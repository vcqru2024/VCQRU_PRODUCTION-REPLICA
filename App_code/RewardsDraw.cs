using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Business_Logic_Layer;
using Business9420;
using System.Collections.Generic;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using CodesGenuinity;

/// <summary>
/// Summary description for RewardsDraw
/// </summary>
namespace CustomeDraw
{
    public class RewardsDraw
    {
        #region Draw Rewards
        public static string Draw(Int64 SSTID)
        {
            List<Gifts> Obj = new List<Gifts>();
            DataTable dt = SQL_DB.ExecuteDataSet("SELECT Trans_Id, SST_Id, ServiceType, Rules, DistributionType, PrizeTrans_Id, MasterCodes, WinningCodes, WinCodes, Frequency, IsPrize FROM M_ServiceRules WHERE SST_Id = '" + SSTID + "'").Tables[0];
            DataTable tdt = SQL_DB.ExecuteDataTable("SELECT SST_Id, Subscribe_Id, Points, IsCashConvert, DateFrom, DateTo, Entry_Date, Update_Flag_H, Update_Flag_E, Comments, Frequency, IsActive, IsDelete, IsDraw, DrawDate FROM M_ServiceSubscriptionTrans WHERE SST_Id = '" + SSTID + "'");
            if ((dt.Rows.Count > 0) && (tdt.Rows.Count > 0))
            {
                try
                {
                    List<SMSGifts> ObjSms = new List<SMSGifts>();
                    DataTable giftdt = SQL_DB.ExecuteDataSet("SELECT COUNT(tg.Trans_Id) FROM T_GiftDistribution as tg WHERE tg.IsUsed = 0 AND tg.SST_Id = '" + SSTID + "' AND CONVERT(VARCHAR,EntryDate,111) >= '" + Convert.ToDateTime(tdt.Rows[0]["DateFrom"]).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,EntryDate,111) <= '" + Convert.ToDateTime(tdt.Rows[0]["DateTo"]).ToString("yyyy/MM/dd") + "' ").Tables[0];
                    //DataTable prizedt = SQL_DB.ExecuteDataSet("SELECT Trans_Id, SST_Id, PrizeTrans_Id, Gift_Id, GiftName, GiftCount, DistributeCount FROM M_ServicePrizeSST_Id WHERE SST_Id = '" + SSTID + "' ORDER BY GiftCount ").Tables[0];
                    DataTable infinitedt = new DataTable();
                    DataTable prizedt = new DataTable();
                    infinitedt = SQL_DB.ExecuteDataSet("SELECT Trans_Id, SST_Id, PrizeTrans_Id, Gift_Id, GiftName, GiftCount, DistributeCount FROM M_ServicePrize WHERE SST_Id = " + Convert.ToInt64(dt.Rows[0]["SST_Id"]) + " AND GiftCount = 0 ").Tables[0];
                    if (infinitedt.Rows.Count == 0)
                        prizedt = SQL_DB.ExecuteDataSet("SELECT Trans_Id, SST_Id, PrizeTrans_Id, Gift_Id, GiftName, GiftCount, DistributeCount FROM M_ServicePrize R  CROSS APPLY dbo.NumbersTable(1,R.GiftCount-R.DistributeCount,1) WHERE R.SST_Id = " + Convert.ToInt64(dt.Rows[0]["SST_Id"]) + " AND R.GiftCount > R.DistributeCount ORDER BY NEWID()").Tables[0];
                    else
                    {
                        #region If infinite rewards is Exist
                        try
                        {
                            int rcount = 0; Int64 finfinitecount = 0; Int64 rem = 0; string ExecuteQry = "";
                            Int64 totalparticount = Convert.ToInt64(SQL_DB.ExecuteScalar("SELECT COUNT(Trans_Id) AS Cnt FROM T_GiftDistribution WHERE (SST_Id = " + Convert.ToInt64(dt.Rows[0]["SST_Id"]) + " ) AND CONVERT(VARCHAR,EntryDate,111) >= '" + Convert.ToDateTime(tdt.Rows[0]["DateFrom"]).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,EntryDate,111) <= '" + Convert.ToDateTime(tdt.Rows[0]["DateTo"]).ToString("yyyy/MM/dd") + "' "));
                            Int64 totalentrygift = Convert.ToInt64(SQL_DB.ExecuteScalar("SELECT SUM(GiftCount) FROM M_ServicePrize WHERE (SST_Id = " + Convert.ToInt64(dt.Rows[0]["SST_Id"]) + " )"));
                            Int64 infinitecount = 0;
                            if (totalparticount > totalentrygift)
                                infinitecount = totalparticount - totalentrygift;
                            else
                                infinitecount = totalentrygift * 5;// 5 times of infinie rewards count;                        
                            if (infinitedt.Rows.Count > 1)
                            {
                                rcount = infinitedt.Rows.Count;
                                finfinitecount = infinitecount / rcount;
                                rem = infinitecount % rcount;
                            }
                            for (int p = 0; p < infinitedt.Rows.Count; p++)
                            {
                                if (rem > 0)
                                {
                                    if (p == infinitedt.Rows.Count - 1)
                                        finfinitecount = finfinitecount + rem;
                                }
                                else
                                    finfinitecount = infinitecount;
                                ExecuteQry += "UPDATE M_ServicePrize SET GiftCount = " + finfinitecount + " , DistributeCount = 0  WHERE Trans_Id = " + Convert.ToInt64(infinitedt.Rows[p]["Trans_Id"]) + ";";
                            }
                            if (ExecuteQry != "")
                            {
                                try
                                {
                                    SQL_DB.ExecuteNonQuery(ExecuteQry);
                                }
                                catch (Exception Ex)
                                {
                                    return "false*" + Ex.Message.ToString();
                                }
                            }
                            prizedt = SQL_DB.ExecuteDataSet("SELECT Trans_Id, SST_Id, PrizeTrans_Id, Gift_Id, GiftName, GiftCount, DistributeCount FROM M_ServicePrize R  CROSS APPLY dbo.NumbersTable(1,R.GiftCount-R.DistributeCount,1) WHERE R.SST_Id = " + Convert.ToInt64(dt.Rows[0]["SST_Id"]) + " AND R.GiftCount > R.DistributeCount ORDER BY NEWID()").Tables[0];
                        }
                        catch (Exception ex)
                        {
                            return "false*" + ex.Message.ToString();
                        }
                        #endregion
                    }
                    if (prizedt.Rows.Count > 0)
                    {
                        for (int p = 0; p < prizedt.Rows.Count; p++)
                            Obj.Add(new Gifts { Gift_ID = prizedt.Rows[p]["Gift_Id"].ToString(), GiftName = prizedt.Rows[p]["GiftName"].ToString(), GiftCount = Convert.ToInt64(prizedt.Rows[p]["GiftCount"]), DistributeGiftCount = Convert.ToInt64(0) });
                    }
                    #region Logic for At Due Date Rules
                    string Qry = "", GiftName = ""; int counter = 0;
                    DataTable giftdttrans = new DataTable();
                    if (dt.Rows[0]["Rules"].ToString() == ServiceRules.FirstNCustomertoNCustomer.ToString())
                    {
                        #region First 'n' Paricipants and 'p' participants distributes awards randoms
                        ////Firstselect random n and 'n' distributed
                        //DataTable giftdttrans = SQL_DB.ExecuteDataSet("SELECT TOP(" + Convert.ToInt64(dt.Rows[0]["MasterCodes"]) + ") * FROM T_GiftDistribution as tg WHERE tg.IsUsed = 0 AND tg.SST_Id = '" + SSTID + "' ORDER BY NEWID()").Tables[0];
                        DataTable distridt = SQL_DB.ExecuteDataSet("SELECT TOP(" + Convert.ToInt64(dt.Rows[0]["WinningCodes"]) + ") * FROM T_GiftDistribution as tg WHERE  Trans_Id IN (SELECT TOP(" + Convert.ToInt64(dt.Rows[0]["MasterCodes"]) + ") Trans_Id FROM T_GiftDistribution as tg WHERE tg.IsUsed = 0 AND tg.SST_Id = '" + SSTID + "'  AND CONVERT(VARCHAR,EntryDate,111) >= '" + Convert.ToDateTime(tdt.Rows[0]["DateFrom"]).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,EntryDate,111) <= '" + Convert.ToDateTime(tdt.Rows[0]["DateTo"]).ToString("yyyy/MM/dd") + "'  ORDER BY NEWID()) ORDER BY NEWID()").Tables[0];
                        if (distridt.Rows.Count > 0)
                        {
                            Qry = "";
                            for (int t = 0; t < distridt.Rows.Count; t++)
                            {
                                if (dt.Rows[0]["DistributionType"].ToString() == RwdDistrubutionRules.Random.ToString())
                                    GiftName = GetRandomRewardsName(Obj);
                                else
                                    GiftName = GetSequenceRewardsName(Obj);
                                Qry += "UPDATE [T_GiftDistribution] SET [Prize] = '" + GiftName + "' ,[IsUsed] = 1  WHERE Trans_Id ='" + distridt.Rows[t]["Trans_Id"].ToString() + "'";
                                counter++;
                                if (counter == 100)
                                {
                                    SQL_DB.ExecuteNonQuery(Qry);
                                    Qry = ""; counter = 0;
                                }
                                ObjSms.Add(new SMSGifts { Trans_Id = Convert.ToInt64(distridt.Rows[t]["Trans_Id"]), MobileNo = distridt.Rows[t]["MobileNo"].ToString(), GiftName = GiftName });
                            }
                            if (Qry != "")
                            {
                                SQL_DB.ExecuteNonQuery(Qry);
                                Qry = ""; counter = 0;
                            }
                            SendSMS(ObjSms);
                        }
                        #endregion
                    }
                    else if (dt.Rows[0]["Rules"].ToString() == ServiceRules.AllCusomertoRandomNCustomer.ToString())
                    {
                        #region First 'n' Paricipants and distributes awards randoms every nth participants
                        Int64 Rows = Convert.ToInt64(dt.Rows[0]["MasterCodes"]) + Convert.ToInt64(dt.Rows[0]["Frequency"]) + 1;
                        giftdttrans = SQL_DB.ExecuteDataSet("SELECT TOP(" + Rows + ") * FROM T_GiftDistribution as tg WHERE tg.IsUsed = 0 AND tg.SST_Id = '" + SSTID + "'  AND CONVERT(VARCHAR,EntryDate,111) >= '" + Convert.ToDateTime(tdt.Rows[0]["DateFrom"]).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,EntryDate,111) <= '" + Convert.ToDateTime(tdt.Rows[0]["DateTo"]).ToString("yyyy/MM/dd") + "'  ORDER BY NEWID()").Tables[0];
                        if (giftdttrans.Rows.Count > 0)
                        {
                            int fre = Convert.ToInt32(dt.Rows[0]["DistributionType"]);
                            Qry = "";
                            for (int t = fre - 1; t < giftdttrans.Rows.Count; t += fre)
                            {
                                if (dt.Rows[0]["DistributionType"].ToString() == RwdDistrubutionRules.Random.ToString())
                                    GiftName = GetRandomRewardsName(Obj);
                                else
                                    GiftName = GetSequenceRewardsName(Obj);
                                Qry += "UPDATE [T_GiftDistribution] SET [Prize] = '" + GiftName + "' ,[IsUsed] = 1  WHERE Trans_Id ='" + giftdttrans.Rows[t]["Trans_Id"].ToString() + "'";
                                counter++;
                                if (counter == 100)
                                {
                                    SQL_DB.ExecuteNonQuery(Qry);
                                    Qry = ""; counter = 0;
                                }
                                ObjSms.Add(new SMSGifts { Trans_Id = Convert.ToInt64(giftdttrans.Rows[t]["Trans_Id"]), MobileNo = giftdttrans.Rows[t]["MobileNo"].ToString(), GiftName = GiftName });
                            }
                            if (Qry != "")
                            {
                                SQL_DB.ExecuteNonQuery(Qry);
                                Qry = ""; counter = 0;
                            }
                            SendSMS(ObjSms);
                        }
                        #endregion
                    }
                    else if (dt.Rows[0]["Rules"].ToString() == ServiceRules.AllCusomertoRandomNWinners.ToString())
                    {
                        #region Random 'n' Paricipants and distributes awards
                        giftdttrans = SQL_DB.ExecuteDataSet("SELECT TOP(" + Convert.ToInt64(dt.Rows[0]["MasterCodes"]) + ") * FROM T_GiftDistribution as tg WHERE tg.IsUsed = 0 AND tg.SST_Id = '" + SSTID + "'  AND CONVERT(VARCHAR,EntryDate,111) >= '" + Convert.ToDateTime(tdt.Rows[0]["DateFrom"]).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,EntryDate,111) <= '" + Convert.ToDateTime(tdt.Rows[0]["DateTo"]).ToString("yyyy/MM/dd") + "'  ORDER BY NEWID()").Tables[0];
                        if (giftdttrans.Rows.Count > 0)
                        {
                            Qry = "";
                            for (int t = 0; t < giftdttrans.Rows.Count; t++)
                            {
                                if (dt.Rows[0]["DistributionType"].ToString() == RwdDistrubutionRules.Random.ToString())
                                    GiftName = GetRandomRewardsName(Obj);
                                else
                                    GiftName = GetSequenceRewardsName(Obj);
                                Qry += "UPDATE [T_GiftDistribution] SET [Prize] = '" + GiftName + "' ,[IsUsed] = 1  WHERE Trans_Id ='" + giftdttrans.Rows[t]["Trans_Id"].ToString() + "'";
                                counter++;
                                if (counter == 100)
                                {
                                    SQL_DB.ExecuteNonQuery(Qry);
                                    Qry = ""; counter = 0;
                                }
                                ObjSms.Add(new SMSGifts { Trans_Id = Convert.ToInt64(giftdttrans.Rows[t]["Trans_Id"]), MobileNo = giftdttrans.Rows[t]["MobileNo"].ToString(), GiftName = GiftName });
                            }
                            if (Qry != "")
                            {
                                SQL_DB.ExecuteNonQuery(Qry);
                                Qry = ""; counter = 0;
                            }
                            SendSMS(ObjSms);
                        }
                        #endregion
                    }
                    else if (dt.Rows[0]["Rules"].ToString() == ServiceRules.AllCustomertoAllCustomer.ToString())
                    {
                        #region All participants distributes awards
                        giftdttrans = SQL_DB.ExecuteDataSet("SELECT * FROM T_GiftDistribution as tg WHERE tg.IsUsed = 0 AND tg.SST_Id = '" + SSTID + "'  AND CONVERT(VARCHAR,EntryDate,111) >= '" + Convert.ToDateTime(tdt.Rows[0]["DateFrom"]).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,EntryDate,111) <= '" + Convert.ToDateTime(tdt.Rows[0]["DateTo"]).ToString("yyyy/MM/dd") + "'  ORDER BY Trans_Id ").Tables[0];
                        if (giftdttrans.Rows.Count > 0)
                        {
                            Qry = "";
                            for (int t = 0; t < giftdttrans.Rows.Count; t++)
                            {
                                if (dt.Rows[0]["DistributionType"].ToString() == RwdDistrubutionRules.Random.ToString())
                                    GiftName = GetRandomRewardsName(Obj);
                                else
                                    GiftName = GetSequenceRewardsName(Obj);
                                Qry += "UPDATE [T_GiftDistribution] SET [Prize] = '" + GiftName + "' ,[IsUsed] = 1  WHERE Trans_Id ='" + giftdttrans.Rows[t]["Trans_Id"].ToString() + "'";
                                counter++;
                                if (counter == 100)
                                {
                                    SQL_DB.ExecuteNonQuery(Qry);
                                    Qry = ""; counter = 0;
                                }
                                ObjSms.Add(new SMSGifts { Trans_Id = Convert.ToInt64(giftdttrans.Rows[t]["Trans_Id"]), MobileNo = giftdttrans.Rows[t]["MobileNo"].ToString(), GiftName = GiftName });
                            }
                            if (Qry != "")
                            {
                                SQL_DB.ExecuteNonQuery(Qry);
                                Qry = ""; counter = 0;
                            }
                            SendSMS(ObjSms);
                        }
                        #endregion
                    }
                    #endregion
                    Rewards_DataTire.UpdateDraw(SSTID);
                    return "true*Draw Rewards successfully.";
                }
                catch (Exception Ex)
                {
                    return "false*" + Ex.Message.ToString();
                }
            }
            else
            {
                return "false*Draw rewards is permitted.";
            }
        }
        #endregion

        #region Logic For Sending SMS
        public static void SendSMS(List<SMSGifts> Obj)
        {
            int counter = 0; string Qry = "";
            #region Logic For Send SMS
            foreach (var item in Obj)
            {
                //CheckGenuinity.SendSms("Win Prize " + item.GiftName, item.MobileNo, "Solution");
                Qry += "UPDATE [T_GiftDistribution] SET [IsSMS] = 1  WHERE [Trans_Id] = " + item.Trans_Id + ";";
                if (counter == 10)
                {
                    SQL_DB.ExecuteNonQuery(Qry);
                    Qry = ""; counter = 0;
                }
            }
            if (Qry != "")
            {
                SQL_DB.ExecuteNonQuery(Qry);
                Qry = ""; counter = 0;
            }
            #endregion
        }
        #endregion

        #region Get Random Rewards Logic
        public static string GetRandomRewardsName(List<Gifts> Obj)
        {
            #region Logic for Entry predefine random gift
            string GNM = "";
            Random rnd = new Random();
            int rt = rnd.Next(Obj.Count);
            Random r = new Random();
            var rand = Obj[r.Next(Obj.Count)];
            Int64 p = rand.DistributeGiftCount; p++;
            Int64 tp = rand.GiftCount;
            GNM = rand.GiftName;
            rand.DistributeGiftCount = p;
            Obj.Remove(rand);
            #region Comments For is rewards is show is single but count is multiple
            //if (tp == p)
            //    Obj.Remove(rand);
            #endregion
            return GNM;
            #endregion
        }
        #endregion

        #region Get Sequence Rewards Logic
        public static string GetSequenceRewardsName(List<Gifts> Obj)
        {
            #region Logic for Entry predefine random gift
            string GNM = "";
            foreach (var item in Obj)
            {
                var rand = item;
                Int64 p = rand.DistributeGiftCount; p++;
                Int64 tp = rand.GiftCount;
                GNM = rand.GiftName;
                rand.DistributeGiftCount = p;
                if (tp == p)
                    Obj.Remove(rand);
                break;
            }
            return GNM;
            #endregion
        }
        #endregion


        #region Get Random Rewards Logic for Instant GiftName & Gift_ID
        public static string GetRandomGiftName(List<Gifts> Obj)
        {
            #region Logic for Entry predefine random gift
            string GNM = "";
            Random rnd = new Random();
            int rt = rnd.Next(Obj.Count);
            Random r = new Random();
            var rand = Obj[r.Next(Obj.Count)];
            Int64 p = rand.DistributeGiftCount; p++;
            Int64 tp = rand.GiftCount;
            GNM = rand.GiftName + "-" +rand.Gift_ID;
            rand.DistributeGiftCount = p;
            Obj.Remove(rand);
            #region Comments For is rewards is show is single but count is multiple
            //if (tp == p)
            //    Obj.Remove(rand);
            #endregion
            return GNM;
            #endregion
        }
        #endregion
    }
    public class Rewards_DataTire
    {
        private static Database database = DatabaseFactory.CreateDatabase();
        private static DbCommand dbCommand;
        public static Int64 GetFilledDetailsCount(Object9420 obj)
        {
            dbCommand = database.GetStoredProcCommand("Proc_GetFilledDetailsCount"); dbCommand.CommandTimeout = 50000;
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, obj.Pro_ID);
            DataTable dt = database.ExecuteDataSet(dbCommand).Tables[0];
            if (dt.Rows.Count > 0) 
                return Convert.ToInt64(dt.Rows[0]["Cnt"]);
            else
                return 0;
        }

        public static void UpdateDraw(Int64 SSTID)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [M_ServiceSubscriptionTrans] SET [IsDraw] = 1,[DrawDate] = '" + Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE SST_Id = " + SSTID + "");
            database.ExecuteNonQuery(dbCommand);
        }

        public static void CheckIsActDeAct()
        {
            dbCommand = database.GetSqlStringCommand("UPDATE M_ServiceSubscriptionTrans SET IsActive = -1 WHERE IsDelete = 0 AND (IsActive = 1 OR IsActive = 0) AND CONVERT(VARCHAR,GETDATE(),111) > CONVERT(VARCHAR,DateTo,111)");
            database.ExecuteNonQuery(dbCommand);
        }

        public static DataSet GetLuckWinners(Object9420 Reg)
        {
            string Qry = "SELECT  tg.Trans_Id, tg.Comp_ID, tg.Pro_ID,(SELECT p.Pro_Name FROM Pro_Reg as p WHERE p.Pro_ID=tg.Pro_ID) AS Pro_Name, " +
            " (SELECT m.ServiceName FROM M_Service as m WHERE m.Service_ID =(SELECT ss.Service_ID FROM M_ServiceSubscription as ss WHERE ss.Subscribe_Id = (SELECT st.Subscribe_Id FROM M_ServiceSubscriptionTrans AS st WHERE st.SST_Id = tg.SST_Id))) AS ServiceName " +
            " , tg.SST_Id, tg.Code1, tg.Code2, ISNULL(tg.MobileNo,'-- --') AS MobileNo, tg.Prize, tg.EntryDate, ISNULL(tg.IsUsed,0) AS IsUsed, ISNULL(tg.IsSMS,0) AS IsSMS, ISNULL(tg.IsDelivery,0) AS IsDelivery " +
            " ,(SELECT ss.Service_ID FROM M_ServiceSubscription as ss WHERE ss.Subscribe_Id = (SELECT st.Subscribe_Id FROM M_ServiceSubscriptionTrans AS st WHERE st.SST_Id = tg.SST_Id)) as Service_ID " +
            " FROM  T_GiftDistribution AS tg WHERE ISNULL(tg.MobileNo,'') <> '' AND ISNULL(tg.Prize,'') <> '' " +
            " AND ('' ='" + Reg.Comp_ID + "' OR tg.Comp_ID ='" + Reg.Comp_ID + "') AND ('' ='" + Reg.Pro_ID + "' OR tg.Pro_ID ='" + Reg.Pro_ID + "')  " + //" AND ('' ='' OR tg.SST_Id ='')  " +
            Reg.datefromstr + Reg.datetostr + Reg.modestr + Reg.statusstr +
            " ORDER BY tg.Prize DESC";
            dbCommand = database.GetSqlStringCommand(Qry);
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet GetCompany()
        {
            dbCommand = database.GetSqlStringCommand("SELECT DISTINCT t.Comp_ID, c.Comp_Name FROM T_GiftDistribution as t INNER JOIN Comp_Reg as c ON t.Comp_ID = c.Comp_ID --WHERE (t.Comp_ID <> '')");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataTable DownLoadExcel(Object9420 Reg)
        {
            string Qry = "SELECT ROW_NUMBER() OVER(ORDER BY tg.Prize) AS Sr_No, (SELECT p.Pro_Name FROM Pro_Reg as p WHERE p.Pro_ID=tg.Pro_ID) AS Product_Name, " +
            " (SELECT m.ServiceName FROM M_Service as m WHERE m.Service_ID =(SELECT ss.Service_ID FROM M_ServiceSubscription as ss WHERE ss.Subscribe_Id = (SELECT st.Subscribe_Id FROM M_ServiceSubscriptionTrans AS st WHERE st.SST_Id = tg.SST_Id))) AS Service_Name " +
            " , tg.Code1, tg.Code2, ISNULL(tg.MobileNo,'-- --') AS MobileNo, tg.Prize, CONVERT(VARCHAR,tg.EntryDate,106) AS Check_Date, CASE WHEN ISNULL(tg.IsSMS,0) = 0 THEN  'Pending' ELSE 'Sent' END AS SMS_Status, CASE WHEN ISNULL(tg.IsDelivery,0) = 0 THEN 'Pending' ELSE 'Delivered' END AS Delivery_Status " +
            " FROM         T_GiftDistribution AS tg WHERE ISNULL(tg.MobileNo,'') <> '' AND ISNULL(tg.Prize,'') <> '' " +
            " AND ('' ='" + Reg.Comp_ID + "' OR tg.Comp_ID ='" + Reg.Comp_ID + "') AND ('' ='" + Reg.Pro_ID + "' OR tg.Pro_ID ='" + Reg.Pro_ID + "')  " + //" AND ('' ='' OR tg.SST_Id ='')  " +
            Reg.datefromstr + Reg.datetostr + Reg.modestr + Reg.statusstr;
            dbCommand = database.GetSqlStringCommand(Qry);
            return database.ExecuteDataSet(dbCommand).Tables[0];
        }
    }
}