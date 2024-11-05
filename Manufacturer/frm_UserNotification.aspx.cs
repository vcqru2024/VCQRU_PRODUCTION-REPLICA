using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_frm_UserNotification : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("~/Login.aspx?Page=frm_UserNotification.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("~/adminLogin.aspx");
        }
        if (!IsPostBack)
        {
            Bindgrid();
        }
    }
    public void Bindgrid()
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        string query = "select * from tblappnotification where Compid=@Comp_Id";
        SqlCommand cmd = new SqlCommand(query, con);
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@Comp_Id", Session["CompanyId"].ToString());
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
        grd1.DataSource = dt;
        grd1.DataBind();

    }

    protected void lnkDownload_Click(object sender, EventArgs e)
    {
        LinkButton lnkbtn = sender as LinkButton;
        GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
        string filePath = grd1.DataKeys[gvrow.RowIndex].Values["Image_Path"].ToString();
        Response.Clear();
        Response.Buffer = true;
        Response.ContentType = "application/pdf";//"image/jpg";
        Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filePath + "\"");
        Response.TransmitFile(Server.MapPath(filePath));
        Response.End();
    }
    protected void ValidateFileUpload(object source, ServerValidateEventArgs args)
    {
        string[] validExtensions = { ".jpg", ".jpeg", ".png" };
        if (compLogo.HasFile)
        {
            string fileExtension = System.IO.Path.GetExtension(compLogo.FileName).ToLower();
            args.IsValid = validExtensions.Contains(fileExtension);
        }
        else
        {
            args.IsValid = false; // Ensure that a file is uploaded
        }
    }
    protected void ValidateMobileNumbers(object source, ServerValidateEventArgs args)
    {
        string[] mobileNumbers = args.Value.Split(',');
        foreach (string mobile in mobileNumbers)
        {
            if (!System.Text.RegularExpressions.Regex.IsMatch(mobile.Trim(), @"^\d{10}$"))
            {
                args.IsValid = false;
                return;
            }
        }
        args.IsValid = true;
    }

    protected void btn_download_Click(object sender, EventArgs e)
    {
        bool isActive = chkActive.Checked;
        string validFrom = txtValidFrom.Text;
        string validTill = txtValidTill.Text;
        LblMsg.Text = "";

        if (Page.IsValid)
        {
            try
            {
                string fileExtension = System.IO.Path.GetExtension(compLogo.FileName).ToLower();
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    string imageFilePath = "NA";
                    Guid obj = Guid.NewGuid();
                    if (compLogo.HasFile)
                    {

                        string fileName = obj.ToString() + Path.GetExtension(compLogo.FileName);
                        string uploadPath = Server.MapPath("~/Info/img/Notification/");
                        imageFilePath = "/Info/img/Notification/" + fileName;

                        string fullUploadPath = Path.Combine(uploadPath, fileName);
                        compLogo.SaveAs(fullUploadPath);
                    }
                    else
                    {
                        // No file uploaded, show error alert using SweetAlert2
                        string script = "<script>showAlert('Error', 'Please select a file to upload.', 'error');</script>";
                        ClientScript.RegisterStartupScript(this.GetType(), "showAlert", script);
                    }


                    string companyId = Session["CompanyId"].ToString();
                    string header = txtheader.Text;
                    string message = txtMessage.Text;
                    string mobileNumbers = txtMobileNumber.Text;

                    if (!string.IsNullOrEmpty(mobileNumbers))
                    {
                        string[] mobiles = mobileNumbers.Split(',');

                        foreach (string mobile in mobiles)
                        {
                            SQL_DB.ExecuteNonQuery("INSERT INTO tblappNotification (Compid, Mobile, Headers, Message, Image_Path, Valid_from, Valid_till, IsActive) " +
                                                   "VALUES ('" + companyId + "', '" + mobile.Trim() + "', '" + header + "', '" + message + "', '" + imageFilePath + "', '" + validFrom + "', '" + validTill + "', '" + Convert.ToInt16(isActive) + "')");
                        }
                    }
                    else
                    {
                        SQL_DB.ExecuteNonQuery("INSERT INTO tblappNotification (Compid, Headers, Message, Image_Path, Valid_from, Valid_till, IsActive) " +
                                               "VALUES ('" + companyId + "', '" + header + "', '" + message + "', '" + imageFilePath + "', '" + validFrom + "', '" + validTill + "', '" + Convert.ToInt16(isActive) + "')");
                    }

                    Bindgrid();
                    LblMsg.Text = "Sent successfully.";
                    LblMsg.ForeColor = System.Drawing.Color.Green;
                    txtheader.Text = "";
                    txtMessage.Text = "";
                    txtMobileNumber.Text = "";
                    txtValidFrom.Text = "";
                    txtValidTill.Text = "";
                    chkActive.Checked = false;
                }
                else
                {
                    // Invalid file extension, show error alert using SweetAlert2
                    string script = "<script>showAlert('Error', 'Only .jpg, .jpeg, or .png files are allowed.', 'error');</script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "showAlert", script);
                }
            }
            catch (Exception ex)
            {
                LblMsg.Text =  "Something went wrong!";
                LblMsg.ForeColor = System.Drawing.Color.Red;
                // Optionally log the exception
            }
        }
    }



    protected void ddlProSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlProSearch.SelectedItem.Value == "1")
            Inputmobile.Visible = true;
        else
            Inputmobile.Visible = false;
    }

    protected void grd1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        grd1.EditIndex = -1;
        Bindgrid();
    }

    protected void grd1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow row = grd1.Rows[e.RowIndex];
        int messageId = Convert.ToInt32(grd1.DataKeys[e.RowIndex].Values["Message_id"]);

        // Retrieve updated values from the edit controls
        bool isActive = (row.FindControl("chkIsReadEdit") as CheckBox).Checked;
        DateTime validFrom = DateTime.ParseExact((row.FindControl("txtValidfromEdit") as TextBox).Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);
        DateTime validTill = DateTime.ParseExact((row.FindControl("txtValidtillEdit") as TextBox).Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);

        // Construct the update query using string concatenation
        string query = "UPDATE tblappNotification SET " +
                       "IsActive='" + Convert.ToInt16(isActive) + "', " +
                       "Valid_from='" + validFrom.ToString("yyyy-MM-dd") + "', " +
                       "Valid_till='" + validTill.ToString("yyyy-MM-dd") + "' " +
                       "WHERE Message_id='" + messageId + "'";

        try
        {
            SQL_DB.ExecuteNonQuery(query);

            // Optionally, you may want to handle success or bind data
            LblMsg.Text = "Record updated successfully.";
            LblMsg.ForeColor = System.Drawing.Color.Green;
            grd1.EditIndex = -1; // Exit edit mode
            Bindgrid(); // Refresh the GridView
        }
        catch (Exception ex)
        {
            // Handle and log the exception as needed
            LblMsg.Text = "Error updating record: " + ex.Message;
            LblMsg.ForeColor = System.Drawing.Color.Red;
        }
    }





    protected void grd1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        grd1.EditIndex = e.NewEditIndex;
        Bindgrid();
    }
}