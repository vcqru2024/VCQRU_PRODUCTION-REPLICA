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

public partial class FrmBankAccount : System.Web.UI.Page
{
    public int AFlag = 0, index = 0; 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmBankAccount.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!Page.IsPostBack)
        {
            lblmsg.Text = "";
            //FillDateCurrent();
            //FillAccount();
            fillGridDemo();
        }
    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewAccount(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT  [Bank_Name] FROM M_BankAccount where [Bank_Name] = '" + res + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    private void FillDateCurrent()
    {
        txtDateFrom.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy").ToString();
        txtDateTo.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy").ToString();
    }
    private void FillAccount()
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Bank_ID, Bank_Name FROM  M_BankAccount WHERE FLAG = 1");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexIntVal(ds, "Bank_ID", "Bank_Name", ddlStatus, "--Account--");
        ddlStatus.SelectedIndex = 0;
    }
    private void fillGridDemo()
    {        
        string StrAll = "";
        StrAll = "WHERE isnull(M_Consumerid,0) = 0 and ('' like '%" + txtCompName.Text.Trim().Replace("'", "''") + "%' or Bank_Name = '" + txtCompName.Text.Trim().Replace("'", "''") + "')";
        DataSet ds = Business9420.function9420.FillDataGridAccount(StrAll);        
        if (ds.Tables[0].Rows.Count > 0)
            GrdBankAccount.DataSource = ds.Tables[0];
        GrdBankAccount.DataBind();
        lblcount.Text = ds.Tables[0].Rows.Count.ToString();

    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Cleartxt();
        ModalPopupExtenderNewDesign.Show();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd"));
        Reg.Bank_Name = txtbankname.Text.Trim().Replace("'", "''");
        Reg.Account_HolderNm = txtAccHolderNm.Text.Trim().Replace("'", "''");
        Reg.Account_No = txtAccountNo.Text.Trim().Replace("'", "''"); //;//Business9420.function9420.GetTrans_No();
        Reg.Branch = txtBranch.Text.Trim().Replace("'", "''");
        Reg.IFSC_Code = txtifscCode.Text.Trim().Replace("'", "''");
        Reg.City = txtCity.Text.Trim().Replace("'", "''");
        Reg.RTGS_Code = txtrtgsCode.Text.Trim().Replace("'", "''");
        Reg.Address = txtaddress.Text.Trim().Replace("'", "''");
        if (rdcurrent.Checked == true)
            Reg.Account_Type = "Current";
        else
            Reg.Account_Type = "Saving";           
        Reg.Flag = 1;        
        if(btnSubmit.Text == "Save")
        {
            Reg.DML = "I";
            function9420.BankInfo(Reg);
            DivNewMsg.Visible = true;
            DivNewMsg.Attributes.Add("class", "alert_boxes_green big_msg");
            lblpopmsg.Text = "Bank Account <span style='color:blue;' >" + Reg.Bank_Name + "</span> is related information registered successfully !";
            fillGridDemo();
            btnSubmit.Text = "Save";            
            lblAddAccountHeader.Text = "Add New Bank Account";
            ModalPopupExtenderNewDesign.Show();
            string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        else if (btnSubmit.Text == "Update")
        {
            Reg.Bank_ID = lblBankId.Text;
            Reg.DML = "U";
            function9420.BankInfo(Reg);
            DivNewMsg.Visible = true;
            DivNewMsg.Attributes.Add("class", "alert_boxes_green big_msg");
            lblmsgHeader.Text = "Bank Account <span style='color:blue;' >" + Reg.Bank_Name + "</span> is related information are updated !";
            fillGridDemo();            
            btnSubmit.Text = "Save";            
            lblAddAccountHeader.Text = "Add New Bank Account";
            string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        Cleartxt();
        FillAccount();                
    }
    private void ShowAsSavingData()
    {
        txtbankname.Enabled = false;
        lblpopmsg.Enabled = false;
        txtAccHolderNm.Enabled = false;
        txtAccountNo.Enabled = false;
        txtBranch.Enabled = false;
        txtifscCode.Enabled = false;
        txtCity.Enabled = false;
        txtrtgsCode.Enabled = false;
        txtaddress.Enabled = false;
        rdcurrent.Enabled = false;
        rdsaving.Enabled = false;        
    }
    private void ShowAsSavingClear()
    {
        txtbankname.Enabled = true;
        lblpopmsg.Enabled = true;
        txtAccHolderNm.Enabled = true;
        txtAccountNo.Enabled = true;
        txtBranch.Enabled = true;
        txtifscCode.Enabled = true;
        txtCity.Enabled = true;
        txtrtgsCode.Enabled = true;
        txtaddress.Enabled = true;
        rdcurrent.Enabled = true;
        rdsaving.Enabled = true;
    }
    private void Cleartxt()
    {
        txtbankname.Text = string.Empty;
        //lblpopmsg.Text = string.Empty;
        txtAccHolderNm.Text = string.Empty;
        txtAccountNo.Text = string.Empty;
        txtBranch.Text = string.Empty;
        txtifscCode.Text = string.Empty;
        txtCity.Text = string.Empty;
        txtrtgsCode.Text = string.Empty;
        txtaddress.Text = string.Empty;
        rdcurrent.Checked = true;
        rdsaving.Checked = false;
        FillAccount();
        ShowAsSavingClear();
        btnSubmit.Text = "Save";
    }

    protected void BtnSearchDemo_Click(object sender, ImageClickEventArgs e)
    {
        lblmsg.Text = "";
        fillGridDemo();
    }
    protected void BtnSearchDemoRefesh_Click(object sender, ImageClickEventArgs e)
    {
        FillDateCurrent();
        lblmsg.Text = ""; FillAccount();
        fillGridDemo();
    }
    protected void GrdCodePrintDemo_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdBankAccount.PageIndex = e.NewPageIndex;
        fillGridDemo();
    }

    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        lblmsg.Text = "";
        Cleartxt();
        DivNewMsg.Visible = false; newMsg.Visible = false;
        lblAddAccountHeader.Text = "Add New Bank Account";
        ModalPopupExtenderNewDesign.Show();        
    }
    protected void GrdBankAccount_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Object9420 Reg = new Object9420();
        lblBankId.Text = e.CommandArgument.ToString();
        Reg.Bank_ID = lblBankId.Text;
        if (e.CommandName == "AccountEdit")
        {
            function9420.GetBankInfo(Reg);
            txtbankname.Text = Reg.Bank_Name;
            txtAccHolderNm.Text = Reg.Account_HolderNm;
            txtAccountNo.Text = Reg.Account_No;
            txtBranch.Text = Reg.Branch;
            txtifscCode.Text = Reg.IFSC_Code;
            txtCity.Text = Reg.City;
            txtrtgsCode.Text = Reg.RTGS_Code;
            txtaddress.Text = Reg.Address;
            if (Reg.Account_Type == "Current")
            {
                rdsaving.Checked = false;
                rdcurrent.Checked = true;
            }
            else
            {
                rdcurrent.Checked = false;
                rdsaving.Checked = true;
            }
            btnSubmit.Text = "Update";
            DivNewMsg.Visible = false;
            lblAddAccountHeader.Text = "Update Bank Account";
            ModalPopupExtenderNewDesign.Show();
        } 
        else if (e.CommandName == "ActCommand")
        {
            string str =  function9420.UpdateActivationFlag(Reg);
            string[] Arr = str.ToString().Split(',');
            int i = Convert.ToInt32(Arr[0]);
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
            if(i == 1)
                lblmsgHeader.Text = "Bank Account <span style='color:blue;' >" + Arr[1].ToString() + "</span> is Acivated !";  
            else
                lblmsgHeader.Text = "Bank Account <span style='color:blue;' >" + Arr[1].ToString() + "</span> is De-Acivated !";
            FillAccount();           
            string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);            
        }
        fillGridDemo();
    }
}
