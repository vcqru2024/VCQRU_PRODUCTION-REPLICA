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
using Business_Logic_Layer;

public partial class codeCheck : System.Web.UI.Page
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
            string callercircle = "";
            string callerno = "";
            string network = "";
            string time = string.Empty;
            string vdate = string.Empty;
            if (Request.QueryString["Code1"] != null)
                Code1 = Request.QueryString["Code1"];
            if (Request.QueryString["Code2"] != null)
                Code2 = Request.QueryString["Code2"];
            if (Request.QueryString["callercircle"] != null)
                callercircle = Request.QueryString["callercircle"];
            if (Request.QueryString["callerno"] != null)
                callerno = Request.QueryString["callerno"];
            if (Request.QueryString["network"] != null)
                network = Request.QueryString["network"];
            if (Request.QueryString["time"] != null)
            {
                time = Request.QueryString["time"].ToString();
            }
            if (Request.QueryString["date"] != null)
            {
                vdate = Request.QueryString["date"].ToString();
            }
            if (Code1 != "" && Code2 != "")
            {
                Object9420 Reg = new Object9420();
                Reg.Received_Code2 = Code2;
                string pp = JsonConvert.SerializeObject(json, Formatting.Indented);
                Message Obj = new Message();
               
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
            throw ex;
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

    //http://www.vcqru.com/solutionAPI/codeCheck.aspx?Code1=456464&Code2=5465476544&callercircle&callerno
    private void CheckCode()
    {
        string Code1 = Request.QueryString["Code1"].ToString();
        string Code2 = Request.QueryString["Code2"].ToString();
        string callercircle = Request.QueryString["callercircle"].ToString();
        string callerno = Request.QueryString["callerno"].ToString();
        //  string Qry = ""; int success = 0;             

        string pp = JsonConvert.SerializeObject(json, Formatting.Indented);
        DataTable DtDetail = new DataTable();
        callerno = "91" + callerno.Substring(callerno.Length - 10);
        #region Checking for M_Consumer
        string ConsumerId = "";

        //try
        //{
        //    if (callerno.Length == 12)
        //    {
        //        int initial = Convert.ToInt32(callerno.Substring(0, 2));
        //        if (initial == 91)
        //            callerno = callerno.Substring(2, callerno.Length - 2);
        //    }
        //    if (callerno.Length == 10)
        //        callerno = "91" + callerno;

        //}
        //catch (Exception ex)
        //{

        //    throw ex;
        //}
        
        DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email] FROM [M_Consumer] where [MobileNo] = '" + callerno + "'");
        SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('IVR-caller-" + callerno + "')");
        if (dcs.Tables[0].Rows.Count > 0)
        {
            // below line is commented by shweta
            //if (dcs.Tables[0].Rows[0]["Email"].ToString() != mobile.Trim().Replace("'", "''"))
            //{
            //    //if (mobile.Trim().Replace("'", "''") != "")
            //    //    SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [Email] = '" + mobile.Trim().Replace("'", "''") + "' WHERE [User_ID] = '" + dcs.Tables[0].Rows[0]["User_ID"].ToString() + "' ");
            //}
            //else
            ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
        }
        if (ConsumerId == "")
        {
            #region Registration
            Random rnd = new Random();
            User_Details Log = new User_Details();
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            Log.ConsumerName = null;
            // Log.Email = "";// email.Trim().Replace("'", "''"); // this is comment is done by shweta
            Log.Email = "";
            Log.MobileNo = callerno;
            Log.City = null;
            Log.PinCode = null;
            Log.Password = rnd.Next(10000, 99999).ToString();
            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.code1 = Code1.Trim().Replace("'", "''");
            Log.code2 = Code2.Trim().Replace("'", "''");
            Log.DML = "I";
            User_Details.InsertUpdateUserDetails(Log);
            // note Send SMS is working from Codeupdate.aspx
            string strReferralCode = Convert.ToString(SQL_DB.ExecuteScalar("Select dbo.GetZeroConcactWithReferralCode(referralcode)  FROM [M_Consumer] where [MobileNo] = '" + callerno + "'"));
            //ServiceLogic.SendSms("You are registered with VCQRU.COM. YOUR USER ID IS " + callerno + " AND PASSWORD IS " + Log.Password + " AND Refferal Code is " + strReferralCode + ".", "+" + callerno);

            string msgString;
            if (!string.IsNullOrEmpty(HttpContext.Current.Session["MMUser"].ToString()))
            {
                msgString = "You are registered with VCQRU.COM. Your USER ID is " + callerno + " and PASSWORD is " + Log.Password + " Visit www.vcqru.com for more info OR for any query contact customer care 0124-4001928. Thanks VCQRU";
            }
            else
            {
                msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + callerno + " AND PASSWORD IS " + Log.Password + " AND Refferal Code is " + strReferralCode + ".";
            }
            ServiceLogic.SendSms(msgString, callerno);
            #endregion
            ConsumerId = Log.User_ID;
            SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('IVR-caller-Registration" + callerno + "')");
        }
       // SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('IVR-caller-IN-strReferralCode')");
        ////                SendSms("Congs! Gained Referral code-" + strReferralCode + "", ProjectSession.strMobileNo);
        #endregion

       

        Object9420 Reg = new Object9420();
        Reg.Received_Code1 = (Code1.Trim().Replace("'", "''"));
        Reg.Received_Code2 = (Code2.Trim().Replace("'", "''"));
        Reg.Dial_Mode = "IVR";
        Reg.Mode_Detail = "";// GetIP();
        Reg.Mobile_No = callerno;
        Reg.Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff"));
      
        //if (Request.QueryString["call_date"] != null)
        //{
        //    Reg.callerdate = Convert.ToDateTime(Request.QueryString["call_date"].ToString());
        //   // vdate = Request.QueryString["call_date"].ToString();
        //    SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('IVR-call_date-" + Reg.callerdate + "')");
        //}
        Reg.callerdate = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff"));
        //if (Request.QueryString["call_time"] != null)
        //{
        //    Reg.callertime = Request.QueryString["call_time"].ToString();
        //   // time = Request.QueryString["call_time"].ToString();
        //    SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('IVR-caller_time-" + Reg.callertime + "')");
        //}
        Reg.callertime = DataProvider.LocalDateTime.Now.ToString("HH:mm:ss.fff");
      //  DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
        if (Business9420.function9420.FindCheckedStatus(Reg)) // it looks company status check i.e verify company by admin
        {
           // SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('Lno-211')");
            #region  
            Reg.Is_Success = 0;
            //Business9420.function9420.InsertCodeChecked(Reg);            
            //result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
            Message Obj = new Message();
            Obj.Status_Code = "0";
            Obj.Status_Message = "Authenticity of the product with Code1- " + Code1 + " and Code2- " + Code2 + "  can not be guaranteed .";
            ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
            return;
            #endregion
            
        }
      
        //   string DefaultComments = ""; string CompName = string.Empty;
        // DataSet ds = Business9420.function9420.FindCheckedCode(Reg);
        DataSet ds = ServiceLogic.FindCheckedCode_2(Reg);
        if (ds.Tables[0].Rows.Count == 0)
        {
          //  SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('Lno-229')");
           // Reg.Is_Success = 0;
            //Business9420.function9420.InsertCodeChecked(Reg);
            //result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
            Message Obj = new Message();
            Obj.Status_Code = "0";
            Obj.Status_Message = "Authenticity of the product with Code1- " + Code1 + " and Code2- " + Code2 + "  can not be guaranteed .";
            ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
            return;
        }
        else if (ds.Tables[0].Rows[0]["Use_Count"].ToString() == "1")
        {
            //  SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('Lno-242')");
            Message Obj1 = new Message();
            Obj1.Status_Code = "2";
            Obj1.Status_Message = "The authenticity of the product with Code1- " + Code1 + " and Code2-  " + Code2 + "  has already been checked before. If you have purchased fresh product with unscratched label then its authenticity can be guaranteed.";
            DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Data/Sound/");
            if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "ROYAL MANUFACTURER")
            {
                DtDetail = dsres.Tables[0];
                DataTable jpcdt1 = new DataTable();
                jpcdt1 = SQL_DB.ExecuteDataTable("select count(1) TotalCount from Pro_Enq where Received_Code1='" + Code1 + "' and Received_Code2='" + Code2 + "'");

                if (Convert.ToInt32(jpcdt1.Rows[0]["TotalCount"].ToString()) <= 2)
                {
                    QueryResponse Obj = new QueryResponse();
                    try
                    {


                        Obj.Status_Code = "1";
                        Obj.Product_Sound_File = DtDetail.Rows[0]["Product_Sound_File"].ToString();
                        Obj.MRP = DtDetail.Rows[0]["MRP"].ToString();
                        Obj.MFG = DtDetail.Rows[0]["mfg_date"].ToString().Substring(0, 10);
                        if (!string.IsNullOrEmpty(DtDetail.Rows[0]["exp_date1"].ToString()))
                        {
                            Obj.EXP = DtDetail.Rows[0]["exp_date1"].ToString().ToString().Substring(0, 10);
                        }
                        else
                        {
                            Obj.EXP = "";
                        }

                        Obj.BatchNo = DtDetail.Rows[0]["Batch_No"].ToString();
                        Obj.Company_Sound_File = DtDetail.Rows[0]["Company_Sound_File"].ToString();

                        Obj.Code1 = Code1;
                        Obj.Code2 = Code2;
                        Obj.CompanyName = DtDetail.Rows[0]["Comp_Name"].ToString();
                        Obj.ProductName = DtDetail.Rows[0]["Pro_Name"].ToString();
                        Obj.Comment_English_File = DtDetail.Rows[0]["comment_english"].ToString();
                        Obj.Comment_Hindi_File = DtDetail.Rows[0]["comment_hindi"].ToString();
                        ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
                    }
                    catch (Exception ex)
                    {

                        throw ex;
                    }
                }
            }
            else
            {
                ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj1, Formatting.Indented) + "}";
            }





            return;
            //  result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, true, ReferralCodeFromUser, Reg.Dial_Mode);
        }
        else if (ds.Tables[0].Rows.Count > 0)
        {
            //SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('Lno-252')");
            string str_Build_Loyalty = "0";
            string str_CashTransfer = "0";
            string str_GiftCoupon = "0";
            DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Data/Sound/");
            if (dsres.Tables.Count > 0)
            {
                if (dsres.Tables[0].Rows.Count > 0)
                {
                   // SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('Lno-261')");
                    if (ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
                    {
                        // string  result =  ServiceLogic.ServiceRequestCheck(dsres, Reg, callerno, false, "", "IVR");
                        //DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(dsres.Tables[0].Rows[0]["Pro_ID"].ToString());
                        DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(Reg.Received_Code1,Reg.Received_Code2);
                        DataTable dtServiceAssign = new DataTable();
                        DataTable dtTotalCodesCount = new DataTable();
                        if (dsServicesAssign.Tables.Count <= 2)
                        {
                            dtServiceAssign = dsServicesAssign.Tables[0];
                            dtTotalCodesCount = dsServicesAssign.Tables[1];
                        }
                        if (dtServiceAssign.Rows.Count > 0)
                        {
                            Reg.M_code_Row_ID = Convert.ToInt64(dsres.Tables[0].Rows[0]["Row_ID"].ToString());
                            Reg.Comp_ID = dtServiceAssign.Rows[0]["Comp_ID"].ToString();
                            Reg.Pro_ID = dtServiceAssign.Rows[0]["Pro_ID"].ToString();


                            long intM_Consumer_MCOde = Business9420.function9420.InsertCodeChecked(Reg); // change this SP, Pass m_code.Row_Id, Pro_id, M_consumerid
                            SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('" + Reg.callerdate + "-" + Reg.callertime + "')");
                            DataRow[] dr = dtServiceAssign.Select("Service_id = 'SRV1001'");
                            if (dr.Length > 0)
                            {
                                try
                                {
                                    DataTable dtBuild_Loyalty = ServiceLogic.Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2,
                                        Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
                                    if (dtBuild_Loyalty.Rows.Count > 0)
                                    {
                                        string strEarnedPoints = dtBuild_Loyalty.Rows[0]["Points"].ToString();
                                        string IsCashConvert = dtBuild_Loyalty.Rows[0]["IsCashConvert"].ToString();
                                        //string AwardNameBL = dtBuild_Loyalty.Rows[0]["AwardNameBL"].ToString();
                                        if (dtBuild_Loyalty.Rows[0]["ReachedFrequency"].ToString() == "0")
                                        {
                                            str_Build_Loyalty = strEarnedPoints;
                                        }
                                    }
                                }
                                catch (Exception)
                                {


                                }
                            }
                            DataRow[] dr2 = dtServiceAssign.Select("Service_id = 'SRV1005'");
                            if (dr2.Length > 0)
                            {
                                try
                                {
                                    DataTable dt_CashTransfer = ServiceLogic.Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2,
                                        Convert.ToInt32(dr2[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
                                    if (dt_CashTransfer.Rows.Count > 0)
                                    {
                                        string strEarnedPoints = dt_CashTransfer.Rows[0]["Points"].ToString();
                                        string Iscash = dt_CashTransfer.Rows[0]["Iscash"].ToString();
                                        if (dt_CashTransfer.Rows[0]["ReachedFrequency"].ToString() == "0")
                                        {
                                            str_CashTransfer = Iscash;
                                        }
                                    }
                                }
                                catch (Exception)
                                {

                                    
                                }
                            }
                            DataRow[] dr3 = dtServiceAssign.Select("Service_id = 'SRV1003'");
                            if (dr3.Length > 0)
                            {
                                try
                                {
                                    string strGiftCoupon = ServiceLogic.GetGiftCouponService(dr3[0],
                                        Convert.ToInt32(dtTotalCodesCount.Rows[0][0].ToString()), Reg.Received_Code1, Reg.Received_Code2, Reg.Comp_ID, false, "SRV1003", Reg);
                                    if (strGiftCoupon.ToLower().Contains("won"))
                                    {
                                        str_GiftCoupon = "1";
                                    }
                                }
                                catch (Exception)
                                {

                                    
                                }
                            }
                        }
                       
                        DtDetail = dsres.Tables[0];
                        SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('IVR-caller-IN-" + DtDetail.Rows.Count + "')");
                        QueryResponse Obj = new QueryResponse();
                        try
                        {


                            Obj.Status_Code = "1";
                            Obj.Product_Sound_File = DtDetail.Rows[0]["Product_Sound_File"].ToString();
                            Obj.MRP = DtDetail.Rows[0]["MRP"].ToString();
                            Obj.MFG = DtDetail.Rows[0]["mfg_date"].ToString().Substring(0, 10);
                            if (!string.IsNullOrEmpty(DtDetail.Rows[0]["exp_date1"].ToString()))
                            {
                                Obj.EXP = DtDetail.Rows[0]["exp_date1"].ToString().ToString().Substring(0, 10);
                            }
                            else
                            {
                                Obj.EXP = "";
                            }
                            
                            Obj.BatchNo = DtDetail.Rows[0]["Batch_No"].ToString();
                            Obj.Company_Sound_File = DtDetail.Rows[0]["Company_Sound_File"].ToString();
                            Obj.Build_Loyalty = str_Build_Loyalty;
                            Obj.Cash_Transfer = str_CashTransfer;
                            Obj.Gift_Coupon = str_GiftCoupon;
                            Obj.Code1 = Code1;
                            Obj.Code2 = Code2;
                            Obj.CompanyName = DtDetail.Rows[0]["Comp_Name"].ToString();
                            Obj.ProductName = DtDetail.Rows[0]["Pro_Name"].ToString();
                            Obj.Comment_English_File = DtDetail.Rows[0]["comment_english"].ToString();
                            Obj.Comment_Hindi_File = DtDetail.Rows[0]["comment_hindi"].ToString();
                        }
                        catch (Exception ex)
                        {

                            throw ex;
                        }
                        // Obj.Raffle_Scheme = "0";
                        // Obj.Run_Survey = "0";
                        ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
                    }
                    else if (ds.Tables[0].Rows[0]["Use_Count"].ToString() != "0")
                    {

                        Message Obj = new Message();
                        Obj.Status_Code = "2";
                        Obj.Status_Message = "The authenticity of the product with Code1- " + Code1 + " and Code2-  " + Code2 + "  has already been checked before. If you have purchased fresh product with unscratched label then its authenticity can be guaranteed.";
                        ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
                        return;
                        //  result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, true, ReferralCodeFromUser, Reg.Dial_Mode);
                    }

                }
                else
                {
                    Message Obj = new Message();
                    Obj.Status_Code = "0";
                    Obj.Status_Message = "Authenticity of the product with Code1- " + Code1 + " and Code2- " + Code2 + "  can not be guaranteed .";
                    ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
                    return;
                    //result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode' and MsgType=2");
                }
               
            }
            else
            {
                Message Obj = new Message();
                Obj.Status_Code = "0";
                Obj.Status_Message = "Authenticity of the product with Code1- " + Code1 + " and Code2- " + Code2 + "  can not be guaranteed .";
                ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
                return;
                //result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
            }
        }
    }

    #region This is actual code for Brand Loyalty Hindi and English Comments File
    //SqlParameter ParmCode1 = new SqlParameter("Code1",Convert.ToInt32(Code1));
    //SqlParameter ParmCode2 = new SqlParameter("Code2",Convert.ToInt64(Code2));
    //DtDetail = DataProvider.Procedure.GetProcedureData("PROC_GetPlayfileInfo", ParmCode1, ParmCode2);
    #endregion


    //        {
    //            "Response":{
    //                "Status_Code": "1", 
    //"Product_Sound_File": "http://www.vcqru.com/Data/Sound/1075/AB48/AB48.wav", 
    //"MRP": "500.00", 
    //"MFG": "14/06/2018 00:00:00", 
    //"EXP": "29/09/2018 00:00:00", 
    //"BatchNo": "525", 
    //"Company_Sound_File": "http://www.vcqru.com/Data/Sound/1075/1075.wav", 
    //"Build_Loyalty": "0", 
    //"Cash_Transfer": "0", 
    //"Gift_Coupon": "0", 
    //"Code1": "72347", 
    //"Code2": "22370022", 
    //"CompanyName": "Patanjali Pvt Ltd", 
    //"ProductName": "Patanjali Soap", 
    //"Comment_English_File": "", 
    //"Comment_Hindi_File": ""
    //   }
    //        }


    //DtDetail = SQL_DB.ExecuteDataTable("SELECT  mcode.Code1, mcode.Code2, creg.Comp_Name AS comp_name, preg.Pro_Name AS prod_name, tpro.MRP, mcode.Use_Count AS attempt_number, tpro.Mfd_Date AS mfg_date, " +
    //" 'http://www.vcqru.com/Data/Sound/'+substring(creg.Comp_ID,6,4)+'/'+substring(creg.Comp_ID,6,4)+'.wav' as company_sound_file,'http://www.vcqru.com/Data/Sound/'+substring(creg.Comp_ID,6,4)+'/'+mcode.Pro_ID+'/'+mcode.Pro_ID+'.wav' as product_sound_file, '' as comment_english, '' as comment_hindi," +
    //" tpro.Exp_Date AS exp_date, mcode.Use_Count, tpro.Batch_No,preg.Pro_ID FROM M_Code" + Code2.ToString().Substring(6,2) + " AS mcode INNER JOIN Pro_Reg AS preg ON mcode.Pro_ID = preg.Pro_ID INNER JOIN Comp_Reg AS creg ON preg.Comp_ID = creg.Comp_ID INNER JOIN " +
    //"T_Pro AS tpro ON mcode.Batch_No = tpro.Row_ID WHERE  mcode.Code1 = '"+ Code1 +"'  AND mcode.Code2 = '"+ Code2 +"'");

    // DtDetail = SQL_DB.ExecuteDataTable("SELECT  mcode.Code1, mcode.Code2, creg.Comp_Name AS comp_name, preg.Pro_Name AS prod_name, tpro.MRP, mcode.Use_Count AS attempt_number, tpro.Mfd_Date AS mfg_date, " +
    //" 'http://www.vcqru.com/Data/Sound/'+substring(creg.Comp_ID,6,4)+'/'+substring(creg.Comp_ID,6,4)+'.wav' as company_sound_file,'http://www.vcqru.com/Data/Sound/'+substring(creg.Comp_ID,6,4)+'/'+mcode.Pro_ID+'/'+mcode.Pro_ID+'.wav' as product_sound_file, '' as comment_english, '' as comment_hindi," +
    //" tpro.Exp_Date AS exp_date, isnull(mcode.Use_Count,0) as Use_Count, tpro.Batch_No,preg.Pro_ID FROM M_Code AS mcode INNER JOIN Pro_Reg AS preg ON mcode.Pro_ID = preg.Pro_ID INNER JOIN Comp_Reg AS creg ON preg.Comp_ID = creg.Comp_ID INNER JOIN " +
    //"T_Pro AS tpro ON mcode.Batch_No = tpro.Row_ID WHERE  mcode.Code1 = " + Code1 + "  AND mcode.Code2 = " + Code2);




    // //SQL_DB.GetDA("SELECT [Code1],[Code2],[comp_name],[prod_name],[MRP],[mfg_date],[exp_date],[Use_Count],[Batch_No],'http://www.vcqru.com/Sound/'+[company_sound_file] as company_sound_file,'http://www.vcqru.com/Sound/'+[product_sound_file] as product_sound_file,'http://www.vcqru.com/Sound/'+[comment_english] as comment_english,'http://www.vcqru.com/Sound/'+[comment_hindi] as comment_hindi FROM [VW_CheckCode] where Code1='" + Code1 + "' and Code2='"+Code2+"'").Fill(DtDetail);       
    // if (DtDetail.Rows.Count<=0)
    // {
    //     Message Obj = new Message();
    //     Obj.Status_Code = "0";    
    //     Obj.Status_Message = "Authenticity of the product with Code1- " + Code1 + " and Code2- " + Code2 + "  can not be guaranteed .";                    
    //     ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
    //     return;
    // }
    // else if (DtDetail.Rows.Count > 0)
    // {
    //     if (DtDetail.Rows[0]["Use_Count"].ToString() == "0")
    //     {
    //         QueryResponse Obj = new QueryResponse();
    //         Obj.Status_Code = "1";
    //         ////Obj.Message += "Code1-" + Code1 + " and Code2-" + Code2 + ", Company-" + DtDetail.Rows[0]["comp_name"].ToString() + ", Product-" + DtDetail.Rows[0]["prod_name"].ToString() + ", MRP-" + DtDetail.Rows[0]["MRP"].ToString() + ", MFG-" + DtDetail.Rows[0]["mfg_date"].ToString() + ", EXP-" + DtDetail.Rows[0]["exp_date"] + ", BtNo-" + DtDetail.Rows[0]["Batch_No"].ToString() + ", Attempt-" + DtDetail.Rows[0]["Use_Count"].ToString() + ", Company Sound File- " + DtDetail.Rows[0]["company_sound_file"].ToString() + ", Product Sound File-" + DtDetail.Rows[0]["product_sound_file"].ToString() + ", Comment English File-" + DtDetail.Rows[0]["comment_english"].ToString() + ", Comment Hindi File-" + DtDetail.Rows[0]["comment_hindi"].ToString() + "";
    //         //Obj.Code1 = Code1;
    //         //Obj.Code2 = Code2;
    //         //Obj.CompanyName = DtDetail.Rows[0]["comp_name"].ToString();
    //         //Obj.ProductName = DtDetail.Rows[0]["prod_name"].ToString();
    //         //Obj.MRP = DtDetail.Rows[0]["MRP"].ToString();
    //         //Obj.MFG = DtDetail.Rows[0]["mfg_date"].ToString();
    //         //Obj.EXP = DtDetail.Rows[0]["exp_date"].ToString();
    //         //Obj.BatchNo = DtDetail.Rows[0]["Batch_No"].ToString();
    //         ////Obj.AttemptNo = DtDetail.Rows[0]["Use_Count"].ToString();
    //         //Obj.Company_Sound_File = DtDetail.Rows[0]["company_sound_file"].ToString();
    //         //Obj.Product_Sound_File = DtDetail.Rows[0]["product_sound_file"].ToString();
    //         //Obj.Comment_English_File = DtDetail.Rows[0]["comment_english"].ToString();
    //         //Obj.Comment_Hindi_File = DtDetail.Rows[0]["comment_hindi"].ToString();
    //         //Obj.Build_Loyalty = "0";
    //         //Obj.Cash_Transfer = "0";
    //         //Obj.Referral_Scheme = "0";
    //         //Obj.Gift_Coupon = "0";
    //         //Obj.Raffle_Scheme = "0";
    //         //Obj.Run_Survey = "0";


    //         Obj.Product_Sound_File = DtDetail.Rows[0]["product_sound_file"].ToString();
    //         Obj.MRP = DtDetail.Rows[0]["MRP"].ToString();
    //         Obj.MFG = DtDetail.Rows[0]["mfg_date"].ToString();
    //         Obj.EXP = DtDetail.Rows[0]["exp_date"].ToString();
    //         Obj.BatchNo = DtDetail.Rows[0]["Batch_No"].ToString();
    //         Obj.Company_Sound_File = DtDetail.Rows[0]["company_sound_file"].ToString();              
    //         Obj.Build_Loyalty = "0";
    //         Obj.Cash_Transfer = "0";               
    //         Obj.Gift_Coupon = "0";

    //         Obj.Code1 = Code1;
    //         Obj.Code2 = Code2;
    //         Obj.CompanyName = DtDetail.Rows[0]["comp_name"].ToString();
    //         Obj.ProductName = DtDetail.Rows[0]["prod_name"].ToString();
    //         Obj.Comment_English_File = DtDetail.Rows[0]["comment_english"].ToString();
    //         Obj.Comment_Hindi_File = DtDetail.Rows[0]["comment_hindi"].ToString();
    //         // Obj.Raffle_Scheme = "0";
    //         // Obj.Run_Survey = "0";
    //         ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
    //     }
    //     else
    //     {
    //         Message Obj = new Message();
    //         Obj.Status_Code = "2";
    //         Obj.Status_Message = "The authenticity of the product with Code1- " + Code1 + " and Code2-  " + Code2 + "  has already been checked before. If you have purchased fresh product with unscratched label then its authenticity can be guaranteed.";
    //         ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
    //     }

    // }



}