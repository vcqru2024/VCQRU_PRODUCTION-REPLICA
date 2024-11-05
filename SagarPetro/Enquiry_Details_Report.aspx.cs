using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_Enquiry_Details_Report : System.Web.UI.Page
{
    cls_message db = new cls_message();
    DataTable dataTable;
    string fromDate = string.Empty;
    string toDate = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../SagarPetro/Loginpfl.aspx?page = enqrpt");
        if (!IsPostBack)
        {
           
             fromDate = DateTime.Today.ToString("yyyy-MM-dd") + " 00:00:00.001";
             toDate = DateTime.Today.ToString("yyyy-MM-dd") + " 23:59:59.999";
        }
    }
    public DataTable GetDataFromDatabase()
    {
        try
        {
            dataTable = SQL_DB.ExecuteDataTable("USP_GetEnquiryDetails '" + Session["CompanyId"].ToString() + "','" + fromDate + "','" + toDate + "'");
        }
        catch (Exception ex)
        {

            dataTable = null;
        }
        return dataTable;
    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        string dateFrom = Convert.ToDateTime(txtfromdate.Text).ToString("yyyy-MM-dd 00:00:00.001");
        string dateTo = Convert.ToDateTime(txttodate.Text).ToString("yyyy-MM-dd 23:59:59.999");
        if(string.IsNullOrEmpty(dateFrom)&& string.IsNullOrEmpty(dateTo))
        {
            db.ShowErrorMessage(this, "Please Select Date Range");
            return;
        }
        else
        {
            
            dataTable = SQL_DB.ExecuteDataTable("USP_GetEnquiryDetails '" + Session["CompanyId"].ToString() + "','" + dateFrom + "','" + dateTo + "'");
            rptData.DataSource = dataTable;
            rptData.DataBind();
        }
    }
}