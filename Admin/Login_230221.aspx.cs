using Business9420;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (txtVerificationCode.Text.ToLower() == Session["CaptchaVerify"].ToString())
        {
            Object9420 Log = new Business9420.Object9420();
            if (txtusername.Text.ToUpper() == "ADMIN")
            {
                Log.User_Type = txtusername.Text.Trim().Replace("'", "''");
                Log.User_ID = txtusername.Text.Trim().Replace("'", "''");
                Log.Password = txtpassword.Text.Trim().Replace("'", "''");
                Log.Dial_Mode = GetIP();
                if (Business9420.function9420.FetchDataForAdminLogin(Log))
                {
                    Session["User_Type"] = "Admin";
                    ProjectSession.strUser_Type = "Admin";
                    if (Session["User_Type"] != null && Request.QueryString["Page"] == null)
                    {
                        SQL_DB.ExecuteNonQuery("INSERT INTO [Login_History](Dial_Mode,User_ID,Login_Date,User_Type) VALUES ('" + Log.Dial_Mode + "','" + Session["User_Type"].ToString() + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' ,1)");
                        Response.Redirect("Dashboard.aspx");  //Response.Redirect("CodeGeneration.aspx");
                    }
                    else if (Session["User_Type"] != null && Request.QueryString["Page"] != null)
                    {
                        SQL_DB.ExecuteNonQuery("INSERT INTO [Login_History](Dial_Mode,User_ID,Login_Date,User_Type) VALUES ('" + Log.Dial_Mode + "','" + Session["User_Type"].ToString() + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' ,1)");
                        Response.Redirect(Request.QueryString["Page"].ToString());
                    }
                }
            }
            else
            {
                txtusername.Text = "";
                txtpassword.Text = "";
                txtusername.Focus();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "toastr_message", "toastr.error('Invalid user id or password !', 'Error')", true);
            }
        }
        else
        {
            lblCaptchaMessage.Text = "Please enter correct captcha !";
            lblCaptchaMessage.ForeColor = System.Drawing.Color.Red;
        }
    }

    private string GetIP()
    {
        string Ipaddress;
        Ipaddress = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (Ipaddress == "" || Ipaddress == null)
        {
            Ipaddress = Request.ServerVariables["REMOTE_ADDR"];
        }
        return Ipaddress;
    }
}