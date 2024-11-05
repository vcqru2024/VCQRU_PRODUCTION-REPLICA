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

public partial class FrmRunSurveys : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../Info/Login.aspx?Page=FrmRunSurveys.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!Page.IsPostBack)
        {
            //if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
            //    Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            FillProduct();
            allClear();
            fillData();
        }
    }    
    protected void ddlRows_SelectedIndexChanged(object sender, EventArgs e)
    {
        fillData();
    }
    protected void ddlproduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        fillData();
    }
    protected void btnExceldwn_Click(object sender, ImageClickEventArgs e)
    {
        //#region Logic for Fill Data
        //Object9420 Reg = new Object9420();
        //if (ddlproname.SelectedIndex > 0)
        //    Reg.Pro_ID = ddlproname.SelectedValue;
        //else
        //    Reg.Pro_ID = "";
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //if (txtDateFrom.Text != "")
        //    Reg.datefromstr = " CONVERT(VARCAHR,tg.EntryDate,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
        //else
        //    Reg.datefromstr = "";
        //if (txtDateTo.Text != "")
        //    Reg.datetostr = " CONVERT(VARCAHR,tg.EntryDate,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        //else
        //    Reg.datetostr = "";
        //string NewQry = "";
        //if (Reg.Comp_ID == "")
        //{
        //    NewQry = "";
        //    if (Reg.datefromstr == "")
        //    {
        //        if (Reg.datetostr == "")
        //            NewQry = "";
        //        else
        //            NewQry = " WHERE " + Reg.datetostr;
        //    }
        //    else
        //    {
        //        NewQry = " WHERE " + Reg.datefromstr;
        //        if (Reg.datetostr != "")
        //            NewQry += " AND " + Reg.datetostr;
        //    }
        //}
        //else
        //{
        //    if (Reg.Pro_ID == "")
        //        NewQry = " WHERE tg.Pro_ID IN (SELECT s.Pro_ID FROM M_ServiceSubscription as s WHERE (''='" + Reg.Comp_ID + "' OR s.comp_ID='" + Reg.Comp_ID + "') AND (s.Service_ID IN (SELECT m.Service_ID FROM M_ServiceFeature as m WHERE (m.IsNotify = 0))))";
        //    else
        //        NewQry = " WHERE tg.Pro_ID IN ('" + Reg.Pro_ID + "')";
        //    if (Reg.datefromstr == "")
        //    {
        //        if (Reg.datetostr != "")
        //            NewQry += " AND " + Reg.datetostr;
        //    }
        //    else
        //    {
        //        NewQry += " AND " + Reg.datefromstr;
        //        if (Reg.datetostr != "")
        //            NewQry += " AND " + Reg.datetostr;
        //    }
        //}
        //string Qry = "SELECT tg.RowId, (SELECT pr.Pro_Name FROM Pro_Reg AS pr WHERE pr.Pro_ID = tg.Pro_ID) as Pro_Name, (SELECT mt.SurveystypeText FROM M_RunSurveys AS mt WHERE mt.RowId = tg.Rating) as SurveystypeText, tg.MobileNo, tg.EntryDate FROM T_RunSurveys as tg " + NewQry;
        //#endregion
        DataTable dt = FillDataaTable();
        DataView dv = new DataView(dt);
        DataTable dt2 = dv.ToTable("Selected", false, "ProductName", "MobileNo", "Email", "Question", "Rate");
        //DataTable dt = SQL_DB.ExecuteDataSet(Qry).Tables[0];
        PDFCLass.downloadExcel(dt2, "Run Surveys Details");
    }
    private void downloadExcel(DataTable dt, string FileName)
    {
        Response.Clear();
        Response.Charset = "";
        Response.AddHeader("content-disposition", "attachment;filename=" + FileName + ".xls");
        Response.ContentType = "application/vnd.ms-excel";

        StringWriter writer = new StringWriter();
        Html32TextWriter htmlwriter = new Html32TextWriter(writer);
        DataGrid grd = new DataGrid();
        grd.DataSource = dt;
        grd.DataBind();
        grd.RenderControl(htmlwriter);
        Response.Write(writer.ToString());
        grd.AlternatingItemStyle.BackColor = System.Drawing.Color.LightSkyBlue;
        Response.End();
        htmlwriter.Close();
    }
    protected void FillProduct()
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT p.Comp_ID, p.Pro_ID ,p.Pro_Name FROM Pro_Reg AS p WHERE (p.Doc_Flag = 1) AND (p.Sound_Flag = 1) AND (p.Pro_ID IN (SELECT s.Pro_ID FROM M_ServiceSubscription as s " +
        " WHERE (''='" + Reg.Comp_ID + "' OR s.comp_ID='" + Reg.Comp_ID + "') AND  (s.Service_ID IN (SELECT m.Service_ID FROM M_ServiceFeature as m WHERE (m.IsNotify = 0)))))");
        DataProvider.MyUtilities.FillDDLInsertBlankIndex(ds, "Pro_ID", "Pro_Name", ddlproname, "--Product--");
        ddlproname.SelectedIndex = 0;
       // fillData();
    }
    private void allClear()
    {
        ddlproname.SelectedIndex = 0;
        txtDateFrom.Text = string.Empty;
        txtDateTo.Text = string.Empty;
        // fillData();
    }
    public DataTable FillDataaTable()
    {
        DateTime? dtDuedate = null;
        DateTime? dtDueTo = null;
        if (!string.IsNullOrEmpty(txtDateFrom.Text))
        {
            dtDuedate = DateTime.Parse(txtDateFrom.Text);
        }
        if (!string.IsNullOrEmpty(txtDateTo.Text))
        {
            dtDueTo = DateTime.Parse(txtDateTo.Text);
        }
        DataSet ds = ExecuteNonQueryAndDatatable.GetConsumerList("", ddlproname.SelectedValue, ProjectSession.strCompanyid, dtDuedate, dtDueTo, "", "runsurvey");
        DataTable dt = ds.Tables[0];
        return dt;
    }
    private void fillData()
    {
        DataTable dt = FillDataaTable();

         // DataSet ds = ExecuteNonQueryAndDatatable.GetLuckyWinners(ddlproname.SelectedValue, dtDuedate, isLuckyDraw);
        // DataSet ds = ExecuteNonQueryAndDatatable.GetConsumerList("", ddlproname.SelectedValue, ProjectSession.strCompanyid, dtDuedate, "", "runsurvey");
        //DataTable dt = ds.Tables[0];
        
        if (Convert.ToInt32(ddlRows.SelectedValue) > 1000)
        {
            if (dt.Rows.Count > 0)
                GrdVw.PageSize = dt.Rows.Count;
        }
        else
            GrdVw.PageSize = Convert.ToInt32(ddlRows.SelectedValue.Trim());

        lblcount.Text = dt.Rows.Count.ToString();

       // if (dt.Rows.Count > 0)
        {
            GrdVw.DataSource = dt;
            GrdVw.DataBind();
        }

        lblcount.Text = dt.Rows.Count.ToString();
        if (GrdVw.Rows.Count > 0)
            GrdVw.HeaderRow.TableSection = TableRowSection.TableHeader;

        //#region Query
        // #region Logic for Fill Data
        //Object9420 Reg = new Object9420();
        //if (ddlproname.SelectedIndex > 0)
        //    Reg.Pro_ID = ddlproname.SelectedValue;
        //else
        //    Reg.Pro_ID = "";
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //if (txtDateFrom.Text != "")
        //    Reg.datefromstr = " CONVERT(VARCAHR,tg.EntryDate,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
        //else
        //    Reg.datefromstr = "";
        //if (txtDateTo.Text != "")
        //    Reg.datetostr = " CONVERT(VARCAHR,tg.EntryDate,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        //else
        //    Reg.datetostr = "";
        //string NewQry = "";
        //if (Reg.Comp_ID == "")
        //{
        //    NewQry = "";
        //    if (Reg.datefromstr == "")
        //    {
        //        if (Reg.datetostr == "")
        //            NewQry = "";
        //        else
        //            NewQry = " WHERE " + Reg.datetostr;
        //    }
        //    else
        //    {
        //        NewQry = " WHERE " + Reg.datefromstr;
        //        if (Reg.datetostr != "")
        //            NewQry += " AND " + Reg.datetostr;
        //    }
        //}
        //else
        //{
        //    if (Reg.Pro_ID == "")
        //        NewQry = " WHERE tg.Pro_ID IN (SELECT s.Pro_ID FROM M_ServiceSubscription as s WHERE (''='" + Reg.Comp_ID + "' OR s.comp_ID='" + Reg.Comp_ID + "') AND (s.Service_ID IN (SELECT m.Service_ID FROM M_ServiceFeature as m WHERE (m.IsNotify = 0))))";
        //    else
        //        NewQry = " WHERE tg.Pro_ID IN ('" + Reg.Pro_ID + "')";
        //    if (Reg.datefromstr == "")
        //    {
        //        if (Reg.datetostr != "")
        //            NewQry += " AND " + Reg.datetostr;
        //    }
        //    else
        //    {
        //        NewQry += " AND " + Reg.datefromstr;
        //        if (Reg.datetostr != "")
        //            NewQry += " AND " + Reg.datetostr;
        //    }
        //}
        //string Qry = "SELECT tg.RowId, tg.Pro_ID,(SELECT pr.Pro_Name FROM Pro_Reg AS pr WHERE pr.Pro_ID = tg.Pro_ID) as Pro_Name, tg.Rating,(SELECT mt.SurveystypeText FROM M_RunSurveys AS mt WHERE mt.RowId = tg.Rating) as SurveystypeText, tg.MobileNo, tg.EntryDate FROM T_RunSurveys as tg " + NewQry;
        //#endregion
        //DataSet ds = SQL_DB.ExecuteDataSet(Qry);
        //#endregion
        //if (Convert.ToInt32(ddlRows.SelectedValue) > 1000)
        //{
        //    if (ds.Tables[0].Rows.Count > 0)
        //        GrdVw.PageSize = ds.Tables[0].Rows.Count;
        //}
        //else
        //    GrdVw.PageSize = Convert.ToInt32(ddlRows.SelectedValue.Trim());
        //lblcount.Text = ds.Tables[0].Rows.Count.ToString();
        //if (ds.Tables[0].Rows.Count > 0)
        //    GrdVw.DataSource = ds.Tables[0];
        //GrdVw.DataBind();
        //lblcount.Text = ds.Tables[0].Rows.Count.ToString();

    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {

        fillData();//allClear();

    }

    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        allClear();
        fillData();
    }

    protected void GrdVw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdVw.PageIndex = e.NewPageIndex;
        fillData();
    }



    protected void GrdVw_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
}