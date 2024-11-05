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

public partial class Patanjali_AddLabelRequest : System.Web.UI.Page
{
    cls_patanjali db = new cls_patanjali();
    public string server = Convert.ToString(ConfigurationManager.ConnectionStrings["ServerName"].ConnectionString), userID = Convert.ToString(ConfigurationManager.ConnectionStrings["UserName"].ConnectionString), password = Convert.ToString(ConfigurationManager.ConnectionStrings["Password"].ConnectionString);
    public int pflag = 0, index = 0;
    public string srt = DataProvider.Utility.FindMailBody();

    private string _LabelRequestid_Prop;
    public string LabelRequestid_Prop
    {
        get { return (string)ViewState["_LabelRequestid_Prop"]; }
        set { ViewState["_LabelRequestid_Prop"] = value; }
    }


    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["CompanyId"] == null)
            Response.Redirect("../default.aspx?Page=AddGift.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            if (Session["UserName"] != null)
            {
                db.ExceptionLogs("Visit on AddLabaleRequest", Session["UserName"].ToString(), "R");
            }
            else
            {
                db.ExceptionLogs("Visit on AddLabaleRequest", Session["Comp_Name"].ToString(), "R");
            }

            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            FillDateCurrent();
            fillProduct();
            fillProductioAndChannel();
            //  FillData();
            //  FillddlSearch();
            if (Request.QueryString["id"] != null)
            {
                LabelRequestid_Prop = Convert.ToString(Request.QueryString["id"]);
                EditMode();
            }

            hdnCompID.Value = Session["CompanyId"].ToString();
            // hdncmphdn.Value = ProjectSession.strCompanyid;// Session["CompanyId"].ToString();
            //  lblmsgHeader.Text = "";
            //newMsg.Visible = false;
            //lblcount.Text = "0";
        }
        //Label2.Text = "";

    }

    public void EditMode()
    {
        CouponProver Reg = new CouponProver();
        lblBankId.Text = LabelRequestid_Prop;
        Reg.Gift_ID = lblBankId.Text;
        //newMsg.Visible = false;
        Reg.DML = "S";
        Reg.Comp_ID = Session["CompanyId"].ToString();
        CouponProver.GiftFillDataGrid(Reg);

        //txtName.Text = Reg.GiftName;
        //  lblAddCourierHeader.Text = "Gift update Details";
        //  btnSubmit.Text = "Update";
    }


    private void FillDateCurrent()
    {
        //  txtDateFrom.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy").ToString();
        //  txtDateTo.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy").ToString();
    }
    private void FillddlSearch()
    {
        //Object9420 obj = new Object9420();
        //obj.Comp_ID = Session["CompanyId"].ToString();
        //DataSet ds = function9420.FetchRequestProductList(obj);
        //DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProSearch, "--Select--");
        //ddlProSearch.SelectedIndex = 0;
    }
    [WebMethod]
    [ScriptMethod]
    public static string FindAllAmount(string res)
    {
        double myamount = 0.0;
        string[] Arr = res.ToString().Split('-');
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Label_Prise FROM  M_Label WHERE Label_Code = '" + Arr[0] + "'");
        if (ds.Tables[0].Rows.Count > 0)
            myamount = Convert.ToDouble(ds.Tables[0].Rows[0]["Label_Prise"]);
        myamount = myamount * Convert.ToDouble(Arr[1]);
        DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT Label_ServiceTax as ServiceTax, Label_Vat as VAT FROM Tax_Master_Info WHERE Row_Id = (SELECT MAX(Row_Id) FROM Tax_Master_Info WHERE Pro_ID = '" + Arr[2] + "' )");
        if (ds1.Tables[0].Rows.Count > 0)
        {
            double servicetax = Math.Round(Convert.ToDouble((myamount * Convert.ToDouble(ds1.Tables[0].Rows[0]["ServiceTax"])) / 100), 2);
            double vat = Math.Round(Convert.ToDouble((myamount * Convert.ToDouble(ds1.Tables[0].Rows[0]["VAT"])) / 100), 2);
            myamount = myamount + servicetax + vat;
        }
        if (ds.Tables[0].Rows.Count > 0)
            return myamount.ToString() + "-" + true;
        else
            return myamount.ToString() + "-" + false;
    }
    protected void ddlprotype_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillChkLabel();
        txtNoofLabel.Text = "";
        if (ddlprotype.SelectedIndex > 0)
        {
            ddlLabelType.SelectedValue = Convert.ToString(SQL_DB.ExecuteScalar("SELECT Label_Code, Label_Name + '( ' +Label_Size+ ') ' as Label_Name FROM  M_Label WHERE Label_Code IN (SELECT [Label_Code]  FROM Pro_Reg where [Pro_ID] = '" + ddlprotype.SelectedValue.ToString() + "') "));
            lblTypeNew1.Text = ddlLabelType.SelectedItem.Text;
        }
        else
            lblTypeNew1.Text = string.Empty;
        HdLabelCodeRequest.Value = ddlLabelType.SelectedValue;
        //   ModalPopupExtenderRequest.Show();
    }
    private void FillChkLabel()
    {
        DataSet ds = new DataSet();
        Object9420 rEG = new Object9420();
        ds = function9420.FillLabel();
        ddlLabelType.Items.Clear();
        ddlLabelType.DataSource = ds.Tables[0];
        ddlLabelType.DataTextField = "Label_Name";
        ddlLabelType.DataValueField = "Label_Code";
        ddlLabelType.DataBind();
        ddlLabelType.Items.Insert(0, "--Select--");
        ddlLabelType.SelectedIndex = 0;
    }
    private void fillProduct()
    {
        Object9420 obj = new Object9420();
        obj.Comp_ID = Session["CompanyId"].ToString();
        DataSet ds = function9420.FetchRequestPro(obj);// FetchRequestProductList(obj);
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlprotype, "--Select--");
        ddlprotype.SelectedIndex = 0;
        lblTypeNew1.Text = string.Empty;
    }
    private void fillProductioAndChannel()
    {
        Object9420 obj = new Object9420();
        obj.Comp_ID = ProjectSession.strCompanyid;
        DataTable ds = SQL_DB.ExecuteDataTable("Select * from ProductionUnit where compid = '" + ProjectSession.strCompanyid + "' ");
        DataProvider.MyUtilities.FillDDLInsertBlankIndexWithZero(ds, "ProductionUnitID", "Name", ddlPU, "--Select--");
        ddlPU.SelectedIndex = 0;
        DataTable dt = SQL_DB.ExecuteDataTable("Select * from Channels where compid = '" + ProjectSession.strCompanyid + "' ");
        DataProvider.MyUtilities.FillDDLInsertBlankIndexWithZero(dt, "ChannelsID", "Name", ddlChannels, "--Select--");
        ddlChannels.SelectedIndex = 0;
        lblTypeNew1.Text = string.Empty;
    }
    private void FillData()
    {
        //string StrAll = "";
        //Object9420 obj = new Object9420();
        //obj.Comp_ID = Session["CompanyId"].ToString();
        //obj.Tracking_No = txttrachingno.Text.Trim().Replace("'", "''");
        //if (ddlProSearch.SelectedIndex > 0)
        //    obj.Pro_ID = ddlProSearch.SelectedValue.Trim();
        //if (txtDateFrom.Text != "" && txtDateTo.Text != "")
        //    StrAll = "  AND CONVERT(nvarchar,M_Label_Request.Entry_Date, 111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "' AND CONVERT(nvarchar, M_Label_Request.Entry_Date, 111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        //else if (txtDateFrom.Text == "" && txtDateTo.Text != "")
        //    StrAll = "  AND CONVERT(nvarchar, M_Label_Request.Entry_Date, 111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        //else if (txtDateFrom.Text != "" && txtDateTo.Text == "")
        //    StrAll = "  AND CONVERT(nvarchar, M_Label_Request.Entry_Date, 111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
        //if (StrAll != "")
        //    obj.chkstr = StrAll;
        //DataSet ds = function9420.FetchRequestLabel(obj);
        //if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        //{
        //    if (ds.Tables[0].Rows.Count > 0)
        //        GrdVwLabelRequest.PageSize = ds.Tables[0].Rows.Count;
        //}
        //else
        //    GrdVwLabelRequest.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        //if (ds.Tables[0].Rows.Count > 0)
        //    GrdVwLabelRequest.DataSource = ds.Tables[0];
        //GrdVwLabelRequest.DataBind();
        //lblcount.Text = GrdVwLabelRequest.Rows.Count.ToString();

        //if (GrdVwLabelRequest.Rows.Count > 0)
        //    GrdVwLabelRequest.HeaderRow.TableSection = TableRowSection.TableHeader;

    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        //DivNewMsg.Visible = false; NewMsgpop.Visible = false;
        //FillDateCurrent();
        //txttrachingno.Text = string.Empty;
        //ddlProSearch.SelectedIndex = 0;
        //FillData();
    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        //DivNewMsg.Visible = false; NewMsgpop.Visible = false;
        //FillData();
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        //DivNewMsg.Visible = false; NewMsgpop.Visible = false;
        //Object9420 obj = new Object9420();
        //obj.Comp_ID = Session["CompanyId"].ToString();
        //DataSet ds = function9420.FetchRequestPro(obj);
        ////DataSet ds = function9420.FetchRequestProductList(obj);
        //if (ds.Tables[0].Rows.Count > 0)
        //{
        //    fillProduct();
        //    FillChkLabel();
        //    txtNoofLabel.Text = "";
        //    ModalPopupExtenderRequest.Show();
        //}
        //else
        //{
        //    DataSet ds1 = function9420.FetchRequestProductList(obj);
        //    if (ds1.Tables[0].Rows.Count == 0)
        //    {
        //        fillProduct();
        //        FillChkLabel();
        //        txtNoofLabel.Text = "";
        //        DivNewMsg.Visible = true;
        //        DivNewMsg.Attributes.Add("class", "alert_boxes_pink");
        //        LabelRequestmsg.Text = "Your product documents or sound file are not verified by Admin!";
        //        ModalPopupExtenderRequest.Show();
        //        string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
        //        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //        return;
        //    }
        //    else
        //    {
        //        DivNewMsg.Visible = true;
        //        DivNewMsg.Attributes.Add("class", "alert_boxes_pink");
        //        LabelRequestmsg.Text = "Please subscribe your service first <a href='ServicesSubcription.aspx' target='_blank' >Subscribe Service Click here.</a>!";
        //        ModalPopupExtenderRequest.Show();
        //        string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
        //        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //        return;
        //    }
        //}
    }
    protected void ddlRowProductCnt_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillData();
    }
    protected void GrdVwLabelRequest_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //    Object9420 Reg = new Object9420();
        //    lblRequestLabelID.Text = e.CommandArgument.ToString();
        //    Reg.Status = 0;
        //    DataSet ds = function9420.FillGrdLabelsRequested(Reg);
        //    DataView dv = ds.Tables[0].DefaultView;
        //    dv.RowFilter = "Row_ID = " + Convert.ToInt32(e.CommandArgument.ToString());
        //    DataTable dt = dv.ToTable();
        //    #region Some Variables        
        //    hdNoofCodes.Value = dt.Rows[0]["Labels"].ToString();
        //    HiddenFieldProNm.Value = dt.Rows[0]["Pro_Name"].ToString();
        //    HiddenFieldLabelType.Value = dt.Rows[0]["Label_Name"].ToString();
        //    #endregion        
        //    if (e.CommandName == "RequestCancel")
        //    {
        //        LabelCalText.Text = "RequestCancel";
        //        LabelAlertheader.Text = "Alert";
        //        LabelAlertText.Text = "Are you sure to canceled labels :- <a style='color:blue;text-decoration:none;'>" + dt.Rows[0]["Pro_Name"].ToString() + "</a> >> Type <a style='color:blue;text-decoration:none;'>" + dt.Rows[0]["Label_Name"].ToString() + "</a> >> quantity : <a style='color:blue;text-decoration:none;'>" + dt.Rows[0]["Labels"].ToString() + "</a> labels ?";
        //        ModalPopupExtenderAlert.Show();
        //    }
    }

    protected void btnYes_Click(object sender, EventArgs e)
    {
        //Object9420 Reg = new Object9420();
        //Reg.Row_ID = lblRequestLabelID.Text;
        //if (LabelCalText.Text == "RequestCancel")
        //{
        //    SQL_DB.ExecuteNonQuery("UPDATE [M_Label_Request] SET [Flag] = -2 WHERE Row_ID = " + Reg.Row_ID);
        //    NewMsgpop.Visible = true;
        //    NewMsgpop.Attributes.Add("class", "alert_boxes_pink big_msg");
        //    Label2.Text = hdNoofCodes.Value + " labels canceled successfully " + HiddenFieldProNm.Value + " >> " + HiddenFieldLabelType.Value;
        //    LabelCalText.Text = string.Empty;
        //    lblRequestLabelID.Text = string.Empty;
        //    FillData();
        //    hdNoofCodes.Value = string.Empty;
        //    HiddenFieldProNm.Value = string.Empty;
        //    HiddenFieldLabelType.Value = string.Empty;
        //    string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //}
    }
    public string FindGrandAmount(string res)
    {
        double myamount = 0.0;
        string[] Arr = res.ToString().Split('-');
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Label_Prise FROM  M_Label WHERE Label_Code = '" + Arr[0] + "'");
        if (ds.Tables[0].Rows.Count > 0)
            myamount = Convert.ToDouble(ds.Tables[0].Rows[0]["Label_Prise"]);
        myamount = myamount * Convert.ToDouble(Arr[1]);
        DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT Row_Id, Service_Tax, VAT, Entry_Date FROM Tax_Master WHERE Row_Id = (SELECT MAX(Row_Id) FROM Tax_Master)");
        if (ds1.Tables[0].Rows.Count > 0)
        {
            double servicetax = (myamount * Convert.ToDouble(ds1.Tables[0].Rows[0]["Service_Tax"])) / 100;
            double vat = (myamount * Convert.ToDouble(ds1.Tables[0].Rows[0]["VAT"])) / 100;
            myamount = myamount + servicetax + vat;
        }
        if (ds.Tables[0].Rows.Count > 0)
            return myamount.ToString();
        else
            return myamount.ToString();
    }
    protected void btnRequestSend_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Pro_ID = ddlprotype.SelectedValue.ToString();
        if (Convert.ToInt32(txtNoofLabel.Text) == 0)
        {
            DivNewMsg.Visible = true;
            DivNewMsg.Attributes.Add("class", "alert_boxes_pink");
            LabelRequestmsg.Text = "Please enter requested  No. of print Labels !";
            // ModalPopupExtenderRequest.Show();
            string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            return;
        }
        else if (!function9420.chkVerifyDoc(Reg))
        {
            DivNewMsg.Visible = true;
            DivNewMsg.Attributes.Add("class", "alert_boxes_pink");
            LabelRequestmsg.Text = "Your product documents or sound file are not verified by Admin!";
            string str = ddlLabelType.SelectedValue.ToString() + "-" + txtNoofLabel.Text;
            lblGrandTotal.Text = FindGrandAmount(str).ToString();
            //    ModalPopupExtenderRequest.Show();
            string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            return;
        }
        else
        {
            #region User Log 
            if (Session["UserName"] != null)
            {
                db.ExceptionLogs("Lable Requested", Session["UserName"].ToString(), "I");
            }
            else
            {
                db.ExceptionLogs("Lable Requested", Session["Comp_Name"].ToString(), "I");
            }
            #endregion
            Reg.Comp_ID = Session["CompanyId"].ToString();
            Reg.Pro_ID = ddlprotype.SelectedValue;
            Reg.Tracking_No = Reg.Comp_ID.ToString().Substring(5, 4) + Reg.Pro_ID + "-" + function9420.GetRequestLabelCode("LabelTracking");
            Reg.NoofCodes = Convert.ToInt32(txtNoofLabel.Text);
            Reg.Label_Code = ddlLabelType.SelectedValue;
            Reg.Flag = 0;
            Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt"));
            Reg.Pro_Name = ddlprotype.SelectedItem.Text.ToString();
            Reg.ProductionUnit = ddlPU.SelectedValue;
            Reg.Channels = ddlChannels.SelectedValue;
            function9420.InsertPrintRequestLabels(Reg);
            function9420.UpdateLabelCode(Reg);
            function9420.FillUpDateProfile(Reg);

            #region MailBody
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
               " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
               " <hr style='border:1px solid #2587D5;'/>" +
               " <div class='w_frame'>" +
               " <p>" +
               " <div class='w_detail'>" +
               " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
               " <br />" +
               " <span>Your label request for print, sent successfully. </span>" +
               " following details below: -" +
               " <p>" +
               " <table border='0' cellspacing='2'>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>Product Name :</strong></td>" +
               " <td width='50%' align='left' ><strong>" + Reg.Pro_Name + "</strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>No of labels : </strong></td>" +
               " <td width='50%' align='left' ><strong>" + Reg.NoofCodes + "</strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>Labels request ID : </strong></td>" +
               " <td width='50%' align='left' ><strong>" + Reg.Tracking_No + "</strong></td>" +
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
               " <td width='50%' align='left' ><strong>" + Reg.Pro_Name + "</strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>No of labels</strong></td>" +
               " <td width='50%' align='left' ><strong>" + Reg.NoofCodes + "</strong></td>" +
               " </tr>" +
               " </table>";
            string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Sales department", "Product label request has been sent successfully." + MBofy);
            string MailBody2 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Print department", "Product label request has been sent successfully." + MBofy);
            string MailBody3 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Account department", "Product label request has been sent successfully." + MBofy);
            string MailBody4 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "IT department", "Product label request has been sent successfully." + MBofy);
            #endregion
            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Label request sent");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Label request");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.print_accomplishtrades, MailBody2, "Label request");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Label request");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Label request");
            }
            Response.Redirect("frmPrintLabelRequest.aspx");
            //NewMsgpop.Visible = true;
            //NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
            //Label2.Text = "Your request sent successfully for printing <a style='color:blue;text-decoration:none;' >" + txtNoofLabel.Text + "</a> Labels to Admin!";
            //txttrachingno.Text = string.Empty;
            //ddlProSearch.SelectedIndex = 0;
            //  FillData();
            //  string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
            //  Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("frmPrintLabelRequest.aspx");
    }
}