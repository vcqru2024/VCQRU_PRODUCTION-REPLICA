using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;
public partial class Manufacturer_LeaderBoardReport : System.Web.UI.Page
{
    private string Totalgenratedcode = "";
    private string TotalUser = "";
    private string TotalProduct = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] != null)
        {


            if (Session["User_Type"].ToString() == "Admin")
                lblloginName.Text = "Admin";
            else
            {
                if (Session["User_Type"].ToString() != "Customer Care")
                    lblloginName.Text = SQL_DB.ExecuteScalar("SELECT [Contact_Person] FROM [Comp_Reg] where [Comp_ID] = '" + Session["CompanyId"].ToString() + "'").ToString();
                else
                    lblloginName.Text = Session["User_Type"].ToString();
            }
        }

        if (!IsPostBack)
        {
            try
            {
                SetGreeting();
                Bindcard();
            
                UserTypeLeaderBoard();
                DropDownList1.Items.Insert(0, new ListItem("Select User Type", "0"));
                DropDownList1.Enabled = true;

                string DateRangeType = "Weekly";
                string UserType = "0";
                string fromdate = string.Empty, todate = string.Empty;
                //string fromdate = System.DateTime.Now.ToString("yyyy-MM-dd") + " 00:00:00.000";
                //string todate = System.DateTime.Now.ToString("yyyy-MM-dd") + " 23:59:00.000";

                //txtDateFrom.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
                //txtDateto.Text = System.DateTime.Now.ToString("yyyy-MM-dd");        

                Bindgrid(fromdate, todate, DateRangeType, UserType);

            }
            catch (Exception ex)
            {

            }

        }

    }
    private void SetGreeting()
    {
        string greeting = GetGreetingBasedOnTime();
        lblGreeting.Text = greeting;
    }

    private string GetGreetingBasedOnTime()
    {
        DateTime now = DateTime.Now;
        int hour = now.Hour;

        if (hour >= 5 && hour < 12)
        {
            return "Good Morning";
        }
        else if (hour >= 12 && hour < 17)
        {
            return "Good Afternoon";
        }
        else if (hour >= 17 && hour < 21)
        {
            return "Good Evening";
        }
        else
        {
            return "Good Night";
        }
    }

    public void Bindcard()
    {

        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        try
        {
            string Procedure = "USP_Reports_LoyaltyDashboard";
            if(Session["CompanyId"].ToString()== "Comp-1499")
            {
                Procedure = "USP_Reports_LoyaltyDashboard_Auto_Cash_Transfer";
            }
            con.Open();
            SqlCommand cmd = new SqlCommand();

            cmd = new SqlCommand(Procedure, con);



            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@companyid", Session["CompanyId"].ToString());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            DataTable ChartData = ds.Tables[0];
            
            lblTotalcashPaid.Text = ChartData.Rows[0]["Total cash Paid"].ToString();
            lblRejectedclaims.Text = ChartData.Rows[0]["Rejected claims"].ToString();
            lblClaimReceived.Text = ChartData.Rows[0]["Claim Received"].ToString();
            lblClaimApproved.Text = ChartData.Rows[0]["Claim Approved"].ToString();
            lblUserReceivedBenefits.Text = ChartData.Rows[0]["User Received Benefits"].ToString();
            lblPendingclaims.Text = ChartData.Rows[0]["Pending claims"].ToString();
        }
        catch (Exception ex)
        {
            string msg = "Get exception in Pie with" + ex;
        }
        finally
        {
            con.Close();
        }
    }

    //private void Bindchart4()
    //{
    //    SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
    //    try
    //    {
    //        con.Open();
    //        SqlCommand cmd = new SqlCommand("USP_CodeAndUserOverview_Loyaltyboard", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@companyid", Session["CompanyId"].ToString());
    //        SqlDataAdapter da = new SqlDataAdapter(cmd);
    //        DataSet ds = new DataSet();
    //        da.Fill(ds);
    //        DataTable ChartData = ds.Tables[0];
    //        //storing total rows count to loop on each Record    
    //        string[] XPointMember = new string[ChartData.Rows.Count];
    //        int[] YPointMember = new int[ChartData.Rows.Count];
    //        for (int count = 0; count < ChartData.Rows.Count; count++)
    //        {
    //            //storing Values for X axis    
    //            XPointMember[count] = ChartData.Rows[count]["Month Name"].ToString();
    //            //storing values for Y Axis    
    //            YPointMember[count] = Convert.ToInt32(ChartData.Rows[count]["Number of Code Checked"]);
    //        }
    //        //binding chart control    
    //        Chart4.Series[0].Points.DataBindXY(XPointMember, YPointMember);

    //        //Setting width of line    
    //        Chart4.Series[0].BorderWidth = 10;
    //        //setting Chart type     
    //        Chart4.Series[0].ChartType = SeriesChartType.Column;
    //        //Chart4.Series[0].ChartType = SeriesChartType.StackedColumn;    
    //        //Hide or show chart back GridLines    
    //        Chart4.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
    //        Chart4.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;
    //        //Enabled 3D    
    //        //Chart4.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;
    //        Chart4.Series[0].Enabled = true;
    //        //Chart4.Legends[0].Enabled = true;
    //        //Chart4.Legends[0].Enabled = true;
    //        Chart4.Series[0].ToolTip = "#VALX : #VALY";
    //        //Chart4.Series[0].ToolTip = "Y Value: #VALY";
    //    }
    //    catch (Exception ex)
    //    {
    //        string msg = "Get exception in Pie with" + ex;
    //    }
    //    finally
    //    {
    //        con.Close();
    //    }
    //}


    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        grd1.DataSource = null;
        grd1.DataBind();
    }


    protected void ImgSearch_Click1(object sender, ImageClickEventArgs e)
    {

        string fromdate = string.Empty;
        string todate = string.Empty;
        string DateRangeType = string.Empty;
        string UserType = string.Empty;
        //Bindchart4();

        if (ddlst.Text != "")
            DateRangeType = ddlst.Text;
        if (ddlst.Text == "Select One")
            DateRangeType = "";



        if (DropDownList1.Text != "")
            UserType = DropDownList1.SelectedValue;

        if (DropDownList1.Text == "Select User Type")
            UserType = "";

        if (txtDateFrom.Text != "" && txtDateFrom.Text != "From Date")
        {
            fromdate = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
        }

        if (txtDateto.Text != "" && txtDateto.Text != "To Date")
        {
            todate = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
        }

        Bindgrid(fromdate, todate, DateRangeType, UserType);
    }


    public void Bindgrid(string datefrom, string dateto, string DateRangeType, string UserType)
    {
        try
        {
            SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("USP_GetLoyaltyLeaderboard", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@companyid", Session["CompanyId"].ToString());
            cmd.Parameters.AddWithValue("@StartDate ", datefrom);
            cmd.Parameters.AddWithValue("@EndDate", dateto);
            cmd.Parameters.AddWithValue("@DateRangeType", DateRangeType);
            cmd.Parameters.AddWithValue("@UserType", Convert.ToInt32(UserType));
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            grd1.DataSource = dt;
            grd1.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }


    public void UserTypeLeaderBoard()
    {
        try
        {
            SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("USP_UserTypeLeaderBoard", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@companyid", Session["CompanyId"].ToString());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            DropDownList1.DataValueField = "UserId";
            DropDownList1.DataTextField = "UserType";
            DropDownList1.DataSource = dt;
            DropDownList1.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
}