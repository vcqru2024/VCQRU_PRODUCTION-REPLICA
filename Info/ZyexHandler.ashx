<%@ WebHandler Language="C#" Class="ZyexHandler" %>

using System;
using System.Web;
using System.Data;

public class ZyexHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        if (context.Request.QueryString["method"] == "ActiveInactiveUser")
        {
            string result = string.Empty;
            string UserRoleId = context.Request.QueryString["UserRoleId"].ToString();
            string CompID = context.Request.QueryString["CompID"].ToString();
            if (string.IsNullOrEmpty(UserRoleId))
            {
                result = "Invalid Role Id";
                context.Response.Write(result);
            }
            DataTable dt = SQL_DB.ExecuteDataTable("exec USP_Updatedealer '" + Convert.ToInt32(UserRoleId) + "','" + CompID + "'");
            if (Convert.ToInt32(dt.Rows[0][0]) == 1)
            {
                result = "User Activated Successfully";
            }
            else if (Convert.ToInt32(dt.Rows[0][0]) == 2)
            {
                result = "User De-Activated Successfully";
            }
            else
            {
                result = "Con't Update this user";
            }
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "DeleteUser")
        {
            string result = string.Empty;
            string UserRoleId = context.Request.QueryString["UserRoleId"].ToString();
            string CompId = context.Request.QueryString["CompId"].ToString();
            if (UserRoleId == "" || UserRoleId == null)
            {
                result = "Invalid Role Id";
            }
            DataTable dt = SQL_DB.ExecuteDataTable("exec USP_Deletedealer '" + Convert.ToInt32(UserRoleId) + "','"+CompId+"'");
            result = dt.Rows[0][0].ToString();
            context.Response.Write(result);
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}