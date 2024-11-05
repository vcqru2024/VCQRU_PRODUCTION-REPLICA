using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using QRCoder; // Import QRCoder library for generating QR codes
using Quantique;

public partial class Quntique : System.Web.UI.Page
{
    SqlConnection connectionString = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Check if the save operation was successful and display alert if needed
            if (Session["SaveSuccess"] != null && (bool)Session["SaveSuccess"])
            {
                string title = "Success!";
                string text = "Dealer data has been saved successfully.";
                string icon = "success";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", "showAlert('" + title + "', '" + text + "', '" + icon + "');", true);

                // Clear the session variable
                Session["SaveSuccess"] = false;
            }
        }

            if (!UserIsLoggedIn()) // You need to implement this method to check if the user is logged in
        {
            Response.Redirect("QuantiqueLogin.aspx");
        }
        // Retrieve username from session
        string username = Session["Username"].ToString(); // Assuming the session variable name is "Username"

        // Get the limit from the database
        int limit = GetLimitFromDatabase(username);

        // Get the generated count from the database
        int generatedCount = GetGeneratedCountFromDatabase();

        // Display the generated count out of the limit
        lblCount.InnerText = "You have generated " + generatedCount + " QR Codes out of " + limit;
    }
    private int GetLimitFromDatabase(string username)
    {
        int limit = 0;
        string query = "SELECT Limit FROM QuantiqueLogin WHERE Username = @Username";

        using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@Username", username);
                connection.Open();
                var result = command.ExecuteScalar();
                if (result != null)
                {
                    limit = (int)result;
                }
            }
        }

        return limit;
    }

    private bool UserIsLoggedIn()
    {
        // Assuming you have a session variable named "IsLoggedIn" set to true upon successful login
        // You can adjust this logic based on your authentication mechanism
        if (Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"])
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    [WebMethod]
    public static Dealer GetDealerData(int dealerId)
    {
        // Fetch dealer data based on dealerId from the database
        Dealer dealer = FetchDealerDataFromDatabase(dealerId);
        return dealer;
    }

    // Method to fetch dealer data from the database
    private static Dealer FetchDealerDataFromDatabase(int dealerId)
    {
        // Replace this connection string with your actual connection string
        string connectionString = WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString;

        Dealer dealer = new Dealer();

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT * FROM DealerData WHERE DealerId = @DealerId";

            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@DealerId", dealerId);

                connection.Open();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        dealer.DealerId = reader["DealerId"].ToString();
                        dealer.Name = reader["Name"].ToString();
                        dealer.Email = reader["Email"].ToString();
                        dealer.Mobile = reader["Mobile"].ToString();
                        dealer.Address1 = reader["Address1"].ToString();
                        dealer.City = reader["City"].ToString();
                        dealer.State = reader["State"].ToString();
                        dealer.PinCode = reader["PinCode"].ToString();
                        dealer.ProductName = reader["ProductName"].ToString();
                        dealer.ProductUrl = reader["ProductUrl"].ToString();
                        dealer.ServiceName = reader["ServiceName"].ToString();
                        dealer.ServiceUrl = reader["ServiceUrl"].ToString();
                        dealer.WebsiteUrl = reader["WebsiteUrl"].ToString();
                        dealer.IsMicrosite = Convert.ToBoolean(reader["IsMicrosite"]);
                    }
                }
            }
        }

        return dealer;
    }
    [WebMethod]
    public static object UpdateDealerData(Dealer dealerData)
    {
        try
        {
            // Update dealer data in the database
            UpdateDealerInDatabase(dealerData);

            // Return success message as JSON
            return new { status = "Success" };
        }
        catch (Exception ex)
        {
            // Log the error or handle it appropriately
            // Return error message as JSON
            return new { status = "Error", message = ex.Message };
        }
    }

    // Method to update dealer data in the database
    private static void UpdateDealerInDatabase(Dealer dealerData)
    {
        // Connection string to your database
        string connectionString = WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString;

        // SQL query to update dealer data
        string query = "UPDATE DealerData SET " +
                       "Name = @Name, " +
                       "Email = @Email, " +
                       "Mobile = @Mobile, " +
                       "Address1 = @Address1, " +
                       "City = @City, " +
                       "State = @State, " +
                       "PinCode = @PinCode, " +
                       "WebsiteUrl = @WebsiteUrl, " +
                       "IsMicrosite = @IsMicrosite, " +
                       "ProductName = @ProductName, " +
                       "ProductUrl = @ProductUrl, " +
                       "ServiceName = @ServiceName, " +
                       "ServiceUrl = @ServiceUrl, " +
                       "UpdatedDate = GETDATE() " + // Include UpdatedDate column
                       "WHERE DealerId = @DealerId";


        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            // Open the connection
            connection.Open();

            // Create a command object
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                // Set parameters
                command.Parameters.AddWithValue("@DealerId", dealerData.DealerId);
                command.Parameters.AddWithValue("@Name", dealerData.Name);
                command.Parameters.AddWithValue("@Email", dealerData.Email);
                command.Parameters.AddWithValue("@Mobile", dealerData.Mobile);
                command.Parameters.AddWithValue("@Address1", dealerData.Address1);
                command.Parameters.AddWithValue("@City", dealerData.City);
                command.Parameters.AddWithValue("@State", dealerData.State);
                command.Parameters.AddWithValue("@PinCode", dealerData.PinCode);
                command.Parameters.AddWithValue("@WebsiteUrl", dealerData.WebsiteUrl);
                command.Parameters.AddWithValue("@IsMicrosite", dealerData.IsMicrosite);
                command.Parameters.AddWithValue("@ProductName", dealerData.ProductName);
                command.Parameters.AddWithValue("@ProductUrl", dealerData.ProductUrl);
                command.Parameters.AddWithValue("@ServiceName", dealerData.ServiceName);
                command.Parameters.AddWithValue("@ServiceUrl", dealerData.ServiceUrl);

                // Execute the command
                command.ExecuteNonQuery();
            }
        }
    }


    public DataTable GetDealerDataFromDatabase()
    {
        DataTable dealerData = new DataTable();

        using (connectionString)
        {
            // SQL query to retrieve dealer data
            string query = "SELECT DealerId, CreatedDate, UpdatedDate, Name, Email, Mobile, City, State, PinCode, ProductName, ProductUrl, ServiceName, ServiceUrl, WebsiteUrl, IsMicrosite, QRCodePath FROM DealerData ORDER BY DealerId DESC";

            using (SqlCommand command = new SqlCommand(query, connectionString))
            {
                connectionString.Open();

                // Execute the SQL command and fill the DataTable with the results
                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    adapter.Fill(dealerData);
                }
            }
        }

        return dealerData;
    }
    // Method to save dealer data and generate QR code
    private void SaveDealerData(string name, string email, string mobile, string city, string state, string pinCode,string address1,
                                string productName, string productUrl, string serviceName, string serviceUrl, string websiteUrl,
                                bool isMicrosite)
    {
        int dealerId = 0;

        // Insert dealer basic data into the database
        using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString))
        {
            string query = @"INSERT INTO DealerData 
                (Name, Email, Mobile, City, State, PinCode, Address1, ProductName, ProductUrl, ServiceName, ServiceUrl, WebsiteUrl, IsMicrosite) 
                VALUES 
                (@Name, @Email, @Mobile, @City, @State, @PinCode, @Address1, @ProductName, @ProductUrl, @ServiceName, @ServiceUrl, @WebsiteUrl, @IsMicrosite);
                SELECT SCOPE_IDENTITY();";

            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@Name", name);
                command.Parameters.AddWithValue("@Email", email);
                command.Parameters.AddWithValue("@Mobile", mobile);
                command.Parameters.AddWithValue("@City", city);
                command.Parameters.AddWithValue("@State", state);
                command.Parameters.AddWithValue("@PinCode", pinCode);
                command.Parameters.AddWithValue("@Address1", address1);
                command.Parameters.AddWithValue("@ProductName", productName);
                command.Parameters.AddWithValue("@ProductUrl", productUrl);
                command.Parameters.AddWithValue("@ServiceName", serviceName);
                command.Parameters.AddWithValue("@ServiceUrl", serviceUrl);
                command.Parameters.AddWithValue("@WebsiteUrl", websiteUrl);
                command.Parameters.AddWithValue("@IsMicrosite", isMicrosite);

                connection.Open();
                dealerId = Convert.ToInt32(command.ExecuteScalar());
            }
        }

        // Generate QR code and save path
        string qrCodePath = GenerateAndSaveQRCode(dealerId);

        // Update database with QR code path
        using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString))
        {
            string query = @"UPDATE DealerData SET QRCodePath = @QRCodePath WHERE DealerId = @DealerId;";
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@QRCodePath", qrCodePath);
                command.Parameters.AddWithValue("@DealerId", dealerId);

                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }

    // Method to generate and save QR code
    public static string GenerateAndSaveQRCode(int dealerId)
    {
        // Generate the content for the QR code (URL with dealer ID)
        string baseUrl = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority);
        string targetUrl = baseUrl + "/DealerData.aspx?dealerId=" + dealerId;

        // Generate the QR code image using QRCoder library
        using (MemoryStream memoryStream = new MemoryStream())
        {
            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCodeData qrCodeData = qrGenerator.CreateQrCode(targetUrl, QRCodeGenerator.ECCLevel.Q);
            QRCode qrCode = new QRCode(qrCodeData);
            Bitmap qrCodeImage = qrCode.GetGraphic(20);

            // Save the QR code image to a folder
            string folderPath = HttpContext.Current.Server.MapPath("~/QRCodeImages/");
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            // Define the file name for the QR code image
            string fileName = "QRCode_" + dealerId + ".png";
            string filePath = Path.Combine(folderPath, fileName);

            // Save the QR code image to the specified file path
            qrCodeImage.Save(filePath, ImageFormat.Png);

            // Return the relative URL for the QR code image
            return "/QRCodeImages/" + fileName;
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("QuantiqueLogin.aspx");
    }
    private int GetGeneratedCountFromDatabase()
    {
        int count = 0;
        string query = "SELECT COUNT(*) FROM DealerData";

        using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();
                count = (int)command.ExecuteScalar();
            }
        }

        return count;
    }

    protected void SaveData(object sender, EventArgs e)
    {
        string username = Session["Username"].ToString(); // Assuming the session variable name is "Username"
        int limit = GetLimitFromDatabase(username);
        int generatedCount = GetGeneratedCountFromDatabase(); // Implement this method to get the count of generated QR codes

        if (generatedCount >= limit)
        {
            // Limit exceeded, disable save button and display message
            Button1.Enabled = false;
            string errorTitle = "Limit Exceeded";
            string errorText = "You have generated the maximum number of QR codes.";
            string errorIcon = "error";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlertScript", "showAlert('" + errorTitle + "', '" + errorText + "', '" + errorIcon + "');", true);
            return;
        }
        // Retrieve data from form fields
        string name = text1.Text;
        string email = text2.Text;
        string mobile = text3.Text;
        string city = dropdownCity.Text;
        string state = textstate.Text; // Retrieve state from form field
        string pinCode = textPinCode.Text;
        string address1 = textAddress1.Text;
        string productName = txtProductName.Text;
        string productUrl = txtProductUrl.Text;
        string serviceName = txtServiceName.Text;
        string serviceUrl = txtServiceUrl.Text;
        string websiteUrl = txtWebsiteUrl.Text;
        bool isMicrosite = radioMicrosite.Checked;

        // Save dealer data and generate QR code
        SaveDealerData(name, email, mobile, city, state, pinCode,address1,
                       productName, productUrl, serviceName, serviceUrl, websiteUrl,
                       isMicrosite);
        // Show alert after saving data
        //string title = "Success!";
        //string text = "Dealer data has been saved successfully.";
        //string icon = "success";
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", "showAlert('" + title + "', '" + text + "', '" + icon + "');", true);
        Session["SaveSuccess"] = true;
        Response.Redirect(Request.RawUrl + "?SaveSuccess=true");
    }
}
namespace Quantique
{
    public class Dealer
    {
        public string DealerId { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Mobile { get; set; }
        public string Address1 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string PinCode { get; set; }
        public string ProductName { get; set; }
        public string ProductUrl { get; set; }
        public string ServiceName { get; set; }
        public string ServiceUrl { get; set; }
        public string WebsiteUrl { get; set; }
        public bool IsMicrosite { get; set; }
        public string QRCodePath { get; set; }
    } 
}