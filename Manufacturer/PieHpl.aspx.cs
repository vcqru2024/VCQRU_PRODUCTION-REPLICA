using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;
public partial class Manufacturer_PieHpl : System.Web.UI.Page
{
    private string Totalgenratedcode = "";
    private string TotalUser = "";
    private string TotalProduct = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("~/Login.aspx?Page=FrmUploadDealerCode.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("~/adminLogin.aspx");
        }
        if (!IsPostBack)
        {
            try
            {
                Bindcard();
               // Bindchart();
               // BindChart2();
               // BindChart3();
               // Bindchart4();
                BindChart1();
                BindChart5();             


                GetCodeReports();
            }
            catch (Exception ex)
            {

            }

        }
    }
    private void GetCodeReports()
    {
        // DataSet dsCodeRp = Business9420.function9420.CodeReports(Session["CompanyId"].ToString());
        DataSet dsCodeRp = SQL_DB.ExecuteDataSet("exec USP_GetCodesDashboard_HPL '" + Session["CompanyId"].ToString() + "'");
        if (dsCodeRp.Tables[0].Rows.Count > 0)
        {
            LabelAllowCode.Text = dsCodeRp.Tables[0].Rows[0]["Allowed Codes"].ToString();
            LabelScrabCode.Text = dsCodeRp.Tables[0].Rows[0]["Scraped Codes"].ToString();
            LabelUseCode.Text = dsCodeRp.Tables[0].Rows[0]["Used Codes"].ToString();
            LabelDownloadcode.Text = dsCodeRp.Tables[0].Rows[0]["Downloaded Codes"].ToString();
            LabelAvailableCode.Text = dsCodeRp.Tables[0].Rows[0]["Available Codes"].ToString();
            LabelActivecode.Text = dsCodeRp.Tables[0].Rows[0]["Downloaded Codes"].ToString();
        }
    }

    public void Bindcard()
    {

        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_getdataforchart", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@comp_id", Session["CompanyId"].ToString());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            DataTable ChartData = ds.Tables[0];
            //lbltotalcode.Text = ChartData.Rows[0]["Total_Code"].ToString();
            //lblttlusedcode.Text = ChartData.Rows[0]["Used_code"].ToString();
            lblttluser.Text = ChartData.Rows[0]["Total_User"].ToString();
            lblttlproduct.Text = ChartData.Rows[0]["Total_Product"].ToString();
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



    private void BindChart1()
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("USP_GetTotalConsumedCodesGraph_HPL", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@companyid", Session["CompanyId"].ToString());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            DataTable ChartData = ds.Tables[0];

            //storing total rows count to loop on each Record  
            string[] XPointMember = new string[ChartData.Rows.Count];
            int[] YPointMember = new int[ChartData.Rows.Count];

            for (int count = 0; count < ChartData.Rows.Count; count++)
            {
                //storing Values for X axis  
                XPointMember[count] = ChartData.Rows[count]["Name"].ToString();
                //storing values for Y Axis  
                YPointMember[count] = Convert.ToInt32(ChartData.Rows[count]["Value"]);

            }
            //binding chart control  
            Chart1.Series[0].Points.DataBindXY(XPointMember, YPointMember);

            //Setting width of line  
            Chart1.Series[0].BorderWidth = 10;
            //setting Chart type   
            Chart1.Series[0].ChartType = SeriesChartType.Doughnut;


            foreach (Series charts in Chart1.Series)
            {
                foreach (DataPoint point in charts.Points)
                {
                    switch (point.AxisLabel)
                    {
                        case "Total Code Generated": point.Color = Color.RoyalBlue; break;
                        case "Total Code Used": point.Color = Color.BlueViolet; break;
                        case "Unused Codes": point.Color = Color.LightSteelBlue; break;
                    }
                    point.Label = string.Format("{0:0} - {1}", point.YValues[0], point.AxisLabel);

                }
            }
            //Enabled 3D  
            Chart1.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;



            Chart1.Legends[0].Enabled = true;
            Chart1.Legends[0].Enabled = true;

            Chart1.Series[0].ToolTip = "#VALX : #VALY";
            Chart1.Series[0]["PieLabelStyle"] = "Disabled";
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

    private void BindChart5()
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("USP_GetClaimDetailsGraph_HPL", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@companyid", Session["CompanyId"].ToString());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            DataTable ChartData = ds.Tables[0];

            //storing total rows count to loop on each Record  
            string[] XPointMember = new string[ChartData.Rows.Count];
            int[] YPointMember = new int[ChartData.Rows.Count];

            for (int count = 0; count < ChartData.Rows.Count; count++)
            {
                //storing Values for X axis  
                XPointMember[count] = ChartData.Rows[count]["Name"].ToString();
                //storing values for Y Axis  
                YPointMember[count] = Convert.ToInt32(ChartData.Rows[count]["Value"]);

            }
            //binding chart control  
            Chart5.Series[0].Points.DataBindXY(XPointMember, YPointMember);

            //Setting width of line  
            Chart5.Series[0].BorderWidth = 10;
            //setting Chart type   
            Chart5.Series[0].ChartType = SeriesChartType.Doughnut;


            foreach (Series charts in Chart5.Series)
            {
                foreach (DataPoint point in charts.Points)
                {
                    switch (point.AxisLabel)
                    {
                        case "Total Claim Received": point.Color = Color.Green; break;
                        case "Claim Approved": point.Color = Color.BlueViolet; break;
                        case "Claim Rejected": point.Color = Color.Lavender; break;
                        case "Claim Pending": point.Color = Color.LightSteelBlue; break;
                    }
                    point.Label = string.Format("{0:0} - {1}", point.YValues[0], point.AxisLabel);

                }
            }
            //Enabled 3D  
            Chart5.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;



            Chart5.Legends[0].Enabled = true;
            Chart5.Legends[0].Enabled = true;

            Chart5.Series[0].ToolTip = "#VALX : #VALY";
            Chart5.Series[0]["PieLabelStyle"] = "Disabled";
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

    //private void Bindchart()
    //{
    //    SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
    //    try
    //    {
    //        con.Open();
    //        SqlCommand cmd = new SqlCommand("GetSaleData", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@Comp_id", Session["CompanyId"].ToString());
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
    //            XPointMember[count] = ChartData.Rows[count]["Quarter"].ToString();
    //            //storing values for Y Axis  
    //            YPointMember[count] = Convert.ToInt32(ChartData.Rows[count]["SalesValue"]);

    //        }
    //        //binding chart control  
    //        Chart1.Series[0].Points.DataBindXY(XPointMember, YPointMember);

    //        //Setting width of line  
    //        Chart1.Series[0].BorderWidth = 10;
    //        //setting Chart type   
    //        Chart1.Series[0].ChartType = SeriesChartType.Pie;


    //        foreach (Series charts in Chart1.Series)
    //        {
    //            foreach (DataPoint point in charts.Points)
    //            {
    //                switch (point.AxisLabel)
    //                {
    //                    case "UnUsed Code": point.Color = Color.RoyalBlue; break;
    //                    case "Used Code": point.Color = Color.Red; break;
    //                        //case "Q3": point.Color = Color.SpringGreen; break;
    //                }
    //                point.Label = string.Format("{0:0} - {1}", point.YValues[0], point.AxisLabel);

    //            }
    //        }
    //        //Enabled 3D  
    //        Chart1.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;
    //        Chart1.Legends[0].Enabled = true;
    //        Chart1.Legends[0].Enabled = true;
    //        Chart1.Series[0].ToolTip = "Total : #VALY";
    //        Chart1.Series[0]["PieLabelStyle"] = "Disabled";
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
    //private void BindChart2()
    //{
    //    SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
    //    try
    //    {
    //        con.Open();
    //        SqlCommand cmd = new SqlCommand("sp_statewisecodecheck", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@Comp_id", Session["CompanyId"].ToString());
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
    //            XPointMember[count] = ChartData.Rows[count]["State"].ToString();
    //            //storing values for Y Axis  
    //            YPointMember[count] = Convert.ToInt32(ChartData.Rows[count]["Total_Checked_Code"]);

    //        }
    //        //binding chart control  
    //        Chart2.Series[0].Points.DataBindXY(XPointMember, YPointMember);

    //        //Setting width of line  
    //        Chart2.Series[0].BorderWidth = 10;
    //        //setting Chart type   
    //        Chart2.Series[0].ChartType = SeriesChartType.Doughnut;


    //        foreach (Series charts in Chart2.Series)
    //        {
    //            foreach (DataPoint point in charts.Points)
    //            {

    //                switch (point.AxisLabel)
    //                {
    //                    case "Andhra Pradesh": point.Color = Color.RoyalBlue; break;
    //                    case "Arunachal Pradesh": point.Color = Color.GreenYellow; break;
    //                    case "Assam": point.Color = Color.SkyBlue; break;
    //                    case "Bihar": point.Color = Color.Aqua; break;
    //                    case "Chhattisgarh": point.Color = Color.DeepPink; break;
    //                    case "Goa": point.Color = Color.LightCyan; break;
    //                    case "Gujarat": point.Color = Color.LightSeaGreen; break;
    //                    case "Haryana": point.Color = Color.LightSteelBlue; break;
    //                    case "Himachal Pradesh": point.Color = Color.Firebrick; break;
    //                    case "Jharkhand": point.Color = Color.GreenYellow; break;
    //                    case "Karnataka": point.Color = Color.Olive; break;
    //                    case "Kerala": point.Color = Color.AliceBlue; break;
    //                    case "Madhya Pradesh": point.Color = Color.Aquamarine; break;
    //                    case "Maharashtra": point.Color = Color.Orange; break;
    //                    case "Manipur": point.Color = Color.BlanchedAlmond; break;
    //                    case "Meghalaya": point.Color = Color.Chartreuse; break;
    //                    case "Mizoram": point.Color = Color.Coral; break;
    //                    case "Nagaland": point.Color = Color.Cornsilk; break;
    //                    case "Odisha": point.Color = Color.Cyan; break;
    //                    case "Punjab": point.Color = Color.DarkGreen; break;
    //                    case "Rajasthan": point.Color = Color.DarkGoldenrod; break;
    //                    case "Sikkim": point.Color = Color.ForestGreen; break;
    //                    case "Tamil Nadu": point.Color = Color.LightSalmon; break;
    //                    case "Telangana": point.Color = Color.LightSteelBlue; break;
    //                    case "Tripura": point.Color = Color.Khaki; break;
    //                    case "Uttar Pradesh": point.Color = Color.Red; break;
    //                    case "Uttarakhand": point.Color = Color.Beige; break;
    //                    case "West Bengal": point.Color = Color.Ivory; break;
    //                    case "Andaman and Nicobar Island": point.Color = Color.LightSeaGreen; break;
    //                    case "Chandigarh": point.Color = Color.PaleGoldenrod; break;
    //                    case "Dadra and Nagar Haveli and Daman and Diu": point.Color = Color.Goldenrod; break;
    //                    case "Delhi": point.Color = Color.CornflowerBlue; break;
    //                    case "Ladakh": point.Color = Color.MediumSlateBlue; break;
    //                    case "Lakshadweep": point.Color = Color.MediumSeaGreen; break;
    //                    case "Jammu and Kashmir": point.Color = Color.MediumSlateBlue; break;
    //                    case "Puducherry": point.Color = Color.LightGoldenrodYellow; break;
    //                    case "Not Available": point.Color = Color.Red; break;
    //                    case "delhi": point.Color = Color.Chartreuse; break;
    //                    case "newdelhi": point.Color = Color.Coral; break;
    //                    case "Newdelhi": point.Color = Color.DarkGoldenrod; break;
    //                }
    //                point.Label = string.Format("{0:0} - {1}", point.YValues[0], point.AxisLabel);

    //            }
    //        }
    //        //Enabled 3D  
    //        Chart2.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;



    //        Chart2.Legends[0].Enabled = true;
    //        Chart2.Legends[0].Enabled = true;

    //        Chart2.Series[0].ToolTip = "#VALX : #VALY";
    //        Chart2.Series[0]["PieLabelStyle"] = "Disabled";
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

    //private void BindChart3()
    //{
    //    SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
    //    try
    //    {
    //        con.Open();
    //        SqlCommand cmd = new SqlCommand("sp_getusercitywise", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@Comp_id", Session["CompanyId"].ToString());
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
    //            XPointMember[count] = ChartData.Rows[count]["State"].ToString();
    //            //storing values for Y Axis  
    //            YPointMember[count] = Convert.ToInt32(ChartData.Rows[count]["Total_Users"]);

    //        }
    //        //binding chart control  
    //        Chart3.Series[0].Points.DataBindXY(XPointMember, YPointMember);

    //        //Setting width of line  
    //        Chart3.Series[0].BorderWidth = 10;
    //        //setting Chart type   
    //        Chart3.Series[0].ChartType = SeriesChartType.Pie;


    //        foreach (Series charts in Chart3.Series)
    //        {
    //            foreach (DataPoint point in charts.Points)
    //            {
    //                switch (point.AxisLabel)
    //                {
    //                    case "Andhra Pradesh": point.Color = Color.RoyalBlue; break;
    //                    case "Arunachal Pradesh": point.Color = Color.GreenYellow; break;
    //                    case "Assam": point.Color = Color.SkyBlue; break;
    //                    case "Bihar": point.Color = Color.Aqua; break;
    //                    case "Chhattisgarh": point.Color = Color.DeepPink; break;
    //                    case "Goa": point.Color = Color.LightCyan; break;
    //                    case "Gujarat": point.Color = Color.LightSeaGreen; break;
    //                    case "Haryana": point.Color = Color.LightSteelBlue; break;
    //                    case "Himachal Pradesh": point.Color = Color.Firebrick; break;
    //                    case "Jharkhand": point.Color = Color.GreenYellow; break;
    //                    case "Karnataka": point.Color = Color.Olive; break;
    //                    case "Kerala": point.Color = Color.AliceBlue; break;
    //                    case "Madhya Pradesh": point.Color = Color.Aquamarine; break;
    //                    case "Maharashtra": point.Color = Color.Orange; break;
    //                    case "Manipur": point.Color = Color.BlanchedAlmond; break;
    //                    case "Meghalaya": point.Color = Color.Chartreuse; break;
    //                    case "Mizoram": point.Color = Color.Coral; break;
    //                    case "Nagaland": point.Color = Color.Cornsilk; break;
    //                    case "Odisha": point.Color = Color.Cyan; break;
    //                    case "Punjab": point.Color = Color.DarkGreen; break;
    //                    case "Rajasthan": point.Color = Color.DarkGoldenrod; break;
    //                    case "Sikkim": point.Color = Color.ForestGreen; break;
    //                    case "Tamil Nadu": point.Color = Color.LightSalmon; break;
    //                    case "Telangana": point.Color = Color.LightSteelBlue; break;
    //                    case "Tripura": point.Color = Color.Khaki; break;
    //                    case "Uttar Pradesh": point.Color = Color.Lavender; break;
    //                    case "Uttarakhand": point.Color = Color.Beige; break;
    //                    case "West Bengal": point.Color = Color.Ivory; break;
    //                    case "Andaman and Nicobar Island": point.Color = Color.LightSeaGreen; break;
    //                    case "Chandigarh": point.Color = Color.PaleGoldenrod; break;
    //                    case "Dadra and Nagar Haveli and Daman and Diu": point.Color = Color.Goldenrod; break;
    //                    case "Delhi": point.Color = Color.BlueViolet; break;
    //                    case "Ladakh": point.Color = Color.MediumSlateBlue; break;
    //                    case "Lakshadweep": point.Color = Color.MediumSeaGreen; break;
    //                    case "Jammu and Kashmir": point.Color = Color.MediumSlateBlue; break;
    //                    case "Puducherry": point.Color = Color.LightGoldenrodYellow; break;
    //                    case "Not Available": point.Color = Color.Red; break;
    //                    case "delhi": point.Color = Color.Chartreuse; break;
    //                    case "newdelhi": point.Color = Color.Coral; break;
    //                    case "Newdelhi": point.Color = Color.DarkGoldenrod; break;
    //                    case "HP": point.Color = Color.CadetBlue; break;
    //                }
    //                point.Label = string.Format("{0:0} - {1}", point.YValues[0], point.AxisLabel);
    //            }
    //        }
    //        //Enabled 3D  
    //        Chart3.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;
    //        Chart3.Legends[0].Enabled = true;
    //        Chart3.Legends[0].Enabled = true;
    //        Chart3.Series[0].ToolTip = "#VALX : #VALY";
    //        Chart3.Series[0]["PieLabelStyle"] = "Disabled";
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

    //private void Bindchart4()
    //{
    //    SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
    //    try
    //    {
    //        con.Open();
    //        SqlCommand cmd = new SqlCommand("sp_Codedetails_productwise", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@comp_id", Session["CompanyId"].ToString());
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
    //            XPointMember[count] = ChartData.Rows[count]["Pro_Name"].ToString();
    //            //storing values for Y Axis    
    //            YPointMember[count] = Convert.ToInt32(ChartData.Rows[count]["UsedCode"]);
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
    protected void btn_downloadClaimDetailStatus_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("USP_GetClaimDetails_HPL", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@companyid", Session["CompanyId"].ToString());
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "ClaimStatusDetails");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=ClaimStatusDetails.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

    protected void btn_downloadConsumeCode_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("USP_GetCodeStatusDetail_HPL", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@companyid", Session["CompanyId"].ToString());
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "ConsumedCodes");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=ConsumedCodes.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

}