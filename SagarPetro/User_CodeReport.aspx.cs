using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_User_CodeReport : System.Web.UI.Page
{
    SqlConnection conectionstring = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Comp_ID"] == null)
            Response.Redirect("~/Patanjali/Loginpfl.aspx?From=Codeverification");
    }
     public DataTable GetDataFromDatabase()
    {
        string parameterValue = Session["Comp_ID"].ToString();
        DateTime fromDate = new DateTime(2024, 1, 1);
        DateTime toDate = new DateTime(2024, 4, 30).AddDays(1).AddSeconds(-1);


        string storedProcedureName = "USP_GetCodeUserOverview_PFL";
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
                    command.Parameters.AddWithValue("@companyId", parameterValue);
                    command.Parameters.AddWithValue("@fromdate", fromDate);
                    command.Parameters.AddWithValue("@todate", toDate);
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
}
