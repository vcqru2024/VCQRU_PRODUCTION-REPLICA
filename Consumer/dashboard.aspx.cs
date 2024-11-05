using Business_Logic_Layer;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Consumer_dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)

    {
        if (Session["Consumer_id"] == null)
            Response.Redirect("../Login.aspx");
      
        DataTable dt = new DataTable();

        if (!IsPostBack)
        {
            if (Session["Comp_id"].ToString() == "")
            {
                DataTable dtcomp = SQL_DB.ExecuteDataTable("exec USP_Getcompbymobile '"+ Session["Consumer_id"].ToString() + "' ");
                if (dtcomp.Rows.Count > 0)
                {
                    Session["Comp_id"] = dtcomp.Rows[0]["Comp_ID"].ToString();
                }
            }
            #region Patanjali logo
            if (Session["Comp_id"] != null)
            {
                if (Session["Comp_id"].ToString() == "Comp-1693")
                {
                    Complogo.Src = "https://www.patanjaliayurved.net/media/images/logo.svg";
                    Complogo.Style.Add("width", "150px");
                }
            }
            #endregion


            if (Request.QueryString["app"] == "1")
            {

                string consumer_id = Request.QueryString["userid"];

                User_Details Log = new User_Details();

                Log.User_Type = "Consumer";

                Log.User_ID = consumer_id;

                //Log.Password = pass.Trim().Replace("'", "''");

                dt = User_Details.app_GetUserLoginDetails(Log);

                Session["USRID"] = dt.Rows[0]["User_ID"].ToString();

                Session["M_ConsumeriD"] = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
                if(Session["Comp_id"].ToString()=="")
                    Session["Comp_id"] = dt.Rows[0]["Comp_id"].ToString();


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

                        dt = User_Details.GetUserLoginDetails(Log);

                        Session["USRID"] = dt.Rows[0]["User_ID"].ToString();
                        if (Session["Comp_id"].ToString() == "")
                            Session["Comp_id"] = dt.Rows[0]["Comp_id"].ToString();

                        Session["M_ConsumeriD"] = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);

                        Session["User_Type"] = "Consumer";

                    }

                    else

                    {

                        Response.Redirect("../Login.aspx");

                    }

                }

                else

                {



                    dt = SQL_DB.ExecuteDataTable("select * from m_consumer where m_consumerid=" + Session["Consumer_id"]);
                    if (Session["Comp_id"].ToString() == "")
                        Session["Comp_id"] = dt.Rows[0]["Comp_id"].ToString();

                }

            }

        }

        User_Details Reg = new User_Details();

        Reg.User_ID = Session["USRID"].ToString();

        User_Details.FillUpDateProfile(Reg);

        if (File.Exists(Server.MapPath(Reg.Profile_image)))

        {



            top_profile_img.ImageUrl = Reg.Profile_image;



            top_profile_img.DataBind();



        }

        else

        {



            top_profile_img.ImageUrl = "../assetsfrui/images/user-profile/user-img.jpg";



            top_profile_img.DataBind();



        }



        string distributorid = string.Empty;

        bool flg = false;

        if (dt.Rows.Count > 0)

        {
            if (Session["Comp_id"].ToString() == "")
                Session["Comp_id"] = dt.Rows[0]["Comp_id"].ToString();
            if (dt.Rows[0]["distributorID"] != null)

            {

                if (dt.Rows[0]["distributorID"].ToString() != "")

                {

                    distributorid = dt.Rows[0]["distributorID"].ToString();

                    string com = SQL_DB.ExecuteScalar("select case when count(Comp_Name)=0 then 'comp' else max(Comp_Name) end Comp_Name from m_dealermaster md inner join comp_reg cr on cr.Comp_ID=md.Comp_id where dealercode='" + distributorid + "'").ToString();

                    if (com == "JOHNSON PAINTS CO.")

                    {

                        flg = true;

                    }

                }

            }

        }

        DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("dashboarddata", Convert.ToInt32(Session["M_ConsumeriD"]), distributorid);

        DataTable dtrecord = new DataTable();
        //int claimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [ClaimDetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.[User_ID]='" + Session["USRID"].ToString() + "' and (cl.Isapproved=1)"));
        string consumerMobileno = string.Empty;
        int UPIclaimapply = 0;
        #region Cash reedemtion 
        int Cashredeem = 0;
        DataTable dtconsumer = SQL_DB.ExecuteDataTable("select top 1 *from M_Consumer where M_Consumerid='" + Session["M_ConsumeriD"].ToString() + "' and IsDelete=0");
        if (dtconsumer.Rows.Count > 0)
        {
            consumerMobileno = dtconsumer.Rows[0]["mobileno"].ToString();
            if (Session["Comp_id"].ToString() == "Comp-1722")
            {
                Cashredeem = Convert.ToInt32(SQL_DB.ExecuteScalar("select isnull(sum(Amount),0) from paytmtransaction where pstatus='Success' and Rec_code1 is not null  and Rec_code2 is not null  and compId='" + Session["Comp_id"].ToString() + "'and mobileno='"+ consumerMobileno + "'"));
            }
        }
        #endregion
        if (Session["Comp_id"].ToString() == "Comp-1673")
        { 
            UPIclaimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [tblupitransactiondetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.[User_ID]='" + Session["USRID"].ToString() + "' and (cl.status='Success') and cl.Code1 <> '' and cl.Code2 <>''"));
        }
       


        int claimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [ClaimDetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.[User_ID]='" + Session["USRID"].ToString() + "' and (cl.Isapproved=1)"));

        claimapply = claimapply + UPIclaimapply;

        lblUser_name.Text = Reg.ConsumerName;

        lblttlcode.Text = dtTrans.Tables[0].Rows[0][0].ToString();

        lblgiftrec.Text = (Convert.ToInt32(dtTrans.Tables[0].Rows[1][0].ToString()) + claimapply+ Cashredeem).ToString();

        lblsuccesscode.Text = dtTrans.Tables[0].Rows[2][0].ToString();

        lblunsuccess.Text = (Convert.ToInt32(lblttlcode.Text) - Convert.ToInt32(lblsuccesscode.Text)).ToString();

        //select sum(loyalty) from scrap_entry se inner join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2 inner join m_consumer ms on ms.MobileNo=pe.MobileNo where ms.M_Consumerid=8777

        string loyalty_return = SQL_DB.ExecuteScalar("select isnull(sum(loyalty),0) from scrap_entry se inner join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2 inner join m_consumer ms on ms.MobileNo=pe.MobileNo where pe.Is_Success=1 and ms.M_Consumerid= " + Session["M_ConsumeriD"]).ToString();

        //dtrecord = SQL_DB.ExecuteDataTable("SELECT case when Sum(convert(int,[Points])) is null then 0 else Sum(convert(int,[Points])) end, case when Sum(convert(int,[Cash])) is null then 0 else Sum(convert(int,[Cash])) end ,Count([Gift]) FROM [BLoyaltyPointsEarned] where [M_Consumerid]= " + Session["M_ConsumeriD"]);

        if (flg)

        {

            #region //** For updated wallet balance query for JPC

            DataSet ds = ExecuteNonQueryAndDatatable.FillTransactions("JPCWalletbalanceConsumerwise", Convert.ToInt32(Session["M_ConsumeriD"]), distributorid);

            dtrecord = ds.Tables[0];

            //dtrecord = SQL_DB.ExecuteDataTable("select (SELECT case when Sum(convert(int,[Points])) is null then 0 else Sum(convert(int,[Points])) end FROM [BLoyaltyPointsEarned] where [M_Consumerid]= " + Session["M_ConsumeriD"] + "), isnull((case when Sum(convert(decimal(10,2),cash)) is null then 0 else Sum(convert(decimal(10,2),cash)) end)+((case when Sum(convert(decimal(10,2),cash)) is null then 0 else Sum(convert(decimal(10,2),Cash)) end)*(select top 1 calculation_value from loyalty_calculation where comp_id=max(mcon.compid))/100),0) ,Count([Gift]) from BLoyaltyPointsEarned bl inner join BuiltLoyaltyMCodeCheck blc on blc.Pkid=bl.BuildLoyaltyOrReferralMCodeCheckid inner join M_Consumer_M_Code mcon on  mcon.m_consumer_mcodeid=blc.m_consumer_mcodeid inner join m_code code on code.row_id=mcon.M_Codeid inner join Pro_Enq pe on pe.received_code1=code.code1 and pe.received_code2=code.code2 inner join enq_dealerid dealer on dealer.enq_id=pe.row_id inner join M_Consumer cons on cons.distributorID=dealer.dealerid where cons.M_Consumerid=" + Session["M_ConsumeriD"] + " and pe.is_success=1");
            #endregion

        }



        else

        {

            if (Session["Comp_id"].ToString() == "Comp-1466")
            {
                reward.Visible = true;
                dtrecord = SQL_DB.ExecuteDataTable("SELECT case when Sum(convert(int,[Points])) is null then 0 else Sum(convert(int,[Points])) end, case when Sum(convert(int,[Cash])) is null then 0 else Sum(convert(int,[Cash])) end ,Count([Gift]) FROM [BLoyaltyPointsEarned] where [M_Consumerid]= " + Session["M_ConsumeriD"]);
            }
            else
            {
                dtrecord = SQL_DB.ExecuteDataTable("SELECT case when Sum(convert(int,[Points])) is null then 0 else Sum(convert(int,[Points])) end, case when Sum(convert(int,[Cash])) is null then 0 else Sum(convert(int,[Cash])) end ,Count([Gift]) FROM [BLoyaltyPointsEarned] where [M_Consumerid]= " + Session["M_ConsumeriD"]);
            }

            //  dtrecord = SQL_DB.ExecuteDataTable("SELECT case when Sum(convert(int,[Points])) is null then 0 else Sum(convert(int,[Points])) end, case when Sum(convert(int,[Cash])) is null then 0 else Sum(convert(int,[Cash])) end ,Count([Gift]) FROM [BLoyaltyPointsEarned] where [M_Consumerid]= " + Session["M_ConsumeriD"]);

        }

        lblcashback.Text = dtrecord.Rows[0][1].ToString();

        string cashredeem = dtTrans.Tables[0].Rows[3][0].ToString();




        if (cashredeem == "")

            lblredeem.Text = "0";

        else

            lblredeem.Text = cashredeem;

        int loyaltybonus = 0;

        //int totalpoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum([Points]) is null then 0 else Sum([Points]) end as point FROM [BLoyaltyPointsEarned] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[M_Consumerid] where mc.[User_ID]='" + Session["USRID"].ToString() + "'"));



        loyaltybonus = Convert.ToInt32(SQL_DB.ExecuteScalar("select isnull(sum(points),0) as points from buildloyalty_offers where m_consumerid=" + Session["M_ConsumeriD"]).ToString());



        lblcashbalance.Text = (Convert.ToDecimal(lblcashback.Text) - Convert.ToDecimal(lblredeem.Text)).ToString();

        lblgift.Text = ((Convert.ToInt32(dtrecord.Rows[0][0].ToString()) - Convert.ToInt32(loyalty_return)) + loyaltybonus).ToString();

        lblpointbalance.Text = (Convert.ToInt32(lblgift.Text) - Convert.ToInt32(lblgiftrec.Text)).ToString();

        dtrecord.Clear();



        #region //* To optimize query to make fast login process Deep Shukla
        //dtrecord = SQL_DB.ExecuteDataTable("select wr.* from [WarrentyDetails] wr inner join [M_consumer] Con on Con.[MobileNo]LIKE CONCAT('%', wr.[Mobile]) where Con.[M_Consumerid]=" + Session["M_ConsumeriD"] + "and wr.[Mobile]<>''");
        dtrecord = SQL_DB.ExecuteDataTable("select  wr.* from [WarrentyDetails] wr where wr.[Mobile]<>'' and wr.[Mobile] like CONCAT('%', (Select [MobileNo]  from [M_consumer] where [M_Consumerid]=" + Session["M_ConsumeriD"] + "))");
        #endregion

        DataRow[] warranty = dtrecord.Select("PurchaseDate>='" + DateTime.Today.AddYears(-1) + "'");

        lblwarranty.Text = dtrecord.Rows.Count.ToString();

        lblvalid.Text = warranty.Length.ToString();



        /////////////////////

        #region //* Optimize this query to make fast login process Deep Shukla
        // DataTable companies = SQL_DB.ExecuteDataTable("select distinct pr.[Comp_id] from(select pe.[Received_Code1], pe.[Received_Code2] from pro_enq pe left join m_consumer m on pe.[MobileNo] = m.[MobileNo] where m.[m_consumerid] =" + Session["M_ConsumeriD"] + ") as l left join m_code mc on l.[Received_Code1] =convert(nvarchar(15), mc.[code1]) and l.[Received_Code2] =convert(nvarchar(15), mc.[code2]) left join[Pro_reg] pr on pr.[Pro_id] = mc.[Pro_id]");
        DataTable companies = SQL_DB.ExecuteDataTable("select distinct pr.[Comp_id] from(select pe.[Received_Code1], pe.[Received_Code2] from pro_enq pe left join m_consumer m on pe.[MobileNo] = m.[MobileNo] where m.[m_consumerid] =" + Session["M_ConsumeriD"] + ") as l left join(select Code1, Code2, Pro_ID from M_Code where Use_Count > 0) mc on l.[Received_Code1] = convert(nvarchar(15), mc.[code1]) and l.[Received_Code2] = convert(nvarchar(15), mc.[code2])left join[Pro_reg] pr on pr.[Pro_id] = mc.[Pro_id]");
        #endregion


        string innerhtml = "";

        foreach (DataRow item in companies.Rows)

        {

            if (item[0].ToString() != "" & System.IO.File.Exists(Server.MapPath("/img/clients/" + item[0].ToString() + ".png")))

            {

                innerhtml = innerhtml + "<div class='col-md-12 col-lg-2' runat='server'  style='cursor:pointer'><div class='card'><div class='card-block text-center'><img id='" + item[0].ToString() + "' src='../img/clients/" + item[0].ToString() + ".png' style='width:100%; height:150px' onclick='gotosummary(this)'/></div></div></div>";

            }

        }

        comapnies.InnerHtml = innerhtml;

        ////////////////////////




        if (Session["Comp_id"].ToString() == "Comp-1388")
        {
            logo.Visible = false;
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








}