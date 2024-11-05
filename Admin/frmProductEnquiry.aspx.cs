using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business9420;
using System.Data;

public partial class frmProductEnquiry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=frmProductEnquiry.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!Page.IsPostBack)
        {
            FillCompany();
            allClear();
            fillMode(); 
            fillData();
        }
    }
    private void FillCompany()
    {
        DataSet ds = function9420.FillActiveComp();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", ddlcompname, "--Company--");
        ddlcompname.SelectedIndex = 0;
        ddlproname.Items.Clear();
        ddlproname.Items.Insert(0, "--Product--");
        ddlproname.SelectedIndex = 0;
    }
    protected void ddlcompname_SelectedIndexChanged(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        if (ddlcompname.SelectedIndex > 0)
        {
            Reg.Comp_ID = ddlcompname.SelectedValue;
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT DISTINCT Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, Pro_Reg.Comp_ID FROM M_Code FULL OUTER JOIN  Pro_Reg ON M_Code.Pro_ID = Pro_Reg.Pro_ID WHERE (M_Code.Print_Status = 1)  AND (Pro_Reg.Comp_ID = '" + ddlcompname.SelectedValue.Trim().ToString() + "')");
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlproname, "--Product--");
            ddlproname.SelectedIndex = 0;
        }
        else
        {
            ddlproname.Items.Insert(0, "--Product--");
            ddlproname.SelectedIndex = 0;
        }
    }
    private void fillMode()
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT distinct [Dial_Mode] FROM [Pro_Enq] order by [Dial_Mode]");
        if (ds.Tables[0].Rows.Count > 0)
        {
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Dial_Mode", "Dial_Mode", ddlMode, "--Select Mode--");
            ddlMode.SelectedIndex = 0;
        }
        else
        {
            ddlMode.Items.Clear();
            ddlMode.Items.Insert(0, "--Select Mode--");
        }

    }

    private void allClear()
    {
        txtDateFrom.Text = "";
        txtDateTo.Text = "";
        ddlMode.SelectedIndex = 0;
        ddlStatus.SelectedIndex = 0;
        // fillData();
    }
    private void fillData()
    {
        #region Commented Old
        //string frdate = "";
        //string todate = "";
        //string md = "";
        //string sts = "";
        //Object9420 Reg = new Object9420();        
        //if (ddlcompname.SelectedIndex > 0)
        //    Reg.Comp_ID = ddlcompname.SelectedValue;
        //else
        //    Reg.Comp_ID = "";
        //if (ddlproname.SelectedIndex > 0)
        //    Reg.Pro_ID = ddlproname.SelectedValue;
        //else
        //    Reg.Pro_ID = "";
        //if (txtDateFrom.Text == "")
        //    frdate = "convert(datetime,convert(nvarchar,[Enq_Date],111))";
        //else
        //    frdate = "'" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
        //if (txtDateTo.Text == "")
        //    todate = "convert(datetime,convert(nvarchar,[Enq_Date],111))";
        //else
        //    todate = "'" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";

        //if (ddlMode.SelectedIndex == 0)
        //    md = "[Dial_Mode]";
        //else
        //    md = "'" + ddlMode.SelectedValue.ToString() + "'";
        //if (ddlStatus.SelectedIndex == 0)
        //    sts = "(case when [Is_Success] = '1' then 'Success' else 'Unsuccess' end)";
        //else
        //    sts = "'" + ddlStatus.SelectedItem.Text.ToString() + "'";
        //DataSet ds = SQL_DB.ExecuteDataSet("SELECT M_Code.Pro_ID,(SELECT Pro_Name FROM Pro_Reg Where Pro_ID = M_Code.Pro_ID) as Pro_Name, Pro_Enq.Dial_Mode AS ModeOfInquiry,convert(nvarchar,Pro_Enq.Enq_Date,109) as EnquiryDate , Pro_Enq.Mode_Detail AS ContactDetails, Pro_Enq.Received_Code1, " +
        //" Pro_Enq.Received_Code2,(case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) as Successstatus  FROM  M_Code INNER JOIN   Pro_Enq ON CONVERT(VARCHAR,M_Code.Code1) = Pro_Enq.Received_Code1 " + 
        //" AND CONVERT(VARCHAR,M_Code.Code2) = Pro_Enq.Received_Code2 " +
        //" where ('' = '" + Reg.Pro_ID + "' OR M_Code.Pro_ID = '" + Reg.Pro_ID + "') AND convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111)) >= " + frdate + "" +
        //" and convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111)) <= " + todate + "" +
        //" and Pro_Enq.Dial_Mode = " + md + " " +
        //" and (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) = " + sts + "" +
        //" order by Pro_Enq.Enq_Date desc");
        #endregion
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
        if (ddlcompname.SelectedIndex > 0)
        {
            Reg.Comp_ID = ddlcompname.SelectedValue;
            if (Reg.Msg != null)
            {
                if (Reg.Msg.Length > 1)
                    Reg.Msg += " AND M_Code.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
            }
            else
                Reg.Msg = " WHERE M_Code.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
        }
        else
            Reg.Comp_ID = "";
        if (txtDateFrom.Text == "")
            Reg.datefromstr = "convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111))";
        else
        {            
            if (Reg.Msg != null)
            {
                if (Reg.Msg.Length > 1)
                    Reg.Msg += " AND convert(nvarchar,Pro_Enq.Enq_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
            }
            else
                Reg.Msg += " WHERE convert(nvarchar,Pro_Enq.Enq_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
        }

        if (txtDateTo.Text == "")
            Reg.datetostr = "convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111))";
        else
        {           
            if (Reg.Msg != null)
            {
                if (Reg.Msg.Length > 1)
                    Reg.Msg += " AND convert(nvarchar,Pro_Enq.Enq_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
            }
            else
                Reg.Msg += " WHERE convert(nvarchar,Pro_Enq.Enq_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";

        }
        if (ddlMode.SelectedIndex == 0)
            Reg.modestr = "Pro_Enq.Dial_Mode";
        else
        {            
            if (Reg.Msg != null)
            {
                if (Reg.Msg.Length > 1)
                    Reg.Msg += " AND Pro_Enq.[Dial_Mode] = '" + ddlMode.SelectedValue + "'";
            }
            else
                Reg.Msg += " WHERE Pro_Enq.[Dial_Mode] = '" + ddlMode.SelectedValue + "'";

        }
        if (ddlStatus.SelectedIndex == 0)
            Reg.statusstr = "(case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end)";
        else
        {            
            if (Reg.Msg != null)
            {
                if (Reg.Msg.Length > 1)
                    Reg.Msg += "AND (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) = '" + ddlStatus.SelectedItem.Text.ToString() + "'";
            }
            else
                Reg.Msg += " WHERE (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) = '" + ddlStatus.SelectedItem.Text.ToString() + "'";
        }
        DataSet ds = function9420.FillFridForEnqDetails(Reg);
        #endregion
        if (Convert.ToInt32(ddlRowsShow.SelectedValue) > 1000)
        {
            if (ds.Tables[0].Rows.Count > 0)
                GrdEnquiry.PageSize = ds.Tables[0].Rows.Count;
        }
        else
            GrdEnquiry.PageSize = Convert.ToInt32(ddlRowsShow.SelectedValue);
        if (ds.Tables[0].Rows.Count > 0)
            GrdEnquiry.DataSource = ds.Tables[0];
        GrdEnquiry.DataBind();        
        lblcount.Text = GrdEnquiry.Rows.Count.ToString();
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        fillData();
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

    protected void GrdEnquiry_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdEnquiry.PageIndex = e.NewPageIndex;
        fillData();
    }


}