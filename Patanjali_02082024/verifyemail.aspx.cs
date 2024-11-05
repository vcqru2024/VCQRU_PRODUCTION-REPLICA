using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Patanjali_verifyemail : System.Web.UI.Page
{
    cls_patanjali db = new cls_patanjali();
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect("../patanjali/loginpfl.aspx");
        //if (!IsPostBack)
        //{
        //    if (!string.IsNullOrEmpty(Request.QueryString["verified_Email_Id_User_Id_email"]))
        //    {
        //        string verifiedValue = Request.QueryString["verified_Email_Id_User_Id_email"];
        //        DataTable dt = db.UpdateEmailFLG("USP_UpdateEmailflg", verifiedValue, "U");
        //        SQL_DB.ExecuteNonQuery("update tbl_pflUsers set Is_Emailverify =1 where UserEmail='" + verifiedValue + "' and IsActive=0 and IsDelete=0");
        //        Response.Redirect("../Patanjali/loginpfl.aspx?From=verifyemail");
        //    }
        //    else
        //    {
        //        Response.Redirect("https://uat.vcqru.com/");
        //    }
        //}
    }

    public static bool IsValidEmail(string email)
    {
        string pattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
        return Regex.IsMatch(email, pattern);
    }
}