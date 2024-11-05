using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_newuser : System.Web.UI.Page
{
    cls_patanjali db = new cls_patanjali();
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (Session["Comp_ID"] == null)
            Response.Redirect("../SagarPetro/Loginpfl.aspx");
        if (!IsPostBack)
        {
            
            bindUser();
        }


    }

    protected void gvNewUser_ItemDataBoundold(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            var isActive = Convert.ToBoolean(DataBinder.Eval(e.Item.DataItem, "IsActive"));
            var userId = DataBinder.Eval(e.Item.DataItem, "ID").ToString();
            var ltToggleAction = e.Item.FindControl("ltToggleAction") as Literal;

            if (ltToggleAction != null)
            {
                var color = isActive ? "green" : "red";
                ltToggleAction.Text = string.Format("<a type='button' class='dropdown-item' href='javascript:void(0);' onclick='Activeinactive(\"{0}\", {1})' style='color: {4};'>" +
                                                    "<i class='fas {2}'></i> {3}</a>",
                                                    userId,
                                                    isActive.ToString().ToLower(),
                                                     isActive ? "fa-toggle-on" : "fa-toggle-off",
                                                    isActive ? "Deactivate" : "Activate",
                                                    color);
            }
        }
    }

    protected void gvNewUser_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            var isActive = Convert.ToBoolean(DataBinder.Eval(e.Item.DataItem, "IsActive"));
            var userId = DataBinder.Eval(e.Item.DataItem, "ID").ToString();
            var ltToggleAction = e.Item.FindControl("ltToggleAction") as Literal;

            if (ltToggleAction != null)
            {
                var color = isActive ? "green" : "red";
                ltToggleAction.Text = string.Format("<a type='button' class='dropdown-item text-center' href='javascript:void(0);' onclick='Activeinactive(\"{0}\", {1})' style='color: {2}; font-size: 30px;'>" +
                                                    "<i class='fas {3}'></i></a>",
                                                    userId,
                                                    isActive.ToString().ToLower(),
                                                    color,
                                                    isActive ? "fa-toggle-on" : "fa-toggle-off");
            }
        }
    }



    public void bindUser()
    {
        DataTable dt = SQL_DB.ExecuteDataTable("exec USP_SagarUserDetails '"+Session["CompanyId"].ToString()+"'");
        if (dt.Rows.Count > 0)
        {
            gvNewUser.DataSource = dt;
            gvNewUser.DataBind();
        }
    }

    [WebMethod]
    public static string ToggleUserStatus(string userId)
    {
        return "User status toggled successfully.";
    }

    protected void btndownload_Click(object sender, EventArgs e)
    {
    }
}