using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using ClosedXML.Excel;

public partial class Manufacturer_FrmOemReports : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("~/Login.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("~/adminLogin.aspx");
        }
        if (!IsPostBack)
        {
            //Bindgrid();
            bindddl();
        }

    }

    public void bindddl()
    {
        DataTable dtuser = SQL_DB.ExecuteDataTable("SELECT  Userrole_id, Username FROM tbl_hpl_users WHERE MappedCompid = 'Comp-1624'");
        // Bind the DropDownList
        DropDownList1.DataSource = dtuser;
        DropDownList1.DataTextField = "Username";
        DropDownList1.DataValueField = "Userrole_id";
        DropDownList1.DataTextField = "Username";// Assuming UserID is the primary key

        DropDownList1.DataBind();
        DropDownList1.Items.Insert(0, new ListItem("Select username", "0"));
    }

   
    public void Bindgrid()
    
    {
      
        string userid = string.Empty;
        if(ViewState["userid"] != null)
        {
            userid = ViewState["userid"].ToString();

        }
        if (DropDownList1.Text == "")
        {
            LblMsg.Text = "Please Select username";

        }
        else {
            SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("USP_GetOEMReports_HPL", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@companyid", Session["companyid"].ToString());
            cmd.Parameters.AddWithValue("@userid", userid);
            //  cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            grd1.DataSource = dt;
            grd1.DataBind();
        }

    }
    protected void btn_download_Click(object sender, EventArgs e)
    {
        

        if (Page.IsValid)
        {
            try
            {
                DataTable dtgried = SQL_DB.ExecuteDataTable("exec USP_GetOEMReports_HPL '" + Session["companyid"].ToString() + "','" + DropDownList1.SelectedItem.Value + "'");
                if(dtgried.Rows.Count >0)
                {
                    XLWorkbook wb = new XLWorkbook();
                    wb.Worksheets.Add(dtgried, "OEM_details");
                    MemoryStream stream = new MemoryStream();
                    wb.SaveAs(stream);
                    Response.Clear();
                    Response.ContentType = "application/force-download";
                    Response.AddHeader("content-disposition", "attachment;    filename=User_details.xlsx");
                    Response.BinaryWrite(stream.ToArray());
                    Response.End();

                }
               
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }

    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {

        string usernm = DropDownList1.SelectedItem.Value;
        if (!string.IsNullOrEmpty(usernm))
        {
            DataTable dtgried = SQL_DB.ExecuteDataTable("exec USP_GetOEMReports_HPL '"+ Session["companyid"].ToString() + "','" + usernm + "'");
            if (dtgried.Rows.Count >0)
            {
                grd1.DataSource = dtgried;
                grd1.DataBind();
            }
        }


    }

protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        grd1.DataSource = null;
        grd1.DataBind();
    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        if (string.IsNullOrEmpty(DropDownList1.SelectedItem.Value))
        {
            LblMsg.Text = "Please Select username";
        }

        else
        {
            ViewState["userid"] = DropDownList1.SelectedItem.Value;
            Bindgrid();
        }
    }
}
