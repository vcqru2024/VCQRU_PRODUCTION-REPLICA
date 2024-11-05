using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;


public partial class SagarPetro_uploadbanner : System.Web.UI.Page
{
    cls_message msg = new cls_message();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
        {
            Response.Redirect("~/loginpfl.aspx");
        }
    }
    protected void add_blog_Click1(object sender, EventArgs e)
    {
        if (blgimg.HasFile)
        {
            blgimg.SaveAs(Server.MapPath("~/assets/images/Vcqru") + Path.GetFileName(blgimg.FileName));
            string imgpath = "assets/images/Vcqru" + Path.GetFileName(blgimg.FileName);
            SQL_DB.ExecuteNonQuery("INSERT INTO Tbl_bannerVcqru (ImagePath,compid)values('" + imgpath + "','" + Session["CompanyId"].ToString() + "')");
            msg.ShowSuccessMessagewithredirect(this, "Banner Added Successfully", "../SagarPetro/bannersagar.aspx");
        }
        else
        {
            msg.ShowErrorMessage(this,"Please select banner");
        }
        
    }
}