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
using DataProvider;
using Business_Logic_Layer;

public partial class Manufacturer_AddCoupons : System.Web.UI.Page
{
    public int Flag = 0, index = 0, sno = 1, IsAdminVerify = 0;
    public string srt = DataProvider.Utility.FindMailBody();

    private string _Couponid_Prop;
    public string Couponid_Prop
    {
        get { return (string)ViewState["_Couponid_Prop"]; }
        set { ViewState["_Couponid_Prop"] = value; }
    }

   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../default.aspx?Page=AddCoupons.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            Fillddl();
            
            if (Request.QueryString["id"] != null)
            {
                Couponid_Prop = Convert.ToString(Request.QueryString["id"]);
                EditMode();
            }
            //lblmsgHeader.Text = "";
            //FillGrid();
            if (Request.QueryString["Open"] != null)
            {
                //Clear();
                //newMsg.Visible = false;
                DivNewMsg.Visible = false;
                //ModalPopupExtenderNewDesign.Show();
            }
        }
        //Label2.Text = "";
        
    }

    public void EditMode()
    {
        CouponProver Reg = new CouponProver();
        lblBankId.Text = Couponid_Prop;
        Reg.Coupon_ID = lblBankId.Text;
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.DML = "S";
        Reg.CouponRequest_ID = lblBankId.Text;
        CouponProver.CRFillDataGrid(Reg);

        Fillddl();
        ddlCoupon.SelectedValue = Reg.Coupon_ID.ToString();
        txtdtfrom.Text = Convert.ToDateTime(Reg.DateFrom).ToString("dd/MM/yyyy");
        txtdtto.Text = Convert.ToDateTime(Reg.DateTo).ToString("dd/MM/yyyy");
        txtQty.Text = Reg.CouponCount.ToString();
        //lblAddCourierHeader.Text = "Coupon Request update Details";
        btnSubmit.Text = "Update";
    }

    private void Fillddl()
    {
        DataSet ds = new DataSet();
        ds = SQL_DB.ExecuteDataSet("SELECT Coupon_ID, CouponName FROM M_Coupon WHERE IsActive = 0 AND IsDelete = 0");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Coupon_ID", "CouponName", ddlCoupon, "--Select--");
        ddlCoupon.SelectedIndex = 0;
    }
    protected void btnSearch_Click(object sender, ImageClickEventArgs e)
    {
     //   FillGrid();
      //  newMsg.Visible = false;
    }
    protected void btnRefesh_Click(object sender, ImageClickEventArgs e)
    {
       // txtSearchName.Text = "";
       // FillGrid();
        //newMsg.Visible = false;
    }
    private void FillGrid()
    {
        //CouponProver Reg = new CouponProver();
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //Reg.DML = "F";
        //Reg.CouponName = txtSearchName.Text.Trim().Replace("'", "''");
        //DataTable DsGrd = new DataTable();
        //DsGrd = Business9420.CouponProver.CRFillDataGrid(Reg);
        //GrdVw.DataSource = DsGrd;
        //GrdVw.DataBind();
        //lblcount.Text = DsGrd.Rows.Count.ToString();
        //if (GrdVw.Rows.Count > 0)
        //    GrdVw.HeaderRow.TableSection = TableRowSection.TableHeader;

    }
    protected void GrdVw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //GrdVw.PageIndex = e.NewPageIndex;
        //FillGrid();
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
            return "Activated";
        else
            return "De-Activated";
    }
    protected void btnNo_Click(object sender, EventArgs e)
    {

    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        //CouponProver Reg = new CouponProver();
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //Reg.CouponRequest_ID = lblBankId.Text;
        //Reg.DML = "S";
        //CouponProver.CRFillDataGrid(Reg);
        //if (dhnactiontype.Value == "A")
        //{
        //    Reg.DML = "A";
        //    if (Reg.IsActive == 0)
        //    {
        //        Reg.IsActive = 1;
        //        lblmsgHeader.Text = "Courier <span style='color:blue;' >" + Reg.CouponName + "</span> has benn <span style='color:blue;' > " + FindStatusNew(Reg.IsActive) + " </span>  successfully.";
        //    }
        //    else
        //    {
        //        Reg.IsActive = 0;
        //        lblmsgHeader.Text = "Courier <span style='color:blue;' >" + Reg.CouponName + "</span> has benn <span style='color:blue;' > " + FindStatusNew(Reg.IsActive) + " </span>  successfully.";
        //    }
        //}
        //else if (dhnactiontype.Value == "D")
        //{
        //    Reg.DML = "D";
        //    if (Reg.IsDelete == 0)
        //        Reg.IsDelete = 1;
        //    else
        //        Reg.IsDelete = 0;
        //    lblmsgHeader.Text = "Courier <span style='color:blue;' >" + Reg.CouponName + "</span> has benn deleted  successfully.";
        //}
        //CouponProver.CRActivateDelete(Reg);
        //newMsg.Visible = true;
        //newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        //FillGrid();
        //string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        CouponProver Reg = new CouponProver();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.EntryDate = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        Reg.Coupon_ID = ddlCoupon.SelectedValue.Trim();
        Reg.DateFrom = txtdtfrom.Text;
        Reg.DateTo = txtdtto.Text;
        Reg.CouponCount = Convert.ToInt64(txtQty.Text);
        if (btnSubmit.Text == "Save")
        {
            Reg.DML = "I";
            //lblmsgHeader.Text = "Coupon Request <span style='color:blue;' >" + Reg.CouponName + "</span> has been registered successfully.";
        }
        else
        {
            Reg.CouponRequest_ID = lblBankId.Text;
            Reg.DML = "U";
            //lblmsgHeader.Text = "Coupon Request <span style='color:blue;' >" + Reg.CouponName + "</span> has beeb updated successfully.";
        }
        CouponProver.CRInsertUpdate(Reg);
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
           " <span>Your coupon request , sent successfully. </span>" +
           " <br/>following details below: -" +
           " <p>" +
           " <table border='0' cellspacing='2'>" +
           " <tr>" +
           " <td width='50%' align='left' ><strong>Coupon Name :</strong></td>" +
           " <td width='50%' align='left' ><strong>" + ddlCoupon.SelectedItem.Text.Trim() + "</strong></td>" +
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
           " <td width='50%' align='left' ><strong>" + ddlCoupon.SelectedItem.Text.Trim() + "</strong></td>" +
           " </tr>" +
           " <tr>" +
           " <td width='50%' align='left' ><strong>No of Coupons</strong></td>" +
           " <td width='50%' align='left' ><strong>" + Reg.CouponCount + "</strong></td>" +
           " </tr>" +
           " </table>";
        string MailBody1 = DataProvider.Utility.FindMailBody(Obj.Comp_Name, "Sales department", "Coupon request has been sent successfully." + MBofy);
        string MailBody2 = DataProvider.Utility.FindMailBody(Obj.Comp_Name, "Print department", "Coupon request has been sent successfully." + MBofy);
        string MailBody3 = DataProvider.Utility.FindMailBody(Obj.Comp_Name, "Account department", "Coupon request has been sent successfully." + MBofy);
        string MailBody4 = DataProvider.Utility.FindMailBody(Obj.Comp_Name, "IT department", "Coupon request has been sent successfully." + MBofy);
        #endregion
        DataSet dsMl = function9420.FetchMailDetail("admin");
        if (dsMl.Tables[0].Rows.Count > 0)
        {
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Obj.Comp_Email, MailBody, "Coupon request sent");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Coupon request");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.print_accomplishtrades, MailBody2, "Coupon request");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Coupon request");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Coupon request");
        }
        //newMsg.Visible = true;
        //newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        //string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //Clear();
        //FillGrid();
        Response.Redirect("FrmCouponRequest.aspx");
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        //Clear(); newMsg.Visible = false; DivNewMsg.Visible = false;
        //ModalPopupExtenderNewDesign.Show();
        Response.Redirect("FrmCouponRequest.aspx");
    }

}