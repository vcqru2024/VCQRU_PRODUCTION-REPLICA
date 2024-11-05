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


public partial class codeCheckold : System.Web.UI.Page
{
    public string json = "Response", ans = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        /*
        if (Request.QueryString["Code1"] != null && Request.QueryString["Code2"] != null)
            CheckCode();
            */

        try
        {

            #region Code
            string Code1 = "";
            string Code2 = "";
            if (Request.QueryString["Code1"] != null)
                Code1 = Request.QueryString["Code1"];
            if (Request.QueryString["Code2"] != null)
                Code2 = Request.QueryString["Code2"];
            if (Code1 != "" && Code2 != "")
            {
                Object9420 Reg = new Object9420();
                Reg.Received_Code2 = Code2;
                string pp = JsonConvert.SerializeObject(json, Formatting.Indented);
                Message Obj = new Message();
                #region check For Ready Codes
                //if (!Business9420.function9420.CheckeReadyCodes(Reg))
                //{
                //    Obj.Status_Code = "0";
                //    Obj.Status_Message = "Authenticity of the product with Code1- " + Code1 + " and Code2- " + Code2 + "  can not be guaranteed .";
                //    ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
                //    return;
                //}
                #endregion
                CheckCode();
            }
            else
            {
                string pp = JsonConvert.SerializeObject(json, Formatting.Indented);
                Message Obj = new Message();
                if (Request.QueryString["Code1"] != null)
                    Code1 = Request.QueryString["Code1"];
                if (Request.QueryString["Code2"] != null)
                    Code2 = Request.QueryString["Code2"];
                if ((Code1 == "") && (Code2 == ""))
                {
                    Obj.Status_Code = "0";
                    Obj.Status_Message = "Parameters not found.";
                    ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
                    return;
                }
                else if (Code1 != "" && Code2 == "")
                {
                    Obj.Status_Code = "0";
                    Obj.Status_Message = "Parameters Code2 not found.";
                    ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
                    return;
                }
                else if (Code1 == "" && Code2 != "")
                {
                    Obj.Status_Code = "0";
                    Obj.Status_Message = "Parameters Code1 not found.";
                    ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
                    return;
                }
            }
            #endregion
        }
        catch (Exception ex)
        {

        }


    }

    public class QueryResponse
    {
        public string Status_Code;
      
        public string Product_Sound_File;
        public string MRP;
        public string MFG;
        public string EXP;
        public string BatchNo;       
        public string Company_Sound_File;
        public string Build_Loyalty;
        public string Cash_Transfer;
      //  public string Referral_Scheme;
        public string Gift_Coupon;
      //  public string Raffle_Scheme;
      //  public string Run_Survey;
        public string Code1;
        public string Code2;
        public string CompanyName;
        public string ProductName;
        public string Comment_English_File;
        public string Comment_Hindi_File;

    }

    public class Message
    {                
        public string Status_Code;
        public string Status_Message;
    }

    //http://www.vcqru.com/solutionAPI/codeCheck.aspx?Code1=456464&Code2=5465476544    //&callercircle&callerno
    private void CheckCode()
    {
        string Code1 = Request.QueryString["Code1"].ToString();
        string Code2 = Request.QueryString["Code2"].ToString();        
      //  string Qry = ""; int success = 0;             
        
        string pp = JsonConvert.SerializeObject(json, Formatting.Indented);
        DataTable DtDetail = new DataTable();

        #region This is actual code for Brand Loyalty Hindi and English Comments File
        //SqlParameter ParmCode1 = new SqlParameter("Code1",Convert.ToInt32(Code1));
        //SqlParameter ParmCode2 = new SqlParameter("Code2",Convert.ToInt64(Code2));
        //DtDetail = DataProvider.Procedure.GetProcedureData("PROC_GetPlayfileInfo", ParmCode1, ParmCode2);
        #endregion

        //DtDetail = SQL_DB.ExecuteDataTable("SELECT  mcode.Code1, mcode.Code2, creg.Comp_Name AS comp_name, preg.Pro_Name AS prod_name, tpro.MRP, mcode.Use_Count AS attempt_number, tpro.Mfd_Date AS mfg_date, " +
        //" 'http://www.vcqru.com/Data/Sound/'+substring(creg.Comp_ID,6,4)+'/'+substring(creg.Comp_ID,6,4)+'.wav' as company_sound_file,'http://www.vcqru.com/Data/Sound/'+substring(creg.Comp_ID,6,4)+'/'+mcode.Pro_ID+'/'+mcode.Pro_ID+'.wav' as product_sound_file, '' as comment_english, '' as comment_hindi," +
        //" tpro.Exp_Date AS exp_date, mcode.Use_Count, tpro.Batch_No,preg.Pro_ID FROM M_Code" + Code2.ToString().Substring(6,2) + " AS mcode INNER JOIN Pro_Reg AS preg ON mcode.Pro_ID = preg.Pro_ID INNER JOIN Comp_Reg AS creg ON preg.Comp_ID = creg.Comp_ID INNER JOIN " +
        //"T_Pro AS tpro ON mcode.Batch_No = tpro.Row_ID WHERE  mcode.Code1 = '"+ Code1 +"'  AND mcode.Code2 = '"+ Code2 +"'");

        DtDetail = SQL_DB.ExecuteDataTable("SELECT  mcode.Code1, mcode.Code2, creg.Comp_Name AS comp_name, preg.Pro_Name AS prod_name, tpro.MRP, mcode.Use_Count AS attempt_number, tpro.Mfd_Date AS mfg_date, " +
       " 'http://www.vcqru.com/Data/Sound/'+substring(creg.Comp_ID,6,4)+'/'+substring(creg.Comp_ID,6,4)+'.wav' as company_sound_file,'http://www.vcqru.com/Data/Sound/'+substring(creg.Comp_ID,6,4)+'/'+mcode.Pro_ID+'/'+mcode.Pro_ID+'.wav' as product_sound_file, '' as comment_english, '' as comment_hindi," +
       " tpro.Exp_Date AS exp_date, isnull(mcode.Use_Count,0) as Use_Count, tpro.Batch_No,preg.Pro_ID FROM M_Code AS mcode INNER JOIN Pro_Reg AS preg ON mcode.Pro_ID = preg.Pro_ID INNER JOIN Comp_Reg AS creg ON preg.Comp_ID = creg.Comp_ID INNER JOIN " +
       "T_Pro AS tpro ON mcode.Batch_No = tpro.Row_ID WHERE  mcode.Code1 = " + Code1 + "  AND mcode.Code2 = " + Code2);
    



        //SQL_DB.GetDA("SELECT [Code1],[Code2],[comp_name],[prod_name],[MRP],[mfg_date],[exp_date],[Use_Count],[Batch_No],'http://www.vcqru.com/Sound/'+[company_sound_file] as company_sound_file,'http://www.vcqru.com/Sound/'+[product_sound_file] as product_sound_file,'http://www.vcqru.com/Sound/'+[comment_english] as comment_english,'http://www.vcqru.com/Sound/'+[comment_hindi] as comment_hindi FROM [VW_CheckCode] where Code1='" + Code1 + "' and Code2='"+Code2+"'").Fill(DtDetail);       
        if (DtDetail.Rows.Count<=0)
        {
            Message Obj = new Message();
            Obj.Status_Code = "0";    
            Obj.Status_Message = "Authenticity of the product with Code1- " + Code1 + " and Code2- " + Code2 + "  can not be guaranteed .";                    
            ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
            return;
        }
        else if (DtDetail.Rows.Count > 0)
        {
            if (DtDetail.Rows[0]["Use_Count"].ToString() == "0")
            {
                QueryResponse Obj = new QueryResponse();
                Obj.Status_Code = "1";
                ////Obj.Message += "Code1-" + Code1 + " and Code2-" + Code2 + ", Company-" + DtDetail.Rows[0]["comp_name"].ToString() + ", Product-" + DtDetail.Rows[0]["prod_name"].ToString() + ", MRP-" + DtDetail.Rows[0]["MRP"].ToString() + ", MFG-" + DtDetail.Rows[0]["mfg_date"].ToString() + ", EXP-" + DtDetail.Rows[0]["exp_date"] + ", BtNo-" + DtDetail.Rows[0]["Batch_No"].ToString() + ", Attempt-" + DtDetail.Rows[0]["Use_Count"].ToString() + ", Company Sound File- " + DtDetail.Rows[0]["company_sound_file"].ToString() + ", Product Sound File-" + DtDetail.Rows[0]["product_sound_file"].ToString() + ", Comment English File-" + DtDetail.Rows[0]["comment_english"].ToString() + ", Comment Hindi File-" + DtDetail.Rows[0]["comment_hindi"].ToString() + "";
                //Obj.Code1 = Code1;
                //Obj.Code2 = Code2;
                //Obj.CompanyName = DtDetail.Rows[0]["comp_name"].ToString();
                //Obj.ProductName = DtDetail.Rows[0]["prod_name"].ToString();
                //Obj.MRP = DtDetail.Rows[0]["MRP"].ToString();
                //Obj.MFG = DtDetail.Rows[0]["mfg_date"].ToString();
                //Obj.EXP = DtDetail.Rows[0]["exp_date"].ToString();
                //Obj.BatchNo = DtDetail.Rows[0]["Batch_No"].ToString();
                ////Obj.AttemptNo = DtDetail.Rows[0]["Use_Count"].ToString();
                //Obj.Company_Sound_File = DtDetail.Rows[0]["company_sound_file"].ToString();
                //Obj.Product_Sound_File = DtDetail.Rows[0]["product_sound_file"].ToString();
                //Obj.Comment_English_File = DtDetail.Rows[0]["comment_english"].ToString();
                //Obj.Comment_Hindi_File = DtDetail.Rows[0]["comment_hindi"].ToString();
                //Obj.Build_Loyalty = "0";
                //Obj.Cash_Transfer = "0";
                //Obj.Referral_Scheme = "0";
                //Obj.Gift_Coupon = "0";
                //Obj.Raffle_Scheme = "0";
                //Obj.Run_Survey = "0";


                Obj.Product_Sound_File = DtDetail.Rows[0]["product_sound_file"].ToString();
                Obj.MRP = DtDetail.Rows[0]["MRP"].ToString();
                Obj.MFG = DtDetail.Rows[0]["mfg_date"].ToString();
                Obj.EXP = DtDetail.Rows[0]["exp_date"].ToString();
                Obj.BatchNo = DtDetail.Rows[0]["Batch_No"].ToString();
                Obj.Company_Sound_File = DtDetail.Rows[0]["company_sound_file"].ToString();              
                Obj.Build_Loyalty = "0";
                Obj.Cash_Transfer = "0";               
                Obj.Gift_Coupon = "0";

                Obj.Code1 = Code1;
                Obj.Code2 = Code2;
                Obj.CompanyName = DtDetail.Rows[0]["comp_name"].ToString();
                Obj.ProductName = DtDetail.Rows[0]["prod_name"].ToString();
                Obj.Comment_English_File = DtDetail.Rows[0]["comment_english"].ToString();
                Obj.Comment_Hindi_File = DtDetail.Rows[0]["comment_hindi"].ToString();
                // Obj.Raffle_Scheme = "0";
                // Obj.Run_Survey = "0";
                ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
            }
            else
            {
                Message Obj = new Message();
                Obj.Status_Code = "2";
                Obj.Status_Message = "The authenticity of the product with Code1- " + Code1 + " and Code2-  " + Code2 + "  has already been checked before. If you have purchased fresh product with unscratched label then its authenticity can be guaranteed.";
                ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
            }

        }
        

    }
}