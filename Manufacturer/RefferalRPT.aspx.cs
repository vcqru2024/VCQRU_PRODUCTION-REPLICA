using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Manufacturer_RefferalRPT : System.Web.UI.Page
{
    SqlConnection conectionstring = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
    string fromdate = "";
    string todate = "";
    protected void Page_Load(object sender, EventArgs e)
    {
 

    }
    public DataTable GetDataFromDatabase()
    {
        string companyId = Session["CompanyId"] != null ? Session["CompanyId"].ToString() : null;
        if (companyId != null && companyId == "Comp-1548")
        {
            if (!IsPostBack)
            {
                fromdate = DateTime.Today.ToString("yyyy-MM-dd") + " 00:00:00.000";
                todate = DateTime.Today.ToString("yyyy-MM-dd") + " 23:59:00.000";
            }
            else
            {
                fromdate = txtfromdate.Value + " 00:00:00.000";
                todate = txtTodate.Value + " 23:59:00.000";
            }
        }

        string storedProcedureName = "USP_GetReferralReport";
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
                    command.Parameters.AddWithValue("@fromdate", fromdate);
                    command.Parameters.AddWithValue("@todate", todate);
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


    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {

    }
}