using Business9420;
using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_Transaction : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }

        if (!Page.IsPostBack)
        {
            Session["lblMsg1"] = null;
            Session["sb"] = null;

            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));

            btnappr.Visible = false;
            btndisappr.Visible = false;
            btnDownloadExcel.Visible = false;
            allClear();

        }
    }

    private void allClear()
    {
        txtDateFrom.Text = "";
        txtDateto.Text = "";
        //lblcount.Text = "No Records Found";
    }
    private void FillGrdPointsDetails()
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

            DataSet ds = ExecuteNonQueryAndDatatable.GetTransactionData(dtfrom, dtTo);

            if (ds.Tables[0].Rows.Count > 0)
            {

                btnappr.Visible = true;
                btndisappr.Visible = true;
                btnDownloadExcel.Visible = true;

                GrdLabel.DataSource = ds.Tables[0];
                GrdLabel.DataBind();
                lblcount.Text = ds.Tables[1].Rows[0][0].ToString() + " records found.";
                if (GrdLabel.Rows.Count > 0)
                    GrdLabel.HeaderRow.TableSection = TableRowSection.TableHeader;

            }
            else
            {
                lblcount.Text = "No Records Found";
                GrdLabel.DataSource = null;
                GrdLabel.DataBind();
                btnappr.Visible = false;
                btndisappr.Visible = false;
                btnDownloadExcel.Visible = false;
            }


        }
        catch (Exception ex)
        {
            throw;
        }

    }


    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        FillGrdPointsDetails();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtDateFrom.Text = "";
        txtDateto.Text = "";
        GrdLabel.DataSource = null;
        GrdLabel.DataBind();
        //FillGrdPointsDetails();
    }
    protected void btnDownloadExcel_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();

        Page.Validate("servss");
        if (Page.IsValid)
        {
            try
            {
                DataSet dtst = ExecuteNonQueryAndDatatable.GetTransactionDataDwn(Convert.ToDateTime(txtDateFrom.Text), Convert.ToDateTime(txtDateto.Text));
                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dtst.Tables[0], "TransactionData");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                //Return xlsx Excel File  

                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=TransactionData.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
    }

    public void DownlaodExcel(DataTable dt)
    {
        //DataTable dt = SQL_DB.ExecuteDataTable(sQry);
        //Build the CSV file data as a Comma separated string.
        string csv = string.Empty;

        foreach (DataColumn column in dt.Columns)
        {
            //Add the Header row for CSV file.
            csv += column.ColumnName + ',';
        }

        //Add new line.
        csv += "\r\n";

        foreach (DataRow row in dt.Rows)
        {
            foreach (DataColumn column in dt.Columns)
            {
                //Add the Data rows.

                csv += row[column.ColumnName].ToString().Replace(",", ";") + ',';


            }

            //Add new line.
            csv += "\r\n";
        }

        //Download the CSV file.
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=TransactionData.csv");
        Response.Charset = "";
        //Response.ContentType = "application/text";
        Response.ContentType = "text/csv";
        Response.Output.Write(csv);
        Response.Flush();
        Response.End();
    }


    protected void btnappr_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet dtst = ExecuteNonQueryAndDatatable.GetBankTransactionData(Convert.ToDateTime(txtDateFrom.Text), Convert.ToDateTime(txtDateto.Text));
            string AppLocation = "";
            AppLocation = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
            AppLocation = AppLocation.Replace("file:\\", "");
            AppLocation = AppLocation + "\\TransactionDataFiles";
            if (!Directory.Exists(AppLocation))
            {
                Directory.CreateDirectory(AppLocation);
            }
            string file = AppLocation + "\\Transaction" + System.DateTime.Now.ToShortDateString().ToString().Replace("/", "") + System.DateTime.Now.Millisecond.ToString() + ".xlsx";

            using (XLWorkbook wb = new XLWorkbook())
            {
                wb.Worksheets.Add(dtst.Tables[0]);
                wb.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                wb.Style.Font.Bold = true;
                wb.SaveAs(file);
                //wb.Dispose();
            }

            DataSet dsMld = function9420.FetchMailingDetail("Transaction", "Approved");
            string body = DataProvider.Utility.FindMailBody() + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                       " <div class='w_logo'><img src='http://vcqru.com/images/logo.png' alt='logo' /></div>" +
                       " <hr style='border:1px solid #2587D5;'/>" +
                       " <div class='w_frame'>" +
                       " <p>" +
                       " <div class='w_detail'>" +
                       " <span>Hi,</span><br />" + dsMld.Tables[0].Rows[0]["body"].ToString() +
                       " <br />" +
                       " <p>" +
                       " <div class='w_detail'>" +
                       " Thank you,<br /><br />" +
                       " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                       " </div>" +
                       " </p>" +
                       " </div>" +
                       " </p>" +
                       " </div> " +
                       " </div> ";

            string subjec = dsMld.Tables[0].Rows[0]["subject"].ToString() + " from " + txtDateFrom.Text.ToString() + " to " + txtDateto.Text.ToString();

            DataSet dsMl = function9420.FetchMailDetail("test");

            DataProvider.Utility.sendMailAttachMultiRecipient(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), dsMld.Tables[0].Rows[0]["tomail"].ToString(), dsMld.Tables[0].Rows[0]["ccmail"].ToString(), body, subjec, file);
            lblMsg1.Text = "Approveal mail sent seccessful...";

        }
        catch (Exception)
        {

            throw;
        }
    }

    protected void btnsmt_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet dtst = ExecuteNonQueryAndDatatable.GetBankTransactionData(Convert.ToDateTime(txtDateFrom.Text), Convert.ToDateTime(txtDateto.Text));
            string AppLocation = "";
            AppLocation = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
            AppLocation = AppLocation.Replace("file:\\", "");
            AppLocation = AppLocation + "\\TransactionDataFiles";
            if (!Directory.Exists(AppLocation))
            {
                Directory.CreateDirectory(AppLocation);
            }
            string file = AppLocation + "\\DisapproveTransaction" + System.DateTime.Now.ToShortDateString().ToString().Replace("/", "") + System.DateTime.Now.Millisecond.ToString() + ".xlsx";
            using (XLWorkbook wb = new XLWorkbook())
            {
                wb.Worksheets.Add(dtst.Tables[0]);
                wb.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                wb.Style.Font.Bold = true;
                wb.SaveAs(file);
            }

            DataSet dsMld = function9420.FetchMailingDetail("Transaction", "Disapproved");
            string body = DataProvider.Utility.FindMailBody() + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                       " <div class='w_logo'><img src='http://vcqru.com/images/logo.png' alt='logo' /></div>" +
                       " <hr style='border:1px solid #2587D5;'/>" +
                       " <div class='w_frame'>" +
                       " <p>" +
                       " <div class='w_detail'>" +
                       " <span>Hi,</span><br />    " +
                       "<p>" + txtrem.Text.ToString() + "</p><br/>     " + dsMld.Tables[0].Rows[0]["body"].ToString() +
                       " <br />" +
                       " <p>" +
                       " <div class='w_detail'>" +
                       " Thank you,<br /><br />" +
                       " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                       " </div>" +
                       " </p>" +
                       " </div>" +
                       " </p>" +
                       " </div> " +
                       " </div> ";

            string subjec = dsMld.Tables[0].Rows[0]["subject"].ToString() + " from " + txtDateFrom.Text.ToString() + " to " + txtDateto.Text.ToString();

            DataSet dsMl = function9420.FetchMailDetail("test");

            DataProvider.Utility.sendMailAttachMultiRecipient(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), dsMld.Tables[0].Rows[0]["tomail"].ToString(), dsMld.Tables[0].Rows[0]["ccmail"].ToString(), body, subjec, file);
            txtrem.Text = "";
            lblMsg1.Text = "Disapproveal mail sent seccessful...";

        }
        catch (Exception)
        {

            throw;
        }
    }

    protected void GrdLabel_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            GrdLabel.PageIndex = e.NewPageIndex;

            FillGrdPointsDetails();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}