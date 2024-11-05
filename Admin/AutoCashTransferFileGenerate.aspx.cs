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

public partial class Admin_AutoCashTransferFileGenerate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            FillCompany();
            txtDateFrom.Text = System.DateTime.Today.ToString("yyyy-MM-dd");
            txtDateto.Text= System.DateTime.Today.ToString("yyyy-MM-dd");
            BindDataDetails();
        }
       
    }


    private DataTable BindDataDetails()   
    {
        DataTable dt = new DataTable();
        string DateFrom = txtDateFrom.Text;
        DateFrom = DateFrom + " 00:00:00.000";
        string Dateto = txtDateto.Text;
        Dateto = Dateto + " 23:59:59.000";
        string CompId = ddlComp_Id.SelectedItem.Value;
        if (CompId.Contains("All"))
            CompId = "";

        string Isapproval = ddlapproval.SelectedItem.Value;
        if (ddlapproval.SelectedItem.Text == "---Select---")
            dt = SQL_DB.ExecuteDataTable("select ReportNumber,TotalRecords,TotalAmount,DateRange,FilegeneratedDate,case when NeedApproval=1 then 'Required' else 'Not Required' end IsApproval ,case when IsPayoutReleased=0 then 'No' else 'Yes' end as IsPayoutReleased,case when IsDelete=0 then 'No' else 'Yes' end IsDelete,case when IsApproved=0 then 'No' else 'Yes' end IsApproved from tblFundTransferDetails where FilegeneratedDate between '" + DateFrom + "' and '" + Dateto + "' order by FilegeneratedDate desc");
        else
        dt = SQL_DB.ExecuteDataTable("select ReportNumber,TotalRecords,TotalAmount,DateRange,FilegeneratedDate,case when NeedApproval=1 then 'Required' else 'Not Required' end IsApproval ,case when IsPayoutReleased=0 then 'No' else 'Yes' end as IsPayoutReleased,case when IsDelete=0 then 'No' else 'Yes' end IsDelete,case when IsApproved=0 then 'No' else 'Yes' end IsApproved from tblFundTransferDetails where FilegeneratedDate between '" + DateFrom + "' and '" + Dateto + "' and NeedApproval='" + ddlapproval.SelectedItem.Value + "' order by FilegeneratedDate desc");

        return dt;
    }
    private void FillCompany()
    {
        string query = "GetAllCompanyDetailsAutoCashTransfer";//not recommended this i have written just for example,write stored procedure for security  
        SqlCommand com = new SqlCommand();
        com.CommandText = query;
        com.CommandType = CommandType.StoredProcedure;

        com.Connection = dtcon.OpenConnection();
        SqlDataAdapter da = new SqlDataAdapter(com);
        DataSet ds = new DataSet();
        da.Fill(ds);




        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", ddlComp_Id, "--All--");
        ddlComp_Id.SelectedIndex = 0;

    }

    protected void lnkDownload_Click(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        string DateFrom = txtDateFrom.Text;
        DateFrom = DateFrom + " 00:00:00.000";
        string Dateto = txtDateto.Text;
        Dateto = Dateto + " 23:59:59.000";
        string CompId = ddlComp_Id.SelectedItem.Value;
        if (CompId.Contains("All"))
            CompId = "";

        if (ddlapproval.SelectedItem.Text == "---Select---")
        {
            lblMsg.Text = "Is approval required from vendor ?";
            return;
        }
        //getting datatable from viewstate  
        string query = "GetBankTransactionDetails";//not recommended this i have written just for example,write stored procedure for security  
        SqlCommand com = new SqlCommand();
        com.CommandText = query;
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@FromDate", DateFrom);
        com.Parameters.AddWithValue("@ToDate", Dateto);
        com.Parameters.AddWithValue("@CompId", CompId);
        com.Parameters.AddWithValue("@GeneratedBy", Session["User_Type"].ToString());
        com.Parameters.AddWithValue("@NeedApproval", ddlapproval.SelectedItem.Value);
        com.Connection = dtcon.OpenConnection();
        SqlDataAdapter da = new SqlDataAdapter(com);
        DataSet ds = new DataSet();
        da.Fill(ds);

        if(ds.Tables[1].Rows.Count==0)
        {
            lblMsg.Text = "Unable to generate file , Please try again later !";
            return;
        }

        if (ds.Tables.Count > 1)
        {
            string FileName = ds.Tables[1].Rows[0]["ReportNumber"].ToString();
            //calling DownloadCSVFile csv File Method and ing dataTable   
            CreateExcelFile(ds.Tables[0], FileName);
        }
        else
            lblMsg.Text = "Data Not Found!";


    }

    public void CreateExcelFile(DataTable Excel, string FileName)
    {
        XLWorkbook wb = new XLWorkbook();
        wb.Worksheets.Add(Excel, FileName);
        MemoryStream stream = new MemoryStream();
        wb.SaveAs(stream);
        Response.Clear();
        Response.ContentType = "application/force-download";
        Response.AddHeader("content-disposition", "attachment;    filename=" + FileName + ".xlsx");
        Response.BinaryWrite(stream.ToArray());
        Response.End();
    }

    protected void lnkfileDownload_Click(object sender, ImageClickEventArgs e)
    {


        DataTable dt = BindDataDetails();



        if (dt.Rows.Count > 0)
        {
            lblcount.Text = dt.Rows.Count.ToString();
            GridView1.DataSource = dt;
            GridView1.DataBind();

        }
        else
        {
            GridView1.DataSource = "";
            lblcount.Text = "0";

        }

    }


    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "No")
            {
                return;
            }


            //string message = "";
            if (e.CommandName == "IndivisualDownLoad")
            {
                int tp = 0;
                //Determine the RowIndex of the Row whose Button was clicked.
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                string MainIndex = e.CommandArgument.ToString();
                if(MainIndex.Length>1)
                 rowIndex = Convert.ToInt32(MainIndex.Substring(MainIndex.Length - 1));

                //Reference the GridView Row.
                GridViewRow row = GridView1.Rows[rowIndex];


                HiddenField hfReportNumber = (HiddenField)row.FindControl("hfReportNumber");
                Label lblIsPayoutReleased = (Label)row.FindControl("lblIsPayoutReleased");

                bool IsProcessed = false;
                if (lblIsPayoutReleased.Text == "Yes")
                {
                    IsProcessed = true;
                }


                string query = "GetPayoutreleasedCodeDetails";//not recommended this i have written just for example,write stored procedure for security  
                SqlCommand com = new SqlCommand();
                com.CommandText = query;
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@ReportNumber", hfReportNumber.Value);
                com.Parameters.AddWithValue("@IsPayoutReleased", IsProcessed);
                com.Connection = dtcon.OpenConnection();
                SqlDataAdapter da = new SqlDataAdapter(com);
                DataSet ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables.Count > 1)
                {
                    string FileName = ds.Tables[1].Rows[0]["ReportNumber"].ToString();
                    //calling DownloadCSVFile csv File Method and ing dataTable   
                    CreateExcelFile(ds.Tables[0], FileName);


                }



            }
            else if (e.CommandName == "RowDelete")
            {
                //Determine the RowIndex of the Row whose Button was clicked.
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Reference the GridView Row.
                GridViewRow row = GridView1.Rows[rowIndex];

                HiddenField hfReportNumber = (HiddenField)row.FindControl("hfReportNumber");

                Label lblIsPayoutReleased = (Label)row.FindControl("lblIsPayoutReleased");

                
                if (lblIsPayoutReleased.Text != "Yes")
                {
                    SQL_DB.ExecuteNonQuery("update tblFundTransferDetails set IsDelete=1,DeleteDate='" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "',DeletedBy='" + Session["User_Type"].ToString() + "' where ReportNumber='" + hfReportNumber.Value + "'");
                    SQL_DB.ExecuteNonQuery("update tblCodeFundTransferDetails set IsDelete=1 where ReportNumber='" + hfReportNumber.Value + "'");

                }



                DataTable dt = BindDataDetails();
                if (dt.Rows.Count > 1)
                {
                    lblcount.Text = dt.Rows.Count.ToString();
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
                else
                {
                    GridView1.DataSource = "";
                    lblcount.Text = "0";

                }
            }

        }
        catch
        {

        }

       
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        DataTable dt = BindDataDetails();
        if (dt.Rows.Count > 1)
        {
            lblcount.Text = dt.Rows.Count.ToString();
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSource = "";
            lblcount.Text = "0";

        }
    }


    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {

        GridView1.EditIndex = e.NewEditIndex;
        GridView1.DataBind();
        GridView1.Visible = true;
    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {

        GridView1.EditIndex = -1;
        GridView1.DataBind();
        GridView1.Visible = true;
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {



        }
    }
}