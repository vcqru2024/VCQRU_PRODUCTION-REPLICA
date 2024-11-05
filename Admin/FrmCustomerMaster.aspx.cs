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

public partial class FrmCustomerMaster : System.Web.UI.Page
{
    public int str = 0, strr = 0,lflag =0; public int index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["User_Type"] = "Admin";
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmCustomerMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {
            FillGrdVwCustomerMaster();
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
        lblheading.Text = "Add New Customer";
        ModalPopupCreateLabel.Show();
    }
    private void FillGrdVwCustomerMaster()
    {        
        Object9420 Reg = new Object9420();
        Reg.User_ID = "";
        Reg.Name = txtsearchlblname.Text.Trim().Replace("'", "''");
        DataSet ds = function9420.FillGridCustomer(Reg);
        GrdCustomer.DataSource = ds.Tables[0];
        GrdCustomer.DataBind();
        lblcount.Text = GrdCustomer.Rows.Count.ToString();         
    }           
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdVwCustomerMaster();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtsearchlblname.Text = string.Empty;
        newMsg.Visible = false;
        FillGrdVwCustomerMaster();
    }
    protected void GrdCustomer_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdCustomer.PageIndex = e.NewPageIndex;
        FillGrdVwCustomerMaster();
    }
    private void Cleartxt()
    {
        ddlUserType.SelectedIndex = 0;
        txtaddress.Text = string.Empty;
        txtEmail.Text = string.Empty;
        txtMobileNo.Text = string.Empty;
        lbleditlabelid.Text = "";        
        txtplanname.Text = string.Empty;
        txtplanname.Enabled = true;                
        btnSave.Text = "Save";
    }
    protected void GrdCustomer_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Cleartxt();
        Object9420 Reg = new Object9420();
        lbleditlabelid.Text = e.CommandArgument.ToString();
        Reg.Customer_ID = lbleditlabelid.Text;
        DataSet ds = function9420.FillGridCustomer(Reg);
        newMsg.Visible = false; Div1.Visible = false;
        if (e.CommandName == "EditCustomer")
        {
            ddlUserType.SelectedValue = ds.Tables[0].Rows[0]["User_Type"].ToString();
            txtplanname.Text = ds.Tables[0].Rows[0]["Customer_Name"].ToString();
            txtEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
            txtaddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
            txtMobileNo.Text = ds.Tables[0].Rows[0]["Mobile_No"].ToString();
            btnSave.Text = "Update";
            lblheading.Text = "Update Customer";
            ModalPopupCreateLabel.Show();            
        }
        else if (e.CommandName == "ShowHideCustomer")
        {                                 
            lblPassPnlHead.Text = "Alert";
            lblPopMsgText.Text = "Are you sure to " + FindStatus(Reg.Flag) + " <span style='color:blue;' >" + Reg.Category_Name + " </span>  Customer ?";            
            ModalPopupExtender3.Show(); 
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
        Reg.Customer_ID = lbleditlabelid.Text;        
        function9420.UpdateCustomerFlag(Reg);
        DataSet ds = function9420.FillGridCustomer(Reg);
        Reg.Customer_Name = ds.Tables[0].Rows[0]["Customer_Name"].ToString();
        Reg.Msg = ds.Tables[0].Rows[0]["Status"].ToString();
        newMsg.Visible = true;               
        newMsg.Attributes.Add("class", "alert_boxes_green");
        Label2.Text = "Status of <span style='color:blue;' >" + Reg.Customer_Name + " </span> is <span style='color:blue;' >" + Reg.Msg + "</span> ! ";
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        FillGrdVwCustomerMaster();  
    }    
    protected void btnNoActivation_Click(object sender, EventArgs e)
    {
        
    }    
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewPlan(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Customer_Name] FROM [Customer_Care] where [Email] = '" + res.Trim().Replace("'", "''") + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }    
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        string script = "";      
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));             
        Reg.Customer_Name = txtplanname.Text.Trim().Replace("'", "''");
        Reg.Email = txtEmail.Text.Trim().Replace("'", "''");
        Reg.Address = txtaddress.Text.Trim().Replace("'", "''");
        Reg.Mobile_No = txtMobileNo.Text.Trim().Replace("'", "''");
        Reg.Flag = 1;
        Reg.User_Type = ddlUserType.SelectedValue;
        Random r = new Random();
        Reg.Password = r.Next().ToString().Substring(0, 5);
        if (btnSave.Text == "Save")
        {
            Reg.Customer_ID = function9420.GetLabelCode("Customer").Replace("_","");
            Reg.DML = "I";
            function9420.SaveCustomer(Reg);
            ProductsLabelPrices.Text = "Customer <span style='color:blue;'>" + Reg.Customer_Name + "</span> has been saved successfully !";
            function9420.UpdateLabelCode("Customer");
            Div1.Visible = true;
            Div1.Attributes.Add("class", "alert_boxes_green");
            ModalPopupCreateLabel.Show();
            script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        else
        {
            Reg.Customer_ID = lbleditlabelid.Text;
            Reg.DML = "U";
            function9420.SaveCustomer(Reg);            
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green");
            Label2.Text = "Customer <span style='color:blue;'>" + Reg.Customer_Name + "</span>  has been Updated successfully !";
            script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        Cleartxt();
        FillGrdVwCustomerMaster();        
    }          
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Cleartxt();
        ModalPopupCreateLabel.Show();
    }
}