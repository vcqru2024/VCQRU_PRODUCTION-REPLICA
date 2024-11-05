using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business9420;
using System.Data;
using Data9420;
using System.Runtime.InteropServices;
using ClosedXML.Excel;
using System.IO;
using ZXing.OneD;

public partial class frmManfEnquiry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (Session["CompanyId"] == null)
        {
            Response.Redirect("/Login.aspx");
            //Response.Redirect("default.aspx?Page=frmManfEnquiry.aspx");
        }
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");

            if (Convert.ToString(Session["CompanyId"]) == "Comp-1248")
                Response.Redirect("AmrutanjanParticipantDetails.aspx");

            if (Convert.ToString(Session["CompanyId"]) == "Comp-1152")
            {
                GrdEnquiry.Columns[7].Visible = true;
                GrdEnquiry.Columns[8].Visible = true;
            }
            else
            {
                GrdEnquiry.Columns[7].Visible = false;
                GrdEnquiry.Columns[8].Visible = false;
            }
        }
        if (!Page.IsPostBack)
        {
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            fillservice();
            allClear();
            fillMode();
            fillData();
        }
        if (Convert.ToString(Session["CompanyId"]) == "Comp-1326")
        {
            btnCodeStatus.Visible = false;
        }
    }
    private void fillservice()
    {
        DataSet ds = SQL_DB.ExecuteDataSet("select distinct sb.service_id,serv.servicename from M_ServiceSubscription sb left join m_service serv on sb.Service_ID=serv.Service_ID where sb.Comp_ID='"+ Session["CompanyId"].ToString()+ "'");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "service_id", "servicename", ddlservice, "--Service--");
        ddlservice.SelectedIndex = 0;
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
                Reg.Msg += " AND [m_code].Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
        }
        else
            Reg.Msg += " WHERE [m_code].Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
        if (txtDateFrom.Text == "")
            Reg.datefromstr = "convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111))";
        else
        {
            //Reg.datefromstr = "'" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
           //Reg.Msg += " AND convert(nvarchar,Pro_Enq.Enq_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
            Reg.Msg += " AND convert(nvarchar,[vw_pro_enq].Enq_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
        }

        if (txtDateTo.Text == "")
            Reg.datetostr = "convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111))";
        else
        {
            //Reg.datetostr = "'" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
            Reg.Msg += " AND convert(nvarchar,[vw_pro_enq].Enq_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        }
        if (ddlMode.SelectedIndex == 0)
            Reg.modestr = "[vw_pro_enq].Dial_Mode";
        else
        {
            //Reg.modestr = "'" + ddlMode.SelectedValue.ToString() + "'";
            Reg.Msg += " AND [vw_pro_enq].[Dial_Mode] = '" + ddlMode.SelectedItem.Text.ToString() + "'";
        }
        if (ddlStatus.SelectedIndex == 0)
            Reg.statusstr = "(case when [vw_pro_enq].Is_Success = '1' then 'Success' else 'Unsuccess' end)";
        else
        {
            //Reg.statusstr = "'" + ddlStatus.SelectedItem.Text.ToString() + "'";
            Reg.Msg += "AND (case when [vw_pro_enq].Is_Success = '1' then 'Success' else 'Unsuccess' end) = '" + ddlStatus.SelectedItem.Text.ToString() + "'";
        }
        DataSet ds = function9420.FillFridForEnqDetails(Reg);
        #endregion

        if (ds.Tables[0].Rows.Count > 0)
        {

            if (Convert.ToString(Session["CompanyId"]) == "Comp-1595")
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                dt.Columns.Remove("MobileNo");
                dt.Columns.Add("MobileNo", typeof(string));
                dt.AcceptChanges();

                string[] selectedColumns = new[] { "EnquiryDate", "Pro_Name", "ModeOfInquiry", "MobileNo", "Received_Code1", "Received_Code2", "Successstatus", "employeeid", "distributorid" };

                DataTable Selecteddt = new DataView(dt).ToTable(false, selectedColumns);

                GrdEnquiry.DataSource = Selecteddt;
            }
            else
                GrdEnquiry.DataSource = ds.Tables[0];
        }
           
        GrdEnquiry.DataBind();
        lblcount.Text = GrdEnquiry.Rows.Count.ToString();
        //if (GrdEnquiry.Rows.Count > 0)
        //    GrdEnquiry.HeaderRow.TableSection = TableRowSection.TableHeader;

    }

    protected void btnCodeStatus_Click(object sender, EventArgs e)
    {
        Response.Redirect("VendorCodeStatus.aspx");
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

    protected void btnDownloadExcel_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        if(txtDateFrom.Text!="")
        Reg.datefromstr =Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd");
        if (txtDateTo.Text != "")
            Reg.datetostr = Convert.ToDateTime(txtDateTo.Text).ToString("yyyy-MM-dd");
        if(ddlservice.SelectedIndex>0)
        {
            Reg.Service_ID = ddlservice.SelectedValue;
            
        }
        else
        {
            Reg.Service_ID = "";
        }
        if (ddlproname.SelectedIndex > 0)
        {
            Reg.Pro_ID = ddlproname.SelectedValue;
            //Reg.Msg = "M_Code.Pro_ID = '" + Reg.Pro_ID + "'";
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
                Reg.Msg += " AND [m_code].Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
        }
        else
            Reg.Msg += " WHERE [m_code].Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
        if (txtDateFrom.Text == "")
        {
            Reg.datefromstr = "";

        }
        
        if (txtDateTo.Text == "")
        {
            Reg.datetostr = "";

        }

        if (txtDateTo.Text == "")
            Reg.datetostr = "Pro_Enq.Enq_Date,";
        else
        {
            //Reg.datetostr = "'" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
            Reg.Msg += " AND convert(nvarchar,Pro_Enq.Enq_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        }
        if (ddlMode.SelectedIndex > 0)
            //Reg.modestr = "Pro_Enq.Dial_Mode";
            Reg.modestr = ddlMode.Text;
        else
        {
            //Reg.modestr = "'" + ddlMode.SelectedValue.ToString() + "'";
            //Reg.Msg += " AND Pro_Enq.[Dial_Mode] = '" + Reg.modestr + "'";
            Reg.modestr = "";
        }
        if (ddlStatus.SelectedIndex> 0)
            // Reg.statusstr = "(case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end)";
            Reg.statusstr = ddlStatus.Text;
        else
        {
            Reg.statusstr = "";
            //Reg.statusstr = "'" + ddlStatus.SelectedItem.Text.ToString() + "'";
            //Reg.Msg += "AND (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) = '" + ddlStatus.SelectedItem.Text.ToString() + "'";
        }

        //string strMsg = "and T_Pro.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "')) ";
        //string sQury = "SELECT Pro_Enq.Enq_Date as EnquiryDate, (SELECT Pro_Name FROM Pro_Reg Where Pro_ID = M_Code.Pro_ID) as Pro_Name, Pro_Enq.Dial_Mode AS ModeOfInquiry," +//M_Code.Pro_ID,
        //    " ISNULL(Pro_Enq.MobileNo,'-- --') as MobileNo, Pro_Enq.Received_Code1 As Code1, " +
        //    //cast(convert(nvarchar,Pro_Enq.Enq_Date,109) as datetime) as EnquiryDate 
        //    " Pro_Enq.Received_Code2 As Code2, (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) as Successstatus";
        //if (Convert.ToString(Session["CompanyId"]) == "Comp-1152")
        //    sQury = sQury + " ,isnull(mc.employeeid,'-- --') as employeeid , isnull(mc.distributorid,'-- --') as distributorid";
        //sQury = sQury + " FROM  M_Code (nolock) INNER JOIN   Pro_Enq " +
        //    " ON cast(M_Code.Code1 as nvarchar) = Pro_Enq.Received_Code1 AND cast(M_Code.Code2 as nvarchar) = Pro_Enq.Received_Code2 " +
        //    " left join T_Pro on M_code.Batch_No = T_Pro.Row_ID" +
        //    " left join m_consumer mc on mc.mobileno = Pro_Enq.MobileNo" +
        //    " where ('' = '" + Reg.Pro_ID + "' OR M_Code.Pro_ID = '" + Reg.Pro_ID + "') " +
        //    " and Pro_Enq.Enq_Date>= '" + Reg.datefromstr + "'" +
        //    " and Pro_Enq.Enq_Date <= '" + Reg.datetostr + "' " +
        //    //"and Pro_Enq.[Dial_Mode] = " + Reg.modestr + " " +
        //    " and (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) = " + Reg.statusstr + "" +
        //    " AND M_Code.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "')) " +
        //    "  order by Pro_Enq.Enq_Date desc";
        // + Reg.Msg  +  strMsg + " order by Pro_Enq.Enq_Date desc");
        Page.Validate("servss");
        if (Page.IsValid)
        {
            try
            {
                DataSet ds = Data_9420.Enquirdetailsdownload(Reg.Pro_ID, Reg.modestr, Reg.statusstr, Convert.ToDateTime(Reg.datefromstr), Convert.ToDateTime(Reg.datetostr), Reg.Comp_ID,Reg.Service_ID);
                XLWorkbook wb = new XLWorkbook();
                #region //** For Lexis and Nexis
                if (Convert.ToString(Session["CompanyId"]) == "Comp-1321")
                {
                    DataTable dt = new DataTable();
                    dt = ds.Tables[0];
                    dt.Columns.Remove("MobileNo");
                    dt.Columns.Add("MobileNo", typeof(string));
                    dt.AcceptChanges();

                    wb.Worksheets.Add(dt, "Enquiry_details");
                }
                else

                    #endregion
                    wb.Worksheets.Add(ds.Tables[0], "Enquiry_details");
                MemoryStream stream = new MemoryStream();
                                   wb.SaveAs(stream);
                    //Return xlsx Excel File  

                    Response.Clear();
                    Response.ContentType = "application/force-download";
                    Response.AddHeader("content-disposition", "attachment;    filename=enquiry_details.xlsx");
                    Response.BinaryWrite(stream.ToArray());
                    Response.End();
                    // return  File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet","Enquiry Details");
              
                //DownlaodExcel(ds.Tables[0]);
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }
    }

   
}
