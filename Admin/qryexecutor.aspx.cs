using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class qryexecutor : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        // Define your connection string directly in the code
        string connString = "Connect Timeout=10000000; pooling=true; Max Pool Size=1000;Data Source=20.204.114.42\\ProdAdmin,1433;Initial Catalog=vcqru;User ID=Bipin_Prod;Password=j47mygNq2w3QuxM";

        // Retrieve the query from the text box
        string query = txtQuery.Text;

        // Check for potentially harmful SQL commands (like UPDATE, DELETE, etc.)
        if (query.IndexOf("update", StringComparison.OrdinalIgnoreCase) >= 0 ||
            query.IndexOf("delete", StringComparison.OrdinalIgnoreCase) >= 0 ||
            query.IndexOf("drop", StringComparison.OrdinalIgnoreCase) >= 0 ||
            query.IndexOf("insert", StringComparison.OrdinalIgnoreCase) >= 0)
        {
            // Show an error message and prevent execution of the query
            lblErrorMessage.Text = "Unsafe SQL queries are not allowed.";
            gvResults.DataSource = null;
            gvResults.DataBind();
            return;
        }

        try
        {
            // Create a SQL connection using the connection string
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Create a data adapter to execute the query
                SqlDataAdapter da = new SqlDataAdapter(query, conn);

                // Fill the data into a DataTable
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Bind the result to the GridView
                gvResults.DataSource = dt;
                gvResults.DataBind();
                lblErrorMessage.Text = "";
            }
        }
        catch (Exception ex)
        {
            // If an error occurs, display it in a label
            lblErrorMessage.Text = "An error occurred: " + ex.Message;
            gvResults.DataSource = null;
            gvResults.DataBind();
        }
    }


    protected void btnExport_Click(object sender, EventArgs e)
    {
        if (gvResults.Rows.Count > 0)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=ExportedData.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                // Write the header row
                gvResults.HeaderRow.BackColor = System.Drawing.Color.Gray;
                foreach (TableCell cell in gvResults.HeaderRow.Cells)
                {
                  //  hw.Write("<b>");
                    hw.Write(cell.Text);
                   // hw.Write("</b>");
                    hw.Write("\t");
                }
                hw.Write("\n");

                // Write data rows
                foreach (GridViewRow row in gvResults.Rows)
                {
                    foreach (TableCell cell in row.Cells)
                    {
                        hw.Write(cell.Text);
                        hw.Write("\t");
                    }
                    hw.Write("\n");
                }

                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }
    }


    public override void VerifyRenderingInServerForm(Control control)
    {
        // Confirms that an HtmlForm control is rendered for the GridView.
    }
}