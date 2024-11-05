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
using System.IO;


public partial class codeupdate : System.Web.UI.Page
{
    public string json = "Response", ans = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Code1"] != null && Request.QueryString["Code2"] != null)
        {
  IVRDatalogs(Request.QueryString["Code1"].ToString(), Request.QueryString["Code1"].ToString(), "");
            UpdateCodeCount();
        }
    }
    public class Group
    {
        public string Status_Code;
        public string Status_Message;


    }

 private static void IVRDatalogs(string Mobile, string Content, string Response)
    {
        try
        {
            string filename = "SMSDatalogsCodeUpdate_" + System.DateTime.Today.ToString("yyyy-MM-dd");
            StreamWriter sr = new StreamWriter(HttpContext.Current.Server.MapPath("~/LogManager/IVRLogs/" + filename + ".txt"), true);
            sr.WriteLine(Content + " ||  " + Mobile + " ||  " + Response + " ||  " + DateTime.Now);

            sr.Close();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void UpdateCodeCount()
    {
        string Code1 = Request.QueryString["Code1"].ToString();
        string Code2 = Request.QueryString["Code2"].ToString();
        string Caller = "", Circle = "", Network = "";
        string time = string.Empty;
        string vdate = string.Empty;
        if (Request.QueryString["callerno"] != null)
            Caller = Request.QueryString["callerno"].ToString();
        if (Request.QueryString["callercircle"] != null)
            Circle = Request.QueryString["callercircle"].ToString();
        if (Request.QueryString["network"] != null)
            Network = Request.QueryString["network"].ToString();

        //if (Request.QueryString["time"] != null)
        //{
        //    time = Request.QueryString["time"].ToString();
        //    SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('IVR-" + time + "')");
        //}
        //if (Request.QueryString["date"] != null)
        //{
        //    vdate = Request.QueryString["date"].ToString();
        //    SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('IVR-" + vdate + "')");
        //}

        if (Request.QueryString["call_time"] != null)
        {
            time = Request.QueryString["call_time"].ToString();
           // SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('IVR-caller_time-" + time + "')");
        }
        if (Request.QueryString["call_date"] != null)
        {
            vdate = Request.QueryString["call_date"].ToString();
          //  SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('IVR-call_date-" + vdate + "')");
        }

#region Apply New logs for IVR Data status
        string RowData = " | Code1 : " + Code1 + " | Code2 : " + Code2 + " | callerno : " + Caller + " | callercircle : " + Circle + " | network : " + Network + "  | call_date : " + vdate + " | call_time : " + time;

        string Url = Request.Url.AbsoluteUri;
        IVRDatalogs(Caller, Url, RowData);
        #endregion

        Group Obj = new Group();
        string pp = JsonConvert.SerializeObject(json, Formatting.Indented);
        DataTable DtDetail = new DataTable();
        SQL_DB.GetDA("SELECT [Code1],[Code2],[comp_name],[prod_name],[MRP],[mfg_date],[exp_date],[Use_Count],[Batch_No],'http://www.VCQRU.com/Sound/'+[company_sound_file] as company_sound_file,'http://www.VCQRU.com/Sound/'+[product_sound_file] as product_sound_file,'http://www.VCQRU.com/Sound/'+[comment_english] as comment_english,'http://www.VCQRU.com/Sound/'+[comment_hindi] as comment_hindi FROM [VW_CheckCode] where Code1='" + Code1 + "' and Code2='" + Code2 + "'").Fill(DtDetail);
        if (DtDetail.Rows.Count <= 0)
        {
            Obj.Status_Code = "0";
            Obj.Status_Message = "Fail";
            ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
            SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network],[Is_Success],[callerdate],[callertime]) VALUES('IVR','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "','" + Caller + "','" + Code1 + "','" + Code2 + "','" + Circle + "','" + Network + "','" + Obj.Status_Code + "','"+ vdate + "','" + time + "')");
            return;
        }
        else if (DtDetail.Rows.Count > 0)
        {
            //SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('Count-" + DtDetail.Rows.Count + "')");
            if (DtDetail.Rows[0]["Use_Count"].ToString() == "1")
            {
              //  SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('IVR-Use_Count-" + DtDetail.Rows[0]["Use_Count"].ToString() + "')");
                Obj.Status_Code = "2";
                Obj.Status_Message = "Checked";
                ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
                SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network],[Is_Success],[callerdate],[callertime]) VALUES('IVR','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "','" + Caller + "','" + Code1 + "','" + Code2 + "','" + Circle + "','" + Network + "','" + Obj.Status_Code + "','" + vdate + "','" + time + "')");
            }
            else
            {
                //Obj.Status_Code = "1";
                //Obj.Status_Message = "Success";
                //ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
                //SQL_DB.ExecuteNonQuery("Update M_Code Set use_count=isnull(use_count,0)+1 where Code1='" + Code1 + "' and Code2='" + Code2 + "'");
                //SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network],[Is_Success],[callerdate],[callertime]) VALUES('IVR','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "','" + Caller + "','" + Code1 + "','" + Code2 + "','" + Circle + "','" + Network + "','" + Obj.Status_Code + "','" + vdate + "','" + time + "')");
                /////////////////////////////check service///////////////////////

                DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(Code1, Code2);

                DataTable dtServiceAssign = new DataTable();

                DataTable dtTotalCodesCount = new DataTable();

                if (dsServicesAssign.Tables.Count <= 2)

                {

                    dtServiceAssign = dsServicesAssign.Tables[0];

                    dtTotalCodesCount = dsServicesAssign.Tables[1];

                }

                if (dtServiceAssign.Rows.Count == 0)

                {

                    Obj.Status_Code = "0";

                    Obj.Status_Message = "Invalid";

                    ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";

                    SQL_DB.ExecuteNonQuery("Update M_Code Set use_count=isnull(use_count,0)+1 where Code1='" + Code1 + "' and Code2='" + Code2 + "'");

                    SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network],[Is_Success],[callerdate],[callertime]) VALUES('IVR','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "','" + Caller + "','" + Code1 + "','" + Code2 + "','" + Circle + "','" + Network + "','" + Obj.Status_Code + "','" + vdate + "','" + time + "')");



                }

                else

                {



                    Obj.Status_Code = "1";

                    Obj.Status_Message = "Success";

                    ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";

                    SQL_DB.ExecuteNonQuery("Update M_Code Set use_count=isnull(use_count,0)+1 where Code1='" + Code1 + "' and Code2='" + Code2 + "'");

                    SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network],[Is_Success],[callerdate],[callertime]) VALUES('IVR','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "','" + Caller + "','" + Code1 + "','" + Code2 + "','" + Circle + "','" + Network + "','" + Obj.Status_Code + "','" + vdate + "','" + time + "')");



                    //result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");

                }







                //////////////////////check service end///////////////////////////


                return;
            }
        }
        else
        {
            Obj.Status_Code = "1";
            Obj.Status_Message = "Success";
            ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
            SQL_DB.ExecuteNonQuery("Update M_Code Set use_count=isnull(use_count,0)+1 where Code1='" + Code1 + "' and Code2='" + Code2 + "'");
            SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network],[Is_Success],[callerdate],[callertime]) VALUES('IVR','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy H:mm:ss") + "','" + Caller + "','" + Code1 + "','" + Code2 + "','" + Circle + "','" + Network + "','" + Obj.Status_Code + "','" + vdate + "','" + time + "')");
            return;
        }

    }
}
