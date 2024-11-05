using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ManualPayout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lbluploadmessage.Text = "";
            
            txtDateFrom.Text = System.DateTime.Now.ToString("dd-MM-yyyy");
            txtDateTo.Text = txtDateFrom.Text;
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

            txtDateFrom.Text = System.DateTime.Now.ToString("dd-MM-yyyy");
            txtDateTo.Text = txtDateFrom.Text;
        }

    }


   

    private DataTable BindDataDetails()
    {
        lbluploadmessage.Text = "";
        DataTable dt = new DataTable();

        DateTime dtfrm = Convert.ToDateTime(txtDateFrom.Text);
        DateTime dtto = Convert.ToDateTime(txtDateTo.Text);
        string FromDate = dtfrm.ToString("yyyy-MM-dd HH:mm:ss");
        string Todate = dtto.ToString("yyyy-MM-dd 23:59:59");
        string CompId = ddlcompid.SelectedItem.Value;

        //if (CompId == "--Select--")
        // CompId = "";
        if (CompId == "Comp-1274")
        { //jpc
            payoutOther.Visible = false;
            payoutjpc.Visible = true;
        }
        else
        {
            payoutOther.Visible = true;
            payoutjpc.Visible = false;
        }



        string query = "GetManualpayoutDetails";//not recommended this i have written just for example,write stored procedure for security  
        SqlCommand com = new SqlCommand();
        com.CommandText = query;
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@DateFrom", FromDate);
        com.Parameters.AddWithValue("@DateTo", Todate);
        com.Parameters.AddWithValue("@Comp_Id", CompId);
       
        com.Connection = dtcon.OpenConnection();
        SqlDataAdapter da = new SqlDataAdapter(com);

        da.Fill(dt);

        return dt;
    }





    protected void lnkfileDownload_Click(object sender, ImageClickEventArgs e)
    {
        FailureDiv.Visible = false;
        SearchDataDiv.Visible = true;
        lbluploadmessage.Text = "";
        DataTable dt = BindDataDetails();

        if (dt.Rows.Count > 0)
        {
            lblcount.Text = dt.Rows.Count.ToString();
            GridView1.DataSource = dt;
            GridView1.DataBind();
            GridView1.Visible = true;

        }
        else
        {
            GridView1.DataSource = "";
            lblcount.Text = "0";
            GridView1.Visible = false;

        }

    }




    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {


        }
        catch (Exception ex)
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
            GridView1.Visible = true;
        }
        else
        {
            GridView1.DataSource = "";
            lblcount.Text = "0";
            GridView1.Visible = false;

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
        if (e.Row.RowIndex == GridView1.EditIndex)
        {


        }
    }



    protected void imgbtnupload_Click(object sender, ImageClickEventArgs e)
    {
        lbluploadmessage.Text = "";
        string path = string.Empty;
        try
        {
            if (fl_CodeStatus.PostedFile.ContentLength > 0)
            {
                var fileName = Path.GetFileNameWithoutExtension(fl_CodeStatus.FileName);
                var fileExtn = Path.GetExtension(fl_CodeStatus.FileName);
                var NewFileName = "Manual_" + Guid.NewGuid().ToString() + fileExtn;
                //path = Path.Combine(Server.MapPath("~/Data/Transactions/"), fileName + fileExtn);
                path = Path.Combine(Server.MapPath("~/images/Transactions/"), NewFileName);
                string filepath = "/images/Transactions/"+ NewFileName;
                fl_CodeStatus.SaveAs(path);

                if (fileExtn == ".xlsx" || fileExtn == ".xls")
                {
                    DataTable sheet1 = new DataTable();
                    //** Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Path\To\Your\Database.accdb

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
                        csbuilder.Add("Extended Properties", "Excel 8.0;HDR=YES;");

                    //string selectSql = @"SELECT * FROM [Sheet1$]";//
                   // string selectSql = @"SELECT * FROM [Manualpayout$]";
                    string selectSql = "";
                    //string selectSql = @"SELECT * FROM [Sheet1$]";//
                    if (ddlcompid.SelectedItem.Value == "Comp-1274")
                    {
                        selectSql = @"SELECT * FROM [Manualpayout$]";
                    }
                    else
                    {
                        selectSql = @"SELECT * FROM [ManualpayoutAll$]";
                    }
                    using (OleDbConnection connection = new OleDbConnection(csbuilder.ConnectionString))
                    using (OleDbDataAdapter adapter = new OleDbDataAdapter(selectSql, connection))
                    {

                        connection.Open();
                        adapter.Fill(sheet1);

                        if (sheet1.Rows.Count > 0 && ddlcompid.SelectedItem.Value == "Comp-1274")
                        {
                            if (sheet1.Rows.Count > 0)
                            {



                                DataTable Errordt = new DataTable();

                                Errordt.Columns.Add("MobileNo");
                                Errordt.Columns.Add("Amount");
                                Errordt.Columns.Add("TransactionDate");
                                Errordt.Columns.Add("CompanyName");
                                Errordt.Columns.Add("TranRemarks");

                                string CompanyId = ddlcompid.SelectedItem.Value;
                                string[] Comp = CompanyId.Split('-');
                                string CompId = Comp[1].ToString();

                                string CompanyName = ddlcompid.SelectedItem.Text;
                                string MobileNo = string.Empty, Amount = string.Empty, TransactionDate = string.Empty, TranRemarks = string.Empty, Remarks = string.Empty; ;

                                string currDate = Convert.ToString(System.DateTime.Now).ToString();

                                int DataCount = 0;
                                for (int i = 0; sheet1.Rows.Count > i; i++)
                                {


                                    MobileNo = string.Empty; Amount = string.Empty; TransactionDate = string.Empty; TranRemarks = string.Empty; Remarks = string.Empty;

                                    if (sheet1.Rows[i][0].ToString() != "")
                                    {
                                        DataCount = DataCount + 1;
                                        //** For Mobileno
                                        MobileNo = sheet1.Rows[i][0].ToString();


                                        if (MobileNo.Length != 12)
                                        {
                                            Errordt.Rows.Add(sheet1.Rows[i][0].ToString(), sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), CompanyName, "Invalid Data");
                                            continue;
                                        }

                                    }
                                    else if (MobileNo.Contains("+") || sheet1.Rows[i][0].ToString() == "")
                                    {
                                        Errordt.Rows.Add(sheet1.Rows[i][0].ToString(), sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), CompanyName, "Invalid Data");
                                        continue;
                                    }
                                    else
                                    {

                                    }
                                    if (sheet1.Rows[i][1].ToString() != "")
                                    {
                                        //** For Mobileno
                                        Amount = sheet1.Rows[i][1].ToString();

                                        decimal myDec;
                                        var Result = Decimal.TryParse(Amount, out myDec);

                                        if (Amount.Contains("."))
                                        {

                                        }
                                        else
                                            Amount = Amount + ".00";
                                        if (!Result)
                                        {
                                            Errordt.Rows.Add(sheet1.Rows[i][0].ToString(), sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), CompanyName, "Invalid Data");

                                            continue;
                                        }

                                    }
                                    else if (Amount.Contains("+"))
                                    {
                                        Errordt.Rows.Add(sheet1.Rows[i][0].ToString(), sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), CompanyName, "Invalid Data");

                                        continue;
                                    }
                                    else
                                    {
                                        Errordt.Rows.Add(sheet1.Rows[i][0].ToString(), sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), CompanyName, "Invalid Data");

                                        continue;
                                    }




                                    if (sheet1.Rows[i][2].ToString() != "")
                                    {
                                        try
                                        {
                                            //** For TransactionDate 
                                            TransactionDate = sheet1.Rows[i][2].ToString();
                                            DateTime datetime = Convert.ToDateTime(TransactionDate);
                                            TransactionDate = datetime.ToString("dd/MMM/yyyy HH:mm:ss");

                                        }
                                        catch (Exception ex)
                                        {
                                            Errordt.Rows.Add(sheet1.Rows[i][0].ToString(), sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), CompanyName, "Invalid Data");

                                            continue;
                                        }


                                    }

                                    //if (sheet1.Rows[i][3].ToString() != "")
                                    //{
                                    //    //** For Remarks
                                    //    Remarks = sheet1.Rows[i][3].ToString();

                                    //}
                                    //else if (Remarks.Contains("+"))
                                    //{
                                    //    Errordt.Rows.Add(sheet1.Rows[i][0].ToString(), sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), CompanyName, "Invalid Data");
                                    //    continue;
                                    //}
                                    //else
                                    //{
                                    //    Errordt.Rows.Add(sheet1.Rows[i][0].ToString(), sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), CompanyName, "Invalid Data");
                                    //    continue;
                                    //}

                                    double ReqAmount = Convert.ToDouble(Amount);



                                    DataTable dt = SQL_DB.ExecuteDataTable("select  MobileNo from Transactions t inner join M_Consumer m on m.M_Consumerid=t.M_CounserID where m.MobileNo='" + MobileNo + "' and t.Amount='" + ReqAmount + "' and t.TransactionDate='" + TransactionDate + "' and t.Issuccess=1");
                                    if (dt.Rows.Count == 0)
                                    {
                                        string query = "USP_InsertPayoutDataforJPC";//not recommended this i have written just for example,write stored procedure for security  
                                        SqlCommand com = new SqlCommand();
                                        com.CommandText = query;
                                        com.CommandType = CommandType.StoredProcedure;
                                        com.Parameters.AddWithValue("@Mobileno", MobileNo);
                                        com.Parameters.AddWithValue("@Companyid", CompId);
                                        com.Parameters.AddWithValue("@Amount", Amount);
                                        com.Parameters.AddWithValue("@TransactionDate", TransactionDate);
                                        com.Connection = dtcon.OpenConnection();
                                        com.ExecuteNonQuery();




                                    }
                                    else
                                    {

                                        Errordt.Rows.Add(sheet1.Rows[i][0].ToString(), sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), CompanyName, "Data Not Fount Or Already paid !");
                                        continue;

                                    }
                                }


                                string FilepathQuery = "insert into tblManualpayoutDetails(CompId,FilePath,RecordsIn)values('" + ddlcompid.SelectedItem.Value + "','" + filepath + "','" + DataCount + "')";

                                SQL_DB.ExecuteNonQuery(FilepathQuery);



                                FailureDiv.Visible = true;
                                SearchDataDiv.Visible = false;
                                lblfailure.Text = Errordt.Rows.Count.ToString();
                                GridView2.DataSource = Errordt;
                                GridView2.DataBind();
                                lbluploadmessage.Text = "Your File has been uploaded successfully";
                            } 
                        }
                        else
                        {
                            if (sheet1.Rows.Count > 0)
                            {


                                DataTable Errordt = new DataTable();

                                Errordt.Columns.Add("MobileNo");
                                Errordt.Columns.Add("Amount");
                                Errordt.Columns.Add("TransactionDate");
                                Errordt.Columns.Add("CompanyName");
                                Errordt.Columns.Add("TranRemarks");
                                Errordt.Columns.Add("AccountNumber");
                                Errordt.Columns.Add("IFSCCode");

                                string CompanyId = ddlcompid.SelectedItem.Value;
                                string[] Comp = CompanyId.Split('-');
                                string CompId = Comp[1].ToString();

                                string CompanyName = ddlcompid.SelectedItem.Text;
                                string AccountNumber = string.Empty;
                                string IFSCCode = string.Empty;
                                string MobileNo = string.Empty, Amount = string.Empty, TransactionDate = string.Empty, TranRemarks = string.Empty, Remarks = string.Empty;

                                string currDate = Convert.ToString(System.DateTime.Now).ToString();

                                int DataCount = 0;
                                for (int i = 0; sheet1.Rows.Count > i; i++)
                                {


                                    MobileNo = string.Empty; Amount = string.Empty; TransactionDate = string.Empty; TranRemarks = string.Empty; Remarks = string.Empty;
                                    AccountNumber = string.Empty; IFSCCode = string.Empty;
                                    if (sheet1.Rows[i][0].ToString() != "")
                                    {
                                        DataCount = DataCount + 1;
                                        //** For Mobileno
                                        MobileNo = sheet1.Rows[i][0].ToString();


                                        if (MobileNo.Length != 12)
                                        {
                                            Errordt.Rows.Add(sheet1.Rows[i][0].ToString(), sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), CompanyName, "Invalid Data");
                                            continue;
                                        }

                                    }
                                    else if (MobileNo.Contains("+") || sheet1.Rows[i][0].ToString() == "")
                                    {
                                        Errordt.Rows.Add(sheet1.Rows[i][0].ToString(), sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), CompanyName, "Invalid Data");
                                        continue;
                                    }
                                    else
                                    {

                                    }
                                    if (sheet1.Rows[i][1].ToString() != "")
                                    {
                                        //** For Mobileno
                                        Amount = sheet1.Rows[i][1].ToString();

                                        decimal myDec;
                                        var Result = Decimal.TryParse(Amount, out myDec);
                                        if (!Result)
                                        {
                                            Errordt.Rows.Add(sheet1.Rows[i][0].ToString(), sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), CompanyName, "Invalid Data");

                                            continue;
                                        }

                                    }
                                    else if (Amount.Contains("+"))
                                    {
                                        Errordt.Rows.Add(sheet1.Rows[i][0].ToString(), sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), CompanyName, "Invalid Data");

                                        continue;
                                    }
                                    else
                                    {
                                        Errordt.Rows.Add(sheet1.Rows[i][0].ToString(), sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), CompanyName, "Invalid Data");

                                        continue;
                                    }




                                    if (sheet1.Rows[i][2].ToString() != "")
                                    {
                                        try
                                        {
                                            //** For TransactionDate 
                                            TransactionDate = sheet1.Rows[i][2].ToString();
                                            DateTime datetime = Convert.ToDateTime(TransactionDate);
                                            TransactionDate = datetime.ToString("dd/MMM/yyyy HH:mm:ss");

                                        }
                                        catch (Exception ex)
                                        {
                                            Errordt.Rows.Add(sheet1.Rows[i][0].ToString(), sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), CompanyName, "Invalid Data");

                                            continue;
                                        }


                                    }


                                    if (sheet1.Rows[i][3].ToString() != "")
                                    {
                                        DataCount = DataCount + 1;
                                        //** For Mobileno
                                        AccountNumber = sheet1.Rows[i][3].ToString();


                                    }
                                    else
                                    {

                                    }


                                    if (sheet1.Rows[i][4].ToString() != "")
                                    {
                                        DataCount = DataCount + 1;
                                        //** For Mobileno
                                        IFSCCode = sheet1.Rows[i][4].ToString();


                                    }
                                    else
                                    {

                                    }




                                    double ReqAmount = Convert.ToDouble(Amount);



                                    DataTable dt = SQL_DB.ExecuteDataTable("select  MobileNo from Transactions t inner join M_Consumer m on m.M_Consumerid=t.M_CounserID where m.MobileNo='" + MobileNo + "' and t.Amount='" + ReqAmount + ".00' and t.TransactionDate='" + TransactionDate + "' and t.Issuccess=1");
                                    if (dt.Rows.Count == 0)
                                    {
                                        string query = "USP_InsertPayoutDataforAll";//not recommended this i have written just for example,write stored procedure for security  
                                        SqlCommand com = new SqlCommand();
                                        com.CommandText = query;
                                        com.CommandType = CommandType.StoredProcedure;
                                        com.Parameters.AddWithValue("@Mobileno", MobileNo);
                                        com.Parameters.AddWithValue("@Companyid", CompId);
                                        com.Parameters.AddWithValue("@Amount", Amount);
                                        com.Parameters.AddWithValue("@TransactionDate", TransactionDate);
                                        com.Parameters.AddWithValue("@AccountNumber", AccountNumber);
                                        com.Parameters.AddWithValue("@IFSCCode", IFSCCode);
                                        com.Connection = dtcon.OpenConnection();
                                        com.ExecuteNonQuery();




                                    }
                                    else
                                    {

                                        Errordt.Rows.Add(sheet1.Rows[i][0].ToString(), sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), CompanyName, "Data Not Fount Or Already paid !");
                                        continue;

                                    }
                                }


                                string FilepathQuery = "insert into tblManualpayoutDetails(CompId,FilePath,RecordsIn)values('" + ddlcompid.SelectedItem.Value + "','" + filepath + "','" + DataCount + "')";

                                SQL_DB.ExecuteNonQuery(FilepathQuery);



                                FailureDiv.Visible = true;
                                SearchDataDiv.Visible = false;
                                lblfailure.Text = Errordt.Rows.Count.ToString();
                                GridView2.DataSource = Errordt;
                                GridView2.DataBind();
                                lbluploadmessage.Text = "Your File has been uploaded successfully";
                            }

                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            if (ex.Message.ToUpper().Contains("MICROSOFT.ACE.OLEDB.12.0"))
                lbluploadmessage.Text = "Something went wrong, please try with .xls file ";
            else
                lbluploadmessage.Text = "Something went wrong, please try again after some time " + ex.StackTrace;
        }
    }
}