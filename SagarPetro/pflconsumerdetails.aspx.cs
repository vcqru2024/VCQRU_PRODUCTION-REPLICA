using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_pflconsumerdetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../SagarPetro/Loginpfl.aspx");
    }
    public DataTable GetDataFromDatabase()
    {
        DataTable dataTable;
        try
        {
             dataTable = SQL_DB.ExecuteDataTable("sp_getConsumerdetails_HPL '" + Session["CompanyId"].ToString() + "',''");
        }
        catch (Exception ex)
        {
            dataTable = null;
        }
        return dataTable;
    }
}