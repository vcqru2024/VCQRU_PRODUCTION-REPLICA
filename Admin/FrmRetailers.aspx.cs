using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Business9420;
using System.Configuration;
using System.Web.Services;
using System.Web.Script.Services;

public partial class Retailer_RetailerDetails : System.Web.UI.Page
{
    public string server = Convert.ToString(ConfigurationManager.ConnectionStrings["ServerName"].ConnectionString), userID = Convert.ToString(ConfigurationManager.ConnectionStrings["UserNameDemo"].ConnectionString), password = Convert.ToString(ConfigurationManager.ConnectionStrings["PasswordDemo"].ConnectionString);
    public string srt = DataProvider.Utility.FindMailBody();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=DemoCodeAllocation.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!Page.IsPostBack)
        {
            FillDateCurrent();
            fillData();
            NewMsgpop.Visible = false;
        }
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
    private void FillDateCurrent()
    {
        txtDateFrom.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy").ToString();
        txtDateTo.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy").ToString();
    }
    protected void GrdDemoCodeAllote_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string MailBody = "";
        Object9420 Reg = new Object9420();
        hdnnewcmp.Value = e.CommandArgument.ToString();
        if (e.CommandName.ToString() == "CodeAllocation")
        {
            NewMsg.Visible = false;
            NewMsgpop.Visible = false;
            DataSet ds = new DataSet();
            ds = Business9420.function9420.FillddlDemoAll();
            if (ds.Tables[0].Rows.Count > 0)
            {
                FillddlDemoAllocation(ddlPackageNew);
                ddlPackageNameNew.SelectedIndex = 0;
                ModalPopupExtenderNewDesign.Show();
            }
            else
            {
                NewMsgpop.Visible = true;
                NewMsgpop.Attributes.Add("class", "alert_boxes_pink big_msg");
                lblmsg.Text = "Please print demo codes !";
                return;
            }
            ModalPopupExtenderNew.Show();
        }
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        fillData();
    }
    private void fillData()
    {
        string StrAll = "";
        if (txtDateFrom.Text != "" && txtDateTo.Text != "")
            StrAll = "   WHERE Comp_Name LIKE '%" + txtCompanyName.Text.Trim().Replace("'", "''") + "%' AND Contact_Person LIKE '%" + txtContactPerson.Text.Trim().Replace("'", "''") + "%' AND   CONVERT(nvarchar, Reg_Date, 111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "' AND CONVERT(nvarchar, Reg_Date, 111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        else if (txtDateFrom.Text == "" && txtDateTo.Text != "")
            StrAll = "   WHERE Comp_Name LIKE '%" + txtCompanyName.Text.Trim().Replace("'", "''") + "%'  AND Contact_Person LIKE '%" + txtContactPerson.Text.Trim().Replace("'", "''") + "%' AND   CONVERT(nvarchar,Reg_Date, 111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        else if (txtDateFrom.Text != "" && txtDateTo.Text == "")
            StrAll = "   WHERE  Comp_Name LIKE '%" + txtCompanyName.Text.Trim().Replace("'", "''") + "%'  AND Contact_Person LIKE '%" + txtContactPerson.Text.Trim().Replace("'", "''") + "%' AND  CONVERT(nvarchar, Reg_Date, 111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
        else
            StrAll = "   WHERE  Comp_Name LIKE '%" + txtCompanyName.Text.Trim().Replace("'", "''") + "%'  AND Contact_Person LIKE '%" + txtContactPerson.Text.Trim().Replace("'", "''") + "%'";
        DataSet ds = Business9420.function9420.FillDataRetailerGrid(StrAll);
        if (Convert.ToInt32(ddlRowsShow.SelectedValue) > 1000)
        {
            if (ds.Tables[0].Rows.Count > 0)
                GrdDemoCodeAllote.PageSize = ds.Tables[0].Rows.Count;
        }
        else
            GrdDemoCodeAllote.PageSize = Convert.ToInt32(ddlRowsShow.SelectedValue.Trim());
        if (ds.Tables[0].Rows.Count > 0)
            GrdDemoCodeAllote.DataSource = ds.Tables[0];
        GrdDemoCodeAllote.DataBind();
        lblcount.Text = ds.Tables[0].Rows.Count.ToString();
    }



    private void txtClearDemo()
    {
        lblmsgmail.Text = string.Empty;
        txtEmailDemo.Text = "";
        txtContactNoDemo.Text = "";
        txtContactPersonNameDemo.Text = "";
        txtCompanyName.Text = "";
        txtContactPerson.Text = "";
        FillddlDemoAllocation(ddlPackage);
        lblAvlPacket.Text = "";
        txtCompantNameDemo.Text = "";
        ddlPackage.SelectedIndex = 0;
        avapac.Visible = false;
        lblAvlPacket.Text = "--Select--";
        FillDateCurrent();

    }
    private void FillddlDemoAllocation(DropDownList Mainddl)
    {
        DataSet ds = new DataSet();
        ds = SQL_DB.ExecuteDataSet("select convert(nvarchar,bunchCode) as bunchCode, convert(nvarchar,row_number() over(order by bunchCode))+'-'+ convert(nvarchar, count(bunchCode)) as totalCount from vw_bunch_code group by bunchCode"); //Business9420.function9420.FillddlDemoAll();        
        if (ds.Tables[0].Rows.Count > 0)
        {
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "totalCount", "bunchCode", Mainddl, "--Select--");
            Mainddl.SelectedIndex = 0;
        }
        else
        {
            Mainddl.Items.Clear();
            Mainddl.Items.Insert(0, "--Select--");
        }
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        NewMsg.Visible = false;
        NewMsgpop.Visible = false;
        DataSet ds = new DataSet();
        ds = Business9420.function9420.FillddlDemoAll();
        if (ds.Tables[0].Rows.Count > 0)
        {
            txtClearDemo();
            ModalPopupExtenderNewDesign.Show();
        }
        else
        {
            NewMsgpop.Visible = true;
            NewMsgpop.Attributes.Add("class", "alert_boxes_pink big_msg");
            lblmsg.Text = "Please print demo codes !";
            return;
        }

    }

    protected void ddlPackage_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlPackage.SelectedIndex == 0)
            avapac.Visible = false;
        else
        {
            avapac.Visible = true;
            string[] b = ddlPackage.SelectedValue.ToString().Split('-');
            lblAvlPacket.Text = b[1].ToString();
            FillddlPacketName(ddlPackage.SelectedItem.Text.Trim(),ddlPackageName);
        }
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Comp_Email] FROM [Comp_Reg] where [Comp_Email] = '" + txtEmailDemo.Text.Trim().Replace("'", "''") + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            btnSaveDemo.CssClass = "button_all_Sec";
            btnSaveDemo.Enabled = false;
            lblmsgmail.Text = "Email Id Already exist.";
            //NewMsg.Visible = true;
            //NewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            //lblpopmsg.Text = "Email Id Already exist.";
        }
        else
        {
            btnSaveDemo.Enabled = true;
            lblmsgmail.Text = string.Empty;
            btnSaveDemo.CssClass = "button_all";
            //NewMsg.Visible = false;
            //NewMsg.Attributes.Add("class", "");
            //lblpopmsg.Text = "";
        }
        ModalPopupExtenderNewDesign.Show();
    }
    protected void ddlPackageNew_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlPackageNew.SelectedIndex == 0)
            avapac.Visible = false;
        else
        {
            avapac.Visible = true;
            string[] b = ddlPackageNew.SelectedValue.ToString().Split('-');
            lblAvlPacket.Text = b[1].ToString();
            FillddlPacketName(ddlPackageNew.SelectedItem.Text.Trim(), ddlPackageNameNew);
        }
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Comp_Email] FROM [Comp_Reg] where [Comp_Email] = '" + txtEmailDemo.Text.Trim().Replace("'", "''") + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            btnSaveDemo.CssClass = "button_all_Sec";
            btnSaveDemo.Enabled = false;
            lblmsgmail.Text = "Email Id Already exist.";
            //NewMsg.Visible = true;
            //NewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            //lblpopmsg.Text = "Email Id Already exist.";
        }
        else
        {
            btnSaveDemo.Enabled = true;
            lblmsgmail.Text = string.Empty;
            btnSaveDemo.CssClass = "button_all";
            //NewMsg.Visible = false;
            //NewMsg.Attributes.Add("class", "");
            //lblpopmsg.Text = "";
        }
        ModalPopupExtenderNew.Show();
    }
    private void FillddlPacketName(string bunchCode,DropDownList ddlMain)
    {
        ddlPackageName.Items.Clear();
        DataSet ds = new DataSet();
        ds = SQL_DB.ExecuteDataSet("select bunchCode,Use_Type as Packet_Name from vw_bunch_code WHERE bunchCode = '" + bunchCode + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            DataProvider.MyUtilities.FillDDLInsertZeroIndexIntVal(ds, "Packet_Name", "Packet_Name", ddlMain, "--Select Packet--");
            ddlMain.SelectedIndex = 0;
        }
        else
        {
            ddlMain.Items.Clear();
            ddlMain.Items.Insert(0, "--Select Packet--");
        }
    }
    //protected void btnSaveDemo_Click(object sender, EventArgs e)
    //{
    //    Object9420 Reg = new Object9420();
    //    Reg.Comp_Email = txtEmailDemo.Text.Trim().Replace("'", "''");
    //    Reg.Comp_Name = txtCompantNameDemo.Text.Trim().Replace("'", "''");
    //    Reg.Contact_Person = txtContactPersonNameDemo.Text.Trim().Replace("'", "''");
    //    Reg.Mobile_No = txtContactNoDemo.Text.Trim().Replace("'", "''");
    //    Reg.NoofCodes = Convert.ToInt32(ddlPackage.SelectedItem.Text.ToString());
    //    Reg.Use_Type = ddlPackageName.SelectedItem.Text.Trim(); //Business9420.function9420.FindPack(Reg);
    //    Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now);
    //    Business9420.function9420.InsertAllocatedCodesForDemo(Reg);


    //    string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
    //               " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
    //               " <hr style='border:1px solid #2587D5;'/>" +
    //               " <div class='w_frame'>" +
    //               " <p>" +
    //               " <div class='w_detail'>" +
    //               " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
    //               " <br /> Thank you for choosing Label9420.com Your details are as follows:-<br />" +
    //               " <table border='0' cellspacing='2'>" +
    //               " <tr>" +
    //               " <td width='150' align='right'><strong>account Type :&nbsp; </strong></td>" +
    //               " <td width='282'>Retailer</td>" +
    //               " </tr>" +
    //               " <tr>" +
    //               " <td align='right' valign='top'><strong>Packet secret Code :&nbsp;</strong></td>" +
    //               " <td>" + Reg.Use_Type + "</td>" +
    //               " </tr>" +
    //               " <tr>" +
    //               " <td align='right' valign='top'><strong>Codes in packet :&nbsp;</strong></td>" +
    //               " <td>" + Reg.NoofCodes + "</td>" +
    //               " </tr>" +
    //               " </table>" +
    //               " <p>" +
    //               " <div class='w_detail'>" +
    //               " Assuring you  of  our best services always.<br />" +
    //               " Thank you,<br /><br />" +
    //               " Team <em><strong>VCQRU.COM,</strong></em><br />" +
    //               "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
    //               " </div>" +
    //               " </p>" +
    //               " </div>" +
    //               " </p>" +
    //               " </div> " +
    //               " </div> ";

    //    DataSet dsMl = function9420.FetchMailDetail("admin");
    //    if (dsMl.Tables[0].Rows.Count > 0)
    //        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Company Retailer Registration");

    //    txtClearDemo();
    //    NewMsgpop.Visible = true;
    //    NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
    //    lblmsg.Text = "Packet secret code send successfully !";
    //    fillData();
    //}

    #region New Code For Retailer Registration
    protected void btnSaveDemo_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_Email = txtEmailDemo.Text.Trim().Replace("'", "''");
        Reg.Comp_Name = txtCompantNameDemo.Text.Trim().Replace("'", "''");
        Reg.Contact_Person = txtContactPersonNameDemo.Text.Trim().Replace("'", "''");
        Reg.Mobile_No = txtContactNoDemo.Text.Trim().Replace("'", "''");
        Reg.NoofCodes = Convert.ToInt32(ddlPackage.SelectedItem.Text.ToString());
        Reg.Use_Type = ddlPackageName.SelectedItem.Text.Trim(); //Business9420.function9420.FindPack(Reg);
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now);
        Business9420.function9420.InsertAllocatedCodesForDemo(Reg);


        Object9420 obj = new Object9420();
        obj.Comp_Name = txtCompantNameDemo.Text.Trim().Replace("'", "''").ToString();
        obj.Comp_Email = txtEmailDemo.Text.Trim().Replace("'", "''").ToString();
        obj.Contact_Person = txtContactPersonNameDemo.Text.Trim().Replace("'", "''").ToString();
        obj.Mobile_No = txtContactNoDemo.Text.Trim().Replace("'", "''").ToString();
        obj.Comp_type = "D";
        obj.Comp_ID = SQL_DB.ExecuteScalar("SELECT [PrPrefix]+ '-' + convert(nvarchar,[PrStart]) as compId FROM [Code_Gen] where [Prfor] = 'Company'").ToString();
        obj.Reg_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy hh:mm:ss tt");
        obj.Status = 0;
        obj.Email_Vari_Flag = 1;
        obj.Update_Flag = 0;
        //obj.City_ID = 137;
        obj.DML = "I";
        Random rnd = new Random();
        obj.Password = rnd.Next().ToString().Substring(0, 5);

        function9420.SaveCompanyReg(obj);
        //SQL_DB.ExecuteNonQuery("UPDATE [Allcation_Demo] SET [Entry_Flag] = 1 WHERE [Email_ID] = '" + obj.Comp_Email + "'");
        SQL_DB.ExecuteNonQuery("UPDATE [Code_Gen] SET [PrStart] = PrStart + 1 WHERE [Prfor] = 'Company'");
        //New Code Update for Retailer
        SQL_DB.ExecuteNonQuery("UPDATE [Comp_Reg] SET  [IsRetailer] = 1 WHERE [Comp_ID] = '" + obj.Comp_ID + "'");
        string EncData = string.Format("Comp_Id={0}", obj.Comp_ID);
        //string link = "http://Label9420.com/Index.aspx";
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + obj.Contact_Person + ",</strong></em></span><br />" +
        " <br />" +
        " <span> Your Company <strong>" + obj.Comp_Name + "</strong> Registered successflly as Retailer </span>" +
        " <br />" +
        " <span>Your login credential is following</span>" +
        " <br />" +
        " <br />" +
        " <span><strong>Your User ID : - </strong>" + obj.Comp_Email + "</span>" +
        " <br />" +
        " <span><strong>Your Password : - </strong>" + obj.Password + "</span>" +
        " <br />you are just few seconds away to enjoy the services of " + ProjectSession.GetWebsiteName + " <br />" +
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
        DataSet dsMl = function9420.FetchMailDetail("register");
        if (dsMl.Tables[0].Rows.Count > 0)
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Comp_Email, MailBody, "Company Registration");
        txtClearDemo();
        lblmsg.Text = "<b>Dear " + txtContactPersonNameDemo.Text + "</b><br/> Thanks for registration with us. Please check your email for your login details  <br/> <br/> <b> Thank you,</b> <br/> Team: VCQRU.COM <br/>  " + ProjectSession.sales_accomplishtrades + " ";
        NewMsgpop.Visible = true;
        NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
        lblmsg.Text = "Packet secret code send successfully !";
        fillData();
        //ModalPopupExtenderMessage.Show();
        //lbllicDemoCheck.Value = string.Empty; txtCompantNameDemo.Text = string.Empty; txtEmailDemo.Text = string.Empty; txtContactPersonNameDemo.Text = string.Empty; txtContactNoDemo.Text = string.Empty;
    }
    #endregion

    protected void btnResetDemo_Click(object sender, EventArgs e)
    {
        txtClearDemo();
        NewMsg.Visible = false;
        ModalPopupExtenderNewDesign.Show();
    }
    protected void btnSaveNew_Click(object sender, EventArgs e)
    {
        string CompId = hdnnewcmp.Value;
        Object9420 Reg = new Object9420();
        DataTable dt = SQL_DB.ExecuteDataTable("SELECT * FROM Comp_Reg WHERE Comp_ID ='" + CompId + "' ");
        if (dt.Rows.Count > 0)
        {
            Reg.Comp_Email = dt.Rows[0]["Comp_Email"].ToString();
            Reg.Comp_Name = dt.Rows[0]["Comp_Name"].ToString();
            Reg.Contact_Person = dt.Rows[0]["Contact_Person"].ToString();
            Reg.Mobile_No = dt.Rows[0]["Mobile_No"].ToString();
            Reg.NoofCodes = Convert.ToInt32(ddlPackageNew.SelectedItem.Text.ToString());
            Reg.Use_Type = ddlPackageNameNew.SelectedItem.Text.Trim(); //Business9420.function9420.FindPack(Reg);
            Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now);
            Business9420.function9420.InsertAllocatedCodesForDemo(Reg);
            if (CheckProduct(CompId))
            {
                DataTable pdt = SQL_DB.ExecuteDataTable("SELECT Pro_ID FROM Pro_Reg WHERE Comp_ID ='" + CompId + "' ");
                if (pdt.Rows.Count > 0)
                {
                    DataTable detdt = SQL_DB.ExecuteDataTable("SELECT Row_ID FROM T_Pro WHERE Pro_ID ='" + pdt.Rows[0]["Pro_ID"].ToString() + "' ");
                    if (detdt.Rows.Count > 0)
                    {
                        Reg.Batch_No = detdt.Rows[0]["Row_ID"].ToString();
                        Reg.Pro_ID = pdt.Rows[0]["Pro_ID"].ToString();
                        Reg.NoofCodes = Convert.ToInt32(ddlPackageNew.SelectedItem.Text.ToString());
                        Reg.Use_Type = ddlPackageNameNew.SelectedItem.Text.Trim();
                        function9420.UpDateBatchProductDetailsInM_CodeDemo(Reg);
                        SQL_DB.ExecuteNonQuery("UPDATE [Allcation_Demo] SET [Entry_Flag] = '1' WHERE [Packet_Name] = '" + Reg.Use_Type + "'");
                    }
                }
            }
        }
        hdnnewcmp.Value = string.Empty;
    }

    private bool CheckProduct(string CompId)
    {
        DataTable dt = SQL_DB.ExecuteDataTable("SELECT * FROM Pro_Reg WHERE Comp_ID ='" + CompId + "' ");
        if (dt.Rows.Count > 0)
            return true;
        else
            return false;
    }
    protected void btnResetNew_Click(object sender, EventArgs e)
    {
        ddlPackageNew.SelectedIndex = 0;
        ddlPackageNameNew.SelectedIndex = 0;
        NewMsg.Visible = false;
        ModalPopupExtenderNew.Show();
    }

    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        NewMsg.Visible = false;
        NewMsgpop.Attributes.Add("class", "");
        lblmsg.Text = string.Empty;
        fillData();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        NewMsg.Visible = false;
        NewMsgpop.Attributes.Add("class", "");
        lblmsg.Text = string.Empty;
        txtClearDemo();
        fillData();
    }





}