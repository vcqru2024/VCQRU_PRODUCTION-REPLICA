using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Business_Logic_Layer;

public partial class admin_NewsUpdate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("../Login.aspx");  
        if (!IsPostBack)
            NewUpDate.FillGrid(GridView1);
    }
    protected void btnsave_Click(object sender, ImageClickEventArgs e)
    {
        NewUpDate mnews = new NewUpDate();
        mnews.News = Editor1.Content;
        mnews.Entry_Date = Convert.ToDateTime("01/01/1999");
        mnews.Updated_Date1 = Convert.ToDateTime("01/01/1999");
        mnews.New_Heading = Editor2.Content;
        if (btnsave.ImageUrl == "~/images/Button/save.png")
        {            
            NewUpDate.NewsEntry(mnews);
            NewUpDate.FillGrid(GridView1);
            lblmdg.Text = "Record Saved Successfully";
        }
        else
        {
            mnews.Tbl_Id =Convert.ToInt32(lblid.Text.Trim());
            NewUpDate.NewsEntryUpdate(mnews);            
            lblmdg.Text = "Record Update Successfully";
            lblid.Text = "0";
        }
        NewUpDate.FillGrid(GridView1);
        Editor1.Content = "";
        Editor2.Content = "";
        lblConmsg.Text = "";
        btnsave.ImageUrl = "~/images/Button/save.png";
    }
    protected void btncancel_Click(object sender, ImageClickEventArgs e)
    {
        Editor1.Content = "";
        Editor2.Content = "";
        lblConmsg.Text = "";
        btnsave.ImageUrl = "~/images/Button/save.png";
        lblmdg.Text = "";
        
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.ToString() == "EditRow")
        {
            lblConmsg.Text = "";
            DataSet ds = new DataSet();
            NewUpDate NewUpdt=new NewUpDate();
            NewUpdt.Tbl_Id= Convert.ToInt16(e.CommandArgument);
            ds = NewUpDate.FillDataUpDate(NewUpdt); 
            Editor1.Content = ds.Tables[0].Rows[0]["news"].ToString();
            Editor2.Content = ds.Tables[0].Rows[0]["News_heading"].ToString();
            lblid.Text = e.CommandArgument.ToString();
            btnsave.ImageUrl = "~/images/Button/update.png";
        }      
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        if (Request.Form["chkselect"] == null)
        {
            lblConmsg.Text = "Select News First";
            return;
        }
        else
        {
            //NewUpDate Del = new NewUpDate();
            //Del.Tbl_Id = Convert.ToInt32(Request.Form["chkselect"].ToString());
            //NewUpDate.DeleteNews(Del);
            SQL_DB.ExecuteNonQuery("delete from  News_tab where  tbl_id in (" + Request.Form["chkselect"].ToString() + ")");
            lblConmsg.Text = "News Deleted Successfully...";
            NewUpDate.FillGrid(GridView1);
        }
    }
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
        if (Request.Form["chkselect"] == null)
        {
            lblConmsg.Text = "Select News First";
            return;
        }
        else
        {
            //NewUpDate UFlag = new NewUpDate();
            //UFlag.Tbl_Id = Convert.ToInt32(Request.Form["chkselect"].ToString());
            //NewUpDate.NewsEntryUpdateFlag(UFlag); 
            SQL_DB.ExecuteNonQuery("UPDATE [News_tab]  SET [Act_Flag] = (case when [Act_Flag]=1 then 0 else 1 end) WHERE tbl_id in (" + Request.Form["chkselect"].ToString() + ")");
            lblConmsg.Text = "News Status Changed Successfully...";
            NewUpDate.FillGrid(GridView1);
        }
    }
}
