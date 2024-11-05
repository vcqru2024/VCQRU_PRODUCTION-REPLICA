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

public partial class Admin_CashTransferDetails_Bnk : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lbluploadmessage.Text = "";
            GetAccptedVendorDetails();
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


    public void GetAccptedVendorDetails()
    {
        string query = "GetClaimApprovedVendors";//not recommended this i have written just for example,write stored procedure for security  
        SqlCommand com = new SqlCommand();
        com.CommandText = query;
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@Reqtype", "Bank");
        com.Connection = dtcon.OpenConnection();
        SqlDataAdapter da = new SqlDataAdapter(com);
        DataSet Pds = new DataSet();
        da.Fill(Pds);


        if (Pds.Tables.Count > 0)
        {
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(Pds, "Comp_ID", "Comp_Name", ddlcompid, "--Select--");
            ddlcompid.SelectedIndex = 0;
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
        string Status = ddlstatus.SelectedItem.Value;
        if (CompId == "--Select--")
            CompId = "";
        if (Status == "--Select--")
            Status = "";


        string query = "GetClaimApprovedDetails";//not recommended this i have written just for example,write stored procedure for security  
        SqlCommand com = new SqlCommand();
        com.CommandText = query;
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@DateFrom", FromDate);
        com.Parameters.AddWithValue("@DateTo", Todate);
        com.Parameters.AddWithValue("@Comp_Id", CompId);
        com.Parameters.AddWithValue("@Status", Status);
        com.Parameters.AddWithValue("@Reqtype", "Bank");
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
            if (ddlcompid.SelectedItem.Text == "--Select--")
            {

                lbluploadmessage.Text = "Please select vendor to update the transaction details !";

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
                    string selectSql = @"SELECT * FROM [BankPaymentStatus$]";
                    using (OleDbConnection connection = new OleDbConnection(csbuilder.ConnectionString))
                    using (OleDbDataAdapter adapter = new OleDbDataAdapter(selectSql, connection))
                    {

                        connection.Open();
                        adapter.Fill(sheet1);

                        if (sheet1.Rows.Count > 0)
                        {

                            DataTable Errordt = new DataTable();
                            Errordt.Columns.Add("UserName");
                            Errordt.Columns.Add("MobileNo");
                            Errordt.Columns.Add("SumOfAmount");
                            Errordt.Columns.Add("Account_No");
                            Errordt.Columns.Add("Account_HolderNm");
                            Errordt.Columns.Add("Bank_Name");
                            Errordt.Columns.Add("IFSC_Code");
                            
                            Errordt.Columns.Add("ClaimDate");
                            Errordt.Columns.Add("ClaimID");
                            Errordt.Columns.Add("PaymentStatus");
                            Errordt.Columns.Add("TxnDate");
                            Errordt.Columns.Add("TxnID");
                            Errordt.Columns.Add("Remarks");
                            Errordt.Columns.Add("TranRemarks");


                            string Account_No = string.Empty, Account_HolderNm = string.Empty, Bank_Name = string.Empty, IFSC_Code = string.Empty, PaymentStatus = string.Empty, BankRefID = string.Empty, TransactionDate = string.Empty, PaymentRemarks = string.Empty, Mobileno = string.Empty, Amount = string.Empty, ClaimId = string.Empty;

                            string currDate = Convert.ToString(System.DateTime.Now).ToString();


                            for (int i = 0; sheet1.Rows.Count > i; i++)
                            {


                                Account_No = string.Empty; Account_HolderNm = string.Empty; Bank_Name = string.Empty; IFSC_Code = string.Empty; PaymentStatus = string.Empty; BankRefID = string.Empty; TransactionDate = string.Empty; PaymentRemarks = string.Empty; Mobileno = string.Empty; Amount = string.Empty; ClaimId = string.Empty;



                                Mobileno = sheet1.Rows[i][2].ToString();
                                if (Mobileno.Contains("+") || sheet1.Rows[i][2].ToString() == "")
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                    continue;
                                }

                                else if (sheet1.Rows[i][2].ToString() != "")
                                {
                                    //** For Mobileno
                                    Mobileno = sheet1.Rows[i][2].ToString();


                                    if (Mobileno.Length != 12)
                                    {
                                        Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                        continue;
                                    }

                                }
                                else
                                {

                                }


                                if (Amount.Contains("+"))
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                    continue;
                                }

                                else if (sheet1.Rows[i][3].ToString() != "")
                                {
                                    //** For Amount
                                    Amount = sheet1.Rows[i][3].ToString();

                                    int myDec;
                                    var Result = int.TryParse(Amount, out myDec);
                                    if (!Result)
                                    {
                                        Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                        continue;
                                    }

                                }
                                else
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), "Invalid Data");
                                    continue;
                                }


                                Account_No = sheet1.Rows[i][4].ToString();
                                if (Account_No.Contains("+"))
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                    continue;
                                }
                                
                                else if (sheet1.Rows[i][4].ToString() != "")
                                {
                                    //** For Account_No
                                    Account_No = sheet1.Rows[i][4].ToString();

                                }
                                else
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), "Invalid Data");
                                    continue;
                                }



                                Account_HolderNm = sheet1.Rows[i][5].ToString();
                                if (Account_HolderNm.Contains("+"))
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                    continue;
                                }
                                
                                else if (sheet1.Rows[i][5].ToString() != "")
                                {
                                    //** For Account_HolderNm
                                    Account_HolderNm = sheet1.Rows[i][5].ToString();

                                }
                                else
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), "Invalid Data");
                                    continue;
                                }


                                Bank_Name = sheet1.Rows[i][6].ToString();
                                if (Bank_Name.Contains("+"))
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                    continue;
                                }
                                
                                else if (sheet1.Rows[i][6].ToString() != "")
                                {
                                    //** For Bank_Name
                                    Bank_Name = sheet1.Rows[i][6].ToString();

                                }
                                else
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), "Invalid Data");
                                    continue;
                                }



                                IFSC_Code = sheet1.Rows[i][7].ToString();
                                if (IFSC_Code.Contains("+"))
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                    continue;
                                }
                                
                                else if (sheet1.Rows[i][7].ToString() != "")
                                {
                                    //** For UPIID
                                    IFSC_Code = sheet1.Rows[i][7].ToString();

                                }
                                else
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                    continue;
                                }






                                ClaimId = sheet1.Rows[i][9].ToString();
                                if (ClaimId.Contains("+"))
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                    continue;
                                }
                                else if (sheet1.Rows[i][9].ToString() != "")
                                {
                                    //** For Mobileno
                                    ClaimId = sheet1.Rows[i][9].ToString();

                                    int myDec;
                                    var Result = int.TryParse(ClaimId, out myDec);
                                    if (!Result)
                                    {
                                        Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                        continue;
                                    }

                                }
                                else
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                    continue;
                                }



                                PaymentStatus = sheet1.Rows[i][10].ToString();
                                if (PaymentStatus.Contains("+"))
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                    continue;
                                }

                                else if (sheet1.Rows[i][10].ToString() != "")
                                {
                                    //** For PaymentStatus 
                                    PaymentStatus = sheet1.Rows[i][10].ToString();

                                }
                                
                                else
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                    continue;
                                }


                                TransactionDate = sheet1.Rows[i][11].ToString();
                                if (TransactionDate.Contains("+"))
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                    continue;
                                }

                                else if (sheet1.Rows[i][11].ToString() != "")
                                {
                                    try
                                    {
                                        //** For TransactionDate 
                                        TransactionDate = sheet1.Rows[i][11].ToString();
                                        DateTime datetime = Convert.ToDateTime(TransactionDate);
                                        TransactionDate = datetime.ToString("dd/MMM/yyyy HH:mm:ss");

                                    }
                                    catch (Exception ex)
                                    {
                                        Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                        continue;
                                    }


                                }
                                
                                else
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                    continue;
                                }

                                if (BankRefID.Contains("+") || sheet1.Rows[i][9].ToString() == "")
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                    continue;
                                }
                                else
                                if (sheet1.Rows[i][12].ToString() != "")
                                {
                                    //** For BankRefID 
                                    BankRefID = sheet1.Rows[i][12].ToString();

                                }
                                else
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                    continue;
                                }

                                if (sheet1.Rows[i][13].ToString() != "")
                                {
                                    //** For PaymentRemarks 
                                    PaymentRemarks = sheet1.Rows[i][13].ToString();

                                }
                                else if (PaymentRemarks.Contains("+"))
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), "Invalid Data");
                                    continue;
                                }
                                else
                                {
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Invalid Data");
                                    continue;
                                }


                                //Check duplicate bank reference id 

                                DataTable Bankdt = SQL_DB.ExecuteDataTable("select Row_id,UPIID,PaymentStatus,BankRefID,TransactionDate,PaymentRemarks,Amount,PointsValue from ClaimDetails where BankRefID='" + BankRefID + "'");
                                if (Bankdt.Rows.Count > 0)
                                {
                                    
                                    Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Duplicate bank reference ID");
                                    continue;
                                }


                                    if (PaymentStatus == "Failed")
                                {
									if (ddlcompid.SelectedItem.Value == "Comp-1400")
                                    {
										string strQuery = "update ClaimDetails set Isapproved=2,PaymentStatus='Failed',BankRefID='" + BankRefID + "',TransactionDate='" + TransactionDate + "',PaymentRemarks='" + PaymentRemarks + "' where Mobileno='" + Mobileno + "' and Row_id='" + ClaimId + "'";

                                    SQL_DB.ExecuteNonQuery(strQuery);
									
                                        SQL_DB.ExecuteNonQuery("update BPointsTransaction set bpstatus='FAILURE' where  Transsctionid='" + ClaimId + "' and bpstatus='Accepted' and Transsctionid >1 ");
                                    }else{
                                    string strQuery = "update ClaimDetails set Isapproved=2,PaymentStatus='Failed',BankRefID='" + BankRefID + "',TransactionDate='" + TransactionDate + "',PaymentRemarks='" + PaymentRemarks + "' where Mobileno='" + Mobileno + "' and PointsValue='" + Amount + "' and Row_id='" + ClaimId + "'";

                                    SQL_DB.ExecuteNonQuery(strQuery);
									}
									
                                }
                                else
                                {


                                    if (PaymentStatus.Trim() == "Success")
                                    {

										DataTable dt = new DataTable();
                                        if (ddlcompid.SelectedItem.Value == "Comp-1400")
                                        {
                                             dt = SQL_DB.ExecuteDataTable("select Row_id,UPIID,PaymentStatus,BankRefID,TransactionDate,PaymentRemarks,Amount,PointsValue from ClaimDetails where Mobileno='" + Mobileno + "' and Row_id='" + ClaimId + "'");

                                        }
                                        else
                                        {
                                         dt = SQL_DB.ExecuteDataTable("select Row_id,UPIID,PaymentStatus,BankRefID,TransactionDate,PaymentRemarks,Amount,PointsValue from ClaimDetails where Mobileno='" + Mobileno + "' and PointsValue='" + Amount + "'  and PaymentStatus='Pending' and Row_id='" + ClaimId + "'");
                                        }
										if (dt.Rows.Count > 0)
                                        {
											if (ddlcompid.SelectedItem.Value == "Comp-1400")
                                            {
                                                string strQuery = "update ClaimDetails set PaymentStatus='Success',BankRefID='" + BankRefID + "',TransactionDate='" + TransactionDate + "',PaymentRemarks='" + PaymentRemarks + "' where Mobileno='" + Mobileno + "' and Row_id='" + ClaimId + "' ";
                                                SQL_DB.ExecuteNonQuery(strQuery);
                                            }
                                            else 
                                            { 
                                            string strQuery = "update ClaimDetails set PaymentStatus='Success',BankRefID='" + BankRefID + "',TransactionDate='" + TransactionDate + "',PaymentRemarks='" + PaymentRemarks + "' where Mobileno='" + Mobileno + "' and PointsValue='" + Amount + "' and Row_id='" + ClaimId + "' and PaymentStatus='Pending'";
                                            SQL_DB.ExecuteNonQuery(strQuery);

                                            DataTable Updt = SQL_DB.ExecuteDataTable("select Row_id,UPIID,PaymentStatus,BankRefID,TransactionDate,PaymentRemarks,Amount from ClaimDetails where Mobileno='" + Mobileno + "' and PointsValue='" + Amount + "' and Row_id='" + ClaimId + "' and IsPaid='0' ");
                                            if (Updt.Rows.Count > 0)
                                            {
                                                decimal WalletBal = 0m;
                                                DataTable Baldt = SQL_DB.ExecuteDataTable("select * from Paytm_balance where Comp_ID='" + ddlcompid.SelectedItem.Value + "'");
                                                if (Baldt.Rows.Count > 0)
                                                {
                                                    WalletBal = Convert.ToDecimal(Baldt.Rows[0]["Amount"].ToString());

                                                    decimal RemAmount = WalletBal - Convert.ToDecimal(Amount);
                                                    string strWalletQuery = "update Paytm_balance set Amount='" + RemAmount + "',Updated_date='" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "' where Comp_ID='" + ddlcompid.SelectedItem.Value + "'";

                                                    SQL_DB.ExecuteNonQuery(strWalletQuery);

                                                    string strPaidQuery = "update ClaimDetails set IsPaid='1' where Mobileno='" + Mobileno + "' and PointsValue='" + Amount + "' and Row_id='" + ClaimId + "' and IsPaid='0'";
                                                    SQL_DB.ExecuteNonQuery(strPaidQuery);




                                                }
                                            }


											}



                                        }
                                        else
                                        {
                                            Errordt.Rows.Add(sheet1.Rows[i][1].ToString(), sheet1.Rows[i][2].ToString(), sheet1.Rows[i][3].ToString(), sheet1.Rows[i][4].ToString(), sheet1.Rows[i][5].ToString(), sheet1.Rows[i][6].ToString(), sheet1.Rows[i][7].ToString(), sheet1.Rows[i][8].ToString(), sheet1.Rows[i][9].ToString(), sheet1.Rows[i][10].ToString(), sheet1.Rows[i][11].ToString(), sheet1.Rows[i][12].ToString(), "Data Not Fount Or Already paid !");
                                            continue;
                                        }
                                    }
                                }





                            }

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
        catch (Exception ex)
        {
            if (ex.Message.ToUpper().Contains("MICROSOFT.ACE.OLEDB.12.0"))
                lbluploadmessage.Text = "Something went wrong, please try with .xls file ";
            else
                lbluploadmessage.Text = "Something went wrong, please try again after some time " + ex.StackTrace;
        }
    }
}