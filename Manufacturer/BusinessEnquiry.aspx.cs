using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_BusinessEnquiry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("~/Login.aspx?Page=FrmUploadDealerCode");
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
        #region Commented Code
        //SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        //con.Open();
        //SqlCommand cmd = new SqlCommand("sp_getConsumerdetails", con);
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.AddWithValue("@compId", Session["CompanyId"].ToString());
        //SqlDataAdapter da = new SqlDataAdapter(cmd);
        //DataTable dt = new DataTable();
        //da.Fill(dt);
        //con.Close();
        #endregion
        DataTable dt = SQL_DB.ExecuteDataTable("exec GetUserEnquiryByCompId '" + Session["CompanyId"].ToString() + "'");
        grd1.DataSource = dt;
        grd1.DataBind();
    }
    protected void btn_download_Click(object sender, EventArgs e)
    {
       
    }

    protected void btn_download_Click1(object sender, EventArgs e)
    {
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
                #region Commented Code
                //SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                //con.Open();
                //SqlCommand cmd = new SqlCommand("sp_getConsumerdetailsexecl", con);
                //cmd.CommandType = CommandType.StoredProcedure;
                ////cmd.Parameters.AddWithValue("@Start_Date",(Convert.ToDateTime( txtDateFrom.Text ) ) );
                ////cmd.Parameters.AddWithValue("@End_Date",(Convert.ToDateTime (txtDateto.Text ) ));

                //cmd.Parameters.AddWithValue("@compId", Session["CompanyId"].ToString());
                //cmd.Parameters.AddWithValue("@Start_Date", datefromstr);
                //cmd.Parameters.AddWithValue("@End_Date",  datetostr);


                //SqlDataAdapter da = new SqlDataAdapter(cmd);
                //DataTable dt = new DataTable();
                //da.Fill(dt);
                //con.Close();
                #endregion
                DataTable dt = SQL_DB.ExecuteDataTable("exec GetUserEnquiryByCompIdAndDateRange '" + Session["CompanyId"].ToString() + "','" + datefromstr + "','" + datetostr + "'");
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
    }
}