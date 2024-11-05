using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class SagarPetro_transactiondetailsrpt : System.Web.UI.Page
{
    cls_message db = new cls_message();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../SagarPetro/Loginpfl.aspx? page = transactiondetailsrpt");
        if (!IsPostBack)
        {
            ddldistrict.Items.Insert(0, new ListItem("Select District", "0"));
            ddldistrict.Enabled = false;
        }
    }

    protected void ddlstate_SelectedIndexChanged(object sender, EventArgs e)
    {

        binddistrict(ddlstate.SelectedItem.Value);
    }
    public void binddistrict(string DistrictID)
    {
        DataTable dtuser = SQL_DB.ExecuteDataTable("select DistrictID,DistrictName from DistrictMaster_SP where StateID='" + DistrictID + "'");
        if (dtuser.Rows.Count > 0)
        {
            ddldistrict.DataSource = dtuser;
            ddldistrict.DataTextField = "DistrictName";
            ddldistrict.DataValueField = "DistrictID";
            ddldistrict.DataBind();
            ddldistrict.Items.Insert(0, new ListItem("Select District", "0"));
            ddldistrict.SelectedIndex = 0;
            ddldistrict.Items[0].Attributes["disabled"] = "disabled";
            ddldistrict.Enabled = true;
        }
    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        string State = ddlstate.SelectedItem.Value;
        if (string.IsNullOrEmpty(State))
        {
            db.ShowErrorMessage(this, "Please Select State");
            return;
        }
        if (State=="0")
        {
            db.ShowErrorMessage(this, "Please Select State");
            return;
        }
        string District = ddldistrict.SelectedItem.Value;
        if (string.IsNullOrEmpty(District))
        {
            db.ShowErrorMessage(this, "Please Select District");
            return;
        }
        if (District=="0")
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
            try
            {
                DataTable dtuser = SQL_DB.ExecuteDataTable("exec USP_GetAssistantMechanicTransactionSummaryForAdmin_SP '" + Session["CompanyId"].ToString() + "','" + dateFrom + "','" + dateTo + "','" + District + "'");
                if (dtuser.Rows.Count > 0)
                {
                    rptData.DataSource = dtuser;
                    rptData.DataBind();
                }
                else
                {
                    rptData.DataSource = null;
                    rptData.DataBind();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}