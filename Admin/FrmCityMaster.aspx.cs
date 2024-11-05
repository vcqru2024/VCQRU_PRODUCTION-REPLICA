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

public partial class FrmCityMaster : System.Web.UI.Page
{
    public int str = 0, strr = 0,lflag =0; public int index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {        
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmCityMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {
            Cleartxt();
            FillGrdVwCityMaster();
            newMsg.Visible = false;            
        }
        Label2.Text = "";
    }    
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {                
        newMsg.Visible = false;
        Cleartxt();        
        newMsg.Visible = false;
        lblheading.Text = "Add New City";
        ModalPopupRegCity.Show();
    }    
    private void FillGrdVwCityMaster()
    {
        string Qry ="";
        if (DropDownList1.SelectedIndex > 0)
            Qry = " AND STATE_ID = " + DropDownList1.SelectedValue + " ";
        else
            Qry = " AND STATE_ID IN (SELECT STATE_ID FROM StateMaster where COUNTRY_ID = 1) ";
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT  ROW_NUMBER() OVER(ORDER BY [CityName]) AS sno,[CITY_ID],[CityName],[State_id],Flag,case when Flag = 1 then 'Click for De-Activate' else 'Click for Active' end as TooTipMsg FROM [CityMaster] where [CityName] like '%" + txtsearchlblname.Text.Trim().Replace("'", "''") + "%' AND [State_id] is not null  "+ Qry +"  and ('' = '' OR CITY_ID = '') ORDER BY  CityName");
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
        FillGrdVwCityMaster();
    }      
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdVwCityMaster();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtsearchlblname.Text = string.Empty;
        newMsg.Visible = false;
        FillGrdVwCityMaster();
    }
    protected void GrdVwCity_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdVwCity.PageIndex = e.NewPageIndex;
        FillGrdVwCityMaster();
    }
    private void Cleartxt()
    {
        FillState();
        txtcityname.Text = string.Empty;
        ddlstate.SelectedIndex = 0;
        btnSave.Text = "Save";
    }
    private void FillState()
    {
        DataSet ds = function9420.fetchState();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexIntVal(ds, "STATE_ID", "stateName", ddlstate, "--Select--");
        ddlstate.SelectedIndex = 0;
        ds = function9420.fetchState();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexIntVal(ds, "STATE_ID", "stateName", DropDownList1, "--Select State--");
        DropDownList1.SelectedIndex = 0; 
    }
    protected void GrdVwCity_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Cleartxt();
        Object9420 Reg = new Object9420();
        lbleditlabelid.Text = e.CommandArgument.ToString();
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [CITY_ID],[CityName],[State_id],[Flag] FROM [CityMaster] where [State_id] is not null and ('' = '" + lbleditlabelid.Text + "' OR CITY_ID = '" + lbleditlabelid.Text + "') ORDER BY  CityName");
        newMsg.Visible = false; Div1.Visible = false;
        if (e.CommandName == "EditCity")
        {

            FillState();
            ddlstate.SelectedValue = ds.Tables[0].Rows[0]["State_id"].ToString();
            txtcityname.Text = ds.Tables[0].Rows[0]["CityName"].ToString();
            btnSave.Text = "Update";
            lblheading.Text = "Update City";
            ModalPopupRegCity.Show();
        }
        else if (e.CommandName == "ShowHideLabel")
        {
            hdnflag.Value = ds.Tables[0].Rows[0]["Flag"].ToString();
            lblPassPnlHead.Text = "Alert";
            lblPopMsgText.Text = "Are you sure to " + FindStatus(Convert.ToInt32(ds.Tables[0].Rows[0]["Flag"].ToString())) + " <span style='color:blue;' >" + ds.Tables[0].Rows[0]["CityName"].ToString() + " </span>  City ?";
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
        SQL_DB.ExecuteDataSet("UPDATE [CityMaster] SET [Flag] = '" + flag + "' WHERE [CITY_ID] = " + Convert.ToInt32(lbleditlabelid.Text) + " ");
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [CITY_ID],[CityName],[State_id],[Flag] FROM [CityMaster] where [State_id] is not null and ('' = '" + lbleditlabelid.Text + "' OR CITY_ID = '" + lbleditlabelid.Text + "') ORDER BY  CityName");
        newMsg.Visible = true;
        newMsg.Attributes.Add("class", "alert_boxes_green");
        Label2.Text = "Status of <span style='color:blue;' >" + ds.Tables[0].Rows[0]["CityName"].ToString() + " </span> is <span style='color:blue;' >" + FindStatus1(Convert.ToInt32(ds.Tables[0].Rows[0]["Flag"].ToString())) + "</span> ! ";
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        FillGrdVwCityMaster();
    }
    protected void btnNoActivation_Click(object sender, EventArgs e)
    {

    }      
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewCity(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [CityName] FROM [CityMaster] where [CityName] = '" + res.Trim().Replace("'", "''") + "'");
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
            SQL_DB.ExecuteDataSet("INSERT INTO [CityMaster] ([CityName],[State_id]) VALUES ('" + txtcityname.Text.Trim().Replace("'", "''") + "',"+ Convert.ToInt32(ddlstate.SelectedValue) +") ");
            ProductsLabelPrices.Text = "City <span style='color:blue;'>" + txtcityname.Text.Trim().Replace("'", "''") + "</span> has been saved successfully !";            
            Div1.Visible = true;
            Div1.Attributes.Add("class", "alert_boxes_green");
            ModalPopupRegCity.Show();
            script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        else
        {
            SQL_DB.ExecuteDataSet("UPDATE [CityMaster] SET [CityName] = '" + txtcityname.Text.Trim().Replace("'", "''") + "',[State_id] = " + Convert.ToInt32(ddlstate.SelectedValue) + " WHERE [CITY_ID] = " + Convert.ToInt32(lbleditlabelid.Text) + " ");           
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green");
            Label2.Text = "City <span style='color:blue;'>" + txtcityname.Text.Trim().Replace("'", "''") + "</span>  has been Updated successfully !";
            script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        Cleartxt();
        FillGrdVwCityMaster();        
    }          
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Cleartxt();
        ModalPopupRegCity.Show();
    }           
}