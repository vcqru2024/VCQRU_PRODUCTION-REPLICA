using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Business9420;
using System.Data.SqlClient;

public partial class FrmCheck : System.Web.UI.Page
{
    public string Message = "MSG=";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Code1"] != null && Request.QueryString["Code2"] != null)
            CheckCode();
    }

    private void CheckCode()
    {
        string Code1 = Request.QueryString["Code1"].ToString();
        string Code2 = Request.QueryString["Code2"].ToString();
        string Qry = ""; int success = 0;
        Object9420 Reg = new Object9420();
        Reg.Received_Code1 = Code1;
        Reg.Received_Code2 = Code2;
        if (Business9420.function9420.FindCheckedStatus(Reg))
        {
            Message += "Authenticity of the product with Code1- " + Code1 + " and Code2- " + Code2 + "  can not be guaranteed .";
            success = 0;
            SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[Received_Code1],[Received_Code2],[Is_Success]) VALUES('MOBILE APP','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "','" + Code1 + "','" + Code2 + "','" + success + "')");
            return;
        }
        DataSet ds = Business9420.function9420.FindCheckedCode(Reg);
        if (ds.Tables[0].Rows.Count == 0)
        {
            success = 0;
            SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[Received_Code1],[Received_Code2],[Is_Success]) VALUES('MOBILE APP','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "','" + Code1 + "','" + Code2 + "','" + success + "')");
            Message += "Authenticity of the product with Code1- " + Code1 + " and Code2- " + Code2 + " can not be guaranteed.";
           
        }
        else if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
        {
            Qry = "SELECT  Comp_Reg.Comp_Name,  m_code.Pro_ID+'-'+ " +
                " convert(varchar,(case when len(convert(nvarchar,M_Code.Series_Order)) = 1 " +
                " then '0'+ convert(nvarchar,M_Code.Series_Order) else " +
                " convert(nvarchar,M_Code.Series_Order) end))+'-'+" +
                " convert(varchar,(case when len(convert(varchar,M_Code.Series_Serial)) = 1 then '00' " +
                " +convert(varchar,M_Code.Series_Serial)  " +
                " when len(convert(varchar,M_Code.Series_Serial)) = 2 then '0' " +
                " +convert(varchar,M_Code.Series_Serial) " +
                " else convert(varchar,M_Code.Series_Serial) end )) as series, Pro_Reg.Pro_Name,isnull(Pro_Reg.Comments,'') as Comments,m_code.Pro_ID," +
                " T_Pro.MRP,convert(nvarchar,T_Pro.Mfd_Date,103) as Mfd_Date, convert(nvarchar,isnull(T_Pro.Exp_Date,''),103) as Exp_Date," +
                " T_Pro.Batch_No, M_Code.Code1,M_Code.Code2, ISNULL(m_code.use_count,0) as use_count " + //," +
                //" 'http://label9420.com/Sound/' + substring(Pro_Reg.Comp_ID,6,4) + '/' + substring(Pro_Reg.Comp_ID,6,4) + '.wav' as Company_Sound_File," +
                //" 'http://label9420.com/Sound/'+ substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + T_Pro.Pro_ID + '.wav' as Product_Sound_File," +
                //" 'http://label9420.com/Sound/'+ substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + convert(nvarchar,T_Pro.Row_ID) + '/' + convert(nvarchar,T_Pro.Row_ID) + '_E.wav' as comment_english," +
                //" 'http://label9420.com/Sound/'+ substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + convert(nvarchar,T_Pro.Row_ID) + '/' + convert(nvarchar,T_Pro.Row_ID) + '_H.wav' as comment_hindi" +
                " FROM T_Pro INNER JOIN M_Code ON T_Pro.Row_ID = M_Code.Batch_No INNER JOIN" +
                " Pro_Reg ON T_Pro.Pro_ID = Pro_Reg.Pro_ID INNER JOIN Comp_Reg ON Pro_Reg.Comp_ID = Comp_Reg.Comp_ID" +
                " where  M_Code.Code1 = '" + Code1 + "' and M_Code.Code2 = '" + Code2 + "' and ISNULL(m_code.use_count,0) = 0";
            SqlDataReader dr = SQL_DB.ExecuteReader(Qry);
            if (dr.Read())
            {
                if (Convert.ToInt32(dr["use_count"]) == 0)
                {
                    string DefaultComments = "";
                    if (Reg.Comp_type == "L")
                    {
                        DataSet ds1 = SQL_DB.ExecuteDataSet("select * from M_Amc_Offer  WHERE Pro_Id = '" + dr["Pro_ID"].ToString() + "' AND Trans_Type = 'Offer' AND  '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' BETWEEN convert(nvarchar,Date_From,111) AND convert(nvarchar,Date_To,111)");
                        if (ds1.Tables[0].Rows.Count > 0)
                            DefaultComments = ds1.Tables[0].Rows[0]["Comments"].ToString();
                        else
                            DefaultComments = "";
                    }
                    else
                        DefaultComments = dr["Comments"].ToString();
		 if(dr["Exp_Date"].ToString()=="01/01/1900")
		 {
                    Message += "Code1-" + Code1 + " and Code2-" + Code2 + ", Prod-" + dr["Pro_Name"] + ", SN-" + dr["series"] + "" +
                                    ", MRP-" + dr["MRP"] + ", MFG" + dr["Mfd_Date"] + ", EXP, BtNo-" + dr["Batch_No"] + ", PROD IS GENUINE & mfd by " + dr["Comp_Name"] + " " + DefaultComments + " Tnx VCQRU";
		 }
		 else
		 {
		    Message += "Code1-" + Code1 + " and Code2-" + Code2 + ", Prod-" + dr["Pro_Name"] + ", SN-" + dr["series"] + "" +
                                    ", MRP-" + dr["MRP"] + ", MFG" + dr["Mfd_Date"] + ", EXP" + dr["Exp_Date"] + ", BtNo-" + dr["Batch_No"] + ", PROD IS GENUINE & mfd by " + dr["Comp_Name"] + " " + DefaultComments + " Tnx VCQRU";
		 }
                    success = 1;
                }
                else
                {
                    Message += "The authenticity of the product with Code1- " + Code1 + " and Code2-  " + Code2 + "  has already been checked before. If you have purchased fresh product with unscratched label then its authenticity can not be guaranteed.";
                    //Message += "Code 1 , Code 2 already checked!!";
                    success = 0;
                }

                SQL_DB.ExecuteNonQuery("Update M_Code Set use_count=isnull(use_count,0)+1 where Code1='" + Code1 + "' and Code2='" + Code2 + "'");

            }

            else
            {
                Message += "Authenticity of the product with Code1- " + Code1 + " and Code2- " + Code2 + "  can not be guaranteed.";
                success = 0;
            }

            SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[Received_Code1],[Received_Code2],[Is_Success]) VALUES('MOBILE APP','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "','" + Code1 + "','" + Code2 + "','" + success + "')");
        }
        else if (Convert.ToInt32(ds.Tables[0].Rows[0]["Use_Count"]) > 0)
        {
            Message += "The authenticity of the product with Code1- " + Code1 + " and Code2-  " + Code2 + "  has already been checked before. If you have purchased fresh product with unscratched label then its authenticity can not be guaranteed.";
            //Message += "Code 1 , Code 2 already checked!!";
            success = 0;
            SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[Received_Code1],[Received_Code2],[Is_Success]) VALUES('MOBILE APP','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "','" + Code1 + "','" + Code2 + "','" + success + "')");
        }

    }

}
