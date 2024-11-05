using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_PointsDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=PointsDetails.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/info/Login.aspx");
        }
    }
}