using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Patanjali_pfluserprofile : System.Web.UI.Page
{
    cls_message db = new cls_message();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserRole_id"] != null)
        {
            if (!IsPostBack)
            {
               
                DataTable dt = SQL_DB.ExecuteDataTable("select UserName,UserEmail,Mobile_Number  from tbl_users_SP where Id='" + Session["UserRole_id"] .ToString()+ "'");
                if (dt.Rows.Count > 0)
                {
                    txtUserName.Text = dt.Rows[0]["UserName"].ToString();
                    txtemail.Text = dt.Rows[0]["UserEmail"].ToString();
                    txtmobile.Text = dt.Rows[0]["Mobile_Number"].ToString();
                }
            }
        }
        else
        {
            Response.Redirect("../SagarPetro/loginpfl.aspx?From=pfluserprofile");
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if(btnsubmit.Text== "Edit")
        {
            txtUserName.ReadOnly = false;
            txtemail.ReadOnly = false;
            txtmobile.ReadOnly = false;
            btnsubmit.Text = "Update";
        }
        else if(btnsubmit.Text == "Update")
        {
            string UserName= txtUserName.Text.Trim();
            string EmailID= txtemail.Text.Trim();
            string MobileNO= txtUserName.Text.Trim();
            SQL_DB.ExecuteNonQuery("update tbl_users_SP set UserName='" + UserName + "',UserEmail='" + EmailID + "',Mobile_Number='" + MobileNO + "' where id='"+ Session["UserRole_id"].ToString() + "'");
            db.ShowSuccessMessagewithredirect(this, "Details Updated Successfully", "../SagarPetro/dashboard.aspx");
           
        }
    }

    protected void btncancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("../Patanjali/pfluserprofile.aspx");
    }

    protected void btnupdatepassword_Click(object sender, EventArgs e)
    {
        string Oldpasword= txtoldpwd.Text.Trim();
        string newpassword= txtnewpass.Text.Trim();
        string Confirmpass= confirmpassword.Text.Trim();
        if(newpassword!= Confirmpass)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'New password and confirm password should be same', 'error');", true);
        }
        else if(newpassword == Confirmpass)
        {
           DataTable dtpass= SQL_DB.ExecuteDataTable("select * from tbl_users_SP where UserPassword ='" + Oldpasword + "'  and isactive=1 and isdelete =0");
            if (dtpass.Rows.Count > 0)
            {
                SQL_DB.ExecuteNonQuery("update tbl_users_SP set UserPassword='" + newpassword + "' where id='"+ Session["UserRole_id"].ToString() + "' and isactive=1 and isdelete =0");
                ClearTextFields();
               // ScriptManager.RegisterStartupScript(this, GetType(), "Success", "showAlert('Success', 'Password Updated Successfully', 'success');", true);
                db.ShowSuccessMessagewithredirect(this, "Password Updated Successfully", "../SagarPetro/dashboard.aspx");
               
            }
        }
    }
    private void ClearTextFields()
    {
        txtoldpwd.Text = "";
        txtnewpass.Text = "";
        confirmpassword.Text = "";
    }
}