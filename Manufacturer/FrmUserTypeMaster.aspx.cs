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

public partial class FrmUserTypeMaster : System.Web.UI.Page
{
    public int Flag = 0, index = 0, sno = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ProjectSession.strCompanyid))
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/default.aspx?Page=FrmUserTypeMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }  
        if (!Page.IsPostBack)
        {
            ////******************* Open For Retailler Service *****************//
            ////Session["Comp_type"]
            //if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
            //    Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            hdnCompID.Value = Session["CompanyId"].ToString(); 
            lblmsgHeader.Text = "";
            FillGrid();
        }
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillGrid();
    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewLabel(string res)
    {
        string[] Arr = res.ToString().Split('*');
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [GiftName] FROM [   M_Gift] WHERE  [GiftName]  = '" + Arr[0].ToString() + "' AND Comp_ID = '" + Arr[1].ToString() + "' AND IsDelete = 0 ");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else   
            return false;
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        Clear();
        newMsg.Visible = false; DivNewMsg.Visible = false;
        ModalPopupExtenderNewDesign.Show();
    }
    private void Clear()    {
        
        dhnactiontype.Value = string.Empty;        
        //txtName.Text = "";
        lblAddCourierHeader.Text = "Add New Gift";
       // btnSubmit.Text = "Save";
    }    
    protected void btnSearch_Click(object sender, ImageClickEventArgs e)
    {
        FillGrid();
        newMsg.Visible = false;
    }
    protected void btnRefesh_Click(object sender, ImageClickEventArgs e)
    {
        txtSearchName.Text = "";
        FillGrid();
        newMsg.Visible = false;
    }
    private void FillGrid()
    {
        //CouponProver Reg = new CouponProver();
        //Reg.DML = "F";
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //Reg.GiftName = txtSearchName.Text.Trim().Replace("'", "''");
        //DataTable DsGrd = new DataTable();
        //DsGrd = Business9420.CouponProver.GiftFillDataGrid(Reg);
        //if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        //{
        //    if (DsGrd.Rows.Count > 0)
        //        GrdVw.PageSize = DsGrd.Rows.Count;
        //}
        //else
        //    GrdVw.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        //if (DsGrd.Rows.Count > 0)
        //    GrdVw.DataSource = DsGrd;
        //GrdVw.DataBind();
       

        DataTable dt2 = SQL_DB.ExecuteDataTable("select * from [UserType_TrackTrace] where compid='" + ProjectSession.strCompanyid + "'");
       // if (dt2.Rows.Count > 0)
        {
            GrdVw.DataSource = dt2;
           // ddlchnls.DataTextField = "name";
           // ddlchnls.DataValueField = "ChannelsID";
            GrdVw.DataBind();
            lblcount.Text = dt2.Rows.Count.ToString();
            if (GrdVw.Rows.Count > 0)
                GrdVw.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

    }
    protected void GrdVw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdVw.PageIndex = e.NewPageIndex;
        FillGrid();
    }
    protected void GrdVw_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        CouponProver Reg = new CouponProver();
        lblBankId.Text = e.CommandArgument.ToString();
        Reg.Gift_ID = lblBankId.Text; newMsg.Visible = false;
        Reg.DML = "S";
        Reg.Comp_ID = Session["CompanyId"].ToString();
        CouponProver.GiftFillDataGrid(Reg);        
        if (e.CommandName.ToString() == "EditRow")
        {
            Response.Redirect("AddUserTypeMaster.aspx?id=" + e.CommandArgument.ToString());  
           // txtName.Text = Reg.GiftName;
           // lblAddCourierHeader.Text = "Gift update Details";
          //  btnSubmit.Text = "Update";
            //ModalPopupExtenderNewDesign.Show();
        }
        else if (e.CommandName.ToString() == "DeleteRow")
        {
            //Reg.DML = "D";
            //if (Reg.IsDelete == 0)
            //    Reg.IsDelete = 1;
            //else
            //    Reg.IsDelete = 0;
            //CouponProver.GiftActivateDelete(Reg);
            SQL_DB.ExecuteNonQuery("delete from UserType_TrackTrace where TTUserTypeid = " + lblBankId.Text);
            lblmsgHeader.Text = "Deleted  successfully.";
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
            FillGrid();
            string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            //dhnactiontype.Value = "D";
            //LabelAlertheader.Text = "Alert";
            //LabelAlertText.Text = "Are you sure to dalete  <span style='color:blue;' >" + Reg.GiftName + "</span>  Gift permanently?";
            //ModalPopupExtenderAlert.Show();
        }
        else if (e.CommandName.ToString() == "ActivateRow")
        {
            //CouponProver.GiftFillDataGrid(Reg);
          //  if (dhnactiontype.Value == "A")
            {
                Reg.DML = "A";
                if (Reg.IsActive == 0)
                {
                    Reg.IsActive = 1;
                    lblmsgHeader.Text = "Gift <span style='color:blue;' >" + Reg.GiftName + "</span> has benn <span style='color:blue;' > " + FindStatusNew(Reg.IsActive) + " </span>  successfully.";
                }
                else
                {
                    Reg.IsActive = 0;
                    lblmsgHeader.Text = "Gift <span style='color:blue;' >" + Reg.GiftName + "</span> has benn <span style='color:blue;' > " + FindStatusNew(Reg.IsActive) + " </span>  successfully.";
                }
                CouponProver.GiftActivateDelete(Reg);
                newMsg.Visible = true;
                newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                FillGrid();
                string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            }
            //dhnactiontype.Value = "A";
            //LabelAlertheader.Text = "Alert";
            //LabelAlertText.Text = "Are you sure to <span style='color:blue;' > " + FindStatus(Reg.IsActive) + " </span> <span style='color:blue;' >" + Reg.GiftName + "</span>  Gift permanently?";
            //ModalPopupExtenderAlert.Show();
        }
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
    protected void btnYes_Click(object sender, EventArgs e)
    {
        CouponProver Reg = new CouponProver();
        Reg.Gift_ID = lblBankId.Text;
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.DML = "S";
        CouponProver.GiftFillDataGrid(Reg);
        if (dhnactiontype.Value == "A")
        {
            Reg.DML = "A";
            if (Reg.IsActive == 0)
            {
                Reg.IsActive = 1;
                lblmsgHeader.Text = "Gift <span style='color:blue;' >" + Reg.GiftName + "</span> has benn <span style='color:blue;' > " + FindStatusNew(Reg.IsActive) + " </span>  successfully.";
            }
            else
            {
                Reg.IsActive = 0;
                lblmsgHeader.Text = "Gift <span style='color:blue;' >" + Reg.GiftName + "</span> has benn <span style='color:blue;' > " + FindStatusNew(Reg.IsActive) + " </span>  successfully.";
            }
        }
        else if (dhnactiontype.Value == "D")
        {
            Reg.DML = "D";
            if (Reg.IsDelete == 0)
                Reg.IsDelete = 1;
            else
                Reg.IsDelete = 0;
            lblmsgHeader.Text = "Gift <span style='color:blue;' >" + Reg.GiftName + "</span> has benn deleted  successfully.";
        }
        CouponProver.GiftActivateDelete(Reg);
        newMsg.Visible = true;
        newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        FillGrid();
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {        
    //    CouponProver Reg = new CouponProver();
    //    Reg.Comp_ID = Session["CompanyId"].ToString();
    //    Reg.EntryDate = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
    //    Reg.GiftName = txtName.Text.Trim().Replace("'", "''");
    //    DataSet ds = SQL_DB.ExecuteDataSet("SELECT [GiftName] FROM [M_Gift] WHERE  [GiftName]  = '" + Reg.GiftName + "' AND Comp_ID = '" + hdnCompID.Value + "' ");
    //    if (ds.Tables[0].Rows.Count > 0)
    //    {
    //        lblpopmsg.Text = "Gift <span style='color:blue;' >" + Reg.GiftName + "</span> already exist.";
    //        DivNewMsg.Visible = true;
    //        newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //        string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    //        ModalPopupExtenderNewDesign.Show();
    //        return;
    //    }        
    //    if (btnSubmit.Text == "Save")
    //    {
    //        Reg.DML = "I";
    //        CouponProver.GiftInsertUpdate(Reg);
    //        lblpopmsg.Text = "Gift <span style='color:blue;' >" + Reg.GiftName + "</span> has been registered successfully.";
    //        DivNewMsg.Visible = true;
    //        DivNewMsg.Attributes.Add("class", "alert_boxes_green");
    //        string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    //        ModalPopupExtenderNewDesign.Show();
    //        Clear();
    //        FillGrid();
    //        return;
    //    }
    //    else
    //    {
    //        Reg.Gift_ID = lblBankId.Text;
    //        Reg.DML = "U";
    //        CouponProver.GiftInsertUpdate(Reg);
    //        lblmsgHeader.Text = "Gift <span style='color:blue;' >" + Reg.GiftName + "</span> has beeb updated successfully.";
    //        newMsg.Visible = true;
    //        newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    //        Clear();
    //        FillGrid();
    //    }                        
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Clear(); newMsg.Visible = false; DivNewMsg.Visible = false;
        ModalPopupExtenderNewDesign.Show();
    }

    protected void imgNew_Click1(object sender, EventArgs e)
    {
        Response.Redirect("AddUserTypeMaster.aspx");
    }
}
