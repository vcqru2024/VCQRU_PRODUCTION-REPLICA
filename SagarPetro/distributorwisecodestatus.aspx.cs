using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ClosedXML.Excel;
using System.IO;

public partial class Manufacturer_distributorwisecodestatus : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataTable dt = binddata();
            grd1.DataSource = dt;
            grd1.DataBind();
        }
    }
    public DataTable  binddata()
    {
        DataTable dt = SQL_DB.ExecuteDataTable("exec USP_GetDistributorwisecodestatus '"+Session["CompanyId"].ToString()+"'");
        return dt;
    }

    protected void btn_download_Click(object sender, EventArgs e)
    {
       
        try
        {

            DataTable dt = binddata();
            XLWorkbook wb = new XLWorkbook();
            wb.Worksheets.Add(dt, "Distributorwisecodestatus");
            MemoryStream stream = new MemoryStream();
            wb.SaveAs(stream);
            Response.Clear();
            Response.ContentType = "application/force-download";
            Response.AddHeader("content-disposition", "attachment;    filename=Distributorwisecodestatus.xlsx");
            Response.BinaryWrite(stream.ToArray());
            Response.End();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}