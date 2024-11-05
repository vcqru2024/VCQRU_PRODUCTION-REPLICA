using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_Consumer_Purchase_History_Report : System.Web.UI.Page
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
        if(!string.IsNullOrEmpty(txtfromdate.Value)&& !string.IsNullOrEmpty(txtTodate.Value))
        {
            fromDate= txtfromdate.Value + " 00:00:00.001";
            toDate=txtTodate.Value + " 23:59:59.999";
        }
        else
        {
            fromDate = fromDate.ToString();
            toDate = toDate.ToString();
        }
        string parameterValue = Session["CompanyId"].ToString();
        string storedProcedureName = "USP_GetConsumerPurchaseHistory_PFL";
        DataTable dataTable = new DataTable();

        using (conectionstring)
        {
            try
            {
                conectionstring.Open();
                using (SqlCommand command = new SqlCommand(storedProcedureName, conectionstring))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@companyId", parameterValue);
                    command.Parameters.AddWithValue("@start_date", fromDate);
                    command.Parameters.AddWithValue("@enq_date", toDate);
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(dataTable);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
            }
        }
        return dataTable;
    }
}