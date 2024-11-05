using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_Graph : System.Web.UI.Page
{
    static string cs = ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString;
    static SqlConnection con = new SqlConnection(cs);
    static string compId;
    protected void Page_Load(object sender, EventArgs e)
    {
        // Session["User_Type"] = "Comp-1275";
        // Session["CompanyId"] = "Comp-1256";

        if (Session["User_Type"] == null)
            Response.Redirect("~/Login.aspx?Page=FrmUploadDealerCode.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("~/adminLogin.aspx");
            bindlable();
            if (!Page.IsPostBack)
            {
                // Bind Gridview  
                //  BindGvData();

                // Bind Charts  
                BindChart();
                BindChart1();
                //BindChart2();
            }
        }


    }

    public void bindlable()
    {
        SqlCommand cmd = new SqlCommand("sp_getdataforchart", con);
        cmd.Parameters.AddWithValue("@comp_id", Session["CompanyId"].ToString());
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable ds = new DataTable();
        da.Fill(ds);
        lblttlcode.Text = ds.Rows[0][0].ToString();
        lbltotalusers.Text = ds.Rows[0][2].ToString();
        lbltotalproduct.Text = ds.Rows[0][3].ToString();

        compId = Session["CompanyId"].ToString();
    }


    private void BindChart()
    {
        DataTable dsChartData = new DataTable();
        StringBuilder strScript = new StringBuilder();

        try
        {
            dsChartData = GetChartData();

            strScript.Append(@"<script type='text/javascript'>  
                    google.load('visualization', '1', {packages: ['corechart']}); </script>  
                      
                    <script type='text/javascript'>  
                     
                    function drawChart() {         
                    var data = google.visualization.arrayToDataTable([  
                    ['Quarter', 'SalesValue'],");

            foreach (DataRow row in dsChartData.Rows)
            {
                strScript.Append("['" + row["Quarter"] + "'," + row["SalesValue"] + "],");
            }
            strScript.Remove(strScript.Length - 1, 1);
            strScript.Append("]);");

            strScript.Append(@" var options = {     
                                    title: 'Total Generated codes VS Used Codes ',            
                                    is3D: true,          
                                    };   ");

            strScript.Append(@"var chart = new google.visualization.PieChart(document.getElementById('myChart'));          
                                chart.draw(data, options);        
                                }    
                            google.setOnLoadCallback(drawChart);  
                            ");
            strScript.Append(" </script>");

            ltScripts.Text = strScript.ToString();
        }
        catch
        {
        }
        finally
        {
            dsChartData.Dispose();
            strScript.Clear();
        }
    }


    private DataTable GetChartData()
    {
        DataSet dsData = new DataSet();
        try
        {
            SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
            //string query = "GetSaleData";
            SqlCommand cmd = new SqlCommand("GetSaleData", sqlCon);
            SqlDataAdapter sqlCmd = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Comp_id", Session["CompanyId"].ToString());
            sqlCmd.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlCon.Open();
            sqlCmd.Fill(dsData);
            sqlCon.Close();
        }
        catch
        {
            throw;
        }
        return dsData.Tables[0];
    }

    private void BindChart1()
    {
        DataTable dsChartData = new DataTable();
        StringBuilder strScript = new StringBuilder();

        try
        {
            dsChartData = GetChartData1();

            strScript.Append(@"<script type='text/javascript'>  
                    google.load('visualization', '1', {packages: ['corechart']});</script>  
  
                    <script type='text/javascript'>  
                    function drawVisualization() {         
                    var data = google.visualization.arrayToDataTable([  
                    ['Pro_Name', 'Total_code', 'UnUsedcode', 'UsedCode'],");

            foreach (DataRow row in dsChartData.Rows)
            {
                strScript.Append("['" + row["Pro_Name"] + "'," + row["Total_code"] + "," +
                    row["UnUsedcode"] + "," + row["UsedCode"] + "],");
            }
            strScript.Remove(strScript.Length - 1, 1);
            strScript.Append("]);");

            strScript.Append("var options = { title : '', vAxis: {title: 'Code'},  hAxis: {title: 'Product'}, seriesType: 'bars', series: {3: {type: 'line'}} };");
            strScript.Append(" var chart = new google.visualization.ComboChart(document.getElementById('piechart_3d'));  chart.draw(data, options); } google.setOnLoadCallback(drawVisualization);");
            strScript.Append(" </script>");

            ltScripts1.Text = strScript.ToString();
        }
        catch
        {
        }
        finally
        {
            dsChartData.Dispose();
            strScript.Clear();
        }
    }


    private DataTable GetChartData1()
    {
        DataSet dsData = new DataSet();
        try
        {
            SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
            //SqlDataAdapter sqlCmd = new SqlDataAdapter("GetData1", sqlCon);
            SqlCommand cmd = new SqlCommand("sp_Codedetails_productwise", sqlCon);
            SqlDataAdapter sqlCmd = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@comp_id", Session["CompanyId"].ToString());
            sqlCmd.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlCon.Open();
            sqlCmd.Fill(dsData);
            sqlCon.Close();
        }
        catch
        {
            throw;
        }
        return dsData.Tables[0];
    }







    private void BindChart2()
    {
        DataTable dsChartData = new DataTable();
        StringBuilder strScript = new StringBuilder();

        try
        {
            dsChartData = GetChartData2();

            strScript.Append(@"<script type='text/javascript'>  

                    google.load('visualization', '1', {packages: ['corechart']}); </script>  
                    < script type='text/javascript'>  
                    function drawChart() {         
                    var data = google.visualization.arrayToDataTable([  
                    ['City', 'Total_Users'],");
            foreach (DataRow row in dsChartData.Rows)
            {
                strScript.Append("['" + row["City"] + "'," + row["Total_Users"] + "],");
            }
            strScript.Remove(strScript.Length - 1, 1);
            strScript.Append("]);");

            strScript.Append(@" var options = {     
                                    title: 'City Wise Used Code ',            
                                    is3D: true, 
                                    
                                    };   ");

            strScript.Append(@"var chart = new google.visualization.PieChart(document.getElementById('container'));          
                                chart.draw(data, options);        
                                }  
                           
                            google.setOnLoadCallback(drawChart);  
                            ");
            strScript.Append(" </script>");

            ltScripts2.Text = strScript.ToString();
        }
        catch
        {
        }
        finally
        {
            dsChartData.Dispose();
            strScript.Clear();
        }
    }

    private DataTable GetChartData2()
    {
        DataSet dsData = new DataSet();
        try
        {
            SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
            //SqlDataAdapter sqlCmd = new SqlDataAdapter("GetData1", sqlCon);
            SqlCommand cmd = new SqlCommand("sp_getusercitywise", sqlCon);
            SqlDataAdapter sqlCmd = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@comp_id", Session["CompanyId"].ToString());
            sqlCmd.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlCon.Open();
            sqlCmd.Fill(dsData);
            sqlCon.Close();
        }
        catch
        {
            throw;
        }
        return dsData.Tables[0];


    }


    [WebMethod]
    public static List<object> GetChartData4()
    {
        string query = "sp_statewisecodecheck";
        string constr = ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString;
        List<object> chartData = new List<object>();
        chartData.Add(new object[]
        {
        "State_List", "Total_Checked_Code"
        });
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand(query))
            {
                //compId = "Comp-1256";
                cmd.Parameters.AddWithValue("@Comp_id", compId);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                con.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        chartData.Add(new object[]
                        {
                        sdr["City"], sdr["Total_Checked_Code"]
                        });
                    }
                }
                con.Close();
                return chartData;
            }
        }
    }

    [WebMethod]
    public static List<object> GetChartData5()
    {
        string query = "sp_getusercitywise";
        string constr = ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString;
        List<object> chartData = new List<object>();
        chartData.Add(new object[]
        {
        "City", "Total_Users"
        });
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand(query))
            {
                cmd.Parameters.AddWithValue("@Comp_id", compId);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                con.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        chartData.Add(new object[]
                        {
                        sdr["City"], sdr["Total_Users"]
                        });
                    }
                }
                con.Close();
                return chartData;
            }
        }
    }


}