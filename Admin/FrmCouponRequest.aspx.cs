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
using System.Web.Services;
using System.Web.Script.Services;

public partial class FrmCouponRequest : System.Web.UI.Page
{
    public int Flag = 0, index = 0, sno = 1, IsAdminVerify = 0;
    public string srt = DataProvider.Utility.FindMailBody();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmCourierDispatch.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!Page.IsPostBack)
        {
            lblmsgHeader.Text = "";
            FillddlComp();
            FillGrid();
        }
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        Clear();
        newMsg.Visible = false; DivNewMsg.Visible = false;
        ModalPopupExtenderNewDesign.Show();
    }
    private void Clear()
    {
        Fillddl();
        dhnactiontype.Value = string.Empty;
        txtdtfrom.Text = string.Empty;
        txtdtto.Text = string.Empty;
        txtQty.Text = string.Empty;
        lblAddCourierHeader.Text = "Add New Coupon Request";
        btnSubmit.Text = "Save";
    }
    private void Fillddl()
    {
        DataSet ds = new DataSet();
        ds = SQL_DB.ExecuteDataSet("SELECT Coupon_ID, CouponName FROM M_Coupon WHERE IsActive = 0 AND IsDelete = 0");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Coupon_ID", "CouponName", ddlCoupon, "--Select--");
        ddlCoupon.SelectedIndex = 0;
    }
    private void FillddlComp()
    {
        DataSet ds = new DataSet();
        ds = Data9420.Data_9420.FillActiveComp();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", ddlCompany, "--Select--");
        ddlCompany.SelectedIndex = 0;
    }
    protected void btnSearch_Click(object sender, ImageClickEventArgs e)
    {
        FillGrid();
        newMsg.Visible = false;
    }
    protected void btnRefesh_Click(object sender, ImageClickEventArgs e)
    {
        txtSearchName.Text = "";
        FillGrid();
        newMsg.Visible = false;
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {        
        FillGrid();
    }
    private void FillGrid()
    {
        CouponProver Reg = new CouponProver();
        if (ddlCompany.SelectedIndex > 0)
            Reg.Comp_ID = ddlCompany.SelectedValue.ToString();
        else
            Reg.Comp_ID = "";
        Reg.DML = "F";
        Reg.CouponName = txtSearchName.Text.Trim().Replace("'", "''");
        DataTable DsGrd = new DataTable();
        DsGrd = Business9420.CouponProver.CRFillDataGrid(Reg);
        if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        {
            if (DsGrd.Rows.Count > 0)
                GrdVw.PageSize = DsGrd.Rows.Count;
        }
        else
            GrdVw.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        if (DsGrd.Rows.Count > 0)
            GrdVw.DataSource = DsGrd;
        GrdVw.DataBind(); 
        lblcount.Text = DsGrd.Rows.Count.ToString();
    }
    protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillGrid();
    }
    protected void GrdVw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdVw.PageIndex = e.NewPageIndex;
        FillGrid();
    }
    protected void GrdVw_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        CouponProver Reg = new CouponProver();
        lblBankId.Text = e.CommandArgument.ToString();
        Reg.Comp_ID = SQL_DB.ExecuteScalar("SELECT Comp_ID FROM  M_CouponRequest where  CouponRequest_ID='" + lblBankId.Text + "'").ToString();
        Reg.CouponRequest_ID = lblBankId.Text; newMsg.Visible = false;
        Reg.DML = "S";
        CouponProver.CRFillDataGrid(Reg);
        dhncompid.Value = Reg.Comp_ID;
        if (e.CommandName.ToString() == "CancelledRow")
        {
            dhnactiontype.Value = "C";
            LabelAlertheader.Text = "Alert";
            LabelAlertText.Text = "Are you sure to dalete  <span style='color:blue;' >" + Reg.CouponName + "</span>  Coupon Request permanently?";
            ModalPopupExtenderAlert.Show();
        }
        else if (e.CommandName.ToString() == "VerifyRow")
        {
            DataTable DsGrd = Business9420.CouponProver.CMFillDataGrid(Reg);
            Int64 tcoupon = Convert.ToInt64(SQL_DB.ExecuteScalar("SELECT COUNT(Valid) Cnt FROM(SELECT *,DATEDIFF(dd,GETDATE(),ValidTo) Valid,CASE WHEN CONVERT(VARCHAR,ValidFrom,111) <= CONVERT(VARCHAR,GETDATE(),111) THEN 1 ELSE 0 END Live FROM M_CouponCodes  WHERE Coupon_ID = '"+ Reg.Coupon_ID +"'  AND ISNULL(AllotedDate,'') = '') REG WHERE REG.Live = 1 GROUP BY Valid"));            
            Int64 TCCount = Convert.ToInt64(DsGrd.Rows[0]["TotalCodes"]);
            if (tcoupon > 0)
                TCCount = tcoupon;
            else
                TCCount = 0;
            if (TCCount >= Convert.ToInt64(Reg.CouponCount))
            {
                dhnactiontype.Value = "V";
                LabelAlertheader.Text = "Alert";
                LabelAlertText.Text = "Are you sure to <span style='color:blue;' > Verify </span> <span style='color:blue;' >" + Reg.CouponName + "</span>  Coupon Request?";
                ModalPopupExtenderAlert.Show();
            }
            else
            {
                lblmsgHeader.Text = "Insufficient Coupon <a href='FrmCouponMaster.aspx?Open=OP' >Add more coupons.</a>";
                newMsg.Visible = true;
                newMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
        }
    }
    private string FindStatus(int p)
    {
        if (p == 0)
            return "De-Activate";
        else
            return "Activate";
    }
    private string FindStatusNew(int p)
    {
        if (p == 0)
            return "Verified";
        else
            return "Cancelled";
    }
    protected void btnNo_Click(object sender, EventArgs e)
    {

    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        CouponProver Reg = new CouponProver();
        Reg.Comp_ID = dhncompid.Value;
        Reg.CouponRequest_ID = lblBankId.Text;
        Reg.DML = "S";
        CouponProver.CRFillDataGrid(Reg);
        try
        {
            if (dhnactiontype.Value == "V")
            {                
                Reg.DML = "V";
                Reg.IsActive = 1;
                lblmsgHeader.Text = "Coupon Request <span style='color:blue;' >" + Reg.CouponName + "</span> has benn <span style='color:blue;' > " + FindStatusNew(Reg.IsAdminVerify) + " </span>  successfully.";
                if (AllotCoupons(Reg))
                    CouponProver.CRActivateDelete(Reg);
                else
                {
                    lblmsgHeader.Text = "Coupon request <span style='color:blue;' >" + Reg.CouponName + "</span> is not verified.";
                    newMsg.Visible = true;
                    newMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                    string script1 = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
                    return;
                }
                Object9420 Obj = new Object9420();
                Obj.Comp_ID = Reg.Comp_ID;
                Business9420.function9420.GetCompanyInfo(Obj);
                #region MailBody
                string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                   " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
                   " <hr style='border:1px solid #2587D5;'/>" +
                   " <div class='w_frame'>" +
                   " <p>" +
                   " <div class='w_detail'>" +
                   " <span>Dear <em><strong>" + Obj.Contact_Person + ",</strong></em></span><br />" +
                   " <br />" +
                   " <span>Your coupon request approved successfully. </span>" +
                   " <br/>following details below: -" +
                   " <p>" +
                   " <table border='0' cellspacing='2'>" +
                   " <tr>" +
                   " <td width='50%' align='left' ><strong>Coupon Name :</strong></td>" +
                   " <td width='50%' align='left' ><strong>" + Reg.CouponName + "</strong></td>" +
                   " </tr>" +
                   " <tr>" +
                   " <td width='50%' align='left' ><strong>No of Coupons : </strong></td>" +
                   " <td width='50%' align='left' ><strong>" + Reg.CouponCount + "</strong></td>" +
                   " </tr>" +
                   " <tr>" +
                   " <td width='50%' align='left' ><strong>Valid Date From : </strong></td>" +
                   " <td width='50%' align='left' ><strong>" + Convert.ToDateTime(Reg.DateFrom).ToString("dddd MMM dd,yyyy") + "</strong></td>" +
                   " </tr>" +
                   " <tr>" +
                   " <td width='50%' align='left' ><strong>Valid Date To : </strong></td>" +
                   " <td width='50%' align='left' ><strong>" + Convert.ToDateTime(Reg.DateTo).ToString("dddd MMM dd,yyyy") + "</strong></td>" +
                   " </tr>" +
                   " </table>" +
                   " <div class='w_detail'>" +
                   " Assuring you  of  our best services always.<br />" +
                   " Thank you,<br /><br />" +
                   " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                   "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                   " </div>" +
                   " </p>" +
                   " </div>" +
                   " </p>" +
                   " </div> " +
                   " </div> ";
                string MBofy = " <br/> following details below: -" +
                   " <p>" +
                   " <table border='0' cellspacing='2'>" +
                   " <tr>" +
                   " <td width='50%' align='left' ><strong>Product</strong></td>" +
                   " <td width='50%' align='left' ><strong>" + Reg.CouponName + "</strong></td>" +
                   " </tr>" +
                   " <tr>" +
                   " <td width='50%' align='left' ><strong>No of Coupons</strong></td>" +
                   " <td width='50%' align='left' ><strong>" + Reg.CouponCount + "</strong></td>" +
                   " </tr>" +
                   " </table>";
                string MailBody1 = DataProvider.Utility.FindMailBody(Obj.Comp_Name, "Sales department", "Coupon request has been approved successfully." + MBofy);
                string MailBody2 = DataProvider.Utility.FindMailBody(Obj.Comp_Name, "Print department", "Coupon request has been approved successfully." + MBofy);
                string MailBody3 = DataProvider.Utility.FindMailBody(Obj.Comp_Name, "Account department", "Coupon request has been approved successfully." + MBofy);
                string MailBody4 = DataProvider.Utility.FindMailBody(Obj.Comp_Name, "IT department", "Coupon request has been approved successfully." + MBofy);
                #endregion
                DataSet dsMl = function9420.FetchMailDetail("admin");
                if (dsMl.Tables[0].Rows.Count > 0)
                {
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Obj.Comp_Email, MailBody, "Coupon request approved");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Coupon request approved");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.print_accomplishtrades, MailBody2, "Coupon request approved");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Coupon request approved");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Coupon request approved");
                }
            }
            else if (dhnactiontype.Value == "C")
            {
                Reg.DML = "C";
                Reg.IsDelete = -1;
                lblmsgHeader.Text = "Coupon Request <span style='color:blue;' >" + Reg.CouponName + "</span> has benn cancelled  successfully.";
                CouponProver.CRActivateDelete(Reg);
                Object9420 Obj = new Object9420();
                Obj.Comp_ID = Reg.Comp_ID;
                Business9420.function9420.GetCompanyInfo(Obj);
                #region MailBody
                string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                   " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
                   " <hr style='border:1px solid #2587D5;'/>" +
                   " <div class='w_frame'>" +
                   " <p>" +
                   " <div class='w_detail'>" +
                   " <span>Dear <em><strong>" + Obj.Contact_Person + ",</strong></em></span><br />" +
                   " <br />" +
                   " <span>Your coupon request approved successfully. </span>" +
                   " <br/>following details below: -" +
                   " <p>" +
                   " <table border='0' cellspacing='2'>" +
                   " <tr>" +
                   " <td width='50%' align='left' ><strong>Coupon Name :</strong></td>" +
                   " <td width='50%' align='left' ><strong>" + Reg.CouponName + "</strong></td>" +
                   " </tr>" +
                   " <tr>" +
                   " <td width='50%' align='left' ><strong>No of Coupons : </strong></td>" +
                   " <td width='50%' align='left' ><strong>" + Reg.CouponCount + "</strong></td>" +
                   " </tr>" +
                   " <tr>" +
                   " <td width='50%' align='left' ><strong>Valid Date From : </strong></td>" +
                   " <td width='50%' align='left' ><strong>" + Convert.ToDateTime(Reg.DateFrom).ToString("dddd MMM dd,yyyy") + "</strong></td>" +
                   " </tr>" +
                   " <tr>" +
                   " <td width='50%' align='left' ><strong>Valid Date To : </strong></td>" +
                   " <td width='50%' align='left' ><strong>" + Convert.ToDateTime(Reg.DateTo).ToString("dddd MMM dd,yyyy") + "</strong></td>" +
                   " </tr>" +
                   " </table>" +
                   " <div class='w_detail'>" +
                   " Assuring you  of  our best services always.<br />" +
                   " Thank you,<br /><br />" +
                   " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                   "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                   " </div>" +
                   " </p>" +
                   " </div>" +
                   " </p>" +
                   " </div> " +
                   " </div> ";
                string MBofy = " <br/> following details below: -" +
                   " <p>" +
                   " <table border='0' cellspacing='2'>" +
                   " <tr>" +
                   " <td width='50%' align='left' ><strong>Product</strong></td>" +
                   " <td width='50%' align='left' ><strong>" + Reg.CouponName + "</strong></td>" +
                   " </tr>" +
                   " <tr>" +
                   " <td width='50%' align='left' ><strong>No of Coupons</strong></td>" +
                   " <td width='50%' align='left' ><strong>" + Reg.CouponCount + "</strong></td>" +
                   " </tr>" +
                   " </table>";
                string MailBody1 = DataProvider.Utility.FindMailBody(Obj.Comp_Name, "Sales department", "Coupon request has been cancelled successfully." + MBofy);
                string MailBody2 = DataProvider.Utility.FindMailBody(Obj.Comp_Name, "Print department", "Coupon request has been cancelled successfully." + MBofy);
                string MailBody3 = DataProvider.Utility.FindMailBody(Obj.Comp_Name, "Account department", "Coupon request has been cancelled successfully." + MBofy);
                string MailBody4 = DataProvider.Utility.FindMailBody(Obj.Comp_Name, "IT department", "Coupon request has been cancelled successfully." + MBofy);
                #endregion
                DataSet dsMl = function9420.FetchMailDetail("admin");
                if (dsMl.Tables[0].Rows.Count > 0)
                {
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Obj.Comp_Email, MailBody, "Coupon request cancelled");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Coupon request cancelled");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),ProjectSession.print_accomplishtrades, MailBody2, "Coupon request cancelled");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Coupon request cancelled");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Coupon request cancelled");
                }
            }                
        }
        catch (Exception ex)
        {
            lblmsgHeader.Text = "Coupon not alloted Error : " + ex.Message.ToString();
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            FillGrid();
            string script1 = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
        }
        newMsg.Visible = true;
        newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        FillGrid();
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        CouponProver Reg = new CouponProver();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.EntryDate = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        Reg.Coupon_ID = ddlCoupon.SelectedValue.Trim();
        Reg.DateFrom = Convert.ToDateTime(txtdtfrom.Text).ToString("yyyy/MM/dd");
        Reg.DateTo = Convert.ToDateTime(txtdtto.Text).ToString("yyyy/MM/dd");
        Reg.CouponCount = Convert.ToInt64(txtQty.Text);
        if (btnSubmit.Text == "Save")
        {
            Reg.DML = "I";
            lblmsgHeader.Text = "Coupon Request <span style='color:blue;' >" + Reg.CouponName + "</span> has been registered successfully.";
        }
        else
        {
            Reg.CouponRequest_ID = lblBankId.Text;
            Reg.DML = "U";
            lblmsgHeader.Text = "Coupon Request <span style='color:blue;' >" + Reg.CouponName + "</span> has beeb updated successfully.";
        }
        CouponProver.CRInsertUpdate(Reg);
        newMsg.Visible = true;
        newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        Clear();
        FillGrid();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Clear(); newMsg.Visible = false; DivNewMsg.Visible = false;
        ModalPopupExtenderNewDesign.Show();
    }
    private bool AllotCoupons(CouponProver Reg)
    {
        try
        {
            // Write code for allot coupons for this company
            Int64 tcoupon = Convert.ToInt64(SQL_DB.ExecuteScalar("SELECT COUNT(Valid) Cnt FROM(SELECT *,DATEDIFF(dd,GETDATE(),ValidTo) Valid,CASE WHEN CONVERT(VARCHAR,ValidFrom,111) <= CONVERT(VARCHAR,GETDATE(),111) THEN 1 ELSE 0 END Live FROM M_CouponCodes  WHERE Coupon_ID = '" + Reg.Coupon_ID + "'  AND ISNULL(AllotedDate,'') = '') REG WHERE REG.Live = 1 GROUP BY Valid"));
            DataTable dt = SQL_DB.ExecuteDataTable("SELECT TOP("+ Reg.CouponCount +") REG.* FROM(SELECT *,DATEDIFF(dd,GETDATE(),ValidTo) Valid,CASE WHEN CONVERT(VARCHAR,ValidFrom,111) <= CONVERT(VARCHAR,GETDATE(),111) THEN 1 ELSE 0 END Live FROM M_CouponCodes  WHERE Coupon_ID = '" + Reg.Coupon_ID + "'  AND ISNULL(AllotedDate,'') = '') REG WHERE REG.Live = 1 ORDER BY Valid");
            //DataTable dt = SQL_DB.ExecuteDataTable("SELECT TOP(" + Reg.CouponCount + ") * FROM M_CouponCodes WHERE Coupon_ID = '" + Reg.Coupon_ID + "' AND ISNULL(AllotedDate,'') = '' AND CONVERT(VARCHAR,ValidFrom,111) >= '" + Convert.ToDateTime(Reg.DateFrom).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,ValidTo,111) >= '" + Convert.ToDateTime(Reg.DateTo).ToString("yyyy/MM/dd") + "'");            
            string Qry = ""; int Counter = 0;
            for (int t = 0; t < dt.Rows.Count; t++)
            {
                Qry += "UPDATE [M_CouponCodes]  SET [Comp_ID] ='" + Reg.Comp_ID + "'  ,[AllotedDate] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE CouponTrans_ID ='" + dt.Rows[t]["CouponTrans_ID"].ToString() + "'; ";
                if (Counter == 100)
                {
                    SQL_DB.ExecuteNonQuery(Qry);
                    Qry = ""; Counter = 0;
                }
            }
            if (Qry != "")
            {
                SQL_DB.ExecuteNonQuery(Qry);
            }
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }   
}
