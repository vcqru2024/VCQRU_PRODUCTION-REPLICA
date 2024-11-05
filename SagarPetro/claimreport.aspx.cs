using Business_Logic_Layer;
using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class SagarPetro_claimreport : System.Web.UI.Page
{
    public int str = 0, strr = 0, aflag = 0, dflag = 0; public int index = 0;
   
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Session["CompanyId"] == null)
            Response.Redirect("~Sagarpetro/Loginpfl.aspx? from= claim");
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


        DataSet ds = Warranty.GetClaimDetailVendor(email);
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
    protected void btnDownloadExcel_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = Warranty.GetClaimDetailVendor(Session["CompanyId"].ToString());
            XLWorkbook wb = new XLWorkbook();
            wb.Worksheets.Add(ds.Tables[0], "Loyalty Claim Payment Report");
            MemoryStream stream = new MemoryStream();
            wb.SaveAs(stream);
            //Return xlsx Excel File  

            Response.Clear();
            Response.ContentType = "application/force-download";
            Response.AddHeader("content-disposition", "attachment;    filename=Loyalty_Claim_BankPayment_Report.xlsx");
            Response.BinaryWrite(stream.ToArray());
            Response.End();
         
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
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbl = (Label)e.Row.FindControl("lblExpDate");
            HtmlAnchor hreft = (HtmlAnchor)e.Row.FindControl("btn");
            if (lbl.Text == "Approved")
            {
                hreft.Attributes.Remove("href");

            }
            else if (lbl.Text == "Rejected")
            {
                hreft.Attributes.Remove("href");
            }
            else
            {
                hreft.HRef = "javascript:void(0)";
            }
        }
    }

   
}