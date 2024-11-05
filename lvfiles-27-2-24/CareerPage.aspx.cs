using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class CareerPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        //string cmobile = "";
        string jobType = jobtype.Value;
        string name = cname.Value;
        string email = cemail.Value;
        string mobile = cmobile.Value;
        resumefile.SaveAs(Server.MapPath("./assets/images/resume/") + Path.GetFileName(resumefile.FileName));
        string imgpath = Path.GetFileName(resumefile.FileName);
        //resumefile.SaveAs(Server.MapPath("/assets/images/resume/") + Path.GetFileName(resumefile.FileName));
        string url = ProjectSession.absoluteSiteBrowseUrl + "Info/MasterHandler.ashx?method=sendqueryOpenings&name=" + name + "&email=" + email + "&cmobile=" + mobile + "&resumePath=" + imgpath + "&jobType=" + jobType;
        Response.Redirect(url);

    }
}