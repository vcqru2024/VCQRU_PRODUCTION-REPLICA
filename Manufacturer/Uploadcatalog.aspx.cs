using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_Uploadcatalog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void add_blog_Click1(object sender, EventArgs e)
    {

        try
        {
            if (blgimg.HasFile)
            {
                var extension = System.IO.Path.GetExtension(blgimg.FileName);
                if (extension.ToLower() == ".pdf")
                {
                    blgimg.SaveAs(Server.MapPath("~/assets/images/Vcqru") + Path.GetFileName(blgimg.FileName));
                    string imgpath = "assets/images/Vcqru" + Path.GetFileName(blgimg.FileName);
                    SQL_DB.ExecuteNonQuery("INSERT INTO Tbl_Catalog (Path,compid)values('" + imgpath + "','" + Session["CompanyId"].ToString() + "')");
                    Response.Redirect("Catalog.aspx");
                }

                else
                {
                    lblmsgHeader.Text = "Please upload pdf files..";
                }
            }

            else
            {
                if (!blgimg.HasFile)
                {
                    lblmsgHeader.Text = "Please upload the file..";
                }
            }
        }

        catch (Exception ex)
        {
            lblmsgHeader.Text = ex.Message;
        }



       
       
    }
}