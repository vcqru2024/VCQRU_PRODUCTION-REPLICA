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

public partial class SagarPetro_Loyalityclaimsgr : System.Web.UI.Page
{
    public int str = 0, strr = 0, aflag = 0, dflag = 0; public int index = 0;
    cls_patanjali db = new cls_patanjali();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../SagarPetro/Loginpfl.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }

        if (!Page.IsPostBack)
        {

            if (!string.IsNullOrEmpty(Session["CompanyId"].ToString()))
                FillGrdLoyaltyAwards(Session["CompanyId"].ToString());

           
        }
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    private void FillGrdLoyaltyAwards(string email)
    {


        // DataSet ds = Warranty.GetClaimDetailVendor(email);
        DataSet ds = SQL_DB.ExecuteDataSet("exec USP_Claimloyalityreportsgr '"+ email + "'");
        if (ds.Tables.Count > 0)
        {
            GrdAwards.DataSource = ds.Tables[0];
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
            DataSet ds = SQL_DB.ExecuteDataSet("exec USP_Claimloyalityreportsgr '" + Session["CompanyId"].ToString() + "'");
            XLWorkbook wb = new XLWorkbook();
            wb.Worksheets.Add(ds.Tables[0], "Loyalty Claim Report");
            MemoryStream stream = new MemoryStream();
            wb.SaveAs(stream);
            Response.Clear();
            Response.ContentType = "application/force-download";
            Response.AddHeader("content-disposition", "attachment;    filename=Loyalty_Claim_Report.xlsx");
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
        if (!string.IsNullOrEmpty(Session["CompanyId"].ToString()))
            FillGrdLoyaltyAwards(Session["CompanyId"].ToString());
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        if (!string.IsNullOrEmpty(Session["CompanyId"].ToString()))
            FillGrdLoyaltyAwards(Session["CompanyId"].ToString());
    }
    protected void GrdAwards_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
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



    protected void dropdownstatus_SelectedIndexChanged(object sender, EventArgs e)
    {
       // bindgridview();
    }

    protected void btnseach_Click(object sender, EventArgs e)
    {
       // bindgridview();
    }
    //public void bindgridview()
    //{
    //    if (dropdownstatus.SelectedItem.Value == "-1")
    //    {
    //        db.ShowErrorMessage(this, "Please select status");
    //        return;
    //    }
    //    if (dropdownstatus.SelectedItem.Value != "-1")
    //    {
    //        string Datefrom = "";
    //        string Dateto = "";
    //        string Mobileno = txtMobilenumber.Text;
    //        if (Mobileno.Length == 10)
    //            Mobileno = "91" + Mobileno;
    //        if (!string.IsNullOrEmpty(txtfromdate.Text))
    //        {
    //            Datefrom = txtfromdate.Text + (" 00:00:00.001");
    //        }
    //        if (!string.IsNullOrEmpty(txtfromdate.Text))
    //        {
    //            Dateto = txttodate.Text + (" 23:59:59.999");
    //        }
    //        if ((Datefrom != "" && Dateto == "") || (Datefrom == "" && Dateto != ""))
    //        {
    //            db.ShowErrorMessage(this, "Please Select Date Range");
    //            return;
    //        }

    //        DataTable dt = SQL_DB.ExecuteDataTable("exec USP_Claimloyalityreportsgr '" + Session["CompanyId"].ToString() + "','" + Mobileno + "','" + dropdownstatus.SelectedItem.Text + "','" + Datefrom + "','" + Dateto + "'");
    //        if (dt.Rows.Count > 0)
    //        {
    //            GrdAwards.DataSource = dt;
    //            GrdAwards.DataBind();
    //            lblcount.Text = dt.Rows.Count.ToString();
    //            if (GrdAwards.Rows.Count > 0)
    //                GrdAwards.HeaderRow.TableSection = TableRowSection.TableHeader;
    //        }
    //    }
    //}
}