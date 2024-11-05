using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_NewAdminMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
Page.Header.DataBind();
        if (HttpContext.Current.Request.Url.AbsoluteUri.ToLower().Contains("login.aspx"))
        {

        }
        else
        {
            Auth.Oncheck();
        }
         
        //if (Session["User_Type"] == null)
        //    Response.Redirect("login.aspx?Page=Dashboard.aspx");
        //if (Session["User_Type"] == "Admin")
        //    lblloginName.Text = "Admin";
        //else if (Session["User_Type"] == "Company")
        //    lblloginName.Text = SQL_DB.ExecuteScalar("SELECT [Comp_Name] FROM [Comp_Reg] where [Comp_ID] = '" + Session["CompanyId"].ToString() + "'").ToString();
    }
}
