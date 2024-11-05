using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_NewBatchAssignedDetails : System.Web.UI.Page
{
    SqlConnection conectionstring = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../Patanjali/Loginpfl.aspx?From=NewBatchAssignedDetails.aspx");

        if(!IsPostBack)
        {
            txtfromdate.Value = System.DateTime.Now.ToString("yyyy-MM-dd");
            txtTodate.Value = txtfromdate.Value;
        }
       
    }
    public DataTable GetDataFromDatabase()
    {
        string parameterValue = Session["Comp_ID"].ToString();
        string Frmdate = Convert.ToDateTime(txtfromdate.Value).Date.ToString("yyyy-MM-dd");
        string Tdate = Convert.ToDateTime(txtTodate.Value).Date.ToString("yyyy-MM-dd");


        string fromdate = Frmdate + " 00:00:00.000";
        string todate = Tdate + " 23:59:00.000";

        string storedProcedureName = "USP_GetNewBatchAssignedDetail";
        DataTable dataTable = new DataTable();

        using (conectionstring)
        {
            try
            {
                //conectionstring.Open();

                // Create a SqlCommand object to execute the stored procedure
                using (SqlCommand command = new SqlCommand(storedProcedureName, conectionstring))
                {
                    // Specify that the command is a stored procedure
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@companyid", parameterValue);
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

    protected void Button1_Click(object sender, EventArgs e)
    {
       // GetDataFromDatabase();
    }
}