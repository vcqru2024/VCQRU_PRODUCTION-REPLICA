using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Business9420;
using System.Web.Services;
using System.Web.Script.Services;
using System.IO;
using DataProvider;

public partial class FrmSettingTaxMaster : System.Web.UI.Page
{
    public int str = 0, strr = 0,lflag =0; public int index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {        
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmSettingTaxMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {
            FillGrdVwTaxMaster();
            newMsg.Visible = false;
            lblcount.Text = "0"; 
        }
        Label2.Text = "";
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        FillddlCompany();
        newMsg.Visible = false;        
        newMsg.Visible = false;
        lblheading.Text = "Create New Tax Setting";
        taxtxtclear();
        ModalTaxMaster.Show();
        
    }
    private void FillGrdVwTaxMaster()
    {        
        Object9420 Reg = new Object9420();
        Reg.Label_Name = txtsearchlblname.Text.Trim().Replace("'","''");
        Reg.TaxSet_ID = "";
        DataSet ds = function9420.FillGridVwTaxMaster(Reg);
        GrdVwTaxMaster.DataSource = ds.Tables[0];
        GrdVwTaxMaster.DataBind();
        lblcount.Text = GrdVwTaxMaster.Rows.Count.ToString();         
    }           
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdVwTaxMaster();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtsearchlblname.Text = string.Empty;
        newMsg.Visible = false;
        FillGrdVwTaxMaster();
    }
    protected void GrdVwTaxMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdVwTaxMaster.PageIndex = e.NewPageIndex;
        FillGrdVwTaxMaster();
    }
    
    protected void GrdVwTaxMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Object9420 Reg = new Object9420();
        lblrowid.Text = e.CommandArgument.ToString();
        Reg.Label_Code = lblrowid.Text;
        newMsg.Visible = false; Div3.Visible = false;   
        if (e.CommandName == "EditTax")
        {
            Reg.TaxSet_ID = lblrowid.Text;
            DataSet ds = function9420.FillGridVwTaxMaster(Reg);
            FillddlCompany();
            ddlCompID.SelectedValue = ds.Tables[0].Rows[0]["Comp_ID"].ToString();
            FillddlProduct(ddlCompID.SelectedValue, ds.Tables[0].Rows[0]["Pro_ID"].ToString());
            ddlProID.SelectedValue = ds.Tables[0].Rows[0]["Pro_ID"].ToString();
            lblcompcat.Text = ds.Tables[0].Rows[0]["Category_Name"].ToString();
            lblAddress.Text = ds.Tables[0].Rows[0]["Dispatch_Location"].ToString();
            txtAmcServiceTax.Text = ds.Tables[0].Rows[0]["AMC_ServiceTax"].ToString();
            txtAMCVATx.Text = ds.Tables[0].Rows[0]["AMC_Vat"].ToString();
            txtLabelServiceTax.Text = ds.Tables[0].Rows[0]["Label_ServiceTax"].ToString();
            txtLabelVAT.Text = ds.Tables[0].Rows[0]["Label_Vat"].ToString();
            txtOfferServiceTax.Text = ds.Tables[0].Rows[0]["Offer_ServiceTax"].ToString();
            txtOfferVAT.Text = ds.Tables[0].Rows[0]["Offer_Vat"].ToString();
            lblheading.Text = "Update Tax Setting";
            btnTaxSetting.Text = "Update";
            ModalTaxMaster.Show();            
        }        
    }
    protected void btnYesActivation_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Label_Code = lblrowid.Text;
        function9420.UpdateLabelFlag(Reg);
        function9420.FillLabelInfo(Reg);        
        newMsg.Visible = true;               
        newMsg.Attributes.Add("class", "alert_boxes_green");
        Label2.Text = "Are uou sure to <span style='color:blue;' >" + Reg.Label_Name + "</span>  ( " + Reg.Label_Size + " ) is <span style='color:blue;' >" + Reg.Label_Msg + "</span> ! ";
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        FillGrdVwTaxMaster();  
    }    
    protected void btnNoActivation_Click(object sender, EventArgs e)
    {
        
    }
    
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewLabel(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Label_Name] FROM [M_Label] where [Label_Name] = '" + res + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }    



    #region Tax Master Setting Code
    protected void ddlCompID_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCompID.SelectedIndex > 0)
        {
            FillddlProduct(ddlCompID.SelectedValue,"");
            lblcompcat.Text = SQL_DB.ExecuteScalar("SELECT Category_Name FROM Category_Master WHERE  Category_ID=(SELECT  Comp_Cat_Id FROM Comp_Reg WHERE Comp_ID = '" + ddlCompID.SelectedValue.Trim() + "') ").ToString();
        }
        else
        {
            FillddlCompany();
            lblcompcat.Text = string.Empty;
        }
        ModalTaxMaster.Show();
    }
    protected void ddlProID_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlProID.SelectedIndex > 0)
        {
            lblAddress.Text = SQL_DB.ExecuteScalar("SELECT Dispatch_Location FROM Pro_Reg WHERE Pro_ID = '" + ddlProID.SelectedValue.Trim() + "' ").ToString();
        }
        else
            lblAddress.Text = "";
        ModalTaxMaster.Show();
    }
    private void FillddlCompany()
    {
        ddlCompID.Items.Clear();
        DataSet ds = function9420.FillActiveCompForTax();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", ddlCompID, "--Select--");
        ddlCompID.SelectedIndex = 0;
        ddlProID.Items.Clear();
        ddlProID.Items.Insert(0, "--Select--");
        ddlProID.SelectedIndex = 0;
    }    
    private void FillddlProduct(string proid,string pro)
    {
        Object9420 Reg = new Object9420();
        Reg.DateFrom = Convert.ToDateTime(Convert.ToDateTime("01/04/" + DataProvider.LocalDateTime.Now.Year).ToString("yyyy/MM/dd"));
        Reg.DateTo = Reg.DateFrom.AddYears(1);
        Reg.DateTo = Reg.DateTo.AddDays(-1);
        ddlProID.Items.Clear();
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT distinct Pro_Reg.Pro_ID, Pro_Reg.Pro_Name FROM Pro_Reg WHERE (Pro_Reg.Comp_ID = '" + proid + "') AND (Pro_ID not in(SELECT  Pro_ID FROM dbo.Tax_Master_Info where convert(varchar,Date_From,111)='" + Convert.ToDateTime(Reg.DateFrom).ToString("yyyy/MM/dd") + "' and convert(varchar,Date_To,111)='" + Convert.ToDateTime(Reg.DateTo).ToString("yyyy/MM/dd") + "' AND Pro_Id not in ('"+ pro +"'))) ORDER BY Pro_Reg.Pro_Name ");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProID, "--Select--");
        ddlProID.SelectedIndex = 0;
        if (ds.Tables[0].Rows.Count == 0)
        {
            ddlProID.Items.Clear();
            ddlProID.Items.Insert(0, "--Select--");
            ddlProID.SelectedIndex = 0;
        }

    }
    private void taxtxtclear()
    {
        ddlCompID.SelectedIndex = 0; ddlProID.SelectedIndex = 0; lblrowid.Text = string.Empty;
        txtLabelServiceTax.Text = string.Empty; txtLabelVAT.Text = string.Empty; lblAddress.Text = string.Empty; txtOfferVAT.Text = string.Empty; txtAmcServiceTax.Text = string.Empty; txtAMCVATx.Text = string.Empty; txtOfferServiceTax.Text = string.Empty;
    }
    protected void btnResetTax_Click(object sender, EventArgs e)
    {
        taxtxtclear();
        ModalTaxMaster.Show();
    }
    protected void btnTaxSetting_Click(object sender, EventArgs e)
    {

        Object9420 Reg = new Object9420();
        Reg.Comp_ID = ddlCompID.SelectedValue;
        Reg.Pro_ID = ddlProID.SelectedValue;
        Reg.DateFrom = Convert.ToDateTime(Convert.ToDateTime("01/04/" + DataProvider.LocalDateTime.Now.Year).ToString("yyyy/MM/dd"));
        Reg.DateTo = Reg.DateFrom.AddYears(1);
        Reg.DateTo = Reg.DateTo.AddDays(-1);        
        Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        Reg.AMC_ServiceTax = Convert.ToDouble(txtAmcServiceTax.Text);
        Reg.AMC_Vat = Convert.ToDouble(txtAMCVATx.Text);
        Reg.Label_ServiceTax = Convert.ToDouble(txtLabelServiceTax.Text);
        Reg.Label_Vat = Convert.ToDouble(txtLabelVAT.Text);
        Reg.Offer_ServiceTax = Convert.ToDouble(txtOfferServiceTax.Text);
        Reg.Offer_Vat = Convert.ToDouble(txtOfferVAT.Text);
        if (btnTaxSetting.Text == "Save")
        {
            DataSet dsn = SQL_DB.ExecuteDataSet("SELECT * FROM Tax_Master_Info WHERE Comp_ID = '" + Reg.Comp_ID + "' AND Pro_ID = '" + Reg.Pro_ID + "' AND (convert(varchar,Date_From,111)='" + Convert.ToDateTime(Reg.DateFrom).ToString("yyyy/MM/dd") + "') AND (convert(varchar,Date_To,111)='" + Convert.ToDateTime(Reg.DateTo).ToString("yyyy/MM/dd") + "') ");
            if (dsn.Tables[0].Rows.Count > 0)
            {
                lblPopMsgText.Text = "Tax Setting <span style='color:blue;'>" + ddlCompID.SelectedItem.Text.Trim() + "</span> >> <span style='color:blue;'>" + ddlProID.SelectedItem.Text.Trim() + "</span>  already exist.";
                ModalPopupExtender3.Show();
                return;
            }
            Reg.Row_ID = "";
            Reg.TaxSet_ID = Business9420.function9420.GetLabelCode("TaxSetting");
            Reg.DML = "I";
            Business9420.function9420.TaxMasterSetting(Reg);
            Business9420.function9420.UpdateLabelCode("TaxSetting");
            Reg.statusstr = "saved";
        }
        else
        {
              Reg.DML = "U";
            Reg.TaxSet_ID = lblrowid.Text;
            btnTaxSetting.Text = "Save";
            Business9420.function9420.TaxMasterSetting(Reg);
            Reg.statusstr = "update";
        }         
        lblPopMsgText.Text = "Tax Setting <span style='color:blue;'>" + ddlCompID.SelectedItem.Text.Trim() + "</span> >> <span style='color:blue;'>" + ddlProID.SelectedItem.Text.Trim() + "</span>  has been " + Reg.statusstr + " successfully.";
        taxtxtclear();
        FillGrdVwTaxMaster();
        ModalPopupExtender3.Show();
    }
    #endregion
}