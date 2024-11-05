using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class JALBATH : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["ID"] == "1")
        {
            HdnID.Value = Request.QueryString["ID"];

        }


        else if (Request.QueryString["ID"] == "JALBATH")
        {
            HdnID.Value = Request.QueryString["ID"];
            HdnCode1.Value = Request.QueryString["codeone"];
            HdnCode2.Value = Request.QueryString["codetwo"];
            CompName.Value = Request.QueryString["Comp"];

        }
        if(!IsPostBack)
        {
            //BindState();
        }

    }
    //public void BindState()
    //{
    //    SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
    //    con.Open();
    //    SqlCommand cmd = new SqlCommand("select*from tbl_jal_statelist",con);
    //    SqlDataAdapter da = new SqlDataAdapter(cmd);
    //    DataTable dt = new DataTable();
    //    da.Fill(dt);
    //    con.Close();
    //    ddlstate.DataSource = dt;
    //    ddlstate.DataValueField = "id";
    //    ddlstate.DataTextField = "State_name";
    //    ddlstate.DataBind();
    //    ddlstate.Items.Insert(0, new ListItem( "--Select State--","0"));
    //}
}