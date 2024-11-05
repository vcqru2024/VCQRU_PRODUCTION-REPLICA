using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_pfl13digitmobilenoscaning : System.Web.UI.Page
{
    private static Database database = DatabaseFactory.CreateDatabase();
    private static DbCommand dbCommand;
    private static DataAdapter adp;
    private static DataSet ds;
    private static DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Comp_ID"] == null)
            Response.Redirect("../Patanjali/Loginpfl.aspx");
    }
    public DataTable GetDataFromDatabase()
    {
        string parameterValue = Session["Comp_ID"].ToString();
        string storedProcedureName = "USP_GetCodeMobileWiseScanning_PFL";
        DataTable dataTable = new DataTable();

        try
        {
            dt = new DataTable();
            dbCommand = database.GetStoredProcCommand(storedProcedureName);
            database.AddInParameter(dbCommand, "@companyid", DbType.String, parameterValue);
            dt = database.ExecuteDataSet(dbCommand).Tables[0];
            return dt;
        }
        catch (Exception)
        {
            throw;
        }
    }
}