using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_Brocher : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Bindgrid();
        }
    }
    public void Bindgrid()
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        string query = "select * from Brochure where Comp_Id=@Comp_Id";
        SqlCommand cmd = new SqlCommand(query, con);
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@Comp_Id", Session["CompanyId"].ToString());
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
        ImageGrid.DataSource = dt;
        ImageGrid.DataBind();

    }
    protected void btnAddImage_Click(object sender, EventArgs e)
    {
        // Check if the image file is uploaded
        if (ProductImageUpload.HasFile)
        {
            // Get the file name and save the file to the server
            string fileName = Path.GetFileName(ProductImageUpload.PostedFile.FileName);
            string filePath = Server.MapPath("~/assets/Brochure/") + fileName;
            ProductImageUpload.SaveAs(filePath);

            // Insert the data into the database
           
            string imageUrl = "~/assets/Brochure/" + fileName;
            string compid = HttpContext.Current.Session["CompanyId"].ToString();

            // Connection string (Update with your database details)

            string query = "INSERT INTO Brochure (brochure,Comp_Id) VALUES ('"+imageUrl+"','" + compid + "')";
            SQL_DB.ExecuteNonQuery(query);
            Bindgrid();

            // Show a success message or redirect to another page
            Response.Write("<script>alert('Brochure added successfully!');</script>");
        }
        else
        {
            // Show an error message if no image is uploaded
            Response.Write("<script>alert('Please upload an Brochure.');</script>");
        }
    }

    protected void ImageGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(ImageGrid.DataKeys[e.RowIndex].Values["Id"]);

        // Logic to delete the record from the database using the id
        SQL_DB.ExecuteNonQuery("Delete from Brochure where id='" + id + "'");

        // Rebind the GridView to reflect the changes
        Bindgrid();
    }

    protected void btnDownloadBill_Click(object sender, EventArgs e)
    {
        LinkButton lnkbtn = sender as LinkButton;
        GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
        string filePath = ImageGrid.DataKeys[gvrow.RowIndex].Values["Brochure"].ToString();
        Response.Clear();
        Response.Buffer = true;
        Response.ContentType = "application/pdf";//"image/jpg";
        Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filePath + "\"");
        Response.TransmitFile(Server.MapPath(filePath));
        Response.End();
    }
}