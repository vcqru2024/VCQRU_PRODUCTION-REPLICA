using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_Success : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string msgkey = string.Empty;
        if (!string.IsNullOrEmpty(Request.QueryString["id"]))
        {
            msgkey = Request.QueryString["id"].ToString();

            if (msgkey.Contains("cannot be") || msgkey.Contains("cannot be") || msgkey.Contains("invalid") || msgkey.Contains("Invalid") )
            {
                htitle.InnerHtml = "Failed";
                Image1.Src = "../assets/images/patanjali_New/canceled.svg";
            }
            else if( msgkey.Contains("Already") || msgkey.Contains("already"))
            {
                htitle.InnerHtml = "Already verified.";
                Image1.Src = "../assets/images/patanjali_New/warning.png";
            }
            else
            {
                Image1.Src = "../assets/images/patanjali_New/succes.svg";
            }
                
            
            
                

            ResponseContent.InnerText = msgkey;
            //if (msgkey == "Success")
            //{
            //    ResponseContent.InnerText = "Congratulations you have purchased an authantic Cow's Ghee of Patanjali";
            //}
            //else
            //{
            //    ResponseContent.InnerText = "This Product is not Valid";
            //}

        }

        //if (!IsPostBack)
        //    ResponseContent.InnerText = Session["ResponseContent"].ToString();
        //else
        //    ResponseContent.InnerText = "";



    }
    [WebMethod]
    [ScriptMethod]
    public static void HandleImageClick(string href, string lat, string longitude)
    {
        string name = GetProductName(href);
        string code = GetProductCode(href);
        string connectionString = WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString; // Replace with your actual connection string

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = @"INSERT INTO [dbo].[tbl_ProductUrl]
                        ([Prod_Url], [Name], [Code], [Click_Count], [Remarks], [IsActive], [IsDelete], [Created_by], [Created_Date], [Updated_by], [Updated_Date],[Latitude],[Longitude])
                        VALUES
                        (@Prod_Url, @Name, @Code, @Click_Count, @Remarks, @IsActive, @IsDelete,@Created_by, GETDATE(), @Updated_by, GETDATE(),@Latitude,@Longitude)";

            SqlCommand command = new SqlCommand(sql, connection);

            // Add parameters
            command.Parameters.AddWithValue("@Prod_Url", href);
            command.Parameters.AddWithValue("@Name", name);
            command.Parameters.AddWithValue("@Code", code);
            command.Parameters.AddWithValue("@Click_Count", 1);
            command.Parameters.AddWithValue("@Latitude", lat);
            command.Parameters.AddWithValue("Longitude", longitude);
            command.Parameters.AddWithValue("@Remarks", "clicked");
            command.Parameters.AddWithValue("@IsActive", 0);
            command.Parameters.AddWithValue("@IsDelete", 0);
            command.Parameters.AddWithValue("@Created_by", "");
            command.Parameters.AddWithValue("@Updated_by", "");

            try
            {
                connection.Open();
                command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error inserting into tbl_ProductUrl: " + ex.Message);
                // Handle the exception as needed
            }
        }
    }
    static string GetProductName(string url)
    {
        // Split the URL by '/'
        string[] parts = url.Split('/');

        // The product name is usually the last part of the URL
        return parts[parts.Length - 2].Replace("-", " ");
    }

    static string GetProductCode(string url)
    {
        // Split the URL by '/'
        string[] parts = url.Split('/');

        // The product code is usually the second-to-last part of the URL
        return parts[parts.Length - 1];
    }
}