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

public partial class FrmStateMaster : System.Web.UI.Page
{

    public int str = 0, strr = 0,lflag =0; public int index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {        
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmStateMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {            
            FillGrdVwStateMaster();
            newMsg.Visible = false;            
        }
        Label2.Text = "";
    }    
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {                
        newMsg.Visible = false;
        Cleartxt();        
        newMsg.Visible = false;
        lblheading.Text = "Add New Country";
        ModalPopupRegCity.Show();
    }    
    private void FillGrdVwStateMaster()
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT ROW_NUMBER() OVER(ORDER BY [StateName]) AS sno, [STATE_ID],[StateName],[COUNTRY_ID],Flag,case when Flag = 1 then 'Click for De-Activate' else 'Click for Active' end as TooTipMsg FROM [StateMaster] where [StateName] like '%" + txtsearchlblname.Text.Trim().Replace("'", "''") + "%' AND [COUNTRY_ID] is not null and ('' = '' OR STATE_ID = '') ORDER BY  StateName");
        if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        {
            if (ds.Tables[0].Rows.Count > 0)
                GrdVwCity.PageSize = ds.Tables[0].Rows.Count;
        }
        else
            GrdVwCity.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        GrdVwCity.DataSource = ds.Tables[0];
        GrdVwCity.DataBind();
        if (GrdVwCity.Rows.Count > 0)
            lblcount.Text = ds.Tables[0].Rows.Count.ToString();
        else
            lblcount.Text = "0";         
    }
    protected void ddlRowProductCnt_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillGrdVwStateMaster();
    }      
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdVwStateMaster();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtsearchlblname.Text = string.Empty;
        newMsg.Visible = false;
        FillGrdVwStateMaster();
    }
    protected void GrdVwCity_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdVwCity.PageIndex = e.NewPageIndex;
        FillGrdVwStateMaster();
    }
    private void Cleartxt()
    {
        FillCountry();
        txtcityname.Text = string.Empty;
        ddlstate.SelectedIndex = 0;
        btnSave.Text = "Save";
    }
    private void FillCountry()
    {
        DataSet ds = function9420.fetchCountry();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexIntVal(ds, "Country_Id", "Country_Name", ddlstate, "--Select--");
        ddlstate.SelectedIndex = 0;        
    }
    protected void GrdVwCity_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Cleartxt();
        Object9420 Reg = new Object9420();
        lbleditlabelid.Text = e.CommandArgument.ToString();
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT STATE_ID, stateName, COUNTRY_ID, Flag  FROM  StateMaster where [COUNTRY_ID] is not null and ('' = '" + lbleditlabelid.Text + "' OR STATE_ID = '" + lbleditlabelid.Text + "') ORDER BY  stateName");
        newMsg.Visible = false; Div1.Visible = false;
        if (e.CommandName == "EditCity")
        {

            FillCountry();
            ddlstate.SelectedValue = ds.Tables[0].Rows[0]["COUNTRY_ID"].ToString();
            txtcityname.Text = ds.Tables[0].Rows[0]["stateName"].ToString();
            btnSave.Text = "Update";
            lblheading.Text = "Update State";
            ModalPopupRegCity.Show();
        }
        else if (e.CommandName == "ShowHideLabel")
        {
            hdnflag.Value = ds.Tables[0].Rows[0]["Flag"].ToString();
            lblPassPnlHead.Text = "Alert";
            lblPopMsgText.Text = "Are you sure to " + FindStatus(Convert.ToInt32(ds.Tables[0].Rows[0]["Flag"].ToString())) + " <span style='color:blue;' >" + ds.Tables[0].Rows[0]["stateName"].ToString() + " </span>  State Name ?";
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
        if (Status == 1)
            return "Activate";
        else
            return "De-Activate";
    }
    protected void btnYesActivation_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Row_ID = lbleditlabelid.Text;
        int flag = 0;
        if (hdnflag.Value == "0")
            flag = 1;
        else
            flag = 0;
        SQL_DB.ExecuteDataSet("UPDATE [StateMaster] SET [Flag] = '" + flag + "' WHERE [STATE_ID] = " + Convert.ToInt32(lbleditlabelid.Text) + " ");
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [STATE_ID],[stateName],[COUNTRY_ID],[Flag] FROM [StateMaster] where [COUNTRY_ID] is not null and ('' = '" + lbleditlabelid.Text + "' OR STATE_ID = '" + lbleditlabelid.Text + "') ORDER BY  StateName");
        newMsg.Visible = true;
        newMsg.Attributes.Add("class", "alert_boxes_green");
        Label2.Text = "Status of <span style='color:blue;' >" + ds.Tables[0].Rows[0]["stateName"].ToString() + " </span> is <span style='color:blue;' >" + FindStatus1(Convert.ToInt32(ds.Tables[0].Rows[0]["Flag"].ToString())) + "</span> ! ";
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        FillGrdVwStateMaster();
    }
    protected void btnNoActivation_Click(object sender, EventArgs e)
    {

    }      
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewCity(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [StateName] FROM [StateMaster] where [StateName] = '" + res.Trim().Replace("'", "''") + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }    
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string script = "";
        if (btnSave.Text == "Save")
        {
            SQL_DB.ExecuteDataSet("INSERT INTO [StateMaster] ([StateName],[COUNTRY_ID]) VALUES ('" + txtcityname.Text.Trim().Replace("'", "''") + "'," + Convert.ToInt32(ddlstate.SelectedValue) + ") ");
            ProductsLabelPrices.Text = "State <span style='color:blue;'>" + txtcityname.Text.Trim().Replace("'", "''") + "</span> has been saved successfully !";            
            Div1.Visible = true;
            Div1.Attributes.Add("class", "alert_boxes_green");
            ModalPopupRegCity.Show();
            script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        else
        {
            SQL_DB.ExecuteDataSet("UPDATE [StateMaster] SET [StateName] = '" + txtcityname.Text.Trim().Replace("'", "''") + "',[COUNTRY_ID] = " + Convert.ToInt32(ddlstate.SelectedValue) + " WHERE [STATE_ID] = " + Convert.ToInt32(lbleditlabelid.Text) + " ");           
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green");
            Label2.Text = "City <span style='color:blue;'>" + txtcityname.Text.Trim().Replace("'", "''") + "</span>  has been Updated successfully !";
            script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        Cleartxt();
        FillGrdVwStateMaster();        
    }          
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Cleartxt();
        ModalPopupRegCity.Show();
    }           
}