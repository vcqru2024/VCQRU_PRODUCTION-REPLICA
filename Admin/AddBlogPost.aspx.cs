using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
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
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
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
    public void RemoveBtnClicked(Object sender,EventArgs e)
    {
        //remove
        ImageButton imgbtn1 = sender as ImageButton;
        GridViewRow row = (GridViewRow)imgbtn1.NamingContainer;
        blogs.DeletePost(int.Parse(row.Cells[0].Text.Trim()));
        BindPostTable();
    }
    public void btnsave_Clicked(object o,EventArgs e)
    {
        blogs.SavePost(txtHeader.Text.Trim(), txtContent.Text.Trim(), fileUpload);
        BindPostTable();
        txtHeader.Text = "";
        txtContent.Text = "";

    }

    protected void grdBlogs_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if(e.Row.RowType == DataControlRowType.DataRow)
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
}