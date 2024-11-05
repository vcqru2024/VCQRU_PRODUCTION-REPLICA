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

public partial class FrmCategoryMaster : System.Web.UI.Page
{
    public int str = 0, strr = 0,lflag =0; public int index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["User_Type"] = "Admin";
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmCategoryMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {            
            FillGrdVwCategoryMaster();
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
        lblheading.Text = "Add New Category";
        ModalPopupCreateLabel.Show();
    }
    private void FillGrdVwCategoryMaster()
    {        
        Object9420 Reg = new Object9420();
        Reg.Category_ID = "";
        Reg.Category_Name = txtsearchlblname.Text.Trim().Replace("'","''");           
        DataSet ds = function9420.FillGridCategory(Reg);
        GrdCategory.DataSource = ds.Tables[0];
        GrdCategory.DataBind();
        lblcount.Text = GrdCategory.Rows.Count.ToString();         
    }           
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdVwCategoryMaster();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtsearchlblname.Text = string.Empty;
        newMsg.Visible = false;
        FillGrdVwCategoryMaster();
    }
    protected void GrdCategory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdCategory.PageIndex = e.NewPageIndex;
        FillGrdVwCategoryMaster();
    }
    private void Cleartxt()
    {        
        lbleditlabelid.Text = "";        
        txtplanname.Text = string.Empty;
        txtplanname.Enabled = true;                
        btnSave.Text = "Save";
    }
    protected void GrdCategory_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Cleartxt();
        Object9420 Reg = new Object9420();
        lbleditlabelid.Text = e.CommandArgument.ToString();
        Reg.Category_ID = lbleditlabelid.Text;
        DataSet ds = function9420.FillGridCategory(Reg);
        newMsg.Visible = false; Div1.Visible = false;
        if (e.CommandName == "EditCategory")
        {
            txtplanname.Text = ds.Tables[0].Rows[0]["Category_Name"].ToString();
            btnSave.Text = "Update";
            lblheading.Text = "Update Category";
            ModalPopupCreateLabel.Show();            
        }
        else if (e.CommandName == "ShowHideCategory")
        {                                 
            lblPassPnlHead.Text = "Alert";
            lblPopMsgText.Text = "Are you sure to " + FindStatus(Reg.Flag) + " <span style='color:blue;' >" + Reg.Category_Name + " </span>  Category ?";            
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
        Reg.Category_ID = lbleditlabelid.Text;        
        function9420.UpdateCategoryFlag(Reg);
        DataSet ds = function9420.FillGridCategory(Reg);
        Reg.Category_Name = ds.Tables[0].Rows[0]["Category_Name"].ToString();
        Reg.Msg = ds.Tables[0].Rows[0]["Status"].ToString();
        newMsg.Visible = true;               
        newMsg.Attributes.Add("class", "alert_boxes_green");
        Label2.Text = "Status of <span style='color:blue;' >" + Reg.Category_Name + " </span> is <span style='color:blue;' >" + Reg.Msg + "</span> ! ";
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        FillGrdVwCategoryMaster();  
    }    
    protected void btnNoActivation_Click(object sender, EventArgs e)
    {
        
    }    
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewPlan(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Category_Name] FROM [Category_Master] where [Category_Name] = '" + res.Trim().Replace("'", "''") + "'");
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
        Reg.Category_Name = txtplanname.Text.Trim().Replace("'", "''");                
        Reg.Flag = 1;      
        if (btnSave.Text == "Save")
        {
            Reg.Category_ID = function9420.GetCategoryCode("Category");
            Reg.DML = "I";            
            function9420.SaveCategory(Reg);
            ProductsLabelPrices.Text = "Categoty <span style='color:blue;'>" + Reg.Category_Name + "</span> has been saved successfully !";
            function9420.UpdateLabelCode("Category");
            Div1.Visible = true;
            Div1.Attributes.Add("class", "alert_boxes_green");
            ModalPopupCreateLabel.Show();
            script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        else
        {
            Reg.Category_ID = lbleditlabelid.Text;
            Reg.DML = "U";
            function9420.SaveCategory(Reg);            
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green");
            Label2.Text = "Categoty <span style='color:blue;'>" + Reg.Category_Name + "</span>  has been Updated successfully !";
            script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        Cleartxt();
        FillGrdVwCategoryMaster();        
    }          
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Cleartxt();
        ModalPopupCreateLabel.Show();
    }
}