using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ZYDEX_Login : System.Web.UI.Page
{
    cls_Zydex zx = new cls_Zydex();
    protected void Page_Load(object sender, EventArgs e)
    {

    }



    protected void btnlogin_Click(object sender, EventArgs e)
    {
        string UserId = txtusername.Text.Trim();
        string Password = txtpassword.Text.Trim();
        if (string.IsNullOrEmpty(UserId))
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "loginFailed", "showAlert('Error', 'Please Enter UserId', 'error');", true);
        }
        else if (string.IsNullOrEmpty(Password))
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "loginFailed", "showAlert('Error', 'Please Enter Password', 'error');", true);
        }
        else
        {
            string encpassword = string.Empty;
            if (Password.Length > 5)
            {
                encpassword = zx.Encrypt(Password);
            }
            else
            {
                encpassword = Password;
            }
            DataTable dtlogin = SQL_DB.ExecuteDataTable("exec USP_Loginvendorzydex '" + UserId + "','" + encpassword + "'");
            if (dtlogin.Rows[0][0].ToString()=="Invalid UserId or Password")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "loginFailed", "showAlert('Error', 'Invalid UserId or Password', 'error');", true);
            }
            else
            {
                HttpContext.Current.Session["CompanyId"] = dtlogin.Rows[0]["Comp_ID"].ToString();
                HttpContext.Current.Session["Comp_Email"] = dtlogin.Rows[0]["Comp_Email"].ToString();
                HttpContext.Current.Session["Comp_Name"] = dtlogin.Rows[0]["Comp_Name"].ToString();
                Response.Redirect("~/ZYDEX/dashboardzydex.aspx");
            }
        }
    }

}