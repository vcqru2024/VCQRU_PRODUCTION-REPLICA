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

public partial class Manufacturer_frm_KYC : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"].ToString() == "Comp-1592")
        {
            userType.Visible = true;
        }
        
            
        if (Session["CompanyId"] == null)
            Response.Redirect("../Info/Login.aspx?Page=frm_KYC.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            bindrole2();
            userType.Items.Insert(0, new ListItem("Select user type", "0"));
            userType.Enabled = true;

        }
    }

   



    protected void ViewReport(object sender, EventArgs e)
    {

    }
    protected void btn_download_Click(object sender, EventArgs e)
    {
        if (Session["CompanyId"].ToString() == "Comp-1615")
        {
            if (Page.IsValid)
            {


                try
                {
                    string datefromstr = string.Empty;
                    string datetostr = string.Empty;
                    string userType1 = "1";
                    string qrystr = "";
                   
                    if (txtDateFrom.Text != "")
                    {
                        datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
                    }
                    if (txtDateto.Text != "")
                    {
                        datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
                    }
                    if (userType.SelectedValue != "0")
                    {
                        userType1 = userType.SelectedValue;
                    }

                    


                    SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                    con.Open();
                    SqlCommand cmd = new SqlCommand("sp_GetKycdetailsbycompHafila", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Start_Date", datefromstr);
                    cmd.Parameters.AddWithValue("@End_Date", datetostr);
                    cmd.Parameters.AddWithValue("@Compid", Session["CompanyId"].ToString());
                    cmd.Parameters.AddWithValue("@Role", userType.SelectedValue);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    con.Close();

                    XLWorkbook wb = new XLWorkbook();
                    wb.Worksheets.Add(dt, "KYC_details");
                    MemoryStream stream = new MemoryStream();
                    wb.SaveAs(stream);
                    Response.Clear();
                    Response.ContentType = "application/force-download";
                    Response.AddHeader("content-disposition", "attachment;    filename=KYC_details" + DateTime.Now + ".xlsx");
                    Response.BinaryWrite(stream.ToArray());
                    Response.End();

                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
           
        }
        else
        {
            try
            {
                string datefromstr = string.Empty;
                string datetostr = string.Empty;

                string qrystr = "";

                if (txtDateFrom.Text != "")
                {
                    datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
                }
                if (txtDateto.Text != "")
                {
                    datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
                }

                qrystr = "sp_DownloadKycdetailsbycomp";


                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand(qrystr, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Start_Date", datefromstr);
                cmd.Parameters.AddWithValue("@End_Date", datetostr);
                cmd.Parameters.AddWithValue("@Compid", Session["CompanyId"].ToString());
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();

                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "KYC_details");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=KYC_details.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }

    protected void ImgSearch_Click(object sender, EventArgs e)
    {
        string datefromstr = string.Empty;
        string datetostr = string.Empty;
        string userType1 = "1";
        string qrystr = "";

        if (Session["CompanyId"].ToString() == "Comp-1615")
        {
            if (txtDateFrom.Text != "")
            {
                datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
            }
            if (txtDateto.Text != "")
            {
                datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
            }
            if (userType.SelectedValue != "0")
            {
                userType1 = userType.SelectedValue;
            }
            if (userType.SelectedValue == "0" && txtDateFrom.Text == "" && txtDateto.Text == "")
            {
                Response.Redirect("frm_KYC.aspx");
            }


            
            if (Page.IsValid)
            {
                try
                {
                    SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                    con.Open();
                   
                    SqlCommand cmd = new SqlCommand("sp_GetKycdetailsbycompHafila", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Start_Date", datefromstr);
                    cmd.Parameters.AddWithValue("@End_Date", datetostr);
                    cmd.Parameters.AddWithValue("@Compid", Session["CompanyId"].ToString());
                    cmd.Parameters.AddWithValue("@Role", userType.SelectedValue);
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
        }
        else
        {
            string Mobileno = txtmobile.Text.Trim();
            if (Mobileno.Length == 10)
                Mobileno = "91" + Mobileno;
            if (txtDateFrom.Text == "" && txtDateto.Text == "" && Mobileno != "")
            {
                if (Mobileno.Length < 10)
                {
                    lblMsg1.Text = "Please Enter Valid Mobile Number";
                    lblMsg1.ForeColor = System.Drawing.Color.Red;
                    return;
                }
                qrystr = "sp_GetKycdetailsbycomp";
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand(qrystr, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Start_Date", datefromstr);
                cmd.Parameters.AddWithValue("@End_Date", datetostr);
                cmd.Parameters.AddWithValue("@MobileNo", Mobileno);
                cmd.Parameters.AddWithValue("@Compid", Session["CompanyId"].ToString());
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                grd1.DataSource = dt;
                grd1.DataBind();
            }

            else if (txtDateFrom.Text != "" && txtDateto.Text != "" && txtmobile.Text == "")
            {
                datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
                datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
                qrystr = "sp_GetKycdetailsbycomp";
                try
                {
                    SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                    con.Open();
                    SqlCommand cmd = new SqlCommand(qrystr, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Start_Date", datefromstr);
                    cmd.Parameters.AddWithValue("@End_Date", datetostr);
                    cmd.Parameters.AddWithValue("@MobileNo", Mobileno);
                    cmd.Parameters.AddWithValue("@Compid", Session["CompanyId"].ToString());
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
            else if (txtDateFrom.Text != "" && txtDateto.Text != "" && txtmobile.Text != "")
            {
                datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
                datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
                qrystr = "sp_GetKycdetailsbycomp";
                try
                {
                    SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                    con.Open();
                    SqlCommand cmd = new SqlCommand(qrystr, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Start_Date", datefromstr);
                    cmd.Parameters.AddWithValue("@End_Date", datetostr);
                    cmd.Parameters.AddWithValue("@MobileNo", Mobileno);
                    cmd.Parameters.AddWithValue("@Compid", Session["CompanyId"].ToString());
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
            else
            {
                lblMsg1.Text = "Please Enter Input to Search Data";
                lblMsg1.ForeColor = System.Drawing.Color.Red;
                return;
            }

        }





    }



    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("frm_KYC.aspx");
    }
    public void bindrole2()
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("select*from tblUserTypeHafila", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
        userType.DataValueField = "Id";
        userType.DataTextField = "UserType";
        userType.DataSource = dt;
        userType.DataBind();
        

    }
  
   
}