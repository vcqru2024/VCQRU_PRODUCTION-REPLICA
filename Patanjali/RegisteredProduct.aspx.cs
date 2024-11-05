using Business9420;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Partner_RegisteredProduct : System.Web.UI.Page
{
    public string server = Convert.ToString(ConfigurationManager.ConnectionStrings["ServerName"].ConnectionString), userID = Convert.ToString(ConfigurationManager.ConnectionStrings["UserName"].ConnectionString), password = Convert.ToString(ConfigurationManager.ConnectionStrings["Password"].ConnectionString);
    public int c = 0, str = 0, upplanindex = 0, upamcindex = 0, upofindex = 0, index = 0, pindex = 0, planindex = 0, Disp = 0, promoDisp = 0, dispindex = 0, promoind = 0; public string TransType = "", Comptype = "", LCode = "", PlanID = "", PromoID = ""; public bool LabelFlag = false;
    public int CntDays = 0, IsCancel = 0, Loyalty = 0;
    public string srt = DataProvider.Utility.FindMailBody();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../patanjali/loginpfl.aspx?Page=RegisteredProduct.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("../patanjali/loginpfl.aspx");
        }
        if (!Page.IsPostBack)
        {
            hhdnCompID.Value = Session["CompanyId"].ToString().Substring(5, 4);
            Session["Path"] = Server.MapPath("../Data/Sound");
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            
            filldata(); Session["LabelCode"] = ""; Session["Plan_ID"] = ""; Session["PromoId"] = ""; Session["BeyondOffer"] = "";
          //  FillLabelDetGrd();
           
           
        }
    }


    private void filldata()
    {
        Object9420 obj = new Object9420();
        obj.Comp_ID = Session["CompanyId"].ToString();
     //   obj.Pro_Name = txtProductName.Text.Trim().Replace("'", "''");
        obj.Pro_ID = "";
        //DataSet ds = function9420.FetchData(obj);
        DataSet ds = function9420.FetchSearchData(obj);
        
        if (ds.Tables[0].Rows.Count > 0)
            GrdProductMaster.DataSource = ds.Tables[0];
        GrdProductMaster.DataBind();

        if (GrdProductMaster.Rows.Count > 0)
            GrdProductMaster.HeaderRow.TableSection = TableRowSection.TableHeader;
        lblcount.Text = GrdProductMaster.Rows.Count.ToString();
    }



    protected void btnYesAlert_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Pro_ID = lblproiddel.Text;
        Reg.Comp_ID = Session["CompanyId"].ToString();
        string path = "";
        DataSet dsS = SQL_DB.ExecuteDataSet("SELECT [Row_ID],[Pro_ID] FROM  T_Pro WHERE  [Pro_ID] = '" + Reg.Pro_ID + "' ");
        for (int i = 0; i < dsS.Tables[0].Rows.Count; i++)
        {
            path = Server.MapPath("../Data/Sound");
            path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\" + dsS.Tables[0].Rows[i]["Row_ID"].ToString();
            DataProvider.Utility.DeleteDirectory(path);
        }
        path = Server.MapPath("../Data/Sound");
        path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + Reg.Pro_ID;
        DataProvider.Utility.DeleteDirectory(path);
        function9420.ProductReset(Reg);
        ChangeValidationGroup(true);
        filldata();
        NewMsgpop.Visible = true;
        NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
        Label2.Text = "Product " + Reg.Pro_Name + " has been deleted successfully !";
        string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }


    private void ChangeValidationGroup(bool str)
    {
        if (str == true)
        {
            //RequiredFieldValidator522.ValidationGroup = "chk94";
            //RequiredFieldValidatorfile.ValidationGroup = "chk94";
        }
        else
        {
            //RequiredFieldValidator522.ValidationGroup = "NO";
            //RequiredFieldValidatorfile.ValidationGroup = "NO";
        }
    }

    protected void btnNoAlert_Click(object sender, EventArgs e)
    {

    }
    protected void GrdProductMaster_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        NewMsgpop.Visible = false;
        GrdProductMaster.PageIndex = e.NewPageIndex;
        filldata();
    }


    protected void GrdProductsAmc_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            #region
            GridViewRow gvr = (GridViewRow)((ImageButton)e.CommandSource).NamingContainer;
            currindex.Value = gvr.RowIndex.ToString();
            DivNewMsg1.Attributes.Add("class", "");
            LabelAmcRenewalmsg.Text = "";
            Object9420 Amc = new Object9420();
            string[] Arr = e.CommandArgument.ToString().Split('-');
            HdnUpdatePlanID.Value = Arr[1].ToString();
            HdnUpdatePlanType.Value = Arr[2].ToString();
            HdnUpdatePlanTransID.Value = Arr[0].ToString();
            Amc.Trans_Type = Arr[2].ToString();
            Amc.Row_ID = Arr[0].ToString();
            if (Arr[2].ToString() == "AMC")
                Session["Plan_ID"] = Arr[1].ToString();
            else if (Arr[2].ToString() == "Offer")
                Session["PromoId"] = Arr[1].ToString();
            Amc.Pro_ID = lblproiddel.Text;
            Amc.Trans_Type = Arr[2].ToString();
            Business9420.function9420.FillData(Amc);
            HdnUpdatePlanStatus.Value = Amc.Status.ToString();
            HdnUpdatePlanTime.Value = Amc.Plan_Time.ToString();
            #endregion
            if ((Amc.Status == -1) || (Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd")) >= Convert.ToDateTime(Convert.ToDateTime(Amc.DateToChk).ToString("yyyy/MM/dd"))))
            {
                NewMsgpop.Visible = true;
                NewMsgpop.Attributes.Add("class", "alert_boxes_pink big_msg");
                Label2.Text = "Action is not allowed, This plan has been expired on  " + Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
            }
            else
            {
                if (e.CommandName.ToString() == "UpgradePlan")
                {
                    if (Amc.Trans_Type.ToString() == "AMC")
                    {
                        #region
                        btnAmcRenewal.Visible = true;
                        btnAmcRenewal.Text = "Update";
                        btnOfferRenewal.Visible = false;
                        MyAmcOfferGrdVw.Visible = true;
                        MyOfferGrdVw.Visible = false;
                        lblAmcText.Visible = true;
                        lblAmcText.Visible = true;
                        lblAmcenddate.Text = Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
                        FillPlanGrdAmcRenewal(Amc);
                        txtdttoamc1.Text = Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
                        txtdtfromamc1.Text = Convert.ToDateTime(Amc.DateFromChk).ToString("dd/MM/yyyy");
                        #endregion
                    }
                    else if (Amc.Trans_Type.ToString() == "Offer")
                    {
                        #region
                        Amc.Amt_Type = Amc.Trans_Type;
                        if (Session["PromoId"] != null)
                        {
                            Amc.Promo_Id = Session["PromoId"].ToString();
                            HdValAMC3.Value = function9420.GetPlanTime(Amc);
                        }
                        else
                            return;
                        string path = "../Data/Sound";
                        //path = Server.MapPath("../Data/Sound");
                        path = path + "\\" + Amc.Comp_ID.ToString().Substring(5, 4) + "\\" + Amc.Pro_ID + "\\" + Amc.TransRow_ID;
                        //DataProvider.Utility.CreateDirectory(path);
                        btnOfferRenewal.Visible = true;
                        if (Convert.ToInt32(Amc.Status) == 0)
                        {
                            btnOfferRenewal.Text = "Update";
                            txtdtfromamc3.Enabled = true;
                        }
                        else if (Convert.ToInt32(Amc.Status) == 1)
                        {
                            btnOfferRenewal.Text = "Update";
                            txtdtfromamc3.Enabled = false;
                        }
                        else
                        {
                            btnOfferRenewal.Text = "Update";
                            txtdtfromamc3.Enabled = true;
                        }
                        btnAmcRenewal.Visible = false;
                        MyAmcOfferGrdVw.Visible = false;
                        MyOfferGrdVw.Visible = true;
                        lblAmcText.Visible = false;
                        A1.Attributes.Add("style", "display:block;");
                        A1.HRef = path + "\\" + Amc.TransRow_ID + "_H.wav";
                        A2.Attributes.Add("style", "display:block;");
                        A2.HRef = path + "\\" + Amc.TransRow_ID + "_E.wav";
                        txtComment.Text = Amc.Comment_Txt;
                        //FillPlanGrdAmcRenewal(0);
                        FillGridChkPromotional(1, GrdVwOfferDetails);
                        txtdttoamc3.Text = Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
                        HdDateTo3.Value = Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
                        txtdtfromamc3.Text = Convert.ToDateTime(Amc.DateFromChk).ToString("dd/MM/yyyy");
                      //  CheckValidation(true);
                        #endregion
                    }
                }
                else if (e.CommandName.ToString() == "CancelPlan")
                {
                    LabelExectute.Text = e.CommandName.ToString();
                    details.Visible = true;
                    Table1.Visible = true;
                    txtremarks.Text = string.Empty;
                    remarks.Visible = true;
                    GPHeadLabel.Text = "Product (<span style='color:blue;'>" + Amc.Pro_Name + "</span>)";
                    lblMsgAlert.Text = "Are you sure to cancelled <span style='color:blue;'>" + Amc.Pro_Name + "</span> >> this Offer with Invoice.";
                    lblstdate.Text = Convert.ToDateTime(Amc.DateFromChk).ToString("dd/MM/yyyy");
                    lblenddate.Text = Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
                    ModalPopupForGp.Show();
                }
                ModalPopupAmcRenewal.Show();
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message.ToString());
        }
    }


    protected void btnbeyondoffer_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        DataTable dt = (DataTable)Session["BeyondOffer"];
        if (dt.Rows.Count > 0)
        {
            Reg.Comp_ID = Session["CompanyId"].ToString();
            Reg.Pro_ID = lblproiddel.Text;
            Reg.Head_Name = "Offer";
            Reg.Cancelled_By = Session["User_Type"].ToString() + " ( " + DataProvider.TransType.Offer_Cancelled_By_Manufacturer.ToString() + ")";
            Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            Reg.Remarks = DataProvider.TransType.Offer_Cancelled_By_Manufacturer_Beacause_This_Offer_Beyond_To_My_AMC_Plan.ToString();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Reg.Head_ID = dt.Rows[i]["Amc_Offer_ID"].ToString();
                function9420.CancelledAmcOfferPlan(Reg);
                //SQL_DB.ExecuteNonQuery("UPDATE [M_Amc_Offer] SET [IsCancel] =  0 WHERE Amc_Offer_ID = '" + dt.Rows[i]["Amc_Offer_ID"].ToString() + "' ");
                //SQL_DB.ExecuteNonQuery("INSERT INTO [M_Amc_Offer_Cancelled] ([Amc_Offer_ID],[Entry_Date],[Cancelled_By],[Remarks])  VALUES ('" + dt.Rows[i]["Amc_Offer_ID"].ToString() + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "','" + Session["User_Type"].ToString() + " ( " + DataProvider.TransType.Offer_Cancelled_By_Manufacturer.ToString() + " )','" + DataProvider.TransType.Offer_Cancelled_By_Manufacturer_Beacause_This_Offer_Beyond_To_My_AMC_Plan.ToString() + "') ");
                //SQL_DB.ExecuteNonQuery("UPDATE [M_Invoice] SET [Status] = 0 WHERE [Comp_ID] = '" + Session["CompanyId"].ToString() + "'' AND [Pro_ID] = '" + lblproiddel.Text + "' AND [Head_ID] = '" + dt.Rows[i]["Amc_Offer_ID"].ToString() + "' AND [Head_Name] = 'Offer'");
                // THIS CODE REPLACE TO PROCEDURE
            }
        }
    }


    protected void btnLoyalty_Click(object sender, EventArgs e)
    {
      
    }

    protected void btnYes_Click(object sender, EventArgs e)
    {
        if (LabelExectute.Text.ToString() == "CancelPlan")
        {
            Object9420 Reg = new Object9420();
            Reg.Comp_ID = Session["CompanyId"].ToString();
            Reg.Pro_ID = lblproiddel.Text;
            Reg.Head_Name = "Offer";
            Reg.Cancelled_By = Session["User_Type"].ToString() + " ( " + DataProvider.TransType.Cancelled.ToString() + ")";
            Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            Reg.Remarks = txtremarks.Text.Trim().Replace("'", "''");
            Reg.Head_ID = HdnUpdatePlanTransID.Value.ToString();
            function9420.CancelledAmcOfferPlan(Reg);
            //lblstdate.Text lblenddate.Text  
            TimeSpan t = new TimeSpan(); int useday = 0;
            if (Convert.ToDateTime(Convert.ToDateTime(lblstdate.Text).ToString("yyyy/MM/dd")) <= Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd")))
            {
                t = Convert.ToDateTime(lblstdate.Text) - Convert.ToDateTime(DataProvider.LocalDateTime.Now);
                useday = Math.Abs(t.Days) + 1;
            }
            else if (Convert.ToDateTime(Convert.ToDateTime(lblstdate.Text).ToString("yyyy/MM/dd")) > Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd")))
            {
                useday = 0;
            }
            //************************* Code start For Generate Invoice ******************//
            if (function9420.CheckForGenerateInvoice(Reg.Pro_ID))
            {
                Object9420 Inv = new Object9420();
                Inv.Head_Name = "Offer";
                Inv.TotalTime = Convert.ToInt32(HdnUpdatePlanTime.Value);
                Inv.Time_Days = useday;
                Inv.Comp_ID = Reg.Comp_ID;
                Inv.Pro_ID = Reg.Pro_ID;
                Inv.Plan_ID = Reg.Head_ID.ToString();
                Inv.FolderPath = Server.MapPath("../Data/Bill");
                Inv.Path = Server.MapPath("../Reports") + "\\RefundInvoiceReport.rpt";
                function9420.CreateRefundInvoice(Inv);
            }
            //************************* Code end For Generate Invoice ******************//

            NewMsgpop.Visible = true;
            NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
            Label2.Text = "Product Offer has been cancelled successfully with Invoice !";
            string script1 = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
            lblproiddel.Text = string.Empty; HdDateTo3.Value = string.Empty; txtdttoamc3.Text = string.Empty; HdnUpdatePlanTransID.Value = string.Empty; LabelExectute.Text = string.Empty;
            filldata();
        }
      
    }

    protected void btnYesConfirm_Click(object sender, EventArgs e)
    {
        SQL_DB.ExecuteNonQuery("UPDATE M_Label_Request SET Flag = 2 FROM M_Label_Request WHERE Pro_ID = '" + lblproid.Value + "' AND  Flag = 0 ");
        newmsg.Visible = true;
        newmsg.Attributes.Add("class", "alert_boxes_green big_msg");
        lblmsgHeader.Text = "All pending request calceled successfully !";
        //tabmenu.ActiveTabIndex = 3;
        ModalPopupExtender1.Show();
        string script = @"setTimeout(function(){document.getElementById('" + newmsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }

    private string FindPlanPromoId()
    {
        string slbl = "";
        if (Request.Form["rdPromo"] != null)
        {
            string[] Arr = Request.Form["rdPromo"].ToString().Split(',');
            slbl = Arr[0].ToString();
        }
        else
            slbl = "";
        HdPromoId.Value = slbl;
        return slbl;
    }


    protected void btnOfferRenewal_Click(object sender, EventArgs e)
    {
        Object9420 Amc = new Object9420();
        Amc.Pro_ID = lblproiddel.Text;
        Amc.Comp_ID = Session["CompanyId"].ToString();
        Amc.OldPromo_Id = HdnUpdatePlanID.Value;
        if (HdnUpdatePlanTransID.Value != "")
            Amc.Row_ID = HdnUpdatePlanTransID.Value;
        else
            Amc.Row_ID = "0";
        Amc.Trans_Type = "Offer";
        Business9420.function9420.FillData(Amc);
        Amc.Manage_By = Session["User_Type"].ToString();
        Amc.AmcOfferRemarks = null;
        if (Amc.Status == -1)
        {
            NewMsgpop.Visible = true;
            NewMsgpop.Attributes.Add("class", "alert_boxes_pink big_msg");
            Label2.Text = "Action is not allowed, This plan has been expired on  " + Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
            return;
        }
        else
        {
            DivNewMsg1.Visible = false; string slblplan = "";
            if (btnOfferRenewal.Text.Trim().ToString() != "Save")
                slblplan = Amc.OldPromo_Id;// FindPlanPromoId();
            else
                slblplan = FindPlanPromoId();
            if (slblplan == "")
            {
                DivNewMsg1.Visible = true;
                DivNewMsg1.Attributes.Add("class", "alert_boxes_pink");
                LabelAmcRenewalmsg.Text = "Please select Offer Plan";
                ModalPopupAmcRenewal.Show();
                string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
            Amc.Trans_Type = "Offer";
            Amc.DateFromChk = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd"));
            Amc.Pro_Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt");
            Amc.PromoDateFrom = Convert.ToDateTime(Convert.ToDateTime(txtdtfromamc3.Text).ToString("yyyy/MM/dd"));
            if (btnOfferRenewal.Text.Trim().ToString() == "Save")
                txtdttoamc3.Text = HdDateTo3.Value;
            else
            {
                txtdttoamc3.Text = "";
                txtdttoamc3.Text = HdDateTo3.Value;
            }
            Amc.PromoDateTo = Convert.ToDateTime(Convert.ToDateTime(txtdttoamc3.Text).ToString("yyyy/MM/dd"));
            Amc.Promo_Id = slblplan;
            Amc.statusstr = null;
            function9420.FindPromoInfo(Amc);
            //if (Amc.OldPayAmt > Amc.Balance)
            //{
            //    DivNewMsg1.Visible = true;
            //    DivNewMsg1.Attributes.Add("class", "alert_boxes_pink");
            //    LabelAmcRenewalmsg.Text = "You are not valid for this plan beacause our paid amount is greater than this plan amount";
            //    ModalPopupAmcRenewal.Show();
            //    string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg1.ClientID + "').style.display='none';},5000);";
            //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            //    return;
            //}
            //else
            //{
            //    Amc.Admin_Balance = Amc.Balance - Amc.OldPayAmt;
            //    Amc.Manu_Balance = Amc.Balance - Amc.OldReqAmt;
            //}
            string path = "";
            DateTime AmcStartDate = Convert.ToDateTime(lblCurrAmcStartDate.Text);
            DateTime AmcEndDate = Convert.ToDateTime(lblCurrAmcEndDate.Text);
            if ((Amc.PromoDateFrom < AmcStartDate) || (Amc.PromoDateFrom > AmcEndDate))
            {
                if (chkComments.Checked)
                {
                    txtComment.Text = string.Empty;
                    chkComments.Checked = false;
                }
                DivNewMsg1.Visible = true;
                DivNewMsg1.Attributes.Add("class", "alert_boxes_pink");
                LabelAmcRenewalmsg.Text = "Please select valid Offer date Between Amc Date [Start Date : <span style='color:blue;' >" + Convert.ToDateTime(AmcStartDate).ToString("dd/MM/yyyy") + "</span> End Date : <span style='color:blue;' >" + Convert.ToDateTime(AmcEndDate).ToString("dd/MM/yyyy") + "</span>].";
                ModalPopupAmcRenewal.Show();
                string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
            else if ((Amc.PromoDateTo > AmcEndDate) || (Amc.PromoDateTo < AmcStartDate))
            {
                if (chkComments.Checked)
                {
                    txtComment.Text = string.Empty;
                    chkComments.Checked = false;
                }
                DivNewMsg1.Visible = true;
                DivNewMsg1.Attributes.Add("class", "alert_boxes_pink");
                LabelAmcRenewalmsg.Text = "Please select valid Offer date Between Amc Date [Start Date : <span style='color:blue;' >" + Convert.ToDateTime(AmcStartDate).ToString("dd/MM/yyyy") + "</span> End Date : <span style='color:blue;' >" + Convert.ToDateTime(AmcEndDate).ToString("dd/MM/yyyy") + "</span>].";
                ModalPopupAmcRenewal.Show();
                string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
            if (btnOfferRenewal.Text.Trim().ToString() == "Save")
            {
                Amc.TransType = DataProvider.TransType.New_Offer.ToString();
                #region Insert Code
                if (function9420.CheckDateFrom(Amc))
                {
                    if (chkComments.Checked)
                    {
                        txtComment.Text = string.Empty;
                        chkComments.Checked = false;
                    }
                    DivNewMsg1.Visible = true;
                    DivNewMsg1.Attributes.Add("class", "alert_boxes_pink");
                    LabelAmcRenewalmsg.Text = "Please select valid AMC Plan date from";
                    ModalPopupAmcRenewal.Show();
                    string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg1.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                    return;
                }
                if (function9420.CheckDateTo(Amc))
                {
                    if (chkComments.Checked)
                    {
                        txtComment.Text = string.Empty;
                        chkComments.Checked = false;
                    }
                    DivNewMsg1.Visible = true;
                    DivNewMsg1.Attributes.Add("class", "alert_boxes_pink");
                    LabelAmcRenewalmsg.Text = "Please select valid AMC Plan date to";
                    ModalPopupAmcRenewal.Show();
                    string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg1.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                    return;
                }
                //if (Amc.PromoDateFrom <= Amc.DateToChk)
                //{
                //    DivNewMsg1.Visible = true;
                //    DivNewMsg1.Attributes.Add("class", "alert_boxes_pink");
                //    LabelAmcRenewalmsg.Text = "Please select valid AMC Plan date from your old Amc End Date : - " + Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
                //    ModalPopupAmcRenewal.Show();
                //    string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg1.ClientID + "').style.display='none';},5000);";
                //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                //    return;
                //}

                Amc.DML = "I"; // Insert Amc 

                Amc.Comment_Txt = txtComment.Text.Trim().Replace("'", "''");
                function9420.InsertAmcOfferPlan(Amc);
                Business9420.function9420.FindAmcOfferId(Amc);

                //************************* Code start For Generate Invoice ******************//
                if (function9420.CheckForGenerateInvoice(Amc.Pro_ID))
                {
                    Object9420 Inv = new Object9420();
                    Inv.Comp_ID = Amc.Comp_ID;
                    Inv.Pro_ID = Amc.Pro_ID;
                    Inv.Plan_ID = Amc.Amc_Offer_ID.ToString();
                    Inv.FolderPath = Server.MapPath("../Data/Bill");
                    Inv.Path = Server.MapPath("../Reports") + "\\InvoiceReport.rpt";
                    function9420.CreateInvoice(Inv);
                    //showReport(Inv.Head_ID, Inv.Invoice_ID, Inv.Head_Name);
                }
                //************************* Code end For Generate Invoice ******************//

                if (!chkComments.Checked)
                {
                    #region Save File
                    if (flSoundPH.FileName != "")
                    {
                        path = Server.MapPath("../Data/Sound");
                        path = path + "\\" + Amc.Comp_ID.ToString().Substring(5, 4) + "\\" + Amc.Pro_ID + "\\" + Amc.Amc_Offer_ID;
                        DataProvider.Utility.CreateDirectory(path);
                        path = path + "\\" + Amc.Amc_Offer_ID + "_H.wav";
                        flSoundPH.SaveAs(path);
                    }
                    if (flSoundPE.FileName != "")
                    {
                        path = Server.MapPath("../Data/Sound");
                        path = path + "\\" + Amc.Comp_ID.ToString().Substring(5, 4) + "\\" + Amc.Pro_ID + "\\" + Amc.Amc_Offer_ID;
                        DataProvider.Utility.CreateDirectory(path);
                        path = path + "\\" + Amc.Amc_Offer_ID + "_E.wav";
                        flSoundPE.SaveAs(path);
                    }
                    #endregion
                }
                else
                {
                    #region File Copy
                    string path1 = "";
                    path1 = Server.MapPath("../Data/Sound");
                    path1 = path1 + "\\" + Amc.Comp_ID.ToString().Substring(5, 4) + "\\" + Amc.Pro_ID + "\\" + hdnoldAmcId.Value;
                    path1 = path1 + "\\" + hdnoldAmcId.Value + "_H.wav";
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Amc.Comp_ID.ToString().Substring(5, 4) + "\\" + Amc.Pro_ID + "\\" + Amc.Amc_Offer_ID;
                    DataProvider.Utility.CreateDirectory(path);
                    path = path + "\\" + Amc.Amc_Offer_ID + "_H.wav";
                    File.Copy(path1, path);
                    path1 = Server.MapPath("../Data/Sound");
                    path1 = path1 + "\\" + Amc.Comp_ID.ToString().Substring(5, 4) + "\\" + Amc.Pro_ID + "\\" + hdnoldAmcId.Value;
                    path1 = path1 + "\\" + hdnoldAmcId.Value + "_E.wav";
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Amc.Comp_ID.ToString().Substring(5, 4) + "\\" + Amc.Pro_ID + "\\" + Amc.Amc_Offer_ID;
                    DataProvider.Utility.CreateDirectory(path);
                    path = path + "\\" + Amc.Amc_Offer_ID + "_E.wav";
                    File.Copy(path1, path);
                    #endregion
                }
                #endregion
            }
            else if ((btnOfferRenewal.Text.Trim().ToString() == "Update") || (btnOfferRenewal.Text.Trim().ToString() == "Upgrade") || (btnOfferRenewal.Text.Trim().ToString() == "Renewal"))
            {
                #region Update
                Amc.chkstr = "Update";
                if (function9420.CheckDateFrom(Amc))
                {
                    if (chkComments.Checked)
                    {
                        txtComment.Text = string.Empty;
                        chkComments.Checked = false;
                    }
                    DivNewMsg1.Visible = true;
                    DivNewMsg1.Attributes.Add("class", "alert_boxes_pink");
                    LabelAmcRenewalmsg.Text = "Please select valid AMC Plan date from";
                    ModalPopupAmcRenewal.Show();
                    string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg1.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                    return;
                }
                if (function9420.CheckDateTo(Amc))
                {
                    if (chkComments.Checked)
                    {
                        txtComment.Text = string.Empty;
                        chkComments.Checked = false;
                    }
                    DivNewMsg1.Visible = true;
                    DivNewMsg1.Attributes.Add("class", "alert_boxes_pink");
                    LabelAmcRenewalmsg.Text = "Please select valid AMC Plan date to";
                    ModalPopupAmcRenewal.Show();
                    string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg1.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                    return;
                }

                if (Amc.Status == 1)// Amc.DML = "IUp"; is update but start date is not update
                {
                    Amc.DML = "I"; // Upgrade AMC
                    Amc.TransType = DataProvider.TransType.Upgrade.ToString();
                }
                else
                {
                    if (Amc.OldPromo_Id == Amc.Promo_Id)
                    {
                        Amc.TransType = DataProvider.TransType.Date_Extention_By_Manufacturer.ToString();
                        Amc.DML = "IU"; // update Amc  WHERE AMC is Date Extention By Manufacturer starts
                    }
                    else
                    {
                        Amc.TransType = DataProvider.TransType.Renewal.ToString();
                        Amc.DML = "IU"; // update Amc  WHERE AMC Renewal Take New AMC
                    }
                }
                Amc.Comment_Txt = txtComment.Text.Trim().Replace("'", "''");
                function9420.InsertAmcOfferPlan(Amc);

                if (flSoundPH.FileName != "")
                {
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Amc.Comp_ID.ToString().Substring(5, 4) + "\\" + Amc.Pro_ID + "\\" + Amc.Row_ID;
                    DataProvider.Utility.CreateDirectory(path);
                    path = path + "\\" + Amc.Row_ID + "_H.wav";
                    flSoundPH.SaveAs(path);
                    Amc.Doc_Flag = 0;
                    function9420.UpdateProductCommentsH(Amc);
                }
                if (flSoundPE.FileName != "")
                {
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Amc.Comp_ID.ToString().Substring(5, 4) + "\\" + Amc.Pro_ID + "\\" + Amc.Row_ID;
                    DataProvider.Utility.CreateDirectory(path);
                    path = path + "\\" + Amc.Row_ID + "_E.wav";
                    flSoundPE.SaveAs(path);
                    Amc.Doc_Flag = 0;
                    function9420.UpdateProductCommentsE(Amc);
                }
                #endregion
            }
            #region Send mail  code
            Object9420 Reg = new Object9420();
            Reg.Comp_ID = Amc.Comp_ID;
            Business9420.function9420.FillUpDateProfile(Reg);
            Object9420 Promoobj = new Object9420();
            Promoobj.Promo_Id = Amc.Promo_Id;
            Business9420.function9420.FindPromoInfo(Promoobj);
            #region Mail Structure
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
            " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
            " <hr style='border:1px solid #2587D5;'/>" +
            " <div class='w_frame'>" +
            " <p>" +
            " <div class='w_detail'>" +
            " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
            " <br />" +
            " <span>Congratulations !!!</span>   <br />    <br />" +
            "<strong> Product <span style='color:blue' >" + Amc.Pro_Name + "</span> Offer Message </strong>  " + Amc.TransType.ToString() + " successfully.   <br />    <br />" +
            " Your Offer message option is  <strong>" + Promoobj.Time_Days + " ( Start Date - " + Convert.ToDateTime(Amc.PromoDateFrom).ToString("dd MMM yyyy") + " End Date - " + Convert.ToDateTime(Amc.PromoDateTo).ToString("dd MMM yyyy") + " ) days.</strong>     <br />    <br />" +
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
            #endregion
            DataSet dsMl = function9420.FetchMailDetail("register");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Product Offer " + Amc.TransType.ToString() + " status");
            }
            #endregion
            //function9420.UpdateProductComments(Amc);
            NewMsgpop.Visible = true;
            NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
            Label2.Text = "Product " + Amc.Pro_Name + " Amc Renewal has been successfully !";
            string script1 = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
            lblproiddel.Text = string.Empty; HdDateTo3.Value = string.Empty; txtdttoamc3.Text = string.Empty;
            filldata();
        }
       // CheckValidation(false);
    }

    private string FindPlanCodeAmc()
    {
        string slbl = "";
        if (Request.Form["rdamcrew"] != null)
        {
            string[] Arr = Request.Form["rdamcrew"].ToString().Split(',');
            string[] pArr = Arr[0].ToString().Split('-');
            slbl = pArr[0].ToString();
            //slbl = Arr[0].ToString();
        }
        else
            slbl = "";
        HdLabelCode.Value = slbl;
        HdLabelCodeRequest.Value = HdLabelCode.Value;
        return slbl;
    }

    private void CreateIncoive(Object9420 Amc)
    {
        //************************* Code start For Generate Invoice ******************//
        if (function9420.CheckForGenerateInvoice(Amc.Pro_ID))
        {
            Object9420 Inv = new Object9420();
            Inv.Comp_ID = Amc.Comp_ID;
            Inv.Pro_ID = Amc.Pro_ID;
            Inv.Plan_ID = Amc.Amc_Offer_ID.ToString();
            Inv.FolderPath = Server.MapPath("../Data/Bill");
            Inv.Path = Server.MapPath("../Reports") + "\\InvoiceReport.rpt";
            Inv.TransRow_ID = HdnUpdatePlanTransID.Value;
            Inv.TransType = Amc.TransType;
            function9420.CreateInvoice(Inv);
        }
        //************************* Code end For Generate Invoice ******************//
    }
    protected void btnAmcRenewal_Click(object sender, EventArgs e)
    {
        Object9420 Amc = new Object9420();
        Amc.Pro_ID = lblproiddel.Text;
        Amc.Comp_ID = Session["CompanyId"].ToString();
        Amc.OldPlan_ID = HdnUpdatePlanID.Value;
        //Amc.Plan_Type = HdnUpdatePlanType.Value;
        if (HdnUpdatePlanTransID.Value != "")
            Amc.Row_ID = HdnUpdatePlanTransID.Value;
        else
            Amc.Row_ID = "0";
        Amc.Trans_Type = "AMC";
        Business9420.function9420.FillData(Amc);
        if (Amc.Status == -1)
        {
            NewMsgpop.Visible = true;
            NewMsgpop.Attributes.Add("class", "alert_boxes_pink big_msg");
            Label2.Text = "Action is not allowed, This plan has been expired on  " + Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
            return;
        }
        else
        {
            DivNewMsg1.Visible = false;
            string slblplan = FindPlanCodeAmc();
            if (slblplan == "")
            {
                DivNewMsg1.Visible = true;
                DivNewMsg1.Attributes.Add("class", "alert_boxes_pink");
                LabelAmcRenewalmsg.Text = "Please select AMC Plan";
                ModalPopupAmcRenewal.Show();
                string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
            Amc.Trans_Type = "AMC";
            Amc.DateFromChk = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd"));
            Amc.Pro_Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt");
            Amc.DateFrom = Convert.ToDateTime(Convert.ToDateTime(txtdtfromamc1.Text).ToString("yyyy/MM/dd"));
            if (txtdttoamc1.Text == "")
                txtdttoamc1.Text = HdDateTo1.Value;
            Amc.DateTo = Convert.ToDateTime(Convert.ToDateTime(txtdttoamc1.Text).ToString("yyyy/MM/dd"));
            #region Check for Beyond Offer
            // Check for Beyond Offer
            if (btnAmcRenewal.Text.Trim().ToString() == "Update")
            {
                Amc.AmcDateFrom = Convert.ToDateTime(hdnAmcDateFrom.Value);
                Amc.AmcDateTo = Convert.ToDateTime(hdnAmcDateTo.Value);
                DataTable dso = function9420.GetBeyondOffer(Amc);
                Session["BeyondOffer"] = (DataTable)dso;
                if (dso.Rows.Count > 0)
                {
                    lblBeyondOffer.Text = "These Offer are Beyond to the Amc Plan.";
                    Amc.Amt_Type = Amc.Trans_Type;
                    FillProductAmcAmount(Amc, GrdVwBeyondOffer);
                    ModalPopupAmcRenewal.Show();
                    ModalPopupCancelOffer.Show();
                    return;
                }
            }
            // Check for Beyond Offer
            #endregion
            Amc.Plan_ID = slblplan;
            Amc.statusstr = null;
            Amc.Manage_By = Session["User_Type"].ToString();
            Amc.AmcOfferRemarks = null;
            function9420.FindAMCInfo(Amc);
            if (Amc.OldPayAmt > Amc.Balance)
            {
                DivNewMsg1.Visible = true;
                DivNewMsg1.Attributes.Add("class", "alert_boxes_pink");
                LabelAmcRenewalmsg.Text = "You are not valid for this plan beacause our paid amount is greater than this plan amount";
                ModalPopupAmcRenewal.Show();
                string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
            else
            {
                Amc.Admin_Balance = Amc.Balance - Amc.OldPayAmt;
                Amc.Manu_Balance = Amc.Balance - Amc.OldReqAmt;
            }
            if (btnAmcRenewal.Text.Trim().ToString() == "Save")
            {
                Amc.TransType = DataProvider.TransType.New_Amc.ToString();
                if (function9420.CheckDateFrom(Amc))
                {
                    DivNewMsg1.Visible = true;
                    DivNewMsg1.Attributes.Add("class", "alert_boxes_pink");
                    LabelAmcRenewalmsg.Text = "Please select valid AMC Plan date from";
                    ModalPopupAmcRenewal.Show();
                    string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg1.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                    return;
                }
                if (function9420.CheckDateTo(Amc))
                {
                    DivNewMsg1.Visible = true;
                    DivNewMsg1.Attributes.Add("class", "alert_boxes_pink");
                    LabelAmcRenewalmsg.Text = "Please select valid AMC Plan date to";
                    ModalPopupAmcRenewal.Show();
                    string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg1.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                    return;
                }
                if (Amc.DateFrom <= Amc.DateToChk)
                {
                    DivNewMsg1.Visible = true;
                    DivNewMsg1.Attributes.Add("class", "alert_boxes_pink");
                    LabelAmcRenewalmsg.Text = "Please select valid AMC Plan date from your old Amc End Date : - " + Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
                    ModalPopupAmcRenewal.Show();
                    string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg1.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                    return;
                }
                Amc.DML = "I"; // Insert Amc 
                function9420.InsertAmcOfferPlan(Amc);
                function9420.FindAmcOfferId(Amc);
                CreateIncoive(Amc);
            }
            else if (btnAmcRenewal.Text.Trim().ToString() == "Update")
            {
                if (Amc.OldPlan_ID == Amc.Plan_ID)
                {
                    Amc.chkstr = "Update";
                    Amc.TransType = DataProvider.TransType.Date_Extention_By_Manufacturer.ToString();
                    Amc.DML = "IU"; // update Amc  WHERE AMC is Date Extention By Manufacturer starts
                    function9420.InsertAmcOfferPlan(Amc);
                }
                else
                {
                    Amc.DML = "I"; // Upgrade AMC
                    Amc.TransType = DataProvider.TransType.Upgrade.ToString();
                    function9420.InsertAmcOfferPlan(Amc);
                    function9420.FindAmcOfferId(Amc);
                }
                CreateIncoive(Amc); // Invoice not generate because already genrated
            }
            else if (btnAmcRenewal.Text.Trim().ToString() == "Upgrade")
            {
                if (Amc.Status == 1) // Amc.DML = "IUp"; is update but start date is not update
                {
                    Amc.DML = "I"; // Upgrade AMC
                    Amc.TransType = DataProvider.TransType.Upgrade.ToString();
                    function9420.InsertAmcOfferPlan(Amc);
                    function9420.FindAmcOfferId(Amc);
                    CreateIncoive(Amc); // Invoice generate but Invoice different Amount Invoice generate
                }
            }
            else if (btnAmcRenewal.Text.Trim().ToString() == "Renewal")
            {
                Amc.TransType = DataProvider.TransType.Renewal.ToString();
                Amc.DML = "I"; // update Amc  WHERE AMC Renewal Take New AMC
                function9420.InsertAmcOfferPlan(Amc);
                function9420.FindAmcOfferId(Amc);
                CreateIncoive(Amc); // New Invoice generate but Invoice different Amount Invoice generate
            }
            #region Send mail  code
            Object9420 Reg = new Object9420();
            Reg.Comp_ID = Amc.Comp_ID;
            Business9420.function9420.FillUpDateProfile(Reg);
            Object9420 Amcobj = new Object9420();
            Amcobj.Plan_ID = Amc.Plan_ID;
            Business9420.function9420.FindAMCInfo(Amcobj);
            #region Mail Structure
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
            " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
            " <hr style='border:1px solid #2587D5;'/>" +
            " <div class='w_frame'>" +
            " <p>" +
            " <div class='w_detail'>" +
            " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
            " <br />" +
            " <span>Congratulations !!!</span>    <br />    <br />" +
            "<strong> Product <span style='color:blue' >" + Amc.Pro_Name + "</span> AMC </strong>  " + Amc.TransType.ToString() + " successfully.   <br />    <br />" +
            " Your AMC Plan is  <strong>" + Amcobj.Plan_Name + "(Start Date - " + Convert.ToDateTime(Amc.DateFrom).ToString("dd MMM yyyy") + " End Date - " + Convert.ToDateTime(Amc.DateTo).ToString("dd MMM yyyy") + ")</strong>     <br />    <br />" +
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
            #endregion
            DataSet dsMl = function9420.FetchMailDetail("register");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Product Offer Message " + Amc.TransType.ToString() + " status");
            }
            #endregion
            NewMsgpop.Visible = true;
            NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
            Label2.Text = "Product " + Amc.Pro_Name + " Amc Renewal has been successfully !";
            string script1 = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
            lblproiddel.Text = string.Empty;
            filldata();
        }
    }
    protected void GrdProductMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        currindex.Value = string.Empty; 
       
        if (e.CommandName == "EditRow")
        {
            Response.Redirect("AddProduct.aspx?id=" + e.CommandArgument.ToString());
           
        }
        else if (e.CommandName == "DeleteRow")
        {
            Object9420 Reg = new Object9420();
            Reg.Pro_ID = lblproiddel.Text;
            Reg.Comp_ID = Session["CompanyId"].ToString();
            DataSet ds = function9420.UpdateData(Reg);
            if (ds.Tables[0].Rows.Count > 0)
            {
                btnNoAlert.Visible = false;
                LabelAlert.Text = "Alert";
                lblalert.Text = " Are you sure to delete the <span style='color:blue;'>" + ds.Tables[0].Rows[0]["Pro_Name"].ToString() + "</span> product ?";
                ModalPopupExtenderAlert.Show();
            }
        }
        else if (e.CommandName == "AudioPlay")
        {
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(Server.MapPath(e.CommandArgument.ToString()));
            player.Play();
        }
        else if (e.CommandName.ToString() == "AmcRenewal")
        {
            lblAmcText.Visible = false;
            lblAmcenddate.Text = string.Empty;
            btnAmcRenewal.Visible = true;
            btnOfferRenewal.Visible = false;
            GrdProductsAmc.Columns[0].HeaderText = "Amc Name";
            DivNewMsg1.Visible = false;
            Object9420 Amc = new Object9420();
            Amc.Pro_ID = lblproiddel.Text;
            Amc.Amt_Type = "AMC";
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT Amc_Offer_ID,Plan_ID,Plan_Amount,Date_From,Date_To,isnull(Status,0) as Status FROM M_Amc_Offer WHERE Amc_Offer_ID = (SELECT Max(Amc_Offer_ID) FROM M_Amc_Offer WHERE Pro_Id = '" + Amc.Pro_ID + "' AND Trans_Type = '" + Amc.Amt_Type + "' )");
            Session["Plan_ID"] = ds.Tables[0].Rows[0]["Plan_ID"].ToString();
            Amc.Plan_ID = Session["Plan_ID"].ToString();
            HdValAMC1.Value = function9420.GetPlanTime(Amc);
            HdnUpdatePlanID.Value = Session["Plan_ID"].ToString();
            HdnUpdatePlanTransID.Value = ds.Tables[0].Rows[0]["Amc_Offer_ID"].ToString();
            HdnUpdatePlanAmount.Value = ds.Tables[0].Rows[0]["Plan_Amount"].ToString();
            txtdttoamc1.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["Date_To"].ToString()).ToString("dd/MM/yyyy");
            txtdtfromamc1.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["Date_From"].ToString()).ToString("dd/MM/yyyy");
            hdnAmcDateFrom.Value = txtdtfromamc1.Text;
            hdnAmcDateTo.Value = txtdttoamc1.Text;
            ////Deepak Rai
            //if (Convert.ToDateTime(ds.Tables[0].Rows[0]["Date_To"].ToString()).Date < Convert.ToDateTime(DataProvider.LocalDateTime.Now).Date)
            //{
            //    SQL_DB.ExecuteNonQuery("Update M_Amc_Offer Set Status =0 where Amc_Offer_ID = (SELECT Max(Amc_Offer_ID) FROM M_Amc_Offer WHERE Pro_Id = '" + Amc.Pro_ID + "' AND Trans_Type = '" + Amc.Amt_Type + "' )");
            //    txtdtfromamc1.Text = Convert.ToDateTime(System.DateTime.Now).ToString("dd/MM/yyyy");
            //    hdnAmcDateFrom.Value = txtdtfromamc1.Text;
            //    btnAmcRenewal.Text = "Update";
            //    Amc.PlanAmount = Convert.ToDouble(HdnUpdatePlanAmount.Value); //Convert.ToDouble(Data_9420.GetMaxPlanAmount());
            //    txtdtfromamc1.Enabled = true;
            //}
            ////****
            if (Convert.ToInt32(ds.Tables[0].Rows[0]["Status"]) == 0)
            {
                btnAmcRenewal.Text = "Update";
                Amc.PlanAmount = Convert.ToDouble(HdnUpdatePlanAmount.Value); //Convert.ToDouble(Data_9420.GetMaxPlanAmount());
                txtdtfromamc1.Enabled = true;
            }
            else if (Convert.ToInt32(ds.Tables[0].Rows[0]["Status"]) == 1)
            {
                btnAmcRenewal.Text = "Upgrade";
                txtdtfromamc1.Enabled = false;
                Amc.PlanAmount = Convert.ToDouble(HdnUpdatePlanAmount.Value);
            }
            else
            {
                btnAmcRenewal.Text = "Renewal";
                Amc.PlanAmount = Convert.ToDouble(0.00);
                txtdtfromamc1.Enabled = true;
            }
            MyAmcOfferGrdVw.Visible = true;
            MyOfferGrdVw.Visible = false;
            //FillProductAmcAmount(Amc, GrdProductsAmc);
            //if (GrdProductsAmc.Rows.Count > 6)
            //    MyAmcOfferGrdVw.Attributes.Add("style", "height: 200px; overflow: auto;");            
            Amc.Disp = 0;
            FillPlanGrdAmcRenewal(Amc);
            MyAmcOfferDetails.Attributes.Add("style", "display:none;");
            LblAmcRenewalHeader.Text = "Amc Renewal (<span style='color:blue;' >" + SQL_DB.ExecuteScalar("SELECT Pro_Name FROM Pro_Reg WHERE Pro_Id = '" + Amc.Pro_ID + "'") + "</span>)";
            //txtdtfromamc1.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy");
            ModalPopupAmcRenewal.Show();
        }
        else if (e.CommandName.ToString() == "OfferRenewal")
        {
            txtComment.Text = string.Empty;
            Object9420 Reg = new Object9420();
            Reg.Pro_ID = lblproiddel.Text;
            Reg.Trans_Type = "AMC";
            function9420.GetAmcPlan(Reg);
            lblCurrAmcStartDate.Text = Convert.ToDateTime(Reg.DateFrom).ToString("dd/MM/yyyy");
            lblCurrAmcEndDate.Text = Convert.ToDateTime(Reg.DateTo).ToString("dd/MM/yyyy");
            Reg.Amt_Type = "Offer";
        //    CheckValidation(false);
            if (!function9420.CheckOffer(Reg))
            {
                chkComments.Visible = false;
                CheckBox1.Visible = false;
                CheckBox2.Visible = false;
            }
            else
            {
                chkComments.Checked = false;
                chkComments.Visible = true;
                A1.Attributes.Add("style", "display:none;");
                A2.Attributes.Add("style", "display:none;");
                CheckBox1.Visible = true;
                CheckBox2.Visible = true;
            }
            btnOfferRenewal.Visible = true;
            btnOfferRenewal.Text = "Save";
            btnAmcRenewal.Visible = false;
            GrdProductsAmc.Columns[0].HeaderText = "Offer Name";
            DivNewMsg1.Visible = false;
            PanelAmcRenewal.Attributes.Add("style", "width:60%");
            FillProductAmcAmount(Reg, GrdProductsAmc);
            if (GrdProductsAmc.Rows.Count > 6)
                MyAmcOfferGrdVw.Attributes.Add("style", "height: 200px; overflow: auto;");
            FillGridChkPromotional(0, GrdVwOfferDetails);
            txtdtfromamc3.Enabled = true;
            txtdtfromamc3.Text = string.Empty; //DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy");
            MyAmcOfferGrdVw.Visible = false;
            MyOfferGrdVw.Visible = true;
            LblAmcRenewalHeader.Text = "Offer Renewal (<span style='color:blue;' >" + SQL_DB.ExecuteScalar("SELECT Pro_Name FROM Pro_Reg WHERE Pro_Id = '" + Reg.Pro_ID + "'") + "</span>)";
            Session["PromoId"] = "";
            ModalPopupAmcRenewal.Show();
        }
        else if (e.CommandName == "Loyalty")
        {
            //lblproiddel.Text = e.CommandArgument.ToString();
            //lblproidamc.Value = lblproiddel.Text;
            //DataTable ddt = SQL_DB.ExecuteDataSet("SELECT RowId, Comp_ID, Pro_ID, Points,IsCashConvert, DateFrom, DateTo, IsActive, IsDelete FROM M_Loyalty WHERE Pro_ID = '" + e.CommandArgument.ToString() + "' ").Tables[0];
            //if (ddt.Rows.Count > 0)
            //{
            //    chkloyalty.Checked = true;
            //    if (Convert.ToInt32(ddt.Rows[0]["IsCashConvert"]) == 0)
            //        chkconvert.Checked = true;
            //    else
            //        chkconvert.Checked = false;
            //    hdnloyalty.Value = ddt.Rows[0]["Pro_ID"].ToString();
            //    txtloyaltypoints.Text = ddt.Rows[0]["Points"].ToString();
            //    txtloyaltydtfrom.Text = ddt.Rows[0]["DateFrom"].ToString();
            //    txtloyaltydtto.Text = ddt.Rows[0]["DateTo"].ToString();
            //    btnloyaltysaveupdate.Text = "Update";
            //    Lblloyaltyhead.Text = "Update Loyalty";
            //}
            //else
            //{
            //    btnloyaltysaveupdate.Text = "Save";
            //    Lblloyaltyhead.Text = "Add Loyalty";
            //}
            //ModalPopupLoyalty.Show();
        }
    }

    private void FillGridChkPromotional(int i, GridView GrdVwPromotional)
    {
        DataSet ds = Business9420.function9420.FillPromotional(i);
        GrdVwPromotional.DataSource = ds.Tables[0];
        GrdVwPromotional.DataBind();
        // csroll set
        if (ds.Tables[0].Rows.Count > 3)
            MyAmcOfferDetails.Attributes.Add("style", "height: 150px; overflow: auto;");
        // Change Selected rows
        if (currindex.Value != "")
        {
            System.Drawing.Color col = System.Drawing.Color.FromName("#E2FBED");
            GrdProductsAmc.Rows[Convert.ToInt32(currindex.Value)].BackColor = col;
        }
    }

    private void FillProductAmcAmount(Object9420 Reg, GridView GrdVw)
    {
        Reg.chkstr = " Manu_Balance ";
        Reg.Comp_ID = Session["CompanyId"].ToString();
        DataSet ds = function9420.FillProductAmcAmount(Reg);
        DataView dv = new DataView();
        dv = ds.Tables[0].DefaultView;
        dv.RowFilter = "Pro_ID = '" + Reg.Pro_ID + "'";
        DataTable dt = dv.ToTable();
        GrdVw.DataSource = dt;
        GrdVw.DataBind();
    }
    private void FillPlanGrdAmcRenewal(Object9420 Reg)
    {
        try
        {
            DataSet ds = function9420.FillGridPlan(Reg);
            //DataSet ds = function9420.FillGridPlan(i);
            DataView dv = ds.Tables[0].DefaultView;
            dv.RowFilter = "Flag = 1";
            GrdVwAmcRenewal.DataSource = dv;
            GrdVwAmcRenewal.DataBind();
            // csroll set
            if (ds.Tables[0].Rows.Count > 3)
                MyAmcOfferDetails.Attributes.Add("style", "height: 150px; overflow: auto;");
            // Change Selected rows
            if (currindex.Value != "")
            {
                System.Drawing.Color col = System.Drawing.Color.FromName("#E2FBED");
                GrdProductsAmc.Rows[Convert.ToInt32(currindex.Value)].BackColor = col;
            }
        }
        catch (Exception ex)
        {
        }
    }

}