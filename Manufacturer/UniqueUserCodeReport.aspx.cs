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
public partial class Manufacturer_UniqueUserCodeReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("~/Login.aspx?Page=UniqueUserCodeReport.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("~/adminLogin.aspx");
        }
        if (!IsPostBack)
        {
            //string compid = Session["Comp_ID"].ToString();
            txtDateFrom.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
            txtDateto.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
            string fromdate = System.DateTime.Now.ToString("yyyy-MM-dd") + " 00:00:00.000";
            string todate = System.DateTime.Now.ToString("yyyy-MM-dd") + " 23:59:00.000";

            Bindgrid(fromdate, todate);
        }
    }
    public void Bindgrid(string datefrom, string dateto)
    {
        try { 
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("USP_GetUniqueUserCodeReport_HPL", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@companyid", Session["CompanyId"].ToString());
        cmd.Parameters.AddWithValue("@fromdate", datefrom);
        cmd.Parameters.AddWithValue("@todate", dateto);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
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

        string fromdate = System.DateTime.Now.ToString("yyyy-MM-dd") + " 00:00:00.000";
        string todate = System.DateTime.Now.ToString("yyyy-MM-dd") + " 23:59:00.000";
        string datefromstr = fromdate;
        string datetostr = todate;
        if (txtDateFrom.Text != "")
            datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
        if (txtDateto.Text != "")
            datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
        if (Page.IsValid)
        {
            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("USP_GetUniqueUserCodeReport_HPL", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@companyid", Session["CompanyId"].ToString());
                cmd.Parameters.AddWithValue("@fromdate", datefromstr);
                cmd.Parameters.AddWithValue("@todate", datetostr);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "UniqueUserCodeReport");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=UniqueUserCodeReport.xlsx");
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
        if (txtDateFrom.Text != "")
            datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
        if (txtDateto.Text != "")
            datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
        if (datefromstr == "" && datetostr == "")
        {
            LblMsg.Text = "Please Select Date";
        }
        else
        {
            Bindgrid(datefromstr, datetostr);
        }
    }
}