using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Business9420;
using System.Data.SqlClient;

public partial class FrmPendingLabelsReceipt : System.Web.UI.Page
{
    DataTable LabelDataTableInfo = new DataTable(); public int Flag = 0,index =0; 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmPendingLabelsReceipt.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        } 
        if (!IsPostBack)
        {
            FillCourierCompany();
            FillGrdMain();
        }
    }
    private void FillCourierCompany()
    {
        DataSet ds = function9420.FillCorierCompany();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Courier_ID", "Courier_Name", ddlCourierName, "--Select Courier--");
        ddlCourierName.SelectedIndex = 0;
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        ((DataTable)Session["LBLInfo"]).Rows.Clear();
        newMsg.Visible = false;
    }
    protected void BtnSearch_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void BtnRefesh_Click(object sender, ImageClickEventArgs e)
    {

    }
    private void FillGrdMain()
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = "";
        if (ddlCourierName.SelectedIndex > 0)
            Reg.Courier_ID = ddlCourierName.SelectedValue;
        if ((txtDateFrom.Text != "") && (txtDateTo.Text != ""))
            Reg.chkstr = " AND CONVERT(VARCHAR,Courier_Dispatch_Master.Expected_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,Courier_Dispatch_Master.Expected_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "' ";
        if ((txtDateFrom.Text != "") && (txtDateTo.Text == ""))
            Reg.chkstr = " AND CONVERT(VARCHAR,Courier_Dispatch_Master.Expected_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "' ";
        if ((txtDateFrom.Text == "") && (txtDateTo.Text != ""))
            Reg.chkstr = " AND CONVERT(VARCHAR,Courier_Dispatch_Master.Expected_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "' ";
        DataSet ds = function9420.FillGrdMainLabelDispatchDataPending(Reg);
        GrdCourierDispatch.DataSource = ds.Tables[0];
        GrdCourierDispatch.DataBind();
        lblcount.Text = ds.Tables[0].Rows.Count.ToString();
        FillProductDetails();
    }
    private void FillProductDetails()
    {
        DataSet ds = new DataSet();
        if (GrdCourierDispatch.Rows.Count > 0)
        {
            for (int i = 0; i < GrdCourierDispatch.Rows.Count; i++)
            {
                Label CourierDispID = (Label)GrdCourierDispatch.Rows[i].FindControl("lblCDispID");
                Object9420 obj = new Object9420();
                obj.Courier_Disp_ID = CourierDispID.Text;
                ds = function9420.GetCourierProDispInfo(obj);
                GridView Grd = (GridView)GrdCourierDispatch.Rows[i].FindControl("GrdLablelDet");
                Grd.DataSource = ds.Tables[0];
                Grd.DataBind();
            }
        }
    }
    protected void GrdCourierDispatch_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }
    protected void GrdCourierDispatch_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Object9420 Reg = new Object9420(); newMsg.Visible = false;
        lblCourierId.Text = e.CommandArgument.ToString();
        Reg.Courier_Disp_ID = lblCourierId.Text;
        function9420.GetCourierDispInfo(Reg); LabelCalText.Text = ""; hdCompanyNm.Value = Reg.Courier_Name;
        newMsg.Visible = true;
        LabelAlertheader.Text = "Alert";
        if (e.CommandName == "LabelReceipt")
        {
            MyRadio.Visible = false;
            LabelCalText.Text = "Cal No";
            LabelAlertText.Text = "Are you sure to receive " + Reg.Courier_Name + "''  Courier Dispatch Order ?";
        }
        else if (e.CommandName == "DenyLabels")
        {
            MyRadio.Visible = false;
            LabelCalText.Text = "Cal Deny";
            LabelAlertText.Text = "Are you sure to rejected " + Reg.Courier_Name + "''  Courier Dispatch Order ?";
        }
        ModalPopupExtenderAlert.Show();
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {

    }
    protected void btnYesReceipt_Click(object sender, EventArgs e)
    {
        if (LabelCalText.Text == "Cal Yes")
        {
            Object9420 Reg = new Object9420();
            Reg.Courier_Disp_ID = lblCourierId.Text;
            Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            if (rdReceipt.Checked)
                Reg.Flag = 1;
            else if (rdReceipts.Checked)
            {
                Reg.Flag = 2;
                Response.Redirect("FrmScrapLabelM.aspx?DPT_ID=" + Reg.Courier_Disp_ID);
            }
            else if (rdReceiptd.Checked)
                Reg.Flag = -1;
            function9420.LabelReceipt(Reg);
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
            lblmsgHeader.Text = "Courier ''" + hdCompanyNm.Value + "'' Dispatch order has been received successfully.";
            FillGrdMain();
            string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            hdCompanyNm.Value = string.Empty;
        }
        else if (LabelCalText.Text == "Cal Deny")
        {
            Object9420 Reg = new Object9420();
            Reg.Courier_Disp_ID = lblCourierId.Text;
            Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            Reg.Flag = -1;
            function9420.LabelReceipt(Reg);
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
            lblmsgHeader.Text = "Courier ''" + hdCompanyNm.Value + "'' Dispatch order has been rejected successfully.";
            FillGrdMain();
            string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            hdCompanyNm.Value = string.Empty;
        }
        else if (LabelCalText.Text == "Cal No")
        {
            MyRadio.Visible = true;
            LabelCalText.Text = "Cal Yes";
            LabelAlertText.Text = "";
            ModalPopupExtenderAlert.Show();
        }
    }
    protected void btnNoReceipt_Click(object sender, EventArgs e)
    {
        LabelCalText.Text = "";
    }
}
