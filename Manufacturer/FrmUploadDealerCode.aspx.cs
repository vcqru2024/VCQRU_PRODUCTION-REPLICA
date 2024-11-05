using ClosedXML.Excel;
using Data9420;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_FrmUploadDealerCode : System.Web.UI.Page
{
    DataTable sb = new DataTable();
    public int ScrapeFlag = 0;
    public int index = 0,dtype=0;
    public Int32 sr = 0;
    private string GetValue(SpreadsheetDocument doc, Cell cell)
    {
        string value = string.Empty;
        if (cell == null)
        {
            return null;
        }
        else if(cell.DataType==null && cell.CellValue!=null)
        {
            dtype = 1;
        }
        //value = string.IsNullOrWhiteSpace(cell.CellValue.InnerText);
        else if (cell.DataType != null && cell.DataType.Value == CellValues.SharedString)
        {
            value = cell.CellValue.InnerText;
            return doc.WorkbookPart.SharedStringTablePart.SharedStringTable.ChildElements.GetItem(int.Parse(value)).InnerText;
            //return value;
        }
        //}
        return value;
    }

    private static IEnumerable<Cell> GetCellsFromRowIncludingEmptyCells(Row row)
    {
        int currentCount = 0;
        // row is a class level variable representing the current
        foreach (DocumentFormat.OpenXml.Spreadsheet.Cell cell in
            row.Descendants<DocumentFormat.OpenXml.Spreadsheet.Cell>())
        {
            string columnName = GetColumnName(cell.CellReference);
            int currentColumnIndex = ConvertColumnNameToNumber(columnName);
            //Return null for empty cells
            for (; currentCount < currentColumnIndex; currentCount++)
            {
                yield return null;
            }
            yield return cell;
            currentCount++;
        }
    }
    public static string GetColumnName(string cellReference)
    {
        // Match the column name portion of the cell name.
        Regex regex = new Regex("[A-Za-z]+");
        Match match = regex.Match(cellReference);

        return match.Value;
    }


    public static int ConvertColumnNameToNumber(string columnName)
    {
        Regex alpha = new Regex("^[A-Z]+$");
        if (!alpha.IsMatch(columnName)) throw new ArgumentException();

        char[] colLetters = columnName.ToCharArray();
        Array.Reverse(colLetters);

        int convertedValue = 0;
        for (int i = 0; i < colLetters.Length; i++)
        {
            char letter = colLetters[i];
            int current = i == 0 ? letter - 65 : letter - 64; // ASCII 'A' = 65
            convertedValue += current * (int)Math.Pow(26, i);
        }

        return convertedValue;
    }

   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("~/Login.aspx?Page=FrmUploadDealerCode.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("~/adminLogin.aspx");
        }


        sb.Columns.Add("Zone");
        sb.Columns.Add("State");
        sb.Columns.Add("DealerCode");
        sb.Columns.Add("TechnicianId");
        sb.Columns.Add("Name");
        sb.Columns.Add("Designation");
        sb.Columns.Add("Status");

        string path = string.Empty;
        if (IsPostBack)
        {

            try
            {
                HttpPostedFile filePosted = Request.Files["ctl00$ContentPlaceHolder1$codesupload"];
                if (filePosted != null)
                {
                    //btnDisable();
                    if (filePosted.ContentLength > 0)
                    {
                        Session["lblMsg1"] = null;
                        Session["sb"] = null;

                        var fileName = Path.GetFileNameWithoutExtension(filePosted.FileName);
                        var fileExtn = Path.GetExtension(filePosted.FileName);

                        path = Path.Combine(Server.MapPath("~/Data/"), fileName + fileExtn);
                        //path = Path.Combine(Server.MapPath("~/images/Transactions/"), fileName + fileExtn);
                        filePosted.SaveAs(path);

                        string value = string.Empty;
                        DataTable dt = new DataTable();
                        if (fileExtn == ".xlsx" || fileExtn == ".xls")
                        {                           

                            using (SpreadsheetDocument myWorkbook = SpreadsheetDocument.Open(path, true))
                            {
                                var sheet = myWorkbook.WorkbookPart.Workbook.GetFirstChild<Sheets>().Elements<Sheet>().First();
                                var worksheetPart = (WorksheetPart)myWorkbook.WorkbookPart.GetPartById(sheet.Id.Value);
                                IEnumerable<Row> rows = worksheetPart.Worksheet.GetFirstChild<SheetData>().Elements<Row>();
                                int RowIndex = 0;

                                foreach (var row in rows)
                                {
                                    //Create the data table header row ie columns using first excel row.
                                    if (row.RowIndex.Value == 1)
                                    {
                                        foreach (Cell cell in row.Descendants<Cell>())
                                        {
                                            dt.Columns.Add(GetValue(myWorkbook, cell));
                                        }
                                    }
                                    else
                                    {
                                        //From second row of excel onwards, add data rows to data table.
                                        IEnumerable<Cell> cells = GetCellsFromRowIncludingEmptyCells(row);
                                        DataRow newDataRow = dt.NewRow();
                                        int columnCount = 0;
                                        foreach (Cell currentCell in cells)
                                        {
                                            value = GetValue(myWorkbook, currentCell);
                                            //There are empty headers which are not added to data table columns. So avoid those.
                                            if (columnCount < dt.Columns.Count)
                                            {
                                                newDataRow[columnCount++] = value;
                                            }
                                        }
                                        dt.Rows.Add(newDataRow);
                                    }
                                }
                            }

                            if(dtype==1)
                            {
                                dt.Rows.Clear();
                            }


                            if (dt.Rows.Count > 0)
                            {

                                DataRow[] dtrows = dt.Select("[DealerCode]='' or [DealerCode] is null OR [TechnicianId]='' OR [TechnicianId] is null or Designation='' or Designation is null or State='' or State is null or Status='' or Status is null");

                                var duplicates = dt.AsEnumerable().GroupBy(i => new { DealerCode = i.Field<string>("DealerCode"), TechnicianId = i.Field<string>("TechnicianId") }).Where(g => g.Count() > 1).Select(g => new { g.Key.DealerCode, g.Key.TechnicianId }).ToList();
                                if (duplicates.Count > 0 || dtrows.Length > 0)
                                {
                                    Session["dt"] = dt;
                                    string msg = dtrows.Length + " Incorrect records & " + duplicates.Count + " Duplicate records Found. Do you want to Proceed anyway ?";
                                    lblMsg1.Text = dtrows.Length + " Incorrect records & " + duplicates.Count + " Duplicate records Found.";
                                    Session["lblMsg1"] = dtrows.Length + " Incorrect records & " + duplicates.Count + " Duplicate records Found.";
                                    //UpdateProgress1.Visible = false;
                                    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "Confirm('" + msg + "')", true);

                                }
                                else
                                {
                                    Session["dt"] = dt;
                                    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "btnsave()", true);
                                   
                                }

                            }

                            else
                            {
                                lblMsg1.Text = "Please convert you excel columns as Text. Followed by steps to all column one by one. Select column then click on Data Menu-> Click on Text To Columns->Click on Fixed->Click next 2 times->Select Text->Click on Finish";
                                Session["lblMsg1"] = "Please convert you excel columns as Text. Followed by steps to all column one by one. Select column then click on Data Menu-> Click on Text To Columns->Click on Fixed->Click next 2 times->Select Text->Click on Finish";
                            }
                        }
                    }

                }

            }
            catch (Exception ex)
            {
                lblMsg1.Text = "Something went wrong, please try again after some time " + ex.StackTrace;
            }


        }
        if (!IsPostBack)
        {

            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));


            //fillgrid();

            if (Session["lblMsg1"] != null)
            {
                lblMsg1.Text = Convert.ToString(Session["lblMsg1"]);
                Session["lblMsg1"] = null;
            }
            else
            {
                lblMsg1.Text = "";
            }
        }
    }


    //private void fillgrid()
    //{

    //    DataSet ds = new DataSet();

    //    string qry = "select top(100) [Zone], [D_State], [DealerCode], [DealerTechnicianId], [D_Name], [DE_Designation], [D_Status] from m_dealermaster1 ";

    //    string fqry = qry;
    //    SQL_DB.GetDA(fqry).Fill(ds, "1");

    //    string cqry = "select count(1) from m_dealermaster1 ";
    //    SQL_DB.GetDA(cqry).Fill(ds, "2");

    //    Grdscrap.DataSource = ds.Tables["1"];
    //    Grdscrap.DataBind();

    //    lblcount.Text = ds.Tables["2"].Rows[0][0].ToString();

    //}

    protected void lnkDownload_Click(object sender, EventArgs e)
    {
        //getting datatable from viewstate  
        string query = "select top(1) [Zone], [D_State] as 'State', [DealerCode], [DealerTechnicianId] as 'TechnicianId', [D_Name] as 'Name', [DE_Designation] as 'Designation', [D_Status] as 'Status' from m_dealermaster";
        SqlCommand com = new SqlCommand(query, dtcon.OpenConnection());
        SqlDataAdapter da = new SqlDataAdapter(query, dtcon.OpenConnection());
        DataSet ds = new DataSet();
        da.Fill(ds);

        //calling create Excel File Method and ing dataTable   
        CreateExcelFile(ds.Tables[0]);
    }
    public void CreateExcelFile(DataTable Excel)
    {

        using (XLWorkbook wb = new XLWorkbook())
        {
            wb.Worksheets.Add(Excel, "DealerCode");

            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetxml.sheet";
            Response.AddHeader("content-disposition", "attachment;filename=DealerCode.xls");
            //Response.AddHeader("Redirect", "5; url=~/Manufacturer/ScrapcodeEntry.aspx");
            using (MemoryStream MyMemoryStream = new MemoryStream())
            {
                wb.SaveAs(MyMemoryStream);
                MyMemoryStream.WriteTo(Response.OutputStream);
                Response.Flush();
                Response.End();
            }

        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("select [Zone], [D_State] as 'State', [DealerCode], [DealerTechnicianId] as 'TechnicianId', [D_Name] as 'Name', [DE_Designation] as 'Designation', [D_Status] as 'Status' from m_dealermaster");
        XLWorkbook wb = new XLWorkbook();
        wb.Worksheets.Add(ds.Tables[0], "DealerCode");
        MemoryStream stream = new MemoryStream();
        wb.SaveAs(stream);
        //Return xlsx Excel File  

        Response.Clear();
        Response.ContentType = "application/force-download";
        Response.AddHeader("content-disposition", "attachment;    filename=DealerCode.xls");
        Response.BinaryWrite(stream.ToArray());
        Response.End();
    }

    private DataTable StripEmptyRows(DataTable dt)
    {
        List<int> rowIndexesToBeDeleted = new List<int>();
        int indexCount = 0;
        foreach (var row in dt.Rows)
        {
            var r = (DataRow)row;
            int emptyCount = 0;
            int itemArrayCount = r.ItemArray.Length;

            if (string.IsNullOrWhiteSpace(r.ItemArray[2].ToString()) || r.ItemArray[3] == null || r.ItemArray[3] == "" || r.ItemArray[5] == null || r.ItemArray[5] == "")
            {
                emptyCount++;
            }

            //    foreach (var i in r.ItemArray)
            //{
                
            //    if (string.IsNullOrWhiteSpace(i.ToString())) emptyCount++;
            //}

            if (emptyCount > 0) rowIndexesToBeDeleted.Add(indexCount);

            indexCount++;
        }

        int count = 0;
        foreach (var i in rowIndexesToBeDeleted)
        {
            dt.Rows.RemoveAt(i - count);
            count++;
        }

        return dt;
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        Session["lblMsg1"] = null;
        
        string path = string.Empty;

        try
        {
            DataTable dt = (DataTable)Session["dt"];
            Session["dt"] = null;
            if (dt.Rows.Count > 0)
            {
                DataRow[] dtrows = dt.Select("[DealerCode]='' or [DealerCode] is null OR [TechnicianId]='' OR [TechnicianId] is null or Designation='' or Designation is null or State='' or State is null or Status='' or Status is null");
                                
                var duplicates = dt.AsEnumerable().GroupBy(i => new { DealerCode = i.Field<string>("DealerCode"), TechnicianId = i.Field<string>("TechnicianId") }).Where(g => g.Count() > 1).Select(g => new { g.Key.DealerCode, g.Key.TechnicianId }).ToList();
                if (duplicates.Count > 0 || dtrows.Length > 0)
                {
                    if (hdncon.Value == "Yes")
                    {
                        //btnDisable();
                        DataTable dte = StripEmptyRows(dt);

                        DataTable dtnew = dte.DefaultView.ToTable(true, "DealerCode", "TechnicianId", "Zone", "State", "Name", "Designation", "Status");
                        dt = dtnew;
                        
                        StringBuilder stb = new StringBuilder();
                        stb.AppendLine("IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'm_dealermastertest') BEGIN drop table m_dealermastertest end");
                        //strQuery = "select count(1) from dbo.m_dealmastertest";
                        int x = SQL_DB.ExecuteNonQuery1(stb.ToString());

                        string strQuery = "select * into dbo.m_dealermastertest from dbo.m_dealermaster where 1=2";

                        x = SQL_DB.ExecuteInt32(strQuery);
                        //int x = SQL_DB.ExecuteNonQuery1(strQuery);

                        using (SqlConnection con = new SqlConnection(SQL_DB.ConnectionString))
                        {
                            using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                            {
                                //Set the database table name
                                sqlBulkCopy.DestinationTableName = "dbo.m_dealermastertest";

                                //[OPTIONAL]: Map the DataTable columns with that of the database table
                                sqlBulkCopy.ColumnMappings.Add("Zone", "Zone");
                                sqlBulkCopy.ColumnMappings.Add("State", "D_State");
                                sqlBulkCopy.ColumnMappings.Add("DealerCode", "DealerCode");
                                sqlBulkCopy.ColumnMappings.Add("TechnicianId", "DealerTechnicianId");
                                sqlBulkCopy.ColumnMappings.Add("Name", "D_Name");
                                sqlBulkCopy.ColumnMappings.Add("Designation", "DE_Designation");
                                sqlBulkCopy.ColumnMappings.Add("Status", "D_Status");
                                con.Open();
                                sqlBulkCopy.WriteToServer(dt);
                                con.Close();
                            }
                        }

                        strQuery = "select count(1) from dbo.m_dealermastertest";
                        x = Convert.ToInt32(SQL_DB.ExecuteScalar(strQuery).ToString());

                        if (dt.Rows.Count == x)
                        {
                            DataTable dtall = Data_9420.GetDealerData("select * from m_dealermastertest union SELECT a.* FROM m_dealermaster a WHERE a.DealerCode NOT IN ( SELECT det.DealerCode FROM m_dealermastertest det ) or a.DealerTechnicianId NOT IN ( SELECT det.DealerTechnicianId FROM m_dealermastertest det )");
                            //DataTable dtall = SQL_DB.ExecuteDataTable("select * from m_dealermastertest union SELECT a.* FROM m_dealermaster a WHERE a.DealerCode NOT IN ( SELECT det.DealerCode FROM m_dealermastertest det ) or a.DealerTechnicianId NOT IN ( SELECT det.DealerTechnicianId FROM m_dealermastertest det )");

                            if (dtall.Rows.Count > 0)
                            {
                                strQuery = "truncate table dbo.m_dealermastertest";
                                x = SQL_DB.ExecuteNonQuery1(strQuery);

                                using (SqlConnection con = new SqlConnection(SQL_DB.ConnectionString))
                                {
                                    using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                                    {
                                        //Set the database table name
                                        sqlBulkCopy.DestinationTableName = "dbo.m_dealermastertest";

                                        //[OPTIONAL]: Map the DataTable columns with that of the database table
                                        sqlBulkCopy.ColumnMappings.Add("Zone", "Zone");
                                        sqlBulkCopy.ColumnMappings.Add("D_State", "D_State");
                                        sqlBulkCopy.ColumnMappings.Add("DealerCode", "DealerCode");
                                        sqlBulkCopy.ColumnMappings.Add("DealerTechnicianId", "DealerTechnicianId");
                                        sqlBulkCopy.ColumnMappings.Add("D_Name", "D_Name");
                                        sqlBulkCopy.ColumnMappings.Add("DE_Designation", "DE_Designation");
                                        sqlBulkCopy.ColumnMappings.Add("D_Status", "D_Status");
                                        con.Open();
                                        sqlBulkCopy.WriteToServer(dtall);
                                        con.Close();
                                    }
                                }


                                string n = "m_dealermaster_" + System.DateTime.Now.ToShortDateString().Replace("/", "");
                                stb.Clear();
                                stb.AppendLine("IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'" + n + "') BEGIN drop table " + n + " end");
                                stb.AppendLine("EXEC sp_rename 'm_dealermaster', '" + n + "';");
                                stb.AppendLine("EXEC sp_rename 'm_dealermastertest', 'm_dealermaster';");
                                //strQuery = "select count(1) from dbo.m_dealmastertest";
                                x = SQL_DB.ExecuteNonQuery1(stb.ToString());

                                lblMsg1.Text = dt.Rows.Count + " Records uploaded";
                                Session["lblMsg1"] = dt.Rows.Count + " Records uploaded";

                            }
                        }
                        else
                        {
                            strQuery = "drop table dbo.m_dealermastertest";
                            x = SQL_DB.ExecuteNonQuery1(strQuery);

                            lblMsg1.Text = "Your File has not been uploaded. Please check and correct it !";
                            Session["lblMsg1"] = "Your File has bot been uploaded. Please check and correct it !";

                        }

                        hdncon.Value = "No";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "hideprogress()", true);
                        //btnEnable();
                    }
                    else
                    {
                        foreach (var dRow in duplicates)
                        {
                            DataRow[] dr = dt.Select("DealerCode='" + dRow.DealerCode + "' and TechnicianId='" + dRow.TechnicianId + "'");
                            DataRow dr1 = sb.NewRow();
                            dr1["zone"] = dr[0]["zone"];
                            dr1["State"] = dr[0]["State"];
                            dr1["DealerCode"] = dr[0]["DealerCode"];
                            dr1["TechnicianId"] = dr[0]["TechnicianId"];
                            dr1["Name"] = dr[0]["Name"];
                            dr1["Designation"] = dr[0]["Designation"];
                            dr1["Status"] = "Duplicate Row";
                            sb.Rows.Add(dr1);

                        }

                        for (int i = 0; i < dtrows.Count(); i++)
                        {
                            DataRow dr1 = sb.NewRow();
                            dr1["zone"] = dtrows[i]["zone"];
                            dr1["State"] = dtrows[i]["State"];
                            dr1["DealerCode"] = dtrows[i]["DealerCode"];
                            dr1["TechnicianId"] = dtrows[i]["TechnicianId"];
                            dr1["Name"] = dtrows[i]["Name"];
                            dr1["Designation"] = dtrows[i]["Designation"];
                            dr1["Status"] = "Invalid Record";
                            sb.Rows.Add(dr1);
                        }
                        Session["sb"] = sb;                        
                        CreateExcelFile(sb);
                    }

                }

               
            }

        }
        catch (Exception ex)
        {
            lblMsg1.Text = "Something went wrong, please try again after some time " + ex.StackTrace;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "hideprogress()", true);
        }

    }



    protected void btnsv_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dt=(DataTable)Session["dt"];
            Session["dt"] = null;
            StringBuilder stb = new StringBuilder();
            stb.AppendLine("IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'm_dealermastertest') BEGIN drop table m_dealermastertest end");
            //strQuery = "select count(1) from dbo.m_dealmastertest";
            int x = SQL_DB.ExecuteNonQuery1(stb.ToString());

            string strQuery = "select * into dbo.m_dealermastertest from dbo.m_dealermaster where 1=2";

            x = SQL_DB.ExecuteInt32(strQuery);

            using (SqlConnection con = new SqlConnection(SQL_DB.ConnectionString))
            {
                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                {
                    //Set the database table name
                    sqlBulkCopy.DestinationTableName = "dbo.m_dealermastertest";

                    //[OPTIONAL]: Map the DataTable columns with that of the database table
                    sqlBulkCopy.ColumnMappings.Add("Zone", "Zone");
                    sqlBulkCopy.ColumnMappings.Add("State", "D_State");
                    sqlBulkCopy.ColumnMappings.Add("DealerCode", "DealerCode");
                    sqlBulkCopy.ColumnMappings.Add("TechnicianId", "DealerTechnicianId");
                    sqlBulkCopy.ColumnMappings.Add("Name", "D_Name");
                    sqlBulkCopy.ColumnMappings.Add("Designation", "DE_Designation");
                    sqlBulkCopy.ColumnMappings.Add("Status", "D_Status");
                    con.Open();
                    sqlBulkCopy.WriteToServer(dt);
                    con.Close();
                }
            }

            strQuery = "select count(1) from dbo.m_dealermastertest";
            x = Convert.ToInt32(SQL_DB.ExecuteScalar(strQuery).ToString());

            if (dt.Rows.Count == x)
            {
                DataTable dtall = SQL_DB.ExecuteDataTable("select * from m_dealermastertest union SELECT a.* FROM m_dealermaster a WHERE a.DealerCode NOT IN ( SELECT det.DealerCode FROM m_dealermastertest det ) or a.DealerTechnicianId NOT IN ( SELECT det.DealerTechnicianId FROM m_dealermastertest det )");

                if (dtall.Rows.Count > 0)
                {
                    strQuery = "truncate table dbo.m_dealermastertest";
                    x = SQL_DB.ExecuteNonQuery1(strQuery);

                    using (SqlConnection con = new SqlConnection(SQL_DB.ConnectionString))
                    {
                        using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                        {
                            //Set the database table name
                            sqlBulkCopy.DestinationTableName = "dbo.m_dealermastertest";

                            //[OPTIONAL]: Map the DataTable columns with that of the database table
                            sqlBulkCopy.ColumnMappings.Add("Zone", "Zone");
                            sqlBulkCopy.ColumnMappings.Add("D_State", "D_State");
                            sqlBulkCopy.ColumnMappings.Add("DealerCode", "DealerCode");
                            sqlBulkCopy.ColumnMappings.Add("DealerTechnicianId", "DealerTechnicianId");
                            sqlBulkCopy.ColumnMappings.Add("D_Name", "D_Name");
                            sqlBulkCopy.ColumnMappings.Add("DE_Designation", "DE_Designation");
                            sqlBulkCopy.ColumnMappings.Add("D_Status", "D_Status");
                            con.Open();
                            sqlBulkCopy.WriteToServer(dtall);
                            con.Close();
                        }
                    }


                    string n = "m_dealermaster_" + System.DateTime.Now.ToShortDateString().Replace("/", "");
                    stb.Clear();
                    stb.AppendLine("IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'" + n + "') BEGIN drop table " + n + " end");
                    stb.AppendLine("EXEC sp_rename 'm_dealermaster', '" + n + "';");
                    stb.AppendLine("EXEC sp_rename 'm_dealermastertest', 'm_dealermaster';");
                    //strQuery = "select count(1) from dbo.m_dealmastertest";
                    x = SQL_DB.ExecuteNonQuery1(stb.ToString());

                    lblMsg1.Text = dt.Rows.Count + " Records uploaded";
                    Session["lblMsg1"] = dt.Rows.Count + " Records uploaded";
                    UpdateProgress1.Visible = false;
                }
            }
            else
            {
                strQuery = "drop table dbo.m_dealermastertest1";
                x = SQL_DB.ExecuteNonQuery1(strQuery);

                lblMsg1.Text = "File is not uploaded. Please check and correct it !";
                Session["lblMsg1"] = "File is not uploaded. Please check and correct it !";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "hideprogress()", true);
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
}