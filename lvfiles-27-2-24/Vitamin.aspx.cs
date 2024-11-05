using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Thevitaminco : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("https://thevitamin.co/pages/authenticate"));
        if (Request.QueryString["ID"] == "1")
        {
            HdnID.Value = Request.QueryString["ID"];
        }

        else if (Request.QueryString["ID"] == "Vitamin")
        {
            HdnID.Value = Request.QueryString["ID"];
            HdnCode1.Value = Request.QueryString["codeone"];
            HdnCode2.Value = Request.QueryString["codetwo"];
            CompName.Value = Request.QueryString["Comp"];
        }
    }
}