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
using DataProvider;
using Business_Logic_Layer;
using System.Data.SqlClient;
using CodesGenuinity;
using System.Net;
using System.Text;
using System.IO;
using ExotelSDK;


public partial class updateStatus : System.Web.UI.Page
{
    public string json = "Response", ans = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        /*if (Request.QueryString["Code1"] != null && Request.QueryString["Code2"] != null)
        {
            UpdateCodeCount();
        }*/
        #region Code
        string Code1 = "";
        string Code2 = "";
        if (Request.QueryString["Code1"] != null)
            Code1 = Request.QueryString["Code1"];
        if (Request.QueryString["Code2"] != null)
            Code2 = Request.QueryString["Code2"];
        if (Code1 != "" && Code2 != "")
        {

            /* This Code is Old Which is Bind From M_Code */
            //UpdateCodeCount();

            Business9420.Object9420 Reg = new Business9420.Object9420();
            Reg.Received_Code1 = Code1;
            Reg.Received_Code2 = Code2;
            /* This Code is Bind From M_Code Tables */
            //DataSet ds = Business9420.function9420.FindCheckeCodes(Reg);
            /* This Code is Bind From M_Code Dynamic Tables According to Suffix */
            DataSet ds = Business9420.function9420.FindCheckCodes(Reg);


            Reg.Pro_ID = ds.Tables[0].Rows[0]["Pro_ID"].ToString();
            DataTable sdt = Business9420.function9420.GetAllServices(Reg);
            int skip = 0; bool skpflag = false;
            if (sdt.Rows.Count > 0)
            {                
                for (int p = 0; p < sdt.Rows.Count; p++)
                {
                    if (sdt.Rows[p]["Service_ID"].ToString() == "SRV1018")
                    {
                        skip = p; skpflag = true;
                        break;
                    }
                }
            }



            /* This Code is Old Which is Bind From M_Code According to Suffix */
            string ApiType = "Solution";
            string MobileNo = "", Circle = "", Network = "";
            if (Request.QueryString["caller"] != null)
                MobileNo = Request.QueryString["caller"].ToString();
            #region CheckGeneuity            
            string Msg = CheckGenuinity.Genuinity(Code1, Code2, MobileNo, "IVR", MobileNo, "Solution","","","","","");            
            string[] Arr = Msg.ToString().Split('*');
            if (Arr.Length > 1)
            {
                if (Arr[1].ToString() != "")
                {
                    string[] NArr = Arr[1].ToString().Split('@');                    
                    for (int i = 0; i < NArr.Length; i++)
                    {
                        if (skpflag)
                        {
                            if(skip != i)
                                SendSms(NArr[i].ToString(), MobileNo, ApiType);
                        }
                        else
                            SendSms(NArr[i].ToString(), MobileNo, ApiType);
                    }
                }
            }
            #endregion
        }
        else
        {
            string pp = JsonConvert.SerializeObject(json, Formatting.Indented);
            Group Obj = new Group();
            if (Request.QueryString["Code1"] != null)
                Code1 = Request.QueryString["Code1"];
            if (Request.QueryString["Code2"] != null)
                Code2 = Request.QueryString["Code2"];
            if ((Code1 == "") && (Code2 == ""))
            {
                Obj.Status_Code = "0";
                Obj.Status_Message = "Parameters not found.";
                ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
                return;
            }
            else if (Code1 != "" && Code2 == "")
            {
                Obj.Status_Code = "0";
                Obj.Status_Message = "Parameters Code2 not found.";
                ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
                return;
            }
            else if (Code1 == "" && Code2 != "")
            {
                Obj.Status_Code = "0";
                Obj.Status_Message = "Parameters Code1 not found.";
                ans = "{" + pp + ":" + JsonConvert.SerializeObject(Obj, Formatting.Indented) + "}";
                return;
            }
        }
        #endregion
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
        #region This is actual code for Brand Loyalty Hindi and English Comments File
        //SqlParameter ParmCode1 = new SqlParameter("Code1",Convert.ToInt32(Code1));
        //SqlParameter ParmCode2 = new SqlParameter("Code2",Convert.ToInt64(Code2));
        //DtDetail = DataProvider.Procedure.GetProcedureData("PROC_GetPlayfileInfo", ParmCode1, ParmCode2);
        #endregion
        DtDetail = SQL_DB.ExecuteDataTable("SELECT  mcode.Code1, mcode.Code2, creg.Comp_Name AS comp_name, preg.Pro_Name AS prod_name, tpro.MRP, mcode.Use_Count AS attempt_number, tpro.Mfd_Date AS mfg_date, " +
        " 'http://www.vcqru.com/Data/Sound/'+substring(creg.Comp_ID,6,4)+'/'+substring(creg.Comp_ID,6,4)+'.wav' as company_sound_file,'http://www.vcqru.com/Data/Sound/'+substring(creg.Comp_ID,6,4)+'/'+mcode.Pro_ID+'/'+mcode.Pro_ID+'.wav' as product_sound_file, '' as comment_english, '' as comment_hindi," +
        " tpro.Exp_Date AS exp_date, mcode.Use_Count, tpro.Batch_No,preg.Pro_ID FROM M_Code" + Code2.ToString().Substring(6, 2) + " AS mcode INNER JOIN Pro_Reg AS preg ON mcode.Pro_ID = preg.Pro_ID INNER JOIN Comp_Reg AS creg ON preg.Comp_ID = creg.Comp_ID INNER JOIN " +
        "T_Pro AS tpro ON mcode.Batch_No = tpro.Row_ID WHERE  mcode.Code1 = '" + Code1 + "'  AND mcode.Code2 = '" + Code2 + "'");
        //SQL_DB.GetDA("SELECT [Code1],[Code2],[comp_name],[prod_name],[MRP],[mfg_date],[exp_date],[Use_Count],[Batch_No],'http://www.label9420.com/Sound/'+[company_sound_file] as company_sound_file,'http://www.label9420.com/Sound/'+[product_sound_file] as product_sound_file,'http://www.label9420.com/Sound/'+[comment_english] as comment_english,'http://www.label9420.com/Sound/'+[comment_hindi] as comment_hindi FROM [VW_CheckCode] where Code1='" + Code1 + "' and Code2='" + Code2 + "'").Fill(DtDetail);
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
            //*************** Brand Loyalty Code start ******************//
            string LoyaltyMessage = "";
            LoyaltyMessage = GetMyMessage(Caller, Code1, Code2);
            //*************** Brand Loyalty Code end ******************//
            return;
        }

    }
    //*************** Brand Loyalty Code start ******************//
    private string GetMyMessage(string MobileNo, string Code1, string Code2)
    {
        string UserID = ""; string Msg = ""; string NewMsg = ""; string MyPointMsg = "";
        DataTable dt = SQL_DB.ExecuteDataSet("SELECT Pro_ID,Use_Count FROM M_Code WHERE Code1 = '" + Code1 + "' AND Code2='" + Code2 + "'").Tables[0];
        if (dt.Rows.Count > 0)
        {
            string Pro_ID = dt.Rows[0]["Pro_ID"].ToString();
            DataTable dst = SQL_DB.ExecuteDataSet("SELECT [Comp_ID],[Comments],[Points],[DateFrom],[DateTo],[Frequency] FROM M_Loyalty WHERE IsActive = 0 AND IsDelete = 0 AND Pro_ID='" + Pro_ID + "'").Tables[0];
            if (dst.Rows.Count > 0)
            {
                DataTable dts = SQL_DB.ExecuteDataSet("SELECT MobileNo,User_ID FROM  M_Consumer WHERE MobileNo = '" + MobileNo + "'").Tables[0];
                if(dts.Rows.Count > 0)
                    UserID = dts.Rows[0]["User_ID"].ToString();
                else if (dts.Rows.Count == 0)
                {
                    #region Registration
                    Random rnd = new Random();
                    User_Details Log = new User_Details();
                    Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
                    Log.ConsumerName = null;
                    Log.Email = null;
                    Log.MobileNo = MobileNo;
                    Log.City = null;
                    Log.PinCode = null;
                    Log.Password = rnd.Next(10000, 99999).ToString();
                    Log.IsActive = 0;
                    Log.IsDelete = 0;
                    Log.DML = "I";
                    User_Details.InsertUpdateUserDetails(Log);
                    string sms_send_str = "You are registered with Label9420.com YOUR USER ID IS " + MobileNo +" AND PASSWORD IS " + Log.Password;
                    //MySmsAPI.SendSms(sms_send_str.Replace(" ", "+"), MobileNo);
                    SendSms(sms_send_str.Replace(" ", "+"), MobileNo, "Solution");
                    #endregion
                    UserID = Log.User_ID;
                }
                Msg = dst.Rows[0]["Comments"].ToString() + " " + dst.Rows[0]["Points"].ToString() + " Points";
                NewMsg = dst.Rows[0]["Comments"].ToString(); MyPointMsg = dst.Rows[0]["Points"].ToString();
                #region Entry For Earn Points
                #region Logic For Frequency
                DataTable td = SQL_DB.ExecuteDataSet("SELECT * FROM T_Points WHERE User_ID='" + UserID + "' AND Pro_ID ='" + Pro_ID + "' AND IsUse = 0").Tables[0];
                Int32 Frequency = 0, GetFrequency = 0, AcFrequency = 0; Frequency = Convert.ToInt32(dst.Rows[0]["Frequency"]); AcFrequency = Frequency;
                if (td.Rows.Count > 0)
                    GetFrequency = Convert.ToInt32(td.Rows.Count);
                Frequency = ((Frequency > 1) ? (Frequency - 1) : 1);
                #endregion
                int chk = Convert.ToInt32(dt.Rows[0]["Use_Count"]);
                if (chk == 0)
                {
                    Loyalty_Points Reg = new Loyalty_Points();
                    Reg.User_ID = UserID;
                    Reg.MobileNo = MobileNo;
                    Reg.Code1 = Convert.ToInt64(Code1);
                    Reg.Code2 = Convert.ToInt64(Code2);
                    Reg.Mode = "IVR";
                    Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
                    if (dst.Rows.Count > 0)
                    {
                        Reg.Comp_ID = dst.Rows[0]["Comp_ID"].ToString(); Reg.Pro_ID = Pro_ID;
                        if (chk == 0)
                        {
                            if (dst.Rows.Count > 0)
                            {
                                bool ChkFlag = false;
                                string Dt1 = dst.Rows[0]["DateFrom"].ToString(); string Dt2 = dst.Rows[0]["DateTo"].ToString();
                                if ((Dt1 != "") && (Dt2 != ""))
                                {
                                    if ((Convert.ToDateTime(dst.Rows[0]["DateFrom"]) <= Convert.ToDateTime(Reg.Entry_Date)) && (Convert.ToDateTime(dst.Rows[0]["DateTo"]) >= Convert.ToDateTime(Reg.Entry_Date)))
                                        ChkFlag = true;
                                    else
                                        ChkFlag = false;
                                }
                                else if ((Dt1 != "") && (Dt2 == ""))
                                    ChkFlag = true;
                                else if ((Dt1 == "") && (Dt2 == ""))
                                    ChkFlag = true;
                                ChkFlag = CheckCode1Code2(Code1, Code2);
                                if (ChkFlag)
                                {
                                    if (Frequency > 0)
                                    {
                                        Reg.Points = (((AcFrequency == 1) || (Frequency == GetFrequency)) ? Convert.ToDecimal(dst.Rows[0]["Points"]) : 0);
                                        if (Reg.Points == 0)
                                            Msg = "You win " + MyPointMsg.ToString() + " Points to " + GetNext(Frequency - GetFrequency) + " Next Purchage ";
                                    }
                                    else
                                        Reg.Points = Convert.ToDecimal(dst.Rows[0]["Points"]);
                                    Reg.EarnType = "Earn";
                                    Reg.DML = "I";
                                    try
                                    {
                                        Loyalty_Points.InsertUpdatePoints(Reg);
                                        if (Reg.Points > 0)
                                            SQL_DB.ExecuteDataSet("UPDATE T_Points SET IsUse = 1 WHERE User_ID='" + UserID + "' AND Pro_ID ='" + Pro_ID + "' AND IsUse = 0");
                                    }
                                    catch (Exception ex)
                                    {

                                    }
                                }
                            }
                        }
                    }
                }
                #endregion
            }
        }
        return Msg;
    }
    private string GetNext(Int32 i)
    {
        string Msg = "";
        switch (i)
        {
            case 2:
                {
                    Msg = i.ToString() + "nd";
                    break;
                }
            case 3:
                {
                    Msg = i.ToString() + "rd";
                    break;
                }
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
                {
                    Msg = i.ToString() + "th";
                    break;
                }
            default:
                {
                    Msg = "";
                    break;
                }
        }
        return Msg;
    }
    private bool CheckCode1Code2(string Code1, string Code2)
    {
        DataTable dt = SQL_DB.ExecuteDataSet("select * from T_Points WHERE Code1= '"+ Code1 +"' AND Code2 = '"+ Code2 +"' ").Tables[0];
        if (dt.Rows.Count > 0)
            return false;
        else
            return true;
    }
    //*************** Brand Loyalty Code end ******************//


    #region Send SMS
    public static void SendSms(string Message, string phone, string ApiType)
    {

        string str = "";
        try
        {
            //http://sms.bsmart.in:8080/smart/SMSmartSendSMS.jsp?http://sms.bsmart.in:8080/smart/SmartSendSMS.jsp
            //str = "http://sms.bsmart.in:8080/smart/SMSmartSendSMS.jsp?usr=LABEL9420&pass=LABEL890&sid=LBVRFY&GSM=" + phone + "&msg=" + Message + "&mt=0";
            //str = "http://193.105.74.58/api/v3/sendsms/plain?user=LABEL9420&password=Sid2014!&sender=labeld&SMSText=" + Message + "&GSM=" + phone;
            //str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A7285cc769f5ed203e7d8cee48444dbb8&sender=SIDEMO&to=" + phone + "&message=" + Message;

            //str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A3f78a344d70a9e35c006e938f428f591&sender=LBVRFY&to=" + phone + "&message=" + Message;
            if (ApiType == "Solution")
            {
                str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A3f78a344d70a9e35c006e938f428f591&sender=LBVRFY&to=" + phone + "&message=" + Message;
                WebRequest request = WebRequest.Create(str);
                request.Method = "POST";
                string postData = "";
                byte[] byteArray = Encoding.UTF8.GetBytes(postData);
                request.ContentType = "application/x-www-form-urlencoded";
                request.ContentLength = byteArray.Length;
                Stream dataStream = request.GetRequestStream();
                dataStream.Write(byteArray, 0, byteArray.Length);
                dataStream.Close();
                WebResponse response = request.GetResponse();
                Console.WriteLine(((HttpWebResponse)response).StatusDescription);
                dataStream = response.GetResponseStream();
                StreamReader reader = new StreamReader(dataStream);
                string responseFromServer = reader.ReadToEnd();
                Console.WriteLine(responseFromServer);
                reader.Close();
                dataStream.Close();
                response.Close();
            }
            else if (ApiType == "BSmart")
            {
                //str = "http://193.105.74.58/api/v3/sendsms/plain?user=LABEL9420&password=Sid2014!&sender=labeld&SMSText=" + Message + "&GSM=" + phone;
                SendSMS s = new SendSMS("label94201", "f0781cb79f9bd13b8d86ef226f26eb53f9613f45");
                string response = s.execute("9212889420", phone, Message);
                //Response.Write(response);
            }


        }
        catch
        {
        }
    }
    #endregion
}
