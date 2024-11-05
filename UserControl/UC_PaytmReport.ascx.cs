﻿using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControl_UC_PaytmReport : System.Web.UI.UserControl
{
    public int str = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            lblcount.Text = "0";
            FillDateCurrent();
            newMsg.Visible = false;

        }
        Label2.Text = "";
    }

    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtDateFrom.Text = "";
        txtDateto.Text = "";
        newMsg.Visible = false;
        FillGrdPointsDetails();
    }

    private void FillDateCurrent()
    {
        txtDateFrom.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy").ToString();
        txtDateto.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy").ToString();
    }

    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdPointsDetails();
    }

    private void FillGrdPointsDetails()
    {
        DateTime? dtfrom = null;
        if (!string.IsNullOrEmpty(txtDateFrom.Text))
        {
            dtfrom = DateTime.Parse(txtDateFrom.Text);
        }
        DateTime? dtTo = null;
        if (!string.IsNullOrEmpty(txtDateto.Text))
        {
            dtTo = DateTime.Parse(txtDateto.Text);
        }
        string mob = string.Empty;
        if (!string.IsNullOrEmpty(txtmob.Text))
        {
            mob = "91" + txtmob.Text;
        }
        string stt = string.Empty;
        stt = ddlst.Text;
        int intIndex = 0;

        DataSet ds = ExecuteNonQueryAndDatatable.FillGrdForPaytm(Session["CompanyId"].ToString(), dtfrom, dtTo, stt, mob,true);
        if (ds.Tables[0].Rows.Count > 0)
        {
            GrdLabel.DataSource = ds.Tables[0];
            GrdLabel.DataBind();
            lblcount.Text = GrdLabel.Rows.Count.ToString();
            if (GrdLabel.Rows.Count > 0)
                GrdLabel.HeaderRow.TableSection = TableRowSection.TableHeader;
            intIndex = 0;
            DataTable dt = ds.Tables[0];
            // DataTable dt2 = ds.Tables[1];
        }

    }


    protected void GrdLabel_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdLabel.PageIndex = e.NewPageIndex;
        if (GrdLabel.PageIndex == 0)
            str = 0;
        else
            str = (16 * GrdLabel.PageIndex) - GrdLabel.PageIndex;
        FillGrdPointsDetails();
    }

    protected void btnDownloadExcel_Click(object sender, EventArgs e)
    {

        Page.Validate("servss");
        if (Page.IsValid)
        {
            try
            {
                DateTime? dtfrom = null;
                if (!string.IsNullOrEmpty(txtDateFrom.Text))
                {
                    dtfrom = DateTime.Parse(txtDateFrom.Text);
                }
                DateTime? dtTo = null;
                if (!string.IsNullOrEmpty(txtDateto.Text))
                {
                    dtTo = DateTime.Parse(txtDateto.Text);
                }
                string mob = string.Empty;
                if (!string.IsNullOrEmpty(txtmob.Text))
                {
                    mob = "91" + txtmob.Text;
                }
                string stt = string.Empty;
                stt = ddlst.Text;
                int intIndex = 0;

                DataSet ds = ExecuteNonQueryAndDatatable.FillGrdForPaytm(Session["CompanyId"].ToString(), dtfrom, dtTo, stt, mob, false);
                ds.Tables[0].Columns.Remove("orderid");
                         XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(ds.Tables[0], "Paytm_Report");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                //Return xlsx Excel File  

                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=Paytm_Report.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();
                // return  File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet","Enquiry Details");

                //DownlaodExcel(ds.Tables[0]);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}