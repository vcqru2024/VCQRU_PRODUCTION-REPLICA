using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
 


public partial class Admin_FrmMailBox : System.Web.UI.Page
{   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["u_reg"] == null)
            Response.Redirect("index.aspx");
        if (!IsPostBack)
        {
            FillUser();
            Clear();
            FillInboxGrid();
            FillOutBoxGrid();
        }
    }

    private void FillUser()
    {
        DataSet ds = new DataSet();
        ddlSendTo.Items.Clear();
        SQL_DB.GetDA("SELECT [name]+' ['+[user_id]+']' as U_Name,[user_id] FROM [Registration] order by [name]").Fill(ds, "1");
        ddlSendTo.DataSource = ds.Tables["1"];
        ddlSendTo.DataTextField = "U_Name";
        ddlSendTo.DataValueField = "user_id";
        ddlSendTo.DataBind();
        ddlSendTo.Items.Insert(0, "--Select--");

    }
    protected void imgbtnSendMail_Click(object sender, ImageClickEventArgs e)
    {
        SQL_DB.ExecuteNonQuery("INSERT INTO [M_MailBox] ([Send_To],[Subject],[Send_By],[Message]) VALUES ('"+ddlSendTo.SelectedValue.ToString()+"','"+txtSubject.Text.Trim().Replace("'","''")+"','Admin','"+Editor1.Content.Trim().Replace("'","''")+"')");
        Clear();
        lblMailMsg.Text = "Mail Sent Successfully...";
    }
    protected void imgBtnReset_Click(object sender, ImageClickEventArgs e)
    {
        Clear();
    }

    private void Clear()
    {
        txtSubject.Text = "";
        ddlSendTo.SelectedIndex = 0;
        Editor1.Content = "";
        lblMailMsg.Text = "";
    }

    private void FillInboxGrid()
    {
        DataSet ds = new DataSet();
        SQL_DB.GetDA("SELECT     M_MailBox.tbl_id, M_MailBox.Subject, M_MailBox.Send_By, M_MailBox.Message, M_MailBox.Read_flg, M_MailBox.Send_date, Registration.name FROM         M_MailBox INNER JOIN Registration ON M_MailBox.Send_By = Registration.user_id WHERE     (M_MailBox.In_Del_Flg = 0) AND (M_MailBox.Send_To = 'Admin') order by M_MailBox.Send_date desc").Fill(ds);
        GridViewInbox.DataSource = ds.Tables[0];
        GridViewInbox.DataBind();
        FillColor();
    }

    private void FillColor()
    {
        for (int i = 0; i < GridViewInbox.Rows.Count; i++)
        {
            if (GridViewInbox.DataKeys[i]["Read_flg"].ToString() == "1")
            {
                GridViewInbox.Rows[i].BackColor = System.Drawing.Color.LightGreen;
            }
        }
    }

    private void FillOutBoxGrid()
    {
        DataSet ds = new DataSet();
        SQL_DB.GetDA("SELECT     M_MailBox.tbl_id, M_MailBox.Subject, Send_To, M_MailBox.Message, M_MailBox.Read_flg, M_MailBox.Send_date, Registration.name FROM         M_MailBox INNER JOIN   Registration ON M_MailBox.Send_To = Registration.user_id WHERE     (M_MailBox.Out_Del_flg = 0) AND (M_MailBox.Send_By = 'Admin') order by M_MailBox.Send_date desc").Fill(ds);
        GridViewOutBox.DataSource = ds.Tables[0];
        GridViewOutBox.DataBind();
    }
    protected void GridViewInbox_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        lblTblId.Text = e.CommandArgument.ToString();
        SQL_DB.ExecuteNonQuery("Update M_MailBox Set Read_flg=1 where tbl_id=" + e.CommandArgument.ToString());
        FillInboxGrid();
        lblViewMsg.Text = Convert.ToString(SQL_DB.ExecuteScalar("SELECT [Message] FROM [M_MailBox] where [tbl_id]=" + e.CommandArgument.ToString()));
        txtMsgReply.Text = "";
        ModalPopupExtender1.Show();
    }

    protected void GridViewInbox_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridViewInbox.PageIndex = e.NewPageIndex;
        FillInboxGrid();
    }

    protected void GridViewOutBox_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        lblMsgVeiw.Text = Convert.ToString(SQL_DB.ExecuteScalar("SELECT [Message] FROM [M_MailBox] where [tbl_id]="+e.CommandArgument.ToString()));
        ModalPopupExtender2.Show();
    }

    protected void GridViewOutBox_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridViewOutBox.PageIndex = e.NewPageIndex;
        FillOutBoxGrid();
    }
    protected void ImgBtnReply_Click(object sender, ImageClickEventArgs e)
    {
        string SendTo = Convert.ToString(SQL_DB.ExecuteScalar("Select Send_By From M_MailBox where tbl_id="+lblTblId.Text));
        SQL_DB.ExecuteNonQuery("INSERT INTO [M_MailBox] ([Send_To],[Subject],[Send_By],[Message]) VALUES ('" + SendTo + "','Reply','Admin','" + txtMsgReply.Text.Trim().Replace("'", "''") + "')");        
        lblMailMsg.Text = "Mail Sent Successfully...";
        FillOutBoxGrid();
    }
    protected void ImgBtnRepReset_Click(object sender, ImageClickEventArgs e)
    {
        txtMsgReply.Text = "";
        ModalPopupExtender2.Show();
    }
    protected void ImgBtnDeleteInMail_Click(object sender, ImageClickEventArgs e)
    {
        if (Request.Form["chkInselect"] != null)
        {
            SQL_DB.ExecuteNonQuery("Update M_MailBox Set In_Del_Flg=1 where tbl_id in ("+Request.Form["chkInselect"].ToString()+")");
        }
        FillInboxGrid();
        lblMailMsg.Text = "Mail Deleted Successfully...";
    }
    protected void ImgBtnDeleteOutMail_Click(object sender, ImageClickEventArgs e)
    {
        if (Request.Form["chkOutselect"] != null)
        {
            SQL_DB.ExecuteNonQuery("Update M_MailBox Set Out_Del_flg=1 where tbl_id in (" + Request.Form["chkOutselect"].ToString() + ")");
        }
        FillOutBoxGrid();
        lblMailMsg.Text = "Mail Deleted Successfully...";
    }


         
         
         
}