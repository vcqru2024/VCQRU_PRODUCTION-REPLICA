using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Business_Logic_Layer;
using Business9420;
using Newtonsoft.Json.Linq;

public partial class Consumer_Transactions : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {

#region Patanjali logo
if(Session["Comp_id"].ToString() == "Comp-1693")
        {
            Complogo.Src = "https://www.patanjaliayurved.net/media/images/logo.svg";
 Complogo.Style.Add("width", "150px");
claim_list.Visible = false;
        }
#endregion

        Report_message.Visible = false;

        var culture = CultureInfo.CreateSpecificCulture("hi-IN");
        lblcur.Text = culture.NumberFormat.CurrencySymbol;

        //if (Session["Consumer_id"]== null)

        //{
        //    if ((HttpContext.Current.Request.Cookies["ConsumerUserName"].Value != null) && (HttpContext.Current.Request.Cookies["ConsumerPassword"].Value != null))
        //    {
        //        User_Details Log = new User_Details();
        //        Log.User_ID = HttpContext.Current.Request.Cookies["ConsumerUserName"].Value;
        //        Log.DML = "Mobile";
        //        Log.Password = HttpContext.Current.Request.Cookies["ConsumerPassword"].Value.Trim().Replace("'", "''");
        //        DataTable dt = User_Details.GetUserLoginDetails(Log);
        //        Session["USRID"] = dt.Rows[0]["User_ID"].ToString();

        //        Session["User_Type"] = "Consumer";
        //    }
        //    else
        //        {
        //            Response.Redirect("../Login.aspx");
        //        }
        //}


        //if (Session["M_ConsumeriD"] == null)
        //    Response.Redirect("../Login.aspx");

        if (!IsPostBack)
        {

#region JPC Financial year remark 

        if (Session["Comp_id"].ToString() == "Comp-1274")
        {
            JPC_Notes.Visible = true;
        }
        #endregion


            if (Request.QueryString["app"] == "1")
            {
                lblcur.Text = culture.NumberFormat.CurrencySymbol;
                string consumer_id = Request.QueryString["userid"];
                User_Details Log = new User_Details();
                Log.User_Type = "Consumer";
                Log.User_ID = consumer_id;
                //Log.Password = pass.Trim().Replace("'", "''");
                DataTable dt = User_Details.app_GetUserLoginDetails(Log);
                Session["USRID"] = dt.Rows[0]["User_ID"].ToString();
                Session["M_ConsumeriD"] = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
                Session["User_Type"] = "Consumer";
                HttpContext.Current.Session["Consumer_id"] = dt.Rows[0]["m_consumerid"].ToString();
                HttpContext.Current.Session["USRNAME"] = dt.Rows[0]["ConsumerName"].ToString();
                ProjectSession.strConsumerName = dt.Rows[0]["ConsumerName"].ToString();
            }
            else
            {
                if (Session["Consumer_id"] == null)

                {
                    if ((HttpContext.Current.Request.Cookies["ConsumerUserName"].Value != null) && (HttpContext.Current.Request.Cookies["ConsumerPassword"].Value != null))
                    {
                        User_Details Log = new User_Details();
                        Log.User_ID = HttpContext.Current.Request.Cookies["ConsumerUserName"].Value;
                        Log.DML = "Mobile";
                        Log.Password = HttpContext.Current.Request.Cookies["ConsumerPassword"].Value.Trim().Replace("'", "''");
                        DataTable dt = User_Details.GetUserLoginDetails(Log);
                        Session["USRID"] = dt.Rows[0]["User_ID"].ToString();
                        Session["M_ConsumeriD"] = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
                        Session["User_Type"] = "Consumer";
                    }
                    else
                    {
                        Response.Redirect("../Login.aspx");
                    }
                }
            }
            string mahindracounts = ExecuteNonQueryAndDatatable.checkscalarvalues("[checkmahindra]", Convert.ToInt32(Session["M_ConsumeriD"]));
            mmvalue.Value = mahindracounts;
            User_Details Reg = new User_Details();
            Reg.User_ID = Session["USRID"].ToString();
            User_Details.FillUpDateProfile(Reg);
            lblUser_name.Text = Reg.ConsumerName;
            if (File.Exists(Server.MapPath(Reg.Profile_image)))
            {

                top_profile_img.ImageUrl = Reg.Profile_image;

                top_profile_img.DataBind();
                //HtmlControl control = FindControl("top_profile_img") as HtmlControl;
                //control.Attributes["src"] = "../img/Profile/" + Reg.User_ID + ".png";
            }
            else
            {

                top_profile_img.ImageUrl = "../assetsfrui/images/user-profile/user-img.jpg";

                top_profile_img.DataBind();
                //HtmlControl control = FindControl("top_profile_img") as HtmlControl;
                //control.Attributes["src"] = "../assetsfrui/images/user-profile/user-img.jpg";
            }
            if (Request.QueryString["filter"] != null)
            {
                Filtertransaction(Request.QueryString["filter"]);
            }
            else
            {
                Filldtransaction("10");
            }



        }

        //if (Request.QueryString["summary"] != null )
        //{
        //    HtmlControl control1 = FindControl("pan_Summary") as HtmlControl;
        //    control1.Attributes["class"] = "tab-pane active";
        //    control1 = FindControl("pan_history") as HtmlControl;
        //    control1.Attributes["class"] = "tab-pane";
        //    control1 = FindControl("pan_Claim") as HtmlControl;
        //    control1.Attributes["class"] = "tab-pane";
        //    control1 = FindControl("history") as HtmlControl;
        //    control1.Attributes["class"] = "nav-link";
        //    control1 = FindControl("Summary") as HtmlControl;
        //    control1.Attributes["class"] = "nav-link active";
        //    DataSet dtTrans = new DataSet();
        //    if (Request.QueryString["summary"] == null)
        //    {
        //        dtTrans = ExecuteNonQueryAndDatatable.FillSummary("summarylist", Convert.ToInt32(Session["M_ConsumeriD"]), null);
        //    }
        //    else
        //    {
        //        dtTrans = ExecuteNonQueryAndDatatable.FillSummary("summarylist", Convert.ToInt32(Session["M_ConsumeriD"]), Request.QueryString["summary"]);
        //    }

        //    DataTable dtmsg = SQL_DB.ExecuteDataTable("select * from [Summary_msg]");
        //    DataTable smr = new DataTable();
        //    smr.Columns.Add("smry");
        //    smr.Columns.Add("Comp_id");
        //    DataView view = new DataView(dtTrans.Tables[0]);
        //    DataTable distinctValues = view.ToTable(true, "Comp_id");
        //    foreach (DataRow item in distinctValues.Rows)
        //    {
        //        DataRow[] msgrows = dtTrans.Tables[0].Select("Comp_id='" + item[0].ToString() + "'");
        //        bool flag = false;
        //        DataRow dr = smr.NewRow();
        //        for (int i = 0; i < msgrows.Length; i++)
        //        {


        //            if (msgrows[i][0].ToString() == "0" || msgrows[i][0].ToString() == "")
        //            { }
        //            else
        //            {

        //                DataRow[] drr = dtmsg.Select("[Service_id]='" + msgrows[i][1].ToString() + "'");
        //                dr[0] = dr[0] + drr[0][2].ToString().Replace("<count>", msgrows[i][0].ToString()) + "<br>";
        //                dr[1] = msgrows[i][2].ToString();
        //                flag = true;

        //            }

        //        }
        //        if (flag)
        //        {

        //            smr.Rows.Add(dr);
        //        }
        //    }


        //    if (smr.Rows.Count == 0)
        //    {
        //        DataRow dr = smr.NewRow();

        //        dr[0] = "Sorry! no Record Found.";
        //        smr.Rows.Add(dr);
        //    }

        //}

        if (Session["Comp_id"].ToString() == "Comp-1388")
        {
            logo.Visible = false;

        }

        if (Session["Comp_id"].ToString() == "Comp-1434")
        {
            term.Visible = true;
        }
        //Hypersonic
        if (Session["Comp_id"].ToString() == "Comp-1629")
        {
            Claim.Visible = false;
        }
        //Hypersonic


    }
    private void Filtertransaction(string filter)
    {

        DataSet dtTrans = ExecuteNonQueryAndDatatable.FilterTransactions("filtertransaction10", Convert.ToInt32(Session["M_ConsumeriD"]), filter);
        if (dtTrans.Tables[0].Rows.Count > 0)
        {
            //ServiceLogic.Paytm_Status();
            Repeater1.DataSource = dtTrans;
            Repeater1.DataBind();
        }




    }
    private void fullFiltertransaction(string filter)
    {

        DataSet dtTrans = ExecuteNonQueryAndDatatable.FilterTransactions("filtertransaction", Convert.ToInt32(Session["M_ConsumeriD"]), filter);
        if (dtTrans.Tables[0].Rows.Count > 0)
        {
            Repeater1.DataSource = dtTrans;
            Repeater1.DataBind();
        }




    }
    private void Filldtransaction(string size)
    {
        if (size == "Full")
        {
            DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("Gettransactionlist", Convert.ToInt32(Session["M_ConsumeriD"]));
            if (dtTrans.Tables[0].Rows.Count > 0)
            {
                Repeater1.DataSource = dtTrans;
                Repeater1.DataBind();
            }
        }
        else
        {
            DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("Gettransactionlist10", Convert.ToInt32(Session["M_ConsumeriD"]));
            if (dtTrans.Tables[0].Rows.Count > 0)
            {
                Repeater1.DataSource = dtTrans;
                Repeater1.DataBind();
            }
        }


    }
    protected void Logout(object sender, EventArgs e)
    {
        Session.Abandon();
        //Response.Redirect("../Home/Index.aspx");
        string val = Session["AppID"].ToString();
        if (val == "2")
        {
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "AppLogin.aspx?AppID=2");
        }

        else if (Session["Comp_id"].ToString() == "Comp-1388")
        {
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "AppLogin.aspx");
        }

        else
        {
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "login.aspx");
        }


    }

    private void claim(int point, string item)
    {
        //int totalpoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum([Points]) is null then 0 else Sum([Points]) end as point FROM [BLoyaltyPointsEarned] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[M_Consumerid] where mc.[User_ID]='" + Session["USRID"].ToString() + "'"));
        DataTable dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,sum(isnull(bl.points, 0)) point,cl.p_cash from dbo.[BLoyaltyPointsEarned] bl inner join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id inner join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id inner join dbo.claimredeem cl on cl.compid=mss.Comp_ID where mss.Comp_ID='Comp-1203' and bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + Session["USRID"].ToString() + "') group by mss.Comp_ID,cl.p_cash");

        int totalpoint = Convert.ToInt32(dtcp.Rows[0]["point"].ToString());
        int redeempoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(bl.[RedeemPoints]) is null then 0 else Sum(bl.[RedeemPoints]) end FROM [BPointsTransaction] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[RedeemBy] where mc.[User_ID]='" + Session["USRID"].ToString() + "' and (bl.bpstatus is null or bl.bpstatus<>'FAILURE')"));
        float totalpointrt = Convert.ToInt32(dtcp.Rows[0]["p_cash"].ToString());
        int tp = totalpoint - redeempoint;

        string msg = "";

        if (tp >= point)
        {
            SQL_DB.ExecuteNonQuery("insert into BPointsTransaction([Transsctionid],[TotalPoints],[RedeemPoints],[Redeemdate],[RedeemBy]) values(1," + tp + "," + point + "," + System.DateTime.UtcNow.ToString("yyyy-MM-dd") + "," + Session["M_ConsumeriD"] + ")");
            msg = "Your request registered with us for " + item;
            Response.Write("<script langauge=\"javascript\">alert('" + msg + "');</script>");

        }
        else
        {
            msg = "You are not eligible for this item kindly try with another.";
            Response.Write("<script langauge=\"javascript\">alert('" + msg + "');</script>");
        }

    }

    protected void Unnamed_Click(object sender, EventArgs e)
    {
        claim(50000, "Vensel LED");
    }

    protected void Unnamed_Click1(object sender, EventArgs e)
    {
        claim(21000, "Casio Watch");
    }

    protected void Unnamed_Click2(object sender, EventArgs e)
    {
        claim(15000, "JBL Headphone");
    }

    protected void Unnamed_Click3(object sender, EventArgs e)
    {
        claim(7000, "JBL Speaker");
    }

    protected void Unnamed_Click4(object sender, EventArgs e)
    {
        claim(2000, "Parker Pen");
    }

    protected void btnreport_Click(object sender, EventArgs e)
    {
        string code = code_value.Value;
        if (Report.Text == "")
        {
            Report_message.Visible = true;
            Report_message.Attributes["class"] = "alert alert-danger";
            Report_message.InnerHtml = "<strong>Warning</Strong>    Enter a valid Issue.";

        }
        else
        {
            int issuescount = Convert.ToInt32(SQL_DB.ExecuteScalar("select count([Useid]) from user_issue where [Useid]='" + Session["USRID"].ToString() + "' and [Code]=" + code + " and [status]=0"));
            if (issuescount == 0)
            {
                SQL_DB.ExecuteNonQuery("insert into user_issue values('" + Session["USRID"].ToString() + "','" + Report.Text + "','" + System.DateTime.Now.ToString("MM-dd-yyyy HH: mm:ss") + "'," + code + ",0)");

                Report_message.Visible = true;
                Report_message.Attributes["class"] = "alert alert-success";
                Report_message.InnerHtml = "Query has been submitted successfully! , our representative will connect with you shortly";
            }
            else
            {
                Report_message.Visible = true;
                Report_message.Attributes["class"] = "alert alert-danger";
                Report_message.InnerHtml = " Our Team is Working on this! , our representative will connect with you shortly";
            }

        }
        Report.Text = "";
    }
    DataTable distinctValues;
    DataSet dtTrans = new DataSet();
    protected void call_Summary_Click(object sender, EventArgs e)
    {
        // DataTable year = SQL_DB.ExecuteDataTable("SELECT distinct year([Enq_Date]) as dateyear  FROM [Pro_Enq] pe inner join m_consumer mc on mc.mobileno=pe.mobileno where mc.m_consumerid=" + Session["M_ConsumeriD"]+ " order by dateyear desc");
        // //ddpYear.DataSource = year;
        // //ddpYear.DataTextField = "dateyear";
        // //ddpYear.DataBind();
        //       dtTrans = ExecuteNonQueryAndDatatable.FillSummary("service_summary", Convert.ToInt32(Session["M_ConsumeriD"]), null);

        // string[] x = new string[dtTrans.Tables[0].Rows.Count];
        // int[] y = new int[dtTrans.Tables[0].Rows.Count];
        // for (int i = 0; i < dtTrans.Tables[0].Rows.Count; i++)
        // {
        //     x[i] = dtTrans.Tables[0].Rows[i][0].ToString();
        //     y[i] = Convert.ToInt32(dtTrans.Tables[0].Rows[i][1]);

        // }

        // chartService_code.Series[0].Points.DataBindXY(x, y);
        // chartService_code.Series[0].ChartType = SeriesChartType.Pie;
        // for (int cnt = 0; cnt < chartService_code.Series[0].Points.Count; cnt++)
        // {
        //     chartService_code.Series[0].Points[cnt].ToolTip = "Total Code scan For " + dtTrans.Tables[0].Rows[cnt][0].ToString() + ": " + dtTrans.Tables[0].Rows[cnt][1].ToString();
        // }
        // chartService_code.Series[0].IsValueShownAsLabel = true;
        // chartService_code.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;

        // dtTrans = ExecuteNonQueryAndDatatable.FillSummary("loyalty_summary", Convert.ToInt32(Session["M_ConsumeriD"]), null);

        //  x = new string[dtTrans.Tables[0].Rows.Count];
        //  y = new int[dtTrans.Tables[0].Rows.Count];
        // for (int i = 0; i < dtTrans.Tables[0].Rows.Count; i++)
        // {
        //     x[i] = dtTrans.Tables[0].Rows[i][0].ToString();
        //     y[i] = Convert.ToInt32(dtTrans.Tables[0].Rows[i][1]);

        // }

        // Chartloyalty_won.Series[0].Points.DataBindXY(x, y);
        // Chartloyalty_won.Series[0].ChartType = SeriesChartType.Doughnut;
        //for (int cnt = 0; cnt < Chartloyalty_won.Series[0].Points.Count; cnt++)
        //     {
        //     Chartloyalty_won.Series[0].Points[cnt].ToolTip ="Loyalty Won "+dtTrans.Tables[0].Rows[cnt]["curreny"].ToString()+" "+dtTrans.Tables[0].Rows[cnt]["cash"].ToString();
        // }
        // Chartloyalty_won.Series[0].IsValueShownAsLabel = true;
        // Chartloyalty_won.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;

        // dtTrans = ExecuteNonQueryAndDatatable.FillSummary("company_code_summary", Convert.ToInt32(Session["M_ConsumeriD"]), null);

        // x = new string[dtTrans.Tables[0].Rows.Count];
        // y = new int[dtTrans.Tables[0].Rows.Count];
        // for (int i = 0; i < dtTrans.Tables[0].Rows.Count; i++)
        // {
        //     x[i] = dtTrans.Tables[0].Rows[i][0].ToString();
        //     y[i] = Convert.ToInt32(dtTrans.Tables[0].Rows[i][1]);

        // }

        // ChartCompany_code.Series[0].Points.DataBindXY(x, y);
        // ChartCompany_code.Series[0].ChartType = SeriesChartType.Doughnut;
        // ChartCompany_code.Series[0].IsValueShownAsLabel = true;
        // ChartCompany_code.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;

        // dtTrans = ExecuteNonQueryAndDatatable.FillSummary("code_summary", Convert.ToInt32(Session["M_ConsumeriD"]), null);

        // x = new string[dtTrans.Tables[0].Rows.Count];
        // y = new int[dtTrans.Tables[0].Rows.Count];
        // for (int i = 0; i < dtTrans.Tables[0].Rows.Count; i++)
        // {
        //     x[i] = dtTrans.Tables[0].Rows[i][0].ToString();
        //     y[i] = Convert.ToInt32(dtTrans.Tables[0].Rows[i][1]);

        // }

        // Chartcode.Series[0].Points.DataBindXY(x, y);
        // Chartcode.Series[0].ChartType = SeriesChartType.Pie;
        // Chartcode.Series[0].IsValueShownAsLabel = true;
        // Chartcode.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;


        //    dtTrans = ExecuteNonQueryAndDatatable.FillyearSummary("yearly_summary", Convert.ToInt32(Session["M_ConsumeriD"]), ddpYear.Text);

        //x = new string[dtTrans.Tables[0].Rows.Count];
        //y = new int[dtTrans.Tables[0].Rows.Count];
        //for (int i = 0; i < dtTrans.Tables[0].Rows.Count; i++)
        //{
        //    x[i] = dtTrans.Tables[0].Rows[i][0].ToString();
        //    y[i] = Convert.ToInt32(dtTrans.Tables[0].Rows[i][1]);

        //}

        //Chartyearlycode.Series[0].Points.DataBindXY(x, y);
        //Chartyearlycode.Series[0].ChartType = SeriesChartType.Line;
        //Chartyearlycode.Series[0].IsValueShownAsLabel = true;
        //Chartyearlycode.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
        //Chartyearlycode.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;
        //Chartyearlycode.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = false;

        dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("[company_service]", Convert.ToInt32(Session["M_ConsumeriD"]));
        if (dtTrans.Tables[0].Rows.Count > 0)
        {
            No_record.Visible = false;
            Chartyearlycode.Visible = true;
            //x = new string[dtTrans.Tables[0].Rows.Count];
            //y = new int[dtTrans.Tables[0].Rows.Count];
            //for (int i = 0; i < dtTrans.Tables[0].Rows.Count; i++)
            //{
            //    x[i] = dtTrans.Tables[0].Rows[i][0].ToString();
            //    y[i] = Convert.ToInt32(dtTrans.Tables[0].Rows[i][1]);

            //}
            if (Convert.ToInt32(page_width.Value) < 400)
            {
                Chartyearlycode.Width = 300;
                Chartyearlycode.Height = 450;
            }
            else
            {

                Chartyearlycode.Width = 650;
                Chartyearlycode.Height = 300;
            }
            Chartyearlycode.DataBindCrossTable(dtTrans.Tables[0].DefaultView, "ServiceName", "comp_name", "codes", "label=Loyalty");
            foreach (Series cs in Chartyearlycode.Series)
            {
                Chartyearlycode.Series[cs.Name].ToolTip = "Code Scanned: #VALY";
                cs.ChartType = SeriesChartType.Column;
            }
            //Chartyearlycode.Series[0].Points.DataBindXY(x, y);
            //Chartyearlycode.Series[0].ChartType = SeriesChartType.Line;
            Chartyearlycode.Series[0].IsValueShownAsLabel = true;
            Chartyearlycode.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
            Chartyearlycode.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;
            Chartyearlycode.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = false;
        }
        else
        {
            No_record.Visible = true;
            Chartyearlycode.Visible = false;
        }
    }

    protected void Transactionload_Click5(object sender, EventArgs e)
    {
        if (Request.QueryString["filter"] != null)
        {
            if (Transactionload.Text == "View Less")
            {
                Filtertransaction(Request.QueryString["filter"]);
                Transactionload.Text = "View More";
            }
            else
            {
                fullFiltertransaction(Request.QueryString["filter"]);
                Transactionload.Text = "View Less";
            }

        }
        else
        {
            if (Transactionload.Text == "View Less")
            {
                Filldtransaction("10");
                Transactionload.Text = "View More";
            }
            else
            {
                Filldtransaction("Full");
                Transactionload.Text = "View Less";
            }
        }
    }



    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView row = e.Item.DataItem as DataRowView;
            Label claim = e.Item.FindControl("claimbutton") as Label;
            Label claimstatus = e.Item.FindControl("claimstatus") as Label;
            Label serviceid = e.Item.FindControl("serviceid") as Label;
            Label tr_status = e.Item.FindControl("tr_status") as Label;
            Label numberofdays = e.Item.FindControl("numberofdays") as Label;
            Label tr_message = e.Item.FindControl("tr_message") as Label;
            HtmlGenericControl company_amt = e.Item.FindControl("company_amt") as HtmlGenericControl;
            HtmlGenericControl logo1 = e.Item.FindControl("logo1") as HtmlGenericControl;
            if (tr_status.Text == "Success" && serviceid.Text == "SRV1023" && claimstatus.Text == "False")
            {
                claim.Visible = true;

                company_amt.Style.Add("Display", "none");

            }
            else
            {
                claim.Visible = false;
                company_amt.Style.Remove("Display");
            }

            if (Session["Comp_id"].ToString() == "Comp-1388")
            {

                logo1.Style.Add("Display", "none");
            }

        }
    }

    protected void btnshowclm_Click(object sender, EventArgs e)

    {
        showclaim();


    }
    public void showclaim()
    {
        if (Session["Comp_id"].ToString() == "Comp-1400" || Session["Comp_id"].ToString() == "Comp-1531" || Session["Comp_id"].ToString() == "Comp-1532")
        {
            paytm.Visible = false;
            btnptmp.Visible = false;
        }
        else
        {
            try

            {
                int totalpoint = 0;
                DataTable dtcp = null;
                int tp = 0;
                if (dtcp != null)

                {

                    dtcp.Rows.Clear();

                }


                string loyalty_return = SQL_DB.ExecuteScalar("select isnull(sum(loyalty),0) from scrap_entry se inner join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2 inner join m_consumer ms on ms.MobileNo=pe.MobileNo where pe.is_success=1 and  ms.M_Consumerid= " + Session["M_ConsumeriD"]).ToString();

                //DataTable dt = SQL_DB.ExecuteDataTable("select distinct cr.Comp_Name from dbo.[M_consumer] mc inner join dbo.pro_enq pe on pe.mobileno = mc.mobileno inner join dbo.M_code mcod on pe.Received_Code1 = mcod.code1 and pe.Received_Code2 = mcod.code2 inner join dbo.pro_reg pr on mcod.pro_ID = pr.Pro_ID inner join dbo.comp_reg cr on pr.Comp_ID = cr.Comp_ID where cr.Comp_ID = 'Comp-1230' and mc.[User_ID]='" + Session["USRID"].ToString() + "'");

                //dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,cl.p_cash from dbo.[BLoyaltyPointsEarned] bl inner join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id inner join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id inner join dbo.claimredeem cl on cl.compid=mss.Comp_ID where mss.Comp_ID='Comp-1203' and bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + Session["USRID"].ToString() + "') group by mss.Comp_ID,cl.p_cash");

                dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash ,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where  bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + Session["USRID"].ToString() + "') group by mss.Comp_ID,cl.p_cash");

                if (dtcp.Rows.Count > 0)

                {

                    int loyaltybonus = 0;

                    //int totalpoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum([Points]) is null then 0 else Sum([Points]) end as point FROM [BLoyaltyPointsEarned] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[M_Consumerid] where mc.[User_ID]='" + Session["USRID"].ToString() + "'"));

                    if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1278" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1285" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1375" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1438")

                    {
                        loyaltybonus = Convert.ToInt32(SQL_DB.ExecuteScalar("select isnull(sum(points),0) as points from buildloyalty_offers where m_consumerid=" + Session["M_ConsumeriD"]).ToString());

                    }

                    totalpoint = (Convert.ToInt32(dtcp.Rows[0]["point"].ToString()) - Convert.ToInt32(loyalty_return)) + loyaltybonus;

                    int redeempoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(bl.[RedeemPoints]) is null then 0 else Sum(isnull(bl.[RedeemPoints],0)) end FROM [BPointsTransaction] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[RedeemBy] where mc.[User_ID]='" + Session["USRID"].ToString() + "' and (bl.bpstatus is null or bl.bpstatus<>'FAILURE')"));


                    //int claimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [ClaimDetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.[User_ID]='" + Session["USRID"].ToString() + "' and (cl.Isapproved=1)"));
                    int claimapply = 0;
                    //if(dtcp.Rows[0]["Comp_ID"].ToString() != "Comp-1375")----- 220323 Bipin
                    claimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [ClaimDetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.[User_ID]='" + Session["USRID"].ToString() + "' and (cl.Isapproved=1 )"));


                    float totalpointrt = Convert.ToInt32(dtcp.Rows[0]["p_cash"].ToString());

                    #region UPI Claim process

                    if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1466" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1548" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1709" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1673" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1702")
                    {
                        int Upiclaimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [tblupitransactiondetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.[User_ID]='" + Session["USRID"].ToString() + "' and (cl.status='Success')"));
                        claimapply = Upiclaimapply;
                    }

                    #endregion

                    DataTable dtcondition = SQL_DB.ExecuteDataTable("select top 1 codition_point,condition_match from point_redeem_condition where comp_id='" + dtcp.Rows[0]["Comp_ID"].ToString() + "' and isactive=1 and selection_id=case when (select count(*) from paytmtransaction where m_consumerid='" + Session["M_ConsumeriD"] + "' and comp_id='Comp-1283')>0 then 2 else 1 end ");



                    if (dtcondition.Rows.Count > 0)
                    {

                        tp = totalpoint - redeempoint - claimapply;

                        int rp = 0;

                        if (dtcondition.Rows[0]["condition_match"].ToString() == "1")

                        {

                            rp = tp % Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString());
                            rp = tp - rp;
                        }

                        else

                        {

                            if (tp >= Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))

                            {

                                rp = tp;

                            }

                        }

                        int ptforrd = rp;

                        //int ptforrd = tp - rp;

                        float tpr = ptforrd * totalpointrt;

                        //float tpr = tp * totalpointrt;

                        if (tp >= 0)

                        {

                            // if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1350")
                            //     {
                            //  if (Convert.ToDecimal(tp) >= 100 && Convert.ToDecimal(tp) < 200)
                            //  {
                            //  lblptmp.Text = "100";
                            //  }
                            // else if (Convert.ToDecimal(tp) >= 200 && Convert.ToDecimal(tp) < 500)
                            //  {
                            //  lblptmp.Text = "230";
                            // }
                            // else if (Convert.ToDecimal(tp) >= 500)
                            // {
                            //  lblptmp.Text = "600";
                            // }
                            // }

                            if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1412")
                            {
                                if (Convert.ToDecimal(tp) >= 5 && Convert.ToDecimal(tp) < 10)
                                {
                                    lblptmp.Text = "12";
                                }
                                else if (Convert.ToDecimal(tp) >= 10 && Convert.ToDecimal(tp) < 20)
                                {
                                    lblptmp.Text = "30";
                                }
                                else if (Convert.ToDecimal(tp) >= 20 && Convert.ToDecimal(tp) < 50)
                                {
                                    lblptmp.Text = "65";
                                }
                                else if (Convert.ToDecimal(tp) >= 50 && Convert.ToDecimal(tp) < 100)
                                {
                                    lblptmp.Text = "175";
                                }
                                else if (Convert.ToDecimal(tp) >= 100)
                                {
                                    lblptmp.Text = "400";
                                }
                            }

                            else if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1483")
                            {
                                if (Convert.ToDecimal(tp) >= 200)
                                {
                                    lblptmp.Text = tp.ToString();
                                }
                            }
                            else if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1659")  //Comp-1483
                            {
                                if (Convert.ToDecimal(tp) >= 500)
                                {
                                    lblptmp.Text = tp.ToString();
                                }
                            }
                            else if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1674")
                            {
                                if (Convert.ToDecimal(tp) >= 1000)
                                {
                                    lblptmp.Text = "1000";
                                }
                            }


                            #region // For claim process By Bipin Ji
                            else if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1434")
                            {
                                if (Convert.ToDecimal(tp) >= 1000 && Convert.ToDecimal(tp) < 2000)
                                {
                                    lblptmp.Text = "1000";
                                }
                                else if (Convert.ToDecimal(tp) >= 2000 && Convert.ToDecimal(tp) < 5000)
                                {
                                    lblptmp.Text = "2000";
                                }
                                else if (Convert.ToDecimal(tp) >= 5000 && Convert.ToDecimal(tp) < 10000)
                                {
                                    lblptmp.Text = "5000";
                                }
                                else if (Convert.ToDecimal(tp) >= 10000 && Convert.ToDecimal(tp) < 20000)
                                {
                                    lblptmp.Text = "10000";
                                }
                                else if (Convert.ToDecimal(tp) >= 20000 && Convert.ToDecimal(tp) < 30000)
                                {
                                    lblptmp.Text = "20000";
                                }
                                else if (Convert.ToDecimal(tp) >= 30000 && Convert.ToDecimal(tp) < 50000)
                                {
                                    lblptmp.Text = "30000";
                                }
                                else if (Convert.ToDecimal(tp) >= 50000 && Convert.ToDecimal(tp) < 70000)
                                {
                                    lblptmp.Text = "50000";
                                }
                                else if (Convert.ToDecimal(tp) >= 70000 && Convert.ToDecimal(tp) < 80000)
                                {
                                    lblptmp.Text = "70000";
                                }
                                else if (Convert.ToDecimal(tp) >= 80000 && Convert.ToDecimal(tp) < 90000)
                                {
                                    lblptmp.Text = "80000";
                                }
                                else if (Convert.ToDecimal(tp) >= 90000 && Convert.ToDecimal(tp) < 100000)
                                {
                                    lblptmp.Text = "90000";
                                }
                                else if (Convert.ToDecimal(tp) >= 100000 && Convert.ToDecimal(tp) < 200000)
                                {
                                    lblptmp.Text = "100000";
                                }
                                else if (Convert.ToDecimal(tp) >= 200000 && Convert.ToDecimal(tp) < 300000)
                                {
                                    lblptmp.Text = "200000";
                                }
                                else if (Convert.ToDecimal(tp) >= 300000 && Convert.ToDecimal(tp) < 400000)
                                {
                                    lblptmp.Text = "300000";
                                }
                                else if (Convert.ToDecimal(tp) >= 400000 && Convert.ToDecimal(tp) < 500000)
                                {
                                    lblptmp.Text = "400000";
                                }
                                else if (Convert.ToDecimal(tp) >= 500000 && Convert.ToDecimal(tp) < 600000)
                                {
                                    lblptmp.Text = "500000";
                                }
                                else if (Convert.ToDecimal(tp) >= 600000 && Convert.ToDecimal(tp) < 700000)
                                {
                                    lblptmp.Text = "600000";
                                }

                            }

                            #endregion

                            else if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1438")  //Comp-1483
                            {

                                if (Convert.ToDecimal(tp) >= 10)
                                {
                                    lblptmp.Text = tp.ToString();
                                }
                            }


                            else
                            {
                                lblptmp.Text = tp.ToString();
                            }


                            if (tp >= Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))

                            {
                                totalpoints.Value = tp.ToString();
                                lbltp.Text = tp.ToString();

                                lblrp.Text = ptforrd.ToString();

                                hcc.Value = dtcp.Rows[0]["Comp_ID"].ToString();

                                lblptmm.Visible = false;

                                btnptmp.Visible = true;

                            }

                            else

                            {

                                if (tp < Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))

                                {

                                    tpr = tp * totalpointrt;

                                    lblptmp.Text = tpr.ToString();

                                    int reqp = Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()) - tp;

                                    lblptmm.Text = "Collect " + reqp + " more points to redeem cash.";

                                    lblptmm.Visible = true;

                                }

                                btnptmp.Visible = false;
                            }

                        }

                        else

                        {

                            if (tp < 0)

                                lblptmp.Text = tpr.ToString();

                            int reqp = Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()) - tp;

                            lblptmm.Text = "Collect " + reqp + " more points to redeem cash.";

                            lblptmm.Visible = true;



                            btnptmp.Visible = false;

                        }



                    }

                }

                else

                {

                    lblptmp.Text = "0";

                    lblptmm.Text = "You are not eligible for claim.";

                    lblptmm.Visible = true;

                    btnptmp.Visible = false;



                }

                /////////////////////////////////////user dashboard claim item//////////////////////////
                ///

                DataTable dt = new DataTable();
                dt = SQL_DB.ExecuteDataTable("select top 1 [user_id],M_Consumerid,UPIId from m_consumer where M_Consumerid=" + Session["M_ConsumeriD"].ToString());

                string UPIId = dt.Rows[0]["UPIId"].ToString();

                DataTable dtcp1 = null;
                if (dtcp1 != null)
                {
                    dtcp1.Rows.Clear();
                }


                dtcp1 = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where  bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + dt.Rows[0][0].ToString() + "') group by mss.Comp_ID,cl.p_cash");

                DataTable table = new DataTable();
                // where [gift_id]=4
                if (dtcp1.Rows.Count > 0)
                {
                    if (dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1466" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1548" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1709" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1708" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1673" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1702" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1483" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1278" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1285" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1375" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1434" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1550" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1350" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1466")
                    {
                        paytm.Visible = false;


                        if (dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1466" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1548" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1709" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1708" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1483" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1285" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1375" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1434" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1550" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1350" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1466")
                        {
                            table = SQL_DB.ExecuteDataTable("select [gift_id],[Gift_name],[Gift_value] ,[Gift_desc],[Gift_image] from Claim_gift where [status]=1 and gift_id<>20 and CompID='" + dtcp1.Rows[0]["Comp_ID"].ToString() + "' order by [Gift_value]");
                        }
                        else if (dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1673" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1702")
                        {
                            table = SQL_DB.ExecuteDataTable("select [gift_id],[Gift_name],[Gift_value] ,[Gift_desc],[Gift_image] from Claim_gift where [status]=1 and  CompID='" + dtcp1.Rows[0]["Comp_ID"].ToString() + "' order by [Gift_value]");
                        }
                        else
                        {
                            table = SQL_DB.ExecuteDataTable("select [gift_id],[Gift_name],[Gift_value] ,[Gift_desc],[Gift_image] from Claim_gift where [status]=1 and gift_id<>20 and CompID is null order by [Gift_value]");
                        }


                        table.Columns.Add("gift_message");
                        table.Columns.Add("btn_flag", typeof(Int32));
                        table.Columns.Add("Comp_id");
                        table.Columns["gift_message"].ReadOnly = false;
                        table.Columns["btn_flag"].ReadOnly = false;
                        table.Columns["Gift_value"].ReadOnly = false;

                        #region //** Lubigen
                        if ((dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1483"))
                        {
                            for (int i = 0; i < table.Rows.Count; i++)
                            {
                                if (Convert.ToInt32(table.Rows[i]["Gift_value"].ToString()) > tp)
                                {
                                    table.Rows[i]["gift_message"] = "You don't have enough points to claim this product.";
                                    table.Rows[i]["btn_flag"] = 0;
                                    table.Rows[i]["Gift_image"] = "../" + table.Rows[i]["Gift_image"];
                                }
                                else
                                {
                                    table.Rows[i]["btn_flag"] = 1;
                                    table.Rows[i]["Gift_image"] = "../" + table.Rows[i]["Gift_image"];
                                }
                            }
                        }
                        #endregion
                        #region Mahaver paint
                        else if ((dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1709"))
                        {
                            for (int i = 0; i < table.Rows.Count; i++)
                            {
                                if (Convert.ToInt32(table.Rows[i]["Gift_value"].ToString()) > tp)
                                {
                                    table.Rows[i]["gift_message"] = "You don't have enough points to claim this product.";
                                    table.Rows[i]["btn_flag"] = 0;
                                    table.Rows[i]["Gift_image"] = "../" + table.Rows[i]["Gift_image"];
                                    table.Rows[i]["Gift_value"] = tp;
                                    table.Rows[i]["Gift_name"] = "₹ " + tp * 10;
                                }
                                else
                                {
                                    table.Rows[i]["btn_flag"] = 1;
                                    table.Rows[i]["Gift_image"] = "../" + table.Rows[i]["Gift_image"];
                                    table.Rows[i]["Gift_value"] = tp;
                                    table.Rows[i]["Gift_name"] = "₹ " + tp * 10;
                                }
                            }
                        }
                        #endregion
                       
                        #region UPI Claim process
                        else if (dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1548" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1673" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1702")
                        {
                            for (int i = 0; i < table.Rows.Count; i++)
                            {
                                if (tp <= 0)
                                {
                                    table.Rows[i]["gift_message"] = "You don't have enough points to claim this product.";
                                    table.Rows[i]["btn_flag"] = 0;
                                    table.Rows[i]["Gift_image"] = "../" + table.Rows[i]["Gift_image"];
                                    table.Rows[i]["Gift_value"] = tp;
                                    table.Rows[i]["Gift_name"] = "₹ " + tp;
                                }
                                else
                                {
				
                                    table.Rows[i]["btn_flag"] = 1;
                                    table.Rows[i]["Gift_image"] = "../" + table.Rows[i]["Gift_image"];
                                    table.Rows[i]["Gift_value"] = tp;
                                    table.Rows[i]["Gift_name"] = "₹ " + tp;
                                }
                            }
                        }
                        #endregion

                        else
                        {
			                for (int i = 0; i < table.Rows.Count; i++)
                            {
                                if (Convert.ToInt32(table.Rows[i]["Gift_value"].ToString()) > tp)
                                {
                                    table.Rows[i]["gift_message"] = "You are not eligible for claim.";
                                    table.Rows[i]["btn_flag"] = 0;
                                    table.Rows[i]["Gift_image"] = "../" + table.Rows[i]["Gift_image"];
                                }
                                else
                                {
                                    table.Rows[i]["btn_flag"] = 1;
                                    table.Rows[i]["Gift_image"] = "../" + table.Rows[i]["Gift_image"];
                                }
                            }
			            }

                        
                    }
                    else
                    {
                        #region Added by Bipin for GCI Paint
                        if (dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1438" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1659" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1674")
                        {
                            paytm.Visible = true;
                        }
                        #endregion

                        else if (dtcp1.Rows[0]["Comp_ID"].ToString() != "Comp-1321")
                        {
                            paytm.Visible = true;
                        }
                        else
                        {
                            paytm.Visible = false;
                        }

                    }
                    Repeater2.DataSource = table;
                    Repeater2.DataBind();

                    #region //** Lubigen
                    if ((dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1483"))
                    {
                        for (int i = 0; i < table.Rows.Count; i++)
                        {

                            if (table.Rows[i]["btn_flag"].ToString() == "1")
                            {

                                Control div2 = Repeater2.Items[i].FindControl("btnpointClaim");
                                Control DivPointClaim = Repeater2.Items[i].FindControl("DivPointClaim_UPI");
                                TextBox txtUpiId_UPI = (TextBox)Repeater2.Items[i].FindControl("txtUpiId_UPI");
                                txtUpiId_UPI.Text = UPIId;
                                txtUpiId_UPI.ReadOnly = false;
                                div2.Visible = true;
                                DivPointClaim.Visible = true;

                                //Control div2 = Repeater2.Items[i].FindControl("btnpointClaim");
                                //Control DivPointClaim = Repeater2.Items[i].FindControl("DivPointClaim");
                                ////Control DivPointClaimMobile = Repeater2.Items[i].FindControl("DivPointClaimMobile");
                                //Control DivPointClaimMobile = Repeater2.Items[i].FindControl("DivPointClaimUpi");
                                //TextBox txtUpiId_UPI = (TextBox)Repeater2.Items[i].FindControl("txtUpiId");  // tej
                                //txtUpiId_UPI.Text = UPIId;  // tej
                                //div2.Visible = true;
                                //DivPointClaim.Visible = false;
                                //DivPointClaimMobile.Visible = false;

                            }


                        }
                    }
                    #endregion

                   

                    #region UPI claim process

                    else if (dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1466" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1548" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1709" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1673" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1702")
                    {
                        for (int i = 0; i < table.Rows.Count; i++)
                        {

                            if (table.Rows[i]["btn_flag"].ToString() == "1")
                            {

                                Control div2 = Repeater2.Items[i].FindControl("btnpointClaim_UPI");
                                Control DivPointClaim = Repeater2.Items[i].FindControl("DivPointClaim_UPI");
                                TextBox txtUpiId_UPI = (TextBox)Repeater2.Items[i].FindControl("txtUpiId_UPI");
                                txtUpiId_UPI.Text = UPIId;
                                txtUpiId_UPI.ReadOnly = true;
                                div2.Visible = true;
                                DivPointClaim.Visible = true;
                                if (dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1702" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1466" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1709" || dtcp1.Rows[0]["Comp_ID"].ToString() == "Comp-1548")
                                {
                                    txtUpiId_UPI.ReadOnly = false;
                                }


                            }
                            else
                            {
                                Control div2 = Repeater2.Items[i].FindControl("btnpointClaim_UPI");
                                Control DivPointClaim = Repeater2.Items[i].FindControl("DivPointClaim_UPI");
                                TextBox txtUpiId_UPI = (TextBox)Repeater2.Items[i].FindControl("txtUpiId_UPI");
                                txtUpiId_UPI.Text = UPIId;
                                txtUpiId_UPI.ReadOnly = true;
                                div2.Visible = false;
                                DivPointClaim.Visible = false;
                            }


                        }
                    }
                    #endregion

                    else
                    {
			 for (int i = 0; i < table.Rows.Count; i++)
                    {

                        if (table.Rows[i]["btn_flag"].ToString() == "1")
                        {

                            Control div2 = Repeater2.Items[i].FindControl("btnptmp");
                            div2.Visible = true;
                        }


                    }

			}

                   
                    //////////////////////////////////end//////////////////////////////////////
                    // Remove paytm claim option for all
                   // paytm.Visible = false;

                    // Remove paytm claim option for all
                    //divclaim.Visible = true;
                }
            }

            catch (Exception ex)

            {

                lblptmm.Text = ex.StackTrace;

                // throw;


            }
        }
    }


    protected void btnptmp_Click(object sender, EventArgs e)
    {
        try
        {



            int tp = Convert.ToInt32(lbltp.Text.ToString());
            int ptforrd = Convert.ToInt32(lblrp.Text.ToString());
            float tpr = float.Parse(lblptmp.Text);
            int lrp;
            if (hcc.Value == "Comp-1350")
            {
                if (Convert.ToDecimal(tpr) >= 500 && Convert.ToDecimal(tpr) < 1000)
                {
                    ptforrd = 500;
                }
                else if (Convert.ToDecimal(tpr) >= 1000 && Convert.ToDecimal(tpr) < 1500)
                {
                    ptforrd = 1000;
                }
                else if (Convert.ToDecimal(tpr) >= 1500 && Convert.ToDecimal(tpr) < 2500)
                {
                    ptforrd = 1500;
                }
                else if (Convert.ToDecimal(tpr) >= 2500 && Convert.ToDecimal(tpr) < 4000)
                {
                    ptforrd = 2500;
                }
                else if (Convert.ToDecimal(tpr) >= 4000 && Convert.ToDecimal(tpr) < 5000)
                {
                    ptforrd = 4000;
                }
                else if (Convert.ToDecimal(tpr) >= 5000 && Convert.ToDecimal(tpr) < 8000)
                {
                    ptforrd = 5000;
                }
                else if (Convert.ToDecimal(tpr) >= 8000 && Convert.ToDecimal(tpr) < 10000)
                {
                    ptforrd = 8000;
                }
                else if (Convert.ToDecimal(tpr) >= 10000 && Convert.ToDecimal(tpr) < 15000)
                {
                    ptforrd = 10000;
                }
                else if (Convert.ToDecimal(tpr) >= 15000 && Convert.ToDecimal(tpr) < 20000)
                {
                    ptforrd = 15000;
                }
                else if (Convert.ToDecimal(tpr) >= 20000 && Convert.ToDecimal(tpr) < 40000)
                {
                    ptforrd = 20000;
                }
                else if (Convert.ToDecimal(tpr) >= 40000 && Convert.ToDecimal(tpr) < 50000)
                {
                    ptforrd = 40000;
                }
                else if (Convert.ToDecimal(tpr) >= 50000 && Convert.ToDecimal(tpr) < 75000)
                {
                    ptforrd = 50000;
                }
                else if (Convert.ToDecimal(tpr) >= 75000 && Convert.ToDecimal(tpr) < 100000)
                {
                    ptforrd = 75000;
                }
                else if (Convert.ToDecimal(tpr) >= 100000)
                {
                    ptforrd = 100000;
                }

                ptforrd = Convert.ToInt32(tpr);

                if (tpr == 500)
                {
                    tpr = 500;
                }
                else if (tpr == 1000)
                {
                    tpr = 1000;
                }
                else if (tpr == 1500)
                {
                    tpr = 1500;
                }
                else if (tpr == 2500)
                {
                    tpr = 2500;
                }
                else if (tpr == 4000)
                {
                    tpr = 4000;
                }
                else if (tpr == 5000)
                {
                    tpr = 5000;
                }

                else if (tpr == 8000)
                {
                    tpr = 8000;
                }
                else if (tpr == 10000)
                {
                    tpr = 10000;
                }
                else if (tpr == 15000)
                {
                    tpr = 15000;
                }
                else if (tpr == 20000)
                {
                    tpr = 20000;
                }
                else if (tpr == 40000)
                {
                    tpr = 40000;
                }
                else if (tpr == 50000)
                {
                    tpr = 50000;
                }
                else if (tpr == 75000)
                {
                    tpr = 75000;
                }
                else if (tpr == 100000)
                {
                    tpr = 100000;
                }




                lrp = tp - Convert.ToInt32(tpr);

            }

            else if (hcc.Value == "Comp-1483")
            {

                if (tpr >= 200)
                {
                    ptforrd = Convert.ToInt32(tpr);
                }
                ptforrd = Convert.ToInt32(tpr);

                lrp = tp - Convert.ToInt32(tpr);
            }
            else if (hcc.Value == "Comp-1659")
            {
                if (tpr >= 500)
                {
                    ptforrd = Convert.ToInt32(tpr);
                }
                ptforrd = Convert.ToInt32(tpr);

                lrp = tp - Convert.ToInt32(tpr);
            }
            else if (hcc.Value == "Comp-1674")
            {

                if (tpr >= 1000)
                {
                    ptforrd = Convert.ToInt32(tpr);
                }
                ptforrd = Convert.ToInt32(tpr);

                lrp = tp - Convert.ToInt32(tpr);
            }


            else if (hcc.Value == "Comp-1434")
            {
                if (Convert.ToDecimal(tpr) >= 1000 && Convert.ToDecimal(tpr) < 2000)
                {
                    ptforrd = 1000;
                }
                else if (Convert.ToDecimal(tpr) >= 2000 && Convert.ToDecimal(tpr) < 3000)
                {
                    ptforrd = 2000;
                }
                else if (Convert.ToDecimal(tpr) >= 3000 && Convert.ToDecimal(tpr) < 5000)
                {
                    ptforrd = 3000;
                }
                else if (Convert.ToDecimal(tpr) >= 5000 && Convert.ToDecimal(tpr) < 10000)
                {
                    ptforrd = 5000;
                }
                else if (Convert.ToDecimal(tpr) >= 10000 && Convert.ToDecimal(tpr) < 20000)
                {
                    ptforrd = 10000;
                }
                else if (Convert.ToDecimal(tpr) >= 20000 && Convert.ToDecimal(tpr) < 30000)
                {
                    ptforrd = 20000;
                }
                else if (Convert.ToDecimal(tpr) >= 30000 && Convert.ToDecimal(tpr) < 50000)
                {
                    ptforrd = 30000;
                }
                else if (Convert.ToDecimal(tpr) >= 50000 && Convert.ToDecimal(tpr) < 70000)
                {
                    ptforrd = 50000;
                }
                else if (Convert.ToDecimal(tpr) >= 70000 && Convert.ToDecimal(tpr) < 80000)
                {
                    ptforrd = 70000;
                }
                else if (Convert.ToDecimal(tpr) >= 80000 && Convert.ToDecimal(tpr) < 90000)
                {
                    ptforrd = 80000;
                }
                else if (Convert.ToDecimal(tpr) >= 90000 && Convert.ToDecimal(tpr) < 100000)
                {
                    ptforrd = 90000;
                }
                else if (Convert.ToDecimal(tpr) >= 100000 && Convert.ToDecimal(tpr) < 200000)
                {
                    ptforrd = 100000;
                }
                else if (Convert.ToDecimal(tpr) >= 200000 && Convert.ToDecimal(tpr) < 300000)
                {
                    ptforrd = 200000;
                }
                else if (Convert.ToDecimal(tpr) >= 300000 && Convert.ToDecimal(tpr) < 400000)
                {
                    ptforrd = 300000;
                }
                else if (Convert.ToDecimal(tpr) >= 400000 && Convert.ToDecimal(tpr) < 500000)
                {
                    ptforrd = 400000;
                }
                else if (Convert.ToDecimal(tpr) >= 500000 && Convert.ToDecimal(tpr) < 600000)
                {
                    ptforrd = 500000;
                }
                else if (Convert.ToDecimal(tpr) >= 600000 && Convert.ToDecimal(tpr) < 700000)
                {
                    ptforrd = 600000;
                }


                ptforrd = Convert.ToInt32(tpr);
                if (tpr == 1000)
                {
                    tpr = 1000;
                }
                else if (tpr == 2000)
                {
                    tpr = 2000;
                }
                else if (tpr == 3000)
                {
                    tpr = 3000;
                }
                else if (tpr == 5000)
                {
                    tpr = 5000;
                }
                else if (tpr == 10000)
                {
                    tpr = 10000;
                }
                else if (tpr == 20000)
                {
                    tpr = 20000;
                }
                else if (tpr == 30000)
                {
                    tpr = 30000;
                }
                else if (tpr == 50000)
                {
                    tpr = 50000;
                }
                else if (tpr == 70000)
                {
                    tpr = 70000;
                }
                else if (tpr == 80000)
                {
                    tpr = 80000;
                }
                else if (tpr == 90000)
                {
                    tpr = 90000;
                }
                else if (tpr == 100000)
                {
                    tpr = 100000;
                }
                else if (tpr == 200000)
                {
                    tpr = 200000;
                }
                else if (tpr == 300000)
                {
                    tpr = 300000;
                }
                else if (tpr == 400000)
                {
                    tpr = 400000;
                }
                else if (tpr == 500000)
                {
                    tpr = 500000;
                }
                else if (tpr == 600000)
                {
                    tpr = 600000;
                }



                lrp = tp - Convert.ToInt32(tpr);
            }


            else if (hcc.Value == "Comp-1412")
            {
                if (Convert.ToDecimal(tpr) >= 5 && Convert.ToDecimal(tpr) < 10)
                {
                    ptforrd = 12;
                }
                else if (Convert.ToDecimal(tpr) >= 10 && Convert.ToDecimal(tpr) < 20)
                {
                    ptforrd = 30;
                }
                else if (Convert.ToDecimal(tpr) >= 20 && Convert.ToDecimal(tpr) < 50)
                {
                    ptforrd = 65;
                }
                else if (Convert.ToDecimal(tpr) >= 50 && Convert.ToDecimal(tpr) < 100)
                {
                    ptforrd = 175;
                }
                else if (Convert.ToDecimal(tpr) >= 100)
                {
                    ptforrd = 400;
                }

                ptforrd = Convert.ToInt32(tpr);

                if (tpr == 12)
                {
                    tpr = 5;
                }
                else if (tpr == 30)
                {
                    tpr = 10;
                }
                else if (tpr == 65)
                {
                    tpr = 20;
                }
                else if (tpr == 175)
                {
                    tpr = 50;
                }
                else if (tpr == 400)
                {
                    tpr = 100;
                }

                lrp = tp - Convert.ToInt32(tpr);
            }
            else
            {
                lrp = tp - ptforrd;
            }
            //int rp = tp % 5;

            //float tpr = ptforrd * pr;
            string ps = string.Empty;
            string msg = "";
            DataTable dtconsumer = SQL_DB.ExecuteDataTable("select count(*) from m_consumer where m_consumerid='" + Session["M_ConsumeriD"] + "' and aadharfile is not null and aadharback is not null");
            if (dtconsumer.Rows[0][0].ToString() != "0" || hcc.Value == "Comp-1227" || hcc.Value == "Comp-1350" || hcc.Value == "Comp-1412" || hcc.Value == "Comp-1434" || hcc.Value == "Comp-1483" || hcc.Value == "Comp-1466" || hcc.Value == "Comp-1438" || hcc.Value == "Comp-1659" || hcc.Value == "Comp-1674")
            {
                DataTable dtcondition = SQL_DB.ExecuteDataTable("select top 1 codition_point,condition_match from point_redeem_condition where comp_id='" + hcc.Value + "' and isactive=1 and selection_id=case when (select count(*) from paytmtransaction where m_consumerid='" + Session["M_ConsumeriD"] + "' and pstatus='SUCCESS' and comp_id='Comp-1283')>0 then 2 else 1 end ");
                if (ptforrd >= Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))
                {
                    string cn = SQL_DB.ExecuteScalar("select Comp_Name from dbo.[comp_reg] where comp_id='" + hcc.Value + "'").ToString();
                    string mb = SQL_DB.ExecuteScalar("select mobileno from dbo.m_consumer where user_id='" + Session["USRID"].ToString() + "'").ToString();
                    string oid = SQL_DB.ExecuteScalar("select (ISNULL(max(orderid),1000))+1 as orderid from [dbo].[paytmtransaction]").ToString();
                    //if (cn == "COATS BATH FITTINGS")
                    //{

                    //    SQL_DB.ExecuteNonQuery("insert into ClaimDetails([Claim_date],[Mobileno],[Amount],[document_status],[action_date],[Isapproved],[Comp_id]) values(GETDATE(),'" + mb + "'," + tpr.ToString() + ",1,null,0,'" + hcc.Value + "') ");
                    //    msg = "Your Request Registere with US for points " + ptforrd;

                    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                    //}

                    if (cn == "COATS BATH FITTINGS" || cn == "R.S Industries" || cn == "Jupiter Aqua Lines Ltd" || cn == "Girish Chemical Industries" || cn== "SAFFRO MELLOW COATINGS AND RESINS" || cn == "BENITTON BATHWARE")
                    {


                        DataTable dtcondition1 = SQL_DB.ExecuteDataTable("select 'x' from [ClaimDetails] left join M_Consumer on right(M_Consumer.MobileNo, 10) = right([ClaimDetails].Mobileno, 10) where M_Consumer.M_Consumerid = '" + Session["M_ConsumeriD"] + "' and[Isapproved] =0");

                        if (dtcondition1.Rows.Count > 0)
                        {
                            msg = "Your request already registered with us for points " + ptforrd;
                        }
                        else
                        {
                            SQL_DB.ExecuteNonQuery("insert into ClaimDetails([Claim_date],[Mobileno],[Amount],[document_status],[action_date],[Isapproved],[Comp_id]) values(GETDATE(),'" + mb + "'," + ptforrd.ToString() + ",1,null,0,'" + hcc.Value + "') ");

                            msg = "Your request registered with us for points " + ptforrd;

                        }

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                    }

                    else
                    {
                        ps = ServiceLogic.Paytm_Cash(mb, ptforrd.ToString(), oid, null, cn);

                        if (hcc.Value == "Comp-1350" || hcc.Value == "Comp-1412" || hcc.Value == "Comp-1483")
                        {
                            if (ps.Contains("ACCEPTED"))
                            {
                                btnptmp.Visible = false;
                                SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + hcc.Value + "','" + mb + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + Session["M_ConsumeriD"] + "'," + ptforrd + ",'Accepted','" + oid + "')");
                                SQL_DB.ExecuteNonQuery("insert into BPointsTransaction([Transsctionid],[TotalPoints],[RedeemPoints],[Redeemdate],[RedeemBy],Incash,bpstatus) values(1," + tp + "," + tpr + ",'" + System.DateTime.Now.ToString("yyyy-MM-dd") + "','" + Session["M_ConsumeriD"] + "'," + ptforrd + ",'Accepted')");
                                msg = "Your request registered with us for points " + tpr + " for amount- " + ptforrd;
                                lblptmp.Text = lrp.ToString();
                                lblptmm.Text = msg;
                                lblptmm.Visible = true;
                                string message = "alert('" + msg + "')";
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                                btnptmp.Visible = false;
                            }
                            else
                            {
                                SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + hcc.Value + "','" + mb + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + Session["M_ConsumeriD"] + "'," + ptforrd + ",'FAILURE','" + oid + "')");
                                msg = "Your Redemption is Fail for points " + tpr;
                                //lblptmp.Text = lrp.ToString();
                                lblptmm.Text = msg;
                                lblptmm.Visible = true;
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                            }
                        }
                        else
                        {

                            if (ps.Contains("ACCEPTED"))
                            {
                                btnptmp.Visible = false;
                                SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + hcc.Value + "','" + mb + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + Session["M_ConsumeriD"] + "'," + tpr + ",'Accepted','" + oid + "')");
                                SQL_DB.ExecuteNonQuery("insert into BPointsTransaction([Transsctionid],[TotalPoints],[RedeemPoints],[Redeemdate],[RedeemBy],Incash,bpstatus) values(1," + tp + "," + ptforrd + ",'" + System.DateTime.Now.ToString("yyyy-MM-dd") + "','" + Session["M_ConsumeriD"] + "'," + tpr + ",'Accepted')");
                                msg = "Your request registered with us for points " + ptforrd + " for amount- " + tpr;
                                lblptmp.Text = lrp.ToString();
                                lblptmm.Text = msg;
                                lblptmm.Visible = true;
                                string message = "alert('" + msg + "')";
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                                btnptmp.Visible = false;
                            }
                            else
                            {
                                SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + hcc.Value + "','" + mb + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + Session["M_ConsumeriD"] + "'," + tpr + ",'FAILURE','" + oid + "')");
                                msg = "Your Redemption is Fail for points " + ptforrd;
                                //lblptmp.Text = lrp.ToString();
                                lblptmm.Text = msg;
                                lblptmm.Visible = true;
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                            }
                        }
                    }
                    //showclaim();
                }
                else
                {
                    msg = "You Redemption is " + ps;
                    lblptmp.Text = lrp.ToString();
                    lblptmm.Text = msg;
                    lblptmm.Visible = true;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                }
            }
            else
            {
                msg = "Please Uplaod the Documents first";
                //lblptmp.Text = lrp.ToString();
                lblptmm.Text = msg;
                lblptmm.Visible = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);

            }
        }
        catch (Exception ex)
        {
            throw;
        }
    }

public void disablebrowserbackbutton()
    {
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        HttpContext.Current.Response.Cache.SetNoServerCaching();
        HttpContext.Current.Response.Cache.SetNoStore();
    }

    protected void btnptmp_Click1(object sender, EventArgs e)
    {
        try
        {

            //Reference the Repeater Item using Button.
            RepeaterItem item = (sender as LinkButton).NamingContainer as RepeaterItem;

            //Reference the Label and TextBox.
            int ptforrd = Convert.ToInt32((item.FindControl("lblrp") as Label).Text);

            //DataTable dtgift = SQL_DB.ExecuteDataTable("select Gifts from Claim_gift where CompID='Comp-1434' and Gift_value='" + ptforrd + "' ");
            DataTable dtgift = SQL_DB.ExecuteDataTable("select Gifts from Claim_gift where CompID='" + hcc.Value + "' and Gift_value='" + ptforrd + "' ");

            //int tp = Convert.ToInt32((item.FindControl("lbltp") as Label).Text);
            float tpr = float.Parse((item.FindControl("lblptmp") as Label).Text);
            //message += "\\nName: " + (item.FindControl("lblName") as Label).Text;
            //message += "\\nCountry: " + (item.FindControl("txtCountry") as TextBox).Text;

            //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + message + "');", true);


            //////////////////////////////////////////
            int tp = Convert.ToInt32(totalpoints.Value);
            //int tp = Convert.ToInt32(lbltp.Text.ToString());
            //int ptforrd = Convert.ToInt32(lblrp.Text.ToString());
            //float tpr = float.Parse(lblptmp.Text);
            //int rp = tp % 5;
            int lrp = tp - ptforrd;
            //float tpr = ptforrd * pr;

            //if (hcc.Value == "Comp-1466")
            //    {
            //        if (Convert.ToDecimal(tpr) >= 200 && Convert.ToDecimal(tpr) < 500)
            //        {
            //            ptforrd = 200;
            //        }
            //        else if (Convert.ToDecimal(tpr) >= 500 && Convert.ToDecimal(tpr) < 1000)
            //        {
            //            ptforrd = 600;
            //        }
            //        else if (Convert.ToDecimal(tpr) >= 1000 && Convert.ToDecimal(tpr) < 2000)
            //        {
            //            ptforrd = 1400;
            //        }
            //        else if (Convert.ToDecimal(tpr) >= 2000 && Convert.ToDecimal(tpr) < 5000)
            //        {
            //            ptforrd = 3000;
            //        }
            //        else if (Convert.ToDecimal(tpr) >= 5000)
            //        {
            //            ptforrd = 8000;
            //        }

            //        lrp = tp - Convert.ToInt32(tpr);
            //    }


            string ps = string.Empty;
            string msg = "";
            DataTable dtconsumer = SQL_DB.ExecuteDataTable("select count(*) from m_consumer where m_consumerid='" + Session["M_ConsumeriD"] + "' and aadharfile is not null and aadharback is not null");
            if (dtconsumer.Rows[0][0].ToString() != "0" || hcc.Value == "Comp-1707" || hcc.Value == "Comp-1227" || hcc.Value == "Comp-1550" || hcc.Value == "Comp-1434" || hcc.Value == "Comp-1350" || hcc.Value == "Comp-1466")
            {
                DataTable dtcondition = SQL_DB.ExecuteDataTable("select top 1 codition_point,condition_match from point_redeem_condition where comp_id='" + hcc.Value + "' and isactive=1 and selection_id=case when (select count(*) from paytmtransaction where m_consumerid='" + Session["M_ConsumeriD"] + "' and pstatus='SUCCESS' and comp_id='Comp-1283')>0 then 2 else 1 end ");
                if (ptforrd >= Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))
                {
                    string cn = SQL_DB.ExecuteScalar("select Comp_Name from dbo.[comp_reg] where comp_id='" + hcc.Value + "'").ToString();
                    string mb = SQL_DB.ExecuteScalar("select mobileno from dbo.m_consumer where user_id='" + Session["USRID"].ToString() + "'").ToString();
                    string oid = SQL_DB.ExecuteScalar("select (ISNULL(max(orderid),1000))+1 as orderid from [dbo].[paytmtransaction]").ToString();

                    if (cn == "Indian Plywood Company" || cn == "COATS BATH FITTINGS" || cn == "R.S Industries" || cn == "BAGHLA SANITARYWARE" || cn == "Jupiter Aqua Lines Ltd" || cn == "Inox Decor Pvt Ltd" || cn == "Veena Polymers" || cn == "OCI Wires and Cables")
                    {

                        DataTable Total_Days = SQL_DB.ExecuteDataTable("select top 1 DATEDIFF(day, Enq_Date, GETDATE()) AS Days_Total from Pro_Enq where MobileNo='" + mb + "' and Is_Success=1 order by Enq_Date asc ");

                        // DataTable dtcondition1 = SQL_DB.ExecuteDataTable("select 'x' from [ClaimDetails] left join M_Consumer on right(M_Consumer.MobileNo, 10) = right([ClaimDetails].Mobileno, 10) where M_Consumer.M_Consumerid = '" + Session["M_ConsumeriD"] + "' and[Isapproved] != 1");
                        DataTable dtcondition1 = SQL_DB.ExecuteDataTable("select 'x' from [ClaimDetails] left join M_Consumer on right(M_Consumer.MobileNo, 10) = right([ClaimDetails].Mobileno, 10) where M_Consumer.M_Consumerid = '" + Session["M_ConsumeriD"] + "' and[Isapproved] = 0");      //--- 230323 bipin

                        if (dtcondition1.Rows.Count > 0)
                        {
                            msg = "Your request already registered with us for points " + ptforrd;
                        }
                        else
                        {

                            if (hcc.Value == "Comp-1434")
                            {
                                if (Convert.ToInt32(Total_Days.Rows[0]["Days_Total"].ToString()) >= 30)
                                {
                                    SQL_DB.ExecuteNonQuery(" insert into ClaimDetails([Claim_date],[Mobileno],[Amount],[document_status],[action_date],[Isapproved],[Comp_id],[Gifts_Redeemed])values(GETDATE(), '" + mb + "', " + ptforrd.ToString() + ", 1, null, 0, '" + hcc.Value + "', '" + dtgift.Rows[0][0].ToString() + "')");
                                    msg = "Your request registered with us for points " + ptforrd;
                                }
                                else
                                {
                                    msg = "Your are not eligible for claim Please try after " + (30 - Convert.ToInt32(Total_Days.Rows[0]["Days_Total"].ToString())) + " " + "Days";
                                }

                            }

                            else if (hcc.Value == "Comp-1350" || hcc.Value == "Comp-1466")
                            {
                                SQL_DB.ExecuteNonQuery(" insert into ClaimDetails([Claim_date],[Mobileno],[Amount],[document_status],[action_date],[Isapproved],[Comp_id],[Gifts_Redeemed])values(GETDATE(), '" + mb + "', " + ptforrd.ToString() + ", 1, null, 0, '" + hcc.Value + "', '" + dtgift.Rows[0][0].ToString() + "')");
                                msg = "Your request registered with us for points " + ptforrd;
                            }

                            else
                            {
                                SQL_DB.ExecuteNonQuery("insert into ClaimDetails([Claim_date],[Mobileno],[Amount],[document_status],[action_date],[Isapproved],[Comp_id]) values(GETDATE(),'" + mb + "'," + ptforrd.ToString() + ",1,null,0,'" + hcc.Value + "') ");
                                msg = "Your request registered with us for points " + ptforrd;


                            }


                        }

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                    }

                    else
                    {
                        ps = ServiceLogic.Paytm_Cash(mb, ptforrd.ToString(), oid, null, cn);





                        if (ps.Contains("ACCEPTED"))
                        {

                            if (hcc.Value == "Comp-001466")
                            {
                                SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + hcc.Value + "','" + mb + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + Session["M_ConsumeriD"] + "'," + ptforrd + ",'Accepted','" + oid + "')");
                                SQL_DB.ExecuteNonQuery("insert into BPointsTransaction([Transsctionid],[TotalPoints],[RedeemPoints],[Redeemdate],[RedeemBy],Incash,bpstatus) values(1," + tp + "," + tpr + ",'" + System.DateTime.Now.ToString("yyyy-MM-dd") + "','" + Session["M_ConsumeriD"] + "'," + ptforrd + ",'Accepted')");
                                // msg = "Your Request Registere with US for points " + ptforrd + " for amount- " + tpr;
                                msg = "Your request registered with us for points " + tpr + " for amount- " + ptforrd;
                            }
                            else
                            {
                                SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + hcc.Value + "','" + mb + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + Session["M_ConsumeriD"] + "'," + tpr + ",'Accepted','" + oid + "')");
                                SQL_DB.ExecuteNonQuery("insert into BPointsTransaction([Transsctionid],[TotalPoints],[RedeemPoints],[Redeemdate],[RedeemBy],Incash,bpstatus) values(1," + tp + "," + ptforrd + ",'" + System.DateTime.Now.ToString("yyyy-MM-dd") + "','" + Session["M_ConsumeriD"] + "'," + tpr + ",'Accepted')");
                                msg = "Your request registered with us for points " + ptforrd + " for amount- " + tpr;
                                //msg = "Your Request Registere with US for points " + tpr + " for amount- " + ptforrd;
                            }

                            btnptmp.Visible = false;
                            // SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + hcc.Value + "','" + mb + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + Session["M_ConsumeriD"] + "'," + tpr + ",'Accepted','" + oid + "')");
                            //  SQL_DB.ExecuteNonQuery("insert into BPointsTransaction([Transsctionid],[TotalPoints],[RedeemPoints],[Redeemdate],[RedeemBy],Incash,bpstatus) values(1," + tp + "," + ptforrd + ",'" + System.DateTime.Now.ToString("yyyy-MM-dd") + "','" + Session["M_ConsumeriD"] + "'," + tpr + ",'Accepted')");
                            //  msg = "Your Request Registere with US for points " + ptforrd + " for amount- " + tpr;
                            lblptmp.Text = lrp.ToString();
                            lblptmm.Text = msg;
                            lblptmm.Visible = true;
                            string message = "alert('" + msg + "')";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                            btnptmp.Visible = false;
                        }
                        else
                        {
                            SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + hcc.Value + "','" + mb + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + Session["M_ConsumeriD"] + "'," + tpr + ",'FAILURE','" + oid + "')");
                            msg = "Your redemption is failed for points " + ptforrd;
                            //lblptmp.Text = lrp.ToString();
                            lblptmm.Text = msg;
                            lblptmm.Visible = true;
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                        }
                    }
                    //showclaim();
                }
                else
                {
                    msg = "You Redemption is " + ps;
                    lblptmp.Text = lrp.ToString();
                    lblptmm.Text = msg;
                    lblptmm.Visible = true;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                }
            }
            else
            {
                msg = "Please Uplaod the Documents first";
                //lblptmp.Text = lrp.ToString();
                lblptmm.Text = msg;
                lblptmm.Visible = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);

            }
        }
        catch (Exception ex)
        {
            throw;
        }
    }

 protected void btnpointClaim_Click(object sender, EventArgs e)
    {
        try
        {



            //Reference the Repeater Item using Button.
            RepeaterItem item = (sender as LinkButton).NamingContainer as RepeaterItem;

            //Reference the Label and TextBox.
            int ptforrd = Convert.ToInt32((item.FindControl("lblrp") as Label).Text);

            //int tp = Convert.ToInt32((item.FindControl("lbltp") as Label).Text);
            float tpr = float.Parse((item.FindControl("lblptmp") as Label).Text);

            string txtUpiId = (item.FindControl("txtUpiId_UPI") as TextBox).Text;
            //string txtUpiId = (item.FindControl("txtUpiId") as TextBox).Text;
            

           // string txtMobile = (item.FindControl("txtMobileNo") as TextBox).Text;


            //CheckBox ChkMoile = item.FindControl("ChkMoile") as CheckBox;
            //CheckBox ChkUpiId = item.FindControl("ChkUpiId") as CheckBox;
            string InputData = "";
            /*  if (ChkMoile.Checked)
              {
                  if (txtMobile == "")
                  {
                      //ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('Please enter 10 digit mobile Number !.');window.location.replace('');</script>");
                      ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('Please enter valid 10 digit mobile Number !');", true);
                      return;
                  }

                  else
                      InputData = txtMobile;

                  if (txtMobile.Length != 10)
                  {
                      //ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('Please enter 10 digit mobile Number !.');window.location.replace('');</script>");
                      ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('Please enter valid 10 digit mobile Number !');", true);
                      return;
                  }


                  if (!txtMobile.All(char.IsDigit))
                  {
                      //ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('Please enter valid 10 digit mobile Number !.');window.location.replace('');</script>");
                      ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('Please enter valid 10 digit mobile Number !');", true);
                      return;
                  }
              }
              */





            //if (ChkUpiId.Checked)
            //{
            //    if (txtUpiId == "")
            //    {
            //        //ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('Please enter upi id !.');window.location.replace('');</script>");
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('Please enter valid upi id !');", true);
            //        return;
            //    }
            //    if (!txtUpiId.Contains("@"))
            //    {
            //        //ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('Please enter valid upi id !.');window.location.replace('');</script>");
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('Please enter valid upi id !');", true);
            //        return;
            //    }
            //    if (txtUpiId.Length > 20)
            //    {
            //        //ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('Please enter valid upi id !.');window.location.replace('');</script>");

            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('Please enter valid upi id !');", true);
            //        return;
            //    }
            //    else
            //        InputData = txtUpiId;

            //}

            if (txtUpiId == "")
            {
                //ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('Please enter upi id !.');window.location.replace('');</script>");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('Please enter valid upi id !');", true);
                return;
            }
            if (!txtUpiId.Contains("@"))
            {
                //ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('Please enter valid upi id !.');window.location.replace('');</script>");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('Please enter valid upi id !');", true);
                return;
            }
            if (txtUpiId.Length < 5 && txtUpiId.Length > 60)
            {
                //ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('Please enter valid upi id !.');window.location.replace('');</script>");

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('Please enter valid upi id !');", true);
                return;
            }
            else
                InputData = txtUpiId;

            // add for lubigen  Tej
            DataTable dt = new DataTable();
            dt = SQL_DB.ExecuteDataTable("select top 1 [user_id],M_Consumerid,UPIId,MobileNo,aadharfile,aadharback from m_consumer where M_Consumerid=" + Session["M_ConsumeriD"].ToString());
            // add for lubigen tej
            if (dt.Rows.Count > 0 && txtUpiId != "")
            {
                if (dt.Rows[0]["UPIId"].ToString().Length < 10)
                {
                    SQL_DB.ExecuteDataTable("UPDATE M_Consumer SET UPIId = '" + txtUpiId.Trim().Replace("'", "''") + "' where M_Consumerid=" + Session["M_ConsumeriD"].ToString());

                }

                if (dt.Rows[0]["aadharfile"].ToString().Length < 10 || dt.Rows[0]["aadharback"].ToString().Length < 10)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('Please upload document, For upload documnet go to profile!');", true);
                    return;
                }

            }


            //////////////////////////////////////////
            ///
            // add by bipin single below line
            DataTable dtgift = SQL_DB.ExecuteDataTable("select Gifts from Claim_gift where CompID='" + hcc.Value + "' and Gift_value='" + ptforrd + "' ");

            int tp = 0;
            if (totalpoints.Value != "")
                tp = Convert.ToInt32(totalpoints.Value);

            int lrp = tp - ptforrd;
            //float tpr = ptforrd * pr;

            string loyalty_return = SQL_DB.ExecuteScalar("select isnull(sum(loyalty),0) from scrap_entry se inner join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2 inner join m_consumer ms on ms.MobileNo=pe.MobileNo where pe.is_success=1 and  ms.M_Consumerid= " + Session["M_ConsumeriD"]).ToString();


            DataTable dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash ,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where  bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + Session["USRID"].ToString() + "') group by mss.Comp_ID,cl.p_cash");

            if (dtcp.Rows.Count > 0)
            {
                int loyaltybonus = 0;



                if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1215" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1285" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1241" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1322" /*|| dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1236" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1256"*/)

                {
                    loyaltybonus = Convert.ToInt32(SQL_DB.ExecuteScalar("select isnull(sum(points),0) as points from buildloyalty_offers where m_consumerid=" + Session["M_ConsumeriD"]).ToString());

                }

                int totalpoint = (Convert.ToInt32(dtcp.Rows[0]["point"].ToString()) - Convert.ToInt32(loyalty_return)) + loyaltybonus;

                int redeempoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(bl.[RedeemPoints]) is null then 0 else Sum(isnull(bl.[RedeemPoints],0)) end FROM [BPointsTransaction] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[RedeemBy] where mc.[User_ID]='" + Session["USRID"].ToString() + "' and (bl.bpstatus is null or bl.bpstatus<>'FAILURE')"));
                int claimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [ClaimDetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.[User_ID]='" + Session["USRID"].ToString() + "' and (cl.Isapproved=1 )"));

                float totalpointrt = Convert.ToInt32(dtcp.Rows[0]["p_cash"].ToString());


                DataTable dtcondition = new DataTable();


                dtcondition = SQL_DB.ExecuteDataTable("select top 1 codition_point,condition_match from point_redeem_condition where comp_id='" + dtcp.Rows[0]["Comp_ID"].ToString() + "' and isactive=1 and selection_id=case when (select count(*) from paytmtransaction where m_consumerid='" + Session["M_ConsumeriD"] + "' and comp_id='Comp-1214')>0 then 2 else 1 end ");
                if (dtcondition.Rows.Count > 0)
                {
                    if (dtcondition.Rows[0]["condition_match"].ToString() == "1")

                    {

                        tp = totalpoint - redeempoint - claimapply;

                        if (tp < ptforrd)
                        {
                           // ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('You have insufficient point balance to claim : " + tp + " !');window.location.replace('');</script>");
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('You have insufficient point balance to claim : " + tp + " !');", true);
                            return;
                        }
                    }



                }

            }



            string ps = string.Empty;
            string msg = "";
            DataTable dtconsumer = SQL_DB.ExecuteDataTable("select count(*) from m_consumer where m_consumerid='" + Session["M_ConsumeriD"] + "' and aadharfile is not null and aadharback is not null");
            if (dtconsumer.Rows[0][0].ToString() != "0" || hcc.Value == "Comp-1483")
            {
                DataTable dtcondition = SQL_DB.ExecuteDataTable("select top 1 codition_point,condition_match from point_redeem_condition where comp_id='" + hcc.Value + "' and isactive=1 and selection_id=case when (select count(*) from paytmtransaction where m_consumerid='" + Session["M_ConsumeriD"] + "' and pstatus='SUCCESS' and comp_id='Comp-1214')>0 then 2 else 1 end ");
                if (ptforrd >= Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))
                {
                    string cn = SQL_DB.ExecuteScalar("select Comp_Name from dbo.[comp_reg] where comp_id='" + hcc.Value + "'").ToString();
                    string mb = SQL_DB.ExecuteScalar("select mobileno from dbo.m_consumer where user_id='" + Session["USRID"].ToString() + "'").ToString();

                    if (cn == "Lubigen Pvt Ltd")
                    {

                        DataTable Total_Days = SQL_DB.ExecuteDataTable("select top 1 DATEDIFF(day, Enq_Date, GETDATE()) AS Days_Total from Pro_Enq where MobileNo='" + mb + "' and Is_Success=1 order by Enq_Date asc ");

                        //DataTable dtcondition1 = SQL_DB.ExecuteDataTable("select 'x' from [ClaimDetails] left join M_Consumer on right(M_Consumer.MobileNo, 10) = right([ClaimDetails].Mobileno, 10) where M_Consumer.M_Consumerid = '" + Session["M_ConsumeriD"] + "' and[Isapproved] != 1");
                        DataTable dtcondition1 = SQL_DB.ExecuteDataTable("select 'x' from [ClaimDetails] left join M_Consumer on right(M_Consumer.MobileNo, 10) = right([ClaimDetails].Mobileno, 10) where M_Consumer.M_Consumerid = '" + Session["M_ConsumeriD"] + "' and[Isapproved] = 0");
                        if (dtcondition1.Rows.Count > 0)
                        {
                            msg = "Your Request Already Registered with us for points " + ptforrd;
                        }
                        else
                        {



                            #region //** Lubigen
                            if (hcc.Value == "Comp-1483")
                            {

                                SQL_DB.ExecuteNonQuery("insert into ClaimDetails([Claim_date],[Mobileno],[Amount],[document_status],[action_date],[Isapproved],[Comp_id],[Gifts_Redeemed],UPIID,PaymentStatus)values(GETDATE(), '" + mb + "', " + ptforrd.ToString() + ", 1, null, 0, '" + hcc.Value + "', '" + dtgift.Rows[0][0].ToString() + "','" + InputData + "','Pending')");
                                msg = "Your claim request has been received. Transaction will take place within 24-48 working hours.";
                            }
                            #endregion

                            else
                            {
                                SQL_DB.ExecuteNonQuery("insert into ClaimDetails([Claim_date],[Mobileno],[Amount],[document_status],[action_date],[Isapproved],[Comp_id]) values(GETDATE(),'" + mb + "'," + ptforrd.ToString() + ",1,null,0,'" + hcc.Value + "') ");
                                msg = "Your Request Registered with us for points " + ptforrd;
                            }

                        }


                       // ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('" + msg + "');window.location.replace('');</script>");
                         ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                        disablebrowserbackbutton();


                    }

                }
                else
                {
                    msg = "You Redemption is " + ps;
                    lblptmp.Text = lrp.ToString();
                    lblptmm.Text = msg;
                    lblptmm.Visible = true;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                }
            }
            else
            {
                msg = "Please Uplaod the Documents first";
                //lblptmp.Text = lrp.ToString();
                lblptmm.Text = msg;
                lblptmm.Visible = true;

              //  ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('" + msg + "');window.location.replace('');</script>");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);

            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + ex + "');", true);
           // ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('" + ex + "');window.location.replace('');</script>");
            throw;
        }
        //Response.Redirect("Transaction.aspx");

        // ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
    }

    protected void ChkMoile_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            //Reference the Repeater Item using Button.
            RepeaterItem item = (sender as CheckBox).NamingContainer as RepeaterItem;

            //Reference the Label and TextBox.

            CheckBox ChkMoile = item.FindControl("ChkMoile") as CheckBox;
            CheckBox ChkUpiId = item.FindControl("ChkUpiId") as CheckBox;
            if (ChkMoile.Checked)
            {

                Control DivPointClaim = Repeater2.Items[0].FindControl("DivPointClaim");
                Control DivPointClaimMobile = Repeater2.Items[0].FindControl("DivPointClaimMobile");
                Control DivPointClaimUpi = Repeater2.Items[0].FindControl("DivPointClaimUpi");
                DivPointClaim.Visible = true;
                DivPointClaimMobile.Visible = true;
                DivPointClaimUpi.Visible = false;
                ChkUpiId.Checked = false;
            }
            else
            {
                Control DivPointClaim = Repeater2.Items[0].FindControl("DivPointClaim");
                Control DivPointClaimMobile = Repeater2.Items[0].FindControl("DivPointClaimMobile");
                Control DivPointClaimUpi = Repeater2.Items[0].FindControl("DivPointClaimUpi");
                DivPointClaim.Visible = true;
                DivPointClaimMobile.Visible = false;
                DivPointClaimUpi.Visible = true;
                ChkMoile.Checked = false;
            }



        }
        catch (Exception ex)
        {

        }
    }

    protected void ChkUpiId_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            //Reference the Repeater Item using Button.
            RepeaterItem item = (sender as CheckBox).NamingContainer as RepeaterItem;

            //Reference the Label and TextBox.
            CheckBox ChkMoile = item.FindControl("ChkMoile") as CheckBox;
            CheckBox ChkUpiId = item.FindControl("ChkUpiId") as CheckBox;
            if (ChkUpiId.Checked)
            {
                Control DivPointClaim = Repeater2.Items[0].FindControl("DivPointClaim");
                Control DivPointClaimMobile = Repeater2.Items[0].FindControl("DivPointClaimMobile");
                Control DivPointClaimUpi = Repeater2.Items[0].FindControl("DivPointClaimUpi");
                DivPointClaim.Visible = true;
                DivPointClaimMobile.Visible = false;
                DivPointClaimUpi.Visible = true;
                ChkMoile.Checked = false;
            }
            else
            {
                Control DivPointClaim = Repeater2.Items[0].FindControl("DivPointClaim");
                Control DivPointClaimMobile = Repeater2.Items[0].FindControl("DivPointClaimMobile");
                Control DivPointClaimUpi = Repeater2.Items[0].FindControl("DivPointClaimUpi");
                DivPointClaim.Visible = true;
                DivPointClaimMobile.Visible = true;
                DivPointClaimUpi.Visible = false;
                ChkUpiId.Checked = false;
            }



        }
        catch (Exception ex)
        {

        }
    }

    protected void btnpointClaim_UPI_Click(object sender, EventArgs e)
    {
        try
        {



            //Reference the Repeater Item using Button.
            RepeaterItem item = (sender as LinkButton).NamingContainer as RepeaterItem;

            //Reference the Label and TextBox.
            int ptforrd = Convert.ToInt32((item.FindControl("lblrp") as Label).Text);  // available point

            //int tp = Convert.ToInt32((item.FindControl("lbltp") as Label).Text);
            float tpr = float.Parse((item.FindControl("lblptmp") as Label).Text);

            string txtUpiId = (item.FindControl("txtUpiId_UPI") as TextBox).Text;

            //  string serviceid = (item.FindControl("serviceid") as Label).Text;



            string InputData = "";







            if (txtUpiId == "")
            {
                ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('Please enter upi id !.');window.location.replace('');</script>");
                return;
            }
            if (!txtUpiId.Contains("@"))
            {
                ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('Please enter valid upi id !.');window.location.replace('');</script>");
                return;
            }
            if (txtUpiId.Length < 5 && txtUpiId.Length > 60)
            {
                ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('Please enter valid upi id !');window.location.replace('');</script>");
                return;
            }
            else
                InputData = txtUpiId;



            DataTable dt = new DataTable();
            dt = SQL_DB.ExecuteDataTable("select top 1 [user_id],M_Consumerid,UPIId,MobileNo from m_consumer where M_Consumerid=" + Session["M_ConsumeriD"].ToString());

            // add for lubigen tej
            if (dt.Rows.Count > 0)
            {
                if (txtUpiId != "")
                {
                    SQL_DB.ExecuteDataTable("UPDATE M_Consumer SET UPIId = '" + txtUpiId.Trim().Replace("'", "''") + "' where M_Consumerid=" + Session["M_ConsumeriD"].ToString());

                }

            }
            string str = String.Format("https://api2.vcqru.com/api/ApiSubmitClaim");
            WebRequest request = WebRequest.Create(str);
            request.Method = "POST";
            string postData="";
            //ambica,oci
            if (Session["Comp_id"].ToString() == "Comp-1702" || Session["Comp_id"].ToString() == "Comp-1202" || Session["Comp_id"].ToString() == "Comp-1548" || Session["Comp_id"].ToString() == "Comp-1466")
            {
                 postData = "{\"Mobile\":\"" + dt.Rows[0]["MobileNo"].ToString() + "\",\"ProductId\":\"284\",\"Productvalue\":\"" + ptforrd + "\",\"ServiceId\":\"SRV1029\",\"Amount\":\"" + ptforrd + "\",\"UPIID\":\"" + txtUpiId + "\"}";

            }
            else if (Session["Comp_id"].ToString() == "Comp-1483")
            { // lubigen
                postData = "{\"Mobile\":\"" + dt.Rows[0]["MobileNo"].ToString() + "\",\"ProductId\":\"284\",\"Productvalue\":\"250\",\"ServiceId\":\"SRV1029\",\"Amount\":\"" + ptforrd + "\",\"UPIID\":\"" + txtUpiId + "\"}";

            }
            else
            {
                postData = "{\"Mobile\":\"" + dt.Rows[0]["MobileNo"].ToString() + "\",\"ProductId\":\"284\",\"Productvalue\":\"" + ptforrd + "\",\"ServiceId\":\"SRV1029\",\"Amount\":\"" + ptforrd + "\",\"UPIID\":\"" + txtUpiId + "\"}";

            }

            byte[] byteArray = Encoding.UTF8.GetBytes(postData);

            request.ContentType = "application/json";//application/     x-www-form-urlencoded

            request.ContentType = "application/json";//application/     x-www-form-urlencoded

            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();
            Console.WriteLine(((HttpWebResponse)response).StatusDescription);
            dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();

            JObject jObjects = JObject.Parse(responseFromServer);
            string msg = jObjects["Message"].ToString();




            ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('" + msg + "');window.location.replace('');</script>");

        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(typeof(Page), "alertMessage", "<script type='text/javascript'>alert('" + ex + "');window.location.replace('');</script>");
            throw;
        }
    }
}