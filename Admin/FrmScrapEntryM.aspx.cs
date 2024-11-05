using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Business9420;

public partial class FrmScrapEntryM : System.Web.UI.Page
{
    public int ScrapeFlag = 0;
    public int index = 0;
    public Int32 sr = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmScrapEntryM.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }  
        if (!IsPostBack)
        {
            //Clear();
            fillCompany();
            fillgrid();
        }
    }
    private void fillCompany()
    {
        ddlCompany.Items.Clear();
        ddlProduct.Items.Clear();
        DataSet ds = function9420.FillActiveComp();  //SQL_DB.ExecuteDataSet("SELECT [Comp_ID],[Comp_Name] FROM[Comp_Reg] where Comp_Type = 'L' order by [Comp_Name]");
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlCompany.DataSource = ds.Tables[0];
            ddlCompany.DataTextField = "Comp_Name";
            ddlCompany.DataValueField = "Comp_ID";
            ddlCompany.DataBind();
            ddlCompany.Items.Insert(0, "--Select--");
            ddlProduct.Items.Insert(0, "--Select--");
        }
        else
        {
            ddlCompany.Items.Clear();
            ddlCompany.Items.Insert(0, "--Select--");
            ddlProduct.Items.Insert(0, "--Select--");
        }
        ddlCompany.SelectedIndex = 0;
        ddlProduct.SelectedIndex = 0;
    }
    private bool DeleteScrap(string s)
    {
        int i = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT count([Serial_Code]) FROM [Scrap_Label] WHERE [Serial_Code]='" + s + "'"));
        if (i == 1)
            return true;
        else
            return false;
    }
    protected void btnYesScrap_Click(object sender, EventArgs e)
    {
        if (hidden1.Value != null)
            ScrapEntry(Convert.ToInt32(ddlreason.SelectedValue));
        else
        {
            LblMsg.Text = "No row selected";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            LblMsg.Font.Bold = true;
            hidden1.Value = string.Empty;
        }
    }
    private void ScrapEntry(int reasonid)
    {
        if (hidden1.Value != null)//(Request.Form["chkselect"] != null)
        {
            string[] Arr = hidden1.Value.ToString().Split(',');
            for (int i = 0; i < Arr.Length; i++)
            {
                DataSet ds = new DataSet();
                string updateqry = null;
                string[] str = Arr[i].Split('-');
                string pro = str[0].ToString();
                Int32 series_order = Convert.ToInt32(str[1]);
                Int32 series_serial = Convert.ToInt32(str[2]);
                string Qry = "SELECT isnull([Batch_No],0) AS BT FROM [M_Code] WHERE Pro_Id='" + pro + "' and [Series_Order]=" + series_order + " and [Series_Serial]=" + series_serial;// and ScrapeFlag=0
                string batch = null;
                SQL_DB.GetDA(Qry).Fill(ds, "1");//[Batch_No] = null ,
                if (ds.Tables["1"].Rows.Count > 0)
                    batch = ds.Tables["1"].Rows[0]["BT"].ToString();
                else
                    batch = "0";
                string Serial_Code = pro + "-" + string.Format("{0:00}", Convert.ToInt32(series_order)) + "-" + string.Format("{0:000}", series_serial);
                updateqry = "UPDATE [M_Code] SET [ScrapeFlag] = " + Convert.ToInt32(reasonid) + " WHERE Pro_ID='" + ddlProduct.SelectedValue + "'  and Print_Status=1 and Series_Order=" + series_order + "  and Series_Serial=" + series_serial + "";
                SQL_DB.ExecuteNonQuery(updateqry);
                string qry = "INSERT INTO [Scrap_Label]([Comp_ID],[Pro_ID] ,[Batch_No] ,[Serial_Code],[Type] )VALUES('" + ddlCompany.SelectedValue.Trim().ToString() + "','" + ddlProduct.SelectedValue + "','" + batch + "','" + Arr[i].ToString() + "',1)";
                string Qry1 = "SELECT * FROM Scrap_Label WHERE (Serial_Code = '" + Serial_Code + "') ";
                string Qry2 = "DELETE FROM [Scrap_Label] WHERE (Serial_Code = '" + Serial_Code + "') ";
                SQL_DB.GetDA(Qry1).Fill(ds, "2");//[Batch_No] = null ,
                if (ds.Tables["2"].Rows.Count > 0)
                {
                    if (reasonid.ToString() == "0")
                        SQL_DB.ExecuteNonQuery(Qry2);
                }
                else
                {
                    if (reasonid.ToString() != "0")
                        SQL_DB.ExecuteNonQuery(qry);
                }

                fillgrid();
                LblMsg.Text = Convert.ToString(Arr.Length) + " Rows Updated";
            }
        }
        else
            LblMsg.Text = "no row selected";
        fillgrid();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Request.Form["chkselect"] != null)
        {
            hidden1.Value = Convert.ToString(Request.Form["chkselect"]);
            FillReason();
            LabelAlertNewHeader.Text = "Scrap Reason";
            ModalPopupExtenderScrap.Show();
        }
        else
        {
            hidden1.Value = string.Empty;
            LblMsg.Text = "No row selected";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            LblMsg.Font.Bold = true;
        }
    }
    private void FillReason()
    {
        DataSet ds = function9420.GetReason(Session["User_Type"]);
        ddlreason.DataSource = ds.Tables[0];
        ddlreason.DataTextField = "Reason";
        ddlreason.DataValueField = "Reason_ID";
        ddlreason.DataBind();
        ddlreason.Items.Insert(0, "--Select--");
        ddlreason.SelectedIndex = 0;
        txtreasonremarks.Text = string.Empty;
    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        fillgrid();
    }

    private void fillProduct()
    {
        ddlProduct.Items.Clear();
        DataSet ds = new DataSet();
        if(ddlCompany.SelectedIndex > 0)
            ds = SQL_DB.ExecuteDataSet("SELECT DISTINCT Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, Pro_Reg.Comp_ID FROM M_Code FULL OUTER JOIN  Pro_Reg ON M_Code.Pro_ID = Pro_Reg.Pro_ID WHERE (M_Code.Print_Status = 1)  AND (Pro_Reg.Comp_ID = '" + ddlCompany.SelectedValue.Trim().ToString() + "')");        
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlProduct.DataSource = ds.Tables[0];
            ddlProduct.DataTextField = "Pro_Name";
            ddlProduct.DataValueField = "Pro_ID";
            ddlProduct.DataBind();
            ddlProduct.Items.Insert(0, "--Select--");
        }
        else
        {
            ddlProduct.Items.Insert(0, "--Select--");
        }
        ddlProduct.SelectedIndex = 0;
    }
    private void fillgrid()
    {
        string s = null;
        if (ddlProduct.SelectedIndex == 0)
            s = null;
        else 
            s = ddlProduct.SelectedValue.ToString();
              DataSet ds = new DataSet();
              #region Commented Code Old For Only Batch Purpose
              string qry = "SELECT * FROM (SELECT  isnull(ScrapeFlag,0) as ScrapeFlag, Pro_ID,(select Pro_Name from Pro_Reg where M_Code.Pro_ID =Pro_Reg.Pro_ID)as Pro_Name, Batch_No, Series_Order, (case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end) as SeriesOrder1,Series_Serial, " +
                  //" (case when (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag)) ='0-0' then '1' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-1' then '-1' " +                 
                  //" when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-4' then '4' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-5' then '5' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-6' then '6' " +
                  //" else '0' end)as ff, " +
                //" (CASE WHEN ((ISNULL(Batch_No,0) <> 0) AND (Scrapeflag = 0)) THEN 0 WHEN ((ISNULL(Batch_No,0) = 0) AND (Scrapeflag = 0)) THEN 1 ELSE  Scrapeflag END ) AS ff " + 
                " isnull(DispatchFlag,0) as DispatchFlag  , " +
                "(CASE WHEN ((DispatchFlag = 1) AND (ISNULL(Scrapeflag,0) <> 0))  THEN 6 ELSE ISNULL(Scrapeflag,0) END) AS ff, Pro_ID +'-'+convert(varchar,(case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end))  +'-'+ convert(varchar,(case when len(convert(nvarchar,Series_Serial)) = 1 then '000'+ convert(nvarchar,Series_Serial) when len(convert(nvarchar,Series_Serial)) = 2 then '00'+ convert(nvarchar,Series_Serial) when len(convert(nvarchar,Series_Serial)) = 3 then '0'+ convert(nvarchar,Series_Serial) else convert(nvarchar,Series_Serial) end)) as SerialCode FROM  M_Code  where (''='" + s + "' OR Pro_ID='" + s + "') and Print_Status=1  AND  isnull([Use_Count],0)=0  " +
                " AND Batch_No IS NULL) reg where reg.ff in (4,0,6) "; // and reg.DispatchFlag = 0 AND DispatchFlag IS NULL
              #endregion
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

        string fqry = qry + str;
        SQL_DB.GetDA(fqry).Fill(ds, "1");
        Session["GrdVwFilter"] = (DataView)ds.Tables["1"].DefaultView;
        DataView dv = new DataView();
        dv = ds.Tables["1"].DefaultView;
        //dv.RowFilter = "DispatchFlag = 0";                
        dv.RowFilter = "DispatchFlag = 1"; // done by shweta
        DataTable dt = new DataTable();
        dt = dv.ToTable();        
        Session["GrdData"] = (DataTable)dt;
        if (ddlProduct.SelectedValue.ToString() == "--Select--")
            dt.Clear();
        if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        {
            if(dt.Rows.Count > 0)
               Grdscrap.PageSize = dt.Rows.Count;
        }
        else
            Grdscrap.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        Grdscrap.DataSource = dt;
        Grdscrap.DataBind();
        if (dt.Rows.Count > 0)
        {
            lblcount.Text = dt.Rows.Count.ToString();
            lblC.Text = Grdscrap.Rows.Count.ToString();
            DataView dv1 = new DataView();
            dv1 = (DataView)Session["GrdVwFilter"];
            dv1.RowFilter = "DispatchFlag = 1";
            DataTable dt1 = new DataTable();
            dt1 = dv1.ToTable();
            if (dt1.Rows.Count > 0)
                Labeldispath.Text = dt1.Rows.Count.ToString();
            else
                Labeldispath.Text = "0";
        }
        else
        {
            lblcount.Text = "0";
            Labeldispath.Text = "0";
        }
       // Grdscrap.PageIndex = 0;
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
        //string qry = null;
        //CheckBox chkAll = (CheckBox)Grdscrap.HeaderRow.FindControl("chkSelectAll");
        //if (chkAll.Checked == true)
        //{

        //    foreach (GridViewRow gvRow in Grdscrap.Rows)
        //    {
        //        CheckBox chkSel = (CheckBox)gvRow.FindControl("chkSelect");
        //        chkSel.Checked = true;



        //    }
        //    //DataSet ds = new DataSet();
        //    //SQL_DB.GetDA("SELECT  top(1) (case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end) as SeriesOrder1,Series_Serial,Pro_ID+'-'+convert(varchar,(case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end))+'-'+convert(varchar,Series_Serial) as SerialCode FROM  M_Code  where Pro_ID='AA07' AND Print_Status=1  AND Series_Order=1 AND Series_Serial >= 1 AND  [Use_Count]=0  order by Series_Serial asc").Fill(ds, "1");
        //    //if (ds.Tables[0].Rows.Count > 0)
        //    //{
        //    //    txtscrapfrom.Text = ds.Tables[0].Rows[0]["SerialCode"].ToString();
        //    //}

        //    //SQL_DB.GetDA("SELECT  top(1) (case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end) as SeriesOrder1,Series_Serial,Pro_ID+'-'+convert(varchar,(case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end))+'-'+convert(varchar,Series_Serial) as SerialCode FROM  M_Code  where Pro_ID='AA07' AND Print_Status=1  AND Series_Order=1 AND Series_Serial >= 1 AND  [Use_Count]=0  order by Series_Serial desc").Fill(ds, "2");
        //    //if (ds.Tables[1].Rows.Count > 0)
        //    //{
        //    //    txtscrapto.Text = ds.Tables[1].Rows[0]["SerialCode"].ToString();
        //    //}

        //} 
        //else
        //    foreach (GridViewRow gvRow in Grdscrap.Rows)
        //    {
        //        CheckBox chkSel = (CheckBox)gvRow.FindControl("chkSelect");
        //        chkSel.Checked = false;
        //        //txtscrapfrom.Text = string.Empty;
        //        //txtscrapto.Text = string.Empty;


        //    }
        
    }
    protected void ddlddlComp_SelectedIndexChanged(object sender, EventArgs e)
    {
        LblMsg.Text = "";
        txtscrapfrom.Text = "";
        txtscrapto.Text = "";
        Clear();
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
        txtscrapfrom.Text = ""; txtscrapto.Text = ""; fillProduct();
        LblMsg.Text = "";
        fillgrid();
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
            else if (Grdscrap.DataKeys[i]["ff"].ToString() == "0") // Used Labels For Manuf.
            {
                System.Drawing.Color col = System.Drawing.ColorTranslator.FromHtml("#c7efc8");//System.Drawing.Color.LightYellow;
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
        if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        {
            if (dt1.Rows.Count > 0)
                Grdscrap.PageSize = dt1.Rows.Count;
        }
        else
            Grdscrap.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
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
        RowFilterGridData("0"); //RowFilterGridData("1");
    }
    protected void btnScrap_Click(object sender, EventArgs e)
    {
        DataTable dt = (DataTable)Session["GrdData"];
        DataView dataview = dt.DefaultView;
        dataview.RowFilter = "FF = -1 OR FF = 5";
        DataTable dt1 = dataview.ToTable();
        if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        {
            if (dt1.Rows.Count > 0)
                Grdscrap.PageSize = dt1.Rows.Count;
        }
        else
            Grdscrap.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
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
}