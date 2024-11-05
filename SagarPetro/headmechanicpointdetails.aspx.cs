using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SagarPetro_headmechanicpointdetails : System.Web.UI.Page
{
    cls_message db = new cls_message();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../SagarPetro/Loginhpl.aspx");
    }
    public DataTable GetDataFromDatabase(string Userroletype, string Datefrom, string Dateto)
    {
        if (string.IsNullOrEmpty(Userroletype))
            Userroletype = "6";
        if (string.IsNullOrEmpty(txtfromdate.Text) && string.IsNullOrEmpty(txttodate.Text))
        {
            Datefrom = DateTime.Today.ToString("yyyy-MM-dd 00:00:00.001");
            Dateto = DateTime.Today.ToString("yyyy-MM-dd 23:59:59.999");
        }

        DataTable dataTable = SQL_DB.ExecuteDataTable("exec USP_GETDetailsScore_SP '" + Session["CompanyId"].ToString() + "','" + Userroletype + "','" + Datefrom + "','" + Dateto + "'");
        // DataTable dataTable = SQL_DB.ExecuteDataTable("exec USP_GetHeadMechanicDetailsDateFilterweb_SP '" + Session["CompanyId"].ToString() + "','"+ Userroletype + "','"+ Datefrom + "','"+ Dateto + "'");
        if (dataTable.Rows.Count == 0)
            dataTable = null;
        return dataTable;
    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        string Userroletype = ddlusertype.SelectedItem.Value;
        string dateFrom = Convert.ToDateTime(txtfromdate.Text).ToString("yyyy-MM-dd 00:00:00.001");
        string dateTo = Convert.ToDateTime(txttodate.Text).ToString("yyyy-MM-dd 23:59:59.999");

        if (string.IsNullOrEmpty(Userroletype))
        {
            db.ShowErrorMessage(this, "Please Select User Type");
        }
        else if (string.IsNullOrEmpty(dateFrom) && string.IsNullOrEmpty(dateTo))
        {
            db.ShowErrorMessage(this, "Please Select User Type");
        }
        else
        {
            GetDataFromDatabase(Userroletype, dateFrom, dateTo);
        }
    }
}