using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

/// <summary>
/// Summary description for cls_patanjali
/// </summary>
public class cls_patanjali
{
    private static Database database = DatabaseFactory.CreateDatabase();
    private static DbCommand dbCommand;
    private static DataAdapter adp;
    private static DataSet ds;
    private static DataTable dt;


    public DataTable Getdatatabele(string Procedurename, string p1 = "", string p2 = "", string p3 = "", string p4 = "", string p5 = "", string p6 = "")
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
    public DataTable RegisterUser(string Procedurename, string Mobile, string Email, string Name,  string Comp_id)
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@UserName", DbType.String, Name);
        database.AddInParameter(dbCommand, "@UserEmail", DbType.String, Email);
        database.AddInParameter(dbCommand, "@UserMobile", DbType.String, Mobile);
       // database.AddInParameter(dbCommand, "@UserRoletype", DbType.String, Role);
        database.AddInParameter(dbCommand, "@MappedCompid", DbType.String, Comp_id);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
    public DataTable SelectUserRole(string Procedurename, int RoleId)
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@Roleid", DbType.String, RoleId);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
    public DataTable InsertUserRole(string Procedurename, string Userroletype)
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@RoleType", DbType.String, Userroletype);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
    public DataTable Updatedeleteuserrole(string Procedurename, int RoleId,string DML)
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@RoleId", DbType.String, RoleId);
        database.AddInParameter(dbCommand, "@DML", DbType.String, DML);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
    public DataTable Getheatmap(string Procedurename, string Comp_id)
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@companyid", DbType.String, Comp_id);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
    public DataTable Validateotpreg(string Procedurename, string MobileNO, string EmailID, string EmailOTP, string MobileOTP)
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@Email", DbType.String, EmailID);
        database.AddInParameter(dbCommand, "@MobileNumber", DbType.String, MobileNO);
        database.AddInParameter(dbCommand, "@EmailOTP", DbType.String, EmailOTP);
        database.AddInParameter(dbCommand, "@MobileOTP", DbType.String, MobileOTP);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
    public DataTable GetRegisteredUserData(string Procedurename, int RoleId)
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@UserRole_id", DbType.String, RoleId);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
    public DataTable GetRegisteredUserData1(string Procedurename, int RoleId, string DML)
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@RoleId", DbType.String, RoleId);
        database.AddInParameter(dbCommand, "@DML", DbType.String, DML);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
    public DataTable LoginVendor(string Procedurename, string EmailID,int Otp, string Password="" )
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@UserEmail", DbType.String, EmailID);
        database.AddInParameter(dbCommand, "@LoginPassword", DbType.String, Password);
        database.AddInParameter(dbCommand, "@OTP", DbType.String, Otp);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
    public DataTable UpdateEmailFLG(string Procedurename, string EmailID,string DML)
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@EmailId", DbType.String, EmailID);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }

   
    public void ExceptionLogs(string txt, string userName, string operation)
    {
        try
        {
            string filein = HttpContext.Current.Server.MapPath("~/");
            string currentDate = DateTime.Now.ToString("yyyyMMdd");
            string path = Path.Combine(filein, "LogManager/Patanjali", "UsersLog_" + currentDate + ".txt");
            string logMessage = string.Format("[{0}]  [{1}]  [{2}]  [{3}]", DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt"), txt, userName, operation);
            using (StreamWriter writer = new StreamWriter(path, true))
            {
                writer.WriteLine(logMessage);
                writer.WriteLine(new string('=', 120));
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}