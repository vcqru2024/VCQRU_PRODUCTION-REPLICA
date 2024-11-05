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
using Business9420;

public partial class Frmchangepasswords : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("../Info/Login.aspx?Page=Frmchangepasswords.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
               Response.Redirect("Login.aspx");
        }     
        if (!Page.IsPostBack)
        {
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            newMsg.Visible = false;
        }
        
    }
    
    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        if (Session["User_Type"].ToString() != "Admin")
        {
            if (txtnewpass.Text == txtreenterpass.Text)
            {
                Object9420 Reg = new Object9420();
                Reg.Password = txtnewpass.Text;
                Reg.oldPassword = txtoldpass.Text;
                Reg.Comp_ID = Session["CompanyId"].ToString();
                if (Business9420.function9420.ChangePass(Reg))
                {
                    Business9420.function9420.ChangePasswordCompID(Reg);
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
