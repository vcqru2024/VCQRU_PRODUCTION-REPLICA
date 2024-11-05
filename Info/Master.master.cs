using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using System.Web.Services;
using System.Web.Script.Services;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using Business9420;
using System.Net;
using System.Text.RegularExpressions;
using Business_Logic_Layer;
using DataProvider;

public partial class Master : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
Page.Header.DataBind();
        if (HttpContext.Current.Request.Url.AbsoluteUri.ToLower().Contains("login.aspx"))
        {

        }
        else
        {
            Auth.Oncheck();
            //if (HttpContext.Current.Session["User_Type"].ToString().ToLower() == "admin" && HttpContext.Current.Request.Url.AbsoluteUri.ToLower().Contains("admin") ||
            //    HttpContext.Current.Session["User_Type"].ToString().ToLower() == "company" && (HttpContext.Current.Request.Url.AbsoluteUri.ToLower().Contains("manufacturer") || HttpContext.Current.Request.Url.AbsoluteUri.ToLower().Contains("info")))
            //{

            //}
            //else
            //{
            //    if (HttpContext.Current.Session["User_Type"].ToString().ToLower() == "admin")
            //    {
            //        HttpContext.Current.Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "admin/login.aspx");
            //    }
            //    else if (HttpContext.Current.Session["User_Type"].ToString().ToLower() == "company")
            //        HttpContext.Current.Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "info/login.aspx");
            //}
        }
        if (!Page.IsPostBack)
        {
            

            if (Session["User_Type"] != null)
            {
                lnklosign.Visible = false;
                lblloginName1.Visible = true;
                imglogout.Visible = true;
                if (Session["User_Type"].ToString() == "Consumer")
                {
                    lblloginName1.Text = ProjectSession.strConsumerName;
                }
                else if (Session["User_Type"].ToString() == "Company")
                {
                    lblloginName1.Text = ProjectSession.strCompanyName;
                }
                else if (Session["User_Type"].ToString() == "Employee")
                {
                    lblloginName1.Text = "Welcome,&nbsp;&nbsp;&nbsp;" + ProjectSession.strEmployeeName;
                }
            }

        }
        // Random rng = new Random();
        //g.
        //// Assume there'd be more logic here really
        //int str1 = rng.Next(10);
        //Random rng2 = new Random();
        //// Assume there'd be more logic here really
        //int str2 = rng2.Next(10);
        //Random rng3 = new Random();
        //// Assume there'd be more logic here really
        //int str3 = rng3.Next(10);
        //Random rng4 = new Random();
        //// Assume there'd be more logic here really
        //int str4 = rng4.Next(10);
        //Random rng5 = new Random();
        //// Assume there'd be more logic here really
        //int str5 = rng5.Next(10);
    }
    protected void imglogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        //Response.Redirect("../Home/Index.aspx");
        Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/default.aspx");
    }

    protected void lblloginName_Click(object sender, EventArgs e)
    {
        if (Session["User_Type"] != null)
        {
            if (Session["User_Type"].ToString() == "Consumer")
            {
                Response.Redirect("~/Consumer/UpdateProfile.aspx");
            }
            else if (Session["User_Type"].ToString() == "Company")
            {
                Response.Redirect("~/Manufacturer/CompProfile.aspx");
            }
            else if (Session["User_Type"].ToString() == "Employee")
            {
                Response.Redirect("~/Employee/UpdateProfile.aspx");
            }
        }
        else
        {
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/default.aspx");
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/default.aspx#logsign");
    }
}

