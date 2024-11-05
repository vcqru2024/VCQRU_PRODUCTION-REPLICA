using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;



public partial class Patanjali_Loginpfl : System.Web.UI.Page
{
    cls_patanjali db = new cls_patanjali();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["message"] != null)
        {
            string msg = Request.QueryString["message"].ToString();
            if (msg == "Success")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "loginSuccess", "showAlert('Success', 'Thanks for registration with us. Please check your email to verify your account.', 'success');", true);
            }
        }
    }



    protected void btnlogin_Click(object sender, EventArgs e)
    {
        string Email = txtUserName.Text.Trim();
        string Password = txtpassword.Text.Trim();
        if (!string.IsNullOrEmpty(Email) && !string.IsNullOrEmpty(Password))
        {
            string LoginPassword = "1234";
            int Otp = 0;
            if (Password.Length < 5)
            {
                Otp = Convert.ToInt32(Password);
            }
            else
            {
                LoginPassword = Password;
            }
            DataTable dt = db.LoginVendor("USP_GetPflUserLogin", Email, Otp, LoginPassword);
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0][0].ToString() == "Invalid Credentials")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "loginFailed", "showAlert('Error', 'Invalid username or password.', 'error');", true);
                }
                else if (dt.Rows[0][0].ToString() == "Account Deactivated")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "loginFailed", "showAlert('Error', 'Your account is deactivated kindly connect with the administrator', 'error');", true);
                }
                else if (dt.Rows[0][0].ToString() == "Account Deleted")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "loginFailed", "showAlert('Error', 'This email is not registered', 'error');", true);
                }
                else
                {

                    bool hasUserRoleColumn = CheckColumnExists(dt, "UserRole_id");

                    if (hasUserRoleColumn)
                    {
                        HttpContext.Current.Session["UserRole_id"] = dt.Rows[0]["UserRole_id"].ToString();
                    }

                    //SQL_DB.ExecuteNonQuery("Insert into PFL_Login_History (LoginID,UserName)values('"+dt.Rows[0]["Comp_ID"].ToString()+"','"+ dt.Rows[0]["UserName"].ToString() + "')");
                    HttpContext.Current.Session["Comp_ID"] = dt.Rows[0]["Comp_ID"].ToString();
                    HttpContext.Current.Session["Comp_Name"] = dt.Rows[0]["Comp_Name"].ToString();
                    HttpContext.Current.Session["Status"] = Convert.ToString(dt.Rows[0]["Status"]);
                    HttpContext.Current.Session["User_Type"] = "Company"; 
                    HttpContext.Current.Session["Comp_type"] = dt.Rows[0]["Comp_type"].ToString();
                    HttpContext.Current.Session["CompanyId"] = dt.Rows[0]["Comp_ID"].ToString();
                    HttpContext.Current.Session["Comp_Name"] = dt.Rows[0]["Comp_Name"].ToString();
                    HttpContext.Current.Session["IsRetailer"] = dt.Rows[0]["IsRetailer"].ToString();
                    HttpContext.Current.Session["Comp_Email"] = dt.Rows[0]["Comp_Email"].ToString();
                    ScriptManager.RegisterStartupScript(this, GetType(), "loginSuccess", "showAlert('Success', 'Login successful!', 'success');", true);
                    if (Session["UserRole_id"] != null)
                    {
                        dt = SQL_DB.ExecuteDataTable("select * from MenuItem_PfL m inner join tbl_pflUsercontrol ma on m.MenuItemID= ma.MenuId where UserRole_Id='" + Session["UserRole_id"].ToString() + "' and RefMenu<>0 order by MenuId asc");
                        DataTable dtuser = SQL_DB.ExecuteDataTable("select*from tbl_pflUsers where UserRole_id='" + Session["UserRole_id"].ToString() + "'");
                        if (dtuser.Rows.Count > 0)
                        {
                            SQL_DB.ExecuteNonQuery("Insert into PFL_Login_History (LoginID,UserName)values('" + Session["UserRole_id"].ToString() + "','" + dtuser.Rows[0]["UserName"].ToString() + "')");
                            HttpContext.Current.Session["UserName"] = dtuser.Rows[0]["UserName"].ToString();
                            db.ExceptionLogs("Login Successfully by", dtuser.Rows[0]["UserName"].ToString(), "R");
                        }
                    }
                    else
                    {
                        SQL_DB.ExecuteNonQuery("Insert into PFL_Login_History (LoginID,UserName)values('" + Session["CompanyId"].ToString() + "','" + Session["Comp_Name"].ToString() + "')");
                        dt = SQL_DB.ExecuteDataTable("select * from MenuItem_PfL m inner join tblMenuAuthendication ma on m.MenuItemID= ma.MenuId where Comp_Id='" + dt.Rows[0]["Comp_ID"].ToString() + "' and RefMenu<>0 order by MenuId asc");
                        db.ExceptionLogs("Login Successfully by", Session["Comp_Name"].ToString(), "R");
                    }

                    if (dt.Rows.Count > 0)
                    {

                        foreach (DataRow row in dt.Rows)
                        {
                            string menuName = row["MenuItemName"].ToString();
                            string status = row["Status"].ToString();
                            HttpContext.Current.Session[menuName] = status;
                        }
                    }
                    else
                    {

                        string[] sessionKeys = {
                                                "Dashboard",
                                                "Users",
                                                "Consumer Report",
                                                "Code Duplicity Report",
                                                "State Wise Status",
                                                "Product Wise Status",
                                                "Mobile Number Wise Status",
                                                "Code Wise Status Count",
                                                "Mothly code usage and user analysis",
                                                "Consumer Product History",
                                                "Code Status",
                                                "Enquiry Details",
                                                "Product Registration",
                                                "Assign Labels to Product",
                                                "Service Subscription",
                                                "Service Setting",
                                                "Scrap Summary Report",
                                                "Scrap Label Entry",
                                                "Request For Print Labels",
                                                "Label Receive",
                                                "Add Label Request",
                                                "Code Verification",
                                                "Product Click tracking Report",
                                                "Invalid Code Details",
                                                "Assign New Batch No",
                                                "Company Profile"
                                            };

                        foreach (string key in sessionKeys)
                        {
                            HttpContext.Current.Session[key] = true;
                        }
                    }
                    Response.Redirect("../Patanjali/dashboard.aspx");
                }
            }
 else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "loginFailed", "showAlert('Error', 'Invalid username or password.', 'error');", true);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "loginFailed", "showAlert('Error', 'Invalid username or password.', 'error');", true);
        }

    }


    public bool CheckColumnExists(DataTable dataTable, string columnName)
    {
        foreach (DataColumn column in dataTable.Columns)
        {
            if (column.ColumnName == columnName)
            {
                return true;
            }
        }
        return false;
    }
}