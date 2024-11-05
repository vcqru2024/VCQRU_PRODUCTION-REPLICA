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

public partial class FrmPendingDispatchLabel : System.Web.UI.Page
{
    public string server = Convert.ToString(ConfigurationManager.ConnectionStrings["ServerName"].ConnectionString), userID = Convert.ToString(ConfigurationManager.ConnectionStrings["UserName"].ConnectionString), password = Convert.ToString(ConfigurationManager.ConnectionStrings["Password"].ConnectionString);
    public int pflag= 0,index = 0;
    public string srt = DataProvider.Utility.FindMailBody();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../Info/Login.aspx?Page=FrmPendingDispatchLabel.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }          
        if (!Page.IsPostBack)
        {            
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));            
            FillData();
            FillddlSearch();
        }
    }    
    private void FillddlSearch()
    {
        Object9420 obj = new Object9420();
        obj.Comp_ID = Session["CompanyId"].ToString();
        DataSet ds = function9420.FetchRequestProductList(obj);
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProSearch, "--Select--");
        ddlProSearch.SelectedIndex = 0;
    }                   
    private void FillData()
    {        
        Object9420 obj = new Object9420();
        obj.Comp_ID = Session["CompanyId"].ToString();
        obj.Tracking_No = txttrachingno.Text.Trim().Replace("'", "''");
        if (ddlProSearch.SelectedIndex > 0)
            obj.Pro_ID = ddlProSearch.SelectedValue.Trim();              
        DataSet ds = function9420.DispatchLabelsStatus(obj);
        DataView dv = ds.Tables[0].DefaultView;
        dv.RowFilter = " PendingDispatchCode <> 0 ";
        DataTable dt = dv.ToTable();
        if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        {
            if (dt.Rows.Count > 0)
                GrdVwLabelRequest.PageSize = dt.Rows.Count;
        }
        else
            GrdVwLabelRequest.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        if (dt.Rows.Count > 0)
            GrdVwLabelRequest.DataSource = dt;
        GrdVwLabelRequest.DataBind();
        lblcount.Text = GrdVwLabelRequest.Rows.Count.ToString();
        if (GrdVwLabelRequest.Rows.Count > 0)
            GrdVwLabelRequest.HeaderRow.TableSection = TableRowSection.TableHeader;

    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {        
        txttrachingno.Text = string.Empty;
        ddlProSearch.SelectedIndex = 0;
        FillData();
    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        //DivNewMsg.Visible = false; 
        NewMsgpop.Visible = false;
        FillData();
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        
    }
    protected void ddlRowProductCnt_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillData();
    }
    protected void GrdVwLabelRequest_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //Object9420 Reg = new Object9420();
        //lblRequestLabelID.Text = e.CommandArgument.ToString();
        //Reg.Status = 0;
        //DataSet ds = function9420.FillGrdLabelsRequested(Reg);
        //DataView dv = ds.Tables[0].DefaultView;
        //dv.RowFilter = "Row_ID = " + Convert.ToInt32(e.CommandArgument.ToString());
        //DataTable dt = dv.ToTable();
        //#region Some Variables        
        //hdNoofCodes.Value = dt.Rows[0]["Labels"].ToString();        
        //HiddenFieldProNm.Value = dt.Rows[0]["Pro_Name"].ToString();
        //HiddenFieldLabelType.Value = dt.Rows[0]["Label_Name"].ToString();
        //#endregion        
        //if (e.CommandName == "RequestCancel")
        //{
        //    LabelCalText.Text = "RequestCancel";
        //    LabelAlertheader.Text = "Alert";
        //    LabelAlertText.Text = "Are you sure to canceled labels :- <a style='color:blue;text-decoration:none;'>" + dt.Rows[0]["Pro_Name"].ToString() + "</a> >> Type <a style='color:blue;text-decoration:none;'>" + dt.Rows[0]["Label_Name"].ToString() + "</a> >> quantity : <a style='color:blue;text-decoration:none;'>" + dt.Rows[0]["Labels"].ToString() + "</a> labels ?";
        //    ModalPopupExtenderAlert.Show();
        //}
    }        
    protected void GrdVwLabelRequest_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdVwLabelRequest.PageIndex = e.NewPageIndex;
        FillData();
    }
}
