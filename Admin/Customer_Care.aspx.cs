using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business9420;
using System.Data;

public partial class Customer_Care : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=Customer_Care.aspx");
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
            //fillData();
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
        txtDateFrom.Text = string.Empty;
        txtDateTo.Text = string.Empty;
        txtcode1.Text = string.Empty;
        txtcode2.Text = string.Empty;
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
        if (ddlcompname.SelectedIndex > 0)
            Reg.Comp_ID = ddlcompname.SelectedValue;
        else
            Reg.Comp_ID = "";
        if (ddlproname.SelectedIndex > 0)
            Reg.Pro_ID = ddlproname.SelectedValue;
        else
            Reg.Pro_ID = "";
        if (txtDateFrom.Text == "")
            Reg.datefromstr = "convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111))";
        else
            Reg.datefromstr = "'" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
        if (txtDateTo.Text == "")
            Reg.datetostr = "convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111))";
        else
            Reg.datetostr = "'" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
        if (ddlMode.SelectedIndex == 0)
            Reg.modestr = "Pro_Enq.Dial_Mode";
        else
            Reg.modestr = "'" + ddlMode.SelectedValue.ToString() + "'";
        if (ddlStatus.SelectedIndex == 0)
            Reg.statusstr = "(case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end)";
        else
            Reg.statusstr = "'" + ddlStatus.SelectedItem.Text.ToString() + "'";  
        if(txtcode1.Text != "")
            Reg.statusstr += " AND M_Code.Code1 = '" + txtcode1.Text.Trim() + "'";
        if (txtcode2.Text != "")
            Reg.statusstr += " AND M_Code.Code2 = '" + txtcode2.Text.Trim() + "'";

        DataSet ds = new DataSet();
        if ((txtcode1.Text != "") && (txtcode2.Text != ""))
        {
            if (SQL_DB.ExecuteDataSet("SELECT isnull(Pro_ID,'') as Pro_ID FROM M_Code where Code1 ='" + txtcode1.Text.Trim() + "' AND Code2='" + txtcode2.Text.Trim() + "' ").Tables[0].Rows[0]["Pro_ID"].ToString() != "")
                ds = function9420.GrdVwEnquiryDetails(Reg);
            else
            {
                ds = SQL_DB.ExecuteDataSet("select (SELECT Pro_ID FROM M_Code where Code1 =Pro_Enq.Received_Code1 AND Code2=Pro_Enq.Received_Code2) AS Pro_ID,'--' AS Comp_Name,'--' AS Pro_Name,Dial_Mode AS ModeOfInquiry,CONVERT(nvarchar, dbo.Pro_Enq.Enq_Date, 109) " +
                " AS EnquiryDate, dbo.Pro_Enq.Mode_Detail AS ContactDetails, dbo.Pro_Enq.Received_Code1, dbo.Pro_Enq.Received_Code2, (CASE WHEN Pro_Enq.Is_Success = '1' THEN 'Success' ELSE 'Unsuccess' END) AS Successstatus  , '--' as Batch_No, '--' as MRP, '--' as Mfd_Date,   " +
                " '--' as Exp_Date from Pro_Enq WHERE (''='" + txtcode1.Text.Trim() + "' OR Pro_Enq.Received_Code1 ='" + txtcode1.Text.Trim() + "') AND (''='" + txtcode2.Text.Trim() + "' OR Pro_Enq.Received_Code2='" + txtcode2.Text.Trim() + "') ");
            }
        }
        else
        {
            ds = function9420.GrdVwEnquiryDetails(Reg);
        }
        #endregion
        if (ds.Tables[0].Rows.Count > 0)
            GrdEnquiry.DataSource = ds.Tables[0];
        GrdEnquiry.DataBind();
        lblcount.Text = GrdEnquiry.Rows.Count.ToString();
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