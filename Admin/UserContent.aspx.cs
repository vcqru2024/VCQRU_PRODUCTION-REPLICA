using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class Admin_UserContent : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("../Login.aspx"); 
        if(!IsPostBack)
            FillDetail();
    }

    private void FillDetail()
    {
        DataTable DtDetail = new DataTable();
        SQL_DB.GetDA("SELECT [tbl_id],[Menu_Heading],[Menu_Content] FROM [M_Content] where tbl_id="+ddlMenuHeading.SelectedValue.ToString()).Fill(DtDetail);
        if (DtDetail.Rows.Count > 0)
        {
            Editor1.Content = DtDetail.Rows[0]["Menu_Content"].ToString();
            ddlMenuHeading.SelectedValue = DtDetail.Rows[0]["tbl_id"].ToString();
        }
    }

    protected void ddlMenuHeading_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillDetail();
    }

    protected void btnsave_Click(object sender, ImageClickEventArgs e)
    {
        SQL_DB.ExecuteNonQuery("UPDATE [M_Content] SET [Menu_Content] = '"+Editor1.Content.Replace("'","''")+"' WHERE [tbl_id]="+ddlMenuHeading.SelectedValue.ToString());
        FillDetail();
        lblmdg.Text = "Record Updated Successfully...";
    }
    protected void btncancel_Click(object sender, ImageClickEventArgs e)
    {
        Editor1.Content = "";
        lblmdg.Text = "";
    }

}
