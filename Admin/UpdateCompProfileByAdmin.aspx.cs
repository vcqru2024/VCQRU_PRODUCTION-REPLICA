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

public partial class Admin_UpdateCompProfileByAdmin : System.Web.UI.Page
{
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

        if (Session["CompanyId"] == null)
        {
            if (Request.QueryString["frmadmin"] == null)
            {
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
            //if (Convert.ToInt32(dsFlCount.Tables[0].Rows[0]["docverifyFlag"]) == 6)
            //    btnNextDoc.Visible = false;
            //else
            //    btnNextDoc.Visible = true;

            btnUpDate.Text = "Edit";
            btnUpDate.ValidationGroup = "chk941";
            EdittxtGray();
            FillUpDateProfile();
            NewMsgpop.Visible = false;
        }
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
        txtCompName.Text = Reg.Comp_Name;
        if (Reg.Comp_Cat_Id.ToString() == "0")
            ddlCategory.SelectedIndex = 0;
        else
            ddlCategory.SelectedValue = Reg.Comp_Cat_Id.ToString();
        txtEmail.Text = Reg.Comp_Email; txtEmail.Enabled = false;
        txtWebSite.Text = Reg.WebSite;
        txtAddress.Text = Reg.Address;

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
        path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + ".wav";
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
        if (ext.ToUpper() == ".WAV")
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
    }
    private void EdittxtGrayToEdit()
    {
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

    }
    protected void btnUpDate_Click(object sender, EventArgs e)
    {
        if (btnUpDate.Text == "Update")
        {
            Object9420 obj = new Object9420();
            obj.Comp_Name = txtCompName.Text.Trim().Replace("'", "''").ToString();
            obj.Comp_Cat_Id = Convert.ToInt32(ddlCategory.SelectedValue);
            obj.Comp_Email = txtEmail.Text.Trim().Replace("'", "''").ToString();
            obj.WebSite = txtWebSite.Text.Trim().Replace("'", "''").ToString();
            obj.Address = txtAddress.Text.Trim().Replace("'", "''").ToString();
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
            function9420.SaveCompanyReg(obj);
            if (flSound.FileName != "")
            {
                string path = Server.MapPath("../Data/Sound");
                path = path + "\\" + obj.Comp_ID.ToString().Substring(5, 4);
                DataProvider.Utility.CreateDirectory(path);
                path = path + "\\" + obj.Comp_ID.ToString().Substring(5, 4) + ".wav";
                SoundFileVerification(obj, path);
                flSound.SaveAs(path);
                Business9420.function9420.UpdateFileFlag(obj);
            }
            allClear();
            FillUpDateProfile();
            NewMsgpop.Visible = true;
            LblMsgUpdate.Text = "Profile updated successfully. Kindly go to <span style = 'color:blue;'>Manage Document</span> section if not completed earlier.";
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
        if (!File.Exists(path))
        {
            Log.DML = "I";
            Log.Doc_Id = Log.Comp_ID.ToString().Substring(5, 4) + "_Sound";
            Log.DocFlag = 0;
            function9420.UpdateDocForVerification(Log);
        }
    }
    private void allClear()
    {
        txtCompName.Text = string.Empty;
        ddlCategory.SelectedIndex = 0;
        txtEmail.Text = string.Empty;
        txtWebSite.Text = string.Empty;
        txtAddress.Text = string.Empty;
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
}