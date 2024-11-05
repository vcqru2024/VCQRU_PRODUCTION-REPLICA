using System.Web.UI;
using System.IO;
using ClosedXML.Excel;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
public partial class UserRegistrationVr : System.Web.UI.Page
{
    private static Database database = DatabaseFactory.CreateDatabase();
    private static DbCommand dbCommand;
    cls_VRKABLE vr = new cls_VRKABLE();
    string compid = "Comp-1400";
    protected void Page_Load(object sender, EventArgs e)
    {
        btn_download.Visible = false;
        grd1.Visible = false;
        ErrorMsg.InnerText = "";

        if (!IsPostBack)
        {
            txtDateFrom.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
            txtDateto.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
        }
    }

    protected void btn_download_Click(object sender, EventArgs e)
    {

        DataTable dt = vr.GetvrkableUserTotalUserBydate("USP_GetUserCountwithRole", txtDateFrom.Text + " 00:00:00.000", txtDateto.Text + " 23:59:59.000");
        if (dt.Rows.Count > 0)
        {
            XLWorkbook wb = new XLWorkbook();
            wb.Worksheets.Add(dt, "Users_by_Role");
            MemoryStream stream = new MemoryStream();
            wb.SaveAs(stream);
            Response.Clear();
            Response.ContentType = "application/force-download";
            Response.AddHeader("content-disposition", "attachment;    filename=Users_by_Role.xlsx");
            Response.BinaryWrite(stream.ToArray());
            Response.End();
        }

    }

    protected void ImgSearch_Click(object sender, EventArgs e)
    {
        grd1.Visible = true;
        DataTable dt = vr.GetvrkableUserTotalUserBydate("USP_GetUserCountwithRole", txtDateFrom.Text + " 00:00:00.000", txtDateto.Text + " 23:59:59.000");
        if (dt.Rows.Count > 0)
        {
            btn_download.Visible = true;
            grd1.DataSource = dt;
            grd1.DataBind();
        }
        else
        {
            ErrorMsg.InnerText = "Record not found!";
        }

    } 

    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("UserRegistrationVr.aspx");
    }
  
}