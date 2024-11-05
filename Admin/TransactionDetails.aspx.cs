using System;
using System.IO;
using System.Data.OleDb;
using System.Data;
using System.Data.SqlClient;


public partial class Admin_TransactionDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("/Admin/Login.aspx");

        if (!IsPostBack) { }
    }

    protected void btnTransaction_Click(object sender, EventArgs e)
    {
        string path = string.Empty;
        try
        {
            if (fl_transaction.PostedFile.ContentLength > 0)
            {
                var fileName = Path.GetFileNameWithoutExtension(fl_transaction.FileName);
                var fileExtn = Path.GetExtension(fl_transaction.FileName);

                //path = Path.Combine(Server.MapPath("~/Data/Transactions/"), fileName + fileExtn);
                path = Path.Combine(Server.MapPath("~/images/Transactions/"), fileName + fileExtn);
                fl_transaction.SaveAs(path);

                if (fileExtn == ".xlsx" || fileExtn == ".xls")
                {
                    DataTable sheet1 = new DataTable();


                    OleDbConnectionStringBuilder csbuilder = new OleDbConnectionStringBuilder();
                   if(fileExtn == ".xlsx")
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
                    string selectSql = @"SELECT * FROM [TransactionDetails$]";
                    using (OleDbConnection connection = new OleDbConnection(csbuilder.ConnectionString))
                    using (OleDbDataAdapter adapter = new OleDbDataAdapter(selectSql, connection))
                    {
                        connection.Open();
                        adapter.Fill(sheet1);

                        if (sheet1.Rows.Count > 0)
                        {
                            string M_CounserID = string.Empty, CustomerName = string.Empty, BankAddress = string.Empty, BankName = string.Empty, AccountNumber = string.Empty,
                                IFSCCode = string.Empty, TransctionNumber = string.Empty, CompId = string.Empty, MobileNumber = string.Empty, Branch = string.Empty, City = string.Empty,
                                RTGS_Code = string.Empty, t_status=string.Empty, Amount=string.Empty;
                            string TransactionProcessDate = null, TransactionDate = null;

                            string currDate = Convert.ToString(System.DateTime.Now).ToString();

                            
                            for (int i = 0; sheet1.Rows.Count > i; i++)
                            {
                                if (sheet1.Rows[i]["M_CounserID"].ToString() != "")
                                    M_CounserID = sheet1.Rows[i]["M_CounserID"].ToString();
                                else
                                    M_CounserID = null;

                                if (sheet1.Rows[i]["CustomerName"].ToString() != "")
                                    CustomerName = sheet1.Rows[i]["CustomerName"].ToString();
                                else
                                    CustomerName = null;

                                if (sheet1.Rows[i]["BankAddress"].ToString() != "")
                                    BankAddress = sheet1.Rows[i]["BankAddress"].ToString();
                                else
                                    BankAddress = null;

                                if (sheet1.Rows[i]["BankName"].ToString() != "")
                                    BankName = sheet1.Rows[i]["BankName"].ToString();
                                else
                                    BankName = null;

                                if (sheet1.Rows[i]["AccountNumber"].ToString() != "")
                                    AccountNumber = sheet1.Rows[i]["AccountNumber"].ToString();
                                else
                                    AccountNumber = null;

                                if (sheet1.Rows[i]["IFSCCode"].ToString() != "")
                                    IFSCCode = sheet1.Rows[i]["IFSCCode"].ToString();
                                else
                                    IFSCCode = null;

                                //string stDate = Convert.ToString(sheet1.Rows[i].ItemArray.GetValue(6).ToString()).ToString();
                                if (sheet1.Rows[i]["TransactionProcessDate"].ToString() != "")
                                    TransactionProcessDate = sheet1.Rows[i]["TransactionProcessDate"].ToString(); //DateTime.Parse(stDate, System.Globalization.CultureInfo.InvariantCulture);
                                else
                                    TransactionProcessDate = currDate; //DateTime.ParseExact(currDate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);

                                if (sheet1.Rows[i]["TransactionDate"].ToString() != "")
                                    TransactionDate = sheet1.Rows[i]["TransactionDate"].ToString();//, System.Globalization.CultureInfo.InvariantCulture); //Convert.ToDateTime(sheet1.Rows[i].ItemArray.GetValue(7).ToString());
                                else
                                    TransactionDate = currDate; //DateTime.ParseExact(currDate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);

                                if (sheet1.Rows[i]["TransctionNumber"].ToString() != "")
                                    TransctionNumber = sheet1.Rows[i]["TransctionNumber"].ToString();
                                else
                                    TransctionNumber = null;
                                if (sheet1.Rows[i]["Amount"].ToString() != "")
                                    Amount = sheet1.Rows[i]["Amount"].ToString();
                                else
                                    Amount = null;

                                if (sheet1.Rows[i]["CompId"].ToString() != "")
                                    CompId = sheet1.Rows[i]["CompId"].ToString();
                                else
                                    CompId = null;

                                if (sheet1.Rows[i]["MobileNumber"].ToString() != "")
                                    MobileNumber = sheet1.Rows[i]["MobileNumber"].ToString();
                                else
                                    MobileNumber = null;

                                if (sheet1.Rows[i]["Branch"].ToString() != "")
                                    Branch = sheet1.Rows[i]["Branch"].ToString();
                                else
                                    Branch = null;

                                if (sheet1.Rows[i]["City"].ToString() != "")
                                    City = sheet1.Rows[i]["City"].ToString();
                                else
                                    City = null;

                                if (sheet1.Rows[i]["RTGS_Code"].ToString() != "")
                                    RTGS_Code = sheet1.Rows[i]["RTGS_Code"].ToString();
                                else
                                    RTGS_Code = null;
                                if (sheet1.Rows[i]["Issuccess"].ToString() != "")
                                    t_status = sheet1.Rows[i]["Issuccess"].ToString();
                                else
                                    t_status = "0";

                                if (!string.IsNullOrEmpty(M_CounserID))
                                {
                                    string strQuery = "insert into Transactions(M_CounserID,CustomerName,BankAddress,BankName,AccountNumber," +
                                        "IFSCCode,TransctionNumber,Amount,TransactionProcessDate,TransactionDate,CompId,MobileNumber,Branch,City,RTGS_Code,issuccess) " +
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
                                        "'" + City + "'," +
                                        "'" + RTGS_Code + "',"
                                         + t_status +
                                        //"'" + sheet1.Rows[i].ItemArray.GetValue(14).ToString().Trim() + "'" +
                                        ")";

                                    SQL_DB.ExecuteNonQuery(strQuery);
                                }
                            }

                            lblMsg.Text = "Your File has been uploaded successfully";
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            if(ex.Message.ToUpper().Contains("MICROSOFT.ACE.OLEDB.12.0"))
                lblMsg.Text = "Something went wrong, please try with .xls file ";
            else
            lblMsg.Text = "Something went wrong, please try again after some time " + ex.StackTrace;
        }
    }

    protected void lnkDownload_Click(object sender, EventArgs e)
    {
        //getting datatable from viewstate  
        string query = "select *from vw_trnDetails";//not recommended this i have written just for example,write stored procedure for security  
        SqlCommand com = new SqlCommand(query, dtcon.OpenConnection());
        SqlDataAdapter da = new SqlDataAdapter(query, dtcon.OpenConnection());
        DataSet ds = new DataSet();
        da.Fill(ds);

        //calling create Excel File Method and ing dataTable   
        CreateExcelFile(ds.Tables[0]);
    }

    public void CreateExcelFile(DataTable Excel)
    {
        //Clears all content output from the buffer stream.  
        Response.ClearContent();
        //Adds HTTP header to the output stream  
        Response.AddHeader("content-disposition", string.Format("attachment; filename=TransactionDetails.xls"));

        // Gets or sets the HTTP MIME type of the output stream  
        Response.ContentType = "application/vnd.ms-excel";
        string space = "";

        foreach (DataColumn dcolumn in Excel.Columns)
        {
            Response.Write(space + dcolumn.ColumnName);
            space = "\t";
        }
        Response.Write("\n");
        int countcolumn;
        foreach (DataRow dr in Excel.Rows)
        {
            space = "";
            for (countcolumn = 0; countcolumn < Excel.Columns.Count; countcolumn++)
            {
                Response.Write(space + dr[countcolumn].ToString());
                space = "\t";
            }
            Response.Write("\n");
        }
        Response.End();
    }

    //public static void InsertDataIntoSQLServerUsingSQLBulkCopy(DataTable csvFileData)
    //{
    //    using (SqlConnection dbConnection = new SqlConnection(dtcon.ConnectionString))
    //    {
    //        dbConnection.Open();
    //        using (SqlBulkCopy s = new SqlBulkCopy(dbConnection))
    //        {
    //            s.DestinationTableName = "Transactions";

    //            foreach (var column in csvFileData.Columns)
    //                s.ColumnMappings.Add(column.ToString(), column.ToString());

    //            s.WriteToServer(csvFileData);
    //        }
    //    }
    //}


    //public static DataTable Import(string srcFilePath, bool hasHeader)
    //{
    //    // Initilization
    //    DataTable datatable = new DataTable();
    //    StreamReader sr = null;

    //    try
    //    {
    //        // Creating data table without header.
    //        using (sr = new StreamReader(new FileStream(srcFilePath, FileMode.Open, FileAccess.Read)))
    //        {
    //            // Initialization.
    //            string line = string.Empty;
    //            string[] headers = sr.ReadLine().Split(',');
    //            DataRow dr = datatable.NewRow();

    //            // Preparing header.
    //            for (int i = 0; i < headers.Length; i++)
    //            {
    //                // Verification.
    //                if (hasHeader)
    //                {
    //                    // Setting.
    //                    datatable.Columns.Add(headers[i]);
    //                }
    //                else
    //                {
    //                    // Setting.
    //                    datatable.Columns.Add(Strings.COL_HEADER_1 + i);
    //                    dr[i] = headers[i];
    //                }
    //            }

    //            // Verification.
    //            if (!hasHeader)
    //            {
    //                // Adding.
    //                datatable.Rows.Add(dr);
    //            }

    //            // Adding data.
    //            while ((line = sr.ReadLine()) != null)
    //            {
    //                // Initialization.
    //                string[] rows = line.Split(',');
    //                dr = datatable.NewRow();

    //                // Verification
    //                if (string.IsNullOrEmpty(line))
    //                {
    //                    // Info.
    //                    continue;
    //                }

    //                // Adding row.
    //                for (int i = 0; i < headers.Length; i++)
    //                {
    //                    // Setting.
    //                    dr[i] = rows[i];
    //                }

    //                // Adding.
    //                datatable.Rows.Add(dr);
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        // Info.
    //        throw ex;
    //    }
    //    finally
    //    {
    //        // Closing.
    //        sr.Dispose();
    //        sr.Close();
    //    }

    //    // Info.
    //    return datatable;
    //}
}