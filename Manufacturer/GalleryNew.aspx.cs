using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Data;

public partial class Admin_GalleryNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

    public void actionfire()
    {
        if (!Page.IsPostBack)
        {
            NewMsgpop.Visible = true;


            if (Request.QueryString["evid"] != null)
            {

                string evid = Convert.ToString(Request.QueryString["evid"]);
                // string evid = Convert.ToString(Request.QueryString["evid"]);
                DataTable dt = new DataTable();

                string strr2 = "select id,is_activee,imgpath,img_1,img_2,img_3,img_4,img_5 from tbl_event where id = '" + evid + "' order by id desc";

                dt = SQL_DB.ExecuteDataTable(strr2);
                string status = dt.Rows[0]["is_activee"].ToString();
                if (status == "1")
                {
                    status = "0";
                }
                else if (status == "0")
                {
                    status = "1";
                }
                else
                {
                    status = "0";
                }
                string defaultimg = "/assets/images/gallery/default.JPG";
                if (dt.Rows[0]["img_1"].ToString() == "" || dt.Rows[0]["img_2"].ToString() == "" || dt.Rows[0]["img_3"].ToString() == "" || dt.Rows[0]["img_4"].ToString() == "" || dt.Rows[0]["img_5"].ToString() == "" || dt.Rows[0]["imgpath"].ToString() == "" || dt.Rows[0]["img_1"].ToString() == defaultimg || dt.Rows[0]["img_2"].ToString() == defaultimg || dt.Rows[0]["img_3"].ToString() == defaultimg || dt.Rows[0]["img_4"].ToString() == defaultimg || dt.Rows[0]["img_5"].ToString() == defaultimg || dt.Rows[0]["imgpath"].ToString() == defaultimg)
                {
                    NewMsgpop.Visible = true;
                    LblMsgUpdate.Text = "Please upload all images this record for active event!";
                    status = "0";
                    // ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
                    //"<script>alert('Please upload all images!')</script>");

                }

                if (dt.Rows.Count > 0)
                {
                    //txtName.Text = dt.Rows[0]["ConsumerName"].ToString();
                    SQL_DB.ExecuteNonQuery("update tbl_event set is_activee='" + status + "'  where id='" + evid + "'");

                    // Response.Redirect("GalleryNew.aspx");
                }
                else
                {

                }
            }

            if (Request.QueryString["delid"] != null)
            {

                string delid = Convert.ToString(Request.QueryString["delid"]);
                string strr23 = "delete from tbl_event where id = '" + delid + "' ";

                SQL_DB.ExecuteNonQuery(strr23);
                Response.Redirect("GalleryNew.aspx");
            }



            try
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
                con.Open();
                SqlCommand cmd1 = new SqlCommand("select id,imgpath,event_name,event_date,img_1,img_2,img_3,img_4,img_5,event_city,event_address, case when is_activee='1' then 'Active' when is_activee='0' then 'Deactive'  else 'Deactive' end  EventStatus  from tbl_event  order by id desc", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd1);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                grd1.DataSource = dt;
                grd1.DataBind();


                con.Open();
                SqlCommand cmd_event = new SqlCommand("select id,event_name from tbl_event", con);
                DropDownList1.DataSource = cmd_event.ExecuteReader();
                DropDownList1.DataTextField = "event_name";
                DropDownList1.DataValueField = "id";
                DropDownList1.DataBind();
                DropDownList1.Items.Insert(0, new ListItem("--Select Event--", "0"));
                con.Close();




            }
            catch (Exception ex)
            {
                Response.Write(ex.Message.ToString());
            }
        }
    }
   
    protected void event_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
        con.Open();
        if (e.CommandName == "Delete")
        {
            string delserid = e.CommandArgument.ToString();
            //Response.Write("<script>alert('" + delserid + "')</script>");
            SqlCommand cmd_display = new SqlCommand("select * from tbl_event is_activee='1' order by id desc", con);
            SqlDataReader sdr = cmd_display.ExecuteReader();
            if (sdr.Read())
            {
                //string filePath = sdr["ImagePath"].ToString();
                var filePath = Server.MapPath("~/" + sdr["imgpath"].ToString());
                if (File.Exists(filePath))
                {
                    File.Delete(filePath);
                }
                // Response.Write("<script>alert('" + uimg + "')</script>");   
            }
            con.Close();
            con.Open();
            SqlCommand cmd = new SqlCommand("DELETE FROM tbl_event WHERE id='" + delserid + "'", con);
            cmd.ExecuteNonQuery();
           
                    con.Close();
            Response.Redirect("GalleryNew.aspx");
         
        }
    }

    
        protected void add_gallery_Click1(object sender, EventArgs e)
    {
       
        if (Path.GetFileName(blgimg.FileName) != "")
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
            con.Open();
            blgimg.SaveAs(Server.MapPath("~/assets/images/gallery/") + Path.GetFileName(blgimg.FileName));
            string imgpath = "/assets/images/gallery/" + Path.GetFileName(blgimg.FileName);
            var idd = DropDownList1.SelectedValue;
            SqlCommand cmd_display = new SqlCommand("select img_1,img_2,img_3,img_4,img_5 from tbl_event where id='" + idd + "'", con);
            SqlDataReader sdr = cmd_display.ExecuteReader();
           //string moreImages = "";
            if (sdr.Read())
            {
                //string filePath = sdr["ImagePath"].ToString();
                string defaultimg = "/assets/images/gallery/default.JPG";
                if (sdr["img_1"].ToString() == "" || sdr["img_1"].ToString() == defaultimg)
                {
                    SQL_DB.ExecuteNonQuery("UPDATE tbl_event set img_1='" + imgpath.ToString() + "' where id = '" + idd + "' ");
                    //moreImages = sdr["more_images"].ToString() + "," + imgpath.ToString();
                    Response.Redirect("GalleryNew.aspx");
                }
                else if (sdr["img_2"].ToString() == "" || sdr["img_2"].ToString() == defaultimg)
                {
                    SQL_DB.ExecuteNonQuery("UPDATE tbl_event set img_2='" + imgpath.ToString() + "' where id = '" + idd + "' ");
                    Response.Redirect("GalleryNew.aspx");
                }
                else if (sdr["img_3"].ToString() == "" || sdr["img_3"].ToString() == defaultimg)
                {
                    SQL_DB.ExecuteNonQuery("UPDATE tbl_event set img_3='" + imgpath.ToString() + "' where id = '" + idd + "' ");
                    Response.Redirect("GalleryNew.aspx");
                }
                else if (sdr["img_4"].ToString() == "" || sdr["img_4"].ToString() == defaultimg)
                {
                    SQL_DB.ExecuteNonQuery("UPDATE tbl_event set img_4='" + imgpath.ToString() + "' where id = '" + idd + "' ");
                    Response.Redirect("GalleryNew.aspx");
                }
                else if (sdr["img_5"].ToString() == "" || sdr["img_5"].ToString() == defaultimg)
                {
                    SQL_DB.ExecuteNonQuery("UPDATE tbl_event set img_5='" + imgpath.ToString() + "' where id = '" + idd + "' ");
                    Response.Redirect("GalleryNew.aspx");
                }
                else
                {
                    
                }
  
            }
           // SQL_DB.ExecuteNonQuery("INSERT INTO tbl_gallery (imgpath,event_id)values('" + imgpath + "','" + DropDownList1.SelectedValue + "')");
           
        }
        else
        {
            Response.Write("<script>alert('Upload gallery image!')</script>");
        }

        Response.Redirect("GalleryNew.aspx");
    }

    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        try { 
        if (event_nameGallery.Text !="" && Path.GetFileName(eventimg.FileName) != "") {
            string imgnm = "event_" + Path.GetFileName(eventimg.FileName);
            eventimg.SaveAs(Server.MapPath("~/assets/images/gallery/") + Path.GetFileName(eventimg.FileName));
            string eventimgPath = "/assets/images/gallery/" + Path.GetFileName(eventimg.FileName);
            string str1 = Server.HtmlEncode(txtContent.Text);
            //string str2 = Server.HtmlDecode(txtContent.Text);
            string editor = str1;
                string defaultImg = "/assets/images/gallery/default.JPG";

            SQL_DB.ExecuteNonQuery("INSERT INTO tbl_event (imgpath,event_name,event_city,event_address,event_content,event_date,from_date,to_date,img_1,img_2,img_3,img_4,img_5,is_activee)values('" + eventimgPath + "','" + event_nameGallery.Text + "','" + event_city.Text + "','" + event_address.Text + "','" + editor + "','"+ txtDate.Text + "','" + from_date.Text + "','" + to_date.Text + "','"+ defaultImg + "','" + defaultImg + "','" + defaultImg + "','" + defaultImg + "','" + defaultImg + "','0')");
        }
        else
        {
            Response.Write("<script>alert('Upload event image or select Event name!')</script>");
        }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        Response.Redirect("GalleryNew.aspx");

    }
}