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


public partial class UserControl_UC_LuckyWinners : System.Web.UI.UserControl
{
    bool isLuckyDraw = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ////******************* Open For Retailler Service *****************//
            ////Session["Comp_type"]
            //if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
            //    Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
           
            allClear();
            FillCompany();
            FillProduct();
            //fillProduct();
            // fillData();
        }
    }
    private void FillCompany()
    {
        //DataSet ds = ExecuteNonQueryAndDatatable.GetTableData("Comp_Reg", "Status", "1", "", 1);
        //DataProvider.MyUtilities.FillDDLInsertBlankIndex(ds, "Comp_ID", "Comp_Name", ddlCompany, "--Company--");
        //ddlCompany.SelectedIndex = 0;
        ExecuteNonQueryAndDatatable.FillCompany(ddlCompany);
        if (ProjectSession.strCompanyid != "")
        {
            ddlCompany.SelectedValue = ProjectSession.strCompanyid;
            ddlCompany.Enabled = false;
        }
        ddlproname.Items.Clear();
        ddlproname.Items.Insert(0, "--Product--");
        ddlproname.SelectedIndex = 0;
    }
    protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCompany.SelectedIndex > 0)
            FillProduct();
        else
        {
            ddlproname.Items.Clear();
            ddlproname.Items.Insert(0, "--Product Name--");
            ddlproname.SelectedIndex = 0;
        }
    }
    protected void ddlRows_SelectedIndexChanged(object sender, EventArgs e)
    {
        fillData();
    }
    protected void ddlproduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        // fillData();
    }
    protected void btnExceldwn_Click(object sender, ImageClickEventArgs e)
    {
        #region Query
        Object9420 Reg = new Object9420();
        if (ddlproname.SelectedIndex > 0)
            Reg.Pro_ID = ddlproname.SelectedValue;
        else
            Reg.Pro_ID = "";
        Reg.Comp_ID = ddlCompany.SelectedValue;
        if (txtDateFrom.Text != "")
            Reg.datefromstr = " AND CONVERT(VARCAHR,tg.EntryDate,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
        else
            Reg.datefromstr = "";
        if (txtDateTo.Text != "")
            Reg.datetostr = " AND CONVERT(VARCAHR,tg.EntryDate,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        else
            Reg.datetostr = "";
        //if (ddlDelivery.SelectedIndex == 0)
        //    Reg.modestr = "";
        //else
        //{
        //    if (ddlDelivery.SelectedIndex == 1)
        //        Reg.modestr = " AND tg.IsDelivery = 1 ";
        //    else if (ddlDelivery.SelectedIndex == 2)
        //        Reg.modestr = " AND tg.IsDelivery = 0 ";
        //}
        //if (ddlSendSMS.SelectedIndex == 0)
        //    Reg.statusstr = "";
        //else
        //{
        //    if (ddlSendSMS.SelectedIndex == 1)
        //        Reg.statusstr = " AND tg.IsSMS = 1 ";
        //    else if (ddlSendSMS.SelectedIndex == 2)
        //        Reg.statusstr = " AND tg.IsSMS = 0 ";
        //}
        #endregion
        DataTable dt = Rewards_DataTire.DownLoadExcel(Reg);
        downloadExcel(dt, "Winners");
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
    private void FillProduct()
    {
        ExecuteNonQueryAndDatatable.FillProduct(ddlCompany.SelectedValue, ddlproname, "'SRV1003','SRV1006'");
        //Object9420 Reg = new Object9420();
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //DataSet ds = SQL_DB.ExecuteDataSet("SELECT DISTINCT Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, Pro_Reg.Comp_ID FROM M_Code FULL OUTER JOIN  Pro_Reg ON M_Code.Pro_ID = Pro_Reg.Pro_ID WHERE (M_Code.Print_Status = 1)  AND (Pro_Reg.Comp_ID = '" + Reg.Comp_ID + "')");
        //DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlproname, "--Product--");
        //ddlproname.SelectedIndex = 0;
    }
    private void allClear()
    {
        ddlCompany.SelectedIndex = 0;
        ddlproname.SelectedIndex = 0;
        txtDateFrom.Text = "";
        txtDateTo.Text = "";
       // ddlDelivery.SelectedIndex = 0;
     //   ddlSendSMS.SelectedIndex = 0;
        // fillData();
    }
    private void fillData()
    {
        #region Query
        Object9420 Reg = new Object9420();
        //if (ddlproname.SelectedIndex > 0)
        //    Reg.Pro_ID = ddlproname.SelectedValue;
        //else
        //    Reg.Pro_ID = "";
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //if (txtDateFrom.Text != "")
        //    Reg.datefromstr = " AND CONVERT(VARCAHR,tg.EntryDate,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
        //else
        //    Reg.datefromstr = "";
        //if (txtDateTo.Text != "")
        //    Reg.datetostr = " AND CONVERT(VARCAHR,tg.EntryDate,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        //else
        //    Reg.datetostr = "";
        //if (ddlDelivery.SelectedIndex == 0)
        //    Reg.modestr = "";
        //else
        //{
        //    if (ddlDelivery.SelectedIndex == 1)
        //        Reg.modestr = " AND tg.IsDelivery = 1 ";
        //    else if (ddlDelivery.SelectedIndex == 2)
        //        Reg.modestr = " AND tg.IsDelivery = 0 ";
        //}
        //if (ddlSendSMS.SelectedIndex == 0)
        //    Reg.statusstr = "";
        //else
        //{
        //    if (ddlSendSMS.SelectedIndex == 1)
        //        Reg.statusstr = " AND tg.IsSMS = 1 ";
        //    else if (ddlSendSMS.SelectedIndex == 2)
        //        Reg.statusstr = " AND tg.IsSMS = 0 ";
        //}

        //DataSet ds =  Rewards_DataTire.GetLuckWinners(Reg);
        //ds = ServiceLogic.GetLuckyWinners(ddlproname.SelectedValue, Convert.ToDateTime(txtDateFrom.Text));
        #endregion       
        DateTime? dtfrom = null;
        if (!string.IsNullOrEmpty(txtDateFrom.Text))
        {
            dtfrom = DateTime.Parse(txtDateFrom.Text);
        }
        DateTime? dtTo = null;
        if (!string.IsNullOrEmpty(txtDateTo.Text))
        {
            dtTo = DateTime.Parse(txtDateTo.Text);
        }

        DataSet ds = ExecuteNonQueryAndDatatable.GetLuckyWinners(ddlproname.SelectedValue, dtfrom, dtTo, isLuckyDraw, ddlService.SelectedValue,ddlCompany.SelectedValue);
        if (Convert.ToInt32(ddlRows.SelectedValue) > 1000)
        {
            if (ds.Tables[0].Rows.Count > 0)
                GrdVw.PageSize = ds.Tables[0].Rows.Count;
        }
        else
            GrdVw.PageSize = Convert.ToInt32(ddlRows.SelectedValue.Trim());

        lblcount.Text = ds.Tables[0].Rows.Count.ToString();

        //if (ds.Tables[0].Rows.Count > 0)
        {
            GrdVw.DataSource = ds.Tables[0];
            GrdVw.DataBind();
        }


        lblcount.Text = ds.Tables[0].Rows.Count.ToString();
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



    protected void btnGoForLuckyDraw_Click(object sender, EventArgs e)
    {
        isLuckyDraw = true;
        //DataTable dt = ExecuteNonQueryAndDatatable.CheckGiftCouponServiceStarted(sst_id, service_id).Tables[0];
        // if (dt.Rows.Count > 0)
        //  {
        // LblMsgBody.Text = "This Gift Coupon service already started, you cannot update details. You can de-Activate it, in case if you want to stop/discontinue  the service .";
        //DivMsg.Visible = true;
        //DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
        //string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
        //     Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", "alert('No record exists for lucky draw');", true);
        //btnSave.Enabled = false;
        //   }
        //  else
        //  {
        fillData();
        //   }
        isLuckyDraw = false;
    }
}