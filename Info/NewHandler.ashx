<%@ WebHandler Language="C#" Class="NewHandler" %>

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
using System.Net.NetworkInformation;
using System.Web.SessionState;
using System.Net.Mail;
using DataProvider;
using Newtonsoft.Json;
using WebApplication1;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Data.SqlClient;

public class NewHandler : IHttpHandler, IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.QueryString["API"] == "Login")
        {
            string Mobileno = string.Empty;
            string Password = string.Empty;
            string Response = string.Empty;

            if (context.Request.QueryString["Mobileno"] != null)
                Mobileno = context.Request.QueryString["Mobileno"].ToString();
            if (context.Request.QueryString["Password"] != null)
                Password = context.Request.QueryString["Password"].ToString();
            if (Mobileno.Length != 10)
            {
                Response = "Failure~Invalid Mobile Number";
            }
            if (Mobileno.Length == 10)
            {
                Mobileno = "91" + Mobileno;
            }


            if (Password.Length > 20)
            {
                Response = "Failure~Invalid Password";
                return;
            }
            else if (Mobileno.Length == 12 && Password.Length < 20)
            {
                Response = LoginAmbikaUser(Mobileno, Password);
            }
            else
            {
                Response = "Failure~Invalid Mobileno or Password";
            }
            context.Response.Write(Response);
        }



        else if (context.Request.QueryString["API"] == "CHKUSER")
        {
            string Mobileno = string.Empty;
            string Compid = string.Empty;
            string Response = string.Empty;

            if (context.Request.QueryString["MobileNo"] != null)
                Mobileno = context.Request.QueryString["MobileNo"].ToString().Trim();
            if (context.Request.QueryString["Compid"] != null)
                Compid = context.Request.QueryString["Compid"].ToString().Trim();

            if (Mobileno.Length != 10)
            {
                Response = "Failure~Invalid Mobile Number";
            }
            if (Mobileno.Length == 10)
            {
                Mobileno = "91" + Mobileno;
            }



            if (Mobileno.Length == 12)
            {
                Response = CHKUSERAMBIKAREF(Mobileno,Compid);
            }
            else
            {
                Response = "Failure~Invalid Mobileno or Password";
            }
            context.Response.Write(Response);
        }

        else if (context.Request.QueryString["API"] == "UpdateAmbikaProfile")
        {
            AmbikaUser log = new AmbikaUser();
            if (context.Request.QueryString["Mobileno"] != null)
                log.Mobile = context.Request.QueryString["Mobileno"].ToString();
            if (context.Request.QueryString["name"] != null)
                log.Name = context.Request.QueryString["name"].ToString();
            if (context.Request.QueryString["city"] != null)
                log.City = context.Request.QueryString["city"].ToString();
            if (context.Request.QueryString["state"] != null)
                log.State = context.Request.QueryString["state"].ToString();
            if (context.Request.QueryString["PinCode"] != null)
                log.PinCode = context.Request.QueryString["PinCode"].ToString();
            if (context.Request.QueryString["Address"] != null)
                log.Address = context.Request.QueryString["Address"].ToString();
            if (context.Request.QueryString["UPIID"] != null)
                log.UPIID = context.Request.QueryString["UPIID"].ToString();
            if (context.Request.QueryString["Usertype"] != null)
                log.Consumertype = context.Request.QueryString["Usertype"].ToString();
            string Data = UpdateAmbikaUserprofile(log);
            context.Response.Write(Data);
        }

        else if (context.Request.QueryString["API"] == "APIRegistration")
        {
            AmbikaUser log = new AmbikaUser();
            if (context.Request.QueryString["Mobileno"] != null)
                log.Mobile = context.Request.QueryString["Mobileno"].ToString();
            if (context.Request.QueryString["name"] != null)
                log.Name = context.Request.QueryString["name"].ToString();
            if (context.Request.QueryString["city"] != null)
                log.City = context.Request.QueryString["city"].ToString();
            if (context.Request.QueryString["state"] != null)
                log.State = context.Request.QueryString["state"].ToString();
            if (context.Request.QueryString["PinCode"] != null)
                log.PinCode = context.Request.QueryString["PinCode"].ToString();
            if (context.Request.QueryString["Address"] != null)
                log.Address = context.Request.QueryString["Address"].ToString();
            if (context.Request.QueryString["typeofconsumer"] != null)
                log.Consumertype = context.Request.QueryString["typeofconsumer"].ToString();
            if (context.Request.QueryString["UPIID"] != null)
                log.UPIID = context.Request.QueryString["UPIID"].ToString();
            if (!string.IsNullOrEmpty(log.Mobile) &&
                 !string.IsNullOrEmpty(log.Name) &&
                 !string.IsNullOrEmpty(log.PinCode) &&
                 !string.IsNullOrEmpty(log.City) &&
                 !string.IsNullOrEmpty(log.State) &&
                 !string.IsNullOrEmpty(log.Address) &&
                 !string.IsNullOrEmpty(log.Consumertype) &&
                 !string.IsNullOrEmpty(log.UPIID))
            {
                string data = RegisterAmbikaUser(log);
                context.Response.Write(data);
            }
            else
            {
                context.Response.Write("Invalid Request");
            }

        }

        

        else if (context.Request.QueryString["API"] == "Genrateotp")
        {
            string Mobile = string.Empty;
            string result = string.Empty;
            if (context.Request.QueryString["Mobileno"] != null)
                Mobile = context.Request.QueryString["Mobileno"].ToString();
            string MobileNo = Mobile;
            if (MobileNo == "")
            {
                result = "Kindly Enter Your Mobile No.";
                context.Response.Write(result);
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
                    context.Response.Write(result);
                }
                if (MobileNo.Length == 11)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        context.Response.Write(result);
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
                        context.Response.Write(result);
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


                DataTable dt1 = new DataTable();
                dt1 = SQL_DB.ExecuteDataTable("SELECT Password FROM [M_Consumer] WHERE  [MobileNo] = '" + MobileNo + "'");
                if (dt1.Rows.Count > 0)
                {
                    //string msgString = "You are registered with VCQRU.COM. Your USER ID is " + MobileNo + " and PASSWORD is " + dt1.Rows[0]["Password"].ToString() + " Visit www.vcqru.com for more info OR for any query contact customer care 9243029420. Thanks VCQRU";
                    string msgString = "Your USER ID is "+MobileNo+" and PASSWORD is " + dt1.Rows[0]["Password"].ToString() + ". visit www.vcqru.com";
                        ServiceLogic.SendSMSFromAlfa(MobileNo, msgString, "PWD");
                   // ServiceLogic.SendSms(msgString, MobileNo);
                    result = "Your password is send to Mobile No. xxxxxxx" + MobileNo.Substring(9, 3);
                    context.Response.Write(result);
                }
            }
        }

    }

    public static bool isDigits(string s)
    {
        if (s == null || s == "") return false;

        for (int i = 0; i < s.Length; i++)
            if ((s[i] ^ '0') > 9)
                return false;

        return true;
    }

    public string CHKUSERAMBIKAREF(string Mobile,string Compid)
    {
        string Result = string.Empty;
        if (Mobile.Length == 10)
            Mobile = "91" + Mobile;
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("proc_countakemisucesscodeforrefral", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@compid", Compid);
        cmd.Parameters.AddWithValue("@mobileno", Mobile);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
        Result = dt.Rows[0][0].ToString();
        return Result;
    }

    public string UpdateAmbikaUserprofile(AmbikaUser log)
    {
        if (log.Mobile.Length == 10)
            log.Mobile = "91" + log.Mobile;
        SQL_DB.ExecuteNonQuery("update M_Consumer set ConsumerName='" + log.Name + "',City='" + log.City + "',state='" + log.State + "',PinCode='" + log.PinCode + "',Address='" + log.Address + "',UPIId='"+log.UPIID+"',Other_Role='"+log.Consumertype+"'  where MobileNo='" + log.Mobile + "'");
        string Result = string.Empty;
        Result = "Updated Successfully";
        return Result;
    }

    public string RegisterAmbikaUser(AmbikaUser log)
    {
        if (log.Mobile.Length == 10)
            log.Mobile = "91" + log.Mobile;
        SQL_DB.ExecuteNonQuery("update M_Consumer set ConsumerName='" + log.Name + "',City='" + log.City + "',state='" + log.State + "',PinCode='" + log.PinCode + "',Address='" + log.Address + "' where MobileNo='" + log.Mobile + "'");
        string Result = string.Empty;
        Result = "Updated Successfully";
        return Result;
    }

    public string LoginAmbikaUser(string Mobileno, string Password)
    {
        string Response = string.Empty;
        if (Mobileno.Length == 12 && Password.Length < 20)
        {
            string ds = User_Details.web_LoginAbbikauser(Mobileno, Password);
            Response = ds;
        }
        return Response;
    }
    //public string LoginwithregAmbikaUser(string Mobileno)
    //{
    //    string Response = string.Empty;
    //    if (Mobileno.Length == 12)
    //    {
    //        string ds = User_Details.web_LoginregAbbikauser(Mobileno);
    //        Response = ds;
    //    }
    //    return Response;
    //}

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    public class AmbikaUser
    {
        public string Name { get; set; }
        public string City { get; set; }
        public string Mobile { get; set; }
        public string State { get; set; }
        public string PinCode { get; set; }
        public string Address { get; set; }
        public string Consumertype { get; set; }
        public string UPIID { get; set; }
    }

}