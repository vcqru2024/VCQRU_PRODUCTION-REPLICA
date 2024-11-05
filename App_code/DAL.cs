using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Business_Logic_Layer;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using System.Data;
using Business9420;
using DataProvider;
using Newtonsoft.Json;

namespace Data_Access_Layer
{
    public class Admin_Login
    {
        private static Database database = DatabaseFactory.CreateDatabase();
        private static DbCommand dbCommand;
        private static DataAdapter adp;
        private static DataSet ds;

        public static DataSet Admin_LoginFunction(Business_Logic_Layer.Admin_Login Adm)
        {
            ds = new DataSet();
            dbCommand = database.GetStoredProcCommand("Proc_AdminLogin");
            database.AddInParameter(dbCommand, "User_Id", DbType.String, Adm.User_id);
            database.AddInParameter(dbCommand, "PWD", DbType.String, Adm.Pwd);
            database.AddInParameter(dbCommand, "typ", DbType.String, Adm.Typ);
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        public static DataSet FillUserDDL()
        {
            dbCommand = database.GetSqlStringCommand("SELECT [typ] FROM [admin_login]");
            return database.ExecuteDataSet(dbCommand);
        }
    }


    public class Registration
    {
        private static Database database = DatabaseFactory.CreateDatabase();
        private static DbCommand dbCommand;
        private static DataAdapter adp;
        private static DataSet ds;

        public static void Registration_Insert(Business_Logic_Layer.Registration Reg)
        {
            Int32 act_reg = 0;
            if (Reg.Dd_Date != "")
                Reg.Dd_Date = Convert.ToDateTime(Reg.Dd_Date).ToString("MM/dd/yyyy");
            string act_date = "";
            if (Reg.Act_Reg == 1)
                act_date = DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy HH:mm:ss");
            string MyQry = " INSERT INTO [Registration] ([user_id],[pwd],[Acc_pass],[name],[father_name],[mother_name],[address],[pincode]" +
               ",[city],[state],[country],[Mobile],[d_o_b],[e_mail] " +
               ",[nominee_name],[nominee_relation],[sponsor_id],[sponsor_name],[status],[reg_date],[act_date],[pan_no],[bank_name],[account_no],[Branch_name],[ifc]" +
                 " ,[Slab])" +
         " VALUES " +
                   "('" + Reg.User_id + "'" +
                   ",'" + Reg.Pwd + "'" +
                      ",'" + Reg.Acc_Pass + "'" +
                  ",'" + Reg.Name.Trim().Replace("'", "") + "'" +
                   ",'" + Reg.Father.Trim().Replace("'", "''") + "'" +
                   ",'" + Reg.Mother.Trim().Replace("'", "''") + "'" +
                   ",'" + Reg.Address.Trim().Replace("'", "''") + "'" +
                    ",'" + Reg.Pincode.Trim().Replace("'", "''") + "'" +
                  " ,'" + Reg.City + "'" +
                   ",'" + Reg.State + "'" +
                   ",'India'" +
                   ",'" + Reg.Mobile.Trim().Replace("'", "''") + "'" +
                   ",'" + Reg.D_o_b.ToString("MM/dd/yyyy") + "'" +
                   ",'" + Reg.E_mail.Trim().Replace("'", "''") + "'" +
                   ",'" + Reg.Nominee_Name.Trim().Replace("'", "''") + "'" +
                   "," + Reg.Relation.Trim() + " " +
                   ",'" + Reg.Sponsor_Id + "'" +
                   ",'" + Reg.Sponsor_Name.Trim().Replace("'", "") + "'" +
                   "," + act_reg + " " +
                   ",'" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "' " +
                   ",'" + act_date + "' " +
                   ",'" + Reg.Pan_no + "','" + Reg.Bank_Name + "','" + Reg.Account_No + "','" + Reg.Branch_Name + "','" + Reg.Ifc + "'," + Reg.Slab + ");";
            dbCommand = database.GetSqlStringCommand(MyQry);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void Registration_Update(Business_Logic_Layer.Registration Reg)
        {
            if (Reg.Dd_Date != "")
                Reg.Dd_Date = Convert.ToDateTime(Reg.Dd_Date).ToString("MM/dd/yyyy");
            string act_date = "";
            if (Reg.Act_Reg == 1)
                act_date = DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy HH:mm:ss");
            string MyQry = "UPDATE [Registration] " +
                       "SET [name] ='" + Reg.Name.Trim().Replace("'", "''") + "'" +
                          ",[father_name] = '" + Reg.Father.Trim().Replace("'", "''") + "'" +
                          ",[mother_name] = '" + Reg.Mother.Trim().Replace("'", "''") + "'" +
                          ",[address] = '" + Reg.Address.Trim().Replace("'", "''") + "'" +
                          ",[city] = '" + Reg.City + "'" +
                          ",[state] = '" + Reg.State + "'" +
                          ",[mobile] = '" + Reg.Mobile.Trim().Replace("'", "''") + "'" +
                          ",[d_o_b] = '" + Reg.D_o_b.ToString("MM/dd/yyy") + "'" +
                          ",[e_mail] ='" + Reg.E_mail.Trim().Replace("'", "''") + "'" +
                          ",[nominee_name] ='" + Reg.Nominee_Name.Trim().Replace("'", "''") + "'" +
                          ",[nominee_relation] ='" + Reg.Relation + "'" +
                          ",[pan_no] ='" + Reg.Pan_no + "'" +
                          ",[bank_name] ='" + Reg.Bank_Name + "'" +
                          ",[account_no] ='" + Reg.Account_No + "'" +
                         ",[Branch_name] ='" + Reg.Branch_Name + "'" +
                         ",[ifc] ='" + Reg.Ifc + "'" +
                         ",[pincode] ='" + Reg.Pincode + "'" +
                     " WHERE  user_id='" + Reg.User_id.Trim() + "';";
            dbCommand = database.GetSqlStringCommand(MyQry);
            database.ExecuteNonQuery(dbCommand);
        }

        public static string GetNewCode(string KeyCol)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Prefix + convert(varchar,startwith) from code_gen WHERE  Key_col='" + KeyCol.Trim() + "'");
            return Convert.ToString(database.ExecuteScalar(dbCommand));
        }
        public static void SetNewCode(string KeyCol)
        {
            SQL_DB.ExecuteNonQuery("update code_gen set startwith=(select max(startwith) from code_gen where Key_col='" + KeyCol.Trim() + "')+1  where Key_col='" + KeyCol.Trim() + "'");
        }
        public static string MyRegistrationExccel(Business_Logic_Layer.Registration RegExccel)
        {
            string g = "Select * From ( " +
                     " SELECT     Row_Number() over (order by Registration.reg_date desc) as sr_no, Registration.user_id, Registration.pwd as Password, Registration.Acc_pass, Registration.name, Registration.father_name,  " +
                      " Registration.mother_name, Registration.address, Registration.pincode, Registration.city, Registration.state, Registration.country,   " +
                      " Registration.mobile, Registration.d_o_b, Registration.pan_no, Registration.e_mail, Registration.bank_name, Registration.account_no,  " +
                     "   Registration.nominee_name, (SELECT [relationship] FROM [relationship_tab] where [id]=Registration.nominee_relation) as Relation,  " +
                      "  Registration.sponsor_id,  " +
                      " Registration.sponsor_name, Registration.status, Registration.reg_date  " +
                      " FROM         Registration  " +
                     "  where ('" + RegExccel.User_id.Trim().Replace("'", "") + "'='' or  Registration.user_id='" + RegExccel.User_id.Trim().Replace("'", "") + "') and (('" + RegExccel.City.Trim() + "'='' or Registration.City='" + RegExccel.City.Trim() + "'))and (('" + RegExccel.Mobile.Trim().Replace("'", "") + "'='' or Registration.Mobile='" + RegExccel.Mobile.Trim().Replace("'", "") + "')) " +
                     "  and (" + RegExccel.Status + "=-1 or Registration.Status=" + RegExccel.Status + ") " +
                     " ) as Reg ";//and ((@Pair=0 or Registration.Tot_Pair>=@Pair))
            return g;
        }
        public static DataSet Fillddlpairsrch()
        {
            ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT [Pair] ,[Medal] FROM [Recog_Pins]");
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        public static DataSet fillDDlrela()
        {
            ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT [id] ,[relationship]FROM [relationship_tab]");
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        public static DataSet fillDDlstate()
        {
            ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT [STATE_ID] ,[stateName] FROM [StateMaster] order by stateName");
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        public static DataSet fillDDlcity(Business_Logic_Layer.Registration RegCity)
        {
            ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT [CITY_ID] ,[CityName]  FROM [CityMaster] WHERE [State_id]='" + RegCity.City.Trim() + "' ORDER BY CityName");
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        public static DataSet fillDDlcitySearch()
        {
            ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT [CITY_ID] ,[CityName]  FROM [CityMaster] WHERE CityName in (SELECT DISTINCT City from Registration)  ORDER BY CityName");
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        public static DataSet fillDDlPro()
        {
            ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("select Product_code,[Upg],Product_Name+'('+convert(varchar,Product_Amount)+')' as Product_Name,Act_Reg  from Product_master where Del_Flag=0 ");
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }

        public static DataSet FillUpDateData(Business_Logic_Layer.Registration Reg_Updt)
        {
            ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT [name],[father_name],[appformno],pin,[ifc],[Category],Branch_name,ifc,[mother_name],[address],[pincode],[city],[state] ,[country],[mobile],[d_o_b],[pan_no],[e_mail],[bank_name],[account_no],[product_code],[nominee_name],[nominee_relation],[nominee_dob],[nominee_address],[payment_mode],[dd_no],[dd_date],[dd_amt],[bank],[sponsor_id],[sponsor_name],[pos],[status],[reg_date],[act_date],[Level_Id],[parent_id] FROM [Registration] where user_id='" + Reg_Updt.User_id + "'");
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }

        public static DataSet FillUpDDDateData(Business_Logic_Layer.Registration Reg_Updt)
        {
            ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("select top 1 DD_Date,DD_No,DD_Bank from F_Transa_Tab where User_Id='" + Reg_Updt.User_id + "'  order by Tra_Id");
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        public static int FinSlab(Business_Logic_Layer.Registration FindS)
        {
            dbCommand = database.GetSqlStringCommand("select isnull(Max([slab]),0) from Registration where User_Id='" + FindS.User_id + "' and name is not null");
            return Convert.ToInt32(database.ExecuteScalar(dbCommand));
        }
        public static string GetName(Business_Logic_Layer.Registration FindS)
        {
            dbCommand = database.GetSqlStringCommand("select name from Registration where User_Id='" + FindS.User_id + "' and name is not null and [slab]=" + FindS.Slab + "");
            return Convert.ToString(database.ExecuteScalar(dbCommand));
        }

        public static int AllCountRows(Business_Logic_Layer.Registration FindS)
        {
            dbCommand = database.GetSqlStringCommand("select count(isnull(name,0)) As Cnt from Registration where name is not null and [slab] > " + FindS.Slab + " and [sponsor_id]='" + FindS.User_id + "'");
            return Convert.ToInt32(database.ExecuteScalar(dbCommand));
        }
        public static void Joining_Request(Business_Logic_Layer.Registration Join)
        {
            dbCommand = database.GetSqlStringCommand("INSERT INTO [joining_Request]([name],[mobile],[e_mail],[address],[CITY_ID])VALUES('" + Join.Name.Trim().Replace("'", "") + "','" + Join.Mobile.Trim().Replace("'", "") + "','" + Join.E_mail.Trim().Replace("'", "") + "','" + Join.Address.Trim().Replace("'", "") + "'," + Join.City + ")");
            database.ExecuteNonQuery(dbCommand);
        }

        //Deepak

        public static DataSet FetchUserLoginDetail(Business_Logic_Layer.Registration RegObj)
        {
            dbCommand = database.GetStoredProcCommand("Proc_UserLogin");
            database.AddInParameter(dbCommand, "user_id", DbType.String, RegObj.User_id);
            database.AddInParameter(dbCommand, "pwd", DbType.String, RegObj.Pwd);
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FetchRetailerLoginDetail(Business_Logic_Layer.Registration RegObj)
        {
            dbCommand = database.GetStoredProcCommand("Proc_RetailerLogin");
            database.AddInParameter(dbCommand, "Ret_Id", DbType.String, RegObj.User_id);
            database.AddInParameter(dbCommand, "Ret_Pass", DbType.String, RegObj.Pwd);
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FillUserSlab(Business_Logic_Layer.Registration RegObj)
        {
            dbCommand = database.GetSqlStringCommand("Select * from getChildUser('" + RegObj.User_id + "')");
            return database.ExecuteDataSet(dbCommand);
        }


        //End
        public static void SendRequestAmount(Business_Logic_Layer.Registration Reg)
        {
            dbCommand = database.GetSqlStringCommand("INSERT INTO [F_Request]([Trans_Id],[User_Id],[Mode],[Req_Date],[Req_Amt],[Remark],[DD_No],[Chk_No],[Bank_Name],[Branch],[Acc_No]) VALUES ('" + Reg.Tra_Id + "','" + Reg.User_id + "','" + Reg.Payment_Mode + "','" + Reg.Reg_Date.ToString("MM/dd/yyyy") + "','" + Reg.Req_Amt + "','" + Reg.Remarks + "','" + Reg.Dd_No + "','" + Reg.Check_No + "','" + Reg.Bank_Name + "','" + Reg.Branch_Name + "','" + Reg.Account_No + "')");
            database.ExecuteNonQuery(dbCommand);
            dbCommand = database.GetSqlStringCommand("UPDATE [Registration] SET [bank_name] = '" + Reg.Bank_Name + "',[account_no] = '" + Reg.Account_No + "',[dd_amt] = '" + Reg.Req_Amt + "',[bank] = '" + Reg.Bank_Name + "' WHERE [user_id] = '" + Reg.User_id + "'    ");
            database.ExecuteNonQuery(dbCommand);
        }
    }
    public class NewssUpDate
    {
        private static Database database = DatabaseFactory.CreateDatabase();
        private static DbCommand dbCommand;
        private static DataAdapter adp;
        private static DataSet ds;

        public static void NewsEntry(NewUpDate mnews)
        {
            dbCommand = database.GetSqlStringCommand("INSERT INTO [News_tab] ([News],[Entry_Date],Updated_Date,News_heading) VALUES ('" + mnews.News.Replace("'", "''") + "','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "','" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "','" + mnews.New_Heading.Trim() + "')");
            database.ExecuteNonQuery(dbCommand);
        }

        public static void NewsEntryUpdate(NewUpDate mnews)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE News_tab SET News='" + mnews.News.Replace("'", "''") + "',Updated_Date='" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "',News_heading='" + mnews.New_Heading.Trim() + "'  where tbl_id=" + mnews.Tbl_Id + " ");
            database.ExecuteNonQuery(dbCommand);
        }

        public static DataSet FillGridData()
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("select top 10 row_number() over(order by tbl_id) as sr_no,[Updated_Date],tbl_id, case when Act_Flag=1 then 'Activated' else 'Deactivated' end as Act_Flag,News,News_heading,Entry_date from News_tab order by Entry_date desc"); dbCommand.CommandTimeout = 500;
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }

        public static DataSet FillDataUpDate(NewUpDate NewUpdt)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("select row_number() over(order by tbl_id) as sr_no,tbl_id,News,News_heading,Entry_date from News_tab  where tbl_id=" + NewUpdt.Tbl_Id + " ");
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }

        public static void DeleteNews(NewUpDate Del)
        {
            dbCommand = database.GetSqlStringCommand("delete from  News_tab where  tbl_id in (" + Del.Tbl_Id + ")");
            database.ExecuteNonQuery(dbCommand);
        }

        public static void NewsEntryUpdateFlag(NewUpDate UFlag)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [News_tab]  SET [Act_Flag] = (case when [Act_Flag]=1 then 0 else 1 end) WHERE tbl_id in (" + UFlag.Tbl_Id + ")");
            database.ExecuteNonQuery(dbCommand);
        }
    }

    #region MyScheme
    public class MyScheme
    {
        private static Database database = DatabaseFactory.CreateDatabase();
        private static DbCommand dbCommand;
        private static DataAdapter adp;
        private static DataSet ds;

        public static void SchemeInsert(Business_Logic_Layer.MyScheme Ins)
        {
            dbCommand = database.GetSqlStringCommand("INSERT INTO [Scheme_Master]([Scheme],[Months],[Deposit],[Offers],[Offer_Paid]) VALUES('" + Ins.Scheme.Trim().Replace("'", "") + "'," + Ins.Months + "," + Ins.Deposit + "," + Ins.Offers + ",'" + Ins.Offer_Paid.Trim().Replace("'", "") + "')");
            database.ExecuteNonQuery(dbCommand);
        }

        internal static void SchemeUpDate(Business_Logic_Layer.MyScheme Ins)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Scheme_Master] SET [Scheme] = '" + Ins.Scheme.Trim().Replace("'", "") + "',[Months] = " + Ins.Months + " ,[Deposit] = " + Ins.Deposit + " ,[Offers] = " + Ins.Offers + " ,[Offer_Paid] ='" + Ins.Offer_Paid.Trim().Replace("'", "") + "' WHERE  [Tbl_Id]=" + Ins.Tbl_Id + " ");
            database.ExecuteNonQuery(dbCommand);

        }

        public static DataSet FillSpeGrid()
        {
            ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT [Tbl_Id],[Scheme],(case when CONVERT(int,ISNULL([Months],0),0)='0' then 'Nill' WHEN CONVERT(int,ISNULL([Months],0),0) !='0' then CONVERT(int,[Months],0) END) AS [Months],(case when CONVERT(int,ISNULL([Deposit],0),0)='0' then 'Nill' when CONVERT(int,ISNULL([Deposit],0),0)!='0' then CONVERT(varchar,[Deposit],0) END) AS [Deposit],(case when CONVERT(int,ISNULL([Offers],0),0)='0' then 'Nill' WHEN CONVERT(int,ISNULL([Offers],0),0) !='0' then CONVERT(int,[Offers],0) END) AS [Offers],(case when Act_Flg=0 then 'Active' else 'Inactive' end) as Status  FROM [Scheme_Master]");
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
    }
    #endregion

    #region Commission
    public class Commission
    {
        private static Database database = DatabaseFactory.CreateDatabase();
        private static DbCommand dbCommand;
        private static DataAdapter adp;
        private static DataSet ds;

        public static DataSet FillCommissionGrid()
        {
            ds = new DataSet();
            string Qry = "SELECT [Tbl_Id],[Level] " +
                     ",(case when CONVERT(int,ISNULL([Reacharge_First],0),0)='0' then 'Nill'  " +
                       "    WHEN CONVERT(int,ISNULL([Reacharge_First],0),0) !='0' then CONVERT(varchar,[Reacharge_First],0) END) AS [Reacharge_First]	   " +
                      ",(case when CONVERT(int,ISNULL([Reacharge_Always],0),0)='0' then 'Nill' " +
                     " when CONVERT(int,ISNULL([Reacharge_Always],0),0)!='0' then CONVERT(varchar,[Reacharge_Always],0) END) AS [Reacharge_Always] " +
                      ",(case when CONVERT(int,ISNULL([Selling_First],0),0)='0' then 'Nill'  " +
                       "    WHEN CONVERT(int,ISNULL([Selling_First],0),0) !='0' then CONVERT(varchar,[Selling_First],0) END) AS [Selling_First]	   " +
                     " ,(case when CONVERT(int,ISNULL([Selling_Always],0),0)='0' then 'Nill' " +
                     " when CONVERT(int,ISNULL([Selling_Always],0),0)!='0' then CONVERT(varchar,[Selling_Always],0) END) AS [Selling_Always] " +
                     " ,(case when CONVERT(int,ISNULL([Booking_First],0),0)='0' then 'Nill'  " +
                       "    WHEN CONVERT(int,ISNULL([Booking_First],0),0) !='0' then CONVERT(varchar,[Booking_First],0) END) AS [Booking_First]	   " +
                    "  ,(case when CONVERT(int,ISNULL([Booking_Always],0),0)='0' then 'Nill' " +
                    "  when CONVERT(int,ISNULL([Booking_Always],0),0)!='0' then CONVERT(varchar,[Booking_Always],0) END) AS [Booking_Always] " +
                 "FROM [Commission_Setting]";
            dbCommand = database.GetSqlStringCommand(Qry);
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }

        public static void Insert(Business_Logic_Layer.Commission Ins)
        {
            dbCommand = database.GetSqlStringCommand("INSERT INTO [Commission_Setting]([Level],[Reacharge_First],[Reacharge_Always],[Selling_First],[Selling_Always],[Booking_First],[Booking_Always]) VALUES (" + Ins.Level + " ,'" + Ins.Recharge_First + "','" + Ins.Recharge_Always + "' ,'" + Ins.Selling_First + "','" + Ins.Selling_Always + "','" + Ins.Booking_First + "','" + Ins.Booking_Always + "')");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void UpDate(Business_Logic_Layer.Commission Ins)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Commission_Setting] SET [Level] = '" + Ins.Level + "',[Reacharge_First] = '" + Ins.Recharge_First + "',[Reacharge_Always] = '" + Ins.Recharge_Always + "',[Selling_First] =  '" + Ins.Selling_First + "',[Selling_Always] =  '" + Ins.Selling_Always + "',[Booking_First] =  '" + Ins.Booking_First + "',[Booking_Always] =  '" + Ins.Booking_Always + "'  WHERE  [Tbl_Id]=" + Ins.Tbl_Id + "");
            database.ExecuteNonQuery(dbCommand);
        }

        internal static DataSet FillUpDateData(Business_Logic_Layer.Commission Filldb)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT [Tbl_Id],[Level],[Reacharge_First],[Reacharge_Always],[Selling_First],[Selling_Always],[Booking_First],[Booking_Always] FROM [Commission_Setting] where Tbl_Id=" + Filldb.Tbl_Id + " ");
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        public static string FillAblBalence(Business_Logic_Layer.Registration Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT (ISNULL(SUM(ISNULL([Req_Amt],0)),0)+isnull((Select sum(isnull(Amount,0)) From Money_Transfer where Transfer_To='" + Reg.User_id + "'),0)+(SELECT isnull(sum(isnull([Final_Amount],0)),0) FROM [Cal_Payment_Tab] where [User_Id]='" + Reg.User_id + "'))-(isnull((Select sum(isnull(Amount,0)) from BankWithdrawal where User_Id='" + Reg.User_id + "' and Aproved=1),0)+isnull((Select SUM(isnull(Coin_Wallet_Amt,0)) from Coin_Wallet_Detail where User_Id ='" + Reg.User_id + "'),0)+isnull((Select sum(isnull(Bid_Amt,0)*isnull(Bid_Qty,0)) from M_Bid_Purchase where User_Id ='" + Reg.User_id + "'),0)+isnull((Select sum(isnull(Amount,0)) From Money_Transfer where Transfer_By='" + Reg.User_id + "'),0)) AS [Req_Amt]  FROM [F_Request] WHERE Commit1=1 and User_Id ='" + Reg.User_id + "'");
            return Convert.ToString(database.ExecuteScalar(dbCommand));
        }
        public static string FillTotalBalence(Business_Logic_Layer.Registration Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT ISNULL(SUM(ISNULL([Req_Amt],0)),0) AS [Req_Amt]  FROM [F_Request] WHERE Commit1=1 and User_Id ='" + Reg.User_id + "'");
            return Convert.ToString(database.ExecuteScalar(dbCommand));
        }
    }
    #endregion

    #region Recognisation
    public class Recognisation
    {

        private static Database database = DatabaseFactory.CreateDatabase();
        private static DbCommand dbCommand;
        private static DataAdapter adp;
        private static DataSet ds;

        #region Methods
        public static void InsertRecognisation(Business_Logic_Layer.Recognisation Reg)
        {
            dbCommand = database.GetSqlStringCommand("INSERT INTO [Recog_Pins] ([Amount],[Medal]) VALUES (" + Reg.Amount + ",'" + Reg.Medel + "')");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void UpDateRecognisation(Business_Logic_Layer.Recognisation Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Recog_Pins] SET [Amount] =" + Reg.Amount + "  ,[Medal] ='" + Reg.Medel + "' WHERE  tbl_id=" + Reg.Tbl_Id);
            database.ExecuteNonQuery(dbCommand);
        }
        public static DataSet FillUpDateData(Business_Logic_Layer.Recognisation Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT [tbl_id],[Amount] ,[Medal] FROM [Recog_Pins] where [tbl_id]=" + Reg.Tbl_Id);
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        public static DataSet FillGrid()
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT [tbl_id],[Amount] ,[Medal] FROM [Recog_Pins] order by tbl_id");
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        #endregion
    }
    #endregion

    #region ManRequest
    public class ManRequest
    {
        private static Database database = DatabaseFactory.CreateDatabase();
        private static DbCommand dbCommand;
        private static DataAdapter adp;
        private static DataSet ds;

        public static DataSet FillManRequest(Business_Logic_Layer.ManRequest Reg)
        {
            ds = new DataSet();
            if (Reg.Date_To == Convert.ToDateTime("01/01/0001 00:00:00"))
                Reg.Date_To = Convert.ToDateTime(DataProvider.LocalDateTime.Now);
            string Qry = "SELECT     joining_Request.id, joining_Request.name, joining_Request.mobile, joining_Request.Remarks, joining_Request.e_mail, joining_Request.address, joining_Request.Entry_Date,joining_Request.CITY_ID, joining_Request.Commit1, CityMaster.CityName, StateMaster.stateName FROM         joining_Request INNER JOIN CityMaster ON joining_Request.CITY_ID = CityMaster.CITY_ID INNER JOIN  StateMaster ON CityMaster.State_id = StateMaster.STATE_ID " +
                         " WHERE('' like '%" + Reg.Name.Trim().Replace("'", "") + "%' or joining_Request.name like '%" + Reg.Name.Trim().Replace("'", "") + "%') " +
                         " AND ('' = '" + Reg.State_Id + "' or StateMaster.STATE_ID = '" + Reg.State_Id + "') " +
                         "and ('' = '" + Reg.City_Id + "' or joining_Request.CITY_ID = '" + Reg.City_Id + "') " +
                         "and ('' >= '" + Reg.Date_From.ToString("dd/MM/yyyy") + "' or convert(varchar,joining_Request.Entry_Date,103) >= '" + Reg.Date_From.ToString("dd/MM/yyyy") + "') " +
                         "and ('' <= '" + Reg.Date_To.ToString("dd/MM/yyyy") + "' or convert(varchar,joining_Request.Entry_Date,103) <= '" + Reg.Date_To.ToString("dd/MM/yyyy") + "') and joining_Request.Commit1=0";
            dbCommand = database.GetSqlStringCommand(Qry);
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
    }
    #endregion

    #region Loyalty
    public class Loyalty_Function
    {
        private static Database database = DatabaseFactory.CreateDatabase();
        private static DbCommand dbCommand;
        /// close midas by tej cash transfer
        public static DataSet CashWalletReport(string strCompanyId)
        {
            DateTime today = System.DateTime.Today;

            dbCommand = database.GetStoredProcCommand("USP_GetCashWalletReport");
            database.AddInParameter(dbCommand, "@Compid", DbType.String, strCompanyId);

            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet GetClaimDetailVendor_downloadMidas(string strCompanyId)
        {
            DateTime today = System.DateTime.Today;
            dbCommand = database.GetStoredProcCommand("USP_GetMarkedPayoutData");
            database.AddInParameter(dbCommand, "@Compid", DbType.String, strCompanyId);
            database.ExecuteNonQuery(dbCommand);
            //}
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet GetClaimDetailVendorWallet_downloadMidas(string strCompanyId)
        {
            DateTime today = System.DateTime.Today;
            dbCommand = database.GetStoredProcCommand("USP_GetCashWalletReport");
            database.AddInParameter(dbCommand, "@Compid", DbType.String, strCompanyId);
            database.ExecuteNonQuery(dbCommand);
            //}
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet GetClaimDetailVendorMidas(string strCompanyId)
        {
            DateTime today = System.DateTime.Today;

            dbCommand = database.GetStoredProcCommand("USP_GetMarkedPayoutData");
            database.AddInParameter(dbCommand, "@Compid", DbType.String, strCompanyId);

            return database.ExecuteDataSet(dbCommand);
        }

        // close midas by tej
        public static DataSet GetClaimDetailVendor(string strCompanyId)
        {
            DateTime today = System.DateTime.Today;
            //if (!string.IsNullOrEmpty(email))
            //{
            //    //dbCommand = database.GetSqlStringCommand("SELECT [id],[BillNo],[PurchaseDate],[Email],[Mobile],WarrantyPeriod,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays FROM [dbo].[WarrentyDetails] where email='" + email + "'");
            //    dbCommand = database.GetSqlStringCommand("SELECT [id],[BillNo],[PurchaseDate],[Email],[Mobile],WarrantyPeriod,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays,ImagePathBill,IsWarrantyClaimed,VendorClaimStatus,ImagePath,VendorComments,Comment FROM [dbo].[WarrentyDetails] Where Email='" + email + "'");
            //}
            //else
            //{


            //string strSql = "SELECT [id],[BillNo],[PurchaseDate],[Email],[Mobile],Code as 'Complete Code',Pro_ID as 'Product_ID',WarrantyPeriod,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays " +
            //",ImagePathBill,IsWarrantyClaimed,VendorClaimStatus,ImagePath,VendorComments,Comment FROM [dbo].[WarrentyDetails] A inner join M_code B on cast(B.Code1 as varchar(20))+'-'+cast(B.Code2 as varchar(20)) = A.Code " +
            //" Where A.IsWarrantyClaimed = 1 and A.PurchaseDate <= getdate() and B.Pro_Id in (select Pro_Id from Pro_Reg where Comp_id = '" + strCompanyId + "') order by A.Purchasedate desc ";

            //string strSql = "SELECT TOP (1000) [Row_id] as Claim_id,[Claim_date],[Mobileno],[Amount],case when [document_status]=1 then 'Uploaded' else 'Not Uploaded' end [document_status],[action_date],case when [Isapproved]=0 then 'Pending' when [Isapproved]=1 then 'Approved' else 'Rejected' end   [vendor_Status],comp_id,vendor_comment,Gifts_Redeemed,Points_Redeemed FROM [ClaimDetails] where comp_id='" + strCompanyId + "' order by [Claim_date] desc";

            //dbCommand = database.GetSqlStringCommand(strSql);
            ////}

            //return database.ExecuteDataSet(dbCommand);



            dbCommand = database.GetStoredProcCommand("sp_getclaimdetails");
            database.AddInParameter(dbCommand, "@Compid", DbType.String, strCompanyId);

            return database.ExecuteDataSet(dbCommand);


        }
        public static DataSet GetClaimDetailVendor_download(string strCompanyId)
        {
            DateTime today = System.DateTime.Today;
            //if (!string.IsNullOrEmpty(email))
            //{
            //    //dbCommand = database.GetSqlStringCommand("SELECT [id],[BillNo],[PurchaseDate],[Email],[Mobile],WarrantyPeriod,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays FROM [dbo].[WarrentyDetails] where email='" + email + "'");
            //    dbCommand = database.GetSqlStringCommand("SELECT [id],[BillNo],[PurchaseDate],[Email],[Mobile],WarrantyPeriod,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays,ImagePathBill,IsWarrantyClaimed,VendorClaimStatus,ImagePath,VendorComments,Comment FROM [dbo].[WarrentyDetails] Where Email='" + email + "'");
            //}
            //else
            //{


            //string strSql = "SELECT [id],[BillNo],[PurchaseDate],[Email],[Mobile],Code as 'Complete Code',Pro_ID as 'Product_ID',WarrantyPeriod,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays " +
            //",ImagePathBill,IsWarrantyClaimed,VendorClaimStatus,ImagePath,VendorComments,Comment FROM [dbo].[WarrentyDetails] A inner join M_code B on cast(B.Code1 as varchar(20))+'-'+cast(B.Code2 as varchar(20)) = A.Code " +
            //" Where A.IsWarrantyClaimed = 1 and A.PurchaseDate <= getdate() and B.Pro_Id in (select Pro_Id from Pro_Reg where Comp_id = '" + strCompanyId + "') order by A.Purchasedate desc ";


            //string strSql = "";
            //strSql = "SELECT TOP (1000) [Row_id] as 'Claim ID',[Claim_date] as 'Claim Date',[Mobileno] as 'Mobile No',[Amount],case when[document_status]=1 then 'Uploaded' else 'Not Uploaded' end 'Documents Status',vendor_comment  as 'Vendor Comment',case when[Isapproved]=0 then 'Pending' when[Isapproved]=1 then 'Approved' else 'Rejected' end   'Claim Status',[action_date] as 'Action Date',vruserType as UserType FROM [ClaimDetails] where comp_id='" + strCompanyId + "' order by [Claim_date] ";
            //if (strCompanyId == "Comp-1400")
            //{
            //    strSql = "SELECT TOP(1000) [Row_id] as 'Claim ID',[Claim_date] as 'Claim Date',[Mobileno] as 'Mobile No',Points_Redeemed as Points,[Amount],case when[document_status] = 1 then 'Uploaded' else 'Not Uploaded' end 'Documents Status',vendor_comment as 'Vendor Comment',case when[Isapproved] = 0 then 'Pending' when[Isapproved] = 1 then 'Approved' else 'Rejected' end   'Claim Status',[action_date] as 'Action Date' FROM[ClaimDetails] where comp_id = '" + strCompanyId + "' order by[Claim_date] ";

            //}

            //dbCommand = database.GetSqlStringCommand(strSql);


            dbCommand = database.GetStoredProcCommand("sp_downloadclaimdetails");
            database.AddInParameter(dbCommand, "@Compid", DbType.String, strCompanyId);

            database.ExecuteNonQuery(dbCommand);

            return database.ExecuteDataSet(dbCommand);
        }

        public static void InsUpdSrvForProduct(Loyalty_Programm obj)
        {
            DataTable cdt = SQL_DB.ExecuteDataTable("SELECT Subscribe_Id FROM M_ServiceSubscriptionTrans WHERE (Subscribe_Id = '" + obj.Subscribe_Id + "') AND (GETDATE() BETWEEN DateFrom AND DateTo)");
            if (cdt.Rows.Count > 0)
            {
                // SQL_DB.ExecuteNonQuery("UPDATE M_ServiceSubscriptionTrans SET IsActive = 0, IsDelete = 1 WHERE (Subscribe_Id = '" + obj.Subscribe_Id + "') AND (GETDATE() BETWEEN DateFrom AND DateTo) AND (IsActive = 1 OR IsActive = 0) AND IsDelete = 0 ");
            }
            try
            {
                #region PROC_InsUpServicesForProduct M_ServiceSubscriptionTrans

                dbCommand = database.GetStoredProcCommand("PROC_InsUpServicesForProduct");
                database.AddInParameter(dbCommand, "ReferralLimit", DbType.Int32, obj.ReferralLimit);
                database.AddInParameter(dbCommand, "SST_Id", DbType.Int64, obj.RowId);
                database.AddInParameter(dbCommand, "Subscribe_Id", DbType.String, obj.Subscribe_Id);
                database.AddInParameter(dbCommand, "Points", DbType.Int32, obj.Points);
                database.AddInParameter(dbCommand, "IsCash", DbType.Int32, obj.IsCash);
                database.AddInParameter(dbCommand, "IsCashConvert", DbType.Int32, obj.IsCashConvert);
                if (obj.DateFrom != null)
                    database.AddInParameter(dbCommand, "DateFrom", DbType.DateTime, Convert.ToDateTime(obj.DateFrom).ToString("yyyy/MM/dd"));
                else
                    database.AddInParameter(dbCommand, "DateFrom", DbType.String, null);
                if (obj.DateTo != null)
                    database.AddInParameter(dbCommand, "DateTo", DbType.DateTime, Convert.ToDateTime(obj.DateTo).ToString("yyyy/MM/dd"));
                else
                    database.AddInParameter(dbCommand, "DateTo", DbType.String, null);
                database.AddInParameter(dbCommand, "IsActive", DbType.Int32, obj.IsActive);
                database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, obj.IsDelete);
                database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
                database.AddInParameter(dbCommand, "Comments", DbType.String, obj.Comments);
                database.AddInParameter(dbCommand, "Frequency", DbType.Int32, obj.Frequency);
                database.AddInParameter(dbCommand, "IsReferral", DbType.Int32, obj.IsReferral);
                database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, obj.Entry_Date);
                database.AddOutParameter(dbCommand, "TransId", DbType.Int64, 10);
                database.AddInParameter(dbCommand, "WarrantyPeriod", DbType.Int32, obj.WarrantyPeriod);
                database.AddInParameter(dbCommand, "AmtType", DbType.String, obj.AmtType);
                database.AddInParameter(dbCommand, "Minval", DbType.Int32, obj.Minval);
                database.AddInParameter(dbCommand, "Maxval", DbType.Int32, obj.Maxval);
                database.AddInParameter(dbCommand, "totalamnt", DbType.Int32, obj.totalloyalty);
                #endregion
                database.ExecuteNonQuery(dbCommand);
                if (obj.DML == "I")
                {
                    obj.Trans_ID = Convert.ToInt64(database.GetParameterValue(dbCommand, "TransId"));
                    obj.RowId = obj.Trans_ID;

                }
                #region Codeing for Referral
                if (obj.IsReferral > 0)
                {
                    Referral IUobj = new Referral();
                    IUobj = obj.Referrals;
                    IUobj.SST_Id = obj.RowId;
                    dbCommand = database.GetStoredProcCommand("PROC_InsUpReferralInfo");
                    database.AddInParameter(dbCommand, "SST_Id", DbType.Int64, IUobj.SST_Id);
                    database.AddInParameter(dbCommand, "PointsReferral", DbType.Int64, IUobj.PointsReferral);
                    database.AddInParameter(dbCommand, "PointsUsers", DbType.Int64, IUobj.PointsUsers);
                    database.AddInParameter(dbCommand, "IsCashReferral", DbType.Int64, IUobj.IsCashReferral);
                    database.AddInParameter(dbCommand, "IsCashUsers", DbType.Int64, IUobj.IsCashUsers);
                    database.AddInParameter(dbCommand, "GiftReferral", DbType.String, IUobj.GiftReferral);
                    database.AddInParameter(dbCommand, "GiftUsers", DbType.String, IUobj.GiftUsers);
                    database.AddInParameter(dbCommand, "IsCashConvert", DbType.Int32, IUobj.IsCashConvert);
                    database.AddInParameter(dbCommand, "Frequency", DbType.Int32, IUobj.Frequency);
                    database.AddInParameter(dbCommand, "DML", DbType.String, IUobj.DML);
                    database.ExecuteNonQuery(dbCommand);
                }
                #endregion
                #region Logic for Insert Service Rules  & Service Prize
                if (obj.GiftList.Count > 0)
                {
                    string Qry = "";
                    if (obj.DML == "I")
                        obj.PrizeTrans_Id = GetMyCodeGenID("Prize Distribution");
                    else
                    {
                        Qry = "DELETE FROM [M_ServicePrize] WHERE PrizeTrans_Id = '" + obj.PrizeTrans_Id + "' ";
                        dbCommand = database.GetSqlStringCommand(Qry);
                        database.ExecuteNonQuery(dbCommand);
                    }
                    Gifts InfObj = new Gifts();
                    #region Insert Gift count like , car, laptop . 2 type of gift assigned it.
                    Int64 CouponRequest_pkID = 0;
                    foreach (Gifts item in obj.GiftList)
                    {
                        //try
                        //{
                        //    if (item.GiftCount != 0)
                        //    {
                        // Very IMPORTANT - UPDATING M_COUPONCODES TABBE BY intM_CouponRequestid


                        dbCommand = database.GetStoredProcCommand("PROC_InsUpServicesPrize");
                        database.AddInParameter(dbCommand, "SST_Id", DbType.Int64, obj.RowId);
                        database.AddInParameter(dbCommand, "PrizeTrans_Id", DbType.String, obj.PrizeTrans_Id);
                        database.AddInParameter(dbCommand, "GiftName", DbType.String, item.GiftName);
                        database.AddInParameter(dbCommand, "GiftCount", DbType.Int64, item.GiftCount);

                        if (item.Gift_ID.ToString().Contains('&'))
                        {
                            string[] strArray = item.Gift_ID.ToString().Split('&');
                            string couponid = strArray[0];
                            CouponRequest_pkID = Convert.ToInt64(strArray[1]);
                            database.AddInParameter(dbCommand, "Gift_ID", DbType.String, couponid);
                            database.AddInParameter(dbCommand, "CouponRequest_pkID", DbType.Int64, CouponRequest_pkID);
                        }
                        else
                        {
                            database.AddInParameter(dbCommand, "Gift_ID", DbType.String, item.Gift_ID);
                            database.AddInParameter(dbCommand, "CouponRequest_pkID", DbType.Int64, 0);
                        }




                        //database.AddInParameter(dbCommand, "intM_CouponRequestid", DbType.String, intM_CouponRequestid);
                        database.ExecuteNonQuery(dbCommand);
                        //    }
                        //    else
                        //        InfObj = item;
                        //}
                        //catch (Exception ex)
                        //{

                        //}                        
                    }
                    //if ((InfObj.GiftCount == 0) && (InfObj.GiftName != null))
                    //{
                    //    dbCommand = database.GetStoredProcCommand("PROC_InsUpServicesPrize");
                    //    database.AddInParameter(dbCommand, "SST_Id", DbType.Int64, obj.RowId);
                    //    database.AddInParameter(dbCommand, "PrizeTrans_Id", DbType.String, obj.PrizeTrans_Id);
                    //    database.AddInParameter(dbCommand, "Gift_ID", DbType.String, InfObj.Gift_ID);
                    //    database.AddInParameter(dbCommand, "GiftName", DbType.String, InfObj.GiftName);
                    //    database.AddInParameter(dbCommand, "GiftCount", DbType.Int64, InfObj.GiftCount);
                    //    database.ExecuteNonQuery(dbCommand);
                    //}
                    #endregion
                    Int64 TotalRwdCount = 0;
                    var pt = obj.GiftList.Where(x => x.GiftCount == 0).SingleOrDefault();
                    if (pt != null)
                        TotalRwdCount = 0;
                    else
                        TotalRwdCount = obj.GiftList.Sum(x => x.GiftCount);
                    if (obj.DML == "I")
                        SetMyCodeGenID("Prize Distribution");

                    // increamented +1 in UPDATE Code_Gen SET PrStart
                    //if (obj.DML == "I")
                    //    Qry = "INSERT INTO [M_ServiceRules] ([SST_Id],[ServiceType],[Rules],[DistributionType],[PrizeTrans_Id],[MasterCodes],[WinningCodes],[WinCodes],[Frequency]) VALUES ('" 
                    //        + obj.RowId + "','" + obj.ServiceType.Replace("'", "''") + "','" + obj.Rules.Replace("'", "''") + "','" + obj.RewardsDistribution.Replace("'", "''") + "','"
                    //        + obj.PrizeTrans_Id + "','" + obj.MasterCodes + "','" + obj.WinningCodes + "','" + obj.WinCodes + "'," + obj.Nth + ")";
                    //else
                    //    Qry = "UPDATE [M_ServiceRules] SET [SST_Id] = '" + obj.RowId + "',[ServiceType] =  '" + obj.ServiceType.Replace("'", "''") + "',[Rules] = '" + obj.Rules.Replace("'", "''") + "',[DistributionType] = '" + obj.RewardsDistribution.Replace("'", "''") + "',[PrizeTrans_Id] = '" + obj.PrizeTrans_Id + "',[MasterCodes] = '" + obj.MasterCodes + "',[WinningCodes] = '" + obj.WinningCodes + "',[WinCodes]= '" + obj.WinCodes + "' , [Frequency] = " + obj.Nth + " WHERE  PrizeTrans_Id = '" + obj.PrizeTrans_Id + "' ";
                    //dbCommand = database.GetSqlStringCommand(Qry);
                    //database.ExecuteNonQuery(dbCommand);
                    int intM_Serviceruleid = 0;
                    try
                    {
                        //if (string.IsNullOrEmpty(strDueDate))
                        //{
                        //    intM_Serviceruleid = ServiceLogic.M_ServiceRuleInsertUpdate(obj.RowId, obj.ServiceType.Replace("'", "''"),
                        //   obj.Rules.Replace("'", "''"), obj.RewardsDistribution.Replace("'", "''"), obj.PrizeTrans_Id, obj.MasterCodes,
                        //   obj.WinningCodes, obj.WinCodes, +obj.Nth, obj.DML, null);
                        //}
                        //else
                        //{
                        intM_Serviceruleid = ServiceLogic.M_ServiceRuleInsertUpdate(obj.RowId, obj.ServiceType.Replace("'", "''"),
                       obj.Rules.Replace("'", "''"), obj.RewardsDistribution.Replace("'", "''"), obj.PrizeTrans_Id, obj.MasterCodes,
                       obj.WinningCodes, obj.WinCodes, +obj.Nth, obj.DML, obj.dttxtDueDate);
                        // }
                    }
                    catch (Exception ex)
                    {

                        throw ex;
                    }


                    //if obj.RewardsDistribution == RwdDistrubutionRules.Sequence

                    if (obj.RewardsDistribution == RwdDistrubutionRules.Sequence.ToString())
                    {
                        if (obj.ServiceType == ServiceTypes.Instant.ToString())
                        {
                            int intIsertSuccess = ServiceLogic.InsertCouponCodeForSequence(obj.RowId, obj.ServiceType, obj.Rules, obj.RewardsDistribution, obj.WinningCodes, obj.Nth, intM_Serviceruleid, obj.Comp_ID, obj.ServiceType, obj.RewardsDistribution);
                        }
                        else if (obj.ServiceType == ServiceTypes.DueDate.ToString())
                        {
                            // all winners will show on due date
                        }
                    }
                    #region Comment codes


                    if (obj.Rules == ServiceRules.RandomNCustomer.ToString())
                    {
                        //#region For Random Winner Logics
                        //Qry = "SELECT TOP(" + obj.MasterCodes + ") Row_ID, ScrapeFlag FROM M_Code WHERE (ISNULL(Batch_No, N'') <> '') AND Pro_ID = '" + obj.Pro_ID + "' AND ISNULL(Use_Count,0) = 0 ORDER BY NEWID() ";
                        //dbCommand = database.GetSqlStringCommand(Qry);
                        //DataTable dt = database.ExecuteDataSet(dbCommand).Tables[0];
                        //if (dt.Rows.Count > 0)
                        //{
                        //    if (obj.DML != "I")
                        //    {
                        //        Qry = "DELETE FROM M_RandomPrize WHERE SST_Id = '" + obj.RowId + "' ";
                        //        dbCommand = database.GetSqlStringCommand(Qry);
                        //        database.ExecuteNonQuery(dbCommand);
                        //    }
                        //    #region Logic for Entry
                        //    Qry = "SELECT SUM(GiftCount) FROM M_ServicePrize where PrizeTrans_Id='" + obj.PrizeTrans_Id + "'";
                        //    dbCommand = database.GetSqlStringCommand(Qry);
                        //    Int64 GiftCount = Convert.ToInt64(database.ExecuteScalar(dbCommand));
                        //    Qry = "SELECT Gift_Id,GiftName,GiftCount FROM M_ServicePrize where PrizeTrans_Id='" + obj.PrizeTrans_Id + "'";
                        //    dbCommand = database.GetSqlStringCommand(Qry);
                        //    DataTable gdt = database.ExecuteDataSet(dbCommand).Tables[0];
                        //    DataTable cpdt = new DataTable();
                        //    List<AllotedCoupons> CouponsList = new List<AllotedCoupons>();
                        //    if (obj.RewardsDistribution == RwdDistrubutionRules.Random.ToString())
                        //    {
                        //        #region Get List Distribution for Awards
                        //        List<Gifts> Lst = new List<Gifts>();
                        //        if (gdt.Rows.Count > 0)
                        //        {
                        //            //for (int p = 0; p < gdt.Rows.Count; p++)
                        //            //    Lst.Add(new Gifts { Gift_ID = gdt.Rows[p]["Gift_Id"].ToString(), GiftName = gdt.Rows[p]["GiftName"].ToString(), GiftCount = Convert.ToInt64(gdt.Rows[p]["GiftCount"]), DistributeGiftCount = Convert.ToInt64(0) });
                        //            for (int p = 0; p < gdt.Rows.Count; p++)
                        //            {
                        //                string PreFix = gdt.Rows[p]["Gift_Id"].ToString().Substring(0, 3);
                        //                if (PreFix == "CPN")
                        //                {
                        //                    cpdt = new DataTable();
                        //                    Qry = "SELECT TOP (" + Convert.ToInt64(gdt.Rows[p]["GiftCount"]) + ") CouponTrans_ID, Coupon_ID, CouponCode, ValidFrom, ValidTo, SST_Id, IsUsed,AllotedDate, EntryDate FROM M_CouponCodes WHERE Comp_ID = '" + obj.Comp_ID + "'  AND ISNULL(IsUsed,0) = 0 AND ISNULL(AllotedDate,'') <> '' AND ISNULL(SST_Id,0) = 0 ";
                        //                    dbCommand = database.GetSqlStringCommand(Qry);
                        //                    cpdt = database.ExecuteDataSet(dbCommand).Tables[0];
                        //                    for (int z = 0; z < cpdt.Rows.Count; z++)
                        //                    {
                        //                        CouponsList.Add(new AllotedCoupons { CouponTrans_ID = Convert.ToInt64(cpdt.Rows[z]["CouponTrans_ID"].ToString()) });
                        //                        Lst.Add(new Gifts { Gift_ID = gdt.Rows[p]["Gift_Id"].ToString(), GiftName = cpdt.Rows[z]["CouponCode"].ToString(), GiftCount = 1, DistributeGiftCount = Convert.ToInt64(0) });
                        //                    }
                        //                }
                        //                else
                        //                    Lst.Add(new Gifts { Gift_ID = gdt.Rows[p]["Gift_Id"].ToString(), GiftName = gdt.Rows[p]["GiftName"].ToString(), GiftCount = Convert.ToInt64(gdt.Rows[p]["GiftCount"]), DistributeGiftCount = Convert.ToInt64(0) });
                        //            }
                        //        }
                        //        #endregion
                        //        int cnt = 0;
                        //        for (int i = 0; i < GiftCount; i++)
                        //        {
                        //            #region Logic for Entry predefine random gift
                        //            string GNM = "";
                        //            Random rnd = new Random();
                        //            int rt = rnd.Next(Lst.Count);
                        //            Random r = new Random();
                        //            var rand = Lst[r.Next(Lst.Count)];
                        //            Int64 p = rand.DistributeGiftCount; p++;
                        //            Int64 tp = rand.GiftCount;
                        //            GNM = rand.GiftName;
                        //            rand.DistributeGiftCount = p;
                        //            if (tp == p)
                        //                Lst.Remove(rand);
                        //            Qry += "INSERT INTO [M_RandomPrize] ([Row_Id],[SST_Id],[Prize] ,[IsUsed]) VALUES ('" + dt.Rows[i]["Row_ID"].ToString() + "','" + obj.RowId + "','" + GNM + "',0);";
                        //            cnt++;
                        //            if (cnt == 100)
                        //            {
                        //                dbCommand = database.GetSqlStringCommand(Qry);
                        //                database.ExecuteNonQuery(dbCommand);
                        //                cnt = 0; Qry = "";

                        //            }
                        //            #endregion
                        //        }
                        //        if (Qry.Length > 1)
                        //        {
                        //            dbCommand = database.GetSqlStringCommand(Qry);
                        //            database.ExecuteNonQuery(dbCommand);
                        //        }
                        //        //#region Update Coupon IsUsed
                        //        //if (CouponsList.Count > 0)
                        //        //{
                        //        //    string Query = ""; int MyCounter = 0;
                        //        //    foreach (var item in CouponsList)
                        //        //    {
                        //        //        Query += "UPDATE [M_CouponCodes] SET [SST_Id] = '" + obj.RowId + "' WHERE [CouponTrans_ID] = '" + item.CouponTrans_ID + "'";
                        //        //        MyCounter++;
                        //        //        if (MyCounter == 100)
                        //        //        {
                        //        //            SQL_DB.ExecuteNonQuery(Query);
                        //        //            Query = ""; MyCounter = 0;
                        //        //        }
                        //        //    }
                        //        //    if (Query != "")
                        //        //    {
                        //        //        SQL_DB.ExecuteNonQuery(Query);
                        //        //        Query = ""; MyCounter = 0;
                        //        //    }

                        //        //}
                        //        //#endregion
                        //    }
                        //    else
                        //    {

                        //    }
                        //    #endregion
                        //}
                        //#endregion
                    }
                    else
                    {
                        //if (obj.DML != "I")
                        //{
                        //    Qry = "DELETE FROM M_RandomPrize WHERE SST_Id = '" + obj.RowId + "' ";
                        //    dbCommand = database.GetSqlStringCommand(Qry);
                        //    database.ExecuteNonQuery(dbCommand);
                        //}
                        //#region Logic for Entry
                        //Qry = "SELECT SUM(GiftCount) FROM M_ServicePrize where PrizeTrans_Id='" + obj.PrizeTrans_Id + "'";
                        //dbCommand = database.GetSqlStringCommand(Qry);
                        //Int64 GiftCount = Convert.ToInt64(database.ExecuteScalar(dbCommand));
                        //Qry = "SELECT Gift_Id,GiftName,GiftCount FROM M_ServicePrize where PrizeTrans_Id='" + obj.PrizeTrans_Id + "'";
                        //dbCommand = database.GetSqlStringCommand(Qry);
                        //DataTable gdt = database.ExecuteDataSet(dbCommand).Tables[0];
                        //DataTable cpdt = new DataTable();
                        //List<AllotedCoupons> CouponsList = new List<AllotedCoupons>();
                        //#region Get List Distribution for Awards
                        //List<Gifts> Lst = new List<Gifts>();
                        //if (gdt.Rows.Count > 0)
                        //{
                        //    //for (int p = 0; p < gdt.Rows.Count; p++)
                        //    //    Lst.Add(new Gifts { Gift_ID = gdt.Rows[p]["Gift_Id"].ToString(), GiftName = gdt.Rows[p]["GiftName"].ToString(), GiftCount = Convert.ToInt64(gdt.Rows[p]["GiftCount"]), DistributeGiftCount = Convert.ToInt64(0) });
                        //    for (int p = 0; p < gdt.Rows.Count; p++)
                        //    {
                        //        string PreFix = gdt.Rows[p]["Gift_Id"].ToString().Substring(0, 3);
                        //        if (PreFix == "CPN")
                        //        {
                        //            cpdt = new DataTable();
                        //            Qry = "SELECT TOP (" + Convert.ToInt64(gdt.Rows[p]["GiftCount"]) + ") CouponTrans_ID, Coupon_ID, CouponCode, ValidFrom, ValidTo, SST_Id, IsUsed,AllotedDate, EntryDate FROM M_CouponCodes WHERE Comp_ID = '" + obj.Comp_ID + "'  AND ISNULL(IsUsed,0) = 0 AND ISNULL(AllotedDate,'') <> '' AND ISNULL(SST_Id,0) = 0 AND (Coupon_ID = '" + gdt.Rows[p]["Gift_Id"].ToString() + "') ";
                        //            dbCommand = database.GetSqlStringCommand(Qry);
                        //            cpdt = database.ExecuteDataSet(dbCommand).Tables[0];
                        //            for (int z = 0; z < cpdt.Rows.Count; z++)
                        //            {
                        //                CouponsList.Add(new AllotedCoupons { CouponTrans_ID = Convert.ToInt64(cpdt.Rows[z]["CouponTrans_ID"].ToString()) });
                        //                Lst.Add(new Gifts { Gift_ID = gdt.Rows[p]["Gift_Id"].ToString(), GiftName = cpdt.Rows[z]["CouponCode"].ToString(), GiftCount = 1, DistributeGiftCount = Convert.ToInt64(0) });
                        //            }
                        //        }
                        //        else
                        //            Lst.Add(new Gifts { Gift_ID = gdt.Rows[p]["Gift_Id"].ToString(), GiftName = gdt.Rows[p]["GiftName"].ToString(), GiftCount = Convert.ToInt64(gdt.Rows[p]["GiftCount"]), DistributeGiftCount = Convert.ToInt64(0) });
                        //    }
                        //}
                        //#endregion
                        //#region Update Coupon IsUsed
                        //if (CouponsList.Count > 0)
                        //{
                        //    string Query = ""; int MyCounter = 0;
                        //    foreach (var item in CouponsList)
                        //    {
                        //        Query += "UPDATE [M_CouponCodes] SET [SST_Id] = '" + obj.RowId + "' WHERE [CouponTrans_ID] = '" + item.CouponTrans_ID + "'";
                        //        MyCounter++;
                        //        if (MyCounter == 100)
                        //        {
                        //            SQL_DB.ExecuteNonQuery(Query);
                        //            Query = ""; MyCounter = 0;
                        //        }
                        //    }
                        //    if (Query != "")
                        //    {
                        //        SQL_DB.ExecuteNonQuery(Query);
                        //        Query = ""; MyCounter = 0;
                        //    }

                        //}
                        //#endregion
                        //#endregion
                    }
                    #endregion
                }
                #endregion

            }
            catch (Exception Ex)
            {
                obj.Msg = Ex.Message.ToString();
            }
        }
        public static void InsertUpdateLoyalty(Loyalty_Programm obj)
        {
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_InsertUpdateLoyalty");
                database.AddInParameter(dbCommand, "RowId", DbType.Int64, obj.RowId);
                database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
                database.AddInParameter(dbCommand, "Pro_ID", DbType.String, obj.Pro_ID);
                database.AddInParameter(dbCommand, "Points", DbType.Decimal, obj.Points);
                database.AddInParameter(dbCommand, "IsCashConvert", DbType.Int32, obj.IsCashConvert);
                database.AddInParameter(dbCommand, "DateFrom", DbType.String, obj.DateFrom);
                database.AddInParameter(dbCommand, "DateTo", DbType.String, obj.DateTo);
                database.AddInParameter(dbCommand, "IsActive", DbType.Int32, obj.IsActive);
                database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, obj.IsDelete);
                database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
                database.AddInParameter(dbCommand, "Comments", DbType.String, obj.Comments);
                database.AddInParameter(dbCommand, "Frequency", DbType.String, obj.Frequency);
                database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, obj.Entry_Date);
                database.ExecuteNonQuery(dbCommand);
                if (obj.DML == "I")
                {
                    string Qry = "SELECT RowId FROM M_Loyalty  WHERE Comp_ID = '" + obj.Comp_ID + "' AND Pro_ID = '" + obj.Pro_ID + "' AND IsActive = 0 ORDER BY RowId DESC ";
                    DataProvider.LogManager.WriteExe("Return Row Id " + Qry);
                    DataTable dt = SQL_DB.ExecuteDataSet(Qry).Tables[0];
                    if (dt.Rows.Count > 0)
                        obj.RowId = Convert.ToInt64(dt.Rows[0]["RowId"]);
                }
            }
            catch (Exception Ex)
            {
                obj.Msg = Ex.Message.ToString();
            }
        }

        public static DataSet FillLoyaltyGrid()
        {
            throw new NotImplementedException();
        }

        public static void InsertUpdateLoyaltySeetings(Loyalty_Settings obj)
        {
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_InsUpdLoyaltySetings");
                database.AddInParameter(dbCommand, "RowId", DbType.Int64, obj.RowId);
                database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
                database.AddInParameter(dbCommand, "Min_Bank_Transfer", DbType.Decimal, obj.Min_Bank_Transfer);
                database.AddInParameter(dbCommand, "Points", DbType.Decimal, obj.Points);
                database.AddInParameter(dbCommand, "IsActive", DbType.Int32, obj.IsActive);
                database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, obj.IsDelete);
                database.AddInParameter(dbCommand, "Courier", DbType.Int32, obj.Courier);
                database.AddInParameter(dbCommand, "Dealer", DbType.Int32, obj.Dealer);
                database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
                database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, obj.Entry_Date);
                database.AddInParameter(dbCommand, "ReferralMinimumlimit", DbType.Int32, obj.ReferralLimit);
                database.ExecuteNonQuery(dbCommand);
            }
            catch (Exception Ex)
            {
                obj.Msg = Ex.Message.ToString();
            }
        }
        public static void InsertUpdateReferralLimit(Loyalty_Settings obj)
        {
            try
            {
                dbCommand = database.GetStoredProcCommand("[PROC_InsUpdReferralLimit]");
                database.AddInParameter(dbCommand, "@Limit", DbType.Int32, obj.ReferralLimit);
                database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
                database.AddInParameter(dbCommand, "@ReferralID", DbType.Int32, obj.ReferralID);
                database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
                database.ExecuteNonQuery(dbCommand);
            }
            catch (Exception Ex)
            {
                obj.Msg = Ex.Message.ToString();
            }
        }
        public static DataSet FillLoyaltySettingsGrid(Loyalty_Settings obj)
        {
            DataSet ds = new DataSet();
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_GridDataLoyaltySettings");
                database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
                database.AddInParameter(dbCommand, "@Referral", DbType.String, obj.Referral);
                ds = database.ExecuteDataSet(dbCommand);
                return ds;
            }
            catch (Exception Ex)
            {
                obj.Msg = Ex.Message.ToString();
                return ds;
            }
        }

        public static void InsertUpdateLoyaltyAwards(Loyalty_Awards obj)
        {
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_InsUpdLoyaltyAwards");
                database.AddInParameter(dbCommand, "RowId", DbType.Int64, obj.RowId);
                database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
                database.AddInParameter(dbCommand, "AwardName", DbType.String, obj.AwardName);
                database.AddInParameter(dbCommand, "Points", DbType.Decimal, obj.Points);
                database.AddInParameter(dbCommand, "IsActive", DbType.Int32, obj.IsActive);
                database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, obj.IsDelete);
                database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
                database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, obj.Entry_Date);
                database.ExecuteNonQuery(dbCommand);
            }
            catch (Exception Ex)
            {
                obj.Msg = Ex.Message.ToString();
            }
        }
        public static bool GetIsCashConvert(string Pro_ID)
        {
            DataTable dt = SQL_DB.ExecuteDataSet("SELECT IsCashConvert, DateFrom, DateTo FROM M_Loyalty WHERE Pro_ID = '" + Pro_ID + "' AND  IsActive = 0 AND IsDelete = 0 ").Tables[0];
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["IsCashConvert"].ToString() == "0")
                    return true;
                else
                    return false;
            }
            return false;
        }
        public static void InsertUpdatePoints(Loyalty_Points obj)
        {
            try
            {
                //if (obj.IsReferral == 0)
                //{
                //    if (GetIsCashConvert(obj.Pro_ID))
                //        obj.IsCashConvert = 0;
                //    else
                //        obj.IsCashConvert = 1;
                //}
                //else
                //    obj.IsCashConvert = obj.IsConvertCash;
                //if (obj.Points == 0)
                //    obj.IsUse = 0;
                //else
                //    obj.IsUse = 1;
                dbCommand = database.GetStoredProcCommand("PROC_InsUpdPoints");
                database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
                database.AddInParameter(dbCommand, "Pro_ID", DbType.String, obj.Pro_ID);
                database.AddInParameter(dbCommand, "User_ID", DbType.String, obj.User_ID);
                database.AddInParameter(dbCommand, "Code1", DbType.Int64, obj.Code1);
                database.AddInParameter(dbCommand, "Code2", DbType.Int64, obj.Code2);
                database.AddInParameter(dbCommand, "Points", DbType.Decimal, obj.Points);
                database.AddInParameter(dbCommand, "Type", DbType.String, obj.EarnType);
                database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
                database.AddInParameter(dbCommand, "Mode", DbType.String, obj.Mode);
                database.AddInParameter(dbCommand, "IsCashConvert", DbType.Int32, obj.IsCashConvert);
                database.AddInParameter(dbCommand, "IsUse", DbType.Int32, obj.IsUse);
                database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, obj.Entry_Date);
                database.ExecuteNonQuery(dbCommand);
                //DataTable ddt = SQL_DB.ExecuteDataSet("Select Use_Count FROM M_Code WHERE Code1 = " + obj.Code1 + " AND Code2 = " + obj.Code2 + " ").Tables[0];
                //if (ddt.Rows.Count > 0)
                //{
                //    int p = Convert.ToInt32(ddt.Rows[0]["Use_Count"]); p++;
                //    SQL_DB.ExecuteNonQuery("UPDATE M_Code SET Use_Count =  "+ p +"  WHERE Code1 = " + obj.Code1 + " AND Code2 = " + obj.Code2 + " ");
                //}
            }
            catch (Exception Ex)
            {
                obj.Msg = Ex.Message.ToString();
            }
        }
        public static DataSet FillLoyaltyAwardsGrid(Loyalty_Awards obj)
        {
            DataSet ds = new DataSet();
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_GridDataLoyaltyAwards");
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
        public static void FillLoyaltyAwardsGridObject(Loyalty_Awards obj)
        {
            DataSet ds = new DataSet();
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_GridDataLoyaltyAwards");
                database.AddInParameter(dbCommand, "RowId", DbType.String, obj.RowId);
                database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
                database.AddInParameter(dbCommand, "AwardName", DbType.String, obj.AwardName);
                ds = database.ExecuteDataSet(dbCommand);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    obj.AwardName = ds.Tables[0].Rows[0]["AwardName"].ToString();
                    obj.Points = Convert.ToDecimal(ds.Tables[0].Rows[0]["Points"]);
                    obj.IsDelete = Convert.ToInt32(ds.Tables[0].Rows[0]["IsDelete"]);
                    obj.IsActive = Convert.ToInt32(ds.Tables[0].Rows[0]["IsActive"]);
                    obj.Comp_ID = ds.Tables[0].Rows[0]["Comp_ID"].ToString();
                    obj.RowId = Convert.ToInt64(ds.Tables[0].Rows[0]["RowId"]);
                }
            }
            catch (Exception Ex)
            {
                obj.Msg = Ex.Message.ToString();
            }
        }

        public static void IsActiveIsDeleteLoyaltyAwards(Loyalty_Awards obj)
        {
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_IsAciveDeleteLoyaltyAwards");
                database.AddInParameter(dbCommand, "RowId", DbType.String, obj.RowId);
                database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
                database.AddInParameter(dbCommand, "IsActive", DbType.Int32, obj.IsActive);
                database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, obj.IsDelete);
                database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
                database.ExecuteNonQuery(dbCommand);
            }
            catch (Exception Ex)
            {
                obj.Msg = Ex.Message.ToString();
            }
        }
        public static void IsActiveIsDeleteBigDtataAlnalysisDATA(Loyalty_Awards obj)
        {
            try
            {
                dbCommand = database.GetStoredProcCommand("[PROC_IsAciveDeleteBigDtataAlnalysisDATA]");
                database.AddInParameter(dbCommand, "RowId", DbType.String, obj.RowId);
                database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
                database.AddInParameter(dbCommand, "IsActive", DbType.Int32, obj.IsActive);
                database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, obj.IsDelete);
                database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
                database.ExecuteNonQuery(dbCommand);
            }
            catch (Exception Ex)
            {
                obj.Msg = Ex.Message.ToString();
            }
        }

public static void InsertUpdateExibitiondtls(Exibition_details obj)
        {
            try
            {

                dbCommand = database.GetStoredProcCommand("InsertUpdateExhibitionDtls");
                database.AddInParameter(dbCommand, "@Mobile", DbType.String, obj.MobileNo);
                database.AddInParameter(dbCommand, "@Name", DbType.String, obj.Name);
                database.AddInParameter(dbCommand, "@Email", DbType.String, obj.Email);
                database.AddInParameter(dbCommand, "@Compname", DbType.String, obj.CompNAme);
                database.AddInParameter(dbCommand, "@Designation", DbType.String, obj.Designation);
                database.AddInParameter(dbCommand, "@Intrest", DbType.String, obj.Intrest);
                database.AddInParameter(dbCommand, "@Exibition", DbType.String, obj.Exibitionname);
                database.AddInParameter(dbCommand, "@DML", DbType.String, obj.DML);
                database.ExecuteNonQuery(dbCommand);

            }
            catch (Exception Ex)
            {
                DataProvider.LogManager.WriteExe("Find Error in Procedure with " + Ex.Message.ToString());
            }
        }

        public static void InsertUpdateUserDetails(User_Details obj)
        {
            try
            {
                //    if (obj.DML == "I")
                //        obj.User_ID = GetMyCodeGenID("Consumer");
                dbCommand = database.GetStoredProcCommand("PROC_InsUpdUserDetails");
                database.AddInParameter(dbCommand, "User_ID", DbType.String, obj.User_ID);
                database.AddInParameter(dbCommand, "ConsumerName", DbType.String, obj.ConsumerName);
                database.AddInParameter(dbCommand, "Email", DbType.String, obj.Email);
                database.AddInParameter(dbCommand, "MobileNo", DbType.String, obj.MobileNo);
                database.AddInParameter(dbCommand, "City", DbType.String, obj.City);
                database.AddInParameter(dbCommand, "PinCode", DbType.String, obj.PinCode);
                database.AddInParameter(dbCommand, "Password", DbType.String, obj.Password);
                database.AddInParameter(dbCommand, "IsActive", DbType.Int32, obj.IsActive);
                database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, obj.IsDelete);
                database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
                database.AddInParameter(dbCommand, "Address", DbType.String, obj.Address);
                database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, obj.Entry_Date);
                database.AddInParameter(dbCommand, "Code1", DbType.Int32, obj.code1);
                database.AddInParameter(dbCommand, "Code2", DbType.Int32, obj.code1);
		        database.AddInParameter(dbCommand, "UPI", DbType.String, obj.UPI);      //Ambica kable
                database.AddInParameter(dbCommand, "pancard_number", DbType.String, obj.PanNumber);      //Hannover
                database.AddInParameter(dbCommand, "Inox_User_Type", DbType.String, obj.Role_ID); //bipin for Inox ddl
		        database.AddInParameter(dbCommand, "Other_Role", DbType.String, obj.Other_Role); //bipin for Inox ddl
                database.AddInParameter(dbCommand, "Vr_gender", DbType.String, obj.gender);
                database.AddInParameter(dbCommand, "Agegroup", DbType.String, obj.Agegroup);  // Added by Bipin for Ramgopal

                database.AddInParameter(dbCommand, "employeeID", DbType.String, obj.MMEmployeID);
                database.AddInParameter(dbCommand, "distributorID", DbType.String, obj.MMDistributorID);
                database.AddInParameter(dbCommand, "aadharNumber", DbType.String, obj.AadhaarNumber);

                database.AddInParameter(dbCommand, "village", DbType.String, obj.village);
                database.AddInParameter(dbCommand, "district", DbType.String, obj.district);
                database.AddInParameter(dbCommand, "state", DbType.String, obj.state);
                database.AddInParameter(dbCommand, "@Comp_id", DbType.String, obj.Comp_id);
                database.AddInParameter(dbCommand, "country", DbType.String, obj.country);
                if (!string.IsNullOrEmpty(obj.AadhaarFile))
                {
                    database.AddInParameter(dbCommand, "aadharFile", DbType.String, obj.AadhaarFile);
                    database.AddInParameter(dbCommand, "uploadedby", DbType.String, "User");
                    database.AddInParameter(dbCommand, "uploadedsource", DbType.String, "website");
                }
                else
                    database.AddInParameter(dbCommand, "aadharFile", DbType.String, null);

                if (!string.IsNullOrEmpty(obj.Aadhaarback))
                    database.AddInParameter(dbCommand, "aadharFile_back", DbType.String, obj.Aadhaarback);
                else
                    database.AddInParameter(dbCommand, "aadharFile_back", DbType.String, null);

                database.AddInParameter(dbCommand, "@SellerName", DbType.String, obj.SellerName);
                database.AddInParameter(dbCommand, "@teslapayoutmode", DbType.String, obj.teslapayoutmode);
                database.ExecuteNonQuery(dbCommand);

            }
            catch (Exception Ex)
            {
                DataProvider.LogManager.WriteExe("Find Error in Procedure with " + Ex.Message.ToString());
            }
        }

        public static void InsertUpdatePublisherDetails(Publisher_Details obj)
        {
            try
            {
                //    if (obj.DML == "I")
                //        obj.User_ID = GetMyCodeGenID("Consumer");
                dbCommand = database.GetStoredProcCommand("Proc_InsertUpdatePub");
                database.AddInParameter(dbCommand, "MobileNo", DbType.String, obj.MobileNo);
                database.AddInParameter(dbCommand, "bookname", DbType.String, obj.Bookname);
                database.AddInParameter(dbCommand, "bookShop", DbType.String, obj.bookShop);
                database.AddInParameter(dbCommand, "ccenter", DbType.String, obj.ccenter);
                database.AddInParameter(dbCommand, "Code1", DbType.String, obj.Code1);
                database.AddInParameter(dbCommand, "Code2", DbType.String, obj.Code2);

                database.ExecuteNonQuery(dbCommand);
            }
            catch (Exception Ex)
            {
                DataProvider.LogManager.WriteExe("Find Error in Procedure with " + Ex.Message.ToString());
            }
        }

        public static string appInsertUpdateUserDetails(User_Details obj)
        {
            message_status msg = new message_status();
            try
            {
                //    if (obj.DML == "I")
                //        obj.User_ID = GetMyCodeGenID("Consumer");
                dbCommand = database.GetStoredProcCommand("PROC_InsUpdUserDetails");
                database.AddInParameter(dbCommand, "User_ID", DbType.String, obj.User_ID);
                database.AddInParameter(dbCommand, "ConsumerName", DbType.String, obj.ConsumerName);
                database.AddInParameter(dbCommand, "Email", DbType.String, obj.Email);
                database.AddInParameter(dbCommand, "MobileNo", DbType.String, obj.MobileNo);
                database.AddInParameter(dbCommand, "City", DbType.String, obj.City);
                database.AddInParameter(dbCommand, "PinCode", DbType.String, obj.PinCode);
                database.AddInParameter(dbCommand, "Password", DbType.String, obj.Password);
                database.AddInParameter(dbCommand, "IsActive", DbType.Int32, obj.IsActive);
                database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, obj.IsDelete);
                database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
                database.AddInParameter(dbCommand, "Address", DbType.String, obj.Address);
                database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, obj.Entry_Date);
                database.AddInParameter(dbCommand, "Code1", DbType.Int32, obj.code1);
                database.AddInParameter(dbCommand, "Code2", DbType.Int32, obj.code1);

                database.AddInParameter(dbCommand, "employeeID", DbType.String, obj.employeeID);
                database.AddInParameter(dbCommand, "distributorID", DbType.String, obj.distributorID);
                database.AddInParameter(dbCommand, "aadharNumber", DbType.String, obj.aadharNumber);
                database.AddInParameter(dbCommand, "village", DbType.String, obj.village);
                database.AddInParameter(dbCommand, "district", DbType.String, obj.district);
                database.AddInParameter(dbCommand, "state", DbType.String, obj.state);
                database.AddInParameter(dbCommand, "country", DbType.String, obj.country);



                if (!string.IsNullOrEmpty(obj.aadharFile))
                {
                    obj.aadharFile = obj.aadharFile.Replace("\"", "").Replace("\\", "");
                    database.AddInParameter(dbCommand, "aadharFile", DbType.String, obj.aadharFile);

                }
                else
                    database.AddInParameter(dbCommand, "aadharFile", DbType.String, null);
                if (string.IsNullOrEmpty(obj.aadharback))
                    obj.aadharback = "";
                if (obj.aadharback != "")
                {
                    obj.aadharback = obj.aadharback.Replace("\"", "").Replace("\\", "");
                    SQL_DB.ExecuteNonQuery("update m_consumer set aadharback='" + obj.aadharback + "' where MobileNo like '%" + obj.MobileNo + "'");

                }

                database.ExecuteNonQuery(dbCommand);
                msg.status = "Success";

                return JsonConvert.SerializeObject(msg);


            }
            catch (Exception Ex)
            {
                DataProvider.LogManager.WriteExe("Find Error in Procedure with " + Ex.Message.ToString());
                msg.status = "Unsuccess";

                return JsonConvert.SerializeObject(msg);
            }
        }
        private static string GetMyCodeGenID(string p)
        {
            DataTable dt = SQL_DB.ExecuteDataSet("SELECT id, Prfor, PrPrefix, PrStart, PrFlag FROM Code_Gen where Prfor = '" + p + "'").Tables[0];
            if (dt.Rows.Count > 0)
                return dt.Rows[0]["PrPrefix"].ToString() + string.Format("{0:0000}", Convert.ToInt64(dt.Rows[0]["PrStart"].ToString()));
            else
                return "";
        }
        private static void SetMyCodeGenID(string p)
        {
            DataTable dt = SQL_DB.ExecuteDataSet("SELECT id, Prfor, PrPrefix, PrStart, PrFlag FROM Code_Gen where Prfor = '" + p + "'").Tables[0];
            if (dt.Rows.Count > 0)
            {
                Int64 P = Convert.ToInt64(dt.Rows[0]["PrStart"].ToString());
                P++;
                SQL_DB.ExecuteNonQuery("UPDATE Code_Gen SET PrStart = " + P + " where id = " + Convert.ToInt32(dt.Rows[0]["id"]) + "");
            }
        }

        public static DataTable app_GetUserLoginDetails(User_Details obj)
        {
            DataTable ds = new DataTable();
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_appGetUserDetails");
                database.AddInParameter(dbCommand, "User_ID", DbType.String, obj.User_ID);
                ds = database.ExecuteDataSet(dbCommand).Tables[0];
                return ds;
            }
            catch (Exception)
            {
                return ds;
            }
        }
        //Added by Bipin for Ambika Reffral
        public static string web_LoginAbbikauser(string MobileNo, string password)
        {
            string result = string.Empty;
            DataTable ds = new DataTable();
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_LOGINAMBIKA");
                database.AddInParameter(dbCommand, "MobileNo", DbType.String, MobileNo);
                database.AddInParameter(dbCommand, "Password", DbType.String, password);
                ds = database.ExecuteDataSet(dbCommand).Tables[0];
                if (ds.Rows[0][0].ToString() == "Failure~Invalid User Details")
                {
                    result = ds.Rows[0][0].ToString();
                }
                else
                {

                    result = "Success~" + JsonConvert.SerializeObject(ds);
                }

            }
            catch (Exception)
            {
                result = JsonConvert.SerializeObject(ds);
            }
            return result;
        }
        public static string web_LoginregAbbikauser(string MobileNo)
        {
            string result = string.Empty;
            string password = string.Empty;
            DataTable ds = new DataTable();
            try
            {
                if (password == "" || password == null)
                    password = SQL_DB.ExecuteScalar("select password from M_consumer where mobileno='" + MobileNo + "'").ToString();

                dbCommand = database.GetStoredProcCommand("PROC_LOGINAMBIKA");
                database.AddInParameter(dbCommand, "MobileNo", DbType.String, MobileNo);
                database.AddInParameter(dbCommand, "Password", DbType.String, password);
                ds = database.ExecuteDataSet(dbCommand).Tables[0];
                if (ds.Rows[0][0].ToString() == "Failure~Invalid User Details")
                {
                    result = ds.Rows[0][0].ToString();
                }
                else
                {
                    result = "Success~" + JsonConvert.SerializeObject(ds);
                }

            }
            catch (Exception)
            {
                result = JsonConvert.SerializeObject(ds);
            }
            return result;
        }

        // End of  Ambika Reffral

        public static DataTable GetUserLoginDetails(User_Details obj)
        {
            DataTable ds = new DataTable();
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_GetUserDetails");
                database.AddInParameter(dbCommand, "User_ID", DbType.String, obj.User_ID);
                database.AddInParameter(dbCommand, "Password", DbType.String, obj.Password);
                database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
                ds = database.ExecuteDataSet(dbCommand).Tables[0];
                return ds;
            }
            catch (Exception)
            {
                return ds;
            }
        }
        public static void FillupTransaction(User_Details obj)
        {
            DataSet ds = new DataSet();
        }
        public static void FillUpDateProfile(User_Details obj)
        {
            DataSet ds = new DataSet();
            //string qSQL = "SELECT *, isnull(ME.mobilenumber,'NA') MM FROM M_Consumer MC Inner Join MMEMPLOYEE ME ON MC.M_Consumerid = ME.M_Consumerid WHERE MC.[User_ID] = '" + obj.User_ID + "'";
            DataTable ddt = SQL_DB.ExecuteDataSet("SELECT mc.*,MD.[DE_Designation] as Designantion  FROM M_Consumer mc left join M_DealerMaster MD on mc.employeeID=MD.[DealerTechnicianId] and mc.[distributorID]=MD.[DealerCode] WHERE MC.User_ID = '" + obj.User_ID + "'").Tables[0];
            //DataTable ddt = SQL_DB.ExecuteDataSet(qSQL).Tables[0];
            if (ddt.Rows.Count > 0)
            {
                try
                {
                    obj.User_ID = ddt.Rows[0]["User_ID"].ToString();
                    obj.ConsumerName = ddt.Rows[0]["ConsumerName"].ToString();
                    obj.Email = ddt.Rows[0]["Email"].ToString();
                    obj.MobileNo = ddt.Rows[0]["MobileNo"].ToString();
                    obj.City = ddt.Rows[0]["City"].ToString(); ;
                    obj.PinCode = ddt.Rows[0]["PinCode"].ToString();
                    obj.Address = ddt.Rows[0]["Address"].ToString();
                    obj.Password = ddt.Rows[0]["Password"].ToString();
                    obj.User_Type = "Consumer";
                    obj.Consumer_ID = ddt.Rows[0]["M_consumerid"].ToString();
                    //obj.MMUser = ddt.Rows[0]["MM"].ToString();

                    if (!string.IsNullOrEmpty(ddt.Rows[0]["employeeID"].ToString()))
                        obj.MMEmployeID = ddt.Rows[0]["employeeID"].ToString();
                    if (!string.IsNullOrEmpty(ddt.Rows[0]["distributorID"].ToString()))
                        obj.MMDistributorID = ddt.Rows[0]["distributorID"].ToString();
                    if (!string.IsNullOrEmpty(ddt.Rows[0]["aadharNumber"].ToString()))
                        obj.AadhaarNumber = ddt.Rows[0]["aadharNumber"].ToString();
                    if (!string.IsNullOrEmpty(ddt.Rows[0]["aadharFile"].ToString()))
                        obj.AadhaarFile = ddt.Rows[0]["aadharFile"].ToString();
                    if (!string.IsNullOrEmpty(ddt.Rows[0]["Designantion"].ToString()))
                        obj.Designation = ddt.Rows[0]["Designantion"].ToString();
                    if (!string.IsNullOrEmpty(ddt.Rows[0]["aadharback"].ToString()))
                        obj.Aadhaarback = ddt.Rows[0]["aadharback"].ToString();
                    DataTable img = SQL_DB.ExecuteDataTable("select [Profile_img] from [Profile_images] where [M_consumerid]=" + obj.Consumer_ID);
                    if (img.Rows.Count > 0)
                    {
                        obj.Profile_image = img.Rows[0][0].ToString();
                    }
                    //D:\PLESKVHOST\vhosts\vcqru.com\httpdocs\img\aadharFile\1152_AB95_1152AB95-631_0_fee96579-b06d-4915-9ec4-d21845a03d89.pdf
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            else
            {
                string qSQL1 = "SELECT * FROM M_Consumer WHERE [User_ID] = '" + obj.User_ID + "'";
                //DataTable ddt = SQL_DB.ExecuteDataSet("SELECT * FROM M_Consumer WHERE User_ID = '" + obj.User_ID + "'").Tables[0];
                DataTable ddt1 = SQL_DB.ExecuteDataSet(qSQL1).Tables[0];
                if (ddt1.Rows.Count > 0)
                {
                    obj.User_ID = ddt1.Rows[0]["User_ID"].ToString();
                    obj.ConsumerName = ddt1.Rows[0]["ConsumerName"].ToString();
                    obj.Email = ddt1.Rows[0]["Email"].ToString();
                    obj.MobileNo = ddt1.Rows[0]["MobileNo"].ToString();
                    obj.City = ddt1.Rows[0]["City"].ToString(); ;
                    obj.PinCode = ddt1.Rows[0]["PinCode"].ToString();
                    obj.Address = ddt1.Rows[0]["Address"].ToString();
                    obj.Password = ddt1.Rows[0]["Password"].ToString();
                    obj.User_Type = "Consumer";

                    if (!string.IsNullOrEmpty(ddt1.Rows[0]["employeeID"].ToString()))
                        obj.MMEmployeID = ddt1.Rows[0]["employeeID"].ToString();
                    if (!string.IsNullOrEmpty(ddt1.Rows[0]["distributorID"].ToString()))
                        obj.MMDistributorID = ddt1.Rows[0]["distributorID"].ToString();
                    if (!string.IsNullOrEmpty(ddt.Rows[0]["aadharNumber"].ToString()))
                        obj.AadhaarNumber = ddt.Rows[0]["aadharNumber"].ToString();
                    if (!string.IsNullOrEmpty(ddt.Rows[0]["aadharFile"].ToString()))
                        obj.AadhaarFile = ddt.Rows[0]["aadharFile"].ToString();
                }
            }
        }

        public static bool CheckOldPassConsumer(User_Details obj)
        {
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_GetUserDetails");
                database.AddInParameter(dbCommand, "User_ID", DbType.String, obj.User_ID);
                database.AddInParameter(dbCommand, "Password", DbType.String, obj.OldPassword);
                database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
                DataTable ds = database.ExecuteDataSet(dbCommand).Tables[0];
                if (ds.Rows.Count > 0)
                {
                    obj.MobileNo = ds.Rows[0]["MobileNo"].ToString();
                    return true;
                }
                else
                    return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static void ChangePassConsumer(User_Details obj)
        {
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_ChangeUserDetailsPwd");
                database.AddInParameter(dbCommand, "User_ID", DbType.String, obj.User_ID);
                database.AddInParameter(dbCommand, "MobileNo", DbType.String, obj.MobileNo);
                database.AddInParameter(dbCommand, "Password", DbType.String, obj.Password);
                database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, obj.Entry_Date);
                database.ExecuteNonQuery(dbCommand);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet FillGrdLoyaltyAwards(Loyalty_Awards obj)
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [RowId],[Comp_ID],(SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID = M_LoyaltyAwards.Comp_ID) AS CompName,[AwardName],CONVERT(VARCHAR,[Points]) AS Points,[IsActive],[IsDelete],[Entry_Date],CASE WHEN IsActive = 0 THEN 'Click for De-Activate' else 'Click for Activate' end as IsActiveMsg " +
                " ,CASE WHEN IsDelete = 1 THEN 'Click for Un-Delete' else 'Click for Delete' end as IsDeleteMsg " +
                " FROM [M_LoyaltyAwards] WHERE  [AwardName] LIKE '%" + obj.AwardName + "%' AND [IsActive] = 0 AND [IsDelete] = 0 " + obj.Msg);
                //dbCommand = database.GetStoredProcCommand("PROC_GridDataLoyaltyAwardsList");
                //database.AddInParameter(dbCommand, "Msg", DbType.String, obj.Msg);
                //database.AddInParameter(dbCommand, "AwardName", DbType.String, obj.AwardName);
                //ds = database.ExecuteDataSet(dbCommand);
                return ds;
            }
            catch (Exception)
            {
                return ds;
            }
        }

        public static DataSet FillGrdpointsDetails(Loyalty_Points obj)
        {
            string Qry = "";
            if (obj.User_ID != "")
                Qry = " [User_ID] = '" + obj.User_ID + "' ";
            else
                Qry = " ('' = '" + obj.User_ID + "' OR [User_ID] = '" + obj.User_ID + "') ";
            DataSet ds = new DataSet();
            try
            {
                ds = SQL_DB.ExecuteDataSet("SELECT ROW_NUMBER() OVER(ORDER BY Comp_ID DESC) as SrNo, [RowId] ,[Comp_ID],(SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID = [T_Points].Comp_ID) AS CompName ,[Pro_ID] ,(SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = [T_Points].Pro_ID) AS ProductName " +
               " ,[User_ID],[Code1],[Code2],[Points],[Type],[Entry_Date],[Mode],[IsCashConvert] FROM [T_Points] WHERE  " + Qry + obj.Msg + " ORDER BY [Entry_Date] DESC");
                //dbCommand = database.GetStoredProcCommand("PROC_GridDataLoyaltyAwardsList");
                //database.AddInParameter(dbCommand, "Msg", DbType.String, obj.Msg);
                //database.AddInParameter(dbCommand, "AwardName", DbType.String, obj.AwardName);
                //ds = database.ExecuteDataSet(dbCommand);
                return ds;
            }
            catch (Exception)
            {
                return ds;
            }
        }
        public static DataSet FillGrdForPoints(Loyalty_Points obj)
        {
            //string Qry = "";
            //if (obj.User_ID != "")
            //    Qry = " [User_ID] = '" + obj.User_ID + "' ";
            //else
            //    Qry = " ('' = '" + obj.User_ID + "' OR [User_ID] = '" + obj.User_ID + "') ";
            DataSet ds = new DataSet();
            try
            {
                // ds = SQL_DB.ExecuteDataSet("SELECT ROW_NUMBER() OVER(ORDER BY Comp_ID DESC) as SrNo, [RowId] ,[Comp_ID],(SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID = [T_Points].Comp_ID) AS CompName ,[Pro_ID] ,(SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = [T_Points].Pro_ID) AS ProductName " +
                //" ,[User_ID],[Code1],[Code2],[Points],[Type],[Entry_Date],[Mode],[IsCashConvert] FROM [T_Points] WHERE  " + Qry + obj.Msg + " ORDER BY [Entry_Date] DESC");
                //dbCommand = database.GetStoredProcCommand("GetWalletList");
                //database.AddInParameter(dbCommand, "@SSt_id", DbType.Int32, obj.sst_id);
                //database.AddInParameter(dbCommand, "AwardName", DbType.int, obj.@M_Consumerid);
                //ds = database.ExecuteDataSet(dbCommand);
                return ds;
            }
            catch (Exception Ex)
            {
                throw Ex;
            }
        }
        public static DataTable FillLoyaltyAwardsGridObject(Award_Transactions obj)
        {
            DataTable ds = new DataTable();
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_GridDataLoyaltyAwardsDet");
                database.AddInParameter(dbCommand, "RowId", DbType.String, obj.RowId);
                ds = database.ExecuteDataSet(dbCommand).Tables[0];
                if (ds.Rows.Count > 0)
                {
                    obj.AwardName = ds.Rows[0]["AwardName"].ToString();
                    obj.Points = Convert.ToDecimal(ds.Rows[0]["Points"]);
                    obj.IsDelete = Convert.ToInt32(ds.Rows[0]["IsDelete"]);
                    obj.IsActive = Convert.ToInt32(ds.Rows[0]["IsActive"]);
                    obj.Comp_ID = ds.Rows[0]["Comp_ID"].ToString();
                    obj.RowId = Convert.ToInt64(ds.Rows[0]["RowId"]);
                }
                return ds;
            }
            catch (Exception x)
            {
                return ds;
            }
        }

        public static void InsertDistributedAwards(Award_Transactions obj)
        {
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_InsUpdDistributedAwardsDet");
                database.AddInParameter(dbCommand, "RowId", DbType.Int64, obj.RowId);
                database.AddInParameter(dbCommand, "User_ID", DbType.String, obj.User_ID);
                database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
                database.AddInParameter(dbCommand, "Dealer_ID", DbType.String, obj.Dealer_ID);
                database.AddInParameter(dbCommand, "TransactionNo", DbType.String, obj.TransactionNo);
                database.AddInParameter(dbCommand, "Delivery_Type", DbType.String, obj.Delivery_Type);
                database.AddInParameter(dbCommand, "IsDelivered", DbType.Int32, obj.IsDelivered);
                database.AddInParameter(dbCommand, "Remarks", DbType.String, obj.Remarks);
                database.AddInParameter(dbCommand, "Cash_Amount", DbType.Int64, obj.Cash_Amount);
                database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
                database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, obj.Entry_Date);
                database.AddInParameter(dbCommand, "Award_Key", DbType.String, obj.Award_Key);
                database.ExecuteNonQuery(dbCommand);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataSet FillMyAwards(Loyalty_Dispatch obj)
        {
            DataSet ds = new DataSet();
            try
            {
                dbCommand = database.GetSqlStringCommand("SELECT [RowId],[User_ID],[Comp_ID],[Dealer_ID],[TransactionNo],[Delivery_Type],[IsDelivered],[Remarks],[Cash_Amount],[Entry_Date],[Award_Key],[IsDispatch] ,(SELECT AwardName FROM M_LoyaltyAwards WHERE [Points]=T_DistributedAwardDetails.Cash_Amount) + ' [' + (SELECT ConsumerName FROM  M_Consumer WHERE [User_ID]=T_DistributedAwardDetails.[User_ID]) +']' AS AwardName FROM [T_DistributedAwardDetails] WHERE [Comp_ID] = '" + obj.Comp_ID + "' AND [Delivery_Type] = 'Courier' AND  [TransactionNo] = '" + obj.Tracking_No + "' ");
                //dbCommand = database.GetStoredProcCommand("PROC_GridDataLoyaltyAwardsDet");
                //database.AddInParameter(dbCommand, "RowId", DbType.String, obj.RowId);
                ds = database.ExecuteDataSet(dbCommand);
                //if (ds.Rows.Count > 0)
                //{
                //    obj.AwardName = ds.Rows[0]["AwardName"].ToString();
                //    obj.Points = Convert.ToDecimal(ds.Rows[0]["Points"]);
                //    obj.IsDelete = Convert.ToInt32(ds.Rows[0]["IsDelete"]);
                //    obj.IsActive = Convert.ToInt32(ds.Rows[0]["IsActive"]);
                //    obj.Comp_ID = ds.Rows[0]["Comp_ID"].ToString();
                //    obj.RowId = Convert.ToInt64(ds.Rows[0]["RowId"]);
                //}
                return ds;
            }
            catch (Exception)
            {
                return ds;
            }
        }
        public static DataSet FillMyAwards(Loyalty_Awards obj)
        {
            DataSet ds = new DataSet();
            try
            {
                dbCommand = database.GetSqlStringCommand("SELECT [RowId],[User_ID],[Comp_ID],[Dealer_ID],[TransactionNo],[Delivery_Type],[IsDelivered],[Remarks],[Cash_Amount],[Entry_Date],[Award_Key],[IsDispatch] ,(SELECT AwardName FROM M_LoyaltyAwards WHERE [Points]=T_DistributedAwardDetails.Cash_Amount AND Comp_ID = T_DistributedAwardDetails.Comp_ID) + ' [' + (SELECT ISNULL(ConsumerName,MobileNo) FROM  M_Consumer WHERE [User_ID]=T_DistributedAwardDetails.[User_ID]) +']' AS AwardName FROM [T_DistributedAwardDetails] WHERE [Comp_ID] = '" + obj.Comp_ID + "' AND [Delivery_Type] = 'Courier' AND ISNULL([IsDelivered],0) = 0 AND ISNULL([IsDispatch],0) = 0 ");
                //dbCommand = database.GetStoredProcCommand("PROC_GridDataLoyaltyAwardsDet");
                //database.AddInParameter(dbCommand, "RowId", DbType.String, obj.RowId);
                ds = database.ExecuteDataSet(dbCommand);
                //if (ds.Rows.Count > 0)
                //{
                //    obj.AwardName = ds.Rows[0]["AwardName"].ToString();
                //    obj.Points = Convert.ToDecimal(ds.Rows[0]["Points"]);
                //    obj.IsDelete = Convert.ToInt32(ds.Rows[0]["IsDelete"]);
                //    obj.IsActive = Convert.ToInt32(ds.Rows[0]["IsActive"]);
                //    obj.Comp_ID = ds.Rows[0]["Comp_ID"].ToString();
                //    obj.RowId = Convert.ToInt64(ds.Rows[0]["RowId"]);
                //}
                return ds;
            }
            catch (Exception)
            {
                return ds;
            }
        }
        public static DataSet FillManufRedeemAwards(Loyalty_Awards obj)
        {
            DataSet ds = new DataSet();
            try
            {
                if (obj.RewardKey > 1)
                    obj.Msg = " AND t.Award_Key = '" + obj.RewardKey + "'";
                else
                    obj.Msg = "";
                if (obj.DML != "SE")
                {
                    if (obj.DML == "PE")
                        obj.Msg += " AND t.IsDispatch = 0 ";
                    else if (obj.DML == "DI")
                        obj.Msg += " AND t.IsDispatch = 1 ";
                    else if (obj.DML == "DE")
                        obj.Msg += " AND t.IsDelivered = 1 ";
                    else if (obj.DML == "WA")
                        obj.Msg += " AND t.Delivery_Type = 'Cash' ";
                }
                dbCommand = database.GetSqlStringCommand("SELECT * FROM (SELECT (SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID = t.Comp_ID) as Comp_Name,ISNULL((SELECT AwardName FROM M_LoyaltyAwards WHERE Points = t.Cash_Amount AND Comp_ID = t.Comp_ID AND t.Delivery_Type <> 'Cash'),'Rs.' + CONVERT(VARCHAR,CONVERT(NUMERIC(18,2),(t.Cash_Amount / (SELECT Points FROM M_LoyaltySettings WHERE Comp_ID = t.Comp_ID))))) as AwardName,t.RowId, t.User_ID, t.Comp_ID, ISNULL(t.Dealer_ID,'-- --') as Dealer_ID, ISNULL(t.TransactionNo, '-- --') AS TransactionNo, t.Delivery_Type, t.IsDelivered, t.Remarks, t.Cash_Amount, t.Entry_Date, t.Award_Key, t.IsDispatch  FROM T_DistributedAwardDetails AS t WHERE ('' = '" + obj.Comp_ID + "' OR t.Comp_ID = '" + obj.Comp_ID + "') " + obj.Msg + ") REG WHERE (REG.Comp_Name LIKE '%" + obj.CompName + "%') AND (REG.AwardName LIKE '%" + obj.AwardName + "%') ORDER BY REG.Entry_Date DESC ");
                ds = database.ExecuteDataSet(dbCommand);
                return ds;
            }
            catch (Exception)
            {
                return ds;
            }
        }
        public static DataSet FillMyWinAwards(Loyalty_Awards obj)
        {
            DataSet ds = new DataSet();
            try
            {
                if (obj.RewardKey > 1)
                    obj.Msg = " AND t.Award_Key = '" + obj.RewardKey + "'";
                else
                    obj.Msg = "";
                if (obj.DML != "SE")
                {
                    if (obj.DML == "PE")
                        obj.Msg += " AND t.IsDispatch = 0 ";
                    else if (obj.DML == "DI")
                        obj.Msg += " AND t.IsDispatch = 1 ";
                    else if (obj.DML == "DE")
                        obj.Msg += " AND t.IsDelivered = 1 ";
                    else if (obj.DML == "WA")
                        obj.Msg += " AND t.Delivery_Type = 'Cash' ";
                }
                dbCommand = database.GetSqlStringCommand("SELECT * FROM (SELECT (SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID = t.Comp_ID) as Comp_Name,ISNULL((SELECT AwardName FROM M_LoyaltyAwards WHERE Points = t.Cash_Amount AND Comp_ID = t.Comp_ID AND t.Delivery_Type <> 'Cash'),'Rs.' + CONVERT(VARCHAR,CONVERT(NUMERIC(18,2),(t.Cash_Amount / (SELECT Points FROM M_LoyaltySettings WHERE Comp_ID = t.Comp_ID))))) as AwardName,t.RowId, t.User_ID, t.Comp_ID, ISNULL(t.Dealer_ID,'-- --') as Dealer_ID, ISNULL(t.TransactionNo, '-- --') AS TransactionNo, t.Delivery_Type, t.IsDelivered, t.Remarks, t.Cash_Amount, t.Entry_Date, t.Award_Key, t.IsDispatch  FROM T_DistributedAwardDetails AS t WHERE (t.User_ID = '" + obj.User_ID + "') " + obj.Msg + ") REG WHERE (REG.Comp_Name LIKE '%" + obj.CompName + "%') AND (REG.AwardName LIKE '%" + obj.AwardName + "%') ORDER BY REG.Entry_Date DESC ");
                //dbCommand = database.GetSqlStringCommand("SELECT r.Comp_Name, ma.AwardName, t.RowId, t.User_ID, t.Comp_ID, t.Dealer_ID, ISNULL(t.TransactionNo,'-- --') AS TransactionNo, t.Delivery_Type, t.IsDelivered, t.Remarks, t.Cash_Amount, t.Entry_Date, t.Award_Key, t.IsDispatch FROM Awards_Dispatch_Master AS m INNER JOIN Comp_Reg AS r ON m.Comp_ID = r.Comp_ID INNER JOIN T_DistributedAwardDetails AS t ON m.Tracking_No = t.TransactionNo INNER JOIN  M_LoyaltyAwards AS ma ON t.Cash_Amount = ma.Points  WHERE r.Comp_Name LIKE '%" + obj.CompName + "%' AND ma.AwardName LIKE '%" + obj.AwardName + "%' AND t.User_ID = '" + obj.User_ID + "' ");//WHERE [Comp_ID] = '" + obj.Comp_ID + "' AND [Delivery_Type] = 'Courier' AND [IsDelivered] = 0 AND [IsDispatch] = 0
                //dbCommand = database.GetStoredProcCommand("PROC_GridDataLoyaltyAwardsDet");
                //database.AddInParameter(dbCommand, "RowId", DbType.String, obj.RowId);
                ds = database.ExecuteDataSet(dbCommand);
                //if (ds.Rows.Count > 0)
                //{
                //    obj.AwardName = ds.Rows[0]["AwardName"].ToString();
                //    obj.Points = Convert.ToDecimal(ds.Rows[0]["Points"]);
                //    obj.IsDelete = Convert.ToInt32(ds.Rows[0]["IsDelete"]);
                //    obj.IsActive = Convert.ToInt32(ds.Rows[0]["IsActive"]);
                //    obj.Comp_ID = ds.Rows[0]["Comp_ID"].ToString();
                //    obj.RowId = Convert.ToInt64(ds.Rows[0]["RowId"]);
                //}
                return ds;
            }
            catch (Exception)
            {
                return ds;
            }
        }
        public static DataSet FillGrdWinAwards(Loyalty_Awards obj)
        {
            DataSet ds = new DataSet();
            try
            {
                dbCommand = database.GetSqlStringCommand("SELECT     m.RowId, m.Courier_ID, m.Comp_ID, m.Tracking_No, m.Dispatch_Date, m.Expected_Date, m.Dispatch_Location, m.Courier_Status, m.Entry_Date, m.Received_Date,  m.Received_Flag, m.Admin_Reason, m.Consumer_Reason, r.Comp_Name, ma.AwardName FROM  Awards_Dispatch_Master AS m INNER JOIN  Comp_Reg AS r ON m.Comp_ID = r.Comp_ID INNER JOIN T_DistributedAwardDetails AS t ON m.Tracking_No = t.TransactionNo INNER JOIN  M_LoyaltyAwards AS ma ON t.Cash_Amount = ma.Points ");
                //dbCommand = database.GetStoredProcCommand("PROC_GridDataLoyaltyAwardsDet");
                //database.AddInParameter(dbCommand, "RowId", DbType.String, obj.RowId);
                ds = database.ExecuteDataSet(dbCommand);
                //if (ds.Rows.Count > 0)
                //{
                //    obj.AwardName = ds.Rows[0]["AwardName"].ToString();
                //    obj.Points = Convert.ToDecimal(ds.Rows[0]["Points"]);
                //    obj.IsDelete = Convert.ToInt32(ds.Rows[0]["IsDelete"]);
                //    obj.IsActive = Convert.ToInt32(ds.Rows[0]["IsActive"]);
                //    obj.Comp_ID = ds.Rows[0]["Comp_ID"].ToString();
                //    obj.RowId = Convert.ToInt64(ds.Rows[0]["RowId"]);
                //}
                return ds;
            }
            catch (Exception)
            {
                return ds;
            }
        }
        public static DataSet FillGrdMainDispatchData(Loyalty_Awards obj)
        {
            DataSet ds = new DataSet();
            try
            {

                dbCommand = database.GetSqlStringCommand("SELECT  m.RowId, m.Courier_ID,(SELECT Courier_Name FROM Courier_Master WHERE m.Courier_ID = Courier_ID) AS Courier_Name, m.Comp_ID, m.Tracking_No, m.Dispatch_Date, m.Expected_Date, m.Dispatch_Location, m.Courier_Status, m.Entry_Date, m.Received_Date,  m.Received_Flag, m.Admin_Reason, m.Consumer_Reason, r.Comp_Name, ma.AwardName,t.Delivery_Type FROM  Awards_Dispatch_Master AS m INNER JOIN Comp_Reg AS r ON m.Comp_ID = r.Comp_ID INNER JOIN T_DistributedAwardDetails AS t ON m.Tracking_No = t.TransactionNo INNER JOIN M_LoyaltyAwards AS ma ON t.Cash_Amount = ma.Points AND m.Comp_ID = ma.Comp_ID WHERE m.Comp_ID = '" + obj.Comp_ID + "' AND r.Comp_Name LIKE '%" + obj.CompName + "%' AND ma.AwardName LIKE '%" + obj.AwardName + "%' ");
                //dbCommand = database.GetStoredProcCommand("PROC_GridDataLoyaltyAwardsDet");
                //database.AddInParameter(dbCommand, "RowId", DbType.String, obj.RowId);
                ds = database.ExecuteDataSet(dbCommand);
                //if (ds.Rows.Count > 0)
                //{
                //    obj.AwardName = ds.Rows[0]["AwardName"].ToString();
                //    obj.Points = Convert.ToDecimal(ds.Rows[0]["Points"]);
                //    obj.IsDelete = Convert.ToInt32(ds.Rows[0]["IsDelete"]);
                //    obj.IsActive = Convert.ToInt32(ds.Rows[0]["IsActive"]);
                //    obj.Comp_ID = ds.Rows[0]["Comp_ID"].ToString();
                //    obj.RowId = Convert.ToInt64(ds.Rows[0]["RowId"]);
                //}
                return ds;
            }
            catch (Exception)
            {
                return ds;
            }
        }

        public static void InsertUpdateDispatchDetails(Loyalty_Dispatch obj)
        {
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_InsUpdDispatchAwardsDet");
                database.AddInParameter(dbCommand, "RowId", DbType.Int64, obj.RowId);
                database.AddInParameter(dbCommand, "Courier_ID", DbType.String, obj.Courier_ID);
                database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
                database.AddInParameter(dbCommand, "Tracking_No", DbType.String, obj.Tracking_No);
                database.AddInParameter(dbCommand, "Dispatch_Date", DbType.DateTime, obj.Dispatch_Date);
                database.AddInParameter(dbCommand, "Expected_Date", DbType.DateTime, obj.Expected_Date);
                database.AddInParameter(dbCommand, "Dispatch_Location", DbType.String, obj.Dispatch_Location);
                database.AddInParameter(dbCommand, "Courier_Status", DbType.Int32, obj.Courier_Status);
                database.AddInParameter(dbCommand, "Received_Date", DbType.DateTime, obj.Expected_Date);
                database.AddInParameter(dbCommand, "Received_Flag", DbType.Int32, obj.Received_Flag);
                database.AddInParameter(dbCommand, "Admin_Reason", DbType.String, obj.Admin_Reason);
                database.AddInParameter(dbCommand, "Consumer_Reason", DbType.String, obj.Consumer_Reason);
                database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
                database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, obj.Entry_Date);
                database.ExecuteNonQuery(dbCommand);
                if (obj.DML == "I")
                {
                    dbCommand = database.GetSqlStringCommand("UPDATE T_DistributedAwardDetails SET IsDispatch = 1,TransactionNo ='" + obj.Tracking_No + "' WHERE RowId = " + obj.RefRowId + " ");
                    database.ExecuteNonQuery(dbCommand);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataSet FillGridDealer(Business_Logic_Layer.Loyalty_Dealer Reg)
        {
            Reg.DML = (Reg.Row_ID == 0 ? "" : Reg.Row_ID.ToString());
            dbCommand = database.GetSqlStringCommand("SELECT [Row_Id],[Dealer_ID],[Contact_Person],[Dealer_Name],[Mobile_No],[Email],[Address],[City],[IsActive] AS [Status],[City],[Entry_Date],[Password],[Comp_ID],(CASE WHEN IsActive = 1 then 'Click for Activated' else 'Click for De-Activate' end) AS TooTipMsg,(CASE WHEN IsActive = 1 then 'Activated' else 'De-Activated' end) AS [Status] FROM [M_Dealer] WHERE [Comp_ID] = '" + Reg.Comp_ID + "' AND Dealer_Name LIKE '%" + Reg.Dealer_Name + "%' AND (''= '" + Reg.DML + "' or Row_ID = '" + Reg.DML + "')");
            return database.ExecuteDataSet(dbCommand);
        }
        public static void SaveDealer(Business_Logic_Layer.Loyalty_Dealer Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_SaveDealer");
            database.AddInParameter(dbCommand, "Row_ID", DbType.Int64, Reg.Row_ID);
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "Dealer_ID", DbType.String, Reg.Dealer_ID);
            database.AddInParameter(dbCommand, "Dealer_Name", DbType.String, Reg.Dealer_Name);
            database.AddInParameter(dbCommand, "Contact_Person", DbType.String, Reg.Contact_Person);
            database.AddInParameter(dbCommand, "Email", DbType.String, Reg.Email);
            database.AddInParameter(dbCommand, "Address", DbType.String, Reg.Address);
            database.AddInParameter(dbCommand, "City", DbType.String, Reg.City);
            database.AddInParameter(dbCommand, "Mobile_No", DbType.String, Reg.Mobile_No);
            database.AddInParameter(dbCommand, "Password", DbType.String, Reg.Password);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, Reg.Entry_Date.ToString("yyyy/MM/dd hh:mm:ss tt"));
            database.AddInParameter(dbCommand, "IsActive", DbType.Int32, Reg.IsActive);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
        }

        public static DataSet FetchSearchData(Loyalty_Programm obj)
        {
            string Qry = "SELECT     m.RowId, m.Comp_ID, m.Pro_ID, m.Points,ISNULL(m.Frequency,0) AS Frequency, CASE WHEN m.IsCashConvert = 0 THEN 'Yes' ELSE 'No' END AS IsCashConvert, m.DateFrom, m.DateTo, m.IsActive, m.IsDelete, m.Entry_Date, m.Update_Flag_H, m.Update_Flag_E, " +
            " 'L' as Comp_type,'Sound/' + SUBSTRING(m.Comp_ID, 6, 4) + '/' + m.Pro_ID + '/Loyalty/'+ CONVERT(VARCHAR,m.RowId) +'/' + CONVERT(VARCHAR,m.RowId) + '_H.wav' AS SoundPath,'Sound/' + SUBSTRING(m.Comp_ID, 6, 4) + '/' + m.Pro_ID + '/Loyalty/'+ CONVERT(VARCHAR,m.RowId) +'/' + CONVERT(VARCHAR,m.RowId) + '_E.wav' AS SoundPath1, m.Comments, p.Pro_Name FROM M_Loyalty AS m INNER JOIN Pro_Reg AS p ON m.Pro_ID = p.Pro_ID " +
            " WHERE ('' = '" + obj.Comp_ID + "' or m.Comp_ID = '" + obj.Comp_ID + "') AND (p.Pro_Name LIKE '%" + obj.Pro_Name + "%') " + obj.Pro_ID + " AND m.IsDelete = 0 ORDER BY  m.Entry_Date DESC";
            dbCommand = database.GetSqlStringCommand(Qry);
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillGrvWDataAdmin(Loyalty_Programm obj)
        {
            string Qry = "SELECT * ,REG.IsSound AS Sound,CASE WHEN REG.IsSound = 0 THEN '../Data/Sound/' + SUBSTRING(REG.Comp_ID, 6, 4) + '/' + REG.Pro_ID + '/Loyalty/'+ CONVERT(VARCHAR,REG.Row_Id) +'/' + CONVERT(VARCHAR,REG.Row_Id) + '_H.wav' ELSE '' END AS SoundPath,CASE WHEN REG.IsSound = 0 THEN '../Data/Sound/' + SUBSTRING(REG.Comp_ID, 6, 4) + '/' + REG.Pro_ID + '/Loyalty/'+ CONVERT(VARCHAR,REG.Row_Id) +'/' + CONVERT(VARCHAR,REG.Row_Id) + '_E.wav' ELSE '' END AS SoundPath1 FROM (SELECT [Row_Id],[Service_ID],(SELECT ServiceName FROM M_Service WHERE Service_ID = m.Service_ID) ServiceName,[Comp_ID],[Pro_ID],(SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = m.Pro_ID) Pro_Name,[Points],[Frequency],[IsCashConvert],[DateFrom],[DateTo],[Entry_Date],[Update_Flag_H],[Update_Flag_E],[Comments],[AdditionalGift],[MessageTemplete],[IsActive],[IsDelete],(SELECT IsSound FROM M_ServiceFeature WHERE Service_ID = m.Service_ID) IsSound  FROM [M_ServiceTransaction]  as m) REG WHERE ('' = '" + obj.Comp_ID + "' or REG.Comp_ID = '" + obj.Comp_ID + "') " + obj.Pro_ID + obj.Service_ID + " AND REG.IsDelete = 0 ORDER BY  REG.Entry_Date DESC";
            dbCommand = database.GetSqlStringCommand(Qry);
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillServiceSubscription(Loyalty_Programm obj)
        {
            string Qry1 = (obj.Qry == null ? "" : obj.Qry);
            //string Qry = "SELECT  t.Subscribe_Id, t.Service_ID, t.Comp_ID, t.Pro_ID, t.Plan_ID, t.PlanName, t.PlanMasterPeriod, t.PlanSalePeriod, t.PlanMasterPrice, t.PlanSalePrice, t.DateFrom, t.DateTo, t.EntryDate, t.IsActive, t.IsDelete, t.IsAdminVerify, m.ServiceName, p.Pro_Name FROM M_ServiceSubscription AS t INNER JOIN Pro_Reg AS p ON t.Pro_ID = p.Pro_ID INNER JOIN M_Service AS m ON t.Service_ID = m.Service_ID  WHERE ('' = '" + obj.Comp_ID + "' or t.Comp_ID = '" + obj.Comp_ID + "') " + obj.Pro_ID + obj.Service_ID + obj.Subscribe_Id + Qry1 + "  AND t.IsDelete = 0 ORDER BY t.EntryDate DESC";
            string Qry = "SELECT  t.Subscribe_Id, t.Service_ID, t.Comp_ID, t.Pro_ID, t.Plan_ID, t.PlanName, t.PlanMasterPeriod, t.PlanSalePeriod, t.PlanMasterPrice, t.PlanSalePrice, t.DateFrom, t.DateTo, t.EntryDate, t.IsActive, t.IsDelete, t.IsAdminVerify, case when t.start_order is null then m.ServiceName else concat(m.ServiceName,concat(t.start_order,'-',t.start_series,',',concat(t.end_order,'-',t.end_series))) end ServiceName, p.Pro_Name FROM M_ServiceSubscription AS t INNER JOIN Pro_Reg AS p ON t.Pro_ID = p.Pro_ID INNER JOIN M_Service AS m ON t.Service_ID = m.Service_ID  WHERE ('' = '" + obj.Comp_ID + "' or t.Comp_ID = '" + obj.Comp_ID + "') " + obj.Pro_ID + obj.Service_ID + obj.Subscribe_Id + Qry1 + "  AND t.IsDelete = 0 ORDER BY t.EntryDate DESC";
            dbCommand = database.GetSqlStringCommand(Qry);
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillGrVwDraw(Loyalty_Programm obj)
        {
            string Qry = "SELECT DISTINCT CASE WHEN (CONVERT(VARCHAR,GETDATE(),111) > CONVERT(VARCHAR,REG.dtto,111)) THEN 1 ELSE 0 END AS Draw,*  FROM (SELECT sst.SST_Id, sst.Subscribe_Id, " +
            " CONVERT(VARCHAR,sst.DateFrom,106) AS DateFrom, CONVERT(VARCHAR,sst.DateTo,106) AS DateTo,sst.DateTo as dtto, sst.Entry_Date,sst.Comments, sst.IsActive, sst.IsDelete, ms.ServiceName,  " +
            " ISNULL(sst.IsDraw,0) AS IsDraw,ISNULL(CONVERT(VARCHAR,sst.DrawDate,106),'-- --') AS DrawDate,p.Pro_Name, M_ServiceFeature.IsSound, ss.Comp_ID, ss.Pro_ID, st.ServiceType, st.WinningCodes " +
            " ,(SELECT COUNT(tg.Trans_Id) FROM T_GiftDistribution as tg WHERE tg.IsUsed = 0 AND tg.SST_Id = st.SST_Id) AS TParicipants   " +
            " FROM         M_ServiceFeature INNER JOIN M_Service AS ms ON M_ServiceFeature.Service_ID =  " +
            " ms.Service_ID INNER JOIN M_ServiceSubscription AS ss ON ms.Service_ID = ss.Service_ID INNER JOIN  M_ServiceSubscriptionTrans AS sst ON ss.Subscribe_Id = sst.Subscribe_Id  " +
            " INNER JOIN Pro_Reg AS p ON ss.Pro_ID = p.Pro_ID INNER JOIN M_ServiceRules AS st ON sst.SST_Id = st.SST_Id) REG " +
            " WHERE ('' = '" + obj.Comp_ID + "' or REG.Comp_ID = '" + obj.Comp_ID + "') " + obj.Pro_ID + obj.Service_ID + " AND  REG.IsDelete = 0 AND REG.ServiceType = 'DueDate' ORDER BY  REG.Entry_Date DESC";
            dbCommand = database.GetSqlStringCommand(Qry);
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillGrVwCashTransfer(Loyalty_Programm obj)
        {
            string Qry = "SELECT RowId, Comp_ID, Pro_ID,(SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = T_Cash.Pro_ID) AS Pro_Name, User_ID, MobileNo, Code1, Code2, IsCash, Entry_Date, Mode FROM T_Cash " +
            " WHERE ('' = '" + obj.Comp_ID + "' or Comp_ID = '" + obj.Comp_ID + "') AND ('' = '" + obj.Pro_ID + "' or Pro_ID = '" + obj.Pro_ID + "') ORDER BY  Entry_Date DESC";
            dbCommand = database.GetSqlStringCommand(Qry);
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillGrvWData(Loyalty_Programm obj)
        {
            string Qry = "SELECT DISTINCT * ,REG.IsSound AS Sound,CASE WHEN REG.IsSound = 0 THEN '../Data/Sound/' + SUBSTRING(REG.Comp_ID, 6, 4) + '/' + REG.Pro_ID + '/Loyalty/'+ CONVERT(VARCHAR,REG.SST_Id) +'/' + CONVERT(VARCHAR,REG.SST_Id) + '_H.wav' ELSE '' END AS SoundPath,CASE WHEN REG.IsSound = 0 THEN '../Data/Sound/' + SUBSTRING(REG.Comp_ID, 6, 4) + '/' + REG.Pro_ID + '/Loyalty/'+ CONVERT(VARCHAR,REG.SST_Id) +'/' + CONVERT(VARCHAR,REG.SST_Id) + '_E.wav' ELSE '' END AS SoundPath1 FROM (SELECT ss.Service_ID, sst.SST_Id, sst.Subscribe_Id, sst.Points, sst.Frequency, sst.IsCashConvert, sst.DateFrom, sst.DateTo, sst.Entry_Date, sst.Update_Flag_H, sst.Update_Flag_E, sst.Comments, sst.IsActive, sst.IsDelete, ms.ServiceName, p.Pro_Name, M_ServiceFeature.IsSound,ss.Comp_ID,ss.Pro_ID, case when ss.start_order is null then '' else concat(ss.start_order,'-',start_series,',',concat(ss.end_order,'-',end_series)) end servicerange FROM  M_ServiceFeature INNER JOIN M_Service AS ms ON M_ServiceFeature.Service_ID = ms.Service_ID INNER JOIN M_ServiceSubscription AS ss ON ms.Service_ID = ss.Service_ID INNER JOIN M_ServiceSubscriptionTrans AS sst ON ss.Subscribe_Id = sst.Subscribe_Id INNER JOIN Pro_Reg AS p ON ss.Pro_ID = p.Pro_ID) REG WHERE ('' = '" + obj.Comp_ID + "' or REG.Comp_ID = '" + obj.Comp_ID + "') " + obj.Pro_ID + obj.Service_ID + " AND REG.IsDelete = 0 ORDER BY  REG.Entry_Date DESC";
            dbCommand = database.GetSqlStringCommand(Qry);
            return database.ExecuteDataSet(dbCommand);
        }
        public static void UpdateFiles(Loyalty_Programm obj)
        {
            string Qry = "";
            if (obj.DMLs == "H")
                Qry = "UPDATE M_ServiceSubscriptionTrans SET Update_Flag_H = 0 WHERE SST_Id = " + obj.RowId + " ";
            else
                Qry = "UPDATE M_ServiceSubscriptionTrans SET Update_Flag_E = 0 WHERE SST_Id = " + obj.RowId + " ";
            dbCommand = database.GetSqlStringCommand(Qry);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void UpdateSoundFile(Loyalty_Programm obj)
        {
            string Qry = "";
            if (obj.DMLs == "H")
                Qry = "UPDATE M_Loyalty SET Update_Flag_H = 0 WHERE RowId = " + obj.RowId + " ";
            else
                Qry = "UPDATE M_Loyalty SET Update_Flag_E = 0 WHERE RowId = " + obj.RowId + " ";
            dbCommand = database.GetSqlStringCommand(Qry);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void SSTIsActiveDelete(Loyalty_Programm obj)
        {
            string Qry = "";
            if (obj.DMLs == "IsActive")
                Qry = "UPDATE M_ServiceSubscriptionTrans SET IsActive = " + obj.IsActive + " WHERE SST_Id = '" + obj.RowId + "' ";
            else if (obj.DMLs == "IsDelete")
                Qry = "UPDATE M_ServiceSubscriptionTrans SET IsDelete = " + obj.IsDelete + " WHERE SST_Id = '" + obj.RowId + "' ";
            dbCommand = database.GetSqlStringCommand(Qry);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void IsActiveDelete(Loyalty_Programm obj)
        {
            string Qry = "";
            if (obj.DMLs == "IsActive")
                Qry = "UPDATE M_ServiceSubscription SET IsActive = " + obj.IsActive + " WHERE Subscribe_Id = '" + obj.Subscribe_Id + "' ";
            else if (obj.DMLs == "IsDelete")
                Qry = "UPDATE M_ServiceSubscription SET IsDelete = " + obj.IsDelete + " WHERE Subscribe_Id = '" + obj.Subscribe_Id + "' ";
            dbCommand = database.GetSqlStringCommand(Qry);
            database.ExecuteNonQuery(dbCommand);
        }

        public static DataSet FillCompDropdownList(Loyalty_Points Reg)
        {
            dbCommand = database.GetStoredProcCommand("Proc_GetUseCompany");
            database.AddInParameter(dbCommand, "User_ID", DbType.String, Reg.User_ID);
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillProductDropdownList(Loyalty_Points Reg)
        {
            dbCommand = database.GetStoredProcCommand("Proc_GetUseProduct");
            database.AddInParameter(dbCommand, "User_ID", DbType.String, Reg.User_ID);
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet Proc_GetUseProductByConsumer(Loyalty_Points Reg)
        {
            dbCommand = database.GetStoredProcCommand("Proc_GetUseProductByConsumer");
            database.AddInParameter(dbCommand, "@M_Consumerid", DbType.String, Reg.M_Consumerid);
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            return database.ExecuteDataSet(dbCommand);
        }
        public static void InsertCashWallet(Award_Transactions op)
        {
            dbCommand = database.GetSqlStringCommand("INSERT INTO [T_CashWallet]([User_ID],[Comp_ID],[Award_Key],[Particulers],[Credit],[Debit],[Entry_Date]) VALUES  ('" + op.User_ID + "','" + op.Comp_ID + "','" + op.Award_Key + "','" + op.Particulers + "','" + op.Credit + "','" + op.Debit + "','" + Convert.ToDateTime(op.Entry_Date).ToString("yyyy/MM/dd hh:mm:ss tt") + "')");
            database.ExecuteNonQuery(dbCommand);
        }

        internal static DataSet FillMyCashWallet(Loyalty_Awards Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT RowId, User_ID, Comp_ID, Award_Key, Particulers, Credit, Debit, Entry_Date FROM T_CashWallet WHERE User_ID ='" + Reg.User_ID + "' ORDER BY Entry_Date DESC");
            return database.ExecuteDataSet(dbCommand);
        }

        public static void ActiveDeActiveDealer(Loyalty_Dealer Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [IsActive] FROM [M_Dealer] WHERE [Row_Id] = '" + Reg.Row_ID + "'");
            Reg.IsActive = Convert.ToInt32(database.ExecuteScalar(dbCommand));
            if (Reg.IsActive == 1)
                Reg.IsActive = 0;
            else
            {
                if (Reg.IsActive == 0)
                    Reg.IsActive = 1;
            }
            dbCommand = database.GetSqlStringCommand("UPDATE [M_Dealer]  SET [IsActive] = " + Reg.IsActive + " WHERE [Row_Id] = '" + Reg.Row_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }

        public static DataSet FillGrdMainDealerDispatch(Loyalty_Awards obj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT * FROM (SELECT RowId, User_ID, Comp_ID, (select Comp_Name from Comp_Reg where Comp_ID = T_DistributedAwardDetails.Comp_ID) as Comp_Name,(SELECT Dealer_Name FROM M_Dealer WHERE Dealer_ID = T_DistributedAwardDetails.Dealer_ID) AS Dealer_Name, Dealer_ID, TransactionNo, Delivery_Type, IsDelivered, Remarks, Cash_Amount, Entry_Date, Award_Key, IsDispatch,Received_Date ,SUBSTRING(RTRIM(LTRIM(Replace(Replace(Remarks,'Redeem awards name', ''),'your points for','-'))),0,CHARINDEX('-', RTRIM(LTRIM(Replace(Replace(Remarks,'Redeem awards name', ''),'your points for','-'))))) as AwardName FROM  T_DistributedAwardDetails ) m WHERE  m.Delivery_Type = 'Dealer' AND m.Comp_ID = '" + obj.Comp_ID + "' AND m.Comp_Name LIKE '%" + obj.CompName + "%' AND m.AwardName LIKE '%" + obj.AwardName + "%' ");
            return database.ExecuteDataSet(dbCommand);
        }
    }
    #endregion

    #region Services
    public static class MasterService
    {
        private static Database database = DatabaseFactory.CreateDatabase();
        private static DbCommand dbCommand;
        private static DataAdapter adp;
        private static DataSet ds;

        #region Function For Service Master
        public static void IUpdService(ObjService Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_IUpdServiceMaster");
            database.AddInParameter(dbCommand, "Service_ID", DbType.String, Reg.Service_ID);
            database.AddInParameter(dbCommand, "ServiceName", DbType.String, Reg.ServiceName);
            database.AddInParameter(dbCommand, "IsShowPrice", DbType.Int32, Reg.IsShowPrice);
            database.AddInParameter(dbCommand, "Image", DbType.String, Reg.Image);
            database.AddInParameter(dbCommand, "EntryDate", DbType.DateTime, Reg.EntryDate.ToString("yyyy/MM/dd hh:mm:ss tt"));
            database.AddInParameter(dbCommand, "IsActive", DbType.Int32, Reg.IsActive);
            database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, Reg.IsDelete);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.AddInParameter(dbCommand, "Act", DbType.String, Reg.Act);
            database.ExecuteNonQuery(dbCommand);
        }
        public static DataSet FillGridService(ObjService Reg)
        {
            Reg.DML = "F";
            dbCommand = database.GetStoredProcCommand("PROC_FillServiceDetails");
            database.AddInParameter(dbCommand, "ServiceName", DbType.String, Reg.ServiceName);
            database.AddInParameter(dbCommand, "Service_ID", DbType.String, Reg.Service_ID);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            return database.ExecuteDataSet(dbCommand);
        }
        public static void FillServiceInfo(ObjService Reg)
        {
            Reg.DML = "S";
            dbCommand = database.GetStoredProcCommand("PROC_FillServiceDetails");
            database.AddInParameter(dbCommand, "ServiceName", DbType.String, Reg.ServiceName);
            database.AddInParameter(dbCommand, "Service_ID", DbType.String, Reg.Service_ID);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            DataTable dt = database.ExecuteDataSet(dbCommand).Tables[0];
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Reg.Service_ID = dt.Rows[i]["Service_ID"].ToString();
                    Reg.ServiceName = dt.Rows[i]["ServiceName"].ToString();
                    Reg.IsShowPrice = Convert.ToInt32(dt.Rows[i]["IsShowPrice"].ToString());
                    Reg.Image = dt.Rows[i]["Image"].ToString();
                    Reg.IsActive = Convert.ToInt32(dt.Rows[i]["IsActive"].ToString());
                }
            }
        }
        #endregion

        #region Function For Service Price Master
        public static void IUpdServicePrice(ObjService Reg)
        {
            if (Reg.DML == "I")
                Reg.Plan_ID = Utility.GetMyGenID("Plan");
            dbCommand = database.GetStoredProcCommand("PROC_IUpdServicePriceMaster");
            database.AddInParameter(dbCommand, "Plan_ID", DbType.String, Reg.Plan_ID);
            database.AddInParameter(dbCommand, "Service_ID", DbType.String, Reg.Service_ID);
            database.AddInParameter(dbCommand, "PlanName", DbType.String, Reg.PlanName);
            database.AddInParameter(dbCommand, "PlanPeriod", DbType.Int64, Reg.PlanPeriod);
            database.AddInParameter(dbCommand, "PlanPrice", DbType.Int64, Reg.PlanPrice);
            database.AddInParameter(dbCommand, "EntryDate", DbType.DateTime, Reg.EntryDate.ToString("yyyy/MM/dd hh:mm:ss tt"));
            database.AddInParameter(dbCommand, "IsActive", DbType.Int32, Reg.IsActive);
            database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, Reg.IsDelete);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.AddInParameter(dbCommand, "Act", DbType.String, Reg.Act);
            //database.AddOutParameter(dbCommand, "ReturnTransID", DbType.String, 50);
            database.ExecuteNonQuery(dbCommand);
            if (Reg.DML == "I")
                Utility.SetMyGenID("Plan");
            InsertServicePriceTransaction(Reg);
            //if (Reg.Act == null)
            //{
            //    Reg.Trans_ID = Convert.ToInt64(database.GetParameterValue(dbCommand, "ReturnTransID"));
            //    InsertServicePriceTransaction(Reg);
            //}
        }
        public static DataSet FillServicePriceDetails(ObjService Reg)
        {
            Reg.DML = "F";
            dbCommand = database.GetStoredProcCommand("PROC_FillServicePriceDetails");
            database.AddInParameter(dbCommand, "Plan_ID", DbType.String, Reg.Plan_ID);
            database.AddInParameter(dbCommand, "Service_ID", DbType.String, Reg.Service_ID);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            return database.ExecuteDataSet(dbCommand);
        }
        public static void FillServicePriceInfo(ObjService Reg)
        {
            Reg.DML = "S";
            dbCommand = database.GetStoredProcCommand("PROC_FillServicePriceDetails");
            database.AddInParameter(dbCommand, "Plan_ID", DbType.String, Reg.Plan_ID);
            database.AddInParameter(dbCommand, "Service_ID", DbType.String, Reg.Service_ID);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            DataTable dt = database.ExecuteDataSet(dbCommand).Tables[0];
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Reg.Plan_ID = dt.Rows[i]["Plan_ID"].ToString();
                    Reg.Service_ID = dt.Rows[i]["Service_ID"].ToString();
                    Reg.PlanName = dt.Rows[i]["PlanName"].ToString();
                    Reg.PlanPeriod = Convert.ToInt64(dt.Rows[i]["PlanPeriod"].ToString());
                    if (Reg.PlanPeriod > 0)
                    {
                        Reg.Service_Year = Reg.PlanPeriod / 12;
                        Reg.Service_Months = Reg.PlanPeriod % 12;
                    }
                    Reg.PlanPrice = Convert.ToInt64(dt.Rows[i]["PlanPrice"].ToString());
                    Reg.IsActive = Convert.ToInt32(dt.Rows[i]["IsActive"].ToString());
                    Reg.ServiceName = dt.Rows[i]["ServiceName"].ToString();
                    Reg.Msg = dt.Rows[i]["TooTipMsg"].ToString();
                }
            }
        }
        public static DataSet FillServicePriceTransDetGrd(ObjService Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_FillServicePriceTransDetails");
            database.AddInParameter(dbCommand, "Plan_ID", DbType.String, Reg.Plan_ID);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.ServiceName = ds.Tables[0].Rows[0]["ServiceName"].ToString();
                Reg.PlanName = ds.Tables[0].Rows[0]["PlanName"].ToString();
                Reg.PlanPeriod = Convert.ToInt64(ds.Tables[0].Rows[0]["PlanPeriod"].ToString());
                if (Reg.PlanPeriod > 0)
                {
                    Reg.Service_Year = Reg.PlanPeriod / 12;
                    Reg.Service_Months = Reg.PlanPeriod % 12;
                }
            }
            return ds;
        }
        public static DataSet FillServiceddl()
        {
            dbCommand = database.GetSqlStringCommand("SELECT Service_ID, ServiceName, IsShowPrice, EntryDate, Image, IsActive, IsDelete FROM M_Service WHERE IsActive = 0 AND IsDelete = 0 ");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillServiceddl(ObjService Reg)
        {
            string Qry = "";
            if (Reg.EditServiceID != null)
                Qry = " AND Service_ID <> '" + Reg.EditServiceID + "' ";
            dbCommand = database.GetSqlStringCommand("SELECT Service_ID, ServiceName, IsShowPrice, EntryDate, Image, IsActive, IsDelete FROM M_Service WHERE IsActive = 0 AND IsDelete = 0 AND Service_ID NOT IN (SELECT Service_ID FROM M_ServiceFeature WHERE IsDelete = 0 " + Qry + " )");
            return database.ExecuteDataSet(dbCommand);
        }
        public static void InsertServicePriceTransaction(ObjService Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_InsertServicePriceTrans");
            database.AddInParameter(dbCommand, "Plan_ID", DbType.String, Reg.Plan_ID);
            database.AddInParameter(dbCommand, "PlanPrice", DbType.Int64, Reg.PlanPrice);
            database.AddInParameter(dbCommand, "EntryDate", DbType.DateTime, Reg.EntryDate.ToString("yyyy/MM/dd hh:mm:ss tt"));
            database.ExecuteNonQuery(dbCommand);
        }
        #endregion

        #region Function For Service Feature Master
        public static void IUpdServiceFeature(ObjService Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_IUpdServiceFeatureMaster");
            database.AddInParameter(dbCommand, "ServiceFeaure_ID", DbType.Int64, Reg.ServiceFeaure_ID);
            database.AddInParameter(dbCommand, "Service_ID", DbType.String, Reg.Service_ID);
            database.AddInParameter(dbCommand, "IsPoints", DbType.Int32, Reg.IsPoints);
            database.AddInParameter(dbCommand, "IsCash", DbType.Int32, Reg.IsCash);
            database.AddInParameter(dbCommand, "IsDateRange", DbType.Int32, Reg.IsDateRange);
            database.AddInParameter(dbCommand, "IsSound", DbType.Int32, Reg.IsSound);
            database.AddInParameter(dbCommand, "IsFrequency", DbType.Int32, Reg.IsFrequency);
            database.AddInParameter(dbCommand, "IsAdditionalGift", DbType.Int32, Reg.IsAdditionalGift);
            database.AddInParameter(dbCommand, "IsCoupons", DbType.Int32, Reg.IsCoupons);
            database.AddInParameter(dbCommand, "IsMessageTemplete", DbType.Int32, Reg.IsMessageTemplete);
            database.AddInParameter(dbCommand, "EntryDate", DbType.DateTime, Reg.EntryDate.ToString("yyyy/MM/dd hh:mm:ss tt"));
            database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, Reg.IsDelete);
            database.AddInParameter(dbCommand, "IsNotify", DbType.Int32, Reg.IsNotify);
            database.AddInParameter(dbCommand, "IsNoMessage", DbType.Int32, Reg.IsNoMessage);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.AddInParameter(dbCommand, "Act", DbType.String, Reg.Act);
            database.ExecuteNonQuery(dbCommand);
        }
        public static DataSet FillGridServiceFeature(ObjService Reg)
        {
            Reg.DML = "F";
            dbCommand = database.GetStoredProcCommand("PROC_FillServiceFeatureDetails");
            database.AddInParameter(dbCommand, "ServiceName", DbType.String, Reg.ServiceName);
            database.AddInParameter(dbCommand, "ServiceFeaure_ID", DbType.String, Reg.ServiceFeaure_ID);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            return database.ExecuteDataSet(dbCommand);
        }
        public static void FillServiceFeatureInfo(ObjService Reg)
        {
            Reg.DML = "S";
            dbCommand = database.GetStoredProcCommand("PROC_FillServiceFeatureDetails");
            database.AddInParameter(dbCommand, "ServiceName", DbType.String, Reg.ServiceName);
            database.AddInParameter(dbCommand, "ServiceFeaure_ID", DbType.String, Reg.ServiceFeaure_ID);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            DataTable dt = database.ExecuteDataSet(dbCommand).Tables[0];
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Reg.Service_ID = dt.Rows[i]["Service_ID"].ToString();
                    Reg.ServiceName = dt.Rows[i]["ServiceName"].ToString();
                    Reg.IsPoints = Convert.ToInt32(dt.Rows[i]["IsPoints"].ToString());
                    Reg.IsDateRange = Convert.ToInt32(dt.Rows[i]["IsDateRange"].ToString());
                    Reg.IsSound = Convert.ToInt32(dt.Rows[i]["IsSound"].ToString());
                    Reg.IsFrequency = Convert.ToInt32(dt.Rows[i]["IsFrequency"].ToString());
                    Reg.IsAdditionalGift = Convert.ToInt32(dt.Rows[i]["IsAdditionalGift"].ToString());
                    Reg.IsMessageTemplete = Convert.ToInt32(dt.Rows[i]["IsMessageTemplete"].ToString());
                    Reg.IsDelete = Convert.ToInt32(dt.Rows[i]["IsDelete"].ToString());
                    Reg.IsNotify = Convert.ToInt32(dt.Rows[i]["IsNotify"].ToString());
                    Reg.IsNoMessage = Convert.ToInt32(dt.Rows[i]["IsNoMessage"].ToString());
                }
            }
        }
        #endregion


        #region Services About's & Terms And Conditions

        public static void NewsEntry(ObjService Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [M_ServiceTerms_Conditions] SET [IsActive] = 1 WHERE [Service_ID] = '" + Reg.Service_ID + "' AND [IsActive] = 0");
            database.ExecuteNonQuery(dbCommand);
            dbCommand = database.GetSqlStringCommand("INSERT INTO [M_ServiceTerms_Conditions]([Service_ID],[EntryDate],[AboutService],[Terms_Conditions],[Advantage],[IsActive],[IsDelete]) VALUES ('" + Reg.Service_ID + "' ,'" + Convert.ToDateTime(Reg.EntryDate).ToString("yyyy/MM/dd hh:mm:ss tt") + "' ,'" + Reg.AboutService + "' ,'" + Reg.Terms_Conditions + "' ,'" + Reg.Advantage + "' ," + Reg.IsActive + " ," + Reg.IsDelete + ") ");
            database.ExecuteNonQuery(dbCommand);
        }
        public static DataSet FillGridData()
        {
            dbCommand = database.GetSqlStringCommand("select row_number() over(order by Row_ID) as sr_no,Row_ID,Service_ID,AboutService,Terms_Conditions,Advantage,EntryDate,case when IsActive=0 then 'Activated' else 'Deactivated' end as [Status],IsActive,IsDelete from M_ServiceTerms_Conditions  WHERE [IsActive] = 0 AND IsDelete = 0 order by EntryDate desc"); dbCommand.CommandTimeout = 500;
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillDataUpDate(ObjService NewUpdt)
        {
            dbCommand = database.GetSqlStringCommand("select row_number() over(order by Row_ID) as sr_no,Row_ID,Service_ID,AboutService,Terms_Conditions,Advantage,EntryDate,case when IsActive=0 then 'Activated' else 'Deactivated' end as [Status],IsActive,IsDelete from M_ServiceTerms_Conditions WHERE Row_ID =" + NewUpdt.Row_ID + "  AND [IsActive] = 0 ");
            return database.ExecuteDataSet(dbCommand);
        }
        public static void DeleteRecords(ObjService Del)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE M_ServiceTerms_Conditions SET IsDelete = 1 WHERE  Row_ID = " + Del.Row_ID + " ");
            database.ExecuteNonQuery(dbCommand);
        }
        #endregion



        public static void InsertUpdateServieSubscription(ObjService Reg)
        {
            DataTable cdt = SQL_DB.ExecuteDataTable("SELECT Subscribe_Id FROM M_ServiceSubscription WHERE (GETDATE() BETWEEN DateFrom AND DateTo) AND (Service_ID = '" + Reg.Service_ID + "') AND (Pro_ID = '" + Reg.Pro_ID + "') AND (Plan_ID = '" + Reg.Plan_ID + "')");
            if (cdt.Rows.Count > 0)
            {
                //SQL_DB.ExecuteNonQuery("UPDATE M_ServiceSubscription SET IsActive = 0, IsDelete = 1 WHERE (GETDATE() BETWEEN DateFrom AND DateTo) AND (Service_ID = '" + Reg.Service_ID + "') AND (Pro_ID = '" + Reg.Pro_ID + "') AND (Plan_ID = '" + Reg.Plan_ID + "')  and start_order=" + Convert.ToInt32(Reg.code_range.Split(',')[0].Split('-')[0]) + " and end_order=" + Convert.ToInt32(Reg.code_range.Split(',')[1].Split('-')[0]) + "and start_series=" + Convert.ToInt32(Reg.code_range.Split(',')[0].Split('-')[1]) + "and end_series=" + Convert.ToInt32(Reg.code_range.Split(',')[1].Split('-')[1]) + " AND (IsActive = 1 OR IsActive = 0) AND IsDelete = 0 ");
            }
            if (Reg.DML == "I")
                Reg.Subscribe_Id = Utility.GetMyGenID("Subscription");
            dbCommand = database.GetStoredProcCommand("PROC_InsertUpdateServiceSubscription");
            database.AddInParameter(dbCommand, "Subscribe_Id", DbType.String, Reg.Subscribe_Id);
            database.AddInParameter(dbCommand, "Service_ID", DbType.String, Reg.Service_ID);
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            database.AddInParameter(dbCommand, "Plan_ID", DbType.String, Reg.Plan_ID);
            database.AddInParameter(dbCommand, "PlanName", DbType.String, Reg.PlanName);
            database.AddInParameter(dbCommand, "PlanMasterPeriod", DbType.Int64, Reg.PlanMasterPeriod);
            database.AddInParameter(dbCommand, "PlanSalePeriod", DbType.Int64, Reg.PlanSalePeriod);
            database.AddInParameter(dbCommand, "PlanMasterPrice", DbType.Int64, Reg.PlanMasterPrice);
            database.AddInParameter(dbCommand, "PlanSalePrice", DbType.Int64, Reg.PlanSalePrice);
            database.AddInParameter(dbCommand, "DateFrom", DbType.DateTime, Convert.ToDateTime(Reg.DateFrom).ToString("yyyy/MM/dd"));
            database.AddInParameter(dbCommand, "DateTo", DbType.DateTime, Convert.ToDateTime(Reg.DateTo).ToString("yyyy/MM/dd"));
            database.AddInParameter(dbCommand, "EntryDate", DbType.DateTime, Reg.EntryDate.ToString("yyyy/MM/dd hh:mm:ss tt"));
            database.AddInParameter(dbCommand, "IsActive", DbType.Int32, Reg.IsActive);
            database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, Reg.IsDelete);
            database.AddInParameter(dbCommand, "IsAdminVerify", DbType.Int32, Reg.IsAdminVerify);
            //database.AddInParameter(dbCommand, "startorder", DbType.Int32, Convert.ToInt32(Reg.code_range.Split(',')[0].Split('-')[0]));
            //database.AddInParameter(dbCommand, "endorder", DbType.Int32, Convert.ToInt32(Reg.code_range.Split(',')[1].Split('-')[0]));
            //database.AddInParameter(dbCommand, "startseries", DbType.Int32, Convert.ToInt32(Reg.code_range.Split(',')[0].Split('-')[1]));
            //database.AddInParameter(dbCommand, "endseries", DbType.Int32, Convert.ToInt32(Reg.code_range.Split(',')[1].Split('-')[1]));
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
            if (Reg.DML == "I")
                Utility.SetMyGenID("Subscription");


        }

        public static void VerifyServiceRequest(ObjService Reg)
        {
            try
            {
                dbCommand = database.GetSqlStringCommand("UPDATE [M_ServiceSubscription] SET [DateFrom] = '" + Convert.ToDateTime(Reg.DateFrom).ToString("yyyy/MM/dd") + "', [DateTo] = '" + Convert.ToDateTime(Reg.DateTo).ToString("yyyy/MM/dd") + "' ,[PlanSalePeriod] =  '" + Reg.PlanSalePeriod + "' ,[PlanSalePrice] = '" + Reg.PlanSalePrice + "',[IsAdminVerify] = 1 WHERE [Subscribe_Id] = '" + Reg.Subscribe_Id + "' ");
                database.ExecuteNonQuery(dbCommand);
                dbCommand = database.GetSqlStringCommand("INSERT INTO M_ServiceSubscriptionLog SELECT * FROM M_ServiceSubscription WHERE [Subscribe_Id] = '" + Reg.Subscribe_Id + "' ");
                database.ExecuteNonQuery(dbCommand);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
    #endregion

    #region Warranty
    public static class Warranty
    {
        private static Database database = DatabaseFactory.CreateDatabase();
        private static DbCommand dbCommand;
        private static DataAdapter adp;
        private static DataSet ds;

        public static DataSet GetWarrantyDetail(string email)
        {
            DateTime today = System.DateTime.Today;
            //dbCommand = database.GetSqlStringCommand("SELECT [id],[BillNo],[PurchaseDate],[Email],[Mobile],WarrantyPeriod,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays, ImagePathBill FROM [dbo].[WarrentyDetails] where Mobile='" + email.Replace("91", "") + "'");
            dbCommand = database.GetSqlStringCommand("SELECT [id],[BillNo],[PurchaseDate],[Email],[Mobile],WarrantyPeriod,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays,ImagePathBill,IsWarrantyClaimed,VendorClaimStatus,[VendorComments],[Comment] FROM [dbo].[WarrentyDetails] where Mobile='" + email.Replace("91", "") + "'");
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet GetWarrantyDetailVendor(string strCompanyId)
        {
            DateTime today = System.DateTime.Today;
            //if (!string.IsNullOrEmpty(email))
            //{
            //    //dbCommand = database.GetSqlStringCommand("SELECT [id],[BillNo],[PurchaseDate],[Email],[Mobile],WarrantyPeriod,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays FROM [dbo].[WarrentyDetails] where email='" + email + "'");
            //    dbCommand = database.GetSqlStringCommand("SELECT [id],[BillNo],[PurchaseDate],[Email],[Mobile],WarrantyPeriod,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays,ImagePathBill,IsWarrantyClaimed,VendorClaimStatus,ImagePath,VendorComments,Comment FROM [dbo].[WarrentyDetails] Where Email='" + email + "'");
            //}
            //else
            //{


            //string strSql = "SELECT [id],[BillNo],[PurchaseDate],[Email],[Mobile],Code as 'Complete Code',Pro_ID as 'Product_ID',WarrantyPeriod,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays " +
            //",ImagePathBill,IsWarrantyClaimed,VendorClaimStatus,ImagePath,VendorComments,Comment FROM [dbo].[WarrentyDetails] A inner join M_code B on cast(B.Code1 as varchar(20))+'-'+cast(B.Code2 as varchar(20)) = A.Code " +
            //" Where A.IsWarrantyClaimed = 1 and A.PurchaseDate <= getdate() and B.Pro_Id in (select Pro_Id from Pro_Reg where Comp_id = '" + strCompanyId + "') order by A.Purchasedate desc ";

//  string strSql = "SELECT [id],[BillNo],pr.[Pro_Name]+'('+ pr.Pro_id + ')' as 'Product_Name',concat(b.[Code1],b.code2) as 'code',[Mobile],WarrantyPeriod,PurchaseDate,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays ,ImagePathBill,IsWarrantyClaimed,VendorClaimStatus,ImagePath,VendorComments,Comment,claimdate FROM [dbo].[WarrentyDetails] A inner join M_code B on cast(B.Code1 as varchar(20))+'-'+cast(B.Code2 as varchar(20)) = A.Code inner join Pro_Reg pr on pr.Pro_ID=b.Pro_ID  Where A.IsWarrantyClaimed = 1 and A.PurchaseDate <= getdate() and pr.comp_id='" + strCompanyId + "'order by A.claimdate desc ";
            string strSql = "SELECT [id],[BillNo],pr.[Pro_Name]+'('+ pr.Pro_id + ')' as 'Product_Name',concat(b.[Code1],b.code2) as 'code',[Mobile],WarrantyPeriod,PurchaseDate,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays ,ImagePathBill,IsWarrantyClaimed,VendorClaimStatus,ImagePath,VendorComments,Comment,claimdate,State FROM [dbo].[WarrentyDetails] A inner join M_code B on cast(B.Code1 as varchar(20))+'-'+cast(B.Code2 as varchar(20)) = A.Code inner join Pro_Reg pr on pr.Pro_ID=b.Pro_ID  Where  A.IsWarrantyClaimed = 1 and A.PurchaseDate <= getdate() and pr.comp_id='" + strCompanyId + "'order by A.claimdate desc ";

            dbCommand = database.GetSqlStringCommand(strSql);
            //}

            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet GetWarrantyDetailVendor_download(string strCompanyId)
        {
            DateTime today = System.DateTime.Today;
            //if (!string.IsNullOrEmpty(email))
            //{
            //    //dbCommand = database.GetSqlStringCommand("SELECT [id],[BillNo],[PurchaseDate],[Email],[Mobile],WarrantyPeriod,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays FROM [dbo].[WarrentyDetails] where email='" + email + "'");
            //    dbCommand = database.GetSqlStringCommand("SELECT [id],[BillNo],[PurchaseDate],[Email],[Mobile],WarrantyPeriod,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays,ImagePathBill,IsWarrantyClaimed,VendorClaimStatus,ImagePath,VendorComments,Comment FROM [dbo].[WarrentyDetails] Where Email='" + email + "'");
            //}
            //else
            //{


            //string strSql = "SELECT [id],[BillNo],[PurchaseDate],[Email],[Mobile],Code as 'Complete Code',Pro_ID as 'Product_ID',WarrantyPeriod,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays " +
            //",ImagePathBill,IsWarrantyClaimed,VendorClaimStatus,ImagePath,VendorComments,Comment FROM [dbo].[WarrentyDetails] A inner join M_code B on cast(B.Code1 as varchar(20))+'-'+cast(B.Code2 as varchar(20)) = A.Code " +
            //" Where A.IsWarrantyClaimed = 1 and A.PurchaseDate <= getdate() and B.Pro_Id in (select Pro_Id from Pro_Reg where Comp_id = '" + strCompanyId + "') order by A.Purchasedate desc ";

           // string strSql = "SELECT [BillNo] as 'Bill.No.',PurchaseDate as '[Purchase on]',concat(b.[Code1],b.code2) as 'Complete Code',[Mobile] as 'Mobile No',pr.[Pro_Name]+'('+ pr.Pro_id + ')' as 'Product Name',WarrantyPeriod as 'Warranty Period(In Months)',ExpirationDate as 'Expiration Date',DATEDIFF(day, GETDATE(), ExpirationDate) as 'Remaining Days',replace(replace(ImagePath,'\\','/'),'~','https://vcqru.com') as 'Product Image',replace(replace(ImagePathBill,'\\','/'),'~','https://vcqru.com') as 'Bill pdf',VendorClaimStatus as 'Vendor Status',claimdate as  'Claim Date' FROM [dbo].[WarrentyDetails] A inner join M_code B on cast(B.Code1 as varchar(20))+'-'+cast(B.Code2 as varchar(20)) = A.Code inner join Pro_Reg pr on pr.Pro_ID=b.Pro_ID  Where A.IsWarrantyClaimed = 1 and A.PurchaseDate <= getdate() and pr.comp_id='" + strCompanyId + "'order by A.claimdate desc ";
            string strSql = "";
            strSql = "SELECT [BillNo] as 'Bill.No.',PurchaseDate as '[Purchase on]',concat(b.[Code1],b.code2) as 'Complete Code',[Mobile] as 'Mobile No',pr.[Pro_Name]+'('+ pr.Pro_id + ')' as 'Product Name',WarrantyPeriod as 'Warranty Period(In Months)',ExpirationDate as 'Expiration Date',DATEDIFF(day, GETDATE(), ExpirationDate) as 'Remaining Days',replace(replace(ImagePath,'\\','/'),'~','https://vcqru.com') as 'Product Image',replace(replace(ImagePathBill,'\\','/'),'~','https://vcqru.com') as 'Bill pdf',VendorClaimStatus as 'Vendor Status',claimdate as  'Claim Date' FROM [dbo].[WarrentyDetails] A inner join M_code B on cast(B.Code1 as varchar(20))+'-'+cast(B.Code2 as varchar(20)) = A.Code inner join Pro_Reg pr on pr.Pro_ID=b.Pro_ID  Where A.IsWarrantyClaimed = 1 and A.PurchaseDate <= getdate() and pr.comp_id='" + strCompanyId + "'order by A.claimdate desc ";
            if (strCompanyId.ToString() == "Comp-1629")
            {
                strSql = "SELECT [BillNo] as 'Vehicle No.',[State] as 'Device Type',PurchaseDate as '[Purchase on]',concat(b.[Code1],b.code2) as 'Complete Code',[Mobile] as 'Mobile No',pr.[Pro_Name]+'('+ pr.Pro_id + ')' as 'Product Name',WarrantyPeriod as 'Warranty Period(In Months)',ExpirationDate as 'Expiration Date',DATEDIFF(day, GETDATE(), ExpirationDate) as 'Remaining Days',replace(replace(ImagePath,'\\','/'),'~','https://vcqru.com') as 'Product Image',replace(replace(ImagePathBill,'\\','/'),'~','https://vcqru.com') as 'Bill pdf',VendorClaimStatus as 'Vendor Status',claimdate as  'Claim Date' FROM [dbo].[WarrentyDetails] A inner join M_code B on cast(B.Code1 as varchar(20))+'-'+cast(B.Code2 as varchar(20)) = A.Code inner join Pro_Reg pr on pr.Pro_ID=b.Pro_ID  Where A.IsWarrantyClaimed = 1 and A.PurchaseDate <= getdate() and pr.comp_id='" + strCompanyId + "'order by A.claimdate desc ";
            }
            dbCommand = database.GetSqlStringCommand(strSql);
            //}

            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet GetImages(int id)
        {

            //dbCommand = database.GetSqlStringCommand("SELECT [id],[BillNo],[PurchaseDate],[Email],[Mobile],WarrantyPeriod,ExpirationDate,DATEDIFF(day, GETDATE(), ExpirationDate) as NumberofDays FROM [dbo].[WarrentyDetails] where email='" + email + "'");
            dbCommand = database.GetSqlStringCommand("select filepath from [File] where WarId=" + id);
            return database.ExecuteDataSet(dbCommand);
        }

    }
    #endregion
}