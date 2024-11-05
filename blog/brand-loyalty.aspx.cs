using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Xml;

public partial class blog_brand_loyalty : System.Web.UI.Page
{

    private readonly Blogs blogs;
    public DataTable dataTable;
    public blog_brand_loyalty()
    {
        blogs = new Blogs();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HtmlLink canonicalLink = (HtmlLink)Master.FindControl("canonicalLink");
            if (canonicalLink != null)
            {
                string currentUrl = Request.Url.AbsoluteUri;
                canonicalLink.Href = currentUrl;
            }
            ContentPlaceHolder jsonLdContent = (ContentPlaceHolder)Master.FindControl("JsonLdContent");
            var blogposts = blogs.GetPostsForMainPage(3);
            blogRepeater.DataSource = blogposts;
            blogRepeater.DataBind();
            string blogid = Page.RouteData.Values["Slugs"].ToString();
            // Retrieve the blog post details from the database based on the query string parameter
            if (blogid != null)
            {
                // Fetch and display the details of the selected blog post
                dataTable = blogs.GetBlogById(blogid);
                if (dataTable.Rows.Count > 0)
                {
                    DataRow row = dataTable.Rows[0];
                    HtmlTitle pageTitle = (HtmlTitle)Master.FindControl("pageTitle");
                    if (pageTitle != null)
                    {
                        pageTitle.Text = row["Title"].ToString();
                    }
                    HtmlMeta metaKeywords = (HtmlMeta)Master.FindControl("keywords");
                    if (metaKeywords != null)
                    {
                        metaKeywords.Attributes["content"] = row["MetaKeywords"].ToString();
                    }

                    HtmlMeta metaDescription = (HtmlMeta)Master.FindControl("metaDescription");
                    if (metaDescription != null)
                    {
                        string metaDescriptionValue = row["MetaDescription"].ToString();
                        string decodedMetaDescription = RemoveHTMLTags(metaDescriptionValue);

                        metaDescription.Attributes["content"] = decodedMetaDescription;
                    }
                    breadcrum.Text= row["Title"].ToString();
                    lblHeader.Text = row["Title"].ToString();
                    lblPost.Text = row["Body"].ToString();
                    imgPost.ImageUrl = row["ImagePath"].ToString();
                    // Assuming `row["CreatedOnUtc"]` contains the date in a recognizable format, such as "2023-03-15T00:00:00"
                    DateTime createdOnUtc;
                    if (DateTime.TryParse(row["CreatedOnUtc"].ToString(), out createdOnUtc))
                    {
                        lbldate.Text = createdOnUtc.ToString("MMM dd, yyyy");
                    }
                    else
                    {
                        // Handle the case where the date parsing fails, if necessary
                        lbldate.Text = "Invalid Date";
                    }

                    string schemaMarkup = GenerateServiceSchema(
                    row["Title"].ToString(),
                    row["ImagePath"].ToString(),
                    row["MetaTitle"].ToString(),
                    row["MetaDescription"].ToString(),
                    "VCQRU" // Example brand name
                );

                    // Inject schema markup into the page
                    AddSchemaMarkupToPage(schemaMarkup);
                  
                }
            }
            else
            {
                // Handle the case when blogId is not provided in the query string
                // For simplicity, redirecting to the blog page
                Response.Redirect("blog.aspx");
            }
        }
    }

    private string GenerateServiceSchema(string name, string image, string title, string description, string brand)
    {
        var schema = new
        {
            @context = "https://schema.org/",
            @type = "Service",
            name = name,
            image = image,
            title = title,
            description = description,
            brand = new
            {
                @type = "Brand",
                name = brand
            }
        };

        var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        return serializer.Serialize(schema);
    }

    private void AddSchemaMarkupToPage(string schemaMarkup)
    {
        // Create the script tag with the schema markup
        string scriptTag = String.Format("<script type='application/ld+json'>{0}</script>", schemaMarkup);

        // Check if the schema script is already added
        if (Page.Header.FindControl("schemaScript") == null)
        {
            LiteralControl schemaScript = new LiteralControl(scriptTag);
            schemaScript.ID = "schemaScript"; // Set ID to avoid duplicates

            // Ensure the header is not null
            if (Page.Header != null)
            {
                Page.Header.Controls.Add(schemaScript);
            }
            else
            {
                // If Page.Header is null, use other methods to add the script
                // For example, adding it to the form or the body
                Page.Form.Controls.AddAt(0, schemaScript);
            }

            // Log to confirm script is added
            System.Diagnostics.Debug.WriteLine("Schema script added to page.");
        }
        else
        {
            System.Diagnostics.Debug.WriteLine("Schema script already exists.");
        }
    }

    public static string RemoveHTMLTags(string input)
    {
        // Check if the input string is null or empty
        if (string.IsNullOrEmpty(input))
            return string.Empty;

        // Remove HTML tags using a simple loop
        bool insideTag = false;
        int insideTagCount = 0;
        char[] output = new char[input.Length];
        int index = 0;

        foreach (char c in input)
        {
            if (c == '<')
            {
                insideTag = true;
                insideTagCount++;
            }
            else if (c == '>')
            {
                insideTag = false;
            }
            else if (!insideTag)
            {
                output[index++] = c;
            }
        }

        return new string(output, 0, index);
    }
}