using Business_Logic_Layer;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Consumer_dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["app"] == "1")
        {
            string consumer_id = Request.QueryString["userid"];
            User_Details Log = new User_Details();
            Log.User_Type = "Consumer";
            Log.User_ID = consumer_id;
            Session["User_Type"] = "Consumer";
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            Session["USRID"] = dt.Rows[0]["User_ID"].ToString();
        }

            if (Session["User_Type"] == null)
            Response.Redirect("../default.aspx?Page=Frmchangepassword.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("../default.aspx");
        }
        if (!Page.IsPostBack)
            NewMsgpop.Visible = false;

    }
        protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        if (txtnewpass.Text == txtreenterpass.Text)
        {
            User_Details Reg = new User_Details();
            Reg.OldPassword = txtoldpass.Text;
            Reg.Password = txtnewpass.Text;
            Reg.User_Type = "Consumer";
            Reg.User_ID = Session["USRID"].ToString();
            Reg.DML = "User_ID";
            Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            if (User_Details.CheckOldPassConsumer(Reg))
            {
                User_Details.ChangePassConsumer(Reg);
                NewMsgpop.Visible = true;
                NewMsgpop.Attributes.Add("class", "class_green");
                LblMsgUpdate.Text = "Password changed successfully !";
                LblMsg.Text = "";
                string script2 = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script2, true);
            }
            else
            {
                NewMsgpop.Visible = true;
                NewMsgpop.Attributes.Add("class", "class_red");
                LblMsgUpdate.Text = "Incorrect old password";
            }

        }
        else
        {
            NewMsgpop.Visible = true;
            NewMsgpop.Attributes.Add("class", "class_red");
            LblMsgUpdate.Text = "Password not matched";
        }
        Clear();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Clear();
        LblMsg.Text = "";
        NewMsgpop.Visible = false;
    }
    private void Clear()
    {
        txtnewpass.Text = ""; txtoldpass.Text = ""; txtreenterpass.Text = "";
        // LblMsg.Text = "";

    }
}