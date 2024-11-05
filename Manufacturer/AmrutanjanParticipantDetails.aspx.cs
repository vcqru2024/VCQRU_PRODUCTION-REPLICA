using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;


public partial class Manufacturer_AmrutanjanParticipantDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!Page.IsPostBack)
        {
            txtfromdate.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
            txttodate.Text = txtfromdate.Text;

            Binddata();

        }
    }
    private void Binddata()
    {
        string Fromdate = txtfromdate.Text + " 00:00:00.000";
        string Todate = txttodate.Text + " 23:59:59.000";

        DataSet dtTrans = new DataSet();
        //new
        if (ddlmode.SelectedItem.Text != "--Select Mode--" && ddlkyc.SelectedItem.Text != "--Select Kyc--" && txtstate.Text == "")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Mode", ddlmode.SelectedItem.Text, "@State", "", "@Product", "", "@Kyc", ddlkyc.SelectedItem.Text);

        else if (txtproduct.SelectedItem.Text != "--Select Product--" && ddlmode.SelectedItem.Text != "--Select Mode--" && ddlkyc.SelectedItem.Text != "--Select Kyc--" && txtstate.Text == "")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Product", txtproduct.SelectedItem.Text, "@Mode", ddlmode.SelectedItem.Text, "@Kyc", ddlkyc.SelectedItem.Text);

        else if (txtproduct.SelectedItem.Text == "--Select Product--" && ddlmode.SelectedItem.Text != "--Select Mode--" && ddlkyc.SelectedItem.Text != "--Select Kyc--" && txtstate.Text != "")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Mode", ddlmode.SelectedItem.Text, "@State", txtstate.Text, "@Product", "", "@Kyc", ddlkyc.SelectedItem.Text);

        else if (txtproduct.SelectedItem.Text != "--Select Product--" && ddlmode.SelectedItem.Text != "--Select Mode--" && ddlkyc.SelectedItem.Text != "--Select Kyc--" && txtstate.Text != "")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Mode", ddlmode.SelectedItem.Text, "@State", txtstate.Text, "@Product", txtproduct.SelectedItem.Text, "@Kyc", ddlkyc.SelectedItem.Text);
        //new

        else if (ddlmode.SelectedItem.Text != "--Select Mode--" && txtstate.Text == "" && txtproduct.SelectedItem.Text == "--Select Product--")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Mode", ddlmode.SelectedItem.Text);

        else if (txtproduct.SelectedItem.Text != "--Select Product--" && ddlmode.SelectedItem.Text != "--Select Mode--" && txtstate.Text != "")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Product", txtproduct.SelectedItem.Text, "@State", txtstate.Text, "@Mode", ddlmode.SelectedItem.Text);
        else if (txtproduct.SelectedItem.Text != "--Select Product--" && ddlmode.SelectedItem.Text != "--Select Mode--")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Product", txtproduct.SelectedItem.Text, "@Mode", ddlmode.SelectedItem.Text);
        else if (txtproduct.SelectedItem.Text != "--Select Product--" && ddlmode.SelectedItem.Text == "--Select Mode--")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Product", txtproduct.SelectedItem.Text);
        else if (txtstate.Text != "" && ddlmode.SelectedItem.Text != "--Select Mode--")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@State", txtstate.Text, "@Mode", ddlmode.SelectedItem.Text);
        else if (txtstate.Text != "")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@State", txtstate.Text);
        else
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Mode", ddlmode.SelectedItem.Text);

        GridView1.DataSource = dtTrans;

        if (dtTrans.Tables.Count > 0)
        {
            //if (dtTrans.Tables[0].Rows.Count ==0)
            //{
            //    Response.Write("<script>alert('Select Mode ! ')</script>");
            //}
            GridView1.Visible = true;
            GridView1.DataSource = dtTrans.Tables[0];
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSource = "";
            GridView1.Visible = false;
        }

    }
    protected void btnSearch_Click(object sender, ImageClickEventArgs e)
    {

        Binddata();
    }

    protected void btnDownloadExcel_Click(object sender, EventArgs e)
    {
        string Fromdate = txtfromdate.Text + " 00:00:00.000";
        string Todate = txttodate.Text + " 23:59:59.000";
        DataSet dtTrans = new DataSet();
        //new
        if (ddlmode.SelectedItem.Text != "--Select Mode--" && ddlkyc.SelectedItem.Text != "--Select Kyc--" && txtstate.Text == "")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Mode", ddlmode.SelectedItem.Text, "@State", "", "@Product", "", "@Kyc", ddlkyc.SelectedItem.Text);

        else if (txtproduct.SelectedItem.Text != "--Select Product--" && ddlmode.SelectedItem.Text != "--Select Mode--" && ddlkyc.SelectedItem.Text != "--Select Kyc--" && txtstate.Text == "")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Product", txtproduct.SelectedItem.Text, "@Mode", ddlmode.SelectedItem.Text, "@Kyc", ddlkyc.SelectedItem.Text);

        else if (txtproduct.SelectedItem.Text == "--Select Product--" && ddlmode.SelectedItem.Text != "--Select Mode--" && ddlkyc.SelectedItem.Text != "--Select Kyc--" && txtstate.Text != "")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Mode", ddlmode.SelectedItem.Text, "@State", txtstate.Text, "@Product", "", "@Kyc", ddlkyc.SelectedItem.Text);

        else if (txtproduct.SelectedItem.Text != "--Select Product--" && ddlmode.SelectedItem.Text != "--Select Mode--" && ddlkyc.SelectedItem.Text != "--Select Kyc--" && txtstate.Text != "")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Mode", ddlmode.SelectedItem.Text, "@State", txtstate.Text, "@Product", txtproduct.SelectedItem.Text, "@Kyc", ddlkyc.SelectedItem.Text);
        //new

        else if (ddlmode.SelectedItem.Text != "--Select Mode--" && txtstate.Text == "" && txtproduct.SelectedItem.Text == "--Select Product--")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Mode", ddlmode.SelectedItem.Text);
        else if (ddlmode.SelectedItem.Text != "--Select Mode--")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate);
        else if (txtproduct.SelectedItem.Text != "--Select Product--" && ddlmode.SelectedItem.Text != "--Select Mode--" && txtstate.Text != "")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Product", txtproduct.SelectedItem.Text, "@State", txtstate.Text, "@Mode", ddlmode.SelectedItem.Text);
        else if (txtproduct.SelectedItem.Text != "--Select Product--" && ddlmode.SelectedItem.Text != "--Select Mode--")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Product", txtproduct.SelectedItem.Text, "@Mode", ddlmode.SelectedItem.Text);

        else if (txtproduct.SelectedItem.Text != "--Select Product--" && ddlmode.SelectedItem.Text == "--Select Mode--")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@Product", txtproduct.SelectedItem.Text, "@Mode", ddlmode.SelectedItem.Text);
        else if (txtstate.Text != "" && ddlmode.SelectedItem.Text != "--Select Mode--")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@State", txtstate.Text, "@Mode", ddlmode.SelectedItem.Text);
        else if (txtstate.Text != "")
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate, "@State", txtstate.Text);
        else
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("Sp_GetParticipantDetails", "@FromDate", Fromdate, "@ToDate", Todate /* , "@Mode" , ddlmode.SelectedItem.Text*/);


        DataTable dt = new DataTable();
        dt = dtTrans.Tables[0];
        //DataTable dt = SQL_DB.ExecuteDataTable(sQry);
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
        Response.AddHeader("content-disposition", "attachment;filename=AmrutanjanParticipantDetails.csv");
        Response.Charset = "";
        //Response.ContentType = "application/text";
        Response.ContentType = "text/csv";
        Response.Output.Write(csv);
        Response.Flush();
        Response.End();
    }

    protected void btnstate_Click(object sender, ImageClickEventArgs e)
    {

    }

    protected void btnproduct_Click(object sender, ImageClickEventArgs e)
    {

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        Binddata();
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {




        if (e.CommandName == "Editt")
        {

            Response.Redirect("Missed_reg.aspx?idd=" + e.CommandArgument);

        }
    }

    protected void btnbrowsesave_ServerClick(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        try
        {

            DataTable pname = SQL_DB.ExecuteDataTable("select ParticipantName,ProofforPurchase from tblParticipant where Id=" + hfidnew1.Value + " ");
            string parname = pname.Rows[0]["ParticipantName"].ToString();
            string doc = pname.Rows[0]["ProofforPurchase"].ToString();

            if (ddlStatus.SelectedValue == "1")
            {
                if (parname == "" && doc == "")
                {
                    Response.Write("<script>alert('Upload document Details Frist ! ')</script>");
                }
                else if (parname != "" && doc == "")
                {
                    Response.Write("<script>alert('Upload document Frist ! ')</script>");
                }
                else if (parname == "" && doc != "")
                {
                    Response.Write("<script>alert('Upload document Frist ! ')</script>");
                }
                else if (parname != "" && doc != "")
                {
                    SqlCommand cmd = new SqlCommand("sp_updatekyc", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@action", "Accepted");
                    cmd.Parameters.AddWithValue("@id", hfidnew1.Value);
                    cmd.Parameters.AddWithValue("@comment", txtcomment.Text);
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Kyc Completed ! ')</script>");
                }

            }
            else
            {
                    SqlCommand cmd = new SqlCommand("sp_updatekyc", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@action", "Rejected");
                    cmd.Parameters.AddWithValue("@comment", txtcomment.Text);
                    cmd.Parameters.AddWithValue("@id", hfidnew1.Value);
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Kyc Rejected ! ')</script>");
            }
        }
        catch (Exception ex)
        {

        }
        finally
        {
            con.Close();
        }
        Binddata();
    }


}