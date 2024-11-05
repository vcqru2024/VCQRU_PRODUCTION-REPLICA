using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class balaji : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Pub_Code"] == "shribalaji")
        {
            HdnID.Value = Request.QueryString["Pub_Code"];
            HdnCode1.Value = Request.QueryString["codeone"];
            HdnCode2.Value = Request.QueryString["codetwo"];

        }
    }
}