using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Business9420;
using System.IO;
using System.Data.OleDb;
using System.Text;
using ClosedXML.Excel;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;

public partial class FrmScrapEntry : System.Web.UI.Page
{
    public int ScrapeFlag = 0;
    public int index = 0;
    public Int32 sr = 0;
    private string GetValue(SpreadsheetDocument doc, Cell cell)
    {
        try
        {
            string value = "";
            if (cell.CellValue!= null)
            {
                value = cell.CellValue.InnerText.Trim(); ;
            }
            else
                return "";
            if (cell.DataType != null && cell.DataType.Value == CellValues.SharedString)
            {
                return doc.WorkbookPart.SharedStringTablePart.SharedStringTable.ChildElements.GetItem(int.Parse(value)).InnerText;
            }
            return value;
        }
        catch (ArgumentNullException)
        {
            return "";
        }
        

    }








 protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("../Info/Login.aspx?Page=FrmScrapEntry.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        sb.Columns.Add("Code");
        int uploadcnt = 0;
        int readcount=0;
        string path = string.Empty;
        if (IsPostBack)
        {
            try
            {
                HttpPostedFile filePosted = Request.Files["ctl00$ContentPlaceHolder1$codesupload"];
                if (filePosted != null)
                {

                    if (filePosted.ContentLength > 0)
                    {

                        Session["lblMsg1"] = null;
                        Session["sb"] = null;

                        var fileName = Path.GetFileNameWithoutExtension(filePosted.FileName);
                        var fileExtn = Path.GetExtension(filePosted.FileName);

                        path = Path.Combine(Server.MapPath("~/Data/"), fileName + fileExtn);
                        //path = Path.Combine(Server.MapPath("~/images/Transactions/"), fileName + fileExtn);
                        filePosted.SaveAs(path);



                        DataTable dt = new DataTable();
                        if (fileExtn == ".xlsx" || fileExtn == ".xls")
                        {

                            using (SpreadsheetDocument doc = SpreadsheetDocument.Open(path, true))
                            {
                                //Read the first Sheet from Excel file.
                                Sheet sheet = doc.WorkbookPart.Workbook.Sheets.GetFirstChild<Sheet>();

                                //Get the Worksheet instance.
                                Worksheet worksheet = (doc.WorkbookPart.GetPartById(sheet.Id.Value) as WorksheetPart).Worksheet;

                                //Fetch all the rows present in the Worksheet.
                                IEnumerable<Row> rows = worksheet.GetFirstChild<SheetData>().Descendants<Row>();

                                //Create a new DataTable.


                                //Loop through the Worksheet rows.
                                foreach (Row row in rows)
                                {
                                    //Use the first row to add columns to DataTable.
                                    if (row.RowIndex.Value == 1)
                                    {
                                        foreach (Cell cell in row.Descendants<Cell>())
                                        {
                                            string value = GetValue(doc, cell);
                                            if (value != "")
                                                dt.Columns.Add(value);
                                            else
                                                break;
                                        }
                                    }
                                    else
                                    {
                                        //Add rows to DataTable.
                                        dt.Rows.Add();
                                        int i = 0;
                                        foreach (Cell cell in row.Descendants<Cell>())
                                        {
                                            string value = GetValue(doc, cell);
                                            if (value != "")
                                            {
                                                dt.Rows[dt.Rows.Count - 1][i] = value;
                                                i++;
                                                readcount++;
                                            }
                                            else
                                            {
                                                break;
                                            }
                                        }
                                    }
                                }
                            }


                            //DataTable sheet1 = new DataTable();
                            //OleDbConnectionStringBuilder csbuilder = new OleDbConnectionStringBuilder();
                            //csbuilder.Provider = "Microsoft.ACE.OLEDB.12.0";
                            //csbuilder.DataSource = path;
                            ////csbuilder.Add("Extended Properties", "Excel 12.0 Xml;HDR=YES");
                            //csbuilder.Add("Extended Properties", "Excel 12.0 Xml;HDR=YES;IMEX=1;");
                            ////string selectSql = @"SELECT * FROM [Sheet1$]";
                            //string selectSql = @"SELECT * FROM [ScrapEntry$]";
                            //using (OleDbConnection connection = new OleDbConnection(csbuilder.ConnectionString))
                            //using (OleDbDataAdapter adapter = new OleDbDataAdapter(selectSql, connection))
                            //{
                            //    connection.Open();
                            //    adapter.Fill(sheet1);

                            if (dt.Rows.Count > 0)
                            {
                                string code1 = string.Empty, code2 = string.Empty, company_id = string.Empty;
                                DateTime entry_Date = DateTime.Now;


                                string currDate = Convert.ToString(System.DateTime.Now).ToString();

                                for (int i = 0; dt.Rows.Count > i; i++)
                                {
                                    if (dt.Rows[i].ItemArray.GetValue(0).ToString() != "")
                                    {
                                        code1 = dt.Rows[i].ItemArray.GetValue(0).ToString().Substring(0, 5);
                                        code2 = dt.Rows[i].ItemArray.GetValue(0).ToString().Substring(5, 8);
                                    }
                                    else
                                    {
                                        code1 = null;
                                        code2 = null;
                                    }

                                    if (!string.IsNullOrEmpty(code1))
                                    {
                                        //string strQuery = "INSERT INTO scrap_entry (code1,code2,loyalty,comp_id,entry_date) select code1,code2,loyalty,comp_id, GETDATE() from m_code_loyalty m_code inner join Pro_Reg pr on pr.pro_id=m_code.pro_id  WHERE NOT EXISTS(SELECT Scrap_id  FROM scrap_entry WHERE code1=" + code1 + " and code2=" + code2 + ") and code1=" + code1 + " and code2=" + code2;
                                        //string strQuery = "INSERT INTO scrap_entry (code1,code2,loyalty,comp_id,entry_date) select distinct ml.code1,ml.code2,case when trans.AmtType='Random' then ml.loyalty else case when ms.Service_ID='SRV1005' or ms.Service_ID='SRV1024' then trans.IsCash else trans.Points end end ,pr.comp_id, GETDATE() from m_code_loyalty ml inner join m_code mc on mc.Code1=ml.code1 and ml.code2=mc.Code2 inner join Pro_Reg pr on pr.pro_id=mc.pro_id     left join M_ServiceSubscription ms on ms.Pro_ID=pr.pro_id and ms.comp_id=pr.comp_id left join M_ServiceSubscriptionTrans trans on trans.Subscribe_Id=ms.Subscribe_Id  WHERE NOT EXISTS(SELECT Scrap_id  FROM scrap_entry WHERE code1=" + code1 + " and code2=" + code2 + ") and mc.code1=" + code1 + " and mc.code2=" + code2;
                                        int x = Convert.ToInt32(ServiceLogic.insertscrap(code1, code2, Session["CompanyId"].ToString()));

                                        //int x = SQL_DB.ExecuteInt32(strQuery);
                                        //int x = SQL_DB.ExecuteNonQuery1(strQuery);
                                        if (x == 0)
                                        {
                                            DataRow dr = sb.NewRow();
                                            dr["code"] = code1+code2;
                                            
                                            sb.Rows.Add(dr);
                                        }
                                        else
                                        {
                                            uploadcnt++;
                                        }
                                    }
                                }
                                if (uploadcnt ==0&& readcount==0)
                                {
                                    lblMsg1.Text = "FIle do not have data in it";
                                    Session["lblMsg1"] = "FIle do not have data in it";
                                }
                                else if(uploadcnt == 0 && readcount != 0)
                                {
                                    lblMsg1.Text = "Uploaded codes are not valid or already in return records.";
                                    Session["lblMsg1"] = "Uploaded codes are not valid or already in return records.";
                                }
                                else if(readcount!=0 && sb.Rows.Count==0)
                                {
                                    lblMsg1.Text = (sb.Rows.Count + uploadcnt).ToString() + " records  found " + uploadcnt + " uploaded successfully!";

                                    Session["lblMsg1"] = (sb.Rows.Count + uploadcnt).ToString() + " records  found, " + uploadcnt + " uploaded successfully!";


                                }
                                else
                                {
                                    lblMsg1.Text = "Out of " + (sb.Rows.Count+uploadcnt).ToString()+ ", " + uploadcnt + " Record uploaded successfully!  Records " + sb.Rows.Count + " record/s are in incorrect format/ may be not registered with us/ already uploaded(refer the auto downloaded file of " + sb.Rows.Count + " record) ";
                             
                                    Session["lblMsg1"] = "Out of " + (sb.Rows.Count + uploadcnt).ToString() + ", " + uploadcnt + " Record uploaded successfully!  Records " + sb.Rows.Count + " record/s are in incorrect format/ may be not registered with us/ already uploaded(refer the auto downloaded file of " + sb.Rows.Count + " record) ";
                                }
                            }
                            //}
                        }
                    }
                    //else
                    //{
                    //    lblMsg1.Text = "Please Select a File first.";
                    //    Session["lblMsg1"] = "Please Select a File first.";
                    //}
                }

                if (sb.Rows.Count > 0)
                {
                    lblMsg1.Text = "Out of " + (sb.Rows.Count + uploadcnt).ToString() + ", " + uploadcnt + " Record uploaded successfully!  Records " + sb.Rows.Count + " record/s are in incorrect format/ may be not registered with us/ already uploaded(refer the auto downloaded file of " + sb.Rows.Count + " record) ";

                    Session["lblMsg1"] = "Out of " + (sb.Rows.Count + uploadcnt).ToString() + ", " + uploadcnt + " Record uploaded successfully!  Records " + sb.Rows.Count + " record/s are in incorrect format/ may be not registered with us/ already uploaded(refer the auto downloaded file of " + sb.Rows.Count + " record) ";

                    //string msg = "Some Records are may be not registered with us OR these can be already Registered. for more details kindly check Downloaded file!";
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                    //Response.Write("<script langauge=\"javascript\">toastr.success(Some Records are may be not registered with us OR these can be already Registered. for more details kindly check Downloaded file!);</script>");
                    //Session["lblMsg1"] = "Uploaded codes are not valid or already in return records …..";

                    //lblMsg1.Text = "Uploaded codes are not valid or already in return records …..";
                    //CreateExcelFile(sb);
                    Session["sb"] = sb;
                }
            }
            catch (Exception ex)
            {
                lblMsg1.Text = "File uploaded is in incorrect format , kindly download and  refer  the Sample file";
            }

            finally
            {
                fillgrid();

                if (Session["sb"] != null)
                {
                    Timer1.Enabled = true;
                }
                else
                {
                    Timer1.Enabled = false;
                }
            }
        }
        if (!IsPostBack)
        {

            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));

            //Clear();
            //if (Request.QueryString["P"] != null)
            //{
            //    ddlProduct.SelectedValue = Request.QueryString["P"].ToString();
            //    txtscrapfrom.Text = Request.QueryString["S1"].ToString();
            //    txtscrapto.Text = Request.QueryString["S2"].ToString();
            //}
            fillgrid();

            if (Session["lblMsg1"] != null)
            {
                lblMsg1.Text = Convert.ToString(Session["lblMsg1"]);
                Session["lblMsg1"] = null;
            }
            else
            {
                lblMsg1.Text = "";
            }

            if (Session["sb"] != null)
            {
                Timer1.Enabled = true;
            }
        }
    }


    //protected void Page_Load(object sender, EventArgs e)
    //{
    //    if (Session["User_Type"] == null)
    //        Response.Redirect("../Info/Login.aspx?Page=FrmScrapEntry.aspx");
    //    else
    //    {
    //        if (Session["User_Type"].ToString() == "Admin")
    //            Response.Redirect("Login.aspx");
    //    }
    //    sb.Columns.Add("Code1");
    //    sb.Columns.Add("Code2");
    //    string path = string.Empty;
    //    if (IsPostBack)
    //    {
    //        try
    //        {
    //            HttpPostedFile filePosted = Request.Files["ctl00$ContentPlaceHolder1$codesupload"];
    //            if (filePosted != null)
    //            {

    //                if (filePosted.ContentLength > 0)
    //                {

    //                    Session["lblMsg1"] = null;
    //                    Session["sb"] = null;

    //                    var fileName = Path.GetFileNameWithoutExtension(filePosted.FileName);
    //                    var fileExtn = Path.GetExtension(filePosted.FileName);

    //                    path = Path.Combine(Server.MapPath("~/Data/"), fileName + fileExtn);
    //                    //path = Path.Combine(Server.MapPath("~/images/Transactions/"), fileName + fileExtn);
    //                    filePosted.SaveAs(path);



    //                    DataTable dt = new DataTable();
    //                    if (fileExtn == ".xlsx" || fileExtn == ".xls")
    //                    {

    //                        using (SpreadsheetDocument doc = SpreadsheetDocument.Open(path, true))
    //                        {
    //                            //Read the first Sheet from Excel file.
    //                            Sheet sheet = doc.WorkbookPart.Workbook.Sheets.GetFirstChild<Sheet>();

    //                            //Get the Worksheet instance.
    //                            Worksheet worksheet = (doc.WorkbookPart.GetPartById(sheet.Id.Value) as WorksheetPart).Worksheet;

    //                            //Fetch all the rows present in the Worksheet.
    //                            IEnumerable<Row> rows = worksheet.GetFirstChild<SheetData>().Descendants<Row>();

    //                            //Create a new DataTable.


    //                            //Loop through the Worksheet rows.
    //                            foreach (Row row in rows)
    //                            {
    //                                //Use the first row to add columns to DataTable.
    //                                if (row.RowIndex.Value == 1)
    //                                {
    //                                    foreach (Cell cell in row.Descendants<Cell>())
    //                                    {
    //                                        dt.Columns.Add(GetValue(doc, cell));
    //                                    }
    //                                }
    //                                else
    //                                {
    //                                    //Add rows to DataTable.
    //                                    dt.Rows.Add();
    //                                    int i = 0;
    //                                    foreach (Cell cell in row.Descendants<Cell>())
    //                                    {
    //                                        dt.Rows[dt.Rows.Count - 1][i] = GetValue(doc, cell);
    //                                        i++;
    //                                    }
    //                                }
    //                            }
    //                        }


    //                        //DataTable sheet1 = new DataTable();
    //                        //OleDbConnectionStringBuilder csbuilder = new OleDbConnectionStringBuilder();
    //                        //csbuilder.Provider = "Microsoft.ACE.OLEDB.12.0";
    //                        //csbuilder.DataSource = path;
    //                        ////csbuilder.Add("Extended Properties", "Excel 12.0 Xml;HDR=YES");
    //                        //csbuilder.Add("Extended Properties", "Excel 12.0 Xml;HDR=YES;IMEX=1;");
    //                        ////string selectSql = @"SELECT * FROM [Sheet1$]";
    //                        //string selectSql = @"SELECT * FROM [ScrapEntry$]";
    //                        //using (OleDbConnection connection = new OleDbConnection(csbuilder.ConnectionString))
    //                        //using (OleDbDataAdapter adapter = new OleDbDataAdapter(selectSql, connection))
    //                        //{
    //                        //    connection.Open();
    //                        //    adapter.Fill(sheet1);

    //                        if (dt.Rows.Count > 0)
    //                        {
    //                            string code1 = string.Empty, code2 = string.Empty, company_id = string.Empty;
    //                            DateTime entry_Date = DateTime.Now;


    //                            string currDate = Convert.ToString(System.DateTime.Now).ToString();

    //                            for (int i = 0; dt.Rows.Count > i; i++)
    //                            {
    //                                if (dt.Rows[i].ItemArray.GetValue(0).ToString() != "")
    //                                {
    //                                    code1 = dt.Rows[i].ItemArray.GetValue(0).ToString().Substring(0, 5);
    //                                    code2 = dt.Rows[i].ItemArray.GetValue(0).ToString().Substring(5, 8);
    //                                }
    //                                else
    //                                {
    //                                    code1 = null;
    //                                    code2 = null;
    //                                }

    //                                //if (dt.Rows[i].ItemArray.GetValue(1).ToString() != "")
    //                                //    code2 = dt.Rows[i].ItemArray.GetValue(1).ToString();
    //                                //else
    //                                //    code2 = null;

    //                                if (!string.IsNullOrEmpty(code1))
    //                                {
    //                                    //string strQuery = "INSERT INTO scrap_entry (code1,code2,loyalty,comp_id,entry_date) select code1,code2,loyalty,comp_id, GETDATE() from m_code_loyalty m_code inner join Pro_Reg pr on pr.pro_id=m_code.pro_id  WHERE NOT EXISTS(SELECT Scrap_id  FROM scrap_entry WHERE code1=" + code1 + " and code2=" + code2 + ") and code1=" + code1 + " and code2=" + code2;
    //                                    string strQuery = "INSERT INTO scrap_entry (code1,code2,loyalty,comp_id,entry_date) select distinct ml.code1,ml.code2,case when trans.AmtType='Random' then ml.loyalty else case when ms.Service_ID='SRV1005' or ms.Service_ID='SRV1024' then trans.IsCash else trans.Points end end ,pr.comp_id, GETDATE() from m_code_loyalty ml inner join m_code mc on mc.Code1=ml.code1 and ml.code2=mc.Code2 inner join Pro_Reg pr on pr.pro_id=mc.pro_id     left join M_ServiceSubscription ms on ms.Pro_ID=pr.pro_id and ms.comp_id=pr.comp_id left join M_ServiceSubscriptionTrans trans on trans.Subscribe_Id=ms.Subscribe_Id  WHERE NOT EXISTS(SELECT Scrap_id  FROM scrap_entry WHERE code1=" + code1 + " and code2=" + code2 + ") and mc.code1=" + code1 + " and mc.code2=" + code2;

    //                                    //int x = SQL_DB.ExecuteInt32(strQuery);
    //                                    int x = SQL_DB.ExecuteNonQuery1(strQuery);
    //                                    if (x == 0)
    //                                    {
    //                                        DataRow dr = sb.NewRow();
    //                                        dr["code1"] = code1;
    //                                        dr["code2"] = code2;
    //                                        sb.Rows.Add(dr);
    //                                    }
    //                                }
    //                            }

    //                            lblMsg1.Text = "Your File has been uploaded successfully";
    //                            Session["lblMsg1"] = "Your File has been uploaded successfully";
    //                        }
    //                        //}
    //                    }
    //                }
    //                //else
    //                //{
    //                //    if (Session["lblMsg1"] != null)
    //                //    {
    //                //        lblMsg1.Text = Session["lblMsg1"].ToString();
    //                //        Session["lblMsg1"] = null;
    //                //    }
    //                //    else
    //                //    {
    //                //        lblMsg1.Text = "Please Select a File first.";
    //                //        Session["lblMsg1"] = "Please Select a File first.";
    //                //    }
    //                //}
    //            }

    //            if (sb.Rows.Count > 0)
    //            {
    //                //string msg = "Some Records are may be not registered with us OR these can be already Registered. for more details kindly check Downloaded file!";
    //                //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
    //                //Response.Write("<script langauge=\"javascript\">toastr.success(Some Records are may be not registered with us OR these can be already Registered. for more details kindly check Downloaded file!);</script>");
    //                Session["lblMsg1"] = "Some Records are may be not registered with us OR these can be already Registered. for more details kindly check Downloaded file.";

    //                //lblMsg1.Text = "Some Records are may be not registered with us OR these can be already Registered. for more details kindly check Downloaded file.";
    //                //CreateExcelFile(sb);
    //                Session["sb"] = sb;
    //            }
    //        }
    //        catch (Exception ex)
    //        {
    //            lblMsg1.Text = "Something went wrong, please try again after some time " + ex.StackTrace;
    //        }

    //        finally
    //        {
    //            if (Session["sb"] != null)
    //            {
    //                Timer1.Enabled = true;
    //            }
    //            else
    //            {
    //                Timer1.Enabled = false;
    //            }
    //        }
    //    }
    //    if (!IsPostBack)
    //    {

    //        if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
    //            Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));

    //        //Clear();
    //        //if (Request.QueryString["P"] != null)
    //        //{
    //        //    ddlProduct.SelectedValue = Request.QueryString["P"].ToString();
    //        //    txtscrapfrom.Text = Request.QueryString["S1"].ToString();
    //        //    txtscrapto.Text = Request.QueryString["S2"].ToString();
    //        //}
    //        fillgrid();

    //        if (Session["lblMsg1"] != null)
    //        {
    //            lblMsg1.Text = Convert.ToString(Session["lblMsg1"]);
    //            Session["lblMsg1"] = null;
    //        }
    //        else
    //        {
    //            lblMsg1.Text = "";
    //        }

    //        if (Session["sb"] != null)
    //        {
    //            Timer1.Enabled = true;
    //        }
    //    }
    //}


    //private void FillReason()
    //{
    //    DataSet ds = function9420.GetReason(Session["User_Type"]);
    //    ddlreason.DataSource = ds.Tables[0];
    //    ddlreason.DataTextField = "Reason";
    //    ddlreason.DataValueField = "Reason_ID";
    //    ddlreason.DataBind();
    //    ddlreason.Items.Insert(0, "--Select--");
    //    ddlreason.SelectedIndex = 0;
    //    txtreasonremarks.Text = string.Empty;
    //}
    //private void ScrapEntry(int reasonid)
    //{
    //    if (hidden1.Value != null)//(Request.Form["chkselect"] != null)
    //    {
    //        string[] Arr = hidden1.Value.ToString().Split(',');
    //        for (int i = 0; i < Arr.Length; i++)
    //        {
    //            DataSet ds = new DataSet();
    //            string updateqry = null;
    //            string[] str = Arr[i].Split('-');
    //            string pro = str[0].ToString();
    //            Int32 series_order = Convert.ToInt32(str[1]);
    //            Int32 series_serial = Convert.ToInt32(str[2]);
    //            string Qry = "SELECT isnull([Batch_No],0) AS BT FROM [M_Code] WHERE Pro_Id='" + pro + "' and [Series_Order]=" + series_order + " and [Series_Serial]=" + series_serial;// and ScrapeFlag=0
    //            string batch = null;
    //            SQL_DB.GetDA(Qry).Fill(ds, "1");//[Batch_No] = null ,
    //            if (ds.Tables["1"].Rows.Count > 0)
    //                batch = ds.Tables["1"].Rows[0]["BT"].ToString();
    //            else
    //                batch = "0";
    //            string Serial_Code = pro + "-" + string.Format("{0:00}", Convert.ToInt32(series_order)) + "-" + string.Format("{0:000}", series_serial);
    //            updateqry = "UPDATE [M_Code] SET [ScrapeFlag] = " + Convert.ToInt32(reasonid) + " WHERE Pro_ID='" + ddlProduct.SelectedValue + "'  and Print_Status=1 and Series_Order=" + series_order + "  and Series_Serial=" + series_serial + "";
    //            SQL_DB.ExecuteNonQuery(updateqry);
    //            string qry = "INSERT INTO [Scrap_Label]([Comp_ID],[Pro_ID] ,[Batch_No] ,[Serial_Code] )VALUES('" + Session["CompanyId"].ToString() + "','" + ddlProduct.SelectedValue + "','" + batch + "','" + Arr[i].ToString() + "')";
    //            string Qry1 = "SELECT * FROM Scrap_Label WHERE (Serial_Code = '" + Serial_Code + "') ";
    //            string Qry2 = "DELETE FROM [Scrap_Label] WHERE (Serial_Code = '" + Serial_Code + "') ";
    //            SQL_DB.GetDA(Qry1).Fill(ds, "2");//[Batch_No] = null ,
    //            if (ds.Tables["2"].Rows.Count > 0)
    //            {
    //                if (reasonid.ToString() == "0")
    //                    SQL_DB.ExecuteNonQuery(Qry2);
    //            }
    //            else
    //            {
    //                if (reasonid.ToString() != "0")
    //                    SQL_DB.ExecuteNonQuery(qry);
    //            }

    //            fillgrid();
    //            LblMsg.Text = Convert.ToString(Arr.Length) + " Rows Updated";
    //        }
    //    }
    //    else
    //        LblMsg.Text = "no row selected";
    //    fillgrid();
    //}

    //protected void btnYesScrap_Click(object sender, EventArgs e)
    //{
    ////    if (hidden1.Value != null)
    ////        ScrapEntry(Convert.ToInt32(ddlreason.SelectedValue));
    ////    else
    ////    {
    ////        LblMsg.Text = "No row selected";
    ////        LblMsg.ForeColor = System.Drawing.Color.Red;
    ////        LblMsg.Font.Bold = true;
    ////        hidden1.Value = string.Empty;
    ////    }
    //}
    //protected void btnNoScrap_Click(object sender, EventArgs e)
    //{

    //}
    //protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    //{
    //    fillgrid();
    //}

    //private void fillProduct()
    //{
    //    //DataSet ds = new DataSet();
    //    //Object9420 Reg = new Object9420();
    //    //Reg.Comp_ID = Session["CompanyId"].ToString();
    //    //Reg.Status = 1;
    //    //ds = function9420.FillProddlSearch(Reg);
    //    //DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProduct, "--Select--");
    //    //ddlProduct.SelectedIndex = 0;
    //}

    private void fillgrid()
    {
       
        DataSet ds = new DataSet();
        #region Commented Code Old For Only Batch Purpose
        string qry = "select top 100 se.Scrap_id,CONCAT(se.code1,se.code2) Complete,loyalty,se.entry_date,right(pe.MobileNo,10) mobileno,pr.pro_name from scrap_entry se left join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2  and pe.Is_Success=1 left join M_Code mc on mc.Code1=cast(se.code1 as int) and mc.Code2=cast(se.code2 as int) left join Pro_Reg pr on pr.pro_id=mc.Pro_ID where pr.comp_id='"+ Session["CompanyId"].ToString() + "' order by se.entry_date desc";
        #endregion


        string fqry = qry;
        SQL_DB.GetDA(fqry).Fill(ds, "1");
        //Session["GrdVwFilter"] = (DataView)ds.Tables["1"].DefaultView;
        //DataView dv = new DataView();
        //dv = ds.Tables["1"].DefaultView;
       // dv.RowFilter = "ReceiveFlag = 1";
        //DataTable dt = new DataTable();
        ////dt = dv.ToTable();
        //dt = ds.Tables["1"];
        //Session["GrdData"] = (DataTable)dt;
        //if (ddlProduct.SelectedValue.ToString() == "--Select--")
        //    dt.Clear();
        //if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        //{
        //    if (dt.Rows.Count > 0)
        //        Grdscrap.PageSize = dt.Rows.Count;
        //}
        //else
        //    Grdscrap.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        Grdscrap.DataSource = ds.Tables["1"];
        Grdscrap.DataBind();
        //if (dt.Rows.Count > 0)
        //{
        lblcount.Text = ds.Tables["1"].Rows.Count.ToString();
        //    lblC.Text = Grdscrap.Rows.Count.ToString();
        //    DataView dv1 = new DataView();
        //    dv1 = (DataView)Session["GrdVwFilter"];
        //    //dv1.RowFilter = "ReceiveFlag = 0";
        //    DataTable dt1 = new DataTable();
        //    dt1 = dv1.ToTable();
        //    if (dt1.Rows.Count > 0)
        //        Labeldispath.Text = dt1.Rows.Count.ToString();
        //    else
        //        Labeldispath.Text = "0";
        //}
        //else
        //{
        //    lblcount.Text = "0";
        //    Labeldispath.Text = "0";
        //}
        // Grdscrap.PageIndex = 0;
        //FillGridColor();
    }
    //protected void ddlbatchno_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    //fillgrid();
    //}
    //private void Clear()
    //{
    //    fillProduct();
    //}
    //protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
    //{

    //}
    //protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    //LblMsg.Text = "";
    //    //txtscrapfrom.Text = "";
    //    //txtscrapto.Text = "";
    //    //fillgrid();
    //}
    //protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    //{
    //    //txtscrapfrom.Text = ""; txtscrapto.Text = ""; fillProduct();
    //    //LblMsg.Text = "";
    //    //fillgrid();
    //}
    //protected void Grdscrap_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    Grdscrap.PageIndex = e.NewPageIndex;
    //    fillgrid();
    //}
    //protected void ddlRowProductCnt_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Grdscrap.SelectedIndex = 0;
    //    fillgrid();
    //}
    private void FillGridColor()
    {
        for (int i = 0; i < Grdscrap.Rows.Count; i++)
        {
            if (Grdscrap.DataKeys[i]["ff"].ToString() == "-1") // Scrap Labels
            {
                System.Drawing.Color col = System.Drawing.ColorTranslator.FromHtml("#fbe3e4");
                Grdscrap.Rows[i].BackColor = col;
            }
            else if (Grdscrap.DataKeys[i]["ff"].ToString() == "1") // Available Labels
            {
                System.Drawing.Color col = System.Drawing.ColorTranslator.FromHtml("#c7efc8");
                Grdscrap.Rows[i].BackColor = col;
            }
            else if (Grdscrap.DataKeys[i]["ff"].ToString() == "0") // Used Labels
            {
                System.Drawing.Color col = System.Drawing.Color.LightYellow;
                Grdscrap.Rows[i].BackColor = col;
            }
            else if (Grdscrap.DataKeys[i]["ff"].ToString() == "4") // Admin Scrap Labels
            {
                System.Drawing.Color col = System.Drawing.ColorTranslator.FromHtml("#C0C7D7");
                Grdscrap.Rows[i].BackColor = col;
            }
            else if (Grdscrap.DataKeys[i]["ff"].ToString() == "6") // Courier Receive Time Scrap Labels
            {
                System.Drawing.Color col = System.Drawing.ColorTranslator.FromHtml("#FFFFFF");
                Grdscrap.Rows[i].BackColor = col;
            }
            else if (Grdscrap.DataKeys[i]["ff"].ToString() == "5") // Scrap Labels
            {
                System.Drawing.Color col = System.Drawing.ColorTranslator.FromHtml("#fbe3e4");
                Grdscrap.Rows[i].BackColor = col;
            }

        }
    }

    #region Filter According To Status
    private void RowFilterGridData(string str)
    {
        LblMsg.Text = string.Empty;
        DataTable dt = (DataTable)Session["GrdData"];
        DataView dataview = dt.DefaultView;
        dataview.RowFilter = "FF = " + str;
        DataTable dt1 = dataview.ToTable();
        if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        {
            if (dt1.Rows.Count > 0)
                Grdscrap.PageSize = dt1.Rows.Count;
        }
        else
            Grdscrap.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        Grdscrap.DataSource = dt1;
        Grdscrap.DataBind();
        if (dt1.Rows.Count > 0)
        {
            lblcount.Text = dt1.Rows.Count.ToString();
            lblC.Text = Grdscrap.Rows.Count.ToString();
        }
        else lblcount.Text = "0";

        FillGridColor();
    }
    protected void btnAdminscrap_Click(object sender, EventArgs e)
    {
        RowFilterGridData("4");
    }
    protected void btnCourierRescrap_Click(object sender, EventArgs e)
    {
        RowFilterGridData("6");
    }
    protected void btnUsed_Click(object sender, EventArgs e)
    {
        RowFilterGridData("0");
    }
    protected void btnAvailable_Click(object sender, EventArgs e)
    {
        RowFilterGridData("1");
    }
    protected void btnScrap_Click(object sender, EventArgs e)
    {
        LblMsg.Text = string.Empty;
        DataTable dt = (DataTable)Session["GrdData"];
        DataView dataview = dt.DefaultView;
        dataview.RowFilter = "FF = -1 OR FF = 5";
        DataTable dt1 = dataview.ToTable();
        if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        {
            if (dt1.Rows.Count > 0)
                Grdscrap.PageSize = dt1.Rows.Count;
        }
        else
            Grdscrap.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        Grdscrap.DataSource = dt1;
        Grdscrap.DataBind();
        if (dt1.Rows.Count > 0)
        {
            lblcount.Text = dt1.Rows.Count.ToString();
            lblC.Text = Grdscrap.Rows.Count.ToString();
        }
        else lblcount.Text = "0";

        FillGridColor();
    }
    #endregion
    DataTable sb = new DataTable();

    //protected void btnsubmit_Click(object sender, EventArgs e)
    //{
       
    //}

    protected void lnkDownload_Click(object sender, EventArgs e)
    {
        //getting datatable from viewstate  
        string query = "select concat(code1,code2) code from scrap_entry where 1=2";//not recommended this i have written just for example,write stored procedure for security  
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
        //Response.ClearContent();
        //Adds HTTP header to the output stream  
        //Response.AddHeader("content-disposition", string.Format("attachment; filename=ScrapEntry.xls"));
        //Response.AddHeader("Redirect", "5; url=~/Manufacturer/ScrapcodeEntry.aspx");

        // Gets or sets the HTTP MIME type of the output stream  
        //Response.ContentType = "application/vnd.ms-excel";
        //string space = "";

        //foreach (DataColumn dcolumn in Excel.Columns)
        //{
        //    Response.Write(space + dcolumn.ColumnName);
        //    space = "\t";
        //}
        //Response.Write("\n");
        //int countcolumn;
        //foreach (DataRow dr in Excel.Rows)
        //{
        //    space = "";
        //    for (countcolumn = 0; countcolumn < Excel.Columns.Count; countcolumn++)
        //    {
        //        Response.Write(space + dr[countcolumn].ToString());
        //        space = "\t";
        //    }
        //    Response.Write("\n");
        //}
        //Response.End();
        using (XLWorkbook wb = new XLWorkbook())
        {
            wb.Worksheets.Add(Excel, "ScrapEntry");

            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetxml.sheet";
            Response.AddHeader("content-disposition", "attachment;filename=ScrapEntry.xls");
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
        DataSet ds = SQL_DB.ExecuteDataSet("select se.Scrap_id,CONCAT(se.code1,se.code2) Complete_Code,loyalty,pr.pro_name Product,right(pe.MobileNo,10) Mobile_No,se.entry_date from scrap_entry se left join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2  and pe.Is_Success=1 left join M_Code mc on mc.Code1=cast(se.code1 as int) and mc.Code2=cast(se.code2 as int) left join Pro_Reg pr on pr.pro_id=mc.Pro_ID where pr.comp_id='" + Session["CompanyId"].ToString() + "' order by se.entry_date desc");
        XLWorkbook wb = new XLWorkbook();
        ds.Tables[0].Columns.Remove("Scrap_id");
     wb.Worksheets.Add(ds.Tables[0], "Scrap_entry");

        MemoryStream stream = new MemoryStream();
        wb.SaveAs(stream);
        //Return xlsx Excel File  

        Response.Clear();
        Response.ContentType = "application/force-download";
        Response.AddHeader("content-disposition", "attachment;    filename=Scrap_entry.xls");
        Response.BinaryWrite(stream.ToArray());
        Response.End();
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        if (Session["sb"] != null)
        {
            DataTable sb1 = Session["sb"] as DataTable;
            Session["sb"] = null;
            CreateExcelFile(sb1);
            Timer1.Enabled = false;
        }
    }
}