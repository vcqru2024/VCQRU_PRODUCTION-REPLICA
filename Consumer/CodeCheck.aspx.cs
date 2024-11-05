using Business_Logic_Layer;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1;

public partial class CodeCheck : System.Web.UI.Page
{
    User_Details Reg = new User_Details();
   
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Request.QueryString["app"] != null)
        {

            code.Value = Request.QueryString["code"];

            User_Details Log = new User_Details();
            
            if(Request.QueryString["uid"].Length==10)
            {
                Log.User_ID ="91"+Request.QueryString["uid"];
            }
            else
            {
                Log.User_ID = Request.QueryString["uid"];
            }
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            Session["USRID"] = dt.Rows[0]["User_ID"].ToString();
            Session["M_ConsumeriD"] = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
            Session["User_Type"] = "Consumer";
            //userdetails();
        }
       else if (Session["Consumer_id"] == null)
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
                //userdetails();
            }
        }


        hdndate1.Value = DateTime.Now.ToString("dd/MM/yyyy");
       
        Reg.User_ID = Session["USRID"].ToString();
                User_Details.FillUpDateProfile(Reg);
        mobilenumber.Value= Reg.MobileNo.Substring(Reg.MobileNo.Length - 10, 10);
        techninicianid.Value = Reg.MMEmployeID;
        dealercode.Value = Reg.MMDistributorID;
        lblUser_name.Text = Reg.ConsumerName;

        if (Session["Login"]!=null )
        {
            if (Session["Login"].ToString() == "1")
            {
               //userdetails();
                Session["Login"] = "0";
            }
        }
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

    }
	
     public void userdetails()
    {
        string ipAddress = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (string.IsNullOrEmpty(ipAddress))
        {
            ipAddress = Request.ServerVariables["REMOTE_ADDR"];
        }


        string url = "https://api.ip2location.com/v2/?ip=" + ipAddress + "&key=5QX2GKT5BA&package=WS9";

        ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;

        HttpWebRequest http = (HttpWebRequest)HttpWebRequest.Create(url);


        HttpWebResponse response = (HttpWebResponse)http.GetResponse();
        using (StreamReader sr = new StreamReader(response.GetResponseStream()))
        {
            string json = sr.ReadToEnd();
            Location location = new JavaScriptSerializer().Deserialize<Location>(json);
            List<Location> locations = new List<Location>();
            locations.Add(location);
            SQL_DB.ExecuteNonQuery("insert into userDetails values('" + Reg.Consumer_ID + "','" + location.city_name + "','" + location.region_name + "','" + location.country_name + "','" + location.country_code + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "','" + ipAddress + "','" + location.zip_code + "','" + location.latitude + "','" + location.longitude + "')");

        }




}
    }