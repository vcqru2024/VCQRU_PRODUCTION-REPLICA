using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business9420;
using System.Data;
using System.Web.UI.DataVisualization.Charting;
using System.Globalization;
using System.Web.UI.HtmlControls;
using System.Threading;
using System.Text;

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
            //if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
            //    Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            //if(Session["CompanyId"].ToString().ToUpper()!="COMP-1152")
            //{
            //    listate.Enabled = false;
            //}
            //else
            //{
            //    fillstate();
            //}
            allClear();
            fillservice();
          
            fillData();
           
            
           
        }
        //if (txtDateFrom.Text != "" && txtDateTo.Text != "")
        //{
        //    graphdata(ddlchart1.Text, ddlchart2.Text);
        //}

    }
    private void fillservice()
    {
        DataSet ds = SQL_DB.ExecuteDataSet("select distinct sb.service_id,serv.servicename from M_ServiceSubscription (nolock) sb left join m_service (nolock) serv on sb.Service_ID=serv.Service_ID where sb.Comp_ID='" + Session["CompanyId"].ToString() + "'");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "service_id", "servicename", ddlservice, "--Service--");
        ddlservice.SelectedIndex = 0;
    }
    private void FillLocation(string service)
    {
        DataSet ds = ExecuteNonQueryAndDatatable.filllocation(Session["CompanyId"].ToString(), service);
        //DataSet ds = SQL_DB.ExecuteDataSet("SELECT distinct [Location] FROM [Tbl_support] order by [Location]");
        DataProvider.MyUtilities.FillLISTsinglecolumnInsertZeroIndexString(ds.Tables[0], "Location", "Location", listate, "--All Location--");
        //listate.SelectedIndex = 0;
    }
   // private void fillstate()
    //{
    //    DataSet ds = SQL_DB.ExecuteDataSet("SELECT DISTINCT [D_State] as [state] FROM [M_DealerMaster] order by [D_State]");

    //    listate.DataSource = ds.Tables[0];
    //    listate.DataTextField = "state";
    //    listate.DataBind();
    //}
    private void FillProducts()
    {
        
        
        DataSet ds = SQL_DB.ExecuteDataSet("select DISTINCT pr.Pro_ID, pr.Pro_Name, pr.Comp_ID from m_servicesubscription (nolock) ms inner join Pro_Reg (nolock) pr on pr.pro_id=ms.pro_id and pr.comp_id=ms.comp_id where ms.service_id='" + ddlservice.SelectedValue + "' and pr.comp_id='" + Session["CompanyId"].ToString() + "' order by pr.Pro_Name");
      
        DataRow dr = ds.Tables[0].NewRow();
        dr[0] = "--All Product--";
        dr[1] = "--All Product--";
        ds.Tables[0].Rows.InsertAt(dr, 0);
        liproname.DataSource = ds.Tables[0];
        liproname.DataTextField = "Pro_Name";
        liproname.DataBind();
    }
    HtmlControl cnt = null;
    bool flag = true;
    
    public void graphdata(string firstcolumn,string secondcolumn)
    {
        string dtfrm = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd");
        string dtto = Convert.ToDateTime(txtDateTo.Text).ToString("yyyy-MM-dd");
        string Service = "";
        bool recordflag = true;
        if (ddlservice.SelectedIndex > 0)
            Service = ddlservice.SelectedValue;
        string query = "SELECT product, sum(convert(int,[" + secondcolumn + "])) as Amount FROM vaiewvalue(dateadd(M,-3,getdate()),'" + Session["CompanyId"].ToString() + "','" + Service + "') where [enq_date]between '" + dtfrm + " 00:00:00.000" + "' and '" + dtto + " 23:59:59.999'";
        string query1 = "SELECT product, COUNT(*) as Total, SUM(CASE WHEN tr_status = 'Success' THEN 1 ELSE 0 END) as Success,SUM(CASE WHEN tr_status = 'Unsuccess' THEN 1 ELSE 0 END) as Unsuccess FROM vaiewvalue(dateadd(M,-3,getdate()),'" + Session["CompanyId"].ToString() + "','" + Service + "') where [enq_date]between '" + dtfrm + " 00:00:00.000" + "' and '" + dtto + " 23:59:59.999'";
        string product = "and Product in(";
       string state = "and state in(";
        string status = "and tr_status=";
        if (ddlStatus.SelectedIndex > 0)
        {
             status = status+"'"+ddlStatus.Text+"'";
        }
       if(status.Length>14)
        {
            query = query + status;
            query1 = query1 + status;
        }
        DataSet ds = new DataSet();
        foreach (var item in liproname.GetSelectedIndices())
        {
            if(!liproname.Items[item].ToString().Contains("--All Product--"))
            product = product +"'"+ liproname.Items[item] + "',";
        }
        
        foreach (int item in listate.GetSelectedIndices())
        {
            if (!listate.Items[item].ToString().Contains("--All Location--"))
            {
                //state = state + "'" + listate.Items[item] + "',";
                flag = false;
            }
           
        }
        List<string> li = new List<string>();
        if(flag)
        {
            for (int i = 1; i < listate.Items.Count; i++)
            {
                li.Add(listate.Items[i].ToString());
            }
        }
        else
        {
            foreach (int item in listate.GetSelectedIndices())
            {
                li.Add(listate.Items[item].ToString());
            }
        }
        if (product.Length > 15)
        {
            product= product.Remove(product.Length - 1, 1) + ")";
            query = query + product;
            query1 = query1 + product;
        }
        if (product.Length > 15 && state.Length > 13)
        {
            state = state.Remove(state.Length - 1, 1) + ")";
            query = query + state;
            query1 = query1 + state;
        }
        else if (state.Length > 13)
        {
            state= state.Remove(state.Length - 1, 1)+")";
            query = query + state;
            query1 = query1 + state;
        }
        //if (secondcolumn == "Amount won")
        //{
          
        //     ds = SQL_DB.ExecuteDataSet(query+" group by [" + firstcolumn+"]");
        //}
        //else
        //{
        //     ds = SQL_DB.ExecuteDataSet(query1 + " group by [" + firstcolumn+"]");
        //}

        //if (ds.Tables[0].Rows.Count > 0)
        //{
        //    lblerror.Visible = false;
        //    string[] x = new string[ds.Tables[0].Rows.Count];
        //    int[] y = new int[ds.Tables[0].Rows.Count];
        //    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        //    {
        //        x[i] = ds.Tables[0].Rows[i][1].ToString();
        //        y[i] = Convert.ToInt32(ds.Tables[0].Rows[i][0]);

        //    }

            
            
         
            //string innerhtml = string.Empty;

            
            if (flag)
            {
            for (int j = 0; j < li.Count; j++)
            {

                                DataTable dtchrt;
                    if (secondcolumn == "Amount won")
                    {
                        if (li[j].ToString() == "")
                            dtchrt = SQL_DB.ExecuteDataTable(query+" and state is null GROUP BY product");
                        else
                            dtchrt = SQL_DB.ExecuteDataTable(query + " and state='" + li[j].ToString() + "' GROUP BY product");


                    }
                    else
                    {
                        if (li[j].ToString() == "")
                            dtchrt = SQL_DB.ExecuteDataTable(query1 + " and state is null GROUP BY product");
                        else
                            dtchrt = SQL_DB.ExecuteDataTable(query1 + " and state='" + li[j].ToString() + "' GROUP BY product");
                    }
                if (dtchrt.Rows.Count > 0)
                {
                    recordflag = false;
                    Chart Chart1 = new Chart();
                    Chart1.ID = "Chart" + j;
                    Chart1.Width = 700;
                    Chart1.Legends.Add("Codes");
                    Chart1.Legends["Codes"].Title = secondcolumn;
                    //Chart1.Titles.Add(listate.Items[j].ToString());
                    Chart1.ChartAreas.Add("ChartArea1");
                    for (int i = 1; i < dtchrt.Columns.Count; i++)
                    {


                        Chart1.Series.Add("Series" + i);
                        Chart1.Series["Series" + i].XValueMember = dtchrt.Columns[0].ColumnName;
                        Chart1.Series["Series" + i].YValueMembers = dtchrt.Columns[i].ColumnName;
                        Chart1.Series["Series" + i].LegendText = dtchrt.Columns[i].ColumnName;
                        Chart1.Series["Series" + i].IsValueShownAsLabel = true;
                        Chart1.Series["Series" + i].ChartArea = "ChartArea1";

                        //Chart1.Series.Add("S2");
                        //Chart1.Series["S2"].XValueMember = dtchrt.Columns[0].ColumnName;
                        //Chart1.Series["S2"].YValueMembers = dtchrt.Columns[2].ColumnName;
                        //Chart1.Series["S2"].LegendText = dtchrt.Columns[1].ColumnName;
                        //Chart1.Series["S2"].IsValueShownAsLabel = true;
                        //Chart1.Series["S2"].ChartArea = "ChartArea1";
                        //Chart1.Series.Add("S3");
                        //Chart1.Series["S3"].XValueMember = dtchrt.Columns[0].ColumnName;
                        //Chart1.Series["S3"].YValueMembers = dtchrt.Columns[3].ColumnName;
                        //Chart1.Series["S3"].LegendText = dtchrt.Columns[1].ColumnName;
                        //Chart1.Series["S3"].IsValueShownAsLabel = true;
                        //Chart1.Series["S3"].ChartArea = "ChartArea1";
                        //Chart1.Legends["Codes"].CellColumns.Add();

                    }
                    Chart1.DataSource = dtchrt;
                    Chart1.DataBind();
                    Chart1.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
                    Chart1.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;
                    Chart1.Titles.Add("Title1");
                    Chart1.Titles["Title1"].Text = "Product";
                    Chart1.Titles["Title1"].Docking = Docking.Bottom;
                    Chart1.Titles.Add("Title2");
                    Chart1.Titles["Title2"].Text = secondcolumn;
                    Chart1.Titles["Title2"].Docking = Docking.Left;
                    Chart1.Titles.Add("Title3");
                    Chart1.Titles["Title3"].Text = li[j].ToString();
                    Chart1.Titles["Title3"].Docking = Docking.Top;
                    Chart1.Titles["Title3"].Font = new System.Drawing.Font("Arial", 14, System.Drawing.FontStyle.Bold);
                    graphs.Controls.Add(Chart1);
                }
                else
                {
                    if (recordflag)
                    {
                        lblerror.Text = "Sorry! No Record Found";
                        lblerror.Visible = true;
                    }
                    else
                    {
                        lblerror.Visible = false;
                    }
                }
                }
            }
            else
            {

            for (int j = 0; j < li.Count; j++)
            {

                DataTable dtchrt;
                if (secondcolumn == "Amount won")
                {
                    if (li[j].ToString() == "")
                        dtchrt = SQL_DB.ExecuteDataTable(query + " and state is null GROUP BY product");
                    else
                        dtchrt = SQL_DB.ExecuteDataTable(query + " and state='" + li[j].ToString() + "' GROUP BY product");


                }
                else
                {
                    if (li[j].ToString() == "")
                        dtchrt = SQL_DB.ExecuteDataTable(query1 + " and state is null GROUP BY product");
                    else
                        dtchrt = SQL_DB.ExecuteDataTable(query1 + " and state='" + li[j].ToString() + "' GROUP BY product");
                }
                if (dtchrt.Rows.Count > 0)
                {
                    //recordflag = false;
                    lblerror.Visible = false;
                    Chart Chart1 = new Chart();
                    Chart1.ID = "Chart" + j;
                    Chart1.Width = 700;
                    Chart1.Legends.Add("Codes");
                    Chart1.Legends["Codes"].Title = secondcolumn;
                    //Chart1.Titles.Add(listate.Items[j].ToString());
                    Chart1.ChartAreas.Add("ChartArea1");
                    for (int i = 1; i < dtchrt.Columns.Count; i++)
                    {

                        Chart1.Series.Add("Series" + i);
                        Chart1.Series["Series" + i].XValueMember = dtchrt.Columns[0].ColumnName;
                        Chart1.Series["Series" + i].YValueMembers = dtchrt.Columns[i].ColumnName;
                        Chart1.Series["Series" + i].LegendText = dtchrt.Columns[i].ColumnName;
                        Chart1.Series["Series" + i].IsValueShownAsLabel = true;
                        Chart1.Series["Series" + i].ChartArea = "ChartArea1";

                    }
                    Chart1.DataSource = dtchrt;
                    Chart1.DataBind();
                    Chart1.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
                    Chart1.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;
                    Chart1.Titles.Add("Title1");
                    Chart1.Titles["Title1"].Text = "Product";
                    Chart1.Titles["Title1"].Docking = Docking.Bottom;
                    Chart1.Titles.Add("Title2");
                    Chart1.Titles["Title2"].Text = secondcolumn;
                    Chart1.Titles["Title2"].Docking = Docking.Left;
                    Chart1.Titles.Add("Title3");
                    Chart1.Titles["Title3"].Text = li[j].ToString();
                    Chart1.Titles["Title3"].Docking = Docking.Top;
                    Chart1.Titles["Title3"].Font = new System.Drawing.Font("Arial", 14, System.Drawing.FontStyle.Bold);
                    graphs.Controls.Add(Chart1);
                }
                else
                {
                    if (recordflag)
                    {
                        lblerror.Text = "Sorry! No Record Found";
                        lblerror.Visible = true;
                    }
                    else
                    {
                        lblerror.Visible = false;
                    }
                }
                }
            }


        //}
        //else
        //{
        //    lblerror.Visible = true;
        //}
        

    }
   

    


    private void allClear()
    {
        txtDateFrom.Text = "";
        txtDateTo.Text = "";
     
    }
    private void fillData()
    {
        
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
        Page.Validate("servss");
        if (Page.IsValid)
        {
            TimeSpan t = Convert.ToDateTime(txtDateTo.Text).Subtract(Convert.ToDateTime(txtDateFrom.Text));
            if (t.TotalDays > 90)
            {
                lblerror.Text = "Selected dates Exceed 90 days! Kindly select maximum 90 days";
                lblerror.Visible = true;
            }
            else
            {
                lblerror.Visible = false;
                graphdata(ddlchart1.Text, ddlchart2.Text);
               // ddlchart1.Enabled = true;
                ddlchart2.Enabled = true;
                

            }
        }
    }



    protected void ddlchart1_SelectedIndexChanged(object sender, EventArgs e)
    {
        graphdata(ddlchart1.Text, ddlchart2.Text);
    }

    protected void ddlchart2_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        graphdata(ddlchart1.Text, ddlchart2.Text);
    }
    protected void ddlservice_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillLocation(ddlservice.SelectedValue);
        FillProducts();
    }

    //protected void Unnamed_Click(object sender, ImageClickEventArgs e)
    //{
    //    Report_chart.SaveImage(@"C:\Temp\HiddenChart.png",ChartImageFormat.Png);
    //}
}
