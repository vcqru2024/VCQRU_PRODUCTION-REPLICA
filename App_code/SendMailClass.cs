using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using System.Data;
using Business9420;
using System.Text.RegularExpressions;
using System.Configuration;
using Business_Logic_Layer;
using System.Net;
using System.Web.SessionState;
using System.Net.Mail;
using DataProvider;


/// <summary>
/// Summary description for SendMailClass
/// </summary>
public class SendMailClass
{
    
    //string srt = DataProvider.Utility.FindMailBody();
    public SendMailClass()
    {
        //
        // TODO: Add constructor logic here
        //
    }
 
    public static bool SendMailToCompany(string Comp_ID, string strtxtsubject, string strtxtbody, HttpPostedFile file)
    {
        string strNewFilename = string.Empty; string path = string.Empty;
        bool isMailSend = false;
        if (file != null)
        {
            string directory = HttpContext.Current.Server.MapPath("~/Data/Sound");
            directory = directory + "\\" + Comp_ID.Substring(5, 4) + "\\Files";
            if (!System.IO.Directory.Exists(directory))
            {
                System.IO.Directory.CreateDirectory(directory);
            }

            strNewFilename = System.IO.Path.GetFileNameWithoutExtension(file.FileName) + DateTime.Now.ToString("MMddyyyyhhmmss");
            string strGetExtension = System.IO.Path.GetExtension(file.FileName);
            strNewFilename = strNewFilename.Replace(" ", "") + strGetExtension;
            path = System.IO.Path.Combine(directory, strNewFilename);
            file.SaveAs(path);
        }
        Object9420 Reg = new Object9420();
        DataSet ds = new DataSet();
        Reg.Comp_ID = Comp_ID;
        ds = function9420.FindData(Reg);
        Reg.Comp_Email = ds.Tables[0].Rows[0]["Comp_Email"].ToString();
        Reg.Comp_Name = ds.Tables[0].Rows[0]["Comp_Name"].ToString();
        //xtsend.Text = Reg.Comp_Email;
        #region Mail Body
        string MailBody = DataProvider.Utility.FindMailBody() + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src=" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + ds.Tables[0].Rows[0]["Contact_Person"].ToString() + ",</strong></em></span><br />" +
        " <br />" + strtxtbody + "<br />" +
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
        #endregion

        DataSet dsMl = function9420.FetchMailDetail("admin");
        if (dsMl.Tables[0].Rows.Count > 0)
        {
            if (Utility.AttSendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(),
                  dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, strtxtsubject, "", "", path))
            {
                isMailSend = true;
            }



        }
        //Utility.AttSendMail(server, userID, password, Reg.Comp_Email, MailBody, subject, sendcc, sendbcc, strfilepath);
        //if (isMailSend)
        {
            Object9420 RegMessage = new Object9420();
            RegMessage.Send_To = Reg.Comp_Email;
            RegMessage.Send_CC = "";
            RegMessage.Send_BCC = "";
            RegMessage.Send_Subject = strtxtsubject;
            RegMessage.Send_Message = strtxtbody;
            RegMessage.Send_AttachFile = strNewFilename;
            Business9420.function9420.InsertMessageLog(RegMessage);
        }



     //   string path = Server.MapPath("../Data/Sound");
     //   path = path + "\\" + lblidsend.Text.Substring(5, 4) + "\\Files";
      //  DataProvider.Utility.CreateDirectory(path);
     //   string ext = System.IO.Path.GetExtension(FileUploadFormail.PostedFile.FileName);
      //  path = path + "\\" + lblidsend.Text.Substring(5, 4) + "_" + Convert.ToString(SQL_DB.ExecuteScalar("SELECT ISNULL(MAX(Row_ID), 1) AS Row_Id FROM M_Message")) + ext;
       // if (FileUploadFormail.FileName != "")
       //     FileUploadFormail.SaveAs(path);

   //     ClearSendMailData();
   //     newMsg.Visible = true;
     //   newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
     //   lblmsgHeader.Text = "Message send successfully !";



        return isMailSend;
    }
}