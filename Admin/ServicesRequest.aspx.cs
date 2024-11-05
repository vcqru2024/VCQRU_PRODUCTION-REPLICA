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
using Business_Logic_Layer;
using Business9420;
using System.Web.Services;
using System.Web.Script.Services;
using System.Text;

public partial class ServicesRequest : System.Web.UI.Page
{
    public StringBuilder srv = new StringBuilder(); public int vl = 0; public static int sno = 0;
    public int c = 0, str = 0, upplanindex = 0, upamcindex = 0, upofindex = 0, index = 0, pindex = 0, planindex = 0, Disp = 0, promoDisp = 0, dispindex = 0, promoind = 0; public string TransType = "", Comptype = "", LCode = "", PlanID = "", PromoID = ""; public bool LabelFlag = false;
    public int CntDays = 0, IsActive = 0, IsAdminVerify = 0;
    public string srt = DataProvider.Utility.FindMailBody();
    protected void Page_Load(object sender, EventArgs e)
    {
        #region Creae Conrol Panel For Services
        try
        {
            //Get ContentPlaceHolder
            ContentPlaceHolder content = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");

            Literal lt;
            Label lb;
            DataTable dt = SQL_DB.ExecuteDataSet("SELECT Service_ID, ServiceName, IsShowPrice, EntryDate, Image, IsActive, IsDelete FROM  M_Service WHERE IsActive = 0 AND IsDelete = 0 ").Tables[0];
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    srv = new StringBuilder();
                    srv.Append("<div class='col-md-3'>");
                    srv.Append("<div class='restmenuwrap'>");
                    srv.Append("<div class='restitem clearfix'>");
                    lt = new Literal();
                    lt.Text = srv.ToString();
                    pnlTextBox.Controls.Add(lt);

                    //Button To add TextBoxes
                    ImageButton btnAddTxt = new ImageButton();
                    btnAddTxt.ID = "BtnImgsrv" + i.ToString();
                    btnAddTxt.AlternateText = dt.Rows[i]["Service_ID"].ToString();
                    btnAddTxt.ToolTip = "Click Add For " + dt.Rows[i]["ServiceName"].ToString();
                    btnAddTxt.Attributes.Add("class", "rm-thumb");
                    btnAddTxt.OnClientClick = "javascript:GetService(this.alt)";
                    btnAddTxt.ImageUrl = "../Data/Service/" + dt.Rows[i]["Image"].ToString();
                    btnAddTxt.Click += new ImageClickEventHandler(btnSelectService_Click);
                    pnlTextBox.Controls.Add(btnAddTxt);
                    srv = new StringBuilder();

                    srv.Append("<h5 class='headname'>" + dt.Rows[i]["ServiceName"].ToString() + "</h5>");
                    srv.Append("<div style='width:100%;padding-left:0px;padding-top:10px;'>");
                    srv.Append("<span style='width:49%; float:left; text-align:left;'><a href='#'>Know More...</a></span><span style='width:49%; float:right; padding: 1px !important;  text-align: center;'><p title= '" + dt.Rows[i]["Service_ID"].ToString() + "' onclick='javascript:GetService(this.title)' style='border:solid 1px #e6e6e6; background-color:#909090; color:#f0f0f0; cursor:pointer;'>Buy Now</p></span>");
                    srv.Append("</div>");
                    srv.Append("</div>");
                    srv.Append("</div>");
                    srv.Append("</div>");

                    lt = new Literal();
                    lt.Text = srv.ToString();
                    pnlTextBox.Controls.Add(lt);

                }
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message.ToString());
        }
        #endregion
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=ServicesRequest.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!Page.IsPostBack)
        {
            Session["Plan_ID"] = "";
            FillddlCompany();
            filldata();
            NewMsgpop.Visible = false;
        }
    }
    protected void ddlsearchcomp_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlsearchcomp.SelectedIndex > 0)
            FillDropdown();
        else
        {
            ddlsearchcomp.Items.Clear();
            ddlsearchcomp.Items.Insert(0, "--Select--");
            ddlsearchcomp.SelectedIndex = 0;
        }
    }
    private void FillddlCompany()
    {
        Object9420 obj = new Object9420();//function9420.FillActiveComp();
        DataSet ds = function9420.FillAllComp();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", ddlsearchcomp, "--Select--");
        ddlsearchPro.SelectedIndex = 0;
    }
    private void FillDropdown()
    {
        Object9420 obj = new Object9420();
        obj.Comp_ID = ddlsearchcomp.SelectedValue.ToString();
        DataSet ds = function9420.FetchRequestProductList(obj);
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlsearchPro, "--Select--");
        ddlsearchPro.SelectedIndex = 0;
        ds = SQL_DB.ExecuteDataSet("SELECT Service_ID, ServiceName, IsShowPrice, EntryDate, Image, IsActive, IsDelete FROM M_Service WHERE IsActive = 0 AND IsDelete = 0");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Service_ID", "ServiceName", ddlsearchSrervice, "--Select--");
        ddlsearchSrervice.SelectedIndex = 0;
    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkFile(string ult)
    {
        int lindex = ult.LastIndexOf('.');
        string ext = ult.Substring(lindex, ult.Length - lindex);
        if (ext.ToUpper() == ".WAV")
            return false;
        else
            return true;
    }

    private void ClearText()
    {
        DivMsg.Visible = false;
        txtfrequency.Text = string.Empty;
        hdnpointsval.Value = string.Empty;
        ChangeUpdateFields(true);
        ChnageValidation(true);
        txtloyaltydtfrom.Text = string.Empty;
        txtloyaltydtto.Text = string.Empty;
        txtloyaltypoints.Text = string.Empty;
        txtProductName.Text = string.Empty;
        ddlProduct.SelectedIndex = 0;
        txtCommentsTxt.Text = string.Empty;
        chkconvert.Checked = false;
        txtDateFrom.Text = string.Empty;
        txtDateTo.Text = string.Empty;
        filldata();
    }

    private void CheckValidation(string ServiceId)
    {
        DataTable dt = SQL_DB.ExecuteDataSet("SELECT Row_ID, Service_ID,(SELECT ServiceName FROM M_Service WHERE Service_ID = M_ServiceFeature.Service_ID) ServiceName, IsPoints, IsDateRange, IsSound, IsFrequency, IsAdditionalGift, IsMessageTemplete, EntryDate, IsDelete FROM M_ServiceFeature WHERE IsDelete = 0 AND Service_ID = '" + ServiceId + "' ").Tables[0];
        if (dt.Rows.Count > 0)
        {
            Lblloyaltyhead.Text = "Add " + dt.Rows[0]["ServiceName"].ToString();
            int IsPoints = 0, IsDateRange = 0, IsSound = 0, IsFrequency = 0, IsAdditionalGift = 0, IsMessageTemplete = 0;
            IsPoints = Convert.ToInt32(dt.Rows[0]["IsPoints"].ToString());
            IsDateRange = Convert.ToInt32(dt.Rows[0]["IsDateRange"].ToString());
            IsSound = Convert.ToInt32(dt.Rows[0]["IsSound"].ToString());
            IsFrequency = Convert.ToInt32(dt.Rows[0]["IsFrequency"].ToString());
            IsAdditionalGift = Convert.ToInt32(dt.Rows[0]["IsAdditionalGift"].ToString());
            IsMessageTemplete = Convert.ToInt32(dt.Rows[0]["IsMessageTemplete"].ToString());
            if (IsPoints == 0)
            {
                divispoints.Visible = true;
                RFVIsPoints.ValidationGroup = "SRVS";
            }
            else
            {
                divispoints.Visible = false;
                RFVIsPoints.ValidationGroup = "NN";
            }
            if (IsDateRange == 0)
            {
                divisdaterange.Visible = true;
                RFVIsDateFrom.ValidationGroup = "SRVS";
            }
            else
            {
                divisdaterange.Visible = false;
                RFVIsDateFrom.ValidationGroup = "NN";
            }
            if (IsSound == 0)
            {
                divissoundComments.Visible = true;
                RFVIsMessage.ValidationGroup = "SRVS";
                RFVIsSoundH.ValidationGroup = "SRVS";
                RFVIsSoundE.ValidationGroup = "SRVS";
            }
            else
            {
                divissoundComments.Visible = false;
                RFVIsMessage.ValidationGroup = "NN";
                RFVIsSoundH.ValidationGroup = "NN";
                RFVIsSoundE.ValidationGroup = "NN";
            }
            if (IsFrequency == 0)
                divisfrequency.Visible = true;
            else
                divisfrequency.Visible = false;

        }
    }

    protected void btnSelectService_Click(object sender, ImageClickEventArgs e)
    {
        txtdtfromamc1.Text = Convert.ToDateTime(System.DateTime.Now.AddDays(1)).ToString("dd/MM/yyyy");
        fillProductLoyalty(true, ddlProSelect, "");
        string ServiceId = selsrvid.Value;
        FillPlanMasterGrid(ServiceId, 0);
        ModalPopupExtenderGridView.Show();
    }
    protected void txtsPeriod_TextChanged(object sender, EventArgs e)
    {
        if (txtsPeriod.Text != "")
        {
            txtdttoamc1.Text = Convert.ToDateTime(txtdtfromamc1.Text).AddMonths(Convert.ToInt32(txtsPeriod.Text)).AddDays(-1).ToString("dd/MM/yyyy");
        }
        ModalPopupExtenderGridView.Show();
    }
    [WebMethod]
    [ScriptMethod]
    public static string WritePlanAmtDis(string res)
    {
        string[] Arr = res.ToString().Split('*');
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Plan_ID, Service_ID, PlanName, PlanPeriod, PlanPrice, EntryDate, IsActive, IsDelete FROM M_ServicePlan WHERE PlanPeriod = '" + Convert.ToInt32(Arr[0]) + "' AND IsActive = 0  AND Service_ID = '" + Arr[1] + "' ");
        if (ds.Tables[0].Rows.Count > 0)
            return ds.Tables[0].Rows[0]["PlanPrice"].ToString() + "*0";
        else
            return "0*0";
    }
    protected void Submit_Click(object sender, EventArgs e)
    {
        ObjService Reg = new ObjService();
        Reg.Subscribe_Id = selsubid.Value;
        Reg.PlanSalePrice = Convert.ToInt64(txtPlanDiscount.Text);
        Reg.PlanSalePeriod = Convert.ToInt64(txtsPeriod.Text);
        Reg.DateFrom = Convert.ToDateTime(txtdtfromamc1.Text);
        Reg.DateTo = Convert.ToDateTime(txtdttoamc1.Text);
        try
        {
            ObjService.VerifyServiceRequest(Reg);
            //************************* Code start For Generate Invoice ******************//
            Object9420 Inv = new Object9420();
            Inv.Comp_ID = hhdnCompID.Value;
            Inv.Pro_ID = hddnProId.Value;
            Inv.Subscribe_Id = Reg.Subscribe_Id;
            Inv.Plan_ID = "";
            Inv.FolderPath = Server.MapPath("../Data/Bill");
            Inv.Path = Server.MapPath("../Reports") + "\\InvoiceReport.rpt";
            function9420.CreateInvoices(Inv);
            //************************* Code start For Generate Invoice ******************//  
            #region Data for Main
            string CompName = "", ContactPerson = "", CompEmail = "", ProName = "", ServiceName = "", PlanName = "", dtfrom = "", dtto = "", PlanSalePeriod = "", PlanSalePrice = "";
            DataTable sdt = SQL_DB.ExecuteDataTable("SELECT PlanSalePeriod,PlanSalePrice,DateFrom,DateTo,(SELECT m.ServiceName from M_Service AS m WHERE m.Service_ID = M_ServiceSubscription.Service_ID) as ServiceName,PlanName FROM M_ServiceSubscription WHERE Subscribe_Id = '" + Inv.Subscribe_Id + "'");
            if (sdt.Rows.Count > 0)
            {
                ServiceName = sdt.Rows[0]["ServiceName"].ToString(); PlanName = sdt.Rows[0]["PlanName"].ToString();
                dtfrom = Convert.ToDateTime(sdt.Rows[0]["DateFrom"]).ToString("dd/MM/yyyy");
                dtto = Convert.ToDateTime(sdt.Rows[0]["DateTo"]).ToString("dd/MM/yyyy");
                PlanSalePeriod = sdt.Rows[0]["PlanSalePeriod"].ToString();
                PlanSalePrice = sdt.Rows[0]["PlanSalePrice"].ToString();
            }
            DataTable prodt = SQL_DB.ExecuteDataTable("SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = '" + Inv.Pro_ID + "'");
            if (prodt.Rows.Count > 0)
                ProName = prodt.Rows[0]["Pro_Name"].ToString();
            DataTable desdt = SQL_DB.ExecuteDataTable("SELECT Contact_Person,Comp_Name,Comp_Email FROM Comp_Reg WHERE Comp_ID = '" + Inv.Comp_ID + "'");
            if (desdt.Rows.Count > 0)
            {
                CompName = desdt.Rows[0]["Comp_Name"].ToString(); ContactPerson = desdt.Rows[0]["Contact_Person"].ToString(); CompEmail = desdt.Rows[0]["Comp_Email"].ToString();
            }
            #endregion
            #region Mail
            #region MailBody
            string InvoiceLink = "" + ProjectSession.absoluteSiteBrowseUrl + "/Admin/Bill/Invoice/" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("dd-MM-yyyy") + "/" + Inv.Invoice_ID + ".pdf";
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
               " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
               " <hr style='border:1px solid #2587D5;'/>" +
               " <div class='w_frame'>" +
               " <p>" +
               " <div class='w_detail'>" +
               " <span>Dear <em><strong>" + ContactPerson + ",</strong></em></span><br />" +
               " <br />" +
               " <span>Product <b>" + ProName + " </b></span><br />" +
               " <br /> Plan Name : " + ServiceName + "  (" + PlanName + ") <br />" +
               " <br /> <b>Plan Period</b> <br />" +
               " <br /> Date From  <b>" + (dtfrom != "" ? Convert.ToDateTime(dtfrom).ToString("dd/MM/yyyy") : "") + " <br /> " +
               " <br /></b>  Date To  <b>" + (dtto != "" ? Convert.ToDateTime(dtto).ToString("dd/MM/yyyy") : "") + "</b><br />" +
               " <br /> Plan Time in Months : " + PlanSalePeriod + " <br />" +
               " <br /> Plan Amount in Rs. : " + PlanSalePrice + " <br />" +
               " <br /><br /> Your request for subscription of above service has been verified and accepted. kindly make request for label Printing for the above product. An Invoice for this service has been generated and attached with this email.<br />" +
               " <br /> Download your invoice  <a href='" + InvoiceLink + "' target='_blank' >Invoice</a><br />" +
               " <p>" +
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
            string MailBody1 = DataProvider.Utility.FindMailBody(CompName, "Sales department", "Product <b>" + ProName + "'s</b> Service subscripion request.");
            string MailBody2 = DataProvider.Utility.FindMailBody(CompName, "Lagal department", "Product <b>" + ProName + "'s</b> Service subscripion request.");
            string MailBody3 = DataProvider.Utility.FindMailBody(CompName, "Account department", "Product <b>" + ProName + "'s</b> Service subscripion request.");
            string MailBody4 = DataProvider.Utility.FindMailBody(CompName, "IT department", "Product <b>" + ProName + "'s</b> Service subscripion request.");
            #endregion
            string SubjectStr = Reg.ServiceName + " subscripion request accepted for " + ProName;
            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), CompEmail, MailBody, SubjectStr);
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Service subscripion request");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Legal_accomplishtrades, MailBody2, "Service subscripion request");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Service subscripion request");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Service subscripion request");
            }
            #endregion
        }
        catch (Exception ex)
        {

        }
        filldata();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        ModalPopupExtenderServices.Show();
    }
    private int FindOccurence(string substr)
    {
        string reqstr = Request.Form.ToString();
        return ((reqstr.Length - reqstr.Replace(substr, "").Length) / substr.Length);
    }
    private void RecreateControls(string ctrlPrefix, string ctrlType)
    {
        string[] ctrls = Request.Form.ToString().Split('&');
        int cnt = FindOccurence(ctrlPrefix);
        if (cnt > 0)
        {
            Literal lt;
            for (int k = 1; k <= cnt; k++)
            {
                for (int i = 0; i < ctrls.Length; i++)
                {
                    if (ctrls[i].Contains(ctrlPrefix + "-" + k.ToString()))
                    {
                        string ctrlName = ctrls[i].Split('=')[0];
                        string ctrlValue = ctrls[i].Split('=')[1];

                        //Decode the Value
                        ctrlValue = Server.UrlDecode(ctrlValue);

                        if (ctrlType == "TextBox")
                        {
                            TextBox txt = new TextBox();
                            txt.ID = ctrlName;
                            txt.Text = ctrlValue;
                            pnlTextBox.Controls.Add(txt);
                            lt = new Literal();
                            lt.Text = "<br />";
                            pnlTextBox.Controls.Add(lt);
                        }

                        if (ctrlType == "DropDownList")
                        {
                            DropDownList ddl = new DropDownList();
                            ddl.ID = ctrlName;

                            //Rebind Data
                            ddl.Items.Add(new ListItem("One", "1"));
                            ddl.Items.Add(new ListItem("Two", "2"));
                            ddl.Items.Add(new ListItem("Three", "3"));

                            //Select the Preselected Item
                            ddl.Items.FindByValue(ctrlValue).Selected = true;
                            pnlDropDownList.Controls.Add(ddl);
                            lt = new Literal();
                            lt.Text = "<br />";
                            pnlDropDownList.Controls.Add(lt);
                        }
                        break;
                    }
                }
            }
        }
    }
    private void fillProductLoyalty(bool Flag, DropDownList ddlPro, string CompID)
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = CompID;
        string Qry = "";
        if (Flag)
            Qry = "SELECT Pro_ID, Pro_Name FROM Pro_Reg WHERE (Comp_ID = '" + Reg.Comp_ID + "') AND (Doc_Flag = 1) AND (Sound_Flag = 1) AND (Pro_ID NOT IN (SELECT Pro_ID FROM M_ServiceSubscription WHERE (Comp_ID = Pro_Reg.Comp_ID) AND IsDelete = 0 AND Service_ID = '" + selsrvid.Value + "')) ORDER BY Pro_Name";
        else
            Qry = "SELECT Pro_ID, Pro_Name FROM Pro_Reg WHERE (Comp_ID = '" + Reg.Comp_ID + "') AND (Doc_Flag = 1) AND (Sound_Flag = 1) AND (Pro_ID NOT IN (SELECT Pro_ID FROM M_ServiceSubscription WHERE  Pro_ID <> '" + lblproiddel.Text + "' AND (Comp_ID = Pro_Reg.Comp_ID)  AND IsDelete = 0 AND Service_ID = '" + selsrvid.Value + "')) ORDER BY Pro_Name";
        //if (Flag)
        //    Qry = "SELECT Pro_ID, Pro_Name FROM Pro_Reg WHERE (Comp_ID = '" + Reg.Comp_ID + "') AND (Doc_Flag = 1) AND (Sound_Flag = 1) AND (Pro_ID NOT IN (SELECT Pro_ID FROM M_Loyalty WHERE (Comp_ID = Pro_Reg.Comp_ID) AND IsDelete = 0)) ORDER BY Pro_Name";
        //else
        //    Qry = "SELECT Pro_ID, Pro_Name FROM Pro_Reg WHERE (Comp_ID = '" + Reg.Comp_ID + "') AND (Doc_Flag = 1) AND (Sound_Flag = 1) AND (Pro_ID NOT IN (SELECT Pro_ID FROM M_Loyalty WHERE  Pro_ID <> '" + lblproiddel.Text + "' AND (Comp_ID = Pro_Reg.Comp_ID)  AND IsDelete = 0)) ORDER BY Pro_Name";
        DataTable ds = SQL_DB.ExecuteDataSet(Qry).Tables[0];
        if (ds.Rows.Count > 0)
        {
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlPro, "--Select--");
            ddlPro.SelectedIndex = 0;
        }
        else
        {
            ddlPro.Items.Clear();
            ddlPro.Items.Insert(0, "--Select--");
        }
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        NewMsgpop.Visible = false;
        txtDateFrom.Text = ""; txtDateTo.Text = ""; txtProductName.Text = ""; filldata();
    }

    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        NewMsgpop.Visible = false;
        filldata();
    }
    private void filldata()
    {
        Loyalty_Programm obj = new Loyalty_Programm();
        if (ddlsearchcomp.SelectedIndex > 0)
            obj.Comp_ID = ddlsearchcomp.SelectedValue.ToString();
        else
            obj.Comp_ID = "";
        obj.Pro_Name = txtProductName.Text.Trim().Replace("'", "''");
        if (ddlsearchSrervice.SelectedIndex > 0)
            obj.Service_ID = " AND t.Service_ID = '" + ddlsearchSrervice.SelectedValue + "' ";
        if (ddlsearchPro.SelectedIndex > 0)
            obj.Pro_ID = " AND t.Pro_ID = '" + ddlsearchPro.SelectedValue + "' ";
        if (ddlstaus.SelectedValue == "Pending")
            obj.Qry = " AND t.IsAdminVerify = 0 ";
        else if (ddlstaus.SelectedValue == "Verify")
            obj.Qry = " AND t.IsAdminVerify = 1 ";
        else if (ddlstaus.SelectedValue == "Activaed")
            obj.Qry = " AND t.IsActive = 1 ";
        else if (ddlstaus.SelectedValue == "De-Activaed")
            obj.Qry = " AND t.IsActive = 0 ";
        DataSet ds = Loyalty_Programm.FillServiceSubscription(obj);
        if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        {
            if (ds.Tables[0].Rows.Count > 0)
                GrdProductMaster.PageSize = ds.Tables[0].Rows.Count;
        }
        else
            GrdProductMaster.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        if (ds.Tables[0].Rows.Count > 0)
            GrdProductMaster.DataSource = ds.Tables[0];
        GrdProductMaster.DataBind();
        lblcount.Text = GrdProductMaster.Rows.Count.ToString();
    }
    protected void ddlstaus_SelectedIndexChanged(object sender, EventArgs e)
    {
        filldata();
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        NewMsgpop.Visible = false;
        filldata();
    }
    private string FindStatus(int i)
    {
        if (i == 1)
            return "Activeted";
        else
            return "De-Activeted";
    }
    private string FindStatusNew(int i)
    {
        if (i == 0)
            return "Activeted";
        else
            return "De-Activeted";
    }
    protected void GrdProductMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            currindex.Value = string.Empty;
            NewMsgpop.Visible = false;
            string ssID = e.CommandArgument.ToString();
            lblproiddel.Text = e.CommandArgument.ToString();
            string CompID = SQL_DB.ExecuteScalar("SELECT Comp_ID FROM M_ServiceSubscription WHERE  Subscribe_Id = '" + lblproiddel.Text + "' ").ToString();
            hhdnCompID.Value = CompID;
            lblproidamc.Value = lblproiddel.Text;
            if (e.CommandName == "IsActive")
            {
                #region
                ActionText.Value = "IsActive";
                Loyalty_Programm Reg = new Loyalty_Programm();
                if (ddlsearchcomp.SelectedIndex > 0)
                    Reg.Comp_ID = CompID;
                else
                    Reg.Comp_ID = "";
                Reg.Pro_Name = txtProductName.Text.Trim().Replace("'", "''");
                if (ddlsearchSrervice.SelectedIndex > 0)
                    Reg.Service_ID = " AND t.Service_ID = '" + ddlsearchSrervice.SelectedValue + "' ";
                if (ddlsearchPro.SelectedIndex > 0)
                    Reg.Pro_ID = " AND t.Pro_ID = '" + ddlsearchPro.SelectedValue + "' ";
                Reg.Subscribe_Id = " AND t.Subscribe_Id = '" + lblproiddel.Text + "' ";
                DataSet ds = Loyalty_Programm.FillServiceSubscription(Reg);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    IsAct.Value = ds.Tables[0].Rows[0]["IsActive"].ToString();
                    selsubid.Value = ds.Tables[0].Rows[0]["Subscribe_Id"].ToString();
                    Reg.Pro_Name = ds.Tables[0].Rows[0]["Pro_Name"].ToString();
                    Reg.Subscribe_Id = selsubid.Value;

                    btnNoAlert.Visible = false;
                    LabelAlertHead.Text = "Alert";
                    lblalert.Text = " Are you sure to <span style='color:blue;'>" + FindStatusNew(Convert.ToInt32(ds.Tables[0].Rows[0]["IsActive"])) + "</span> service request for <span style='color:blue;'>" + ds.Tables[0].Rows[0]["Pro_Name"].ToString() + "</span> product ?";
                    ModalPopupExtenderAlert.Show();


                    ////Loyalty_Programm Reg = new Loyalty_Programm();
                    ////Reg.RowId = Convert.ToInt64(currindex.Value);
                    ////if (ActionText.Value == "IsActive")
                    ////{
                    //if (Convert.ToInt32(IsAct.Value) == 0)
                    //    Reg.IsActive = 1;
                    //else
                    //    Reg.IsActive = 0;
                    //Reg.DMLs = "IsActive";
                    //Loyalty_Programm.IsActiveDelete(Reg);
                    //Label2.Text = "Service " + Reg.Pro_Name + " Loyalty has been <span style='color:blue;'>" + FindStatus(Reg.IsActive) + "</span> successfully !";
                    ////}                    
                    //filldata();
                    //NewMsgpop.Visible = true;
                    //NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
                    //string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
                    //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                    //return;
                }
                #endregion
            }
            if (e.CommandName == "DeleteRow")
            {
                #region
                ActionText.Value = "IsDelete";
                Loyalty_Programm Reg = new Loyalty_Programm();
                Reg.Pro_ID = " AND m.Pro_ID = '" + lblproiddel.Text + "'";
                Reg.Comp_ID = CompID;
                DataSet ds = Loyalty_Programm.FetchSearchData(Reg);
                if (ds.Tables[0].Rows.Count > 0)
                {

                    IsAct.Value = ds.Tables[0].Rows[0]["IsActive"].ToString();
                    currindex.Value = ds.Tables[0].Rows[0]["RowId"].ToString();
                    Reg.RowId = Convert.ToInt64(currindex.Value);
                   
                    Reg.IsDelete = 1;
                    Reg.DMLs = "IsDelete";
                    Reg.Subscribe_Id = ssID;
                    Loyalty_Programm.IsActiveDelete(Reg);
                    Label2.Text = "Product " + Reg.Pro_Name + " has been deleted successfully !";
                    //}
                    filldata();
                    NewMsgpop.Visible = true;
                    NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
                    string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                }
                else
                {
                    Reg.IsDelete = 1;
                    Reg.DMLs = "IsDelete";
                    Reg.Subscribe_Id = ssID;
                    Loyalty_Programm.IsActiveDelete(Reg);
                    Label2.Text = "Product " + Reg.Pro_Name + " has been deleted successfully !";
                    //}
                    filldata();
                    NewMsgpop.Visible = true;
                    NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
                    string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                }
                #endregion
            }
            else if (e.CommandName == "Verify")
            {
                FillDropdown();
                selsubid.Value = e.CommandArgument.ToString();
                lblproidamc.Value = lblproiddel.Text;
                Loyalty_Programm Reg = new Loyalty_Programm();
                Reg.Pro_ID = "";
                Reg.Comp_ID = CompID;
                Reg.Subscribe_Id = " AND t.Subscribe_Id  = '" + e.CommandArgument.ToString() + "'";
                DataTable ddt = Loyalty_Programm.FillServiceSubscription(Reg).Tables[0];
                if (ddt.Rows.Count > 0)
                {
                    HdValAMC1.Value = ddt.Rows[0]["PlanMasterPeriod"].ToString();
                    lblplannameview.Text = ddt.Rows[0]["PlanName"].ToString();
                    lblproiddel.Text = ddt.Rows[0]["Pro_ID"].ToString(); hddnProId.Value = lblproiddel.Text;
                    selsrvid.Value = ddt.Rows[0]["Service_ID"].ToString();
                    fillProductLoyalty(false, ddlProSelect, CompID);
                    Session["Plan_ID"] = ddt.Rows[0]["Plan_ID"].ToString();
                    ddlProSelect.SelectedValue = ddt.Rows[0]["Pro_ID"].ToString();
                    txtdtfromamc1.Text = Convert.ToDateTime(ddt.Rows[0]["DateFrom"]).ToString("dd/MM/yyyy");
                    txtdttoamc1.Text = Convert.ToDateTime(ddt.Rows[0]["DateTo"]).ToString("dd/MM/yyyy");
                    txtPlanAmount.Text = ddt.Rows[0]["PlanMasterPrice"].ToString();
                    txtmPeriod.Text = ddt.Rows[0]["PlanMasterPeriod"].ToString();
                    txtPlanDiscount.Text = ddt.Rows[0]["PlanMasterPrice"].ToString();
                    txtsPeriod.Text = ddt.Rows[0]["PlanMasterPeriod"].ToString();
                    btnAmcRenewal.Text = "Verify";
                    Lblloyaltyhead.Text = "Verify Service";
                    //try
                    //{
                    //    FillPlanMasterGrid(selsrvid.Value, 0);
                    //}
                    //catch (Exception ex)
                    //{
                    //}
                }
                else
                {
                    btnAmcRenewal.Text = "Verify";
                    Lblloyaltyhead.Text = "Verify Service";
                }
                ModalPopupExtenderGridView.Show();
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void CheckforUpdate(object sender, EventArgs e)
    {
        Int64 OldPoints = Convert.ToInt64(hdnpointsval.Value);
        Int64 NewPoints = Convert.ToInt64(txtloyaltypoints.Text);
        if (OldPoints <= NewPoints)
        {
            txtloyaltypoints.Text = NewPoints.ToString();
            DivMsg.Visible = false;
        }
        else
        {
            LblMsgBody.Text = "Points not update is less than old points " + OldPoints;
            DivMsg.Visible = true;
            DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
            string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            txtloyaltypoints.Text = OldPoints.ToString();
        }
        ModalPopupLoyalty.Show();
    }
    private void ChangeUpdateFields(bool check)
    {

    }
    private bool GetUpdate(string Pro_ID, DateTime DateTime)
    {
        DataTable dt = SQL_DB.ExecuteDataSet("SELECT  RowId, Comp_ID, Pro_ID, User_ID, Code1, Code2, Points, Type, Entry_Date, Mode, IsCashConvert, IsUse FROM  T_Points WHERE Pro_ID='" + Pro_ID + "' AND CONVERT(VARCHAR,Entry_Date,111) >= '" + Convert.ToDateTime(DateTime).ToString("yyyy/MM/dd") + "' ").Tables[0];
        if (dt.Rows.Count > 0)
            return false;
        else
            return true;
    }
    private void ChnageValidation(bool Flag)
    {
        if (Flag)
        {
            FileDownHindi.Visible = false; FileDownEnglish.Visible = false;
            RFVIsSoundH.ValidationGroup = "LOY";
            RFVIsSoundE.ValidationGroup = "LOY";
        }
        else
        {
            FileDownHindi.Visible = true; FileDownEnglish.Visible = true;
            RFVIsSoundH.ValidationGroup = "NA";
            RFVIsSoundE.ValidationGroup = "NA";
        }
    }
    protected void GrdProductMaster_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        NewMsgpop.Visible = false;
        GrdProductMaster.PageIndex = e.NewPageIndex;
        filldata();
    }
    protected void btnAddServices_Click(object sender, EventArgs e)
    {
        Loyalty_Programm Reg = new Loyalty_Programm();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.Pro_ID = ddlProduct.SelectedValue.ToString();
        Reg.Service_ID = selsrvid.Value;
        Reg.ServiceTransId = Convert.ToInt64(selsrvplanid.Value);
        if (txtloyaltydtfrom.Text != "")
            Reg.DateFrom = Convert.ToDateTime(txtloyaltydtfrom.Text).ToString("yyyy/MM/dd hh:mm:ss tt");
        else
            Reg.DateFrom = null;
        if (txtloyaltydtto.Text != "")
            Reg.DateTo = Convert.ToDateTime(txtloyaltydtto.Text).ToString("yyyy/MM/dd hh:mm:ss tt");
        else
            Reg.DateTo = null;
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        if (chkconvert.Checked)
            Reg.IsCashConvert = 0;
        else
            Reg.IsCashConvert = 1;
        if (txtfrequency.Text.Trim().Replace("'", "''") != "")
            Reg.Frequency = Convert.ToInt32(txtfrequency.Text.Trim().Replace("'", "''"));
        else
            Reg.Frequency = 1;
        if (txtloyaltypoints.Text != "")
            Reg.Points = Convert.ToDecimal(txtloyaltypoints.Text);
        else
            Reg.Points = 0;
        Reg.Comments = txtCommentsTxt.Text.Trim().Replace("'", "''");
        if (btnSave.Text == "Save")
        {
            Reg.RowId = 0;
            Reg.DML = "I";
            Label2.Text = "Loyalty Programm saved successfully fot this Product!";
            selsrvid.Value = string.Empty;
        }
        else
        {
            //Reg.RowId = Convert.ToInt32(lblproiddel.Text);
            Reg.DML = "U";
            Reg.RowId = Convert.ToInt32(currindex.Value);
            Label2.Text = "Loyalty Programm saved successfully fot this Product!";
            selsrvid.Value = string.Empty;
        }
        Loyalty_Programm.InsUpdSrvForProduct(Reg);
        //Loyalty_Programm.InsertUpdateLoyalty(Reg);
        string path = Server.MapPath("../Data/Sound");
        if (flSoundH.FileName != "")
        {
            path = Server.MapPath("../Data/Sound");
            path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + Reg.RowId;
            DataProvider.Utility.CreateDirectory(path);
            path = path + "\\" + Reg.RowId + "_H.wav";
            flSoundH.SaveAs(path);
            Reg.DMLs = "H";
            Loyalty_Programm.UpdateFiles(Reg);
        }
        if (flSoundE.FileName != "")
        {
            path = Server.MapPath("../Data/Sound");
            path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + Reg.RowId;
            DataProvider.Utility.CreateDirectory(path);
            path = path + "\\" + Reg.RowId + "_E.wav";
            flSoundE.SaveAs(path);
            Reg.DMLs = "E";
            Loyalty_Programm.UpdateFiles(Reg);
        }
        ClearText();
        NewMsgpop.Visible = true;
        NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
        string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);

    }
    protected void btnYesAlert_Click(object sender, EventArgs e)
    {
        Loyalty_Programm Reg = new Loyalty_Programm();
        Reg.Subscribe_Id = lblproiddel.Text;
        if (ActionText.Value == "IsActive")
        {
            if (Convert.ToInt32(IsAct.Value) == 0)
                Reg.IsActive = 1;
            else
                Reg.IsActive = 0;
            Reg.DMLs = "IsActive";
            Loyalty_Programm.IsActiveDelete(Reg);
            Label2.Text = "Product " + Reg.Pro_Name + " has been <span style='color:blue;'>" + FindStatus(Reg.IsActive) + "</span> successfully !";
            SendEmail(Reg);
        }
        else if (ActionText.Value == "IsDelete")
        {
            Reg.IsDelete = 1;
            Reg.DMLs = "IsDelete";
            Loyalty_Programm.IsActiveDelete(Reg);
            Label2.Text = "Product " + Reg.Pro_Name + " has been deleted successfully !";
        }
        filldata();
        NewMsgpop.Visible = true;
        NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
        string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }
    protected void btnNoAlert_Click(object sender, EventArgs e)
    {

    }
    protected void PlanGridViewDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        selsrvplanid.Value = e.CommandArgument.ToString();
        if (e.CommandName.ToString() == "BuyService")
        {
            string ServiceId = selsrvid.Value;
            CheckValidation(ServiceId);

            ClearText(); NewMsgpop.Visible = false;
            fillProductLoyalty(true, ddlProduct, "");
            if (ddlProduct.SelectedIndex > 0)
            {
                DataTable ddt = SQL_DB.ExecuteDataSet("SELECT RowId, Comp_ID, Pro_ID, Points,IsCashConvert, DateFrom, DateTo, IsActive, IsDelete FROM M_Loyalty WHERE Pro_ID = '" + ddlProduct.SelectedValue.ToString() + "' ").Tables[0];
                if (ddt.Rows.Count > 0)
                {
                    if (Convert.ToInt32(ddt.Rows[0]["IsCashConvert"]) == 0)
                        chkconvert.Checked = true;
                    else
                        chkconvert.Checked = false;
                    hdnloyalty.Value = ddt.Rows[0]["Pro_ID"].ToString();
                    txtloyaltypoints.Text = ddt.Rows[0]["Points"].ToString();
                    txtloyaltydtfrom.Text = ddt.Rows[0]["DateFrom"].ToString();
                    txtloyaltydtto.Text = ddt.Rows[0]["DateTo"].ToString();
                    btnSave.Text = "Update";
                    //Lblloyaltyhead.Text = "Update Loyalty";
                }
                else
                {
                    btnSave.Text = "Save";
                    //Lblloyaltyhead.Text = "Add Loyalty";
                }
            }
            else
            {
                btnSave.Text = "Save";
                //Lblloyaltyhead.Text = "Add Loyalty";
            }
            ModalPopupLoyalty.Show();
        }
    }
    private void FillPlanMasterGrid(string ServiceId, int disp)
    {

        DataTable dt = SQL_DB.ExecuteDataSet("SELECT " + disp + " AS Disp, Plan_ID, Service_ID,(SELECT ServiceName FROM M_Service WHERE Service_ID = M_ServicePlan.Service_ID) ServiceName, PlanName, PlanPeriod, PlanPrice, EntryDate, IsActive, IsDelete FROM M_ServicePlan WHERE Service_ID = '" + ServiceId + "' AND IsActive = 0 AND IsDelete = 0 ").Tables[0];
        if (dt.Rows.Count > 0)
            lblplgrw.Text = dt.Rows[0]["ServiceName"].ToString();
        PlanGridViewDetails.DataSource = dt;
        PlanGridView.DataBind();
    }
    private void SendEmail(Loyalty_Programm Reg)
    {
        #region Data for Main
        string CompID="", CompName = "", ContactPerson = "", CompEmail = "", ProName = "", ServiceName = "", PlanName = "", dtfrom = "", dtto = "", PlanSalePeriod = "", PlanSalePrice = "";
        DataTable sdt = SQL_DB.ExecuteDataTable("SELECT Comp_ID,PlanSalePeriod,PlanSalePrice,DateFrom,DateTo,(SELECT m.ServiceName from M_Service AS m WHERE m.Service_ID = M_ServiceSubscription.Service_ID) as ServiceName,PlanName,Pro_ID,(SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID=M_ServiceSubscription.Pro_ID) as ProName FROM M_ServiceSubscription WHERE Subscribe_Id = '" + Reg.Subscribe_Id + "'");
        if (sdt.Rows.Count > 0)
        {
            ServiceName = sdt.Rows[0]["ServiceName"].ToString(); PlanName = sdt.Rows[0]["PlanName"].ToString();
            dtfrom = Convert.ToDateTime(sdt.Rows[0]["DateFrom"]).ToString("dd/MM/yyyy");
            dtto = Convert.ToDateTime(sdt.Rows[0]["DateTo"]).ToString("dd/MM/yyyy");
            PlanSalePeriod = sdt.Rows[0]["PlanSalePeriod"].ToString();
            PlanSalePrice = sdt.Rows[0]["PlanSalePrice"].ToString();
            ProName = sdt.Rows[0]["ProName"].ToString();
            CompID = sdt.Rows[0]["Comp_ID"].ToString();
        }
        //DataTable prodt = SQL_DB.ExecuteDataTable("SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = '" + Pro_ID + "'");
        //if (prodt.Rows.Count > 0)
        //    ProName = prodt.Rows[0]["Pro_Name"].ToString();
        DataTable desdt = SQL_DB.ExecuteDataTable("SELECT Contact_Person,Comp_Name,Comp_Email FROM Comp_Reg WHERE Comp_ID = '" + CompID + "'");
        if (desdt.Rows.Count > 0)
        {
            CompName = desdt.Rows[0]["Comp_Name"].ToString(); ContactPerson = desdt.Rows[0]["Contact_Person"].ToString(); CompEmail = desdt.Rows[0]["Comp_Email"].ToString();
        }
        string SrvStatus = "";
        if (Reg.IsActive == 1)
            SrvStatus = "Activated";
        else
            SrvStatus = "De-Activated";
        #endregion
        #region Mail
        #region MailBody
        //string InvoiceLink = ""+ ProjectSession.absoluteSiteBrowseUrl +"/beta/Data/Bill/Invoice/" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("dd-MM-yyyy") + "/" + Inv.Invoice_ID + ".pdf";
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
           " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
           " <hr style='border:1px solid #2587D5;'/>" +
           " <div class='w_frame'>" +
           " <p>" +
           " <div class='w_detail'>" +
           " <span>Dear <em><strong>" + ContactPerson + ",</strong></em></span><br />" +
           " <br />" +
           " <span>Product <b>" + ProName + " </b></span><br />" +
           " <br /> Plan Name : " + ServiceName + "  (" + PlanName + ") <br />" +
           " <br /> <b>Plan Period</b> <br />" +
           " <br /> Date From  <b>" + (dtfrom != "" ? Convert.ToDateTime(dtfrom).ToString("dd/MM/yyyy") : "") + " <br /> " +
           " <br /></b>  Date To  <b>" + (dtto != "" ? Convert.ToDateTime(dtto).ToString("dd/MM/yyyy") : "") + "</b><br />" +
           " <br /> Plan Time in Months : " + PlanSalePeriod + " <br />" +
            //" <br /> Plan Amount in Rs. : " + PlanSalePrice + " <br />" +
           " <br /><br /> Your service subscription of above service has been <b>" + SrvStatus + "</b>.<br />" +
            //" <br /> Download your invoice  <a href='" + InvoiceLink + "' target='_blank' >Invoice</a><br />" +
           " <p>" +
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
        string MailBody1 = DataProvider.Utility.FindMailBody(CompName, "Sales department", "Product <b>" + ProName + "'s</b> Service "+ SrvStatus +".");
        string MailBody2 = DataProvider.Utility.FindMailBody(CompName, "Lagal department", "Product <b>" + ProName + "'s</b> Service  " + SrvStatus + ".");
        string MailBody3 = DataProvider.Utility.FindMailBody(CompName, "Account department", "Product <b>" + ProName + "'s</b> Service " + SrvStatus + ".");
        string MailBody4 = DataProvider.Utility.FindMailBody(CompName, "IT department", "Product <b>" + ProName + "'s</b> Service " + SrvStatus + ".");
        #endregion
        string SubjectStr = ServiceName + " service " + SrvStatus + " for " + ProName;
        DataSet dsMl = function9420.FetchMailDetail("admin");
        if (dsMl.Tables[0].Rows.Count > 0)
        {
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), CompEmail, MailBody, SubjectStr);
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Service " + SrvStatus + "");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Legal_accomplishtrades, MailBody2, "Service " + SrvStatus + "");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Service " + SrvStatus + "");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Service " + SrvStatus + "");
        }
        #endregion
    }
}
