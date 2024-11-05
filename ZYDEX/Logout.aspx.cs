using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ZYDEX_Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("~/ZYDEX/Login.aspx");
        clearsession();
    }
    public void clearsession()
    {
        Session.Abandon();
        Session.Clear();
        Response.Redirect("~/ZYDEX/Login.aspx");
    }
}