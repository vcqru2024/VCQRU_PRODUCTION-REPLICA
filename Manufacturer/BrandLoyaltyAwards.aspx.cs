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

public partial class BrandLoyaltyAwards : System.Web.UI.Page
{
    public int str = 0, strr = 0, aflag = 0, dflag = 0; public int index = 0;
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
            FillGrdLoyaltyAwards();
            newMsg.Visible = false;
            lblcount.Text = "0"; 
        }
        Label2.Text = "";
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillGrdLoyaltyAwards();
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        //lblimg.Visible = false;
        lblallotmsg.Text = "";
        newMsg.Visible = false;
        Cleartxt();
        newMsg.Visible = false;
        lblheading.Text = "Add New Award";
        ModalPopupCreateLabel.Show();
    }
    private void FillGrdLoyaltyAwards()
    {
        Loyalty_Awards Reg = new Loyalty_Awards();
        Reg.RowId = 0;
        Reg.Comp_ID = "";// Session["CompanyId"].ToString();
        Reg.AwardName = txtsearchlblname.Text.Trim().Replace("'","''");
        DataSet ds = Loyalty_Awards.FillLoyaltyAwardsGrid(Reg);
        if (ds.Tables.Count > 0)
        {            
            if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
            {
                if (ds.Tables[0].Rows.Count > 0)
                    GrdAwards.PageSize = ds.Tables[0].Rows.Count;
            }
            else
                GrdAwards.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
            if (ds.Tables[0].Rows.Count > 0)
                GrdAwards.DataSource = ds.Tables[0];
            GrdAwards.DataBind();
            lblcount.Text = GrdAwards.Rows.Count.ToString();
            if (GrdAwards.Rows.Count > 0)
                GrdAwards.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
        else
            lblcount.Text = "0";
    }           
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdLoyaltyAwards();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtsearchlblname.Text = string.Empty;
        newMsg.Visible = false;
        FillGrdLoyaltyAwards();
    }
    protected void GrdAwards_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdAwards.PageIndex = e.NewPageIndex;
        FillGrdLoyaltyAwards();
    }
    private void Cleartxt()
    {
       // ProductsLabelPrices.Text = "";
        lbleditlabelid.Text = "";
        txtlabelprise.Text = string.Empty;
        txtlabelname.Text = string.Empty;        
        btnSave.Text = "Save";
        lblheading.Text = "Add New Award";
    }
    private void EditLabel(Loyalty_Awards Reg)
    {
        txtlabelname.Text = Reg.AwardName;
        txtlabelprise.Text = Reg.Points.ToString();        
        btnSave.Text = "Update";     
    }
    protected void GrdAwards_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Loyalty_Awards Reg = new Loyalty_Awards();
        lbleditlabelid.Text = e.CommandArgument.ToString();
        Reg.RowId = Convert.ToInt64(lbleditlabelid.Text);        
        newMsg.Visible = false; Div1.Visible = false;
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.AwardName = "";
        Loyalty_Awards.FillLoyaltyAwardsGridObject(Reg);
        if (e.CommandName == "EditLabel")
        {            
            EditLabel(Reg);
            lblheading.Text = "Update Award";
            ModalPopupCreateLabel.Show();            
        }
        else if (e.CommandName == "IsActive")
        {
            hdnIsActive.Value = Reg.IsActive.ToString(); hdntype.Value = "IsActive";        
            lblPassPnlHead.Text = "Alert";
            lblPopMsgText.Text = "Are you sure to " + FindStatus(Reg.IsActive) + " <span style='color:blue;' >" + Reg.AwardName + "</span>  for ( " + Reg.Points + " )  Points ?";            
            ModalPopupExtender3.Show(); 
        }
        else if (e.CommandName == "IsDelete")
        {
            hdnIsActive.Value = Reg.IsDelete.ToString(); hdntype.Value = "IsDelete";   
            lblPassPnlHead.Text = "Alert";
            lblPopMsgText.Text = "Are you sure to delete <span style='color:blue;' >" + Reg.AwardName + "</span>  for ( " + Reg.Points + " )  Points ?";
            ModalPopupExtender3.Show();
        }
        else if (e.CommandName == "ViewLabelDetails")
        {
            
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
        Loyalty_Awards Reg = new Loyalty_Awards();
        Reg.RowId = Convert.ToInt64(lbleditlabelid.Text);
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.AwardName = "";
        Loyalty_Awards.FillLoyaltyAwardsGridObject(Reg);
        Reg.DML = hdntype.Value;
        if (Reg.DML == "IsActive")
        {
            if (Convert.ToInt32(hdnIsActive.Value) == 0)
                Reg.IsActive = 1;
            else
                Reg.IsActive = 0;
            Label2.Text = "Status of <span style='color:blue;' >" + Reg.AwardName + "</span>  ( " + FindStatus(Reg.IsActive) + " ) is <span style='color:blue;' >" + Reg.Msg + "</span> ! ";
        }
        else if (Reg.DML == "IsDelete")
        {
            if (Convert.ToInt32(hdnIsDelete.Value) == 0)
                Reg.IsDelete = 1;
            else
                Reg.IsDelete = 0;
            Label2.Text = "Status of <span style='color:blue;' >" + Reg.AwardName + "</span>  ( " + FindStatus1(Reg.IsDelete) + " ) is <span style='color:blue;' >" + Reg.Msg + "</span> ! ";
        }
        Loyalty_Awards.IsActiveIsDeleteLoyaltyAwards(Reg);        
        newMsg.Visible = true;               
        newMsg.Attributes.Add("class", "alert_boxes_green");        
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        FillGrdLoyaltyAwards();  
    }    
    protected void btnNoActivation_Click(object sender, EventArgs e)
    {
        
    }
    private void FillLabelDetGrd(Object9420 Reg)
    {
       DataSet ds = function9420.FillLabelPriseInfo(Reg);
       Label1.Text = " Price Details";
       Label4.Text = ds.Tables[0].Rows[0]["Label_Name"].ToString() + "  ( " + ds.Tables[0].Rows[0]["Label_Size"].ToString() + " )";       
       GrdViewLabelDetails.DataSource = ds.Tables[0];
       GrdViewLabelDetails.DataBind();
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
        Loyalty_Awards Reg = new Loyalty_Awards();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.AwardName = txtlabelname.Text.Trim().Replace("'","''");
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        Reg.Points = Convert.ToDecimal(txtlabelprise.Text);
        if (btnSave.Text == "Save")
        {
            Reg.DML = "I";
            Reg.RowId = 0;
            Reg.IsActive = 0;
            Reg.IsDelete = 0;
            function9420.UpdateLabelCode("Label");            
            Div1.Visible = true;
            Div1.Attributes.Add("class", "alert_boxes_green");
            Label6.Text = "Award <span style='color:blue;' >" + Reg.AwardName + "</span> for  ( " + Reg.Points + " ) Points has been Created successfully !";
            ModalPopupCreateLabel.Show();
            string script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        else
        {
            Reg.DML = "U";
            Reg.RowId = Convert.ToInt64(lbleditlabelid.Text);            
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green");
            Label2.Text = "Award <span style='color:blue;' >" + Reg.AwardName + "</span>  for ( " + Reg.Points + " ) Points has been Updated successfully !";
            string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        if (btnSave.Text == "Save")
        {
            Boolean isDuplicate = false;
            DataSet ds = Loyalty_Awards.FillLoyaltyAwardsGrid(Reg);
            // DataRow aa[] = ds.Tables[0].Select("");
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                if (dr[2].ToString() == Reg.AwardName.ToString())
                {
                    isDuplicate = true;
                    break;
                }
            }
            if (isDuplicate)
            {
                Div1.Attributes.Remove("class");
                //Div1.Attributes.Add("class", "alert_boxes_red");
                Div1.Visible = true;

                //ProductsLabelPrices.Visible = true;
                //lblallotmsg.Text = "kjhdfidhdihidsh";
                lblallotmsg.Text = "Award <span style='color:blue;' >" + Reg.AwardName + "</span> is already exists !";
            }
            else
            { 
                Loyalty_Awards.InsertUpdateLoyaltyAward(Reg);
                lblallotmsg.Text = "";
            }
        }
        else
        {
            Loyalty_Awards.InsertUpdateLoyaltyAward(Reg);
        }

        //Loyalty_Awards.InsertUpdateLoyaltyAward(Reg);
        Cleartxt();
        FillGrdLoyaltyAwards();
        // arb, disable double click 
        //btnSave.Enabled = false;
    }          
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Cleartxt();
        ModalPopupCreateLabel.Show();
    }
}