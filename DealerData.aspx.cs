using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DealerData : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string dealerId = Request.QueryString["dealerId"];

        if (!IsPostBack && !string.IsNullOrEmpty(dealerId))
        {
            // Fetch dealer information based on dealerId
            Dealer dealer = GetDealerInfoFromDatabase(dealerId);

            if (dealer != null)
            {
                if (dealer.IsMicrosite)
                {
                    // Display dealer information in labels
                    lblname.InnerText = dealer.Name;
                    lblemail.InnerText = dealer.Email;
                    lblcontact.InnerText = dealer.Mobile;
                    lbldealerAdd.InnerText = string.Format("{0}, {1}, {2},{3}",dealer.Address1, dealer.City, dealer.State, dealer.PinCode);

                    // Bind products and services to the repeaters
                    productRepeater.DataSource = GetDealerProductsFromDatabase(dealerId);
                    productRepeater.DataBind();
                    serviceRepeater.DataSource = GetDealerServicesFromDatabase(dealerId);
                    serviceRepeater.DataBind();
                }
                else
                {
                    // Redirect to the dealer's website
                    Response.Redirect(dealer.WebsiteUrl);
                }
            }
        }
    }
    protected string GetProductImageUrl(int index)
    {
        string[] imageUrls = {
            "https://quantique.ai/assets/4x/green%20growth.png",
            "https://quantique.ai/assets/4x/Insurance%20Renewal%20.png",
            "https://quantique.ai/assets/4x/Qms.png"
        };

        return imageUrls[index % imageUrls.Length];
    }

    protected string GetServiceImageUrl(int index)
    {
        string[] imageUrls = {
            "https://quantique.ai/assets/4x/Asset%2020@4x.png",
            "https://quantique.ai/assets/4x/Asset-23.png",
            "https://quantique.ai/assets/4x/Asset-27.png"
        };

        return imageUrls[index % imageUrls.Length];
    }

    private DataTable GetDealerProductsFromDatabase(string dealerId)
    {
        DataTable dtProducts = new DataTable();
        string connectionString = WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString;

        string query = "SELECT ProductName, ProductUrl FROM DealerData WHERE DealerId = @DealerId AND ProductName IS NOT NULL";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@DealerId", dealerId);

                try
                {
                    connection.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    adapter.Fill(dtProducts);
                }
                catch (Exception ex)
                {
                    // Handle exception
                }
            }
        }

        return dtProducts;
    }

    private DataTable GetDealerServicesFromDatabase(string dealerId)
    {
        DataTable dtServices = new DataTable();
        string connectionString = WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString;

        string query = "SELECT ServiceName, ServiceUrl FROM DealerData WHERE DealerId = @DealerId AND ServiceName IS NOT NULL";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@DealerId", dealerId);

                try
                {
                    connection.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    adapter.Fill(dtServices);
                }
                catch (Exception ex)
                {
                    // Handle exception
                }
            }
        }

        return dtServices;
    }

    private Dealer GetDealerInfoFromDatabase(string dealerId)
    {
        Dealer dealer = null;
        string connectionString = WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString;

        string query = "SELECT * FROM DealerData WHERE DealerId = @DealerId";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@DealerId", dealerId);

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        dealer = new Dealer
                        {
                            DealerId = reader["DealerId"].ToString(),
                            Name = reader["Name"].ToString(),
                            Email = reader["Email"].ToString(),
                            Mobile = reader["Mobile"].ToString(),
                            Address1 = reader["Address1"].ToString(),
                            City = reader["City"].ToString(),
                            State = reader["State"].ToString(),
                            PinCode = reader["PinCode"].ToString(),
                            ProductName = reader["ProductName"].ToString(),
                            ProductUrl = reader["ProductUrl"].ToString(),
                            ServiceName = reader["ServiceName"].ToString(),
                            ServiceUrl = reader["ServiceUrl"].ToString(),
                            WebsiteUrl = reader["WebsiteUrl"].ToString(),
                            IsMicrosite = Convert.ToBoolean(reader["IsMicrosite"]),
                            QRCodePath = reader["QRCodePath"].ToString()
                        };
                    }
                }
                catch (Exception ex)
                {
                    // Handle exception
                }
            }
        }

        return dealer;
    }
}
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