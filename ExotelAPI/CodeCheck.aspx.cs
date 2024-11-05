using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class ExotelAPI_CodeCheck : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["callsid"] != null)
        {
            DataTable DtCall = new DataTable();
            SQL_DB.GetDA("SELECT [Digits],[Language] FROM [IVRCodeCheck] where [Callsid]='" + Request.QueryString["callsid"].ToString() + "'").Fill(DtCall);
            if (DtCall.Rows.Count > 0)
            {
                string code1 = DtCall.Rows[0]["Digits"].ToString().Substring(1, 5);
                string code2 = DtCall.Rows[0]["Digits"].ToString().Substring(6, 8);
                string CommentPath = "";
                DataTable DtDetail = new DataTable();
                #region This is actual code for Brand Loyalty Hindi and English Comments File
                SqlParameter ParmCode1 = new SqlParameter("Code1",Convert.ToInt32(code1));
                SqlParameter ParmCode2 = new SqlParameter("Code2",Convert.ToInt64(code2));
                DtDetail = DataProvider.Procedure.GetProcedureData("PROC_GetPlayfileInfo", ParmCode1, ParmCode2);
                #endregion
                SQL_DB.GetDA("SELECT [Code1],[Code2],[comp_name],[prod_name],[MRP],[mfg_date],[exp_date],[Use_Count],[Batch_No],'http://www.vcqru.com/Sound/'+[company_sound_file] as company_sound_file,'http://www.vcqru.com/Sound/'+[product_sound_file] as product_sound_file,'http://www.vcqru.com/Sound/'+[comment_english] as comment_english,'http://www.vcqru.com/Sound/'+[comment_hindi] as comment_hindi FROM [VW_CheckCode] where Code1='" + code1 + "' and Code2='" + code2 + "'").Fill(DtDetail);
                if (DtDetail.Rows.Count > 0)
                {
                    if (DtDetail.Rows[0]["Use_Count"].ToString() == "0")
                    {
                        if (DtCall.Rows[0]["Language"].ToString() == "Hindi")
                            CommentPath = DtDetail.Rows[0]["comment_hindi"].ToString();
                        else
                            CommentPath = DtDetail.Rows[0]["comment_english"].ToString();
                        Response.Write(DtDetail.Rows[0]["product_sound_file"].ToString() + "\n" + DtDetail.Rows[0]["company_sound_file"].ToString() + "\nMRP is Rupees " + DtDetail.Rows[0]["MRP"].ToString() + " Manufacturing Date is " + Convert.ToDateTime(DtDetail.Rows[0]["mfg_date"].ToString()).ToString("dd MMMM yyyy") + " Expiry Date is " + Convert.ToDateTime(DtDetail.Rows[0]["exp_date"].ToString()).ToString("dd MMMM yyyy") + " and Batch Number is " + DtDetail.Rows[0]["Batch_No"].ToString() + "\n" + CommentPath + "");
                    }
                    else if (Convert.ToInt32(DtDetail.Rows[0]["Use_Count"]) > 0)
                    {
                        Response.Write("Status = 2");
                    }

                }
                else
                {
                    Response.Write("Status = 0");
                }
                
            }
        }
        
        
    }
}