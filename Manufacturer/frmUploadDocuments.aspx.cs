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
using System.Text;
using System.IO;

public partial class frmUploadDocuments : System.Web.UI.Page
{
    public string srt = DataProvider.Utility.FindMailBody();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/default.aspx?Page=frmUploadDocuments.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!Page.IsPostBack)
        {
            if (Session["Comp_type"].ToString() == "D")
               Response.Redirect("Message.aspx");        
            NewMsgpop.Visible = false;
            FillDataDoc();
            
        }
    }

    private bool ChkFile(string p)
    {
        string path = Server.MapPath("../Data/Sound");
        path = path + "\\" + p.ToString().Substring(5, 4);
        DataProvider.Utility.CreateDirectory(path);
        path = path + "\\" + p.ToString().Substring(5, 4) + ".wav";
        if (File.Exists(path))
            return true;
        else
            return false;
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

    
    private void FillDataDoc()
    {
        Object9420 Log = new Business9420.Object9420();
        Log.Comp_ID = Session["CompanyId"].ToString();
        function9420.FindFile(Log);
        
        string path = Server.MapPath("../Data/Sound");
        path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "\\Doc";
        string ppath = "../Data\\Sound\\" + Log.Comp_ID.ToString().Substring(5, 4) + "\\Doc";
        DataProvider.Utility.CreateDirectory(path);
        string path1 = path + "\\" + Log.Comp_Addressproof;
        string pathd = Server.MapPath("../Data/Sound");
        pathd = pathd + "\\" + Log.Comp_ID.ToString().Substring(5, 4);
        DataProvider.Utility.CreateDirectory(pathd);
        pathd = pathd + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + ".wav";


        if (!string.IsNullOrEmpty(Log.Comp_Info))
        {
            FillGray(Log, "");
            FillCompanyData(Log, ppath);
            btnEdit.Visible = true;
            btnUploadDoc.Visible = false;
            btnUploadDoc.Style.Add("display", "none");
            FillVerificationStatus();
        }
        else
        {
            ClearForm();
            LabelAlertheader.Text = string.Empty;
            LabelAlertText.Text = string.Empty;
            ModalPopupExtenderAlert.Hide();
            btnEdit.Visible = false;
            btnUploadDoc.Visible = true;
            btnUploadDoc.Enabled = true;
            btnUploadDoc.Style.Add("display", "");
            btnUploadDoc.Text = "Upload Document";
            btnUploadDoc.Attributes.Add("class", "btn btn-primary float-right mb-5");
        }

        if (File.Exists(path1) && (function9420.FindVerifyFile(Log)))
        {
            FillGray(Log, ppath);
            NewMsgpop.Visible = true;
            NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
            LblMsgUpdate.Text = "Document already uploaded and verify!";
            string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            btnUploadDoc.Visible = true;
            btnUploadDoc.Enabled = false;
            btnUploadDoc.Visible = false;
            
            FillVerificationStatus();
        }
        //else if (File.Exists(path1) && (!function9420.FindVerifyFile(Log)))
       // {
            //FillEdit(Log, ppath);
            //NewMsgpop.Visible = true;
            //NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
            //LblMsgUpdate.Text = "Document already uploaded.";
            //string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            //btnUploadDoc.Visible = true;
            //btnUploadDoc.Enabled = true;
            //btnUploadDoc.Text = "Update Document";
            //btnUploadDoc.Attributes.Add("class", "");            
        //}
        //else
        //{
        //    ClearForm();
        //    LabelAlertheader.Text = string.Empty;
        //    LabelAlertText.Text = string.Empty;
        //    ModalPopupExtenderAlert.Hide();
        //    btnUploadDoc.Enabled = true;
        //    btnUploadDoc.Text = "Upload Document";
        //    btnUploadDoc.Attributes.Add("class", "button_all");
        //}
        //FillVerificationStatus();
    }
    private void ClearForm()
    {
        txtcompinfo.Text = string.Empty;
        txtpantanno.Text = string.Empty;
        txtvat.Text = string.Empty;
        HyperLink0.HRef = string.Empty;
        HyperLink1.HRef = string.Empty;
        HyperLink2.HRef = string.Empty;
        txtcompinfo.Enabled = true;
        txtpantanno.Enabled = true;
        txtvat.Enabled = true;
        HyperLink0.Visible = false;
        HyperLink1.Visible = false;
        HyperLink2.Visible = false;
        FileUploadaddpfrrof.Enabled = true;
        FileUploadowner.Enabled = true;
        FileUploadsignature.Enabled = true;
        RequiredFieldValidatorupl10.ValidationGroup = "UPLOADchkup";
        RequiredFieldValidatorupl9.ValidationGroup = "UPLOADchkup";
        RequiredFieldValidatorupl8.ValidationGroup = "UPLOADchkup";
    }

    private void FillCompanyData(Object9420 Log, string ppath)
    {
      


        txtcompinfo.Text = Log.Comp_Info;
        txtpantanno.Text = Log.PAN_TAN;
        txtvat.Text = Log.VAT;
        if (!string.IsNullOrEmpty(ppath))
        {
            HyperLink0.HRef = ppath + "\\" + Log.Comp_Addressproof;
            HyperLink1.HRef = ppath + "\\" + Log.Owner_proof;
            HyperLink2.HRef = ppath + "\\" + Log.Signature;
        }
        HiddenField0.Value = Log.Comp_Addressproof;
        HiddenField1.Value = Log.Owner_proof;
        HiddenField2.Value = Log.Signature;
        // if (HiddenField0.Value.Length > 0) { RequiredFieldValidatorupl10.ValidationGroup = "NN"; }

        RequiredFieldValidatorupl10.ValidationGroup = "NN";
        RequiredFieldValidatorupl9.ValidationGroup = "NN";
        RequiredFieldValidatorupl8.ValidationGroup = "NN";
    }
    private void FillGray(Object9420 Log, string ppath)
    {
        txtcompinfo.Enabled = false;
        txtpantanno.Enabled = false;
        txtvat.Enabled = false;
        HyperLink0.Visible = true;
        HyperLink1.Visible = true;
        HyperLink2.Visible = true;
        FileUploadaddpfrrof.Enabled = false;
        FileUploadowner.Enabled = false;
        FileUploadsignature.Enabled = false;
        //txtcompinfo.Text = Log.Comp_Info;
        //txtpantanno.Text = Log.PAN_TAN;
        //txtvat.Text = Log.VAT;
        //if (!string.IsNullOrEmpty(ppath))
        //{
        //    HyperLink0.HRef = ppath + "\\" + Log.Comp_Addressproof;
        //    HyperLink1.HRef = ppath + "\\" + Log.Owner_proof;
        //    HyperLink2.HRef = ppath + "\\" + Log.Signature;
        //}
        //HyperLink0.HRef = ppath + "\\" + Log.Comp_Addressproof;
        //HyperLink1.HRef = ppath + "\\" + Log.Owner_proof;
        //HyperLink2.HRef = ppath + "\\" + Log.Signature;
        //HiddenField0.Value = Log.Comp_Addressproof;
        //HiddenField1.Value = Log.Owner_proof;
        //HiddenField2.Value = Log.Signature;
       // RequiredFieldValidatorupl10.ValidationGroup = "NN";
       // RequiredFieldValidatorupl9.ValidationGroup = "NN";
       // RequiredFieldValidatorupl8.ValidationGroup = "NN";
    }
    private void FillEdit(Object9420 Log, string ppath)
    {
        //txtcompinfo.Enabled = true;
        //txtpantanno.Enabled = true;
        //txtvat.Enabled = true;
        HyperLink0.Visible = true;
        HyperLink1.Visible = true;
        HyperLink2.Visible = true;
        //FileUploadaddpfrrof.Enabled = true;
        //FileUploadowner.Enabled = true;
        //FileUploadsignature.Enabled = true;
        txtcompinfo.Text = Log.Comp_Info;
        txtpantanno.Text = Log.PAN_TAN;
        txtvat.Text = Log.VAT;
        HyperLink0.HRef = ppath + "\\" + Log.Comp_Addressproof;
        HyperLink1.HRef = ppath + "\\" + Log.Owner_proof;
        HyperLink2.HRef = ppath + "\\" + Log.Signature;
        HiddenField0.Value = Log.Comp_Addressproof;
        HiddenField1.Value = Log.Owner_proof;
        HiddenField2.Value = Log.Signature;
        RequiredFieldValidatorupl10.ValidationGroup = "NN";
        RequiredFieldValidatorupl9.ValidationGroup = "NN";
        RequiredFieldValidatorupl8.ValidationGroup = "NN";
    }
    private void FillLabelStatus(Image lbl,int Flag,string Remarks,string DocStatus)
    {
        if (Flag == 1)
        {
            lbl.ImageUrl = "../Content/images/generated_bill.png";
            lbl.ForeColor = System.Drawing.Color.Green;
        }
        else if (Flag == -1)
        {
            lbl.ImageUrl = "../Content/images/generated_billC.png";
            lbl.ForeColor = System.Drawing.Color.Red;
        }
        else if (Flag ==0)
        {
            lbl.ImageUrl = "../Content/images/warning.png";
            lbl.ForeColor = System.Drawing.Color.Black;
        }
        //lbl.AlternateText = Remarks;
        lbl.ToolTip = Remarks;
        
    }
    private void FillVerificationStatus()
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        DataSet ds = function9420.FindVerifyData(Reg);
        if (ds.Tables[0].Rows.Count > 0)
        {
            if (ds.Tables[0].Rows.Count == 1)
            {
                FillLabelStatus(lblremarkssoundinfo, Convert.ToInt32(ds.Tables[0].Rows[0]["Flag"]), ds.Tables[0].Rows[0]["Docstremarks"].ToString(), ds.Tables[0].Rows[0]["DocSt"].ToString());
            }
            if (ds.Tables[0].Rows.Count >= 6)
            {
                FillLabelStatus(lblremarksaddresproof, Convert.ToInt32(ds.Tables[0].Rows[0]["Flag"]), ds.Tables[0].Rows[0]["Docstremarks"].ToString(), ds.Tables[0].Rows[0]["DocSt"].ToString());
                FillLabelStatus(lblremarksinfo, Convert.ToInt32(ds.Tables[0].Rows[1]["Flag"]), ds.Tables[0].Rows[1]["Docstremarks"].ToString(), ds.Tables[0].Rows[1]["DocSt"].ToString());
                FillLabelStatus(lblremarksownerproof, Convert.ToInt32(ds.Tables[0].Rows[2]["Flag"]), ds.Tables[0].Rows[2]["Docstremarks"].ToString(), ds.Tables[0].Rows[2]["DocSt"].ToString());
                FillLabelStatus(lblremarkspantan, Convert.ToInt32(ds.Tables[0].Rows[3]["Flag"]), ds.Tables[0].Rows[3]["Docstremarks"].ToString(), ds.Tables[0].Rows[3]["DocSt"].ToString());
                if (ds.Tables[0].Rows.Count == 6)
                {
                    FillLabelStatus(lblremarkssignature, Convert.ToInt32(ds.Tables[0].Rows[4]["Flag"]), ds.Tables[0].Rows[4]["Docstremarks"].ToString(), ds.Tables[0].Rows[4]["DocSt"].ToString());
                    FillLabelStatus(lblremarksvatno, Convert.ToInt32(ds.Tables[0].Rows[5]["Flag"]), ds.Tables[0].Rows[5]["Docstremarks"].ToString(), ds.Tables[0].Rows[5]["DocSt"].ToString());
                }
                else if (ds.Tables[0].Rows.Count == 7)
                {
                    FillLabelStatus(lblremarkssignature, Convert.ToInt32(ds.Tables[0].Rows[4]["Flag"]), ds.Tables[0].Rows[4]["Docstremarks"].ToString(), ds.Tables[0].Rows[4]["DocSt"].ToString());
                    FillLabelStatus(lblremarksvatno, Convert.ToInt32(ds.Tables[0].Rows[6]["Flag"]), ds.Tables[0].Rows[6]["Docstremarks"].ToString(), ds.Tables[0].Rows[6]["DocSt"].ToString());
                    FillLabelStatus(lblremarkssoundinfo, Convert.ToInt32(ds.Tables[0].Rows[5]["Flag"]), ds.Tables[0].Rows[5]["Docstremarks"].ToString(), ds.Tables[0].Rows[5]["DocSt"].ToString());
                }
            }
        }
        else
        {
            lblremarksaddresproof.ImageUrl  = string.Empty;
            lblremarksinfo.ImageUrl = string.Empty;
            lblremarksownerproof.ImageUrl = string.Empty;
            lblremarkspantan.ImageUrl = string.Empty;
            lblremarkssignature.ImageUrl = string.Empty;
            lblremarksvatno.ImageUrl = string.Empty;
        }
    }
    protected void btnUploadDoc_Click(object sender, EventArgs e)
    {
        Object9420 Log = new Business9420.Object9420();
        Log.Comp_ID = Session["CompanyId"].ToString();
        Log.Comp_Info = txtcompinfo.Text.Trim().Replace("'", "''");
        Log.PAN_TAN = txtpantanno.Text.Trim().Replace("'", "''");
        Log.VAT = txtvat.Text.Trim().Replace("'", "''");

        //SQL_DB.ExecuteNonQuery("UPDATE [Comp_Reg] SET [Doc_Flag] = 1 WHERE [Comp_ID] = '" + Session["CompanyId"].ToString() + "'");
        string path =string.Empty;
        string ext = "";
        string pathename = Log.Comp_ID.ToString().Substring(5, 4);// + DateTime.Now.ToString("hhMMSS");// DateTime.Now.ToString("MMddyyyyhhmmss")

        if (FileUploadaddpfrrof.FileName.Length > 0)
        {
            path = Server.MapPath("../Data/Sound");
            path = path + "\\" + pathename + "\\Doc";
            DataProvider.Utility.CreateDirectory(path);
            ext = Path.GetExtension(FileUploadaddpfrrof.FileName);
            path = path + "\\" + pathename + "_Add" + ext;
            if (File.Exists(path)) File.Delete(path);
            FileUploadaddpfrrof.SaveAs(path);
            Log.Comp_Addressproof = pathename + "_Add" + ext;
        }
        else
        {
            Log.Comp_Addressproof = HiddenField0.Value;
        }

        if (FileUploadowner.FileName.Length > 0)
        {
           
           path = Server.MapPath("../Data/Sound");
            path = path + "\\" + pathename + "\\Doc";
            DataProvider.Utility.CreateDirectory(path);
            ext = Path.GetExtension(FileUploadowner.FileName);
            path = path + "\\" + pathename + "_Own" + ext;
            if (File.Exists(path)) File.Delete(path);
            FileUploadowner.SaveAs(path);
            Log.Owner_proof = pathename + "_Own" + ext;
        }
        else
        {
            Log.Owner_proof = HiddenField1.Value;
        }

        if (FileUploadsignature.FileName.Length > 0)
        {
           
           path = Server.MapPath("../Data/Sound");
            path = path + "\\" + pathename + "\\Doc";
            DataProvider.Utility.CreateDirectory(path);
            ext = Path.GetExtension(FileUploadsignature.FileName);
            path = path + "\\" + pathename + "_Sign" + ext;
            if (File.Exists(path)) File.Delete(path);
            FileUploadsignature.SaveAs(path);
            Log.Signature = Log.Comp_ID.ToString().Substring(5, 4) + "_Sign" + ext;
        }
        else
        {
            Log.Signature = HiddenField2.Value;
        }


        if (btnUploadDoc.Text == "Upload Document")
        {
            #region Insert
            //path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "\\Doc";
            //DataProvider.Utility.CreateDirectory(path);
            //ext = Path.GetExtension(FileUploadaddpfrrof.FileName);
            //path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "_Add" + ext;
            //FileUploadaddpfrrof.SaveAs(path);
            //Log.Comp_Addressproof = Log.Comp_ID.ToString().Substring(5, 4) + "_Add" + ext;
            //path = Server.MapPath("../Data/Sound");
            //path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "\\Doc";
            //DataProvider.Utility.CreateDirectory(path);
            //ext = Path.GetExtension(FileUploadowner.FileName);
            //path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "_Own" + ext;
            //FileUploadowner.SaveAs(path);
            //Log.Owner_proof = Log.Comp_ID.ToString().Substring(5, 4) + "_Own" + ext;
            //path = Server.MapPath("../Data/Sound");
            //path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "\\Doc";
            //DataProvider.Utility.CreateDirectory(path);
            //ext = Path.GetExtension(FileUploadsignature.FileName);
            //path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "_Sign" + ext;
            //FileUploadsignature.SaveAs(path);
            //Log.Signature = Log.Comp_ID.ToString().Substring(5, 4) + "_Sign" + ext;
            Log.DML = "I";
            btnUploadDoc.Text = "Update Document";
            function9420.UploadDocuments(Log);
            #region Mail Body
            function9420.FillUpDateProfile(Log);
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
            " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
            " <hr style='border:1px solid #2587D5;'/>" +
            " <div class='w_frame'>" +
            " <p>" +
            " <div class='w_detail'>" +
            " <span>Dear <em><strong>" + Log.Contact_Person + ",</strong></em></span><br />" +
            " <br />" +
            " <span>Thank you for choosing VCQRU.com</span>" +
            " <br />Documents are uploaded and please wait for the verification by the admin <br />" +
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
            string MailBody1 = DataProvider.Utility.FindMailBody(Session["Comp_Name"].ToString(), "Sales department", "documents has been uploaded successfully and pending for verification.");
            string MailBody2 = DataProvider.Utility.FindMailBody(Session["Comp_Name"].ToString(), "Lagal department", "documents has been uploaded successfully and pending for verification.");

            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Log.Comp_Email, MailBody, "Document verification");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Document verification pending");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Legal_accomplishtrades, MailBody2, "Document verification pending");
            }
            NewMsgpop.Visible = true;
            NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
            LblMsgUpdate.Text = "Document Uploaded Successfully. Please wait for verification by Admin.";
            string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            string path1 = Server.MapPath("../Data/Sound");
            path1 = path1 + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "\\Doc";
            string ppath = "Sound\\" + Log.Comp_ID.ToString().Substring(5, 4) + "\\Doc";
            FillEdit(Log, ppath);
            #endregion
        }
        else
        {
            #region Update
            Log.DML = "U";
            
            Object9420 Reg = new Business9420.Object9420();
            Reg.Comp_ID = Session["CompanyId"].ToString();
            function9420.FindFile(Reg);
            if (Reg.Comp_Info != Log.Comp_Info)
            {
                Log.Doc_Id = Log.Comp_ID.ToString().Substring(5, 4) + "_Info";
                Log.DocFlag = 0;
                function9420.UpdateDocForVerification(Log);
            }
            if (Reg.PAN_TAN != Log.PAN_TAN)
            {
                Log.Doc_Id = Log.Comp_ID.ToString().Substring(5, 4) + "_PANTAN";
                Log.DocFlag = 0;
                function9420.UpdateDocForVerification(Log);
            }
            if (Reg.VAT != Log.VAT)
            {
                Log.Doc_Id = Log.Comp_ID.ToString().Substring(5, 4) + "_VAT";
                Log.DocFlag = 0;
                function9420.UpdateDocForVerification(Log);
            }
            if (FileUploadaddpfrrof.FileName != "")
            {
                Log.Doc_Id = Log.Comp_ID.ToString().Substring(5, 4) + "_Add";
                //path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "\\Doc";
                //DataProvider.Utility.CreateDirectory(path);
                //ext = Path.GetExtension(FileUploadaddpfrrof.FileName);
                //path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "_Add" + ext;
                //FileUploadaddpfrrof.SaveAs(path);
                //Log.Comp_Addressproof = Log.Comp_ID.ToString().Substring(5, 4) + "_Add" + ext;

                ///Note :  Log.Comp_Addressproof value getting from above code
                
                Log.DocFlag = 0;
                function9420.UpdateDocForVerification(Log);
            }
            //else
            //    Log.Comp_Addressproof = HiddenField0.Value;

            if (FileUploadowner.FileName != "")
            {
                Log.Doc_Id = Log.Comp_ID.ToString().Substring(5, 4) + "_Own";
                //path = Server.MapPath("../Data/Sound");
                //path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "\\Doc";
                //DataProvider.Utility.CreateDirectory(path);
                //ext = Path.GetExtension(FileUploadowner.FileName);
                //path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "_Own" + ext;
                //FileUploadowner.SaveAs(path);
                //Log.Owner_proof = Log.Comp_ID.ToString().Substring(5, 4) + "_Own" + ext;
                Log.DocFlag = 0;
                function9420.UpdateDocForVerification(Log);
            }
            //else
            //    Log.Owner_proof = HiddenField1.Value;

            if (FileUploadsignature.FileName != "")
            {
                Log.Doc_Id = Log.Comp_ID.ToString().Substring(5, 4) + "_Sign";
                //path = Server.MapPath("../Data/Sound");
                //path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "\\Doc";
                //DataProvider.Utility.CreateDirectory(path);
                //ext = Path.GetExtension(FileUploadsignature.FileName);
                //path = path + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + "_Sign" + ext;
                //FileUploadsignature.SaveAs(path);
                //Log.Signature = Log.Comp_ID.ToString().Substring(5, 4) + "_Sign" + ext;
                Log.DocFlag = 0;
                function9420.UpdateDocForVerification(Log);
            }
            //else
            //    Log.Signature = HiddenField2.Value;

            //   Business9420.function9420.UploadDocuments(Log);

            function9420.UploadDocuments(Log);
            NewMsgpop.Visible = true;
            NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
            LblMsgUpdate.Text = "Document Updated Successfully. Please wait for verification by Admin.";
            string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
          
            #endregion

        }

        //string path = Server.MapPath("../Data/Sound");
        //path = path + "\\" + pathename + "\\Doc";
        //string ppath = "../Data\\Sound\\" + pathename + "\\Doc";
        //DataProvider.Utility.CreateDirectory(path);
        //string path1 = path + "\\" + Log.Comp_Addressproof;
        //string pathd = Server.MapPath("../Data/Sound");
        //pathd = pathd + "\\" + Log.Comp_ID.ToString().Substring(5, 4);
        //DataProvider.Utility.CreateDirectory(pathd);
        //pathd = pathd + "\\" + Log.Comp_ID.ToString().Substring(5, 4) + ".wav";

        FillGray(Log, "");
        btnEdit.Visible = true;
        btnUploadDoc.Visible = false;
        FillCompanyData(Log, "../Data\\Sound\\" + pathename + "\\Doc");
        FillVerificationStatus();
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        txtcompinfo.Enabled = true;
        txtpantanno.Enabled = true;
        txtvat.Enabled = true;
        HyperLink0.Visible = true;
        HyperLink1.Visible = true;
        HyperLink2.Visible = true;
        FileUploadaddpfrrof.Enabled = true;
        FileUploadowner.Enabled = true;
        FileUploadsignature.Enabled = true;

        // btnUploadDoc.Visible = true;

         NewMsgpop.Visible = false;
        //  NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
        //LblMsgUpdate.Text = "Document already uploaded.";
        //string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
      //  LblMsgUpdate.Text = "";
        btnEdit.Visible = false;
        btnUploadDoc.Visible = true;
        btnUploadDoc.Enabled = true;
        btnUploadDoc.Style.Add("display", "block");
       
        btnUploadDoc.Text = "Update Document";
        btnUploadDoc.Attributes.Add("class", "btn btn-primary float-right mb-0");

        FillVerificationStatus();
    }
}
