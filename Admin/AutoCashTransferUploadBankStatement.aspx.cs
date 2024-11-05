using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_AutoCashTransferUploadBankStatement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            txtDateFrom.Text = System.DateTime.Today.ToString("yyyy-MM-dd");
            txtDateto.Text = System.DateTime.Today.ToString("yyyy-MM-dd");

        }

    }

    private DataTable BindDataDetails()
    {
        DataTable dt = new DataTable();
        string DateFrom = txtDateFrom.Text;
        DateFrom = DateFrom + " 00:00:00.000";
        string Dateto = txtDateto.Text;
        Dateto = Dateto + " 23:59:59.000";



        dt = SQL_DB.ExecuteDataTable("select ReportNumber,TotalRecords,TotalAmount,DateRange,FilegeneratedDate,case when NeedApproval=1 then 'Required' else 'Not Required' end IsApproval ,case when IsPayoutReleased=0 then 'No' else 'Yes' end as IsPayoutReleased,case when IsDelete=0 then 'No' else 'Yes' end IsDelete,case when IsApproved=0 then 'No' else 'Yes' end IsApproved, case when PayoutReleasedPath is null then 'NA' else PayoutReleasedPath end PayoutReleasedPath from tblFundTransferDetails where FilegeneratedDate between '" + DateFrom + "' and '" + Dateto + "' order by FilegeneratedDate desc");

        return dt;
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
                if (MainIndex.Length > 1)
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
            else if (e.CommandName == "UploadBankFile")
            {
                //Determine the RowIndex of the Row whose Button was clicked.
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                string MainIndex = e.CommandArgument.ToString();
                if (MainIndex.Length > 1)
                    rowIndex = Convert.ToInt32(MainIndex.Substring(MainIndex.Length - 1));

                //Reference the GridView Row.
                GridViewRow row = GridView1.Rows[rowIndex];

                HiddenField hfReportNumber = (HiddenField)row.FindControl("hfReportNumber");
                FileUpload flupload = (FileUpload)row.FindControl("flupload");
                Label lbluploadfile = (Label)row.FindControl("lblfilepath");

                lbluploadfile.Text = "";
                string path = string.Empty;
                try
                {
                    if (flupload.PostedFile.ContentLength > 0)
                    {



                        var fileName = Path.GetFileNameWithoutExtension(flupload.FileName);
                        var fileExtn = Path.GetExtension(flupload.FileName);

                        //path = Path.Combine(Server.MapPath("~/Data/Transactions/"), fileName + fileExtn);
                        string GUID = Guid.NewGuid().ToString();
                        path = Path.Combine(Server.MapPath("~/images/Transactions/"), fileName + "_" + GUID + fileExtn);
                        string Filepath = "/images/Transactions/" + fileName + "_" + GUID + fileExtn;
                        flupload.SaveAs(path);

                        if (fileExtn == ".xlsx" || fileExtn == ".xls")
                        {
                            DataTable sheet1 = new DataTable();


                            OleDbConnectionStringBuilder csbuilder = new OleDbConnectionStringBuilder();
                            if (fileExtn == ".xlsx")
                                csbuilder.Provider = "Microsoft.ACE.OLEDB.12.0";
                            if (fileExtn == ".xls")
                                csbuilder.Provider = "Microsoft.Jet.OLEDB.4.0";
                            csbuilder.DataSource = path;
                            //csbuilder.Add("Extended Properties", "Excel 12.0 Xml;HDR=YES");
                            if (fileExtn == ".xlsx")
                                csbuilder.Add("Extended Properties", "Excel 12.0 Xml;HDR=YES;IMEX=1;");
                            if (fileExtn == ".xls")
                                csbuilder.Add("Extended Properties", "Excel 8.0;HDR=Yes;IMEX=1");

                            //string selectSql = @"SELECT * FROM [Sheet1$]";//
                            string selectSql = @"SELECT * FROM [AutoCashTransfer$]";
                            using (OleDbConnection connection = new OleDbConnection(csbuilder.ConnectionString))
                            using (OleDbDataAdapter adapter = new OleDbDataAdapter(selectSql, connection))
                            {
                                connection.Open();
                                adapter.Fill(sheet1);

                                sheet1.Columns.Add("Response",typeof(string));
                                if (sheet1.Rows.Count > 0)
                                {
                                    string M_CounserID = string.Empty, ResponseMessage = string.Empty ,CustomerRefNo =string.Empty, CustomerName = string.Empty, BankAddress = string.Empty, BankName = string.Empty, AccountNumber = string.Empty,
                                        IFSCCode = string.Empty, TransctionNumber = string.Empty, CompId = string.Empty, MobileNumber = string.Empty, Branch = string.Empty, City = string.Empty,
                                        RTGS_Code = string.Empty, t_status = string.Empty, Amount = string.Empty;
                                    string TransactionProcessDate = null, TransactionDate = null;

                                    string currDate = Convert.ToString(System.DateTime.Now).ToString();


                                    int RowCount = sheet1.Rows.Count;
                                    decimal TotalPaidAmount = 0m;
                                    for (int i = 0; sheet1.Rows.Count > i; i++)
                                    {
                                        //** Reference No
                                        if (sheet1.Rows[i][2].ToString() != "")
                                        {
                                            // M_CounserID = sheet1.Rows[i]["Reference No."].ToString();
                                            string Referenceno = sheet1.Rows[i]["Reference No"].ToString();
                                            TransctionNumber = Referenceno;

                                        }

                                      

                                        DataTable Rdt = SQL_DB.ExecuteDataTable("select TransctionNumber from Transactions where TransctionNumber='" + TransctionNumber.Trim() + "' and issuccess=1");
                                        if (Rdt.Rows.Count > 0)
                                        {
                                            ResponseMessage = "Already paid for tansaction number : "+ TransctionNumber + " !";

                                            
                                        }
                                        else
                                        {
                                            //** Transaction Description
                                            if (sheet1.Rows[i][1].ToString() != "")
                                            {
                                                string TransactionDescription = sheet1.Rows[i][1].ToString();
                                                String[] strlist = TransactionDescription.Split('-');
                                                if(strlist.Length >4)
                                                {
                                                    IFSCCode = strlist[0].ToString();
                                                    IFSCCode = strlist[1].ToString();
                                                    CustomerRefNo = strlist[2].ToString();
                                                    AccountNumber = strlist[3].ToString();
                                                    CustomerName = strlist[4].ToString();
                                                }
                                                else
                                                {

                                                    CustomerRefNo = strlist[1].ToString();
                                                    AccountNumber = strlist[2].ToString();
                                                    CustomerName = strlist[3].ToString();
                                                   
                                                    DataTable Ifscdt = SQL_DB.ExecuteDataTable("select IFSC_Code from M_BankAccount where Account_No='" + AccountNumber.Trim() + "'");
                                                    if (Ifscdt.Rows.Count > 0)
                                                    {
                                                        IFSCCode = Ifscdt.Rows[0]["IFSC_Code"].ToString();
                                                       
                                                    }
                                                    else
                                                        IFSCCode = "HDFC0009110";




                                                }

                                                IFSCCode = IFSCCode.Trim();
                                                CustomerRefNo = CustomerRefNo.Trim();
                                                AccountNumber = AccountNumber.Trim();
                                              


                                                String[] Customerist = CustomerRefNo.Split('V');
                                                CompId = Customerist[0].ToString();
                                                string Rdata = Customerist[1].ToString();
                                                String[] Rdatalist = Rdata.Split('C');
                                                M_CounserID = Rdatalist[0].ToString();


                                               


                                                DataTable Cdt = SQL_DB.ExecuteDataTable("select M_Consumerid,ConsumerName,MobileNo from M_Consumer where M_Consumerid='" + M_CounserID.Trim() + "' and IsDelete=0");
                                                if (Cdt.Rows.Count > 0)
                                                {
                                                    MobileNumber = Cdt.Rows[0]["MobileNo"].ToString();
                                                    CustomerName = Cdt.Rows[0]["ConsumerName"].ToString();
                                                }
                                                else
                                                {
                                                    ResponseMessage = "User Details not found.";
                                                }


                                                DataTable IFSCdt = SQL_DB.ExecuteDataTable("select BANK,BRANCH,ADDRESS,CITY,DISTRICT from IFSC where IFSC='" + IFSCCode.Trim() + "'");
                                                if (IFSCdt.Rows.Count > 0)
                                                {
                                                    BankName = IFSCdt.Rows[0]["BANK"].ToString();
                                                    BankAddress = IFSCdt.Rows[0]["ADDRESS"].ToString();
                                                    City = IFSCdt.Rows[0]["CITY"].ToString();
                                                    Branch = IFSCdt.Rows[0]["BRANCH"].ToString();

                                                }
                                                else
                                                {
                                                    ResponseMessage = "IFSC code is not exist in our master file.";
                                                }

                                            }

                                            //** Transaction Date
                                            if (sheet1.Rows[i][0].ToString() != "")
                                                TransactionDate = sheet1.Rows[i][0].ToString();//, System.Globalization.CultureInfo.InvariantCulture); //Convert.ToDateTime(sheet1.Rows[i].ItemArray.GetValue(7).ToString());
                                            else
                                                TransactionDate = currDate; //DateTime.ParseExact(currDate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                                            DateTime dtime = Convert.ToDateTime(TransactionDate);
                                            TransactionDate = dtime.ToString("yyyy-MM-dd");
                                            TransactionProcessDate = TransactionDate;

                                            //** "Debit Amount"
                                            decimal DebitAmount = 0m;
                                            if (sheet1.Rows[i][3].ToString() != "")
                                                DebitAmount = Convert.ToDecimal(sheet1.Rows[i][3].ToString());
                                            else
                                                DebitAmount = 0;


                                            decimal CreditAmount = 0m;
                                            //** For Credit Amount
                                            if (sheet1.Rows[i][4].ToString() != "")
                                                CreditAmount = Convert.ToDecimal(sheet1.Rows[i][4].ToString());
                                            else
                                                CreditAmount = 0;

                                            Amount = (DebitAmount - CreditAmount).ToString();


                                            //if (sheet1.Rows[i]["Issuccess"].ToString() != "")
                                            //    t_status = sheet1.Rows[i]["Issuccess"].ToString();
                                            //else
                                            t_status = "1";


                                            DataTable Reportdt = SQL_DB.ExecuteDataTable("select * from tblCodeFundTransferDetails where ReportNumber='" + hfReportNumber.Value + "' and CustomerReferenceNumber='" + CustomerRefNo.Trim() + "' and IsPayoutReleased=0");
                                            if (Reportdt.Rows.Count > 0)
                                            {
                                                if (!string.IsNullOrEmpty(M_CounserID))
                                                {
                                                    string strQuery = "insert into Transactions(M_CounserID,CustomerName,BankAddress,BankName,AccountNumber," +
                                                        "IFSCCode,TransctionNumber,Amount,TransactionProcessDate,TransactionDate,CompId,MobileNumber,Branch,City,issuccess) " +
                                                        "values(" +
                                                        "'" + M_CounserID + "'," +
                                                        "'" + CustomerName + "'," +
                                                        "'" + BankAddress + "'," +
                                                        "'" + BankName + "'," +
                                                        "'" + AccountNumber + "'," +
                                                        "'" + IFSCCode + "'," +
                                                        "'" + TransctionNumber + "'," +
                                                        "'" + Amount + "'," +
                                                        "'" + TransactionProcessDate + "'," +
                                                        "'" + TransactionDate + "'," +
                                                        "'" + CompId + "'," +
                                                        "'" + MobileNumber + "'," +
                                                        "'" + Branch + "'," +
                                                        "'" + City + "',"
                                                         + t_status +
                                                        //"'" + sheet1.Rows[i].ItemArray.GetValue(14).ToString().Trim() + "'" +
                                                        ")";

                                                    SQL_DB.ExecuteNonQuery(strQuery);

                                                    string CodeUpdQuery = "update tblCodeFundTransferDetails set IsPayoutReleased=1,M_Consumerid='" + M_CounserID + "' where ReportNumber='" + hfReportNumber.Value.Trim() + "' and CustomerReferenceNumber='" + CustomerRefNo.Trim() + "'";

                                                    SQL_DB.ExecuteNonQuery(CodeUpdQuery);

                                                    TotalPaidAmount = TotalPaidAmount + Convert.ToDecimal(Amount);

                                                }
                                            }
                                            else
                                            {
                                                
                                                ResponseMessage = "Wrong customer refrence id requested for this selected file! ";
                                                return;
                                            }


                                           

                                        }



                                    }


                                   

                                    if (RowCount>0 && TotalPaidAmount >0)
                                    {
                                        string UpdQuery = "update tblFundTransferDetails set IsPayoutReleased='1',PayoutReleasedBy='" + Session["User_Type"].ToString() + "',TotalPayoutReleasedRecords='" + RowCount + "',TotalPayoutReleasedAmount='" + TotalPaidAmount + "',PayoutReleasedDate='" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "',PayoutReleasedPath='" + Filepath + "' where ReportNumber='" + hfReportNumber.Value.Trim() + "'";

                                        SQL_DB.ExecuteNonQuery(UpdQuery);

                                        ResponseMessage = "Your File has been uploaded successfully";

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



                                    lbluploadfile.Text = ResponseMessage;
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    if (ex.Message.ToUpper().Contains("MICROSOFT.ACE.OLEDB.12.0"))
                        lbluploadfile.Text = "Something went wrong, please try with .xls file ";
                    else
                        lbluploadfile.Text = "Something went wrong, please try again after some time !";
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

            HiddenField hfReportNumber = (HiddenField)e.Row.FindControl("hfReportNumber");
            FileUpload flupload = (FileUpload)e.Row.FindControl("flupload");
            Label lbluploadfile = (Label)e.Row.FindControl("lblfilepath");
            Label lblIsApproved = (Label)e.Row.FindControl("lblIsApproved");
            Label lblNeedApproval = (Label)e.Row.FindControl("lblNeedApproval");
            Button lnkbtnupload = (Button)e.Row.FindControl("lnkbtnupload");

            HiddenField hfPayoutReleasedPath = (HiddenField)e.Row.FindControl("hfPayoutReleasedPath");
          
            if (e.Row.Cells[5].Text == "Required" && e.Row.Cells[4].Text== "No")
            {
                
                flupload.Visible = false;
                lbluploadfile.Visible = false;
                lnkbtnupload.Visible = false;
            }
            else
            {
                
                flupload.Visible = true;
                lbluploadfile.Visible = true;
                lnkbtnupload.Visible = true;
            }


            if (hfPayoutReleasedPath.Value == "NA" && lblNeedApproval.Text == "Required" && lblIsApproved.Text == "No")
            {
                e.Row.Cells[9].Text = "NA";
                flupload.Visible = false;
                lbluploadfile.Visible = false;
                lnkbtnupload.Visible = false;
            }
            if (hfPayoutReleasedPath.Value == "NA" && lblNeedApproval.Text == "Not Required")
            {
                e.Row.Cells[9].Text = "NA";
            }
            else
            {
                e.Row.Cells[9].Visible = true;
                flupload.Visible = false;
                lbluploadfile.Visible = false;
                lnkbtnupload.Visible = false;
            }

        }
    }
}