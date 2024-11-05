using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Business9420;
public partial class Patanjali_Frm_Scrap : System.Web.UI.Page
{
    cls_patanjali db = new cls_patanjali();
    public int ScrapeFlag = 0;
    public int index = 0;
    public Int32 sr = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
        Response.Redirect("../Loginpfl.aspx?Page=Frm_Scrap.aspx");
        else
        {
            if (Session["CompanyId"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            #region User Log 
            if (Session["UserName"] != null)
            {
                db.ExceptionLogs("Visited on Scrap", Session["UserName"].ToString(), "R");
            }
            else
            {
                db.ExceptionLogs("CompanyProfile Updated by", Session["Comp_Name"].ToString(), "R");
            }
            #endregion
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            Clear();
            //fillgrid();
        }
    }

    private bool DeleteScrap(string s)
    {
        int i = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT count([Serial_Code]) FROM [Scrap_Label] WHERE [Serial_Code]='" + s + "'"));
        if (i == 1)
            return true;
        else
            return false;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        hidden1.Value = Convert.ToString(Request.Form["chkselect"]);
        for (int K = 0; K < Convert.ToInt32(lblC.Text); K++)
        {
            DataSet ds = new DataSet();
            string[] Arr = hidden1.Value.ToString().Split(',');
            string updateqry = null;
            Label L = (Label)Grdscrap.Rows[K].FindControl("Label1SeNew");
            string[] str = L.Text.ToString().Split('-');
            string pro = str[0].ToString();
            Int32 series_order = Convert.ToInt32(str[1]);
            Int32 series_serial = Convert.ToInt32(str[2]); string batch = null;
            if (series_order.ToString().Length == 1)
                batch = "0" + series_order;
            string Qry = "SELECT ISNULL(Batch_No, NULL) AS BT FROM Scrap_Label WHERE     (Serial_Code = '" + pro + '-' + batch + '-' + series_serial + "')";
            SQL_DB.GetDA(Qry).Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
                batch = ds.Tables[0].Rows[0]["BT"].ToString();
            else
                batch = "0";
            if (Arr.Length > 0)
            {
                for (int p = 0; p < Arr.Length; p++)
                {
                    if (Arr[p].ToString() != L.Text.ToString())
                    {
                        if (batch != "0")
                            updateqry = "UPDATE [M_Code_PFL] SET  [Batch_No] = " + batch + "  ,[ScrapeFlag] = 0 WHERE Pro_ID='" + ddlProduct.SelectedValue + "'  and Print_Status=1 and Series_Order=" + series_order + "  and Series_Serial=" + series_serial + " AND [Batch_No] IS NULL AND [ScrapeFlag] = 1 ";
                        else
                            updateqry = "UPDATE [M_Code_PFL] SET  [ScrapeFlag] = 0 WHERE Pro_ID='" + ddlProduct.SelectedValue + "'  and Print_Status=1 and Series_Order=" + series_order + "  and Series_Serial=" + series_serial + " AND [Batch_No] IS NULL ";
                        SQL_DB.ExecuteNonQuery(updateqry);
                        if (DeleteScrap(L.Text.ToString()))
                            SQL_DB.ExecuteNonQuery("DELETE FROM [Scrap_Label] WHERE [Serial_Code]='" + L.Text.ToString() + "'");
                    }
                }
            }
            else
            {
                if (batch != "0")
                    updateqry = "UPDATE [M_Code_PFL] SET  [Batch_No] = " + batch + " ,[ScrapeFlag] = 0 WHERE Pro_ID='" + ddlProduct.SelectedValue + "'  and Print_Status=1 and Series_Order=" + series_order + "  and Series_Serial=" + series_serial + " AND [Batch_No] IS NULL AND [ScrapeFlag] = 1 ";
                else
                    updateqry = "UPDATE [M_Code_PFL] SET  [ScrapeFlag] = 0 WHERE Pro_ID='" + ddlProduct.SelectedValue + "'  and Print_Status=1 and Series_Order=" + series_order + "  and Series_Serial=" + series_serial + " AND [Batch_No] IS NULL ";
                SQL_DB.ExecuteNonQuery(updateqry);
                if (DeleteScrap(L.Text.ToString()))
                    SQL_DB.ExecuteNonQuery("DELETE FROM [Scrap_Label] WHERE [Serial_Code]='" + L.Text.ToString() + "'");
            }
        }
        if (Request.Form["chkselect"] != null)
        {
            string[] Arr = hidden1.Value.ToString().Split(',');
            for (int i = 0; i < Arr.Length; i++)
            {
                string updateqry = null;
                string[] str = Arr[i].Split('-');
                string pro = str[0].ToString();
                Int32 series_order = Convert.ToInt32(str[1]);
                Int32 series_serial = Convert.ToInt32(str[2]);
                string Qry = "SELECT isnull([Batch_No],0) FROM [M_Code_PFL] WHERE Pro_Id='" + pro + "' and [Series_Order]=" + series_order + " and [Series_Serial]=" + series_serial;// and ScrapeFlag=0
                string batch = SQL_DB.ExecuteScalar(Qry).ToString();
                updateqry = "UPDATE [M_Code_PFL] SET [Batch_No] = null ,[ScrapeFlag] = 1 WHERE Pro_ID='" + ddlProduct.SelectedValue + "'  and Print_Status=1 and Series_Order=" + series_order + "  and Series_Serial=" + series_serial + "";
                SQL_DB.ExecuteNonQuery(updateqry);
                string qry = "INSERT INTO [Scrap_Label]([Comp_ID],[Pro_ID] ,[Batch_No] ,[Serial_Code] )VALUES('" + Session["CompanyId"].ToString() + "','" + ddlProduct.SelectedValue + "','" + batch + "','" + Arr[i].ToString() + "')";
                if (batch.ToString() != "0")
                    SQL_DB.ExecuteNonQuery(qry);
                fillgrid();
                LblMsg.Text = Convert.ToString(Request.Form["chkselect"]).Split(',').Length + " Rows Updated";
            }
            #region User Log 
            if (Session["UserName"] != null)
            {
                db.ExceptionLogs("Scraped by", Session["UserName"].ToString(), "U");
            }
            else
            {
                db.ExceptionLogs("Scraped by", Session["Comp_Name"].ToString(), "U");
            }
            #endregion
        }
        else
            LblMsg.Text = "no row selected";
        fillgrid();
    }

    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
       
    }

    private void fillProduct()
    {
        DataSet ds = new DataSet();
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.Status = 0;
        ds = function9420.FillProddlSearch(Reg);
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProduct, "--Select--");
        ddlProduct.SelectedIndex = 0;
    }
    private void fillgrid()
    {
        Int64 RowsCount = 25;
      //  RowsCount = Convert.ToInt64(ddlRowProductCnt.SelectedValue) * 2;
        #region Query
        string s = null;
        if (ddlProduct.SelectedIndex == 0)
            s = null;
        else s = ddlProduct.SelectedValue.ToString();
        DataSet ds = new DataSet(); //TOP (" + RowsCount + ")
        string qry = "SELECT  (select Top 1 Reason from M_Reason where Reason_ID=isnull(ScrapeFlag,0)) ScrapeStatus ,isnull(ScrapeFlag,0) as ScrapeFlag, Pro_ID,(select Pro_Name from Pro_Reg where M_Code_PFL.Pro_ID =Pro_Reg.Pro_ID)as Pro_Name, Batch_No, Series_Order, (case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end) as SeriesOrder1, Series_Serial," +
        //"(case when (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag)) ='0-0' then '1' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-1' then '-1' " +
        //" when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-4' then '4' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-5' then '5' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-6' then '6' " +
        //" else '0' end)as ff,
        " (CASE WHEN ((ISNULL(Batch_No,0) <> 0) AND (isnull(Scrapeflag,0) = 0)) THEN 0 WHEN ((ISNULL(Batch_No,0) = 0) AND (isnull(Scrapeflag,0) = 0)) THEN 1 ELSE  isnull(Scrapeflag,0) END ) AS ff ,Pro_ID +'-'+convert(varchar,(case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end))  +'-'+ convert(varchar,(case when len(convert(nvarchar,Series_Serial)) = 1 then '000'+ convert(nvarchar,Series_Serial) when len(convert(nvarchar,Series_Serial)) = 2 then '00'+ convert(nvarchar,Series_Serial) when len(convert(nvarchar,Series_Serial)) = 3 then '0'+ convert(nvarchar,Series_Serial) else convert(nvarchar,Series_Serial) end)) as SerialCode FROM  M_Code_PFL  where (''='" + s + "' OR Pro_ID='" + s + "') and Print_Status=1   " + //AND  [Use_Count]=0
        " AND (CASE WHEN ((ISNULL(Batch_No,0) <> 0) AND (isnull(Scrapeflag,0) = 0)) THEN 0 WHEN ((ISNULL(Batch_No,0) = 0) AND (isnull(Scrapeflag,0) = 0)) THEN 1 ELSE  isnull(Scrapeflag,0) END ) <> 4 ";
        //" (case when (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag)) ='0-0' then '1' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-1' then '-1'  when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-4' then '4' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-5' then '5' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-6' then '6'  else '0' end) <> 4 ";       
        string str = null;
        if (txtscrapfrom.Text != "" && txtscrapto.Text != "")
        {
            string[] Serialcode = txtscrapfrom.Text.Split('-');
            string pro = Serialcode[0];
            Int32 Series_Order = Convert.ToInt32(Serialcode[1]);
            Int32 Series_Serial = Convert.ToInt32(Serialcode[2]);
            string[] Serialcode1 = txtscrapto.Text.Split('-');
            string pro1 = Serialcode1[0];
            Int32 Series_Order1 = Convert.ToInt32(Serialcode1[1]);
            Int32 Series_Serial1 = Convert.ToInt32(Serialcode1[2]);
            if (Series_Order == Series_Order1 && pro == pro1 && pro == ddlProduct.SelectedValue.ToString() && pro == ddlProduct.SelectedValue.ToString())
            {
                LblMsg.Text = "";
                str = " AND Series_Order=" + Series_Order + " AND Series_Serial >= " + Series_Serial;
                str += " AND Series_Serial<=" + Series_Serial1;
            }
            else
            {
                LblMsg.Text = "Plz select right product... ";
            }
        }
        else if (txtscrapfrom.Text != "" && txtscrapto.Text == "")
        {

            string[] Serialcode = txtscrapfrom.Text.Split('-');
            string pro = Serialcode[0];
            Int32 Series_Order = Convert.ToInt32(Serialcode[1]);
            Int32 Series_Serial = Convert.ToInt32(Serialcode[2]);
            if (pro == ddlProduct.SelectedValue.ToString())
            {
                LblMsg.Text = "";
                str = "AND Series_Order=" + Series_Order + " AND Series_Serial >= " + Series_Serial;
            }
        }
        else if (txtscrapfrom.Text == "" && txtscrapto.Text != "")
        {
            string[] Serialcode1 = txtscrapto.Text.Split('-');
            string pro1 = Serialcode1[0];
            Int32 Series_Order1 = Convert.ToInt32(Serialcode1[1]);
            Int32 Series_Serial1 = Convert.ToInt32(Serialcode1[2]);
            if (pro1 == ddlProduct.SelectedValue.ToString())
            {
                LblMsg.Text = "";
                str = " AND Series_Order=" + Series_Order1 + " AND Series_Serial<=" + Series_Serial1;
            }
        }
        else
        {
            LblMsg.Text = "";
            str += "";
        }
        #endregion
        string fqry = qry + str;
        SQL_DB.GetDA(fqry).Fill(ds, "1");
        Session["GrdData"] = (DataTable)ds.Tables["1"];
        if (ddlProduct.SelectedValue.ToString() == "--Select--")
            ds.Tables["1"].Clear();
        //if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        //{
        //    if (ds.Tables["1"].Rows.Count > 0)
        //        Grdscrap.PageSize = ds.Tables["1"].Rows.Count;
        //}
        //else
        //    Grdscrap.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
       
        if (ds.Tables["1"].Rows.Count > 0)
        {
            Grdscrap.DataSource = ds.Tables["1"];
            Grdscrap.DataBind();
            Grdscrap.Visible = true;
            lblcount.Text = ds.Tables["1"].Rows.Count.ToString();
            lblC.Text = Grdscrap.Rows.Count.ToString();
        }
        else
        {
            lblcount.Text = "0";
            Grdscrap.Visible = false;
        }
           
        if (Grdscrap.Rows.Count > 0)
            Grdscrap.HeaderRow.TableSection = TableRowSection.TableHeader;


        FillGridColor();
    }
    protected void ddlbatchno_SelectedIndexChanged(object sender, EventArgs e)
    {
        fillgrid();
    }
    private void Clear()
    {
        fillProduct();
    }
    protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
    {

    }
    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        LblMsg.Text = "";
        txtscrapfrom.Text = "";
        txtscrapto.Text = "";
        fillgrid();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        
    }
    protected void Grdscrap_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Grdscrap.PageIndex = e.NewPageIndex;
        fillgrid();
    }
    protected void ddlRowProductCnt_SelectedIndexChanged(object sender, EventArgs e)
    {
        Grdscrap.SelectedIndex = 0;
        fillgrid();
    }
    private void FillGridColor()
    {
        for (int i = 0; i < Grdscrap.Rows.Count; i++)
        {
            if (Grdscrap.DataKeys[i]["ff"].ToString() == "-1") // Scrap Labels
            {
                System.Drawing.Color col = System.Drawing.ColorTranslator.FromHtml("#fbe3e4");
                Grdscrap.Rows[i].BackColor = col;
            }
            else if (Grdscrap.DataKeys[i]["ff"].ToString() == "1") // Available Labels
            {
                System.Drawing.Color col = System.Drawing.ColorTranslator.FromHtml("#c7efc8");
                Grdscrap.Rows[i].BackColor = col;
            }
            else if (Grdscrap.DataKeys[i]["ff"].ToString() == "0") // Used Labels
            {
                System.Drawing.Color col = System.Drawing.Color.LightYellow;
                Grdscrap.Rows[i].BackColor = col;
            }
            else if (Grdscrap.DataKeys[i]["ff"].ToString() == "4") // Admin Scrap Labels
            {
                System.Drawing.Color col = System.Drawing.ColorTranslator.FromHtml("#C0C7D7");
                Grdscrap.Rows[i].BackColor = col;
            }
            else if (Grdscrap.DataKeys[i]["ff"].ToString() == "6") // Courier Receive Time Scrap Labels
            {
                System.Drawing.Color col = System.Drawing.ColorTranslator.FromHtml("#FFFFFF");
                Grdscrap.Rows[i].BackColor = col;
            }
            else if (Grdscrap.DataKeys[i]["ff"].ToString() == "5") // Scrap Labels
            {
                System.Drawing.Color col = System.Drawing.ColorTranslator.FromHtml("#fbe3e4");
                Grdscrap.Rows[i].BackColor = col;
            }

        }
    }
    #region Filter According To Status
    private void RowFilterGridData(string str)
    {
        DataTable dt = (DataTable)Session["GrdData"];
        DataView dataview = dt.DefaultView;
        dataview.RowFilter = "FF = " + str;
        DataTable dt1 = dataview.ToTable();
        //if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        //{
        //    if (dt1.Rows.Count > 0)
        //        Grdscrap.PageSize = dt1.Rows.Count;
        //}
        //else
        //    Grdscrap.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
      
        if (dt1.Rows.Count > 0)
        {
            lblcount.Text = dt1.Rows.Count.ToString();
            lblC.Text = Grdscrap.Rows.Count.ToString();
            Grdscrap.Visible = true;
            Grdscrap.DataSource = dt1;
            Grdscrap.DataBind();
        }
        else
        {
            Grdscrap.Visible = false;
            lblcount.Text = "0";
        }
            

        FillGridColor();
    }
    protected void btnAdminscrap_Click(object sender, EventArgs e)
    {
        RowFilterGridData("4");
    }
    protected void btnCourierRescrap_Click(object sender, EventArgs e)
    {
        RowFilterGridData("6");
    }
    protected void btnUsed_Click(object sender, EventArgs e)
    {
        RowFilterGridData("0");
    }
    protected void btnAvailable_Click(object sender, EventArgs e)
    {
        RowFilterGridData("1");
    }
    protected void btnScrap_Click(object sender, EventArgs e)
    {
        DataTable dt = (DataTable)Session["GrdData"];
        DataView dataview = dt.DefaultView;
        dataview.RowFilter = "FF = -1 OR FF = 5";
        DataTable dt1 = dataview.ToTable();
        //if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        //{
        //    if (dt1.Rows.Count > 0)
        //        Grdscrap.PageSize = dt1.Rows.Count;
        //}
        //else
        //    Grdscrap.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        Grdscrap.DataSource = dt1;
        Grdscrap.DataBind();
        if (dt1.Rows.Count > 0)
        {
            lblcount.Text = dt1.Rows.Count.ToString();
            lblC.Text = Grdscrap.Rows.Count.ToString();
        }
        else lblcount.Text = "0";

        FillGridColor();
    }
    #endregion

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        fillgrid();
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        txtscrapfrom.Text = ""; txtscrapto.Text = ""; fillProduct();
        LblMsg.Text = "";
        fillgrid();
    }
}