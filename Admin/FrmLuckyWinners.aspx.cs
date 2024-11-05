using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business9420;
using System.Data;
using CustomeDraw;
using System.IO;

public partial class FrmLuckyWinners : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmLuckyWinners.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        //if (!Page.IsPostBack)
        //{
        //    FillCompany();
        //    allClear();             
        //    fillData();
        //}
    }
    //protected void btnExceldwn_Click(object sender, ImageClickEventArgs e)
    //{
    //    #region Query
    //    Object9420 Reg = new Object9420();
    //    if (ddlproname.SelectedIndex > 0)
    //        Reg.Pro_ID = ddlproname.SelectedValue;
    //    else
    //        Reg.Pro_ID = "";
    //    if (ddlcompname.SelectedIndex > 0)
    //        Reg.Comp_ID = ddlcompname.SelectedValue;
    //    else
    //        Reg.Comp_ID = "";
    //    if (txtDateFrom.Text != "")
    //        Reg.datefromstr = " AND CONVERT(VARCAHR,tg.EntryDate,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
    //    else
    //        Reg.datefromstr = "";
    //    if (txtDateTo.Text != "")
    //        Reg.datetostr = " AND CONVERT(VARCAHR,tg.EntryDate,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
    //    else
    //        Reg.datetostr = "";
    //    if (ddlDelivery.SelectedIndex == 0)
    //        Reg.modestr = "";
    //    else
    //    {
    //        if (ddlDelivery.SelectedIndex == 1)
    //            Reg.modestr = " AND tg.IsDelivery = 1 ";
    //        else if (ddlDelivery.SelectedIndex == 2)
    //            Reg.modestr = " AND tg.IsDelivery = 0 ";
    //    }
    //    if (ddlSendSMS.SelectedIndex == 0)
    //        Reg.statusstr = "";
    //    else
    //    {
    //        if (ddlSendSMS.SelectedIndex == 1)
    //            Reg.statusstr = " AND tg.IsSMS = 1 ";
    //        else if (ddlSendSMS.SelectedIndex == 2)
    //            Reg.statusstr = " AND tg.IsSMS = 0 ";
    //    }
    //    #endregion
    //    DataTable dt = Rewards_DataTire.DownLoadExcel(Reg);
    //    downloadExcel(dt, "Winners");
    //}
    //private void downloadExcel(DataTable dt, string FileName)
    //{
    //    Response.Clear();
    //    Response.Charset = "";
    //    Response.AddHeader("content-disposition", "attachment;filename=" + FileName + ".xls");
    //    Response.ContentType = "application/vnd.ms-excel";

    //    StringWriter writer = new StringWriter();
    //    Html32TextWriter htmlwriter = new Html32TextWriter(writer);
    //    DataGrid grd = new DataGrid();
    //    grd.DataSource = dt;
    //    grd.DataBind();
    //    grd.RenderControl(htmlwriter);
    //    Response.Write(writer.ToString());
    //    grd.AlternatingItemStyle.BackColor = System.Drawing.Color.LightSkyBlue;
    //    Response.End();
    //    htmlwriter.Close();
    //}
    //private void FillCompany()
    //{
    //    DataSet ds = Rewards_DataTire.GetCompany();
    //    DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", ddlcompname, "--Company--");
    //    ddlcompname.SelectedIndex = 0;
    //    ddlproname.Items.Clear();
    //    ddlproname.Items.Insert(0, "--Product--");
    //    ddlproname.SelectedIndex = 0;
    //}
    //protected void ddlRows_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    fillData();
    //}
    //protected void ddlproduct_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    fillData();
    //}
    //protected void ddlcompname_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Object9420 Reg = new Object9420();
    //    if (ddlcompname.SelectedIndex > 0)
    //    {
    //        Reg.Comp_ID = ddlcompname.SelectedValue;
    //        DataSet ds = SQL_DB.ExecuteDataSet("SELECT DISTINCT Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, Pro_Reg.Comp_ID FROM M_Code FULL OUTER JOIN  Pro_Reg ON M_Code.Pro_ID = Pro_Reg.Pro_ID WHERE (M_Code.Print_Status = 1)  AND (Pro_Reg.Comp_ID = '" + ddlcompname.SelectedValue.Trim().ToString() + "')");
    //        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlproname, "--Product--");
    //        ddlproname.SelectedIndex = 0;
    //    }
    //    else
    //    {
    //        ddlproname.Items.Insert(0, "--Product--");
    //        ddlproname.SelectedIndex = 0;
    //    }
    //    fillData();
    //}
    //private void allClear()
    //{
    //    txtDateFrom.Text = "";
    //    txtDateTo.Text = "";
    //    ddlDelivery.SelectedIndex = 0;
    //    ddlSendSMS.SelectedIndex = 0;
    //    // fillData();
    //}
    //private void fillData()
    //{
    //    #region Commented Old
    //    //string frdate = "";
    //    //string todate = "";
    //    //string md = "";
    //    //string sts = "";
    //    //Object9420 Reg = new Object9420();        
    //    //if (ddlcompname.SelectedIndex > 0)
    //    //    Reg.Comp_ID = ddlcompname.SelectedValue;
    //    //else
    //    //    Reg.Comp_ID = "";
    //    //if (ddlproname.SelectedIndex > 0)
    //    //    Reg.Pro_ID = ddlproname.SelectedValue;
    //    //else
    //    //    Reg.Pro_ID = "";
    //    //if (txtDateFrom.Text == "")
    //    //    frdate = "convert(datetime,convert(nvarchar,[Enq_Date],111))";
    //    //else
    //    //    frdate = "'" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
    //    //if (txtDateTo.Text == "")
    //    //    todate = "convert(datetime,convert(nvarchar,[Enq_Date],111))";
    //    //else
    //    //    todate = "'" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";

    //    //if (ddlMode.SelectedIndex == 0)
    //    //    md = "[Dial_Mode]";
    //    //else
    //    //    md = "'" + ddlMode.SelectedValue.ToString() + "'";
    //    //if (ddlStatus.SelectedIndex == 0)
    //    //    sts = "(case when [Is_Success] = '1' then 'Success' else 'Unsuccess' end)";
    //    //else
    //    //    sts = "'" + ddlStatus.SelectedItem.Text.ToString() + "'";
    //    //DataSet ds = SQL_DB.ExecuteDataSet("SELECT M_Code.Pro_ID,(SELECT Pro_Name FROM Pro_Reg Where Pro_ID = M_Code.Pro_ID) as Pro_Name, Pro_Enq.Dial_Mode AS ModeOfInquiry,convert(nvarchar,Pro_Enq.Enq_Date,109) as EnquiryDate , Pro_Enq.Mode_Detail AS ContactDetails, Pro_Enq.Received_Code1, " +
    //    //" Pro_Enq.Received_Code2,(case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) as Successstatus  FROM  M_Code INNER JOIN   Pro_Enq ON CONVERT(VARCHAR,M_Code.Code1) = Pro_Enq.Received_Code1 " + 
    //    //" AND CONVERT(VARCHAR,M_Code.Code2) = Pro_Enq.Received_Code2 " +
    //    //" where ('' = '" + Reg.Pro_ID + "' OR M_Code.Pro_ID = '" + Reg.Pro_ID + "') AND convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111)) >= " + frdate + "" +
    //    //" and convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111)) <= " + todate + "" +
    //    //" and Pro_Enq.Dial_Mode = " + md + " " +
    //    //" and (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) = " + sts + "" +
    //    //" order by Pro_Enq.Enq_Date desc");
    //    #endregion
    //    #region Query
    //    Object9420 Reg = new Object9420();        
    //    if (ddlproname.SelectedIndex > 0)
    //        Reg.Pro_ID = ddlproname.SelectedValue;    
    //    else
    //        Reg.Pro_ID = "";        
    //    if (ddlcompname.SelectedIndex > 0)
    //        Reg.Comp_ID = ddlcompname.SelectedValue;    
    //    else
    //        Reg.Comp_ID = "";
    //    if (txtDateFrom.Text != "")
    //        Reg.datefromstr = " AND CONVERT(VARCAHR,tg.EntryDate,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
    //    else
    //        Reg.datefromstr = "";
    //    if (txtDateTo.Text != "")
    //        Reg.datetostr = " AND CONVERT(VARCAHR,tg.EntryDate,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
    //    else
    //        Reg.datetostr = "";
    //    if (ddlDelivery.SelectedIndex == 0)
    //        Reg.modestr = "";
    //    else
    //    {            
    //        if(ddlDelivery.SelectedIndex == 1)
    //            Reg.modestr = " AND tg.IsDelivery = 1 ";
    //        else if(ddlDelivery.SelectedIndex == 2)
    //            Reg.modestr = " AND tg.IsDelivery = 0 ";
    //    }
    //    if (ddlSendSMS.SelectedIndex == 0)
    //        Reg.statusstr = "";
    //    else
    //    {
    //        if (ddlSendSMS.SelectedIndex == 1)
    //            Reg.statusstr = " AND tg.IsSMS = 1 ";
    //        else if (ddlSendSMS.SelectedIndex == 2)
    //            Reg.statusstr = " AND tg.IsSMS = 0 ";
    //    }        
    //    DataSet ds = Rewards_DataTire.GetLuckWinners(Reg);
    //    #endregion        
    //    if (Convert.ToInt32(ddlRows.SelectedValue) > 1000)
    //    {
    //        if (ds.Tables[0].Rows.Count > 0)
    //            GrdVw.PageSize = ds.Tables[0].Rows.Count;
    //    }
    //    else
    //        GrdVw.PageSize = Convert.ToInt32(ddlRows.SelectedValue.Trim());
    //    lblcount.Text = ds.Tables[0].Rows.Count.ToString();
    //    if (ds.Tables[0].Rows.Count > 0)
    //        GrdVw.DataSource = ds.Tables[0];
    //    GrdVw.DataBind();
    //    lblcount.Text = ds.Tables[0].Rows.Count.ToString();  
    //}
    //protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    //{

    //    fillData();//allClear();

    //}

    //protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    //{
    //    allClear();
    //    fillData();
    //}

    //protected void GrdVw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GrdVw.PageIndex = e.NewPageIndex;
    //    fillData();
    //}


}