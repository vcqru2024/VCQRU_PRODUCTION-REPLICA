using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using ClosedXML.Excel;
using System.IO;

public partial class Manufacturer_frm_Cashrpt : System.Web.UI.Page
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
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("ConsumerWalletBalance", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Comp_id", Session["CompanyId"].ToString());
        cmd.Parameters.AddWithValue("@distributorid", "");
        cmd.Parameters.AddWithValue("@mobile", txtMobile.Text);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
        grd1.DataSource = dt;
        grd1.DataBind();

    }

    protected void btn_download_Click(object sender, EventArgs e)
    {

        try
        {
            SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("ConsumerWalletBalance", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Comp_id", Session["CompanyId"].ToString());
            cmd.Parameters.AddWithValue("@distributorid", "");
            cmd.Parameters.AddWithValue("@mobile", txtMobile.Text);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            XLWorkbook wb = new XLWorkbook();
            wb.Worksheets.Add(dt, "User_Wise_Cash_details");
            MemoryStream stream = new MemoryStream();
            wb.SaveAs(stream);
            Response.Clear();
            Response.ContentType = "application/force-download";
            Response.AddHeader("content-disposition", "attachment;    filename=User_Wise_Cash_details.xlsx");
            Response.BinaryWrite(stream.ToArray());
            Response.End();
        }
        catch (Exception ex)
        {
            throw ex;
        }


        /*

        string datefromstr = string.Empty;
        string datetostr = string.Empty;
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
                SqlCommand cmd = new SqlCommand("sp_getConsumerdetailsexecl", con);
                cmd.CommandType = CommandType.StoredProcedure;
                //cmd.Parameters.AddWithValue("@Start_Date",(Convert.ToDateTime( txtDateFrom.Text ) ) );
                //cmd.Parameters.AddWithValue("@End_Date",(Convert.ToDateTime (txtDateto.Text ) ));
                cmd.Parameters.AddWithValue("@Start_Date", datefromstr);
                cmd.Parameters.AddWithValue("@End_Date", datetostr);

                cmd.Parameters.AddWithValue("@compId", Session["CompanyId"].ToString());
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
        }
        */
    }

    public static bool isDigits(string s)
    {
        if (s == null || s == "") return false;

        for (int i = 0; i < s.Length; i++)
            if ((s[i] ^ '0') > 9)
                return false;

        return true;
    }

    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        
        if (txtMobile.Text.Length < 10)
        {
            lblMsg1.Text = "Enter Valid Mobile No";
            return;
        }
        else if (txtMobile.Text.Length > 12)
        {
            lblMsg1.Text = "Enter Valid Mobile No";
            return;
        }
        else if (!isDigits(txtMobile.Text))
        {
            lblMsg1.Text = "Please Enter Valid Mobile No";
            return;
        }
        else
        {
            lblMsg1.Text = "";
            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("ConsumerWalletBalance", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Comp_id", Session["CompanyId"].ToString());
                cmd.Parameters.AddWithValue("@distributorid", "");
                cmd.Parameters.AddWithValue("@mobile", txtMobile.Text);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();

            }
            catch (Exception ex)
            {
                throw ex;
            }

        }


        Bindgrid();
    }

    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        lblMsg1.Text = "";
        txtMobile.Text = "";
        Bindgrid();
    }
}