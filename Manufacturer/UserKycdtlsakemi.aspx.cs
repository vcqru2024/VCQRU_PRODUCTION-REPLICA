using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using ClosedXML.Excel;
using System.IO;

public partial class Manufacturer_UserKycdtlsakemi : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["CompanyId"] = "Comp-1297";
        if (Session["User_Type"] == null)
            Response.Redirect("~/Login.aspx?Page=FrmUploadDealerCode.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("~/adminLogin.aspx");
        }
        if (!IsPostBack)
        {
            getkycdetails();
        }
    }


    public void getkycdetails()
    {

        string mob = txtmobile.Text;
        if (mob.Length == 10)
        {
            mob = "91" + mob;
        }

       
        lblMsg1.Text = "";
        string datefromstr = string.Empty;
        string datetostr = string.Empty;
        if (txtDateFrom.Text != "")
            datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
        if (txtDateto.Text != "")
            datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
        try
        {
            SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter();
            if (mob != "" && datefromstr == "" && datetostr == "")
            {
                SqlCommand cmd = new SqlCommand("select m.ConsumerName,m.MobileNo,m.City,m.PinCode,m.state,m.Entry_Date from M_Consumer m left join Pro_Enq pe on m.mobileno=pe.mobileno     where comp_id='" + Session["CompanyId"].ToString() + "' coalesce(VRKbl_KYC_status,0)=0 and pe.MobileNo is null  and m.MobileNo='" + mob + "'", con);
                da = new SqlDataAdapter(cmd);
            }
            else if (mob != "" && datefromstr != "" && datetostr != "")
            {
                string qry = "select m.ConsumerName,m.MobileNo,m.City,m.PinCode,m.state,m.Entry_Date from M_Consumer m left join Pro_Enq pe on m.mobileno=pe.mobileno    where comp_id='" + Session["CompanyId"].ToString() + "' coalesce(VRKbl_KYC_status,0)=0 and pe.MobileNo is null  and Entry_Date>='" + datefromstr + "'and Entry_Date<='" + datetostr + "'  and m.MobileNo='" + mob + "'";
                SqlCommand cmd = new SqlCommand(qry, con);
                da = new SqlDataAdapter(cmd);
            }
            else
            {
                SqlCommand cmd = new SqlCommand("sp_getnonkycuser", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Start_Date", datefromstr);
                cmd.Parameters.AddWithValue("@End_Date", datetostr);
                cmd.Parameters.AddWithValue("@compId", Session["CompanyId"].ToString());
                da = new SqlDataAdapter(cmd);
            }


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

    public void getkycdetailsdownload()
    {
        DataTable dt = SQL_DB.ExecuteDataTable("select m.ConsumerName,m.MobileNo,m.City,m.PinCode,m.state,m.Entry_Date from M_Consumer m left join Pro_Enq pe on m.mobileno=pe.mobileno    where comp_id='" + Session["CompanyId"].ToString() + "' coalesce(VRKbl_KYC_status,0)=0 and pe.MobileNo is null ");
        if (dt.Rows.Count > 0)
        {
            grd1.DataSource = dt;
            grd1.DataBind();
            string date = Convert.ToString(DateTime.Now);
            XLWorkbook wb = new XLWorkbook();
            wb.Worksheets.Add(dt, "User_details");
            MemoryStream stream = new MemoryStream();
            wb.SaveAs(stream);
            Response.Clear();
            Response.ContentType = "application/force-download";
            Response.AddHeader("content-disposition", "attachment;    filename=NONKYC" + date + ".xlsx");
            Response.BinaryWrite(stream.ToArray());
            Response.End();


        }


       

    }

    protected void btn_download_Click(object sender, EventArgs e)
    {



        if (txtDateFrom.Text != "" && txtDateto.Text != "")
        {
            string datefromstr = string.Empty;
            string datetostr = string.Empty;
            if (txtDateFrom.Text != "")
                datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
            if (txtDateto.Text != "")
                datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_getnonkycuser", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Start_Date", datefromstr);
                cmd.Parameters.AddWithValue("@End_Date", datetostr);
                cmd.Parameters.AddWithValue("@compId", Session["CompanyId"].ToString());
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "NONKYC");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=NONKYCUSER.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        else
        {
            getkycdetailsdownload();
        }

    }

    protected void imgsearch_Click(object sender, ImageClickEventArgs e)
    {
        getkycdetails();
    }

    protected void imgreset_Click(object sender, ImageClickEventArgs e)
    {
        txtDateFrom.Text = "";
        txtDateto.Text = "";
        txtmobile.Text = "";
        grd1.DataSource = "";
        grd1.DataBind();
    }
}