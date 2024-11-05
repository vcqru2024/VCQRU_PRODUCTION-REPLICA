using Business9420;
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

public partial class Admin_AutoCashTransferDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("/Admin/Login.aspx");

       
        lblIfsccode.Text = "";
        if (!IsPostBack) 
        {
           
            Fillpayoutreleasedfile();
        }
    }

    private void Fillpayoutreleasedfile()
    {
        string query = "GetPayoutreleasedFileName";//not recommended this i have written just for example,write stored procedure for security  
        SqlCommand com = new SqlCommand();
        com.CommandText = query;
        com.CommandType = CommandType.StoredProcedure;

        com.Connection = dtcon.OpenConnection();
        SqlDataAdapter da = new SqlDataAdapter(com);
        DataSet Pds = new DataSet();
        da.Fill(Pds);


        if (Pds.Tables.Count > 0)
        {
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(Pds, "FileName", "FileName", ddlpayoutRelease, "--Select--");
            ddlpayoutRelease.SelectedIndex = 0;
        }


            

    }
   
  

   


    public void DownloadCSVFile(DataTable dt, string FileName)
    {
        //Clears all content output from the buffer stream.  
        Response.ClearContent();
       
        

        string csv = string.Empty;

        foreach (DataColumn column in dt.Columns)
        {
            //Add the Header row for CSV file.
            csv += column.ColumnName + "\t" + ',';
        }

        //Add new line.
        csv += "\r\n";

        foreach (DataRow row in dt.Rows)
        {
            foreach (DataColumn column in dt.Columns)
            {
                //Add the Data rows.
                csv += row[column.ColumnName.ToString()].ToString().Replace(",", ";") + ',';
                csv=csv+ "\t";
            }

            //Add new line.
            csv += "\n";
        }

        //Download the CSV file.
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename="+ FileName + ".csv");
        Response.Charset = "";
        Response.ContentType = "application/text";
        Response.Output.Write(csv);
        Response.Flush();
        Response.End();
    }

    public void CreateExcelFile(DataTable Excel,string FileName)
    {
       
        XLWorkbook wb = new XLWorkbook();
       
        wb.Worksheets.Add(Excel, FileName);
        
       
        MemoryStream stream = new MemoryStream();
        wb.SaveAs(stream);
        Response.Clear();
        Response.ContentType = "application/text";
        Response.AddHeader("content-disposition", "attachment;    filename=" + FileName + ".xlsx");
        Response.BinaryWrite(stream.ToArray());
        Response.End();
    }

    protected void btncodestatus_Click(object sender, EventArgs e)
    {
        lblcodestatus.Text = "";
        string path = string.Empty;
        try
        {
            string SelectedFile = ddlpayoutRelease.SelectedItem.Text;
            if (SelectedFile.Contains("Select"))
            {
                lblcodestatus.Text = "Please select file for processing !.";
                return;
            }

            if (fl_CodeStatus.PostedFile.ContentLength > 0)
            {
                var fileName = Path.GetFileNameWithoutExtension(fl_CodeStatus.FileName);
                var fileExtn = Path.GetExtension(fl_CodeStatus.FileName);

                //path = Path.Combine(Server.MapPath("~/Data/Transactions/"), fileName + fileExtn);
                path = Path.Combine(Server.MapPath("~/images/Transactions/"), fileName + "_" + Guid.NewGuid().ToString() + fileExtn);
                fl_CodeStatus.SaveAs(path);

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
                    string selectSql = @"SELECT * FROM [Codestatus$]";
                    using (OleDbConnection connection = new OleDbConnection(csbuilder.ConnectionString))
                    using (OleDbDataAdapter adapter = new OleDbDataAdapter(selectSql, connection))
                    {
                        connection.Open();
                        adapter.Fill(sheet1);

                        if (sheet1.Rows.Count > 0)
                        {
                            string Completecode = string.Empty, Remark = string.Empty, TransactionDate = string.Empty;

                            string currDate = Convert.ToString(System.DateTime.Now).ToString();


                            for (int i = 0; sheet1.Rows.Count > i; i++)
                            {




                                if (sheet1.Rows[i][0].ToString() != "")
                                {
                                    //** For Completecode
                                    Completecode = sheet1.Rows[i][0].ToString();

                                }

                                DataTable dt = SQL_DB.ExecuteDataTable("select Complete_code,Transaction_Status,Transaction_date from Transaction_status where Complete_code='" + Completecode.Trim() + "'");
                                if (dt.Rows.Count > 0)
                                {

                                }
                                else
                                {
                                    if (sheet1.Rows[i][1].ToString() != "")
                                    {
                                        //** For Remarks
                                        Remark = sheet1.Rows[i][1].ToString();

                                    }

                                    //** For TransactionDate
                                    if (sheet1.Rows[i][2].ToString() != "")
                                        TransactionDate = sheet1.Rows[i][2].ToString();//, System.Globalization.CultureInfo.InvariantCulture); //Convert.ToDateTime(sheet1.Rows[i].ItemArray.GetValue(7).ToString());
                                    else
                                        TransactionDate = currDate; //DateTime.ParseExact(currDate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                                    DateTime dtime = Convert.ToDateTime(TransactionDate);
                                    TransactionDate = dtime.ToString("yyyy-MM-dd");
                                    if (!string.IsNullOrEmpty(Completecode))
                                    {
                                        string strQuery = "insert into Transaction_status(Complete_code,Transaction_Status,Transaction_date)values(" +
                                            "'" + Completecode + "'," +
                                            "'" + Remark + "'," +
                                            "'" + TransactionDate + "')";

                                        SQL_DB.ExecuteNonQuery(strQuery);


                                        string UpdQuery = "update tblCodeFundTransferDetails set IsPayoutReleased=1 where CompleteCode='" + Completecode.Trim() + "' and ReportNumber='" + SelectedFile.Trim() + "'";

                                        SQL_DB.ExecuteNonQuery(UpdQuery);

                                    }

                                }



                            }

                            lblcodestatus.Text = "Your File has been uploaded successfully";
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            if (ex.Message.ToUpper().Contains("MICROSOFT.ACE.OLEDB.12.0"))
                lblcodestatus.Text = "Something went wrong, please try with .xls file ";
            else
                lblcodestatus.Text = "Something went wrong, please try again after some time " + ex.StackTrace;
        }
    }



    protected void Button1_Click(object sender, EventArgs e)
    {
        string path = string.Empty;
        try
        {
            if (FileUpload1.PostedFile.ContentLength > 0)
            {
                var fileName = Path.GetFileNameWithoutExtension(FileUpload1.FileName);
                var fileExtn = Path.GetExtension(FileUpload1.FileName);

                //path = Path.Combine(Server.MapPath("~/Data/Transactions/"), fileName + fileExtn);
                path = Path.Combine(Server.MapPath("~/images/Transactions/"), fileName + "_" + Guid.NewGuid().ToString() + fileExtn);
                FileUpload1.SaveAs(path);

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
                    string selectSql = @"SELECT * FROM [IFSCcodeMaster$]";
                    using (OleDbConnection connection = new OleDbConnection(csbuilder.ConnectionString))
                    using (OleDbDataAdapter adapter = new OleDbDataAdapter(selectSql, connection))
                    {
                        connection.Open();
                        adapter.Fill(sheet1);

                        if (sheet1.Rows.Count > 0)
                        {
                            string BANK = string.Empty, IFSC = string.Empty, BRANCH = string.Empty, ADDRESS = string.Empty, CONTACT = string.Empty, CITY = string.Empty, DISTRICT = string.Empty, STATE = string.Empty;

                            string currDate = Convert.ToString(System.DateTime.Now).ToString();


                            for (int i = 0; sheet1.Rows.Count > i; i++)
                            {




                                if (sheet1.Rows[i][0].ToString() != "")
                                {
                                    //** For Bank name
                                    BANK = sheet1.Rows[i][0].ToString();

                                }

                                if (sheet1.Rows[i][1].ToString() != "")
                                {
                                    //** For IFsc code 
                                    IFSC = sheet1.Rows[i][1].ToString();

                                }
                                if (sheet1.Rows[i][2].ToString() != "")
                                {
                                    //** For Branch address
                                    BRANCH = sheet1.Rows[i][2].ToString();

                                }
                                if (sheet1.Rows[i][3].ToString() != "")
                                {
                                    //** For Bank address 
                                    ADDRESS = sheet1.Rows[i][3].ToString();

                                }
                                if (sheet1.Rows[i][4].ToString() != "")
                                {
                                    //** For Contact 
                                    CONTACT = sheet1.Rows[i][4].ToString();

                                }
                                if (sheet1.Rows[i][5].ToString() != "")
                                {
                                    //** For CITY 
                                    CITY = sheet1.Rows[i][5].ToString();

                                }
                                if (sheet1.Rows[i][6].ToString() != "")
                                {
                                    //** For DISTRICT 
                                    DISTRICT = sheet1.Rows[i][6].ToString();

                                }
                                if (sheet1.Rows[i][7].ToString() != "")
                                {
                                    //** For STATE 
                                    STATE = sheet1.Rows[i][7].ToString();

                                }

                                DataTable dt = SQL_DB.ExecuteDataTable("select BANK,IFSC,BRANCH,ADDRESS,CONTACT,CITY,DISTRICT,STATE from IFSC where IFSC='" + IFSC.Trim() + "'");
                                if (dt.Rows.Count > 0)
                                { 
                                    string strQuery = "update IFSC set BANK='"+BANK+"',BRANCH='"+BRANCH+"',ADDRESS='"+ADDRESS+"',CONTACT='"+CONTACT+"',CITY='"+CITY+"',DISTRICT='"+DISTRICT+"',STATE='"+STATE+"' where IFSC='" + IFSC.Trim() + "'";

                                    SQL_DB.ExecuteNonQuery(strQuery);
                                }
                                else
                                {
                                    string strQuery = "insert into IFSC(BANK,IFSC,BRANCH,ADDRESS,CONTACT,CITY,DISTRICT,STATE)values(" +
                                             "'" + BANK + "'," +
                                             "'" + IFSC + "'," +
                                             "'" + BRANCH + "'," +
                                             "'" + ADDRESS + "'," +
                                             "'" + CONTACT + "'," +
                                             "'" + CITY + "'," +
                                             "'" + DISTRICT + "'," +
                                             "'" + STATE + "')";

                                    SQL_DB.ExecuteNonQuery(strQuery);

                                }



                            }

                            lblIfsccode.Text = "Your File has been uploaded successfully";
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            if (ex.Message.ToUpper().Contains("MICROSOFT.ACE.OLEDB.12.0"))
                lblIfsccode.Text = "Something went wrong, please try with .xls file ";
            else
                lblIfsccode.Text = "Something went wrong, please try again after some time " + ex.StackTrace;
        }
    }

   

    protected void lnkpayoutReleasedownlaod_Click(object sender, EventArgs e)
    {
        lblcodestatus.Text = "";
        string SelectedFile = ddlpayoutRelease.SelectedItem.Text;
        if (SelectedFile.Contains("Select"))
        {
            lblcodestatus.Text = "Please select file for processing !.";
            return;
        }

        string query = "GetPayoutreleasedCodeDetails";//not recommended this i have written just for example,write stored procedure for security  
        SqlCommand com = new SqlCommand();
        com.CommandText = query;
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@ReportNumber", SelectedFile);
        com.Parameters.AddWithValue("@IsPayoutReleased", true);
        com.Connection = dtcon.OpenConnection();
        SqlDataAdapter da = new SqlDataAdapter(com);
        DataSet ds = new DataSet();
        da.Fill(ds);

        if (ds.Tables.Count > 1)
        {
            string FileName = ds.Tables[1].Rows[0]["ReportNumber"].ToString();
            //calling DownloadCSVFile csv File Method and ing dataTable   
            // DownloadCSVFile(ds.Tables[0], FileName);

            CreateExcelFile(ds.Tables[0], FileName);
            

        }
        else
            lblcodestatus.Text = "Data Not Found!";

    }
}