using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    

    protected void Page_Load(object sender, EventArgs e)
    {
        string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
     string blogid =   Request.QueryString["blog"];
        if (currentPage.ToString() == "blog-details.aspx")
        {
            if (blogid == "17")
            {
                Response.Redirect("Strategies_blog.aspx");
            }else if (blogid == "13")
            {
                Response.Redirect("warrenty_blog.aspx");
            }
            else if (blogid == "19")
            {
                Response.Redirect("Brand_loyalty.aspx");
            }
            else if (blogid == "18")
            {
                Response.Redirect("digital_marketing_blog.aspx");
            }
            else if (blogid == "16")
            {
                Response.Redirect("Customer_Retention.aspx");
            }


        }
           

    }

}