using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ExotelAPI_CodeRepeat : System.Web.UI.Page
{
    public string str="";
    protected void Page_Load(object sender, EventArgs e)
    {                
        if (Request.QueryString["callsid"] != null)
        {
            string Str=SQL_DB.ExecuteScalar("SELECT [Digits] FROM [IVRCodeCheck] where [Callsid]='" + Request.QueryString["callsid"].ToString() + "'").ToString();
            if (Str != "")
            {
                
                string code1 = Str.Substring(1, 5);code1 = string.Format("{0:0 0 0 0 0}",Convert.ToInt32(code1));
                string code2 = Str.Substring(6, 8);code2 = string.Format("{0:0 0 0 0 0 0 0 0}",Convert.ToInt64(code2));
                //Response.Write(Str + code1 + " and code 2 is " + code2);
                str=code1 + " and code 2 is " + code2;
                //Response.Write(code1 + " and code 2 is " + code2);
            }
        }
    }    
}