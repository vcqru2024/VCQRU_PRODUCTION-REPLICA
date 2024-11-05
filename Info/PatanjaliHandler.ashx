<%@ WebHandler Language="C#" Class="PatanjaliHandler" %>

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

public class PatanjaliHandler : IHttpHandler
{
    public static string srt = DataProvider.Utility.FindMailBody();
    cls_patanjali db = new cls_patanjali();
    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.QueryString["method"] == "otpsendforpfl")  //pfl
        {
            string Result = string.Empty;
            string Email = context.Request.QueryString["Email"].ToString();
            DataTable dtuser = SQL_DB.ExecuteDataTable("select UserMobile from tbl_pflUsers where UserEmail='" + Email + "' and IsActive=1 and IsDelete=0");
            if (dtuser.Rows.Count > 0)
            {
                int rdmNumber = RandomNumber(1000, 9999);
                string mobileNumber = dtuser.Rows[0]["UserMobile"].ToString();
                string otpMsg = "Your Employee verification OTP is " + rdmNumber + " www.vcqru.com md5b2lDaeHj";
               
                ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");
                DateTime expDate = System.DateTime.Now.AddYears(1);
                SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[CompanyProduct] ([expiryDate], [otp], [status],[mobileNumber]) values ('" + expDate.ToString("yyyy-MM-dd HH:mm:ss") + "', '" + rdmNumber + "', 0, '" + mobileNumber + "')");
                Result = "Otp Send Successfully";
            }
            else
            {
                Result = "Invalid Email ID";
            }
            context.Response.Write(Result);
        }
        else if (context.Request.QueryString["method"] == "Resendotponemail")  //pfl
        {
            string Result = string.Empty;
            string EmailID = context.Request.QueryString["Email"].ToString();
            string MobileNO = context.Request.QueryString["Mobile"].ToString();
            int OTPFORMAIL = RandomNumber(1000, 9999);
            string Maild = OTPSENDONMAIL("User", EmailID, MobileNO, OTPFORMAIL.ToString(), "OTP");
            if (Maild == "Query has been sent successfully.")
            {
                Result = "Otp Send Successfully.";
            }
            else
            {
                Result = "Invalid Request.";
            }
            context.Response.Write(Result);
        }
        else if (context.Request.QueryString["method"] == "ResendotponMobile")  //pfl
        {
            string Result = string.Empty;
            string MobileNO = context.Request.QueryString["Mobile"].ToString();
            if (MobileNO.Length == 10)
            {
                Result = SendOtp(MobileNO);
            }
            else
            {
                Result = "Invalid Mobile Number";
            }
            Result = SendOtp(MobileNO);
            context.Response.Write(Result);
        }

        else if (context.Request.QueryString["method"] == "ForgotPassword")  //pfl
        {
            string Result = string.Empty;
            string Email = context.Request.QueryString["Email"].ToString();
            DataTable dtuser = SQL_DB.ExecuteDataTable("select UserMobile,UserPassword,UserName from tbl_pflUsers where UserEmail='" + Email + "' and IsActive=1 and IsDelete=0");
            if (dtuser.Rows.Count > 0)
            {
                int rdmNumber = RandomNumber(1000, 9999);
                string mobileNumber = dtuser.Rows[0]["UserMobile"].ToString();
                string Password = dtuser.Rows[0]["UserPassword"].ToString();
                string UserName = dtuser.Rows[0]["UserName"].ToString();
                string result = PatanjaliRegistrationDeno(UserName, Email, mobileNumber);
                Result = "Password Send On Registered Email Id";
            }
            else
            {
                Result = "Invalid Email ID";
            }
            context.Response.Write(Result);
        }

        else if (context.Request.QueryString["method"] == "PatanjaliRegistrationDeno")
        {
            string Name = context.Request.QueryString["Name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string cmobile = context.Request.QueryString["cmobile"].ToString();
            //string menu = context.Request.QueryString["menu"].ToString();
            string result = PatanjaliRegistrationDeno(Name, email, cmobile);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "DeleteUser")
        {
            string result = string.Empty;
            string UserRoleId = context.Request.QueryString["UserRoleId"].ToString();
            if (UserRoleId == "" || UserRoleId == null)
            {
                result = "Invalid Role Id";
            }

            DataTable dt = db.GetRegisteredUserData("USP_PFLDELETEUserROLEData", Convert.ToInt32(UserRoleId));
            if (Convert.ToInt32(dt.Rows[0][0]) == 1)
            {
                result = "User Deleted Successfully";
            }
            else
            {
                result = "Con't delete this user";
            }
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "PatanjaliContactus")
        {
            // Retrieve form data from the request
            string Name = context.Request.Form["Name"];
            string city = context.Request.Form["city"];
            string mobile = context.Request.Form["mobile"];
            string useremail = context.Request.Form["useremail"];
            string enquiry = context.Request.Form["enquiry"];
            string email = context.Request.Form["email"];
            string userid = context.Request.Form["userid"];

            // Retrieve image data from the request
            HttpPostedFile imageFile = context.Request.Files["image"];
            string imagePath = SaveImage(imageFile); // Save the image and get the saved path
 imagePath = imagePath.Replace("~","");
            string result = PatanjaliContactus(Name, city, mobile, imagePath, enquiry, useremail, userid, email);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "register")
        {
            string result = string.Empty;
            string OTPEmail = context.Request.QueryString["OTPEmail"].ToString();
            string OTPMobile = context.Request.QueryString["OTPMobile"].ToString();
            string company = context.Request.QueryString["company"].ToString();
            string contactpersion = context.Request.QueryString["contactpersion"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string mobile = context.Request.QueryString["mobile"].ToString();
            DataTable dt = db.Validateotpreg("VerifyAndLogin", mobile, email, OTPEmail, OTPMobile);
            if (dt.Rows[0][0].ToString()== "Login successful")
            {
               result = register(company, contactpersion, email, mobile);
                if (result == "Query has been sent successfully.")
                {
                    result = "Success";
                }
                else
                {
                    result = "Failed~" + result;
                }
            }
            else
            {
                result = "Failed~"+dt.Rows[0][0].ToString();
            }
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "OTPSENDFORREG")
        {
            string result = string.Empty;
            string EmailID = context.Request.QueryString["EmailID"].ToString();
            string MobileNO = context.Request.QueryString["MobileNO"].ToString();
            if (!string.IsNullOrEmpty(EmailID) && !string.IsNullOrEmpty(MobileNO))
            {
                int OTPFORMAIL = RandomNumber(1000, 9999);
                string Maild = OTPSENDONMAIL("User", EmailID, MobileNO, OTPFORMAIL.ToString(), "OTP");
                string Result1 = SendOtp(MobileNO);
                result = "Success~OTP SEND SUCCESSFULLY.";
            }
            else
            {
                result = "Invalid Details";
            }
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "heatMap")
        {
            string result = string.Empty;
            string companyid = context.Request.QueryString["companyid"].ToString();
            if (companyid == "" || companyid == null)
            {
                result = "Invalid Request";
            }

            // DataTable dt = db.Getheatmap("USP_GetHeatMapReport_PFL_testing", companyid);
            DataTable dt = db.Getheatmap("sp_testing", companyid);
            if (dt.Rows.Count > 0)
            {
                result = JsonConvert.SerializeObject(dt);
            }
            else
            {
                result = "Data not Avlaible";
            }
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "ActiveInactiveUser")
        {
            string result = string.Empty;
            string UserRoleId = context.Request.QueryString["UserRoleId"].ToString();
            if (UserRoleId == "" || UserRoleId == null)
            {
                result = "Invalid Role Id";
            }

            DataTable dt = db.GetRegisteredUserData("USP_PFLUPDATEUserROLEData", Convert.ToInt32(UserRoleId));
            if (Convert.ToInt32(dt.Rows[0][0]) == 1)
            {
                result = "User Activated Successfully";
            }
            else if (Convert.ToInt32(dt.Rows[0][0]) == 2)
            {
                result = "User De-Activated Successfully";
            }
            else
            {
                result = "Con't Update this user";
            }
            context.Response.Write(result);
        }

    }
    public static string OTPSENDONMAIL(string name, string email, string cmobile, string OTP, string subject = null)
    {
        string result = "";

        Object9420 obj = new Object9420();
        obj.Name = name.Trim().Replace("'", "''");
        obj.Email = email.Trim().Replace("'", "''");
        obj.cmobile = cmobile.Trim().Replace("'", "''");

        #region OTP Store insert Table 
        DateTime expDate = System.DateTime.Now.AddYears(1);
        SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[tbl_EmailOtp] (Comp_Name,Email_id,Otp,Expirydate) values ('" + obj.Name + "','" + obj.Email + "','" + OTP + "','" + expDate.ToString("yyyy-MM-dd HH:mm:ss") + "')");
        #endregion
        if (subject == null)
        {
            subject = "OTP";
        }

        #region Mail Structure
        string MailBody = srt +
        " <span>Dear <em><strong>" + obj.Name + ",</strong></em></span><br />" +
        " <br />" +
        "Thank you for sharing details with us. Your information is greatly appreciated, and it helps us better understand your needs and preferences.<br />" +
         " <br />" +
         " <br />" +
          " <span><em><strong>Your Otp for Registration is : -</strong></em> " + OTP + "</span><br />" +
        " <br />" +
        " Our experts will connect with you soon. If you have any questions or concerns regarding the information you've shared or our data handling practices," +
        "please don't hesitate to reach out to us at 9355903103/01245181074 <br />" +
        " <p>" +
        " <div class='w_detail'>" +
        " Assuring you  of  our best services always.<br />" +
        " <br />" +
        " Best Regards,<br /><br />" +
         " <br />" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <em><strong>VCQRU.COM,</strong></em><br />" +
        "<a href='https://www.facebook.com/vcqru/'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/facebook.png' alt='Facebook' /></a>" +
        "<a href='https://www.linkedin.com/company/vcqru-wesecureyou/'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/linkedin.png' alt='linkedin' /></a>" +
        "<a href='https://www.instagram.com/vcqru_wesecureyou/'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/instagram.png' alt='instagram' /></a>" +
        "<a href='https://twitter.com/Vcqru_Official'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/twitter2.png' alt='twitter' /></a>" +
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
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Email, MailBody, subject);
        }
        result = "Query has been sent successfully.";
        return result;
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
            DataTable dtcomp = SQL_DB.ExecuteDataTable("select * from Comp_Reg where Comp_Email = '" + obj.Comp_Email + "'");
            string ps = "";
            SQL_DB.ExecuteNonQuery("UPDATE [Comp_Reg]  SET  [Email_Vari_Flag] = 1  WHERE [Comp_ID] = '" + dtcomp.Rows[0]["Comp_ID"].ToString() + "'");
            Random rnd = new Random();
            ps = rnd.Next().ToString().Substring(0, 5);
            SQL_DB.ExecuteNonQuery("UPDATE [Comp_Reg] SET [Password]='" + ps + "' WHERE [Comp_ID]='" + dtcomp.Rows[0]["Comp_ID"].ToString() + "'");
            string subject = "New Registrtration";

            #region Mail Structure
            string MailBody = srt +
            " <span>Dear <em><strong>" + dtcomp.Rows[0]["Contact_Person"].ToString() + ",</strong></em></span><br />" +
            " <br />" +
            "Thank you for sharing details with us. Your information is greatly appreciated, and it helps us better understand your needs and preferences.<br />" +
             " <br />" +
             " <br />" +
              " <span><em><strong>Email ID : -</strong></em> " + dtcomp.Rows[0]["Comp_Email"].ToString() + "</span><br />" +
              " <span><em><strong>Password : -</strong></em> " + ps + "</span><br />" +
            " <br />" +
            " Our experts will connect with you soon. If you have any questions or concerns regarding the information you've shared or our data handling practices," +
            "please don't hesitate to reach out to us at 9355903103/01245181074 <br />" +
            " <p>" +
            " <div class='w_detail'>" +
            " Assuring you  of  our best services always.<br />" +
            " <br />" +
            " Best Regards,<br /><br />" +
             " <br />" +
            " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
            " <em><strong>VCQRU.COM,</strong></em><br />" +
            "<a href='https://www.facebook.com/vcqru/'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/facebook.png' alt='Facebook' /></a>" +
            "<a href='https://www.linkedin.com/company/vcqru-wesecureyou/'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/linkedin.png' alt='linkedin' /></a>" +
            "<a href='https://www.instagram.com/vcqru_wesecureyou/'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/instagram.png' alt='instagram' /></a>" +
            "<a href='https://twitter.com/Vcqru_Official'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/twitter2.png' alt='twitter' /></a>" +
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
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Comp_Email, MailBody, subject);
            }
            string result = "Query has been sent successfully.";
            return result;
        }
        else
        {
            string msg = "This email id already registered in our system. Please enter different email id.";
            return msg;
        }
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
    public static string SendOtp(string mobileNumber)
    {
        string Result = string.Empty;
        int rdmNumber = RandomNumber(1000, 9999);
        string otpMsg = "Your Employee verification OTP is " + rdmNumber + " www.vcqru.com md5b2lDaeHj";
        // HttpContext.Current.Session["otpSendTimes"] = 1;    Uncomment when need to procede on Qa
        ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");
        DateTime expDate = System.DateTime.Now.AddYears(1);
        SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[CompanyProduct] ([expiryDate], [otp], [status],[mobileNumber]) values ('" + expDate.ToString("yyyy-MM-dd HH:mm:ss") + "', '" + rdmNumber + "', 0, '" + mobileNumber + "')");
        Result = "Otp Send Successfully";
        return Result;
    }
    private string SaveImage(HttpPostedFile imageFile)
    {
        if (imageFile != null && imageFile.ContentLength > 0)
        {
            try
            {
                // Validate file extension or MIME type here if necessary

                string fileName = Path.GetFileName(imageFile.FileName);
                string folderPath = HttpContext.Current.Server.MapPath("~/assets/images/patanjali/inquiryimage");
                string filePath = Path.Combine(folderPath, fileName);

                // Ensure the folder exists, create it if not
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                // Generate a unique filename to prevent directory traversal attacks
                string uniqueFileName = Guid.NewGuid().ToString() + Path.GetExtension(fileName);
                filePath = Path.Combine(folderPath, uniqueFileName);

                // Save the file
                imageFile.SaveAs(filePath);

                // Construct the virtual path
                string virtualPath = "~/assets/images/patanjali/inquiryimage/" + uniqueFileName;

                return virtualPath;
            }
            catch (Exception ex)
            {
                // Handle exceptions
                // You might want to log the error or return a specific error message
                // Don't expose sensitive information about the system in the error message
                // For example: return "An error occurred while saving the image.";
                throw ex; // Rethrow the exception or handle it according to your application's needs
            }
        }
        return string.Empty;
    }
    public static string PatanjaliRegistrationDeno(string name, string email, string cmobile, string subject = null)
    {
        string result = "";

        Object9420 obj = new Object9420();
        obj.Name = name.Trim().Replace("'", "''");
        obj.Email = email.Trim().Replace("'", "''");
        obj.cmobile = cmobile.Trim().Replace("'", "''");
        DataTable dtpass = SQL_DB.ExecuteDataTable("SELECT UserPassword from tbl_pflUsers where UserEmail = '" + email + "' and IsDelete=0");
        if (dtpass.Rows.Count > 0)
        {
            obj.Password = dtpass.Rows[0]["UserPassword"].ToString();
        }
        if (subject == null)
        {
            subject = "New Registrtration";

        }
        string emailVerificationLink = "https://www.vcqru.com/patanjali/verifyemail.aspx?verified_Email_Id_User_Id_email=" + obj.Email;
        #region Mail Structure
        string MailBody = srt +


        " <span>Dear <em><strong>" + obj.Name + ",</strong></em></span><br />" +
        " <br />" +
        "You are registered with Patanjali As A User. <a href='" + emailVerificationLink + "'>Verify Your Email and login</a>.<br />"+
        "Thank you for sharing details with us. Your information is greatly appreciated, and it helps us better understand your needs and preferences.<br />" +
         " <br />" +
         " <br />" +
          " <span><em><strong>Email ID : -</strong></em> " + obj.Email + "</span><br />" +
          " <span><em><strong>Password : -</strong></em> " + obj.Password + "</span><br />" +
        " <br />" +
        " Our experts will connect with you soon. If you have any questions or concerns regarding the information you've shared or our data handling practices," +
        "please don't hesitate to reach out to us at 9355903103/01245181074 <br />" +
        " <p>" +
        " <div class='w_detail'>" +
        " Assuring you  of  our best services always.<br />" +
        " <br />" +
        " Best Regards,<br /><br />" +
         " <br />" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <em><strong>VCQRU.COM,</strong></em><br />" +
        "<a href='https://www.facebook.com/vcqru/'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/facebook.png' alt='Facebook' /></a>" +
        "<a href='https://www.linkedin.com/company/vcqru-wesecureyou/'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/linkedin.png' alt='linkedin' /></a>" +
        "<a href='https://www.instagram.com/vcqru_wesecureyou/'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/instagram.png' alt='instagram' /></a>" +
        "<a href='https://twitter.com/Vcqru_Official'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/twitter2.png' alt='twitter' /></a>" +
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
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Email, MailBody, subject);
        }
        result = "Query has been sent successfully.";



        return result;
    }
    public static string PatanjaliContactus(string name, string city, string mobile, string image, string enquiry, string useremail, string userid, string email)
    {
        string result = "";

        InquiryData obj = new InquiryData();
        obj.Name = name.Trim();
        obj.City = city.Trim();
        obj.MobileNo = mobile.Trim();
        obj.Inquiry = enquiry.Trim();
        obj.Userid = userid.Trim();
        obj.email = email.Trim();
        obj.UserEmail = useremail.Trim();

        if (!string.IsNullOrEmpty(image)) // Check if image is not null or empty
        {
            obj.Image = image.Trim();
        }

        StoreInquiry(obj);
        string subject2 = "Patanjali Enquiry Submitted Successfully";
        string subject = "Patanjali Enquiry"; // Default subject

        // Construct mail body
        string MailBody = srt +
            " <span>Dear <em><strong>" + obj.Userid + ",</strong></em></span><br />" +
            " <br />" +
            "A new inquiry has been generated from a Patanjali user.<br />" +
            " <br />" +
            " <br />" +
            " <span><em><strong>User Name : -</strong></em> " + obj.Name + "</span><br />" +
            " <span><em><strong>User Mobile : -</strong></em> " + obj.MobileNo + "</span><br />" +
            " <span><em><strong>User Inquiry : -</strong></em> " + obj.Inquiry + "</span><br />" +
            " <span><em><strong>User City : -</strong></em> " + obj.City + "</span><br />" +
            " <br />";
        string MailBody2 = srt +
        " <span>Dear <em><strong>" + obj.Name + ",</strong></em></span><br />" +
        " <br />" +
        "A new inquiry has been Submitted Succesfully to a Patanjali.<br />" +
        " <br />" +
        " <br />" +
        " <span><em><strong>User Name : -</strong></em> " + obj.Name + "</span><br />" +
        " <span><em><strong>User Mobile : -</strong></em> " + obj.MobileNo + "</span><br />" +
        " <span><em><strong>User Inquiry : -</strong></em> " + obj.Inquiry + "</span><br />" +
        " <span><em><strong>User City : -</strong></em> " + obj.City + "</span><br />" +
        " <br />";

        // Include image in mail body if it exists
        if (!string.IsNullOrEmpty(obj.Image))
        {
            string absoluteUrl = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + VirtualPathUtility.ToAbsolute(obj.Image);
            MailBody += " <img src='" + absoluteUrl + "' alt='User Image' style='max-width: 100%; height: auto;'>";
            MailBody2 += " <img src='" + absoluteUrl + "' alt='User Image' style='max-width: 100%; height: auto;'>";
        }

        // Send mail
        DataSet dsMl = function9420.FetchMailDetail("support");
        if (dsMl.Tables[0].Rows.Count > 0)
        {
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.email, MailBody, subject);
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.UserEmail, MailBody2, subject2);
        }

        result = "Query has been sent successfully.";

        return result;
    }


    public static void StoreInquiry(InquiryData inquiryData)
    {
        string query = "INSERT INTO tbl_Enquiries (Name, Mobile_Number, City, Image_url,Email_Id,Enquiry) VALUES ('" +
                        inquiryData.Name + "', '" +
                        inquiryData.MobileNo + "', '" +
                        inquiryData.City + "', '" +
                        inquiryData.Image + "', '" +
                        inquiryData.UserEmail + "', '" +
                        inquiryData.Inquiry + "')";

        // Assuming SQL_DB.ExecuteNonQuery method is provided by the environment
        SQL_DB.ExecuteNonQuery(query);
    }

    public static int RandomNumber(int min, int max)
    {
        Random random = new Random();
        return random.Next(min, max);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }



}
public class InquiryData
{
    public string Name { get; set; }
    public string MobileNo { get; set; }
    public string UserEmail { get; set; }
    public string City { get; set; }
    public string Image { get; set; }
    public string Inquiry { get; set; }
    public string email { get; set; }
    public string Userid { get; set; }
}