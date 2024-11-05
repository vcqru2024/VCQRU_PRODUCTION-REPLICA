using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string Codes = Request.QueryString["codeone"];

        if (Codes != "" && Codes != null)
        {
            string codeone = Request.QueryString["codeone"];
            string[] CodeList = codeone.Split('-');
            HdnID.Value = "Patanjli";
            HdnCode1.Value = CodeList[0].ToString();
            HdnCode2.Value = CodeList[1].ToString();
            CompName.Value = "PATANJALI";
        }
    }
}