using Business9420;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_companyprofile : System.Web.UI.Page
{
    cls_patanjali db = new cls_patanjali();
    protected void Page_PreInit(object sender, EventArgs e)

    {
        if (Request.QueryString["frmadmin"] != null)
        {
            if (Request.QueryString["frmadmin"].ToString() == "1")
            {
                //this.MasterPageFile = "~/Admin/NewAdminMaster.master";
                Session["Comp_type"] = Request.QueryString["Comp_type"].ToString();
                Session["CompanyId"] = Request.QueryString["CompanyId"].ToString();
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
       
        string Adata = txtaadharotp.Text;
        string Ad = hfaadharnumber.Value;

        if (Session["CompanyId"] == null)
        {
            if (Request.QueryString["frmadmin"] == null)
            {
                Session.Abandon();
                Response.Redirect("../Info/Login.aspx?Page=UpDateCompanyProfile.aspx");
                //if (Request.QueryString["frmadmin"].ToString() == "1")
                //{
                //    this.MasterPageFile = "~/Admin/NewAdminMaster.master";
                //}
            }
        }
        else
        {
            if (Request.QueryString["frmadmin"] == null)
            {
                if (Session["User_Type"].ToString() == "Admin")
                    Response.Redirect("Login.aspx");
            }
        }
        if (!IsPostBack)
        {
            if (Session["Comp_type"].ToString() == "D")
                Response.Redirect("UpDateCompanyProfileDemo.aspx");
            //if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
            //    Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            DataSet dsFlCount = SQL_DB.ExecuteDataSet("SELECT count([Flag]) as docverifyFlag FROM [Comp_Doc_Flag] where [Comp_ID] = '" + Session["CompanyId"].ToString() + "' and [Flag] = 1");


            btnUpDate.Text = "Edit";
            btnUpDate.ValidationGroup = "chk941";

            FillUpDateProfile();
            NewMsgpop.Visible = false;
            //lnkDelete.Visible = false;

            #region Pan card and GSTIN/VAT moved from  document upload page.

            FillVerificationStatus();
            #endregion

            EdittxtGray();
        }
    }



    private void FillVerificationStatus()
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        DataSet ds = function9420.FindVerifyData(Reg);
        if (ds.Tables[0].Rows.Count > 0)
        {

            if (ds.Tables[0].Rows.Count >= 6)
            {

                FillLabelStatus(lblremarkspantan, Convert.ToInt32(ds.Tables[0].Rows[3]["Flag"]), ds.Tables[0].Rows[3]["Docstremarks"].ToString(), ds.Tables[0].Rows[3]["DocSt"].ToString());
                #region //For Online  pan verification
                string PanFlag = ds.Tables[0].Rows[3]["Flag"].ToString();
                if (PanFlag == "1")
                {
                    txtpantanno.ReadOnly = true;
                    Imgpanverify.Visible = false;
                    hfIspanverified.Value = "1";
                }

                else
                {
                    Imgpanverify.Visible = true;
                    hfIspanverified.Value = "0";
                }


                #endregion
                if (ds.Tables[0].Rows.Count == 6)
                {

                    FillLabelStatus(lblremarksvatno, Convert.ToInt32(ds.Tables[0].Rows[5]["Flag"]), ds.Tables[0].Rows[5]["Docstremarks"].ToString(), ds.Tables[0].Rows[5]["DocSt"].ToString());


                }
                else if (ds.Tables[0].Rows.Count == 7)
                {

                    FillLabelStatus(lblremarksvatno, Convert.ToInt32(ds.Tables[0].Rows[6]["Flag"]), ds.Tables[0].Rows[6]["Docstremarks"].ToString(), ds.Tables[0].Rows[6]["DocSt"].ToString());

                    #region //For Online  GSt verification
                    string TANFlag = ds.Tables[0].Rows[6]["Flag"].ToString();
                    if (TANFlag == "1")
                    {
                        txtCompName.ReadOnly = true;
                        txtAddress.ReadOnly = true;
                        txtvat.ReadOnly = true;
                        lnkgstverify.Visible = false;
                    }

                    else
                    {
                        txtCompName.ReadOnly = false;
                        txtAddress.ReadOnly = false;
                        hfIsGstverified.Value = "0";
                        lnkgstverify.Visible = true;
                    }


                    #endregion
                }
            }
        }
        else
        {

            lblremarkspantan.ImageUrl = string.Empty;

            lblremarksvatno.ImageUrl = string.Empty;
        }
    }
    private void FillLabelStatus(Image lbl, int Flag, string Remarks, string DocStatus)
    {
        if (Flag == 1)
        {
            lbl.ImageUrl = "../Content/images/success_icon.png";

            lbl.ForeColor = System.Drawing.Color.Green;


        }
        else if (Flag == -1)
        {
            lbl.ImageUrl = "../Content/images/generated_billC.png";
            lbl.ForeColor = System.Drawing.Color.Red;
        }
        else if (Flag == 0)
        {
            lbl.ImageUrl = "../Content/images/warning.png";
            lbl.ForeColor = System.Drawing.Color.Black;
        }
        //lbl.AlternateText = Remarks;
        lbl.ToolTip = Remarks;

    }
    private void ChkOpen()
    {
        Object9420 obj = new Object9420();
        obj.Comp_ID = Session["CompanyId"].ToString();
        DataSet ds = function9420.CheckStatusForMan(obj);
        if (ds.Tables[0].Rows.Count > 0)
        {
            if (ds.Tables[0].Rows[0]["Comp_Type"].ToString() == "D")
                Response.Redirect("Message.aspx");
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
        fillCategory(); fillCountry();
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Business9420.function9420.FillUpDateProfile(Reg);

        #region // For Online aadhar verification
        if (Reg.IsAadharVerified)
        {
            FillLabelStatus(lblremarksAadharno, 1, "Verified", "Success");
            txtaadharnumber.ReadOnly = true;
            lnkaadharnumber.Visible = false;
            hfIsaadharverified.Value = "1";
        }

        else
        {
            lnkaadharnumber.Visible = true;
            FillLabelStatus(lblremarksAadharno, 0, "Pending", "Pending");
            hfIsaadharverified.Value = "0";
        }

        #endregion
        txtpantanno.Text = Reg.PAN_TAN;
        txtvat.Text = Reg.VAT;
        txtCompName.Text = Reg.Comp_Name;
        if (Reg.Comp_Cat_Id.ToString() == "0")
            ddlCategory.SelectedIndex = 0;
        else
            ddlCategory.SelectedValue = Reg.Comp_Cat_Id.ToString();
        txtEmail.Text = Reg.Comp_Email; txtEmail.Enabled = false;
        txtWebSite.Text = Reg.WebSite;
        txtAddress.Text = Reg.Address;
        txtResiAddress.Text = Reg.ResiAddress;
        txtDirectorName.Text = Reg.DirectorName;
        txtDirectorFatherName.Text = Reg.DirectorFatherName;
        txtaadharnumber.Text = Reg.AadharNumber;
        hfaadharnumber.Value = Reg.AadharNumber;
        DataSet dsSta = Business9420.function9420.FindStateID(Reg);
        if (dsSta.Tables[0].Rows.Count > 0)
        {
            ddlState.SelectedValue = dsSta.Tables[0].Rows[0]["State_id"].ToString();
            ddlState_SelectedIndexChanged(this, EventArgs.Empty);
            ddlCity.SelectedValue = dsSta.Tables[0].Rows[0]["City_ID"].ToString();
        }
        txtPersonName.Text = Reg.Contact_Person;
        if (Reg.Fax.Length > 0)
        {
            string[] Arr1 = Reg.Fax.ToString().Split('-');
            txtFax0.Text = Arr1[0].ToString().Substring(1, Arr1[0].Length - 1);
            txtFax1.Text = Arr1[1].ToString();
            txtFax.Text = Arr1[2].ToString();
        }
        txtMob.Text = Reg.Mobile_No;
        if (Reg.Phone_No.Length > 0)
        {
            string[] Arr = Reg.Phone_No.ToString().Split('-');
            txtPhone0.Text = Arr[0].ToString().Substring(1, Arr[0].Length - 1);
            txtPhone1.Text = Arr[1].ToString();
            txtPhone.Text = Arr[2].ToString();
        }
        string path = Server.MapPath("../Data/Sound");
        path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4);
        DataProvider.Utility.CreateDirectory(path);
        path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + ".mp3";
        if (!File.Exists(path))
        {
            FileDown.Visible = false;
            btnUpDate.ValidationGroup = "NN";
            rfvsound.ValidationGroup = "chk94";
            //btnNextDoc.Visible = false;            
            //int i = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT Status FROM [Comp_Reg] where [Comp_ID] = '" + Reg.Comp_ID + "' and [Email_Vari_Flag] = '1'"));
            //if (i == 1)
            //    btnNextDoc.Visible = false;
            //else
            //    btnNextDoc.Visible = true;
        }
        else
        {
            FileDown.Visible = true;
            btnUpDate.ValidationGroup = "chk941";
            rfvsound.ValidationGroup = "NN";
            //btnNextDoc.Visible = true;           
            //int i = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT Status FROM [Comp_Reg] where [Comp_ID] = '" + Reg.Comp_ID + "' and [Email_Vari_Flag] = '1'"));
            //if (i == 1)
            //    btnNextDoc.Visible = false;
            //else
            //    btnNextDoc.Visible = true;
        }
        FileDown.HRef = Reg.Password;
        if (!string.IsNullOrEmpty(Reg.logo_path))
        {
            imgLogo.Visible = true;
            imgLogo.ImageUrl = Reg.logo_path;
            lnkDelete.Visible = true;
        }
        else
        {
            imgLogo.Visible = false;
            lnkDelete.Visible = false;
        }
    }
    private bool ChkVerDoc(Object9420 Reg)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("select * from Comp_Doc_Flag WHERE Comp_ID = '" + Reg.Comp_ID + "' AND Flag = 1");
        if (ds.Tables[0].Rows.Count > 0)
        {
            if (ds.Tables[0].Rows.Count == 6)
                return true;
            else
                return false;
        }
        else
            return false;
    }
    private void fillCategory()
    {
        DataSet ds = function9420.fetchCategory();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexIntVal(ds, "Cat_Id", "Cat_Name", ddlCategory, "--Select--");
        ddlCategory.SelectedIndex = 0;
    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkFile(string ult)
    {
        int lindex = ult.LastIndexOf('.');
        string ext = ult.Substring(lindex, ult.Length - lindex);
        if (ext.ToLower() == ".mp3")
            return false;
        else
            return true;
    }
    private void fillCountry()
    {
        DataSet ds = function9420.fetchState();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexIntVal(ds, "STATE_ID", "stateName", ddlState, "--Select--");
        ddlState.SelectedIndex = 0;
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0, "--Select--");
        }
        else
        {
            ddlState.Items.Clear();
            ddlState.Items.Insert(0, "--Select--");
            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0, "--Select--");
        }
    }

    private void EdittxtGray()
    {
        Imgpanverify.Enabled = false;
        lnkgstverify.Enabled = false;
        lnkaadharnumber.Enabled = false;
        txtCompName.Enabled = false;
        ddlCategory.Enabled = false;
        txtEmail.Enabled = false; txtEmail.Enabled = false;
        txtWebSite.Enabled = false;
        txtAddress.Enabled = false;
        ddlState.Enabled = false;
        ddlCity.Enabled = false;
        txtPersonName.Enabled = false;
        txtFax0.Enabled = false;
        txtFax1.Enabled = false;
        txtFax.Enabled = false;
        txtMob.Enabled = false;
        txtPhone0.Enabled = false;
        txtPhone1.Enabled = false;
        txtPhone.Enabled = false;
        flSound.Enabled = false;
        txtResiAddress.Enabled = false;
        txtDirectorName.Enabled = false;
        txtDirectorFatherName.Enabled = false;
        txtaadharnumber.Enabled = false;
        txtaadharotp.Enabled = false;
        txtpantanno.Enabled = false;
        txtvat.Enabled = false;
    }
    private void EdittxtGrayToEdit()
    {
        Imgpanverify.Enabled = true;
        lnkgstverify.Enabled = true;
        lnkaadharnumber.Enabled = true;
        txtCompName.Enabled = true;
        ddlCategory.Enabled = true;
        txtEmail.Enabled = true; txtEmail.Enabled = false;
        txtWebSite.Enabled = true;
        txtAddress.Enabled = true;
        ddlState.Enabled = true;
        ddlCity.Enabled = true;
        txtPersonName.Enabled = true;
        txtFax0.Enabled = true;
        txtFax1.Enabled = true;
        txtFax.Enabled = true;
        txtMob.Enabled = true;
        txtPhone0.Enabled = true;
        txtPhone1.Enabled = true;
        txtPhone.Enabled = true;
        flSound.Enabled = true;
        txtResiAddress.Enabled = true;
        txtDirectorName.Enabled = true;
        txtDirectorFatherName.Enabled = true;
        txtaadharnumber.Enabled = true;
        txtaadharotp.Enabled = true;
        txtpantanno.Enabled = true;
        txtvat.Enabled = true;


    }
    protected void btnUpDate_Click(object sender, EventArgs e)
    {
        if (btnUpDate.Text == "Update")
        {
            if (hfIsaadharverified.Value == "0" || hfIspanverified.Value == "0" || hfIsGstverified.Value == "0")
            {
               // NewMsgpop.Visible = true;

               // NewMsgpop.Style.Add("background", "#ff0000");
              //  LblMsgUpdate.Text = "Please verify your Pan card, GSTIN and Aadhar first to update profile.";
                ScriptManager.RegisterStartupScript(this, GetType(), "loginSuccess", "showAlert('Error', 'Please verify your Pan card, GSTIN and Aadhar first to update profile.', 'error');", true);
                return;

            }
            Object9420 obj = new Object9420();
            obj.Comp_Name = txtCompName.Text.Trim().Replace("'", "''").ToString();
            obj.Comp_Cat_Id = Convert.ToInt32(ddlCategory.SelectedValue);
            obj.Comp_Email = txtEmail.Text.Trim().Replace("'", "''").ToString();
            obj.WebSite = txtWebSite.Text.Trim().Replace("'", "''").ToString();
            obj.Address = txtAddress.Text.Trim().Replace("'", "''").ToString();
            obj.ResiAddress = txtResiAddress.Text.Trim().Replace("'", "''").ToString();
            obj.DirectorName = txtDirectorName.Text.Trim().Replace("'", "''").ToString();
            obj.DirectorFatherName = txtDirectorFatherName.Text.Trim().Replace("'", "''").ToString();
            obj.AadharNumber = txtaadharnumber.Text.Trim().Replace("'", "''").ToString();
            #region Added from document page
            obj.PAN_TAN = txtpantanno.Text.Trim().Replace("'", "''").ToString();
            obj.VAT = txtvat.Text.Trim().Replace("'", "''").ToString();
            #endregion

            obj.City_ID = Convert.ToInt32(ddlCity.SelectedValue);
            obj.Contact_Person = txtPersonName.Text.Trim().Replace("'", "''").ToString();
            if ((txtFax0.Text.Trim() != "") && (txtFax1.Text.Trim() != "") && (txtFax.Text.Trim() != ""))
                obj.Fax = "+" + txtFax0.Text.Trim() + "-" + txtFax1.Text.Trim() + "-" + txtFax.Text.Trim();
            obj.Mobile_No = txtMob.Text.Trim().Replace("'", "''").ToString();
            if ((txtPhone0.Text.Trim() != "") && (txtPhone1.Text.Trim() != "") && (txtPhone.Text.Trim() != ""))
                obj.Phone_No = "+" + txtPhone0.Text.Trim() + "-" + txtPhone1.Text.Trim() + "-" + txtPhone.Text.Trim();
            obj.Comp_ID = Session["CompanyId"].ToString();
            obj.Status = 0;
            obj.Email_Vari_Flag = 0;
            //obj.Update_Flag = 0;
            obj.DML = "U";

            if (compLogo.FileName != "")
            {
                string flName = Path.GetFileNameWithoutExtension(compLogo.FileName);
                string lpath = "~/Info/img/logos/" + obj.Comp_ID.ToString().Substring(5, 4) + "/";
                string fName = lpath + flName + "-" + obj.Comp_ID.ToString().Substring(5, 4) + Path.GetExtension(compLogo.FileName);
                obj.logo_path = fName;
            }

            function9420.SaveCompanyReg(obj);

            if (flSound.FileName != "")
            {
                string path = Server.MapPath("../Data/Sound");
                path = path + "\\" + obj.Comp_ID.ToString().Substring(5, 4);
                DataProvider.Utility.CreateDirectory(path);
                path = path + "\\" + obj.Comp_ID.ToString().Substring(5, 4) + ".mp3";
                SoundFileVerification(obj, path);
                flSound.SaveAs(path);
                Business9420.function9420.UpdateFileFlag(obj);
            }

            if (compLogo.FileName != "")
            {
                string lpath = Server.MapPath("../Info/img/logos");
                lpath = lpath + "\\" + obj.Comp_ID.ToString().Substring(5, 4);
                DataProvider.Utility.CreateDirectory(lpath);
                string flName = Path.GetFileName(compLogo.FileName);
                lpath = lpath + "\\" + Path.GetFileNameWithoutExtension(compLogo.FileName) + "-" + obj.Comp_ID.ToString().Substring(5, 4) + Path.GetExtension(compLogo.FileName);
                //SoundFileVerification(obj, lpath);
                compLogo.SaveAs(lpath);
            }

            allClear();
            FillUpDateProfile();
            // NewMsgpop.Visible = true;
            // LblMsgUpdate.Text = "Profile updated successfully. Kindly go to <span style = 'color:blue;'>Manage Document</span> section if not completed earlier.";
            ScriptManager.RegisterStartupScript(this, GetType(), "loginSuccess", "showAlert('Success', 'Profile updated successfully.', 'success');", true);
            Response.Redirect("frmManfEnquiry.aspx");
            btnUpDate.Text = "Edit";
            EdittxtGray();
        }
        else
        {
            NewMsgpop.Visible = false;
            EdittxtGrayToEdit();
            btnUpDate.ValidationGroup = "chk94";
            btnUpDate.Text = "Update";
            //btnNextDoc.Visible = false;
        }
    }
    private void SoundFileVerification(Object9420 Log, string path)
    {
        // if (File.Exists(path))
        {
            // Log.DML = "I";
            Log.Doc_Id = Log.Comp_ID.ToString().Substring(5, 4) + "_Sound";
            Log.DocFlag = 0;
            function9420.UpdateDocForVerification(Log);
        }
    }

    private void allClear()
    {
        lblaadharmsz.Text = "";
        txtCompName.Text = string.Empty;
        //   ddlCategory.SelectedIndex = 0;
        txtEmail.Text = string.Empty;
        txtWebSite.Text = string.Empty;
        txtAddress.Text = string.Empty;
        txtResiAddress.Text = string.Empty;
        txtDirectorName.Text = string.Empty;
        txtDirectorFatherName.Text = string.Empty;

        ddlCity.SelectedIndex = 0;
        txtPersonName.Text = string.Empty;
        //txtFax0.Text = string.Empty;
        txtFax1.Text = string.Empty;
        txtFax.Text = string.Empty;
        txtMob.Text = string.Empty;
        //txtPhone0.Text = string.Empty;
        txtPhone1.Text = string.Empty;
        txtPhone.Text = string.Empty;

        txtCompName.Focus();
    }
    //protected void btnNextDoc_Click(object sender, EventArgs e)
    //{
    //    if (btnUpDate.Text == "Edit")
    //        Response.Redirect("frmUploadDocuments.aspx");  
    //}

    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlState.SelectedIndex == 0)
        {
            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0, "--Select--");
        }
        else
        {
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT [CITY_ID],[CityName] FROM [CityMaster] where [Flag]= 1 AND [State_id] is not null and [State_id] = " + ddlState.SelectedValue + " ORDER BY  CityName");
            DataProvider.MyUtilities.FillDDLInsertZeroIndexIntVal(ds, "CITY_ID", "CityName", ddlCity, "--Select--");
            ddlCity.SelectedIndex = 0;
        }

    }

    protected void lnkDelete_Click(object sender, EventArgs e)
    {
        DataTable dtComp = SQL_DB.ExecuteDataTable("update Comp_Reg set Logo_Path='' where Comp_ID='" + Session["CompanyId"].ToString() + "'");
        if (dtComp.Rows.Count > 0)
        {
            FillUpDateProfile();
        }
        //NewMsgpop.Visible = true;
        //LblMsgUpdate.Text = "Your logo has been removed successfully.";
        ScriptManager.RegisterStartupScript(this, GetType(), "loginSuccess", "showAlert('Success', 'Your logo has been removed successfully.', 'success');", true);
    }



    protected void btnVerifyOTP_Click(object sender, EventArgs e)
    {
        RequiredFieldValidator15.ErrorMessage = "";
        if (txtaadharotp.Text == "")
        {
            RequiredFieldValidator15.ErrorMessage = "";
            return;
        }
        lblaadharmsz.Text = "";
        lblVerifyOTP.Text = "";

        string str = String.Format("https://vrkableuat.vcqru.com/api/ValidateAadharOTPForVendor");
        WebRequest request = WebRequest.Create(str);
        request.Method = "POST";
        string postData = "{\"Comp_ID\":\"" + Session["CompanyId"].ToString() + "\",\"AadharNo\":\"" + txtaadharnumber.Text + "\",\"Otp\":\"" + txtaadharotp.Text + "\",\"Request_Id\":\"" + hfRequest_Id.Value + "\",\"WebEncData\":\"d861967d37065f549c13e39cc9a8b9\"}";
        byte[] byteArray = Encoding.UTF8.GetBytes(postData);

        request.ContentType = "application/json";//application/     x-www-form-urlencoded

        Stream dataStream = request.GetRequestStream();
        dataStream.Write(byteArray, 0, byteArray.Length);
        dataStream.Close();
        WebResponse response = request.GetResponse();
        Console.WriteLine(((HttpWebResponse)response).StatusDescription);
        dataStream = response.GetResponseStream();
        StreamReader reader = new StreamReader(dataStream);
        string responseFromServer = reader.ReadToEnd();

        // string postData = "{\"Comp_ID\":\"" + Session["CompanyId"].ToString() + "\",\"AadharNo\":\"" + txtaadharnumber.Text + "\",\"Otp\":\"" + txtaadharotp.Text + "\",\"Request_Id\":\"" + hfRequest_Id.Value + "\",\"WebEncData\":\"d861967d37065f549c13e39cc9a8b9\"}";
        // String responseFromServer = db.PostCall(postData, "api/ValidateAadharOTPForVendor", "https://vrkableuat.vcqru.com/");

        if (responseFromServer.Contains("\"Verified successfully\""))
        {
            lblVerifyOTP.Text = "Verified successfully !";
            lnkaadharnumber.Visible = false;
            AadharOTP.Visible = false;
            lblaadharmsz.Text = responseFromServer.Replace('"', ' ');
            lblVerifyOTP.Text = "";

            FillUpDateProfile();
            NewMsgpop.Visible = false;
            //lnkDelete.Visible = false;

            #region Pan card and GSTIN/VAT moved from  document upload page.

            FillVerificationStatus();
            #endregion
        }
        else
            lblVerifyOTP.Text = responseFromServer.Replace('"', ' ');
        lblVerifyOTP.ForeColor = System.Drawing.Color.Red;

    }

    protected void Imageaadharverify_Click(object sender, ImageClickEventArgs e)
    {
        RequiredFieldValidator15.ErrorMessage = "";
        if (txtaadharnumber.Text == "")
        {
            RequiredFieldValidator15.ErrorMessage = "Please Enter Valid Aadhar Number";
            return;
        }

        string ada = hfaadharnumber.Value;
        string Adata = txtaadharnumber.Text;
        lblaadharmsz.Text = "";
        // hfRequest_Id.Value = string.Empty;

        string str = String.Format("https://vrkableuat.vcqru.com/api/SendAadharOTPForVendor");
        WebRequest request = WebRequest.Create(str);
        request.Method = "POST";
        string postData = "{\"Comp_ID\":\"" + Session["CompanyId"].ToString() + "\",\"AadharNo\":\"" + txtaadharnumber.Text + "\",\"WebEncData\":\"d861967d37065f549c13e39cc9a8b9\"}";
        byte[] byteArray = Encoding.UTF8.GetBytes(postData);

        request.ContentType = "application/json";//application/     x-www-form-urlencoded

        Stream dataStream = request.GetRequestStream();
        dataStream.Write(byteArray, 0, byteArray.Length);
        dataStream.Close();
        WebResponse response = request.GetResponse();
        Console.WriteLine(((HttpWebResponse)response).StatusDescription);
        dataStream = response.GetResponseStream();
        StreamReader reader = new StreamReader(dataStream);
        string responseFromServer = reader.ReadToEnd();

        //  string postData = "{\"Comp_ID\":\"" + Session["CompanyId"].ToString() + "\",\"AadharNo\":\"" + txtaadharnumber.Text + "\",\"WebEncData\":\"d861967d37065f549c13e39cc9a8b9\"}";
        // String responseFromServer = db.PostCall(postData, "api/SendAadharOTPForVendor", "https://vrkableuat.vcqru.com/");

        if (responseFromServer.Contains("\"OTP send successfully"))
        {
            responseFromServer = responseFromServer.Replace("\"", "");
            lblaadharmsz.Text = "OTP send successfully!";
            lblaadharmsz.ForeColor = System.Drawing.Color.Green;
            txtaadharnumber.ReadOnly = true;
            lnkaadharnumber.Visible = false;
            AadharOTP.Visible = true;
            string[] Res = responseFromServer.Split('@');
            hfRequest_Id.Value = Res[1].ToString();
        }
        else
        {
            lblaadharmsz.Text = responseFromServer.Replace('"', ' '); ;
            lblaadharmsz.ForeColor = System.Drawing.Color.Red;
        }
    }

    protected void lnkaadharverify_Click(object sender, EventArgs e)
    {



    }

    protected void Imgpanverify_Click(object sender, ImageClickEventArgs e)
    {

        RequiredFieldValidator15.ErrorMessage = "";
        if (txtpantanno.Text == "")
        {
            RequiredFieldValidator15.ErrorMessage = "";
            return;
        }

        lblpanmsz.Text = "";

        string str = String.Format("https://vrkableuat.vcqru.com/api/VendorPancardVerificatioin");
        WebRequest request = WebRequest.Create(str);
        request.Method = "POST";
        string postData = "{\"Comp_ID\":\"" + Session["CompanyId"].ToString() + "\",\"Pancard\":\"" + txtpantanno.Text + "\",\"PanHolderName\":\"Test\",\"WebEncData\":\"d861967d37065f549c13e39cc9a8b9\"}";
        byte[] byteArray = Encoding.UTF8.GetBytes(postData);

        request.ContentType = "application/json";//application/     x-www-form-urlencoded

        Stream dataStream = request.GetRequestStream();
        dataStream.Write(byteArray, 0, byteArray.Length);
        dataStream.Close();
        WebResponse response = request.GetResponse();
        Console.WriteLine(((HttpWebResponse)response).StatusDescription);
        dataStream = response.GetResponseStream();
        StreamReader reader = new StreamReader(dataStream);
        string responseFromServer = reader.ReadToEnd();

        // string postData = "{\"Comp_ID\":\"" + Session["CompanyId"].ToString() + "\",\"Pancard\":\"" + txtpantanno.Text + "\",\"PanHolderName\":\"Test\",\"WebEncData\":\"d861967d37065f549c13e39cc9a8b9\"}";
        // String responseFromServer = db.PostCall(postData, "api/VendorPancardVerificatioin", "https://vrkableuat.vcqru.com/");

        if (responseFromServer.Contains("\"Verified successfully\""))
        {
            lblpanmsz.Text = "Verified successfully.";
            Imgpanverify.Visible = false;
            lblpanmsz.ForeColor = System.Drawing.Color.Green;

            FillUpDateProfile();
            NewMsgpop.Visible = false;
            //lnkDelete.Visible = false;

            #region Pan card and GSTIN/VAT moved from  document upload page.

            FillVerificationStatus();
            #endregion

        }
        else
        {
            lblpanmsz.Text = responseFromServer.Replace('"', ' '); ;
            lblpanmsz.ForeColor = System.Drawing.Color.Red;
        }
    }

    protected void lnkgstverify_Click(object sender, ImageClickEventArgs e)
    {

        RequiredFieldValidator15.ErrorMessage = "";
        if (txtvat.Text == "")
        {
            RequiredFieldValidator15.ErrorMessage = "";
            return;
        }

        lblgstmsz.Text = "";

        string str = String.Format("https://vrkableuat.vcqru.com/api/VendorGSTVerification");
        WebRequest request = WebRequest.Create(str);
        request.Method = "POST";
        string postData = "{\"Comp_ID\":\"" + Session["CompanyId"].ToString() + "\",\"GSTIN\":\"" + txtvat.Text + "\",\"Otp\":\"\",\"WebEncData\":\"d861967d37065f549c13e39cc9a8b9\"}";
        byte[] byteArray = Encoding.UTF8.GetBytes(postData);

        request.ContentType = "application/json";//application/     x-www-form-urlencoded

        Stream dataStream = request.GetRequestStream();
        dataStream.Write(byteArray, 0, byteArray.Length);
        dataStream.Close();
        WebResponse response = request.GetResponse();
        Console.WriteLine(((HttpWebResponse)response).StatusDescription);
        dataStream = response.GetResponseStream();
        StreamReader reader = new StreamReader(dataStream);
        string responseFromServer = reader.ReadToEnd();

        // string postData = "{\"Comp_ID\":\"" + Session["CompanyId"].ToString() + "\",\"GSTIN\":\"" + txtvat.Text + "\",\"Otp\":\"\",\"WebEncData\":\"d861967d37065f549c13e39cc9a8b9\"}";
        // String responseFromServer= db.PostCall(postData, "api/VendorGSTVerification", "https://vrkableuat.vcqru.com/");


        if (responseFromServer.Contains("\"Verified successfully\""))
        {
            lblgstmsz.Text = "Verified successfully.";
            lblgstmsz.ForeColor = System.Drawing.Color.Green;
            lnkgstverify.Visible = false;

            FillUpDateProfile();
            NewMsgpop.Visible = false;
            //lnkDelete.Visible = false;

            #region Pan card and GSTIN/VAT moved from  document upload page.

            FillVerificationStatus();
            #endregion

        }
        else
        {
            lblgstmsz.Text = responseFromServer.Replace('"', ' '); ;
            lblgstmsz.ForeColor = System.Drawing.Color.Red;

        }
    }
}