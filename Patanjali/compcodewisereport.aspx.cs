using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_compcodewisereport : System.Web.UI.Page
{
    SqlConnection conectionstring = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../patanjali/loginpfl.aspx?Page=clicked");
    }
    public DataTable GetDataFromDatabase()
    {
        string parameterValue = Session["CompanyId"].ToString();
        string fromdate = txtfromdate.Value+ " 00:00:00.000";
        string todate = txtTodate.Value+ " 23:59:00.000";
        string storedProcedureName = "USP_GetCompleteCodeWiseStatusCount_PFL";
        DataTable dataTable = new DataTable();

        using (conectionstring)
        {
            try
            {
                conectionstring.Open();

                // Create a SqlCommand object to execute the stored procedure
                using (SqlCommand command = new SqlCommand(storedProcedureName, conectionstring))
                {
                    // Specify that the command is a stored procedure
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@companyid", parameterValue);
                    command.Parameters.AddWithValue("@start_date", fromdate);
                    command.Parameters.AddWithValue("@enq_date", todate);
                    // Execute the stored procedure and fill the DataTable
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(dataTable);
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions here
                Console.WriteLine("An error occurred: " + ex.Message);
            }
        }

        return dataTable;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }
}