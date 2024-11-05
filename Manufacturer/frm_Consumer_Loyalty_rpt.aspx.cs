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

public partial class Manufacturer_frm_Consumer_Loyalty_rpt : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("~/Login.aspx?Page=FrmUploadDealerCode.aspx");
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
        string datefromstr = String.Empty;
        string datetostr = String.Empty;
        if (txtDateFrom.Text != "")
            datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
        if (txtDateto.Text != "")
            datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");


        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("sp_Consumer_point_dtls", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@mobile", txtSearch.Text);
        cmd.Parameters.AddWithValue("@datefrom", datefromstr);
        cmd.Parameters.AddWithValue("@dateto", datetostr);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
        grd1.DataSource = dt;
        grd1.DataBind();

    }
    protected void btn_download_Click(object sender, EventArgs e)
    {
        string datefromstr = String.Empty;
        string datetostr = String.Empty;

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
                SqlCommand cmd = new SqlCommand("sp_Consumer_point_dtls", con);
                cmd.CommandType = CommandType.StoredProcedure;
                //cmd.Parameters.AddWithValue("@Start_Date",(Convert.ToDateTime( txtDateFrom.Text ) ) );
                //cmd.Parameters.AddWithValue("@End_Date",(Convert.ToDateTime (txtDateto.Text ) ));
                cmd.Parameters.AddWithValue("@mobile", txtSearch.Text);
                cmd.Parameters.AddWithValue("@datefrom", datefromstr);
                cmd.Parameters.AddWithValue("@dateto", datetostr);
                //cmd.Parameters.AddWithValue("@Start_Date", datefromstr);
                //cmd.Parameters.AddWithValue("@End_Date", datetostr);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "Loyalty_Points");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=Loyalty_Points.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

    protected void grd1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grd1.PageIndex = e.NewPageIndex;
        Bindgrid();

    }

    protected void btnsrch_ServerClick(object sender, EventArgs e)
    {
        Bindgrid();
        txtSearch.Text = "";
    }

    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        Bindgrid();
       
     
    }

    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        Bindgrid();
        txtSearch.Text = "";
        txtDateFrom.Text = "";
        txtDateto.Text = "";
      

    }
}