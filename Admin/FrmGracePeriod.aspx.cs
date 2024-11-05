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

public partial class FrmGracePeriod : System.Web.UI.Page
{
    public string srt = DataProvider.Utility.FindMailBody();
    public int upofindex = 0, flag = 0, index = 0, IsCancel=0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            FillCompany();
    }
    private void FillCompany()
    {
        DataSet ds = Business9420.function9420.FillAllComp();
        if (ds.Tables[0].Rows.Count > 0)
        {
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", ddlComapany, "--Select Company--");
            ddlComapany.SelectedIndex = 0;
        }
        else
        {
            ddlComapany.Items.Clear();
            ddlComapany.Items.Insert(0, "--Select Company--");
            ddlComapany.SelectedIndex = 0;
        }
        ddlProducts.Items.Clear();
        ddlProducts.Items.Insert(0, "--Select Product--");
    }
    protected void ddlComapany_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillProducts();
        if (ddlProducts.SelectedIndex > 0)
            SearchData();
    }
    protected void ddlProducts_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlProducts.SelectedIndex > 0)
            SearchData();
    }
    private void FillProducts()
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Row_ID, Comp_ID, Pro_ID, Pro_Entry_Date, Pro_Name, Update_Flag FROM  Pro_Reg WHERE Comp_ID='" + ddlComapany.SelectedValue.ToString() + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProducts, "--Select Product--");
            ddlProducts.SelectedIndex = 0;
        }
        else
        {
            ddlProducts.Items.Clear();
            ddlProducts.Items.Insert(0, "--Select Product--");
        }
    }
    private void SearchData()
    {
        if (ddlProducts.SelectedIndex > 0)
        {
            Object9420 Reg = new Object9420();
            Reg.Pro_ID = ddlProducts.SelectedValue.ToString();
            Reg.Amt_Type = ddltType.SelectedValue.ToString();
            if (Reg.Amt_Type == "Offer")
                GrdProductsAmc.Columns[0].HeaderText = "Offer Name";
            else
                GrdProductsAmc.Columns[0].HeaderText = "Amc Name";
            FillProductAmcAmount(Reg, GrdProductsAmc);
        }
    }
    private void FillProductAmcAmount(Object9420 Reg, GridView GrdVw)
    {
        Reg.chkstr = " Manu_Balance ";
        Reg.Comp_ID = SQL_DB.ExecuteScalar("SELECT Comp_ID FROM Pro_Reg WHERE Pro_ID = '" + Reg.Pro_ID + "' ").ToString(); //Session["CompanyId"].ToString();
        DataSet ds = function9420.FillProductAmcAmount(Reg);
        DataView dv = new DataView();
        dv = ds.Tables[0].DefaultView;
        dv.RowFilter = "Pro_ID = '" + Reg.Pro_ID + "'";
        DataTable dt = dv.ToTable();
        GrdVw.DataSource = dt;
        GrdVw.DataBind();
        FillGridColor(GrdVw);
    }
    private void FillGridColor(GridView GrdVw)
    {
        for (int i = 0; i < GrdVw.Rows.Count; i++)
        {
            if (GrdVw.DataKeys[i]["IsCancel"].ToString() == "0")
            {
                System.Drawing.Color col = System.Drawing.Color.FromName("#FCEEEE");
                GrdVw.Rows[i].BackColor = col;
            }
            else if (GrdVw.DataKeys[i]["IsCancel"].ToString() == "1")
            {
                System.Drawing.Color col = System.Drawing.Color.FromName("#E2FBED");
                GrdVw.Rows[i].BackColor = col;
            }
        }
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
    }
    protected void GrdProductsAmc_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {

            #region
            GridViewRow gvr = (GridViewRow)((ImageButton)e.CommandSource).NamingContainer;
            currindex.Value = gvr.RowIndex.ToString();
            Object9420 Amc = new Object9420();
            string[] Arr = e.CommandArgument.ToString().Split('-');
            HdnUpdatePlanID.Value = Arr[1].ToString();
            HdnUpdatePlanType.Value = Arr[2].ToString();
            HdnUpdatePlanTransID.Value = Arr[0].ToString();
            Amc.Trans_Type = Arr[2].ToString();
            Amc.Row_ID = Arr[0].ToString();
            if (Arr[2].ToString() == "AMC")
                Session["Plan_ID"] = Arr[1].ToString();
            else if (Arr[2].ToString() == "Offer")
                Session["PromoId"] = Arr[1].ToString();
            Amc.Pro_ID = ddlProducts.SelectedValue.ToString();
            Business9420.function9420.FillData(Amc);
            hdndtfrom.Value = Amc.DateFromChk.ToString();
            hdndtto.Value = Amc.DateToChk.ToString();
            #endregion
            if (Amc.Status == -1)
            {
                NewMsgpop.Visible = true;
                NewMsgpop.Attributes.Add("class", "alert_boxes_pink big_msg");
                Label2.Text = "Action is not allowed, This plan has been expired on  " + Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
            }
            else
            {
                #region
                if (e.CommandName.ToString() == "GivenGPPlan")
                {
                    LabelExectute.Text = e.CommandName.ToString();
                    Table3.Visible = false;
                    details.Visible = true;
                    Table1.Visible = false;
                    txtforgp.Text = string.Empty;
                    remarks.Visible = true;
                    txtremarks.Text = string.Empty;
                    GPHeadLabel.Text = "Product (<span style='color:blue;'>" + Amc.Pro_Name + "</span>)";
                    lblstdate.Text = Convert.ToDateTime(Amc.DateFromChk).ToString("dd/MM/yyyy");
                    lblenddate.Text = Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
                    ModalPopupForGp.Show();
                }
                else if (e.CommandName.ToString() == "CancelPlan")
                {
                    LabelExectute.Text = e.CommandName.ToString();
                    details.Visible = false;
                    Table3.Visible = false;
                    Table1.Visible = true;
                    txtforgp.Text = string.Empty;
                    txtremarks.Text = string.Empty;
                    remarks.Visible = true;
                    GPHeadLabel.Text = "Product (<span style='color:blue;'>" + Amc.Pro_Name + "</span>)";
                    lblMsgAlert.Text = "Are you sure to cancelled <span style='color:blue;'>" + Amc.Pro_Name + "</span> >> this " + ddltType.SelectedValue + " with Invoice";
                    lblstdate.Text = Convert.ToDateTime(Amc.DateFromChk).ToString("dd/MM/yyyy");
                    lblenddate.Text = Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
                    ModalPopupForGp.Show();
                }
                else if (e.CommandName.ToString() == "ActivePlan")
                {
                    LabelExectute.Text = e.CommandName.ToString();
                    details.Visible = false;
                    Table3.Visible = false;
                    Table1.Visible = true;
                    txtforgp.Text = string.Empty;
                    txtremarks.Text = string.Empty;
                    remarks.Visible = false;
                    GPHeadLabel.Text = "Product (<span style='color:blue;'>" + Amc.Pro_Name + "</span>)";
                    lblMsgAlert.Text = "Are you sure to Active " + ddltType.SelectedValue + " for Product <span style='color:blue;'>" + Amc.Pro_Name + "</span> ";
                    lblstdate.Text = Convert.ToDateTime(Amc.DateFromChk).ToString("dd/MM/yyyy");
                    lblenddate.Text = Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
                    ModalPopupForGp.Show();
                }
                else if (e.CommandName.ToString() == "DeActivePlan")
                {
                    LabelExectute.Text = e.CommandName.ToString();
                    details.Visible = false;
                    Table3.Visible = false;
                    Table1.Visible = true;
                    txtforgp.Text = string.Empty;
                    remarks.Visible = false;
                    txtremarks.Text = string.Empty;
                    GPHeadLabel.Text = "Product (<span style='color:blue;'>" + Amc.Pro_Name + "</span>)";
                    lblMsgAlert.Text = "Are you sure to De-Active  " + ddltType.SelectedValue + "  for Product <span style='color:blue;'>" + Amc.Pro_Name + "</span> ";
                    lblstdate.Text = Convert.ToDateTime(Amc.DateFromChk).ToString("dd/MM/yyyy");
                    lblenddate.Text = Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
                    ModalPopupForGp.Show();
                }
                else if (e.CommandName.ToString() == "DateExtention")
                {
                    LabelExectute.Text = e.CommandName.ToString();
                    details.Visible = false;
                    Table3.Visible = true;
                    Table1.Visible = false;
                    txtforgp.Text = string.Empty;
                    txtremarks.Text = string.Empty;
                    remarks.Visible = true;
                    GPHeadLabel.Text = "Product (<span style='color:blue;'>" + Amc.Pro_Name + "</span>)";
                    txtstdate.Text = Convert.ToDateTime(Amc.DateFromChk).ToString("dd/MM/yyyy");
                    txtenddate.Text = Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
                    ModalPopupForGp.Show();
                }
                #endregion
                else if (e.CommandName.ToString() == "UpgradePlan")
                {
                    if (Amc.Trans_Type.ToString() == "AMC")
                    {
                        #region
                        //btnAmcRenewal.Visible = true;
                        //btnAmcRenewal.Text = "Update";
                        //btnOfferRenewal.Visible = false;
                        //MyAmcOfferGrdVw.Visible = true;
                        //MyOfferGrdVw.Visible = false;
                        //lblAmcText.Visible = true;
                        //lblOfferText.Visible = false;
                        //lblAmcText.Visible = true;
                        //lblAmcenddate.Text = Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
                        //FillPlanGrdAmcRenewal(0);
                        //txtdttoamc1.Text = Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
                        //txtdtfromamc1.Text = Convert.ToDateTime(Amc.DateFromChk).ToString("dd/MM/yyyy");
                        #endregion
                    }
                    else if (Amc.Trans_Type.ToString() == "Offer")
                    {
                        #region
                        string path = "../Data/Sound";
                        //path = Server.MapPath("../Data/Sound");
                        path = path + "\\" + Amc.Comp_ID.ToString().Substring(5, 4) + "\\" + Amc.Pro_ID + "\\" + Amc.TransRow_ID;
                        //DataProvider.Utility.CreateDirectory(path);
                        ////btnOfferRenewal.Visible = true;
                        ////if (Convert.ToInt32(Amc.Status) == 0)
                        ////    btnOfferRenewal.Text = "Update";
                        ////else if (Convert.ToInt32(Amc.Status) == 1)
                        ////{
                        ////    btnOfferRenewal.Text = "Upgrade";
                        ////    txtdtfromamc3.Enabled = false;
                        ////}
                        ////else
                        ////    btnOfferRenewal.Text = "Renewal";
                        ////btnAmcRenewal.Visible = false;
                        ////MyAmcOfferGrdVw.Visible = false;
                        ////MyOfferGrdVw.Visible = true;
                        ////lblAmcText.Visible = false;
                        ////lblOfferText.Visible = true;
                        ////A1.Attributes.Add("style", "display:block;");
                        ////A1.HRef = path + "\\" + Amc.TransRow_ID + "_H.wav";
                        ////A2.Attributes.Add("style", "display:block;");
                        ////A2.HRef = path + "\\" + Amc.TransRow_ID + "_E.wav";
                        ////txtComment.Text = Amc.Comment_Txt;
                        ////lblOfferText.Visible = true;
                        ////lblOfferenddate.Text = Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
                        //////FillPlanGrdAmcRenewal(0);
                        ////FillGridChkPromotional(0, GrdVwOfferDetails);
                        ////txtdttoamc3.Text = Convert.ToDateTime(Amc.DateToChk).ToString("dd/MM/yyyy");
                        ////txtdtfromamc3.Text = Convert.ToDateTime(Amc.DateFromChk).ToString("dd/MM/yyyy");
                        ////CheckValidation(true);
                        #endregion
                    }
                }
                //ModalPopupAmcRenewal.Show();
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message.ToString());
        }
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        NewMsgpop.Visible = false;
        SearchData();
    }

    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        NewMsgpop.Visible = false;
        SearchData();
    }

    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        NewMsgpop.Visible = false;
        SearchData();
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        if (LabelExectute.Text.ToString() == "GivenGPPlan")
        {
            DateTime Dto = Convert.ToDateTime(lblenddate.Text);
            int oldgpDays = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT isnull(SUM(Days),0) FROM M_Amc_Offer_Grace_Period_Log WHERE Amc_Offer_ID = '" + HdnUpdatePlanTransID.Value + "' "));
            Dto = Dto.AddDays(Convert.ToInt32(txtforgp.Text) + Convert.ToInt32(oldgpDays));

            //******************* Pending Work *************//

            // this code manage using with procedure


            // check include this section for end date is not include this offer/AMC


            SQL_DB.ExecuteNonQuery("UPDATE [M_Amc_Offer] SET [Date_To] = '" + Convert.ToDateTime(Dto).ToString("yyyy/MM/dd") + "'  WHERE [Plan_ID] = '" + HdnUpdatePlanID.Value + "' AND [Trans_Type] = '" + HdnUpdatePlanType.Value + "' AND [Amc_Offer_ID]='" + HdnUpdatePlanTransID.Value + "' ");
            SQL_DB.ExecuteNonQuery("INSERT INTO [M_Amc_Offer_Log]([Amc_Offer_ID],[Date_From],[Date_To],[Entry_Date],[Manage_By],[Trans_Type],[Remarks]) VALUES ('" + HdnUpdatePlanTransID.Value + "','" + Convert.ToDateTime(lblstdate.Text).ToString("yyyy/MM/dd") + "','" + Convert.ToDateTime(Dto).ToString("yyyy/MM/dd") + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "','" + Session["User_Type"].ToString() + "','" + DataProvider.TransType.Given_Grace_Period.ToString() + "','" + txtremarks.Text.Trim().Replace("'", "''") + "')");
            SQL_DB.ExecuteNonQuery("INSERT INTO [M_Amc_Offer_Grace_Period_Log]([Amc_Offer_ID],[Days],[Manage_By],[Remarks]) VALUES ('" + HdnUpdatePlanTransID.Value + "'," + Convert.ToInt32(txtforgp.Text) + ",'" + Session["User_Type"].ToString() + " ( " + DataProvider.TransType.Given_Grace_Period.ToString() + ")','" + txtremarks.Text.Trim().Replace("'", "''") + "')");


            txtforgp.Text = string.Empty;
            txtremarks.Text = string.Empty;
        }
        else if (LabelExectute.Text.ToString() == "CancelPlan")
        {
            Object9420 Reg = new Object9420();
            Reg.Comp_ID = ddlComapany.SelectedValue.ToString();
            Reg.Pro_ID = ddlProducts.SelectedValue.ToString();
            Reg.Head_Name = ddltType.SelectedValue.ToString();
            Reg.Cancelled_By = Session["User_Type"].ToString() + " ( " + DataProvider.TransType.Cancelled.ToString() + ")";
            Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            Reg.Remarks = txtremarks.Text.Trim().Replace("'", "''");
            Reg.Head_ID = HdnUpdatePlanTransID.Value.ToString();
            function9420.CancelledAmcOfferPlan(Reg);

            //SQL_DB.ExecuteNonQuery("UPDATE [M_Amc_Offer] SET [IsCancel] =  0 WHERE Amc_Offer_ID = '" + HdnUpdatePlanTransID.Value + "' ");
            //SQL_DB.ExecuteNonQuery("INSERT INTO [M_Amc_Offer_Cancelled] ([Amc_Offer_ID],[Entry_Date],[Cancelled_By],[Remarks])  VALUES ('" + HdnUpdatePlanTransID.Value + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "','" + Session["User_Type"].ToString() + " ( " + DataProvider.TransType.Cancelled.ToString() + " )','" + txtremarks.Text.Trim().Replace("'", "''") + "') ");


            //// code manage for camcelled Invoice

        }
        else if (LabelExectute.Text.ToString() == "ActivePlan")
        {
            #region Mail Code
            SQL_DB.ExecuteNonQuery("UPDATE [M_Amc_Offer] SET [Status] =  1 WHERE Amc_Offer_ID = '" + HdnUpdatePlanTransID.Value + "' ");
            Object9420 Log = new Object9420();
            DataTable dt = new DataTable();
            SQL_DB.GetDA("SELECT [Amc_Offer_ID],[Pro_ID],[Plan_ID],[Comp_ID],(SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = M_Amc_Offer.Pro_ID) as Pro_Name,[Plan_Name],[Plan_Amount],[Date_From],[Date_To],[Trans_Type],[Plan_Discount],[Comments]  FROM [tauseef_L9420].[dbo].[M_Amc_Offer] WHERE Amc_Offer_ID = '" + HdnUpdatePlanTransID.Value + "' ").Fill(dt);
            Log.Comp_ID = dt.Rows[0]["Comp_ID"].ToString();
            function9420.FillUpDateProfile(Log);
            string MailBody = "";
            if (dt.Rows[0]["Trans_Type"].ToString() == "AMC")
            {
                #region mail
                int tt = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT Plan_Time FROM  M_Plan where Plan_ID='" + dt.Rows[0]["Plan_ID"].ToString() + "'"));
                MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
                " <hr style='border:1px solid #2587D5;'/>" +
                " <div class='w_frame'>" +
                " <p>" +
                " <div class='w_detail'>" +
                " <span>Dear <em><strong>" + Log.Contact_Person + ",</strong></em></span><br />" +
                " <br />" +
                " <span>For Product <b>" + dt.Rows[0]["Pro_Name"].ToString() + "</b> Following periodic maintenance cost option selected by you is live as per following details. </span>" +
                " <br />" +
                " <br />" +
                " <span> AMC Plan Name : " + dt.Rows[0]["Plan_Name"].ToString() + "</span>" +
                " <br />" +
                " <span> Plan Cost : " + dt.Rows[0]["Plan_Amount"].ToString() + "</span>" +
                " <br />" +
                " <span> Plan Period : " + tt.ToString() + " Months</span>" +
                " <br />" +
                " <span> Start Date : " + Convert.ToDateTime(dt.Rows[0]["Date_From"]).ToString("MMM dd , yyyy") + "</span>" +
                " <br />" +
                " <span> End Date : " + Convert.ToDateTime(dt.Rows[0]["Date_To"]).ToString("MMM dd , yyyy") + "</span>" +
                " <br />" +
                " <div class='w_detail'><br /><br />" +
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
            }
            else
            {
                #region mail
                int tt = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT Time_Days FROM  M_Promotional where Promo_ID='" + dt.Rows[0]["Plan_ID"].ToString() + "'"));
                MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
                " <hr style='border:1px solid #2587D5;'/>" +
                " <div class='w_frame'>" +
                " <p>" +
                " <div class='w_detail'>" +
                " <span>Dear <em><strong>" + Log.Contact_Person + ",</strong></em></span><br />" +
                " <br />" +
                " <span>For Product <b>" + dt.Rows[0]["Pro_Name"].ToString() + "</b> Following MSG for Buyer plan selected by you is live as per following details. </span>" +
                " <br />" +
                " <br />" +
                " <span> MSG for Buyer Plan Name : " + dt.Rows[0]["Plan_Name"].ToString() + "</span>" +
                " <br />" +
                " <span> Plan Cost : " + dt.Rows[0]["Plan_Amount"].ToString() + "</span>" +
                " <br />" +
                " <span> Plan Period : " + tt.ToString() + " Days</span>" +
                " <br />" +
                " <span> Start Date : " + Convert.ToDateTime(dt.Rows[0]["Date_From"]).ToString("MMM dd , yyyy") + "</span>" +
                " <br />" +
                " <span> End Date : " + Convert.ToDateTime(dt.Rows[0]["Date_To"]).ToString("MMM dd , yyyy") + "</span>" +
                " <br />" +
                " <span> Comments Line : " + dt.Rows[0]["Comments"].ToString() + "</span>" +
                " <br />" +
                " <span> Sound File in Hindi : <a href='"+ ProjectSession.absoluteSiteBrowseUrl +"/Sound/" + dt.Rows[0]["Comp_ID"].ToString().Substring(5, 4) + "/" + dt.Rows[0]["Pro_ID"].ToString() + "/" + HdnUpdatePlanTransID.Value + "/" + HdnUpdatePlanTransID.Value + "_H.wav ' target='_blank' >Click For Play Sound in Hindi</a></span>" +
                " <br />" +
                " <span> Sound File in English : <a href='"+ ProjectSession.absoluteSiteBrowseUrl +"/Sound/" + dt.Rows[0]["Comp_ID"].ToString().Substring(5, 4) + "/" + dt.Rows[0]["Pro_ID"].ToString() + "/" + HdnUpdatePlanTransID.Value + "/" + HdnUpdatePlanTransID.Value + "_E.wav ' target='_blank' >Click For Play Sound in English</a></span>" +
                " <br />" +
                " <div class='w_detail'><br /><br />" +
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
            }
            #region Mail Body                  
            #endregion
            //string MailBody1 = DataProvider.Utility.FindMailBody(Session["Comp_Name"].ToString(), "Sales department", "documents has been uploaded successfully and pending for verification.");
            //string MailBody2 = DataProvider.Utility.FindMailBody(Session["Comp_Name"].ToString(), "Lagal department", "documents has been uploaded successfully and pending for verification.");

            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Log.Comp_Email, MailBody, dt.Rows[0]["Trans_Type"].ToString()+" Activated");
                //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Document verification pending");
                //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), "legal@label9420.com", MailBody2, "Document verification pending");
            }
            #endregion
        }
        else if (LabelExectute.Text.ToString() == "DeActivePlan")
        {   
            #region Mail Code
            SQL_DB.ExecuteNonQuery("UPDATE [M_Amc_Offer] SET [Status] =  0 WHERE Amc_Offer_ID = '" + HdnUpdatePlanTransID.Value + "' ");
            Object9420 Log = new Object9420();            
            DataTable dt = new DataTable();
            SQL_DB.GetDA("SELECT [Amc_Offer_ID],[Pro_ID],[Plan_ID],[Comp_ID],(SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = M_Amc_Offer.Pro_ID) as Pro_Name,[Plan_Name],[Plan_Amount],[Date_From],[Date_To],[Trans_Type],[Plan_Discount],[Comments]  FROM [tauseef_L9420].[dbo].[M_Amc_Offer] WHERE Amc_Offer_ID = '" + HdnUpdatePlanTransID.Value + "' ").Fill(dt);
            Log.Comp_ID = dt.Rows[0]["Comp_ID"].ToString();
            function9420.FillUpDateProfile(Log);
            string MailBody = "";
            if (dt.Rows[0]["Trans_Type"].ToString() == "AMC")
            {
                #region mail
                int tt = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT Plan_Time FROM  M_Plan where Plan_ID='" + dt.Rows[0]["Plan_ID"].ToString() + "'"));
                MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
                " <hr style='border:1px solid #2587D5;'/>" +
                " <div class='w_frame'>" +
                " <p>" +
                " <div class='w_detail'>" +
                " <span>Dear <em><strong>" + Log.Contact_Person + ",</strong></em></span><br />" +
                " <br />" +
                " <span>For Product <b>" + dt.Rows[0]["Pro_Name"].ToString() + "</b> Following periodic maintenance cost option selected by you is live as per following details. </span>" +
                " <br />" +
                " <br />" +
                " <span> AMC Plan Name : " + dt.Rows[0]["Plan_Name"].ToString() + "</span>" +
                " <br />" +
                " <span> Plan Cost : " + dt.Rows[0]["Plan_Amount"].ToString() + "</span>" +
                " <br />" +
                " <span> Plan Period : " + tt.ToString() + " Months</span>" +
                " <br />" +
                " <span> Start Date : " + Convert.ToDateTime(dt.Rows[0]["Date_From"]).ToString("MMM dd , yyyy") + "</span>" +
                " <br />" +
                " <span> End Date : " + Convert.ToDateTime(dt.Rows[0]["Date_To"]).ToString("MMM dd , yyyy") + "</span>" +
                " <br />" +
                " <div class='w_detail'><br /><br />" +
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
            }
            else
            {
                #region mail
                int tt = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT Time_Days FROM  M_Promotional where Promo_ID='" + dt.Rows[0]["Plan_ID"].ToString() + "'"));
                MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
                " <hr style='border:1px solid #2587D5;'/>" +
                " <div class='w_frame'>" +
                " <p>" +
                " <div class='w_detail'>" +
                " <span>Dear <em><strong>" + Log.Contact_Person + ",</strong></em></span><br />" +
                " <br />" +
                " <span>For Product <b>" + dt.Rows[0]["Pro_Name"].ToString() + "</b> Following MSG for Buyer plan selected by you is live as per following details. </span>" +
                " <br />" +
                " <br />" +
                " <span> MSG for Buyer Plan Name : " + dt.Rows[0]["Plan_Name"].ToString() + "</span>" +
                " <br />" +
                " <span> Plan Cost : " + dt.Rows[0]["Plan_Amount"].ToString() + "</span>" +
                " <br />" +
                " <span> Plan Period : " + tt.ToString() + " Days</span>" +
                " <br />" +
                " <span> Start Date : " + Convert.ToDateTime(dt.Rows[0]["Date_From"]).ToString("MMM dd , yyyy") + "</span>" +
                " <br />" +
                " <span> End Date : " + Convert.ToDateTime(dt.Rows[0]["Date_To"]).ToString("MMM dd , yyyy") + "</span>" +
                " <br />" +
                " <span> Comments Line : " + dt.Rows[0]["Comments"].ToString() + "</span>" +
                " <br />" +
                " <span> Sound File in Hindi : <a href='"+ ProjectSession.absoluteSiteBrowseUrl +"/Sound/" + dt.Rows[0]["Comp_ID"].ToString().Substring(5, 4) + "/" + dt.Rows[0]["Pro_ID"].ToString() + "/"+ HdnUpdatePlanTransID.Value+"/" + HdnUpdatePlanTransID.Value + "_H.wav ' target='_blank' >Click For Play Sound in Hindi</a></span>" +
                " <br />" +
                " <span> Sound File in English : <a href='"+ ProjectSession.absoluteSiteBrowseUrl +"/Sound/" + dt.Rows[0]["Comp_ID"].ToString().Substring(5, 4) + "/" + dt.Rows[0]["Pro_ID"].ToString() + "/" + HdnUpdatePlanTransID.Value + "/" + HdnUpdatePlanTransID.Value + "_E.wav ' target='_blank' >Click For Play Sound in English</a></span>" +
                " <br />" +
                " <div class='w_detail'><br /><br />" +
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
            }
            #region Mail Body            
            #endregion
            //string MailBody1 = DataProvider.Utility.FindMailBody(Session["Comp_Name"].ToString(), "Sales department", "documents has been uploaded successfully and pending for verification.");
            //string MailBody2 = DataProvider.Utility.FindMailBody(Session["Comp_Name"].ToString(), "Lagal department", "documents has been uploaded successfully and pending for verification.");

            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Log.Comp_Email, MailBody, dt.Rows[0]["Trans_Type"].ToString()+"  De-Activated");
                //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Document verification pending");
                //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), "legal@label9420.com", MailBody2, "Document verification pending");
            }
            #endregion
        }
        else if (LabelExectute.Text.ToString() == "DateExtention")
        {
            DateTime EndDate = new DateTime();
            DateTime D1 = Convert.ToDateTime(Convert.ToDateTime(hdndtfrom.Value).ToString("yyyy/MM/dd"));
            DateTime D2 = Convert.ToDateTime(Convert.ToDateTime(txtstdate.Text).ToString("yyyy/MM/dd"));
            if (D2 >= D1)
            {
                TimeSpan t = D2 - D1;
                int days = t.Days;
                EndDate = Convert.ToDateTime(hdndtfrom.Value).AddDays(days);
            }
            else
            {
                TimeSpan t = D1 - D2;
                int ddays = t.Days;
                EndDate = Convert.ToDateTime(hdndtfrom.Value).AddDays(-ddays);
            }
            SQL_DB.ExecuteNonQuery("UPDATE [M_Amc_Offer] SET [Date_From] = '" + Convert.ToDateTime(txtstdate.Text).ToString("yyyy/MM/dd") + "' , [Date_To] = '" + Convert.ToDateTime(EndDate).ToString("yyyy/MM/dd") + "'  WHERE Amc_Offer_ID = '" + HdnUpdatePlanTransID.Value + "' ");
            SQL_DB.ExecuteNonQuery("INSERT INTO [M_Amc_Offer_Log]([Amc_Offer_ID],[Date_From],[Date_To],[Entry_Date],[Manage_By],[Trans_Type],[Remarks]) VALUES ('" + HdnUpdatePlanTransID.Value + "','" + Convert.ToDateTime(txtstdate.Text).ToString("yyyy/MM/dd") + "','" + Convert.ToDateTime(EndDate).ToString("yyyy/MM/dd") + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "','" + Session["User_Type"].ToString() + "','" + DataProvider.TransType.Date_Extention.ToString() + "','" + txtremarks.Text.Trim().Replace("'", "''") + "')");
            //SQL_DB.ExecuteNonQuery("INSERT INTO [M_Amc_Offer_Cancelled] ([Amc_Offer_ID],[Entry_Date],[Cancelled_By],[Remarks])  VALUES ('" + HdnUpdatePlanTransID.Value + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "','" + Session["User_Type"].ToString() + " ( " + DataProvider.TransType.Cancelled.ToString() + " )','" + txtremarks.Text.Trim().Replace("'", "''") + "') ");
        }
        SearchData();
    }
}
