using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_UserEnquiryReport : System.Web.UI.Page
{
    SqlConnection conectionstring = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Comp_ID"] == null)
            Response.Redirect("../Patanjali/Loginpfl.aspx?From=Codeverification");
    }
    public DataTable GetDataFromDatabase()
    {
        string query = "select Name,Mobile_Number,City,Email_ID,Image_Url,Enquiry,Created_Date from tbl_Enquiries ORDER BY Created_Date DESC";
        DataTable dataTable = new DataTable();

        using (conectionstring)
        {
            try
            {
                conectionstring.Open();

               
                using (SqlCommand command = new SqlCommand(query, conectionstring))
                {
                    command.CommandType = CommandType.Text;
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(dataTable);
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions here
                Console.WriteLine("An error occurred: " + ex.Message);
            }
        }

        return dataTable;
    }

    protected void btnexport_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                string query = "select Name,Mobile_Number,City,Email_ID,'https://www.vcqru.com'+Image_Url as Image_Url,Enquiry,Created_Date as [Enquiry Date] from tbl_Enquiries ORDER BY Created_Date DESC";
                DataTable dt = new DataTable();

                using (conectionstring)
                {
                    try
                    {
                        conectionstring.Open();


                        using (SqlCommand command = new SqlCommand(query, conectionstring))
                        {
                            command.CommandType = CommandType.Text;
                            using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                            {
                                adapter.Fill(dt);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Handle exceptions here
                        Console.WriteLine("An error occurred: " + ex.Message);
                    }
                }

                
                
                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "UserEnquiryReport");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=UserEnquiryReport.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();
            }
            catch (Exception ex)
            {
                // throw ex;
            }
        }
    }
}