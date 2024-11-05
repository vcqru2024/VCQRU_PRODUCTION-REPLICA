using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
public partial class Manufacturer_BannerVcqru : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("select * from Tbl_bannerVcqru where compid='"+ Session["CompanyId"].ToString() + "' order by ID desc", con);
        System.Data.DataSet ds = new System.Data.DataSet();
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        sda.Fill(ds);
        rewards.DataSource = ds;
        rewards.DataBind();
        con.Close();
    }


    protected void rewards_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
        con.Open();
        if (e.CommandName == "Delete")
        {
            string delserid = e.CommandArgument.ToString();
            //Response.Write("<script>alert('" + delserid + "')</script>");
            SqlCommand cmd_display = new SqlCommand("select * from Tbl_bannerVcqru where ID='" + delserid + "' order by ID desc", con);
            SqlDataReader sdr = cmd_display.ExecuteReader();
            if (sdr.Read())
            {
                //string filePath = sdr["ImagePath"].ToString();
                var filePath = Server.MapPath("~/" + sdr["ImagePath"].ToString());
                if (File.Exists(filePath))
                {
                    File.Delete(filePath);
                }
                // Response.Write("<script>alert('" + uimg + "')</script>");   
            }
            con.Close();
            con.Open();
            SqlCommand cmd = new SqlCommand("DELETE FROM Tbl_bannerVcqru WHERE ID='" + delserid + "'", con);
            cmd.ExecuteNonQuery();

            con.Close();
            Response.Redirect("BannerVcqru.aspx");
            //Response.Write("<script>alert('Reward successfully deleted')</script>");
            // Response.Redirect("hos-services.aspx");
        }
    }
}