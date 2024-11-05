using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class codeverify : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		//Response.Redirect("https://www.avvatarindia.com/authenticate");
		
        HdnID.Value = Request.QueryString["ID"];

	  if (HdnID.Value.ToString() == "4")
        {
            Response.Redirect("https://www.avvatarindia.com/authenticate");
        }

        if (Request.QueryString["ID"] == "FBNutrition" || Request.QueryString["ID"] == "ROYALMANUFACTURER" || Request.QueryString["ID"] == "GuruKripaEnterprises" || Request.QueryString["ID"] == "PARAG" || Request.QueryString["ID"] == "AnkeriteHealth" || Request.QueryString["ID"] == "Chase2")
        {
            //HdnID.Value = Request.QueryString["ID"];
            HdnCode1.Value = Request.QueryString["codeone"];
            HdnCode2.Value = Request.QueryString["codetwo"];

        }

    }


}