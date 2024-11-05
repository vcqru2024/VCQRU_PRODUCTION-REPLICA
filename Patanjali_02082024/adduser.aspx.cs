
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_adduser : System.Web.UI.Page
{
    int UserRoleID = 0;
    cls_patanjali db = new cls_patanjali();
    string Comp_id = "";
    //SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
    //SqlCommand cmd;
    //string query;
    string baseUrl = "https://uat.vcqru.com/";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../Patanjali/Loginpfl.aspx?From=adduser");
        if (!IsPostBack)
        {
            #region User Log 
            if (Session["UserName"] != null)
            {
                db.ExceptionLogs("Visit on Add Users", Session["UserName"].ToString(), "R");
            }
            else
            {
                db.ExceptionLogs("Visit on Add Users", Session["Comp_Name"].ToString(), "R");
            }
            #endregion
            if (!String.IsNullOrEmpty(Request.QueryString["id"]))
            {
                UserRoleID = Convert.ToInt32(Request.QueryString["id"]);
                DataTable dt = db.GetRegisteredUserData("USP_PFLGETUserROLEData", UserRoleID);
                if (dt.Rows.Count > 0)
                {
                    username.Text = dt.Rows[0]["UserName"].ToString();
                    username.ReadOnly = true;
                    userEmail.Text = dt.Rows[0]["UserEmail"].ToString();
                    userEmail.ReadOnly = true;
                    userMobile.Text = dt.Rows[0]["UserMobile"].ToString();
                    userMobile.ReadOnly = true;
                    BindReport(UserRoleID);
                    btnSubmit.Text = "Update";
                    ViewState["UserRoleID"] = UserRoleID;
                }
            }
            else
            {
                BindAllMenus();
            }
        }
        else
        {
            if (!String.IsNullOrEmpty(Request.QueryString["id"]))
            {
                UserRoleID = Convert.ToInt32(Request.QueryString["id"]);
            }
        }
    }

    public void BindReport(int roleId)
    {
        BindMenuItems(roleId, "1", Chkdashboard);
        BindMenuItems(roleId, "2", ChkUsers);
        BindMenuItems(roleId, "3", ChkReport);
        BindMenuItems(roleId, "4", ChkCompprofile);
        BindMenuItems(roleId, "14", ChkProduct);
        BindMenuItems(roleId, "17", ChkService);
        BindMenuItems(roleId, "23", ChKLabel);
        BindMenuItems(roleId, "20", ChkScrap);
    }

    private void BindMenuItems(int roleId, string refMenuId, CheckBoxList checkBoxList)
    {
        DataTable dt = GetMenuItems(roleId, refMenuId);
        if (dt.Rows.Count > 0)
        {
            BindCheckBoxList(dt, checkBoxList);
        }
        else
        {
            DataTable defaultMenuItems = GetDefaultMenuItems(refMenuId);
            BindCheckBoxList(defaultMenuItems, checkBoxList);
        }
    }

    private DataTable GetMenuItems(int roleId, string refMenuId)
    {
        return bindOther1(roleId, refMenuId);
    }

    private DataTable GetDefaultMenuItems(string refMenuId)
    {
        return SQL_DB.ExecuteDataTable("select MenuItemID, MenuItemName from MenuItem_PfL where RefMenu='" + refMenuId + "'");
    }

    private void BindCheckBoxList(DataTable dt, CheckBoxList checkBoxList)
    {
        try
        {
            if (dt != null)
            {
                checkBoxList.DataValueField = "MenuItemID";
                checkBoxList.DataTextField = "MenuItemName";
                checkBoxList.DataSource = dt;
                checkBoxList.DataBind();
                SelectCheckBoxes(dt, checkBoxList);
            }
        }
        catch (Exception)
        {
            throw;
        }
    }

    private void SelectCheckBoxes(DataTable dt, CheckBoxList checkBoxList)
    {
        try
        {
            //for (int i = 0; i < dt.Rows.Count; i++)
            //{
            //    bool status = dt.Rows[i].Field<bool>("Status");
            //    checkBoxList.Items[i].Selected = status;
            //}
            for (int i = 0; i < dt.Rows.Count && i < checkBoxList.Items.Count; i++)
            {
                bool status = false;
                if (dt.Columns.Contains("Status") && dt.Rows[i]["Status"] != DBNull.Value)
                {
                    try
                    {
                        status = Convert.ToBoolean(dt.Rows[i]["Status"]);
                    }
                    catch (InvalidCastException)
                    {
                        status = false; 
                    }
                }
                checkBoxList.Items[i].Selected = status;
            }
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected DataTable bindOther1(int roleId, string refMenuId)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(SQL_DB.ConnectionString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("USP_PFLGetAllMenuItems", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@RoleID", roleId);
                    cmd.Parameters.AddWithValue("@RefMenuId", refMenuId);
                    DataTable dt = new DataTable();
                    using (SqlDataAdapter adp = new SqlDataAdapter(cmd))
                    {
                        adp.Fill(dt);
                        return dt;
                    }
                }
            }
        }
        catch (Exception)
        {
            return null;
        }
    }

    public string getPatanjaliDemonew(string name, string email, string cmobile)
    {

        string sessionId = "gfyn4xtzlrnl55rpfbxp1o3d";
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls;
        string url = baseUrl + "Info/PatanjaliHandler.ashx" + "?method=PatanjaliRegistrationDeno" + "&name=" + name + "&email=" + email + "&cmobile=" + cmobile;
        try
        {
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "GET";
            request.Headers.Add("Cookie", "ASP.NET_SessionId=" + sessionId);
            using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            {
                using (Stream stream = response.GetResponseStream())
                {
                    using (StreamReader reader = new StreamReader(stream))
                    {
                        string responseContent = reader.ReadToEnd();
                        return responseContent;
                    }
                }
            }
        }
        catch (WebException ex)
        {
            return "Error: " + ex.Message;
        }
        catch (Exception ex)
        {
            return "Error: " + ex.Message;
        }
    }

    private bool IsValidInput(string name, string email, string mobile)
    {
        if (!IsValidUserName(name))
        {
            ShowErrorMessage("Please Enter Valid User Name");
            return false;
        }

        if (!IsEmailValid(email))
        {
            ShowErrorMessage("Please Enter Valid Email Id");
            return false;
        }

        if (!IsMobileNumberValid(mobile))
        {
            ShowErrorMessage("Please Enter Valid Mobile Number");
            return false;
        }

        return true;
    }
    public void ClearFields()
    {
        username.Text = "";
        userEmail.Text = "";
        userMobile.Text = "";

        // Clear checkbox lists
        Chkdashboard.ClearSelection();
        ChkReport.ClearSelection();
        ChkUsers.ClearSelection();
        ChkProduct.ClearSelection();
        ChkService.ClearSelection();
        ChKLabel.ClearSelection();
        ChkScrap.ClearSelection();
    }

    public int GetUserRoleId(string email, string mobile)
    {
        DataTable dtUser = SQL_DB.ExecuteDataTable("SELECT Userrole_id FROM tbl_pflUsers WHERE UserEmail = '"+ email + "' AND UserMobile = '"+ mobile + "' AND IsActive = 1");
        if (dtUser.Rows.Count > 0)
        {
            return Convert.ToInt32(dtUser.Rows[0]["Userrole_id"]);
        }

        return 0; // Return 0 if no matching user role ID found
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (btnSubmit.Text == "Update")
        {
            if (UserRoleID == 0)
            {
                ShowErrorMessage("Something Went Wrong Please try After");
                return;
            }

            DataTable dtget = SQL_DB.ExecuteDataTable("Select MenuId,Status from tbl_pflUsercontrol where UserRole_Id = '"+ UserRoleID + "'");

            if (dtget.Rows.Count > 0)
            {
                UpdateMenuPermissions(ChkCompprofile, UserRoleID);
                UpdateMenuPermissions(Chkdashboard, UserRoleID);
                UpdateMenuPermissions(ChkReport, UserRoleID);
                UpdateMenuPermissions(ChkUsers, UserRoleID);
                UpdateMenuPermissions(ChkProduct, UserRoleID);
                UpdateMenuPermissions(ChkService, UserRoleID);
                UpdateMenuPermissions(ChKLabel, UserRoleID);
                UpdateMenuPermissions(ChkScrap, UserRoleID);

                LogAction("User Role Updated By");

                ShowSuccessMessage("Updated Successfully!");
                return;
            }
        }
        else // Registration Process for Patanjali Users
        {
            string name = username.Text;
            string email = userEmail.Text;
            string mobile = userMobile.Text;

            if (!IsValidInput(name, email, mobile))
                return;

            DataTable dt = db.RegisterUser("Insert_pflUser", mobile, email, name, Session["CompanyId"].ToString());
            string registrationMessage = dt.Rows[0][0].ToString();

            if (registrationMessage == "Entered Mobile Number Already Used" || registrationMessage == "Entered Email Id Already Used" || registrationMessage == "Entered email is deleted kindy connect to Administrator")
            {
                ShowErrorMessage(registrationMessage);
                return;
            }

            

            int userRoleId = GetUserRoleId(email, mobile);
            if (userRoleId == 0)
                return;
            UpdateMenuPermissions(ChkCompprofile, userRoleId);
            UpdateMenuPermissions(Chkdashboard, userRoleId);
            UpdateMenuPermissions(ChkReport, userRoleId);
            UpdateMenuPermissions(ChkUsers, userRoleId);
            UpdateMenuPermissions(ChkProduct, userRoleId);
            UpdateMenuPermissions(ChkService, userRoleId);
            UpdateMenuPermissions(ChKLabel, userRoleId);
            UpdateMenuPermissions(ChkScrap, userRoleId);

            LogAction("User Added By");

            string responseMessage = getPatanjaliDemonew(name, email, mobile);
            ClearFields();
            if (responseMessage == "Query has been sent successfully.")
            {
                Response.Redirect("../Patanjali/newuser.aspx?msg=Success");
            }
            else
            {
                ShowSuccessMessage("Registered Successfully");
            }
        }
    }
    private void UpdateMenuPermissions(CheckBoxList chkList, int userRoleId)
    {
        foreach (ListItem item in chkList.Items)
        {
            int menuId = Convert.ToInt32(item.Value);
            int status = item.Selected ? 1 : 0;
            int existingRecordsCount = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT COUNT(*) FROM tbl_pflUsercontrol WHERE MenuId = '" + menuId + "' AND UserRole_Id = '" + userRoleId + "'"));
            if (existingRecordsCount > 0)
            {
                SQL_DB.ExecuteNonQuery("UPDATE tbl_pflUsercontrol SET Status = '" + status + "' WHERE MenuId = '" + menuId + "' AND UserRole_Id = '" + userRoleId + "'");
            }
            else
            {
                SQL_DB.ExecuteNonQuery("INSERT INTO tbl_pflUsercontrol (MenuId, UserRole_Id, Status) VALUES ('" + menuId + "', '" + userRoleId + "', '" + status + "')");
            }
        }
    }


    //private void UpdateMenuPermissions(CheckBoxList chkList, int userRoleId)
    //{
    //    foreach (ListItem item in chkList.Items)
    //    {
    //        int menuId = Convert.ToInt32(item.Value);
    //        int status = item.Selected ? 1 : 0;

    //        SQL_DB.ExecuteNonQuery("UPDATE tbl_pflUsercontrol SET Status = '" + status + "' WHERE MenuId = '" + menuId + "' AND UserRole_Id = '" + userRoleId + "'");
    //    }
    //}

    private void ShowErrorMessage(string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', '"+ message + "', 'error');", true);
    }

    private void ShowSuccessMessage(string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "Success", "showAlert('Success', '" + message + "', 'success');", true);
    }
    private void LogAction(string action)
    {
        string userName = Session["UserName"] != null ? Session["UserName"].ToString() : Session["Comp_Name"].ToString();
        db.ExceptionLogs(action, userName, "U");
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
        // Regular expression pattern to match only letters and spaces
        string pattern = "^[A-Za-z\\s]+$";

        // Check if the username matches the pattern
        return Regex.IsMatch(username, pattern);
    }

    public void BindMenu(Control checkboxControl, int refMenuId)
    {
        DataTable dt = SQL_DB.ExecuteDataTable("SELECT MenuItemID, MenuItemName FROM MenuItem_PfL WHERE RefMenu = '" + refMenuId + "'");
        CheckBoxList chkList = (CheckBoxList)checkboxControl;
        chkList.DataValueField = "MenuItemID";
        chkList.DataTextField = "MenuItemName";
        chkList.DataSource = dt;
        chkList.DataBind();
    }

    public void BindAllMenus()
    {
        BindMenu(Chkdashboard, 1);
        BindMenu(ChkReport, 3);
        BindMenu(ChkCompprofile, 4);
        BindMenu(ChkScrap, 20);
        BindMenu(ChKLabel, 23);

        BindMenu(ChkProduct, 14);
        BindMenu(ChkUsers, 2);
        BindMenu(ChkService, 17);
    }
}