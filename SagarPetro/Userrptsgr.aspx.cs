using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SagarPetro_Userrptsgr : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../SagarPetro/Loginpfl.aspx ? from userrptsgr");
        GetDataFromDatabase();
    }

    public DataTable GetDataFromDatabase()
    {
        DataTable dataTable = SQL_DB.ExecuteDataTable("USP_UserCount_SP '"+Session["CompanyID"].ToString()+"'");
        if (dataTable.Rows.Count == 0)
        {
            dataTable = null;
        }
        return dataTable;
    }
}