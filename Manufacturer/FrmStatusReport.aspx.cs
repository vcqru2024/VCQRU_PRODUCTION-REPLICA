using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business9420;
using System.IO;
using System.Web.Services;
using System.Web.Script.Services;
using Data9420;
using System.Configuration;

public partial class FrmStatusReport : System.Web.UI.Page
{    
    public int index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../Info/Login.aspx?Page=FrmStatusReport.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!Page.IsPostBack)
        {
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            filldata(); 
            NewMsgpop.Visible = false;
        }
    }
    protected void ImgSearch_Click(object sender,EventArgs e)
    {

    }
    protected void ImgRefresh_Click(object sender, EventArgs e)
    {

    }
    private void filldata()
    {
        Object9420 obj = new Object9420();
        obj.Comp_ID = Session["CompanyId"].ToString();
        if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 50)
            obj.Norec = 0;
        else
            obj.Norec = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        DataSet ds = function9420.FillLoginSummary(obj);
        if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 50)
        {
            if (ds.Tables[0].Rows.Count > 0)
                GrdLoginSummary.PageSize = ds.Tables[0].Rows.Count;
        }
        else
            GrdLoginSummary.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        if (ds.Tables[0].Rows.Count > 0)
            GrdLoginSummary.DataSource = ds.Tables[0];
        GrdLoginSummary.DataBind();
        lblcount.Text = GrdLoginSummary.Rows.Count.ToString();
        if (GrdLoginSummary.Rows.Count > 0)
            GrdLoginSummary.HeaderRow.TableSection = TableRowSection.TableHeader;

    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        filldata();
    }
    protected void GrdLoginSummary_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }
    public DateTime FindDateFormate(DateTime Dt)
    {
        DateTime d = new DateTime();
        d = Convert.ToDateTime(Convert.ToDateTime(Dt).ToString("MMM/dd/yyyy"));
        return d;
    }
}