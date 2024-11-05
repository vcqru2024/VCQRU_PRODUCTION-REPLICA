using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_Users : System.Web.UI.Page
{
    cls_patanjali db = new cls_patanjali();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }

    //protected void btnsave_Click(object sender, EventArgs e)
    //{
    //    string Role = txtrole.Text;
    //    if (!string.IsNullOrEmpty(Role))
    //    {
    //        DataTable dt = db.InsertUserRole("USP_PFLCreateRole", Role);
    //        if (dt.Rows.Count > 0)
    //        {
    //            lblmsg.Text = "Updated Sucessfully";
    //            lblmsg.ForeColor = System.Drawing.Color.Green;
    //            txtrole.Text="";
    //        }
    //    }
    //    else
    //    {
    //        lblmsg.Text = "Kindly Enter Role Type";
    //        lblmsg.ForeColor = System.Drawing.Color.Red;
    //        return;
    //    }
    //}

    protected void btnCreateRole_Click(object sender, EventArgs e)
    {
        divuserregistration.Visible = false;
        // divrole.Visible = true;
        // bindrolegried();
    }
    //public void bindrolegried()
    //{
    //    DataTable dt = db.SelectUserRole("USP_PFLGETROLE",0);
    //    grdrole.DataSource = dt;
    //    grdrole.DataBind();
    //}
    protected void grdrole_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ActiveDeactive")
        {
            // Implement logic to activate/deactivate role
            int roleId = Convert.ToInt32(e.CommandArgument);
            DataTable dt = db.Updatedeleteuserrole("USP_PFLUPDATEDELETEUSERROLE", roleId, "U");
            if (dt.Rows[0][0].ToString() == "Activated")
            {
                lblmsg.Text = "Activated Sucessfully";
                lblmsg.ForeColor = System.Drawing.Color.Green;
                return;
            }
            if (dt.Rows[0][0].ToString() == "DeActivated")
            {
                lblmsg.Text = "DeActivated Sucessfully";
                lblmsg.ForeColor = System.Drawing.Color.Red;
                return;
            }
        }
        else if (e.CommandName == "DeleteRole")
        {
            // Implement logic to delete role
            int roleId = Convert.ToInt32(e.CommandArgument);
            DataTable dt = db.Updatedeleteuserrole("USP_PFLUPDATEDELETEUSERROLE", roleId, "D");
            if (dt.Rows[0][0].ToString() == "Deleted")
            {
                lblmsg.Text = "Role Deleted Sucessfully";
                lblmsg.ForeColor = System.Drawing.Color.Red;
                return;
            }
        }
        // bindrolegried();
    }
    protected void btnregisteruser_Click(object sender, EventArgs e)
    {
        //  divrole.Visible = false;
        divuserregistration.Visible = true;
        bindRegisteredUser();
    }
    public void bindRegisteredUser()
    {
        //  binddropdown();
        DataTable dt = db.GetRegisteredUserData("USP_PFLGETUserROLEData", 0);
        grduserreg.DataSource = dt;
        grduserreg.DataBind();
    }
    //public void binddropdown()
    //{
    //    DataTable dt = db.SelectUserRole("USP_PFLGETROLE", 0);
    //    ddluserrole.DataSource = dt;
    //    ddluserrole.DataValueField = "RoleId";
    //    ddluserrole.DataTextField = "RoleName";
    //    ddluserrole.DataBind();
    //}

    protected void btnRegisternewUser_Click(object sender, EventArgs e)
    {
        string Mobile = txtMobile.Text.Trim();
        string Email = txtEmail.Text.Trim();
        string Name = txtName.Text.Trim();
        // string UserType = ddluserrole.SelectedValue;
        bool isValid = IsMobileNumberValid(Mobile);
        bool isValidEmail = IsEmailValid(Email);
        if (!isValid)
        {
            lblmsg.Text = "Please Enter Valid Mobie Number";
            lblmsg.ForeColor = System.Drawing.Color.Red;
            return;
        }
        if (!isValidEmail)
        {
            lblmsg.Text = "Please Enter Valid Email Id";
            lblmsg.ForeColor = System.Drawing.Color.Red;
            return;
        }

        if (!string.IsNullOrEmpty(Mobile) && !string.IsNullOrEmpty(Email) && !string.IsNullOrEmpty(Name))
        {
            DataTable dt = db.RegisterUser("Insert_pflUser  ", Mobile, Email, Name, "Comp-1311");
            if (dt.Rows.Count > 0)
            {
                lblmsg.Text = "User Created Successfully";
                lblmsg.ForeColor = System.Drawing.Color.Red;
                txtMobile.Text = "";
                txtEmail.Text = "";
                txtName.Text = "";
                return;

            }
            else
            {
                lblmsg.Text = "Invalid Request User Not Registered";
                lblmsg.ForeColor = System.Drawing.Color.Red;
                return;
            }
        }
    }
    public static bool IsMobileNumberValid(string mobileNumber)
    {
        string pattern = @"^[0-9]{10}$";
        Regex regex = new Regex(pattern);
        Match match = regex.Match(mobileNumber);
        return match.Success;
    }
    public static bool IsEmailValid(string emailAddress)
    {
        string pattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
        Regex regex = new Regex(pattern);
        Match match = regex.Match(emailAddress);
        return match.Success;
    }

   
}