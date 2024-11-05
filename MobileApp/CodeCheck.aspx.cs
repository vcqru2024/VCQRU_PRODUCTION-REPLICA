using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Newtonsoft.Json;
using Business_Logic_Layer;
using Business9420;
using System.Net;
using System.IO;
using System.Text;
using CodesGenuinity;
using DataProvider;

public partial class MobileApp_CodeCheck : System.Web.UI.Page
{
    public string json = "Response", ans = "";
    protected void Page_Load(object sender, EventArgs e)
    
    {
        LogManager.WriteExe(Request.QueryString["Code1"].ToString());
        LogManager.WriteExe(Request.QueryString["Code2"].ToString());
        LogManager.WriteExe(Request.QueryString["MobileNo"].ToString());
        LogManager.WriteExe(Request.QueryString["Mode"].ToString());
        LogManager.WriteExe(Request.QueryString["DeviceToken"].ToString());
        if ((Request.QueryString["Code1"] != null) && (Request.QueryString["Code2"] != null) && (Request.QueryString["MobileNo"] != null) && (Request.QueryString["Mode"] != null) && (Request.QueryString["DeviceToken"] != null))
        {
            string Code1 = Request.QueryString["Code1"].ToString();
            string Code2 = Request.QueryString["Code2"].ToString();
            string ContactNo = Request.QueryString["MobileNo"].ToString();
            string Mode = Request.QueryString["Mode"].ToString();
            string DeviceToken = Request.QueryString["DeviceToken"].ToString();
            // CheckGenuinity(ContactNo, "", Code1, Code2,Mode,DeviceToken);
            string str = CheckGenuinity.Genuinity(Code1, Code2, ContactNo, Mode, DeviceToken, "", "", null, "", "Solution");

            string[] Arr = str.ToString().Split('*');

            Label lblRegMsg = new Label();
            if (Arr.Length > 1)
            {
                //// if (Arr[1].ToString() != "")
                //{
                //    //     string[] NArr = Arr[1].ToString().Split('@');
                //    //     if (NArr.Length > 0)
                //    {
                //        for (int i = 0; i < Arr.Length; i++)
                //        {
                //            SendSms(Arr[i].ToString(), MobileNo, Type);
                //        }
                //    }
                //}

                if (Arr[1].ToString() != "")
                {
                    //string[] NArr = Arr[1].ToString().Split('@');
                    int counter = 1; lblRegMsg.Text = string.Empty;
                    for (int i = 0; i < Arr.Length; i++)
                    {
                        lblRegMsg.Text += counter.ToString() + "." + Arr[i].ToString() + " ";
                        counter++;
                    }
                }
                //if (Arr[1].ToString() != "")
                //{
                //    string[] NArr = Arr[1].ToString().Split('@');
                //    int counter = 1; lblRegMsg.Text = string.Empty;
                //    for (int i = 0; i < NArr.Length; i++)
                //    {
                //        lblRegMsg.Text += counter.ToString() + "." + NArr[i].ToString() + " ";
                //        counter++;
                //    }
                //}
            }

            string pp = JsonConvert.SerializeObject(json, Formatting.Indented);
            Msg Obj = new Msg();
            Obj.Status_Code = "1";
            //Obj.Status_Message = Arr[1].ToString();
            Obj.Status_Message = lblRegMsg.Text;
            ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
            return;

            //Response.Redirect(""+ ProjectSession.absoluteSiteBrowseUrl +"/MobileApp/CodeCheck.aspx?message=" + lblRegMsg.Text.ToString());
            //Response.Redirect("http://vcqru.com/MobileApp/CodeCheck.aspx?message=" + lblRegMsg.Text.ToString());
            //return;
        }
        else
        {
            string pp = JsonConvert.SerializeObject(json, Formatting.Indented);
            Msg Obj = new Msg();
            Obj.Status_Code = "0";
            Obj.Status_Message = "Invalid Parameters";
            ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
            return;
        }
    }


}
public class Msg
{
    public string Status_Code;
    public string Status_Message;
}