using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SagarPetro_userroletype : System.Web.UI.Page
{
    cls_patanjali db = new cls_patanjali();
    cls_message msg = new cls_message();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Comp_ID"] == null)
            Response.Redirect("../SagarPetro/Loginpfl.aspx?From=userroletype");
        if (!IsPostBack)
        {
            #region User Log 
            if (Session["UserName"] != null)
            {
                db.ExceptionLogs("Visited on Users", Session["UserName"].ToString(), "R");
            }
            else
            {
                db.ExceptionLogs("Visited on Users", Session["Comp_Name"].ToString(), "R");
            }
            #endregion
            bindUser();
        }
    }
    public void bindUser()
    {
        DataTable dt = SQL_DB.ExecuteDataTable("Select*from tbl_pflUserRole where Isdelete=0");
        gvNewUser.DataSource = dt;
        gvNewUser.DataBind();
    }

    [WebMethod]
    public static string ToggleUserStatus(string userId)
    {
        return "User status toggled successfully.";
    }

    [WebMethod]
    public string DeleteUser(string userId)
    {
        string Result = string.Empty;
        int UserRoleID = Convert.ToInt32(userId);
        DataTable dt = db.GetRegisteredUserData("USP_PFLDELETEUserROLEData", UserRoleID);
        if (Convert.ToInt32(dt.Rows[0][0]) == 1)
        {
            Result = "User Deleted Successfully";
        }
        else
        {
            Result = "Can't Delete User";
        }
        return Result;
    }
    protected void btndownload_Click(object sender, EventArgs e)
    {
    }

    protected void btnsavechnages_Click(object sender, EventArgs e)
    {
        string RoleName = txtrolename.Text.Trim();
        if (string.IsNullOrEmpty(RoleName))
        {
            msg.ShowErrorMessage(this,"Please Enter Role Name");
            return;
        }
        if (IsRoleExist(RoleName))
        {
            msg.ShowErrorMessage(this, "Role Name Already Exists");
            return;
        }
        SQL_DB.ExecuteNonQuery("insert into tbl_pflUserRole (RoleType) values('" + RoleName + "')");
        txtrolename.Text = "";
        bindUser();
        msg.ShowSuccessMessage(this, "Role Addeed Successfully.");
    }
    private bool IsRoleExist(string roleName)
    {
        string query = "SELECT COUNT(*) FROM tbl_pflUserRole WHERE RoleType = '"+ roleName + "'";
        int count = Convert.ToInt32(SQL_DB.ExecuteScalar(query));
        return count > 0;
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
    private DataTable GetMenuItems(int roleId, string refMenuId)
    {
        return bindOther1(roleId, refMenuId);
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
    private DataTable GetDefaultMenuItems(string refMenuId)
    {
        return SQL_DB.ExecuteDataTable("select MenuItemID, MenuItemName from MenuItem_PfL where RefMenu='" + refMenuId + "'");
    }
    private void SelectCheckBoxes(DataTable dt, CheckBoxList checkBoxList)
    {
        try
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                bool status = dt.Rows[i].Field<bool>("Status");
                checkBoxList.Items[i].Selected = status;
            }
        }
        catch (Exception)
        {
            throw;
        }
    }
}