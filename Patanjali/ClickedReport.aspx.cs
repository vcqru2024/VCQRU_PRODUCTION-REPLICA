using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_ClickedReport : System.Web.UI.Page
{
    string fromDate = string.Empty;
    string toDate = string.Empty;
    SqlConnection conectionstring = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../patanjali/loginpfl.aspx?Page=clicked");
        if (!IsPostBack)
        {
            fromDate = DateTime.Now.ToString("yyyy-MM-dd") + " 00:00:00.001";
            toDate = DateTime.Now.ToString("yyyy-MM-dd") + " 23:59:59.999";
        }
    }
    public DataTable GetDataFromDatabase()
    {
        if (!string.IsNullOrEmpty(txtfromdate.Value) && !string.IsNullOrEmpty(txtTodate.Value))
        {
            fromDate = txtfromdate.Value + " 00:00:00.001";
            toDate = txtTodate.Value + " 23:59:59.999";
        }
        else
        {
            fromDate = fromDate.ToString();
            toDate = toDate.ToString();
        }
        string storedProcedureName = "USP_GetTotalClickCount";
        DataTable dataTable = new DataTable();

        using (conectionstring)
        {
            try
            {
                conectionstring.Open();
                using (SqlCommand command = new SqlCommand(storedProcedureName, conectionstring))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(dataTable);
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
        }

        return dataTable;
    }
}