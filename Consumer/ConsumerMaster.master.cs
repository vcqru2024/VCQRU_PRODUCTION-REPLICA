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

public partial class Consumer_ConsumerMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {Page.Header.DataBind();
        if (Session["User_Type"] != null)
        {
            if (Session["User_Type"].ToString() == "Admin")
                lblloginName.Text = "Admin";
            else
            {
                if (ProjectSession.strUser_Type == "Consumer")//(Session["User_Type"].ToString() == "Consumer")
                {
                    if (Session["USRNAME"] == null)
                    {
                        lblloginName.Text = ProjectSession.strMobileNo;//.Replace("91",""); //Session["USRMOBILENO"].ToString();
                        lblloginMobileNumber.Text = ProjectSession.strMobileNo;
                    }
                    else
                    {
                        lblloginMobileNumber.Text = Session["strMobileNo"].ToString().Replace("91", "");
                        lblloginName.Text = Session["USRNAME"].ToString();//Session["strMobileNo"].ToString();
                    }
                }
                else
                    lblloginName.Text = ProjectSession.strUser_Type;// Session["User_Type"].ToString();
            }
        }
        else
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/default.aspx#logsign");
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
        Session.Abandon();
        //Response.Redirect("../Home/Index.aspx");
        //Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/default.aspx#logsign");
        Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/index.html");
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

    protected void imglogout_Click1(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/index.html");

    }
}
