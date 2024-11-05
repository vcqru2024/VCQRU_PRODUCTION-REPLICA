using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_Feedback : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       

        if (Session["CompanyId"] == null)
        {
            Response.Redirect("/Login.aspx");

        }


        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }

        if (!Page.IsPostBack)
        {

            DataTable dtdealer = SQL_DB.ExecuteDataTable("select*from EventFeedback order by Date desc");
            if (dtdealer.Rows.Count != 0)
            {
                GridView1.DataSource = dtdealer;
                GridView1.DataBind();

            }
            else
            {

                GridView1.DataSource = "";
                GridView1.DataBind();
            }

            //if (GridView1.Rows.Count > 0)
            //    GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;

        }
    }
}