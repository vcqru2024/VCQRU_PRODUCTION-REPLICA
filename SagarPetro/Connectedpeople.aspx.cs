using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SagarPetro_Connectedpeople : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Comp_ID"] == null)
            Response.Redirect("../SagarPetro/Loginpfl.aspx");
        bindUser(ddlusertype.SelectedItem.Value);
    }
    public void bindUser(string selecteditem)
    {
        DataTable dt = new DataTable();
        if (selecteditem == "4")
        {
            dt = SQL_DB.ExecuteDataTable("USP_ConectedpeopleManager_sp");
        }
        else if (selecteditem == "5")
        {
            dt = SQL_DB.ExecuteDataTable("USP_ConectedpeopleSalesExecutive_sp");
        }
        else if (selecteditem == "6")
        {
            dt = SQL_DB.ExecuteDataTable("exec USP_Conectedpeoplehead_sp");
        }

        gvNewUser.DataSource = dt;
        gvNewUser.DataBind();
    }

    protected void ddlusertype_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selecteditem = ddlusertype.SelectedItem.Value;
        bindUser(selecteditem);

    }
}