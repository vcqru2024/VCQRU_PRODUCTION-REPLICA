using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Business9420;
using System.Web.Services;
using System.Web.Script.Services;
using System.IO;
using Business_Logic_Layer;

public partial class ServicePriceMaster : System.Web.UI.Page
{
    public int str = 0, strr = 0, lflag = 0; public int index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=ServicePriceMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {
            FillddlService(ddlsearchservice);
            FillGrdVwServicePriceDetails();
            newMsg.Visible = false;
            lblcount.Text = "0";
        }
        Label2.Text = "";
    }
    private void FillYearMonths()
    {
        ddlyear.Items.Clear();
        ddlyear.Items.Insert(0, "--Select--");
        ddlmonths.Items.Clear();
        ddlmonths.Items.Insert(0, "--Select--");
        for (int i = 1; i < 13; i++)
        {
            ddlyear.Items.Insert(i, i.ToString() + " Year");
            if (i != 12)
                ddlmonths.Items.Insert(i, i.ToString() + " Months");
        }
        ddlyear.SelectedIndex = 0;
        ddlmonths.SelectedIndex = 0;
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        //lblimg.Visible = false;
        newMsg.Visible = false;
        Cleartxt();
        newMsg.Visible = false;
        lblheading.Text = "Create New Service Price";
        ModalPopupCreateLabel.Show();
    }
    private void FillGrdVwServicePriceDetails()
    {
        ObjService Reg = new ObjService();
        Reg.Service_ID = ddlsearchservice.SelectedValue.Trim();
        DataSet ds = ObjService.FillServicePriceDetails(Reg);
        GrdServicePrice.DataSource = ds.Tables[0];
        GrdServicePrice.DataBind();
        lblcount.Text = GrdServicePrice.Rows.Count.ToString();
    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdVwServicePriceDetails();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        ddlsearchservice.SelectedIndex = 0;
        newMsg.Visible = false;
        FillGrdVwServicePriceDetails();
    }
    protected void GrdServicePrice_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdServicePrice.PageIndex = e.NewPageIndex;
        FillGrdVwServicePriceDetails();
    }
    private void FillddlService(DropDownList ddl)
    {
        DataSet ds = ObjService.FillServiceddl();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Service_ID", "ServiceName", ddl, "--Select--");
        ddl.SelectedIndex = 0;
    }
    private void Cleartxt()
    {
        FillddlService(ddlService);
        FillYearMonths();
        lbleditlabelid.Text = "";
        txtlabelprise.Text = string.Empty;
        txtplanname.Text = string.Empty;
        txtplanname.Enabled = true;
        txtlabelprise.Enabled = true;
        btnSave.Text = "Save";
    }
    protected void GrdServicePrice_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Cleartxt();
        ObjService Reg = new ObjService();
        lbleditlabelid.Text = e.CommandArgument.ToString();
        Reg.Plan_ID = lbleditlabelid.Text;
        ObjService.FillServicePriceInfo(Reg);
        newMsg.Visible = false; Div1.Visible = false;
        if (e.CommandName == "EditServicePrice")
        {
            ddlService.SelectedValue = Reg.Service_ID;
            txtplanname.Text = Reg.PlanName;
            txtlabelprise.Text = Reg.PlanPrice.ToString();
            if (Reg.Service_Year > 0)
                ddlyear.SelectedIndex = Convert.ToInt32(Reg.Service_Year);
            if (Reg.Service_Months > 0)
                ddlmonths.SelectedIndex = Convert.ToInt32(Reg.Service_Months);
            btnSave.Text = "Update";
            lblheading.Text = "Update Service Price";
            ModalPopupCreateLabel.Show();
        }
        else if (e.CommandName == "ShowHideServicePrice")
        {
            hdntransid.Value = "IsActive";
            lblPassPnlHead.Text = "Alert";
            lblPopMsgText.Text = "Are you sure to " + FindStatus(Reg.IsActive) + " <span style='color:blue;' >" + Reg.ServiceName + " </span> For <span style='color:blue;' >" + Reg.PlanName + " </span>  Plan ?";
            ModalPopupExtender3.Show();
        }
        else if (e.CommandName == "DeletePriceTrans")
        {
            hdntransid.Value = "IsDelete";
            lblPassPnlHead.Text = "Alert";
            lblPopMsgText.Text = "Are you sure to delete <span style='color:blue;' >" + Reg.ServiceName + " </span> For <span style='color:blue;' >" + Reg.PlanName + " </span>  Plan ?";
            ModalPopupExtender3.Show();
        }
        else if (e.CommandName == "ViewSRVPriceDetails")
        {
            FillServicePriceTrans(Reg);
            ModalPopupLabelPriseDetails.Show();
        }
    }

    private void FillServicePriceTrans(ObjService Reg)
    {
        DataSet ds = ObjService.FillServicePriceTransDetGrd(Reg);
        Label1.Text = " Plan Details"; string Msg = "";
        if (Reg.Service_Year > 0)
        {
            if (Reg.Service_Months > 0)
                Msg = Reg.Service_Year + " Year and " + Reg.Service_Months + " Months";
            else
                Msg = Reg.Service_Year + " Year";
        }
        else
            Msg = Reg.Service_Months + " Months";
        Label4.Text = "Service Name <span style='color:blue;' > " + Reg.ServiceName + " </span> for Service Title <span style='color:blue;' > " + Reg.PlanName + " </span>";// Plan <span style='color:blue;' > " + Msg + " </span>
        GrdViewServiceDetails.DataSource = ds.Tables[0];
        GrdViewServiceDetails.DataBind();
    }
    private string FindStatus(int Status)
    {
        if (Status == 0)
            return "De-Activate";
        else
            return "Activate";
    }
    private string FindStatus1(int Status)
    {
        if (Status == 1)
            return "De-Activated";
        else
            return "Activated";
    }
    protected void btnYesActivation_Click(object sender, EventArgs e)
    {
        ObjService Reg = new ObjService();
        Reg.EntryDate = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        Reg.Plan_ID = lbleditlabelid.Text;
        ObjService.FillServicePriceInfo(Reg);
        Reg.DML = "U";
        if (hdntransid.Value == "IsActive")
        {
            if (Reg.IsActive == 0)
                Reg.IsActive = 1;
            else
                Reg.IsActive = 0;
            Reg.Act = "IsActive";
        }
        else if (hdntransid.Value == "IsDelete")
        {
            if (Reg.IsDelete == 0)
                Reg.IsDelete = 1;
            else
                Reg.IsDelete = 0;
            Reg.Act = "IsDelete";
        }
        ObjService.IUpdServicePrice(Reg);
        ObjService.FillServicePriceInfo(Reg);
        newMsg.Visible = true;
        newMsg.Attributes.Add("class", "alert_boxes_green");
        Label2.Text = "Status of <span style='color:blue;' >" + Reg.ServiceName + " </span> and <span style='color:blue;' >" + Reg.PlanName + " </span> is <span style='color:blue;' >" + (Reg.Act == "IsDelete" ? "Deleted" : Reg.Msg) + "</span> ! ";
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        FillGrdVwServicePriceDetails();
    }
    protected void btnNoActivation_Click(object sender, EventArgs e)
    {

    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewPlan(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Plan_Name] FROM [M_Plan] where [Plan_Name] = '" + res.Trim().Replace("'", "''") + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        ObjService Reg = new ObjService();
        Reg.Service_ID = ddlService.SelectedValue.ToString();
        Reg.PlanPrice = Convert.ToDouble(txtlabelprise.Text);
        Reg.EntryDate = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        string script = "";
        Reg.PlanName = txtplanname.Text.Trim().Replace("'", "''");
        #region Service Time
        Int32 plan_time = 0;
        if (ddlyear.SelectedIndex > 0)
        {
            int yer = Convert.ToInt32(ddlyear.SelectedValue.ToString().Substring(0, 2).Trim());
            if (ddlmonths.SelectedIndex > 0)
            {
                int mon = Convert.ToInt32(ddlmonths.SelectedValue.ToString().Substring(0, 2).Trim());
                plan_time = Convert.ToInt32(Convert.ToInt32(yer) * 12) + Convert.ToInt32(mon);
            }
            else
                plan_time = Convert.ToInt32(Convert.ToInt32(yer) * 12);
        }
        else
        {
            if (ddlmonths.SelectedIndex > 0)
            {
                int mon = Convert.ToInt32(ddlmonths.SelectedValue.ToString().Substring(0, 2).Trim());
                plan_time = Convert.ToInt32(mon);
            }
            else
            {
                ProductsLabelPrices.Text = "Please select plan time!";
                ddlyear.Focus();
                Div1.Visible = true;
                Div1.Attributes.Add("class", "alert_boxes_pink big_msg");
                ModalPopupCreateLabel.Show();
                script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            }
        }
        #endregion
        Reg.PlanPeriod = plan_time;
        Reg.IsActive = 0; Reg.IsDelete = 0;
        if (btnSave.Text == "Save")
        {
            Reg.DML = "I";
            ObjService.IUpdServicePrice(Reg);
            ProductsLabelPrices.Text = "Service <span style='color:blue;'>" + ddlService.SelectedItem.Text.Trim() + "</span> Plan <span style='color:blue;'>" + Reg.PlanName + "</span> has been saved successfully !";
            Div1.Visible = true;
            Div1.Attributes.Add("class", "alert_boxes_green");
            ModalPopupCreateLabel.Show();
            script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        else
        {
            Reg.Plan_ID = lbleditlabelid.Text;
            Reg.DML = "U";
            ObjService.IUpdServicePrice(Reg);
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green");
            Label2.Text = "Service <span style='color:blue;'>" + ddlService.SelectedItem.Text.Trim() + "</span> Plan <span style='color:blue;'>" + Reg.PlanName + "</span>  has been Updated successfully !";
            script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        Cleartxt();
        FillGrdVwServicePriceDetails();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Cleartxt();
        ModalPopupCreateLabel.Show();
    }
}