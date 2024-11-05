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

public partial class ServiceMaster : System.Web.UI.Page
{
    public int str = 0, strr = 0,lflag =0; public int index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {        
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=ServiceMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {
            FillGrdServiceMaster();
            newMsg.Visible = false;
            lblcount.Text = "0"; 
        }
        Label2.Text = "";
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        lblimg.Visible = false;
        newMsg.Visible = false;
        Cleartxt();
        newMsg.Visible = false;
        lblheading.Text = "Create New Service";
        ModalPopupCreateLabel.Show();
    }
    private void FillGrdServiceMaster()
    {
        ObjService Reg = new ObjService();
        Reg.ServiceName = txtsearchlblname.Text.Trim().Replace("'","''");        
        DataSet ds = ObjService.FillGridService(Reg);
        GrdServiceMaster.DataSource = ds.Tables[0];
        GrdServiceMaster.DataBind();
        lblcount.Text = GrdServiceMaster.Rows.Count.ToString();         
    }           
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdServiceMaster();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtsearchlblname.Text = string.Empty;
        newMsg.Visible = false;
        FillGrdServiceMaster();
    }    
    protected void GrdServiceMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdServiceMaster.PageIndex = e.NewPageIndex;
        FillGrdServiceMaster();
    }
    private void Cleartxt()
    {
        lbleditlabelid.Text = "";
        txtlabelname.Text = string.Empty;
        lblimg.NavigateUrl = string.Empty;
        lblimg.Visible = false;
        btnSave.Text = "Save";
        RFVFileupload.ValidationGroup = "LCR";
        lblheading.Text = "Create New Label";
    }
    private void EditLabel(ObjService Reg)
    {
        txtlabelname.Text = Reg.ServiceName;
        lblimg.NavigateUrl = "~/Data/Service/" + Reg.Image;
        if (Reg.IsShowPrice == 0)
            chkisshowprice.Checked = true;
        else
            chkisshowprice.Checked = false;
        lblimg.Visible = true;
        RFVFileupload.ValidationGroup = "NA";
        btnSave.Text = "Update";
    }
    protected void GrdServiceMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        ObjService Reg = new ObjService();
        lbleditlabelid.Text = e.CommandArgument.ToString();
        Reg.Service_ID = lbleditlabelid.Text;
        ObjService.FillServiceInfo(Reg);
        newMsg.Visible = false; Div1.Visible = false;
        if (e.CommandName == "EditService")
        {            
            EditLabel(Reg);            
            lblheading.Text = "Update Service Details";
            ModalPopupCreateLabel.Show();            
        }
        else if (e.CommandName == "ShowHideService")
        {
            hdntype.Value = "IsActive";             
            lblPassPnlHead.Text = "Alert";
            lblPopMsgText.Text = "Are you sure to " + FindStatus(Reg.IsActive) + " <span style='color:blue;' >" + Reg.ServiceName + "</span>  Service ?";            
            ModalPopupExtender3.Show(); 
        }
        else if (e.CommandName == "DeleteService")
        {
            hdntype.Value = "IsDelete";
            lblPassPnlHead.Text = "Alert";
            lblPopMsgText.Text = "Are you sure to Delete <span style='color:blue;' >" + Reg.ServiceName + "</span>  Service ?";
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
        Reg.Service_ID = lbleditlabelid.Text;
        Reg.EntryDate = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));      
        ObjService.FillServiceInfo(Reg);
        Reg.Image = "NA";
        Reg.DML = "U";
        if (hdntype.Value == "IsActive")
        {
            Reg.Act = "IsActive";
            Reg.IsActive = (Reg.IsActive == 0 ? 1 : 0);
            Reg.IsDelete = 0;
            ObjService.IUpdService(Reg);
            ObjService.FillServiceInfo(Reg); 
            Label2.Text = "Status of <span style='color:blue;' >" + Reg.ServiceName + "</span> is <span style='color:blue;' >" + FindStatus1(Reg.IsActive) + "</span> ! ";
        }
        if (hdntype.Value == "IsDelete")
        {
            Reg.Act = "IsDelete";
            Reg.IsDelete = (Reg.IsDelete == 0 ? 1 : 0);
            Reg.IsActive = 0;
            ObjService.IUpdService(Reg);
            ObjService.FillServiceInfo(Reg); 
            Label2.Text = "<span style='color:blue;' >" + Reg.ServiceName + "</span> is <span style='color:blue;' > Deleted successfully </span>. ";
        }               
        newMsg.Visible = true;               
        newMsg.Attributes.Add("class", "alert_boxes_green");        
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        FillGrdServiceMaster();  
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
    private string getFileName(FileUpload FileUpload, string KeyVal)
    {
        string path = Server.MapPath("../Data");
        path = path + "\\Service";
        try
        {
            DataProvider.Utility.CreateDirectory(path);
        }
        catch (Exception ex)
        {
            LogManager.WriteExe(ex.Message.ToString());
        }
        string ext = Path.GetExtension(FileUpload.FileName);
        path = path + "\\" + KeyVal + ext;
        LabelFileupload.SaveAs(path);
        return KeyVal + ext;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        ObjService Reg = new ObjService();        
        Reg.EntryDate = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));        
        Reg.ServiceName = txtlabelname.Text.Trim().Replace("'", "''");
        if (chkisshowprice.Checked)
            Reg.IsShowPrice = 0;
        else
            Reg.IsShowPrice = 1;
        Reg.Image = "NA";
        if (btnSave.Text == "Save")
        {
            Reg.DML = "I";            
            Reg.Service_ID = function9420.GetLabelCode("Service").Replace("_","");
            Reg.IsActive = 0; Reg.IsDelete = 0;
            if (LabelFileupload.FileName != "")
                Reg.Image = getFileName(LabelFileupload, Reg.Service_ID);
            ObjService.IUpdService(Reg);
            ProductsLabelPrices.Text = "Service <span style='color:blue;' >" + Reg.ServiceName + "</span> has been Created successfully !";
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
            Reg.Service_ID = lbleditlabelid.Text;
            if (LabelFileupload.FileName != "")
                Reg.Image = getFileName(LabelFileupload, Reg.Service_ID);
            ObjService.IUpdService(Reg);
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green");
            Label2.Text = "Price Label <span style='color:blue;' >" + Reg.ServiceName + "</span>  has been Updated successfully !";
            string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        Cleartxt();
        FillGrdServiceMaster();        
    }          
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Cleartxt();
        ModalPopupCreateLabel.Show();
    }
}