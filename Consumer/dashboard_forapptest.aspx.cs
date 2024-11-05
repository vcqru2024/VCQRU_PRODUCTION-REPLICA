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

public partial class Consumer_dashboard :  System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["app"] == "1")
            {
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
        DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("dashboarddata", Convert.ToInt32(Session["M_ConsumeriD"]));
        DataTable dtrecord = new DataTable();
        lblUser_name.Text = Reg.ConsumerName;
        lblttlcode.Text = dtTrans.Tables[0].Rows[0][0].ToString(); 
        lblgiftrec.Text= dtTrans.Tables[0].Rows[1][0].ToString();
        lblsuccesscode.Text= dtTrans.Tables[0].Rows[2][0].ToString();
        lblunsuccess.Text = (Convert.ToInt32(lblttlcode.Text) - Convert.ToInt32(lblsuccesscode.Text)).ToString();
        //select sum(loyalty) from scrap_entry se inner join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2 inner join m_consumer ms on ms.MobileNo=pe.MobileNo where ms.M_Consumerid=8777
       string  loyalty_return = SQL_DB.ExecuteScalar("select isnull(sum(loyalty),0) from scrap_entry se inner join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2 inner join m_consumer ms on ms.MobileNo=pe.MobileNo where pe.Is_Success=1 and ms.M_Consumerid= " + Session["M_ConsumeriD"]).ToString();
        dtrecord = SQL_DB.ExecuteDataTable("SELECT case when Sum(convert(int,[Points])) is null then 0 else Sum(convert(int,[Points])) end, case when Sum(convert(int,[Cash])) is null then 0 else Sum(convert(int,[Cash])) end ,Count([Gift]) FROM [BLoyaltyPointsEarned] where [M_Consumerid]= " + Session["M_ConsumeriD"]);
   lblcashback.Text= dtrecord.Rows[0][1].ToString();
      string cashredeem = dtTrans.Tables[0].Rows[3][0].ToString();
       if (cashredeem == "")
            lblredeem.Text = "0";
        else
            lblredeem.Text = cashredeem;

       lblcashbalance.Text= (Convert.ToInt32(lblcashback.Text) - Convert.ToInt32(lblredeem.Text)).ToString();
        lblgift.Text= (Convert.ToInt32(dtrecord.Rows[0][0].ToString())- Convert.ToInt32(loyalty_return)).ToString();
        lblpointbalance.Text= (Convert.ToInt32(lblgift.Text) - Convert.ToInt32(lblgiftrec.Text)).ToString();
        dtrecord.Clear();
        dtrecord = SQL_DB.ExecuteDataTable("select wr.* from [WarrentyDetails] wr inner join [M_consumer] Con on Con.[MobileNo]LIKE CONCAT('%', wr.[Mobile]) where Con.[M_Consumerid]=" + Session["M_ConsumeriD"]+ "and wr.[Mobile]<>''");
      DataRow[] warranty= dtrecord.Select("PurchaseDate>='" + DateTime.Today.AddYears(-1)+"'");
        lblwarranty.Text = dtrecord.Rows.Count.ToString();
        lblvalid.Text = warranty.Length.ToString();

        ///////////////////// 
        DataTable companies = SQL_DB.ExecuteDataTable("select distinct pr.[Comp_id] from(select pe.[Received_Code1], pe.[Received_Code2] from pro_enq pe left join m_consumer m on pe.[MobileNo] = m.[MobileNo] where m.[m_consumerid] =" + Session["M_ConsumeriD"] + ") as l left join m_code mc on l.[Received_Code1] =convert(nvarchar(15), mc.[code1]) and l.[Received_Code2] =convert(nvarchar(15), mc.[code2]) left join[Pro_reg] pr on pr.[Pro_id] = mc.[Pro_id]");
        string innerhtml = "";
        foreach (DataRow item in companies.Rows)
        {
            if (item[0].ToString() != "" & System.IO.File.Exists(Server.MapPath("/img/clients/" + item[0].ToString()+".png")))
            {
                innerhtml = innerhtml + "<div class='col-md-12 col-lg-2' runat='server'  style='cursor:pointer'><div class='card'><div class='card-block text-center'><img id='" + item[0].ToString() + "' src='../img/clients/" + item[0].ToString()+".png' style='width:100%; height:150px' onclick='gotosummary(this)'/></div></div></div>";
            }
        }
          comapnies.InnerHtml = innerhtml;
        ////////////////////////



    }
    protected void Logout(object sender, EventArgs e)
    {
        Session.Abandon();
        //Response.Redirect("../Home/Index.aspx");
        Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "index.html");
    }



   



   
}