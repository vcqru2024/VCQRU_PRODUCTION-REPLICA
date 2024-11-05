using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_CreditBalance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetInstantPayoutVendorDetails();
            DataBind();
        }
          
    }

    public void GetInstantPayoutVendorDetails()
    {
        string query = "GetAllInstantpayVendorDetails";//not recommended this i have written just for example,write stored procedure for security  
        SqlCommand com = new SqlCommand();
        com.CommandText = query;
        com.CommandType = CommandType.StoredProcedure;

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

    public void DataBind()
    {
        string query = "GetcashWalletCreditHistory";//not recommended this i have written just for example,write stored procedure for security  
        SqlCommand com = new SqlCommand();
        com.CommandText = query;
        com.CommandType = CommandType.StoredProcedure;

        com.Connection = dtcon.OpenConnection();
        SqlDataAdapter da = new SqlDataAdapter(com);
        DataTable Walletdt = new DataTable();
        da.Fill(Walletdt);


        if (Walletdt.Rows.Count > 0)
        {
            grdwallethistory.DataSource = Walletdt;
            grdwallethistory.DataBind();
        }

    }

    protected void ddlcompid_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblmsz.Text = "";
        lblbalance.Text = "";
        txtamount.Text = "";
        string Comp_ID = ddlcompid.SelectedItem.Value;
        if (Comp_ID == "--Select--")
        {
            lblmsz.Text = "Please select a vendor from list !";
            return;
        }
           
        string query = "select sum(Amount) as Amount  from Paytm_balance where Comp_ID='" + Comp_ID + "'";//not recommended this i have written just for example,write stored procedure for security  
        SqlCommand com = new SqlCommand();
        com.CommandText = query;
        com.CommandType = CommandType.Text;

        com.Connection = dtcon.OpenConnection();
        SqlDataAdapter da = new SqlDataAdapter(com);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if(dt.Rows.Count > 0)
        {
            lblbalance.Text = "Current balance is ₹ : " + dt.Rows[0]["Amount"].ToString();
            lblmsz.Text = "";
            txtamount.Text = "";
        }
    }

    protected void btncredit_Click(object sender, EventArgs e)
    {
        lblmsz.Text = "";
        
        lblmsz.Text = "";
        string Comp_ID = ddlcompid.SelectedItem.Value;
        if (Comp_ID == "--Select--")
        {
            lblmsz.Text = "Please select a vendor from list !";
            return;
        }

        if (txtamount.Text.Trim() =="")
        {
            lblmsz.Text = "Please select a vendor from list !";
            return;
        }

        string query = "CreditCashBalance";//not recommended this i have written just for example,write stored procedure for security  
        SqlCommand com = new SqlCommand();
        com.CommandText = query;
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@Comp_ID", Comp_ID);
        com.Parameters.AddWithValue("@Amount", txtamount.Text.Trim());
        com.Connection = dtcon.OpenConnection();
        SqlDataAdapter da = new SqlDataAdapter(com);
        DataTable Cdt = new DataTable();
        da.Fill(Cdt);
       if(Cdt.Rows.Count >0)
        {
            lblmsz.Text = "Now current balance is ₹ : " + Cdt.Rows[0]["Amount"].ToString();
           // lblbalance.Text = "Now Current balance is ₹ : " + Cdt.Rows[0]["Amount"].ToString();
            txtamount.Text = "";

        }
        DataBind();
    }
}