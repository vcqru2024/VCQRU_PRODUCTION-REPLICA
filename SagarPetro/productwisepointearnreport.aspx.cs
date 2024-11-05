using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SagarPetro_productwisepointearnreport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../SagarPetro/Loginhpl.aspx");
    }
    public DataTable GetDataFromDatabase()
    {
        DataTable dataTable = SQL_DB.ExecuteDataTable("exec USP_GETCodeStatusDetails_SP '"+Session["CompanyId"].ToString()+"'");
        if (dataTable.Rows.Count == 0)
            dataTable = null;
        return dataTable;
    }
}