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
using System.Data.SqlClient;

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
                Response.Redirect("../patanjali/loginpfl.aspx");
        }
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["id"] != null)
            {
                Proid_Prop = Convert.ToString(Request.QueryString["id"]);
                lblheading.Text = "Update Product";
            }
            hhdnCompID.Value = Session["CompanyId"].ToString().Substring(5, 4);
            Session["Path"] = Server.MapPath("../Data/Sound");
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            
            Session["LabelCode"] = ""; Session["Plan_ID"] = ""; Session["PromoId"] = ""; Session["BeyondOffer"] = "";
            filldata();
          //  FillLabelDetGrd();
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


    private bool IsSubscribed(string Pro_ID)
    {
        string Comp_ID = Session["CompanyId"].ToString();

        DataTable dt = SQL_DB.ExecuteDataSet("select s.Pro_ID from M_ServiceSubscription s inner join M_ServiceSubscriptionTrans st on st.Subscribe_Id=s.Subscribe_Id where s.Pro_ID='" + Pro_ID + "' and s.Comp_ID='" + Comp_ID + "' and st.IsDelete=0").Tables[0];
        if (dt.Rows.Count > 0)
            return true;
        else
            return false;
    }
    private void AutoServiceSetting(ObjService obj,string ProId)
    {

        string Productid = ProId;
        bool IsSubcribed = IsSubscribed(ProId);
        if (IsSubcribed)
        {

           

            return;

        }
        

        Loyalty_Programm Reg = new Loyalty_Programm();

        Referral Ref = new Referral();


        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.Pro_ID = ProId;
        Reg.Service_ID = "SRV1018";
        Reg.Subscribe_Id = obj.Subscribe_Id;
        object subscribe_id = null;
        if (Reg.Subscribe_Id == null || Reg.Subscribe_Id == "")
        {


            if (subscribe_id != null)
                Reg.Subscribe_Id = subscribe_id.ToString();
            else
            {
                DataTable dtseubscription = SQL_DB.ExecuteDataTable("select * from m_servicesubscription where pro_id='" + Reg.Pro_ID + "' and comp_id='" + Reg.Comp_ID + "' and service_id='" + Reg.Service_ID + "'");
                Reg.Subscribe_Id = Utility.GetMyGenID("Subscription");
                DataRow dr = dtseubscription.Rows[0];
                dr["subscribe_id"] = Reg.Subscribe_Id;

                dr["entrydate"] = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff");
                DataTable dtsb = dtseubscription.Clone();
                dtsb.ImportRow(dr);
                ConnectionStringSettings settings =
      ConfigurationManager.ConnectionStrings["defaultConnectionbeta"];
                SqlConnection connection = new SqlConnection(settings.ConnectionString);
                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(connection))
                {
                    connection.Open();
                    bulkCopy.DestinationTableName = "[m_servicesubscription]";

                    bulkCopy.WriteToServer(dtsb);


                }
                Utility.SetMyGenID("Subscription");

            }
        }


        int IsSound = 0, IsAdditionalGift = 0;
        string str4 = Reg.Service_ID;

        switch (str4)
        {
            case "SRV1018":
                {

                    break;
                }

            default:
                break;
        }
       

        DataTable dt = SQL_DB.ExecuteDataSet("SELECT ServiceFeaure_ID, Service_ID,(SELECT ServiceName FROM M_Service WHERE Service_ID = M_ServiceFeature.Service_ID) ServiceName, IsPoints, IsDateRange, IsSound, IsFrequency, IsAdditionalGift, IsMessageTemplete, EntryDate, IsDelete FROM M_ServiceFeature WHERE IsDelete = 0 AND Service_ID = '" + Reg.Service_ID + "' ").Tables[0];
        if (dt.Rows.Count > 0)
        {
            IsSound = Convert.ToInt32(dt.Rows[0]["IsSound"].ToString());
            IsAdditionalGift = Convert.ToInt32(dt.Rows[0]["IsAdditionalGift"].ToString());
        }
        
       
        
            Reg.DateFrom = System.DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt");
       
        
            Reg.DateTo = Convert.ToDateTime(System.DateTime.Now.AddMonths(60)).ToString("yyyy/MM/dd hh:mm:ss tt"); // 60 Months or 5 years
       
        Reg.Entry_Date = Convert.ToDateTime(System.DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt"));

        Reg.IsCashConvert = 1;
        Reg.IsActive = 1;
        Reg.IsDelete = 0;
        Reg.Frequency = 1;

        Reg.Points = 0;


        Reg.AmtType = "Fixed";
        Reg.Minval = 0;
        Reg.Maxval = 0;




        Reg.IsCash = 0;

       
        
        if (btnSave.Text == "Save")
        {
            Reg.RowId = 0;
            Reg.DML = "I";
            
        }
       


        Reg.IsReferral = 0;
        Ref = new Referral();

        Reg.Referrals = Ref;

        DateTime? dttxtDueDate = null;



        Loyalty_Programm.InsUpdSrvForProduct(Reg); //[M_ServiceSubscriptionTrans] having inset/update
    }

    private void AutoSubscribed(string ProId ,string DML)
    {

        ObjService Reg = new ObjService();
        Reg.Service_ID = "SRV1018"; //selsrvid.Value;
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.PlanPeriod = 60; // In months for 5 years.
        DataTable dt = SQL_DB.ExecuteDataSet("SELECT Plan_ID, Service_ID,(SELECT m.ServiceName FROM M_Service AS m WHERE m.Service_ID= M_ServicePlan.Service_ID) as ServiceName, PlanName, PlanPeriod, PlanPrice, EntryDate FROM M_ServicePlan WHERE PlanPeriod = '" + Convert.ToInt32(Reg.PlanPeriod) + "' AND IsActive = 0  AND Service_ID = '" + Reg.Service_ID + "' ").Tables[0];
        if (dt.Rows.Count > 0)
        {
            Reg.Plan_ID = dt.Rows[0]["Plan_ID"].ToString();
            Reg.PlanName = dt.Rows[0]["PlanName"].ToString();
            Reg.PlanMasterPeriod = Convert.ToInt64(dt.Rows[0]["PlanPeriod"]);
            Reg.PlanMasterPrice = Convert.ToInt64(dt.Rows[0]["PlanPrice"]);
            Reg.ServiceName = dt.Rows[0]["ServiceName"].ToString();
        }
        Reg.Pro_ID = ProId;
        Reg.DateFrom = System.DateTime.Now;

        Reg.DateTo = System.DateTime.Now.AddMonths(60);// In months for 5 years.
        Reg.EntryDate = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        if (DML == "I")
        {
            Reg.IsActive = 1;
            Reg.IsDelete = 0;
            Reg.IsAdminVerify = 1;
            Reg.DML = "I";
        }
        
        ObjService.InsertUpdateServieSubscription(Reg);

        AutoServiceSetting(Reg, ProId);
    }
    private void filldata()
    {
        allClear();
        txtProName.Attributes.Add("onchange", "CheckProductNew(this.value)");
        //flSound.Attributes.Add("onchange", "fileTypeCheckengNew(this.value)");
        //ProDocFileUpload.Attributes.Add("onchange", "fileTypeCheckengNew12(this.value)");
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
            //FileDocDownPath.Text = ds.Tables[0].Rows[0]["Pro_Doc"].ToString();
            //FileDownDoc.NavigateUrl = ds.Tables[0].Rows[0]["ProDocPath"].ToString();
            //FileDown.HRef = ds.Tables[0].Rows[0]["SoundPath"].ToString();
            Session["LabelCode"] = ds.Tables[0].Rows[0]["Label_Code"].ToString();
            docflag.Value = ds.Tables[0].Rows[0]["Doc_Flag"].ToString();
            //txtBatchSize.Text = ds.Tables[0].Rows[0]["BtSize"].ToString();
            //txtdisatchLoc.Text = ds.Tables[0].Rows[0]["Dispatch_Location"].ToString();

            //FileDown.Visible = true;
            //FileDownDoc.Visible = true;

            
        }
       // FillLabelDetGrd();
        lblheading.Text = "Update Product";
        if(obj.Pro_ID =="" || obj.Pro_ID==null)
            lblheading.Text = "Add Product";
        ChangeValidationGroup(false);
       
    }

    protected void btnNextInfo_Click(object sender, EventArgs e)
    {
        
    }
    protected void btnAlertForNewPro_Click(object sender, EventArgs e)
    {
       
    }
    protected void btnYesAlert_Click(object sender, EventArgs e)
    {
        
    }
    protected void btnNoAlert_Click(object sender, EventArgs e)
    {

    }

    protected void btnNextLabel_Click(object sender, EventArgs e)
    {
       
    }
    protected void imgNew_Click1(object sender, EventArgs e)//object sender, ImageClickEventArgs e)
    {
        Response.Redirect("AddProduct.aspx");
       
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
            //RequiredFieldValidator522.ValidationGroup = "chk94";
            //RequiredFieldValidatorfile.ValidationGroup = "chk94";
        }
        else
        {
            //RequiredFieldValidator522.ValidationGroup = "NO";
            //RequiredFieldValidatorfile.ValidationGroup = "NO";
        }
    }
    private void FillPlanGrd(Object9420 Reg)
    {

        DataSet ds = function9420.FillGridPlan(Reg);

        DataView dv = ds.Tables[0].DefaultView;
        dv.RowFilter = "Flag = 1";
        

    }
    private void FillLabelDetGrd()
    {
        Object9420 Reg = new Object9420();
        Reg.Label_Name = "";
        DataSet ds = function9420.FillGridLabel(Reg);
        DataView dv = ds.Tables[0].DefaultView;
        dv.RowFilter = "Flag = 1";
       

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

        


        Object9420 obj = new Object9420();
        obj.Pro_Name = txtProName.Text.Trim().Replace("'", "''").ToString();
        obj.Comp_ID = Session["CompanyId"].ToString();
        obj.DateFromChk = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd"));
        obj.Pro_Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy hh:mm:ss tt");
        obj.Pro_Descri = txtprodDes.Text.Trim().Replace("'", "''").ToString();
        obj.Label_Code = slbl;

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
       
        //obj.Update_Flag = 0;
        obj.Update_Flag = 0;
        obj.DocFlag = 1;
        
        string ext = "";

       
        string path1 = "";
        string path2 = "";
        string path3 = "";
       


        //if (flSound.FileName != "")
        //{
        //    string path = Server.MapPath("../Data/Sound");
        //    path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID;
        //    DataProvider.Utility.CreateDirectory(path);
        //    path = path + "\\" + obj.Pro_ID + ".mp3";
        //    flSound.SaveAs(path);
        //    Business9420.function9420.UpdateFileFlagProduct(obj);
        //    Business9420.function9420.UpdateSoundFlagProduct(obj);
        //}
        //else if (FileDown.HRef != "")
        //{
        //}
        //else
        //{
        //    Label2.Text = "Please upload sound file !";
           
        //    script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);

        //    ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please upload sound file !', 'error');", true);

        //    return;
        //}
       


        //if (ProDocFileUpload.FileName != "")
        //{
        //    ext = Path.GetExtension(ProDocFileUpload.FileName);
        //    string path = Server.MapPath("../Data/Sound");
        //    path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID;
        //    DirectoryInfo hdDirectoryInWhichToSearch = new DirectoryInfo(path);
        //    string partialName = obj.Pro_ID + "_ProDoc";
        //    if (FileDownDoc.NavigateUrl != "")
        //    {
        //        FileInfo[] filesInDir = hdDirectoryInWhichToSearch.GetFiles(partialName + ".*");
        //        foreach (FileInfo foundFile in filesInDir)
        //        {
        //            foundFile.Delete();
        //        }
        //    }

        //    DataProvider.Utility.CreateDirectory(path);
        //    path = path + "\\" + obj.Pro_ID + "_ProDoc" + ext;
        //    ProDocFileUpload.SaveAs(path);
            
        //    Business9420.function9420.UpdateDocFlagProduct(obj);
        //}
        //else if (FileDownDoc.NavigateUrl != "")
        //{
        
        //}
        //else
        //{
        //    Label2.Text = "Please leagal document !";
            
        //    script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);


        //    ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please leagal document !', 'error');", true);

        //    return;
        //}


            if (ext != "")
            {
                obj.Pro_Doc = obj.Pro_ID + "_ProDoc" + ext;
                obj.Doc_Flag = 0;
            }
            else
            {
                //obj.Pro_Doc = FileDocDownPath.Text;
                //if (docflag.Value != "")
                //{
                //    obj.Doc_Flag = Convert.ToInt32(docflag.Value);
                //}

            }







        if (lblproid.Value == "")
        {
            obj.DML = "I";
            obj.Pro_ID = GenerateProductID();
#region Product Image
        try
            {
                string Oldfilepath = "C:/inetpub/wwwroot/httpdocs/Info/img/logos/1693/image_2024_06_12T12_48_50_086Z-1693.png";

                string NewFilePath = "C:/inetpub/wwwroot/httpdocs/img/product/" + obj.Pro_ID + ".jpg";

                File.Copy(Oldfilepath, NewFilePath);
            }
            catch
            {

            }
     
        #endregion


        }
        else
        {
            obj.DML = "U";
            obj.Pro_ID = lblproid.Value;
        }
        obj.BatchSize = 25;
        obj.Dispatch_Location ="Delhi";
        function9420.ProductMaster(obj);
        //if (ProDocFileUpload.FileName != "")
            Business9420.function9420.UpdateDocFlagProduct_Pfl(obj);
        #region Auto Subscribed 
        AutoSubscribed(obj.Pro_ID, obj.DML);
        #endregion

 

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
       
        ChangeValidationGroup(false);

  

        allClear();
        filldata();



        if (obj.DML == "I")
        ScriptManager.RegisterStartupScript(this, GetType(), "Updated", "showAlert('Success', 'Product " + obj.Pro_Name + " has been created successfully.', 'success');", true);
        else
            ScriptManager.RegisterStartupScript(this, GetType(), "Updated", "showAlert('Success', 'Product " + obj.Pro_Name + " has been updated successfully.', 'success');", true);



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
       
        obj.Update_Flag = 0;
        string ext = "";
        //if (flSound.FileName != "")
        //{
        //    string path = Server.MapPath("../Data/Sound");
        //    path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID;
        //    DataProvider.Utility.CreateDirectory(path);
        //    path = path + "\\" + obj.Pro_ID + ".mp3";
        //    flSound.SaveAs(path);
        //    Business9420.function9420.UpdateFileFlagProduct(obj);
        //    Business9420.function9420.UpdateSoundFlagProduct(obj);
        //}
        //else
        //{
        //    NewMsgpop.Visible = true;
        //    NewMsgpop.Attributes.Add("class", "alert_boxes_pink big_msg");
        //    Label2.Text = "Please upload sound file ";
            
        //    script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);

        //    ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please upload sound file', 'error');", true);

        //    return;
        //}
        //if (ProDocFileUpload.FileName != "")
        //{
        //    ext = Path.GetExtension(ProDocFileUpload.FileName);
        //    string path = Server.MapPath("../Data/Sound");
        //    path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID;
        //    DirectoryInfo hdDirectoryInWhichToSearch = new DirectoryInfo(path);
        //    string partialName = obj.Pro_ID + "_ProDoc";
        //    FileInfo[] filesInDir = hdDirectoryInWhichToSearch.GetFiles(partialName + ".*");
        //    foreach (FileInfo foundFile in filesInDir)
        //    {
        //        foundFile.Delete();
        //    }
        //    DataProvider.Utility.CreateDirectory(path);
        //    path = path + "\\" + obj.Pro_ID + "_ProDoc" + ext;
        //    ProDocFileUpload.SaveAs(path);
            
        //    Business9420.function9420.UpdateDocFlagProduct(obj);
        //}

        //else
        //{
        //    NewMsgpop.Visible = true;
        //    NewMsgpop.Attributes.Add("class", "alert_boxes_pink big_msg");
        //    Label2.Text = "Please upload legal document file ";
            
        //    script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);

        //    ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please upload legal document file', 'error');", true);

        //    return;
        //}

        if (ext != "")
        {
            obj.Pro_Doc = obj.Pro_ID + "_ProDoc" + ext;
            obj.Doc_Flag = 0;
        }
        else
        {
            //obj.Pro_Doc = FileDocDownPath.Text;
            //obj.Doc_Flag = Convert.ToInt32(docflag.Value);
        }
       
        //obj.BatchSize = Convert.ToInt64(txtBatchSize.Text.Trim().Replace("'", "''"));
        //obj.Dispatch_Location = txtdisatchLoc.Text.Trim().Replace("'", "''");
        //function9420.ProductMaster(obj);
        //if (ProDocFileUpload.FileName != "")
        //    Business9420.function9420.UpdateDocFlagProduct(obj);
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
       
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        
        Response.Redirect("RegisteredProduct.aspx");
    }

    private void allClear()
    {
       // txtdisatchLoc.Text = string.Empty;
        //txtBatchSize.Text = string.Empty;
        txtProName.Attributes.Add("onchange", "checkproduct(this.value)");
        //flSound.Attributes.Add("onchange", "fileTypeCheckeng(this.value)");
        //ProDocFileUpload.Attributes.Add("onchange", "fileTypeCheckeng11111(this.value)");
        //FileDown.HRef = "";
        //FileDown.Visible = false;
        //FileDownDoc.NavigateUrl = "";
        //FileDownDoc.Visible = false;
        //FileDocDownPath.Text = "";
        lblheading.Text = "Add Product";
        btnSave.Text = "Save";
        txtProName.Text = "";
        txtprodDes.Text = "";
        txtProName.Focus();
        Label2.Text = "";
        
        lblproid.Value = string.Empty;
    }

    private void FillAmcOfferDetails(string Plan, TextBox Date_From, TextBox Date_To, HiddenField HdnFiled, Object9420 obj)
    {
        function9420.GetAmcPlan(obj);
        if (Plan == "AMC")
        {
            Session["Plan_ID"] = obj.Plan_ID;
            HdnFiled.Value = Convert.ToInt32(Convert.ToInt32(obj.Row_ID) - 1).ToString();
           
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
        
    }
    protected void GrdProductMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        
        NewMsgpop.Visible = false;
       
        if (e.CommandName == "EditRow")
        {
            Response.Redirect("AddProduct.aspx?id=" + e.CommandArgument.ToString());
            
        }
        else if (e.CommandName == "DeleteRow")
        {
            Object9420 Reg = new Object9420();
            Reg.Pro_ID = e.CommandArgument.ToString();// lblproiddel.Text;
            Reg.Comp_ID = Session["CompanyId"].ToString();
            DataSet ds = function9420.UpdateData(Reg);
            if (ds.Tables[0].Rows.Count > 0)
            {
               
            }
        }
        else if (e.CommandName == "AudioPlay")
        {
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(Server.MapPath(e.CommandArgument.ToString()));
            player.Play();
        }
        else if (e.CommandName.ToString() == "AmcRenewal")
        {
           
        }
        else if (e.CommandName.ToString() == "OfferRenewal")
        {
           
        }
        else if (e.CommandName == "Loyalty")
        {
            
        }
    }
    private void CheckValidation(bool Flag)
    {
        if (Flag == true)
        {
           
        }
        else
        {
            
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
        
        filldata();
    }
    protected void btnNext1_Click(object sender, EventArgs e)
    {
       
    }
    protected void btnPre1_Click(object sender, EventArgs e)
    {
       
    }
    protected void btnNext2_Click(object sender, EventArgs e)
    {
        
    }
    protected void btnPre2_Click(object sender, EventArgs e)
    {
       
    }
    protected void btnNext3_Click(object sender, EventArgs e)
    {
       
    }
    protected void btnPre3_Click(object sender, EventArgs e)
    {
        
    }
    protected void btnNext4_Click(object sender, EventArgs e)
    {
        
    }
    protected void btnPre4_Click(object sender, EventArgs e)
    {
        
    }

    private string FindPlanCodeAmc()
    {
        string slbl = "";
        if (Request.Form["rdamcrew"] != null)
        {
            string[] Arr = Request.Form["rdamcrew"].ToString().Split(',');
            string[] pArr = Arr[0].ToString().Split('-');
            slbl = pArr[0].ToString();
            
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
           
        }
        catch (Exception ex)
        {
        }
    }

    private void CreateIncoive(Object9420 Amc)
    {
        //************************* Code start For Generate Invoice ******************//
        
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
           
        }
        else
        {
                      
        }
    }
    private void FillGridChkPromotional(int i, GridView GrdVwPromotional)
    {
        
    }
    protected void btnYesConfirm_Click(object sender, EventArgs e)
    {
        
    }
}