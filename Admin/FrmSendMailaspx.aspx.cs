using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Data.OleDb;
using System.Net.Mail;
using Business9420;

public partial class FrmSendMailaspx : System.Web.UI.Page
{
    public OleDbConnection oledbCon = new OleDbConnection();
    public OleDbCommand oledbCmd = new OleDbCommand();
    public int sr = 0;
    public string str1 = "none", str2 = "none", str3 = "none", str4 = "none";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmSendMailaspx.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        } 
        Session["Form_Name"] = "Email";
        if (!IsPostBack)
        {
            FillDDL();
            FillGrid();
            Editor2.Content = GetContentForEditor();
        }
    }

    public  string GetContentForEditor()
    {
        string str123 = "<p>Hi $name$ ,</p>" +
" <p style='font-family:'Calibri','sans-serif;font-size:12;'>This is Parvinder Singh from <a href=" + ProjectSession.absoluteSiteBrowseUrl + "' target='_blank' " +
            ">VCQRU</a>, We are a product base IT company we provide 10 very useful services, to helpbusiness to grow. Once you use our service the replica of your product willstop, sales will increase, the customer loyalty will increase too.</p>" +
" <p>According to the report of European Union IntellectualProperty Office(EUIPO) and &nbsp;The Federation of Indian Chambers of Commerce andIndustry(FICCI), piracy in consumer products has coasted companies loss of€338 billion in 2017 and is expected to increase by 32% this year.We are hereto secure you from this problem.&nbsp;&nbsp;</p> " +
" <p><br />" +
" </p>" +
"<p><b><u>Over Services</u></b>:-<span style ='font-size: 10pt'> &nbsp;</span></p>" +
"<p></p>" +
"<p><span style='font-family:arial,sans-serif'>v<span>&nbsp; </span></span>Counterfeit:Your Shield against Fakes.</p>" +
"<p><span style='font-family:arial,sans-serif'>v<span style='font-variant-numeric: normal; font-variant-east-asian: normal;font-stretch: normal; font-size: 7pt; line-height: normal; font-family: times new roman;' > &nbsp; </span></span>SecureTrack &amp; Trace Solution: you can track your product from manufacturing UNIT toC&amp;F to distributor to retailer to end customer.</p>" +
"<p><span style='font-family:arial,sans-serif'>v<span style='font-variant-numeric: normal; font-variant-east-asian: normal;font-stretch: normal; font-size: 7pt; line-height: normal; font-family: times new roman;'> &nbsp; </span></span>CustomiseSolutions: We can customise the software based on business need.</p>" +
"<p><span style='font-family:arial,sans-serif'>v<span style='font-variant-numeric: normal; font-variant-east-asian: normal;font-stretch: normal; font-size: 7pt; line-height: normal; font-family: times new roman;'>&nbsp; </span></span>BuildLoyalty: Points based loyalty system.</p>" +
"<p><span style='font-family:arial,sans-serif'>v<span style='font-variant-numeric: normal; font-variant-east-asian: normal;font-stretch: normal; font-size: 7pt; line-height: normal; font-family: times new roman;'> &nbsp; </span></span>GiftCoupons:&nbsp;Loyalty scheme offer to customers, Like, Movie Ticket, DiscountCoupon etc.</p>" +
"<p><span style='font-family:arial,sans-serif'>v<span style='font-variant-numeric: normal; font-variant-east-asian: normal;font-stretch: normal; font-size: 7pt; line-height: normal; font-family: times new roman;'>&nbsp; </span></span>CashTransfer:&nbsp;A loyalty scheme offer to customers, in this program you canoffer a cash back to customer in their wallets.</p>" +
"<p><span style='font-family:arial,sans-serif'>v<span style='font-variant-numeric: normal; font-variant-east-asian: normal;font-stretch: normal; font-size: 7pt; line-height: normal; font-family: times new roman;'> &nbsp; </span></span>RaffleScheme:&nbsp;A loyalty scheme offer to customers, Through Lucky Draw, offer agood gift etc.</p>" +
"<p><span style='font-family:arial,sans-serif'>v<span style='font-variant-numeric: normal; font-variant-east-asian: normal;font-stretch: normal; font-size: 7pt; line-height: normal; font-family: times new roman;'>&nbsp; </span></span>Referral:&nbsp;Loyaltyscheme offer to customers, this is very popular segment, in this program yourcustomer base will increase, word of mouth publicity, etc.</p>" +
"<p><span style='font-family:arial,sans-serif'>v<span style='font-variant-numeric: normal; font-variant-east-asian: normal;font-size: 7pt; line-height: normal; font-family: times new roman;'>&nbsp; </span></span>RunSurveys:&nbsp;This will help to campiness to take the feedback directly fromcustomers. </p>" +
"<p><span style='font-family:arial,sans-serif'>v<span style='font-variant-numeric: normal; font-variant-east-asian: normal;font-stretch: normal; font-size: 7pt; line-height: normal; font-family: times new roman;'>&nbsp; </span></span>BigData Analytics:&nbsp;This program you can analysis of the data, Buying Pattern,Behaviour, Duration, etc.of a customer.</p>" +
"<p>&nbsp;</p>" +
"<p>Note:- For more information of the product please allow meto have a one on one meeting with the decision maker.Our expert will come atyour place to give you the full knowledge of the product. </p>" +
"<p>&nbsp;</p>" +
"<p><div style='width:100%;height:700px;'><div style='float:left'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/image003.png' alt='Screen Shot 2018-07-12 at 9.59.42 AM.png' tabindex='0' width='508' height='722' border='0' /></div>" +
"<div style='float:left'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/image005.png' alt='Screen Shot 2018-07-12 at 9.59.42 AM.png' tabindex='0' width='508' height='722' border='0' /></div></div></p>" +

"<p><br/></p>" +
"<p style='font:size:17px'><span> Regards </span><br/>" +
"<span> Rakesh Kumar</span><br/>" +
"<span> CEO - Chief Executive Officer</span><br/>" +
"<span>M: +91-9717115556, T:&nbsp; +91 124 4001928</span></p>" +

"<p><img src ='" + ProjectSession.absoluteSiteBrowseUrl + "/images/LogoMail.png' width='160' height='103' border='0'/></p>" +

"<p style='font:size:17px'><span><a href='http://www.vcqru.com/' target='_blank'><span style='color:#0563c1'>www.vcqru.com </ span ></ a >, <a href='mailto:rakesh@vcqru.com' target='_blank'><span style='color:#0563c1'>rakesh@vcqru.com</span></a></span><br/>" +
"<span>219 A, 2<sup>nd</sup> Floor, Unitech Arcadia,</span><br/>" +
"<span>South City II, Sec 49, Gurgaon-122018</span><br/>" +
"<p></p>" +
"<p>&nbsp;</p>";
        return str123;
    }
    private void FillDDL()
    {
        ddlFrom.Items.Clear();
        //SQL_DB.fillDropDown("SELECT [tbl_id],[Email_Name] FROM [Mail_Credentials] order by Email_Name", "tbl_id", "Email_Name", ddlFrom);
        SQL_DB.fillDropDown("SELECT [Row_id],[Mail_Type] FROM [Mail_Details] order by Mail_Type ", "Row_id", "Mail_Type", ddlFrom);
        ddlFrom.Items.Insert(0, "--Select--");
    }
    private void Clear()
    {
        txtCC.Text = "";
        txtSubject.Text = "";
        txtUserEmail.Text = "";
        Editor2.Content = "";
        ddlFrom.SelectedIndex = 0;
        ddlToWhome.SelectedIndex = 0;
        lblchmsg.Text = "";
        lblAllEmail3.Text = "";
    }

    protected void imgBtnSentMail_Click(object sender, ImageClickEventArgs e)
    {
        FillDDL();
        Clear();
        Editor2.Content = GetContentForEditor();
        txtCC.Text = "Rakesh@vcqru.com";
        ModalPopupExtenderPrint.Show();
    }
    protected void ImageButton3_Click(object sender, EventArgs e)
    {
        Clear();
        ModalPopupExtenderPrint.Show();
    }
    protected void ImageButton2_Click(object sender, EventArgs e)
    {
       // DataTable DtSMTP = new DataTable();
       // SQL_DB.GetDA("SELECT [SMTP],[User_Id],[Password],[Email_Name] FROM [Mail_Credentials] where [tbl_id]=" + ddlFrom.SelectedValue.ToString() + "").Fill(DtSMTP);
        DataSet dsMl = function9420.FetchMailDetail(ddlFrom.SelectedItem.Text);
        //DataProvider.Utility.sendMailAttach();

        if (ddlToWhome.SelectedValue.ToString() == "1" || ddlToWhome.SelectedValue.ToString() == "3")
        {
            if (txtUserEmail.Text == "" && ddlToWhome.SelectedValue.ToString() != "3")
            {
                lblchmsg.Text = "Email is Empty...";
                str1 = "";
                str2 = "none";
                str3 = "none";
                str4 = "none";
                ModalPopupExtenderPrint.Show();
                return;
            }
            else
            {
                string Mail_Id = GetNewCode("Mail");
                string MSG = Editor2.Content;
                MSG = MSG.Replace("&lt;&lt;date&gt;&gt;", DateTime.Now.ToString("dd MMM yyyy"));
                string strfilepath = "";
                if (FileAttachment.HasFile)
                {
                    string path = Server.MapPath("../Data/Sound");
                    path += "\\Upload_File\\Email";
                    if (!Directory.Exists(path))
                    {
                        Directory.CreateDirectory(path);
                    }
                    string FileName = path + "\\" + FileAttachment.FileName;
                    path = path + "\\" + FileAttachment.FileName;
                    strfilepath = path;
                    FileAttachment.SaveAs(path);
                    SQL_DB.ExecuteNonQuery("INSERT INTO [Mail_Master]([Mail_id],[Entry_Date],[Mail_From],[Mail_CC],[Mail_Subject],[Mail_Message],[Mail_Attachment]) VALUES ('" + Mail_Id + "','" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "','" + dsMl.Tables[0].Rows[0]["User_Id"].ToString() + "','" + txtCC.Text.Trim().Replace("'", "''") + "','" + txtSubject.Text.Trim().Replace("'", "''") + "',N'" + MSG.Trim().Replace("'", "''") + "','" + FileName + "')");
                }
                else
                    SQL_DB.ExecuteNonQuery("INSERT INTO [Mail_Master]([Mail_id],[Entry_Date],[Mail_From],[Mail_CC],[Mail_Subject],[Mail_Message]) VALUES"+
                        "('" + Mail_Id + "','" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "','" + dsMl.Tables[0].Rows[0]["User_Id"].ToString() + "','" + txtCC.Text.Trim().Replace("'", "''") + "','" + txtSubject.Text.Trim().Replace("'", "''") + "',N'" + MSG.Trim().Replace("'", "''") + "')");
                if (lblAllEmail3.Text != "" && txtUserEmail.Text == "")
                    txtUserEmail.Text = lblAllEmail3.Text.Replace(" ", ",");
                string[] MailCounter = txtUserEmail.Text.Trim().Split(',');
                for (int i = 0; i < MailCounter.Length; i++)
                {
                    if (lblPopupHeading.Text == "Client List")
                    {
                        lblEmpClEMPName.Text = Convert.ToString(SQL_DB.ExecuteScalar("Select [Client_Name] FROM M_Client  where Client_Email='" + MailCounter[i].ToString() + "'"));
                        MSG = MSG.Replace("&lt;&lt;name&gt;&gt;", lblEmpClEMPName.Text);
                    }
                    else if (lblPopupHeading.Text == "Employee List")
                    {
                        lblEmpClEMPName.Text = Convert.ToString(SQL_DB.ExecuteScalar("Select [Emp_Name] FROM Employee_Master  where Emp_Email_I='" + MailCounter[i].ToString() + "'"));
                        MSG = MSG.Replace("&lt;&lt;name&gt;&gt;", lblEmpClEMPName.Text);
                    }
                    SQL_DB.ExecuteNonQuery("INSERT INTO [Mail_SendDetail] ([Mail_id],[Mail_To]) VALUES ('" + Mail_Id + "' ,'" + MailCounter[i].ToString() + "')");
                   // dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), , sendTo, body, subject, txtfilepth
                    sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(),
                        dsMl.Tables[0].Rows[0]["Mail_Type"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
                        MailCounter[i].ToString(), MSG.Trim().Replace("'", "''").Replace("$name$"," "), txtSubject.Text, txtCC.Text.Trim(), strfilepath);
                }
                SetNewCode("Mail");

            }
        }
        if (ddlToWhome.SelectedValue.ToString() == "2")
        {
            if (FileExcel.HasFile)
            {
                if ((Path.GetExtension(FileExcel.FileName).ToLower() != ".xls") && (Path.GetExtension(FileExcel.FileName).ToLower() != ".xlsx"))
                {
                    lblchmsg.Text = "Please Select Valid Excel File...";
                    str1 = "none";
                    str2 = "";
                    str3 = "none";
                    str4 = "none";
                    ModalPopupExtenderPrint.Show();
                    return;
                }
                else
                {
                    string ext = Path.GetExtension(FileExcel.FileName).ToLower();
                    if (FileExcel.HasFile)
                    {
                        string FilePath = Server.MapPath("../Data/Sound");
                        FilePath += "\\Upload_File\\Data";                        
                        string FileName = "Data" + ext;
                        FilePath = FilePath + "//" + FileName;
                        FileExcel.SaveAs(FilePath);
                    }
                    string DbPath = Server.MapPath("../Data/Sound") + "\\Upload_File\\Data\\" + "Data" + ext;
                    if (ext == ".xlsx")
                        oledbCon.ConnectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + DbPath + ";Extended Properties=Excel 12.0;";
                    if (ext == ".xls")
                        oledbCon.ConnectionString = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DbPath + ";Extended Properties=Excel 8.0;";                    
                    oledbCmd.Connection = oledbCon;

                    oledbCon.Open();
                    oledbCmd.CommandText = "Select Name,Email from [Sheet1$]";
                    oledbCmd.ExecuteNonQuery();
                    OleDbDataAdapter oledbAdp = new OleDbDataAdapter(oledbCmd);
                    DataTable dt = new DataTable();                    
                    oledbAdp.Fill(dt);

                    DataView dv = new DataView();
                    dv = dt.DefaultView;
                    dv.RowFilter = "Email <> ''";
                    dt = dv.ToTable();

                    string MSG = "";
                    string Mail_Id = GetNewCode("Mail");
                    string strfilepath = "";
                    if (FileAttachment.HasFile)
                    {
                        string path = Server.MapPath("../Data/Sound");
                        path += "\\Upload_File\\Email";
                        if (!Directory.Exists(path))
                        {
                            Directory.CreateDirectory(path);
                        }
                        string FileName = path +"\\"+ FileAttachment.FileName;
                        path = path + "\\" + FileAttachment.FileName;
                        strfilepath = path;
                        FileAttachment.SaveAs(path);
                        SQL_DB.ExecuteNonQuery("INSERT INTO [Mail_Master]([Mail_id],[Entry_Date],[Mail_From],[Mail_CC],[Mail_Subject],[Mail_Message],[Mail_Attachment]) VALUES ('" + Mail_Id + "','" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "','" + dsMl.Tables[0].Rows[0]["User_Id"].ToString() + "','" + txtCC.Text.Trim().Replace("'", "''") + "','" + txtSubject.Text.Trim().Replace("'", "''") + "',N'" + Editor2.Content.Trim().Replace("'", "''") + "','" + FileName + "')");
                    }
                    else
                        SQL_DB.ExecuteNonQuery("INSERT INTO [Mail_Master]([Mail_id],[Entry_Date],[Mail_From],[Mail_CC],[Mail_Subject],[Mail_Message]) VALUES ('" + Mail_Id + "','" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "','" + dsMl.Tables[0].Rows[0]["User_Id"].ToString() + "','" + txtCC.Text.Trim().Replace("'", "''") + "','" + txtSubject.Text.Trim().Replace("'", "''") + "',N'" + Editor2.Content.Trim().Replace("'", "''") + "')");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        MSG = Editor2.Content;
                         MSG = MSG.Replace("$name$", dt.Rows[i]["Name"].ToString());
                        //MSG = MSG.Replace("&lt;&lt;name&gt;&gt;", dt.Rows[i]["Name"].ToString());
                        MSG = MSG.Replace("&lt;&lt;date&gt;&gt;", DateTime.Now.ToString("dd MMM yyyy"));
                        SQL_DB.ExecuteNonQuery("INSERT INTO [Mail_SendDetail] ([Mail_id],[Mail_To]) VALUES ('" + Mail_Id + "' ,'" + dt.Rows[i]["Email"].ToString() + "')");
                        sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["Mail_Type"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), dt.Rows[i]["Email"].ToString(), MSG, txtSubject.Text.Trim(), txtCC.Text.Trim(), strfilepath);
                    }
                    SetNewCode("Mail");
                }
            }
            else
            {
                lblchmsg.Text = "Please Select Excel File...";
                str1 = "none";
                str2 = "";
                str3 = "none";
                str4 = "none";
                ModalPopupExtenderPrint.Show();
                return;
            }

        }
        Clear();
        FillGrid();
    }

    private void FillGrid()
    {
        DataTable DtGrd = new DataTable();
        string St1 = "";
        if (txtdtFrom.Text != "")
            St1 += " and convert(varchar,Entry_Date,111)>='" + Convert.ToDateTime(txtdtFrom.Text).ToString("yyyy/MM/dd") + "'";
        if(txtdtto.Text!="")
            St1 += " and convert(varchar,Entry_Date,111)<='" + Convert.ToDateTime(txtdtto.Text).ToString("yyyy/MM/dd") + "'";
        SQL_DB.GetDA("SELECT [Mail_id],[Entry_Date],[Mail_From],[Mail_CC],[Mail_Subject],[Mail_Message],[Mail_Attachment],(Select count(tbl_id) From Mail_SendDetail where  Mail_id=[Mail_Master].Mail_id) as MailCount FROM [Mail_Master] where Del_Flg=0 " + St1 + " ORDER BY  Entry_Date DESC ").Fill(DtGrd);
        lblCount.Text = DtGrd.Rows.Count.ToString();
        GrdEmailDetail.DataSource = DtGrd;
        GrdEmailDetail.DataBind();
    }

    protected void BtnSearchDemo_Click(object sender, ImageClickEventArgs e)
    {
        FillGrid();
    }
    protected void BtnSearchDemoRefesh_Click(object sender, ImageClickEventArgs e)
    {
        txtdtFrom.Text = "";
        txtdtto.Text = "";
        FillGrid();
    }
    protected void GrdEmailDetail_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        lblid.Text = e.CommandArgument.ToString();
        if (e.CommandName.ToString() == "MailTo")
        {
            lblReciepientID1.Text = Convert.ToString(SQL_DB.ExecuteScalar("SELECT [dbo].[GetRecipient] ('" + lblid.Text + "')"));
            ModalPopupExtender1.Show();
        }
        else if (e.CommandName.ToString() == "ShowMessage")
        {
            lblMailMessage1.Text = Convert.ToString(SQL_DB.ExecuteScalar("SELECT (case when [Mail_Attachment] is null then [Mail_Message] else Mail_Message +'<br/><img src=images/attach.png height=15 width=15/>&nbsp;<a href='+ Mail_Attachment+' target=_blank>'+(REVERSE(SUBSTRING(REVERSE(Mail_Attachment),0,CHARINDEX('/',REVERSE(Mail_Attachment)))))+'</a>' end) as Mail_Message FROM [Mail_Master] where Mail_id='" + lblid.Text + "'"));
            ModalPopupExtender2.Show();
        }
        else if (e.CommandName.ToString() == "DeleteRow")
        {
            SQL_DB.ExecuteNonQuery("Update Mail_Master Set Del_Flg=1 where Mail_id='" + lblid.Text + "'");
            FillGrid();
        }
        else if (e.CommandName.ToString() == "ResendMail")
        {
            DataTable DtEmail = new DataTable();
            // SQL_DB.GetDA("SELECT [Mail_id],[Mail_From],[Mail_CC],(Select tbl_id from Mail_Credentials where User_Id=[Mail_Master].[Mail_From]) as Mail_Tbl_id,[Mail_Subject],[Mail_Message],[Mail_Attachment],[dbo].[GetRecipient] ([Mail_Master].[Mail_id]) as SendTo FROM [Mail_Master] where Mail_id='" + lblid.Text + "'").Fill(DtEmail);
            SQL_DB.GetDA("SELECT [Mail_id],[Mail_From],[Mail_CC],(Select Row_Id from Mail_Details where User_Id=[Mail_Master].[Mail_From]) as Mail_Tbl_id,[Mail_Subject],[Mail_Message],[Mail_Attachment],[dbo].[GetRecipient] ([Mail_Master].[Mail_id]) as SendTo FROM [Mail_Master] where Mail_id='" + lblid.Text + "'").Fill(DtEmail);
            if (DtEmail.Rows.Count > 0)
            {
                ddlFrom.SelectedValue = DtEmail.Rows[0]["Mail_Tbl_id"].ToString();
                str1 = "";
                str2 = "none";
                str3 = "none";
                str4 = "none";
                txtUserEmail.Text = DtEmail.Rows[0]["SendTo"].ToString();
                ddlToWhome.SelectedValue = "1";
                txtCC.Text = DtEmail.Rows[0]["Mail_CC"].ToString();
                txtSubject.Text = DtEmail.Rows[0]["Mail_Subject"].ToString();
                Editor2.Content = DtEmail.Rows[0]["Mail_Message"].ToString();
                Editor2.Content = Editor2.Content.Replace("$name$", " ");
                ModalPopupExtenderPrint.Show();
            }

        }
    }

    private void sendMail(string server, string userID, string username, string password, string sendTo, string body, string subject, string CCMail, string File)
    {
        try
        {
            using (System.Net.Mail.MailMessage mess = new System.Net.Mail.MailMessage())
            {
                System.Net.Mail.SmtpClient sc = new System.Net.Mail.SmtpClient();
                mess.To.Add(sendTo);
                if (CCMail != "")
                    mess.CC.Add(CCMail);
                if (File != "")
                    mess.Attachments.Add(new Attachment(File));
                //if (File.HasFile)
                //{
                //    Attachment attachment = new Attachment(Path.GetFullPath(File.PostedFile.FileName));
                //    mess.Attachments.Add(attachment);
                //}
                mess.Subject = subject;
                mess.Body = body;
                mess.IsBodyHtml = true;
                mess.From = new System.Net.Mail.MailAddress(userID, "VCQRU");//username
                // mess.From.DisplayName = new System.Net.Mail. .MailAddress(userID); username.ToString();
                //sc.Host = server;
                //sc.Port = 25;
                //sc.UseDefaultCredentials = false;
                //sc.Credentials = new System.Net.NetworkCredential(userID, password);
                //sc.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                //sc.Send(mess);

               // SmtpClient sc = new SmtpClient();
                sc.Host = server;
                //sc.EnableSsl = true;
                sc.UseDefaultCredentials = false;
                sc.Credentials = new System.Net.NetworkCredential(userID, password);
               // sc.Port = 587;
                sc.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                sc.Send(mess);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    private void sendMail(string server, string userID, string username, string password, string sendTo, string body, string subject, string CCMail, FileUpload File)
    {
        try
        {
            using (System.Net.Mail.MailMessage mess = new System.Net.Mail.MailMessage())
            {
                System.Net.Mail.SmtpClient sc = new System.Net.Mail.SmtpClient();
                mess.To.Add(sendTo);
                if (CCMail != "")
                    mess.CC.Add(CCMail);
                if (File.HasFile)
                {
                    Attachment attachment = new Attachment(Path.GetFullPath(File.PostedFile.FileName));
                    mess.Attachments.Add(attachment);
                }
                mess.Subject = subject;
                mess.Body = body;
                mess.IsBodyHtml = true;
                mess.From = new System.Net.Mail.MailAddress(userID, username);
                // mess.From.DisplayName = new System.Net.Mail. .MailAddress(userID); username.ToString();
                sc.Host = server;
                sc.Port = 25;
                sc.UseDefaultCredentials = false;
                sc.Credentials = new System.Net.NetworkCredential(userID, password);
                sc.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                sc.Send(mess);
            }
        }
        catch (Exception)
        {

        }
    }
    protected void lnkEmployee_Click(object sender, EventArgs e)
    {
        lblPopupHeading.Text = "Employee List";
        str1 = "none";
        str2 = "none";
        str3 = "";
        str4 = "none";
        FillPopUpGrid();
        ModalPopupExtenderPrint.Show();
        ModalPopupExtender3.Show();
    }
    protected void lnkClient_Click(object sender, EventArgs e)
    {
        lblPopupHeading.Text = "Company List";
        str1 = "none";
        str2 = "none";
        str3 = "";
        str4 = "none";
        FillPopUpGrid();
        ModalPopupExtenderPrint.Show();
        ModalPopupExtender3.Show();
    }
    protected void imgBtnPopupContinue_Click(object sender, EventArgs e)
    {
        if (Request.Form["chkEMpsel"] != null)
        {
            lblEmpClEmail.Text = Request.Form["chkEMpsel"].ToString();
            str1 = "none";
            str2 = "none";
            str3 = "";
            str4 = "";
        }
        else
        {
            lblEmpClEmail.Text = string.Empty;
            str1 = "none";
            str2 = "none";
            str3 = "";
            str4 = "none";
        }
        lblAllEmail3.Text = lblEmpClEmail.Text.Replace(",", " ");

        ModalPopupExtenderPrint.Show();
    }
    private void FillPopUpGrid()
    {
        DataTable DtClient = new DataTable();
        if (lblPopupHeading.Text == "Company List")
        {
            SQL_DB.GetDA("SELECT [Comp_ID] as Code,[Comp_Name] as Name,[Comp_Email] as Email,[Comp_Type] FROM [Comp_Reg] where [Status]=1").Fill(DtClient);
            
        }
        else if (lblPopupHeading.Text == "Employee List")
        {
            //SQL_DB.GetDA("SELECT [Emp_Code] as Code,[Emp_Name] as Name,[Emp_Email_I] as Email FROM [Employee_Master] where [Del_Flg]=0 and Emp_Name like '%" + txtSearchEmpClName.Text.Trim() + "%'").Fill(DtClient);
        }
        GrdPopEmailSSend.DataSource = DtClient;
        GrdPopEmailSSend.DataBind();
    }
    protected void ImgBtnPopEmpClSear_Click(object sender, ImageClickEventArgs e)
    {
        FillPopUpGrid();
        str1 = "none";
        str2 = "none";
        str3 = "";
        str4 = "none";
        ModalPopupExtenderPrint.Show();
        ModalPopupExtender3.Show();
    }
    private string GetNewCode(string KeyCol)
    {

        return Convert.ToString(SQL_DB.ExecuteScalar("SELECT [PrPrefix]+convert(varchar,[PrStart])  FROM [Code_Gen] where [Prfor]='" + KeyCol + "'"));
    }

    private void SetNewCode(string KeyCol)
    {
        SQL_DB.ExecuteNonQuery("UPDATE [Code_Gen] SET [PrStart] = [PrStart]+1 where [Prfor]='" + KeyCol + "'");
    }
}
