using System;
using System.Data;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Default : System.Web.UI.Page
{
    private readonly Blogs blogs;
    public DataTable dataTable;
    public Admin_Default()
    {
        blogs = new Blogs();
    }
    public string StartDate
    {
        get { return txtStartDate.Text; }
        set { txtStartDate.Text = value; }
    }

    public string EndDate
    {
        get { return txtEndDate.Text; }
        set { txtEndDate.Text = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            BindPostTable();
        }
    }
    public void BindPostTable()
    {
        dataTable = blogs.GetblogPosts();
        grdBlogs.DataSource = dataTable;
        grdBlogs.DataBind();
    }
    public void RemoveBtnClicked(Object sender, EventArgs e)
    {
        //remove
        ImageButton imgbtn1 = sender as ImageButton;
        GridViewRow row = (GridViewRow)imgbtn1.NamingContainer;
        blogs.DeletePost(int.Parse(row.Cells[0].Text.Trim()));
        BindPostTable();
    }
    public void btnsave_Clicked(object o, EventArgs e)
    {
        string postID = hdnPostId.Value; // Get the post ID from hidden field

        string str1 = Server.HtmlEncode(txtContent.Text);
        string str2 = Server.HtmlDecode(txtContent.Text);
        string bodyOverview = Server.HtmlDecode(txtBodyOverview.Text);
        string MetaDescription = Server.HtmlDecode(txtMetaDescription.Text);
        string content = str2;
        string dateStringstart = txtStartDate.Text;
        DateTime startDate = DateTime.ParseExact(dateStringstart, "yyyy-MM-dd", null);
        string dateStringend = txtEndDate.Text;
        DateTime? endDate = null; // Assuming end date is nullable
        if (!string.IsNullOrEmpty(dateStringend))
        {
            DateTime parsedEndDate;
            try
            {
                parsedEndDate = DateTime.ParseExact(dateStringend, "yyyy-MM-dd", null);
                endDate = parsedEndDate;
            }
            catch (FormatException)
            {
                // Handle invalid end date format
                // For example, display an error message or provide a default value
            }
        }

        string existingImagePath = null;
        if (!string.IsNullOrEmpty(postID))
        {
            // Get the existing image path from the database or wherever it is stored
            existingImagePath = blogs.GetPostImagePath(postID);
        }

        string imagePath = null;
        if (fileUpload.HasFile)
        {
            // Save the new image and get its path
            imagePath = SaveFile(fileUpload); // Implement SaveFile method as per your requirement
        }
        else
        {
            // Use existing image path if no new image is uploaded
            imagePath = existingImagePath;
        }

        if (!string.IsNullOrEmpty(postID))
        {
            // Update existing post
            blogs.UpdatePost(postID, txtHeader.Text.Trim(), content, txtMetaKeywords.Text, txtMetaTitle.Text, bodyOverview, txtMetaTags.Text, startDate, endDate, MetaDescription, imagePath, txtseo.Text.Trim());
        }
        else
        {
            // Save new post
            blogs.SavePost(txtHeader.Text.Trim(), content, txtMetaKeywords.Text, txtMetaTitle.Text, bodyOverview, txtMetaTags.Text, startDate, endDate, MetaDescription, imagePath, txtseo.Text.Trim());
        }

        // Generate schema markup
        string schemaMarkup = GenerateServiceSchema(
            txtHeader.Text.Trim(),
            imagePath,
            txtMetaTitle.Text,
            MetaDescription,
            "VCQRU" // Example brand name
        );

        // Inject schema markup into the page
        AddSchemaMarkupToPage(schemaMarkup);

        // After saving or updating, rebind the post table
        BindPostTable();

        // Clear form fields
        ClearFormFields();
    }




    // Method to save file and return its path
    private string SaveFile(FileUpload fileUpload)
    {
        string directory = AppDomain.CurrentDomain.BaseDirectory + "\\assets\\images\\blogimages";
        if (!Directory.Exists(directory))
        {
            Directory.CreateDirectory(directory);
        }
        if (fileUpload.HasFile)
        {
            string fileName = Path.GetFileName(fileUpload.FileName);
            string path = Path.Combine(directory, fileName);
            fileUpload.SaveAs(path);
            string assetPath = "/assets/images/blogimages/" + fileName;
            return assetPath;
        }
        else
        {
            return null; // Handle this case according to your logic
        }
    }


    protected void grdBlogs_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells.Count > 1)
            {
                //e.Row.Cells[0].Visible = false;
                //e.Row.Cells[0].Attributes.Add("width", "display:none");
                if (e.Row.Cells[2].Text.Length > 100)
                {
                    e.Row.Cells[2].Attributes.Add("Title", e.Row.Cells[2].Text);
                    e.Row.Cells[2].Text = e.Row.Cells[2].Text.Substring(0, 100) + "...";
                }
                if (e.Row.Cells[1].Text.Length > 20)
                {
                    e.Row.Cells[1].Attributes.Add("Title", e.Row.Cells[1].Text);
                    e.Row.Cells[1].Text = e.Row.Cells[1].Text.Substring(0, 20) + "...";
                }
            }
        }
        //else
        //{
        //    e.Row.Cells[0].Attributes.Add("style", "display:none");
        //}
    }

    protected void grdBlogs_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdBlogs.PageIndex = e.NewPageIndex;
        BindPostTable();
    }

    protected void calEndDate_SelectionChanged(object sender, EventArgs e)
    {

    }
    private void PopulatePostData(string postId)
    {
        var post = blogs.GetBlogByEdit(postId); // Assuming this method retrieves blog post details

        if (post.Rows.Count > 0)
        {
            DataRow row = post.Rows[0];
            txtHeader.Text = row["Title"].ToString();
            txtMetaTitle.Text = row["MetaTitle"].ToString();
            txtMetaKeywords.Text = row["MetaKeywords"].ToString();
            txtMetaDescription.Text = row["MetaDescription"].ToString();
            txtseo.Text = row["Slugs"].ToString();
            DateTime startDate;
            if (DateTime.TryParse(row["StartDateUtc"].ToString(), out startDate))
            {
                txtStartDate.Text = startDate.ToString("yyyy-MM-dd");
            }
            else
            {
                // Handle the case where the date is not valid
                txtStartDate.Text = string.Empty;
            }


            DateTime endDate;
            if (DateTime.TryParse(row["EndDateUtc"].ToString(), out endDate))
            {
                txtEndDate.Text = endDate.ToString("yyyy-MM-dd");
            }
            else
            {
                // Handle the case where the date is not valid
                txtEndDate.Text = string.Empty;
            }
            txtContent.Text = row["Body"].ToString();
            txtBodyOverview.Text = row["BodyOverview"].ToString();
            txtMetaTags.Text = row["Tags"].ToString();
            rfvFileUpload.Enabled = false;
            UploadedImageView.ImageUrl = row["ImagePath"].ToString();

            // Assuming btnSave is your ASP.NET Button control
            btnSave.Text = "Update"; // Change button text to "Update"

            // Set a hidden field to store the post ID for later use
            hdnPostId.Value = postId;

            // Expand the collapse element (assuming you want to show the form)
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowFormScript", "$('#collapseExample').collapse('show');", true);
        }
    }

    //[WebMethod]
    //[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    //public static object Upload()
    //{
    //    HttpContext context = HttpContext.Current;
    //    context.Response.ContentType = "application/json";

    //    try
    //    {
    //        HttpPostedFile file = context.Request.Files[0];
    //        if (file != null && file.ContentLength > 0)
    //        {
    //            string filename = Path.GetFileName(file.FileName);
    //            string savePath = context.Server.MapPath("~/Uploads/") + filename;
    //            file.SaveAs(savePath);

    //            return new { success = true, fileUrl = "~/Uploads/" + filename };
    //        }
    //        else
    //        {
    //            return new { success = false, error = "No file uploaded." };
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        return new { success = false, error = ex.Message };
    //    }
    //}




    protected void grdBlogs_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditRow")
        {
            string postId = (string)e.CommandArgument;
            // Load the data for the selected post and populate the form for editing
            PopulatePostData(postId); // Implement this method to load data into your form fields
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

        var serializer = new JavaScriptSerializer();
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



    private void ClearFormFields()
{
    txtHeader.Text = "";
    txtContent.Text = "";
    txtEndDate.Text = string.Empty;
    txtStartDate.Text = string.Empty;
    txtMetaDescription.Text = string.Empty;
    txtMetaKeywords.Text = string.Empty;
    txtMetaTags.Text = string.Empty;
    txtMetaTitle.Text = string.Empty;
    txtseo.Text = string.Empty;
}
}

//protected void grdBlogs_SelectedIndexChanged(object sender, EventArgs e)
//{

//     string str1 = Server.HtmlEncode(txtContent.Text);
//    string str2 = Server.HtmlDecode(txtContent.Text);
//    string bodyOverview = Server.HtmlDecode(txtBodyOverview.Text);
//    string MetaDescription = Server.HtmlDecode(txtMetaDescription.Text);
//    string content = str2;
//    string dateStringstart = txtStartDate.Text;
//    DateTime startDate = DateTime.ParseExact(dateStringstart, "yyyy-MM-dd", null);
//    string dateStringend = txtEndDate.Text;
//    DateTime? endDate = null; // Assuming end date is nullable
//    if (!string.IsNullOrEmpty(dateStringend))
//    {
//        DateTime parsedEndDate;
//        try
//        {
//            parsedEndDate = DateTime.ParseExact(dateStringend, "yyyy-MM-dd", null);
//            endDate = parsedEndDate;
//        }
//        catch (FormatException)
//        {
//            // Handle invalid end date format
//            // For example, display an error message or provide a default value
//        }
//    }


//    blogs.SavePost(txtHeader.Text.Trim(), content,txtMetaKeywords.Text,txtMetaTitle.Text,bodyOverview,txtMetaTags.Text,startDate,endDate, MetaDescription, fileUpload,txtseo.Text.Trim());
//    BindPostTable();
//    txtHeader.Text = "";
//    txtContent.Text = "";
//    txtEndDate.Text = string.Empty;
//    txtStartDate.Text = string.Empty;
//    //txtLanguageId.Text = string.Empty;
//    txtMetaDescription.Text = string.Empty;
//    txtMetaKeywords.Text = string.Empty;
//    txtMetaTags.Text = string.Empty;
//    txtMetaTitle.Text = string.Empty;
//    //chkAllowComments.Checked = false;
//   // chkIncludeInSitemap.Checked = false;
//   // chkLimitedToStore.Checked = false;

//}




