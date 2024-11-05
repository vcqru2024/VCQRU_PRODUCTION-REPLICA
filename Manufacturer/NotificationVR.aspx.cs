using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_NotificationVR : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            NewMsgpop.Visible = false;
            DataTable dt = new DataTable();
           // string ss = "select notifiDetail from vr_notification";

            dt = SQL_DB.ExecuteDataTable("select notifiDetail from vr_notification");

            if (dt.Rows.Count > 0)
            {
                notificationMsg.Text = dt.Rows[0]["notifiDetail"].ToString();
            }
            else
            {

            }
        }
    }

    protected void ImgSearch_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        if (notificationMsg.Text != "")
        {
            string result = string.Empty;
            DataTable dt = new DataTable();
            dt = SQL_DB.ExecuteDataTable("select notifiDetail from vr_notification");
            if (dt.Rows.Count > 0)
            {
                SQL_DB.ExecuteNonQuery("update vr_notification set  notifiDetail='" + notificationMsg.Text + "', created_at='" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "' ");
                NewMsgpop.Visible = true;
                LblMsgUpdate.Text = "updated Successfully!";
            }
        }
        else
        {
            NewMsgpop.Visible = true;
            LblMsgUpdate.Text = "Please select enter fields!";
            //ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
            //      "<script>alert('Please select KYC Status!')</script>");
        }

    }

}