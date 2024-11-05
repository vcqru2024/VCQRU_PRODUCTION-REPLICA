﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.IO;
using System.Text;
using Business9420;
using Business_Logic_Layer;
using CodesGenuinity;
using DataProvider;
using ExotelSDK;
using System.Configuration;

public partial class sms_recieve : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            HttpContext.Current.Session["long"] = null;
            HttpContext.Current.Session["long"] = null;

            //  int i =System.Convert.ToInt32("ss");
            //Literal lt = new Literal();
			//DataProvider.LogManager.ErrorExceptionLog("smsreceive:"+System.Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            //lt.Text = "Cong! Earned 10 points.Redeem-VCQRU.COM/Info/Consumerregister.aspx#trylogin";
            //ServiceLogic.SendSms(lt.Text.ToString(), "9714198676");
            //LogManager.WriteExe("Url Hit from " + Request.QueryString["from"].ToString());
            //SendSms("testABC451", "+919714198676", "");
            //  SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('Server Hit')");
            string code1 = "", code2 = "";
            //if (Request.QueryString["msg"] == null)
            //    return;
            //if (Request.QueryString["message"] == null)
            //    return;
            string str2 = "", MobileNo = "", Type = "SMS";



            //if (Request.QueryString["message"] != null)
            //{
            //    str2 = (Request.QueryString["message"]).Trim();
            //    MobileNo = Request.QueryString["from"].ToString();
            //    Type = "Solution";
            //    SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('Solution "+MobileNo+"')");
            //}
            if (Request.QueryString["Body"] != null)
            {

                // SendSms("shweta", "+919714198676", "");
                // Response.Write("done");
                //ttp://etsrds.kapps.in/webapi/accomplish/api/accomplish_T897_sms.py?BODY=shweta&customer_number=9714198676
                str2 = Request.QueryString["Body"].ToString();
                //str2 = "1234567891234";
                //MobileNo = Request.QueryString["From"].ToString();
                // Type = "BSmart";
                //string valstr = MobileNo + " " + Request.QueryString["Body"].ToString() + " " + Request.QueryString["To"].ToString(); // +" " + Request.QueryString["Date"].ToString();
                //SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('"+valstr+"')");

            }
            string callerno = string.Empty;
            string time = string.Empty;
            string vdate = string.Empty;
            string callercircle = string.Empty;
            string network = string.Empty;
            if (Request.QueryString["callerno"] != null)
            {
                callerno = Request.QueryString["callerno"].ToString();

            }
            if (Request.QueryString["time"] != null)
            {
                time = Request.QueryString["time"].ToString();
            }
            if (Request.QueryString["date"] != null)
            {
                vdate = Request.QueryString["date"].ToString();
            }
            if (Request.QueryString["callercircle"] != null)
            {
                callercircle = Request.QueryString["callercircle"].ToString();
            }
            if (Request.QueryString["network"] != null)
            {
                network = Request.QueryString["network"].ToString();
            }
            //+919714198676-12345-12345677-09:45:12-2018-07-27-Gujarat-Idea Cellu
            //callerno = "+919714198676";
            //time = "09:45:12";
            //vdate = "2018-07-27";
            //callercircle = "Gujarat";
            //network = "Idea Cellu";
            //str2 = "1234512345677";
            if (str2.Length > 0)
            {

                code1 = str2.Substring(0, 5);
                code2 = str2.Substring(5, 8);

                // string Msg = CheckGenuinity.Genuinity(code1, code2, MobileNo, "SMS", MobileNo, Type);
                string Msg = CheckGenuinity.Genuinity(code1, code2, callerno, "SMS", callerno, callercircle, network, vdate, time, Type);
                //SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('" + Msg + "')");
                string[] Arr = Msg.ToString().Split('*');
                if (Arr.Length >= 1)
                {
                    // if (Arr[1].ToString() != "")
                    {
                        //     string[] NArr = Arr[1].ToString().Split('@');
                        //     if (NArr.Length > 0)
                        {
                            for (int i = 0; i < Arr.Length; i++)
                            {
                                //SendSms("testABC", "+919714198676", "");
                                if (!string.IsNullOrEmpty(Arr[i].ToString()))
                                {
                                    SendSms(Arr[i].ToString(), callerno, Type);
                                }
                            }
                        }
                    }
                }
            }
            //SendSms(Arr[1].ToString(), MobileNo, Type);
        }
        catch (Exception ex)
        {
            //SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('error - " + ex.Message + "')");
            //string ErrorPagePath = HttpContext.Current.Request.Url.ToString();
            //Exception ErrorInfo = ex.GetBaseException(); //HttpContext.Current.Server.GetLastError().GetBaseException();
            DataProvider.LogManager.ErrorExceptionLog(System.Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            //DataProvider.LogManager.ErrorExceptionLog(ErrorPagePath);
            //DataProvider.LogManager.ErrorExceptionLog(ErrorInfo.Message);
            //DataProvider.LogManager.ErrorExceptionLog("\n" + ErrorInfo.StackTrace + "\n");
            //DataProvider.LogManager.ErrorExceptionLog("\n UserHostAddress: " + Convert.ToString(HttpContext.Current.Request.UserHostAddress) + ",REMOTE_ADDR: " + HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] + ", HTTP_X_FORWARDED_FOR: " + Convert.ToString(HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"]));
            ////throw ex;
        }
    }

    private bool CheckProduct(string ProId)
    {
        DataTable dt = SQL_DB.ExecuteDataTable("SELECT * FROM Pro_Reg WHERE Pro_ID = '"+ ProId +"' ");
        if (dt.Rows.Count > 0)
            return true;
        else
            return false;
    }
    #region Send SMS
    public static void SendSms(string Message, string phone, string ApiType)
    {

        string str = "";
        try
        {
            ServiceLogic.SendSMSFromAlfa(phone, Message,"Transaction");
            //if (ConfigurationManager.AppSettings["SMS"] == "Knowlarity")
            //{

            //    //http://sms.bsmart.in:8080/smart/SMSmartSendSMS.jsp?http://sms.bsmart.in:8080/smart/SmartSendSMS.jsp
            //    //str = "http://sms.bsmart.in:8080/smart/SMSmartSendSMS.jsp?usr=LABEL9420&pass=LABEL890&sid=LBVRFY&GSM=" + phone + "&msg=" + Message + "&mt=0";
            //    //str = "http://193.105.74.58/api/v3/sendsms/plain?user=LABEL9420&password=Sid2014!&sender=labeld&SMSText=" + Message + "&GSM=" + phone;
            //    //str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A7285cc769f5ed203e7d8cee48444dbb8&sender=SIDEMO&to=" + phone + "&message=" + Message;

            //    //str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A3f78a344d70a9e35c006e938f428f591&sender=LBVRFY&to=" + phone + "&message=" + Message;
            //    //if (ApiType == "Solution")
            //    //{
            //    //str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A3f78a344d70a9e35c006e938f428f591&sender=LBVRFY&to=" + phone + "&message=" + Message;
            //    str = "http://etsrds.kapps.in/webapi/accomplish/api/accomplish_T897_sms.py?customer_number=" + phone + "&sms_text=" + Message;
            //    WebRequest request = WebRequest.Create(str);
            //    request.Method = "POST";
            //    string postData = "";
            //    byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            //    request.Headers.Add("auth_key", "fJeVv745L-rI6TPSZqgb-Z3U6mvgZ-ODYI0");
            //    request.ContentType = "application/x-www-form-urlencoded";//application/     x-www-form-urlencoded
            //    request.ContentLength = byteArray.Length;
            //    Stream dataStream = request.GetRequestStream();
            //    dataStream.Write(byteArray, 0, byteArray.Length);
            //    dataStream.Close();
            //    WebResponse response = request.GetResponse();
            //    Console.WriteLine(((HttpWebResponse)response).StatusDescription);
            //    dataStream = response.GetResponseStream();
            //    StreamReader reader = new StreamReader(dataStream);
            //    string responseFromServer = reader.ReadToEnd();
            //    Console.WriteLine(responseFromServer);
            //    reader.Close();
            //    dataStream.Close();
            //    string function = "console.log('{0}');";
            //    string log = string.Format(GenerateCodeFromFunction(function), responseFromServer);
            //    HttpContext.Current.Response.Write(log);
            //    response.Close();
            //    //}
            //    //else if (ApiType == "BSmart")
            //    //{
            //    //    //str = "http://193.105.74.58/api/v3/sendsms/plain?user=LABEL9420&password=Sid2014!&sender=labeld&SMSText=" + Message + "&GSM=" + phone;
            //    //    SendSMS s = new SendSMS("label94201", "f0781cb79f9bd13b8d86ef226f26eb53f9613f45");
            //    //    string response = s.execute("9212889420", phone, Message);
            //    //    //Response.Write(response);
            //    //}

            //}
            //else
            //{
            //    ServiceLogic.SendSMSFromAlfa(phone, Message);
            //}
        }
        catch (Exception ex)
        {
            //  throw ex;
        }
    }
    static string scriptTag = "<script type=\"\" language=\"\">{0}</script>";
    static string GenerateCodeFromFunction(string function)
    {
        return string.Format(scriptTag, function);
    }
    public static void SendSms123(string Message, string phone, string ApiType)
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
            {
                str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A3f78a344d70a9e35c006e938f428f591&sender=LBVRFY&to=" + phone + "&message=" + Message;
                WebRequest request = WebRequest.Create(str);
                request.Method = "POST";
                string postData = "";
                byte[] byteArray = Encoding.UTF8.GetBytes(postData);
                request.Headers.Add("Authorization", "fJeVv745L - rI6TPSZqgb - Z3U6mvgZ - ODYI0");
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
            else if (ApiType == "BSmart")
            {
                //str = "http://193.105.74.58/api/v3/sendsms/plain?user=LABEL9420&password=Sid2014!&sender=labeld&SMSText=" + Message + "&GSM=" + phone;
                SendSMS s = new SendSMS("label94201", "f0781cb79f9bd13b8d86ef226f26eb53f9613f45");
                string response = s.execute("9212889420", phone, Message);
                //Response.Write(response);
            }

            
        }
        catch
        {
        }
        #region Code for Run Serveys
        //if (Request.QueryString["message"] != null)
        //{
        //    str2 = (Request.QueryString["message"]).Trim();
        //    if (str2.Length < 13)
        //    {
        //        string ProId = ""; int MyRating = 0;
        //        string[] ArrNew = str2.Split('-');
        //        if (ArrNew.Length > 0)
        //        {
        //            ProId = ArrNew[0].ToString(); MyRating = System.Convert.ToInt32(ArrNew[1]);
        //            MobileNo = Request.QueryString["from"].ToString();
        //            Type = "Solution";
        //            if (CheckProduct(ProId))
        //            {
        //                if (MyRating > 0)
        //                {
        //                    // MyRating = MyRating;
        //                }
        //                else
        //                    MyRating = 1;
        //                SQL_DB.ExecuteNonQuery("INSERT INTO [T_RunSurveys]([Pro_ID],[Rating],[MobileNo],[EntryDate]) VALUES ('" + ProId + "','" + MyRating + "','" + MobileNo + "','" + System.Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "') ");
        //            }
        //            SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('Solution " + MobileNo + "')");
        //        }
        //        return;
        //    }
        //}
        #endregion

        #region Code for Run Serveys
        //if (Request.QueryString["Body"] != null)
        //{
        //    try
        //    {


        //        str2 = (Request.QueryString["Body"]).Trim();
        //        if (str2.Length < 13)
        //        {
        //            string ProId = ""; int MyRating = 0;
        //            string[] ArrNew = str2.Split('-');
        //            if (ArrNew.Length > 0)
        //            {
        //                ProId = ArrNew[0].ToString(); MyRating = System.Convert.ToInt32(ArrNew[1]);
        //                MobileNo = Request.QueryString["From"].ToString();
        //                Type = "BSmart";
        //                if (CheckProduct(ProId))
        //                {
        //                    if (MyRating > 0)
        //                    {
        //                        // MyRating = MyRating;
        //                    }
        //                    else
        //                        MyRating = 1;
        //                    SQL_DB.ExecuteNonQuery("INSERT INTO [T_RunSurveys]([Pro_ID],[Rating],[MobileNo],[EntryDate]) VALUES ('" + ProId + "','" + MyRating + "','" + MobileNo + "','" + System.Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "') ");
        //                }
        //                SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('Solution " + MobileNo + "')");
        //            }
        //            return;
        //        }
        //    }
        //    catch (Exception)
        //    {

        //    }
        //    finally
        //    {

        //    }
        //}
        #endregion
    }
    #endregion
}