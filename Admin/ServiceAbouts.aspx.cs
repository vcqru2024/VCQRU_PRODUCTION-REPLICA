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

public partial class ServiceAbouts : System.Web.UI.Page
{
    public int index =0,IsVal =0;
    protected void Page_Load(object sender, EventArgs e)
    {
        ObjService Reg = new ObjService();
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=ServiceAbouts.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {
            cleartxt();
            ObjService.FillGrid(GridView1);
            if (GridView1.Rows.Count > 0)
                lblcount.Text = GridView1.Rows.Count.ToString();
            else
                lblcount.Text = "0";
        }
    }
    private void FillddlService(DropDownList ddl)
    {
        DataSet ds = ObjService.FillServiceddl();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Service_ID", "ServiceName", ddl, "--Select--");
        ddl.SelectedIndex = 0;
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        int counter = 0;
        ObjService Reg = new ObjService();
        Reg.AboutService = Editor1.Content.Trim().Replace("''", "'").Replace("'", "''");
        if (Reg.AboutService == "")
            counter++;
        Reg.Terms_Conditions = Editor2.Content.Trim().Replace("''", "'").Replace("'", "''");
        if (Reg.Terms_Conditions == "")
            counter++;
        Reg.Advantage = Editor3.Content.Trim().Replace("''", "'").Replace("'", "''");
        if (Reg.Advantage == "")
            counter++;
        if (counter > 2)
        {
            divmsg.Visible = true;
            divmsg.Attributes.Add("class", "alert_boxes_green big_msg");
            lblmsg.Text = "Please Enter Values.";
            string script = @"setTimeout(function(){document.getElementById('" + divmsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true); 
            return;
        }
        Reg.EntryDate = Convert.ToDateTime(DataProvider.LocalDateTime.Now);
        Reg.Service_ID = ddlService.SelectedValue.Trim().ToString();
        if (btnsave.Text == "Save")
        {
            ObjService.NewsEntry(Reg);            
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
            ObjService.NewsEntry(Reg);
            divmsg.Visible = true;
            divmsg.Attributes.Add("class", "alert_boxes_green big_msg");
            lblmsg.Text = "Record Update Successfully.";
            string script = @"setTimeout(function(){document.getElementById('" + divmsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);            
            lblid.Text = "0";
        }
        ObjService.FillGrid(GridView1);
        if (GridView1.Rows.Count > 0)
            lblcount.Text = GridView1.Rows.Count.ToString();
        else
            lblcount.Text = "0";
        cleartxt();        
    }
    protected void btncancel_Click(object sender, EventArgs e)
    {
        cleartxt();        
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        cleartxt();
        lblid.Text = e.CommandArgument.ToString();
        divmsg.Visible = false;
        ObjService NewUpdt = new ObjService();
        if (e.CommandName.ToString() == "EditRow")
        {            
            lblConmsg.Text = "";
            DataSet ds = new DataSet();            
            NewUpdt.Row_ID = Convert.ToInt16(e.CommandArgument);
            ds = ObjService.FillDataUpDate(NewUpdt);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlService.SelectedValue = ds.Tables[0].Rows[0]["Service_ID"].ToString();
                Editor1.Content = ds.Tables[0].Rows[0]["AboutService"].ToString();
                Editor2.Content = ds.Tables[0].Rows[0]["Terms_Conditions"].ToString();
                Editor3.Content = ds.Tables[0].Rows[0]["Advantage"].ToString();                
                btnsave.Text = "Update";
            }
        }
        if (e.CommandName.ToString() == "DeleteRows")
        {
            NewUpdt.Row_ID = Convert.ToInt32(e.CommandArgument.ToString());
            ObjService.DeleteRecords(NewUpdt);
            divmsg.Visible = true;
            divmsg.Attributes.Add("class", "alert_boxes_green big_msg");
            lblmsg.Text = "Record Deleted Successfully...";
            string script = @"setTimeout(function(){document.getElementById('" + divmsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true); 
        }
        ObjService.FillGrid(GridView1);
    }

    private void cleartxt()
    {
        FillddlService(ddlService);
        Editor1.Content = string.Empty; 
        Editor2.Content = string.Empty; 
        Editor3.Content = string.Empty;
        lblmsg.Text = string.Empty;
        lblConmsg.Text = string.Empty;
        btnsave.Text = "Save";
        ddlService.SelectedIndex = 0;
        divmsg.Visible = false;
        lblmsg.Text = string.Empty;
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        ObjService.FillGrid(GridView1);
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
            ObjService.FillGrid(GridView1);
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
            ObjService.FillGrid(GridView1);
            if (GridView1.Rows.Count > 0)
                lblcount.Text = GridView1.Rows.Count.ToString();
            else
                lblcount.Text = "0";
        }
    }
}
