using System.Web.UI;
using System.IO;
using ClosedXML.Excel;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Manufacturer_ProductWiseCodeCheckVr : System.Web.UI.Page
{
    private static Database database = DatabaseFactory.CreateDatabase();
    private static DbCommand dbCommand;
    cls_VRKABLE vr = new cls_VRKABLE();
    string compid = "Comp-1400";
    protected void Page_Load(object sender, EventArgs e)
    {
        btn_download3.Visible = false;
        GridProductWise.Visible = false;
        ErrorMsg.InnerText = "";

        if (!IsPostBack)
        {
           
            BindProducts();
        }
    }

    protected void btn_download_Click_drpdown(object sender, EventArgs e)
    {

        if (Page.IsValid)
        {
            try
            {
                string proid = ddlProducts.SelectedValue;
                if (proid != "0")
                {
                    DataTable dt = vr.GetvrkableGetCheckCodeByProduct("USP_ProductWiseUserCount", compid, proid);
                    if (dt.Rows.Count > 0)
                    {
                        XLWorkbook wb = new XLWorkbook();
                        wb.Worksheets.Add(dt, "User_ProductWiseCodeCheck");
                        MemoryStream stream = new MemoryStream();
                        wb.SaveAs(stream);
                        Response.Clear();
                        Response.ContentType = "application/force-download";
                        Response.AddHeader("content-disposition", "attachment; filename=User_ProductWiseCodeCheck.xlsx");
                        Response.BinaryWrite(stream.ToArray());
                        Response.End();
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }


    protected void ImgSearch_Click3(object sender, EventArgs e)
    {
        try
        {
          
            string proid = ddlProducts.SelectedValue;
            if (proid != "0")
            {
                DataTable dt = vr.GetvrkableGetCheckCodeByProduct("USP_ProductWiseUserCount", compid, proid);
                if (dt.Rows.Count > 0)
                {
                    btn_download3.Visible = true;
                    GridProductWise.Visible = true;
                    GridProductWise.DataSource = dt;
                    GridProductWise.DataBind();
                }
                else
                {
                    ErrorMsg.InnerText = "Record not found!";
                }
            }
            else
            {
                ErrorMsg.InnerText = "Please select product!";
            }

        }
        catch (Exception ex)
        {
            throw ex;
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
        ddlProducts.DataValueField = "Pro_ID";
        ddlProducts.DataTextField = "Pro_Name";
        ddlProducts.DataSource = dt;
        ddlProducts.DataBind();
        ddlProducts.Items.Insert(0, new ListItem("Select Product", "0"));
    }

    protected void ImgRefresh_Click3(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("ProductWiseCodeCheckVr.aspx");
    }



}