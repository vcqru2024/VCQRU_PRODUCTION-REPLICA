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
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.Net;
using System.IO;

/// <summary>
/// Summary description for Uttils
/// </summary>
/// 
namespace DataProvider
{
    public class MyCalculation
    {        
        public static void Calculation(string User_Id)
        {            
            DataSet ds = new System.Data.DataSet();
            DataSet dsf = new System.Data.DataSet();            
            SQL_DB.GetDA("SELECT  id, user_id, pwd, Acc_pass, name, father_name, mother_name, address, pincode, city, state, country, mobile, d_o_b, pan_no, e_mail, bank_name, account_no, product_code, nominee_name, nominee_relation, nominee_dob, nominee_address, payment_mode, dd_amt, ifc, bank, sponsor_id, sponsor_name, pos, status, reg_date, act_date, Level_Id, Parent_Id, IsPayReferal, IsFirst, Tot_Pair, Category, dd_date, dd_no, Branch_name, Policy_No, Policy_Date, Zone_Entry_Date, Policy_holder, other_detail, pin, appformno, Slab FROM  Registration where user_id='" + User_Id + "'").Fill(ds, "Reg_Data");
            SQL_DB.GetDA("SELECT Tbl_Id, [Level], Reacharge_First, Reacharge_Always, Selling_First, Selling_Always, Booking_First, Booking_Always FROM Commission_Setting").Fill(ds, "Comm");
            SQL_DB.GetDA("select Admin_Charge,TDS,Min_Tra,Max_Tra,[Bon_Start],[Bon_End],isnull([BonanzaOn],0) as [BonanzaOn] from Detect_Master").Fill(ds, "Master");
            SQL_DB.GetDA("SELECT  Registration.user_id from Registration INNER JOIN  Rechage_Trans ON  Registration.user_id= Rechage_Trans.user_id where sponsor_id='" + User_Id + "' AND  Rechage_Trans.Rch_Amt >= '" + Convert.ToString(SQL_DB.ExecuteScalar("SELECT ISNULL(Min_Reacharge,0) AS Min_Reacharge  FROM  Detect_Master WHERE tbl_id=1")) + "' ").Fill(ds, "Lvl1");
            double MyTotalAmount = 0.0; double MyAmount = 0.0; double OldAmount = 0.0; double AdminC = 0.0; double TDS = 0.0; double CurrentAmount = 0.0;
            double MyTotalAmount1 = 0.0; double AdminC1 = 0.0; double TDS1 = 0.0; double CurrentAmount1 = 0.0;
            int cntrow = 0; int totalUser=ds.Tables["Lvl1"].Rows.Count;
            if (totalUser > 0)
                cntrow = 1;
             if (ds.Tables["Lvl1"].Rows.Count > 0)
                {
                    cntrow +=1;
                FindDs:
                    if (ds.Tables["Lvl" + Convert.ToInt32(cntrow - 1).ToString()].Rows.Count > 0)
                     {
                        for (int i = 0; i < ds.Tables["Lvl"+Convert.ToInt32(cntrow -1).ToString()].Rows.Count; i++)
                        {
                            SQL_DB.GetDA("SELECT user_id from Registration where sponsor_id='" + ds.Tables["Lvl" + Convert.ToInt32(cntrow - 1).ToString()].Rows[i]["user_id"].ToString() + "'").Fill(ds, "Lvl" + cntrow.ToString());                     
                        }
                    }
                    if (ds.Tables["Lvl" + Convert.ToInt32(cntrow).ToString()].Rows.Count > 0)
                    {
                        cntrow += 1;
                        goto FindDs;
                    }
                    else
                    {
                       ds.Tables.Remove("Lvl" + Convert.ToInt32(cntrow).ToString());
                       cntrow -= 1;
                    }
                 }
            #region CheckFirst And Always Condions
             
                for (int m = 1; m <= cntrow; m++)
                {
                    StringBuilder strbuild = new StringBuilder(); StringBuilder strbuild1 = new StringBuilder();
                    string copuser_id="";string copuser_id1="";
                    if (ds.Tables["Lvl" + m.ToString()].Rows.Count > 0)
                    {
                        for (int j = 0; j < ds.Tables["Lvl" + m.ToString()].Rows.Count; j++)
                        {  
                            if(Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT IsFirst FROM Registration WHERE User_Id='"+ ds.Tables["Lvl" + m.ToString()].Rows[j]["user_id"].ToString() +"'"))==0)
                                strbuild.Append("'"+ds.Tables["Lvl" + m.ToString()].Rows[j]["user_id"].ToString()+"',");
                            else
                                strbuild1.Append("'" + ds.Tables["Lvl" + m.ToString()].Rows[j]["user_id"].ToString() + "',");
                        }
                        if(strbuild.ToString() != "")
                            copuser_id = strbuild.ToString().Substring(0, strbuild.ToString().Length-1);
                        if(strbuild1.ToString() != "")
                            copuser_id1 = strbuild1.ToString().Substring(0, strbuild1.ToString().Length - 1);
                        OldAmount = Convert.ToDouble(SQL_DB.ExecuteScalar("SELECT ISNULL(SUM(isnull([Lvl" + m.ToString() + "],0)),0) FROM [Cal_Payment_Tab] WHERE user_id='" + User_Id + "'  "));
                        if (copuser_id.ToString() != "")
                        {
                            MyTotalAmount += Convert.ToDouble(SQL_DB.ExecuteScalar("SELECT ISNULL(SUM(isnull([Rch_Amt],0)),0) FROM [Rechage_Trans] WHERE user_id in (" + copuser_id + ")  and [Paid]=1"));
                            if (Convert.ToDouble(ds.Tables["Comm"].Rows[m - 1]["Reacharge_First"].ToString()) == 0.0)
                                CurrentAmount = 0.0;
                            else
                                CurrentAmount = Convert.ToDouble(Convert.ToDouble((MyTotalAmount - OldAmount) * Convert.ToDouble(ds.Tables["Comm"].Rows[m - 1]["Reacharge_First"].ToString())) / 100);
                            if (Convert.ToDouble(ds.Tables["Master"].Rows[0]["Admin_Charge"].ToString()) == 0.0)
                                AdminC = 0.0;
                            else
                                AdminC = Convert.ToDouble(Convert.ToDouble(CurrentAmount * Convert.ToDouble(ds.Tables["Master"].Rows[0]["Admin_Charge"].ToString())) / 100);
                            if (Convert.ToDouble(ds.Tables["Master"].Rows[0]["TDS"].ToString()) == 0.0)
                                TDS = 0.0;
                            else
                                TDS = Convert.ToDouble(Convert.ToDouble(CurrentAmount * Convert.ToDouble(ds.Tables["Master"].Rows[0]["TDS"].ToString())) / 100);
                        }
                        else
                        {
                            MyTotalAmount = 0.0; CurrentAmount = 0.0; AdminC = 0.0; TDS = 0.0;
                        }
                        if (copuser_id1.ToString() != "")
                        {
                            MyTotalAmount1 += Convert.ToDouble(SQL_DB.ExecuteScalar("SELECT ISNULL(SUM(isnull([Rch_Amt],0)),0) FROM [Rechage_Trans] WHERE user_id in (" + copuser_id1 + ")  and [Paid]=1"));
                            if (Convert.ToDouble(ds.Tables["Comm"].Rows[m - 1]["Reacharge_Always"].ToString()) == 0.0)
                                CurrentAmount1 = 0.0;
                            else
                                CurrentAmount1 = Convert.ToDouble(Convert.ToDouble((MyTotalAmount1 - OldAmount) * Convert.ToDouble(ds.Tables["Comm"].Rows[m - 1]["Reacharge_First"].ToString())) / 100);
                            if (Convert.ToDouble(ds.Tables["Master"].Rows[0]["Admin_Charge"].ToString()) == 0.0)
                                AdminC1 = 0.0;
                            else
                                AdminC1 = Convert.ToDouble(Convert.ToDouble(CurrentAmount1 * Convert.ToDouble(ds.Tables["Master"].Rows[0]["Admin_Charge"].ToString())) / 100);
                            if (Convert.ToDouble(ds.Tables["Master"].Rows[0]["TDS"].ToString()) == 0.0)
                                TDS1 = 0.0;
                            else
                                TDS1 = Convert.ToDouble(Convert.ToDouble(CurrentAmount1 * Convert.ToDouble(ds.Tables["Master"].Rows[0]["TDS"].ToString())) / 100);
                        }
                        else
                        {
                            MyTotalAmount1 = 0.0; CurrentAmount1 = 0.0; AdminC1 = 0.0; TDS1 = 0.0;
                        }
                        MyAmount = Convert.ToDouble(CurrentAmount + CurrentAmount1 - (AdminC + AdminC1 + TDS + TDS1));
                        InsertAmount(User_Id, ds.Tables["Lvl" + m.ToString()].Rows.Count, MyAmount, m, Convert.ToDouble(MyTotalAmount + MyTotalAmount1 - OldAmount), Convert.ToDouble(AdminC + AdminC1), Convert.ToDouble(TDS +TDS1), Convert.ToDouble(CurrentAmount +CurrentAmount1)); MyTotalAmount = 0.0; OldAmount = 0.0;
                        if (copuser_id.ToString() != "")
                        {
                            string[] UserIds = copuser_id.Split(',');
                            foreach (string UserId in UserIds)
                            {
                                SQL_DB.ExecuteNonQuery("update Registration Set IsFirst=1 where User_Id=" + UserId + " ");
                            }
                        }
                    }                   
                }           
            #endregion
        }
        public static void InsertAmount(string User_Id, double totalUser, double MyAmount, int LevelId, double oldAmount, double AdminC, double TDS, double CurrentAmount)
        {
            DataSet ds=new System.Data.DataSet(); double lve1Amt=0.0;double lve2Amt=0.0;double lve3Amt=0.0;double lve4Amt=0.0;double lve5Amt=0.0;double lve6Amt=0.0;
            #region Level
            switch (LevelId)
            {
                case 1:
                    {
                        lve1Amt = oldAmount; lve2Amt = 0.0; lve3Amt = 0.0; lve4Amt = 0.0; lve5Amt = 0.0; lve6Amt = 0.0; break;
                    }
                case 2:
                    {
                        lve1Amt = 0.0; lve2Amt = oldAmount; lve3Amt = 0.0; lve4Amt = 0.0; lve5Amt = 0.0; lve6Amt = 0.0; break;
                    }
                case 3:
                    {
                        lve1Amt = 0.0; lve2Amt = 0.0; lve3Amt = oldAmount; lve4Amt = 0.0; lve5Amt = 0.0; lve6Amt = 0.0; break;
                    }
                case 4:
                    {
                        lve1Amt = 0.0; lve2Amt = 0.0; lve3Amt = 0.0; lve4Amt = oldAmount; lve5Amt = 0.0; lve6Amt = 0.0; break;
                    }
                case 5:
                    {
                        lve1Amt = 0.0; lve2Amt = 0.0; lve3Amt = 0.0; lve4Amt = 0.0; lve5Amt = oldAmount; lve6Amt = 0.0; break;
                    }
                case 6:
                    {
                        lve1Amt = 0.0; lve2Amt = 0.0; lve3Amt = 0.0; lve4Amt = 0.0; lve5Amt = 0.0; lve6Amt = oldAmount; break;
                    }
                default :
                    lve1Amt=0.0;lve2Amt=0.0;lve3Amt=0.0;lve4Amt=0.0;lve5Amt=0.0;lve6Amt=0.0; break;

            }
            #endregion
            SQL_DB.GetDA("SELECT [prefix],[startwith]  FROM [code_gen] where  [key_col]='Calculate'").Fill(ds, "Code_Gen");
            string TransId = ds.Tables["Code_Gen"].Rows[0]["prefix"].ToString() + ds.Tables["Code_Gen"].Rows[0]["startwith"].ToString();
            string Qry = "";
            Qry = "INSERT INTO [Cal_Payment_Tab] ([ID],[User_Id],[Child_Current_Date],[BV_Amount] " +
                         " ,[Admin],[TDS],[WelFair],[Final_Amount],[Entry_Date],[Cal_Date],[Chq_No],[Chq_Issue_date],[Chq_Remark] " +
                         ",[Grwth_Amt],[Tot_User],[award_id],[rewarded],[TDS_Per],[Admin_Per],[Lvl1],[Lvl2],[Lvl3],[Lvl4],[Lvl5],[Lvl6]) VALUES " +
                         " ('" + TransId + "' " +
                         ", '" + User_Id + "' " +
                         ", '" + totalUser + "' " +
                         ", '" + Convert.ToDouble(CurrentAmount) + "' " +
                          ", '" + AdminC + "' " +
                         ", '" + TDS + "' " +
                         ", '0' " +
                         ", '" + Convert.ToDouble(MyAmount) + "' " +
                         ", '" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "' " +
                         ", '" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "' " +
                         ", 'NA' " +
                         ", '" + DataProvider.LocalDateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "' " +
                         ", 'NA' " +
                         ", '" + Convert.ToDouble(MyAmount) + "' " +
                         ", '" + totalUser + "' " +
                         ", 0 " +
                         ", 0 " +
                         ", '"+ AdminC+"' " +
                         ", '"+ TDS +"' " + 
                         ", '"+ lve1Amt +"' , '"+ lve2Amt +"', '"+ lve3Amt +"', '"+ lve4Amt +"', '"+ lve5Amt +"', '"+ lve6Amt +"'  " + 
                         " )";           
                 SQL_DB.ExecuteNonQuery(Qry);
                 SQL_DB.ExecuteNonQuery("UPDATE [code_gen] SET [startwith] = [startwith]+1 WHERE [key_col] = 'Calculate'");
        }
        public static bool ChechFirst(string User_Id)
        {
            bool myChk = false;
            int str = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT  count(IsFirst) from Registration where user_id='" + User_Id + "'"));
            if (str == 0)
                myChk = true;
            return myChk;
        }
    }
    //public class LocalDateTime 
    //{
    //    DateTime Date;
    //    public LocalDateTime()
    //    {

    //    }
    //    public LocalDateTime(int Year,int Month,int day)
    //    {
    //        Date = new DateTime(Year, Month, day);
    //    }

    //    public static DateTime Now
    //    {
    //        get {                
    //            DateTime univerTime = DateTime.SpecifyKind(DateTime.Now, DateTimeKind.Local);
    //            univerTime = univerTime.AddSeconds(1);
    //            TimeZoneInfo tz = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
    //            return TimeZoneInfo.ConvertTime(univerTime, tz);
    //            }
    //    }
    //}
    //public class Uttils
    //{
        
    //    private static DateTime dto, dfrom;
    //    public static int Count;
    //    public static int TDSCount;
    //    public static int AdminCount;
    //    public static int AccSMCount;
    //    public static int CalCount;
    //    public static int TransCount;       
    //    public Uttils()
    //    { 
            
    //    }
    //    private static int GetPageIndex(int maximumRows, int startRowIndex)
    //    {
    //        double d=startRowIndex / maximumRows;
    //        return Convert.ToInt32(Math.Ceiling(d)) + 1;
    //    }
    //    public static string Create_Directory(string str)
    //    {
    //        if (Directory.Exists(str))
    //        { }
    //        else
    //            Directory.CreateDirectory(str);
    //        return str;
    //    }
    //    public static DataTable GetRegistration(string User_Id, string City, string Mobile, int Pair , int Status,string SortCol, int maximumRows, int startRowIndex)
    //    {
    //        if (startRowIndex > 0)
    //            startRowIndex = GetPageIndex(maximumRows, startRowIndex);
    //        SqlParameter ParamUser_Id = new SqlParameter("Usr_Id", User_Id);
    //        SqlParameter ParamCity = new SqlParameter("City", City);
    //        SqlParameter ParamMob = new SqlParameter("Mobile", Mobile);
    //        SqlParameter ParamPair = new SqlParameter("Pair", Pair);
    //        SqlParameter ParamStatus = new SqlParameter("Status", Status);
    //        SqlParameter ParamPIndex = new SqlParameter("Page_Index", startRowIndex);
    //        SqlParameter ParamPSize = new SqlParameter("Page_Size", maximumRows);           
    //        DataTable dt = new DataTable();
    //        dt = Procedure.GetProcedureData("GeRegistration", ParamUser_Id, ParamPIndex, ParamPSize, ParamCity, ParamMob, ParamPair, ParamStatus);
    //        DataView dv = dt.DefaultView;
    //        dv.Sort = SortCol;
    //        return dv.ToTable();
    //    }

    //    public static int RegCount(string User_Id, string City, string Mobile, int Pair , int Status, string SortCol)
    //    {
    //        Count = GetRegistration(User_Id, City, Mobile, Pair, Status, SortCol, 999999, 0).Rows.Count;
    //        return Count;
    //    }

    //    public static DataTable GetCalData(string User_Id, string Datefrom, string Dateto, string Condition, int maximumRows, int startRowIndex)
    //    {
    //        if (startRowIndex > 0)
    //            startRowIndex = GetPageIndex(maximumRows, startRowIndex);
    //        if (startRowIndex == 0)
    //            startRowIndex = 1;

    //        if (Datefrom != "" && Datefrom != " ")
    //        {

    //            dfrom = Convert.ToDateTime(Datefrom);
    //            Datefrom = dfrom.ToString("MM/dd/yyyy");
    //        }
    //        if (Dateto != "" && Dateto != " ")
    //        {
    //            string[] str = Dateto.Split('/');
    //            dto = Convert.ToDateTime(Dateto);
    //            Dateto = dto.ToString("MM/dd/yyyy");
    //        }
    //        DataSet ds = new DataSet();
    //        string s = "Select * from (SELECT row_number() over(order by tbl_id) as Row_No , Cal_Payment_Tab.tbl_id, Cal_Payment_Tab.ID, Cal_Payment_Tab.User_Id, Registration.name,Cal_Payment_Tab.BV_Amount, " +
    //                  " Cal_Payment_Tab.Admin, Cal_Payment_Tab.TDS, Cal_Payment_Tab.WelFair, Cal_Payment_Tab.Final_Amount, Cal_Payment_Tab.Entry_Date,  " +
    //                  " Cal_Payment_Tab.Cal_Date, Cal_Payment_Tab.Chq_No, Cal_Payment_Tab.Chq_Issue_date, Cal_Payment_Tab.Chq_Remark,  " +
    //                  " Cal_Payment_Tab.Grwth_Amt, Cal_Payment_Tab.Tot_User, Cal_Payment_Tab.award_id, Cal_Payment_Tab.rewarded, Cal_Payment_Tab.TDS_Per,  " +
    //                  " Cal_Payment_Tab.Admin_Per, Cal_Payment_Tab.Lvl1 + Cal_Payment_Tab.Lvl2+ Cal_Payment_Tab.Lvl3+ Cal_Payment_Tab.Lvl4+ Cal_Payment_Tab.Lvl5+ Cal_Payment_Tab.Lvl6 AS Lvl, Registration.status " +
    //                  " FROM         Cal_Payment_Tab INNER JOIN " +
    //                  " Registration ON Cal_Payment_Tab.User_Id = Registration.user_id " +
    //                  " where (''='" + User_Id + "' or '" + User_Id + "' is null or  Cal_Payment_Tab.User_Id='" + User_Id + "') and  ((''='" + Datefrom + "' or '" + Datefrom + "' is null or Cal_Payment_Tab.Cal_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (''='" + Dateto + "' or '" + Dateto + "' is null or Cal_Payment_Tab.Cal_Date<='" + dto.ToString("MM/dd/yyyy") + "') and CONVERT(numeric(18,2),Cal_Payment_Tab.BV_Amount) != 0.00) " + Condition + ") Cal_Tab where Row_No>(" + (startRowIndex - 1) * maximumRows + ") and Row_No<=(" + (startRowIndex) * maximumRows + ")     order by Cal_Tab.Cal_Date ";
    //        //string s = "Select * from (SELECT row_number() over(order by tbl_id) as Row_No ,Cal_Payment_Tab.tbl_id, Cal_Payment_Tab.ID, Cal_Payment_Tab.Left_Child_Current_Date, Cal_Payment_Tab.Right_Child_Current_Date,  Cal_Payment_Tab.Paired_Current_Date, Cal_Payment_Tab.Leps_Bv_Current_Date, Cal_Payment_Tab.BV_Amount, Cal_Payment_Tab.Admin, Cal_Payment_Tab.TDS, Cal_Payment_Tab.WelFair, Cal_Payment_Tab.Final_Amount, Cal_Payment_Tab.Entry_Date, Cal_Payment_Tab.Cal_Date, Cal_Payment_Tab.Referal_amt, Cal_Payment_Tab.Binary_Amt,  Cal_Payment_Tab.User_Id, Registration.Status ,Registration.name FROM   Cal_Payment_Tab INNER JOIN Registration ON Cal_Payment_Tab.User_Id = Registration.user_id  where (''='" + User_Id + "' or '" + User_Id + "' is null or  Cal_Payment_Tab.User_Id='" + User_Id + "') and  ((''='" + Datefrom + "' or '" + Datefrom + "' is null or Cal_Payment_Tab.Cal_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (''='" + Dateto + "' or '" + Dateto + "' is null or Cal_Payment_Tab.Cal_Date<='" + dto.ToString("MM/dd/yyyy") + "')) " + Condition + ") Cal_Tab where Row_No>(" + (startRowIndex - 1) * maximumRows + ") and Row_No<=(" + (startRowIndex) * maximumRows + ")     order by Cal_Tab.Cal_Date ";
    //        //SQL_DB.GetDA("Select * from (SELECT row_number() over(order by tbl_id) as Row_No ,Cal_Payment_Tab.PrimiumAmt,Cal_Payment_Tab.ZoneAmt,Cal_Payment_Tab.Left_Pv,Cal_Payment_Tab.Right_Pv,Cal_Payment_Tab.tbl_id, Cal_Payment_Tab.ID, Cal_Payment_Tab.Left_Child_Current_Date, Cal_Payment_Tab.Right_Child_Current_Date,  Cal_Payment_Tab.Paired_Current_Date, Cal_Payment_Tab.Leps_Bv_Current_Date, Cal_Payment_Tab.BV_Amount, Cal_Payment_Tab.Admin, Cal_Payment_Tab.TDS, Cal_Payment_Tab.WelFair, Cal_Payment_Tab.Final_Amount, Cal_Payment_Tab.Entry_Date, Cal_Payment_Tab.Cal_Date, Cal_Payment_Tab.Referal_amt, Cal_Payment_Tab.Binary_Amt,  Cal_Payment_Tab.User_Id, Registration.Status ,Registration.name FROM   Cal_Payment_Tab INNER JOIN Registration ON Cal_Payment_Tab.User_Id = Registration.user_id  where (''='" + User_Id + "' or '" + User_Id + "' is null or  Cal_Payment_Tab.User_Id='" + User_Id + "') and  ((''='" + Datefrom + "' or '" + Datefrom + "' is null or Cal_Payment_Tab.Cal_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (''='" + Dateto + "' or '" + Dateto + "' is null or Cal_Payment_Tab.Cal_Date<='" + dto.ToString("MM/dd/yyyy") + "')) " + Condition + ") Cal_Tab where Row_No>(" + (startRowIndex - 1) * maximumRows + ") and Row_No<=(" + (startRowIndex) * maximumRows + ")     order by Cal_Tab.Cal_Date ").Fill(ds, "1");
    //        SQL_DB.GetDA(s).Fill(ds, "1");
    //        return ds.Tables[0];
    //    }
    //    public static int CalDataCount(string User_Id, string Datefrom, string Dateto, string Condition)
    //    {
    //        if (Datefrom != "" && Datefrom != " ")
    //        {

    //            dfrom = Convert.ToDateTime(Datefrom);
    //            Datefrom = dfrom.ToString("MM/dd/yyyy");
    //        }
    //        if (Dateto != "" && Dateto != " ")
    //        {

    //            dto = Convert.ToDateTime(Dateto);
    //            Dateto = dto.ToString("MM/dd/yyyy");
    //        }
    //        string s = "Select count(*) from (SELECT row_number() over(order by tbl_id) as Row_No , Cal_Payment_Tab.tbl_id, Cal_Payment_Tab.ID, Cal_Payment_Tab.User_Id, Registration.name,Cal_Payment_Tab.BV_Amount, " +
    //                  " Cal_Payment_Tab.Admin, Cal_Payment_Tab.TDS, Cal_Payment_Tab.WelFair, Cal_Payment_Tab.Final_Amount, Cal_Payment_Tab.Entry_Date,  " +
    //                  " Cal_Payment_Tab.Cal_Date, Cal_Payment_Tab.Chq_No, Cal_Payment_Tab.Chq_Issue_date, Cal_Payment_Tab.Chq_Remark,  " +
    //                  " Cal_Payment_Tab.Grwth_Amt, Cal_Payment_Tab.Tot_User, Cal_Payment_Tab.award_id, Cal_Payment_Tab.rewarded, Cal_Payment_Tab.TDS_Per,  " +
    //                  " Cal_Payment_Tab.Admin_Per,Cal_Payment_Tab.Lvl1 + Cal_Payment_Tab.Lvl2+ Cal_Payment_Tab.Lvl3+ Cal_Payment_Tab.Lvl4+ Cal_Payment_Tab.Lvl5+ Cal_Payment_Tab.Lvl6 AS Lvl, Registration.status " +
    //                  " FROM         Cal_Payment_Tab INNER JOIN " +
    //                  " Registration ON Cal_Payment_Tab.User_Id = Registration.user_id " +
    //                  " where (''='" + User_Id + "' or '" + User_Id + "' is null or  Cal_Payment_Tab.User_Id='" + User_Id + "') and  ((''='" + Datefrom + "' or '" + Datefrom + "' is null or Cal_Payment_Tab.Cal_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (''='" + Dateto + "' or '" + Dateto + "' is null or Cal_Payment_Tab.Cal_Date<='" + dto.ToString("MM/dd/yyyy") + "') and CONVERT(numeric(18,2),Cal_Payment_Tab.BV_Amount) != 0.00) " + Condition + ") Cal_Tab ";
    //        //CalCount = Convert.ToInt32(SQL_DB.ExecuteScalar( "Select count(*) from (SELECT row_number() over(order by tbl_id) as Row_No ,Cal_Payment_Tab.tbl_id, Cal_Payment_Tab.ID, Cal_Payment_Tab.Left_Child_Current_Date, Cal_Payment_Tab.Right_Child_Current_Date,  Cal_Payment_Tab.Paired_Current_Date, Cal_Payment_Tab.Leps_Bv_Current_Date, Cal_Payment_Tab.BV_Amount, Cal_Payment_Tab.Admin, Cal_Payment_Tab.TDS, Cal_Payment_Tab.WelFair, Cal_Payment_Tab.Final_Amount, Cal_Payment_Tab.Entry_Date, Cal_Payment_Tab.Cal_Date, Cal_Payment_Tab.Referal_amt, Cal_Payment_Tab.Binary_Amt,  Cal_Payment_Tab.User_Id, Registration.Status ,Registration.name FROM   Cal_Payment_Tab INNER JOIN Registration ON Cal_Payment_Tab.User_Id = Registration.user_id  where (''='" + User_Id + "' or '" + User_Id + "' is null or  Cal_Payment_Tab.User_Id='" + User_Id + "') and  ((''='" + Datefrom + "' or '" + Datefrom + "' is null or Cal_Payment_Tab.Cal_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (''='" + Dateto + "' or '" + Dateto + "' is null or Cal_Payment_Tab.Cal_Date<='" + dto.ToString("MM/dd/yyyy") + "')) " + Condition + ") Cal_Tab    "));
    //        CalCount = Convert.ToInt32(SQL_DB.ExecuteScalar(s));
    //        return CalCount;
    //        //return Convert.ToInt32(SQL_DB.ExecuteScalar("select count(*) from registration"));
    //    }
    //    //public static DataTable GetCalData(string User_Id, string Datefrom, string Dateto, string Condition, int maximumRows, int startRowIndex)
    //    //{
    //    //    if (startRowIndex > 0)
    //    //        startRowIndex = GetPageIndex(maximumRows, startRowIndex);
    //    //    if (startRowIndex == 0)
    //    //        startRowIndex = 1;

    //    //    if (Datefrom != "" && Datefrom!=" ")
    //    //    {
              
    //    //        dfrom = Convert.ToDateTime(Datefrom);
    //    //        Datefrom = dfrom.ToString("MM/dd/yyyy");
    //    //    }
    //    //    if (Dateto != "" && Dateto!=" ")
    //    //    {
    //    //        string[] str = Dateto.Split('/');
    //    //        dto = Convert.ToDateTime(Dateto);
    //    //        Dateto = dto.ToString("MM/dd/yyyy");
    //    //    }
    //    //    DataSet ds = new DataSet();
    //    //    string s = "Select * from (SELECT row_number() over(order by tbl_id) as Row_No ,Cal_Payment_Tab.tbl_id, Cal_Payment_Tab.ID, Cal_Payment_Tab.Left_Child_Current_Date, Cal_Payment_Tab.Right_Child_Current_Date,  Cal_Payment_Tab.Paired_Current_Date, Cal_Payment_Tab.Leps_Bv_Current_Date, Cal_Payment_Tab.BV_Amount, Cal_Payment_Tab.Admin, Cal_Payment_Tab.TDS, Cal_Payment_Tab.WelFair, Cal_Payment_Tab.Final_Amount, Cal_Payment_Tab.Entry_Date, Cal_Payment_Tab.Cal_Date, Cal_Payment_Tab.Referal_amt, Cal_Payment_Tab.Binary_Amt,  Cal_Payment_Tab.User_Id, Registration.Status ,Registration.name FROM   Cal_Payment_Tab INNER JOIN Registration ON Cal_Payment_Tab.User_Id = Registration.user_id  where (''='" + User_Id + "' or '" + User_Id + "' is null or  Cal_Payment_Tab.User_Id='" + User_Id + "') and  ((''='" + Datefrom + "' or '" + Datefrom + "' is null or Cal_Payment_Tab.Cal_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (''='" + Dateto + "' or '" + Dateto + "' is null or Cal_Payment_Tab.Cal_Date<='" + dto.ToString("MM/dd/yyyy") + "')) " + Condition + ") Cal_Tab where Row_No>(" + (startRowIndex - 1) * maximumRows + ") and Row_No<=(" + (startRowIndex) * maximumRows + ")     order by Cal_Tab.Cal_Date ";
    //    //    SQL_DB.GetDA("Select * from (SELECT row_number() over(order by tbl_id) as Row_No ,Cal_Payment_Tab.PrimiumAmt,Cal_Payment_Tab.ZoneAmt,Cal_Payment_Tab.Left_Pv,Cal_Payment_Tab.Right_Pv,Cal_Payment_Tab.tbl_id, Cal_Payment_Tab.ID, Cal_Payment_Tab.Left_Child_Current_Date, Cal_Payment_Tab.Right_Child_Current_Date,  Cal_Payment_Tab.Paired_Current_Date, Cal_Payment_Tab.Leps_Bv_Current_Date, Cal_Payment_Tab.BV_Amount, Cal_Payment_Tab.Admin, Cal_Payment_Tab.TDS, Cal_Payment_Tab.WelFair, Cal_Payment_Tab.Final_Amount, Cal_Payment_Tab.Entry_Date, Cal_Payment_Tab.Cal_Date, Cal_Payment_Tab.Referal_amt, Cal_Payment_Tab.Binary_Amt,  Cal_Payment_Tab.User_Id, Registration.Status ,Registration.name FROM   Cal_Payment_Tab INNER JOIN Registration ON Cal_Payment_Tab.User_Id = Registration.user_id  where (''='" + User_Id + "' or '" + User_Id + "' is null or  Cal_Payment_Tab.User_Id='" + User_Id + "') and  ((''='" + Datefrom + "' or '" + Datefrom + "' is null or Cal_Payment_Tab.Cal_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (''='" + Dateto + "' or '" + Dateto + "' is null or Cal_Payment_Tab.Cal_Date<='" + dto.ToString("MM/dd/yyyy") + "')) " + Condition + ") Cal_Tab where Row_No>(" + (startRowIndex - 1) * maximumRows + ") and Row_No<=(" + (startRowIndex) * maximumRows + ")     order by Cal_Tab.Cal_Date ").Fill(ds, "1");
    //    //    return ds.Tables[0];
    //    //}
    //    //public static int CalDataCount(string User_Id, string Datefrom, string Dateto, string Condition)
    //    //{
    //    //    if (Datefrom != "" && Datefrom != " ")
    //    //    {
             
    //    //        dfrom = Convert.ToDateTime(Datefrom);
    //    //        Datefrom = dfrom.ToString("MM/dd/yyyy");
    //    //    }
    //    //    if (Dateto != "" && Dateto != " ")
    //    //    {
              
    //    //        dto = Convert.ToDateTime(Dateto);
    //    //        Dateto = dto.ToString("MM/dd/yyyy");
    //    //    }

    //    //    CalCount = Convert.ToInt32(SQL_DB.ExecuteScalar( "Select count(*) from (SELECT row_number() over(order by tbl_id) as Row_No ,Cal_Payment_Tab.tbl_id, Cal_Payment_Tab.ID, Cal_Payment_Tab.Left_Child_Current_Date, Cal_Payment_Tab.Right_Child_Current_Date,  Cal_Payment_Tab.Paired_Current_Date, Cal_Payment_Tab.Leps_Bv_Current_Date, Cal_Payment_Tab.BV_Amount, Cal_Payment_Tab.Admin, Cal_Payment_Tab.TDS, Cal_Payment_Tab.WelFair, Cal_Payment_Tab.Final_Amount, Cal_Payment_Tab.Entry_Date, Cal_Payment_Tab.Cal_Date, Cal_Payment_Tab.Referal_amt, Cal_Payment_Tab.Binary_Amt,  Cal_Payment_Tab.User_Id, Registration.Status ,Registration.name FROM   Cal_Payment_Tab INNER JOIN Registration ON Cal_Payment_Tab.User_Id = Registration.user_id  where (''='" + User_Id + "' or '" + User_Id + "' is null or  Cal_Payment_Tab.User_Id='" + User_Id + "') and  ((''='" + Datefrom + "' or '" + Datefrom + "' is null or Cal_Payment_Tab.Cal_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (''='" + Dateto + "' or '" + Dateto + "' is null or Cal_Payment_Tab.Cal_Date<='" + dto.ToString("MM/dd/yyyy") + "')) " + Condition + ") Cal_Tab    "));
    //    //    return CalCount;
    //    //    //return Convert.ToInt32(SQL_DB.ExecuteScalar("select count(*) from registration"));
    //    //}

    //    public static DataTable GetAdminTransactgion(string User_Id, string Datefrom, string Dateto,string TransId, int maximumRows, int startRowIndex)
    //    {
    //        if (startRowIndex > 0)
    //            startRowIndex = GetPageIndex(maximumRows, startRowIndex);
    //        if (startRowIndex == 0)
    //            startRowIndex = 1;
    //        DataSet ds = new DataSet();
            
    //        SQL_DB.GetDA("Select * from (SELECT   row_number() over(order by F_Transa_Tab.tbl_id) as Row_No ,  F_Transa_Tab.tbl_id, F_Transa_Tab.Tra_ID, F_Transa_Tab.Tra_Date, F_Transa_Tab.Tra_Name, F_Transa_Tab.Cr_Amt, F_Transa_Tab.Dr_Amt, F_Transa_Tab.Remarks, Registration.name, F_Transa_Tab.User_Id FROM   F_Transa_Tab INNER JOIN Registration ON F_Transa_Tab.User_Id = Registration.user_id ) Tab  where Row_No>(" + (startRowIndex - 1) * maximumRows + ") and Row_No<=(" + (startRowIndex) * maximumRows + ") and (' '='" + TransId + "' or Tab.Tra_ID='" + TransId + "') and  (''='" + User_Id + "' or '" + User_Id + "' is null or User_Id='" + User_Id + "') and  ((''='" + Datefrom + "' or '" + Datefrom + "' is null or Tra_Date>='" + Datefrom + "') and (''='" + Dateto + "' or '" + Dateto + "' is null or Tra_Date<='" + Dateto + "')) order by Tra_Date").Fill(ds, "1");
    //        return ds.Tables[0];
    //    }
    //    public static int GetAdminTransactgionCount(string User_Id, string Datefrom, string Dateto, string TransId)
    //    {
    //        TransCount = Convert.ToInt32(SQL_DB.ExecuteScalar("Select count(*) from (SELECT    F_Transa_Tab.Tra_ID, F_Transa_Tab.Tra_Date,   F_Transa_Tab.User_Id FROM   F_Transa_Tab INNER JOIN Registration ON F_Transa_Tab.User_Id = Registration.user_id ) Tab  where (''='" + TransId + "' or Tab.Tra_ID='" + TransId + "') and (''='" + User_Id + "' or '" + User_Id + "' is null or User_Id='" + User_Id + "') and  ((''='" + Datefrom + "' or '" + Datefrom + "' is null or Tra_Date>='" + Datefrom + "') and (''='" + Dateto + "' or '" + Dateto + "' is null or Tra_Date<='" + Dateto + "')) "));
    //        return TransCount;
    //    }
    //    public static DataTable GetTDS(string User_Id, string DateFrom, string DateTo, int maximumRows, int startRowIndex)
    //    {
    //        DataSet ds = new DataSet();
    //        if (DateTo == " " || DateTo == null)
    //            dto = new DateTime(2010, 2, 2);
    //        else
    //            dto = Convert.ToDateTime(DateTo);
    //        if (DateFrom == " " || DateFrom == null)
    //            dfrom = new DateTime(2010, 2, 2);
    //        else
    //            dfrom = Convert.ToDateTime(DateFrom);
    //        if (startRowIndex > 0)
    //            startRowIndex = GetPageIndex(maximumRows, startRowIndex);
    //        if (startRowIndex == 0)
    //            startRowIndex = 1;
    //        string g = "select * from ( " +
    //                 "Select row_number() over(order by User_Id) as Row_No,* from (" +
    //                 "select Registration.name,Tab.User_Id,sum(Tab.Admin) as Admin,sum(Tab.TDS)as TDS from (" +
    //                 "SELECT    User_Id,Admin, TDS FROM   Cal_Payment_Tab where tds>0 and (''='" + DateFrom + "' or  Entry_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (''='" + DateTo + "' or Entry_Date<='" + dto.ToString("MM/dd/yyyy") + "')" +
    //                 //"union all " +
    //                 //"SELECT [User_Id],[Admin],[TDS]	 FROM [T_Salary] where tds>0 and  (''='" + DateFrom + "' or  Entry_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (''='" + DateTo + "' or Entry_Date<='" + dto.ToString("MM/dd/yyyy") + "')" +
    //                 ") as Tab " +
    //                 "inner join Registration on registration.User_Id=Tab.User_Id where (''='" + User_Id + "' or registration.user_id='" + User_Id + "') group by Registration.name,Tab.User_Id  " +
    //                 ") as T )as Tab where  Tab.Row_No>" + (startRowIndex - 1) * maximumRows + " and Tab.Row_No<=" + (startRowIndex) * maximumRows;
    //       SQL_DB.GetDA(g).Fill(ds, "1");
    //        return ds.Tables["1"];
    //    }
    //    public static int GetTDSCount(string User_Id, string DateFrom, string DateTo)
    //    {
    //        if (DateTo == " " || DateTo == null)
    //            dto = new DateTime(2010, 2, 2);
    //        else
    //            dto = Convert.ToDateTime(DateTo);
    //        if (DateFrom == " " || DateFrom == null)
    //            dfrom = new DateTime(2010, 2, 2);
    //        else
    //            dfrom = Convert.ToDateTime(DateFrom);
    //        string g = "select count(*)  from ( " +
    //              "Select row_number() over(order by User_Id) as Row_No,* from (" +
    //              "select Registration.name,Tab.User_Id,sum(Tab.Admin) as Admin,sum(Tab.TDS)as TDS from (" +
    //              "SELECT    User_Id,Admin, TDS FROM   Cal_Payment_Tab where  tds>0 and (''='" + DateFrom + "' or  Entry_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (''='" + DateTo + "' or Entry_Date<='" + dto.ToString("MM/dd/yyyy") + "')" +
    //              //"union all " +
    //              //"SELECT [User_Id],[Admin],[TDS]	 FROM [T_Salary] where  tds>0 and (''='" + DateFrom + "' or  Entry_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (''='" + DateTo + "' or Entry_Date<='" + dto.ToString("MM/dd/yyyy") + "')" +
    //              ") as Tab " +
    //              "inner join Registration on registration.User_Id=Tab.User_Id where (''='" + User_Id + "' or registration.user_id='" + User_Id + "') group by Registration.name,Tab.User_Id  " +
    //              ") as T )as Tab  ";
    //        TDSCount = Convert.ToInt32(SQL_DB.ExecuteScalar(g));
    //        return TDSCount;

    //    }
    //    public static DataTable GetAdmin(string User_Id, string DateFrom, string DateTo, int maximumRows, int startRowIndex)
    //    {
    //        DataSet ds = new DataSet();
    //        if (DateTo == " " || DateTo == null)
    //            dto = new DateTime(2010, 2, 2);
    //        else
    //            dto = Convert.ToDateTime(DateTo);
    //        if (DateFrom == " " || DateFrom == null)
    //            dfrom = new DateTime(2010, 2, 2);
    //        else
    //            dfrom = Convert.ToDateTime(DateFrom);
    //        if (startRowIndex > 0)
    //            startRowIndex = GetPageIndex(maximumRows, startRowIndex);
    //        if (startRowIndex == 0)
    //            startRowIndex = 1;
    //        SQL_DB.GetDA("select * from (SELECT     row_number() over(order by Registration.user_id ) as Row_No,Registration.user_id, Registration.name, sum(Cal_Payment_Tab.Admin) As Admin FROM  Registration INNER JOIN Cal_Payment_Tab ON Registration.user_id = Cal_Payment_Tab.User_Id where  ((' '='" + DateFrom + "' or Cal_Payment_Tab.Cal_date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (' '='" + DateTo + "' or Cal_Payment_Tab.Cal_date<='" + dto.ToString("MM/dd/yyyy") + "')) and Cal_Payment_Tab.Admin>0  group by  Registration.user_id, Registration.name) as Tab where Tab.Row_No>" + (startRowIndex - 1) * maximumRows + " and Tab.Row_No<=" + (startRowIndex) * maximumRows + " and (''='" + User_Id + "' or Tab.User_Id='" + User_Id + "')").Fill(ds, "1");
    //        return ds.Tables["1"];
    //    }
    //    public static int GetAdminCount(string User_Id, string DateFrom, string DateTo)
    //    {
    //        if (DateTo == " " || DateTo == null)
    //            dto = new DateTime(2010, 2, 2);
    //        else
    //            dto = Convert.ToDateTime(DateTo);
    //        if (DateFrom == " " || DateFrom == null)
    //            dfrom = new DateTime(2010, 2, 2);
    //        else
    //            dfrom = Convert.ToDateTime(DateFrom);
    //        AdminCount= Convert.ToInt32(SQL_DB.ExecuteScalar("select count(*) from (SELECT     Registration.user_id, Registration.name, sum(Cal_Payment_Tab.Admin) As Admin FROM  Registration INNER JOIN Cal_Payment_Tab ON Registration.user_id = Cal_Payment_Tab.User_Id where  ((' '='" + DateFrom + "' or Cal_Payment_Tab.Cal_date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (' '='" + DateTo + "' or Cal_Payment_Tab.Cal_date<='" + dto.ToString("MM/dd/yyyy") + "')) and  Cal_Payment_Tab.Admin>0  group by  Registration.user_id, Registration.name) as Tab where  (''='" + User_Id + "' or Tab.User_Id='" + User_Id + "')"));
    //        return AdminCount;
    //    }
    //    public static DataTable GetAccSummary(string Option, string User_Id, string DateFrom, string DateTo,string TraType, int maximumRows, int startRowIndex, string Trans_Id)
    //    {
    //        DataSet ds = new DataSet();
    //        if (DateTo == " " || DateTo == null)
    //            dto = new DateTime(2010, 2, 2);
    //        else
    //            dto = Convert.ToDateTime(DateTo);
    //        if (DateFrom == " " || DateFrom == null)
    //            dfrom = new DateTime(2010, 2, 2);
    //        else
    //            dfrom = Convert.ToDateTime(DateFrom);
    //        if (startRowIndex > 0)
    //            startRowIndex = GetPageIndex(maximumRows, startRowIndex);
    //        if (startRowIndex == 0)
    //            startRowIndex = 1;
    //        //****Deepak********            
    //        string Qry = "select * from (SELECT row_number() over(order by Tra_ID ) as Row_No,[Tra_ID],[User_Id],[Tra_Date] ,Tra_Name,[Cr_Amt],[Dr_Amt],[Remarks] FROM [F_Transa_Tab] where (''='" + User_Id + "' or User_Id='" + User_Id + "')  and (''='" + Trans_Id + "' or F_Transa_Tab.Tra_ID='" + Trans_Id + "') and ((' '='" + DateFrom + "' or F_Transa_Tab.Tra_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (' '='" + DateTo + "' or F_Transa_Tab.Tra_Date<='" + dto.ToString("MM/dd/yyyy") + "')) " + Option + " ) as Tab where Tab.Row_No>" + (startRowIndex - 1) * maximumRows + " and Tab.Row_No<=" + (startRowIndex) * maximumRows;
    //        SQL_DB.GetDA("select * from (SELECT row_number() over(order by Tra_ID ) as Row_No,[Tra_ID],[User_Id],[Tra_Date] ,Tra_Name,[Cr_Amt],[Dr_Amt],[Remarks] FROM [F_Transa_Tab] where (''='" + User_Id + "' or User_Id='" + User_Id + "')  and (''='" + Trans_Id + "' or F_Transa_Tab.Tra_ID='" + Trans_Id + "') and ((' '='" + DateFrom + "' or F_Transa_Tab.Tra_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (' '='" + DateTo + "' or F_Transa_Tab.Tra_Date<='" + dto.ToString("MM/dd/yyyy") + "')) and (''='"+TraType+"' or  Tra_Name='"+TraType+"') " + Option + " ) as Tab where Tab.Row_No>" + (startRowIndex - 1) * maximumRows + " and Tab.Row_No<=" + (startRowIndex) * maximumRows).Fill(ds, "1");
    //        return ds.Tables["1"];
    //    }
    //    public static int GetAccSummaryCount(string Option, string User_Id, string DateFrom, string DateTo, string Trans_Id, string TraType)
    //    {
    //        if (DateTo == " " || DateTo == null)
    //            dto = new DateTime(2010, 2, 2);
    //        else
    //            dto = Convert.ToDateTime(DateTo);
    //        if (DateFrom == " " || DateFrom == null)
    //            dfrom = new DateTime(2010, 2, 2);
    //        else
    //            dfrom = Convert.ToDateTime(DateFrom);

    //        AccSMCount = Convert.ToInt32(SQL_DB.ExecuteScalar("select count(*) from (SELECT row_number() over(order by Tra_ID ) as Row_No,[Tra_ID],[User_Id],[Tra_Date] ,Tra_Name,[Cr_Amt],[Dr_Amt],[Remarks] FROM [F_Transa_Tab] where (''='" + User_Id + "' or User_Id='" + User_Id + "')  and (''='" + Trans_Id + "' or F_Transa_Tab.Tra_ID='" + Trans_Id + "') and ((' '='" + DateFrom + "' or F_Transa_Tab.Tra_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (' '='" + DateTo + "' or F_Transa_Tab.Tra_Date<='" + dto.ToString("MM/dd/yyyy") + "')) and (''='" + TraType + "' or  Tra_Name='" + TraType + "')  " + Option + " ) as Tab"));
    //       return AccSMCount;
    //    }
    //    public static DataTable GetAccSummaryMember(string Option, string User_Id, string DateFrom, string DateTo, int maximumRows, int startRowIndex, string Trans_Id)
    //    {
    //        DataSet ds = new DataSet();
    //        if (DateTo == " " || DateTo == null)
    //            dto = new DateTime(2010, 2, 2);
    //        else
    //            dto = Convert.ToDateTime(DateTo);
    //        if (DateFrom == " " || DateFrom == null)
    //            dfrom = new DateTime(2010, 2, 2);
    //        else
    //            dfrom = Convert.ToDateTime(DateFrom);
    //        if (startRowIndex > 0)
    //            startRowIndex = GetPageIndex(maximumRows, startRowIndex);
    //        if (startRowIndex == 0)
    //            startRowIndex = 1;
    //        //****Deepak********            
    //        string Qry = "select * from (SELECT row_number() over(order by Tra_ID ) as Row_No,[Tra_ID],[User_Id],[Tra_Date] ,Tra_Name,[Cr_Amt],[Dr_Amt],[Remarks] FROM [F_Transa_Tab] where (''='" + User_Id + "' or User_Id='" + User_Id + "')  and (''='" + Trans_Id + "' or F_Transa_Tab.Tra_ID='" + Trans_Id + "') and ((' '='" + DateFrom + "' or F_Transa_Tab.Tra_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (' '='" + DateTo + "' or F_Transa_Tab.Tra_Date<='" + dto.ToString("MM/dd/yyyy") + "')) " + Option + " ) as Tab where Tab.Row_No>" + (startRowIndex - 1) * maximumRows + " and Tab.Row_No<=" + (startRowIndex) * maximumRows;
    //        SQL_DB.GetDA("select * from (SELECT row_number() over(order by Tra_ID ) as Row_No,[Tra_ID],[User_Id],[Tra_Date] ,Tra_Name,[Cr_Amt],[Dr_Amt],[Remarks] FROM [F_Transa_Tab] where (''='" + User_Id + "' or User_Id='" + User_Id + "')  and (''='" + Trans_Id + "' or F_Transa_Tab.Tra_ID='" + Trans_Id + "') and ((' '='" + DateFrom + "' or F_Transa_Tab.Tra_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (' '='" + DateTo + "' or F_Transa_Tab.Tra_Date<='" + dto.ToString("MM/dd/yyyy") + "'))  " + Option + " ) as Tab where Tab.Row_No>" + (startRowIndex - 1) * maximumRows + " and Tab.Row_No<=" + (startRowIndex) * maximumRows).Fill(ds, "1");
    //        return ds.Tables["1"];
    //    }
    //    public static int GetAccSummaryMemberCount(string Option, string User_Id, string DateFrom, string DateTo, string Trans_Id)
    //    {
    //        if (DateTo == " " || DateTo == null)
    //            dto = new DateTime(2010, 2, 2);
    //        else
    //            dto = Convert.ToDateTime(DateTo);
    //        if (DateFrom == " " || DateFrom == null)
    //            dfrom = new DateTime(2010, 2, 2);
    //        else
    //            dfrom = Convert.ToDateTime(DateFrom);

    //        AccSMCount = Convert.ToInt32(SQL_DB.ExecuteScalar("select count(*) from (SELECT row_number() over(order by Tra_ID ) as Row_No,[Tra_ID],[User_Id],[Tra_Date] ,Tra_Name,[Cr_Amt],[Dr_Amt],[Remarks] FROM [F_Transa_Tab] where (''='" + User_Id + "' or User_Id='" + User_Id + "')  and (''='" + Trans_Id + "' or F_Transa_Tab.Tra_ID='" + Trans_Id + "') and ((' '='" + DateFrom + "' or F_Transa_Tab.Tra_Date>='" + dfrom.ToString("MM/dd/yyyy") + "') and (' '='" + DateTo + "' or F_Transa_Tab.Tra_Date<='" + dto.ToString("MM/dd/yyyy") + "'))   " + Option + " ) as Tab"));
    //        return AccSMCount;
    //    }
    //    public static void sendMail(string server, string userID, string password, string sendTo, string body, string subject)
    //    {
    //        try
    //        {
    //            using (System.Net.Mail.MailMessage mess = new System.Net.Mail.MailMessage())
    //            {
    //                System.Net.Mail.SmtpClient sc = new System.Net.Mail.SmtpClient();
    //                mess.To.Add(sendTo);
    //                mess.Subject = subject;
    //                mess.Body = body;
    //                mess.IsBodyHtml = true;
    //                mess.From = new System.Net.Mail.MailAddress(userID);
    //                sc.Host = server;
    //                sc.Port = 25;
    //                sc.UseDefaultCredentials = false;
    //                sc.Credentials = new System.Net.NetworkCredential(userID, password);
    //                sc.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
    //                sc.Send(mess);
    //            }
    //        }
    //        catch (Exception)
    //        {
                
    //        }
    //    }

    //    public static void UpdateForRefferalIncome(string Refferal)
    //    {
    //        SqlParameter ParamUser_Id = new SqlParameter("User_Id", Refferal);
    //        Procedure.ExecuteProcedure("UpdateUserForZoneIncome", ParamUser_Id);
    //    }

    //    public static string GetNewCode(string Keycol)
    //    {
    //        return Convert.ToString(SQL_DB.ExecuteScalar("SELECT [Prefix]+convert(varchar,[Start]) as id FROM [Code_Gen] where Keycol='"+Keycol+"'"));   
    //    }
    //    public static void SetNewCode(string Keycol)
    //    {
    //        SQL_DB.ExecuteNonQuery("Update Code_Gen Set [Start]=[Start]+1 where Keycol='"+Keycol+"'");
    //    }

    //    public static string MobileRecharge(string opcode, string MobileNo,int amount)
    //    {
    //        string str = "",results="";
    //        try
    //        {

    //            str = "http://dishaeservices.org/ApiService/RechargeService.aspx?userid=MD23755562&pass=113222&mno="+MobileNo+"&op="+opcode+"&amt="+amount+"";
    //            HttpWebRequest httpreq = (HttpWebRequest)WebRequest.Create(str);
    //            HttpWebResponse httpres = (HttpWebResponse)httpreq.GetResponse();
    //            StreamReader sr = new StreamReader(httpres.GetResponseStream());                
    //            results = sr.ReadToEnd();
    //            sr.Close();

    //        }
    //        catch
    //        {
    //        }
    //        return results;
    //    }
    //}
    //public class Procedure
    //{      
    //    private static SqlCommand cmd;
    //    private static SqlConnection con;
    //    private static SqlDataAdapter adp;
    //    public static void ExecuteProcedure(string ProcedureName,params   SqlParameter [] ProParameters)
    //    {          
    //        con = SQL_DB.CreateConnection();
    //        cmd = SQL_DB.CreateCommand(con, ProcedureName);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddRange(ProParameters);
    //        con.Open();
    //        cmd.ExecuteNonQuery();
    //        con.Close();
    //    }
    //    public static DataTable GetProcedureData(string ProcedureName, params   SqlParameter[] ProParameters)
    //    {
    //        con = SQL_DB.CreateConnection();
    //        cmd = SQL_DB.CreateCommand(con, ProcedureName);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddRange(ProParameters);
    //        adp = new SqlDataAdapter(cmd);
    //        DataTable ds = new DataTable();
    //        adp.Fill(ds);
    //        return ds;
    //    }


    //}
    //public class MyUtilities
    //{
    //    public static string SplitString(string str, string delmeters)
    //    {
    //        char[] delimiterChars = { ' ', ',', '.', ':', '\t' };

    //        string text = "one\ttwo three:four,five six seven";
    //        System.Console.WriteLine("Original text: '{0}'", text);

    //        string[] words = text.Split(delimiterChars);
    //        System.Console.WriteLine("{0} words in text:", words.Length);

    //        foreach (string s in words)
    //        {
    //            System.Console.WriteLine(s);
    //        }

    //        // Keep the console window open in debug mode.
    //        System.Console.WriteLine("Press any key to exit.");
    //        System.Console.ReadKey();
    //        return str;
    //    }
    //    public static void FillDropDownList(DataSet ds, string ValField, string NmField, DropDownList MyDDL)
    //    {
    //        MyDDL.DataSource = ds.Tables[0];
    //        MyDDL.DataTextField = NmField;
    //        MyDDL.DataValueField = ValField;
    //        MyDDL.DataBind();
    //    }
    //    public static void FillDropDownList(DataSet ds, string ValField, string NmField, DropDownList MyDDL, string RowfilterString)
    //    {
    //        DataView dv = ds.Tables[0].DefaultView;
    //        dv.RowFilter = RowfilterString;
    //        MyDDL.DataSource = dv.ToTable();
    //        MyDDL.DataTextField = NmField;
    //        MyDDL.DataValueField = ValField;
    //        MyDDL.DataBind();
    //    }
    //    public static void FillDDLInsertZeroIndexString(DataSet ds, string ValField, string NmField, DropDownList MyDDL, string ZeroIndexString)
    //    {            
    //        DataRow dr = ds.Tables[0].NewRow();
    //        dr[0] = 0;
    //        dr[1] = ZeroIndexString ;
    //        ds.Tables[0].Rows.InsertAt(dr, 0);
    //        MyDDL.DataSource = ds.Tables[0];
    //        MyDDL.DataTextField = NmField;
    //        MyDDL.DataValueField = ValField;
    //        MyDDL.DataBind();
    //    }
    //    public static void FillGrid(DataSet ds, GridView MyGrid)
    //    {
    //        MyGrid.DataSource = ds.Tables[0];
    //        MyGrid.DataBind();
    //    }
    //}

   
}

