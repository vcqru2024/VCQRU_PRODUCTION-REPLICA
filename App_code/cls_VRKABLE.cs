using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_VRKABLE
/// </summary>
public class cls_VRKABLE
{
    private static Database database = DatabaseFactory.CreateDatabase();
    private static DbCommand dbCommand;
    private static DataAdapter adp;
    private static DataSet ds;
    private static DataTable dt;

    public DataTable Getdatatabel(string Procedurename, string p1 = "", string p2 = "", string p3 = "", string p4 = "", string p5 = "", string p6 = "")
    {
        if (p3 == "0")
            p3 = null;
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@state", DbType.String, p1);
        database.AddInParameter(dbCommand, "@Vrkabel_User_Type", DbType.String, p2);
        database.AddInParameter(dbCommand, "@ref_cin_number", DbType.String, p3);
        database.AddInParameter(dbCommand, "@comp_id", DbType.String, p6);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
    public DataTable Getvrkableseleteduserdata(string Procedurename, string Para1, string Para2,string Para3)
    {
       
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@Vrkabel_User_Type", DbType.String, Para1);
        database.AddInParameter(dbCommand, "@state", DbType.String, Para2);
        database.AddInParameter(dbCommand, "@Comp_ID", DbType.String, Para3);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
    public DataTable GetvrkableUserDetailswithCinNo(string Procedurename, string Para1, string Para2)
    {

        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@ref_cin_number", DbType.String, Para1);
        database.AddInParameter(dbCommand, "@companyid", DbType.String, Para2);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
    public DataTable GetvrkableUserDetailswithState(string Procedurename, string Para1, string Para2)
    {

        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@state", DbType.String, Para1);
        database.AddInParameter(dbCommand, "@companyid", DbType.String, Para2);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
    public DataTable GetvrkableUserDetailKYC(string Procedurename, string Para1, string Para2, string Para3, string Para4)
    {
        if (Para3 == "0")
            Para3 = null;
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@fromdate", DbType.String, Para1);
        database.AddInParameter(dbCommand, "@todate", DbType.String, Para2);
        database.AddInParameter(dbCommand, "@type", DbType.String, Para3);
        database.AddInParameter(dbCommand, "@companyid", DbType.String, Para4);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
	
	 public DataTable GetvrkableUserTotalUserBydate(string Procedurename, string Para1, string Para2)
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@fromdate", DbType.String, Para1);
        database.AddInParameter(dbCommand, "@todate", DbType.String, Para2);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
    public DataTable GetvrCodeCheckUserWise(string Procedurename, string Para1, string Para2, string Para3, string Para4)
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@Companyid", DbType.String, Para1);
        database.AddInParameter(dbCommand, "@fromdate", DbType.String, Para2);
        database.AddInParameter(dbCommand, "@todate", DbType.String, Para3);
        database.AddInParameter(dbCommand, "@MobileNo", DbType.String, Para4);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
    

    public DataTable GetvrkableGetCheckCodeByProduct(string Procedurename, string Para1, string Para2)
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@Companyid", DbType.String, Para1);
        database.AddInParameter(dbCommand, "@pro_id", DbType.String, Para2);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
}