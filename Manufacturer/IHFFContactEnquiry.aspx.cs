using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using ClosedXML.Excel;
using System;

public partial class Manufacturer_IHFFContactEnquiry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("~/Login.aspx?Page=IHFFContactEnquiry.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("~/adminLogin.aspx");
        }
        //txtDateFrom.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
        //txtDateto.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
        if (!IsPostBack)
        {
            string datefrom = System.DateTime.Now.ToString("yyyy-MM-dd" + " " + "00:00:01.999"); 
            string dateto = System.DateTime.Now.ToString("yyyy-MM-dd" + " " + "23:59:59.999");
            if (!IsPostBack)
            {
                 txtDateFrom.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
                 txtDateto.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
                // Bindgrid();
            }
            Bindgrid(datefrom, dateto);
			
        }
    }
    public void Bindgrid(string datefrom, string dateto)
    {
        string datefromstr = string.Empty;
        string datetostr = string.Empty;
        if (txtDateFrom.Text != "")
            datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
        if (txtDateto.Text != "")
            datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");

txtDateFrom.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
                txtDateto.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("USP_GetEventFormData", con);
        cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.AddWithValue("@compId", Session["CompanyId"].ToString());
        cmd.Parameters.AddWithValue("@fromdate", datefromstr);
        cmd.Parameters.AddWithValue("@todate", datetostr);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
        grd1.DataSource = dt;
        grd1.DataBind();
		

    }
   
    

    protected void ImgSearch_Click1(object sender, System.Web.UI.ImageClickEventArgs e)
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

    protected void ImgRefresh_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        grd1.DataSource = null;
        grd1.DataBind();
    }
}