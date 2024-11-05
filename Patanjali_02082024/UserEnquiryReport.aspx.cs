using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_UserEnquiryReport : System.Web.UI.Page
{
    SqlConnection conectionstring = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Comp_ID"] == null)
            Response.Redirect("../Patanjali/Loginpfl.aspx?From=Codeverification");
    }
    public DataTable GetDataFromDatabase()
    {
        string query = "select Name,Mobile_Number,City,Email_ID,Image_Url,Enquiry,Created_Date from tbl_Enquiries ORDER BY Created_Date DESC";
        DataTable dataTable = new DataTable();

        using (conectionstring)
        {
            try
            {
                conectionstring.Open();

               
                using (SqlCommand command = new SqlCommand(query, conectionstring))
                {
                    command.CommandType = CommandType.Text;
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