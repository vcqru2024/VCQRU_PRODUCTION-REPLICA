using Business9420;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_CodeVerificationReport : System.Web.UI.Page
{
    SqlConnection conectionstring = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
    private static DbCommand dbCommand;
    private static Database database = DatabaseFactory.CreateDatabase();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (! Page.IsPostBack)
        {
            allClear();
            fillservice();
            FillRemarks();
        }
    }
    public DataTable GetDataFromDatabase()
    {
        string parameterValue = Session["Comp_id"].ToString();
        string fromdate = txtfromdate.Value;
        string todate = txtTodate.Value;
        string storedProcedureName = "Web_Support_Counter_PFL";
        DataTable dataTable = new DataTable();

        using (conectionstring)
        {
            try
            {
                conectionstring.Open();

                // Create a SqlCommand object to execute the stored procedure
                using (SqlCommand command = new SqlCommand(storedProcedureName, conectionstring))
                {
                    // Specify that the command is a stored procedure
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@companyid", parameterValue);
                    command.Parameters.AddWithValue("@start_date", fromdate);
                    command.Parameters.AddWithValue("@enq_date", todate);
                    command.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
                    command.Parameters.AddWithValue("@Location", listate.SelectedValue);
                    // Execute the stored procedure and fill the DataTable
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(dataTable);
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions here
                Console.WriteLine("An error occurred: " + ex.Message);
            }
        }

        return dataTable;
    }
    public DataSet getdataset()
    {
        Object9420 Reg = new Object9420();
        string product = "";
        string state = "";
        foreach (var item in liproname.GetSelectedIndices())
        {
            product = product + "" + liproname.Items[item].Value + ",";
        }
        bool x = product.Contains("--All Product--");
        if (product.Length > 0 && !product.Contains("--All Product--"))
        {
            product = product.Remove(product.Length - 1, 1);
        }
        else
        {
            product = "";
        }
        foreach (int item in listate.GetSelectedIndices())
        {
            state = state + "" + listate.Items[item] + ",";

        }
        if (state.Length > 0 && !state.Contains("--All Location--"))
        {
            state = state.Remove(state.Length - 1, 1);
        }
        else
        {
            state = "";
        }
        if (ddlservice.SelectedIndex > 0)
            Reg.Service_ID = ddlservice.SelectedValue;
        else
            Reg.Service_ID = "";

        if (ddlRemarks.SelectedIndex > 0)
        {
            Reg.Remarks = ddlRemarks.SelectedValue;
        }
        else
            Reg.Remarks = "";
        if (ddlStatus.SelectedIndex > 0)
        {
            Reg.statusstr = ddlStatus.SelectedValue;
        }
        else
            Reg.statusstr = "";
        Page.Validate("servss");
        DataSet dtst = new DataSet();
        if (Page.IsValid)
        {
            try
            {
                 dtst = FillcodeverificationPFL("Comp-1605", product, Convert.ToDateTime(txtTodate.Value), Convert.ToDateTime(txtfromdate.Value), Reg.statusstr, Reg.Remarks, Mobile.Text, state, Reg.Service_ID);
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
            } 
        }
        return dtst;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

    }

    protected void ddlservice_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillLocation(ddlservice.SelectedValue);
        FillProducts("Comp-1605");
    }
    private void fillservice()
    {
        DataSet ds = SQL_DB.ExecuteDataSet("select distinct sb.service_id,serv.servicename from M_ServiceSubscription (nolock) sb left join m_service (nolock) serv on sb.Service_ID=serv.Service_ID where sb.Comp_ID='Comp-1605'");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "service_id", "servicename", ddlservice, "--Service--");
        ddlservice.SelectedIndex = 0;
    }
    private void FillRemarks()
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT distinct [call_status] FROM [Tbl_support] (nolock) order by [call_status]");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "call_status", "call_status", ddlRemarks, "--Remarks --");
        ddlRemarks.SelectedIndex = 0;
    }
    private void allClear()
    {
        txtfromdate.Value = "";
        txtTodate.Value = "";
        //ddlMode.SelectedIndex = 0;
        ddlStatus.SelectedIndex = 0;
    }
    private void FillProducts(string CompID)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("select DISTINCT pr.Pro_ID, pr.Pro_Name, pr.Comp_ID from m_servicesubscription (nolock) ms inner join Pro_Reg (nolock) pr on pr.pro_id=ms.pro_id and pr.comp_id=ms.comp_id where ms.service_id='" + ddlservice.SelectedValue + "' and pr.comp_id='" + CompID.ToString() + "' order by pr.Pro_Name");
        DataProvider.MyUtilities.FillLISTInsertZeroIndexString(ds.Tables[0], "Pro_ID", "Pro_Name", liproname, "--All Product--");

    }
    private void FillLocation(string service)
    {
        DataSet ds = ExecuteNonQueryAndDatatable.filllocation("Comp-1605", service);
        //DataSet ds = SQL_DB.ExecuteDataSet("SELECT distinct [Location] FROM [Tbl_support] order by [Location]");
        DataProvider.MyUtilities.FillLISTsinglecolumnInsertZeroIndexString(ds.Tables[0], "Location", "Location", listate, "--All Location--");
        //listate.SelectedIndex = 0;
    }
    public static DataSet FillcodeverificationPFL(string comp_id, string pro_id, DateTime enq_date, DateTime start_date, string status, string remarks, string mobileno, string location, string service)
    {
        try
        {
            //string circleflag = "N";
            //string[] locations = location.Split(',');
            //int pos = Array.IndexOf(locations, "");
            //if (pos > -1 || location=="")
            //{
            //    circleflag = "Y";
            //}
            if (service == "SRV1018")
            {
                string dtstrt = start_date.ToString("yyyy-MM-dd");
                //dbCommand = database.GetStoredProcCommand("GetWalletList");
                dbCommand = database.GetStoredProcCommand("[web_SUPPORT_Counter_PFL]");
            }
            else
            {
                string dtstrt = start_date.ToString("yyyy-MM-dd");
                //dbCommand = database.GetStoredProcCommand("GetWalletList");
                dbCommand = database.GetStoredProcCommand("[web_SUPPORT]");
            }
            dbCommand.Parameters.Add(new SqlParameter("@companyid", comp_id));
            dbCommand.Parameters.Add(new SqlParameter("@product", pro_id));
            dbCommand.Parameters.Add(new SqlParameter("@enq_date", enq_date.ToString("yyyy-MM-dd") + " 23:59:59.999"));//DateTime.Today
            dbCommand.Parameters.Add(new SqlParameter("@status", status.Trim()));
            dbCommand.Parameters.Add(new SqlParameter("@Remarks", remarks.Trim()));
            dbCommand.Parameters.Add(new SqlParameter("@mobile", mobileno.Trim()));
            dbCommand.Parameters.Add(new SqlParameter("@start_date", start_date.ToString("yyyy-MM-dd")));
            dbCommand.Parameters.Add(new SqlParameter("@Location", location.Trim()));
            dbCommand.Parameters.Add(new SqlParameter("@service", service.Trim()));
            //dbCommand.Parameters.Add(new SqlParameter("@circleflag", circleflag.Trim()));
            dbCommand.CommandTimeout = 500;
            return database.ExecuteDataSet(dbCommand);


        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

}