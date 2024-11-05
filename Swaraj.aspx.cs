using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class swaraj : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["ID"] == "1")
        {
            HdnID.Value = Request.QueryString["ID"];
        }

        else if (Request.QueryString["ID"] == "SWARAJ")
        {
            HdnID.Value = Request.QueryString["ID"];
            HdnCode1.Value = Request.QueryString["codeone"];
            HdnCode2.Value = Request.QueryString["codetwo"];
            CompName.Value = Request.QueryString["Comp"];

            //string code = Request.QueryString["codeone"].ToString() + Request.QueryString["codetwo"].ToString();
            //codeonee.Value = Request.QueryString["codeone"].ToString() + Request.QueryString["codetwo"].ToString();


           
        }
    }
}