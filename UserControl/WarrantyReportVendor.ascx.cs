using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Business9420;
using System.Web.Services;
using System.Web.Script.Services;
using System.IO;
using Business_Logic_Layer;
using ClosedXML.Excel;
using System.Web.UI.HtmlControls;

public partial class UserControl_Wrv : System.Web.UI.UserControl
{
    public int str = 0, strr = 0, aflag = 0, dflag = 0; public int index = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("Default.aspx?Page=WarrantyReportVendor.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!Page.IsPostBack)
        {
            if (!string.IsNullOrEmpty(Session["CompanyId"].ToString()))
                FillGrdLoyaltyAwards(Session["CompanyId"].ToString());

            newMsg.Visible = false;
            //lblcount.Text = "0";
        }
        Label2.Text = "";
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        // FillGrdLoyaltyAwards();
    }
    private void FillGrdLoyaltyAwards(string email)
    {
        if (Session["CompanyId"].ToString() == "Comp-1629")
        {
            GrdAwards.Columns[0].HeaderText = "Vehicle no";
            GrdAwards.Columns[12].HeaderText = "Device";
            GrdAwards.Columns[12].Visible = true;
        }
        else if (Session["CompanyId"].ToString() != "Comp-1629")
        {
            GrdAwards.Columns[13].Visible = false;
        }
        DataSet ds = Warranty.GetWarrantyDetailVendor(email);
        if (ds.Tables.Count > 0)
        {
            GrdAwards.DataSource = ds;
            GrdAwards.DataBind();
            lblcount.Text = ds.Tables[0].Rows.Count.ToString();
            if (GrdAwards.Rows.Count > 0)
                GrdAwards.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
        else
            lblcount.Text = "0";
    }

    private void FillImageGrid(int id)
    {

        DataSet ds = Warranty.GetImages(id);
        if (ds.Tables.Count > 0)
        {

            gvImage.DataSource = ds;
            gvImage.DataBind();

        }
    }
    protected void btnDownloadExcel_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = Warranty.GetWarrantyDetailVendor_download(Session["CompanyId"].ToString());
            XLWorkbook wb = new XLWorkbook();
            wb.Worksheets.Add(ds.Tables[0], "Warranty Report");
            MemoryStream stream = new MemoryStream();
            wb.SaveAs(stream);
            //Return xlsx Excel File  

            Response.Clear();
            Response.ContentType = "application/force-download";
            Response.AddHeader("content-disposition", "attachment;    filename=Warranty_Report.xlsx");
            Response.BinaryWrite(stream.ToArray());
            Response.End();
            // return  File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet","Enquiry Details");

            //DownlaodExcel(ds.Tables[0]);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        if (!string.IsNullOrEmpty(Session["CompanyId"].ToString()))
            FillGrdLoyaltyAwards(Session["CompanyId"].ToString());
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtsearchlblname.Text = string.Empty;
        newMsg.Visible = false;
        if (!string.IsNullOrEmpty(Session["CompanyId"].ToString()))
            FillGrdLoyaltyAwards(Session["CompanyId"].ToString());
    }
    protected void GrdAwards_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdAwards.PageIndex = e.NewPageIndex;
        if (!string.IsNullOrEmpty(Session["CompanyId"].ToString()))
            FillGrdLoyaltyAwards(Session["CompanyId"].ToString());
    }

    private string FindStatus(int Status)
    {
        if (Status == 1)
            return "De-Activate";
        else
            return "Activate";
    }
    private string FindStatus1(int Status)
    {
        if (Status == 0)
            return "De-Activated";
        else
            return "Activated";
    }

    [WebMethod]
    [ScriptMethod]
    public static bool checkNewLabel(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Label_Name] FROM [M_Label] where [Label_Name] = '" + res + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }

    protected void GrdAwards_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{ 

        //}
    }


 protected void GrdAwards_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbl = (Label)e.Row.FindControl("lblVendorClaimStatus");
            
            HtmlAnchor hreft = (HtmlAnchor)e.Row.FindControl("btn");

            if (lbl.Text == "Approved")
            {
                hreft.Attributes.Remove("href");

            }
            else if (lbl.Text == "Reject")
            {
                hreft.Attributes.Remove("href");
            }
            else
            {
                hreft.HRef = "javascript:void(0)";
            }
        }
    }

    protected void lnkDownload_Click(object sender, EventArgs e)
    {
        LinkButton lnkbtn = sender as LinkButton;
        GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
        string filePath = GrdAwards.DataKeys[gvrow.RowIndex].Values[0].ToString();
        string root = @"C:\inetpub\wwwroot\httpdocs";
       string filePath1 = filePath.Replace(@"/", @"\").Replace(@"\\",@"\").Replace("~", root);
        if (filePath != null && File.Exists(filePath1))
        {
            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/pdf";//"image/jpg";
            Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filePath + "\"");
            Response.TransmitFile(Server.MapPath(filePath));
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.End();
        }
    }
    protected void lnkDownloadProduct_Click(object sender, EventArgs e)
    {
       LinkButton lnkbtn = sender as LinkButton;
        GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
        string filePath = GrdAwards.DataKeys[gvrow.RowIndex].Values[1].ToString();
       string root = @"C:\inetpub\wwwroot\httpdocs";
        string filePath1 = filePath.Replace(@"/", @"\").Replace(@"\\", @"\").Replace("~", root);
        if (filePath != null && File.Exists(filePath1))
        {
            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/pdf";//"image/jpg";
            Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filePath + "\"");
            Response.TransmitFile(Server.MapPath(filePath));
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.End();
        }
    }
    protected void lnkDownloadProduct1_Click(object sender, EventArgs e)
    {
        LinkButton lnkbtn = sender as LinkButton;
        GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
        string filePath = gvImage.DataKeys[gvrow.RowIndex].Values[0].ToString();
        string root = @"C:\inetpub\wwwroot\httpdocs";
        string filePath1 = filePath.Replace(@"/", @"\").Replace(@"\\", @"\").Replace("~", root);
        if (filePath != null && File.Exists(filePath1))
        {            
            Response.ContentType = "image/jpg";
            Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filePath + "\"");
            Response.TransmitFile(Server.MapPath(filePath));
            Response.End();
        }      

    }
}