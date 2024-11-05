using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_newuser : System.Web.UI.Page
{
    cls_patanjali db = new cls_patanjali();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session.IsNewSession)
        {
           
            string sessionCookie = Request.Headers["Cookie"];
            if ((sessionCookie != null) && (sessionCookie.IndexOf("ASP.NET_SessionId") >= 0))
            {
                Response.Redirect("../Patanjali/Loginpfl.aspx");
            }
        }
        if (Session["Comp_ID"] == null)
            Response.Redirect("../Patanjali/Loginpfl.aspx");
        if (!IsPostBack)
        {
            if (Request.QueryString["msg"] != null)
            {
                if (Request.QueryString["msg"] == "Success")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Success", "showAlert('Success', 'Registered Successfully', 'success');", true);
                }
            }

            #region User Log 
            if (Session["UserName"] != null)
            {
                db.ExceptionLogs("Visited on Users", Session["UserName"].ToString(), "R");
            }
            else
            {
                db.ExceptionLogs("Visited on Users", Session["Comp_Name"].ToString(), "R");
            }
            #endregion
            bindUser();
        }


    }

   

    public void bindUser()
    {
        DataTable dt = db.GetRegisteredUserData("USP_PFLGETUserROLEData", 0);
        gvNewUser.DataSource = dt;
        gvNewUser.DataBind();
    }

    [WebMethod]
    public static string ToggleUserStatus(string userId)
    {
        return "User status toggled successfully.";
    }

    [WebMethod]
    public  string DeleteUser(string userId)
    {
        string Result = string.Empty;
        int UserRoleID = Convert.ToInt32(userId);
        DataTable dt = db.GetRegisteredUserData("USP_PFLDELETEUserROLEData", UserRoleID);
        if(Convert.ToInt32(dt.Rows[0][0]) == 1)
        {
            Result = "User Deleted Successfully";
        }
        else
        {
            Result = "Can't Delete User";
        }
        return Result;
    }
   




    protected void btndownload_Click(object sender, EventArgs e)
    {

    }
}