using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business9420;
using System.Data;
using ClosedXML.Excel;
using System.IO;

public partial class frmManfEnquiryW : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("Default.aspx?Page=frmManfEnquiryW.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!Page.IsPostBack)
        {
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            allClear();
            fillMode();
            fillData();
        }
    }
    
    private void fillMode()
    {                
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT distinct [Dial_Mode] ,[Dial_Mode] as Dial_Mode1 FROM [Pro_Enq] order by [Dial_Mode]");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Dial_Mode", "Dial_Mode1", ddlMode, "--Select --");
        ddlMode.SelectedIndex = 0;
        FillProducts(Session["CompanyId"].ToString());
    }
    private void FillProducts(string CompID)
    {        
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT DISTINCT Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, Pro_Reg.Comp_ID FROM M_Code FULL OUTER JOIN  Pro_Reg ON M_Code.Pro_ID = Pro_Reg.Pro_ID WHERE (M_Code.Print_Status = 1)  AND (Pro_Reg.Comp_ID = '" + CompID.ToString() + "')");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlproname, "--Product--");
        ddlproname.SelectedIndex = 0;
    }
    private void allClear()
    {
        txtDateFrom.Text = "";
        txtDateTo.Text = "";
        ddlMode.SelectedIndex = 0;
        ddlStatus.SelectedIndex = 0;        
    }
    private void fillData()
    {
        #region Query
        Object9420 Reg = new Object9420();
        if (ddlproname.SelectedIndex > 0)
        {
            Reg.Pro_ID = ddlproname.SelectedValue;
            Reg.Msg = "M_Code.Pro_ID = '" + Reg.Pro_ID + "'";
        }
        else
            Reg.Pro_ID = "";
        if (Reg.Msg != null)
        {
            if (Reg.Msg.Length > 1)
                Reg.Msg = " WHERE " + Reg.Msg;
        }
        Reg.Comp_ID = Session["CompanyId"].ToString();
        if (Reg.Msg != null)
        {
            if (Reg.Msg.Length > 1)
                Reg.Msg += " AND T_Pro.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
        }
        else
            Reg.Msg += " WHERE T_Pro.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
        if (txtDateFrom.Text == "")
            Reg.datefromstr = "convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111))";
        else
        {
            //Reg.datefromstr = "'" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
            Reg.Msg += " AND convert(nvarchar,Pro_Enq.Enq_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'"; 
        }

        if (txtDateTo.Text == "")
            Reg.datetostr = "convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111))";
        else
        {
            //Reg.datetostr = "'" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
            Reg.Msg += " AND convert(nvarchar,Pro_Enq.Enq_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'"; 
        }
        if (ddlMode.SelectedIndex == 0)
            Reg.modestr = "Pro_Enq.Dial_Mode";
        else
        {
            //Reg.modestr = "'" + ddlMode.SelectedValue.ToString() + "'";
            Reg.Msg += " AND Pro_Enq.[Dial_Mode] = '" + Reg.modestr + "'";
        }
        if (ddlStatus.SelectedIndex == 0)
            Reg.statusstr = "(case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end)";
        else
        {
            //Reg.statusstr = "'" + ddlStatus.SelectedItem.Text.ToString() + "'";
            Reg.Msg += "AND (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) = '" + ddlStatus.SelectedItem.Text.ToString() + "'";
        }
        DataSet ds = function9420.FillFridForEnqDetails_Warranty(Reg);
        #endregion
        if (ds.Tables[0].Rows.Count > 0)
            GrdEnquiry.DataSource = ds.Tables[0];
        GrdEnquiry.DataBind();
        lblcount.Text = GrdEnquiry.Rows.Count.ToString();
        if (GrdEnquiry.Rows.Count > 0)
            GrdEnquiry.HeaderRow.TableSection = TableRowSection.TableHeader;

    }
    protected void btnDownloadExcel_Click(object sender, EventArgs e)
    {
        try
        {
            #region Query
            Object9420 Reg = new Object9420();
            if (ddlproname.SelectedIndex > 0)
            {
                Reg.Pro_ID = ddlproname.SelectedValue;
                Reg.Msg = "M_Code.Pro_ID = '" + Reg.Pro_ID + "'";
            }
            else
                Reg.Pro_ID = "";
            if (Reg.Msg != null)
            {
                if (Reg.Msg.Length > 1)
                    Reg.Msg = " WHERE " + Reg.Msg;
            }
            Reg.Comp_ID = Session["CompanyId"].ToString();
            if (Reg.Msg != null)
            {
                if (Reg.Msg.Length > 1)
                    Reg.Msg += " AND T_Pro.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
            }
            else
                Reg.Msg += " WHERE T_Pro.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
            if (txtDateFrom.Text == "")
                Reg.datefromstr = "convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111))";
            else
            {
                //Reg.datefromstr = "'" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
                Reg.Msg += " AND convert(nvarchar,Pro_Enq.Enq_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
            }

            if (txtDateTo.Text == "")
                Reg.datetostr = "convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111))";
            else
            {
                //Reg.datetostr = "'" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
                Reg.Msg += " AND convert(nvarchar,Pro_Enq.Enq_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
            }
            if (ddlMode.SelectedIndex == 0)
                Reg.modestr = "Pro_Enq.Dial_Mode";
            else
            {
                //Reg.modestr = "'" + ddlMode.SelectedValue.ToString() + "'";
                Reg.Msg += " AND Pro_Enq.[Dial_Mode] = '" + Reg.modestr + "'";
            }
            if (ddlStatus.SelectedIndex == 0)
                Reg.statusstr = "(case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end)";
            else
            {
                //Reg.statusstr = "'" + ddlStatus.SelectedItem.Text.ToString() + "'";
                Reg.Msg += "AND (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) = '" + ddlStatus.SelectedItem.Text.ToString() + "'";
            }
            DataSet ds = function9420.FillFridForEnqDetails_Warranty_download(Reg);
            #endregion
            //DataSet ds = Warranty.GetWarrantyDetailVendor_download(Session["CompanyId"].ToString());
            XLWorkbook wb = new XLWorkbook();
            wb.Worksheets.Add(ds.Tables[0], "Warranty Claim Report");
            MemoryStream stream = new MemoryStream();
            wb.SaveAs(stream);
            //Return xlsx Excel File  

            Response.Clear();
            Response.ContentType = "application/force-download";
            Response.AddHeader("content-disposition", "attachment;    filename=Warranty_claim_Report.xlsx");
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
        fillData();
    }

    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        allClear();
        fillData();
    }
    protected void GrdEnquiry_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdEnquiry.PageIndex = e.NewPageIndex;
        fillData();
    }




}
