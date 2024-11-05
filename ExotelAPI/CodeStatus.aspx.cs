using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Newtonsoft.Json;

public partial class ExotelAPI_CodeStatus : System.Web.UI.Page
{
    public string json = "Response", ans = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["callsid"] != null)
        {
            DataTable DtCall = new DataTable();
            SQL_DB.GetDA("SELECT [Digits],[Language] FROM [IVRCodeCheck] where [Callsid]='" + Request.QueryString["callsid"].ToString() + "'").Fill(DtCall);
            if (DtCall.Rows.Count > 0)
            {
                string code1 = DtCall.Rows[0]["Digits"].ToString().Substring(1, 5);
                string code2 = DtCall.Rows[0]["Digits"].ToString().Substring(6, 8);
                string CommentPath = "";
                string pp = JsonConvert.SerializeObject(json, Formatting.Indented);
                DataTable DtDetail = new DataTable();
                SQL_DB.GetDA("SELECT [Use_Count] FROM [VW_CheckCode] where Code1='" + code1 + "' and Code2='" + code2 + "'").Fill(DtDetail);
                if (DtDetail.Rows.Count > 0)
                {
                    if (DtDetail.Rows[0]["Use_Count"].ToString() == "0")
                    {
                        Message Obj = new Message();
                        Obj.select = "Correct";
                        //ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
			ans = JsonConvert.SerializeObject(Obj, Formatting.Indented) ;
                        return;
                    }
                    else if (Convert.ToInt32(DtDetail.Rows[0]["Use_Count"]) > 0)
                    {                        
                        Message Obj = new Message();
                        Obj.select = "Repeat";
                        //ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
			ans = JsonConvert.SerializeObject(Obj, Formatting.Indented) ;
                    }

                }
                else
                {
                    Message Obj = new Message();
                    Obj.select = "Invalid";
                    //ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
		    ans = JsonConvert.SerializeObject(Obj, Formatting.Indented) ;
                }
                
            } 
        }
        
        
    }
}
public class Message
{
    public string select { get; set; }    
}