using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControl_Footer : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Label l1 = (Label)this.Page.Master.FindControl("ContentPlaceHolder1").FindControl("lblMsg1");
        if (l1 != null)
        {
            if (Session["lblMsg1"] != null)
                l1.Text = Convert.ToString(Session["lblMsg1"]);
        }
    }
}