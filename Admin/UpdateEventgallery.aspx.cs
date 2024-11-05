using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_UpdateEventgallery : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            NewMsgpop.Visible = false;

            if (Request.QueryString["evid"] != null)
            {
                string evid = Request.QueryString["evid"];

                string mid = Convert.ToString(Request.QueryString["evid"]);
                DataTable dt = new DataTable();
                string strr2 = "select * from tbl_event where id = '" + evid + "' order by id desc";
                dt = SQL_DB.ExecuteDataTable(strr2);
                if (dt.Rows.Count > 0)
                {

                        event_nameGallery.Text = dt.Rows[0]["event_name"].ToString().Trim(); ;
                        event_city.Text = dt.Rows[0]["event_city"].ToString().Trim(); ;
                        event_address.Text = dt.Rows[0]["event_address"].ToString().Trim(); ;
                        txtDate.Text = dt.Rows[0]["event_date"].ToString().Trim(); ;
                        from_date.Text = dt.Rows[0]["from_date"].ToString().Trim(); ;
                   // string ddtTo = dt.Rows[0]["to_date"].ToString().Trim();
                        to_date.Text = dt.Rows[0]["to_date"].ToString().Trim();
                    //to_date.Text = "2019-11-30";
                    txtContent.Text = dt.Rows[0]["event_content"].ToString().Trim(); ;
                        HiddenField1.Value = dt.Rows[0]["id"].ToString();

                    eventimg_1.ImageUrl = "~/" + dt.Rows[0]["imgpath"].ToString();
                    eventimg_2.ImageUrl = "~/" + dt.Rows[0]["img_1"].ToString();
                    eventimg_3.ImageUrl = "~/" + dt.Rows[0]["img_2"].ToString();
                    eventimg_4.ImageUrl = "~/" + dt.Rows[0]["img_3"].ToString();
                    eventimg_5.ImageUrl = "~/" + dt.Rows[0]["img_4"].ToString();
                    eventimg_6.ImageUrl = "~/" + dt.Rows[0]["img_5"].ToString();
                }
                else
                {

                }
            }

        }


    }

    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        //SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
       // con.Open();


        if (event_nameGallery.Text != "" && HiddenField1.Value != "")
        {
            string result = string.Empty;
            DataTable dt = new DataTable();
            string strr2 = "select id from tbl_event where id = '" + HiddenField1.Value + "' order by id desc";
            dt = SQL_DB.ExecuteDataTable(strr2);
            if (dt.Rows.Count > 0)
            {
                SQL_DB.ExecuteNonQuery("update tbl_event set event_name='" + event_nameGallery.Text + "', event_city='" + event_city.Text + "', event_address='" + event_address.Text + "', event_date='" + txtDate.Text + "', from_date='" + from_date.Text + "', to_date='" + to_date.Text + "', event_content='" + txtContent.Text + "'  where id='" + HiddenField1.Value + "'");

                if (Path.GetFileName(eventimg.FileName) != "")
                {
                    eventimg.SaveAs(Server.MapPath("~/assets/images/gallery/") + Path.GetFileName(eventimg.FileName));
                    string imgpath = "/assets/images/gallery/" + Path.GetFileName(eventimg.FileName);
                    SQL_DB.ExecuteNonQuery("UPDATE tbl_event set imgpath='" + imgpath.ToString() + "' where id = '" + HiddenField1.Value + "' ");
                }
                if (Path.GetFileName(img_2.FileName) != "")
                {
                    img_2.SaveAs(Server.MapPath("~/assets/images/gallery/") + Path.GetFileName(img_2.FileName));
                    string imgpath2 = "/assets/images/gallery/" + Path.GetFileName(img_2.FileName);
                    SQL_DB.ExecuteNonQuery("UPDATE tbl_event set img_1='" + imgpath2.ToString() + "' where id = '" + HiddenField1.Value + "' ");
                }
                if (Path.GetFileName(img_3.FileName) != "")
                {
                    img_3.SaveAs(Server.MapPath("~/assets/images/gallery/") + Path.GetFileName(img_3.FileName));
                    string imgpath3 = "/assets/images/gallery/" + Path.GetFileName(img_3.FileName);
                    SQL_DB.ExecuteNonQuery("UPDATE tbl_event set img_2='" + imgpath3.ToString() + "' where id = '" + HiddenField1.Value + "' ");
                }
                if (Path.GetFileName(img_4.FileName) != "")
                {
                    img_4.SaveAs(Server.MapPath("~/assets/images/gallery/") + Path.GetFileName(img_4.FileName));
                    string imgpath4 = "/assets/images/gallery/" + Path.GetFileName(img_4.FileName);
                    SQL_DB.ExecuteNonQuery("UPDATE tbl_event set img_3='" + imgpath4.ToString() + "' where id = '" + HiddenField1.Value + "' ");
                }
                if (Path.GetFileName(img_5.FileName) != "")
                {
                    img_5.SaveAs(Server.MapPath("~/assets/images/gallery/") + Path.GetFileName(img_5.FileName));
                    string imgpath5 = "/assets/images/gallery/" + Path.GetFileName(img_5.FileName);
                    SQL_DB.ExecuteNonQuery("UPDATE tbl_event set img_4='" + imgpath5.ToString() + "' where id = '" + HiddenField1.Value + "' ");
                }
                if (Path.GetFileName(img_6.FileName) != "")
                {
                    img_6.SaveAs(Server.MapPath("~/assets/images/gallery/") + Path.GetFileName(img_6.FileName));
                    string imgpath6 = "/assets/images/gallery/" + Path.GetFileName(img_6.FileName);
                    SQL_DB.ExecuteNonQuery("UPDATE tbl_event set img_5='" + imgpath6.ToString() + "' where id = '" + HiddenField1.Value + "' ");
                }

                NewMsgpop.Visible = true;
                LblMsgUpdate.Text = "Record update Successfully!";
            }
        }
        else
        {
            NewMsgpop.Visible = true;
            LblMsgUpdate.Text = "Please select mandatory field!";
        }

    }

    protected void btnReset_Click(object sender, EventArgs e)
    {

        Response.Redirect("GalleryNew.aspx");
    }

}