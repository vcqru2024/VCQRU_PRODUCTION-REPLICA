
<%@ WebHandler Language="C#" Class="MasterHandler" %>

using System;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using Business9420;
using System.Text.RegularExpressions;
using System.Configuration;
using Business_Logic_Layer;
using System.Net;
using System.Web.SessionState;
using System.Net.Mail;
using DataProvider;
using Newtonsoft.Json;
using WebApplication1;
using System.Web.Script.Serialization;
using System.Collections.Generic;



public class MasterHandler : IHttpHandler, IRequiresSessionState
{
    public static StringBuilder sbnews = new StringBuilder();
    public static string server = Convert.ToString(ConfigurationManager.ConnectionStrings["ServerName"].ConnectionString), userID = Convert.ToString(ConfigurationManager.ConnectionStrings["UserName"].ConnectionString), password = Convert.ToString(ConfigurationManager.ConnectionStrings["Password"].ConnectionString);
    public static string strip = "";
    public static string srt = DataProvider.Utility.FindMailBody();
    public static int otpSendTimes = 3;
    public static string[] allcodes = new string[2];
    public static string FieldSeparator = "<@>";

    public void ProcessRequest(HttpContext context)
    {

        if (context.Request.QueryString["method"] == "GetIP")
        {
            CustomeDraw.Rewards_DataTire.CheckIsActDeAct();
            string result = GetIP();
            context.Response.Write(result);
        }
        if (context.Request.QueryString["method"] == "IFSC")
        {
            string ifsccode = context.Request.QueryString["ifsccode"];
            DataTable table = new DataTable();
            table = SQL_DB.ExecuteDataTable("select * from ifsc where ifsc='" + ifsccode + "'");

            string json = JsonConvert.SerializeObject(table, Formatting.Indented);

            context.Response.Write(json);
        }
        if (context.Request.QueryString["method"] == "Claim")
        {
            DataTable table = new DataTable();
            table = SQL_DB.ExecuteDataTable("select * from Claim_gift");

            string json = JsonConvert.SerializeObject(table, Formatting.Indented);

            context.Response.Write(json);

        }
        if (context.Request.QueryString["method"] == "SubmitClaim")
        {
            message_status messageobject = new message_status();
            try
            {
                string claimdetails = context.Request.QueryString["claimdetails"];
                Claim Log = new Claim();
                Log = JsonConvert.DeserializeObject<Claim>(claimdetails);

                messageobject.status = "Success";
            }
            catch (Exception ex)
            {
                messageobject.status = "Unsuccess";
            }
            context.Response.Write(JsonConvert.SerializeObject(messageobject, Formatting.Indented));
        }
        else if (context.Request.QueryString["method"] == "Issue")
        {
            string Result = string.Empty;
            string Issue = context.Request.QueryString["Issue"];
            string code = context.Request.QueryString["code"];
            string userid = context.Request.QueryString["userid"];

            int issuescount = Convert.ToInt32(SQL_DB.ExecuteScalar("select count([Useid]) from user_issue where [Useid]='" + userid + "' and [Code]=" + code + " and [status]=0"));
            if (issuescount == 0)
            {
                SQL_DB.ExecuteNonQuery("insert into user_issue values('" + userid + "','" + Issue + "','" + System.DateTime.Now.ToString("MM-dd-yyyy HH: mm:ss") + "'," + code + ",0)");

                Result = "Success=Query has been submitted successfully! , our representative will connect with you shortly";
            }
            else
            {

                Result = "Success=Our Team is Working on this! , our representative will connect with you shortly";
            }
            context.Response.Write(Result);

        }
        else if (context.Request.QueryString["method"] == "selectIssue")
        {
            try
            {
                string Result = string.Empty;
                string code = context.Request.QueryString["code"];
                string userid = context.Request.QueryString["userid"];

                int issuescount = Convert.ToInt32(SQL_DB.ExecuteScalar("select count([Useid]) from user_issue where [Useid]='" + userid + "' and [Code]=" + code + " and [status]=0"));
                //message_status msg = new message_status();
                //if (issuescount > 0)
                //    msg.status = "Unsuccess";
                //else
                //{
                //    msg.status = "Success";
                //}
                //Result = JsonConvert.SerializeObject(msg);
                context.Response.Write(issuescount.ToString());
            }
            catch (Exception ex)
            {
                DataProvider.LogManager.ErrorExceptionLog(DateTime.Now.ToLongDateString() + ": Exception at Masterhandler on selectIssue condition" + Environment.NewLine + " Error: " + ex.Message + Environment.NewLine + " Parameter: userid=" + context.Request.QueryString["userid"] + " and code=" + context.Request.QueryString["code"]);
                throw ex;
            }
        }
        else if (context.Request.QueryString["method"] == "Appcodecheck")
        {
            string Encrypt_code = context.Request.QueryString["scan"];
            string mobile = context.Request.QueryString["mobile"];
            string mode;
            if (context.Request.QueryString["mode"] == "")
                mode = "App_mode";
            else
                mode = context.Request.QueryString["mode"];

            if (Encrypt_code.Contains("aspx?id="))
            {
                Encrypt_code = Encrypt_code.Substring(Encrypt_code.IndexOf('?') + 1);
                string result = DecryptCode(Encrypt_code.Split('=')[1]);

                allcodes[0] = result.Substring(result.IndexOf('=') + 1, 5).ToString();
                allcodes[1] = result.Substring(result.LastIndexOf('=') + 1, 8).ToString();

            }
            else
            {
                string[] codes = Encrypt_code.Split(new char[] { '=' });
                if (codes[1].Contains("-"))
                    allcodes = codes[1].Split(new char[] { '-' });
                else
                {
                    allcodes[0] = codes[1].Substring(0, 5);
                    allcodes[1] = codes[1].Substring(5, 8);
                }

            }
            context.Response.Write(appcheckWarranty(allcodes[0], allcodes[1], mobile, mode));
        }
        if (context.Request.QueryString["method"] == "claim")
        {
            string claimdetails = context.Request.QueryString["claimdetails"];
            string result = string.Empty;
            try
            {
                Claim Log = new Claim();
                Log = JsonConvert.DeserializeObject<Claim>(claimdetails);
                result = "Success";
            }
            catch (Exception ex)
            {

            }

            context.Response.Write(result);
        }
        if (context.Request.QueryString["method"] == "update_user")
        {
            string usr_details = context.Request.QueryString["usr_details"];


            try
            {

                User_Details Log = new User_Details();
                Log = JsonConvert.DeserializeObject<User_Details>(usr_details);
                Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));

                string result = string.Empty;
                if (Log.distributorID == null)
                    Log.distributorID = "";
                if (Log.employeeID == null)
                    Log.employeeID = "";
                if (Log.distributorID.Trim() != "" && Log.employeeID.Trim() != "")
                {
                    DataTable dsCheckDealer = SQL_DB.ExecuteDataTable("Select * from M_DealerMaster where replace(ltrim(replace(DealerTechnicianId,'0',' ')),' ','0') ='" + Log.employeeID.Replace("'", "''").TrimStart(new Char[] { '0' }) + "' and replace(ltrim(replace(DealerCode,'0',' ')),' ','0')='" + Log.distributorID.Replace("'", "''").TrimStart(new Char[] { '0' }) + "'");
                    if (dsCheckDealer.Rows.Count > 0)
                    {
                        result = User_Details.appInsertUpdateUserDetails(Log);
                        if (Log.Profile_image == null)
                            Log.Profile_image = "";

                        if (Log.Profile_image != "")
                        {
                            Log.Profile_image = Log.Profile_image.Replace("\"", "").Replace("\\", "");
                            if (Convert.ToInt32(SQL_DB.ExecuteScalar("select count(m_consumerid) from Profile_images where m_consumerid=" + Log.M_Consumerid)) > 0)
                            {
                                SQL_DB.ExecuteScalar("update Profile_images set profile_img='" + Log.Profile_image + "' where m_consumerid=" + Log.Consumer_ID);
                            }
                            else
                            {
                                SQL_DB.ExecuteScalar("insert into Profile_images values(" + Log.Consumer_ID + ",'" + Log.Profile_image + "')");
                            }
                        }
                    }
                    else
                    {
                        message_status msg = new message_status();
                        msg.status = "Error";
                        msg.message = "Technician ID or Dealer Code are not correct!";

                        result = JsonConvert.SerializeObject(msg);

                    }
                }
                else
                {
                    result = User_Details.appInsertUpdateUserDetails(Log);
                    if (Log.Profile_image == null)
                        Log.Profile_image = "";

                    if (Log.Profile_image != "")
                    {
                        if (Convert.ToInt32(SQL_DB.ExecuteScalar("select count(m_consumerid) from Profile_images where m_consumerid=" + Log.M_Consumerid)) > 0)
                        {
                            SQL_DB.ExecuteScalar("update Profile_images set profile_img='" + Log.Profile_image + "' where m_consumerid=" + Log.Consumer_ID);
                        }
                        else
                        {
                            SQL_DB.ExecuteScalar("insert into Profile_images values(" + Log.Consumer_ID + ",'" + Log.Profile_image + "')");
                        }
                    }
                }
                context.Response.Write(result);
            }
            catch (Exception ex)
            {
                DataProvider.LogManager.ErrorExceptionLog(DateTime.Now.ToLongDateString() + ": Exception at Masterhandler on update_user condition" + Environment.NewLine + " Error: " + ex.Message + Environment.NewLine + " Parameter: " + JsonConvert.DeserializeObject<User_Details>(usr_details));
                throw ex;
            }
        }
        if (context.Request.QueryString["method"] == "update_bank")
        {
            string usr_details = context.Request.QueryString["bank_details"];
            Object9420 Log = new Object9420();
            Log = JsonConvert.DeserializeObject<Object9420>(usr_details);

            //Log.DML = "I";
            //Log.Entry_Date=Convert.ToDateTime(Convert.ToDateTime(Log.strEntry_Date).ToString("yyyy/MM/dd hh:mm:ss tt"));
            string result = "";

            result = function9420.appBankInfo(Log);

            context.Response.Write(result);
            // User_Details.InsertUpdateUserDetails(Log);
        }
        if (context.Request.QueryString["method"] == "bankdetails")
        {
            string result = string.Empty;
            string consumer_id = context.Request.QueryString["userid"];
            User_Details Log = new User_Details();
            Log.User_ID = consumer_id;
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            int consumerid = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
            string bnkid = (string)SQL_DB.ExecuteScalar("SELECT top 1 case when [Bank_ID]=null then ' ' else [Bank_ID] end as Bank_ID FROM [M_BankAccount] where [M_Consumerid] = '" + consumerid + "' order by [Entry_Date] desc");
            bank_responses Bnk = new bank_responses();
            Bnk.Bank_ID = bnkid;
            Bnk.M_ConsumeriD = consumerid;
            function9420.GetappBankInfo(Bnk);
            context.Response.Write(JsonConvert.SerializeObject(Bnk, Formatting.Indented));
        }
        else if (context.Request.QueryString["method"] == "Summary")
        {
            string result = string.Empty;
            string consumer_id = context.Request.QueryString["userid"];
            User_Details Log = new User_Details();
            Log.User_ID = consumer_id;
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            int consumerid = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
            DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("[company_service]", Convert.ToInt32(consumerid));
            context.Response.Write(JsonConvert.SerializeObject(dtTrans.Tables[0], Formatting.Indented));

        }

        else if (context.Request.QueryString["method"] == "Dashboard")
        {
            string result = string.Empty;
            string consumer_id = context.Request.QueryString["userid"];
            User_Details Log = new User_Details();
            Log.User_ID = consumer_id;
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            int consumerid = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
            Query_responses query = new Query_responses();
            ///////////////////
            /////////////////////Code Scan/////////////////////
            ///////////////
            DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("dashboarddata", Convert.ToInt32(consumerid));
            DataTable dtrecord = new DataTable();

            query.totalCode = dtTrans.Tables[0].Rows[0][0].ToString();
            query.reedemPoint = dtTrans.Tables[0].Rows[1][0].ToString();
            query.successCode = dtTrans.Tables[0].Rows[2][0].ToString();
            // lblunsuccess.Text = (Convert.ToInt32(lblttlcode.Text) - Convert.ToInt32(lblsuccesscode.Text)).ToString();
            ///////////////////
            //////////////////////point and Cash/////////////////////
            ///////////////
            string loyalty_return = SQL_DB.ExecuteScalar("select isnull(sum(loyalty),0) from scrap_entry se inner join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2 inner join m_consumer ms on ms.MobileNo=pe.MobileNo where pe.Is_Success=1 and ms.M_Consumerid= " + consumerid).ToString();
            dtrecord = SQL_DB.ExecuteDataTable("SELECT case when Sum(convert(int,[Points])) is null then 0 else Sum(convert(int,[Points])) end, case when Sum(convert(int,[Cash])) is null then 0 else Sum(convert(int,[Cash])) end ,Count([Gift]) FROM [BLoyaltyPointsEarned] where [M_Consumerid]= " + consumerid);
            query.totalCash = dtrecord.Rows[0][1].ToString();
            query.transferredCash = dtTrans.Tables[0].Rows[3][0].ToString();
            if (query.transferredCash == "")
                query.transferredCash = "0";


            //lblcashbalance.Text= (Convert.ToInt32(lblcashback.Text) - Convert.ToInt32(lblredeem.Text)).ToString();
            query.totalPoint = (Convert.ToInt32(dtrecord.Rows[0][0].ToString()) - Convert.ToInt32(loyalty_return)).ToString();
            //query.totalPoint = dtrecord.Rows[0][0].ToString();
            //lblpointbalance.Text= (Convert.ToInt32(lblgift.Text) - Convert.ToInt32(lblgiftrec.Text)).ToString();
            dtrecord.Clear();
            ///////////////////
            //////////////////////Warranty count/////////////////////
            ///////////////
            dtrecord = SQL_DB.ExecuteDataTable("select wr.* from [WarrentyDetails] wr inner join [M_consumer] Con on Con.[MobileNo]LIKE CONCAT('%', wr.[Mobile]) where Con.[M_Consumerid]=" + consumerid + "and wr.[Mobile]<>''");
            DataRow[] warranty = dtrecord.Select("PurchaseDate>='" + DateTime.Today.AddYears(-1) + "'");
            query.totalWarranty = dtrecord.Rows.Count.ToString();
            query.underWarranty = warranty.Length.ToString();

            DataSet dtTranscounter = ExecuteNonQueryAndDatatable.FillTransactions("[counterfeitcode]", Convert.ToInt32(consumerid));
            query.totalcounterfeit = dtTranscounter.Tables[0].Rows[0][0].ToString();
            query.successcounterfeit = dtTranscounter.Tables[0].Rows[1][0].ToString();

            context.Response.Write(JsonConvert.SerializeObject(query, Formatting.Indented));
        }
        else if (context.Request.QueryString["method"] == "Transaction")
        {
            string result = string.Empty;
            string consumer_id = context.Request.QueryString["userid"];
            string limit = context.Request.QueryString["limit"];
            User_Details Log = new User_Details();
            Log.User_ID = consumer_id;
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            int consumerid = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);

            ///////////////////
            /////////////////////Code Scan/////////////////////
            ///////////////
            DataTable table = Filldtransaction(limit, consumerid);


            string json = JsonConvert.SerializeObject(table, Formatting.Indented);
            // context.Response.Write(JSONString.ToString());
            context.Response.Write(json);

        }
        else if (context.Request.QueryString["method"] == "subscribe")
        {
            string result = string.Empty;
            string email = context.Request.QueryString["email"];

            if (Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT count(id) FROM dbo.subscribe where email='" + email + "'")) == 0)
            {
                result = SQL_DB.ExecuteNonQuery1("INSERT INTO [dbo].[subscribe] ([email], [status], [createdby],[createddate]) values ('" + email + "',1,'" + email + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "')").ToString();
            }
            else
            {
                result = SQL_DB.ExecuteNonQuery1("update dbo.subscribe set updateddate='" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "' where email='" + email + "'").ToString();
            }
            context.Response.Write(result);

        }

        else if (context.Request.QueryString["method"] == "appchkgenuenity")
        {
            app_details app = new app_details();
            try
            {

                message_status messageobject = new message_status();
                string scaninfo = context.Request.QueryString["ScanInfo"];
                DataProvider.LogManager.ErrorExceptionLog(scaninfo);
                app = JsonConvert.DeserializeObject<app_details>(scaninfo);
                                    string mobile = "91" + app.mobile.Substring(app.mobile.Length - 10, 10);
                string codeone = app.code1;
                string codetwo = app.code2;
                string dealerid = string.Empty;
                string result = string.Empty;
                string paintermobile = string.Empty;
                string mode;
                if (context.Request.QueryString["mode"] == "")
                    mode = "App_mode";
                else
                    mode = context.Request.QueryString["mode"];


                HttpContext.Current.Session["mode"] = mode;
                /////////////////////////////
                ///




                string[] FieldList = app.fields.Split(new string[] { FieldSeparator }, StringSplitOptions.None);
                if (app.CompanyName == "JOHNSON PAINTS CO.")
                {
                    for (int i = 0; i < FieldList.Length; i++)
                    {
                        string[] fieldname = FieldList[i].Split('=');
                        if (fieldname[0] == "Dealer Id")
                        {
                            dealerid = fieldname[1];
                        }
                        if(fieldname[0]=="Painter Mobile")
                        {
                            paintermobile=fieldname[1];
                        }

                    }

                    DataTable dtconsumer = SQL_DB.ExecuteDataTable("select isnull(distributorID,0) distributorID from m_consumer where mobileno='" + mobile + "'");
                    if (dealerid != "")
                    {
                        DataTable dtdealer = SQL_DB.ExecuteDataTable("select DealerCode,D_Status from m_dealermaster where DealerCode='" + dealerid + "'");
                        if (dtdealer.Rows.Count == 0)
                        {
                            messageobject.status = "Error";
                            messageobject.message = "Dealer Id does not exist";
                            messageobject.fields = "Dealer ID";
                        }
                        else if (dtdealer.Rows[0]["D_Status"].ToString() == "1")
                        {
                            messageobject.status = "Error";
                            messageobject.message = "This dealerId already Taken";
                            messageobject.fields = "Dealer ID";
                        }
                        if (dtconsumer.Rows[0]["distributorID"].ToString() != dealerid && dtconsumer.Rows[0]["distributorID"].ToString() != "0")
                        {
                            messageobject.status = "Error";
                            messageobject.message = "Dealer Id not Matched with mobile no.";
                            messageobject.fields = "Dealer ID";
                        }

                    }
                    else
                            dealerid=dtconsumer.Rows[0][0].ToString();

                    result = JsonConvert.SerializeObject(messageobject, Formatting.Indented);
                }




                if(messageobject.message==""||messageobject.message==null)
                {
                    // string mobile = app.mobile;


                    location loc = new location();
                    loc.latitude = app.latitude;
                    loc.longitude = app.longitude;
                    loc.mobileno = mobile.Substring(mobile.Length - 10);
                    loc.code1 = codeone;
                    loc.code2 = codetwo;
                    ExecuteNonQueryAndDatatable.location_update(loc);




                    string email = string.Empty;
                    string purchasedate = string.Empty;
                    string billno = string.Empty;
                    string image = string.Empty;
                    if (mobile != "")
                        if (app.ServiceId == "SRV1023")
                        {
                            // string[] FieldList = app.fields.Split(new string[] { FieldSeparator }, StringSplitOptions.None);
                            string updatefields = string.Empty;
                            for (int i = 0; i < FieldList.Length; i++)
                            {
                                string[] fieldname = FieldList[i].Split('=');
                                if (fieldname[0] == "Email")
                                {
                                    email = fieldname[1];
                                }
                                if (fieldname[0] == "Purchase Date")
                                {
                                    purchasedate = fieldname[1];
                                }
                                if (fieldname[0] == "Bill No")
                                {
                                    billno = fieldname[1];
                                }
                                if (fieldname[0] == "Bill Image")
                                {

                                    image = fieldname[1];
                                }

                            }
                            result = warranrty(email, mobile, purchasedate, codeone + "-" + codetwo, billno, image);

                            messageobject.status = "Success";
                            messageobject.message = result;
                            result = JsonConvert.SerializeObject(messageobject, Formatting.Indented);
                        }
                        else
                        {
                            if (app.CompanyName == "JOHNSON PAINTS CO.")
                                result = appchkgenuenity(codeone, codetwo, paintermobile, app.fields, mode,dealerid);
                            else
                                result = appchkgenuenity(codeone, codetwo, mobile, app.fields, mode);
                        }
                }
                context.Response.Write(result);
            }
            catch (Exception ex)
            {
                DataProvider.LogManager.ErrorExceptionLog(DateTime.Now.ToLongDateString() + ": Exception at Masterhandler on Appchkgeneunity condition" + Environment.NewLine + " Error: " + ex.Message + Environment.NewLine + " Parameter: " + app);
                throw ex;
            }
            // string result = chkgenuenity(codeone, codetwo, mobile);
            // context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "RunSurvey")
        {
            //string company = context.Request.QueryString["company"].ToString();
            //string contactpersion = context.Request.QueryString["contactpersion"].ToString();
            //string email = context.Request.QueryString["email"].ToString();
            //string mobile = context.Request.QueryString["mobile"].ToString();
            //string result = register(company, contactpersion, email, mobile);
            //context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "DispatchGift")
        {
            //string company = context.Request.QueryString["company"].ToString();
            //string contactpersion = context.Request.QueryString["contactpersion"].ToString();
            //string email = context.Request.QueryString["email"].ToString();
            //string mobile = context.Request.QueryString["mobile"].ToString();
            //string result = register(company, contactpersion, email, mobile);
            //context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "register")
        {
            string company = context.Request.QueryString["company"].ToString();
            string contactpersion = context.Request.QueryString["contactpersion"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string mobile = context.Request.QueryString["mobile"].ToString();
            string result = register(company, contactpersion, email, mobile);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "EmployeeRegister")
        {
            string Etype = context.Request.QueryString["Etype"].ToString();
            string Name = context.Request.QueryString["Name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string mobile = context.Request.QueryString["mobile"].ToString();
            string City = context.Request.QueryString["City"].ToString();
            string Pin = context.Request.QueryString["Pin"].ToString();
            string pwd = context.Request.QueryString["pwd"].ToString();
            string result = EmployeeRegister(Etype, Name, email, mobile, City, Pin, pwd);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "DealerRegister")
        {
            string Name = context.Request.QueryString["Name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string mobile = context.Request.QueryString["mobile"].ToString();
            string City = context.Request.QueryString["City"].ToString();
            string Pin = context.Request.QueryString["Pin"].ToString();
            string pwd = context.Request.QueryString["pwd"].ToString();
            string loc = context.Request.QueryString["loc"].ToString();
            string type = context.Request.QueryString["type"].ToString();
            string result = DealerRegister(Name, email, mobile, City, Pin, pwd, loc, type);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "ConsumerRegister")
        {
            string Name = context.Request.QueryString["Name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string mobile = context.Request.QueryString["mobile"].ToString();
            string City = context.Request.QueryString["City"].ToString();
            string Pin = context.Request.QueryString["Pin"].ToString();
            string pwd = context.Request.QueryString["pwd"].ToString();
            string result = ConsumerRegister(Name, email, mobile, City, Pin, pwd);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "demoreegister")
        {
            string company = context.Request.QueryString["company"].ToString();
            string contactpersion = context.Request.QueryString["contactpersion"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string mobile = context.Request.QueryString["mobile"].ToString();
            string result = demoreegister(company, contactpersion, email, mobile);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "CheckEmailid")
        {
            string email = context.Request.QueryString["email"].ToString();
            string result = CheckEmail(email);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "DemoPackeageCode")
        {
            string code = context.Request.QueryString["code"].ToString();
            string result = DemoPackeageCode(code);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "loginEmp")
        {
            string userid = context.Request.QueryString["userid"].ToString();
            string pass = context.Request.QueryString["pass"].ToString();
            string remember = context.Request.QueryString["rememberme"].ToString();
            string result = loginEmp(userid, pass, Convert.ToInt32(remember));
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "login")
        {
            string userid = context.Request.QueryString["userid"].ToString();
            string pass = context.Request.QueryString["pass"].ToString();

            string remember = string.Empty;
            if (context.Request.QueryString["rememberme"] != null)
                remember = context.Request.QueryString["rememberme"].ToString();

            string result = login(userid, pass, Convert.ToInt32(remember));
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "Adminlogin")
        {
            string userid = context.Request.QueryString["userid"].ToString();
            string pass = context.Request.QueryString["pass"].ToString();
            string result = Adminlogin(userid, pass);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "android_userdetails")
        {
            string consumer_id = context.Request.QueryString["userid"];
            User_Details Log = new User_Details();
            Log.User_Type = "Consumer";
            Log.User_ID = consumer_id;
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable table = User_Details.app_GetUserLoginDetails(Log);

            string json = JsonConvert.SerializeObject(table, Formatting.Indented);

            context.Response.Write(json);


        }
        else if (context.Request.QueryString["method"] == "chkmahindra")
        {
            try
            {
                string consumer_id = context.Request.QueryString["userid"];
                string mahindracounts = ExecuteNonQueryAndDatatable.checkmahindra("[appcheckmahindra]", consumer_id);
                //string json = JsonConvert.SerializeObject(mahindracounts, Formatting.Indented);
                message_status msg = new message_status();
                if (mahindracounts != "0")
                    msg.status = "Success";
                else
                {
                    msg.status = "Unsuccess";
                }

                context.Response.Write(JsonConvert.SerializeObject(msg));
            }
            catch (Exception ex)
            {
                DataProvider.LogManager.ErrorExceptionLog(DateTime.Now.ToLongDateString() + ": Exception at Masterhandler on chkmahindra condition" + Environment.NewLine + " Error: " + ex.Message + Environment.NewLine + " Parameter: userid=" + context.Request.QueryString["userid"]);
                throw ex;
            }
        }
        else if (context.Request.QueryString["method"] == "app_userdetails")
        {
            string consumer_id = context.Request.QueryString["userid"];
            User_Details Log = new User_Details();
            Log.User_Type = "Consumer";
            Log.User_ID = consumer_id;
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            string user_id = dt.Rows[0]["User_ID"].ToString();
            string consumerid = dt.Rows[0]["M_consumerid"].ToString();
            string result = string.Empty; ;
            DataSet ds = new DataSet();
            //string qSQL = "SELECT *, isnull(ME.mobilenumber,'NA') MM FROM M_Consumer MC Inner Join MMEMPLOYEE ME ON MC.M_Consumerid = ME.M_Consumerid WHERE MC.[User_ID] = '" + obj.User_ID + "'";
            DataTable ddt = SQL_DB.ExecuteDataSet("SELECT mc.*,MD.[DE_Designation] as Designantion  FROM M_Consumer mc left join M_DealerMaster MD on mc.employeeID=MD.[DealerTechnicianId] and mc.[distributorID]=MD.[DealerCode] WHERE MC.User_ID = '" + user_id + "'").Tables[0];
            //DataTable ddt = SQL_DB.ExecuteDataSet(qSQL).Tables[0];
            if (ddt.Rows.Count > 0)
            {
                try
                {

                    result = ddt.Rows[0]["ConsumerName"].ToString();

                    DataTable img = SQL_DB.ExecuteDataTable("select [Profile_img] from [Profile_images] where [M_consumerid]=" + consumerid);
                    if (img.Rows.Count > 0)
                    {
                        result = result + "=" + img.Rows[0][0].ToString();
                    }
                    //D:\PLESKVHOST\vhosts\vcqru.com\httpdocs\img\aadharFile\1152_AB95_1152AB95-631_0_fee96579-b06d-4915-9ec4-d21845a03d89.pdf
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            else
            {
                string qSQL1 = "SELECT * FROM M_Consumer WHERE [User_ID] = '" + user_id + "'";
                //DataTable ddt = SQL_DB.ExecuteDataSet("SELECT * FROM M_Consumer WHERE User_ID = '" + obj.User_ID + "'").Tables[0];
                DataTable ddt1 = SQL_DB.ExecuteDataSet(qSQL1).Tables[0];
                if (ddt1.Rows.Count > 0)
                {

                    result = ddt1.Rows[0]["ConsumerName"].ToString();
                    DataTable img = SQL_DB.ExecuteDataTable("select [Profile_img] from [Profile_images] where [M_consumerid]=" + consumerid);
                    if (img.Rows.Count > 0)
                    {
                        result = result + "=" + img.Rows[0][0].ToString();
                    }
                }

            }
            context.Response.Write(result);

        }
        else if (context.Request.QueryString["method"] == "consumerlogin")
        {
            string userid = context.Request.QueryString["userid"].ToString();
            string pass = context.Request.QueryString["pass"].ToString();
            //string remember = context.Request.QueryString["rememberme"].ToString();
            string result = consumerlogin(userid, pass, 1);//Convert.ToInt32(remember)
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "Dealerlogin")
        {
            string userid = context.Request.QueryString["userid"].ToString();
            string pass = context.Request.QueryString["pass"].ToString();
            string remember = context.Request.QueryString["remember"].ToString();
            string result = Dealerlogin(userid, pass, Convert.ToInt32(remember));
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "saveinterusted")
        {
            string InterCompNm = context.Request.QueryString["InterCompNm"].ToString();
            string InterEmail = context.Request.QueryString["InterEmail"].ToString();
            string InterUserNm = context.Request.QueryString["InterUserNm"].ToString();
            string InterMobileNo = context.Request.QueryString["InterMobileNo"].ToString();
            string result = saveinterusted(InterCompNm, InterEmail, InterUserNm, InterMobileNo);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "logout")
        {
            int result = logout();
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "forgotpassword")
        {
            string email = context.Request.QueryString["email"].ToString();
            string result = forgotpassword(email);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "forgotpasswordEmp")
        {
            string email = context.Request.QueryString["email"].ToString();
            string result = forgotpasswordEmp(email);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "Consumerforgotpassword")
        {
            string email = context.Request.QueryString["mobile"].ToString();
            string result = Consumerforgotpassword(email);
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "fillnews")
        {
            string result = fillnews();
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "subscribenewsletter")
        {
            string email = context.Request.QueryString["email"].ToString();
            string result = subscribenewsletter(email);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "chkwarranty")
        {
            string code1 = context.Request.QueryString["codeone"];//context.Request.QueryString["email"].ToString();
            string code2 = context.Request.QueryString["codetwo"];
            string result = checkWarranty(code1, code2);

            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "autobrowsesave")
        {
            // string email = context.Request.QueryString["email"].ToString(); //HttpContext.Current.Request.Form["email"];
            string mobile = context.Request.QueryString["mobile"].ToString();//HttpContext.Current.Request.Form["mobile"];
            mobile = "91" + mobile.Substring(mobile.Length - 10);
            //string billno = context.Request.QueryString["billno"].ToString(); //HttpContext.Current.Request.Form["billno"];
            // string purchasedate = context.Request.QueryString["purchasedate"].ToString(); // HttpContext.Current.Request.Form["purchasedate"];
            string purchasedate = DateTime.Today.ToString("MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture); // HttpContext.Current.Request.Form["purchasedate"];
            string code = context.Request.QueryString["code"].ToString();

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
            DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(code);
            DataRow[] servicedetais = dsServicesAssign.Tables[0].Select("Service_id = 'SRV1023'");

            DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            period = servicedetais[0]["WarrantyPeriod"].ToString();
            expDate = purDate.AddMonths(Convert.ToInt32(period));
            //DateTime expDate = purDate.AddYears(1);

            //string strWar = "The Product which you have purchased is Autopark Genuine Product. Product warranty of this product is valid till " + expDate.ToString().Substring(0,10);
            //HttpContext.Current.Session["strWar"] = strWar;
            //}
            //if (HttpContext.Current.Session["strWar"] != null)
            //{

            //    string result = Convert.ToString(HttpContext.Current.Session["strWar"]);
            //    string strMsg = result.ToString().Replace("(", "").Replace(")", "");
            //    context.Response.Write(strMsg);
            //}
            //var fileName = Path.GetFileName(file.FileName);
            //var fileName = Path.GetFileNameWithoutExtension(file.FileName) + "_" + Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
            //path = Path.Combine(context.Server.MapPath("~/WarrantyFile"), fileName);
            //virtualPath = Path.Combine("~/WarrantyFile", fileName);
            //file.SaveAs(path);


            //  }
            //if (context.Request.QueryString["app"] != null)
            //{

            //string xx = HttpContext.Current.Session["strWar"].ToString();
            //if (HttpContext.Current.Session["strWar"] == null)
            //{
            //    DataRow product_details = GetProductName(code);
            //    string prdName = product_details["Pro_name"].ToString();
            //    DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(code);
            //    DataRow[] servicedetais = dsServicesAssign.Tables[0].Select("Service_id = 'SRV1023'");

            //    DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            //    period = servicedetais[0]["WarrantyPeriod"].ToString();
            //    expDate = purDate.AddMonths(Convert.ToInt32(period));
            //    //DateTime expDate = purDate.AddYears(1);

            //    string strWar = "Warranty for the " + prdName +
            //          "has been registered successfully, Warranty validity till " + expDate + " To claim your warranty visit <a href='https://www.vcqru.com/'>https://www.vcqru.com/</a>";
            //    HttpContext.Current.Session["strWar"] = strWar;
            //}
            //if (HttpContext.Current.Session["strWar"] != null)
            //{
            //    string result = Convert.ToString(HttpContext.Current.Session["strWar"]);
            //    string strMsg = result.ToString().Replace("(", "").Replace(")", "");
            //    context.Response.Write(strMsg);
            //}
            //virtualPath = context.Request.QueryString["virtualpath"];
            //}
            SaveWarrentyDetailsforauto(purchasedate, mobile, code, expDate, period);
            //SaveWarrentyDetails(email, billno, purchasedate, mobile, virtualPath, code, expDate, period);
            /////////////////////////////////////////////

            //if (mobile.Length == 10)
            //    mobile = "91" + mobile;

            //DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email],Password FROM [M_Consumer] where [MobileNo] = '" + mobile + "'");
            //if (dcs.Tables[0].Rows.Count > 0)
            //{
            //    string ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
            //    string pass = dcs.Tables[0].Rows[0]["Password"].ToString();
            //    string MailBody = "";
            //    MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
            //                               " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
            //                               " <hr style='border:1px solid #2587D5;'/>" +
            //                               " <div class='w_frame'>" +
            //                               " <p>" +
            //                               " <div class='w_detail'>" +
            //                               " <span>Dear <em><strong> Sir/Mam,</strong></em></span><br />" +
            //                               " <br />" +
            //                               " <span>Warranty registered successfully. Login to https://vcqru.com/default.aspx#logsign  Claim warranty </span><br />" +
            //                               " Your Login Credentials  <br /> <strong> User Id - " + dcs.Tables[0].Rows[0]["MobileNo"].ToString() + "</strong><br /> <strong> Password - " + pass + "</strong>  " +
            //                               "<br /><br /> We will contact you soon.   <br />" +
            //                               " <p>" +
            //                               " <div class='w_detail'>" +
            //                               " Assuring you  of  our best services always.<br />" +
            //                               " Thank you,<br /><br />" +
            //                               " Team <em><strong>VCQRU.COM,</strong></em><br />" +
            //                               "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
            //                               " </div>" +
            //                               " </p>" +
            //                               " </div>" +
            //                               " </p>" +
            //                               " </div> " +
            //                               " </div> ";

            //    DataSet dsMl = function9420.FetchMailDetail("support");
            //    //if (dsMl.Tables[0].Rows.Count > 0)
            //    //{
            //    //    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
            //    //        email, MailBody, "Warranty Registration");

            //    //}
            //}
            ////////////////////////////////////////////////
            // ConsumerRegisterAndEmail(email,mobile,"");
        }
        else if (context.Request.QueryString["method"] == "browsesave")
        {
            string email = context.Request.QueryString["email"].ToString(); //HttpContext.Current.Request.Form["email"];
            string mobile = context.Request.QueryString["mobile"].ToString();//HttpContext.Current.Request.Form["mobile"];
            string billno = context.Request.QueryString["billno"].ToString(); //HttpContext.Current.Request.Form["billno"];
            string purchasedate = context.Request.QueryString["purchasedate"].ToString(); // HttpContext.Current.Request.Form["purchasedate"];
            string code = context.Request.QueryString["code"].ToString();
            mobile = "91" + mobile.Substring(mobile.Length - 10);
            var path = "";
            var virtualPath = "";
            string period = string.Empty;
            DateTime expDate = DateTime.Today;
            // foreach (HttpPostedFile file in context.Request.Files)
            foreach (string key in HttpContext.Current.Request.Files)
            {
                var file = HttpContext.Current.Request.Files[key];
                //if (HttpContext.Current.Session["strWar"] == null)
                //{
                DataRow product_details = GetProductName(code);
                string prdName = product_details["Pro_name"].ToString();
                DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(code);
                DataRow[] servicedetais = dsServicesAssign.Tables[0].Select("Service_id = 'SRV1023'");

                DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                period = servicedetais[0]["WarrantyPeriod"].ToString();
                expDate = purDate.AddMonths(Convert.ToInt32(period));
                //DateTime expDate = purDate.AddYears(1);
                string comp_name = SQL_DB.ExecuteScalar("select comp_name from comp_reg where comp_id='" + servicedetais[0]["Comp_id"].ToString() + "'").ToString();
                string strWar ="";;
                if(comp_name!="Delta Luminaries")
                    strWar = "Warranty for the " + prdName +"has been registered successfully, Warranty validity till " + expDate + " To claim your warranty visit <a href='https://www.vcqru.com/'>https://www.vcqru.com/</a>";
                HttpContext.Current.Session["strWar"] = strWar;
                //  }
                if (HttpContext.Current.Session["strWar"] != null)
                {
                    string result = Convert.ToString(HttpContext.Current.Session["strWar"]);
                    string strMsg = result.ToString().Replace("(", "").Replace(")", "");
                    context.Response.Write(strMsg);
                }
                //var fileName = Path.GetFileName(file.FileName);
                var fileName = Path.GetFileNameWithoutExtension(file.FileName) + "_" + Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                path = Path.Combine(context.Server.MapPath("~/WarrantyFile"), fileName);
                virtualPath = Path.Combine("~/WarrantyFile", fileName);
                file.SaveAs(path);


            }
            if (context.Request.QueryString["app"] != null)
            {
                if (HttpContext.Current.Session["strWar"] == null)
                {
                    DataRow product_details = GetProductName(code);
                    string prdName = product_details["Pro_name"].ToString();
                    DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(code);
                    DataRow[] servicedetais = dsServicesAssign.Tables[0].Select("Service_id = 'SRV1023'");

                    DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                    period = servicedetais[0]["WarrantyPeriod"].ToString();
                    expDate = purDate.AddMonths(Convert.ToInt32(period));
                    //DateTime expDate = purDate.AddYears(1);

                    string strWar = "Warranty for the " + prdName +
                          "has been registered successfully, Warranty validity till " + expDate + " To claim your warranty visit <a href='https://www.vcqru.com/'>https://www.vcqru.com/</a>";
                    HttpContext.Current.Session["strWar"] = strWar;
                }
                if (HttpContext.Current.Session["strWar"] != null)
                {
                    string result = Convert.ToString(HttpContext.Current.Session["strWar"]);
                    string strMsg = result.ToString().Replace("(", "").Replace(")", "");
                    context.Response.Write(strMsg);
                }
                virtualPath = context.Request.QueryString["virtualpath"];
            }

            SaveWarrentyDetails(email, billno, purchasedate, mobile, virtualPath, code, expDate, period);
            /////////////////////////////////////////////

            if (mobile.Length == 10)
                mobile = "91" + mobile;

            DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email],Password FROM [M_Consumer] where [MobileNo] = '" + mobile + "'");
            if (dcs.Tables[0].Rows.Count > 0)
            {
                string ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
                string pass = dcs.Tables[0].Rows[0]["Password"].ToString();
                string MailBody = "";
                MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                                           " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
                                           " <hr style='border:1px solid #2587D5;'/>" +
                                           " <div class='w_frame'>" +
                                           " <p>" +
                                           " <div class='w_detail'>" +
                                           " <span>Dear <em><strong> Sir/Mam,</strong></em></span><br />" +
                                           " <br />" +
                                           " <span>Warranty registered successfully. Login to https://vcqru.com/default.aspx#logsign  Claim warranty </span><br />" +
                                           " Your Login Credentials  <br /> <strong> User Id - " + email + "</strong><br /> <strong> Password - " + pass + "</strong>  " +
                                           "<br /><br /> We will contact you soon.   <br />" +
                                           " <p>" +
                                           " <div class='w_detail'>" +
                                           " Assuring you  of  our best services always.<br />" +
                                           " Thank you,<br /><br />" +
                                           " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                                           "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                                           " </div>" +
                                           " </p>" +
                                           " </div>" +
                                           " </p>" +
                                           " </div> " +
                                           " </div> ";

                DataSet dsMl = function9420.FetchMailDetail("support");
                if (dsMl.Tables[0].Rows.Count > 0)
                {
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
                        email, MailBody, "Warranty Registration");

                }
            }
            ////////////////////////////////////////////////
            // ConsumerRegisterAndEmail(email,mobile,"");
        }
        else if (context.Request.QueryString["method"] == "otpsend")
        {

            string mobileNumber = context.Request.QueryString["mobile"].ToString();
            mobileNumber = mobileNumber.Substring(mobileNumber.Length - 10);
            DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email],Password FROM [M_Consumer] where [MobileNo] like '%" + mobileNumber + "'");

            if (dcs.Tables[0].Rows.Count == 0)
            {
                User_Details user = new User_Details();
                if (mobileNumber.Length == 10)
                    mobileNumber = "91" + mobileNumber;
                user.MobileNo = mobileNumber;
                user.DML = "I";
                user.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy-MM-dd hh:mm:ss.ttt"));
                User_Details.InsertUpdateUserDetails(user);

            }
            int rdmNumber = RandomNumber(1000, 9999);

            string otpMsg = "%3C%23%3E Your Employee verification OTP is " + rdmNumber + " vcqru.com. md5b2lDaeHj";
            //string sendSMSurl = "http://sms.alfasms.in/sendSMS?username=alfasms&message=" + otpMsg + "&sendername=Alfast&smstype=TRANS&numbers=" + mobileNumber + "&apikey=d13cfc39-dae1-4462-8b46-5a2ab78ca5c1";
            //Your password  is " + dt.Rows[0]["Password"].ToString() + " VCQRU.com
            //SendSmsWithAlfa(otpMsg, mobileNumber);
            HttpContext.Current.Session["otpSendTimes"] = 1;

            ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");

            DateTime expDate = System.DateTime.Now.AddYears(1); //purDate.AddYears(1);
                                                                //int otp_counter = Convert.ToInt16(SQL_DB.ExecuteScalar("select count([mobileNumber]) from [dbo].[CompanyProduct] where [mobileNumber]='" + mobileNumber + "'"));
                                                                //if(otp_counter > 0)
                                                                //{
                                                                //    SQL_DB.ExecuteNonQuery("update [dbo].[CompanyProduct] set [expiryDate]='" + expDate.ToString("MM/dd/yyyy") + "', [otp]='" + rdmNumber + "', [status]=0,[mobileNumber]='" + mobileNumber + "'");
                                                                //}
                                                                //else
                                                                //{
            SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[CompanyProduct] ([expiryDate], [otp], [status],[mobileNumber]) values ('" + expDate.ToString("yyyy-MM-dd HH:mm:ss") + "', '" + rdmNumber + "', 0, '" + mobileNumber + "')");
            //}
            context.Response.Write("1," + rdmNumber);

        }
        else if (context.Request.QueryString["method"] == "android_otpsend")
        {

            otp_response otp = new otp_response();

            string mobileNumber = context.Request.QueryString["mobile"].ToString();
            mobileNumber = mobileNumber.Substring(mobileNumber.Length - 10);
            DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email],Password FROM [M_Consumer] where [MobileNo] like '%" + mobileNumber + "'");

            if (dcs.Tables[0].Rows.Count == 0)
            {
                User_Details user = new User_Details();
                Random rnd = new Random();
                user.Password = rnd.Next(10000, 99999).ToString();
                if (mobileNumber.Length == 10)
                    mobileNumber = "91" + mobileNumber;
                user.MobileNo = mobileNumber;
                user.DML = "I";
                user.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy-MM-dd hh:mm:ss.ttt"));
                User_Details.InsertUpdateUserDetails(user);

            }
            int rdmNumber = RandomNumber(1000, 9999);

            string otpMsg = "%3C%23%3E Your Employee verification OTP is " + rdmNumber + " vcqru.com. md5b2lDaeHj";
            //string sendSMSurl = "http://sms.alfasms.in/sendSMS?username=alfasms&message=" + otpMsg + "&sendername=Alfast&smstype=TRANS&numbers=" + mobileNumber + "&apikey=d13cfc39-dae1-4462-8b46-5a2ab78ca5c1";
            //Your password  is " + dt.Rows[0]["Password"].ToString() + " VCQRU.com
            //SendSmsWithAlfa(otpMsg, mobileNumber);
            HttpContext.Current.Session["otpSendTimes"] = 1;

            ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");

            DateTime expDate = System.DateTime.Now.AddYears(1); //purDate.AddYears(1);
                                                                //int otp_counter = Convert.ToInt16(SQL_DB.ExecuteScalar("select count([mobileNumber]) from [dbo].[CompanyProduct] where [mobileNumber]='" + mobileNumber + "'"));
                                                                //if(otp_counter > 0)
                                                                //{
                                                                //    SQL_DB.ExecuteNonQuery("update [dbo].[CompanyProduct] set [expiryDate]='" + expDate.ToString("MM/dd/yyyy") + "', [otp]='" + rdmNumber + "', [status]=0,[mobileNumber]='" + mobileNumber + "'");
                                                                //}
                                                                //else
                                                                //{
            SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[CompanyProduct] ([expiryDate], [otp], [status],[mobileNumber]) values ('" + expDate.ToString("yyyy-MM-dd HH:mm:ss") + "', '" + rdmNumber + "', 0, '" + mobileNumber + "')");
            //}
            otp.success = 1;
            otp.otp = rdmNumber.ToString(); ;
            //context.Response.Write("1," + rdmNumber);

            context.Response.Write(JsonConvert.SerializeObject(otp, Formatting.Indented));

        }
        else if (context.Request.QueryString["method"] == "app_OTPVerify")
        {
            string result;
            string otp = context.Request.QueryString["verifycode"].ToString();
            string mobile = context.Request.QueryString["mobile"].ToString();
            DataSet dsOTPVerify = app_OTPVerify(otp, mobile);
            if (dsOTPVerify.Tables[0].Rows[0][0].ToString() == otp)
            {
                result = "Success";
            }
            else
            {
                result = "Usuccess";
            }
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "web_OTPVerify")
        {
            string result;
            string userid;
            string otp = context.Request.QueryString["verifycode"].ToString();
            string MobileNo = context.Request.QueryString["mobile"].ToString();
            DataSet dsOTPVerify = app_OTPVerify(otp, MobileNo);
            if (dsOTPVerify.Tables[0].Rows[0][0].ToString() == otp)
            {
                User_Details Log = new User_Details();

                Log.DML = "Mobile";
                #region Find Actual Mobile No
                if (MobileNo.Length < 10)
                {
                    result = "Mobile No. must be 10 digits!";

                }
                if (MobileNo.Length == 11)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";

                    }
                }
                if (MobileNo.Length == 13)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";

                    }
                }
                if (MobileNo.Length == 12)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
                    if (initial == 91)
                        MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
                    else
                    {
                        result = "Mobile No. Wrong!";

                    }
                }
                if (MobileNo.Length == 10)
                    MobileNo = "91" + MobileNo;
                #endregion

                Log.User_Type = "Consumer";
                Log.User_ID = MobileNo;
                //Log.Password = pass.Trim().Replace("'", "''");
                DataTable dt = User_Details.app_GetUserLoginDetails(Log);
                if (dt.Rows.Count > 0)
                {
                    //if (remember == 1)
                    //{
                    //    HttpContext.Current.Response.Cookies["ConsumerUserName"].Value = Log.User_ID;
                    //    HttpContext.Current.Response.Cookies["ConsumerPassword"].Value = pass.Trim();
                    //    HttpContext.Current.Response.Cookies["ConsumerUserName"].Expires = DateTime.Now.AddDays(15);
                    //    HttpContext.Current.Response.Cookies["ConsumerPassword"].Expires = DateTime.Now.AddDays(15);

                    //    if (!string.IsNullOrEmpty(dt.Rows[0]["employeeID"].ToString()) && !string.IsNullOrEmpty(dt.Rows[0]["distributorID"].ToString()))
                    //    {
                    //        HttpContext.Current.Session["MMUser"] = "MMUSERR";
                    //    }
                    //    else { HttpContext.Current.Session["MMUser"] = ""; }

                    //    //string sQry = "Select * from M_Consumer Where MobileNo='" + MobileNo + "' and employeeID IS NOT NULL and distributorID IS NOT NULL";
                    //    //DataSet dsConsumer = SQL_DB.ExecuteDataSet(sQry);
                    //    //if (dsConsumer.Tables[0].Rows.Count > 0)
                    //    //{
                    //    //    HttpContext.Current.Session["MMUser"] = "MMUSERR";
                    //    //}
                    //}
                    //else if (remember == 0)
                    //{
                    //    HttpContext.Current.Response.Cookies["ConsumerUserName"].Value = null;
                    //    HttpContext.Current.Response.Cookies["ConsumerPassword"].Value = null;
                    //}
                    //HttpContext.Current.Session["User_Type"] = "Consumer";
                    //HttpContext.Current.Session["USRID"] = dt.Rows[0]["User_ID"].ToString();
                    HttpContext.Current.Session["Consumer_id"] = dt.Rows[0]["m_consumerid"].ToString();
                    ProjectSession.strUser_Type = "Consumer";
                    ProjectSession.strConsumerUserID = dt.Rows[0]["User_ID"].ToString();
                    ProjectSession.intM_ConsumeriD = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
                    if (dt.Rows[0]["ConsumerName"].ToString() != "")
                    {
                        HttpContext.Current.Session["USRNAME"] = dt.Rows[0]["ConsumerName"].ToString();
                        ProjectSession.strConsumerName = dt.Rows[0]["ConsumerName"].ToString();

                    }
                    else
                        HttpContext.Current.Session["USRNAME"] = null;
                    // HttpContext.Current.Session["USRMOBILENO"] = dt.Rows[0]["MobileNo"].ToString();
                    ProjectSession.strMobileNo = dt.Rows[0]["MobileNo"].ToString();
                    result = "Success";// + "~" + dt.Rows[0]["MM"].ToString()
                }
                else
                {
                    result = "Invalid userid or password !";

                }



            }
            else
            {
                result = "Usuccess";
            }
            //if(dsOTPVerify.Tables[0].Rows.Count>0)
            //{
            //    result= "Success";
            //}
            //else
            //{
            //    result= "Usuccess";
            //}
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "billdetails")
        {
            string warrantycode = context.Request.QueryString["code"];
            string code1 = warrantycode.Substring(0, 5);
            string code2 = warrantycode.Substring(5, 8);
            string id = SQL_DB.ExecuteScalar("select top 1 imagepathbill from WarrentyDetails where code='" + code1 + "-" + code2 + "'").ToString();
            context.Response.Write(id);
        }
        else if (context.Request.QueryString["method"] == "imagedetails")
        {
            string warrantycode = context.Request.QueryString["code"];
            string code1 = warrantycode.Substring(0, 5);
            string code2 = warrantycode.Substring(5, 8);
            string id = SQL_DB.ExecuteScalar("select id from WarrentyDetails where code='" + code1 + "-" + code2 + "'").ToString();
            string result = getimagepaths(id);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "updatewarrantydetails")
        {
            string comment = context.Request.QueryString["comment"];//context.Request.QueryString["email"].ToString();
                                                                    // string id = context.Request.QueryString["id"];
            var path = "";
            var virtualPath = "";
            string warrantycode = context.Request.QueryString["code"];
            string code1 = warrantycode.Substring(0, 5);
            string code2 = warrantycode.Substring(5, 8);
            string id = SQL_DB.ExecuteScalar("select id from WarrentyDetails where code='" + code1 + "-" + code2 + "'").ToString();
            // foreach (HttpPostedFile file in context.Request.Files)
            foreach (string key in HttpContext.Current.Request.Files)
            {
                var file = HttpContext.Current.Request.Files[key];
                if (HttpContext.Current.Session["strWar"] == null)
                {
                    string strWar = "Warranty claimed for the product, wait for the vendor  approval.";
                    HttpContext.Current.Session["strWar"] = strWar;
                }
                if (HttpContext.Current.Session["strWar"] != null)
                {
                    string result = Convert.ToString(HttpContext.Current.Session["strWar"]);
                    context.Response.Write(result);
                }
                var fileName = Path.GetFileNameWithoutExtension(file.FileName) + "_" + Guid.NewGuid().ToString() + "." + Path.GetExtension(file.FileName);
                path = Path.Combine(context.Server.MapPath("~/WarrantyFile"), fileName);
                virtualPath = Path.Combine("~/WarrantyFile", fileName);
                file.SaveAs(path);
                InsertFiles("", fileName, "", virtualPath, id);
            }
            UpdateClaimWarrentyDetails(comment, virtualPath, id);
        }

        else if (context.Request.QueryString["method"] == "updatewarranty")
        {
            string comment = context.Request.QueryString["comment"];//context.Request.QueryString["email"].ToString();
            string id = context.Request.QueryString["id"];
            var path = "";
            var virtualPath = "";


            // foreach (HttpPostedFile file in context.Request.Files)
            foreach (string key in HttpContext.Current.Request.Files)
            {
                var file = HttpContext.Current.Request.Files[key];
                if (HttpContext.Current.Session["strWar"] == null)
                {
                    string strWar = "Warranty claimed for the product, wait for the vendor  approval.";
                    HttpContext.Current.Session["strWar"] = strWar;
                }
                if (HttpContext.Current.Session["strWar"] != null)
                {
                    string result = Convert.ToString(HttpContext.Current.Session["strWar"]);
                    context.Response.Write(result);
                }
                var fileName = Path.GetFileNameWithoutExtension(file.FileName) + "_" + Guid.NewGuid().ToString() + "." + Path.GetExtension(file.FileName);
                path = Path.Combine(context.Server.MapPath("~/WarrantyFile"), fileName);
                virtualPath = Path.Combine("~/WarrantyFile", fileName);
                file.SaveAs(path);
                InsertFiles("", fileName, "", virtualPath, id);
            }
            UpdateClaimWarrentyDetails(comment, virtualPath, id);
        }

        else if (context.Request.QueryString["method"] == "updatewarrantyVendor")
        {

            string comment = HttpContext.Current.Request.Form["comment"];//context.Request.QueryString["email"].ToString();
            string id = HttpContext.Current.Request.Form["id"];
            string approveStatus = HttpContext.Current.Request.Form["approveStatus"];

            UpdateClaimWarrentyDetailsVendor(comment, approveStatus, id);
        }

        else if (context.Request.QueryString["method"] == "sendquery")
        {
            string name = context.Request.QueryString["name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string comment = context.Request.QueryString["comment"].ToString();
            string cmobile = context.Request.QueryString["cmobile"].ToString();
            string result = sendquery(name, email, comment, cmobile);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "verifyresetpwd")
        {
            string name = context.Request.QueryString["mlt"].ToString();
            string result = verifyresetpwd(name);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "verifyaccount")
        {
            string name = context.Request.QueryString["key"].ToString();
            string result = verifyaccount(name);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "deleteaccount")
        {
            string result = deleteaccount();
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "setpassword")
        {
            string password = context.Request.QueryString["pwd"].ToString();
            string value = context.Request.QueryString["value"].ToString();
            string result = setpassword(password, value);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "checkconsumer")
        {
            string type = context.Request.QueryString["type"].ToString();
            string value = context.Request.QueryString["value"].ToString();
            string Utype = context.Request.QueryString["Utype"].ToString();
            string result = checkconsumer(type, value, Utype);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "CatchWebsiteHit")
        {
            //  string type = context.Request.QueryString["type"].ToString();
            // string value = context.Request.QueryString["value"].ToString();
            string result = CatchWebsiteHit();
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "DecryptCode")
        {
            //  string type = context.Request.QueryString["type"].ToString();
            // string value = context.Request.QueryString["value"].ToString();
            string name = context.Request.QueryString["id"].ToString();
            string result = DecryptCode(name);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "CheckReferral")
        {
            string c1 = context.Request.QueryString["c1"].ToString();
            string c2 = context.Request.QueryString["c2"].ToString();
            //string name = context.Request.QueryString["id"].ToString();
            string result = CheckReferral(c1, c2);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "CheckReferralExists")
        {
            string refcode = context.Request.QueryString["refcode"].ToString();
            string Mno = context.Request.QueryString["Mno"].ToString();
            //string name = context.Request.QueryString["id"].ToString();
            string result = CheckReferralExists(refcode, Mno);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "savecompany")
        {
            string result = string.Empty;
            string msgReturn = string.Empty;
            string errMsg = string.Empty;
            string errDMsg = string.Empty;

            //PROC_GetMessageTemplete
            string mobileNumber = context.Request.QueryString["mobile"].ToString();
            string MobileNo = mobileNumber;
            if (MobileNo == "")
            {
                result = "Kindly Enter Your Mobile No.";
            }



            if (!isDigits(MobileNo))
            {
                result = "Mobile No. must be numeric only!";
                context.Response.Write(result);
            }
            else
            {
                if (MobileNo.Length < 10)
                {
                    result = "Mobile No. must be 10 digits!";
                }
                if (MobileNo.Length == 11)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";
                    }
                }
                if (MobileNo.Length == 13)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";
                    }
                }
                if (MobileNo.Length == 12)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
                    if (initial == 91)
                        MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
                }
                if (MobileNo.Length == 10)
                    MobileNo = "91" + MobileNo;
                string employeeId = context.Request.QueryString["empId"].ToString();
                string distributorId = context.Request.QueryString["disId"].ToString();
                string cmpCode = context.Request.QueryString["code"].ToString();
                string cmpName = context.Request.QueryString["compName"].ToString();
                string currDateTime = System.DateTime.Now.ToString();

                DataSet dsEmployee = CheckEmployeeDetails(employeeId, distributorId);
                DataSet dsDistributor = CheckDistrbutorDetails(employeeId, distributorId);

                if (dsEmployee.Tables[0].Rows.Count == 0)
                {
                    errMsg = "Please provide a valid Dealer Technician ID / Techmaster ID as given ID " + employeeId + " is wrong.";
                }

                if (dsDistributor.Tables[0].Rows.Count == 0)
                {
                    errDMsg = "Please provide a valid Dealer Code as given code " + distributorId + " is wrong.";
                }

                if (dsEmployee.Tables[0].Rows.Count > 0 && dsDistributor.Tables[0].Rows.Count > 0)
                {
                    int rdmNumber = RandomNumber(1000, 9999);

                    string otpMsg = "%3C%23%3E Your Employee verification OTP is " + rdmNumber + " vcqru.com. md5b2lDaeHj";
                    //string sendSMSurl = "http://sms.alfasms.in/sendSMS?username=alfasms&message=" + otpMsg + "&sendername=Alfast&smstype=TRANS&numbers=" + mobileNumber + "&apikey=d13cfc39-dae1-4462-8b46-5a2ab78ca5c1";
                    //Your password  is " + dt.Rows[0]["Password"].ToString() + " VCQRU.com
                    //SendSmsWithAlfa(otpMsg, mobileNumber);
                    HttpContext.Current.Session["otpSendTimes"] = 1;
                    ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");

                    DataSet ds = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] where [MobileNo] = '91" + mobileNumber + "'");
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        SQL_DB.ExecuteNonQuery("Update M_Consumer set employeeID='" + employeeId + "', distributorID='" + distributorId + "' where MobileNo='91" + mobileNumber + "'");
                    }
                    else
                    {
                        int psw = RandomNumber(1000, 9999);
                        User_Details Log = new User_Details();
                        Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));

                        // Log.Email = "";
                        // email.Trim().Replace("'", "''"); //this is comment is done by shweta

                        Log.MobileNo = "91" + mobileNumber;

                        Log.PinCode = null;
                        Log.Password = psw.ToString();
                        Log.IsActive = 0;
                        Log.IsDelete = 0;
                        Log.MMEmployeID = employeeId;
                        Log.MMDistributorID = distributorId;
                        Log.DML = "I";

                        User_Details.InsertUpdateUserDetails(Log);
                    }

                    DataSet dsPID = ProductID(cmpCode.Split('-')[0], cmpCode.Split('-')[1]);
                    if (dsPID.Tables[0].Rows.Count > 0)
                    {
                        SaveCompanyDetails(cmpName, dsPID.Tables[0].Rows[0]["Pro_ID"].ToString(), currDateTime, employeeId, distributorId, cmpCode, rdmNumber, mobileNumber);
                    }

                    msgReturn = "success";
                }
                else
                {
                    if (dsEmployee.Tables[0].Rows.Count == 0 && dsDistributor.Tables[0].Rows.Count == 0)
                        msgReturn = errMsg + "<br/>" + errDMsg;
                    else
                        msgReturn = "Failure~" + (!string.IsNullOrEmpty(errMsg) ? errMsg : errDMsg);
                }

                context.Response.Write(msgReturn);
            }
        }
        else if (context.Request.QueryString["method"] == "savecoats")
        {
            string result = string.Empty;
            string msgReturn = string.Empty;
            string errMsg = string.Empty;
            string errDMsg = string.Empty;

            //PROC_GetMessageTemplete
            string mobileNumber = context.Request.QueryString["mobile"].ToString();
            string MobileNo = mobileNumber;
            if (MobileNo == "")
            {
                result = "Kindly Enter Your Mobile No.";
            }



            if (!isDigits(MobileNo))
            {
                result = "Mobile No. must be numeric only!";
                context.Response.Write(result);
            }
            else
            {
                if (MobileNo.Length < 10)
                {
                    result = "Mobile No. must be 10 digits!";
                }
                if (MobileNo.Length == 11)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";
                    }
                }
                if (MobileNo.Length == 13)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";
                    }
                }
                if (MobileNo.Length == 12)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
                    if (initial == 91)
                        MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
                }
                if (MobileNo.Length == 10)
                    MobileNo = "91" + MobileNo;
                if(result==string.Empty)
                {
                    string desgnation = context.Request.QueryString["designation"].ToString();
                    string name = context.Request.QueryString["name"].ToString();
                    string cmpCode = context.Request.QueryString["code"].ToString();
                    string cmpName = context.Request.QueryString["compName"].ToString();
                    string currDateTime = System.DateTime.Now.ToString();

                    //DataSet dsEmployee = CheckEmployeeDetails(employeeId, distributorId);
                    //DataSet dsDistributor = CheckDistrbutorDetails(employeeId, distributorId);

                    //if (dsEmployee.Tables[0].Rows.Count == 0)
                    //{
                    //    errMsg = "Please provide a valid Dealer Technician ID / Techmaster ID as given ID " + employeeId + " is wrong.";
                    //}

                    //if (dsDistributor.Tables[0].Rows.Count == 0)
                    //{
                    //    errDMsg = "Please provide a valid Dealer Code as given code " + distributorId + " is wrong.";
                    //}

                    //if (dsEmployee.Tables[0].Rows.Count > 0 && dsDistributor.Tables[0].Rows.Count > 0)
                    //{
                    int rdmNumber = RandomNumber(1000, 9999);

                    string otpMsg = "%3C%23%3E Your Employee verification OTP is " + rdmNumber + " vcqru.com. md5b2lDaeHj";
                    //string sendSMSurl = "http://sms.alfasms.in/sendSMS?username=alfasms&message=" + otpMsg + "&sendername=Alfast&smstype=TRANS&numbers=" + mobileNumber + "&apikey=d13cfc39-dae1-4462-8b46-5a2ab78ca5c1";
                    //Your password  is " + dt.Rows[0]["Password"].ToString() + " VCQRU.com
                    //SendSmsWithAlfa(otpMsg, mobileNumber);
                    HttpContext.Current.Session["otpSendTimes"] = 1;
                    ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");

                    DataSet ds = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] where [MobileNo] = '91" + mobileNumber + "'");
                    //if (ds.Tables[0].Rows.Count > 0)
                    //{
                    //    SQL_DB.ExecuteNonQuery("Update M_Consumer set employeeID='" + employeeId + "', distributorID='" + distributorId + "' where MobileNo='91" + mobileNumber + "'");
                    //}
                    //else
                    //{
                    int psw = RandomNumber(1000, 9999);
                    User_Details Log = new User_Details();
                    Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));

                    // Log.Email = "";
                    // email.Trim().Replace("'", "''"); //this is comment is done by shweta

                    Log.MobileNo = "91" + mobileNumber;

                    Log.PinCode = null;
                    Log.Password = psw.ToString();
                    Log.IsActive = 0;
                    Log.IsDelete = 0;
                    Log.ConsumerName = name;
                    Log.DML = "I";

                    User_Details.InsertUpdateUserDetails(Log);
                    // }

                    DataSet dsPID = ProductID(cmpCode.Split('-')[0], cmpCode.Split('-')[1]);
                    if (dsPID.Tables[0].Rows.Count > 0)
                    {
                        SaveCompanyDetails(cmpName, dsPID.Tables[0].Rows[0]["Pro_ID"].ToString(), currDateTime, "", "", cmpCode, rdmNumber, mobileNumber);
                    }

                    msgReturn = "success";
                }
                else
                {

                    msgReturn = "Failure~" + result;
                }

                context.Response.Write(msgReturn);
            }
        }
        else if (context.Request.QueryString["method"] == "savedecore")
        {
            string result = string.Empty;
            string msgReturn = string.Empty;
            string errMsg = string.Empty;
            string errDMsg = string.Empty;
            string dealermobile = string.Empty;
            string dealerid=string.Empty;;
            //PROC_GetMessageTemplete
            string mobileNumber = context.Request.QueryString["mobile"].ToString();
            string cmpName = context.Request.QueryString["compName"].ToString();
            dealermobile =context.Request.QueryString["dealermobile"].ToString();
            dealerid=context.Request.QueryString["dealerid"].ToString();
            string MobileNo = mobileNumber;
            if (cmpName == "JOHNSON PAINTS CO.")
            {
                if (dealermobile == "")
                {
                    result = "Kindly Enter Dealer Mobile No.";
                }

                if (!isDigits(dealermobile))
                {
                    result = "Dealer Mobile No. must be numeric only!";
                    context.Response.Write(result);
                }
                else
                {
                    if (dealermobile.Length < 10)
                    {
                        result = "Dealer Mobile No. must be 10 digits!";
                    }
                    if (dealermobile.Length == 11)
                    {
                        int initial = Convert.ToInt32(dealermobile.Substring(0, 1));
                        if (initial == 0)
                            dealermobile = "91" + dealermobile.Substring(1, dealermobile.Length - 1);
                        else
                        {
                            result = "dealer Mobile No. Wrong!";
                        }
                    }
                    if (dealermobile.Length == 13)
                    {
                        int initial = Convert.ToInt32(dealermobile.Substring(0, 1));
                        if (initial == 0)
                            dealermobile = dealermobile.Substring(1, dealermobile.Length - 1);
                        else
                        {
                            result = "dealer Mobile No. Wrong!";
                        }
                    }
                    if (dealermobile.Length == 12)
                    {
                        int initial = Convert.ToInt32(dealermobile.Substring(0, 2));
                        if (initial == 91)
                            dealermobile = dealermobile.Substring(2, dealermobile.Length - 2);
                    }
                    if (dealermobile.Length == 10)
                        dealermobile = "91" + dealermobile;

                    DataTable dtconsumer = SQL_DB.ExecuteDataTable("select mobileno, isnull(distributorID,0) distributorID from m_consumer where mobileno='" + dealermobile + "'");
                    DataTable dtdealer = SQL_DB.ExecuteDataTable("select DealerCode,D_Status from m_dealermaster where DealerCode='" + dealerid + "'");
                    if (dtconsumer.Rows.Count != 0)
                    {


                        if (dtconsumer.Rows[0]["distributorID"].ToString() != dealerid && dtconsumer.Rows[0]["distributorID"].ToString() != "0")
                        {
                            result = "Dealer Id not Matched with mobile no.";
                        }
                        else if (dtdealer.Rows.Count == 0)
                        {
                            result = "Dealer Id does not exist";
                        }

                    }
                    else
                    {

                        if (dtdealer.Rows.Count == 0)
                        {
                            result = "Dealer Id does not exist";
                        }
                        else if (dtdealer.Rows[0]["D_Status"].ToString() == "1")
                        {
                            result = "This dealerId already Taken";
                        }
                    }

                }

            }
            if (MobileNo == "")
            {
                result =result+Environment.NewLine+"Kindly Enter Your Mobile No.";

            }

            if (!isDigits(MobileNo))
            {
                result = result+Environment.NewLine+"Mobile No. must be numeric only!";
                context.Response.Write(result);
            }
            else
            {
                if (MobileNo.Length < 10)
                {
                    result = result+Environment.NewLine+"Mobile No. must be 10 digits!";
                }
                if (MobileNo.Length == 11)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = result+Environment.NewLine+"Mobile No. Wrong!";
                    }
                }
                if (MobileNo.Length == 13)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = result+Environment.NewLine+"Mobile No. Wrong!";
                    }
                }
                if (MobileNo.Length == 12)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
                    if (initial == 91)
                        MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
                }
                if (MobileNo.Length == 10)
                    MobileNo = "91" + MobileNo;
                if (result == string.Empty)
                {
                    string name = context.Request.QueryString["name"].ToString();
                    string cmpCode = context.Request.QueryString["code"].ToString();

                    string currDateTime = System.DateTime.Now.ToString();


                    int rdmNumber = RandomNumber(1000, 9999);

                    string otpMsg = "%3C%23%3E Your Employee verification OTP is " + rdmNumber + " vcqru.com. md5b2lDaeHj";
                    //string sendSMSurl = "http://sms.alfasms.in/sendSMS?username=alfasms&message=" + otpMsg + "&sendername=Alfast&smstype=TRANS&numbers=" + mobileNumber + "&apikey=d13cfc39-dae1-4462-8b46-5a2ab78ca5c1";
                    //Your password  is " + dt.Rows[0]["Password"].ToString() + " VCQRU.com
                    //SendSmsWithAlfa(otpMsg, mobileNumber);
                    HttpContext.Current.Session["otpSendTimes"] = 1;
                    ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");

                    DataSet ds = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] where [MobileNo] = '" + mobileNumber + "'");
                    DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] where [MobileNo] = '" + dealermobile + "'");
                    if(ds1.Tables[0].Rows.Count==0)
                    {
                        int psw = RandomNumber(1000, 9999);
                        User_Details Log = new User_Details();
                        Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));

                        // Log.Email = "";
                        // email.Trim().Replace("'", "''"); //this is comment is done by shweta

                        Log.MobileNo = dealermobile;

                        Log.PinCode = null;
                        Log.Password = psw.ToString();
                        Log.IsActive = 0;
                        Log.IsDelete = 0;
                        //Log.ConsumerName = name;
                        Log.DML = "I";
                        Log.MMDistributorID = dealerid;
                        //Log.distributorID = dealerid;
                        User_Details.InsertUpdateUserDetails(Log);
                        SQL_DB.ExecuteDataTable("update m_dealermaster set D_Status='1' where DealerCode='" + dealerid + "'");
                        string  msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + dealermobile + " AND PASSWORD IS " + Log.Password + ". Visit www.vcqru.com to complete the user and bank details  or call 9243029420 for customer support.";
                        ServiceLogic.SendSms(msgString, dealermobile);
                    }
                    if(ds.Tables[0].Rows.Count==0)
                    {
                        int psw = RandomNumber(1000, 9999);
                        User_Details Log = new User_Details();
                        Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));

                        // Log.Email = "";
                        // email.Trim().Replace("'", "''"); //this is comment is done by shweta

                        Log.MobileNo =  mobileNumber;

                        Log.PinCode = null;
                        Log.Password = psw.ToString();
                        Log.IsActive = 0;
                        Log.IsDelete = 0;
                        Log.ConsumerName = name;
                        Log.DML = "I";

                        User_Details.InsertUpdateUserDetails(Log);
                        string  msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ".Visit www.vcqru.com for more info OR for any query contact customer care 7669017720. Thanks VCQRU";
                        ServiceLogic.SendSms(msgString, mobileNumber);

                    }

                    DataSet dsPID = ProductID(cmpCode.Split('-')[0], cmpCode.Split('-')[1]);
                    if (dsPID.Tables[0].Rows.Count > 0)
                    {
                        SaveCompanyDetails(cmpName, dsPID.Tables[0].Rows[0]["Pro_ID"].ToString(), currDateTime, "", "", cmpCode, rdmNumber, mobileNumber);
                    }

                    msgReturn = "success";

                }
                else
                {
                    msgReturn = "Failure~" + result;
                }
                context.Response.Write(msgReturn);



            }
        }
        else if (context.Request.QueryString["method"] == "chkgenuenity")
        {
            string codetwo = string.Empty;
            string codeone = context.Request.QueryString["codeone"].ToString();
            string name = string.Empty;
            string city = string.Empty;
            string email = string.Empty;
            string client = string.Empty;
            if (context.Request.QueryString["Client"] != null)
                client = context.Request.QueryString["Client"];


            if (context.Request.QueryString["name"] != null)
                name = context.Request.QueryString["name"].ToString();

            if (codeone.Length == 13)
            {
                codetwo = codeone.Substring(5, 8);
                codeone = codeone.Substring(0, 5);
            }
            else
            {
                codetwo = context.Request.QueryString["codetwo"].ToString();
            }

            if (context.Request.QueryString["mode"] == "Barcode")
            {
                HttpContext.Current.Session["mode"] = "Barcode";
            }
            string mobile = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["mobile"]))
                mobile = context.Request.QueryString["mobile"].ToString();

            string RefCd = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["RefCd"]))
                RefCd = context.Request.QueryString["RefCd"].ToString();
            if (context.Request.QueryString["name"] != null)
                city = context.Request.QueryString["city"].ToString();
            if (context.Request.QueryString["email"] != null)
                email = context.Request.QueryString["email"].ToString();
            string result = string.Empty;
            if (mobile.Length != 0)
                mobile = "91" + mobile.Substring(mobile.Length - 10);
            //location loc = new location();
            //loc.latitude = context.Request.QueryString["lat"];
            //loc.longitude = context.Request.QueryString["long"];
            //loc.mobileno = mobile.Substring(mobile.Length - 10);
            //loc.code1 = codeone;
            //loc.code2 = codetwo;
            //ExecuteNonQueryAndDatatable.location_update(loc);

            if (!string.IsNullOrEmpty(client))
                if (client == "Comp-1206")
                {
                    try
                    {
                        SQL_DB.ExecuteNonQuery("insert into clientTransaction(completeCode,mobileno,username,city,email,comp_id,entrydate) values(" + codeone + codetwo + ",'" + mobile + "','" + name + "','" + city + "','" + email + "','" + client + "','" + DateTime.Now.ToString("yyyy-dd-MM HH:mm:ss.fff") + "')");
                    }
                    catch (Exception ex)
                    {
                        DataProvider.LogManager.ErrorExceptionLog("Location: masterhandler.aspx   " + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "        paramete are : code:" + codeone + codetwo + ", mobile:" + mobile + ", name: " + name + ", city: " + city + ", email: " + email + ",client:" + client);
                    }
                }
            if (mobile != "")
                result = chkgenuenity(codeone, codetwo, mobile, email, RefCd, city, name);

            // string result = chkgenuenity(codeone, codetwo, mobile);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "verifyotp")
        {
            string result = string.Empty;
            string email = "", gCode = "", otp = "";
            string name = null;
            string dealerid = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["dealerid"]))
                dealerid = context.Request.QueryString["dealerid"].ToString();
            if (context.Request.QueryString["mode"] == "Barcode")
            {
                HttpContext.Current.Session["mode"] = "Barcode";
            }

            if (context.Request.QueryString["verifycode"].ToString() == "1234")
                otp = context.Request.QueryString["verifycode"].ToString();
            else
                otp = context.Request.QueryString["verifycode"].ToString();

            if (!string.IsNullOrEmpty(context.Request.QueryString["name"]))
                name = context.Request.QueryString["name"].ToString();


            string mobile = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["mobile"]))
                mobile = context.Request.QueryString["mobile"].ToString();

            string RefCd = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["RefCd"]))
                RefCd = context.Request.QueryString["RefCd"].ToString();

            if (!string.IsNullOrEmpty(context.Request.QueryString["vCode"]))
                gCode = context.Request.QueryString["vCode"].ToString();

            string empId = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["empId"]))
                empId = context.Request.QueryString["empId"].ToString();

            string disId = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["disId"]))
                disId = context.Request.QueryString["disId"].ToString();

            DataSet dsOTPVerify = OTPVerify(otp, mobile, empId, disId);
            if (dsOTPVerify.Tables[0].Rows.Count > 0)
            {
                result = chkgenuenity(gCode.ToString().Split('-')[0], gCode.ToString().Split('-')[1], mobile, email, RefCd, null, name,dealerid);
                //result = chkgenuenity(gCode.ToString().Split('-')[0], gCode.ToString().Split('-')[1], mobile, email, RefCd);
                result = "success~" + result;
            }
            else
            {
                result = "failure";
            }

            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "resendotp")
        {
            string result = string.Empty;
            string mobile = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["mobile"]))
            {
                mobile = context.Request.QueryString["mobile"].ToString();
                int oTimes = Convert.ToInt16(HttpContext.Current.Session["otpSendTimes"].ToString()) + 1;
                if (oTimes <= otpSendTimes)
                {
                    int rdmNumber = RandomNumber(1000, 9999);
                    SQL_DB.ExecuteNonQuery("update [dbo].[CompanyProduct] set otp='" + rdmNumber + "', [status]=0 where mobileNumber='" + mobile + "'");
                    string otpMsg = "%3C%23%3E Your Employee verification OTP is " + rdmNumber + " vcqru.com. md5b2lDaeHj";
                    ServiceLogic.SendSMSFromAlfa(mobile, otpMsg, "OTP");
                    HttpContext.Current.Session["otpSendTimes"] = Convert.ToInt16(HttpContext.Current.Session["otpSendTimes"].ToString()) + 1;
                    result = "success";
                }
                else
                {
                    result = "exceed";
                }
            }
            else
            { result = "failure"; }

            context.Response.Write(result);
        }


    }

    public static string DealerRegister(string Name, string email, string mobile, string City, string Pin, string pwd, string loc, string type)
    {
        string result = "";
        LogManager.WriteExe("Enter");
        string MobileNo = mobile.Trim().Replace("'", "''");
        #region Find Actual Mobile No
        if (MobileNo.Length < 10)
        {
            result = "Mobile No. must be 10 digits!";
            return result;
        }
        if (MobileNo.Length == 11)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
                return result;
            }
        }
        if (MobileNo.Length == 13)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
                return result;
            }
        }
        if (MobileNo.Length == 12)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
            if (initial == 91)
                MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
            else
            {
                result = "Mobile No. Wrong!";
                return result;
            }
        }
        if (MobileNo.Length == 10)
            MobileNo = "91" + MobileNo;
        #endregion
        LogManager.WriteExe("Manage Mobile No.");
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [Dealer] where [Email] = '" + email.Trim().Replace("'", "''") + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            result = "Email ID Already exist!";
            return result;
        }
        LogManager.WriteExe("Checking Email Complite");
        DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT [MobileNo] FROM [Dealer] where [MobileNo] = '" + MobileNo + "'");
        if (ds1.Tables[0].Rows.Count > 0)
        {
            result = "Mobile No. Already exist!";
            return result;
        }
        LogManager.WriteExe("Checking mobile no. Complite");
        User_Details Log = new User_Details();
        Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        Log.ConsumerName = Name.Trim().Replace("'", "''");
        Log.Email = email.Trim().Replace("'", "''");
        Log.MobileNo = MobileNo;
        Log.City = loc.Trim().Replace("'", "''"); //City.Trim().Replace("'", "''");
        Log.PinCode = Pin.Trim().Replace("'", "''");
        Log.Password = pwd.Trim().Replace("'", "''");
        Log.User_Type = type;
        Log.IsActive = 1;
        Log.IsDelete = 0;
        Log.DML = "I";
        SQL_DB.ExecuteNonQuery("insert into Dealer([name],[Email],[mobileno],[pwd],[Location],[Type],[createddate],[active]) " +
            "values ('" + Log.ConsumerName + "','" + Log.Email + "','" + Log.MobileNo + "','" + Log.Password + "','" + Log.City + "'," +
            " " + Log.User_Type + ",'" + System.DateTime.Now.ToString("MM/dd/yyyy") + "'," + Log.IsActive + ")");
        // check is there in db - if mobile no exists then update
        // User_Details.InsertUpdateUserDetails(Log);
        result = "<b>Dear " + Name + "</b><br/>Thanks for registering with us. <br/><br/> <b> Thank you,</b> <br/> Team: VCQRU.COM <br/> " + ProjectSession.sales_accomplishtrades + " ";
        return result;
    }
    public static string ConsumerRegister(string Name, string email, string mobile, string City, string Pin, string pwd)
    {
        string result = "";
        LogManager.WriteExe("Enter");
        string MobileNo = mobile.Trim().Replace("'", "''");
        #region Find Actual Mobile No
        if (MobileNo.Length < 10)
        {
            result = "Mobile No. must be 10 digits!";
            return result;
        }
        if (MobileNo.Length == 11)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
                return result;
            }
        }
        if (MobileNo.Length == 13)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
                return result;
            }
        }
        if (MobileNo.Length == 12)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
            if (initial == 91)
                MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
            else
            {
                result = "Mobile No. Wrong!";
                return result;
            }
        }
        if (MobileNo.Length == 10)
            MobileNo = "91" + MobileNo;
        #endregion
        LogManager.WriteExe("Manage Mobile No.");
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [M_Consumer] where [Email] = '" + email.Trim().Replace("'", "''") + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            result = "Email ID Already exist!";
            return result;
        }
        LogManager.WriteExe("Checking Email Complite");
        DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT [MobileNo] FROM [M_Consumer] where [MobileNo] = '" + MobileNo + "'");
        if (ds1.Tables[0].Rows.Count > 0)
        {
            result = "Mobile No. Already exist!";
            return result;
        }
        LogManager.WriteExe("Checking mobile no. Complite");
        User_Details Log = new User_Details();
        Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        Log.ConsumerName = Name.Trim().Replace("'", "''");
        Log.Email = email.Trim().Replace("'", "''");
        Log.MobileNo = MobileNo;
        Log.City = City.Trim().Replace("'", "''");
        Log.PinCode = Pin.Trim().Replace("'", "''");
        Log.Password = pwd.Trim().Replace("'", "''");
        Log.IsActive = 0;
        Log.IsDelete = 0;
        Log.DML = "I";
        // check is there in db - if mobile no exists then update
        User_Details.InsertUpdateUserDetails(Log);
        result = "<b>Dear " + Name + "</b><br/> Thanks for registration with us. <br/><br/> <b> Thank you,</b> <br/> Team: VCQRU.COM <br/> " + ProjectSession.sales_accomplishtrades + " ";
        return result;
    }

    public static string EmployeeRegister(string Etype, string Name, string email, string mobile, string City, string Pin, string pwd)
    {
        string result = "";
        LogManager.WriteExe("Enter");
        string MobileNo = mobile.Trim().Replace("'", "''");
        #region Find Actual Mobile No
        if (MobileNo.Length < 10)
        {
            result = "Mobile No. must be 10 digits!";
            return result;
        }
        if (MobileNo.Length == 11)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
                return result;
            }
        }
        if (MobileNo.Length == 13)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
                return result;
            }
        }
        if (MobileNo.Length == 12)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
            if (initial == 91)
                MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
            else
            {
                result = "Mobile No. Wrong!";
                return result;
            }
        }
        if (MobileNo.Length == 10)
            MobileNo = "91" + MobileNo;
        #endregion
        LogManager.WriteExe("Manage Mobile No.");
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [Employee] where [Email] = '" + email.Trim().Replace("'", "''") + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            result = "Email ID Already exist!";
            return result;
        }
        LogManager.WriteExe("Checking Email Complite");
        DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT [MobileNo] FROM [Employee] where [MobileNo] = '" + MobileNo + "'");
        if (ds1.Tables[0].Rows.Count > 0)
        {
            result = "Mobile No. Already exist!";
            return result;
        }
        LogManager.WriteExe("Checking mobile no. Complite");
        User_Details Log = new User_Details();
        Log.EmployeeType = Convert.ToInt16(Etype);
        Log.Address = "";
        Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        Log.ConsumerName = Name.Trim().Replace("'", "''");
        Log.Email = email.Trim().Replace("'", "''");
        Log.MobileNo = MobileNo;
        Log.City = City.Trim().Replace("'", "''");
        Log.PinCode = Pin.Trim().Replace("'", "''");
        Log.Password = pwd.Trim().Replace("'", "''");
        Log.IsActive = 1;
        Log.IsDelete = 0;
        Log.DML = "I";
        // check is there in db - if mobile no exists then update
        //User_Details.InsertUpdateUserDetails(Log);
        ExecuteNonQueryAndDatatable.InsertEmployeeDetails(Log);


        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + Log.ConsumerName + ",</strong></em></span><br />" +
        " <br />" +
        " <span>Thanks for registration with us</span><br />" +
        " Your Login Credentials  <br /> <strong> User Id - " + Log.Email + "</strong><br /> <strong> Password - " + Log.Password + "</strong>  " +
        "<br /><br /> We will contact you soon.   <br />" +
        " <p>" +
        " <div class='w_detail'>" +
        " Assuring you  of  our best services always.<br />" +
        " Thank you,<br /><br />" +
        " Team <em><strong>VCQRU.COM,</strong></em><br />" +
        "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";

        DataSet dsMl = function9420.FetchMailDetail("support");
        if (dsMl.Tables[0].Rows.Count > 0)
        {
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
                Log.Email, MailBody, "Employee Registration");

        }

        result = "<b>Dear " + Name + "</b><br/> Thanks for registration with us. <br/><br/> <b> Thank you,</b> <br/> Team: VCQRU.COM <br/> " + ProjectSession.sales_accomplishtrades + " ";
        return result;
    }


    public static string checkconsumer(string type, string value, string Utype)
    {
        string result = "";
        DataSet ds = new DataSet();
        if (type == "Email")
        {

            if (Utype.ToLower() == "user")
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [M_Consumer] where isnull(isactive,0) =0 and isnull(isdelete,0) =0  and  [Email] = '" + value.Trim().Replace("'", "''") + "'");
            }
            else if (Utype.ToLower() == "vendor")
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [Comp_Email] FROM [Comp_Reg] where isnull(status,1) = 1 and  isnull(Delete_Flag,1)=1 and [Comp_Email] = '" + value.Trim().Replace("'", "''") + "'");
            }
            else if (Utype.ToLower() == "emp")
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [Employee] where   isnull(active,0) =1 and isnull(dalete,0) =0  and  [Email] = '" + value.Trim().Replace("'", "''") + "'");
            }
            else if (Utype.ToLower() == "dealer")
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [dealer] where   isnull(active,0) =1 and isnull([delete],0) =0  and  [Email] = '" + value.Trim().Replace("'", "''") + "'");
            }
            if (ds.Tables[0].Rows.Count > 0)
            {
                result = "Email ID Already exist!";
                return result;
            }
        }
        else if (type == "Mobile")
        {
            string MobileNo = value.Trim().Replace("'", "''");
            #region Find Actual Mobile No
            if (MobileNo.Length < 10)
            {
                result = "Mobile No. must be 10 digits!";
                return result;
            }
            if (MobileNo.Length == 11)
            {
                int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                if (initial == 0)
                    MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
                else
                {
                    result = "Mobile No. Wrong!";
                    return result;
                }
            }
            if (MobileNo.Length == 13)
            {
                int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                if (initial == 0)
                    MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
                else
                {
                    result = "Mobile No. Wrong!";
                    return result;
                }
            }
            if (MobileNo.Length == 12)
            {
                int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
                if (initial == 91)
                    MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
                else
                {
                    result = "Mobile No. Wrong!";
                    return result;
                }
            }
            if (MobileNo.Length == 10)
                MobileNo = "91" + MobileNo;
            #endregion
            //DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [M_Consumer] where [MobileNo] = '" + MobileNo + "'");
            if (Utype.ToLower() == "user")
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [M_Consumer] where isnull(isactive,0) =0 and isnull(isdelete,0) =0  and  [MobileNo] = '" + MobileNo.Trim().Replace("'", "''") + "'");
            }
            else if (Utype.ToLower() == "vendor")
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [Comp_Email] FROM [Comp_Reg] where isnull(status,1) = 1 and  isnull(Delete_Flag,1)=1 and [Mobile_No] = '" + MobileNo.Trim().Replace("'", "''") + "'");
            }
            else if (Utype.ToLower() == "emp")
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [Employee] where   isnull(active,0) =0 and isnull(dalete,0) =0  and  [MobileNo] = '" + MobileNo.Trim().Replace("'", "''") + "'");
            }
            else if (Utype.ToLower() == "dealer")
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [dealer] where   isnull(active,0) =1 and isnull([delete],0) =0  and  [mobileno] = '" + MobileNo.Trim().Replace("'", "''") + "'");
            }
            if (ds.Tables[0].Rows.Count > 0)
            {
                result = "Mobile No. Already exist!";
                return result;
            }
        }
        return result;
    }
    public static string Dealerlogin(string userid, string pass, int remember)
    {
        string result = "";
        User_Details Log = new User_Details();
        if (userid.ToUpper() == "ADMIN")
        {
            result = "Invalid userid or password !";
            return result;
        }
        else
        {
            string MobileNo = userid.Trim().Replace("'", "''");
            if (IsValid(userid.Trim().Replace("'", "''")))
                Log.DML = "Email";
            else
            {
                Log.DML = "Mobile";
                #region Find Actual Mobile No
                if (MobileNo.Length < 10)
                {
                    result = "Mobile No. must be 10 digits!";
                    return result;
                }
                if (MobileNo.Length == 11)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        return result;
                    }
                }
                if (MobileNo.Length == 13)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        return result;
                    }
                }
                if (MobileNo.Length == 12)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
                    if (initial == 91)
                        MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        return result;
                    }
                }
                if (MobileNo.Length == 10)
                    MobileNo = "91" + MobileNo;
                #endregion
            }
            Log.User_Type = " ";
            Log.User_ID = MobileNo;
            Log.Password = pass.Trim().Replace("'", "''");
            //  DataTable dt = User_Details.GetUserLoginDetails(Log);
            DataTable dt = SQL_DB.ExecuteDataTable("Select * from Dealer where mobileno = '" + MobileNo + "' and pwd = '" + pass + "'");
            if (dt.Rows.Count > 0)
            {
                if (remember == 1)
                {
                    HttpContext.Current.Response.Cookies["DistributorUserName"].Value = Log.User_ID;
                    HttpContext.Current.Response.Cookies["DistributorPassword"].Value = pass.Trim();
                    HttpContext.Current.Response.Cookies["DistributorUserName"].Expires = DateTime.Now.AddDays(15);
                    HttpContext.Current.Response.Cookies["DistributorPassword"].Expires = DateTime.Now.AddDays(15);
                }
                else if (remember == 0)
                {
                    HttpContext.Current.Response.Cookies["DistributorUserName"].Value = null;
                    HttpContext.Current.Response.Cookies["DistributorPassword"].Value = null;
                }
                //HttpContext.Current.Session["User_Type"] = "Consumer";
                //HttpContext.Current.Session["USRID"] = dt.Rows[0]["User_ID"].ToString();

                ProjectSession.strUser_Type = "Dealer";
                ProjectSession.strDealerUserID = dt.Rows[0]["Dealerid"].ToString();
                //   ProjectSession.intM_ConsumeriD = Convert.ToInt32(dt.Rows[0]["Dealerid"]);
                if (dt.Rows[0]["Name"].ToString() != "")
                {
                    HttpContext.Current.Session["DealerName"] = dt.Rows[0]["Name"].ToString();
                    ProjectSession.strDealerName = dt.Rows[0]["Name"].ToString();
                }
                else
                    HttpContext.Current.Session["DealerName"] = null;
                // HttpContext.Current.Session["USRMOBILENO"] = dt.Rows[0]["MobileNo"].ToString();
                ProjectSession.strMobileNo = dt.Rows[0]["MobileNo"].ToString();
                result = "success";
            }
            else
            {
                result = "Invalid userid or password !";
                return result;
            }
        }
        return result;
    }
    public static string consumerlogin(string userid, string pass, int remember)
    {
        string result = "";
        User_Details Log = new User_Details();
        if (userid.ToUpper() == "ADMIN")
        {
            result = "Invalid userid or password !";
            return result;
        }
        else
        {
            string MobileNo = userid.Trim().Replace("'", "''");
            if (IsValid(userid.Trim().Replace("'", "''")))
                Log.DML = "Email";
            else
            {
                Log.DML = "Mobile";
                #region Find Actual Mobile No
                if (MobileNo.Length < 10)
                {
                    result = "Mobile No. must be 10 digits!";
                    return result;
                }
                if (MobileNo.Length == 11)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        return result;
                    }
                }
                if (MobileNo.Length == 13)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        return result;
                    }
                }
                if (MobileNo.Length == 12)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
                    if (initial == 91)
                        MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        return result;
                    }
                }
                if (MobileNo.Length == 10)
                    MobileNo = "91" + MobileNo;
                #endregion
            }
            Log.User_Type = "Consumer";
            Log.User_ID = MobileNo;
            Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.GetUserLoginDetails(Log);
            if (dt.Rows.Count > 0)
            {
                if (remember == 1)
                {
                    HttpContext.Current.Response.Cookies["ConsumerUserName"].Value = Log.User_ID;
                    HttpContext.Current.Response.Cookies["ConsumerPassword"].Value = pass.Trim();
                    HttpContext.Current.Response.Cookies["ConsumerUserName"].Expires = DateTime.Now.AddDays(15);
                    HttpContext.Current.Response.Cookies["ConsumerPassword"].Expires = DateTime.Now.AddDays(15);

                    if (!string.IsNullOrEmpty(dt.Rows[0]["employeeID"].ToString()) && !string.IsNullOrEmpty(dt.Rows[0]["distributorID"].ToString()))
                    {
                        HttpContext.Current.Session["MMUser"] = "MMUSERR";
                    }
                    else { HttpContext.Current.Session["MMUser"] = ""; }

                    //string sQry = "Select * from M_Consumer Where MobileNo='" + MobileNo + "' and employeeID IS NOT NULL and distributorID IS NOT NULL";
                    //DataSet dsConsumer = SQL_DB.ExecuteDataSet(sQry);
                    //if (dsConsumer.Tables[0].Rows.Count > 0)
                    //{
                    //    HttpContext.Current.Session["MMUser"] = "MMUSERR";
                    //}
                }
                else if (remember == 0)
                {
                    HttpContext.Current.Response.Cookies["ConsumerUserName"].Value = null;
                    HttpContext.Current.Response.Cookies["ConsumerPassword"].Value = null;
                }
                //HttpContext.Current.Session["User_Type"] = "Consumer";
                // HttpContext.Current.Session["USRID"] = dt.Rows[0]["User_ID"].ToString();
                HttpContext.Current.Session["Consumer_id"] = dt.Rows[0]["m_consumerid"].ToString();

                ProjectSession.strUser_Type = "Consumer";
                ProjectSession.strConsumerUserID = dt.Rows[0]["User_ID"].ToString();
                ProjectSession.intM_ConsumeriD = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
                if (dt.Rows[0]["ConsumerName"].ToString() != "")
                {
                    HttpContext.Current.Session["USRNAME"] = dt.Rows[0]["ConsumerName"].ToString();
                    ProjectSession.strConsumerName = dt.Rows[0]["ConsumerName"].ToString();

                }
                else
                    HttpContext.Current.Session["USRNAME"] = null;
                // HttpContext.Current.Session["USRMOBILENO"] = dt.Rows[0]["MobileNo"].ToString();
                ProjectSession.strMobileNo = dt.Rows[0]["MobileNo"].ToString();
                result = "success";// + "~" + dt.Rows[0]["MM"].ToString()
            }
            else
            {
                result = "Invalid userid or password !";
                return result;
            }
        }
        return result;
    }

    public static bool IsValid(string emailaddress)
    {
        try
        {
            MailAddress m = new MailAddress(emailaddress);

            return true;
        }
        catch (FormatException)
        {
            return false;
        }
    }
    public static string Consumerforgotpassword(string mobile)
    {
        string result = "";
        User_Details Log = new User_Details();
        if (mobile.ToUpper() == "ADMIN")
        {
            result = "Invalid user id or password !";
            return result;
        }
        else
        {
            string MobileNo = mobile.Trim().Replace("'", "''");
            if (IsValid(mobile.Trim().Replace("'", "''")))
            {
                Log.DML = "Email";
            }
            else
            {
                Log.DML = "Mobile";
                #region Find Actual Mobile No
                if (MobileNo.Length < 10)
                {
                    result = "Mobile No. must be 10 digits!";
                    return result;
                }
                if (MobileNo.Length == 11)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        return result;
                    }
                }
                if (MobileNo.Length == 13)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        return result;
                    }
                }
                if (MobileNo.Length == 12)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
                    if (initial == 91)
                        MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        return result;
                    }
                }
                if (MobileNo.Length == 10)
                    MobileNo = "91" + MobileNo;
                #endregion
            }
            Log.User_Type = "Consumer";
            Log.User_ID = MobileNo;
            DataTable dt = new DataTable();
            if (Log.DML == "Mobile")
                dt = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] WHERE  [MobileNo] = '" + MobileNo + "'").Tables[0];
            else if (Log.DML == "Email")
                dt = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] WHERE  [Email] = '" + MobileNo + "' ").Tables[0];
            if (dt.Rows.Count > 0)
            {
                string email = dt.Rows[0]["Email"].ToString();
                if (email != "")
                {
                    ServiceLogic.SendSms("Your password  is " + dt.Rows[0]["Password"].ToString() + " VCQRU.COM", "+" + MobileNo);
                    result = "Your password is send sms to Mobile No. xxxxxxx" + MobileNo.Substring(9, 3) + " and Email!";
                }
                else
                {
                    ServiceLogic.SendSms("Your password  is " + dt.Rows[0]["Password"].ToString() + " VCQRU.COM", "+" + MobileNo);
                    result = "Your password is send sms to Mobile No. xxxxxxx" + MobileNo.Substring(9, 3);
                }
            }
            else
            {
                result = "Your user id is invalid!";
            }
        }
        return result;
    }

    public static string setpassword(string password, string value)
    {
        string result = "";
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [User_ID] FROM [ResetPassword] where  [Encrypt_Value] = '" + value.Replace(" ", "+") + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Comp_Reg] SET [Password] = '" + (password.Replace("'", "''").ToString()) + "' WHERE [Comp_ID] = '" + ds.Tables[0].Rows[0]["User_ID"].ToString() + "'");
            result = "Password has been changed successfully.";
        }
        return result;
    }
    public static string sendquery(string name, string email, string comment, string cmobile)
    {
        string result = "";
        Object9420 obj = new Object9420();
        obj.Name = name.Trim().Replace("'", "''");
        obj.Email = email.Trim().Replace("'", "''");
        obj.cmobile = cmobile.Trim().Replace("'", "''");
        obj.Comments = comment.Trim().Replace("'", "''");
        function9420.SaveLetUsTalk(obj);
        #region Mail Structure
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + obj.Name + ",</strong></em></span><br />" +
        " <br />" +
        " <span>Congratulations !!!</span><br />" +
        " Your Query <strong> " + obj.Comments + "</strong>  has been sent successfully.   <br />" +
        " We will contact you soon.   <br />" +
        " <p>" +
        " <div class='w_detail'>" +
        " Assuring you  of  our best services always.<br />" +
        " Thank you,<br /><br />" +
        " Team <em><strong>VCQRU.COM,</strong></em><br />" +
        "  " + ProjectSession.sales_vcqrucom + "  <br />" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";
        string MailBody1 = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong> Media,</strong></em></span><br />" +
        " Resume details : -   <br />" +
        " <span><em><strong>Name : -</strong></em> " + obj.Name + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + obj.Email + "</span><br />" +
         " <span><em><strong>Mobile No : -</strong></em> " + obj.cmobile + "</span><br />" +
        " <span><em><strong>Comments : -</strong></em> " + obj.Comments + "</span><br /></div>" +
        " <p>" +
        " <div class='w_detail'>" +
        " Assuring you  of  our best services always.<br />" +
        " Thank you,<br /><br />" +
        " Team <em><strong>VCQRU.COM,</strong></em><br />" +
        "  " + ProjectSession.sales_vcqrucom + "  <br />" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";
        #endregion
        DataSet dsMl = function9420.FetchMailDetail("support");
        if (dsMl.Tables[0].Rows.Count > 0)
        {
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Email, MailBody, "User Query");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Media_accomplishtrades, MailBody1, "User Query");
        }
        result = "Query has been sent successfully.";

        // ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
        //"<script>alert('Record Added Successfully')</script>");

        return result;
    }
    public static DataTable Filldtransaction(string size, int consumer_id)
    {
        if (size == "Full")
        {

            DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("Gettransactionlist", consumer_id);
            return dtTrans.Tables[0];
        }
        else
        {
            DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("Gettransactionlist10", consumer_id);
            return dtTrans.Tables[0];
        }


    }
    public static string appchkgenuenity(string code1, string code2, string mobile, string fields, string mode,string dealerid="")
    // public static string chkgenuenity(string code1, string code2, string mobile)
    {
        //return "testing <br/>  Congratulation's !!! <b>You</b> have won gift coupon of";
        string errMsg = "";
        string ReferralCodeFromUser = string.Empty;
        string result = "";
        string ConsumerId = "";
        message_status messageobject = new message_status();
        string MobileNo = mobile.Trim().Replace("'", "''");
        ServiceLogic.paytm_mobile = MobileNo;
        ServiceLogic.paytm_codes = code1 + code2;
        #region validation check
        if (MobileNo == "")
        {
            result = "Kindly Enter Your Mobile No.";
        }
        #endregion
        #region Validate Mobile No (actual length entered by  user )
        if (MobileNo.Length < 10)
        {
            result = "Mobile No. must be 10 digits!";
        }
        if (MobileNo.Length == 11)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
            }
        }
        if (MobileNo.Length == 13)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
            }
        }
        if (MobileNo.Length == 12)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
            if (initial == 91)
                MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
        }
        if (MobileNo.Length == 10)
            MobileNo = "91" + MobileNo;

        #endregion

        #region Checking for M_Consumer
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
        }
        else
        {
            Random r = new Random();
               
            int psw =  r.Next(1000, 9999);
            User_Details Log = new User_Details();
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));

            // Log.Email = "";
            // email.Trim().Replace("'", "''"); //this is comment is done by shweta

            Log.MobileNo =  MobileNo;

            Log.PinCode = null;
            Log.Password = psw.ToString();
            Log.IsActive = 0;
            Log.IsDelete = 0;

            Log.DML = "I";

            User_Details.InsertUpdateUserDetails(Log);
            string  msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ".Visit www.vcqru.com for more info OR for any query contact customer care 7669017720. Thanks VCQRU";
            ServiceLogic.SendSms(msgString, MobileNo);


        }
        #endregion
        if (fields.Length > 0)
        {

            string msgReturn = string.Empty;

            string errDMsg = string.Empty;

            string employeeId = string.Empty;
            string distributorId = string.Empty;
            string[] FieldList = fields.Split(new string[] { FieldSeparator }, StringSplitOptions.None);
            string updatefields = string.Empty;
            for (int i = 0; i < FieldList.Length; i++)
            {
                string[] fieldname = FieldList[i].Split('=');
                if (fieldname[0] != "Painter OTP" ||fieldname[0] != "Dealer Id")
                {
                    if (i < FieldList.Length - 1)
                        updatefields += SQL_DB.ExecuteScalar("select top 1 Field_value from App_fields where Field_name='" + fieldname[0] + "'") + "='" + fieldname[1] + "',";
                    else
                        updatefields += SQL_DB.ExecuteScalar("select top 1 Field_value from App_fields where Field_name='" + fieldname[0] + "'") + "='" + fieldname[1] + "'";
                }
            }
            foreach (string item in FieldList)
            {
                if (item.Contains("Technician ID"))
                    employeeId = item.Split('=')[1];
                if (item.Contains("Dealer Code"))
                    distributorId = item.Split('=')[1];
            }


            if (employeeId != "" && distributorId != "")
            {
                DataSet dsEmployee = CheckEmployeeDetails(employeeId, distributorId);
                DataSet dsDistributor = CheckDistrbutorDetails(employeeId, distributorId);

                if (dsEmployee.Tables[0].Rows.Count == 0)
                {
                    errMsg = "Please provide a valid Dealer Technician ID / Techmaster ID as given ID " + employeeId + " is wrong.";
                }

                if (dsDistributor.Tables[0].Rows.Count == 0)
                {
                    errDMsg = "Please provide a valid Dealer Code as given code " + distributorId + " is wrong.";
                }

                if (dsEmployee.Tables[0].Rows.Count == 0 && dsDistributor.Tables[0].Rows.Count == 0)
                {

                    messageobject.status = "Error";
                    messageobject.message = errMsg + Environment.NewLine + errDMsg;
                    messageobject.fields = "Technician ID,Dealer Code";
                    return JsonConvert.SerializeObject(messageobject, Formatting.Indented);


                }
                else
                {
                    SQL_DB.ExecuteNonQuery("update m_consumer set " + updatefields + " where [MobileNo] = '" + MobileNo + "'");
                }


            }
        }


        Object9420 Reg = new Object9420();
        Reg.Received_Code1 = (code1.Trim().Replace("'", "''"));
        Reg.Received_Code2 = (code2.Trim().Replace("'", "''"));
        Reg.dealerid = dealerid;

        //if (HttpContext.Current.Session["mode"] != null)
        //{
        //    if (HttpContext.Current.Session["mode"].ToString() == "Barcode")
        //    {
        //        Reg.Dial_Mode = "QR code";
        //    }
        //    else
        //    {
        //        Reg.Dial_Mode = "WebSite";
        //    }
        //}
        //else
        //{
        Reg.Dial_Mode = mode;
        // }
        Reg.Mode_Detail = GetIP();

        Reg.Mobile_No = MobileNo;
        Reg.Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff"));
        Reg.callerdate = DateTime.Now;
        Reg.callertime = DateTime.Now.ToString("hh:mm:ss");
        Location location = locationdetails();

        Reg.callercircle = location.region_name;
        Reg.City = location.city_name;
        ////Reg.Comp_ID = ProjectSession.strCompanyid.ToString();
        //if (cmpName == "MAHINDRA AND MAHINDRA LTD")
        //{
        //    Reg.TempleteHead = "SRV1005";
        //    Reg.SubHeadId = "cash";
        //}
        DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
        if (Business9420.function9420.FindCheckedStatus(Reg)) //it looks company status check i.e verify company by admin
        {
            Reg.Is_Success = 0;
            Business9420.function9420.InsertCodeChecked(Reg);
            // result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
            result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
            //send a mail to customer that it's company status is inactive(i.e 0) , so user cannot veryfy there product.
            //return result; // it should if not graranted shweta
            messageobject.status = "Invalid";
        }
        //   string DefaultComments = ""; string CompName = string.Empty;
        // DataSet ds = Business9420.function9420.FindCheckedCode(Reg);
        DataSet ds = ServiceLogic.FindCheckedCode_2(Reg);
        if (ds.Tables[0].Rows.Count == 0)
        {
            Reg.Is_Success = 0;
            Business9420.function9420.InsertCodeChecked(Reg);
            result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
            messageobject.status = "Inavlid";

            // result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
            // return result; // it should if not graranted shweta
        }
        else if (ds.Tables[0].Rows.Count > 0)
        {
            DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
            if (dsres.Tables.Count > 0)
            {
                if (dsres.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
                    {
                        result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, false, ReferralCodeFromUser, Reg.Dial_Mode);



                    }
                    else if (ds.Tables[0].Rows[0]["Use_Count"].ToString() != "0")
                    {
                        messageobject.status = "Unsuccess";
                        //DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
                        result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, true, ReferralCodeFromUser, Reg.Dial_Mode);

                    }
                }
                else
                {
                    if (ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
                    {
                        Reg.Is_Success = 2;
                        messageobject.status = "Unsuccess";
                        SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                            "[Is_Success],[callerdate],[callertime]) VALUES('" + Reg.Dial_Mode + "','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "'," +
                            "'" + MobileNo + "','" + code1 + "','" + code2 + "','" + Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "','" + Reg.callerdate.ToString("yyyy/MM/dd HH:mm:ss") + "','" + Reg.callertime + "')");
                        //DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
                        result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='Checked'");

                        //SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('result inner - " + result + "')");
                    }
                    else
                    {
                        SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                        "[Is_Success],[callerdate],[callertime]) VALUES('" + Reg.Dial_Mode + "','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "'," +
                        "'" + MobileNo + "','" + code1 + "','" + code2 + "','" + Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "','" + Reg.callerdate.ToString("yyyy/MM/dd HH:mm:ss") + "','" + Reg.callertime + "')");

                        //result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, false, ReferralCodeFromUser, Reg.Dial_Mode);
                        result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode' and MsgType=2 ");
                        messageobject.status = "Invalid";

                    }

                    // result = result + "Invalid Code!";
                    //result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode' and MsgType=2");
                }

            }
            else
            {
                if (ds.Tables[0].Rows[0]["Use_Count"].ToString() != "0")
                {
                    Reg.Is_Success = 2;
                    messageobject.status = "Unsuccess";
                    SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                        "[Is_Success],[callerdate],[callertime]) VALUES('" + Reg.Dial_Mode + "','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "'," +
                        "'" + MobileNo + "','" + code1 + "','" + code2 + "','" + Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "','" + Reg.callerdate.ToString("yyyy/MM/dd HH:mm:ss") + "','" + Reg.callertime + "')");
                    //DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
                    result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='Checked'");
                }
                else
                {
                    result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
                    messageobject.status = "Invalid";
                }
                // result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
            }
        }


        messageobject.message = result;
        if (result.Contains("Sorry"))
        {
            messageobject.status = "Invalid";
        }
        return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
    }
    public static bool isDigits(string s)
    {
        if (s == null || s == "") return false;

        for (int i = 0; i < s.Length; i++)
            if ((s[i] ^ '0') > 9)
                return false;

        return true;
    }
    public static string chkgenuenity(string code1, string code2, string mobile, string email, string ReferralCodeFromUser, string city, string name,string dealerid="")
    // public static string chkgenuenity(string code1, string code2, string mobile)
    {
        //return "testing <br/>  Congratulation's !!! <b>You</b> have won gift coupon of";
        string result = "";
        string ConsumerId = "";

        string MobileNo = mobile.Trim().Replace("'", "''");
        ServiceLogic.paytm_mobile = MobileNo;
        ServiceLogic.paytm_codes = code1 + code2;
        #region validation check
        if (MobileNo == "")
        {
            result = "Kindly Enter Your Mobile No.";
        }
        #endregion
        #region Validate Mobile No (actual length entered by  user )

        if (!isDigits(MobileNo))
        {
            result = "Mobile No. must be numeric only!";
            return result;
        }
        if (MobileNo.Length < 10)
        {
            result = "Mobile No. must be 10 digits!";
        }
        if (MobileNo.Length == 11)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
            }
        }
        if (MobileNo.Length == 13)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
            }
        }
        if (MobileNo.Length == 12)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
            if (initial == 91)
                MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
        }
        if (MobileNo.Length == 10)
            MobileNo = "91" + MobileNo;

        #endregion

        #region Checking for M_Consumer
        DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email] FROM [M_Consumer] where right([MobileNo],10) = '" + MobileNo.Substring(MobileNo.Length - 10) + "'");
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
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
            Log.ConsumerName = name;
            // Log.Email = "";
            // email.Trim().Replace("'", "''"); //this is comment is done by shweta
            Log.Email = email.Trim().Replace("'", "''");
            Log.MobileNo = MobileNo;
            Log.City = city;
            Log.PinCode = null;
            Log.Password = rnd.Next(10000, 99999).ToString();
            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.code1 = code1.Trim().Replace("'", "''");
            Log.code2 = code2.Trim().Replace("'", "''");
            Log.DML = "I";

            User_Details.InsertUpdateUserDetails(Log);
            string strReferralCode = Convert.ToString(SQL_DB.ExecuteScalar("Select dbo.GetZeroConcactWithReferralCode(referralcode)  FROM [M_Consumer] where [MobileNo] = '" + MobileNo + "'"));

            string msgString = string.Empty;
            if (HttpContext.Current.Session["MMUser"] == null || HttpContext.Current.Session["MMUser"].ToString() == "")
            {
                if (HttpContext.Current.Session["service"] != null)
                {
                    if (HttpContext.Current.Session["service"].ToString() == "MS")
                        msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ".Visit www.vcqru.com for more info OR for any query contact customer care 9243029420. Thanks VCQRU";
                    else if (HttpContext.Current.Session["companyname"].ToString() == "JPH Publications Pvt. Ltd")
                        msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ".Visit www.vcqru.com for more info OR for any query contact customer care 9243029420. Thanks VCQRU";
                    else
                        msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ". Visit www.vcqru.com to complete the user and bank details  or call 9243029420 for customer support.";
                }

                else if (HttpContext.Current.Session["companyname"] != null)
                {
                    if (HttpContext.Current.Session["companyname"].ToString().ToUpper() == "MYSHA HEALTH WORLD")
                    {
                        msgString = "Thanks for purchasing from MYSHA Nutrition. You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ".";
                    }
                    else if (HttpContext.Current.Session["companyname"].ToString() == "Generic Pharma")
                    {
                        msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ".Visit www.vcqru.com for more info OR for any query contact customer care 7669017720. Thanks VCQRU";
                    }
                    else if (HttpContext.Current.Session["companyname"].ToString() == "JPH Publications Pvt. Ltd")
                        msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ".Visit www.vcqru.com for more info OR for any query contact customer care 9243029420. Thanks VCQRU";
                }
                else
                {
                    msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ". Visit www.vcqru.com to complete the user and bank details  or call 9243029420 for customer support.";
                }
            }

            else
            {
                if (HttpContext.Current.Session["service"] != null)
                {
                    if (HttpContext.Current.Session["service"].ToString() == "MS")
                        msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ".Visit www.vcqru.com for more info OR for any query contact customer care 9243029420. Thanks VCQRU";
                    else if (HttpContext.Current.Session["companyname"].ToString() == "JPH Publications Pvt. Ltd")
                        msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ".Visit www.vcqru.com for more info OR for any query contact customer care 9243029420. Thanks VCQRU";
                    else
                        msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ". Visit www.vcqru.com to complete the user and bank details  or call 9243029420 for customer support.";
                }
                else
                {
                    msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ". Visit www.vcqru.com to complete the user and bank details  or call 9243029420 for customer support.";
                }
            }
            ServiceLogic.SendSms(msgString, MobileNo);

            //SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('IVR-caller_time-dddddddd')");
            #endregion
            ConsumerId = Log.User_ID;
        }

        ////SendSms("Congs! Gained Referral code-" + strReferralCode + "", ProjectSession.strMobileNo);
        #endregion
        if (!string.IsNullOrEmpty(ReferralCodeFromUser))
        {
            if (!string.IsNullOrEmpty(ConsumerId))
            {
                ExecuteNonQueryAndDatatable.InsertUser_ReferredUser(ReferralCodeFromUser, MobileNo);
            }
        }

        Object9420 Reg = new Object9420();
        Reg.Received_Code1 = (code1.Trim().Replace("'", "''"));
        Reg.Received_Code2 = (code2.Trim().Replace("'", "''"));


        if (HttpContext.Current.Session["mode"] != null)
        {
            if (HttpContext.Current.Session["mode"].ToString() == "Barcode")
            {
                Reg.Dial_Mode = "QR code";
            }
            else
            {
                Reg.Dial_Mode = "WebSite";
            }
        }
        else
        {
            Reg.Dial_Mode = "WebSite";
        }
        Reg.Mode_Detail = GetIP();

        Reg.Mobile_No = MobileNo;
        Reg.Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff"));
        Reg.callerdate = DateTime.Now;
        Reg.callertime = DateTime.Now.ToString("hh:mm:ss");
        Location location = locationdetails();

        Reg.callercircle = location.region_name;
        Reg.City = location.city_name;
        if (dealerid != "")
            Reg.dealerid = dealerid;
        ////Reg.Comp_ID = ProjectSession.strCompanyid.ToString();
        //if (cmpName == "MAHINDRA AND MAHINDRA LTD")
        //{
        //    Reg.TempleteHead = "SRV1005";
        //    Reg.SubHeadId = "cash";
        //}
        DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
        if (Business9420.function9420.FindCheckedStatus(Reg)) //it looks company status check i.e verify company by admin
        {
            Reg.Is_Success = 0;
            Business9420.function9420.InsertCodeChecked(Reg);
            // result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
            result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
            //send a mail to customer that it's company status is inactive(i.e 0) , so user cannot veryfy there product.
            //return result; // it should if not graranted shweta
        }
        //   string DefaultComments = ""; string CompName = string.Empty;
        // DataSet ds = Business9420.function9420.FindCheckedCode(Reg);
        DataSet ds = ServiceLogic.FindCheckedCode_2(Reg);
        if (ds.Tables[0].Rows.Count == 0)
        {
            Reg.Is_Success = 0;
            Business9420.function9420.InsertCodeChecked(Reg);
            result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
            // result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
            // return result; // it should if not graranted shweta
        }
        else if (ds.Tables[0].Rows.Count > 0)
        {
            DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
            if (dsres.Tables.Count > 0)
            {
                if (dsres.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
                    {
                        result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, false, ReferralCodeFromUser, Reg.Dial_Mode);
                    }
                    else if (ds.Tables[0].Rows[0]["Use_Count"].ToString() != "0")
                    {
                        //DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
                        result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, true, ReferralCodeFromUser, Reg.Dial_Mode);
                    }
                }
                else
                {
                    if (ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
                    {
                        Reg.Is_Success = 2;
                        SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                            "[Is_Success],[callerdate],[callertime]) VALUES('" + Reg.Dial_Mode + "','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "'," +
                            "'" + MobileNo + "','" + code1 + "','" + code2 + "','" + Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "','" + Reg.callerdate.ToString("yyyy/MM/dd HH:mm:ss") + "','" + Reg.callertime + "')");
                        //DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
                        result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='Checked'");
                        //SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('result inner - " + result + "')");
                    }
                    else
                    {
                        SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                        "[Is_Success],[callerdate],[callertime]) VALUES('" + Reg.Dial_Mode + "','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "'," +
                        "'" + MobileNo + "','" + code1 + "','" + code2 + "','" + Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "','" + Reg.callerdate.ToString("yyyy/MM/dd HH:mm:ss") + "','" + Reg.callertime + "')");

                        //result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, false, ReferralCodeFromUser, Reg.Dial_Mode);
                        result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode' and MsgType=2 ");
                    }

                    // result = result + "Invalid Code!";
                    //result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode' and MsgType=2");
                }

            }
            else
            {
                if (ds.Tables[0].Rows[0]["Use_Count"].ToString() != "0")
                {
                    Reg.Is_Success = 2;
                    SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                        "[Is_Success],[callerdate],[callertime]) VALUES('" + Reg.Dial_Mode + "','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "'," +
                        "'" + MobileNo + "','" + code1 + "','" + code2 + "','" + Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "','" + Reg.callerdate.ToString("yyyy/MM/dd HH:mm:ss") + "','" + Reg.callertime + "')");
                    //DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
                    result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='Checked'");
                }
                else
                {
                    result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
                }
                // result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
            }
        }
        return result;
    }

    public static string chkgenuenity_old(string code1, string code2, string mobile, string email)
    // public static string chkgenuenity(string code1, string code2, string mobile)
    {
        string result = "";
        string ConsumerId = "";

        string MobileNo = mobile.Trim().Replace("'", "''");
        #region validation check
        if (MobileNo == "")
        {
            result = "Kindly Enter Your Mobile No.";
        }
        #endregion
        #region Validate Mobile No (actual length entered by  user )
        if (MobileNo.Length < 10)
        {
            result = "Mobile No. must be 10 digits!";
        }
        if (MobileNo.Length == 11)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
            }
        }
        if (MobileNo.Length == 13)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
            }
        }
        if (MobileNo.Length == 12)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
            if (initial == 91)
                MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
        }
        if (MobileNo.Length == 10)
            MobileNo = "91" + MobileNo;
        #endregion

        #region Checking for M_Consumer
        DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email] FROM [M_Consumer] where [MobileNo] = '" + MobileNo + "'");
        if (dcs.Tables[0].Rows.Count > 0)
        {
            if (dcs.Tables[0].Rows[0]["Email"].ToString() != mobile.Trim().Replace("'", "''"))
            {
                if (mobile.Trim().Replace("'", "''") != "")
                    SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [Email] = '" + mobile.Trim().Replace("'", "''") + "' WHERE [User_ID] = '" + dcs.Tables[0].Rows[0]["User_ID"].ToString() + "' ");
            }
            else
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
            Log.Email = email.Trim().Replace("'", "''");
            Log.MobileNo = MobileNo;
            Log.City = null;
            Log.PinCode = null;
            Log.Password = rnd.Next(10000, 99999).ToString();
            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.DML = "I";
            User_Details.InsertUpdateUserDetails(Log);

            string smsMsg = "You are registered with VCQRU.COM. Your USER ID is " + MobileNo + "  and PASSWORD is " + Log.Password + " Visit www.vcqru.com for more info OR for any query contact customer care 9243029420 Thanks VCQRU";
            ServiceLogic.SendSms(smsMsg, MobileNo);
            #endregion
            ConsumerId = Log.User_ID;
        }
        #endregion

        Object9420 Reg = new Object9420();
        Reg.Received_Code1 = (code1.Trim().Replace("'", "''"));
        Reg.Received_Code2 = (code2.Trim().Replace("'", "''"));
        Reg.Dial_Mode = "WebSite";
        Reg.Mode_Detail = GetIP();
        Reg.Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss"));
        if (Business9420.function9420.FindCheckedStatus(Reg))
        {
            Reg.Is_Success = 0;
            Business9420.function9420.InsertCodeChecked(Reg);
            result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";

        }
        DataSet ds = Business9420.function9420.FindCheckedCode(Reg);
        if (ds.Tables[0].Rows.Count == 0)
        {
            Reg.Is_Success = 0;
            Business9420.function9420.InsertCodeChecked(Reg);
            result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
        }
        else if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
        {
            // Check for all servicesagainst the product
            //ServiceLogic.GetServicesAssign_Product(Reg.Pro_ID);
            //*************** Brand Loyalty Code start ******************//
            string LoyaltyMessage = "";
            LoyaltyMessage = GetMyMessage(MobileNo, Reg.Received_Code1, Reg.Received_Code2, Reg.Mode_Detail);
            //*************** Brand Loyalty Code end ******************//
            Reg.Is_Success = 1;
            DataSet dsres = SQL_DB.ExecuteDataSet("SELECT  Comp_Reg.Comp_Name,  m_code.Pro_ID+'-'+ " +
            " convert(varchar,(case when len(convert(nvarchar,M_Code.Series_Order)) = 1 " +
            " then '0'+ convert(nvarchar,M_Code.Series_Order) else " +
            " convert(nvarchar,M_Code.Series_Order) end))+'-'+" +
            " convert(varchar,(case when len(convert(varchar,M_Code.Series_Serial)) = 1 then '00' " +
            " +convert(varchar,M_Code.Series_Serial)  " +
            " when len(convert(varchar,M_Code.Series_Serial)) = 2 then '0' " +
            " +convert(varchar,M_Code.Series_Serial) " +
            " else convert(varchar,M_Code.Series_Serial) end )) as series, Pro_Reg.Pro_Name,isnull(Pro_Reg.Comments,'') as Comments,m_code.Pro_ID," +
            " T_Pro.MRP,convert(nvarchar,T_Pro.Mfd_Date,103) as Mfd_Date, convert(nvarchar,isnull(T_Pro.Exp_Date,''),103) as Exp_Date," +
            " T_Pro.Batch_No, M_Code.Code1,M_Code.Code2, " +
            //" '"+ ProjectSession.absoluteSiteBrowseUrl +"/Sound/' + substring(Pro_Reg.Comp_ID,6,4) + '/' + substring(Pro_Reg.Comp_ID,6,4) + '.wav' as Company_Sound_File," +
            //" '"+ ProjectSession.absoluteSiteBrowseUrl +"/Sound/'+ substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + T_Pro.Pro_ID + '.wav' as Product_Sound_File," +
            //" '"+ ProjectSession.absoluteSiteBrowseUrl +"/Sound/'+ substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + convert(nvarchar,T_Pro.Row_ID) + '/' + convert(nvarchar,T_Pro.Row_ID) + '_E.wav' as comment_english," +
            //" '"+ ProjectSession.absoluteSiteBrowseUrl +"/Sound/'+ substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + convert(nvarchar,T_Pro.Row_ID) + '/' + convert(nvarchar,T_Pro.Row_ID) + '_H.wav' as comment_hindi" +
            " '" + ProjectSession.absoluteSiteBrowseUrl + "/Sound/' + substring(Pro_Reg.Comp_ID,6,4) + '/' + substring(Pro_Reg.Comp_ID,6,4) + '.wav' as Company_Sound_File," +
            " '" + ProjectSession.absoluteSiteBrowseUrl + "/Sound/'+ substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + T_Pro.Pro_ID + '.wav' as Product_Sound_File," +
            " '" + ProjectSession.absoluteSiteBrowseUrl + "/Sound/'+ substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + convert(nvarchar,T_Pro.Row_ID) + '/' + convert(nvarchar,T_Pro.Row_ID) + '_E.wav' as comment_english," +
            " '" + ProjectSession.absoluteSiteBrowseUrl + "/Sound/'+ substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + convert(nvarchar,T_Pro.Row_ID) + '/' + convert(nvarchar,T_Pro.Row_ID) + '_H.wav' as comment_hindi" +
            " FROM T_Pro INNER JOIN M_Code ON T_Pro.Row_ID = M_Code.Batch_No INNER JOIN" +
            " Pro_Reg ON T_Pro.Pro_ID = Pro_Reg.Pro_ID INNER JOIN Comp_Reg ON Pro_Reg.Comp_ID = Comp_Reg.Comp_ID" +
            " where  M_Code.Code1 = '" + Reg.Received_Code1 + "' and M_Code.Code2 = '" + Reg.Received_Code2 + "' and ISNULL(m_code.use_count,0) = 0");
            Business9420.function9420.InsertCodeChecked(Reg); // doing entry in Pro_Enq tabgle
            Business9420.function9420.UpdateUse_CountM_Code(Reg);// update [Use_Count] =0 in M_Code
            string DefaultComments = ""; if (Reg.Comp_type == "L")
            {
                DataSet ds1 = SQL_DB.ExecuteDataSet("select * from M_Amc_Offer  WHERE Pro_Id = '" + dsres.Tables[0].Rows[0]["Pro_ID"].ToString() + "' AND Trans_Type = 'Offer' AND  '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' BETWEEN convert(nvarchar,Date_From,111) AND convert(nvarchar,Date_To,111)");
                if (ds1.Tables[0].Rows.Count > 0)
                    DefaultComments = ds1.Tables[0].Rows[0]["Comments"].ToString();
                else
                    DefaultComments = "";
            }
            else
                DefaultComments = dsres.Tables[0].Rows[0]["Comments"].ToString();
            DefaultComments += " " + LoyaltyMessage;
            if (dsres.Tables[0].Rows[0]["Exp_Date"].ToString() == "01/01/1900")
            {
                result = "Code1-" + Reg.Received_Code1 + " & Code2-" + Reg.Received_Code2 + ", Prod-" + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", SN-" + dsres.Tables[0].Rows[0]["series"].ToString() + "" +
                                    ", MRP-" + dsres.Tables[0].Rows[0]["MRP"].ToString() + ", MFG" + dsres.Tables[0].Rows[0]["Mfd_Date"].ToString() + ", EXP, BtNo-" + dsres.Tables[0].Rows[0]["Batch_No"].ToString() + ", PROD IS GENUINE & mfd by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + " " + DefaultComments + " Tnx VCQRU.COM";
            }
            else
            {
                result = "Code1-" + Reg.Received_Code1 + " & Code2-" + Reg.Received_Code2 + ", Prod-" + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", SN-" + dsres.Tables[0].Rows[0]["series"].ToString() + "" +
                                        ", MRP-" + dsres.Tables[0].Rows[0]["MRP"].ToString() + ", MFG" + dsres.Tables[0].Rows[0]["Mfd_Date"].ToString() + ", EXP" + dsres.Tables[0].Rows[0]["Exp_Date"].ToString() + ", BtNo-" + dsres.Tables[0].Rows[0]["Batch_No"].ToString() + ", PROD IS GENUINE & mfd by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + " " + DefaultComments + " Tnx VCQRU.COM";
            }
        }
        else if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Use_Count"].ToString() != "0")
        {
            Reg.Is_Success = 0;
            Business9420.function9420.InsertCodeChecked(Reg);
            result = "THE AUTHENTICITY OF THE PRODUCT WITH CODE 1 " + Reg.Received_Code1 + " AND CODE2 " + Reg.Received_Code2 + " HAS ALREADY BEEN CHECKED BEFORE. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN ITS AUTHENTICITY CAN NOT BE GUARANTEED.";

        }
        // Gift Coupon logic

        return result;
    }
    #region Brand Loyalty Code


    private static void SendSms(string Message, string phone)
    {

        string str = "";
        try
        {
            //http://sms.bsmart.in:8080/smart/SMSmartSendSMS.jsp?http://sms.bsmart.in:8080/smart/SmartSendSMS.jsp
            //str = "http://sms.bsmart.in:8080/smart/SMSmartSendSMS.jsp?usr=LABEL9420&pass=LABEL890&sid=LBVRFY&GSM=" + phone + "&msg=" + Message + "&mt=0";
            //str = "http://193.105.74.58/api/v3/sendsms/plain?user=LABEL9420&password=Sid2014!&sender=labeld&SMSText=" + Message + "&GSM=" + phone;
            //str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A7285cc769f5ed203e7d8cee48444dbb8&sender=SIDEMO&to=" + phone + "&message=" + Message;

            //    str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A3f78a344d70a9e35c006e938f428f591&sender=LBVRFY&to=" + phone + "&message=" + Message;
            str = "http://etsrds.kapps.in/webapi/accomplish/api/accomplish_T897_sms.py?customer_number=" + phone + "&sms_text=" + Message;

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

    private static void SendSmsWithAlfa(string msg, string phone)
    {
        string str = "";
        try
        {
            //string otpMsg = "Your Employee verification OTP is " + rdmNumber + " <a href='https://www.vcqru.com'>vcqru.com</a>";
            str = "http://sms.alfasms.in/sendSMS?username=alfasms&message=" + msg + "&sendername=Alfast&smstype=TRANS&numbers=" + phone + "&apikey=d13cfc39-dae1-4462-8b46-5a2ab78ca5c1";

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

    //*************** Brand Loyalty Code start ******************//
    private static string GetMyMessage(string MobileNo, string Code1, string Code2, string Mode)
    {
        string UserID = ""; string Msg = ""; string NewMsg = ""; string MyPointMsg = "";
        DataTable dt = SQL_DB.ExecuteDataSet("SELECT Pro_ID,Use_Count FROM M_Code WHERE Code1 = '" + Code1 + "' AND Code2='" + Code2 + "'").Tables[0];
        if (dt.Rows.Count > 0)
        {
            string Pro_ID = dt.Rows[0]["Pro_ID"].ToString();
            DataTable dst = SQL_DB.ExecuteDataSet("SELECT [Comp_ID],[Comments],[Points],[DateFrom],[DateTo],[Frequency] FROM M_Loyalty WHERE IsActive = 0 AND IsDelete = 0 AND Pro_ID='" + Pro_ID + "'").Tables[0];
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
                int chk = Convert.ToInt32(dt.Rows[0]["Use_Count"]);
                if (chk == 0)
                {
                    Loyalty_Points Reg = new Loyalty_Points();
                    Reg.User_ID = UserID;
                    Reg.MobileNo = MobileNo;
                    Reg.Code1 = Convert.ToInt64(Code1);
                    Reg.Code2 = Convert.ToInt64(Code2);
                    Reg.Mode = Mode;
                    Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
                    if (dst.Rows.Count > 0)
                    {
                        Reg.Comp_ID = dst.Rows[0]["Comp_ID"].ToString(); Reg.Pro_ID = Pro_ID;
                        if (chk == 0)
                        {
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
                                if (ChkFlag)
                                {
                                    if (Frequency > 0)
                                    {
                                        Reg.Points = (((AcFrequency == 1) || (Frequency == GetFrequency)) ? Convert.ToDecimal(dst.Rows[0]["Points"]) : 0);
                                        if (Reg.Points == 0)
                                            Msg = "You win " + MyPointMsg.ToString() + " Points to " + ServiceLogic.GetNext(Frequency - GetFrequency) + " Next Purchage ";
                                    }
                                    else
                                        Reg.Points = Convert.ToDecimal(dst.Rows[0]["Points"]);
                                    Reg.EarnType = "Earn";
                                    Reg.DML = "I";
                                    try
                                    {
                                        Loyalty_Points.InsertUpdatePoints(Reg);
                                        if (Reg.Points > 0)
                                            SQL_DB.ExecuteDataSet("UPDATE T_Points SET IsUse = 1 WHERE User_ID='" + UserID + "' AND Pro_ID ='" + Pro_ID + "' AND IsUse = 0");
                                    }
                                    catch (Exception ex)
                                    {
                                        throw ex;
                                    }
                                }
                            }
                        }
                    }
                }
                #endregion
            }
        }
        return Msg;
    }
    //private static string GetNext(Int32 i)
    //{
    //    string Msg = "";
    //    switch (i)
    //    {
    //        case 2:
    //            {
    //                Msg = i.ToString() + "nd";
    //                break;
    //            }
    //        case 3:
    //            {
    //                Msg = i.ToString() + "rd";
    //                break;
    //            }
    //        case 4:
    //        case 5:
    //        case 6:
    //        case 7:
    //        case 8:
    //        case 9:
    //        case 10:
    //            {
    //                Msg = i.ToString() + "th";
    //                break;
    //            }
    //        default:
    //            {
    //                Msg = "";
    //                break;
    //            }
    //    }
    //    return Msg;
    //}
    private static bool CheckCode1Code2(string Code1, string Code2)
    {
        DataTable dt = SQL_DB.ExecuteDataSet("select * from T_Points WHERE Code1= '" + Code1 + "' AND Code2 = '" + Code2 + "' ").Tables[0];
        if (dt.Rows.Count > 0)
            return false;
        else
            return true;
    }
    //*************** Brand Loyalty Code end ******************//

    #endregion
    public static string subscribenewsletter(string Email)
    {
        string result = "";
        DataSet ds = new DataSet();
        Object9420 Reg = new Object9420();
        Reg.Email = Email.Trim().Replace("'", "''");
        ds = function9420.GetNewsLettersEmail(Reg);
        if (ds.Tables[0].Rows.Count > 0)
        {
            if (Convert.ToInt32(ds.Tables[0].Rows[0]["Status"]) == 0)
            {
                Reg.Status = 1;
                Reg.DML = "U";
                result = "Your e-mail has been subscribe successfully.";
            }
            else
                result = "Your e-mail already subscribe.";
        }
        else
        {
            Reg.Status = 1;
            Reg.DML = "I";
            function9420.InsertNewsLetterSubscription(Reg);
            result = "Your e-mail has been subscribe successfully.";
        }
        return result;

    }
    public static string fillnews()
    {
        string sbnews = "";
        DataSet ds = Data_Access_Layer.NewssUpDate.FillGridData();
        if (sbnews == "")
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                if (i == 0)
                {
                    sbnews += "<div class='item active'><blockquote><div class='row'><div class='col-sm-12'>";
                }
                else
                {
                    sbnews += "<div class='item'><blockquote><div class='row'><div class='col-sm-12'>";
                }
                Regex regex = new Regex("<a(.*)target");
                var v = regex.Match(ds.Tables[0].Rows[i]["News"].ToString());
                string s = v.Groups[1].ToString();
                int ii = ds.Tables[0].Rows[i]["News_heading"].ToString().Length;
                sbnews += "<p>";
                if (ds.Tables[0].Rows[i]["News_heading"].ToString().Length > 150)
                    sbnews += "" + ds.Tables[0].Rows[i]["News_heading"].ToString().Substring(0, 150) + "....";
                else
                    sbnews += "" + ds.Tables[0].Rows[i]["News_heading"].ToString() + "...";

                sbnews += "</p>";
                sbnews += "<small><span class='ddmmyy'>" + Convert.ToDateTime(ds.Tables[0].Rows[i]["Updated_Date"]).ToString("dd MMM yyyy") + "</span><span><a style='padding:10px;' class='view_more' " + s.ToString() + " target='_blank' >View More...</a></span></small>";
                sbnews += "</div></div></blockquote></div>";
            }
        }
        return sbnews.ToString();
    }
    public static string CheckEmail(string Email)
    {
        string msg = "";
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Comp_Email] FROM [Comp_Reg] where [Comp_Email] = '" + Email.Trim().Replace("'", "''") + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            msg = "Email ID Already Registered!";
        }
        else
        {
            msg = "Email ID Not Registered!";
        }
        return msg;
    }
    public static string Encrypt(string TextToBeEncrypted)
    {
        RijndaelManaged RijndaelCipher = new RijndaelManaged();
        string Password = "CSC";
        byte[] PlainText = System.Text.Encoding.Unicode.GetBytes(TextToBeEncrypted);
        byte[] Salt = Encoding.ASCII.GetBytes(Password.Length.ToString());
        PasswordDeriveBytes SecretKey = new PasswordDeriveBytes(Password, Salt);
        ICryptoTransform Encryptor = RijndaelCipher.CreateEncryptor(SecretKey.GetBytes(32), SecretKey.GetBytes(16));
        MemoryStream memoryStream = new MemoryStream();
        CryptoStream cryptoStream = new CryptoStream(memoryStream, Encryptor, CryptoStreamMode.Write);
        cryptoStream.Write(PlainText, 0, PlainText.Length);
        cryptoStream.FlushFinalBlock();
        byte[] CipherBytes = memoryStream.ToArray();
        memoryStream.Close();
        cryptoStream.Close();
        string EncryptedData = Convert.ToBase64String(CipherBytes);
        return EncryptedData;
    }

    public static string Decrypt(string TextToBeDecrypted)
    {
        RijndaelManaged RijndaelCipher = new RijndaelManaged();
        string Password = "CSC";
        string DecryptedData;
        try
        {
            string dummyData = TextToBeDecrypted.Trim().Replace(" ", "+");
            if (dummyData.Length % 4 > 0)
                dummyData = dummyData.PadRight(dummyData.Length + 4 - dummyData.Length % 4, '=');
            byte[] EncryptedData = Convert.FromBase64String(dummyData);
            //byte[] EncryptedData = UTF8Encoding.UTF8.GetBytes(TextToBeDecrypted);
            byte[] Salt = Encoding.ASCII.GetBytes(Password.Length.ToString());
            PasswordDeriveBytes SecretKey = new PasswordDeriveBytes(Password, Salt);
            ICryptoTransform Decryptor = RijndaelCipher.CreateDecryptor(SecretKey.GetBytes(32), SecretKey.GetBytes(16));
            MemoryStream memoryStream = new MemoryStream(EncryptedData);
            CryptoStream cryptoStream = new CryptoStream(memoryStream, Decryptor, CryptoStreamMode.Read);
            byte[] PlainText = new byte[EncryptedData.Length];
            int DecryptedCount = cryptoStream.Read(PlainText, 0, PlainText.Length);
            memoryStream.Close();
            cryptoStream.Close();
            DecryptedData = Encoding.Unicode.GetString(PlainText, 0, DecryptedCount);
        }
        catch
        {
            DecryptedData = TextToBeDecrypted;
        }
        return DecryptedData;
    }





    [WebMethod]
    public static string register(string Companyname, string contactpersion, string email, string mobile)
    {
        Business9420.Object9420 obj = new Business9420.Object9420();
        obj.Comp_Name = Companyname.Trim().Replace("'", "''").ToString();
        obj.Comp_Email = email.Trim().Replace("'", "''").ToString();
        obj.Contact_Person = contactpersion.Trim().Replace("'", "''").ToString();
        obj.Mobile_No = mobile.Trim().Replace("'", "''").ToString();
        obj.Comp_type = "L";
        obj.Comp_ID = SQL_DB.ExecuteScalar("SELECT [PrPrefix]+ '-' + convert(nvarchar,[PrStart]) as compId FROM [Code_Gen] where [Prfor] = 'Company'").ToString();
        obj.Reg_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy hh:mm:ss tt");
        obj.Status = 0;
        obj.Email_Vari_Flag = 0;
        obj.Update_Flag = 0;
        //obj.Country_ID = 137;
        obj.DML = "I";
        DataSet ds12 = SQL_DB.ExecuteDataSet("SELECT [Comp_Email] FROM [Comp_Reg] where [Comp_Email] = '" + obj.Comp_Email + "' and [Delete_Flag] = 1 ");
        if (ds12.Tables[0].Rows.Count == 0)
        {
            Business9420.function9420.SaveCompanyReg(obj);
            SQL_DB.ExecuteNonQuery("UPDATE [Code_Gen] SET [PrStart] = PrStart + 1 WHERE [Prfor] = 'Company'");
            string EncData = string.Format("Comp_Id={0}", obj.Comp_ID);
            string link = ProjectSession.absoluteSiteBrowseUrl + "/default.aspx?key=" + Encrypt(obj.Comp_ID);
            #region Mial Body
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
            " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
            " <hr style='border:1px solid #2587D5;'/>" +
            " <div class='w_frame'>" +
            " <p>" +
            " <div class='w_detail'>" +
            " <span>Dear <em><strong>" + contactpersion + ",</strong></em></span><br />" +
            " <br />" +
            " <span>Thank you for choosing VCQRU.COM</span>" +
            " <br />you are just few seconds away to enjoy the services of VCQRU.COM <br />" +
            " Please visit the link below, to verify your email. <a href='" + link + "'><strong>Verify your Email now</strong></a>" +
            " <br />" +
            " <br />" +
            " <p>" +
            " <div class='w_detail'>" +
            " Assuring you  of  our best services always.<br />" +
            " Thank you,<br /><br />" +
            " Team <em><strong>VCQRU.COM,</strong></em><br />" +
            "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
            " </div>" +
            " </p>" +
            " </div>" +
            " </p>" +
            " </div> " +
            " </div> ";

            string MailBody1 = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
            " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
            " <hr style='border:1px solid #2587D5;'/>" +
            " <div class='w_frame'>" +
            " <p>" +
            " <div class='w_detail'>" +
            " <span>Dear <em><strong>, Sales person</strong></em></span><br />" +
            " <br />" +
            "<br/> <strong>" + obj.Comp_Name + "</strong> Company registered successfully. <br/> " +
            " Thank you,<br /><br />" +
            " Team <em><strong>VCQRU.COM,</strong></em><br />" +
            "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
            " </div>" +
            " </p>" +
            " </div>" +
            " </p>" +
            " </div> " +
            " </div> ";
            #endregion
            string msg = "";
            System.Data.DataSet dsMl = Business9420.function9420.FetchMailDetail("register");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Comp_Email, MailBody, "Company Registration");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Company Registration");
                msg = "<b>Dear " + contactpersion + "</b><br/> Thanks for registration with us. Please check your email to verify your account. <br/> <br/> <b> Thank you,</b> <br/> Team: VCQRU.COM <br/>  " + ProjectSession.sales_accomplishtrades + " ";
            }

            return msg;
        }
        else
        {
            string msg = "<b>This email id already registered in our system. Please enter different email id. </b>";
            return msg;
        }

    }


    [WebMethod]
    public static string demoreegister(string Companyname, string email, string contactpersion, string mobile)
    {
        string result = "";
        Object9420 obj = new Object9420();
        obj.Comp_Name = Companyname.Trim().Replace("'", "''").ToString();
        obj.Comp_Email = email.Trim().Replace("'", "''").ToString();
        obj.Contact_Person = contactpersion.Trim().Replace("'", "''").ToString();
        obj.Mobile_No = mobile.Trim().Replace("'", "''").ToString();
        obj.Comp_type = "D";
        obj.Comp_ID = SQL_DB.ExecuteScalar("SELECT [PrPrefix]+ '-' + convert(nvarchar,[PrStart]) as compId FROM [Code_Gen] where [Prfor] = 'Company'").ToString();
        obj.Reg_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy hh:mm:ss tt");
        obj.Status = 0;
        obj.Email_Vari_Flag = 1;
        obj.Update_Flag = 0;
        //obj.City_ID = 137;
        obj.DML = "I";
        Random rnd = new Random();
        obj.Password = rnd.Next().ToString().Substring(0, 5);

        function9420.SaveCompanyReg(obj);
        SQL_DB.ExecuteNonQuery("UPDATE [Allcation_Demo] SET [Entry_Flag] = 1 WHERE [Email_ID] = '" + obj.Comp_Email + "'");
        SQL_DB.ExecuteNonQuery("UPDATE [Code_Gen] SET [PrStart] = PrStart + 1 WHERE [Prfor] = 'Company'");
        string EncData = string.Format("Comp_Id={0}", obj.Comp_ID);
        //string link = ""+ ProjectSession.absoluteSiteBrowseUrl +"/default.aspx";
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + obj.Contact_Person + ",</strong></em></span><br />" +
        " <br />" +
        " <span> Your Company <strong>" + obj.Comp_Name + "</strong> Registered successflly as Demo </span>" +
        " <br />" +
        " <span>Your login credential is following</span>" +
        " <br />" +
        " <br />" +
        " <span><strong>Your User ID : - </strong>" + obj.Comp_Email + "</span>" +
        " <br />" +
        " <span><strong>Your Password : - </strong>" + obj.Password + "</span>" +
        " <br />you are just few seconds away to enjoy the services of VCQRU.COM <br />" +
        " <br />" +
        " <p>" +
        " <div class='w_detail'>" +
        " Assuring you  of  our best services always.<br />" +
        " Thank you,<br /><br />" +
        " Team <em><strong>VCQRU.COM,</strong></em><br />" +
        "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";
        DataSet dsMl = function9420.FetchMailDetail("register");
        if (dsMl.Tables[0].Rows.Count > 0)
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Comp_Email, MailBody, "Company Registration");
        result = "<b>Dear " + contactpersion + "</b><br/> Thanks for registration with us. Please check your email for your login details  <br/> <br/> <b> Thank you,</b> <br/> Team: VCQRU.COM <br/>  " + ProjectSession.sales_accomplishtrades + " ";
        return result;
    }

    public static string DemoPackeageCode(string PackeageCode)
    {
        string result = "";
        DataSet dsNewChk = SQL_DB.ExecuteDataSet("SELECT [Entry_Flag],[Email_ID] FROM [Allcation_Demo] where [Packet_Name] = '" + PackeageCode.Trim() + "'");
        if (dsNewChk.Tables[0].Rows.Count > 0 && dsNewChk.Tables[0].Rows[0]["Entry_Flag"].ToString() == "1")
        {
            result = "Packet secret code already registered !";
            return result;
        }
        else if (dsNewChk.Tables[0].Rows.Count > 0 && dsNewChk.Tables[0].Rows[0]["Entry_Flag"].ToString() == "0")
        {
            DataTable rdt = SQL_DB.ExecuteDataTable("SELECT IsRetailer FROM Comp_Reg WHERE Comp_Email= '" + dsNewChk.Tables[0].Rows[0]["Email_ID"].ToString() + "'");
            if (rdt.Rows.Count > 0)
            {
                if (Convert.ToInt32(rdt.Rows[0]["IsRetailer"]) == 1)
                {
                    result = "Packet secret code already registered !";
                    return result;
                }
            }
        }
        DataSet ds = Business9420.function9420.CheckDemoPackageCodes(PackeageCode.Trim());
        DataSet ds1 = Business9420.function9420.CheckDemoPackageCodesRows(PackeageCode.Trim());
        if (ds1.Tables[0].Rows.Count > 0)
        {
            DataSet dsAllot = SQL_DB.ExecuteDataSet("SELECT [Email_ID],[Comp_Name],[Contact_No],[Contact_Name],[Packet_Name] FROM [Allcation_Demo] where [Packet_Name] = '" + PackeageCode.Trim() + "'");
            if (dsAllot.Tables[0].Rows.Count > 0)
            {
                result = dsAllot.Tables[0].Rows[0]["Email_ID"].ToString() + '#' + dsAllot.Tables[0].Rows[0]["Comp_Name"].ToString() + '#' + dsAllot.Tables[0].Rows[0]["Contact_Name"].ToString() + '#' + dsAllot.Tables[0].Rows[0]["Contact_No"].ToString();
            }
            else
            {
                result = "Invalid packet secret code !";
                return result;
            }
            return result;
        }
        if (result == "")
        {
            result = "Invalid packet secret code !";
        }
        return result;
    }
    public static string loginEmp(string userid, string pass, int remember)
    {
        string result = "1";
        //Object9420 Log = new Business9420.Object9420();
        //if (userid.ToUpper() == "ADMIN")
        //{
        //    userid = "";
        //    pass = "";
        //    result = "1";
        //    return result;
        //}
        //else
        //{
        //Log.User_Type = "Employee";
        //  Log.User_ID = userid.Trim().Replace("'", "''");
        //  Log.Password = pass.Trim().Replace("'", "''");

        DataSet ds = SQL_DB.ExecuteDataSet("SELECT * FROM [Employee] where [email]='" + userid + "' AND [Pwd]='" + pass + "' AND [Active]=1 ");
        if (ds.Tables[0].Rows.Count > 0)
        {
            HttpContext.Current.Session["User_Type"] = "Employee";
            DataTable dt = ds.Tables[0];
            ProjectSession.strEmployeeName = dt.Rows[0]["name"].ToString();
            ProjectSession.strEmployeeEmail = dt.Rows[0]["email"].ToString();
            if (remember == 1)
            {
                HttpContext.Current.Response.Cookies["EquixUserNameEmp"].Value = dt.Rows[0]["email"].ToString();
                HttpContext.Current.Response.Cookies["EquixPasswordEmp"].Value = dt.Rows[0]["pwd"].ToString();
                HttpContext.Current.Response.Cookies["EquixUserNameEmp"].Expires = DateTime.Now.AddDays(15);
                HttpContext.Current.Response.Cookies["EquixPasswordEmp"].Expires = DateTime.Now.AddDays(15);
            }
            else if (remember == 2)
            {
                HttpContext.Current.Response.Cookies["EquixUserNameEmp"].Value = null;
                HttpContext.Current.Response.Cookies["EquixPasswordEmp"].Value = null;
            }


        }
        else
        {
            result = "3";
            return result;
        }
        return result;


    }
    public static string login(string userid, string pass, int remember)
    {
        string result = "";
        Object9420 Log = new Business9420.Object9420();
        if (userid.ToUpper() == "ADMIN")
        {
            userid = "";
            pass = "";
            result = "1";
            return result;
        }
        else
        {
            Log.User_Type = "Customer Care";
            Log.User_ID = userid.Trim().Replace("'", "''");
            Log.Password = pass.Trim().Replace("'", "''");
            if (Business9420.function9420.FetchDataForCustonerLogin(Log))
            {
                HttpContext.Current.Session["User_Type"] = "Customer Care";
                if (HttpContext.Current.Session["User_Type"] != null && HttpContext.Current.Request.QueryString["Page"] == null)
                {
                    SQL_DB.ExecuteNonQuery("INSERT INTO [Login_Summary](User_ID,Login_Date,User_Type) VALUES ('" + HttpContext.Current.Session["User_Type"].ToString() + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' ,1)");
                    HttpContext.Current.Response.Redirect("Dashboard.aspx");
                }
                else if (HttpContext.Current.Session["User_Type"] != null && HttpContext.Current.Request.QueryString["Page"] != null)
                {
                    SQL_DB.ExecuteNonQuery("INSERT INTO [Login_Summary](User_ID,Login_Date,User_Type) VALUES ('" + HttpContext.Current.Session["User_Type"].ToString() + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' ,1)");
                    HttpContext.Current.Response.Redirect(HttpContext.Current.Request.QueryString["Page"].ToString());
                }
            }

        }

        Log.Comp_Email = userid.Trim().Replace("'", "''");
        Log.Password = pass.Trim().Replace("'", "''");
        DataSet dsPass = SQL_DB.ExecuteDataSet("SELECT [IsRetailer],[Comp_ID],[Comp_Email],[Comp_Name],[Comp_type],[Status],[Delete_Flag] FROM [Comp_Reg] where isnull(delete_flag,0) =1 " +
            " and [Comp_Email] = '" + Log.Comp_Email + "' and [Password] = '" + Log.Password + "' and [Email_Vari_Flag] = '1'  "); //and isnull(delete_flag,1) =1
        if (dsPass.Tables[0].Rows.Count > 0)
        {
            if (remember == 1)
            {
                HttpContext.Current.Response.Cookies["EquixUserName"].Value = Log.Comp_Email;
                HttpContext.Current.Response.Cookies["EquixPassword"].Value = pass.Trim();
                HttpContext.Current.Response.Cookies["EquixUserName"].Expires = DateTime.Now.AddDays(15);
                HttpContext.Current.Response.Cookies["EquixPassword"].Expires = DateTime.Now.AddDays(15);
            }
            else if (remember == 2)
            {
                HttpContext.Current.Response.Cookies["EquixUserName"].Value = null;
                HttpContext.Current.Response.Cookies["EquixPassword"].Value = null;
            }
            try
            {

                Log.Comp_ID = dsPass.Tables[0].Rows[0]["Comp_ID"].ToString();
                string path = HttpContext.Current.Server.MapPath("Data/Sound");
                path = path + "\\" + dsPass.Tables[0].Rows[0]["Comp_ID"].ToString().Substring(5, 4);
                DataProvider.Utility.CreateDirectory(path);
                path = path + "\\" + dsPass.Tables[0].Rows[0]["Comp_ID"].ToString().Substring(5, 4) + ".wav";
                int docflag = Convert.ToInt32(function9420.GetUploadDocStatus(Log));
                int Verdocflag = Convert.ToInt32(function9420.VerifyDocStatus(Log));
                int statusflag = Convert.ToInt32(dsPass.Tables[0].Rows[0]["Status"]);
                int delflag = Convert.ToInt32(dsPass.Tables[0].Rows[0]["Delete_Flag"]);
                Log.Dial_Mode = GetIP();


                SQL_DB.ExecuteNonQuery("INSERT INTO [Login_History](Dial_Mode,User_ID,Login_Date,User_Type) VALUES ('" + Log.Dial_Mode + "','" + dsPass.Tables[0].Rows[0]["Comp_ID"].ToString() + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' ,0)");
                if (delflag == 1)
                {
                    HttpContext.Current.Session["Status"] = Convert.ToString(dsPass.Tables[0].Rows[0]["Status"]);
                    HttpContext.Current.Session["User_Type"] = "Company"; //ViewState["User_Type"] = "Company";
                    HttpContext.Current.Session["Comp_type"] = dsPass.Tables[0].Rows[0]["Comp_type"].ToString();
                    HttpContext.Current.Session["CompanyId"] = dsPass.Tables[0].Rows[0]["Comp_ID"].ToString();
                    HttpContext.Current.Session["Comp_Name"] = dsPass.Tables[0].Rows[0]["Comp_Name"].ToString();
                    HttpContext.Current.Session["IsRetailer"] = dsPass.Tables[0].Rows[0]["IsRetailer"].ToString();
                    ProjectSession.strCompanyid = dsPass.Tables[0].Rows[0]["Comp_ID"].ToString();
                    ProjectSession.strCompanyName = dsPass.Tables[0].Rows[0]["Comp_Name"].ToString();
                    ProjectSession.strUserEmail = dsPass.Tables[0].Rows[0]["Comp_Email"].ToString();
                    //ProjectSession.strMobileNo = dsPass.Tables[0].Rows[0]["Mobile"].ToString();
                }
                if ((dsPass.Tables[0].Rows[0]["Comp_type"].ToString() == "L") && (delflag == 1))
                {
                    if (!File.Exists(path))
                    {
                        HttpContext.Current.Session["MyNewMessage"] = "Your account is in-active, please <a href='CompProfile.aspx' style='color:blue;'> update your profile </a> & <a href='frmUploadDocuments.aspx' style='color:blue;'> upload required documents</a>. If already done , please wait for activation from ADMIN.";
                        //HttpContext.Current.Response.Redirect("Manufacturer/CompProfile.aspx");
                        result = "4";
                    }
                    else if ((File.Exists(path)) && (docflag == 0))
                    {
                        if (!chkDoc(dsPass.Tables[0].Rows[0]["Comp_ID"].ToString()))
                        {
                            HttpContext.Current.Session["MyNewMessage"] = "Your account is in-active, please <a href='CompProfile.aspx' style='color:blue;'> update your profile </a> & <a href='frmUploadDocuments.aspx' style='color:blue;'> upload required documents</a>. If already done , please wait for activation from ADMIN.";
                            //HttpContext.Current.Response.Redirect("Manufacturer/frmUploadDocuments.aspx");
                            result = "5";
                        }
                        else
                        {
                            HttpContext.Current.Session["MyNewMessage"] = "Your account is in-active, please <a href='CompProfile.aspx' style='color:blue;'> update your profile </a> & <a href='frmUploadDocuments.aspx' style='color:blue;'> upload required documents</a>. If already done , please wait for activation from ADMIN.";
                            //HttpContext.Current.Response.Redirect("Manufacturer/Message.aspx");
                            result = "6";
                        }
                    }
                    else if ((File.Exists(path)) && (docflag == 1) && (Verdocflag != 7))
                    {
                        HttpContext.Current.Session["MyNewMessage"] = "Your account is in-active, please contact to admin.";
                        HttpContext.Current.Response.Redirect("Manufacturer/Message.aspx");
                    }
                    else if ((File.Exists(path)) && (docflag == 1) && (Verdocflag == 7) && (statusflag == 1))
                        HttpContext.Current.Response.Redirect("Manufacturer/Dashboard.aspx");
                    else if ((File.Exists(path)) && (docflag == 1) && (Verdocflag == 7) && (statusflag == 0))
                    {
                        HttpContext.Current.Session["MyNewMessage"] = "Your account is in-active, please contact to admin.";
                        HttpContext.Current.Response.Redirect("Manufacturer/Message.aspx");
                    }
                }
                else if ((dsPass.Tables[0].Rows[0]["Comp_type"].ToString() == "L") && (delflag == 0))
                {
                    result = "2";
                    return result;
                }
                else
                {
                    if (delflag == 1)
                    {
                        if (!File.Exists(path))
                        {
                            HttpContext.Current.Session["MyNewMessage"] = "Your account has been registered as demo user please <a href='UpDateCompanyProfileDemo.aspx' style='color=blue;'>update your profile</a>";
                            HttpContext.Current.Response.Redirect("Manufacturer/UpDateCompanyProfileDemo.aspx");
                        }
                        else if ((File.Exists(path)) && (statusflag == 0))
                        {
                            HttpContext.Current.Session["MyNewMessage"] = "Your account is in-active, please wait for activation from ADMIN.";
                            HttpContext.Current.Response.Redirect("Manufacturer/Message.aspx");
                        }
                        else if ((File.Exists(path)) && (statusflag == 1))
                        {
                            HttpContext.Current.Session["MyNewMessage"] = "You are registered as demo user.";
                            HttpContext.Current.Response.Redirect("Manufacturer/Dashboard.aspx");
                        }
                    }
                    else
                    {
                        result = "2";
                        return result;
                    }
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        else
        {
            result = "3";
            return result;
        }
        return result;
    }

    private static bool chkDoc(string p)
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = p;
        DataSet ds = function9420.ChkUploadDocFlag(Reg);
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    private static string GetIP()
    {
        string Ipaddress;
        Ipaddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (Ipaddress == "" || Ipaddress == null)
        {
            Ipaddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }

        return Ipaddress;
    }


    public static string saveinterusted(string InterCompNm, string InterEmail, string InterUserNm, string InterMobileNo)
    {
        string result = "";
        Object9420 obj = new Object9420();
        obj.Comp_Name = InterCompNm.Trim().Replace("'", "''").ToString();
        obj.Comp_Email = InterEmail.Trim().Replace("'", "''").ToString();
        obj.Contact_Person = InterUserNm.Trim().Replace("'", "''").ToString();
        obj.Mobile_No = InterMobileNo.Trim().Replace("'", "''").ToString();
        obj.Status = 0;
        obj.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        function9420.InterestedAsDemo(obj);
        #region Mial Body
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + InterUserNm + ",</strong></em></span><br />" +
        " <br />" +
        "<br/> Your Interest for demo for VCQRU.COM Services has been received successfully. <br/> " +
        " Your details : -   <br />" +
        " <span><em><strong>Contact Person : -</strong></em> " + obj.Contact_Person + "</span><br />" +
        " <span><em><strong>Company Name : -</strong></em> " + obj.Comp_Name + "</span><br />" +
        " <span><em><strong>Mobile No : -</strong></em> " + obj.Mobile_No + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + obj.Comp_Email + "</span><br />" +
        " <span>Thank you for choosing VCQRU.COM</span><br/>" +
        " We will contact you soon.   <br />" +
        " <br />" +
        " <br />" +
        " <p>" +
        " <div class='w_detail'>" +
        " Assuring you  of  our best services always.<br />" +
        " Thank you,<br /><br />" +
        " Team <em><strong>VCQRU.COM,</strong></em><br />" +
        "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";

        string MailBody1 = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>, Sales person</strong></em></span><br />" +
        " <br />" +
        "<br/> <strong>" + obj.Comp_Name + "</strong> send Interested for demo request successfully. <br/> " +
        " Interested for Demo Manufacturer details : -   <br />" +
        " <span><em><strong>Contact Person : -</strong></em> " + obj.Contact_Person + "</span><br /></div>" +
        " <span><em><strong>Company Name : -</strong></em> " + obj.Comp_Name + "</span><br />" +
        " <span><em><strong>Mobile No : -</strong></em> " + obj.Mobile_No + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + obj.Comp_Email + "</span><br />" +
        " Thank you,<br /><br />" +
        " Team <em><strong>VCQRU.COM,</strong></em><br />" +
        "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";
        #endregion
        DataSet dsMl = function9420.FetchMailDetail("register");
        if (dsMl.Tables[0].Rows.Count > 0)
        {
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Comp_Email, MailBody, "Interested for Demo Registration");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.admin_accomplishtrades, MailBody1, "Interested for Demo Registration");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Marketing_accomplishtrades, MailBody1, "Interested for Demo Registration");
        }
        result = "<b>Dear " + InterUserNm + "</b><br/> Thanks for registration with us. Our team will contact you soon. <br/> <br/> <b> Thank you,</b> <br/> Team: VCQRU.COM <br/>  " + ProjectSession.sales_accomplishtrades + " ";
        return result;

    }


    public static int logout()
    {
        int result = 0;
        string IP = GetIP();
        if (HttpContext.Current.Session["User_Type"].ToString() == "Admin")
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Login_History] SET [Logout_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE CONVERT(VARCHAR,Login_Date,111)= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' AND User_ID = '" + HttpContext.Current.Session["User_Type"].ToString() + "'  AND user_Type = 1 AND (Dial_Mode = '" + IP + "')  AND Row_ID = (SELECT MAX(Row_ID) FROM  Login_History WHERE  User_ID = '" + HttpContext.Current.Session["User_Type"].ToString() + "'  AND (Dial_Mode = '" + IP + "') ) ");
            HttpContext.Current.Session.Abandon();
            //HttpContext.Current.Response.Redirect("Admin/Login.aspx");
            result = 1;
        }
        if (HttpContext.Current.Session["User_Type"].ToString() == "Consumer")
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Login_History] SET [Logout_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE CONVERT(VARCHAR,Login_Date,111)= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' AND User_ID = '" + HttpContext.Current.Session["User_Type"].ToString() + "'  AND user_Type = 1 AND (Dial_Mode = '" + IP + "')  AND Row_ID = (SELECT MAX(Row_ID) FROM  Login_History WHERE  User_ID = '" + HttpContext.Current.Session["USRID"].ToString() + "'  AND (Dial_Mode = '" + IP + "') ) ");
            HttpContext.Current.Session.Abandon();
            //HttpContext.Current.Response.Redirect("Index.aspx");
            result = 2;
        }
        else
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Login_History] SET [Logout_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE CONVERT(VARCHAR,Login_Date,111)= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' AND User_ID = '" + HttpContext.Current.Session["CompanyId"].ToString() + "'  AND user_Type = 0 AND (Dial_Mode = '" + IP + "')  AND Row_ID = (SELECT MAX(Row_ID) FROM  Login_History WHERE  User_ID = '" + HttpContext.Current.Session["CompanyId"].ToString() + "'  AND (Dial_Mode = '" + IP + "') ) ");
            HttpContext.Current.Session.Abandon();
            //HttpContext.Current.Response.Redirect("Index.aspx");
            result = 3;
        }
        return result;
    }
    public static string deleteaccount()
    {
        return "Your account has been deleted permanently, please contact to admin.";
    }
    public static string verifyresetpwd(string value)
    {
        string result = "";
        string mailstatsflag = value;
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Mail_Status] FROM [ResetPassword] where [Encrypt_Value] = '" + mailstatsflag.Replace(" ", "+") + "'");   //where User_ID = '" + ds1.Tables[0].Rows[0]["User_ID"].ToString() + "'
        if (ds.Tables[0].Rows.Count > 0)
        {
            if (ds.Tables[0].Rows[0]["Mail_Status"].ToString() == "1")
            {
                result = "Link expired, Please try again.";
            }
            else
            {
                SQL_DB.ExecuteNonQuery("update ResetPassword set Mail_Status = 1 where [Encrypt_Value] = '" + mailstatsflag.Replace(" ", "+") + "'");
                result = "yes";
            }
        }
        return result;
    }
    public static string DecryptCode(string name)
    {
        if (!string.IsNullOrEmpty(name))
        {
            return DataProvider.LogManager.Decrypt(name);
        }
        else
        {
            return "";
        }
    }
    public static string CheckReferral(string c1, string c2)
    {
        if (!string.IsNullOrEmpty(c1) && !string.IsNullOrEmpty(c2))
        {
            //return DataProvider.LogManager.Decrypt(name);
            //SQL_DB.ExecuteScalar("select row_id from ");
            //CheckReferral
            DataSet ds = ExecuteNonQueryAndDatatable.CheckReferral(c1, c2);
            if (ds.Tables.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    string strval = Convert.ToString(dt.Rows[0][0]);
                    if (!string.IsNullOrEmpty(strval))
                        return strval;
                    else
                    {
                        return "";
                    }
                }
                else
                {
                    return "";
                }
            }
        }
        return "";
    }

    public static string checkWarranty(string C1, string C2)
    {
        Object9420 Reg = new Object9420();
        Reg.Received_Code1 = (C1.Trim().Replace("'", "''"));
        Reg.Received_Code2 = (C2.Trim().Replace("'", "''"));

        DataSet ds = ServiceLogic.FindCheckedCode_2(Reg);
        DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
        if (ds.Tables[0].Rows.Count == 0)
        {
            Reg.Is_Success = 0;
            //Business9420.function9420.InsertCodeChecked(Reg);
            return ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, C1, C1, "Service_ID='InvalidCode'");
            // result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
            // return result; // it should if not graranted shweta

        }
        else
        {
            if (!string.IsNullOrEmpty(C1) && !string.IsNullOrEmpty(C2))
            {
                ds = ExecuteNonQueryAndDatatable.CheckWarranty(C1, C2);
                if (ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        if (dt.Columns.Contains("PlanName"))
                        {
                            string strval = Convert.ToString(dt.Rows[0]["PlanName"]);
                            if (!string.IsNullOrEmpty(strval))
                                return strval;
                            else
                                return "";
                        }
                        else
                        {
                            //string strval = Convert.ToString(dt.Rows[0][1]);
                            string strval = Convert.ToString(dt.Rows[0][0]);
                            if (strval.Split('&').Length > 3)
                                HttpContext.Current.Session["service"] = strval.Split('&')[3];
                            if (!string.IsNullOrEmpty(strval))
                            {
                                if (strval.Split('&').Length > 0)
                                    HttpContext.Current.Session["companyname"] = strval.Split('&')[1];
                                return strval;
                            }
                            else
                                return "";
                        }
                    }
                    else
                    {
                        return "";
                    }
                }
            }
            return "";
        }
    }
    public static string appcheckWarranty(string C1, string C2, string MobileNo, string mode)
    {
        Object9420 Reg = new Object9420();
        app_details app = new app_details();
        Reg.Received_Code1 = (C1.Trim().Replace("'", "''"));
        Reg.Received_Code2 = (C2.Trim().Replace("'", "''"));
        string result = "";

        if (MobileNo == "")
        {
            result = "Kindly Enter Your Mobile No.";
        }

        if (MobileNo.Length < 10)
        {
            result = "Mobile No. must be 10 digits!";
        }
        if (MobileNo.Length == 11)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
            }
        }
        if (MobileNo.Length == 13)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
            }
        }
        if (MobileNo.Length == 12)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
            if (initial == 91)
                MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
        }
        if (MobileNo.Length == 10)
            MobileNo = "91" + MobileNo;
        Reg.Mobile_No = MobileNo;
        if (result != "")
        {
            app.message = result;
            // result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
            // return result; // it should if not graranted shweta
            app.status = "Error";
            return JsonConvert.SerializeObject(app, Formatting.Indented);
        }

        Reg.Dial_Mode = mode;
        string fields = string.Empty;
        DataSet ds = ServiceLogic.FindCheckedCode_2(Reg);
        DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
        string distributorid= SQL_DB.ExecuteScalar("select isnull(distributorid,0) distributorid from m_consumer where mobileno='" + MobileNo + "'").ToString();
        if (ds.Tables[0].Rows.Count == 0)
        {
            Reg.Is_Success = 0;
            Business9420.function9420.appInsertCodeChecked(Reg);
            app.message = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, C1, C2, "Service_ID='InvalidCode'");
            // result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
            // return result; // it should if not graranted shweta
            app.status = "Invalid";
            return JsonConvert.SerializeObject(app, Formatting.Indented);

        }
        else
        {
            if (!string.IsNullOrEmpty(C1) && !string.IsNullOrEmpty(C2))
            {
                ds = ExecuteNonQueryAndDatatable.appCheckWarranty(C1, C2);
                if (ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        if (dt.Columns.Contains("PlanName"))
                        {
                            string strval = Convert.ToString(dt.Rows[0]["PlanName"]);
                            if (!string.IsNullOrEmpty(strval))
                                return strval;
                            else
                                return "";
                        }
                        else
                        {
                            //string strval = Convert.ToString(dt.Rows[0][1]);
                            //string strval = Convert.ToString(dt.Rows[0][0]);
                            //if(strval.Length>0)
                            //    HttpContext.Current.Session["service"] = strval.Split('&')[3];
                            //if (!string.IsNullOrEmpty(strval))
                            //    return strval;
                            //else
                            //    return "";
                            foreach (DataRow item in ds.Tables[1].Rows)
                            {
                                if(distributorid!="0"&& item["Field_name"].ToString()=="Dealer Id")
                                { }
                                else
                                    fields += item["Field_name"].ToString() + FieldSeparator;
                            }
                            if (fields.Length > 0)
                                fields = fields.Remove(fields.LastIndexOf(FieldSeparator), FieldSeparator.Length);

                            app.code1 = C1;
                            app.code2 = C2;
                            if (ds.Tables[1].Rows.Count > 0)
                                app.ServiceId = ds.Tables[1].Rows[0]["Service_id"].ToString();
                            app.CompanyName = ds.Tables[0].Rows[0][0].ToString().Split('&')[0];
                            app.Logopath = ds.Tables[0].Rows[0][0].ToString().Split('&')[1];
                            app.fields = fields;
                            app.status = "Valid";
                            return JsonConvert.SerializeObject(app, Formatting.Indented);
                        }
                    }
                    else
                    {
                        return "";
                    }
                }
            }
            return "";
        }
    }
    public static string CheckReferralExists(string refcode, string Mno)
    {
        if (!string.IsNullOrEmpty(refcode))
        {
            Mno = ServiceLogic.GetMobileNo(Mno);
            //return DataProvider.LogManager.Decrypt(name);
            //SQL_DB.ExecuteScalar("select row_id from ");
            //CheckReferral
            DataSet ds = ExecuteNonQueryAndDatatable.CheckReferralExists(refcode, Mno);
            if (ds.Tables.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    string strval = Convert.ToString(dt.Rows[0][0]);
                    if (!string.IsNullOrEmpty(strval))
                        return strval;
                    else
                    {
                        return "";
                    }
                }
                else
                {
                    return "";
                }
            }
        }
        return "";
    }
    public static string CatchWebsiteHit()
    {
        string result = "";
        //string mailstatsflag = "";
        string strbrowser = string.Empty;
        //if (HttpContext.Current.Request.ServerVariables["HTTP_USER_AGENT"].Contains("MSIE"))
        //    strbrowser = "Internet Explorer";
        //else if (HttpContext.Current.Request.ServerVariables["HTTP_USER_AGENT"].Contains("Firefox"))
        //    strbrowser = "Mozilla";
        //else if (HttpContext.Current.Request.ServerVariables["HTTP_USER_AGENT"].Contains("Chrome"))
        //    strbrowser = "Mozilla";
        //else if (HttpContext.Current.Request.ServerVariables["HTTP_USER_AGENT"].Contains("Opera"))
        //    strbrowser = "Opera";
        //else 
        if (HttpContext.Current.Request.Browser.IsMobileDevice)
        {
            strbrowser = "Mobile";
            string[] mobiles =
        new[]
            {
                    "midp", "j2me", "avant", "docomo",
                    "novarra", "palmos", "palmsource",
                    "240x320", "opwv", "chtml",
                    "pda", "windows ce", "mmp/",
                    "blackberry", "mib/", "symbian",
                    "wireless", "nokia", "hand", "mobi",
                    "phone", "cdm", "up.b", "audio",
                    "SIE-", "SEC-", "samsung", "HTC",
                    "mot-", "mitsu", "sagem", "sony"
                    , "alcatel", "lg", "eric", "vx",
                    "NEC", "philips", "mmm", "xx",
                    "panasonic", "sharp", "wap", "sch",
                    "rover", "pocket", "benq", "java",
                    "pt", "pg", "vox", "amoi",
                    "bird", "compal", "kg", "voda",
                    "sany", "kdd", "dbt", "sendo",
                    "sgh", "gradi", "jb", "dddi",
                    "moto", "iphone"
            };

            //Loop through each item in the list created above 
            //and check if the header contains that text
            foreach (string s in mobiles)
            {
                if (HttpContext.Current.Request.ServerVariables["HTTP_USER_AGENT"].
                                                    ToLower().Contains(s.ToLower()))
                {
                    strbrowser = strbrowser + " - " + s.ToLower();
                }
            }
        }

        //  SQL_DB.ExecuteNonQuery("Insert into WebsiteHitHistory values ('" + GetIP() + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now) + "','" + strbrowser + "')");
        //if (ds.Tables[0].Rows.Count > 0)
        //{
        //    if (ds.Tables[0].Rows[0]["Mail_Status"].ToString() == "1")
        //    {
        //        result = "Link expired, Please try again.";
        //    }
        //    else
        //    {
        //        SQL_DB.ExecuteNonQuery("update ResetPassword set Mail_Status = 1 where [Encrypt_Value] = '" + mailstatsflag.Replace(" ", "+") + "'");
        //        result = "yes";
        //    }
        //}
        return result;
    }
    public static string verifyaccount(string value)
    {
        string result = "";
        string compid = Decrypt(value.Replace(" ", "+"));
        string key = "select Email_Vari_Flag,Comp_Email,Comp_Name,Contact_Person from Comp_Reg where Comp_ID = '" + compid + "'";
        DataSet ds = SQL_DB.ExecuteDataSet("select Email_Vari_Flag,Comp_Email,Comp_Name,Contact_Person from Comp_Reg where Comp_ID = '" + compid + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            string ps = "";
            if (ds.Tables[0].Rows[0]["Email_Vari_Flag"].ToString() == "0")
            {
                SQL_DB.ExecuteNonQuery("update Comp_Reg set Email_Vari_Flag = 1 where Comp_ID = '" + compid + "'");
                Random rnd = new Random();
                ps = rnd.Next().ToString().Substring(0, 5);
                SQL_DB.ExecuteNonQuery("UPDATE [Comp_Reg] SET [Password]='" + ps + "' WHERE [Comp_ID]='" + compid + "'");
                #region MailBody
                string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
                " <hr style='border:1px solid #2587D5;'/>" +
                " <div class='w_frame'>" +
                " <p>" +
                " <div class='w_detail'>" +
                " <span>Dear <em><strong>" + ds.Tables[0].Rows[0]["Contact_Person"].ToString() + ",</strong></em></span><br />" +
                " <br />" +
                " <span>Congratulations !!!</span>" +
                " <br />Your login details are as follows:- <br />" +
                " <table border='0' cellspacing='2'>" +
                " <tr>" +
                " <td width='70' align='left'><strong>Login ID :&nbsp; </strong></td>" +
                " <td width='282'><a href='#'>" + ds.Tables[0].Rows[0]["Comp_Email"].ToString() + "</a></td>" +
                " </tr>" +
                " <tr>" +
                " <td align='left' valign='top'><strong>Password :&nbsp;</strong></td>" +
                " <td>" + ps + "</td>" +
                " </tr>" +
                "<tr><td colspan='2'><a href='" + ProjectSession.absoluteSiteBrowseUrl + "/default.aspx#logsign'  target='_blank'><strong>CLICK HERE TO LOGIN</strong></a></td></tr>" +
                " </table>" +
                " <tr>" +
                " <td align='left' valign='top' colspan='2'><strong>Please login with above credentials and upload your company documents. Then please wait for our notification on your document verification and account activation <br> If you face any problem in login with above credentials, please feel free to email our support team</strong></td>" +
                " </tr>" +
                " </table>" +
                " <p>" +
                " <div class='w_detail'>" +
                " Assuring you  of  our best services always.<br />" +
                " Thank you,<br /><br />" +
                " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                " </div>" +
                " </p>" +
                " </div>" +
                " </p>" +
                " </div> " +
                " </div> ";

                string MailBody1 = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
               " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
               " <hr style='border:1px solid #2587D5;'/>" +
               " <div class='w_frame'>" +
               " <p>" +
               " <div class='w_detail'>" +
               " <span>Dear <em><strong>, Sales person</strong></em></span><br />" +
               " <br />" +
               "<br/> <strong>" + ds.Tables[0].Rows[0]["Comp_Name"].ToString() + "'s</strong> E-mail verification has been completed. <br/> " +
               " Thank you,<br /><br />" +
               " Team <em><strong>VCQRU.COM,</strong></em><br />" +
               "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
               " </div>" +
               " </p>" +
               " </div>" +
               " </p>" +
               " </div> " +
               " </div> ";

                #endregion
                DataSet dsMl = function9420.FetchMailDetail("admin");
                if (dsMl.Tables[0].Rows.Count > 0)
                {
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ds.Tables[0].Rows[0]["Comp_Email"].ToString(), MailBody, "User login credential");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Company E-mail verification");
                }
                result = "Your account has been verified successfully, Please check your registered mail for login credentials .";
            }
            else
            {
                result = "Your account is already verified.";
            }
        }
        return result;
    }
    public static string forgotpassword(string email)
    {
        string result = "";
        DataTable DtUserDetail = new DataTable();
        SQL_DB.GetDA("SELECT [Contact_Person] ,[Password],* FROM [Comp_Reg] where [Comp_Email] = '" + email.Trim() + "' and (  isnull(delete_flag,0) != 0)").Fill(DtUserDetail);
        if (DtUserDetail.Rows.Count > 0)
        {
            //DataSet dsMail = SQL_DB.ExecuteDataSet("SELECT [Comp_ID] FROM [Comp_Reg] where [Comp_Email] = '" + email.Trim() + "' ");
            // if (dsMail.Tables[0].Rows.Count > 0)
            {
                SQL_DB.ExecuteNonQuery("update ResetPassword set Mail_Status = 1 where User_ID = '" + DtUserDetail.Rows[0]["Comp_ID"].ToString() + "'");
                Random rnd = new Random();
                SQL_DB.ExecuteNonQuery("INSERT INTO [ResetPassword]" +
               " ([Entry_Date]" +
               " ,[User_ID]" +
               " ,[Encrypt_Value])" +
               " VALUES" +
               " ('" + Convert.ToDateTime(System.DateTime.Now).ToString("MM/dd/yyyy HH:mm:ss") + "'" +
               " ,'" + DtUserDetail.Rows[0]["Comp_ID"].ToString() + "'" +
               " ,'" + rnd.Next().ToString().Substring(0, 8) + "')");
            }
            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), email.Trim(), MailTemplate(DtUserDetail.Rows[0]["Contact_Person"].ToString(), (DtUserDetail.Rows[0]["Password"].ToString()), email), "Forgot Password");
            //result = "Please check your email to reset your password.";
            result = "Your password has been sent on your registered email address.";
        }
        else
        {
            result = "Your account is deleted.Please contact administrator!";
        }
        return result;
    }
    public static string forgotpasswordEmp(string email)
    {
        string result = "";
        //DataTable DtUserDetail = new DataTable();
        //SQL_DB.GetDA("SELECT [Name] ,[pwd] FROM [Employee] where [Email] = '" + email.Trim() + "' ").Fill(DtUserDetail);
        //if (DtUserDetail.Rows.Count > 0)
        //{
        //    DataSet dsMail = SQL_DB.ExecuteDataSet("SELECT [Name] ,[pwd] FROM [Employee] where [Email] = '" + email.Trim() + "' ");
        //    if (dsMail.Tables[0].Rows.Count > 0)
        //    {
        //        //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(),
        //        //    dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
        //        //    email.Trim(), MailTemplate(DtUserDetail.Rows[0]["Contact_Person"].ToString(),
        //        //    (DtUserDetail.Rows[0]["Password"].ToString()), email), "Forgot Password");
        //        // SQL_DB.ExecuteNonQuery("update ResetPassword set Mail_Status = 1 where User_ID = '" + dsMail.Tables[0].Rows[0]["Comp_ID"].ToString() + "'");
        //        // Random rnd = new Random();
        //        // SQL_DB.ExecuteNonQuery("INSERT INTO [ResetPassword]" +
        //        //" ([Entry_Date]" +
        //        //" ,[User_ID]" +
        //        //" ,[Encrypt_Value])" +
        //        //" VALUES" +
        //        //" ('" + Convert.ToDateTime(System.DateTime.Now).ToString("MM/dd/yyyy HH:mm:ss") + "'" +
        //        //" ,'" + dsMail.Tables[0].Rows[0]["Comp_ID"].ToString() + "'" +
        //        //" ,'" + rnd.Next().ToString().Substring(0, 8) + "')");
        //    }
        //    DataSet dsMl = function9420.FetchMailDetail("admin");
        //    if (dsMl.Tables[0].Rows.Count > 0)
        //        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), email.Trim(), MailTemplate(DtUserDetail.Rows[0]["Contact_Person"].ToString(), (DtUserDetail.Rows[0]["Password"].ToString()), email), "Forgot Password");
        //    result = "Please check your email to reset your password.";
        //}
        //else
        //{
        //    result = "Email ID does not exist...";
        //}
        return result;
    }

    private static string MailTemplate(string Name, string Password, string email)
    {
        string srt = "<style type='text/css'>" +
           " .latter" +
           " {" +
               " width:75%;" +
               " border:1px solid #2587D5;" +
               " display:inline-block;" +
               " -webkit-box-shadow: #D9E7FD 3px 3px 3px;" +
               " -moz-box-shadow: #D9E7FD 3px 3px 3px; " +
               " box-shadow: #D9E7FD 3px 3px 3px;" +
               " padding:5px;" +
               " margin-left:100px;" +
           " }" +
           " .latter div.w_logo" +
           " {" +
               " width:100%;" +
               " margin:0 auto;" +
               " background-position:center top;" +
               " height:70px;" +
               " margin-bottom:10px;" +
           " }" +
           " .latter div.w_logo span" +
           " {" +
               " font-size:18pt;" +
               " color:#222;" +
               " float:right;" +
               " font-weight:bold;" +
               " margin-right:45px;" +
               " margin-top:25px;" +
           " }" +
           " .latter div.w_logo img" +
           " {" +
               " height:29px;" +
               " width:300px;" +
           " }" +
           " .latter div.w_frame" +
           " {" +
               " width:98%;" +
               " margin:0 auto;" +
               " font-family:Arial, Helvetica, sans-serif;" +
               " font-size:9pt;" +
               " color:#333;" +
               " line-height:20px;" +
               " margin-bottom:10px;" +
           " }" +
           " .latter div.w_frame p" +
           " {" +
               " text-align:justify;" +
               " padding-bottom:5px;" +
           " }" +
           " .latter div.w_frame p span" +
           " {" +
               " padding-left:20px;" +
           " }" +
           " .w_detail" +
           " {" +
               " padding-left:20px;" +
               " text-align:justify;" +
           " }" +
           " .w_detail a" +
           " {" +
               " color:#095BB4;" +
               " text-decoration:none;" +
           " }" +
           " .w_detail a:hover" +
           " {" +
               " text-decoration:underline;" +
           " }" +
           " .w_foot" +
           " {" +
               " width:99%;" +
               " padding:5px;" +
               " color:#333;" +
               " font-size:8pt;" +
               " text-align:center;" +
               " line-height:13px;" +
               " margin:0 auto;" +
           " }" +
           " hr" +
           " {" +
           "  border:2px solid #2587D5" +
           " }" +
           " </style>";
        string link = "";
        DataSet dsMail = SQL_DB.ExecuteDataSet("SELECT ResetPassword.Encrypt_Value FROM [Comp_Reg] INNER JOIN ResetPassword ON [Comp_Reg].[Comp_ID] = ResetPassword.User_ID" +
        " where Comp_Reg.[Comp_Email]='" + email.Trim().Replace("'", "''").ToString() + "' and Comp_Reg.[Email_Vari_Flag]=1 and  ResetPassword.Mail_Status = 0");
        if (dsMail.Tables[0].Rows.Count > 0)
            // link = "http://54.201.1.244/index.aspx?key=" + dsMail.Tables[0].Rows[0]["Encrypt_Value"].ToString();
            link = "" + ProjectSession.absoluteSiteBrowseUrl + "/default.aspx?mlt=" + dsMail.Tables[0].Rows[0]["Encrypt_Value"].ToString();

        // string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        //       " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        //       " <hr style='border:1px solid #2587D5;'/>" +
        //       " <div class='w_frame'>" +
        //       " <p>" +
        //       " <div class='w_detail'>" +
        //       " <span>Dear <em><strong>" + Name + ",</strong></em></span><br />" +
        //       " <br />" +
        //       " <span><em><strong>Please click the link below to reset your password :  <br/><br/>  <a href = '" + link + "' target = '_blank'> " + ProjectSession.absoluteSiteBrowseUrl + "/default.aspx?mlt=" + dsMail.Tables[0].Rows[0]["Encrypt_Value"].ToString() + " </a></strong></em></span><br/>" +
        //       " <p>" +
        //       " <div class='w_detail'>" +
        //      " Assuring you  of  our best services always.<br />" +
        //" Thank you,<br /><br />" +
        //" Team <em><strong>VCQRU.COM,</strong></em><br />" +
        //"  " + ProjectSession.sales_accomplishtrades + "  <br />" +
        //" </div>" +
        //" </p>" +
        //" </div>" +
        //" </p>" +
        //" </div> " +
        //" </div> ";

        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
         " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
         " <hr style='border:1px solid #2587D5;'/>" +
         " <div class='w_frame'>" +
         " <p>" +
         " <div class='w_detail'>" +
         " <span>Dear <em><strong>" + Name + ",</strong></em></span><br />" +
         " <br />" +
         " <span><em><strong>password : " + Password +
         " <p>" +
         " <div class='w_detail'>" +
        " Assuring you  of  our best services always.<br />" +
    " Thank you,<br /><br />" +
    " Team <em><strong>VCQRU.COM,</strong></em><br />" +
    "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
    " </div>" +
    " </p>" +
    " </div>" +
    " </p>" +
    " </div> " +
    " </div> ";
        return MailBody;
    }



    /// <summary>
    /// /Admin Login
    /// </summary>
    public string Adminlogin(string name, string password)
    {
        string result = "";
        Object9420 Log = new Business9420.Object9420();
        if (name.ToUpper() == "ADMIN")
        {
            Log.User_Type = name.Trim().Replace("'", "''");
            Log.User_ID = name.Trim().Replace("'", "''");
            Log.Password = password.Trim().Replace("'", "''");
            Log.Dial_Mode = GetIP();
            if (Business9420.function9420.FetchDataForAdminLogin(Log))
            {
                HttpContext.Current.Session["User_Type"] = "Admin";
                if (HttpContext.Current.Session["User_Type"] != null)
                {
                    SQL_DB.ExecuteNonQuery("INSERT INTO [Login_History](Dial_Mode,User_ID,Login_Date,User_Type) VALUES ('" + Log.Dial_Mode + "','" + HttpContext.Current.Session["User_Type"].ToString() + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' ,1)");
                    result = "1";
                }
            }
        }
        else
        {
            result = "2";
        }
        return result;
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    public DataRow GetProductName(string c)
    {
        DataRow rsProID = null;
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Pro_Name,PRO_ID FROM Pro_Reg WHERE PRO_ID IN (SELECT PRO_ID FROM M_Code Where CODE1='" + c.Split('-')[0] + "' and CODE2='" + c.Split('-')[1] + "')");
        if (ds.Tables[0].Rows.Count > 0)
            //rsProID = ds.Tables[0].Rows[0]["Pro_Name"].ToString();
            rsProID = ds.Tables[0].Rows[0];
        return rsProID;
    }

    public void SaveWarrentyDetails(string email, string billno, string purchasedate, string mobile, string filePath, string wCode, DateTime expDate, string period)
    {
        DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
        // DateTime expDate = purDate.AddYears(1);
        SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[WarrentyDetails] ([BillNo],[PurchaseDate],[Email],[Mobile],WarrantyPeriod,ExpirationDate,ImagePathBill,IsWarrantyClaimed, code) values ('" + billno + "','" + purDate.ToString("MM/dd/yyyy") + "','" + email + "','" + mobile + "','" + period + "','" + expDate.ToString("MM/dd/yyyy") + "','" + filePath + "', 0, '" + wCode + "')");
    }
    public void SaveWarrentyDetailsforauto(string purchasedate, string mobile, string wCode, DateTime expDate, string period)
    {
        DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
        // DateTime expDate = purDate.AddYears(1);
        SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[WarrentyDetails] ([PurchaseDate],[Mobile],WarrantyPeriod,ExpirationDate,IsWarrantyClaimed, code) values ('" + purDate.ToString("MM/dd/yyyy") + "','" + mobile + "','" + period + "','" + expDate.ToString("MM/dd/yyyy") + "', 0, '" + wCode + "')");
    }
    public void SaveCompanyDetails(string cName, string pName, string purchasedate, string empId, string disId, string wCode, int otpCode, string mobileNumber)
    {
        DataSet dsOtpCheck = SQL_DB.ExecuteDataSet("Select * from [dbo].[CompanyProduct] Where mobileNumber='" + mobileNumber + "' and employeeID='" + empId + "' and distributorID='" + disId + "' and otp='" + otpCode + "' and [status]=1");
        if (dsOtpCheck.Tables[0].Rows.Count > 0)
        {
            DateTime expDate = System.DateTime.Now.AddYears(1); //purDate.AddYears(1);
            SQL_DB.ExecuteNonQuery("update [dbo].[CompanyProduct] set otp='" + otpCode + "', [status]=0 where mobileNumber='" + mobileNumber + "' and employeeID='" + empId + "' and distributorID='" + disId + "'");
        }
        else
        {
            DateTime expDate = System.DateTime.Now.AddYears(1); //purDate.AddYears(1);
            SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[CompanyProduct] ([companyName],[productName],[expiryDate],[employeeID],[distributorID], [code], [otp], [status],[mobileNumber]) values ('" + cName + "','" + pName + "','" + expDate.ToString("MM/dd/yyyy") + "','" + empId + "','" + disId + "','" + wCode + "', '" + otpCode + "', 0, '" + mobileNumber + "')");
        }
    }


    public void UpdateClaimWarrentyDetails(string comment, string filePath, string id)
    {
        SQL_DB.ExecuteNonQuery("update [dbo].[WarrentyDetails] set [IsWarrantyClaimed]=1,[Comment]='" + comment + "',VendorClaimStatus='Pending', ImagePath='" + filePath + "', claimdate='" + System.DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "' where id=" + id + "");
    }
    public void UpdateClaimWarrentyDetailsVendor(string comment, string approveStatus, string id)
    {
        SQL_DB.ExecuteNonQuery("update [dbo].[WarrentyDetails] set VendorClaimStatus='" + approveStatus + "',[VendorComments]='" + comment + "' where id=" + id + "");
    }

    public void InsertFiles(string email, string fileName, string mobile, string filePath, string WarId)
    {
        SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[File] ([Email],[Mobile],FileName,FilePath,WarId) values ('" + email + "','" + mobile + "','" + fileName + "','" + filePath + "'," + WarId + ")");
    }

    public DataSet GetFiles(int id)
    {
        return SQL_DB.ExecuteDataSet("select filepath from file where WarId=" + id);
    }

    public static DataSet CheckEmployeeDetails(string eID, string dID)
    {
        DataSet dsEmployee = SQL_DB.ExecuteDataSet("SELECT * FROM M_DealerMaster WHERE replace(ltrim(replace(DealerTechnicianId,'0',' ')),' ','0')  = '" + eID.TrimStart(new Char[] { '0' }) + "' and replace(ltrim(replace(DealerCode,'0',' ')),' ','0') ='" + dID.TrimStart(new Char[] { '0' }) + "' and d_Status='Active' ");
        return dsEmployee;
    }

    public static DataSet CheckDistrbutorDetails(string eID, string dID)
    {
        DataSet dsDistrbutor = SQL_DB.ExecuteDataSet("SELECT * FROM M_DealerMaster WHERE replace(ltrim(replace(DealerTechnicianId,'0',' ')),' ','0') = '" + eID.TrimStart(new Char[] { '0' }) + "' and replace(ltrim(replace(DealerCode,'0',' ')),' ','0')='" + dID.TrimStart(new Char[] { '0' }) + "' and d_Status='Active' ");
        return dsDistrbutor;
    }

    public DataSet ProductID(string c1, string c2)
    {
        return SQL_DB.ExecuteDataSet("SELECT Pro_ID FROM M_Code WHERE code1 = '" + c1 + "' and code2='" + c2 + "'");
    }

    public DataSet OTPVerify(string otpCode, string mobile, string eId, string dId)
    {
        SQL_DB.ExecuteNonQuery("Update COMPANYPRODUCT set status = 1 where otp = '" + otpCode + "' and MobileNumber='" + mobile + "'");
        return SQL_DB.ExecuteDataSet("SELECT * FROM COMPANYPRODUCT WHERE otp = '" + otpCode + "' and MobileNumber='" + mobile + "' and status=1 and employeeID='" + eId + "' and distributorID='" + dId + "'");
    }
    public DataSet app_OTPVerify(string otpCode, string mobile)
    {
        SQL_DB.ExecuteNonQuery("Update COMPANYPRODUCT set status = 1 where otp = '" + otpCode + "' and MobileNumber='" + mobile + "'");
        return SQL_DB.ExecuteDataSet("SELECT  top 1 otp FROM COMPANYPRODUCT WHERE MobileNumber='" + mobile + "' order by  [expiryDate] Desc, DateAdd(Second, -1, Cast([expiryDate] as time)) desc");

    }
    // Generate a random number between two numbers    
    public int RandomNumber(int min, int max)
    {
        Random random = new Random();
        return random.Next(min, max);
    }
    public static Location locationdetails()
    {
        string ipAddress = GetIP();
        //string APIKey = "8287343040a884bee543a519fe0bd28ad723a102550e6526ca9a2167c3c0f924";
        // string url = string.Format("http://api.ipinfodb.com/v3/ip-city/?key={0}&ip={1}&format=json", APIKey, ipAddress);
        //string url = "https://api.ip2location.com/v2/?ip=" + ipAddress + "&key=5QX2GKT5BA&package=WS9";
        //using (WebClient client = new WebClient())
        //{
        //    string json = client.DownloadString(url);
        //    Location location = new JavaScriptSerializer().Deserialize<Location>(json);
        //    List<Location> locations = new List<Location>();
        //    locations.Add(location);
        //    return location;
        //    //SQL_DB.ExecuteNonQuery("insert into userDetails values('" + Reg.Consumer_ID + "','" + location.CityName + "','" + location.RegionName + "','" + location.CountryName + "','" + location.CountryCode + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "','" + location.IPAddress + "','"+location.ZipCode+"','"+location.Latitude+"','"+location.Longitude+"')");

        //}

        string url = "https://api.ip2location.com/v2/?ip=" + ipAddress + "&key=5QX2GKT5BA&package=WS9";

        ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;

        HttpWebRequest http = (HttpWebRequest)HttpWebRequest.Create(url);


        HttpWebResponse response = (HttpWebResponse)http.GetResponse();
        using (StreamReader sr = new StreamReader(response.GetResponseStream()))
        {
            string json = sr.ReadToEnd();
            Location location = new JavaScriptSerializer().Deserialize<Location>(json);
            List<Location> locations = new List<Location>();
            locations.Add(location);
            return location;
            // SQL_DB.ExecuteNonQuery("insert into visitor values('" + location.city_name + "','" + location.region_name + "','" + location.country_name + "','" + location.country_code + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "','" + ipAddress + "','" + location.zip_code + "','" + location.latitude + "','" + location.longitude + "')");

        }





    }
    public string warranrty(string email, string mobile, string purchasedate, string code, string billno, string path)
    {
        string period = string.Empty;
        DateTime expDate = DateTime.Today;
        // foreach (HttpPostedFile file in context.Request.Files)

        string virtualPath = "~/WarrantyFile/" + path;

        DataRow product_details = GetProductName(code);
        string prdName = product_details["Pro_name"].ToString();
        DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(code);
        DataRow[] servicedetais = dsServicesAssign.Tables[0].Select("Service_id = 'SRV1023'");

        DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
        period = servicedetais[0]["WarrantyPeriod"].ToString();
        expDate = purDate.AddMonths(Convert.ToInt32(period));
        //DateTime expDate = purDate.AddYears(1);

        string strWar = "Warranty for the " + prdName +
              "has been registered successfully, Warranty validity till " + expDate + " To claim your warranty visit <a href='https://www.vcqru.com/'>https://www.vcqru.com/</a>";
        HttpContext.Current.Session["strWar"] = strWar;


        SaveWarrentyDetails(email, billno, purchasedate, mobile, virtualPath, code, expDate, period);
        /////////////////////////////////////////////

        if (mobile.Length == 10)
            mobile = "91" + mobile;

        DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email],Password FROM [M_Consumer] where [MobileNo] = '" + mobile + "'");
        if (dcs.Tables[0].Rows.Count > 0)
        {
            string ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
            string pass = dcs.Tables[0].Rows[0]["Password"].ToString();
            string MailBody = "";
            MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                                       " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
                                       " <hr style='border:1px solid #2587D5;'/>" +
                                       " <div class='w_frame'>" +
                                       " <p>" +
                                       " <div class='w_detail'>" +
                                       " <span>Dear <em><strong> Sir/Mam,</strong></em></span><br />" +
                                       " <br />" +
                                       " <span>Warranty registered successfully. Login to https://vcqru.com/default.aspx#logsign  Claim warranty </span><br />" +
                                       " Your Login Credentials  <br /> <strong> User Id - " + email + "</strong><br /> <strong> Password - " + pass + "</strong>  " +
                                       "<br /><br /> We will contact you soon.   <br />" +
                                       " <p>" +
                                       " <div class='w_detail'>" +
                                       " Assuring you  of  our best services always.<br />" +
                                       " Thank you,<br /><br />" +
                                       " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                                       "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                                       " </div>" +
                                       " </p>" +
                                       " </div>" +
                                       " </p>" +
                                       " </div> " +
                                       " </div> ";

            DataSet dsMl = function9420.FetchMailDetail("support");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
                    email, MailBody, "Warranty Registration");

            }
        }
        return strWar;
        ////////////////////////////////////////////////
        // ConsumerRegisterAndEma
    }
    public string getimagepaths(string id)
    {
        StringBuilder sr = new StringBuilder();
        DataTable dt = new DataTable();
        dt = SQL_DB.ExecuteDataTable("select filepath from [file] where Warid='" + id + "'");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (i == dt.Rows.Count - 1)
            {
                sr.Append(dt.Rows[i][0].ToString());
            }
            else
            {
                sr.Append(dt.Rows[i][0].ToString() + ",");
            }
        }
        return sr.ToString();

    }
}