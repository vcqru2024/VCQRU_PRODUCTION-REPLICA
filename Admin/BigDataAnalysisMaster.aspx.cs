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

public partial class Admin_BigDataAnalysisMaster : System.Web.UI.Page
{
    private int _pkid;
    public int Pkid
    {
        //get { return _prop_Referralid; }
        //set { _prop_Referralid = value; }
        get
        {
            if (ViewState["_pkid"] == null)
            {
                return 0;
            }
            else
            {
                return (int)ViewState["_pkid"];
            }

        }
        set { ViewState["_pkid"] = value; }
    }
    public int str = 0, strr = 0, aflag = 0, dflag = 0; public int index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=BigDataAnalysisMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/info/Login.aspx");
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
        lblheading.Text = "Add New Record";
        ModalPopupCreateLabel.Show();
    }
    private void FillGrdLoyaltyAwards()
    {
        Loyalty_Awards Reg = new Loyalty_Awards();
        Reg.RowId = 0;
        Reg.Comp_ID = ProjectSession.strUser_Type;//Session["CompanyId"].ToString();
        Reg.DataQty = txtDataQuantity.Text == "" ? 0 : Convert.ToInt32(txtDataQuantity.Text.Trim().Replace("'", "''"));
        Reg.DataPrice = txtPrice.Text == "" ? 0 : Convert.ToInt32(txtPrice.Text.Trim().Replace("'", "''"));

       // DataSet ds = Loyalty_Awards.FillLoyaltyAwardsGrid(Reg);
        DataSet ds =  ExecuteNonQueryAndDatatable.GetBigdataAnalysisData(Reg);
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
        txtDataQuantity.Text = string.Empty;
        txtPrice.Text = string.Empty;
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
        txtQuantity1.Text = string.Empty;
        txtDataPrice1.Text = string.Empty;        
        btnSave.Text = "Save";
        lblheading.Text = "Add New Record";
    }
    private void EditLabel(Loyalty_Awards Reg)
    {
        txtQuantity1.Text = Reg.DataQty.ToString();
        txtDataPrice1.Text = Reg.DataPrice.ToString();        
        btnSave.Text = "Update";     
    }
    protected void GrdAwards_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Loyalty_Awards Reg = new Loyalty_Awards();
        lbleditlabelid.Text = e.CommandArgument.ToString();
        Reg.RowId = Convert.ToInt64(lbleditlabelid.Text);
        Pkid = Convert.ToInt32(lbleditlabelid.Text);
        newMsg.Visible = false; Div1.Visible = false;
        Reg.Comp_ID = ""; //Session["CompanyId"].ToString();
        Reg.AwardName = "";

        //Loyalty_Awards.FillLoyaltyAwardsGridObject(Reg);
        DataTable dt = ExecuteNonQueryAndDatatable.BigdataAnalysisDataSelect(Reg).Tables[0];

        Reg.DataQty = Convert.ToInt32(dt.Rows[0]["DataQty"].ToString());
        Reg.DataPrice = Convert.ToDecimal(dt.Rows[0]["Price"]);
        Reg.IsDelete = Convert.ToInt32(dt.Rows[0]["Isdelete1"]);
        Reg.IsActive = Convert.ToInt32(dt.Rows[0]["IsActive1"]);
       // Reg.Comp_ID = dt.Rows[0]["Comp_ID"].ToString();
        Reg.RowId = Convert.ToInt64(dt.Rows[0]["BigDataAnalysisDataid"]);


        if (e.CommandName == "EditLabel")
        {            
            EditLabel(Reg);
            lblheading.Text = "Update Record";
            ModalPopupCreateLabel.Show();            
        }
        else if (e.CommandName == "IsActive")
        {
            hdnIsActive.Value = Reg.IsActive.ToString(); hdntype.Value = "IsActive";        
            lblPassPnlHead.Text = "Alert";
            //lblPopMsgText.Text = "Are you sure to " + FindStatus(Reg.IsActive) + " <span style='color:blue;' >" + Reg.DataQty + "</span>  for ( " + Reg.Points + " )  Points ?";            
            if (Reg.IsActive.ToString() == "0")
                lblPopMsgText.Text = "Are you sure you want to De-Activate this record?";
            else
            {
                lblPopMsgText.Text = "Are you sure you want to Activate this record?";
            }
            ModalPopupExtender3.Show(); 
        }
        else if (e.CommandName == "IsDelete")
        {
            hdnIsActive.Value = Reg.IsDelete.ToString(); hdntype.Value = "IsDelete";   
            lblPassPnlHead.Text = "Alert";
            lblPopMsgText.Text = "Are you sure to delete this record?";
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
       // Reg.Comp_ID = Session["CompanyId"].ToString();
      //  Reg.AwardName = "";
       // Loyalty_Awards.FillLoyaltyAwardsGridObject(Reg);
       // DataTable dt = ExecuteNonQueryAndDatatable.BigdataAnalysisDataActive(Reg).Tables[0];
        Reg.DML = hdntype.Value;
        if (Reg.DML == "IsActive")
        {
            if (Convert.ToInt32(hdnIsActive.Value) == 0)
                Reg.IsActive = 1;
            else
                Reg.IsActive = 0;
            // Label2.Text = "Status of <span style='color:blue;' >" + Reg.AwardName + "</span>  ( " + FindStatus(Reg.IsActive) + " ) is <span style='color:blue;' >" + Reg.Msg + "</span> ! ";
            Label2.Text = FindStatus(Reg.IsActive) + " Successfully";
        }
        else if (Reg.DML == "IsDelete")
        {
            if (Convert.ToInt32(hdnIsDelete.Value) == 0)
                Reg.IsDelete = 1;
            else
                Reg.IsDelete = 0;
            //  Label2.Text = "Status of <span style='color:blue;' >" + Reg.AwardName + "</span>  ( " + FindStatus1(Reg.IsDelete) + " ) is <span style='color:blue;' >" + Reg.Msg + "</span> ! ";
            Label2.Text = "Deleted Successfully";
        }
        Loyalty_Awards.IsActiveIsDeleteBigDtataAlnalysisDATA(Reg);        
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
        int pkid2 = Pkid;// Convert.ToInt32(lbleditlabelid.Text);
        if (btnSave.Text == "Save")
        {

            DataSet ds2 = SQL_DB.ExecuteDataSet("SELECT * FROM [BigDataAnalysisData] WHERE  DataQty = " + txtQuantity1.Text );//and Price = " + txtDataPrice1.Text
            if (ds2.Tables[0].Rows.Count > 0)
            {
                Div1.Attributes.Remove("class");
                //Div1.Attributes.Add("class", "alert_boxes_red");
                Div1.Visible = true;
                Div1.Attributes.Add("class", "alert_boxes_pink");
                // Label6.Text = "Award <span style='color:blue;' >" + Reg.AwardName + "</span> for  ( " + Reg.Points + " ) Points has been Created successfully !";
                Label6.Text = "Record already exists for Quantity <b>" + txtQuantity1.Text + "</b>";
                ModalPopupCreateLabel.Show();
                string script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            }
            else
            {
                //insert 
                string str4 = "insert into [BigDataAnalysisData] (DataQty,Price,CreatedDate) Values (" + txtQuantity1.Text + "," + txtDataPrice1.Text + ",'" + DateTime.Now.ToString("MM/dd/yyyy") + "')";
                SQL_DB.ExecuteNonQuery(str4);
                lblallotmsg.Text = "";
                Div1.Visible = true;
                Div1.Attributes.Add("class", "alert_boxes_green");
                // Label6.Text = "Award <span style='color:blue;' >" + Reg.AwardName + "</span> for  ( " + Reg.Points + " ) Points has been Created successfully !";
                Label6.Text = "Updated Successfully";
                ModalPopupCreateLabel.Show();
                string script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                Cleartxt();
                FillGrdLoyaltyAwards();
            }
        }
        else
        {
            DataSet ds2 = SQL_DB.ExecuteDataSet("SELECT * FROM [BigDataAnalysisData] WHERE  DataQty = " + txtQuantity1.Text + "  and BigDataAnalysisDataid not in (" + Pkid + ")");
            if (ds2.Tables[0].Rows.Count > 0)
            {
                Div1.Attributes.Remove("class");
                //Div1.Attributes.Add("class", "alert_boxes_red");
                Div1.Visible = true;
                Div1.Attributes.Add("class", "alert_boxes_pink");
                // Label6.Text = "Award <span style='color:blue;' >" + Reg.AwardName + "</span> for  ( " + Reg.Points + " ) Points has been Created successfully !";
                Label6.Text = "Record already exists for Quantity <b>" + txtQuantity1.Text + "</b>";
                ModalPopupCreateLabel.Show();
                string script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            }
            else
            {
                //Update 
                SQL_DB.ExecuteNonQuery("Update [BigDataAnalysisData] set DataQty = " + txtQuantity1.Text + ",Price=" + txtDataPrice1.Text + ",ModifiedDate='" + DateTime.Now.ToString("MM/dd/yyyy") + "' where BigDataAnalysisDataid= " + Pkid);
                   
                newMsg.Visible = true;
                newMsg.Attributes.Add("class", "alert_boxes_green");
                // Label2.Text = "Award <span style='color:blue;' >" + Reg.AwardName + "</span>  for ( " + Reg.Points + " ) Points has been Updated successfully !";
                Label2.Text = "Updated Successfully";
                string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                lblallotmsg.Text = "";
                Cleartxt();
                FillGrdLoyaltyAwards();
            }
            //Loyalty_Awards.InsertUpdateLoyaltyAward(Reg);
        }


        //Loyalty_Awards Reg = new Loyalty_Awards();
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //Reg.AwardName = txtlabelname.Text.Trim().Replace("'","''");
        //Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        //Reg.Points = Convert.ToDecimal(txtlabelprise.Text);
        if (btnSave.Text == "Save")
        {
            //Reg.DML = "I";
            //Reg.RowId = 0;
            //Reg.IsActive = 0;
            //Reg.IsDelete = 0;
          //  function9420.UpdateLabelCode("Label");            
           
        }
        else
        {
            //Reg.DML = "U";
            //Reg.RowId = Convert.ToInt64(lbleditlabelid.Text);            
           
        }
       

        //Loyalty_Awards.InsertUpdateLoyaltyAward(Reg);
       
        // arb, disable double click 
        //btnSave.Enabled = false;
    }          
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Cleartxt();
        ModalPopupCreateLabel.Show();
    }
}