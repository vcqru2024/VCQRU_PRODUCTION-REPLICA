using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business9420;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using System.IO;

public partial class Frmchangepassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=Frmchangepassword.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }        
        if (!Page.IsPostBack)
        {
            //if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
            //    Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            newMsg.Visible = false;
        }
    }    
  
    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        if (txtnewpass.Text == txtreenterpass.Text)
        {
            Object9420 Reg = new Object9420();
            Reg.oldPassword = txtoldpass.Text;
            Reg.Password = txtnewpass.Text;
            Reg.User_Type = "Admin";
            Reg.User_ID = "Admin";
            if (Business9420.function9420.ChangePassAdmin(Reg))
            {
                Business9420.function9420.ChangePasswordAdmin(Reg);
                newMsg.Visible = true;
                newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                Label2.Text = "Password changed successfully !";
                LblMsg.Text = "";
            }
            else
            {
                newMsg.Visible = false;
                LblMsg.Text = "Incorrect old password";
            }

        }
        else
        {
            newMsg.Visible = false;
            LblMsg.Text = "Password not matched";
        }
        Clear();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Clear();
        LblMsg.Text = "";
        newMsg.Visible = false;
    }
    private void Clear()
    {
        txtnewpass.Text = ""; txtoldpass.Text = ""; txtreenterpass.Text = "";
        // LblMsg.Text = "";
    }
}