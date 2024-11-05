using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class order_status_form : System.Web.UI.Page
{

    string connectionString = "Connect Timeout=10000000; pooling=true; Max Pool Size=200;Data Source=20.198.123.187\\VCQRU,1433;Initial Catalog=vcqru_qa;User ID=vcqru_label;Password=vcqruadmin@123";

    protected void Page_Load(object sender, EventArgs e)
    {

      


    }

    public static bool Validate(TextBox ponumber, TextBox projectname, TextBox ownerofpro, TextBox servicename, TextBox accountapproval, TextBox remarks, out string errorMessage)
    {
        if (string.IsNullOrWhiteSpace(ponumber.Text))
        {
            errorMessage = "PONumber is required.";
            return false;
        }

        if (string.IsNullOrWhiteSpace(projectname.Text))
        {
            errorMessage = "Project Name is required.";
            return false;
        }

        if (string.IsNullOrWhiteSpace(ownerofpro.Text))
        {
            errorMessage = "Owner of Project is required.";
            return false;
        }

        if (string.IsNullOrWhiteSpace(servicename.Text))
        {
            errorMessage = "Service Name is required.";
            return false;
        }

        if (string.IsNullOrWhiteSpace(accountapproval.Text))
        {
            errorMessage = "Account Status is required.";
            return false;
        }

        if (string.IsNullOrWhiteSpace(remarks.Text))
        {
            errorMessage = "Remarks are required.";
            return false;
        }

        errorMessage = string.Empty;
        return true;
    }




    protected void Unnamed_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "showLoader", "showLoader();", true);

        if (IsPONumberDuplicate(ponumber.Text))
        {
            ShowErrorMessage(this,"The PO Number already exists. Please use a different PO Number.");
            return;
        }

        string errorMessage;
        if(Validate(ponumber, projectname, ownerofpro, servicename, accountapproval, remarks, out errorMessage))
        {
            string query = "INSERT INTO Orders (PONumber, OrderName, OwnerofProject, ServiceName, Account_status,Remarks) VALUES (@PONumber, @OrderName, @OwnerofProject, @ServiceName,@Account_status,@Remarks)";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@PONumber", ponumber.Text);
                    cmd.Parameters.AddWithValue("@OrderName", projectname.Text);
                    cmd.Parameters.AddWithValue("@OwnerofProject", ownerofpro.Text);
                    cmd.Parameters.AddWithValue("@ServiceName", servicename.Text);
                    cmd.Parameters.AddWithValue("@Account_status", accountapproval.Text);
                    cmd.Parameters.AddWithValue("@Remarks", remarks.Text);

                    try
                    {
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ShowSuccessMessage(this, "sUCCEESS");
                            return;
                        }
                        else
                        {
                            // Handle the case where no rows were affected
                            Console.WriteLine("No record was inserted.");
                        }
                    }
                    catch (Exception ex)
                    {
                        // Handle any exceptions that occur during the execution
                        Console.WriteLine("An error occurred: " + ex.Message);
                    }
                    finally
                    {
                        conn.Close();
                        ClearFormFields();// Close the connection
                    }
                }
                
            }
           
        }
       
       



    }
    private bool IsPONumberDuplicate(string poNumber)
    {
        string query = "SELECT COUNT(*) FROM Orders WHERE PONumber = @PONumber";
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@PONumber", poNumber);
                try
                {
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
                catch (Exception ex)
                {
                    Console.WriteLine("An error occurred: " + ex.Message);
                    return true; // Consider as duplicate in case of error
                }
                finally
                {
                    conn.Close(); // Close the connection
                }
            }
        }
    }
    public void ShowSuccessMessage(Page page, string message)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), "Success", "showAlert('Success', '" + message + "', 'success');", true);
    }
    public void ShowErrorMessage(Page page, string message)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), "Invalid", "showAlert('Error', '" + message + "', 'error');", true);
    }

    private void ClearFormFields()
    {
        // Clear form fields after successful submission
        ponumber.Text = "";
        projectname.Text = "";
        ownerofpro.Text = "";
        servicename.Text = "";
        accountapproval.Text = "";
        remarks.Text = "";
    }
}





