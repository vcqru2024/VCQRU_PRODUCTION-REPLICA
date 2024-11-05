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
using Business9420;
using System.Web.Services;
using System.Web.Script.Services;
using System.IO;
using Business_Logic_Layer;

public partial class Consumer_Profile : System.Web.UI.Page
{
    public int Flag = 0, index = 0, sno = 1;

    private string _Bnkid, _Consumerid;
    public string Bnkid
    {
        get { return (string)ViewState["_Bnkid"]; }
        set { ViewState["_Bnkid"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

#region Patanjali logo
if(Session["Comp_id"].ToString() == "Comp-1693")
        {
            Complogo.Src = "https://www.patanjaliayurved.net/media/images/logo.svg";
 Complogo.Style.Add("width", "150px");
        }
#endregion

        //aadharbackvalidator.IsValid = true;
        //aadharfilevalidator.IsValid = true;
        imgaahar.Visible = false;
        imgback.Visible = false;
        imgpass.Visible = false;
        if (Request.QueryString["app"] == "1")
        {
            string consumer_id = Request.QueryString["userid"];
            User_Details Log = new User_Details();
            Log.User_Type = "Consumer";
            Log.User_ID = consumer_id;
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            Session["USRID"] = dt.Rows[0]["User_ID"].ToString();
            Session["M_ConsumeriD"] = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
            Session["User_Type"] = "Consumer";
            if (!string.IsNullOrEmpty(dt.Rows[0]["employeeID"].ToString()) && !string.IsNullOrEmpty(dt.Rows[0]["distributorID"].ToString()))
            {
                HttpContext.Current.Session["MMUser"] = "MMUSERR";
            }
            else { HttpContext.Current.Session["MMUser"] = ""; }
            HttpContext.Current.Session["Consumer_id"] = dt.Rows[0]["m_consumerid"].ToString();
            _Consumerid = dt.Rows[0]["m_consumerid"].ToString();
            HttpContext.Current.Session["USRNAME"] = dt.Rows[0]["ConsumerName"].ToString();
            ProjectSession.strConsumerName = dt.Rows[0]["ConsumerName"].ToString();
        }
        else
        {
            if (Session["Consumer_id"] != null)
                _Consumerid = Session["Consumer_id"].ToString();
            else
            {
                if ((HttpContext.Current.Request.Cookies["ConsumerUserName"].Value != null) && (HttpContext.Current.Request.Cookies["ConsumerPassword"].Value != null))
                {
                    User_Details Log = new User_Details();
                    Log.User_ID = HttpContext.Current.Request.Cookies["ConsumerUserName"].Value;
                    Log.DML = "Mobile";
                    Log.Password = HttpContext.Current.Request.Cookies["ConsumerPassword"].Value.Trim().Replace("'", "''");
                    DataTable dt = User_Details.GetUserLoginDetails(Log);
                    if (!string.IsNullOrEmpty(dt.Rows[0]["employeeID"].ToString()) && !string.IsNullOrEmpty(dt.Rows[0]["distributorID"].ToString()))
                    {
                        HttpContext.Current.Session["MMUser"] = "MMUSERR";
                    }
                    else { HttpContext.Current.Session["MMUser"] = ""; }
                    Session["USRID"] = dt.Rows[0]["User_ID"].ToString();
                    _Consumerid = dt.Rows[0]["m_consumerid"].ToString();
                    Session["User_Type"] = "Consumer";
                }
            }
        }
        txtAccountNo.Attributes.Add("autocomplete", "stopdoingthat");
        txtEmail.Attributes.Add("autocomplete", "stopdoingthat");
        txtifscCode.Attributes.Add("autocomplete", "stopdoingthat");
        lblIfsc_error.Visible = false;
        // _Consumerid = SQL_DB.ExecuteScalar("select [m_consumerid]  from [m_consumer] where [User_id]='" + Session["USRID"].ToString() + "'").ToString();


        string mahindracounts = ExecuteNonQueryAndDatatable.checkscalarvalues("[checkmahindra]", Convert.ToInt32(_Consumerid));
        mmvalue.Value = mahindracounts;
        if (IsPostBack)
        {
            User_Details Log = new User_Details();
            //HttpPostedFile filePosted = Request.Files["aadharfile"];
            //HttpPostedFile filePostedback = Request.Files["aadharback"];

            HttpPostedFile filePostedpass = Request.Files["Passbookfile"];


            if (filePostedpass != null && filePostedpass.ContentLength > 0)
            {
                try
                {
                    if (Passbookfile.PostedFile.ContentLength <= 409600)
                    {

                    }
                    else
                    {
                        NewMsgpopupld.Visible = true;

                        NewMsgpopupld.Attributes["class"] = "alert alert-danger";
                        NewMsgpopupld.InnerHtml = "<strong>Warning</Strong>    File size mus be less than 400KB";
                        //HtmlControl control = FindControl("upload_document") as HtmlControl;
                        //control.Attributes["class"] = "tab-pane active";
                        //control = FindControl("personal") as HtmlControl;
                        //control.Attributes["class"] = "tab-pane";
                        //control = FindControl("profile_nav") as HtmlControl;
                        //control.Attributes["class"] = "nav-link";
                        //control = FindControl("upload_nav") as HtmlControl;
                        //control.Attributes["class"] = "nav-link active";

                    }

                }
                catch (Exception ex)
                {
                    NewMsgpopupld.Visible = true;
                    //NewMsgpopupld.Attributes.Add("class", "msg_green");
                    NewMsgpopupld.Attributes["class"] = "alert alert-danger";
                    NewMsgpopupld.InnerHtml = "<strong>Warning</Strong>    File not uploaded please try after some time.";
                    //LblMsgUpdateupld.Text = "    File not uploaded please try after some time.";
                }
            }
            HttpPostedFile filePosted1 = Request.Files["profile_upload"];
            if (filePosted1 != null && filePosted1.ContentLength > 0)
            {
                if (profile_upload.PostedFile.ContentLength < 409600)
                {
                    string fileName = Path.GetFileName(profile_upload.PostedFile.FileName);
                    string flName = Path.GetFileNameWithoutExtension(fileName);
                    string flExtn = Path.GetExtension(fileName);

                    if (flExtn.ToLower() == ".jpg" || flExtn.ToLower() == ".jpeg" || flExtn.ToLower() == ".png")
                    {
                        string lPath = "/img/Profile/";
                        string path = Server.MapPath(lPath);
                        DataProvider.Utility.CreateDirectory(path);
                        string fullFName = path + Session["USRID"].ToString() + flExtn;

                        filePosted1.SaveAs(fullFName);
                        Log.Profile_image = lPath + Session["USRID"].ToString() + flExtn;
                        DataTable dtconsumerid = SQL_DB.ExecuteDataTable("select [M_consumerid] from [M_consumer] where [User_id]='" + Session["USRID"].ToString() + "'");
                        if (dtconsumerid.Rows.Count > 0)
                        {
                            int imgcount = Convert.ToInt32(SQL_DB.ExecuteScalar("select count(profile_img) from [Profile_images] where [M_consumerid]=" + dtconsumerid.Rows[0][0]));

                            if (imgcount > 0)
                                SQL_DB.ExecuteScalar("update [Profile_images] set profile_img='" + Log.Profile_image + "' where [M_consumerid]=" + dtconsumerid.Rows[0][0]);
                            else
                                SQL_DB.ExecuteScalar("insert into [Profile_images] values(" + dtconsumerid.Rows[0][0] + ",'" + Log.Profile_image + "')");
                        }
                        FillUpDateProfile();
                    }
                    else
                    {
                        string msg = "Please Upload a File in jpg/jpeg/png Format.";
                        Response.Write("<script langauge=\"javascript\">alert('" + msg + "');</script>");


                    }
                }
                else
                {
                    //string msg = "File size must be less than 400KB.";
                    //Response.Write("<script langauge=\"javascript\">alert('" + msg + "');</script>");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
                }
            }

        }
        if (Session["User_Type"] == null)
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/default.aspx#logsign");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/default.aspx#logsign");
        }

        btnUpDate.Text = "Update";
        btnUpDate.ValidationGroup = "chk94";
        // EdittxtGray();
        if (!IsPostBack)
        {
            NewMsgpop.Visible = false;
            NewMsgpopupld.Visible = false;
            dvdealermsg.Visible = false;
            DivNewMsg.Visible = false;
            txtbankname.Enabled = false;
            txtBranch.Enabled = false;
            Passbookfile.Enabled = false;
            FillUpDateProfile();

            //string bnkid =(string) SQL_DB.ExecuteScalar("SELECT top 1 case when [Bank_ID]=null then ' ' else [Bank_ID] end as Bank_ID FROM [M_BankAccount] where [M_Consumerid] = '" + _Consumerid + "' and Account_No<>'' and Account_No is not null order by [Entry_Date] desc");
            DataTable dtbnkid = SQL_DB.ExecuteDataTable("SELECT top 1 * FROM [M_BankAccount] where [M_Consumerid] = '" + _Consumerid + "' order by [Entry_Date] desc");
            if (dtbnkid.Rows.Count > 0)
            {
                Bnkid = dtbnkid.Rows[0]["Bank_ID"].ToString();

                txtAccHolderNm.Enabled = false;
                txtifscCode.Enabled = false;
                txtAccountNo.Enabled = false;
                txtCnfAccountNo.Enabled = false;
                txtbankname.Enabled = false;
                txtBranch.Enabled = false;
                DropDownList1.Enabled = false;

 #region //** To Update blank or null fields value
                if (dtbnkid.Rows[0]["Bank_Name"] == null || dtbnkid.Rows[0]["Bank_Name"].ToString() == "")
                {
                    txtbankname.Enabled = true;
                }
                if (dtbnkid.Rows[0]["Account_HolderNm"] == null || dtbnkid.Rows[0]["Account_HolderNm"].ToString() == "")
                {
                    txtAccHolderNm.Enabled = true;
                }
                if (dtbnkid.Rows[0]["Account_No"] == null || dtbnkid.Rows[0]["Account_No"].ToString() == "")
                {
                    txtAccountNo.Enabled = true;
                    txtCnfAccountNo.Enabled = true;
                }
                if (dtbnkid.Rows[0]["Branch"] == null || dtbnkid.Rows[0]["Branch"].ToString() == "")
                {
                    txtBranch.Enabled = true;
                }
                if (dtbnkid.Rows[0]["IFSC_Code"] == null || dtbnkid.Rows[0]["IFSC_Code"].ToString() == "")
                {
                    txtifscCode.Enabled = true;
                }
                if (dtbnkid.Rows[0]["Account_Type"] == null || dtbnkid.Rows[0]["Account_Type"].ToString() == "")
                {
                    DropDownList1.Enabled = true;
                }
                #endregion

                if (dtbnkid.Rows[0]["chkpassbook"] == null || dtbnkid.Rows[0]["chkpassbook"].ToString() == "")
                {
                    Passbookfile.Enabled = false;
                }
                else
                {
                    editbtn2.Attributes.Add("style", "Display: none ! important;");
                }
                EditMode();
            }



            if (Session["MMUser"] != null) { dealerInformation.Visible = true; }
            else { dealerInformation.Visible = false; }


            //////////////////////////

            DropDownList1.Items.Add("Saving");
            DropDownList1.Items.Add("Current");
        }
        //lbldealerinfomation.Visible = false;
        //////////////////
        ///

        if (Session["Comp_id"].ToString() == "Comp-1388")
        {
            logo.Visible = false;
        }

    }
    public void EditMode()
    {
        if (Bnkid != "0" && Bnkid != "")
        {
            Object9420 Reg = new Object9420();
            Reg.Bank_ID = Bnkid;
            function9420.GetBankInfo(Reg);
            txtbankname.Text = Reg.Bank_Name;
            txtAccHolderNm.Text = Reg.Account_HolderNm;
            txtAccountNo.Attributes["value"] = Reg.Account_No; ;

            txtCnfAccountNo.Text = Reg.Account_No;
            txtBranch.Text = Reg.Branch;
            txtifscCode.Text = Reg.IFSC_Code;
            //txtCity.Text = Reg.City;
            //txtEmail.Text = Reg.Email;

            //txtrtgsCode.Text = Reg.RTGS_Code;
            // txtaddress.Text = Reg.Address;
            //if (Reg.Account_Type == "Current")
            //{
            //    rdsaving.Checked = false;
            //    rdcurrent.Checked = true;
            //}
            //else
            //{
            //    rdcurrent.Checked = false;
            //    rdsaving.Checked = true;
            //}
            if (File.Exists(Server.MapPath(Reg.chkpassbook)))
            {
                string dttm = DateTime.Now.Ticks.ToString();
                Imgbank.Attributes.Add("class", "img-documents");
                imgpass.Visible = true;
                Imgbank.ImageUrl = Reg.chkpassbook + "?" + dttm;
                Imgbank.DataBind();
                Passbookfile.Enabled = false;
                Passbookfile.Style.Add("opacity", "1");
                passupload.Style.Add("border", "none");

            }
        }

        btnSubmit.Text = "Update";
        //CouponProver Reg = new CouponProver();
        //lblBankId.Text = Giftid_Prop;
        //Reg.Gift_ID = lblBankId.Text;
        ////newMsg.Visible = false;
        //Reg.DML = "S";
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //CouponProver.GiftFillDataGrid(Reg);

        //txtName.Text = Reg.GiftName;
        //  lblAddCourierHeader.Text = "Gift update Details";

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
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [M_Consumer] FROM [Email] where [Comp_Email] = '" + res + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }

    private void FillUpDateProfile()
    {
        // allClear();
        User_Details Reg = new User_Details();
        Reg.User_ID = Session["USRID"].ToString();




        User_Details.FillUpDateProfile(Reg);
        if (File.Exists(Server.MapPath(Reg.AadhaarFile)))
        {
            string dttm = DateTime.Now.Ticks.ToString();
            imgaahar.Visible = true;
            imgAadharCard.ImageUrl = Reg.AadhaarFile + "?" + dttm;
            imgAadharCard.Attributes.Add("class", "img-documents");
            imgAadharCard.DataBind();
            aadharfile.Enabled = false;
            aadharfile.Style.Add("opacity", "1");
            dvadhar.Style.Add("border", "none");

        }

        if (File.Exists(Server.MapPath(Reg.Aadhaarback)))
        {
            string dttm = DateTime.Now.Ticks.ToString();
            imgback.Visible = true;
            image_aadharback.ImageUrl = Reg.Aadhaarback + "?" + dttm;
            image_aadharback.Attributes.Add("class", "img-documents");
            image_aadharback.DataBind();
            aadharback.Enabled = false;
            aadharback.Style.Add("opacity", "1");
            Div1.Style.Add("border", "none");

        }


        txtEmail.Text = Reg.Email;
        // txtEmail.Enabled = false;
        lblusertop.Text = lblUser_name.Text = txtPersonName.Text = Reg.ConsumerName;
        txtAddress.Text = Reg.Address;
        txtMob.Text = Reg.MobileNo;
        ddlCity.Text = Reg.City;
        txtpincode.Text = Reg.PinCode;
        _Consumerid = Reg.Consumer_ID;
        // txtEmail.Text = Reg.Email;
        //if (Reg.MMUser != null)
        lblMMUser.Text = Reg.MMUser;
        //else
        //    lblMMUser.Text = "NA";
        lblUser_designation.Text = Reg.Designation;
        employeeid.Text = Reg.MMEmployeID;
        distributorid.Text = Reg.MMDistributorID;
        aadharnumber.Text = Reg.AadhaarNumber;
        if (File.Exists(Server.MapPath(Reg.Profile_image)))
        {
            string dttm = DateTime.Now.Ticks.ToString();
            imgProfile.ImageUrl = Reg.Profile_image + "?" + dttm;
            top_profile_img.ImageUrl = Reg.Profile_image + "?" + dttm;
            imgProfile.DataBind();
            top_profile_img.DataBind();
            //HtmlControl control = FindControl("top_profile_img") as HtmlControl;
            //control.Attributes["src"] = "../img/Profile/" + Reg.User_ID + ".png";
        }
        else
        {
            string dttm = DateTime.Now.Ticks.ToString();
            imgProfile.ImageUrl = "../assetsfrui/images/user-profile/user-img.jpg" + "?" + dttm;
            top_profile_img.ImageUrl = "../assetsfrui/images/user-profile/user-img.jpg" + "?" + dttm;
            imgProfile.DataBind();
            top_profile_img.DataBind();
            //HtmlControl control = FindControl("top_profile_img") as HtmlControl;
            //control.Attributes["src"] = "../assetsfrui/images/user-profile/user-img.jpg";
        }


        //lnkAadharCard.InnerText = "www.vcqru.com" + Reg.AadhaarFile;
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
    private void EdittxtGray()
    {
        txtEmail.Enabled = false;
        txtEmail.Enabled = false;
        txtAddress.Enabled = false;
        ddlCity.Enabled = false;
        txtPersonName.Enabled = false;
        txtMob.Enabled = false;
        txtpincode.Enabled = false;
        ddlCity.Enabled = false;

        employeeid.Enabled = false;
        distributorid.Enabled = false;
        aadharnumber.Enabled = false;
        aadharfile.Enabled = false;
    }
    private void EdittxtGrayToEdit()
    {
        txtEmail.Enabled = true;
        txtEmail.Enabled = true;
        ddlCity.Enabled = true;
        ddlCity.Enabled = true;
        txtPersonName.Enabled = true;
        txtAddress.Enabled = true;
        txtMob.Enabled = false;
        txtpincode.Enabled = true;

        employeeid.Enabled = true;
        distributorid.Enabled = true;
        aadharnumber.Enabled = true;
        aadharfile.Enabled = true;
    }

    protected void btnupload_Click(object sender, EventArgs e)
    {
        User_Details Log = new User_Details();
        if (aadharfile.PostedFile.ContentLength > 0)
        {
            try
            {
                string fileName = Path.GetFileName(aadharfile.PostedFile.FileName);
                string flName = Path.GetFileNameWithoutExtension(fileName);
                string flExtn = Path.GetExtension(fileName);

                //Guid guid = Guid.NewGuid();
                string lPath = "/img/aadharFile/";
                string path = Server.MapPath(lPath);
                DataProvider.Utility.CreateDirectory(path);
                string fullFName = path + Session["USRID"].ToString() + flExtn;

                //aadharfile.SaveAs(fullFName);
                Log.AadhaarFile = lPath + Session["USRID"].ToString() + flExtn;


                //NewMsgpop.Visible = true;
                //NewMsgpop.Attributes.Add("class", "msg_green");
                //LblMsgUpdate.Text = "    File Uploaded successfully.";
                HtmlControl _control = FindControl("imgAadharCard") as HtmlControl;
                _control.Attributes["class"] = "img-documents";
                _control.Attributes["src"] = "../img/aadharFile/" + Session["USRID"].ToString() + flExtn;
                SQL_DB.ExecuteNonQuery("update [M_consumer] set aadharfile='" + Log.AadhaarFile + "' where [User_id]='" + Session["USRID"].ToString() + "'");
                NewMsgpopupld.Visible = true;
                NewMsgpop.Attributes.Add("class", "msg_green");
                //LblMsgUpdateupld.Text = "    Aadhar File Uploaded successfully.";
                // LblMsgUpdate.Text = "Email ID Already exist!";
                string script2 = @"setTimeout(function () {$('#NewMsgpopupld').fadeOut(100, null);}, 5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script2, true);

            }
            catch (Exception ex)
            {

            }
        }
        if (Passbookfile.PostedFile.ContentLength > 0)
        {
            try
            {
                string fileName = Path.GetFileName(Passbookfile.PostedFile.FileName);
                string flName = Path.GetFileNameWithoutExtension(fileName);
                string flExtn = Path.GetExtension(fileName);

                Guid guid = Guid.NewGuid();
                string lPath = "/img/BankDocuments/";
                string path = Server.MapPath(lPath);
                DataProvider.Utility.CreateDirectory(path);
                string fullFName = path + Session["USRID"].ToString() + flExtn;

                // Passbookfile.SaveAs(fullFName);
                Log.BankFile = lPath + Session["USRID"].ToString() + flExtn;
                NewMsgpop.Visible = true;
                NewMsgpop.Attributes.Add("class", "msg_green");
                //LblMsgUpdate.Text = "    Files Uploaded successfully.";

                Imgbank.Attributes.Add("class", "img-documents");
                Imgbank.ImageUrl = "../img/BankDocuments/" + Session["USRID"].ToString() + flExtn;
                Imgbank.DataBind();

                _Consumerid = SQL_DB.ExecuteScalar("select [m_consumerid]  from [m_consumer] where [User_id]='" + Session["USRID"].ToString() + "'").ToString();
                SQL_DB.ExecuteNonQuery("update [m_bankaccount] set chkpassbook='" + Log.BankFile + "' where [m_consumerid]='" + _Consumerid + "'");
                NewMsgpopupld.Visible = true;
                NewMsgpop.Attributes.Add("class", "msg_green");
                //LblMsgUpdateupld.Text = "    Checkbook/Passbook File Uploaded successfully.";
                // LblMsgUpdate.Text = "Email ID Already exist!";
                string script2 = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script2, true);

            }
            catch (Exception ex)
            { }
        }
        HtmlControl control = FindControl("upload_document") as HtmlControl;
        control.Attributes["class"] = "tab-pane active";
        control = FindControl("personal") as HtmlControl;
        control.Attributes["class"] = "tab-pane";
        control = FindControl("profile_nav") as HtmlControl;
        control.Attributes["class"] = "nav-link";
        control = FindControl("upload_nav") as HtmlControl;
        control.Attributes["class"] = "nav-link active";



    }
    protected void btnUpDate_Click(object sender, EventArgs e)
    {


        Page.Validate("chk94");
        bool vldt = Page.IsValid;
        HttpPostedFile filePosted = Request.Files["aadharfile"];
        HttpPostedFile filePostedback = Request.Files["aadharback"];

        if (imgAadharCard.ImageUrl != "")
        {
            lblaadhar.Visible = false;

        }
        else
        {
            if (filePosted.FileName == "")
            {
                lblaadhar.Visible = true;
                lblaadharback.Visible = true;
                aadharback.Enabled = true;
                vldt = false;
            }
            else
            {
                lblaadhar.Visible = false;
            }
        }
        if (image_aadharback.ImageUrl != "")
        {
            lblaadharback.Visible = false;
        }
        else
        {
            if (filePostedback.FileName == "")
            {
                lblaadharback.Visible = true;
                lblaadhar.Visible = true;
                aadharback.Enabled = true;
                vldt = false;
            }
            else
            {
                lblaadharback.Visible = false;
            }
        }
        //if (filePosted. == true && Passbookfile == null)
        //{
        //    passbookkvalidator.IsValid = false;
        //}
        //else
        //{
        //    passbookkvalidator.IsValid = true;
        //}



        if (vldt)
        {
            if (btnUpDate.Text == "Update")
            {
                /////////////////////////////////////////////////////////////////////
                ///
                User_Details Log = new User_Details();

                if (filePosted != null && filePosted.ContentLength > 0)
                {
                    try
                    {
                        if (aadharfile.PostedFile.ContentLength <= 409600)
                        {
                            string fileName = Path.GetFileName(aadharfile.PostedFile.FileName);
                            string flName = Path.GetFileNameWithoutExtension(fileName);
                            string flExtn = Path.GetExtension(fileName);
                            if (flExtn.ToLower() == ".jpg" || flExtn.ToLower() == ".jpeg" || flExtn.ToLower() == ".png")
                            {
                                //Guid guid = Guid.NewGuid();
                                string lPath = "/img/aadharFile/";
                                string path = Server.MapPath(lPath);
                                DataProvider.Utility.CreateDirectory(path);
                                string fullFName = path + Session["USRID"].ToString() + flExtn;

                                filePosted.SaveAs(fullFName);
                                Log.AadhaarFile = lPath + Session["USRID"].ToString() + flExtn;

                            }
                            else
                            {

                                NewMsgpop.Visible = true;
                                NewMsgpop.Attributes["class"] = "alert alert-danger";
                                NewMsgpop.InnerHtml = "<strong>Warning</Strong>    Please Upload a File in jpg/jpeg/png Format.";
                                HtmlControl control1 = FindControl("profile_form") as HtmlControl;
                                control1.Attributes["class"] = "profile_form profile_form-edit";
                                goto profileend;
                            }
                        }
                        else
                        {
                            NewMsgpop.Visible = true;
                            NewMsgpop.Attributes["class"] = "alert alert-danger";
                            NewMsgpop.InnerHtml = "<strong>Warning</Strong>    File size must be less than 400KB";
                            HtmlControl control1 = FindControl("profile_form") as HtmlControl;
                            control1.Attributes["class"] = "profile_form profile_form-edit";
                            goto profileend;
                        }


                    }
                    catch (Exception ex)
                    {
                        NewMsgpop.Visible = true;

                        NewMsgpop.Attributes["class"] = "alert alert-danger";
                        NewMsgpop.InnerHtml = "<strong>Warning</Strong>    File not uploaded please try after some time.";
                        HtmlControl control1 = FindControl("profile_form") as HtmlControl;
                        control1.Attributes["class"] = "profile_form profile_form-edit";
                        goto profileend;
                    }
                }
                if (filePostedback != null && filePostedback.ContentLength > 0)
                {
                    try
                    {
                        if (aadharback.PostedFile.ContentLength <= 409600)
                        {
                            string fileName = Path.GetFileName(aadharback.PostedFile.FileName);
                            string flName = Path.GetFileNameWithoutExtension(fileName);
                            string flExtn = Path.GetExtension(fileName);
                            if (flExtn.ToLower() == ".jpg" || flExtn.ToLower() == ".jpeg" || flExtn.ToLower() == ".png")
                            {
                                //Guid guid = Guid.NewGuid();
                                string lPath = "/img/aadharFile/";
                                string path = Server.MapPath(lPath);
                                DataProvider.Utility.CreateDirectory(path);
                                string fullFName = path + Session["USRID"].ToString() + "_back" + flExtn;

                                filePostedback.SaveAs(fullFName);
                                Log.Aadhaarback = lPath + Session["USRID"].ToString() + "_back" + flExtn;

                                // SQL_DB.ExecuteNonQuery("update [M_consumer] set aadharback='" + Log.Aadhaarback + "' where [User_id]='" + Session["USRID"].ToString() + "'");
                                //HtmlControl control = FindControl("upload_document") as HtmlControl;
                                //control.Attributes["class"] = "tab-pane active";
                                //control = FindControl("personal") as HtmlControl;
                                //control.Attributes["class"] = "tab-pane";
                                //control = FindControl("profile_nav") as HtmlControl;
                                //control.Attributes["class"] = "nav-link";
                                //control = FindControl("upload_nav") as HtmlControl;
                                //control.Attributes["class"] = "nav-link active";
                                //FillUpDateProfile();



                                NewMsgpop.Visible = true;

                                NewMsgpop.Attributes["class"] = "alert alert-success";
                                NewMsgpop.InnerHtml = "<strong>Success</Strong>    Aadhar Back  uploaded successfully.";
                                //LblMsgUpdateupld.Text = "    File Uploaded successfully.";
                            }
                            else
                            {
                                NewMsgpop.Visible = true;

                                NewMsgpop.Attributes["class"] = "alert alert-danger";
                                NewMsgpop.InnerHtml = "<strong>Warning</Strong>    Please Upload a File in jpg/jpeg/png Format.";
                                HtmlControl control1 = FindControl("profile_form") as HtmlControl;
                                control1.Attributes["class"] = "profile_form profile_form-edit";
                                goto profileend;
                                //HtmlControl control = FindControl("upload_document") as HtmlControl;
                                //control.Attributes["class"] = "tab-pane active";
                                //control = FindControl("personal") as HtmlControl;
                                //control.Attributes["class"] = "tab-pane";
                                //control = FindControl("profile_nav") as HtmlControl;
                                //control.Attributes["class"] = "nav-link";
                                //control = FindControl("upload_nav") as HtmlControl;
                                //control.Attributes["class"] = "nav-link active";
                                //NewMsgpopupld.Visible = true;

                                //NewMsgpopupld.Attributes["class"] = "alert alert-danger";
                                //NewMsgpopupld.InnerHtml = "<strong>Warning</Strong>    Please Upload a File in jpg/jpeg/png Format.";

                            }
                        }
                        else
                        {
                            NewMsgpop.Visible = true;

                            NewMsgpop.Attributes["class"] = "alert alert-danger";
                            NewMsgpop.InnerHtml = "<strong>Warning</Strong>    File size must be less than 400KB";
                            //NewMsgpopupld.Visible = true;
                            HtmlControl control1 = FindControl("profile_form") as HtmlControl;
                            control1.Attributes["class"] = "profile_form profile_form-edit";
                            goto profileend;
                            //NewMsgpopupld.Attributes["class"] = "alert alert-danger";
                            //NewMsgpopupld.InnerHtml = "<strong>Warning</Strong>    File size must be less than 400KB";
                            //HtmlControl control = FindControl("upload_document") as HtmlControl;
                            //control.Attributes["class"] = "tab-pane active";
                            //control = FindControl("personal") as HtmlControl;
                            //control.Attributes["class"] = "tab-pane";
                            //control = FindControl("profile_nav") as HtmlControl;
                            //control.Attributes["class"] = "nav-link";
                            //control = FindControl("upload_nav") as HtmlControl;
                            //control.Attributes["class"] = "nav-link active";
                            //NewMsgpopupld.Visible = true;

                        }

                    }
                    catch (Exception ex)
                    {
                        NewMsgpopupld.Visible = true;

                        NewMsgpopupld.Attributes["class"] = "alert alert-danger";
                        NewMsgpopupld.InnerHtml = "<strong>Warning</Strong>    File not uploaded please try after some time.";
                        HtmlControl control1 = FindControl("profile_form") as HtmlControl;
                        control1.Attributes["class"] = "profile_form profile_form-edit";

                        goto profileend;
                    }
                }




                //////////////////////////////////////////////////////////////////////////


                Log.MMEmployeID = employeeid.Text;
                Log.MMDistributorID = distributorid.Text;

                if (aadharnumber.Text != "")
                    Log.AadhaarNumber = aadharnumber.Text.Trim().Replace("'", "''");

                string aadhr = aadharnumber.Text;
                Log.User_ID = Session["USRID"].ToString();
                Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
                Log.ConsumerName = txtPersonName.Text.Trim().Replace("'", "''");
                Log.Email = txtEmail.Text.Trim().Replace("'", "''");
                Log.MobileNo = txtMob.Text.Trim().Replace("'", "''");
                Log.City = ddlCity.Text.Trim().Replace("'", "''");
                Log.PinCode = txtpincode.Text.Trim().Replace("'", "''");

                //Log.Password = txtpincode.Text.Trim().Replace("'", "''");


                //////////////////////////////

                /////////////////////////

                Log.IsActive = 0;
                Log.IsDelete = 0;
                Log.Address = Request.Form["txtAddress"].ToString().Trim().Replace("'", "''");
                Log.DML = "U";

                User_Details.InsertUpdateUserDetails(Log);
                allClear();
                FillUpDateProfile();
                //NewMsgpop.Visible = true;

                btnUpDate.Text = "Update";
                NewMsgpop.Visible = true;


                NewMsgpop.InnerHtml = "Profile updated successfully.";

                //NewMsgpop.Visible = true;
                //NewMsgpop.Attributes.Add("class", "msg_green");
                //LblMsgUpdate.Text = "    Profile updated successfully.";
                // LblMsgUpdate.Text = "Email ID Already exist!";
                //        string script2 = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
                //        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script2, true);
                //// EdittxtGray();
                //string myscript = "document.getElementById('" + btnprf.ClientID + "').click()";
                //ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "myscript", myscript, true);

                //}
                //else
                //{
                //    NewMsgpop.Visible = true;
                //    NewMsgpop.Attributes.Add("class", "alert_boxes_pink2 big_msg");
                //    LblMsgUpdate.Text = "Dealer Technician Id/Techmaster ID and Dealer Code is wrong.";
                //}
                //}
            }
            else
            {
                NewMsgpop.Visible = false;
                EdittxtGrayToEdit();
                btnUpDate.ValidationGroup = "chk94";
                btnUpDate.Text = "Update";
                btnNextDoc.Visible = false;
            }
            FillUpDateProfile();
        }
        else
        {
            HtmlControl control = FindControl("profile_form") as HtmlControl;
            control.Attributes["class"] = "profile_form profile_form-edit";


        }
    profileend:;
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
        txtEmail.Text = string.Empty;
        ddlCity.Text = string.Empty;
        txtPersonName.Text = string.Empty;
        txtMob.Text = string.Empty;
        txtAddress.Text = string.Empty;
    }
    protected void btnNextDoc_Click(object sender, EventArgs e)
    {
        allClear();
        FillUpDateProfile();
    }

    protected void imgProfile_Click(object sender, ImageClickEventArgs e)
    {


    }
    /////////////////////////bank PAge coding//////////////////////
    public static bool checkNewAccount(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Bank_Name] FROM M_BankAccount where [Bank_Name] = '" + res + "' and M_Consumerid=" + ProjectSession.intM_ConsumeriD);
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewLabel(string res)
    {
        string[] Arr = res.ToString().Split('*');
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [GiftName] FROM [M_Gift] WHERE  [GiftName]  = '" + Arr[0].ToString() + "' AND Comp_ID = '" + Arr[1].ToString() + "' AND IsDelete = 0 ");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        //  Clear();
        // newMsg.Visible = false; DivNewMsg.Visible = false;
        // ModalPopupExtenderNewDesign.Show();
    }
    private void Clear()
    {

        //  dhnactiontype.Value = string.Empty;
        // txtName.Text = "";
        //  lblAddCourierHeader.Text = "Add New Gift";
        // btnSubmit.Text = "Save";
    }
    protected void btnSearch_Click(object sender, ImageClickEventArgs e)
    {
        //  FillGrid();
        // newMsg.Visible = false;
    }
    protected void btnRefesh_Click(object sender, ImageClickEventArgs e)
    {
        //txtSearchName.Text = "";
        // FillGrid();
        // newMsg.Visible = false;
    }
    private void FillGrid()
    {
        //CouponProver Reg = new CouponProver();
        //Reg.DML = "F";
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //Reg.GiftName = txtSearchName.Text.Trim().Replace("'", "''");
        //DataTable DsGrd = new DataTable();
        //DsGrd = Business9420.CouponProver.GiftFillDataGrid(Reg);
        ////if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        ////{
        ////    if (DsGrd.Rows.Count > 0)
        ////        GrdVw.PageSize = DsGrd.Rows.Count;
        ////}
        ////else
        ////    GrdVw.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        //if (DsGrd.Rows.Count > 0)
        //    GrdVw.DataSource = DsGrd;
        //GrdVw.DataBind();
        //lblcount.Text = DsGrd.Rows.Count.ToString();
        //if (GrdVw.Rows.Count > 0)
        //    GrdVw.HeaderRow.TableSection = TableRowSection.TableHeader;

    }

    protected void GrdVw_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //CouponProver Reg = new CouponProver();
        //lblBankId.Text = e.CommandArgument.ToString();
        //Reg.Gift_ID = lblBankId.Text; newMsg.Visible = false;
        //Reg.DML = "S";
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //CouponProver.GiftFillDataGrid(Reg);
        //if (e.CommandName.ToString() == "EditRow")
        //{
        //    txtName.Text = Reg.GiftName;
        //    lblAddCourierHeader.Text = "Gift update Details";
        //    btnSubmit.Text = "Update";
        //    //ModalPopupExtenderNewDesign.Show();
        //}
        //else if (e.CommandName.ToString() == "DeleteRow")
        //{
        //    dhnactiontype.Value = "D";
        //    LabelAlertheader.Text = "Alert";
        //    LabelAlertText.Text = "Are you sure to dalete  <span style='color:blue;' >" + Reg.GiftName + "</span>  Gift permanently?";
        //    ModalPopupExtenderAlert.Show();
        //}
        //else if (e.CommandName.ToString() == "ActivateRow")
        //{
        //    dhnactiontype.Value = "A";
        //    LabelAlertheader.Text = "Alert";
        //    LabelAlertText.Text = "Are you sure to <span style='color:blue;' > " + FindStatus(Reg.IsActive) + " </span> <span style='color:blue;' >" + Reg.GiftName + "</span>  Gift permanently?";
        //    ModalPopupExtenderAlert.Show();
        //}
    }

    private void Cleartxt()
    {
        txtbankname.Text = string.Empty;
        //lblpopmsg.Text = string.Empty;
        txtAccHolderNm.Text = string.Empty;
        txtAccountNo.Text = string.Empty;
        txtBranch.Text = string.Empty;
        txtifscCode.Text = string.Empty;
        //txtCity.Text = string.Empty;
        //txtrtgsCode.Text = string.Empty;
        //txtaddress.Text = string.Empty;
        //rdcurrent.Checked = true;
        //rdsaving.Checked = false;
        // FillAccount();
        // ShowAsSavingClear();
        // btnSubmit.Text = "Save";
    }
    protected void btnSubmit_Click1(object sender, EventArgs e)
    {
        //DivNewMsg.Visible = true;
        //DivNewMsg.Attributes.Add("class", "msg_red big_msg");
        //lblpopmsg.Text = "    Please Enter Valid IFSC Code !";
        HttpPostedFile filePostedpass = Request.Files["Passbookfile"];
        if (Passbookfile.Enabled == true && Passbookfile == null)
        {
            passbookkvalidator.IsValid = false;
        }
        else
        {
            passbookkvalidator.IsValid = true;
        }
        if (txtCnfAccountNo.Text != "")
        {
            RequiredFieldValidator11.IsValid = true;
        }
        else
        {
            RequiredFieldValidator11.IsValid = false;
        }
        if (Page.IsValid)
        {
            if (DivNewMsg.Visible != true)
            {

                Object9420 Reg = new Object9420();

                //////////////////////////////////////////////////////

                string fileName = Path.GetFileName(Passbookfile.PostedFile.FileName);
                string flName = Path.GetFileNameWithoutExtension(fileName);
                string flExtn = Path.GetExtension(fileName);
                if (flExtn.ToLower() == ".jpg" || flExtn.ToLower() == ".jpeg" || flExtn.ToLower() == ".png")
                {
                    // Guid guid = Guid.NewGuid();
                    string lPath = "/img/BankDocuments/";
                    string path = Server.MapPath(lPath);
                    DataProvider.Utility.CreateDirectory(path);
                    string fullFName = path + Session["USRID"].ToString() + flExtn;

                    filePostedpass.SaveAs(fullFName);
                    Reg.chkpassbook = lPath + Session["USRID"].ToString() + flExtn;


                    //Imgbank.Attributes.Add("class", "img-documents");
                    //Imgbank.ImageUrl = "../img/BankDocuments/" + Session["USRID"].ToString() + flExtn;
                    //Imgbank.DataBind();

                    //_Consumerid = SQL_DB.ExecuteScalar("select [m_consumerid]  from [m_consumer] where [User_id]='" + Session["USRID"].ToString() + "'").ToString();

                }
                else
                {
                    HtmlControl control = FindControl("upload_document") as HtmlControl;
                    control.Attributes["class"] = "tab-pane active";
                    control = FindControl("personal") as HtmlControl;
                    control.Attributes["class"] = "tab-pane";
                    control = FindControl("profile_nav") as HtmlControl;
                    control.Attributes["class"] = "nav-link";
                    control = FindControl("upload_nav") as HtmlControl;
                    control.Attributes["class"] = "nav-link active";
                    NewMsgpopupld.Visible = true;

                    NewMsgpopupld.Attributes["class"] = "alert alert-danger";
                    NewMsgpopupld.InnerHtml = "<strong>Warning</Strong>    Please Upload a File in jpg/jpeg/png Format.";

                }




                /////////////////////////////////////////////////////////
                Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd"));

                //Reg.Bank_Name = Request.Form["txtbankname"].ToString().Trim().Replace("'", "''");
                //Reg.Account_HolderNm = Request.Form["txtAccHolderNm"].ToString().Trim().Replace("'", "''");
                //Reg.Account_No = Request.Form["txtAccountNo"].ToString().Trim().Replace("'", "''");  //;//Business9420.function9420.GetTrans_No();
                //Reg.Branch = Request.Form["txtBranch"].ToString().Trim().Replace("'", "''");
                //Reg.IFSC_Code = Request.Form["txtifscCode"].ToString().Trim().Replace("'", "''");

                Reg.Bank_Name = txtbankname.Text;
                Reg.Account_HolderNm = txtAccHolderNm.Text.Trim().Replace("'", "''");
                // Reg.Account_No = txtAccountNo.Text.Trim().Replace("'", "''");
                Reg.Account_No = txtCnfAccountNo.Text.Trim().Replace("'", "''");     //;//Business9420.function9420.GetTrans_No();
                Reg.Branch = txtBranch.Text.Trim().Replace("'", "''");
                Reg.IFSC_Code = txtBranch.Text.ToString().Trim().Replace("'", "''");

                //Reg.City = txtCity.Text.Trim().Replace("'", "''");
                Reg.RTGS_Code = null; //txtrtgsCode.Text.Trim().Replace("'", "''");
                Reg.M_ConsumerID = ProjectSession.intM_ConsumeriD;

                Reg.Account_Type = DropDownList1.SelectedItem.Text;

                Reg.Flag = 1;
                if (btnSubmit.Text == "Save")
                {
                    Reg.DML = "I";
                    function9420.BankInfo(Reg);

                    //DivNewMsg.Visible = true;
                    //DivNewMsg.Attributes.Add("class", "msg_green big_msg");
                    //lblpopmsg.Text = "Bank Account <span style='color:blue;' >" + Reg.Bank_Name + "</span> is related information registered successfully !";
                    //fillGridDemo();
                    btnSubmit.Text = "Update";
                    //lblAddAccountHeader.Text = "Add New Bank Account";
                    //ModalPopupExtenderNewDesign.Show();
                    string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                    // Response.Redirect(Request.RawUrl);
                    DivNewMsg.Visible = true;
                    DivNewMsg.Attributes["class"] = "alert alert-success";
                    DivNewMsg.InnerHtml = "Bank Account " + Reg.Bank_Name + " related information registered successfully !";

                    string bnkid = (string)SQL_DB.ExecuteScalar("SELECT top 1 case when [Bank_ID]=null then ' ' else [Bank_ID] end as Bank_ID FROM [M_BankAccount] where [M_Consumerid] = '" + _Consumerid + "' order by [Entry_Date] desc");

                    if (bnkid != null)
                    {
                        Bnkid = bnkid;
                        EditMode();
                        editbtn2.Attributes.Add("style", "Display: none ! Important;");
                        HtmlControl control = FindControl("Account_form") as HtmlControl;
                        control.Attributes["class"] = "account_form";
                        //control = FindControl("editbtn2") as HtmlControl;
                        //control.Attributes["class"] = "profile-overlap-edit";
                    }
                }
                else if (btnSubmit.Text == "Update")
                {
                    Reg.Bank_ID = Bnkid;  //lblBankId.Text;
                    Reg.DML = "U";
                    function9420.BankInfo(Reg);
                    DivNewMsg.Visible = true;
                    DivNewMsg.Attributes["class"] = "alert alert-success";
                    //DivNewMsg.Attributes.Add("class", "msg_green big_msg");
                    DivNewMsg.InnerHtml = "Bank Account <span style='color:blue;' >" + Reg.Bank_Name + "</span> is related information Updated successfully !";
                    // lblmsgHeader.Text = "Bank Account <span style='color:blue;' >" + Reg.Bank_Name + "</span> is related information are updated !";
                    // fillGridDemo();
                    btnSubmit.Text = "Update";
                    // lblAddAccountHeader.Text = "Add New Bank Account";
                    string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                    editbtn2.Attributes.Add("style", "Display: none ! important;");
                }
                //DivNewMsg.Visible = false;
                //string script11 = "window.onload = function(){  CheckBankMsg();return false;}";
                ////  Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                //ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script11, true);

                //Response.Redirect("FrmBankAccount.aspx?msg=success");

                //string url;
                //url = "FrmBankAccount.aspx";

                //string winFeatures = "toolbar=no,status=no,menubar=no,location=center,scrollbars=yes,resizable=no,height=650,width=825";
                //ClientScript.RegisterStartupScript(this.GetType(), "newWindow", string.Format("<script type='text/javascript'>var popup=window.open('{0}', 'Bank details added successfully.', '{1}'); popup.focus();</script>", url, winFeatures));
                ////string winFeatures = "toolbar=no,status=no,menubar=no,location=center,scrollbars=yes,resizable=no,height=650,width=825";
                //ClientScript.RegisterStartupScript(this.GetType(), "newWindow", string.Format("<script type='text/javascript'>var popup=window.open('Bank details added successfully'); popup.focus();</script>", winFeatures));

                //Cleartxt();
                //FillAccount();

            }
        }
        //protected void btnReset_Click1(object sender, EventArgs e)
        //{
        //    Response.Redirect("FrmBankAccount.aspx");
        //}
    }
    private string FindStatus(int p)
    {
        if (p == 0)
            return "De-Activate";
        else
            return "Activate";
    }
    private string FindStatusNew(int p)
    {
        if (p == 0)
            return "Activated";
        else
            return "De-Activated";
    }
    protected void btnNo_Click(object sender, EventArgs e)
    {

    }

    protected void Logout(object sender, EventArgs e)
    {
        Session.Abandon();
        //Response.Redirect("../Home/Index.aspx");
        string val = Session["AppID"].ToString();
        if (val == "2")
        {
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "AppLogin.aspx?AppID=2");
        }

        else if (Session["Comp_id"].ToString() == "Comp-1388")
        {
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "AppLogin.aspx");
        }

        else
        {
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "login.aspx");
        }


    }

    protected void txtifscCode_TextChanged(object sender, EventArgs e)
    {
        if (txtifscCode.Text != "")
        {
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT * FROM [IFSC] WHERE [IFSC]  = '" + txtifscCode.Text.ToString() + "'");
            if (ds.Tables[0].Rows.Count > 0)
            {
                txtbankname.Text = ds.Tables[0].Rows[0]["Bank"].ToString();
                txtBranch.Text = ds.Tables[0].Rows[0]["Branch"].ToString();
                //txtCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
                //txtaddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                DivNewMsg.Visible = false;
                txtbankname.Enabled = false;
                txtBranch.Enabled = false;
                //lblpopmsg.Text = "";
                btnSubmit.Enabled = true;
                lblIfsc_error.Visible = false;
                Passbookfile.Enabled = true;

            }
            else
            {
                lblIfsc_error.Visible = true;
                //DivNewMsg.Visible = true;
                //DivNewMsg.Attributes.Add("class", "alert alert-danger");
                //DivNewMsg.InnerHtml = "<strong>Warning <strong>   Enter a valid IFSC Code !";
                //lblpopmsg.Text = "    Please Enter Valid IFSC Code !";
                btnSubmit.Enabled = false;
                txtbankname.Enabled = true;
                txtBranch.Enabled = true;
                Passbookfile.Enabled = false;
                txtbankname.Text = "";
                txtBranch.Text = "";
                //txtCity.Text = "";
                //txtaddress.Text = "";
            }
            HtmlControl control = FindControl("Account_form") as HtmlControl;
            control.Attributes["class"] = "account_form account_form-edit";

            accountname.Text = "Account Holder Name*";


            ifsc.Text = "IFSC code*";
            accountno.Text = "Account number*";
            confirmaccount.Text = "Confirm Account number*";

            accounttype.Text = "Account Type*";








        }
    }









    protected void updateDealer_Click(object sender, EventArgs e)
    {

        if (employeeid.Text.Replace("'", "''") != "" && distributorid.Text.Replace("'", "''") != "")//aadharnumber.Text != "" && 
        {
            DataTable dsCheckDealer = SQL_DB.ExecuteDataTable("Select * from M_DealerMaster where replace(ltrim(replace(DealerTechnicianId,'0',' ')),' ','0') ='" + employeeid.Text.Replace("'", "''").TrimStart(new Char[] { '0' }) + "' and replace(ltrim(replace(DealerCode,'0',' ')),' ','0')='" + distributorid.Text.Replace("'", "''").TrimStart(new Char[] { '0' }) + "'");
            if (dsCheckDealer.Rows.Count > 0)
            {
                User_Details Log = new User_Details();
                Log.MMEmployeID = employeeid.Text;
                Log.MMDistributorID = distributorid.Text;

                if (aadharnumber.Text != "")
                    Log.AadhaarNumber = aadharnumber.Text.Trim().Replace("'", "''");

                string aadhr = aadharnumber.Text;
                Log.User_ID = Session["USRID"].ToString();
                Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
                Log.ConsumerName = txtPersonName.Text.Trim().Replace("'", "''");
                Log.Email = txtEmail.Text.Trim().Replace("'", "''");
                Log.MobileNo = txtMob.Text.Trim().Replace("'", "''");
                Log.City = ddlCity.Text.Trim().Replace("'", "''");
                Log.PinCode = txtpincode.Text.Trim().Replace("'", "''");

                //Log.Password = txtpincode.Text.Trim().Replace("'", "''");


                //////////////////////////////

                /////////////////////////

                Log.IsActive = 0;
                Log.IsDelete = 0;
                Log.Address = Request.Form["txtAddress"].ToString().Trim().Replace("'", "''");
                Log.DML = "U";

                User_Details.InsertUpdateUserDetails(Log);
                allClear();
                FillUpDateProfile();
                dvdealermsg.Visible = true;
                dvdealermsg.InnerHtml = "Technician ID and Dealer Code updated Successfully!";

                //lbldealerinfomation.Visible = true;
                //lbldealerinfomation.Attributes.Add("class", "msg_green");
                //lbldealerinfomation.Text = "Technician ID and Dealer Code updated Successfully!";
                FillUpDateProfile();
            }
            else
            {
                dvdealermsg.Visible = true;
                dvdealermsg.Attributes["class"] = "alert alert-danger";
                dvdealermsg.InnerHtml = "<strong>Warning!</Strong> Technician ID or Dealer Code are not correct!";

                //lbldealerinfomation.Visible = true;
                //lbldealerinfomation.Attributes.Add("class", "msg_red");
                //lbldealerinfomation.Text = "Technician ID or Dealer Code are not correct!";
            }
        }
        else
        {
            dvdealermsg.Visible = true;
            dvdealermsg.Attributes["class"] = "alert alert-danger";
            dvdealermsg.InnerHtml = "<strong>Warning!</Strong> Technician ID or Dealer Code can not be blank";

            //lbldealerinfomation.Visible = true;
            //lbldealerinfomation.Attributes.Add("class", "msg_red");
            //lbldealerinfomation.Text = "Technician ID or Dealer Code can not be blank";
        }
    }

    protected void Close1_Click(object sender, EventArgs e)
    {
        FillUpDateProfile();
        profile_form.Attributes["class"] = "profile_form profile_form-edit";

        fullName.Text = "Full Name*";
        Address.Text = "Address*";
        City.Text = "City*";
        Pincode.Text = "Pin code*";
        Aadharno.Text = "Aadhar Number*";
    }

    protected void cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.RawUrl);
    }




}