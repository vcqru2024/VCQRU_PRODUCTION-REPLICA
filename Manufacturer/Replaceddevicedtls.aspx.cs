using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_Replaceddevicedtls : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["CompanyId"] == null)
        {
            Response.Redirect("/Login.aspx");
            //Response.Redirect("default.aspx?Page=frmManfEnquiry.aspx");
        }
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");

        }
        if (!Page.IsPostBack)
        {
           
            DataTable dtdetails = new DataTable();
            dtdetails = SQL_DB.ExecuteDataTable("select b.MobileNo,b.OldCode,b.NewCode,b.OldUniqueDeviceId,b.NewUniqueDeviceId,b.MappingDate,b.Remark  from WarrentyDetails a inner join  tbl_Warranty_mapping b on a.id = b.Oldcodeid order by b.id desc");

            if (dtdetails.Rows.Count > 0)
            {
                GridView1.DataSource = dtdetails;
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataSource = "";
                GridView1.DataBind();
            }
        }
    }
}