using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Newtonsoft.Json;


public partial class FrmCodeUse : System.Web.UI.Page
{
    public string json = "Response", ans = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Code1"] != null && Request.QueryString["Code2"] != null)
        {
            UpdateCodeCount();
        }
    }
    public class Group
    {
        public string Status_Code;
        public string Status_Message;


    }

    private void UpdateCodeCount()
    {
        string Code1 = Request.QueryString["Code1"].ToString();
        string Code2 = Request.QueryString["Code2"].ToString();
        string Caller = "", Circle = "", Network = "";
        if (Request.QueryString["caller"] != null)
            Caller = Request.QueryString["caller"].ToString();
        if (Request.QueryString["circle"] != null)
            Circle = Request.QueryString["circle"].ToString();
        if (Request.QueryString["network"] != null)
            Network = Request.QueryString["network"].ToString();
        Group Obj = new Group();
        string pp = JsonConvert.SerializeObject(json, Formatting.Indented);
        DataTable DtDetail = new DataTable();
        SQL_DB.GetDA("SELECT [Code1],[Code2],[comp_name],[prod_name],[MRP],[mfg_date],[exp_date],[Use_Count],[Batch_No],'http://www.VCQRU.com/Sound/'+[company_sound_file] as company_sound_file,'http://www.VCQRU.com/Sound/'+[product_sound_file] as product_sound_file,'http://www.VCQRU.com/Sound/'+[comment_english] as comment_english,'http://www.VCQRU.com/Sound/'+[comment_hindi] as comment_hindi FROM [VW_CheckCode] where Code1='" + Code1 + "' and Code2='" + Code2 + "'").Fill(DtDetail);
        if (DtDetail.Rows.Count <= 0)
        {
            Obj.Status_Code = "0";
            Obj.Status_Message = "Fail";
            ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
            SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[Mode_Detail],[Received_Code1],[Received_Code2],[Circle],[Network],[Is_Success]) VALUES('IVR','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "','" + Caller + "','" + Code1 + "','" + Code2 + "','" + Circle + "','" + Network + "','" + Obj.Status_Code + "')");
            return;
        }
        else
        {
            Obj.Status_Code = "1";
            Obj.Status_Message = "Success";
            ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
            SQL_DB.ExecuteNonQuery("Update M_Code Set use_count=isnull(use_count,0)+1 where Code1='" + Code1 + "' and Code2='" + Code2 + "'");
            SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[Mode_Detail],[Received_Code1],[Received_Code2],[Circle],[Network],[Is_Success]) VALUES('IVR','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "','" + Caller + "','" + Code1 + "','" + Code2 + "','" + Circle + "','" + Network + "','" + Obj.Status_Code + "')");
            return;
        }

    }
}
