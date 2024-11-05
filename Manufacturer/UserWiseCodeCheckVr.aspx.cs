using System.Web.UI;
using System.IO;
using ClosedXML.Excel;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
public partial class Manufacturer_UserWiseCodeCheckVr : System.Web.UI.Page
{
    private static Database database = DatabaseFactory.CreateDatabase();
    private static DbCommand dbCommand;
    cls_VRKABLE vr = new cls_VRKABLE();
    string compid = "Comp-1400";
    protected void Page_Load(object sender, EventArgs e)
    {

        btn_download2.Visible = false;
        GridUserWiseLoyalty.Visible = false;
        ErrorMsg.InnerText = "";

        if (!IsPostBack)
        {

             txtDateFrom2.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
             txtDateto2.Text = System.DateTime.Now.ToString("yyyy-MM-dd");

            // txtDateFrom2.Text = "";
            // txtDateto2.Text = "";
            BindProducts();
        }
    }

   
    protected void btn_download_Click2(object sender, EventArgs e)
    {
        try
        {
            var MobileNo = Mobile.Text.Trim();

        if ((MobileNo.Length < 10 && MobileNo.Length > 0) || MobileNo.Length > 10)
        {
            ErrorMsg.InnerText = "Invalid mobile number!";
        }
        if (MobileNo.Length < 1)
        {
            MobileNo = "All";
        }

        DataTable dt = vr.GetvrCodeCheckUserWise("USP_GetUserWiseLoyalty", compid, txtDateFrom2.Text + " 00:00:00.000", txtDateto2.Text + " 23:59:59.000", MobileNo);
        if (dt.Rows.Count > 0)
        {
            XLWorkbook wb = new XLWorkbook();
            wb.Worksheets.Add(dt, "Users_CodeCheckUserWise");
            MemoryStream stream = new MemoryStream();
            wb.SaveAs(stream);
            Response.Clear();
            Response.ContentType = "application/force-download";
            Response.AddHeader("content-disposition", "attachment;    filename=User_CodeCheckUserWise.xlsx");
            Response.BinaryWrite(stream.ToArray());
            Response.End();
        }
        }
        catch
        {
            ErrorMsg.InnerText = "Something went wrong!";
        }
        finally
        {

        }


    }


    protected void ImgSearch_Click2(object sender, EventArgs e)
    {
        try
        {
            var MobileNo = Mobile.Text.Trim();

            if ((MobileNo.Length < 10 && MobileNo.Length > 0) || MobileNo.Length > 10)
            {
                ErrorMsg.InnerText = "Invalid mobile number!";
            }
            if (MobileNo.Length < 1)
            {
                MobileNo = "All";
            }

            GridUserWiseLoyalty.Visible = true; DataTable dt = vr.GetvrCodeCheckUserWise("USP_GetUserWiseLoyalty", compid, txtDateFrom2.Text + " 00:00:00.000", txtDateto2.Text + " 23:59:59.000", MobileNo);
            if (dt.Rows.Count > 0)
            {
                ErrorMsg.InnerText = "";
                btn_download2.Visible = true;
                GridUserWiseLoyalty.Visible = true;
                GridUserWiseLoyalty.DataSource = dt;
                GridUserWiseLoyalty.DataBind();
            }
            else
            {
                ErrorMsg.InnerText = "Record not found!";
            }
        }
        catch
        {
            ErrorMsg.InnerText = "Something went wrong!";
        }
        finally
        {

        }

      
    }


    public void BindProducts()
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("select Pro_ID,Pro_Name from Pro_Reg where Comp_ID='" + compid + "'", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
    }


    protected void ImgRefresh_Click2(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("UserWiseCodeCheckVr.aspx");
    }
 
}