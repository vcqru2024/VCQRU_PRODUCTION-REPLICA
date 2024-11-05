using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class statuslogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string username = txtUsername.Text;
        string password = txtPassword.Text;

        // Example: Check if username and password match in a hypothetical database
        if (IsValidUser(username, password))
        {
            // Set session variable to indicate user is logged in
            Session["IsLoggedIn"] = true;
            Session["UserName"] = username;

            // Redirect to the desired page upon successful login
            Response.Redirect("Adminstatus/Dashboard.aspx");
        }
        else
        {
            // Display error message
            lblMessage.Visible = true;
            lblMessage.Text = "Invalid username or password.";
        }
    }

    private bool IsValidUser(string username, string password)
    {
        // Connection string to your database
        string connectionString = ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString;

        // SQL query to check if the provided username and password match in the database
        string query = "SELECT COUNT(*) FROM StatusLogin  WHERE Username = @username  AND Password = @password ";

        // Assume you have a table named Users with columns Username and Password

        // Use a using statement to ensure proper disposal of resources
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            // Open the connection
            connection.Open();

            // Create a command with the query and connection
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                // Add parameters to the query to prevent SQL injection
                command.Parameters.AddWithValue("@Username", username);
                command.Parameters.AddWithValue("@Password", password);

                // Execute the query and get the result
                int count = (int)command.ExecuteScalar();

                // If count is greater than 0, it means the provided username and password match
                // an entry in the database, so return true
                return count > 0;
            }
        }
    }
}