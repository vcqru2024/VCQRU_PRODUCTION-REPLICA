using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class gallery : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
    //con.Open();
    int num = 1;
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            // num = 1;
            Session["countNum"] = 1;
            BindRepeater(num);
        }

    }

    protected void BindRepeater(int numrows)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("select top "+ numrows + "* from tbl_event where is_activee='1' order by id desc ", con);
            System.Data.DataSet ds = new System.Data.DataSet();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds1 = SQL_DB.ExecuteDataSet("select id from tbl_event where is_activee='1' order by id desc ");
          
            if (ds1.Tables[0].Rows.Count <= numrows)
            {
                btnLoadMore.Visible = false;
            }
            sda.Fill(ds);
            datalist1.DataSource = ds;
            datalist1.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message.ToString());
        }

    }

    protected void btnLoadMore_Click(object sender, EventArgs e)
    {
        Session["countNum"] = Convert.ToInt32(Session["countNum"]) + 1;
        BindRepeater(Convert.ToInt32(Session["countNum"]));
    }

}