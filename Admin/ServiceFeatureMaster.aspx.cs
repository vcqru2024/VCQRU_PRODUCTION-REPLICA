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
using DataProvider;

public partial class ServiceFeatureMaster : System.Web.UI.Page
{
    public int str = 0, strr = 0, lflag = 0; public int index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=ServiceFeatureMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {
            FillGrdServiceFeatureMaster();
            newMsg.Visible = false;
            lblcount.Text = "0";
        }
        Label2.Text = "";
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        Cleartxt();
        newMsg.Visible = false;
        lblheading.Text = "Create New Service Feature";
        ModalPopupCreateLabel.Show();
    }
    private void FillGrdServiceFeatureMaster()
    {
        ObjService Reg = new ObjService();
        Reg.ServiceName = txtsearchlblname.Text.Trim().Replace("'", "''");
        DataSet ds = ObjService.FillGridServiceFeature(Reg);
        GrdServiceFeatureMaster.DataSource = ds.Tables[0];
        GrdServiceFeatureMaster.DataBind();
        lblcount.Text = GrdServiceFeatureMaster.Rows.Count.ToString();
    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdServiceFeatureMaster();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtsearchlblname.Text = string.Empty;
        newMsg.Visible = false;
        FillGrdServiceFeatureMaster();
    }
    protected void GrdServiceFeatureMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdServiceFeatureMaster.PageIndex = e.NewPageIndex;
        FillGrdServiceFeatureMaster();
    }
    private void FillddlService(DropDownList ddl, ObjService Reg)
    {
        DataSet ds = ObjService.FillServiceddl(Reg);
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Service_ID", "ServiceName", ddl, "--Select--");
        ddl.SelectedIndex = 0;
    }
    private void Cleartxt()
    {
        ObjService Reg = new ObjService();
        FillddlService(ddlService,Reg);
        chkdtrange.Checked = false;
        chkfrequency.Checked = false;
        chkisgift.Checked = false;
        chkispoints.Checked = false;
        chkmsg.Checked = false;
        chksfileorcomm.Checked = false;
        chknomessage.Checked = false;
        chknotify.Checked = false;
        chkCoupons.Checked = false;
        chkcashamt.Checked = false;
        chkReferral.Checked = false;
        lbleditlabelid.Text = "";
        ddlService.SelectedIndex = 0;
        btnSave.Text = "Save";
        lblheading.Text = "Add New Service Feaure";
    }
    private void CheckCheckBox(CheckBox Chk, int Val)
    {
        if (Val == 0)
            Chk.Checked = true;
        else
            Chk.Checked = false;
    }
    private int GetCheckBoxVal(CheckBox Chk)
    {
        if (Chk.Checked)
            return 0;
        else
            return 1;
    }
    private void EditLabel(ObjService Reg)
    {
        ddlService.SelectedValue = Reg.Service_ID;
        CheckCheckBox(chkispoints, Reg.IsPoints);
        CheckCheckBox(chkdtrange, Reg.IsDateRange);
        CheckCheckBox(chksfileorcomm, Reg.IsSound);
        CheckCheckBox(chkfrequency, Reg.IsFrequency);
        CheckCheckBox(chkisgift, Reg.IsAdditionalGift);
        CheckCheckBox(chkmsg, Reg.IsMessageTemplete);
        CheckCheckBox(chknotify, Reg.IsNotify);
        CheckCheckBox(chknomessage, Reg.IsNoMessage);
        CheckCheckBox(chkCoupons, Reg.IsCoupons);
        CheckCheckBox(chkcashamt, Reg.IsCash);
        CheckCheckBox(chkReferral, Reg.IsReferral);
        btnSave.Text = "Update";
    }
    protected void GrdServiceFeatureMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        ObjService Reg = new ObjService();
        lbleditlabelid.Text = e.CommandArgument.ToString();
        Reg.ServiceFeaure_ID = Convert.ToInt64(lbleditlabelid.Text);
        ObjService.FillServiceFeatureInfo(Reg);
        newMsg.Visible = false; Div1.Visible = false;
        if (e.CommandName == "EditServiceFeaure")
        {
            Reg.EditServiceID = Reg.Service_ID;
            FillddlService(ddlService, Reg);
            EditLabel(Reg);
            lblheading.Text = "Update Service Feature Details";
            ModalPopupCreateLabel.Show();
        }
        else if (e.CommandName == "DeleteServiceFeature")
        {
            hdntype.Value = "IsDelete";
            lblPassPnlHead.Text = "Alert";
            lblPopMsgText.Text = "Are you sure to Delete <span style='color:blue;' >" + Reg.ServiceName + "</span>  Service Feature's ?";
            ModalPopupExtender3.Show();
        }
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
        Reg.ServiceFeaure_ID = Convert.ToInt64(lbleditlabelid.Text);
        Reg.EntryDate = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        ObjService.FillServiceFeatureInfo(Reg);
        Reg.DML = "U";
        if (hdntype.Value == "IsActive")
        {
            Reg.Act = "IsActive";
            Reg.IsActive = (Reg.IsActive == 0 ? 1 : 0);
            Reg.IsDelete = 0;
            ObjService.IUpdServiceFeature(Reg);
            ObjService.FillServiceFeatureInfo(Reg);
            Label2.Text = "Status of <span style='color:blue;' >" + Reg.ServiceName + "</span> is <span style='color:blue;' >" + FindStatus1(Reg.IsActive) + "</span> ! ";
        }
        if (hdntype.Value == "IsDelete")
        {
            Reg.Act = "IsDelete";
            Reg.IsDelete = (Reg.IsDelete == 0 ? 1 : 0);
            Reg.IsActive = 0;
            ObjService.IUpdServiceFeature(Reg);
            ObjService.FillServiceFeatureInfo(Reg);
            Label2.Text = "<span style='color:blue;' >" + Reg.ServiceName + "</span> is <span style='color:blue;' > Deleted successfully </span>. ";
        }
        newMsg.Visible = true;
        newMsg.Attributes.Add("class", "alert_boxes_green");
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        FillGrdServiceFeatureMaster();
    }
    protected void btnNoActivation_Click(object sender, EventArgs e)
    {

    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewLabel(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [ServiceName] FROM [M_Service] where [ServiceName] = '" + res + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        ObjService Reg = new ObjService();
        Reg.EntryDate = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        Reg.Service_ID = ddlService.SelectedValue.Trim();
        Reg.IsPoints = GetCheckBoxVal(chkispoints);
        Reg.IsDateRange = GetCheckBoxVal(chkdtrange);
        Reg.IsSound = GetCheckBoxVal(chksfileorcomm);
        Reg.IsFrequency = GetCheckBoxVal(chkfrequency);
        Reg.IsAdditionalGift = GetCheckBoxVal(chkisgift);
        Reg.IsMessageTemplete = GetCheckBoxVal(chkmsg);
        Reg.IsNotify = GetCheckBoxVal(chknotify);
        Reg.IsNoMessage = GetCheckBoxVal(chknomessage);
        Reg.IsCoupons = GetCheckBoxVal(chkCoupons);
        Reg.IsCash = GetCheckBoxVal(chkcashamt);
        Reg.IsReferral = GetCheckBoxVal(chkReferral);
        
        if (btnSave.Text == "Save")
        {
            Reg.DML = "I";
            Reg.IsDelete = 0;
            ObjService.IUpdServiceFeature(Reg);
            ProductsLabelPrices.Text = "Service <span style='color:blue;' >" + ddlService.SelectedItem.Text + "</span> Feature has been Saved successfully !";
            function9420.UpdateLabelCode("Service");
            Div1.Visible = true;
            Div1.Attributes.Add("class", "alert_boxes_green");
            ModalPopupCreateLabel.Show();
            string script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        else
        {
            Reg.DML = "U";
            Reg.ServiceFeaure_ID = Convert.ToInt64(lbleditlabelid.Text);
            ObjService.IUpdServiceFeature(Reg);
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green");
            Label2.Text = "Price Label <span style='color:blue;' >" + Reg.ServiceName + "</span>  Feature has been Updated successfully !";
            string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        Cleartxt();
        FillGrdServiceFeatureMaster();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Cleartxt();
        ModalPopupCreateLabel.Show();
    }
}