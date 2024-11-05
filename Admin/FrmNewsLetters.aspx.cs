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
using Business_Logic_Layer;
using Business9420;
using System.Security.Cryptography;
using System.Text;
using System.IO;

public partial class FrmNewsLetters : System.Web.UI.Page
{
    public string srt = DataProvider.Utility.FindMailBody();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmNewsLetters.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {
            FillCurrentDate();
            FillddlNewsLetter();
            FillGrdVw();
        }
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillGrdVw();
    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        FillGrdVw();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtsearchemail.Text = string.Empty; FillCurrentDate();
        FillGrdVw();
    }
    private void FillGrdVw()
    {
        DataSet ds = new DataSet();
        Object9420 Reg = new Object9420();
        Reg.Email = txtsearchemail.Text.Trim().Replace("'", "''");
        string StrAll = "";
        string DateFrom = DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd");   // "1900/01/01"; 
        string DateTo = DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd");
        if (txtDateFrom.Text != "" && txtDateTo.Text == "")
        {
            DateFrom = Convert.ToDateTime(txtDateFrom.Text).ToString();
            StrAll += " AND  CONVERT(VARCHAR,c.Entry_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
        }
        else if (txtDateTo.Text == "" && txtDateTo.Text != "")
        {
            DateFrom = Convert.ToDateTime(txtDateFrom.Text).ToString();
            DateTo = Convert.ToDateTime(txtDateTo.Text).ToString();
            StrAll += " AND  CONVERT(VARCHAR,c.Entry_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        }
        else if (txtDateTo.Text != "" && txtDateTo.Text != "")
        {
            DateFrom = Convert.ToDateTime(txtDateFrom.Text).ToString();
            DateTo = Convert.ToDateTime(txtDateTo.Text).ToString();
            StrAll += " AND  CONVERT(VARCHAR,c.Entry_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,c.Entry_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        }
        ds = function9420.FillGrdVwNewsLetterDet(Reg ,StrAll);
        GridView1.DataSource = ds.Tables[0];
        GridView1.DataBind();
        lblcount.Text = GridView1.Rows.Count.ToString();
    }
    private void FillCurrentDate()
    {
        txtDateFrom.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy").ToString();
        txtDateTo.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy").ToString();
    }
    private void FillddlNewsLetter()
    {
        Object9420 Reg = new Object9420();
        Reg.NewsLetterID = "";
        DataSet ds = function9420.GetNewsLetters(Reg);
        DataRow dr = ds.Tables[0].NewRow();
        dr["NewsLettersID"] = "New";
        dr["SubjectNm"] = "New";
        dr["Subject"] = "";
        dr["Content"] = "";
        dr["Entry_Date"] = Convert.ToDateTime(DataProvider.LocalDateTime.Now);
        dr["Status"] = 1;
        ds.Tables[0].Rows.InsertAt(dr, 0);
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "NewsLettersID", "SubjectNm", ddlNewsLetter, "--Select News Letters--");
        ddlNewsLetter.SelectedIndex = 0;
    }    
    protected void btnsave_Click(object sender, EventArgs e)
    {
        Object9420 obj = new Object9420();
        obj.NewsLetterID = function9420.GetPartnerId("NewsLetter");
        obj.NewsContent = Editor1.Content.Trim().Replace("''", "'").Replace("'", "''");
        obj.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        obj.NewsSubject = Editor2.Content.Trim().Replace("''", "'").Replace("'", "''");
        function9420.SaveNewsLetters(obj);
        function9420.setPartnerId("NewsLetter");
        obj.Email = "";        
        DataSet ds = function9420.GetNewsLettersEmails(obj);
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                obj.Email = ds.Tables[0].Rows[i]["Email"].ToString();
                obj.Row_ID = ds.Tables[0].Rows[i]["Row_ID"].ToString();
                string EncData = string.Format("Row_ID={0}", obj.Row_ID);
                EncData = Encrypt(EncData.ToString());
                string link = "" + ProjectSession.absoluteSiteBrowseUrl + "/FrmUnsubscribe.aspx?key=" + EncData;
                #region Mail Structure
                string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
                " <hr style='border:1px solid #2587D5;'/>" +
                " <div class='w_frame'>" +
                " <p>" +
                " <div class='w_detail'>" +
                " <span>Dear <em><strong>,</strong></em></span><br />" +
                " <br />" +               
                " <strong> " +obj.NewsSubject + "</strong><br />" +
                " " + obj.NewsContent + "   <br />" +
                " To stop receiving the news alerts mails from us,<a href='" + link + "'><strong>unsubscribe</strong>.</a>" +
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
                DataSet dsMl = function9420.FetchMailDetail("news");
                if (dsMl.Tables[0].Rows.Count > 0)
                {
                    SQL_DB.ExecuteNonQuery("INSERT INTO [NewsLetters_Subscription_Details]([NewsLettersID],[Email],[Entry_Date])  VALUES ('"+ obj.NewsLetterID +"','"+ obj.Email +"','"+ Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") +"')");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Email, MailBody, ProjectSession.GetWebsiteName + " News Letters");
                }
            }            
        }
        divmsg.Visible = true;
        divmsg.Attributes.Add("class", "alert_boxes_green big_msg");
        lblmsg.Text = "News Letter send Successfully...";
        string script = @"setTimeout(function(){document.getElementById('" + divmsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);      
        Editor1.Content = string.Empty;
        Editor2.Content = string.Empty;
        ddlNewsLetter.SelectedIndex = 0;        
    }
    protected void btncancel_Click(object sender, EventArgs e)
    {
        divmsg.Visible = false;
        Editor1.Content = string.Empty;
        Editor2.Content = string.Empty;
        ddlNewsLetter.SelectedIndex = 0;
        btnsave.Text = "Save";
        lblmsg.Text = string.Empty;
    }
    public static string Encrypt(string TextToBeEncrypted)
    {
        RijndaelManaged RijndaelCipher = new RijndaelManaged();
        string Password = "CSC";
        byte[] PlainText = System.Text.Encoding.Unicode.GetBytes(TextToBeEncrypted);
        byte[] Salt = Encoding.ASCII.GetBytes(Password.Length.ToString());
        PasswordDeriveBytes SecretKey = new PasswordDeriveBytes(Password, Salt);
        ICryptoTransform Encryptor = RijndaelCipher.CreateEncryptor(SecretKey.GetBytes(32), SecretKey.GetBytes(16));
        MemoryStream memoryStream = new MemoryStream();
        CryptoStream cryptoStream = new CryptoStream(memoryStream, Encryptor, CryptoStreamMode.Write);
        cryptoStream.Write(PlainText, 0, PlainText.Length);
        cryptoStream.FlushFinalBlock();
        byte[] CipherBytes = memoryStream.ToArray();
        memoryStream.Close();
        cryptoStream.Close();
        string EncryptedData = Convert.ToBase64String(CipherBytes);
        return EncryptedData;
    }
    protected void ddlNewsLetter_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlNewsLetter.SelectedIndex > 0)
        {
            if (ddlNewsLetter.SelectedValue != "New")
            {
                Object9420 Reg = new Object9420();
                Reg.NewsLetterID = ddlNewsLetter.SelectedValue;
                DataSet ds = function9420.GetNewsLetters(Reg);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Editor1.Content = ds.Tables[0].Rows[0]["Content"].ToString();
                    Editor2.Content = ds.Tables[0].Rows[0]["Subject"].ToString();
                }
                else
                {
                    Editor1.Content = string.Empty;
                    Editor2.Content = string.Empty;
                }
            }
            else
            {
                Editor1.Content = string.Empty;
                Editor2.Content = string.Empty;
            }
        }
        else
        {
            Editor1.Content = string.Empty;
            Editor2.Content = string.Empty;
        }
    }
}
