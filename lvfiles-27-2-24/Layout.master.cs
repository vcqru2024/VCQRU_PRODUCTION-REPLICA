using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Layout : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {


string currentPageName = Request.Url.Segments[Request.Url.Segments.Length - 1];
        if (currentPageName == "Default.aspx") ;
            //divnikolt.Visible = true;

    }
}
