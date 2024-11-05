using System;
using System.Web;
using System.Web.UI.WebControls;

public partial class blog : System.Web.UI.Page
{
    private readonly Blogs blogs;

    public blog()
    {
        blogs = new Blogs();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindBlogPosts(GetCurrentPageNumber());
        }
    }

    private void BindBlogPosts(int pageNumber)
    {
        const int pageSize = 10; // Set the page size
        var blogposts = blogs.GetPostsForMainPage(pageNumber, pageSize); // Get blog posts for the specified page
        blogRepeater.DataSource = blogposts;
        blogRepeater.DataBind();
        UpdatePageNumberLabel(pageNumber);
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        int currentPage = GetCurrentPageNumber();
        int totalPages = GetTotalPages(); // Retrieve the total number of pages
        int nextPage = currentPage + 1;
        if (nextPage <= totalPages) // Check if next page exceeds total pages
        {
            BindBlogPosts(nextPage);
            UpdatePageNumberInUrl(nextPage);
        }
    }

    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        int currentPage = GetCurrentPageNumber();
        int previousPage = currentPage > 1 ? currentPage - 1 : 1;
        if (previousPage >= 1) // Check if previous page is valid
        {
            BindBlogPosts(previousPage);
            UpdatePageNumberInUrl(previousPage);
        }
    }

    private int GetTotalPages()
    {
        const int pageSize = 10; // Set the page size
        int totalPosts = blogs.GetTotalPosts(); // Assuming you have a method to retrieve the total number of posts
        return (int)Math.Ceiling((double)totalPosts / pageSize);
    }

    private int GetCurrentPageNumber()
    {
        int currentPage;
        if (!int.TryParse(Request.QueryString["page"], out currentPage))
        {
            currentPage = 1;
        }
        return currentPage;
    }

    private void UpdatePageNumberInUrl(int pageNumber)
    {
        var uriBuilder = new UriBuilder(Request.Url);
        var query = HttpUtility.ParseQueryString(uriBuilder.Query);
        query["page"] = pageNumber.ToString();
        uriBuilder.Query = query.ToString();
        Response.Redirect(uriBuilder.ToString(), false); // Set 'false' to avoid terminating the request
        Context.ApplicationInstance.CompleteRequest(); // Use this to complete the request without calling Response.End
    }

    private void UpdatePageNumberLabel(int pageNumber)
    {
        lblPageNumber.Text = "Page " + pageNumber;
    }
}
