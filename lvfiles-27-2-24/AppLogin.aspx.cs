using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AppLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["Login"] = "1";

        Session["AppID"] = "1";

        if (!string.IsNullOrEmpty(Request.QueryString["AppID"]))
            Session["AppID"] = Request.QueryString["AppID"].ToString();

    }
}