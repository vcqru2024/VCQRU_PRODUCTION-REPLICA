using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SagarPetro_ViewConnectedpeople : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Comp_ID"] == null)
            Response.Redirect("../SagarPetro/Loginpfl.aspx");
        string id = Request.QueryString["id"];
        string type = Request.QueryString["type"];
        if (!string.IsNullOrEmpty(id) && !string.IsNullOrEmpty(type))
        {
            bindUser(id, type);
        }
    }

    public void bindUser(string id,string type)
    {
        DataTable dt = SQL_DB.ExecuteDataTable("exec USP_ConectedpeopleDetails_sp '" + id + "','"+ type + "'");
        if (dt.Rows.Count > 0)
        {
            gvNewUser.DataSource = dt;
            gvNewUser.DataBind();
        }
    }

    protected void btnback_Click(object sender, EventArgs e)
    {
        Response.Redirect("../SagarPetro/Connectedpeople.aspx");
    }
}