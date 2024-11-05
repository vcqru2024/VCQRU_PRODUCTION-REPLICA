using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_uploadrewardsvrkabel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
protected void btnReset_Click(object sender, EventArgs e)
    {
        Response.Redirect("RewardsVrkabel.aspx");
    }
    protected void add_blog_Click1(object sender, EventArgs e)
    {
        if(blgimg.FileName!=""){
        blgimg.SaveAs(Server.MapPath("~/assets/images/vrkabel/") + Path.GetFileName(blgimg.FileName));
        string imgpath = "assets/images/vrkabel/" + Path.GetFileName(blgimg.FileName);
        //SqlCommand cmd = new SqlCommand("insert into add_blog(utblid,uloginid,title,author,blgimg,txarea) values('" + Session["prid"] + "','" + Session["loginUser"] + "','" + title.Value + "','" + author.Value + "','" + blgimg.FileName + "','" + txarea.Value + "')", con);
        //cmd.ExecuteNonQuery();
        //Response.Write("<script>alert('Blog has been successfully added')</script>");
        //con.Close();
        //clearFielddata();

        SQL_DB.ExecuteNonQuery("INSERT INTO Tbl_OfferVrKabel (ImagePath)values('" + imgpath + "')");
        Response.Redirect("RewardsVrkabel.aspx");
}else{
//Response.Write("<script>alert('Reward successfully added!')</script>");
}
        
    }
}