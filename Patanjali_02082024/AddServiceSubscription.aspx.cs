using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business_Logic_Layer;
using Business9420;
using System.Web.Services;
using System.Web.Script.Services;
using System.Text;
using System.Data;

public partial class Partner_AddServiceSubscription : System.Web.UI.Page
{
    public string _SubscribeID;
    public string SubscribeID_Prop
    {
        get
        {

            if (ViewState["_SubscribeID"] == null)
            { return ""; }
            else
            {
                return (string)ViewState["_SubscribeID"];
            }

        }
        set { ViewState["_SubscribeID"] = value; }
    }

    public StringBuilder srv = new StringBuilder(); public int vl = 0; public static int sno = 0;
    public int c = 0, str = 0, upplanindex = 0, upamcindex = 0, upofindex = 0, index = 0, pindex = 0, planindex = 0, Disp = 0, promoDisp = 0, dispindex = 0, promoind = 0; public string TransType = "", Comptype = "", LCode = "", PlanID = "", PromoID = ""; public bool LabelFlag = false;
    public int CntDays = 0, IsActive = 0;
    public string srt = DataProvider.Utility.FindMailBody();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["CompanyId"] == null)
            Response.Redirect("../patanjali/loginpfl.aspx?Page=AddServiceSubscription.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        // arb, disable on refresh 
        btnAmcRenewal.Enabled = false;
        if (!Page.IsPostBack)
        {
            Session["Plan_ID"] = "";
            FillDropdown();
            hhdnCompID.Value = Session["CompanyId"].ToString().Substring(5, 4);
            Session["Path"] = Server.MapPath("../Data/Sound");
            if (Request.QueryString["id"] != null)
            {
                SubscribeID_Prop = Convert.ToString(Request.QueryString["id"]);
            }
            if (SubscribeID_Prop != "")
            {
                filldata();
            }

            NewMsgpop.Visible = false;
            //if (Request.QueryString["OP"] != null)
            //    ModalPopupExtenderServices.Show();
        }
    }

    private void FillDropdown()
    {

        Object9420 obj = new Object9420();
        obj.Comp_ID = Session["CompanyId"].ToString();
        // DataSet ds = function9420.FetchRequestProductList(obj);
        // DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlsearchPro, "--Select--");
        // ddlsearchPro.SelectedIndex = 0;
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Service_ID, ServiceName, IsShowPrice, EntryDate, Image, IsActive, IsDelete FROM M_Service  WHERE Service_ID='SRV1018' and IsActive = 0 AND IsDelete = 0");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Service_ID", "ServiceName", ddlService, "--Select--");
        ddlService.SelectedIndex = 0;
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
        // DivMsg.Visible = false;
        // txtfrequency.Text = string.Empty;
        hdnpointsval.Value = string.Empty;
        ChangeUpdateFields(true);
        ChnageValidation(true);
        //txtloyaltydtfrom.Text = string.Empty;
        //txtloyaltydtto.Text = string.Empty;
        //txtloyaltypoints.Text = string.Empty;
        //txtProductName.Text = string.Empty;
        //ddlProduct.SelectedIndex = 0;
        //txtCommentsTxt.Text = string.Empty;
        //chkconvert.Checked = false;
        //txtDateFrom.Text = string.Empty;
        //txtDateTo.Text = string.Empty;
        filldata();
    }

    private void CheckValidation(string ServiceId)
    {
        DataTable dt = SQL_DB.ExecuteDataSet("SELECT Row_ID, Service_ID,(SELECT ServiceName FROM M_Service WHERE Service_ID = M_ServiceFeature.Service_ID) ServiceName, IsPoints, IsDateRange, IsSound, IsFrequency, IsAdditionalGift, IsMessageTemplete, EntryDate, IsDelete FROM M_ServiceFeature WHERE IsDelete = 0 AND Service_ID = '" + ServiceId + "' ").Tables[0];
        if (dt.Rows.Count > 0)
        {
            // Lblloyaltyhead.Text = "Add " + dt.Rows[0]["ServiceName"].ToString();
            int IsPoints = 0, IsDateRange = 0, IsSound = 0, IsFrequency = 0, IsAdditionalGift = 0, IsMessageTemplete = 0;
            IsPoints = Convert.ToInt32(dt.Rows[0]["IsPoints"].ToString());
            IsDateRange = Convert.ToInt32(dt.Rows[0]["IsDateRange"].ToString());
            IsSound = Convert.ToInt32(dt.Rows[0]["IsSound"].ToString());
            IsFrequency = Convert.ToInt32(dt.Rows[0]["IsFrequency"].ToString());
            IsAdditionalGift = Convert.ToInt32(dt.Rows[0]["IsAdditionalGift"].ToString());
            IsMessageTemplete = Convert.ToInt32(dt.Rows[0]["IsMessageTemplete"].ToString());
            //if (IsPoints == 0)
            //{
            //    divispoints.Visible = true;
            //    RFVIsPoints.ValidationGroup = "SRVS";
            //}
            //else
            //{
            //    divispoints.Visible = false;
            //    RFVIsPoints.ValidationGroup = "NN";
            //}
            //if (IsDateRange == 0)
            //{
            //    divisdaterange.Visible = true;
            //    RFVIsDateFrom.ValidationGroup = "SRVS";
            //}
            //else
            //{
            //    divisdaterange.Visible = false;
            //    RFVIsDateFrom.ValidationGroup = "NN";
            //}
            //if (IsSound == 0)
            //{
            //    divissoundComments.Visible = true;
            //    RFVIsMessage.ValidationGroup = "SRVS";
            //    RFVIsSoundH.ValidationGroup = "SRVS";
            //    RFVIsSoundE.ValidationGroup = "SRVS";
            //}
            //else
            //{
            //    divissoundComments.Visible = false;
            //    RFVIsMessage.ValidationGroup = "NN";
            //    RFVIsSoundH.ValidationGroup = "NN";
            //    RFVIsSoundE.ValidationGroup = "NN";
            //}
            //if (IsFrequency == 0)
            //    divisfrequency.Visible = true;
            //else
            //    divisfrequency.Visible = false;

        }
    }

    protected void btnSelectService_Click(object sender, ImageClickEventArgs e)
    {
        //  selsrvid.Value = 
        selsrvid.Value = ((ImageButton)sender).AlternateText;
        txtdtfromamc1.Text = Convert.ToDateTime(System.DateTime.Now).ToString("dd/MM/yyyy");
        // fillProductLoyalty(true, ddlProSelect);
        string ServiceId = selsrvid.Value;
        FillPlanMasterGrid(ServiceId, 0);
        // ModalPopupExtenderGridView.Show();
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
    /// <summary>
    /// Renewal  services 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Submit_Click(object sender, EventArgs e)
    {

        if (ddlService.SelectedItem.Text == "--Select--")
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please Select service first !', 'error');", true);

            return;
        }

        if ((HdValAMC1.Value == "") || (HdValAMC1.Value == null))
        {
            Label8.Text = "Please Select Plan Name";
            Div2.Visible = true;
            Div2.Attributes.Add("class", "alert_boxes_green big_msg");
            string script = @"setTimeout(function(){document.getElementById('" + Div2.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);

            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please Select Plan Name', 'error');", true);

            return;
        }

       
        ObjService Reg = new ObjService();
        Reg.Service_ID = ddlService.SelectedValue; //selsrvid.Value;
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.PlanPeriod = Convert.ToInt64(HdValAMC1.Value);
        DataTable dt = SQL_DB.ExecuteDataSet("SELECT Plan_ID, Service_ID,(SELECT m.ServiceName FROM M_Service AS m WHERE m.Service_ID= M_ServicePlan.Service_ID) as ServiceName, PlanName, PlanPeriod, PlanPrice, EntryDate FROM M_ServicePlan WHERE PlanPeriod = '" + Convert.ToInt32(Reg.PlanPeriod) + "' AND IsActive = 0  AND Service_ID = '" + Reg.Service_ID + "' ").Tables[0];
        if (dt.Rows.Count > 0)
        {
            Reg.Plan_ID = dt.Rows[0]["Plan_ID"].ToString();
            Reg.PlanName = dt.Rows[0]["PlanName"].ToString();
            Reg.PlanMasterPeriod = Convert.ToInt64(dt.Rows[0]["PlanPeriod"]);
            Reg.PlanMasterPrice = Convert.ToInt64(dt.Rows[0]["PlanPrice"]);
            Reg.ServiceName = dt.Rows[0]["ServiceName"].ToString();
        }
        Reg.Pro_ID = ddlProSelect.SelectedValue;
        Reg.DateFrom = Convert.ToDateTime(txtdtfromamc1.Text);
        if (txtdttoamc1.Text == "")
            txtdttoamc1.Text = HdDateTo1.Value;
        Reg.DateTo = Convert.ToDateTime(txtdttoamc1.Text);
        Reg.EntryDate = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        if (btnAmcRenewal.Text == "Submit")
        {
            Reg.IsActive = 1;
            Reg.IsDelete = 0;
            Reg.IsAdminVerify = 1;
            Reg.DML = "I";
        }
        else
        {
            
            Reg.IsAdminVerify = 1;
            Reg.Subscribe_Id = SubscribeID_Prop; //lblproidamc.Value;
            Reg.DML = "U";
        }
        ObjService.InsertUpdateServieSubscription(Reg);
        #region Data for Main
        string CompName = "", ContactPerson = "", CompEmail = "", ProName = "";
        DataTable prodt = SQL_DB.ExecuteDataTable("SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = '" + Reg.Pro_ID + "'");
        if (prodt.Rows.Count > 0)
            ProName = prodt.Rows[0]["Pro_Name"].ToString();
        DataTable desdt = SQL_DB.ExecuteDataTable("SELECT Contact_Person,Comp_Name,Comp_Email FROM Comp_Reg WHERE Comp_ID = '" + Reg.Comp_ID + "'");
        if (desdt.Rows.Count > 0)
        {
            CompName = desdt.Rows[0]["Comp_Name"].ToString(); ContactPerson = desdt.Rows[0]["Contact_Person"].ToString(); CompEmail = desdt.Rows[0]["Comp_Email"].ToString();
        }
        #endregion
        #region Mail
        #region MailBody
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
           " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
           " <hr style='border:1px solid #2587D5;'/>" +
           " <div class='w_frame'>" +
           " <p>" +
           " <div class='w_detail'>" +
           " <span>Dear <em><strong>" + ContactPerson + ",</strong></em></span><br />" +
           " <br />" +
           " <span>Product <b>" + ProName + " </b></span><br />" +
           " <br /> Plan Name : " + Reg.ServiceName + "  (" + Reg.PlanName + ") <br />" +
           " <br /> <b>Plan Period</b> <br />" +
           " <br /> Date From  <b>" + Convert.ToDateTime(Reg.DateFrom).ToString("dd/MM/yyyy") + " <br /> " +
           " <br /></b>  Date To  <b>" + Convert.ToDateTime(Reg.DateTo).ToString("dd/MM/yyyy") + "</b><br />" +
           " <br /> Plan Time in Months : " + Reg.PlanMasterPeriod + " <br />" +
           " <br /><br /> Please wait for confirmation from admin for service subscription.<br />" +
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
        string SubjectStr = Reg.ServiceName + " subscripion request for " + ProName;
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
        lblproidamc.Value = string.Empty;
        btnAmcRenewal.Text = "Submit";

        ScriptManager.RegisterStartupScript(this, GetType(), "Updated", "showAlert('Success', 'Subscribed successfully!', 'success');", true);
        filldata();
        // arb, disable double click hre 
        btnAmcRenewal.Enabled = false;
        Response.Redirect("ServicesSubcription.aspx?mg=s");
    }
    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{

    //}
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        //ModalPopupExtenderServices.Show();
    }
    private int FindOccurence(string substr)
    {
        string reqstr = Request.Form.ToString();
        return ((reqstr.Length - reqstr.Replace(substr, "").Length) / substr.Length);
    }
    //private void RecreateControls(string ctrlPrefix, string ctrlType)
    //{
    //    string[] ctrls = Request.Form.ToString().Split('&');
    //    int cnt = FindOccurence(ctrlPrefix);
    //    if (cnt > 0)
    //    {
    //        Literal lt;
    //        for (int k = 1; k <= cnt; k++)
    //        {
    //            for (int i = 0; i < ctrls.Length; i++)
    //            {
    //                if (ctrls[i].Contains(ctrlPrefix + "-" + k.ToString()))
    //                {
    //                    string ctrlName = ctrls[i].Split('=')[0];
    //                    string ctrlValue = ctrls[i].Split('=')[1];

    //                    //Decode the Value
    //                    ctrlValue = Server.UrlDecode(ctrlValue);

    //                    if (ctrlType == "TextBox")
    //                    {
    //                        TextBox txt = new TextBox();
    //                        txt.ID = ctrlName;
    //                        txt.Text = ctrlValue;
    //                        pnlTextBox.Controls.Add(txt);
    //                        lt = new Literal();
    //                        lt.Text = "<br />";
    //                        pnlTextBox.Controls.Add(lt);
    //                    }

    //                    if (ctrlType == "DropDownList")
    //                    {
    //                        DropDownList ddl = new DropDownList();
    //                        ddl.ID = ctrlName;

    //                        //Rebind Data
    //                        ddl.Items.Add(new ListItem("One", "1"));
    //                        ddl.Items.Add(new ListItem("Two", "2"));
    //                        ddl.Items.Add(new ListItem("Three", "3"));

    //                        //Select the Preselected Item
    //                        ddl.Items.FindByValue(ctrlValue).Selected = true;
    //                        pnlDropDownList.Controls.Add(ddl);
    //                        lt = new Literal();
    //                        lt.Text = "<br />";
    //                        pnlDropDownList.Controls.Add(lt);
    //                    }
    //                    break;
    //                }
    //            }
    //        }
    //    }
    //}
    private void fillProductLoyalty(bool Flag, DropDownList ddlPro, string serviceid)
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        string Qry = "";
        if (Flag)
            Qry = "SELECT Pro_ID, Pro_Name FROM Pro_Reg WHERE (Comp_ID = '" + Reg.Comp_ID + "') AND (Doc_Flag = 1) AND (Sound_Flag = 1) AND (Pro_ID NOT IN (SELECT Pro_ID FROM M_ServiceSubscription WHERE (Comp_ID = Pro_Reg.Comp_ID) AND IsDelete = 0 AND Service_ID = '" + serviceid + "')) ORDER BY Pro_Name";
        else
            Qry = "SELECT Pro_ID, Pro_Name FROM Pro_Reg WHERE (Comp_ID = '" + Reg.Comp_ID + "') AND (Doc_Flag = 1) AND (Sound_Flag = 1) AND (Pro_ID NOT IN (SELECT Pro_ID FROM M_ServiceSubscription WHERE  Pro_ID <> '" + lblproiddel.Text + "' AND (Comp_ID = Pro_Reg.Comp_ID)  AND IsDelete = 0 AND Service_ID = '" + serviceid + "')) ORDER BY Pro_Name";
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
        //  txtDateFrom.Text = ""; txtDateTo.Text = ""; txtProductName.Text = "";
        filldata();
    }

    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        NewMsgpop.Visible = false;
        filldata();
    }
    private void fillProductLoyalty(bool Flag, DropDownList ddlPro)
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
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
    private void filldata()
    {
        selsrvid.Value = SubscribeID_Prop;
        lblproidamc.Value = lblproiddel.Text;
        Loyalty_Programm Reg = new Loyalty_Programm();
        Reg.Pro_ID = "";
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.Subscribe_Id = " AND t.Subscribe_Id  = '" + SubscribeID_Prop + "'";
        DataTable ddt = Loyalty_Programm.FillServiceSubscription(Reg).Tables[0];
        if (ddt.Rows.Count > 0)
        {
            HdValAMC1.Value = ddt.Rows[0]["PlanMasterPeriod"].ToString();
            lblproiddel.Text = ddt.Rows[0]["Pro_ID"].ToString();
            fillProductLoyalty(false, ddlProSelect);
            Session["Plan_ID"] = ddt.Rows[0]["Plan_ID"].ToString();
            selsrvid.Value = ddt.Rows[0]["Service_ID"].ToString();
            ddlService.SelectedValue = selsrvid.Value;
            ddlProSelect.SelectedValue = ddt.Rows[0]["Pro_ID"].ToString();
            txtdtfromamc1.Text = Convert.ToDateTime(ddt.Rows[0]["DateFrom"]).ToString("dd/MM/yyyy");
            txtdttoamc1.Text = Convert.ToDateTime(ddt.Rows[0]["DateTo"]).ToString("dd/MM/yyyy");
            btnAmcRenewal.Text = "Update";
            //  Lblloyaltyhead.Text = "Update Loyalty";
            chkterms.Checked = true;
            try
            {
                FillPlanMasterGrid(selsrvid.Value, 0);
            }
            catch (Exception)
            {

            }
        }
        else
        {
            btnAmcRenewal.Text = "Save";
            //Lblloyaltyhead.Text = "Add Loyalty";
        }
        //  ModalPopupExtenderGridView.Show();

        //Loyalty_Programm obj = new Loyalty_Programm();
        //obj.Comp_ID = Session["CompanyId"].ToString();
        //obj.Pro_Name = txtProductName.Text.Trim().Replace("'", "''");
        //if (ddlsearchSrervice.SelectedIndex > 0)
        //    obj.Service_ID = " AND t.Service_ID = '" + ddlsearchSrervice.SelectedValue + "' ";
        //if (ddlsearchPro.SelectedIndex > 0)
        //    obj.Pro_ID = " AND t.Pro_ID = '" + ddlsearchPro.SelectedValue + "' ";
        //DataSet ds = Loyalty_Programm.FillServiceSubscription(obj);
        //if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        //{
        //    if (ds.Tables[0].Rows.Count > 0)
        //        GrdProductMaster.PageSize = ds.Tables[0].Rows.Count;
        //}
        //else
        //    GrdProductMaster.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        //if (ds.Tables[0].Rows.Count > 0)
        //    GrdProductMaster.DataSource = ds.Tables[0];
        //GrdProductMaster.DataBind();
        //lblcount.Text = GrdProductMaster.Rows.Count.ToString();

        //if (GrdProductMaster.Rows.Count > 0)
        //    GrdProductMaster.HeaderRow.TableSection = TableRowSection.TableHeader;
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        NewMsgpop.Visible = false;
        filldata();
    }
    private string FindStatus(int i)
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
            lblproiddel.Text = e.CommandArgument.ToString();
            lblproidamc.Value = lblproiddel.Text;
            if (e.CommandName == "DeleteRow")
            {
                ActionText.Value = "IsDelete";
                Loyalty_Programm Reg = new Loyalty_Programm();
                Reg.Pro_ID = " AND m.Pro_ID = '" + lblproiddel.Text + "'";
                Reg.Comp_ID = Session["CompanyId"].ToString();
                DataSet ds = Loyalty_Programm.FetchSearchData(Reg);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    //btnNoAlert.Visible = false;
                    //LabelAlertHead.Text = "Alert";
                    //lblalert.Text = " Are you sure to delete the Brand Loyalty Settings of <span style='color:blue;'>" + ds.Tables[0].Rows[0]["Pro_Name"].ToString() + "</span> product ?";
                    //ModalPopupExtenderAlert.Show();

                    IsAct.Value = ds.Tables[0].Rows[0]["IsActive"].ToString();
                    currindex.Value = ds.Tables[0].Rows[0]["RowId"].ToString();
                    Reg.RowId = Convert.ToInt64(currindex.Value);
                    //else if (ActionText.Value == "IsDelete")
                    //{
                    Reg.IsDelete = 1;
                    Reg.DMLs = "IsDelete";
                    Loyalty_Programm.IsActiveDelete(Reg);
                    // Label2.Text = "Product " + Reg.Pro_Name + " has been deleted successfully !";
                    //}
                    filldata();
                    NewMsgpop.Visible = true;
                    NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
                    string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                }
            }
            else if (e.CommandName == "ServiceEdit")
            {
                selsrvid.Value = e.CommandArgument.ToString();
                lblproidamc.Value = lblproiddel.Text;
                Loyalty_Programm Reg = new Loyalty_Programm();
                Reg.Pro_ID = "";
                Reg.Comp_ID = Session["CompanyId"].ToString();
                Reg.Subscribe_Id = " AND t.Subscribe_Id  = '" + e.CommandArgument.ToString() + "'";
                DataTable ddt = Loyalty_Programm.FillServiceSubscription(Reg).Tables[0];
                if (ddt.Rows.Count > 0)
                {
                    HdValAMC1.Value = ddt.Rows[0]["PlanMasterPeriod"].ToString();
                    lblproiddel.Text = ddt.Rows[0]["Pro_ID"].ToString();
                    //fillProductLoyalty(false, ddlProSelect);
                    Session["Plan_ID"] = ddt.Rows[0]["Plan_ID"].ToString();
                    selsrvid.Value = ddt.Rows[0]["Service_ID"].ToString();
                    ddlProSelect.SelectedValue = ddt.Rows[0]["Pro_ID"].ToString();
                    txtdtfromamc1.Text = Convert.ToDateTime(ddt.Rows[0]["DateFrom"]).ToString("dd/MM/yyyy");
                    txtdttoamc1.Text = Convert.ToDateTime(ddt.Rows[0]["DateTo"]).ToString("dd/MM/yyyy");
                    btnAmcRenewal.Text = "Update";
                    //  Lblloyaltyhead.Text = "Update Loyalty";
                    chkterms.Checked = true;
                    try
                    {
                        FillPlanMasterGrid(selsrvid.Value, 0);
                    }
                    catch (Exception ex)
                    {
                    }
                }
                else
                {
                    btnAmcRenewal.Text = "Save";
                    //   Lblloyaltyhead.Text = "Add Loyalty";
                }
                //  ModalPopupExtenderGridView.Show();
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void CheckforUpdate(object sender, EventArgs e)
    {
        //Int64 OldPoints = Convert.ToInt64(hdnpointsval.Value);
        //Int64 NewPoints = Convert.ToInt64(txtloyaltypoints.Text);
        //if (OldPoints <= NewPoints)
        //{
        //    txtloyaltypoints.Text = NewPoints.ToString();
        //    DivMsg.Visible = false;
        //}
        //else
        //{
        //    LblMsgBody.Text = "Points not update is less than old points " + OldPoints;
        //    DivMsg.Visible = true;
        //    DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        //    string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //    txtloyaltypoints.Text = OldPoints.ToString();
        //}
        //ModalPopupLoyalty.Show();
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
        //if (Flag)
        //{
        //    FileDownHindi.Visible = false; FileDownEnglish.Visible = false;
        //    RFVIsSoundH.ValidationGroup = "LOY";
        //    RFVIsSoundE.ValidationGroup = "LOY";
        //}
        //else
        //{
        //    FileDownHindi.Visible = true; FileDownEnglish.Visible = true;
        //    RFVIsSoundH.ValidationGroup = "NA";
        //    RFVIsSoundE.ValidationGroup = "NA";
        //}
    }
    protected void GrdProductMaster_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        NewMsgpop.Visible = false;
        //GrdProductMaster.PageIndex = e.NewPageIndex;
        filldata();
    }
    protected void btnAddServices_Click(object sender, EventArgs e)
    {
        //Loyalty_Programm Reg = new Loyalty_Programm();
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //Reg.Pro_ID = ddlProduct.SelectedValue.ToString();
        //Reg.Service_ID = selsrvid.Value;
        //Reg.ServiceTransId = Convert.ToInt64(selsrvplanid.Value);
        //if (txtloyaltydtfrom.Text != "")
        //    Reg.DateFrom = Convert.ToDateTime(txtloyaltydtfrom.Text).ToString("yyyy/MM/dd hh:mm:ss tt");
        //else
        //    Reg.DateFrom = null;
        //if (txtloyaltydtto.Text != "")
        //    Reg.DateTo = Convert.ToDateTime(txtloyaltydtto.Text).ToString("yyyy/MM/dd hh:mm:ss tt");
        //else
        //    Reg.DateTo = null;
        //Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        //if (chkconvert.Checked)
        //    Reg.IsCashConvert = 0;
        //else
        //    Reg.IsCashConvert = 1;
        //if (txtfrequency.Text.Trim().Replace("'", "''") != "")
        //    Reg.Frequency = Convert.ToInt32(txtfrequency.Text.Trim().Replace("'", "''"));
        //else
        //    Reg.Frequency = 1;
        //if (txtloyaltypoints.Text != "")
        //    Reg.Points = Convert.ToDecimal(txtloyaltypoints.Text);
        //else
        //    Reg.Points = 0;
        //Reg.Comments = txtCommentsTxt.Text.Trim().Replace("'", "''");
        //if (btnSave.Text == "Save")
        //{
        //    Reg.RowId = 0;
        //    Reg.DML = "I";
        //    Label2.Text = "Loyalty Programm saved successfully fot this Product!";
        //    selsrvid.Value = string.Empty;
        //}
        //else
        //{
        //    //Reg.RowId = Convert.ToInt32(lblproiddel.Text);
        //    Reg.DML = "U";
        //    Reg.RowId = Convert.ToInt32(currindex.Value);
        //    Label2.Text = "Loyalty Programm saved successfully fot this Product!";
        //    selsrvid.Value = string.Empty;
        //}
        //// Loyalty_Programm.InsUpdSrvForProduct(Reg);
        ////Loyalty_Programm.InsertUpdateLoyalty(Reg);
        //string path = Server.MapPath("../Data/Sound");
        //if (flSoundH.FileName != "")
        //{
        //    path = Server.MapPath("../Data/Sound");
        //    path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + Reg.RowId;
        //    DataProvider.Utility.CreateDirectory(path);
        //    path = path + "\\" + Reg.RowId + "_H.wav";
        //    flSoundH.SaveAs(path);
        //    Reg.DMLs = "H";
        //    Loyalty_Programm.UpdateFiles(Reg);
        //}
        //if (flSoundE.FileName != "")
        //{
        //    path = Server.MapPath("../Data/Sound");
        //    path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + Reg.RowId;
        //    DataProvider.Utility.CreateDirectory(path);
        //    path = path + "\\" + Reg.RowId + "_E.wav";
        //    flSoundE.SaveAs(path);
        //    Reg.DMLs = "E";
        //    Loyalty_Programm.UpdateFiles(Reg);
        //}
        //ClearText();
        //NewMsgpop.Visible = true;
        //NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
        //string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);

    }
    protected void btnYesAlert_Click(object sender, EventArgs e)
    {
        Loyalty_Programm Reg = new Loyalty_Programm();
        Reg.RowId = Convert.ToInt64(currindex.Value);
        if (ActionText.Value == "IsActive")
        {
            if (Convert.ToInt32(IsAct.Value) == 0)
                Reg.IsActive = 1;
            else
                Reg.IsActive = 0;
            Reg.DMLs = "IsActive";
            Loyalty_Programm.IsActiveDelete(Reg);
            //  Label2.Text = "Product " + Reg.Pro_Name + " has been <span style='color:blue;'>" + FindStatus(Reg.IsActive) + "</span> successfully !";
        }
        else if (ActionText.Value == "IsDelete")
        {
            Reg.IsDelete = 1;
            Reg.DMLs = "IsDelete";
            Loyalty_Programm.IsActiveDelete(Reg);
            //  Label2.Text = "Product " + Reg.Pro_Name + " has been deleted successfully !";
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
            string ServiceId = ddlService.SelectedValue; // selsrvid.Value;
            CheckValidation(ServiceId);

            ClearText(); NewMsgpop.Visible = false;
            // fillProductLoyalty(true, ddlProduct);
            //if (ddlProduct.SelectedIndex > 0)
            //{
            //    DataTable ddt = SQL_DB.ExecuteDataSet("SELECT RowId, Comp_ID, Pro_ID, Points,IsCashConvert, DateFrom, DateTo, IsActive, IsDelete FROM M_Loyalty WHERE Pro_ID = '" + ddlProduct.SelectedValue.ToString() + "' ").Tables[0];
            //    if (ddt.Rows.Count > 0)
            //    {
            //        if (Convert.ToInt32(ddt.Rows[0]["IsCashConvert"]) == 0)
            //            chkconvert.Checked = true;
            //        else
            //            chkconvert.Checked = false;
            //        hdnloyalty.Value = ddt.Rows[0]["Pro_ID"].ToString();
            //        txtloyaltypoints.Text = ddt.Rows[0]["Points"].ToString();
            //        txtloyaltydtfrom.Text = ddt.Rows[0]["DateFrom"].ToString();
            //        txtloyaltydtto.Text = ddt.Rows[0]["DateTo"].ToString();
            //        btnSave.Text = "Update";
            //        //Lblloyaltyhead.Text = "Update Loyalty";
            //    }
            //    else
            //    {
            //        btnSave.Text = "Save";
            //        //Lblloyaltyhead.Text = "Add Loyalty";
            //    }
            //}
            //else
            //{
            //    btnSave.Text = "Save";
            //    //Lblloyaltyhead.Text = "Add Loyalty";
            //}
            //ModalPopupLoyalty.Show();
        }
    }
    private void FillPlanMasterGrid(string ServiceId, int disp)
    {

        DataTable dt = SQL_DB.ExecuteDataSet("SELECT " + disp + " AS Disp, Plan_ID, Service_ID,(SELECT ServiceName FROM M_Service WHERE Service_ID = M_ServicePlan.Service_ID) ServiceName, PlanName, PlanPeriod, PlanPrice, EntryDate, IsActive, IsDelete FROM M_ServicePlan WHERE Service_ID = '" + ServiceId + "' AND IsActive = 0 AND IsDelete = 0 ").Tables[0];
        if (dt.Rows.Count > 0)
            lblplgrw.Text = dt.Rows[0]["ServiceName"].ToString();
        PlanGridViewDetails.DataSource = dt;
        PlanGridViewDetails.DataBind();
        string srvId = ddlService.SelectedValue; //selsrvid.Value;
        Int32 showflag = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT IsShowPrice FROM  M_Service WHERE Service_ID ='" + srvId + "'"));
        if (showflag == 0)
            PlanGridViewDetails.Columns[3].Visible = true;
        else
            PlanGridViewDetails.Columns[3].Visible = false;
    }

    protected void ddlService_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlService.SelectedValue != "0")
        {
            fillProductLoyalty(true, ddlProSelect, ddlService.SelectedValue);
            txtdtfromamc1.Text = Convert.ToDateTime(System.DateTime.Now).ToString("dd/MM/yyyy");
            FillPlanMasterGrid(ddlService.SelectedValue, 0);
        }

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("ServicesSubcription.aspx");
    }
}