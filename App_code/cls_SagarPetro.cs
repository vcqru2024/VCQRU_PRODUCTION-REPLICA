using Microsoft.Practices.EnterpriseLibrary.Data;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_SagarPetro
/// </summary>
public class cls_SagarPetro
{
    private static Database database = DatabaseFactory.CreateDatabase();
    private static DbCommand dbCommand;
    private static DataAdapter adp;
    private static DataSet ds;
    private static DataTable dt;


    public bool Validatemobilenumber(string Mobilneno)
    {
        DataTable dt = SQL_DB.ExecuteDataTable("select*from tbl_users_SP where Mobile_Number='"+ Mobilneno + "' and IsActive=1 and IsDelete=0");
        if (dt.Rows.Count == 0)
            return true;
        else
            return false;
    }

   
    public DataTable RegisterUser(string Procedurename, string Mobile, string Email, string Name, string District, string State, string Designation, string Role, string Comp_id)
    {

        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@UserName", DbType.String, Name);
        database.AddInParameter(dbCommand, "@UserEmail", DbType.String, Email);
        database.AddInParameter(dbCommand, "@Mobile_Number", DbType.String, Mobile);
        database.AddInParameter(dbCommand, "@District", DbType.String, District);
        database.AddInParameter(dbCommand, "@StateName", DbType.String, State);
        database.AddInParameter(dbCommand, "@Designation", DbType.String, Designation);
        database.AddInParameter(dbCommand, "@City", DbType.String, District);
        database.AddInParameter(dbCommand, "@User_Type", DbType.String, Role);
        database.AddInParameter(dbCommand, "@MappedCompid", DbType.String, Comp_id);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }

    public DataTable Getheadmachinicname(string Procedurename, int headmachanicid , string Comp_id)
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@HeadMechanicName", DbType.String, headmachanicid);
        database.AddInParameter(dbCommand, "@companyid", DbType.String, Comp_id);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }

    //public DataTable Headmachanicreg(string Procedurename, string userName, string userEmail, string userMobile, string userAddress, string userDistrict, string userState, string userCity, string userPin, string userType, string userDOB, string gender, string maritalStatus, string roleId, string companyId)
    public DataTable Headmachanicreg(string Procedurename, string userName, string userMobile, string userDistrict, string userState, string designation, string userAddress, string userCity, string userPin, int Machanictype, string userDOB, string gender, string maritalStatus, string roleId, string Headmachanicname, string userEmail, string companyId)
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@UserName", DbType.String, userName);
        database.AddInParameter(dbCommand, "@Mobile_Number", DbType.String, userMobile);
        database.AddInParameter(dbCommand, "@District", DbType.String, userDistrict);
        database.AddInParameter(dbCommand, "@StateName", DbType.String, userState);
        database.AddInParameter(dbCommand, "@Designation", DbType.String, designation);
        database.AddInParameter(dbCommand, "@Complete_Address", DbType.String, userAddress);
        database.AddInParameter(dbCommand, "@City", DbType.String, userCity);
        database.AddInParameter(dbCommand, "@Pincode", DbType.String, userPin);
        database.AddInParameter(dbCommand, "@Mechanic_Type", DbType.String, Machanictype);
        database.AddInParameter(dbCommand, "@User_DOB", DbType.String, userDOB);
        database.AddInParameter(dbCommand, "@Gender", DbType.String, gender);
        database.AddInParameter(dbCommand, "@Marital_Status", DbType.String, maritalStatus);
        database.AddInParameter(dbCommand, "@User_Type", DbType.String, roleId);
        database.AddInParameter(dbCommand, "@Head_Mechanic_Name", DbType.String, Headmachanicname);
        database.AddInParameter(dbCommand, "@UserEmail", DbType.String, userEmail);
        database.AddInParameter(dbCommand, "@MappedCompid", DbType.String, companyId);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }

    public DataTable Assismachanicreg(string Procedurename, string userName, string userMobile, string userDistrict, string userState, string designation, string userAddress, string userCity, string userPin, int Machanictype, string userDOB, string gender, string maritalStatus, string roleId, string Headmachanicname, string userEmail, string companyId)
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@UserName", DbType.String, userName);
        database.AddInParameter(dbCommand, "@Mobile_Number", DbType.String, userMobile);
        database.AddInParameter(dbCommand, "@District", DbType.String, userDistrict);
        database.AddInParameter(dbCommand, "@StateName", DbType.String, userState);
        database.AddInParameter(dbCommand, "@Designation", DbType.String, designation);
        database.AddInParameter(dbCommand, "@Complete_Address", DbType.String, userAddress);
        database.AddInParameter(dbCommand, "@City", DbType.String, userCity);
        database.AddInParameter(dbCommand, "@Pincode", DbType.String, userPin);
        database.AddInParameter(dbCommand, "@Mechanic_Type", DbType.String, Machanictype);
        database.AddInParameter(dbCommand, "@User_DOB", DbType.String, userDOB);
        database.AddInParameter(dbCommand, "@Gender", DbType.String, gender);
        database.AddInParameter(dbCommand, "@Marital_Status", DbType.String, maritalStatus);
        database.AddInParameter(dbCommand, "@User_Type", DbType.String, roleId);
        database.AddInParameter(dbCommand, "@Head_Mechanic_Name", DbType.String, Headmachanicname);
        database.AddInParameter(dbCommand, "@UserEmail", DbType.String, userEmail);
        database.AddInParameter(dbCommand, "@MappedCompid", DbType.String, companyId);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }


    public DataTable Getloyalitygiftmaster(string Procedurename,  string Comp_id)
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@CompanyId", DbType.String, Comp_id);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
    public DataTable LoginVendor(string Procedurename, string EmailID, int Otp, string Password = "")
    {
        dt = new DataTable();
        dbCommand = database.GetStoredProcCommand(Procedurename);
        database.AddInParameter(dbCommand, "@UserEmail", DbType.String, EmailID);
        database.AddInParameter(dbCommand, "@LoginPassword", DbType.String, Password);
       // database.AddInParameter(dbCommand, "@OTP", DbType.String, Otp);
        dt = database.ExecuteDataSet(dbCommand).Tables[0];
        return dt;
    }
}

public class RegistrationMailsagar
{
    public string Name { get; set; }
    public string Email { get; set; }
    public string Mobile { get; set; }
    public string Subject { get; set; }
    public string LoginID { get; set; }
    public string Password { get; set; }
    public string GetJson()
    {
        RegistrationMailsagar ObjData = new RegistrationMailsagar();
        ObjData.Name = this.Name;
        ObjData.Email = this.Email;
        ObjData.Mobile = this.Mobile;
        ObjData.Subject = this.Subject;
        ObjData.LoginID = this.LoginID;
        ObjData.Password = this.Password;
        string jsonString;
        jsonString = JsonConvert.SerializeObject(ObjData);
        return jsonString;
    }
}