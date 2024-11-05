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
using System.IO;
using System.Net;
using System.Text;
using System.Data.SqlClient;
using Business9420;
using System.Net.Mail;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Security.Cryptography;

/// <summary>
/// Summary description for Utility
/// </summary>
/// 
namespace DataProvider
{

    public class LocalDateTime
    {
        DateTime Date;
        public LocalDateTime()
        {

        }
        public LocalDateTime(int Year, int Month, int day, int hr, int mn, int sec)
        {
            Date = new DateTime(Year, Month, day, hr, mn, sec);
        }

        public static DateTime Now
        {
            get
            {
                DateTime univerTime = DateTime.SpecifyKind(DateTime.Now, DateTimeKind.Local);
                univerTime = univerTime.AddSeconds(1);
                TimeZoneInfo tz = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
                return TimeZoneInfo.ConvertTime(univerTime, tz);
            }
        }
    }
    public class Utility
    {
      
        public static string GeneratePassword()
        {
            int Length = 8;
            int NonAlphaNumericChars = 1;
            string allowedChars = "abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ0123456789";
            string allowedNonAlphaNum = "!@#$%^&*()_-+=[{]};:<>|./?";
            //string allowedNonAlphaNum = "!@#$%&*()_-+=[{]}?";
            Random rd = new Random();

            if (NonAlphaNumericChars > Length || Length <= 0 || NonAlphaNumericChars < 0)
                throw new ArgumentOutOfRangeException();

            char[] pass = new char[Length];
            int[] pos = new int[Length];
            int i = 0, j = 0, temp = 0;
            bool flag = false;

            //Random the position values of the pos array for the string Pass
            while (i < Length - 1)
            {
                j = 0;
                flag = false;
                temp = rd.Next(0, Length);
                for (j = 0; j < Length; j++)
                    if (temp == pos[j])
                    {
                        flag = true;
                        j = Length;
                    }

                if (!flag)
                {
                    pos[i] = temp;
                    i++;
                }
            }

            //Random the AlphaNumericChars
            for (i = 0; i < Length - NonAlphaNumericChars; i++)
                pass[i] = allowedChars[rd.Next(0, allowedChars.Length)];

            //Random the NonAlphaNumericChars
            for (i = Length - NonAlphaNumericChars; i < Length; i++)
                pass[i] = allowedNonAlphaNum[rd.Next(0, allowedNonAlphaNum.Length)];

            //Set the sorted array values by the pos array for the rigth posistion
            char[] sorted = new char[Length];
            for (i = 0; i < Length; i++)
                sorted[i] = pass[pos[i]];

            string Pass = new String(sorted);

            return Pass;
        }

        #region New added by Bipin for tesla
        public static void SendMailnew(string server, string userID, string password, string sendTo, string body, string subject)
        {
            try
            {
                // Initialize the MailMessage
                using (var msg = new MailMessage())
                {
                    msg.From = new MailAddress("sales@vcqru.com", "VCQRU");
                    msg.To.Add(sendTo);
                    msg.IsBodyHtml = true;
                    msg.Subject = subject;
                    msg.Body = body;

                    // Initialize the SmtpClient
                    using (var smtpClient = new SmtpClient(server))
                    {
                        smtpClient.EnableSsl = true;
                        smtpClient.UseDefaultCredentials = false;
                        smtpClient.Credentials = new NetworkCredential(userID, password);
                        smtpClient.Port = 587;
                        smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;

                        // Send the email synchronously
                        smtpClient.Send(msg);
                    }
                }
            }
            catch (SmtpException smtpEx)
            {
                // Handle SMTP-specific exceptions
            }
            catch (Exception ex)
            {
                // Handle other exceptions
            }
        }
        #endregion

        public static void sendMailwithattachedment(string server, string userID, string password, string sendTo, string body, string subject, byte[] bytes)
        {
            try
            {
                System.Diagnostics.Stopwatch sWatch = new System.Diagnostics.Stopwatch();
                sWatch.Start();
                MailMessage msg = new MailMessage();
                msg.From = new MailAddress("sales@vcqru.com", "VCQRU");
                msg.To.Add(sendTo);
                msg.IsBodyHtml = true;
                msg.Subject = subject;
                msg.Body = body;
                msg.Attachments.Add(new Attachment(new MemoryStream(bytes), "E-Warranty-Certificate.pdf"));
                SmtpClient sc = new SmtpClient();
                sc.Host = server;
                sc.EnableSsl = true;
                sc.UseDefaultCredentials = false;
                sc.Credentials = new NetworkCredential(userID, password);
                sc.Port = 587;
                sc.DeliveryMethod = SmtpDeliveryMethod.Network;
                sc.SendMailAsync(msg);
                sWatch.Stop();
            }
            catch (Exception e)
            {
                string str;
                str = e.Message.ToString();
            }
        }
        public static void sendMailAttachMultiRecipient(string server, string userID, string password, string sendTo, string sendcc, string body, string subject, string txtfilepth)
        {
            try
            {
                /****** SMTP gmail Code For Send Email Start ******/
                MailMessage msg = new MailMessage();
                msg.From = new MailAddress(userID, "VCQRU");
                if (sendTo.Contains(","))
                {
                    string[] tomail = sendTo.Split(',');
                    foreach (string tmail in tomail)
                    {
                        msg.To.Add(new MailAddress(tmail));
                    }
                }
                else
                {
                    msg.To.Add(sendTo);
                }

                if (sendcc.Contains(","))
                {
                    string[] ccmail = sendcc.Split(',');
                    foreach (string cmail in ccmail)
                    {
                        msg.CC.Add(new MailAddress(cmail));
                    }
                }
                else
                {
                    if (sendcc != "" && sendcc != null)
                        msg.CC.Add(sendcc);
                }

                msg.IsBodyHtml = true;
                msg.Subject = subject;
                msg.Body = body;
                Attachment acc = new Attachment(txtfilepth);
                msg.Attachments.Add(acc);
                SmtpClient sc = new SmtpClient();
                sc.Host = server;
                sc.EnableSsl = true; // changed for vcqru mail domain
                sc.UseDefaultCredentials = false;// changed for vcqru mail domain 
                sc.Credentials = new NetworkCredential(userID, password);
                sc.Port = 587;// changed for vcqru mail domain
                sc.DeliveryMethod = SmtpDeliveryMethod.Network;
                sc.Send(msg);

            }
            catch (Exception e)
            {
                string str;
                str = e.Message.ToString();
            }
        }
        public static void sendMail(string server, string userID, string password, string sendTo, string body, string subject)
        {
            try
            {
                /****** SMTP gmail Code For Send Email Start ******/
               /* MailMessage msg = new MailMessage();
                msg.From = new MailAddress("sales@vcqru.com", "VCQRU");
                msg.To.Add(sendTo);
                msg.IsBodyHtml = true;
                msg.Subject = subject;
                msg.Body = body;
                SmtpClient sc = new SmtpClient();

                sc.Host = server;
                sc.EnableSsl = true; // changed for vcqru mail domain
                sc.UseDefaultCredentials = false;// changed for vcqru mail domain
                sc.Credentials = new NetworkCredential(userID, password);
               
                sc.Port = 587;// changed for vcqru mail domain
                sc.DeliveryMethod = SmtpDeliveryMethod.Network;
                sc.Send(msg);
		*/
 		System.Diagnostics.Stopwatch sWatch = new System.Diagnostics.Stopwatch();
                sWatch.Start();
                /****** SMTP gmail Code For Send Email Start ******/
                MailMessage msg = new MailMessage();
                msg.From = new MailAddress("sales@vcqru.com", "VCQRU");
                msg.To.Add(sendTo);
                msg.IsBodyHtml = true;
                msg.Subject = subject;
                msg.Body = body;
                SmtpClient sc = new SmtpClient();

                sc.Host = server;
                sc.EnableSsl = true; // changed for vcqru mail domain
                sc.UseDefaultCredentials = false;// changed for vcqru mail domain
                sc.Credentials = new NetworkCredential(userID, password);
               
                sc.Port = 587;// changed for vcqru mail domain
                sc.DeliveryMethod = SmtpDeliveryMethod.Network;
                sc.SendMailAsync(msg);
                sWatch.Stop();

                /****** SMTP gmail Code For Send Email End ******/
                /*
                                using (System.Net.Mail.MailMessage mess = new System.Net.Mail.MailMessage())
                                {                  
                                    System.Net.Mail.SmtpClient sc = new System.Net.Mail.SmtpClient();
                                    mess.To.Add(sendTo);
                                    mess.Subject = subject;
                                    mess.Body = body;
                                    mess.IsBodyHtml = true;
                                    mess.From = new System.Net.Mail.MailAddress(userID, "VCQRU");
                                    sc.Host = server;
                                    sc.Port = 25;
                                    sc.UseDefaultCredentials = false;
                                    sc.Credentials = new System.Net.NetworkCredential(userID, password);
                                    sc.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                                    sc.Send(mess);
                                }
                */
            }
            catch (Exception e)
            {
                string str;
                str = e.Message.ToString();
            }
        }
        // added by Satvik
        public static void sendMailCC(string server, string userID, string password, string sendTo, string body, string subject)
        {
            try
            {
                /****** SMTP gmail Code For Send Email Start ******/
                MailMessage msg = new MailMessage();

                msg.From = new MailAddress("sales@vcqru.com", "VCQRU");
                msg.To.Add(sendTo);
                msg.IsBodyHtml = true;
                msg.Subject = subject;
                msg.Body = body;
                SmtpClient sc = new SmtpClient();

                sc.Host = server;
                sc.EnableSsl = true; // changed for vcqru mail domain
                sc.UseDefaultCredentials = false;// changed for vcqru mail domain
                sc.Credentials = new NetworkCredential(userID, password);

                sc.Port = 587;// changed for vcqru mail domain
                sc.DeliveryMethod = SmtpDeliveryMethod.Network;
                sc.SendMailAsync(msg);

            }
            catch (Exception e)
            {
                string str;
                str = e.Message.ToString();
            }
        }
        // Added by Satvik
        public static void sendMailAttach(string server, string userID, string password, string sendTo, string body, string subject,string txtfilepth)
        {
            try
            {
                /****** SMTP gmail Code For Send Email Start ******/
                MailMessage msg = new MailMessage();
                msg.From = new MailAddress(userID, "VCQRU");
                msg.To.Add(sendTo);
                msg.IsBodyHtml = true;
                msg.Subject = subject;
                msg.Body = body;
                Attachment acc = new Attachment(txtfilepth);
                msg.Attachments.Add(acc);
                SmtpClient sc = new SmtpClient();
                sc.Host = server;
               sc.EnableSsl = true; // changed for vcqru mail domain
              //  sc.UseDefaultCredentials = true;// changed for vcqru mail domain
                sc.Credentials = new NetworkCredential(userID, password);
                sc.Port = 587;// changed for vcqru mail domain
                sc.DeliveryMethod = SmtpDeliveryMethod.Network;
                sc.Send(msg);
                /****** SMTP gmail Code For Send Email End ******/
                /*
                                using (System.Net.Mail.MailMessage mess = new System.Net.Mail.MailMessage())
                                {                  
                                    System.Net.Mail.SmtpClient sc = new System.Net.Mail.SmtpClient();
                                    mess.To.Add(sendTo);
                                    mess.Subject = subject;
                                    mess.Body = body;
                                    mess.IsBodyHtml = true;
                                    mess.From = new System.Net.Mail.MailAddress(userID, "VCQRU");
                                    sc.Host = server;
                                    sc.Port = 25;
                                    sc.UseDefaultCredentials = false;
                                    sc.Credentials = new System.Net.NetworkCredential(userID, password);
                                    sc.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                                    sc.Send(mess);
                                }
                */
            }
            catch (Exception e)
            {
                string str;
                str = e.Message.ToString();
            }
        }
        public static void sendMail(string server, string userID, string sendTo, string body, string subject)
        {
            try
            {
                /*
                                server = "email-smtp.us-west-2.amazonaws.com";
                                userID = "AKIAIVNHNXPROLT72V4A";
                                string password = "AnldxokutkUQW+aXr0MLfTV2JTzNFvKfOqKs/iyfY3uN";

                                using (System.Net.Mail.MailMessage mess = new System.Net.Mail.MailMessage())
                                {
                                    System.Net.Mail.SmtpClient sc = new System.Net.Mail.SmtpClient();
                                    mess.To.Add(sendTo);
                                    mess.Subject = subject;
                                    mess.Body = body;
                                    mess.IsBodyHtml = true;
                    
                                    mess.From = new System.Net.Mail.MailAddress(userID);
                                    sc.Host = server;
                                    sc.Port = 25;
                    
                                    sc.UseDefaultCredentials = false;
                                    sc.Credentials = new System.Net.NetworkCredential(userID, password);
                                    sc.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                                    sc.Send(mess);
                                }
                */
            }
            catch (Exception)
            {

            }
        }


        public static bool AttSendMail(string server, string userID, string password, string sendTo, string body, string subject, string sendcc, string sendbcc, string txtfilepth)
        {
            try
            {


                /****** SMTP gmail Code For Send Email Start ******/
                MailMessage msg = new MailMessage();
            msg.From = new MailAddress(userID, "VCQRU");
                msg.To.Add(sendTo);
            msg.IsBodyHtml = true;
            msg.Subject = subject;
            msg.Body = body;
            if (txtfilepth != "")
                msg.Attachments.Add(new Attachment(txtfilepth));
            SmtpClient sc = new SmtpClient();
            sc.Host = server;
            sc.EnableSsl = true;
            //sc.UseDefaultCredentials = true;
            sc.Credentials = new NetworkCredential(userID, password);
            sc.Port = 587;
                sc.DeliveryMethod = SmtpDeliveryMethod.Network;
                sc.Send(msg);
                return true;
                /****** SMTP gmail Code For Send Email End ******/
                /*
                            using (System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage())
                                try
                                {
                                    System.Net.Mail.SmtpClient sc = new System.Net.Mail.SmtpClient();
                                    mail.To.Add(sendTo);
                                    if (sendcc != "")
                                        mail.CC.Add(sendcc);
                                    if (sendbcc != "")
                                        mail.Bcc.Add(sendbcc);
                                    mail.Subject = subject;
                                    mail.Body = body;
                                    mail.IsBodyHtml = true;
                                    if (txtfilepth != "")
                                        mail.Attachments.Add(new Attachment(txtfilepth));
                                    mail.From = new System.Net.Mail.MailAddress(userID);
                                    sc.Host = server;
                                    sc.Port = 25;
                                    sc.UseDefaultCredentials = false;
                                    sc.Credentials = new System.Net.NetworkCredential(userID, password);
                                    sc.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                                    sc.Send(mail);
                                }
                                catch (Exception ex)
                                {
                                    //Response.Write(ex.Message);
                                }
                */
            }
            catch (Exception)
            {

                return false;
            }
        }
        public static string FindMailBody()
        {
            #region Mail Body
            return "<style type='text/css'>" +
            " .latter" +
            " {" +
                " width:100%;" +
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
                " height:75px;" +
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
                " height:84px;" +
                " width:278px;" +
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
            " 	border:2px solid #2587D5" +
            " }" +
            " </style>";
            #endregion
        }
        public static string FindMailBody(string Comp_Name, string HeadName, string details)
        {
            #region Mail Body
            string srt = "<style type='text/css'>" +
            " .latter" +
            " {" +
                " width:100%;" +
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
                " height:84px;" +
                " width:278px;" +
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
            " 	border:2px solid #2587D5" +
            " }" +
            " </style>";
            #endregion
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                      " <div class='w_logo'><img src='"+  ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
                      " <hr style='border:1px solid #2587D5;'/>" +
                      " <div class='w_frame'>" +
                      " <p>" +
                      " <div class='w_detail'>" +
                      " <span><em><strong> " + HeadName + " </strong></em></span><br />" +
                      " <br />" +
                      "<br/> <strong>" + Comp_Name + "'s</strong> " + details + " <br/> " +
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
        public static void CreateExcel(DataTable dt, string DirectoryName, string Comp_ID, string Pro_ID, int i, string LBLREQID)
        {
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    //// byte[] bytes = (byte[])GetData("SELECT Data FROM Images WHERE Id =" + id).Rows[0]["Data"];
                    //string base64String = Convert.ToBase64String(QRCode, 0, QRCode.Length);
                    //// Image1.ImageUrl = "data:image/png;base64," + base64String;
                    string FilePathName = DirectoryName + "\\" + Comp_ID.Substring(5, 4) + "_" + Pro_ID.ToString() + "_" + LBLREQID + "_" + i.ToString() + ".xls";
                    StreamWriter writer = File.AppendText(FilePathName);
                    FileInfo fileInfo = new FileInfo(FilePathName);
                    fileInfo.IsReadOnly = true;
                    DataGrid gvDetails = new DataGrid();
                    gvDetails.DataSource = dt;
                    gvDetails.DataBind();
                    gvDetails.RenderControl(hw);
                    writer.WriteLine(sw.ToString());
                    writer.Close();
                }
            }
        }
        private static PdfPTable Add_Content_To_PDF1(PdfPTable tableLayout, System.Data.DataTable dt,string PrintLabelOrQrcode)
        {
            try
            {


                float[] headers;//

                if (PrintLabelOrQrcode == "2")
                {
                    headers = new float[] { 20, 20, 60 };
                }
                else
                {
                    headers = new float[] { 20, 20, 20, 20, 20 };
                }
                //Header Widths
                tableLayout.SetWidths(headers);        //Set the pdf headers
                tableLayout.WidthPercentage = 80;       //Set the PDF File witdh percentage
                tableLayout.SpacingAfter = 20f;


                tableLayout.AddCell(new PdfPCell(new iTextSharp.text.Phrase("Sno")));
                tableLayout.AddCell(new PdfPCell(new iTextSharp.text.Phrase("Searies_Name")));
                if (PrintLabelOrQrcode == "2")
                {
                    tableLayout.AddCell(new PdfPCell(new iTextSharp.text.Phrase("QR_Code")));
                }
                else
                {
                    tableLayout.AddCell(new PdfPCell(new iTextSharp.text.Phrase("Code1")));
                    tableLayout.AddCell(new PdfPCell(new iTextSharp.text.Phrase("Code2")));
                    tableLayout.AddCell(new PdfPCell(new iTextSharp.text.Phrase("QR_Code")));
                }


                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (i == 25000 || i == 50000 || i == 75000)
                    {
                        System.Threading.Thread.Sleep(2000);
                        SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('Sleep -" + i + "')");

                    }
                    int j = i + 1;
                    iTextSharp.text.Image image = iTextSharp.text.Image.GetInstance((byte[])dt.Rows[i]["QRCode"]);
                    image.ScalePercent(44f);
                    image.ScaleToFit(500f, 30f);
                    image.GetLeft(10f);

                    tableLayout.AddCell(new PdfPCell(new iTextSharp.text.Phrase(i.ToString())));
                    tableLayout.AddCell(new PdfPCell(new iTextSharp.text.Phrase(dt.Rows[i]["Searies_Name"].ToString())));                    
                    if (PrintLabelOrQrcode == "2")
                    {
                        tableLayout.AddCell(new PdfPCell(image));
                    }
                    else
                    {
                        tableLayout.AddCell(new PdfPCell(new iTextSharp.text.Phrase(dt.Rows[i]["Code1"].ToString())));
                        tableLayout.AddCell(new PdfPCell(new iTextSharp.text.Phrase(dt.Rows[i]["Code2"].ToString())));
                        tableLayout.AddCell(new PdfPCell(image));
                    }
                }
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return tableLayout;
        }
        public static void CreateExcel_PrintLabels(DataTable dt, string DirectoryName, string Comp_ID, string Pro_ID, int i, string LBLREQID,string PrintLabelOrQrcode)
        {
           // using (StringWriter sw = new StringWriter())
            {
              //  using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    iTextSharp.text.Document doc = new iTextSharp.text.Document(iTextSharp.text.PageSize.A4, 10f, 10f, 10f, 0f);
                 //   string strAdminPath = "~/QRImage/TestQRCode/";
                 //   string subPath = HttpContext.Current.Server.MapPath(strAdminPath); // your code goes here
                 //   string subPathWithFilename = HttpContext.Current.Server.MapPath(strAdminPath + DateTime.Now.ToString("dd-MM-yyyy hhmmss") + ".pdf");
                    string FilePathName_pdf = DirectoryName + "\\" + Comp_ID.Substring(5, 4) + "_" + Pro_ID.ToString() + "_" + LBLREQID + "_" + i.ToString() + ".pdf";
                    PdfWriter.GetInstance(doc, new FileStream(FilePathName_pdf, FileMode.Create));
                    doc.Open();
                    int columnNo = 5;
                    if (PrintLabelOrQrcode == "2")
                    {
                        columnNo = 3;
                    }
                    PdfPTable tableLayout1 = new PdfPTable(columnNo);
                    doc.Add(Add_Content_To_PDF1(tableLayout1, dt, PrintLabelOrQrcode));
                    doc.Close();
                    ////// byte[] bytes = (byte[])GetData("SELECT Data FROM Images WHERE Id =" + id).Rows[0]["Data"];
                    ////string base64String = Convert.ToBase64String(QRCode, 0, QRCode.Length);
                    ////// Image1.ImageUrl = "data:image/png;base64," + base64String;
                    //string FilePathName = DirectoryName + "\\" + Comp_ID.Substring(5, 4) + "_" + Pro_ID.ToString() + "_" + LBLREQID + "_" + i.ToString() + ".xls";
                    //StreamWriter writer = File.AppendText(FilePathName);
                    //FileInfo fileInfo = new FileInfo(FilePathName);
                    //fileInfo.IsReadOnly = true;
                    //DataGrid gvDetails = new DataGrid();
                    //gvDetails.DataSource = dt;
                    //gvDetails.DataBind();
                    //gvDetails.RenderControl(hw);
                    //writer.WriteLine(sw.ToString());
                    //writer.Close();
                }
            }
        }
        public static void DeleteDirectoryDemo(string path)
        {
            System.IO.DirectoryInfo dir = new System.IO.DirectoryInfo(path);
            if (dir.Exists)
            {
                System.IO.DirectoryInfo downloadedMessageInfo = new DirectoryInfo(path);
                foreach (DirectoryInfo dirq in downloadedMessageInfo.GetDirectories())
                    dirq.Delete(true);
                System.IO.Directory.Delete(path, true);
            }
        }

        public static DataTable CreateAssingedImageDataTable()
        {
            DataTable myDataTable = new DataTable();
            DataColumn myDataColumn;
            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.Int64");
            myDataColumn.ColumnName = "Id";
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.String");
            myDataColumn.ColumnName = "M_CodeId";
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.String");
            myDataColumn.ColumnName = "ArtImageId";
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.String");
            myDataColumn.ColumnName = "ReqDate";
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.String");
            myDataColumn.ColumnName = "Code1";
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.String");
            myDataColumn.ColumnName = "Code2";
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.String");
            myDataColumn.ColumnName = "ImagePath";
            myDataTable.Columns.Add(myDataColumn);


            return myDataTable;
        }
        //  Deep Shukla ------- Add  ImageFile Column
        public static DataTable CreateDataTableExcelImageFile()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("SNO", typeof(Int32));
            dt.Columns.Add("Searies_Name", typeof(string));
            dt.Columns.Add("Code1", typeof(Int32));
            dt.Columns.Add("Code2", typeof(Int32));
            dt.Columns.Add("QRCode", typeof(string));
            dt.Columns.Add("ImageFile", typeof(string));
            return dt;
        }

        public static DataTable CreateDataTableExcel()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("SNO", typeof(Int32));
            dt.Columns.Add("Searies_Name", typeof(string));
            dt.Columns.Add("Code1", typeof(Int32));
            dt.Columns.Add("Code2", typeof(Int32));
            return dt;
        }
        public static DataTable CreateDataTableExcel_PrintLabels()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("SNO", typeof(Int32));
            dt.Columns.Add("Searies_Name", typeof(string));
            dt.Columns.Add("Code1", typeof(Int32));
            dt.Columns.Add("Code2", typeof(Int32));
            dt.Columns.Add("QRCode", typeof(Byte[]));
            return dt;
        }

public static DataTable AddNewRowsExcel_ImageFile_PrintLabels(DataTable dt, Int32 Code1, Int32 Code2, Int32 SNO, string Searies_Name, string ImageFile)
        {
            DataRow dr = dt.NewRow();
            dr["SNO"] = SNO;
            dr["Searies_Name"] = Searies_Name;
            dr["Code1"] = Code1;
            dr["Code2"] = Code2;
            dr["QRCode"] = "https://www.patanjaliayurved.net/authentic_products.html?codeone=" + Code1 + "-" + Code2;
            dr["ImageFile"] = ImageFile;
            dt.Rows.Add(dr);
            return dt;
        }

        public static DataTable AddNewRowsExcel(DataTable dt, Int32 Code1, Int32 Code2, Int32 SNO, string Searies_Name)
        {
            DataRow dr = dt.NewRow();
            dr["SNO"] = SNO;
            dr["Searies_Name"] = Searies_Name;
            dr["Code1"] = Code1;
            dr["Code2"] = Code2;
            dt.Rows.Add(dr);
            return dt;
        }
        public static DataTable AddNewRowsExcel_PrintLabels(DataTable dt, Int32 Code1, Int32 Code2, Int32 SNO, string Searies_Name,byte[] QRCode)
        {
            DataRow dr = dt.NewRow();
            dr["SNO"] = SNO;
            dr["Searies_Name"] = Searies_Name;
            dr["Code1"] = Code1;
            dr["Code2"] = Code2;
            dr["QRCode"] = QRCode;
            dt.Rows.Add(dr);
            return dt;
        }
        public static void DeleteDirectory(string path)
        {
            System.IO.DirectoryInfo dir = new System.IO.DirectoryInfo(path);
            if (dir.Exists)
                System.IO.Directory.Delete(path, true);

        }
        public static void CreateDirectory(string directoryPath)
        {
            DirectoryInfo directory = new DirectoryInfo(directoryPath);
            if (!directory.Exists)
                System.IO.Directory.CreateDirectory(directoryPath);
        }
        public static void DeleteFiles(string FilePath)
        {
            if (File.Exists(FilePath))
                File.Delete(FilePath);
        }
        public static string GetMyGenID(string KeyName)
        {
            DataTable dt = SQL_DB.ExecuteDataSet("SELECT id, Prfor, PrPrefix, PrStart, PrFlag FROM Code_Gen  WHERE Prfor = '" + KeyName + "' ").Tables[0];
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0]["PrPrefix"].ToString()+dt.Rows[0]["PrStart"].ToString();
            }
            else
                return "";
        }
        public static void SetMyGenID(string KeyName)
        {
            Int64 PrStart = 0;
            DataTable dt = SQL_DB.ExecuteDataSet("SELECT id, Prfor, PrPrefix, PrStart, PrFlag FROM Code_Gen  WHERE Prfor = '" + KeyName + "' ").Tables[0];
            if (dt.Rows.Count > 0)
            {
                PrStart = Convert.ToInt64(dt.Rows[0]["PrStart"].ToString());
                PrStart++;
                SQL_DB.ExecuteNonQuery("UPDATE Code_Gen SET PrStart = '" + PrStart + "' WHERE Prfor = '" + KeyName + "' ");
            }
        }
    }
    public class MyUtilities
    {
        public static string SplitString(string str, string delmeters)
        {
            char[] delimiterChars = { ' ', ',', '.', ':', '\t' };

            string text = "one\ttwo three:four,five six seven";
            System.Console.WriteLine("Original text: '{0}'", text);

            string[] words = text.Split(delimiterChars);
            System.Console.WriteLine("{0} words in text:", words.Length);

            foreach (string s in words)
            {
                System.Console.WriteLine(s);
            }

            // Keep the console window open in debug mode.
            System.Console.WriteLine("Press any key to exit.");
            System.Console.ReadKey();
            return str;
        }
        public static void FillDropDownList(DataSet ds, string ValField, string NmField, DropDownList MyDDL)
        {
            MyDDL.DataSource = ds.Tables[0];
            MyDDL.DataTextField = NmField;
            MyDDL.DataValueField = ValField;
            MyDDL.DataBind();
        }
        public static void FillDropDownList(DataSet ds, string ValField, string NmField, DropDownList MyDDL, string RowfilterString)
        {
            DataView dv = ds.Tables[0].DefaultView;
            dv.RowFilter = RowfilterString;
            MyDDL.DataSource = dv.ToTable();
            MyDDL.DataTextField = NmField;
            MyDDL.DataValueField = ValField;
            MyDDL.DataBind();
        }
        public static void FillDDLInsertZeroIndexString(DataTable ds, string ValField, string NmField, DropDownList MyDDL, string ZeroIndexString)
        {
            MyDDL.Items.Clear();
            DataRow dr = ds.NewRow();
            dr[0] = ZeroIndexString;
            dr[1] = ZeroIndexString;
            ds.Rows.InsertAt(dr, 0);
            MyDDL.DataSource = ds;
            MyDDL.DataTextField = NmField;
            MyDDL.DataValueField = ValField;
            MyDDL.DataBind();
        }

        public static void FillDDLInsertZeroIndexString1(DataSet ds, string ValField, string NmField, DropDownList MyDDL, string ZeroIndexString)
        {
            MyDDL.Items.Clear();
            DataRow dr = ds.Tables[0].NewRow();
            dr[ValField] = 0;
            dr[NmField] = ZeroIndexString;
            ds.Tables[0].Rows.InsertAt(dr, 0);
            MyDDL.DataSource = ds.Tables[0];
            MyDDL.DataTextField = NmField;
            MyDDL.DataValueField = ValField;
            MyDDL.DataBind();
        }


        public static void FillLISTInsertZeroIndexString(DataTable ds, string ValField, string NmField, ListBox MyDDL, string ZeroIndexString)
        {
            MyDDL.Items.Clear();
            DataRow dr = ds.NewRow();
            dr[0] = ZeroIndexString;
            dr[1] = ZeroIndexString;
            ds.Rows.InsertAt(dr, 0);
            MyDDL.DataSource = ds;
            MyDDL.DataTextField = NmField;
            MyDDL.DataValueField = ValField;
            MyDDL.DataBind();
        }
        public static void FillLISTsinglecolumnInsertZeroIndexString(DataTable ds, string ValField, string NmField, ListBox MyDDL, string ZeroIndexString)
        {
            MyDDL.Items.Clear();
            DataRow dr = ds.NewRow();
            dr[0] = ZeroIndexString;
            ds.Rows.InsertAt(dr, 0);
            MyDDL.DataSource = ds;
            MyDDL.DataTextField = NmField;
            MyDDL.DataValueField = ValField;
            MyDDL.DataBind();
        }
        public static void FillDDLInsertZeroIndexString(DataSet ds, string ValField, string NmField, DropDownList MyDDL, string ZeroIndexString)
        {
            MyDDL.Items.Clear();
            DataRow dr = ds.Tables[0].NewRow();
            dr[ValField] = ZeroIndexString;
            dr[NmField] = ZeroIndexString;
            ds.Tables[0].Rows.InsertAt(dr, 0);
            MyDDL.DataSource = ds.Tables[0];
            MyDDL.DataTextField = NmField;
            MyDDL.DataValueField = ValField;
            MyDDL.DataBind();
        }
      
        public static void FillDDLInsertZeroIndexStringWithEmpty(DataSet ds, string ValField, string NmField, DropDownList MyDDL, string ZeroIndexString)
        {
            MyDDL.Items.Clear();
            DataRow dr = ds.Tables[0].NewRow();
            dr[ValField] = "";
            dr[NmField] = ZeroIndexString;
            ds.Tables[0].Rows.InsertAt(dr, 0);
            MyDDL.DataSource = ds.Tables[0];
            MyDDL.DataTextField = NmField;
            MyDDL.DataValueField = ValField;
            MyDDL.DataBind();
        }
        public static void FillDDLInsertZeroIndexIntVal(DataSet ds, string ValField, string NmField, DropDownList MyDDL, string ZeroIndexString)
        {
            MyDDL.Items.Clear();
            DataRow dr = ds.Tables[0].NewRow();
            dr[ValField] = 0;
            dr[NmField] = ZeroIndexString;
            ds.Tables[0].Rows.InsertAt(dr, 0);
            MyDDL.DataSource = ds.Tables[0];
            MyDDL.DataTextField = NmField;
            MyDDL.DataValueField = ValField;
            MyDDL.DataBind();
        }
        public static void FillDDLInsertZeroIndexIntValBy(DataTable dt, string ValField, string NmField, DropDownList MyDDL, string ZeroIndexString)
        {
            MyDDL.Items.Clear();
            //DataRow dr = dt.NewRow();
            //dr[ValField] = 0;
            //dr[NmField] = ZeroIndexString;
           
            MyDDL.DataSource = dt;
            MyDDL.DataTextField = NmField;
            MyDDL.DataValueField = ValField;
            MyDDL.DataBind();
            MyDDL.Items.Insert(0, "--Select--");

        }
        public static void FillDDLInsertZeroIndexIntValbyShweta(DataSet ds, string ValField, string NmField, DropDownList MyDDL, string ZeroIndexString)
        {
            MyDDL.Items.Clear();
            //DataRow dr = ds.Tables[0].NewRow();
            //dr[ValField] = 0;
            //dr[NmField] = ZeroIndexString;
            //ds.Tables[0].Rows.InsertAt(dr, 0);
            MyDDL.DataSource = ds.Tables[0];
            MyDDL.DataTextField = NmField;
            MyDDL.DataValueField = ValField;
            MyDDL.DataBind();
            MyDDL.Items.Insert(0, "--Select--");
        }

        public static void FillDDLInsertBlankIndex(DataSet ds, string ValField, string NmField, DropDownList MyDDL, string ZeroIndexString)
        {
            MyDDL.Items.Clear();
            DataRow dr = ds.Tables[0].NewRow();
            dr[ValField] = "";
            dr[NmField] = ZeroIndexString;
            ds.Tables[0].Rows.InsertAt(dr, 0);
            MyDDL.DataSource = ds.Tables[0];
            MyDDL.DataTextField = NmField;
            MyDDL.DataValueField = ValField;
            MyDDL.DataBind();
        }
        public static void FillDDLInsertBlankIndexWithZero(DataTable dt, string ValField, string NmField, DropDownList MyDDL, string ZeroIndexString)
        {
            MyDDL.Items.Clear();
            DataRow dr = dt.NewRow();
            dr[ValField] = "0";
            dr[NmField] = ZeroIndexString;
            dt.Rows.InsertAt(dr, 0);
            MyDDL.DataSource = dt;
            MyDDL.DataTextField = NmField;
            MyDDL.DataValueField = ValField;
            MyDDL.DataBind();
        }
        public static void FillGrid(DataSet ds, GridView MyGrid)
        {
            MyGrid.DataSource = ds.Tables[0];
            MyGrid.DataBind();
        }

        public static void FillDropDownList(string p, string p_2, string p_3, DropDownList ddlCategory)
        {
            throw new NotImplementedException();
        }

        public static string NumberToWords(int number)
        {
            if (number == 0)
                return "zero";

            if (number < 0)
                return "minus " + NumberToWords(Math.Abs(number));

            string words = "";

            if ((number / 1000000) > 0)
            {
                words += NumberToWords(number / 1000000) + " million ";
                number %= 1000000;
            }

            if ((number / 1000) > 0)
            {
                words += NumberToWords(number / 1000) + " thousand ";
                number %= 1000;
            }

            if ((number / 100) > 0)
            {
                words += NumberToWords(number / 100) + " hundred ";
                number %= 100;
            }

            if (number > 0)
            {
                if (words != "")
                    words += "and ";

                var unitsMap = new[] { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen" };
                var tensMap = new[] { "zero", "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety" };

                if (number < 20)
                    words += unitsMap[number];
                else
                {
                    words += tensMap[number / 10];
                    if ((number % 10) > 0)
                        words += "-" + unitsMap[number % 10];
                }
            }

            return words;
        }
    }

    public class Uttils
    {

        private static DateTime dto, dfrom;
        public static int Count;
        public static int TDSCount;
        public static int AdminCount;
        public static int AccSMCount;
        public static int CalCount;
        public static int TransCount;
        public Uttils()
        {

        }
        private static int GetPageIndex(int maximumRows, int startRowIndex)
        {
            double d = startRowIndex / maximumRows;
            return Convert.ToInt32(Math.Ceiling(d)) + 1;
        }
        public static string Create_Directory(string str)
        {
            if (Directory.Exists(str))
            { }
            else
                Directory.CreateDirectory(str);
            return str;
        }
        public static DataTable GetRegistration(string Comp_Cat_Id, string Contact_Person, DateTime DateFrom, DateTime DateTo, int Status, int Email_Vari_flag, string SortCol, int maximumRows, int startRowIndex)
        {
            if (startRowIndex > 0)
                startRowIndex = GetPageIndex(maximumRows, startRowIndex);
            SqlParameter ParamComp_Cat_Id = new SqlParameter("Comp_Cat_Id", Comp_Cat_Id);
            SqlParameter ParamContact_Person = new SqlParameter("Contact_Person", Contact_Person);
            SqlParameter ParamDateFrom = new SqlParameter("DateFrom", DateFrom);
            SqlParameter ParamDateTO = new SqlParameter("DateTO", DateTo);
            SqlParameter ParamStatus = new SqlParameter("Status", Status);
            SqlParameter ParamEmail_Vari_flag = new SqlParameter("Email_Vari_flag", Email_Vari_flag);
            SqlParameter ParamPIndex = new SqlParameter("Page_Index", startRowIndex);
            SqlParameter ParamPSize = new SqlParameter("Page_Size", maximumRows);
            DataTable dt = new DataTable();
            dt = Procedure.GetProcedureData("GeRegistration", ParamComp_Cat_Id, ParamPIndex, ParamPSize, ParamContact_Person, ParamDateFrom, ParamDateTO, ParamStatus, ParamEmail_Vari_flag);
            DataView dv = dt.DefaultView;
            dv.Sort = SortCol;
            return dv.ToTable();
        }

        public static int RegCount(string Comp_Cat_Id, string Contact_Person, DateTime DateFrom, DateTime DateTo, int Status, int Email_Vari_flag, string SortCol)
        {
            Count = GetRegistration(Comp_Cat_Id, Contact_Person, DateFrom, DateTo, Status, Email_Vari_flag, SortCol, 999999, 0).Rows.Count;
            return Count;
        }

        public static DataTable GetCalData(string User_Id, string Datefrom, string Dateto, string Condition, int maximumRows, int startRowIndex)
        {
            if (startRowIndex > 0)
                startRowIndex = GetPageIndex(maximumRows, startRowIndex);
            if (startRowIndex == 0)
                startRowIndex = 1;

            if (Datefrom != "" && Datefrom != " ")
            {

                dfrom = Convert.ToDateTime(Datefrom);
                Datefrom = dfrom.ToString("MM/dd/yyyy");
            }
            if (Dateto != "" && Dateto != " ")
            {
                string[] str = Dateto.Split('/');
                dto = Convert.ToDateTime(Dateto);
                Dateto = dto.ToString("MM/dd/yyyy");
            }
            DataSet ds = new DataSet();
            string s = "Select * from (SELECT row_number() over(order by tbl_id) as Row_No , Cal_Payment_Tab.tbl_id, Cal_Payment_Tab.ID, Cal_Payment_Tab.User_Id, Registration.name,Cal_Payment_Tab.BV_Amount, " +
                      " Cal_Payment_Tab.Admin, Cal_Payment_Tab.TDS, Cal_Payment_Tab.WelFair, Cal_Payment_Tab.Final_Amount, Cal_Payment_Tab.Entry_Date,  " +
                      " Cal_Payment_Tab.Cal_Date, Cal_Payment_Tab.Chq_No, Cal_Payment_Tab.Chq_Issue_date, Cal_Payment_Tab.Chq_Remark,  " +
                      " Cal_Payment_Tab.Grwth_Amt, Cal_Payment_Tab.Tot_User, Cal_Payment_Tab.award_id, Cal_Payment_Tab.rewarded, Cal_Payment_Tab.TDS_Per,  " +
                      " Cal_Payment_Tab.Admin_Per, Cal_Payment_Tab.Lvl1 + Cal_Payment_Tab.Lvl2+ Cal_Payment_Tab.Lvl3+ Cal_Payment_Tab.Lvl4+ Cal_Payment_Tab.Lvl5+ Cal_Payment_Tab.Lvl6 AS Lvl, Registration.status " +
                      " FROM         Cal_Payment_Tab INNER JOIN " +
                      " Registration ON Cal_Payment_Tab.User_Id = Registration.user_id " +
                      " where (''='" + User_Id + "' or '" + User_Id + "' is null or  Cal_Payment_Tab.User_Id='" + User_Id + "') and  ((''='" + Datefrom + "' or '" + Datefrom + "' is null or Cal_Payment_Tab.Cal_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (''='" + Dateto + "' or '" + Dateto + "' is null or Cal_Payment_Tab.Cal_Date<='" + dto.ToString("MM/dd/yyyy") + "')) " + Condition + ") Cal_Tab where Row_No>(" + (startRowIndex - 1) * maximumRows + ") and Row_No<=(" + (startRowIndex) * maximumRows + ")     order by Cal_Tab.Cal_Date ";
            SQL_DB.GetDA(s).Fill(ds, "1");
            return ds.Tables[0];
        }
        public static int CalDataCount(string User_Id, string Datefrom, string Dateto, string Condition)
        {
            if (Datefrom != "" && Datefrom != " ")
            {

                dfrom = Convert.ToDateTime(Datefrom);
                Datefrom = dfrom.ToString("MM/dd/yyyy");
            }
            if (Dateto != "" && Dateto != " ")
            {

                dto = Convert.ToDateTime(Dateto);
                Dateto = dto.ToString("MM/dd/yyyy");
            }
            string s = "Select count(*) from (SELECT row_number() over(order by tbl_id) as Row_No , Cal_Payment_Tab.tbl_id, Cal_Payment_Tab.ID, Cal_Payment_Tab.User_Id, Registration.name,Cal_Payment_Tab.BV_Amount, " +
                      " Cal_Payment_Tab.Admin, Cal_Payment_Tab.TDS, Cal_Payment_Tab.WelFair, Cal_Payment_Tab.Final_Amount, Cal_Payment_Tab.Entry_Date,  " +
                      " Cal_Payment_Tab.Cal_Date, Cal_Payment_Tab.Chq_No, Cal_Payment_Tab.Chq_Issue_date, Cal_Payment_Tab.Chq_Remark,  " +
                      " Cal_Payment_Tab.Grwth_Amt, Cal_Payment_Tab.Tot_User, Cal_Payment_Tab.award_id, Cal_Payment_Tab.rewarded, Cal_Payment_Tab.TDS_Per,  " +
                      " Cal_Payment_Tab.Admin_Per,Cal_Payment_Tab.Lvl1 + Cal_Payment_Tab.Lvl2+ Cal_Payment_Tab.Lvl3+ Cal_Payment_Tab.Lvl4+ Cal_Payment_Tab.Lvl5+ Cal_Payment_Tab.Lvl6 AS Lvl, Registration.status " +
                      " FROM         Cal_Payment_Tab INNER JOIN " +
                      " Registration ON Cal_Payment_Tab.User_Id = Registration.user_id " +
                      " where (''='" + User_Id + "' or '" + User_Id + "' is null or  Cal_Payment_Tab.User_Id='" + User_Id + "') and  ((''='" + Datefrom + "' or '" + Datefrom + "' is null or Cal_Payment_Tab.Cal_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (''='" + Dateto + "' or '" + Dateto + "' is null or Cal_Payment_Tab.Cal_Date<='" + dto.ToString("MM/dd/yyyy") + "')) " + Condition + ") Cal_Tab ";
            CalCount = Convert.ToInt32(SQL_DB.ExecuteScalar(s));
            return CalCount;
        }

        public static string GetNewCode(string Keycol)
        {
            return Convert.ToString(SQL_DB.ExecuteScalar("SELECT [Prefix]+convert(varchar,[Start]) as id FROM [Code_Gen] where Keycol='" + Keycol + "'"));
        }
        public static void SetNewCode(string Keycol)
        {
            SQL_DB.ExecuteNonQuery("Update Code_Gen Set [Start]=[Start]+1 where Keycol='" + Keycol + "'");
        }


    }
    public class Procedure
    {
        private static SqlCommand cmd;
        private static SqlConnection con;
        private static SqlDataAdapter adp;
        public static void ExecuteProcedure(string ProcedureName, params   SqlParameter[] ProParameters)
        {
            con = SQL_DB.CreateConnection();
            cmd = SQL_DB.CreateCommand(con, ProcedureName);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddRange(ProParameters);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
        public static DataTable GetProcedureData(string ProcedureName, params   SqlParameter[] ProParameters)
        {
            con = SQL_DB.CreateConnection();
            cmd = SQL_DB.CreateCommand(con, ProcedureName);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddRange(ProParameters);
            adp = new SqlDataAdapter(cmd);
            DataTable ds = new DataTable();
            adp.Fill(ds);
            return ds;
        }
        public static DataTable GetProcedureData(string ProcedureName, string strServiceName,params SqlParameter[] ProParameters)
        {
            con = SQL_DB.CreateConnection();
            cmd = SQL_DB.CreateCommand(con, ProcedureName);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddRange(ProParameters);
            adp = new SqlDataAdapter(cmd);
            DataTable ds = new DataTable();
            adp.Fill(ds);
            return ds;
        }

    }
    public class User_Status
    {
        public static string CheckUserStatus(string Comp_ID, string User_Type)
        {
            Object9420 obj = new Object9420();
            obj.Comp_ID = Comp_ID;
            DataSet ds = function9420.CheckStatusForMan(obj);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["Comp_Type"].ToString().Trim() == "D")
                    return "Message.aspx";
                else
                {
                    if (ds.Tables[0].Rows[0]["Status"].ToString() == "0")
                        return "Message.aspx";
                }
            }
            return "";
        }
        public static string CheckUserStatus1(string Comp_ID, string User_Type)
        {
            Object9420 obj = new Object9420();
            obj.Comp_ID = Comp_ID;
            DataSet ds = function9420.CheckStatusForMan(obj);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["Comp_Type"] == "D")
                    return "Message.aspx";
                else
                {
                    if (ds.Tables[0].Rows[0]["Status"].ToString() == "0")
                        return "#";
                }
            }
            return "";
        }
    }

    public class Invoice
    {
        public static double LabelPrice = 0.0, Vat = 0.0, Vat_PerLabel = 0.0, Adnavce = 0.0, Vat_TaxValue = 0.0, Service_Tax = 0.0, Service_TaxValue = 0.0, Total_Amount = 0.0, No_Of_Labels = 0.0, Net_Amount = 0.0, Grand_Amt = 0.0, Due_Amt = 0.0, Tax = 0.0, TaxperLabel = 0.0, LabelRateperLabel = 0.0;

        public static void CreateInvoice(Business9420.Object9420 Reg)
        {
            string InvoiceNo = Reg.Invoice_No;
            string pdfpath = Reg.FolderPath + "\\" + DataProvider.LocalDateTime.Now.ToString("dd-MM-yyyy");
            DataProvider.Utility.CreateDirectory(pdfpath);
            string imagepath = Reg.ImgFolderPath;
            FillData(Reg);
            //Create PDF Table
            PdfPTable tableLayout = new PdfPTable(5);
            PdfPTable tableLayout1 = new PdfPTable(2);
            PdfPTable tableLayout2 = new PdfPTable(3);
            PdfPTable tableLayout0 = new PdfPTable(2);
            Document doc = new Document();
            try
            {
                string filename = string.Format("{0}.pdf", InvoiceNo);
                PdfWriter writer = PdfWriter.GetInstance(doc, new FileStream(pdfpath + "\\" + filename, FileMode.Create));
                doc.Open();

                ////doc.Add(new Paragraph("GIF"));
                //iTextSharp.text.Image gif = iTextSharp.text.Image.GetInstance(imagepath + "/logo.png");
                //gif.ScaleToFit(150f, 50f);
                //doc.Add(gif);

                float[] headers = { 80, 20 };
                tableLayout0.SetWidths(headers);        //Set the pdf headers
                tableLayout0.WidthPercentage = 100;       //Set the PDF File witdh percentage 

                // add a image
                iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(imagepath + "/logo.png");
                logo.ScaleToFit(150f, 50f);
                PdfPCell imageCell = new PdfPCell(logo);
                //imageCell.Colspan = 2; // either 1 if you need to insert one cell
                imageCell.Border = 0;
                imageCell.HorizontalAlignment = 0; //0=Left, 1=Centre, 2=Right


                // add a image
                tableLayout0.AddCell(imageCell);

                Font lightblue = new Font(Font.FontFamily.TIMES_ROMAN, 22f, Font.NORMAL, new BaseColor(43, 145, 175));
                PdfPCell cell = new PdfPCell(new Phrase("INVOICE", lightblue));
                //cell.Colspan = 3;
                cell.Border = 0;
                //cell.Padding = 1f;
                //cell.BackgroundColor = BaseColor.GRAY;
                cell.HorizontalAlignment = 1; //0=Left, 1=Centre, 2=Right
                tableLayout0.AddCell(cell);

                doc.Add(tableLayout0);

                //Add Content to PDF
                doc.Add(Content_To_PDF(writer, doc, tableLayout2, Reg));

                //Add Content to PDF
                doc.Add(Add_Content_To_PDF1(tableLayout1));

                //Add Content to PDF
                doc.Add(Add_Content_To_PDF(tableLayout));

                // Add text in footer
                //Font lightblue1 = new Font(Font.FontFamily.TIMES_ROMAN, 14f, Font.NORMAL, new BaseColor(43, 145, 175));
                //Paragraph p = new Paragraph("Thanks for using Label9420", lightblue1);
                //p.Alignment = 1;
                //doc.Add(p);
                OnEndPage(writer, doc);

                // Add WaterTextMark in pdf                

                ////PdfWriter pdfWriter = PdfWriter.GetInstance(pdfDoc, msReport);
                //writer.PageEvent = new PdfWriterEvents("Label9420.com");
                //PdfWriterEvents.OnStartPage(writer, doc);

                // Closing the document
                doc.Close();
            }
            catch (Exception )
            {
                //Log error;
            }
            finally
            {
                doc.Close();
            }
        }

        private static PdfPTable Content_To_PDF(PdfWriter writer, Document doc, PdfPTable tableLayout, Object9420 Reg)
        {
            #region New Disign
            PdfPCell cell = null;
            //float[] headers = { 20, 20, 30, 30 };  //Header Widths
            float[] headers = { 70, 15, 15 };
            tableLayout.SetWidths(headers);        //Set the pdf headers
            tableLayout.WidthPercentage = 100;       //Set the PDF File witdh percentage            

            //Add body
            Font lightblue = new Font(Font.NORMAL, 9f, Font.NORMAL, new BaseColor(43, 145, 175));

            cell = new PdfPCell(new Phrase("", lightblue));//Address
            cell.Colspan = 3;
            cell.Border = 0;
            cell.HorizontalAlignment = 0; //0=Left, 1=Centre, 2=Right
            tableLayout.AddCell(cell);
            //AddCellToBody(tableLayout, p.ToString());            

            AddCellToBody1(tableLayout, "B1-503, Milan Vihar Apartment, Patparganj", 1);
            AddCellToBody2(tableLayout, "Invoice No :", 1);
            AddCellToBody2(tableLayout, Reg.Invoice_No, 1);


            AddCellToBody1(tableLayout, ",New Delhi - 110091.", 1);
            AddCellToBody2(tableLayout, "Date :", 1);
            AddCellToBody2(tableLayout, DataProvider.LocalDateTime.Now.ToString("MMM dd,yyyy"), 1);

            ////Separater Line
            //BaseColor color = new BaseColor(System.Drawing.ColorTranslator.FromHtml("#A9A9A9"));
            //DrawLine(writer, 25f, doc.Top - 104f, doc.PageSize.Width - 25f, doc.Top - 104f, color);
            //DrawLine(writer, 25f, doc.Top - 105f, doc.PageSize.Width - 25f, doc.Top - 105f, color);

            cell = new PdfPCell(new Phrase(""));
            cell.Colspan = 3;
            cell.Border = 1;
            cell.Padding = 1f;
            cell.BackgroundColor = BaseColor.GRAY;
            cell.HorizontalAlignment = 0; //0=Left, 1=Centre, 2=Right
            tableLayout.AddCell(cell);

            cell = new PdfPCell(new Phrase("TO", lightblue));
            //cell.Colspan = 3;  
            cell.Border = 0;
            cell.HorizontalAlignment = 0; //0=Left, 1=Centre, 2=Right
            tableLayout.AddCell(cell);
            //AddCellToBody1(tableLayout, "Bill TO", 1);
            AddCellToBody(tableLayout, "", 2);

            AddCellToBody1(tableLayout, "Sector-11, Vikas Nagar Lucknow", 1);
            AddCellToBody(tableLayout, "", 2);

            AddCellToBody1(tableLayout, "Lucknow - 226010.", 1);
            AddCellToBody(tableLayout, "", 2);

            ////Separater Line
            //DrawLine(writer, 25f, doc.Top - 179f, doc.PageSize.Width - 25f, doc.Top - 179f, color);
            //DrawLine(writer, 25f, doc.Top - 180f, doc.PageSize.Width - 25f, doc.Top - 180f, color);

            cell = new PdfPCell(new Phrase(""));
            cell.Colspan = 3;
            cell.Border = 1;
            cell.Padding = 1f;
            cell.BackgroundColor = BaseColor.GRAY;
            cell.HorizontalAlignment = 0; //0=Left, 1=Centre, 2=Right
            tableLayout.AddCell(cell);

            return tableLayout;
            #endregion
        }

        public static PdfPTable Add_Content_To_PDF(PdfPTable tableLayout)
        {
            try
            {
                PdfPCell cell = null;
                //float[] headers = { 20, 20, 30, 30 };  //Header Widths
                float[] headers = { 20, 20, 20, 20, 20 };//{ 16, 16, 16, 16, 16, 20 };
                tableLayout.SetWidths(headers);        //Set the pdf headers
                tableLayout.WidthPercentage = 100;       //Set the PDF File witdh percentage            

                //Add Title to the PDF file at the top
                tableLayout.AddCell(new PdfPCell(new Phrase("Bill Summary", new Font(Font.NORMAL, 8, 1, new iTextSharp.text.BaseColor(153, 51, 0)))) { Colspan = 5, Border = 0, PaddingBottom = 5, HorizontalAlignment = Element.ALIGN_LEFT });

                ////Add header
                //AddCellToHeader(tableLayout, "Cricketer Name");
                //AddCellToHeader(tableLayout, "Height");

                //Add header
                AddCellToHeader(tableLayout, "No. Of Label");
                AddCellToHeader(tableLayout, "Label Price");
                AddCellToHeader(tableLayout, "Net Amount");
                AddCellToHeader(tableLayout, "Tax(Service, Vat)");
                //AddCellToHeader(tableLayout, "Vat(" + Tax.ToString() + "%)");
                AddCellToHeader(tableLayout, "Grand Amount");

                //Add body
                AddCellToBody(tableLayout, No_Of_Labels.ToString());
                AddCellToBody(tableLayout, string.Format("{0:0.00}", LabelPrice));
                AddCellToBody(tableLayout, string.Format("{0:0.00}", Net_Amount));
                AddCellToBody(tableLayout, string.Format("{0:0.00}", Service_TaxValue));
                //AddCellToBody(tableLayout, Vat_TaxValue.ToString());
                AddCellToBody(tableLayout, string.Format("{0:0.00}", Grand_Amt));

                AddCellToBody2(tableLayout, "", 5);

                //AddCellToBody(tableLayout, "", 2);
                AddCellToBody2(tableLayout, "Net Amount", 4);
                AddCellToBody(tableLayout, string.Format("{0:0.00}", Grand_Amt));

                //AddCellToBody(tableLayout, "", 2);
                AddCellToBody2(tableLayout, "Advance Amount", 4);
                AddCellToBody(tableLayout, string.Format("{0:0.00}", Adnavce));

                //AddCellToBody(tableLayout, "", 2);
                AddCellToBody2(tableLayout, "Due Amount", 4);
                AddCellToBody(tableLayout, string.Format("{0:0.00}", Due_Amt));


                //AddCellToBody(tableLayout, "", 2);
                AddCellToBody2(tableLayout, "Total Amount", 4);
                AddCellToBody(tableLayout, string.Format("{0:0.00}", Total_Amount));

                AddCellToBody2(tableLayout, "", 5);

                cell = new PdfPCell(new Phrase(""));
                cell.Colspan = 5;
                cell.Border = 1;
                cell.Padding = 1f;
                cell.BackgroundColor = BaseColor.GRAY;
                cell.HorizontalAlignment = 0; //0=Left, 1=Centre, 2=Right
                tableLayout.AddCell(cell);
            }
            catch (Exception )
            {
                return tableLayout;
            }
            return tableLayout;
        }

        public static PdfPTable Add_Content_To_PDF1(PdfPTable tableLayout)
        {
            try
            {
                PdfPCell cell = null;
                //float[] headers = { 20, 20, 30, 30 };  //Header Widths
                float[] headers = { 50, 50 };
                tableLayout.SetWidths(headers);        //Set the pdf headers
                tableLayout.WidthPercentage = 100;       //Set the PDF File witdh percentage                

                //Add Title to the PDF file at the top
                tableLayout.AddCell(new PdfPCell(new Phrase("Label Details", new Font(Font.NORMAL, 8, 1, new iTextSharp.text.BaseColor(153, 51, 0)))) { Colspan = 2, Border = 0, PaddingBottom = 5, HorizontalAlignment = Element.ALIGN_LEFT });

                //Add header
                AddCellToBody2(tableLayout, "Price / Label");
                AddCellToBody2(tableLayout, string.Format("{0:0.00}", LabelPrice));

                AddCellToBody2(tableLayout, "Service Tax (" + Tax + "%)");
                AddCellToBody2(tableLayout, string.Format("{0:0.00}", TaxperLabel));

                AddCellToBody2(tableLayout, "VAT (" + Vat + "%)");
                AddCellToBody2(tableLayout, string.Format("{0:0.00}", Vat_PerLabel));

                AddCellToBody2(tableLayout, "Price / Label(inc.[Tax])", 1);
                AddCellToBody2(tableLayout, string.Format("{0:0.00}", LabelRateperLabel));

                //cell = new PdfPCell(new Phrase(""));
                //cell.Colspan = 2;
                //cell.Border = 1;
                //cell.Padding = 1f;
                //cell.BackgroundColor = BaseColor.GRAY;
                //cell.HorizontalAlignment = 0; //0=Left, 1=Centre, 2=Right
                //tableLayout.AddCell(cell);

            }
            catch (Exception )
            {
                return tableLayout;
            }
            return tableLayout;
        }

        // Method to add single cell to the header
        public static void AddCellToHeader(PdfPTable tableLayout, string cellText)
        {
            tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 7, 1, iTextSharp.text.BaseColor.WHITE))) { HorizontalAlignment = Element.ALIGN_CENTER, Padding = 5, BackgroundColor = new iTextSharp.text.BaseColor(0, 51, 102) });
        }

        // Method to add single cell to the body
        public static void AddCellToBody(PdfPTable tableLayout, string cellText)
        {
            tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 8, 1, iTextSharp.text.BaseColor.BLACK))) { HorizontalAlignment = Element.ALIGN_CENTER, Padding = 5, BackgroundColor = iTextSharp.text.BaseColor.WHITE });
        }

        // Method to add single cell to the body
        public static void AddCellToBody(PdfPTable tableLayout, string cellText, int Colspan)
        {
            tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 8, 1, iTextSharp.text.BaseColor.BLACK))) { Colspan = Colspan, Border = 0, HorizontalAlignment = Element.ALIGN_CENTER, Padding = 4, BackgroundColor = iTextSharp.text.BaseColor.WHITE });
            //tableLayout.AddCell(new PdfPCell(new Phrase("Label Bill", new Font(Font.NORMAL, 13, 1, new iTextSharp.text.BaseColor(153, 51, 0)))) { Colspan = Colspan, Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_CENTER });
        }

        // Method to add single cell to the body
        public static void AddCellToBody1(PdfPTable tableLayout, string cellText, int Colspan)
        {
            tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 8, 1, iTextSharp.text.BaseColor.BLACK))) { Colspan = Colspan, Border = 0, HorizontalAlignment = Element.ALIGN_LEFT, Padding = 4, BackgroundColor = iTextSharp.text.BaseColor.WHITE });
            //tableLayout.AddCell(new PdfPCell(new Phrase("Label Bill", new Font(Font.NORMAL, 13, 1, new iTextSharp.text.BaseColor(153, 51, 0)))) { Colspan = Colspan, Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_CENTER });
        }

        // Method to add single cell to the body
        public static void AddCellToBody2(PdfPTable tableLayout, string cellText, int Colspan)
        {
            tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 8, 1, iTextSharp.text.BaseColor.BLACK))) { Colspan = Colspan, Border = 0, HorizontalAlignment = Element.ALIGN_RIGHT, Padding = 4, BackgroundColor = iTextSharp.text.BaseColor.WHITE });
            //tableLayout.AddCell(new PdfPCell(new Phrase("Label Bill", new Font(Font.NORMAL, 13, 1, new iTextSharp.text.BaseColor(153, 51, 0)))) { Colspan = Colspan, Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_CENTER });
        }

        // Method to add single cell to the body
        public static void AddCellToBody2(PdfPTable tableLayout, string cellText)
        {
            tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 8, 1, iTextSharp.text.BaseColor.BLACK))) { HorizontalAlignment = Element.ALIGN_RIGHT, Padding = 4, BackgroundColor = iTextSharp.text.BaseColor.WHITE });
            //tableLayout.AddCell(new PdfPCell(new Phrase("Label Bill", new Font(Font.NORMAL, 13, 1, new iTextSharp.text.BaseColor(153, 51, 0)))) { Colspan = Colspan, Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_CENTER });
        }

        public static void FillData(Object9420 Reg)
        {
            #region Datat for reports
            Tax = Data9420.Data_9420.FindTax(); // Service Tax
            Vat = Data9420.Data_9420.FindVat(Reg);  //accoring to vat master which is enter according to area // Vat
            DataSet ds = new DataSet();
            SQL_DB.GetDA("SELECT Row_Id, Invoice_No, Comp_ID, Generate_Date, G_Amount, Tax, N_Amount, Pre_Bal, Trans_Type FROM M_Generate_Bill WHERE Invoice_No = '" + Reg.Invoice_No + "' ").Fill(ds, "1");
            SQL_DB.GetDA("SELECT Row_Id, Invoice_No, Pro_ID, Plan_ID, Qty, Rate, G_Amount, Amc_Offer_ID, Pre_Bal FROM T_Generate_Bill WHERE Invoice_No = '" + Reg.Invoice_No + "' ").Fill(ds, "2");
            LabelPrice = Math.Round((Convert.ToDouble(ds.Tables["2"].Rows[0]["Rate"].ToString())), 2);   // Per Label Price
            TaxperLabel = Math.Round(Convert.ToDouble((LabelPrice * Tax) / 100), 2);    // Service tax per Laabel                                                 
            No_Of_Labels = Math.Round((Convert.ToDouble(ds.Tables["2"].Rows[0]["Qty"].ToString())), 2);  // Total no of Labels
            Vat_PerLabel = Math.Round(((LabelPrice * Vat) / 100), 2);                      // Vat tax
            Vat_TaxValue = Math.Round((Vat_PerLabel * No_Of_Labels), 2);                                 // Vat Tax Value
            Service_Tax = Math.Round((TaxperLabel * No_Of_Labels), 2);                                    // Service tax 
            Service_TaxValue = Math.Round((Vat_TaxValue + Service_Tax), 2);                              // Service tax inc.(Tax_Vat)
            LabelRateperLabel = Math.Round((LabelPrice + TaxperLabel + Vat_PerLabel), 2);                // Per Label Net rate 
            Net_Amount = Math.Round((LabelPrice * No_Of_Labels), 2);                                     // Net Amount
            Grand_Amt = Math.Round((LabelRateperLabel * No_Of_Labels), 2);                               // Grand Amount                                   
            Due_Amt = Math.Round(Convert.ToDouble(Reg.Rec_Payment), 2);   // Due anount old pending ammount
            if (Due_Amt < 0)
            {
                Total_Amount = Math.Round(Math.Abs(Due_Amt - Grand_Amt), 2);                           // Total Amount
                Adnavce = 0.00;
                Due_Amt = Math.Round(Math.Abs(Due_Amt), 2);
            }
            else
            {
                Total_Amount = Math.Round(Grand_Amt, 2);                                               // Total Amount
                Adnavce = Math.Round(Due_Amt, 2);                                                      // Advance Amount
                Due_Amt = 0.00;
            }
            #endregion
        }

        //override the OnPageEnd event handler to add our footer
        public static void OnEndPage(PdfWriter writer, Document doc)
        {
            BaseColor lightblue = new BaseColor(43, 145, 175);//(128, 128, 128); Gray color Code
            Font footer = FontFactory.GetFont("Arial", 5f, Font.NORMAL, lightblue);

            //I use a PdfPtable with 2 columns to position my footer where I want it
            PdfPTable footerTbl = new PdfPTable(1);

            //set the width of the table to be the same as the document
            footerTbl.TotalWidth = doc.PageSize.Width;

            //Center the table on the page
            footerTbl.HorizontalAlignment = Element.ALIGN_CENTER;

            //Create a paragraph that contains the footer text
            Paragraph para = new Paragraph("Thanks for using VCQRU", footer);

            //// For Add new Line 
            ////add a carriage return
            //para.Add(Environment.NewLine);
            //para.Add("Thanks for using Label9420");

            //create a cell instance to hold the text
            PdfPCell cell = new PdfPCell(para);
            cell.HorizontalAlignment = 1;
            cell.Border = 0; //set cell border to 0
            cell.PaddingLeft = 10; //add some padding to bring away from the edge

            //add cell to table
            footerTbl.AddCell(cell);

            //write the rows out to the PDF output stream.
            footerTbl.WriteSelectedRows(0, -1, 0, (doc.BottomMargin + 10), writer.DirectContent);
        }


        private static void DrawLine(PdfWriter writer, float x1, float y1, float x2, float y2, BaseColor color)
        {
            PdfContentByte contentByte = writer.DirectContent;
            contentByte.SetColorStroke(color);
            contentByte.MoveTo(x1, y1);
            contentByte.LineTo(x2, y2);
            contentByte.Stroke();
        }

        private static PdfPCell PhraseCell(Phrase phrase, int align)
        {
            PdfPCell cell = new PdfPCell(phrase);
            cell.BorderColor = BaseColor.WHITE;
            cell.VerticalAlignment = PdfPCell.ALIGN_TOP;
            cell.HorizontalAlignment = align;
            cell.PaddingBottom = 2f;
            cell.PaddingTop = 0f;
            return cell;
        }

        private static PdfPCell ImageCell(string path, float scale, int align)
        {
            iTextSharp.text.Image image = iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath(path));
            image.ScalePercent(scale);
            PdfPCell cell = new PdfPCell(image);
            cell.BorderColor = BaseColor.WHITE;
            cell.VerticalAlignment = PdfPCell.ALIGN_TOP;
            cell.HorizontalAlignment = align;
            cell.PaddingBottom = 0f;
            cell.PaddingTop = 0f;
            return cell;
        }



        public static void CreateReceipt(Business9420.Object9420 Reg)
        {
            string InvoiceNo = Reg.Invoice_No;
            string pdfpath = Reg.FolderPath + "\\" + DataProvider.LocalDateTime.Now.ToString("dd-MM-yyyy");
            DataProvider.Utility.CreateDirectory(pdfpath);
            string imagepath = Reg.ImgFolderPath;
            FillData(Reg);
            //Create PDF Table
            PdfPTable tableLayout = new PdfPTable(5);
            PdfPTable tableLayout1 = new PdfPTable(2);
            PdfPTable tableLayout2 = new PdfPTable(3);
            PdfPTable tableLayout0 = new PdfPTable(2);
            PdfPTable tableLayouts = new PdfPTable(4);

            Document doc = new Document();
            try
            {
                string filename = string.Format("{0}.pdf", InvoiceNo);
                PdfWriter writer = PdfWriter.GetInstance(doc, new FileStream(pdfpath + "\\" + filename, FileMode.Create));
                doc.Open();

                ////doc.Add(new Paragraph("GIF"));
                //iTextSharp.text.Image gif = iTextSharp.text.Image.GetInstance(imagepath + "/logo.png");
                //gif.ScaleToFit(150f, 50f);
                //doc.Add(gif);

                float[] headers = { 80, 20 };
                tableLayout0.SetWidths(headers);        //Set the pdf headers
                tableLayout0.WidthPercentage = 100;       //Set the PDF File witdh percentage 

                // add a image
                iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(imagepath + "/logo.png");
                logo.ScaleToFit(150f, 50f);
                PdfPCell imageCell = new PdfPCell(logo);
                //imageCell.Colspan = 2; // either 1 if you need to insert one cell
                imageCell.Border = 0;
                imageCell.HorizontalAlignment = 0; //0=Left, 1=Centre, 2=Right


                // add a image
                tableLayout0.AddCell(imageCell);

                Font lightblue = new Font(Font.FontFamily.TIMES_ROMAN, 22f, Font.NORMAL, new BaseColor(43, 145, 175));
                PdfPCell cell = new PdfPCell(new Phrase("PAYMENT RECEIPT", lightblue));
                //cell.Colspan = 3;
                cell.Border = 0;
                //cell.Padding = 1f;
                //cell.BackgroundColor = BaseColor.GRAY;
                cell.HorizontalAlignment = 1; //0=Left, 1=Centre, 2=Right
                tableLayout0.AddCell(cell);

                doc.Add(tableLayout0);

                //Add Content to PDF
                doc.Add(Content_To_PDF(writer, doc, tableLayout2, Reg));

                //Add Content to PDF
                doc.Add(Add_Content_To_PDF1(tableLayout1));

                //Add Content to PDF
                doc.Add(Add_Content_To_PDF(tableLayout));

                // Add text in footer
                //Font lightblue1 = new Font(Font.FontFamily.TIMES_ROMAN, 14f, Font.NORMAL, new BaseColor(43, 145, 175));
                //Paragraph p = new Paragraph("Thanks for using Label9420", lightblue1);
                //p.Alignment = 1;
                //doc.Add(p);
                OnEndPage(writer, doc);

                // Add WaterTextMark in pdf                

                ////PdfWriter pdfWriter = PdfWriter.GetInstance(pdfDoc, msReport);
                //writer.PageEvent = new PdfWriterEvents("Label9420.com");
                //PdfWriterEvents.OnStartPage(writer, doc);

                // Closing the document
                doc.Close();
            }
            catch (Exception )
            {
                //Log error;
            }
            finally
            {
                doc.Close();
            }
        }




    }

    public enum TransType
    {
        Label,
        AMC,
        Offer,
        New_Amc,
        New_Offer,
        Date_Extention_By_Manufacturer,
        Date_Extention_By_Admin,
        Upgrade,
        Renewal,
        Given_Grace_Period,
        Cancelled,
        Date_Extention,
        Offer_Cancelled_By_Manufacturer,
        Offer_Cancelled_By_Manufacturer_Beacause_This_Offer_Beyond_To_My_AMC_Plan
    }

    public static class LogManager
    {
        public static void WriteExe(string txt)
        {
            //string filein = HttpContext.Current.Server.MapPath("");
            try
            {
                //string filein = "G:\\Alfha\\Label\\cvqur.com\\";
                string filein = HttpContext.Current.Server.MapPath("~/");
                SQL_DB.ExecuteNonQuery("INSERT INTO [Test] ([Remak]) VALUES  ('" + Convert.ToDateTime(System.DateTime.Now).ToString("dd-MM-yyyy hh:mm:ss tt") + txt + "')");
                //System.IO.File.AppendAllText(@"C:\inetpub\wwwroot\label9420\LogManger\LogManger.txt", " \r\n " + System.DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt") + " : " + txt + " \r\n");
                string path = filein + "\\LogManager\\LogManger.txt";
                System.IO.File.AppendAllText(path, " \r\n " + System.DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt") + " : " + txt + " \r\n");
            }
            catch (Exception ex)
            {

                throw ex;
            }
            
        }
        public static void WriteCourierDispatch(string txt)
        {
            //string filein = HttpContext.Current.Server.MapPath("");
            try
            {
                //string filein = "G:\\Alfha\\Label\\cvqur.com\\";
                string filein = HttpContext.Current.Server.MapPath("~/");
                //  SQL_DB.ExecuteNonQuery("INSERT INTO [Test] ([Remak]) VALUES  ('" + Convert.ToDateTime(System.DateTime.Now).ToString("dd-MM-yyyy hh:mm:ss tt") + txt + "')");
                //System.IO.File.AppendAllText(@"C:\inetpub\wwwroot\label9420\LogManger\LogManger.txt", " \r\n " + System.DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt") + " : " + txt + " \r\n");
                string path = filein + "\\LogManager\\Dispatch.txt";
                System.IO.File.AppendAllText(path, " \r\n " + System.DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt") + " : " + txt + " \r\n");
            }
            catch (Exception )
            {

                //throw ex;
            }

        }
        public static void ErrorExceptionLog(string txt)
        {
            //string filein = HttpContext.Current.Server.MapPath("");
            try
            {
                //string filein = "G:\\Alfha\\Label\\cvqur.com\\";
                string filein = HttpContext.Current.Server.MapPath("~/");
                //  SQL_DB.ExecuteNonQuery("INSERT INTO [Test] ([Remak]) VALUES  ('" + Convert.ToDateTime(System.DateTime.Now).ToString("dd-MM-yyyy hh:mm:ss tt") + txt + "')");
                //System.IO.File.AppendAllText(@"C:\inetpub\wwwroot\label9420\LogManger\LogManger.txt", " \r\n " + System.DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt") + " : " + txt + " \r\n");
              //** Commented by Deep Shukla for generating new logs file every day **//
  //string path = filein + "\\LogManager\\Ecom.txt";

string filename = "Ecom_" + DataProvider.LocalDateTime.Now.ToString("yyyy-MM-dd") + ".txt";
                string path = filein + "\\LogManager\\"+ filename ;
                System.IO.File.AppendAllText(path, " \r\n " + System.Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")) + " : " + txt + " \r\n");
            }
            catch (Exception)
            {

                //throw ex;
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
    }

}