using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Patanjali_pfluserprofile : System.Web.UI.Page
{
    cls_patanjali db = new cls_patanjali();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserRole_id"] != null)
        {
            if (!IsPostBack)
            {
                #region User Log 
                if (Session["UserName"] != null)
                {
                    db.ExceptionLogs("Visited On UserProfile", Session["UserName"].ToString(), "R");
                }
                else
                {
                    db.ExceptionLogs("Visited On UserProfile", Session["Comp_Name"].ToString(), "R");
                }
                #endregion
                DataTable dt = SQL_DB.ExecuteDataTable("select UserName,UserEmail,UserMobile  from tbl_pflUsers where UserRole_id='"+ Session["UserRole_id"] .ToString()+ "'");
                if (dt.Rows.Count > 0)
                {
                    txtUserName.Text = dt.Rows[0]["UserName"].ToString();
                    txtemail.Text = dt.Rows[0]["UserEmail"].ToString();
                    txtmobile.Text = dt.Rows[0]["UserMobile"].ToString();
                }
            }
        }
        else
        {
            Response.Redirect("https://qa.vcqru.com/Patanjali/loginpfl.aspx?From=pfluserprofile");
        }
    }

       //protected void btnsubmit_Click(object sender, EventArgs e)
    //{
    //    if(btnsubmit.Text== "Edit")
    //    {
    //        txtUserName.ReadOnly = false;
    //        txtemail.ReadOnly = false;
    //        txtmobile.ReadOnly = false;
    //        btnsubmit.Text = "Update";
    //    }
    //    else if(btnsubmit.Text == "Update")
    //    {
    //        string UserName= txtUserName.Text.Trim();
    //        string EmailID= txtemail.Text.Trim();
    //        string MobileNO= txtUserName.Text.Trim();
    //        SQL_DB.ExecuteNonQuery("update tbl_pflUsers set UserName='"+ UserName + "',UserEmail='"+ EmailID + "',UserMobile='"+ MobileNO + "' where UserRole_id='"+ Session["UserRole_id"].ToString() + "'");
    //        ScriptManager.RegisterStartupScript(this, GetType(), "Success", "showAlert('Success', 'Details Updated Successfully', 'success');", true);
    //        #region User Log 
    //        if (Session["UserName"] != null)
    //        {
    //            db.ExceptionLogs("UserProfile Updated By", Session["UserName"].ToString(), "U");
    //        }
    //        else
    //        {
    //            db.ExceptionLogs("UserProfile Updated By", Session["Comp_Name"].ToString(), "U");
    //        }
    //        #endregion
    //    }
    //}
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
           DataTable dtpass= SQL_DB.ExecuteDataTable("select * from tbl_pflUsers where UserPassword ='"+ Oldpasword + "'  and isactive=1 and isdelete =0");
            if (dtpass.Rows.Count > 0)
            {
                SQL_DB.ExecuteNonQuery("update tbl_pflUsers set UserPassword='"+ newpassword + "' where UserRole_id='"+ Session["UserRole_id"].ToString() + "' and isactive=1 and isdelete =0");
                ClearTextFields();
                ScriptManager.RegisterStartupScript(this, GetType(), "Success", "showAlert('Success', 'Password Updated Successfully', 'success');", true);
                #region User Log 
                if (Session["UserName"] != null)
                {
                    db.ExceptionLogs("UserPassword Updated By", Session["UserName"].ToString(), "U");
                }
                else
                {
                    db.ExceptionLogs("UserPassword Updated By", Session["Comp_Name"].ToString(), "U");
                }
                #endregion
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