using Business9420;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;



public class cls_teslaemailtemplate
{
    public static string srt = DataProvider.Utility.FindMailBody();
    public string SendMailbydata(string Mailbody,string Reciveremail, string carboncopy,string Subject)
    {
        string subject = Subject;
        string MailBody = string.Empty;
        MailBody = srt + Mailbody;
        DataSet dsMl = function9420.FetchMailDetail("support");
        if (dsMl.Tables[0].Rows.Count > 0)
        {
            DataProvider.Utility.SendMailnew(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reciveremail, MailBody, subject);
            DataProvider.Utility.SendMailnew(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), carboncopy, MailBody, subject);
        }
        return "Email Send Successfully.";
    }
    public void Registationemail(string MobileNO, string Reciveremail, string carboncopy)
    {
        string Mailbody = @"<div style='padding:20px; font-family: Arial, sans-serif; color: #333;'>
                    <div style='text-align: center; margin-bottom: 20px;'>
                        <img src='https://teslapowerusa.com/assets/images/TeslaPowerUSA-20-02-21.png' alt='logo' style='max-width: 150px;' />
                    </div>
                    <hr style='border:1px solid #2587D5; margin-bottom: 20px;'/>
                    <div style='padding: 20px; background-color: #f9f9f9; border-radius: 10px;'>
                        <p style='font-size: 16px;'>
                            Dear Tesla Team,<br /><br />
                            A new user with mobile number <strong>'" + MobileNO + @"'</strong> has been registered. Kindly review the KYC of the registered user and take the needful actions accordingly.<br /><br />
                            Thank you.<br /><br />
                            Best regards,<br />
                            VCQRU
                        </p>
                    </div>
                </div>";
        string Subject = "New User Registration - KYC Review Required";
        SendMailbydata(Mailbody, Reciveremail, carboncopy, Subject);
    }
    public void ApprovedKYC(string username, string Reciveremail, string carboncopy)
    {
        string Mailbody = @"<div style='padding:20px; font-family: Arial, sans-serif; color: #333;'>
                    <div style='text-align: center; margin-bottom: 20px;'>
                        <img src='https://teslapowerusa.com/assets/images/TeslaPowerUSA-20-02-21.png' alt='logo' style='max-width: 150px;' />
                    </div>
                    <hr style='border:1px solid #2587D5; margin-bottom: 20px;'/>
                    <div style='padding: 20px; background-color: #f9f9f9; border-radius: 10px;'>
                        <p style='font-size: 16px;'>
                            Dear '"+ username + @"',<br /><br />
                            Your KYC has been approved. Keep verifying more codes to earn more benefits.<br /><br />
                            Thank you.<br /><br />
                            Best regards,<br />
                            Tesla management team
                        </p>
                    </div>
                </div>";
        string Subject = "KYC Verified";
        SendMailbydata(Mailbody, Reciveremail, carboncopy, Subject);
    }
    public void RejectedKYC(string username, string Reciveremail, string carboncopy)
    {
        string Mailbody = @"<div style='padding:20px; font-family: Arial, sans-serif; color: #333;'>
                    <div style='text-align: center; margin-bottom: 20px;'>
                        <img src='https://teslapowerusa.com/assets/images/TeslaPowerUSA-20-02-21.png' alt='logo' style='max-width: 150px;' />
                    </div>
                    <hr style='border:1px solid #2587D5; margin-bottom: 20px;'/>
                    <div style='padding: 20px; background-color: #f9f9f9; border-radius: 10px;'>
                        <p style='font-size: 16px;'>
                            Dear '" + username + @"',<br /><br />
                            Your KYC has been rejected. Kindly contact to support team at +917353000903.<br /><br />
                            Thank you.<br /><br />
                            Best regards,<br />
                            Tesla management team
                        </p>
                    </div>
                </div>";
        string Subject = "KYC Verified";
        SendMailbydata(Mailbody, Reciveremail, carboncopy, Subject);
    }
}