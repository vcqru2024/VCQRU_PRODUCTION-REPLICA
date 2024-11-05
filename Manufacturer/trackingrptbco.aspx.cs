using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_trackingrptbco : System.Web.UI.Page
{
    cls_message msg = new cls_message();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["CompanyId"] == null)
            Response.Redirect("../Login.aspx?Page=trackingrptbco.aspx");
        if (!IsPostBack)
        {
            string datefromstr = string.Empty;
            string datetostr = string.Empty;
            datetostr = DateTime.Now.ToString("yyyy-MM-dd" + " " + "23:59:59.999");
            datefromstr = DateTime.Now.ToString("yyyy-MM-dd" + " " + "00:00:00.001");
            DataTable dt = SQL_DB.ExecuteDataTable(" exec USP_Yamunatrackingrpt '" + Session["CompanyId"].ToString() + "', '" + datefromstr + "','" + datetostr + "'");
            if (dt.Rows.Count > 0)
            {
                grd1.DataSource = dt;
                grd1.DataBind();
            }
        }
    }


    protected void btn_download_Click(object sender, EventArgs e)
    {
        try
        {
            string datefromstr = string.Empty;
            string datetostr = string.Empty;
            if (!string.IsNullOrEmpty(txtDateFrom.Text))
            {
                datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:00.001");
            }
            if (!string.IsNullOrEmpty(txtDateto.Text))
            {
                datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
            }
            DataTable dt = new DataTable();
            if(string.IsNullOrEmpty(txtDateFrom.Text) && string.IsNullOrEmpty(txtDateto.Text))
            {
                 dt = SQL_DB.ExecuteDataTable(" exec USP_Yamunatrackingrpt '"+ Session["CompanyId"].ToString() + "'");
            }
            else
            {
                 dt = SQL_DB.ExecuteDataTable(" exec USP_Yamunatrackingrpt '" + Session["CompanyId"].ToString() + "', '" + datefromstr + "','" + datetostr + "'");
            }
            
            if (dt.Rows.Count > 0)
            {
                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "Tracking Report");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=Tracking_Report.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();
            }
            else
            {
                msg.ShowErrorMessage(this, "Data not found.");
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void ImgSearch_Click(object sender, EventArgs e)
    {
        string datefromstr = string.Empty;
        string datetostr = string.Empty;
        if (string.IsNullOrEmpty(txtDateFrom.Text) && string.IsNullOrEmpty(txtDateto.Text))
        {
            msg.ShowErrorMessage(this, "Please Select Date Range.");
            return;
        }
        if (string.IsNullOrEmpty(txtDateFrom.Text) || string.IsNullOrEmpty(txtDateto.Text))
        {
            msg.ShowErrorMessage(this, "Please Select Date Range.");
            return;
        }
        datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
        datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");

        DataTable dt = SQL_DB.ExecuteDataTable(" exec USP_Yamunatrackingrpt '"+Session["CompanyId"].ToString() +"','" + datefromstr + "','" + datetostr + "'");
        if (dt.Rows.Count > 0)
        {
            grd1.DataSource = dt;
            grd1.DataBind();
        }
    }



    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("trackingrptbco.aspx");
    }
}