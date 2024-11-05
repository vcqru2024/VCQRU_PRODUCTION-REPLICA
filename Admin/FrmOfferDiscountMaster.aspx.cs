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

public partial class FrmOfferDiscountMaster : System.Web.UI.Page
{
    public int str = 0, strr = 0, lflag = 0; public int index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["User_Type"] = "Admin";
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmOfferDiscountMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {                        
            FillGrdVwPlanMaster();
            newMsg.Visible = false;
        }
        Label2.Text = "";
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {        
        newMsg.Visible = false;
        Cleartxt();
        Object9420 Reg = new Object9420();
        Reg.Trans_Type = "Offer";
        Reg.Plan_ID = "";
        FillPlan(Reg);
        newMsg.Visible = false;
        lblheading.Text = "Create New Offer Discount";
        ModalPopupCreateLabel.Show();
    }
    protected void ddlRowProductCnt_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillGrdVwPlanMaster();
    } 
    private void FillGrdVwPlanMaster()
    {
        Object9420 Reg = new Object9420();
        Reg.Trans_Type = "Offer";
        Reg.Plan_ID = "";
        Reg.Plan_Name = txtsearchlblname.Text.Trim().Replace("'", "''");
        DataSet ds = function9420.FillGridVwDiscount(Reg);
        if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        {
            if (ds.Tables[0].Rows.Count > 0)
                GrdLabel.PageSize = ds.Tables[0].Rows.Count;
        }
        else
            GrdLabel.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        GrdLabel.DataSource = ds.Tables[0];
        GrdLabel.DataBind();
        if (GrdLabel.Rows.Count > 0)
            lblcount.Text = GrdLabel.Rows.Count.ToString();
        else
            lblcount.Text = "0";   
    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdVwPlanMaster();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtsearchlblname.Text = string.Empty;
        newMsg.Visible = false;
        FillGrdVwPlanMaster();
    }
    protected void GrdLabel_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdLabel.PageIndex = e.NewPageIndex;
        FillGrdVwPlanMaster();
    }
    private void Cleartxt()
    {        
        lblplanAmount.Text = string.Empty;
        lbleditlabelid.Text = string.Empty;
        Lbltranstype.Text = string.Empty;
        txtlabelprise.Text = string.Empty;
        txtdatefrom.Text = string.Empty;
        txtdateto.Text = string.Empty;
        btnSave.Text = "Save";
    }
    protected void GrdLabel_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Cleartxt();
        Object9420 Reg = new Object9420();
        string[] Arr = e.CommandArgument.ToString().Split('-');
        if (Arr.Length > 1)
        {
            lbleditlabelid.Text = Arr[0].ToString();
            Reg.Plan_ID = Arr[1].ToString();
            Lbltranstype.Text = Arr[2].ToString();
            Reg.Trans_Type = Lbltranstype.Text;
            Reg.Row_ID = lbleditlabelid.Text;
            FillPlan(Reg);
            DataSet ds = function9420.FillGridVwDiscount(Reg);
            newMsg.Visible = false; Div1.Visible = false;
            if (e.CommandName == "EditLabel")
            {
                ddlplan.SelectedValue = Reg.Plan_ID;
                lblplanAmount.Text = ds.Tables[0].Rows[0]["Plan_Amount"].ToString();
                txtlabelprise.Text = ds.Tables[0].Rows[0]["Plan_Discount"].ToString();
                txtdatefrom.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["Date_From"]).ToString("dd/MM/yyyy");
                txtdateto.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["Date_To"]).ToString("dd/MM/yyyy");
                btnSave.Text = "Update";
                lblheading.Text = "Update Offer Discount";
                ModalPopupCreateLabel.Show();
            }
            else if (e.CommandName == "ShowHideLabel")
            {

                lblPassPnlHead.Text = "Alert";
                lblPopMsgText.Text = "Are you sure to " + FindStatus(Convert.ToInt32(ds.Tables[0].Rows[0]["Flag"].ToString())) + " <span style='color:blue;' >" + ds.Tables[0].Rows[0]["Plan_Name"].ToString() + " </span>  Offer Discount ?";
                ModalPopupExtender3.Show();
            }
            else if (e.CommandName == "ViewLabelDetails")
            {
                FillLabelDetGrd(Reg);
                ModalPopupLabelPriseDetails.Show();
            }
        }
    }
    private string FindStatus(int Status)
    {
        if (Status == 1)
            return "De-Activate";
        else
            return "Activate";
    }
    private string FindStatus1(int Status)
    {
        if (Status == 0)
            return "De-Activated";
        else
            return "Activated";
    }
    protected void btnYesActivation_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Row_ID = lbleditlabelid.Text;
        function9420.UpdateDiscountFlag(Reg);
        DataSet ds = function9420.FillGridVwDiscount(Reg);
        newMsg.Visible = true;
        newMsg.Attributes.Add("class", "alert_boxes_green");
        Label2.Text = "Status of <span style='color:blue;' >" + ds.Tables[0].Rows[0]["Plan_Name"].ToString() + " </span> is <span style='color:blue;' >" + ds.Tables[0].Rows[0]["Status"].ToString() + "</span> ! ";
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        FillGrdVwPlanMaster();
    }
    protected void btnNoActivation_Click(object sender, EventArgs e)
    {

    }
    private void FillLabelDetGrd(Object9420 Reg)
    {
        DataSet ds = function9420.FillPlanLog(Reg);
        function9420.FillPlanInfo(Reg);
        Label1.Text = " Offer Details";
        Label4.Text = "Offer <span style='color:blue;' > " + Reg.Plan_Name + " </span>";
        GrdViewLabelDetails.DataSource = ds.Tables[0];
        GrdViewLabelDetails.DataBind();
    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewPlan(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Plan_Name] FROM [M_Plan] where [Plan_Name] = '" + res.Trim().Replace("'", "''") + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        string script = "";
        Reg.Plan_ID = ddlplan.SelectedValue;
        Reg.Trans_Type = "Offer";
        function9420.FillDiscountInfo(Reg);
        Reg.Plan_Discount = Convert.ToDouble(txtlabelprise.Text);
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        Reg.DateFrom = Convert.ToDateTime(Convert.ToDateTime(txtdatefrom.Text).ToString("yyyy/MM/dd"));
        Reg.DateTo = Convert.ToDateTime(Convert.ToDateTime(txtdateto.Text).ToString("yyyy/MM/dd"));
        Reg.Flag = 1;
        if (btnSave.Text == "Save")
        {
            Reg.Row_ID = "0";
            if (function9420.CheckDateFromDiscount(Reg))
            {
                Div1.Visible = true;
                Div1.Attributes.Add("class", "alert_boxes_pink");
                ProductsLabelPrices.Text = "Please select valid AMC Offer date from";
                ModalPopupCreateLabel.Show();
                script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
            if (function9420.CheckDateToDiscount(Reg))
            {
                Div1.Visible = true;
                Div1.Attributes.Add("class", "alert_boxes_pink");
                ProductsLabelPrices.Text = "Please select valid AMC Offer date to";
                ModalPopupCreateLabel.Show();
                script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
            if (Reg.DateFrom >= Reg.DateTo)
            {
                Div1.Visible = true;
                Div1.Attributes.Add("class", "alert_boxes_pink");
                ProductsLabelPrices.Text = "Please select valid AMC Offer date from your old Amc End Date : - " + Convert.ToDateTime(Reg.DateTo).ToString("dd/MM/yyyy");
                ModalPopupCreateLabel.Show();
                script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
            Reg.DML = "I";
            function9420.SaveDiscountPlanMaster(Reg);
            ProductsLabelPrices.Text = "Offer <span style='color:blue;'>" + Reg.Plan_Name + "</span> has been saved successfully !";
            function9420.UpdateLabelCode("Plan");
            Div1.Visible = true;
            Div1.Attributes.Add("class", "alert_boxes_green");
            ModalPopupCreateLabel.Show();
            script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        else
        {
            Reg.Row_ID = lbleditlabelid.Text;
            Reg.chkstr = "Update";
            if (function9420.CheckDateFromDiscount(Reg))
            {
                Div1.Visible = true;
                Div1.Attributes.Add("class", "alert_boxes_pink");
                ProductsLabelPrices.Text = "Please select valid AMC Offer date from";
                ModalPopupCreateLabel.Show();
                script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
            if (function9420.CheckDateToDiscount(Reg))
            {
                Div1.Visible = true;
                Div1.Attributes.Add("class", "alert_boxes_pink");
                ProductsLabelPrices.Text = "Please select valid AMC Offer date to";
                ModalPopupCreateLabel.Show();
                script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
            if (Reg.DateFrom >= Reg.DateTo)
            {
                Div1.Visible = true;
                Div1.Attributes.Add("class", "alert_boxes_pink");
                ProductsLabelPrices.Text = "Please select valid AMC Offer date from your old Amc End Date : - " + Convert.ToDateTime(Reg.DateTo).ToString("dd/MM/yyyy");
                ModalPopupCreateLabel.Show();
                script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
            Reg.DML = "U";
            function9420.SaveAmcPlan(Reg);
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green");
            Label2.Text = "Offer <span style='color:blue;'>" + Reg.Plan_Name + "</span>  has been Updated successfully !";
            script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        Cleartxt();
        FillGrdVwPlanMaster();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Cleartxt();
        ModalPopupCreateLabel.Show();
    }
    private void FillPlan(Object9420 Reg)
    {
        DataSet ds = new DataSet();
        ds = function9420.FillPlan(Reg);
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Plan_ID", "Plan_Name", ddlplan, "--Select--");
        ddlplan.SelectedIndex = 0;
    }
    protected void ddlplan_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlplan.SelectedIndex > 0)
        {
            Object9420 Reg = new Object9420();
            Reg.Trans_Type = "Offer";
            Reg.Plan_ID = ddlplan.SelectedValue;
            DataSet ds = new DataSet();
            ds = function9420.FillPlan(Reg);
            lblplanAmount.Text = ds.Tables[0].Rows[0]["Plan_Amount"].ToString();
        }
        else
        {
            lblplanAmount.Text = string.Empty;
        }
        ModalPopupCreateLabel.Show();
    }
}