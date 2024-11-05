using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_PointChart : System.Web.UI.Page
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
        string query = "select * from PointChart where Comp_Id=@Comp_Id";
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

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        // Reset DropDownList to the default value
        ddlCategory.SelectedIndex = 0;

        // Clear the uploaded file
        ProductImageUpload.Attributes.Clear(); // Note: FileUpload control cannot be cleared directly, so we clear its attributes

    }

    protected void btnAddImage_Click(object sender, EventArgs e)
    {
        // Check if the image file is uploaded
        if (ProductImageUpload.HasFile)
        {
            // Get the file name and save the file to the server
            string fileName = Path.GetFileName(ProductImageUpload.PostedFile.FileName);
            string filePath = Server.MapPath("~/assets/PointChart/") + fileName;
            ProductImageUpload.SaveAs(filePath);

            // Insert the data into the database
            string title = "Example";
            string category = ddlCategory.SelectedItem.Text;
            string imageUrl = "~/assets/PointChart/" + fileName;
            string compid= HttpContext.Current.Session["CompanyId"].ToString();

            // Connection string (Update with your database details)

            string query = "INSERT INTO PointChart (Category, Image,Title,Comp_Id) VALUES ('" + category + "', '" + imageUrl + "','"+title+"','"+compid+"')";
            SQL_DB.ExecuteNonQuery(query);
            Bindgrid();

            // Clear the controls after successful insert
           
            ddlCategory.ClearSelection();
            ProductImageUpload.Attributes.Clear();
            // Show a success message or redirect to another page
            Response.Write("<script>alert('Image added successfully!');</script>");
        }
        else
        {
            // Show an error message if no image is uploaded
            Response.Write("<script>alert('Please upload an image.');</script>");
        }
    }

    protected void ImageGrid_RowEditing(object sender, GridViewEditEventArgs e)
    {
        ImageGrid.EditIndex = e.NewEditIndex;

        Bindgrid();
    }

    protected void ImageGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow row = ImageGrid.Rows[e.RowIndex];
        int messageId = Convert.ToInt32(ImageGrid.DataKeys[e.RowIndex].Values["Id"]);
        FileUpload fileUploadControl = row.FindControl("editImage") as FileUpload;
        bool isFileUploaded = fileUploadControl != null && fileUploadControl.HasFile;
        DropDownList grdddlCategory = row.FindControl("editddlCategory") as DropDownList;
        if (isFileUploaded)
        {
            // Proceed with file processing
            string fileName = Path.GetFileName(fileUploadControl.FileName);
            string filePath = Server.MapPath("~/assets/PointChart/") + fileName;
            fileUploadControl.SaveAs(filePath);
            string grdimageurl= "~/assets/PointChart/" + fileName;
            // Additional logic for storing the file path in the database, etc.
            // Construct the update query using string concatenation
            string query = "UPDATE Pointchart SET " +
                           "Image='" + grdimageurl + "', " +
                           "Category='" + grdddlCategory.SelectedItem.Text + "' " +
                           "WHERE Id='" + messageId + "'";
            try
            {
                SQL_DB.ExecuteNonQuery(query);
                Response.Write("<script>alert('Record updated successfully.');</script>");
                //// Optionally, you may want to handle success or bind data
                //LblMsg.Text = "Record updated successfully.";
                //LblMsg.ForeColor = System.Drawing.Color.Green;
                ImageGrid.EditIndex = -1; // Exit edit mode
                Bindgrid(); // Refresh the GridView
            }
            catch (Exception ex)
            {
                // Handle and log the exception as needed
                //LblMsg.Text = "Error updating record: " + ex.Message;
                //LblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }
        else
        {
            // Handle the case when no file is uploaded
            // For example, show a message to the user
            Response.Write("<script>alert('Please upload a file.');</script>");
        }

       

        
    }

    protected void ImageGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        ImageGrid.EditIndex = -1;
        Bindgrid();
    }

    protected void btnDownloadBill_Click(object sender, EventArgs e)
    {
        LinkButton lnkbtn = sender as LinkButton;
        GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
        string filePath = ImageGrid.DataKeys[gvrow.RowIndex].Values["Image"].ToString();
        Response.Clear();
        Response.Buffer = true;
        Response.ContentType = "application/pdf";//"image/jpg";
        Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filePath + "\"");
        Response.TransmitFile(Server.MapPath(filePath));
        Response.End();
    }

    protected void ImageGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(ImageGrid.DataKeys[e.RowIndex].Values["Id"]);

        // Logic to delete the record from the database using the id
        SQL_DB.ExecuteNonQuery("Delete from Pointchart where id='" + id + "'");

        // Rebind the GridView to reflect the changes
        Bindgrid();
    }
}