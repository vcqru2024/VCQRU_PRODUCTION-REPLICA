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

public partial class FrmAmcPlanMaster : System.Web.UI.Page
{
    public int str = 0, strr = 0,lflag =0; public int index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["User_Type"] = "Admin";
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmAmcPlanMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {            
            FillGrdVwPlanMaster();
            newMsg.Visible = false;
            lblcount.Text = "0"; 
        }
        Label2.Text = "";
    }
    private void FillYearMonths()
    {
        ddlyear.Items.Clear();
        ddlyear.Items.Insert(0,"--Select--");
        ddlmonths.Items.Clear();
        ddlmonths.Items.Insert(0, "--Select--");
        for (int i = 1; i < 13; i++)
        {
            ddlyear.Items.Insert(i, i.ToString() + " Year");
            if(i != 12)
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
        lblheading.Text = "Create New Plan";
        ModalPopupCreateLabel.Show();
    }
    private void FillGrdVwPlanMaster()
    {        
        Object9420 Reg = new Object9420();
        Reg.Plan_Name = txtsearchlblname.Text.Trim().Replace("'","''");                
        DataSet ds = function9420.FillGridAMC(Reg);
        GrdLabel.DataSource = ds.Tables[0];
        GrdLabel.DataBind();
        lblcount.Text = GrdLabel.Rows.Count.ToString();         
    }           
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdVwPlanMaster();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtsearchlblname.Text = string.Empty;
        newMsg.Visible = false;
        FillGrdVwPlanMaster();
    }    
    protected void GrdLabel_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdLabel.PageIndex = e.NewPageIndex;
        FillGrdVwPlanMaster();
    }
    private void Cleartxt()
    {
        FillYearMonths();
        lbleditlabelid.Text = "";
        txtlabelprise.Text = string.Empty;
        txtplanname.Text = string.Empty;
        txtplanname.Enabled = true;        
        txtlabelprise.Enabled = true;
        btnSave.Text = "Save";
    }    
    protected void GrdLabel_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Cleartxt();
        Object9420 Reg = new Object9420();
        lbleditlabelid.Text = e.CommandArgument.ToString();
        Reg.Plan_ID = lbleditlabelid.Text;        
        function9420.FillPlanInfo(Reg);
        newMsg.Visible = false; Div1.Visible = false;   
        if (e.CommandName == "EditLabel")
        {
            txtplanname.Text = Reg.Plan_Name;
            txtlabelprise.Text = Reg.Plan_Amount.ToString();
            ddlyear.SelectedIndex = Reg.Plan_year;
            ddlmonths.SelectedIndex = Reg.Plan_months;
            btnSave.Text = "Update";            
            lblheading.Text = "Update Plan";
            ModalPopupCreateLabel.Show();            
        }
        else if (e.CommandName == "ShowHideLabel")
        {            
                     
            lblPassPnlHead.Text = "Alert";
            lblPopMsgText.Text = "Are you sure to " + FindStatus(Reg.Flag) + " <span style='color:blue;' >" + Reg.Plan_Name + " </span>  Plan ?";            
            ModalPopupExtender3.Show(); 
        }
        else if (e.CommandName == "ViewLabelDetails")
        {
            FillLabelDetGrd(Reg);
            ModalPopupLabelPriseDetails.Show();
        }
    }
    private string FindStatus(int Status)
    {
        if (Status == 1)
            return "De-Activate";
        else
            return "Activate";
    }
    private string FindStatus1(int Status)
    {
        if (Status == 0)
            return "De-Activated";
        else
            return "Activated";
    }
    protected void btnYesActivation_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Plan_ID = lbleditlabelid.Text;        
        function9420.UpdatePlanFlag(Reg);
        function9420.FillPlanInfo(Reg);        
        newMsg.Visible = true;               
        newMsg.Attributes.Add("class", "alert_boxes_green");
        Label2.Text = "Status of <span style='color:blue;' >" + Reg.Plan_Name + " </span> is <span style='color:blue;' >" + Reg.Msg + "</span> ! ";
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        FillGrdVwPlanMaster();  
    }    
    protected void btnNoActivation_Click(object sender, EventArgs e)
    {
        
    }
    private void FillLabelDetGrd(Object9420 Reg)
    {
       DataSet ds = function9420.FillPlanLog(Reg);
       function9420.FillPlanInfo(Reg);
       Label1.Text = " Plan Details";
       Label4.Text = "Plan <span style='color:blue;' > " + Reg.Plan_Name + " </span>";         
       GrdViewLabelDetails.DataSource = ds.Tables[0];
       GrdViewLabelDetails.DataBind();
    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewPlan(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Plan_Name] FROM [M_Plan] where [Plan_Name] = '" + res.Trim().Replace("'","''") + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }    
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Plan_Amount = Convert.ToDouble(txtlabelprise.Text);        
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        string script = "";
        Int32 plan_time = 0;        
        Reg.Plan_Name = txtplanname.Text.Trim().Replace("'", "''");
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
        Reg.Plan_Time = plan_time;
        Reg.Flag = 1;      
        if (btnSave.Text == "Save")
        {
            Reg.Plan_ID = function9420.GetLabelCode("Plan");
            Reg.DML = "I";
            function9420.SaveAmcPlan(Reg);
            ProductsLabelPrices.Text = "Plan <span style='color:blue;'>" + Reg.Plan_Name + "</span> has been saved successfully !";
            function9420.UpdateLabelCode("Plan");
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
            function9420.SaveAmcPlan(Reg);            
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green");
            Label2.Text = "Plan <span style='color:blue;'>" + Reg.Plan_Name + "</span>  has been Updated successfully !";
            script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        Cleartxt();
        FillGrdVwPlanMaster();        
    }          
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Cleartxt();
        ModalPopupCreateLabel.Show();
    }
}