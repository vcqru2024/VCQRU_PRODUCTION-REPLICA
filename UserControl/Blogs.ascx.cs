using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;

public partial class UserControl_Blogs : System.Web.UI.UserControl
{
    public StringBuilder sbnews = new StringBuilder();
    protected void Page_Load(object sender, EventArgs e)
    {

   
        if (!IsPostBack)
        {
            //NewUpDate.FillGrid(GridView1);
            FillNewBlocks();
        }
    }
    private void FillNewBlocks()
    {
        DataSet ds = Data_Access_Layer.NewssUpDate.FillGridData();
        sbnews = new StringBuilder();
        if (ds.Tables[0].Rows.Count > 0)
        {
            //sbnews.Append("<div class='accordion2'>");
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                sbnews.Append("<h3>" + ds.Tables[0].Rows[i]["News_heading"].ToString() + "<span class='ui-accordion-accordionspan'>" + Convert.ToDateTime(ds.Tables[0].Rows[i]["Updated_Date"]).ToString("MMM dd yyyy") + "</span></h3><div><p>" + ds.Tables[0].Rows[i]["News"].ToString() + "</p></div>");
                //    sbnews.Append("<h3>");
                //    sbnews.Append("<p class='date f_left'>"); sbnews.Append(Convert.ToDateTime(ds.Tables[0].Rows[i]["Updated_Date"]).ToString("MMM dd yyyy"));
                //    sbnews.Append("</p>");
                //    sbnews.Append("<p class='news_heading f_left'>");
                //    sbnews.Append(ds.Tables[0].Rows[i]["News_heading"].ToString() + " </p>");
                //    sbnews.Append("<div class='clr'>");
                //    sbnews.Append("</div>");
                //    sbnews.Append("</h3>");
                //    sbnews.Append("<div class='accord_cont'>");
                //    sbnews.Append(ds.Tables[0].Rows[i]["News"].ToString());
                //    sbnews.Append("<div class='clr'>");
                //    sbnews.Append("</div>");
                //    sbnews.Append("<div class='clr'>");
                //    sbnews.Append("</div>");
                //    sbnews.Append("</div>");
            }
            //sbnews.Append("</div>");
        }
    }
}