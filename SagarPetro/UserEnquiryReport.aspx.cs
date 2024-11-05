using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_UserEnquiryReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblbind(); 
        }
        if (Session["Comp_ID"] == null)
            Response.Redirect("~/Patanjali/Loginpfl.aspx?From=Codeverification");
    }
    public DataTable GetDataFromDatabase()
    {
        string query = @"
    SELECT 
        Row_ID,
        Name, 
        Mobile_Number, 
        City, 
        Email_ID, 
        Image_Url, 
        Enquiry, 
        Created_Date,
        CASE 
            WHEN Status = 0 THEN 'New' 
            WHEN Status = 1 THEN 'Open' 
            WHEN Status = 2 THEN 'Close' 
            ELSE 'Unknown' 
        END AS Status_Text,
        CASE 
            WHEN Calling_Status = 0 THEN 'Not Connected' 
            WHEN Calling_Status = 1 THEN 'Connected' 
            WHEN Calling_Status = 2 THEN 'Unreachable' 
            WHEN Calling_Status = 3 THEN 'Call Later' 
            ELSE 'Unknown' 
        END AS Calling_Status_Text,
        Remarks 
    FROM 
        tbl_Enquiries 
    ORDER BY 
        Created_Date DESC";

        DataTable dataTable = new DataTable();
        try
        {
            dataTable = SQL_DB.ExecuteDataTable(query);
        }
        catch (Exception ex)
        {
            // Handle exceptions here
            Console.WriteLine("An error occurred: " + ex.Message);
        }
        return dataTable;
    }
    // Define a web method that will be called asynchronously
    [WebMethod]
    public static string UpdateDetailsOnServer(string status, string remarks, string callingStatus)
    {

        try
        {
            SQL_DB.ExecuteNonQuery("UPDATE tbl_Enquiries SET remarks = '" + remarks.Trim() + "', status = " + status + ", calling_status = " + callingStatus + "");
            return "Details updated successfully!";
        }
        catch (Exception ex)
        {
            // Handle any exceptions that occur during the update process
            // Log the error or return an error message as needed
            return "An error occurred while updating details: " + ex.Message;
        }
    }

    protected void EnquiryUpdate_Click(object sender, EventArgs e)
    {
        string rowIdString = editRow_ID.Value; // Retrieve the value as a string

        // Convert the string value to an integer using int.TryParse
        int rowId;
        if (int.TryParse(rowIdString, out rowId))
        {
            // Now you can use 'rowId' as an integer
            // Example usage:
            // Do something with 'rowId'
        }
        else
        {
            // Handle the case where the value couldn't be parsed as an integer
            // For example, log an error or display a message to the user
        }
        string remarks = editRemarks.Text; // Assuming editRemarks is the ID of your textarea
        int status = editStatus.SelectedIndex;
        int callingstatus = editCallingStatus.SelectedIndex;
        try
        {
            SQL_DB.ExecuteNonQuery("UPDATE tbl_Enquiries SET remarks = '" + remarks.Trim() + "', Status = " + status + ", Calling_Status = " + callingstatus + " where Row_ID=" + rowId + "");
            ScriptManager.RegisterStartupScript(this, GetType(), "alertScript", "showAlert('Success!', 'Your Changes have been submitted successfully.', 'success');", true);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alertScript", "showAlert('Error!', 'Failed to submit your Changes. Please try again later.', 'error');", true);
        }
        finally
        {
            lblbind();
        }
    }
    protected void lblbind()
    {
       lblnewenq.InnerText= SQL_DB.ExecuteScalar("select COUNT(Status) from tbl_Enquiries where status=0").ToString();
        lblopnenq.InnerText = SQL_DB.ExecuteScalar("select COUNT(Status) from tbl_Enquiries where status=1").ToString();
        lblclsenq.InnerText = SQL_DB.ExecuteScalar("select COUNT(Status) from tbl_Enquiries where status=2").ToString();
        lblgenenq.InnerText = SQL_DB.ExecuteScalar("select count(*) from tbl_Enquiries").ToString();
    }
}