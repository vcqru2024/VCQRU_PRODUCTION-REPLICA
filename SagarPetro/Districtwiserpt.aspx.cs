using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class SagarPetro_Districtwiserpt : System.Web.UI.Page
{
    DataTable dataTable;
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    public DataTable GetDataFromDatabase()
    {
        try
        {
            dataTable = SQL_DB.ExecuteDataTable("exec USP_GETCodeStatusDetails_SP '" + Session["CompanyId"].ToString() + "'");
            if (dataTable.Rows.Count == 0)
                dataTable = null;
            return dataTable;
        }
        catch (Exception ex)
        {

        }

        return dataTable;

    }
}