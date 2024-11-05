using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_CommissionSetting : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        GetInstantPayoutVendorDetails();
       
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
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(Pds, "Comp_ID", "Comp_Name", ddlcompany, "--Select--");
            ddlcompany.SelectedIndex = 0;
        }

    }

    public void DataBind()
    {
        string query = "USP_GetCommissionVendorWise";//not recommended this i have written just for example,write stored procedure for security  
        SqlCommand com = new SqlCommand();
        com.CommandText = query;
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@Comp_Id", ddlcompany.SelectedItem.Value);
        com.Parameters.AddWithValue("@Service_Id", ddlservice.SelectedItem.Value);
        com.Connection = dtcon.OpenConnection();
        SqlDataAdapter da = new SqlDataAdapter(com);
        DataTable Walletdt = new DataTable();
        da.Fill(Walletdt);


        if (Walletdt.Rows.Count > 0)
        {
            gridview1.DataSource = Walletdt;
            gridview1.DataBind();
        }

    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }

    protected void gridview1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gridview1.EditIndex = e.NewEditIndex;
        gridview1.ShowFooter = false;
    }

    protected void gridview1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {

    }

    protected void gridview1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
       
        try
        {
            GridViewRow row = gridview1.Rows[e.RowIndex];

            Label lbl_ID = row.FindControl("lbl_ID") as Label;

           // HiddenField field = (HiddenField)gridview1.Rows[gridview1.SelectedIndex].FindControl("hdfchargetype");
           //// string sValue = ((HiddenField)gridview1.Rows[e.RowIndex].FindControl("hdfchargetype")).Value;


           // HiddenField hdfchargetyp = gridview1.Rows[e.RowIndex].FindControl("hdfchargetype") as HiddenField;
           // HiddenField hfComm_ID = gridview1.Rows[e.RowIndex].FindControl("hfComm_ID") as HiddenField;
           // HiddenField hfSlab_Id = gridview1.Rows[e.RowIndex].FindControl("hfSlab_Id") as HiddenField;
            TextBox txt_Charge_Amount = gridview1.Rows[e.RowIndex].FindControl("txt_Charge_Amount") as TextBox;
            DropDownList ddlCharge_Type = gridview1.Rows[e.RowIndex].FindControl("ddlCharge_Type") as DropDownList;


           
            DataTable dt = new DataTable();
            string query = "select Comp_Id,Service_Id,Slab_Id from tblcommission where Comp_Id='" + ddlcompany.SelectedItem.Value + "' and Service_Id='" + ddlservice.SelectedItem.Value + "' and Slab_Id='" + lbl_ID.Text + "'";
            SqlCommand com = new SqlCommand();
            com.CommandText = query;

            com.Connection = dtcon.OpenConnection();
            SqlDataAdapter da = new SqlDataAdapter(com);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                SQL_DB.ExecuteNonQuery("update tblcommission set Charge_Amount='" + txt_Charge_Amount.Text + "',Charge_Type='" + ddlCharge_Type.SelectedItem.Value + "' where Comp_Id='" + ddlcompany.SelectedItem.Value + "' and Service_Id='" + ddlservice.SelectedItem.Value + "' and Slab_Id='" + lbl_ID.Text + "'");
            }
            else
            {
                SQL_DB.ExecuteNonQuery("insert into tblcommission(Comp_Id,Service_Id,Slab_Id, Charge_Amount,Charge_Type)values('" + ddlcompany.SelectedItem.Value + "','" + ddlservice.SelectedItem.Value + "','" + lbl_ID.Text + "','" + txt_Charge_Amount.Text + "','" + ddlCharge_Type.SelectedItem.Value + "')");
            }

            DataBind();
        }
        catch
        {

        }

            
        

    }

    protected void gridview1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            try
            {
                HiddenField hdfchargetyp = (e.Row.FindControl("hdfchargetype") as HiddenField);
                HiddenField hfComm_ID = (e.Row.FindControl("hfComm_ID") as HiddenField);
                HiddenField hfSlab_Id = (e.Row.FindControl("hfSlab_Id") as HiddenField);
                TextBox txt_Charge_Amount = (e.Row.FindControl("txt_Charge_Amount") as TextBox);
                DropDownList ddlselectedCharge_Type = (e.Row.FindControl("ddlselectedCharge_Type") as DropDownList);
                DropDownList ddlCharge_Type = (e.Row.FindControl("ddlCharge_Type") as DropDownList);


                string ChargeType = hdfchargetyp.Value;

                ddlselectedCharge_Type.SelectedValue = hdfchargetyp.Value;
                ddlselectedCharge_Type.Enabled = false;


            }
            catch
            {

            }
           
        }
    }
}