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
using System.Web.Services;
using System.Web.Script.Services;

public partial class BrandLoyalty : System.Web.UI.Page
{
    public int c = 0, str = 0, upplanindex = 0, upamcindex = 0, upofindex = 0, index = 0, pindex = 0, planindex = 0, Disp = 0, promoDisp = 0, dispindex = 0, promoind = 0; public string TransType = "", Comptype = "", LCode = "", PlanID = "", PromoID = ""; public bool LabelFlag = false;
    public int CntDays = 0, IsActive = 0;
    public string srt = DataProvider.Utility.FindMailBody();
    protected void Page_Load(object sender, EventArgs e)
    {        
        if (Session["CompanyId"] == null)
            Response.Redirect("../Info/Login.aspx?Page=BrandLoyalty.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!Page.IsPostBack)
        {
            hhdnCompID.Value = Session["CompanyId"].ToString().Substring(5, 4);
            Session["Path"] = Server.MapPath("../Data/Sound");
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            if (Session["Comp_type"].ToString() == "D")
                imgNew.Visible = false;
            else
                imgNew.Visible = true;
            filldata(); 
            NewMsgpop.Visible = false;
        }
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
    private void ClearText()
    {
        DivMsg.Visible = false;
        txtfrequency.Text = string.Empty;
        hdnpointsval.Value = string.Empty;
        ChangeUpdateFields(true);
        ChnageValidation(true);
        txtloyaltydtfrom.Text = string.Empty;
        txtloyaltydtto.Text = string.Empty;
        txtloyaltypoints.Text = string.Empty;
        txtProductName.Text = string.Empty;            
        ddlProduct.SelectedIndex = 0;
        txtCommentsTxt.Text = string.Empty;
        chkconvert.Checked = false;
        txtDateFrom.Text = string.Empty;
        txtDateTo.Text = string.Empty;
        filldata();
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        ClearText(); NewMsgpop.Visible = false;        
        fillProductLoyalty(true);
        if (ddlProduct.SelectedIndex > 0)
        {
            DataTable ddt = SQL_DB.ExecuteDataSet("SELECT RowId, Comp_ID, Pro_ID, Points,IsCashConvert, DateFrom, DateTo, IsActive, IsDelete FROM M_Loyalty WHERE Pro_ID = '" + ddlProduct.SelectedValue.ToString() + "' ").Tables[0];
            if (ddt.Rows.Count > 0)
            {
                chkloyalty.Checked = true;
                if (Convert.ToInt32(ddt.Rows[0]["IsCashConvert"]) == 0)
                    chkconvert.Checked = true;
                else
                    chkconvert.Checked = false;
                hdnloyalty.Value = ddt.Rows[0]["Pro_ID"].ToString();
                txtloyaltypoints.Text = ddt.Rows[0]["Points"].ToString();
                txtloyaltydtfrom.Text = ddt.Rows[0]["DateFrom"].ToString();
                txtloyaltydtto.Text = ddt.Rows[0]["DateTo"].ToString();
                btnSave.Text = "Update";
                Lblloyaltyhead.Text = "Update Loyalty";
            }
            else
            {
                btnSave.Text = "Save";
                Lblloyaltyhead.Text = "Add Loyalty";
            }
        }
        else
        {
            btnSave.Text = "Save";
            Lblloyaltyhead.Text = "Add Loyalty";
        }
        ModalPopupLoyalty.Show();
    }
    private void fillProductLoyalty(bool Flag)
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        string Qry = "";
        if(Flag)
            Qry = "SELECT Pro_ID, Pro_Name FROM Pro_Reg WHERE (Comp_ID = '" + Reg.Comp_ID + "') AND (Doc_Flag = 1) AND (Sound_Flag = 1) AND (Pro_ID NOT IN (SELECT Pro_ID FROM M_Loyalty WHERE (Comp_ID = Pro_Reg.Comp_ID) AND IsDelete = 0)) ORDER BY Pro_Name";
        else
            Qry = "SELECT Pro_ID, Pro_Name FROM Pro_Reg WHERE (Comp_ID = '" + Reg.Comp_ID + "') AND (Doc_Flag = 1) AND (Sound_Flag = 1) AND (Pro_ID NOT IN (SELECT Pro_ID FROM M_Loyalty WHERE  Pro_ID <> '" + lblproiddel.Text + "' AND (Comp_ID = Pro_Reg.Comp_ID)  AND IsDelete = 0)) ORDER BY Pro_Name";
        DataTable ds = SQL_DB.ExecuteDataSet(Qry).Tables[0];
        if (ds.Rows.Count > 0)
        {
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProduct, "--Select--");
            ddlProduct.SelectedIndex = 0;
        }
        else
        {
            ddlProduct.Items.Clear();
            ddlProduct.Items.Insert(0, "--Select--");
        }
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        NewMsgpop.Visible = false;
        txtDateFrom.Text = ""; txtDateTo.Text = ""; txtProductName.Text = ""; filldata();
    }

    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        NewMsgpop.Visible = false;
        filldata();
    }    
    private void filldata()
    {
        Loyalty_Programm obj = new Loyalty_Programm();
        obj.Comp_ID = Session["CompanyId"].ToString();
        obj.Pro_Name = txtProductName.Text.Trim().Replace("'", "''");
        obj.Pro_ID = "";        
        DataSet ds = Loyalty_Programm.FetchSearchData(obj);
        if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        {
            if (ds.Tables[0].Rows.Count > 0)
                GrdProductMaster.PageSize = ds.Tables[0].Rows.Count;
        }
        else
            GrdProductMaster.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        if (ds.Tables[0].Rows.Count > 0)
            GrdProductMaster.DataSource = ds.Tables[0];
        GrdProductMaster.DataBind();
        lblcount.Text = GrdProductMaster.Rows.Count.ToString();
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        NewMsgpop.Visible = false;
        filldata();
    }
    private string FindStatus(int i)
    {
        if (i == 0)
            return "Activeted";
        else
            return "De-Activeted";
    }
    protected void GrdProductMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            currindex.Value = string.Empty;
            NewMsgpop.Visible = false;
            lblproiddel.Text = e.CommandArgument.ToString();
            lblproidamc.Value = lblproiddel.Text;
            if (e.CommandName == "IsActive")
            {
                ActionText.Value = "IsActive";
                Loyalty_Programm Reg = new Loyalty_Programm();
                Reg.Pro_ID = " AND m.Pro_ID = '" + lblproiddel.Text + "'";
                Reg.Comp_ID = Session["CompanyId"].ToString();
                DataSet ds = Loyalty_Programm.FetchSearchData(Reg);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    IsAct.Value = ds.Tables[0].Rows[0]["IsActive"].ToString();
                    currindex.Value = ds.Tables[0].Rows[0]["RowId"].ToString();
                    //btnNoAlert.Visible = false;
                    //LabelAlertHead.Text = "Alert";
                    //lblalert.Text = " Are you sure to <span style='color:blue;'>" + FindStatus(Convert.ToInt32(ds.Tables[0].Rows[0]["IsActive"])) + "</span> the Brand Loyalty Settings of <span style='color:blue;'>" + ds.Tables[0].Rows[0]["Pro_Name"].ToString() + "</span> product ?";
                    //ModalPopupExtenderAlert.Show();


                    //Loyalty_Programm Reg = new Loyalty_Programm();
                    Reg.RowId = Convert.ToInt64(currindex.Value);
                    //if (ActionText.Value == "IsActive")
                    //{
                        if (Convert.ToInt32(IsAct.Value) == 0)
                            Reg.IsActive = 1;
                        else
                            Reg.IsActive = 0;
                        Reg.DMLs = "IsActive";
                        Loyalty_Programm.IsActiveDelete(Reg);
                        Label2.Text = "Product " + Reg.Pro_Name + " Loyalty has been <span style='color:blue;'>" + FindStatus(Reg.IsActive) + "</span> successfully !";
                    //}                    
                    filldata();
                    NewMsgpop.Visible = true;
                    NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
                    string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                    return;
                }
            }
            if (e.CommandName == "DeleteRow")
            {
                ActionText.Value = "IsDelete";
                Loyalty_Programm Reg = new Loyalty_Programm();
                Reg.Pro_ID = " AND m.Pro_ID = '" + lblproiddel.Text + "'";
                Reg.Comp_ID = Session["CompanyId"].ToString();
                DataSet ds = Loyalty_Programm.FetchSearchData(Reg);
                if (ds.Tables[0].Rows.Count > 0)
                {                    
                    //btnNoAlert.Visible = false;
                    //LabelAlertHead.Text = "Alert";
                    //lblalert.Text = " Are you sure to delete the Brand Loyalty Settings of <span style='color:blue;'>" + ds.Tables[0].Rows[0]["Pro_Name"].ToString() + "</span> product ?";
                    //ModalPopupExtenderAlert.Show();

                    IsAct.Value = ds.Tables[0].Rows[0]["IsActive"].ToString();
                    currindex.Value = ds.Tables[0].Rows[0]["RowId"].ToString();
                    Reg.RowId = Convert.ToInt64(currindex.Value);
                    //else if (ActionText.Value == "IsDelete")
                    //{
                        Reg.IsDelete = 1;
                        Reg.DMLs = "IsDelete";
                        Loyalty_Programm.IsActiveDelete(Reg);
                        Label2.Text = "Product " + Reg.Pro_Name + " has been deleted successfully !";
                    //}
                    filldata();
                    NewMsgpop.Visible = true;
                    NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
                    string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                }
            }
            else if (e.CommandName == "AudioPlay")
            {
                System.Media.SoundPlayer player = new System.Media.SoundPlayer(Server.MapPath(e.CommandArgument.ToString()));
                player.Play();
            }
            else if (e.CommandName == "Loyalty")
            {
                lblproiddel.Text = e.CommandArgument.ToString();
                lblproidamc.Value = lblproiddel.Text;
                fillProductLoyalty(false);
                DataTable ddt = SQL_DB.ExecuteDataSet("SELECT RowId, Comp_ID, Pro_ID, Points,IsCashConvert, DateFrom, DateTo, IsActive, IsDelete,Comments ,Frequency,Entry_Date, " +
                    " 'Sound/' + SUBSTRING(Comp_ID, 6, 4) + '/' + Pro_ID + '/Loyalty/'+ CONVERT(VARCHAR,RowId) +'/' + CONVERT(VARCHAR,RowId) + '_H.wav'  AS SoundPath , " +
                    " 'Sound/' + SUBSTRING(Comp_ID, 6, 4) + '/' + Pro_ID + '/Loyalty/'+ CONVERT(VARCHAR,RowId) +'/' + CONVERT(VARCHAR,RowId) + '_E.wav'  AS SoundPath1 " +
                    " FROM M_Loyalty WHERE Pro_ID = '" + e.CommandArgument.ToString() + "' ").Tables[0];
                if (ddt.Rows.Count > 0)
                {
                    bool check = GetUpdate(ddt.Rows[0]["Pro_ID"].ToString(), Convert.ToDateTime(ddt.Rows[0]["Entry_Date"]));
                    currindex.Value = ddt.Rows[0]["RowId"].ToString();
                    ddlProduct.SelectedValue = ddt.Rows[0]["Pro_ID"].ToString();
                    chkloyalty.Checked = true;
                    if (Convert.ToInt32(ddt.Rows[0]["IsCashConvert"]) == 0)
                        chkconvert.Checked = true;
                    else
                        chkconvert.Checked = false;
                    hdnloyalty.Value = ddt.Rows[0]["Pro_ID"].ToString();
                    txtloyaltypoints.Text = ddt.Rows[0]["Points"].ToString();
                    txtloyaltydtfrom.Text = ddt.Rows[0]["DateFrom"].ToString();
                    txtloyaltydtto.Text = ddt.Rows[0]["DateTo"].ToString();
                    txtCommentsTxt.Text = ddt.Rows[0]["Comments"].ToString();
                    FileDownHindi.HRef = ddt.Rows[0]["SoundPath"].ToString();
                    FileDownEnglish.HRef = ddt.Rows[0]["SoundPath1"].ToString();
                    txtfrequency.Text = ddt.Rows[0]["Frequency"].ToString();
                    hdnpointsval.Value = txtloyaltypoints.Text;
                    ChangeUpdateFields(check);
                    ChnageValidation(false);
                    btnSave.Text = "Update";
                    Lblloyaltyhead.Text = "Update Loyalty";
                }
                else
                {
                    ChnageValidation(true);
                    btnSave.Text = "Save";
                    Lblloyaltyhead.Text = "Add Loyalty";
                }                
                ModalPopupLoyalty.Show();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void CheckforUpdate(object sender, EventArgs e)
    {
        Int64 OldPoints = Convert.ToInt64(hdnpointsval.Value);
        Int64 NewPoints = Convert.ToInt64(txtloyaltypoints.Text);
        if (OldPoints <= NewPoints)
        {
            txtloyaltypoints.Text = NewPoints.ToString();
            DivMsg.Visible = false;
        }
        else
        {
            LblMsgBody.Text = "Points not update is less than old points " + OldPoints;
            DivMsg.Visible = true;
            DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
            string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            txtloyaltypoints.Text = OldPoints.ToString();
        }        
        ModalPopupLoyalty.Show();
    }
    private void ChangeUpdateFields(bool check)
    {
        //if (check)
        //{
        //    txtloyaltydtfrom.Enabled = true; txtfrequency.Enabled = true; 
        //}
        //else
        //{
        //    txtloyaltydtfrom.Enabled = false; txtfrequency.Enabled = false; 
        //}
    }

    private bool GetUpdate(string Pro_ID, DateTime DateTime)
    {
        DataTable dt = SQL_DB.ExecuteDataSet("SELECT  RowId, Comp_ID, Pro_ID, User_ID, Code1, Code2, Points, Type, Entry_Date, Mode, IsCashConvert, IsUse FROM  T_Points WHERE Pro_ID='" + Pro_ID + "' AND CONVERT(VARCHAR,Entry_Date,111) >= '" + Convert.ToDateTime(DateTime).ToString("yyyy/MM/dd") + "' ").Tables[0];
        if (dt.Rows.Count > 0)
            return false;
        else
            return true;
    }

    
    private void ChnageValidation(bool Flag)
    {
        if (Flag)
        {
            FileDownHindi.Visible = false; FileDownEnglish.Visible = false;             
            RequiredFieldValidatorHindi.ValidationGroup = "LOY";
            RequiredFieldValidator6English.ValidationGroup = "LOY";
        }
        else
        {
            FileDownHindi.Visible = true; FileDownEnglish.Visible = true;
            RequiredFieldValidatorHindi.ValidationGroup = "NA";
            RequiredFieldValidator6English.ValidationGroup = "NA";
        }
    }
    protected void GrdProductMaster_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        NewMsgpop.Visible = false;
        GrdProductMaster.PageIndex = e.NewPageIndex;
        filldata();
    }
    protected void btnLoyalty_Click(object sender, EventArgs e)
    {
        if (chkloyalty.Checked)
        {
            Loyalty_Programm Reg = new Loyalty_Programm();            
            Reg.Comp_ID = Session["CompanyId"].ToString();
            if(txtloyaltydtfrom.Text != "")
                Reg.DateFrom = Convert.ToDateTime(txtloyaltydtfrom.Text).ToString("yyyy/MM/dd hh:mm:ss tt");
            if(txtloyaltydtto.Text != "")
                Reg.DateTo = Convert.ToDateTime(txtloyaltydtto.Text).ToString("yyyy/MM/dd hh:mm:ss tt");
            Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
            if (chkconvert.Checked)
                Reg.IsCashConvert = 0;
            else
                Reg.IsCashConvert = 1;
            if (chkIsActive.Checked)
                Reg.IsActive = 0;
            else
                Reg.IsActive = 1;
            if (chkIsDelete.Checked)
                Reg.IsDelete = 1;
            else
                Reg.IsDelete = 0;
            if (txtfrequency.Text.Trim().Replace("'", "''") != "")
                Reg.Frequency = Convert.ToInt32(txtfrequency.Text.Trim().Replace("'", "''"));
            else
                Reg.Frequency = 1;
            Reg.Points = Convert.ToDecimal(txtloyaltypoints.Text);
            Reg.Comments = txtCommentsTxt.Text.Trim().Replace("'","''");
            if (btnSave.Text == "Save")
            {
                Reg.Pro_ID = ddlProduct.SelectedValue.ToString(); ;
                Reg.DML = "I";                
                Label2.Text = "Loyalty Programm saved successfully fot this Product!";
            }
            else
            {
                Reg.Pro_ID = lblproiddel.Text;
                Reg.DML = "U";
                Reg.RowId = Convert.ToInt32(currindex.Value);
                Label2.Text = "Loyalty Programm saved successfully fot this Product!";
            }            
            Loyalty_Programm.InsertUpdateLoyalty(Reg);            
            string path = Server.MapPath("../Data/Sound");
            if (flSoundH.FileName != "")
            {
                path = Server.MapPath("../Data/Sound");
                path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Loyalty\\" + Reg.RowId;
                DataProvider.Utility.CreateDirectory(path);
                path = path + "\\" + Reg.RowId + "_H.wav";
                flSoundH.SaveAs(path);
                Reg.DMLs = "H";
                Loyalty_Programm.UpdateSoundFile(Reg);
            }
            if (flSoundE.FileName != "")
            {
                path = Server.MapPath("../Data/Sound");
                path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Loyalty\\" + Reg.RowId;
                DataProvider.Utility.CreateDirectory(path);
                path = path + "\\" + Reg.RowId + "_E.wav";
                flSoundE.SaveAs(path);
                Reg.DMLs = "E";
                Loyalty_Programm.UpdateSoundFile(Reg);
            }
            ClearText();
            NewMsgpop.Visible = true;
            NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
            string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        else
        {
            NewMsgpop.Visible = true;
            NewMsgpop.Attributes.Add("class", "alert_boxes_pink big_msg");
            Label2.Text = "Please select Loyalty Required!";
            string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }        
    }
    protected void btnYesAlert_Click(object sender, EventArgs e)
    {
        Loyalty_Programm Reg = new Loyalty_Programm();
        Reg.RowId = Convert.ToInt64(currindex.Value);
        if (ActionText.Value == "IsActive")
        {
            if (Convert.ToInt32(IsAct.Value) == 0)
                Reg.IsActive = 1;
            else
                Reg.IsActive = 0;
            Reg.DMLs = "IsActive";
            Loyalty_Programm.IsActiveDelete(Reg);
            Label2.Text = "Product " + Reg.Pro_Name + " has been <span style='color:blue;'>" + FindStatus(Reg.IsActive) + "</span> successfully !";
        }
        else if (ActionText.Value == "IsDelete")
        {
            Reg.IsDelete = 1;
            Reg.DMLs = "IsDelete";
            Loyalty_Programm.IsActiveDelete(Reg);
            Label2.Text = "Product " + Reg.Pro_Name + " has been deleted successfully !";
        }                
        filldata();
        NewMsgpop.Visible = true;
        NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");        
        string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }
    protected void btnNoAlert_Click(object sender, EventArgs e)
    {

    }
}
