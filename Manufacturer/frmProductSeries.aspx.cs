using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business9420;
using System.Data;

public partial class frmProductSeries : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../Info/Login.aspx?Page=frmProductSeries.aspx");
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
            lblcount.Text = "0"; 
        }
    }   
    private void fillData()
    {
        Object9420 Reg = new Object9420();
        if (ddlProduct.SelectedIndex > 0)
            Reg.Pro_ID = ddlProduct.SelectedValue.Trim();
        else
            Reg.Pro_ID = "";
        DataSet ds = function9420.FillSeriesDetails(Reg);
        if (ds.Tables[0].Rows.Count > 0)
            GrdPrintLabel.DataSource = ds.Tables[0];
        GrdPrintLabel.DataBind();
        lblcount.Text = ds.Tables[0].Rows.Count.ToString();
        if (GrdPrintLabel.Rows.Count > 0)
            GrdPrintLabel.HeaderRow.TableSection = TableRowSection.TableHeader;

    }
    private void fillProduct()
    {
        DataSet ds = new DataSet();
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.Status = 1;
        ds = function9420.FillProddlDetails(Reg);
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProduct, "--Select--");
        ddlProduct.SelectedIndex = 0;        
    }
   
    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlProduct.SelectedIndex > 0)
            fillData();
        else
        {
            lblcount.Text = "0";
        }
    }
    
    protected void GrdPrintLabel_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdPrintLabel.PageIndex = e.NewPageIndex;
        fillData();
    }

}