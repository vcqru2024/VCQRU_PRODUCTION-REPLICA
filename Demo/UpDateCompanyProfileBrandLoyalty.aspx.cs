using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data;
using Business9420;
using System.Configuration;
using System.IO;

public partial class UpDateCompanyProfileBrandLoyalty : System.Web.UI.Page
{
    public string server = Convert.ToString(ConfigurationManager.ConnectionStrings["ServerName"].ConnectionString), userID = Convert.ToString(ConfigurationManager.ConnectionStrings["UserName"].ConnectionString), password = Convert.ToString(ConfigurationManager.ConnectionStrings["Password"].ConnectionString);
    public string srt = DataProvider.Utility.FindMailBody();
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
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../Index.aspx?Page=UpDateCompanyProfileDemo.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        } 
        if (!IsPostBack)
        {
            if (Session["Comp_type"].ToString() == "L")
                Response.Redirect("UpDateCompanyProfile.aspx");
            NewMsgpop.Visible = false;            
            FileDown.Visible = false;
            FillUpDateProfile();
            NewMsgpop.Visible = false;                       
        }                   
    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewProduct(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Comp_Email] FROM [Comp_Reg] where [Comp_Email] = '" + res + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    private void FillUpDateProfile()
    {
        allClear();
        fillCategory();fillCountry();
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Business9420.function9420.FillUpDateProfile(Reg);
        Business9420.function9420.FillSecreteCode(Reg);
        txtCompNameD.Text = Reg.Comp_Name;
        if (Reg.Comp_Cat_Id.ToString() == "0")
            ddlCategoryD.SelectedIndex = 0;
        else
            ddlCategoryD.SelectedValue = Reg.Comp_Cat_Id.ToString();
        txtEmailD.Text = Reg.Comp_Email; 
        txtEmailD.Enabled = false;
        txtWebSiteD.Text = Reg.WebSite;
        txtAddressD.Text = Reg.Address;
        DataSet dsSta = Business9420.function9420.FindStateID(Reg);
        if (dsSta.Tables[0].Rows.Count > 0)
        {
            ddlStateD.SelectedValue = dsSta.Tables[0].Rows[0]["State_id"].ToString();
            ddlStateD_SelectedIndexChanged(this, EventArgs.Empty);
            ddlCityID.SelectedValue = dsSta.Tables[0].Rows[0]["City_ID"].ToString();
        }          
        txtPersonNameD.Text = Reg.Contact_Person;
        if (Reg.Fax.Length > 0)
        {
            string[] Arr = Reg.Fax.ToString().Split('-');
            txtFaxD0.Text = Arr[0].ToString().Substring(1, Arr[0].Length - 1);
            txtFaxD1.Text = Arr[1].ToString();
            txtFaxD.Text = Arr[2].ToString();
        }        
        txtMobD.Text = Reg.Mobile_No;
        //txtMobD.Text = Reg.Phone_No;
        string path = Server.MapPath("../Data/Sound");
        path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4);
        DataProvider.Utility.CreateDirectory(path);
        path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + ".wav";

        A1.Visible = false;
        A2.Visible = false;
        A3.Visible = false;
        FileDown.HRef = Reg.Password; TextBox1.Text = Reg.NoofCodes.ToString();
        lblcodedetail.Text = Reg.NoofCodes.ToString() + " Code Available";
        txtDemoPackeageCode.Text = Reg.PacketCode;
        if (!File.Exists(path))
        {
            flSoundD.Enabled = true;
            FileDown.Visible = false;
        }
        else
        {
            FileDown.Visible = true;
            FillUpDateProfileAfter();
        }        

    }
    private void FillUpDateProfileAfter()
    {
        allClear();
        //fillCategory(); fillCountry();
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Business9420.function9420.FillUpDateProfile(Reg);
        Business9420.function9420.FillSecreteCode(Reg);
        txtCompNameD.Text = Reg.Comp_Name;
        if (Reg.Comp_Cat_Id.ToString() == "0")
            ddlCategoryD.SelectedIndex = 0;
        else
            ddlCategoryD.SelectedValue = Reg.Comp_Cat_Id.ToString();
        txtEmailD.Text = Reg.Comp_Email;
        txtEmailD.Enabled = false;
        txtWebSiteD.Text = Reg.WebSite;
        txtAddressD.Text = Reg.Address;
        if (Reg.City_ID.ToString() == "0")
            ddlCityID.SelectedIndex = 0;
        else
            ddlCityID.SelectedValue = Reg.City_ID.ToString();
        txtPersonNameD.Text = Reg.Contact_Person;
        if (Reg.Fax.Length > 0)
        {
            string[] Arr = Reg.Fax.ToString().Split('-');
            txtFaxD0.Text = Arr[0].ToString().Substring(1, Arr[0].Length - 1);
            txtFaxD1.Text = Arr[1].ToString();
            txtFaxD.Text = Arr[2].ToString();
        }   
        txtMobD.Text = Reg.Mobile_No;
        //txtMobD.Text = Reg.Phone_No;
        FileDown.HRef = Reg.Password;
        string path = Server.MapPath("../Data/Sound");
        path += "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + ".wav";
        if (File.Exists(path))
        {
            flSoundD.Enabled = false;
            FileDown.Visible = true;
        }
        TextBox1.Text = Reg.NoofCodes.ToString();
        lblcodedetail.Text = Reg.NoofCodes.ToString() + " Code Used";
        txtDemoPackeageCode.Text = Reg.PacketCode;

        function9420.FillProductDetailDemo(Reg);

        txtProductName.Text = Reg.Pro_Name;
        txtBatchNo.Text = Reg.Batch_No;
        txtMRP.Text = Reg.MRP.ToString();
        txtMfd_Date.Text = Reg.Mfd_Date.ToString();
        txtExp_Date.Text = Reg.Exp_Date;
        txtcomment.Text = Reg.Comments;
        DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT  Amc_Offer_ID FROM M_Amc_Offer WHERE (Status = 1) AND (Pro_ID='" + Reg.Pro_ID + "') AND  (Amc_Offer_ID = (SELECT MAX(Amc_Offer_ID) AS Expr1 FROM M_Amc_Offer AS M_Amc_Offer_1 WHERE (Status = 1) AND (Pro_ID='" + Reg.Pro_ID + "')  ))");
        if (ds1.Tables[0].Rows.Count > 0)
        {
            Reg.Amc_Offer_ID = Convert.ToInt32(ds1.Tables[0].Rows[0]["Amc_Offer_ID"].ToString());
            A1.HRef = "\\Sound\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\" + Reg.Pro_ID + ".wav";
            A2.HRef = "\\Sound\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\" + Reg.Amc_Offer_ID + "\\" + Reg.Amc_Offer_ID + "_H.wav";
            A3.HRef = "\\Sound\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\" + Reg.Amc_Offer_ID + "\\" + Reg.Amc_Offer_ID + "_E.wav";
            path = "";
            path = Server.MapPath("../Data/Sound");
            path += "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\" + Reg.Pro_ID + ".wav";
            if (File.Exists(path))
            {
                flSoundProduct.Enabled = false;
                A1.Visible = true;
            }
            path = "";
            path = Server.MapPath("../Data/Sound");
            path += "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\" + Reg.Amc_Offer_ID + "\\" + Reg.Amc_Offer_ID + "_H.wav";
            //path += "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\" + Reg.Row_ID + "\\" + Reg.Row_ID +"_H.wav";        
            if (File.Exists(path))
            {
                flSoundPH.Enabled = false;
                A2.Visible = true;
            }
            path = "";
            path = Server.MapPath("../Data/Sound");
            path += "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\" + Reg.Amc_Offer_ID + "\\" + Reg.Amc_Offer_ID + "_E.wav";
            //path += "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\" + Reg.Row_ID + "\\" + Reg.Row_ID + "_E.wav";        
            if (File.Exists(path))
            {
                flSoundPE.Enabled = false;
                A3.Visible = true;
            }
            btnSaveDemo.Visible = false;
        }
        
    }
    private void fillCategory()
    {
        ddlCategoryD.Items.Clear();
        DataSet ds = function9420.fetchCategory();
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlCategoryD.DataSource = ds.Tables[0];
            ddlCategoryD.DataTextField = "Cat_Name";
            ddlCategoryD.DataValueField = "Cat_Id";
            ddlCategoryD.DataBind();
            ddlCategoryD.Items.Insert(0, "--Select--");
        }
        else
        {            
            ddlCategoryD.Items.Insert(0, "--Select--");
        }

    }

    private void fillCountry()
    {
        DataSet ds = function9420.fetchState();
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlStateD.DataSource = ds.Tables[0];
            ddlStateD.DataTextField = "stateName";
            ddlStateD.DataValueField = "STATE_ID";
            ddlStateD.DataBind();
            ddlStateD.Items.Insert(0, "--Select--");
            ddlCityID.Items.Insert(0, "--Select--");
        }
        else
        {
            ddlStateD.Items.Clear();
            ddlStateD.Items.Insert(0, "--Select--");
            ddlCityID.Items.Clear();
            ddlCityID.Items.Insert(0, "--Select--");
        }
    }

    private void EdittxtGray()
    {
        txtCompNameD.Enabled = false;
        ddlCategoryD.Enabled = false;
        txtEmailD.Enabled = false; txtEmailD.Enabled = false;
        txtWebSiteD.Enabled = false;
        txtAddressD.Enabled = false;
        ddlCityID.Enabled = false;
        txtPersonNameD.Enabled = false;
        txtFaxD0.Enabled = false;
        txtFaxD1.Enabled = false;
        txtFaxD.Enabled = false;
        txtMobD.Enabled = false;
        txtMobD.Enabled = false;
        flSoundD.Enabled = false;
    }
    private void EdittxtGrayToEdit()
    {
        txtCompNameD.Enabled = true;
        ddlCategoryD.Enabled = true;
        txtEmailD.Enabled = true; txtEmailD.Enabled = false;
        txtWebSiteD.Enabled = true;
        txtAddressD.Enabled = true;
        ddlCityID.Enabled = true;
        txtPersonNameD.Enabled = true;
        txtFaxD0.Enabled = true;
        txtFaxD1.Enabled = true;
        txtFaxD.Enabled = true;
        txtMobD.Enabled = true;
        txtMobD.Enabled = true;
        flSoundD.Enabled = true;
    }
    protected void btnResetDemo_Click(object sender, EventArgs e)
    {
        allClear();
        DivNewMsg.Visible = false;
        //CheckedDemoCodes(false);
//        ModalPopupExtenderNewDesign.Show();
    }
    protected void btnUpDate_Click(object sender, EventArgs e)
    {

    }
    protected void btnSaveDemo_Click(object sender, EventArgs e)
    {
        if (Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT count(Pro_ID) FROM Pro_Reg WHERE Pro_Name = '" + txtProductName.Text.Trim().Replace("'", "''") + "' AND Comp_ID = '" + Session["CompanyId"].ToString() + "' ")) == 1)
            return;
        Object9420 obj = new Object9420(); txtNoOfCodes.Text = TextBox1.Text;
        obj.NoofCodes = Convert.ToInt32(txtNoOfCodes.Text.Trim());
        obj.Comp_Name = txtCompNameD.Text.Trim().Replace("'", "''").ToString();
        obj.Comp_Cat_Id = Convert.ToInt32(ddlCategoryD.SelectedValue);
        obj.Comp_Email = txtEmailD.Text.Trim().Replace("'", "''").ToString();
        obj.WebSite = txtWebSiteD.Text.Trim().Replace("'", "''").ToString();
        obj.Address = txtAddressD.Text.Trim().Replace("'", "''").ToString();
        obj.City_ID = Convert.ToInt32(ddlCityID.SelectedValue);
        obj.Contact_Person = txtPersonNameD.Text.Trim().Replace("'", "''").ToString();
        if ((txtFaxD0.Text.Trim() != "") && (txtFaxD1.Text.Trim() != "") && (txtFaxD.Text.Trim() != ""))
            obj.Fax = "+" + txtFaxD0.Text.Trim() + "-" + txtFaxD1.Text.Trim() + "-" + txtFaxD.Text.Trim();
        obj.Mobile_No = txtMobD.Text.Trim().Replace("'", "''").ToString();
        obj.Phone_No = string.Empty;// txtPhoneD.Text.Trim().Replace("'", "''").ToString();
        //obj.Comp_ID = SQL_DB.ExecuteScalar("SELECT [PrPrefix]+ '-' + convert(nvarchar,[PrStart]) as compId FROM [Code_Gen] where [Prfor] = 'Company'").ToString();
        obj.Comp_ID = Session["CompanyId"].ToString();
        obj.Reg_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy hh:mm:ss");
        obj.Status = 0;
        obj.Email_Vari_Flag = 1;
        obj.Update_Flag = 0;
        obj.TypeOfCompany = "D";
        function9420.SaveCompanyReg(obj);        
        SQL_DB.ExecuteNonQuery("UPDATE [dbo].[Allcation_Demo] SET [Entry_Flag] = '1' WHERE [Packet_Name] = '" + txtDemoPackeageCode.Text.Trim().Replace("'", "''") + "'");
        string path = Server.MapPath("../Data/Sound");
        path = path + "\\" + obj.Comp_ID.ToString().Substring(5, 4);
        DataProvider.Utility.CreateDirectory(path);
        path = path + "\\" + obj.Comp_ID.ToString().Substring(5, 4) + ".wav";
        flSoundD.SaveAs(path);       
        obj.Pro_Name = txtProductName.Text.Trim().Replace("'", "''").ToString();
        obj.Pro_ID = GenerateProductID();
        obj.Pro_Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy");
        if(txtcomment.Text != "")
            obj.Comment_Txt = txtcomment.Text.Trim().Replace("'", "''");
        else
            obj.Comment_Txt = null;
        function9420.SaveProductMaster(obj);
        path = "";
        path = Server.MapPath("../Data/Sound");
        path = path + "\\" + obj.Comp_ID.ToString().Substring(5, 4) + "\\" + obj.Pro_ID;
        DataProvider.Utility.CreateDirectory(path);
        path = path + "\\" + obj.Pro_ID + ".wav";
        flSoundProduct.SaveAs(path);
        SQL_DB.ExecuteNonQuery("UPDATE [Code_Gen] SET [PrStart] = [PrStart] + 1 WHERE [Prfor] = 'Product' and [PrFlag] = 1");
        string path_H = ""; string path_E = "";
        obj.Batch_No = txtBatchNo.Text.Trim().Replace("'", "''");
        obj.MRP = Convert.ToDouble(txtMRP.Text.Trim());
        obj.DemoMfd_Date = txtMfd_Date.Text;
        if(txtExp_Date.Text == "")
            obj.Exp_Date = null;
        else
            obj.Exp_Date = txtExp_Date.Text;
        obj.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now);
        obj.Update_Flag = 0;
        obj.Comments = txtcomment.Text.Trim().Replace("'", "''");
        function9420.SaveBatchProductDetails(obj);
        obj.Row_ID = Business9420.function9420.GetRow_ID();
        obj.Batch_No = Business9420.function9420.GetRow_ID();
        obj.Use_Type = txtDemoPackeageCode.Text;

        function9420.UpDateBatchProductDetailsInM_CodeDemo(obj);

        #region New Code For  Offer
        // this is parameter is Amc
        DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT  Plan_ID, Plan_Name, Plan_Time, Plan_Amount, Plan_Discount, Entry_Date, Flag  FROM M_Plan WHERE (Flag = 1) AND (Row_Id = (SELECT MAX(Row_Id) AS Expr1 FROM M_Plan AS M_Plan_1 WHERE (Flag = 1)))");

        obj.Trans_Type = "AMC";
        obj.Plan_ID = ds1.Tables[0].Rows[0]["Plan_ID"].ToString();
        obj.Plan_Name = ds1.Tables[0].Rows[0]["Plan_Name"].ToString();
        obj.Plan_Amount = 0.00;
        obj.DateFrom = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd"));
        obj.DateTo = obj.DateFrom.AddYears(1);



        // this is parameter is promotional/offer
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT  Promo_ID, Promo_Name, Time_Days, Amount FROM M_Promotional WHERE (Flag = 1) AND (Row_Id = (SELECT MAX(Row_Id) AS Expr1 FROM M_Promotional AS M_Promotional_1 WHERE (Flag = 1)))");
        
        obj.statusstr = "1";
        obj.Promo_Id = ds.Tables[0].Rows[0]["Promo_ID"].ToString();
        obj.Promo_Name = ds.Tables[0].Rows[0]["Promo_Name"].ToString();
        obj.Promo_Amount = 0.00;
        obj.PromoDateFrom = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd"));
        obj.PromoDateTo = obj.PromoDateFrom.AddYears(1);
        obj.Plan_Discount = 0.00;
        obj.Row_ID = obj.Amc_Offer_ID.ToString();
        obj.Admin_Balance = 0.00;
        obj.Admin_Balance = 0.00;
        obj.Pro_Entry_Date = obj.Reg_Date;
        obj.Comment_Txt = txtcomment.Text.Trim().Replace("'", "''");
        obj.Row_ID = null;
        obj.DML = "I";
        function9420.FindAMCInfo(obj);
        function9420.InsertAmcOfferPlan(obj);

        obj.Trans_Type = "Offer";
        function9420.FindPromoInfo(obj);
        function9420.InsertAmcOfferPlan(obj);
        function9420.FindAmcOfferId(obj);
        obj.Row_ID = obj.Amc_Offer_ID.ToString();
        
        if (flSoundPH.FileName != "")
        {
            path = Server.MapPath("../Data/Sound");
            path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID + "\\" + obj.Amc_Offer_ID;
            DataProvider.Utility.CreateDirectory(path);
            path = path + "\\" + obj.Amc_Offer_ID + "_H.wav";
            flSoundPH.SaveAs(path);
        }
        if (flSoundPE.FileName != "")
        {
            path = Server.MapPath("../Data/Sound");
            path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID + "\\" + obj.Amc_Offer_ID;
            DataProvider.Utility.CreateDirectory(path);
            path = path + "\\" + obj.Amc_Offer_ID + "_E.wav";
            flSoundPE.SaveAs(path);
        }
        #endregion
        #region Old Code for File Saved
        //path = "";
        //path = Server.MapPath("../Data/Sound");
        //path += "\\" + obj.Comp_ID.ToString().Substring(5, 4) + "\\" + obj.Pro_ID;
        ////path = path + "\\" + obj.Comp_ID.ToString().Substring(5, 4) + "\\" + obj.Pro_ID + "\\" + obj.Row_ID;
        //DataProvider.Utility.CreateDirectory(path);
        //path_H = path + "\\" + obj.Pro_ID + "_H.wav";
        //flSoundPH.SaveAs(path_H);
        //path_E = path + "\\" + obj.Pro_ID + "_E.wav";
        //flSoundPE.SaveAs(path_E);
        #endregion
        Clear();
        allClear();

        #region
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
           " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
           " <hr style='border:1px solid #2587D5;'/>" +
           " <div class='w_frame'>" +
           " <p>" +
           " <div class='w_detail'>" +
           " <span>Dear <em><strong>" + obj.Contact_Person + ",</strong></em></span><br />" +
           " <br />" +
           " <span>Your details are submit successfully, Please wait for account activation. </span>" +
           " <br /> for further assistance, please contact us <br />" +
           " <br />" +
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
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Comp_Email, MailBody, "Demo Company Registration");
        LblMsgUpdate.Text = "<b>Dear " + obj.Contact_Person + "</b><br/> Thanks for registration with us. Please check your email for <br/> to verify your account. <br/> <br/> <b> Thank you,</b> <br/> Team: VCQRU.COM <br/>  " + ProjectSession.sales_accomplishtrades + " ";
        //ModalPopupExtenderMessage.Show();
        allClear();
        FillUpDateProfile();
        NewMsgpop.Visible = true;
        btnSaveDemo.Visible = false;
        LblMsgUpdate.Text = "Profile saved successfully !";
        
        FillUpDateProfileAfter();        
        //EdittxtGray();
    }
    private void Clear()
    {
        //lblheading.Text = "New Product Details";
        btnSaveDemo.Text = "Save";
        txtBatchNo.Text = "";
        txtMRP.Text = "";
        txtMfd_Date.Text = "";
        txtExp_Date.Text = "";
        txtNoOfCodes.Text = "";
        txtDemoPackeageCode.Text = "";
        //LblMsg.Text = ""; 
        Label3.Text = "";
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
    private void allClear()
    {
        txtCompNameD.Text = string.Empty;
        ddlCategoryD.SelectedIndex = 0;
        txtEmailD.Text = string.Empty;
        txtWebSiteD.Text = string.Empty;
        txtAddressD.Text = string.Empty;
        ddlCityID.SelectedIndex = 0;
        txtPersonNameD.Text = string.Empty;
        txtFaxD0.Text = string.Empty;
        txtFaxD1.Text = string.Empty;
        txtFaxD.Text = string.Empty;
        txtMobD.Text = string.Empty;
        txtMobD.Text = string.Empty;
        txtCompNameD.Focus();
    }

    protected void btnpacketInfoReset_Click(object sender, EventArgs e)
    {
        allClear();
        txtNoOfCodes.Text = "";
        txtDemoPackeageCode.Text = "";
        DivNewMsg.Visible = false;
        CheckedDemoCodes(false);
        //ModalPopupExtenderNewDesign.Show();
    }
    protected void btnContinueDemo_Click(object sender, EventArgs e)
    {
        DataSet dsNewChk = SQL_DB.ExecuteDataSet("SELECT [Entry_Flag] FROM [Allcation_Demo] where [Packet_Name] = '" + txtDemoPackeageCode.Text.Trim() + "'");
        if (dsNewChk.Tables[0].Rows.Count > 0 && dsNewChk.Tables[0].Rows[0]["Entry_Flag"].ToString() == "1")
        {
            txtEmailD.Text = "";
            txtCompNameD.Text = "";
            txtPersonNameD.Text = "";
            txtMobD.Text = "";
            txtNoOfCodes.Text = "";
            DivNewMsg.Visible = true;
            DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            LblMsgCodes.Text = "Packet secret code already registered !";
            btnSaveDemo.CssClass = "button_all_Sec";
            btnSaveDemo.Enabled = false;
            //btnContinueDemo.CssClass = "button_all_Sec";
            //btnContinueDemo.Enabled = false;
            lblcodedetail.Visible = false;
            //ModalPopupExtenderNewDesign.Show();
            return;
        }


        DataSet ds = Business9420.function9420.CheckDemoPackageCodes(txtDemoPackeageCode.Text.Trim());
        DataSet ds1 = Business9420.function9420.CheckDemoPackageCodesRows(txtDemoPackeageCode.Text.Trim());
        if (ds1.Tables[0].Rows.Count > 0)
        {
            DivNewMsg.Visible = false;
            DataSet dsAllot = SQL_DB.ExecuteDataSet("SELECT [Email_ID],[Comp_Name],[Contact_No],[Contact_Name],[Packet_Name] FROM [Allcation_Demo] where [Packet_Name] = '" + txtDemoPackeageCode.Text.Trim() + "'");
            if (dsAllot.Tables[0].Rows.Count > 0)
            {
                txtEmailD.Text = dsAllot.Tables[0].Rows[0]["Email_ID"].ToString();
                txtCompNameD.Text = dsAllot.Tables[0].Rows[0]["Comp_Name"].ToString();
                txtPersonNameD.Text = dsAllot.Tables[0].Rows[0]["Contact_Name"].ToString();
                txtMobD.Text = dsAllot.Tables[0].Rows[0]["Contact_No"].ToString();
            }
            txtNoOfCodes.Text = ds.Tables[0].Rows[0]["Row_ID"].ToString();
            LblMsgCodes.Text = "";
            btnContinueDemo.CssClass = "button_all";
            btnContinueDemo.Enabled = true;
            btnSaveDemo.CssClass = "button_all";
            btnSaveDemo.Enabled = true;
            lblcodedetail.Visible = true;
            //ModalPopupExtenderNewDesign.Show();
        }
        else
        {
            txtEmailD.Text = "";
            txtCompNameD.Text = "";
            txtPersonNameD.Text = "";
            txtMobD.Text = "";
            txtNoOfCodes.Text = "";
            DivNewMsg.Visible = true;
            DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            LblMsgCodes.Text = "Invalid packet secret code !";
            btnSaveDemo.CssClass = "button_all_Sec";
            btnSaveDemo.Enabled = false;
            //btnContinueDemo.CssClass = "button_all_Sec";
            //btnContinueDemo.Enabled = false;
            lblcodedetail.Visible = false;
            //ModalPopupExtenderNewDesign.Show();
            return;
        }

        //ModalPopupExtenderNewDesign.Show();


        if (txtDemoPackeageCode.Text != "")
        {
            //ModalPopupExtenderNewDesign.Show();
            CheckedDemoCodes(true);
        }
        else
        {
            DivNewMsg.Visible = true;
            DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            LblMsgCodes.Text = "Please enter secret code !";
            btnSaveDemo.CssClass = "button_all_Sec";
            btnSaveDemo.Enabled = false;
            //ModalPopupExtenderNewDesign.Show();
            return;
        }

    }

    private void CheckedDemoCodes(bool flag)
    {
        if (flag == true)
        {
            DemoDiv.Visible = true; DemoDivCodeInfo.Visible = false;
        }
        else
        {
            DemoDiv.Visible = false; DemoDivCodeInfo.Visible = true;
        }
    }
    protected void btnUplDoc_Click(object sender, EventArgs e)
    {
        ModalPopupExtenderUpload.Show();  
    }

    protected void btnUploadDoc_Click(object sender, EventArgs e)
    {
        Object9420 Log = new Business9420.Object9420();
        Log.Comp_ID = Session["CompanyId"].ToString();
        Log.Comp_Info = txtcompinfo.Text.Trim().Replace("'", "''");
        Log.PAN_TAN = txtpantanno.Text.Trim().Replace("'", "''");
        Log.VAT = txtvat.Text.Trim().Replace("'", "''");

        string path = Server.MapPath("../Data/Sound");
        path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "\\Doc";
        DataProvider.Utility.CreateDirectory(path);
        string ext = Path.GetExtension(FileUploadaddpfrrof.FileName);  //int lindex = FileUploadaddpfrrof.FileName.LastIndexOf('.'); //string ext = FileUploadaddpfrrof.FileName.Substring(lindex, FileUploadaddpfrrof.FileName.Length - lindex);        
        path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "_Add" + ext;
        FileUploadaddpfrrof.SaveAs(path);

        Log.Comp_Addressproof = Log.Comp_ID.ToString().Substring(5, 4) + "_Add" + ext;

        path = Server.MapPath("../Data/Sound");
        path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "\\Doc";
        DataProvider.Utility.CreateDirectory(path);
        ext = Path.GetExtension(FileUploadowner.FileName);
        path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "_Own" + ext;
        FileUploadowner.SaveAs(path);

        Log.Owner_proof = Log.Comp_ID.ToString().Substring(5, 4) + "_Own" + ext;

        path = Server.MapPath("../Data/Sound");
        path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "\\Doc";
        DataProvider.Utility.CreateDirectory(path);
        ext = Path.GetExtension(FileUploadsignature.FileName);
        path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "_Sign" + ext;
        FileUploadsignature.SaveAs(path);

        Log.Signature = Log.Comp_ID.ToString().Substring(5, 4) + "_Sign" + ext;

        Business9420.function9420.UploadDocuments(Log);

        SQL_DB.ExecuteNonQuery("UPDATE [Comp_Reg] SET [Doc_Flag] = 1 WHERE [Comp_ID] = '" + Session["CompanyId"].ToString() + "'");
        LabelAlertheader.Text = "Confirmation";
        LabelAlertText.Text = "Document uploaded successfully!";
        ModalPopupExtenderAlert.Show();
    }

    protected void ddlStateD_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlStateD.SelectedIndex == 0)
        {
            ddlCityID.Items.Clear();
            ddlCityID.Items.Insert(0, "--Select--");
        }
        else
        {
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT [CITY_ID],[CityName] FROM [CityMaster] where [State_id] is not null and [State_id] = " + ddlStateD.SelectedValue + "  ORDER BY  CityName ");
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlCityID.DataSource = ds.Tables[0];
                ddlCityID.DataTextField = "CityName";
                ddlCityID.DataValueField = "CITY_ID";
                ddlCityID.DataBind();
                ddlCityID.Items.Insert(0, "--Select--");
            }
            else
            {
                ddlCityID.Items.Clear();
                ddlCityID.Items.Insert(0, "--Select--");
            }

        }

    }
        
}