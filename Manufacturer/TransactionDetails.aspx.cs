using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_TransactionDetails : System.Web.UI.Page
{
    public int str = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../Login.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("admin/Login.aspx");
        }

        if (!IsPostBack)
        {
            FillTransData();
        }
    }

    private void FillTransData()
    {
        DataSet dsComp = SQL_DB.ExecuteDataSet("SELECT * FROM Comp_Reg where Comp_Email='" + Session["CompanyId"].ToString() + "'");
        if (dsComp.Tables[0].Rows.Count > 0)
        {
            string sQry = "Select * from Transactions Where CompId='" + dsComp.Tables[0].Rows[0]["Comp_ID"].ToString() + "'";
            hdnCompId.Value = dsComp.Tables[0].Rows[0]["Comp_ID"].ToString();

            DataTable dtTrans = SQL_DB.ExecuteDataTable(sQry);

            if (dtTrans.Rows.Count > 0)
            {
                lblcount.InnerText = dtTrans.Rows.Count + " Record(s) found";
                gvTransactions.DataSource = dtTrans;
                gvTransactions.DataBind();
                btnDownload.Visible = true;
            }
        }
        else
        {
            btnDownload.Visible = false;
            lblcount.InnerText = "No Record(s) found";
        }
    }


    public void DownlaodExcel(string sQry)
    {
        DataTable dt = SQL_DB.ExecuteDataTable(sQry);
        //Build the CSV file data as a Comma separated string.
        string csv = string.Empty;

        foreach (DataColumn column in dt.Columns)
        {
            //Add the Header row for CSV file.
            csv += column.ColumnName + ',';
        }

        //Add new line.
        csv += "\r\n";

        foreach (DataRow row in dt.Rows)
        {
            foreach (DataColumn column in dt.Columns)
            {
                //Add the Data rows.
                csv += row[column.ColumnName].ToString().Replace(",", ";") + ',';
            }

            //Add new line.
            csv += "\r\n";
        }

        //Download the CSV file.
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=Vendor_TransactionDetails.csv");
        Response.Charset = "";
        Response.ContentType = "application/text";
        Response.Output.Write(csv);
        Response.Flush();
        Response.End();
    }

    protected void btnDownload_Click(object sender, EventArgs e)
    {
        string sQry = "Select * from Transactions Where CompId='" + hdnCompId.Value + "'";
        DownlaodExcel(sQry);
    }
}