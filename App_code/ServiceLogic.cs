using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using System.Data;
using Business9420;
using System.Text.RegularExpressions;
using System.Configuration;
using Business_Logic_Layer;
using System.Net;
using System.Web.SessionState;
using System.Net.Mail;
using DataProvider;
using System.Text;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using paytm;
using System.Web.Script.Serialization;
using Newtonsoft.Json.Linq;
using System.Data.SqlClient;
using Newtonsoft.Json;
using System.Threading;

/// <summary>
/// Summary description for ServiceLogic
/// </summary>
public class ServiceLogic
{
    private static Database database = DatabaseFactory.CreateDatabase();
    private static DbCommand dbCommand;
    public static string strDialMode1;
    public static string str_GiftOrRaffle = "0";
    public static string str_IVR = string.Empty;
    public static string paytm_mobile;
    public static string paytm_codes;
    public static string srt = DataProvider.Utility.FindMailBody();

    public ServiceLogic()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string GetMobileNo(string MobileNo)
    {
        string result = string.Empty;
        #region Validate Mobile No (actual length entered by  user )
        if (MobileNo.Length < 10)
        {
            result = "Mobile No. must be 10 digits!";
        }
        if (MobileNo.Length == 11)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
            }
        }
        if (MobileNo.Length == 13)
        {
            MobileNo = MobileNo.Replace("+", "0");
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
            }
        }
        if (MobileNo.Length == 12)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
            if (initial == 91)
                MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
        }
        if (MobileNo.Length == 10)
            MobileNo = "91" + MobileNo;

        paytm_mobile = result = MobileNo;
        return result;
        #endregion
    }
    public static string GetNext(Int32 i)
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
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Code1"></param>
    /// <param name="Code2"></param>
    /// <returns></returns>
    private static bool CheckCode1Code2ByForPoints(string Code1, string Code2)
    {
        DataTable dt = SQL_DB.ExecuteDataSet("select * from T_Points WHERE Code1= '" + Code1 + "' AND Code2 = '" + Code2 + "' ").Tables[0];
        if (dt.Rows.Count > 0)
            return false;
        else
            return true;
    }

    #region //** Get ArtImages for patanajali
    public static DataSet GetAssignedArtImages(string Code1, string Code2, string CompId)
    {
        try
        {

            if (CompId == "Comp-1693")
                dbCommand = database.GetStoredProcCommand("GetAssignedArtImages_PFL");
            else
                dbCommand = database.GetStoredProcCommand("GetAssignedArtImages");

            database.AddInParameter(dbCommand, "@Code1", DbType.String, Code1);
            database.AddInParameter(dbCommand, "@Code2", DbType.String, Code2);

            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    #endregion

    public static DataSet FindCheckedCode_2(Object9420 Reg)
    {
        // this change is done by shweta  AND (Batch_No IS NOT NULL) , batch is a mandatory field for only counter fitting, for other services it is not mandatory.
        // And We ahve required field validator on Batch_No should not go null with Couter fitting service. 
        // dbCommand = database.GetSqlStringCommand("SELECT [Row_ID],[Code1],[Code2],ISNULL(Use_Count,0) AS Use_Count,[Pro_ID] FROM [M_Code] where ([DispatchFlag] = 1) AND ([ReceiveFlag] = 1) AND ([ScrapeFlag] =  0 OR [ScrapeFlag] IS NULL) AND convert(nvarchar,[Code1]) = '" + Reg.Received_Code1 + "' and convert(nvarchar,[Code2]) = '" + Reg.Received_Code2 + "'");
        //dbCommand = database.GetSqlStringCommand("SELECT [Row_ID],[Code1],[Code2],ISNULL(Use_Count,0) AS Use_Count,[Pro_ID] FROM [M_Code] where ([DispatchFlag] = 1) AND ([ReceiveFlag] = 1) AND (Batch_No IS NOT NULL) AND ([ScrapeFlag] =  0 OR [ScrapeFlag] IS NULL) AND convert(nvarchar,[Code1]) = '" + Reg.Received_Code1 + "' and convert(nvarchar,[Code2]) = '" + Reg.Received_Code2 + "'");
        //dbCommand = database.GetSqlStringCommand("SELECT [Row_ID],[Code1],[Code2],ISNULL(Use_Count,0) AS Use_Count,[Pro_ID] FROM [M_Code] where ([DispatchFlag] = 1) AND ([ReceiveFlag] = 1) AND (Batch_No IS NOT NULL) AND  ([ScrapeFlag] =  0 OR [ScrapeFlag] IS NULL) AND convert(nvarchar,[Code1]) = '" + Reg.Received_Code1 + "' and convert(nvarchar,[Code2]) = '" + Reg.Received_Code2 + "'");
        //dbCommand = database.GetSqlStringCommand("SELECT [Row_ID],[Code1],[Code2],ISNULL(Use_Count,0) AS Use_Count,[Pro_ID] FROM [M_Code] where ([DispatchFlag] = 1) AND ([ReceiveFlag] = 1) AND (Batch_No IS NOT NULL  OR [Batch_No] IS NULL) AND  ([ScrapeFlag] =  0 OR [ScrapeFlag] IS NULL) AND convert(nvarchar,[Code1]) = '" + Reg.Received_Code1 + "' AND convert(nvarchar,[Code2]) = '" + Reg.Received_Code2 + "'");

        if (Reg.Comp_ID == "Comp-1693")
            dbCommand = database.GetSqlStringCommand("SELECT [Row_ID],[Code1],[Code2],ISNULL(Use_Count,0) AS Use_Count,[Pro_ID] FROM [M_Code_PFL] where ([DispatchFlag] = 1) AND ([ReceiveFlag] = 1) AND (Batch_No IS NOT NULL  OR [Batch_No] IS NULL) AND  ([ScrapeFlag] =  0 OR [ScrapeFlag] IS NULL) AND [Code1] = " + Reg.Received_Code1 + " AND [Code2] = " + Reg.Received_Code2 + "");
        else
            dbCommand = database.GetSqlStringCommand("SELECT [Row_ID],[Code1],[Code2],ISNULL(Use_Count,0) AS Use_Count,[Pro_ID] FROM [M_Code] where ([DispatchFlag] = 1) AND ([ReceiveFlag] = 1) AND (Batch_No IS NOT NULL  OR [Batch_No] IS NULL) AND  ([ScrapeFlag] =  0 OR [ScrapeFlag] IS NULL) AND [Code1] = " + Reg.Received_Code1 + " AND [Code2] = " + Reg.Received_Code2);
        return database.ExecuteDataSet(dbCommand);
    }


    /// <summary>
    /// Brand Loyalty Started
    /// </summary>
    /// <param name="MobileNo"></param>
    /// <param name="Code1"></param>
    /// <param name="Code2"></param>
    /// <param name="Mode"></param>
    /// <returns></returns>
    private static string GetMyMessage(string MobileNo, string Code1, string Code2, string Mode)
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
                UserID = dts.Rows[0]["User_ID"].ToString();
                if (dts.Rows.Count == 0)
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
                    Reg.Mode = Mode;
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
                                ChkFlag = CheckCode1Code2ByForPoints(Code1, Code2);
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
                                        throw ex;
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

    public static string insertscrap(string code1, string code2, string Comp_id)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[Proc_insertscrap]");
            dbCommand.CommandTimeout = 500000;
            database.AddInParameter(dbCommand, "@Code1", DbType.String, code1);
            database.AddInParameter(dbCommand, "@Code2", DbType.String, code2);
            database.AddInParameter(dbCommand, "@comp_id", DbType.String, Comp_id);
            //database.AddInParameter(dbCommand, "@Pro_ID", DbType.String, Pro_ID);
            //database.AddInParameter(dbCommand, "@Series_Order", DbType.Int32, Series_Order);
            //database.AddInParameter(dbCommand, "@Series_Serial", DbType.Int32, Series_Serial);
            //database.AddInParameter(dbCommand, "@Series_Serial1", DbType.Int32, Series_Serial1);
            string y = database.ExecuteScalar(dbCommand).ToString();
            return y;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public static Dictionary<int, int> loyaltydistribution(Loyalty_Programm Reg)
    {

        Dictionary<int, int> loyaltydistribute = new Dictionary<int, int>();
        long amount = Reg.totalloyalty;
        int min = Reg.Minval;
        int max = Reg.Maxval;
        int multiple = Reg.multiple;
        long[] bundle = new long[(max - min) / multiple + 1];

        long codes = Reg.totalcode;
        long pending_amount = amount - (codes * min);
        int amnt = max - min;
        bundle[0] = codes;
        int i = bundle.Count() - 1;
        int mmt = 0;
        while (pending_amount > 0 && bundle[0] > 0)
        {
        xy:
            if (pending_amount >= amnt)
            {
                bundle[i] = bundle[i] + 1;
                pending_amount = pending_amount - amnt;
                bundle[mmt] = bundle[mmt] - 1;
                amnt = amnt - multiple;
                i--;
            }
            else
            {
                //if (bundle[mmt] == 0)
                //{
                //    mmt++;
                //    bundle[mmt] = bundle[mmt] - 1;
                //    pending_amount = pending_amount + mmt;
                //    amnt = max-1;
                //    i = bundle.Count() - 1;
                //}

                if (i >= mmt)
                {
                    amnt = amnt - multiple;
                    i--;
                    goto xy;
                }
                else
                {
                    amnt = max - min;
                    i = bundle.Count() - 1;
                }
            }
            //if(bundle[mmt]==0)
            //    {
            //        mmt++;
            //        pending_amount = pending_amount + mmt;
            //        amnt = max-1;
            //        i = bundle.Count() - 1;
            //    }
            if (i < mmt)
            {
                amnt = max - min;
                i = bundle.Count() - 1;

            }

        }
        mmt = 1;
        i = max - 1;
        amnt = max;
        while (pending_amount > 0)
        {
            if (bundle[mmt] > 0)
            {
                bundle[mmt] = bundle[mmt] - 1;
                pending_amount = pending_amount + mmt + 1;
                if (pending_amount <= max)
                {
                    bundle[pending_amount - 1] = bundle[pending_amount - 1] + 1;
                    amnt = max;
                    break;
                }
                pending_amount = pending_amount - amnt;
                bundle[i] = bundle[i] + 1;

                i--;
                amnt = amnt - multiple;
            }
            else
                mmt++;
            if (i < mmt)
            {
                amnt = max - multiple;
                i = bundle.Count() - 1;

            }
        }

        int y = max;
        for (int x = bundle.Length - 1; x >= 0; x--)
        {
            loyaltydistribute.Add(max, Convert.ToInt32(bundle[x]));
            max = max - multiple;
        }
        ////////////////////////////////////old logic for distribution////////////////////////////////////////////////
        //Dictionary<int, int> loyaltydistribute = new Dictionary<int, int>();
        //long[] bundle = new long[(Reg.Maxval - Reg.Minval) + 1];
        //long amount = Reg.totalloyalty;
        //int min = Reg.Minval;
        //int max = Reg.Maxval;
        //long codes = Reg.totalcode;
        //long pending_amount = amount - (codes * min);
        //int amnt = max - min;
        //bundle[0] = codes;
        //int i = bundle.Count() - 1;
        //int mmt = 0;
        //while (pending_amount > 0 && bundle[0] > 0)
        //{
        //xy:
        //    if (pending_amount >= amnt)
        //    {
        //        bundle[i] = bundle[i] + 1;
        //        pending_amount = pending_amount - amnt;
        //        bundle[mmt] = bundle[mmt] - 1;
        //        amnt--;
        //        i--;
        //    }
        //    else
        //    {
        //        //if (bundle[mmt] == 0)
        //        //{
        //        //    mmt++;
        //        //    bundle[mmt] = bundle[mmt] - 1;
        //        //    pending_amount = pending_amount + mmt;
        //        //    amnt = max-1;
        //        //    i = bundle.Count() - 1;
        //        //}

        //        if (i >= mmt)
        //        {
        //            amnt--;
        //            i--;
        //            goto xy;
        //        }
        //        else
        //        {
        //            amnt = max - min;
        //            i = bundle.Count() - 1;
        //        }
        //    }
        //    //if(bundle[mmt]==0)
        //    //    {
        //    //        mmt++;
        //    //        pending_amount = pending_amount + mmt;
        //    //        amnt = max-1;
        //    //        i = bundle.Count() - 1;
        //    //    }
        //    if (i < mmt)
        //    {
        //        amnt = max - min;
        //        i = bundle.Count() - 1;

        //    }

        //}
        //mmt = 1;
        //i = max - 1;
        //amnt = max;
        //while (pending_amount > 0)
        //{
        //    if (bundle[mmt] > 0)
        //    {
        //        bundle[mmt] = bundle[mmt] - 1;
        //        pending_amount = pending_amount + mmt + 1;
        //        if (pending_amount <= max)
        //        {
        //            bundle[pending_amount - 1] = bundle[pending_amount - 1] + 1;
        //            amnt = max;
        //            break;
        //        }
        //        pending_amount = pending_amount - amnt;
        //        bundle[i] = bundle[i] + 1;

        //        i--;
        //        amnt--;
        //    }
        //    else
        //        mmt++;
        //    if (i < mmt)
        //    {
        //        amnt = max - 1;
        //        i = bundle.Count() - 1;

        //    }
        //}

        //int y = max;
        //for (int x = bundle.Length - 1; x >= 0; x--)
        //{
        //    loyaltydistribute.Add(max, Convert.ToInt32(bundle[x]));
        //    max--;
        //}
        return loyaltydistribute;
    }
    public static string GetMessageFromM_TemplateMSg(DataTable dtTemplateMSG, string code1, string code2, string RowFilter)
    {
        string strMSG = string.Empty;

        if (dtTemplateMSG.Rows.Count > 0)
        {
            //}
            //else
            //{
            DataView dv = dtTemplateMSG.DefaultView;
            dv.RowFilter = RowFilter;// " Service_ID = 'InvalidCode'";
            DataTable fdt = dv.ToTable();

            if (fdt.Rows[0]["IsCustomise"].ToString() == "1")
            {
                //string paytmmessage = Paytm_Cash(paytm_mobile, P_cash, paytm_codes, dv, CompName);
                strMSG = fdt.Rows[0]["MsgBody"].ToString();
                if (strMSG.Contains("<CODE1>"))
                    strMSG = strMSG.Replace("<CODE1>", code1).Replace("<CODE2>", code2);
            }
            else
            {
                strMSG = fdt.Rows[0]["MsgBody"].ToString();
                if (strMSG.Contains("<CODE1>"))
                    strMSG = strMSG.Replace("<CODE1>", code1).Replace("<CODE2>", code2);


            }

        }
        return strMSG;
    }

    public static string SendMailExibition(string name, string email, string comment, string subject = null)
    {
        string result = "";

        if (subject == null)
        {
            subject = "Thanks for connecting to VCQRU.";

        }
        #region Mail Structure
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='https://www.vcqru.com/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +


        " <strong> " + comment + " <br />" +
        " Thank VCQRU.   <br />" +
        " <p>" +
        " <div class='w_detail'>" +
        " Assuring you  of  our best services always.<br />" +
        " Thank you,<br /><br />" +
        " Team <em><strong>VCQRU.COM,</strong></em><br />" +
        "  " + ProjectSession.sales_vcqrucom + "  <br />" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";
        string MailBody1 = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='https://www.vcqru.com/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong> Media,</strong></em></span><br />" +
               " <span><em><strong>Name : -</strong></em> " + name + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + email + "</span><br />" +
        " <span><em><strong>Message : -</strong></em> " + comment + "</span><br /></div>" +
        " <p>" +
        " <div class='w_detail'>" +
        " Assuring you  of  our best services always.<br />" +
        " Thank you,<br /><br />" +
        " Team <em><strong>VCQRU.COM,</strong></em><br />" +
        "  " + ProjectSession.sales_vcqrucom + "  <br />" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";
        #endregion
        DataSet dsMl = function9420.FetchMailDetail("support");
        if (dsMl.Tables[0].Rows.Count > 0)
        {
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), email, MailBody, subject);
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Media_accomplishtrades, MailBody1, subject);
        }
        result = "";

        // ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
        //"<script>alert('Record Added Successfully')</script>");

        return result;
    }

    //public static string Paytm_Cash(string Mobile, String Cash, string code, DataView dv, string CompName)
    //{

    //    string value = "https://dashboard.paytm.com/bpay/api/v1/disburse/order/wallet/gratification";

    //    string mid = "Accomp05744616645099";
    //    string merchant_key = "Tvdl!R8SHKGPnjzF";
    //    string beneficiaryPhoneNo = Mobile;
    //    string amount = Cash;

    //    string subwallet_guid = string.Empty;
    //    string SubwalletGuid = SQL_DB.ExecuteScalar("SELECT subwalletGuid FROM dbo.Paytm_subwallet where [Comp_Name] = '" + CompName + "'").ToString();
    //    if (SubwalletGuid == "" || SubwalletGuid == null)
    //        subwallet_guid = "0666b257-0650-4c15-83a3-3c1ab5c85e1b";
    //    else
    //        subwallet_guid = SubwalletGuid;

    //    string callback = "https://vcqru.com/";//( which you want to redirect after the transaction)


    //    Dictionary<string, string> innerrequest = new Dictionary<string, string>();
    //    Random r = new Random();
    //    //string orderid= r.Next(1000, 10000).ToString();
    //    innerrequest.Add("orderId", "Accom" + code);
    //    innerrequest.Add("beneficiaryPhoneNo", beneficiaryPhoneNo);
    //    innerrequest.Add("amount", amount);
    //    innerrequest.Add("subwalletGuid", subwallet_guid);
    //    innerrequest.Add("callbackUrl", callback);

    //    String first_jason = new JavaScriptSerializer().Serialize(innerrequest);
    //    first_jason = first_jason.Replace("\\", "").Replace(":\"{", ":{").Replace("}\",", "},");
    //    try
    //    {
    //        string Check = paytm.CheckSum.generateCheckSumByJson(merchant_key, first_jason);

    //        System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls;
    //        String url = value;

    //        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);//Makes a request to uri

    //        request.ContentType = "application/json";
    //        request.MediaType = "application/json";
    //        request.Accept = "application/json";
    //        request.Method = "POST";
    //        request.Headers.Add("x-mid", mid);

    //        request.Headers.Add("x-checksum", Check);

    //        request.ContentLength = first_jason.Length;
    //        using (StreamWriter requestWriter2 = new StreamWriter(request.GetRequestStream()))//Write request data
    //        {
    //            requestWriter2.Write(first_jason);

    //        }


    //        string responseData = string.Empty;

    //        using (StreamReader responseReader = new StreamReader(request.GetResponse().GetResponseStream()))// Send the 'WebRequest' and wait for response..and  Obtain a 'Stream' object associated with the response object.
    //        {
    //            responseData = responseReader.ReadToEnd();
    //            string jsonoutput = "Requested Json= " + first_jason.ToString() + "</br></br>";
    //            //JObject jObject = JObject.Parse(first_jason.ToString());
    //            //JToken memberName = jObject["Json"].First["orderId"];
    //            ////Console.WriteLine(memberName);
    //            ////string responsedate = "Response Json= " + responseData;
    //            ////Response.Write("Requested Json= " + first_jason.ToString() + "</br></br>");
    //            ////Response.Write("Response Json= " + responseData);

    //            return "Success";
    //            //return jsonoutput;

    //        }


    //    }
    //    catch (WebException ex)
    //    {
    //        string m;
    //        if (ex.Status == WebExceptionStatus.ProtocolError)
    //            m = "The remote server returned an error: (401) unauthorized.";
    //        else

    //            m = ex.Message;
    //        //StreamReader sr = new StreamReader(s);
    //        //string m = sr.ReadToEnd();
    //        //Response.Write(m);
    //        return m;

    //    }
    //}
    public static string GetMessageFromM_TemplateMSgPaytm(DataTable dtTemplateMSG, string code1, string code2, string RowFilter, string P_cash, string CompName)
    {
        string strMSG = string.Empty;
        //  Object9420 Reg = new Object9420();
        //Reg.TempleteHead = "DEFAULT";
        //Reg.SubHeadId = "";
        paytm_codes = code1 + "" + code2;
        paytm_mobile = paytm_mobile.Replace("+", "");

        if (dtTemplateMSG.Rows.Count > 0)
        {
            //}
            //else
            //{
            DataView dv = dtTemplateMSG.DefaultView;
            dv.RowFilter = RowFilter;// " Service_ID = 'InvalidCode'";
            DataTable fdt = dv.ToTable();
            string oid = SQL_DB.ExecuteScalar("select (ISNULL(max(orderid),1000))+1 as orderid from [dbo].[paytmtransaction]").ToString();
            #region Added for New Order id 20241013 by Bipin
            string UniqueNumber = DateTime.Now.ToString("yyMMddHHmmss");
            oid = UniqueNumber;
            #endregion
            string M_Consumerid = "";
            string ConsumerName = "";
            DataTable table = SQL_DB.ExecuteDataTable("select top 1 M_Consumerid,ConsumerName From M_Consumer where MobileNo like '%" + paytm_mobile + "%'");
            if (table.Rows.Count > 0)
            {
                M_Consumerid = table.Rows[0]["M_Consumerid"].ToString();
                ConsumerName = table.Rows[0]["ConsumerName"].ToString();
            }
            string CompID = "";
            DataTable table2 = SQL_DB.ExecuteDataTable("select top 1 Comp_ID From Comp_Reg where Comp_Name like '%" + CompName + "%'");
            if (table2.Rows.Count > 0)
            {
                CompID = table2.Rows[0]["Comp_ID"].ToString();
            }

            string date = System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff");

            if (fdt.Rows[0]["IsCustomise"].ToString() == "1")
            {
                // string paytmmessage = Paytm_Cash(paytm_mobile, P_cash, oid, dv, CompName);
                string paytmmessage = "FAILURE";
                strMSG = fdt.Rows[0]["MsgBody"].ToString();
                if (strMSG.Contains("<code1>"))
                    strMSG = strMSG.Replace("<code1>", code1).Replace("<code2>", code2);

                if (paytmmessage.ToUpper().Contains("ACCEPTED"))
                {
                    SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid,Rec_code1,Rec_code2) values('" + CompID + "','" + paytm_mobile + "','" + date + "','" + M_Consumerid + "'," + P_cash + ",'Accepted','" + oid + "'," + code1 + "," + code2 + ")");


                }
                else
                {
                    SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid,Rec_code1,Rec_code2) values('" + CompID + "','" + paytm_mobile + "','" + date + "','" + M_Consumerid + "'," + P_cash + ",'FAILURE','" + oid + "'," + code1 + "," + code2 + ")");
                }

            }
            else
            {
                //string paytmmessage = Paytm_Cash(paytm_mobile, P_cash, oid, dv, CompName);
                string paytmmessage = "FAILURE";
                if (paytmmessage == "Success" || paytmmessage.ToUpper().Contains("ACCEPTED"))
                {
                    SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid,Rec_code1,Rec_code2) values('" + CompID + "','" + paytm_mobile + "','" + date + "','" + M_Consumerid + "'," + P_cash + ",'Accepted','" + oid + "'," + code1 + "," + code2 + ")");
                    strMSG = fdt.Rows[0]["MsgBody"].ToString();
                    if (strMSG.Contains("<code1>"))
                        strMSG = strMSG.Replace("<code1>", code1).Replace("<code2>", code2).Replace("<cash>", P_cash);
                }
                else
                    SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid,Rec_code1,Rec_code2) values('" + CompID + "','" + paytm_mobile + "','" + date + "','" + M_Consumerid + "'," + P_cash + ",'FAILURE','" + oid + "'," + code1 + "," + code2 + ")");

                #region //** Paytm response commented and set template 
                strMSG = fdt.Rows[0]["MsgBody"].ToString();
                if (strMSG.Contains("<code1>"))
                    strMSG = strMSG.Replace("<code1>", code1).Replace("<code2>", code2).Replace("<cash>", P_cash);
                //  strMSG = paytmmessage;
                #endregion

            }

            SQL_DB.ExecuteNonQuery("insert into Transactions(M_CounserID,CustomerName,Amount,TransctionNumber,CompId,MobileNumber,Issuccess)values('" + M_Consumerid + "','" + ConsumerName + "'," + P_cash + ",'" + oid + "','" + CompID.Split('-')[1] + "','" + paytm_mobile + "',0)");



        }
        return strMSG;
    }

    public static string GetMessageFromM_TemplateMSg(DataTable dtTemplateMSG, string code1, string code2, string RowFilter, string CompName)
    {
        string strMSG = string.Empty;

        if (dtTemplateMSG.Rows.Count > 0)
        {
            //}
            //else
            //{
            DataView dv = dtTemplateMSG.DefaultView;
            dv.RowFilter = RowFilter;// " Service_ID = 'InvalidCode'";
            DataTable fdt = dv.ToTable();

            if (fdt.Rows[0]["IsCustomise"].ToString() == "1")
            {
                //string paytmmessage = Paytm_Cash(paytm_mobile, P_cash, paytm_codes, dv, CompName);
                strMSG = fdt.Rows[0]["MsgBody"].ToString();
                if (strMSG.Contains("<CODE1>"))
                    strMSG = strMSG.Replace("<CODE1>", code1).Replace("<CODE2>", code2);
            }

        }
        return strMSG;
    }
    public static DataSet insertcodeforloyalty(string pro_id, string starteries, string endseries, string subscribe_id, string service_id, int count, int loyalty)
    {
        try
        {
            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");
            dbCommand = database.GetStoredProcCommand("Proc_insert code");
            database.AddInParameter(dbCommand, "@Pro_id", DbType.String, pro_id);
            database.AddInParameter(dbCommand, "@stratseries", DbType.String, starteries);
            database.AddInParameter(dbCommand, "@endseries", DbType.String, endseries);
            database.AddInParameter(dbCommand, "@subscribe_id", DbType.String, subscribe_id);
            database.AddInParameter(dbCommand, "@service_id", DbType.String, service_id);
            database.AddInParameter(dbCommand, "@count", DbType.String, count);
            database.AddInParameter(dbCommand, "@loyalty", DbType.String, loyalty);

            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public static string Paytm_Status()
    {

        try
        {


            DataTable table = SQL_DB.ExecuteDataTable("select * from dbo.paytmtransaction where pstatus <> 'FAILURE' and pstatus <> 'SUCCESS'");

            if (table.Rows.Count > 0)
            {

                foreach (DataRow dr in table.Rows)
                {

                    Dictionary<string, string> requestBody = new Dictionary<string, string>();

                    //requestBody.Add("orderId", "Accomp3156");
                    requestBody.Add("orderId", "Accomp" + dr["orderid"].ToString());
                    string Comp_ID = dr["compId"].ToString();


                    string post_data = JsonConvert.SerializeObject(requestBody);

                    string merchant_key = "Tvdl!R8SHKGPnjzF";
                    string paytmChecksum = paytm.CheckSum.generateCheckSumByJson("Tvdl!R8SHKGPnjzF", JsonConvert.SerializeObject(requestBody));

                    string x_mid = "Accomp05744616645099";
                    string x_checksum = paytmChecksum;

                    ServicePointManager.Expect100Continue = true;
                    ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;


                    //For  Staging
                    //string url = "https://staging-dashboard.paytm.com/bpay/api/v1/disburse/order/query";

                    //For  Production 
                    string url = "https://dashboard.paytm.com/bpay/api/v1/disburse/order/query";

                    HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(url);

                    webRequest.Method = "POST";
                    webRequest.ContentType = "application/json";
                    webRequest.ContentLength = post_data.Length;
                    webRequest.Headers.Add("x-mid", x_mid);
                    webRequest.Headers.Add("x-checksum", x_checksum);
                    using (StreamWriter requestWriter = new StreamWriter(webRequest.GetRequestStream()))
                    {
                        requestWriter.Write(post_data);
                    }

                    string responseData = string.Empty;

                    using (StreamReader responseReader = new StreamReader(webRequest.GetResponse().GetResponseStream()))
                    {
                        responseData = responseReader.ReadToEnd();
                        // Console.WriteLine(responseData);
                    }
                    ///////SUCCESS
                    ///ACCEPTED
                    ///FAILURE

                    #region Apply New logs for paytm check status
                    PaytmStatuslogs("Accomp" + dr["orderid"].ToString(), url, responseData);
                    #endregion


                    /////////////////////////end//////////////////////////////////
                    var jObject = JsonConvert.DeserializeObject<Dictionary<dynamic, dynamic>>(responseData);
                    // string rs = jObject["body"]["resultInfo"]["resultStatus"].ToString();
                    string rs = jObject["status"].ToString();
                    string comment = jObject["statusMessage"].ToString();
                    string date = System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff");

                    #region //** Added for other vendors's data stored in BPointsTransaction table
                    DateTime Bd = Convert.ToDateTime(dr["pdate"].ToString());
                    string BpointDate = Bd.ToString("yyyy-MM-dd");

                    //   string BpointDate = dr["pdate"].ToString();
                    #endregion

                    if (Comp_ID == "Comp-1388" || Comp_ID == "Comp-1313" || Comp_ID == "Comp-1312" || Comp_ID == "Comp-1439" || Comp_ID == "Comp-1451" || Comp_ID == "Comp-1499" || Comp_ID == "Comp-1496")
                    {

                        if (rs == "SUCCESS")
                        {

                            ExecuteNonQueryAndDatatable.InsUpdStoreProcedure("Sp_UpdatePaytmTransactionStatus", "@pstatus", rs.Trim(), "@Comment", comment.Trim(), "@OrderId", dr["orderid"].ToString().Trim());
                            // SQL_DB.ExecuteNonQuery("update dbo.paytmtransaction set pstatus='SUCCESS',Comment='NA' where orderid=" + dr["orderid"].ToString() + "");

                            SQL_DB.ExecuteNonQuery("update dbo.Transactions set Issuccess=1,TransactionDate='" + date + "' where TransctionNumber='" + dr["orderid"].ToString() + "'");

                        }
                        else if (rs == "FAILURE")
                        {
                            ExecuteNonQueryAndDatatable.InsUpdStoreProcedure("Sp_UpdatePaytmTransactionStatus", "@pstatus", rs.Trim(), "@Comment", comment.Trim(), "@OrderId", dr["orderid"].ToString().Trim());

                            // SQL_DB.ExecuteNonQuery("update dbo.paytmtransaction set pstatus='FAILURE',Comment='NA' where orderid=" + dr["orderid"].ToString() + "");
                        }
                        else
                        {
                            ExecuteNonQueryAndDatatable.InsUpdStoreProcedure("Sp_UpdatePaytmTransactionStatus", "@pstatus", rs.Trim(), "@Comment", comment.Trim(), "@OrderId", dr["orderid"].ToString().Trim());

                            // SQL_DB.ExecuteNonQuery("update dbo.paytmtransaction set pstatus='" + rs + "',Comment='NA' where orderid=" + dr["orderid"].ToString() + "");

                        }
                    }
                    else
                    {
                        if (rs == "SUCCESS")
                        {
                            //SQL_DB.ExecuteNonQuery("update dbo.BPointsTransaction set bpstatus='SUCCESS' where incash=" + float.Parse(dr["Amount"].ToString()) + " and redeemdate='" + date + "' and redeemby='" + dr["M_consumerid"].ToString() + "'");

                            SQL_DB.ExecuteNonQuery("update dbo.BPointsTransaction set bpstatus='SUCCESS' where incash=" + float.Parse(dr["Amount"].ToString()) + " and FORMAT( Redeemdate,'yyyy-MM-dd')='" + BpointDate + "' and redeemby='" + dr["M_consumerid"].ToString() + "'");

                            ExecuteNonQueryAndDatatable.InsUpdStoreProcedure("Sp_UpdatePaytmTransactionStatus", "@pstatus", rs.Trim(), "@Comment", comment.Trim(), "@OrderId", dr["orderid"].ToString().Trim());
                            // SQL_DB.ExecuteNonQuery("update dbo.paytmtransaction set pstatus='SUCCESS',Comment='NA' where orderid=" + dr["orderid"].ToString() + "");

                        }
                        else if (rs == "FAILURE")
                        {

                            #region //** Apply  condition to auto revers amount if transaction has been failed
                            // SQL_DB.ExecuteNonQuery("update dbo.BPointsTransaction set bpstatus='FAILURE' where  redeemby='" + dr["M_consumerid"].ToString() + "'");
                            SQL_DB.ExecuteNonQuery("update dbo.BPointsTransaction set bpstatus='FAILURE' where incash=" + float.Parse(dr["Amount"].ToString()) + " and FORMAT( Redeemdate,'yyyy-MM-dd')='" + BpointDate + "' and redeemby='" + dr["M_consumerid"].ToString() + "'");
                            ExecuteNonQueryAndDatatable.InsUpdStoreProcedure("Sp_UpdatePaytmTransactionStatus", "@pstatus", rs.Trim(), "@Comment", comment.Trim(), "@OrderId", dr["orderid"].ToString().Trim());
                            // SQL_DB.ExecuteNonQuery("update dbo.paytmtransaction set pstatus='FAILURE',Comment='NA' where orderid=" + dr["orderid"].ToString() + "");
                            #endregion

                        }
                        else
                        {

                            SQL_DB.ExecuteNonQuery("update dbo.BPointsTransaction set bpstatus='" + rs + "' where incash=" + float.Parse(dr["Amount"].ToString()) + " and redeemdate='" + date + "' and redeemby='" + dr["M_consumerid"].ToString() + "'");

                            ExecuteNonQueryAndDatatable.InsUpdStoreProcedure("Sp_UpdatePaytmTransactionStatus", "@pstatus", rs.Trim(), "@Comment", comment.Trim(), "@OrderId", dr["orderid"].ToString().Trim());
                            //  SQL_DB.ExecuteNonQuery("update dbo.paytmtransaction set pstatus='" + rs + "',Comment='NA' where orderid=" + dr["orderid"].ToString() + "");
                        }

                        if (Comp_ID == "Comp-1321")
                        {
                            try
                            {
                                string Resp = ExecuteNonQueryAndDatatable.checkscalarvalues("Sp_InsupdWalletbalance", Convert.ToInt32(dr["M_consumerid"].ToString()));
                            }
                            catch
                            {

                            }

                        }

                    }

                    DataProvider.LogManager.ErrorExceptionLog(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + " - " + "Accomp" + dr["orderid"].ToString());

                }

            }

            return "success";

        }
        catch (WebException ex)
        {

            string m;

            if (ex.Status == WebExceptionStatus.ProtocolError)
                m = "The remote server returned an error: (401) unauthorized.";
            else

                m = ex.Message;
            //StreamReader sr = new StreamReader(s);
            //string m = sr.ReadToEnd();
            //Response.Write(m);
            return m;
        }


    }

    public static string Paytm_Cash(string Mobile, String Cash, string code, DataView dv, string CompName)
    {
        string value = "https://dashboard.paytm.com/bpay/api/v1/disburse/order/wallet/gratification";

        string mid = "Accomp05744616645099";
        string merchant_key = "Tvdl!R8SHKGPnjzF";
        string beneficiaryPhoneNo = Mobile.Substring(Mobile.Length - 10);
        string amount = Cash;

        string subwallet_guid = string.Empty;
        string SubwalletGuid = string.Empty;
        try
        {
            SubwalletGuid = SQL_DB.ExecuteScalar("SELECT subwalletGuid FROM dbo.Paytm_subwallet where [Comp_Name] = '" + CompName + "'").ToString();
        }
        catch (Exception ex)
        {
            subwallet_guid = "52570e70-4551-4a30-9103-4c449d0ed675";
        }
        if (SubwalletGuid == "" || SubwalletGuid == null)
            subwallet_guid = "52570e70-4551-4a30-9103-4c449d0ed675";
        else
            subwallet_guid = SubwalletGuid;

        string callback = "https://vcqru.com/";//( which you want to redirect after the transaction)


        Dictionary<string, string> innerrequest = new Dictionary<string, string>();
        Random r = new Random();
        //string orderid= r.Next(1000, 10000).ToString();
        innerrequest.Add("orderId", "Accomp" + code);
        innerrequest.Add("beneficiaryPhoneNo", beneficiaryPhoneNo);
        innerrequest.Add("amount", amount);
        innerrequest.Add("subwalletGuid", subwallet_guid);
        innerrequest.Add("callbackUrl", callback);

        String first_jason = new JavaScriptSerializer().Serialize(innerrequest);
        first_jason = first_jason.Replace("\\", "").Replace(":\"{", ":{").Replace("}\",", "},");
        try
        {
            string Check = paytm.CheckSum.generateCheckSumByJson(merchant_key, first_jason);

            System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12;
            String url = value;

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);//Makes a request to uri

            request.ContentType = "application/json";
            request.MediaType = "application/json";
            request.Accept = "application/json";
            request.Method = "POST";
            request.Headers.Add("x-mid", mid);

            request.Headers.Add("x-checksum", Check);

            request.ContentLength = first_jason.Length;
            using (StreamWriter requestWriter2 = new StreamWriter(request.GetRequestStream()))//Write request data
            {
                requestWriter2.Write(first_jason);

            }


            string responseData = string.Empty;

            using (StreamReader responseReader = new StreamReader(request.GetResponse().GetResponseStream()))// Send the 'WebRequest' and wait for response..and  Obtain a 'Stream' object associated with the response object.
            {
                responseData = responseReader.ReadToEnd();
                string jsonoutput = "Requested Json= " + first_jason.ToString() + "</br></br>";
                JObject jObject = JObject.Parse(responseData);
                string rs = jObject.First.First.ToString();
                ////Console.WriteLine(memberName);
                ////string responsedate = "Response Json= " + responseData;
                ////Response.Write("Requested Json= " + first_jason.ToString() + "</br></br>");
                ////Response.Write("Response Json= " + responseData);

                DataProvider.LogManager.ErrorExceptionLog(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "        " + jObject + "  " + beneficiaryPhoneNo);
                return rs;

                //return "Success";
                //return jsonoutput;

            }


        }
        catch (WebException ex)
        {
            string m;

            if (ex.Status == WebExceptionStatus.ProtocolError)
                m = "The remote server returned an error: (401) unauthorized.";
            else

                m = ex.Message;
            //StreamReader sr = new StreamReader(s);
            //string m = sr.ReadToEnd();
            //Response.Write(m);
            return m;

        }
    }
    public static string ShowMessageForRunSurvey()
    {

        return "Give your feedback and rate your product - <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/RunSurveyFeedback.aspx?M=" + ProjectSession.strMobileNo + "-" + ProjectSession.intM_Consumer_MCOde + "&#RunSurvey' target='_blank' style='color:blue;'>Continue</a>.";
        //   string strReturnMSG = string.Empty;
        //   strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1001' and MsgType = 5");
        //   return strReturnMSG.Replace("<points>", strEarnedPoints).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl).ToUpper();
        ////   "Give feedback and rate your product-<absoluteSiteBrowseUrl>/Info/RunSurveyFeedback.aspx?M=<strMobileNo>-<intM_Consumer_MCOde>"
        // //  return strReturnMSG;


    }

    //public static string ServiceRequestCheck(DataSet dsres, Object9420 Reg, string strMobileNo, bool IsCheckedUse_Count, string ReferralCodeFromUser, string Dial_Mode)
    //{
    //    string DefaultComments = ""; string CompName = string.Empty; string result = string.Empty;
    //    DataTable dtServiceAssign = new DataTable();
    //    DataTable dtTotalCodesCount = new DataTable();
    //    try
    //    {
    //        #region MyRegion
    //        DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(dsres.Tables[0].Rows[0]["Pro_ID"].ToString());
    //        if (!IsCheckedUse_Count)
    //        {

    //            Reg.Is_Success = 1;
    //            if (dsres.Tables[0].Rows.Count > 0)
    //            {
    //                if (dsServicesAssign.Tables.Count <= 2)
    //                {
    //                    dtServiceAssign = dsServicesAssign.Tables[0];
    //                    dtTotalCodesCount = dsServicesAssign.Tables[1];

    //                    if (dtServiceAssign.Rows.Count > 0)
    //                    {
    //                        #region Loop in service
    //                        CompName = dsres.Tables[0].Rows[0]["Comp_Name"].ToString();
    //                        string json = JsonConvert.SerializeObject(Reg, Formatting.Indented);
    //                        DataProvider.LogManager.ErrorExceptionLog(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "        " + json);
    //                        long intM_Consumer_MCOde = Business9420.function9420.InsertCodeChecked(Reg); // doing entry in Pro_Enq tabgle (PROC_InsertProductInquery)
    //                        DataProvider.LogManager.ErrorExceptionLog(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "        " + json);
    //                        Business9420.function9420.UpdateUse_CountM_Code(Reg);// update [Use_Count] =0 in M_Code
    //                        ProjectSession.strMobileNo = Reg.Mobile_No;
    //                        ProjectSession.intM_Consumer_MCOde = intM_Consumer_MCOde;
    //                        Reg.intM_Consumer_MCOde = intM_Consumer_MCOde;

    //                        try
    //                        {
    //                            DataRow[] drw = dtServiceAssign.Select("Service_id = 'SRV1023'");
    //                            //////////////Comment by sandeep 040620///////////////
    //                            // string strWar = "Warranty for the " + CompName + " (" + Convert.ToString(drw[0]["PNm"]) + ") has " +
    //                            //"registered successfully for (" + Convert.ToString(drw[0]["WarrantyPeriod"]) + " months )";
    //                            // HttpContext.Current.Session["strWar"] = strWar;
    //                        }
    //                        catch (Exception ex)
    //                        {
    //                            ex.StackTrace.ToString();
    //                            //throw ex.Message.ToString();
    //                        }


    //                        //string strReferralCode = Convert.ToString(SQL_DB.ExecuteScalar("Select dbo.GetZeroConcactWithReferralCode(referralcode)  FROM [M_Consumer] where [MobileNo] = '" + strMobileNo + "'"));
    //                        //SendSms("Congs! Gained Referral code-" + strReferralCode + "", ProjectSession.strMobileNo);

    //                        #region Seperator "*" to concact string msg 
    //                        // if (i > 0) result = result + "<br/>";
    //                        string strSeperator = "<br/><br/>";
    //                        if (Dial_Mode.ToLower() == "website")
    //                        {
    //                            strSeperator = "<br/><br/>";
    //                        }
    //                        else
    //                        {
    //                            strSeperator = "*";
    //                        }

    //                        #endregion
    //                        string strReturnMSG = string.Empty;
    //                        // Get Return message from Template Msg Table i.e 
    //                        DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
    //                        //bool Status = false;
    //                        for (int i = 0; i < dtServiceAssign.Rows.Count; i++)
    //                        {
    //                            if (i > 0) result = result + strSeperator;
    //                            #region
    //                            string stServiceid = dtServiceAssign.Rows[i]["Service_ID"].ToString();
    //                            DataRow[] dr = dtServiceAssign.Select("Service_id = '" + stServiceid + "'");

    //                            switch (stServiceid)
    //                            {
    //                                case "SRV1023":// build loyalty
    //                                    {
    //                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1023' and MsgType = 9");
    //                                        if (!string.IsNullOrEmpty(dtServiceAssign.Rows[i]["WarrantyPeriod"].ToString()))
    //                                        {
    //                                            //if (WarrantyPeriod)

    //                                            result = result + (strReturnMSG.Replace("<warrpariod>", dtServiceAssign.Rows[i]["WarrantyPeriod"].ToString() + " months")).ToUpper();
    //                                        }
    //                                        else
    //                                        {
    //                                            result = result + (strReturnMSG.Replace("<warrpariod>", " 0 months")).ToUpper();
    //                                        }
    //                                        break;
    //                                    }
    //                                case "SRV1001":// build loyalty
    //                                    {
    //                                        #region build loyalty
    //                                        DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
    //                                        if (dt.Rows.Count > 0)
    //                                        {
    //                                            string strEarnedPoints = dt.Rows[0]["Points"].ToString();
    //                                            string IsCashConvert = dt.Rows[0]["IsCashConvert"].ToString();
    //                                            string AwardNameBL = dt.Rows[0]["AwardNameBL"].ToString();
    //                                            if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
    //                                            {
    //                                                if (IsCashConvert == "0") // Covert points to cash will do end user
    //                                                {
    //                                                    //result = result + " You have earned " + strEarnedPoints + " points. Redeem points and earn cash - <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";
    //                                                    // result = result + "Congs! earned <points> points.Redeem-<absoluteSiteBrowseUrl>/Info/Consumerregister.aspx#trylogin.";
    //                                                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1001' and MsgType = 4");
    //                                                    result = result + (strReturnMSG.Replace("<points>", strEarnedPoints).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
    //                                                }
    //                                                else
    //                                                {
    //                                                    // if (!string.IsNullOrEmpty(AwardNameBL))
    //                                                    // {
    //                                                    // result = result + "You have won a <b>gift</b> againts earned points. Redeem points and earn gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";
    //                                                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1001' and MsgType = 5");
    //                                                    result = result + (strReturnMSG.Replace("<points>", strEarnedPoints).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
    //                                                    //}
    //                                                    //else
    //                                                    //{
    //                                                    //    result = result + "Congs! You have earned points againts the purchased product. ";
    //                                                    //}
    //                                                }
    //                                                // result = result + "Congs! You have earned points againts the purchased product. ";
    //                                            }
    //                                            else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
    //                                            {
    //                                                // result = result + "Congs! You can earn <b>points</b> againts the purchased product.Just left with  <b> " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " </b> more purchase ";
    //                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1001' and MsgType = 6");
    //                                                result = result + (strReturnMSG.Replace("<points>", strEarnedPoints).Replace("<frequency>", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();
    //                                            }
    //                                        }
    //                                        #endregion
    //                                        break;
    //                                    }
    //                                case "SRV1002"://Run Surveys
    //                                    {
    //                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1002' and MsgType = 4");
    //                                        result = result + (strReturnMSG.Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)
    //                                                                       .Replace("<strMobileNo>", ProjectSession.strMobileNo)
    //                                                                        .Replace("<intM_Consumer_MCOde>", ProjectSession.intM_Consumer_MCOde.ToString())).ToUpper();
    //                                        // result = result + ShowMessageForRunSurvey();
    //                                        break;
    //                                    }
    //                                case "SRV1018"://COUNTERFIETING
    //                                    {
    //                                        DataView dv = MsgTempdt.DefaultView;
    //                                        if (CompName.ToUpper() == "MFN")
    //                                        {
    //                                            dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 4";
    //                                        }

    //                                        else if (CompName.ToUpper() == "MAHINDRA AND MAHINDRA LTD")
    //                                        {
    //                                            dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 5";
    //                                        }
    //                                        else if (CompName.ToUpper() == "UNIGLOBAL DISTRIBUTORS PRIVATE LIMITED")
    //                                        {
    //                                            dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 6";
    //                                        }
    //                                        else if (CompName.ToUpper() == "MYSHA HEALTH WORLD")
    //                                        {
    //                                            dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 7";
    //                                        }

    //                                        else
    //                                        {
    //                                            dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 1";
    //                                        }
    //                                        DataTable fdt = dv.ToTable();

    //                                        #region Loyalty
    //                                        //*************** Brand Loyalty Code start ******************//
    //                                        string LoyaltyMessage = "";
    //                                        LoyaltyMessage = GetMyMessage(strMobileNo, Reg.Received_Code1, Reg.Received_Code2, Reg.Mode_Detail);
    //                                        //*************** Brand Loyalty Code end ******************//
    //                                        if (Reg.Comp_type == "L")
    //                                        {
    //                                            // m_Amc_offer is for renewal
    //                                            DataSet ds1 = SQL_DB.ExecuteDataSet("select * from M_Amc_Offer  WHERE Pro_Id = '" + dsres.Tables[0].Rows[0]["Pro_ID"].ToString() + "' AND Trans_Type = 'Offer' AND  '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' BETWEEN convert(nvarchar,Date_From,111) AND convert(nvarchar,Date_To,111)");
    //                                            if (ds1.Tables[0].Rows.Count > 0)
    //                                                DefaultComments = ds1.Tables[0].Rows[0]["Comments"].ToString();
    //                                            else
    //                                                DefaultComments = "";
    //                                        }
    //                                        else
    //                                            DefaultComments = dsres.Tables[0].Rows[0]["Comments"].ToString();
    //                                        DefaultComments += " " + LoyaltyMessage;
    //                                        if (dsres.Tables[0].Rows[0]["Exp_Date"].ToString() == "01/01/1900")
    //                                        {
    //                                            //  result = result + "Code1-" + Reg.Received_Code1 + " & Code2-" + Reg.Received_Code2 + ", Prod-" + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", SN-" + dsres.Tables[0].Rows[0]["series"].ToString() + "" +
    //                                            //                      ", MRP-" + dsres.Tables[0].Rows[0]["MRP"].ToString() + ", MFG" + dsres.Tables[0].Rows[0]["Mfd_Date"].ToString() + ", EXP, BtNo-" + dsres.Tables[0].Rows[0]["Batch_No"].ToString() + ", PROD IS GENUINE.";// & mfd by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + " " + DefaultComments + " Tnx label9420";

    //                                            if (CompName.ToLower() == "1 stop nutrition")
    //                                            {
    //                                                result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "    Tnx SKS Nutritions";
    //                                            }
    //                                            else
    //                                            {
    //                                                if (result != "")
    //                                                    result += fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<MRP>", dsres.Tables[0].Rows[0]["MRP"].ToString()).Replace("<MFD>", Convert.ToDateTime(dsres.Tables[0].Rows[0]["Mfd_Date"]).ToString("MM/yyyy")).Replace("<BTNO>", dsres.Tables[0].Rows[0]["Batch_No"].ToString()).Replace("<SMS>", dsres.Tables[0].Rows[0]["Comments"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString()).Replace("EXP <EXP>", "");
    //                                                else
    //                                                    result += fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>",
    //                                                        Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<MRP>",
    //                                                        dsres.Tables[0].Rows[0]["MRP"].ToString()).Replace("<MFD>",
    //                                                        Convert.ToDateTime(dsres.Tables[0].Rows[0]["Mfd_Date"]).ToString("MM/yyyy")).Replace("<BTNO>",
    //                                                        dsres.Tables[0].Rows[0]["Batch_No"].ToString()).Replace("<SMS>",
    //                                                        dsres.Tables[0].Rows[0]["Comments"].ToString()).Replace("<CMPNAME>",
    //                                                        dsres.Tables[0].Rows[0]["Comp_Name"].ToString()).Replace("EXP <EXP>", "");
    //                                                //if (!string.IsNullOrEmpty(dsres.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString()))
    //                                                //{
    //                                                //    result += result.Replace("<warranty>", "Warranty -" + dsres.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString() + " months");
    //                                                //}
    //                                                //else
    //                                                //{
    //                                                //    result += result.Replace("<warranty>", "");
    //                                                //}
    //                                            }
    //                                        }
    //                                        else
    //                                        {
    //                                            if (CompName.ToLower() == "1 stop nutrition")
    //                                            {
    //                                                result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "   Tnx SKS Nutritions";
    //                                            }
    //                                            else if (CompName.ToLower() == "nutriglow")
    //                                            {
    //                                                result = "GENUINE CODE " + Reg.Received_Code1 + "-" + Reg.Received_Code2 + "," + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + "," +
    //                                                   dsres.Tables[0].Rows[0]["MRP"].ToString() + "," + DefaultComments;

    //                                            }
    //                                            else

    //                                            {
    //                                                //result = result + " Code1-" + Reg.Received_Code1 + " & Code2-" + Reg.Received_Code2 + ", Prod-" + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", SN-" + dsres.Tables[0].Rows[0]["series"].ToString() + "" +
    //                                                //                        ", MRP-" + dsres.Tables[0].Rows[0]["MRP"].ToString() + ", MFG" + dsres.Tables[0].Rows[0]["Mfd_Date"].ToString() + ", EXP" + dsres.Tables[0].Rows[0]["Exp_Date"].ToString() + ", BtNo-" + dsres.Tables[0].Rows[0]["Batch_No"].ToString() + ", <b> PROD IS GENUINE </b>."; //& mfd by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + " " + DefaultComments + " Tnx label9420";
    //                                                result += fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>",
    //                                                   Reg.Received_Code2).Replace("<PRONAME>",
    //                                                   dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<MRP>",
    //                                                   dsres.Tables[0].Rows[0]["MRP"].ToString()).Replace("<MFD>",
    //                                                   Convert.ToDateTime(dsres.Tables[0].Rows[0]["Mfd_Date"]).ToString("MM/yyyy")).Replace("<EXP>",
    //                                                   Convert.ToDateTime(dsres.Tables[0].Rows[0]["Exp_Date"]).ToString("MM/yyyy")).Replace("<BTNO>",
    //                                                   dsres.Tables[0].Rows[0]["Batch_No"].ToString()).Replace("<SMS>", dsres.Tables[0].Rows[0]["Comments"].ToString())
    //                                                   .Replace("<CMPNAME>",
    //                                                   dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
    //                                                //if (!string.IsNullOrEmpty(dsres.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString()))
    //                                                //{
    //                                                //    result += result.Replace("<warranty>", "Warranty -" + dsres.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString() + " months");
    //                                                //}
    //                                                //else
    //                                                //{
    //                                                //    result += result.Replace("<warranty>", "");
    //                                                //}
    //                                                //.Replace("<warranty>", dsres.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString() + " months");
    //                                                // SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('exp date -" + Convert.ToDateTime(dsres.Tables[0].Rows[0]["Exp_Date"]).ToString("MM/yyyy") + "')");
    //                                            }
    //                                        }


    //                                        //   Status = true;
    //                                        //   return Status + "*" + result;
    //                                        //if (!string.IsNullOrEmpty(result))
    //                                        //{
    //                                        //    result = result + " & mfd by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + " " + DefaultComments + " Tnx label9420";
    //                                        //}
    //                                        break;
    //                                        #endregion
    //                                    }
    //                                //case "SRV1004": //Big Data Analysis - not required for code check.
    //                                //     {

    //                                //         break;
    //                                //     }
    //                                case "SRV1005": //Cash Transfers
    //                                    {
    //                                        #region Cah Transfer
    //                                        DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
    //                                        if (dt.Rows.Count > 0)
    //                                        {
    //                                            string strEarnedPoints = dt.Rows[0]["Points"].ToString();
    //                                            string Iscash = dt.Rows[0]["Iscash"].ToString();
    //                                            string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

    //                                            if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
    //                                            {
    //                                                // if (IsCashConvert == "0") // ask arish below point? Covert points to cash will do end user/company user
    //                                                //result = result + " You have gained <b> Rs" + Iscash + "/- </b> against the purchased product.Please complete your Profile details to avail cash amount - <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";
    //                                                if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "MAHINDRA AND MAHINDRA LTD")
    //                                                {
    //                                                    if (Dial_Mode == "SMS")
    //                                                    {

    //                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
    //                                                                                                                                                                    //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
    //                                                        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
    //                                                                                        .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();

    //                                                    }
    //                                                    else
    //                                                    {
    //                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
    //                                                                                                                                                                    //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
    //                                                        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
    //                                                                                        .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
    //                                                    }
    //                                                }
    //                                                else
    //                                                {
    //                                                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
    //                                                    result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
    //                                                }
    //                                                // else
    //                                                //      result = result + " You have won a gift againts earned points.Please complete your profile details to claim your gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>";
    //                                            }
    //                                            else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
    //                                            {
    //                                                //result = result + "Just left with " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " more purchase and will gain a cash of  <b> Rs" + Iscash + "/- </b>.";
    //                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 5");
    //                                                result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();
    //                                            }

    //                                        }
    //                                        #endregion
    //                                        break;
    //                                    }
    //                                case "SRV1003": //Gift Coupons
    //                                    {
    //                                        #region GiftCoupon
    //                                        //GetGiftCouponService();
    //                                        //DataRow[] dr = dtServiceAssign.Select("Service_id = '" + stServiceid + "'");
    //                                        if (dr.Length > 0)
    //                                        {
    //                                            strDialMode1 = Dial_Mode;
    //                                            result = result + ServiceLogic.GetGiftCouponService(dr[0], Convert.ToInt32(dtTotalCodesCount.Rows[0][0].ToString()), Reg.Received_Code1, Reg.Received_Code2, Reg.Comp_ID, false, stServiceid, Reg);
    //                                        }
    //                                        #endregion
    //                                        break;
    //                                    }
    //                                case "SRV1006": //Raffle Scheme
    //                                    {
    //                                        #region Raffle Service
    //                                        //Reg.Is_Success = 0;
    //                                        //Business9420.function9420.InsertCodeChecked(Reg);
    //                                        if (dr.Length > 0)
    //                                        {
    //                                            strDialMode1 = Dial_Mode;
    //                                            result = result + ServiceLogic.GetGiftCouponService(dr[0], Convert.ToInt32(dtTotalCodesCount.Rows[0][0].ToString()), Reg.Received_Code1, Reg.Received_Code2, Reg.Comp_ID, true, stServiceid, Reg);

    //                                        }
    //                                        //result = result + "Wprk in process";
    //                                        #endregion
    //                                        break;
    //                                    }
    //                                case "SRV1020": //Referral
    //                                    {


    //                                        #region Referral
    //                                        DataSet ds = Proc_SaveCodeDtsForReferralService(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde, ReferralCodeFromUser);
    //                                        DataTable dt = ds.Tables[0];
    //                                        // DataTable dtReferralLimit = ds.Tables[1];
    //                                        // string strlimit = string.Empty;
    //                                        //if (dtReferralLimit.Rows.Count > 0)
    //                                        //{
    //                                        //    strlimit = dtReferralLimit.Rows[0]["limit"].ToString();
    //                                        //}
    //                                        if (dt.Rows.Count > 0)
    //                                        {
    //                                            //string strReferralCode = dt.Rows[0]["ReferralCode"].ToString();
    //                                            //  string IsCashConvert = dt.Rows[0]["IsCashConvert"].ToString();
    //                                            // if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
    //                                            {
    //                                                string points22 = "";
    //                                                if (dt.Rows[0]["IsReferral1"].ToString() == "1")
    //                                                    points22 = "cash";
    //                                                else if (dt.Rows[0]["IsReferral1"].ToString() == "2")
    //                                                    points22 = "points";
    //                                                else if (dt.Rows[0]["IsReferral1"].ToString() == "3")
    //                                                    points22 = "gift";


    //                                                string strReferralCode = dt.Rows[0]["NewGenerate_ReferralCode"].ToString();
    //                                                // if (IsCashConvert == "0") // ask arish below point? Covert points to cash will do end user/company user
    //                                                //if (!string.IsNullOrEmpty(strReferralCode))
    //                                                if (string.IsNullOrEmpty(ReferralCodeFromUser))
    //                                                {
    //                                                    if (Convert.ToInt32(dt.Rows[0]["limitno"]) > 0)
    //                                                    {
    //                                                        // DataView dv = MsgTempdt.DefaultView;
    //                                                        // dv.RowFilter = ;
    //                                                        //  DataTable fdt = dv.ToTable();
    //                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1020' and SubHeadId = 'POINTS' and MsgType =4");
    //                                                        result = result + (strReturnMSG.Replace("<strReferralCode>", strReferralCode)).ToUpper();

    //                                                        // result = result + "Congs! You gained <b>" + points22 + "</b> and  a referral code - <b>" + strReferralCode + "</b>.Share your referral code to <b>" + strlimit + " people </b> and gain benefits.";
    //                                                        //result += fdt.Rows[0]["MsgBody"].ToString().Replace("<strReferralCode>", strReferralCode);
    //                                                        // result = result + "Congs! Can gain (points/cash/gift),just share your referral code<b>(" + strReferralCode + ") others.";
    //                                                        //result = result + "Congs! You gained a referral code - <b>" + strReferralCode + "</b>.Share your referral code to people's and gain benefits.";
    //                                                        // SendSms("Congs! Gained Referral code-" + strReferralCode + "", ProjectSession.strMobileNo);
    //                                                    }

    //                                                }
    //                                                else if (!string.IsNullOrEmpty(ReferralCodeFromUser))
    //                                                {

    //                                                    //DataTable dtREFCODE = new DataTable();
    //                                                    //try
    //                                                    //{
    //                                                    //    string strval1 = ReferralCodeFromUser.Substring(3);
    //                                                    //    dtREFCODE = SQL_DB.ExecuteDataTable("select * from M_consumer where ReferralCode = " + strval1);                                                           
    //                                                    //}
    //                                                    //catch (Exception)
    //                                                    //{


    //                                                    //}
    //                                                    if (Convert.ToInt32(dt.Rows[0]["limitno"]) < 0)
    //                                                    {
    //                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1020' and SubHeadId = 'POINTS' and MsgType =5");
    //                                                        result = result + (strReturnMSG.Replace("<strReferralCode>", ReferralCodeFromUser)).ToUpper();
    //                                                        //result = result + " You have won a gift againts earned points.Please complete your profile details to claim your gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>";
    //                                                    }
    //                                                    else
    //                                                    {
    //                                                        #region
    //                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1020' and SubHeadId = 'POINTS' and MsgType =6");
    //                                                        result = result + (strReturnMSG.Replace("<point>", dt.Rows[0]["RefPoints_ReferUser"].ToString()).Replace("<strReferralCode>", ReferralCodeFromUser)).ToUpper();

    //                                                        if (Dial_Mode.ToLower() == "website")
    //                                                        {
    //                                                            SendSms((strReturnMSG.Replace("<point>", dt.Rows[0]["RefPoints_ReferUser"].ToString()).Replace("<strReferralCode>", ReferralCodeFromUser)).ToUpper()
    //                                                                , Reg.Mobile_No);// referral user.

    //                                                            if (ds.Tables.Count > 1)
    //                                                            {
    //                                                                DataTable dt_Ref_User = ds.Tables[1];
    //                                                                if (dt_Ref_User.Rows.Count > 0)
    //                                                                {
    //                                                                    if (dt_Ref_User.Rows[0][0].ToString() != "0")
    //                                                                    {
    //                                                                        SendSms((strReturnMSG.Replace("<point>", dt_Ref_User.Rows[0]["RefPoints_User"].ToString())
    //                                                                            .Replace("<strReferralCode>", ReferralCodeFromUser)).ToUpper().Replace("USING CODE", "REFFERING CODE")
    //                                                                            , dt_Ref_User.Rows[0]["User_ReferralCode_MobileNo"].ToString()); // the user
    //                                                                    }
    //                                                                }
    //                                                            }
    //                                                        }
    //                                                        else
    //                                                        {
    //                                                            // Note : this is for SMS
    //                                                            // here SMS(functionality) is going to the users (this user is using referral code) who done the code check. but for user (who's referral code is used must also receive SMS)
    //                                                            // so one of the user is doing code check and other user, who's referral code is used, must also receive a sms of earn benefits.                                                                
    //                                                            DataTable dt_Ref_User = ds.Tables[1];
    //                                                            if (dt_Ref_User.Rows.Count > 0)
    //                                                            {
    //                                                                if (dt_Ref_User.Rows[0][0].ToString() != "0")
    //                                                                {
    //                                                                    SendSms((strReturnMSG.Replace("<point>", dt_Ref_User.Rows[0]["RefPoints_User"].ToString())
    //                                                                      .Replace("<strReferralCode>", ReferralCodeFromUser)).ToUpper().Replace("USING CODE", "REFFERING CODE")
    //                                                                      , dt_Ref_User.Rows[0]["User_ReferralCode_MobileNo"].ToString()); // the user
    //                                                                }
    //                                                            }

    //                                                        }
    //                                                        #endregion
    //                                                    }


    //                                                }


    //                                            }
    //                                            //else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
    //                                            //{
    //                                            //    //result = result + "Congs! You have earned points againts the purchased product. ";
    //                                            //    string points = "";
    //                                            //    if (dt.Rows[0]["IsReferral1"].ToString() == "1")
    //                                            //        points = "cash";
    //                                            //    else if (dt.Rows[0]["IsReferral1"].ToString() == "2")
    //                                            //        points = "points";
    //                                            //    else if (dt.Rows[0]["IsReferral1"].ToString() == "3")
    //                                            //        points = "gift";

    //                                            //    result = result + "Congs! You can earn <b>" + points + "</b> againts your purchase.Just <b>" + dt.Rows[0]["ReachedFrequency"].ToString() + "</b> more purchase left.";
    //                                            //}
    //                                            //if (!string.IsNullOrEmpty(ReferralCodeFromUser))
    //                                            //{
    //                                            //    if (dt.Rows[0]["pkBReferralToOtherConsumerBenefit"].ToString() == "0")
    //                                            //    {
    //                                            //        result = result + "<br/> Your Referral Code : " + ReferralCodeFromUser + " is expired.Better luck next time!";
    //                                            //    }
    //                                            //    else if (Convert.ToInt32(dt.Rows[0]["pkBReferralToOtherConsumerBenefit"]) > 0)
    //                                            //    {


    //                                            //        // this is all the user who used the referral code reffered by other user
    //                                            //        DataTable dtR = ds.Tables[2];
    //                                            //        string points = "points";
    //                                            //        if (dtR.Rows[0]["isCash"].ToString() != "0")
    //                                            //            points = "cash";
    //                                            //        else if (dtR.Rows[0]["Points"].ToString() != "0")
    //                                            //            points = "points";
    //                                            //        else if (dtR.Rows[0]["Gift"].ToString() != "0")
    //                                            //            points = "gift";

    //                                            //        result = result + " <br/>Congs! You have earn <b>" + points + "</b> againts your <b>Referral Code : " + ReferralCodeFromUser + " </b>.";
    //                                            //        //result = result + "Your " + ReferralCodeFromUser + " is expired.Better luck next time!";
    //                                            //    }
    //                                            //}
    //                                        }
    //                                        #endregion
    //                                        break;
    //                                    }
    //                                case "SRV1024": //Paytm 
    //                                    {
    //                                        #region Paytm
    //                                        //DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
    //                                        //if (dt.Rows.Count > 0)
    //                                        //{
    //                                        //    string strEarnedPoints = dt.Rows[0]["Points"].ToString();
    //                                        //    string Iscash = dt.Rows[0]["Iscash"].ToString();
    //                                        //    string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

    //                                        //    if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
    //                                        //    {
    //                                        //        // if (IsCashConvert == "0") // ask arish below point? Covert points to cash will do end user/company user
    //                                        //        //result = result + " You have gained <b> Rs" + Iscash + "/- </b> against the purchased product.Please complete your Profile details to avail cash amount - <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";

    //                                        //        strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, "", "", " Service_ID = 'SRV1024' and MsgType = 1", Iscash, CompName);
    //                                        //        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();

    //                                        //        // else
    //                                        //        //      result = result + " You have won a gift againts earned points.Please complete your profile details to claim your gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>";
    //                                        //    }
    //                                        //    else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
    //                                        //    {
    //                                        //        //result = result + "Just left with " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " more purchase and will gain a cash of  <b> Rs" + Iscash + "/- </b>.";
    //                                        //        strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, "", "", " Service_ID = 'SRV1024' and MsgType = 1", Iscash, CompName);
    //                                        //        result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();

    //                                        //    }

    //                                        //}

    //                                        if (CompName.ToUpper() == "MYSHA HEALTH WORLD")
    //                                        {
    //                                            DataSet ds = SQL_DB.ExecuteDataSet("select * from dbo.MoblileRegisterForPaytm where mobileno='" + strMobileNo + "'");
    //                                            if (ds.Tables[0].Rows.Count > 0)
    //                                            {

    //                                                DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
    //                                                if (dt.Rows.Count > 0)
    //                                                {
    //                                                    string strEarnedPoints = dt.Rows[0]["Points"].ToString();
    //                                                    string Iscash = dt.Rows[0]["Iscash"].ToString();
    //                                                    string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

    //                                                    if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
    //                                                    {
    //                                                        // if (IsCashConvert == "0") // ask arish below point? Covert points to cash will do end user/company user
    //                                                        //result = result + " You have gained <b> Rs" + Iscash + "/- </b> against the purchased product.Please complete your Profile details to avail cash amount - <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";

    //                                                        strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, "", "", " Service_ID = 'SRV1024' and MsgType = 1", Iscash, CompName);
    //                                                        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();

    //                                                        // else
    //                                                        //      result = result + " You have won a gift againts earned points.Please complete your profile details to claim your gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>";
    //                                                    }
    //                                                    else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
    //                                                    {
    //                                                        //result = result + "Just left with " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " more purchase and will gain a cash of  <b> Rs" + Iscash + "/- </b>.";
    //                                                        strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, "", "", " Service_ID = 'SRV1024' and MsgType = 1", Iscash, CompName);
    //                                                        result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();

    //                                                    }

    //                                                }
    //                                            }
    //                                        }
    //                                        else
    //                                        {
    //                                            DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
    //                                            if (dt.Rows.Count > 0)
    //                                            {
    //                                                string strEarnedPoints = dt.Rows[0]["Points"].ToString();
    //                                                string Iscash = dt.Rows[0]["Iscash"].ToString();
    //                                                string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

    //                                                if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
    //                                                {
    //                                                    // if (IsCashConvert == "0") // ask arish below point? Covert points to cash will do end user/company user
    //                                                    //result = result + " You have gained <b> Rs" + Iscash + "/- </b> against the purchased product.Please complete your Profile details to avail cash amount - <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";

    //                                                    strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, "", "", " Service_ID = 'SRV1024' and MsgType = 1", Iscash, CompName);
    //                                                    result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();

    //                                                    // else
    //                                                    //      result = result + " You have won a gift againts earned points.Please complete your profile details to claim your gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>";
    //                                                }
    //                                                else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
    //                                                {
    //                                                    //result = result + "Just left with " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " more purchase and will gain a cash of  <b> Rs" + Iscash + "/- </b>.";
    //                                                    strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, "", "", " Service_ID = 'SRV1024' and MsgType = 1", Iscash, CompName);
    //                                                    result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();

    //                                                }

    //                                            }
    //                                        }
    //                                        #endregion
    //                                        break;
    //                                    }
    //                                default:
    //                                    break;

    //                            }
    //                            #endregion
    //                        }


    //                        #endregion
    //                    }
    //                    else
    //                    {
    //                        if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToLower() == "1 stop nutrition")
    //                        {
    //                            result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + "   Tnx SKS Nutritions";
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //        else if (IsCheckedUse_Count)
    //        {
    //            string strReturnMSG = string.Empty;
    //            CompName = dsres.Tables[0].Rows[0]["Comp_Name"].ToString();
    //            Reg.Is_Success = 2;
    //            DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
    //            Business9420.function9420.InsertCodeChecked(Reg);
    //            if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "MAHINDRA AND MAHINDRA LTD")
    //            {
    //                if (dsServicesAssign.Tables[0].Rows.Count > 0)
    //                {
    //                    if (dsServicesAssign.Tables[0].Rows[0]["Service_id"].ToString() == "SRV1005")
    //                    {
    //                        result += dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " bucket with code1-" + Reg.Received_Code1 + " code2-" + Reg.Received_Code2 + " has already been checked before. Kindly purchase a fresh bucket. for customer support contact at 9243029420 Thanks VCQRU. ";

    //                    }
    //                    else if (dsServicesAssign.Tables[0].Rows[0]["Service_id"].ToString() == "SRV1018")
    //                    {
    //                        //result += dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with code1-" + Reg.Received_Code1 + " code2-" + Reg.Received_Code2 + " has already been checked before. Kindly purchase a fresh bucket. for customer support contact at 9243029420 Thanks VCQRU. ";
    //                        result += "This product code " + Reg.Received_Code1 + Reg.Received_Code2 + " has already been checked before.If you have purchased a fresh pack and have any query kindly contact at 9243029420 or visit www.vcqru.com";
    //                    }
    //                    else
    //                    {
    //                        result += dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with code1-" + Reg.Received_Code1 + " code2-" + Reg.Received_Code2 + " has already been checked before. Kindly purchase a fresh bucket. for customer support contact at 9243029420 Thanks VCQRU. ";

    //                    }
    //                }//string smsBodyMsg = dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with code1-" + Reg.Received_Code1 + " code2-" + Reg.Received_Code2 + " has already been checked before. Kindly purchase a fresh bucket. for customer support contact at 0124-4001928 Thanks VCQRU. ";
    //                //ServiceLogic.SendSMSFromAlfa(Reg.Mobile_No, smsBodyMsg);
    //            }
    //            else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToLower() == "1 stop nutrition")
    //            {
    //                result += "The product with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is already checked. If you have purchased a product with unscratched label, contact the manufacturer.   Tnx SKS Nutritions";
    //            }
    //            else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "UNIGLOBAL DISTRIBUTORS PRIVATE LIMITED")
    //            {
    //                result += "This product code " + Reg.Received_Code1 + Reg.Received_Code2 + " has already been checked before. If you have any query kindly contact at 9243029420 or visit www.vcqru.com ";
    //            }
    //            else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "Competent Electricals India")
    //            {
    //                DataSet ds = SQL_DB.ExecuteDataSet("select * from dbo.Pro_Enq where MobileNo='" + strMobileNo + "' and Received_Code1='" + Reg.Received_Code1 + "' AND Received_Code2 = '" + Reg.Received_Code2 + "' and is_success=1");
    //                if (ds.Tables[0].Rows.Count > 0)
    //                {
    //                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1018' and MsgType =8", CompName);
    //                    result = result + (strReturnMSG.Replace("<cash>", "").Replace("<ProductName>", "").Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
    //                    //result = result + "THE PRODUCT WITH CODE 1 - " + Reg.Received_Code1 + " AND CODE2 - " + Reg.Received_Code2 + " IS GENEUIN. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN IT CAN BE CHECKED/PROCESS FURTHER.";
    //                }

    //                else
    //                {
    //                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1018' and MsgType = 9", CompName);
    //                    result = result + (strReturnMSG.Replace("<cash>", "").Replace("<ProductName>", "").Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
    //                    //result = result + "THE PRODUCT WITH CODE 1 - " + Reg.Received_Code1 + " AND CODE2 - " + Reg.Received_Code2 + " HAS ALREADY BEEN CHECKED BEFORE. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN IT CAN BE CHECKED/PROCESS FURTHER.";
    //                }
    //            }
    //            else
    //            {
    //                result = result + "THE PRODUCT WITH CODE 1 - " + Reg.Received_Code1 + " AND CODE2 - " + Reg.Received_Code2 + " HAS ALREADY BEEN CHECKED BEFORE. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN IT CAN BE CHECKED/PROCESS FURTHER.";

    //            }

    //            //for (int i = 0; i < dtServiceAssign.Rows.Count; i++)
    //            //{
    //            //    if (i > 0) result = result + "<br/>";
    //            //    string stServiceid = dtServiceAssign.Rows[i]["Service_ID"].ToString();
    //            //    switch (stServiceid)
    //            //    {

    //            //        case "SRV1018":
    //            //            {
    //            //                result = result + "THE AUTHENTICITY OF THE PRODUCT WITH CODE 1 " + Reg.Received_Code1 + " AND CODE2 " + Reg.Received_Code2 + " HAS ALREADY BEEN CHECKED BEFORE. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN ITS AUTHENTICITY CAN NOT BE GUARANTEED.";
    //            //                break;
    //            //            }
    //            //        case "SRV1003":
    //            //            {
    //            //                result = result + "THE  PRODUCT WITH CODE 1 " + Reg.Received_Code1 + " AND CODE2 " + Reg.Received_Code2 + " HAS ALREADY BEEN CHECKED BEFORE. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN ITS AUTHENTICITY CAN NOT BE GUARANTEED.";
    //            //                break;
    //            //            }
    //            //}
    //        }
    //        if (string.IsNullOrEmpty(result))
    //        {
    //            if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "MAHINDRA AND MAHINDRA LTD")
    //            {
    //                Reg.Is_Success = 0;
    //                long intM_Consumer_MCOde = Business9420.function9420.InsertCodeChecked(Reg);
    //                result = "Sorry, this coupon cannot be redeemed. This mechanic coupon scheme has been closed. Thanks for your participation";

    //            }
    //            else
    //            {
    //                Reg.Is_Success = 0;
    //                long intM_Consumer_MCOde = Business9420.function9420.InsertCodeChecked(Reg);
    //                result = "Thank You for visiting VCQRU.com";
    //            }
    //        }
    //        else if (!string.IsNullOrEmpty(result))
    //        {
    //            if (CompName.ToLower() != "nutriglow")
    //            {
    //                if (Dial_Mode.ToLower() == "website")

    //                    if (CompName.ToUpper() == "MAHINDRA AND MAHINDRA LTD")
    //                    {
    //                        //if (IsCheckedUse_Count)
    //                        //    result = result + " <br/><br/> THANKS VCQRU";


    //                    }
    //                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "UNIGLOBAL DISTRIBUTORS PRIVATE LIMITED")
    //                    {

    //                    }
    //                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "MYSHA HEALTH WORLD")
    //                    { }
    //                    else if (CompName.ToUpper() != "MFN")
    //                        result = result + " <br/><br/> MFD BY " + CompName + " " + DefaultComments + " THANKS VCQRU";
    //                    else
    //                    {
    //                        result = result.Replace("TNX VCQRU.COM", "mfd by " + CompName.ToUpper() == "" ? dsres.Tables[0].Rows[0]["Comp_Name"].ToString() : CompName.ToUpper() + "  TNX VCQRU.COM").ToUpper();
    //                    }
    //            }
    //        }

    //        #endregion
    //    }
    //    catch (Exception ex)
    //    {

    //        string ErrorPagePath = HttpContext.Current.Request.Url.ToString();
    //        Exception ErrorInfo = ex.GetBaseException(); //HttpContext.Current.Server.GetLastError().GetBaseException();
    //        DataProvider.LogManager.ErrorExceptionLog(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
    //        DataProvider.LogManager.ErrorExceptionLog(ErrorPagePath);
    //        DataProvider.LogManager.ErrorExceptionLog(ErrorInfo.Message);
    //        DataProvider.LogManager.ErrorExceptionLog("\n" + ErrorInfo.StackTrace + "\n");
    //        DataProvider.LogManager.ErrorExceptionLog("\n UserHostAddress: " + Convert.ToString(HttpContext.Current.Request.UserHostAddress) + ",REMOTE_ADDR: " + HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] + ", HTTP_X_FORWARDED_FOR: " + Convert.ToString(HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"]));
    //    }
    //    return result;
    //}
    //public static string ServiceRequestCheck(DataSet dsres, Object9420 Reg, string strMobileNo, bool IsCheckedUse_Count, string ReferralCodeFromUser, string Dial_Mode)
    //{
    //    string DefaultComments = ""; string CompName = string.Empty; string result = string.Empty;
    //    DataTable dtServiceAssign = new DataTable();
    //    DataTable dtTotalCodesCount = new DataTable();
    //    string strSeperator = "<br/><br/>";
    //    try
    //    {
    //        #region MyRegion
    //        DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(dsres.Tables[0].Rows[0]["Pro_ID"].ToString());
    //        if (!IsCheckedUse_Count)
    //        {

    //            Reg.Is_Success = 1;
    //            if (dsres.Tables[0].Rows.Count > 0)
    //            {
    //                if (dsServicesAssign.Tables.Count <= 2)
    //                {
    //                    dtServiceAssign = dsServicesAssign.Tables[0];
    //                    dtTotalCodesCount = dsServicesAssign.Tables[1];

    //                    if (dtServiceAssign.Rows.Count > 0)
    //                    {
    //                        #region Loop in service
    //                        CompName = dsres.Tables[0].Rows[0]["Comp_Name"].ToString();
    //                        string json = JsonConvert.SerializeObject(Reg, Formatting.Indented);
    //                        DataProvider.LogManager.ErrorExceptionLog(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "        " + json);
    //                        long intM_Consumer_MCOde = Business9420.function9420.InsertCodeChecked(Reg); // doing entry in Pro_Enq tabgle (PROC_InsertProductInquery)
    //                        DataProvider.LogManager.ErrorExceptionLog(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "        " + json);
    //                        Business9420.function9420.UpdateUse_CountM_Code(Reg);// update [Use_Count] =0 in M_Code
    //                        ProjectSession.strMobileNo = Reg.Mobile_No;
    //                        ProjectSession.intM_Consumer_MCOde = intM_Consumer_MCOde;
    //                        Reg.intM_Consumer_MCOde = intM_Consumer_MCOde;

    //                        try
    //                        {
    //                            DataRow[] drw = dtServiceAssign.Select("Service_id = 'SRV1023'");
    //                            //////////////Comment by sandeep 040620///////////////
    //                            // string strWar = "Warranty for the " + CompName + " (" + Convert.ToString(drw[0]["PNm"]) + ") has " +
    //                            //"registered successfully for (" + Convert.ToString(drw[0]["WarrantyPeriod"]) + " months )";
    //                            // HttpContext.Current.Session["strWar"] = strWar;
    //                        }
    //                        catch (Exception ex)
    //                        {
    //                            ex.StackTrace.ToString();
    //                            //throw ex.Message.ToString();
    //                        }


    //                        //string strReferralCode = Convert.ToString(SQL_DB.ExecuteScalar("Select dbo.GetZeroConcactWithReferralCode(referralcode)  FROM [M_Consumer] where [MobileNo] = '" + strMobileNo + "'"));
    //                        //SendSms("Congs! Gained Referral code-" + strReferralCode + "", ProjectSession.strMobileNo);

    //                        #region Seperator "*" to concact string msg 
    //                        // if (i > 0) result = result + "<br/>";

    //                        if (Dial_Mode.ToLower() == "website")
    //                        {
    //                            strSeperator = "<br/><br/>";
    //                        }
    //                        else
    //                        {
    //                            strSeperator = "*";
    //                        }

    //                        #endregion
    //                        string strReturnMSG = string.Empty;
    //                        // Get Return message from Template Msg Table i.e 
    //                        DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
    //                        //bool Status = false;
    //                        for (int i = 0; i < dtServiceAssign.Rows.Count; i++)
    //                        {
    //                            if (i > 0) result = result + strSeperator;
    //                            #region
    //                            string stServiceid = dtServiceAssign.Rows[i]["Service_ID"].ToString();
    //                            DataRow[] dr = dtServiceAssign.Select("Service_id = '" + stServiceid + "'");

    //                            switch (stServiceid)
    //                            {
    //                                case "SRV1023":// build loyalty
    //                                    {
    //                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1023' and MsgType = 9");
    //                                        if (!string.IsNullOrEmpty(dtServiceAssign.Rows[i]["WarrantyPeriod"].ToString()))
    //                                        {
    //                                            //if (WarrantyPeriod)

    //                                            result = result + (strReturnMSG.Replace("<warrpariod>", dtServiceAssign.Rows[i]["WarrantyPeriod"].ToString() + " months")).ToUpper();
    //                                        }
    //                                        else
    //                                        {
    //                                            result = result + (strReturnMSG.Replace("<warrpariod>", " 0 months")).ToUpper();
    //                                        }
    //                                        break;
    //                                    }
    //                                case "SRV1001":// build loyalty
    //                                    {
    //                                        #region build loyalty
    //                                        DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
    //                                        if (dt.Rows.Count > 0)
    //                                        {
    //                                            string strEarnedPoints = dt.Rows[0]["Points"].ToString();
    //                                            string IsCashConvert = dt.Rows[0]["IsCashConvert"].ToString();
    //                                            string AwardNameBL = dt.Rows[0]["AwardNameBL"].ToString();
    //                                            if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
    //                                            {
    //                                                if (IsCashConvert == "0") // Covert points to cash will do end user
    //                                                {
    //                                                    //result = result + " You have earned " + strEarnedPoints + " points. Redeem points and earn cash - <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";
    //                                                    // result = result + "Congs! earned <points> points.Redeem-<absoluteSiteBrowseUrl>/Info/Consumerregister.aspx#trylogin.";
    //                                                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1001' and MsgType = 4");
    //                                                    result = result + (strReturnMSG.Replace("<points>", strEarnedPoints).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
    //                                                }
    //                                                else
    //                                                {
    //                                                    // if (!string.IsNullOrEmpty(AwardNameBL))
    //                                                    // {
    //                                                    // result = result + "You have won a <b>gift</b> againts earned points. Redeem points and earn gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";
    //                                                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1001' and MsgType = 5");
    //                                                    result = result + (strReturnMSG.Replace("<points>", strEarnedPoints).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
    //                                                    //}
    //                                                    //else
    //                                                    //{
    //                                                    //    result = result + "Congs! You have earned points againts the purchased product. ";
    //                                                    //}
    //                                                }
    //                                                // result = result + "Congs! You have earned points againts the purchased product. ";
    //                                            }
    //                                            else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
    //                                            {
    //                                                // result = result + "Congs! You can earn <b>points</b> againts the purchased product.Just left with  <b> " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " </b> more purchase ";
    //                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1001' and MsgType = 6");
    //                                                result = result + (strReturnMSG.Replace("<points>", strEarnedPoints).Replace("<frequency>", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();
    //                                            }
    //                                        }
    //                                        #endregion
    //                                        break;
    //                                    }
    //                                case "SRV1002"://Run Surveys
    //                                    {
    //                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1002' and MsgType = 4");
    //                                        result = result + (strReturnMSG.Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)
    //                                                                       .Replace("<strMobileNo>", ProjectSession.strMobileNo)
    //                                                                        .Replace("<intM_Consumer_MCOde>", ProjectSession.intM_Consumer_MCOde.ToString())).ToUpper();
    //                                        // result = result + ShowMessageForRunSurvey();
    //                                        break;
    //                                    }
    //                                case "SRV1018"://COUNTERFIETING
    //                                    {
    //                                        DataView dv = MsgTempdt.DefaultView;
    //                                        if (CompName.ToUpper() == "MFN")
    //                                        {
    //                                            dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 4";
    //                                        }


    //                                        else if (CompName.ToUpper() == "MAHINDRA AND MAHINDRA LTD")
    //                                        {
    //                                            dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 5";
    //                                        }
    //                                        else if (CompName.ToUpper() == "UNIGLOBAL DISTRIBUTORS PRIVATE LIMITED")
    //                                        {
    //                                            dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 6";
    //                                        }
    //                                        else if (CompName.ToUpper() == "MYSHA HEALTH WORLD")
    //                                        {
    //                                            if (Reg.Dial_Mode != "SMS")
    //                                                dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 7";
    //                                            else
    //                                                dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 10";
    //                                        }

    //                                        else if (CompName == "Competent Electricals India")
    //                                        {
    //                                            dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 9";
    //                                        }
    //                                        else if (CompName == "Generic Pharma")
    //                                        {
    //                                            dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 11";
    //                                        }
    //                                        else
    //                                        {
    //                                            dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 1";
    //                                        }
    //                                        DataTable fdt = dv.ToTable();

    //                                        #region Loyalty
    //                                        //*************** Brand Loyalty Code start ******************//
    //                                        string LoyaltyMessage = "";
    //                                        LoyaltyMessage = GetMyMessage(strMobileNo, Reg.Received_Code1, Reg.Received_Code2, Reg.Mode_Detail);
    //                                        //*************** Brand Loyalty Code end ******************//
    //                                        if (Reg.Comp_type == "L")
    //                                        {
    //                                            // m_Amc_offer is for renewal
    //                                            DataSet ds1 = SQL_DB.ExecuteDataSet("select * from M_Amc_Offer  WHERE Pro_Id = '" + dsres.Tables[0].Rows[0]["Pro_ID"].ToString() + "' AND Trans_Type = 'Offer' AND  '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' BETWEEN convert(nvarchar,Date_From,111) AND convert(nvarchar,Date_To,111)");
    //                                            if (ds1.Tables[0].Rows.Count > 0)
    //                                                DefaultComments = ds1.Tables[0].Rows[0]["Comments"].ToString();
    //                                            else
    //                                                DefaultComments = "";
    //                                        }
    //                                        else
    //                                            DefaultComments = dsres.Tables[0].Rows[0]["Comments"].ToString();
    //                                        DefaultComments += " " + LoyaltyMessage;
    //                                        if (dsres.Tables[0].Rows[0]["Exp_Date"].ToString() == "01/01/1900")
    //                                        {
    //                                            //  result = result + "Code1-" + Reg.Received_Code1 + " & Code2-" + Reg.Received_Code2 + ", Prod-" + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", SN-" + dsres.Tables[0].Rows[0]["series"].ToString() + "" +
    //                                            //                      ", MRP-" + dsres.Tables[0].Rows[0]["MRP"].ToString() + ", MFG" + dsres.Tables[0].Rows[0]["Mfd_Date"].ToString() + ", EXP, BtNo-" + dsres.Tables[0].Rows[0]["Batch_No"].ToString() + ", PROD IS GENUINE.";// & mfd by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + " " + DefaultComments + " Tnx label9420";

    //                                            if (CompName.ToLower() == "1 stop nutrition")
    //                                            {
    //                                                result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "    Tnx SKS Nutritions";
    //                                            }
    //                                            else
    //                                            {
    //                                                if (result != "")
    //                                                    result += fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<MRP>", dsres.Tables[0].Rows[0]["MRP"].ToString()).Replace("<MFD>", Convert.ToDateTime(dsres.Tables[0].Rows[0]["Mfd_Date"]).ToString("MM/yyyy")).Replace("<BTNO>", dsres.Tables[0].Rows[0]["Batch_No"].ToString()).Replace("<SMS>", dsres.Tables[0].Rows[0]["Comments"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString()).Replace("EXP <EXP>", "");
    //                                                else
    //                                                    result += fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>",
    //                                                        Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<MRP>",
    //                                                        dsres.Tables[0].Rows[0]["MRP"].ToString()).Replace("<MFD>",
    //                                                        Convert.ToDateTime(dsres.Tables[0].Rows[0]["Mfd_Date"]).ToString("MM/yyyy")).Replace("<BTNO>",
    //                                                        dsres.Tables[0].Rows[0]["Batch_No"].ToString()).Replace("<SMS>",
    //                                                        dsres.Tables[0].Rows[0]["Comments"].ToString()).Replace("<CMPNAME>",
    //                                                        dsres.Tables[0].Rows[0]["Comp_Name"].ToString()).Replace("EXP <EXP>", "");
    //                                                //if (!string.IsNullOrEmpty(dsres.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString()))
    //                                                //{
    //                                                //    result += result.Replace("<warranty>", "Warranty -" + dsres.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString() + " months");
    //                                                //}
    //                                                //else
    //                                                //{
    //                                                //    result += result.Replace("<warranty>", "");
    //                                                //}
    //                                            }
    //                                        }
    //                                        else
    //                                        {
    //                                            if (CompName.ToLower() == "1 stop nutrition")
    //                                            {
    //                                                result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "   Tnx SKS Nutritions";
    //                                            }
    //                                            else if (CompName.ToLower() == "nutriglow")
    //                                            {
    //                                                result = "GENUINE CODE " + Reg.Received_Code1 + "-" + Reg.Received_Code2 + "," + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + "," +
    //                                                   dsres.Tables[0].Rows[0]["MRP"].ToString() + "," + DefaultComments;

    //                                            }
    //                                            else

    //                                            {
    //                                                //result = result + " Code1-" + Reg.Received_Code1 + " & Code2-" + Reg.Received_Code2 + ", Prod-" + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", SN-" + dsres.Tables[0].Rows[0]["series"].ToString() + "" +
    //                                                //                        ", MRP-" + dsres.Tables[0].Rows[0]["MRP"].ToString() + ", MFG" + dsres.Tables[0].Rows[0]["Mfd_Date"].ToString() + ", EXP" + dsres.Tables[0].Rows[0]["Exp_Date"].ToString() + ", BtNo-" + dsres.Tables[0].Rows[0]["Batch_No"].ToString() + ", <b> PROD IS GENUINE </b>."; //& mfd by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + " " + DefaultComments + " Tnx label9420";
    //                                                result += fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>",
    //                                                   Reg.Received_Code2).Replace("<PRONAME>",
    //                                                   dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<MRP>",
    //                                                   dsres.Tables[0].Rows[0]["MRP"].ToString()).Replace("<MFD>",
    //                                                   Convert.ToDateTime(dsres.Tables[0].Rows[0]["Mfd_Date"]).ToString("MM/yyyy")).Replace("<EXP>",
    //                                                   Convert.ToDateTime(dsres.Tables[0].Rows[0]["Exp_Date"]).ToString("MM/yyyy")).Replace("<BTNO>",
    //                                                   dsres.Tables[0].Rows[0]["Batch_No"].ToString()).Replace("<SMS>", dsres.Tables[0].Rows[0]["Comments"].ToString())
    //                                                   .Replace("<CMPNAME>",
    //                                                   dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
    //                                                //if (!string.IsNullOrEmpty(dsres.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString()))
    //                                                //{
    //                                                //    result += result.Replace("<warranty>", "Warranty -" + dsres.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString() + " months");
    //                                                //}
    //                                                //else
    //                                                //{
    //                                                //    result += result.Replace("<warranty>", "");
    //                                                //}
    //                                                //.Replace("<warranty>", dsres.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString() + " months");
    //                                                // SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('exp date -" + Convert.ToDateTime(dsres.Tables[0].Rows[0]["Exp_Date"]).ToString("MM/yyyy") + "')");
    //                                            }
    //                                        }


    //                                        //   Status = true;
    //                                        //   return Status + "*" + result;
    //                                        //if (!string.IsNullOrEmpty(result))
    //                                        //{
    //                                        //    result = result + " & mfd by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + " " + DefaultComments + " Tnx label9420";
    //                                        //}
    //                                        break;
    //                                        #endregion
    //                                    }
    //                                //case "SRV1004": //Big Data Analysis - not required for code check.
    //                                //     {

    //                                //         break;
    //                                //     }
    //                                case "SRV1005": //Cash Transfers
    //                                    {
    //                                        #region Cah Transfer
    //                                        DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
    //                                        if (dt.Rows.Count > 0)
    //                                        {
    //                                            string strEarnedPoints = dt.Rows[0]["Points"].ToString();
    //                                            string Iscash = dt.Rows[0]["Iscash"].ToString();
    //                                            string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

    //                                            if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
    //                                            {
    //                                                // if (IsCashConvert == "0") // ask arish below point? Covert points to cash will do end user/company user
    //                                                //result = result + " You have gained <b> Rs" + Iscash + "/- </b> against the purchased product.Please complete your Profile details to avail cash amount - <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";
    //                                                if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "MAHINDRA AND MAHINDRA LTD")
    //                                                {
    //                                                    if (Dial_Mode == "SMS")
    //                                                    {
    //                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
    //                                                                                                                                                                    //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
    //                                                        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
    //                                                                                        .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();

    //                                                    }
    //                                                    else
    //                                                    {
    //                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
    //                                                                                                                                                                    //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
    //                                                        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
    //                                                                                        .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
    //                                                    }
    //                                                }
    //                                                else
    //                                                {
    //                                                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
    //                                                    result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
    //                                                }
    //                                                // else
    //                                                //      result = result + " You have won a gift againts earned points.Please complete your profile details to claim your gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>";
    //                                            }
    //                                            else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
    //                                            {
    //                                                //result = result + "Just left with " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " more purchase and will gain a cash of  <b> Rs" + Iscash + "/- </b>.";
    //                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 5");
    //                                                result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();
    //                                            }

    //                                        }
    //                                        #endregion
    //                                        break;
    //                                    }
    //                                case "SRV1003": //Gift Coupons
    //                                    {
    //                                        #region GiftCoupon
    //                                        //GetGiftCouponService();
    //                                        //DataRow[] dr = dtServiceAssign.Select("Service_id = '" + stServiceid + "'");
    //                                        if (dr.Length > 0)
    //                                        {
    //                                            strDialMode1 = Dial_Mode;
    //                                            result = result + ServiceLogic.GetGiftCouponService(dr[0], Convert.ToInt32(dtTotalCodesCount.Rows[0][0].ToString()), Reg.Received_Code1, Reg.Received_Code2, Reg.Comp_ID, false, stServiceid, Reg);
    //                                        }
    //                                        #endregion
    //                                        break;
    //                                    }
    //                                case "SRV1006": //Raffle Scheme
    //                                    {
    //                                        #region Raffle Service
    //                                        //Reg.Is_Success = 0;
    //                                        //Business9420.function9420.InsertCodeChecked(Reg);
    //                                        if (dr.Length > 0)
    //                                        {
    //                                            strDialMode1 = Dial_Mode;
    //                                            result = result + ServiceLogic.GetGiftCouponService(dr[0], Convert.ToInt32(dtTotalCodesCount.Rows[0][0].ToString()), Reg.Received_Code1, Reg.Received_Code2, Reg.Comp_ID, true, stServiceid, Reg);

    //                                        }
    //                                        //result = result + "Wprk in process";
    //                                        #endregion
    //                                        break;
    //                                    }
    //                                case "SRV1020": //Referral
    //                                    {


    //                                        #region Referral
    //                                        DataSet ds = Proc_SaveCodeDtsForReferralService(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde, ReferralCodeFromUser);
    //                                        DataTable dt = ds.Tables[0];
    //                                        // DataTable dtReferralLimit = ds.Tables[1];
    //                                        // string strlimit = string.Empty;
    //                                        //if (dtReferralLimit.Rows.Count > 0)
    //                                        //{
    //                                        //    strlimit = dtReferralLimit.Rows[0]["limit"].ToString();
    //                                        //}
    //                                        if (dt.Rows.Count > 0)
    //                                        {
    //                                            //string strReferralCode = dt.Rows[0]["ReferralCode"].ToString();
    //                                            //  string IsCashConvert = dt.Rows[0]["IsCashConvert"].ToString();
    //                                            // if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
    //                                            {
    //                                                string points22 = "";
    //                                                if (dt.Rows[0]["IsReferral1"].ToString() == "1")
    //                                                    points22 = "cash";
    //                                                else if (dt.Rows[0]["IsReferral1"].ToString() == "2")
    //                                                    points22 = "points";
    //                                                else if (dt.Rows[0]["IsReferral1"].ToString() == "3")
    //                                                    points22 = "gift";


    //                                                string strReferralCode = dt.Rows[0]["NewGenerate_ReferralCode"].ToString();
    //                                                // if (IsCashConvert == "0") // ask arish below point? Covert points to cash will do end user/company user
    //                                                //if (!string.IsNullOrEmpty(strReferralCode))
    //                                                if (string.IsNullOrEmpty(ReferralCodeFromUser))
    //                                                {
    //                                                    if (Convert.ToInt32(dt.Rows[0]["limitno"]) > 0)
    //                                                    {
    //                                                        // DataView dv = MsgTempdt.DefaultView;
    //                                                        // dv.RowFilter = ;
    //                                                        //  DataTable fdt = dv.ToTable();
    //                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1020' and SubHeadId = 'POINTS' and MsgType =4");
    //                                                        result = result + (strReturnMSG.Replace("<strReferralCode>", strReferralCode)).ToUpper();

    //                                                        // result = result + "Congs! You gained <b>" + points22 + "</b> and  a referral code - <b>" + strReferralCode + "</b>.Share your referral code to <b>" + strlimit + " people </b> and gain benefits.";
    //                                                        //result += fdt.Rows[0]["MsgBody"].ToString().Replace("<strReferralCode>", strReferralCode);
    //                                                        // result = result + "Congs! Can gain (points/cash/gift),just share your referral code<b>(" + strReferralCode + ") others.";
    //                                                        //result = result + "Congs! You gained a referral code - <b>" + strReferralCode + "</b>.Share your referral code to people's and gain benefits.";
    //                                                        // SendSms("Congs! Gained Referral code-" + strReferralCode + "", ProjectSession.strMobileNo);
    //                                                    }

    //                                                }
    //                                                else if (!string.IsNullOrEmpty(ReferralCodeFromUser))
    //                                                {

    //                                                    //DataTable dtREFCODE = new DataTable();
    //                                                    //try
    //                                                    //{
    //                                                    //    string strval1 = ReferralCodeFromUser.Substring(3);
    //                                                    //    dtREFCODE = SQL_DB.ExecuteDataTable("select * from M_consumer where ReferralCode = " + strval1);                                                           
    //                                                    //}
    //                                                    //catch (Exception)
    //                                                    //{


    //                                                    //}
    //                                                    if (Convert.ToInt32(dt.Rows[0]["limitno"]) < 0)
    //                                                    {
    //                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1020' and SubHeadId = 'POINTS' and MsgType =5");
    //                                                        result = result + (strReturnMSG.Replace("<strReferralCode>", ReferralCodeFromUser)).ToUpper();
    //                                                        //result = result + " You have won a gift againts earned points.Please complete your profile details to claim your gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>";
    //                                                    }
    //                                                    else
    //                                                    {
    //                                                        #region
    //                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1020' and SubHeadId = 'POINTS' and MsgType =6");
    //                                                        result = result + (strReturnMSG.Replace("<point>", dt.Rows[0]["RefPoints_ReferUser"].ToString()).Replace("<strReferralCode>", ReferralCodeFromUser)).ToUpper();

    //                                                        if (Dial_Mode.ToLower() == "website")
    //                                                        {
    //                                                            SendSms((strReturnMSG.Replace("<point>", dt.Rows[0]["RefPoints_ReferUser"].ToString()).Replace("<strReferralCode>", ReferralCodeFromUser)).ToUpper()
    //                                                                , Reg.Mobile_No);// referral user.

    //                                                            if (ds.Tables.Count > 1)
    //                                                            {
    //                                                                DataTable dt_Ref_User = ds.Tables[1];
    //                                                                if (dt_Ref_User.Rows.Count > 0)
    //                                                                {
    //                                                                    if (dt_Ref_User.Rows[0][0].ToString() != "0")
    //                                                                    {
    //                                                                        SendSms((strReturnMSG.Replace("<point>", dt_Ref_User.Rows[0]["RefPoints_User"].ToString())
    //                                                                            .Replace("<strReferralCode>", ReferralCodeFromUser)).ToUpper().Replace("USING CODE", "REFFERING CODE")
    //                                                                            , dt_Ref_User.Rows[0]["User_ReferralCode_MobileNo"].ToString()); // the user
    //                                                                    }
    //                                                                }
    //                                                            }
    //                                                        }
    //                                                        else
    //                                                        {
    //                                                            // Note : this is for SMS
    //                                                            // here SMS(functionality) is going to the users (this user is using referral code) who done the code check. but for user (who's referral code is used must also receive SMS)
    //                                                            // so one of the user is doing code check and other user, who's referral code is used, must also receive a sms of earn benefits.                                                                
    //                                                            DataTable dt_Ref_User = ds.Tables[1];
    //                                                            if (dt_Ref_User.Rows.Count > 0)
    //                                                            {
    //                                                                if (dt_Ref_User.Rows[0][0].ToString() != "0")
    //                                                                {
    //                                                                    SendSms((strReturnMSG.Replace("<point>", dt_Ref_User.Rows[0]["RefPoints_User"].ToString())
    //                                                                      .Replace("<strReferralCode>", ReferralCodeFromUser)).ToUpper().Replace("USING CODE", "REFFERING CODE")
    //                                                                      , dt_Ref_User.Rows[0]["User_ReferralCode_MobileNo"].ToString()); // the user
    //                                                                }
    //                                                            }

    //                                                        }
    //                                                        #endregion
    //                                                    }


    //                                                }


    //                                            }
    //                                            //else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
    //                                            //{
    //                                            //    //result = result + "Congs! You have earned points againts the purchased product. ";
    //                                            //    string points = "";
    //                                            //    if (dt.Rows[0]["IsReferral1"].ToString() == "1")
    //                                            //        points = "cash";
    //                                            //    else if (dt.Rows[0]["IsReferral1"].ToString() == "2")
    //                                            //        points = "points";
    //                                            //    else if (dt.Rows[0]["IsReferral1"].ToString() == "3")
    //                                            //        points = "gift";

    //                                            //    result = result + "Congs! You can earn <b>" + points + "</b> againts your purchase.Just <b>" + dt.Rows[0]["ReachedFrequency"].ToString() + "</b> more purchase left.";
    //                                            //}
    //                                            //if (!string.IsNullOrEmpty(ReferralCodeFromUser))
    //                                            //{
    //                                            //    if (dt.Rows[0]["pkBReferralToOtherConsumerBenefit"].ToString() == "0")
    //                                            //    {
    //                                            //        result = result + "<br/> Your Referral Code : " + ReferralCodeFromUser + " is expired.Better luck next time!";
    //                                            //    }
    //                                            //    else if (Convert.ToInt32(dt.Rows[0]["pkBReferralToOtherConsumerBenefit"]) > 0)
    //                                            //    {


    //                                            //        // this is all the user who used the referral code reffered by other user
    //                                            //        DataTable dtR = ds.Tables[2];
    //                                            //        string points = "points";
    //                                            //        if (dtR.Rows[0]["isCash"].ToString() != "0")
    //                                            //            points = "cash";
    //                                            //        else if (dtR.Rows[0]["Points"].ToString() != "0")
    //                                            //            points = "points";
    //                                            //        else if (dtR.Rows[0]["Gift"].ToString() != "0")
    //                                            //            points = "gift";

    //                                            //        result = result + " <br/>Congs! You have earn <b>" + points + "</b> againts your <b>Referral Code : " + ReferralCodeFromUser + " </b>.";
    //                                            //        //result = result + "Your " + ReferralCodeFromUser + " is expired.Better luck next time!";
    //                                            //    }
    //                                            //}
    //                                        }
    //                                        #endregion
    //                                        break;
    //                                    }
    //                                case "SRV1024": //Paytm 
    //                                    {
    //                                        #region Paytm


    //                                        if (CompName.ToUpper() == "MYSHA HEALTH WORLD")
    //                                        {
    //                                            DataSet ds = SQL_DB.ExecuteDataSet("select * from dbo.MoblileRegisterForPaytm (nolock) where mobileno='" + strMobileNo + "'");
    //                                            if (ds.Tables[0].Rows.Count > 0)
    //                                            {

    //                                                DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
    //                                                if (dt.Rows.Count > 0)
    //                                                {
    //                                                    string strEarnedPoints = dt.Rows[0]["Points"].ToString();
    //                                                    string Iscash = dt.Rows[0]["Iscash"].ToString();
    //                                                    string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

    //                                                    if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
    //                                                    {
    //                                                        // if (IsCashConvert == "0") // ask arish below point? Covert points to cash will do end user/company user
    //                                                        //result = result + " You have gained <b> Rs" + Iscash + "/- </b> against the purchased product.Please complete your Profile details to avail cash amount - <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";
    //                                                        if (Reg.Dial_Mode == "SMS")
    //                                                        {
    //                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, "", "", " Service_ID = 'SRV1024' and MsgType = 2", Iscash, CompName);

    //                                                        }
    //                                                        else
    //                                                        {
    //                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, "", "", " Service_ID = 'SRV1024' and MsgType = 3", Iscash, CompName);
    //                                                        }
    //                                                        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
    //                                                        // else
    //                                                        //      result = result + " You have won a gift againts earned points.Please complete your profile details to claim your gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>";
    //                                                    }
    //                                                    else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
    //                                                    {
    //                                                        //result = result + "Just left with " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " more purchase and will gain a cash of  <b> Rs" + Iscash + "/- </b>.";
    //                                                        if (Reg.Dial_Mode == "SMS")
    //                                                        {
    //                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, "", "", " Service_ID = 'SRV1024' and MsgType = 2", Iscash, CompName);

    //                                                        }
    //                                                        else
    //                                                        {
    //                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, "", "", " Service_ID = 'SRV1024' and MsgType = 3", Iscash, CompName);
    //                                                        }
    //                                                        result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();

    //                                                    }

    //                                                }
    //                                            }
    //                                        }
    //                                        else
    //                                        {
    //                                            DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
    //                                            if (dt.Rows.Count > 0)
    //                                            {
    //                                                string strEarnedPoints = dt.Rows[0]["Points"].ToString();
    //                                                string Iscash = dt.Rows[0]["Iscash"].ToString();
    //                                                string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

    //                                                if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
    //                                                {
    //                                                    // if (IsCashConvert == "0") // ask arish below point? Covert points to cash will do end user/company user
    //                                                    //result = result + " You have gained <b> Rs" + Iscash + "/- </b> against the purchased product.Please complete your Profile details to avail cash amount - <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";

    //                                                    strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, "", "", " Service_ID = 'SRV1024' and MsgType = 1", Iscash, CompName);
    //                                                    result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();

    //                                                    // else
    //                                                    //      result = result + " You have won a gift againts earned points.Please complete your profile details to claim your gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>";
    //                                                }
    //                                                else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
    //                                                {
    //                                                    //result = result + "Just left with " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " more purchase and will gain a cash of  <b> Rs" + Iscash + "/- </b>.";
    //                                                    strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, "", "", " Service_ID = 'SRV1024' and MsgType = 1", Iscash, CompName);
    //                                                    result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();

    //                                                }

    //                                            }
    //                                        }
    //                                        #endregion
    //                                        break;
    //                                    }
    //                                default:
    //                                    break;

    //                            }
    //                            #endregion
    //                        }


    //                        #endregion
    //                    }
    //                    else
    //                    {
    //                        if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToLower() == "1 stop nutrition")
    //                        {
    //                            result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + "   Tnx SKS Nutritions";
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //        else if (IsCheckedUse_Count)
    //        {
    //            string strReturnMSG = string.Empty;
    //            CompName = dsres.Tables[0].Rows[0]["Comp_Name"].ToString();
    //            Reg.Is_Success = 2;
    //            DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
    //            DataView dv = MsgTempdt.DefaultView;
    //            Business9420.function9420.InsertCodeChecked(Reg);
    //            if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "MAHINDRA AND MAHINDRA LTD")
    //            {
    //                if (dsServicesAssign.Tables[0].Rows.Count > 0)
    //                {
    //                    if (dsServicesAssign.Tables[0].Rows[0]["Service_id"].ToString() == "SRV1005")
    //                    {
    //                        result += dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " bucket with code1-" + Reg.Received_Code1 + " code2-" + Reg.Received_Code2 + " has already been checked before. Kindly purchase a fresh bucket. for customer support contact at 9243029420 Thanks VCQRU. ";

    //                    }
    //                    else if (dsServicesAssign.Tables[0].Rows[0]["Service_id"].ToString() == "SRV1018")
    //                    {
    //                        //result += dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with code1-" + Reg.Received_Code1 + " code2-" + Reg.Received_Code2 + " has already been checked before. Kindly purchase a fresh bucket. for customer support contact at 9243029420 Thanks VCQRU. ";
    //                        result += "This product code " + Reg.Received_Code1 + Reg.Received_Code2 + " has already been checked before.If you have purchased a fresh pack and have any query kindly contact at 9243029420 or visit www.vcqru.com";
    //                    }
    //                    else
    //                    {
    //                        result += dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with code1-" + Reg.Received_Code1 + " code2-" + Reg.Received_Code2 + " has already been checked before. Kindly purchase a fresh bucket. for customer support contact at 9243029420 Thanks VCQRU. ";

    //                    }
    //                }//string smsBodyMsg = dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with code1-" + Reg.Received_Code1 + " code2-" + Reg.Received_Code2 + " has already been checked before. Kindly purchase a fresh bucket. for customer support contact at 0124-4001928 Thanks VCQRU. ";
    //                //ServiceLogic.SendSMSFromAlfa(Reg.Mobile_No, smsBodyMsg);
    //            }
    //            else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToLower() == "1 stop nutrition")
    //            {
    //                result += "The product with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is already checked. If you have purchased a product with unscratched label, contact the manufacturer.   Tnx SKS Nutritions";
    //            }
    //            else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "UNIGLOBAL DISTRIBUTORS PRIVATE LIMITED")
    //            {
    //                result += "This product code " + Reg.Received_Code1 + Reg.Received_Code2 + " has already been checked before. If you have any query kindly contact at 9243029420 or visit www.vcqru.com ";
    //            }
    //            else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "Competent Electricals India")
    //            {
    //                DataSet ds = SQL_DB.ExecuteDataSet("select * from dbo.Pro_Enq where MobileNo='" + strMobileNo + "' and Received_Code1='" + Reg.Received_Code1 + "' AND Received_Code2 = '" + Reg.Received_Code2 + "' and is_success=1");
    //                if (ds.Tables[0].Rows.Count > 0)
    //                {
    //                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1018' and MsgType =8", CompName);
    //                    result = result + (strReturnMSG.Replace("<cash>", "").Replace("<ProductName>", "").Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
    //                    //result = result + "THE PRODUCT WITH CODE 1 - " + Reg.Received_Code1 + " AND CODE2 - " + Reg.Received_Code2 + " IS GENEUIN. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN IT CAN BE CHECKED/PROCESS FURTHER.";
    //                }

    //                else
    //                {
    //                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1018' and MsgType = 9", CompName);
    //                    result = result + (strReturnMSG.Replace("<cash>", "").Replace("<ProductName>", "").Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
    //                    //result = result + "THE PRODUCT WITH CODE 1 - " + Reg.Received_Code1 + " AND CODE2 - " + Reg.Received_Code2 + " HAS ALREADY BEEN CHECKED BEFORE. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN IT CAN BE CHECKED/PROCESS FURTHER.";
    //                }
    //            }

    //            else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "MYSHA HEALTH WORLD")
    //            {

    //                if (Reg.Dial_Mode == "SMS")
    //                {
    //                    dv.RowFilter = "Service_ID = 'Already' and MsgType = 2";
    //                }
    //                else
    //                {
    //                    dv.RowFilter = "Service_ID = 'Already' and MsgType = 1";
    //                }
    //                DataTable fdt = dv.ToTable();
    //                result += fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);


    //            }

    //            else
    //            {
    //                result = result + "THE PRODUCT WITH CODE 1 - " + Reg.Received_Code1 + " AND CODE2 - " + Reg.Received_Code2 + " HAS ALREADY BEEN CHECKED BEFORE. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN IT CAN BE CHECKED/PROCESS FURTHER.";

    //            }

    //            //for (int i = 0; i < dtServiceAssign.Rows.Count; i++)
    //            //{
    //            //    if (i > 0) result = result + "<br/>";
    //            //    string stServiceid = dtServiceAssign.Rows[i]["Service_ID"].ToString();
    //            //    switch (stServiceid)
    //            //    {

    //            //        case "SRV1018":
    //            //            {
    //            //                result = result + "THE AUTHENTICITY OF THE PRODUCT WITH CODE 1 " + Reg.Received_Code1 + " AND CODE2 " + Reg.Received_Code2 + " HAS ALREADY BEEN CHECKED BEFORE. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN ITS AUTHENTICITY CAN NOT BE GUARANTEED.";
    //            //                break;
    //            //            }
    //            //        case "SRV1003":
    //            //            {
    //            //                result = result + "THE  PRODUCT WITH CODE 1 " + Reg.Received_Code1 + " AND CODE2 " + Reg.Received_Code2 + " HAS ALREADY BEEN CHECKED BEFORE. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN ITS AUTHENTICITY CAN NOT BE GUARANTEED.";
    //            //                break;
    //            //            }
    //            //}
    //        }
    //        if (string.IsNullOrEmpty(result))
    //        {
    //            if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "MAHINDRA AND MAHINDRA LTD")
    //            {
    //                Reg.Is_Success = 0;
    //                long intM_Consumer_MCOde = Business9420.function9420.InsertCodeChecked(Reg);
    //                result = "Sorry, this coupon cannot be redeemed. This mechanic coupon scheme has been closed. Thanks for your participation";

    //            }
    //            else
    //            {
    //                Reg.Is_Success = 0;
    //                long intM_Consumer_MCOde = Business9420.function9420.InsertCodeChecked(Reg);
    //                result = "Thank You for visiting VCQRU.com";
    //            }
    //        }
    //        else if (!string.IsNullOrEmpty(result))
    //        {
    //            if (CompName.ToLower() != "nutriglow")
    //            {
    //                if (Dial_Mode.ToLower() == "website")

    //                    if (CompName.ToUpper() == "MAHINDRA AND MAHINDRA LTD")
    //                    {
    //                        //if (IsCheckedUse_Count)
    //                        //    result = result + " <br/><br/> THANKS VCQRU";


    //                    }
    //                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "UNIGLOBAL DISTRIBUTORS PRIVATE LIMITED")
    //                    {

    //                    }
    //                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Generic Pharma")
    //                    {

    //                    }
    //                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "MYSHA HEALTH WORLD")
    //                    {
    //                        if (Reg.Dial_Mode != "SMS")
    //                        {
    //                            result = result.Replace(strSeperator, "");
    //                            result += " Kindly visit www.myshahealthworld.com for any query or call 9717344860";
    //                            result = result.ToUpper();
    //                        }

    //                    }
    //                    else if (CompName.ToUpper() != "MFN")
    //                        result = result + " <br/><br/> MFD BY " + CompName + " " + DefaultComments + " THANKS VCQRU";
    //                    else
    //                    {
    //                        result = result.Replace("TNX VCQRU.COM", "mfd by " + CompName.ToUpper() == "" ? dsres.Tables[0].Rows[0]["Comp_Name"].ToString() : CompName.ToUpper() + "  TNX VCQRU.COM").ToUpper();
    //                    }
    //            }
    //        }

    //        #endregion
    //    }
    //    catch (Exception ex)
    //    {

    //        string ErrorPagePath = HttpContext.Current.Request.Url.ToString();
    //        Exception ErrorInfo = ex.GetBaseException(); //HttpContext.Current.Server.GetLastError().GetBaseException();
    //        DataProvider.LogManager.ErrorExceptionLog(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
    //        DataProvider.LogManager.ErrorExceptionLog(ErrorPagePath);
    //        DataProvider.LogManager.ErrorExceptionLog(ErrorInfo.Message);
    //        DataProvider.LogManager.ErrorExceptionLog("\n" + ErrorInfo.StackTrace + "\n");
    //        DataProvider.LogManager.ErrorExceptionLog("\n UserHostAddress: " + Convert.ToString(HttpContext.Current.Request.UserHostAddress) + ",REMOTE_ADDR: " + HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] + ", HTTP_X_FORWARDED_FOR: " + Convert.ToString(HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"]));
    //    }
    //    return result;
    //}

    public static string OnlineAccountPayment(string Comp_Id, string Code1, string Code2, string M_Consumerid, string MobileNo, string Amount, string AccountNo, string BeneName, string IFSCCode)
    {
        string Rsp = "NA";

        try
        {
            SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("GetPayoutModedetails", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@CompId", Comp_Id);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dtMode = new DataTable();
            da.Fill(dtMode);
            con.Close();
            string Endpoint = "";
            if (dtMode.Rows.Count > 0)
            {

                if (dtMode.Rows[0][0].ToString() == "IMPS")
                    Endpoint = "MakeHDFC_IMPS_PaymentRequest";
                else if (dtMode.Rows[0][0].ToString() == "NEFT")
                    Endpoint = "MakeHDFC_NEFT_PaymentRequest";

                if (IFSCCode.Contains("hdfc"))
                    Endpoint = "MakeHDFC_A2A_PaymentRequest";


            }


            #region Commented due to claim process on same service
            string str = String.Format("https://api2.vcqru.com/api/" + Endpoint);
            WebRequest request = WebRequest.Create(str);
            request.Method = "POST";
            string postData = "{\"Comp_Id\":\"" + Comp_Id + "\",\"Code1\":\"" + Code1 + "\",\"Code2\":\"" + Code2 + "\",\"M_Consumerid\":\"" + M_Consumerid + "\",\"MobileNo\":\"" + MobileNo + "\",\"Amount\":\"" + Amount + "\",\"AccountNo\":\"" + AccountNo + "\",\"BeneName\":\"" + BeneName + "\",\"IFSCCode\":\"" + IFSCCode + "\",\"WebEncData\":\"d861967d37065f549c13e39cc9a8b9\"}"; byte[] byteArray = Encoding.UTF8.GetBytes(postData);

            request.ContentType = "application/json";//application/     x-www-form-urlencoded

            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();
            Console.WriteLine(((HttpWebResponse)response).StatusDescription);
            dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();
            Rsp = responseFromServer;
            #endregion
        }
        catch
        {

        }



        return Rsp;
    }

    public static bool MakeUPIpayment(string Comp_id, string Mobileno, string ConsumerName, string ConsumerEmail, string UPIId, string Amount, string M_Consumerid, string Code1 = "", string Code2 = "")
    {
        bool Rsp = false;

        try
        {
            string BaseUrl = ConfigurationManager.AppSettings["APIBaseUrl"];
            string str = String.Format("https://api2.vcqru.com/api/MakeRequestForUPIPayment");
            WebRequest request = WebRequest.Create(str);
            request.Method = "POST";
            string postData = "{\"Comp_id\":\"" + Comp_id + "\",\"M_Consumerid\":\"" + M_Consumerid + "\",\"Mobileno\":\"" + Mobileno + "\",\"ConsumerName\":\"" + ConsumerName + "\",\"ConsumerEmail\":\"" + ConsumerEmail + "\",\"UPIId\":\"" + UPIId + "\",\"Amount\":\"" + Amount + "\",\"Code1\":\"" + Code1 + "\",\"Code2\":\"" + Code2 + "\",\"WebEncData\":\"d861967d37065f549c13e39cc9a8b9_UPI\"}";
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);

            request.ContentType = "application/json";//application/     x-www-form-urlencoded

            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();
            Console.WriteLine(((HttpWebResponse)response).StatusDescription);
            dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();

            JObject jObjects = JObject.Parse(responseFromServer);
            DataTable dt = new DataTable();
            if (jObjects["Status"].ToString() == "True" || jObjects["Status"].ToString() == "true")
                Rsp = true;
        }
        catch (Exception ex)
        {

        }


        return Rsp;
    }


    public static string OnlineAccountVerification(string AccountNo, string IFSCCode, string M_Consumerid)
    {
        string Rsp = "NA";

        try
        {
            string str = String.Format("http://api2.vcqru.com/api/WebAccountVerification");
            WebRequest request = WebRequest.Create(str);
            request.Method = "POST";
            string postData = "{\"M_Consumerid\":\"" + M_Consumerid + "\",\"AccountNo\":\"" + AccountNo + "\",\"IFSCCode\":\"" + IFSCCode + "\",\"WebEncData\":\"d861967d37065f549c13e39cc9a8b9\"}";
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);

            request.ContentType = "application/x-www-form-urlencoded";//application/     x-www-form-urlencoded

            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();
            Console.WriteLine(((HttpWebResponse)response).StatusDescription);
            dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();

            //JObject jObjects = JObject.Parse(responseFromServer);
            //DataTable dt = new DataTable();
            //if (jObjects["Statuscode"].ToString() == "TXN")
            //{

            //}
        }
        catch (Exception ex)
        {

        }


        return Rsp;
    }

    public static string ServiceRequestCheck(DataSet dsres, Object9420 Reg, string strMobileNo, bool IsCheckedUse_Count, string ReferralCodeFromUser, string Dial_Mode, string BankName = "", string AccountNumber = "", string IfscCode = "", string AccountHolderName = "", string BranchName = "", string TNC = "")
    {
        string DefaultComments = ""; string Assinservice = string.Empty; string CompName = string.Empty; string result = string.Empty; string GerserviceId = string.Empty;
        DataTable dtServiceAssign = new DataTable();
        DataTable dtTotalCodesCount = new DataTable();
        string strSeperator = "<br/><br/>";
        string tempres = "";
        string Teslacodecheckselection = Reg.Others;
        try
        {
            #region MyRegion
            if (Reg.Dial_Mode == "IVR")
                Reg.Mobile_No = Reg.Mobile_No.Remove(0);

            strMobileNo = strMobileNo.Replace("+", "0");

            ///////////////////////whats app test///////////////////////
            GetMobileNo(strMobileNo);
            #region IF MobileNull
            if (string.IsNullOrEmpty(Reg.Mobile_No))
            {
                if (!string.IsNullOrEmpty(strMobileNo) && strMobileNo.Length >= 10)
                {
                    Reg.Mobile_No = "91" + strMobileNo.Substring(strMobileNo.Length - 10);
                }
            }
            #endregion

            //////////////////////////
            ///

            // DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(dsres.Tables[0].Rows[0]["Pro_ID"].ToString());

            if (string.IsNullOrEmpty(Reg.Comp_ID))
                Reg.Comp_ID = "";

            DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(Reg.Received_Code1.ToString(), Reg.Received_Code2.ToString(), Reg.Comp_ID.ToString());
            if (dsServicesAssign.Tables.Count > 0)
            {
                if (dsServicesAssign.Tables[0].Rows.Count > 0)
                    GerserviceId = dsServicesAssign.Tables[0].Rows[0]["Service_ID"].ToString();
                else
                {
                    if (Reg.Comp_ID.ToString() == "Comp-1693")
                        result = "The service of this coupon has been deactivated and cannot be verified, Please contact to support 7353000903.!";
                    else
                        result = "The service of this coupon has been deactivated , Please contact to your service provider.!";
                    return result;
                    result = "The service of this coupon has been deactivated , Please contact to your service provider.!";
                    return result;
                }
                //GerserviceId = dsServicesAssign.Tables[0].Rows[0]["Service_ID"].ToString();

            }

            #region Patanjali multi code scan
            int Use_Count = 0;
            if (Reg.Comp_ID == "Comp-1693")
            {
                DataTable dtMcodeCount = SQL_DB.ExecuteDataTable("select count(isnull(Row_ID,0)) Use_Count from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=1");
                if (dtMcodeCount.Rows.Count > 0)
                {
                    Use_Count = Convert.ToInt32(dtMcodeCount.Rows[0][0]);

                    if (Use_Count >= 3)
                    {
                        DataTable dtAlrdCount = SQL_DB.ExecuteDataTable("select count(isnull(Row_ID,0)) Use_Count from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=2");
                        if (dtAlrdCount.Rows.Count > 0)
                        {
                            int Already = 0;
                            Already = Convert.ToInt32(dtAlrdCount.Rows[0][0]);

                            Use_Count = Use_Count + Already;
                        }
                    }
                    IsCheckedUse_Count = true;


                }
            }

            #endregion

            #region Patanjali Different location code scan
            bool IsSameLocation = false;
            DataTable dtIsSameLocation = new DataTable();
            DataTable dtCode = new DataTable();
            dtCode = SQL_DB.ExecuteDataTable("select isnull(MobileNo,0) Use_Count from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "'  and (Is_Success=1 or Is_Success=2)");
            if (Reg.Latitude == "" || Reg.Latitude == null)
                dtIsSameLocation = SQL_DB.ExecuteDataTable("select isnull(MobileNo,0) Use_Count from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and ((PinCode='" + Reg.PinCode + "')) and (Is_Success=1 or Is_Success=2)");
            else
                dtIsSameLocation = SQL_DB.ExecuteDataTable("select isnull(MobileNo,0) Use_Count from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and ((Latitude='" + Reg.Latitude + "' and Longitude='" + Reg.Longitude + "') or (City='" + Reg.City + "' and state='" + Reg.State + "')) and (Is_Success=1 or Is_Success=2)");
            if (dtIsSameLocation.Rows.Count > 0 || dtCode.Rows.Count == 0)
            {
                IsSameLocation = true;


            }
            #endregion

            

            if (!IsCheckedUse_Count)
            {

                Reg.Is_Success = 1;
                if (dsres.Tables[0].Rows.Count > 0)
                {
                    if (dsServicesAssign.Tables.Count <= 2)
                    {
                        dtServiceAssign = dsServicesAssign.Tables[0];
                        dtTotalCodesCount = dsServicesAssign.Tables[1];

                        if (dtServiceAssign.Rows.Count > 0)
                        {
                            #region Loop in service
                            CompName = dsres.Tables[0].Rows[0]["Comp_Name"].ToString();
                            #region Ambica Refral Point Add
                            if (CompName == "Ambica Cable" && Reg.Refral != "")
                            {
                                //SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                                //con.Open();
                                //SqlCommand cmd = new SqlCommand("USP_CHKReffrel", con);
                                //cmd.CommandType = CommandType.StoredProcedure;
                                //cmd.Parameters.AddWithValue("@Reffrelcode", Reg.Refral);
                                //cmd.Parameters.AddWithValue("@Mobileno", Reg.Mobile_No);
                                //SqlDataAdapter da = new SqlDataAdapter(cmd);
                                //DataTable chkref = new DataTable();
                                //da.Fill(chkref);
                                //if (chkref.Rows[0][0].ToString() != "Already Used")
                                //{
                                //    SqlCommand cmd1 = new SqlCommand("Proc_AddRefralpoint", con);
                                //    cmd1.CommandType = CommandType.StoredProcedure;
                                //    cmd1.Parameters.AddWithValue("@Refralcode", Reg.Refral);
                                //    SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                                //    DataTable countcd = new DataTable();
                                //    da1.Fill(countcd);
                                //}
                                //con.Close();


                                DataTable chkref = SQL_DB.ExecuteDataTable("USP_CHKReffrel '" + Reg.Mobile_No + "','" + Reg.Refral + "'");

                                if (chkref.Rows[0][0].ToString() != "Already Used")
                                {
                                    DataTable countcd = SQL_DB.ExecuteDataTable("EXEC Proc_AddRefralpoint '" + Reg.Refral + "'");
                                    DataTable dtconum = SQL_DB.ExecuteDataTable("select* from M_Consumer where ReferralCode='" + Reg.Refral + "'");
                                    if (dtconum.Rows.Count > 0)
                                    {
                                        DataRow row = dtconum.Rows[0];
                                        string consumerID = row["M_Consumerid"].ToString(); // Adjust column name as per your table
                                        string consumerName = row["ConsumerName"].ToString();
                                        string consumerEmail = row["Email"].ToString();
                                        string upiId = row["UPIId"].ToString();
                                        string strEarnedPoints = "50";
                                        string receivedCode1 = "";
                                        string receivedCode2 = "";
                                        string strMobileNoRef = row["MobileNo"].ToString();


                                        // Call the MakeUPIpayment method with the extracted data
                                        MakeUPIpayment(Reg.Comp_ID, strMobileNoRef, consumerName, consumerEmail, upiId, strEarnedPoints, consumerID, receivedCode1, receivedCode2);
                                    }

                                }


                            }
                            #endregion
                            //Comment for check with one mobileno multiple time
                            /*
                            if (CompName == "Cosmo Tech Expo" || CompName == "Pack Plus")
                            {

                                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                                con.Open();
                                SqlCommand cmd = new SqlCommand("CheckCodeCountExibition", con);
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@Compname", CompName);
                                cmd.Parameters.AddWithValue("@mobileno", Reg.Mobile_No);
                                SqlDataAdapter da = new SqlDataAdapter(cmd);
                                DataTable countcd = new DataTable();
                                da.Fill(countcd);
                                con.Close();
                                if (countcd.Rows.Count > 0)
                                {
                                    result = "You have already avail the benefits.";
                                    return result;
                                }
                            }
                            */
                            //** Added for Instant payout and UPI
                            string Comp_ID = dtServiceAssign.Rows[0]["Comp_ID"].ToString();

                            if (CompName == "NV INFOTECH DOMAIN")
                            {
                                string dtto = DateTime.Now.ToString("yyyy-MM-dd" + " 23:59:59.999");
                                string dtfrom = DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd" + " 00:00:01.000");
                                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                                con.Open();
                                SqlCommand cmd = new SqlCommand("CheckCodeCount", con);
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@Compname", CompName);
                                cmd.Parameters.AddWithValue("@enq_date", dtto);
                                cmd.Parameters.AddWithValue("@start_date", dtfrom);
                                cmd.Parameters.AddWithValue("@mobileno", Reg.Mobile_No);
                                SqlDataAdapter da = new SqlDataAdapter(cmd);
                                DataTable countcd = new DataTable();
                                da.Fill(countcd);
                                con.Close();
                                if (countcd.Rows.Count > 2)
                                {
                                    result = "You have exceeded the limit of scanning and kindly scan after 7 days.";
                                    return result;
                                }
                            }

                            string json = JsonConvert.SerializeObject(Reg, Formatting.Indented);
                            //DataProvider.LogManager.ErrorExceptionLog(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "        " + json);
                            long intM_Consumer_MCOde = Business9420.function9420.InsertCodeChecked(Reg); // doing entry in Pro_Enq tabgle (PROC_InsertProductInquery)
                            //DataProvider.LogManager.ErrorExceptionLog(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "        " + json);
                            Business9420.function9420.UpdateUse_CountM_Code(Reg);// update [Use_Count] =0 in M_Code
                            ProjectSession.strMobileNo = Reg.Mobile_No;
                            ProjectSession.intM_Consumer_MCOde = intM_Consumer_MCOde;
                            Reg.intM_Consumer_MCOde = intM_Consumer_MCOde;

                            try
                            {
                                DataRow[] drw = dtServiceAssign.Select("Service_id = 'SRV1023'");
                                //////////////Comment by sandeep 040620///////////////
                                // string strWar = "Warranty for the " + CompName + " (" + Convert.ToString(drw[0]["PNm"]) + ") has " +
                                //"registered successfully for (" + Convert.ToString(drw[0]["WarrantyPeriod"]) + " months )";
                                // HttpContext.Current.Session["strWar"] = strWar;
                            }
                            catch (Exception ex)
                            {
                                ex.StackTrace.ToString();
                                //throw ex.Message.ToString();
                            }


                            //string strReferralCode = Convert.ToString(SQL_DB.ExecuteScalar("Select dbo.GetZeroConcactWithReferralCode(referralcode)  FROM [M_Consumer] where [MobileNo] = '" + strMobileNo + "'"));
                            //SendSms("Congs! Gained Referral code-" + strReferralCode + "", ProjectSession.strMobileNo);

                            #region Seperator "*" to concact string msg 
                            // if (i > 0) result = result + "<br/>";

                            if (Dial_Mode.ToLower() == "website" || Dial_Mode.ToLower() == "qr code" || Dial_Mode.ToLower() == "barcode")
                            {
                                strSeperator = "<br/><br/>";
                            }
                            else
                            {
                                strSeperator = "*";
                            }

                            #endregion
                            string strReturnMSG = string.Empty;
                            string addition = "Congrats!!  You Won";
                            string pro = "";
                            // Get Return message from Template Msg Table i.e 
                            DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
                            //bool Status = false;
                            for (int i = 0; i < dtServiceAssign.Rows.Count; i++)
                            {
                                if (i > 0)
                                    result = result + strSeperator;
                                #region
                                string stServiceid = dtServiceAssign.Rows[i]["Service_ID"].ToString();
                                DataRow[] dr = dtServiceAssign.Select("Service_id = '" + stServiceid + "'");

                                switch (stServiceid)
                                {
                                    case "SRV1023":// build loyalty
                                        {
                                            if (CompName.ToUpper() == "AUTO MAX INDIA")
                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1023' and MsgType = 10");
                                            else if (CompName == "Delta Luminaries")
                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1023' and MsgType = 11");
                                            else if (CompName == "TNT")
                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1023' and MsgType = 13");
                                            else if (CompName == "ORBIT ELECTRODOMESTICS INDIA" || CompName == "TECHNICAL MINDS PRIVATE LIMITED")
                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1023' and MsgType = 14");

                                            else
                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1023' and MsgType = 9");
                                            if (!string.IsNullOrEmpty(dtServiceAssign.Rows[i]["WarrantyPeriod"].ToString()))
                                            {
                                                //if (WarrantyPeriod)

                                                result = result + (strReturnMSG.Replace("<warrpariod>", dtServiceAssign.Rows[i]["WarrantyPeriod"].ToString() + " months").ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()));
                                            }
                                            else
                                            {
                                                result = result + (strReturnMSG.Replace("<warrpariod>", " 0 months")).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString());
                                            }

                                            string expDate = DateTime.Today.AddMonths(Convert.ToInt32(dtServiceAssign.Rows[i]["WarrantyPeriod"].ToString())).ToString().Substring(0, 10); //-- Tej
                                            result = result.Replace("<EXPIRY>", expDate);
                                            break;
                                        }
                                    case "SRV1001":// build loyalty
                                        {
                                            #region build loyalty
                                            DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
                                            if (dt.Rows.Count > 0)
                                            {
                                                string strM_consumerid = dt.Rows[0]["M_consumerid"].ToString();
                                                string strEarnedPoints = dt.Rows[0]["Points"].ToString();
                                                string dstrEarnedPoints = "";
                                                string IsCashConvert = dt.Rows[0]["IsCashConvert"].ToString();
                                                string AwardNameBL = dt.Rows[0]["AwardNameBL"].ToString();

                                                // Add sms Tej----------- BL
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {

                                                    //Congratulations! You have won<point> points with the coupon code<CODE1>< CODE2 >.www.vcqru.com
                                                    //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 72");
                                                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 413");
                                                    if (strReturnMSG.Contains("<CODE1>"))
                                                    {
                                                        strReturnMSG = strReturnMSG.Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                    }
                                                    if (strReturnMSG.Contains("<point>"))
                                                    {
                                                        strReturnMSG = strReturnMSG.Replace("<point>", strEarnedPoints);
                                                    }

                                                    #region// TemplateId for Success
                                                    SendSmsfromknowlarity(strReturnMSG, Reg.Mobile_No, "1007283387751173484");
                                                    #endregion
                                                }
                                                // Add close sms Tej----------- BL

                                                if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
                                                {


                                                    if (IsCashConvert == "0") // Covert points to cash will do end user
                                                    {
                                                        //result = result + " You have earned " + strEarnedPoints + " points. Redeem points and earn cash - <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";
                                                        // result = result + "Congs! earned <points> points.Redeem-<absoluteSiteBrowseUrl>/Info/Consumerregister.aspx#trylogin.";
                                                        if (CompName == "Competent Electricals India")
                                                        {
                                                            if (Reg.Dial_Mode == "SMS")
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 10");
                                                            else
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 8");
                                                        }
                                                        else if (CompName == "COATS BATH FITTINGS")
                                                        {

                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 11");
                                                        }
                                                        else if (CompName == "BAGHLA SANITARYWARE")
                                                        {
                                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 42");
                                                            }
                                                            else
                                                                strReturnMSG = "Congratulations!! You have purchased an authentic product from prestige bath fittings and on purchase of the product, you have won <points> points.</br>बधाई हो!! आपने prestige bath fittings से एक प्रामाणिक उत्पाद खरीदा है और उत्पाद की खरीद पर, आपने <points> अंक जीते हैं। </br></br>To Check Another Code <a href='https://www.vcqru.com/Bhagla.aspx'>Click Here</a>";
                                                        }

                                                        else if (CompName == "Girish Chemical Industries")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 110");
                                                        }

                                                        else if (CompName == "Inox Decor Pvt Ltd")
                                                        {
                                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 42");
                                                            }
                                                            else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 91");
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 42");
                                                            }


                                                        }
                                                        else if (CompName == "Yava Paints Pvt. Ltd.")
                                                        {

                                                            strReturnMSG = "Congratulations you have won <points> Point and to claim, contact on 8059444734 </br> बधाई हो आपने <points> प्वाइंट जीत लिया है और दावा करने के लिए 8059444734 पर सपंर्क करें.</br> <a href='https://www.vcqru.com/login.aspx'>Login Here</a>";
                                                        }
                                                        else if (CompName == "SAFFRO MELLOW COATINGS AND RESINS")
                                                        {
                                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 122");
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 122");
                                                            }
                                                        }
                                                        else if (CompName == "BENITTON BATHWARE")
                                                        {
                                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 124");
                                                                result = (strReturnMSG.Replace("<points>", strEarnedPoints));
                                                                return result;
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 124");
                                                                result = (strReturnMSG.Replace("<points>", strEarnedPoints));
                                                                return result;
                                                            }
                                                        }

                                                        else if (CompName == "Ambica Cable")
                                                        {
                                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 42");
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 101");
                                                            }
                                                        }


                                                        else if (CompName == "Cosmo Tech Expo" || CompName == "Pack Plus")
                                                        {


                                                            if (dsres.Tables[0].Rows[0]["Pro_Name"].ToString() == "Sorry, Better luck next time")
                                                            {
                                                                //pro = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();
                                                                //string mail = SendMailExibition(Reg.consumer_name, Reg.Email, pro);
                                                                strReturnMSG = "Sorry Better luck next time";
                                                            }
                                                            else
                                                            {
                                                                pro = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

                                                                //strReturnMSG = "Congratulations!! You won " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " <a href='https://www.linkedin.com/company/vcqru-wesecureyou'>Click here</a> and follow our LinkedIn page and collect your gift from the counter. ";
                                                                strReturnMSG = "Dear " + Reg.consumer_name + ", Congratulations! you have won <br> <b style='font-size:18px;'><center>" + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ".</center><b/>";
                                                                string strReturnMSG1 = "Dear " + Reg.consumer_name + " ! Thanks for trying VCQRU Build Loyalty/Gift scheme program. Congratulations You have won <b>" + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + "<b/> with the Coupon Code " + Reg.Received_Code1 + Reg.Received_Code2 + ". Please collect your gift from VCQRU counter and share your experience and feedback.";

                                                                Thread email = new Thread(delegate ()
                                                                                                   {
                                                                                                       string mail = SendMailExibition(Reg.consumer_name, Reg.Email, strReturnMSG1);
                                                                                                   });
                                                                email.IsBackground = true;
                                                                email.Start();
                                                            }


                                                        }


                                                        else if (CompName == "Lubigen Pvt Ltd")
                                                        {
                                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 73");
                                                            }
                                                            else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 71");
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 69");
                                                            }

                                                        }

                                                        else if (CompName == "OCI Wires and Cables")
                                                        {
                                                            if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 72");
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 60");
                                                            }

                                                        }


                                                        else if (CompName == "Veena Polymers")
                                                        {

                                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 73");
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 43");
                                                            }


                                                        }
                                                        else if (CompName == "VR KABLE INDIA PRIVATE LIMITED")
                                                        {

                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 54");
                                                        }

                                                        else if (CompName == "R.S Industries")
                                                        {

                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 28");
                                                        }

                                                        else if (CompName == "Jupiter Aqua Lines Ltd")
                                                        {

                                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 73");
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 29");
                                                            }


                                                        }

                                                        else if (CompName == "GRIH PRAWESH MARKETING COMPANY")
                                                        {

                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 20");

                                                        }



                                                        else if (CompName == "SKYDECOR LAMINATES PRIVATE LIMITED")
                                                        {

                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 13");
                                                        }
                                                        else if (CompName == "JOHNSON PAINTS CO.")
                                                        {
                                                            dstrEarnedPoints = (((Convert.ToInt32(strEarnedPoints) * 10) / 100) + Convert.ToInt32(strEarnedPoints)).ToString();
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 15");
                                                        }
                                                        else if (CompName == "EVERCROP AGRO SCIENCE")
                                                        {
                                                            if (Dial_Mode == "SMS")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 17");
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 19");

                                                                result = result + "<br/> <br/>जीती गई राशि की पुष्टि करने और अधिक रोमांचक पुरस्कार प्राप्त करने के लिए व्हाट्सएप पर उत्पाद पर मौजूद लेबल की फोटो क्लिक कर के भेजें।  <br><a class='btn btn-primary btn-sm' href='https://api.whatsapp.com/send?phone=+917428919991&amp;text=EVERCROP AGRO SCIENCE' title='Show Chat' target='_blank'>click here</a></p> <p>" +

                                                                                                      "इनाम की सूचना आपको SMS/व्हाट्सएप/फेसबुक/कॉल/फोन द्वारा की जाएगी<br>" +

                                                                                                         "शर्तें -<br></p>" +

                                                                                                         "<ol type='1' style='font-size:smaller;'><li>अगर आप इनाम जीते हैं तो निम्न चीजों की आवश्यकता होगी।</li><li>खरीदे गए एवरक्रॉप बीज का खाली पैकेट कूपन के साथ।</li><li> मोबाइल नंबर जिस से आप ने SMS किया है।</li><li>हमारे व्हाट्सएप पर एवरक्रॉप बीज के पैकेट के साथ आपकी फोटो।</li><li> खरीदार का आधार कार्ड। </li><li> इनाम कंपनी द्वारा निर्धारित सेंटर से लेना होगा। </li> </ol>";

                                                            }
                                                        }

                                                        else if (CompName == "DD NUTRITIONS PRIVATE LIMITED")
                                                        {

                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 35");
                                                            // strReturnMSG = "Congratulations!! You have purchased an Authentic product from DD NUTRITIONS PRIVATE LIMITED.";
                                                        }

                                                        else if (CompName == "Wudchem Industries Private Limited")
                                                        {
                                                            //** Changes done by Bipin ji at 29_08_22_13_57

                                                            DataTable dtpoint = new DataTable();
                                                            DataSet dsTrans = ExecuteNonQueryAndDatatable.FillTransactions("GetConsumerRemainingPoints", Convert.ToInt32(strM_consumerid), "");

                                                            dtpoint = dsTrans.Tables[0];
                                                            if (dtpoint.Rows.Count > 0)
                                                            {
                                                                int totalpoint = Convert.ToInt32(dtpoint.Rows[0][0]);

                                                                //if (totalpoint != "1" || totalpoint != "2" || totalpoint != "3" || totalpoint != "4")
                                                                if (totalpoint >= 5)
                                                                {
                                                                    //dstrEarnedPoints = (((Convert.ToInt32(strEarnedPoints) * 10) / 100) + Convert.ToInt32(strEarnedPoints)).ToString();
                                                                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 34");
                                                                }
                                                                else
                                                                {
                                                                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 33");
                                                                }
                                                            }

                                                            //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 33");
                                                            //** Changes done by Bipin ji at 29_08_22_13_57
                                                            /*if (strEarnedPoints == "5")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 34");
                                                                // result = result + "<a href="LoginSignUp.ascx">click to collect the rewards<a> "+;
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 33");
                                                            }
															*/

                                                        }


                                                        //  else if (CompName.ToUpper() == "LIPKA" || CompName.ToUpper() == "RUHE")
                                                        //  {
                                                        //  //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 21");
                                                        //  strReturnMSG = "Congratulations! You have purchased a genuine product of " + CompName + " and our team will call you soon.";
                                                        //  }

                                                        else if (CompName.ToUpper() == "LIPKA")
                                                        {
                                                            //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 21");
                                                            strReturnMSG = "Congratulations! You have purchased a genuine product of " + CompName + " and our team will call you soon.";


                                                        }
                                                        else if (CompName.ToUpper() == "RUHE")
                                                        {
                                                            DataTable Ruhepts = new DataTable();
                                                            DataSet Ruhdt = ExecuteNonQueryAndDatatable.FillTransactions("GetConsumerWalletBalance", Convert.ToInt32(strM_consumerid), "");

                                                            Ruhepts = Ruhdt.Tables[0];
                                                            decimal RTotalpoints = 0;
                                                            if (Ruhepts.Rows.Count > 0)
                                                                RTotalpoints = Convert.ToDecimal(Ruhepts.Rows[0]["TotalPoints"].ToString());



                                                            string RuhestrReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 41 and MsgFor='RUHE'");
                                                            result = result + (RuhestrReturnMSG.Replace("<points>", strEarnedPoints).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<Bal>", RTotalpoints.ToString()));


                                                        }




                                                        else
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1001' and MsgType = 4");

                                                        result = result + (strReturnMSG.Replace("<points>", strEarnedPoints).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString());
                                                    }
                                                    else
                                                    {
                                                        // if (!string.IsNullOrEmpty(AwardNameBL))
                                                        // {
                                                        // result = result + "You have won a <b>gift</b> againts earned points. Redeem points and earn gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";
                                                        if (CompName == "Competent Electricals India")
                                                        {
                                                            if (Reg.Dial_Mode == "SMS")
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 10");
                                                            else
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 8");
                                                        }
                                                        else if (CompName == "Indian Plywood Company")
                                                        {

                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 142");
                                                            result = (strReturnMSG.Replace("<points>", strEarnedPoints));
                                                            return result;
                                                        }
                                                        else if (CompName == "COATS BATH FITTINGS")
                                                        {

                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 11");
                                                        }
                                                        else if (CompName == "BAGHLA SANITARYWARE")
                                                        {
                                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 42");
                                                            }
                                                            else
                                                                strReturnMSG = "Congratulations!! You have purchased an authentic product from prestige bath fittings and on purchase of the product, you have won <points> points.</br>बधाई हो!! आपने prestige bath fittings से एक प्रामाणिक उत्पाद खरीदा है और उत्पाद की खरीद पर, आपने <points> अंक जीते हैं। </br></br>To Check Another Code <a href='https://www.vcqru.com/Bhagla.aspx'>Click Here</a>";
                                                        }

                                                        else if (CompName == "Girish Chemical Industries")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 110");
                                                        }

                                                        else if (CompName == "Inox Decor Pvt Ltd")
                                                        {

                                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 42");
                                                            }
                                                            else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 91");
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 42");
                                                            }

                                                        }
                                                        else if (CompName == "Yava Paints Pvt. Ltd.")
                                                        {

                                                            strReturnMSG = "Congratulations you have won <points> Point and to claim, contact on 8059444734 </br> बधाई हो आपने <points> प्वाइंट जीत लिया है और दावा करने के लिए 8059444734 पर सपंर्क करें.</br><a href=' https://www.vcqru.com/login.aspx'>Login Here</a>";
                                                        }
                                                        else if (CompName == "SAFFRO MELLOW COATINGS AND RESINS")
                                                        {

                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 122");
                                                        }
                                                        else if (CompName == "BENITTON BATHWARE")
                                                        {

                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 124");
                                                            result = (strReturnMSG.Replace("<points>", strEarnedPoints));
                                                            return result;
                                                        }

                                                        else if (CompName == "Ambica Cable")
                                                        {
                                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 42");
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 101");
                                                            }
                                                        }


                                                        else if (CompName == "Cosmo Tech Expo" || CompName == "Pack Plus")
                                                        {


                                                            if (dsres.Tables[0].Rows[0]["Pro_Name"].ToString() == "Sorry, Better luck next time")
                                                            {
                                                                //pro = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();
                                                                //string mail = SendMailExibition(Reg.consumer_name, Reg.Email, pro);
                                                                strReturnMSG = "Sorry Better luck next time";
                                                            }
                                                            else
                                                            {
                                                                pro = addition + dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

                                                                //strReturnMSG = "Congratulations!! You won " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " <a href='https://www.linkedin.com/company/vcqru-wesecureyou'>Click here</a> and follow our LinkedIn page and collect your gift from the counter. ";
                                                                strReturnMSG = "Dear " + Reg.consumer_name + ", Congratulations! you have won <br> <b style='font-size:18px;'><center>" + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ".</center><b/>";
                                                                string strReturnMSG1 = "Dear " + Reg.consumer_name + " ! Thanks for trying VCQRU Build Loyalty/Gift scheme program. Congratulations You have won <b>" + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + "<b/> with the Coupon Code " + Reg.Received_Code1 + Reg.Received_Code2 + ". Please collect your gift from VCQRU counter and share your experience and feedback.";

                                                                Thread email = new Thread(delegate ()
                                                                                               {
                                                                                                   string mail = SendMailExibition(Reg.consumer_name, Reg.Email, strReturnMSG1);
                                                                                               });
                                                                email.IsBackground = true;
                                                                email.Start();


                                                            }


                                                        }


                                                        else if (CompName == "Lubigen Pvt Ltd")
                                                        {
                                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 73");
                                                            }
                                                            else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 71");
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 69");
                                                            }

                                                        }



                                                        else if (CompName == "OCI Wires and Cables")
                                                        {
                                                            if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 72");
                                                            }
                                                            else if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 73");
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 60");
                                                            }

                                                        }


                                                        else if (CompName == "Veena Polymers")
                                                        {
                                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 73");
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 43");
                                                            }



                                                        }

                                                        else if (CompName == "R.S Industries")
                                                        {

                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 28");
                                                        }
                                                        else if (CompName == "VR KABLE INDIA PRIVATE LIMITED")
                                                        {

                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 54");
                                                        }

                                                        else if (CompName == "Jupiter Aqua Lines Ltd")
                                                        {

                                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 73");
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 29");
                                                            }



                                                        }


                                                        else if (CompName == "SKYDECOR LAMINATES PRIVATE LIMITED")
                                                        {

                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 13");
                                                        }
                                                        else if (CompName == "GRIH PRAWESH MARKETING COMPANY")
                                                        {

                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 20");

                                                        }
                                                        else if (CompName == "JOHNSON PAINTS CO.")
                                                        {
                                                            dstrEarnedPoints = (((Convert.ToInt32(strEarnedPoints) * 10) / 100) + Convert.ToInt32(strEarnedPoints)).ToString();
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 15");
                                                        }
                                                        else if (CompName == "EVERCROP AGRO SCIENCE")
                                                        {
                                                            if (Dial_Mode == "SMS")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 17");
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 19");
                                                                result = result + "<br/> <br/>जीती गई राशि की पुष्टि करने और अधिक रोमांचक पुरस्कार प्राप्त करने के लिए व्हाट्सएप पर उत्पाद पर मौजूद लेबल की फोटो क्लिक कर के भेजें।  <br><a class='btn btn-primary btn-sm' href='https://api.whatsapp.com/send?phone=+917428919991&amp;text=EVERCROP AGRO SCIENCE' title='Show Chat' target='_blank'>click here</a></p> <p>" +

                                                                                                      "इनाम की सूचना आपको SMS/व्हाट्सएप/फेसबुक/कॉल/फोन द्वारा की जाएगी<br>" +

                                                                                                         "शर्तें -<br></p>" +

                                                                                                         "<ol type='1' style='font-size:smaller;'><li>अगर आप इनाम जीते हैं तो निम्न चीजों की आवश्यकता होगी।</li><li>खरीदे गए एवरक्रॉप बीज का खाली पैकेट कूपन के साथ।</li><li> मोबाइल नंबर जिस से आप ने SMS किया है।</li><li>हमारे व्हाट्सएप पर एवरक्रॉप बीज के पैकेट के साथ आपकी फोटो।</li><li> खरीदार का आधार कार्ड। </li><li> इनाम कंपनी द्वारा निर्धारित सेंटर से लेना होगा। </li> </ol>";

                                                            }
                                                        }

                                                        else if (CompName == "Wudchem Industries Private Limited")
                                                        {
                                                            //** Changes done by Bipin Ji _29_08_22_13:58
                                                            DataTable dtpoint = new DataTable();
                                                            DataSet dsTrans = ExecuteNonQueryAndDatatable.FillTransactions("GetConsumerRemainingPoints", Convert.ToInt32(strM_consumerid), "");

                                                            dtpoint = dsTrans.Tables[0];
                                                            if (dtpoint.Rows.Count > 0)
                                                            {
                                                                int totalpoint = Convert.ToInt32(dtpoint.Rows[0][0]);

                                                                //if (totalpoint != "1" || totalpoint != "2" || totalpoint != "3" || totalpoint != "4")
                                                                if (totalpoint >= 5)
                                                                {
                                                                    //dstrEarnedPoints = (((Convert.ToInt32(strEarnedPoints) * 10) / 100) + Convert.ToInt32(strEarnedPoints)).ToString();
                                                                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 34");
                                                                }
                                                                else
                                                                {
                                                                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 33");
                                                                }
                                                            }
                                                            //  strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 33");
                                                            //** Changes done by Bipin Ji _29_08_22_13:58

                                                            /*if (strEarnedPoints == "5")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 34");
                                                                // result = result + "<a href="LoginSignUp.ascx">click to collect the rewards<a> "+;
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 33");
                                                            }*/
                                                        }
                                                        else if (CompName == "DD NUTRITIONS PRIVATE LIMITED")
                                                        {

                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 35");
                                                            //strReturnMSG = "Congratulations!! You have purchased an Authentic product from DD NUTRITIONS PRIVATE LIMITED.";
                                                        }



                                                        // else if (CompName.ToUpper() == "LIPKA" || CompName.ToUpper() == "RUHE")
                                                        // {
                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 21");
                                                        //  strReturnMSG = "Congratulations! You have purchased a genuine product of " + CompName + " and our team will call you soon.";
                                                        // }

                                                        else if (CompName.ToUpper() == "LIPKA")
                                                        {
                                                            //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 21");
                                                            strReturnMSG = "Congratulations! You have purchased a genuine product of " + CompName + " and our team will call you soon.";


                                                        }
                                                        else if (CompName.ToUpper() == "RUHE")
                                                        {
                                                            DataTable Ruhepts = new DataTable();
                                                            DataSet Ruhdt = ExecuteNonQueryAndDatatable.FillTransactions("GetConsumerWalletBalance", Convert.ToInt32(strM_consumerid), "");

                                                            Ruhepts = Ruhdt.Tables[0];
                                                            decimal RTotalpoints = 0;
                                                            if (Ruhepts.Rows.Count > 0)
                                                                RTotalpoints = Convert.ToDecimal(Ruhepts.Rows[0]["TotalPoints"].ToString());



                                                            string RuhestrReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 41 and MsgFor='RUHE'");
                                                            result = result + (RuhestrReturnMSG.Replace("<points>", strEarnedPoints).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<Bal>", RTotalpoints.ToString()));


                                                        }




                                                        else
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1001' and MsgType = 5");
                                                        result = result + (strReturnMSG.Replace("<dpoints>", dstrEarnedPoints).Replace("<points>", strEarnedPoints).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", CompName.ToUpper());
                                                        //}
                                                        //else
                                                        //{
                                                        //    result = result + "Congs! You have earned points againts the purchased product. ";
                                                        //}
                                                    }
                                                    // result = result + "Congs! You have earned points againts the purchased product. ";
                                                }
                                                else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
                                                {
                                                    // result = result + "Congs! You can earn <b>points</b> againts the purchased product.Just left with  <b> " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " </b> more purchase ";
                                                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1001' and MsgType = 6");
                                                    result = result + (strReturnMSG.Replace("<points>", strEarnedPoints).Replace("<frequency>", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();
                                                }
                                            }
                                            #endregion
                                            break;
                                        }
                                    case "SRV1002"://Run Surveys
                                        {
                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1002' and MsgType = 4");
                                            result = result + (strReturnMSG.Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)
                                                                           .Replace("<strMobileNo>", ProjectSession.strMobileNo)
                                                                            .Replace("<intM_Consumer_MCOde>", ProjectSession.intM_Consumer_MCOde.ToString())).ToUpper();
                                            // result = result + ShowMessageForRunSurvey();
                                            break;
                                        }
                                    case "SRV1018"://COUNTERFIETING
                                        {
                                            DataView dv = MsgTempdt.DefaultView;

                                            // Add sms Tej----------- AC 
                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                            {
                                                dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 416";

                                                //The product you have purchased is an authentic product of <CMPNAME> with security code <CODE1><CODE2>. visit www.vcqru.com for more info

                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 416");
                                                if (strReturnMSG.Contains("<CODE1>"))
                                                {
                                                    strReturnMSG = strReturnMSG.Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                }
                                                if (strReturnMSG.Contains("<CMPNAME>"))
                                                {
                                                    strReturnMSG = strReturnMSG.Replace("<CMPNAME>", CompName);
                                                }
                                                SendSmsfromknowlarity(strReturnMSG, Reg.Mobile_No, "1007083658168413428");
                                            }
                                            // Add clos sms Tej----------- AC 

                                            if (CompName.ToUpper() == "MFN")
                                            {
                                                dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 4";
                                            }
                                            else if (CompName == "Helix")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    //dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                    dv.RowFilter = "Congratulations!! You have purchased an Authentic product from Helix Brand, to check another code <a href='../Helix.aspx'>Click Here</a>.";
                                                }
                                                else
                                                {
                                                    // result = "<b>**100% GENUINE - VERIFIED**</b></br>Thank you for purchasing and verifying your MUSCLE PUNCH " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", your product is made with the BEST QUALITY ingredients and is 100% GENUINE.";
                                                    result = "Congratulations!! You have purchased an Authentic product from Helix Brand, to check another code <a href='../Helix.aspx'>Click Here</a>.";
                                                    return result;
                                                }
                                            }
                                            else if (CompName == "Muscle Garage")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    //dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                    dv.RowFilter = "Congratulations!! You have purchased an Authentic product from Muscle Garage, to check another code <a href='../musclegarage.aspx'>Click Here</a>.";
                                                }
                                                else
                                                {
                                                    // result = "<b>**100% GENUINE - VERIFIED**</b></br>Thank you for purchasing and verifying your MUSCLE PUNCH " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", your product is made with the BEST QUALITY ingredients and is 100% GENUINE.";
                                                    result = "Congratulations!! You have purchased an Authentic product from Muscle Garage, to check another code <a href='../musclegarage.aspx'>Click Here</a>.";
                                                    return result;
                                                }
                                            }
                                            else if (CompName == "Fit Fleet")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    //dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                    dv.RowFilter = "<b>Congratulations!! You have purchased an Authentic product from Fit Fleet.</b>";
                                                }
                                                else
                                                {
                                                    // result = "<b>**100% GENUINE - VERIFIED**</b></br>Thank you for purchasing and verifying your MUSCLE PUNCH " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", your product is made with the BEST QUALITY ingredients and is 100% GENUINE.";
                                                    result = "<b>Congratulations!! You have purchased an Authentic product from Fit Fleet.</b>";
                                                    return result;
                                                }
                                            }
                                            else if (CompName == "PROQUEST NUTRITION PRIVATE LIMITED")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    //dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                    dv.RowFilter = "Congratulations!! You have purchased an Authentic product  " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " from Proquest Nutrition Pvt Ltd, to check another code <a href='https://www.proquest.fit/check-authenticity' style='color: white;'>Click Here</a>.";
                                                }
                                                else
                                                {
                                                    // result = "<b>**100% GENUINE - VERIFIED**</b></br>Thank you for purchasing and verifying your MUSCLE PUNCH " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", your product is made with the BEST QUALITY ingredients and is 100% GENUINE.";
                                                    result = "Congratulations!! You have purchased an Authentic product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " from Proquest Nutrition Pvt Ltd, to check another code <a href='https://www.proquest.fit/check-authenticity' style='color: white;'>Click Here</a>.";
                                                    return result;
                                                }
                                            }
                                            else if (CompName == "FITSIQUE")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    //dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                    dv.RowFilter = "Congratulations!! You have purchased an Authentic product from Fatisque, to check another code <a href='https://fitsique.in/authenticate/' style='color: white;'>Click Here</a>.";
                                                }
                                                else
                                                {
                                                    // result = "<b>**100% GENUINE - VERIFIED**</b></br>Thank you for purchasing and verifying your MUSCLE PUNCH " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", your product is made with the BEST QUALITY ingredients and is 100% GENUINE.";
                                                    result = "Congratulations!! You have purchased an Authentic product from Fatisque, <br>to check another code <a href='https://fitsique.in/authenticate/' style='color: white;'>Click Here</a>.";
                                                    return result;
                                                }
                                            }
                                            else if (CompName == "TRUE NUTRITION PERFORMANCE PRIVATE LIMITED")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    //dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                    dv.RowFilter = "Congratulations!! You have purchased an Authentic product from True Nutrition Performance, to check another code <a href='https://www.vcqru.com/TrueNutrition.aspx' style='color: white;'>Click Here</a>.";
                                                }
                                                else
                                                {
                                                    // result = "<b>**100% GENUINE - VERIFIED**</b></br>Thank you for purchasing and verifying your MUSCLE PUNCH " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", your product is made with the BEST QUALITY ingredients and is 100% GENUINE.";
                                                    result = "Congratulations!! You have purchased an Authentic product from True Nutrition Performance, <br>to check another code <a href='https://www.vcqru.com/TrueNutrition.aspx' style='color: white;'>Click Here</a>.";
                                                    return result;
                                                }
                                            }
                                            else if (CompName.ToUpper() == "JPH PUBLICATIONS PVT. LTD")
                                            {
                                                dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 12";
                                            }
                                            else if (CompName.ToUpper() == "MAHINDRA AND MAHINDRA LTD")
                                            {
                                                dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 5";
                                            }
                                            else if (CompName.ToUpper() == "UNIGLOBAL DISTRIBUTORS PRIVATE LIMITED")
                                            {
                                                dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 6";
                                            }

                                            else if (CompName == "AMULYA AYURVEDA" || CompName == "Nutravel Health Care" || CompName == "Black Mango Herbs")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                }
                                                else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 68";
                                                }
                                                else
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 24";
                                                }

                                            }

                                            else if (CompName == "Secure Lifesciences")
                                            {
                                                dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 25";
                                            }

                                            else if (CompName == "SHRI BALAJI OVERSEAS MUSCLE TECH")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 76";
                                                else
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 27";
                                            }

                                            else if (CompName.ToUpper() == "OSR IMPEX")
                                            {
                                                if (dsres.Tables[0].Rows[0]["Pro_Name"].ToString() == "SSNC Nutrition")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 15";
                                                }
                                                else
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 14";
                                                }
                                            }
                                            else if (CompName.ToUpper() == "MYSHA HEALTH WORLD")
                                            {
                                                if (Reg.Dial_Mode != "SMS")
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 7";
                                                else
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 10";
                                            }

                                            else if (CompName == "Competent Electricals India")
                                            {
                                                dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 9";
                                            }
                                            else if (CompName.ToUpper() == "Generic Pharma")
                                            {
                                                dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 11";
                                            }
                                            else if (CompName == "Nutramarc Sports")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                }
                                                else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 68";
                                                }
                                                else
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 50";
                                                }

                                            }

                                            else if (CompName == "Denzour Nutritions")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                }
                                                else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 68";
                                                }
                                                else
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 50";
                                                }

                                            }

                                            else if (CompName == "SPORTECH SOLUTIONS")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                }

                                                else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 87";
                                                }
                                                else
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 86";
                                                }
                                            }
                                            else if (CompName == "RELX INDIA PRIVATE LIMITED")
                                            {
                                                if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 417";
                                                }
                                                else
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 418";
                                                }
                                            }
                                            else if (CompName == "MANGAL DASS TRADING CO")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                }

                                                else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 85";
                                                }
                                                else
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 84";
                                                }
                                            }

                                            else if (CompName == "EVERCROP AGRO SCIENCE")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                }

                                                else
                                                {
                                                    result = "बधाई हो!! आपने " + "एवरक्रॉप" + " से एक प्रामाणिक उत्पाद खरीदा है।";
                                                }

                                            }
                                            else if (CompName == "Gupta edutech Delhi")
                                            {
                                                dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 109";
                                            }
                                            else if (CompName == "Cosmo Tech Expo")
                                            {
                                                result = "<b> Congratulations!! You have purchased an authentic product from VCQRU PVT LTD.";
                                            }

                                            else if (CompName == "SWARAJ")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                }
                                                else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 68";
                                                }
                                                else
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 55";
                                                }

                                            }
                                            else if (CompName == "YAMUNA INTERIORS PRIVATE LIMITED" || CompName == "Yamuna Interiors Pvt Ltd G")
                                            {
                                                result = "<div><img src='../assets/fonts/icon-original.svg' class='original'></div><strong><p>The product you have purchased is an authentic product of Black cobra.</p></strong>";
                                                return result;
                                            }
                                            else if (CompName == "Ram Gopal and Sons")
                                            {
                                                dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 115";
                                            }

                                            else if (CompName == "Wellversed Health Pvt Ltd")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                }

                                                else
                                                {
                                                    result = "Congratulations, the product you inquired is Wellversed Health Pvt Ltd official genuine product.";
                                                }

                                            }

                                            else if (CompName == "PATANJALI  FOODS  LIMITED")
                                            {
                                                DataTable DTMSN = SQL_DB.ExecuteDataTable("EXEC USP_Getexpdatepfl '" + Reg.Received_Code1 + "','" + Reg.Received_Code2 + "'");
                                                if (DTMSN.Rows.Count > 0)
                                                {
                                                    string manufacturedDate = DateTime.Parse(DTMSN.Rows[0]["Manufactured_date"].ToString()).ToString("dd/MM/yyyy");
                                                    string expiryDate = DateTime.Parse(DTMSN.Rows[0]["Expiry_date"].ToString()).ToString("dd/MM/yyyy");
                                                    result = "Congratulations! You've bought a genuine <product name> from Patanjali.</br> manufacturing date: " + manufacturedDate + " </br> expiration date: " + expiryDate + " ";
                                                }
                                                else
                                                {
                                                    result = "Congratulations! You've bought a genuine <product name> from Patanjali.";
                                                }
                                                if (!IsSameLocation)
                                                    result = result + "| This code has been verified from different location.";
                                                result = result.Replace("<product name>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString());
                                                result = result.Replace("<br/><br/>", "");
                                            }

                                            else if (CompName == "1 STOP NUTRITION")
                                            {
                                                dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 107";
                                            }

                                            else if (CompName == "RSR Resource")
                                            {
                                                result = "Congratulations!! You had purchased an Authentic product from RSR Resource.";

                                            }
                                            else if (CompName == "FOREVER NUTRITION")
                                            {
                                                dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 103";

                                            }
                                            else if (CompName == "MUSCLE PUNCH SUPPLEMENTS")
                                            {

                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                }
                                                else
                                                {
                                                    result = "<b>**100% GENUINE - VERIFIED**</b></br>Thank you for purchasing and verifying your MUSCLE PUNCH " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", your product is made with the BEST QUALITY ingredients and is 100% GENUINE.";
                                                }
                                            }
                                            else if (CompName == "RANDHAWA SWEETS")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    //dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                    dv.RowFilter = "Congratulations you have purchased an Authentic product from Randhawa Sweets";
                                                }
                                                else
                                                {
                                                    // result = "<b>**100% GENUINE - VERIFIED**</b></br>Thank you for purchasing and verifying your MUSCLE PUNCH " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", your product is made with the BEST QUALITY ingredients and is 100% GENUINE.";
                                                    result = "Congratulations you have purchased an Authentic product from Randhawa Sweets.<br> To Check Another Code <a href='https://www.randhawasweets.com/authenticity/'>Click Here</a>";
                                                    return result;
                                                }
                                            }
                                            else if (CompName == "Big Daddy Overseas")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                }
                                                else
                                                {
                                                    result = "Congratulations!!! You have purchased an authentic product from Big Daddy Overseas.<br> To Check Another Code <a href='https://vcqru.com/bigdaddy.html'>Click Here</a>";
                                                }
                                            }
                                            else if (CompName == "Muscle Fighter Nutrition")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    //dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                    dv.RowFilter = "Congratulations!! You have purchased an Authentic product from Muscle fighter India.";
                                                }
                                                else
                                                {
                                                    // result = "<b>**100% GENUINE - VERIFIED**</b></br>Thank you for purchasing and verifying your MUSCLE PUNCH " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", your product is made with the BEST QUALITY ingredients and is 100% GENUINE.";
                                                    result = "Congratulations!! You have purchased an Authentic product from Muscle fighter India.<br> To Check Another Code <a href='https://musclefighternutrition.com/authenticity'>Click Here</a>";
                                                }
                                            }
                                            else if (CompName == "Paras cosmetics private limited")
                                            {
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {
                                                    dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 57";
                                                }
                                                else
                                                {
                                                    result = "Congratulations you have purchased an authentic product from Aroma Care.<br> To Check Another Code <a href='https://vcqru.com/aromacare.aspx' style='color:blue;'>Click Here</a>";
                                                }
                                            }
                                            else
                                            {
                                                dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 1";
                                            }
                                            DataTable fdt = dv.ToTable();

                                            #region Loyalty
                                            //*************** Brand Loyalty Code start ******************//
                                            string LoyaltyMessage = "";
                                            LoyaltyMessage = GetMyMessage(strMobileNo, Reg.Received_Code1, Reg.Received_Code2, Reg.Mode_Detail);
                                            //*************** Brand Loyalty Code end ******************//
                                            if (Reg.Comp_type == "L")
                                            {
                                                // m_Amc_offer is for renewal
                                                DataSet ds1 = SQL_DB.ExecuteDataSet("select * from M_Amc_Offer  WHERE Pro_Id = '" + dsres.Tables[0].Rows[0]["Pro_ID"].ToString() + "' AND Trans_Type = 'Offer' AND  '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' BETWEEN convert(nvarchar,Date_From,111) AND convert(nvarchar,Date_To,111)");
                                                if (ds1.Tables[0].Rows.Count > 0)
                                                    DefaultComments = ds1.Tables[0].Rows[0]["Comments"].ToString();
                                                else
                                                    DefaultComments = "";
                                            }
                                            else
                                                DefaultComments = dsres.Tables[0].Rows[0]["Comments"].ToString();
                                            DefaultComments += " " + LoyaltyMessage;
                                            if (dsres.Tables[0].Rows[0]["Exp_Date"].ToString() == "01/01/1900")
                                            {
                                                //  result = result + "Code1-" + Reg.Received_Code1 + " & Code2-" + Reg.Received_Code2 + ", Prod-" + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", SN-" + dsres.Tables[0].Rows[0]["series"].ToString() + "" +
                                                //                      ", MRP-" + dsres.Tables[0].Rows[0]["MRP"].ToString() + ", MFG" + dsres.Tables[0].Rows[0]["Mfd_Date"].ToString() + ", EXP, BtNo-" + dsres.Tables[0].Rows[0]["Batch_No"].ToString() + ", PROD IS GENUINE.";// & mfd by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + " " + DefaultComments + " Tnx label9420";

                                                if (CompName.ToLower() == "1 stop nutrition")
                                                {
                                                    //result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "    Tnx SKS Nutritions";
                                                    result += "You have purchased a Genuine " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " product by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + " with coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " Inc. VCQRU";
                                                }

                                                else if (CompName == "Guru Kripa Enterprises")
                                                {
                                                    //result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "    Tnx SKS Nutritions";
                                                    result += "You have purchased a Genuine " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " product by Pro Nutrition with coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " Inc. VCQRU";
                                                }


                                                else if (CompName == "PARAG MILK FOODS")
                                                {
                                                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                    {
                                                        result += "You have purchased a Genuine " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " product by PARAG MILK FOODS with coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " Inc. VCQRU";
                                                    }
                                                    else
                                                    {
                                                        result += "Congratulations!! You have purchased an Authentic product from Avvatar India.";
                                                    }


                                                }

                                                else if (CompName == "Ankerite Health Care Pvt. Ltd")
                                                {
                                                    //result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "    Tnx SKS Nutritions";
                                                    result += "Congratulations!! You have purchased an Authentic Product from Ankerite Health Care Pvt Ltd.";
                                                }
                                                else if (CompName == "Chase2Fit")
                                                {
                                                    //result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "    Tnx SKS Nutritions";
                                                    result += "Congratulations!! You have purchased an Authentic Product of Chase 2 Fit.";
                                                }

                                                else
                                                {
                                                    if (result != "")
                                                        result += fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<MRP>", dsres.Tables[0].Rows[0]["MRP"].ToString()).Replace("<MFD>", Convert.ToDateTime(dsres.Tables[0].Rows[0]["Mfd_Date"]).ToString("MM/yyyy")).Replace("<BTNO>", dsres.Tables[0].Rows[0]["Batch_No"].ToString()).Replace("<SMS>", dsres.Tables[0].Rows[0]["Comments"].ToString()).Replace("<CMPNAME>", dsres.Tables[0].Rows[0]["Comp_Name"].ToString()).Replace("EXP <EXP>", "");
                                                    else
                                                        result += fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>",
                                                            Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<MRP>",
                                                            dsres.Tables[0].Rows[0]["MRP"].ToString()).Replace("<MFD>",
                                                            Convert.ToDateTime(dsres.Tables[0].Rows[0]["Mfd_Date"]).ToString("MM/yyyy")).Replace("<BTNO>",
                                                            dsres.Tables[0].Rows[0]["Batch_No"].ToString()).Replace("<SMS>",
                                                            dsres.Tables[0].Rows[0]["Comments"].ToString()).Replace("<CMPNAME>",
                                                            dsres.Tables[0].Rows[0]["Comp_Name"].ToString()).Replace("EXP <EXP>", "");
                                                    //if (!string.IsNullOrEmpty(dsres.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString()))
                                                    //{
                                                    //    result += result.Replace("<warranty>", "Warranty -" + dsres.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString() + " months");
                                                    //}
                                                    //else
                                                    //{
                                                    //    result += result.Replace("<warranty>", "");
                                                    //}
                                                }
                                            }
                                            else
                                            {
                                                if (CompName.ToLower() == "1 stop nutrition")
                                                {
                                                    //result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "   Tnx SKS Nutritions";
                                                    result += "You have purchased a Genuine " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " product by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + " with coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " Inc. VCQRU";
                                                }

                                                else if (CompName == "Guru Kripa Enterprises")
                                                {
                                                    //result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "    Tnx SKS Nutritions";
                                                    result += "You have purchased a Genuine " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " product by Pro Nutrition with coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " Inc. VCQRU";
                                                }
                                                else if (CompName == "PATANJALI  FOODS  LIMITED")
                                                {

                                                    DataTable DTMSN = SQL_DB.ExecuteDataTable("EXEC USP_Getexpdatepfl '" + Reg.Received_Code1 + "','" + Reg.Received_Code2 + "'");
                                                    if (DTMSN.Rows.Count > 0)
                                                    {
                                                        string manufacturedDate = DateTime.Parse(DTMSN.Rows[0]["Manufactured_date"].ToString()).ToString("dd/MM/yyyy");
                                                        string expiryDate = DateTime.Parse(DTMSN.Rows[0]["Expiry_date"].ToString()).ToString("dd/MM/yyyy");
                                                        result = "Congratulations! You've bought a genuine <product name> from Patanjali.</br> manufacturing date: " + manufacturedDate + " </br> expiration date: " + expiryDate + " ";
                                                    }
                                                    else
                                                    {
                                                        result = "Congratulations! You've bought a genuine <product name> from Patanjali.";
                                                    }
                                                    if (!IsSameLocation)
                                                        result = result + "| This code has been verified from different location.";
                                                    result = result.Replace("<product name>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString());
                                                    result = result.Replace("<br/><br/>", "");
                                                }
                                                else if (CompName == "PARAG MILK FOODS")
                                                {

                                                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                    {
                                                        result += "You have purchased a Genuine " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " product by PARAG MILK FOODS with coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " Inc. VCQRU";
                                                    }
                                                    else
                                                    {
                                                        result += "Congratulations!! You have purchased an Authentic product from Avvatar India.";
                                                    }



                                                }

                                                else if (CompName == "Ankerite Health Care Pvt. Ltd")
                                                {
                                                    //result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "    Tnx SKS Nutritions";
                                                    result += "Congratulations!! You have purchased an Authentic Product from Ankerite Health Care Pvt Ltd.";
                                                }

                                                else if (CompName == "Chase2Fit")
                                                {
                                                    //result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "    Tnx SKS Nutritions";
                                                    result += "Congratulations!! You have purchased an Authentic Product of Chase 2 Fit.";
                                                }

                                                else if (CompName == "EVERCROP AGRO SCIENCE")
                                                {
                                                    //result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "    Tnx SKS Nutritions";
                                                    result = result + "";
                                                }

                                                else if (CompName.ToLower() == "nutriglow")
                                                {
                                                    result = "GENUINE CODE " + Reg.Received_Code1 + "-" + Reg.Received_Code2 + "," + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + "," +
                                                       dsres.Tables[0].Rows[0]["MRP"].ToString() + "," + DefaultComments;

                                                }
                                                else if (CompName == "RSR Resource" || CompName == "Muscle Fighter Nutrition")
                                                {
                                                    result += "";
                                                }
                                                else

                                                {
                                                    //result = result + " Code1-" + Reg.Received_Code1 + " & Code2-" + Reg.Received_Code2 + ", Prod-" + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", SN-" + dsres.Tables[0].Rows[0]["series"].ToString() + "" +
                                                    //                        ", MRP-" + dsres.Tables[0].Rows[0]["MRP"].ToString() + ", MFG" + dsres.Tables[0].Rows[0]["Mfd_Date"].ToString() + ", EXP" + dsres.Tables[0].Rows[0]["Exp_Date"].ToString() + ", BtNo-" + dsres.Tables[0].Rows[0]["Batch_No"].ToString() + ", <b> PROD IS GENUINE </b>."; //& mfd by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + " " + DefaultComments + " Tnx label9420";
                                                    result += fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>",
                                                       Reg.Received_Code2).Replace("<PRONAME>",
                                                       dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<MRP>",
                                                       dsres.Tables[0].Rows[0]["MRP"].ToString()).Replace("<MFD>",
                                                       Convert.ToDateTime(dsres.Tables[0].Rows[0]["Mfd_Date"]).ToString("MM/yyyy")).Replace("<EXP>",
                                                       Convert.ToDateTime(dsres.Tables[0].Rows[0]["Exp_Date"]).ToString("MM/yyyy")).Replace("<BTNO>",
                                                       dsres.Tables[0].Rows[0]["Batch_No"].ToString()).Replace("<SMS>", dsres.Tables[0].Rows[0]["Comments"].ToString())
                                                       .Replace("<CMPNAME>",
                                                       dsres.Tables[0].Rows[0]["Comp_Name"].ToString());
                                                    //if (!string.IsNullOrEmpty(dsres.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString()))
                                                    //{
                                                    //    result += result.Replace("<warranty>", "Warranty -" + dsres.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString() + " months");
                                                    //}
                                                    //else
                                                    //{
                                                    //    result += result.Replace("<warranty>", "");
                                                    //}
                                                    //.Replace("<warranty>", dsres.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString() + " months");
                                                    // SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('exp date -" + Convert.ToDateTime(dsres.Tables[0].Rows[0]["Exp_Date"]).ToString("MM/yyyy") + "')");
                                                }
                                            }


                                            //   Status = true;
                                            //   return Status + "*" + result;
                                            //if (!string.IsNullOrEmpty(result))
                                            //{
                                            //    result = result + " & mfd by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + " " + DefaultComments + " Tnx label9420";
                                            //}
                                            break;
                                            #endregion
                                        }
                                    //case "SRV1004": //Big Data Analysis - not required for code check.
                                    //     {

                                    //         break;
                                    //     }
                                    case "SRV1005": //Cash Transfers
                                        {
                                            #region Cah Transfer
                                            DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
                                            if (dt.Rows.Count > 0)
                                            {
                                                string strEarnedPoints = dt.Rows[0]["Points"].ToString();
                                                string dIscash = "";
                                                string Iscash = dt.Rows[0]["Iscash"].ToString();
                                                string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();
                                                string RS = "RS.";

                                                if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
                                                {
                                                    // Add sms Tej----------- Cash Transfer
                                                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                    {


                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 412");
                                                        if (strReturnMSG.Contains("<CODE1>"))
                                                        {
                                                            strReturnMSG = strReturnMSG.Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                        if (strReturnMSG.Contains("<MRP>"))
                                                        {
                                                            strReturnMSG = strReturnMSG.Replace("<MRP>", Iscash);
                                                        }

                                                        #region// TemplateId for Success
                                                        SendSmsfromknowlarity(strReturnMSG, Reg.Mobile_No, "1007066708989170180");
                                                        #endregion
                                                    }
                                                    // Add cloe sms Tej----------- Cash Transfer

                                                    // if (IsCashConvert == "0") // ask arish below point? Covert points to cash will do end user/company user
                                                    //result = result + " You have gained <b  Rs" + Iscash + "/- </b> against the purchased product.Please complete your Profile details to avail cash amount - <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";
                                                    if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "MAHINDRA AND MAHINDRA LTD")
                                                    {

                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<RS>", RS)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }

                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }
                                                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "DURGA COLOUR AND CHEM.P LTD.")
                                                    {
                                                        if (Dial_Mode == "SMS" || Dial_Mode == "IVR")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 151");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 151");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }

                                                    }
                                                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "PRINCIPLE ADHESIVES PRIVATE LIMITED")
                                                    {
                                                        if (Dial_Mode == "SMS" || Dial_Mode == "IVR")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 158");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 158");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }

                                                    }
                                                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "CHERYL CHEMICAL AND POLYMERS")
                                                    {
                                                        if (Dial_Mode == "SMS" || Dial_Mode == "IVR")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 151");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 419");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }

                                                    }
                                                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Oltimo Lubes")
                                                    {
                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 93");
                                                        result = result + (strReturnMSG.Replace("<cash>", "₹" + Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                    }

                                                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "HERBAL AYURVEDA AND RESEARCH CENTER")
                                                    {
                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 108");
                                                        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                    }

                                                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "SAMSOIL PETROLEUM INDIA LTD")
                                                    {
                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 119");
                                                        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                    }

                                                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "BLUEGEM PAINTS")
                                                    {
                                                        if (Dial_Mode == "SMS" || Dial_Mode == "IVR")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 102");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 102");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }

                                                    }
                                                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "MIDAS TOUCH METALLOYS PRIVATE LIMITED")
                                                    {
                                                        if (Dial_Mode == "SMS" || Dial_Mode == "IVR")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 102");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 137");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }

                                                    }

                                                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Shree Durga Traders")
                                                    {
                                                        if (Dial_Mode == "SMS" || Dial_Mode == "IVR")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 112");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                        else if (proName == "Durga_Gift")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 113");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 112");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }

                                                    }


                                                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "NV INFOTECH DOMAIN")
                                                    {

                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<RS>", RS)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 89");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }

                                                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "The Kolorado  Paints")
                                                    {

                                                        if (Dial_Mode == "SMS" || Dial_Mode == "IVR")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<RS>", RS)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 83");
                                                            result = result + (strReturnMSG.Replace("<cash>", "₹" + Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }

                                                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "MITHILA PAINTS PRIVATE LIMITED")
                                                    {
                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 117");
                                                        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                    }
                                                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "JOHNSON PAINTS CO.")
                                                    {
                                                        dIscash = (((decimal.Round(Convert.ToDecimal(Iscash), 2) * 10) / 100) + decimal.Round(Convert.ToDecimal(Iscash), 2)).ToString("N2");
                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 9");
                                                        result = result + (strReturnMSG.Replace("<dcash>", dIscash).Replace("<cash>", Iscash).Replace("<PRONAME>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
                                                    }
                                                    else
                                                    {
                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 4");
                                                        result = result + (strReturnMSG.Replace("<dcash>", dIscash).Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
                                                    }
                                                    // else
                                                    //      result = result + " You have won a gift againts earned points.Please complete your profile details to claim your gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>";
                                                }
                                                else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
                                                {
                                                    //result = result + "Just left with " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " more purchase and will gain a cash of  <b> Rs" + Iscash + "/- </b>.";
                                                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 5");
                                                    result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();
                                                }

                                            }
                                            #endregion
                                            break;
                                        }
                                    case "SRV1003": //Gift Coupons
                                        {
                                            #region GiftCoupon
                                            //GetGiftCouponService();
                                            //DataRow[] dr = dtServiceAssign.Select("Service_id = '" + stServiceid + "'");
                                            if (dr.Length > 0)
                                            {
                                                strDialMode1 = Dial_Mode;
                                                result = result + ServiceLogic.GetGiftCouponService(dr[0], Convert.ToInt32(dtTotalCodesCount.Rows[0][0].ToString()), Reg.Received_Code1, Reg.Received_Code2, Reg.Comp_ID, false, stServiceid, Reg);
                                            }
                                            #endregion
                                            break;
                                        }
                                    case "SRV1006": //Raffle Scheme
                                        {
                                            #region Raffle Service
                                            //Reg.Is_Success = 0;
                                            //Business9420.function9420.InsertCodeChecked(Reg);
                                            if (dr.Length > 0)
                                            {
                                                strDialMode1 = Dial_Mode;
                                                result = result + ServiceLogic.GetGiftCouponService(dr[0], Convert.ToInt32(dtTotalCodesCount.Rows[0][0].ToString()), Reg.Received_Code1, Reg.Received_Code2, Reg.Comp_ID, true, stServiceid, Reg);

                                            }
                                            //result = result + "Wprk in process";
                                            #endregion
                                            break;
                                        }
                                    case "SRV1020": //Referral
                                        {


                                            #region Referral
                                            DataSet ds = Proc_SaveCodeDtsForReferralService(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde, ReferralCodeFromUser);
                                            DataTable dt = ds.Tables[0];
                                            // DataTable dtReferralLimit = ds.Tables[1];
                                            // string strlimit = string.Empty;
                                            //if (dtReferralLimit.Rows.Count > 0)
                                            //{
                                            //    strlimit = dtReferralLimit.Rows[0]["limit"].ToString();
                                            //}
                                            if (dt.Rows.Count > 0)
                                            {
                                                //string strReferralCode = dt.Rows[0]["ReferralCode"].ToString();
                                                //  string IsCashConvert = dt.Rows[0]["IsCashConvert"].ToString();
                                                // if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
                                                {
                                                    string points22 = "";
                                                    if (dt.Rows[0]["IsReferral1"].ToString() == "1")
                                                        points22 = "cash";
                                                    else if (dt.Rows[0]["IsReferral1"].ToString() == "2")
                                                        points22 = "points";
                                                    else if (dt.Rows[0]["IsReferral1"].ToString() == "3")
                                                        points22 = "gift";


                                                    string strReferralCode = dt.Rows[0]["NewGenerate_ReferralCode"].ToString();
                                                    // if (IsCashConvert == "0") // ask arish below point? Covert points to cash will do end user/company user
                                                    //if (!string.IsNullOrEmpty(strReferralCode))
                                                    if (string.IsNullOrEmpty(ReferralCodeFromUser))
                                                    {
                                                        if (Convert.ToInt32(dt.Rows[0]["limitno"]) > 0)
                                                        {
                                                            // DataView dv = MsgTempdt.DefaultView;
                                                            // dv.RowFilter = ;
                                                            //  DataTable fdt = dv.ToTable();
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1020' and SubHeadId = 'POINTS' and MsgType =4");
                                                            result = result + (strReturnMSG.Replace("<strReferralCode>", strReferralCode)).ToUpper();

                                                            // result = result + "Congs! You gained <b>" + points22 + "</b> and  a referral code - <b>" + strReferralCode + "</b>.Share your referral code to <b>" + strlimit + " people </b> and gain benefits.";
                                                            //result += fdt.Rows[0]["MsgBody"].ToString().Replace("<strReferralCode>", strReferralCode);
                                                            // result = result + "Congs! Can gain (points/cash/gift),just share your referral code<b>(" + strReferralCode + ") others.";
                                                            //result = result + "Congs! You gained a referral code - <b>" + strReferralCode + "</b>.Share your referral code to people's and gain benefits.";
                                                            // SendSms("Congs! Gained Referral code-" + strReferralCode + "", ProjectSession.strMobileNo);
                                                        }

                                                    }
                                                    else if (!string.IsNullOrEmpty(ReferralCodeFromUser))
                                                    {

                                                        //DataTable dtREFCODE = new DataTable();
                                                        //try
                                                        //{
                                                        //    string strval1 = ReferralCodeFromUser.Substring(3);
                                                        //    dtREFCODE = SQL_DB.ExecuteDataTable("select * from M_consumer where ReferralCode = " + strval1);                                                           
                                                        //}
                                                        //catch (Exception)
                                                        //{


                                                        //}
                                                        if (Convert.ToInt32(dt.Rows[0]["limitno"]) < 0)
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1020' and SubHeadId = 'POINTS' and MsgType =5");
                                                            result = result + (strReturnMSG.Replace("<strReferralCode>", ReferralCodeFromUser)).ToUpper();
                                                            //result = result + " You have won a gift againts earned points.Please complete your profile details to claim your gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>";
                                                        }
                                                        else
                                                        {
                                                            #region
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1020' and SubHeadId = 'POINTS' and MsgType =6");
                                                            result = result + (strReturnMSG.Replace("<point>", dt.Rows[0]["RefPoints_ReferUser"].ToString()).Replace("<strReferralCode>", ReferralCodeFromUser)).ToUpper();

                                                            if (Dial_Mode.ToLower() == "website")
                                                            {
                                                                SendSms((strReturnMSG.Replace("<point>", dt.Rows[0]["RefPoints_ReferUser"].ToString()).Replace("<strReferralCode>", ReferralCodeFromUser)).ToUpper()
                                                                    , Reg.Mobile_No);// referral user.

                                                                if (ds.Tables.Count > 1)
                                                                {
                                                                    DataTable dt_Ref_User = ds.Tables[1];
                                                                    if (dt_Ref_User.Rows.Count > 0)
                                                                    {
                                                                        if (dt_Ref_User.Rows[0][0].ToString() != "0")
                                                                        {
                                                                            SendSms((strReturnMSG.Replace("<point>", dt_Ref_User.Rows[0]["RefPoints_User"].ToString())
                                                                                .Replace("<strReferralCode>", ReferralCodeFromUser)).ToUpper().Replace("USING CODE", "REFFERING CODE")
                                                                                , dt_Ref_User.Rows[0]["User_ReferralCode_MobileNo"].ToString()); // the user
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                            else
                                                            {
                                                                // Note : this is for SMS
                                                                // here SMS(functionality) is going to the users (this user is using referral code) who done the code check. but for user (who's referral code is used must also receive SMS)
                                                                // so one of the user is doing code check and other user, who's referral code is used, must also receive a sms of earn benefits.                                                                
                                                                DataTable dt_Ref_User = ds.Tables[1];
                                                                if (dt_Ref_User.Rows.Count > 0)
                                                                {
                                                                    if (dt_Ref_User.Rows[0][0].ToString() != "0")
                                                                    {
                                                                        SendSms((strReturnMSG.Replace("<point>", dt_Ref_User.Rows[0]["RefPoints_User"].ToString())
                                                                          .Replace("<strReferralCode>", ReferralCodeFromUser)).ToUpper().Replace("USING CODE", "REFFERING CODE")
                                                                          , dt_Ref_User.Rows[0]["User_ReferralCode_MobileNo"].ToString()); // the user
                                                                    }
                                                                }

                                                            }
                                                            #endregion
                                                        }


                                                    }


                                                }
                                                //else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
                                                //{
                                                //    //result = result + "Congs! You have earned points againts the purchased product. ";
                                                //    string points = "";
                                                //    if (dt.Rows[0]["IsReferral1"].ToString() == "1")
                                                //        points = "cash";
                                                //    else if (dt.Rows[0]["IsReferral1"].ToString() == "2")
                                                //        points = "points";
                                                //    else if (dt.Rows[0]["IsReferral1"].ToString() == "3")
                                                //        points = "gift";

                                                //    result = result + "Congs! You can earn <b>" + points + "</b> againts your purchase.Just <b>" + dt.Rows[0]["ReachedFrequency"].ToString() + "</b> more purchase left.";
                                                //}
                                                //if (!string.IsNullOrEmpty(ReferralCodeFromUser))
                                                //{
                                                //    if (dt.Rows[0]["pkBReferralToOtherConsumerBenefit"].ToString() == "0")
                                                //    {
                                                //        result = result + "<br/> Your Referral Code : " + ReferralCodeFromUser + " is expired.Better luck next time!";
                                                //    }
                                                //    else if (Convert.ToInt32(dt.Rows[0]["pkBReferralToOtherConsumerBenefit"]) > 0)
                                                //    {


                                                //        // this is all the user who used the referral code reffered by other user
                                                //        DataTable dtR = ds.Tables[2];
                                                //        string points = "points";
                                                //        if (dtR.Rows[0]["isCash"].ToString() != "0")
                                                //            points = "cash";
                                                //        else if (dtR.Rows[0]["Points"].ToString() != "0")
                                                //            points = "points";
                                                //        else if (dtR.Rows[0]["Gift"].ToString() != "0")
                                                //            points = "gift";

                                                //        result = result + " <br/>Congs! You have earn <b>" + points + "</b> againts your <b>Referral Code : " + ReferralCodeFromUser + " </b>.";
                                                //        //result = result + "Your " + ReferralCodeFromUser + " is expired.Better luck next time!";
                                                //    }
                                                //}
                                            }
                                            #endregion
                                            break;
                                        }
                                    case "SRV1024": //Paytm 
                                        {
                                            #region Paytm


                                            //if (CompName.ToUpper() == "MYSHA HEALTH WORLD")
                                            //{
                                            //    DataSet ds = SQL_DB.ExecuteDataSet("select * from dbo.MoblileRegisterForPaytm (nolock) where mobileno='" + strMobileNo + "'");
                                            //    if (ds.Tables[0].Rows.Count > 0)
                                            //    {

                                            //        DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
                                            //        if (dt.Rows.Count > 0)
                                            //        {
                                            //            string strEarnedPoints = dt.Rows[0]["Points"].ToString();
                                            //            string Iscash = dt.Rows[0]["Iscash"].ToString();
                                            //            string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

                                            //            if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
                                            //            {
                                            //                // if (IsCashConvert == "0") // ask arish below point? Covert points to cash will do end user/company user
                                            //                //result = result + " You have gained <b> Rs" + Iscash + "/- </b> against the purchased product.Please complete your Profile details to avail cash amount - <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";
                                            //                if (Reg.Dial_Mode == "SMS")
                                            //                {
                                            //                    strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 2", Iscash, CompName);

                                            //                }
                                            //                else
                                            //                {
                                            //                    strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 3", Iscash, CompName);
                                            //                }
                                            //                result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
                                            //                // else
                                            //                //      result = result + " You have won a gift againts earned points.Please complete your profile details to claim your gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>";
                                            //            }
                                            //            else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
                                            //            {
                                            //                //result = result + "Just left with " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " more purchase and will gain a cash of  <b> Rs" + Iscash + "/- </b>.";
                                            //                if (Reg.Dial_Mode == "SMS")
                                            //                {
                                            //                    strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 2", Iscash, CompName);

                                            //                }
                                            //                else
                                            //                {
                                            //                    strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 3", Iscash, CompName);
                                            //                }
                                            //                result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();

                                            //            }

                                            //        }
                                            //    }
                                            //}
                                            if (CompName == "GRIH PRAWESH MARKETING COMPANY")
                                            {
                                                DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
                                                if (dt.Rows.Count > 0)
                                                {
                                                    string cnt = "2";
                                                    string strEarnedPoints = dt.Rows[0]["Points"].ToString();
                                                    string Iscash = dt.Rows[0]["Iscash"].ToString();
                                                    string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();
                                                    if (Iscash == "40")
                                                    {
                                                        cnt = "2";
                                                    }

                                                    if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
                                                    {
                                                        // if (IsCashConvert == "0") // ask arish below point? Covert points to cash will do end user/company user
                                                        //result = result + " You have gained <b> Rs" + Iscash + "/- </b> against the purchased product.Please complete your Profile details to avail cash amount - <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";

                                                        strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 4", Iscash, CompName);
                                                        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl).Replace("<points>", cnt)).ToUpper();

                                                        // else
                                                        //      result = result + " You have won a gift againts earned points.Please complete your profile details to claim your gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>";
                                                    }
                                                    else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
                                                    {
                                                        //result = result + "Just left with " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " more purchase and will gain a cash of  <b> Rs" + Iscash + "/- </b>.";
                                                        strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 4", Iscash, CompName);
                                                        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl).Replace("<points>", cnt)).ToUpper();
                                                        result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();

                                                    }

                                                }
                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 20").ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);


                                            }

                                            else if (CompName == "ALSTONE INDUSTRIES PVT. Ltd REYNOBOND")
                                            {
                                                DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];

                                                if (dt.Rows.Count > 0)
                                                {
                                                    string strEarnedPoints = dt.Rows[0]["Points"].ToString();
                                                    string Iscash = dt.Rows[0]["Iscash"].ToString();
                                                    string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

                                                    if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
                                                    {

                                                        if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 74", Iscash, CompName);
                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 30", Iscash, CompName);
                                                        }




                                                        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<PRONAME>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();


                                                    }
                                                    else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
                                                    {

                                                        if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 74", Iscash, CompName);
                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 1", Iscash, CompName);
                                                        }


                                                        result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();

                                                    }

                                                }
                                            }
                                            else if (CompName == "MARMO SOLUTIONS PRIVATE LIMITED")
                                            {
                                                DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];

                                                if (dt.Rows.Count > 0)
                                                {
                                                    string strEarnedPoints = dt.Rows[0]["Points"].ToString();
                                                    string Iscash = dt.Rows[0]["Iscash"].ToString();
                                                    string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

                                                    if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
                                                    {
                                                        if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 74", Iscash, CompName);
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<PRONAME>", proName).Replace("<Code1>", Reg.Received_Code1).Replace("<Code2>", Reg.Received_Code2).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString();
                                                        }
                                                        else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 77", Iscash, CompName);
                                                            result = result + (strReturnMSG.Replace("<cash>", " ₹" + Iscash).Replace("<PRONAME>", proName).Replace("<Code1>", Reg.Received_Code1).Replace("<Code2>", Reg.Received_Code2).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString();
                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 51", Iscash, CompName);
                                                            result = result + (strReturnMSG.Replace("<cash>", " ₹" + Iscash).Replace("<PRONAME>", proName).Replace("<Code1>", Reg.Received_Code1).Replace("<Code2>", Reg.Received_Code2).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString();
                                                        }
                                                    }
                                                    else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
                                                    {
                                                        strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 1", Iscash, CompName);
                                                        result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"])));

                                                    }

                                                }
                                            }

                                            else if (CompName == "RAUNAQ PAINT INDUSTRY")
                                            {
                                                DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];

                                                if (dt.Rows.Count > 0)
                                                {

                                                    string strEarnedPoints = dt.Rows[0]["Points"].ToString();
                                                    string Iscash = dt.Rows[0]["Iscash"].ToString();
                                                    string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

                                                    if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
                                                    {
                                                        if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 63", Iscash, CompName);
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<PRONAME>", proName).Replace("<Code1>", Reg.Received_Code1).Replace("<Code2>", Reg.Received_Code2).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString();
                                                        }
                                                        else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 81", Iscash, CompName);
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<PRONAME>", proName).Replace("<Code1>", Reg.Received_Code1).Replace("<Code2>", Reg.Received_Code2).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString();
                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 80", Iscash, CompName);
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<PRONAME>", proName).Replace("<Code1>", Reg.Received_Code1).Replace("<Code2>", Reg.Received_Code2).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString();
                                                        }

                                                    }
                                                    else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
                                                    {
                                                        strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 1", Iscash, CompName);
                                                        result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();

                                                    }

                                                }
                                            }



                                            else if (CompName == "BSC Paints Pvt Ltd")
                                            {
                                                DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];

                                                if (dt.Rows.Count > 0)
                                                {

                                                    string strEarnedPoints = dt.Rows[0]["Points"].ToString();
                                                    string Iscash = dt.Rows[0]["Iscash"].ToString();
                                                    string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

                                                    if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
                                                    {
                                                        if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 90", Iscash, CompName);
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<PRONAME>", proName).Replace("<Code1>", Reg.Received_Code1).Replace("<Code2>", Reg.Received_Code2).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString();
                                                        }
                                                        else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL" || Reg.Dial_Mode == "App_mode")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 17", Iscash, CompName);
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<PRONAME>", proName).Replace("<Code1>", Reg.Received_Code1).Replace("<Code2>", Reg.Received_Code2).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString();
                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 17", Iscash, CompName);
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<PRONAME>", proName).Replace("<Code1>", Reg.Received_Code1).Replace("<Code2>", Reg.Received_Code2).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString();
                                                        }

                                                    }
                                                    else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
                                                    {
                                                        strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 1", Iscash, CompName);
                                                        result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();

                                                    }

                                                }
                                            }




                                            else if (CompName == "Color Valley Coatings")
                                            {
                                                DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];

                                                if (dt.Rows.Count > 0)
                                                {

                                                    string strEarnedPoints = dt.Rows[0]["Points"].ToString();
                                                    string Iscash = dt.Rows[0]["Iscash"].ToString();
                                                    string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

                                                    if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
                                                    {
                                                        if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 63", Iscash, CompName);
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<PRONAME>", proName).Replace("<Code1>", Reg.Received_Code1).Replace("<Code2>", Reg.Received_Code2).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString();
                                                        }
                                                        else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 54", Iscash, CompName);
                                                            result = result + (strReturnMSG.Replace("<cash>", " ₹" + Iscash).Replace("<PRONAME>", proName).Replace("<Code1>", Reg.Received_Code1).Replace("<Code2>", Reg.Received_Code2).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString();
                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 54", Iscash, CompName);
                                                            result = result + (strReturnMSG.Replace("<cash>", " ₹" + Iscash).Replace("<PRONAME>", proName).Replace("<Code1>", Reg.Received_Code1).Replace("<Code2>", Reg.Received_Code2).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString();
                                                        }

                                                    }
                                                    else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
                                                    {
                                                        strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 1", Iscash, CompName);
                                                        result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();

                                                    }

                                                }
                                            }





                                            else if (CompName == "EVERCROP AGRO SCIENCE")
                                            {
                                                DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];

                                                if (dt.Rows.Count > 0)
                                                {
                                                    string strEarnedPoints = dt.Rows[0]["Points"].ToString();
                                                    string Iscash = dt.Rows[0]["Iscash"].ToString();
                                                    string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

                                                    if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
                                                    {
                                                        strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 411", Iscash, CompName);
                                                        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<PRONAME>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
                                                    }
                                                    else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
                                                    {
                                                        //result = result + "Just left with " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " more purchase and will gain a cash of  <b> Rs" + Iscash + "/- </b>.";
                                                        strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 1", Iscash, CompName);
                                                        result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();

                                                    }

                                                }
                                            }



                                            else
                                            {
                                                DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
                                                if (dt.Rows.Count > 0)
                                                {
                                                    string strEarnedPoints = dt.Rows[0]["Points"].ToString();
                                                    string Iscash = dt.Rows[0]["Iscash"].ToString();
                                                    string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

                                                    if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
                                                    {
                                                        // if (IsCashConvert == "0") // ask arish below point? Covert points to cash will do end user/company user
                                                        //result = result + " You have gained <b> Rs" + Iscash + "/- </b> against the purchased product.Please complete your Profile details to avail cash amount - <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>.";

                                                        strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 1", Iscash, CompName);
                                                        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();

                                                        // else
                                                        //      result = result + " You have won a gift againts earned points.Please complete your profile details to claim your gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>";
                                                    }
                                                    else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
                                                    {
                                                        //result = result + "Just left with " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " more purchase and will gain a cash of  <b> Rs" + Iscash + "/- </b>.";
                                                        strReturnMSG = GetMessageFromM_TemplateMSgPaytm(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1024' and MsgType = 1", Iscash, CompName);
                                                        result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();

                                                    }

                                                }
                                            }
                                            #endregion
                                            break;
                                        }
                                    case "SRV1027": //Auto Cash Transfer
                                        {

                                            #region Auto Cash Transfer.
                                            DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
                                            if (dt.Rows.Count > 0)
                                            {
                                                string strEarnedPoints = dt.Rows[0]["Points"].ToString();
                                                string dIscash = "";
                                                string Iscash = dt.Rows[0]["Iscash"].ToString();
                                                string proName = dsres.Tables[0].Rows[0]["Pro_Name"].ToString();

                                                if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
                                                {
                                                    #region //** Auto Cash Transfer
                                                    DataTable Bdt = SQL_DB.ExecuteDataTable("select top 1 M_Consumerid From M_Consumer where MobileNo = '" + Reg.Mobile_No + "' and IsDelete=0");
                                                    string dtto = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff");
                                                    string M_Consumerid = Bdt.Rows[0]["M_Consumerid"].ToString();
                                                    string bankId = "ACC" + M_Consumerid;
                                                    string Data = "NA";
                                                    DataSet OnlDs = SQL_DB.ExecuteDataSet("select top 1 ReqCount from tblKycBankDataDetails where AccountNo='" + AccountNumber + "' and IFSC_Code='" + IfscCode + "' and ResponseCode=100 and Status=1 and IsBankAccountVerify=1");
                                                    DataTable Bbkdt = SQL_DB.ExecuteDataTable("select top 1 m.M_Consumerid,b.Row_ID,b.Account_No From M_BankAccount b inner join M_Consumer m on m.M_Consumerid=b.M_Consumerid where m.MobileNo = '" + Reg.Mobile_No + "' and m.IsDelete=0  and b.Bank_Name is not null");



                                                    if (OnlDs.Tables[0].Rows.Count > 0)
                                                    {
                                                        int ReqCount = Convert.ToInt32(OnlDs.Tables[0].Rows[0]["ReqCount"].ToString());
                                                        if (ReqCount >= 1 && Bbkdt.Rows.Count > 0)
                                                        {

                                                        }
                                                        else
                                                        {

                                                            Data = OnlineAccountVerification(AccountNumber, IfscCode, M_Consumerid);

                                                        }


                                                    }


                                                    if (Bbkdt.Rows.Count == 0 && Data != "Success")
                                                    {

                                                        SQL_DB.ExecuteNonQuery("insert into M_BankAccount(Bank_ID,Bank_Name,Account_No,IFSC_Code,Account_HolderNm,Branch,M_Consumerid,Entry_Date,TNC) values('" + bankId + "','" + BankName + "','" + AccountNumber + "','" + IfscCode + "','" + AccountHolderName + "','" + BranchName + "','" + M_Consumerid + "','" + dtto + "','" + TNC + "')");

                                                        var length = AccountNumber.Length;
                                                        AccountNumber = new String('X', length - 4) + AccountNumber.Substring(length - 4);


                                                    }
                                                    else
                                                    {
                                                        if (Bbkdt.Rows[0]["Account_No"].ToString() != "")
                                                            AccountNumber = Bbkdt.Rows[0]["Account_No"].ToString();
                                                        else
                                                        {
                                                            string Row_ID = Bbkdt.Rows[0]["Row_ID"].ToString();
                                                            SQL_DB.ExecuteNonQuery("update M_BankAccount set Bank_Name='" + BankName + "', Account_No='" + AccountNumber + "',IFSC_Code='" + IfscCode + "',Account_HolderNm='" + AccountHolderName + "',Branch='" + BranchName + "',TNC='1' where Row_ID='" + Row_ID + "'");
                                                        }


                                                        var length = AccountNumber.Length;
                                                        AccountNumber = new String('X', length - 4) + AccountNumber.Substring(length - 4);

                                                    }

                                                    #endregion

                                                    if (CompName == "ALSTONE INDUSTRIES PVT. Ltd REYNOBOND")
                                                    {
                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }
                                                    else if (CompName == "PARAS INDUSTRIES WINDSOR")
                                                    {
                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }
                                                    else if (CompName == "SURESH CONFECTIONERY WORKS")
                                                    {
                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }
                                                    else if (CompName == "Woodland")
                                                    {
                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }
                                                    //else if (CompName == "MYSHA HEALTH WORLD")
                                                    //{
                                                    //    if (Dial_Mode == "SMS")
                                                    //    {
                                                    //        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                    //                                                                                                                                                    //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                    //        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                    //                                        .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                    //    }
                                                    //    else
                                                    //    {
                                                    //        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
                                                    //                                                                                                                                                    //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                    //        result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                    //                                        .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                    //    }
                                                    //}
                                                    else if (CompName == "VCQRU GENERIC")
                                                    {
                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }
                                                    else if (CompName == "Welgo")
                                                    {
                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }
                                                    else if (CompName == "SKYDECOR LAMINATES PRIVATE LIMITED")
                                                    {
                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }
                                                    else if (CompName == "EVERCROP AGRO SCIENCE")
                                                    {
                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }
                                                    else if (CompName == "GRIH PRAWESH MARKETING COMPANY")
                                                    {
                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }
                                                    else if (CompName == "Wudchem Industries Private Limited")
                                                    {
                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }
                                                    else if (CompName == "Marmo Solution")
                                                    {
                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }
                                                    else if (CompName == "COLOR VALLEY COATINGS")
                                                    {
                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }
                                                    else if (CompName == "Addcon Chemical")
                                                    {
                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }
                                                    //"Surface Paints" on QA and "RAUNAQ PAINT INDUSTRY"
                                                    else if (CompName == "RAUNAQ PAINT INDUSTRY")
                                                    {
                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1027' and MsgType = 1", CompName);
                                                            result = result + (strReturnMSG.Replace("<amount>", Iscash).Replace("<Product name>", proName).Replace("<1 digit>", Reg.Received_Code1 + Reg.Received_Code2).Replace("<brand name>", CompName)).Replace("<account number>", AccountNumber).ToString();

                                                        }
                                                    }
                                                    else if (CompName == "BSC Paints Pvt Ltd")
                                                    {
                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1027' and MsgType = 1", CompName);
                                                            result = result + (strReturnMSG.Replace("<amount>", Iscash).Replace("<Product name>", proName).Replace("<1 digit>", Reg.Received_Code1 + Reg.Received_Code2).Replace("<brand name>", CompName)).Replace("<account number>", AccountNumber).ToString();

                                                        }
                                                    }
                                                    else if (CompName == "BENFENLI FOODS PRIVATE LIMITED")
                                                    {
                                                        if (Dial_Mode == "SMS")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 7");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 8");   //msgType 6 is not availabel in database
                                                                                                                                                                                                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1005' and MsgType = 4");
                                                            result = result + (strReturnMSG.Replace("<cash>", Iscash).Replace("<ProductName>", proName)
                                                                                            .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                        }
                                                    }


                                                    else
                                                    {
                                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 4");
                                                        result = result + (strReturnMSG.Replace("<dcash>", dIscash).Replace("<cash>", Iscash).Replace("<ProductName>", proName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
                                                    }
                                                    // else
                                                    //      result = result + " You have won a gift againts earned points.Please complete your profile details to claim your gift <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' style='color:blue;'> BUYER SIGNUP / SIGNIN </a>";
                                                }
                                                else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
                                                {
                                                    //result = result + "Just left with " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " more purchase and will gain a cash of  <b> Rs" + Iscash + "/- </b>.";
                                                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1005' and MsgType = 5");
                                                    result = result + (strReturnMSG.Replace("<Frequency> ", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();
                                                }

                                            }
                                            #endregion





                                            break;
                                        }

                                    case "SRV1029":// Cashback-UPI
                                        {
                                            #region build loyalty
                                            DataTable dt = Proc_SaveCodeDtsForBuiltLoyalty(Reg.Received_Code1, Reg.Received_Code2, Convert.ToInt32(dr[0]["SST_Id"]), intM_Consumer_MCOde).Tables[0];
                                            if (dt.Rows.Count > 0)
                                            {
                                                string strM_consumerid = dt.Rows[0]["M_consumerid"].ToString();
                                                string strEarnedPoints = dt.Rows[0]["Points"].ToString();
                                                string dstrEarnedPoints = "";
                                                string IsCashConvert = dt.Rows[0]["IsCashConvert"].ToString();
                                                string AwardNameBL = dt.Rows[0]["AwardNameBL"].ToString();


                                                DataTable Bdt = SQL_DB.ExecuteDataTable("select top 1 * From M_Consumer where MobileNo = '" + Reg.Mobile_No + "' and IsDelete=0");

                                                string M_Consumerid = Bdt.Rows[0]["M_Consumerid"].ToString();
                                                string ConsumerName = Bdt.Rows[0]["ConsumerName"].ToString();
                                                string ConsumerEmail = Bdt.Rows[0]["Email"].ToString();
                                                string UPIId = Bdt.Rows[0]["UPIId"].ToString();



                                                // Add sms Tej----------- BL
                                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                {

                                                    //Congratulations! You have won<point> points with the coupon code<CODE1>< CODE2 >.www.vcqru.com
                                                    //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 72");
                                                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 413");
                                                    if (strReturnMSG.Contains("<CODE1>"))
                                                    {
                                                        strReturnMSG = strReturnMSG.Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                    }
                                                    if (strReturnMSG.Contains("<point>"))
                                                    {
                                                        strReturnMSG = strReturnMSG.Replace("<point>", strEarnedPoints);
                                                    }

                                                    #region// TemplateId for Success
                                                    SendSmsfromknowlarity(strReturnMSG, Reg.Mobile_No, "1007283387751173484");
                                                    #endregion
                                                }
                                                // Add close sms Tej----------- BL

                                                if (dt.Rows[0]["ReachedFrequency"].ToString() == "0")
                                                {

                                                    //MakeUPIpayment(Comp_ID, strMobileNo, ConsumerName, ConsumerEmail, UPIId, strEarnedPoints, M_Consumerid, Reg.Received_Code1, Reg.Received_Code2);
                                                    string compnm = dsres.Tables[0].Rows[0]["Comp_Name"].ToString();
                                                    string UPIKYCSTATUS = Bdt.Rows[0]["UPIKYCSTATUS"].ToString();
                                                    // stop code check pay amount
                                                    if (compnm.ToString() == "SURIE POLEX INDUSTRIES PRIVATE LIMITED" || compnm.ToString() == "Sawaria Plywood" || compnm.ToString() == "OCI Wires and Cables" || compnm == "Lubigen Pvt Ltd" || compnm == "MAHAVIR PAINTS AND ADHESIVES")
                                                    { }
                                                    else if (Teslacodecheckselection == "Bank" && compnm == "TESLA POWER INDIA PRIVATE LIMITED")
                                                    {
                                                        #region //** Instant Payout
                                                        DataTable Bdtbank = SQL_DB.ExecuteDataTable("select top 1 M_Consumerid From M_Consumer where MobileNo = '" + Reg.Mobile_No + "' and IsDelete=0");
                                                        string dtto = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff");
                                                        string M_Consumeridbank = Bdtbank.Rows[0]["M_Consumerid"].ToString();
                                                        string bankId = "ACC" + M_Consumerid;
                                                        string PaymentData = "NAA";
                                                        string DbAccount_HolderNm = "";
                                                        DataTable Bbkdt = SQL_DB.ExecuteDataTable("select top 1 m.M_Consumerid,b.Account_No,b.Account_HolderNm,b.IFSC_Code From M_BankAccount b inner join M_Consumer m on m.M_Consumerid=b.M_Consumerid where m.MobileNo = '" + Reg.Mobile_No + "' and m.IsDelete=0  and b.Bank_Name is not null");
                                                        if (Bbkdt.Rows.Count > 0)
                                                        {
                                                            DbAccount_HolderNm = Bbkdt.Rows[0]["Account_HolderNm"].ToString();
                                                            AccountNumber = Bbkdt.Rows[0]["Account_No"].ToString();
                                                            IfscCode = Bbkdt.Rows[0]["IFSC_Code"].ToString();
                                                            if (PaymentData == "NAA")
                                                                PaymentData = OnlineAccountPayment(Comp_ID, Reg.Received_Code1, Reg.Received_Code2, M_Consumerid, Reg.Mobile_No, strEarnedPoints, AccountNumber, DbAccount_HolderNm, IfscCode);
                                                        }
                                                        else
                                                        {
                                                            PaymentData = OnlineAccountPayment(Comp_ID, Reg.Received_Code1, Reg.Received_Code2, M_Consumerid, Reg.Mobile_No, strEarnedPoints, AccountNumber, DbAccount_HolderNm, IfscCode);
                                                        }
                                                        #endregion
                                                    }
                                                    else if (compnm == "TESLA POWER INDIA PRIVATE LIMITED" && UPIKYCSTATUS != "1")
                                                    {
                                                        MakeUPIpayment(Comp_ID, strMobileNo, ConsumerName, ConsumerEmail, UPIId, strEarnedPoints, M_Consumerid, Reg.Received_Code1, Reg.Received_Code2);
                                                    }
                                                    else
                                                    {
                                                        MakeUPIpayment(Comp_ID, strMobileNo, ConsumerName, ConsumerEmail, UPIId, strEarnedPoints, M_Consumerid, Reg.Received_Code1, Reg.Received_Code2);
                                                    }
                                                    if (IsCashConvert == "0") // Covert points to cash will do end user
                                                    {
                                                        if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "TESLA POWER INDIA PRIVATE LIMITED")
                                                        {
                                                            if ((Teslacodecheckselection == "Bank" && Bdt.Rows[0]["VRKbl_KYC_status"].ToString() == "1") || (Teslacodecheckselection == "UPI" && Bdt.Rows[0]["UPIKYCSTATUS"].ToString() == "1"))
                                                            {
                                                                //strReturnMSG = "Congratulations! You have won <cash> Rs. amount. </br> To claim the benefits,  <a href=\"https://qa.vcqru.com/login.aspx\">click here:</a>";
                                                                // strReturnMSG = " </b>Congratulations! The coupon verified successfully and you have won ₹<cash> amount.</br></br> To login/ check /claim wallet balance <a href=\"https://qa.vcqru.com/login.aspx\">click here</a>";
                                                                strReturnMSG = " </b>The coupon has been verified successfully and you have won ₹<cash>.</br>कूपन सफलतापूर्वक सत्यापित हो गया है और आपने ₹<cash> राशि जीत ली है।  </br></br> To login/ check /claim wallet balance <a href=\"https://www.vcqru.com/teslalogin.aspx\">click here</a>";
                                                                result = result + (strReturnMSG.Replace("<cash>", strEarnedPoints).Replace("<ProductName>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                                return result;
                                                            }
                                                            else if (Teslacodecheckselection == "Bank" && (Bdt.Rows[0]["VRKbl_KYC_status"].ToString() == "0" || string.IsNullOrEmpty(Bdt.Rows[0]["VRKbl_KYC_status"].ToString())))
                                                            {
                                                                //strReturnMSG = "Congratulations! You have won <cash> Rs. amount. </br> To claim the benefits,  <a href=\"https://qa.vcqru.com/login.aspx\">click here:</a>";
                                                                // strReturnMSG = "</b>Congratulations! The coupon verified successfully but the transaction failed due to pending KYC. ₹<cash> added to your wallet. </br></br> To login/ check /claim wallet balance <a href=\"https://qa.vcqru.com/login.aspx\">click here</a>";
                                                                strReturnMSG = "</b> The coupon has been verified successfully and you have won ₹<cash>. Your profile is under review and it will be verified within 24-48 hrs.</br>कूपन सफलतापूर्वक सत्यापित हो गया है और आपने ₹<cash> राशि जीत ली है। आपकी प्रोफ़ाइल समीक्षाधीन है और इसे 24-48 घंटों के भीतर सत्यापित किया जाएगा। </br></br> To login/ check /claim wallet balance <a href=\"https://www.vcqru.com/teslalogin.aspx\">click here</a>";
                                                                result = result + (strReturnMSG.Replace("<cash>", strEarnedPoints).Replace("<ProductName>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                                return result;
                                                            }
                                                            else if (Teslacodecheckselection == "UPI" && (Bdt.Rows[0]["UPIKYCSTATUS"].ToString() == "0" || string.IsNullOrEmpty(Bdt.Rows[0]["UPIKYCSTATUS"].ToString())))
                                                            {
                                                                // strReturnMSG = "</b>Congratulations! The coupon verified successfully but the transaction failed due to pending KYC. ₹<cash> added to your wallet.</br></br> To login/ check /claim wallet balance <a href=\"https://qa.vcqru.com/login.aspx\">click here</a>";
                                                                strReturnMSG = "</b> The coupon has been verified successfully and you have won ₹<cash>. Your profile is under review and it will be verified within 24-48 hrs.</br>कूपन सफलतापूर्वक सत्यापित हो गया है और आपने ₹<cash> राशि जीत ली है। आपकी प्रोफ़ाइल समीक्षाधीन है और इसे 24-48 घंटों के भीतर सत्यापित किया जाएगा। </br></br> To login/ check /claim wallet balance <a href=\"https://www.vcqru.com/teslalogin.aspx\">click here</a>";
                                                                result = result + (strReturnMSG.Replace("<cash>", strEarnedPoints).Replace("<ProductName>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                                return result;
                                                            }
                                                            else if (Teslacodecheckselection == "Bank" && Bdt.Rows[0]["VRKbl_KYC_status"].ToString() == "2")
                                                            {
                                                                //strReturnMSG = "Congratulations! You have won <cash> Rs. amount. </br> To claim the benefits,  <a href=\"https://qa.vcqru.com/login.aspx\">click here:</a>";
                                                                // strReturnMSG = "</b>Congratulations! The coupon verified successfully but the transaction failed due to rejected KYC. ₹<cash> added to your wallet. Kindly connect with the customer support team.</br></br> To login/ check /claim wallet balance <a href=\"https://qa.vcqru.com/login.aspx\">click here</a>";
                                                                strReturnMSG = "</b>The coupon verified successfully but the transaction failed due to rejected KYC. ₹<cash> added to your wallet.</br>कूपन सफलतापूर्वक सत्यापित हो गया लेकिन केवाईसी अस्वीकृत होने के कारण लेनदेन विफल हो गया। ₹<cash> आपके वॉलेट में जमा कर दिया गया है। </br></br> To login/ check /claim wallet balance <a href=\"https://www.vcqru.com/teslalogin.aspx\">click here</a>";
                                                                result = result + (strReturnMSG.Replace("<cash>", strEarnedPoints).Replace("<ProductName>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                                return result;
                                                            }
                                                            else if (Teslacodecheckselection == "UPI" && Bdt.Rows[0]["UPIKYCSTATUS"].ToString() == "2")
                                                            {
                                                                // strReturnMSG = "</b>Congratulations! The coupon verified successfully but the transaction failed due to rejected KYC. ₹<cash> added to your wallet. Kindly connect with the customer support team.</br></br> To login/ check /claim wallet balance <a href=\"https://qa.vcqru.com/login.aspx\">click here</a>";
                                                                strReturnMSG = "</b>The coupon verified successfully but the transaction failed due to rejected KYC. ₹<cash> added to your wallet.</br>कूपन सफलतापूर्वक सत्यापित हो गया लेकिन केवाईसी अस्वीकृत होने के कारण लेनदेन विफल हो गया। ₹<cash> आपके वॉलेट में जमा कर दिया गया है। </br></br> To login/ check /claim wallet balance <a href=\"https://www.vcqru.com/teslalogin.aspx\">click here</a>";
                                                                result = result + (strReturnMSG.Replace("<cash>", strEarnedPoints).Replace("<ProductName>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                                return result;
                                                            }


                                                        }
                                                        if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "HANNOVER CHEMIKALIEN PRIVATE LIMITED")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1029' and MsgType = 127");
                                                            result = result + (strReturnMSG.Replace("<cash>", "₹" + strEarnedPoints).Replace("<ProductName>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                            return result;
                                                        }
                                                        if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "SHERKOTTI INDUSTRIES PRIVATE LIMITED")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1029' and MsgType = 156");
                                                            result = result + (strReturnMSG.Replace("<cash>", "₹" + strEarnedPoints).Replace("<ProductName>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                            return result;
                                                        }
                                                        else if (compnm.ToString() == "Oltimo Lubes")
                                                        {
                                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1020' and MsgType = 2 ").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                                                            }

                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1029' and MsgType = 115");
                                                                result = result + (strReturnMSG.Replace("<cash>", "₹" + strEarnedPoints).Replace("<ProductName>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                                                            }
                                                            return result;
                                                        }
                                                        else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "VCQRU")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1029' and MsgType = 154");
                                                            result = result + (strReturnMSG.Replace("<cash>", "₹" + strEarnedPoints).Replace("<ProductName>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                            return result;
                                                        }
                                                        else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "SRI ANANTHA PADMANABHA SWAMY ENTERPRISES")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1029' and MsgType = 135");
                                                            result = result + (strReturnMSG.Replace("<cash>", strEarnedPoints).Replace("<ProductName>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                            return result;
                                                        }
                                                        else if (compnm.ToString() == "Ambica Cable")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1029' and MsgType = 146");
                                                            result = result + (strReturnMSG.Replace("<cash>", "₹" + strEarnedPoints).Replace("<ProductName>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                                            return result;
                                                        }
                                                        else if (CompName == "MAHAVIR PAINTS AND ADHESIVES")
                                                        {
                                                            strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 144");
                                                            result = (strReturnMSG.Replace("<points>", strEarnedPoints));

                                                        }
                                                        else if (CompName == "OCI Wires and Cables")
                                                        {

                                                            if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                            {
                                                                result = "Congratulations You have won " + strEarnedPoints + " points added to your wallet successfully.<br> बधाई हो आपने अपने वॉलेट में सफलतापूर्वक " + strEarnedPoints + " अंक जोड़ लिए हैं";
                                                            }
                                                            else if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 73");
                                                            }
                                                            else
                                                            {
                                                                result = "Congratulations You have won " + strEarnedPoints + " points added to your wallet successfully.<br> बधाई हो आपने अपने वॉलेट में सफलतापूर्वक " + strEarnedPoints + " अंक जोड़ लिए हैं";

                                                                // result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 60");
                                                            }
                                                        }
                                                        else
                                                        {
                                                            strReturnMSG = "Congrats! Won rs. <points> against <PRONAME> for coupon <CODE1><CODE2> , amount has been initiated through UPI payment.";
                                                            result = result + (strReturnMSG.Replace("<points>", strEarnedPoints).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString());
                                                        }
                                                    }
                                                    else if (IsCashConvert == "1") // Covert points to 
                                                    {
                                                        if (CompName == "OCI Wires and Cables")
                                                        {

                                                            if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                            {
                                                                result = "Congratulations You have won " + strEarnedPoints + " points added to your wallet successfully.<br> बधाई हो आपने अपने वॉलेट में सफलतापूर्वक " + strEarnedPoints + " अंक जोड़ लिए हैं";
                                                            }
                                                            else if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 73");
                                                            }
                                                            else
                                                            {
                                                                result = "Congratulations You have won " + strEarnedPoints + " points added to your wallet successfully.<br> बधाई हो आपने अपने वॉलेट में सफलतापूर्वक " + strEarnedPoints + " अंक जोड़ लिए हैं";

                                                                // result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 60");
                                                            }
                                                        }
                                                        else if (CompName == "SURIE POLEX INDUSTRIES PRIVATE LIMITED")
                                                        {
                                                            result = "You have purchased an Authentic product from Surie Polex and on purchase of the product, you have won " + strEarnedPoints + " points." +
                                                                " बधाई हो!! आपने सूरी पोलेक्स से एक प्रामाणिक उत्पाद खरीदा है और उत्पाद की खरीद पर आपने " + strEarnedPoints + " अंक जीते हैं।";
                                                            return result;
                                                        }
                                                        else if (CompName == "Lubigen Pvt Ltd")
                                                        {
                                                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                                            {
                                                                result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 73");
                                                            }
                                                            else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 71");
                                                                result = (strReturnMSG.Replace("<points>", strEarnedPoints));
                                                            }
                                                            else
                                                            {
                                                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 69");
                                                                result = (strReturnMSG.Replace("<points>", strEarnedPoints));
                                                            }

                                                        }
                                                        else
                                                        {
                                                            result = "Congratulations You have won " + strEarnedPoints + " points added to your wallet successfully.";

                                                        }

                                                    }

                                                    else
                                                    {
                                                        strReturnMSG = "Congrats! Won rs. <points> against <PRONAME> for coupon <CODE1><CODE2> , amount has been initiated through UPI payment.";
                                                        result = result + (strReturnMSG.Replace("<dpoints>", dstrEarnedPoints).Replace("<points>", strEarnedPoints).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<CMPNAME>", CompName.ToUpper());
                                                    }

                                                }
                                                else if (Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) > 0)
                                                {
                                                    // result = result + "Congs! You can earn <b>points</b> againts the purchased product.Just left with  <b> " + Convert.ToInt32(dt.Rows[0]["ReachedFrequency"]) + " </b> more purchase ";
                                                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1001' and MsgType = 6");
                                                    result = result + (strReturnMSG.Replace("<points>", strEarnedPoints).Replace("<frequency>", Convert.ToString(dt.Rows[0]["ReachedFrequency"]))).ToUpper();
                                                }
                                            }
                                            #endregion
                                            break;
                                        }

                                    default:
                                        break;

                                }
                                #endregion
                            }


                            #endregion
                        }
                        else
                        {
                            if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToLower() == "1 stop nutrition")
                            {
                                //result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + "   Tnx SKS Nutritions";
                                result += "You have purchased a Genuine " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " product by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + " with coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " Inc. VCQRU";
                            }

                            else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Guru Kripa Enterprises")
                            {
                                //result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "    Tnx SKS Nutritions";
                                result += "You have purchased a Genuine " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " product by Pro Nutrition with coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " Inc. VCQRU";
                            }

                            else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "PARAG MILK FOODS")
                            {
                                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                {
                                    result += "You have purchased a Genuine " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " product by PARAG MILK FOODS with coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " Inc. VCQRU";
                                }
                                else
                                {
                                    result += "Congratulations!! You have purchased an Authentic product from Avvatar India.";
                                }


                            }

                            else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Ankerite Health Care Pvt. Ltd")
                            {
                                //result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "    Tnx SKS Nutritions";
                                result += "Congratulations!! You have purchased an Authentic Product from Ankerite Health Care Pvt Ltd.";
                            }
                            else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Nutramarc Sports")
                            {
                                result += "Congratulations!! You have purchased an Authentic product from Nutra marc Sports Nutrition.";
                            }

                            else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Denzour Nutritions")
                            {
                                result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "    Tnx Denzour Nutritions";
                                //result += "Congratulations!! You have purchased an Authentic product from Denzour Nutritions.";
                            }
                            else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "PATANJALI  FOODS  LIMITED")
                            {

                                DataTable DTMSN = SQL_DB.ExecuteDataTable("EXEC USP_Getexpdatepfl '" + Reg.Received_Code1 + "','" + Reg.Received_Code2 + "'");
                                if (DTMSN.Rows.Count > 0)
                                {
                                    string manufacturedDate = DateTime.Parse(DTMSN.Rows[0]["Manufactured_date"].ToString()).ToString("dd/MM/yyyy");
                                    string expiryDate = DateTime.Parse(DTMSN.Rows[0]["Expiry_date"].ToString()).ToString("dd/MM/yyyy");
                                    result = "Congratulations! You've bought a genuine <product name> from Patanjali.</br> manufacturing date: " + manufacturedDate + " </br> expiration date: " + expiryDate + " ";
                                }
                                else
                                {
                                    result = "Congratulations! You've bought a genuine <product name> from Patanjali.";
                                }
                                if (!IsSameLocation)
                                    result = result + "| This code has been verified from different location.";
                                result = result.Replace("<product name>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString());
                                result = result.Replace("<br/><br/>", "");
                            }
                            else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Chase2Fit")
                            {
                                //result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "    Tnx SKS Nutritions";
                                result += "Congratulations!! You have purchased an Authentic Product of Chase 2 Fit.";
                            }

                        }
                    }
                }
            }
            #region Patanjali multi code scan
            else if (IsCheckedUse_Count && Use_Count <= 2 && Reg.Comp_ID.ToString() == "Comp-1693")
            {

                Reg.Is_Success = 1;
                if (dsres.Tables[0].Rows.Count > 0)
                {
                    if (dsServicesAssign.Tables.Count <= 2)
                    {
                        dtServiceAssign = dsServicesAssign.Tables[0];
                        dtTotalCodesCount = dsServicesAssign.Tables[1];

                        if (dtServiceAssign.Rows.Count > 0)
                        {
                            #region Loop in service
                            CompName = dsres.Tables[0].Rows[0]["Comp_Name"].ToString();


                            //** Added for Instant payout
                            string Comp_ID = dtServiceAssign.Rows[0]["Comp_ID"].ToString();

                            Assinservice = dtServiceAssign.Rows[0]["Service_ID"].ToString();



                            string json = JsonConvert.SerializeObject(Reg, Formatting.Indented);


                            long intM_Consumer_MCOde = Business9420.function9420.InsertCodeChecked(Reg); // doing entry in Pro_Enq tabgle (PROC_InsertProductInquery)

                            Business9420.function9420.UpdateUse_CountM_Code(Reg);// update [Use_Count] =0 in M_Code
                            ProjectSession.strMobileNo = Reg.Mobile_No;
                            ProjectSession.intM_Consumer_MCOde = intM_Consumer_MCOde;
                            Reg.intM_Consumer_MCOde = intM_Consumer_MCOde;


                            try
                            {
                                DataRow[] drw = dtServiceAssign.Select("Service_id = 'SRV1023'");
                                //////////////Comment by sandeep 040620///////////////

                            }
                            catch (Exception ex)
                            {
                                ex.StackTrace.ToString();
                                //throw ex.Message.ToString();
                            }




                            if (Dial_Mode.ToLower() == "website" || Dial_Mode.ToLower() == "qr code" || Dial_Mode.ToLower() == "barcode")
                            {
                                strSeperator = "<br/><br/>";
                            }
                            else
                            {
                                strSeperator = "*";
                            }


                            string strReturnMSG = string.Empty;
                            // string pro = "Congrats!!  You Won " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString();
                            string addition = "Congrats!!  You Won";
                            string pro = "";
                            // Get Return message from Template Msg Table i.e 
                            DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
                            //bool Status = false;
                            for (int i = 0; i < dtServiceAssign.Rows.Count; i++)
                            {
                                if (i > 0)
                                    result = result + strSeperator;
                                #region
                                string stServiceid = dtServiceAssign.Rows[i]["Service_ID"].ToString();
                                DataRow[] dr = dtServiceAssign.Select("Service_id = '" + stServiceid + "'");

                                if (stServiceid == "SRV1018") //COUNTERFIETING
                                {
                                    DataView dv = MsgTempdt.DefaultView;
                                    // Add sms Tej----------- AC 
                                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                    {
                                        dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 416";

                                        //The product you have purchased is an authentic product of <CMPNAME> with security code <CODE1><CODE2>. visit www.vcqru.com for more info

                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 416");
                                        if (strReturnMSG.Contains("<CODE1>"))
                                        {
                                            strReturnMSG = strReturnMSG.Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                        }
                                        if (strReturnMSG.Contains("<CMPNAME>"))
                                        {
                                            strReturnMSG = strReturnMSG.Replace("<CMPNAME>", CompName);
                                        }
                                        SendSmsfromknowlarity(strReturnMSG, Reg.Mobile_No, "1007834160145962028");
                                    }
                                    // Add clos sms Tej----------- AC 

                                    if (CompName == "PATANJALI  FOODS  LIMITED")
                                    {

                                        DataTable DTMSN = SQL_DB.ExecuteDataTable("EXEC USP_Getexpdatepfl '" + Reg.Received_Code1 + "','" + Reg.Received_Code2 + "'");
                                        if (DTMSN.Rows.Count > 0)
                                        {
                                            string manufacturedDate = DateTime.Parse(DTMSN.Rows[0]["Manufactured_date"].ToString()).ToString("dd/MM/yyyy");
                                            string expiryDate = DateTime.Parse(DTMSN.Rows[0]["Expiry_date"].ToString()).ToString("dd/MM/yyyy");
                                            result = "Congratulations! You've bought a genuine <product name> from Patanjali.</br> manufacturing date: " + manufacturedDate + " </br> expiration date: " + expiryDate + " ";
                                        }
                                        else
                                        {
                                            result = "Congratulations! You've bought a genuine <product name> from Patanjali.";
                                        }
                                        if (!IsSameLocation)
                                            result = result + "| This code has been verified from different location.";
                                        result = result.Replace("<product name>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString());
                                        result = result.Replace("<br/><br/>", "");
                                    }

                                }

                                #endregion
                            }


                            #endregion
                        }
                        else
                        {
                            if (CompName == "PATANJALI  FOODS  LIMITED")
                            {

                                DataTable DTMSN = SQL_DB.ExecuteDataTable("EXEC USP_Getexpdatepfl '" + Reg.Received_Code1 + "','" + Reg.Received_Code2 + "'");
                                if (DTMSN.Rows.Count > 0)
                                {
                                    string manufacturedDate = DateTime.Parse(DTMSN.Rows[0]["Manufactured_date"].ToString()).ToString("dd/MM/yyyy");
                                    string expiryDate = DateTime.Parse(DTMSN.Rows[0]["Expiry_date"].ToString()).ToString("dd/MM/yyyy");
                                    result = "Congratulations! You've bought a genuine <product name> from Patanjali.</br> manufacturing date: " + manufacturedDate + " </br> expiration date: " + expiryDate + " ";
                                }
                                else
                                {
                                    result = "Congratulations! You've bought a genuine <product name> from Patanjali.";
                                }
                                if (!IsSameLocation)
                                    result = result + "| This code has been verified from different location.";
                                result = result.Replace("<product name>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString());
                                result = result.Replace("<br/><br/>", "");
                            }

                        }
                    }
                }
            }
            else if (IsCheckedUse_Count && Use_Count >= 3 && Use_Count < 5 && Reg.Comp_ID.ToString() == "Comp-1693")
            {

                Reg.Is_Success = 2;
                if (dsres.Tables[0].Rows.Count > 0)
                {
                    if (dsServicesAssign.Tables.Count <= 2)
                    {
                        dtServiceAssign = dsServicesAssign.Tables[0];
                        dtTotalCodesCount = dsServicesAssign.Tables[1];

                        if (dtServiceAssign.Rows.Count > 0)
                        {
                            #region Loop in service
                            CompName = dsres.Tables[0].Rows[0]["Comp_Name"].ToString();


                            //** Added for Instant payout
                            string Comp_ID = dtServiceAssign.Rows[0]["Comp_ID"].ToString();

                            Assinservice = dtServiceAssign.Rows[0]["Service_ID"].ToString();



                            string json = JsonConvert.SerializeObject(Reg, Formatting.Indented);

                            long intM_Consumer_MCOde = Business9420.function9420.InsertCodeChecked(Reg); // doing entry in Pro_Enq tabgle (PROC_InsertProductInquery)





                            try
                            {
                                DataRow[] drw = dtServiceAssign.Select("Service_id = 'SRV1023'");
                                //////////////Comment by sandeep 040620///////////////

                            }
                            catch (Exception ex)
                            {
                                ex.StackTrace.ToString();
                                //throw ex.Message.ToString();
                            }




                            if (Dial_Mode.ToLower() == "website" || Dial_Mode.ToLower() == "qr code" || Dial_Mode.ToLower() == "barcode")
                            {
                                strSeperator = "<br/><br/>";
                            }
                            else
                            {
                                strSeperator = "*";
                            }


                            string strReturnMSG = string.Empty;
                            // string pro = "Congrats!!  You Won " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString();
                            string addition = "Congrats!!  You Won";
                            string pro = "";
                            // Get Return message from Template Msg Table i.e 
                            DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
                            //bool Status = false;
                            for (int i = 0; i < dtServiceAssign.Rows.Count; i++)
                            {
                                if (i > 0)
                                    result = result + strSeperator;
                                #region
                                string stServiceid = dtServiceAssign.Rows[i]["Service_ID"].ToString();
                                DataRow[] dr = dtServiceAssign.Select("Service_id = '" + stServiceid + "'");

                                if (stServiceid == "SRV1018") //COUNTERFIETING
                                {
                                    DataView dv = MsgTempdt.DefaultView;
                                    // Add sms Tej----------- AC 
                                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                                    {
                                        dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 416";

                                        //The product you have purchased is an authentic product of <CMPNAME> with security code <CODE1><CODE2>. visit www.vcqru.com for more info

                                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 416");
                                        if (strReturnMSG.Contains("<CODE1>"))
                                        {
                                            strReturnMSG = strReturnMSG.Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                                        }
                                        if (strReturnMSG.Contains("<CMPNAME>"))
                                        {
                                            strReturnMSG = strReturnMSG.Replace("<CMPNAME>", CompName);
                                        }
                                        SendSmsfromknowlarity(strReturnMSG, Reg.Mobile_No, "1007834160145962028");
                                    }
                                    // Add clos sms Tej----------- AC 

                                    if (CompName == "PATANJALI  FOODS  LIMITED")
                                    {

                                        result = "The code scan limit has been exceeded.Kindly contact the support team at 7353000903.";
                                        if (!IsSameLocation)
                                            result = result + "| This code has been verified from different location.";
                                        result = result.Replace("<product name>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString());
                                        result = result.Replace("<br/><br/>", "");
                                    }

                                }

                                #endregion
                            }


                            #endregion
                        }
                        else
                        {
                            if (CompName == "PATANJALI  FOODS  LIMITED")
                            {

                                DataTable DTMSN = SQL_DB.ExecuteDataTable("EXEC USP_Getexpdatepfl '" + Reg.Received_Code1 + "','" + Reg.Received_Code2 + "'");
                                if (DTMSN.Rows.Count > 0)
                                {
                                    string manufacturedDate = DateTime.Parse(DTMSN.Rows[0]["Manufactured_date"].ToString()).ToString("dd/MM/yyyy");
                                    string expiryDate = DateTime.Parse(DTMSN.Rows[0]["Expiry_date"].ToString()).ToString("dd/MM/yyyy");
                                    result = "Congratulations! You've bought a genuine <product name> from Patanjali.</br> manufacturing date: " + manufacturedDate + " </br> expiration date: " + expiryDate + " ";
                                }
                                else
                                {
                                    result = "Congratulations! You've bought a genuine <product name> from Patanjali.";
                                }
                                if (!IsSameLocation)
                                    result = result + "| This code has been verified from different location.";
                                result = result.Replace("<product name>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString());
                                result = result.Replace("<br/><br/>", "");
                            }

                        }
                    }
                }
            }
            #endregion
            else if (IsCheckedUse_Count)
            {
                string strReturnMSG = string.Empty;
                CompName = dsres.Tables[0].Rows[0]["Comp_Name"].ToString();
                Reg.Is_Success = 2;
                DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
                DataView dv = MsgTempdt.DefaultView;

                #region Added by BIpin for yamuna  Entry in pro_enq table 
                if (CompName == "YAMUNA INTERIORS PRIVATE LIMITED" || CompName == "Yamuna Interiors Pvt Ltd G")
                {
                    DataTable dtInx = SQL_DB.ExecuteDataTable("select Enq_Date,MobileNo from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "'");
                    if (dtInx.Rows.Count < 2)
                    {
                        Reg.Is_Success = 1;
                        Business9420.function9420.InsertCodeChecked(Reg);
                        result = "<div><img src='../assets/fonts/icon-original.svg' class='original'></div><strong><p>The product you have purchased is an authentic product of Black cobra.</p></strong>";
                        return result;
                    }
                    else
                    {
                        Business9420.function9420.InsertCodeChecked(Reg);
                    }
                    
                }
                else
                {
                    Business9420.function9420.InsertCodeChecked(Reg); //bipin
                }
                #endregion


                // Add sms Tej ----------- Already
                //The code<CODE1>< CODE2 > is already checked and benefits are availed. Please contact 7128671286 for further information. www.vcqru.com
                if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                {


                    if (CompName == "RANDHAWA SWEETS" || CompName == "FOREVER NUTRITION" || CompName == "PARAG MILK FOODS")
                    {
                        //result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 139").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                        //result = strReturnMSG.Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                        //#region// TemplateId for Already used
                        //SendSmsfromknowlarity(strReturnMSG, Reg.Mobile_No, "1007153356479447662");
                        //return result;
                        //#endregion;
                        //strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'Already' and MsgType = 414");

                        #region// TemplateId for Already used
                        string msg = "The Authenticity of the Product with code <CODE1><CODE2> is already verified. For any help please call on 7535000903. www.vcqru.com";
                        strReturnMSG = msg.Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                        ServiceLogic.SendSmsfromknowlarity(strReturnMSG, Reg.Mobile_No, "1007153356479447662");
                        return result;
                        #endregion;

                    }
                    else
                    {
                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'Already' and MsgType = 414");
                    }

                    result = strReturnMSG.Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                    #region// TemplateId for Already used
                    SendSmsfromknowlarity(strReturnMSG, Reg.Mobile_No, "1007472135095850470");
                    return result;
                    #endregion;
                }
                // Add close sms Tej ----------- Already 


               

                // Business9420.function9420.InsertCodeChecked(Reg);
                if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "MAHINDRA AND MAHINDRA LTD")
                {
                    if (dsServicesAssign.Tables[0].Rows.Count > 0)
                    {
                        if (dsServicesAssign.Tables[0].Rows[0]["Service_id"].ToString() == "SRV1005")
                        {

                            if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                            {
                                result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'All' and MsgType = 75").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                            }
                            else
                            {
                                result += "Coupon CODE " + Reg.Received_Code1 + Reg.Received_Code2 + " is already verified & benefits availed. For more info visit https://www.vcqru.com/assets/images/pdf/FAQ.pdf";
                            }




                        }
                        else if (dsServicesAssign.Tables[0].Rows[0]["Service_id"].ToString() == "SRV1018")
                        {
                            //result += dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with code1-" + Reg.Received_Code1 + " code2-" + Reg.Received_Code2 + " has already been checked before. Kindly purchase a fresh bucket. for customer support contact at 9243029420 Thanks VCQRU. ";
                            //result += "This product code " + Reg.Received_Code1 + Reg.Received_Code2 + " has already been checked before.If you have purchased a fresh pack and have any query kindly contact at 9243029420 or visit www.vcqru.com";
                            result += "Coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " is already verified. For more info visit https://www.vcqru.com/assets/images/pdf/FAQ.pdf";
                        }
                        else
                        {
                            result += dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with code1-" + Reg.Received_Code1 + " code2-" + Reg.Received_Code2 + " has already been checked before. Kindly purchase a fresh bucket. for customer support contact at 9243029420 Thanks VCQRU. ";

                        }
                    }//string smsBodyMsg = dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with code1-" + Reg.Received_Code1 + " code2-" + Reg.Received_Code2 + " has already been checked before. Kindly purchase a fresh bucket. for customer support contact at 0124-4001928 Thanks VCQRU. ";
                    //ServiceLogic.SendSMSFromAlfa(Reg.Mobile_No, smsBodyMsg);
                }
                else if (CompName == "PATANJALI  FOODS  LIMITED")
                {
                    //result += "Your purchased product " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is Genuine. Mfd by " + CompName + "    Tnx SKS Nutritions";
                    result = "The authenticity of this product <product name> is already verifed, Kindly contact the support team at 7353000903.";
                    result = result.Replace("<product name>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString());
                    result = result.Replace("<br/><br/>", "");
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "HANNOVER CHEMIKALIEN PRIVATE LIMITED")
                {
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1029' and MsgType = 126").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "SRI ANANTHA PADMANABHA SWAMY ENTERPRISES")
                {
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1029' and MsgType = 141").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToLower() == "1 STOP NUTRITION")
                {
                    //result += "The product with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is already checked. If you have purchased a product with unscratched label, contact the manufacturer.   Tnx SKS Nutritions";
                    result += "Coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " is already verified. For more info visit https://www.vcqru.com/assets/images/pdf/FAQ.pdf";
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToLower() == "1 stop nutrition")
                {
                    //result += "The product with Code " + Reg.Received_Code1 + " - " + Reg.Received_Code2 + " is already checked. If you have purchased a product with unscratched label, contact the manufacturer.   Tnx SKS Nutritions";
                    result += "Coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " is already verified. For more info visit https://www.vcqru.com/assets/images/pdf/FAQ.pdf";
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "UNIGLOBAL DISTRIBUTORS PRIVATE LIMITED")
                {

                    if (Reg.Dial_Mode == "SMS")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'All' and MsgType = 75").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else
                    {
                        result += "This product code " + Reg.Received_Code1 + Reg.Received_Code2 + " has already been checked before. If you have any query kindly contact at 9243029420 or visit www.vcqru.com ";
                    }



                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Competent Electricals India")
                {
                    DataSet ds = SQL_DB.ExecuteDataSet("select * from dbo.Pro_Enq where MobileNo='" + strMobileNo + "' and Received_Code1='" + Reg.Received_Code1 + "' AND Received_Code2 = '" + Reg.Received_Code2 + "' and is_success=1");

                    ////////////////////////////////////////////////
                    if (dsServicesAssign.Tables[0].Rows.Count > 0)
                    {
                        if (dsServicesAssign.Tables[0].Rows[0]["Service_id"].ToString() == "SRV1001")
                        {
                            if (Reg.Dial_Mode == "SMS")
                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 7");
                            else
                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 9");
                            result = result + (strReturnMSG.Replace("<cash>", "").Replace("<ProductName>", "").Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                        }

                        else
                        {
                            if (ds.Tables[0].Rows.Count > 0)
                            {
                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1018' and MsgType =9", CompName);
                            }
                            else
                            {
                                strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, " Service_ID = 'SRV1018' and MsgType = 8", CompName);
                            }
                            //result = result + (strReturnMSG.Replace("<cash>", "").Replace("<ProductName>", "").Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                            //result = result + "THE PRODUCT WITH CODE 1 - " + Reg.Received_Code1 + " AND CODE2 - " + Reg.Received_Code2 + " IS GENEUIN. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN IT CAN BE CHECKED/PROCESS FURTHER.";

                            result = result + (strReturnMSG.Replace("<cash>", "").Replace("<ProductName>", "").Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
                            //result = result + "THE PRODUCT WITH CODE 1 - " + Reg.Received_Code1 + " AND CODE2 - " + Reg.Received_Code2 + " HAS ALREADY BEEN CHECKED BEFORE. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN IT CAN BE CHECKED/PROCESS FURTHER.";
                        }

                    }


                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "MYSHA HEALTH WORLD")
                {

                    if (Reg.Dial_Mode == "SMS")
                    {
                        dv.RowFilter = "Service_ID = 'Already' and MsgType = 2";
                    }
                    else
                    {
                        dv.RowFilter = "Service_ID = 'Already' and MsgType = 1";
                    }
                    DataTable fdt = dv.ToTable();
                    result += fdt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);


                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "JPH PUBLICATIONS PVT. LTD")
                {
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 13");
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "GRIH PRAWESH MARKETING COMPANY")
                {
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 18").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Delta Luminaries" && dsServicesAssign.Tables[0].Rows[0]["Service_id"].ToString() == "SRV1023")
                {
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1023' and MsgType = 12");
                    string expDate = SQL_DB.ExecuteScalar("select isnull(ExpirationDate,0) ExpirationDate from [WarrentyDetails] where Code='" + Reg.Received_Code1 + "-" + Reg.Received_Code2 + "'").ToString();
                    if (expDate != "0")
                    {
                        expDate = Convert.ToDateTime(expDate).ToString("dd/MM/yyyy");
                        result = result.Replace("<EXPIRY>", expDate);
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "COATS BATH FITTINGS")
                {
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 12").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Indian Plywood Company")
                {
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 143").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Helix")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 58").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else
                    {
                        result = "“The Code is already verified but the product you have purchased is an Authentic Product of Helix India, to check another code <a href='../Helix.aspx'>Click Here</a>.";
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Muscle Garage")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 58").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else
                    {
                        result = "“The Code is already verified but the product you have purchased is an Authentic Product of Muscle Garage, to check another code <a href='../musclegarage.aspx'>Click Here</a>.";
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "MAHAVIR PAINTS AND ADHESIVES")
                {
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 145").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "SHERKOTTI INDUSTRIES PRIVATE LIMITED")
                {
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1029' and MsgType = 157").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                }
                else if (CompName == "PROQUEST NUTRITION PRIVATE LIMITED")
                {
                    DataTable jpcdt1 = new DataTable();
                    jpcdt1 = SQL_DB.ExecuteDataTable("select count(1) TotalCount from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "'");

                    if (Convert.ToInt32(jpcdt1.Rows[0]["TotalCount"].ToString()) <= 5)
                    {
                        dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 1";

                        DataTable f_dt = dv.ToTable();
                        result += "The Code is already verified but the product you have purchased is an Proquest Nutrition Pvt Ltd<br>   <center> to check another code <a href='https://www.proquest.fit/check-authenticity' style='color: white;'>Click Here</a></center>";
                        // result += "Congratulations!! You have purchased an Authentic product from Avvatar India.";

                    }
                    else
                    {
                        //DataTable jpcdt = new DataTable();
                        //jpcdt = SQL_DB.ExecuteDataTable("select  top  1 Enq_Date from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=1 order by 1");
                        result = "This code has already been verified.<br>   <center> to check another code <a href='https://www.proquest.fit/check-authenticity' style='color: white;'>Click Here</a></center>";
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "CHERYL CHEMICAL AND POLYMERS")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1020' and MsgType = 75 ").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }

                    else
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 420").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "TRUE NUTRITION PERFORMANCE PRIVATE LIMITED")
                {
                    DataTable jpcdt1 = new DataTable();
                    jpcdt1 = SQL_DB.ExecuteDataTable("select count(1) TotalCount from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "'");

                    if (Convert.ToInt32(jpcdt1.Rows[0]["TotalCount"].ToString()) <= 7)
                    {
                        dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 1";

                        DataTable f_dt = dv.ToTable();
                        result += "The Code is already verified but the product you have purchased is an Authentic Product of True Nutrition Performance<br>   <center> to check another code <a href='https://www.vcqru.com/TrueNutrition.aspx' style='color: white;'>Click Here</a></center>";
                        // result += "Congratulations!! You have purchased an Authentic product from Avvatar India.";

                    }
                    else
                    {
                        //DataTable jpcdt = new DataTable();
                        //jpcdt = SQL_DB.ExecuteDataTable("select  top  1 Enq_Date from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=1 order by 1");
                        result = "This code has already been verified.<br>   <center> <br>to check another code <a href='https://www.vcqru.com/TrueNutrition.aspx' style='color: white;'>Click Here</a></center>";
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Fit Fleet")
                {
                    DataTable dtnutra = new DataTable();
                    DataTable Constbl = new DataTable();
                    dtnutra = SQL_DB.ExecuteDataTable("select Enq_Date,MobileNo from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=1 ");
                    string MobNo = dtnutra.Rows[0][1].ToString();
                    Constbl = SQL_DB.ExecuteDataTable("select ConsumerName from M_Consumer where right(MobileNo,10)='" + MobNo.Substring(MobNo.Length - 10, 10).ToString() + "' ");
                    // result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 49").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<DRDT>", dtnutra.Rows[0][0].ToString()).Replace("<MOBILE>", dtnutra.Rows[0][1].ToString()); ;
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 58").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else
                    {
                        result = "<b>The Code is already verified but the product you have purchased is an Authentic Product of Fit Fleet.</b>";
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "FITSIQUE")
                {
                    DataTable dtnutra = new DataTable();
                    DataTable Constbl = new DataTable();
                    dtnutra = SQL_DB.ExecuteDataTable("select Enq_Date,MobileNo from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=1 ");
                    string MobNo = dtnutra.Rows[0][1].ToString();
                    Constbl = SQL_DB.ExecuteDataTable("select ConsumerName from M_Consumer where right(MobileNo,10)='" + MobNo.Substring(MobNo.Length - 10, 10).ToString() + "' ");
                    // result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 49").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<DRDT>", dtnutra.Rows[0][0].ToString()).Replace("<MOBILE>", dtnutra.Rows[0][1].ToString()); ;
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 58").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else
                    {
                        result = "The Code is already verified,<br> to check another code  <a href='https://fitsique.in/authenticate/'>Click Here</a>.";
                    }
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Veena Polymers")
                {

                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'All' and MsgType = 75").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 12").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }


                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "SAFFRO MELLOW COATINGS AND RESINS")
                {
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 123").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "BENITTON BATHWARE")
                {
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 125").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "R.S Industries")
                {
                    result = "This code has already been checked and benefits availed but the product you have purchased is an Authentic Product of POLYTUF.";
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "ALSTONE INDUSTRIES PVT. Ltd REYNOBOND")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'All' and MsgType = 75").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                    }
                    else
                    {
                        result = "This code has already been verified and benefits are availed, kindly buy another ALSTONE product for more benefits.";
                    }


                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "MARMO SOLUTIONS PRIVATE LIMITED")
                {
                    if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                    {
                        result = "This code has already been verified and benefits are availed, kindly buy another MARMO Solutions product for more benefits.";
                    }
                    else if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'Already' and MsgType = 75").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else
                    {
                        result = "<b>This code has already been verified and benefits are availed, kindly buy another MARMO Solutions product for more benefits.</b>";
                    }

                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "RAUNAQ PAINT INDUSTRY")
                {
                    if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                    {
                        result = "This code has already been verified and benefits are availed, kindly buy another Surface Paints product for more benefits.";
                    }
                    else if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'All' and MsgType = 75").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else
                    {
                        result = "<b>This code has already been verified and benefits are availed, kindly buy another Surface Paints product for more benefits. <br> <br> <p> To check another code <a href='https://www.vcqru.com/raunaq.aspx?ID=1'> Click here</a></p>";
                    }
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "HERBAL AYURVEDA AND RESEARCH CENTER")
                {
                    result = "<b>This code has already been verified and benefits are availed, kindly buy another Exotic Leaf product for more benefits.</br>To Check Another Code <a style='color: blue;' href='https://www.vcqru.com/herbal.aspx'>Click Here</a>";
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "BSC Paints Pvt Ltd")
                {
                    if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                    {
                        result = "यह कोड पहले ही सत्यापित किया जा चुका है और लाभ प्राप्त किए जा चुके हैं, कृपया अधिक लाभ के लिए अन्य उत्पाद खरीदें. This code has already been verified and benefits are availed, kindly purchase another product for more benefits";
                    }
                    else if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'All' and MsgType = 75").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else
                    {
                        result = "<b>यह कोड पहले ही सत्यापित किया जा चुका है और लाभ प्राप्त किए जा चुके हैं, कृपया अधिक लाभ के लिए अन्य उत्पाद खरीदें. <br> <br> This code has already been verified and benefits are availed, kindly purchase another product for more benefits <br> <br> <p> To check another code <a href='https://www.vcqru.com/bscpaint.aspx'><button> Click here</button></a></p>";
                    }
                }


                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Color Valley Coatings")
                {
                    if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                    {
                        result = "This code has already been verified and benefits are availed, kindly buy another color valley product for more benefits.";
                    }
                    else if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1024' and MsgType = 64").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else
                    {
                        result = "<b>This code has already been verified and benefits are availed, kindly buy another COLOR VALLEY product for more benefits.";
                    }

                }


                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Jupiter Aqua Lines Ltd")
                {

                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'All' and MsgType = 75").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;

                    }
                    else
                    {
                        result = "This code has already been checked and benefits availed but the product you have purchased is an Authentic Product of JAL.";
                    }


                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "OCI Wires and Cables")
                {
                    if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                    {
                        result = "This code has already been checked and benefits availed but the product you have purchased is an Authentic Product of OCI KABLE.";
                    }
                    else if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = "This code is already checked and the product is genuine. Visit www.vcqru.com for more info or for any query call " + 7291999420;
                    }
                    else
                    {
                        result = "<b>The product you have purchased is an Authentic product of OCI  Wires and Cables. You have already claimed the points.</br></br><a href='https://www.vcqru.com/login.aspx'> Click for Claim</a>";
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "SPORTECH SOLUTIONS")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 58").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                    {
                        result = "This code has been already verified.";
                    }
                    else
                    {
                        result = "<b>This code has been already verified. <br/> To Check Another Code <a href='https://thevitamin.co/pages/authenticate'> Click Here <a/>";
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "RELX INDIA PRIVATE LIMITED")
                {
                    if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                    {
                        result = "Thanks for submitting the details.";
                    }
                    else
                    {
                        result = "<b>Thanks for submitting the details. <br/>";
                    }
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "MANGAL DASS TRADING CO")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 58").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                    {
                        result = "This code has been already verified.";
                    }
                    else
                    {
                        result = "<b>This code has been already verified. <br/> To Check Another Code<a href='https://www.vcqru.com/Nicolt.aspx'>Click Here<a/>";
                    }
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Gupta edutech Delhi")
                {
                    DataTable jpcdt1 = new DataTable();
                    jpcdt1 = SQL_DB.ExecuteDataTable("select count(1) TotalCount from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "'");

                    if (Convert.ToInt32(jpcdt1.Rows[0]["TotalCount"].ToString()) < 21)
                    {
                        dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 109";
                        DataTable f_dt = dv.ToTable();
                        result += f_dt.Rows[0]["MsgBody"].ToString();
                    }
                    else
                    {
                        result = "This copy seems to be a duplicate copy.please fill below details to serve you better <br> To Check Another Code <a href='https://www.vcqru.com/blackbook.html'>Click Here</a>";
                    }
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "SWARAJ")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 58").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 65").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 56").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }


                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "TESLA POWER INDIA PRIVATE LIMITED")
                {
                    result = "</b>This coupon has already been verified and benefits are already availed.</br>इस कूपन को पहले ही सत्यापित किया जा चुका है और लाभ पहले ही उठाया जा चुका है। </br></br> To login/ check /claim wallet balance <a href=\"https://www.vcqru.com/teslalogin.aspx\">click here</a>";
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "YAMUNA INTERIORS PRIVATE LIMITED" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Yamuna Interiors Pvt Ltd G")
                {
                    DataTable dtInx = SQL_DB.ExecuteDataTable("select Enq_Date,MobileNo from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "'");
                    if (dtInx.Rows.Count < 2)
                    {
                        result = "<div><img src='../assets/fonts/icon-original.svg' class='original'></div><strong><p>The product you have purchased is an authentic product of Black cobra.</p></strong>";
                        return result;
                    }
                    else
                    {
                        result = "<strong><p>The product purchase is authentic, the code is already verified.</p></strong>";
                    }

                }

                //else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Ram Gopal and Sons")
                //{
                //    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 116").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                //}
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Cosmo Tech Expo")
                {
                    result = "<b> This code has already been verified Thanks VCQRU PVT Ltd";
                }

                #region  for the different message of the Ramgopal

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Ram Gopal and Sons")
                {
                    DataTable rmdt = new DataTable();
                    rmdt = SQL_DB.ExecuteDataTable("select count(Is_Success) TotalCount from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "'and Is_Success=2");

                    if (Convert.ToInt32(rmdt.Rows[0]["TotalCount"].ToString()) == 1)
                    {
                        result = "<b>Congratulations! You have purchased a GENUINE EAGLE'S product.</a>";
                    }
                    else if (Convert.ToInt32(rmdt.Rows[0]["TotalCount"].ToString()) == 2)
                    {
                        result = "<b>Your code has already been verified.</a>";
                    }
                    else if (Convert.ToInt32(rmdt.Rows[0]["TotalCount"].ToString()) == 3)
                    {
                        result = "<b>The authenticity of your product cannot be guaranteed</a>";
                    }
                    else
                    {
                        result = "<b>Counterfeit Product<br>Fake Product<br>Duplicate Product<br>Sahte ürün<br>منتج مزيف<br>Please contact us through Whatsapp +91 9650056956";
                    }
                }
                #endregion

                //else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Ram Gopal and Sons")
                //{
                //    result = result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 116");
                //}
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Wellversed Health Pvt Ltd")
                {
                    result = "This code has been already verified. ";
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "1 STOP NUTRITION")
                {
                    result = "Oops! This verification code has already been verified. <br> To Check Another Code <a href='https://www.vcqru.com/1stop.aspx'>Click Here</a>";

                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "FOREVER NUTRITION")
                {

                    DataTable dtInx = new DataTable();
                    dtInx = SQL_DB.ExecuteDataTable("select Enq_Date,pe.MobileNo,mc.ConsumerName from Pro_Enq pe inner join M_Consumer mc on mc.MobileNo=pe.MobileNo where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=1 ");
                    result = "<b>Oops! This verification code has already been verified by " + dtInx.Rows[0]["ConsumerName"].ToString() + " on " + dtInx.Rows[0]["Enq_Date"].ToString() + ".</br> To Verify Another Product <a href='https://trueforma.in/authenticate/'> Click Here <a/>";

                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "RSR Resource")
                {
                    DataTable dtnutra = new DataTable();
                    DataTable Constbl = new DataTable();
                    dtnutra = SQL_DB.ExecuteDataTable("select Enq_Date,MobileNo from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=1 ");
                    string MobNo = dtnutra.Rows[0][1].ToString();
                    Constbl = SQL_DB.ExecuteDataTable("select ConsumerName from M_Consumer where right(MobileNo,10)='" + MobNo.Substring(MobNo.Length - 10, 10).ToString() + "' ");

                    result = "Your product Muscle Mountain " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + "  has already been registered and verified by " + Constbl.Rows[0][0].ToString() + " on " + dtnutra.Rows[0][0].ToString() + ".</br></br>";
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "MUSCLE PUNCH SUPPLEMENTS")
                {
                    DataTable dtnutra = new DataTable();
                    DataTable Constbl = new DataTable();
                    dtnutra = SQL_DB.ExecuteDataTable("select Enq_Date,MobileNo from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=1 ");
                    string MobNo = dtnutra.Rows[0][1].ToString();
                    Constbl = SQL_DB.ExecuteDataTable("select ConsumerName from M_Consumer where right(MobileNo,10)='" + MobNo.Substring(MobNo.Length - 10, 10).ToString() + "' ");
                    // result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 49").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<DRDT>", dtnutra.Rows[0][0].ToString()).Replace("<MOBILE>", dtnutra.Rows[0][1].ToString()); ;
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 58").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else
                    {
                        result = "Your product MUSCLE PUNCH " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + " has already been registered and verified by " + Constbl.Rows[0][0].ToString() + " on " + dtnutra.Rows[0][0].ToString() + ".";
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Big Daddy Overseas")
                {
                    DataTable dtnutraBigD = new DataTable();
                    dtnutraBigD = SQL_DB.ExecuteDataTable("select Enq_Date,MobileNo from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=1 ");
                    // result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 49").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<DRDT>", dtnutra.Rows[0][0].ToString()).Replace("<MOBILE>", dtnutra.Rows[0][1].ToString()); ;
                    result = "This code has already been verified on " + dtnutraBigD.Rows[0][0].ToString() + ". <br> To Check Another Code <a href='https://vcqru.com/bigdaddy.html'>Click Here</a> ";
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "RANDHAWA SWEETS")
                {
                    DataTable dtnutra = new DataTable();
                    DataTable Constbl = new DataTable();
                    dtnutra = SQL_DB.ExecuteDataTable("select Enq_Date,MobileNo from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=1 ");
                    string MobNo = dtnutra.Rows[0][1].ToString();
                    Constbl = SQL_DB.ExecuteDataTable("select ConsumerName from M_Consumer where right(MobileNo,10)='" + MobNo.Substring(MobNo.Length - 10, 10).ToString() + "' ");
                    // result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 49").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<DRDT>", dtnutra.Rows[0][0].ToString()).Replace("<MOBILE>", dtnutra.Rows[0][1].ToString()); ;
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 58").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else
                    {
                        result = "“This code has already been verified, to check another code <a href='https://www.randhawasweets.com/authenticity/'>Click Here</a>.";
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Muscle Fighter Nutrition")
                {
                    DataTable dtCount = SQL_DB.ExecuteDataTable("select Count(row_id) Total from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=2 ");
                    int TotalCount = Convert.ToInt32(dtCount.Rows[0]["Total"].ToString()) + 1;

                    if (TotalCount <= 10)
                    {

                        result = "The Code is already verified but the product you have purchased is an Authentic product of muscle fighter India.<br> To Check Another Code <a href='https://musclefighternutrition.com/authenticity'>Click Here</a>";
                    }
                    else
                    {
                        //result = "Your product Muscle Mountain " + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + "  has already been registered and verified by " + Constbl.Rows[0][0].ToString() + " on " + dtnutra.Rows[0][0].ToString() + ".</br></br>To Check Another Code<a href='https://musclemountain.com/pages/authenticity'>Click Here</a>";
                        result = "The code can't be authenticated. Please contact our customer support on 7353000903 for help.<br> To Check Another Code <a href='https://musclefighternutrition.com/authenticity'>Click Here</a>";
                    }




                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Paras cosmetics private limited")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'Already' and MsgType = 2").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                        //result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'Already' and MsgType = 414").Replace("{#var#}", Reg.Received_Code1 + Reg.Received_Code2);
                    }
                    else
                    {
                        result = "This code has already been verified, <br> to check another code <a href='https://vcqru.com/aromacare.aspx' style='color:blue;'>click here</a>";
                    }

                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "SKYDECOR LAMINATES PRIVATE LIMITED")
                {
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 14").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "EVERCROP AGRO SCIENCE")
                {
                    if (GerserviceId == "SRV1018" && (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR"))
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 18").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else if (GerserviceId == "SRV1018" && (Reg.Dial_Mode == "WebSite" || Reg.Dial_Mode == "QR code"))
                    {
                        result = "यह कोड पहले ही सत्यापित किया जा चुका है|";
                    }
                    else
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 18").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }

                    // result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 18").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Oltimo Lubes")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1020' and MsgType = 2 ").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }

                    else
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 92").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "VCQRU")
                {
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1029' and MsgType = 155").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "DURGA COLOUR AND CHEM.P LTD.")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType =58 ").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }

                    else
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 152").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "PRINCIPLE ADHESIVES PRIVATE LIMITED")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType =58 ").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }

                    else
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 159").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "BLUEGEM PAINTS")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType =58 ").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }

                    else
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 103").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "MIDAS TOUCH METALLOYS PRIVATE LIMITED")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType =138 ").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }

                    else
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 138").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "NV INFOTECH DOMAIN")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1020' and MsgType = 2").Replace("<code1>", Reg.Received_Code1).Replace("<code2>", Reg.Received_Code2); ;
                    }

                    else
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 90").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "The Kolorado  Paints")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1020' and MsgType = 2").Replace("<code1>", Reg.Received_Code1).Replace("<code2>", Reg.Received_Code2); ;
                    }

                    else
                    {
                        result = "<b>This code has already been verified and benefits are availed, kindly buy another Kolorado Paints product for more benefits.<br/>यह कोड पहले ही सत्यापित किया जा चुका है और लाभ प्राप्त किए जा चुके हैं, अधिक लाभ के लिए कृपया कोई अन्य Kolorado Paints उत्पाद खरीदें <br/> To Check Another Code <a href='https://www.vcqru.com/Kolorado.aspx'> Click Here <a/>";
                    }
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "MITHILA PAINTS PRIVATE LIMITED")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = '' and MsgType = ").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }

                    else
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 118").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "JOHNSON PAINTS CO.")
                {
                    DataTable jpcdt = new DataTable();
                    jpcdt = SQL_DB.ExecuteDataTable("select top 1 createddate, dealerid from enq_dealerid pd inner join Pro_Enq pe on pe.Row_ID = pd.enq_id where pe.Received_Code1 = '" + Reg.Received_Code1 + "' and pe.Received_Code2 = '" + Reg.Received_Code2 + "' and pe.Is_Success=1");
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 10").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<DEALERID>", jpcdt.Rows[0]["dealerid"].ToString()).Replace("<SUCCESSDATE>", jpcdt.Rows[0]["createddate"].ToString());
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Wudchem Industries Private Limited")
                {
                    result = "This code has already been checked and benefits availed but the product you have purchased is an Authentic Product of WUD CHEM INDUSTRIES.";
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Nutramarc Sports")
                {

                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 58").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                    }

                    else
                    {
                        DataTable dtnutra = new DataTable();
                        dtnutra = SQL_DB.ExecuteDataTable("select Enq_Date,MobileNo from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=1 ");
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 40").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<DRDT>", dtnutra.Rows[0][0].ToString()).Replace("<MOBILE>", dtnutra.Rows[0][1].ToString());

                    }



                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Denzour Nutritions" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Denzour Nutrition")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 58").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                    }

                    else
                    {
                        DataTable dtnutra = new DataTable();
                        dtnutra = SQL_DB.ExecuteDataTable("select Enq_Date,MobileNo from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=1 ");
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 49").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<DRDT>", dtnutra.Rows[0][0].ToString()).Replace("<MOBILE>", dtnutra.Rows[0][1].ToString()); ;

                    }


                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "BAGHLA SANITARYWARE")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 58").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                    }
                    else
                        result = "<b>This code has already been verified and benefits are availed, kindly buy another prestige bath fittings product for more benefits.</br>इस कोड को पहले ही सत्यापित किया जा चुका है और लाभ प्राप्त किया जा चुका है, कृपया अधिक लाभ के लिए एक अन्य prestige bath fittings उत्पाद खरीदें। </br></br>To Check Another Code <a href='https://www.vcqru.com/Bhagla.aspx'>Click Here</a>";
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Girish Chemical Industries")
                {
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 111").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Inox Decor Pvt Ltd")
                {
                    DataTable dtInx = new DataTable();
                    dtInx = SQL_DB.ExecuteDataTable("select Enq_Date,MobileNo from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=1 ");
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1001' and MsgType = 41").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2).Replace("<DRDT>", dtInx.Rows[0][0].ToString()).Replace("<MOBILE>", dtInx.Rows[0][1].ToString()); ;
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Yava Paints Pvt. Ltd.")
                {
                    DataTable dtInx = new DataTable();
                    dtInx = SQL_DB.ExecuteDataTable("select Enq_Date,MobileNo from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=2");
                    if (dtInx.Rows.Count > 1)
                    {
                        result = "<b>The Code Is Invalid कोड अमान्य है।.</br>To Check Another Code <a style='color: blue;' href='http://yavapaints.com/yuva-paints.html'>Click Here</a> </br><a href=' https://www.vcqru.com/login.aspx '>Login Here</a>";
                    }
                    else
                    {
                        result = "<b>Oops! This verification code has already been verified.</br>उफ़! यह सत्यापन कोड पहलेही सत्यापि त कि या जा चुका है।.</br>To Check Another Code <a style='color: blue;' href='http://yavapaints.com/yuva-paints.html'>Click Here</a>  </br><a href=' https://www.vcqru.com/login.aspx'>Login Here</a>";
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "SAMSOIL PETROLEUM INDIA LTD")
                {
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 120").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Ambica Cable")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1020' and MsgType = 2 ").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                    }
                    else
                    {
                        result = "<b>sorry you have already scanned code";
                        //result = "<b>This code has already been verified and benefits are availed but the product you have purchased is an Authentic Product of Ambica Cable. </ br></br>To Check Another Code<a href='https://www.ambicacables.com/loyality.html'> Click Here</a> </br><a href='https://www.vcqru.com/login.aspx'>Login Here</a>";
                    }

                }


                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Lubigen Pvt Ltd")
                {
                    if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "MANUAL")
                    {
                        result = "This code has already been verified and benefits are availed, kindly buy another Lubigen product for more benefits.";
                    }
                    else if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = "Coupon" + Reg.Received_Code1 + Reg.Received_Code2 + "is already verifed.For more info visit https://www.vcqru.com/assets/images/pdf/FAQ.pdf ";
                    }

                    else
                    {
                        result = "<b>This code has already been verified and benefits are availed, kindly buy another Lubigen product for more benefits.";
                    }
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Cosmo Tech Expo" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Pack Plus")
                {
                    result = "Already Used Please Try With Another Code.";
                    //string mail = SendMailExibition(Reg.consumer_name, Reg.Email, result);
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "DD NUTRITIONS PRIVATE LIMITED")
                {
                    result = "This Code has already varified but the product you have purchased is an Authentic Product of DD NUTRITIONS PRIVATE LIMITED.  ";
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "ROYAL MANUFACTURER")
                {
                    DataTable jpcdt1 = new DataTable();
                    jpcdt1 = SQL_DB.ExecuteDataTable("select count(1) TotalCount from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "'");

                    if (Convert.ToInt32(jpcdt1.Rows[0]["TotalCount"].ToString()) <= 3)
                    {

                        dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 1";

                        DataTable f_dt = dv.ToTable();

                        result += f_dt.Rows[0]["MsgBody"].ToString().Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>",
                                                            Reg.Received_Code2).Replace("<PRONAME>", dsres.Tables[0].Rows[0]["Pro_Name"].ToString()).Replace("<MRP>",
                                                            dsres.Tables[0].Rows[0]["MRP"].ToString()).Replace("<MFD>",
                                                            Convert.ToDateTime(dsres.Tables[0].Rows[0]["Mfd_Date"]).ToString("MM/yyyy")).Replace("<BTNO>",
                                                            dsres.Tables[0].Rows[0]["Batch_No"].ToString()).Replace("<SMS>",
                                                            dsres.Tables[0].Rows[0]["Comments"].ToString()).Replace("<CMPNAME>",
                                                            dsres.Tables[0].Rows[0]["Comp_Name"].ToString()).Replace("EXP <EXP>", "");

                    }
                    else
                    {
                        result = "Coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " is already verified. For more info visit https://www.vcqru.com/assets/images/pdf/FAQ.pdf";
                    }



                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Black Mango Herbs" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "AMULYA AYURVEDA" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Nutravel Health Care")
                {

                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 58").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                    }

                    else
                    {
                        result = "Coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " is already verified.," + dsres.Tables[0].Rows[0]["Comp_Name"].ToString();

                    }

                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToString() == "Shree Durga Traders")
                {
                    result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1005' and MsgType = 114").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Secure Lifesciences")
                {
                    result = "The code is already verified but the Product you have purchased is an Authentic product of GYMFORD.";
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Ankerite Health Care Pvt. Ltd")
                {
                    result = "This code has already been checked but the product you have purchased is an Authentic Product of Ankerite Health Care Pvt Ltd.";
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Chase2Fit")
                {
                    result = "This code has already been checked but the product you have purchased is an Authentic Product of Chase 2 Fit.";
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "OSR IMPEX")
                {


                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'All' and MsgType = 75").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else
                    {
                        result += "Coupon CODE " + Reg.Received_Code1 + Reg.Received_Code2 + " is already verified & benefits availed. For more info visit https://www.vcqru.com/assets/images/pdf/FAQ.pdf";
                    }
                }


                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "PARAG MILK FOODS")
                {
                    DataTable jpcdt1 = new DataTable();
                    jpcdt1 = SQL_DB.ExecuteDataTable("select count(1) TotalCount from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "'");

                    if (Convert.ToInt32(jpcdt1.Rows[0]["TotalCount"].ToString()) <= 5)
                    {
                        dv.RowFilter = "Service_ID = 'SRV1018' and MsgType = 1";
                        DataTable f_dt = dv.ToTable();
                        result += "Congratulations!! You have purchased an Authentic product from Avvatar India.";
                    }
                    else
                    {
                        DataTable jpcdt = new DataTable();
                        jpcdt = SQL_DB.ExecuteDataTable("select  top  1 Enq_Date from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=1 order by 1");
                        if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                        {
                            // result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'All' and MsgType = 75").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                            // result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 139").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                            // result = strReturnMSG.Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);

                            #region// TemplateId for Already used
                            string msg = "The Authenticity of the Product with code <CODE1><CODE2> is already verified. For any help please call on 7535000903. www.vcqru.com";
                            strReturnMSG = msg.Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                            ServiceLogic.SendSmsfromknowlarity(strReturnMSG, Reg.Mobile_No, "1007153356479447662");
                            return result;
                            #endregion;
                        }
                        else
                        {
                            result = "This Code is already verified on " + jpcdt.Rows[0]["Enq_Date"].ToString() + "";
                        }
                        result = "This Code is already verified on " + jpcdt.Rows[0]["Enq_Date"].ToString() + "";
                    }



                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "SHRI BALAJI OVERSEAS MUSCLE TECH")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'All' and MsgType = 75").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                    }
                    else
                    {
                        result = "This code has already been checked but the product you have purchased is an Authentic Product of MUSCLETECH.";
                    }

                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "VCQRU WE SECURE YOU")
                {
                    //result = "Coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " is already verifed.";
                    result = "You have already registered the warranty of this product with coupon code '" + Reg.Received_Code1 + Reg.Received_Code2 + "'. Please check your e-mail for login ID/password and log into your account to check the warranty. or visit https://www.vcqru.com/login.aspx.";
                }

                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "TNT")
                {
                    //result = "Coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " is already verifed.";
                    result = "You have already registered the warranty of this product with coupon code '" + Reg.Received_Code1 + Reg.Received_Code2 + "'. Please check your e-mail for login ID/password and log into your account to check the warranty. or visit https://www.vcqru.com/login.aspx.";
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "ORBIT ELECTRODOMESTICS INDIA")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        //result = GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID = 'SRV1018' and MsgType = 58").Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2); ;
                        result = "This code has already been verified.";
                    }
                    else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "App_mode" || Reg.Dial_Mode == "MANUAL")
                    {
                        result = "This code has already been verified.";
                    }
                    else
                    {
                        DataTable jpcdt = new DataTable();
                        jpcdt = SQL_DB.ExecuteDataTable("select  top  1 Enq_Date from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "' and Is_Success=1 order by 1");

                        result = "This code has already been verified on " + jpcdt.Rows[0]["Enq_Date"].ToString() + " and the product is already registered for warranty, <br> kindly <a href='https://www.indiaorbit.in/e-warranty'>click here<a/> to  check another product <br> or to claim the warranty <a href='https://qa.vcqru.com/login.aspx'>click here</a>";
                    }
                }
                else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "TECHNICAL MINDS PRIVATE LIMITED")
                {
                    if (Reg.Dial_Mode == "SMS" || Reg.Dial_Mode == "IVR")
                    {
                        result = "This code has already been verified.";
                    }
                    else if (Reg.Dial_Mode == "SCANNER" || Reg.Dial_Mode == "App_mode" || Reg.Dial_Mode == "MANUAL")
                    {
                        result = "This code has already been verified.";
                    }
                    else
                    {
                        result = "This code has already been verified and the product is already registered for warranty, <br>kindly <a href='https://hypersonic.club/e-warranty/hypersonic.html'>click here<a/> to check another code or <br>to claim the warranty <a href='https://www.vcqru.com/login.aspx'>click here</a> <br>यह कोड पहले ही सत्यापित हो चुका है और उत्पाद पहले से ही वारंटी के लिए पंजीकृत है, <br>कृपया किसी अन्य कोड की जांच करने के लिए <a href='https://hypersonic.club/e-warranty/hypersonic.html'>यहां क्लिक<a/> करें या <br>वारंटी का दावा करने के लिए <a href='https://www.vcqru.com/login.aspx'>यहां क्लिक</a> करें.";
                    }
                }

                else
                {
                    result = "Coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " is already verified. For more info visit https://www.vcqru.com/assets/images/pdf/FAQ.pdf";
                    // result = result + "THE PRODUCT WITH CODE 1 - " + Reg.Received_Code1 + " AND CODE2 - " + Reg.Received_Code2 + " HAS ALREADY BEEN CHECKED BEFORE. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN IT CAN BE CHECKED/PROCESS FURTHER.";

                }

                //for (int i = 0; i < dtServiceAssign.Rows.Count; i++)
                //{
                //    if (i > 0) result = result + "<br/>";
                //    string stServiceid = dtServiceAssign.Rows[i]["Service_ID"].ToString();
                //    switch (stServiceid)
                //    {

                //        case "SRV1018":
                //            {
                //                result = result + "THE AUTHENTICITY OF THE PRODUCT WITH CODE 1 " + Reg.Received_Code1 + " AND CODE2 " + Reg.Received_Code2 + " HAS ALREADY BEEN CHECKED BEFORE. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN ITS AUTHENTICITY CAN NOT BE GUARANTEED.";
                //                break;
                //            }
                //        case "SRV1003":
                //            {
                //                result = result + "THE  PRODUCT WITH CODE 1 " + Reg.Received_Code1 + " AND CODE2 " + Reg.Received_Code2 + " HAS ALREADY BEEN CHECKED BEFORE. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN ITS AUTHENTICITY CAN NOT BE GUARANTEED.";
                //                break;
                //            }
                //}
            }
            if (string.IsNullOrEmpty(result))
            {

                DataTable Aldt = new DataTable();
                Aldt = SQL_DB.ExecuteDataTable("select count(1) TotalCount from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "'  and Is_Success=1");

                if (Convert.ToInt32(Aldt.Rows[0]["TotalCount"].ToString()) > 0)
                {

                    result = "Congrats! Won for coupon " + Reg.Received_Code1 + Reg.Received_Code2 + "   For more info visit https://www.vcqru.com/assets/images/pdf/FAQ.pdf";
                }
                else
                {
                    Reg.Is_Success = 0;
                    long intM_Consumer_MCOde = Business9420.function9420.InsertCodeChecked(Reg);
                    // result = "Sorry, this coupon cannot be redeemed. This mechanic coupon scheme has been closed. Thanks for your participation";
                    result = "Service of the coupon " + Reg.Received_Code1 + Reg.Received_Code2 + " has been deactivated. For more info visit https://www.vcqru.com/assets/images/pdf/FAQ.pdf";
                }


            }
            else if (!string.IsNullOrEmpty(result))
            {
                if (CompName.ToLower() != "nutriglow")
                {
                    // if (Dial_Mode.ToLower() == "website")
                    if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "GRIH PRAWESH MARKETING COMPANY")
                    {
                        result = result.Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                        SendSmsfromknowlarity(result, strMobileNo);
                    }

                    if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "ALSTONE INDUSTRIES PVT. Ltd REYNOBOND")
                    {
                        result = result.Replace("<CODE1>", Reg.Received_Code1).Replace("<CODE2>", Reg.Received_Code2);
                        //SendSmsfromknowlarity(result, strMobileNo);
                    }

                    if (CompName.ToUpper() == "MAHINDRA AND MAHINDRA LTD")
                    {
                        //if (IsCheckedUse_Count)
                        //    result = result + " <br/><br/> THANKS VCQRU";


                    }
                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "PROQUEST NUTRITION PRIVATE LIMITED" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "harrison demo" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "A TO Z PHARMACEUTICALS" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "Trimurti" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "GRIH PRAWESH MARKETING COMPANY" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "ALSTONE INDUSTRIES PVT. Ltd REYNOBOND" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "BCC ASSOCIATES" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "ROYAL MANUFACTURER" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "FB NUTRITION" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "PARAG MILK FOODS" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Ankerite Health Care Pvt. Ltd" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Chase2Fit" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Guru Kripa Enterprises" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "SHRI BALAJI" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "A TO Z PHARMA" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "AMULYA AYURVEDA" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Secure Lifesciences" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "SHRI BALAJI OVERSEAS MUSCLE TECH" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "BLACK MANGO HERBS" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Nutravel Health Care" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "UNIGLOBAL DISTRIBUTORS PVT. LTD." || dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "AUTO MAX INDIA" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Delta Luminaries" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Competent Electricals India" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "JPH PUBLICATIONS PVT. LTD" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "COATS BATH FITTINGS" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Veena Polymer" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Wudchem Industries Private Limited" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "R.S Industries" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Jupiter Aqua Lines Ltd" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "SKYDECOR LAMINATES PRIVATE LIMITED" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "JOHNSON PAINTS CO." || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "HERBAL AYURVEDA AND RESEARCH CENTER" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "SAFFRO MELLOW COATINGS AND RESINS" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "BENITTON BATHWARE" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "YAMUNA INTERIORS PRIVATE LIMITED" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "Yamuna Interiors Pvt Ltd G")
                    {
                        // dd nutrition above line
                    }


                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "LIPKA" || dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "RUHE")
                    {
                        result = "<a target='_blank' href='https://api.whatsapp.com/send?phone=" + strMobileNo + "&text=" + result + "'>" + result + "</a>";
                    }

                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString() == "EVERCROP AGRO SCIENCE")
                    {
                        if (!IsCheckedUse_Count)
                        {
                            if (Dial_Mode == "SMS")
                                result = result + " click here https://tinyurl.com/4ekxxfun";
                            else
                                result = result;
                        }

                    }
                    else if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "MYSHA HEALTH WORLD")
                    {
                        if (Reg.Dial_Mode != "SMS")
                        {
                            result = result.Replace(strSeperator, "");
                            //result += " Kindly visit www.myshahealthworld.com for any query or call 9717344860";
                            result = result.ToUpper();
                        }

                    }
                    else if (CompName.ToUpper() == "OSR IMPEX")
                    {
                        if (Reg.Dial_Mode == "SMS")
                        {
                            // result = result + "SPONSORED BY VCQRU.";
                        }
                    }
                    else if (CompName.ToUpper() == "TNT")
                    {
                        result = result + " <br/><br/> We look forward to your seamless experience and next purchase from TNT.";
                    }
                    else if (CompName.ToUpper() == "ORBIT ELECTRODOMESTICS INDIA")
                    {
                        result = result + "";
                    }
                    else if (CompName.ToUpper() == "TECHNICAL MINDS PRIVATE LIMITED")
                    {
                        result = result + ' ';
                    }



                    else if (CompName.ToString() == "Color Valley Coatings")
                    {
                        result = result + "";
                    }



                    else if (CompName.ToString() == "VR KABLE INDIA PRIVATE LIMITED")
                    {
                        result = result + "";
                    }

                    // else if (CompName.ToUpper() != "MFN")
                    //   result = result + " <br/><br/> MFD BY " + CompName + " " + DefaultComments ;
                    //  else
                    //  {
                    //  result = result.Replace("TNX VCQRU.COM", "mfd by " + CompName.ToUpper() == "" ? dsres.Tables[0].Rows[0]["Comp_Name"].ToString() : CompName.ToUpper() + "  TNX VCQRU.COM").ToUpper();
                    // }
                }
            }

            #endregion
        }
        catch (Exception ex)
        {

            string ErrorPagePath = HttpContext.Current.Request.Url.ToString();
            Exception ErrorInfo = ex.GetBaseException(); //HttpContext.Current.Server.GetLastError().GetBaseException();
            DataProvider.LogManager.ErrorExceptionLog(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            DataProvider.LogManager.ErrorExceptionLog(ErrorPagePath);
            DataProvider.LogManager.ErrorExceptionLog(ErrorInfo.Message);
            DataProvider.LogManager.ErrorExceptionLog("\n" + ErrorInfo.StackTrace + "\n");
            DataProvider.LogManager.ErrorExceptionLog("\n UserHostAddress: " + Convert.ToString(HttpContext.Current.Request.UserHostAddress) + ",REMOTE_ADDR: " + HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] + ", HTTP_X_FORWARDED_FOR: " + Convert.ToString(HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"]));
        }
        return result;
    }

    /// <summary>
    /// Selects top n from table . This "n" is intRandomNumber. Use the last record to get nth record .
    /// </summary>
    /// <param name="intRandomNumber">used for "top n"</param>
    /// <param name="Pro_id"></param>
    /// <returns></returns>
    public static DataTable Proc_GetRandomCode(int intRandomNumber, string Pro_id)
    {
        try
        {


            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");
            dbCommand = database.GetStoredProcCommand("Proc_GetRandomCode");
            database.AddInParameter(dbCommand, "RandomNumber", DbType.Int32, intRandomNumber);
            database.AddInParameter(dbCommand, "Pro_id", DbType.String, Pro_id);
            return database.ExecuteDataSet(dbCommand).Tables[0];
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataTable Proc_SaveCode(string Pro_id, string code1, string code2, string CompID, int SST_Id, int Trans_Id, string strRules, string serviceid)
    {
        try
        {


            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");
            dbCommand = database.GetStoredProcCommand("Proc_SaveCodeForRandomFirstNPaticipants");
            //database.AddInParameter(dbCommand, "RandomNumber", DbType.Int32, intRandomNumber);
            database.AddInParameter(dbCommand, "Pro_id", DbType.String, Pro_id);
            database.AddInParameter(dbCommand, "code1", DbType.String, code1);
            database.AddInParameter(dbCommand, "code2", DbType.String, code2);
            database.AddInParameter(dbCommand, "CompID", DbType.String, CompID);
            database.AddInParameter(dbCommand, "SST_Id", DbType.Int32, SST_Id);
            database.AddInParameter(dbCommand, "Trans_Id", DbType.Int32, Trans_Id);
            database.AddInParameter(dbCommand, "strRules", DbType.String, strRules);
            database.AddInParameter(dbCommand, "@serviceid", DbType.String, serviceid);
            return database.ExecuteDataSet(dbCommand).Tables[0];
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataTable Proc_SaveCodeOnlyForDueDate(Int64 SST_Id, string code1, string code2)
    {
        try
        {


            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");
            dbCommand = database.GetStoredProcCommand("GetCodeCheckForDueDate");
            //database.AddInParameter(dbCommand, "RandomNumber", DbType.Int32, intRandomNumber);
            database.AddInParameter(dbCommand, "@SST_Id", DbType.Int64, SST_Id);
            database.AddInParameter(dbCommand, "@Code1", DbType.String, code1);
            database.AddInParameter(dbCommand, "@Code2", DbType.String, code2);

            //database.AddInParameter(dbCommand, "Pro_id", DbType.String, Pro_id);
            //database.AddInParameter(dbCommand, "CompID", DbType.String, CompID);

            //database.AddInParameter(dbCommand, "Trans_Id", DbType.Int32, Trans_Id);
            //database.AddInParameter(dbCommand, "strRules", DbType.String, strRules);
            //database.AddInParameter(dbCommand, "@serviceid", DbType.String, serviceid);
            return database.ExecuteDataSet(dbCommand).Tables[0];
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static string Proc_SaveCodeDtsForRandomCount(string code1, string code2, int SST_Id)
    {
        try
        {


            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");

            dbCommand = database.GetStoredProcCommand("Proc_SaveCodeDtsForRandomCount");


            //database.AddInParameter(dbCommand, "RandomNumber", DbType.Int32, intRandomNumber);
            //database.AddInParameter(dbCommand, "Pro_id", DbType.String, Pro_id);
            database.AddInParameter(dbCommand, "code1", DbType.String, code1);
            database.AddInParameter(dbCommand, "code2", DbType.String, code2);
            //  database.AddInParameter(dbCommand, "CompID", DbType.String, CompID);
            database.AddInParameter(dbCommand, "SST_Id", DbType.Int32, SST_Id);
            //  database.AddInParameter(dbCommand, "Trans_Id", DbType.Int32, Trans_Id);
            //  database.AddInParameter(dbCommand, "strRules", DbType.String, strRules);
            object i = database.ExecuteScalar(dbCommand);
            return Convert.ToString(i);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet Proc_SaveCodeDtsForBuiltLoyalty(string code1, string code2, int SST_Id, long intM_Consumer_MCOde)
    {
        try
        {


            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");

            dbCommand = database.GetStoredProcCommand("Proc_SaveCodeDtsForBuiltLoyalty");

            //database.AddInParameter(dbCommand, "RandomNumber", DbType.Int32, intRandomNumber);
            //database.AddInParameter(dbCommand, "Pro_id", DbType.String, Pro_id);
            database.AddInParameter(dbCommand, "code1", DbType.String, code1);
            database.AddInParameter(dbCommand, "code2", DbType.String, code2);
            //  database.AddInParameter(dbCommand, "CompID", DbType.String, CompID);
            database.AddInParameter(dbCommand, "SST_Id", DbType.Int32, SST_Id);
            database.AddInParameter(dbCommand, "intM_Consumer_MCOde", DbType.Int64, intM_Consumer_MCOde);
            //  database.AddInParameter(dbCommand, "strRules", DbType.String, strRules);
            return database.ExecuteDataSet(dbCommand);

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet Proc_SaveCodeDtsForReferralService(string code1, string code2, int SST_Id, long intM_Consumer_MCOde, string ReferralCodeFromUser)
    {
        try
        {


            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");

            dbCommand = database.GetStoredProcCommand("Proc_SaveCodeDtsForReferralService_New");

            //database.AddInParameter(dbCommand, "RandomNumber", DbType.Int32, intRandomNumber);
            //database.AddInParameter(dbCommand, "Pro_id", DbType.String, Pro_id);
            database.AddInParameter(dbCommand, "code1", DbType.String, code1);
            database.AddInParameter(dbCommand, "code2", DbType.String, code2);
            //  database.AddInParameter(dbCommand, "CompID", DbType.String, CompID);
            database.AddInParameter(dbCommand, "SST_Id", DbType.Int32, SST_Id);
            database.AddInParameter(dbCommand, "intM_Consumer_MCOde", DbType.Int64, intM_Consumer_MCOde);
            database.AddInParameter(dbCommand, "ReferralCodeFromUser", DbType.String, ReferralCodeFromUser);
            database.AddInParameter(dbCommand, "dtDatetime", DbType.DateTime, DataProvider.LocalDateTime.Now);
            return database.ExecuteDataSet(dbCommand);

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public static DataSet GetServicesAssign_Product(string Pro_id)
    {
        try
        {


            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");
            dbCommand = database.GetStoredProcCommand("Proc_GetServicesAssignAgainstProduct");

            database.AddInParameter(dbCommand, "Pro_id", DbType.String, "AH12");
            database.AddInParameter(dbCommand, "code1", DbType.String, Pro_id.Split('-')[0].ToString());
            database.AddInParameter(dbCommand, "code2", DbType.String, Pro_id.Split('-')[1].ToString());
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetServicesAssignAgainstProduct_Duedate(string Code1, string Code2)
    {
        try
        {


            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");
            dbCommand = database.GetStoredProcCommand("Proc_GetServicesAssignAgainstProduct_Duedate");
            database.AddInParameter(dbCommand, "@Code1", DbType.String, Code1);
            database.AddInParameter(dbCommand, "@Code2", DbType.String, Code2);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetServicesAssign_Product(string Code1, string Code2, string CompId = "")
    {
        try
        {
            if (CompId == "Comp-1693")
                dbCommand = database.GetStoredProcCommand("Proc_GetServicesAssignAgainstProduct_PFL");
            else
                //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");
                dbCommand = database.GetStoredProcCommand("Proc_GetServicesAssignAgainstProduct");
            database.AddInParameter(dbCommand, "@Code1", DbType.String, Code1);
            database.AddInParameter(dbCommand, "@Code2", DbType.String, Code2);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetProductDtsByCode1andcode2(string code1, string code2, string @url, string CompId = "")
    {
        if (CompId == "Comp-1693")
            dbCommand = database.GetStoredProcCommand("Proc_GetProductDtsByCode1andcode2_PFL");
        else
            dbCommand = database.GetStoredProcCommand("Proc_GetProductDtsByCode1andcode2");
        database.AddInParameter(dbCommand, "@code1", DbType.String, code1);
        database.AddInParameter(dbCommand, "@code2", DbType.String, code2);
        database.AddInParameter(dbCommand, "@url", DbType.String, url);
        return database.ExecuteDataSet(dbCommand);
    }
    /// <summary>
    /// GiftCount > DistributeCount checking condition
    /// </summary>
    /// <param name="SST_Id"></param>
    /// <returns></returns>
    public static DataSet GetGiftCouponName(int SST_Id, int Trans_Id, int M_CodeID, string Comp_ID)
    {
        dbCommand = database.GetStoredProcCommand("GetGiftCouponNAME");
        database.AddInParameter(dbCommand, "@SST_Id", DbType.String, SST_Id);
        database.AddInParameter(dbCommand, "@Trans_Id", DbType.String, Trans_Id);
        database.AddInParameter(dbCommand, "@M_CodeID", DbType.String, M_CodeID);
        database.AddInParameter(dbCommand, "@CompID", DbType.String, Comp_ID);
        return database.ExecuteDataSet(dbCommand);
    }
    /// <summary>
    /// Getting Coupon code (eg Pizza coupon code ( getting Rs 100/- off).
    /// And Updating all tables flag 1 i.e gift is assigned to code, inserting M_CodeCouponAssign 
    /// </summary>
    /// <param name="SST_Id"></param>
    /// <returns></returns>
    public static DataSet GetGiftCouponCode(int SST_Id, int Trans_Id, int M_Codeid)
    {
        dbCommand = database.GetStoredProcCommand("GetGiftCouponCode");
        database.AddInParameter(dbCommand, "@SST_Id", DbType.String, SST_Id);
        database.AddInParameter(dbCommand, "@Trans_Id", DbType.Int32, Trans_Id);
        database.AddInParameter(dbCommand, "@M_Codeid", DbType.Int32, M_Codeid);
        return database.ExecuteDataSet(dbCommand);
    }
    public static DataSet M_CodeCouponAssignSelectForSequence(int code1, int code2, Int64 intM_code_M_ConsumerID, string strServiceid)
    {
        dbCommand = database.GetStoredProcCommand("M_CodeCouponAssignSelectbySequence");
        //database.AddInParameter(dbCommand, "@code1", DbType.Int32, code1);
        //database.AddInParameter(dbCommand, "@code2", DbType.Int32, code2);
        database.AddInParameter(dbCommand, "@intM_code_M_ConsumerID", DbType.Int64, intM_code_M_ConsumerID);
        database.AddInParameter(dbCommand, "@strServiceid", DbType.String, strServiceid);
        return database.ExecuteDataSet(dbCommand);
    }
    public static DataSet GetGiftOrRaffleDueDate(Int64 sst_id, string strServiceid, string code1, string code2)
    {
        dbCommand = database.GetStoredProcCommand("GetGiftOrRaffleDueDate");
        database.AddInParameter(dbCommand, "@code1", DbType.String, code1);
        database.AddInParameter(dbCommand, "@code2", DbType.String, code2);
        database.AddInParameter(dbCommand, "@sst_id", DbType.Int64, sst_id);
        //   database.AddInParameter(dbCommand, "@intM_code_M_ConsumerID", DbType.Int64, intM_code_M_ConsumerID);
        database.AddInParameter(dbCommand, "@strServiceid", DbType.String, strServiceid);
        return database.ExecuteDataSet(dbCommand);
    }
    public static string ShowMessageGiftCoupon(string couponnameOrGiftName, string coupancode, bool isDueDate, string strDuedate, bool isRaffleService)
    {
        Object9420 Reg = new Object9420();
        if (isRaffleService == true)
        {
            Reg.TempleteHead = "SRV1006";
        }
        else { Reg.TempleteHead = "SRV1003"; }

        Reg.SubHeadId = "";
        DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
        string strReturnMSG = string.Empty;
        if (isDueDate)
        {
            #region Duedate msg
            // if (string.IsNullOrEmpty(couponnameOrGiftName))
            {
                if (Convert.ToDateTime(strDuedate) <= DateTime.UtcNow)
                {
                    if (isRaffleService == true)
                    {
                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1006' and MsgType = 5");
                        //strReturnMSG = (strReturnMSG.Replace("<cash>", Iscash)
                        //                                .Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
                        //  return "Sorry, you have not won any gift, better luck next time ! ";// Or for redeem, visit your account at VCQRU.";
                        return strReturnMSG.ToUpper();
                    }
                    else
                    {
                        strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1003' and MsgType = 5");
                        //return "Sorry, you have not won any gift coupon, better luck next time ! ";// Or for redeem, visit your account at VCQRU.";
                        return strReturnMSG.ToUpper();
                    }
                }
                else
                {
                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1003,SRV1006' and MsgType = 7");
                    strReturnMSG = (strReturnMSG.Replace("<strDuedate>", strDuedate)).ToUpper();
                    // return "Are you a lucky winner!  You will come to know on due date <b>'" + strDuedate + "'</b>.";// Or for redeem, visit your account at VCQRU.";
                    return strReturnMSG;
                }
            }
            #endregion
        }
        else
        {
            if (string.IsNullOrEmpty(couponnameOrGiftName))
            {
                if (isRaffleService == true)
                {
                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1006' and MsgType = 5");
                    //return "Sorry, you have not won any gift, better luck next time ! ";// Or for redeem, visit your account at VCQRU.";
                    return strReturnMSG.ToUpper();
                }
                else
                {
                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1003' and MsgType = 5");
                    // return "Sorry, you have not won any gift coupon, better luck next time ! ";// Or for redeem, visit your account at VCQRU.";
                    return strReturnMSG.ToUpper();
                }

            }
            else
            {
                if (isRaffleService == true)
                {
                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1006' and MsgType = 8");
                    strReturnMSG = (strReturnMSG.Replace("<gift>", couponnameOrGiftName).Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)).ToUpper();
                    return strReturnMSG;
                    // SendSms("Cong! You won a gift.Please register/complete details to claim your gift on VCQRU.COM", ProjectSession.strMobileNo);
                    // return "Congratulations!! You Won!! You have won a gift '<b>" + couponnameOrGiftName + " </b>'.Please complete your profile details to claim your gift <a href='"+ ProjectSession.absoluteSiteBrowseUrl + "/Info/Consumerregister.aspx#trylogin' target='_blank' style='color:blue;'> BUYER SIGNUP / SIGNIN </a> .";// Or for redeem, visit your account at VCQRU.";
                }
                else
                {
                    strReturnMSG = GetMessageFromM_TemplateMSg(MsgTempdt, "", "", " Service_ID = 'SRV1003' and MsgType = 8");
                    strReturnMSG = (strReturnMSG.Replace("<gift>", couponnameOrGiftName).
                                                Replace("<absoluteSiteBrowseUrl>", ProjectSession.absoluteSiteBrowseUrl)
                                                .Replace("<couponcode>", coupancode)).ToUpper();
                    if (!string.IsNullOrEmpty(strDialMode1))
                    {
                        if (strDialMode1.ToLower() == "website")
                            SendSms("Cong! Your Coupon code - " + coupancode + " VCQRU.COM", ProjectSession.strMobileNo);
                    }

                    return strReturnMSG;
                    // return "Congratulations!! You Won!! You have won a gift coupon of '" + couponnameOrGiftName + "'. Please note your Coupon code, your code is '<b>" + coupancode + " </b>' .";// Or for redeem, visit your account at VCQRU.";
                }

            }
        }


    }
    public static string GetMsgProc_SaveCode(string Pro_id, string code1, string code2, string CompID, int SST_Id, int Trans_Id, string strRules, bool IsRaffleservice, string strServiceid)
    {
        string strMesg = string.Empty;
        DataTable dtm_SaveCode = Proc_SaveCode(Pro_id, code1, code2, CompID, SST_Id, Trans_Id, strRules, strServiceid); // 
        if (dtm_SaveCode.Rows.Count > 0)
        {
            if (dtm_SaveCode.Rows[0][0].ToString() == "0")
            {
                strMesg = ShowMessageGiftCoupon("", "", false, "", IsRaffleservice); // show message of Better luck next time if not won gift

            }
            else
            {
                strMesg = ShowMessageGiftCoupon(dtm_SaveCode.Rows[0]["couponname"].ToString(), dtm_SaveCode.Rows[0]["CouponCode"].ToString(), false, "", IsRaffleservice);
                str_GiftOrRaffle = dtm_SaveCode.Rows[0][0].ToString();
            }
        }
        else
        {
            strMesg = ShowMessageGiftCoupon("", "", false, "", IsRaffleservice); // show message of Better luck next time if not won gift
        }
        return strMesg;
    }

    /// <summary>
    /// Gift coupon service logic
    /// </summary>
    /// <param name="dr"></param>
    /// <param name="intTotalCodeCount"> is required to get randomly value from total code count.</param>
    /// <param name="Received_Code1"></param>
    /// <param name="Received_Code2"></param>
    /// <returns></returns>
    public static string GetGiftCouponService(DataRow dr, int intTotalCodeCount, string Received_Code1, string Received_Code2, string Comp_ID, bool isRaffleService, string strServiceid, Object9420 Reg)
    {
        string strDueDate = string.Empty;
        string strMesg = string.Empty;
        string strRandomOrSequence = dr["DistributionType"].ToString();
        if (dr["ServiceType"].ToString() == Business_Logic_Layer.ServiceTypes.Instant.ToString())
        {
            // Random rng = new Random();

            // int intRandom = -1;

            if (strRandomOrSequence == Business_Logic_Layer.RwdDistrubutionRules.Random.ToString())
            {
                #region Random         
                if (dr["Rules"].ToString() == Business_Logic_Layer.ServiceRules.FirstNCustomer.ToString())
                {
                    strMesg = GetMsgProc_SaveCode(dr["Pro_ID"].ToString(), Received_Code1, Received_Code2, Comp_ID, Convert.ToInt32(dr["SST_Id"]), Convert.ToInt32(dr["Trans_Id"]), dr["Rules"].ToString(), isRaffleService, strServiceid);

                    //DataTable dtm_SaveCode = Proc_SaveCode(dr["Pro_ID"].ToString(), Received_Code1, Received_Code2, Comp_ID, Convert.ToInt32(dr["SST_Id"]), Convert.ToInt32(dr["Trans_Id"]), dr["Rules"].ToString()); // 
                    //if (dtm_SaveCode.Rows.Count > 0)
                    //{
                    //    strMesg = ShowMessageGiftCoupon(dtm_SaveCode.Rows[0]["couponname"].ToString(), dtm_SaveCode.Rows[0]["CouponCode"].ToString(), false, "");
                    //}
                    //else
                    //{
                    //    strMesg = ShowMessageGiftCoupon("", "", false, ""); // show message of Better luck next time if not won gift
                    //}
                }
                else if (dr["Rules"].ToString() == Business_Logic_Layer.ServiceRules.RandomNCustomernth.ToString())
                {
                    // save to Db
                    string strPkid = Proc_SaveCodeDtsForRandomCount(Received_Code1, Received_Code2, Convert.ToInt32(dr["SST_Id"]));
                    strMesg = GetMsgProc_SaveCode(dr["Pro_ID"].ToString(), Received_Code1, Received_Code2, Comp_ID, Convert.ToInt32(dr["SST_Id"]), Convert.ToInt32(dr["Trans_Id"]), dr["Rules"].ToString(), isRaffleService, strServiceid);


                }
                else if (dr["Rules"].ToString() == Business_Logic_Layer.ServiceRules.RandomNCustomer.ToString())
                {
                    strMesg = GetMsgProc_SaveCode(dr["Pro_ID"].ToString(), Received_Code1, Received_Code2, Comp_ID, Convert.ToInt32(dr["SST_Id"]), Convert.ToInt32(dr["Trans_Id"]), dr["Rules"].ToString(), isRaffleService, strServiceid);
                }
                else if (dr["Rules"].ToString() == Business_Logic_Layer.ServiceRules.AllCustomer.ToString())
                {
                    strMesg = GetMsgProc_SaveCode(dr["Pro_ID"].ToString(), Received_Code1, Received_Code2, Comp_ID, Convert.ToInt32(dr["SST_Id"]), Convert.ToInt32(dr["Trans_Id"]), dr["Rules"].ToString(), isRaffleService, strServiceid);
                }

                #endregion
            }
            else if (strRandomOrSequence == Business_Logic_Layer.RwdDistrubutionRules.Sequence.ToString())
            {
                #region Sequence 
                DataTable dtSequenceFirstNParticipants = M_CodeCouponAssignSelectForSequence(Convert.ToInt32(Received_Code1), Convert.ToInt32(Received_Code2), Reg.intM_Consumer_MCOde, strServiceid).Tables[0];
                if (dtSequenceFirstNParticipants.Rows.Count > 0)
                {
                    str_GiftOrRaffle = dtSequenceFirstNParticipants.Rows[0][0].ToString();
                    return ShowMessageGiftCoupon(dtSequenceFirstNParticipants.Rows[0]["couponname"].ToString(), dtSequenceFirstNParticipants.Rows[0]["CouponCode"].ToString(), false, "", isRaffleService);// "Congratulation's !!! You have won gift coupon of '" + dtSequenceFirstNParticipants.Rows[0]["couponname"] + "'. Please note your Coupon code, your code is '<b>" + dtSequenceFirstNParticipants.Rows[0]["CouponCode"].ToString() + " </b>' Or for redeem, visit your account at VCQRU.";
                }
                else
                    return "";
                #endregion
            }
        }
        // -------------------------------------  due date ---------------------------------------- 
        else if (dr["ServiceType"].ToString() == Business_Logic_Layer.ServiceTypes.DueDate.ToString())
        {
            #region Code Check At due date
            //Reg.Is_Success = 0;
            //Business9420.function9420.InsertCodeChecked(Reg);


            // get due date          
            // Get a sql query.
            DataSet ds = GetGiftOrRaffleDueDate(Convert.ToInt32(dr["SST_Id"]), strServiceid, Received_Code1, Received_Code2);

            DataTable dt = ds.Tables[0];
            DataTable dt2 = ds.Tables[1];
            if (dt2.Rows.Count > 0)
            {
                strDueDate = Convert.ToDateTime(dt2.Rows[0]["DueDate"]).ToString("dd/MMM/yyyy");
            }
            //if (dt.Rows.Count > 0)
            //{
            //    if (Convert.ToBoolean(dt.Rows[0]["IsCheckedForDueDate1"].ToString()) == true)
            //    {
            //        // this code is already checked before
            //    }
            //    else
            //    {
            //        strMesg = ShowMessageGiftCoupon(dt.Rows[0]["couponname"].ToString(), dt.Rows[0]["CouponCode"].ToString(), true, strDueDate, isRaffleService);

            //        SQL_DB.ExecuteDataSet("  Update M_CodeCouponAssign set IsCheckedForDueDate = 1 where id in (" + dt.Rows[0]["id"].ToString() + ")");
            //    }
            //}
            //else
            {
                if (Convert.ToDateTime(strDueDate) > DateTime.UtcNow)
                {
                    string strPkid = Proc_SaveCodeDtsForRandomCount(Received_Code1, Received_Code2, Convert.ToInt32(dr["SST_Id"]));
                }
                strMesg = ShowMessageGiftCoupon("", "", true, strDueDate, isRaffleService);
            }

            #endregion
        }
        return strMesg;
    }


    public static void GetRaffleSchemeService()
    {
    }
    /// <summary>
    /// All update are going in this SP , delete  data on update M_CodeCouponAssign , update flag on M_couponcodes and m_code table
    /// </summary>
    /// <param name="RowId"></param>
    /// <param name="ServiceType"></param>
    /// <param name="Rules"></param>
    /// <param name="RewardsDistribution"></param>
    /// <param name="PrizeTrans_Id"></param>
    /// <param name="MasterCodes"></param>
    /// <param name="WinningCodes"></param>
    /// <param name="WinCodes"></param>
    /// <param name="Nth"></param>
    /// <param name="DML"></param>
    /// <param name="strDueDate"></param>
    /// <returns></returns>
    public static int M_ServiceRuleInsertUpdate(Int64 RowId, string ServiceType, string Rules, string RewardsDistribution, string PrizeTrans_Id, Int64 MasterCodes
        , Int64 WinningCodes, Int64 WinCodes, int Nth, string DML, DateTime? strDueDate)
    {
        dbCommand = database.GetStoredProcCommand("Proc_M_ServiceRuleInsertUpdate");
        database.AddInParameter(dbCommand, "@SST_Id", DbType.Int64, RowId);
        database.AddInParameter(dbCommand, "@ServiceType", DbType.String, ServiceType);
        database.AddInParameter(dbCommand, "@Rules", DbType.String, Rules);
        database.AddInParameter(dbCommand, "@DistributionType", DbType.String, RewardsDistribution);
        database.AddInParameter(dbCommand, "@PrizeTrans_Id", DbType.String, PrizeTrans_Id);
        database.AddInParameter(dbCommand, "@MasterCodes", DbType.Int64, MasterCodes);
        database.AddInParameter(dbCommand, "@WinningCodes", DbType.Int64, WinningCodes);
        database.AddInParameter(dbCommand, "@WinCodes", DbType.Int64, WinCodes);
        database.AddInParameter(dbCommand, "@Frequency", DbType.Int32, Nth);
        database.AddInParameter(dbCommand, "@DML", DbType.String, DML);
        database.AddInParameter(dbCommand, "@strDueDate", DbType.DateTime, strDueDate);
        //  database.AddInParameter(dbCommand, "@intM_Serviceruleid", DbType.Int32, intM_Serviceruleid);
        //  database.AddInParameter(dbCommand, "@Comp_id", DbType.String, Comp_ID);
        object i = database.ExecuteScalar(dbCommand);
        return Convert.ToInt32(i);
    }
    /// <summary>
    /// Sequence type gift distribution
    /// </summary>
    public static int InsertCouponCodeForSequence(Int64 SST_Id, string ServiceType, string strRules, string DistributionType, Int64 WinningCodes, int Frequency, int intM_Serviceruleid, string Comp_ID, string strServiceType, string RewardsDistribution)
    {
        try
        {
            // Note - All Things are checking in SP. 
            dbCommand = database.GetStoredProcCommand("Proc_InsertCouponCodeForSequence");
            database.AddInParameter(dbCommand, "@SST_Id", DbType.Int64, SST_Id);
            //database.AddInParameter(dbCommand, "@ServiceType", DbType.String, ServiceType);
            //database.AddInParameter(dbCommand, "@Rules", DbType.String, Rules);
            //database.AddInParameter(dbCommand, "@DistributionType", DbType.String, DistributionType);
            //database.AddInParameter(dbCommand, "@WinningCodes", DbType.Int64, WinningCodes);
            //database.AddInParameter(dbCommand, "@Frequency", DbType.Int32, Frequency);
            database.AddInParameter(dbCommand, "@intM_Serviceruleid", DbType.Int32, intM_Serviceruleid);
            database.AddInParameter(dbCommand, "@Comp_id", DbType.String, Comp_ID);
            database.AddInParameter(dbCommand, "@strRules", DbType.String, strRules);
            database.AddInParameter(dbCommand, "@strServiceType", DbType.String, strServiceType);
            database.AddInParameter(dbCommand, "@RewardsDistribution", DbType.String, RewardsDistribution);
            return database.ExecuteNonQuery(dbCommand);
        }
        catch (Exception)
        {
            return -1;
        }

    }

    public static string LoopInServicesAndExecuteQueryAndReturnMsg(string strCode1, string strCode2, string CheckingType)
    {
        string msg = "";
        DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(strCode1, strCode2);
        DataTable dtServiceAssign = dsServicesAssign.Tables[0];
        DataTable dtTotalCodesCount = dsServicesAssign.Tables[1];
        Object9420 Reg = new Object9420();
        if (dtServiceAssign.Rows.Count > 0)
        {
            for (int i = 0; i < dtServiceAssign.Rows.Count; i++)
            {
                string stServiceid = dtServiceAssign.Rows[i]["Service_ID"].ToString();
                switch (stServiceid)
                {
                    case "SRV1018":
                        {
                            //DtDetail = DataProvider.Procedure.GetProcedureData("PROC_GetPlayfileInfo", strCode1, strCode2);
                            msg = "Counterfitting";
                            break;
                        }
                    case "SRV1003":
                        {
                            //GetGiftCouponService();
                            DataRow[] dr = dtServiceAssign.Select("Service_id = '" + stServiceid + "'");
                            if (dr.Length > 0)
                            {
                                GetGiftCouponService(dr[0], Convert.ToInt32(dtTotalCodesCount.Rows[0][0].ToString()), strCode1, strCode2, dr[0]["Comp_ID"].ToString(), false, stServiceid, Reg);
                            }

                            break;
                        }
                    case "SRV1006":
                        {

                            DataRow[] dr = dtServiceAssign.Select("Service_id = '" + stServiceid + "'");
                            GetGiftCouponService(dr[0], Convert.ToInt32(dtTotalCodesCount.Rows[0][0].ToString()), strCode1, strCode2, dr[0]["Comp_ID"].ToString(), false, stServiceid, Reg);
                            //result = result + "Wprk in process";

                            break;
                        }
                    default:
                        break;

                }
            }

        }
        return msg;
    }
    static string scriptTag = "<script type=\"\" language=\"\">{0}</script>";
    static string GenerateCodeFromFunction(string function)
    {
        return string.Format(scriptTag, function);
    }




    public static void SendSmsfromknowlarity(string Message, string phone, string TemplateId = "")
    {

        string str = "";
        try
        {
            String TemplateidNew = "1007472135095850470";


            string Mob10Digit = phone.Substring(phone.Length - 10, 10).ToString();

            if (TemplateId != "")
            {
                #region New Api 9_2023 Tej send otp
                string URL = String.Format("http://msgapi.knowlarity.com/api/sms?key=YAD0BJzW&to=91" + Mob10Digit + "&from=VCQRUI&body=" + Message + "&entityid=1001407084320227804&templateid=" + TemplateId);
                smslog(DateTime.Now.ToLongDateString() + ":" + URL);
                HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(URL);
                myReq.Method = "GET";
                HttpWebResponse Webresponse = (HttpWebResponse)myReq.GetResponse();
                Stream rstream = Webresponse.GetResponseStream();
                StreamReader reader = new StreamReader(rstream, Encoding.UTF8);
                string sResponse = reader.ReadToEnd();
                smslog(DateTime.Now.ToLongDateString() + ":" + sResponse);
                reader.Close();
                // smslog(sResponse);
                #endregion
            }



        }
        catch (Exception ex)
        {
            smslog(DateTime.Now.ToLongDateString() + ":" + ex.Message);
            //  throw ex;
        }
    }

    public static void SendSMSFromAlfaCosmo(string sPhoneNo, string sMessage, string msg_type)
    {
        string sResponse = "";
        try
        {
            sMessage = sMessage.Replace("&", "%26");
            if (sPhoneNo.Length == 10)
                sPhoneNo = "+91" + sPhoneNo;
            else if (sPhoneNo.Length == 12)
                sPhoneNo = "+" + sPhoneNo;
            if (msg_type == "OTP")
            {
                string URL = String.Format("http://msgapi.knowlarity.com/api/sms?key=YAD0BJzW&to=" + sPhoneNo + "&from=VCQRUI&body=" + sMessage + "&entityid=1001407084320227804&templateid=1007520233281764726");
                HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(URL);
                myReq.Method = "GET";
                HttpWebResponse Webresponse = (HttpWebResponse)myReq.GetResponse();
                Stream rstream = Webresponse.GetResponseStream();
                StreamReader reader = new StreamReader(rstream, Encoding.UTF8);
                sResponse = reader.ReadToEnd();
                reader.Close();
                smslog(sResponse);
            }

        }
        catch (Exception ex)
        {
            sResponse = ex.Message;
            //DataObjects.insertException("Task", ex.Message, BusinessObjects.NullIntToZero(Session["UserID"]).ToString(), "While sending create task sms.");
        }
    }

    public static void SendSMSFromAlfa(string sPhoneNo, string sMessage, string msg_type)
    {
        string sResponse = "";
        try
        {
            sMessage = sMessage.Replace("&", "%26");
            if (sPhoneNo.Length == 10)
                sPhoneNo = "+91" + sPhoneNo;
            else if (sPhoneNo.Length == 12)
                sPhoneNo = "+" + sPhoneNo;
            if (msg_type == "OTP")
            {

                if (ConfigurationManager.AppSettings["OTP"] == "Knowlarity")
                {
                    SendSmsfromknowlarity(sMessage, sPhoneNo);
                }
                else if (ConfigurationManager.AppSettings["OTP"] == "Smart")
                {
                    sPhoneNo = sPhoneNo.Substring(sPhoneNo.Length - 10, 10);
                    string URL = String.Format("http://sms.smartsmsservice.com/sendSMS?username=rake31@gmail.com&message=" + sMessage + "&sendername=ivcqru&smstype=TRANS&numbers=" + sPhoneNo + "&apikey=f99e4e8a-9eff-4c32-9cad-9528126bdfec"); ////////Running API//////////
                                                                                                                                                                                                                                                  // string URL = String.Format("http://sms.alfasms.in/sendSMS?username=vcqru1&message=" + sMessage + "&sendername=wecqru&smstype=TRANS&numbers=" + sPhoneNo + "&apikey=3625aac6-eed4-4606-9e1e-65dbb39311fc"); ///////////testing APi/////////
                    HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(URL);
                    myReq.Method = "GET";
                    HttpWebResponse Webresponse = (HttpWebResponse)myReq.GetResponse();
                    Stream rstream = Webresponse.GetResponseStream();
                    StreamReader reader = new StreamReader(rstream, Encoding.UTF8);
                    sResponse = reader.ReadToEnd();
                    reader.Close();
                    smslog(sResponse);
                }
                else
                {
                    sPhoneNo = sPhoneNo.Substring(sPhoneNo.Length - 10, 10);
                    // string URL = String.Format("http://sms.alfasms.in/sendSMS?username=vcqru&message=" + sMessage + "&sendername=wecqru&smstype=TRANS&numbers=" + sPhoneNo + "&apikey=0e2cc02f-059c-41ff-b913-0b1da374829d"); ////////Running API//////////
                    //string URL = String.Format("https://api-alerts.kaleyra.com/v5/?api_key=A6f2d5a230693a3f018c902dea571f1cb&method=sms&message=" + sMessage + "&to=" + sPhoneNo + "&sender=iVCQRU");
                    //HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(URL);
                    //myReq.Method = "GET";
                    //HttpWebResponse Webresponse = (HttpWebResponse)myReq.GetResponse();
                    //Stream rstream = Webresponse.GetResponseStream();
                    //StreamReader reader = new StreamReader(rstream, Encoding.UTF8);
                    //sResponse = reader.ReadToEnd();
                    //reader.Close();
                    //smslog(sResponse);

                    #region New Api


                    string URL = String.Format("https://api.kaleyra.io/v1/HXIN1745186923IN/messages?to=91" + sPhoneNo + "&type=OTP&sender=VCQRUI&body=" + sMessage + "&template_id=1007399099979047799&&Source=API");
                    ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3;
                    System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
                    ServicePointManager.ServerCertificateValidationCallback = (snder, cert, chain, error) => true;

                    WebRequest request = WebRequest.Create(URL);
                    request.Method = "POST";
                    string postData = "";
                    byte[] byteArray = Encoding.UTF8.GetBytes(postData);
                    request.ContentType = "application/x-www-form-urlencoded";
                    request.Headers.Add("api-key", "A8630797ed2577e3a9166d386937db77f");
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
                    #endregion
                    smslog(sResponse);
                }
            }

            else if (msg_type == "PWD")
            {
                sPhoneNo = sPhoneNo.Substring(sPhoneNo.Length - 10, 10);
                #region New Api

                string URL = String.Format("https://api.kaleyra.io/v1/HXIN1745186923IN/messages?to=91" + sPhoneNo + "&type=OTP&sender=VCQRUI&body=" + sMessage + "&template_id=1007786556642544707&Source=API");


                ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3;
                System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
                ServicePointManager.ServerCertificateValidationCallback = (snder, cert, chain, error) => true;

                WebRequest request = WebRequest.Create(URL);
                request.Method = "POST";
                string postData = "";
                byte[] byteArray = Encoding.UTF8.GetBytes(postData);
                request.ContentType = "application/x-www-form-urlencoded";
                request.Headers.Add("api-key", "A30570561af694829647e90add32efeaa");
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
                smslog(sResponse);
                #endregion

            }
            else
            {
                if (ConfigurationManager.AppSettings["SMS"] == "Knowlarity")
                {
                    SendSmsfromknowlarity(sMessage, sPhoneNo);
                }
                else if (ConfigurationManager.AppSettings["SMS"] == "Smart")
                {
                    sPhoneNo = sPhoneNo.Substring(sPhoneNo.Length - 10, 10);
                    string URL = String.Format("http://sms.smartsmsservice.com/sendSMS?username=rake31@gmail.com&message=" + sMessage + "&sendername=ivcqru&smstype=TRANS&numbers=" + sPhoneNo + "&apikey=f99e4e8a-9eff-4c32-9cad-9528126bdfec"); ////////Running API//////////
                                                                                                                                                                                                                                                  // string URL = String.Format("http://sms.alfasms.in/sendSMS?username=vcqru1&message=" + sMessage + "&sendername=wecqru&smstype=TRANS&numbers=" + sPhoneNo + "&apikey=3625aac6-eed4-4606-9e1e-65dbb39311fc"); ///////////testing APi/////////
                    HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(URL);
                    myReq.Method = "GET";
                    HttpWebResponse Webresponse = (HttpWebResponse)myReq.GetResponse();
                    Stream rstream = Webresponse.GetResponseStream();
                    StreamReader reader = new StreamReader(rstream, Encoding.UTF8);
                    sResponse = reader.ReadToEnd();
                    reader.Close();
                    smslog(sResponse);
                }
                else
                {
                    sPhoneNo = sPhoneNo.Substring(sPhoneNo.Length - 10, 10);
                    // string URL = String.Format("http://sms.alfasms.in/sendSMS?username=vcqru&message=" + sMessage + "&sendername=wecqru&smstype=TRANS&numbers=" + sPhoneNo + "&apikey=0e2cc02f-059c-41ff-b913-0b1da374829d"); ////////Running API//////////
                    string URL = String.Format("https://api-alerts.kaleyra.com/v5/?api_key=A8bbe02ad498531d5a99882991bef09fd&method=sms&message=" + sMessage + "&to=" + sPhoneNo + "&sender=VCQRUI");                                                                                                                                                                                                                                          // string URL = String.Format("http://sms.alfasms.in/sendSMS?username=vcqru1&message=" + sMessage + "&sendername=wecqru&smstype=TRANS&numbers=" + sPhoneNo + "&apikey=3625aac6-eed4-4606-9e1e-65dbb39311fc"); ///////////testing APi/////////
                    HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(URL);
                    myReq.Method = "GET";
                    HttpWebResponse Webresponse = (HttpWebResponse)myReq.GetResponse();
                    Stream rstream = Webresponse.GetResponseStream();
                    StreamReader reader = new StreamReader(rstream, Encoding.UTF8);
                    sResponse = reader.ReadToEnd();
                    reader.Close();
                    smslog(sResponse);
                }
            }
        }
        catch (Exception ex)
        {
            sResponse = ex.Message;
            //DataObjects.insertException("Task", ex.Message, BusinessObjects.NullIntToZero(Session["UserID"]).ToString(), "While sending create task sms.");
        }
    }

    public static void SendSms(string Message, string phone, string ApiType)
    {
        string str = "";
        if (ApiType == "Solution")
            str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A3f78a344d70a9e35c006e938f428f591&sender=LBVRFY&to=" + phone + "&message=" + Message;
        else if (ApiType == "BSmart")
            str = "http://193.105.74.58/api/v3/sendsms/plain?user=LABEL9420&password=Sid2014!&sender=labeld&SMSText=" + Message + "&GSM=" + phone;
        SendSMSBody(str);
    }

    #region //** New logs implemted as per paytm Check Status
    private static void PaytmStatuslogs(string Mobile, string Content, string Response)
    {
        try
        {
            string filename = "PaytmStatuslogs_" + System.DateTime.Today.ToString("yyyy-MM-dd");
            StreamWriter sr = new StreamWriter(HttpContext.Current.Server.MapPath("~/LogManager/PaytmLogs/" + filename + ".txt"), true);
            sr.WriteLine(Content + " :  " + Mobile + " :  " + Response + " :  " + DateTime.Now);

            sr.Close();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    #endregion

    #region //** New logs implemted as per suggested by RK Sir


    private static void smslog_New(string Mobile, string Content, string Response)
    {
        try
        {
            string filename = "Smslogs_" + System.DateTime.Today.ToString("yyyy-MM-dd");
            StreamWriter sr = new StreamWriter(HttpContext.Current.Server.MapPath("~/LogManager/SMSLogs/" + filename + ".txt"), true);
            sr.WriteLine(Content + " :  " + Mobile + " :  " + Response + " :  " + DateTime.Now);

            sr.Close();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    #endregion


    private static void smslog(string rsponse)
    {
        try
        {
            StreamWriter sr = new StreamWriter(HttpContext.Current.Server.MapPath("~/LogManager/smslog.txt"), true);

            sr.WriteLine(DateTime.Now + ":  " + rsponse);
            sr.Close();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    #region //** New logs implemted as per suggested by RK Sir
    public static void MissedcallLogs(string Mobile, string Response)
    {
        try
        {
            string filename = "MissedcallLogs_" + System.DateTime.Today.ToString("yyyy-MM-dd");
            StreamWriter sr = new StreamWriter(HttpContext.Current.Server.MapPath("~/LogManager/MissedcallLogs/" + filename + ".txt"), true);
            sr.WriteLine("Mobile Number :  " + Mobile + " :  " + Response + " :  " + DateTime.Now);

            sr.Close();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    #endregion

    public static void SendSms(string Message, string phone)
    {

        string str = "";
        try
        {
            Message = Message.Replace("&", "%26");
            if (phone.Length == 10)
                phone = "+91" + phone;
            else if (phone.Length == 12)
                phone = "+" + phone;
            if (ConfigurationManager.AppSettings["SMS"] == "Knowlarity")
            {
                SendSmsfromknowlarity(Message, phone);
            }
            else
            {
                //http://sms.bsmart.in:8080/smart/SMSmartSendSMS.jsp?http://sms.bsmart.in:8080/smart/SmartSendSMS.jsp
                //str = "http://sms.bsmart.in:8080/smart/SMSmartSendSMS.jsp?usr=LABEL9420&pass=LABEL890&sid=LBVRFY&GSM=" + phone + "&msg=" + Message + "&mt=0";
                //str = "http://193.105.74.58/api/v3/sendsms/plain?user=LABEL9420&password=Sid2014!&sender=labeld&SMSText=" + Message + "&GSM=" + phone;
                //str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A7285cc769f5ed203e7d8cee48444dbb8&sender=SIDEMO&to=" + phone + "&message=" + Message;

                //str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A3f78a344d70a9e35c006e938f428f591&sender=LBVRFY&to=" + phone + "&message=" + Message;
                //if (ApiType == "Solution")
                //{
                //str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A3f78a344d70a9e35c006e938f428f591&sender=LBVRFY&to=" + phone + "&message=" + Message;

                //str = "http://etsrds.kapps.in/webapi/accomplish/api/accomplish_T897_sms.py?customer_number=" + phone + "&sms_text=" + Message;

                // str = String.Format("http://sms.alfasms.in/sendSMS?username=vcqru&message=" + Message + "&sendername=wecqru&smstype=TRANS&numbers=" + phone + "&apikey=0e2cc02f-059c-41ff-b913-0b1da374829d");


                str = String.Format("https://api-alerts.kaleyra.com/v5/?api_key=A6f2d5a230693a3f018c902dea571f1cb&method=sms&message=" + Message + "&to=" + phone + "&sender=VCQRUI");
                WebRequest request = WebRequest.Create(str);
                request.Method = "POST";
                string postData = "";
                byte[] byteArray = Encoding.UTF8.GetBytes(postData);
                request.Headers.Add("auth_key", "fJeVv745L-rI6TPSZqgb-Z3U6mvgZ-ODYI0");
                request.ContentType = "application/x-www-form-urlencoded";//application/     x-www-form-urlencoded
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

                smslog(responseFromServer);
                reader.Close();
                dataStream.Close();
                response.Close();
            }

            //}
            //else if (ApiType == "BSmart")
            //{
            //    //str = "http://193.105.74.58/api/v3/sendsms/plain?user=LABEL9420&password=Sid2014!&sender=labeld&SMSText=" + Message + "&GSM=" + phone;
            //    SendSMS s = new SendSMS("label94201", "f0781cb79f9bd13b8d86ef226f26eb53f9613f45");
            //    string response = s.execute("9212889420", phone, Message);
            //    //Response.Write(response);
            //}
        }
        catch
        {
        }
    }
    public static void SendSms_old(string Message, string phone)
    {

        string str = "";
        try
        {
            //http://sms.bsmart.in:8080/smart/SMSmartSendSMS.jsp?http://sms.bsmart.in:8080/smart/SmartSendSMS.jsp
            //str = "http://sms.bsmart.in:8080/smart/SMSmartSendSMS.jsp?usr=LABEL9420&pass=LABEL890&sid=LBVRFY&GSM=" + phone + "&msg=" + Message + "&mt=0";
            //str = "http://193.105.74.58/api/v3/sendsms/plain?user=LABEL9420&password=Sid2014!&sender=labeld&SMSText=" + Message + "&GSM=" + phone;
            //str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A7285cc769f5ed203e7d8cee48444dbb8&sender=SIDEMO&to=" + phone + "&message=" + Message;

            str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A3f78a344d70a9e35c006e938f428f591&sender=LBVRFY&to=" + phone + "&message=" + Message;

            SendSMSBody(str);


            // WebRequest request = WebRequest.Create(str);
            //request.Method = "POST";
            //string postData = "";
            //byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            //request.ContentType = "application/x-www-form-urlencoded";
            //request.ContentLength = byteArray.Length;
            //Stream dataStream = request.GetRequestStream();
            //dataStream.Write(byteArray, 0, byteArray.Length);
            //dataStream.Close();
            //WebResponse response = request.GetResponse();
            //Console.WriteLine(((HttpWebResponse)response).StatusDescription);
            //dataStream = response.GetResponseStream();
            //StreamReader reader = new StreamReader(dataStream);
            //string responseFromServer = reader.ReadToEnd();
            //Console.WriteLine(responseFromServer);
            //reader.Close();
            //dataStream.Close();
            //response.Close();
        }
        catch
        {
        }




    }
    /// <summary>
    /// Get SMS text  and send it to the mobile no
    /// </summary>
    /// <param name="str"></param>
    public static void SendSMSBody(string str)
    {
        try
        {
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
        catch (Exception)
        {

        }
    }
    public static string GetIP()
    {
        string Ipaddress;
        Ipaddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (Ipaddress == "" || Ipaddress == null)
        {
            Ipaddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }

        return Ipaddress;

    }
}

public static class ExecuteNonQueryAndDatatable
{
    private static Database database = DatabaseFactory.CreateDatabase();
    private static DbCommand dbCommand;
    public static DataSet GetRunSurveyQuestion(string compid, string txtMobile)//,string listComments
    {
        try
        {
            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");
            dbCommand = database.GetStoredProcCommand("Proc_RunSurveyQuestion");
            database.AddInParameter(dbCommand, "compid", DbType.String, compid);
            database.AddInParameter(dbCommand, "mobile", DbType.String, txtMobile);
            //database.AddInParameter(dbCommand, "Comp_Doc_Flagid", DbType.String, Comp_Doc_Row_id);
            //database.AddInParameter(dbCommand, "listComments", DbType.String, listComments);
            // database.AddInParameter(dbCommand, "@flag", DbType.String, flag);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    public static DataSet GetStoreProcedure(string Procedurename, string Parma1, string Value1, string Param2 = "", string Value2 = "", string Param3 = "", string Value3 = "", string Param4 = "", string Value4 = "", string Param5 = "", string Value5 = "", string Param6 = "", string Value6 = "")
    {
        try
        {
            //dbCommand = database.GetStoredProcCommand("GetWalletList");
            dbCommand = database.GetStoredProcCommand(Procedurename);
            dbCommand.CommandTimeout = 1000000;
            database.AddInParameter(dbCommand, Parma1, DbType.String, Value1);
            if (Param2 != "")
                database.AddInParameter(dbCommand, Param2, DbType.String, Value2);
            if (Param3 != "")
                database.AddInParameter(dbCommand, Param3, DbType.String, Value3);
            if (Param4 != "")
                database.AddInParameter(dbCommand, Param4, DbType.String, Value4);
            if (Param5 != "")
                database.AddInParameter(dbCommand, Param5, DbType.String, Value5);
            if (Param6 != "")
                database.AddInParameter(dbCommand, Param6, DbType.String, Value6);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    public static int InsUpdStoreProcedure(string Procedurename, string Parma1, string Value1, string Param2 = "", string Value2 = "", string Param3 = "", string Value3 = "", string Param4 = "", string Value4 = "", string Param5 = "", string Value5 = "", string Param6 = "", string Value6 = "", string Param7 = "", string Value7 = "", string Param8 = "", string Value8 = "", string Param9 = "", string Value9 = "", string Param10 = "", string Value10 = "", string Param11 = "", string Value11 = "", string Param12 = "", string Value12 = "")
    {
        try
        {
            //dbCommand = database.GetStoredProcCommand("GetWalletList");
            dbCommand = database.GetStoredProcCommand(Procedurename);
            dbCommand.CommandTimeout = 1000000;
            database.AddInParameter(dbCommand, Parma1, DbType.String, Value1);
            if (Param2 != "")
                database.AddInParameter(dbCommand, Param2, DbType.String, Value2);
            if (Param3 != "")
                database.AddInParameter(dbCommand, Param3, DbType.String, Value3);
            if (Param4 != "")
                database.AddInParameter(dbCommand, Param4, DbType.String, Value4);
            if (Param5 != "")
                database.AddInParameter(dbCommand, Param5, DbType.String, Value5);
            if (Param6 != "")
                database.AddInParameter(dbCommand, Param6, DbType.String, Value6);
            if (Param7 != "")
                database.AddInParameter(dbCommand, Param7, DbType.String, Value7);
            if (Param8 != "")
                database.AddInParameter(dbCommand, Param8, DbType.String, Value8);
            if (Param9 != "")
                database.AddInParameter(dbCommand, Param9, DbType.String, Value9);
            if (Param10 != "")
                database.AddInParameter(dbCommand, Param10, DbType.String, Value10);
            if (Param11 != "")
                database.AddInParameter(dbCommand, Param11, DbType.String, Value11);
            if (Param12 != "")
                database.AddInParameter(dbCommand, Param12, DbType.String, Value12);

            return database.ExecuteNonQuery(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }




    public static DataSet Proc_VerifyDoc(string compid, string Comp_Doc_Row_id)//,string listComments
    {
        try
        {
            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");
            dbCommand = database.GetStoredProcCommand("Proc_VerifyDocumentsByAdmin");
            database.AddInParameter(dbCommand, "compid", DbType.String, compid);
            database.AddInParameter(dbCommand, "Comp_Doc_Flagid", DbType.String, Comp_Doc_Row_id);
            //database.AddInParameter(dbCommand, "listComments", DbType.String, listComments);
            // database.AddInParameter(dbCommand, "@flag", DbType.String, flag);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    public static DataSet Proc_GetInvoiceData(string compid, string Pro_id, string strInvoiceid)//,string listComments
    {
        try
        {
            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");
            dbCommand = database.GetStoredProcCommand("Proc_GetInvoiceData");
            database.AddInParameter(dbCommand, "compid", DbType.String, compid);
            database.AddInParameter(dbCommand, "Pro_id", DbType.String, Pro_id);
            database.AddInParameter(dbCommand, "strInvoiceid", DbType.String, strInvoiceid);
            // database.AddInParameter(dbCommand, "Comp_Doc_Flagid", DbType.String, Comp_Doc_Row_id);
            //database.AddInParameter(dbCommand, "listComments", DbType.String, listComments);
            // database.AddInParameter(dbCommand, "@flag", DbType.String, flag);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    public static DataSet Proc_GetGiftList(string compid, string ServiceId)//,string listComments
    {
        try
        {
            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");
            dbCommand = database.GetStoredProcCommand("Proc_GetGiftList");
            database.AddInParameter(dbCommand, "compid", DbType.String, compid);
            database.AddInParameter(dbCommand, "ServiceId", DbType.String, ServiceId);
            //database.AddInParameter(dbCommand, "listComments", DbType.String, listComments);
            // database.AddInParameter(dbCommand, "@flag", DbType.String, flag);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }


    public static DataSet Proc_InsUpdtGiftDispatch(string strGift_PkidList, string strMConsu_PkidList, string strdealerCourier, int strdealerCourierid, DateTime? dispdate, DateTime? expdate,
        string comp_id, string strCodeConsumer_Pkid, string sst_id, string servicetype)//,string listComments
    {
        try
        {
            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");
            dbCommand = database.GetStoredProcCommand("Proc_InsUpdtGiftDispatch");
            database.AddInParameter(dbCommand, "strGift_PkidList", DbType.String, strGift_PkidList);
            database.AddInParameter(dbCommand, "strMConsu_PkidList", DbType.String, strMConsu_PkidList);
            database.AddInParameter(dbCommand, "@strdealerCourier", DbType.String, strdealerCourier);
            database.AddInParameter(dbCommand, "@dealeridORcourierid", DbType.Int32, strdealerCourierid);
            //database.AddInParameter(dbCommand, "courid", DbType.Int32, courid);
            database.AddInParameter(dbCommand, "dispdate", DbType.DateTime, dispdate);
            database.AddInParameter(dbCommand, "expdate", DbType.DateTime, expdate);
            database.AddInParameter(dbCommand, "@comp_id", DbType.String, comp_id);
            database.AddInParameter(dbCommand, "@strCodeConsumer_Pkid", DbType.String, strCodeConsumer_Pkid);
            database.AddInParameter(dbCommand, "@sst_id", DbType.String, sst_id);
            database.AddInParameter(dbCommand, "@servicetype", DbType.String, servicetype);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    public static DataSet Proc_InsUpdtRedeemPoints(string strBLoyalty_PointEarnedID, long intM_Consumerid, int intPoints, string strCompid, string SST_id, string gift_id,
        DateTime CreatedDate, string strTypeCashOrGift, int intTotalPoints)//,string listComments
    {
        try
        {
            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");
            dbCommand = database.GetStoredProcCommand("Proc_InsUpdtRedeemPoints");
            database.AddInParameter(dbCommand, "strBLoyalty_PointEarnedID", DbType.String, strBLoyalty_PointEarnedID);
            //    database.AddInParameter(dbCommand, "strConsumer_Pkid", DbType.String, strConsumer_Pkid);
            database.AddInParameter(dbCommand, "intM_Consumerid", DbType.Int64, intM_Consumerid);
            database.AddInParameter(dbCommand, "intPoints", DbType.Int32, intPoints);
            database.AddInParameter(dbCommand, "strCompid", DbType.String, strCompid);
            database.AddInParameter(dbCommand, "SST_id", DbType.String, SST_id);
            database.AddInParameter(dbCommand, "gift_id", DbType.String, gift_id);
            database.AddInParameter(dbCommand, "CreatedDate", DbType.DateTime, CreatedDate);
            database.AddInParameter(dbCommand, "CashOrGift", DbType.String, strTypeCashOrGift);
            database.AddInParameter(dbCommand, "intTotalPoints", DbType.Int32, intTotalPoints);
            // database.AddInParameter(dbCommand, "@dtimeSpan", DbType.String, dtimeSpan);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    public static DataSet Proc_InsUpdtRedeemPoints_Referral(string strBLoyalty_PointEarnedID, long intM_Consumerid, int intPoints, string strCompid,
       string servicename, string gift_id,
       DateTime CreatedDate, string strTypeCashOrGift, int intTotalPoints, int BPointsPaytmid)//,string listComments
    {
        try
        {
            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");
            dbCommand = database.GetStoredProcCommand("[Proc_InsUpdtRedeemPoints_Referral]");
            database.AddInParameter(dbCommand, "strBLoyalty_PointEarnedID", DbType.String, strBLoyalty_PointEarnedID);
            //    database.AddInParameter(dbCommand, "strConsumer_Pkid", DbType.String, strConsumer_Pkid);
            database.AddInParameter(dbCommand, "intM_Consumerid", DbType.Int64, intM_Consumerid);
            database.AddInParameter(dbCommand, "intPoints", DbType.Int32, intPoints);
            database.AddInParameter(dbCommand, "strCompid", DbType.String, strCompid);

            database.AddInParameter(dbCommand, "gift_id", DbType.String, gift_id);
            database.AddInParameter(dbCommand, "servicename", DbType.String, servicename);
            database.AddInParameter(dbCommand, "CreatedDate", DbType.DateTime, CreatedDate);
            database.AddInParameter(dbCommand, "CashOrGift", DbType.String, strTypeCashOrGift);
            database.AddInParameter(dbCommand, "intTotalPoints", DbType.Int32, intTotalPoints);
            database.AddInParameter(dbCommand, "BPointsPaytmid", DbType.Int32, BPointsPaytmid);

            // database.AddInParameter(dbCommand, "@dtimeSpan", DbType.String, dtimeSpan);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    public static DataSet InsertGetRunSurveyQuestion(string strRate1TO5List, string strQs_PkidList, string strMobileNo, long intM_Consumer_MCOde)//,string listComments
    {
        try
        {
            //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");
            dbCommand = database.GetStoredProcCommand("Proc_InsertGetRunSurveyQuestion");
            database.AddInParameter(dbCommand, "strRate1TO5List", DbType.String, strRate1TO5List);
            database.AddInParameter(dbCommand, "strQs_PkidList", DbType.String, strQs_PkidList);
            database.AddInParameter(dbCommand, "strMobileNo", DbType.String, strMobileNo);
            database.AddInParameter(dbCommand, "@intM_Consumer_MCOde", DbType.Int64, intM_Consumer_MCOde);
            database.AddInParameter(dbCommand, "@CD", DbType.DateTime, DateTime.Now);
            ////database.AddInParameter(dbCommand, "courid", DbType.Int32, courid);
            //database.AddInParameter(dbCommand, "dispdate", DbType.DateTime, dispdate);
            //database.AddInParameter(dbCommand, "expdate", DbType.DateTime, expdate);
            //database.AddInParameter(dbCommand, "@comp_id", DbType.String, comp_id);
            //database.AddInParameter(dbCommand, "@strCodeConsumer_Pkid", DbType.String, strCodeConsumer_Pkid);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }


    public static DataTable FillDocumentData(Business9420.Object9420 Reg)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("DocName", typeof(string));
        dt.Columns.Add("DocDet", typeof(string));
        dt.Columns.Add("Status", typeof(string));
        dt.Columns.Add("Row_Id", typeof(string));
        dt.Columns.Add("Download", typeof(string));
        dt.Columns.Add("StatusName", typeof(string));
        dt.Columns.Add("StatusImg", typeof(string));
        dt.Columns.Add("FlagID", typeof(string));
        dt.Columns.Add("Remarks", typeof(string));
        DataTable ds = new DataTable(); DataTable ds1 = new DataTable();

        DataSet dsMain = function9420.FindCompanyDocuments(Reg);
        ds = dsMain.Tables[0]; // function9420.FindDataForDocuments(Reg);
        ds1 = dsMain.Tables[1];// function9420.FindVerifyData(Reg);
        if ((ds.Rows.Count > 0) && (ds1.Rows.Count > 0))
        {

            if (ds1.Rows.Count == 1)
            {
                dt = AddNewRows(dt, "Company Sound File", ds.Rows[0]["Comp_Info"].ToString(), ds1.Rows[0]["Flag"].ToString(), "Company Sound File" + "," + ds1.Rows[0]["Row_ID"].ToString(), "", ds1.Rows[0]["Row_ID"].ToString(), ds1.Rows[0]["remarks"].ToString());
            }
            if (ds1.Rows.Count >= 6)
            {
                dt = AddNewRows(dt, "Address Proof", ds.Rows[0]["Addressproof"].ToString(), ds1.Rows[0]["Flag"].ToString(), "Address Proof" + "," + ds1.Rows[0]["Row_ID"].ToString(), "Download", ds1.Rows[0]["Row_ID"].ToString(), ds1.Rows[0]["remarks"].ToString());
                dt = AddNewRows(dt, "Company Information", ds.Rows[0]["Comp_Info"].ToString(), ds1.Rows[1]["Flag"].ToString(), "Company Information" + "," + ds1.Rows[1]["Row_ID"].ToString(), "", ds1.Rows[1]["Row_ID"].ToString(), ds1.Rows[1]["remarks"].ToString());
                dt = AddNewRows(dt, "Owner/Director Proof", ds.Rows[0]["Owner_proof"].ToString(), ds1.Rows[2]["Flag"].ToString(), "Owner/Director Proof" + "," + ds1.Rows[2]["Row_ID"].ToString(), "Download", ds1.Rows[2]["Row_ID"].ToString(), ds1.Rows[2]["remarks"].ToString());
                dt = AddNewRows(dt, "PAN/TAN No.", ds.Rows[0]["PAN_TAN"].ToString(), ds1.Rows[3]["Flag"].ToString(), "PAN/TAN No." + "," + ds1.Rows[3]["Row_ID"].ToString(), "", ds1.Rows[3]["Row_ID"].ToString(), ds1.Rows[3]["remarks"].ToString());
                if (ds1.Rows.Count == 6)
                {
                    dt = AddNewRows(dt, "Signature", ds.Rows[0]["Signproof"].ToString(), ds1.Rows[4]["Flag"].ToString(), "Signature" + "," + ds1.Rows[4]["Row_ID"].ToString(), "Download", ds1.Rows[4]["Row_ID"].ToString(), ds1.Rows[4]["remarks"].ToString());
                    dt = AddNewRows(dt, "VAT No.", ds.Rows[0]["VAT"].ToString(), ds1.Rows[5]["Flag"].ToString(), "VAT No." + "," + ds1.Rows[5]["Row_ID"].ToString(), "", ds1.Rows[5]["Row_ID"].ToString(), ds1.Rows[5]["remarks"].ToString());
                    dt = AddNewRows(dt, "Company Sound File", "No Sound file", "", "", "", ds1.Rows[5]["Flag"].ToString(), "");
                }
                else if (ds1.Rows.Count == 7)
                {
                    dt = AddNewRows(dt, "Signature", ds.Rows[0]["Signproof"].ToString(), ds1.Rows[4]["Flag"].ToString(), "Signature" + "," + ds1.Rows[4]["Row_ID"].ToString(), "Download", ds1.Rows[4]["Row_ID"].ToString(), ds1.Rows[4]["remarks"].ToString());
                    dt = AddNewRows(dt, "VAT No.", ds.Rows[0]["VAT"].ToString(), ds1.Rows[6]["Flag"].ToString(), "VAT No." + "," + ds1.Rows[6]["Row_ID"].ToString(), "", ds1.Rows[6]["Row_ID"].ToString(), ds1.Rows[6]["remarks"].ToString());
                    // = AddNewRows(dt, "Company Sound File", ds.Rows[0]["SoundFile"].ToString(), ds1.Rows[5]["Flag"].ToString(), "Company Sound File" + "," + ds1.Rows[5]["Row_ID"].ToString(), "", ds1.Rows[5]["Row_ID"].ToString());
                    string ss = ds.Rows[0]["SoundFile"].ToString();
                    // ss = ss + "/" + Reg.Comp_ID.Substring(5) + "/" + Reg.Comp_ID.Substring(5) + ".wav";
                    // ss = "< audio style = 'width:50px' controls = 'controls' >< source src = " + ss + " type = 'dio/wav' /></ audio >";
                    // ss = "";
                    dt = AddNewRows(dt, "Company Sound File", ss, ds1.Rows[5]["Flag"].ToString(), "Company Sound File" + "," + ds1.Rows[5]["Row_ID"].ToString(), "sound", ds1.Rows[5]["Row_ID"].ToString(), ds1.Rows[5]["remarks"].ToString());
                }
            }
            // GridViewDoc.DataSource = dt;
            // GridViewDoc.DataBind();
        }
        else
        {
            DataRow dr = dt.NewRow();
            dr["DocName"] = "Document of < a style = 'color:blue;text-decoration:none;' > '" + Reg.Comp_Name + "' </ a > company are not uploaded!";
            dr["DocDet"] = "";
            dr["Status"] = "0";
            dr["Row_Id"] = "0";
            dr["Download"] = "";
            dr["StatusName"] = "";
            dr["StatusImg"] = "";
            dr["FlagID"] = "";
            dr["Remarks"] = "";
            dt.Rows.Add(dr);
            // DataSet dsn = function9420.FindData(Reg);
            //LabelAlertNewHeader.Text = "Alert";
            //LabelAlertNewText.Text = " Document of <a style='color:blue;text-decoration:none;'>'" + dsn.Tables[0].Rows[0]["Comp_Name"].ToString() + "' </a> company are not uploaded!";
            //LabelModel.Text = "No";
        }
        return dt;
    }
    private static DataTable AddNewRows(DataTable dt, string DocName, string DocDet, string Status, string Row_Id, string Download, string FlagID, string strremarks)
    {
        DataRow dr = dt.NewRow();
        dr["DocName"] = DocName;
        dr["DocDet"] = DocDet;
        dr["Status"] = Status;
        dr["Row_Id"] = Row_Id;
        dr["Download"] = Download;

        if (Status == "0")
        {
            dr["StatusName"] = "<span style='color:blue;' >Pending</span>";
            dr["StatusImg"] = ProjectSession.absoluteSiteBrowseUrl + "/content/images/" + "not_verified.png";
        }
        else if (Status == "-1")
        {
            dr["StatusName"] = "<span style='color:red;' >Rejected</span>";
            dr["StatusImg"] = ProjectSession.absoluteSiteBrowseUrl + "/content/images/" + "generated_billC.png";
        }
        else if (Status == "1")
        {
            dr["StatusName"] = "<span style='color:green;' >verified</span>";
            dr["StatusImg"] = ProjectSession.absoluteSiteBrowseUrl + "/content/images/" + "generated_bill.png";
        }
        else
        {
            dr["StatusName"] = "";
            dr["StatusImg"] = "";
        }
        dr["FlagID"] = FlagID;
        dr["Remarks"] = strremarks;
        dt.Rows.Add(dr);
        return dt;
    }
    public static DataSet CheckGiftCouponServiceStarted(int sst_id, string serviceid2)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("CheckGiftCouponServiceStarted");
            database.AddInParameter(dbCommand, "sst_id", DbType.Int32, sst_id);
            database.AddInParameter(dbCommand, "@serviceid2", DbType.String, serviceid2);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetLuckyWinners(string Pro_Rowid, DateTime? dtfrom, DateTime? dtTo, bool IsLuckyDraw, string serviceid, string comp_id)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("GetLuckyWinners");
            database.AddInParameter(dbCommand, "Pro_id", DbType.String, Pro_Rowid);
            database.AddInParameter(dbCommand, "dtfrom", DbType.DateTime, dtfrom);
            database.AddInParameter(dbCommand, "dtTo", DbType.DateTime, dtTo);
            database.AddInParameter(dbCommand, "IsLuckyDraw", DbType.Boolean, IsLuckyDraw);
            database.AddInParameter(dbCommand, "serviceid", DbType.String, serviceid);
            database.AddInParameter(dbCommand, "comp_id1", DbType.String, comp_id);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetBigdataAnalysis(string comp_id, DateTime? dtDueDate, DateTime? dtDueDate2)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[GetBigDataAnalysis]");
            database.AddInParameter(dbCommand, "comp_id", DbType.String, comp_id);
            database.AddInParameter(dbCommand, "dtDueDate", DbType.DateTime, dtDueDate);
            database.AddInParameter(dbCommand, "dtDueDate2", DbType.DateTime, dtDueDate2);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public static DataSet GetBigdataAnalysisData(Loyalty_Awards obj)
    {
        DataSet ds = new DataSet();
        try
        {
            dbCommand = database.GetStoredProcCommand("GetBigdataAnalysisData");
            database.AddInParameter(dbCommand, "DataQty", DbType.Int32, obj.DataQty);
            database.AddInParameter(dbCommand, "DataPrice", DbType.Decimal, obj.DataPrice);
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        catch (Exception Ex)
        {
            obj.Msg = Ex.Message.ToString();
            return ds;
        }
    }
    public static DataSet BigdataAnalysisDataSelect(Loyalty_Awards obj)
    {
        DataSet ds = new DataSet();
        try
        {
            dbCommand = database.GetStoredProcCommand("GetBigdataAnalysisDataSelect");
            database.AddInParameter(dbCommand, "RowId", DbType.Int32, obj.RowId);
            //database.AddInParameter(dbCommand, "DataPrice", DbType.Decimal, obj.Comp_ID);
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        catch (Exception Ex)
        {
            obj.Msg = Ex.Message.ToString();
            return ds;
        }
    }
    public static DataSet BigdataAnalysisDataInsertUpdate(Loyalty_Awards obj)
    {
        DataSet ds = new DataSet();
        try
        {
            dbCommand = database.GetStoredProcCommand("BigdataAnalysisDataInsertUpdate");
            database.AddInParameter(dbCommand, "RowId", DbType.String, obj.RowId);
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
            database.AddInParameter(dbCommand, "AwardName", DbType.String, obj.AwardName);
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        catch (Exception Ex)
        {
            obj.Msg = Ex.Message.ToString();
            return ds;
        }
    }
    public static DataSet BigdataAnalysisDataActive(Loyalty_Awards obj)
    {
        DataSet ds = new DataSet();
        try
        {
            dbCommand = database.GetStoredProcCommand("BigdataAnalysisDataActive");
            database.AddInParameter(dbCommand, "RowId", DbType.String, obj.RowId);
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        catch (Exception Ex)
        {
            obj.Msg = Ex.Message.ToString();
            return ds;
        }
    }
    //public static DataSet BigdataAnalysisSelect(string comp_id, DateTime? dtDueDate, DateTime? dtDueDate2)
    //{
    //    try
    //    {
    //        dbCommand = database.GetStoredProcCommand("[BigdataAnalysisSelect]");
    //        database.AddInParameter(dbCommand, "comp_id", DbType.String, comp_id);
    //        database.AddInParameter(dbCommand, "dtDueDate", DbType.DateTime, dtDueDate);
    //        database.AddInParameter(dbCommand, "dtDueDate2", DbType.DateTime, dtDueDate2);
    //        return database.ExecuteDataSet(dbCommand);
    //    }
    //    catch (Exception ex)
    //    {

    //        throw ex;
    //    }
    //}
    public static DataSet BigdataAnalysisSelect(long BigDataId, string comp_id)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[BigdataAnalysisSelect]");
            database.AddInParameter(dbCommand, "BigDataId", DbType.String, BigDataId);
            database.AddInParameter(dbCommand, "comp_id", DbType.String, comp_id);
            // database.AddInParameter(dbCommand, "dtDueDate", DbType.DateTime, dtDueDate);
            //  database.AddInParameter(dbCommand, "dtDueDate2", DbType.DateTime, dtDueDate2);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet BigdataAnalysisSelectDDL(long BigDataId, string comp_id, int ddlQty)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[BigdataAnalysisSelectDDL]");
            database.AddInParameter(dbCommand, "BigDataId", DbType.String, BigDataId);
            database.AddInParameter(dbCommand, "comp_id", DbType.String, comp_id);
            database.AddInParameter(dbCommand, "ddlQty", DbType.String, ddlQty);
            // database.AddInParameter(dbCommand, "dtDueDate", DbType.DateTime, dtDueDate);
            //  database.AddInParameter(dbCommand, "dtDueDate2", DbType.DateTime, dtDueDate2);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet BigdataAnalysisSelect(long BigDataId)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[BigdataAnalysisSelectForExcel]");
            database.AddInParameter(dbCommand, "BigDataId", DbType.String, BigDataId);
            //  database.AddInParameter(dbCommand, "comp_id", DbType.String, comp_id);
            // // database.AddInParameter(dbCommand, "dtDueDate", DbType.DateTime, dtDueDate);
            ////  database.AddInParameter(dbCommand, "dtDueDate2", DbType.DateTime, dtDueDate2);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet BigdataAnalysisDelete(long BigDataId, string comp_id)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[BigdataAnalysisDelete]");
            database.AddInParameter(dbCommand, "BigDataId", DbType.Int64, BigDataId);
            database.AddInParameter(dbCommand, "comp_id", DbType.String, comp_id);
            // database.AddInParameter(dbCommand, "dtDueDate", DbType.DateTime, dtDueDate);
            //  database.AddInParameter(dbCommand, "dtDueDate2", DbType.DateTime, dtDueDate2);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetTableData(string TableName, string columnName, string columnName1Value, string comp_id, int VarcharOrInt)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[GetTableData]");
            database.AddInParameter(dbCommand, "@TableName", DbType.String, TableName);
            database.AddInParameter(dbCommand, "columnName1", DbType.String, columnName);
            database.AddInParameter(dbCommand, "columnName1Value", DbType.String, columnName1Value);
            database.AddInParameter(dbCommand, "@comp_id", DbType.String, comp_id);
            database.AddInParameter(dbCommand, "@VarcharOrInt", DbType.Int16, VarcharOrInt);
            //database.AddInParameter(dbCommand, "dtDueDate2", DbType.DateTime, dtDueDate2);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetBigDataAnalysisSelectALL()
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[GetBigDataAnalysisSelectALL]");
            //database.AddInParameter(dbCommand, "@TableName", DbType.String, TableName);
            //database.AddInParameter(dbCommand, "columnName1", DbType.String, columnName);
            //database.AddInParameter(dbCommand, "columnName1Value", DbType.String, columnName1Value);
            //database.AddInParameter(dbCommand, "@comp_id", DbType.String, comp_id);
            //database.AddInParameter(dbCommand, "@VarcharOrInt", DbType.Int16, VarcharOrInt);
            //database.AddInParameter(dbCommand, "dtDueDate2", DbType.DateTime, dtDueDate2);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet InsertUpdateBigDataAnalysis(long BigDataId, string comp_idFrom, string comp_idTo, int DataStatus, int DataQty, int Price, string Createdby, string UpddatedBy, string UserType, DateTime dtUpdate)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("InsertUpdateBigDataAnalysis");
            database.AddInParameter(dbCommand, "BigDataId", DbType.Int64, BigDataId);
            database.AddInParameter(dbCommand, "@comp_idFrom", DbType.String, comp_idFrom);
            database.AddInParameter(dbCommand, "@comp_idTo", DbType.String, comp_idTo);
            database.AddInParameter(dbCommand, "@DataQty", DbType.Int32, DataQty);
            database.AddInParameter(dbCommand, "@Price", DbType.Int32, Price);
            database.AddInParameter(dbCommand, "@Createdby", DbType.String, Createdby);
            database.AddInParameter(dbCommand, "@UpddatedBy", DbType.String, UpddatedBy);
            database.AddInParameter(dbCommand, "@DataStatus", DbType.Int32, DataStatus);
            database.AddInParameter(dbCommand, "@UserType", DbType.String, UserType);
            database.AddInParameter(dbCommand, "@dtUpdate", DbType.DateTime, dtUpdate);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetConsumerList(string strMobileno, string ddlstatus, string comp_id, DateTime? dtDueDate, DateTime? dtDueTo, string Pro_Rowid, string strType)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("GetConsumerList");
            database.AddInParameter(dbCommand, "Mobileno", DbType.String, strMobileno);
            database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
            database.AddInParameter(dbCommand, "comp_id", DbType.String, comp_id);
            database.AddInParameter(dbCommand, "dtDueDate", DbType.DateTime, dtDueDate);
            database.AddInParameter(dbCommand, "dtDueTo", DbType.DateTime, dtDueTo);
            database.AddInParameter(dbCommand, "Pro_id", DbType.String, Pro_Rowid);
            database.AddInParameter(dbCommand, "Type", DbType.String, strType);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetAwardListByCompany(string strMobileno, string ddlstatus, string comp_id, DateTime? dtDueDate, string Pro_Rowid, string strType)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("GetConsumerList");
            database.AddInParameter(dbCommand, "Mobileno", DbType.String, strMobileno);
            database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
            database.AddInParameter(dbCommand, "comp_id", DbType.String, comp_id);
            database.AddInParameter(dbCommand, "dtDueDate", DbType.DateTime, dtDueDate);
            database.AddInParameter(dbCommand, "Pro_id", DbType.String, Pro_Rowid);
            database.AddInParameter(dbCommand, "Type", DbType.String, strType);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetAwardDispatchByDealerOrCourier(string serviceType, string Pro_id, int Giftid, string comp_id, DateTime? dtDueDate, string DealerOrCourier)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("GetAwardDispatchByDealerOrCourier");
            database.AddInParameter(dbCommand, "serviceType", DbType.String, serviceType);
            database.AddInParameter(dbCommand, "Pro_id", DbType.String, Pro_id);
            database.AddInParameter(dbCommand, "Giftid", DbType.Int32, Giftid);
            database.AddInParameter(dbCommand, "comp_id", DbType.String, comp_id);
            database.AddInParameter(dbCommand, "dtDueDate", DbType.DateTime, dtDueDate);
            database.AddInParameter(dbCommand, "DealerOrCourier", DbType.String, DealerOrCourier);

            // database.AddInParameter(dbCommand, "Type", DbType.String, strType);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetAwardListByReffleBuildReferral(string Pro_id, int Giftid, string strMobileno, string comp_id, DateTime? dtDueDate, string Pro_Rowid, string strType)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("GetAwardListByReffleBuildReferral");
            database.AddInParameter(dbCommand, "Pro_id", DbType.String, Pro_id);
            database.AddInParameter(dbCommand, "Giftid", DbType.Int32, Giftid);
            database.AddInParameter(dbCommand, "Mobileno", DbType.String, strMobileno);
            database.AddInParameter(dbCommand, "comp_id", DbType.String, comp_id);
            database.AddInParameter(dbCommand, "dtDueDate", DbType.DateTime, dtDueDate);
            database.AddInParameter(dbCommand, "Type", DbType.String, strType);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    public static DataSet FillGrdForCashWalletrpt(string compid, string dtFrom, String dtTo)
    {
        try
        {

            dbCommand = database.GetStoredProcCommand("GetVendorcashWalletCreditHistory");
            database.AddInParameter(dbCommand, "@compid", DbType.String, compid);

            database.AddInParameter(dbCommand, "@dtFrom", DbType.DateTime, dtFrom);
            database.AddInParameter(dbCommand, "@dtTo", DbType.DateTime, dtTo);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public static DataSet FillGrdForUPIPayoutrpt(string compid, string dtFrom, string dtTo, string st, string mobile)
    {
        try
        {

            dbCommand = database.GetStoredProcCommand("GetUPIpayoutrpt");
            database.AddInParameter(dbCommand, "@compid", DbType.String, compid);
            database.AddInParameter(dbCommand, "@mobileno", DbType.String, mobile);
            database.AddInParameter(dbCommand, "@dtFrom", DbType.DateTime, dtFrom);
            database.AddInParameter(dbCommand, "@dtTo", DbType.DateTime, dtTo);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public static DataSet FillGrdForPoints(string strPro_id, string comp_id, DateTime? dtFrom, DateTime? dtTo, string SSt_id,
        int M_Consumerid, string servicename, string servicenameDefault, string strTYpe, int IsPointsToGiftOrCashBuildLoyalty)
    {
        try
        {
            //dbCommand = database.GetStoredProcCommand("GetWalletList");
            dbCommand = database.GetStoredProcCommand("GetCashWalletList");
            database.AddInParameter(dbCommand, "@Pro_id", DbType.String, strPro_id);
            // database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
            //database.AddInParameter(dbCommand, "@comp_id", DbType.String, comp_id);
            database.AddInParameter(dbCommand, "@dtFrom", DbType.DateTime, dtFrom);
            database.AddInParameter(dbCommand, "@dtTo", DbType.DateTime, dtTo);
            //database.AddInParameter(dbCommand, "@SSt_id", DbType.String, SSt_id);
            database.AddInParameter(dbCommand, "@M_Consumerid", DbType.Int64, M_Consumerid);
            database.AddInParameter(dbCommand, "@servicename", DbType.String, servicename);
            //database.AddInParameter(dbCommand, "@servicenameDefault", DbType.String, servicenameDefault);
            //database.AddInParameter(dbCommand, "@strTYpe", DbType.String, strTYpe);
            //database.AddInParameter(dbCommand, "@IsPointsToGiftOrCashBuildLoyalty", DbType.Int32, IsPointsToGiftOrCashBuildLoyalty);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public static DataSet FillGrdForBankTransaction(string compid, string dtFrom, string dtTo, string st, string mobile, bool flag)
    {
        try
        {

            dbCommand = database.GetStoredProcCommand("GetUploadedTransactioinDetailsrpt");

            database.AddInParameter(dbCommand, "@compid", DbType.String, compid);
            database.AddInParameter(dbCommand, "@mobileno", DbType.String, mobile);
            database.AddInParameter(dbCommand, "@DateFrom", DbType.String, dtFrom);
            database.AddInParameter(dbCommand, "@DateTo", DbType.String, dtTo);
            database.AddInParameter(dbCommand, "@pstatus", DbType.String, st);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public static DataSet FillGrdForPaytm(string compid, DateTime? dtFrom, DateTime? dtTo, string st, string mobile, bool flag)
    {
        try
        {
            //dbCommand = database.GetStoredProcCommand("GetWalletList");
            if (flag)
                dbCommand = database.GetStoredProcCommand("GetPaytmrpt");
            else
                dbCommand = database.GetStoredProcCommand("GetPaytmrptdwn");

            database.AddInParameter(dbCommand, "@compid", DbType.String, compid);
            database.AddInParameter(dbCommand, "@mobileno", DbType.String, mobile);
            // database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
            database.AddInParameter(dbCommand, "@dtFrom", DbType.DateTime, dtFrom);
            database.AddInParameter(dbCommand, "@dtTo", DbType.DateTime, dtTo);
            //database.AddInParameter(dbCommand, "@flg", DbType.Int16, fl);
            database.AddInParameter(dbCommand, "@pstatus", DbType.String, st);
            //database.AddInParameter(dbCommand, "@servicenameDefault", DbType.String, servicenameDefault);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public static DataSet FillGrdForCashsrpt(string compid, DateTime? dtFrom, DateTime? dtTo, string st, string mobile, bool flag)
    {
        try
        {
            if (flag)
                dbCommand = database.GetStoredProcCommand("GetCashrpt");
            else
                dbCommand = database.GetStoredProcCommand("GetCashrptdwn");

            database.AddInParameter(dbCommand, "@compid", DbType.String, compid);
            database.AddInParameter(dbCommand, "@mobileno", DbType.String, mobile);
            // database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
            database.AddInParameter(dbCommand, "@dtFrom", DbType.DateTime, dtFrom);
            database.AddInParameter(dbCommand, "@dtTo", DbType.DateTime, dtTo);
            //database.AddInParameter(dbCommand, "@flg", DbType.Int16, fl);
            //database.AddInParameter(dbCommand, "@pstatus", DbType.String, st);
            //database.AddInParameter(dbCommand, "@servicenameDefault", DbType.String, servicenameDefault);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public static DataSet FillGrdForPointsrpt(string compid, DateTime? dtFrom, DateTime? dtTo, string st, string mobile, bool flag)
    {
        try
        {
            if (flag)
                dbCommand = database.GetStoredProcCommand("GetPointrpt");
            else
                dbCommand = database.GetStoredProcCommand("GetPointrptdwn");

            database.AddInParameter(dbCommand, "@compid", DbType.String, compid);
            database.AddInParameter(dbCommand, "@mobileno", DbType.String, mobile);
            // database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
            database.AddInParameter(dbCommand, "@dtFrom", DbType.DateTime, dtFrom);
            database.AddInParameter(dbCommand, "@dtTo", DbType.DateTime, dtTo);
            //database.AddInParameter(dbCommand, "@flg", DbType.Int16, fl);
            //database.AddInParameter(dbCommand, "@pstatus", DbType.String, st);
            //database.AddInParameter(dbCommand, "@servicenameDefault", DbType.String, servicenameDefault);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    public static DataSet FillSummary(string strPro_id, int M_Consumerid, string company_id)
    {
        try
        {
            //dbCommand = database.GetStoredProcCommand("GetWalletList");
            dbCommand = database.GetStoredProcCommand(strPro_id);
            database.AddInParameter(dbCommand, "@M_Consumerid", DbType.Int64, M_Consumerid);
            //database.AddInParameter(dbCommand, "@Company_id", DbType.String, company_id);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet FillyearSummary(string strPro_id, int M_Consumerid, string year)
    {
        try
        {
            //dbCommand = database.GetStoredProcCommand("GetWalletList");
            dbCommand = database.GetStoredProcCommand(strPro_id);
            database.AddInParameter(dbCommand, "@M_Consumerid", DbType.Int64, M_Consumerid);
            database.AddInParameter(dbCommand, "@Year", DbType.String, year);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet FilterTransactions(string strPro_id, int M_Consumerid, string filter)
    {
        try
        {
            //dbCommand = database.GetStoredProcCommand("GetWalletList");
            dbCommand = database.GetStoredProcCommand(strPro_id);
            database.AddInParameter(dbCommand, "@M_Consumerid", DbType.String, M_Consumerid);
            database.AddInParameter(dbCommand, "@filter", DbType.String, filter);
            dbCommand.CommandTimeout = 60;
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet filllocation(string comp_id, string service)
    {
        try
        {
            //dbCommand = database.GetStoredProcCommand("GetWalletList");
            dbCommand = database.GetStoredProcCommand("[getlocation]");

            dbCommand.Parameters.Add(new SqlParameter("@Company", comp_id));
            dbCommand.Parameters.Add(new SqlParameter("@Service", service));

            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet Fillcodeverification(string comp_id, string pro_id, DateTime enq_date, DateTime start_date, string status, string remarks, string mobileno, string location, string service)
    {
        try
        {
            //string circleflag = "N";
            //string[] locations = location.Split(',');
            //int pos = Array.IndexOf(locations, "");
            //if (pos > -1 || location=="")
            //{
            //    circleflag = "Y";
            //}
            if (service == "SRV1018")
            {
                string Proc_Name = string.Empty;
                DataTable dtproc = SQL_DB.ExecuteDataTable("select Proc_Name from tbl_Codeverification_procedurelist where Comp_id='"+ comp_id + "' and isactive=1 and isdelete=0");
                if (dtproc.Rows.Count > 0)
                {
                    Proc_Name = dtproc.Rows[0][0].ToString();
                }
                else
                {
                    Proc_Name = "web_SUPPORT_counter";
                }
                string dtstrt = start_date.ToString("yyyy-MM-dd");
                //dbCommand = database.GetStoredProcCommand("GetWalletList");
                dbCommand = database.GetStoredProcCommand(Proc_Name);

            }
            else
            {
                string dtstrt = start_date.ToString("yyyy-MM-dd");
                //dbCommand = database.GetStoredProcCommand("GetWalletList");
                dbCommand = database.GetStoredProcCommand("[web_SUPPORT]");
            }
            dbCommand.Parameters.Add(new SqlParameter("@companyid", comp_id));
            dbCommand.Parameters.Add(new SqlParameter("@product", pro_id));
            dbCommand.Parameters.Add(new SqlParameter("@enq_date", enq_date.ToString("yyyy-MM-dd") + " 23:59:59.999"));//DateTime.Today
            dbCommand.Parameters.Add(new SqlParameter("@status", status.Trim()));
            dbCommand.Parameters.Add(new SqlParameter("@Remarks", remarks.Trim()));
            dbCommand.Parameters.Add(new SqlParameter("@mobile", mobileno.Trim()));
            dbCommand.Parameters.Add(new SqlParameter("@start_date", start_date.ToString("yyyy-MM-dd")));
            dbCommand.Parameters.Add(new SqlParameter("@Location", location.Trim()));
            dbCommand.Parameters.Add(new SqlParameter("@service", service.Trim()));
            //dbCommand.Parameters.Add(new SqlParameter("@circleflag", circleflag.Trim()));
            dbCommand.CommandTimeout = 500;
            return database.ExecuteDataSet(dbCommand);


        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public static DataSet GetTransactionData(DateTime? dtFrom, DateTime? dtTo)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("usp_TransactionData");
            database.AddInParameter(dbCommand, "start_date", DbType.DateTime, dtFrom);
            database.AddInParameter(dbCommand, "enq_date", DbType.DateTime, dtTo);

            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetBankTransactionData(DateTime? dtFrom, DateTime? dtTo)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("usp_BankTransactionData");
            database.AddInParameter(dbCommand, "start_date", DbType.DateTime, dtFrom);
            database.AddInParameter(dbCommand, "enq_date", DbType.DateTime, dtTo);

            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet FillTransactions(string strPro_id, int M_Consumerid, string distributorid = "")
    {
        try
        {
            //dbCommand = database.GetStoredProcCommand("GetWalletList");
            dbCommand = database.GetStoredProcCommand(strPro_id);
            dbCommand.CommandTimeout = 1000000;
            database.AddInParameter(dbCommand, "@M_Consumerid", DbType.String, M_Consumerid);
            database.AddInParameter(dbCommand, "@distributorid", DbType.String, distributorid);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static String checkscalarvalues(string strPro_id, int M_Consumerid)
    {
        try
        {
            //dbCommand = database.GetStoredProcCommand("GetWalletList");
            dbCommand = database.GetStoredProcCommand(strPro_id);
            database.AddInParameter(dbCommand, "@M_Consumerid", DbType.String, M_Consumerid);
            return database.ExecuteScalar(dbCommand).ToString();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static String location_update(location loc)
    {
        try
        {
            //dbCommand = database.GetStoredProcCommand("GetWalletList");
            dbCommand = database.GetStoredProcCommand("locationupdate");
            database.AddInParameter(dbCommand, "@lat", DbType.String, loc.latitude);
            database.AddInParameter(dbCommand, "@long", DbType.String, loc.longitude);
            database.AddInParameter(dbCommand, "@mobileno", DbType.String, loc.mobileno);
            database.AddInParameter(dbCommand, "@code1", DbType.String, loc.code1);
            database.AddInParameter(dbCommand, "@code2", DbType.String, loc.code2);
            database.AddInParameter(dbCommand, "@city", DbType.String, loc.city);
            database.AddInParameter(dbCommand, "@state", DbType.String, loc.state);
            database.AddInParameter(dbCommand, "@Country", DbType.String, loc.country);
            database.AddInParameter(dbCommand, "@address", DbType.String, loc.address);
            return database.ExecuteNonQuery(dbCommand).ToString();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public static String location_update1(location loc)
    {
        try
        {
            //dbCommand = database.GetStoredProcCommand("GetWalletList");
            dbCommand = database.GetStoredProcCommand("New_locationupdate");
            database.AddInParameter(dbCommand, "@lat", DbType.String, loc.latitude);
            database.AddInParameter(dbCommand, "@long", DbType.String, loc.longitude);
            database.AddInParameter(dbCommand, "@mobileno", DbType.String, loc.mobileno);
            database.AddInParameter(dbCommand, "@code1", DbType.String, loc.code1);
            database.AddInParameter(dbCommand, "@code2", DbType.String, loc.code2);
            database.AddInParameter(dbCommand, "@city", DbType.String, loc.city);
            database.AddInParameter(dbCommand, "@state", DbType.String, loc.state);
            database.AddInParameter(dbCommand, "@Country", DbType.String, loc.country);
            database.AddInParameter(dbCommand, "@address", DbType.String, loc.address);
            database.AddInParameter(dbCommand, "@PostalCode", DbType.String, loc.PostalCode);
            database.AddInParameter(dbCommand, "@entrydate", DbType.DateTime, loc.EnqDate);

            return database.ExecuteNonQuery(dbCommand).ToString();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public static String checkmahindra(string strPro_id, string M_Consumerid)
    {
        try
        {
            //dbCommand = database.GetStoredProcCommand("GetWalletList");
            dbCommand = database.GetStoredProcCommand(strPro_id);
            database.AddInParameter(dbCommand, "@M_Consumerid", DbType.String, M_Consumerid);
            return database.ExecuteScalar(dbCommand).ToString();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetFillGrdForPoints(string strPro_id, DateTime? dtFrom, DateTime? dtTo, int M_Consumerid, string servicename, int isCashConvert)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("GetCashWalletList1");//GetCashWalletList
            database.AddInParameter(dbCommand, "@Pro_id", DbType.String, strPro_id);
            database.AddInParameter(dbCommand, "@dtFrom", DbType.DateTime, dtFrom);
            database.AddInParameter(dbCommand, "@dtTo", DbType.DateTime, dtTo);
            database.AddInParameter(dbCommand, "@M_Consumerid", DbType.Int64, M_Consumerid);
            database.AddInParameter(dbCommand, "@servicename", DbType.String, servicename);
            database.AddInParameter(dbCommand, "@isCashConvert", DbType.Int16, isCashConvert);

            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public static DataSet FillGrdBPointsTransaction(string strPro_id, string comp_id, DateTime? dtFrom, DateTime? dtTo, string SSt_id,
       long M_Consumerid, int Tranid, string servicename, string servicenameDefault, string strTYpe, int IsPointsToGiftOrCashBuildLoyalty, string mobileno, int PointAdjustStatus)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("Select_BPointsTransaction");
            //database.AddInParameter(dbCommand, "Pro_id", DbType.String, strPro_id);
            //// database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
            database.AddInParameter(dbCommand, "comp_id", DbType.String, comp_id);
            //database.AddInParameter(dbCommand, "dtFrom", DbType.DateTime, dtFrom);
            //database.AddInParameter(dbCommand, "dtTo", DbType.DateTime, dtTo);
            //database.AddInParameter(dbCommand, "SSt_id", DbType.String, SSt_id);
            database.AddInParameter(dbCommand, "M_Consumerid", DbType.Int64, M_Consumerid);
            database.AddInParameter(dbCommand, "Tranid", DbType.Int32, Tranid);
            database.AddInParameter(dbCommand, "mobileno", DbType.String, mobileno);
            database.AddInParameter(dbCommand, "PointAdjustStatus", DbType.Int32, PointAdjustStatus);
            //database.AddInParameter(dbCommand, "servicename", DbType.String, servicename);
            //database.AddInParameter(dbCommand, "servicenameDefault", DbType.String, servicenameDefault);
            //database.AddInParameter(dbCommand, "@strTYpe", DbType.String, strTYpe);
            database.AddInParameter(dbCommand, "@IsPointsToGiftOrCashBuildLoyalty", DbType.Int32, IsPointsToGiftOrCashBuildLoyalty);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet FillGrdForPoints_New(string strPro_id, string comp_id, DateTime? dtFrom, DateTime? dtTo,
        string SSt_id, int M_Consumerid, string servicename, string servicenameDefault, string strTYpe)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[GetWalletList_PointsTran]");
            database.AddInParameter(dbCommand, "Pro_id", DbType.String, strPro_id);
            // database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
            database.AddInParameter(dbCommand, "comp_id", DbType.String, comp_id);
            database.AddInParameter(dbCommand, "dtFrom", DbType.DateTime, dtFrom);
            database.AddInParameter(dbCommand, "dtTo", DbType.DateTime, dtTo);
            database.AddInParameter(dbCommand, "SSt_id", DbType.String, SSt_id);
            database.AddInParameter(dbCommand, "M_Consumerid", DbType.Int32, M_Consumerid);
            database.AddInParameter(dbCommand, "servicename", DbType.String, servicename);
            database.AddInParameter(dbCommand, "servicenameDefault", DbType.String, servicenameDefault);
            database.AddInParameter(dbCommand, "@strTYpe", DbType.String, strTYpe);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet FillGrdForEmployee(string strname, string steEmail, DateTime? dtFrom, DateTime? dtTo)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("GetEmployeeList");

            database.AddInParameter(dbCommand, "@name", DbType.String, strname);
            // database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
            database.AddInParameter(dbCommand, "@Email", DbType.String, steEmail);
            database.AddInParameter(dbCommand, "dtFrom", DbType.DateTime, dtFrom);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet FillGrdForRedeem(string strPro_id, string comp_id, DateTime? dtFrom, DateTime? dtTo, string SSt_id,
        int M_Consumerid, string servicename, string servicenameDefault, string strTYpe, int IsPointsToGiftOrCashBuildLoyalty)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("GetRedeem");
            database.AddInParameter(dbCommand, "Pro_id", DbType.String, strPro_id);
            // database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
            database.AddInParameter(dbCommand, "comp_id", DbType.String, comp_id);
            database.AddInParameter(dbCommand, "dtFrom", DbType.DateTime, dtFrom);
            database.AddInParameter(dbCommand, "dtTo", DbType.DateTime, dtTo);
            database.AddInParameter(dbCommand, "@IsPointsToGiftOrCashBuildLoyalty", DbType.Int32, IsPointsToGiftOrCashBuildLoyalty);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetWalletListByBuildLoyaltyAwards(string strPro_id, string comp_id, DateTime? dtFrom, DateTime? dtTo, string SSt_id, int M_Consumerid, string servicename, string servicenameDefault, string strTYpe)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("GetWalletListByBuildLoyaltyAwards");
            database.AddInParameter(dbCommand, "Pro_id", DbType.String, strPro_id);
            // database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
            database.AddInParameter(dbCommand, "comp_id", DbType.String, comp_id);
            database.AddInParameter(dbCommand, "dtFrom", DbType.DateTime, dtFrom);
            database.AddInParameter(dbCommand, "dtTo", DbType.DateTime, dtTo);
            database.AddInParameter(dbCommand, "SSt_id", DbType.String, SSt_id);
            database.AddInParameter(dbCommand, "M_Consumerid", DbType.Int32, M_Consumerid);
            database.AddInParameter(dbCommand, "servicename", DbType.String, servicename);
            database.AddInParameter(dbCommand, "servicenameDefault", DbType.String, servicenameDefault);
            database.AddInParameter(dbCommand, "@strTYpe", DbType.String, strTYpe);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet FillGrdForPointDetailsByBUildLoyalty(string strPro_id, string comp_id, DateTime? dtFrom, DateTime? dtTo, string SSt_id, int M_Consumerid, string servicename, string servicenameDefault, string strTYpe)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("GetWalletListDetailsByBuildLoyalty");
            database.AddInParameter(dbCommand, "Pro_id", DbType.String, strPro_id);
            // database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
            database.AddInParameter(dbCommand, "comp_id", DbType.String, comp_id);
            database.AddInParameter(dbCommand, "dtFrom", DbType.DateTime, dtFrom);
            database.AddInParameter(dbCommand, "dtTo", DbType.DateTime, dtTo);
            database.AddInParameter(dbCommand, "SSt_id", DbType.String, SSt_id);
            database.AddInParameter(dbCommand, "M_Consumerid", DbType.Int32, M_Consumerid);
            database.AddInParameter(dbCommand, "servicename", DbType.String, servicename);
            database.AddInParameter(dbCommand, "servicenameDefault", DbType.String, servicenameDefault);
            database.AddInParameter(dbCommand, "@strTYpe", DbType.String, strTYpe);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet FillGrdForPointsByBuildLoyalty(string strPro_id, string comp_id, DateTime? dtFrom, DateTime? dtTo, string SSt_id, int M_Consumerid,
        string servicename, string servicenameDefault, string strTYpe)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[GetWalletListByBuildLoyalty]");
            database.AddInParameter(dbCommand, "Pro_id", DbType.String, strPro_id);
            // database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
            database.AddInParameter(dbCommand, "comp_id", DbType.String, comp_id);
            database.AddInParameter(dbCommand, "dtFrom", DbType.DateTime, dtFrom);
            database.AddInParameter(dbCommand, "dtTo", DbType.DateTime, dtTo);
            database.AddInParameter(dbCommand, "SSt_id", DbType.String, SSt_id);
            database.AddInParameter(dbCommand, "M_Consumerid", DbType.Int32, M_Consumerid);
            database.AddInParameter(dbCommand, "servicename", DbType.String, servicename);
            database.AddInParameter(dbCommand, "servicenameDefault", DbType.String, servicenameDefault);
            database.AddInParameter(dbCommand, "@strTYpe", DbType.String, strTYpe);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetGiftByCompany(string comp_id)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("GetGiftByCompany");
            database.AddInParameter(dbCommand, "@Comp_id", DbType.String, comp_id);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }




    public static void FillProduct(string Comp_ID, DropDownList ddlproname, string Service_ID)//,
    {

        try
        {
            dbCommand = database.GetStoredProcCommand("[FillProduct]");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Comp_ID);
            // database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
            database.AddInParameter(dbCommand, "Service_ID", DbType.String, Service_ID);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            DataProvider.MyUtilities.FillDDLInsertBlankIndex(ds, "Pro_ID", "Pro_Name", ddlproname, "--Product--");
            ddlproname.SelectedIndex = 0;
        }
        catch (Exception ex)
        {

            throw ex;
        }



        //string strServiceQry = string.Empty;
        //strServiceQry = " AND () ";



        //  DataSet ds = SQL_DB.ExecuteDataSet("SELECT p.Comp_ID, p.Pro_ID ,p.Pro_Name FROM Pro_Reg AS p WHERE (p.Doc_Flag = 1) AND (p.Sound_Flag = 1) AND (p.Pro_ID IN (SELECT s.Pro_ID FROM M_ServiceSubscription as s " +

        //" WHERE (''='" + Comp_ID + "' OR s.comp_ID='" + Comp_ID + "') AND  (s.Service_ID IN (SELECT m.Service_ID FROM M_ServiceFeature as m WHERE (m.IsNotify = 0)))))");



        //  DataProvider.MyUtilities.FillDDLInsertBlankIndex(ds, "Pro_ID", "Pro_Name", ddlproname, "--Product--");
        //  ddlproname.SelectedIndex = 0;
        // fillData();
    }

    public static void FillCompany(DropDownList ddlCompany)
    {
        DataSet ds = ExecuteNonQueryAndDatatable.GetTableData("Comp_Reg", "Status", "1", "", 1);
        DataProvider.MyUtilities.FillDDLInsertBlankIndex(ds, "Comp_ID", "Comp_Name", ddlCompany, "--Company--");
        ddlCompany.SelectedIndex = 0;
    }
    public static DataSet getfilterdata(string strqry)
    {
        dbCommand = database.GetSqlStringCommand(strqry);
        dbCommand.CommandTimeout = 100000;
        //  database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Comp_ID);
        // database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
        //database.AddInParameter(dbCommand, "Service_ID", DbType.String, Service_ID);
        DataSet ds = database.ExecuteDataSet(dbCommand);
        return ds;
    }
    public static DataSet getM_Label_Request(string Pro_ID)
    {
        dbCommand = database.GetStoredProcCommand("[GetM_Label_Request]");
        database.AddInParameter(dbCommand, "@Pro_ID", DbType.String, Pro_ID);
        // database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
        //database.AddInParameter(dbCommand, "Service_ID", DbType.String, Service_ID);
        DataSet ds = database.ExecuteDataSet(dbCommand);
        return ds;
    }
    public static DataSet GetM_Label_RequestbyPro_id(string Pro_ID)
    {
        dbCommand = database.GetStoredProcCommand("[GetM_Label_RequestbyPro_id]");
        database.AddInParameter(dbCommand, "@Pro_ID", DbType.String, Pro_ID);
        // database.AddInParameter(dbCommand, "ddlstatus", DbType.String, ddlstatus);
        //database.AddInParameter(dbCommand, "Service_ID", DbType.String, Service_ID);
        DataSet ds = database.ExecuteDataSet(dbCommand);
        return ds;
    }

    public static void UpdateM_code_ReceiveFlagCompId(string Courier_Disp_ID)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[UpdateM_code_ReceiveFlag_PFL]");
            database.AddInParameter(dbCommand, "@Courier_Disp_ID", DbType.String, Courier_Disp_ID);
            //database.AddInParameter(dbCommand, "@pcount", DbType.Int32, pcount);
            //database.AddInParameter(dbCommand, "@Pro_ID", DbType.String, Pro_ID);
            //database.AddInParameter(dbCommand, "@Series_Order", DbType.Int32, Series_Order);
            //database.AddInParameter(dbCommand, "@Series_Serial", DbType.Int32, Series_Serial);
            //database.AddInParameter(dbCommand, "@Series_Serial1", DbType.Int32, Series_Serial1);
            DataSet ds = database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    public static void UpdateM_code_ReceiveFlag(string Courier_Disp_ID)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[UpdateM_code_ReceiveFlag]");
            database.AddInParameter(dbCommand, "@Courier_Disp_ID", DbType.String, Courier_Disp_ID);
            //database.AddInParameter(dbCommand, "@pcount", DbType.Int32, pcount);
            //database.AddInParameter(dbCommand, "@Pro_ID", DbType.String, Pro_ID);
            //database.AddInParameter(dbCommand, "@Series_Order", DbType.Int32, Series_Order);
            //database.AddInParameter(dbCommand, "@Series_Serial", DbType.Int32, Series_Serial);
            //database.AddInParameter(dbCommand, "@Series_Serial1", DbType.Int32, Series_Serial1);
            DataSet ds = database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    public static void UpdateM_Code_DispatchFlagCompId(string Courier_Disp_ID)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[UpdateM_Code_DispatchFlag_PFL]");
            dbCommand.CommandTimeout = 500000;
            database.AddInParameter(dbCommand, "@Courier_Disp_ID", DbType.String, Courier_Disp_ID);

            //database.AddInParameter(dbCommand, "@Pro_ID", DbType.String, Pro_ID);
            //database.AddInParameter(dbCommand, "@Series_Order", DbType.Int32, Series_Order);
            //database.AddInParameter(dbCommand, "@Series_Serial", DbType.Int32, Series_Serial);
            //database.AddInParameter(dbCommand, "@Series_Serial1", DbType.Int32, Series_Serial1);
            DataSet ds = database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }


    }
    public static void UpdateM_Code_DispatchFlag(string Courier_Disp_ID)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[UpdateM_Code_DispatchFlag]");
            dbCommand.CommandTimeout = 500000;
            database.AddInParameter(dbCommand, "@Courier_Disp_ID", DbType.String, Courier_Disp_ID);
            //database.AddInParameter(dbCommand, "@pcount", DbType.Int32, pcount);
            //database.AddInParameter(dbCommand, "@Pro_ID", DbType.String, Pro_ID);
            //database.AddInParameter(dbCommand, "@Series_Order", DbType.Int32, Series_Order);
            //database.AddInParameter(dbCommand, "@Series_Serial", DbType.Int32, Series_Serial);
            //database.AddInParameter(dbCommand, "@Series_Serial1", DbType.Int32, Series_Serial1);
            DataSet ds = database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    public static DataSet GetProductDetailsNoofCodes(string Comp_ID)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[PROC_SelectProductDetailsNoofCodes_New]");
            dbCommand.CommandTimeout = 500000;
            database.AddInParameter(dbCommand, "@Comp_ID", DbType.String, Comp_ID);
            //database.AddInParameter(dbCommand, "@pcount", DbType.Int32, pcount);
            //database.AddInParameter(dbCommand, "@Pro_ID", DbType.String, Pro_ID);
            //database.AddInParameter(dbCommand, "@Series_Order", DbType.Int32, Series_Order);
            //database.AddInParameter(dbCommand, "@Series_Serial", DbType.Int32, Series_Serial);
            //database.AddInParameter(dbCommand, "@Series_Serial1", DbType.Int32, Series_Serial1);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetProductDetailsNoofCodes_ddl(string Comp_ID)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[PROC_SelectProductDetailsNoofCodes_ddl]");
            database.AddInParameter(dbCommand, "@Comp_ID", DbType.String, Comp_ID);
            //database.AddInParameter(dbCommand, "@pcount", DbType.Int32, pcount);
            //database.AddInParameter(dbCommand, "@Pro_ID", DbType.String, Pro_ID);
            //database.AddInParameter(dbCommand, "@Series_Order", DbType.Int32, Series_Order);
            //database.AddInParameter(dbCommand, "@Series_Serial", DbType.Int32, Series_Serial);
            //database.AddInParameter(dbCommand, "@Series_Serial1", DbType.Int32, Series_Serial1);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet GetDetailsbyPro_id(string Comp_ID, string Pro_ID)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("[GetDetailsbyPro_id]");
            database.AddInParameter(dbCommand, "@Comp_ID", DbType.String, Comp_ID);
            database.AddInParameter(dbCommand, "@Pro_ID", DbType.String, Pro_ID);
            //database.AddInParameter(dbCommand, "@pcount", DbType.Int32, pcount);
            //database.AddInParameter(dbCommand, "@Pro_ID", DbType.String, Pro_ID);
            //database.AddInParameter(dbCommand, "@Series_Order", DbType.Int32, Series_Order);
            //database.AddInParameter(dbCommand, "@Series_Serial", DbType.Int32, Series_Serial);
            //database.AddInParameter(dbCommand, "@Series_Serial1", DbType.Int32, Series_Serial1);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet SaveBatchProductDetails_new(Object9420 Reg)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("PROC_InsertBatchProductDetials_New");
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            database.AddInParameter(dbCommand, "MRP", DbType.Double, Reg.MRP);
            database.AddInParameter(dbCommand, "Warranty", DbType.Int32, Reg.Warranty);
            if (Reg.DemoMfd_Date != null)
                database.AddInParameter(dbCommand, "Mfd_Date", DbType.String, Convert.ToDateTime(Reg.DemoMfd_Date).ToString("yyyy/MM/dd"));
            else
                database.AddInParameter(dbCommand, "Mfd_Date", DbType.String, Reg.DemoMfd_Date);
            //database.AddInParameter(dbCommand, "Mfd_Date", DbType.String, Convert.ToDateTime(Reg.DemoMfd_Date).ToString("yyyy/MM/dd"));
            if (Reg.Exp_Date != null)
                database.AddInParameter(dbCommand, "Exp_Date", DbType.String, Convert.ToDateTime(Reg.Exp_Date).ToString("yyyy/MM/dd"));
            else
                database.AddInParameter(dbCommand, "Exp_Date", DbType.String, Reg.Exp_Date);
            database.AddInParameter(dbCommand, "Batch_No", DbType.String, Reg.Batch_No);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, Convert.ToDateTime(Reg.Entry_Date).ToString("yyyy/MM/dd"));
            //database.AddInParameter(dbCommand, "Update_Flag_H", DbType.String, Reg.Update_Flag);
            //database.AddInParameter(dbCommand, "Update_Flag_E", DbType.String, Reg.Update_Flag);
            database.AddInParameter(dbCommand, "Comments", DbType.String, Reg.Comments);
            //  database.ExecuteNonQuery(dbCommand);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public static DataSet UpdateM_codeByBatch_No(Int64 Row_ID, string pro_id)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("UpdateM_codeByBatch_No");
            database.AddInParameter(dbCommand, "@Row_ID", DbType.Int64, Row_ID);
            database.AddInParameter(dbCommand, "@pro_id", DbType.String, pro_id);

            //  database.ExecuteNonQuery(dbCommand);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    public static DataSet InsertPrintLabels(int NoofCodes, string Pro_id, DateTime ddate, string Use_Type, string trackid, string xmlstring)//, int intTabOrder)//, int intGroupNumber)
    {
        Database db = null;
        DbCommand dbCommand = null;
        try
        {
            db = DatabaseFactory.CreateDatabase();
            dbCommand = db.GetStoredProcCommand("M_Code_PrintLabels");

            dbCommand.CommandTimeout = 500000;

            db.AddInParameter(dbCommand, "@NoofCodes", DbType.Int32, NoofCodes);
            db.AddInParameter(dbCommand, "@Pro_id", DbType.String, Pro_id);
            db.AddInParameter(dbCommand, "@ddate", DbType.DateTime, ddate);
            db.AddInParameter(dbCommand, "@Use_Type", DbType.String, Use_Type);
            db.AddInParameter(dbCommand, "@trackid", DbType.String, trackid);
            db.AddInParameter(dbCommand, "xmlstring", DbType.Xml, xmlstring);
            //db.AddInParameter(dbCommand, "intTabOrder", DbType.Int32, intTabOrder);
            //db.AddInParameter(dbCommand, "@intGroupNumber", DbType.Int32, intGroupNumber);

            // Execute the query and return the new identity value
            return db.ExecuteDataSet(dbCommand);

            // return returnValue;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (dbCommand != null)
            {
                dbCommand.Dispose();
                dbCommand = null;
            }
            if (db != null)
                db = null;
        }
    }
    public static DataSet ProductioOrChannelsInsert(DateTime ddate, string compid, string xmlstring, string strType)//, int intTabOrder)//, int intGroupNumber)
    {
        Database db = null;
        DbCommand dbCommand = null;
        try
        {
            db = DatabaseFactory.CreateDatabase();
            dbCommand = db.GetStoredProcCommand("ProductionUnitORChannelsInsert");
            dbCommand.CommandTimeout = 500000;
            db.AddInParameter(dbCommand, "@ddate", DbType.DateTime, ddate);
            db.AddInParameter(dbCommand, "@compid", DbType.String, compid);
            db.AddInParameter(dbCommand, "@strType", DbType.String, strType);
            db.AddInParameter(dbCommand, "xmlstring", DbType.Xml, xmlstring);
            //db.AddInParameter(dbCommand, "intTabOrder", DbType.Int32, intTabOrder);
            //db.AddInParameter(dbCommand, "@intGroupNumber", DbType.Int32, intGroupNumber);

            // Execute the query and return the new identity value
            return db.ExecuteDataSet(dbCommand);

            // return returnValue;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (dbCommand != null)
            {
                dbCommand.Dispose();
                dbCommand = null;
            }
            if (db != null)
                db = null;
        }
    }
    public static DataSet TrackTraceInsert(DateTime ddate, string compid, string xmlstring, Int64 M_ServiceSubTransId)//, int intTabOrder)//, int intGroupNumber)
    {
        Database db = null;
        DbCommand dbCommand = null;
        try
        {
            db = DatabaseFactory.CreateDatabase();
            dbCommand = db.GetStoredProcCommand("TrackTraceInsert");
            dbCommand.CommandTimeout = 500000;
            db.AddInParameter(dbCommand, "@ddate", DbType.DateTime, ddate);
            db.AddInParameter(dbCommand, "@compid", DbType.String, compid);
            db.AddInParameter(dbCommand, "@M_ServiceSubTransId", DbType.Int64, M_ServiceSubTransId);
            db.AddInParameter(dbCommand, "xmlstring", DbType.Xml, xmlstring);
            //db.AddInParameter(dbCommand, "intTabOrder", DbType.Int32, intTabOrder);
            //db.AddInParameter(dbCommand, "@intGroupNumber", DbType.Int32, intGroupNumber);

            // Execute the query and return the new identity value
            return db.ExecuteDataSet(dbCommand);

            // return returnValue;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (dbCommand != null)
            {
                dbCommand.Dispose();
                dbCommand = null;
            }
            if (db != null)
                db = null;
        }
    }
    public static DataSet TrackTraceUpdate(Int64 M_ServiceSubTransId)//, int intTabOrder)//, int intGroupNumber)
    {
        Database db = null;
        DbCommand dbCommand = null;
        try
        {
            db = DatabaseFactory.CreateDatabase();
            dbCommand = db.GetStoredProcCommand("TrackTraceUpdate");
            dbCommand.CommandTimeout = 500000;
            //db.AddInParameter(dbCommand, "@ddate", DbType.DateTime, ddate);
            //db.AddInParameter(dbCommand, "@compid", DbType.String, compid);
            db.AddInParameter(dbCommand, "@M_ServicesubscriptionTransid", DbType.Int64, M_ServiceSubTransId);
            // db.AddInParameter(dbCommand, "xmlstring", DbType.Xml, xmlstring);
            //db.AddInParameter(dbCommand, "intTabOrder", DbType.Int32, intTabOrder);
            //db.AddInParameter(dbCommand, "@intGroupNumber", DbType.Int32, intGroupNumber);

            // Execute the query and return the new identity value
            return db.ExecuteDataSet(dbCommand);

            // return returnValue;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (dbCommand != null)
            {
                dbCommand.Dispose();
                dbCommand = null;
            }
            if (db != null)
                db = null;
        }
    }
    public static DataSet DistributorRetailerInsert(DateTime ddate, string compid, string xmlstring, short strType)//, int intTabOrder)//, int intGroupNumber)
    {
        Database db = null;
        DbCommand dbCommand = null;
        try
        {
            db = DatabaseFactory.CreateDatabase();
            dbCommand = db.GetStoredProcCommand("DistributorRetailerInsert");
            dbCommand.CommandTimeout = 500000;
            db.AddInParameter(dbCommand, "@ddate", DbType.DateTime, ddate);
            db.AddInParameter(dbCommand, "@compid", DbType.String, compid);
            db.AddInParameter(dbCommand, "@strType", DbType.Int16, strType);
            db.AddInParameter(dbCommand, "xmlstring", DbType.Xml, xmlstring);
            //db.AddInParameter(dbCommand, "intTabOrder", DbType.Int32, intTabOrder);
            //db.AddInParameter(dbCommand, "@intGroupNumber", DbType.Int32, intGroupNumber);

            // Execute the query and return the new identity value
            return db.ExecuteDataSet(dbCommand);

            // return returnValue;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (dbCommand != null)
            {
                dbCommand.Dispose();
                dbCommand = null;
            }
            if (db != null)
                db = null;
        }
    }
    public static DataSet CheckDuplicate_GenerateCode(string xmlstring)//, int intTabOrder)//, int intGroupNumber)
    {
        Database db = null;
        DbCommand dbCommand = null;
        try
        {
            db = DatabaseFactory.CreateDatabase();
            dbCommand = db.GetStoredProcCommand("CheckDuplicate_Code");
            dbCommand.CommandTimeout = 500000;
            db.AddInParameter(dbCommand, "xmlstring", DbType.Xml, xmlstring);
            //db.AddInParameter(dbCommand, "intTabOrder", DbType.Int32, intTabOrder);
            //db.AddInParameter(dbCommand, "@intGroupNumber", DbType.Int32, intGroupNumber);

            // Execute the query and return the new identity value
            return db.ExecuteDataSet(dbCommand);

            // return returnValue;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (dbCommand != null)
            {
                dbCommand.Dispose();
                dbCommand = null;
            }
            if (db != null)
                db = null;
        }
    }
    public static DataSet InsertSubMasterLabelCodes(string xmlstring)//, int intTabOrder)//, int intGroupNumber)
    {
        Database db = null;
        DbCommand dbCommand = null;
        try
        {
            db = DatabaseFactory.CreateDatabase();
            dbCommand = db.GetStoredProcCommand("InsertSubMasterLabelCodes");
            dbCommand.CommandTimeout = 500000;
            db.AddInParameter(dbCommand, "xmlstring", DbType.Xml, xmlstring);
            //db.AddInParameter(dbCommand, "intTabOrder", DbType.Int32, intTabOrder);
            //db.AddInParameter(dbCommand, "@intGroupNumber", DbType.Int32, intGroupNumber);

            // Execute the query and return the new identity value
            return db.ExecuteDataSet(dbCommand);

            // return returnValue;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (dbCommand != null)
            {
                dbCommand.Dispose();
                dbCommand = null;
            }
            if (db != null)
                db = null;
        }
    }
    public static DataSet CheckDuplicate_GenerateSubMasterLabelCode(string xmlstring, string SubCodeOrMasterCode)//, int intTabOrder)//, int intGroupNumber)
    {
        Database db = null;
        DbCommand dbCommand = null;
        try
        {
            db = DatabaseFactory.CreateDatabase();
            dbCommand = db.GetStoredProcCommand("CheckDuplicate_SubMasterLabelCode");
            dbCommand.CommandTimeout = 500000;
            db.AddInParameter(dbCommand, "xmlstring", DbType.Xml, xmlstring);
            db.AddInParameter(dbCommand, "SubCodeOrMasterCode", DbType.String, SubCodeOrMasterCode);
            //db.AddInParameter(dbCommand, "@intGroupNumber", DbType.Int32, intGroupNumber);

            // Execute the query and return the new identity value
            return db.ExecuteDataSet(dbCommand);

            // return returnValue;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (dbCommand != null)
            {
                dbCommand.Dispose();
                dbCommand = null;
            }
            if (db != null)
                db = null;
        }
    }
    public static DataSet CheckReferral(string c1, string c2)//, int intTabOrder)//, int intGroupNumber)
    {
        Database db = null;
        DbCommand dbCommand = null;
        try
        {
            db = DatabaseFactory.CreateDatabase();
            dbCommand = db.GetStoredProcCommand("CheckReferral");
            dbCommand.CommandTimeout = 500000;
            db.AddInParameter(dbCommand, "@c1", DbType.String, c1);
            db.AddInParameter(dbCommand, "@c2", DbType.String, c2);
            //db.AddInParameter(dbCommand, "@intGroupNumber", DbType.Int32, intGroupNumber);

            // Execute the query and return the new identity value
            return db.ExecuteDataSet(dbCommand);

            // return returnValue;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (dbCommand != null)
            {
                dbCommand.Dispose();
                dbCommand = null;
            }
            if (db != null)
                db = null;
        }
    }

    public static DataSet CheckWarranty(string c1, string c2, string CompId = "")
    {
        Database db = null;
        DbCommand dbCommand = null;
        try
        {
            db = DatabaseFactory.CreateDatabase();
            if (CompId == "Comp-1693")
                dbCommand = db.GetStoredProcCommand("CheckWarranty_PFL");
            else
                dbCommand = db.GetStoredProcCommand("CheckWarranty");
            dbCommand.CommandTimeout = 500000;
            db.AddInParameter(dbCommand, "@codeone", DbType.String, c1);
            db.AddInParameter(dbCommand, "@codetwo", DbType.String, c2);

            return db.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (dbCommand != null)
            {
                dbCommand.Dispose();
                dbCommand = null;
            }
            if (db != null)
                db = null;
        }
    }
    public static DataSet appCheckWarranty(string c1, string c2)
    {
        Database db = null;
        DbCommand dbCommand = null;
        try
        {
            db = DatabaseFactory.CreateDatabase();
            dbCommand = db.GetStoredProcCommand("appCheckWarranty");
            dbCommand.CommandTimeout = 500000;
            db.AddInParameter(dbCommand, "@codeone", DbType.String, c1);
            db.AddInParameter(dbCommand, "@codetwo", DbType.String, c2);

            return db.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (dbCommand != null)
            {
                dbCommand.Dispose();
                dbCommand = null;
            }
            if (db != null)
                db = null;
        }
    }

    public static DataSet CheckReferralExists(string refcode, string Mno)//, int intTabOrder)//, int intGroupNumber)
    {
        Database db = null;
        DbCommand dbCommand = null;
        try
        {
            db = DatabaseFactory.CreateDatabase();
            dbCommand = db.GetStoredProcCommand("CheckReferralExists");
            dbCommand.CommandTimeout = 500000;
            db.AddInParameter(dbCommand, "@refcode", DbType.String, refcode);
            //  db.AddInParameter(dbCommand, "@Mno", DbType.String, Mno);
            //db.AddInParameter(dbCommand, "@intGroupNumber", DbType.Int32, intGroupNumber);

            // Execute the query and return the new identity value
            return db.ExecuteDataSet(dbCommand);

            // return returnValue;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (dbCommand != null)
            {
                dbCommand.Dispose();
                dbCommand = null;
            }
            if (db != null)
                db = null;
        }
    }
    public static DataSet GetPrintLabels(string strqry)//, int intTabOrder)//, int intGroupNumber)
    {
        Database db = null;
        DbCommand dbCommand = null;
        try
        {
            db = DatabaseFactory.CreateDatabase();
            dbCommand = db.GetSqlStringCommand(strqry);
            dbCommand.CommandTimeout = 500000;
            // db.AddInParameter(dbCommand, "xmlstring", DbType.Xml, xmlstring);
            //db.AddInParameter(dbCommand, "intTabOrder", DbType.Int32, intTabOrder);
            //db.AddInParameter(dbCommand, "@intGroupNumber", DbType.Int32, intGroupNumber);

            // Execute the query and return the new identity value
            return db.ExecuteDataSet(dbCommand);

            // return returnValue;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (dbCommand != null)
            {
                dbCommand.Dispose();
                dbCommand = null;
            }
            if (db != null)
                db = null;
        }
    }
    public static bool Is_DispatchPending(string Pro_ID)//, int intTabOrder)//, int intGroupNumber)
    {
        Database db = null;
        DbCommand dbCommand = null;
        try
        {
            db = DatabaseFactory.CreateDatabase();
            dbCommand = db.GetStoredProcCommand("[Sp_DispatchPending]");
            //dbCommand.CommandTimeout = 500000;
            //  db.AddInParameter(dbCommand, "xmlstring", DbType.Xml, xmlstring);
            db.AddInParameter(dbCommand, "Pro_ID", DbType.String, Pro_ID);
            //db.AddInParameter(dbCommand, "@intGroupNumber", DbType.Int32, intGroupNumber);

            // Execute the query and return the new identity value
            int i = Convert.ToInt32(db.ExecuteScalar(dbCommand));
            if (i == 0)
                return false;
            else
                return true;

            // return returnValue;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (dbCommand != null)
            {
                dbCommand.Dispose();
                dbCommand = null;
            }
            if (db != null)
                db = null;
        }
    }

    public static void InsertUser_ReferredUser(string strRefCode, string MobileNo)
    {
        if (!string.IsNullOrEmpty(strRefCode))
        {
            Database db = null;
            DbCommand dbCommand = null;
            try
            {
                db = DatabaseFactory.CreateDatabase();
                dbCommand = db.GetStoredProcCommand("[InsertUser_ReferredUser]");
                //dbCommand.CommandTimeout = 500000;
                //  db.AddInParameter(dbCommand, "xmlstring", DbType.Xml, xmlstring);
                db.AddInParameter(dbCommand, "strRefCode", DbType.String, strRefCode);
                db.AddInParameter(dbCommand, "MobileNo", DbType.String, MobileNo);
                //db.AddInParameter(dbCommand, "@intGroupNumber", DbType.Int32, intGroupNumber);

                // Execute the query and return the new identity value
                int i = Convert.ToInt32(db.ExecuteScalar(dbCommand));
                //if (i == 0)
                //    return false;
                //else
                //    return true;

                // return returnValue;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (dbCommand != null)
                {
                    dbCommand.Dispose();
                    dbCommand = null;
                }
                if (db != null)
                    db = null;
            }
        }
    }
    public static int InsertEmployeeDetails(User_Details obj)
    {
        try
        {
            //    if (obj.DML == "I")
            //        obj.User_ID = GetMyCodeGenID("Consumer");
            dbCommand = database.GetStoredProcCommand("PROC_InsertEmployee");
            database.AddInParameter(dbCommand, "@EmployeeID", DbType.Int32, obj.EmployeeID);
            database.AddInParameter(dbCommand, "@Name", DbType.String, obj.ConsumerName);
            database.AddInParameter(dbCommand, "@Address", DbType.String, obj.Address);
            database.AddInParameter(dbCommand, "@Email", DbType.String, obj.Email);
            database.AddInParameter(dbCommand, "@MobileNo", DbType.String, obj.MobileNo);
            database.AddInParameter(dbCommand, "@Password", DbType.String, obj.Password);
            database.AddInParameter(dbCommand, "@City", DbType.String, obj.City);
            database.AddInParameter(dbCommand, "@PinCode", DbType.String, obj.PinCode);
            database.AddInParameter(dbCommand, "@Emp_type", DbType.Int16, obj.EmployeeType);
            database.AddInParameter(dbCommand, "@active", DbType.Boolean, obj.IsActive);
            database.AddInParameter(dbCommand, "@dalete", DbType.Boolean, obj.IsDelete);


            database.AddInParameter(dbCommand, "@createddate", DbType.DateTime, obj.Entry_Date);
            database.AddInParameter(dbCommand, "@createdby", DbType.Int32, obj.CreatedBy);
            database.AddInParameter(dbCommand, "@DML", DbType.String, obj.DML);

            //database.AddInParameter(dbCommand, "Code1", DbType.Int32, obj.code1);
            //database.AddInParameter(dbCommand, "Code2", DbType.Int32, obj.code1);
            return database.ExecuteNonQuery(dbCommand);
            //if (obj.DML == "I")
            //    SetMyCodeGenID("Consumer");
        }
        catch (Exception Ex)
        {
            DataProvider.LogManager.WriteExe("Find Error in Procedure with " + Ex.Message.ToString());
            return 0;
        }
    }
    public static int InsertDealerDetails(User_Details obj)
    {
        try
        {

            dbCommand = database.GetStoredProcCommand("PROC_InsertEmployee");
            database.AddInParameter(dbCommand, "@EmployeeID", DbType.Int32, obj.EmployeeID);
            database.AddInParameter(dbCommand, "@Name", DbType.String, obj.ConsumerName);
            database.AddInParameter(dbCommand, "@Address", DbType.String, obj.Address);
            database.AddInParameter(dbCommand, "@Email", DbType.String, obj.Email);
            database.AddInParameter(dbCommand, "@MobileNo", DbType.String, obj.MobileNo);
            database.AddInParameter(dbCommand, "@Password", DbType.String, obj.Password);
            database.AddInParameter(dbCommand, "@City", DbType.String, obj.City);
            database.AddInParameter(dbCommand, "@PinCode", DbType.String, obj.PinCode);
            database.AddInParameter(dbCommand, "@Emp_type", DbType.Int16, obj.EmployeeType);
            database.AddInParameter(dbCommand, "@active", DbType.Boolean, obj.IsActive);
            database.AddInParameter(dbCommand, "@dalete", DbType.Boolean, obj.IsDelete);


            database.AddInParameter(dbCommand, "@createddate", DbType.DateTime, obj.Entry_Date);
            database.AddInParameter(dbCommand, "@createdby", DbType.Int32, obj.CreatedBy);
            database.AddInParameter(dbCommand, "@DML", DbType.String, obj.DML);


            //  return database.ExecuteNonQuery(dbCommand);
            return -1;

        }
        catch (Exception Ex)
        {
            DataProvider.LogManager.WriteExe("Find Error in Procedure with " + Ex.Message.ToString());
            return 0;
        }
    }
}
