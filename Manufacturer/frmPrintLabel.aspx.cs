using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business9420;
using System.Data;

public partial class frmPrintLabel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Session["User_Type"] == null)
            Response.Redirect("../Info/Login.aspx?Page=frmPrintLabel.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }  
        if (!Page.IsPostBack)
        {
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            fillProduct();
            ddlBatch.Items.Clear();
            ddlBatch.Items.Insert(0, "--Select Batch--");
            fillData();
        }
    }
   
    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlProduct.SelectedIndex > 0)
            fillBatch();
        else
        {
            ddlBatch.Items.Clear();
            ddlBatch.Items.Insert(0, "--Select Batch--");
        }
        fillData();
    }
    protected void ddlBatch_SelectedIndexChanged(object sender, EventArgs e)
    {
        fillData();
    }
    private void fillBatch()
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        if (ddlProduct.SelectedIndex > 0)
        {
            Reg.Pro_ID = ddlProduct.SelectedValue.ToString();
            DataSet ds = function9420.FillBatchddlDetails(Reg);
            DataProvider.MyUtilities.FillDDLInsertZeroIndexIntVal(ds, "Row_ID", "Batch_No", ddlBatch, "--Select Batch--");
            ddlBatch.SelectedIndex = 0;
        }
    }    
    private void fillProduct()
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();        
        DataSet ds = function9420.FillProddlDetails(Reg);
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProduct, "--Select--");
        ddlProduct.SelectedIndex = 0;                
    }    
    private void fillData()
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();        
        if (ddlProduct.SelectedIndex > 0)
            Reg.Pro_ID = "'" + ddlProduct.SelectedValue.ToString() + "'";
        else
            Reg.Pro_ID = "M_Code.Pro_ID";        
        if (ddlBatch.SelectedIndex > 0)
            Reg.Row_ID = ddlBatch.SelectedValue.ToString();
        else
            Reg.Row_ID = "T_Pro.Row_ID";
        DataSet ds = function9420.FillGridForPrintedLabels(Reg);
         if (ds.Tables[0].Rows.Count > 0)
             GrdPrintLabel.DataSource = ds.Tables[0];
         GrdPrintLabel.DataBind();
         lblcount.Text = ds.Tables[0].Rows.Count.ToString();
        if (GrdPrintLabel.Rows.Count > 0)
            GrdPrintLabel.HeaderRow.TableSection = TableRowSection.TableHeader;


    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        fillData();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        fillProduct();
        ddlBatch.Items.Clear();
        ddlBatch.Items.Insert(0, "--Select Batch--");
        fillData();
    }
    protected void GrdPrintLabel_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdPrintLabel.PageIndex = e.NewPageIndex;
        fillData();
    }
    
}