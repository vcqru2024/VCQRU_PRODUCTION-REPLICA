using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Business9420;
using System.Data;

public partial class Admin_BigDataAnalysis : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        
        
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=BigDataAnalysis.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/info/Login.aspx");
        }
        //if (!Page.IsPostBack)
        //{
        //    if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
        //        Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
        //    txtTestimonial.Text = string.Empty;
        //    FillData();
        //}
    }
   
}