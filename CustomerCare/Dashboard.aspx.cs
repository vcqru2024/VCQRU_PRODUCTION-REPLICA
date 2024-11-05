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
using System.Data.SqlClient;
using DataProvider;
using System.Net;
using DataProvider;

public partial class Dashboard : System.Web.UI.Page
{
    public int IntStatus = 0, IntIndex = 0, sindex = 0, dindex = 0, c = 0, index = 0, Flag = 0, tindex = 0, alertCount = 0, SoundFlag = 0, DocFlag = 0, pindex = 0, payflag = 0, docindex = 0, ver_email = 0, ver_str = 0, st_flag = 0, pro = 0, docflag = 0, sflag = 0, rflag = 0, windex = 0, scrapindex = 0; public string dflag = "", ver_eflag = "";
    public string FSound = "", FPath = "", CurrCompID = "", PType = "", U_Type = "";
    public string server = Convert.ToString(ConfigurationManager.ConnectionStrings["ServerName"].ConnectionString), userID = Convert.ToString(ConfigurationManager.ConnectionStrings["UserName"].ConnectionString), password = Convert.ToString(ConfigurationManager.ConnectionStrings["Password"].ConnectionString);
    public string srt = DataProvider.Utility.FindMailBody();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("../Index.aspx?Page=Dashboard.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                lblloginName.Text = "Admin";
            else if (Session["User_Type"].ToString() == "Company")//Response.Redirect("Index.aspx");
                lblloginName.Text = SQL_DB.ExecuteScalar("SELECT [Comp_Name] FROM [Comp_Reg] where [Comp_ID] = '" + Session["CompanyId"].ToString() + "'").ToString();
        }
        if (!Page.IsPostBack)
        {
            ChkOpen();
            if (Session["User_Type"].ToString() != "Customer Care")
            {                
                Object9420 Reg = new Object9420();
                if (Session["User_Type"].ToString() == "Admin")
                {
                    Reg.Comp_ID = "";
                    FillRequestedLabels();
                    FillGrdMainDispatchLabels();
                    Reg.Pro_ID = "";
                    FillProdocWise(Reg);
                    FillReqPayment();
                    FillDataNewReg();
                    FillWorkingCompanyStatus();
                    FillInterestedAsDemo();
                }
                else
                {
                    Reg.Comp_ID = Session["CompanyId"].ToString();                    
                    FillRequestedLabels();
                    FillGrdMainDispatchLabels();
                    Reg.Pro_ID = "";
                    FillProdocWise(Reg);
                    FillReqPayment();
                }                                
                lblallertcount.Text = string.Format("{0:00}", alertCount);
            }
        }
    }
    private void ChkOpen()
    {
        if (Session["User_Type"].ToString() != "Admin")
        {
            if (Session["User_Type"].ToString() != "Customer Care")
            {
                Object9420 obj = new Object9420();
                obj.Comp_ID = Session["CompanyId"].ToString();
                DataSet ds = function9420.CheckStatusForMan(obj);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (Session["Comp_type"].ToString() == "D")
                    {
                        Div1.Visible = false;
                        DivDemoPanal.Visible = true;
                        //Response.Redirect("Messages.aspx");
                    }
                    else
                    {
                        if (ds.Tables[0].Rows[0]["Status"].ToString() == "0")
                            Response.Redirect("Message.aspx");
                        Div1.Visible = true;
                        DivDemoPanal.Visible = false;
                    }
                }
            }
            else
            {
                Div1.Visible = false;
                DivDemoPanal.Visible = false;
            }
        }
        else
        {
            Div1.Visible = true;
            DivDemoPanal.Visible = false;
        }
    }
    #region Demo Panal Coding For Upgrade Version
    protected void btnUpgradeAcc_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Business9420.function9420.FillUpDateProfile(Reg);
        string path = "";
        path = Server.MapPath("../Data/Sound");
        path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4);
        DataProvider.Utility.DeleteDirectoryDemo(path);
        Business9420.function9420.UpgradeAcc(Reg);
        NewMsgpop.Visible = true;
        NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
        lbldemoMsg.Text = "Your company has been successfully upgrade  Demo to Licence Version !";
        string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        #region MailBody
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
           " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
           " <hr style='border:1px solid #2587D5;'/>" +
           " <div class='w_frame'>" +
           " <p>" +
           " <div class='w_detail'>" +
           " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
           " <br />" +
           " <span>Your company upgradation demo to Licence has been upgrade successfully. </span><br/><br/><br/>" +
           " <span>Kindly sign in with existing user name and password. </span><br/><br/><br/>" +
           " <span>After conversion to licence version, The Demo Print Labels given to you earlier are no longer valid. Please do not paste them now on products.  </span><br/><br/><br/>" +
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
        string MBofy = " <p>" +
           " <table border='0' cellspacing='2'>" +
           " <tr ><td colspan='2' ><strong>Comapny Details : - </strong></td> </tr>" +
           " <tr>" +
           " <td width='50%' align='left' ><strong>Company Name : </strong></td>" +
           " <td width='50%' align='left' >" + Reg.Comp_Name + "</td>" +
           " </tr>" +
           " <tr>" +
           " <td width='50%' align='left' ><strong>Contact Person : </strong></td>" +
           " <td width='50%' align='left' >" + Reg.Contact_Person + "</td>" +
           " </tr>" +
            " <tr>" +
           " <td width='50%' align='left' ><strong>Mobile No : </strong></td>" +
           " <td width='50%' align='left' >" + Reg.Mobile_No + "</td>" +
           " </tr>" +
            " <tr>" +
           " <td width='50%' align='left' ><strong>Email ID : -</strong></td>" +
           " <td width='50%' align='left' >" + Reg.Comp_Email + "</td>" +
           " </tr>" +
            " <tr>" +
           " <td width='50%' align='left' ><strong>Address : </strong></td>" +
           " <td width='50%' align='left' >" + Reg.Address + "</td>" +
           " </tr>" +
           " </table>";
        string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Admin department", "Company upgradation demo to Licence has been upgrade successfully.<br/>" + MBofy);
        #endregion
        DataSet dsMl1 = function9420.FetchMailDetail("register");
        if (dsMl1.Tables[0].Rows.Count > 0)
            DataProvider.Utility.sendMail(dsMl1.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl1.Tables[0].Rows[0]["User_Id"].ToString(), dsMl1.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.admin_accomplishtrades, MailBody1, "Company upgradation");
        DataSet dsMl = function9420.FetchMailDetail("admin");
        if (dsMl.Tables[0].Rows.Count > 0)
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Company upgrade Confirmation");
        Session.Abandon();
        Response.Redirect("../Index.aspx?Upg=Yes");
    }
    #endregion
    #region For refresh Grid
    protected void RefreshPayment_Click(object sender, ImageClickEventArgs e)
    {
        FillReqPayment();
    }
    protected void RefreshNewReg_Click(object sender, ImageClickEventArgs e)
    {
        FillDataNewReg();
    }
    protected void RefreshWorkStatus_Click(object sender, ImageClickEventArgs e)
    {
        FillWorkingCompanyStatus();
    }
    protected void RefreshSoundDoc_Click(object sender, ImageClickEventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Pro_ID = "";
        FillProdocWise(Reg);
    }
    protected void RefreshLabelRequest_Click(object sender, ImageClickEventArgs e)
    {
        FillRequestedLabels();
    }
    protected void RefreshLabelDispatch_Click(object sender, ImageClickEventArgs e)
    {
        FillGrdMainDispatchLabels();
    }
    #endregion
    private void FillWorkingCompanyStatus()
    {
        DataSet ds = new DataSet();
        #region
        string Qty = "SELECT * FROM (SELECT  Status, Comp_ID, Comp_Name,Contact_Person, Reg_Date, Comp_Email, Mobile_No,Comp_Type ,(SELECT     ISNULL(COUNT(Pro_ID), 0) FROM  Pro_Reg WHERE (Comp_ID = Comp_Reg.Comp_ID)) as P,  " +
            " Isnull((SELECT top(1) Doc_Flag FROM  Pro_Reg WHERE (Comp_ID = Comp_Reg.Comp_ID) ORDER BY (CASE  WHEN ((Sound_Flag = 1) AND (Doc_Flag = 1)) THEN 10 WHEN ((Sound_Flag = 1) AND (Doc_Flag = 0)) THEN 9 WHEN ((Sound_Flag = 1) AND (Doc_Flag = -1)) THEN 7 WHEN ((Sound_Flag = 0) AND (Doc_Flag = 1)) THEN 8 WHEN ((Sound_Flag = -1) AND (Doc_Flag = 1)) THEN 5 WHEN ((Sound_Flag = -1) AND (Doc_Flag = -1)) THEN 4 WHEN ((Sound_Flag = -1) AND (Doc_Flag = 0)) THEN 3 WHEN ((Sound_Flag = 0) AND (Doc_Flag = -1)) THEN 6 ELSE  2  END) DESC  ),0) as Doc_Flag , " +
            " Isnull((SELECT top(1) Sound_Flag FROM  Pro_Reg WHERE (Comp_ID = Comp_Reg.Comp_ID) ORDER BY (CASE  WHEN ((Sound_Flag = 1) AND (Doc_Flag = 1)) THEN 10 WHEN ((Sound_Flag = 1) AND (Doc_Flag = 0)) THEN 9 WHEN ((Sound_Flag = 1) AND (Doc_Flag = -1)) THEN 7 WHEN ((Sound_Flag = 0) AND (Doc_Flag = 1)) THEN 8 WHEN ((Sound_Flag = -1) AND (Doc_Flag = 1)) THEN 5 WHEN ((Sound_Flag = -1) AND (Doc_Flag = -1)) THEN 4 WHEN ((Sound_Flag = -1) AND (Doc_Flag = 0)) THEN 3 WHEN ((Sound_Flag = 0) AND (Doc_Flag = -1)) THEN 6 ELSE  2  END) DESC  ),0) as Sound_Flag  " +
            " ,ISNULL((SELECT  TOP(1) (CASE WHEN Flag = 1 THEN 1  WHEN Flag = 0 THEN 2 WHEN Flag = -1 THEN 3 ELSE 4 END) AS Cnt FROM  M_Label_Request WHERE Pro_ID IN (SELECT Pro_ID FROM Pro_Reg where Comp_ID = Comp_Reg.Comp_ID)  ORDER BY Flag DESC),4) as R " +
            //" (CASE WHEN (SELECT Count(Row_ID) FROM M_Label_Request WHERE Pro_ID IN (SELECT Pro_ID FROM Pro_Reg where Comp_ID = Comp_Reg.Comp_ID) AND ((Flag = 1) OR (Flag = - 1) OR (Flag = 0))) = 0 THEN 2  WHEN  (SELECT Count(Row_ID) FROM M_Label_Request WHERE Pro_ID IN  " +
            //" (SELECT Pro_ID FROM Pro_Reg where Comp_ID = Comp_Reg.Comp_ID) AND ((Flag = 1) OR (Flag = - 1) OR (Flag = 0))) > 0 THEN  (SELECT Flag FROM M_Label_Request WHERE Pro_ID IN (SELECT Pro_ID FROM Pro_Reg where Comp_ID = Comp_Reg.Comp_ID) AND ((Flag = 1) OR (Flag = - 1) OR (Flag = 0))) " +
            " FROM  Comp_Reg WHERE Status = 1) Reg  WHERE R <> 1 ORDER BY  Reg_Date DESC";
        #endregion
        SQL_DB.GetDA(Qty).Fill(ds, "1");
        LblworkCount.Text = ds.Tables["1"].Rows.Count.ToString();
        if (ds.Tables["1"].Rows.Count > 0)
            GrdVwCompWork.PageSize = Convert.ToInt32(LblworkCount.Text);
        else
            GrdVwCompWork.PageSize = 10;
        GrdVwCompWork.DataSource = ds.Tables["1"];
        GrdVwCompWork.DataBind();
    }
    private void FillReqPayment()
    {
        string StrAll = "Flag=0"; string Comp_ID = "";
        if (Session["User_Type"].ToString() == "Admin")
            Comp_ID = "";
        else
            Comp_ID = Session["CompanyId"].ToString();
        DataSet ds = Business9420.function9420.FillDataGridPaymentRequest(StrAll, Comp_ID);
        Label1.Text = ds.Tables[0].Rows.Count.ToString();
        if (ds.Tables[0].Rows.Count > 0)
            GrdRequestAmount.DataSource = ds.Tables[0];
        GrdRequestAmount.DataBind();
        alertCount += ds.Tables[0].Rows.Count;
        Label1.Text = ds.Tables[0].Rows.Count.ToString();
        if (ds.Tables[0].Rows.Count == 0)
            lbltotalpay.Text = "(0)";
        else
        {
            //DataTable dt = ds.Tables[0];
            //double k = dt.AsEnumerable().Sum(o => o.Field<Int16>("Rec_Amount"));
            lbltotalpay.Text = "(" + ds.Tables[0].Compute("SUM(Req_Amount)", "Flag=0").ToString() + ")";      // "("+ k.ToString() + ")" ; 
        }
        if (Session["User_Type"].ToString() == "Admin")
            GrdRequestAmount.Columns[8].Visible = true;
        else
            GrdRequestAmount.Columns[8].Visible = false;        
    }    
    protected void imglogout_Click(object sender, ImageClickEventArgs e)
    {
        string IP = GetIP();
        if (Session["User_Type"].ToString() == "Admin")
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Login_History] SET [Logout_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE CONVERT(VARCHAR,Login_Date,111)= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' AND User_ID = '" + Session["User_Type"].ToString() + "'  AND user_Type = 1 AND (Dial_Mode = '" + IP + "')  AND Row_ID = (SELECT MAX(Row_ID) FROM  Login_History WHERE  User_ID = '" + Session["User_Type"].ToString() + "'  AND (Dial_Mode = '" + IP + "') ) ");
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
        else
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Login_History] SET [Logout_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE CONVERT(VARCHAR,Login_Date,111)= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' AND User_ID = '" + Session["CompanyId"].ToString() + "'  AND user_Type = 0 AND (Dial_Mode = '" + IP + "')  AND Row_ID = (SELECT MAX(Row_ID) FROM  Login_History WHERE  User_ID = '" + Session["CompanyId"].ToString() + "'  AND (Dial_Mode = '" + IP + "') ) ");
            Session.Abandon();
            Response.Redirect("Index.aspx");
        }
    }
    private string GetIP()
    {
        string Ipaddress;
        Ipaddress = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (Ipaddress == "" || Ipaddress == null)
        {
            Ipaddress = Request.ServerVariables["REMOTE_ADDR"];
            //Response.Write(ipaddress);
        }
        //string activity;
        //string controlpage = Request["__EVENTARGUMENT"];
        //IPHostEntry host;
        //string localIP = "?";
        //host = Dns.GetHostEntry(Dns.GetHostName());
        //foreach (IPAddress ip in host.AddressList)
        //{
        //    if (ip.AddressFamily.ToString() == "InterNetwork")
        //    {
        //        localIP = ip.ToString();
        //    }
        //}
        //if (controlpage == null)
        //{
        //    activity = "Open Page";
        //}
        //else
        //{
        //    activity = controlpage.ToString();
        //}
        //string Ipaddress = localIP.ToString();
        return Ipaddress;
    }
    private void FillRequestedLabels()
    {
        DataSet ds = new DataSet();
        Object9420 obj = new Object9420();
        if (Session["User_Type"].ToString() == "Admin")
        {
            obj.Comp_ID = "";
            obj.Status = 0;
        }
        else
        {
            obj.Comp_ID = Session["CompanyId"].ToString();
            obj.Status = 1;
        }
        ds = function9420.FillGrdLabelsRequested(obj);// Old Manf function9420.FetchDataForManDashBoard(obj);//        
        lblLabelsC.Text = ds.Tables[0].Rows.Count.ToString();
        if (ds.Tables[0].Rows.Count > 0)
            GrdRequestedLabels.PageSize = Convert.ToInt32(lblLabelsC.Text);
        else
            GrdRequestedLabels.PageSize = 10;
        GrdRequestedLabels.DataSource = ds.Tables[0];
        GrdRequestedLabels.DataBind();
        alertCount += ds.Tables[0].Rows.Count;
        if (Session["User_Type"].ToString() == "Admin")
        {
            GrdRequestedLabels.Columns[6].Visible = false;
            GrdRequestedLabels.Columns[7].Visible = true;
        }
        else
        {
            GrdRequestedLabels.Columns[6].Visible = true;
            GrdRequestedLabels.Columns[7].Visible = false;
        }
    }
    private void FillGrdMainDispatchLabels()
    {
        Object9420 Reg = new Object9420();
        if (Session["User_Type"].ToString() == "Admin")
            Reg.Comp_ID = "";
        else
            Reg.Comp_ID = Session["CompanyId"].ToString();
        DateTime D1 = Convert.ToDateTime(DataProvider.LocalDateTime.Now);
        D1 = D1.AddDays(-10);
        Reg.Msg = " AND (CONVERT(VARCHAR,Entry_Date,111) <= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "') AND (CONVERT(VARCHAR,Entry_Date,111) >= '" + Convert.ToDateTime(D1).ToString("yyyy/MM/dd") + "')";
        DataSet ds = function9420.FillGrdMainLabelDispatchDataDashBoard(Reg);
        LblCountDisp.Text = ds.Tables[0].Rows.Count.ToString();
        if (ds.Tables[0].Rows.Count > 0)
            GrdRequestedLabels.PageSize = ds.Tables[0].Rows.Count;
        else
            GrdRequestedLabels.PageSize = 10;
        GrdCourierDispatch.DataSource = ds.Tables[0];
        GrdCourierDispatch.DataBind();
        alertCount += ds.Tables[0].Rows.Count;
        FillProductDetails();
    }
    private void FillProductDetails()
    {
        DataSet ds = new DataSet();
        if (GrdCourierDispatch.Rows.Count > 0)
        {
            for (int i = 0; i < GrdCourierDispatch.Rows.Count; i++)
            {
                Label CourierDispID = (Label)GrdCourierDispatch.Rows[i].FindControl("lblCDispID");
                Object9420 obj = new Object9420();
                obj.Courier_Disp_ID = CourierDispID.Text;
                ds = function9420.GetCourierProDispInfo(obj);
                GridView Grd = (GridView)GrdCourierDispatch.Rows[i].FindControl("GrdLablelDet");
                Grd.DataSource = ds.Tables[0];
                Grd.DataBind();
            }
        }
    }
    private void FillScrapEntryCourier(Object9420 Reg)
    {
        DataSet dsn12 = Business9420.function9420.FillScrapEntryCourier(Reg);
        GrdVwCourierScrapOpen.DataSource = dsn12.Tables[0];
        GrdVwCourierScrapOpen.DataBind();
    }
    private void FillDataNewReg()
    {
        DataSet ds = new DataSet();
        #region
        string Qty = "SELECT * from ( SELECT Comp_ID, Comp_Name, (SELECT Cat_Name FROM M_Category WHERE Cat_Id=Comp_Reg.Comp_Cat_Id ) as Comp_Type, Comp_Email, WebSite, Address, (SELECT Country_Name FROM M_Country WHERE Country_ID=Comp_Reg.City_ID) AS Country_Name, Contact_Person, Mobile_No, Phone_No, Fax, Reg_Date, Password, Status, " +
            " case when Comp_Type = 'L' then (case when isnull((select Row_ID from Comp_Document where  Comp_ID = Comp_Reg.Comp_ID),0)  = 0 then 'No' else  convert(varchar, (case when isnull((select count(*) from Comp_Doc_Flag where Comp_ID = Comp_Reg.Comp_ID and Flag = 1),0) = 0 then (case when Status = 0 then 'No' else 'ENo' end) else (case when Status = 0 then 'No' else 'EYes' end) end) )end) else (case when Status = 0 then 'No' else 'ENo' end) end as Doo, " +
            " (case when isnull((select Row_ID from Comp_Document where  Comp_ID = Comp_Reg.Comp_ID),0)  = 0 then 'No' else  convert(varchar, (case when isnull((select count(*) from Comp_Doc_Flag where Comp_ID = Comp_Reg.Comp_ID),0) < 7  then 'No' when isnull((select count(*) from Comp_Doc_Flag where Comp_ID = Comp_Reg.Comp_ID),0) = 7  then 'ENo' else 'EYes' end) ) end )as D, " +
            " (case when isnull((select Row_ID from Comp_Document where  Comp_ID = Comp_Reg.Comp_ID),0)  = 0 then 'No' else  convert(varchar, (case when isnull((select count(*) from Comp_Doc_Flag where Comp_ID = Comp_Reg.Comp_ID and Flag = 1),0) = 0 then 'No' else 'Yes' end) )end)as Cnt, " +
        " Email_Vari_Flag, Update_Flag,(case when Comp_Type = 'D' then 1 else isnull((SELECT top(1) Flag FROM Comp_Doc_Flag WHERE (Comp_ID = Comp_Reg.Comp_ID) GROUP BY Comp_ID, Flag ORDER BY Flag),0)end) as Doc_Flag,'Sound/' + SUBSTRING(Comp_ID, 6, 4) + '/' + SUBSTRING(Comp_ID, 6, 4) + '.wav' AS SoundPath,Comp_Type as TypeCmp " +
        " FROM Comp_Reg ) Reg where Reg.Doo = 'No' ORDER BY Reg_Date DESC --AND Reg.TypeCmp = 'L' ";
        #endregion
        SQL_DB.GetDA(Qty).Fill(ds, "1");
        Label5.Text = ds.Tables["1"].Rows.Count.ToString();
        if (ds.Tables["1"].Rows.Count > 0)
            GrdProductMaster.PageSize = ds.Tables["1"].Rows.Count;
        else
            GrdProductMaster.PageSize = 10;
        GrdProductMaster.DataSource = ds.Tables["1"];
        GrdProductMaster.DataBind();
        alertCount += ds.Tables[0].Rows.Count;
        //FillProductDetails();
        //FillGridColor();
    }
    private void FillProdocWise(Object9420 Reg)
    {
        if (Session["User_Type"].ToString() == "Admin")
            Reg.Comp_ID = "";
        else
            Reg.Comp_ID = Session["CompanyId"].ToString();
        DataSet ds = function9420.FillGrdProDoc(Reg);
        if (ds.Tables[0].Rows.Count > 0)
            GrdRequestedLabels.PageSize = ds.Tables[0].Rows.Count;
        else
            GrdViewProDoc.PageSize = 10;
        GrdViewProDoc.DataSource = ds.Tables[0];
        GrdViewProDoc.DataBind();
        alertCount += ds.Tables[0].Rows.Count;
        LabelProdoc.Text = ds.Tables[0].Rows.Count.ToString();
        if (Session["User_Type"].ToString() == "Admin")
        {
            GrdViewProDoc.Columns[5].Visible = false;
            GrdViewProDoc.Columns[6].Visible = false;
            GrdViewProDoc.Columns[7].Visible = true;
        }
        else
        {
            GrdViewProDoc.Columns[5].Visible = true;
            GrdViewProDoc.Columns[6].Visible = true;
            GrdViewProDoc.Columns[7].Visible = false;
        }
    }
    protected void btnOkReason_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Row_ID = lblRequestLabelID.Text;
        if (LabelCalText.Text == "VerifySound")
        {
            NewMsg.Visible = true;
            NewMsg.Attributes.Add("class", "alert_boxes_green");
            SQL_DB.ExecuteNonQuery("UPDATE Pro_Reg SET Sound_Flag = -1 ,Sound_Remark = '" + txtCancelRemarks.Text.Trim().Replace("'", "''") + "' WHERE  (Pro_ID = '" + HiddenField1.Value + "')");//(isnull(Sound_Flag,0) = 0) AND
            LblDashBoardmsg.Text = HiddenField3.Value + " >> " + HiddenField2.Value + " sound file has been canceled successfully !";
            Reg.Pro_ID = ""; Reg.FileType = "Sound";
            FillProdocWise(Reg);
            string script = @"setTimeout(function(){document.getElementById('" + NewMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        else if (LabelCalText.Text == "VerifyDocuments")
        {
            NewMsg.Visible = true;
            NewMsg.Attributes.Add("class", "alert_boxes_green");
            SQL_DB.ExecuteNonQuery("UPDATE Pro_Reg SET Doc_Flag = -1,Doc_Remark = '" + txtCancelRemarks.Text.Trim().Replace("'", "''") + "'  WHERE  (Pro_ID = '" + HiddenField1.Value + "')");//(isnull(Doc_Flag,0) = 0) AND
            LblDashBoardmsg.Text = HiddenField3.Value + " >> " + HiddenField2.Value + " document file has been canceled successfully !";
            Reg.Pro_ID = ""; Reg.FileType = "Document";
            FillProdocWise(Reg);
            string script = @"setTimeout(function(){document.getElementById('" + NewMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        #region MailBody
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
           " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
           " <hr style='border:1px solid #2587D5;'/>" +
           " <div class='w_frame'>" +
           " <p>" +
           " <div class='w_detail'>" +
           " <span>Dear <em><strong>" + HiddenField10.Value + ",</strong></em></span><br />" +
           " <br />" +
           " <span>Your " + Reg.Password + " file  has been canceled due to " + txtCancelRemarks.Text.Trim().Replace("'", "''") + "</span>" +
           "<br/> Please upload again!" +
           " <p>" +
           " <div class='w_detail'>" +
           " Assuring you  of  our best services always.<br />" +
           " Thank you,<br /><br />" +
           " Team <em><strong>VCQRU.COM,</strong></em><br />" +
           "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
           " <strong>Toll Free: 1800 183 9420</strong>" +
           " </div>" +
           " </p>" +
           " </div>" +
           " </p>" +
           " </div> " +
           " </div> ";
        #endregion
        string SubjectStr = Reg.FileType + " File Rejected";
        DataSet dsMl = function9420.FetchMailDetail("admin");
        if (dsMl.Tables[0].Rows.Count > 0)
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), HiddenField11.Value, MailBody, SubjectStr);
        LabelCalText.Text = string.Empty;
        HiddenField1.Value = string.Empty;
        HiddenField2.Value = string.Empty;
        HiddenField3.Value = string.Empty;
        HiddenField10.Value = string.Empty;
        HiddenField11.Value = string.Empty;
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ModalPopupExtenderReason.Show();
    }

    //protected void testbutton(object sender, EventArgs e)
    //{
    //    LogManager.WriteExe("Enter Yes Button Click");
    //}
    protected void btnYes_Click(object sender, EventArgs e)
    {
        LogManager.WriteExe("Enter Yes Button Click");
        Object9420 Reg = new Object9420();
        Reg.Row_ID = lblRequestLabelID.Text;
        Reg.Pro_ID = hdProductID.Value;
        if (hdNoofCodes.Value != "")
            Reg.Qty = Convert.ToInt32(hdNoofCodes.Value);
        else
            Reg.Qty = 0;
        if (HdLabelPrice.Value != "")
            Reg.Label_Prise = Convert.ToDouble(HdLabelPrice.Value);
        else
            Reg.Label_Prise = 0.00;
        Reg.Comp_ID = hdCompID.Value;
        if (LabelCalText.Text == "PrintLabels")
        {
            LogManager.WriteExe("Enter Yes Button Click for PrintLabels functionality!");
            DataSet dsl = function9420.GetCurrentLabelInfo(Reg);
            HiddenTrackingNo.Value = dsl.Tables[0].Rows[0]["Tracking_No"].ToString(); //SQL_DB.ExecuteScalar("SELECT Tracking_No FROM  M_Label_Request where  Row_ID='" + Reg.Row_ID + "'").ToString();
            LabelCalText.Text = string.Empty;
            Reg.Trans_Type = "Label";
            try
            {
                AllocateAndPrint(hdNoofCodes.Value, hdProductID.Value, hdCompID.Value);
            }
            catch(Exception ex)
            {
                LogManager.WriteExe("Error Find in Code Label Print functionality! Error is " + ex.Message.ToString());
                return;
            }
            LogManager.WriteExe("Before updte M_Label_Request!");
            double CurrLabelPrice = Convert.ToDouble(dsl.Tables[0].Rows[0]["Price"]);
            SQL_DB.ExecuteNonQuery("UPDATE [M_Label_Request] SET [Flag] = 1,[Price] = '" + CurrLabelPrice + "' WHERE Row_ID = " + Reg.Row_ID);
            LogManager.WriteExe("After updte M_Label_Request!");
            function9420.Generate_Invoice(Reg);
            //function9420.Invoice(Reg);
            Business9420.function9420.FillUpDateProfile(Reg);
            #region MailBody
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
               " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
               " <hr style='border:1px solid #2587D5;'/>" +
               " <div class='w_frame'>" +
               " <p>" +
               " <div class='w_detail'>" +
               " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
               " <br />" +
               " <span>Your label print request accepted and labels printed successfully. </span>" +
               " following details below: -" +
               " <p>" +
               " <table border='0' cellspacing='2'>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>Product Name : </strong></td>" +
               " <td width='50%' align='left' ><strong>" + HiddenFieldProNm.Value + "</strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>No of labels : </strong></td>" +
               " <td width='50%' align='left' ><strong>" + hdNoofCodes.Value + "</strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>Labels request ID : </strong></td>" +
               " <td width='50%' align='left' ><strong>" + HiddenTrackingNo.Value + "</strong></td>" +
               " </tr>" +
               " </table>" +
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
            string MBofy = " <br/> following details below: -" +
               " <p>" +
               " <table border='0' cellspacing='2'>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>Product</strong></td>" +
               " <td width='50%' align='left' ><strong>" + HiddenFieldProNm.Value + "</strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>No of labels</strong></td>" +
               " <td width='50%' align='left' ><strong>" + hdNoofCodes.Value + "</strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>Labels request ID : </strong></td>" +
               " <td width='50%' align='left' ><strong>" + HiddenTrackingNo.Value + "</strong></td>" +
               " </tr>" +
               " </table>";
            string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Sales department", "Product requested labels has been print successfully." + MBofy);
            string MailBody2 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Print department", "Product requested labels has been print successfully." + MBofy);
            string MailBody3 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Account department", "Product requested labels has been print successfully." + MBofy);
            string MailBody4 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "IT department", "Product requested labels has been print successfully." + MBofy);
            #endregion
            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Label request print");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Print Labels");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.print_accomplishtrades, MailBody2, "Print Labels");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Print Labels");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Print Labels");
            }
            LabelConfrimText.Text = hdNoofCodes.Value + " labels printed successfully <span style='color:blue;' > " + HiddenFieldCompNm.Value + "  </span>  >> " + HiddenFieldProNm.Value + " >> " + HiddenFieldLabelType.Value;
            FillRequestedLabels();
            LabelConfrimHeader.Text = "Alert";
            hdProductID.Value = string.Empty;
            hdCompID.Value = string.Empty;
            hdNoofCodes.Value = string.Empty;
            LabelCalText.Text = string.Empty;
            lblRequestLabelID.Text = string.Empty;
            ModalPopupExtenderConfrim.Show();
            FillRequestedLabels();
            HiddenFieldCompNm.Value = string.Empty;
            HiddenFieldProNm.Value = string.Empty;
            HiddenFieldLabelType.Value = string.Empty;
        }
        else if (LabelCalText.Text == "RequestCancel")
        {
            SQL_DB.ExecuteNonQuery("UPDATE [M_Label_Request] SET [Flag] = -1 WHERE Row_ID = " + Reg.Row_ID);
            #region MailBody
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
               " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
               " <hr style='border:1px solid #2587D5;'/>" +
               " <div class='w_frame'>" +
               " <p>" +
               " <div class='w_detail'>" +
               " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
               " <br />" +
               " <span>Your label print request is rejected. Please Contact Admin. </span>" +
               " following details below: -" +
               " <p>" +
               " <table border='0' cellspacing='2'>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>Product Name : </strong></td>" +
               " <td width='50%' align='left' ><strong>" + HiddenFieldProNm.Value + "</strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>No of labels : </strong></td>" +
               " <td width='50%' align='left' ><strong>" + hdNoofCodes.Value + "</strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>Labels request ID : </strong></td>" +
               " <td width='50%' align='left' ><strong>" + HiddenTrackingNo.Value + "</strong></td>" +
               " </tr>" +
                //" <tr>" +
                //" <td width='50%' align='left' ><strong>Reason : </strong></td>" +
                //" <td width='50%' align='left' ><strong>" + HiddenTrackingNo.Value + "</strong></td>" +
                //" </tr>" +
               " </table>" +
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
            string MBofy = " <br/> following details below: -" +
               " <p>" +
               " <table border='0' cellspacing='2'>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>Product Name : </strong></td>" +
               " <td width='50%' align='left' ><strong>" + HiddenFieldProNm.Value + "</strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>No of labels : </strong></td>" +
               " <td width='50%' align='left' ><strong>" + hdNoofCodes.Value + "</strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>Labels request ID : </strong></td>" +
               " <td width='50%' align='left' ><strong>" + HiddenTrackingNo.Value + "</strong></td>" +
               " </tr>" +
               " </table>";
            string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Sales department", "Product requested labels has been print successfully." + MBofy);
            string MailBody2 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Print department", "Product requested labels has been print successfully." + MBofy);
            string MailBody3 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Account department", "Product requested labels has been print successfully." + MBofy);
            string MailBody4 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "IT department", "Product requested labels has been print successfully." + MBofy);
            #endregion
            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Label request print");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Print Labels");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.print_accomplishtrades, MailBody2, "Print Labels");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Print Labels");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Print Labels");
            }
            LabelConfrimText.Text = hdNoofCodes.Value + " labels canceled successfully <span style='color:blue;' > " + HiddenFieldCompNm.Value + "  </span>  >> " + HiddenFieldProNm.Value + " >> " + HiddenFieldLabelType.Value;
            FillRequestedLabels();
            LabelConfrimHeader.Text = "Alert";
            hdProductID.Value = string.Empty;
            hdCompID.Value = string.Empty;
            hdNoofCodes.Value = string.Empty;
            LabelCalText.Text = string.Empty;
            lblRequestLabelID.Text = string.Empty;
            ModalPopupExtenderConfrim.Show();
            FillRequestedLabels();
            HiddenFieldCompNm.Value = string.Empty;
            HiddenFieldProNm.Value = string.Empty;
            HiddenFieldLabelType.Value = string.Empty;
        }
        else if (LabelCalText.Text == "VerifyReqPay")
        {
            Reg.Comp_ID = Label2.Text; // Comp_ID from Payment Received
            Reg.Row_ID = Label3.Text; // Row_Id from Payment Received
            Reg.Flag = 0;
            function9420.FindDetailsForRequestPayment(Reg);
            hdnRequestNo.Value = Reg.Request_No; // Request_No from Payment Received
            hdnManuRequestAmount.Value = Reg.ManuReq_Payment.ToString(); // Request_Amount by Manuf. from Payment Received   
            GrdVwAmcOffer.Visible = true;
            FillVerifyPaymentDetails(Reg);
            ModalPopupVerifyPayment.Show();
        }
        else if (LabelCalText.Text == "VerifySound")
        {
            NewMsg.Visible = true;
            NewMsg.Attributes.Add("class", "alert_boxes_green");
            SQL_DB.ExecuteNonQuery("UPDATE Pro_Reg SET Sound_Flag = 1  WHERE  (Pro_ID = '" + HiddenField1.Value + "')");//(isnull(Sound_Flag,0) = 0) AND

            //************************* Code start For Generate Invoice ******************//
            if (function9420.CheckForGenerateInvoice(HiddenField1.Value))
            {
                Object9420 Inv = new Object9420();
                Inv.Comp_ID = hdntaxcompid.Value;
                Inv.Pro_ID = HiddenField1.Value;
                Inv.Plan_ID = "";
                Inv.FolderPath = Server.MapPath("../Data/Bill");
                Inv.Path = Server.MapPath("../Reports")+"\\InvoiceReport.rpt";
                function9420.CreateInvoice(Inv);
            }
            //************************* Code start For Generate Invoice ******************//

            LblDashBoardmsg.Text = HiddenField3.Value + " >> " + HiddenField2.Value + " sound file has been verified successfully !";
            Reg.Pro_ID = "";
            Reg.FileType = "Sound";
            FillProdocWise(Reg);
            Reg.Comp_Name = HiddenField3.Value;
            #region MailBody
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
               " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
               " <hr style='border:1px solid #2587D5;'/>" +
               " <div class='w_frame'>" +
               " <p>" +
               " <div class='w_detail'>" +
               " <span>Dear <em><strong>" + HiddenField10.Value + ",</strong></em></span><br />" +
               " <br />" +
               " <span>Product <b>" + HiddenField2.Value + "'s</b> Sound file  has been verified successfully. </span>" +
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
            string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Sales department", "Product <b>" + HiddenField2.Value + "'s</b> sound file has been verified successfully.");
            string MailBody2 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Lagal department", "Product <b>" + HiddenField2.Value + "'s</b> sound file has been verified successfully.");
            string MailBody3 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Account department", "Product <b>" + HiddenField2.Value + "'s</b> sound file has been verified successfully.");
            string MailBody4 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "IT department", "Product <b>" + HiddenField2.Value + "'s</b> sound file has been verified successfully.");
            #endregion
            string SubjectStr = HiddenField2.Value + "'s "+ Reg.FileType + " file verified";
            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), HiddenField11.Value, MailBody, SubjectStr);
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Company's product sound file activation");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Legal_accomplishtrades, MailBody2, "Company's product sound file activation");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Company's product sound file activation");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Company's product sound file activation");
            }
            LabelCalText.Text = string.Empty;
            HiddenField1.Value = string.Empty;
            HiddenField2.Value = string.Empty;
            HiddenField3.Value = string.Empty;
            HiddenField10.Value = string.Empty;
            HiddenField11.Value = string.Empty;
            string script = @"setTimeout(function(){document.getElementById('" + NewMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        else if (LabelCalText.Text == "VerifyDocuments")
        {
            NewMsg.Visible = true;
            NewMsg.Attributes.Add("class", "alert_boxes_green");
            SQL_DB.ExecuteNonQuery("UPDATE Pro_Reg SET Doc_Flag = 1  WHERE (Pro_ID = '" + HiddenField1.Value + "')");//(isnull(Doc_Flag,0) = 0) AND 

            //************************* Code start For Generate Invoice ******************//
            if (function9420.CheckForGenerateInvoice(HiddenField1.Value))
            {
                Object9420 Inv = new Object9420();
                Inv.Comp_ID = hdntaxcompid.Value;
                Inv.Pro_ID = HiddenField1.Value;
                Inv.Plan_ID = "";
                Inv.FolderPath = Server.MapPath("../Data/Bill");
                Inv.Path = Server.MapPath("../Reports") + "\\InvoiceReport.rpt";
                function9420.CreateInvoice(Inv);
            }
            //************************* Code start For Generate Invoice ******************//

            LblDashBoardmsg.Text = HiddenField3.Value + " >> " + HiddenField2.Value + " document file has been verified successfully !";
            Reg.Pro_ID = "";
            Reg.FileType = "Document";
            FillProdocWise(Reg);
            Reg.Comp_Name = HiddenField3.Value;
            #region MailBody
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
               " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
               " <hr style='border:1px solid #2587D5;'/>" +
               " <div class='w_frame'>" +
               " <p>" +
               " <div class='w_detail'>" +
               " <span>Dear <em><strong>" + HiddenField10.Value + ",</strong></em></span><br />" +
               " <br />" +
               " <span>Product <b>" + HiddenField2.Value + "'s</b> documents has been verified successfully. </span>" +
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
            string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Sales department", "Product <b>" + HiddenField2.Value + "'s</b> document file has been verified successfully.");
            string MailBody2 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Lagal department", "Product <b>" + HiddenField2.Value + "'s</b> document file has been verified successfully.");
            string MailBody3 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Account department", "Product <b>" + HiddenField2.Value + "'s</b> document file has been verified successfully.");
            string MailBody4 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "IT department", "Product <b>" + HiddenField2.Value + "'s</b> document file has been verified successfully.");
            #endregion
            string SubjectStr = HiddenField2.Value + "'s " + Reg.FileType + " file verified";
            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), HiddenField11.Value, MailBody, SubjectStr);
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Company's product document file activation");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Legal_accomplishtrades, MailBody2, "Company's product document file activation");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Company's product document file activation");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Company's product document file activation");
            }
            LabelCalText.Text = string.Empty;
            HiddenField1.Value = string.Empty;
            HiddenField2.Value = string.Empty;
            HiddenField3.Value = string.Empty;
            HiddenField10.Value = string.Empty;
            HiddenField11.Value = string.Empty;
            string script = @"setTimeout(function(){document.getElementById('" + NewMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
    }
    private DataTable CreateDataTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Code1", typeof(Int32));
        dt.Columns.Add("Code2", typeof(Int32));
        dt.Columns.Add("Use_Type", typeof(string));
        dt.Columns.Add("Allot_Date", typeof(DateTime));
        dt.Columns.Add("Pro_ID", typeof(string));
        dt.Columns.Add("Print_Status", typeof(Int32));
        dt.Columns.Add("Print_Date", typeof(DateTime));
        dt.Columns.Add("Series_Order", typeof(Int32));
        dt.Columns.Add("Series_Serial", typeof(Int32));
        return dt;
    }
    private DataTable AddNewRows(DataTable dt, Int32 Code1, Int32 Code2, string Use_Type, DateTime Allot_Date, string Pro_ID, Int32 Print_Status, DateTime Print_Date, Int32 Series_Order, Int32 Series_Serial)
    {
        DataRow dr = dt.NewRow();
        dr["Code1"] = Code1;
        dr["Code2"] = Code2;
        dr["Use_Type"] = Use_Type;
        dr["Allot_Date"] = Allot_Date;
        dr["Pro_ID"] = Pro_ID;
        dr["Print_Status"] = Print_Status;
        dr["Print_Date"] = Print_Date;
        dr["Series_Order"] = Series_Order;
        dr["Series_Serial"] = Series_Serial;
        dt.Rows.Add(dr);
        return dt;
    }
    private void AllocateAndPrint(string NoofCodes, string Pro_ID, string Comp_ID)
    {

        //************************* Code Allocation Start **************************//
        #region Commmented Allocation
        //StringBuilder sbAll = new StringBuilder();
        //NewMsg.Visible = false;
        //string str = "SELECT top " + Convert.ToInt32(NoofCodes) + " [Code1],[Code2] FROM [M_Code] where [Pro_ID] is null and [Use_Type] is null";
        //DataSet ds = SQL_DB.ExecuteDataSet(str);
        //if (ds.Tables[0].Rows.Count > 0)
        //{
        //    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        //    {
        //        sbAll.Append("UPDATE [M_Code]" +
        //        " SET [Allot_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy") + "'" +
        //        " ,[Pro_ID] = '" + Pro_ID + "'" +
        //        " ,[Print_Status] = 0" +
        //        " WHERE [Code1] = " + ds.Tables[0].Rows[i]["Code1"] + "" +
        //        " and [Code2] = " + ds.Tables[0].Rows[i]["Code2"] + ";");                
        //    }
        //    SQL_DB.ExecuteNonQuery(sbAll.ToString());
        //}
        #endregion

        #region Comments
        //LblCal.Text = "Allocate";
        //LabelAlertText.Text = txtcodes.Text.ToString() + " code allocation successfully to '" + ddlCompany.SelectedItem.Text.Trim() + "'  Company.";
        //string CompanyEmail = SQL_DB.ExecuteScalar("SELECT [Comp_Email] FROM [Comp_Reg] where [Comp_ID] = '" + ddlCompany.SelectedValue.ToString() + "'").ToString();
        //string MailBody = ddlProduct.SelectedItem.Text.ToString() + "<br/>" + txtcodes.Text.ToString();
        //allClear();
        //DailyCodeAllot();
        //FilCodelInfo();
        //LabelAlertheader.Text = "Alert";


        ////NewMsg.Visible = true;
        ////NewMsg.Attributes.Add("class", "alert_boxes_green");
        ////ProductsLabelPrices.Text = "Code alloted successfully !";


        ////ModalPopupExtender1.Show(); //************* Main Code Popup
        #endregion

        //************************* Code Allocation End **************************//

        //************************* Print Labels Start **************************//
        DataSet ds = new DataSet();
        Object9420 Reg = new Object9420();
        Reg.Pro_ID = Pro_ID;
        Reg.LabelRequestID = HiddenTrackingNo.Value;
        LblDashBoardmsg.Text = ""; string s1 = ""; string o1 = ""; string s2 = ""; string o2 = "";
        ds.Reset();
        //ds = SQL_DB.ExecuteDataSet("SELECT top " + Convert.ToInt32(NoofCodes) + " [Code1],[Code2] FROM [M_Code] where [Pro_ID] is null and [Use_Type] is null AND [Allot_Date] IS NULL ");//[Pro_ID] = '" + Pro_ID + "' and [Print_Status] = 0
        t:
        try
        {
            ds = SQL_DB.ExecuteDataSet("SELECT * FROM [dbo].[GetAvailableCode] (" + Convert.ToInt64(NoofCodes) + ")");
        }
        catch(Exception ex)
        {            
            LogManager.WriteExe("Error find count Avail Code in M_code " + ex.Message.ToString());
            goto t;
        }
        if (ds.Tables[0].Rows.Count > 0)
        {
            StringBuilder sb = new StringBuilder();
            DataSet dseries = SQL_DB.ExecuteDataSet("select isnull( max([Series_Order]),0) as Series_order," +
            " isnull(max(Series_Serial),0) as Series_Serial FROM [M_Code] where [Pro_ID] = '" + Pro_ID + "'" +
            " and Print_Status = 1 and [Series_Order] = (select max([Series_Order]) as Series_order " +
            " FROM [M_Code] where [Pro_ID] = '" + Pro_ID + "' " +
            " and Print_Status = 1)");
            int orderId = Convert.ToInt32(dseries.Tables[0].Rows[0]["Series_order"]);
            int serialId = Convert.ToInt32(dseries.Tables[0].Rows[0]["Series_Serial"]);
            int i = 0;
            DataTable M_Code = new DataTable();
            M_Code = CreateDataTable();
            int counter = 0;
            if (orderId == 0 && serialId == 0)
            {
                Reg.Series_Order = 0;
                Reg.Series_Serial = 0;
                Reg.Use_Type = "L";
                Reg.Code1 = Convert.ToInt64(ds.Tables[0].Rows[0]["Code1"].ToString());
                Reg.Code2 = Convert.ToInt64(ds.Tables[0].Rows[0]["Code2"].ToString());
                Business9420.function9420.UpdateFunction(Reg);
                i = 1;
                counter++;
                s1 = Reg.Series_Serial.ToString();
                o1 = Reg.Series_Order.ToString();
            }
            bool CFlag = false; int currentindex = 0; 
            string Series_OrderChk = ""; string Series_SerialChkFrom = ""; string Series_SerialChkTo = "";
      k:
            for (; i < ds.Tables[0].Rows.Count; i++)
            {
            p:                
                if (!CFlag)
                {
                    string NewNumber = NextNumber(orderId, serialId);
                    string[] b = NewNumber.Split('-');
                    Reg.Series_Order = Convert.ToInt32(b[0]);
                    Reg.Series_Serial = Convert.ToInt32(b[1]);
                }
                if (sb.Length == 0)
                {
                    currentindex = i;
                    Series_OrderChk = Reg.Series_Order.ToString(); Series_SerialChkFrom = Reg.Series_Serial.ToString();
                }                
                #region Only Mail Data
                if (i == 0)
                {
                    s1 = Reg.Series_Serial.ToString();
                    o1 = Reg.Series_Order.ToString();
                }
                if (i == ds.Tables[0].Rows.Count - 1)
                {
                    s2 = Reg.Series_Serial.ToString();
                    o2 = Reg.Series_Order.ToString();
                }
                #endregion
                Reg.Use_Type = "L";
                Reg.Code1 = Convert.ToInt64(ds.Tables[0].Rows[i]["Code1"].ToString());
                Reg.Code2 = Convert.ToInt64(ds.Tables[0].Rows[i]["Code2"].ToString());
                //--------------New Code 22_3_13---------------------                

                //M_Code = AddNewRows(M_Code, Convert.ToInt32(Reg.Code1), Convert.ToInt32(Reg.Code2), Reg.Use_Type, Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd")), Pro_ID, 1, Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd")), Reg.Series_Order, Reg.Series_Serial);

                sb.Append("UPDATE [M_Code] SET [Print_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy") + "',[Allot_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy") + "'" +
                " ,[Pro_ID] = '" + Pro_ID + "',[Use_Type] = '" + Reg.Use_Type + "',[Print_Status] = 1, Series_Order = " + Reg.Series_Order + ", Series_Serial = " + Reg.Series_Serial + " , LabelRequestId = '" + HiddenTrackingNo.Value + "' WHERE [Code1] = " + Reg.Code1 + "" +
                " and [Code2] = " + Reg.Code2 + ";");
                //---------------------------------------------------
                //Business9420.function9420.UpdateFunction(Reg);
                orderId = Convert.ToInt32(Reg.Series_Order);
                serialId = Convert.ToInt32(Reg.Series_Serial);
                if (serialId == 9999)
                {
                    try
                    {
                        Series_SerialChkTo = Reg.Series_Serial.ToString();
                        SQL_DB.ExecuteNonQuery(sb.ToString());
                        sb = new StringBuilder();
                        CFlag = false;
                    }
                    catch (Exception ex)
                    {
                        LogManager.WriteExe("Error Execute code when bunch code print in M_code " + ex.Message.ToString());
                        int cc = 0;
                        lp:
                        try
                        {
                            cc = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT [dbo].[GetExecuteRows] ('" + Pro_ID + "'," + Series_OrderChk + "," + Series_SerialChkFrom + "," + Series_SerialChkTo + ")"));
                        }
                        catch (Exception exe)
                        {
                            LogManager.WriteExe("Error find count Code which is print in M_code " + exe.Message.ToString());
                            goto lp;
                        }
                        i = currentindex + cc; LogManager.WriteExe("Which is kill function in Count No  " + i.ToString());
                        Reg.Series_Order = Convert.ToInt32(Series_OrderChk); Reg.Series_Serial = Convert.ToInt32(Series_SerialChkFrom) + cc;
                        CFlag = true;
                        goto p;
                    }
                }
            }
            if (sb != null)
            {
                try
                {
                    Series_SerialChkTo = Reg.Series_Serial.ToString();
                    SQL_DB.ExecuteNonQuery(sb.ToString());
                    sb = new StringBuilder();
                    CFlag = false;
                }
                catch (Exception ex)
                {
                    LogManager.WriteExe("sb != null Error Execute code when bunch code print in M_code " + ex.Message.ToString());
                    int cc1 = 0;
                lp1:
                    try
                    {
                        cc1 = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT [dbo].[GetExecuteRows] ('" + Pro_ID + "'," + Series_OrderChk + "," + Series_SerialChkFrom + "," + Series_SerialChkTo + ")"));
                    }
                    catch (Exception exe)
                    {
                        LogManager.WriteExe("sb != null Error find count Code which is print in M_code " + exe.Message.ToString());
                        goto lp1;
                    }
                    i = currentindex + cc1; LogManager.WriteExe("sb != null Which is kill function in Count No  " + i.ToString());
                    Reg.Series_Order = Convert.ToInt32(Series_OrderChk); Reg.Series_Serial = Convert.ToInt32(Series_SerialChkFrom) + cc1;
                    CFlag = true;
                    goto k;
                }
            }
            // SQL_DB.ExecuteNonQuery(sb.ToString());
            //SqlDataAdapter adp = SQL_DB.GetDA("SELECT top " + Convert.ToInt32(Convert.ToInt32(NoofCodes) - Convert.ToInt32(counter)) + " [Code1],[Code2],[Use_Type],[Allot_Date],[Pro_ID],[Print_Status],[Print_Date],[Series_Order],[Series_Serial]  FROM [M_Code] where [Pro_ID] is null and [Use_Type] is null AND [Allot_Date] IS NULL ");
            //SqlCommandBuilder command = new SqlCommandBuilder(adp);
            //adp.Update(M_Code);
            //M_Code.AcceptChanges();
            LogManager.WriteExe("For loop End line");
        }
        LogManager.WriteExe("For loop outer line");
        //************** Generate Invoice ****************************/
        LogManager.WriteExe("Before Generate Invoice");
        //************** Generate Invoice ****************************/
        //************** Download Excel File And Save *****************
        Object9420 RegExccel = new Object9420();
        RegExccel.Pro_ID = Pro_ID;
        RegExccel.LabelRequestID = HiddenTrackingNo.Value;
        download(Convert.ToString(Business9420.function9420.MyRegistrationExccel(RegExccel)), Pro_ID, Comp_ID, RegExccel.LabelRequestID);
        //************** Download Excel File And End Save *****************
        LogManager.WriteExe("After Generate Invoice");
        // for company information
        Object9420 NewReg = new Object9420();
        NewReg.Comp_ID = Comp_ID;
        Business9420.function9420.FillUpDateProfile(NewReg);

        //for product information
        DataSet ds1 = function9420.UpdateData(RegExccel);
        if (ds1.Tables[0].Rows.Count > 0)
            RegExccel.Pro_Name = ds1.Tables[0].Rows[0]["Pro_Name"].ToString();
        else
            RegExccel.Pro_Name = "-- -- -- ";

        // for Label Information
        function9420.GetLabelInfo(RegExccel);

        LabelConfrimHeader.Text = "Alert";
        LabelConfrimText.Text = NoofCodes + " Labels of Type '" + RegExccel.Label_Name + "'  for  '" + NewReg.Comp_Name + "'  company  printed.";

        #region MailBody
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
           " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
           " <hr style='border:1px solid #2587D5;'/>" +
           " <div class='w_frame'>" +
           " <p>" +
           " <div class='w_detail'>" +
           " <span>Dear <em><strong>" + NewReg.Contact_Person + ",</strong></em></span><br />" +
           " <br />" +
           " <span>Your print labels request has been done</span>" +
            //" <br /> Your account has been activated successfully. <br />" +
           " <br />printed labels details are as follows:- <br />" +
           " <table border='0' cellspacing='2'>" +
           " <tr>" +
           " <td width='90' align='right'><strong>Company Name :&nbsp; </strong></td>" +
           " <td width='282'><a href='#'>" + NewReg.Comp_Name + "</a></td>" +
           " </tr>" +
           " <tr>" +
           " <td align='right' valign='top'><strong>Address :&nbsp;</strong></td>" +
           " <td>" + NewReg.Address + "</td>" +
           " </tr>" +

           " <tr>" +
           " <td align='right' valign='top'><strong>Mobile No. :&nbsp;</strong></td>" +
           " <td>" + NewReg.Mobile_No + "</td>" +
           " </tr>" +

           " <tr>" +
           " <td align='right' valign='top'><strong>Fax No. :&nbsp;</strong></td>" +
           " <td>" + NewReg.Fax + "</td>" +
           " </tr>" +

           " <tr>" +
           " <td align='right' valign='top'><strong>Email :&nbsp;</strong></td>" +
           " <td>" + NewReg.Comp_Email + "</td>" +
           " </tr>" +

           " <tr>" +
           " <td align='right' valign='top'><strong>Product Name :&nbsp;</strong></td>" +
           " <td>" + RegExccel.Pro_Name + "</td>" +
           " </tr>" +

           " <tr>" +
           " <td align='right' valign='top'><strong>Label Type :&nbsp;</strong></td>" +
           " <td>" + RegExccel.Label_Name + " ( " + RegExccel.Label_Size + " ) </td>" +
           " </tr>" +

           " <tr>" +
           " <td align='right' valign='top'><strong>Number of Labels :&nbsp;</strong></td>" +
           " <td>" + NoofCodes + "</td>" +
           " </tr>" +

           " <tr>" +
           " <td width='100%' align='left' colspan='2'><strong>Label Series From " + RegExccel.Pro_ID + "-" + string.Format("{0:00}", o1) + "-" + string.Format("{0:000}", s1) + " </strong></td>" +
           " </tr>" +
           " <tr>" +


            " <tr>" +
           " <td width='100%' align='left' colspan='2'><strong>Series Up To " + RegExccel.Pro_ID + "-" + string.Format("{0:00}", o2) + "-" + string.Format("{0:000}", s2) + " </strong></td> " +
           " </tr>" +
           " <tr>" +

           " <tr>" +
           " <td align='right' valign='top'><strong>Label Cost :&nbsp;</strong></td>" +
           " <td>" + RegExccel.Label_Prise.ToString() + "</td>" +
           " </tr>" +

            " <tr>" +
           " <td width='100%' align='left' colspan='2'><strong>Each full series contains 1000 Labels starting from 000 To 999.</strong></td>" +
           " </tr>" +

           //" <tr>" +
           //" <td width='100%' align='left' colspan='2'><strong><u>Invoice Copy</u></strong></td>" +
           //" </tr>" +
           " </table>" +
           " <p>" +
           " <div class='w_detail'>" +
           " Assuring you  of  our best services always.<br />" +
           " Thank you,<br /><br />" +
           " Team <em><strong>VCQRU.COM,</strong></em><br />" +
           "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
           " <strong>Toll Free: 1800 183 9420</strong>" +
           " </div>" +
           " </p>" +
           " </div>" +
           " </p>" +
           " </div> " +
           " </div> ";
        #endregion
        DataSet dsMl = function9420.FetchMailDetail("print");
        if (dsMl.Tables[0].Rows.Count > 0)
        {
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), NewReg.Comp_Email, MailBody, "Printed Labels");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.admin_accomplishtrades, MailBody, "Printed Labels");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.print_accomplishtrades, MailBody, "Printed Labels");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody, "Printed Labels");
        }

        lblRequestLabelID.Text = string.Empty; // Reset Print Codes Row_ID



        //************************* Print Labels End **************************//

        //ModalPopupExtenderAlert.Show();
    }
    private void CancelLabelRequest()
    {
        Object9420 Reg = new Object9420();
        Reg.Row_ID = lblRequestLabelID.Text;
        function9420.CancelLabelsRequest(Reg);
        lblRequestLabelID.Text = string.Empty;
        LabelConfrimHeader.Text = "Alert";
        LabelConfrimText.Text = "Label request canceled successfully!";
    }
    protected void btnNo_Click(object sender, EventArgs e)
    {

    }
    protected void btnConfrimOK_Click(object sender, EventArgs e)
    {
        Response.Redirect("Dashboard.aspx");
    }
    private string NextNumber(int orderid, int serialid)
    {
        int NewOrderID;
        int NewSerialID;
        if (serialid == 9999)
            NewOrderID = orderid + 1;
        else
            NewOrderID = orderid;
        if (serialid == 9999)
            NewSerialID = 0;
        else
            NewSerialID = serialid + 1;

        string NewOrderSerial = Convert.ToString(NewOrderID) + "-" + Convert.ToString(NewSerialID);
        return NewOrderSerial;
    }
    private void download(string qry, string Pro_ID, string Comp_ID, string LBLREQID)
    {
        Object9420 RegExccel = new Object9420();
        RegExccel.Pro_ID = Pro_ID;
        RegExccel.Comp_ID = Comp_ID;
        RegExccel.LabelRequestID = LBLREQID;
        string path = Server.MapPath("");
        path = path + "\\" + "Excel";
        DataProvider.Utility.CreateDirectory(path);
        string DirectoryName = path + "\\" + DataProvider.LocalDateTime.Now.ToString("dd-MM-yyyy");
        DataProvider.Utility.CreateDirectory(DirectoryName);
        string DirectoryNameN = DirectoryName + "\\" + "Licence";
        DataProvider.Utility.CreateDirectory(DirectoryNameN);
        DataProvider.Utility.DeleteFiles(DirectoryNameN + "\\" + RegExccel.Comp_ID.Substring(5, 4) + "_" + RegExccel.Pro_ID + ".xls");
        DataSet ds_rpt = new DataSet(); DataSet ds = new DataSet(); DataTable dt = new DataTable();
        SQL_DB.GetDA(qry).Fill(ds, "1");
        Int32 countrows = ds.Tables[0].Rows.Count;
        int cntloop = 0;
        int rem = 0;
        if (countrows > 50000)
        {
            cntloop = countrows / 50000;
            rem = countrows - (cntloop * 50000);
        }
        else
        {
            rem = countrows;
        }
        int i = 0, j = 0, k = 0, l = 0;
        if (cntloop > 0)
        {
            for (i = 0; i < cntloop; i++)
            {
                dt = DataProvider.Utility.CreateDataTableExcel();
                for (l = 0, j = k; l < 50000; l++, j++)
                {
                    dt = DataProvider.Utility.AddNewRowsExcel(dt, Convert.ToInt32(ds.Tables[0].Rows[j]["Code1"]), Convert.ToInt32(ds.Tables[0].Rows[j]["Code2"]), Convert.ToInt32(ds.Tables[0].Rows[j]["SNO"]), ds.Tables[0].Rows[j]["Searies_Name"].ToString());
                }
                k = j;
                DataProvider.Utility.CreateExcel(dt, DirectoryNameN, RegExccel.Comp_ID, RegExccel.Pro_ID, i, RegExccel.LabelRequestID);
            }
        }
        if (rem > 0)
        {
            dt = DataProvider.Utility.CreateDataTableExcel();
            for (l = 0, j = k; l < rem; j++, l++)
            {
                dt = DataProvider.Utility.AddNewRowsExcel(dt, Convert.ToInt32(ds.Tables[0].Rows[j]["Code1"]), Convert.ToInt32(ds.Tables[0].Rows[j]["Code2"]), Convert.ToInt32(ds.Tables[0].Rows[j]["SNO"]), ds.Tables[0].Rows[j]["Searies_Name"].ToString());
            }
            DataProvider.Utility.CreateExcel(dt, DirectoryNameN, RegExccel.Comp_ID, RegExccel.Pro_ID, i, RegExccel.LabelRequestID);
        }

    }
    protected void GrdRequestAmount_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Object9420 Reg = new Object9420();
        string[] Arr = e.CommandArgument.ToString().Split(',');
        Reg.Comp_ID = Arr[0].ToString();
        function9420.FillUpDateProfile(Reg);
        Label2.Text = Arr[0].ToString();
        Label3.Text = Arr[1].ToString();
        btnCancel.Visible = false;
        btnYes.Text = "Yes";
        btnNo.Text = "No";
        if (e.CommandName.ToString() == "VerifyReqPay")
        {
            LabelCalText.Text = "VerifyReqPay";
            LabelAlertheader.Text = "Alert";
            LabelAlertText.Text = "Are you sure to verify Requested payment Amount <a  style='color:blue;text-decoration:none;' >" + Arr[2].ToString() + "</a> of <a style='color:blue;text-decoration:none;' >" + Reg.Comp_Name + " </a>Company !";
            ModalPopupExtenderAlert.Show();
        }
        else if (e.CommandName.ToString() == "CanceledRequest")
        {
            lblreaseonMessage.Text = "Are you sure to canceled Requested payment Amount <a  style='color:blue;text-decoration:none;' >" + Arr[2].ToString() + "</a> of <a style='color:blue;text-decoration:none;' >" + Reg.Comp_Name + " </a>Company !";
            ModalPopupExtender1.Show();
        }
    }
    protected void GrdViewProDoc_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Object9420 Reg = new Object9420();
        LabelProUpId.Text = e.CommandArgument.ToString();
        Reg.Pro_ID = LabelProUpId.Text;
        DataSet ds = function9420.FillGrdProDoc(Reg);
        #region Checking For Brand Loyalty AMC Plan Added
        DataTable dtamc = SQL_DB.ExecuteDataSet("SELECT * FROM M_Amc_Offer WHERE Pro_ID = '" + Reg.Pro_ID + "' ").Tables[0];
        if (dtamc.Rows.Count == 0)
        {
            LblAmcSelectHead.Text = "Confirmation Message";            
            //msgAmc.Visible = true;
            Lblmsgp.Text = "Please take a AMC Plan <a href='ProFileAuthentiCation.aspx' target='_blank' >Take AMC</a> for this product.";
            //msgAmc.Attributes.Add("class", "alert_boxes_pink");
            AmcSelectModalPopup.Show();
            //string script = @"setTimeout(function(){document.getElementById('" + msgAmc.ClientID + "').style.display='none';},5000);";
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            //btnCancel.Attributes.Add("onclick", "SetScrollEvent();");
            return;
        }
        #endregion
        #region Some Variables
        Reg.Comp_ID = ds.Tables[0].Rows[0]["Comp_ID"].ToString();
        Reg.Pro_Name = ds.Tables[0].Rows[0]["Pro_Name"].ToString();
        Reg.Comp_Name = ds.Tables[0].Rows[0]["Comp_Name"].ToString();
        HiddenField1.Value = ds.Tables[0].Rows[0]["Pro_ID"].ToString();
        HiddenField2.Value = ds.Tables[0].Rows[0]["Pro_Name"].ToString();
        HiddenField3.Value = ds.Tables[0].Rows[0]["Comp_Name"].ToString();
        HiddenField10.Value = ds.Tables[0].Rows[0]["Contact_Person"].ToString();
        HiddenField11.Value = ds.Tables[0].Rows[0]["Comp_Email"].ToString();
        hdntaxcompid.Value = ds.Tables[0].Rows[0]["Comp_ID"].ToString();
        NewMsg.Visible = false;
        #endregion
        btnCancel.Visible = true;
        btnYes.Text = "Verify";
        btnNo.Text = "Close";
        txtCancelRemarks.Text = string.Empty;
        Reg.DateFrom = Convert.ToDateTime(Convert.ToDateTime("01/04/" + DataProvider.LocalDateTime.Now.Year).ToString("yyyy/MM/dd"));
        Reg.DateTo = Reg.DateFrom.AddYears(1);
        Reg.DateTo = Reg.DateTo.AddDays(-1);
        DataSet dsn = SQL_DB.ExecuteDataSet("SELECT * FROM Tax_Master_Info WHERE Comp_ID = '" + Reg.Comp_ID + "' AND Pro_ID = '" + Reg.Pro_ID + "' AND (convert(varchar,Date_From,111)='" + Convert.ToDateTime(Reg.DateFrom).ToString("yyyy/MM/dd") + "') AND (convert(varchar,Date_To,111)='" + Convert.ToDateTime(Reg.DateTo).ToString("yyyy/MM/dd") + "') ");
        if (dsn.Tables[0].Rows.Count != 0)
        {
            if (e.CommandName == "VerifySound")
            {
                LabelCalText.Text = "VerifySound";
                LabelAlertheader.Text = "Alert";
                LabelAlertText.Text = "Are you sure to verify Sound file of  product <a style='color:blue;text-decoration:none;' >" + Reg.Pro_Name + " </a>for <a style='color:blue;text-decoration:none;' >" + Reg.Comp_Name + " </a>Company !";
                ModalPopupExtenderAlert.Show();
            }
            else if (e.CommandName == "VerifyDocuments")
            {
                LabelCalText.Text = "VerifyDocuments";
                LabelAlertheader.Text = "Alert";
                LabelAlertText.Text = "Are you sure to verify Documents of  product <a style='color:blue;text-decoration:none;' >" + Reg.Pro_Name + " </a>for <a style='color:blue;text-decoration:none;' >" + Reg.Comp_Name + " </a>Company !";
                ModalPopupExtenderAlert.Show();
            }
        }
        else
        {
            FillTaxDetailsInfo(Reg);
            ModalTaxMaster.Show();
        }
        Reg.Pro_ID = "";
    }

    private void FillTaxDetailsInfo(Object9420 Reg)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Comp_Reg.Comp_ID, Comp_Reg.Comp_Name, Category_Master.Category_Name, Pro_Reg.Dispatch_Location " +
        " FROM         Comp_Reg INNER JOIN Category_Master ON Comp_Reg.Comp_Cat_Id = Category_Master.Category_ID INNER JOIN Pro_Reg ON Comp_Reg.Comp_ID = Pro_Reg.Comp_ID  WHERE Comp_Reg.Comp_ID = '" + Reg.Comp_ID + "' AND Pro_Reg.Pro_ID = '" + LabelProUpId.Text + "'  ");
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlcompidfortax.Text = ds.Tables[0].Rows[0]["Comp_Name"].ToString();
            lblcompcat.Text = ds.Tables[0].Rows[0]["Category_Name"].ToString();
            lblAddress.Text = ds.Tables[0].Rows[0]["Dispatch_Location"].ToString();
            lblpronametax.Text = Reg.Pro_Name;
            hdntaxcompid.Value = Reg.Comp_ID;
        }
    }
    protected void GrdRequestedLabels_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Object9420 Reg = new Object9420();
        lblRequestLabelID.Text = e.CommandArgument.ToString();
        Reg.Status = 0;
        DataSet ds = function9420.FillGrdLabelsRequested(Reg);
        DataView dv = ds.Tables[0].DefaultView;
        dv.RowFilter = "Row_ID = " + Convert.ToInt32(e.CommandArgument.ToString());
        DataTable dt = dv.ToTable();
        #region Some Variables
        hdProductID.Value = dt.Rows[0]["Pro_ID"].ToString();
        hdCompID.Value = dt.Rows[0]["Comp_ID"].ToString();
        hdNoofCodes.Value = dt.Rows[0]["Labels"].ToString();
        Reg.Pro_ID = hdProductID.Value;
        HiddenFieldCompNm.Value = dt.Rows[0]["Comp_Name"].ToString();
        HiddenFieldProNm.Value = dt.Rows[0]["Pro_Name"].ToString();
        HiddenFieldLabelType.Value = dt.Rows[0]["Label_Name"].ToString();
        HdLabelPrice.Value = dt.Rows[0]["Label_Prise"].ToString();
        HiddenTrackingNo.Value = dt.Rows[0]["Tracking_No"].ToString();
        #endregion
        btnCancel.Visible = false;
        btnYes.Text = "Yes";
        btnNo.Text = "No";
        if (e.CommandName == "PrintLabels")
        {
            LogManager.WriteExe("Enter PrintLabels Functions in RowCommond");
            DataSet dsc = SQL_DB.ExecuteDataSet("SELECT * FROM [dbo].[GetAvailableCode] (" + Convert.ToInt32(dt.Rows[0]["Labels"].ToString()) + ")");
            string i4 = dsc.Tables[0].Rows.Count.ToString();
            if (!function9420.chkVerifyDoc(Reg))
            {
                NewMsg.Visible = true;
                NewMsg.Attributes.Add("class", "alert_boxes_pink");
                LblDashBoardmsg.Text = "Product document or sound file are not verified by Admin!";
                string script = @"setTimeout(function(){document.getElementById('" + NewMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
            if (Convert.ToInt64(dt.Rows[0]["Labels"].ToString()) > Convert.ToInt64(i4))
            {
                NewMsg.Visible = true;
                NewMsg.Attributes.Add("class", "alert_boxes_pink");
                LblDashBoardmsg.Text = dt.Rows[0]["Labels"].ToString() + " codes not available in code bank !";
                string script = @"setTimeout(function(){document.getElementById('" + NewMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
            LabelCalText.Text = "PrintLabels";
            LabelAlertheader.Text = "Alert";
            LabelAlertText.Text = "Are you sure to print labels :- <a style='color:blue;text-decoration:none;'>" + dt.Rows[0]["Comp_Name"].ToString() + "</a>  >> <a style='color:blue;text-decoration:none;'>" + dt.Rows[0]["Pro_Name"].ToString() + "</a> >> Type <a style='color:blue;text-decoration:none;'>" + dt.Rows[0]["Label_Name"].ToString() + "</a> >> quantity : <a style='color:blue;text-decoration:none;'>" + dt.Rows[0]["Labels"].ToString() + "</a> labels ?";
            ModalPopupExtenderAlert.Show();
        }
        else if (e.CommandName == "RequestCancel")
        {
            LabelCalText.Text = "RequestCancel";
            LabelAlertheader.Text = "Alert";
            LabelAlertText.Text = "Are you sure to canceled labels :- <a style='color:blue;text-decoration:none;'>" + dt.Rows[0]["Comp_Name"].ToString() + "</a>  >> <a style='color:blue;text-decoration:none;'>" + dt.Rows[0]["Pro_Name"].ToString() + "</a> >> Type <a style='color:blue;text-decoration:none;'>" + dt.Rows[0]["Label_Name"].ToString() + "</a> >> quantity : <a style='color:blue;text-decoration:none;'>" + dt.Rows[0]["Labels"].ToString() + "</a> labels ?";
            ModalPopupExtenderAlert.Show();
        }
    }
    protected void GrdCourierDispatch_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Courier_Disp_ID = e.CommandArgument.ToString();
        if (e.CommandName.ToString() == "ShowDetails")
        {
            FillScrapEntryCourier(Reg);
            ModalPopupScrapDetails.Show();
        }
    }



    protected void btnVerifyPayment_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.User_Type = Session["User_Type"].ToString();
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt"));
        Reg.Comp_ID = Label2.Text; // Comp_ID from Payment Received
        Reg.Row_ID = Label3.Text; // Row_Id from Payment Received
        Reg.Flag = 0;
        function9420.FindDetailsForRequestPayment(Reg);

        #region Code For Account
        double payAmt = 0.0;
        for (int i = 0; i <= GrdVwAmcOffer.Rows.Count - 1; i++)
        {            
            DropDownList ddlpay = (DropDownList)GrdVwAmcOffer.Rows[i].FindControl("ddlpay"); // // Used for Transction Table
            TextBox txtpayAmt = (TextBox)GrdVwAmcOffer.Rows[i].FindControl("txtprices");  // Used for Transction Table
            Label lblManuReqAmt = (Label)GrdVwAmcOffer.Rows[i].FindControl("LblAmcreqAmt");
            Reg.ManuReq_Payment = Convert.ToDouble(lblManuReqAmt.Text);
            Reg.Admin_Remark = null;// ddlpay.SelectedValue.ToString();// txtAmtremarks.Text;
            if (Reg.Admin_Remark == "Block")
                Reg.Status = 0;
            else if (Reg.Admin_Remark == "Continue")
                Reg.Status = 1;
            if (txtpayAmt.Text != "")
                Reg.TRec_Payment = Convert.ToDouble(txtpayAmt.Text);
            else
                Reg.TRec_Payment = 0.00;  
            payAmt += Convert.ToDouble(Reg.TRec_Payment);
        }
        if (payAmt > 0.00)
        {
            Reg.Row_ID = Label3.Text; // Row_Id from Payment Received where action applied
            Reg.Rec_Payment = payAmt;
            Reg.Flag = 1;
            if (payAmt == Convert.ToDouble(hdnManuRequestAmount.Value))
                Reg.Admin_Remark = "Verified all requested amount";
            else
                Reg.Admin_Remark = "Verified Less amount in requested amount";
            function9420.UpdateReceivedPayment(Reg);  // Update Payment_Received Table Data 
            //************ Receipt Report Code Start ***************//
            Reg.FolderPath = Server.MapPath("../Data/Bill");
            Reg.Path = Server.MapPath("../Reports") + "\\PaymentReceipt.rpt";
            GenerateCrystalInvoice.Receipt.showReport(Reg);
            //************ Receipt Report Code End ***************//
        }
        #endregion
        //function9420.Generate_InvoiceAmcOffer(Reg);

        function9420.FillUpDateProfile(Reg);
        NewMsg.Visible = true;
        NewMsg.Attributes.Add("class", "alert_boxes_green");
        LblDashBoardmsg.Text = "Payment receive successfully from  " + Reg.Comp_Name + " Company !";
        FillReqPayment();
        LabelCalText.Text = string.Empty;
        Label2.Text = string.Empty;
        Label3.Text = string.Empty;
        hdnRequestNo.Value = string.Empty;
        hdnManuRequestAmount.Value = string.Empty;
        string script = @"setTimeout(function(){document.getElementById('" + NewMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }
    private void FillVerifyPaymentDetails(Object9420 Reg)
    {
        DataSet ds = function9420.FillAmcOfferDetails(Reg);
        GrdVwAmcOffer.DataSource = ds.Tables[0];
        GrdVwAmcOffer.DataBind();
        if (GrdVwAmcOffer.Rows.Count > 5)
            MyAmcOfferGrdVw.Attributes.Add("style", "height: 200px; overflow: auto;");
    }

    protected void BtnCancelRemark1_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Label2.Text; // Comp_ID from Payment Received
        Reg.Row_ID = Label3.Text; // Row_Id from Payment Received
        Reg.TransRow_ID = Label3.Text;
        Reg.User_Type = Session["User_Type"].ToString();
        Reg.Admin_Remarks = LabelReasonText.Text.Trim().Replace("'", "''");
        Reg.Flag = 0;
        function9420.FindDetailsForRequestPayment(Reg);
        if (Session["User_Type"].ToString() == "Admin")
            Reg.Flag = -1;
        else
            Reg.Flag = 2;
        //function9420.CanceledRequest(Reg); // Old Function for checking
        function9420.CanceledPaymentRequest(Reg);
        function9420.FillUpDateProfile(Reg);
        NewMsg.Visible = true;
        NewMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        LblDashBoardmsg.Text = "Payment request canceled successfully from  <span style='color:blue;' >" + Reg.Comp_Name + " </span> Company !";
        FillReqPayment();
        LabelCalText.Text = string.Empty;
        Label2.Text = string.Empty;
        Label3.Text = string.Empty;
        hdnRequestNo.Value = string.Empty;
        hdnManuRequestAmount.Value = string.Empty;
        string script = @"setTimeout(function(){document.getElementById('" + NewMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }


    #region Tax Master Setting Code
    private void taxtxtclear()
    {
        txtLabelServiceTax.Text = string.Empty; txtLabelVAT.Text = string.Empty; lblAddress.Text = string.Empty; hdntaxcompid.Value = string.Empty; txtOfferVAT.Text = string.Empty; LabelProUpId.Text = string.Empty; txtAmcServiceTax.Text = string.Empty; txtAMCVATx.Text = string.Empty; txtOfferServiceTax.Text = string.Empty;
    }
    protected void btnResetTax_Click(object sender, EventArgs e)
    {
        taxtxtclear();
        ModalTaxMaster.Show();
    }
    protected void btnTaxSetting_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = hdntaxcompid.Value;
        Reg.Pro_ID = LabelProUpId.Text;
        Reg.DateFrom = Convert.ToDateTime(Convert.ToDateTime("01/04/" + DataProvider.LocalDateTime.Now.Year).ToString("yyyy/MM/dd"));
        Reg.DateTo = Reg.DateFrom.AddYears(1);
        Reg.DateTo = Reg.DateTo.AddDays(-1);
        Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        Reg.AMC_ServiceTax = Convert.ToDouble(txtAmcServiceTax.Text);
        Reg.AMC_Vat = Convert.ToDouble(txtAMCVATx.Text);
        Reg.Label_ServiceTax = Convert.ToDouble(txtLabelServiceTax.Text);
        Reg.Label_Vat = Convert.ToDouble(txtLabelVAT.Text);
        Reg.Offer_ServiceTax = Convert.ToDouble(txtOfferServiceTax.Text);
        Reg.Offer_Vat = Convert.ToDouble(txtOfferVAT.Text);
        if (btnTaxSetting.Text == "Save")
        {
            Reg.Row_ID = "";
            Reg.TaxSet_ID = Business9420.function9420.GetLabelCode("TaxSetting");
            Reg.DML = "I";
            Business9420.function9420.TaxMasterSetting(Reg);
            Business9420.function9420.UpdateLabelCode("TaxSetting");
            Reg.statusstr = "saved";
        }
        else
        {
            Reg.DML = "U";
            Reg.TaxSet_ID = lblrowid.Text;
            btnTaxSetting.Text = "Save";
            Business9420.function9420.TaxMasterSetting(Reg);
        }
        //CreateInvoice(Reg); // this is reporting function
        taxtxtclear();
        LabelConfrimText.Text = "Tax Setting <span style='color:blue;'>" + HiddenField3.Value + "</span> >> <span style='color:blue;'>" + HiddenField2.Value + "</span>  has been saved.";
        ModalPopupExtenderConfrim.Show();

    }
    #endregion


    #region Create Invoice
    //private void CreateInvoice(Object9420 Reg)
    //{
    //    DataSet dsn = new DataSet();
    //    dsn = SQL_DB.ExecuteDataSet("SELECT Row_ID FROM M_Amc_Offer WHERE Pro_ID = '" + Reg.Pro_ID + "' ");
    //    for (int t = 0; t < dsn.Tables[0].Rows.Count; t++)
    //    {
    //        Reg.Row_ID = dsn.Tables[0].Rows[t]["Row_ID"].ToString();
    //        Reg.Trans_Type = dsn.Tables[0].Rows[t]["Trans_Type"].ToString();
    //        DataSet ds = new DataSet();
    //        ds = function9420.FillAmcOfferInvoiceDetails(" WHERE M_Amc_Offer.Row_ID = '" + Reg.Row_ID + "'");
    //        if (ds.Tables[0].Rows.Count > 0)
    //        {
    //            for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
    //            {
    //                string Invoice = function9420.GetLabelCode("Invoices");
    //                showReport(Convert.ToInt32(ds.Tables[0].Rows[j]["Row_ID"]), Invoice, Reg.Trans_Type);
    //                function9420.UpdateLabelCode("Invoices");
    //            }
    //        }
    //    }

    //}
    //private void showReport(int Row_ID, string invn, string Trans_Type)
    //{
    //    ReportDocument myreportdocumen = new ReportDocument();
    //    CrystalReportViewer CrystalReportViewer1 = new CrystalReportViewer();
    //    CrystalReportViewer1.DisplayGroupTree = false;
    //    CrystalReportViewer1.DisplayGroupTree = false;
    //    myreportdocumen.Load(Server.MapPath(@"Reports\InvoiceReport.rpt"), CrystalDecisions.Shared.OpenReportMethod.OpenReportByDefault);
    //    myreportdocumen.DataDefinition.FormulaFields["Invoice_No"].Text = "'" + invn + "'";
    //    myreportdocumen.DataDefinition.FormulaFields["Invoice_Date"].Text = "'" + DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy") + "'";
    //    myreportdocumen.DataDefinition.FormulaFields["Row_ID"].Text = "'" + Convert.ToInt32(Row_ID) + "'";
    //    myreportdocumen.DataDefinition.FormulaFields["Trans_Type"].Text = "'" + Trans_Type + " '";
    //    myreportdocumen.SetDatabaseLogon("sa", "infra");
    //    //DataSet ds = new DataSet();
    //    //string Qry = "SELECT  row_number() over(order by m.Row_ID) as ID,m.Row_ID,m.Plan_Name,m.Plan_Amount , m.Date_From, m.Date_To, m.Trans_Type, m.Entry_Date, r.Comp_Name, r.Contact_Person, " +
    //    //              " d.PAN_TAN, d.VAT as VAT_NO, p.Dispatch_Location, t." + Trans_Type + "_Vat , t." + Trans_Type + "_ServiceTax " +
    //    //             " ,ISNULL((SELECT Plan_Discount FROM M_PlanDiscount WHERE  (Plan_ID = m.Plan_ID) AND (Flag = 1) and Trans_Type=m.Trans_Type AND (CONVERT(VARCHAR,GETDATE(),111) BETWEEN CONVERT(VARCHAR, Date_From, 111) AND CONVERT(VARCHAR, Date_To, 111))),0) as Plan_Discount " +
    //    //             " ,CONVERT(NUMERIC(18,2),((m.Plan_Amount * t." + Trans_Type + "_ServiceTax)/100)) AS STAX,CONVERT(NUMERIC(18,2),((m.Plan_Amount * t." + Trans_Type + "_Vat)/100)) AS VTAX " +
    //    //             " ,CONVERT(NUMERIC(18,2),(((m.Plan_Amount * t." + Trans_Type + "_ServiceTax)/100) + ((m.Plan_Amount * t." + Trans_Type + "_Vat)/100) + m.Plan_Amount)) AS Admin_Balance " +
    //    //             "  FROM         M_Amc_Offer AS m INNER JOIN " +
    //    //              " Comp_Reg AS r ON m.Comp_ID = r.Comp_ID INNER JOIN  " +
    //    //             "  Comp_Document AS d ON r.Comp_ID = d.Comp_ID INNER JOIN  " +
    //    //              " Pro_Reg AS p ON m.Pro_ID = p.Pro_ID INNER JOIN " +
    //    //              " Tax_Master_Info AS t ON r.Comp_ID = t.Comp_ID   Row_ID='" + Convert.ToInt32(Row_ID) + "' AND  Trans_Type = '" + Trans_Type + "'  ";
    //    ////string Qry = "select * from vw_Invoice where Row_ID='" + Convert.ToInt32(Row_ID) + "' AND  Trans_Type = '" + Trans_Type + "' ";
    //    //SQL_DB.GetDA(Qry).Fill(ds, "1");
    //    //if (ds.Tables["1"].Rows.Count > 0)
    //    //    myreportdocumen.SetDataSource(ds.Tables["1"]);
    //    CrystalReportViewer1.ReportSource = myreportdocumen;
    //    CrystalReportViewer1.DataBind();
    //    CrystalReportViewer1.Visible = false;
    //    ExportOptions CrExportOptions1;
    //    DiskFileDestinationOptions CrDiskFileDestinationOptions1 = new DiskFileDestinationOptions();
    //    PdfRtfWordFormatOptions CrFormatTypeOptions1 = new PdfRtfWordFormatOptions();
    //    string pt = Server.MapPath("../Data/Bill") + "\\Invoice";
    //    if (!Directory.Exists(pt))
    //        Directory.CreateDirectory(pt);
    //    CrDiskFileDestinationOptions1.DiskFileName = pt + "\\" + Row_ID.ToString() + ".pdf";
    //    CrExportOptions1 = myreportdocumen.ExportOptions;
    //    {
    //        CrExportOptions1.ExportDestinationType = ExportDestinationType.DiskFile;
    //        CrExportOptions1.ExportFormatType = ExportFormatType.PortableDocFormat;
    //        CrExportOptions1.DestinationOptions = CrDiskFileDestinationOptions1;
    //        CrExportOptions1.FormatOptions = CrFormatTypeOptions1;
    //    }
    //    myreportdocumen.Export();
    //}
    #endregion

    #region Interested as Demo
    private void FillInterestedAsDemo()
    {
        DataSet ds = new DataSet();
        #region
        string Qty = "SELECT Row_ID, Comp_Name, Comp_Email, Contact_Person, Mobile_No, Reg_Date, case when Status = 0 then 'Not View & Contact'  when Status = 1 then 'Already View & Contact' else 'Cancelled' end ReqStFlag, Status, Contact_Flag FROM Interested_Demo WHERE Status = 0 ";
        #endregion
        SQL_DB.GetDA(Qty).Fill(ds, "1");
        lblInterested.Text = ds.Tables["1"].Rows.Count.ToString();
        if (ds.Tables["1"].Rows.Count > 0)
            GrdProductMaster.PageSize = ds.Tables["1"].Rows.Count;
        else
            GrdProductMaster.PageSize = 10;
        GrdVwInterested.DataSource = ds.Tables["1"];
        GrdVwInterested.DataBind();
        alertCount += ds.Tables[0].Rows.Count;
    }
    protected void RefreshInterested_Click(object sender, ImageClickEventArgs e)
    {
        FillInterestedAsDemo();
    }
    protected void GrdVwInterested_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string script = "";
        NewMsg.Visible = true;
        NewMsg.Attributes.Add("class", "alert_boxes_pink");
        if (e.CommandName == "IntReqAccept")
        {
            SQL_DB.ExecuteNonQuery("UPDATE  Interested_Demo SET Status = 1 WHERE Row_ID = '"+ e.CommandArgument.ToString() +"'  ");            
            LblDashBoardmsg.Text = " Interested Request has been accepted successfully !";          
        }
        else if (e.CommandName == "IntReqCancel")
        {
            SQL_DB.ExecuteNonQuery("UPDATE  Interested_Demo SET Status = -1 WHERE Row_ID = '"+ e.CommandArgument.ToString() +"'  ");            
            LblDashBoardmsg.Text = " Interested Request has been camcelled successfully !";                                  
        }
        script = @"setTimeout(function(){document.getElementById('" + NewMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);  
        FillInterestedAsDemo();
    }
    #endregion
}
