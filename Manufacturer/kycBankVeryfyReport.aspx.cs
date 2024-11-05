using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using ClosedXML.Excel;


public partial class Manufacturer_kycBankVeryfyReport : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {


        }
    }

    protected void btn_download_Click_drpdown(object sender, EventArgs e)
    {

        if (Page.IsValid)
        {
            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                string qrystr = "select a.M_Consumerid,a.MobileNo,ConsumerName,AccountNo as AccountNo,AccountHolderName,case when IsBankAccountVerify='true' then 'Success' else 'Failure' end IsBankAccountVerify,IFSC_Code,BankReqdate,BankRemarks,created_at from M_Consumer a,tblKycBankDataDetails b  where a.M_Consumerid=b.M_Consumerid  order by b.Id desc  ";
                SqlCommand cmd = new SqlCommand(qrystr, con);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();

                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "User_KycBankReport");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=User_Bankdetails.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }



    protected void ViewReport(object sender, EventArgs e)
    {

    }
    protected void btn_download_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {

            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();

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


                if (txtDateFrom.Text != "" && txtDateto.Text != "")
                {
                    qrystr = "select a.M_Consumerid,a.MobileNo,ConsumerName,AccountNo as AccountNo,AccountHolderName,case when IsBankAccountVerify='true' then 'Success' else 'Failure' end IsBankAccountVerify,IFSC_Code,BankReqdate,BankRemarks,created_at from M_Consumer a,tblKycBankDataDetails b  where a.M_Consumerid=b.M_Consumerid and b.created_at >= '" + datefromstr + "' and b.created_at <= '" + datetostr + "' order by b.Id desc  ";
                }

                SqlCommand cmd = new SqlCommand(qrystr, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();

                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "User_KycBankReport");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment; filename=User_Bankdetails.xlsx");
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
        string qrystr = "";
        if (txtDateFrom.Text != "")
        {
            datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
        }
        if (txtDateto.Text != "")
        {
            datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
        }


        if (txtDateFrom.Text == "" && txtDateto.Text == "")
        {
            Response.Redirect("kycBankVeryfyReport.aspx");
        }


        if (txtDateFrom.Text != "" && txtDateto.Text != "")
        {
            qrystr = "select a.M_Consumerid,a.MobileNo,ConsumerName,AccountNo as AccountNo,AccountHolderName,case when IsBankAccountVerify='true' then 'Success' else 'Failure' end IsBankAccountVerify,IFSC_Code,BankReqdate,BankRemarks,created_at from M_Consumer a,tblKycBankDataDetails b  where a.M_Consumerid=b.M_Consumerid and b.created_at >= '" + datefromstr + "' and b.created_at <= '" + datetostr + "' order by b.Id desc  ";
        }


        if (Page.IsValid)
        {
            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                //DataTable newdt = SQL_DB.ExecuteDataTable("select ref_cin_number from M_Consumer where M_Consumerid='10745'");
                ///string ssss = qrystr
                SqlCommand cmd = new SqlCommand(qrystr, con);
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

    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("kycBankVeryfyReport.aspx");
    }



    protected void grd1_PageIndexChanged(object sender, EventArgs e)
    {

    }
}