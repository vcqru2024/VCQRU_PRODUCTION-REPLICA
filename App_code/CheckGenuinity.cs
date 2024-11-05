using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Business_Logic_Layer;
using System.Net;
using System.Text;
using System.IO;
using Business9420;
using System.Collections.Generic;
using DataProvider;

/// <summary>
/// Summary description for CheckGenuinity
/// </summary>
namespace CodesGenuinity
{
    public class CheckGenuinity
    {
        public static bool InsFlag = true;
        #region Check Genuinity Code1 & Code2
        public static string Genuinity(string Code1, string Code2, string Mobile, string Dial_Mode, string Mode_Detail, string callercircle, string network,
            string callerdatetime, string callertime, string ApiType, params object[] ReferralCodes)
        {
            // string Msg = ""; bool Status = false;
            string result = "";
            string ConsumerId = "";
            string ReferralCode = "";
            Mobile = Mobile.TrimStart('+').TrimEnd('+');
            //SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('Enterd')");
            try
            {
                if ((ReferralCodes != null) && (ReferralCodes.Length > 0))
                    ReferralCode = ReferralCodes[0].ToString();
                InsFlag = true;

                // note : remove "+" from mobileno in below line to check validation of mobileno
                string MobileNo = GetActualMobileNo(Mobile);

                //SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('" + MobileNo + "')");
                string[] Arr = MobileNo.ToString().Split('*');
                if (Arr[0].ToString().Trim() == "false")
                    return Mobile;
                else
                    MobileNo = Arr[1].ToString().Trim();
                #region Checking for M_Consumer
                //  SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('"+MobileNo+"')");
                DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email] FROM [M_Consumer] where [MobileNo] = '" + MobileNo + "'");
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
                    //    SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('exists ConsumerId')");
                }

                if (ConsumerId == "")
                {
                    SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('New ConsumerId')");
                    #region Registration : send uid/pwd and referral code (ref-001) code
                    Random rnd = new Random();
                    User_Details Log = new User_Details();
                    Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
                    Log.ConsumerName = null;
                    // Log.Email = "";// email.Trim().Replace("'", "''"); // this is comment is done by shweta
                    //Log.Email = email.Trim().Replace("'", "''");
                    Log.MobileNo = Mobile;
                    Log.City = null;
                    Log.PinCode = null;
                    Log.Password = rnd.Next(10000, 99999).ToString();
                    Log.IsActive = 0;
                    Log.IsDelete = 0;
                    Log.code1 = Code1.Trim().Replace("'", "''");
                    Log.code2 = Code2.Trim().Replace("'", "''");
                    Log.DML = "I";
                    try
                    {
                        User_Details.InsertUpdateUserDetails(Log);
                        string strReferralCode = Convert.ToString(SQL_DB.ExecuteScalar("Select dbo.GetZeroConcactWithReferralCode(referralcode)  FROM [M_Consumer] where [MobileNo] = '" + MobileNo + "'"));
                        string msgString;
                        DataTable servicechk =SQL_DB.ExecuteDataTable("select ms.Service_ID,cr.comp_id from m_code mc left join pro_reg cr on mc.pro_id=cr.pro_id left join m_servicesubscription  ms on ms.pro_id=cr.pro_id and cr.comp_id=cr.comp_id where mc.code1='" + Code1 + "' and mc.code2='" + Code2 + "'");
                        //if (!string.IsNullOrEmpty(HttpContext.Current.Session["MMUser"].ToString()))
                        //{
                        if (servicechk.Rows.Count > 0)
                        {
                            if (servicechk.Rows[0][0].ToString() != "SRV1018" && servicechk.Rows[0][1].ToString().ToUpper() == "COMP-1152")
                            {
                                msgString = "Your VCQRU_ID: " + MobileNo + " & PWD: " + Log.Password + " Visit https://www.vcqru.com/login.aspx & complete your profile";
                            }
                            else
                            {
                                msgString = "Your VCQRU_ID: " + MobileNo + " & PWD: " + Log.Password + " Visit https://www.vcqru.com/login.aspx & complete your profile";
                            }
                        }
                        else
                        {
                            msgString = "Your VCQRU_ID: " + MobileNo + " & PWD: " + Log.Password + " Visit https://www.vcqru.com/login.aspx & complete your profile";
                        }
                            //}
                        //else
                        //{
                            //msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + " AND Referral Code is " + strReferralCode + ".";
                        //}
                        ServiceLogic.SendSms(msgString, MobileNo);

                        //ServiceLogic.SendSms("You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + " AND Referral Code is " + strReferralCode + ".", "+" + MobileNo);
                    }
                    catch (Exception ex)
                    {
                        SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('error Line no 90 in checkGenuinity.cs - " + ex.Message + "')");

                    }
                    #endregion
                    ConsumerId = Log.User_ID;
                    //SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('New ConsumerId - " + ConsumerId.ToString() + "')");
                }
                #endregion


               

                //if (!string.IsNullOrEmpty(ReferralCodeFromUser))
                //{
                //    if (!string.IsNullOrEmpty(ConsumerId))
                //    {
                //        ExecuteNonQueryAndDatatable.InsertUser_ReferredUser(ReferralCodeFromUser, MobileNo);
                //    }
                //}


                // SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('ConsumerId')");
                //Object9420 Reg = new Object9420();
                //Reg.Received_Code1 = (Code1.Trim().Replace("'", "''"));
                //Reg.Received_Code2 = (Code2.Trim().Replace("'", "''"));
                //Reg.Dial_Mode = "WebSite";
                //Reg.Mode_Detail = GetIP();
                //Reg.Mobile_No = MobileNo;
                //Reg.Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss"));

                Object9420 Reg = new Object9420();
                Reg.Received_Code1 = Code1;
                Reg.Received_Code2 = Code2;
                Reg.Dial_Mode = Dial_Mode;
                Reg.Mode_Detail = Mode_Detail;
                Reg.Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff"));
                Reg.Mobile_No = MobileNo;
                Reg.callercircle = callercircle;
                Reg.network = network;
                Reg.callerdate = Convert.ToDateTime(callerdatetime);
                Reg.callertime = callertime;

                DataSet ds = Business9420.function9420.FindCheckeCodes(Reg);
                DataTable dtComp = new DataTable();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    dtComp = SQL_DB.ExecuteDataTable("select * from Comp_Reg where comp_id in (select comp_Id from Pro_Reg  Where Pro_ID='" + ds.Tables[0].Rows[0]["Pro_ID"].ToString() + "')");
                    Reg.Comp_ID = dtComp.Rows[0]["Comp_ID"].ToString();
                    Reg.Comp_Name = dtComp.Rows[0]["Comp_Name"].ToString();
                }
                 
                //Reg.TempleteHead = "DEFAULT";
                //Reg.SubHeadId = "";


                //Added by Tej Midas Touch For any mobile number a person will be able to scan 10 codes in a month
                if (dtComp.Rows[0]["Comp_Name"].ToString() == "MIDAS TOUCH METALLOYS PRIVATE LIMITED")
                {
                    Reg.Comp_ID = dtComp.Rows[0]["Comp_ID"].ToString();
                    //string strQryMid = "SELECT PE.MobileNo FROM Pro_Enq PE JOIN Pro_Reg PR ON PR.Pro_ID = (SELECT Pro_ID FROM m_code WHERE Code1 = '" + Code1 + "' AND Code2 = '" + Code2 + "' ) JOIN Comp_Reg PR2 ON PR2.Comp_ID = 'Comp-1690' WHERE RIGHT(PE.MobileNo,10) = '" + MobileNo.Substring(MobileNo.Length - 10, 10) + "'  AND PE.Is_Success = '1'  AND CAST(PE.Enq_Date AS DATE) BETWEEN CAST(DATEADD(MONTH, -1, GETDATE()) AS DATE) AND CAST(GETDATE() AS DATE)";
                    //string strQryMid = "select * from Pro_Enq where RIGHT(MobileNo,10) = '" + MobileNo.Substring(MobileNo.Length - 10, 10) + "' and Is_Success='1' and Comp_ID='Comp-1690' AND CAST(Enq_Date AS DATE) BETWEEN CAST(DATEADD(MONTH, -1, GETDATE()) AS DATE) AND CAST(GETDATE() AS DATE)";
                    string strQryMid = "select PE.Is_Success,PE.MobileNo from Pro_Enq PE, Comp_Reg CR where RIGHT(PE.MobileNo,10) = '" + MobileNo.Substring(MobileNo.Length - 10, 10) + "' AND PE.Is_Success = '1' AND cr.Comp_ID='Comp-1690' AND CAST(Enq_Date AS DATE) BETWEEN CAST(DATEADD(MONTH, -1, GETDATE()) AS DATE) AND CAST(GETDATE() AS DATE)";

                    DataTable dtchkCountSuccCode = SQL_DB.ExecuteDataTable(strQryMid);
                    if (dtchkCountSuccCode.Rows.Count > 9)
                    {
                        result = "You've reached the maximum scan limit for this month. Please try again next month. ";
                        return result;
                    }
                }
                //close by Tej



                DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);

             if (Business9420.function9420.FindCheckedStatus(Reg)) // it looks company status check i.e verify company by admin
                {
                    Reg.Is_Success = 0;
                    Business9420.function9420.InsertCodeChecked(Reg);
                    if (dtComp.Rows[0]["Comp_Name"].ToString().ToLower() == "1 stop nutritions")
                    {
                        result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode' and SubHeadId='Custom_Msg'");
                    }
                    else
                    {
                        result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
                        //result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
                        //send a mail to customer that it's company status is inactive(i.e 0) , so user cannot veryfy there product.
                        //return result; // it should if not graranted shweta
                    }
                }

               
                //  DataSet ds = ServiceLogic.FindCheckedCode_2(Reg);
                if (ds.Tables[0].Rows.Count == 0)
                {
                    Reg.Is_Success = 0;
                    Business9420.function9420.InsertCodeChecked(Reg);
                    #region// TemplateId for InvalidSMS
                     result = "The entered code is invalid. Please enter correct 13-digit code or call us on 7353000903. www.vcqru.com";
                    ServiceLogic.SendSmsfromknowlarity(result, Reg.Mobile_No, "1007709448324581324");
                    #endregion;  

                    //if (dtComp.Rows[0]["Comp_Name"].ToString().ToLower() == "1 stop nutritions")
                    //{
                    //    result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode' and SubHeadId='Custom_Msg'");
                    //}
                    //else
                    //{
                    //    result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
                    //result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
                    // result = "code1 -" + Reg.Received_Code1 + " code2 -" + Reg.Received_Code2 + " which you have entered is incorrect.Visit www.vcqru.com for more info OR for any query contact customer care 9243029420.Thanks VCQRU";
                    //result = "code1 -" + Reg.Received_Code1 + " and code2 -" + Reg.Received_Code2 + "which you have entered is not authentic.Visit www.vcqru.com for more info OR for any query contact customer care 9243029420.";
                    result = "The checked coupon code " + Reg.Received_Code1 + Reg.Received_Code2+" is not valid . For more info visit https://www.vcqru.com/assets/images/pdf/FAQ.pdf";
                    
                    return result; // it should if not graranted shweta
                   // }
                }
                else if (ds.Tables[0].Rows.Count > 0)
                {
                    // SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('ds - " + ds.Tables[0].Rows[0]["Use_Count"].ToString() + "')");
                    DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
                    if (dsres.Tables.Count > 0)
                    {
                        #region Service Looping
                        if (dsres.Tables[0].Rows.Count > 0)
                        {
                            if (ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
                            {
                                result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, false, ReferralCode, Reg.Dial_Mode);
                                //////////////////////////////
                                string code = Reg.Received_Code1 + "-" + Reg.Received_Code2;
                                DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(code);
                                //HttpContext.Current.Request.Form["mobile"];
                                if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Auto Max India" && dsServicesAssign.Tables[0].Rows[0]["Service_id"].ToString() == "SRV1023")
                                {
                                    //string billno = context.Request.QueryString["billno"].ToString(); //HttpContext.Current.Request.Form["billno"];
                                    // string purchasedate = context.Request.QueryString["purchasedate"].ToString(); // HttpContext.Current.Request.Form["purchasedate"];
                                    string purchasedate = DateTime.Today.ToString("MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture); // HttpContext.Current.Request.Form["purchasedate"];
                                  
                                    //var path = "";
                                    //var virtualPath = "";
                                    string period = string.Empty;
                                    DateTime expDate = DateTime.Today;
                                    // foreach (HttpPostedFile file in context.Request.Files)
                                    //foreach (string key in HttpContext.Current.Request.Files)
                                    //{
                                    //    var file = HttpContext.Current.Request.Files[key];
                                    //    if (HttpContext.Current.Session["strWar"] == null)
                                    //    {
                                    DataRow product_details = GetProductName(code);
                                    string prdName = product_details["Pro_name"].ToString();
                                    //DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(code);
                                    DataRow[] servicedetais = dsServicesAssign.Tables[0].Select("Service_id = 'SRV1023'");

                                    DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                                    period = servicedetais[0]["WarrantyPeriod"].ToString();
                                    expDate = purDate.AddMonths(Convert.ToInt32(period));

                                    SaveWarrentyDetailsforauto(purchasedate, MobileNo, code, expDate, period);
                                }
                                ///////////////////////////////////
                                // 18/11/20 m_code update if exception occured SQL_DB.ExecuteNonQuery("Update M_Code set Use_Count = 1 where [Code1] = '"+ Reg.Received_Code1 + "' and [Code2] = '"+ Reg.Received_Code2 + "'");

                                Reg.Is_Success = 1;
                                //SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                                //    "[Is_Success],[callerdate],[callertime]) VALUES('" + Reg.Dial_Mode + "','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "'," +
                                //    "'" + MobileNo + "','" + Code1 + "','" + Code2 + "','" + Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "','" +
                                //    Reg.callerdate.ToString("yyyy/MM/dd HH:mm:ss") + "','" + Reg.callertime + "')");
                            }
                            else if (ds.Tables[0].Rows[0]["Use_Count"].ToString() != "0")
                            {
                                //DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
                                result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, true, ReferralCode, Reg.Dial_Mode);
                                //Reg.Is_Success = 2;

                                //SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                                //    "[Is_Success],[callerdate],[callertime]) VALUES('" + Reg.Dial_Mode + "','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "'," +
                                //    "'" + MobileNo + "','" + Code1 + "','" + Code2 + "','" + Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "','" + 
                                //    Reg.callerdate.ToString("yyyy/MM/dd HH:mm:ss") + "','" + Reg.callertime + "')");
                            }
                        }
                        else
                        {
                            if (ds.Tables[0].Rows[0]["Use_Count"].ToString() != "0")
                            {
                                Reg.Is_Success = 2;
                                SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network],"+
                                    "[Is_Success],[callerdate],[callertime]) VALUES('"+Reg.Dial_Mode+"','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "',"+
                                    "'" + MobileNo + "','" + Code1 + "','" + Code2 + "','" +Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "','" + Reg.callerdate.ToString("yyyy/MM/dd HH:mm:ss") + "','" + Reg.callertime + "')");
                                //DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");

                                if (dtComp.Rows[0]["Comp_Name"].ToString().ToLower() == "1 stop nutritions")
                                {
                                    result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='Checked' and SubHeadId='Custom_Msg'");
                                }
                                else
                                {
                                    result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='Checked'");
                                    //SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('result inner - " + result + "')");
                                }
                            }
                            else
                            {
                                if (dtComp.Rows[0]["Comp_Name"].ToString().ToLower() == "1 stop nutritions")
                                {
                                    result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode' and SubHeadId='Custom_Msg'");
                                }
                                else
                                {
                                    result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
                                }
                            }

                        }
                        #endregion
                    }
                    else
                    {
                        if (ds.Tables[0].Rows[0]["Use_Count"].ToString() != "0")
                        {
                            Reg.Is_Success = 2;
                            SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                                "[Is_Success],[callerdate],[callertime]) VALUES('" + Reg.Dial_Mode + "','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "'," +
                                "'" + MobileNo + "','" + Code1 + "','" + Code2 + "','" + Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "','" + Reg.callerdate.ToString("yyyy/MM/dd HH:mm:ss") + "','" + Reg.callertime + "')");
                            //DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
                            result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='Checked'");
                            // SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('result - " + result + "')");
                        }
                        else
                        {
                            result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
                        }
                    }
                }
                //SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('" + Mobile + "-" + Code1 + "-" + Code2 + "-" + callertime + "-" + callerdatetime + "-" + callercircle + "-" + network + "')");
            }
            catch (Exception ex)
            {
                SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('error - " + ex.Message + "')");
                string ErrorPagePath = HttpContext.Current.Request.Url.ToString();
                Exception ErrorInfo = ex.GetBaseException(); //HttpContext.Current.Server.GetLastError().GetBaseException();
                DataProvider.LogManager.ErrorExceptionLog(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
                DataProvider.LogManager.ErrorExceptionLog(ErrorPagePath);
                DataProvider.LogManager.ErrorExceptionLog(ErrorInfo.Message);
                DataProvider.LogManager.ErrorExceptionLog("\n" + ErrorInfo.StackTrace + "\n");
                DataProvider.LogManager.ErrorExceptionLog("\n UserHostAddress: " + Convert.ToString(HttpContext.Current.Request.UserHostAddress) + ",REMOTE_ADDR: " + HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] + ", HTTP_X_FORWARDED_FOR: " + Convert.ToString(HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"]));
            }
            //return Status + "*" + Msg;

            return result;
        }

        public static DataRow GetProductName(string c)
        {
            DataRow rsProID = null;
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT Pro_Name,PRO_ID FROM Pro_Reg WHERE PRO_ID IN (SELECT PRO_ID FROM M_Code Where CODE1='" + c.Split('-')[0] + "' and CODE2='" + c.Split('-')[1] + "')");
            if (ds.Tables[0].Rows.Count > 0)
                //rsProID = ds.Tables[0].Rows[0]["Pro_Name"].ToString();
                rsProID = ds.Tables[0].Rows[0];
            return rsProID;
        }
        public static void SaveWarrentyDetailsforauto(string purchasedate, string mobile, string wCode, DateTime expDate, string period)
        {
            DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            // DateTime expDate = purDate.AddYears(1);
            SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[WarrentyDetails] ([PurchaseDate],[Mobile],WarrantyPeriod,ExpirationDate,IsWarrantyClaimed, code) values ('" + purDate.ToString("MM/dd/yyyy") + "','" + mobile + "','" + period + "','" + expDate.ToString("MM/dd/yyyy") + "', 0, '" + wCode + "')");
        }
        public static string Genuinity2(string Code1, string Code2, string Mobile, string Dial_Mode, string Mode_Detail, string ApiType, params object[] ReferralCodes)//, string Referral
        {
            LogManager.WriteExe("Hit this Function ");
            string ReferralCode = "";
            if ((ReferralCodes != null) && (ReferralCodes.Length > 0))
                ReferralCode = ReferralCodes[0].ToString();
            InsFlag = true;
            try
            {
                string Msg = ""; bool Status = false;
                string MobileNo = "";
                MobileNo = GetActualMobileNo(Mobile);
                string[] Arr = MobileNo.ToString().Split('*');
                if (Arr[0].ToString().Trim() == "false")
                    return Mobile;
                else
                    MobileNo = Arr[1].ToString().Trim();
                string ConsumerId = "", RefConsumerId = "", RefMobileNo = "";
                #region Checking for M_Consumer
                DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email] FROM [M_Consumer] where [MobileNo] = '" + MobileNo + "'");
                if (dcs.Tables[0].Rows.Count > 0)
                    ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
                if (ConsumerId == "")
                {
                    #region Registration
                    Random rnd = new Random();
                    User_Details Log = new User_Details();
                    Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
                    Log.ConsumerName = null;
                    Log.Email = null;
                    Log.MobileNo = MobileNo;
                    Log.City = null;
                    Log.PinCode = null;
                    Log.Password = rnd.Next(10000, 99999).ToString();
                    Log.IsActive = 0;
                    Log.IsDelete = 0;
                    Log.DML = "I";
                    User_Details.InsertUpdateUserDetails(Log);
                    SendSms("Your VCQRU_ID: " + MobileNo + " & PWD: " + Log.Password + ".Visit https://www.vcqru.com/login.aspx & complete your profile.", MobileNo, ApiType);
                    #endregion
                    ConsumerId = Log.User_ID;
                }
                #endregion
                Object9420 Reg = new Object9420();
                Reg.Received_Code1 = Code1;
                Reg.Received_Code2 = Code2;
                Reg.Dial_Mode = Dial_Mode;
                Reg.Mode_Detail = Mode_Detail;
                Reg.Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss"));
                Reg.Mobile_No = MobileNo;
                DataSet ds = Business9420.function9420.FindCheckeCodes(Reg);
                Reg.TempleteHead = "DEFAULT";
                Reg.SubHeadId = "";
                DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
                if (ds.Tables[0].Rows.Count == 0)
                {
                    Reg.Is_Success = 0;
                    Business9420.function9420.InsertCodeChecked(Reg);
                    Msg = MsgTempdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                    Status = false;
                    return Status + "*" + Msg;
                }
                else
                {
                    #region Check if Code is already checked
                    if (ds.Tables[0].Rows[0]["Use_Count"].ToString() != "0")
                    {
                        string CounterSrvID = "SRV1018";// Counter fitting Service id 
                        string MsgSrvType = "S";
                        DataTable chkdt = new DataTable(); DataTable srvdt = new DataTable();
                        chkdt = SQL_DB.ExecuteDataTable("SELECT Service_ID, Comp_ID,(SELECT IsRetailer FROM Comp_Reg WHERE (Comp_ID = m.Comp_ID)) AS IsRetailer,(SELECT Comp_Name FROM Comp_Reg WHERE (Comp_ID = m.Comp_ID)) AS Comp_Name, Pro_ID,(SELECT Pro_Name FROM Pro_Reg WHERE (Pro_ID = m.Pro_ID)) AS Pro_Name FROM M_ServiceSubscription AS m WHERE (GETDATE() BETWEEN DateFrom AND DateTo) AND (IsActive = 1) AND (Pro_ID = '" + ds.Tables[0].Rows[0]["Pro_ID"].ToString() + "') ");
                        if (chkdt.Rows.Count > 0)
                        {
                            srvdt = SQL_DB.ExecuteDataTable("SELECT SST_Id FROM M_ServiceSubscriptionTrans WHERE (Subscribe_Id IN (SELECT Subscribe_Id FROM M_ServiceSubscription WHERE (Service_ID = '" + CounterSrvID + "') AND (GETDATE() BETWEEN DateFrom AND DateTo) AND (IsActive = 1) AND (Pro_ID = '" + ds.Tables[0].Rows[0]["Pro_ID"].ToString() + "'))) AND (GETDATE() BETWEEN DateFrom AND DateTo) AND (IsActive = 1)");
                            if (srvdt.Rows.Count > 0)
                            {
                                if (chkdt.Rows[0]["IsRetailer"].ToString() == "1")
                                    MsgSrvType = "R";
                                else
                                    MsgSrvType = "C";
                            }
                            else
                                MsgSrvType = "S";
                        }
                        else
                            MsgSrvType = "S";
                        if (chkdt.Rows[0]["IsRetailer"].ToString() == "1")
                            MsgSrvType = "R";
                        else
                        {
                            if (MsgSrvType != "C")
                                MsgSrvType = "S";
                        }
                        if (MsgSrvType == "C")
                        {
                            Reg.SubHeadId = "";
                        }
                        else if (MsgSrvType == "R")
                        {
                            CounterSrvID = "SRV1012"; // Retailer Service id
                            Reg.SubHeadId = "INSTANT";
                        }
                        else
                        {
                            CounterSrvID = "SRV1003"; // Gift Coupon Instant Service id
                            Reg.SubHeadId = "INSTANT";
                        }
                        #region Get Message templete
                        MsgTempdt.Reset();
                        Reg.TempleteHead = CounterSrvID;
                        MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
                        #endregion
                        Reg.Is_Success = 0;
                        Business9420.function9420.InsertCodeChecked(Reg);
                        DataView dv = MsgTempdt.DefaultView;
                        dv.RowFilter = "MsgType = 2";
                        DataTable fdt = dv.ToTable();
                        //if(chkdt.Rows.Count > 0)
                        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", chkdt.Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", chkdt.Rows[0]["Comp_Name"].ToString());
                        //else
                        //Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", chkdt.Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", chkdt.Rows[0]["Comp_Name"].ToString());
                        Status = false;
                        return Status + "*" + Msg;
                    }
                    #endregion

                    Reg.Pro_ID = ds.Tables[0].Rows[0]["Pro_ID"].ToString();
                    DataTable sdt = Business9420.function9420.GetAllServices(Reg);

                    #region Query For M_Code
                    Reg.Is_Success = 1;
                    DataSet dsres = SQL_DB.ExecuteDataSet("SELECT Pro_Reg.Comp_ID,Comp_Reg.Comp_Name,  m_code.Pro_ID+'-'+ " +
                    " convert(varchar,(case when len(convert(nvarchar,M_Code.Series_Order)) = 1 " +
                    " then '0'+ convert(nvarchar,M_Code.Series_Order) else " +
                    " convert(nvarchar,M_Code.Series_Order) end))+'-'+" +
                    " convert(varchar,(case when len(convert(varchar,M_Code.Series_Serial)) = 1 then '00' " +
                    " +convert(varchar,M_Code.Series_Serial)  " +
                    " when len(convert(varchar,M_Code.Series_Serial)) = 2 then '0' " +
                    " +convert(varchar,M_Code.Series_Serial) " +
                    " else convert(varchar,M_Code.Series_Serial) end )) as series, Pro_Reg.Pro_Name,isnull(Pro_Reg.Comments,'') as Comments,m_code.Pro_ID," +
                    " T_Pro.MRP,convert(nvarchar,T_Pro.Mfd_Date,103) as Mfd_Date, convert(nvarchar,isnull(T_Pro.Exp_Date,''),103) as Exp_Date," +
                    " T_Pro.Batch_No, M_Code.Code1,M_Code.Code2 " +
                    " FROM T_Pro INNER JOIN M_Code ON T_Pro.Row_ID = M_Code.Batch_No INNER JOIN" +
                    " Pro_Reg ON T_Pro.Pro_ID = Pro_Reg.Pro_ID INNER JOIN Comp_Reg ON Pro_Reg.Comp_ID = Comp_Reg.Comp_ID" +
                    " where  M_Code.Code1 = '" + Reg.Received_Code1 + "' and M_Code.Code2 = '" + Reg.Received_Code2 + "' ");//and ISNULL(m_code.use_count,0) = 0
                    #endregion

                    #region Check for Services
                    if (sdt.Rows.Count > 0)
                    {
                        string CompId = dsres.Tables[0].Rows[0]["Comp_ID"].ToString(); string ProId = ds.Tables[0].Rows[0]["Pro_ID"].ToString();
                        string SubscribeId = "", ServiceId = "";
                        Int32 IsAdditionalGift = 1, IsPoints = 1, IsNotify = 1, IsCash = 1, IsCoupons = 1, IsReferralValue = 0, IsReferral = 0;
                        for (int s = 0; s < sdt.Rows.Count; s++)
                        {
                            ServiceId = sdt.Rows[s]["Service_ID"].ToString();
                            SubscribeId = sdt.Rows[s]["Subscribe_Id"].ToString();
                            IsAdditionalGift = Convert.ToInt32(sdt.Rows[s]["IsAdditionalGift"]);
                            IsPoints = Convert.ToInt32(sdt.Rows[s]["IsPoints"]);
                            IsNotify = Convert.ToInt32(sdt.Rows[s]["IsNotify"]);
                            IsCash = Convert.ToInt32(sdt.Rows[s]["IsCash"]);
                            IsCoupons = Convert.ToInt32(sdt.Rows[s]["IsCoupons"]);
                            IsReferralValue = Convert.ToInt32(sdt.Rows[s]["IsRef"]);
                            IsReferral = Convert.ToInt32(sdt.Rows[s]["IsReferral"]);
                            MsgTempdt.Reset();
                            Reg.TempleteHead = ServiceId;
                            Reg.SubHeadId = "";
                            MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
                            if (IsAdditionalGift == 0)
                            {
                                #region Additional Gift for Raffle scheme & Gift Coupons
                                if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
                                {
                                    #region Logic For Additional Gift

                                    Reg.Is_Success = 1;
                                    UpdateTransactions(Reg, true);

                                    #region Some Global Variables for this code region
                                    Int64 SSTID = Convert.ToInt64(sdt.Rows[s]["SST_Id"]);
                                    Int64 TPrize = 0, DPrize = 0, dpr = 0, IsPrize = 0, Frequency = 0;
                                    DataTable rulesdt = SQL_DB.ExecuteDataSet("SELECT Trans_Id, SST_Id, ServiceType, Rules, DistributionType, PrizeTrans_Id, MasterCodes, WinningCodes, WinCodes, Frequency,IsPrize FROM M_ServiceRules WHERE SST_Id = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + "").Tables[0];
                                    if (rulesdt.Rows.Count > 0)
                                    {
                                        TPrize = Convert.ToInt64(rulesdt.Rows[0]["WinningCodes"]);
                                        DPrize = Convert.ToInt64(rulesdt.Rows[0]["WinCodes"]);
                                        IsPrize = Convert.ToInt32(rulesdt.Rows[0]["IsPrize"]);
                                        Frequency = Convert.ToInt32(rulesdt.Rows[0]["Frequency"]);
                                    }
                                    #endregion

                                    bool FreQuencyFlag = false; // is Frequency is applied and then check is won or hard luck
                                    if (rulesdt.Rows[0]["ServiceType"].ToString() != ServiceTypes.DueDate.ToString())
                                    {
                                        #region Logic for randomly distribute rewards frequency wise
                                        if (Frequency > 1)
                                        {
                                            IsPrize++;
                                            if (Frequency != IsPrize)
                                            {
                                                #region Get Message
                                                DataView dv = MsgTempdt.DefaultView;
                                                dv.RowFilter = "MsgType = 4";
                                                DataTable fdt = dv.ToTable();
                                                #endregion
                                                if (Msg != "")
                                                    Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString()); //" Hard luck, please try next time.";
                                                else
                                                    Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString()); //" Hard luck, please try next time.";
                                                SQL_DB.ExecuteNonQuery("UPDATE M_ServiceRules SET IsPrize = " + IsPrize + "  WHERE SST_Id = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " ");
                                                FreQuencyFlag = false;
                                            }
                                            else
                                            {
                                                SQL_DB.ExecuteNonQuery("UPDATE M_ServiceRules SET IsPrize = 0  WHERE SST_Id = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " ");
                                                Frequency = -1;
                                                FreQuencyFlag = true;
                                            }
                                        }
                                        else
                                            FreQuencyFlag = true;
                                        #endregion
                                    }
                                    else
                                        FreQuencyFlag = true;                                        

                                    #region Logic For
                                    if (FreQuencyFlag)
                                    {
                                        DataTable prizedt = new DataTable();
                                        DataTable infinitedt = new DataTable();
                                        DataTable Coupondt = new DataTable();
                                        List<Gifts> Obj = new List<Gifts>();
                                        if (rulesdt.Rows[0]["ServiceType"].ToString() == ServiceTypes.Instant.ToString())
                                        {
                                            #region Get Message templete
                                            MsgTempdt.Reset();
                                            Reg.TempleteHead = ServiceId;
                                            Reg.SubHeadId = "INSTANT";
                                            MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
                                            #endregion
                                            #region Logic For Instant
                                            if (rulesdt.Rows[0]["Rules"].ToString() != ServiceRules.RandomNCustomer.ToString())
                                            {
                                                if (rulesdt.Rows[0]["DistributionType"].ToString() == RwdDistrubutionRules.Random.ToString())
                                                {
                                                    Obj = new List<Gifts>();
                                                    #region Logic for Random Rewards Distributions
                                                    infinitedt = SQL_DB.ExecuteDataSet("SELECT Trans_Id, SST_Id, PrizeTrans_Id, Gift_Id, GiftName, GiftCount, DistributeCount FROM M_ServicePrize WHERE SST_Id = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " AND GiftCount = 0 ").Tables[0];

                                                    #region New Code
                                                    if (infinitedt.Rows.Count == 0)
                                                        prizedt = SQL_DB.ExecuteDataSet("SELECT Trans_Id, SST_Id, PrizeTrans_Id, Gift_Id, GiftName, GiftCount, DistributeCount FROM M_ServicePrize R  CROSS APPLY dbo.NumbersTable(1,R.GiftCount-R.DistributeCount,1) WHERE R.SST_Id = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " AND R.GiftCount > R.DistributeCount ORDER BY NEWID()").Tables[0];
                                                    else
                                                    {
                                                        #region If infinite rewards is Exist
                                                        try
                                                        {
                                                            int rcount = 0; Int64 finfinitecount = 0; Int64 rem = 0; string ExecuteQry = "";
                                                            Int64 totalparticount = Convert.ToInt64(SQL_DB.ExecuteScalar("SELECT COUNT(Trans_Id) AS Cnt FROM T_GiftDistribution WHERE (SST_Id = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " ) AND CONVERT(VARCHAR,EntryDate,111) >= '" + Convert.ToDateTime(sdt.Rows[s]["DateFrom"]).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,EntryDate,111) <= '" + Convert.ToDateTime(sdt.Rows[s]["DateTo"]).ToString("yyyy/MM/dd") + "' "));
                                                            Int64 totalentrygift = Convert.ToInt64(SQL_DB.ExecuteScalar("SELECT SUM(GiftCount) FROM M_ServicePrize WHERE (SST_Id = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " )"));
                                                            totalparticount = (totalparticount == 0 ? 1 : totalparticount);
                                                            Int64 infinitecount = 0;
                                                            infinitecount = totalentrygift + totalentrygift * 5 + totalparticount;
                                                            //if (totalparticount > totalentrygift)
                                                            //    infinitecount = totalparticount - totalentrygift;
                                                            //else
                                                            //    infinitecount = totalentrygift * 5;// 5 times of infinie rewards count;                        
                                                            if (infinitedt.Rows.Count > 1)
                                                            {
                                                                rcount = infinitedt.Rows.Count;
                                                                finfinitecount = infinitecount / rcount;
                                                                rem = infinitecount % rcount;
                                                            }
                                                            for (int p = 0; p < infinitedt.Rows.Count; p++)
                                                            {
                                                                if (rem > 0)
                                                                {
                                                                    if (p == infinitedt.Rows.Count - 1)
                                                                        finfinitecount = finfinitecount + rem;
                                                                }
                                                                else
                                                                    finfinitecount = infinitecount;
                                                                // Update Rows for get Logics
                                                                ExecuteQry += "UPDATE M_ServicePrize SET GiftCount = " + finfinitecount + " , DistributeCount = 0  WHERE Trans_Id = " + Convert.ToInt64(infinitedt.Rows[p]["Trans_Id"]) + ";";
                                                            }
                                                            if (ExecuteQry != "")
                                                            {
                                                                try
                                                                {
                                                                    SQL_DB.ExecuteNonQuery(ExecuteQry);
                                                                }
                                                                catch (Exception Ex)
                                                                {
                                                                    return "false*" + Ex.Message.ToString();
                                                                }
                                                            }
                                                            prizedt = SQL_DB.ExecuteDataSet("SELECT Trans_Id, SST_Id, PrizeTrans_Id, Gift_Id, GiftName, GiftCount, DistributeCount FROM M_ServicePrize R  CROSS APPLY dbo.NumbersTable(1,R.GiftCount-R.DistributeCount,1) WHERE R.SST_Id = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " AND R.GiftCount > R.DistributeCount ORDER BY NEWID()").Tables[0];
                                                            // Update Rows for infinite rows Logics//infinitedt.Rows.Count
                                                            ExecuteQry = "";
                                                            for (int q = 0; q < infinitedt.Rows.Count; q++)                                                            
                                                            {                                                               
                                                                // Update Rows for get Logics
                                                                ExecuteQry += "UPDATE M_ServicePrize SET GiftCount = 0 , DistributeCount = 0  WHERE Trans_Id = " + Convert.ToInt64(infinitedt.Rows[q]["Trans_Id"]) + ";";
                                                            }
                                                            if (ExecuteQry != "")
                                                            {
                                                                try
                                                                {
                                                                    SQL_DB.ExecuteNonQuery(ExecuteQry);
                                                                }
                                                                catch (Exception Ex)
                                                                {
                                                                    return "false*" + Ex.Message.ToString();
                                                                }
                                                            }
                                                        }
                                                        catch (Exception ex)
                                                        {
                                                            throw ex;
                                                        }
                                                        #endregion
                                                    }
                                                    if (prizedt.Rows.Count > 0)
                                                    {
                                                        for (int p = 0; p < prizedt.Rows.Count; p++)
                                                            Obj.Add(new Gifts { Gift_ID = prizedt.Rows[p]["Gift_Id"].ToString(), GiftName = prizedt.Rows[p]["GiftName"].ToString(), GiftCount = Convert.ToInt64(prizedt.Rows[p]["GiftCount"]), DistributeGiftCount = Convert.ToInt64(0) });
                                                    }
                                                    #endregion
                                                    string GiftName = CustomeDraw.RewardsDraw.GetRandomGiftName(Obj);
                                                    string[] GiftArr = GiftName.ToString().Split('-');
                                                    dpr = Convert.ToInt64(SQL_DB.ExecuteScalar("SELECT ISNULL(DistributeCount,0) FROM M_ServicePrize WHERE (SST_Id = '" + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + "') AND (Gift_Id = '" + GiftArr[1] + "') "));                                                    
                                                    if (DPrize < TPrize)
                                                    {
                                                        #region
                                                        //prizedt = SQL_DB.ExecuteDataSet("SELECT TOP(1) Trans_Id, SST_Id, PrizeTrans_Id, Gift_Id, GiftName, GiftCount,DistributeCount FROM M_ServicePrize WHERE SST_Id = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " AND  (GiftCount > DistributeCount) ORDER BY NEWID() ").Tables[0];
                                                        //if (prizedt.Rows.Count > 0)
                                                        if (Obj.Count > 0)
                                                        {
                                                            //dpr = Convert.ToInt64(prizedt.Rows[0]["DistributeCount"]);
                                                            string p = "INSERT INTO [T_GiftDistribution] ([Comp_ID],[Pro_ID],[SST_Id],[Code1],[Code2],[MobileNo],[Prize],[EntryDate],[IsUsed],[IsSMS],[IsDelivery]) VALUES " +
                                                                    " ('" + CompId + "','" + ProId + "','" + SSTID + "','" + Code1 + "','" + Code2 + "','" + MobileNo + "','" + GiftArr[0].ToString() + "' ,'" + Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "',1,0,0) ";
                                                            try
                                                            {
                                                                SQL_DB.ExecuteNonQuery(p);
                                                                DPrize++; dpr++; 
                                                                if (Frequency == -1)
                                                                    SQL_DB.ExecuteNonQuery("UPDATE M_ServiceRules SET WinCodes = '" + DPrize + "' WHERE Trans_Id = '" + Convert.ToInt64(rulesdt.Rows[0]["Trans_Id"]) + "' ");
                                                                else
                                                                    SQL_DB.ExecuteNonQuery("UPDATE M_ServiceRules SET WinCodes = '" + DPrize + "' , IsPrize = 0 WHERE Trans_Id = '" + Convert.ToInt64(rulesdt.Rows[0]["Trans_Id"]) + "' ");
                                                                //SQL_DB.ExecuteNonQuery("UPDATE M_ServicePrize SET DistributeCount = '" + dpr + "' WHERE Trans_Id = '" + Convert.ToInt64(prizedt.Rows[0]["Trans_Id"]) + "' ");
                                                                SQL_DB.ExecuteNonQuery("UPDATE M_ServicePrize SET DistributeCount = '" + dpr + "' WHERE (SST_Id = '" + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + "') AND (Gift_Id = '" + GiftArr[1] + "') ");
                                                                if (infinitedt.Rows.Count == 0)
                                                                {
                                                                    if (TPrize == DPrize)
                                                                        SQL_DB.ExecuteNonQuery("UPDATE M_ServiceSubscriptionTrans SET IsActive = 0 WHERE SST_Id = '" + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + "' ");
                                                                }                                                                
                                                                #region Get Message
                                                                DataView dv = MsgTempdt.DefaultView;
                                                                dv.RowFilter = "MsgType = 1";
                                                                DataTable fdt = dv.ToTable();
                                                                #endregion
                                                                #region Create Templete
                                                                if (IsCoupons == 1)
                                                                {
                                                                    if (Msg != "")
                                                                        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<GIFTNAME>", GiftArr[0].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                    else
                                                                        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<GIFTNAME>", GiftArr[0].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                }
                                                                else
                                                                {
                                                                    Coupondt.Reset();
                                                                    Coupondt = SQL_DB.ExecuteDataTable("SELECT TOP(1) CouponTrans_ID, Price, CONVERT(VARCHAR,ValidFrom,103) AS ValidFrom, CONVERT(VARCHAR,ValidTo,103) AS ValidTo,CouponCode FROM M_CouponCodes where Coupon_ID='" + prizedt.Rows[0]["Gift_Id"].ToString() + "' AND SST_ID = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " AND ISNULL(IsDistributed,0) = 0 ");
                                                                    if (Coupondt.Rows.Count > 0)
                                                                    {
                                                                        if (Msg != "")
                                                                            Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<VALIDFROM>", Coupondt.Rows[0]["ValidFrom"].ToString()).Replace("<TILLDT>", Coupondt.Rows[0]["ValidTo"].ToString()).Replace("<GIFTNAME>", Coupondt.Rows[0]["Price"].ToString()).Replace("<COUPONCODE>", Coupondt.Rows[0]["CouponCode"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                        else
                                                                            Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<VALIDFROM>", Coupondt.Rows[0]["ValidFrom"].ToString()).Replace("<TILLDT>", Coupondt.Rows[0]["ValidTo"].ToString()).Replace("<GIFTNAME>", Coupondt.Rows[0]["Price"].ToString()).Replace("<COUPONCODE>", Coupondt.Rows[0]["CouponCode"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                        SQL_DB.ExecuteNonQuery("UPDATE M_CouponCodes SET IsDistributed = 1 WHERE CouponTrans_ID = " + Convert.ToInt64(Coupondt.Rows[0]["CouponTrans_ID"]));
                                                                    }
                                                                }
                                                                #endregion
                                                            }
                                                            catch (Exception ex)
                                                            {
                                                                return "false*" + ex.Message.ToString();
                                                            }
                                                        }
                                                        #endregion
                                                    }
                                                    else
                                                    {
                                                        #region
                                                        if ((infinitedt.Rows.Count > 0) && (Obj.Count > 0))
                                                        {
                                                            string p = "INSERT INTO [T_GiftDistribution] ([Comp_ID],[Pro_ID],[SST_Id],[Code1],[Code2],[MobileNo],[Prize],[EntryDate],[IsUsed],[IsSMS],[IsDelivery]) VALUES " +
                                                                " ('" + CompId + "','" + ProId + "','" + SSTID + "','" + Code1 + "','" + Code2 + "','" + MobileNo + "','" + GiftArr[0].ToString() + "' ,'" + Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "',1,0,0) ";
                                                            try
                                                            {
                                                                SQL_DB.ExecuteNonQuery(p);
                                                                DPrize++;
                                                                if (Frequency == -1)
                                                                    SQL_DB.ExecuteNonQuery("UPDATE M_ServiceRules SET WinCodes = '" + DPrize + "' WHERE Trans_Id = '" + Convert.ToInt64(rulesdt.Rows[0]["Trans_Id"]) + "' ");
                                                                else
                                                                    SQL_DB.ExecuteNonQuery("UPDATE M_ServiceRules SET WinCodes = '" + DPrize + "' , IsPrize = 0 WHERE Trans_Id = '" + Convert.ToInt64(rulesdt.Rows[0]["Trans_Id"]) + "' ");
                                                                SQL_DB.ExecuteNonQuery("UPDATE M_ServicePrize SET DistributeCount = '" + dpr + "' WHERE (SST_Id = '" + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + "') AND (Gift_Id = '" + GiftArr[1] + "') ");
                                                                #region Get Message
                                                                DataView dv = MsgTempdt.DefaultView;
                                                                dv.RowFilter = "MsgType = 1";
                                                                DataTable fdt = dv.ToTable();
                                                                #endregion
                                                                #region Create Msg Templete
                                                                if (IsCoupons == 1)
                                                                {
                                                                    if (Msg != "")
                                                                        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<GIFTNAME>", GiftArr[0].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                    else
                                                                        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<GIFTNAME>", GiftName.ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                }
                                                                else
                                                                {
                                                                    Coupondt.Reset();
                                                                    Coupondt = SQL_DB.ExecuteDataTable("SELECT TOP(1) CouponTrans_ID, Price, CONVERT(VARCHAR,ValidFrom,103) AS ValidFrom, CONVERT(VARCHAR,ValidTo,103) AS ValidTo,CouponCode FROM M_CouponCodes where Coupon_ID='" + infinitedt.Rows[0]["Gift_Id"].ToString() + "' AND SST_ID = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " AND ISNULL(IsDistributed,0) = 0 ");
                                                                    if (Coupondt.Rows.Count > 0)
                                                                    {
                                                                        if (Msg != "")
                                                                            Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<VALIDFROM>", Coupondt.Rows[0]["ValidFrom"].ToString()).Replace("<TILLDT>", Coupondt.Rows[0]["ValidTo"].ToString()).Replace("<GIFTNAME>", Coupondt.Rows[0]["Price"].ToString()).Replace("<COUPONCODE>", Coupondt.Rows[0]["CouponCode"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                        else
                                                                            Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<VALIDFROM>", Coupondt.Rows[0]["ValidFrom"].ToString()).Replace("<TILLDT>", Coupondt.Rows[0]["ValidTo"].ToString()).Replace("<GIFTNAME>", Coupondt.Rows[0]["Price"].ToString()).Replace("<COUPONCODE>", Coupondt.Rows[0]["CouponCode"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                        SQL_DB.ExecuteNonQuery("UPDATE M_CouponCodes SET IsDistributed = 1 WHERE CouponTrans_ID = " + Convert.ToInt64(Coupondt.Rows[0]["CouponTrans_ID"]));
                                                                    }
                                                                }
                                                                #endregion
                                                            }
                                                            catch (Exception ex)
                                                            {
                                                                return "false*" + ex.Message.ToString();
                                                            }
                                                        }
                                                        else
                                                        {
                                                            #region Get Message
                                                            DataView dv = MsgTempdt.DefaultView;
                                                            dv.RowFilter = "MsgType = 4";
                                                            DataTable fdt = dv.ToTable();
                                                            #endregion
                                                            if (Msg != "")
                                                                Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                            else
                                                                Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                        }
                                                        #endregion
                                                    }
                                                    #region Commented Code for Infinite and Probelity
                                                    /*
                                                    if (DPrize < TPrize)
                                                    {
                                                        #region
                                                        prizedt = SQL_DB.ExecuteDataSet("SELECT TOP(1) Trans_Id, SST_Id, PrizeTrans_Id, Gift_Id, GiftName, GiftCount,DistributeCount FROM M_ServicePrize WHERE SST_Id = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " AND  (GiftCount > DistributeCount) ORDER BY NEWID() ").Tables[0];
                                                        if (prizedt.Rows.Count > 0)                                                        
                                                        {
                                                            dpr = Convert.ToInt64(prizedt.Rows[0]["DistributeCount"]);
                                                            string p = "INSERT INTO [T_GiftDistribution] ([Comp_ID],[Pro_ID],[SST_Id],[Code1],[Code2],[MobileNo],[Prize],[EntryDate],[IsUsed],[IsSMS],[IsDelivery]) VALUES " +
                                                                    " ('" + CompId + "','" + ProId + "','" + SSTID + "','" + Code1 + "','" + Code2 + "','" + MobileNo + "','" + prizedt.Rows[0]["GiftName"].ToString() + "' ,'" + Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "',1,0,0) ";
                                                            try
                                                            {
                                                                SQL_DB.ExecuteNonQuery(p);
                                                                DPrize++; dpr++;
                                                                if (Frequency == -1)
                                                                    SQL_DB.ExecuteNonQuery("UPDATE M_ServiceRules SET WinCodes = '" + DPrize + "' WHERE Trans_Id = '" + Convert.ToInt64(rulesdt.Rows[0]["Trans_Id"]) + "' ");
                                                                else
                                                                    SQL_DB.ExecuteNonQuery("UPDATE M_ServiceRules SET WinCodes = '" + DPrize + "' , IsPrize = 0 WHERE Trans_Id = '" + Convert.ToInt64(rulesdt.Rows[0]["Trans_Id"]) + "' ");
                                                                SQL_DB.ExecuteNonQuery("UPDATE M_ServicePrize SET DistributeCount = '" + dpr + "' WHERE Trans_Id = '" + Convert.ToInt64(prizedt.Rows[0]["Trans_Id"]) + "' ");
                                                                if (infinitedt.Rows.Count == 0)
                                                                {
                                                                    if (TPrize == DPrize)
                                                                        SQL_DB.ExecuteNonQuery("UPDATE M_ServiceSubscriptionTrans SET IsActive = 0 WHERE SST_Id = '" + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + "' ");
                                                                }
                                                                #region Get Message
                                                                DataView dv = MsgTempdt.DefaultView;
                                                                dv.RowFilter = "MsgType = 1";
                                                                DataTable fdt = dv.ToTable();
                                                                #endregion
                                                                #region Create Templete
                                                                if (IsCoupons == 1)
                                                                {
                                                                    if (Msg != "")
                                                                        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<GIFTNAME>", prizedt.Rows[0]["GiftName"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                    else
                                                                        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<GIFTNAME>", prizedt.Rows[0]["GiftName"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                }
                                                                else
                                                                {
                                                                    Coupondt.Reset();
                                                                    Coupondt = SQL_DB.ExecuteDataTable("SELECT TOP(1) CouponTrans_ID, Price, CONVERT(VARCHAR,ValidFrom,103) AS ValidFrom, CONVERT(VARCHAR,ValidTo,103) AS ValidTo,CouponCode FROM M_CouponCodes where Coupon_ID='" + prizedt.Rows[0]["Gift_Id"].ToString() + "' AND SST_ID = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " AND ISNULL(IsDistributed,0) = 0 ");
                                                                    if (Coupondt.Rows.Count > 0)
                                                                    {
                                                                        if (Msg != "")
                                                                            Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<VALIDFROM>", Coupondt.Rows[0]["ValidFrom"].ToString()).Replace("<TILLDT>", Coupondt.Rows[0]["ValidTo"].ToString()).Replace("<GIFTNAME>", Coupondt.Rows[0]["Price"].ToString()).Replace("<COUPONCODE>", Coupondt.Rows[0]["CouponCode"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                        else
                                                                            Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<VALIDFROM>", Coupondt.Rows[0]["ValidFrom"].ToString()).Replace("<TILLDT>", Coupondt.Rows[0]["ValidTo"].ToString()).Replace("<GIFTNAME>", Coupondt.Rows[0]["Price"].ToString()).Replace("<COUPONCODE>", Coupondt.Rows[0]["CouponCode"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                        SQL_DB.ExecuteNonQuery("UPDATE M_CouponCodes SET IsDistributed = 1 WHERE CouponTrans_ID = " + Convert.ToInt64(Coupondt.Rows[0]["CouponTrans_ID"]));
                                                                    }
                                                                }
                                                                #endregion
                                                            }
                                                            catch (Exception ex)
                                                            {
                                                                return "false*" + ex.Message.ToString();
                                                            }
                                                        }
                                                        #endregion
                                                    }
                                                    else
                                                    {
                                                        #region
                                                        if (infinitedt.Rows.Count > 0)
                                                        {
                                                            string p = "INSERT INTO [T_GiftDistribution] ([Comp_ID],[Pro_ID],[SST_Id],[Code1],[Code2],[MobileNo],[Prize],[EntryDate],[IsUsed],[IsSMS],[IsDelivery]) VALUES " +
                                                                " ('" + CompId + "','" + ProId + "','" + SSTID + "','" + Code1 + "','" + Code2 + "','" + MobileNo + "','" + infinitedt.Rows[0]["GiftName"].ToString() + "' ,'" + Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "',1,0,0) ";
                                                            try
                                                            {
                                                                SQL_DB.ExecuteNonQuery(p);
                                                                DPrize++;
                                                                if (Frequency == -1)
                                                                    SQL_DB.ExecuteNonQuery("UPDATE M_ServiceRules SET WinCodes = '" + DPrize + "' WHERE Trans_Id = '" + Convert.ToInt64(rulesdt.Rows[0]["Trans_Id"]) + "' ");
                                                                else
                                                                    SQL_DB.ExecuteNonQuery("UPDATE M_ServiceRules SET WinCodes = '" + DPrize + "' , IsPrize = 0 WHERE Trans_Id = '" + Convert.ToInt64(rulesdt.Rows[0]["Trans_Id"]) + "' ");
                                                                #region Get Message
                                                                DataView dv = MsgTempdt.DefaultView;
                                                                dv.RowFilter = "MsgType = 1";
                                                                DataTable fdt = dv.ToTable();
                                                                #endregion
                                                                #region Create Msg Templete
                                                                if (IsCoupons == 1)
                                                                {
                                                                    if (Msg != "")
                                                                        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<GIFTNAME>", infinitedt.Rows[0]["GiftName"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                    else
                                                                        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<GIFTNAME>", infinitedt.Rows[0]["GiftName"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                }
                                                                else
                                                                {
                                                                    Coupondt.Reset();
                                                                    Coupondt = SQL_DB.ExecuteDataTable("SELECT TOP(1) CouponTrans_ID, Price, CONVERT(VARCHAR,ValidFrom,103) AS ValidFrom, CONVERT(VARCHAR,ValidTo,103) AS ValidTo,CouponCode FROM M_CouponCodes where Coupon_ID='" + infinitedt.Rows[0]["Gift_Id"].ToString() + "' AND SST_ID = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " AND ISNULL(IsDistributed,0) = 0 ");
                                                                    if (Coupondt.Rows.Count > 0)
                                                                    {
                                                                        if (Msg != "")
                                                                            Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<VALIDFROM>", Coupondt.Rows[0]["ValidFrom"].ToString()).Replace("<TILLDT>", Coupondt.Rows[0]["ValidTo"].ToString()).Replace("<GIFTNAME>", Coupondt.Rows[0]["Price"].ToString()).Replace("<COUPONCODE>", Coupondt.Rows[0]["CouponCode"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                        else
                                                                            Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<VALIDFROM>", Coupondt.Rows[0]["ValidFrom"].ToString()).Replace("<TILLDT>", Coupondt.Rows[0]["ValidTo"].ToString()).Replace("<GIFTNAME>", Coupondt.Rows[0]["Price"].ToString()).Replace("<COUPONCODE>", Coupondt.Rows[0]["CouponCode"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                        SQL_DB.ExecuteNonQuery("UPDATE M_CouponCodes SET IsDistributed = 1 WHERE CouponTrans_ID = " + Convert.ToInt64(Coupondt.Rows[0]["CouponTrans_ID"]));
                                                                    }
                                                                }
                                                                #endregion
                                                            }
                                                            catch (Exception ex)
                                                            {
                                                                return "false*" + ex.Message.ToString();
                                                            }
                                                        }
                                                        else
                                                        {
                                                            #region Get Message
                                                            DataView dv = MsgTempdt.DefaultView;
                                                            dv.RowFilter = "MsgType = 4";
                                                            DataTable fdt = dv.ToTable();
                                                            #endregion
                                                            if (Msg != "")
                                                                Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                            else
                                                                Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                        #endregion
                                                    }*/
                                                    #endregion
                                                    #endregion
                                                }
                                                else if (rulesdt.Rows[0]["DistributionType"].ToString() == RwdDistrubutionRules.Sequence.ToString())
                                                {
                                                    infinitedt = SQL_DB.ExecuteDataSet("SELECT Trans_Id, SST_Id, PrizeTrans_Id, Gift_Id, GiftName, GiftCount, DistributeCount FROM M_ServicePrize WHERE SST_Id = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " AND GiftCount = 0 ").Tables[0];
                                                    // checking for only infinite is exist
                                                    if (infinitedt.Rows.Count > 0)
                                                        TPrize = DPrize + 1;
                                                    #region Logic for Sequence Rewards Distributions
                                                    if (DPrize < TPrize)
                                                    {
                                                        #region Sequence rewards distributions
                                                        string Qry = "";
                                                        if(infinitedt.Rows.Count > 0)
                                                            Qry = "SELECT TOP(1) Trans_Id, SST_Id, PrizeTrans_Id, Gift_Id, GiftName, GiftCount,DistributeCount FROM M_ServicePrize WHERE SST_Id = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " AND  ((GiftCount > DistributeCount) OR (GiftCount = 0)) ORDER BY Trans_Id ";
                                                        else
                                                            Qry = "SELECT TOP(1) Trans_Id, SST_Id, PrizeTrans_Id, Gift_Id, GiftName, GiftCount,DistributeCount FROM M_ServicePrize WHERE SST_Id = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " AND  (GiftCount > DistributeCount) ORDER BY Trans_Id ";
                                                        prizedt = SQL_DB.ExecuteDataSet(Qry).Tables[0];
                                                        if (prizedt.Rows.Count > 0)
                                                        {
                                                            dpr = Convert.ToInt64(prizedt.Rows[0]["DistributeCount"]);
                                                            string p = "INSERT INTO [T_GiftDistribution] ([Comp_ID],[Pro_ID],[SST_Id],[Code1],[Code2],[MobileNo],[Prize],[EntryDate],[IsUsed],[IsSMS],[IsDelivery]) VALUES " +
                                                                    " ('" + CompId + "','" + ProId + "','" + SSTID + "','" + Code1 + "','" + Code2 + "','" + MobileNo + "','" + prizedt.Rows[0]["GiftName"].ToString() + "' ,'" + Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "',1,0,0) ";
                                                            try
                                                            {
                                                                SQL_DB.ExecuteNonQuery(p);
                                                                DPrize++; dpr++;
                                                                if (Frequency == -1)
                                                                    SQL_DB.ExecuteNonQuery("UPDATE M_ServiceRules SET WinCodes = '" + DPrize + "' WHERE Trans_Id = '" + Convert.ToInt64(rulesdt.Rows[0]["Trans_Id"]) + "' ");
                                                                else
                                                                    SQL_DB.ExecuteNonQuery("UPDATE M_ServiceRules SET WinCodes = '" + DPrize + "' , IsPrize = 0 WHERE Trans_Id = '" + Convert.ToInt64(rulesdt.Rows[0]["Trans_Id"]) + "' ");
                                                                SQL_DB.ExecuteNonQuery("UPDATE M_ServicePrize SET DistributeCount = '" + dpr + "' WHERE Trans_Id = '" + Convert.ToInt64(prizedt.Rows[0]["Trans_Id"]) + "' ");
                                                                if (infinitedt.Rows.Count == 0)
                                                                {
                                                                    if (TPrize == DPrize)
                                                                        SQL_DB.ExecuteNonQuery("UPDATE M_ServiceSubscriptionTrans SET IsActive = 0 WHERE SST_Id = '" + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + "' ");
                                                                }
                                                                #region Get Message
                                                                DataView dv = MsgTempdt.DefaultView;
                                                                dv.RowFilter = "MsgType = 1";
                                                                DataTable fdt = dv.ToTable();
                                                                #endregion
                                                                //Msg = " You won Prize " + prizedt.Rows[0]["GiftName"].ToString();
                                                                if (Msg != "")
                                                                    Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<GIFTNAME>", prizedt.Rows[0]["GiftName"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                else
                                                                    Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<GIFTNAME>", prizedt.Rows[0]["GiftName"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                            }
                                                            catch (Exception ex)
                                                            {
                                                                return "false*" + ex.Message.ToString();
                                                            }
                                                        }
                                                        #endregion
                                                    }
                                                    #endregion
                                                }
                                            }
                                            else if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.RandomNCustomer.ToString())
                                            {
                                                #region Random Distributions for Instants
                                                Int64 RowID = Convert.ToInt64(ds.Tables[0].Rows[0]["Row_ID"].ToString());
                                                DataTable rprizedt = SQL_DB.ExecuteDataSet("SELECT Trans_Id, Row_Id, SST_Id, Prize as GiftName, IsUsed FROM  M_RandomPrize WHERE Row_Id ='" + RowID + "' AND IsUsed = 0 ").Tables[0];
                                                if (rprizedt.Rows.Count > 0)
                                                {
                                                    string p = "INSERT INTO [T_GiftDistribution] ([Comp_ID],[Pro_ID],[SST_Id],[Code1],[Code2],[MobileNo],[Prize],[EntryDate],[IsUsed],[IsSMS],[IsDelivery]) VALUES " +
                                                                " ('" + CompId + "','" + ProId + "','" + SSTID + "','" + Code1 + "','" + Code2 + "','" + MobileNo + "','" + rprizedt.Rows[0]["GiftName"].ToString() + "' ,'" + Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "',1,0,0) ";
                                                    try
                                                    {
                                                        SQL_DB.ExecuteNonQuery(p);
                                                        DPrize++; dpr++;
                                                        SQL_DB.ExecuteNonQuery("UPDATE M_ServiceRules SET WinCodes = '" + DPrize + "' WHERE Trans_Id = '" + Convert.ToInt64(rulesdt.Rows[0]["Trans_Id"]) + "' ");
                                                        SQL_DB.ExecuteNonQuery("UPDATE M_RandomPrize SET IsUsed = 1 WHERE Trans_Id = '" + Convert.ToInt64(rprizedt.Rows[0]["Trans_Id"]) + "' ");
                                                        if (TPrize == DPrize)
                                                            SQL_DB.ExecuteNonQuery("UPDATE M_ServiceSubscriptionTrans SET IsActive = 0 WHERE SST_Id = '" + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + "' ");
                                                        #region Get Message
                                                        DataView dv = MsgTempdt.DefaultView;
                                                        dv.RowFilter = "MsgType = 1";
                                                        DataTable fdt = dv.ToTable();
                                                        #endregion
                                                        #region Create Msg templete
                                                        if (IsCoupons == 1)
                                                        {
                                                            if (Msg != "")
                                                                Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<GIFTNAME>", rprizedt.Rows[0]["GiftName"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                            else
                                                                Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<GIFTNAME>", rprizedt.Rows[0]["GiftName"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                        }
                                                        else
                                                        {
                                                            Coupondt.Reset();
                                                            Coupondt = SQL_DB.ExecuteDataTable("SELECT TOP(1) CouponTrans_ID, Price, CONVERT(VARCHAR,ValidFrom,103) AS ValidFrom, CONVERT(VARCHAR,ValidTo,103) AS ValidTo FROM M_CouponCodes where CouponCode='" + rprizedt.Rows[0]["GiftName"].ToString() + "' AND SST_ID = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " AND ISNULL(IsDistributed,0) = 0 ");
                                                            if (Coupondt.Rows.Count > 0)
                                                            {
                                                                if (Msg != "")
                                                                    Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<VALIDFROM>", Coupondt.Rows[0]["ValidFrom"].ToString()).Replace("<TILLDT>", Coupondt.Rows[0]["ValidTo"].ToString()).Replace("<GIFTNAME>", Coupondt.Rows[0]["Price"].ToString()).Replace("<COUPONCODE>", rprizedt.Rows[0]["GiftName"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                else
                                                                    Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<VALIDFROM>", Coupondt.Rows[0]["ValidFrom"].ToString()).Replace("<TILLDT>", Coupondt.Rows[0]["ValidTo"].ToString()).Replace("<GIFTNAME>", Coupondt.Rows[0]["Price"].ToString()).Replace("<COUPONCODE>", rprizedt.Rows[0]["GiftName"].ToString()).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                                SQL_DB.ExecuteNonQuery("UPDATE M_CouponCodes SET IsDistributed = 1 WHERE CouponTrans_ID = " + Convert.ToInt64(Coupondt.Rows[0]["CouponTrans_ID"]));
                                                            }
                                                        }
                                                        SQL_DB.ExecuteNonQuery("UPDATE M_RandomPrize SET IsUsed = 1 WHERE Row_Id ='" + RowID + "' ");
                                                        #endregion

                                                    }
                                                    catch (Exception ex)
                                                    {
                                                        return "false*" + ex.Message.ToString();
                                                    }
                                                }
                                                else
                                                {
                                                    #region Get Message
                                                    DataView dv = MsgTempdt.DefaultView;
                                                    dv.RowFilter = "MsgType = 4";
                                                    DataTable fdt = dv.ToTable();
                                                    #endregion
                                                    if (Msg != "")
                                                        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString()); //" Hard luck, please try next time.";
                                                    else
                                                        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString()); //" Hard luck, please try next time.";
                                                    SQL_DB.ExecuteNonQuery("UPDATE M_ServiceRules SET IsPrize = " + IsPrize + "  WHERE SST_Id = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " ");
                                                }
                                                #endregion
                                            }
                                            #endregion
                                        }
                                        else if (rulesdt.Rows[0]["ServiceType"].ToString() == ServiceTypes.DueDate.ToString())
                                        {
                                            #region Get Message templete
                                            MsgTempdt.Reset();
                                            Reg.TempleteHead = ServiceId;
                                            Reg.SubHeadId = "DUEDATE";
                                            MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
                                            #endregion
                                            string p = "INSERT INTO [T_GiftDistribution] ([Comp_ID],[Pro_ID],[SST_Id],[Code1],[Code2],[MobileNo],[Prize],[EntryDate],[IsUsed],[IsSMS],[IsDelivery]) VALUES " +
                                                                " ('" + CompId + "','" + ProId + "','" + SSTID + "','" + Code1 + "','" + Code2 + "','" + MobileNo + "','' ,'" + Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "',0,0,0) ";
                                            try
                                            {
                                                SQL_DB.ExecuteNonQuery(p);
                                                #region Get Message
                                                DataView dv = MsgTempdt.DefaultView;
                                                dv.RowFilter = "MsgType = 1";
                                                DataTable fdt = dv.ToTable();
                                                #endregion
                                                if (Msg != "")
                                                    Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<DRDT>", Convert.ToDateTime(sdt.Rows[s]["DateTo"]).AddDays(1).ToString("MMM dd yyyy")).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                else
                                                    Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<DRDT>", Convert.ToDateTime(sdt.Rows[s]["DateTo"]).AddDays(1).ToString("MMM dd yyyy")).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                            }
                                            catch (Exception ex)
                                            {
                                                return "false*" + ex.Message.ToString();
                                            }
                                        }
                                    }
                                    #endregion

                                    #endregion
                                }
                                #region Commented Code for All ready Checked
                                //else
                                //{
                                //    #region All ready checked Code or Reapted code
                                //    Reg.Is_Success = 0;
                                //    UpdateTransactions(Reg, false);
                                //    #region Get Message
                                //    DataView dv = MsgTempdt.DefaultView;
                                //    dv.RowFilter = "MsgType = 2";
                                //    DataTable fdt = dv.ToTable();
                                //    #endregion
                                //    if (Msg != "")
                                //        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                //    else
                                //        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                //    #endregion
                                //}
                                #endregion
                                #endregion
                            }
                            else if (IsPoints == 0)
                            {
                                #region for Build Loyalty
                                #region Get Message templete
                                MsgTempdt.Reset();
                                Reg.TempleteHead = ServiceId;
                                Reg.SubHeadId = "";
                                MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
                                #endregion
                                if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
                                {
                                    #region first time code checked
                                    Reg.Is_Success = 1;
                                    UpdateTransactions(Reg, true);
                                    if (Msg != "")
                                        Msg += "@" + GetMyMessage(MobileNo, Reg.Received_Code1, Reg.Received_Code2, Reg.Mode_Detail, ProId, SubscribeId, CompId, MsgTempdt, dsres);
                                    else
                                        Msg = GetMyMessage(MobileNo, Reg.Received_Code1, Reg.Received_Code2, Reg.Mode_Detail, ProId, SubscribeId, CompId, MsgTempdt, dsres);
                                    #endregion
                                }
                                #region Commented Code for All ready Checked
                                //else
                                //{
                                //    #region All ready checked Code or Reapted code
                                //    Reg.Is_Success = 0;
                                //    UpdateTransactions(Reg, false);
                                //    #region Get Message
                                //    DataView dv = MsgTempdt.DefaultView;
                                //    dv.RowFilter = "MsgType = 2";
                                //    DataTable fdt = dv.ToTable();
                                //    #endregion
                                //    if (Msg != "")
                                //        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                //    else
                                //        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                //    #endregion
                                //}
                                #endregion
                                #endregion
                            }
                            else if (IsNotify == 0)
                            {
                                #region for Run surveys services
                                if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
                                {
                                    #region First time code check
                                    Reg.Is_Success = 1;
                                    UpdateTransactions(Reg, true);
                                    #region Get Message
                                    DataView dv = MsgTempdt.DefaultView;
                                    dv.RowFilter = "MsgType = 1";
                                    DataTable fdt = dv.ToTable();
                                    #endregion
                                    if (Msg != "")
                                        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<PROID>", Reg.Pro_ID).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                    else
                                        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<PROID>", Reg.Pro_ID).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                    #endregion
                                }
                                #region Commented Code for All ready Checked
                                //else
                                //{
                                //    #region All ready checked Code or Reapted code
                                //    Reg.Is_Success = 0;
                                //    UpdateTransactions(Reg, false);
                                //    #region Get Message
                                //    DataView dv = MsgTempdt.DefaultView;
                                //    dv.RowFilter = "MsgType = 2";
                                //    DataTable fdt = dv.ToTable();
                                //    #endregion
                                //    if (Msg != "")
                                //        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                //    else
                                //        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                //    #endregion
                                //}
                                #endregion
                                #endregion
                            }
                            else if (IsCash == 0)
                            {
                                #region for cash transfer services
                                if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
                                {
                                    // Integrate Cash Transfer Api
                                    Int64 ActFrequency = 0, Frequency = 0;
                                    ActFrequency = Convert.ToInt32(sdt.Rows[s]["Frequency"]);
                                    DataTable frdt = SQL_DB.ExecuteDataTable("SELECT ISNULL(COUNT(User_ID),0) as Cnt FROM T_Cash WHERE IsUsed = 0 AND User_ID = '" + ConsumerId + "'");
                                    if (frdt.Rows.Count > 0)
                                        Frequency = Convert.ToInt64(frdt.Rows[0]["Cnt"]);
                                    Frequency++;
                                    Int64 CashAmt = Convert.ToInt64(sdt.Rows[s]["Cash"]);
                                    Int64 WinCashAmt = 0; string NextVal = "";
                                    #region first time code check
                                    Reg.Is_Success = 1;
                                    UpdateTransactions(Reg, true);
                                    if (ActFrequency == Frequency)
                                        WinCashAmt = CashAmt;
                                    else
                                        WinCashAmt = 0;
                                    try
                                    {
                                        SQL_DB.ExecuteNonQuery("INSERT INTO [T_Cash] ([Comp_ID],[Pro_ID],[User_ID],[MobileNo],[Code1],[Code2],[IsCash],[Entry_Date],[Mode],[IsUsed]) VALUES " +
                                        " ('" + CompId + "','" + ProId + "','" + ConsumerId + "','" + MobileNo + "','" + Reg.Received_Code1 + "','" + Reg.Received_Code2 + "','" + WinCashAmt + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "','" + Dial_Mode + "',0)");
                                        if (WinCashAmt > 0)
                                        {
                                            SQL_DB.ExecuteNonQuery("UPDATE [T_Cash] SET IsUsed = 1 WHERE IsUsed = 0 AND User_ID = '" + ConsumerId + "'");
                                            NextVal = GetNext(Convert.ToInt32(ActFrequency));
                                        }
                                        else
                                            NextVal = GetNext(Convert.ToInt32(ActFrequency - Frequency));
                                    }
                                    catch (Exception ex)
                                    {
                                        throw ex;
                                    }
                                    #region Get Message
                                    DataView dv = MsgTempdt.DefaultView;
                                    dv.RowFilter = "MsgType = 1";
                                    DataTable fdt = dv.ToTable();
                                    #endregion
                                    if (Msg != "")
                                        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<RS>", sdt.Rows[s]["Cash"].ToString()).Replace("<MOBILE>", MobileNo.Substring(2, 10)).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                    else
                                        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<RS>", sdt.Rows[s]["Cash"].ToString()).Replace("<MOBILE>", MobileNo.Substring(2, 10)).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());

                                    // Add New SMS Templete for thsi cash transfer service

                                    #endregion
                                }
                                #region Commented Code for All ready Checked
                                //else
                                //{
                                //    #region All ready checked Code or Reapted code
                                //    Reg.Is_Success = 0;
                                //    UpdateTransactions(Reg, false);
                                //    #region Get Message
                                //    DataView dv = MsgTempdt.DefaultView;
                                //    dv.RowFilter = "MsgType = 2";
                                //    DataTable fdt = dv.ToTable();
                                //    #endregion
                                //    if (Msg != "")
                                //        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                //    else
                                //        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                //    #endregion
                                //}
                                #endregion
                                #endregion
                            }
                            else if (IsReferralValue == 0)
                            {
                                #region Referrals
                                DataView dv = new DataView();
                                DataTable fdt = new DataTable();
                                #region Checking for Referral Rewards
                                if (ReferralCode != "")
                                {
                                    DataTable rdt = SQL_DB.ExecuteDataTable("SELECT User_ID,MobileNo FROM M_Consumer WHERE (ReferralCode = '" + ReferralCode + "')");
                                    if (rdt.Rows.Count > 0)
                                    {
                                        RefConsumerId = rdt.Rows[0]["User_ID"].ToString();
                                        RefMobileNo = rdt.Rows[0]["MobileNo"].ToString();
                                    }
                                }
                                #endregion

                                #region New Code
                                DataTable rdetdt = SQL_DB.ExecuteDataTable("SELECT PointsReferral, PointsUsers, IsCashReferral, IsCashUsers, IsCashConvert, GiftReferral,(SELECT GiftName FROM M_Gift WHERE Gift_ID= T_CouponsTrans.GiftReferral) GiftReferrals, GiftUsers,(SELECT GiftName FROM M_Gift WHERE Gift_ID= T_CouponsTrans.GiftUsers) GiftUser, Frequency FROM  T_CouponsTrans WHERE SST_Id = " + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + " ");
                                if (rdetdt.Rows.Count > 0)
                                {
                                    if (ReferralCode != "")
                                    {
                                        if (IsReferral == 1) // For Cash is set to rewards
                                        {
                                            #region Code for Cash in Referrals
                                            MsgTempdt.Reset();
                                            Reg.TempleteHead = ServiceId;
                                            Reg.SubHeadId = "CASH";
                                            MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
                                            if (CheckUseReferral(ConsumerId, ReferralCode))
                                            {
                                                try
                                                {
                                                    #region Insert Transaction from Cash
                                                    SQL_DB.ExecuteNonQuery("INSERT INTO [T_Cash] ([Comp_ID],[Pro_ID],[User_ID],[MobileNo],[Code1],[Code2],[IsCash],[Entry_Date],[Mode],[ReferralCode]) VALUES " +
                                                    " ('" + CompId + "','" + ProId + "','" + RefConsumerId + "','" + RefMobileNo + "','" + Reg.Received_Code1 + "','" + Reg.Received_Code2 + "','" + rdetdt.Rows[s]["IsCashReferral"].ToString() + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "','" + Dial_Mode + "','" + ReferralCode + "')");
                                                    SQL_DB.ExecuteNonQuery("INSERT INTO [T_Cash] ([Comp_ID],[Pro_ID],[User_ID],[MobileNo],[Code1],[Code2],[IsCash],[Entry_Date],[Mode],[ReferralCode]) VALUES " +
                                                    " ('" + CompId + "','" + ProId + "','" + ConsumerId + "','" + MobileNo + "','" + Reg.Received_Code1 + "','" + Reg.Received_Code2 + "','" + rdetdt.Rows[s]["IsCashUsers"].ToString() + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "','" + Dial_Mode + "','" + ReferralCode + "')");
                                                    #endregion
                                                    #region Get Message
                                                    dv = new DataView();
                                                    dv = MsgTempdt.DefaultView;
                                                    dv.RowFilter = "MsgType = 1";
                                                    fdt = new DataTable();
                                                    fdt = dv.ToTable();
                                                    #endregion

                                                    if (Msg != "")
                                                        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<RS>", rdetdt.Rows[0]["IsCashUsers"].ToString()).Replace("<MOBILE>", MobileNo.Substring(2, 10)).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                    else
                                                        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<RS>", rdetdt.Rows[0]["IsCashUsers"].ToString()).Replace("<MOBILE>", MobileNo.Substring(2, 10)).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                    //// This code is use for referrals
                                                    //if (Msg != "")
                                                    //    Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<RS>", rdetdt.Rows[0]["IsCashReferral"].ToString()).Replace("<MOBILE>", RefMobileNo.Substring(2, 10)).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                    //else
                                                    //    Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<RS>", rdetdt.Rows[0]["IsCashReferral"].ToString()).Replace("<MOBILE>", RefMobileNo.Substring(2, 10)).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                }
                                                catch (Exception ex)
                                                {
                                                    throw ex;
                                                }
                                            }
                                            else
                                            {
                                                #region All ready checked Code or Reapted code
                                                #region Get Message
                                                dv = new DataView();
                                                dv = MsgTempdt.DefaultView;
                                                dv.RowFilter = "MsgType = 2";
                                                fdt = new DataTable();
                                                fdt = dv.ToTable();
                                                #endregion
                                                if (Msg != "")
                                                    Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<REFCODE>>", ReferralCode).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                else
                                                    Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<REFCODE>", ReferralCode).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                #endregion
                                            }
                                            #endregion
                                        }
                                        else if (IsReferral == 2)  // For Points is set to rewards
                                        {
                                            #region Code for Points in Referrals
                                            if (CheckUseReferral(ConsumerId, ReferralCode))
                                            {
                                                try
                                                {
                                                    #region Insert Points in Transactions
                                                    Loyalty_Points Opt = new Loyalty_Points();
                                                    Opt.IsReferral = 1;
                                                    Opt.IsConvertCash = Convert.ToInt32(rdetdt.Rows[s]["IsCashConvert"]);
                                                    Opt.Comp_ID = CompId;
                                                    Opt.Pro_ID = ProId;
                                                    Opt.User_ID = RefConsumerId;
                                                    Opt.MobileNo = RefMobileNo;
                                                    Opt.Code1 = Convert.ToInt64(Code1);
                                                    Opt.Code2 = Convert.ToInt64(Code2);
                                                    Opt.Mode = Reg.Mode_Detail;
                                                    Opt.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
                                                    Opt.EarnType = "Earn";
                                                    Opt.DML = "I";
                                                    Opt.Points = Convert.ToInt64(rdetdt.Rows[s]["PointsReferral"]);
                                                    Loyalty_Points.InsertUpdatePoints(Opt);
                                                    Opt.User_ID = ConsumerId;
                                                    Opt.MobileNo = MobileNo;
                                                    Opt.Points = Convert.ToInt64(rdetdt.Rows[s]["PointsUsers"]);
                                                    Loyalty_Points.InsertUpdatePoints(Opt);
                                                    #endregion
                                                    #region Get Message
                                                    dv = new DataView();
                                                    dv = MsgTempdt.DefaultView;
                                                    dv.RowFilter = "MsgType = 1";
                                                    fdt = new DataTable();
                                                    fdt = dv.ToTable();
                                                    #endregion
                                                    if (Msg != "")
                                                        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<WONPTS>", rdetdt.Rows[0]["PointsUsers"].ToString()).Replace("<PTS>", rdetdt.Rows[0]["PointsUsers"].ToString()).Replace("<NEXT>", "EVERY").Replace("<CODE1>", Code1).Replace("<CODE2>", Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                    else
                                                        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<WONPTS>", rdetdt.Rows[0]["PointsUsers"].ToString()).Replace("<PTS>", rdetdt.Rows[0]["PointsUsers"].ToString()).Replace("<NEXT>", "EVERY").Replace("<CODE1>", Code1).Replace("<CODE2>", Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                    //// This code is use for referrals
                                                    //if (Msg != "")
                                                    //    Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<WONPTS>", rdetdt.Rows[0]["PointsReferral"].ToString()).Replace("<PTS>", rdetdt.Rows[0]["PointsUsers"].ToString()).Replace("<NEXT>", "EVERY").Replace("<CODE1>", Code1).Replace("<CODE2>", Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                    //else
                                                    //    Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<WONPTS>", rdetdt.Rows[0]["PointsReferral"].ToString()).Replace("<PTS>", rdetdt.Rows[0]["PointsUsers"].ToString()).Replace("<NEXT>", "EVERY").Replace("<CODE1>", Code1).Replace("<CODE2>", Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                }
                                                catch (Exception ex)
                                                {
                                                    throw ex;
                                                }
                                            }
                                            else
                                            {
                                                #region All ready checked Code or Reapted code
                                                #region Get Message
                                                dv = new DataView();
                                                dv = MsgTempdt.DefaultView;
                                                dv.RowFilter = "MsgType = 2";
                                                fdt = new DataTable();
                                                fdt = dv.ToTable();
                                                #endregion
                                                if (Msg != "")
                                                    Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<REFCODE>>", ReferralCode).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                else
                                                    Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<REFCODE>", ReferralCode).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                #endregion
                                            }
                                            #endregion
                                        }
                                        else if (IsReferral == 3)  // For Gift is set to rewards
                                        {
                                            #region Code for Gift in Referrals
                                            #region Get Message templete
                                            MsgTempdt.Reset();
                                            Reg.TempleteHead = ServiceId;
                                            Reg.SubHeadId = "GIFT";
                                            MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
                                            #endregion
                                            try
                                            {
                                                if (ReferralUsed(MobileNo, ReferralCode))
                                                {
                                                    string p = "INSERT INTO [T_GiftDistribution] ([Comp_ID],[Pro_ID],[SST_Id],[Code1],[Code2],[MobileNo],[Prize],[EntryDate],[IsUsed],[IsSMS],[IsDelivery],[ReferralCode]) VALUES " +
                                                                    " ('" + CompId + "','" + ProId + "','" + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + "','" + Code1 + "','" + Code2 + "','" + MobileNo + "','" + rdetdt.Rows[0]["GiftUser"].ToString() + "' ,'" + Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "',0,0,0,'" + ReferralCode + "') ";
                                                    SQL_DB.ExecuteNonQuery(p);
                                                    p = "INSERT INTO [T_GiftDistribution] ([Comp_ID],[Pro_ID],[SST_Id],[Code1],[Code2],[MobileNo],[Prize],[EntryDate],[IsUsed],[IsSMS],[IsDelivery],[ReferralCode]) VALUES " +
                                                                    " ('" + CompId + "','" + ProId + "','" + Convert.ToInt64(sdt.Rows[s]["SST_Id"]) + "','" + Code1 + "','" + Code2 + "','" + RefMobileNo + "','" + rdetdt.Rows[0]["GiftReferrals"].ToString() + "' ,'" + Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "',0,0,0,'" + ReferralCode + "') ";
                                                    SQL_DB.ExecuteNonQuery(p);
                                                    #region Get Message
                                                    dv = new DataView();
                                                    dv = MsgTempdt.DefaultView;
                                                    dv.RowFilter = "MsgType = 1";
                                                    fdt = new DataTable();
                                                    fdt = dv.ToTable();
                                                    #endregion
                                                    if (Msg != "")
                                                        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<GIFTNAME>", rdetdt.Rows[0]["GiftUser"].ToString()).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                    else
                                                        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<GIFTNAME>", rdetdt.Rows[0]["GiftUser"].ToString()).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                    ////code for main referrals
                                                    //if (Msg != "")
                                                    //    Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<GIFTNAME>", rdetdt.Rows[0]["GiftReferrals"].ToString()).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                    //else
                                                    //    Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<GIFTNAME>", rdetdt.Rows[0]["GiftReferrals"].ToString()).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                }
                                                else
                                                {
                                                    #region All ready checked Code or Reapted code
                                                    #region Get Message
                                                    dv = new DataView();
                                                    dv = MsgTempdt.DefaultView;
                                                    dv.RowFilter = "MsgType = 2";
                                                    fdt = new DataTable();
                                                    fdt = dv.ToTable();
                                                    #endregion
                                                    if (Msg != "")
                                                        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<REFCODE>>", ReferralCode).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                    else
                                                        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<REFCODE>", ReferralCode).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                    #endregion
                                                }
                                            }
                                            catch (Exception ex)
                                            {
                                                throw ex;
                                            }
                                            #endregion
                                        }
                                    }
                                }
                                #endregion

                                #region Code for Referral
                                DataTable cdt = SQL_DB.ExecuteDataTable("SELECT * FROM [M_Consumer] WHERE [User_ID] = '" + ConsumerId + "' AND ISNULL(ReferralCode,'') <> '' ");
                                if (cdt.Rows.Count == 0)
                                {
                                POP:
                                    string RefCode = getRandomNumber();
                                    if (CheckReferralCode(RefCode))
                                        goto POP;
                                    SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [ReferralCode] = '" + RefCode + "' WHERE [User_ID] = '" + ConsumerId + "'");
                                    MsgTempdt.Reset();
                                    Reg.TempleteHead = ServiceId;
                                    Reg.SubHeadId = "REFERRAL";
                                    MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
                                    #region Get Message
                                    dv = new DataView();
                                    dv = MsgTempdt.DefaultView;
                                    dv.RowFilter = "MsgType = 1";
                                    fdt = new DataTable();
                                    fdt = dv.ToTable();
                                    #endregion
                                    if (Msg != "")
                                        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<LUCKYCODE>", RefCode);
                                    else
                                        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<LUCKYCODE>", RefCode);
                                }
                                #endregion

                                #endregion
                            }
                            else
                            {
                                #region for cash transfer services
                                if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
                                {
                                    Reg.Is_Success = 1;
                                    UpdateTransactions(Reg, true);
                                    #region Get Message
                                    DataView dv = MsgTempdt.DefaultView;
                                    dv.RowFilter = "MsgType = 1";
                                    DataTable fdt = dv.ToTable();
                                    #endregion
                                    if (dsres.Tables[0].Rows[0]["Exp_Date"].ToString() == "01/01/1900")
                                    {
                                        if (Msg != "")
                                            Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<MRP>", dsres.Tables[0].Rows[0]["MRP"].ToString()).Replace("<MFD>", Convert.ToDateTime(dsres.Tables[0].Rows[0]["Mfd_Date"]).ToString("MM/yyyy")).Replace("<BTNO>", dsres.Tables[0].Rows[0]["Batch_No"].ToString()).Replace("<SMS>", dsres.Tables[0].Rows[0]["Comments"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString()).Replace(" EXP<EXP>", "");
                                        else
                                            Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<MRP>", dsres.Tables[0].Rows[0]["MRP"].ToString()).Replace("<MFD>", Convert.ToDateTime(dsres.Tables[0].Rows[0]["Mfd_Date"]).ToString("MM/yyyy")).Replace("<BTNO>", dsres.Tables[0].Rows[0]["Batch_No"].ToString()).Replace("<SMS>", dsres.Tables[0].Rows[0]["Comments"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString()).Replace(" EXP<EXP>", "");
                                        Status = true;
                                        return Status + "*" + Msg;
                                    }
                                    else
                                    {
                                        if (Msg != "")
                                            Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>",
                                                Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<MRP>", 
                                                dsres.Tables[0].Rows[0]["MRP"].ToString()).Replace("<MFD>", Convert.ToDateTime(dsres.Tables[0].Rows[0]["Mfd_Date"]).ToString("MM/yyyy")).
                                                Replace("<EXP>",Convert.ToDateTime(dsres.Tables[0].Rows[0]["Exp_Date"]).ToString("MM/yyyy")).Replace("<BTNO>",
                                                dsres.Tables[0].Rows[0]["Batch_No"].ToString()).Replace("<SMS>", dsres.Tables[0].Rows[0]["Comments"].ToString()).Replace("<CMPNAME>", 
                                                dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                        else
                                            Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<MRP>", dsres.Tables[0].Rows[0]["MRP"].ToString()).Replace("<MFD>", Convert.ToDateTime(dsres.Tables[0].Rows[0]["Mfd_Date"]).ToString("MM/yyyy")).Replace("<EXP>", Convert.ToDateTime(dsres.Tables[0].Rows[0]["Exp_Date"]).ToString("MM/yyyy")).Replace("<BTNO>", dsres.Tables[0].Rows[0]["Batch_No"].ToString()).Replace("<SMS>", dsres.Tables[0].Rows[0]["Comments"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                        Status = true;
                                        return Status + "*" + Msg;
                                    }
                                }
                                #region Commented Code for All ready Checked
                                //else
                                //{
                                //    Reg.Is_Success = 0;
                                //    UpdateTransactions(Reg, false);
                                //    #region All ready checked Code or Reapted code
                                //    #region Get Message
                                //    DataView dv = MsgTempdt.DefaultView;
                                //    dv.RowFilter = "MsgType = 2";
                                //    DataTable fdt = dv.ToTable();
                                //    #endregion
                                //    if (Msg != "")
                                //        Msg += "@" + fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                //    else
                                //        Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                //    #endregion
                                //}
                                #endregion
                                #endregion
                            }
                        }
                        return Status + "*" + Msg;
                    }
                    else
                    {
                        #region If Not service is live
                        MsgTempdt.Reset();
                        Reg.TempleteHead = "EXPIRED";
                        MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
                        Reg.Is_Success = 0;
                        Business9420.function9420.InsertCodeChecked(Reg);
                        Msg = MsgTempdt.Rows[0]["MsgBody"].ToString();
                        Status = false;
                        #endregion
                        return Status + "*" + Msg;
                    }
                    #endregion
                }
                //return Status + "*" + Msg;
            }
            catch (Exception ex)
            {
                return "false*" + ex.Message.ToString();
            }
        }

        private static bool ReferralUsed(string MobileNo, string ReferralCode)
        {
            DataTable dt = SQL_DB.ExecuteDataTable("SELECT Trans_Id FROM T_GiftDistribution WHERE (MobileNo = '" + MobileNo + "') AND (ReferralCode = '" + ReferralCode + "')");
            if (dt.Rows.Count > 0)
                return false;
            else
                return true;
        }
        #endregion

        #region Insert Enquery Detilts & Update M_Code
        public static void UpdateTransactions(Object9420 Reg, bool Update)
        {
            #region Insert & Update Master and Transaction Tables
            if (InsFlag)
            {
                // Insert Code1 & Code2 Enquiry Table
                Business9420.function9420.InsertCodeChecked(Reg);
                // Update UseCount[Checking Flag in M_Code] Code1 & Code2 M_Code Table
                if (Update)
                    Business9420.function9420.UpdateUse_CountM_Code(Reg);
                InsFlag = false;
            }
            #endregion
        }
        #endregion

        #region Get Actual Mobile No + 91
        public static string GetActualMobileNo(string MobileNo)
        {

            #region Find Actual Mobile No
            if (MobileNo.Length < 10)
                return "false * Mobile No. must be 10 digits!";
            if (MobileNo.Length == 11)
            {
                int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                if (initial == 0)
                    MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
                else
                    return "false * Mobile No. Wrong!";
            }
            if (MobileNo.Length == 13)
            {
                SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('13 - " + MobileNo.Length + "')");
                return "true * " + MobileNo;
                //if (initial == 91)
                //{
                //    MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
                //    return "true * 91" + MobileNo;
                //}
                //int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                //if (initial == 0)
                //    MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
                //else
                //    return "false * Mobile No. Wrong!";
            }
            if (MobileNo.Length == 12)
            {
                int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
                if (initial == 91)
                {
                    MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
                    return "true * 91" + MobileNo;
                }
                else
                    return "false * Mobile No. Wrong!";
            }
            if (MobileNo.Length == 10)
            {
                MobileNo = "91" + MobileNo;
                return "true * " + MobileNo;
            }

            else
                return "true * " + MobileNo;
            #endregion
        }
        #endregion

        #region Brand Loyalty Code
        public static string GetMyMessage(string MobileNo, string Code1, string Code2, string Mode, string Pro_ID, string SubscribeId, string CompID, DataTable MsgTempdt, DataSet dsres)
        {
            string UserID = ""; string Msg = ""; string NewMsg = ""; string MyPointMsg = "";
            #region Logic
            DataTable dst = SQL_DB.ExecuteDataSet("SELECT [Points], [DateFrom], [DateTo], [Comments], [Frequency],[IsCashConvert] FROM M_ServiceSubscriptionTrans WHERE Subscribe_Id = '" + SubscribeId + "'  AND IsDelete =0 AND IsActive = 1 ").Tables[0];
            if (dst.Rows.Count > 0)
            {
                DataTable dts = SQL_DB.ExecuteDataSet("SELECT MobileNo,User_ID FROM  M_Consumer WHERE MobileNo = '" + MobileNo + "'").Tables[0];
                UserID = dts.Rows[0]["User_ID"].ToString();
                if (dts.Rows.Count == 0)
                {
                    #region Registration
                    Random rnd = new Random();
                    User_Details Log = new User_Details();
                    Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
                    Log.ConsumerName = null;
                    Log.Email = null;
                    Log.MobileNo = MobileNo;
                    Log.City = null;
                    Log.PinCode = null;
                    Log.Password = rnd.Next(10000, 99999).ToString();
                    Log.IsActive = 0;
                    Log.IsDelete = 0;
                    Log.DML = "I";
                    User_Details.InsertUpdateUserDetails(Log);
                    #endregion
                    UserID = Log.User_ID;
                }
                Msg = dst.Rows[0]["Comments"].ToString() + " " + dst.Rows[0]["Points"].ToString() + " Points";
                NewMsg = dst.Rows[0]["Comments"].ToString(); MyPointMsg = dst.Rows[0]["Points"].ToString();
                #region Entry For Earn Points
                #region Logic For Frequency
                DataTable td = SQL_DB.ExecuteDataSet("SELECT * FROM T_Points WHERE User_ID='" + UserID + "' AND Pro_ID ='" + Pro_ID + "' AND IsUse = 0").Tables[0];
                Int32 Frequency = 0, GetFrequency = 0, AcFrequency = 0; Frequency = Convert.ToInt32(dst.Rows[0]["Frequency"]); AcFrequency = Frequency;
                if (td.Rows.Count > 0)
                    GetFrequency = Convert.ToInt32(td.Rows.Count);
                Frequency = ((Frequency > 1) ? (Frequency - 1) : 1);
                #endregion

                #region Codes
                Loyalty_Points Reg = new Loyalty_Points();
                Reg.User_ID = UserID;
                Reg.MobileNo = MobileNo;
                Reg.Code1 = Convert.ToInt64(Code1);
                Reg.Code2 = Convert.ToInt64(Code2);
                Reg.Mode = Mode;
                Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
                if (dst.Rows.Count > 0)
                {
                    Reg.Comp_ID = CompID; Reg.Pro_ID = Pro_ID;
                    #region New Logic
                    if (dst.Rows.Count > 0)
                    {
                        bool ChkFlag = false;
                        string Dt1 = dst.Rows[0]["DateFrom"].ToString(); string Dt2 = dst.Rows[0]["DateTo"].ToString();
                        if ((Dt1 != "") && (Dt2 != ""))
                        {
                            if ((Convert.ToDateTime(dst.Rows[0]["DateFrom"]) <= Convert.ToDateTime(Reg.Entry_Date)) && (Convert.ToDateTime(dst.Rows[0]["DateTo"]) >= Convert.ToDateTime(Reg.Entry_Date)))
                                ChkFlag = true;
                            else
                                ChkFlag = false;
                        }
                        else if ((Dt1 != "") && (Dt2 == ""))
                            ChkFlag = true;
                        else if ((Dt1 == "") && (Dt2 == ""))
                            ChkFlag = true;
                        ChkFlag = CheckCode1Code2(Code1, Code2);
                        #region Get Message
                        DataView dv = MsgTempdt.DefaultView;
                        dv.RowFilter = "MsgType = 1";
                        DataTable fdt = dv.ToTable();
                        #endregion
                        if (ChkFlag)
                        {
                            if (Frequency > 0)
                            {
                                Reg.Points = (((AcFrequency == 1) || (Frequency == GetFrequency)) ? Convert.ToDecimal(dst.Rows[0]["Points"]) : 0);
                                if (Reg.Points == 0)
                                {
                                    //WON <WONPTS>PTS PROD <PRONAME> <CMPNAME> CODE <CODE1><CODE2> EARN <PTS>PTS ON EVERY <NEXT> PURCHASE TO AVAIL USE WALLET VCQRU BY LOGIN TNX LABEL9420                                    
                                    Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<WONPTS>", Reg.Points.ToString()).Replace("<PTS>", MyPointMsg.ToString()).Replace("<NEXT>", GetNext(Frequency - GetFrequency)).Replace("<CODE1>", Code1).Replace("<CODE2>", Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString()).Replace("EVERY", (AcFrequency > 1 ? GetNext(AcFrequency) : "EVERY"));
                                }
                                else
                                    Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<WONPTS>", Reg.Points.ToString()).Replace("<PTS>", MyPointMsg.ToString()).Replace("<NEXT>", GetNext(Frequency - GetFrequency)).Replace("<CODE1>", Code1).Replace("<CODE2>", Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString()).Replace("EVERY", (AcFrequency > 1 ? GetNext(AcFrequency) : "EVERY"));
                            }
                            else
                            {
                                Reg.Points = Convert.ToDecimal(dst.Rows[0]["Points"]);
                                Msg = fdt.Rows[0]["MsgBody"].ToString().Replace("<WONPTS>", Reg.Points.ToString()).Replace("<PTS>", MyPointMsg.ToString()).Replace("<NEXT>", GetNext(Frequency - GetFrequency)).Replace("<CODE1>", Code1).Replace("<CODE2>", Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                            }
                            Reg.EarnType = "Earn";
                            Reg.DML = "I";
                            Reg.IsCashConvert = Convert.ToInt32(dst.Rows[0]["IsCashConvert"]);
                            try
                            {
                                Loyalty_Points.InsertUpdatePoints(Reg);
                                if (Reg.Points > 0)
                                    SQL_DB.ExecuteDataSet("UPDATE T_Points SET IsUse = 1 WHERE User_ID='" + UserID + "' AND Pro_ID ='" + Pro_ID + "' AND IsUse = 0");
                            }
                            catch (Exception)
                            {

                            }
                        }
                    }
                    #endregion
                }
                #endregion

                #endregion
            }
            #endregion
            return Msg;
        }
        public static string GetNext(Int32 i)
        {
            string Msg = "";
            switch (i)
            {
                case 1:
                    {
                        Msg = "NEXT";
                        break;
                    }
                case 2:
                    {
                        Msg = i.ToString() + "nd";
                        break;
                    }
                case 3:
                    {
                        Msg = i.ToString() + "rd";
                        break;
                    }
                case 4:
                case 5:
                case 6:
                case 7:
                case 8:
                case 9:
                case 10:
                    {
                        Msg = i.ToString() + "th";
                        break;
                    }
                default:
                    {
                        Msg = "EVERY";
                        break;
                    }
            }
            return Msg;
        }
        public static bool CheckCode1Code2(string Code1, string Code2)
        {
            DataTable dt = SQL_DB.ExecuteDataSet("select * from T_Points WHERE Code1= '" + Code1 + "' AND Code2 = '" + Code2 + "' ").Tables[0];
            if (dt.Rows.Count > 0)
                return false;
            else
                return true;
        }
        #endregion

        #region Send SMS
        public static void SendSms(string Message, string phone, string ApiType)
        {

            string str = "";
            try
            {
                //http://sms.bsmart.in:8080/smart/SMSmartSendSMS.jsp?http://sms.bsmart.in:8080/smart/SmartSendSMS.jsp
                //str = "http://sms.bsmart.in:8080/smart/SMSmartSendSMS.jsp?usr=LABEL9420&pass=LABEL890&sid=LBVRFY&GSM=" + phone + "&msg=" + Message + "&mt=0";
                //str = "http://193.105.74.58/api/v3/sendsms/plain?user=LABEL9420&password=Sid2014!&sender=labeld&SMSText=" + Message + "&GSM=" + phone;
                //str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A7285cc769f5ed203e7d8cee48444dbb8&sender=SIDEMO&to=" + phone + "&message=" + Message;

                //str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A3f78a344d70a9e35c006e938f428f591&sender=LBVRFY&to=" + phone + "&message=" + Message;
                if (ApiType == "Solution")
                    str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A3f78a344d70a9e35c006e938f428f591&sender=LBVRFY&to=" + phone + "&message=" + Message;
                else if (ApiType == "BSmart")
                    str = "http://193.105.74.58/api/v3/sendsms/plain?user=LABEL9420&password=Sid2014!&sender=labeld&SMSText=" + Message + "&GSM=" + phone;


                WebRequest request = WebRequest.Create(str);
                request.Method = "POST";
                string postData = "";
                byte[] byteArray = Encoding.UTF8.GetBytes(postData);
                request.ContentType = "application/x-www-form-urlencoded";
                request.ContentLength = byteArray.Length;
                Stream dataStream = request.GetRequestStream();
                dataStream.Write(byteArray, 0, byteArray.Length);
                dataStream.Close();
                WebResponse response = request.GetResponse();
                Console.WriteLine(((HttpWebResponse)response).StatusDescription);
                dataStream = response.GetResponseStream();
                StreamReader reader = new StreamReader(dataStream);
                string responseFromServer = reader.ReadToEnd();
                Console.WriteLine(responseFromServer);
                reader.Close();
                dataStream.Close();
                response.Close();
            }
            catch
            {
            }
        }
        #endregion

        #region Generate Random Number for Referral & Other Fnction for referral
        public static string getRandomNumber()
        {
            string CouponLen = "10";
            string alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            string small_alphabets = "";
            string numbers = "1234567890";

            string characters = numbers;
            characters += alphabets + small_alphabets + numbers;
            int length = int.Parse(CouponLen);
            string otp = string.Empty;
            for (int i = 0; i < length; i++)
            {
                string character = string.Empty;
                do
                {
                    int index = new Random().Next(0, characters.Length);
                    character = characters.ToCharArray()[index].ToString();
                } while (otp.IndexOf(character) != -1);
                otp += character;
            }
            return otp;
        }
        public static bool CheckReferralCode(string RefCode)
        {
            DataTable dt = SQL_DB.ExecuteDataTable("SELECT ReferralCode FROM M_Consumer WHERE (ReferralCode = '" + RefCode + "')");
            if (dt.Rows.Count > 0)
                return true;
            else
                return false;

        }
        public static bool CheckUseReferral(string ConsumerId, string ReferralCode)
        {
            DataTable dt = SQL_DB.ExecuteDataTable("SELECT RowId, Comp_ID, Pro_ID, User_ID, MobileNo, Code1, Code2, IsCash, Entry_Date, Mode, ReferralCode FROM T_Cash WHERE  User_ID = '" + ConsumerId + "' AND ReferralCode = '" + ReferralCode + "' ");
            if (dt.Rows.Count > 0)
                return false;
            else
                return true;
        }
        #endregion
    }
}