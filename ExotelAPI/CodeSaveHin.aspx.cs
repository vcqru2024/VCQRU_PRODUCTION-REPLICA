using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ExotelAPI_CodeSaveHin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["digits"] != null && Request.QueryString["callsid"] != null)
        {
            SQL_DB.ExecuteNonQuery("INSERT INTO [IVRCodeCheck] ([Callsid],[Digits],[Language]) VALUES ('" + Request.QueryString["callsid"].ToString() + "','" + Request.QueryString["digits"].ToString().Trim() + "','Hindi')");
        }
    }
}