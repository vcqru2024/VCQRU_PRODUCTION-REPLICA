<%@ WebHandler Language="C#" Class="SagarHandler" %>

using System;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using Business9420;
using Newtonsoft.Json;


public class SagarHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.QueryString["method"] == "ActiveInactiveUser")
        {
            string result = string.Empty;
            string UserRoleId = context.Request.QueryString["UserRoleId"].ToString();
            string Usertype = context.Request.QueryString["Usertype"].ToString();
            if (string.IsNullOrEmpty(UserRoleId))
            {
                result = "Invalid Role Id";
                context.Response.Write(result);
            }
            else if (string.IsNullOrEmpty(Usertype))
            {
                result = "Invalid Usertype";
                context.Response.Write(result);
            }

            DataTable dt = SQL_DB.ExecuteDataTable("exec USP_UPDATEUserROLEData_SAGAR '" + Convert.ToInt32(UserRoleId) + "','" + Convert.ToInt32(Usertype) + "'");
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

        else if (context.Request.QueryString["method"] == "ActiveInactiveUsergift")
        {
            string result = string.Empty;
            string GiftID = context.Request.QueryString["UserRoleId"].ToString();
            string CompanyId = context.Request.QueryString["CompanyId"].ToString();
            if (string.IsNullOrEmpty(GiftID) && string.IsNullOrEmpty(CompanyId))
            {
                result = "Invalid Role Id";
            }
            else
            {
                SQL_DB.ExecuteNonQuery("UPDATE Claim_gift SET status = CASE WHEN status = '0' THEN '1' ELSE '0' END WHERE gift_id = '" + GiftID + "' AND CompID = '" + CompanyId + "'");
                result = "Status successfully update";
            }
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "UpdateRole")
        {
            string result = string.Empty;
            string Remark = "";
            string UserRoleId = context.Request.QueryString["UserRoleId"].ToString();
            string User_Type = context.Request.QueryString["User_Type"].ToString();
            string NewRoleId = context.Request.QueryString["NewRoleId"].ToString();
            if(context.Request.QueryString["Remark"].ToString()!=null)
                Remark = context.Request.QueryString["Remark"].ToString();
            if (string.IsNullOrEmpty(UserRoleId) && string.IsNullOrEmpty(User_Type) && string.IsNullOrEmpty(NewRoleId) )
            {
                result = "Invalid Details";
            }
            else
            {
                DataTable dtupdaterole = SQL_DB.ExecuteDataTable("exec USP_Updateassignhead '" + UserRoleId + "','" + User_Type + "','" + NewRoleId + "','" + Remark + "'");
                if( Convert.ToInt32(dtupdaterole.Rows[0][0])==1)
                    result = "User Updated Successfully";
                else
                    result = "Invalid Request";
            }
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "DeleteUser")
        {
            string result = string.Empty;
            string UserRoleId = context.Request.QueryString["UserRoleId"].ToString();
            if (UserRoleId == "" || UserRoleId == null)
            {
                result = "Invalid Role Id";
            }

            //DataTable dt = db.GetRegisteredUserData("USP_PFLDELETEUserROLEData", Convert.ToInt32(UserRoleId));
            DataTable dt = SQL_DB.ExecuteDataTable("exec USP_SAGARDELETEUserROLEData '" + Convert.ToInt32(UserRoleId) + "'");
            if (Convert.ToInt32(dt.Rows[0][0]) == 1)
            {
                result = "User Deleted Successfully";
            }
            else
            {
                result = "Con't delete this user";
            }
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "GetUserType")
        {
            string Result = string.Empty;
            string userId = context.Request.QueryString["userId"];
            DataTable Usertype = SQL_DB.ExecuteDataTable("exec USP_HeadmechanicStatusCheck '"+userId+"'");
            if (Usertype.Rows.Count > 0)
            {
                Result = Usertype.Rows[0]["User_Type"].ToString() + "~" + Usertype.Rows[0]["isactive"].ToString() + "~" + Usertype.Rows[0]["RegisteredUser"].ToString();
            }
            else
            {
                Result = "Invalid";
            }
            context.Response.Write(Result);
        }
        else if (context.Request.QueryString["method"] == "Selectuser")
        {
            string result = string.Empty;
            Object Data = "";
            DataTable dt = new DataTable();
            string userId = context.Request.QueryString["userId"];
            if (!string.IsNullOrEmpty(userId))
            {
                string Usertype = SQL_DB.ExecuteScalar("select User_Type from tbl_users_SP where id='" + userId + "'").ToString();
                if (!string.IsNullOrEmpty(Usertype))
                {
                    dt = SQL_DB.ExecuteDataTable("select id,UserName from tbl_users_SP where User_Type='" + Usertype + "' and IsActive=1 and IsDelete=0 and id<>'"+userId+"' and District in(select District from tbl_users_SP where id='"+userId+"')  ");
                    if (dt.Rows.Count > 0)
                    {
                        Data = dt;
                    }
                }
                result = JsonConvert.SerializeObject(Data);
                context.Response.Write(result);
            }
            else
            {
                result = "False";
                context.Response.Write(result);
            }
        }
        else if (context.Request.QueryString["method"] == "UploadImageFile")
        {
            string imgpath = context.Request.QueryString["imgpath"].ToString();
            string UserId = context.Request.QueryString["UserId"].ToString();
            string filetype = context.Request.QueryString["filetype"].ToString();
            object result = UploadVrkabelFile(imgpath, UserId, filetype);
            context.Response.Write(result);
        }
    }

    public static string UploadVrkabelFile(string imgpath, string UserId, string filetype)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [User_ID] FROM [M_Consumer] where  [User_ID] = '" + UserId + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            DataTable dt = new DataTable();
            if (filetype == "Img1")
            {
                dt= SQL_DB.ExecuteDataTable("exec USP_UploadShoping_SP 'Img1','" + imgpath + "' , '" + UserId + "'");
            }
            else if (filetype == "Img2")
            {
               dt= SQL_DB.ExecuteDataTable("exec USP_UploadShoping_SP 'Img2','" + imgpath + "' , '" + UserId + "'");
            }
            else if (filetype == "Img3")
            {
               dt= SQL_DB.ExecuteDataTable("exec USP_UploadShoping_SP 'Img3','" + imgpath + "' , '" + UserId + "'");
            }
        }
        else
        {
        }
        return imgpath;
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}