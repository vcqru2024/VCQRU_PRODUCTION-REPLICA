using Business9420;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Manufacturer_hpl_userregistration : System.Web.UI.Page
{
    cls_patanjali db = new cls_patanjali();
    cls_HPL hpl = new cls_HPL();
    //Notification notification = new Notification();
    protected void Page_Load(object sender, EventArgs e)
    {
        string EmailId = string.Empty;
        if (Session["CompanyId"] == null)
            Response.Redirect("../login.aspx? form = htpuserregistration");
        
       
        
        if (!IsPostBack)
        {
            if (Request.QueryString["UserId"] != null)
            {
                EmailId = Request.QueryString["UserId"].ToString();
                filldata(EmailId);
            }
            else
            {
                BindAllMenus();
                BindAllMenu();
            }
            
        }
    }

    public void filldata(string EmailId)
    {
        DataTable dtconsumer = SQL_DB.ExecuteDataTable("Select * from tbl_Hpl_Users where UserEmail='" + EmailId + "'");
        if (dtconsumer.Rows.Count > 0)
        {
            string result = dtconsumer.Rows[0]["AssignProduct"].ToString();
            string output = result.Replace("[\"", "").Replace("\",\"", ",").Replace("\"]", "");
           string Userasignproduct = output;
            BindMenufill(ChkProductName, result);
            txtName.Text= dtconsumer.Rows[0]["Username"].ToString();
            txtEmail.Text= dtconsumer.Rows[0]["UserEmail"].ToString();
            txtMobile.Text= dtconsumer.Rows[0]["MobileNo"].ToString();
            txtlocation.Text= dtconsumer.Rows[0]["Location"].ToString();
            txtEmail.ReadOnly = true;
        }
        
    }
    protected void btnRegisternewUser_Click(object sender, EventArgs e)
    {
        string UserName = txtName.Text.Trim();
        string UserEmail = txtEmail.Text.Trim();
        string UserMobile = txtMobile.Text.Trim();
        string UserLocation = txtlocation.Text.Trim();
        if (btnRegisternewUser.Text == "Update")
        {
            int userRoleId = GetUserRoleId(UserEmail, UserMobile);
            UpdateMenuPermissions(ChkProductName, userRoleId);
             ClearFields();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "alert('Update Successfully.');", true);
            btnRegisternewUser.Text = "Register Now";
            txtEmail.ReadOnly = false;
            string script = "<script>window.location.href = 'hpl_Users.aspx';</script>";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "ChangeUrl", script);
        }
        else
        {
            string Password1 = Data_Access_Layer.EncryptionGeneratePasswordHelper.GeneratePasswordEncrypt().ToString();
            string Password = Data_Access_Layer.EncryptionHelper.Encrypt(Password1);
            if (!IsValidInput(UserName, UserEmail, UserMobile, UserLocation))
                
            return;

            DataTable dt = hpl.RegisterUser("USP_HPLUSERREGISTRATION", UserMobile, UserEmail, UserName, UserLocation, Password, Session["CompanyId"].ToString());
            string registrationMessage = dt.Rows[0][0].ToString();

            if (registrationMessage == "Entered Mobile Number Already Used" || registrationMessage == "Entered Email Id Already Used" || registrationMessage == "Entered email is deleted kindy connect to Administrator")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "alert('"+ registrationMessage + "');", true);
                return;
            }
            int userRoleId = GetUserRoleId(UserEmail, UserMobile);
            if (userRoleId == 0)
                return;
            RegistrationMail mail = new RegistrationMail();
            mail.Name = UserName;
            mail.Email = UserEmail;
            mail.Mobile = UserMobile;
            mail.Subject = "OEM Registration Successful!";
            mail.LoginID = UserEmail;
            mail.Password = Password1;
            string mailresponse = hpl.PostCall(mail.GetJson(), "api/sendmailregistration", "https://vrkableuat.vcqru.com/");
            UpdateMenuPermissions(ChkProductName, userRoleId);
            ClearFields();
            #region Uncomment if Need menu assign to OEM
            // InsertMenuPermissions(Chkdashboard, userRoleId);
            // InsertMenuPermissions(ChkReport, userRoleId);
            // InsertMenuPermissions(ChkProduct, userRoleId);
            //InsertMenuPermissions(ChkService, userRoleId);
            // InsertMenuPermissions(ChKLabel, userRoleId);
            // InsertMenuPermissions(ChkScrap, userRoleId);
            // InsertMenuPermissions(ChkClaimrpt, userRoleId);
            #endregion

            #region Mail Send SMTP
            StringBuilder body = new StringBuilder();

            body.Append(@"<div class='latter' style='border:1px solid #2587D5;padding:5px;'>");
            body.Append(" <div class='w_logo'><img src='https://www.hplindia.com/images/logo.png' alt='logo' /></div>");
            body.Append(" <hr style='border:1px solid #2587D5;'/>");
            body.Append(" <div class='w_frame'>");
            body.Append(" <p>");
            body.Append(" <div class='w_detail'>");
            body.Append(" <span>Dear " + UserName + ",</span> ");
            body.Append("<br /><br /> We are excited to inform you that your registration as an authorized OEM to generate E-Warranty codes has been successful. You can now start issuing warranty codes. <br />");
            body.Append(" <span>Your login credential is following</span>");
            body.Append(" <br />");
            body.Append(" <br />");
            body.Append(" <span><strong>Your User ID : - </strong>" + UserEmail + "</span>");
            body.Append(" <br />");
            body.Append(" <span><strong>Your Password : - </strong>" + Password1 + "</span>");
            body.Append(" <span><strong>Login On : - </strong>https://qa.vcqru.com/login.aspx</span>");
            body.Append("<br /><br /> Thank you for partnering with HPL. <br />");
            body.Append(" <p>");
            body.Append(" <div class='w_detail'>");
            body.Append(" Best regards,<br /><br />");
            body.Append("  <em><strong>HPL Team</strong></em><br />");
            body.Append(" </div>");
            body.Append(" </p>");
            body.Append(" </div>");
            body.Append(" </p>");
            body.Append(" </div> ");
            body.Append(" </div> ");

            string emailBody = body.ToString();
            string Subject = "OEM Registration Successful!";
          
            //sendmail(UserEmail, Subject, emailBody);
       // DataSet dsMl = function9420.FetchMailDetail("support");
      //  DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), UserEmail, body, Subject);

        #endregion

        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "alert('Registered Successfully.');", true);
        }
        
    }

   
    public int GetUserRoleId(string email, string mobile)
    {
        DataTable dtUser = SQL_DB.ExecuteDataTable("SELECT Userrole_id FROM tbl_Hpl_Users WHERE UserEmail = '" + email + "' AND MobileNo = '" + mobile + "' AND IsActive = 1");
        if (dtUser.Rows.Count > 0)
        {
            return Convert.ToInt32(dtUser.Rows[0]["Userrole_id"]);
        }

        return 0; // Return 0 if no matching user role ID found
    }
    private void InsertMenuPermissions(CheckBoxList chkList, int userRoleId)
    {
        foreach (ListItem item in chkList.Items)
        {
            int menuId = Convert.ToInt32(item.Value);
            int status = item.Selected ? 1 : 0;

            SQL_DB.ExecuteNonQuery("insert into TBL_AuthenticateMenu_HPL(MenuId,Status,Comp_id,User_role_Id) values('" + menuId + "','" + status + "','" + Session["CompanyId"].ToString() + "','" + userRoleId + "')");
           // SQL_DB.ExecuteNonQuery("UPDATE tbl_pflUsercontrol SET Status = '" + status + "' WHERE MenuId = '" + menuId + "' AND UserRole_Id = '" + userRoleId + "'");
               
        }
    }
    private void UpdateMenuPermissions(CheckBoxList chkList, int userRoleId)
    {
        List<string> selectedItems = new List<string>();
        foreach (ListItem item in chkList.Items)
        {
            if (item.Selected)
            {
                string menuId = item.Value;
                selectedItems.Add(menuId);
            }
        }
        string jsonStatus = JsonConvert.SerializeObject(selectedItems);
        SQL_DB.ExecuteNonQuery("UPDATE tbl_Hpl_Users SET AssignProduct = '" + jsonStatus + "' WHERE  UserRole_Id = '" + userRoleId + "'");
    }
    public void ClearFields()
    {
        txtEmail.Text = "";
        txtlocation.Text = "";
        txtMobile.Text = "";
        txtName.Text = "";
        
       // ChkClaimrpt.ClearSelection();
       // Chkdashboard.ClearSelection();
       // ChKLabel.ClearSelection();
       // ChkProduct.ClearSelection();
        ChkProductName.ClearSelection();
       // ChkReport.ClearSelection();
       // ChkScrap.ClearSelection();
       // ChkService.ClearSelection();
        
    }

    public bool IsValidInput(string name, string email, string mobile, string location)
    {
        if (!IsValidUserName(name))
        {
            //db.ShowErrorMessage(this, "Please Enter Valid User Name");
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "alert('Please Enter Valid User Name');", true);
            return false;
        }

        if (!IsEmailValid(email))
        {
            //db.ShowErrorMessage(this, "Please Enter Valid Email Id");
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "alert('Please Enter Valid Email Id');", true);
            return false;
        }

        if (!IsMobileNumberValid(mobile))
        {
            //db.ShowErrorMessage(this, "Please Enter Valid Mobile Number");
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "alert('Please Enter Valid Mobile Number');", true);
            return false;
        }
        if (!IsValidUserName(location))
        {
            //db.ShowErrorMessage(this, "Please Enter Valid location");
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "alert('Please Enter Valid location');", true);
            return false;
        }

        return true;
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
    public static bool IsValidUserName(string username)
    {
        string pattern = "^[A-Za-z\\s]+$";
        return Regex.IsMatch(username, pattern);
    }
    public void BindAllMenus()
    {
        BindMenu(ChkProductName);
    }
    public void BindAllMenu()
    {
       // BindMenu(Chkdashboard, 1);
       // BindMenu(ChkReport, 2);
        //BindMenu(ChkCompprofile, 4);
       // BindMenu(ChkScrap, 39);
       // BindMenu(ChKLabel, 33);

       // BindMenu(ChkProduct, 14);
       // BindMenu(ChkUsers, 2);
       // BindMenu(ChkService, 18);
       // BindMenu(ChkClaimrpt, 87);
    }
    public void BindMenu(Control checkboxControl, int refMenuId)
    {
        DataTable dt = SQL_DB.ExecuteDataTable("SELECT MenuItemID, MenuItemName FROM MenuItem_HPL WHERE RefMenu = '" + refMenuId + "'");
        CheckBoxList chkList = (CheckBoxList)checkboxControl;
        chkList.DataValueField = "MenuItemID";
        chkList.DataTextField = "MenuItemName";
        chkList.DataSource = dt;
        chkList.DataBind();
    }
    public void BindMenu(Control checkboxControl)
    {
        DataTable dt = SQL_DB.ExecuteDataTable("select*from Pro_Reg where comp_id='" + Session["CompanyId"].ToString() + "' and Pro_Name<>'Default' ");
        CheckBoxList chkList = (CheckBoxList)checkboxControl;
        chkList.DataValueField = "Pro_ID";
        chkList.DataTextField = "Pro_Name";
        chkList.DataSource = dt;
        chkList.DataBind();
        
    }
    private void SelectCheckBoxes(DataTable dt, CheckBoxList checkBoxList)
    {
        BindMenu(checkBoxList);
        try
        {
            foreach (ListItem item in checkBoxList.Items)
            {
                string proId = item.Value;
                DataRow[] rows = dt.Select("Pro_ID = '" + proId + "'");
                if (rows.Length > 0)
                {
                    item.Selected = true;
                }
            }
            btnRegisternewUser.Text = "Update";
        }
        catch (Exception)
        {
            throw;
        }
    }
    public void BindMenufill(Control checkboxControl, string ProductId)
    {
        string[] listofproduct = ParseJsonArray(ProductId);
        string QRY = string.Format("SELECT * FROM Pro_Reg WHERE comp_id='{0}' AND Pro_Id IN ('{1}')", Session["CompanyId"], string.Join("','", listofproduct));
        DataTable dt = SQL_DB.ExecuteDataTable(QRY);

        CheckBoxList chkList = (CheckBoxList)checkboxControl;
        chkList.DataValueField = "Pro_ID";
        chkList.DataTextField = "Pro_Name";
        chkList.DataSource = dt;
        chkList.DataBind();
        SelectCheckBoxes(dt, chkList);
        //// Iterate over the CheckBoxList items
        //foreach (ListItem item in chkList.Items)
        //{
        //    // Check if the Pro_ID exists in the DataTable
        //    string proId = item.Value;
        //    DataRow[] rows = dt.Select("Pro_ID = '" + proId + "'");
        //    if (rows.Length > 0)
        //    {
        //        // If the Pro_ID exists, check the CheckBoxList item
        //        item.Selected = true;
        //    }
        //}
    }

    static string[] ParseJsonArray(string jsonArray)
    {
        string[] parts = jsonArray.Replace("[", "").Replace("]", "").Split(',');
        return parts.Select(part => part.Trim().Replace("\"", "")).ToArray();
    }
}