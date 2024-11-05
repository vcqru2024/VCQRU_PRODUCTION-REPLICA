using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Data;
using Business9420;
using System.Data.SqlClient;


public partial class FrmJsonCheck : System.Web.UI.Page
{
    public string json = "Responce", ans = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Code1"] != null && Request.QueryString["Code2"] != null)
            CheckCode();
    }

    public class Group
    {
        public string Status;
        public string Message;
        
    }

    private void CheckCode()
    {
        string Code1 = Request.QueryString["Code1"].ToString();
        string Code2 = Request.QueryString["Code2"].ToString();        
        string Qry = ""; int success = 0;
        Object9420 Reg = new Object9420();
        Reg.Received_Code1 = Code1;
        Reg.Received_Code2 = Code2;       
        Group Obj = new Group();
        string pp = JsonConvert.SerializeObject(json, Formatting.Indented);
        Obj.Status = "0";
        if (Business9420.function9420.FindCheckedStatus(Reg))
        {
            Obj.Message += "Authenticity of the product with Code1- " + Code1 + " and Code2- " + Code2 + "  can not be guaranteed .";
            Obj.Status = "0";
            SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[Received_Code1],[Received_Code2],[Is_Success]) VALUES('MOBILE APP','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "','" + Code1 + "','" + Code2 + "','" + success + "')");
            ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
            return;
        }
        DataSet ds = Business9420.function9420.FindCheckedCode(Reg);
        if (ds.Tables[0].Rows.Count == 0)
        {
            Obj.Status = "0";
            SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[Received_Code1],[Received_Code2],[Is_Success]) VALUES('MOBILE APP','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "','" + Code1 + "','" + Code2 + "','" + success + "')");
            Obj.Message += "Authenticity of the product with Code1- " + Code1 + " and Code2- " + Code2 + " can not be guaranteed.";
            ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";

        }
        else if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
        {
            DataTable DtDetail = new DataTable();
            #region This is actual code for Brand Loyalty Hindi and English Comments File
            SqlParameter ParmCode1 = new SqlParameter("Code1", Convert.ToInt32(Code1));
            SqlParameter ParmCode2 = new SqlParameter("Code2", Convert.ToInt64(Code2));
            DtDetail = DataProvider.Procedure.GetProcedureData("PROC_GetPlayfileInfo", ParmCode1, ParmCode2);
            #endregion
            #region Commented Code
            //Qry = " SELECT DISTINCT Comp_Reg.Comp_Name as comp_name,Pro_Reg.Pro_Name as prod_name,T_Pro.MRP,isnull(m_code.use_count,0) as attempt_number,convert(nvarchar,T_Pro.Mfd_Date,103) as mfg_date,"+
            //      " convert(nvarchar,T_Pro.Exp_Date,103) as exp_date,T_Pro.Batch_No,CASE -- CASE 1 WHEN Comp_Reg.Delete_Flag = 0  THEN  'Fake.wav' ELSE CASE -- CASE 2 WHEN Comp_Reg.status = 0 THEN 'Abord.wav'"+
            //      " ELSE CASE  -- CASE 3 WHEN ISNULL((SELECT [Status] FROM M_Amc_Offer WHERE Amc_Offer_ID =(SELECT MAX(Amc_Offer_ID) FROM M_Amc_Offer WHERE  (Pro_ID = M_Code.Pro_ID) AND (IsCancel = 1) and Trans_Type='AMC' AND (CONVERT(VARCHAR,GETDATE(),111) BETWEEN CONVERT(VARCHAR, Date_From, 111) AND CONVERT(VARCHAR, Date_To, 111)))),0)  = 0"+
            //      " THEN 'Abord.wav' ELSE substring(Pro_Reg.Comp_ID,6,4) + '/' + substring(Pro_Reg.Comp_ID,6,4) + '.wav' END   -- CASE 3 END  -- CASE 2 END -- CASE 1 as company_sound_file,CASE -- CASE 1 WHEN Comp_Reg.Delete_Flag = 0  THEN  'Blank.wav' ELSE CASE -- CASE 2 WHEN Comp_Reg.status = 0 THEN 'Blank.wav' ELSE  CASE  -- CASE 3"+
            //      " WHEN ISNULL((SELECT [Status] FROM M_Amc_Offer WHERE Amc_Offer_ID =(SELECT MAX(Amc_Offer_ID) FROM M_Amc_Offer WHERE  (Pro_ID = M_Code.Pro_ID) AND (IsCancel = 1) and Trans_Type='AMC' AND (CONVERT(VARCHAR,GETDATE(),111) BETWEEN CONVERT(VARCHAR, Date_From, 111) AND CONVERT(VARCHAR, Date_To, 111)))),0)  = 0 THEN 'Blank.wav'"+
            //      " ELSE substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + T_Pro.Pro_ID + '.wav' END   -- CASE 3 END  -- CASE 2 END -- CASE 1 as product_sound_file, CASE -- CASE 1 WHEN Comp_Reg.Delete_Flag = 0  THEN  'Blank.wav' ELSE CASE -- CASE 2 WHEN Comp_Reg.status = 0 THEN 'Blank.wav' ELSE CASE  -- CASE 3 WHEN ISNULL((SELECT [Status] FROM M_Amc_Offer WHERE Amc_Offer_ID =(SELECT MAX(Amc_Offer_ID) FROM M_Amc_Offer WHERE  (Pro_ID = M_Code.Pro_ID) AND (IsCancel = 1) and Trans_Type='AMC' AND (CONVERT(VARCHAR,GETDATE(),111) BETWEEN CONVERT(VARCHAR, Date_From, 111) AND CONVERT(VARCHAR, Date_To, 111)))),0)  = 0"+
            //      " THEN 'Blank.wav' ELSE CASE -- CASE 4 WHEN ISNULL((SELECT [Status] FROM M_Amc_Offer WHERE  (Pro_ID = M_Code.Pro_ID) AND (IsCancel = 1) and Trans_Type='Offer' AND (CONVERT(VARCHAR,GETDATE(),111) BETWEEN CONVERT(VARCHAR, Date_From, 111) AND CONVERT(VARCHAR, Date_To, 111))),0) = 0 THEN 'Blank.wav'"+
            //      " ELSE substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + convert(nvarchar,ISNULL((SELECT Amc_Offer_ID FROM M_Amc_Offer WHERE  (Pro_ID = M_Code.Pro_ID) AND (Status = 1) AND (IsCancel = 1) and Trans_Type='Offer' AND (CONVERT(VARCHAR,GETDATE(),111) BETWEEN CONVERT(VARCHAR, Date_From, 111) AND CONVERT(VARCHAR, Date_To, 111))),'')) + '/' + convert(nvarchar,ISNULL((SELECT Amc_Offer_ID FROM M_Amc_Offer WHERE  (Pro_ID = M_Code.Pro_ID) AND (Status = 1) AND (IsCancel = 1) and Trans_Type='Offer' AND (CONVERT(VARCHAR,GETDATE(),111) BETWEEN CONVERT(VARCHAR, Date_From, 111) AND CONVERT(VARCHAR, Date_To, 111))),'')) + '_E.wav'"+
            //      " END  -- CASE 4  END   -- CASE 3 END  -- CASE 2 END -- CASE 1 as comment_english, CASE -- CASE 1 WHEN Comp_Reg.Delete_Flag = 0  THEN  'Blank.wav' ELSE CASE -- CASE 2 WHEN Comp_Reg.status = 0 THEN 'Blank.wav' ELSE CASE  -- CASE 3 WHEN ISNULL((SELECT [Status] FROM M_Amc_Offer WHERE Amc_Offer_ID =(SELECT MAX(Amc_Offer_ID) FROM M_Amc_Offer WHERE  (Pro_ID = M_Code.Pro_ID) AND (IsCancel = 1) and Trans_Type='AMC' AND (CONVERT(VARCHAR,GETDATE(),111) BETWEEN CONVERT(VARCHAR, Date_From, 111) AND CONVERT(VARCHAR, Date_To, 111)))),0)  = 0 THEN 'Blank.wav' ELSE CASE -- CASE 4 WHEN ISNULL((SELECT [Status] FROM M_Amc_Offer WHERE  (Pro_ID = M_Code.Pro_ID) AND (IsCancel = 1) and Trans_Type='Offer' AND (CONVERT(VARCHAR,GETDATE(),111) BETWEEN CONVERT(VARCHAR, Date_From, 111) AND CONVERT(VARCHAR, Date_To, 111))),0) = 0 "+
            //      " THEN 'Blank.wav' ELSE substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + convert(nvarchar,ISNULL((SELECT Amc_Offer_ID FROM M_Amc_Offer WHERE  (Pro_ID = M_Code.Pro_ID) AND (Status = 1) AND (IsCancel = 1) and Trans_Type='Offer' AND (CONVERT(VARCHAR,GETDATE(),111) BETWEEN CONVERT(VARCHAR, Date_From, 111) AND CONVERT(VARCHAR, Date_To, 111))),'')) + '/' + convert(nvarchar,ISNULL((SELECT Amc_Offer_ID FROM M_Amc_Offer WHERE  (Pro_ID = M_Code.Pro_ID) AND (Status = 1) AND (IsCancel = 1) and Trans_Type='Offer' AND (CONVERT(VARCHAR,GETDATE(),111) BETWEEN CONVERT(VARCHAR, Date_From, 111) AND CONVERT(VARCHAR, Date_To, 111))),'')) + '_H.wav' END  -- CASE 4 END   -- CASE 3 END  -- CASE 2 END -- CASE 1 as comment_hindi FROM T_Pro INNER JOIN M_Code ON T_Pro.Row_ID = M_Code.Batch_No INNER JOIN "+
            //      " Pro_Reg ON T_Pro.Pro_ID = Pro_Reg.Pro_ID INNER JOIN Comp_Reg ON Pro_Reg.Comp_ID = Comp_Reg.Comp_ID INNER JOIN M_Amc_Offer ON Pro_Reg.Comp_ID = Comp_Reg.Comp_ID where  M_Code.Code1 = '"+Code1+"' and M_Code.Code2 = '"+Code2+"' and isnull(m_code.ScrapeFlag,0) = 0 AND (m_code.ReceiveFlag = 1)";
            //SqlDataReader dr = SQL_DB.ExecuteReader(Qry);
            #endregion
            DataTable table = new DataTable();
            //Fill table with data 
            //table = YourGetDataMethod(); 
            DataTableReader dr = DtDetail.CreateDataReader();
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
                    Obj.Message += "Code1-" + Code1 + " and Code2-" + Code2 + ", Prod-" + dr["Pro_Name"] + ", SN-" + dr["series"] + "" +
                                    ", MRP-" + dr["MRP"] + ", MFG" + dr["Mfd_Date"] + ", EXP" + dr["Exp_Date"] + ", BtNo-" + dr["Batch_No"] + ", PROD IS GENUINE & mfd by " + dr["Comp_Name"] + " " + DefaultComments + " Tnx VCQRU";
                    Obj.Status = "1";
                    ans = ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
                }
                else
                {
                    Obj.Message += "The authenticity of the product with Code1- " + Code1 + " and Code2-  " + Code2 + "  has already been checked before. If you have purchased fresh product with unscratched label then its authenticity can not be guaranteed.";
                    //Message += "Code 1 , Code 2 already checked!!";
                    Obj.Status = "0";
                    ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
                }

                SQL_DB.ExecuteNonQuery("Update M_Code Set use_count=isnull(use_count,0)+1 where Code1='" + Code1 + "' and Code2='" + Code2 + "'");

            }

            else
            {
                Obj.Message += "Authenticity of the product with Code1- " + Code1 + " and Code2- " + Code2 + "  can not be guaranteed.";
                Obj.Status = "0";
                ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
            }

            SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[Received_Code1],[Received_Code2],[Is_Success]) VALUES('MOBILE APP','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "','" + Code1 + "','" + Code2 + "','" + success + "')");
        }
        else if (Convert.ToInt32(ds.Tables[0].Rows[0]["Use_Count"]) > 0)
        {
            Obj.Message += "The authenticity of the product with Code1- " + Code1 + " and Code2-  " + Code2 + "  has already been checked before. If you have purchased fresh product with unscratched label then its authenticity can not be guaranteed.";
            //Message += "Code 1 , Code 2 already checked!!";
            Obj.Status = "0";
            SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[Received_Code1],[Received_Code2],[Is_Success]) VALUES('MOBILE APP','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "','" + Code1 + "','" + Code2 + "','" + success + "')");
            ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
        }

    }
}