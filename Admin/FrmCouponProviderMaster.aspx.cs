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

public partial class FrmCouponProviderMaster : System.Web.UI.Page
{
    public int Flag = 0, index = 0, sno = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmCouponProviderMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!Page.IsPostBack)
        {
            lblmsgHeader.Text = "";
            FillGrid();
        }
    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewLabel(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [CouponProviderName] FROM [M_CouponProvider] WHERE  [CouponProviderName]  = '" + res + "' ");
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
    private void Clear()
    {
        dhnactiontype.Value = string.Empty;
        txtCPerson.Text = "";
        txtContactNo.Text = "";
        txtEmail.Text = "";
        txtName.Text = "";
        lblAddCourierHeader.Text = "Add New Courier";
        btnSubmit.Text = "Save";
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
        CouponProver Reg = new CouponProver();
        Reg.DML = "F";
        Reg.CouponProviderName = txtSearchName.Text.Trim().Replace("'", "''");
        DataTable DsGrd = new DataTable();
        DsGrd = Business9420.CouponProver.CPMFillDataGrid(Reg);
        GrdVw.DataSource = DsGrd;
        GrdVw.DataBind();
        lblcount.Text = DsGrd.Rows.Count.ToString();
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
        Reg.CouponProvider_Id = Convert.ToInt64(lblBankId.Text); newMsg.Visible = false;
        Reg.DML = "S";
        CouponProver.CPMFillDataGrid(Reg);
        if (e.CommandName.ToString() == "EditRow")
        {
            txtName.Text = Reg.CouponProviderName;
            txtEmail.Text = Reg.CouponProviderEmail;
            txtContactNo.Text = Reg.CouponProviderContactNo;
            txtCPerson.Text = Reg.CouponProviderContactPerson;
            lblAddCourierHeader.Text = "Courier update Details";
            btnSubmit.Text = "Update";
            ModalPopupExtenderNewDesign.Show();
        }
        else if (e.CommandName.ToString() == "DeleteRow")
        {
            dhnactiontype.Value = "D";
            LabelAlertheader.Text = "Alert";
            LabelAlertText.Text = "Are you sure to dalete  <span style='color:blue;' >" + Reg.CouponProviderName + "</span>  Courier Company permanently?";
            ModalPopupExtenderAlert.Show();
        }
        else if (e.CommandName.ToString() == "ActivateRow")
        {
            dhnactiontype.Value = "A";
            LabelAlertheader.Text = "Alert";
            LabelAlertText.Text = "Are you sure to <span style='color:blue;' > " + FindStatus(Reg.IsActive) + " </span> <span style='color:blue;' >" + Reg.CouponProviderName + "</span>  Courier Company permanently?";
            ModalPopupExtenderAlert.Show();
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
        Reg.CouponProvider_Id = Convert.ToInt64(lblBankId.Text);
        Reg.DML = "S";
        CouponProver.CPMFillDataGrid(Reg);
        if (dhnactiontype.Value == "A")
        {
            Reg.DML = "A";
            if (Reg.IsActive == 0)
            {
                Reg.IsActive = 1;
                lblmsgHeader.Text = "Courier <span style='color:blue;' >" + Reg.CouponProviderName + "</span> has benn <span style='color:blue;' > " + FindStatusNew(Reg.IsActive) + " </span>  successfully.";
            }
            else
            {
                Reg.IsActive = 0;
                lblmsgHeader.Text = "Courier <span style='color:blue;' >" + Reg.CouponProviderName + "</span> has benn <span style='color:blue;' > " + FindStatusNew(Reg.IsActive) + " </span>  successfully.";
            }
        }
        else if (dhnactiontype.Value == "D")
        {
            Reg.DML = "D";
            if (Reg.IsDelete == 0)
                Reg.IsDelete = 1;
            else
                Reg.IsDelete = 0;
            lblmsgHeader.Text = "Courier <span style='color:blue;' >" + Reg.CouponProviderName + "</span> has benn deleted  successfully.";
        }
        CouponProver.CPMActivateDelete(Reg);
        newMsg.Visible = true;
        newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        FillGrid();
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        CouponProver Reg = new CouponProver();
        Reg.EntryDate = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        Reg.CouponProviderName = txtName.Text.Trim().Replace("'", "''");
        Reg.CouponProviderEmail = txtEmail.Text.Trim().Replace("'", "''");
        Reg.CouponProviderContactPerson = txtCPerson.Text.Trim().Replace("'", "''");
        Reg.CouponProviderContactNo = txtContactNo.Text.Trim().Replace("'", "''");
        if (btnSubmit.Text == "Save")
        {
            Reg.DML = "I";
            lblmsgHeader.Text = "Courier <span style='color:blue;' >" + Reg.CouponProviderName + "</span> has been registered successfully.";
        }
        else
        {
            Reg.CouponProvider_Id = Convert.ToInt64(lblBankId.Text);
            Reg.DML = "U";
            lblmsgHeader.Text = "Courier <span style='color:blue;' >" + Reg.CouponProviderName + "</span> has beeb updated successfully.";
        }
        CouponProver.CPMInsertUpdate(Reg);
        newMsg.Visible = true;
        newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        Clear();
        FillGrid();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Clear(); newMsg.Visible = false; DivNewMsg.Visible = false;
        ModalPopupExtenderNewDesign.Show();
    }
}
