using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

public partial class Media_Gallery : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
        string blogid = Request.QueryString["idd"];
        if (currentPage.ToString() == "Media-Gallery.aspx")
        {
            if (blogid == "12")
            {
                Response.Redirect("gallery.aspx");
            }
        }
            Response.Redirect("gallery.aspx");
    }

}