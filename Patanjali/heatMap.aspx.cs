using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_heatMap : System.Web.UI.Page
{
    cls_patanjali db = new cls_patanjali();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../patanjali/loginpfl.aspx?Page=heatMap");
        if (!IsPostBack)
        {
            #region User Log 
            if (Session["UserName"] != null)
            {
                db.ExceptionLogs("Visited On HeatMap", Session["UserName"].ToString(), "R");
            }
            else
            {
                db.ExceptionLogs("Visited On HeatMap", Session["Comp_Name"].ToString(), "R");
            }
            #endregion
        }
    }
}