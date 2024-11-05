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
using System.Web.UI.WebControls;

public partial class Manufacturer_manualPayout_cashTransfer : System.Web.UI.Page
{
    private static readonly Regex mobileNumberRegex = new Regex(@"^[789]\d{9}$");
    //private static readonly Regex upiIdRegex = new Regex(@"^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("~/Login.aspx?Page=manualPayout_cashTransfer.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("~/adminLogin.aspx");
        }
        if (!IsPostBack)
        {
            string MobileNo = "All";

            string fromdate = string.Empty, todate = string.Empty;
            // string fromdate = System.DateTime.Now.ToString("yyyy-MM-dd") + " 00:00:00.000";
            //string todate = System.DateTime.Now.ToString("yyyy-MM-dd") + " 23:59:00.000";

            //txtDateFrom.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
            //txtDateto.Text = System.DateTime.Now.ToString("yyyy-MM-dd");         

            Bindgrid(fromdate, todate, MobileNo);
        }
    }
    public static bool IsMobileNumber(string input)
    {
        input = input.Substring(input.Length - 10, 10).ToString();
        return mobileNumberRegex.IsMatch(input);
    }

    //public static bool IsUpiId(string input)
    //{
    //    return upiIdRegex.IsMatch(input);
    //}
    public void Bindgrid(string datefrom, string dateto, string MobileNo)
    {
        try
        {
           
               

            

                //SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                //con.Open();
                //SqlCommand cmd = new SqlCommand("USP_GetConsumersWallet_Basex", con);
                //cmd.CommandType = CommandType.StoredProcedure;
                //cmd.Parameters.AddWithValue("@companyid", Session["CompanyId"].ToString());
                //cmd.Parameters.AddWithValue("@fromdate", datefrom);
                //cmd.Parameters.AddWithValue("@todate", dateto);
                //cmd.Parameters.AddWithValue("@mobileno", MobileNo);
                //cmd.Parameters.AddWithValue("@status", stt);
                //cmd.Parameters.AddWithValue("@upiid", upiid);
                //SqlDataAdapter da = new SqlDataAdapter(cmd);
                //DataTable dt = SQL_DB.ExecuteDataTable("exec ");
                DataTable dt = SQL_DB.ExecuteDataTable("exec USP_manualPayout_cashtransferReport'" + Session["CompanyId"].ToString() + "', '" + datefrom + "', '" + dateto + "', '" + MobileNo + "'");

            //da.Fill(dt);
            //con.Close();
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
        string datefrom = string.Empty;
        string dateto = string.Empty;

        string stt = string.Empty;

        string MobileNo = "All";

        if (txtDateFrom.Text != "" && txtDateFrom.Text != "From Date")
        {
            datefrom = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
        }

        if (txtDateto.Text != "" && txtDateto.Text != "To Date")
        {
            dateto = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
        }
        if (Mobile.Text != "")
        {

            if (IsMobileNumber(Mobile.Text.Trim()))
            {
                MobileNo = Mobile.Text.Trim();
                MobileNo = MobileNo.Substring(MobileNo.Length - 10, 10).ToString();
                if (MobileNo.Length != 10)
                {
                    LblMsg.Text = "Invalid mobile number!";
                }

            }


        }

 


        if (Page.IsValid)
        {
            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                //SqlCommand cmd = new SqlCommand("USP_manualPayout_cashtransferReport", con);
                //cmd.CommandType = CommandType.StoredProcedure;
                //cmd.Parameters.AddWithValue("@companyid", Session["CompanyId"].ToString());
                //cmd.Parameters.AddWithValue("@StartDate", fromdate);
                //cmd.Parameters.AddWithValue("@EndDate", todate);
                //cmd.Parameters.AddWithValue("@mobileno", MobileNo);

                //SqlDataAdapter da = new SqlDataAdapter(cmd);
                //DataTable dt = new DataTable();
                //da.Fill(dt);
                //con.Close();
                DataTable dt = SQL_DB.ExecuteDataTable("exec USP_manualPayout_cashtransferReport'" + Session["CompanyId"].ToString() + "', '" + datefrom + "', '" + dateto + "', '" + MobileNo + "'");

                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "PayoutcashtransferReport");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=PayoutcashtransferReport.xlsx");
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

        //DateTime? datefromstr = null;
        //string From = string.Empty, To = string.Empty;
        //if (!string.IsNullOrEmpty(txtDateFrom.Text))
        //{
        //    From = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd HH:mm:ss");
        //}

        string stt = string.Empty;
        string fromdate = string.Empty;
        string todate = string.Empty;
        string MobileNo = "All";
        string upiid = "All";
        if (txtDateFrom.Text != "" && txtDateFrom.Text != "From Date")
        {
            fromdate = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
        }


        if (txtDateto.Text != "" && txtDateto.Text != "To Date")
        {
            todate = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
        }


        if (Mobile.Text != "")
        {

            if (IsMobileNumber(Mobile.Text.Trim()))
            {
                MobileNo = Mobile.Text.Trim();
                MobileNo = MobileNo.Substring(MobileNo.Length - 10, 10).ToString();
                if (MobileNo.Length != 10)
                {
                    LblMsg.Text = "Invalid mobile number!";
                }

            }
            //else if (IsUpiId(Mobile.Text.Trim()))
            //{
            //    upiid = Mobile.Text.Trim();
            //}
            //else
            //{
            //    LblMsg.Text = "The string is neither a valid mobile number nor a UPI ID.!";
            //}

        }

        //else if (ddlst.Text != "")
        //{
        //    stt = ddlst.Text;
        //}

        //if (ddlst.Text == "Select Status")
        //{
        //    stt = "All";
        //}



        Bindgrid(fromdate, todate, MobileNo);

    }
}