using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_dailylimit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCompanyIds();
            LoadCurrentLimits();
        }
    }

    protected void btnSetLimit_Click(object sender, EventArgs e)
    {
        string compId = ddlCompId.SelectedValue; // Get the selected value from the dropdown
        int limit;

        if (int.TryParse(txtLimit.Text.Trim(), out limit))
        {
            try
            {
                if (limit > 10000)
                {
                    lblError.Text = "Over limit not allow.";
                    lblError.Visible = true;
                    return;
                }
                DataTable dtcomp = SQL_DB.ExecuteDataTable("select*from tbl_HDFC_Daily_Limit where comp_id='"+ compId + "'");
                if (dtcomp.Rows.Count > 0)
                {
                    lblError.Text = "Limit already set for this client.";
                    lblError.Visible = true;
                    return;
                }
                lblError.Visible = false;
                InsertDailyLimit(compId, limit);
                LoadCurrentLimits();
                txtLimit.Text = string.Empty; // Clear input fields
            }
            catch (SqlException ex)
            {
                lblError.Text = "An error occurred while setting the limit. Please try again.";
                lblError.Visible = true;
                // Optionally log the exception
            }
        }
        else
        {
            lblError.Text = "Please enter a valid numeric daily limit.";
            lblError.Visible = true;
        }
    }

    private void InsertDailyLimit(string compId, int limit)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand("INSERT INTO tbl_HDFC_Daily_Limit (Comp_id, Limit) VALUES (@CompId, @Limit)", conn))
            {
                cmd.Parameters.AddWithValue("@CompId", compId);
                cmd.Parameters.AddWithValue("@Limit", limit);
                cmd.ExecuteNonQuery();
            }
        }
    }


    private void LoadCurrentLimits()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand("SELECT c.Comp_Name, Limit, Entry_date FROM tbl_HDFC_Daily_Limit  h inner join Comp_Reg c on h.comp_id=c.Comp_ID", conn))
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvLimits.DataSource = dt;
                    gvLimits.DataBind();
                }
            }
        }
    }
    protected void gvLimits_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLimits.PageIndex = e.NewPageIndex; // Set the new page index
        LoadCurrentLimits(); // Rebind the data to the GridView
    }


    private void LoadCompanyIds()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand("SELECT DISTINCT cr.Comp_ID, Comp_Name FROM Comp_Reg cr INNER JOIN M_ServiceSubscription ms ON ms.Comp_ID = cr.Comp_ID WHERE Email_Vari_Flag = 1 AND Status = 1 AND Delete_Flag = 1 AND ms.Service_ID = 'SRV1028'", conn))
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    ddlCompId.DataSource = dt;
                    ddlCompId.DataTextField = "Comp_Name"; // Displayed name
                    ddlCompId.DataValueField = "Comp_ID"; // Value of the dropdown
                    ddlCompId.DataBind();
                }
            }
        }

        // Add a default item
        ListItem defaultItem = new ListItem("Select a Company", "");
        ddlCompId.Items.Insert(0, defaultItem);
        ddlCompId.Items[0].Attributes["disabled"] = "disabled"; // Disable the default item
    }



    protected void btnUpdateLimit_Click(object sender, EventArgs e)
    {
        string compId = ddlCompId.SelectedValue; // Get the selected company ID from the dropdown
        int newLimit;

        // Parse the limit from the text box
        if (int.TryParse(txtLimit.Text.Trim(), out newLimit))
        {
            if (newLimit > 10000)
            {
                lblError.Text = "Over limit not allow.";
                lblError.Visible = true;
                return;
            }
            lblError.Visible = false;
            UpdateDailyLimit(compId, newLimit);
            LoadCurrentLimits(); // Reload the limits after updating
            txtLimit.Text = string.Empty; // Clear input fields
            lblError.Visible = false; // Hide any previous error messages
        }
        else
        {
            lblError.Text = "Please enter a valid numeric daily limit.";
            lblError.Visible = true;
        }
    }
    private void UpdateDailyLimit(string compId, int limit)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand("UPDATE tbl_HDFC_Daily_Limit SET Limit = @Limit WHERE Comp_id = @CompId", conn))
            {
                cmd.Parameters.AddWithValue("@CompId", compId);
                cmd.Parameters.AddWithValue("@Limit", limit);
                cmd.ExecuteNonQuery();
            }
        }
    }
}
