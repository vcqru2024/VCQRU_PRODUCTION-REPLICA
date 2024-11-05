using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_TermsandConditions : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetAccptedVendorDetails();
            DataBind();
        }

    }

    public void GetAccptedVendorDetails()
    {
        string query = "GetAccptedVendorDetails";//not recommended this i have written just for example,write stored procedure for security  
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

    public void DataBind(string CompanyId)
    {
        string query = "GetTermsandConditionAccreptedDetailsVendorwise";//not recommended this i have written just for example,write stored procedure for security  
        SqlCommand com = new SqlCommand();
        com.CommandText = query;
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@Comp_Id", CompanyId);
       
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





    protected void btnsearch_Click(object sender, EventArgs e)
    {
        string CompanyId = "All";
        if (ddlcompid.SelectedItem.Text != "--Select--")
            CompanyId = ddlcompid.SelectedItem.Value;
        DataBind(CompanyId);
    }
}