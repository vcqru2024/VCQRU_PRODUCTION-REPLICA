using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AmrutanjanSuccess : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hfproductId.Value = Request.QueryString["Id"];
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string id = Request.QueryString["Id"];
        string url = ConfigurationManager.AppSettings[id];
        if (url != null || url != "")
            Response.Redirect(url);
    }
}