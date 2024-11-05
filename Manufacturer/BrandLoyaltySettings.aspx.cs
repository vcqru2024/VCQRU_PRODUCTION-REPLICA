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

public partial class BrandLoyaltySettings : System.Web.UI.Page
{
    private string _prop_Referral;
    public string Prop_ReferralLimit
    {
        get { return (string)ViewState["_prop_Referral"]; }
        set { ViewState["_prop_Referral"] = value; }
    }
    private int _prop_Referralid;
    public int Prop_Referralid
    {
        //get { return _prop_Referralid; }
        //set { _prop_Referralid = value; }
        get {
            if (ViewState["_prop_Referralid"] != null)
                return (int)ViewState["_prop_Referralid"];
            else
                return 0;
        }
        set { ViewState["_prop_Referralid"] = value; }
    }
    public int str = 0, strr = 0,lflag =0; public int index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {  
        if (Session["CompanyId"] == null)
            Response.Redirect("../Info/Login.aspx?Page=RegisteredProduct.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["Referral"] != null)
            {
                Prop_ReferralLimit = Request.QueryString["Referral"].ToString();
            }
            FillGrdLabel(Prop_ReferralLimit);
            newMsg.Visible = false;  
        }        
        Label2.Text = "";
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        
    }
    private void FillGrdLabel(string strReferral)
    {
        Loyalty_Settings Reg = new Loyalty_Settings();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.Referral = strReferral;
        if (Reg.Referral == "1")
        {
            tblBL.Visible = false;
            tblRS.Visible = true;
            lblSet.Text = "Referral Limit Setting";
        }
        else
        {
            tblBL.Visible = true;
            tblRS.Visible = false;
        }
       
     
        DataSet ds = Loyalty_Settings.FillLoyaltySettingsGrid(Reg);
        if (ds.Tables[0].Rows.Count > 0)
        {
            if (Reg.Referral == "1")
            {
                
                txtLimit.Text = ds.Tables[0].Rows[0]["Limit"].ToString();
                Prop_Referralid = Convert.ToInt32(ds.Tables[0].Rows[0]["ReferralID"].ToString());
            }
            else
            {
              
                txtminbanktransfer.Text = ds.Tables[0].Rows[0]["Min_Bank_Transfer"].ToString();
                txtonersequalto.Text = ds.Tables[0].Rows[0]["Points"].ToString();
                txtMinimumRefAmount.Text = ds.Tables[0].Rows[0]["MinimumReferralAmountLimit"].ToString();
                if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsActive"]) == 0)
                    chkIsActive.Checked = true;
                else
                    chkIsActive.Checked = false;
                if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsDelete"]) == 0)
                    chkIsDelete.Checked = false;
                else
                    chkIsDelete.Checked = true;
                if (Convert.ToInt32(ds.Tables[0].Rows[0]["Courier"]) == 0)
                    chkcourier.Checked = true;
                else
                    chkcourier.Checked = false;
                if (Convert.ToInt32(ds.Tables[0].Rows[0]["Dealer"]) == 0)
                    chkdealer.Checked = true;
                else
                    chkdealer.Checked = false;

            }

            btnSave.Text = "Update";
        }
        else
            btnSave.Text = "Save";         
    }               
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewLabel(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Label_Name] FROM [M_Label] where [Label_Name] = '" + res + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }    
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Loyalty_Settings Reg = new Loyalty_Settings();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        if (Prop_ReferralLimit == "1")
        {
            Reg.ReferralLimit = txtLimit.Text;
            Reg.ReferralID = Prop_Referralid;
            if (btnSave.Text == "Save")
            {
                Reg.DML = "I";
                Label2.Text = "Referral Limit has been saved successfully !";
                newMsg.Visible = true;
                newMsg.Attributes.Add("class", "alert_boxes_green");
                string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            }
            else
            {
                Reg.DML = "U";
                newMsg.Visible = true;
                newMsg.Attributes.Add("class", "alert_boxes_green");
                Label2.Text = "Referral Limit has been updated successfully !";
                string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            }
            Loyalty_Settings.InsertUpdateReferralLimit(Reg);
        }
        else
        {
            
            Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
            Reg.Min_Bank_Transfer = Convert.ToDecimal(txtminbanktransfer.Text.Trim().Replace("'", "''"));
            Reg.Points = Convert.ToDecimal(txtonersequalto.Text.Trim().Replace("'", "''"));
            Reg.ReferralLimit = txtMinimumRefAmount.Text;
            if (chkIsActive.Checked)
                Reg.IsActive = 0;
            else
                Reg.IsActive = 1;
            if (chkIsDelete.Checked)
                Reg.IsDelete = 1;
            else
                Reg.IsDelete = 0;
            if (chkcourier.Checked)
                Reg.Courier = 0;
            else
                Reg.Courier = 1;
            if (chkdealer.Checked)
                Reg.Dealer = 0;
            else
                Reg.Dealer = 1;
            if (btnSave.Text == "Save")
            {
                Reg.DML = "I";
                Label2.Text = "Loyalty Settings Min. Bank Tranfer <span style='color:blue;' >" + Reg.Min_Bank_Transfer + "</span> 1 Rs. Equal to ( " + Reg.Points + " ) Points has been saved successfully !";
                newMsg.Visible = true;
                newMsg.Attributes.Add("class", "alert_boxes_green");
                string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            }
            else
            {
                Reg.DML = "U";
                newMsg.Visible = true;
                newMsg.Attributes.Add("class", "alert_boxes_green");
                Label2.Text = "Loyalty Settings Min. Bank Tranfer <span style='color:blue;' >" + Reg.Min_Bank_Transfer + "</span> 1 Rs. Equal to ( " + Reg.Points + " ) Points has been updated successfully !";
                string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            }
            Loyalty_Settings.InsertUpdateLoyalty(Reg);

        }
        FillGrdLabel(Prop_ReferralLimit);
    }         
    protected void btnReset_Click(object sender, EventArgs e)
    {
        newMsg.Visible = false;
        FillGrdLabel(Prop_ReferralLimit);        
    }
}