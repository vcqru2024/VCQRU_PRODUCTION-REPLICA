using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ClosedXML.Excel;
using System.IO;

public partial class SagarPetro_monthwisereport : System.Web.UI.Page
{
    cls_message db = new cls_message();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../SagarPetro/Loginpfl.aspx");
        if (!IsPostBack)
        {
            ddlcity.Items.Insert(0, new ListItem("Select District", "0"));
            ddlcity.Enabled = false;
        }
    }
    public DataTable binddatatable(string Usertypr,string Stateid,string DistrictId)
    {
        DataTable dt = SQL_DB.ExecuteDataTable("Exec USP_GETusertypeandstateanddistrictMonthWise_sp '"+Session["CompanyId"].ToString()+"','"+ Usertypr + "','"+ Stateid + "','"+ DistrictId + "' ");
        if (dt.Rows.Count == 0)
        {
            dt = null;
        }
        return dt;
    }
    public void bindcity(string stateid)
    {
        DataTable dtcity = SQL_DB.ExecuteDataTable("select DistrictID,DistrictName from DistrictMaster_SP where StateID='" + stateid + "'");
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


    protected void ddlstate_SelectedIndexChanged(object sender, EventArgs e)
    {
        string StateId = string.Empty;
        if (ddlstate.SelectedItem.Value != "-1")
        {
            StateId = ddlstate.SelectedItem.Value;
            bindcity(StateId);
        }
    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        if (ddlusertype.SelectedItem.Value == "")
        {
            db.ShowErrorMessage(this,"Please Select Usertype");
            return;
        }
       else if (ddlstate.SelectedItem.Value == "-1")
        {
            db.ShowErrorMessage(this, "Please Select State");
            return;
        }
        else if (ddlstate.SelectedItem.Value == "-1")
        {
            db.ShowErrorMessage(this, "Please Select State");
            return;
        }
        else if (ddlcity.SelectedItem.Value == "0")
        {
            db.ShowErrorMessage(this, "Please Select District");
            return;
        }
        else
        {
            string Usertype = ddlusertype.SelectedItem.Value;
            string StateId = ddlstate.SelectedItem.Value;
            string CityId = ddlcity.SelectedItem.Value;
            DataTable dt = binddatatable(Usertype, StateId, CityId);
            grdmonthwisereport.DataSource = dt;
            grdmonthwisereport.DataBind();
        }
    }


    protected void btndownload_Click(object sender, EventArgs e)
    {
        if (ddlusertype.SelectedItem.Value == "")
        {
            db.ShowErrorMessage(this, "Please Select Usertype");
            return;
        }
        else if (ddlstate.SelectedItem.Value == "-1")
        {
            db.ShowErrorMessage(this, "Please Select State");
            return;
        }
        else if (ddlstate.SelectedItem.Value == "-1")
        {
            db.ShowErrorMessage(this, "Please Select State");
            return;
        }
        else if (ddlcity.SelectedItem.Value == "0")
        {
            db.ShowErrorMessage(this, "Please Select District");
            return;
        }
        else
        {
            string Usertype = ddlusertype.SelectedItem.Value;
            string StateId = ddlstate.SelectedItem.Value;
            string CityId = ddlcity.SelectedItem.Value;
            DataTable dt = binddatatable(Usertype, StateId, CityId);
            XLWorkbook wb = new XLWorkbook();
            wb.Worksheets.Add(dt, "MonthWiseReport");
            MemoryStream stream = new MemoryStream();
            wb.SaveAs(stream);
            Response.Clear();
            Response.ContentType = "application/force-download";
            Response.AddHeader("content-disposition", "attachment;    filename=Monthwise_Report.xlsx");
            Response.BinaryWrite(stream.ToArray());
            Response.End();
        }
    }
}