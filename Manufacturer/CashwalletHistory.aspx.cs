using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_CashwalletHistory : System.Web.UI.Page
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
        FillGrdDetails();
    }

    private void FillDateCurrent()
    {
        txtDateFrom.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy").ToString();
        txtDateto.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy").ToString();
        FillGrdDetails();
    }

    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdDetails();
    }

    private void FillGrdDetails()
    {
        DateTime dtfrom = DateTime.Parse(txtDateFrom.Text); ;
        if (!string.IsNullOrEmpty(txtDateFrom.Text))
        {
            dtfrom = DateTime.Parse(txtDateFrom.Text);
        }
        DateTime dtTo = DateTime.Parse(txtDateto.Text);
        if (!string.IsNullOrEmpty(txtDateto.Text))
        {
            dtTo = DateTime.Parse(txtDateto.Text);
        }
        string mob = string.Empty;
      
        string stt = string.Empty;

      
        int intIndex = 0;
        string datefrom = dtfrom.ToString("yyyy-MM-dd") + " 00:00:00";
        string dateTo = dtTo.ToString("yyyy-MM-dd") + " 23:59:59";

        DataSet ds = ExecuteNonQueryAndDatatable.FillGrdForCashWalletrpt(Session["CompanyId"].ToString(), datefrom, dateTo);
        if (ds.Tables[0].Rows.Count > 0)
        {
            GrdLabel.DataSource = ds.Tables[0];
            GrdLabel.DataBind();
          
            //DataTable dt = new DataTable();
            //dt = ds.Tables[0];
            //int SuccessCode = 0;
            //int PendingCode = 0;
            //int FailureCode = 0;
            //decimal SuccessAmount = 0m;
            //decimal FailureAmount = 0m;
            //decimal PendingAmount = 0m;


            //if (dt.Rows.Count > 0)
            //{

            //    SuccessCode = Convert.ToInt32(dt.Compute("Count(ConsumerName)", "BankStatus ='SUCCESS' or FinalStatus='SUCCESS'"));
            //    FailureCode = Convert.ToInt32(dt.Compute("Count(ConsumerName)", "BankStatus ='Failure'"));
            //    PendingCode = Convert.ToInt32(dt.Compute("Count(ConsumerName)", "BankStatus ='ACCEPTED'  and FinalStatus='NA'"));

            //    if (SuccessCode > 0)
            //        SuccessAmount = Convert.ToDecimal(dt.Compute("SUM(Amount)", "BankStatus ='SUCCESS' or FinalStatus='SUCCESS'"));
            //    if (FailureCode > 0)
            //        FailureAmount = Convert.ToDecimal(dt.Compute("SUM(Amount)", "BankStatus ='Failure'"));
            //    if (PendingCode > 0)
            //        PendingAmount = Convert.ToDecimal(dt.Compute("SUM(Amount)", "BankStatus ='ACCEPTED'  and FinalStatus='NA'"));


            //}
           

            lblcount.Text = GrdLabel.Rows.Count.ToString();
            if (GrdLabel.Rows.Count > 0)
                GrdLabel.HeaderRow.TableSection = TableRowSection.TableHeader;
            intIndex = 0;

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
        FillGrdDetails();

    }

    protected void btnDownloadExcel_Click(object sender, EventArgs e)
    {
        DateTime? dtfrom = null;
        if (!string.IsNullOrEmpty(txtDateFrom.Text))
        {
            dtfrom = DateTime.Parse(txtDateFrom.Text).AddHours(0);
        }
        DateTime? dtTo = null;
        if (!string.IsNullOrEmpty(txtDateto.Text))
        {
            dtTo = DateTime.Parse(txtDateto.Text).AddHours(23.5);
        }
      
        int intIndex = 0;

        DataSet ds = ExecuteNonQueryAndDatatable.FillGrdForCashWalletrpt(Session["CompanyId"].ToString(), dtfrom.ToString(), dtTo.ToString());
        XLWorkbook wb = new XLWorkbook();
        wb.Worksheets.Add(ds.Tables[0], "CashwalletHistory_Report");
        MemoryStream stream = new MemoryStream();
        wb.SaveAs(stream);
        //Return xlsx Excel File  

        Response.Clear();
        Response.ContentType = "application/force-download";
        Response.AddHeader("content-disposition", "attachment;    filename=CashwalletHistory_Report.xlsx");
        Response.BinaryWrite(stream.ToArray());
        Response.End();

    }
}