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

public partial class Manufacturer_frm_RetailerDetails : System.Web.UI.Page
{
    string mobile = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["CompanyId"] = "Comp-1152";
        //if (Session["User_Type"] == null)
        //    Response.Redirect("~/Login.aspx?Page=frm_RetailerDetails.aspx");
        //else
        //{
        //    if (Session["User_Type"].ToString() == "Admin")
        //        Response.Redirect("~/adminLogin.aspx");
        //}
        //if (!IsPostBack)
        //{

        //}
    }
    public void Bindgrid()
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        string datefromstr = string.Empty;
        string datetostr = string.Empty;
       
        mobile = txtmobile.Text;
        if (txtDateFrom.Text != "")
            datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
        if (txtDateto.Text != "")
            datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");

        if (txtDateFrom.Text == "")
        {
            LblMsg.Text = "Please Select Date";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            return;

        }
        if (txtDateto.Text == "")
        {
            LblMsg.Text = "Please Select Date";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            return;

        }

        if (Page.IsValid)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("GetMahindraRetailerIDDetails", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@from_date", datefromstr);
                cmd.Parameters.AddWithValue("@to_date", datetostr);
                cmd.Parameters.AddWithValue("@compid", Session["CompanyId"].ToString());
                cmd.Parameters.AddWithValue("@mobileno", mobile);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                grd1.DataSource = dt;
                grd1.DataBind();
            }
            catch (Exception ex)
            {
                LblMsg.Text = "Invalid Request" + ex;
                LblMsg.ForeColor = System.Drawing.Color.Red;
            }
            finally
            {
                con.Close();
            }
        }
    }
    private void allClear()
    {
        txtDateFrom.Text = "";
        txtDateto.Text = "";
        txtmobile.Text = "";
        grd1.DataSource = null;
    }

    protected void grd1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        txtDateFrom.Text = "";
        txtDateto.Text = "";
        grd1.PageIndex = e.NewPageIndex;
        Bindgrid();
    }


    protected void btn_Search_Click(object sender, EventArgs e)
    {
        Bindgrid();
    }

    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        allClear();
    }

    protected void btnDownloadExcel_Click(object sender, EventArgs e)
    {
        ExportGridToExcel();
    }

    private void ExportGridToExcel()
    {

        string datefromstr = string.Empty;
        string datetostr = string.Empty;
        if (txtDateFrom.Text != "")
            datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
        if (txtDateto.Text != "")
            datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
        if (txtDateFrom.Text == "")
        {
            LblMsg.Text = "Please Select Date";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            return;
            
        }
        if (txtDateto.Text == "")
        {
            LblMsg.Text = "Please Select Date";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            return;

        }

        //if (Page.IsValid)
        //{
            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("GetMahindraRetailerIDDetails", con);
                cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@from_date", datefromstr);
            cmd.Parameters.AddWithValue("@to_date", datetostr);
            cmd.Parameters.AddWithValue("@compid", Session["CompanyId"].ToString());
            cmd.Parameters.AddWithValue("@mobileno", mobile);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "User_details");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=User_details.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();
            }
            catch (Exception ex)
            {
                throw ex;
            }
       // }

    }
}