using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_TdsReport : System.Web.UI.Page
{

    public class Listing
    {
        public int Id{ get; set; }
        public string Year { get; set; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("~/Login.aspx?Page=TdsReport.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("~/adminLogin.aspx");
        }
        if (!IsPostBack)
        {
            GetFinancialYear();
        }
    }

    public void GetFinancialYear()
    {
        string StartYear = "2018";
        string PreYear = "2017";
        string CurrentYear = DateTime.Now.Year.ToString();
        int Count = 1;

        List<Listing> list = new List<Listing>();
       
       
        while (StartYear != CurrentYear)
        {

            Listing lst = new Listing();
            int StrYear = Convert.ToInt32(StartYear);
            int PrYear = Convert.ToInt32(PreYear);
            StartYear = (StrYear + 1).ToString();
            PreYear = (PrYear + 1).ToString();
            string Financialyear = PreYear + "-" + StartYear;
            lst.Id = Count;
            lst.Year = Financialyear;
            list.Add(lst);

            Count++;

        }

        ddlfinacialYear.DataSource = list.ToList();
        ddlfinacialYear.DataTextField = "Year";
        ddlfinacialYear.DataValueField = "Year";
        ddlfinacialYear.DataBind();
    }
    public void Bindgrid(string datefrom, string dateto)
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("TDSReport_SSRS_VendorWise", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@companyid", Session["CompanyId"].ToString());
        cmd.Parameters.AddWithValue("@financialperiod", ddlfinacialYear.SelectedItem.Text);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
        grd1.DataSource = dt;
        grd1.DataBind();

    }
    protected void btn_download_Click(object sender, EventArgs e)
    {
        
        
        if (Page.IsValid)
        {
            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("TDSReport_SSRS_VendorWise", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@financialperiod", ddlfinacialYear.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@companyid", Session["CompanyId"].ToString());
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "TDS");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=TDS_Report.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        grd1.DataSource = null;
        grd1.DataBind();
    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        string datefromstr = string.Empty;
        string datetostr = string.Empty;
        
       
        
            Bindgrid(datefromstr, datetostr);
        
    }
}