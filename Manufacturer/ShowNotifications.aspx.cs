using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_ShowNotifications : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["CompanyId"] == null)
            Response.Redirect("../default.aspx?Page=VendorCodeStatus.aspx");
        string counthit = "1";
        if (Session["CompanyId"].ToString() == "Comp-1713") // proquest
        {
            counthit = "5";
        }else if (Session["CompanyId"].ToString() == "Comp-1718" || Session["CompanyId"].ToString() == "Comp-1717" || Session["CompanyId"].ToString() == "Comp-1733") // proquest
        {
            counthit = "7";
        }
        else
        {
            counthit = "1";
        }

        DataTable dtdealer = SQL_DB.ExecuteDataTable("select Concat(code1,'-',code2)Code , Total,case when isread=0 then 'Blue' else 'Black' end as Class from tblNotification where Comp_ID='" + Session["CompanyId"].ToString() + "' and Total >='"+ counthit + "' order by IsRead ,CreationDate desc");

        if (dtdealer.Rows.Count != 0)
        {
            GrdNotifications.DataSource = dtdealer;
            GrdNotifications.DataBind();

        }

        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }


    }


    protected void GrdNotifications_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "select")
        {
            string Code = e.CommandArgument.ToString();

            string[] subs = Code.Split('-');

            string Code1 = subs[0].Trim();
            string Code2 = subs[1].Trim();

            DataTable dtdealer1 = SQL_DB.ExecuteDataTable("select MobileNo, Concat(Received_Code1,'-',Received_Code2)Code ,Enq_Date,case when is_Success=0 then 'Invalid' when Is_Success=1 then 'Success' else 'UnSuccess' end as Status from Pro_Enq where Received_Code1='" + Code1 + "' and Received_Code2='" + Code2 + "' order by Enq_Date desc");

            SQL_DB.ExecuteNonQuery("update tblNotification set IsRead=1 where Code1='" + Code1 + "' and code2='" + Code2 + "'");

            if (dtdealer1.Rows.Count != 0)
            {
                GridShowAllNot.DataSource = dtdealer1;
                GridShowAllNot.DataBind();

            }


            DataTable dtdealer = SQL_DB.ExecuteDataTable("select Concat(code1,'-',code2)Code , Total,case when isread=0 then 'Blue' else 'Black' end as Class  from tblNotification where Comp_ID='" + Session["CompanyId"].ToString() + "' order by IsRead,CreationDate desc");

            if (dtdealer.Rows.Count != 0)
            {
                GrdNotifications.DataSource = dtdealer;
                GrdNotifications.DataBind();

            }
            
        }
    }
}