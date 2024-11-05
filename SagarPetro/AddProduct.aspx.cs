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
public partial class Patanjali_AddProduct : System.Web.UI.Page
{

    public string server = Convert.ToString(ConfigurationManager.ConnectionStrings["ServerName"].ConnectionString), userID = Convert.ToString(ConfigurationManager.ConnectionStrings["UserName"].ConnectionString), password = Convert.ToString(ConfigurationManager.ConnectionStrings["Password"].ConnectionString);
    public int c = 0, str = 0, upplanindex = 0, upamcindex = 0, upofindex = 0, index = 0, pindex = 0, planindex = 0, Disp = 0, promoDisp = 0, dispindex = 0, promoind = 0; public string TransType = "", Comptype = "", LCode = "", PlanID = "", PromoID = ""; public bool LabelFlag = false;
    public int CntDays = 0, IsCancel = 0, Loyalty = 0;
    public string srt = DataProvider.Utility.FindMailBody();

    private string _Proid_Prop;
    public string Proid_Prop
    {
        get { return (string)ViewState["_Proid_Prop"]; }
        set { ViewState["_Proid_Prop"] = value; }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../patanjali/loginpfl.aspx?Page=AddProduct.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["id"] != null)
            {
                Proid_Prop = Convert.ToString(Request.QueryString["id"]);
            }
            hhdnCompID.Value = Session["CompanyId"].ToString().Substring(5, 4);
            Session["Path"] = Server.MapPath("../Data/Sound");
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            //if (Session["Comp_type"].ToString() == "D")
            //    imgNew.Visible = false;
            //else
            //    imgNew.Visible = true;
            Session["LabelCode"] = ""; Session["Plan_ID"] = ""; Session["PromoId"] = ""; Session["BeyondOffer"] = "";
            filldata();
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
        if (ext.ToUpper() == ".MP3")
            return true;
        else
            return false;
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
            return Reg.Path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\" + Reg.Pro_ID + Arr[1] + ".mp3";
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
        allClear();
        txtProName.Attributes.Add("onchange", "CheckProductNew(this.value)");
        flSound.Attributes.Add("onchange", "fileTypeCheckengNew(this.value)");
        ProDocFileUpload.Attributes.Add("onchange", "fileTypeCheckengNew12(this.value)");
        Label2.Text = "";
        Object9420 obj = new Object9420();
        obj.Pro_ID = Proid_Prop;
        DataSet ds = function9420.UpdateData(obj);
        if (ds.Tables[0].Rows.Count > 0)
        {
            lblproid.Value = obj.Pro_ID;
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
            txtBatchSize.Text = ds.Tables[0].Rows[0]["BtSize"].ToString();
            txtdisatchLoc.Text = ds.Tables[0].Rows[0]["Dispatch_Location"].ToString();

            FileDown.Visible = true;
            FileDownDoc.Visible = true;

            //  TabPanelAMC.Visible = false;
            //  TabPanelMsg.Visible = false;
            //  btnUpdate.Visible = true;
            //  btnResetNew.Visible = true;
        }
        FillLabelDetGrd();
        lblheading.Text = "Update Product";
        ChangeValidationGroup(false);
        //newmsg.Visible = false;
        //    Object9420 obj = new Object9420();
        //    obj.Comp_ID = Session["CompanyId"].ToString();
        //    obj.Pro_Name = txtProductName.Text.Trim().Replace("'", "''");
        //    obj.Pro_ID = "";
        //    //DataSet ds = function9420.FetchData(obj);
        //    DataSet ds = function9420.FetchSearchData(obj);
        //    if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        //    {
        //        if (ds.Tables[0].Rows.Count > 0)
        //            GrdProductMaster.PageSize = ds.Tables[0].Rows.Count;
        //    }
        //    else
        //        GrdProductMaster.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        //    if (ds.Tables[0].Rows.Count > 0)
        //        GrdProductMaster.DataSource = ds.Tables[0];
        //    GrdProductMaster.DataBind();

        //    if (GrdProductMaster.Rows.Count > 0)
        //        GrdProductMaster.HeaderRow.TableSection = TableRowSection.TableHeader;
        //    lblcount.Text = GrdProductMaster.Rows.Count.ToString();
    }

    protected void btnNextInfo_Click(object sender, EventArgs e)
    {
        //ModalPopupExtender1.Show();
        //tabmenu.ActiveTabIndex = 1;
    }
    protected void btnAlertForNewPro_Click(object sender, EventArgs e)
    {
        //newmsg.Visible = false;
        //ModalPopupExtender1.Show();
    }
    protected void btnYesAlert_Click(object sender, EventArgs e)
    {
        //Object9420 Reg = new Object9420();
        //Reg.Pro_ID = lblproiddel.Text;
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //string path = "";
        //DataSet dsS = SQL_DB.ExecuteDataSet("SELECT [Row_ID],[Pro_ID] FROM  T_Pro WHERE  [Pro_ID] = '" + Reg.Pro_ID + "' ");
        //for (int i = 0; i < dsS.Tables[0].Rows.Count; i++)
        //{
        //    path = Server.MapPath("../Data/Sound");
        //    path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\" + dsS.Tables[0].Rows[i]["Row_ID"].ToString();
        //    DataProvider.Utility.DeleteDirectory(path);
        //}
        //path = Server.MapPath("../Data/Sound");
        //path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + Reg.Pro_ID;
        //DataProvider.Utility.DeleteDirectory(path);
        //function9420.ProductReset(Reg);
        //ChangeValidationGroup(true);
        //filldata();
        //NewMsgpop.Visible = true;
        //NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
        //Label2.Text = "Product " + Reg.Pro_Name + " has been deleted successfully !";
        //string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }
    protected void btnNoAlert_Click(object sender, EventArgs e)
    {

    }

    protected void btnNextLabel_Click(object sender, EventArgs e)
    {
        //ModalPopupExtender1.Show();
        //tabmenu.ActiveTabIndex = 2;
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

        DataSet ds = function9420.FillGridPlan(Reg);

        DataView dv = ds.Tables[0].DefaultView;
        dv.RowFilter = "Flag = 1";
        // GrdViewAMC.DataSource = dv;
        //GrdViewAMC.DataBind();

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
        string script = "";
        if (slbl == "")
            slbl = "LBL_1000";

        //if (slbl == "")
        //{
        //    newmsg.Visible = true;
        //    newmsg.Attributes.Add("class", "alert_boxes_pink big_msg");
        //    lblmsgHeader.Text = "Please select label type for product  " + txtProName.Text.Trim().Replace("'", "''");
        //    //tabmenu.ActiveTabIndex = 3;
        //    // ModalPopupExtender1.Show();
        //    script = @"setTimeout(function(){document.getElementById('" + newmsg.ClientID + "').style.display='none';},5000);";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);

        //    ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please select label type for product  " + txtProName.Text.Trim().Replace("'", "''") + "', 'error');", true);
        //    return;
        //}


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

        //Added by Bipin for patanjali 21092023
        string path1 = "";
        string path2 = "";
        string path3 = "";
        //Added by Bipin for patanjali 21092023


        if (flSound.FileName != "")
        {
            string path = Server.MapPath("../Data/Sound");
            path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID;
            DataProvider.Utility.CreateDirectory(path);
            path = path + "\\" + obj.Pro_ID + ".mp3";
            flSound.SaveAs(path);
            Business9420.function9420.UpdateFileFlagProduct(obj);
            Business9420.function9420.UpdateSoundFlagProduct(obj);
        }
        else if (FileDown.HRef != "")
        {
        }
        else
        {
            Label2.Text = "Please upload sound file !";
            // lblmsgHeader.Text = "Product <span style='color:blue;'>" + obj.Pro_Name + "</span> has been updated successfully. Please wait for verification by admin.";
            script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);

            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please upload sound file !', 'error');", true);

            return;
        }
       


        if (ProDocFileUpload.FileName != "")
        {
            ext = Path.GetExtension(ProDocFileUpload.FileName);
            string path = Server.MapPath("../Data/Sound");
            path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID;
            DirectoryInfo hdDirectoryInWhichToSearch = new DirectoryInfo(path);
            string partialName = obj.Pro_ID + "_ProDoc";
            if (FileDownDoc.NavigateUrl != "")
            {
                FileInfo[] filesInDir = hdDirectoryInWhichToSearch.GetFiles(partialName + ".*");
                foreach (FileInfo foundFile in filesInDir)
                {
                    foundFile.Delete();
                }
            }

            DataProvider.Utility.CreateDirectory(path);
            path = path + "\\" + obj.Pro_ID + "_ProDoc" + ext;
            ProDocFileUpload.SaveAs(path);
            //Business9420.function9420.UpdateFileFlagProduct(obj);
            Business9420.function9420.UpdateDocFlagProduct(obj);
        }
        else if (FileDownDoc.NavigateUrl != "")
        {
        
        }
        else
        {
            Label2.Text = "Please leagal document !";
            // lblmsgHeader.Text = "Product <span style='color:blue;'>" + obj.Pro_Name + "</span> has been updated successfully. Please wait for verification by admin.";
            script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);


            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please leagal document !', 'error');", true);

            return;
        }


            if (ext != "")
            {
                obj.Pro_Doc = obj.Pro_ID + "_ProDoc" + ext;
                obj.Doc_Flag = 0;
            }
            else
            {
                obj.Pro_Doc = FileDocDownPath.Text;
                if (docflag.Value != "")
                {
                    obj.Doc_Flag = Convert.ToInt32(docflag.Value);
                }

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
            string CompName = "", ContactPerson = "", CompEmail = "";
            DataTable desdt = SQL_DB.ExecuteDataTable("SELECT Contact_Person,Comp_Name,Comp_Email FROM Comp_Reg WHERE Comp_ID = '" + obj.Comp_ID + "'");
            if (desdt.Rows.Count > 0)
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


        //NewMsgpop.Visible = true;
        //NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");  //class="alert_boxes_pink big_msg"   

        allClear();
        filldata();


        //Label2.Text = "Product <span style='color:blue;'>" + obj.Pro_Name + "</span> has been updated successfully. Please wait for verification by admin.";
        //lblmsgHeader.Text = "Product <span style='color:blue;'>" + obj.Pro_Name + "</span> has been updated successfully. Please wait for verification by admin.";
        //script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);


        ScriptManager.RegisterStartupScript(this, GetType(), "Updated", "showAlert('Success', 'Product " + obj.Pro_Name + "has been updated successfully. Please wait for verification by admin.', 'success');", true);
       
        
        
    }
    //protected void savebulk_Click(object sender, EventArgs e)
    //{
    //    string slbl = FindLabelCode();
    //    string product = "1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1024,1025,1026,1027,1028,1029,1030,1031,1032,1033,1034,1035,1050,1051,1501,1502,1503,1504,1505,1506,1507,1508,1509,1510,1511,1512,1513,1514,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,3001,3002,3003,3004,3005,3006,3007,3008,3009,3010,3011,3012,3013,3014,3015,3016,3017,3018,4001,4002,4003,4004,4005,4006,4007,4008,4009,4010,4011,4012,4013,4014,4015,4016,4017,4025,4026,4027,4028,4029,4030,4050,4051,4052,4053,4054,4055,4056,4057,4058,4059,4060,4061,5001,5002,5003,5004,5005,5006,5007,5008,6001,6002,6003,6004,6005,6006,6007,6008,6009,6010,6011,6012,6013,6014,6015,6016,6017,6018,6019,6020,6021,6022,6023,6024,6025,6026,6027,6028,6029,6030,6031,6032,6033,6034,6035,6036,6037,6038,6039,6040,6041,6042,6043,6044,6045,6046,6047,6048,6049,6050,6051,6052,6053,6054,6055,7001,7002,7003,7004,7005,7006,7007,7008,7009,7010,7011,7012,7013,7014,7015,7016,7017,7018,7019,7020,7021,7022,7023,7024,7025,7026,7027,7028,7501,7502,7503,7504,7505,7506,7507,7508,8001,8002,8003,8004,8005,8006,8007,8008,8009,8010,8011,8012,8013,8014,8015,8016,8017,8018,8019,8020,8021,8022,8023,8024";
    //    string[] productllist = product.Split(',');
    //    string script = "";
    //    if (slbl == "")
    //    {
    //        newmsg.Visible = true;
    //        newmsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //        lblmsgHeader.Text = "Please select label type for product  " + txtProName.Text.Trim().Replace("'", "''");
    //        //tabmenu.ActiveTabIndex = 3;
    //        // ModalPopupExtender1.Show();
    //        script = @"setTimeout(function(){document.getElementById('" + newmsg.ClientID + "').style.display='none';},5000);";
    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    //        return;
    //    }
    //    foreach (string item in productllist)
    //    {


    //        Object9420 obj = new Object9420();
    //        obj.Pro_Name = item.Trim().Replace("'", "''").ToString();
    //        obj.Comp_ID = Session["CompanyId"].ToString();
    //        obj.DateFromChk = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd"));
    //        obj.Pro_Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy hh:mm:ss tt");
    //        obj.Pro_Descri = item.Trim().Replace("'", "''").ToString();
    //        obj.Label_Code = slbl;
    //        if (lblproid.Value == "")
    //        {
    //            obj.DML = "I";
    //            obj.Pro_ID = GenerateProductID();
    //        }
    //        else
    //        {
    //            obj.DML = "U";
    //            obj.Pro_ID = lblproid.Value;
    //        }
    //        //obj.Pro_ID = lblproid.Value;
    //        obj.Update_Flag = 0;
    //        string ext = "";
    //        if (flSound.FileName != "")
    //        {
    //            string path = Server.MapPath("../Data/Sound");
    //            path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID;
    //            DataProvider.Utility.CreateDirectory(path);
    //            path = path + "\\" + obj.Pro_ID + ".mp3";
    //            flSound.SaveAs(path);
    //            Business9420.function9420.UpdateFileFlagProduct(obj);
    //            Business9420.function9420.UpdateSoundFlagProduct(obj);
    //        }
    //        if (ProDocFileUpload.FileName != "")
    //        {
    //            ext = Path.GetExtension(ProDocFileUpload.FileName);
    //            string path = Server.MapPath("../Data/Sound");
    //            path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID;
    //            DirectoryInfo hdDirectoryInWhichToSearch = new DirectoryInfo(path);
    //            string partialName = obj.Pro_ID + "_ProDoc";
    //            FileInfo[] filesInDir = hdDirectoryInWhichToSearch.GetFiles(partialName + ".*");
    //            foreach (FileInfo foundFile in filesInDir)
    //            {
    //                foundFile.Delete();
    //            }
    //            DataProvider.Utility.CreateDirectory(path);
    //            path = path + "\\" + obj.Pro_ID + "_ProDoc" + ext;
    //            ProDocFileUpload.SaveAs(path);
    //            //Business9420.function9420.UpdateFileFlagProduct(obj);
    //            Business9420.function9420.UpdateDocFlagProduct(obj);
    //        }
    //        if (ext != "")
    //        {
    //            obj.Pro_Doc = obj.Pro_ID + "_ProDoc" + ext;
    //            obj.Doc_Flag = 0;
    //        }
    //        else
    //        {
    //            obj.Pro_Doc = FileDocDownPath.Text;
    //            obj.Doc_Flag = Convert.ToInt32(docflag.Value);
    //        }
    //        //if (lblproid.Value == "")
    //        //{
    //        //    obj.DML = "I";
    //        //    obj.Pro_ID = GenerateProductID();
    //        //}
    //        //else
    //        //{
    //        //    obj.DML = "U";
    //        //    obj.Pro_ID = lblproid.Value;
    //        //}
    //        obj.BatchSize = Convert.ToInt64("100");
    //        obj.Dispatch_Location = "Greater Noida";
    //        function9420.ProductMaster(obj);
    //        if (ProDocFileUpload.FileName != "")
    //            Business9420.function9420.UpdateDocFlagProduct(obj);
    //        #region Mail Logic
    //        if (obj.DML == "I")
    //        {
    //            string CompName = "", ContactPerson = "", CompEmail = "";
    //            DataTable desdt = SQL_DB.ExecuteDataTable("SELECT Contact_Person,Comp_Name,Comp_Email FROM Comp_Reg WHERE Comp_ID = '" + obj.Comp_ID + "'");
    //            if (desdt.Rows.Count > 0)
    //            {
    //                CompName = desdt.Rows[0]["Comp_Name"].ToString(); ContactPerson = desdt.Rows[0]["Contact_Person"].ToString(); CompEmail = desdt.Rows[0]["Comp_Email"].ToString();
    //            }
    //            #region Mail Structure
    //            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
    //            " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
    //            " <hr style='border:1px solid #2587D5;'/>" +
    //            " <div class='w_frame'>" +
    //            " <p>" +
    //            " <div class='w_detail'>" +
    //            " <span>Dear <em><strong>" + ContactPerson + ",</strong></em></span><br />" +
    //            " <br />" +
    //            " <span>Congratulations !!!</span>   <br />" +
    //            " Product <strong> " + obj.Pro_Name + "</strong>  registered successfully.   <br />   <br />" +
    //            " <br /> Your sound  & document  file has been uploaded successfully. please wait for verification by admin. <br />   <br />" +
    //            " <p>" +
    //            " <div class='w_detail'>" +
    //            " Assuring you  of  our best services always.<br />" +
    //            " Thank you,<br /><br />" +
    //            " Team <em><strong>VCQRU.COM,</strong></em><br />" +
    //            "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
    //            " </div>" +
    //            " </p>" +
    //            " </div>" +
    //            " </p>" +
    //            " </div> " +
    //            " </div> ";
    //            #endregion
    //            string MailBody1 = DataProvider.Utility.FindMailBody(CompName, "Sales department", "Product sound & document file uploaded successfully.");
    //            string MailBody2 = DataProvider.Utility.FindMailBody(CompName, "Lagal department", "Product sound & document file uploaded successfully.");
    //            string MailBody3 = DataProvider.Utility.FindMailBody(CompName, "Account department", "Product sound & document file uploaded successfully.");
    //            string MailBody4 = DataProvider.Utility.FindMailBody(CompName, "IT department", "Product sound & document file uploaded successfully. <br/>");
    //            DataSet dsMl = function9420.FetchMailDetail("register");
    //            if (dsMl.Tables[0].Rows.Count > 0)
    //            {
    //                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), CompEmail, MailBody, "Product registration status");
    //                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), " " + ProjectSession.sales_accomplishtrades + " ", MailBody1, "Company's product sound & document file activation");
    //                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), " " + ProjectSession.sales_accomplishtrades + " ", MailBody2, "Company's product sound & document file activation");
    //                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), " " + ProjectSession.sales_accomplishtrades + " ", MailBody3, "Company's product sound & document file activation");
    //                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), " " + ProjectSession.sales_accomplishtrades + " ", MailBody4, "Company's product sound & document file activation");
    //                //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Company's product sound & document file activation");
    //                //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), "legal@label9420.com", MailBody2, "Company's product sound & document file activation");
    //                //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Company's product sound & document file activation");
    //                //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Company's product sound & document file activation");
    //            }
    //        }
    //        #endregion
    //        docflag.Value = string.Empty;
    //        filldata(); Label3.Text = "";
    //        /*********** Commented code for new  *******/
    //        //ChangeValidationGroup(true); 
    //        ChangeValidationGroup(false);
    //        NewMsgpop.Visible = true;
    //        NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");  //class="alert_boxes_pink big_msg"   

    //        allClear();
    //        filldata();
    //        Label2.Text = "Product <span style='color:blue;'>" + obj.Pro_Name + "</span> has been updated successfully. Please wait for verification by admin.";
    //        // lblmsgHeader.Text = "Product <span style='color:blue;'>" + obj.Pro_Name + "</span> has been updated successfully. Please wait for verification by admin.";
    //        script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    //    }
    //}
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
            NewMsgpop.Visible = true;
            NewMsgpop.Attributes.Add("class", "alert_boxes_pink big_msg");
            Label2.Text = "Please select label type for product  " + txtProName.Text.Trim().Replace("'", "''");
            //tabmenu.ActiveTabIndex = 3;
            //ModalPopupExtender1.Show();
            script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);

            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Something Went Wrong Please try After', 'error');", true);
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
            path = path + "\\" + obj.Pro_ID + ".mp3";
            flSound.SaveAs(path);
            Business9420.function9420.UpdateFileFlagProduct(obj);
            Business9420.function9420.UpdateSoundFlagProduct(obj);
        }
        else
        {
            NewMsgpop.Visible = true;
            NewMsgpop.Attributes.Add("class", "alert_boxes_pink big_msg");
            Label2.Text = "Please upload sound file ";
            //tabmenu.ActiveTabIndex = 3;
            //ModalPopupExtender1.Show();
            script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);

            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please upload sound file', 'error');", true);

            return;
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

        else
        {
            NewMsgpop.Visible = true;
            NewMsgpop.Attributes.Add("class", "alert_boxes_pink big_msg");
            Label2.Text = "Please upload legal document file ";
            //tabmenu.ActiveTabIndex = 3;
            //ModalPopupExtender1.Show();
            script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);

            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please upload legal document file', 'error');", true);

            return;
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
            string CompName = "", ContactPerson = "", CompEmail = "";
            DataTable desdt = SQL_DB.ExecuteDataTable("SELECT Contact_Person,Comp_Name,Comp_Email FROM Comp_Reg WHERE Comp_ID = '" + obj.Comp_ID + "'");
            if (desdt.Rows.Count > 0)
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
        filldata(); //Label3.Text = "";
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

        ScriptManager.RegisterStartupScript(this, GetType(), "Updated", "showAlert('Success', 'Updated Successfully!', 'success');", true);


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
        //NewMsgpop.Visible = false;
        //allClear();
        //txtProName.Attributes.Add("onchange", "CheckProductNew(this.value)");
        //flSound.Attributes.Add("onchange", "fileTypeCheckengNew(this.value)");
        //ProDocFileUpload.Attributes.Add("onchange", "fileTypeCheckengNew12(this.value)");
        //Label2.Text = "";
        //Object9420 obj = new Object9420();
        //obj.Pro_ID = lblproiddel.Text.ToString();
        //DataSet ds = function9420.UpdateData(obj);
        //if (ds.Tables[0].Rows.Count > 0)
        //{
        //    lblproid.Value = lblproiddel.Text.ToString();
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
    protected void btnReset_Click(object sender, EventArgs e)
    {
        //if (Session["Comp_type"].ToString() == "L")
        //{
        //    allClear();
        //    lblmsgHeader.Text = ""; Label2.Text = ""; Label3.Text = "";
        //    NewMsgpop.Visible = false;
        //    newmsg.Visible = false;
        //    TabPanelAMC.Visible = true;
        //    TabPanelMsg.Visible = true;
        //    btnUpdate.Visible = false;
        //    btnResetNew.Visible = false;
        //}
        //tabmenu.ActiveTabIndex = 0;
        //ModalPopupExtender1.Show();
        Response.Redirect("RegisteredProduct.aspx");
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
        //Label3.Text = "";
        //lblmsgHeader.Text = "";
        //RdYesMessage.Enabled = true;
        //RdNoMessage.Enabled = true;
        //RdYesMessage.Checked = true;
        //RdNoMessage.Checked = false;
        //txtdtfromamc.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy");
        ////txtdtfromamc2.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy");
        //txtdtfromamc2.Text = string.Empty;
        //txtdttoamc.Text = string.Empty;
        //txtdttoamc2.Text = string.Empty;
        //txtCommentsTxt.Text = string.Empty;
        lblproid.Value = string.Empty;
    }

    private void FillAmcOfferDetails(string Plan, TextBox Date_From, TextBox Date_To, HiddenField HdnFiled, Object9420 obj)
    {
        function9420.GetAmcPlan(obj);
        if (Plan == "AMC")
        {
            Session["Plan_ID"] = obj.Plan_ID;
            HdnFiled.Value = Convert.ToInt32(Convert.ToInt32(obj.Row_ID) - 1).ToString();
            //  HdFieldAmcId.Value = function9420.FindRowID();
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
        //currindex.Value = string.Empty; txtdttoamc3.Text = string.Empty;
        NewMsgpop.Visible = false;
        // lblproiddel.Text = e.CommandArgument.ToString();
        // lblproidamc.Value = lblproiddel.Text;
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
            Reg.Pro_ID = e.CommandArgument.ToString();// lblproiddel.Text;
            Reg.Comp_ID = Session["CompanyId"].ToString();
            DataSet ds = function9420.UpdateData(Reg);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //btnNoAlert.Visible = false;
                //LabelAlert.Text = "Alert";
                //lblalert.Text = " Are you sure to delete the <span style='color:blue;'>" + ds.Tables[0].Rows[0]["Pro_Name"].ToString() + "</span> product ?";
                //ModalPopupExtenderAlert.Show();
            }
        }
        else if (e.CommandName == "AudioPlay")
        {
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(Server.MapPath(e.CommandArgument.ToString()));
            player.Play();
        }
        else if (e.CommandName.ToString() == "AmcRenewal")
        {
            //lblAmcText.Visible = false;
            //lblAmcenddate.Text = string.Empty;
            //btnAmcRenewal.Visible = true;
            //btnOfferRenewal.Visible = false;
            //GrdProductsAmc.Columns[0].HeaderText = "Amc Name";
            //DivNewMsg1.Visible = false;
            //Object9420 Amc = new Object9420();
            //Amc.Pro_ID = lblproiddel.Text;
            //Amc.Amt_Type = "AMC";
            //DataSet ds = SQL_DB.ExecuteDataSet("SELECT Amc_Offer_ID,Plan_ID,Plan_Amount,Date_From,Date_To,isnull(Status,0) as Status FROM M_Amc_Offer WHERE Amc_Offer_ID = (SELECT Max(Amc_Offer_ID) FROM M_Amc_Offer WHERE Pro_Id = '" + Amc.Pro_ID + "' AND Trans_Type = '" + Amc.Amt_Type + "' )");
            //Session["Plan_ID"] = ds.Tables[0].Rows[0]["Plan_ID"].ToString();
            //Amc.Plan_ID = Session["Plan_ID"].ToString();
            //HdValAMC1.Value = function9420.GetPlanTime(Amc);
            //HdnUpdatePlanID.Value = Session["Plan_ID"].ToString();
            //HdnUpdatePlanTransID.Value = ds.Tables[0].Rows[0]["Amc_Offer_ID"].ToString();
            //HdnUpdatePlanAmount.Value = ds.Tables[0].Rows[0]["Plan_Amount"].ToString();
            //txtdttoamc1.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["Date_To"].ToString()).ToString("dd/MM/yyyy");
            //txtdtfromamc1.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["Date_From"].ToString()).ToString("dd/MM/yyyy");
            //hdnAmcDateFrom.Value = txtdtfromamc1.Text;
            //hdnAmcDateTo.Value = txtdttoamc1.Text;

            //if (Convert.ToInt32(ds.Tables[0].Rows[0]["Status"]) == 0)
            //{
            //    btnAmcRenewal.Text = "Update";
            //    Amc.PlanAmount = Convert.ToDouble(HdnUpdatePlanAmount.Value); //Convert.ToDouble(Data_9420.GetMaxPlanAmount());
            //    txtdtfromamc1.Enabled = true;
            //}
            //else if (Convert.ToInt32(ds.Tables[0].Rows[0]["Status"]) == 1)
            //{
            //    btnAmcRenewal.Text = "Upgrade";
            //    txtdtfromamc1.Enabled = false;
            //    Amc.PlanAmount = Convert.ToDouble(HdnUpdatePlanAmount.Value);
            //}
            //else
            //{
            //    btnAmcRenewal.Text = "Renewal";
            //    Amc.PlanAmount = Convert.ToDouble(0.00);
            //    txtdtfromamc1.Enabled = true;
            //}
            //MyAmcOfferGrdVw.Visible = true;
            //MyOfferGrdVw.Visible = false;
            ////FillProductAmcAmount(Amc, GrdProductsAmc);
            ////if (GrdProductsAmc.Rows.Count > 6)
            ////    MyAmcOfferGrdVw.Attributes.Add("style", "height: 200px; overflow: auto;");            
            //Amc.Disp = 0;
            //FillPlanGrdAmcRenewal(Amc);
            //MyAmcOfferDetails.Attributes.Add("style", "display:none;");
            //LblAmcRenewalHeader.Text = "Amc Renewal (<span style='color:blue;' >" + SQL_DB.ExecuteScalar("SELECT Pro_Name FROM Pro_Reg WHERE Pro_Id = '" + Amc.Pro_ID + "'") + "</span>)";
            ////txtdtfromamc1.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy");
            //ModalPopupAmcRenewal.Show();
        }
        else if (e.CommandName.ToString() == "OfferRenewal")
        {
            //txtComment.Text = string.Empty;
            //Object9420 Reg = new Object9420();
            //Reg.Pro_ID = lblproiddel.Text;
            //Reg.Trans_Type = "AMC";
            //function9420.GetAmcPlan(Reg);
            //lblCurrAmcStartDate.Text = Convert.ToDateTime(Reg.DateFrom).ToString("dd/MM/yyyy");
            //lblCurrAmcEndDate.Text = Convert.ToDateTime(Reg.DateTo).ToString("dd/MM/yyyy");
            //Reg.Amt_Type = "Offer";
            //CheckValidation(false);
            //if (!function9420.CheckOffer(Reg))
            //{
            //    chkComments.Visible = false;
            //    CheckBox1.Visible = false;
            //    CheckBox2.Visible = false;
            //}
            //else
            //{
            //    chkComments.Checked = false;
            //    chkComments.Visible = true;
            //    A1.Attributes.Add("style", "display:none;");
            //    A2.Attributes.Add("style", "display:none;");
            //    CheckBox1.Visible = true;
            //    CheckBox2.Visible = true;
            //}
            //btnOfferRenewal.Visible = true;
            //btnOfferRenewal.Text = "Save";
            //btnAmcRenewal.Visible = false;
            //GrdProductsAmc.Columns[0].HeaderText = "Offer Name";
            //DivNewMsg1.Visible = false;
            //PanelAmcRenewal.Attributes.Add("style", "width:60%");
            //FillProductAmcAmount(Reg, GrdProductsAmc);
            //if (GrdProductsAmc.Rows.Count > 6)
            //    MyAmcOfferGrdVw.Attributes.Add("style", "height: 200px; overflow: auto;");
            //FillGridChkPromotional(0, GrdVwOfferDetails);
            //txtdtfromamc3.Enabled = true;
            //txtdtfromamc3.Text = string.Empty; //DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy");
            //MyAmcOfferGrdVw.Visible = false;
            //MyOfferGrdVw.Visible = true;
            //LblAmcRenewalHeader.Text = "Offer Renewal (<span style='color:blue;' >" + SQL_DB.ExecuteScalar("SELECT Pro_Name FROM Pro_Reg WHERE Pro_Id = '" + Reg.Pro_ID + "'") + "</span>)";
            //Session["PromoId"] = "";
            //ModalPopupAmcRenewal.Show();
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
            //chkComments.Visible = false;
            //CheckBox1.Visible = false;
            //CheckBox2.Visible = false;
            //RequiredFieldValidator12.ValidationGroup = "NN";
            //RequiredFieldValidator10.ValidationGroup = "NN";
            //RequiredFieldValidator11.ValidationGroup = "NN";
        }
        else
        {
            //chkComments.Visible = true;
            //CheckBox1.Visible = true;
            //CheckBox2.Visible = true;
            //RequiredFieldValidator12.ValidationGroup = "promo";
            //RequiredFieldValidator10.ValidationGroup = "promo";
            //RequiredFieldValidator11.ValidationGroup = "promo";
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
        //  txtDateFrom.Text = ""; txtDateTo.Text = ""; txtProductName.Text = "";
        filldata();
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
        // GrdProductMaster.PageIndex = e.NewPageIndex;
        filldata();
    }
    protected void btnNext1_Click(object sender, EventArgs e)
    {
        // tabmenu.ActiveTabIndex = tabmenu.ActiveTabIndex + 1;
        // ModalPopupExtender1.Show();
    }
    protected void btnPre1_Click(object sender, EventArgs e)
    {
        //  tabmenu.ActiveTabIndex = tabmenu.ActiveTabIndex - 1;
        //  ModalPopupExtender1.Show();
    }
    protected void btnNext2_Click(object sender, EventArgs e)
    {
        //  tabmenu.ActiveTabIndex = tabmenu.ActiveTabIndex + 1;
        //  ModalPopupExtender1.Show();
    }
    protected void btnPre2_Click(object sender, EventArgs e)
    {
        //  tabmenu.ActiveTabIndex = tabmenu.ActiveTabIndex - 1;
        //  ModalPopupExtender1.Show();
    }
    protected void btnNext3_Click(object sender, EventArgs e)
    {
        //tabmenu.ActiveTabIndex = tabmenu.ActiveTabIndex + 1;
        // ModalPopupExtender1.Show();
    }
    protected void btnPre3_Click(object sender, EventArgs e)
    {
        //// tabmenu.ActiveTabIndex = tabmenu.ActiveTabIndex - 1;
        // ModalPopupExtender1.Show();
    }
    protected void btnNext4_Click(object sender, EventArgs e)
    {
        // tabmenu.ActiveTabIndex = tabmenu.ActiveTabIndex + 1;
        // ModalPopupExtender1.Show();
    }
    protected void btnPre4_Click(object sender, EventArgs e)
    {
        //  tabmenu.ActiveTabIndex = tabmenu.ActiveTabIndex - 1;
        //  ModalPopupExtender1.Show();
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
            //DataSet ds = function9420.FillGridPlan(Reg);
            ////DataSet ds = function9420.FillGridPlan(i);
            //DataView dv = ds.Tables[0].DefaultView;
            //dv.RowFilter = "Flag = 1";
            //GrdVwAmcRenewal.DataSource = dv;
            //GrdVwAmcRenewal.DataBind();
            //// csroll set
            //if (ds.Tables[0].Rows.Count > 3)
            //    MyAmcOfferDetails.Attributes.Add("style", "height: 150px; overflow: auto;");
            //// Change Selected rows
            //if (currindex.Value != "")
            //{
            //    System.Drawing.Color col = System.Drawing.Color.FromName("#E2FBED");
            //    GrdProductsAmc.Rows[Convert.ToInt32(currindex.Value)].BackColor = col;
            //}
        }
        catch (Exception ex)
        {
        }
    }

    private void CreateIncoive(Object9420 Amc)
    {
        //************************* Code start For Generate Invoice ******************//
        //if (function9420.CheckForGenerateInvoice(Amc.Pro_ID))
        //{
        //    Object9420 Inv = new Object9420();
        //    Inv.Comp_ID = Amc.Comp_ID;
        //    Inv.Pro_ID = Amc.Pro_ID;
        //    Inv.Plan_ID = Amc.Amc_Offer_ID.ToString();
        //    Inv.FolderPath = Server.MapPath("../Data/Bill");
        //    Inv.Path = Server.MapPath("../Reports") + "\\InvoiceReport.rpt";
        //    Inv.TransRow_ID = HdnUpdatePlanTransID.Value;
        //    Inv.TransType = Amc.TransType;
        //    function9420.CreateInvoice(Inv);
        //}
        //************************* Code end For Generate Invoice ******************//
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
            //RdNoMessage.Checked = true;
            //RdYesMessage.Checked = false;
            ////Promotional.Visible = true;
            //FillGridChkPromotional(i, GrdVwPromotional);
        }
        else
        {
            //RdNoMessage.Checked = false;
            //RdYesMessage.Checked = true;
            ////Promotional.Visible = false;            
        }
    }
    private void FillGridChkPromotional(int i, GridView GrdVwPromotional)
    {
        //DataSet ds = Business9420.function9420.FillPromotional(i);
        //GrdVwPromotional.DataSource = ds.Tables[0];
        //GrdVwPromotional.DataBind();
        //// csroll set
        //if (ds.Tables[0].Rows.Count > 3)
        //    MyAmcOfferDetails.Attributes.Add("style", "height: 150px; overflow: auto;");
        //// Change Selected rows
        //if (currindex.Value != "")
        //{
        //    System.Drawing.Color col = System.Drawing.Color.FromName("#E2FBED");
        //    GrdProductsAmc.Rows[Convert.ToInt32(currindex.Value)].BackColor = col;
        //}
    }
    protected void btnYesConfirm_Click(object sender, EventArgs e)
    {
        //SQL_DB.ExecuteNonQuery("UPDATE M_Label_Request SET Flag = 2 FROM M_Label_Request WHERE Pro_ID = '" + lblproid.Value + "' AND  Flag = 0 ");
        //newmsg.Visible = true;
        //newmsg.Attributes.Add("class", "alert_boxes_green big_msg");
        //lblmsgHeader.Text = "All pending request calceled successfully !";
        //tabmenu.ActiveTabIndex = 3;
        //ModalPopupExtender1.Show();
        //string script = @"setTimeout(function(){document.getElementById('" + newmsg.ClientID + "').style.display='none';},5000);";
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }
}