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
//using CrystalDecisions.CrystalReports.Engine;
//using CrystalDecisions.Web;
//using CrystalDecisions.Shared;

public partial class RegisteredProduct : System.Web.UI.Page
{
    public string server = Convert.ToString(ConfigurationManager.ConnectionStrings["ServerName"].ConnectionString), userID = Convert.ToString(ConfigurationManager.ConnectionStrings["UserName"].ConnectionString), password = Convert.ToString(ConfigurationManager.ConnectionStrings["Password"].ConnectionString);
    public int c = 0, str = 0, upplanindex = 0, upamcindex = 0, upofindex = 0, index = 0, pindex = 0, planindex = 0, Disp = 0, promoDisp = 0, dispindex = 0, promoind = 0; public string TransType = "", Comptype = "", LCode = "", PlanID = "", PromoID = ""; public bool LabelFlag = false;
    public int CntDays = 0, IsCancel = 0, Loyalty = 0;
    public string srt = DataProvider.Utility.FindMailBody();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../default.aspx?Page=RegisteredProduct.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!Page.IsPostBack)
        {
            hhdnCompID.Value = Session["CompanyId"].ToString().Substring(5, 4);
            Session["Path"] = Server.MapPath("../Data/Sound");
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            if (Session["Comp_type"].ToString() == "D")
                imgNew.Visible = false;
            else
                imgNew.Visible = true;
            filldata(); Session["LabelCode"] = ""; Session["Plan_ID"] = ""; Session["PromoId"] = ""; Session["BeyondOffer"] = "";
            FillLabelDetGrd();
            NewMsgpop.Visible = false;
            if (Request.QueryString["Parm"] != null)
            {
                if (Request.QueryString["Parm"].ToString() == "New")
                    imgNew_Click1(new object(), null);
            }
        }
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
    [WebMethod]
    [ScriptMethod]
    public static bool checkFileNew(string ult)
    {
        int lindex = ult.LastIndexOf('.');
        string ext = ult.Substring(lindex, ult.Length - lindex);
        if (ext.ToUpper() == ".JPG" || ext.ToUpper() == ".JPEG" || ext.ToUpper() == ".PNG" || ext.ToUpper() == ".ZIP" || ext.ToUpper() == ".PDF" || ext.ToUpper() == ".DOC" || ext.ToUpper() == ".DOCX")
            return false;
        else
            return true;
    }
    [WebMethod]
    [ScriptMethod]
    public static string checkOldSound(string res)
    {
        Object9420 Reg = new Object9420();
        string[] Arr = res.ToString().Split('-');
        Reg.Comp_ID = HttpContext.Current.Session["CompanyId"].ToString();
        Reg.Pro_ID = Arr[0];
        Reg.Path = "../Data/Sound";
        DataSet ds = new DataSet();
        ds = SQL_DB.ExecuteDataSet("SELECT Row_ID FROM Pro_Reg WHERE Pro_ID = '" + Arr[0].ToString() + "' ");
        if (ds.Tables[0].Rows.Count > 0)
            return Reg.Path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\" + Reg.Pro_ID + Arr[1] + ".wav";
        else
            return "";
    }
    [WebMethod]
    [ScriptMethod]
    public static string checkOldRemarks(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Comments],isnull([Amc_Offer_ID],0) as Row_ID FROM [M_Amc_Offer] where [Pro_ID] = '" + res.Trim().Replace("'", "''") + "' AND  Trans_Type ='Offer' AND (Amc_Offer_ID = (SELECT Max(Amc_Offer_ID) FROM [M_Amc_Offer] where [Pro_ID] = '" + res.Trim().Replace("'", "''") + "' AND  Trans_Type ='Offer') ) ");
        if (ds.Tables[0].Rows.Count > 0)
            return ds.Tables[0].Rows[0]["Row_ID"].ToString() + "," + ds.Tables[0].Rows[0]["Comments"].ToString();
        else
            return "";
    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewProduct(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + HttpContext.Current.Session["CompanyId"] + "' and [Pro_Name] = '" + res.Trim().Replace("'", "''") + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    [WebMethod]
    [ScriptMethod]
    public static string checkcheckproLabel(string res)
    {
        string[] Arr = res.ToString().Split('-');
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Label_Code] FROM [Pro_Reg] where [Pro_ID] = '" + res + "' ");
        if (ds.Tables[0].Rows.Count > 0)
        {
            if (HttpContext.Current.Session["LabelCode"].ToString() == ds.Tables[0].Rows[0]["Label_Code"].ToString())
            {
                ds.Reset();
                ds = SQL_DB.ExecuteDataSet("SELECT Label_Code,(SELECT Label_Name + ' ('+Label_Size+')' FROM M_Label WHERE Label_Code = M_Label_Request.Label_Code)  as LType FROM M_Label_Request where [Pro_ID] = '" + res + "' AND Flag = 0 ");
                if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0].Rows.Count.ToString() + "-" + ds.Tables[0].Rows[0]["LType"].ToString() + "-" + true;
                else
                    return "0-" + false;
            }
            else
                return "0-" + false;
        }
        else
            return "0-" + false;
    }
    private void filldata()
    {
        Object9420 obj = new Object9420();
        obj.Comp_ID = Session["CompanyId"].ToString();
        obj.Pro_Name = txtProductName.Text.Trim().Replace("'", "''");
        obj.Pro_ID = "";
        //DataSet ds = function9420.FetchData(obj);
        DataSet ds = function9420.FetchSearchData(obj);
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

        if (GrdProductMaster.Rows.Count > 0)
            GrdProductMaster.HeaderRow.TableSection = TableRowSection.TableHeader;
        lblcount.Text = GrdProductMaster.Rows.Count.ToString();
    }

    protected void btnNextInfo_Click(object sender, EventArgs e)
    {
        //ModalPopupExtender1.Show();
        //tabmenu.ActiveTabIndex = 1;
    }
    protected void btnAlertForNewPro_Click(object sender, EventArgs e)
    {
        newmsg.Visible = false;
        ModalPopupExtender1.Show();
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
    protected void btnNoAlert_Click(object sender, EventArgs e)
    {

    }

    protected void btnNextLabel_Click(object sender, EventArgs e)
    {
        ModalPopupExtender1.Show();
        tabmenu.ActiveTabIndex = 2;
    }
    protected void imgNew_Click1(object sender, EventArgs e)//object sender, ImageClickEventArgs e)
    {
        Response.Redirect("AddProduct.aspx");
        //if (chkLabel())
        //{
        //    allClear(); FillLabelDetGrd(); Object9420 Reg = new Object9420();
        //    Reg.Pro_ID = ""; Reg.Disp = 0;
        //    FillPlanGrd(Reg); // function fill new registration for product
        //    Session["Plan_ID"] = ""; ; Session["LabelCode"] = ""; Label2.Text = ""; Label3.Text = ""; lblmsgHeader.Text = "";
        //    ChangeValidationGroup(true);
        //    newmsg.Visible = false;
        //    NewMsgpop.Visible = false;
        //    tabmenu.ActiveTabIndex = 0;
        //    txtdtfromamc.Enabled = true;
        //    FillGridChkPromotional(0, GrdVwPromotional);
        //    ChkPromotional(false, 0);
        //    //TabPanelAMC.Visible = true;
        //    //TabPanelMsg.Visible = true;
        //    //btnUpdate.Visible = false;
        //    //btnResetNew.Visible = false;
        //    //** New Code starts ***********/
        //    btnUpdate.Text = "Save";
        //    ChangeValidationGroup(false);
        //    /*********** new end *******/
        //    txtdtfromamc.Text = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("dd/MM/yyyy"); //Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy");      // LocalDateTime;// System.DateTime.Now.ToString("dd/MM/yyyy");
        //    ModalPopupExtender1.Show();
        //}
        //else
        //{
        //    NewMsgpop.Visible = true;
        //    NewMsgpop.Attributes.Add("class", "alert_boxes_pink big_msg");
        //    Label2.Text = "Labels are not available, Please contact Admin!";
        //    string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //    return;
        //}
    }

    private bool chkLabel()
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT  Row_Id, Label_Code, Label_Name, Label_Size, Label_Prise, Label_Image, Entry_Date, Flag FROM M_Label");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    private void ChangeValidationGroup(bool str)
    {
        if (str == true)
        {
            RequiredFieldValidator522.ValidationGroup = "chk94";
            RequiredFieldValidatorfile.ValidationGroup = "chk94";
        }
        else
        {
            RequiredFieldValidator522.ValidationGroup = "NO";
            RequiredFieldValidatorfile.ValidationGroup = "NO";
        }
    }
    private void FillPlanGrd(Object9420 Reg)
    {
        //Object9420 Reg = new Object9420();
        DataSet ds = function9420.FillGridPlan(Reg);
        //DataSet ds = function9420.FillGridPlan(i);
        DataView dv = ds.Tables[0].DefaultView;
        dv.RowFilter = "Flag = 1";
        GrdViewAMC.DataSource = dv;
        GrdViewAMC.DataBind();
        //LabelCount.Text = GrdViewLabelDetails.Rows.Count.ToString();  
    }
    private void FillLabelDetGrd()
    {
        Object9420 Reg = new Object9420();
        Reg.Label_Name = "";
        DataSet ds = function9420.FillGridLabel(Reg);
        DataView dv = ds.Tables[0].DefaultView;
        dv.RowFilter = "Flag = 1";
        GrdViewLabelDetails.DataSource = dv;
        GrdViewLabelDetails.DataBind();
        //LabelCount.Text = GrdViewLabelDetails.Rows.Count.ToString();  

    }
    private string FindLabelCode()
    {
        string slbl = "";
        if (Request.Form["rdlabel"] != null)
        {
            string[] Arr = Request.Form["rdlabel"].ToString().Split(',');
            slbl = Arr[0].ToString();
        }
        else
            slbl = "";
        HdLabelCode.Value = slbl;
        HdLabelCodeRequest.Value = HdLabelCode.Value;
        return slbl;
    }
    private string FindPlanCode()
    {
        string slbl = "";
        if (Request.Form["rdamc"] != null)
        {
            string[] Arr = Request.Form["rdamc"].ToString().Split(',');
            string[] pArr = Arr[0].ToString().Split('-');
            slbl = pArr[0].ToString();
        }
        else
            slbl = "";
        HdLabelCode.Value = slbl;
        HdLabelCodeRequest.Value = HdLabelCode.Value;
        return slbl;
    }
    private string FindPromoId()
    {
        string slbl = "";
        if (Request.Form["rdPromotional"] != null)
        {
            string[] Arr = Request.Form["rdPromotional"].ToString().Split(',');
            slbl = Arr[0].ToString();
        }
        else
            slbl = "";
        HdPromoId.Value = slbl;
        return slbl;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string slbl = FindLabelCode();
        string slblplan = FindPlanCode();
        string promoid = FindPromoId();
        if (btnSave.Text == "Update")
            if (slblplan == "")
                slblplan = Session["Plan_ID"].ToString();
        if (slbl == "")
        {
            newmsg.Visible = true;
            newmsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            lblmsgHeader.Text = "Please select label type for product  " + txtProName.Text.Trim().Replace("'", "''");
            tabmenu.ActiveTabIndex = 3;
            ModalPopupExtender1.Show();
            string script = @"setTimeout(function(){document.getElementById('" + newmsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            return;
        }
        else if (slblplan == "")
        {
            newmsg.Visible = true;
            newmsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            lblmsgHeader.Text = "Please select AMC Plan for product  " + txtProName.Text.Trim().Replace("'", "''");
            tabmenu.ActiveTabIndex = 4;
            ModalPopupExtender1.Show();
            string script = @"setTimeout(function(){document.getElementById('" + newmsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            return;
        }
        else
        {
            Object9420 obj = new Object9420();
            obj.Pro_Name = txtProName.Text.Trim().Replace("'", "''").ToString();
            obj.Comp_ID = Session["CompanyId"].ToString();
            obj.DateFromChk = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd"));
            obj.Pro_Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy hh:mm:ss tt");
            obj.Pro_Descri = txtprodDes.Text.Trim().Replace("'", "''").ToString();
            obj.Label_Code = slbl;
            obj.Plan_ID = slblplan;
            obj.Promo_Id = promoid;
            obj.DateFrom = Convert.ToDateTime(Convert.ToDateTime(txtdtfromamc.Text.Trim()).ToString("yyyy/MM/dd"));
            if (txtdttoamc.Text == "")
                txtdttoamc.Text = HdDateTo.Value;
            obj.DateTo = Convert.ToDateTime(Convert.ToDateTime(txtdttoamc.Text.Trim()).ToString("yyyy/MM/dd"));
            if (btnSave.Text == "Save")
            {
                //obj.Row_ID = function9420.FindRowID();
                obj.Pro_ID = GenerateProductID(); HdPro_ID.Value = obj.Pro_ID;
                obj.Update_Flag = 0;
                obj.DML = "I";
                string path = Server.MapPath("../Data/Sound");
                path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID;
                DataProvider.Utility.CreateDirectory(path);
                path = path + "\\" + obj.Pro_ID + ".wav";
                flSound.SaveAs(path);
                path = Server.MapPath("../Data/Sound");
                string ext = Path.GetExtension(ProDocFileUpload.FileName);
                path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID;
                DataProvider.Utility.CreateDirectory(path);
                path = path + "\\" + obj.Pro_ID + "_ProDoc" + ext;
                ProDocFileUpload.SaveAs(path);
                obj.Pro_Doc = obj.Pro_ID + "_ProDoc" + ext;
                obj.Doc_Flag = 0;
                obj.statusstr = null;
                obj.Trans_Type = "AMC";
                obj.TransType = DataProvider.TransType.New_Amc.ToString();
                obj.Manage_By = Session["User_Type"].ToString();
                obj.AmcOfferRemarks = null;
                function9420.FindAMCInfo(obj);
                function9420.InsertAmcOfferPlan(obj);
                obj.Comment_Txt = null;
                obj.Dispatch_Location = txtdisatchLoc.Text.Trim().Replace("'", "''");
                obj.BatchSize = Convert.ToInt64(txtBatchSize.Text.Trim().Replace("'", "''"));
                function9420.ProductMaster(obj);
                if (RdYesMessage.Checked)
                {
                    obj.PromoDateFrom = Convert.ToDateTime(Convert.ToDateTime(txtdtfromamc2.Text.Trim()).ToString("yyyy/MM/dd"));
                    if (txtdttoamc2.Text == "")
                        txtdttoamc2.Text = HdDateTo2.Value;
                    obj.PromoDateTo = Convert.ToDateTime(Convert.ToDateTime(txtdttoamc2.Text.Trim()).ToString("yyyy/MM/dd"));
                    obj.Trans_Type = "Offer";
                    obj.TransType = DataProvider.TransType.New_Offer.ToString();
                    obj.Comment_Txt = txtCommentsTxt.Text.Trim().Replace("'", "''");
                    obj.AmcOfferRemarks = null;
                    function9420.FindPromoInfo(obj);
                    function9420.InsertAmcOfferPlan(obj);
                    function9420.FindAmcOfferId(obj);
                    obj.Row_ID = obj.Amc_Offer_ID.ToString();
                    //CreateInvoice(obj);
                    if (flSoundH.FileName != "")
                    {
                        path = Server.MapPath("../Data/Sound");
                        path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID + "\\" + obj.Amc_Offer_ID;
                        DataProvider.Utility.CreateDirectory(path);
                        path = path + "\\" + obj.Amc_Offer_ID + "_H.wav";
                        flSoundH.SaveAs(path);
                    }
                    if (flSoundE.FileName != "")
                    {
                        path = Server.MapPath("../Data/Sound");
                        path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID + "\\" + obj.Amc_Offer_ID;
                        DataProvider.Utility.CreateDirectory(path);
                        path = path + "\\" + obj.Amc_Offer_ID + "_E.wav";
                        flSoundE.SaveAs(path);
                    }
                }
                allClear();
                filldata();
                Label2.Text = ""; Label3.Text = ""; newmsg.Visible = false; ;
                newmsg.Visible = true;
                newmsg.Attributes.Add("class", "alert_boxes_green big_msg");
                lblmsgHeader.Text = "Product <a style='color:blue;text-decoration:none;' >" + obj.Pro_Name + "</a> has been registered successfully !";
                //LblAlertForRequestText.Text = "Product <a style='color:blue;text-decoration:none;' >" + obj.Pro_Name + "</a> has been registered successfully !";
                Object9420 Reg = new Object9420();
                Reg.Comp_ID = obj.Comp_ID;
                Business9420.function9420.FillUpDateProfile(Reg);
                Object9420 Promoobj = new Object9420();
                Promoobj.Promo_Id = obj.Promo_Id;
                Business9420.function9420.FindPromoInfo(Promoobj);
                Object9420 Amcobj = new Object9420();
                Amcobj.Plan_ID = obj.Plan_ID;
                Business9420.function9420.FindAMCInfo(Amcobj);
                #region Mail Structure
                string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
                " <hr style='border:1px solid #2587D5;'/>" +
                " <div class='w_frame'>" +
                " <p>" +
                " <div class='w_detail'>" +
                " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
                " <br />" +
                " <span>Congratulations !!!</span>   <br />" +
                " Product <strong> " + obj.Pro_Name + "</strong>  registered successfully.   <br />   <br />" +
                " <br /> Your sound  & document  file has been uploaded successfully. please wait for verification by admin. <br />   <br />" +
                " your AMC Plan is  <strong>" + Amcobj.Plan_Name + "(Start Date - " + Convert.ToDateTime(obj.DateFrom).ToString("dd MMM yyyy") + " To - " + Convert.ToDateTime(obj.DateTo).ToString("dd MMM yyyy") + ")</strong> and message option is  <strong>" + Promoobj.Time_Days + "(Start Date - " + Convert.ToDateTime(obj.PromoDateFrom).ToString("dd MMM yyyy") + " End Date - " + Convert.ToDateTime(obj.PromoDateTo).ToString("dd MMM yyyy") + ") days.</strong>    <br />   <br />" +
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
                string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Sales department", "Product sound & document file uploaded successfully.  <br/> AMC Plan is  <strong>" + Amcobj.Plan_Name + "</strong> and message option is  <strong>" + Promoobj.Time_Days + " days</strong>");
                string MailBody2 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Lagal department", "Product sound & document file uploaded successfully.");
                string MailBody3 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Account department", "Product sound & document file uploaded successfully. <br/> AMC Plan is  <strong>" + Amcobj.Plan_Name + "</strong> and message option is  <strong>" + Promoobj.Time_Days + " days</strong>");
                string MailBody4 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "IT department", "Product sound & document file uploaded successfully. <br/> AMC Plan is  <strong>" + Amcobj.Plan_Name + "</strong> and message option is  <strong>" + Promoobj.Time_Days + " days</strong>");
                DataSet dsMl = function9420.FetchMailDetail("register");
                if (dsMl.Tables[0].Rows.Count > 0)
                {
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Product registration status");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Company's product sound & document file activation");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Legal_accomplishtrades, MailBody2, "Company's product sound & document file activation");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Company's product sound & document file activation");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Company's product sound & document file activation");
                }
                RdYesMessage.Checked = false; RdNoMessage.Checked = true; ChkPromotional(false, 0);
                tabmenu.ActiveTabIndex = 0;
                ModalPopupExtender1.Show();
                string script = @"setTimeout(function(){document.getElementById('" + newmsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                //LblAlertForRequestH.Text = "Alert";
                //ModalPopupPrintedRequest.Show();

            }
            else if (btnSave.Text == "Update")
            {
                obj.Pro_ID = lblproid.Value;
                obj.Update_Flag = 0;
                //function9420.UpdateProductMaster(obj); /*** Old Code                
                string ext = "";
                if (flSound.FileName != "")
                {
                    string path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID;
                    DataProvider.Utility.CreateDirectory(path);
                    path = path + "\\" + obj.Pro_ID + ".wav";
                    flSound.SaveAs(path);
                    Business9420.function9420.UpdateFileFlagProduct(obj);
                    Business9420.function9420.UpdateSoundFlagProduct(obj);
                }
                if (ProDocFileUpload.FileName != "")
                {
                    ext = Path.GetExtension(ProDocFileUpload.FileName);
                    string path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID;
                    DirectoryInfo hdDirectoryInWhichToSearch = new DirectoryInfo(path);
                    string partialName = obj.Pro_ID + "_ProDoc";
                    FileInfo[] filesInDir = hdDirectoryInWhichToSearch.GetFiles(partialName + ".*");
                    foreach (FileInfo foundFile in filesInDir)
                    {
                        foundFile.Delete();
                    }
                    DataProvider.Utility.CreateDirectory(path);
                    path = path + "\\" + obj.Pro_ID + "_ProDoc" + ext;
                    ProDocFileUpload.SaveAs(path);
                    //Business9420.function9420.UpdateFileFlagProduct(obj);
                    Business9420.function9420.UpdateDocFlagProduct(obj);
                }
                if (ext != "")
                {
                    obj.Pro_Doc = obj.Pro_ID + "_ProDoc" + ext;
                    obj.Doc_Flag = 0;
                }
                else
                {
                    obj.Pro_Doc = FileDocDownPath.Text;
                    obj.Doc_Flag = Convert.ToInt32(docflag.Value);
                }
                if (!ChkPrintLables(obj))
                {
                    obj.DML = "U";
                    obj.Trans_Type = "AMC";
                    function9420.FindAMCInfo(obj);
                    obj.Row_ID = function9420.FindRowID();   // find  id for amc 
                    function9420.InsertAmcOfferPlan(obj);
                    if (RdYesMessage.Checked)
                    {
                        obj.PromoDateFrom = Convert.ToDateTime(Convert.ToDateTime(txtdtfromamc2.Text.Trim()).ToString("yyyy/MM/dd"));
                        if (txtdttoamc2.Text == "")
                            txtdttoamc2.Text = HdDateTo2.Value;
                        obj.PromoDateTo = Convert.ToDateTime(Convert.ToDateTime(txtdttoamc2.Text.Trim()).ToString("yyyy/MM/dd"));
                        obj.Trans_Type = "Offer";
                        function9420.FindPromoInfo(obj);
                        obj.Row_ID = function9420.FindRowID(); // find  id for offer
                        function9420.InsertAmcOfferPlan(obj);
                    }
                }
                //else
                //{
                //    obj.DML = "UI";
                //    function9420.InsertAmcOfferPlan(obj);
                //    if (RdYesMessage.Checked)
                //        function9420.InsertAmcOfferPlan(obj);
                //}
                obj.DML = "U";
                obj.BatchSize = Convert.ToInt64(txtBatchSize.Text.Trim().Replace("'", "''"));
                obj.Dispatch_Location = txtdisatchLoc.Text.Trim().Replace("'", "''");
                function9420.ProductMaster(obj);
                if (ProDocFileUpload.FileName != "")
                    Business9420.function9420.UpdateDocFlagProduct(obj);
                docflag.Value = string.Empty;
                filldata(); Label3.Text = "";
                ChangeValidationGroup(true);
                NewMsgpop.Visible = true;
                NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");  //class="alert_boxes_pink big_msg"   
                Label2.Text = "Product " + obj.Pro_Name + " has been updated successfully !";
                string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            }
            filldata();
        }
    }

    private void CreateInvoice(Object9420 Reg)
    {
        DataSet ds = new DataSet();
        ds = function9420.FillAmcOfferInvoiceDetails(" WHERE M_Amc_Offer.Row_ID = '" + Reg.Row_ID + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
            {
                string Invoice = function9420.GetLabelCode("Invoices");
                showReport(Convert.ToInt32(ds.Tables[0].Rows[j]["Row_ID"]), Invoice, Reg.Trans_Type);
                function9420.UpdateLabelCode("Invoices");
            }
        }
    }
    #region Create Invoice
    private void showReport(int Row_ID, string invn, string Trans_Type)
    {
        //ReportDocument myreportdocumen = new ReportDocument();
        //CrystalReportViewer CrystalReportViewer1 = new CrystalReportViewer();
        //CrystalReportViewer1.DisplayGroupTree = false;
        //CrystalReportViewer1.DisplayGroupTree = false;
        //myreportdocumen.Load(Server.MapPath(@"Reports\InvoiceReport.rpt"), CrystalDecisions.Shared.OpenReportMethod.OpenReportByDefault);
        //myreportdocumen.DataDefinition.FormulaFields["Invoice_No"].Text = "'" + invn + "'";
        //myreportdocumen.DataDefinition.FormulaFields["Invoice_Date"].Text = "'" + DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy") + "'";
        //myreportdocumen.DataDefinition.FormulaFields["Row_ID"].Text = "'" + Convert.ToInt32(Row_ID) + " '";
        //myreportdocumen.DataDefinition.FormulaFields["Trans_Type"].Text = "'" + Trans_Type + " '";
        //myreportdocumen.SetDatabaseLogon("sa", "infra");
        //DataSet ds = new DataSet();
        //string Qry = "select * from vw_Invoice where Row_ID='" + Convert.ToInt32(Row_ID) + "' AND  Trans_Type = '" + Trans_Type + "' ";
        //SQL_DB.GetDA(Qry).Fill(ds, "1");
        //if (ds.Tables["1"].Rows.Count > 0)
        //    myreportdocumen.SetDataSource(ds.Tables["1"]);
        //CrystalReportViewer1.ReportSource = myreportdocumen;
        //CrystalReportViewer1.DataBind();
        //CrystalReportViewer1.Visible = false;
        //ExportOptions CrExportOptions1;
        //DiskFileDestinationOptions CrDiskFileDestinationOptions1 = new DiskFileDestinationOptions();
        //PdfRtfWordFormatOptions CrFormatTypeOptions1 = new PdfRtfWordFormatOptions();
        //string pt = Server.MapPath("../Data/Bill") + "\\Invoice";
        //if (!Directory.Exists(pt))
        //    Directory.CreateDirectory(pt);
        //CrDiskFileDestinationOptions1.DiskFileName = pt + "\\" + Row_ID.ToString() + ".pdf";
        //CrExportOptions1 = myreportdocumen.ExportOptions;
        //{
        //    CrExportOptions1.ExportDestinationType = ExportDestinationType.DiskFile;
        //    CrExportOptions1.ExportFormatType = ExportFormatType.PortableDocFormat;
        //    CrExportOptions1.DestinationOptions = CrDiskFileDestinationOptions1;
        //    CrExportOptions1.FormatOptions = CrFormatTypeOptions1;
        //}
        //myreportdocumen.Export();
    }
    #endregion
    protected void btnUpdate_Click(object sender, EventArgs e)
    {


        //if (Page.IsPostBack)
        //{ 

        string slbl = FindLabelCode();
        string script = "";
        if (slbl == "")
        {
            newmsg.Visible = true;
            newmsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            lblmsgHeader.Text = "Please select label type for product  " + txtProName.Text.Trim().Replace("'", "''");
            tabmenu.ActiveTabIndex = 3;
            ModalPopupExtender1.Show();
            script = @"setTimeout(function(){document.getElementById('" + newmsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            return;
        }
        Object9420 obj = new Object9420();
        obj.Pro_Name = txtProName.Text.Trim().Replace("'", "''").ToString();
        obj.Comp_ID = Session["CompanyId"].ToString();
        obj.DateFromChk = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd"));
        obj.Pro_Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy hh:mm:ss tt");
        obj.Pro_Descri = txtprodDes.Text.Trim().Replace("'", "''").ToString();
        obj.Label_Code = slbl;
        if (lblproid.Value == "")
        {
            obj.DML = "I";
            obj.Pro_ID = GenerateProductID();
        }
        else
        {
            obj.DML = "U";
            obj.Pro_ID = lblproid.Value;
        }
        //obj.Pro_ID = lblproid.Value;
        obj.Update_Flag = 0;
        string ext = "";
        if (flSound.FileName != "")
        {
            string path = Server.MapPath("../Data/Sound");
            path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID;
            DataProvider.Utility.CreateDirectory(path);
            path = path + "\\" + obj.Pro_ID + ".wav";
            flSound.SaveAs(path);
            Business9420.function9420.UpdateFileFlagProduct(obj);
            Business9420.function9420.UpdateSoundFlagProduct(obj);
        }
        if (ProDocFileUpload.FileName != "")
        {
            ext = Path.GetExtension(ProDocFileUpload.FileName);
            string path = Server.MapPath("../Data/Sound");
            path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID;
            DirectoryInfo hdDirectoryInWhichToSearch = new DirectoryInfo(path);
            string partialName = obj.Pro_ID + "_ProDoc";
            FileInfo[] filesInDir = hdDirectoryInWhichToSearch.GetFiles(partialName + ".*");
            foreach (FileInfo foundFile in filesInDir)
            {
                foundFile.Delete();
            }
            DataProvider.Utility.CreateDirectory(path);
            path = path + "\\" + obj.Pro_ID + "_ProDoc" + ext;
            ProDocFileUpload.SaveAs(path);
            //Business9420.function9420.UpdateFileFlagProduct(obj);
            Business9420.function9420.UpdateDocFlagProduct(obj);
        }
        if (ext != "")
        {
            obj.Pro_Doc = obj.Pro_ID + "_ProDoc" + ext;
            obj.Doc_Flag = 0;
        }
        else
        {
            obj.Pro_Doc = FileDocDownPath.Text;
            obj.Doc_Flag = Convert.ToInt32(docflag.Value);
        }
        //if (lblproid.Value == "")
        //{
        //    obj.DML = "I";
        //    obj.Pro_ID = GenerateProductID();
        //}
        //else
        //{
        //    obj.DML = "U";
        //    obj.Pro_ID = lblproid.Value;
        //}
        obj.BatchSize = Convert.ToInt64(txtBatchSize.Text.Trim().Replace("'", "''"));
        obj.Dispatch_Location = txtdisatchLoc.Text.Trim().Replace("'", "''");
        function9420.ProductMaster(obj);
        if (ProDocFileUpload.FileName != "")
            Business9420.function9420.UpdateDocFlagProduct(obj);
        #region Mail Logic
        if (obj.DML == "I")
        {
            string CompName = "", ContactPerson = "", CompEmail ="";
            DataTable desdt = SQL_DB.ExecuteDataTable("SELECT Contact_Person,Comp_Name,Comp_Email FROM Comp_Reg WHERE Comp_ID = '" + obj.Comp_ID + "'");
            if(desdt.Rows.Count  > 0)
            {
                CompName = desdt.Rows[0]["Comp_Name"].ToString(); ContactPerson = desdt.Rows[0]["Contact_Person"].ToString(); CompEmail = desdt.Rows[0]["Comp_Email"].ToString(); 
            }
            #region Mail Structure
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
            " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
            " <hr style='border:1px solid #2587D5;'/>" +
            " <div class='w_frame'>" +
            " <p>" +
            " <div class='w_detail'>" +
            " <span>Dear <em><strong>" + ContactPerson + ",</strong></em></span><br />" +
            " <br />" +
            " <span>Congratulations !!!</span>   <br />" +
            " Product <strong> " + obj.Pro_Name + "</strong>  registered successfully.   <br />   <br />" +
            " <br /> Your sound  & document  file has been uploaded successfully. please wait for verification by admin. <br />   <br />" +
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
            string MailBody1 = DataProvider.Utility.FindMailBody(CompName, "Sales department", "Product sound & document file uploaded successfully.");
            string MailBody2 = DataProvider.Utility.FindMailBody(CompName, "Lagal department", "Product sound & document file uploaded successfully.");
            string MailBody3 = DataProvider.Utility.FindMailBody(CompName, "Account department", "Product sound & document file uploaded successfully.");
            string MailBody4 = DataProvider.Utility.FindMailBody(CompName, "IT department", "Product sound & document file uploaded successfully. <br/>");
            DataSet dsMl = function9420.FetchMailDetail("register");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), CompEmail, MailBody, "Product registration status");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), " " + ProjectSession.sales_accomplishtrades + " ", MailBody1, "Company's product sound & document file activation");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), " " + ProjectSession.sales_accomplishtrades + " ", MailBody2, "Company's product sound & document file activation");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), " " + ProjectSession.sales_accomplishtrades + " ", MailBody3, "Company's product sound & document file activation");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), " " + ProjectSession.sales_accomplishtrades + " ", MailBody4, "Company's product sound & document file activation");
                //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Company's product sound & document file activation");
                //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), "legal@label9420.com", MailBody2, "Company's product sound & document file activation");
                //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Company's product sound & document file activation");
                //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Company's product sound & document file activation");
            }
        }
        #endregion
        docflag.Value = string.Empty;
        filldata(); Label3.Text = "";
        /*********** Commented code for new  *******/
        //ChangeValidationGroup(true); 
        ChangeValidationGroup(false);
        NewMsgpop.Visible = true;
        NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");  //class="alert_boxes_pink big_msg"   
        
        allClear();
        filldata();
        Label2.Text = "Product <span style='color:blue;'>" + obj.Pro_Name + "</span> has been updated successfully. Please wait for verification by admin.";
        // lblmsgHeader.Text = "Product <span style='color:blue;'>" + obj.Pro_Name + "</span> has been updated successfully. Please wait for verification by admin.";
        script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        // arb , to stop doubleclick 
        //btnUpdate.Enabled = false;
    //}
    }

    private bool ChkPrintLables(Object9420 Reg)
    {
        int i = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT isnull(COUNT(Pro_ID),0) AS Cnt FROM M_Code WHERE (Pro_ID = '" + Reg.Pro_ID + "') AND (Print_Status = 1)"));
        if (i == 0)
            return false;
        else
            return true;
    }
    private string UpdateProID(string prefix)
    {
        SQL_DB.ExecuteNonQuery("UPDATE [Code_Gen] SET [PrFlag] = '0' WHERE [Prfor] = 'Product'");
        SQL_DB.ExecuteNonQuery("INSERT INTO [Code_Gen]" +
           " ([Prfor]" +
           " ,[PrPrefix]" +
           " ,[PrStart]" +
           " ,[PrFlag])" +
           " VALUES" +
           " ('Product'" +
           " ,'" + prefix + "'" +
           " ,100" +
           " ,'1')");
        return SQL_DB.ExecuteScalar("SELECT [PrPrefix] + substring(convert(nvarchar,[PrStart]),2,2) as Product_Id" +
         " FROM [Code_Gen] where [Prfor] = 'Product' and [PrFlag] = 1").ToString();
    }


    private string GenerateProductID()
    {
        string a1 = "";
        string prefix = "";
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [PrPrefix] + substring(convert(nvarchar,[PrStart]),2,2) as Product_Id,[PrStart]" +
        " FROM [Code_Gen] where [Prfor] = 'Product' and [PrFlag] = 1");
        int char1 = (int)Convert.ToChar(ds.Tables[0].Rows[0]["Product_Id"].ToString().Substring(0, 1));
        int char2 = (int)Convert.ToChar(ds.Tables[0].Rows[0]["Product_Id"].ToString().Substring(1, 1));
        if (ds.Tables[0].Rows[0]["PrStart"].ToString() == "200" && char2 == 90 && char1 == 90)
        {
            return a1;
        }
        if (ds.Tables[0].Rows[0]["PrStart"].ToString() == "200" && char2 != 90)
        {
            char2 = char2 + 1;
            prefix = Char.ConvertFromUtf32(char1) + Char.ConvertFromUtf32(char2);
            return UpdateProID(prefix);
        }
        if (ds.Tables[0].Rows[0]["PrStart"].ToString() == "200" && char2 == 90)
        {
            char1 = char1 + 1;
            char2 = 65;
            prefix = Char.ConvertFromUtf32(char1) + Char.ConvertFromUtf32(char2);
            return UpdateProID(prefix);
        }
        return ds.Tables[0].Rows[0]["Product_Id"].ToString();
    }

    protected void btnResetNew_Click(object sender, EventArgs e)
    {
        NewMsgpop.Visible = false;
        allClear();
        txtProName.Attributes.Add("onchange", "CheckProductNew(this.value)");
        flSound.Attributes.Add("onchange", "fileTypeCheckengNew(this.value)");
        ProDocFileUpload.Attributes.Add("onchange", "fileTypeCheckengNew12(this.value)");
        Label2.Text = "";
        Object9420 obj = new Object9420();
        obj.Pro_ID = lblproiddel.Text.ToString();
        DataSet ds = function9420.UpdateData(obj);
        if (ds.Tables[0].Rows.Count > 0)
        {
            lblproid.Value = lblproiddel.Text.ToString();
            txtProName.Text = ds.Tables[0].Rows[0]["Pro_Name"].ToString();
            if (ds.Tables[0].Rows[0]["Pro_Desc"].ToString() == "")
                txtprodDes.Text = "";
            else
                txtprodDes.Text = ds.Tables[0].Rows[0]["Pro_Desc"].ToString();
            FileDocDownPath.Text = ds.Tables[0].Rows[0]["Pro_Doc"].ToString();
            FileDownDoc.NavigateUrl = ds.Tables[0].Rows[0]["ProDocPath"].ToString();
            FileDown.HRef = ds.Tables[0].Rows[0]["SoundPath"].ToString();
            Session["LabelCode"] = ds.Tables[0].Rows[0]["Label_Code"].ToString();
            docflag.Value = ds.Tables[0].Rows[0]["Doc_Flag"].ToString();
            FileDown.Visible = true;
            FileDownDoc.Visible = true;
            TabPanelAMC.Visible = false;
            TabPanelMsg.Visible = false;
            btnUpdate.Visible = true;
            btnResetNew.Visible = true;
        }
        FillLabelDetGrd();
        lblheading.Text = "Update Product";
        ChangeValidationGroup(false);
        newmsg.Visible = false;
        ModalPopupExtender1.Show();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        if (Session["Comp_type"].ToString() == "L")
        {
            allClear();
            lblmsgHeader.Text = ""; Label2.Text = ""; Label3.Text = "";
            NewMsgpop.Visible = false;
            newmsg.Visible = false;
            TabPanelAMC.Visible = true;
            TabPanelMsg.Visible = true;
            btnUpdate.Visible = false;
            btnResetNew.Visible = false;
        }
        tabmenu.ActiveTabIndex = 0;
        ModalPopupExtender1.Show();
    }

    private void allClear()
    {
        txtdisatchLoc.Text = string.Empty;
        txtBatchSize.Text = string.Empty;
        txtProName.Attributes.Add("onchange", "checkproduct(this.value)");
        flSound.Attributes.Add("onchange", "fileTypeCheckeng(this.value)");
        ProDocFileUpload.Attributes.Add("onchange", "fileTypeCheckeng11111(this.value)");
        FileDown.HRef = "";
        FileDown.Visible = false;
        FileDownDoc.NavigateUrl = "";
        FileDownDoc.Visible = false;
        FileDocDownPath.Text = "";
        lblheading.Text = "Add Product";
        btnSave.Text = "Save";
        txtProName.Text = "";
        txtprodDes.Text = "";
        txtProName.Focus();
        Label2.Text = "";
        Label3.Text = "";
        lblmsgHeader.Text = "";
        RdYesMessage.Enabled = true;
        RdNoMessage.Enabled = true;
        RdYesMessage.Checked = true;
        RdNoMessage.Checked = false;
        txtdtfromamc.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy");
        //txtdtfromamc2.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy");
        txtdtfromamc2.Text = string.Empty;
        txtdttoamc.Text = string.Empty;
        txtdttoamc2.Text = string.Empty;
        txtCommentsTxt.Text = string.Empty;
        lblproid.Value = string.Empty;
    }

    private void FillAmcOfferDetails(string Plan, TextBox Date_From, TextBox Date_To, HiddenField HdnFiled, Object9420 obj)
    {
        function9420.GetAmcPlan(obj);
        if (Plan == "AMC")
        {
            Session["Plan_ID"] = obj.Plan_ID;
            HdnFiled.Value = Convert.ToInt32(Convert.ToInt32(obj.Row_ID) - 1).ToString();
            HdFieldAmcId.Value = function9420.FindRowID();
        }
        else if (Plan == "Promo")
        {
            Session["PromoId"] = obj.Plan_ID;
            HdnFiled.Value = obj.Plan_ID.ToString();
        }
        Date_From.Text = Convert.ToDateTime(obj.DateFrom).ToString("dd/MM/yyyy");
        Date_To.Text = Convert.ToDateTime(obj.DateTo).ToString("dd/MM/yyyy");

    }
    protected void btnLoyalty_Click(object sender, EventArgs e)
    {
        //if (chkloyalty.Checked)
        //{
        //    Loyalty_Programm Reg = new Loyalty_Programm();
        //    Reg.Pro_ID = lblproiddel.Text;
        //    Reg.Comp_ID = Session["CompanyId"].ToString();
        //    Reg.DateFrom = Convert.ToDateTime(Convert.ToDateTime(txtloyaltydtfrom.Text).ToString("yyyy/MM/dd hh:mm:ss tt"));
        //    Reg.DateTo = Convert.ToDateTime(Convert.ToDateTime(txtloyaltydtto.Text).ToString("yyyy/MM/dd hh:mm:ss tt"));
        //    Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        //    if (chkconvert.Checked)
        //        Reg.IsCashConvert = 0;
        //    else
        //        Reg.IsCashConvert = 1;
        //    if (chkIsActive.Checked)
        //        Reg.IsActive = 0;
        //    else
        //        Reg.IsActive = 1;
        //    if (chkIsDelete.Checked)
        //        Reg.IsDelete = 1;
        //    else
        //        Reg.IsDelete = 0;
        //    Reg.Points = Convert.ToDecimal(txtloyaltypoints.Text);
        //    if (btnloyaltysaveupdate.Text == "Save")
        //    {
        //        Reg.DML = "I";
        //        Label2.Text = "Loyalty Programm saved successfully fot this Product!";
        //    }
        //    else
        //    {
        //        Reg.DML = "U";
        //        Label2.Text = "Loyalty Programm saved successfully fot this Product!";
        //    }
        //    Loyalty_Programm.InsertUpdateLoyalty(Reg);
        //    NewMsgpop.Visible = true;
        //    NewMsgpop.Attributes.Add("class", "alert_boxes_pink big_msg");
        //}
        //else
        //{
        //    NewMsgpop.Visible = true;
        //    NewMsgpop.Attributes.Add("class", "alert_boxes_pink big_msg");
        //    Label2.Text = "Please select Loyalty Required!";
        //}
    }
    protected void GrdProductMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        currindex.Value = string.Empty; txtdttoamc3.Text = string.Empty;
        NewMsgpop.Visible = false;
        lblproiddel.Text = e.CommandArgument.ToString();
        lblproidamc.Value = lblproiddel.Text;
        if (e.CommandName == "EditRow")
        {
            Response.Redirect("AddProduct.aspx?id=" + e.CommandArgument.ToString());
            //allClear();
            //txtProName.Attributes.Add("onchange", "CheckProductNew(this.value)");
            //flSound.Attributes.Add("onchange", "fileTypeCheckengNew(this.value)");
            //ProDocFileUpload.Attributes.Add("onchange", "fileTypeCheckengNew12(this.value)");
            //Label2.Text = "";
            //Object9420 obj = new Object9420();
            //obj.Pro_ID = e.CommandArgument.ToString();
            //DataSet ds = function9420.UpdateData(obj);
            //if (ds.Tables[0].Rows.Count > 0)
            //{
            //    lblproid.Value = e.CommandArgument.ToString();
            //    txtProName.Text = ds.Tables[0].Rows[0]["Pro_Name"].ToString();
            //    if (ds.Tables[0].Rows[0]["Pro_Desc"].ToString() == "")
            //        txtprodDes.Text = "";
            //    else
            //        txtprodDes.Text = ds.Tables[0].Rows[0]["Pro_Desc"].ToString();
            //    FileDocDownPath.Text = ds.Tables[0].Rows[0]["Pro_Doc"].ToString();
            //    FileDownDoc.NavigateUrl = ds.Tables[0].Rows[0]["ProDocPath"].ToString();
            //    FileDown.HRef = ds.Tables[0].Rows[0]["SoundPath"].ToString();
            //    Session["LabelCode"] = ds.Tables[0].Rows[0]["Label_Code"].ToString();
            //    docflag.Value = ds.Tables[0].Rows[0]["Doc_Flag"].ToString();
            //    txtBatchSize.Text = ds.Tables[0].Rows[0]["BtSize"].ToString();
            //    txtdisatchLoc.Text = ds.Tables[0].Rows[0]["Dispatch_Location"].ToString();
               
            //    FileDown.Visible = true;
            //    FileDownDoc.Visible = true;
               
            //    TabPanelAMC.Visible = false;
            //    TabPanelMsg.Visible = false;
            //    btnUpdate.Visible = true;
            //    btnResetNew.Visible = true;
            //}
            //FillLabelDetGrd();            
            //lblheading.Text = "Update Product";
            //ChangeValidationGroup(false);
            //newmsg.Visible = false;
            //ModalPopupExtender1.Show();
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
            CheckValidation(false);
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
    private void CheckValidation(bool Flag)
    {
        if (Flag == true)
        {
            chkComments.Visible = false;
            CheckBox1.Visible = false;
            CheckBox2.Visible = false;
            RequiredFieldValidator12.ValidationGroup = "NN";
            RequiredFieldValidator10.ValidationGroup = "NN";
            RequiredFieldValidator11.ValidationGroup = "NN";
        }
        else
        {
            chkComments.Visible = true;
            CheckBox1.Visible = true;
            CheckBox2.Visible = true;
            RequiredFieldValidator12.ValidationGroup = "promo";
            RequiredFieldValidator10.ValidationGroup = "promo";
            RequiredFieldValidator11.ValidationGroup = "promo";
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

    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        NewMsgpop.Visible = false;
        filldata();
    }

    protected void GrdProductMaster_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        NewMsgpop.Visible = false;
        GrdProductMaster.PageIndex = e.NewPageIndex;
        filldata();
    }
    protected void btnNext1_Click(object sender, EventArgs e)
    {
        tabmenu.ActiveTabIndex = tabmenu.ActiveTabIndex + 1;
        ModalPopupExtender1.Show();
    }
    protected void btnPre1_Click(object sender, EventArgs e)
    {
        tabmenu.ActiveTabIndex = tabmenu.ActiveTabIndex - 1;
        ModalPopupExtender1.Show();
    }
    protected void btnNext2_Click(object sender, EventArgs e)
    {
        tabmenu.ActiveTabIndex = tabmenu.ActiveTabIndex + 1;
        ModalPopupExtender1.Show();
    }
    protected void btnPre2_Click(object sender, EventArgs e)
    {
        tabmenu.ActiveTabIndex = tabmenu.ActiveTabIndex - 1;
        ModalPopupExtender1.Show();
    }
    protected void btnNext3_Click(object sender, EventArgs e)
    {
        tabmenu.ActiveTabIndex = tabmenu.ActiveTabIndex + 1;
        ModalPopupExtender1.Show();
    }
    protected void btnPre3_Click(object sender, EventArgs e)
    {
        tabmenu.ActiveTabIndex = tabmenu.ActiveTabIndex - 1;
        ModalPopupExtender1.Show();
    }
    protected void btnNext4_Click(object sender, EventArgs e)
    {
        tabmenu.ActiveTabIndex = tabmenu.ActiveTabIndex + 1;
        ModalPopupExtender1.Show();
    }
    protected void btnPre4_Click(object sender, EventArgs e)
    {
        tabmenu.ActiveTabIndex = tabmenu.ActiveTabIndex - 1;
        ModalPopupExtender1.Show();
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
            " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
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
            " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
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
        CheckValidation(false);
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
    private void ChkPromotional(bool Flag, int i)
    {
        if (Flag == true)
        {
            RdNoMessage.Checked = true;
            RdYesMessage.Checked = false;
            //Promotional.Visible = true;
            FillGridChkPromotional(i, GrdVwPromotional);
        }
        else
        {
            RdNoMessage.Checked = false;
            RdYesMessage.Checked = true;
            //Promotional.Visible = false;            
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
    protected void btnYesConfirm_Click(object sender, EventArgs e)
    {
        SQL_DB.ExecuteNonQuery("UPDATE M_Label_Request SET Flag = 2 FROM M_Label_Request WHERE Pro_ID = '" + lblproid.Value + "' AND  Flag = 0 ");
        newmsg.Visible = true;
        newmsg.Attributes.Add("class", "alert_boxes_green big_msg");
        lblmsgHeader.Text = "All pending request calceled successfully !";
        tabmenu.ActiveTabIndex = 3;
        ModalPopupExtender1.Show();
        string script = @"setTimeout(function(){document.getElementById('" + newmsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
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
                        CheckValidation(true);
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
        //if (LabelExectute.Text.ToString() == "CancelPlan")
        //{
        //    Object9420 Reg = new Object9420();
        //    Reg.Comp_ID = Session["CompanyId"].ToString();
        //    Reg.Pro_ID = lblproiddel.Text;
        //    Reg.Head_Name = "Offer";
        //    Reg.Cancelled_By = Session["User_Type"].ToString() + " ( " + DataProvider.TransType.Cancelled.ToString() + ")";
        //    Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        //    Reg.Remarks = txtremarks.Text.Trim().Replace("'", "''");
        //    Reg.Head_ID = HdnUpdatePlanTransID.Value.ToString();
        //    function9420.CancelledAmcOfferPlan(Reg);
        //    NewMsgpop.Visible = true;
        //    NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
        //    Label2.Text = "Product Offer has been cancelled successfully with Invoice !";
        //    string script1 = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
        //    lblproiddel.Text = string.Empty; HdDateTo3.Value = string.Empty; txtdttoamc3.Text = string.Empty; HdnUpdatePlanTransID.Value = string.Empty; LabelExectute.Text = string.Empty;
        //    filldata();
        //}

    }

    //protected void imgNew_Click1(object sender, EventArgs e)
    //{

    //}
}