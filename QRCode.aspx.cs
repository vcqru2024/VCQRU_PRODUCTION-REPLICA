using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class QRCode :  System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    private void Page_PreInit(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] != null)
        {
            string id = Request.QueryString["id"];
           string url = ConfigurationManager.AppSettings[id];
           // if (url != null || url != "")

if(id.Trim()=="1" || id.Trim() == "2" || id.Trim() == "3")
            {
              
                if(id.Trim() == "1")
                    Response.Redirect("https://www.worldofamrutanjan.com/amrutanjan-pain-balm-extra-power-1");
                else if (id.Trim() == "2")
                    Response.Redirect("https://www.worldofamrutanjan.com/amrutanjan-maha-strong-pain-balm");
                else
                    Response.Redirect("https://www.worldofamrutanjan.com/amrutanjan-maha-strong-pain-balm");

           
            }
else
Response.Redirect(url);

        }

    }
}