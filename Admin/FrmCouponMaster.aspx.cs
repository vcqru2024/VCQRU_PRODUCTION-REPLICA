using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Business9420;
using System.Web.Services;
using System.Web.Script.Services;
using System.IO;
using System.Data.OleDb;
using Data9420;
//using Microsoft.Office.Interop.Excel;

public partial class FrmCouponMaster : System.Web.UI.Page
{
    public OleDbConnection oledbCon = new OleDbConnection();
    public OleDbCommand oledbCmd = new OleDbCommand();
    public int Flag = 0, index = 0, sno = 1; public Int64 UsedCodes = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmCouponMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!Page.IsPostBack)
        {
            lblmsgHeader.Text = "";
            FillGrid();
        }
    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewLabel(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [CouponProviderName] FROM [M_CouponProvider] WHERE  [CouponProviderName]  = '" + res + "' ");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        Clear();
        newMsg.Visible = false; DivNewMsg.Visible = false;
        ModalPopupExtenderNewDesign.Show();
    }
    private void Clear()
    {
        Fillddl();
        dhnactiontype.Value = string.Empty;
        txtName.Text = "";
        lblAddCourierHeader.Text = "Add New Coupon";
        btnSubmit.Text = "Save";
    }
    private void Fillddl()
    {
        DataSet ds = new DataSet();
        ds = SQL_DB.ExecuteDataSet("SELECT CouponProvider_Id, CouponProviderName FROM M_CouponProvider WHERE IsActive = 0 AND IsDelete = 0");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexIntVal(ds, "CouponProvider_Id", "CouponProviderName", ddlCouponProvider, "--Select--");
        ddlCouponProvider.SelectedIndex = 0;
    }
   
    protected void btnSearch_Click(object sender, ImageClickEventArgs e)
    {
        FillGrid();
        newMsg.Visible = false;
    }
    protected void btnRefesh_Click(object sender, ImageClickEventArgs e)
    {
        txtSearchName.Text = "";
        FillGrid();
        newMsg.Visible = false;
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillGrid();
    }
    private void FillGrid()
    {
        CouponProver Reg = new CouponProver();
        Reg.DML = "F";
        Reg.CouponName = txtSearchName.Text.Trim().Replace("'", "''");
        DataTable DsGrd = new DataTable();
        DsGrd = Business9420.CouponProver.CMFillDataGrid(Reg);
        if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        {
            if (DsGrd.Rows.Count > 0)
                GrdVw.PageSize = DsGrd.Rows.Count;
        }
        else
            GrdVw.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        if (DsGrd.Rows.Count > 0)
            GrdVw.DataSource = DsGrd;
        GrdVw.DataBind();        
        lblcount.Text = DsGrd.Rows.Count.ToString();
    }
    protected void GrdVw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdVw.PageIndex = e.NewPageIndex;
        FillGrid();
    }
    protected void GrdVw_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        CouponProver Reg = new CouponProver();
        lblBankId.Text = e.CommandArgument.ToString();
        Reg.Coupon_ID = lblBankId.Text; newMsg.Visible = false;
        Reg.DML = "S";
        CouponProver.CMFillDataGrid(Reg);
        if (e.CommandName.ToString() == "EditRow")
        {
            Fillddl();
            ddlCouponProvider.SelectedValue = Reg.CouponProvider_Id.ToString();
            txtName.Text = Reg.CouponName;
            lblAddCourierHeader.Text = "Coupon update Details";
            btnSubmit.Text = "Update";
            ModalPopupExtenderNewDesign.Show();
        }
        else if (e.CommandName.ToString() == "DeleteRow")
        {
            dhnactiontype.Value = "D";
            LabelAlertheader.Text = "Alert";
            LabelAlertText.Text = "Are you sure to dalete  <span style='color:blue;' >" + Reg.CouponName + "</span>  Coupon permanently?";
            ModalPopupExtenderAlert.Show();
        }
        else if (e.CommandName.ToString() == "ActivateRow")
        {
            dhnactiontype.Value = "A";
            LabelAlertheader.Text = "Alert";
            LabelAlertText.Text = "Are you sure to <span style='color:blue;' > " + FindStatus(Reg.IsActive) + " </span> <span style='color:blue;' >" + Reg.CouponName + "</span>  Coupon permanently?";
            ModalPopupExtenderAlert.Show();
        }
    }
    private string FindStatus(int p)
    {
        if (p == 0)
            return "De-Activate";
        else
            return "Activate";
    }
    private string FindStatusNew(int p)
    {
        if (p == 0)
            return "Activated";
        else
            return "De-Activated";
    }
    protected void btnNo_Click(object sender, EventArgs e)
    {

    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        CouponProver Reg = new CouponProver();
        Reg.Coupon_ID = lblBankId.Text;
        Reg.DML = "S";
        CouponProver.CMFillDataGrid(Reg);
        if (dhnactiontype.Value == "A")
        {
            Reg.DML = "A";
            if (Reg.IsActive == 0)
            {
                Reg.IsActive = 1;
                lblmsgHeader.Text = "Coupon <span style='color:blue;' >" + Reg.CouponName + "</span> has benn <span style='color:blue;' > " + FindStatusNew(Reg.IsActive) + " </span>  successfully.";
            }
            else
            {
                Reg.IsActive = 0;
                lblmsgHeader.Text = "Coupon <span style='color:blue;' >" + Reg.CouponName + "</span> has benn <span style='color:blue;' > " + FindStatusNew(Reg.IsActive) + " </span>  successfully.";
            }
        }
        else if (dhnactiontype.Value == "D")
        {
            Reg.DML = "D";
            if (Reg.IsDelete == 0)
                Reg.IsDelete = 1;
            else
                Reg.IsDelete = 0;
            lblmsgHeader.Text = "Coupon <span style='color:blue;' >" + Reg.CouponName + "</span> has benn deleted  successfully.";
        }
        CouponProver.CMActivateDelete(Reg);
        newMsg.Visible = true;
        newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        FillGrid();
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        CouponProver Reg = new CouponProver();
        Reg.EntryDate = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));        
        Reg.CouponName = txtName.Text.Trim().Replace("'", "''");
        Reg.CouponProvider_Id = Convert.ToInt64(ddlCouponProvider.SelectedValue);
        Reg.Coupon_ID = CouponProverObj.GetID("Coupon");
        if (btnSubmit.Text == "Save")
        {
            if (CheckCouponCode(Reg))
                Reg.DML = "U";
            else
                Reg.DML = "I";
            lblmsgHeader.Text = "Coupon <span style='color:blue;' >" + Reg.CouponName + "</span> has been registered successfully.";
        }
        else
        {
            Reg.Coupon_ID = lblBankId.Text;
            Reg.DML = "U";
            lblmsgHeader.Text = "Coupon <span style='color:blue;' >" + Reg.CouponName + "</span> has beeb updated successfully.";
        }
        string strMsg = MasterCoupon(Reg);
        
        if (string.IsNullOrEmpty(strMsg)) // if (MasterCoupon(Reg))
        {
            CouponProver.CMInsertUpdate(Reg);
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
            string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            Clear();
            FillGrid();
        }
        else
        {
            if (strMsg == "DateInValid")
            {
                lblmsgHeader.Text = "please upload a gift coupon excel sheet with valid date. DateFrom and DateTo should be greater than current date.";
            }
            else
            {
                lblmsgHeader.Text = "Coupon details not saved. Error in excel file.";
            }
            
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
    }

    private bool CheckCouponCode(CouponProver Reg)
    {
        DataTable dt = SQL_DB.ExecuteDataTable("SELECT Coupon_ID FROM M_Coupon WHERE CouponName = '" + Reg.CouponName + "' AND IsDelete = 0");
        if (dt.Rows.Count > 0)
        {
            Reg.Coupon_ID = dt.Rows[0]["Coupon_ID"].ToString();
            return true;
        }
        else
            return false;
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Clear(); newMsg.Visible = false; DivNewMsg.Visible = false;
        ModalPopupExtenderNewDesign.Show();
    }
    private DataTable LoadWorksheetInDataTable(string fileName, string sheetName)
    {
        DataTable sheetData = new DataTable();
        using (OleDbConnection conn = this.returnConnection(fileName))
        {
            conn.Open();
            // retrieve the data using data adapter
            OleDbDataAdapter sheetAdapter = new OleDbDataAdapter("select * from [" + sheetName + "]", conn);
            sheetAdapter.Fill(sheetData);
        }
        return sheetData;
    }

    private OleDbConnection returnConnection(string fileName)
    {
        return new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + fileName + "; Jet OLEDB:Engine Type=5;Extended Properties=\"Excel 8.0;\"");
    }
    public void ConvertXLSXtoXLS(string strPath,string strfileNM )
    {
        try
        {
            

            //string fileName = @strPath + "\\"+ strfileNM;            
            //string svfileName = @strPath + "\\" + strfileNM;

            //svfileName = System.IO.Path.ChangeExtension(svfileName, "xls");

            //if (File.Exists(svfileName))
            //    File.Delete(svfileName);

            //object oMissing = Type.Missing;
            //var app = new Microsoft.Office.Interop.Excel.Application();
            //var wb = app.Workbooks.Open(fileName, oMissing, oMissing,
            //                oMissing, oMissing, oMissing, oMissing, oMissing, oMissing, oMissing, oMissing, oMissing, oMissing, oMissing, oMissing);
            //wb.SaveAs(svfileName, Microsoft.Office.Interop.Excel.XlFileFormat.xlOpenXMLTemplate, Type.Missing, Type.Missing, Type.Missing, Type.Missing, 
            //    Microsoft.Office.Interop.Excel.XlSaveAsAccessMode.xlExclusive, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing);
            //app.Quit();
            
        }
        catch (Exception ex)
        {

            Response.Write(ex.Message);
        }
    }
   public DataTable ReadExl(string @svfileName)
    {
        DataTable dt = new DataTable();
        try
        {


         
            //CouponCode,Price,ValidDateFrom,ValidDateTo

            //dt.Columns.Add("SrNo", typeof(string));
            //dt.Columns.Add("CouponName", typeof(string));
            //dt.Columns.Add("CouponCode", typeof(string));
            //dt.Columns.Add("Price", typeof(string));
            //dt.Columns.Add("ValidDateFrom", typeof(DateTime));
            //dt.Columns.Add("ValidDateTo", typeof(DateTime));
            //Microsoft.Office.Interop.Excel.Application app = new Microsoft.Office.Interop.Excel.Application();
            //Microsoft.Office.Interop.Excel.Workbook workBook = app.Workbooks.Open(@svfileName, 0, true, 5, "", "", true, Microsoft.Office.Interop.Excel.XlPlatform.xlWindows, "\t", false, false, 0, true, 1, 0);
            //Microsoft.Office.Interop.Excel.Worksheet workSheet = (Microsoft.Office.Interop.Excel.Worksheet)workBook.ActiveSheet;

            //DataRow row;
            //int rowIndex = 0;
            //int index = 0;
            //do
            //{
            //    rowIndex = 2 + index;
            //    row = dt.NewRow();
            //    row[0] = Convert.ToString(((Microsoft.Office.Interop.Excel.Range)workSheet.Cells[rowIndex, 1]).Value2);
            //    row[1] = Convert.ToString(((Microsoft.Office.Interop.Excel.Range)workSheet.Cells[rowIndex, 2]).Value2);
            //    row[2] = Convert.ToString(((Microsoft.Office.Interop.Excel.Range)workSheet.Cells[rowIndex, 3]).Value2);
            //    row[3] = Convert.ToString(((Microsoft.Office.Interop.Excel.Range)workSheet.Cells[rowIndex, 4]).Value2);
            //    //row[4] = Convert.ToDateTime(((Microsoft.Office.Interop.Excel.Range)workSheet.Cells[rowIndex, 5]).Value2);
            //    string sDate = (workSheet.Cells[rowIndex, 5] as Microsoft.Office.Interop.Excel.Range).Value2.ToString();

            //    double date = double.Parse(sDate);

            //    var vdateTime = DateTime.FromOADate(date).ToString("MMMM dd, yyyy");
            //    row[4] = vdateTime;
            //    string sDate2 = (workSheet.Cells[rowIndex, 6] as Microsoft.Office.Interop.Excel.Range).Value2.ToString();

            //    double date2 = double.Parse(sDate2);

            //    var vdateTime2 = DateTime.FromOADate(date2).ToString("MMMM dd, yyyy");
            //    row[5] = vdateTime2;// Convert.ToDateTime(((Microsoft.Office.Interop.Excel.Range)workSheet.Cells[rowIndex, 6]).Value2);
            //    index++;
            //    dt.Rows.Add(row);
            //}
            //while (((Microsoft.Office.Interop.Excel.Range)workSheet.Cells[rowIndex, 1]).Value2 != null);
            return dt;
        }
        catch (Exception)
        {
            return dt;
           // throw ex;
        }
    }
    public bool CheckDateValidation(DataTable  dt)
    {
        try
        {
            string expression;
            expression = string.Format("ValidDateTo > #{0}#", DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss tt"));
            DataRow[] dr = dt.Select(expression);
            if (dr.Length == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        catch (Exception ex)
        {

             throw ex; 
        }
    }
    private string MasterCoupon(CouponProver Reg)
    {
        try
        {

            if (Reg.DML == "U")
                SQL_DB.ExecuteNonQuery("DELETE FROM [M_CouponCodes] WHERE Coupon_ID ='" + Reg.Coupon_ID + "' and  comp_id is null");
            string ext = Path.GetExtension(FileUpload1.FileName).ToLower();
            string FileName = "";
          
            if (FileUpload1.HasFile)
            {
                string FilePath = Server.MapPath("../Data");
                FileName = Reg.Coupon_ID + ext;
                FilePath = FilePath + "\\" + FileName;
                //FilePath = FilePath + "//" + FileName;
                if (File.Exists(FilePath))
                    File.Delete(FilePath);
                FileUpload1.SaveAs(FilePath);
               
            }
            
            DataTable dt = new DataTable();
            try
            {




                SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[Test] ([Remak]) VALUES   ('" + ext + "')");
                string DbPath = Server.MapPath("../Data"); DbPath += "\\" + FileName;
              //  string DbPath = Server.MapPath("../Data"); //DbPath += "D:\\test\\Data\\" + FileName;
                //DbPath = "D:\\test\\Data\\" + FileName;
                //D:\test\Data\
                //Response.Write(Server.MapPath("../Data"));
                //Response.Write("\\" + FileName);
                //string DbPath = ProjectSession.absoluteSiteBrowseUrl + "/Data" + "/" + FileName;
                Response.Write(DbPath);
                if (ext == ".xlsx")
                {
                    oledbCon.ConnectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + DbPath + ";Extended Properties=Excel 12.0;";
                  //  Response.Write(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + DbPath + ";Extended Properties=Excel 12.0;");
                }
                if (ext == ".xls")
                {
                    oledbCon.ConnectionString = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DbPath + ";Extended Properties=Excel 8.0;";
                  //  Response.Write(@"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DbPath + ";Extended Properties=Excel 8.0;");
                }
                SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[Test] ([Remak]) VALUES   ('" + oledbCon.ConnectionString + "')");
                oledbCmd.Connection = oledbCon;
               // DataTable dt = new DataTable();
                try
                {
                    if (oledbCon.State == ConnectionState.Open)
                        oledbCon.Close();
                    oledbCon.Open();
                    oledbCmd.CommandText = "Select CouponCode,Price,ValidDateFrom,ValidDateTo from [Sheet1$]";
                    OleDbDataAdapter objDatAdap = new OleDbDataAdapter();
                    objDatAdap.SelectCommand = oledbCmd;
                    objDatAdap.Fill(dt);
                    oledbCon.Close();
                    SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[Test] ([Remak]) VALUES   ('Fill Data successfully.')");
                }
                catch (Exception ex)
                {
                    SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[Test] ([Remak]) VALUES   ('" + ex.Message.ToString() + "')");
                }
               // int counter = 0;

                #region

                //SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[Test] ([Remak]) VALUES   ('" + ext + "')");
                //string DbPath = Server.MapPath("../Data");
                //if (ext == ".xlsx")
                //{
                //    ConvertXLSXtoXLS(DbPath, FileName);

                //     ext = ".xls";
                //    FileName = Path.ChangeExtension(FileName, ".xls");
                //}
                //DbPath += "\\" + FileName;
                //dt = ReadExl(DbPath);

                #endregion
                // READExcel(DbPath);
                //if (ext == ".xlsx")
                //{
                    
                //    string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + DbPath + ";Extended Properties=\"Excel 12.0;HDR=YES;\"";
                //    // oledbCon.ConnectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + DbPath + ";Extended Properties=Excel 12.0;HDR=YES;IMEX=1;";
                //    oledbCon.ConnectionString = connectionString;
                //}
                //if (ext == ".xls")
                //{
                //    oledbCon.ConnectionString = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DbPath + ";Extended Properties=Excel 8.0;";
                //    //string excelConnection = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DbPath + ";Extended Properties=\"Excel 8.0;HDR=YES;IMEX=1;\"";
                //    //oledbCon.ConnectionString = excelConnection;
                //    //Response.Write(DbPath);
                //}
                //SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[Test] ([Remak]) VALUES   ('" + oledbCon.ConnectionString + "')");
                //oledbCmd.Connection = oledbCon;
             

                //if (oledbCon.State == ConnectionState.Open)
                //    oledbCon.Close();
                //oledbCon.Open();
                //oledbCmd.CommandText = "Select CouponCode,Price,ValidDateFrom,ValidDateTo from [Sheet1$]";
                //OleDbDataAdapter objDatAdap = new OleDbDataAdapter();
                //objDatAdap.SelectCommand = oledbCmd;
                //objDatAdap.Fill(dt);
                //oledbCon.Close();
                //if (CheckDateValidation(dt) == false)
                //{
                //    return "DateInValid";call
                //}
              //  SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[Test] ([Remak]) VALUES   ('Fill Data successfully.')");
              
            }
            catch (Exception ex)
            {
                //SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[Test] ([Remak]) VALUES   ('" + ex.Message.ToString() + "')");
                Response.Write(ex.Message);
                throw ex;
             
//                return "error";
            }
            int counter = 0;
            string Qry = "";
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                try
                {
                    Qry += "INSERT INTO [M_CouponCodes] ([Coupon_ID],[CouponCode],[Price] ,[ValidFrom],[ValidTo],[SST_Id],[IsUsed],[AllotedDate],[EntryDate]) " +
                    " VALUES ('" + Reg.Coupon_ID + "','" + dt.Rows[i]["CouponCode"].ToString() + "'," + Convert.ToInt64(dt.Rows[i]["Price"]) + ",'" + Convert.ToDateTime(dt.Rows[i]["ValidDateFrom"]).ToString("yyyy/MM/dd") + "','" + Convert.ToDateTime(dt.Rows[i]["ValidDateTo"]).ToString("yyyy/MM/dd") + "',null,0,null,'" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "'); ";
                    counter++;
                    if (counter == 100)
                    {
                        SQL_DB.ExecuteNonQuery(Qry);
                        counter = 0; Qry = "";
                    }
                }
                catch (Exception ex)
                {
                    //SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[Test] ([Remak]) VALUES   ('"+ ex.Message.ToString() +"')");
                    throw ex;
                }
            }
            if (Qry != "")
                SQL_DB.ExecuteNonQuery(Qry);
            return "";
        }
        catch (Exception ex)
        {
            Response.Write(ex.ToString());
            Response.Write(ex.Message);
            //throw ex;
            return "error";
        }
    }

    
}
