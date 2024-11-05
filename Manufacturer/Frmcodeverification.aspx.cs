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

public partial class frmManfEnquiry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
        {
            Response.Redirect("/Login.aspx");
            //Response.Redirect("default.aspx?Page=frmManfEnquiry.aspx");
        }
        
        if (!Page.IsPostBack)
        {
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));

            allClear();
            // fillMode();
            // fillData();
            fillservice();
           // FillLocation();
           
            FillRemarks();
        }
    }

    //private void fillMode()
    //{
    //    DataSet ds = SQL_DB.ExecuteDataSet("SELECT distinct [Dial_Mode] ,[Dial_Mode] as Dial_Mode1 FROM [Pro_Enq] order by [Dial_Mode]");
    //    DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Dial_Mode", "Dial_Mode1", ddlMode, "--Select Mode--");
    //    ddlMode.SelectedIndex = 0;
    //    FillProducts(Session["CompanyId"].ToString());
    //}
    private void fillservice()
    {
        DataSet ds = SQL_DB.ExecuteDataSet("select distinct sb.service_id,serv.servicename from M_ServiceSubscription (nolock) sb left join m_service (nolock) serv on sb.Service_ID=serv.Service_ID where sb.Comp_ID='" + Session["CompanyId"].ToString() + "'");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "service_id", "servicename", ddlservice, "--Service--");
        ddlservice.SelectedIndex = 0;
    }
    private void FillProducts(string CompID)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("select DISTINCT pr.Pro_ID, pr.Pro_Name, pr.Comp_ID from m_servicesubscription (nolock) ms inner join Pro_Reg (nolock) pr on pr.pro_id=ms.pro_id and pr.comp_id=ms.comp_id where ms.service_id='" + ddlservice.SelectedValue+"' and pr.comp_id='" + CompID.ToString() + "' order by pr.Pro_Name");
        DataProvider.MyUtilities.FillLISTInsertZeroIndexString(ds.Tables[0], "Pro_ID", "Pro_Name", liproname, "--All Product--");
     
    }
    private void FillLocation( string service)
    {
        DataSet ds= ExecuteNonQueryAndDatatable.filllocation(Session["CompanyId"].ToString(), service);
        //DataSet ds = SQL_DB.ExecuteDataSet("SELECT distinct [Location] FROM [Tbl_support] order by [Location]");
        DataProvider.MyUtilities.FillLISTsinglecolumnInsertZeroIndexString(ds.Tables[0], "Location", "Location", listate, "--All Location--");
        //listate.SelectedIndex = 0;
    }
    private void FillRemarks()
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT distinct [call_status] FROM [Tbl_support] (nolock) order by [call_status]");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "call_status", "call_status", ddlRemarks, "--Remarks --");
        ddlRemarks.SelectedIndex = 0;
    }
    
    private void allClear()
    {
        txtDateFrom.Text = "";
        txtDateTo.Text = "";
        //ddlMode.SelectedIndex = 0;
        ddlStatus.SelectedIndex = 0;
    }
    private void fillData()
    {
        //#region Query
        //Object9420 Reg = new Object9420();
        //if (ddlproname.SelectedIndex > 0)
        //{
        //    Reg.Pro_ID = ddlproname.SelectedValue;
        //    Reg.Msg = "M_Code.Pro_ID = '" + Reg.Pro_ID + "'";
        //}
        //else
        //    Reg.Pro_ID = "";
        //if (Reg.Msg != null)
        //{
        //    if (Reg.Msg.Length > 1)
        //        Reg.Msg = " WHERE " + Reg.Msg;
        //}
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //if (Reg.Msg != null)
        //{
        //    if (Reg.Msg.Length > 1)
        //        Reg.Msg += " AND T_Pro.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
        //}
        //else
        //    Reg.Msg += " WHERE T_Pro.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
        //if (txtDateFrom.Text == "")
        //    Reg.datefromstr = "convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111))";
        //else
        //{
        //    //Reg.datefromstr = "'" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
        //   //Reg.Msg += " AND convert(nvarchar,Pro_Enq.Enq_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
        //    Reg.Msg += " AND convert(nvarchar,[vw_pro_enq].Enq_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
        //}

        //if (txtDateTo.Text == "")
        //    Reg.datetostr = "convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111))";
        //else
        //{
        //    //Reg.datetostr = "'" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
        //    Reg.Msg += " AND convert(nvarchar,[vw_pro_enq].Enq_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        //}
        //if (ddlMode.SelectedIndex == 0)
        //    Reg.modestr = "[vw_pro_enq].Dial_Mode";
        //else
        //{
        //    //Reg.modestr = "'" + ddlMode.SelectedValue.ToString() + "'";
        //    Reg.Msg += " AND [vw_pro_enq].[Dial_Mode] = '" + ddlMode.SelectedItem.Text.ToString() + "'";
        //}
        //if (ddlStatus.SelectedIndex == 0)
        //    Reg.statusstr = "(case when [vw_pro_enq].Is_Success = '1' then 'Success' else 'Unsuccess' end)";
        //else
        //{
        //    //Reg.statusstr = "'" + ddlStatus.SelectedItem.Text.ToString() + "'";
        //    Reg.Msg += "AND (case when [vw_pro_enq].Is_Success = '1' then 'Success' else 'Unsuccess' end) = '" + ddlStatus.SelectedItem.Text.ToString() + "'";
        //}
        //DataSet ds = function9420.FillFridForEnqDetails(Reg);
        //#endregion

        //if (ds.Tables[0].Rows.Count > 0)
        //    GrdEnquiry.DataSource = ds.Tables[0];
        //GrdEnquiry.DataBind();
        //lblcount.Text = GrdEnquiry.Rows.Count.ToString();
        //if (GrdEnquiry.Rows.Count > 0)
        //    GrdEnquiry.HeaderRow.TableSection = TableRowSection.TableHeader;

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
       // GrdEnquiry.PageIndex = e.NewPageIndex;
        fillData();
    }

    protected void btnDownloadExcel_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        string product = "";
        string state = "";
        foreach (var item in liproname.GetSelectedIndices())
        {
            product = product + "" + liproname.Items[item].Value + ",";
        }
        bool x = product.Contains("--All Product--");
        if (product.Length>0 && !product.Contains("--All Product--"))
        {
            product = product.Remove(product.Length - 1, 1);
        }
        else
        {
            product = "";
        }
        foreach (int item in listate.GetSelectedIndices())
        {
            state = state + "" + listate.Items[item] + ",";

        }
        if (state.Length > 0 && !state.Contains("--All Location--"))
        {
            state = state.Remove(state.Length - 1, 1);
        }
        else
        {
            state = "";
        }
        //if (ddlproname.SelectedIndex > 0)
        //{
        //    Reg.Pro_ID = ddlproname.SelectedValue;

        //}
        //else
        //    Reg.Pro_ID = "";
        if (ddlservice.SelectedIndex > 0)
            Reg.Service_ID = ddlservice.SelectedValue;
        else
            Reg.Service_ID = "";

        if (ddlRemarks.SelectedIndex > 0)
        {
            Reg.Remarks = ddlRemarks.SelectedValue;
        }
        else
            Reg.Remarks = "";
        //if (ddlLocation.SelectedIndex > 0)
        //{
        //    Reg.Location = ddlLocation.SelectedValue;
        //}
        //else
        //    Reg.Location = "";
        if (ddlStatus.SelectedIndex > 0)
        {
            Reg.statusstr = ddlStatus.SelectedValue;
        }
        else
            Reg.statusstr = "";
        
        //if (Reg.Msg != null)
        //{
        //    if (Reg.Msg.Length > 1)
        //        Reg.Msg = " WHERE " + Reg.Msg;
        //}
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //if (Reg.Msg != null)
        //{
        //    if (Reg.Msg.Length > 1)
        //        Reg.Msg += " AND T_Pro.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
        //}
        //else
        //    Reg.Msg += " WHERE T_Pro.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
        //if (txtDateFrom.Text == "")
        //    Reg.datefromstr = "convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111))";
        //else
        //{
        //    //Reg.datefromstr = "'" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
        //    Reg.Msg += " AND convert(nvarchar,Pro_Enq.Enq_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
        //}

        //if (txtDateTo.Text == "")
        //    Reg.datetostr = "convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111))";
        //else
        //{
        //    //Reg.datetostr = "'" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
        //    Reg.Msg += " AND convert(nvarchar,Pro_Enq.Enq_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        //}
        //if (ddlMode.SelectedIndex == 0)
        //    Reg.modestr = "Pro_Enq.Dial_Mode";
        //else
        //{
        //    //Reg.modestr = "'" + ddlMode.SelectedValue.ToString() + "'";
        //    Reg.Msg += " AND Pro_Enq.[Dial_Mode] = '" + Reg.modestr + "'";
        //}
        //if (ddlStatus.SelectedIndex == 0)
        //    Reg.statusstr = "(case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end)";
        //else
        //{
        //    //Reg.statusstr = "'" + ddlStatus.SelectedItem.Text.ToString() + "'";
        //    Reg.Msg += "AND (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) = '" + ddlStatus.SelectedItem.Text.ToString() + "'";
        //}

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
        //    " and convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111)) >= " + Reg.datefromstr + "" +
        //    " and convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111)) <= " + Reg.datetostr + " " +
        //    //"and Pro_Enq.[Dial_Mode] = " + Reg.modestr + " " +
        //    " and (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) = " + Reg.statusstr + "" +
        //    " AND M_Code.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "')) " +
        //    "  order by Pro_Enq.Enq_Date desc";
        //// + Reg.Msg  +  strMsg + " order by Pro_Enq.Enq_Date desc");
        /////////////////////////////
        Page.Validate("servss");
        if(Page.IsValid)
        {
            try
            {
                DataSet dtst = ExecuteNonQueryAndDatatable.Fillcodeverification(Session["CompanyId"].ToString(), product, Convert.ToDateTime(txtDateTo.Text), Convert.ToDateTime(txtDateFrom.Text), Reg.statusstr, Reg.Remarks, Mobile.Text, state, Reg.Service_ID);
                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dtst.Tables[0],"Code_verification");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                //Return xlsx Excel File  

                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=Code_verification.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();
            }
            catch(Exception ex)
            {
                throw ex;
            }
            //////////////////////////
            
    }
    }

    public void DownlaodExcel(DataTable dt)
    {
        //DataTable dt = SQL_DB.ExecuteDataTable(sQry);
        //Build the CSV file data as a Comma separated string.
        string csv = string.Empty;

        foreach (DataColumn column in dt.Columns)
        {
            //Add the Header row for CSV file.
            csv += column.ColumnName + ',';
        }

        //Add new line.
        csv += "\r\n";

        foreach (DataRow row in dt.Rows)
        {
            foreach (DataColumn column in dt.Columns)
            {
                //Add the Data rows.
               
                    csv +=row[column.ColumnName].ToString().Replace(",", ";") + ',';
               
          
            }

            //Add new line.
            csv += "\r\n";
        }

        //Download the CSV file.
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=Code_verification.csv");
        Response.Charset = "";
        //Response.ContentType = "application/text";
        Response.ContentType = "text/csv";
        Response.Output.Write(csv);
        Response.Flush();
        Response.End();
    }

    protected void ddlservice_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillLocation(ddlservice.SelectedValue);
        FillProducts(Session["CompanyId"].ToString());


    }
}
