using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Employee_Employee : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
Page.Header.DataBind();
        if (!Page.IsCallback)
        {
            if (Session["User_Type"].ToString() == "Consumer")
            {
                lblloginName.Text = ProjectSession.strConsumerName;
            }
            else if (Session["User_Type"].ToString() == "Company")
            {
                lblloginName.Text = ProjectSession.strCompanyName;
            }
            else if (Session["User_Type"].ToString() == "Employee")
            {
                lblloginName.Text = "Welcome,&nbsp;&nbsp;&nbsp;" + ProjectSession.strEmployeeName;
            }
        }
    }

    protected void imglogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/default.aspx#logsign");
    }
}
