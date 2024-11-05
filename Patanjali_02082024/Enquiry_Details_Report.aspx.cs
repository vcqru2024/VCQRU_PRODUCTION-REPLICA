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
    string fromDate = string.Empty;
    string toDate = string.Empty;
    SqlConnection conectionstring = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (Session["CompanyId"] == null)
            Response.Redirect("../patanjali/loginpfl.aspx?Page=clicked");
        if (!IsPostBack)
        {
            fromDate = DateTime.Today.ToString("yyyy-MM-dd") + " 00:00:00.001";
            toDate = DateTime.Today.ToString("yyyy-MM-dd") + " 23:59:59.999";
        }

    }
    public DataTable GetDataFromDatabase()
    {
        if(!string.IsNullOrEmpty(txtfromdate.Value)&& !string.IsNullOrEmpty(txtTodate.Value))
        {
            fromDate = txtfromdate.Value + " 00:00:00.001"; ;
            toDate = txtTodate.Value + " 23:59:59.999";
        }
        else
        {
            fromDate = fromDate.ToString();
            toDate = toDate.ToString();
        }
        
        string parameterValue = Session["CompanyId"].ToString();
        string storedProcedureName = "USP_GetEnquiryDetails_PFL";
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