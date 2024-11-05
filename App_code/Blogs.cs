using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Business_Logic_Layer;
using System.Net;
using System.Text;
using System.IO;
using Business9420;
using System.Collections.Generic;
using DataProvider;
using System.Data.SqlClient;
using System.Web.Configuration;

/// <summary>
/// Summary description for Blogs
/// </summary>
public class Blogs
{
    SqlConnection conectionstring = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
    public Blogs()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public DataTable GetblogPosts()
    {
        try
        {
            DataTable dt = SQL_DB.ExecuteDataTable("select * from [BlogPost] order by id desc");
            return dt;
        }
        catch (Exception ex)
        {

            throw;
        }
    }
    public DataTable GetPostsForMainPage(int limit)
    {
        try
        {
            DataTable dt = SQL_DB.ExecuteDataTable("SELECT TOP " + limit + " * FROM [BlogPost] WHERE StartDateUtc <= GETDATE() AND EndDateUtc >= GETDATE() ORDER BY Id DESC");
            return dt;
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    public int GetTotalPosts()
    {
        try
        {
            DataTable dt = SQL_DB.ExecuteDataTable("SELECT COUNT(*) FROM [BlogPost] WHERE (StartDateUtc IS NULL OR StartDateUtc <= CAST(GETDATE() AS DATE)) AND (EndDateUtc IS NULL OR EndDateUtc >= CAST(GETDATE() AS DATE))");
            int totalCount = 0;
            if (dt.Rows.Count > 0 && dt.Rows[0][0] != DBNull.Value)
            {
                totalCount = Convert.ToInt32(dt.Rows[0][0]);
            }
            return totalCount;
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    public DataTable GetPostsForMainPage(int pageNumber, int pageSize)
    {
        try
        {
            int startRow = (pageNumber - 1) * pageSize + 1;
            int endRow = startRow + pageSize - 1;

            string query = string.Format(@"
            SELECT * 
            FROM (
                SELECT *, 
                       ROW_NUMBER() OVER (ORDER BY CreatedOnUtc DESC) AS RowNum 
                FROM [BlogPost] 
                WHERE (StartDateUtc IS NULL OR StartDateUtc <= CAST(GETDATE() AS DATE))
                  AND (EndDateUtc IS NULL OR EndDateUtc >= CAST(GETDATE() AS DATE))
            ) AS Temp
            WHERE RowNum BETWEEN {0} AND {1}
            ORDER BY CreatedOnUtc DESC", startRow, endRow);

            DataTable dt = SQL_DB.ExecuteDataTable(query);

            // Calculate total pages
            int totalPosts = GetTotalPosts();
            int totalPages = (int)Math.Ceiling((double)totalPosts / pageSize);

            // You can return both the data table and the total pages as a tuple or some other data structure
            // For simplicity, let's assume you only need the data table here
            return dt;
        }
        catch (Exception ex)
        {
            throw;
        }
    }



    public DataTable GetRandomBlogs()
    {
        try
        {
            DataTable dt = SQL_DB.ExecuteDataTable("select top 3  * from Blogs where VideoPath='NA' order by 1 desc");
            return dt;
        }
        catch (Exception ex)
        {
            throw;
        }
    }
    private DataRow GetBlogData()
    {
        // Your logic to fetch the blog data
        DataTable table = new DataTable();
        table.Columns.Add("Header");
        table.Columns.Add("Image");
        table.Columns.Add("Title");
        table.Columns.Add("Description");

        DataRow row = table.NewRow();
        row["Header"] = "Your Blog Header";
        row["Image"] = "https://www.example.com/path-to-blog-image.jpg";
        row["Title"] = "Your Blog Title";
        row["Description"] = "Your Blog Description";
        table.Rows.Add(row);

        return row;
    }

  
    public DataTable GetBlogById(string id)
     {

        try
        {
            DataTable dt = SQL_DB.ExecuteDataTable("select * from BlogPost where Slugs = '" + id+"'");
            return dt;
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    public DataTable GetBlogByEdit(string id)
    {

        try
        {
            DataTable dt = SQL_DB.ExecuteDataTable("select * from BlogPost where Id = '" + id + "'");
            return dt;
        }
        catch (Exception ex)
        {
            throw;
        }
    }
    public bool SavePost(string title, string body, string metaKeywords, string metaTitle,
                      string bodyOverview, string tags, DateTime? startDateUtc, DateTime? endDateUtc,
                      string metaDescription, string imagePath, string seo)
    {
        try
        {
            // SQL query with parameterized values
            string query = @"INSERT INTO [BlogPost] (Title, Body, MetaKeywords, MetaTitle, BodyOverview, Tags, StartDateUtc, EndDateUtc, MetaDescription, CreatedOnUtc, ImagePath, Slugs)
                         VALUES (@Title, @Body, @MetaKeywords, @MetaTitle, @BodyOverview, @Tags, @StartDateUtc, @EndDateUtc, @MetaDescription, @CreatedOnUtc, @ImagePath, @Slugs)";

            using (conectionstring)
            {
                using (SqlCommand command = new SqlCommand(query, conectionstring))
                {
                    // Add parameters to the command
                    command.Parameters.AddWithValue("@Title", title);
                    command.Parameters.AddWithValue("@Body", body);
                    command.Parameters.AddWithValue("@MetaKeywords", metaKeywords);
                    command.Parameters.AddWithValue("@MetaTitle", metaTitle);
                    command.Parameters.AddWithValue("@BodyOverview", bodyOverview);
                    command.Parameters.AddWithValue("@Tags", tags);
                    command.Parameters.AddWithValue("@StartDateUtc", startDateUtc.HasValue ? (object)startDateUtc.Value : DBNull.Value);
                    command.Parameters.AddWithValue("@EndDateUtc", endDateUtc.HasValue ? (object)endDateUtc.Value : DBNull.Value);
                    command.Parameters.AddWithValue("@MetaDescription", metaDescription);
                    command.Parameters.AddWithValue("@CreatedOnUtc", DateTime.UtcNow);
                    command.Parameters.AddWithValue("@ImagePath", string.IsNullOrEmpty(imagePath) ? DBNull.Value : (object)imagePath);
                    command.Parameters.AddWithValue("@Slugs", seo);

                    // Open connection and execute command
                    conectionstring.Open();
                    command.ExecuteNonQuery();
                }
            }

            return true;
        }
        catch (Exception ex)
        {
            // Handle the exception appropriately (log, display error message, etc.)
            throw new Exception("Failed to save post", ex);
        }
    }

    private bool isImage(string name)
    {
        string extention = name.Split(".".ToCharArray())[1].ToLower();
        if (extention == "mp4" || extention == "ogg" || extention == "webm")
            return false;
        return true;
    }

  






    public bool DeletePost(int id)
    {
        try
        {
            string query = "delete from BlogPost where Id=" + id.ToString();
            SQL_DB.ExecuteNonQuery(query);
            return true;
        }
        catch (Exception ex)
        {
            return false;
            throw;
        }
    }

    private string SaveFile(FileUpload fileUpload)
    {
        string directory = AppDomain.CurrentDomain.BaseDirectory + "\\assets\\images\\blogimages";
        if (!Directory.Exists(directory))
        {
            Directory.CreateDirectory(directory);
        }
        if (fileUpload.HasFile)
        {
            string assetpath = @"\assets\images\blogimages\" + fileUpload.FileName;
            string path = directory + "\\" + fileUpload.FileName;
            fileUpload.SaveAs(path);
            return assetpath;
        }
        else
        {
            return "NA";
        }
    }
    public string GetPostImagePath(string postID)
    {
        string imagePath = null;

        // SQL query to retrieve ImagePath based on postID
        string query = "SELECT ImagePath FROM BlogPost WHERE Id = @Id";

        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, connection))
            {
                cmd.Parameters.AddWithValue("@Id", postID);
                connection.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Read the ImagePath from the result set
                        imagePath = reader["ImagePath"].ToString();
                    }
                }
            }
        }

        return imagePath;
    }

    public bool UpdatePost(string postID, string title, string body, string metaKeywords, string metaTitle,
                      string bodyOverview, string tags, DateTime? startDateUtc, DateTime? endDateUtc,
                      string metaDescription, string imagePath, string seo)
    {
        try
        {
            // SQL update query
            string updateQuery = @"
            UPDATE [BlogPost]
            SET Title = @Title,
                Body = @Body,
                MetaKeywords = @MetaKeywords,
                MetaTitle = @MetaTitle,
                BodyOverview = @BodyOverview,
                Tags = @Tags,
                StartDateUtc = @StartDateUtc,
                EndDateUtc = @EndDateUtc,
                MetaDescription = @MetaDescription,
                ImagePath = @ImagePath, -- Assuming ImagePath is the column name in your database
                Slugs = @Slugs
            WHERE Id = @Id";

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(updateQuery, connection))
                {
                    // Add parameters to the command
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Body", body);
                    cmd.Parameters.AddWithValue("@MetaKeywords", metaKeywords);
                    cmd.Parameters.AddWithValue("@MetaTitle", metaTitle);
                    cmd.Parameters.AddWithValue("@BodyOverview", bodyOverview);
                    cmd.Parameters.AddWithValue("@Tags", tags);
                    cmd.Parameters.AddWithValue("@StartDateUtc", startDateUtc ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@EndDateUtc", endDateUtc ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@MetaDescription", metaDescription);
                    cmd.Parameters.AddWithValue("@Slugs", seo);
                    cmd.Parameters.AddWithValue("@Id", postID);

                    // Add ImagePath parameter
                    if (imagePath != null)
                    {
                        cmd.Parameters.AddWithValue("@ImagePath", imagePath);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@ImagePath", DBNull.Value);
                    }

                    connection.Open();

                    // Execute the SQL command
                    int rowsAffected = cmd.ExecuteNonQuery();

                    // Check if the update was successful
                    if (rowsAffected > 0)
                    {
                        return true;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Handle the exception appropriately (log, display error message, etc.)
            throw new Exception("Failed to update post", ex);
        }

        return false;
    }


}

