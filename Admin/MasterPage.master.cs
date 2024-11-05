using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Net;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
Page.Header.DataBind();
        if (Session["User_Type"] != null)
        {
            Auth.Oncheck();
            if (Session["User_Type"].ToString() == "Admin")
                lblloginName.Text = "Admin";
            else
            {
                if (Session["User_Type"].ToString() != "Customer Care")
                    lblloginName.Text = ProjectSession.strCompanyName;
                // lblloginName.Text = SQL_DB.ExecuteScalar("SELECT [Comp_Name] FROM [Comp_Reg] where [Comp_ID] = '" + Session["CompanyId"].ToString() + "'").ToString();
                else
                    lblloginName.Text = Session["User_Type"].ToString();
            }

            
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
    protected void imglogout_Click(object sender, ImageClickEventArgs e)
    {
        string IP = GetIP();
        if (Session["User_Type"].ToString() == "Admin")
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Login_History] SET [Logout_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE CONVERT(VARCHAR,Login_Date,111)= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' AND User_ID = '" + Session["User_Type"].ToString() + "'  AND user_Type = 1 AND (Dial_Mode = '" + IP + "')  AND Row_ID = (SELECT MAX(Row_ID) FROM  Login_History WHERE  User_ID = '" + Session["User_Type"].ToString() + "'  AND (Dial_Mode = '" + IP + "') ) ");
            Session.Abandon();
            Response.Redirect("../Admin/Login.aspx");
        }
        else
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Login_History] SET [Logout_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE CONVERT(VARCHAR,Login_Date,111)= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' AND User_ID = '" + Session["CompanyId"].ToString() + "'  AND user_Type = 0 AND (Dial_Mode = '" + IP + "')  AND Row_ID = (SELECT MAX(Row_ID) FROM  Login_History WHERE  User_ID = '" + Session["CompanyId"].ToString() + "'  AND (Dial_Mode = '" + IP + "') ) ");
            Session.Abandon();
            //Response.Redirect("../default.aspx");
           Response.Redirect("../info/login.aspx");// changed by shweta
        }
    }
    private string GetIP()
    {
        string Ipaddress;
        Ipaddress = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (Ipaddress == "" || Ipaddress == null)
        {
            Ipaddress = Request.ServerVariables["REMOTE_ADDR"];
            //Response.Write(ipaddress);
        }
        //string activity;
        //string controlpage = Request["__EVENTARGUMENT"];
        //IPHostEntry host;
        //string localIP = "?";
        //host = Dns.GetHostEntry(Dns.GetHostName());
        //foreach (IPAddress ip in host.AddressList)
        //{
        //    if (ip.AddressFamily.ToString() == "InterNetwork")
        //    {
        //        localIP = ip.ToString();
        //    }
        //}
        //if (controlpage == null)
        //{
        //    activity = "Open Page";
        //}
        //else
        //{
        //    activity = controlpage.ToString();
        //}
        //string Ipaddress = localIP.ToString();
        return Ipaddress;
    }
}
