using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Business9420;
using System.IO;
using ComponentAce.Compression.ZipForge;
using ComponentAce.Compression.Archiver;
using System.Net;
public partial class frmPayment : System.Web.UI.Page
{
    public int index = 0, str = 0, c = 0, pindex = 0, uindex = 0; public string PType = "", U_Type = "", Status="";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=frmPayment.aspx");
        else if (Session["User_Type"] == "Company")
            Response.Redirect("Index.aspx");
        if (!Page.IsPostBack)
        {
            if (Session["User_Type"].ToString() == "Admin")
                ChnageValidationGroup(true);
            else
                ChnageValidationGroup(false);
            lblmsg.Text = "";
            FillDateCurrent();
            FillBankAccount();
            FillProducts();
            fillGridDemo();
        }
    }
    protected void ddlComp_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlComp.SelectedIndex > 0)
            FillProducts();
        else
        {
            ddlPro.Items.Clear();
            ddlPro.Items.Insert(0, "--Select Product--");
            ddlPro.SelectedIndex = 0;
        }
    }
    private void FillProducts()
    {
        if (ddlComp.SelectedIndex > 0)
        {
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT Pro_ID, Pro_Name FROM  Pro_Reg WHERE Comp_ID='" + ddlComp.SelectedValue.ToString() + "' AND Doc_Flag = 1 AND  Sound_Flag = 1 ");
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlPro, "--Select Product--");
                ddlPro.SelectedIndex = 0;
            }
            else
            {
                ddlPro.Items.Clear();
                ddlPro.Items.Insert(0, "--Select Product--");
            }
        }
        else
        {
            ddlPro.Items.Clear();
            ddlPro.Items.Insert(0, "--Select Product--");
        }
        ddlPro.SelectedIndex = 0;
    }
    protected void DDLProductPayments_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DDLProductPayments.SelectedIndex > 0)
        {
            Business9420.function9420.FindAvaAmount(ddlCompId.SelectedValue.ToString());
            //if (rdLabelPayment.Checked)
            Object9420 Reg = new Object9420();
            Reg.Pro_ID = DDLProductPayments.SelectedValue;
            Reg.Availabl_Balance = Data9420.Data_9420.FindNetAvailablBalance(Reg);
            if (Reg.Availabl_Balance <= 0.00)
                lblAvlCodeDemo.Text = Math.Abs(Reg.Availabl_Balance).ToString(); 
            //lblAvlCodeDemo.Text = Business9420.function9420.FindAvaAmount(ddlCompId.SelectedValue.ToString(), DDLProductPayments.SelectedValue);
            //else
            //    lblAvlCodeDemo.Text = "0.00";
        }
        else
        {
            lblAvlCodeDemo.Text = "0.00";
        }
        ModalPopupExtenderNewDesign.Show();
    }
    private void ChnageValidationGroup(bool Flag)
    {
        if (Flag == true)
        {
            tdddlComp.Visible = true;
            RowDet.Visible = false;
            RowTAmt.Visible = true;
            RowComp.Visible = true;
            RequiredFieldValidator1.ValidationGroup = "NN";
            RequiredFieldValidatorComp3.ValidationGroup = "PR";
        }
        else
        {
            RequiredFieldValidator1.ValidationGroup = "PR";
            RequiredFieldValidatorComp3.ValidationGroup = "NN";
            tdddlComp.Visible = false;
            RowDet.Visible = true;
            RowTAmt.Visible = false;
            RowComp.Visible = false;
        }
    }
    private void FillDateCurrent()
    {
        txtDateFrom.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy").ToString();
        txtDateTo.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy").ToString();
    }

    protected void ddlPaymentMode_SelectedIndexChanged(object sender, EventArgs e)
    {
        if ((ddlPaymentMode.SelectedValue == "Cheque") || (ddlPaymentMode.SelectedValue == "DD"))
        {
            trmode.Attributes.Add("class", "display:block;");
            RequiredFieldValidator3.ValidationGroup = "PR";
            ddlmodeofpayment.Visible = true;
        }
        else
        {
            trmode.Attributes.Add("class", "display:none;");
            RequiredFieldValidator3.ValidationGroup = "NN";
            ddlmodeofpayment.Visible = false;
        }
        ModalPopupExtenderNewDesign.Show();

    }
    private void FillBankAccount()
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT  Bank_ID, Bank_Name FROM M_BankAccount WHERE Flag = 1");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Bank_ID", "Bank_Name", ddlComp_Id, "--Select--");
        ddlComp_Id.SelectedIndex = 0;
        ds.Reset(); ds = SQL_DB.ExecuteDataSet("SELECT  Bank_ID, Bank_Name FROM M_BankAccount WHERE Flag = 1");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Bank_ID", "Bank_Name", ddlStatus, "--Select Bank--");
        ddlStatus.SelectedIndex = 0;
        ds.Reset(); ds = Business9420.function9420.FillActiveComp();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", ddlComp, "--Select Company--");
        ddlComp.SelectedIndex = 0;
        ds.Reset(); ds = Business9420.function9420.FillActiveComp();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", ddlCompId, "--Select--");
        ddlCompId.SelectedIndex = 0;
    }
    protected void ddlCompId_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataSet dsn = new DataSet();
        if (ddlCompId.SelectedIndex == 0)
        {
            DDLProductPayments.Items.Clear();
            DDLProductPayments.Items.Insert(0, "--Select Product--");
            DDLProductPayments.SelectedIndex = 0;
            lblAvlCodeDemo.Text = "0.00";
        }
        else
        {
            dsn = SQL_DB.ExecuteDataSet("SELECT Pro_ID,Pro_Name FROM  Pro_Reg WHERE Comp_ID = '" + ddlCompId.SelectedValue + "' ");
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(dsn, "Pro_ID", "Pro_Name", DDLProductPayments, "--Select Product--");
            DDLProductPayments.SelectedIndex = 0;
            lblAvlCodeDemo.Text = "0.00";
        }
        //ddlPaymentMode.SelectedIndex = 0;
        //ddlmodeofpayment.SelectedIndex = 0;
        //fillProduct();
        //ChkValidation();
        ModalPopupExtenderNewDesign.Show();
    }
    private void fillGridDemo()
    {
        string stat = "", pmt = "";
        string StrAll = "";
        if (ddlStatus.SelectedValue == "--Select Bank--")
            stat = "";
        else
            stat = ddlStatus.SelectedValue.ToString();
        if (ddlPro.SelectedIndex == 0)
            pmt = "";
        else
            pmt = ddlPro.SelectedValue.ToString();

        if (txtDateFrom.Text != "" && txtDateTo.Text != "")
            StrAll = " (Payment_Received.Bank_ID like '%" + stat + "%') AND (''='" + pmt + "' OR Payment_Received.Pro_ID ='" + pmt + "') AND CONVERT(nvarchar, Payment_Received.Req_Date, 111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "' AND CONVERT(nvarchar, Payment_Received.Req_Date, 111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        else if (txtDateFrom.Text == "" && txtDateTo.Text != "")
            StrAll = " (Payment_Received.Bank_ID like '%" + stat + "%')  AND (''='" + pmt + "' OR Payment_Received.Pro_ID ='" + pmt + "')  AND CONVERT(nvarchar, Payment_Received.Req_Date, 111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        else if (txtDateFrom.Text != "" && txtDateTo.Text == "")
            StrAll = " (Payment_Received.Bank_ID like '%" + stat + "%')  AND (''='" + pmt + "' OR Payment_Received.Pro_ID ='" + pmt + "')  AND CONVERT(nvarchar, Payment_Received.Req_Date, 111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
        DataSet ds = new DataSet();
        string CompID = "";
        if (ddlComp.SelectedIndex == 0)
            CompID = "";
        else
            CompID = ddlComp.SelectedValue.ToString();
        ds = Business9420.function9420.FillDataGridPaymentRequest((StrAll + "ORDER BY  Payment_Received.Req_Date DESC ").ToString().Replace("Req_Date", "Rec_Date") + " --AND (Payment_Received.Rec_Date IS NOT NULL) ", CompID);
        lblcount.Text = ds.Tables[0].Rows.Count.ToString();
        if (ds.Tables[0].Rows.Count > 0)
            GrdCodePrintDemo.DataSource = ds.Tables[0];
        GrdCodePrintDemo.DataBind();
        if (GrdCodePrintDemo.Rows.Count > 0)
            FillFooterData(GrdCodePrintDemo, ds);
        lblcount.Text = ds.Tables[0].Rows.Count.ToString();
        if (ds.Tables[0].Rows.Count == 0)
            lbltotalpay.Text = "(0)";
        else
        {
            //DataTable dt = ds.Tables[0];
            //double k = dt.AsEnumerable().Sum(o => o.Field<Int16>("Rec_Amount"));
            lbltotalpay.Text = "(" + ds.Tables[0].Compute("SUM(Req_Amount)", "Flag = 0").ToString() + ")";      // "("+ k.ToString() + ")" ; 
        }
        if (lbltotalpay.Text == "()")
            lbltotalpay.Text = "(0)";        
    }
    private void FillFooterData(GridView GrdVw, DataSet ds)
    {
        if (GrdVw.Rows.Count > 0)
        {
            Label lblTpurchaseAmt0 = (Label)GrdVw.FooterRow.FindControl("P1");
            Label lblTpurchaseAmt = (Label)GrdVw.FooterRow.FindControl("P2");
            lblTpurchaseAmt0.Text = ds.Tables[0].Compute("SUM(Req_Amount)", "").ToString();
            lblTpurchaseAmt.Text = ds.Tables[0].Compute("SUM(Rec_Amount)", "").ToString();
        }
    }    
    protected void ddlComp_Id_SelectedIndexChanged(object sender, EventArgs e)
    {
        DivNewMsg.Visible = false;
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT  Row_ID, Bank_ID, Bank_Name, Account_HolderNm, Account_No, Branch, IFSC_Code, City, RTGS_Code, Account_Type, Address, Entry_Date, Flag FROM M_BankAccount WHERE Bank_ID = '" + ddlComp_Id.SelectedValue.ToString() + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            lblAccHolderNm.Text = ds.Tables[0].Rows[0]["Account_HolderNm"].ToString();
            lblAccNo.Text = ds.Tables[0].Rows[0]["Account_No"].ToString();
            lblIfsccode.Text = ds.Tables[0].Rows[0]["IFSC_Code"].ToString();
            ddlPaymentMode.SelectedIndex = 0;
            ddlmodeofpayment.SelectedIndex = 0;
        }
        ModalPopupExtenderNewDesign.Show();
    }
    protected void btnPrintDemo_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420(); string Msg = "";
        Reg.User_Type = Session["User_Type"].ToString();
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt"));
        Reg.Request_No = Business9420.function9420.GetRequest_No();
        Reg.PayMode = ddlPaymentMode.SelectedItem.Text.Trim();
        Reg.Details = txtDetails.Text.Trim().Replace("'", "''");
        Reg.Bank_ID = ddlComp_Id.SelectedValue.Trim();
        if ((ddlPaymentMode.SelectedItem.ToString() == "DD") || (ddlPaymentMode.SelectedItem.ToString() == "Cheque"))
            Reg.ModeofPayment = ddlmodeofpayment.SelectedValue;
        else
            Reg.ModeofPayment = null;
        Reg.Pro_ID = DDLProductPayments.SelectedValue;                
        Reg.G_Amount = Convert.ToDouble(txtNoofCode.Text.Trim().Replace("'", "''"));
        if (Session["User_Type"].ToString() == "Admin")
        {
            Reg.Rec_Payment = Reg.G_Amount;
            Reg.Req_Payment = Reg.G_Amount;
            Reg.Comp_ID = ddlCompId.SelectedValue.Trim();
            Reg.Flag = 1;
            Reg.Admin_Remarks = txtRemarks.Text.Trim().Replace("'", "''");
            Reg.Remarks = null;
        }
        else
        {
            Reg.Req_Payment = Reg.G_Amount;
            Reg.Rec_Payment = 0.00;
            Reg.Comp_ID = Session["CompanyId"].ToString();
            Reg.Flag = 0;
            Reg.Remarks = txtRemarks.Text.Trim().Replace("'", "''");
            Reg.Admin_Remark = null;
        }
        if (Reg.G_Amount <= 0.00)
        {
            DivNewMsg.Visible = true;
            lblpopmsg.Text = "Please enter pay Amount";
            DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            ModalPopupExtenderNewDesign.Show();
            return;
        }
        function9420.InsertReceivedPayment(Reg);
        //************ Receipt Report Code Start ***************//
        Reg.FolderPath = Server.MapPath("../Data/Bill");
        Reg.Path = Server.MapPath("../Reports") + "\\PaymentReceipt.rpt";
try{
        GenerateCrystalInvoice.Receipt.showReport(Reg);
}
catch(Exception ex)
{
	DivNewMsg.Visible = true;
        DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");        
        lblpopmsg.Text = ex.Message.ToString();
	ModalPopupExtenderNewDesign.Show();
	return;
}
        //************ Receipt Report Code End ***************//
        if (Session["User_Type"].ToString() == "Admin")
        {            
            Msg = "<span style='color:blue;'>" + ddlCompId.SelectedItem.Text.Trim() + " </span> >> <span style='color:blue;'>" + DDLProductPayments.SelectedItem.Text.Trim() + " </span>  Payment <span style='color:blue;'>" + Reg.G_Amount + "</span> Payment received successfully !";
        }
        else
            Msg = "<span style='color:blue;'>" + DDLProductPayments.SelectedItem.Text.Trim() + " </span>  Payment <span style='color:blue;'>" + Reg.G_Amount + "</span> Payment request sent successfully !";
        DivNewMsg.Visible = true;
        DivNewMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        Cleartxt();
        lblpopmsg.Text = Msg.ToString();
        ModalPopupExtenderNewDesign.Show();
        fillGridDemo();
        ChkValidation();
    }
    private void Cleartxt()
    {
        lblAvlCodeDemo.Text = "0.00";
        lblTotalAmt.Text = "0.00";
        lblpopmsg.Text = "";
        ddlPaymentMode.SelectedIndex = 0;
        ddlmodeofpayment.SelectedIndex = 0;
        DDLProductPayments.Items.Clear();
        DDLProductPayments.Items.Insert(0, "--Select--");
        DDLProductPayments.SelectedIndex = 0;
        ddlmodeofpayment.Visible = false;
        txtNoofCode.Text = "";
        txtDetails.Text = "";
        txtRemarks.Text = "";
        FillBankAccount();
        ddlComp_Id.SelectedIndex = 0;
        lblIfsccode.Text = string.Empty;
        lblAccNo.Text = string.Empty;
        lblAccHolderNm.Text = string.Empty;
    }

    protected void BtnSearchDemo_Click(object sender, ImageClickEventArgs e)
    {
        lblmsg.Text = "";
        fillGridDemo();
    }
    protected void BtnSearchDemoRefesh_Click(object sender, ImageClickEventArgs e)
    {
        FillDateCurrent();
        lblmsg.Text = ""; 
        FillBankAccount();
        fillGridDemo();
        FillProducts();
    }
    protected void GrdCodePrintDemo_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdCodePrintDemo.PageIndex = e.NewPageIndex;
        fillGridDemo();
    }

    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        lblmsg.Text = "";
        Cleartxt();
        DivNewMsg.Visible = false;
        if (ddlComp_Id.SelectedIndex == 0)
            lblTotalAmt.Text = "0.00";
        else
        {
            if (Business9420.function9420.FindAvaAmount(ddlComp_Id.SelectedValue.ToString()) == "")
                lblTotalAmt.Text = "0.00";
            else
                lblTotalAmt.Text = Business9420.function9420.FindAvaAmount(ddlComp_Id.SelectedValue.ToString());
        }
        //rdAmcPayment.Checked = false; rdLabelPayment.Checked = true; rdOfferPayment.Checked = false;
        ChkValidation();
        ModalPopupExtenderNewDesign.Show();
        //ModalPopupExtenderPrint.Show();
    }
    private void ChkValidation()
    {
        //Object9420 Reg = new Object9420();
        //if (rdLabelPayment.Checked)
        //{
        //    Fieldset3Child.Visible = true;
        //    Fieldset4.Visible = false;
        //    ReqValtxtAmount.ValidationGroup = "PR";
        //    //ReqValtxtDetails.ValidationGroup = "PR";
        //}
        //else if (rdAmcPayment.Checked)
        //{
        //    Fieldset3Child.Visible = false;
        //    Fieldset4.Visible = true;
        //    ReqValtxtAmount.ValidationGroup = "NN";
        //    //ReqValtxtDetails.ValidationGroup = "NN";
        //    Reg.Amt_Type = "AMC";
        //    GrdProductsAmc.Columns[1].HeaderText = "Amc Type";
        //    GrdProductsAmc.Columns[2].HeaderText = "Plan Amount";
        //    FillProductAmcAmount(Reg, GrdProductsAmc);

        //}
        //else if (rdOfferPayment.Checked)
        //{
        //    Fieldset3Child.Visible = false;
        //    Fieldset4.Visible = true;
        //    ReqValtxtAmount.ValidationGroup = "NN";
        //    //ReqValtxtDetails.ValidationGroup = "NN";
        //    Reg.Amt_Type = "Offer";
        //    GrdProductsAmc.Columns[1].HeaderText = "Offer Type";
        //    GrdProductsAmc.Columns[2].HeaderText = "Offer Amount";
        //    FillProductAmcAmount(Reg, GrdProductsAmc);

        //}
        //if (Session["User_Type"].ToString() == "Admin")
        //{
        //    if (rdLabelPayment.Checked)
        //        RowTAmt.Visible = true;
        //    else
        //        RowTAmt.Visible = false;
        //}
        //ModalPopupExtenderNewDesign.Show();
    }
    private void FillProductAmcAmount(Object9420 Reg, GridView GrdVw)
    {
        //if (Session["User_Type"].ToString() == "Admin")
        //{
        //    Reg.chkstr = " Admin_Balance ";
        //    if (ddlCompId.SelectedIndex == 0)
        //        Reg.Comp_ID = "";
        //    else
        //        Reg.Comp_ID = ddlCompId.SelectedValue.ToString();
        //}
        //else
        //{
        //    Reg.chkstr = " Manu_Balance ";
        //    Reg.Comp_ID = Session["CompanyId"].ToString();
        //}
        //Reg.Pro_ID = "";
        //DataSet ds = new DataSet();
        //if (ddlproduct.SelectedIndex > 0)
        //    Reg.Pro_ID = ddlproduct.SelectedValue;
        //else
        //    Reg.Pro_ID = "";
        //ds = function9420.FillProductAmcAmount(Reg);
        //GrdVw.DataSource = ds.Tables[0];
        //GrdVw.DataBind();
        //if (GrdVw.Rows.Count > 0)
        //{
        //    Label lblPAmt = (Label)GrdVw.FooterRow.FindControl("profooterplaAmt");
        //    Label lblPDiscAmt = (Label)GrdVw.FooterRow.FindControl("profooterpladiscAmt");
        //    Label lblPReqAmt = (Label)GrdVw.FooterRow.FindControl("profooterplareqAmt");
        //    Label lblPDueAmt = (Label)GrdVw.FooterRow.FindControl("profooterpladueAmt");
        //    lblPAmt.Text = ds.Tables[0].Compute("SUM(Plan_Amount)", "").ToString();
        //    lblPDiscAmt.Text = ds.Tables[0].Compute("SUM(Plan_Discount)", "").ToString();
        //    lblPReqAmt.Text = ds.Tables[0].Compute("SUM(Pending_Balance)", "").ToString();
        //    lblPDueAmt.Text = ds.Tables[0].Compute("SUM(Manu_Balance)", "").ToString();
        //}
        //if (GrdVw.Rows.Count > 5)
        //    MyAmcOfferGrdVw.Attributes.Add("style", "height: 200px; overflow: auto;");

    }
    protected void rdLabelPayment_CheckedChanged(object sender, EventArgs e)
    {
        fillProduct();
        DivNewMsg.Attributes.Add("class", "");
        lblpopmsg.Text = string.Empty;
        ChkValidation();
    }
    private void fillProduct()
    {
        //ddlproduct.Items.Clear();
        //DataSet ds = new DataSet();
        //if (ddlCompId.SelectedIndex > 0)
        //{
        //    Object9420 Reg = new Object9420();            
        //    if (Session["User_Type"].ToString() == "Admin")
        //    {
        //        Reg.chkstr = " Admin_Balance ";
        //        if (ddlCompId.SelectedIndex == 0)
        //            Reg.Comp_ID = "";
        //        else
        //            Reg.Comp_ID = ddlCompId.SelectedValue.ToString();
        //    }
        //    else
        //    {
        //        Reg.chkstr = " Manu_Balance ";
        //        Reg.Comp_ID = Session["CompanyId"].ToString();
        //    }
        //    Reg.Pro_ID = "";
        //    if(rdAmcPayment.Checked)
        //        Reg.Amt_Type = "AMC";
        //    else if(rdOfferPayment.Checked)
        //        Reg.Amt_Type = "Offer";            
        //    //ds = function9420.FillProductAmcOffer(Reg);
        //    ds = function9420.FilldllProAmcOffer(Reg);
        //    DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlproduct, "--Select Product--");
        //    ddlproduct.SelectedIndex = 0;
        //}
        //else
        //{
        //    ddlproduct.Items.Insert(0, "--Select Product--");
        //    ddlproduct.SelectedIndex = 0;
        //}
    }
    protected void ddlproduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        DivNewMsg.Attributes.Add("class", "");
        lblpopmsg.Text = string.Empty;
        ChkValidation();
    }
}