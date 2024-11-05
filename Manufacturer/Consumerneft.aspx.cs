using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_Consumerneft : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("~/Login.aspx?Page=FrmUploadDealerCode");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("~/adminLogin.aspx");
        }
        if (!IsPostBack)
        {
            Bindgrid();
        }
    }
    public void Bindgrid()
    {

        DataTable dt = SQL_DB.ExecuteDataTable("exec USP_GetConsumerNEFT_Tesla  '" + Session["CompanyId"].ToString() + "'");
        rptData.DataSource = dt;
        rptData.DataBind();
    }
    protected void btn_download_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                DataTable dt = SQL_DB.ExecuteDataTable("exec USP_GetConsumerNEFT_Tesla  '" + Session["CompanyId"].ToString() + "'");
                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "Consumer_neft");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=Consumer_neft.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}