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

public partial class FrmNewsUpdate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmNewsUpdate.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {
            NewUpDate.FillGrid(GridView1);
            if (GridView1.Rows.Count > 0)
                lblcount.Text = GridView1.Rows.Count.ToString();
            else
                lblcount.Text = "0";
        }
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        NewUpDate mnews = new NewUpDate();
        mnews.News = Editor1.Content.Trim().Replace("''", "'").Replace("'", "''");
        mnews.Entry_Date = Convert.ToDateTime("01/01/1999");
        mnews.Updated_Date1 = Convert.ToDateTime("01/01/1999");
        mnews.New_Heading = Editor2.Content.Trim().Replace("''", "'").Replace("'", "''");
        if (btnsave.Text == "Save")
        {
            NewUpDate.NewsEntry(mnews);
            NewUpDate.FillGrid(GridView1);
            if (GridView1.Rows.Count > 0)
                lblcount.Text = GridView1.Rows.Count.ToString();
            else
                lblcount.Text = "0";
            divmsg.Visible = true;
            divmsg.Attributes.Add("class", "alert_boxes_green big_msg");
            lblmsg.Text = "Record Saved Successfully...";
            string script = @"setTimeout(function(){document.getElementById('" + divmsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);            
        }
        else
        {
            mnews.Tbl_Id = Convert.ToInt32(lblid.Text.Trim());
            NewUpDate.NewsEntryUpdate(mnews);
            divmsg.Visible = true;
            divmsg.Attributes.Add("class", "alert_boxes_green big_msg");
            lblmsg.Text = "Record Update Successfully.";
            string script = @"setTimeout(function(){document.getElementById('" + divmsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);            
            lblid.Text = "0";
        }
        NewUpDate.FillGrid(GridView1);
        if (GridView1.Rows.Count > 0)
            lblcount.Text = GridView1.Rows.Count.ToString();
        else
            lblcount.Text = "0";
        Editor1.Content = string.Empty;
        Editor2.Content = string.Empty;
        lblConmsg.Text = string.Empty;
        btnsave.Text = "Save";
    }
    protected void btncancel_Click(object sender, EventArgs e)
    {
        divmsg.Visible = false;
        Editor1.Content = string.Empty;
        Editor2.Content = string.Empty;
        lblConmsg.Text = string.Empty;
        btnsave.Text = "Save";
        lblmsg.Text = string.Empty;
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        divmsg.Visible = false;
        if (e.CommandName.ToString() == "EditRow")
        {
            lblConmsg.Text = "";
            DataSet ds = new DataSet();
            NewUpDate NewUpdt = new NewUpDate();
            NewUpdt.Tbl_Id = Convert.ToInt16(e.CommandArgument);
            ds = NewUpDate.FillDataUpDate(NewUpdt);
            Editor1.Content = ds.Tables[0].Rows[0]["news"].ToString();
            Editor2.Content = ds.Tables[0].Rows[0]["News_heading"].ToString();
            lblid.Text = e.CommandArgument.ToString();
            btnsave.Text = "Update";
        }
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        NewUpDate.FillGrid(GridView1);
        if (GridView1.Rows.Count > 0)
            lblcount.Text = GridView1.Rows.Count.ToString();
        else
            lblcount.Text = "0";
    }
    protected void ImageButton1_Click(object sender, EventArgs e)
    {
        if (Request.Form["chkselect"] == null)
        {
            lblConmsg.Text = "Select News First";
            return;
        }
        else
        {
            SQL_DB.ExecuteNonQuery("delete from  News_tab where  tbl_id in (" + Request.Form["chkselect"].ToString() + ")");
            divmsg.Visible = true;
            divmsg.Attributes.Add("class", "alert_boxes_green big_msg");
            lblmsg.Text = "News Deleted Successfully.";
            string script = @"setTimeout(function(){document.getElementById('" + divmsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);           
            NewUpDate.FillGrid(GridView1);
            if (GridView1.Rows.Count > 0)
                lblcount.Text = GridView1.Rows.Count.ToString();
            else
                lblcount.Text = "0";
        }
    }
    protected void ImageButton2_Click(object sender, EventArgs e)
    {
        if (Request.Form["chkselect"] == null)
        {
            lblConmsg.Text = "Select News First";
            return;
        }
        else
        {
            SQL_DB.ExecuteNonQuery("UPDATE [News_tab]  SET [Act_Flag] = (case when [Act_Flag]=1 then 0 else 1 end) WHERE tbl_id in (" + Request.Form["chkselect"].ToString() + ")");
            divmsg.Visible = true;
            divmsg.Attributes.Add("class", "alert_boxes_green big_msg");
            lblmsg.Text = "News Status Changed Successfully.";
            string script = @"setTimeout(function(){document.getElementById('" + divmsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);            
            NewUpDate.FillGrid(GridView1);
            if (GridView1.Rows.Count > 0)
                lblcount.Text = GridView1.Rows.Count.ToString();
            else
                lblcount.Text = "0";
        }
    }
}
