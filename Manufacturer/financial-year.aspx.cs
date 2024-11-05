using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.WebControls;
public partial class Manufacturer_financial_year : System.Web.UI.Page
{
    private static readonly Regex mobileNumberRegex = new Regex(@"^[789]\d{9}$");
    //private static readonly Regex upiIdRegex = new Regex(@"^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("~/Login.aspx?Page=financial-year.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("~/adminLogin.aspx");
        }
        if (!IsPostBack)
        {
            
            string fromdate = string.Empty, todate = string.Empty;
            // string fromdate = System.DateTime.Now.ToString("yyyy-MM-dd") + " 00:00:00.000";
            //string todate = System.DateTime.Now.ToString("yyyy-MM-dd") + " 23:59:00.000";

            //txtDateFrom.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
            //txtDateto.Text = System.DateTime.Now.ToString("yyyy-MM-dd");         

            Bindgrid(Session["CompanyId"].ToString());
        }
    }
  
    public void Bindgrid(string compid)
    {
        try
        {
            
           DataTable dt = SQL_DB.ExecuteDataTable("exec sp_getFinancialreport'" + Session["CompanyId"].ToString() + "'");
            grd1.DataSource = dt;
            grd1.DataBind();

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void btn_download_Click(object sender, EventArgs e)
    {
       
        if (Page.IsValid)
        {
            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                
                DataTable dt = SQL_DB.ExecuteDataTable("exec sp_getFinancialreport'" + Session["CompanyId"].ToString() + "'");

                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "sp_getFinancialreport");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=sp_getFinancialreport.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
 
}