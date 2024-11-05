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

public partial class Manufacturer_ReportofWellverse : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["CompanyId"] = "Comp-1599";
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
                SqlCommand cmd = new SqlCommand("select mc.ConsumerName, fr.Mobileno,Purchasedfrom,Dateofreport,Imgpath  from tbl_Wellverse_Fake_RPT fr left join M_Consumer mc on mc.MobileNo=fr.Mobileno where fr.Comp_id='" + Session["CompanyId"].ToString() + "' and fr.Mobileno='" + mob + "'  order by fr.Id desc", con);
                da = new SqlDataAdapter(cmd);
            }
            else if (mob != "" && datefromstr != "" && datetostr != "")
            {
                string qry = "select mc.ConsumerName, fr.Mobileno,Purchasedfrom,Dateofreport,Imgpath  from tbl_Wellverse_Fake_RPT fr left join M_Consumer mc on mc.MobileNo=fr.Mobileno where fr.Comp_id='" + Session["CompanyId"].ToString() + "' and  fr.Dateofreport>='" + datefromstr + "'and fr.Dateofreport<='" + datetostr + "' and fr.Mobileno='" + mob + "'  order by fr.Id desc";
               // string qry = "select Mobile_no,User_Name,Email,PinCode,City,State,Retailer_name,case  when book_name= 'Book1' then 'Black book of English Vocabulary.'when book_name= 'Book2' then 'Black book of Samanya Jagrukta.'when book_name= 'Book3' then 'Black book of General Awareness.'end as Book_name,Rating,Feedback,Enq_date from tbl_blackbookuserdetails where  enq_date>='" + datefromstr + "'and enq_date<='" + datetostr + "' and Mobile_no='" + mob + "'";
                SqlCommand cmd = new SqlCommand(qry, con);
                da = new SqlDataAdapter(cmd);
            }

            else if (mob == "" && datefromstr != "" && datetostr != "")
            {
                string qry = "select mc.ConsumerName, fr.Mobileno,Purchasedfrom,Dateofreport,Imgpath  from tbl_Wellverse_Fake_RPT fr left join M_Consumer mc on mc.MobileNo=fr.Mobileno where fr.Comp_id='" + Session["CompanyId"].ToString() + "' and  fr.Dateofreport>='" + datefromstr + "'and fr.Dateofreport<='" + datetostr + "'  order by fr.Id desc";
                // string qry = "select Mobile_no,User_Name,Email,PinCode,City,State,Retailer_name,case  when book_name= 'Book1' then 'Black book of English Vocabulary.'when book_name= 'Book2' then 'Black book of Samanya Jagrukta.'when book_name= 'Book3' then 'Black book of General Awareness.'end as Book_name,Rating,Feedback,Enq_date from tbl_blackbookuserdetails where  enq_date>='" + datefromstr + "'and enq_date<='" + datetostr + "' and Mobile_no='" + mob + "'";
                SqlCommand cmd = new SqlCommand(qry, con);
                da = new SqlDataAdapter(cmd);
            }

            else
            {
                string qry = "select mc.ConsumerName, fr.Mobileno,Purchasedfrom,Dateofreport,Imgpath  from tbl_Wellverse_Fake_RPT fr left join M_Consumer mc on mc.MobileNo=fr.Mobileno where fr.Comp_id='" + Session["CompanyId"].ToString() + "'  order by fr.Id desc";
                SqlCommand cmd = new SqlCommand(qry, con);
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
        DataTable dt = SQL_DB.ExecuteDataTable("select mc.ConsumerName, fr.Mobileno,Purchasedfrom,Dateofreport,Imgpath  from tbl_Wellverse_Fake_RPT fr left join M_Consumer mc on mc.MobileNo=fr.Mobileno where fr.Comp_id='" + Session["CompanyId"].ToString() + "'  order by fr.Id desc");
        if (dt.Rows.Count > 0)
        {
            grd1.DataSource = dt;
            grd1.DataBind();
            string date = Convert.ToString(DateTime.Now);
            XLWorkbook wb = new XLWorkbook();
            wb.Worksheets.Add(dt, "Reported Data");
            MemoryStream stream = new MemoryStream();
            wb.SaveAs(stream);
            Response.Clear();
            Response.ContentType = "application/force-download";
            Response.AddHeader("content-disposition", "attachment;    filename=Reported_Data" + date + ".xlsx");
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
                string date = Convert.ToString(DateTime.Now);
                DataTable dt = SQL_DB.ExecuteDataTable("select mc.ConsumerName, fr.Mobileno,Purchasedfrom,Dateofreport,Imgpath  from tbl_Wellverse_Fake_RPT fr left join M_Consumer mc on mc.MobileNo=fr.Mobileno where  fr.Dateofreport>='" + datefromstr + "'and fr.Dateofreport<='" + datetostr + "' order by fr.Id desc");
                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "Reported Data");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=Reported_Data" + date + ".xlsx");
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
        Bindgrid();
    }

    protected void imgreset_Click(object sender, ImageClickEventArgs e)
    {
        txtDateFrom.Text = "";
        txtDateto.Text = "";
        txtmobile.Text = "";
        grd1.DataSource = "";
        grd1.DataBind();
    }
    protected void grd1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grd1.PageIndex = e.NewPageIndex;
        Bindgrid();
    }
}