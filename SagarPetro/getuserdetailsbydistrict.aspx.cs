using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SagarPetro_getuserdetailsbydistrict : System.Web.UI.Page
{
    DataTable Userdata;
    cls_message db = new cls_message();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../SagarPetro/Loginpfl.aspx");
        if (!IsPostBack)
        {
            ddlcity.Items.Insert(0, new ListItem("Select District", "0"));
            ddlcity.Enabled = false;
            rptData.DataSource = GetDataFromDatabase("", "", "", "", "", "");
            rptData.DataBind();
        }
       
    }
    public DataTable GetDataFromDatabase(string Userroletype,string districtid, string Datefrom, string Dateto,string Action,string Stateid)
    {
       
        if (string.IsNullOrEmpty(Userroletype))
            Userroletype = "6";
        if (string.IsNullOrEmpty(txtfromdate.Text) && string.IsNullOrEmpty(txttodate.Text))
        {
            Datefrom = DateTime.Today.ToString("yyyy-MM-dd 00:00:00.001");
            Dateto = DateTime.Today.ToString("yyyy-MM-dd 23:59:59.999");
        }
        if(Action== "USERSELECTION")
        {
            Userdata = SQL_DB.ExecuteDataTable("USP_GETDetailsScore_SP_Newbyusertype '" + Session["CompanyId"].ToString() + "' ,'" + Userroletype + "'");
        }
        else if(Action == "StateSelection")
        {
            Userdata = SQL_DB.ExecuteDataTable("exec USP_GETDetailsScore_SP_Newbyusertypeandstate '" + Session["CompanyId"].ToString() + "','" + Userroletype + "','" + Stateid + "'");
        }
        else if (Action == "DDLCITYCHANGE")
        {
            Userdata = SQL_DB.ExecuteDataTable("exec USP_GETDetailsScore_SP_Newbyusertypeandstateanddistrict '" + Session["CompanyId"].ToString() + "','" + Userroletype + "','" + Stateid + "' ,'" + districtid + "' ");
        }
        else if (Action == "BTNSEARCH" || Action=="")
        {
            Userdata = SQL_DB.ExecuteDataTable("exec USP_GETDetailsScore_SP_New '" + Session["CompanyId"].ToString() + "','" + Userroletype + "','" + Datefrom + "','" + Dateto + "','" + districtid + "'");
        }
        if (Userdata.Rows.Count == 0 )
            Userdata = null;
        
        return Userdata;
    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        string Userroletype = ddlusertype.SelectedItem.Value;
        if (string.IsNullOrEmpty(Userroletype))
        {
            db.ShowErrorMessage(this, "Please Select User Type");
            return;
        }
        string State = ddlstate.SelectedItem.Value;
        if (string.IsNullOrEmpty(State))
        {
            db.ShowErrorMessage(this, "Please Select State");
            return;
        }
        string District = ddlcity.SelectedItem.Value;
        if (string.IsNullOrEmpty(District))
        {
            db.ShowErrorMessage(this, "Please Select District");
            return;
        }
        if (string.IsNullOrEmpty(txtfromdate.Text) && string.IsNullOrEmpty(txttodate.Text))
        {
            db.ShowErrorMessage(this, "Please Select Date Range");
            return;
        }
        string dateFrom = Convert.ToDateTime(txtfromdate.Text).ToString("yyyy-MM-dd 00:00:00.001");
        string dateTo = Convert.ToDateTime(txttodate.Text).ToString("yyyy-MM-dd 23:59:59.999");

       
        
        
         if (string.IsNullOrEmpty(dateFrom) && string.IsNullOrEmpty(dateTo))
        {
            db.ShowErrorMessage(this, "Please Select Date Range");
            return;
        }
        else
        {
           rptData.DataSource= GetDataFromDatabase(Userroletype, District, dateFrom, dateTo,"BTNSEARCH","");
            rptData.DataBind();
        }
    }

    protected void ddlstate_SelectedIndexChanged(object sender, EventArgs e)
    {
        string Stateid = ddlstate.SelectedItem.Value;
        if (string.IsNullOrEmpty(Stateid))
        {
            db.ShowErrorMessage(this, "Please Select State");
        }
        else
        {
            bindcity(Stateid);
           rptData.DataSource= GetDataFromDatabase(ddlusertype.SelectedItem.Value, "", "", "", "StateSelection", Stateid);
            rptData.DataBind();
        }
    }
    public void bindcity(string stateid)
    {
        DataTable dtcity = SQL_DB.ExecuteDataTable("select DistrictID,DistrictName from DistrictMaster_SP where StateID='"+ stateid + "'");
        if (dtcity.Rows.Count > 0)
        {
            ddlcity.DataSource = dtcity;
            ddlcity.DataTextField = "DistrictName";
            ddlcity.DataValueField = "DistrictID";
            ddlcity.DataBind();
            ddlcity.Items.Insert(0, new ListItem("Select District", "0"));
            ddlcity.SelectedIndex = 0;
            ddlcity.Items[0].Attributes["disabled"] = "disabled";
            ddlcity.Enabled = true;
        }
    }

    protected void ddlusertype_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlstate.ClearSelection();
        ddlcity.ClearSelection();
       rptData.DataSource= GetDataFromDatabase(ddlusertype.SelectedItem.Value, "", "", "","USERSELECTION","");
        rptData.DataBind();
    }

    protected void ddlcity_SelectedIndexChanged(object sender, EventArgs e)
    {
        rptData.DataSource = GetDataFromDatabase(ddlusertype.SelectedItem.Value, ddlcity.SelectedItem.Value, "", "", "DDLCITYCHANGE", ddlstate.SelectedItem.Value);
        rptData.DataBind();
    }
}