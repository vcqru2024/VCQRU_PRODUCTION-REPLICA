using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO; 
using Business9420;
using System.Configuration;
using System.Web.Mail;
using System.Net.Mail;

public partial class FrmGeneratedInvoice : System.Web.UI.Page
{
    public string server = Convert.ToString(ConfigurationManager.ConnectionStrings["ServerName"].ConnectionString), userID = Convert.ToString(ConfigurationManager.ConnectionStrings["UserName"].ConnectionString), password = Convert.ToString(ConfigurationManager.ConnectionStrings["Password"].ConnectionString);
    public Int32 InvNo = 0; public int index = 0;
    //public string filePt = Server.MapPath("../Data/Bill") + "\\" + System.DateTime.Now.ToString("dd-MM-yyyy") + "\\";
    protected void Page_Load(object sender, EventArgs e)
    {       
        if (Session["User_Type"] == null)
            Response.Redirect("../Info/Login.aspx?Page=FrmGeneratedInvoice.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            string strtype = "";
            if(Request.QueryString["ID"] != null)
                 strtype = Request.QueryString["ID"].ToString();
            FillProduct();
          //  FillCompany();
            FillDateCurrent();
            FillGridData();
        }
    }
    private void FillProduct()
    {
        Object9420 Reg = new Object9420();
        if (Session["CompanyId"] != null)
        {
            Reg.Comp_ID = Session["CompanyId"].ToString();            
            DataSet ds = function9420.FetchProduct(Reg);
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlproname, "--Product--");
            ddlproname.SelectedIndex = 0;
        }
        else
        {
            ddlproname.Items.Insert(0, "--Product--");
            ddlproname.SelectedIndex = 0;
        }
    }
    protected void ImgGrdVwRefresh_Click(object sender, ImageClickEventArgs e)
    {
        FillCompany();
        FillDateCurrent();
        FillGridData();
    }
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> GetCountries(string prefixText)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Comp_Name] FROM [Comp_Reg] where [Comp_Name] like '" + prefixText + "%'");

        List<string> CountryNames = new List<string>();
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            CountryNames.Add(ds.Tables[0].Rows[i][0].ToString());
        }
        return CountryNames;
    }

    private void FillDateCurrent()
    {
        txtDateFrom.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy").ToString();
        txtDateTo.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy").ToString();
    }    
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillGridData();
    }
    private void FillGridData()
    {
        Object9420 Reg = new Object9420();                
        if (ddlcompname.SelectedIndex > 0)
            Reg.Comp_ID = ddlcompname.SelectedValue;
        else
            Reg.Comp_ID = "";
        if (Session["CompanyId"] != null)
            Reg.Comp_ID = Session["CompanyId"].ToString();
        if (ddlproname.SelectedIndex > 0)
            Reg.Pro_ID = ddlproname.SelectedValue;
        else
            Reg.Pro_ID = "";
        string StrAll = " WHERE  (''='" + Reg.Comp_ID + "' OR M_Invoice.Comp_ID = '" + Reg.Comp_ID + "') AND (''='" + Reg.Pro_ID + "' OR M_Invoice.Pro_ID='" + Reg.Pro_ID + "')  AND M_Invoice.Invoice_ID LIKE '%" + txtinvoice.Text.Trim().Replace("'", "''") + "%' ";//(SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID=mg.Comp_ID)  LIKE '%" + txtCompanyName.Text.Trim().Replace("'", "''") + "%'
        if (txtDateFrom.Text != "" && txtDateTo.Text == "")
        {            
            StrAll += " AND  CONVERT(VARCHAR,M_Invoice.Invoice_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
        }
        else if (txtDateTo.Text == "" && txtDateTo.Text != "")
        {            
            StrAll += " AND  CONVERT(VARCHAR,M_Invoice.Invoice_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        }
        else if (txtDateTo.Text != "" && txtDateTo.Text != "")
        {            
            StrAll += " AND  CONVERT(VARCHAR,M_Invoice.Invoice_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,M_Invoice.Invoice_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        }
        if (Request.QueryString["ID"] != null)
            StrAll += " AND M_Invoice.Head_Name = '" + Request.QueryString["ID"].ToString() + "' ";
        //DataSet ds = Business9420.function9420.FindFillGridGeneratedBills(StrAll);
        DataSet ds = Business9420.function9420.FindFillGrdVwInvoicess(StrAll);
        //if (ds.Tables[0].Rows.Count > 0)
        //{
        //if (Convert.ToInt32(ddlRowsShow.SelectedValue) > 1000)
        //{
        //    if (ds.Tables[0].Rows.Count > 0)
        //        GrdCodeAllote.PageSize = ds.Tables[0].Rows.Count;
        //}
        //else
        //    GrdCodeAllote.PageSize = Convert.ToInt32(ddlRowsShow.SelectedValue.Trim());
            GrdCodeAllote.DataSource = ds.Tables[0];
            GrdCodeAllote.DataBind();
            if(GrdCodeAllote.Rows.Count > 0)
              FillFooterData(GrdCodeAllote, ds);
            lblcount.Text = ds.Tables[0].Rows.Count.ToString();
        if (GrdCodeAllote.Rows.Count > 0)
            GrdCodeAllote.HeaderRow.TableSection = TableRowSection.TableHeader;

        //for (int i = 0; i < GrdCodeAllote.Rows.Count; i++)
        //{
        //    Label compid = (Label)GrdCodeAllote.Rows[i].FindControl("lblAllotDateNew23");
        //    GridView Grd = (GridView)GrdCodeAllote.Rows[i].FindControl("GrdProductWiseCodeAllote");
        //    Object9420 obj = new Object9420();
        //    obj.Invoice_No = compid.Text;
        //    DataSet dsProd = function9420.FetchInvoiceNoWiseDetails(obj);
        //    if (dsProd.Tables[0].Rows.Count > 0)
        //        Grd.DataSource = dsProd.Tables[0];
        //    Grd.DataBind();
        //}
        //}
        //else
        //{
        //    GrdCodeAllote.DataSource = ds.Tables[0];
        //    GrdCodeAllote.DataBind();
        //    lblcount.Text = "0";            
        //}
    }
    private void FillFooterData(GridView GrdVw, DataSet ds)
    {
        if (GrdVw.Rows.Count > 0)
        {
            Label lblTpurchaseAmt0 = (Label)GrdVw.FooterRow.FindControl("P1");
            Label lblTpurchaseAmt = (Label)GrdVw.FooterRow.FindControl("P2");
            Label lblVATTax = (Label)GrdVw.FooterRow.FindControl("P22");
            Label lblTpaidcAmt = (Label)GrdVw.FooterRow.FindControl("P3");
            Label lblAdvanceAmt = (Label)GrdVw.FooterRow.FindControl("P4");
            Label lblOutstantAmt = (Label)GrdVw.FooterRow.FindControl("P5");
            lblTpurchaseAmt0.Text = ds.Tables[0].Compute("SUM(G_Amount)", "").ToString();
            lblTpurchaseAmt.Text = ds.Tables[0].Compute("SUM(Service_Tax)", "").ToString();
            lblTpaidcAmt.Text = ds.Tables[0].Compute("SUM(N_Amount)", "").ToString();
            lblAdvanceAmt.Text = ds.Tables[0].Compute("SUM(Balance)", "").ToString();
            lblOutstantAmt.Text = ds.Tables[0].Compute("SUM(Net_Pay)", "").ToString();
            lblVATTax.Text = ds.Tables[0].Compute("SUM(VAT)", "").ToString();
        }
    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        FillGridData();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtClear(); FillDateCurrent();
        FillGridData();
    }
    private void txtClear()
    {
        txtCompanyName.Text = "";
        txtDateFrom.Text = "";
        txtDateTo.Text = "";
        txtinvoice.Text = ""; 
    }
    private void FillCompany()
    {
        DataSet ds = function9420.FillActiveComp();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", ddlcompname, "--Company--");
        ddlcompname.SelectedIndex = 0;
        ddlproname.Items.Clear();
        ddlproname.Items.Insert(0, "--Product--");
        ddlproname.SelectedIndex = 0;
    }
    protected void ddlcompname_SelectedIndexChanged(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        if (ddlcompname.SelectedIndex > 0)
        {
            Reg.Comp_ID = ddlcompname.SelectedValue;
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT DISTINCT Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, Pro_Reg.Comp_ID FROM M_Code FULL OUTER JOIN  Pro_Reg ON M_Code.Pro_ID = Pro_Reg.Pro_ID WHERE (M_Code.Print_Status = 1)  AND (Pro_Reg.Comp_ID = '" + ddlcompname.SelectedValue.Trim().ToString() + "')");
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlproname, "--Product--");
            ddlproname.SelectedIndex = 0;
        }
        else
        {
            ddlproname.Items.Insert(0, "--Product--");
            ddlproname.SelectedIndex = 0;
        }
    }   
    protected void GrdCodeAllote_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdCodeAllote.PageIndex = e.NewPageIndex;
        FillGridData();
    }

    protected void GrdCodeAllote_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //if (e.CommandName == "SendMail")
        //{
        //    string pt = Server.MapPath("../Data/Bill") + "\\" + DataProvider.LocalDateTime.Now.ToString("dd-MM-yyyy") + "\\" + e.CommandArgument.ToString() + ".pdf";
        //    if(File.Exists(pt))
        //        AttSendMail(server, userID, password, "register@label9420.com", "Label9420 Bill", "Label9420 Bill Report", pt);

        //}       
        if (e.CommandName == "SendMail")
        {
            string[] str = e.CommandArgument.ToString().Split('*');
            if (str.Length > 0)
            {
                //http://localhost:52666//Admin/Bill/Invoice/07-07-2017/INVL17-1325.pdf
                string pt = Server.MapPath("~/") + "Admin/Bill/Invoice/" + str[1].ToString() + "/" + str[0].ToString() + ".pdf";
                //string pt = Server.MapPath("../Data/Bill") + "\\" + DataProvider.LocalDateTime.Now.ToString("dd-MM-yyyy") + "\\" + e.CommandArgument.ToString() + ".pdf";
                if (File.Exists(pt))
                {
                    AttSendMail(server, userID, password, str[2], "VCQRU.com Bill", "VCQRU.com Bill Report", pt, str[0].ToString());

                    lblmsgHeader.Text = "Mail sent successfully";
                    newMsg.Visible = true;
                    newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                                       
                    string script1 = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
                }

            }

        }
    }

    private void AttSendMail(string server, string userID, string password, string sendTo, string body, string subject, string txtfilepth, string InvoiceNo)
    {
        try
        {


            body = DataProvider.Utility.FindMailBody() + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                        //" <div class='w_logo'><img src='http://vcqru.com/images/logo.png' alt='logo' /></div>" +
                        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
                        " <hr style='border:1px solid #2587D5;'/>" +
                        " <div class='w_frame'>" +
                        " <p>" +
                        " <div class='w_detail'>" +
                        " <span>Dear <em><strong>" + sendTo + ",</strong></em></span><br />" +
                        " <br />" +
                        " <br />" +
                        " <span>Generated bill for Invoice No - " + InvoiceNo + " </span><br />" +
                        " <p>" +
                        " <div class='w_detail'>" +
                        " Thank you,<br /><br />" +
                        " Team <em><strong>VCQRU.com,</strong></em><br />" +
                        "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                        " </div>" +
                        " </p>" +
                        " </div>" +
                        " </p>" +
                        " </div> " +
                        " </div> ";

            DataSet dsMl = function9420.FetchMailDetail("register");
            DataProvider.Utility.sendMailAttach(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), sendTo, body, subject, txtfilepth);


        }
        catch (Exception)
        {

            throw;
        }
        //using (System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage())
        //    try
        //    {
        //        System.Net.Mail.SmtpClient sc = new System.Net.Mail.SmtpClient();
        //        mail.To.Add(sendTo);
        //        mail.Subject = subject;
        //        mail.Body = body;
        //        mail.IsBodyHtml = true;
        //        if (txtfilepth != "")
        //            mail.Attachments.Add(new Attachment(txtfilepth));
        //        mail.From = new System.Net.Mail.MailAddress(userID);
        //        sc.Host = server;
        //        sc.Port = 25;
        //        sc.UseDefaultCredentials = false;
        //        sc.Credentials = new System.Net.NetworkCredential(userID, password);
        //        sc.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
        //        sc.Send(mail);
        //    }
        //    catch (Exception ex)
        //    {
        //        Response.Write(ex.Message);
        //    }
    }
    
}