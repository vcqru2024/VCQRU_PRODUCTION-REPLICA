using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_UploadBannersVcqru : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void add_blog_Click1(object sender, EventArgs e)
    {
        //SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconnect"].ConnectionString);
        //con.Open();
        blgimg.SaveAs(Server.MapPath("~/assets/images/Vcqru") + Path.GetFileName(blgimg.FileName));
        string imgpath = "assets/images/Vcqru" + Path.GetFileName(blgimg.FileName);
        //SqlCommand cmd = new SqlCommand("insert into add_blog(utblid,uloginid,title,author,blgimg,txarea) values('" + Session["prid"] + "','" + Session["loginUser"] + "','" + title.Value + "','" + author.Value + "','" + blgimg.FileName + "','" + txarea.Value + "')", con);
        //cmd.ExecuteNonQuery();
        //Response.Write("<script>alert('Blog has been successfully added')</script>");
        //con.Close();
        //clearFielddata();

        SQL_DB.ExecuteNonQuery("INSERT INTO Tbl_bannerVcqru (ImagePath,compid)values('" + imgpath + "','"+ Session["CompanyId"].ToString() + "')");
        Response.Redirect("BannerVcqru.aspx");
        //Response.Write("<script>alert('Reward successfully added!')</script>");
    }
}