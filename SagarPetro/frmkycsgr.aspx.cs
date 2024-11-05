using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ClosedXML.Excel;
using System.IO;

public partial class SagarPetro_frmkycsgr : System.Web.UI.Page
{
    cls_message db = new cls_message();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Session["CompanyId"] == null)
            Response.Redirect("../Sagarpetro/Loginpfl.aspx?Page=frm_KYC");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            txtDateFrom.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtDateto.Text = DateTime.Now.ToString("yyyy-MM-dd");
            DateTime dateFrom = Convert.ToDateTime(txtDateFrom.Text);
            DateTime dateTo = Convert.ToDateTime(txtDateto.Text);

           string dateFromStr = dateFrom.ToString("yyyy-MM-dd 00:00:00.001");
            string dateToStr = dateTo.ToString("yyyy-MM-dd 23:59:59.999");
            DataTable dt = SQL_DB.ExecuteDataTable("USP_GetKycdetailsbycomp_SP '" + Session["CompanyId"].ToString() + "','" + dateFromStr + "','" + dateToStr + "'");

            if (dt.Rows.Count > 0)
            {
                grd1.DataSource = dt;
                grd1.DataBind();
            }
            else
            {
                grd1.DataSource = null;
                grd1.DataBind();
            }
        }
    }

    protected void ViewReport(object sender, EventArgs e)
    {

    }
    protected void btn_download_Click(object sender, EventArgs e)
    {
        try
        {

            string datefromstr = string.Empty;
            string datetostr = string.Empty;
            if (txtDateFrom.Text != "")
            {
                datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
            }
            if (txtDateto.Text != "")
            {
                datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
            }

            DataTable dt = SQL_DB.ExecuteDataTable("USP_GetKycdetailsbycomp_SP '" + Session["CompanyId"].ToString() + "','" + datefromstr + "','" + datetostr + "'");
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
    protected void ImgSearch_Click(object sender, EventArgs e)
    {
        string dateFromStr = string.Empty;
        string dateToStr = string.Empty;
    
        bool isDateFromValid = !string.IsNullOrEmpty(txtDateFrom.Text);
        bool isDateToValid = !string.IsNullOrEmpty(txtDateto.Text);
        if ((isDateFromValid && isDateToValid))
        {
            if (!isDateFromValid && !isDateToValid)
            {
                dateFromStr = string.Empty;
                dateToStr = string.Empty;
            }
            else if (isDateFromValid && isDateToValid)
            {
                DateTime dateFrom = Convert.ToDateTime(txtDateFrom.Text);
                DateTime dateTo = Convert.ToDateTime(txtDateto.Text);

                dateFromStr = dateFrom.ToString("yyyy-MM-dd 00:00:00.001");
                dateToStr = dateTo.ToString("yyyy-MM-dd 23:59:59.999");
            }

            try
            {
                DataTable dt = SQL_DB.ExecuteDataTable("USP_GetKycdetailsbycomp_SP '" + Session["CompanyId"].ToString() + "','" + dateFromStr + "','" + dateToStr + "'");
                     
                if (dt.Rows.Count > 0)
                {
                    grd1.DataSource = dt;
                    grd1.DataBind();
                }
                else
                {
                    grd1.DataSource = null;
                    grd1.DataBind();
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        else
        {
            db.ShowErrorMessage(this, "Please enter either a valid date range or a valid mobile number.");
        }
    }

    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("frmkycsgr.aspx");
    }
}