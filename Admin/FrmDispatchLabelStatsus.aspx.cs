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

public partial class FrmDispatchLabelStatsus : System.Web.UI.Page
{
    public string server = Convert.ToString(ConfigurationManager.ConnectionStrings["ServerName"].ConnectionString), userID = Convert.ToString(ConfigurationManager.ConnectionStrings["UserName"].ConnectionString), password = Convert.ToString(ConfigurationManager.ConnectionStrings["Password"].ConnectionString);
    public int pflag= 0,index = 0;
    public string srt = DataProvider.Utility.FindMailBody();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmDispatchLabelStatsus.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }          
        if (!Page.IsPostBack)
        {
            FillCompany();    
            FillData();
            //FillddlSearch();
        }
    }
    private void FillCompany()
    {
        DataSet ds = function9420.FillActiveComp();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", ddlcompname, "--Company--");
        ddlcompname.SelectedIndex = 0;
        ddlProSearch.Items.Clear();
        ddlProSearch.Items.Insert(0, "--Product--");
        ddlProSearch.SelectedIndex = 0;
    }
    protected void ddlcompname_SelectedIndexChanged(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        ddlProSearch.Items.Clear();
        if (ddlcompname.SelectedIndex > 0)
        {
            Reg.Comp_ID = ddlcompname.SelectedValue;
            //DataSet ds = SQL_DB.ExecuteDataSet("SELECT DISTINCT Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, Pro_Reg.Comp_ID FROM M_Code FULL OUTER JOIN  Pro_Reg ON M_Code.Pro_ID = Pro_Reg.Pro_ID WHERE (M_Code.Print_Status = 1)  AND (Pro_Reg.Comp_ID = '" + ddlcompname.SelectedValue.Trim().ToString() + "')");
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT DISTINCT Pro_ID, Pro_Name, Comp_ID FROM Pro_Reg WHERE  Comp_ID = '" + ddlcompname.SelectedValue + "' ");
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProSearch, "--Product--");
            ddlProSearch.SelectedIndex = 0;
        }
        else
        {
            ddlProSearch.Items.Insert(0, "--Product--");
            ddlProSearch.SelectedIndex = 0;
        }
    }   
    //private void FillddlSearch()
    //{
    //    Object9420 obj = new Object9420();
    //    obj.Comp_ID = Session["CompanyId"].ToString();
    //    //DataSet ds = function9420.FetchRequestProductList(obj);
    //    DataSet ds = SQL_DB.ExecuteDataSet("SELECT DISTINCT Pro_ID, Pro_Name, Comp_ID FROM Pro_Reg WHERE  Comp_ID = '" + ddlcompname.SelectedValue + "' ");
    //    DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProSearch, "--Select--");
    //    ddlProSearch.SelectedIndex = 0;
    //}                   
    private void FillData()
    {        
        Object9420 obj = new Object9420();
        if (ddlcompname.SelectedIndex > 0)
            obj.Comp_ID = ddlcompname.SelectedValue.ToString();
        else
            obj.Comp_ID = "";
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
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {        
        txttrachingno.Text = string.Empty;
        FillCompany();
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
