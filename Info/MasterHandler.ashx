<%@ WebHandler Language="C#" Class="MasterHandler" %>

using System;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using Business9420;
using System.Text.RegularExpressions;
using System.Configuration;
using Business_Logic_Layer;
using System.Net;
using System.Web.SessionState;
using System.Net.Mail;
using DataProvider;
using Newtonsoft.Json;
using WebApplication1;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Net.NetworkInformation;
using Newtonsoft.Json.Linq;



public class MasterHandler : IHttpHandler, IRequiresSessionState
{
    public static StringBuilder sbnews = new StringBuilder();
    public static string server = Convert.ToString(ConfigurationManager.ConnectionStrings["ServerName"].ConnectionString), userID = Convert.ToString(ConfigurationManager.ConnectionStrings["UserName"].ConnectionString), password = Convert.ToString(ConfigurationManager.ConnectionStrings["Password"].ConnectionString);
    public static string strip = "";
    public static string srt = DataProvider.Utility.FindMailBody();
    public static int otpSendTimes = 3;
    public static string[] allcodes = new string[2];
    public static string FieldSeparator = "<@>";



    public class GoogleGeoCodeResponse
    {

        public string status { get; set; }
        public results[] results { get; set; }

    }

    public class results
    {
        public string formatted_address { get; set; }
        public geometry geometry { get; set; }
        public string[] types { get; set; }
        public address_component[] address_components { get; set; }
    }

    public class geometry
    {
        public string location_type { get; set; }
        public location location { get; set; }
    }

    //public class location
    //{
    //    public string lat { get; set; }
    //    public string lng { get; set; }
    //}

    public class address_component
    {
        public string long_name { get; set; }
        public string short_name { get; set; }
        public string[] types { get; set; }
    }

    public string ConsumerDetailsByMobileNoBlugem(string MobileNo, string codeone = "", string codetwo = "", string compid = "")
    {
        string result = "NA";

        DataTable dt = new DataTable();
        // dt = SQL_DB.ExecuteDataTable("select * from M_Consumer where Right(MobileNo,10)='" + MobileNo.Substring(MobileNo.Length - 10, 10).ToString() + "'");
        dt = SQL_DB.ExecuteDataTable("select PinCode,ConsumerName,City,Inox_User_Type,state,SellerName,Other_Role ,Email,Comp_id,Address,UPIId from M_Consumer where Right(MobileNo,10)='" + MobileNo.Substring(MobileNo.Length - 10, 10).ToString() + "'");

        string PinCode = "";
        string ConsumerName = "";
        string City = "";
        string Inox_User_Type = "";
        string Other_Role = "";
        string state = "";
        string SellerName = "";
        string Email = "";
        string Compid = "";
        string Address = "";
        string UPIId = "";
        string BankName = "";
        string AccountNumber = "";
        string IfscCode = "";
        string AccountHolderName = "";
        string BranchName = "";

        if (dt.Rows.Count > 0)
        {
            PinCode = dt.Rows[0]["PinCode"].ToString();
            ConsumerName = dt.Rows[0]["ConsumerName"].ToString();
            City = dt.Rows[0]["City"].ToString();
            Inox_User_Type = dt.Rows[0]["Inox_User_Type"].ToString();
            state = dt.Rows[0]["state"].ToString();
            SellerName = dt.Rows[0]["SellerName"].ToString();
            Email = dt.Rows[0]["Email"].ToString();
            Compid = dt.Rows[0]["Comp_id"].ToString();
            Address = dt.Rows[0]["Address"].ToString();
            Other_Role = dt.Rows[0]["Other_Role"].ToString();
            UPIId = dt.Rows[0]["UPIId"].ToString();
        }

        #region //** Auto Cash Transfer
        if (codeone != "" && codetwo != "")
        {
            DataTable Srvdt = SQL_DB.ExecuteDataTable("select distinct Service_ID from M_ServiceSubscription where Pro_ID in ( select distinct Pro_ID from  M_Code   where Code1='" + codeone + "' and Code2='" + codetwo + "') and Service_ID='SRV1027'");
            if (Srvdt.Rows.Count > 0)
            {


                DataTable Bbkdt = SQL_DB.ExecuteDataTable("select top 1 b.Bank_Name,b.Account_No,b.IFSC_Code,b.Account_HolderNm,b.Branch From M_BankAccount b inner join M_Consumer m on m.M_Consumerid=b.M_Consumerid where m.MobileNo = '" + MobileNo + "' and m.IsDelete=0 and Bank_Name is not null");

                if (Bbkdt.Rows.Count > 0)
                {
                    BankName = Bbkdt.Rows[0]["Bank_Name"].ToString();
                    AccountNumber = Bbkdt.Rows[0]["Account_No"].ToString();
                    IfscCode = Bbkdt.Rows[0]["IFSC_Code"].ToString();
                    AccountHolderName = Bbkdt.Rows[0]["Account_HolderNm"].ToString();
                    BranchName = Bbkdt.Rows[0]["Branch"].ToString();

                }

                result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode + "~" + BankName + "~" + AccountNumber + "~" + IfscCode + "~" + AccountHolderName + "~" + BranchName;
            }
            else
                result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode + "~" + Email + "~" + Compid + "~" + Address;


        }
        if (compid == "Comp-1559")
        {
            DataTable Bbkdt = SQL_DB.ExecuteDataTable("select top 1 b.Bank_Name,b.Account_No,b.IFSC_Code,b.Account_HolderNm,b.Branch From M_BankAccount b inner join M_Consumer m on m.M_Consumerid=b.M_Consumerid where m.MobileNo = '" + MobileNo + "' and m.IsDelete=0 and Bank_Name is not null");
            if (Bbkdt.Rows.Count > 0)
            {
                BankName = Bbkdt.Rows[0]["Bank_Name"].ToString();
                AccountNumber = Bbkdt.Rows[0]["Account_No"].ToString();
                IfscCode = Bbkdt.Rows[0]["IFSC_Code"].ToString();
                AccountHolderName = Bbkdt.Rows[0]["Account_HolderNm"].ToString();
                BranchName = Bbkdt.Rows[0]["Branch"].ToString();

            }

            result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode + "~" + BankName + "~" + AccountNumber + "~" + IfscCode + "~" + UPIId + "~" + BranchName + "~" + AccountHolderName + "~" + Address;
        }


        else
            #endregion



            result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode + "~" + Email + "~" + Compid + "~" + Address + "~" + UPIId;
        return result;



    }


    //added by Bipin for gci
    public string GetConsumerDetailsByMobileNoandcomp(string MobileNo, string codeone = "", string codetwo = "", string compid = "")
    {
        string result = "NA";

        DataTable dt = new DataTable();
        // dt = SQL_DB.ExecuteDataTable("select * from M_Consumer where Right(MobileNo,10)='" + MobileNo.Substring(MobileNo.Length - 10, 10).ToString() + "'");
        dt = SQL_DB.ExecuteDataTable("select PinCode,ConsumerName,City,Inox_User_Type,state,SellerName,Other_Role ,Email,Comp_id,Address,UPIId from M_Consumer where Right(MobileNo,10)='" + MobileNo.Substring(MobileNo.Length - 10, 10).ToString() + "'");

        string PinCode = "";
        string ConsumerName = "";
        string City = "";
        string Inox_User_Type = "";
        string Other_Role = "";
        string state = "";
        string SellerName = "";
        string Email = "";
        string Compid = "";
        string Address = "";
        string UPIId = "";
        string BankName = "";
        string AccountNumber = "";
        string IfscCode = "";
        string AccountHolderName = "";
        string BranchName = "";

        if (dt.Rows.Count > 0)
        {
            PinCode = dt.Rows[0]["PinCode"].ToString();
            ConsumerName = dt.Rows[0]["ConsumerName"].ToString();
            City = dt.Rows[0]["City"].ToString();
            Inox_User_Type = dt.Rows[0]["Inox_User_Type"].ToString();
            state = dt.Rows[0]["state"].ToString();
            SellerName = dt.Rows[0]["SellerName"].ToString();
            Email = dt.Rows[0]["Email"].ToString();
            Compid = dt.Rows[0]["Comp_id"].ToString();
            Address = dt.Rows[0]["Address"].ToString();
            Other_Role = dt.Rows[0]["Other_Role"].ToString();
            UPIId = dt.Rows[0]["UPIId"].ToString();
        }

        #region //** Auto Cash Transfer
        if (codeone != "" && codetwo != "")
        {
            DataTable Srvdt = SQL_DB.ExecuteDataTable("select distinct Service_ID from M_ServiceSubscription where Pro_ID in ( select distinct Pro_ID from  M_Code   where Code1='" + codeone + "' and Code2='" + codetwo + "') and Service_ID='SRV1027'");
            if (Srvdt.Rows.Count > 0)
            {


                DataTable Bbkdt = SQL_DB.ExecuteDataTable("select top 1 b.Bank_Name,b.Account_No,b.IFSC_Code,b.Account_HolderNm,b.Branch From M_BankAccount b inner join M_Consumer m on m.M_Consumerid=b.M_Consumerid where m.MobileNo = '" + MobileNo + "' and m.IsDelete=0 and Bank_Name is not null");

                if (Bbkdt.Rows.Count > 0)
                {
                    BankName = Bbkdt.Rows[0]["Bank_Name"].ToString();
                    AccountNumber = Bbkdt.Rows[0]["Account_No"].ToString();
                    IfscCode = Bbkdt.Rows[0]["IFSC_Code"].ToString();
                    AccountHolderName = Bbkdt.Rows[0]["Account_HolderNm"].ToString();
                    BranchName = Bbkdt.Rows[0]["Branch"].ToString();

                }

                result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode + "~" + BankName + "~" + AccountNumber + "~" + IfscCode + "~" + AccountHolderName + "~" + BranchName;
            }
            else
                result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode + "~" + Email + "~" + Compid + "~" + Address;

        }
        if (compid == "Comp-1438" || compid == "Comp-1594" || compid == "Comp-1593" || compid == "Comp-1609" || compid == "Comp-1649")
        {
            DataTable Bbkdt = SQL_DB.ExecuteDataTable("select top 1 b.Bank_Name,b.Account_No,b.IFSC_Code,b.Account_HolderNm,b.Branch From M_BankAccount b inner join M_Consumer m on m.M_Consumerid=b.M_Consumerid where m.MobileNo = '" + MobileNo + "' and m.IsDelete=0 and Bank_Name is not null");
            if (Bbkdt.Rows.Count > 0)
            {
                BankName = Bbkdt.Rows[0]["Bank_Name"].ToString();
                AccountNumber = Bbkdt.Rows[0]["Account_No"].ToString();
                IfscCode = Bbkdt.Rows[0]["IFSC_Code"].ToString();
                AccountHolderName = Bbkdt.Rows[0]["Account_HolderNm"].ToString();
                BranchName = Bbkdt.Rows[0]["Branch"].ToString();

            }

            result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode + "~" + BankName + "~" + AccountNumber + "~" + IfscCode + "~" + UPIId + "~" + BranchName + "~" + AccountHolderName + "~" + Address;
        }
        else
            #endregion
            result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode + "~" + Email + "~" + Compid + "~" + Address + "~" + UPIId;
        return result;
    }
    //added by Bipin for gci



    public string GetConsumerDetailsByMobileNo(string MobileNo, string codeone = "", string codetwo = "", string comp_id = "")
    {
        string result = "NA";
        //this condition for ram gopal by dipak
        DataTable dt = new DataTable();
        // dt = SQL_DB.ExecuteDataTable("select * from M_Consumer where Right(MobileNo,10)='" + MobileNo.Substring(MobileNo.Length - 10, 10).ToString() + "'");
        if (MobileNo.StartsWith("91") || MobileNo.StartsWith("+91"))
        {
            dt = SQL_DB.ExecuteDataTable("select * from M_Consumer where Right(MobileNo,10)='" + MobileNo.Substring(MobileNo.Length - 10, 10).ToString() + "'");
        }
        else
        {
            dt = SQL_DB.ExecuteDataTable("select * from M_Consumer where MobileNo='" + MobileNo + "'");
        }

        string PinCode = "";
        string ConsumerName = "";
        string City = "";
        string Inox_User_Type = "";
        string Other_Role = "";
        string state = "";
        string SellerName = "";
        string Email = "";
        string Compid = "";
        string Address = "";
        string UPIId = "";
        //Added by BIpin for Ramgopal
        string Gender = "";
        string Agegroup = "";
        string Country = "";
        //Added by BIpin for Ramgopal
        string UserId = "";   //Added by Bipin for Ambika
        string Refralcode = "";   //Added by Bipin for Ambika
        string pancard_number = "";   //Added by Deep Shukla for HanOver
        string aadhar_number = "";   //Added by tej by tej for vsc
        string department = "";   //added by tej for max paints
        string organization = ""; ;   //added by tej for max paints
        string BankName = "";
        string AccountNumber = "";
        string IfscCode = "";
        string AccountHolderName = "";
        string BranchName = "";

        if (dt.Rows.Count > 0)
        {
            PinCode = dt.Rows[0]["PinCode"].ToString();
            ConsumerName = dt.Rows[0]["ConsumerName"].ToString();
            City = dt.Rows[0]["City"].ToString();
            Inox_User_Type = dt.Rows[0]["Inox_User_Type"].ToString();
            state = dt.Rows[0]["state"].ToString();
            SellerName = dt.Rows[0]["SellerName"].ToString();
            Email = dt.Rows[0]["Email"].ToString();
            Compid = dt.Rows[0]["Comp_id"].ToString();
            Address = dt.Rows[0]["Address"].ToString();
            Other_Role = dt.Rows[0]["Other_Role"].ToString();
            UPIId = dt.Rows[0]["UPIId"].ToString();
            Gender = dt.Rows[0]["gender"].ToString();
            Agegroup = dt.Rows[0]["agegroup"].ToString();
            Country = dt.Rows[0]["country"].ToString();
            Refralcode = dt.Rows[0]["ReferralCode"].ToString();
            UserId = dt.Rows[0]["User_ID"].ToString();
            pancard_number = dt.Rows[0]["pancard_number"].ToString(); //Added by Deep Shukla for HanOver
            aadhar_number = dt.Rows[0]["aadharNumber"].ToString(); //Added by tej for vsc
            department = dt.Rows[0]["designation"].ToString();//added by tej for max paints
            organization = dt.Rows[0]["Other_Role"].ToString();//added by tej for max paints
        }

        #region //** Auto Cash Transfer
        if (codeone != "" && codetwo != "")
        {
            DataTable Srvdt = SQL_DB.ExecuteDataTable("select distinct Service_ID from M_ServiceSubscription where Pro_ID in ( select distinct Pro_ID from  M_Code   where Code1='" + codeone + "' and Code2='" + codetwo + "') and Service_ID='SRV1027'");
            if (Srvdt.Rows.Count > 0)
            {


                DataTable Bbkdt = SQL_DB.ExecuteDataTable("select top 1 b.Bank_Name,b.Account_No,b.IFSC_Code,b.Account_HolderNm,b.Branch From M_BankAccount b inner join M_Consumer m on m.M_Consumerid=b.M_Consumerid where m.MobileNo = '" + MobileNo + "' and m.IsDelete=0 and Bank_Name is not null");

                if (Bbkdt.Rows.Count > 0)
                {
                    BankName = Bbkdt.Rows[0]["Bank_Name"].ToString();
                    AccountNumber = Bbkdt.Rows[0]["Account_No"].ToString();
                    IfscCode = Bbkdt.Rows[0]["IFSC_Code"].ToString();
                    AccountHolderName = Bbkdt.Rows[0]["Account_HolderNm"].ToString();
                    BranchName = Bbkdt.Rows[0]["Branch"].ToString();

                }

                result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode + "~" + BankName + "~" + AccountNumber + "~" + IfscCode + "~" + AccountHolderName + "~" + BranchName + "~" + department + "~" + organization;
            }
            else
                result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode + "~" + Email + "~" + Compid + "~" + Address;


        }
        else if (codeone == "" && codetwo == "" && MobileNo != "" && (comp_id == "Comp-1722" || comp_id == "Comp-1707" || comp_id == "Comp-1738"))
        { // added by dipak tiwari for max paint


            DataTable Bbkdt = SQL_DB.ExecuteDataTable("select top 1 b.Bank_Name,b.Account_No,b.IFSC_Code,b.Account_HolderNm,b.Branch From M_BankAccount b inner join M_Consumer m on m.M_Consumerid=b.M_Consumerid where m.MobileNo = '" + MobileNo + "' and m.IsDelete=0 and Bank_Name is not null");
            if (Bbkdt.Rows.Count > 0)
            {
                BankName = Bbkdt.Rows[0]["Bank_Name"].ToString();
                AccountNumber = Bbkdt.Rows[0]["Account_No"].ToString();
                IfscCode = Bbkdt.Rows[0]["IFSC_Code"].ToString();
                AccountHolderName = Bbkdt.Rows[0]["Account_HolderNm"].ToString();
                BranchName = Bbkdt.Rows[0]["Branch"].ToString();

            }
            if (comp_id == "Comp-1722")
            {
                result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode + "~" + BankName + "~" + AccountNumber + "~" + IfscCode + "~" + UPIId + "~" + BranchName + "~" + AccountHolderName + "~" + Address + "~" + Email;
            }
            else
            {
                result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode + "~" + Email + "~" + BankName + "~" + AccountNumber + "~" + IfscCode + "~" + UPIId + "~" + BranchName + "~" + AccountHolderName + "~" + Address + "~" + department + "~" + organization + "~" + pancard_number + "~" + aadhar_number + "~" + Gender + "~" + Agegroup;
            }

        }
        else
            #endregion

            result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode + "~" + Email + "~" + Compid + "~" + Address + "~" + UPIId + "~" + Gender + "~" + Agegroup + "~" + Country + "~" + UserId + "~" + Refralcode + "~" + pancard_number + "~" + aadhar_number;
        return result;



    }

    public static string InsertUpdateExibitiondtls(string MobileNo, string Name = "", string Email = "", string Compname = "", string Designation = "", string Intrest = "")
    {
        //DataProvider.LogManager.WriteExe("Find Error in Procedure with " + Ex.Message.ToString());
        string result = "";
        Exibition_details Log = new Exibition_details();
        #region Checking for M_Consumer
        DataTable dcs = SQL_DB.ExecuteDataTable("SELECT [Mobile] FROM [TBL_Exibition] where [Mobile] = '" + MobileNo + "'");
        #endregion
        if (dcs.Rows.Count > 0)
        {
            Log.DML = "U";
        }
        else
        {
            Log.DML = "I";
        }

        #region Registration
        Log.MobileNo = MobileNo;
        Log.Name = Name;
        Log.Email = Email;
        Log.CompNAme = Compname;
        Log.Designation = Designation;
        Log.Intrest = Intrest;
        Log.Exibitionname = "Pack Plus";
        Exibition_details.InsertUpdateExibitiondtls(Log);
        #endregion
        result = "Success";
        return result;
    }

    public string GetDealerList(string State, string City)
    {
        Object Data = "";
        DataTable dt = new DataTable();
        dt = SQL_DB.ExecuteDataTable("Select DealerCode,DealerName from M_Retailer_DealerMaster where Status='Active' and State like '%" + State + "%' and  District like '%" + City + "%'  order by DealerName asc");
        if (dt.Rows.Count > 0)
        {
            Data = dt;
        }
        else
        {
            #region Need to change here state into city in where clause 
            dt = SQL_DB.ExecuteDataTable("Select DealerCode,DealerName from M_Retailer_DealerMaster where Status='Active' and State like '%" + State + "%'  order by DealerName asc");
            #endregion
            if (dt.Rows.Count > 0)
            {
                Data = dt;
            }
        }
        string result = JsonConvert.SerializeObject(Data);
        return result;
    }

    public string SaveRetailerIdMM(string name, string mobile, string gst_or_adhar, string shopname, string pin, string city, string state, string dealercode, string dealername)
    {
        String Result = string.Empty;
        try
        {
            #region //** Is this user registered or not ?
            DataTable Sdt = new DataTable();
            Sdt = SQL_DB.ExecuteDataTable("Select*from tblMMRetailerDetails where Status=1 and M_Consumerid=(select M_Consumerid from M_Consumer where MobileNo like'%" + mobile + "%' and IsDelete=0)");
            if (Sdt.Rows.Count > 0)
            {
                Result = "Already registered !.";
                Result = Result + "~" + Sdt.Rows[0]["RetailerId"].ToString() + "~" + Sdt.Rows[0]["DealerCode"].ToString();
                return Result;
            }
            #endregion


            DataTable dt = new DataTable();
            dt = SQL_DB.ExecuteDataTable("select RetailerId,DealerCode from tblMMRetailerDetails where RetailerId='" + gst_or_adhar + "' and DealerCode='" + dealercode + "' and M_Consumerid=(select M_Consumerid from M_Consumer where MobileNo like'%" + mobile + "%' and IsDelete=0)");
            //dt = db.SelectTableData("tblMMRetailerDetails", "RetailerId,DealerCode", "RetailerId='"+ RetailerId + "' and DealerCode='"+ DealerCode + "' and M_Consumerid=(select M_Consumerid from M_Consumer where MobileNo='"+ userid + "' and IsDelete=0)");
            if (dt.Rows.Count > 0)
            {
                Result = "Already registered !.";
                Result = Result + "~" + dt.Rows[0]["RetailerId"].ToString() + "~" + dt.Rows[0]["DealerCode"].ToString();
                return Result;
            }

            DataTable Rdt = new DataTable();
            Rdt = SQL_DB.ExecuteDataTable("select RetailerId,DealerCode from tblMMRetailerDetails where RetailerId='" + gst_or_adhar + "'");
            if (Rdt.Rows.Count > 0)
            {
                Result = "Already registered !.";
                Result = Result + "~" + Rdt.Rows[0]["RetailerId"].ToString() + "~" + Rdt.Rows[0]["DealerCode"].ToString();
                return Result;
            }


            string M_Consumerid = "0";
            dt = SQL_DB.ExecuteDataTable("select M_Consumerid from M_Consumer where MobileNo like'%" + mobile + "%' and IsDelete=0");
            //dt = db.SelectTableData("M_Consumer", "M_Consumerid", "MobileNo='" + userid + "' and IsDelete=0");
            if (dt.Rows.Count > 0)
            {
                M_Consumerid = dt.Rows[0]["M_Consumerid"].ToString();
            }

            if (M_Consumerid == "0")
            {



                if (mobile.Length < 10)
                {
                    Result = "Mobile No. must be 10 digits!";
                    return Result;
                }
                if (mobile.Length == 11)
                {
                    int initial = Convert.ToInt32(mobile.Substring(0, 1));
                    if (initial == 0)
                        mobile = "91" + mobile.Substring(1, mobile.Length - 1);
                    else
                    {
                        Result = "Mobile No. Wrong!";
                        return Result;
                    }
                }
                if (mobile.Length == 13)
                {
                    int initial = Convert.ToInt32(mobile.Substring(0, 1));
                    if (initial == 0)
                        mobile = mobile.Substring(1, mobile.Length - 1);
                    else
                    {
                        Result = "Mobile No. Wrong!";
                        return Result;
                    }
                }
                if (mobile.Length == 12)
                {
                    int initial = Convert.ToInt32(mobile.Substring(0, 2));
                    if (initial == 91)
                        mobile = mobile.Substring(2, mobile.Length - 2);
                }
                if (mobile.Length == 10)
                    mobile = "91" + mobile;

                Random rnd = new Random();
                User_Details Log = new User_Details();
                Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
                Log.ConsumerName = name;
                Log.MobileNo = mobile;

                Log.City = city;
                Log.PinCode = pin;
                Log.Password = rnd.Next(10000, 99999).ToString();
                Log.IsActive = 0;
                Log.IsDelete = 0;
                Log.state = state;
                Log.DML = "I";
                User_Details.InsertUpdateUserDetails(Log);
                dt = SQL_DB.ExecuteDataTable("select M_Consumerid from M_Consumer where MobileNo like'%" + mobile + "%' and IsDelete=0");
                if (dt.Rows.Count > 0)
                {
                    M_Consumerid = dt.Rows[0]["M_Consumerid"].ToString();
                }



                //Result = "Something went wrong , Please try again later !.";
                //Result = "Failure" + "~" + Result;
                //return Result;

            }

            SQL_DB.ExecuteNonQuery("insert into tblMMRetailerDetails(RetailerId,ShopName,Pincode,City,State,DealerName,DealerCode,M_Consumerid) values('" + gst_or_adhar + "','" + shopname + "','" + pin + "','" + city + "','" + state + "','" + dealername + "','" + dealercode + "','" + M_Consumerid + "')");
            DataTable dta = new DataTable();
            dta = SQL_DB.ExecuteDataTable("select RetailerId,DealerCode from tblMMRetailerDetails where RetailerId='" + gst_or_adhar + "' and DealerCode='" + dealercode + "' and M_Consumerid=(select M_Consumerid from M_Consumer where MobileNo like'%" + mobile + "%' and IsDelete=0)");

            if (dta.Rows.Count > 0)
            {
                Result = "Success" + "~" + dta.Rows[0]["RetailerId"].ToString() + "~" + dta.Rows[0]["DealerCode"].ToString();
            }
        }
        catch (Exception ex)
        {
            Result = "Find Error in RetailerIdRegistrationForMahindra api with | " + ex.Message.ToString();
        }
        return Result;
    }

    public string AUCGetConsumerDetailsByMobileNo(string MobileNo, string codeone = "", string codetwo = "")
    {
        string result = "NA";

        DataTable dt = new DataTable();
        // dt = SQL_DB.ExecuteDataTable("select * from M_Consumer where Right(MobileNo,10)='" + MobileNo.Substring(MobileNo.Length - 10, 10).ToString() + "'");
        dt = SQL_DB.ExecuteDataTable("select PinCode,ConsumerName,City,Inox_User_Type,state,SellerName,Other_Role ,Email,Comp_id,Address,UPIId from M_Consumer where Right(MobileNo,10)='" + MobileNo.Substring(MobileNo.Length - 10, 10).ToString() + "'");

        string PinCode = "";
        string ConsumerName = "";
        string City = "";
        string Inox_User_Type = "";
        string Other_Role = "";
        string state = "";
        string SellerName = "";
        string Email = "";
        string Compid = "";
        string Address = "";
        string UPIId = "";

        if (dt.Rows.Count > 0)
        {
            PinCode = dt.Rows[0]["PinCode"].ToString();
            ConsumerName = dt.Rows[0]["ConsumerName"].ToString();
            City = dt.Rows[0]["City"].ToString();
            Inox_User_Type = dt.Rows[0]["Inox_User_Type"].ToString();
            state = dt.Rows[0]["state"].ToString();
            SellerName = dt.Rows[0]["SellerName"].ToString();
            Email = dt.Rows[0]["Email"].ToString();
            Compid = dt.Rows[0]["Comp_id"].ToString();
            Address = dt.Rows[0]["Address"].ToString();
            Other_Role = dt.Rows[0]["Other_Role"].ToString();
            UPIId = dt.Rows[0]["UPIId"].ToString();

        }

        #region //** Auto Cash Transfer
        if (codeone != "" && codetwo != "")
        {
            DataTable Srvdt = SQL_DB.ExecuteDataTable("select distinct Service_ID from M_ServiceSubscription where Pro_ID in ( select distinct Pro_ID from  M_Code   where Code1='" + codeone + "' and Code2='" + codetwo + "') and Service_ID='SRV1027'");
            if (Srvdt.Rows.Count > 0)
            {
                string BankName = "";
                string AccountNumber = "";
                string IfscCode = "";
                string AccountHolderName = "";
                string BranchName = "";

                DataTable Bbkdt = SQL_DB.ExecuteDataTable("select top 1 b.Bank_Name,b.Account_No,b.IFSC_Code,b.Account_HolderNm,b.Branch From M_BankAccount b inner join M_Consumer m on m.M_Consumerid=b.M_Consumerid where m.MobileNo = '" + MobileNo + "' and m.IsDelete=0 and Bank_Name is not null");

                if (Bbkdt.Rows.Count > 0)
                {
                    BankName = Bbkdt.Rows[0]["Bank_Name"].ToString();
                    AccountNumber = Bbkdt.Rows[0]["Account_No"].ToString();
                    IfscCode = Bbkdt.Rows[0]["IFSC_Code"].ToString();
                    AccountHolderName = Bbkdt.Rows[0]["Account_HolderNm"].ToString();
                    BranchName = Bbkdt.Rows[0]["Branch"].ToString();

                }

                result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode + "~" + BankName + "~" + AccountNumber + "~" + IfscCode + "~" + AccountHolderName + "~" + BranchName;
            }
            else
                result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode + "~" + UPIId;


        }



        else
            #endregion



            result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode;
        return result;



    }

    public string GetConsumerDetailsByMobileNo2(string MobileNo, string codeone = "", string codetwo = "")
    {
        string result = "NA";

        DataTable dt = new DataTable();
        // dt = SQL_DB.ExecuteDataTable("select * from M_Consumer where Right(MobileNo,10)='" + MobileNo.Substring(MobileNo.Length - 10, 10).ToString() + "'");
        dt = SQL_DB.ExecuteDataTable("select PinCode,ConsumerName,City,Inox_User_Type,state,SellerName,Other_Role,UPIId from M_Consumer where Right(MobileNo,10)='" + MobileNo.Substring(MobileNo.Length - 10, 10).ToString() + "'");

        string PinCode = "";
        string ConsumerName = "";
        string City = "";
        string Inox_User_Type = "";
        string Other_Role = "";
        string state = "";
        string SellerName = "";
        string upiid = "";

        if (dt.Rows.Count > 0)
        {
            PinCode = dt.Rows[0]["PinCode"].ToString();
            ConsumerName = dt.Rows[0]["ConsumerName"].ToString();
            City = dt.Rows[0]["City"].ToString();
            Inox_User_Type = dt.Rows[0]["Inox_User_Type"].ToString();
            state = dt.Rows[0]["state"].ToString();
            SellerName = dt.Rows[0]["SellerName"].ToString();
            Other_Role = dt.Rows[0]["Other_Role"].ToString();
            upiid = dt.Rows[0]["UPIId"].ToString();
        }

        #region //** Auto Cash Transfer
        if (codeone != "" && codetwo != "")
        {
            DataTable Srvdt = SQL_DB.ExecuteDataTable("select distinct Service_ID from M_ServiceSubscription where Pro_ID in ( select distinct Pro_ID from  M_Code   where Code1='" + codeone + "' and Code2='" + codetwo + "') and (Service_ID='SRV1027' or Service_ID='SRV1028')");
            //if(Srvdt.Rows.Count >0)
            //{
            string BankName = "";
            string AccountNumber = "";
            string IfscCode = "";
            string AccountHolderName = "";
            string BranchName = "";

            DataTable Bbkdt = SQL_DB.ExecuteDataTable("select top 1 b.Bank_Name,b.Account_No,b.IFSC_Code,b.Account_HolderNm,b.Branch From M_BankAccount b inner join M_Consumer m on m.M_Consumerid=b.M_Consumerid where m.MobileNo = '" + MobileNo + "' and m.IsDelete=0 and Bank_Name is not null");

            if (Bbkdt.Rows.Count > 0)
            {
                BankName = Bbkdt.Rows[0]["Bank_Name"].ToString();
                AccountNumber = Bbkdt.Rows[0]["Account_No"].ToString();
                IfscCode = Bbkdt.Rows[0]["IFSC_Code"].ToString();
                AccountHolderName = Bbkdt.Rows[0]["Account_HolderNm"].ToString();
                BranchName = Bbkdt.Rows[0]["Branch"].ToString();

            }

            result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode + "~" + BankName + "~" + AccountNumber + "~" + IfscCode + "~" + AccountHolderName + "~" + BranchName + "~" + upiid;
            //}
            //else
            //    result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode;


        }



        else
            #endregion



            result = ConsumerName + "~" + Inox_User_Type + "~" + City + "~" + state + "~" + SellerName + "~" + Other_Role + "~" + PinCode;
        return result;



    }



    public void ProcessRequest(HttpContext context)
    {

        if (context.Request.QueryString["method"] == "GetIP")
        {
            CustomeDraw.Rewards_DataTire.CheckIsActDeAct();
            string result = GetIP();
            context.Response.Write(result);
        }



        //added by Bipin for gci
        if (context.Request.QueryString["method"] == "ConsumerDetailsByMobileNoandcomp")
        {
            string mobile = context.Request.QueryString["MobileNo"];
            mobile = "91" + mobile.Substring(mobile.Length - 10, 10);
            string compid = "";
            if (context.Request.QueryString["compid"] != null)
                compid = context.Request.QueryString["compid"].ToString();

            #region //** Auto Cash Transfer
            string codeone = string.Empty;
            string codetwo = string.Empty;
            if (context.Request.QueryString["codeone"] != null && context.Request.QueryString["codetwo"] != null)
            {
                if (context.Request.QueryString["codeone"] != "" && context.Request.QueryString["codetwo"] != "")
                {
                    codeone = context.Request.QueryString["codeone"];
                    codetwo = context.Request.QueryString["codetwo"];

                }
            }


            string result = "";
            if (codeone.Trim().Length == 5 && codetwo.Trim().Length == 8)
                result = GetConsumerDetailsByMobileNoandcomp(mobile, codeone, codetwo);
            else
                #endregion
                //  string result = "";
                result = GetConsumerDetailsByMobileNoandcomp(mobile, "", "", compid);
            context.Response.Write(result);
        }
        //added by Bipin for gci

        if (context.Request.QueryString["method"] == "AUCConsumerDetailsByMobileNo")
        {
            string mobile = context.Request.QueryString["MobileNo"];
            mobile = "91" + mobile.Substring(mobile.Length - 10, 10);


            #region //** Auto Cash Transfer
            string codeone = string.Empty;
            string codetwo = string.Empty;
            if (context.Request.QueryString["codeone"] != null && context.Request.QueryString["codetwo"] != null)
            {
                if (context.Request.QueryString["codeone"] != "" && context.Request.QueryString["codetwo"] != "")
                {
                    codeone = context.Request.QueryString["codeone"];
                    codetwo = context.Request.QueryString["codetwo"];

                }
            }


            string result = "";
            if (codeone.Trim().Length == 5 && codetwo.Trim().Length == 8)
                result = AUCGetConsumerDetailsByMobileNo(mobile, codeone, codetwo);
            else
                #endregion
                //  string result = "";
                result = AUCGetConsumerDetailsByMobileNo(mobile);
            context.Response.Write(result);
        }


        if (context.Request.QueryString["method"] == "ConsumerDetailsByMobileNo2")
        {
            string mobile = context.Request.QueryString["MobileNo"];
            mobile = "91" + mobile.Substring(mobile.Length - 10, 10);


            #region //** Auto Cash Transfer
            string codeone = string.Empty;
            string codetwo = string.Empty;
            if (context.Request.QueryString["codeone"] != null && context.Request.QueryString["codetwo"] != null)
            {
                if (context.Request.QueryString["codeone"] != "" && context.Request.QueryString["codetwo"] != "")
                {
                    codeone = context.Request.QueryString["codeone"];
                    codetwo = context.Request.QueryString["codetwo"];

                }
            }


            string result = "";
            if (codeone.Trim().Length == 5 && codetwo.Trim().Length == 8)
                result = GetConsumerDetailsByMobileNo2(mobile, codeone, codetwo);
            else
                #endregion
                //  string result = "";
                result = GetConsumerDetailsByMobileNo2(mobile);
            context.Response.Write(result);
        }


        //Exibition
        if (context.Request.QueryString["method"] == "GetCodeCountbyMobile")
        {
            string CompName = "";
            string result = "";
            string mobile = context.Request.QueryString["MobileNo"];
            mobile = "91" + mobile.Substring(mobile.Length - 10, 10);

            if (context.Request.QueryString["CompName"] != null)
                CompName = context.Request.QueryString["CompName"].ToString();

            if (CompName == "Cosmo Tech Expo" || CompName == "Pack Plus")
            {

                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("CheckCodeCountExibition", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Compname", CompName);
                cmd.Parameters.AddWithValue("@mobileno", mobile);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable countcd = new DataTable();
                da.Fill(countcd);
                con.Close();
                if (countcd.Rows.Count > 0)
                {
                    result = "failure~This code has already been verified </br>Thanks VCQRU PVT Ltd.";

                }
                else
                {
                    result = "Success~ok.";
                }
                context.Response.Write(result);
            }

        }

        //Exibition

        if (context.Request.QueryString["method"] == "ConsumerDetailsByMobileNo")
        {
            //2. this changes for ram gopal
            string countrycode = context.Request.QueryString["CountryCode"] != null ?
                         context.Request.QueryString["CountryCode"].Trim() :
                         string.Empty; // Default to empty if null
            string mobile = context.Request.QueryString["MobileNo"].Trim();
            if (countrycode != string.Empty)
            {
                mobile = "+" + countrycode + "-" + mobile;
            }
            else
            {
                mobile = "91" + mobile.Substring(mobile.Length - 10, 10);
            }
            string compid = "";
            if (context.Request.QueryString["compid"] != null)
                compid = context.Request.QueryString["compid"].ToString();

            #region //** Auto Cash Transfer
            string codeone = string.Empty;
            string codetwo = string.Empty;
            if (context.Request.QueryString["codeone"] != null && context.Request.QueryString["codetwo"] != null)
            {
                if (context.Request.QueryString["codeone"] != "" && context.Request.QueryString["codetwo"] != "")
                {
                    codeone = context.Request.QueryString["codeone"];
                    codetwo = context.Request.QueryString["codetwo"];

                }
            }


            string result = "";
            if (codeone.Trim().Length == 5 && codetwo.Trim().Length == 8)
                result = GetConsumerDetailsByMobileNo(mobile, codeone, codetwo);
            else
                #endregion
                //  string result = "";
                result = GetConsumerDetailsByMobileNo(mobile, "", "", compid);
            context.Response.Write(result);
        }
        if (context.Request.QueryString["method"] == "ConsumerDetailsByMobileNoBlugem")
        {
            string mobile = context.Request.QueryString["MobileNo"];
            mobile = "91" + mobile.Substring(mobile.Length - 10, 10);
            string compid = "";
            if (context.Request.QueryString["compid"] != null)
                compid = context.Request.QueryString["compid"].ToString();

            #region //** Auto Cash Transfer
            string codeone = string.Empty;
            string codetwo = string.Empty;
            if (context.Request.QueryString["codeone"] != null && context.Request.QueryString["codetwo"] != null)
            {
                if (context.Request.QueryString["codeone"] != "" && context.Request.QueryString["codetwo"] != "")
                {
                    codeone = context.Request.QueryString["codeone"];
                    codetwo = context.Request.QueryString["codetwo"];

                }
            }


            string result = "";
            if (codeone.Trim().Length == 5 && codetwo.Trim().Length == 8)
                result = ConsumerDetailsByMobileNoBlugem(mobile, codeone, codetwo);
            else
                #endregion
                //  string result = "";
                result = ConsumerDetailsByMobileNoBlugem(mobile, "", "", compid);
            context.Response.Write(result);
        }


        if (context.Request.QueryString["method"] == "userdetails")
        {
            string result = "";
            string mobile = context.Request.QueryString["mobile"];
            mobile = "91" + mobile.Substring(mobile.Length - 10, 10);
            string code = context.Request.QueryString["codeone"];
            DataTable table = SQL_DB.ExecuteDataTable("select top 1 mobileno from pro_enq where Received_Code1='" + code.Substring(0, 5) + "' and Received_Code2='" + code.Substring(5, 8) + "'  and Is_Success=1");
            if (table.Rows.Count > 0)
            {
                if (table.Rows[0]["mobileno"].ToString() == mobile)
                {
                    DataTable userdetails = SQL_DB.ExecuteDataTable("select top 1 * from M_Consumer where mobileno='" + mobile + "'");

                    if (String.IsNullOrEmpty(userdetails.Rows[0]["ConsumerName"].ToString()) || String.IsNullOrEmpty(userdetails.Rows[0]["village"].ToString()) || String.IsNullOrEmpty(userdetails.Rows[0]["district"].ToString()) || String.IsNullOrEmpty(userdetails.Rows[0]["state"].ToString()))
                    {
                        result = "Details~enter data";
                    }
                    else
                    {
                        result = "Failure~विवरण पहले ही भरा जा चुका है।";
                    }
                    // result=JsonConvert.SerializeObject(userdetails,Formatting.Indented);
                }
                else
                {
                    result = "Already~मोबाइल नंबर कोड से मेल नहीं खाता।";
                }
            }
            else
            {
                result = "Already~कृपया 13 अंकों का सही कोड दर्ज करें।";
            }
            context.Response.Write(result);
        }

        if (context.Request.QueryString["method"] == "SaveRetailerId")
        {
            string name = context.Request.QueryString["name"];
            string mobile = context.Request.QueryString["mobile"];
            string gst_or_adhar = context.Request.QueryString["gst_or_adhar"];
            string shopname = context.Request.QueryString["shopname"];
            string pin = context.Request.QueryString["pin"];
            string city = context.Request.QueryString["city"];
            string state = context.Request.QueryString["state"];
            string dealercode = context.Request.QueryString["dealercode"];
            string dealername = context.Request.QueryString["dealername"];
            string result = "";
            result = SaveRetailerIdMM(name, mobile, gst_or_adhar, shopname, pin, city, state, dealercode, dealername);
            context.Response.Write(result);
        }

        if (context.Request.QueryString["method"] == "Binddealer")
        {
            string State = context.Request.QueryString["State"];
            string City = context.Request.QueryString["City"];
            string result = "";
            result = GetDealerList(State, City);
            context.Response.Write(result);
        }


        if (context.Request.QueryString["method"] == "Uservalidate")
        {
            try
            {
                string mobile = context.Request.QueryString["mobileno"];
                mobile = "91" + mobile.Substring(mobile.Length - 10, 10);

                DataTable table = SQL_DB.ExecuteDataTable("select M_Consumerid from M_Consumer where mobileno='" + mobile + "'");
                if (table.Rows.Count > 0)
                {
                    context.Response.Write("true");
                }
                else
                {
                    context.Response.Write("false");
                }
            }
            catch (Exception e)
            {
                throw;
            }
        }

        //Added by Bipin for Patanjali
        if (context.Request.QueryString["method"] == "InsertInquieryDetails_Patanjali")
        {
            string href = HttpContext.Current.Request.QueryString["href"];
            string[] parts = href.Split('/');

            string name = parts[parts.Length - 2].Replace("-", " ");

            string code = parts[parts.Length - 1];



            string connectionString = ConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString; // Replace with your actual connection string

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string sql = @"INSERT INTO [dbo].[tbl_ProductUrl]
                        ([Prod_Url], [Name], [Code], [Click_Count], [Remarks], [IsActive], [IsDelete], [Created_by], [Created_Date], [Updated_by], [Updated_Date])
                        VALUES
                        (@Prod_Url, @Name, @Code, @Click_Count, @Remarks, @IsActive, @IsDelete,@Created_by, GETDATE(), @Updated_by, GETDATE())";

                SqlCommand command = new SqlCommand(sql, connection);

                // Add parameters
                command.Parameters.AddWithValue("@Prod_Url", href);
                command.Parameters.AddWithValue("@Name", name);
                command.Parameters.AddWithValue("@Code", code);
                command.Parameters.AddWithValue("@Click_Count", 1);
                command.Parameters.AddWithValue("@Remarks", "clicked");
                command.Parameters.AddWithValue("@IsActive", 0);
                command.Parameters.AddWithValue("@IsDelete", 0);
                command.Parameters.AddWithValue("@Created_by", "");
                command.Parameters.AddWithValue("@Updated_by", "");

                try
                {
                    connection.Open();
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error inserting into tbl_ProductUrl: " + ex.Message);
                    // Handle the exception as needed
                }
            }
            string json = "{\"Status\":\"Success\"}";

            context.Response.Write(json);
        }


        if (context.Request.QueryString["method"] == "Getproductimgurl")
        {
            string Mobile = context.Request.QueryString["mobile"];
            string Code = context.Request.QueryString["vCode"];
            string Comp_name = context.Request.QueryString["comp"];
            string Comp_ID = context.Request.QueryString["Comp_ID"];
            string code1 = Code.Substring(0, 5);
            string code2 = Code.Substring(6, 8);
            string proID = "";
            DataTable proid = new DataTable();
            if (Comp_ID == "Comp-1693")
                proid = SQL_DB.ExecuteDataTable("select pro_id from M_Code_PFL where code1='" + code1 + "' and code2='" + code2 + "'");
            else
                proid = SQL_DB.ExecuteDataTable("select pro_id from M_code where code1='" + code1 + "' and code2='" + code2 + "'");
            if (proid.Rows.Count > 0)
            {
                proID = proid.Rows[0][0].ToString();
            }
            DataTable dtgetimg = SQL_DB.ExecuteDataTable("select Upper_View,Lower_View,Full_View from tbl_product_image where Comp_ID='" + Comp_ID + "' and Pro_ID='" + proID + "'");
            string json = "";

            if (dtgetimg.Rows.Count > 0)
            {
                //json = JsonConvert.SerializeObject(dtgetimg, Formatting.Indented);
                json = dtgetimg.Rows[0]["Upper_View"].ToString() + "~" + dtgetimg.Rows[0]["Lower_View"].ToString() + "~" + dtgetimg.Rows[0]["Full_View"].ToString();
            }


            context.Response.Write(json);
        }

        //Added by Bipin for Patanjali

        if (context.Request.QueryString["method"] == "IFSC")
        {
            string ifsccode = context.Request.QueryString["ifsccode"];
            DataTable table = new DataTable();
            table = SQL_DB.ExecuteDataTable("select * from ifsc where ifsc='" + ifsccode + "'");

            string json = JsonConvert.SerializeObject(table, Formatting.Indented);

            context.Response.Write(json);
        }

        if (context.Request.QueryString["method"] == "getintouch")
        {
            try
            {
                string email = context.Request.QueryString["email"];
                string phone = context.Request.QueryString["phone"];
                string fname = context.Request.QueryString["fname"];
                string lname = context.Request.QueryString["lname"];
                string message = context.Request.QueryString["message"];
                string requested = context.Request.QueryString["requested"];
                DataTable table = new DataTable();
                SQL_DB.ExecuteNonQuery("insert into [Getintouch]([fname],[lname],[email],[phone],[msg],[createddate],[updateddate],[Reuested_page]) values('" + fname + "','" + lname + "','" + email + "','" + phone + "','" + message + "',getdate(),getdate(),'" + requested + "')");
                string result = sendquery(fname + " " + lname, email, message, phone, "Requset Regarding " + requested + " VCQRU");


                context.Response.Write("Success~Your Query Submitted Successfuly! We will contact you soon.");
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        if (context.Request.QueryString["method"] == "Claim")
        {
            DataTable dt = new DataTable();
            dt = SQL_DB.ExecuteDataTable("select top 1 [user_id],M_Consumerid from m_consumer where right(mobileno,10)='" + context.Request.QueryString["userid"].Substring(context.Request.QueryString["userid"].Length - 10, 10) + "'");
            DataTable dtcp = null;
            if (dtcp != null)
            {
                dtcp.Rows.Clear();
            }
            dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where  bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + dt.Rows[0][0].ToString() + "') group by mss.Comp_ID,cl.p_cash");

            DataTable table = new DataTable();
            // where [gift_id]=4
            if (dtcp.Rows.Count != 0 && (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1278" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1285" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1375" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1350"))
            {
                if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1285" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1375" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1350")
                {
                    table = SQL_DB.ExecuteDataTable("select [gift_id],[Gift_name],[Gift_value] ,[Gift_desc],[Gift_image] from Claim_gift where [status]=1 and [gift_id]<>20 and CompID='" + dtcp.Rows[0]["Comp_ID"].ToString() + "' order by Gift_value");
                }
                else
                {
                    table = SQL_DB.ExecuteDataTable("select [gift_id],[Gift_name],[Gift_value] ,[Gift_desc],[Gift_image] from Claim_gift where [status]=1 and [gift_id]<>20 and  CompID is null order by Gift_value");
                }
            }
            else
            {
                table = SQL_DB.ExecuteDataTable("select [gift_id],[Gift_name],[Gift_value] ,[Gift_desc],[Gift_image] from Claim_gift where [gift_id]=20");
            }
            table.Columns.Add("gift_message");
            table.Columns.Add("btn_flag", typeof(Int32));
            table.Columns.Add("Comp_id");
            table.Columns["gift_message"].ReadOnly = false;
            table.Columns["btn_flag"].ReadOnly = false;
            table.Columns["Gift_value"].ReadOnly = false;
            ////////////////
            try
            {
                int tp = 0;

                string loyalty_return = SQL_DB.ExecuteScalar("select isnull(sum(loyalty),0) from scrap_entry se inner join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2 inner join m_consumer ms on ms.MobileNo=pe.MobileNo where pe.is_success=1 and  ms.M_Consumerid=" + dt.Rows[0][1].ToString()).ToString();
                //DataTable dt = SQL_DB.ExecuteDataTable("select distinct cr.Comp_Name from dbo.[M_consumer] mc inner join dbo.pro_enq pe on pe.mobileno = mc.mobileno inner join dbo.M_code mcod on pe.Received_Code1 = mcod.code1 and pe.Received_Code2 = mcod.code2 inner join dbo.pro_reg pr on mcod.pro_ID = pr.Pro_ID inner join dbo.comp_reg cr on pr.Comp_ID = cr.Comp_ID where cr.Comp_ID = 'Comp-1230' and mc.[User_ID]='" + Session["USRID"].ToString() + "'");
                //dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,cl.p_cash from dbo.[BLoyaltyPointsEarned] bl inner join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id inner join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id inner join dbo.claimredeem cl on cl.compid=mss.Comp_ID where mss.Comp_ID='Comp-1203' and bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + Session["USRID"].ToString() + "') group by mss.Comp_ID,cl.p_cash");
                //dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where  bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + dt.Rows[0][0].ToString() + "') group by mss.Comp_ID,cl.p_cash");
                if (dtcp.Rows.Count > 0)
                {
                    //int totalpoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum([Points]) is null then 0 else Sum([Points]) end as point FROM [BLoyaltyPointsEarned] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[M_Consumerid] where mc.[User_ID]='" + Session["USRID"].ToString() + "'"));
                    int loyaltybonus = 0;

                    if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1278" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1285" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1375")
                    {
                        loyaltybonus = Convert.ToInt32(SQL_DB.ExecuteScalar("select isnull(sum(points),0) as points from buildloyalty_offers where m_consumerid=" + dt.Rows[0][1].ToString()).ToString());
                    }
                    int totalpoint = (Convert.ToInt32(dtcp.Rows[0]["point"].ToString()) - Convert.ToInt32(loyalty_return)) + loyaltybonus;
                    int redeempoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(bl.[RedeemPoints]) is null then 0 else Sum(isnull(bl.[RedeemPoints],0)) end FROM [BPointsTransaction] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[RedeemBy] where mc.[User_ID]='" + dt.Rows[0][0].ToString() + "' and (bl.bpstatus is null or bl.bpstatus<>'FAILURE')"));
                    int claimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [ClaimDetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.[User_ID]='" + dt.Rows[0][0].ToString() + "' and (cl.Isapproved=1)"));
                    float totalpointrt = Convert.ToInt32(dtcp.Rows[0]["p_cash"].ToString());
                    DataTable dtcondition = SQL_DB.ExecuteDataTable("select top 1 codition_point,condition_match from point_redeem_condition where comp_id='" + dtcp.Rows[0]["Comp_ID"].ToString() + "' and isactive=1 and selection_id=case when (select count(*) from paytmtransaction where m_consumerid='" + dt.Rows[0][1].ToString() + "' and comp_id='Comp-1214')>0 then 2 else 1 end ");

                    if (dtcondition.Rows.Count > 0)
                    {
                        tp = totalpoint - redeempoint - claimapply;
                        int rp = 0;
                        if (dtcondition.Rows[0]["condition_match"].ToString() == "1")
                        {
                            rp = tp % Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString());
                            rp = tp - rp;
                        }
                        else
                        {
                            if (tp >= Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))
                            {
                                rp = tp;
                            }
                        }
                        //int ptforrd = rp;
                        int ptforrd = tp - rp;
                        float tpr = ptforrd * totalpointrt;
                        for (int i = 0; i < table.Rows.Count; i++)
                        {
                            if (table.Rows[i]["gift_id"].ToString() == "20")
                            {

                                //string loyalty_return = SQL_DB.ExecuteScalar("select isnull(sum(loyalty),0) from scrap_entry se inner join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2 inner join m_consumer ms on ms.MobileNo=pe.MobileNo where pe.is_success=1 and  ms.M_Consumerid=" + dt.Rows[0][1].ToString()).ToString();
                                ////DataTable dt = SQL_DB.ExecuteDataTable("select distinct cr.Comp_Name from dbo.[M_consumer] mc inner join dbo.pro_enq pe on pe.mobileno = mc.mobileno inner join dbo.M_code mcod on pe.Received_Code1 = mcod.code1 and pe.Received_Code2 = mcod.code2 inner join dbo.pro_reg pr on mcod.pro_ID = pr.Pro_ID inner join dbo.comp_reg cr on pr.Comp_ID = cr.Comp_ID where cr.Comp_ID = 'Comp-1230' and mc.[User_ID]='" + Session["USRID"].ToString() + "'");
                                ////dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,cl.p_cash from dbo.[BLoyaltyPointsEarned] bl inner join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id inner join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id inner join dbo.claimredeem cl on cl.compid=mss.Comp_ID where mss.Comp_ID='Comp-1203' and bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + Session["USRID"].ToString() + "') group by mss.Comp_ID,cl.p_cash");
                                ////dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where  bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + dt.Rows[0][0].ToString() + "') group by mss.Comp_ID,cl.p_cash");
                                //if (dtcp.Rows.Count > 0)
                                //{
                                //    //int totalpoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum([Points]) is null then 0 else Sum([Points]) end as point FROM [BLoyaltyPointsEarned] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[M_Consumerid] where mc.[User_ID]='" + Session["USRID"].ToString() + "'"));
                                //    int loyaltybonus = 0;

                                //    if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1278")
                                //    {
                                //        loyaltybonus = Convert.ToInt32(SQL_DB.ExecuteScalar("select isnull(sum(points),0) as points from buildloyalty_offers where m_consumerid=" + dt.Rows[0][1].ToString()).ToString());
                                //    }
                                //    int totalpoint = (Convert.ToInt32(dtcp.Rows[0]["point"].ToString()) - Convert.ToInt32(loyalty_return)) + loyaltybonus;
                                //    int redeempoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(bl.[RedeemPoints]) is null then 0 else Sum(isnull(bl.[RedeemPoints],0)) end FROM [BPointsTransaction] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[RedeemBy] where mc.[User_ID]='" + dt.Rows[0][0].ToString() + "' and (bl.bpstatus is null or bl.bpstatus<>'FAILURE')"));
                                //    int claimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [ClaimDetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.[User_ID]='" + dt.Rows[0][0].ToString() + "' and (cl.Isapproved=0 or cl.Isapproved=1)"));
                                //    float totalpointrt = Convert.ToInt32(dtcp.Rows[0]["p_cash"].ToString());
                                //    DataTable dtcondition = SQL_DB.ExecuteDataTable("select top 1 codition_point,condition_match from point_redeem_condition where comp_id='" + dtcp.Rows[0]["Comp_ID"].ToString() + "' and isactive=1 and selection_id=case when (select count(*) from paytmtransaction where m_consumerid='" + dt.Rows[0][1].ToString() + "' and comp_id='Comp-1214')>0 then 2 else 1 end ");

                                //    if (dtcondition.Rows.Count > 0)
                                //    {
                                //        tp = totalpoint - redeempoint - claimapply;
                                //        int rp = 0;
                                //        if (dtcondition.Rows[0]["condition_match"].ToString() == "1")
                                //        {
                                //            rp = tp % Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString());
                                //            rp = tp - rp;
                                //        }
                                //        else
                                //        {
                                //            if (tp >= Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))
                                //            {
                                //                rp = tp;
                                //            }
                                //        }
                                //        //int ptforrd = rp;
                                //        int ptforrd = tp - rp;
                                //        float tpr = ptforrd * totalpointrt;
                                //float tpr = tp * totalpointrt;
                                if (tp >= 0)
                                {

                                    if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1350")
                                    {
                                        if (Convert.ToDecimal(tp) >= 100 && Convert.ToDecimal(tp) < 200)
                                        {
                                            table.Rows[i]["Gift_value"] = "100";
                                        }
                                        else if (Convert.ToDecimal(tp) >= 200 && Convert.ToDecimal(tp) < 500)
                                        {
                                            table.Rows[i]["Gift_value"] = "230";
                                        }
                                        else if (Convert.ToDecimal(tp) >= 500)
                                        {
                                            table.Rows[i]["Gift_value"] = "600";
                                        }
                                    }
                                    else if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1412")
                                    {
                                        if (Convert.ToDecimal(tp) >= 5 && Convert.ToDecimal(tp) < 10)
                                        {
                                            table.Rows[i]["Gift_value"] = "12";
                                        }
                                        else if (Convert.ToDecimal(tp) >= 10 && Convert.ToDecimal(tp) < 20)
                                        {
                                            table.Rows[i]["Gift_value"] = "30";
                                        }

                                        else if (Convert.ToDecimal(tp) >= 20 && Convert.ToDecimal(tp) < 50)
                                        {
                                            table.Rows[i]["Gift_value"] = "65";
                                        }
                                        else if (Convert.ToDecimal(tp) >= 50 && Convert.ToDecimal(tp) < 100)
                                        {
                                            table.Rows[i]["Gift_value"] = "175";
                                        }

                                        else if (Convert.ToDecimal(tp) >= 100)
                                        {
                                            table.Rows[i]["Gift_value"] = "400";
                                        }
                                    }


                                    else
                                    {
                                        table.Rows[i]["Gift_value"] = tp.ToString();
                                    }

                                    // lblptmp.Text = tpr.ToString();
                                    if (tp >= Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))
                                    {
                                        //lbltp.Text = tp.ToString();
                                        //lblrp.Text = ptforrd.ToString();
                                        table.Rows[i]["comp_id"] = dtcp.Rows[0]["Comp_ID"].ToString();
                                        //lblptmm.Visible = false;
                                        //btnptmp.Visible = true;
                                        table.Rows[i]["btn_flag"] = 1;
                                    }
                                    else
                                    {
                                        if (tp < Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))
                                        {
                                            tpr = tp * totalpointrt;
                                            //lblptmp.Text = tpr.ToString();
                                            int reqp = Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()) - tp;
                                            //lblptmm.Text = "Collect " + reqp + " more points to redeem cash.";
                                            table.Rows[i]["gift_message"] = "Collect " + reqp + " more points to redeem cash.";
                                            table.Rows[i]["btn_flag"] = 0;
                                            //lblptmm.Visible = true;
                                        }
                                        //btnptmp.Visible = false;
                                    }

                                }
                                else
                                {
                                    //if (tp < 0)
                                    //    lblptmp.Text = tpr.ToString();
                                    int reqp = Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()) - tp;
                                    table.Rows[i]["gift_message"] = "Collect " + reqp + " more points to redeem cash.";
                                    table.Rows[i]["btn_flag"] = 0;
                                    //lblptmm.Text = "Collect " + reqp + " more points to redeem cash.";
                                    //lblptmm.Visible = true;

                                    //btnptmp.Visible = false;
                                }

                            }
                            else
                            {
                                if (Convert.ToInt32(table.Rows[i]["Gift_value"].ToString()) > tp)
                                {
                                    table.Rows[i]["gift_message"] = "You are not eligible for claim.";
                                    table.Rows[i]["btn_flag"] = 0;
                                    table.Rows[i]["Gift_image"] = "../" + table.Rows[i]["Gift_image"];
                                }
                                else
                                {
                                    table.Rows[i]["btn_flag"] = 1;
                                    table.Rows[i]["Gift_image"] = "../" + table.Rows[i]["Gift_image"];
                                }

                            }


                            //table.Rows[i]["gift_message"] = "You are not eligible for claim.";
                            //table.Rows[i]["btn_flag"] = 0;
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                throw;
            }



            ///////////////////////////////////
            string json = JsonConvert.SerializeObject(table, Formatting.Indented);

            context.Response.Write(json);


        }

        if (context.Request.QueryString["method"] == "Claim_1")
        {
            DataTable dt = new DataTable();
            dt = SQL_DB.ExecuteDataTable("select top 1 [user_id],M_Consumerid from m_consumer where right(mobileno,10)='" + context.Request.QueryString["userid"].Substring(context.Request.QueryString["userid"].Length - 10, 10) + "'");
            DataTable dtcp = null;
            if (dtcp != null)
            {
                dtcp.Rows.Clear();
            }
            dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where  bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + dt.Rows[0][0].ToString() + "') group by mss.Comp_ID,cl.p_cash");

            DataTable table = new DataTable();
            // where [gift_id]=4
            if (dtcp.Rows.Count != 0 && (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1400" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1278" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1285" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1375" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1350" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1466" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1434"))
            {
                if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1400" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1285" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1375" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1350" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1466" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1434")
                {
                    table = SQL_DB.ExecuteDataTable("select [gift_id],[Gift_name],[Gift_value] ,[Gift_desc],[Gift_image] from Claim_gift where [status]=1 and [gift_id]<>20 and CompID='" + dtcp.Rows[0]["Comp_ID"].ToString() + "' order by Gift_value");
                }
                else
                {
                    table = SQL_DB.ExecuteDataTable("select [gift_id],[Gift_name],[Gift_value] ,[Gift_desc],[Gift_image] from Claim_gift where [status]=1 and [gift_id]<>20 and  CompID is null order by Gift_value");
                }
            }
            else
            {

                table = SQL_DB.ExecuteDataTable("select [gift_id],[Gift_name],[Gift_value] ,[Gift_desc],[Gift_image] from Claim_gift where [gift_id]=20");
            }
            table.Columns.Add("gift_message");
            table.Columns.Add("btn_flag", typeof(Int32));
            table.Columns.Add("Comp_id");
            table.Columns["gift_message"].ReadOnly = false;
            table.Columns["btn_flag"].ReadOnly = false;
            table.Columns["Gift_value"].ReadOnly = false;
            ////////////////
            try
            {
                int tp = 0;

                string loyalty_return = SQL_DB.ExecuteScalar("select isnull(sum(loyalty),0) from scrap_entry se inner join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2 inner join m_consumer ms on ms.MobileNo=pe.MobileNo where pe.is_success=1 and  ms.M_Consumerid=" + dt.Rows[0][1].ToString()).ToString();
                //DataTable dt = SQL_DB.ExecuteDataTable("select distinct cr.Comp_Name from dbo.[M_consumer] mc inner join dbo.pro_enq pe on pe.mobileno = mc.mobileno inner join dbo.M_code mcod on pe.Received_Code1 = mcod.code1 and pe.Received_Code2 = mcod.code2 inner join dbo.pro_reg pr on mcod.pro_ID = pr.Pro_ID inner join dbo.comp_reg cr on pr.Comp_ID = cr.Comp_ID where cr.Comp_ID = 'Comp-1230' and mc.[User_ID]='" + Session["USRID"].ToString() + "'");
                //dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,cl.p_cash from dbo.[BLoyaltyPointsEarned] bl inner join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id inner join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id inner join dbo.claimredeem cl on cl.compid=mss.Comp_ID where mss.Comp_ID='Comp-1203' and bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + Session["USRID"].ToString() + "') group by mss.Comp_ID,cl.p_cash");
                //dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where  bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + dt.Rows[0][0].ToString() + "') group by mss.Comp_ID,cl.p_cash");
                if (dtcp.Rows.Count > 0)
                {
                    //int totalpoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum([Points]) is null then 0 else Sum([Points]) end as point FROM [BLoyaltyPointsEarned] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[M_Consumerid] where mc.[User_ID]='" + Session["USRID"].ToString() + "'"));
                    int loyaltybonus = 0;

                    if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1278" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1285" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1375" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1466")
                    {
                        loyaltybonus = Convert.ToInt32(SQL_DB.ExecuteScalar("select isnull(sum(points),0) as points from buildloyalty_offers where m_consumerid=" + dt.Rows[0][1].ToString()).ToString());
                    }
                    int totalpoint = (Convert.ToInt32(dtcp.Rows[0]["point"].ToString()) - Convert.ToInt32(loyalty_return)) + loyaltybonus;
                    int redeempoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(bl.[RedeemPoints]) is null then 0 else Sum(isnull(bl.[RedeemPoints],0)) end FROM [BPointsTransaction] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[RedeemBy] where mc.[User_ID]='" + dt.Rows[0][0].ToString() + "' and (bl.bpstatus is null or bl.bpstatus<>'FAILURE')"));
                    int claimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [ClaimDetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.[User_ID]='" + dt.Rows[0][0].ToString() + "' and (cl.Isapproved=1)"));
                    float totalpointrt = Convert.ToInt32(dtcp.Rows[0]["p_cash"].ToString());
                    DataTable dtcondition = SQL_DB.ExecuteDataTable("select top 1 codition_point,condition_match from point_redeem_condition where comp_id='" + dtcp.Rows[0]["Comp_ID"].ToString() + "' and isactive=1 and selection_id=case when (select count(*) from paytmtransaction where m_consumerid='" + dt.Rows[0][1].ToString() + "' and comp_id='Comp-1214')>0 then 2 else 1 end ");

                    if (dtcondition.Rows.Count > 0)
                    {

                        #region // For Jupiter Aqua Lines Ltd
                        if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1375")
                            tp = totalpoint - redeempoint;
                        else
                            #endregion

                            tp = totalpoint - redeempoint - claimapply;
                        int rp = 0;
                        if (dtcondition.Rows[0]["condition_match"].ToString() == "1")
                        {
                            rp = tp % Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString());
                            rp = tp - rp;
                        }
                        else
                        {
                            if (tp >= Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))
                            {
                                rp = tp;
                            }
                        }
                        //int ptforrd = rp;
                        int ptforrd = tp - rp;
                        float tpr = ptforrd * totalpointrt;
                        for (int i = 0; i < table.Rows.Count; i++)
                        {
                            if (table.Rows[i]["gift_id"].ToString() == "20")
                            {

                                //string loyalty_return = SQL_DB.ExecuteScalar("select isnull(sum(loyalty),0) from scrap_entry se inner join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2 inner join m_consumer ms on ms.MobileNo=pe.MobileNo where pe.is_success=1 and  ms.M_Consumerid=" + dt.Rows[0][1].ToString()).ToString();
                                ////DataTable dt = SQL_DB.ExecuteDataTable("select distinct cr.Comp_Name from dbo.[M_consumer] mc inner join dbo.pro_enq pe on pe.mobileno = mc.mobileno inner join dbo.M_code mcod on pe.Received_Code1 = mcod.code1 and pe.Received_Code2 = mcod.code2 inner join dbo.pro_reg pr on mcod.pro_ID = pr.Pro_ID inner join dbo.comp_reg cr on pr.Comp_ID = cr.Comp_ID where cr.Comp_ID = 'Comp-1230' and mc.[User_ID]='" + Session["USRID"].ToString() + "'");
                                ////dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,cl.p_cash from dbo.[BLoyaltyPointsEarned] bl inner join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id inner join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id inner join dbo.claimredeem cl on cl.compid=mss.Comp_ID where mss.Comp_ID='Comp-1203' and bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + Session["USRID"].ToString() + "') group by mss.Comp_ID,cl.p_cash");
                                ////dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where  bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + dt.Rows[0][0].ToString() + "') group by mss.Comp_ID,cl.p_cash");
                                //if (dtcp.Rows.Count > 0)
                                //{
                                //    //int totalpoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum([Points]) is null then 0 else Sum([Points]) end as point FROM [BLoyaltyPointsEarned] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[M_Consumerid] where mc.[User_ID]='" + Session["USRID"].ToString() + "'"));
                                //    int loyaltybonus = 0;

                                //    if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1278")
                                //    {
                                //        loyaltybonus = Convert.ToInt32(SQL_DB.ExecuteScalar("select isnull(sum(points),0) as points from buildloyalty_offers where m_consumerid=" + dt.Rows[0][1].ToString()).ToString());
                                //    }
                                //    int totalpoint = (Convert.ToInt32(dtcp.Rows[0]["point"].ToString()) - Convert.ToInt32(loyalty_return)) + loyaltybonus;
                                //    int redeempoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(bl.[RedeemPoints]) is null then 0 else Sum(isnull(bl.[RedeemPoints],0)) end FROM [BPointsTransaction] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[RedeemBy] where mc.[User_ID]='" + dt.Rows[0][0].ToString() + "' and (bl.bpstatus is null or bl.bpstatus<>'FAILURE')"));
                                //    int claimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [ClaimDetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.[User_ID]='" + dt.Rows[0][0].ToString() + "' and (cl.Isapproved=0 or cl.Isapproved=1)"));
                                //    float totalpointrt = Convert.ToInt32(dtcp.Rows[0]["p_cash"].ToString());
                                //    DataTable dtcondition = SQL_DB.ExecuteDataTable("select top 1 codition_point,condition_match from point_redeem_condition where comp_id='" + dtcp.Rows[0]["Comp_ID"].ToString() + "' and isactive=1 and selection_id=case when (select count(*) from paytmtransaction where m_consumerid='" + dt.Rows[0][1].ToString() + "' and comp_id='Comp-1214')>0 then 2 else 1 end ");

                                //    if (dtcondition.Rows.Count > 0)
                                //    {
                                //        tp = totalpoint - redeempoint - claimapply;
                                //        int rp = 0;
                                //        if (dtcondition.Rows[0]["condition_match"].ToString() == "1")
                                //        {
                                //            rp = tp % Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString());
                                //            rp = tp - rp;
                                //        }
                                //        else
                                //        {
                                //            if (tp >= Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))
                                //            {
                                //                rp = tp;
                                //            }
                                //        }
                                //        //int ptforrd = rp;
                                //        int ptforrd = tp - rp;
                                //        float tpr = ptforrd * totalpointrt;
                                //float tpr = tp * totalpointrt;
                                if (tp >= 0)
                                {

                                    if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1350")
                                    {
                                        if (Convert.ToDecimal(tp) >= 100 && Convert.ToDecimal(tp) < 200)
                                        {
                                            table.Rows[i]["Gift_value"] = "100";
                                        }
                                        else if (Convert.ToDecimal(tp) >= 200 && Convert.ToDecimal(tp) < 500)
                                        {
                                            table.Rows[i]["Gift_value"] = "230";
                                        }
                                        else if (Convert.ToDecimal(tp) >= 500)
                                        {
                                            table.Rows[i]["Gift_value"] = "600";
                                        }
                                    }



                                    else
                                    {
                                        table.Rows[i]["Gift_value"] = tp.ToString();
                                    }

                                    // lblptmp.Text = tpr.ToString();
                                    if (tp >= Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))
                                    {
                                        //lbltp.Text = tp.ToString();
                                        //lblrp.Text = ptforrd.ToString();
                                        table.Rows[i]["comp_id"] = dtcp.Rows[0]["Comp_ID"].ToString();
                                        //lblptmm.Visible = false;
                                        //btnptmp.Visible = true;
                                        table.Rows[i]["btn_flag"] = 1;
                                    }
                                    else
                                    {
                                        if (tp < Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))
                                        {
                                            tpr = tp * totalpointrt;
                                            //lblptmp.Text = tpr.ToString();
                                            int reqp = Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()) - tp;
                                            //lblptmm.Text = "Collect " + reqp + " more points to redeem cash.";
                                            table.Rows[i]["gift_message"] = "Collect " + reqp + " more points to redeem cash.";
                                            table.Rows[i]["btn_flag"] = 0;
                                            //lblptmm.Visible = true;
                                        }
                                        //btnptmp.Visible = false;
                                    }

                                }
                                else if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1412")
                                {
                                    if (Convert.ToDecimal(tp) >= 5 && Convert.ToDecimal(tp) < 10)
                                    {
                                        table.Rows[i]["Gift_value"] = "12";
                                    }
                                    else if (Convert.ToDecimal(tp) >= 10 && Convert.ToDecimal(tp) < 20)
                                    {
                                        table.Rows[i]["Gift_value"] = "30";
                                    }
                                    else if (Convert.ToDecimal(tp) >= 20 && Convert.ToDecimal(tp) < 50)
                                    {
                                        table.Rows[i]["Gift_value"] = "65";
                                    }
                                    else if (Convert.ToDecimal(tp) >= 50 && Convert.ToDecimal(tp) < 100)
                                    {
                                        table.Rows[i]["Gift_value"] = "175";
                                    }
                                    else if (Convert.ToDecimal(tp) >= 100)
                                    {
                                        table.Rows[i]["Gift_value"] = "400";
                                    }
                                }
                                else if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1483")
                                {
                                    if (Convert.ToDecimal(tp) >= 5 && Convert.ToDecimal(tp) < 10)
                                    {
                                        table.Rows[i]["Gift_value"] = "12";
                                    }
                                    else if (Convert.ToDecimal(tp) >= 10 && Convert.ToDecimal(tp) < 20)
                                    {
                                        table.Rows[i]["Gift_value"] = "30";
                                    }

                                    else if (Convert.ToDecimal(tp) >= 20 && Convert.ToDecimal(tp) < 50)
                                    {
                                        table.Rows[i]["Gift_value"] = "65";
                                    }
                                    else if (Convert.ToDecimal(tp) >= 50 && Convert.ToDecimal(tp) < 100)
                                    {
                                        table.Rows[i]["Gift_value"] = "175";
                                    }

                                    else if (Convert.ToDecimal(tp) >= 100)
                                    {
                                        table.Rows[i]["Gift_value"] = "400";
                                    }
                                }

                                else
                                {
                                    //if (tp < 0)
                                    //    lblptmp.Text = tpr.ToString();
                                    int reqp = Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()) - tp;
                                    table.Rows[i]["gift_message"] = "Collect " + reqp + " more points to redeem cash.";
                                    table.Rows[i]["btn_flag"] = 0;
                                    //lblptmm.Text = "Collect " + reqp + " more points to redeem cash.";
                                    //lblptmm.Visible = true;

                                    //btnptmp.Visible = false;
                                }

                            }
                            else
                            {
                                if (Convert.ToInt32(table.Rows[i]["Gift_value"].ToString()) > tp)
                                {
                                    table.Rows[i]["gift_message"] = "You are not eligible for claim.";
                                    table.Rows[i]["btn_flag"] = 0;
                                    table.Rows[i]["Gift_image"] = "../" + table.Rows[i]["Gift_image"];
                                }
                                else
                                {
                                    table.Rows[i]["btn_flag"] = 1;
                                    table.Rows[i]["Gift_image"] = "../" + table.Rows[i]["Gift_image"];
                                }

                            }


                            //table.Rows[i]["gift_message"] = "You are not eligible for claim.";
                            //table.Rows[i]["btn_flag"] = 0;
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                throw;
            }



            // this code use for hide paytm first time user registration and for company by id -- Tej,RUHE,JAL,INOX
            if (table.Rows[0]["Gift_value"].ToString() == "0" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1321" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1375")
            {
                table.Clear();
            }


            ///////////////////////////////////
            var response = new { result = table };
            string json = JsonConvert.SerializeObject(response, Formatting.Indented);

            context.Response.Write(json);


        }

        if (context.Request.QueryString["method"] == "dealerid")
        {
            string result = "";
            string mobile = string.Empty;
            if (context.Request.QueryString["mobile"] != null)
                mobile = context.Request.QueryString["mobile"];
            mobile = "91" + mobile.Substring(mobile.Length - 10, 10);
            DataTable dt = new DataTable();
            dt = SQL_DB.ExecuteDataTable("select top 1  isnull([Dealer Name],0) DealerName ,isnull(distributorID,0)distributorid  from M_Consumer left join dealership_details on dealership_details.[Dealer Code]=M_Consumer.distributorID where M_Consumer.mobileno='91" + mobile.Substring(mobile.Length - 10, 10) + "'");
            if (dt.Rows.Count > 0)
            {
                result += dt.Rows[0]["distributorid"].ToString() + "," + dt.Rows[0]["DealerName"].ToString();
            }
            else
            {
                result = "0";
            }
            context.Response.Write(result);
        }
        if (context.Request.QueryString["method"] == "SubmitClaim")
        {
            message_status messageobject = new message_status();
            try
            {
                string claimdetails = context.Request.QueryString["claimdetails"];
                DataProvider.LogManager.ErrorExceptionLog(claimdetails);
                Claim Log = new Claim();

                Log = JsonConvert.DeserializeObject<Claim>(claimdetails);
                DataTable dt = new DataTable();
                dt = SQL_DB.ExecuteDataTable("select top 1 [user_id],M_Consumerid from m_consumer where right(mobileno,10)='" + Log.Userid.Substring(Log.Userid.Length - 10, 10) + "'");

                ///////////////////////////////////////////////////////////

                DataTable dtcp = null;
                DataTable dtcondition = new DataTable();
                int tp = 0;
                int tprr = 0;        //oci
                if (dtcp != null)
                {
                    dtcp.Rows.Clear();
                }
                string loyalty_return = SQL_DB.ExecuteScalar("select isnull(sum(loyalty),0) from scrap_entry se inner join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2 inner join m_consumer ms on ms.MobileNo=pe.MobileNo where pe.is_success=1 and  ms.M_Consumerid=" + dt.Rows[0][1].ToString()).ToString();
                //DataTable dt = SQL_DB.ExecuteDataTable("select distinct cr.Comp_Name from dbo.[M_consumer] mc inner join dbo.pro_enq pe on pe.mobileno = mc.mobileno inner join dbo.M_code mcod on pe.Received_Code1 = mcod.code1 and pe.Received_Code2 = mcod.code2 inner join dbo.pro_reg pr on mcod.pro_ID = pr.Pro_ID inner join dbo.comp_reg cr on pr.Comp_ID = cr.Comp_ID where cr.Comp_ID = 'Comp-1230' and mc.[User_ID]='" + Session["USRID"].ToString() + "'");
                //dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,cl.p_cash from dbo.[BLoyaltyPointsEarned] bl inner join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id inner join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id inner join dbo.claimredeem cl on cl.compid=mss.Comp_ID where mss.Comp_ID='Comp-1203' and bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + Session["USRID"].ToString() + "') group by mss.Comp_ID,cl.p_cash");
                dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where  bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + dt.Rows[0][0].ToString() + "') group by mss.Comp_ID,cl.p_cash");
                if (dtcp.Rows.Count > 0)
                {
                    //int totalpoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum([Points]) is null then 0 else Sum([Points]) end as point FROM [BLoyaltyPointsEarned] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[M_Consumerid] where mc.[User_ID]='" + Session["USRID"].ToString() + "'"));
                    int loyaltybonus = 0;
                    //int totalpoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum([Points]) is null then 0 else Sum([Points]) end as point FROM [BLoyaltyPointsEarned] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[M_Consumerid] where mc.[User_ID]='" + Session["USRID"].ToString() + "'"));
                    if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1278" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1285" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1375" || dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1434")
                    {
                        loyaltybonus = Convert.ToInt32(SQL_DB.ExecuteScalar("select isnull(sum(points),0) as points from buildloyalty_offers where m_consumerid=" + dt.Rows[0][1].ToString()).ToString());
                    }
                    int totalpoint = (Convert.ToInt32(dtcp.Rows[0]["point"].ToString()) - Convert.ToInt32(loyalty_return)) + loyaltybonus;
                    int redeempoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(bl.[RedeemPoints]) is null then 0 else Sum(isnull(bl.[RedeemPoints],0)) end FROM [BPointsTransaction] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[RedeemBy] where mc.[User_ID]='" + dt.Rows[0][0].ToString() + "' and (bl.bpstatus is null or bl.bpstatus<>'FAILURE')"));
                    float totalpointrt = Convert.ToInt32(dtcp.Rows[0]["p_cash"].ToString());


                    if (dtcondition.Rows.Count > 0)
                    {
                        tp = totalpoint - redeempoint;
                    }


                    string CompID = Log.Comp_id;

                    int ptforrd = Convert.ToInt32(Log.Productvalue);
                    float tpr = ptforrd;
                    int lrp;
                    if (CompID == "Comp-1350")
                    {
                        if (Convert.ToDecimal(tpr) >= 100 && Convert.ToDecimal(tpr) < 200)
                        {
                            ptforrd = 100;
                        }
                        else if (Convert.ToDecimal(tpr) >= 200 && Convert.ToDecimal(tpr) < 500)
                        {
                            ptforrd = 230;
                        }
                        else if (Convert.ToDecimal(tpr) >= 500)
                        {
                            ptforrd = 600;
                        }

                        ptforrd = Convert.ToInt32(tpr);

                        if (tpr == 100)
                        {
                            tpr = 100;
                        }
                        else if (tpr == 230)
                        {
                            tpr = 200;
                        }
                        else if (tpr == 600)
                        {
                            tpr = 500;
                        }

                        lrp = tp - Convert.ToInt32(tpr);
                    }


                    else if (CompID == "Comp-1466")
                    {
                        if (Convert.ToDecimal(tpr) >= 200 && Convert.ToDecimal(tpr) < 500)
                        {
                            tprr = 200;
                            ptforrd = 200;
                        }
                        else if (Convert.ToDecimal(tpr) >= 500 && Convert.ToDecimal(tpr) < 1000)
                        {
                            tprr = 500;
                            ptforrd = 600;
                        }
                        else if (Convert.ToDecimal(tpr) >= 1000 && Convert.ToDecimal(tpr) < 2000)
                        {
                            tprr = 1000;
                            ptforrd = 1400;
                        }
                        else if (Convert.ToDecimal(tpr) >= 2000 && Convert.ToDecimal(tpr) < 3000)
                        {
                            tprr = 2000;
                            ptforrd = 3000;
                        }
                        else if (Convert.ToDecimal(tpr) >= 5000)
                        {

                            tprr = 5000;
                            ptforrd = 8000;
                        }



                        lrp = tp - tprr;
                    }

                    else if (CompID == "Comp-1483")
                    {
                        if (Convert.ToDecimal(tpr) >= 200 && Convert.ToDecimal(tpr) < 500)
                        {

                            ptforrd = Convert.ToInt32(tpr);
                        }
                        lrp = tp - ptforrd;
                    }


                    else if (CompID == "Comp-1412")
                    {
                        if (Convert.ToDecimal(tpr) >= 5 && Convert.ToDecimal(tpr) < 10)
                        {
                            ptforrd = 12;
                        }
                        else if (Convert.ToDecimal(tpr) >= 10 && Convert.ToDecimal(tpr) < 20)
                        {
                            ptforrd = 30;
                        }
                        else if (Convert.ToDecimal(tpr) >= 20 && Convert.ToDecimal(tpr) < 50)
                        {
                            ptforrd = 65;
                        }
                        else if (Convert.ToDecimal(tpr) >= 50 && Convert.ToDecimal(tpr) < 100)
                        {
                            ptforrd = 175;
                        }
                        else if (Convert.ToDecimal(tpr) >= 100)
                        {
                            ptforrd = 400;
                        }

                        ptforrd = Convert.ToInt32(tpr);

                        if (tpr == 12)
                        {
                            tpr = 5;
                        }
                        else if (tpr == 30)
                        {
                            tpr = 10;
                        }
                        else if (tpr == 65)
                        {
                            tpr = 20;
                        }
                        else if (tpr == 175)
                        {
                            tpr = 50;
                        }
                        else if (tpr == 400)
                        {
                            tpr = 100;
                        }

                        lrp = tp - Convert.ToInt32(tpr);
                    }
                    else
                    {
                        lrp = tp - ptforrd;
                    }

                    string ps = string.Empty;
                    string msg = "";
                    DataTable dtconsumer = SQL_DB.ExecuteDataTable("select m_consumerid from m_consumer where m_consumerid='" + dt.Rows[0][1].ToString() + "' and aadharfile is not null and aadharback is not null");
                    if (dtconsumer.Rows.Count > 0 || Log.Comp_id == "Comp-1227" || Log.Comp_id == "Comp-1350" || Log.Comp_id == "Comp-1412" || Log.Comp_id == "Comp-1466" || Log.Comp_id == "Comp-1483" || Log.Comp_id == "Comp-1434")
                    {
                        dtcondition = SQL_DB.ExecuteDataTable("select top 1 codition_point,condition_match from point_redeem_condition where comp_id='" + dtcp.Rows[0]["Comp_ID"].ToString() + "' and isactive=1 and selection_id=case when (select count(*) from paytmtransaction where m_consumerid='" + dt.Rows[0][1].ToString() + "' and pstatus='SUCCESS' and comp_id='Comp-1214')>0 then 2 else 1 end ");
                        if (ptforrd >= Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))
                        {
                            string cn = SQL_DB.ExecuteScalar("select Comp_Name from dbo.[comp_reg] where comp_id='" + dtcp.Rows[0]["Comp_ID"].ToString() + "'").ToString();
                            string mb = SQL_DB.ExecuteScalar("select mobileno from dbo.m_consumer where user_id='" + dt.Rows[0][0].ToString() + "'").ToString();
                            string oid = SQL_DB.ExecuteScalar("select (ISNULL(max(orderid),1000))+1 as orderid from [dbo].[paytmtransaction]").ToString();

                            if (cn == "COATS BATH FITTINGS" || cn == "R.S Industries" || cn == "Jupiter Aqua Lines Ltd" || cn == "Veena Polymers" || cn == "Inox Decor Pvt Ltd")
                            {
                                DataTable Total_Days = SQL_DB.ExecuteDataTable("select top 1 DATEDIFF(day, Enq_Date, GETDATE()) AS Days_Total from Pro_Enq where MobileNo='" + mb + "' and Is_Success=1 order by Enq_Date asc ");



                                DataTable dtcondition1 = SQL_DB.ExecuteDataTable("select 'x' from [ClaimDetails] left join M_Consumer on right(M_Consumer.MobileNo, 10) = right([ClaimDetails].Mobileno, 10) where M_Consumer.M_Consumerid = '" + dt.Rows[0][1].ToString() + "' and[Isapproved] = 0");



                                int giftValue = Convert.ToInt32(Log.Productvalue);
                                DataTable GiftsTbl = SQL_DB.ExecuteDataTable("select * from Claim_gift where CompID='" + dtcp.Rows[0]["Comp_ID"].ToString() + "' and Gift_value='" + giftValue + "'");
                                string GiftName = "Gift value not match!";
                                if (GiftsTbl.Rows.Count > 0)
                                {
                                    GiftName = GiftsTbl.Rows[0]["Gift_name"].ToString();
                                }

                                if (dtcondition1.Rows.Count > 0)
                                {
                                    messageobject.status = "Unsuccess";
                                    msg = "Your Request Already Registered with US for points " + ptforrd;
                                }
                                else
                                {
                                    if (Log.Comp_id == "Comp-1434")
                                    {
                                        if (Convert.ToInt32(Total_Days.Rows[0]["Days_Total"].ToString()) >= 30)
                                        {
                                            SQL_DB.ExecuteNonQuery("insert into ClaimDetails([Claim_date],[Mobileno],[Amount],[Gifts_Redeemed],[document_status],[action_date],[Isapproved],[Comp_id]) values(GETDATE(),'" + mb + "'," + tpr.ToString() + ",'" + GiftName + "',1,null,0,'" + dtcp.Rows[0]["Comp_ID"].ToString() + "') ");
                                            msg = "Your Request Registered with US for points " + ptforrd;
                                        }
                                        else
                                        {
                                            msg = "Your are not eligible for claim Please try after " + (30 - Convert.ToInt32(Total_Days.Rows[0]["Days_Total"].ToString())) + " " + "Days";
                                        }
                                    }
                                    else
                                    {

                                        SQL_DB.ExecuteNonQuery("insert into ClaimDetails([Claim_date],[Mobileno],[Amount],[document_status],[action_date],[Isapproved],[Comp_id]) values(GETDATE(),'" + mb + "'," + tpr.ToString() + ",1,null,0,'" + dtcp.Rows[0]["Comp_ID"].ToString() + "') ");
                                        messageobject.status = "Success";
                                        msg = "Your Request Registered with US for points " + ptforrd;
                                    }
                                }



                                messageobject.message = msg;
                            }
                            else
                            {
                                ps = ServiceLogic.Paytm_Cash(mb, ptforrd.ToString(), oid, null, cn);
                                if (Log.Comp_id == "Comp-1350" || Log.Comp_id == "Comp-1412" || Log.Comp_id == "Comp-1466" || Log.Comp_id == "Comp-1483")
                                {
                                    if (ps.Contains("ACCEPTED"))
                                    {

                                        if (Log.Comp_id == "Comp-1466")
                                        {
                                            messageobject.status = "Success";

                                            SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + dtcp.Rows[0]["Comp_ID"].ToString() + "','" + mb + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + dt.Rows[0][1].ToString() + "'," + ptforrd + ",'Accepted','" + oid + "')");
                                            SQL_DB.ExecuteNonQuery("insert into BPointsTransaction([Transsctionid],[TotalPoints],[RedeemPoints],[Redeemdate],[RedeemBy],Incash,bpstatus) values(1," + tp + "," + tprr + ",'" + System.DateTime.Now.ToString("yyyy-MM-dd") + "','" + dt.Rows[0][1].ToString() + "'," + ptforrd + ",'Accepted')");
                                            msg = "Your request registered with us for points " + tprr + " for amount- " + ptforrd;
                                            messageobject.message = msg;
                                        }

                                        else
                                        {



                                            messageobject.status = "Success";

                                            SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + dtcp.Rows[0]["Comp_ID"].ToString() + "','" + mb + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + dt.Rows[0][1].ToString() + "'," + ptforrd + ",'Accepted','" + oid + "')");
                                            SQL_DB.ExecuteNonQuery("insert into BPointsTransaction([Transsctionid],[TotalPoints],[RedeemPoints],[Redeemdate],[RedeemBy],Incash,bpstatus) values(1," + tp + "," + tpr + ",'" + System.DateTime.Now.ToString("yyyy-MM-dd") + "','" + dt.Rows[0][1].ToString() + "'," + ptforrd + ",'Accepted')");
                                            msg = "Your request registere with us for points " + tpr + " for amount- " + ptforrd;
                                            messageobject.message = msg;



                                        }


                                    }
                                    else
                                    {

                                        SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + dtcp.Rows[0]["Comp_ID"].ToString() + "','" + mb + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + dt.Rows[0][1].ToString() + "'," + ptforrd + ",'FAILURE','" + oid + "')");
                                        msg = "Your Redemption is Fail for points " + tpr;
                                        messageobject.status = "Unsuccess";
                                        messageobject.message = msg;

                                    }
                                }
                                else
                                {


                                    if (ps.Contains("ACCEPTED"))
                                    {
                                        messageobject.status = "Success";
                                        //btnptmp.Visible = false;
                                        SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + dtcp.Rows[0]["Comp_ID"].ToString() + "','" + mb + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + dt.Rows[0][1].ToString() + "'," + tpr + ",'Accepted','" + oid + "')");
                                        SQL_DB.ExecuteNonQuery("insert into BPointsTransaction([Transsctionid],[TotalPoints],[RedeemPoints],[Redeemdate],[RedeemBy],Incash,bpstatus) values(1," + tp + "," + ptforrd + ",'" + System.DateTime.Now.ToString("yyyy-MM-dd") + "','" + dt.Rows[0][1].ToString() + "'," + tpr + ",'Accepted')");
                                        msg = "Your request registered with us for points " + ptforrd + " for amount- " + tpr;
                                        messageobject.message = msg;
                                        //lblptmp.Text = lrp.ToString();
                                        //lblptmm.Text = msg;
                                        //lblptmm.Visible = true;
                                        //string message = "alert('" + msg + "')";
                                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                                        //btnptmp.Visible = false;
                                    }
                                    else
                                    {
                                        SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + Log.Comp_id + "','" + mb + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + dt.Rows[0][1].ToString() + "'," + tpr + ",'FAILURE','" + oid + "')");
                                        msg = "Your Redemption is " + ps;
                                        //lblptmp.Text = lrp.ToString();
                                        messageobject.status = "Unsuccess";
                                        messageobject.message = msg;
                                        //lblptmm.Text = msg;
                                        //lblptmm.Visible = true;
                                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                                    }
                                }
                            }
                        }
                        else
                        {
                            msg = "You Redemption is " + ps;
                            messageobject.status = "Unsuccess";
                            messageobject.message = msg;
                            //lblptmp.Text = lrp.ToString();
                            //lblptmm.Text = msg;
                            //lblptmm.Visible = true;
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                        }
                    }
                    else
                    {
                        msg = "Please Uplaod the Documents first";
                        //lblptmp.Text = lrp.ToString();
                        messageobject.status = "Unsuccess";
                        messageobject.message = msg;
                        //lblptmm.Text = msg;
                        //lblptmm.Visible = true;
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);

                    }

                    //////////////////////////////////////////////////////////////
                }
            }
            catch (Exception ex)
            {
                messageobject.status = "Unsuccess";
            }
            context.Response.Write(JsonConvert.SerializeObject(messageobject, Formatting.Indented));
        }
        else if (context.Request.QueryString["method"] == "Issue")
        {
            string Result = string.Empty;
            string Issue = context.Request.QueryString["Issue"];
            string code = context.Request.QueryString["code"];
            string userid = context.Request.QueryString["userid"];

            int issuescount = Convert.ToInt32(SQL_DB.ExecuteScalar("select count([Useid]) from user_issue where [Useid]='" + userid + "' and [Code]=" + code + " and [status]=0"));
            if (issuescount == 0)
            {
                SQL_DB.ExecuteNonQuery("insert into user_issue values('" + userid + "','" + Issue + "','" + System.DateTime.Now.ToString("MM-dd-yyyy HH: mm:ss") + "'," + code + ",0)");

                Result = "Success=Query has been submitted successfully! , our representative will connect with you shortly";
            }
            else
            {

                Result = "Success=Our Team is Working on this! , our representative will connect with you shortly";
            }
            context.Response.Write(Result);

        }
        else if (context.Request.QueryString["method"] == "selectIssue")
        {
            try
            {
                string Result = string.Empty;
                string code = context.Request.QueryString["code"];
                string userid = context.Request.QueryString["userid"];

                int issuescount = Convert.ToInt32(SQL_DB.ExecuteScalar("select count([Useid]) from user_issue where [Useid]='" + userid + "' and [Code]=" + code + " and [status]=0"));
                //message_status msg = new message_status();
                //if (issuescount > 0)
                //    msg.status = "Unsuccess";
                //else
                //{
                //    msg.status = "Success";
                //}
                //Result = JsonConvert.SerializeObject(msg);
                context.Response.Write(issuescount.ToString());
            }
            catch (Exception ex)
            {
                DataProvider.LogManager.ErrorExceptionLog(DateTime.Now.ToLongDateString() + ": Exception at Masterhandler on selectIssue condition" + Environment.NewLine + " Error: " + ex.Message + Environment.NewLine + " Parameter: userid=" + context.Request.QueryString["userid"] + " and code=" + context.Request.QueryString["code"]);
                throw ex;
            }
        }
        else if (context.Request.QueryString["method"] == "Appcodecheck")
        {
            try
            {
                string Encrypt_code = context.Request.QueryString["scan"];
                string mobile = context.Request.QueryString["mobile"];
                DataProvider.LogManager.ErrorExceptionLog(Encrypt_code);

                string mode;
                if (context.Request.QueryString["mode"] == "")
                    mode = "App_mode";
                else
                    mode = context.Request.QueryString["mode"];

                if (Encrypt_code.Contains("aspx?id="))
                {
                    Encrypt_code = Encrypt_code.Substring(Encrypt_code.IndexOf('?') + 1);
                    string result = DecryptCode(Encrypt_code.Split('=')[1]);

                    allcodes[0] = result.Substring(result.IndexOf('=') + 1, 5).ToString();
                    allcodes[1] = result.Substring(result.LastIndexOf('=') + 1, 8).ToString();

                }
                else
                {
                    string codes = Encrypt_code;
                    if (Encrypt_code.Contains("="))
                    {
                        codes = Encrypt_code.Split(new char[] { '=' })[1];
                    }


                    if (codes.Contains("-"))
                        allcodes = codes.Split(new char[] { '-' });
                    else
                    {
                        allcodes[0] = codes.Substring(0, 5);
                        allcodes[1] = codes.Substring(5, 8);
                    }

                }
                context.Response.Write(appcheckWarranty(allcodes[0], allcodes[1], mobile, mode));
            }
            catch (Exception ex)
            {
                message_status ms = new message_status();
                ms.status = "No correct 13 digit code found";
                context.Response.Write(JsonConvert.SerializeObject(ms));
            }

        }
        if (context.Request.QueryString["method"] == "claim")
        {
            string claimdetails = context.Request.QueryString["claimdetails"];
            string result = string.Empty;
            try
            {
                Claim Log = new Claim();
                Log = JsonConvert.DeserializeObject<Claim>(claimdetails);
                result = "Success";
            }
            catch (Exception ex)
            {

            }

            context.Response.Write(result);
        }
        if (context.Request.QueryString["method"] == "update_user")
        {
            string usr_details = context.Request.QueryString["usr_details"];


            try
            {

                User_Details Log = new User_Details();
                Log = JsonConvert.DeserializeObject<User_Details>(usr_details);

                Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));

                string result = string.Empty;


                DataTable dtdistid = SQL_DB.ExecuteDataTable("Select distributorID  from M_consumer where MobileNo='" + Log.MobileNo + "'  ");

                string aadharback = "";
                string aadharFile = "";
                if (Log.aadharback != null)
                    aadharback = Log.aadharback.Replace("\"", "").Replace("\\", "");
                if (Log.aadharFile != null)
                    aadharFile = Log.aadharFile.Replace("\"", "").Replace("\\", "");

                if (aadharback == "/img/aadharFile/null.jpg" || aadharback == "/img/aadharFile/null_back.jpg" || aadharFile == "/img/aadharFile/null.jpg" || aadharFile == "/img/aadharFile/null_back.jpg" || Log.M_Consumerid == "0")
                {
                    message_status msg = new message_status();
                    msg.status = "Error";
                    if (Log.M_Consumerid == "0")
                        msg.message = "please try againm later!";
                    else
                        msg.message = "Kindly reupload your document or try again later !";

                    result = JsonConvert.SerializeObject(msg);
                    context.Response.Write(result);
                    return;
                }


                if (Log.distributorID == null || Log.distributorID == "")
                {
                    if (dtdistid.Rows.Count == 0)
                    {
                        Log.distributorID = "";
                    }
                    else
                    {
                        Log.distributorID = dtdistid.Rows[0][0].ToString();
                    }
                }

                if (Log.employeeID == null)
                    Log.employeeID = "";




                if (Log.distributorID.Trim() != "" && Log.employeeID.Trim() != "")
                {
                    DataTable dsCheckDealer = SQL_DB.ExecuteDataTable("Select * from M_DealerMaster where replace(ltrim(replace(DealerTechnicianId,'0',' ')),' ','0') ='" + Log.employeeID.Replace("'", "''").TrimStart(new Char[] { '0' }) + "' and replace(ltrim(replace(DealerCode,'0',' ')),' ','0')='" + Log.distributorID.Replace("'", "''").TrimStart(new Char[] { '0' }) + "'");
                    if (dsCheckDealer.Rows.Count > 0)
                    {
                        result = User_Details.appInsertUpdateUserDetails(Log);
                        if (Log.Profile_image == null)
                            Log.Profile_image = "";

                        if (Log.Profile_image != "")
                        {
                            Log.Profile_image = Log.Profile_image.Replace("\"", "").Replace("\\", "");
                            if (Convert.ToInt32(SQL_DB.ExecuteScalar("select count(m_consumerid) from Profile_images where m_consumerid=" + Log.M_Consumerid)) > 0)
                            {
                                SQL_DB.ExecuteScalar("update Profile_images set profile_img='" + Log.Profile_image + "' where m_consumerid=" + Log.Consumer_ID);
                            }
                            else
                            {
                                SQL_DB.ExecuteScalar("insert into Profile_images values(" + Log.Consumer_ID + ",'" + Log.Profile_image + "')");
                            }
                        }
                    }
                    else
                    {
                        message_status msg = new message_status();
                        msg.status = "Error";
                        msg.message = "Technician ID or Dealer Code are not correct!";

                        result = JsonConvert.SerializeObject(msg);

                    }
                }
                else
                {
                    result = User_Details.appInsertUpdateUserDetails(Log);
                    if (Log.Profile_image == null)
                        Log.Profile_image = "";

                    if (Log.Profile_image != "")
                    {
                        if (Convert.ToInt32(SQL_DB.ExecuteScalar("select count(m_consumerid) from Profile_images where m_consumerid=" + Log.M_Consumerid)) > 0)
                        {
                            SQL_DB.ExecuteScalar("update Profile_images set profile_img='" + Log.Profile_image + "' where m_consumerid=" + Log.Consumer_ID);
                        }
                        else
                        {
                            SQL_DB.ExecuteScalar("insert into Profile_images values(" + Log.Consumer_ID + ",'" + Log.Profile_image + "')");
                        }
                    }
                }
                context.Response.Write(result);
            }
            catch (Exception ex)
            {
                DataProvider.LogManager.ErrorExceptionLog(DateTime.Now.ToLongDateString() + ": Exception at Masterhandler on update_user condition" + Environment.NewLine + " Error: " + ex.Message + Environment.NewLine + " Parameter: " + JsonConvert.DeserializeObject<User_Details>(usr_details));
                throw ex;
            }
        }
        if (context.Request.QueryString["method"] == "update_bank")
        {
            string usr_details = context.Request.QueryString["bank_details"];

            Object9420 Log = new Object9420();
            Log = JsonConvert.DeserializeObject<Object9420>(usr_details);
            string result = "";
            message_status msg = new message_status();

            result = function9420.appBankInfo(Log);

            //Log.DML = "I";
            //Log.Entry_Date=Convert.ToDateTime(Convert.ToDateTime(Log.strEntry_Date).ToString("yyyy/MM/dd hh:mm:ss tt"));




            context.Response.Write(result);
            // User_Details.InsertUpdateUserDetails(Log);
        }
        if (context.Request.QueryString["method"] == "bankdetails")
        {
            string result = string.Empty;
            string consumer_id = context.Request.QueryString["userid"];
            User_Details Log = new User_Details();
            Log.User_ID = consumer_id;
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            int consumerid = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
            string bnkid = (string)SQL_DB.ExecuteScalar("SELECT top 1 case when [Bank_ID]=null then ' ' else [Bank_ID] end as Bank_ID FROM [M_BankAccount] where [M_Consumerid] = '" + consumerid + "' order by [Entry_Date] desc");
            bank_responses Bnk = new bank_responses();
            Bnk.Bank_ID = bnkid;
            Bnk.M_ConsumeriD = consumerid;
            function9420.GetappBankInfo(Bnk);
            context.Response.Write(JsonConvert.SerializeObject(Bnk, Formatting.Indented));
        }
        else if (context.Request.QueryString["method"] == "Summary")
        {
            string result = string.Empty;
            string consumer_id = context.Request.QueryString["userid"];
            User_Details Log = new User_Details();
            Log.User_ID = consumer_id;
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            int consumerid = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
            DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("[company_service]", Convert.ToInt32(consumerid));
            context.Response.Write(JsonConvert.SerializeObject(dtTrans.Tables[0], Formatting.Indented));

        }

        else if (context.Request.QueryString["method"] == "Summary_1")
        {
            string result = string.Empty;
            string consumer_id = context.Request.QueryString["userid"];
            User_Details Log = new User_Details();
            Log.User_ID = consumer_id;
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            int consumerid = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
            DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("[company_service]", Convert.ToInt32(consumerid));
            var response = new { result = dtTrans.Tables[0] };
            context.Response.Write(JsonConvert.SerializeObject(response, Formatting.Indented));
        }


        else if (context.Request.QueryString["method"] == "Dashboard")
        {
            string result = string.Empty;
            string consumer_id = context.Request.QueryString["userid"];
            User_Details Log = new User_Details();
            Log.User_ID = consumer_id;
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            int consumerid = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
            string distributorid = string.Empty;
            bool flg = false;
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["distributorID"] != null)
                {
                    if (dt.Rows[0]["distributorID"].ToString() != "")
                    {
                        distributorid = dt.Rows[0]["distributorID"].ToString();
                        string com = SQL_DB.ExecuteScalar("select Comp_Name from m_dealermaster md left join comp_reg cr on cr.Comp_ID=md.Comp_id where dealercode='" + distributorid + "'").ToString();
                        if (com == "JOHNSON PAINTS CO.")
                        {
                            flg = true;
                        }
                    }
                }
            }
            Query_responses query = new Query_responses();
            ///////////////////
            /////////////////////Code Scan/////////////////////
            ///////////////
            DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("dashboarddata", Convert.ToInt32(consumerid), distributorid);
            DataTable dtrecord = new DataTable();
            int claimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [ClaimDetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.M_Consumerid='" + consumerid + "' and (cl.Isapproved=1)"));
            query.totalCode = dtTrans.Tables[0].Rows[0][0].ToString();
            //query.reedemPoint = dtTrans.Tables[0].Rows[1][0].ToString();
            query.reedemPoint = (Convert.ToInt32(dtTrans.Tables[0].Rows[1][0].ToString()) + claimapply).ToString();

            #region //** For VRkable redeempoint
            DataTable VRdt = new DataTable();
            VRdt = SQL_DB.ExecuteDataTable("select Comp_Name from comp_reg cr left join M_Consumer mc on mc.Comp_ID=cr.Comp_id where M_Consumerid='" + consumerid + "'");
            if (VRdt.Rows.Count > 0)
            {


                if (VRdt.Rows[0]["Comp_Name"].ToString() == "VR KABLE INDIA PRIVATE LIMITED")
                {
                    query.reedemPoint = (Convert.ToInt32(dtTrans.Tables[0].Rows[1][0].ToString())).ToString();
                }

            }
            #endregion

            query.successCode = dtTrans.Tables[0].Rows[2][0].ToString();
            // lblunsuccess.Text = (Convert.ToInt32(lblttlcode.Text) - Convert.ToInt32(lblsuccesscode.Text)).ToString();
            ///////////////////
            //////////////////////point and Cash/////////////////////
            ///////////////
            string loyalty_return = SQL_DB.ExecuteScalar("select isnull(sum(loyalty),0) from scrap_entry se inner join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2 inner join m_consumer ms on ms.MobileNo=pe.MobileNo where pe.Is_Success=1 and ms.M_Consumerid= " + consumerid).ToString();
            if (flg)
            {
                #region //** For updated wallet balance query for JPC for Application

                DataSet ds = ExecuteNonQueryAndDatatable.FillTransactions("JPCWalletbalanceConsumerwise", consumerid, distributorid);

                dtrecord = ds.Tables[0];

                //dtrecord = SQL_DB.ExecuteDataTable("select (SELECT case when Sum(convert(int,[Points])) is null then 0 else Sum(convert(int,[Points])) end FROM [BLoyaltyPointsEarned] where [M_Consumerid]= " + Session["M_ConsumeriD"] + "), isnull((case when Sum(convert(decimal(10,2),cash)) is null then 0 else Sum(convert(decimal(10,2),cash)) end)+((case when Sum(convert(decimal(10,2),cash)) is null then 0 else Sum(convert(decimal(10,2),Cash)) end)*(select top 1 calculation_value from loyalty_calculation where comp_id=max(mcon.compid))/100),0) ,Count([Gift]) from BLoyaltyPointsEarned bl inner join BuiltLoyaltyMCodeCheck blc on blc.Pkid=bl.BuildLoyaltyOrReferralMCodeCheckid inner join M_Consumer_M_Code mcon on  mcon.m_consumer_mcodeid=blc.m_consumer_mcodeid inner join m_code code on code.row_id=mcon.M_Codeid inner join Pro_Enq pe on pe.received_code1=code.code1 and pe.received_code2=code.code2 inner join enq_dealerid dealer on dealer.enq_id=pe.row_id inner join M_Consumer cons on cons.distributorID=dealer.dealerid where cons.M_Consumerid=" + Session["M_ConsumeriD"] + " and pe.is_success=1");
                #endregion

            }
            else
            {
                dtrecord = SQL_DB.ExecuteDataTable("SELECT case when Sum(convert(int,[Points])) is null then 0 else Sum(convert(int,[Points])) end, case when Sum(convert(int,[Cash])) is null then 0 else Sum(convert(int,[Cash])) end ,Count([Gift]) FROM [BLoyaltyPointsEarned] where [M_Consumerid]= " + consumerid);
            }
            int loyaltybonus = 0;
            //int totalpoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum([Points]) is null then 0 else Sum([Points]) end as point FROM [BLoyaltyPointsEarned] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[M_Consumerid] where mc.[User_ID]='" + Session["USRID"].ToString() + "'"));

            loyaltybonus = Convert.ToInt32(SQL_DB.ExecuteScalar("select isnull(sum(points),0) as points from buildloyalty_offers where m_consumerid=" + consumerid).ToString());


            query.totalCash = dtrecord.Rows[0][1].ToString();
            query.transferredCash = dtTrans.Tables[0].Rows[3][0].ToString();
            if (query.transferredCash == "")
                query.transferredCash = "0";


            //lblcashbalance.Text= (Convert.ToInt32(lblcashback.Text) - Convert.ToInt32(lblredeem.Text)).ToString();
            query.totalPoint = ((Convert.ToDecimal(dtrecord.Rows[0][0].ToString()) - Convert.ToDecimal(loyalty_return)) + loyaltybonus).ToString();
            //query.totalPoint = dtrecord.Rows[0][0].ToString();
            //lblpointbalance.Text= (Convert.ToInt32(lblgift.Text) - Convert.ToInt32(lblgiftrec.Text)).ToString();
            dtrecord.Clear();
            ///////////////////
            //////////////////////Warranty count/////////////////////
            ///////////////

            dtrecord = SQL_DB.ExecuteDataTable("select wr.* from [WarrentyDetails] wr with(nolock) where wr.[Mobile] like CONCAT('%',(SELECT SUBSTRING( MobileNo, 3, 12 ) FROM M_Consumer where [M_Consumerid]=" + consumerid + ")) and wr.[Mobile]<>''");
            if (dtrecord.Rows.Count > 0)
            {
                DataRow[] warranty = dtrecord.Select("PurchaseDate>='" + DateTime.Today.AddYears(-1) + "'");
                query.totalWarranty = dtrecord.Rows.Count.ToString();
                query.underWarranty = warranty.Length.ToString();
            }
            else
            {
                query.totalWarranty = "0";
                query.underWarranty = "0";
            }

            DataSet dtTranscounter = ExecuteNonQueryAndDatatable.FillTransactions("[counterfeitcode]", Convert.ToInt32(consumerid));
            query.totalcounterfeit = dtTranscounter.Tables[0].Rows[0][0].ToString();
            query.successcounterfeit = dtTranscounter.Tables[0].Rows[1][0].ToString();

            ServiceLogic.Paytm_Status();

            context.Response.Write(JsonConvert.SerializeObject(query, Formatting.Indented));
        }

        else if (context.Request.QueryString["method"] == "Dashboard_VR")
        {
            string result = string.Empty;
            string consumer_id = context.Request.QueryString["userid"];
            User_Details Log = new User_Details();
            Log.User_ID = consumer_id;
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            int consumerid = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
            string distributorid = string.Empty;
            bool flg = false;

            Query_responses query = new Query_responses();
            ///////////////////
            /////////////////////Code Scan/////////////////////
            ///////////////
            DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("dashboarddataVR", Convert.ToInt32(consumerid), distributorid);
            DataTable dtrecord = new DataTable();
            int claimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [ClaimDetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.M_Consumerid='" + consumerid + "' and (cl.Isapproved=1) and mc.Comp_id='Comp-1400'"));
            query.totalCode = dtTrans.Tables[0].Rows[0][0].ToString();
            //query.reedemPoint = dtTrans.Tables[0].Rows[1][0].ToString();
            query.reedemPoint = (Convert.ToInt32(dtTrans.Tables[0].Rows[1][0].ToString()) + claimapply).ToString();
            string com1 = SQL_DB.ExecuteScalar("select Comp_Name from comp_reg cr left join M_Consumer mc on mc.Comp_ID=cr.Comp_id where M_Consumerid='" + consumerid + "'").ToString();
            if (com1 == "VR KABLE INDIA PRIVATE LIMITED")
            {
                query.reedemPoint = (Convert.ToInt32(dtTrans.Tables[0].Rows[1][0].ToString())).ToString();
            }
            query.successCode = dtTrans.Tables[0].Rows[2][0].ToString();
            // lblunsuccess.Text = (Convert.ToInt32(lblttlcode.Text) - Convert.ToInt32(lblsuccesscode.Text)).ToString();
            ///////////////////
            //////////////////////point and Cash/////////////////////
            ///////////////
            string loyalty_return = SQL_DB.ExecuteScalar("select isnull(sum(loyalty),0) from scrap_entry se inner join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2 inner join m_consumer ms on ms.MobileNo=pe.MobileNo where pe.Is_Success=1 and ms.M_Consumerid= " + consumerid + " and ms.Comp_id='Comp-1400'").ToString();

            // dtrecord = SQL_DB.ExecuteDataTable("SELECT case when Sum(convert(int,[Points])) is null then 0 else Sum(convert(int,[Points])) end, case when Sum(convert(int,[Cash])) is null then 0 else Sum(convert(int,[Cash])) end ,Count([Gift]) FROM [BLoyaltyPointsEarned] as a,m_consumer as ms where a.[M_Consumerid]=ms.[M_Consumerid] and  a.[M_Consumerid]= " + consumerid + " and ms.Comp_id='Comp-1400'");
            //string qryy =  "select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where mss.Comp_ID='Comp-1262' and bl.M_consumerid = (select M_consumerid from dbo.m_consumer where M_Consumerid= " + consumerid +") group by mss.Comp_ID,cl.p_cash";
            dtrecord = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where mss.Comp_ID='Comp-1400' and bl.M_consumerid = (select M_consumerid from dbo.m_consumer where M_Consumerid= " + consumerid + ") group by mss.Comp_ID,cl.p_cash");

            int loyaltybonus = 0;
            //int totalpoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum([Points]) is null then 0 else Sum([Points]) end as point FROM [BLoyaltyPointsEarned] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[M_Consumerid] where mc.[User_ID]='" + Session["USRID"].ToString() + "'"));

            loyaltybonus = Convert.ToInt32(SQL_DB.ExecuteScalar("select isnull(sum(points),0) as points from buildloyalty_offers as a,m_consumer as ms where a.m_consumerid=" + consumerid + " and ms.Comp_id='Comp-1400' ").ToString());
            query.totalCash = '0'.ToString();
            if (dtrecord.Rows.Count > 0)
            {

                query.totalCash = dtrecord.Rows[0][1].ToString();
            }
            query.transferredCash = dtTrans.Tables[0].Rows[3][0].ToString();
            if (query.transferredCash == "")
                query.transferredCash = "0";


            //lblcashbalance.Text= (Convert.ToInt32(lblcashback.Text) - Convert.ToInt32(lblredeem.Text)).ToString();
            //query.totalPoint = (Convert.ToDecimal('0'.ToString()));
            if (dtrecord.Rows.Count > 0)
            {

                query.totalPoint = ((Convert.ToDecimal(dtrecord.Rows[0][1].ToString()) - Convert.ToDecimal(loyalty_return)) + loyaltybonus).ToString();
            }
            //query.totalPoint = dtrecord.Rows[0][0].ToString();
            //lblpointbalance.Text= (Convert.ToInt32(lblgift.Text) - Convert.ToInt32(lblgiftrec.Text)).ToString();
            dtrecord.Clear();
            ///////////////////
            //////////////////////Warranty count/////////////////////
            ///////////////
            //dtrecord = SQL_DB.ExecuteDataTable("select wr.* from [WarrentyDetails] wr inner join [M_consumer] Con on Con.[MobileNo]LIKE CONCAT('%', wr.[Mobile]) where Con.[M_Consumerid]=" + consumerid + "and wr.[Mobile]<>''");
            // DataRow[] warranty = dtrecord.Select("PurchaseDate>='" + DateTime.Today.AddYears(-1) + "'");
            query.totalWarranty = "0";
            query.underWarranty = "0";

            // DataSet dtTranscounter = ExecuteNonQueryAndDatatable.FillTransactions("[counterfeitcode]", Convert.ToInt32(consumerid));
            query.totalcounterfeit = "0";
            query.successcounterfeit = "0";

            //ServiceLogic.Paytm_Status();

            context.Response.Write(JsonConvert.SerializeObject(query, Formatting.Indented));
        }
        else if (context.Request.QueryString["method"] == "Transaction")
        {
            string result = string.Empty;
            string consumer_id = context.Request.QueryString["userid"];
            string limit = context.Request.QueryString["limit"];
            User_Details Log = new User_Details();
            Log.User_ID = consumer_id;
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            int consumerid = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);

            ///////////////////
            /////////////////////Code Scan/////////////////////
            ///////////////
            ///

            //ServiceLogic.Paytm_Status();
            DataTable table = Filldtransaction(limit, consumerid);


            string json = JsonConvert.SerializeObject(table, Formatting.Indented);
            // context.Response.Write(JSONString.ToString());
            context.Response.Write(json);

        }

        else if (context.Request.QueryString["method"] == "Transaction_1")
        {
            string result = string.Empty;
            string consumer_id = context.Request.QueryString["userid"];
            string limit = context.Request.QueryString["limit"];
            User_Details Log = new User_Details();
            Log.User_ID = consumer_id;
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            int consumerid = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);

            ///////////////////
            /////////////////////Code Scan/////////////////////
            ///////////////
            ///
            //ServiceLogic.Paytm_Status();

            DataTable table = Filldtransaction(limit, consumerid);


            var response = new { result = table };
            string json = JsonConvert.SerializeObject(response, Formatting.Indented);
            // context.Response.Write(JSONString.ToString());
            context.Response.Write(json);
        }


        else if (context.Request.QueryString["method"] == "subscribe")
        {
            string result = string.Empty;
            string email = context.Request.QueryString["email"];

            if (Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT count(id) FROM dbo.subscribe where email='" + email + "'")) == 0)
            {
                result = SQL_DB.ExecuteNonQuery1("INSERT INTO [dbo].[subscribe] ([email], [status], [createdby],[createddate]) values ('" + email + "',1,'" + email + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "')").ToString();
            }
            else
            {
                result = SQL_DB.ExecuteNonQuery1("update dbo.subscribe set updateddate='" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "' where email='" + email + "'").ToString();
            }
            context.Response.Write(result);

        }

        else if (context.Request.QueryString["method"] == "appchkgenuenity")
        {
            app_details app = new app_details();

            try
            {

                message_status messageobject = new message_status();
                string scaninfo = context.Request.QueryString["ScanInfo"];
                DataProvider.LogManager.ErrorExceptionLog(scaninfo);
                app = JsonConvert.DeserializeObject<app_details>(scaninfo);
                string mobile = "91" + app.mobile.Substring(app.mobile.Length - 10, 10);
                string codeone = app.code1;
                string codetwo = app.code2;
                string dealerid = string.Empty;
                string result = string.Empty;
                string paintermobile = string.Empty;
                string paintername = string.Empty;
                string designation = string.Empty;
                string Email = string.Empty;
                string BookName = string.Empty;
                string BookShop = string.Empty;
                string CoachingCenter = string.Empty;
                string Address = string.Empty;
                string SellerName = string.Empty;
                bool flag = false;
                string mode;
                if (context.Request.QueryString["mode"] == "")
                    mode = "App_mode";
                else
                    mode = context.Request.QueryString["mode"];


                HttpContext.Current.Session["mode"] = mode;
                /////////////////////////////
                ///




                string[] FieldList = app.fields.Split(new string[] { FieldSeparator }, StringSplitOptions.None);
                if (app.CompanyName == "SKYDECOR LAMINATES PRIVATE LIMITED" || app.CompanyName == "COATS BATH FITTINGS")
                {
                    for (int i = 0; i < FieldList.Length; i++)
                    {
                        string[] fieldname = FieldList[i].Split('=');

                        if (fieldname[0] == "customer name")
                        {
                            paintername = fieldname[1];
                        }
                        if (fieldname[0] == "Designation")
                        {
                            designation = fieldname[1];
                        }

                    }
                    if (!Regex.IsMatch(paintername, @"^[a-zA-Z]+$"))
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Customer NAme Should Contain Alphabet only";
                        messageobject.fields = "customer name";
                    }
                    if (app.CompanyName == "COATS BATH FITTINGS")
                    {
                        if (!Regex.IsMatch(designation, @"^[a-zA-Z]+$"))
                        {
                            messageobject.status = "Error";
                            messageobject.message = "Designation Should Contain Alphabet only";
                            messageobject.fields = "Designation";
                        }
                    }
                    if (!isDigits(mobile) && mobile != "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Mobile No. should be numeric only";
                        messageobject.fields = "Designation contact";
                    }
                    else if (Convert.ToInt32(mobile.Substring(0, 1)) < 6)
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Invalid Mobile No.";
                        messageobject.fields = "Painter contact";
                    }

                }

                if (app.CompanyName == "SHRI BALAJI PUBLICATIONS")
                {
                    for (int i = 0; i < FieldList.Length; i++)
                    {
                        string[] fieldname = FieldList[i].Split('=');
                        if (fieldname[0] == "Name")
                        {
                            paintername = fieldname[1];
                        }
                        if (fieldname[0] == "Email Address")
                        {
                            Email = fieldname[1];
                        }
                        if (fieldname[0] == "Book Name")
                        {
                            BookName = fieldname[1];
                        }
                        if (fieldname[0] == "Book Shop")
                        {
                            BookShop = fieldname[1];
                        }
                        if (fieldname[0] == "Coaching Center")
                        {
                            CoachingCenter = fieldname[1];
                        }
                    }
                    if (paintername == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Name can not be blank";
                        messageobject.fields = "Name";
                    }
                    if (!Regex.IsMatch(paintername, @"^[a-zA-Z ]+$"))
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Name Should Contain Alphabet only";
                        messageobject.fields = "Name";
                    }
                    if (Email == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Email Address can not be blank";
                        messageobject.fields = "Email Address";
                    }
                    if (!Regex.IsMatch(Email, @"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"))
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Email Address is not Valid";
                        messageobject.fields = "Email Address";
                    }
                    if (BookName == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Book Name can not be blank";
                        messageobject.fields = "Book Name";
                    }
                    if (BookShop == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Book Shop can not be blank";
                        messageobject.fields = "Book Shop";
                    }
                    if (CoachingCenter == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Coaching Center can not be blank";
                        messageobject.fields = "Coaching Center";
                    }
                    if (!isDigits(mobile) && mobile != "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Mobile No. should be numeric only";
                        messageobject.fields = "Mobile Number";
                    }
                    else if (Convert.ToInt32(mobile.Substring(0, 1)) < 6)
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Invalid Mobile No.";
                        messageobject.fields = "Mobile Number";
                    }
                }

                if (app.CompanyName.ToString() == "OCI Wires and Cables")
                {
                    for (int i = 0; i < FieldList.Length; i++)
                    {
                        string[] fieldname = FieldList[i].Split('=');
                        if (fieldname[0] == "Select Role")
                        {
                            string vl = fieldname[1];
                            string role = SQL_DB.ExecuteScalar("select Other_Role from M_Consumer where MobileNo='" + mobile + "'").ToString();
                            if (role == "")
                            {
                                SQL_DB.ExecuteDataTable("update M_Consumer set Other_Role='" + vl + "' where MobileNo='" + mobile + "'");
                            }
                        }
                    }
                }


                if (app.CompanyName.ToString() == "Inox Decor Pvt Ltd")
                {
                    for (int i = 0; i < FieldList.Length; i++)
                    {
                        string[] fieldname = FieldList[i].Split('=');   //Inox_User_Type
                        if (fieldname[0] == "Select Role")
                        {
                            string[] fieldnamen = fieldname[1].Split('|');
                            string vl = fieldnamen[0];
                            string v2 = fieldnamen[1];
                            string orole = SQL_DB.ExecuteScalar("select Other_Role from M_Consumer where MobileNo='" + mobile + "'").ToString();
                            string role = SQL_DB.ExecuteScalar("select Inox_User_Type from M_Consumer where MobileNo='" + mobile + "'").ToString();
                            if (role == "")
                            {
                                if (vl == "40")
                                {
                                    SQL_DB.ExecuteDataTable("update M_Consumer set Inox_User_Type='" + vl + "' where MobileNo='" + mobile + "'");
                                    SQL_DB.ExecuteDataTable("update M_Consumer set Other_Role='" + v2 + "' where MobileNo='" + mobile + "'");
                                }
                                else
                                {
                                    SQL_DB.ExecuteDataTable("update M_Consumer set Inox_User_Type='" + vl + "' where MobileNo='" + mobile + "'");
                                }

                            }
                        }
                    }
                }


                if (app.CompanyName == "A TO Z PHARMACEUTICALS")
                {
                    for (int i = 0; i < FieldList.Length; i++)
                    {
                        string[] fieldname = FieldList[i].Split('=');
                        if (fieldname[0] == "Name")
                        {
                            paintername = fieldname[1];
                        }
                        if (fieldname[0] == "Address")
                        {
                            Address = fieldname[1];
                        }
                    }
                    if (paintername == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Name can not be blank";
                        messageobject.fields = "Name";
                    }
                    if (!Regex.IsMatch(paintername, @"^[a-zA-Z ]+$"))
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Name Should Contain Alphabet only";
                        messageobject.fields = "Name";
                    }
                    if (Address == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Address can not be blank";
                        messageobject.fields = "Address";
                    }
                    if (!isDigits(mobile) && mobile != "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Mobile No. should be numeric only";
                        messageobject.fields = "Mobile Number";
                    }
                    else if (Convert.ToInt32(mobile.Substring(0, 1)) < 6)
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Invalid Mobile No.";
                        messageobject.fields = "Mobile Number";
                    }
                }


                if (app.CompanyName == "Veena Polymers")
                {
                    for (int i = 0; i < FieldList.Length; i++)
                    {
                        string[] fieldname = FieldList[i].Split('=');
                        if (fieldname[0] == "Name")
                        {
                            paintername = fieldname[1];
                        }
                        if (fieldname[0] == "Address")
                        {
                            Address = fieldname[1];
                        }
                        if (fieldname[0] == "SellerName")
                        {
                            SellerName = fieldname[1];
                        }
                    }
                    if (paintername == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Name can not be blank";
                        messageobject.fields = "Name";
                    }
                    if (!Regex.IsMatch(paintername, @"^[a-zA-Z ]+$"))
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Name Should Contain Alphabet only";
                        messageobject.fields = "Name";
                    }
                    if (!Regex.IsMatch(SellerName, @"^[a-zA-Z ]+$"))
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Seller Name Should Contain Alphabet only";
                        messageobject.fields = "SellerName";
                    }
                    if (Address == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Address can not be blank";
                        messageobject.fields = "Address";
                    }
                    if (!isDigits(mobile) && mobile != "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Mobile No. should be numeric only";
                        messageobject.fields = "Mobile Number";
                    }
                    else if (Convert.ToInt32(mobile.Substring(0, 1)) < 6)
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Invalid Mobile No.";
                        messageobject.fields = "Mobile Number";
                    }
                }
                if (app.CompanyName == "BCC ASSOCIATES" || app.CompanyName == "Wudchem Industries Private Limited")
                {
                    for (int i = 0; i < FieldList.Length; i++)
                    {
                        string[] fieldname = FieldList[i].Split('=');
                        if (fieldname[0] == "Name")
                        {
                            paintername = fieldname[1];
                        }
                        if (fieldname[0] == "Address" || fieldname[0] == "City")
                        {
                            Address = fieldname[1];
                        }

                    }
                    if (paintername == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Name can not be blank";
                        messageobject.fields = "Name";
                    }
                    if (!Regex.IsMatch(paintername, @"^[a-zA-Z ]+$"))
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Name Should Contain Alphabet only";
                        messageobject.fields = "Name";
                    }

                    if (Address == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "City can not be blank";
                        messageobject.fields = "City";
                    }
                    if (!isDigits(mobile) && mobile != "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Mobile No. should be numeric only";
                        messageobject.fields = "Mobile Number";
                    }
                    else if (Convert.ToInt32(mobile.Substring(0, 1)) < 6)
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Invalid Mobile No.";
                        messageobject.fields = "Mobile Number";
                    }
                }

                if (app.CompanyName == "PARAG MILK FOODS")
                {
                    for (int i = 0; i < FieldList.Length; i++)
                    {
                        string[] fieldname = FieldList[i].Split('=');
                        if (fieldname[0] == "Name")
                        {
                            paintername = fieldname[1];
                        }
                        if (fieldname[0] == "Address")
                        {
                            Address = fieldname[1];
                        }
                        if (fieldname[0] == "Email Address")
                        {
                            Email = fieldname[1];
                        }
                    }
                    if (paintername == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Name can not be blank";
                        messageobject.fields = "Name";
                    }
                    if (!Regex.IsMatch(paintername, @"^[a-zA-Z ]+$"))
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Name Should Contain Alphabet only";
                        messageobject.fields = "Name";
                    }

                    if (Address == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Address can not be blank";
                        messageobject.fields = "Address";
                    }
                    if (!isDigits(mobile) && mobile != "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Mobile No. should be numeric only";
                        messageobject.fields = "Mobile Number";
                    }
                    else if (Convert.ToInt32(mobile.Substring(0, 1)) < 6)
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Invalid Mobile No.";
                        messageobject.fields = "Mobile Number";
                    }

                    if (Email == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Email Address can not be blank";
                        messageobject.fields = "Email Address";
                    }
                    if (!Regex.IsMatch(Email, @"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"))
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Email Address is not Valid";
                        messageobject.fields = "Email Address";
                    }



                }

                if (app.CompanyName == "Ankerite Health Care Pvt. Ltd" || app.CompanyName == "Chase2Fit")
                {
                    for (int i = 0; i < FieldList.Length; i++)
                    {
                        string[] fieldname = FieldList[i].Split('=');
                        if (fieldname[0] == "Name")
                        {
                            paintername = fieldname[1];
                        }
                        if (fieldname[0] == "City")
                        {
                            Address = fieldname[1];
                        }

                    }
                    if (paintername == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Name can not be blank";
                        messageobject.fields = "Name";
                    }
                    if (!Regex.IsMatch(paintername, @"^[a-zA-Z ]+$"))
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Name Should Contain Alphabet only";
                        messageobject.fields = "Name";
                    }

                    if (Address == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "City can not be blank";
                        messageobject.fields = "City";
                    }
                    if (!isDigits(mobile) && mobile != "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Mobile No. should be numeric only";
                        messageobject.fields = "Mobile Number";
                    }
                    else if (Convert.ToInt32(mobile.Substring(0, 1)) < 6)
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Invalid Mobile No.";
                        messageobject.fields = "Mobile Number";
                    }



                }




                if (app.CompanyName == "R.S Industries" || app.CompanyName == "Jupiter Aqua Lines Ltd")
                {
                    for (int i = 0; i < FieldList.Length; i++)
                    {
                        string[] fieldname = FieldList[i].Split('=');
                        if (fieldname[0] == "Name")
                        {
                            paintername = fieldname[1];
                        }
                        if (fieldname[0] == "Address" || fieldname[0] == "City")
                        {
                            Address = fieldname[1];
                        }
                        if (fieldname[0] == "Designation")
                        {
                            designation = fieldname[1];
                        }
                    }
                    if (paintername == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Name can not be blank";
                        messageobject.fields = "Name";
                    }
                    if (!Regex.IsMatch(paintername, @"^[a-zA-Z ]+$"))
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Name Should Contain Alphabet only";
                        messageobject.fields = "Name";
                    }
                    if (!Regex.IsMatch(designation, @"^[a-zA-Z]+$"))
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Designation Should Contain Alphabet only";
                        messageobject.fields = "Designation";
                    }
                    if (Address == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Address can not be blank";
                        messageobject.fields = "Address";
                    }
                    if (!isDigits(mobile) && mobile != "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Mobile No. should be numeric only";
                        messageobject.fields = "Mobile Number";
                    }
                    else if (Convert.ToInt32(mobile.Substring(0, 1)) < 6)
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Invalid Mobile No.";
                        messageobject.fields = "Mobile Number";
                    }
                }


                if (app.CompanyName == "JOHNSON PAINTS CO.")
                {
                    string name = string.Empty;
                    DataTable dtconsumer1 = SQL_DB.ExecuteDataTable("select top 1  isnull([Dealer Name],0) name from M_Consumer left join dealership_details on dealership_details.[Dealer Code]=M_Consumer.distributorID where mobileno='91" + mobile.Substring(mobile.Length - 10, 10) + "'");

                    name = dtconsumer1.Rows[0]["name"].ToString();

                    if (name != "0")
                    {
                        paintername = name;
                    }


                    // paintermobile = "6666666666";
                    paintermobile = mobile.Substring(mobile.Length - 10, 10);
                    for (int i = 0; i < FieldList.Length; i++)
                    {
                        string[] fieldname = FieldList[i].Split('=');
                        if (fieldname[0] == "Dealer Id")
                        {
                            flag = true;
                            dealerid = fieldname[1];
                        }
                        if (fieldname[0] == "Painter contact")
                        {
                            paintermobile = fieldname[1];
                        }
                        if (fieldname[0] == "Dealer Name")
                        {
                            flag = true;
                            paintername = fieldname[1];
                        }
                        if (fieldname[0] == "customer name")
                        {
                            paintername = fieldname[1];
                        }

                    }
                    //if (!Regex.IsMatch(paintername, @"^[a-zA-Z ]+$"))
                    //{
                    //    messageobject.status = "Error";
                    //    messageobject.message = "Dealer Name Should Contain Alphabet only";
                    //    messageobject.fields = "Dealer Name";
                    //}
                    if (dealerid == "" && flag)
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Dealer Id can not be blank";
                        messageobject.fields = "Dealer Id";
                    }
                    else if (paintername == "" && flag)
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Dealer Name can not be blank";
                        messageobject.fields = "Dealer Name";
                    }
                    else if (paintermobile == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Painter contact can not be blank";
                        messageobject.fields = "Painter contact";
                    }
                    else if (paintername == "" && dealerid == "")
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Dealer Id and Dealer Name can not be blank";
                        messageobject.fields = "Dealer Name,Dealer Id";
                    }
                    if (!isDigits(paintermobile))
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Mobile No. should be numeric only";
                        messageobject.fields = "Painter contact";
                    }
                    else if (Convert.ToInt32(paintermobile.Substring(0, 1)) < 6)
                    {
                        messageobject.status = "Error";
                        messageobject.message = "Invalid Painter Mobile No.";
                        messageobject.fields = "Painter contact";
                    }

                    if (messageobject.message == "" || messageobject.message == null)
                    {
                        DataTable dtconsumer = SQL_DB.ExecuteDataTable("select isnull(distributorID,0) distributorID from m_consumer where mobileno='91" + mobile.Substring(mobile.Length - 10, 10) + "'");
                        if (dealerid != string.Empty)
                        {
                            DataTable dtdealer = SQL_DB.ExecuteDataTable("select DealerCode,D_Status from m_dealermaster where DealerCode='" + dealerid + "'");
                            if (dtdealer.Rows.Count == 0)
                            {
                                messageobject.status = "Error";
                                messageobject.message = "Dealer Id does not exist";
                                messageobject.fields = "Dealer ID";
                            }
                            else if (dtdealer.Rows[0]["D_Status"].ToString() == "1")
                            {
                                messageobject.status = "Error";
                                messageobject.message = "This dealerId already Taken";
                                messageobject.fields = "Dealer ID";
                            }
                            else if (dtconsumer.Rows[0]["distributorID"].ToString() != dealerid && dtconsumer.Rows[0]["distributorID"].ToString() != "0")
                            {
                                messageobject.status = "Error";
                                messageobject.message = "Dealer Id not Matched with mobile no.";
                                messageobject.fields = "Dealer ID";
                            }
                            else if (dtconsumer.Rows.Count > 0 && dtconsumer.Rows[0]["distributorID"].ToString() == "0" && dtdealer.Rows[0]["D_Status"].ToString() != "1")
                            {

                                SQL_DB.ExecuteNonQuery("update m_consumer set distributorID='" + dealerid + "' where mobileno='" + mobile + "'");
                                SQL_DB.ExecuteNonQuery("update m_dealermaster set D_Status='1' where DealerCode='" + dealerid + "'");

                            }
                            else if (dtconsumer.Rows.Count == 0 && dtdealer.Rows[0]["D_Status"].ToString() != "1")

                            {

                                int psw = RandomNumber(1000, 9999);
                                User_Details Log = new User_Details();
                                Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));

                                // Log.Email = "";
                                // email.Trim().Replace("'", "''"); //this is comment is done by shweta

                                Log.MobileNo = mobile;

                                Log.PinCode = null;
                                Log.Password = psw.ToString();
                                Log.IsActive = 0;
                                Log.IsDelete = 0;
                                //Log.ConsumerName = name;
                                Log.DML = "I";
                                if (dealerid != "")
                                {
                                    Log.MMDistributorID = dealerid;
                                }
                                //Log.distributorID = dealerid;
                                User_Details.InsertUpdateUserDetails(Log);
                                SQL_DB.ExecuteDataTable("update m_dealermaster set D_Status='1' where DealerCode='" + dealerid + "'");
                                string msgString = "Your VCQRU_ID: " + mobile + " & PWD: " + Log.Password + " Visit https://www.vcqru.com/login.aspx & complete your profile";


                                ServiceLogic.SendSms(msgString, mobile);



                            }
                            else
                                dealerid = dtconsumer.Rows[0][0].ToString();

                            result = JsonConvert.SerializeObject(messageobject, Formatting.Indented);
                        }
                        else
                        {
                            dealerid = dtconsumer.Rows[0][0].ToString();
                        }
                    }

                }
                else
                {
                    paintermobile = mobile;
                }


                if (messageobject.message == "" || messageobject.message == null)
                {
                    location loc = new location();
                    loc.mobileno = mobile.Substring(mobile.Length - 10);
                    loc.code1 = codeone;
                    loc.code2 = codetwo;

                    HttpContext.Current.Session["lat"] = null;
                    HttpContext.Current.Session["long"] = null;


                    HttpContext.Current.Session["lat"] = app.latitude;
                    HttpContext.Current.Session["long"] = app.longitude;

                    string email = string.Empty;
                    string purchasedate = string.Empty;
                    string billno = string.Empty;
                    string image = string.Empty;
                    DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(loc.code1 + "-" + loc.code2);
                    DataRow[] servicedetais = dsServicesAssign.Tables[0].Select("Service_id = 'SRV1023'");
                    if (mobile != "")
                        //if (app.ServiceId == "SRV1023")
                        if (servicedetais.Length > 0)
                        {
                            if (app.CompanyName.ToUpper() == "AUTO MAX INDIA")
                            {
                                Object9420 Reg = new Object9420();
                                Reg.Received_Code1 = (codeone.Trim().Replace("'", "''"));
                                Reg.Received_Code2 = (codetwo.Trim().Replace("'", "''"));
                                DataSet ds = ServiceLogic.FindCheckedCode_2(Reg);
                                if (ds.Tables[0].Rows.Count > 0)
                                {
                                    if (ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
                                    {
                                        purchasedate = DateTime.Today.ToString("MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture); // HttpContext.Current.Request.Form["purchasedate"];
                                        string code = app.code1 + "-" + app.code2;

                                        string period = string.Empty;
                                        DateTime expDate = DateTime.Today;
                                        DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                                        period = servicedetais[0]["WarrantyPeriod"].ToString();
                                        expDate = purDate.AddMonths(Convert.ToInt32(period));

                                        SaveWarrentyDetailsforauto(purchasedate, mobile, code, expDate, period);
                                    }
                                }
                            }
                            else
                            {
                                // string[] FieldList = app.fields.Split(new string[] { FieldSeparator }, StringSplitOptions.None);
                                string updatefields = string.Empty;
                                for (int i = 0; i < FieldList.Length; i++)
                                {
                                    string[] fieldname = FieldList[i].Split('=');
                                    if (fieldname[0] == "Email")
                                    {
                                        email = fieldname[1];
                                    }
                                    if (fieldname[0] == "Purchase Date")
                                    {
                                        purchasedate = fieldname[1];
                                    }
                                    if (fieldname[0] == "Bill No")
                                    {
                                        billno = fieldname[1];
                                    }
                                    if (fieldname[0] == "Bill Image")
                                    {

                                        image = fieldname[1];
                                    }


                                }
                                warranrty(email, mobile, purchasedate, codeone + "-" + codetwo, billno, image);

                            }
                            result = appchkgenuenity(codeone, codetwo, mobile, app.fields, mode);
                            //messageobject.status = "Success";
                            //messageobject.message = result;
                            // result = JsonConvert.SerializeObject(result, Formatting.Indented);
                        }
                        else
                        {
                            if (app.CompanyName == "JOHNSON PAINTS CO." || app.CompanyName == "A TO Z PHARMACEUTICALS" || app.CompanyName == "SHRI BALAJI PUBLICATIONS" || app.CompanyName == "SKYDECOR LAMINATES PRIVATE LIMITED" || app.CompanyName == "COATS BATH FITTINGS" || app.CompanyName == "Veena Polymers" || app.CompanyName == "Wudchem Industries Private Limited" || app.CompanyName == "PARAG MILK FOODS" || app.CompanyName == "Ankerite Health Care Pvt. Ltd" || app.CompanyName == "Chase2Fit" || app.CompanyName == "R.S Industries" || app.CompanyName == "Jupiter Aqua Lines Ltd")
                                result = appchkgenuenity(codeone, codetwo, paintermobile, app.fields, mode, dealerid, paintername, mobile, BookName, BookShop, CoachingCenter, Email, app.CompanyName, Address, SellerName);

                            else if (app.CompanyName == "OCI Wires and Cables" || app.CompanyName == "Inox Decor Pvt Ltd")
                                result = appchkgenuenity(codeone, codetwo, mobile, app.fields, mode, "", "", "", "", "", "", "", app.CompanyName);

                            else
                                result = appchkgenuenity(codeone, codetwo, mobile, app.fields, mode);
                        }
                }
                else
                {

                    if (app.CompanyName == "JOHNSON PAINTS CO.")
                    {
                        Object9420 Reg = new Object9420();
                        Reg.Received_Code1 = app.code1;
                        Reg.Received_Code2 = app.code2;
                        Reg.Mobile_No = "91" + paintermobile.Substring(paintermobile.Length - 10, 10);
                        //Reg.Enq_Date = DateTime.Now.ToLongTimeString();
                        Reg.Is_Success = 0;


                        Reg.Dial_Mode = mode;

                        Reg.Mode_Detail = GetIP();


                        Reg.Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff"));
                        Reg.callerdate = DateTime.Now;
                        Reg.callertime = DateTime.Now.ToString("hh:mm:ss");
                        //Location location = locationdetails();

                        //Reg.callercircle = location.region_name;
                        //Reg.City = location.city_name;
                        if (dealerid != "")
                        {
                            Reg.dealerid = dealerid;
                        }
                        Reg.dealer_mobile = "91" + mobile.Substring(mobile.Length - 10, 10);
                        Business9420.function9420.InsertCodeChecked(Reg);
                    }




                    result = JsonConvert.SerializeObject(messageobject, Formatting.Indented);
                }
                context.Response.Write(result);
            }
            catch (Exception ex)
            {
                DataProvider.LogManager.ErrorExceptionLog(DateTime.Now.ToLongDateString() + ": Exception at Masterhandler on Appchkgeneunity condition" + Environment.NewLine + " Error: " + ex.Message + Environment.NewLine + " Parameter: " + app);
                throw ex;
            }
            // string result = chkgenuenity(codeone, codetwo, mobile);
            // context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "RunSurvey")
        {
            //string company = context.Request.QueryString["company"].ToString();
            //string contactpersion = context.Request.QueryString["contactpersion"].ToString();
            //string email = context.Request.QueryString["email"].ToString();
            //string mobile = context.Request.QueryString["mobile"].ToString();
            //string result = register(company, contactpersion, email, mobile);
            //context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "DispatchGift")
        {
            //string company = context.Request.QueryString["company"].ToString();
            //string contactpersion = context.Request.QueryString["contactpersion"].ToString();
            //string email = context.Request.QueryString["email"].ToString();
            //string mobile = context.Request.QueryString["mobile"].ToString();
            //string result = register(company, contactpersion, email, mobile);
            //context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "register")
        {
            string company = context.Request.QueryString["company"].ToString();
            string contactpersion = context.Request.QueryString["contactpersion"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string mobile = context.Request.QueryString["mobile"].ToString();
            string result = register(company, contactpersion, email, mobile);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "EmployeeRegister")
        {
            string Etype = context.Request.QueryString["Etype"].ToString();
            string Name = context.Request.QueryString["Name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string mobile = context.Request.QueryString["mobile"].ToString();
            string City = context.Request.QueryString["City"].ToString();
            string Pin = context.Request.QueryString["Pin"].ToString();
            string pwd = context.Request.QueryString["pwd"].ToString();
            string result = EmployeeRegister(Etype, Name, email, mobile, City, Pin, pwd);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "DealerRegister")
        {
            string Name = context.Request.QueryString["Name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string mobile = context.Request.QueryString["mobile"].ToString();
            string City = context.Request.QueryString["City"].ToString();
            string Pin = context.Request.QueryString["Pin"].ToString();
            string pwd = context.Request.QueryString["pwd"].ToString();
            string loc = context.Request.QueryString["loc"].ToString();
            string type = context.Request.QueryString["type"].ToString();
            string result = DealerRegister(Name, email, mobile, City, Pin, pwd, loc, type);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "ConsumerRegister")
        {
            string Name = context.Request.QueryString["Name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string mobile = context.Request.QueryString["mobile"].ToString();
            string City = context.Request.QueryString["City"].ToString();
            string Pin = context.Request.QueryString["Pin"].ToString();
            string pwd = context.Request.QueryString["pwd"].ToString();
            string result = ConsumerRegister(Name, email, mobile, City, Pin, pwd);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "demoreegister")
        {
            string company = context.Request.QueryString["company"].ToString();
            string contactpersion = context.Request.QueryString["contactpersion"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string mobile = context.Request.QueryString["mobile"].ToString();
            string result = demoreegister(company, contactpersion, email, mobile);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "CheckEmailid")
        {
            string email = context.Request.QueryString["email"].ToString();
            string result = CheckEmail(email);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "DemoPackeageCode")
        {
            string code = context.Request.QueryString["code"].ToString();
            string result = DemoPackeageCode(code);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "loginEmp")
        {
            string userid = context.Request.QueryString["userid"].ToString();
            string pass = context.Request.QueryString["pass"].ToString();
            string remember = context.Request.QueryString["rememberme"].ToString();
            string result = loginEmp(userid, pass, Convert.ToInt32(remember));
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "login")
        {
            string userid = context.Request.QueryString["userid"].ToString();
            string pass = context.Request.QueryString["pass"].ToString();

            string remember = string.Empty;
            if (context.Request.QueryString["rememberme"] != null)
                remember = context.Request.QueryString["rememberme"].ToString();

            string result = login(userid, pass, Convert.ToInt32(remember));
            context.Response.Write(result);
        }

        #region //** Vendor Terms and Conditoins
        else if (context.Request.QueryString["method"] == "VendorTermsCondition")

        {
            string Comp_Id = context.Request.QueryString["Comp_Id"].ToString();


            #region //**
            string IsAccept = "0";
            DataSet dsPPolicy = SQL_DB.ExecuteDataSet("select Count(1)  IsAccept,ReqDate  from tblPPolicyHistory where Comp_Id='" + Comp_Id + "' and IsAccept=1 group by ReqDate");
            if (dsPPolicy.Tables[0].Rows.Count > 0)
            {
                IsAccept = dsPPolicy.Tables[0].Rows[0]["IsAccept"].ToString();
                if (IsAccept == "0")
                {

                }
                else
                {
                    DateTime ReqDate = Convert.ToDateTime(dsPPolicy.Tables[0].Rows[0]["ReqDate"].ToString());
                    DateTime ExpDate = ReqDate.AddYears(1);
                    DateTime CurrDate = System.DateTime.Now;
                    if (ExpDate < CurrDate)
                    {
                        IsAccept = "0";
                    }

                }



            }

            if (IsAccept == "0")
            {
                DataSet dsCompanydetails = SQL_DB.ExecuteDataSet("select c.Comp_ID,c.Comp_Name,c.Comp_Email,c.Address,c.Contact_Person,c.Mobile_No,cd.PAN_TAN,c.ResiAddress,c.DirectorName,c.DirectorFatherName,c.AadharNumber from Comp_Reg c inner join Comp_Document cd on c.Comp_ID=cd.Comp_ID where c.Comp_ID='" + Comp_Id + "'");
                if (dsCompanydetails.Tables[0].Rows.Count > 0)
                {
                    string Comp_ID = dsCompanydetails.Tables[0].Rows[0]["Comp_ID"].ToString();
                    string Comp_Name = dsCompanydetails.Tables[0].Rows[0]["Comp_Name"].ToString();
                    string Comp_Email = dsCompanydetails.Tables[0].Rows[0]["Comp_Email"].ToString();
                    string Address = dsCompanydetails.Tables[0].Rows[0]["Address"].ToString();
                    string Contact_Person = dsCompanydetails.Tables[0].Rows[0]["Contact_Person"].ToString();
                    string Mobile_No = dsCompanydetails.Tables[0].Rows[0]["Mobile_No"].ToString();
                    string PAN_TAN = dsCompanydetails.Tables[0].Rows[0]["PAN_TAN"].ToString();
                    string ResiAddress = dsCompanydetails.Tables[0].Rows[0]["ResiAddress"].ToString();
                    string DirectorName = dsCompanydetails.Tables[0].Rows[0]["DirectorName"].ToString();
                    string DirectorFatherName = dsCompanydetails.Tables[0].Rows[0]["DirectorFatherName"].ToString();
                    string AadharNumber = dsCompanydetails.Tables[0].Rows[0]["AadharNumber"].ToString();

                    DataSet dsServicedetails = SQL_DB.ExecuteDataSet("select ServiceName from M_Service where Service_ID in (select distinct Service_ID from M_ServiceSubscription where Comp_ID='" + Comp_Id + "')");

                    string ServiceName = "";
                    if (dsServicedetails.Tables[0].Rows.Count > 0)
                    {
                        DataTable dt = new DataTable();
                        dt = dsServicedetails.Tables[0];

                        foreach (DataRow row in dt.Rows)
                        {
                            string name = row["ServiceName"].ToString();
                            ServiceName = name + " ,";
                        }

                        ServiceName = ServiceName.Remove(ServiceName.Length - 1);
                    }


                    IsAccept = Comp_ID + "~" + Comp_Name + "~" + Comp_Email + "~" + Address + "~" + Contact_Person + "~" + Mobile_No + "~" + PAN_TAN + "~" + ResiAddress + "~" + DirectorName + "~" + DirectorFatherName + "~" + AadharNumber + "~" + ServiceName;

                }
            }

            #endregion


            context.Response.Write(IsAccept);
        }
        else if (context.Request.QueryString["method"] == "InsertVendorTermsCondition")
        {
            string Comp_Id = context.Request.QueryString["Comp_Id"].ToString();
            string Content = context.Request.QueryString["Content"].ToString();
            string IPAddress = context.Request.QueryString["IPAddress"].ToString();
            string Browser = context.Request.QueryString["Browser"].ToString();
            string DeviceDetails = context.Request.QueryString["DeviceDetails"].ToString();

            // string MacID = context.Request.QueryString["MacID"].ToString();


            string MacID = "NA";
            foreach (NetworkInterface n in NetworkInterface.GetAllNetworkInterfaces())
            {
                if (n.OperationalStatus == OperationalStatus.Up)
                {
                    MacID += n.GetPhysicalAddress().ToString();
                    break;
                }
            }


            string IsAccept = "0";
            string result = SQL_DB.ExecuteNonQuery1("insert into tblPPolicyHistory(Comp_Id,PolicyId,IsAccept,ReqDate,IPAddress,Browser,DeviceDetails,MacID) values ('" + Comp_Id + "',1,1,'" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "','" + IPAddress + "','" + Browser + "','" + DeviceDetails + "','" + MacID + "')").ToString();

            try
            {



                DataSet dcs = SQL_DB.ExecuteDataSet("select Comp_ID,Comp_Name,Comp_Cat_Id,Comp_Email,WebSite,Address,Contact_Person,Mobile_No from Comp_Reg where Comp_ID='" + Comp_Id + "'");
                if (dcs.Tables[0].Rows.Count > 0)
                {
                    string Contact_Person = dcs.Tables[0].Rows[0]["Contact_Person"].ToString();
                    string Mobile_No = dcs.Tables[0].Rows[0]["Mobile_No"].ToString();
                    string Comp_Email = dcs.Tables[0].Rows[0]["Comp_Email"].ToString();
                    //  Comp_Email="deep@vcqru.com";



                    DateTime CurrentDate = System.DateTime.Today;
                    DateTime ExDate = CurrentDate.AddYears(1);
                    string ExpDate = ExDate.ToString("dd-MM-yyyy");
                    string MailBody = "";
                    MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                                               " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
                                               " <hr style='border:1px solid #2587D5;'/>" +
                                               " <div class='w_frame'>" +
                                               " <p>" +
                                               " <div class='w_detail'>" +
                                               " <span>Dear <em><strong> " + Contact_Person + ",</strong></em></span><br />" +
                                               " <br />" +
                                               " <span>I trust this email finds you in good health.</span><br />" +
                                               " <br />" +
                                               " <span>We are pleased to inform you that the attached document contains the digitally signed Terms and Conditions Agreement about our recent discussions and engagements.</span><br />" +
                                               " <br />" +
                                               " <span>VCQRU Private Limited is committed to ensuring clarity and transparency in our business transactions. The attached document bears the digital signatures of our authorized representatives, validating its authenticity and legal standing.</span><br />" +
                                               " <br />" +
                                               " <span>Please take the time to review the terms outlined in the document. If you have any questions or require further clarification on any aspect, feel free to reach out to us.</span><br />" +
                                               " <br />" +
                                                " <span>Your prompt attention to this matter is highly appreciated. We look forward to your confirmation, signifying your acceptance of the agreed-upon terms.</span><br />" +
                                               " <br />" +
                                               "<br /><br /> Thank you for your continued partnership. <br />" +
                                               " <p>" +
                                               " <div class='w_detail'>" +
                                               " Best regards,<br />" +
                                               " VCQRU Private Limited <br />" +

                                               " </div>" +
                                               " </p>" +
                                               " </div>" +
                                               " </p>" +
                                               " </div> " +
                                               " </div> ";

                    DataSet dsMl = function9420.FetchMailDetail("support");
                    if (dsMl.Tables[0].Rows.Count > 0)
                    {


                        DataProvider.Utility.sendMailAttach(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
                           Comp_Email, MailBody, "Annual Contract of VCQRU of use and policies", @"C:\inetpub\wwwroot\httpdocs\assets\VendorAgreementCopy\" + Comp_Id + ".pdf");

                    }
                }



            }
            catch (Exception ex)
            {

            }



            context.Response.Write(IsAccept);
        }

        else if (context.Request.QueryString["method"] == "InsertUpdateVendorTermsCondition")
        {
            string Comp_Id = context.Request.QueryString["Comp_Id"].ToString();
            string Content = context.Request.QueryString["Content"].ToString();
            string IPAddress = context.Request.QueryString["IPAddress"].ToString();
            string Browser = context.Request.QueryString["Browser"].ToString();
            string DeviceDetails = context.Request.QueryString["DeviceDetails"].ToString();
            // string MacID = context.Request.QueryString["MacID"].ToString();


            string MacID = "NA";
            foreach (NetworkInterface n in NetworkInterface.GetAllNetworkInterfaces())
            {
                if (n.OperationalStatus == OperationalStatus.Up)
                {
                    MacID += n.GetPhysicalAddress().ToString();
                    break;
                }
            }
            string Accept = "0";
            DataSet dsPPolicy = SQL_DB.ExecuteDataSet("select SkipCount  from tblPPolicyHistory where Comp_Id='" + Comp_Id + "' and IsAccept=0");
            if (dsPPolicy.Tables[0].Rows.Count > 0)
            {
                int SkipCount = Convert.ToInt32(dsPPolicy.Tables[0].Rows[0]["SkipCount"].ToString());
                if (SkipCount > 0)
                {
                    SkipCount = SkipCount + 1;
                    Accept = SQL_DB.ExecuteNonQuery1("update tblPPolicyHistory set SkipCount='" + SkipCount + "',IPAddress='" + IPAddress + "',Browser='" + Browser + "',DeviceDetails='" + DeviceDetails + "',MacID='" + MacID + "',ReqDate='" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "' where Comp_Id='" + Comp_Id + "'").ToString();
                }
                else
                    Accept = SQL_DB.ExecuteNonQuery1("insert into tblPPolicyHistory(Comp_Id,PolicyId,IsAccept,ReqDate,IPAddress,Browser,DeviceDetails,MacID,SkipCount) values ('" + Comp_Id + "',0,0,'" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "','" + IPAddress + "','" + Browser + "','" + DeviceDetails + "','" + MacID + "',1)").ToString();

            }
            else
                Accept = SQL_DB.ExecuteNonQuery1("insert into tblPPolicyHistory(Comp_Id,PolicyId,IsAccept,ReqDate,IPAddress,Browser,DeviceDetails,MacID,SkipCount) values ('" + Comp_Id + "',0,0,'" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "','" + IPAddress + "','" + Browser + "','" + DeviceDetails + "','" + MacID + "',1)").ToString();





            context.Response.Write(Accept);
        }
        #endregion
        else if (context.Request.QueryString["method"] == "Adminlogin")
        {
            string userid = context.Request.QueryString["userid"].ToString();
            string pass = context.Request.QueryString["pass"].ToString();
            string result = Adminlogin(userid, pass);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "android_userdetails")
        {
            string consumer_id = context.Request.QueryString["userid"];
            User_Details Log = new User_Details();
            Log.User_Type = "Consumer";
            Log.User_ID = consumer_id;
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable table = User_Details.app_GetUserLoginDetails(Log);

            string json = JsonConvert.SerializeObject(table, Formatting.Indented);

            context.Response.Write(json);


        }
        else if (context.Request.QueryString["method"] == "chkmahindra")
        {
            try
            {
                string consumer_id = context.Request.QueryString["userid"];
                string mahindracounts = ExecuteNonQueryAndDatatable.checkmahindra("[appcheckmahindra]", consumer_id);
                //string json = JsonConvert.SerializeObject(mahindracounts, Formatting.Indented);
                message_status msg = new message_status();
                if (mahindracounts != "0")
                    msg.status = "Success";
                else
                {
                    msg.status = "Unsuccess";
                }

                context.Response.Write(JsonConvert.SerializeObject(msg));
            }
            catch (Exception ex)
            {
                DataProvider.LogManager.ErrorExceptionLog(DateTime.Now.ToLongDateString() + ": Exception at Masterhandler on chkmahindra condition" + Environment.NewLine + " Error: " + ex.Message + Environment.NewLine + " Parameter: userid=" + context.Request.QueryString["userid"]);
                throw ex;
            }
        }
        else if (context.Request.QueryString["method"] == "app_userdetails")
        {
            string consumer_id = context.Request.QueryString["userid"];
            User_Details Log = new User_Details();
            Log.User_Type = "Consumer";
            Log.User_ID = consumer_id;
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            string user_id = dt.Rows[0]["User_ID"].ToString();
            string consumerid = dt.Rows[0]["M_consumerid"].ToString();
            string result = string.Empty; ;
            DataSet ds = new DataSet();
            //string qSQL = "SELECT *, isnull(ME.mobilenumber,'NA') MM FROM M_Consumer MC Inner Join MMEMPLOYEE ME ON MC.M_Consumerid = ME.M_Consumerid WHERE MC.[User_ID] = '" + obj.User_ID + "'";
            DataTable ddt = SQL_DB.ExecuteDataSet("SELECT mc.*,MD.[DE_Designation] as Designantion  FROM M_Consumer mc left join M_DealerMaster MD on mc.employeeID=MD.[DealerTechnicianId] and mc.[distributorID]=MD.[DealerCode] WHERE MC.User_ID = '" + user_id + "'").Tables[0];
            //DataTable ddt = SQL_DB.ExecuteDataSet(qSQL).Tables[0];
            if (ddt.Rows.Count > 0)
            {
                try
                {

                    result = ddt.Rows[0]["ConsumerName"].ToString();

                    DataTable img = SQL_DB.ExecuteDataTable("select [Profile_img] from [Profile_images] where [M_consumerid]=" + consumerid);
                    if (img.Rows.Count > 0)
                    {
                        result = result + "=" + img.Rows[0][0].ToString();
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
                string qSQL1 = "SELECT * FROM M_Consumer WHERE [User_ID] = '" + user_id + "'";
                //DataTable ddt = SQL_DB.ExecuteDataSet("SELECT * FROM M_Consumer WHERE User_ID = '" + obj.User_ID + "'").Tables[0];
                DataTable ddt1 = SQL_DB.ExecuteDataSet(qSQL1).Tables[0];
                if (ddt1.Rows.Count > 0)
                {

                    result = ddt1.Rows[0]["ConsumerName"].ToString();
                    DataTable img = SQL_DB.ExecuteDataTable("select [Profile_img] from [Profile_images] where [M_consumerid]=" + consumerid);
                    if (img.Rows.Count > 0)
                    {
                        result = result + "=" + img.Rows[0][0].ToString();
                    }
                }

            }
            context.Response.Write(result);

        }
        else if (context.Request.QueryString["method"] == "consumerlogin")
        {
            string userid = context.Request.QueryString["userid"].ToString();
            string pass = context.Request.QueryString["pass"].ToString();
            //string remember = context.Request.QueryString["rememberme"].ToString();
            string result = consumerlogin(userid, pass, 1);//Convert.ToInt32(remember)
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "Dealerlogin")
        {
            string userid = context.Request.QueryString["userid"].ToString();
            string pass = context.Request.QueryString["pass"].ToString();
            string remember = context.Request.QueryString["remember"].ToString();
            string result = Dealerlogin(userid, pass, Convert.ToInt32(remember));
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "saveinterusted")
        {
            string InterCompNm = context.Request.QueryString["InterCompNm"].ToString();
            string InterEmail = context.Request.QueryString["InterEmail"].ToString();
            string InterUserNm = context.Request.QueryString["InterUserNm"].ToString();
            string InterMobileNo = context.Request.QueryString["InterMobileNo"].ToString();
            string result = saveinterusted(InterCompNm, InterEmail, InterUserNm, InterMobileNo);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "logout")
        {
            int result = logout();
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "forgotpassword")
        {
            string email = context.Request.QueryString["email"].ToString();
            string result = forgotpassword(email);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "forgotpasswordEmp")
        {
            string email = context.Request.QueryString["email"].ToString();
            string result = forgotpasswordEmp(email);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "Consumerforgotpassword")
        {
            string email = context.Request.QueryString["mobile"].ToString();
            string result = Consumerforgotpassword(email);
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "fillnews")
        {
            string result = fillnews();
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "subscribenewsletter")
        {
            string email = context.Request.QueryString["email"].ToString();
            string result = subscribenewsletter(email);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "chkwarranty")
        {
            string code1 = context.Request.QueryString["codeone"];//context.Request.QueryString["email"].ToString();
            string code2 = context.Request.QueryString["codetwo"];
            string result = checkWarranty(code1, code2);

            HttpContext.Current.Session["lat"] = null;
            HttpContext.Current.Session["long"] = null;


            if (!string.IsNullOrEmpty(context.Request.QueryString["lat"]))
                HttpContext.Current.Session["lat"] = context.Request.QueryString["lat"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["long"]))
                HttpContext.Current.Session["long"] = context.Request.QueryString["long"].ToString();



            HttpContext.Current.Session["Code1"] = null;
            HttpContext.Current.Session["Code2"] = null;
            HttpContext.Current.Session["Code1"] = code1;
            HttpContext.Current.Session["Code2"] = code2;

            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "chkUsedCode")
        {  // RELX INDIA PRIVATE LIMITED - Tej
            string code1 = context.Request.QueryString["codeone"];//context.Request.QueryString["email"].ToString();
            string code2 = context.Request.QueryString["codetwo"];
            string CompID = context.Request.QueryString["CompID"];

            string result = "";
            code1 = (code1.Trim().Replace("'", "''"));
            code2 = (code2.Trim().Replace("'", "''"));
            CompID = (CompID.Trim().Replace("'", "''"));
            if (CompID == "Comp-1595")
            {
                //string dtcountcodecheck = SQL_DB.ExecuteScalar("select count('x') from Pro_Enq where Received_Code1='" + code1 + "' and Received_Code2='" + code2 + "' and Is_Success='1' ").ToString();
                //string dtcountcodecheck = SQL_DB.ExecuteScalar("select Use_Count from M_Code where Code1='" + code1 + "' and Code2='" + code2 + "' ").ToString();
                DataTable ds1 = SQL_DB.ExecuteDataTable("select Use_Count from M_Code where Code1='" + code1 + "' and Code2='" + code2 + "'");
                if (ds1.Rows.Count > 0)
                {

                    if (ds1.Rows[0]["Use_Count"].ToString() != "")
                    {
                        result = "UsedCode";
                    }
                }
                else
                {
                    result = "UsedCode"; // invalid Code
                }

            }

            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "chklocation")
        {

            HttpContext.Current.Session["lat"] = null;
            HttpContext.Current.Session["long"] = null;


            if (!string.IsNullOrEmpty(context.Request.QueryString["lat"]))
                HttpContext.Current.Session["lat"] = context.Request.QueryString["lat"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["long"]))
                HttpContext.Current.Session["long"] = context.Request.QueryString["long"].ToString();


            context.Response.Write("Success");
        }
        else if (context.Request.QueryString["method"] == "ProcessRequestevent")
        {
            ProcessRequestevent(context);

        }
        else if (context.Request.QueryString["method"] == "autobrowsesave")
        {
            // string email = context.Request.QueryString["email"].ToString(); //HttpContext.Current.Request.Form["email"];
            string mobile = context.Request.QueryString["mobile"].ToString();//HttpContext.Current.Request.Form["mobile"];
            mobile = "91" + mobile.Substring(mobile.Length - 10);
            //string billno = context.Request.QueryString["billno"].ToString(); //HttpContext.Current.Request.Form["billno"];
            // string purchasedate = context.Request.QueryString["purchasedate"].ToString(); // HttpContext.Current.Request.Form["purchasedate"];
            string purchasedate = DateTime.Today.ToString("MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture); // HttpContext.Current.Request.Form["purchasedate"];
            string code = context.Request.QueryString["code"].ToString();

            //var path = "";
            //var virtualPath = "";
            string period = string.Empty;
            DateTime expDate = DateTime.Today;
            // foreach (HttpPostedFile file in context.Request.Files)
            //foreach (string key in HttpContext.Current.Request.Files)
            //{
            //    var file = HttpContext.Current.Request.Files[key];
            //    if (HttpContext.Current.Session["strWar"] == null)
            //    {
            DataRow product_details = GetProductName(code);
            string prdName = product_details["Pro_name"].ToString();
            DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(code);

            #region Avoid code check from website for Hafila
            string strWar = "";
            if (dsServicesAssign.Tables[0].Rows[0]["Comp_Id"].ToString() == "Comp-1615")
            {
                strWar = "To Check Code Please Download the App Hafila";
                return;
            }
            #endregion
            DataRow[] servicedetais = dsServicesAssign.Tables[0].Select("Service_id = 'SRV1023'");

            DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            period = servicedetais[0]["WarrantyPeriod"].ToString();
            expDate = purDate.AddMonths(Convert.ToInt32(period));
            //DateTime expDate = purDate.AddYears(1);

            //string strWar = "The Product which you have purchased is Autopark Genuine Product. Product warranty of this product is valid till " + expDate.ToString().Substring(0,10);
            //HttpContext.Current.Session["strWar"] = strWar;
            //}
            //if (HttpContext.Current.Session["strWar"] != null)
            //{

            //    string result = Convert.ToString(HttpContext.Current.Session["strWar"]);
            //    string strMsg = result.ToString().Replace("(", "").Replace(")", "");
            //    context.Response.Write(strMsg);
            //}
            //var fileName = Path.GetFileName(file.FileName);
            //var fileName = Path.GetFileNameWithoutExtension(file.FileName) + "_" + Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
            //path = Path.Combine(context.Server.MapPath("~/WarrantyFile"), fileName);
            //virtualPath = Path.Combine("~/WarrantyFile", fileName);
            //file.SaveAs(path);


            //  }
            //if (context.Request.QueryString["app"] != null)
            //{

            //string xx = HttpContext.Current.Session["strWar"].ToString();
            //if (HttpContext.Current.Session["strWar"] == null)
            //{
            //    DataRow product_details = GetProductName(code);
            //    string prdName = product_details["Pro_name"].ToString();
            //    DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(code);
            //    DataRow[] servicedetais = dsServicesAssign.Tables[0].Select("Service_id = 'SRV1023'");

            //    DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            //    period = servicedetais[0]["WarrantyPeriod"].ToString();
            //    expDate = purDate.AddMonths(Convert.ToInt32(period));
            //    //DateTime expDate = purDate.AddYears(1);

            //    string strWar = "Warranty for the " + prdName +
            //          "has been registered successfully, Warranty validity till " + expDate + " To claim your warranty visit <a href='https://www.vcqru.com/'>https://www.vcqru.com/</a>";
            //    HttpContext.Current.Session["strWar"] = strWar;
            //}
            //if (HttpContext.Current.Session["strWar"] != null)
            //{
            //    string result = Convert.ToString(HttpContext.Current.Session["strWar"]);
            //    string strMsg = result.ToString().Replace("(", "").Replace(")", "");
            //    context.Response.Write(strMsg);
            //}
            //virtualPath = context.Request.QueryString["virtualpath"];
            //}
            SaveWarrentyDetailsforauto(purchasedate, mobile, code, expDate, period);
            //SaveWarrentyDetails(email, billno, purchasedate, mobile, virtualPath, code, expDate, period);
            /////////////////////////////////////////////

            //if (mobile.Length == 10)
            //    mobile = "91" + mobile;

            //DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email],Password FROM [M_Consumer] where [MobileNo] = '" + mobile + "'");
            //if (dcs.Tables[0].Rows.Count > 0)
            //{
            //    string ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
            //    string pass = dcs.Tables[0].Rows[0]["Password"].ToString();
            //    string MailBody = "";
            //    MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
            //                               " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
            //                               " <hr style='border:1px solid #2587D5;'/>" +
            //                               " <div class='w_frame'>" +
            //                               " <p>" +
            //                               " <div class='w_detail'>" +
            //                               " <span>Dear <em><strong> Sir/Mam,</strong></em></span><br />" +
            //                               " <br />" +
            //                               " <span>Warranty registered successfully. Login to https://vcqru.com/default.aspx#logsign  Claim warranty </span><br />" +
            //                               " Your Login Credentials  <br /> <strong> User Id - " + dcs.Tables[0].Rows[0]["MobileNo"].ToString() + "</strong><br /> <strong> Password - " + pass + "</strong>  " +
            //                               "<br /><br /> We will contact you soon.   <br />" +
            //                               " <p>" +
            //                               " <div class='w_detail'>" +
            //                               " Assuring you  of  our best services always.<br />" +
            //                               " Thank you,<br /><br />" +
            //                               " Team <em><strong>VCQRU.COM,</strong></em><br />" +
            //                               "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
            //                               " </div>" +
            //                               " </p>" +
            //                               " </div>" +
            //                               " </p>" +
            //                               " </div> " +
            //                               " </div> ";

            //    DataSet dsMl = function9420.FetchMailDetail("support");
            //    //if (dsMl.Tables[0].Rows.Count > 0)
            //    //{
            //    //    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
            //    //        email, MailBody, "Warranty Registration");

            //    //}
            //}
            ////////////////////////////////////////////////
            // ConsumerRegisterAndEmail(email,mobile,"");
        }
        else if (context.Request.QueryString["method"] == "browsesave")
        {
            string comp_name = string.Empty;
            string email = context.Request.QueryString["email"].ToString(); //HttpContext.Current.Request.Form["email"];
            string mobile = context.Request.QueryString["mobile"].ToString();//HttpContext.Current.Request.Form["mobile"];
            string billno = context.Request.QueryString["billno"].ToString(); //HttpContext.Current.Request.Form["billno"];
            string purchasedate = context.Request.QueryString["purchasedate"].ToString(); // HttpContext.Current.Request.Form["purchasedate"];
            string code = context.Request.QueryString["code"].ToString();
            //string state = context.Request.QueryString["state"].ToString();
            //string city = context.Request.QueryString["city"].ToString();
            //string dealerName = context.Request.QueryString["dealerName"].ToString();
            string state = "";
            string city = "";
            string dealerName = "";
            if (context.Request.QueryString["state"] != null)
            {
                state = context.Request.QueryString["state"].ToString();

            }
            if (context.Request.QueryString["city"] != null)
            {

                city = context.Request.QueryString["city"].ToString();

            }
            if (context.Request.QueryString["dealerName"] != null)
            {

                dealerName = context.Request.QueryString["dealerName"].ToString();
            }

            mobile = "91" + mobile.Substring(mobile.Length - 10);
            var path = "";
            var virtualPath = "";
            string period = string.Empty;
            DateTime expDate = DateTime.Today;
            // foreach (HttpPostedFile file in context.Request.Files)
            foreach (string key in HttpContext.Current.Request.Files)
            {
                var file = HttpContext.Current.Request.Files[key];
                //if (HttpContext.Current.Session["strWar"] == null)
                //{
                DataRow product_details = GetProductName(code);
                string prdName = product_details["Pro_name"].ToString();
                DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(code);

                #region Avoid code check from website for Hafila
                string strWar = "";
                if (dsServicesAssign.Tables[0].Rows[0]["Comp_Id"].ToString() == "Comp-1615")
                {
                    strWar = "To Check Code Please Download the App Hafila";
                    return;
                }
                #endregion

                DataRow[] servicedetais = dsServicesAssign.Tables[0].Select("Service_id = 'SRV1023'");
                //  string strWar = "";


                if (dsServicesAssign.Tables.Count > 0)
                {
                    if (dsServicesAssign.Tables[0].Rows.Count > 0)
                    {

                        // DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);

                        DateTime purDate = Convert.ToDateTime(purchasedate);
                        period = servicedetais[0]["WarrantyPeriod"].ToString();

                        expDate = purDate.AddMonths(Convert.ToInt32(period));
                        //  string year = (Convert.ToDouble(period) / 12).ToString();
                        string year = Math.Round((Convert.ToDouble(period) / 12), 2).ToString(); //-- Tej


                        //DateTime expDate = purDate.AddYears(1);
                        comp_name = SQL_DB.ExecuteScalar("select comp_name from comp_reg where comp_id='" + servicedetais[0]["Comp_id"].ToString() + "'").ToString();
                        //string strWar = ""; ;
                        if (comp_name != "Delta Luminaries" && comp_name != "TNT" && comp_name != "ORBIT ELECTRODOMESTICS INDIA" && comp_name != "FUAO INTERIO PRIVATE LIMITED" && comp_name != "TECHNICAL MINDS PRIVATE LIMITED")
                            strWar = "Warranty for the " + prdName + "has been registered successfully, Warranty validity till " + expDate + " To claim your warranty visit <a href='https://www.vcqru.com/'>https://www.vcqru.com/</a>";
                        else if (comp_name.ToUpper() == "TNT")
                            //strWar = year + "-year warranty for your TNT product has been successfully registered with coupon code " + code;
                            // strWar = year + "-year warranty for your TNT product has been successfully registered with coupon code " + code;
                            strWar = year + "- year warranty for your TNT product has been successfully registered with coupon code " + code;
                        else if (comp_name.ToUpper() == "FUAO INTERIO PRIVATE LIMITED")
                            strWar = "Congratulations You have purchased an Authentic Product of Fuao and " + year + "-year warranty for your FUAO INTERIO PRIVATE LIMITED product has been successfully registered with coupon code " + code;
                        else if (comp_name.ToUpper() == "ORBIT ELECTRODOMESTICS INDIA")
                            strWar = "Congratulations on your purchase. This is an authentic product of Orbit and You have successfully registered your product for the warranty of " + year + " year. <br>to claim the warranty <a href='https://www.vcqru.com/login.aspx'>click here</a>";
                        else if (comp_name.ToUpper() == "TECHNICAL MINDS PRIVATE LIMITED")
                            strWar = "Congratulations on your purchase. You have successfully registered your product for the warranty of " + year + " year<br>आपकी खरीदारी पर बधाई. आपने " + year + " वर्ष की वारंटी के लिए अपने उत्पाद को सफलतापूर्वक पंजीकृत कर लिया है. <br><br> Claim the warranty <a href='https://www.vcqru.com/login.aspx'>Login Here</a><br>वारंटी का दावा करें <a href='https://www.vcqru.com/login.aspx'>यहां लॉगिन </a> करें,<br/><br/>The warranty is valid till " + expDate.ToString().Substring(0, 10) + " <br/>वारंटी " + expDate.ToString().Substring(0, 10) + " तक वैध है";

                        else
                            strWar = "Congratulations on your purchase. This is an authentic product of Orbit and You have successfully registered your product for the warranty of " + year + " year. <br>to claim the warranty <a href='https://www.vcqru.com/login.aspx'>click here</a>";


                        HttpContext.Current.Session["strWar"] = strWar;
                        //  }
                        if (HttpContext.Current.Session["strWar"] != null)
                        {
                            string result = Convert.ToString(HttpContext.Current.Session["strWar"]);
                            string strMsg = result.ToString().Replace("(", "").Replace(")", "");
                            context.Response.Write(strMsg);
                        }
                        //var fileName = Path.GetFileName(file.FileName);
                        var fileName = Path.GetFileNameWithoutExtension(file.FileName) + "_" + Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                        path = Path.Combine(context.Server.MapPath("~/WarrantyFile"), fileName);
                        virtualPath = Path.Combine("~/WarrantyFile", fileName);
                        file.SaveAs(path);


                    }
                    else
                    {
                        strWar = "Invalid Code!";
                    }
                }
                else
                {
                    strWar = "Invalid Code2!";
                }

            }
            if (context.Request.QueryString["app"] != null)
            {
                if (HttpContext.Current.Session["strWar"] == null)
                {
                    DataRow product_details = GetProductName(code);
                    string prdName = product_details["Pro_name"].ToString();
                    DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(code);
                    DataRow[] servicedetais = dsServicesAssign.Tables[0].Select("Service_id = 'SRV1023'");

                    DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                    period = servicedetais[0]["WarrantyPeriod"].ToString();
                    expDate = purDate.AddMonths(Convert.ToInt32(period));
                    //DateTime expDate = purDate.AddYears(1);

                    string strWar = "Warranty for the " + prdName +
                          "has been registered successfully, Warranty validity till " + expDate + " To claim your warranty visit <a href='https://www.vcqru.com/'>https://www.vcqru.com/</a>";
                    HttpContext.Current.Session["strWar"] = strWar;
                }
                if (HttpContext.Current.Session["strWar"] != null)
                {
                    string result = Convert.ToString(HttpContext.Current.Session["strWar"]);
                    string strMsg = result.ToString().Replace("(", "").Replace(")", "");
                    context.Response.Write(strMsg);
                }
                virtualPath = context.Request.QueryString["virtualpath"];
            }

            SaveWarrentyDetails(email, billno, purchasedate, mobile, virtualPath, code, expDate, period, state, city, dealerName);
            /////////////////////////////////////////////

            if (mobile.Length == 10)
                mobile = "91" + mobile;

            DataSet dcs = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] where [MobileNo] = '" + mobile + "'");
            if (dcs.Tables[0].Rows.Count > 0)
            {
                string ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
                string pass = dcs.Tables[0].Rows[0]["Password"].ToString();
                string MailBody = "";


                string subject = "Thank You for Registering Your Product with Orbit Electrodomestics Pvt. Ltd.";
                string MailBody2 = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                " <div class='w_logo'><img style='height: 5rem;' src='" + ProjectSession.absoluteSiteBrowseUrl + "/assets/images/orbit/orbit-logo.png' alt='logo' /></div>" +
                " <hr style='border:1px solid #2587D5;'/>" +
                " <div class='w_frame'>" +
                " <p>" +
                " <div class='w_detail'>" +
                " <span>Dear <em><strong>" + dcs.Tables[0].Rows[0]["ConsumerName"].ToString() + ",</strong></em></span><br />" +
                " <br />" +
                "We extend our heartfelt gratitude for choosing our products. We appreciate your trust in our brand and are delighted to inform you that your recent purchase has been successfully registered for e-warranty of 1 year and will be valid till " + expDate +
                "<br/>" +
                 "<br/>" +
                " By registering your product for e-warranty, you have taken an important step in ensuring the long-lasting performance of your purchase. Our e-warranty program is designed to provide you with seamless support and assistance whenever needed." +
                 "<br/>" +
                 "<br/>" +
                "If you have any questions or require further assistance, please do not hesitate to reach out to our customer support team at +919167981567. We are here to assist you in every possible way." +
                 "<br/>" +
                 "<br/>" +
                "Once again, thank you for choosing Orbit Electrodomestics. We look forward to being a part of your daily life and adding value to your home." +
                 " <br />" +
                  " <br />" +
                 " <span>Warranty registered successfully. Login to https://www.vcqru.com/login.aspx#logsign  Claim warranty </span><br />" +
               " Your Login Credentials  <br /> <strong> Mobile Number - " + mobile + "</strong><br /> <strong> Password - " + pass + "</strong>  " +
                " <br />" +
               "Best regards," +
               " <br />" +
               "Orbit Electrodomestics Pvt. Ltd." +
                " </div>" +
                " </p>" +
                " </div>" +
                " </p>" +
                " </div> " +
                " </div> ";


                MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                                           " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
                                           " <hr style='border:1px solid #2587D5;'/>" +
                                           " <div class='w_frame'>" +
                                           " <p>" +
                                           " <div class='w_detail'>" +
                                           " <span>Dear <em><strong> Sir/Mam,</strong></em></span><br />" +
                                           " <br />" +
                                           " <span>Warranty registered successfully. Login to https://www.vcqru.com/login.aspx#logsign  Claim warranty </span><br />" +
                                           " Your Login Credentials  <br /> <strong> Mobile Number - " + mobile + "</strong><br /> <strong> Password - " + pass + "</strong>  " +
                                           "<br /><br /> We will contact you soon.   <br />" +
                                           " <p>" +
                                           " <div class='w_detail'>" +
                                           " Assuring you  of  our best services always.<br />" +
                                           " Thank you,<br /><br />" +
                                           " Team <em><strong>VCQRU.COM,</strong></em><br />" +

                                           " </div>" +
                                           " </p>" +
                                           " </div>" +
                                           " </p>" +
                                           " </div> " +
                                           " </div> ";

                //  hypersonic
                string subjectHyper = "Thank You for Registering Your Product with TECHNICAL MINDS PRIVATE LIMITED";
                string MailBodyHyprsonic = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                                            " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/assets/images/hypersonic/hypersonic-logo.png' alt='logo' style='width:230px' /></div>" +
                                             " <h2>E-Warranty Confirmation</h2>" +
                                            " <hr style='border:1px solid #2587D5;'/>" +

                                            " <div class='w_frame'>" +
                                            " <p>" +
                                            " <div class='w_detail'>" +
                                            " <span> <em><strong>Dear Sir/Mam,</strong></em></span><br />" +
                                            " <br />" +
                                            " <span>Warranty registered successfully. Login to https://www.vcqru.com/login.aspx to Claim warranty </span><br />" +
                                            " Your Login Credentials  <br /> <strong> Mobile Number - " + mobile + "</strong><br /> <strong> Password - " + pass + "</strong>  " +
                                            "<br /><br /> We will contact you soon.   <br />" +
                                            " <p>" +
                                            " <div class='w_detail'>" +
                                            " Assuring you  of  our best services always.<br />" +
                                            " Thank you,<br /><br />" +
                                            " Team <em><strong>Technical Minds India Pvt. Ltd.,</strong></em><br />" +
                                            "  technicalminds1980@gmail.com  <br />" +
                                            " </div>" +
                                            " </p>" +
                                            " </div>" +
                                            " </p>" +
                                            " </div> " +
                                            " </div> ";

                DataSet dsMl = function9420.FetchMailDetail("support");
                if (dsMl.Tables[0].Rows.Count > 0)
                {
                    //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
                    //    email, MailBody, "Warranty Registration");

                    if (comp_name == "ORBIT ELECTRODOMESTICS INDIA")
                    {
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
                           email, MailBody2, subject);
                    }
                    else if (comp_name == "TECHNICAL MINDS PRIVATE LIMITED")
                    {
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
                           email, MailBodyHyprsonic, subjectHyper);
                    }
                    else
                    {
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
                       email, MailBody, "Warranty Registration");
                    }

                }
            }
            ////////////////////////////////////////////////
            // ConsumerRegisterAndEmail(email,mobile,"");
        }
        else if (context.Request.QueryString["method"] == "otpsend")
        {

            string mobileNumber = context.Request.QueryString["mobile"].ToString();
            mobileNumber = mobileNumber.Substring(mobileNumber.Length - 10);
            DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email],Password FROM [M_Consumer] where [MobileNo] like '%" + mobileNumber + "' and  IsDelete=0");

            if (dcs.Tables[0].Rows.Count == 0)
            {
                User_Details user = new User_Details();
                if (mobileNumber.Length == 10)
                    mobileNumber = "91" + mobileNumber;
                user.MobileNo = mobileNumber;
                user.DML = "I";
                user.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy-MM-dd hh:mm:ss.ttt"));
                User_Details.InsertUpdateUserDetails(user);

            }
            int rdmNumber = RandomNumber(1000, 9999);

            string otpMsg = "Your Employee verification OTP is " + rdmNumber + " www.vcqru.com md5b2lDaeHj";
            //string  otpMsg = "%3C%23%3E OTP is " + rdmNumber + " for login at vcqru. Valid till "+DateTime.Now.AddMinutes(3).ToShortTimeString()+" "+ConfigurationManager.AppSettings["hashvalue"];
            //string sendSMSurl = "http://sms.alfasms.in/sendSMS?username=alfasms&message=" + otpMsg + "&sendername=Alfast&smstype=TRANS&numbers=" + mobileNumber + "&apikey=d13cfc39-dae1-4462-8b46-5a2ab78ca5c1";
            //Your password  is " + dt.Rows[0]["Password"].ToString() + " VCQRU.com
            //SendSmsWithAlfa(otpMsg, mobileNumber);
            HttpContext.Current.Session["otpSendTimes"] = 1;

            ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");

            DateTime expDate = System.DateTime.Now.AddYears(1); //purDate.AddYears(1);
                                                                //int otp_counter = Convert.ToInt16(SQL_DB.ExecuteScalar("select count([mobileNumber]) from [dbo].[CompanyProduct] where [mobileNumber]='" + mobileNumber + "'"));
                                                                //if(otp_counter > 0)
                                                                //{
                                                                //    SQL_DB.ExecuteNonQuery("update [dbo].[CompanyProduct] set [expiryDate]='" + expDate.ToString("MM/dd/yyyy") + "', [otp]='" + rdmNumber + "', [status]=0,[mobileNumber]='" + mobileNumber + "'");
                                                                //}
                                                                //else
                                                                //{
            SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[CompanyProduct] ([expiryDate], [otp], [status],[mobileNumber]) values ('" + expDate.ToString("yyyy-MM-dd HH:mm:ss") + "', '" + rdmNumber + "', 0, '" + mobileNumber + "')");
            //}
            context.Response.Write("1," + rdmNumber);

        }
        else if (context.Request.QueryString["method"] == "android_otpsend")
        {

            otp_response otp = new otp_response();

            string mobileNumber = context.Request.QueryString["mobile"].ToString();
            mobileNumber = mobileNumber.Substring(mobileNumber.Length - 10);
            DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email],Password FROM [M_Consumer] where [MobileNo] like '%" + mobileNumber + "' and IsDelete=0");

            if (dcs.Tables[0].Rows.Count == 0)
            {
                User_Details user = new User_Details();
                Random rnd = new Random();
                user.Password = rnd.Next(10000, 99999).ToString();
                if (mobileNumber.Length == 10)
                    mobileNumber = "91" + mobileNumber;
                user.MobileNo = mobileNumber;
                user.DML = "I";
                user.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy-MM-dd hh:mm:ss.ttt"));
                User_Details.InsertUpdateUserDetails(user);

            }
            int rdmNumber = RandomNumber(1000, 9999);

            string otpMsg = "Your Employee verification OTP is " + rdmNumber + " www.vcqru.com md5b2lDaeHj";
            // string  otpMsg = "%3C%23%3E OTP is " + rdmNumber + " for login at vcqru. Valid till "+DateTime.Now.AddMinutes(3).ToShortTimeString()+" "+ConfigurationManager.AppSettings["hashvalue"];
            //string sendSMSurl = "http://sms.alfasms.in/sendSMS?username=alfasms&message=" + otpMsg + "&sendername=Alfast&smstype=TRANS&numbers=" + mobileNumber + "&apikey=d13cfc39-dae1-4462-8b46-5a2ab78ca5c1";
            //Your password  is " + dt.Rows[0]["Password"].ToString() + " VCQRU.com
            //SendSmsWithAlfa(otpMsg, mobileNumber);
            HttpContext.Current.Session["otpSendTimes"] = 1;

            ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");

            DateTime expDate = System.DateTime.Now.AddYears(1); //purDate.AddYears(1);
                                                                //int otp_counter = Convert.ToInt16(SQL_DB.ExecuteScalar("select count([mobileNumber]) from [dbo].[CompanyProduct] where [mobileNumber]='" + mobileNumber + "'"));
                                                                //if(otp_counter > 0)
                                                                //{
                                                                //    SQL_DB.ExecuteNonQuery("update [dbo].[CompanyProduct] set [expiryDate]='" + expDate.ToString("MM/dd/yyyy") + "', [otp]='" + rdmNumber + "', [status]=0,[mobileNumber]='" + mobileNumber + "'");
                                                                //}
                                                                //else
                                                                //{
            SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[CompanyProduct] ([expiryDate], [otp], [status],[mobileNumber]) values ('" + expDate.ToString("yyyy-MM-dd HH:mm:ss") + "', '" + rdmNumber + "', 0, '" + mobileNumber + "')");
            //}
            otp.success = 1;
            otp.otp = rdmNumber.ToString(); ;
            //context.Response.Write("1," + rdmNumber);

            DataProvider.LogManager.ErrorExceptionLog("Location: masterhandler.aspx  Line 2649 :" + otp);

            context.Response.Write(JsonConvert.SerializeObject(otp, Formatting.Indented));



        }

        else if (context.Request.QueryString["method"] == "android_otpsend_1")
        {

            otp_response otp = new otp_response();

            string mobileNumber = context.Request.QueryString["mobile"].ToString();
            mobileNumber = mobileNumber.Substring(mobileNumber.Length - 10);
            DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email],Password FROM [M_Consumer] where [MobileNo] like '%" + mobileNumber + "' and IsDelete=0");

            if (dcs.Tables[0].Rows.Count == 0)
            {
                User_Details user = new User_Details();
                Random rnd = new Random();
                user.Password = rnd.Next(10000, 99999).ToString();
                if (mobileNumber.Length == 10)
                    mobileNumber = "91" + mobileNumber;
                user.MobileNo = mobileNumber;
                user.DML = "I";
                user.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy-MM-dd hh:mm:ss.ttt"));
                User_Details.InsertUpdateUserDetails(user);

            }
            int rdmNumber = RandomNumber(1000, 9999);
            string otpMsg = string.Empty;
            if (context.Request.QueryString["compName"] == "BlackCobra")
            {
                otpMsg = "%3C%23%3E Your Employee verification OTP is " + rdmNumber + " vcqru.com. TCSquYx9UD9, agvkT8I1MqO";
            }
            else
            {
                otpMsg = "Your Employee verification OTP is " + rdmNumber + " www.vcqru.com md5b2lDaeHj";
            }
            //string otpMsg = "%3C%23%3E Your Employee verification OTP is " + rdmNumber + " vcqru.com. TCSquYx9UD9";
            // string  otpMsg = "%3C%23%3E OTP is " + rdmNumber + " for login at vcqru. Valid till "+DateTime.Now.AddMinutes(3).ToShortTimeString()+" "+ConfigurationManager.AppSettings["hashvalue"];
            //string sendSMSurl = "http://sms.alfasms.in/sendSMS?username=alfasms&message=" + otpMsg + "&sendername=Alfast&smstype=TRANS&numbers=" + mobileNumber + "&apikey=d13cfc39-dae1-4462-8b46-5a2ab78ca5c1";
            //Your password  is " + dt.Rows[0]["Password"].ToString() + " VCQRU.com
            //SendSmsWithAlfa(otpMsg, mobileNumber);
            HttpContext.Current.Session["otpSendTimes"] = 1;

            ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");

            DateTime expDate = System.DateTime.Now.AddYears(1); //purDate.AddYears(1);
                                                                //int otp_counter = Convert.ToInt16(SQL_DB.ExecuteScalar("select count([mobileNumber]) from [dbo].[CompanyProduct] where [mobileNumber]='" + mobileNumber + "'"));
                                                                //if(otp_counter > 0)
                                                                //{
                                                                //    SQL_DB.ExecuteNonQuery("update [dbo].[CompanyProduct] set [expiryDate]='" + expDate.ToString("MM/dd/yyyy") + "', [otp]='" + rdmNumber + "', [status]=0,[mobileNumber]='" + mobileNumber + "'");
                                                                //}
                                                                //else
                                                                //{
            SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[CompanyProduct] ([expiryDate], [otp], [status],[mobileNumber]) values ('" + expDate.ToString("yyyy-MM-dd HH:mm:ss") + "', '" + rdmNumber + "', 0, '" + mobileNumber + "')");
            //}
            otp.success = 1;
            otp.otp = rdmNumber.ToString(); ;
            //context.Response.Write("1," + rdmNumber);
            DataProvider.LogManager.ErrorExceptionLog("Location: masterhandler.aspx  Line 2703 :" + otp);

            context.Response.Write(JsonConvert.SerializeObject(otp, Formatting.Indented));

        }


        else if (context.Request.QueryString["method"] == "app_OTPVerify")
        {
            string result;
            string otp = context.Request.QueryString["verifycode"].ToString();
            string mobile = context.Request.QueryString["mobile"].ToString();
            DataSet dsOTPVerify = app_OTPVerify(otp, mobile);
            if (dsOTPVerify.Tables[0].Rows[0][0].ToString() == otp)
            {
                result = "Success";
            }
            else
            {
                result = "Usuccess";
            }
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "web_OTPVerify")
        {
            string result;
            string userid;
            string otp = context.Request.QueryString["verifycode"].ToString();
            string MobileNo = context.Request.QueryString["mobile"].ToString();
            DataSet dsOTPVerify = app_OTPVerify(otp, MobileNo);
            if (dsOTPVerify.Tables[0].Rows[0][0].ToString() == otp)
            {
                User_Details Log = new User_Details();

                Log.DML = "Mobile";
                #region Find Actual Mobile No
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
                    else
                    {
                        result = "Mobile No. Wrong!";

                    }
                }
                if (MobileNo.Length == 10)
                    MobileNo = "91" + MobileNo;
                #endregion

                Log.User_Type = "Consumer";
                Log.User_ID = MobileNo;
                //Log.Password = pass.Trim().Replace("'", "''");
                DataTable dt = User_Details.app_GetUserLoginDetails(Log);
                if (dt.Rows.Count > 0)
                {
                    //if (remember == 1)
                    //{
                    //    HttpContext.Current.Response.Cookies["ConsumerUserName"].Value = Log.User_ID;
                    //    HttpContext.Current.Response.Cookies["ConsumerPassword"].Value = pass.Trim();
                    //    HttpContext.Current.Response.Cookies["ConsumerUserName"].Expires = DateTime.Now.AddDays(15);
                    //    HttpContext.Current.Response.Cookies["ConsumerPassword"].Expires = DateTime.Now.AddDays(15);

                    //    if (!string.IsNullOrEmpty(dt.Rows[0]["employeeID"].ToString()) && !string.IsNullOrEmpty(dt.Rows[0]["distributorID"].ToString()))
                    //    {
                    //        HttpContext.Current.Session["MMUser"] = "MMUSERR";
                    //    }
                    //    else { HttpContext.Current.Session["MMUser"] = ""; }

                    //    //string sQry = "Select * from M_Consumer Where MobileNo='" + MobileNo + "' and employeeID IS NOT NULL and distributorID IS NOT NULL";
                    //    //DataSet dsConsumer = SQL_DB.ExecuteDataSet(sQry);
                    //    //if (dsConsumer.Tables[0].Rows.Count > 0)
                    //    //{
                    //    //    HttpContext.Current.Session["MMUser"] = "MMUSERR";
                    //    //}
                    //}
                    //else if (remember == 0)
                    //{
                    //    HttpContext.Current.Response.Cookies["ConsumerUserName"].Value = null;
                    //    HttpContext.Current.Response.Cookies["ConsumerPassword"].Value = null;
                    //}
                    //HttpContext.Current.Session["User_Type"] = "Consumer";
                    //HttpContext.Current.Session["USRID"] = dt.Rows[0]["User_ID"].ToString();
                    HttpContext.Current.Session["Consumer_id"] = dt.Rows[0]["m_consumerid"].ToString();
                    ProjectSession.strUser_Type = "Consumer";
                    ProjectSession.strConsumerUserID = dt.Rows[0]["User_ID"].ToString();
                    ProjectSession.intM_ConsumeriD = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
                    if (dt.Rows[0]["ConsumerName"].ToString() != "")
                    {
                        HttpContext.Current.Session["USRNAME"] = dt.Rows[0]["ConsumerName"].ToString();
                        ProjectSession.strConsumerName = dt.Rows[0]["ConsumerName"].ToString();

                    }
                    else
                        HttpContext.Current.Session["USRNAME"] = null;
                    // HttpContext.Current.Session["USRMOBILENO"] = dt.Rows[0]["MobileNo"].ToString();
                    ProjectSession.strMobileNo = dt.Rows[0]["MobileNo"].ToString();
                    result = "Success";// + "~" + dt.Rows[0]["MM"].ToString()
                }
                else
                {
                    result = "Invalid userid or password !";

                }



            }
            else
            {
                result = "Usuccess";
            }
            //if(dsOTPVerify.Tables[0].Rows.Count>0)
            //{
            //    result= "Success";
            //}
            //else
            //{
            //    result= "Usuccess";
            //}
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "billdetails")
        {
            string warrantycode = context.Request.QueryString["code"];
            string code1 = warrantycode.Substring(0, 5);
            string code2 = warrantycode.Substring(5, 8);
            string id = SQL_DB.ExecuteScalar("select top 1 imagepathbill from WarrentyDetails where code='" + code1 + "-" + code2 + "'").ToString();
            context.Response.Write(id);
        }
        else if (context.Request.QueryString["method"] == "imagedetails")
        {
            string warrantycode = context.Request.QueryString["code"];
            string code1 = warrantycode.Substring(0, 5);
            string code2 = warrantycode.Substring(5, 8);
            string id = SQL_DB.ExecuteScalar("select id from WarrentyDetails where code='" + code1 + "-" + code2 + "'").ToString();
            string result = getimagepaths(id);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "updatewarrantydetails")
        {
            string comment = context.Request.QueryString["comment"];//context.Request.QueryString["email"].ToString();
                                                                    // string id = context.Request.QueryString["id"];
            var path = "";
            var virtualPath = "";
            string warrantycode = context.Request.QueryString["code"];
            string code1 = warrantycode.Substring(0, 5);
            string code2 = warrantycode.Substring(5, 8);
            // string id = SQL_DB.ExecuteScalar("select id from WarrentyDetails where code='" + code1 + "-" + code2 + "'").ToString();
            // hypersonic Tej
            string id = SQL_DB.ExecuteScalar("select top 1 id from WarrentyDetails where code='" + code1 + "-" + code2 + "' order by id desc").ToString();

            // foreach (HttpPostedFile file in context.Request.Files)
            foreach (string key in HttpContext.Current.Request.Files)
            {
                var file = HttpContext.Current.Request.Files[key];
                if (HttpContext.Current.Session["strWar"] == null)
                {
                    string strWar = "Warranty claimed for the product, wait for the vendor  approval.";
                    HttpContext.Current.Session["strWar"] = strWar;
                }
                if (HttpContext.Current.Session["strWar"] != null)
                {
                    string result = Convert.ToString(HttpContext.Current.Session["strWar"]);
                    context.Response.Write(result);
                }
                var fileName = Path.GetFileNameWithoutExtension(file.FileName) + "_" + Guid.NewGuid().ToString() + "." + Path.GetExtension(file.FileName);
                path = Path.Combine(context.Server.MapPath("~/WarrantyFile"), fileName);
                virtualPath = Path.Combine("~/WarrantyFile", fileName);
                file.SaveAs(path);
                InsertFiles("", fileName, "", virtualPath, id);
            }
            UpdateClaimWarrentyDetails(comment, virtualPath, id);

            // mail for orbit by Tej for ORBIT ELECTRODOMESTICS INDIA
            DataSet ds2 = SQL_DB.ExecuteDataSet("SELECT m.ConsumerName,w.Email,m.MobileNo,Comment FROM WarrentyDetails w inner join M_consumer m  on m.mobileno=w.mobile WHERE id= '" + id + "'");

            String ConsumerName = ds2.Tables[0].Rows[0]["ConsumerName"].ToString();
            String Email = ds2.Tables[0].Rows[0]["Email"].ToString();
            String MobileNo = ds2.Tables[0].Rows[0]["MobileNo"].ToString();
            //  String subjectfrm = ds2.Tables[0].Rows[0]["subjectfrm"].ToString();
            String Comment = ds2.Tables[0].Rows[0]["Comment"].ToString();
            string coded = code1 + "-" + code2;

            DataTable Wdate = SQL_DB.ExecuteDataTable("select * from [WarrentyDetails] where Code='" + coded + "'");
            string rscompPro_ID = SQL_DB.ExecuteScalar("select Pro_ID from M_Code where Code1='" + code1 + "' and Code2='" + code2 + "'").ToString();
            string rscompID = string.Empty;
            DataTable dtproduct = SQL_DB.ExecuteDataTable("select * from Pro_Reg where Pro_ID='" + rscompPro_ID + "'");
            rscompID = dtproduct.Rows[0]["Comp_ID"].ToString();

            DataTable dtcompdetails = SQL_DB.ExecuteDataTable("select*from comp_reg where Comp_ID ='" + rscompID + "' ");
            if (rscompID == "Comp-1625")
            {
                string subject = "Warranty Claim Submission - " + rscompID;
                string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
                " <hr style='border:1px solid #2587D5;'/>" +
                " <div class='w_frame'>" +
                " <p>" +
                " <div class='w_detail'>" +
                " <span>Dear <em><strong>" + dtcompdetails.Rows[0]["comp_name"].ToString() + ",</strong></em></span><br />" +
                " <br />" +
                "We have received a warranty claim for one of our products, and we wanted to inform you promptly to initiate the necessary steps for resolution. Below are the details of the warranty claim: " +
                "<br/>" +

                 "Claim Date and Time: " + Wdate.Rows[0]["claimdate"].ToString() +
                    " <br />" +
                    "13-Digit VCQRU Code: " + Wdate.Rows[0]["Code"].ToString() +
                 " <br />" +
                   "Claim Remark: " + Wdate.Rows[0]["Comment"].ToString() +
                 " <br />" +
                  "Product Name: " + dtproduct.Rows[0]["pro_name"].ToString() +
                 " <br />" +
                 "Customer Mobile number: " + MobileNo +
                 " <br />" +
                  "Customer email ID: " + Wdate.Rows[0]["Email"].ToString() +
                 " <br />" +
                   "To assist you in processing this claim efficiently, we have included additional information regarding the purchase of the product: " +
                 " <br />" +

                    " Purchase Date:  " + Wdate.Rows[0]["PurchaseDate"].ToString() +
                 " <br />" +
                    "Please login to VCQRU.com and review the claim.  " +
                 " <br />" +
                   "Thank you for your prompt attention to this matter.  " +
                 " <br />" +
                   " <br />" +

               "Best regards," +
               " <br />" +
               "VCQRU E Warranty." +
                " </div>" +
                " </p>" +
                " </div>" +
                " </p>" +
                " </div> " +
                " </div> ";

                DataSet dsMl = function9420.FetchMailDetail("support");
                if (dsMl.Tables[0].Rows.Count > 0)
                {
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), "rshukla@indiaorbit.in", MailBody, subject);
                    //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Media_accomplishtrades, MailBody1, subject);
                }
                //result = "Query has been sent successfully.";
            }
        }

        else if (context.Request.QueryString["method"] == "updatewarranty")
        {
            string comment = context.Request.QueryString["comment"];//context.Request.QueryString["email"].ToString();
            string id = context.Request.QueryString["id"];
            var path = "";
            var virtualPath = "";


            // foreach (HttpPostedFile file in context.Request.Files)
            foreach (string key in HttpContext.Current.Request.Files)
            {
                var file = HttpContext.Current.Request.Files[key];
                if (HttpContext.Current.Session["strWar"] == null)
                {
                    string strWar = "Warranty claimed for the product, wait for the vendor  approval.";
                    HttpContext.Current.Session["strWar"] = strWar;
                }
                if (HttpContext.Current.Session["strWar"] != null)
                {
                    string result = Convert.ToString(HttpContext.Current.Session["strWar"]);
                    context.Response.Write(result);
                }
                var fileName = Path.GetFileNameWithoutExtension(file.FileName) + "_" + Guid.NewGuid().ToString() + "." + Path.GetExtension(file.FileName);
                path = Path.Combine(context.Server.MapPath("~/WarrantyFile"), fileName);
                virtualPath = Path.Combine("~/WarrantyFile", fileName);
                file.SaveAs(path);
                InsertFiles("", fileName, "", virtualPath, id);
            }
            UpdateClaimWarrentyDetails(comment, virtualPath, id);
        }

        else if (context.Request.QueryString["method"] == "updatewarrantyVendor")
        {

            string comment = HttpContext.Current.Request.Form["comment"];//context.Request.QueryString["email"].ToString();
            string id = HttpContext.Current.Request.Form["id"];
            string approveStatus = HttpContext.Current.Request.Form["approveStatus"];

            UpdateClaimWarrentyDetailsVendor(comment, approveStatus, id);
        }
        else if (context.Request.QueryString["method"] == "updateclaimVendor")
        {

            string comment = HttpContext.Current.Request.Form["comment"];//context.Request.QueryString["email"].ToString();
            string id = HttpContext.Current.Request.Form["id"];
            string approveStatus = HttpContext.Current.Request.Form["approveStatus"];
            string mb = HttpContext.Current.Request.Form["mobileno"];
            int tpr = Convert.ToInt32(HttpContext.Current.Request.Form["amount"]);
            string cn = HttpContext.Current.Request.Form["company"];
            string company_name = SQL_DB.ExecuteScalar("select comp_name from comp_reg where comp_id='" + cn + "'").ToString();
            string oid = SQL_DB.ExecuteScalar("select (ISNULL(max(orderid),1000))+1 as orderid from [dbo].[paytmtransaction]").ToString();
            string consumerid = SQL_DB.ExecuteScalar("select m_consumerid from m_consumer  where MobileNo='" + mb + "'").ToString();
            string ps = string.Empty;

                 //if (company_name != "Lubigen Pvt Ltd")
                 //{
                 //    UpdateClaimDetailsVendor(comment, approveStatus, id, cn);
                 //    context.Response.Write(approveStatus);
                 //}
                 //if (company_name == "Lubigen Pvt Ltd" && approveStatus != "1")
                 //{
                 //    UpdateClaimDetailsVendor(comment, approveStatus, id, cn);
                 //    context.Response.Write(approveStatus);
                 //}
                 if (company_name == "VR KABLE INDIA PRIVATE LIMITED" && approveStatus == "1")
                {
                    SQL_DB.ExecuteNonQuery("insert into BPointsTransaction([Transsctionid],[TotalPoints],[RedeemPoints],[Redeemdate],[RedeemBy],Incash,bpstatus) values(" + id + "," + tpr + "," + tpr + ",'" + System.DateTime.Now.ToString("yyyy-MM-dd") + "','" + consumerid + "'," + tpr + ",'Accepted')");
                }
                  if ((company_name == "Lubigen Pvt Ltd" && approveStatus != "1") || (company_name == "SURIE POLEX INDUSTRIES PRIVATE LIMITED" && approveStatus != "1") )
                {
                     UpdateClaimDetailsVendor(comment, approveStatus, id, cn);
                     context.Response.Write(approveStatus);
                }
                else if ((company_name == "Lubigen Pvt Ltd" && approveStatus == "1") || (company_name == "SURIE POLEX INDUSTRIES PRIVATE LIMITED" && approveStatus == "1") )
                {

                    string InputData = "";
                    string txtUpiId = SQL_DB.ExecuteScalar("select UPIId from m_consumer  where MobileNo='" + mb + "'").ToString();
                    int ptforrd = tpr;
                    // int ptforrd = 11;
                    if (txtUpiId != "")
                    {
                        InputData = txtUpiId;
                        DataTable dt = new DataTable();
                        dt = SQL_DB.ExecuteDataTable("select top 1 [user_id],M_Consumerid,UPIId,MobileNo from m_consumer  where MobileNo='" + mb + "'");


                        string str = String.Format("https://api2.vcqru.com/api/ApiSubmitClaim");
                        WebRequest request = WebRequest.Create(str);
                        request.Method = "POST";
                        //string postData = "{\"Mobile\":\"" + dt.Rows[0]["MobileNo"].ToString() + "\",\"ProductId\":\"284\",\"Productvalue\":\"250\",\"ServiceId\":\"SRV1029\",\"Amount\":\"" + ptforrd + "\",\"UPIID\":\"" + txtUpiId + "\"}";
                        //string postData = "{\"Mobile\":\"" + dt.Rows[0]["MobileNo"].ToString() + "\",\"ProductId\":\"138\",\"Productvalue\":\"" + ptforrd + "\",\"ServiceId\":\"SRV1029\",\"Amount\":\"" + ptforrd + "\",\"UPIID\":\"" + txtUpiId + "\"}";
                        string postData = "";
                        //if (company_name == "Lubigen Pvt Ltd")
                        //{
                        //    postData = "{\"Mobile\":\"" + dt.Rows[0]["MobileNo"].ToString() + "\",\"ProductId\":\"" + id + "\",\"Productvalue\":\"250\",\"ServiceId\":\"SRV1029\",\"Amount\":\"" + ptforrd + "\",\"UPIID\":\"" + txtUpiId + "\"}";
                        //}
                        //else
                        //{
                        //    postData = "{\"Mobile\":\"" + dt.Rows[0]["MobileNo"].ToString() + "\",\"ProductId\":\"" + id + "\",\"Productvalue\":\"" + ptforrd + "\",\"ServiceId\":\"SRV1029\",\"Amount\":\"" + ptforrd + "\",\"UPIID\":\"" + txtUpiId + "\"}";

                        //}
                        postData = "{\"Mobile\":\"" + dt.Rows[0]["MobileNo"].ToString() + "\",\"ProductId\":\"" + id + "\",\"Productvalue\":\"" + ptforrd + "\",\"ServiceId\":\"SRV1029\",\"Amount\":\"" + ptforrd + "\",\"UPIID\":\"" + txtUpiId + "\"}";


                        byte[] byteArray = Encoding.UTF8.GetBytes(postData);

                        request.ContentType = "application/json";//application/     x-www-form-urlencoded

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
                        string msg = jObjects["Message"].ToString();
                         DateTime TransactionDate = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
                        if (jObjects["Status"].ToString() == "true")
                        {
                           UpdateClaimDetailsVendor(comment, approveStatus, id);
                            SQL_DB.ExecuteNonQuery("update [dbo].[ClaimDetails] set Isapproved='1', PaymentStatus='Success',TransactionDate='" + TransactionDate + "' where Row_id=" + id + "");
                            context.Response.Write(msg);
                        }
                        else
                        {
                            SQL_DB.ExecuteNonQuery("update [dbo].[ClaimDetails] set Isapproved='2', PaymentStatus='Failed',TransactionDate='" + TransactionDate + "' where Row_id=" + id + "");
                            context.Response.Write(msg);
                        }

                    }
                    else
                    {
                        context.Response.Write("Please update upiid");
                    }
                }
                else
                {
                    UpdateClaimDetailsVendor(comment, approveStatus, id, cn);
                    context.Response.Write(approveStatus);
                }
            
            
           
            

            // if (company_name == "Jupiter Aqua Lines Ltd")
            //  {

            //   if (approveStatus == "1")
            // {
            //   ps = ServiceLogic.Paytm_Cash(mb, tpr.ToString(), oid, null, company_name);
            // if (ps.Contains("ACCEPTED"))
            //  {

            //  SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + cn + "','" + mb + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + consumerid + "'," + tpr + ",'Accepted','" + oid + "')");
            //  SQL_DB.ExecuteNonQuery("insert into BPointsTransaction([Transsctionid],[TotalPoints],[RedeemPoints],[Redeemdate],[RedeemBy],Incash,bpstatus) values(1," + tpr + "," + tpr + ",'" + System.DateTime.Now.ToString("yyyy-MM-dd") + "','" + consumerid + "'," + tpr + ",'Accepted')");
            // }
            // else
            // {
            //  SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + cn + "','" + mb + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + consumerid + "'," + tpr + ",'FAILURE','" + oid + "')");

            // }
            // }
            // }

        }
        else if (context.Request.QueryString["method"] == "updateclaimVendorMidas")
        {

            string comment = HttpContext.Current.Request.Form["comment"];//context.Request.QueryString["email"].ToString();
            string UPIID = HttpContext.Current.Request.Form["UPIID"];
            string approveStatus = HttpContext.Current.Request.Form["approveStatus"];
            string mb = HttpContext.Current.Request.Form["mobileno"];
            string TransactionID = HttpContext.Current.Request.Form["TransactionID"];
            string TransactionDate = HttpContext.Current.Request.Form["TransactionDate"];
            string PaymentRemarks = HttpContext.Current.Request.Form["PaymentRemarks"];
            int Balance = Convert.ToInt32(HttpContext.Current.Request.Form["Balance"]);
            string company = HttpContext.Current.Request.Form["company"];
            string company_name = SQL_DB.ExecuteScalar("select comp_name from comp_reg where comp_id='" + company + "'").ToString();
            //string oid = SQL_DB.ExecuteScalar("select (ISNULL(max(orderid),1000))+1 as orderid from [dbo].[paytmtransaction]").ToString();
            string consumerid = SQL_DB.ExecuteScalar("select m_consumerid from m_consumer  where MobileNo='" + mb + "'").ToString();
            string ps = string.Empty;
            //UpdateClaimDetailsVendor(comment, approveStatus, UPIID);
            if (company_name == "MIDAS TOUCH METALLOYS PRIVATE LIMITED" && Balance >= 1)
            {

                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("USP_InsertintoClaimDetails_Midas", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@companyid", company);
                cmd.Parameters.AddWithValue("@mobileno", mb);
                cmd.Parameters.AddWithValue("@balance", Balance);
                cmd.Parameters.AddWithValue("@paymentstatus", approveStatus);
                cmd.Parameters.AddWithValue("@UPIID", UPIID);
                cmd.Parameters.AddWithValue("@transactionid", TransactionID);
                cmd.Parameters.AddWithValue("@transactiondate", TransactionDate);
                cmd.Parameters.AddWithValue("@remarks", PaymentRemarks);
                int k = cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        else if (context.Request.QueryString["method"] == "sendquery")
        {
            string name = context.Request.QueryString["name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string comment = context.Request.QueryString["comment"].ToString();
            string cmobile = context.Request.QueryString["cmobile"].ToString();
            string result = sendquery(name, email, comment, cmobile);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "sendqueryMarketingCompaging")
        {
            string name = context.Request.QueryString["name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string comment = context.Request.QueryString["comment"].ToString();
            string cmobile = context.Request.QueryString["cmobile"].ToString();
            string pageName = context.Request.QueryString["pageName"].ToString();
            string result = sendqueryMarketingCompaging(name, email, comment, cmobile, pageName);
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "sendqueryVendor")
        {
            string name = context.Request.QueryString["name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string comment = context.Request.QueryString["comment"].ToString();
            string cmobile = context.Request.QueryString["cmobile"].ToString();
            string pageName = context.Request.QueryString["pageName"].ToString();
            string result = sendqueryVendor(name, email, comment, cmobile, pageName);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "sendqueryMVC")
        {
            string name = context.Request.QueryString["name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string comment = context.Request.QueryString["comment"].ToString();
            string result = sendqueryMVC(name, email, comment);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "sendqueryMVCNews")
        {
            string email = context.Request.QueryString["email"].ToString();
            string name = context.Request.QueryString["name"].ToString();
            string result = sendqueryMVCNews(email, name);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "sendqueryMVCRQSemo")
        {
            string name = context.Request.QueryString["name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string companyName = context.Request.QueryString["companyName"].ToString();
            string comment = context.Request.QueryString["comment"].ToString();
            string result = sendqueryMVCRQSemo(name, email, comment, companyName);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "sendqueryMVCRPFAllPage")
        {
            string name = context.Request.QueryString["name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string companyName = context.Request.QueryString["companyName"].ToString();
            string comment = context.Request.QueryString["comment"].ToString();
            string result = sendqueryMVCRPFAllPage(name, email, comment, companyName);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "sendqueryMVCRPF")
        {
            string name = context.Request.QueryString["name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string cmobile = context.Request.QueryString["phone"].ToString();
            string companyName = context.Request.QueryString["companyName"].ToString();
            string comment = context.Request.QueryString["comment"].ToString();
            string result = sendqueryMVCRPF(name, email, comment, companyName, cmobile);
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "sendqueryMVCRPF2")
        {
            string name = context.Request.QueryString["name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string cmobile = context.Request.QueryString["phone"].ToString();
            string companyName = context.Request.QueryString["companyName"].ToString();
            string comment = context.Request.QueryString["comment"].ToString();

            string result = sendqueryMVCRPF2(name, email, comment, companyName, cmobile);
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "sendqueryOpenings")
        {
            string name = context.Request.QueryString["name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string jobType = context.Request.QueryString["jobType"].ToString();
            string cmobile = context.Request.QueryString["cmobile"].ToString();
            //string resumePath = context.Request.QueryString["resumePath"].ToString();
            var path = "";
            var resumePath = "";

            foreach (string key in HttpContext.Current.Request.Files)
            {
                var file = HttpContext.Current.Request.Files[key];
                var fileName = Path.GetFileNameWithoutExtension(file.FileName) + "_" + Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                path = Path.Combine(context.Server.MapPath("~/assets/images/resume"), fileName);
                resumePath = Path.Combine("assets/images/resume/", fileName);
                file.SaveAs(path);
            }
            string result = sendqueryOpenings(name, email, cmobile, resumePath, jobType);
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "sendqueryService")
        {
            string name = context.Request.QueryString["name"].ToString();
            string cmobile = context.Request.QueryString["cmobile"].ToString();
            string pageName = context.Request.QueryString["pageName"].ToString();
            string result = sendqueryService(name, cmobile, pageName);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "sendqueryLandingPageContact")
        {
            string name = context.Request.QueryString["name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string cmobile = context.Request.QueryString["phone"].ToString();
            string companyName = context.Request.QueryString["companyName"].ToString();

            string result = sendqueryLandingPageContact(name, email, cmobile, companyName);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "GetYourFreePass")
        {
            string Name = context.Request.QueryString["Name"].ToString();
            string Email = context.Request.QueryString["Email"].ToString();
            string Mobile = context.Request.QueryString["Mobile"].ToString();
            string Comp = context.Request.QueryString["Comp"].ToString();
            string Visitor = context.Request.QueryString["Visitor"].ToString();
            string Exibitionname = context.Request.QueryString["Exibitionname"].ToString();
            string result = GetYourFreePassNow(Name, Email, Mobile, Comp, Visitor, Exibitionname);
            context.Response.Write(result);
        }



        else if (context.Request.QueryString["method"] == "verifyresetpwd")
        {
            string name = context.Request.QueryString["mlt"].ToString();
            string result = verifyresetpwd(name);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "verifyaccount")
        {
            string name = context.Request.QueryString["key"].ToString();
            string result = verifyaccount(name);
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "deleteaccount")
        {
            string result = deleteaccount();
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "setpassword")
        {
            string password = context.Request.QueryString["pwd"].ToString();
            string value = context.Request.QueryString["value"].ToString();
            string result = setpassword(password, value);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "checkconsumer")
        {
            string type = context.Request.QueryString["type"].ToString();
            string value = context.Request.QueryString["value"].ToString();
            string Utype = context.Request.QueryString["Utype"].ToString();
            string result = checkconsumer(type, value, Utype);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "CatchWebsiteHit")
        {
            //  string type = context.Request.QueryString["type"].ToString();
            // string value = context.Request.QueryString["value"].ToString();
            string result = CatchWebsiteHit();
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "DecryptCode")
        {
            //  string type = context.Request.QueryString["type"].ToString();
            // string value = context.Request.QueryString["value"].ToString();
            string name = context.Request.QueryString["id"].ToString();
            string result = DecryptCode(name);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "CheckReferral")
        {
            string c1 = context.Request.QueryString["c1"].ToString();
            string c2 = context.Request.QueryString["c2"].ToString();
            //string name = context.Request.QueryString["id"].ToString();
            string result = CheckReferral(c1, c2);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "CheckReferralExists")
        {
            string refcode = context.Request.QueryString["refcode"].ToString();
            string Mno = context.Request.QueryString["Mno"].ToString();
            //string name = context.Request.QueryString["id"].ToString();
            string result = CheckReferralExists(refcode, Mno);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "savecompany")
        {
            string result = string.Empty;
            string msgReturn = string.Empty;
            string errMsg = string.Empty;
            string errDMsg = string.Empty;

            //PROC_GetMessageTemplete
            string mobileNumber = context.Request.QueryString["mobile"].ToString();
            string UserType = context.Request.QueryString["UserType"].ToString();
            string MobileNo = mobileNumber;
            if (MobileNo == "")
            {
                result = "Kindly Enter Your Mobile No.";
            }



            if (!isDigits(MobileNo))
            {
                result = "Mobile No. must be numeric only!";
                context.Response.Write(result);
            }
            else
            {
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


                string employeeId = context.Request.QueryString["empId"].ToString();
                string distributorId = context.Request.QueryString["disId"].ToString();
                string cmpCode = context.Request.QueryString["code"].ToString();
                string cmpName = context.Request.QueryString["compName"].ToString();
                string currDateTime = System.DateTime.Now.ToString();
                DataSet dsPID = ProductID(cmpCode.Split('-')[0], cmpCode.Split('-')[1]);
                // DataSet dsEmployee = CheckEmployeeDetails(employeeId, distributorId);
                // DataSet dsDistributor = CheckDistrbutorDetails(employeeId, distributorId);

                DataSet dsDistributor;
                DataSet dsEmployee;
                string ConsumerId = "";

                //DataSet dsRetailer;
                DataTable ds1 = SQL_DB.ExecuteDataTable("SELECT M_Consumerid FROM [M_Consumer] where [MobileNo] = '91" + mobileNumber + "'");
                if (ds1.Rows.Count > 0)
                {
                    ConsumerId = ds1.Rows[0]["M_Consumerid"].ToString();
                }

                if (UserType == "3" && distributorId != "SBUTEAM")
                {
                    dsDistributor = CheckDistrbutorDetailsEmployee(employeeId, distributorId);
                    dsEmployee = CheckEmployeeDetailsEmployee(employeeId, distributorId);
                }
                #region //** New retailer Id Process
                // else if (UserType == "4" && distributorId != "SBUTEAM")
                // {
                // dsEmployee = CheckRetailerDetails(ConsumerId, employeeId, distributorId);
                //  dsDistributor = CheckRetailerDealerCodeDetails(ConsumerId, employeeId, distributorId);
                //  }
                #endregion
                #region //** SBU Distributor ID Added by BIpin
                else if (UserType == "5")
                {
                    dsEmployee = CheckEmployeeDetailsSBU(employeeId, distributorId, MobileNo);
                    dsDistributor = CheckDistrbutorDetailsSBU(employeeId, distributorId, MobileNo);
                }
                #endregion

                else
                {
                    dsEmployee = CheckEmployeeDetails(employeeId, distributorId);
                    dsDistributor = CheckDistrbutorDetails(employeeId, distributorId);
                }



                if (dsEmployee.Tables[0].Rows.Count == 0)
                {
                    errMsg = "Please provide a valid Dealer Technician ID / Techmaster ID/SBU as given ID " + employeeId + " is wrong.";
                }

                if (dsDistributor.Tables[0].Rows.Count == 0)
                {
                    errDMsg = "Please provide a valid Dealer Code as given code " + distributorId + " is wrong.";
                }

                if (dsEmployee.Tables[0].Rows.Count > 0 && dsDistributor.Tables[0].Rows.Count > 0)
                {
                    int rdmNumber = RandomNumber(1000, 9999);

                    string otpMsg = "Your Employee verification OTP is " + rdmNumber + " www.vcqru.com md5b2lDaeHj";
                    //string  otpMsg = "%3C%23%3E OTP is " + rdmNumber + " for "+dsPID.Tables[0].Rows[0]["Pro_name"].ToString()+" at vcqru. Valid till "+DateTime.Now.AddMinutes(3).ToShortTimeString()+" "+ConfigurationManager.AppSettings["hashvalue"];
                    //string sendSMSurl = "http://sms.alfasms.in/sendSMS?username=alfasms&message=" + otpMsg + "&sendername=Alfast&smstype=TRANS&numbers=" + mobileNumber + "&apikey=d13cfc39-dae1-4462-8b46-5a2ab78ca5c1";
                    //Your password  is " + dt.Rows[0]["Password"].ToString() + " VCQRU.com
                    //SendSmsWithAlfa(otpMsg, mobileNumber);
                    HttpContext.Current.Session["otpSendTimes"] = 1;
                    ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");

                    // Get Compid for All Condition in Multivendor
                    DataSet dscomp = ServiceLogic.GetServicesAssign_Product(cmpCode.Split('-')[0], cmpCode.Split('-')[1]);
                    string compnyid = "";
                    string Pro_ID = "";
                    if (dscomp.Tables.Count > 0)
                    {
                        if (dscomp.Tables[0].Rows.Count > 0)
                        {
                            compnyid = dscomp.Tables[0].Rows[0]["Comp_ID"].ToString();
                            Pro_ID = dscomp.Tables[0].Rows[0]["Pro_ID"].ToString();
                        }
                    }
                    // Get Compid for All Condition in Multivendor

                    DataSet ds = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] where [MobileNo] = '91" + mobileNumber + "'");
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        SQL_DB.ExecuteNonQuery("Update M_Consumer set employeeID='" + employeeId + "', distributorID='" + distributorId + "' where MobileNo='91" + mobileNumber + "'");
                    }
                    else
                    {
                        int psw = RandomNumber(1000, 9999);
                        User_Details Log = new User_Details();
                        Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));

                        // Log.Email = "";
                        // email.Trim().Replace("'", "''"); //this is comment is done by shweta

                        Log.MobileNo = "91" + mobileNumber;
                        Log.Comp_id = compnyid;              /// Added by BIpin for SBU  and Multivendor
                        Log.PinCode = null;
                        Log.Password = psw.ToString();
                        Log.IsActive = 0;
                        Log.IsDelete = 0;
                        Log.MMEmployeID = employeeId;
                        Log.MMDistributorID = distributorId;
                        Log.DML = "I";

                        User_Details.InsertUpdateUserDetails(Log);
                    }


                    if (dsPID.Tables[0].Rows.Count > 0)
                    {
                        SaveCompanyDetails(cmpName, dsPID.Tables[0].Rows[0]["Pro_ID"].ToString(), currDateTime, employeeId, distributorId, cmpCode, rdmNumber, mobileNumber);
                    }

                    msgReturn = "success";
                }
                else
                {
                    if (dsEmployee.Tables[0].Rows.Count == 0 && dsDistributor.Tables[0].Rows.Count == 0)
                        msgReturn = errMsg + "<br/>" + errDMsg;
                    else
                        msgReturn = "Failure~" + (!string.IsNullOrEmpty(errMsg) ? errMsg : errDMsg);
                }

                context.Response.Write(msgReturn);
            }
        }
        else if (context.Request.QueryString["method"] == "savecoats")
        {
            string result = string.Empty;
            string msgReturn = string.Empty;
            string errMsg = string.Empty;
            string errDMsg = string.Empty;

            //PROC_GetMessageTemplete
            string mobileNumber = context.Request.QueryString["mobile"].ToString();
            string MobileNo = mobileNumber;
            if (MobileNo == "")
            {
                result = "Kindly Enter Your Mobile No.";
            }



            if (!isDigits(MobileNo))
            {
                result = "Mobile No. must be numeric only!";
                context.Response.Write(result);
            }
            else
            {
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
                if (result == string.Empty)
                {

                    string name = context.Request.QueryString["name"].ToString();
                    string cmpCode = context.Request.QueryString["code"].ToString();
                    string cmpName = context.Request.QueryString["compName"].ToString();
                    string currDateTime = System.DateTime.Now.ToString();
                    DataSet dsPID = ProductID(cmpCode.Split('-')[0], cmpCode.Split('-')[1]);
                    //DataSet dsEmployee = CheckEmployeeDetails(employeeId, distributorId);
                    //DataSet dsDistributor = CheckDistrbutorDetails(employeeId, distributorId);

                    //if (dsEmployee.Tables[0].Rows.Count == 0)
                    //{
                    //    errMsg = "Please provide a valid Dealer Technician ID / Techmaster ID as given ID " + employeeId + " is wrong.";
                    //}

                    //if (dsDistributor.Tables[0].Rows.Count == 0)
                    //{
                    //    errDMsg = "Please provide a valid Dealer Code as given code " + distributorId + " is wrong.";
                    //}

                    //if (dsEmployee.Tables[0].Rows.Count > 0 && dsDistributor.Tables[0].Rows.Count > 0)
                    //{
                    int rdmNumber = RandomNumber(1000, 9999);

                    string otpMsg = "Your Employee verification OTP is " + rdmNumber + " www.vcqru.com md5b2lDaeHj";
                    //string  otpMsg = "%3C%23%3E OTP is " + rdmNumber + " for "+dsPID.Tables[0].Rows[0]["Pro_name"].ToString()+" at vcqru. Valid till "+DateTime.Now.AddMinutes(3).ToShortTimeString()+" "+ConfigurationManager.AppSettings["hashvalue"];
                    //string sendSMSurl = "http://sms.alfasms.in/sendSMS?username=alfasms&message=" + otpMsg + "&sendername=Alfast&smstype=TRANS&numbers=" + mobileNumber + "&apikey=d13cfc39-dae1-4462-8b46-5a2ab78ca5c1";
                    //Your password  is " + dt.Rows[0]["Password"].ToString() + " VCQRU.com
                    //SendSmsWithAlfa(otpMsg, mobileNumber);
                    HttpContext.Current.Session["otpSendTimes"] = 1;
                    ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");

                    DataSet ds = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] where [MobileNo] = '91" + mobileNumber + "'");
                    //if (ds.Tables[0].Rows.Count > 0)
                    //{
                    //    SQL_DB.ExecuteNonQuery("Update M_Consumer set employeeID='" + employeeId + "', distributorID='" + distributorId + "' where MobileNo='91" + mobileNumber + "'");
                    //}
                    //else
                    //{
                    int psw = RandomNumber(1000, 9999);
                    User_Details Log = new User_Details();
                    Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));

                    // Log.Email = "";
                    // email.Trim().Replace("'", "''"); //this is comment is done by shweta

                    Log.MobileNo = "91" + mobileNumber;

                    Log.PinCode = null;
                    Log.Password = psw.ToString();
                    Log.IsActive = 0;
                    Log.IsDelete = 0;
                    Log.ConsumerName = name;
                    Log.DML = "I";

                    User_Details.InsertUpdateUserDetails(Log);
                    // }


                    if (dsPID.Tables[0].Rows.Count > 0)
                    {
                        SaveCompanyDetails(cmpName, dsPID.Tables[0].Rows[0]["Pro_ID"].ToString(), currDateTime, "", "", cmpCode, rdmNumber, mobileNumber);
                    }

                    msgReturn = "success";
                }
                else
                {

                    msgReturn = "Failure~" + result;
                }

                context.Response.Write(msgReturn);
            }
        }
        /////////////////////patanjali///////////////////////
        ///
        else if (context.Request.QueryString["method"] == "savepatanjali")
        {
            string result = string.Empty;
            string msgReturn = string.Empty;
            string errMsg = string.Empty;
            string errDMsg = string.Empty;

            //PROC_GetMessageTemplete
            string mobileNumber = context.Request.QueryString["mobile"].ToString();
            string MobileNo = mobileNumber;
            if (MobileNo == "")
            {
                result = "Kindly Enter Your Mobile No.";
            }



            if (!isDigits(MobileNo))
            {
                result = "Mobile No. must be numeric only!";
                context.Response.Write(result);
            }
            else
            {
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
                if (result == string.Empty)
                {

                    string comment = context.Request.QueryString["comment"].ToString();
                    string cmpCode = context.Request.QueryString["code"].ToString();
                    string cmpName = context.Request.QueryString["compName"].ToString();
                    string currDateTime = System.DateTime.Now.ToString();
                    DataSet dsPID = ProductID(cmpCode.Split('-')[0], cmpCode.Split('-')[1]);
                    //DataSet dsEmployee = CheckEmployeeDetails(employeeId, distributorId);
                    //DataSet dsDistributor = CheckDistrbutorDetails(employeeId, distributorId);

                    //if (dsEmployee.Tables[0].Rows.Count == 0)
                    //{
                    //    errMsg = "Please provide a valid Dealer Technician ID / Techmaster ID as given ID " + employeeId + " is wrong.";
                    //}

                    //if (dsDistributor.Tables[0].Rows.Count == 0)
                    //{
                    //    errDMsg = "Please provide a valid Dealer Code as given code " + distributorId + " is wrong.";
                    //}

                    //if (dsEmployee.Tables[0].Rows.Count > 0 && dsDistributor.Tables[0].Rows.Count > 0)
                    //{
                    int rdmNumber = RandomNumber(1000, 9999);

                    string otpMsg = "Your Employee verification OTP is " + rdmNumber + " www.vcqru.com md5b2lDaeHj";
                    //string  otpMsg = "%3C%23%3E OTP is " + rdmNumber + " for "+dsPID.Tables[0].Rows[0]["Pro_name"].ToString()+" at vcqru. Valid till "+DateTime.Now.AddMinutes(3).ToShortTimeString()+" "+ConfigurationManager.AppSettings["hashvalue"];
                    //string sendSMSurl = "http://sms.alfasms.in/sendSMS?username=alfasms&message=" + otpMsg + "&sendername=Alfast&smstype=TRANS&numbers=" + mobileNumber + "&apikey=d13cfc39-dae1-4462-8b46-5a2ab78ca5c1";
                    //Your password  is " + dt.Rows[0]["Password"].ToString() + " VCQRU.com
                    //SendSmsWithAlfa(otpMsg, mobileNumber);
                    HttpContext.Current.Session["otpSendTimes"] = 1;
                    ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");

                    DataSet ds = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] where [MobileNo] = '91" + mobileNumber + "'");
                    //if (ds.Tables[0].Rows.Count > 0)
                    //{
                    //    SQL_DB.ExecuteNonQuery("Update M_Consumer set employeeID='" + employeeId + "', distributorID='" + distributorId + "' where MobileNo='91" + mobileNumber + "'");
                    //}
                    //else
                    //{
                    int psw = RandomNumber(1000, 9999);
                    User_Details Log = new User_Details();
                    Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));

                    // Log.Email = "";
                    // email.Trim().Replace("'", "''"); //this is comment is done by shweta

                    Log.MobileNo = "91" + mobileNumber;

                    Log.PinCode = null;
                    Log.Password = psw.ToString();
                    Log.IsActive = 0;
                    Log.IsDelete = 0;
                    // Log.ConsumerName = name;
                    Log.DML = "I";

                    User_Details.InsertUpdateUserDetails(Log);
                    // }


                    if (dsPID.Tables[0].Rows.Count > 0)
                    {
                        SaveCompanyDetails(cmpName, dsPID.Tables[0].Rows[0]["Pro_ID"].ToString(), currDateTime, "", "", cmpCode, rdmNumber, mobileNumber);
                    }

                    msgReturn = "success";
                }
                else
                {

                    msgReturn = "Failure~" + result;
                }

                context.Response.Write(msgReturn);
            }
        }






        ////////////////////endpatanjali////////////////////
        else if (context.Request.QueryString["method"] == "savedecore")
        {


            string result = string.Empty;
            string msgReturn = string.Empty;
            string errMsg = string.Empty;
            string errDMsg = string.Empty;
            string dealermobile = string.Empty;
            string dealerid = string.Empty;
            string cmpCode = context.Request.QueryString["code"].ToString();
            //PROC_GetMessageTemplete
            string mobileNumber = context.Request.QueryString["mobile"].ToString();

            string cmpName = context.Request.QueryString["compName"].ToString();
            if (context.Request.QueryString["dealermobile"] != null)
                dealermobile = context.Request.QueryString["dealermobile"].ToString();
            if (context.Request.QueryString["dealerid"] != null)
                dealerid = context.Request.QueryString["dealerid"].ToString();
            string MobileNo = mobileNumber;
            DataSet dsPID = ProductID(cmpCode.Split('-')[0], cmpCode.Split('-')[1]);
            if (cmpName == "JOHNSON PAINTS CO.")
            {
                if (dealermobile == "")
                {
                    result = "Kindly Enter Dealer Mobile No.";
                }

                if (!isDigits(dealermobile))
                {
                    result = "Dealer Mobile No. must be numeric only!";
                    //context.Response.Write(result);
                }
                else
                {
                    if (dealermobile.Length < 10)
                    {
                        result = "Dealer Mobile No. must be 10 digits!";
                    }
                    if (dealermobile.Length == 11)
                    {
                        int initial = Convert.ToInt32(dealermobile.Substring(0, 1));
                        if (initial == 0)
                            dealermobile = "91" + dealermobile.Substring(1, dealermobile.Length - 1);
                        else
                        {
                            result = "dealer Mobile No. Wrong!";
                        }
                    }
                    if (dealermobile.Length == 13)
                    {
                        int initial = Convert.ToInt32(dealermobile.Substring(0, 1));
                        if (initial == 0)
                            dealermobile = dealermobile.Substring(1, dealermobile.Length - 1);
                        else
                        {
                            result = "dealer Mobile No. Wrong!";
                        }
                    }
                    if (dealermobile.Length == 12)
                    {
                        int initial = Convert.ToInt32(dealermobile.Substring(0, 2));
                        if (initial == 91)
                            dealermobile = dealermobile.Substring(2, dealermobile.Length - 2);
                    }
                    if (dealermobile.Length == 10)
                        dealermobile = "91" + dealermobile;
                    if (cmpName == "JOHNSON PAINTS CO.")
                    {
                        DataTable dtconsumer = SQL_DB.ExecuteDataTable("select mobileno, isnull(distributorID,0) distributorID from m_consumer where mobileno='91" + dealermobile.Substring(dealermobile.Length - 10, 10) + "'");
                        DataTable dtdealer = SQL_DB.ExecuteDataTable("select DealerCode,D_Status from m_dealermaster where DealerCode='" + dealerid + "'");
                        if (dtconsumer.Rows.Count != 0)
                        {

                            if (!Regex.IsMatch(dealerid, @"^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$"))
                            {
                                result = "Invalid Dealer Id.";
                            }
                            else
                                                       if (dtconsumer.Rows[0]["distributorID"].ToString().ToUpper() != dealerid.ToUpper() && dtconsumer.Rows[0]["distributorID"].ToString() != "0")
                            {
                                result = "Dealer Id not Matched with mobile no.";
                            }
                            else if (dtdealer.Rows.Count == 0)
                            {
                                result = "Dealer Id does not exist";
                            }

                        }
                        else
                        {
                            //Added by Bipin for jpc 20231201
                            DataTable dtchkuser = SQL_DB.ExecuteDataTable("select *from dealership_details where [dealer code]='" + dealerid + "' and MOBILENO='" + dealermobile.Substring(dealermobile.Length - 10, 10) + "'");
                            if (dtchkuser.Rows.Count > 0)
                            {

                            }
                            else
                            {
                                result = "Mobile Number Not Mapped With Dealer";
                                msgReturn = "Failure~" + result;
                                context.Response.Write(msgReturn);
                                return;
                            }
                            //End Added by Bipin for jpc 20231201

                            if (dtdealer.Rows.Count == 0)
                            {
                                result = "Dealer Id does not exist";
                            }
                            else if (dtdealer.Rows[0]["D_Status"].ToString() == "1")
                            {
                                result = "This dealerId already Taken";
                            }
                        }

                    }
                }

            }
            if (MobileNo == "")
            {
                result = result + Environment.NewLine + "Kindly Enter Your Mobile No.";

            }

            if (!isDigits(MobileNo))
            {
                result = result + Environment.NewLine + "Mobile No. must be numeric only!";
                //context.Response.Write(result);
            }
            else
            {
                if (MobileNo.Length < 10)
                {
                    result = result + Environment.NewLine + "Mobile No. must be 10 digits!";
                }
                if (MobileNo.Length == 11)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = result + Environment.NewLine + "Mobile No. Wrong!";
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
                        result = result + Environment.NewLine + "Mobile No. Wrong!";
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
                if (result == string.Empty)
                {
                    string name = context.Request.QueryString["name"].ToString();
                    //string cmpCode = context.Request.QueryString["code"].ToString();

                    string currDateTime = System.DateTime.Now.ToString();
                    int rdmNumber = RandomNumber(1000, 9999);
                    if (cmpName != "JOHNSON PAINTS CO.")
                    {


                        //       string otpMsg = "%3C%23%3E Your Employee verification OTP is " + rdmNumber + " vcqru.com. md5b2lDaeHj";
                        string otpMsg = "Your Employee verification OTP is " + rdmNumber + " www.vcqru.com md5b2lDaeHj";
                        //string  otpMsg = "%3C%23%3E OTP is " + rdmNumber + " for "+dsPID.Tables[0].Rows[0]["Pro_name"].ToString()+" at vcqru. Valid till "+DateTime.Now.AddMinutes(3).ToShortTimeString()+" "+ConfigurationManager.AppSettings["hashvalue"];
                        //string sendSMSurl = "http://sms.alfasms.in/sendSMS?username=alfasms&message=" + otpMsg + "&sendername=Alfast&smstype=TRANS&numbers=" + mobileNumber + "&apikey=d13cfc39-dae1-4462-8b46-5a2ab78ca5c1";
                        //Your password  is " + dt.Rows[0]["Password"].ToString() + " VCQRU.com
                        //SendSmsWithAlfa(otpMsg, mobileNumber);
                        HttpContext.Current.Session["otpSendTimes"] = 1;
                        ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");
                    }
                    if (cmpName == "JOHNSON PAINTS CO.")
                    {
                        DataSet ds = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] where [MobileNo] = '91" + mobileNumber.Substring(mobileNumber.Length - 10, 10) + "'");
                        DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] where [MobileNo] = '91" + dealermobile.Substring(dealermobile.Length - 10, 10) + "'");
                        if (ds1.Tables[0].Rows.Count == 0)
                        {
                            int psw = RandomNumber(1000, 9999);
                            User_Details Log = new User_Details();
                            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));

                            // Log.Email = "";
                            // email.Trim().Replace("'", "''"); //this is comment is done by shweta

                            Log.MobileNo = "91" + dealermobile.Substring(dealermobile.Length - 10, 10);

                            Log.PinCode = null;
                            Log.Password = psw.ToString();
                            Log.IsActive = 0;
                            Log.IsDelete = 0;
                            //Log.ConsumerName = name;
                            Log.DML = "I";
                            if (dealerid != "")
                            {
                                Log.MMDistributorID = dealerid;
                            }
                            //Log.distributorID = dealerid;
                            User_Details.InsertUpdateUserDetails(Log);
                            SQL_DB.ExecuteDataTable("update m_dealermaster set D_Status='1' where DealerCode='" + dealerid + "'");
                            string msgString = "Your VCQRU_ID: " + dealermobile + " & PWD: " + Log.Password + " Visit https://www.vcqru.com/login.aspx & complete your profile";


                            ServiceLogic.SendSms(msgString, dealermobile);
                        }
                        if (ds.Tables[0].Rows.Count == 0)
                        {
                            int psw = RandomNumber(1000, 9999);
                            User_Details Log = new User_Details();
                            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));

                            // Log.Email = "";
                            // email.Trim().Replace("'", "''"); //this is comment is done by shweta

                            Log.MobileNo = "91" + mobileNumber.Substring(mobileNumber.Length - 10, 10);

                            Log.PinCode = null;
                            Log.Password = psw.ToString();
                            Log.IsActive = 0;
                            Log.IsDelete = 0;
                            // Log.ConsumerName = name;
                            Log.DML = "I";

                            User_Details.InsertUpdateUserDetails(Log);
                            // string  msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ".Visit www.vcqru.com for more info OR for any query contact customer care 7669017720. Thanks VCQRU";
                            string msgString = "Your VCQRU_ID: " + MobileNo + " & PWD: " + Log.Password + " Visit https://www.vcqru.com/login.aspx & complete your profile";
                            ServiceLogic.SendSms(msgString, mobileNumber);

                        }
                    }

                    if (dsPID.Tables[0].Rows.Count > 0)
                    {
                        if (cmpName == "JOHNSON PAINTS CO.")
                        {
                            msgReturn = "success~" + chkgenuenity(cmpCode.ToString().Split('-')[0], cmpCode.ToString().Split('-')[1], "91" + mobileNumber.Substring(mobileNumber.Length - 10, 10), "", "", null, "", "", name, dealerid, "", "91" + dealermobile.Substring(dealermobile.Length - 10, 10));

                        }
                        else
                        {
                            SaveCompanyDetails(cmpName, dsPID.Tables[0].Rows[0]["Pro_ID"].ToString(), currDateTime, "", "", cmpCode, rdmNumber, mobileNumber);
                            msgReturn = "success";
                        }
                    }



                }
                else
                {
                    if (cmpName == "JOHNSON PAINTS CO.")
                    {
                        Object9420 Reg = new Object9420();
                        Reg.Received_Code1 = cmpCode.Split('-')[0];
                        Reg.Received_Code2 = cmpCode.Split('-')[1];
                        Reg.Mobile_No = "91" + mobileNumber.Substring(mobileNumber.Length - 10, 10);
                        //Reg.Enq_Date = DateTime.Now.ToLongTimeString();
                        Reg.Is_Success = 0;

                        if (HttpContext.Current.Session["mode"] != null)
                        {
                            if (HttpContext.Current.Session["mode"].ToString() == "Barcode")
                            {
                                Reg.Dial_Mode = "QR code";
                            }
                            else
                            {
                                Reg.Dial_Mode = "WebSite";
                            }
                        }
                        else
                        {
                            Reg.Dial_Mode = "WebSite";
                        }
                        Reg.Mode_Detail = GetIP();


                        Reg.Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff"));
                        Reg.callerdate = DateTime.Now;
                        Reg.callertime = DateTime.Now.ToString("hh:mm:ss");
                        //Location location = locationdetails();

                        //Reg.callercircle = location.region_name;
                        //Reg.City = location.city_name;
                        if (dealerid != "")
                        {
                            Reg.dealerid = dealerid;
                        }
                        Reg.dealer_mobile = "91" + dealermobile.Substring(dealermobile.Length - 10, 10);
                        Business9420.function9420.InsertCodeChecked(Reg);
                    }
                    msgReturn = "Failure~" + result;
                }
                context.Response.Write(msgReturn);



            }
        }

        //Added by Deep Shukla for Patanjali

        else if (context.Request.QueryString["method"] == "chkwarrantypatanjali")
        {
            string code1 = context.Request.QueryString["codeone"];//context.Request.QueryString["email"].ToString();
            string code2 = context.Request.QueryString["codetwo"];
            string MobileNo = context.Request.QueryString["mobile"];

            if (MobileNo.Length == 10)
                MobileNo = "91" + MobileNo;
            string Comp_ID = context.Request.QueryString["Comp_ID"];
            string result = checkWarranty(code1, code2, Comp_ID);




            HttpContext.Current.Session["lat"] = null;
            HttpContext.Current.Session["long"] = null;


            if (!string.IsNullOrEmpty(context.Request.QueryString["lat"]))
                HttpContext.Current.Session["lat"] = context.Request.QueryString["lat"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["long"]))
                HttpContext.Current.Session["long"] = context.Request.QueryString["long"].ToString();

            string dtcountcodecheck = SQL_DB.ExecuteScalar("select count('x') from Pro_Enq where Received_Code1='" + code1 + "' and Received_Code2='" + code2 + "' and Is_Success=1").ToString();
            if (Convert.ToInt32(dtcountcodecheck) <= 5)
            {
                result = result + "&" + "True";
                DataSet ds = ServiceLogic.GetAssignedArtImages(code1, code2, Comp_ID);
                //Track and Trace

                if (ds.Tables[0].Rows.Count > 0)
                {
                    result = result + "&" + ds.Tables[0].Rows[0]["ImagePath"].ToString() + "-" + ds.Tables[0].Rows[0]["IsCorrect"].ToString() + "&" + ds.Tables[0].Rows[1]["ImagePath"].ToString() + "-" + ds.Tables[0].Rows[1]["IsCorrect"].ToString() + "&" + ds.Tables[0].Rows[2]["ImagePath"].ToString() + "-" + ds.Tables[0].Rows[2]["IsCorrect"].ToString() + "&" + ds.Tables[0].Rows[3]["ImagePath"].ToString() + "-" + ds.Tables[0].Rows[3]["IsCorrect"].ToString() + "&" + ds.Tables[0].Rows[4]["ImagePath"].ToString() + "-" + ds.Tables[0].Rows[4]["IsCorrect"].ToString() + "&" + ds.Tables[0].Rows[5]["ImagePath"].ToString() + "-" + ds.Tables[0].Rows[5]["IsCorrect"].ToString();
                }
                else
                {


                    SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                    "[Is_Success],[callerdate],[callertime],Image,IsVerified,Mode_Detail) VALUES('WebSite',getdate()," +
                    "'" + MobileNo + "','" + code1 + "','" + code2 + "','','',0,cast(getdate() as date),Convert(Time, GetDate()),'',0,'" + GetIP() + "')");


                    result = result + "&" + "False";
                }


            }
            else
            {


                SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                "[Is_Success],[callerdate],[callertime],Image,IsVerified) VALUES('WebSite',getdate()," +
                "'" + MobileNo + "','" + code1 + "','" + code2 + "','','',0,cast(getdate() as date),Convert(Time, GetDate()),'',0)");


                result = result + "&" + "False";
            }

            HttpContext.Current.Session["Code1"] = null;
            HttpContext.Current.Session["Code2"] = null;
            HttpContext.Current.Session["Code1"] = code1;
            HttpContext.Current.Session["Code2"] = code2;

            context.Response.Write(result);
        }

        //End of Patanjali


        //Added by Bipin for blackbook
        else if (context.Request.QueryString["method"] == "chkwarrantypatanjali1")
        {
            string code1 = context.Request.QueryString["codeone"];
            string code2 = context.Request.QueryString["codetwo"];
            string result = checkWarranty(code1, code2);


            chkgenuenity(code1, code2, "1111111111", "", "", "", "", "", "");

            HttpContext.Current.Session["lat"] = null;
            HttpContext.Current.Session["long"] = null;


            if (!string.IsNullOrEmpty(context.Request.QueryString["lat"]))
                HttpContext.Current.Session["lat"] = context.Request.QueryString["lat"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["long"]))
                HttpContext.Current.Session["long"] = context.Request.QueryString["long"].ToString();

            string dtcountcodecheck = SQL_DB.ExecuteScalar("select count('x') from Pro_Enq where Received_Code1='" + code1 + "' and Received_Code2='" + code2 + "'").ToString();
            if (Convert.ToInt32(dtcountcodecheck) <= 21)
            {
                result = result + "&" + "True";
            }
            else
            {
                result = result + "&" + "False";
            }
            HttpContext.Current.Session["Code1"] = null;
            HttpContext.Current.Session["Code2"] = null;
            HttpContext.Current.Session["Code1"] = code1;
            HttpContext.Current.Session["Code2"] = code2;
            context.Response.Write(result);
        }

        //End of blackbook

        //SBU DIstributor
        else if (context.Request.QueryString["method"] == "CHKSBUDATA")
        {
            string result = string.Empty;
            string mobile = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["mobile"]))
                mobile = context.Request.QueryString["mobile"].ToString();
            if (mobile.Length == 10)
                mobile = "91" + mobile;
            string qry = "select employeeID,distributorID from M_consumer mc inner join M_DealerMaster m on mc.employeeID=m.DealerTechnicianId" +
                " where mc.mobileno='" + mobile + "' and mc.IsDelete=0 and m.DealerType='SBU'";
            DataTable dt = SQL_DB.ExecuteDataTable(qry);
            if (dt.Rows.Count > 0)
            {
                result = "Success" + "~" + dt.Rows[0]["employeeID"].ToString() + "~" + dt.Rows[0]["distributorID"].ToString();

            }
            else
            {
                result = "Faild";
            }

            context.Response.Write(result);
        }
        //SBU DIstributor



        else if (context.Request.QueryString["method"] == "chkgenuenity")
        {
            string codetwo = string.Empty;
            string codeone = context.Request.QueryString["codeone"].ToString();
            string name = string.Empty;
            string city = string.Empty;
            string email = string.Empty;
            string client = string.Empty;
            string compname = string.Empty;
            string PinCode = string.Empty;
            string designation = string.Empty;
            if (context.Request.QueryString["designation"] != null)
                designation = context.Request.QueryString["designation"].ToString();

            if (context.Request.QueryString["PinCode"] != null)
                PinCode = context.Request.QueryString["PinCode"].ToString();


            if (context.Request.QueryString["Client"] != null)
                client = context.Request.QueryString["Client"];


            string State = string.Empty;    //Created by bipin for Inox
            string Role_ID = string.Empty;  //Created by bipin for Inox
            string Other_Role = string.Empty;  //Created by bipin for Inox
            if (context.Request.QueryString["Other_Role"] != null) //created by bipin for Inox
                Other_Role = context.Request.QueryString["Other_Role"];


            if (context.Request.QueryString["State"] != null)
                State = context.Request.QueryString["State"].ToString();

            if (context.Request.QueryString["Role_Id"] != null)
                Role_ID = context.Request.QueryString["Role_Id"].ToString();



            if (context.Request.QueryString["name"] != null)
                name = context.Request.QueryString["name"].ToString();

            if (context.Request.QueryString["comp"] != null)
                compname = context.Request.QueryString["comp"].ToString();


            if (codeone.Length == 13)
            {
                codetwo = codeone.Substring(5, 8);
                codeone = codeone.Substring(0, 5);
            }
            else
            {
                codetwo = context.Request.QueryString["codetwo"].ToString();
            }

            if (context.Request.QueryString["mode"] == "Barcode")
            {
                HttpContext.Current.Session["mode"] = "Barcode";
            }
            string mobile = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["mobile"]))
                mobile = context.Request.QueryString["mobile"].ToString();

            string RefCd = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["RefCd"]))
                RefCd = context.Request.QueryString["RefCd"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["city"]))
                city = context.Request.QueryString["city"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["email"]))
                email = context.Request.QueryString["email"].ToString();
            string result = string.Empty;
            if (mobile.Length != 0)
                mobile = "91" + mobile.Substring(mobile.Length - 10);

            HttpContext.Current.Session["client"] = null;

            if (!string.IsNullOrEmpty(client))
            {
                if (client == "Comp-1466")
                {

                    if (Other_Role == "Contractor")
                    {
                        Role_ID = "1";
                    }
                    else if (Other_Role == "Electrician")
                    {
                        Role_ID = "2";
                    }
                    else if (Other_Role == "Shop")
                    {
                        Role_ID = "3";
                    }
                    else if (Other_Role == "User")
                    {
                        Role_ID = "4";
                    }
                    else
                    {
                        Role_ID = "";
                    }

                }
                try
                {
                    HttpContext.Current.Session["client"] = client;
                    SQL_DB.ExecuteNonQuery("insert into clientTransaction(completeCode,mobileno,username,city,email,comp_id,entrydate) values(" + codeone + codetwo + ",'" + mobile + "','" + name + "','" + city + "','" + email + "','" + client + "','" + DateTime.Now.ToString("yyyy-dd-MM HH:mm:ss.fff") + "')");
                }
                catch (Exception ex)
                {
                    DataProvider.LogManager.ErrorExceptionLog("Location: masterhandler.aspx   " + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "        paramete are : code:" + codeone + codetwo + ", mobile:" + mobile + ", name: " + name + ", city: " + city + ", email: " + email + ",client:" + client);
                }
            }
            if (mobile != "")
                result = chkgenuenity(codeone, codetwo, mobile, email, Role_ID, State, RefCd, city, name, "", designation, "", "", "", "", compname, "", "", "", "", "", "", client, Other_Role, PinCode);

            // string result = chkgenuenity(codeone, codetwo, mobile);
            context.Response.Write(result);
        }


        else if (context.Request.QueryString["method"] == "AllCompany")
        {
            string result = string.Empty;
            string consumer_id = context.Request.QueryString["userid"];
            User_Details Log = new User_Details();
            Log.User_ID = consumer_id;
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            int consumerid = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
            DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("[company_service_All_Comp]", Convert.ToInt32(consumerid));
            var response = new { result = dtTrans.Tables[0] };

            context.Response.Write(JsonConvert.SerializeObject(response, Formatting.Indented));
        }

        else if (context.Request.QueryString["method"] == "AllServices")
        {
            string result = string.Empty;
            string consumer_id = context.Request.QueryString["userid"];
            User_Details Log = new User_Details();
            Log.User_ID = consumer_id;
            //Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.app_GetUserLoginDetails(Log);
            int consumerid = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
            DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("[company_All_service]", Convert.ToInt32(consumerid));
            var response = new { result = dtTrans.Tables[0] };

            context.Response.Write(JsonConvert.SerializeObject(response, Formatting.Indented));
        }

        else if (context.Request.QueryString["method"] == "SaveLocation")
        {

            string result = string.Empty;
            HttpContext.Current.Session["lat"] = null;
            HttpContext.Current.Session["long"] = null;
            if (!string.IsNullOrEmpty(context.Request.QueryString["lat"]))
                HttpContext.Current.Session["lat"] = context.Request.QueryString["lat"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["long"]))
                HttpContext.Current.Session["long"] = context.Request.QueryString["long"].ToString();


            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "savenutra")
        {
            string result = "";

            string comp = string.Empty;

            string mobile = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["mobile"]))
                mobile = context.Request.QueryString["mobile"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["comp"]))
                comp = context.Request.QueryString["comp"].ToString();

            DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email],[ConsumerName],village,district,[state] FROM [M_Consumer] where right([MobileNo],10) = '" + mobile.Substring(mobile.Length - 10) + "'");
            if (dcs.Tables[0].Rows.Count > 0)
            {

                string ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();

                #region Registration
                Random rnd = new Random();
                User_Details Log = new User_Details();
                Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));

                Log.User_ID = ConsumerId;
                // Log.Email = "";
                // email.Trim().Replace("'", "''"); //this is comment is done by shweta
                Log.MobileNo = mobile;

                Log.DML = "U";
                try
                {
                    User_Details.InsertUpdateUserDetails(Log);
                    result = "success~Imformation Saved Successfully.";
                }
                catch (Exception ex)
                {
                    result = "Failure~" + ex.Message;

                }

                #endregion
            }
            else
            {
                result = "User Does not Exist!";

            }
            context.Response.Write(result);

        }
        //else if(context.Request.QueryString["method"] =="saveeverdetails")
        //{
        //    string result = "";
        //    string name = string.Empty;
        //    string village = string.Empty;
        //    string district = string.Empty;
        //    string state = string.Empty;
        //    string comp = string.Empty;

        //    string mobile = string.Empty;
        //    if (!string.IsNullOrEmpty(context.Request.QueryString["mobile"]))
        //        mobile = context.Request.QueryString["mobile"].ToString();
        //    if (!string.IsNullOrEmpty(context.Request.QueryString["comp"]))
        //        comp = context.Request.QueryString["comp"].ToString();
        //    if (!string.IsNullOrEmpty(context.Request.QueryString["village"]))
        //        village = context.Request.QueryString["village"].ToString();
        //    if (!string.IsNullOrEmpty(context.Request.QueryString["district"]))
        //        district = context.Request.QueryString["district"].ToString();
        //    if (!string.IsNullOrEmpty(context.Request.QueryString["state"]))
        //        state = context.Request.QueryString["state"].ToString();
        //    if (!string.IsNullOrEmpty(context.Request.QueryString["comp"]))
        //        comp = context.Request.QueryString["comp"].ToString();
        //    if (!string.IsNullOrEmpty(context.Request.QueryString["name"]))
        //        name = context.Request.QueryString["name"].ToString();

        //    DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email],[ConsumerName],village,district,[state] FROM [M_Consumer] where right([MobileNo],10) = '" + mobile.Substring(mobile.Length - 10) + "'");
        //    if (dcs.Tables[0].Rows.Count > 0)
        //    {

        //        string ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();

        //        #region Registration
        //        Random rnd = new Random();
        //        User_Details Log = new User_Details();
        //        Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
        //        Log.ConsumerName = name;
        //        Log.User_ID = ConsumerId;
        //        // Log.Email = "";
        //        // email.Trim().Replace("'", "''"); //this is comment is done by shweta
        //        Log.MobileNo = mobile;
        //        Log.village = village;
        //        Log.district = district;
        //        Log.state = state;
        //        Log.DML = "U";
        //        try
        //        {
        //            User_Details.InsertUpdateUserDetails(Log);
        //            result= "success~Imformation Saved Successfully.";
        //        }
        //        catch(Exception ex)
        //        {
        //            result= "Failure~" + ex.Message;

        //        }

        //        #endregion
        //    }
        //    else
        //    {
        //        result= "User Does not Exist!";

        //    }
        //    context.Response.Write(result);
        //}
        else if (context.Request.QueryString["method"] == "saveeverdetails")
        {
            string result = "";
            string name = string.Empty;
            string village = string.Empty;
            string district = string.Empty;
            string state = string.Empty;
            string comp = string.Empty;

            string mobile = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["mobile"]))
                mobile = context.Request.QueryString["mobile"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["comp"]))
                comp = context.Request.QueryString["comp"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["village"]))
                village = context.Request.QueryString["village"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["district"]))
                district = context.Request.QueryString["district"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["state"]))
                state = context.Request.QueryString["state"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["comp"]))
                comp = context.Request.QueryString["comp"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["name"]))
                name = context.Request.QueryString["name"].ToString();

            DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email],[ConsumerName],village,district,[state] FROM [M_Consumer] where right([MobileNo],10) = '" + mobile.Substring(mobile.Length - 10) + "'");
            if (dcs.Tables[0].Rows.Count > 0)
            {

                string ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();

                #region Registration
                Random rnd = new Random();
                User_Details Log = new User_Details();
                Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
                Log.ConsumerName = name;
                Log.User_ID = ConsumerId;
                // Log.Email = "";
                // email.Trim().Replace("'", "''"); //this is comment is done by shweta
                Log.MobileNo = mobile;
                Log.village = village;
                Log.district = district;
                Log.state = state;
                Log.DML = "U";
                try
                {
                    User_Details.InsertUpdateUserDetails(Log);
                    result = "success~जीती गई राशि की पुष्टि करने और अधिक रोमांचक पुरस्कार प्राप्त करने के लिए व्हाट्सएप पर उत्पाद पर मौजूद लेबल की फोटो क्लिक कर के भेजें।  <br><a class='btn btn-primary btn-sm' href='https://api.whatsapp.com/send?phone=+917428919991&amp;text=EVERCROP AGRO SCIENCE' title='Show Chat' target='_blank'>click here</a></p> <p>" +

                                        "इनाम की सूचना आपको SMS/व्हाट्सएप/फेसबुक/कॉल/फोन द्वारा की जाएगी<br>" +

        "शर्तें -<br></p>" +

        "<ol type='A' style='font-size:smaller;'><li>अगर आप इनाम जीते हैं तो निम्न चीजों की आवश्यकता होगी।</li><li>खरीदे गए एवरक्रॉप बीज का खाली पैकेट कूपन के साथ।</li><li> मोबाइल नंबर जिस से आप ने SMS किया है।</li><li>हमारे व्हाट्सएप पर एवरक्रॉप बीज के पैकेट के साथ आपकी फोटो।</li><li> खरीदार का आधार कार्ड। </li><li> इनाम कंपनी द्वारा निर्धारित सेंटर से लेना होगा। </li> </ol>";
                }
                catch (Exception ex)
                {
                    result = "Failure~" + ex.Message;

                }

                #endregion
            }
            else
            {
                result = "Failure~User Does not Exist!";

            }
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "CheckIfcCode")
        {
            string IfscCode = context.Request.QueryString["IfcCode"];
            if (IfscCode != null && IfscCode != "")
            {
                DataSet Bnkds = SQL_DB.ExecuteDataSet("select BANK,IFSC,BRANCH,ADDRESS from IFSC where IFSC='" + IfscCode + "'");
                if (Bnkds.Tables[0].Rows.Count > 0)
                {
                    //BankName = Bnkds.Tables[0].Rows[0]["BANK"].ToString();
                    //BranchName = Bnkds.Tables[0].Rows[0]["BRANCH"].ToString();
                    context.Response.Write("1");
                    return;
                }
                else
                {
                    context.Response.Write("0");
                    return;
                }
            }
        }
        //For Event feedback by Bipin
        if (context.Request.QueryString["method"] == "Feedback")
        {
            string result = "";
            string MobileNo = context.Request.QueryString["Mobile"];
            string Name = context.Request.QueryString["Name"];
            string Suggestion = context.Request.QueryString["Suggestion"];
            string Rateing = context.Request.QueryString["Rateing"];
            string ip = context.Request.QueryString["Interactedper"];
            SQL_DB.ExecuteNonQuery("insert into [EventFeedback]([ConsumerName],[MobileNo],[Suggestion],[Rating],[Date],[Interacted Persion]) values('" + Name + "','" + MobileNo + "','" + Suggestion + "','" + Rateing + "',getdate(),'" + ip + "')");
            result = "Success";
            context.Response.Write(result);
        }
        //For Event feedback by Bipin

        else if (context.Request.QueryString["method"] == "verifyotp")
        {
            string result = string.Empty;
            string email = "", gCode = "", otp = "";
            string name = null;
            string village = string.Empty;
            string district = string.Empty;
            string country = string.Empty;
            string state = string.Empty;
            string comp = string.Empty;
            string dealerid = string.Empty;
            string dealermobile = string.Empty;
            string desgnation = string.Empty;

            string bookname = string.Empty;
            string bookShop = string.Empty;
            string ccenter = string.Empty;

            string SellerName = string.Empty;   //13/01/2022
            string Latitude = string.Empty;   //13/01/2022
            string Longitude = string.Empty;   //13/01/2022


            string Other_Role = string.Empty;   //ocikable
            if (context.Request.QueryString["Other_Role"] != null) //ocikable
                Other_Role = context.Request.QueryString["Other_Role"];

            string Address = string.Empty;

            #region //** Input params for Auto Cash Transfer
            string BankName = string.Empty;
            string AccountNumber = string.Empty;
            string IfscCode = string.Empty;
            string AccountHolderName = string.Empty;
            string BranchName = string.Empty;
            string TNC = string.Empty;
            string teslapayoutmode = "";

            string UPI = string.Empty;
            string pancard_number = string.Empty;
            string aadhar_number = "";  //vsc Tej

            string CountryCode = string.Empty;//added by dipak for ram gopal
            if (context.Request.QueryString["UPI"] != null)
                UPI = context.Request.QueryString["UPI"].ToString();
            if (context.Request.QueryString["pancard_number"] != null)
                pancard_number = context.Request.QueryString["pancard_number"].ToString(); //Hanover
            if (context.Request.QueryString["aadhar_number"] != null)
                aadhar_number = context.Request.QueryString["aadhar_number"].ToString(); //vsc

            if (context.Request.QueryString["Latitude"] != null)
                Latitude = context.Request.QueryString["Latitude"].ToString();
            if (context.Request.QueryString["Longitude"] != null)
                Longitude = context.Request.QueryString["Longitude"].ToString();
            //Added by Bipin for patanjali
            string virtualPath1 = "";
            if (context.Request.QueryString["virtualPath1"] != null)
                virtualPath1 = context.Request.QueryString["virtualPath1"].ToString();
            if (context.Request.QueryString["teslapayoutmode"] != null)
                teslapayoutmode = context.Request.QueryString["teslapayoutmode"].ToString(); //tesla

            string IsVerified = "";
            if (context.Request.QueryString["IsVerified"] != null)
                IsVerified = context.Request.QueryString["IsVerified"].ToString();
            //Added by Bipin for patanjali


            //Added by BIpin for Ramgopal 
            string gender = "";
            if (context.Request.QueryString["gender"] != null)
                gender = context.Request.QueryString["gender"].ToString();
            string Age = "";
            if (context.Request.QueryString["Age"] != null)
                Age = context.Request.QueryString["Age"].ToString();

            string Refercode = string.Empty;  //Added by Bipin for Refral
            if (!string.IsNullOrEmpty(context.Request.QueryString["Refercode"]))
                Refercode = context.Request.QueryString["Refercode"].ToString();
            //Added by BIpin for Ramgopal 

            if (context.Request.QueryString["TNC"] != null)
                TNC = context.Request.QueryString["TNC"].ToString();

            string Shopname = "";
            if (context.Request.QueryString["Shopname"] != null)
                Shopname = context.Request.QueryString["Shopname"].ToString();

            if (context.Request.QueryString["AccountNumber"] != null)
                AccountNumber = context.Request.QueryString["AccountNumber"].ToString();

            if (context.Request.QueryString["IfscCode"] != null)
                IfscCode = context.Request.QueryString["IfscCode"].ToString();

            if (context.Request.QueryString["AccountHolderName"] != null)
                AccountHolderName = context.Request.QueryString["AccountHolderName"].ToString();

            if (IfscCode != null && IfscCode != "" && AccountNumber != null && AccountNumber != "")
            {
                AccountNumber = AccountNumber.ToUpper();
                IfscCode = IfscCode.ToUpper();
                AccountHolderName = AccountHolderName.ToUpper();

                DataSet Bnkds = SQL_DB.ExecuteDataSet("select BANK,IFSC,BRANCH,ADDRESS from IFSC where IFSC='" + IfscCode + "'");
                if (Bnkds.Tables[0].Rows.Count > 0)
                {
                    BankName = Bnkds.Tables[0].Rows[0]["BANK"].ToString();
                    BranchName = Bnkds.Tables[0].Rows[0]["BRANCH"].ToString();

                    BankName = BankName.ToUpper();
                    BranchName = BranchName.ToUpper();
                }
                else
                {


                    context.Response.Write("Kindly enter valid IFSC code !.");
                    return;

                }
            }



            #endregion





            #region black book /Gupta
            string Rating = string.Empty;
            string Feedback = string.Empty;

            if (context.Request.QueryString["Rating"] != null) //ocikable
                Rating = context.Request.QueryString["Rating"];

            if (context.Request.QueryString["Feedback"] != null) //ocikable
                Feedback = context.Request.QueryString["Feedback"];

            #endregion



            string city = string.Empty;//added by bipin marmo
            string Comp_ID = string.Empty;//addredby bipin marmo

            if (context.Request.QueryString["Comp_ID"] != null)
                Comp_ID = context.Request.QueryString["Comp_ID"];

            if (!string.IsNullOrEmpty(context.Request.QueryString["city"]))
                city = context.Request.QueryString["city"].ToString();



            if (!string.IsNullOrEmpty(context.Request.QueryString["bookname"]))
                bookname = context.Request.QueryString["bookname"].ToString();

            if (!string.IsNullOrEmpty(context.Request.QueryString["SellerName"]))
                SellerName = context.Request.QueryString["SellerName"].ToString();

            if (!string.IsNullOrEmpty(context.Request.QueryString["bookShop"]))
                bookShop = context.Request.QueryString["bookShop"].ToString();

            if (!string.IsNullOrEmpty(context.Request.QueryString["ccenter"]))
                ccenter = context.Request.QueryString["ccenter"].ToString();

            if (!string.IsNullOrEmpty(context.Request.QueryString["EmailAddrs"]))
                email = context.Request.QueryString["EmailAddrs"].ToString();

            if (!string.IsNullOrEmpty(context.Request.QueryString["designation"]))
                desgnation = context.Request.QueryString["designation"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["dealerid"]))
                dealerid = context.Request.QueryString["dealerid"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["dealermobile"]))
                dealermobile = context.Request.QueryString["dealermobile"].ToString();

            if (!string.IsNullOrEmpty(context.Request.QueryString["village"]))
                village = context.Request.QueryString["village"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["country"]))
                country = context.Request.QueryString["country"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["district"]))
                district = context.Request.QueryString["district"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["state"]))
                state = context.Request.QueryString["state"].ToString();
            if (!string.IsNullOrEmpty(context.Request.QueryString["comp"]))
                comp = context.Request.QueryString["comp"].ToString();

            if (!string.IsNullOrEmpty(context.Request.QueryString["Address"]))
                Address = context.Request.QueryString["Address"].ToString();

            string PinCode = string.Empty;//lubigen

            if (context.Request.QueryString["PinCode"] != null) //ocikable
                PinCode = context.Request.QueryString["PinCode"];

            if (context.Request.QueryString["mode"] == "Barcode")
            {
                HttpContext.Current.Session["mode"] = "Barcode";
            }
            // tej
            //if (comp != "SWARAJ" && comp != "EVERCROP AGRO SCIENCE" && comp != "Veena Polymers" && comp != "Wudchem Industries Private Limited" && comp != "PARAG MILK FOODS" && comp != "Ankerite Health Care Pvt. Ltd" && comp != "Chase2Fit" && comp != "R.S Industries" && comp != "Jupiter Aqua Lines Ltd" && comp != "SHRI BALAJI PUBLICATIONS" && comp != "A TO Z PHARMACEUTICALS" && comp.ToUpper() != "NUTRAVEL HEALTH CARE" && comp.ToUpper() != "AMULYA AYURVEDA" && comp.ToUpper() != "SHRI BALAJI OVERSEAS MUSCLE TECH" && comp.ToUpper() != "BLACK MANGO HERBS" && comp != "Secure Lifesciences" && comp.ToUpper() != "GRIH PRAWESH MARKETING COMPANY" && comp.ToUpper() != "ALSTONE INDUSTRIES PVT. Ltd REYNOBOND" && comp != "" && comp !="Lubigen Pvt Ltd" && comp !="BSC Paints Pvt Ltd" && comp !="SPORTECH SOLUTIONS" && comp !="RAUNAQ PAINT INDUSTRY" && comp != "MANGAL DASS TRADING CO")
            else if (comp == "MAHINDRA AND MAHINDRA LTD")
            {
                if (context.Request.QueryString["verifycode"].ToString() == "1234")
                    otp = context.Request.QueryString["verifycode"].ToString();
                else
                    otp = context.Request.QueryString["verifycode"].ToString();
            }
            if (!string.IsNullOrEmpty(context.Request.QueryString["name"]))
                name = context.Request.QueryString["name"].ToString();
            //added by dipak for ram gopal
            if (!string.IsNullOrEmpty(context.Request.QueryString["CountryCode"]))
                CountryCode = context.Request.QueryString["CountryCode"].ToString();
            string mobile = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["mobile"]))
                mobile = context.Request.QueryString["mobile"].ToString();
            if (CountryCode != string.Empty)
            {
                if (CountryCode.Trim() == "+91")
                {
                    mobile = "91" + mobile;
                }
                else
                {
                    mobile = CountryCode + "-" + mobile;
                }
            }

            string RefCd = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["RefCd"]))
                RefCd = context.Request.QueryString["RefCd"].ToString();

            if (!string.IsNullOrEmpty(context.Request.QueryString["vCode"]))
                gCode = context.Request.QueryString["vCode"].ToString();

            string empId = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["empId"]))
                empId = context.Request.QueryString["empId"].ToString();

            string disId = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["disId"]))
                disId = context.Request.QueryString["disId"].ToString();




            string M_Consumerid = "";

            #region //** Validate Account Number
            if (IfscCode != null && IfscCode != "" && AccountNumber != null && AccountNumber != "")
            {
                string bankconsumer = "";
                DataTable dtcon = SQL_DB.ExecuteDataTable("select [M_Consumerid] FROM [M_Consumer] where right([MobileNo],10) = '" + mobile.Substring(mobile.Length - 10) + "'");
                if (dtcon.Rows.Count > 0)
                {
                    M_Consumerid = dtcon.Rows[0][0].ToString();
                }
                DataTable dtbank = SQL_DB.ExecuteDataTable("select*from M_BankAccount where Account_No='" + AccountNumber + "'");
                if (dtbank.Rows.Count > 0)
                {
                    bankconsumer = dtbank.Rows[0]["M_Consumerid"].ToString();
                    if (M_Consumerid != "" && (bankconsumer == M_Consumerid))
                    {
                        DataTable dtbankre = SQL_DB.ExecuteDataTable("select*from M_BankAccount where Account_No='" + AccountNumber + "' and  M_Consumerid='" + M_Consumerid + "'");
                        if (dtbankre.Rows.Count > 0)
                        {

                        }
                        else
                        {
                            result = "failure~This Account Number Already Used With Another Mobile Number Please Use Correct Account Number";
                            context.Response.Write(result);
                            return;
                        }
                    }
                    else
                    {
                        result = "failure~This Account Number Already Used With Another Mobile Number Please Use Correct Account Number";
                        context.Response.Write(result);
                        return;
                    }
                }
            }
            #endregion
            //if (Comp_ID == "Comp-1548" || comp == "Ambica Kable")
            //{

            //    DataTable dtconConName = SQL_DB.ExecuteDataTable("select [M_Consumerid],ConsumerName,UPIId FROM [M_Consumer] where right([MobileNo],10) = '" + mobile.Substring(mobile.Length - 10) + "'");
            //    if (dtconConName.Rows.Count > 0)
            //    {
            //    if (dtconConName.Rows[0][1].ToString().Length < 2 && name.Length > 2)
            //    {
            //    SQL_DB.ExecuteNonQuery("update M_Consumer set ConsumerName='" + name + "' where right([MobileNo],10) = '\" + mobile.Substring(mobile.Length - 10) + \"'");
            //    }
            //    if (dtconConName.Rows[0][1].ToString().Length > 2 && name.Length < 3)
            //    {

            //    name = dtconConName.Rows[0][1].ToString();
            //    }
            //    if (dtconConName.Rows[0][2].ToString().Length > 5 && UPI.Length < 5)
            //    {

            //    UPI = dtconConName.Rows[0][2].ToString();

            //    }
            //    if (dtconConName.Rows[0][2].ToString().Length < 5 && UPI.Length > 5)
            //    {
            //    SQL_DB.ExecuteNonQuery("update M_Consumer set UPIId='" + UPI + "' where right([MobileNo],10) = '\" + mobile.Substring(mobile.Length - 10) + \"'");

            //    }

            //    }

            //    if (name.ToString().Length < 3 || UPI.ToString().Length < 6)
            //    {
            //    result = "Cashback can't be transferred. Code check successful. Update Your Bank Account name and UPI ID. To update, log in: <a href='https://www.vcqru.com/login.aspx'>Click Here</a>";
            //    context.Response.Write(result);
            //    return;

            //    }
            //}

            //if (Comp_ID == "Comp-1538")
            //{
            //    var path = "";
            //    var virtualPath = "";
            //    foreach (string key in HttpContext.Current.Request.Files)
            //    {
            //        var file = HttpContext.Current.Request.Files[key];
            //        var fileName = Path.GetFileNameWithoutExtension(file.FileName) + "_" + Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
            //        path = Path.Combine(context.Server.MapPath("~/fackProductImg"), fileName);
            //        virtualPath = Path.Combine("/fackProductImg", fileName);
            //        file.SaveAs(path);
            //    }
            //    result = chkgenuenity(gCode.ToString().Split('-')[0], gCode.ToString().Split('-')[1], "91" + mobile.Substring(mobile.Length - 10, 10), email, "", "", RefCd, city, name, dealerid, desgnation, dealermobile, village, district, state, comp, country, bookname, bookShop, ccenter, Address, SellerName, Comp_ID, Other_Role, PinCode, BankName, AccountNumber, IfscCode, AccountHolderName, BranchName, virtualPath);
            //    result = "success~" + result;
            //    context.Response.Write(result);
            //    return;
            //}

            //if (Comp_ID == "Comp-1722") //Tesla
            //{
            //    DataTable dtupichk = SQL_DB.ExecuteDataTable("Exec USP_CheckUPITesla '" + mobile + "','" + UPI + "'");
            //    if (dtupichk.Rows[0][0].ToString() == "UPI Id Already Used")
            //    {
            //        result = "failure~UPI Id Already Used";
            //        context.Response.Write(result);
            //        return;
            //    }
            //}

            //Added by Tej Midas Touch For any mobile number a person will be able to scan 10 codes in a month
            if (Comp_ID == "Comp-1690" && mobile != "")
            {
                //string strQryMid = "select * from Pro_Enq where RIGHT(MobileNo,10) = '" + mobile.Substring(mobile.Length - 10, 10) + "' and Is_Success='1' and Comp_ID='Comp-1690' AND CAST(Enq_Date AS DATE) BETWEEN CAST(DATEADD(MONTH, -1, GETDATE()) AS DATE) AND CAST(GETDATE() AS DATE)";


                //string strQryMid = "SELECT PE.MobileNo FROM Pro_Enq PE JOIN Pro_Reg PR ON PR.Pro_ID = (SELECT Pro_ID FROM m_code WHERE Code1 = '" + gCode.ToString().Split('-')[0] + "' AND Code2 = '" + gCode.ToString().Split('-')[1] + "' ) JOIN Comp_Reg PR2 ON PR2.Comp_ID = 'Comp-1690' WHERE RIGHT(PE.MobileNo,10) = '" + mobile.Substring(mobile.Length - 10, 10) + "'  AND PE.Is_Success = '1'  AND CAST(PE.Enq_Date AS DATE) BETWEEN CAST(DATEADD(MONTH, -1, GETDATE()) AS DATE) AND CAST(GETDATE() AS DATE)";
                string strQryMid = "select PE.Is_Success,PE.MobileNo from Pro_Enq PE, Comp_Reg CR where RIGHT(PE.MobileNo,10) = '" + mobile.Substring(mobile.Length - 10, 10) + "' AND PE.Is_Success = '1' AND cr.Comp_ID='Comp-1690' AND CAST(Enq_Date AS DATE) BETWEEN CAST(DATEADD(MONTH, -1, GETDATE()) AS DATE) AND CAST(GETDATE() AS DATE)";

                DataTable dtchkCountSuccCode = SQL_DB.ExecuteDataTable(strQryMid);
                if (dtchkCountSuccCode.Rows.Count > 9)
                {
                    result = "success~You've reached the maximum scan limit for this month. Please try again next month.";
                    context.Response.Write(result);
                    return;
                }
            }
            //close by Tej

            //Added by Bipin for Upi Check 
            if (Comp_ID == "Comp-1593" && UPI != "")
            {
                DataTable dtchkupi = SQL_DB.ExecuteDataTable("select*from M_consumer where MobileNo ='" + mobile + "'");
                if (dtchkupi.Rows.Count > 0)
                {

                }
                else
                {
                    DataTable dtchkduplicateupi = SQL_DB.ExecuteDataTable("select UPIId from M_consumer where UPIId ='" + UPI + "'");
                    if (dtchkduplicateupi.Rows.Count > 0)
                    {
                        result = "failure~UPI Id Already Used Please Use Diffrent UPI ID. ";
                        context.Response.Write(result);
                        return;
                    }
                }
            }


            //Added by Bipin for Upi Check 
            //Added for Upi Pan Tej 
            if ((Comp_ID == "Comp-1702" || Comp_ID == "Comp-1722") && (UPI != ""))
            {

                DataTable dtchkupi = SQL_DB.ExecuteDataTable("select [mobileno] FROM [M_Consumer] where right([MobileNo],10) <> '" + mobile.Substring(mobile.Length - 10, 10) + "' AND UPIId ='" + UPI + "'");
                if (dtchkupi.Rows.Count > 0)
                {
                    result = "failure~UPI Id Already Used Please Use Diffrent UPI ID. ";
                    context.Response.Write(result);
                    return;
                }

            }
            if ((Comp_ID == "Comp-1702") && (pancard_number != ""))
            {

                DataTable dtchkupi = SQL_DB.ExecuteDataTable("select [mobileno] FROM [M_Consumer] where right([MobileNo],10) <> '" + mobile.Substring(mobile.Length - 10, 10) + "' AND pancard_number ='" + pancard_number + "'");
                if (dtchkupi.Rows.Count > 0)
                {
                    result = "failure~Pancard_number Id Already Used Please Use Diffrent pancard_number. ";
                    context.Response.Write(result);
                    return;
                }

            }
            // tej


            if (Comp_ID == "Comp-1594")
            {
                SQL_DB.ExecuteNonQuery("insert into tbl_blackbookuserdetails(Mobile_no,User_Name,Email,PinCode,City,State,Retailer_name,Book_name,Rating,Feedback) values('" + mobile + "','" + name + "','" + email + "','" + PinCode + "','" + city + "','" + state + "','" + SellerName + "','" + bookname + "' ,'" + Rating + "' ,'" + Feedback + "')");
                string dtcountcodecheck = SQL_DB.ExecuteScalar("select count('x') from Pro_Enq where Received_Code1='" + gCode.ToString().Split('-')[0] + "' and Received_Code2='" + gCode.ToString().Split('-')[1] + "'").ToString();
                if (Convert.ToInt32(dtcountcodecheck) <= 20)
                {
                    result = " ~ Thank you for submitting the feedback form of BlackBook. All the very best for your upcoming exams..";
                    //result = result + "&" + "True";
                }
                else
                {
                    result = " ~ Scanned too many times or Duplicate copy.";
                    //result = result + "&" + "False";
                }
                context.Response.Write(result);
            }


            if (comp.ToUpper() == "GRIH PRAWESH MARKETING COMPANY")
            {
                //DataSet dsOTPVerify = OTPVerify(otp, mobile, empId, disId);


                //if (dsOTPVerify.Tables[0].Rows.Count > 0)
                //{
                result = chkgenuenity(gCode.ToString().Split('-')[0], gCode.ToString().Split('-')[1], "91" + mobile.Substring(mobile.Length - 10, 10), email, RefCd, null, name, dealerid, desgnation, dealermobile, village, district, state, comp, country);
                //result = chkgenuenity(gCode.ToString().Split('-')[0], gCode.ToString().Split('-')[1], mobile, email, RefCd);
                result = "success~" + result;
                //}
                //else
                //{
                //    result = "failure";
                //}
            }
            //tej
            // else if (comp != "SWARAJ" && comp != "EVERCROP AGRO SCIENCE" && comp != "Veena Polymers" && comp != "PARAG MILK FOODS" && comp != "Ankerite Health Care Pvt. Ltd" && comp != "Chase2Fit" && comp != "R.S Industries" && comp != "Jupiter Aqua Lines Ltd" && comp != "SHRI BALAJI PUBLICATIONS" && comp != "A TO Z PHARMACEUTICALS" && comp.ToUpper() != "NUTRAVEL HEALTH CARE" && comp.ToUpper() != "AMULYA AYURVEDA" && comp.ToUpper() != "SHRI BALAJI OVERSEAS MUSCLE TECH" && comp != "Secure Lifesciences" && comp.ToUpper() != "BLACK MANGO HERBS" && comp != "" && comp != "Wudchem Industries Private Limited" && comp !="Lubigen Pvt Ltd" && comp !="BSC Paints Pvt Ltd" && comp !="RAUNAQ PAINT INDUSTRY" && comp !="SPORTECH SOLUTIONS" && comp != "MANGAL DASS TRADING CO")
            else if (comp == "MAHINDRA AND MAHINDRA LTD")
            {
                DataSet dsOTPVerify = OTPVerify(otp, mobile, empId, disId);


                if (dsOTPVerify.Tables[0].Rows.Count > 0)
                {
                    result = chkgenuenity(gCode.ToString().Split('-')[0], gCode.ToString().Split('-')[1], "91" + mobile.Substring(mobile.Length - 10, 10), email, RefCd, null, name, dealerid, desgnation, dealermobile);
                    //result = chkgenuenity(gCode.ToString().Split('-')[0], gCode.ToString().Split('-')[1], mobile, email, RefCd);
                    result = "success~" + result;
                }
                else
                {
                    result = "failure";
                }
            }

            else
            {
                //Added by BIPin for RamGopal
                if (Comp_ID == "Comp-1626")
                {
                    mobile = mobile.Trim();
                }
                else
                {
                    mobile = "91" + mobile.Substring(mobile.Length - 10, 10);
                }
                //Added by BIPin for RamGopal change mobile no

                result = chkgenuenity(gCode.ToString().Split('-')[0], gCode.ToString().Split('-')[1], mobile, email, "", "", RefCd, city, name, dealerid, desgnation, dealermobile, village, district, state, comp, country, bookname, bookShop, ccenter, Address, SellerName, Comp_ID, Other_Role, PinCode, BankName, AccountNumber, IfscCode, AccountHolderName, BranchName, virtualPath1, TNC, UPI, Shopname, gender, Age, Refercode, pancard_number, IsVerified, Latitude, Longitude, aadhar_number, teslapayoutmode);
                //result = chkgenuenity(gCode.ToString().Split('-')[0], gCode.ToString().Split('-')[1], mobile, email, RefCd);
                result = "success~" + result;


            }


            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "resendotp")
        {
            string result = string.Empty;
            string mobile = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["mobile"]))
            {
                mobile = context.Request.QueryString["mobile"].ToString();
                int oTimes = Convert.ToInt16(HttpContext.Current.Session["otpSendTimes"].ToString()) + 1;
                if (oTimes <= otpSendTimes)
                {
                    DataTable dtOTP = SQL_DB.ExecuteDataTable("select top 1 CompanyID from CompanyProduct where MobileNumber='" + mobile + "' order by CompanyID desc");
                    if (dtOTP.Rows.Count > 0)
                    {
                        string CompanyID = dtOTP.Rows[0]["CompanyID"].ToString();
                        int rdmNumber = RandomNumber(1000, 9999);
                        SQL_DB.ExecuteNonQuery("update [dbo].[CompanyProduct] set otp='" + rdmNumber + "', [status]=0 where mobileNumber='" + mobile + "' and CompanyID='" + CompanyID + "'");
                        string otpMsg = "Your Employee verification OTP is " + rdmNumber + " www.vcqru.com md5b2lDaeHj";

                        //string  otpMsg = "%3C%23%3E OTP is " + rdmNumber + " for login at vcqru. Valid till "+DateTime.Now.AddMinutes(3).ToShortTimeString()+" "+ConfigurationManager.AppSettings["hashvalue"];
                        ServiceLogic.SendSMSFromAlfa(mobile, otpMsg, "OTP");
                        HttpContext.Current.Session["otpSendTimes"] = Convert.ToInt16(HttpContext.Current.Session["otpSendTimes"].ToString()) + 1;
                        result = "success";
                    }
                    else
                    {

                        string ExpiryDate = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy-MM-dd hh:mm:ss.ttt")).ToString();
                        int rdmNumber = RandomNumber(1000, 9999);

                        SQL_DB.ExecuteNonQuery("insert into CompanyProduct(otp,status,MobileNumber,expiryDate)values('" + rdmNumber + "','0','" + mobile + "','" + ExpiryDate + "')");

                        string otpMsg = "Your Employee verification OTP is " + rdmNumber + " www.vcqru.com md5b2lDaeHj";

                        //string  otpMsg = "%3C%23%3E OTP is " + rdmNumber + " for login at vcqru. Valid till "+DateTime.Now.AddMinutes(3).ToShortTimeString()+" "+ConfigurationManager.AppSettings["hashvalue"];
                        ServiceLogic.SendSMSFromAlfa(mobile, otpMsg, "OTP");
                        HttpContext.Current.Session["otpSendTimes"] = Convert.ToInt16(HttpContext.Current.Session["otpSendTimes"].ToString()) + 1;
                        result = "success";



                    }

                }
                else
                {
                    result = "exceed";
                }
            }
            else
            { result = "failure"; }

            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "GetClientInfo")
        {
            string MobileNo = string.Empty;
            MobileNo = context.Request.QueryString["mobile"].ToString();
            string ClientName = string.Empty;
            string ClientCity = string.Empty;
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT Top 1 city FROM [clientTransaction] where mobileno = '" + MobileNo.Trim().Replace("'", "''") + "' order by 1 desc");
            if (ds.Tables[0].Rows.Count > 0)
            {
                ClientName = SQL_DB.ExecuteScalar("SELECT Top 1 username FROM [clientTransaction] where mobileno = '" + MobileNo.Trim().Replace("'", "''") + "' order by 1 desc").ToString();
                ClientCity = SQL_DB.ExecuteScalar("SELECT Top 1 city FROM [clientTransaction] where mobileno = '" + MobileNo.Trim().Replace("'", "''") + "' order by 1 desc").ToString();
            }
            context.Response.Write("Name= '" + ClientName + "', City= '" + ClientCity + "'");
        }

        // --------------- Start VR Kable -------------------
        else if (context.Request.QueryString["method"] == "consumerloginVRkabel")
        {
            string userid = context.Request.QueryString["userid"].ToString();
            string pass = context.Request.QueryString["pass"].ToString();
            //string uid = context.Request.QueryString["uid"].ToString();
            //string remember = context.Request.QueryString["rememberme"].ToString();
            string result = consumerloginVRkabel(userid, pass);//Convert.ToInt32(remember)
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "DeleteAccountVRkabel")
        {
            string mobileno = context.Request.QueryString["mobileno"].ToString();
            string mode = "";
            if (context.Request.QueryString["mode"] == "")
                mode = "App_mode";
            else
                mode = context.Request.QueryString["mode"];

            string result = DeleteAccountVRkabel(mobileno, mode);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "DeleteTestCode")
        {
            string code1 = context.Request.QueryString["code1"].ToString();
            string code2 = context.Request.QueryString["code2"].ToString();
            string result = DeleteTestCode(code1, code2);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "DeleteAccountVRkabelWEb")
        {
            string mobileno = context.Request.QueryString["mobileno"].ToString();
            string mode = context.Request.QueryString["mode"].ToString();
            string result = DeleteAccountVRkabel(mobileno, mode);
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "forgotpasswordVrKabel")
        {
            string email = context.Request.QueryString["mobile"].ToString();
            string result = forgotpasswordVrKabel(email);
            context.Response.Write(result);
        }
        //Added by BIpin for RamGopal
        else if (context.Request.QueryString["method"] == "GetCountrylistwithcode")
        {
            DataTable dtcountry = SQL_DB.ExecuteDataTable("select CountryCode ,Country from CountryCodes order by Country asc");
            string result = JsonConvert.SerializeObject(dtcountry);
            context.Response.Write(result);
        }
        //Added by BIpin for RamGopal

        else if (context.Request.QueryString["method"] == "VRConsumerRegister")
        {
            string Name = context.Request.QueryString["Name"].ToString();
            //string email = context.Request.QueryString["email"].ToString();
            string mobile = context.Request.QueryString["mobile"].ToString();
            string pwd = context.Request.QueryString["pwd"].ToString();
            string Role_ID = context.Request.QueryString["rolid"].ToString();
            //string Designation = context.Request.QueryString["designation"].ToString();
            string Cin_number = context.Request.QueryString["cin_number"].ToString();
            // string DOB = context.Request.QueryString["dob"].ToString();
            //  string Gender = context.Request.QueryString["gender"].ToString();
            //string Sur_name = context.Request.QueryString["sur_name"].ToString();
            //string shop_name = context.Request.QueryString["shop_name"].ToString();
            string apistatus = "400";

            //string result = VRConsumerRegister(Name, email, mobile, pwd, Role_ID, Cin_number.ToUpper(), Designation, DOB, Gender, Sur_name, apistatus);
            string result = VRConsumerRegister(Name, mobile, pwd, Role_ID, Cin_number.ToUpper(), apistatus);
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "profileUpdateVR")
        {
            string userid = context.Request.QueryString["userid"].ToString();
            string name = context.Request.QueryString["name"].ToString();
            string email = context.Request.QueryString["email"].ToString();
            string Designation = context.Request.QueryString["designation"].ToString();
            string DOB = context.Request.QueryString["dob"].ToString();
            string Gender = context.Request.QueryString["gender"].ToString();
            string Sur_name = context.Request.QueryString["sur_name"].ToString();
            string result = profileUpdateVR(userid, name, email, Designation, DOB, Gender, Sur_name);
            context.Response.Write(result);
        }


        else if (context.Request.QueryString["method"] == "profileCommunication")
        {
            string userid = context.Request.QueryString["userid"].ToString();
            string pin_code = context.Request.QueryString["pin_code"].ToString();
            string house_number = context.Request.QueryString["house_number"].ToString();
            string land_mark = context.Request.QueryString["land_mark"].ToString();
            string state = context.Request.QueryString["state"].ToString();
            string district = context.Request.QueryString["district"].ToString();
            string city = context.Request.QueryString["city"].ToString();
            string result = profileCommunication(userid, pin_code, house_number, land_mark, state, district, city);
            context.Response.Write(result);
        }
        else if (context.Request.QueryString["method"] == "profileBusiness")
        {
            string userid = context.Request.QueryString["userid"].ToString();
            string owner_number = context.Request.QueryString["owner_number"].ToString();
            string shop_name = context.Request.QueryString["shop_name"].ToString();
            string aadhar_number = context.Request.QueryString["aadhar_number"].ToString();
            string pancard_number = context.Request.QueryString["pancard_number"].ToString();
            string gst_number = context.Request.QueryString["gst_number"].ToString();
            //string city = context.Request.QueryString["city"].ToString();
            string result = profileBusiness(userid, owner_number, shop_name, aadhar_number, pancard_number, gst_number);
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "notificationVR")
        {
            try
            {
                DataTable table = new DataTable();
                table = SQL_DB.ExecuteDataTable("select * from vr_notification");

                if (table.Rows.Count > 0)
                {
                    var response = new { result = table };
                    string json = JsonConvert.SerializeObject(response, Formatting.Indented);
                    context.Response.Write(json);
                }
                else
                {
                    var response = new { result = table };
                    string json = JsonConvert.SerializeObject(response, Formatting.Indented);
                    context.Response.Write(json);
                }
            }
            catch (Exception e)
            {
                throw;
            }

        }


        else if (context.Request.QueryString["method"] == "android_userdetailsVrKabel")
        {
            string consumer_id = context.Request.QueryString["userid"];
            if (consumer_id.Length == 12)
            {
                consumer_id = consumer_id.Substring(consumer_id.Length - 10).ToString();
            }

            string Vrkabel_User_Type = "";
            string userTypeName = "";
            Profile_DetailsVrKabel messageobject = new Profile_DetailsVrKabel();
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] where  right([MobileNo],10) = '" + consumer_id + "'");
            if (ds.Tables[0].Rows.Count > 0)
            {

                //consumer_id=ds.Tables[0].Rows[0]["MobileNo"].ToString();
                Vrkabel_User_Type = ds.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString();

                if (Vrkabel_User_Type == "1")
                {
                    userTypeName = "Dealar";
                }
                else if (Vrkabel_User_Type == "4")
                { // electrician
                    userTypeName = "Electrician";
                }
                else if (Vrkabel_User_Type == "3")
                { // counterboy
                    userTypeName = "Counter Boy";
                }
                else if (Vrkabel_User_Type == "2")
                { // retailer
                    userTypeName = "Retailer";
                }
                else
                {
                    userTypeName = "NA";
                }

                messageobject.name = ds.Tables[0].Rows[0]["ConsumerName"].ToString();
                messageobject.owner_number = ds.Tables[0].Rows[0]["owner_number"].ToString();
                messageobject.user_type = Vrkabel_User_Type;
                messageobject.userTypeName = userTypeName;
                messageobject.cin_number = ds.Tables[0].Rows[0]["cin_number"].ToString();
                messageobject.mobile_number = ds.Tables[0].Rows[0]["MobileNo"].ToString();
                messageobject.pan_card_file = ds.Tables[0].Rows[0]["pan_card_file"].ToString();
                messageobject.shop_name = ds.Tables[0].Rows[0]["shop_name"].ToString();
                messageobject.aadhar_number = ds.Tables[0].Rows[0]["aadharNumber"].ToString();
                messageobject.aadhar_file_front = ds.Tables[0].Rows[0]["aadharFile"].ToString();
                messageobject.aadhar_file_back = ds.Tables[0].Rows[0]["aadharback"].ToString();
                messageobject.sur_name = ds.Tables[0].Rows[0]["sur_name"].ToString();
                messageobject.gender = ds.Tables[0].Rows[0]["gender"].ToString();
                messageobject.dob = ds.Tables[0].Rows[0]["dob"].ToString();
                messageobject.email_id = ds.Tables[0].Rows[0]["Email"].ToString();
                messageobject.house_number = ds.Tables[0].Rows[0]["house_number"].ToString();
                messageobject.land_mark = ds.Tables[0].Rows[0]["village"].ToString();
                messageobject.city = ds.Tables[0].Rows[0]["City"].ToString();
                messageobject.district = ds.Tables[0].Rows[0]["district"].ToString();
                messageobject.state = ds.Tables[0].Rows[0]["state"].ToString();
                messageobject.pin_code = ds.Tables[0].Rows[0]["PinCode"].ToString();
                messageobject.pancard_number = ds.Tables[0].Rows[0]["pancard_number"].ToString();
                messageobject.gst_number = ds.Tables[0].Rows[0]["gst_number"].ToString();
                messageobject.designation = ds.Tables[0].Rows[0]["designation"].ToString();
                messageobject.shop_file = ds.Tables[0].Rows[0]["shop_file"].ToString();
                messageobject.user_id = ds.Tables[0].Rows[0]["User_ID"].ToString();
                messageobject.status = "200";
            }
            else
            {
                messageobject.status = "400";
            }
            string json = JsonConvert.SerializeObject(messageobject, Formatting.Indented);
            //DataProvider.LogManager.ErrorExceptionLog(DateTime.Now.ToLongDateString() + ":line no-2010 Exception at Masterhandler on update_user condition" + Environment.NewLine + " Parameter: " + json);
            context.Response.Write(json);
        }

        else if (context.Request.QueryString["method"] == "dealerloginVRkabel")
        {
            string cinNumber = context.Request.QueryString["cin_number"].ToString();
            string result = dealerloginVRkabel(cinNumber);//Convert.ToInt32(remember)
            context.Response.Write(result);
        }

        else if (context.Request.QueryString["method"] == "CheckUserVr")
        {
            try
            {
                string mobile = context.Request.QueryString["mobileno"].ToString();
                mobile = "91" + mobile.Substring(mobile.Length - 10, 10);
                message_status messageobject = new message_status();

                DataTable table = SQL_DB.ExecuteDataTable("select M_Consumerid,Comp_id,Vrkabel_User_Type from M_Consumer where right([MobileNo],10)='" + mobile.Substring(mobile.Length - 10, 10) + "'");
                if (table.Rows.Count > 0)
                {
                    if (table.Rows[0]["Comp_id"].ToString() != "Comp-1400")
                    {
                        messageobject.status = "2";
                        messageobject.message = "This number is registered for other company!";

                    }
                    else if (table.Rows[0]["Vrkabel_User_Type"].ToString() == "")
                    {

                        messageobject.status = "3";
                        messageobject.message = "User role not updated!";

                    }
                    else
                    {
                        //context.Response.Write("true");
                        messageobject.status = "1";
                        messageobject.message = "success";
                    }
                }
                else
                {
                    //context.Response.Write("false");
                    messageobject.status = "0";
                    messageobject.message = "Record not found!";
                }
                string json = JsonConvert.SerializeObject(messageobject, Formatting.Indented);
                context.Response.Write(json);
            }
            catch (Exception e)
            {
                throw;
            }
        }

        else if (context.Request.QueryString["method"] == "otpsend_1VR")
        {
            //string result = string.Empty;
            string mobileNumber = string.Empty;
            otp_response otp = new otp_response();
            if (!string.IsNullOrEmpty(context.Request.QueryString["mobile"]))
            {
                mobileNumber = context.Request.QueryString["mobile"].ToString();
                HttpContext.Current.Session["otpSendTimes"] = 0;
                DateTime expDate = System.DateTime.Now.AddYears(1);
                if (mobileNumber.Length == 10)
                    mobileNumber = "91" + mobileNumber;
                int rdmNumber = 0;
                int oTimes = Convert.ToInt32(HttpContext.Current.Session["otpSendTimes"].ToString()) + 1;
                if (oTimes <= otpSendTimes)
                {
                    rdmNumber = RandomNumber(1000, 9999);
                    SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[CompanyProduct] ([expiryDate], [otp], [status],[mobileNumber]) values ('" + expDate.ToString("yyyy-MM-dd HH:mm:ss") + "', '" + rdmNumber + "', 0, '" + mobileNumber + "')");
                    // SQL_DB.ExecuteNonQuery("update [dbo].[CompanyProduct] set otp='" + rdmNumber + "', [status]=0 where mobileNumber='" + mobile + "'");
                    //   string otpMsg = "%3C%23%3E Your Employee verification OTP is " + rdmNumber + " vcqru.com. md5b2lDaeHj";
                    string otpMsg = "Your Employee verification OTP is " + rdmNumber + " www.vcqru.com md5b2lDaeHj";
                    ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");
                    HttpContext.Current.Session["otpSendTimes"] = Convert.ToInt16(HttpContext.Current.Session["otpSendTimes"].ToString()) + 1;
                    otp.success = 1;
                    otp.otp = rdmNumber.ToString();
                    // context.Response.Write(JsonConvert.SerializeObject(otp, Formatting.Indented));
                }
                else
                {
                    otp.success = 0;
                    otp.otp = "";
                    // context.Response.Write(JsonConvert.SerializeObject(otp, Formatting.Indented));
                }
            }
            else
            {
                otp.success = 0;
                otp.otp = "Please enter correct mobile number";
                // context.Response.Write(JsonConvert.SerializeObject(otp, Formatting.Indented));
                //result = "failure"; 
            }

            // otp.success = 0;
            // otp.otp = "";
            context.Response.Write(JsonConvert.SerializeObject(otp, Formatting.Indented));
        }

        else if (context.Request.QueryString["method"] == "OTPVerifyVR")
        {
            try
            {
                string otp = context.Request.QueryString["verifycode"].ToString();
                string mobile = context.Request.QueryString["mobile"].ToString();
                DataSet dsOTPVerify = app_OTPVerifyVR(otp, mobile);
                string json = "";
                message_status messageobject = new message_status();
                string otpp = dsOTPVerify.Tables[0].Rows[0][0].ToString();
                messageobject.status = "0";
                messageobject.message = "";
                if (dsOTPVerify.Tables[0].Rows[0][0].ToString() == otp)
                {
                    messageobject.status = "1";
                    messageobject.message = "success";
                }
                else
                {
                    messageobject.status = "0";
                    messageobject.message = "OTP is wrong!";
                }
                json = JsonConvert.SerializeObject(messageobject, Formatting.Indented);
                context.Response.Write(json);

            }
            catch (Exception e)
            {
                throw;
            }

        }

        else if (context.Request.QueryString["method"] == "app_CompleteProfileStatusVR")
        {
            try
            {
                string userid = context.Request.QueryString["userid"].ToString();

                userid = userid.Substring(userid.Length - 10, 10).ToString();

                Profile_DetailsVrKabel messageobject = new Profile_DetailsVrKabel();
                DataTable table = new DataTable();
                table = SQL_DB.ExecuteDataTable("select a.M_Consumerid,User_ID,ref_cin_number,communication_status,business_status,aadharFile,aadharback,Aadhar_source,pan_card_file,shop_file,profile_image,Vrkabel_User_Type,VRKbl_KYC_status,case when dob is null then 0 else 1 end ProfileStep1Status,remark, case when (b.Account_No <>'' and b.IFSC_Code <>'' and b.[Bank_Name] <>'' and b.Branch <>'') then '1' else '0' end accountStatus from M_Consumer as a  left join  M_BankAccount as b  on b.M_Consumerid=a.M_Consumerid where right(a.MobileNo, 10) = '" + userid + "'");
                if (table.Rows.Count > 0)
                {
                    table.Columns.Add("gift_message");

                    if (table.Rows[0]["VRKbl_KYC_status"].ToString() == "2")
                    {
                        string comments = "" + table.Rows[0]["remark"].ToString() + "";
                        // string acb = "hi this is admin";
                        string commentsRemark = '“' + comments + '“';
                        table.Rows[0]["gift_message"] = "Your KYC was rejected due to " + commentsRemark + ", Please check the details entered and update your profile with correct information. Once completed contact to support on +91 9728840888. ";
                    }
                    else if (table.Rows[0]["VRKbl_KYC_status"].ToString() == "3")
                    {
                        table.Rows[0]["gift_message"] = "Your Profile is under review. You can access the account after KYC is approved.";
                    }
                    else
                    {
                        table.Rows[0]["gift_message"] = " ";
                    }
                    var response = new { result = table };
                    string json = JsonConvert.SerializeObject(response, Formatting.Indented);
                    context.Response.Write(json);
                }
                else
                {
                    var response = new { result = table };
                    string json = JsonConvert.SerializeObject(response, Formatting.Indented);
                    context.Response.Write(json);
                }
            }
            catch (Exception e)
            {
                throw;
            }

        }
        else if (context.Request.QueryString["method"] == "copperDetalVR")
        {
            try
            {
                //string result;
                //string userid = context.Request.QueryString["userid"].ToString();
                //Profile_DetailsVrKabel messageobject = new Profile_DetailsVrKabel();
                DataTable table = new DataTable();
                //  table = SQL_DB.ExecuteDataTable("select title,price,CONCAT(sortDesc,updated_at) as sortDesc, detail,imagePath,status from vr_copper_detail");
                table = SQL_DB.ExecuteDataTable("select title,price,CONCAT(sortDesc, format(updated_at, 'hh:mm tt dd MMM yyyy')) as sortDesc, detail,imagePath,status from vr_copper_detail");

                if (table.Rows.Count > 0)
                {
                    var response = new { result = table };
                    string json = JsonConvert.SerializeObject(response, Formatting.Indented);
                    context.Response.Write(json);
                }
                else
                {
                    var response = new { result = table };
                    string json = JsonConvert.SerializeObject(response, Formatting.Indented);
                    context.Response.Write(json);
                }
            }
            catch (Exception e)
            {
                throw;
            }

        }

        else if (context.Request.QueryString["method"] == "GiftTableForDealer")
        {
            try
            {
                string UserType = context.Request.QueryString["UserType"];
                string CompId = context.Request.QueryString["CompID"];
                DataTable table = new DataTable();
                table = SQL_DB.ExecuteDataTable("select [Gift_name],[Gift_value],[Gift_point],[Stage] from Claim_gift where [status]=1 and CompID='" + CompId + "' and UserType='" + UserType + "' order by Gift_point");

                if (table.Rows.Count > 0)
                {
                    var response = new { result = table };
                    string json = JsonConvert.SerializeObject(response, Formatting.Indented);
                    context.Response.Write(json);
                }
                else
                {
                    var response = new { result = table };
                    string json = JsonConvert.SerializeObject(response, Formatting.Indented);
                    context.Response.Write(json);
                }
            }
            catch (Exception e)
            {
                throw;
            }

        }


        else if (context.Request.QueryString["method"] == "app_OTPVerifyVR")
        {
            try
            {
                //string result;
                string Vrkabel_User_Type = "";
                string userTypeName = "";
                Profile_DetailsVrKabel messageobject = new Profile_DetailsVrKabel();
                string otp = context.Request.QueryString["verifycode"].ToString();
                string mobile = context.Request.QueryString["mobile"].ToString();
                DataTable dtt1 = SQL_DB.ExecuteDataTable("SELECT top 1 otp FROM COMPANYPRODUCT WHERE right([MobileNumber],10) = '" + mobile.Substring(mobile.Length - 10) + "' and otp= '" + otp + "' and status='1'");
                if (dtt1.Rows.Count == 1)
                {
                    messageobject.status = "400";
                    messageobject.message = "Otp allready used!";
                }
                else
                {
                    DataSet dsOTPVerify = app_OTPVerifyVR(otp, mobile);

                    string otpp = dsOTPVerify.Tables[0].Rows[0][0].ToString();
                    if (dsOTPVerify.Tables[0].Rows[0][0].ToString() == otp)
                    {
                        DataSet ds = SQL_DB.ExecuteDataSet("select * from M_Consumer where right([mobileno],10) = '" + mobile.Substring(mobile.Length - 10) + "' and Vrkabel_User_Type is not NULL");
                        if (ds.Tables[0].Rows.Count > 0)
                        {

                            //consumer_id=ds.Tables[0].Rows[0]["MobileNo"].ToString();
                            Vrkabel_User_Type = ds.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString();

                            if (Vrkabel_User_Type == "1")
                            {
                                userTypeName = "Dealar";
                            }
                            else if (Vrkabel_User_Type == "4")
                            { // electrician
                                userTypeName = "Electrician";
                            }
                            else if (Vrkabel_User_Type == "3")
                            { // counterboy
                                userTypeName = "Counter Boy";
                            }
                            else if (Vrkabel_User_Type == "2")
                            { // retailer
                                userTypeName = "Retailer";
                            }
                            else
                            {
                                userTypeName = "NA";
                            }

                            messageobject.name = ds.Tables[0].Rows[0]["ConsumerName"].ToString();
                            messageobject.user_type = Vrkabel_User_Type;
                            messageobject.userTypeName = userTypeName;
                            messageobject.M_Consumerid = ds.Tables[0].Rows[0]["M_Consumerid"].ToString();
                            messageobject.cin_number = ds.Tables[0].Rows[0]["cin_number"].ToString();
                            messageobject.mobile_number = ds.Tables[0].Rows[0]["MobileNo"].ToString();
                            messageobject.user_id = ds.Tables[0].Rows[0]["User_ID"].ToString();
                            messageobject.pan_card_file = ds.Tables[0].Rows[0]["pan_card_file"].ToString();
                            messageobject.aadhar_file_front = ds.Tables[0].Rows[0]["aadharFile"].ToString();
                            messageobject.aadhar_file_back = ds.Tables[0].Rows[0]["aadharback"].ToString();
                            messageobject.shop_file = ds.Tables[0].Rows[0]["shop_file"].ToString();
                            messageobject.communication_status = ds.Tables[0].Rows[0]["communication_status"].ToString();
                            messageobject.business_status = ds.Tables[0].Rows[0]["business_status"].ToString();
                            messageobject.status = "200";
                            messageobject.message = "Success";
                        }
                        else
                        {
                            messageobject.status = "400";
                            messageobject.message = "Mobile number not registered Or Role not activated!";
                        }

                    }
                    else
                    {
                        messageobject.status = "400";
                        messageobject.message = "OTP not valid!";

                    }
                }
                string json = JsonConvert.SerializeObject(messageobject, Formatting.Indented);
                //DataProvider.LogManager.ErrorExceptionLog(DateTime.Now.ToLongDateString() + ":line no-2010 Exception at Masterhandler on update_user condition" + Environment.NewLine + " Parameter: " + json);
                context.Response.Write(json);
            }
            catch (Exception e)
            {
                throw;
            }

        }

        else if (context.Request.QueryString["method"] == "Validateotp")
        {
            string result = "";
            string otp = "";
            if (context.Request.QueryString["verifycode"].ToString() == "1234")
                otp = context.Request.QueryString["verifycode"].ToString();
            else
                otp = context.Request.QueryString["verifycode"].ToString();
            string mobile = string.Empty;
            if (!string.IsNullOrEmpty(context.Request.QueryString["mobile"]))
                mobile = context.Request.QueryString["mobile"].ToString();

            DataSet dsOTPVerify = OTPVerifyexibition(otp, mobile);
            if (dsOTPVerify.Tables[0].Rows.Count > 0)
            {
                result = "Success";
            }
            else
            {
                result = "failure";
            }
            context.Response.Write(result);
            return;
        }

        //Packplus
        else if (context.Request.QueryString["method"] == "InsertUpdateExibition")
        {
            string Mobile_no = "";
            if (context.Request.QueryString["Mobile_no"] != null)
                Mobile_no = context.Request.QueryString["Mobile_no"].ToString();
            string Name = "";
            if (context.Request.QueryString["Name"] != null)
                Name = context.Request.QueryString["Name"].ToString();
            string Email = "";
            if (context.Request.QueryString["Email"] != null)
                Email = context.Request.QueryString["Email"].ToString();
            string CompName = "";
            if (context.Request.QueryString["CompName"] != null)
                CompName = context.Request.QueryString["CompName"].ToString();
            string Designation = "";
            if (context.Request.QueryString["Designation"] != null)
                Designation = context.Request.QueryString["Designation"].ToString();
            string Intrest = "";
            if (context.Request.QueryString["Intrest"] != null)
                Intrest = context.Request.QueryString["Intrest"].ToString();
            InsertUpdateExibitiondtls(Mobile_no, Name, Email, CompName, Designation, Intrest);
        }
        //Packplus

        //start of Wellverse 
        else if (context.Request.QueryString["method"] == "Repostofwellverse")
        {
            string Mobileno = string.Empty;
            string Imgpath = string.Empty;
            string Lat = string.Empty;
            string Long = string.Empty;
            string Comp_id = string.Empty;
            string Prchasedfrom = string.Empty;
            if (context.Request.QueryString["Mobileno"] != null)
                Mobileno = context.Request.QueryString["Mobileno"];
            if (context.Request.QueryString["Imgpath"] != null)
                Imgpath = context.Request.QueryString["Imgpath"];
            if (context.Request.QueryString["Lat"] != null)
                Lat = context.Request.QueryString["Lat"];
            if (context.Request.QueryString["Long"] != null)
                Long = context.Request.QueryString["Long"];
            if (context.Request.QueryString["Comp_id"] != null)
                Comp_id = context.Request.QueryString["Comp_id"];
            if (context.Request.QueryString["Prchasedfrom"] != null)
                Prchasedfrom = context.Request.QueryString["Prchasedfrom"];
            if (Mobileno.Length == 10)
            {
                Mobileno = "91" + Mobileno;
            }
            location loc = new location();
            insertfakedata ifd = new insertfakedata();
            loc.latitude = Lat;
            loc.longitude = Long;
            string getaddress = Business9420.function9420.GetLocationFromLongLatreturnaddress(loc);
            if (getaddress.Length > 0)
            {
                ifd.Country = getaddress.Split('~')[0].ToString();
                ifd.State = getaddress.Split('~')[1].ToString();
                ifd.City = getaddress.Split('~')[2].ToString();
                ifd.Address = getaddress.Split('~')[3].ToString();
            }

            var path = "";
            var virtualPath = "";
            foreach (string key in HttpContext.Current.Request.Files)
            {
                var file = HttpContext.Current.Request.Files[key];
                var fileName = Path.GetFileNameWithoutExtension(file.FileName) + "_" + Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                path = Path.Combine(context.Server.MapPath("~/fackProductImg"), fileName);
                virtualPath = Path.Combine("/fackProductImg", fileName);
                file.SaveAs(path);
            }
            ifd.Mobileno = Mobileno;
            ifd.Imgpath = virtualPath;
            ifd.Lat = Lat;
            ifd.Long = Long;
            ifd.Comp_id = Comp_id;
            ifd.Purchsedfrom = Prchasedfrom;
            ifd.DML = "I";
            Business9420.function9420.Insertfakedata(ifd);
            string resilt = "We are appreciate your cooperation in helping us address the product verification issue.";
            context.Response.Write(resilt);
        }
        //End of Wellverse

        #region Delete account request
        else if (context.Request.QueryString["method"] == "Deleteotpsend")
        {

            string mobileNumber = context.Request.QueryString["mobile"].ToString();
            mobileNumber = mobileNumber.Substring(mobileNumber.Length - 10);
            DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email],Password FROM [M_Consumer] where [MobileNo] like '%" + mobileNumber + "' and IsDelete=0");

            if (dcs.Tables[0].Rows.Count == 0)
            {

                context.Response.Write("2");
                return;
            }
            int rdmNumber = RandomNumber(1000, 9999);

            string otpMsg = "Your Employee verification OTP is " + rdmNumber + " www.vcqru.com md5b2lDaeHj";
            //string  otpMsg = "%3C%23%3E OTP is " + rdmNumber + " for login at vcqru. Valid till "+DateTime.Now.AddMinutes(3).ToShortTimeString()+" "+ConfigurationManager.AppSettings["hashvalue"];
            //string sendSMSurl = "http://sms.alfasms.in/sendSMS?username=alfasms&message=" + otpMsg + "&sendername=Alfast&smstype=TRANS&numbers=" + mobileNumber + "&apikey=d13cfc39-dae1-4462-8b46-5a2ab78ca5c1";
            //Your password  is " + dt.Rows[0]["Password"].ToString() + " VCQRU.com
            //SendSmsWithAlfa(otpMsg, mobileNumber);
            HttpContext.Current.Session["otpSendTimes"] = 1;

            ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");

            DateTime expDate = System.DateTime.Now.AddYears(1); //purDate.AddYears(1);
                                                                //int otp_counter = Convert.ToInt16(SQL_DB.ExecuteScalar("select count([mobileNumber]) from [dbo].[CompanyProduct] where [mobileNumber]='" + mobileNumber + "'"));
                                                                //if(otp_counter > 0)
                                                                //{
                                                                //    SQL_DB.ExecuteNonQuery("update [dbo].[CompanyProduct] set [expiryDate]='" + expDate.ToString("MM/dd/yyyy") + "', [otp]='" + rdmNumber + "', [status]=0,[mobileNumber]='" + mobileNumber + "'");
                                                                //}
                                                                //else
                                                                //{
            SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[CompanyProduct] ([expiryDate], [otp], [status],[mobileNumber]) values ('" + expDate.ToString("yyyy-MM-dd HH:mm:ss") + "', '" + rdmNumber + "', 0, '" + mobileNumber + "')");
            //}
            context.Response.Write("1," + rdmNumber);

        }


        else if (context.Request.QueryString["method"] == "DeleteAccount_OTPVerify")
        {
            string result;
            string userid;
            string otp = context.Request.QueryString["verifycode"].ToString();
            string MobileNo = context.Request.QueryString["mobile"].ToString();
            DataSet dsOTPVerify = app_OTPVerify(otp, MobileNo);
            if (dsOTPVerify.Tables[0].Rows[0][0].ToString() == otp)
            {
                User_Details Log = new User_Details();

                Log.DML = "Mobile";
                #region Find Actual Mobile No
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
                    else
                    {
                        result = "Mobile No. Wrong!";

                    }
                }
                if (MobileNo.Length == 10)
                    MobileNo = "91" + MobileNo;
                #endregion

                Log.User_Type = "Consumer";
                Log.User_ID = MobileNo;

                DataTable dt = User_Details.app_GetUserLoginDetails(Log);
                if (dt.Rows.Count > 0)
                {

                    string Additional = System.DateTime.Now.ToString("yyMMddHHmmssff");

                    SQL_DB.ExecuteNonQuery("Update M_Consumer set IsDelete=1 ,Additional='" + Additional + "' where M_Consumerid='" + dt.Rows[0]["M_Consumerid"].ToString() + "'");



                    result = "Success";// + "~" + dt.Rows[0]["MM"].ToString()
                }
                else
                {
                    result = "This account is not registered with us.!";

                }



            }
            else
            {
                result = "Usuccess";
            }

            context.Response.Write(result);
        }
        #endregion

        //exibition
        else if (context.Request.QueryString["method"] == "sendotpexibition")
        {
            string Result = "";
            otp_response otp = new otp_response();
            string mobileNumber = context.Request.QueryString["mobile"].ToString();

            User_Details user = new User_Details();
            Random rnd = new Random();
            user.Password = rnd.Next(10000, 99999).ToString();
            if (mobileNumber.Length == 10)
                mobileNumber = "91" + mobileNumber;
            user.MobileNo = mobileNumber;
            user.DML = "I";
            user.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy-MM-dd hh:mm:ss.ttt"));
            //User_Details.InsertUpdateUserDetails(user);
            int rdmNumber = RandomNumber(1000, 9999);

            //  string otpMsg = "%3C%23%3E Your Employee verification OTP is " + rdmNumber + " vcqru.com. xj4rOadD4po";
            string otpMsg = "Your Employee verification OTP is " + rdmNumber + " www.vcqru.com md5b2lDaeHj";
            HttpContext.Current.Session["otpSendTimes"] = 1;
            ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");
            DateTime expDate = System.DateTime.Now.AddYears(1);
            SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[CompanyProduct] ([expiryDate], [otp], [status],[mobileNumber]) values ('" + expDate.ToString("yyyy-MM-dd HH:mm:ss") + "', '" + rdmNumber + "', 0, '" + mobileNumber + "')");
            Result = "OTP send successfully";
            // return Result;
            //otp.success = 1;
            //otp.otp = rdmNumber.ToString();
            //otp.otp = "OTP send successfully!";
            context.Response.Write(Result);
        }
        //exibition


        else if (context.Request.QueryString["method"] == "android_otpsend_1VR")
        {

            otp_response otp = new otp_response();
            string mobileNumber = context.Request.QueryString["mobile"].ToString();
            mobileNumber = mobileNumber.Substring(mobileNumber.Length - 10);
            DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email],Password,Vrkabel_User_Type,Comp_id FROM [M_Consumer] where right([MobileNo],10) = '" + mobileNumber.Substring(mobileNumber.Length - 10) + "'");

            if (dcs.Tables[0].Rows.Count > 0)
            {

                if (dcs.Tables[0].Rows[0]["Comp_id"].ToString() != "Comp-1400")
                {
                    otp.success = 2;
                    otp.otp = "this number is already registered for other company!";
                    context.Response.Write(JsonConvert.SerializeObject(otp, Formatting.Indented));
                }
                else if (dcs.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString() == "")
                {
                    otp.success = 0;
                    otp.otp = "Invalid user role !";
                    context.Response.Write(JsonConvert.SerializeObject(otp, Formatting.Indented));
                }
                else
                {
                    User_Details user = new User_Details();
                    Random rnd = new Random();
                    user.Password = rnd.Next(10000, 99999).ToString();
                    if (mobileNumber.Length == 10)
                        mobileNumber = "91" + mobileNumber;
                    user.MobileNo = mobileNumber;
                    user.DML = "I";
                    user.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy-MM-dd hh:mm:ss.ttt"));
                    //User_Details.InsertUpdateUserDetails(user);
                    int rdmNumber = RandomNumber(1000, 9999);

                    //  string otpMsg = "%3C%23%3E Your Employee verification OTP is " + rdmNumber + " vcqru.com. xj4rOadD4po";
                    string otpMsg = "Your Employee verification OTP is " + rdmNumber + " www.vcqru.com md5b2lDaeHj";
                    HttpContext.Current.Session["otpSendTimes"] = 1;
                    ServiceLogic.SendSMSFromAlfa(mobileNumber, otpMsg, "OTP");
                    DateTime expDate = System.DateTime.Now.AddYears(1);
                    SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[CompanyProduct] ([expiryDate], [otp], [status],[mobileNumber]) values ('" + expDate.ToString("yyyy-MM-dd HH:mm:ss") + "', '" + rdmNumber + "', 0, '" + mobileNumber + "')");

                    otp.success = 1;
                    //otp.otp = rdmNumber.ToString();
                    otp.otp = "OTP send successfully!";
                    context.Response.Write(JsonConvert.SerializeObject(otp, Formatting.Indented));
                }
            }
            else
            {

                otp.success = 0;
                otp.otp = "Number not registered!";
                context.Response.Write(JsonConvert.SerializeObject(otp, Formatting.Indented));

            }


        }


        else if (context.Request.QueryString["method"] == "OffersVrKabel")
        {
            DataTable table = new DataTable();
            table = SQL_DB.ExecuteDataTable("select ImagePath from Tbl_OfferVrKabel");
            //if (table.Rows.Count > 0)
            var response = new { result = table };
            string json = JsonConvert.SerializeObject(response, Formatting.Indented);
            context.Response.Write(json);
        }
        else if (context.Request.QueryString["method"] == "LeaderBoardVRKabel")
        {
            string userType = context.Request.QueryString["userType"].ToString();
            DataTable table = new DataTable();
            userType = userType.Trim();
            string qryStr = "select  * from( select top 5 m.mobileno,m.ConsumerName AS name,m.Profile_Image, " +
          "(sum(isnull(cast(bl.Points as int),0))- isnull((select Sum(cast(TotalPoints as int)) " +
          "from BPointsTransaction " +
          "where RedeemBy=m.M_Consumerid and (bpstatus='Accepted' or bpstatus='SUCCESS')),0)) as Points " +
          "from  M_Consumer m left join Pro_Enq pe on pe.MobileNo=m.MobileNo and pe.is_success= '1' " +
          "left join (Select Row_ID,Code1,Code2,Pro_ID from M_Code where Use_Count >0 ) mc " +
          "on mc.Code1=pe.Received_Code1 and mc.Code2=pe.Received_Code2 " +
          "left join M_Consumer_M_Code mcode on mcode.M_Codeid=mc.Row_ID " +
          "left join BuiltLoyaltyMCodeCheck blc on blc.M_Consumer_MCOdeid=mcode.M_Consumer_MCodeid " +
          "left join BLoyaltyPointsEarned bl on bl.BuildLoyaltyOrReferralMCodeCheckid=blc.Pkid " +
          "where  m.Vrkabel_User_Type='" + userType + "' " +
          "group by m.mobileno,m.ConsumerName,m.Email,m.M_Consumerid,m.User_ID, " +
          "m.cin_number,m.designation,m.gender,m.sur_name,m.profile_image order by Points desc) Details  ";

            table = SQL_DB.ExecuteDataTable(qryStr);
            //if (table.Rows.Count > 0)
            var response = new { result = table };
            string json = JsonConvert.SerializeObject(response, Formatting.Indented);
            context.Response.Write(json);
        }
        else if (context.Request.QueryString["method"] == "LeaderBoardVRKabel")
        {
            string userType = context.Request.QueryString["userType"].ToString();
            DataTable table = new DataTable();
            userType = userType.Trim();
            string qryStr = "select  * from( select top 5 m.mobileno,m.ConsumerName AS name,m.Profile_Image, " +
          "(sum(isnull(cast(bl.Points as int),0))- isnull((select Sum(cast(TotalPoints as int)) " +
          "from BPointsTransaction " +
          "where RedeemBy=m.M_Consumerid and (bpstatus='Accepted' or bpstatus='SUCCESS')),0)) as Points " +
          "from  M_Consumer m left join Pro_Enq pe on pe.MobileNo=m.MobileNo and pe.is_success= '1' " +
          "left join (Select Row_ID,Code1,Code2,Pro_ID from M_Code where Use_Count >0 ) mc " +
          "on mc.Code1=pe.Received_Code1 and mc.Code2=pe.Received_Code2 " +
          "left join M_Consumer_M_Code mcode on mcode.M_Codeid=mc.Row_ID " +
          "left join BuiltLoyaltyMCodeCheck blc on blc.M_Consumer_MCOdeid=mcode.M_Consumer_MCodeid " +
          "left join BLoyaltyPointsEarned bl on bl.BuildLoyaltyOrReferralMCodeCheckid=blc.Pkid " +
          "where  m.Vrkabel_User_Type='" + userType + "' " +
          "group by m.mobileno,m.ConsumerName,m.Email,m.M_Consumerid,m.User_ID, " +
          "m.cin_number,m.designation,m.gender,m.sur_name,m.profile_image order by Points desc) Details  ";

            table = SQL_DB.ExecuteDataTable(qryStr);
            //if (table.Rows.Count > 0)
            var response = new { result = table };
            string json = JsonConvert.SerializeObject(response, Formatting.Indented);
        }
        else if (context.Request.QueryString["method"] == "PointBifurcationVRKabel")
        {
            string userType = context.Request.QueryString["userType"].ToString();
            DataTable table = new DataTable();
            userType = userType.Trim();
            //message_Vrkabel messageobject = new message_Vrkabel();
            table = SQL_DB.ExecuteDataTable("select ImagePath from VR_PointBifurcation where user_type = '" + userType + "'");
            //if (table.Rows.Count > 0)
            var response = new { result = table };
            string json = JsonConvert.SerializeObject(response, Formatting.Indented);
            context.Response.Write(json);
        }
        else if (context.Request.QueryString["method"] == "VRGetUserByCinNumber")
        {
            string cinNumber = context.Request.QueryString["cin_number"].ToString();
            string userType = context.Request.QueryString["userType"].ToString();
            string OrderBy = context.Request.QueryString["OrderBy"].ToString();

            DataTable table = new DataTable();
            //message_Vrkabel messageobject = new message_Vrkabel();
            //table = SQL_DB.ExecuteDataTable("select User_ID AS id,ConsumerName AS name,Email AS email_id,MobileNo AS mobile_number, case  when Vrkabel_User_Type='1' then 'Dealer' when Vrkabel_User_Type='2' then 'Retailer' when Vrkabel_User_Type='3' then 'Counter Boy' when Vrkabel_User_Type='4' then 'Electrician'  end 'Usertype',cin_number,designation,gender,sur_name from M_Consumer where ref_cin_number='" + cinNumber + "'");

            /*string qry1 = "select  * from  ( select m.MobileNo AS mobile_number,m.ConsumerName AS name,m.Email AS email_id,m.M_Consumerid,m.User_ID AS id,m.cin_number,m.designation,m.gender,m.sur_name, case  when m.Vrkabel_User_Type='1' then 'Dealer' when m.Vrkabel_User_Type='2' then 'Retailer' when m.Vrkabel_User_Type='3' then 'Counter Boy' when m.Vrkabel_User_Type='4' then 'Electrician'  end 'Usertype',CAST((sum(bl.Points)- isnull((select Sum(TotalPoints)  from BPointsTransaction where RedeemBy=m.M_Consumerid and (bpstatus='Accepted' or bpstatus='SUCCESS')),0)) AS int) Points from  M_Consumer m inner join Pro_Enq pe on pe.MobileNo=m.MobileNo " +
                          "inner join (Select Row_ID,Code1,Code2,Pro_ID from M_Code where Use_Count >0 ) mc on mc.Code1=pe.Received_Code1 and mc.Code2=pe.Received_Code2 " +
                          "inner join M_Consumer_M_Code mcode on mcode.M_Codeid=mc.Row_ID " +
                          "inner join BuiltLoyaltyMCodeCheck blc on blc.M_Consumer_MCOdeid=mcode.M_Consumer_MCodeid " +
                          "inner join BLoyaltyPointsEarned bl on bl.BuildLoyaltyOrReferralMCodeCheckid=blc.Pkid " +
                          "where m.ref_cin_number='" +cinNumber+ "' " +
                          "group by m.MobileNo,m.ConsumerName,m.Email,m.M_Consumerid,m.User_ID,m.cin_number,m.designation,m.gender,m.sur_name,m.Vrkabel_User_Type) Details order by Points desc";
            */

            string qry1 = "select  * from( select m.MobileNo AS mobile_number,m.ConsumerName AS name,m.Email AS email_id, " +
                          "m.M_Consumerid,m.User_ID AS id,m.cin_number,m.designation,m.gender,m.sur_name, " +
                          "case  when m.Vrkabel_User_Type='1' then 'Dealer' " +
                          "when m.Vrkabel_User_Type='2' then 'Retailer' " +
                          "when m.Vrkabel_User_Type='3' then 'Counter Boy' " +
                          "when m.Vrkabel_User_Type='4' then 'Electrician'  end 'Usertype', " +
                     "(sum(isnull(cast(bl.Points as int),0))- isnull((select Sum(cast(TotalPoints as int)) " +
                          "from BPointsTransaction " +
                          "where RedeemBy=m.M_Consumerid and (bpstatus='Accepted' or bpstatus='SUCCESS')),0)) as Points " +
                          "from  M_Consumer m left join Pro_Enq pe on pe.MobileNo=m.MobileNo and pe.is_success= '1' " +
                          "left join (Select Row_ID,Code1,Code2,Pro_ID from M_Code where Use_Count >0 ) mc " +
                          "on mc.Code1=pe.Received_Code1 and mc.Code2=pe.Received_Code2 " +
                          "left join M_Consumer_M_Code mcode on mcode.M_Codeid=mc.Row_ID " +
                          "left join BuiltLoyaltyMCodeCheck blc on blc.M_Consumer_MCOdeid=mcode.M_Consumer_MCodeid " +
                          "left join BLoyaltyPointsEarned bl on bl.BuildLoyaltyOrReferralMCodeCheckid=blc.Pkid " +
                          "where m.ref_cin_number = '" + cinNumber + "' and m.Vrkabel_User_Type like '%" + userType + "%'   " +
                          "group by m.MobileNo,m.ConsumerName,m.Email,m.M_Consumerid,m.User_ID, " +
                          "m.cin_number,m.designation,m.gender,m.sur_name,m.Vrkabel_User_Type) Details " +
                          "order by Points " + OrderBy;

            table = SQL_DB.ExecuteDataTable(qry1);
            var response = new { result = table };
            string json = JsonConvert.SerializeObject(response, Formatting.Indented);
            context.Response.Write(json);
        }
        else if (context.Request.QueryString["method"] == "VRGifts")
        {
            DataTable table = new DataTable();
            table = SQL_DB.ExecuteDataTable("select * from Claim_gift where CompID='Comp-1400' order by gift_id desc");
            var response = new { result = table };
            string json = JsonConvert.SerializeObject(response, Formatting.Indented);
            context.Response.Write(json);
        }

        else if (context.Request.QueryString["method"] == "UploadVrkabelFile")
        {
            string imgpath = context.Request.QueryString["imgpath"].ToString();
            string UserId = context.Request.QueryString["UserId"].ToString();
            string filetype = context.Request.QueryString["filetype"].ToString();
            object result = UploadVrkabelFile(imgpath, UserId, filetype);
            context.Response.Write(result);
        }




        if (context.Request.QueryString["method"] == "Claim_1VRApp")
        {
            string strcompidParam = context.Request.QueryString["compid"];
            string userid = context.Request.QueryString["userid"];
            if (userid.Length == 12)
            {
                userid = userid.Substring(userid.Length - 10, 10);
            }

            DataTable dt = new DataTable();
            dt = SQL_DB.ExecuteDataTable("select top 1 [user_id],[MobileNo],M_Consumerid,Vrkabel_User_Type from m_consumer where right(mobileno,10)='" + userid + "'");
            DataTable dtcp = null;
            if (dtcp != null)
            {
                dtcp.Rows.Clear();
            }
            int consumerid = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
            string distributorid = string.Empty;
            DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("dashboarddataVR", Convert.ToInt32(consumerid), distributorid);
            DataTable dtrecord = new DataTable();

            dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where mss.Comp_ID='Comp-1400' and bl.M_consumerid = (select M_consumerid from dbo.m_consumer where M_Consumerid= " + consumerid + ") group by mss.Comp_ID,cl.p_cash"); // and mss.Comp_ID='"+strcompidParam+"' added by tej

            //dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where  bl.M_consumerid = (select M_consumerid from dbo.m_consumer where MobileNo = '" + dt.Rows[0]["MobileNo"].ToString() + "') and mss.Comp_ID='" + strcompidParam + "' group by mss.Comp_ID,cl.p_cash"); // and mss.Comp_ID='"+strcompidParam+"' added by tej

            // dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where  bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + dt.Rows[0][0].ToString() + "') group by mss.Comp_ID,cl.p_cash");

            DataTable table = new DataTable();


            table = SQL_DB.ExecuteDataTable("select [gift_id],[Gift_name],[Gift_value],[Gift_point] ,[Gift_desc],[Gift_image],[Stage] from Claim_gift where [status]=1 and CompID='" + strcompidParam.ToString() + "' and UserType='" + dt.Rows[0]["Vrkabel_User_Type"].ToString() + "'  order by Gift_point");

            table.Columns.Add("gift_message");
            table.Columns.Add("btn_flag", typeof(Int32));
            table.Columns.Add("Comp_id");
            table.Columns["gift_message"].ReadOnly = false;
            table.Columns["btn_flag"].ReadOnly = false;
            table.Columns["Gift_value"].ReadOnly = false;
            ////////////////
            try
            {
                int tp = 0;

                string loyalty_return = SQL_DB.ExecuteScalar("select isnull(sum(loyalty),0) from scrap_entry se inner join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2 inner join m_consumer ms on ms.MobileNo=pe.MobileNo where pe.is_success=1 and  ms.M_Consumerid=" + dt.Rows[0][1].ToString()).ToString();
                if (dtcp.Rows.Count > 0)
                {
                    //int totalpoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum([Points]) is null then 0 else Sum([Points]) end as point FROM [BLoyaltyPointsEarned] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[M_Consumerid] where mc.[User_ID]='" + Session["USRID"].ToString() + "'"));
                    int loyaltybonus = 0;

                    if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1400")
                    {
                        loyaltybonus = Convert.ToInt32(SQL_DB.ExecuteScalar("select isnull(sum(points),0) as points from buildloyalty_offers where m_consumerid=" + dt.Rows[0][1].ToString()).ToString());
                    }
                    int totalpoint = (Convert.ToInt32(dtcp.Rows[0]["point"].ToString()) - Convert.ToInt32(loyalty_return)) + loyaltybonus;
                    // int redeempoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(bl.[RedeemPoints]) is null then 0 else Sum(isnull(bl.[RedeemPoints],0)) end FROM [BPointsTransaction] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[RedeemBy] where mc.[User_ID]='" + dt.Rows[0][0].ToString() + "' and (bl.bpstatus is null or bl.bpstatus<>'FAILURE') and mc.Comp_id='" + strcompidParam + "'")); // and mc.Comp_id='"+strcompidParam+"' Tej
                    //int claimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [ClaimDetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.[User_ID]='" + dt.Rows[0][0].ToString() + "' and (cl.Isapproved=1)"));
                    int claimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [ClaimDetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.M_Consumerid='" + consumerid + "' and (cl.Isapproved=1) and mc.Comp_id='Comp-1400'"));
                    int redeempoint = Convert.ToInt32(dtTrans.Tables[0].Rows[1][0].ToString());

                    float totalpointrt = Convert.ToInt32(dtcp.Rows[0]["p_cash"].ToString());
                    DataTable dtcondition = SQL_DB.ExecuteDataTable("select top 1 codition_point,condition_match from point_redeem_condition where comp_id='" + dtcp.Rows[0]["Comp_ID"].ToString() + "' and isactive=1 and selection_id=case when (select count(*) from paytmtransaction where m_consumerid='" + dt.Rows[0][1].ToString() + "' and comp_id='Comp-1214')>0 then 2 else 1 end ");

                    if (dtcondition.Rows.Count > 0)
                    {
                        //tp = totalpoint - redeempoint - claimapply;
                        tp = totalpoint - redeempoint;
                        int rp = 0;
                        if (dtcondition.Rows[0]["condition_match"].ToString() == "1")
                        {
                            rp = tp % Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString());
                            rp = tp - rp;
                        }
                        else
                        {
                            if (tp >= Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))
                            {
                                rp = tp;
                            }
                        }
                        //int ptforrd = rp;
                        int ptforrd = tp - rp;
                        float tpr = ptforrd * totalpointrt;
                        for (int i = 0; i < table.Rows.Count; i++)
                        {
                            if (table.Rows[i]["gift_id"].ToString() == "20")
                            {


                            }
                            else
                            {
                                if (Convert.ToInt32(table.Rows[i]["Gift_point"].ToString()) > tp)
                                {
                                    table.Rows[i]["gift_message"] = "You are not valid for claim.";
                                    table.Rows[i]["btn_flag"] = 0;
                                    table.Rows[i]["Gift_image"] = "../" + table.Rows[i]["Gift_image"];
                                }
                                else
                                {
                                    table.Rows[i]["btn_flag"] = 1;
                                    table.Rows[i]["Gift_image"] = "../" + table.Rows[i]["Gift_image"];
                                }

                            }

                        }
                    }

                }
            }
            catch (Exception ex)
            {
                throw;
            }
            ///////////////////////////////////
            var response = new { result = table };
            string json = JsonConvert.SerializeObject(response, Formatting.Indented);

            context.Response.Write(json);

        }
        if (context.Request.QueryString["method"] == "SubmitClaimVRApp")
        {
            string strcompidParam = context.Request.QueryString["compid"];
            message_status messageobject = new message_status();
            try
            {
                string claimdetails = context.Request.QueryString["claimdetails"];
                DataProvider.LogManager.ErrorExceptionLog(claimdetails);
                Claim Log = new Claim();
                string msg = "";
                int userType = 0;
                int giftid = 0;
                string UserMobileNo = "";
                Log = JsonConvert.DeserializeObject<Claim>(claimdetails);

                if (Log.Userid.Length == 12)
                {
                    UserMobileNo = Log.Userid.Substring(Log.Userid.Length - 10, 10).ToString();
                }
                else
                {
                    UserMobileNo = Log.Userid;
                }

                DataTable dt = new DataTable();
                dt = SQL_DB.ExecuteDataTable("select top 1 [user_id],M_Consumerid,Vrkabel_User_Type,[MobileNo] from m_consumer where right(mobileno,10)='" + UserMobileNo + "'");
                if (dt.Rows.Count > 0)
                {
                    userType = Convert.ToInt32(dt.Rows[0]["Vrkabel_User_Type"]);
                }
                giftid = Log.ProductId;
                ///////////////////////////////////////////////////////////
                string KycCheck = SQL_DB.ExecuteScalar("select VRKbl_KYC_status from dbo.[m_consumer] where right(mobileno,10)='" + UserMobileNo + "'").ToString();
                if (KycCheck == "1")
                {
                    DataTable dtcp = null;
                    //DataTable dtcp2 = null;

                    DataTable dtcondition = new DataTable();
                    int tp = 0;
                    if (dtcp != null)
                    {
                        dtcp.Rows.Clear();
                    }

                    //string loyalty_return = SQL_DB.ExecuteScalar("select isnull(sum(loyalty),0) from scrap_entry se inner join Pro_Enq pe on pe.Received_Code1=se.code1 and pe.Received_Code2=se.code2 inner join m_consumer ms on ms.MobileNo=pe.MobileNo where pe.is_success=1 and  ms.M_Consumerid=" + dt.Rows[0][1].ToString()).ToString();
                    string strqr = "select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where  bl.M_consumerid = (select M_consumerid from dbo.m_consumer where MobileNo = '" + dt.Rows[0]["MobileNo"].ToString() + "') and mss.Comp_ID = '" + strcompidParam + "' group by mss.Comp_ID,cl.p_cash";
                    dtcp = SQL_DB.ExecuteDataTable(strqr);

                    // dtcp2 = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where  bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + dt.Rows[0][0].ToString() + "') group by mss.Comp_ID,cl.p_cash");

                    if (dtcp.Rows.Count > 0)
                    {

                        string CompID = Log.Comp_id;
                        int ptforrd = Convert.ToInt32(Log.Productvalue);
                        float tpr = ptforrd;


                        string ps = string.Empty;

                        DataTable dtconsumer = SQL_DB.ExecuteDataTable("select m_consumerid from m_consumer where m_consumerid='" + dt.Rows[0][1].ToString() + "' and aadharfile is not null and aadharback is not null");
                        if (dtconsumer.Rows.Count > 0 || Log.Comp_id == "Comp-1400")
                        {
                            dtcondition = SQL_DB.ExecuteDataTable("select top 1 codition_point,condition_match from point_redeem_condition where comp_id='" + dtcp.Rows[0]["Comp_ID"].ToString() + "' and isactive=1 and selection_id=case when (select count(*) from paytmtransaction where m_consumerid='" + dt.Rows[0][1].ToString() + "' and pstatus='SUCCESS' and comp_id='Comp-1214')>0 then 2 else 1 end ");


                            if (ptforrd >= Convert.ToInt32(dtcondition.Rows[0]["codition_point"].ToString()))
                            {
                                string cn = SQL_DB.ExecuteScalar("select Comp_Name from dbo.[comp_reg] where comp_id='" + dtcp.Rows[0]["Comp_ID"].ToString() + "'").ToString();
                                string mb = SQL_DB.ExecuteScalar("select mobileno from dbo.m_consumer where right(mobileno,10)='" + UserMobileNo.ToString() + "'").ToString();
                                string oid = SQL_DB.ExecuteScalar("select (ISNULL(max(orderid),1000))+1 as orderid from [dbo].[paytmtransaction]").ToString();

                                if (cn == "VR KABLE INDIA PRIVATE LIMITED")
                                {
                                    string fv = "select Isapproved,Amount from [ClaimDetails]  where right([ClaimDetails].Mobileno, 10) = '" + UserMobileNo + "' and [Isapproved] = 0 ";
                                    DataTable dtcondition2 = SQL_DB.ExecuteDataTable("select Isapproved,Amount from [ClaimDetails]  where right([ClaimDetails].Mobileno, 10) = '" + UserMobileNo + "' and [Isapproved] = 0 ");
                                    DataTable dtcondition1 = SQL_DB.ExecuteDataTable("select Isapproved,Gift_id from [ClaimDetails]  where right([ClaimDetails].Mobileno, 10) = '" + UserMobileNo + "' and [Isapproved] != 1 and Gift_id = '" + Log.ProductId.ToString() + "'");
                                    int giftValue = Convert.ToInt32(Log.Productvalue);
                                    //DataTable GiftsTbl = SQL_DB.ExecuteDataTable("select * from Claim_gift where CompID='" + dtcp.Rows[0]["Comp_ID"].ToString() + "' and Gift_value='"+ giftValue +"'");
                                    DataTable GiftsTbl = SQL_DB.ExecuteDataTable("select * from Claim_gift where CompID='" + dtcp.Rows[0]["Comp_ID"].ToString() + "' and gift_id='" + Log.ProductId + "'");
                                    string GiftName = "Gift value not match!";
                                    string Gift_point = "0";
                                    string Gift_Value = "0";
                                    if (GiftsTbl.Rows.Count > 0)
                                    {
                                        GiftName = GiftsTbl.Rows[0]["Gift_name"].ToString();
                                        Gift_point = GiftsTbl.Rows[0]["Gift_point"].ToString();
                                        Gift_Value = GiftsTbl.Rows[0]["Gift_value"].ToString();
                                    }
                                    if (dtcondition2.Rows.Count > 0)
                                    {

                                        messageobject.status = "Unsuccess";
                                        msg = "Your Request Already Registered with US for points " + dtcondition2.Rows[0]["Amount"].ToString();

                                    }
                                    else
                                    {
                                        if (dtcondition1.Rows.Count > 0 && dtcondition1.Rows[0]["Isapproved"].ToString() == "2")
                                        {
                                            // SQL_DB.ExecuteNonQuery("update ClaimDetails set Isapproved='0' where Isapproved = 2 and Comp_id='Comp-1400' and Gift_id = '" + Log.ProductId.ToString() + "'");
                                            //string strqrr = "insert into ClaimDetails([Claim_date],[Mobileno],[Amount],[Gifts_Redeemed],[document_status],[action_date],[Isapproved],[Comp_id]) values(GETDATE(),'" + mb + "'," + tpr.ToString() + ",'" + GiftName + "',1,null,0,'" + dtcp.Rows[0]["Comp_ID"].ToString() + "') ";

                                            SQL_DB.ExecuteNonQuery("insert into ClaimDetails([Claim_date],[Mobileno],[Amount],[Gifts_Redeemed],[Points_Redeemed],[document_status],[action_date],[Isapproved],[Comp_id],[vruserType],[Gift_id]) values(GETDATE(),'" + mb + "'," + Gift_Value.ToString() + ",'" + GiftName + "','" + Gift_point + "',1,null,0,'" + dtcp.Rows[0]["Comp_ID"].ToString() + "','" + userType + "','" + giftid + "') ");
                                            messageobject.status = "Success";
                                            msg = "Your Request Registered with US for points " + ptforrd;
                                        }
                                        else
                                        {
                                            SQL_DB.ExecuteNonQuery("insert into ClaimDetails([Claim_date],[Mobileno],[Amount],[Gifts_Redeemed],[Points_Redeemed],[document_status],[action_date],[Isapproved],[Comp_id],[vruserType],[Gift_id]) values(GETDATE(),'" + mb + "','" + Gift_Value.ToString() + "','" + GiftName + "','" + Gift_point + "',1,null,0,'" + dtcp.Rows[0]["Comp_ID"].ToString() + "','" + userType + "','" + giftid + "') ");
                                            messageobject.status = "Success";
                                            msg = "Your Request Registered with US for points " + ptforrd;
                                        }
                                        string ClaimReq_date = SQL_DB.ExecuteScalar("select Claim_date from [ClaimDetails]  where right([ClaimDetails].Mobileno, 10) = '" + UserMobileNo + "' and [Isapproved] != 1 and Gift_id = '" + Log.ProductId.ToString() + "'").ToString();
                                        string ClaimReq_Username = SQL_DB.ExecuteScalar("select ConsumerName from [ClaimDetails]  where right([M_Consumer].MobileNo, 10) = '" + UserMobileNo + "' and [Comp_ID] ='Comp-1702' ").ToString();
                                        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                                     " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
                                     " <hr style='border:1px solid #2587D5;'/>" +
                                     " <div class='w_frame'>" +
                                     " <p>" +
                                     " <div class='w_detail'>" +
                                     " <span>Dear <em><strong>" + ClaimReq_Username + ",</strong></em></span><br />" +
                                     " <br />A new user with mobile number " + UserMobileNo + "  has claimed " + GiftName + "  on " + ClaimReq_date + " .<br />" +
                                     " <br />You can login to the dashboard to check the details and approve the claim.<br />" +
                                     " <p>" +
                                     " <div class='w_detail'>" +
                                     " Thank you,<br /><br />" +
                                     " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                                     " </div>" +
                                     " </p>" +
                                     " </div>" +
                                     " </p>" +
                                     " </div> " +
                                     " </div> ";

                                        DataSet dsMl = function9420.FetchMailDetail("support");
                                        if (dsMl.Tables[0].Rows.Count > 0)
                                        {
                                            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), "sales@vrkable.com", MailBody, "New Claim ");
                                        }
                                    }


                                    messageobject.message = msg;
                                }
                                else
                                {

                                    msg = "Company name not matched!";
                                    messageobject.status = "Unsuccess";
                                    messageobject.message = msg;
                                }
                            }
                            else
                            {
                                msg = "Condition point not matched!";
                                messageobject.status = "Unsuccess";
                                messageobject.message = msg;
                                //lblptmp.Text = lrp.ToString();
                                //lblptmm.Text = msg;
                                //lblptmm.Visible = true;
                                //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);
                            }
                        }
                        else
                        {
                            msg = "Please Uplaod the Documents first";
                            //lblptmp.Text = lrp.ToString();
                            messageobject.status = "Unsuccess";
                            messageobject.message = msg;
                            //lblptmm.Text = msg;
                            //lblptmm.Visible = true;
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + msg + "');", true);

                        }

                        //////////////////////////////////////////////////////////////
                    }
                    else
                    {
                        msg = "Points not available.";
                        messageobject.status = "Unsuccess";
                        messageobject.message = msg;
                    }
                }
                else
                {
                    msg = "KYC is is not approved.";
                    messageobject.status = "Unsuccess";
                    messageobject.message = msg;
                }
            }
            catch (Exception ex)
            {
                messageobject.status = "Unsuccess";
            }
            context.Response.Write(JsonConvert.SerializeObject(messageobject, Formatting.Indented));
        }



        else if (context.Request.QueryString["method"] == "ClaimHistoryVr")
        {
            try
            {
                string compid = context.Request.QueryString["compid"].ToString();
                string mobileNo = context.Request.QueryString["mobileNo"].ToString();

                DataTable dt = new DataTable();
                string query = "[USP_GetVRClaimHistory]";
                SqlCommand com = new SqlCommand();
                com.CommandText = query;
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@comppanyid", compid);
                com.Parameters.AddWithValue("@mobileno", mobileNo);
                com.Connection = dtcon.OpenConnection();
                SqlDataAdapter da = new SqlDataAdapter(com);
                DataSet Pds = new DataSet();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    var response = new { result = dt };
                    string json = JsonConvert.SerializeObject(response, Formatting.Indented);
                    context.Response.Write(json);
                }
                else
                {
                    var response = new { result = dt };
                    string json = JsonConvert.SerializeObject(response, Formatting.Indented);
                    context.Response.Write(json);
                }
            }
            catch (Exception e)
            {
                throw;
            }

            // string compid = context.Request.QueryString["compid"].ToString();
            // string mobileNo = context.Request.QueryString["mobileNo"].ToString();
            // DataTable table = new DataTable();
            //table = SQL_DB.ExecuteDataTable("select  format(Claim_date,'dd MMM yyyy HH:mm tt') as Claim_date,a.Amount, a.Isapproved ,a.Mobileno,b.Gift_name,b.Gift_value,b.Gift_desc,b.Stage,b.Gift_point,case when a.Isapproved='0' then 'VR Kable reviewing your claim, will infrom the status' when a.Isapproved='1' then 'VR Kable approved your claim' when a.Isapproved='2' then 'VR Kable rejected your claim, please contact for further information' end Msg from ClaimDetails as a, Claim_gift as b where a.Gift_id=b.gift_id  and a.Comp_id = b.CompID and  right(a.Mobileno,10) = '" + mobileNo.Substring(mobileNo.Length - 10, 10).ToString() + "' and a.Comp_id='" + compid + "' order by a.Row_id desc");
            // var response = new { result = table };
            // string json = JsonConvert.SerializeObject(response, Formatting.Indented);
            // context.Response.Write(json);
        }

        // --------------- Close VR Kable -------------------


    }



    // --------------- Start VR Kable -------------------


    public static string consumerlogin(string userid, string pass, int remember)
    {
        string result = "";
        User_Details Log = new User_Details();
        if (userid.ToUpper() == "ADMIN")
        {
            result = "Invalid userid or password !";
            return result;
        }
        else
        {
            string MobileNo = userid.Trim().Replace("'", "''");
            if (IsValid(userid.Trim().Replace("'", "''")))
                Log.DML = "Email";
            else
            {
                Log.DML = "Mobile";
                if (MobileNo.Contains("+"))
                {
                    MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
                }

                if (MobileNo.Length < 10 || MobileNo.Length > 13)
                {
                    result = "Please Enter Mobileno With Country Code";
                    return result;
                }

                /*
                 #region Find Actual Mobile No
                 if (MobileNo.Length < 10)
                 {
                     result = "Mobile No. must be 10 digits!";
                     return result;
                 }
                 if (MobileNo.Length == 11)
                 {
                     int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                     if (initial == 0)
                         MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
                     else
                     {
                         result = "Mobile No. Wrong!";
                         return result;
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
                         return result;
                     }
                 }
                 if (MobileNo.Length == 12)
                 {
                     int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
                     if (initial == 91)
                         MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
                     else
                     {
                         result = "Mobile No. Wrong!";
                         return result;
                     }
                 }
                 if (MobileNo.Length == 10)
                     MobileNo = "91" + MobileNo;
                 #endregion
                 */
            }
            Log.User_Type = "Consumer";
            Log.User_ID = MobileNo;
            Log.Password = pass.Trim().Replace("'", "''");
            DataTable dt = User_Details.GetUserLoginDetails(Log);
            if (dt.Rows.Count > 0)
            {
                if (remember == 1)
                {
                    HttpContext.Current.Response.Cookies["ConsumerUserName"].Value = Log.User_ID;
                    HttpContext.Current.Response.Cookies["ConsumerPassword"].Value = pass.Trim();
                    HttpContext.Current.Response.Cookies["ConsumerUserName"].Expires = DateTime.Now.AddDays(15);
                    HttpContext.Current.Response.Cookies["ConsumerPassword"].Expires = DateTime.Now.AddDays(15);

                    if (!string.IsNullOrEmpty(dt.Rows[0]["employeeID"].ToString()) && !string.IsNullOrEmpty(dt.Rows[0]["distributorID"].ToString()))
                    {
                        HttpContext.Current.Session["MMUser"] = "MMUSERR";
                    }
                    else { HttpContext.Current.Session["MMUser"] = ""; }

                    //string sQry = "Select * from M_Consumer Where MobileNo='" + MobileNo + "' and employeeID IS NOT NULL and distributorID IS NOT NULL";
                    //DataSet dsConsumer = SQL_DB.ExecuteDataSet(sQry);
                    //if (dsConsumer.Tables[0].Rows.Count > 0)
                    //{
                    //    HttpContext.Current.Session["MMUser"] = "MMUSERR";
                    //}
                }
                else if (remember == 0)
                {
                    HttpContext.Current.Response.Cookies["ConsumerUserName"].Value = null;
                    HttpContext.Current.Response.Cookies["ConsumerPassword"].Value = null;
                }
                //HttpContext.Current.Session["User_Type"] = "Consumer";
                HttpContext.Current.Session["USRID"] = dt.Rows[0]["User_ID"].ToString();
                HttpContext.Current.Session["Consumer_id"] = dt.Rows[0]["m_consumerid"].ToString();
                HttpContext.Current.Session["Comp_id"] = dt.Rows[0]["Comp_id"].ToString();

                ProjectSession.strUser_Type = "Consumer";
                ProjectSession.strConsumerUserID = dt.Rows[0]["User_ID"].ToString();
                ProjectSession.intM_ConsumeriD = Convert.ToInt32(dt.Rows[0]["M_ConsumeriD"]);
                if (dt.Rows[0]["ConsumerName"].ToString() != "")
                {
                    HttpContext.Current.Session["USRNAME"] = dt.Rows[0]["ConsumerName"].ToString();
                    ProjectSession.strConsumerName = dt.Rows[0]["ConsumerName"].ToString();

                }
                else
                    HttpContext.Current.Session["USRNAME"] = null;
                // HttpContext.Current.Session["USRMOBILENO"] = dt.Rows[0]["MobileNo"].ToString();
                ProjectSession.strMobileNo = dt.Rows[0]["MobileNo"].ToString();
                result = "success";// + "~" + dt.Rows[0]["MM"].ToString()
            }
            else
            {
                result = "Invalid userid or password !";
                return result;
            }
        }
        return result;
    }

    public static string VRConsumerRegister(string Name, string mobile, string pwd, string Role_ID, string Cin_number, string apistatus)
    {
        message_AddVrReg messageobject = new message_AddVrReg();
        string result = "";
        string ConsumerId = "";
        string M_Consumerid = "";
        string MobileNo10Digit = mobile;
        string userTypeName = "";
        LogManager.WriteExe("Enter");
        string MobileNo = mobile.Trim().Replace("'", "''");
        #region Find Actual Mobile No
        if ((Role_ID == "3" && Cin_number == "VRKABLE") || (Role_ID == "4" && Cin_number == "VRKABLE"))
        {
            result = "Invalid CIN number!";
            // return result;
            messageobject.status = apistatus;
            messageobject.result = result;
            messageobject.user_id = ConsumerId;
            messageobject.user_idnew = ConsumerId;
            return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
        }
        if (MobileNo.Length < 10)
        {
            result = "Mobile No. must be 10 digits!";
            // return result;
            messageobject.status = apistatus;
            messageobject.result = result;
            messageobject.user_id = ConsumerId;
            messageobject.user_idnew = ConsumerId;
            return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
        }
        if (MobileNo.Length == 11)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
                messageobject.status = apistatus;
                messageobject.result = result;
                messageobject.user_id = ConsumerId;
                messageobject.user_idnew = ConsumerId;
                return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
                //return result;
            }
        }
        if (MobileNo.Length == 13)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
                messageobject.status = apistatus;
                messageobject.result = result;
                messageobject.user_id = ConsumerId;
                messageobject.user_idnew = ConsumerId;
                return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
                //return result;
            }
        }
        if (MobileNo.Length == 12)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
            if (initial == 91)
                MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
            else
            {
                result = "Mobile No. Wrong!";
                //return result;
                messageobject.status = apistatus;
                messageobject.result = result;
                messageobject.user_id = ConsumerId;
                messageobject.user_idnew = ConsumerId;
                return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
            }
        }
        if (MobileNo.Length == 10)
            MobileNo = "91" + MobileNo;
        #endregion
        LogManager.WriteExe("Manage Mobile No.");
        /*  if (Role_ID == "2" || Role_ID == "1")
          {
              DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [M_Consumer] where [Email] = '" + email.Trim().Replace("'", "''") + "'");
              if (ds.Tables[0].Rows.Count > 0)
              {

                  result = "Email ID Already exist!";

                  messageobject.status = apistatus;
                  messageobject.result = result;
                  messageobject.user_id = ConsumerId;
                  messageobject.user_idnew = ConsumerId;
                  return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
              }
          }
          LogManager.WriteExe("Checking Email Complite");
              */
        DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT [MobileNo] FROM [M_Consumer] where [MobileNo] = '" + MobileNo + "' or [MobileNo] = '" + MobileNo10Digit + "'");
        if (ds1.Tables[0].Rows.Count > 0)
        {
            result = "Mobile No. Already registered!";
            // return result;
            messageobject.status = apistatus;
            messageobject.result = result;
            messageobject.user_id = ConsumerId;
            messageobject.user_idnew = ConsumerId;
            return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
        }
        string Ref_cin_number = "";
        if (Role_ID == "1")
        {
            userTypeName = "Dealers";
            Cin_number = ConsumerId;
            Ref_cin_number = "";
        }
        else if (Role_ID == "4")
        { // electrician
            userTypeName = "Electrician";
            Ref_cin_number = Cin_number;
            Cin_number = "";
        }
        else if (Role_ID == "3")
        { // counterboy
            userTypeName = "Counter Boy";
            Ref_cin_number = Cin_number;
            Cin_number = "";
        }
        else if (Role_ID == "2")
        { // retailer
            userTypeName = "Retailer";
            Ref_cin_number = Cin_number;
            Cin_number = ConsumerId;
        }

        if (Role_ID == "2" || Role_ID == "3" || Role_ID == "4")
        {
            DataSet ds5 = SQL_DB.ExecuteDataSet("SELECT [cin_number] FROM [M_Consumer] where [cin_number] = '" + Ref_cin_number + "'");
            if (ds5.Tables[0].Rows.Count < 1)
            {
                //string ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
                result = "CIN Number not exist!";
                //return result;
                messageobject.status = apistatus;
                messageobject.result = result;
                messageobject.user_id = ConsumerId;
                messageobject.user_idnew = ConsumerId;
                return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
            }
        }
        /*if (Role_ID == "2")
         {
             DataSet ds5 = SQL_DB.ExecuteDataSet("SELECT [cin_number] FROM [M_Consumer] where [cin_number] = '" + Ref_cin_number + "' and Vrkabel_User_Type = 2 ");
             if (ds5.Tables[0].Rows.Count >= 1)
             {
                 //string ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
                 result = "This CIN Number is already assign other retailer!";
                 //return result;
                 messageobject.status = apistatus;
                 messageobject.result = result;
                 messageobject.user_id = ConsumerId;
                 messageobject.user_idnew = ConsumerId;
                 return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
             }
         }
         */

        LogManager.WriteExe("Checking mobile no. Complite");
        User_Details Log = new User_Details();
        Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        Log.ConsumerName = Name.Trim().Replace("'", "''");
        // Log.Email = email.Trim().Replace("'", "''");
        Log.MobileNo = MobileNo;

        Log.Password = pwd.Trim().Replace("'", "''");
        Log.Role_ID_VRK = Role_ID;
        Log.Comp_id = "Comp-1400";

        Log.IsActive = 0;
        Log.IsDelete = 0;
        Log.DML = "I";
        User_Details.InsertUpdateUserDetails(Log);
        string CinNumber = "";
        DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[cin_number],[Vrkabel_User_Type],[M_Consumerid],case  when VRKbl_KYC_status='0' then 'Pending' when VRKbl_KYC_status='1' then 'Approved' when VRKbl_KYC_status='2' then 'Rejected' else 'Error'  end 'KYCStatus', format(Entry_Date, 'hh:mm tt dd MMM yyyy') as Entry_Date FROM [M_Consumer] where [MobileNo] = '" + MobileNo + "'");

        if (dcs.Tables[0].Rows.Count > 0)
        {
            //  string M_Consumerid = "";
            apistatus = "200";
            result = "success";
            ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
            M_Consumerid = dcs.Tables[0].Rows[0]["M_Consumerid"].ToString();
            int kycStatus = 0;
            /*
        DataSet ds11 = SQL_DB.ExecuteDataSet("SELECT [Bank_ID] FROM [M_BankAccount] where  [M_Consumerid] = '" + M_Consumerid + "'");
        if (ds11.Tables[0].Rows.Count < 1)
        {
            DataSet ds2 = SQL_DB.ExecuteDataSet("SELECT top 1 [Bank_ID] FROM [M_BankAccount] order by Row_ID desc");
            string bankidd = ds2.Tables[0].Rows[0]["Bank_ID"].ToString();
            string test1 = bankidd.Substring(3, 4);
            int bnkidnew = Convert.ToInt32(test1) + 1;
            //string bnkidnewGenrate = bankidd.Substring(0, 3)+bnkidnew;
            string bnkidnewGenrate = "ACC" + M_Consumerid;
            string datecurrent = Convert.ToDateTime(DateTime.Today.ToShortDateString()).ToString("yyyy-MM-dd HH:mm:ss.fff");
            SQL_DB.ExecuteNonQuery("INSERT INTO M_BankAccount (Bank_ID,M_Consumerid,Entry_Date,chkPassbook) values('" + bnkidnewGenrate + "','" + M_Consumerid + "','"+datecurrent+"','/img/BankDocuments/default.jpg')");
        }
        */
            if (Role_ID == "1" || Role_ID == "2")
            {
                CinNumber = ConsumerId.ToString();
                // SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [cin_number] = '" + ConsumerId + "' WHERE [User_ID] = '" + ConsumerId + "'");
                // var strrr = "UPDATE [M_Consumer] SET [cin_number] = '" + ConsumerId + "',[Vrkabel_User_Type]='" + Role_ID + "',[ref_cin_number]='" + Ref_cin_number + "' WHERE [M_Consumerid] = '" + ConsumerId + "'";
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [cin_number] = '" + ConsumerId + "',[Vrkabel_User_Type]='" + Role_ID + "',[ref_cin_number]='" + Ref_cin_number + "',[VRKbl_KYC_status]='" + kycStatus + "' WHERE [M_Consumerid] = '" + M_Consumerid + "'");
            }
            else
            {
                CinNumber = Cin_number.ToString();
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [Vrkabel_User_Type]='" + Role_ID + "',[cin_number]='" + Cin_number + "',[ref_cin_number]='" + Ref_cin_number + "',[VRKbl_KYC_status]='" + kycStatus + "' WHERE [M_Consumerid] = '" + M_Consumerid + "'");
            }


            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
    " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
    " <hr style='border:1px solid #2587D5;'/>" +
    " <div class='w_frame'>" +
    " <p>" +
    " <div class='w_detail'>" +
    " <span>Dear <em><strong>" + Log.ConsumerName + ",</strong></em></span><br />" +
    " <br />A new user with mobile number " + Log.MobileNo + " has registered as " + userTypeName + "  on " + dcs.Tables[0].Rows[0]["Entry_Date"].ToString() + " .<br />" +
    " <br />You can login to the dashboard to check the details.<br />" +
    //" <span>Thanks for registration with us</span><br />" +
    // " Your Login Credentials  <br /> <strong> User Id - " + Log.Email + "</strong><br /> <strong> Password - " + Log.Password + "</strong>  " +
    //"<br /><br /> We will contact you soon.   <br />" +
    " <p>" +
    " <div class='w_detail'>" +
    " Thank you,<br /><br />" +
    " Team <em><strong>VCQRU.COM,</strong></em><br />" +
    "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
    " </div>" +
    " </p>" +
    " </div>" +
    " </p>" +
    " </div> " +
    " </div> ";

            DataSet dsMl = function9420.FetchMailDetail("support");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), "sales@vrkable.com", MailBody, "New user Registartion");
            }
        }
        messageobject.status = apistatus;
        messageobject.result = result;
        messageobject.user_id = ConsumerId;
        messageobject.user_idnew = ConsumerId;
        messageobject.communication_status = "0";
        messageobject.business_status = "0";
        messageobject.userTypeName = userTypeName;
        messageobject.name = Name;
        messageobject.kycStatus = dcs.Tables[0].Rows[0]["KYCStatus"].ToString();
        messageobject.entryDate = dcs.Tables[0].Rows[0]["Entry_Date"].ToString();
        //messageobject.user_type = dcs.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString(); 
        messageobject.user_type = Role_ID;
        messageobject.cin_number = CinNumber.ToString();
        messageobject.mobile_number = mobile;
        messageobject.m_consumerid = M_Consumerid;
        return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
        //result = "<b>Dear " + Name + "</b><br/>Thanks for registering with us. <br/><br/> <b> Thank you,</b> <br/> Team: VCQRU.COM <br/> " + ProjectSession.sales_accomplishtrades + " ";
        // return result;

    }
    public static string DeleteTestCode(string code1, string code2)
    {
        DataSet dcs = new DataSet();
        message_Vrkabel messageobject = new message_Vrkabel();
        string result = "Invalid Code";
        string apistatus = "400";
        code1 = code1.Trim().Replace("'", "''");
        code2 = code2.Trim().Replace("'", "''");
        dcs = SQL_DB.ExecuteDataSet("SELECT IsDelete FROM [Pro_Enq] where Received_Code1='" + code1 + "' and Received_Code2='" + code2 + "'");
        if (dcs.Tables[0].Rows.Count > 0)
        {

            string Additional = System.DateTime.Now.ToString("yyMMddHH");
            SQL_DB.ExecuteNonQuery("Update Pro_Enq set IsDelete=1,IsActive=1 where Received_Code1='" + code1 + "' and Received_Code2='" + code2 + "'");
            apistatus = "200";
            result = "success";
            messageobject.status = apistatus;
            messageobject.result = result;
            return JsonConvert.SerializeObject(messageobject, Formatting.Indented);

        }
        else
        {
            apistatus = "400";
            result = "Invalid Code";
            messageobject.status = apistatus;
            messageobject.result = result;
            return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
        }

    }

    public static string DeleteAccountVRkabel(string mobile, string mode)
    {
        DataSet dcs = new DataSet();
        message_Vrkabel messageobject = new message_Vrkabel();
        string result = "This account is not registered with us!";
        string apistatus = "400";
        string MobileNo = mobile.Trim().Replace("'", "''");
        MobileNo = mobile.Substring(mobile.Length - 10, 10).ToString();

        dcs = SQL_DB.ExecuteDataSet("SELECT [mobileno] FROM [M_Consumer] where right([MobileNo],10)='" + mobile.Substring(mobile.Length - 10, 10) + "'  and Comp_id='Comp-1400' ");
        if (dcs.Tables[0].Rows.Count > 0)
        {
            string Additional = System.DateTime.Now.ToString("yyMMddHH");
            SQL_DB.ExecuteNonQuery("Update M_Consumer  set IsDelete=1,IsActive=1,remark='" + mode + "', mobileno='VR91" + mobile.Substring(mobile.Length - 10, 10) + "K' ,Additional='" + Additional + "DelVRKabl' where right([MobileNo],10)='" + mobile.Substring(mobile.Length - 10, 10) + "' and Comp_id='Comp-1400'");
            apistatus = "200";
            result = "success";
            messageobject.status = apistatus;
            messageobject.result = result;
            return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
        }
        else
        {
            result = "This account is not registered with us.!";
            messageobject.status = apistatus;
            messageobject.result = result;
            return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
        }

    }
    public static string consumerloginVRkabel(string mobile, string pass)
    {
        DataSet dcs = new DataSet();
        message_AddVrReg messageobject = new message_AddVrReg();
        string result = "";
        string ConsumerId = "";
        string apistatus = "400";
        string id = "";
        string name = "";
        string userTypeName = "";
        // LogManager.WriteExe("Enter");
        string MobileNo = mobile.Trim().Replace("'", "''");
        // #region Find Actual Mobile No
        if (MobileNo.Length < 10)
        {
            result = "Mobile No. must be 10 digits!";
            // return result;
            messageobject.status = apistatus;
            messageobject.result = result;
            messageobject.user_id = ConsumerId;
            messageobject.user_idnew = ConsumerId;
            return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
        }
        if (MobileNo.Length == 11)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
                messageobject.status = apistatus;
                messageobject.result = result;
                messageobject.user_id = ConsumerId;
                messageobject.user_idnew = ConsumerId;
                return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
            }
        }
        if (MobileNo.Length == 13)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
                messageobject.status = apistatus;
                messageobject.result = result;
                messageobject.user_id = ConsumerId;
                messageobject.user_idnew = ConsumerId;
                return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
            }
        }
        if (MobileNo.Length == 12)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
            if (initial == 91)
                MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
            else
            {
                result = "Mobile No. Wrong!";
                messageobject.status = apistatus;
                messageobject.result = result;
                messageobject.user_id = ConsumerId;
                messageobject.user_idnew = ConsumerId;
                return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
            }
        }
        if (MobileNo.Length == 10)
        {
            MobileNo = "91" + MobileNo;
        }
        dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[ConsumerName],[M_Consumerid],[Vrkabel_User_Type],[cin_number],[communication_status],[business_status] FROM [M_Consumer] where [MobileNo] = '" + MobileNo + "' and [Password] = '" + pass + "' ");
        if (dcs.Tables[0].Rows.Count > 0)
        {


            if (dcs.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString() == "1")
            { // dealer
                userTypeName = "Dealer";
            }
            else if (dcs.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString() == "2")
            { // retailer
                userTypeName = "Retailer";
            }
            else if (dcs.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString() == "3")
            { // Counter boy
                userTypeName = "Counter Boy";
            }
            else if (dcs.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString() == "4")
            { // Electriction
                userTypeName = "Electrician";
            }

            string communication_status = "";
            if (dcs.Tables[0].Rows[0]["communication_status"].ToString() == "1")
            { // Electriction
                communication_status = "1";
            }
            else
            {
                communication_status = "0";
            }

            string business_status = "";
            if (dcs.Tables[0].Rows[0]["business_status"].ToString() == "1")
            { // Electriction
                business_status = "1";
            }
            else
            {
                business_status = "0";
            }

            apistatus = "200";
            result = "success";
            ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
            // Vrkabel_User_Type = dcs.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString();

            messageobject.status = apistatus;
            messageobject.result = result;
            messageobject.user_id = ConsumerId;
            messageobject.id = ConsumerId;
            messageobject.name = dcs.Tables[0].Rows[0]["ConsumerName"].ToString();
            messageobject.user_idnew = ConsumerId;
            messageobject.user_type = dcs.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString();
            // messageobject.profile_status = int 1;
            messageobject.communication_status = communication_status;
            messageobject.business_status = business_status;
            messageobject.cin_number = dcs.Tables[0].Rows[0]["cin_number"].ToString();
            messageobject.userTypeName = userTypeName;
            messageobject.mobile_number = MobileNo;
            messageobject.m_consumerid = dcs.Tables[0].Rows[0]["M_Consumerid"].ToString();


            return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
        }
        else
        {
            result = "400";
            messageobject.status = apistatus;
            messageobject.result = result;
            messageobject.user_id = ConsumerId;
            messageobject.user_idnew = ConsumerId;
            return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
        }
        //return result;
    }

    public static string forgotpasswordVrKabel(string mobile)
    {
        string result = "";
        User_Details Log = new User_Details();
        msg_Vrkabel messageobject = new msg_Vrkabel();
        if (mobile.ToUpper() == "ADMIN")
        {
            result = "Invalid user id or password !";
            messageobject.status = "400";
            messageobject.result = result;
            return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
            //return result;
        }
        else
        {
            string MobileNo = mobile.Trim().Replace("'", "''");
            if (IsValid(mobile.Trim().Replace("'", "''")))
            {
                Log.DML = "Email";
            }
            else
            {
                Log.DML = "Mobile";
                #region Find Actual Mobile No
                if (MobileNo.Length < 10)
                {
                    result = "Mobile No. must be 10 digits!";
                    messageobject.status = "400";
                    messageobject.result = result;
                    return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
                    //return result;
                }
                if (MobileNo.Length == 11)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        messageobject.status = "400";
                        messageobject.result = result;
                        return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
                        //return result;
                    }
                }
                if (MobileNo.Length == 13)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        messageobject.status = "400";
                        messageobject.result = result;
                        return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
                        //return result;
                    }
                }
                if (MobileNo.Length == 12)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
                    if (initial == 91)
                        MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        messageobject.status = "400";
                        messageobject.result = result;
                        return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
                        //return result;
                    }
                }
                if (MobileNo.Length == 10)
                    MobileNo = "91" + MobileNo;
                #endregion
            }
            Log.User_Type = "Consumer";
            Log.User_ID = MobileNo;
            DataTable dt = new DataTable();
            if (Log.DML == "Mobile")
                dt = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] WHERE  [MobileNo] = '" + MobileNo + "' and IsDelete=0").Tables[0];
            else if (Log.DML == "Email")
                dt = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] WHERE  [Email] = '" + MobileNo + "' and IsDelete=0").Tables[0];
            if (dt.Rows.Count > 0)
            {
                string email = dt.Rows[0]["Email"].ToString();
                string forgetpass = dt.Rows[0]["Password"].ToString();
                if (dt.Rows[0]["Password"].ToString().Length > 15)
                {
                    forgetpass = Decrypt(dt.Rows[0]["Password"].ToString());
                }

                if (email != "")
                {
                    //string ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
                    string pass = dt.Rows[0]["Password"].ToString();
                    string MailBody = "";
                    MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                                               " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
                                               " <hr style='border:1px solid #2587D5;'/>" +
                                               " <div class='w_frame'>" +
                                               " <p>" +
                                               " <div class='w_detail'>" +
                                               " <span>Dear <em><strong> " + dt.Rows[0]["ConsumerName"].ToString() + ",</strong></em></span><br />" +
                                               " <br />" +
                                               " <span>Login to https://www.qa.vcqru.com/login.aspx#logsign </span><br />" +
                                               " Password - " + forgetpass + "</strong>  " +
                                               " <p>" +
                                               " <div class='w_detail'>" +
                                               " Assuring you  of  our best services always.<br />" +
                                               " Thank you,<br /><br />" +
                                               " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                                               "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                                               " </div>" +
                                               " </p>" +
                                               " </div>" +
                                               " </p>" +
                                               " </div> " +
                                               " </div> ";

                    DataSet dsMl = function9420.FetchMailDetail("support");
                    if (dsMl.Tables[0].Rows.Count > 0)
                    {
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
                            email, MailBody, "Forget Password");

                    }



                    ServiceLogic.SendSms("Your VCQRU_ID: " + MobileNo + " & PWD: " + forgetpass.ToString() + " Visit https://www.vcqru.com/login.aspx & complete your profile", "+" + MobileNo);
                    // result = "Your password is send sms to Mobile No. xxxxxxx" + MobileNo.Substring(9, 3) + " and Email!";
                    result = "Your password is send to registerd Email Id / Mobile Number!";
                    messageobject.status = "200";
                    messageobject.result = result;
                    return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
                }
                else
                {
                    ServiceLogic.SendSms("Your VCQRU_ID: " + MobileNo + " & PWD: " + dt.Rows[0]["Password"].ToString() + " Visit https://www.vcqru.com/login.aspx & complete your profile", "+" + MobileNo);
                    //result = "Your password is send sms to Mobile No. xxxxxxx" + MobileNo.Substring(9, 3);
                    result = "Password sent successfully.";
                    messageobject.status = "200";
                    messageobject.result = result;
                    return JsonConvert.SerializeObject(messageobject, Formatting.Indented);

                }
            }
            else
            {
                result = "Your user id is invalid!";
                messageobject.status = "400";
                messageobject.result = result;
                return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
            }
        }
        messageobject.status = "200";
        messageobject.result = result;
        return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
        //return result;
    }

    public static string profileUpdateVR(string userid, string name, string email, string Designation, string DOB, string Gender, string Sur_name)
    {
        message_Vrkabel messageobject = new message_Vrkabel();
        string result = "";
        string status = "";
        string message = "";
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [User_ID],[M_Consumerid] FROM [M_Consumer] where  [M_Consumerid] = '" + userid + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [ConsumerName] = '" + name + "', [Email] = '" + email + "',[designation] = '" + Designation + "',[dob] = '" + DOB + "',[gender] = '" + Gender + "',[sur_name] = '" + Sur_name + "' WHERE [M_Consumerid] = '" + ds.Tables[0].Rows[0]["M_Consumerid"].ToString() + "'");
            //result = "Password has been changed successfully.";
            status = "200";
            result = "success";
            message = "Profile updated";
        }
        else
        {
            status = "400";
            result = "false";
            message = "Error!";
        }

        messageobject.status = status;
        messageobject.message = message;
        messageobject.result = result;
        return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
    }
    public static string profileCommunication(string userid, string pin_code, string house_number, string land_mark, string state, string district, string city)
    {
        message_Vrkabel messageobject = new message_Vrkabel();
        string result = "";
        string status = "";
        string message = "";
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [M_Consumerid] FROM [M_Consumer] where  [M_Consumerid] = '" + userid + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [PinCode] = '" + pin_code + "',[state] = '" + state + "',[district] = '" + district + "',[City] = '" + city + "',[house_number] = '" + house_number + "',[village] = '" + land_mark + "',[communication_status] = '1' WHERE [M_Consumerid] = '" + ds.Tables[0].Rows[0]["M_Consumerid"].ToString() + "'");
            //result = "Password has been changed successfully.";
            status = "200";
            result = "success";
            message = "Profile updated";
        }
        else
        {
            status = "400";
            result = "false";
            message = "Error!";
        }

        messageobject.status = status;
        messageobject.message = message;
        messageobject.result = result;
        return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
    }
    public static string profileBusiness(string userid, string owner_number, string shop_name, string aadhar_number, string pancard_number, string gst_number)
    {
        string business_status = "1";
        message_Vrkabel messageobject = new message_Vrkabel();
        string result = "";
        string status = "";
        string message = "";
        string cinNumber = "";
        string M_Consumerid = "";

        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [User_ID],[cin_number],[M_Consumerid] FROM [M_Consumer] where  [M_Consumerid] = '" + userid + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [owner_number] = '" + owner_number + "',[shop_name] = '" + shop_name + "',[aadharNumber] = '" + aadhar_number + "',[pancard_number] = '" + pancard_number + "',[gst_number] = '" + gst_number + "',[business_status] = '" + business_status + "' WHERE [M_Consumerid] = '" + ds.Tables[0].Rows[0]["M_Consumerid"].ToString() + "'");
            status = "200";
            result = "success";
            message = "Profile updated";
            cinNumber = ds.Tables[0].Rows[0]["cin_number"].ToString();
            M_Consumerid = ds.Tables[0].Rows[0]["M_Consumerid"].ToString();

            DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT [Bank_ID] FROM [M_BankAccount] where  [M_Consumerid] = '" + M_Consumerid + "'");
            if (ds1.Tables[0].Rows.Count < 1)
            {
                DataSet ds2 = SQL_DB.ExecuteDataSet("SELECT top 1 [Bank_ID] FROM [M_BankAccount] order by Row_ID desc");
                string bankidd = ds2.Tables[0].Rows[0]["Bank_ID"].ToString();
                string test1 = bankidd.Substring(3, 4);
                int bnkidnew = Convert.ToInt32(test1) + 1;
                //string bnkidnewGenrate = bankidd.Substring(0, 3)+bnkidnew;
                string bnkidnewGenrate = "ACC" + M_Consumerid;
                string datecurrent = Convert.ToDateTime(DateTime.Today.ToShortDateString()).ToString("yyyy-MM-dd HH:mm:ss.fff");
                SQL_DB.ExecuteNonQuery("INSERT INTO M_BankAccount (Bank_ID,M_Consumerid,Entry_Date,chkPassbook) values('" + bnkidnewGenrate + "','" + M_Consumerid + "','" + datecurrent + "','/img/BankDocuments/default.jpg')");
            }
            status = "200";
            result = "success";
            message = "Profile updated";
            cinNumber = ds.Tables[0].Rows[0]["cin_number"].ToString();

            //mail-
            DataSet dsVr = SQL_DB.ExecuteDataSet("SELECT ConsumerName, MobileNo, Entry_Date, aadharNumber, aadharback, aadharFile, Vrkabel_User_Type, pancard_number, pan_card_file, shop_file, VRKbl_KYC_status FROM [M_Consumer] where  [M_Consumerid] = '" + userid + "'");
            if (dsVr.Tables[0].Rows.Count > 0)
            {
                string Entry_Date = dsVr.Tables[0].Rows[0]["Entry_Date"].ToString();
                string MobileNo = dsVr.Tables[0].Rows[0]["MobileNo"].ToString();
                string ConsumerName = dsVr.Tables[0].Rows[0]["ConsumerName"].ToString();
                string VRKbl_KYC_status = dsVr.Tables[0].Rows[0]["VRKbl_KYC_status"].ToString();
                string Vrkabel_User_Type = dsVr.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString();
                string pan_card_file = dsVr.Tables[0].Rows[0]["pan_card_file"].ToString();
                string shop_file = dsVr.Tables[0].Rows[0]["shop_file"].ToString();
                string aadharback = dsVr.Tables[0].Rows[0]["aadharback"].ToString();
                string aadharFile = dsVr.Tables[0].Rows[0]["aadharFile"].ToString();
                if ((Vrkabel_User_Type == "1" && VRKbl_KYC_status != "1" && aadharback.ToString().Length > 5 && aadharFile.Length > 5 && pan_card_file.Length > 5) || (Vrkabel_User_Type == "2" && VRKbl_KYC_status != "1" && pan_card_file.Length > 5 && shop_file.Length > 5) || ((Vrkabel_User_Type == "3" || Vrkabel_User_Type == "4") && VRKbl_KYC_status != "1" && aadharback.ToString().Length > 5 && aadharFile.Length > 5 && pan_card_file.Length > 5))
                {
                    string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                   " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
                   " <hr style='border:1px solid #2587D5;'/>" +
                   " <div class='w_frame'>" +
                   " <p>" +
                   " <div class='w_detail'>" +
                   " <span>Dear <em><strong>" + ConsumerName + ",</strong></em></span><br />" +
                   " <br />A new user with mobile number " + MobileNo + " has submitted the KYC details  on " + Entry_Date + " .<br />" +
                   " <br />You can login to the dashboard to check the details and approve the user KYC.<br />" +
                   " <p>" +
                   " <div class='w_detail'>" +
                   " Thank you,<br /><br />" +
                   " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                   "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                   " </div>" +
                   " </p>" +
                   " </div>" +
                   " </p>" +
                   " </div> " +
                   " </div> ";

                    DataSet dsMl = function9420.FetchMailDetail("support");
                    if (dsMl.Tables[0].Rows.Count > 0)
                    {
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), "sales@vrkable.com", MailBody, "User KYC");
                    }
                }
            }

        }
        else
        {
            status = "400";
            result = "false";
            message = "Error!";
            cinNumber = "";
        }

        messageobject.status = status;
        messageobject.message = message;
        messageobject.result = result;
        messageobject.cinNumber = cinNumber;
        return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
    }
    public static string dealerloginVRkabel(string cinNumber)
    {
        DataSet dcs = new DataSet();
        message_AddVrReg messageobject = new message_AddVrReg();
        string result = "";
        string ConsumerId = "";
        string apistatus = "";
        string id = "";
        string name = "";
        //string cin_number = "";
        string userTypeName = "";
        // LogManager.WriteExe("Enter");
        string cin_number = cinNumber.Trim().Replace("'", "''");
        // #region Find Actual Mobile No

        dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[ConsumerName],[Vrkabel_User_Type],[cin_number],[communication_status],[business_status],[MobileNo] FROM [M_Consumer] where [cin_number] = '" + cin_number + "' and Vrkabel_User_Type='1' ");
        if (dcs.Tables[0].Rows.Count > 0)
        {
            if (dcs.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString() == "1")
            { // dealer
                userTypeName = "Dealers";
            }
            else if (dcs.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString() == "2")
            { // retailer
                userTypeName = "Retailer";
            }
            else if (dcs.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString() == "3")
            { // Counter boy
                userTypeName = "Counter Boy";
            }
            else if (dcs.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString() == "4")
            { // Electriction
                userTypeName = "Electrician";
            }
            string communication_status = "";

            if (dcs.Tables[0].Rows[0]["communication_status"].ToString() == "1")
            { // Electriction
                communication_status = "1";
            }
            else
            {
                communication_status = "0";
            }


            string business_status = "";
            if (dcs.Tables[0].Rows[0]["business_status"].ToString() == "1")
            { // Electriction
                business_status = "1";
            }
            else
            {
                business_status = "0";
            }

            apistatus = "200";
            result = "success";
            ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
            // Vrkabel_User_Type = dcs.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString();

            messageobject.status = apistatus;
            messageobject.result = result;
            messageobject.user_id = ConsumerId;
            messageobject.id = ConsumerId;
            messageobject.name = dcs.Tables[0].Rows[0]["ConsumerName"].ToString();
            messageobject.user_type = dcs.Tables[0].Rows[0]["Vrkabel_User_Type"].ToString();
            // messageobject.profile_status = int 1;
            messageobject.communication_status = communication_status;
            messageobject.business_status = business_status;
            messageobject.cin_number = dcs.Tables[0].Rows[0]["cin_number"].ToString();
            messageobject.userTypeName = userTypeName;
            messageobject.mobile_number = dcs.Tables[0].Rows[0]["MobileNo"].ToString();


            return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
        }
        else
        {
            result = "Enter correct deler CIN Number";
            messageobject.status = apistatus;
            messageobject.result = result;
            messageobject.user_id = ConsumerId;
            return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
        }
        //return result;
    }
    public static string UploadVrkabelFile(string imgpath, string UserId, string filetype)
    {
        message_Vrkabel messageobject = new message_Vrkabel();

        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [User_ID] FROM [M_Consumer] where  [User_ID] = '" + UserId + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            if (filetype == "AadharFront")
            {
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [aadharFile] = '" + imgpath + "' WHERE [User_ID] = '" + ds.Tables[0].Rows[0]["User_ID"].ToString() + "'");
            }
            else if (filetype == "AadharBack")
            {
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [aadharback] = '" + imgpath + "' WHERE [User_ID] = '" + ds.Tables[0].Rows[0]["User_ID"].ToString() + "'");
            }
            else if (filetype == "Pancard")
            {
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [pan_card_file] = '" + imgpath + "' WHERE [User_ID] = '" + ds.Tables[0].Rows[0]["User_ID"].ToString() + "'");
            }
            else if (filetype == "shopFile")
            {
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [shop_file] = '" + imgpath + "' WHERE [User_ID] = '" + ds.Tables[0].Rows[0]["User_ID"].ToString() + "'");
            }
            else if (filetype == "Profileimg")
            {
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [profile_image] = '" + imgpath + "' WHERE [User_ID] = '" + ds.Tables[0].Rows[0]["User_ID"].ToString() + "'");
            }
            else if (filetype == "PassbookDocs")
            {
                SQL_DB.ExecuteNonQuery("UPDATE M_BankAccount SET chkPassbook = '" + imgpath + "' where M_Consumerid in (select M_Consumerid from M_Consumer WHERE [User_ID] = '" + ds.Tables[0].Rows[0]["User_ID"].ToString() + "')");
            }
            else if (filetype == "AddressProof")
            {
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [AddressProof] = '" + imgpath + "' WHERE [User_ID] = '" + ds.Tables[0].Rows[0]["User_ID"].ToString() + "'");
            }
            else if (filetype == "UpiidImage")
            {
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [UpiidImage] = '" + imgpath + "' WHERE [User_ID] = '" + ds.Tables[0].Rows[0]["User_ID"].ToString() + "'");
            }
            else if (filetype == "Selfie")
            {
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [Selfie_image] = '" + imgpath + "' WHERE [User_ID] = '" + ds.Tables[0].Rows[0]["User_ID"].ToString() + "'");
            }

        }
        else
        {
            //return  "Error";
            //status = "400";
            //result = "false";
            //message = "Error!";
        }
        return imgpath;

    }
    // --------------- Close VR Kable -------------------



    public static string DealerRegister(string Name, string email, string mobile, string City, string Pin, string pwd, string loc, string type)
    {
        string result = "";
        LogManager.WriteExe("Enter");
        string MobileNo = mobile.Trim().Replace("'", "''");
        #region Find Actual Mobile No
        if (MobileNo.Length < 10)
        {
            result = "Mobile No. must be 10 digits!";
            return result;
        }
        if (MobileNo.Length == 11)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
                return result;
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
                return result;
            }
        }
        if (MobileNo.Length == 12)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
            if (initial == 91)
                MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
            else
            {
                result = "Mobile No. Wrong!";
                return result;
            }
        }
        if (MobileNo.Length == 10)
            MobileNo = "91" + MobileNo;
        #endregion
        LogManager.WriteExe("Manage Mobile No.");
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [Dealer] where [Email] = '" + email.Trim().Replace("'", "''") + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            result = "Email ID Already exist!";
            return result;
        }
        LogManager.WriteExe("Checking Email Complite");
        DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT [MobileNo] FROM [Dealer] where [MobileNo] = '" + MobileNo + "'");
        if (ds1.Tables[0].Rows.Count > 0)
        {
            result = "Mobile No. Already exist!";
            return result;
        }
        LogManager.WriteExe("Checking mobile no. Complite");
        User_Details Log = new User_Details();
        Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        Log.ConsumerName = Name.Trim().Replace("'", "''");
        Log.Email = email.Trim().Replace("'", "''");
        Log.MobileNo = MobileNo;
        Log.City = loc.Trim().Replace("'", "''"); //City.Trim().Replace("'", "''");
        Log.PinCode = Pin.Trim().Replace("'", "''");
        Log.Password = pwd.Trim().Replace("'", "''");
        Log.User_Type = type;
        Log.IsActive = 1;
        Log.IsDelete = 0;
        Log.DML = "I";
        SQL_DB.ExecuteNonQuery("insert into Dealer([name],[Email],[mobileno],[pwd],[Location],[Type],[createddate],[active]) " +
            "values ('" + Log.ConsumerName + "','" + Log.Email + "','" + Log.MobileNo + "','" + Log.Password + "','" + Log.City + "'," +
            " " + Log.User_Type + ",'" + System.DateTime.Now.ToString("MM/dd/yyyy") + "'," + Log.IsActive + ")");
        // check is there in db - if mobile no exists then update
        // User_Details.InsertUpdateUserDetails(Log);
        result = "<b>Dear " + Name + "</b><br/>Thanks for registering with us. <br/><br/> <b> Thank you,</b> <br/> Team: VCQRU.COM <br/> " + ProjectSession.sales_accomplishtrades + " ";
        return result;
    }
    public static string ConsumerRegister(string Name, string email, string mobile, string City, string Pin, string pwd)
    {
        string result = "";
        LogManager.WriteExe("Enter");
        string MobileNo = mobile.Trim().Replace("'", "''");
        #region Find Actual Mobile No
        if (MobileNo.Length < 10)
        {
            result = "Mobile No. must be 10 digits!";
            return result;
        }
        if (MobileNo.Length == 11)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
                return result;
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
                return result;
            }
        }
        if (MobileNo.Length == 12)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
            if (initial == 91)
                MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
            else
            {
                result = "Mobile No. Wrong!";
                return result;
            }
        }
        if (MobileNo.Length == 10)
            MobileNo = "91" + MobileNo;
        #endregion
        LogManager.WriteExe("Manage Mobile No.");
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [M_Consumer] where [Email] = '" + email.Trim().Replace("'", "''") + "' and IsDelete=0");
        if (ds.Tables[0].Rows.Count > 0)
        {
            result = "Email ID Already exist!";
            return result;
        }
        LogManager.WriteExe("Checking Email Complite");
        DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT [MobileNo] FROM [M_Consumer] where [MobileNo] = '" + MobileNo + "' and IsDelete=0");
        if (ds1.Tables[0].Rows.Count > 0)
        {
            result = "Mobile No. Already exist!";
            return result;
        }
        LogManager.WriteExe("Checking mobile no. Complite");
        User_Details Log = new User_Details();
        Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        Log.ConsumerName = Name.Trim().Replace("'", "''");
        Log.Email = email.Trim().Replace("'", "''");
        Log.MobileNo = MobileNo;
        Log.City = City.Trim().Replace("'", "''");
        Log.PinCode = Pin.Trim().Replace("'", "''");
        Log.Password = pwd.Trim().Replace("'", "''");
        Log.IsActive = 0;
        Log.IsDelete = 0;
        Log.DML = "I";
        // check is there in db - if mobile no exists then update
        User_Details.InsertUpdateUserDetails(Log);
        result = "<b>Dear " + Name + "</b><br/> Thanks for registration with us. <br/><br/> <b> Thank you,</b> <br/> Team: VCQRU.COM <br/> " + ProjectSession.sales_accomplishtrades + " ";
        return result;
    }

    public static string EmployeeRegister(string Etype, string Name, string email, string mobile, string City, string Pin, string pwd)
    {
        string result = "";
        LogManager.WriteExe("Enter");
        string MobileNo = mobile.Trim().Replace("'", "''");
        #region Find Actual Mobile No
        if (MobileNo.Length < 10)
        {
            result = "Mobile No. must be 10 digits!";
            return result;
        }
        if (MobileNo.Length == 11)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                result = "Mobile No. Wrong!";
                return result;
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
                return result;
            }
        }
        if (MobileNo.Length == 12)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
            if (initial == 91)
                MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
            else
            {
                result = "Mobile No. Wrong!";
                return result;
            }
        }
        if (MobileNo.Length == 10)
            MobileNo = "91" + MobileNo;
        #endregion
        LogManager.WriteExe("Manage Mobile No.");
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [Employee] where [Email] = '" + email.Trim().Replace("'", "''") + "' and IsDelete=0");
        if (ds.Tables[0].Rows.Count > 0)
        {
            result = "Email ID Already exist!";
            return result;
        }
        LogManager.WriteExe("Checking Email Complite");
        DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT [MobileNo] FROM [Employee] where [MobileNo] = '" + MobileNo + "' and IsDelete=0");
        if (ds1.Tables[0].Rows.Count > 0)
        {
            result = "Mobile No. Already exist!";
            return result;
        }
        LogManager.WriteExe("Checking mobile no. Complite");
        User_Details Log = new User_Details();
        Log.EmployeeType = Convert.ToInt16(Etype);
        Log.Address = "";
        Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        Log.ConsumerName = Name.Trim().Replace("'", "''");
        Log.Email = email.Trim().Replace("'", "''");
        Log.MobileNo = MobileNo;
        Log.City = City.Trim().Replace("'", "''");
        Log.PinCode = Pin.Trim().Replace("'", "''");
        Log.Password = pwd.Trim().Replace("'", "''");
        Log.IsActive = 1;
        Log.IsDelete = 0;
        Log.DML = "I";
        // check is there in db - if mobile no exists then update
        //User_Details.InsertUpdateUserDetails(Log);
        ExecuteNonQueryAndDatatable.InsertEmployeeDetails(Log);


        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + Log.ConsumerName + ",</strong></em></span><br />" +
        " <br />" +
        " <span>Thanks for registration with us</span><br />" +
        " Your Login Credentials  <br /> <strong> User Id - " + Log.Email + "</strong><br /> <strong> Password - " + Log.Password + "</strong>  " +
        "<br /><br /> We will contact you soon.   <br />" +
        " <p>" +
        " <div class='w_detail'>" +
        " Assuring you  of  our best services always.<br />" +
        " Thank you,<br /><br />" +
        " Team <em><strong>VCQRU.COM,</strong></em><br />" +
        "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";

        DataSet dsMl = function9420.FetchMailDetail("support");
        if (dsMl.Tables[0].Rows.Count > 0)
        {
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
                Log.Email, MailBody, "Employee Registration");

        }

        result = "<b>Dear " + Name + "</b><br/> Thanks for registration with us. <br/><br/> <b> Thank you,</b> <br/> Team: VCQRU.COM <br/> " + ProjectSession.sales_accomplishtrades + " ";
        return result;
    }


    public static string checkconsumer(string type, string value, string Utype)
    {
        string result = "";
        DataSet ds = new DataSet();
        if (type == "Email")
        {

            if (Utype.ToLower() == "user")
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [M_Consumer] where isnull(isactive,0) =0 and isnull(isdelete,0) =0  and  [Email] = '" + value.Trim().Replace("'", "''") + "'");
            }
            else if (Utype.ToLower() == "vendor")
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [Comp_Email] FROM [Comp_Reg] where isnull(status,1) = 1 and  isnull(Delete_Flag,1)=1 and [Comp_Email] = '" + value.Trim().Replace("'", "''") + "'");
            }
            else if (Utype.ToLower() == "emp")
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [Employee] where   isnull(active,0) =1 and isnull(dalete,0) =0  and  [Email] = '" + value.Trim().Replace("'", "''") + "'");
            }
            else if (Utype.ToLower() == "dealer")
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [dealer] where   isnull(active,0) =1 and isnull([delete],0) =0  and  [Email] = '" + value.Trim().Replace("'", "''") + "'");
            }
            if (ds.Tables[0].Rows.Count > 0)
            {
                result = "Email ID Already exist!";
                return result;
            }
        }
        else if (type == "Mobile")
        {
            string MobileNo = value.Trim().Replace("'", "''");
            #region Find Actual Mobile No
            if (MobileNo.Length < 10)
            {
                result = "Mobile No. must be 10 digits!";
                return result;
            }
            if (MobileNo.Length == 11)
            {
                int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                if (initial == 0)
                    MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
                else
                {
                    result = "Mobile No. Wrong!";
                    return result;
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
                    return result;
                }
            }
            if (MobileNo.Length == 12)
            {
                int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
                if (initial == 91)
                    MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
                else
                {
                    result = "Mobile No. Wrong!";
                    return result;
                }
            }
            if (MobileNo.Length == 10)
                MobileNo = "91" + MobileNo;
            #endregion
            //DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [M_Consumer] where [MobileNo] = '" + MobileNo + "'");
            if (Utype.ToLower() == "user")
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [M_Consumer] where isnull(isactive,0) =0 and isnull(isdelete,0) =0  and  [MobileNo] = '" + MobileNo.Trim().Replace("'", "''") + "'");
            }
            else if (Utype.ToLower() == "vendor")
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [Comp_Email] FROM [Comp_Reg] where isnull(status,1) = 1 and  isnull(Delete_Flag,1)=1 and [Mobile_No] = '" + MobileNo.Trim().Replace("'", "''") + "'");
            }
            else if (Utype.ToLower() == "emp")
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [Employee] where   isnull(active,0) =0 and isnull(dalete,0) =0  and  [MobileNo] = '" + MobileNo.Trim().Replace("'", "''") + "'");
            }
            else if (Utype.ToLower() == "dealer")
            {
                ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [dealer] where   isnull(active,0) =1 and isnull([delete],0) =0  and  [mobileno] = '" + MobileNo.Trim().Replace("'", "''") + "'");
            }
            if (ds.Tables[0].Rows.Count > 0)
            {
                result = "Mobile No. Already exist!";
                return result;
            }
        }
        return result;
    }
    public static string Dealerlogin(string userid, string pass, int remember)
    {
        string result = "";
        User_Details Log = new User_Details();
        if (userid.ToUpper() == "ADMIN")
        {
            result = "Invalid userid or password !";
            return result;
        }
        else
        {
            string MobileNo = userid.Trim().Replace("'", "''");
            if (IsValid(userid.Trim().Replace("'", "''")))
                Log.DML = "Email";
            else
            {
                Log.DML = "Mobile";
                #region Find Actual Mobile No
                if (MobileNo.Length < 10)
                {
                    result = "Mobile No. must be 10 digits!";
                    return result;
                }
                if (MobileNo.Length == 11)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        return result;
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
                        return result;
                    }
                }
                if (MobileNo.Length == 12)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
                    if (initial == 91)
                        MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        return result;
                    }
                }
                if (MobileNo.Length == 10)
                    MobileNo = "91" + MobileNo;
                #endregion
            }
            Log.User_Type = " ";
            Log.User_ID = MobileNo;
            Log.Password = pass.Trim().Replace("'", "''");
            //  DataTable dt = User_Details.GetUserLoginDetails(Log);
            DataTable dt = SQL_DB.ExecuteDataTable("Select * from Dealer where mobileno = '" + MobileNo + "' and pwd = '" + pass + "'");
            if (dt.Rows.Count > 0)
            {
                if (remember == 1)
                {
                    HttpContext.Current.Response.Cookies["DistributorUserName"].Value = Log.User_ID;
                    HttpContext.Current.Response.Cookies["DistributorPassword"].Value = pass.Trim();
                    HttpContext.Current.Response.Cookies["DistributorUserName"].Expires = DateTime.Now.AddDays(15);
                    HttpContext.Current.Response.Cookies["DistributorPassword"].Expires = DateTime.Now.AddDays(15);
                }
                else if (remember == 0)
                {
                    HttpContext.Current.Response.Cookies["DistributorUserName"].Value = null;
                    HttpContext.Current.Response.Cookies["DistributorPassword"].Value = null;
                }
                //HttpContext.Current.Session["User_Type"] = "Consumer";
                HttpContext.Current.Session["USRID"] = dt.Rows[0]["User_ID"].ToString();

                ProjectSession.strUser_Type = "Dealer";
                ProjectSession.strDealerUserID = dt.Rows[0]["Dealerid"].ToString();
                //   ProjectSession.intM_ConsumeriD = Convert.ToInt32(dt.Rows[0]["Dealerid"]);
                if (dt.Rows[0]["Name"].ToString() != "")
                {
                    HttpContext.Current.Session["DealerName"] = dt.Rows[0]["Name"].ToString();
                    ProjectSession.strDealerName = dt.Rows[0]["Name"].ToString();
                }
                else
                    HttpContext.Current.Session["DealerName"] = null;
                // HttpContext.Current.Session["USRMOBILENO"] = dt.Rows[0]["MobileNo"].ToString();
                ProjectSession.strMobileNo = dt.Rows[0]["MobileNo"].ToString();
                result = "success";
            }
            else
            {
                result = "Invalid userid or password !";
                return result;
            }
        }
        return result;
    }

    public static bool IsValid(string emailaddress)
    {
        try
        {
            MailAddress m = new MailAddress(emailaddress);

            return true;
        }
        catch (FormatException)
        {
            return false;
        }
    }
    public static string Consumerforgotpassword(string mobile)
    {
        string result = "";
        User_Details Log = new User_Details();
        if (mobile.ToUpper() == "ADMIN")
        {
            result = "Invalid user id or password !";
            return result;
        }
        else
        {
            string MobileNo = mobile.Trim().Replace("'", "''");
            if (IsValid(mobile.Trim().Replace("'", "''")))
            {
                Log.DML = "Email";
            }
            else
            {
                Log.DML = "Mobile";
                #region Find Actual Mobile No
                if (MobileNo.Length < 10)
                {
                    result = "Mobile No. must be 10 digits!";
                    return result;
                }
                if (MobileNo.Length == 11)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
                    if (initial == 0)
                        MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        return result;
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
                        return result;
                    }
                }
                if (MobileNo.Length == 12)
                {
                    int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
                    if (initial == 91)
                        MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
                    else
                    {
                        result = "Mobile No. Wrong!";
                        return result;
                    }
                }
                if (MobileNo.Length == 10)
                    MobileNo = "91" + MobileNo;
                #endregion
            }
            Log.User_Type = "Consumer";
            Log.User_ID = MobileNo;
            DataTable dt = new DataTable();
            if (Log.DML == "Mobile")
                dt = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] WHERE  [MobileNo] = '" + MobileNo + "'").Tables[0];
            else if (Log.DML == "Email")
                dt = SQL_DB.ExecuteDataSet("SELECT * FROM [M_Consumer] WHERE  [Email] = '" + MobileNo + "' ").Tables[0];
            if (dt.Rows.Count > 0)
            {
                string email = dt.Rows[0]["Email"].ToString();
                string forgetpass = dt.Rows[0]["Password"].ToString();
                if (dt.Rows[0]["Password"].ToString().Length > 15)
                {
                    forgetpass = Decrypt(dt.Rows[0]["Password"].ToString());
                }

                if (email != "")
                {
                    //string ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
                    string pass = dt.Rows[0]["Password"].ToString();
                    string MailBody = "";
                    MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                                               " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
                                               " <hr style='border:1px solid #2587D5;'/>" +
                                               " <div class='w_frame'>" +
                                               " <p>" +
                                               " <div class='w_detail'>" +
                                               " <span>Dear <em><strong> " + dt.Rows[0]["ConsumerName"].ToString() + ",</strong></em></span><br />" +
                                               " <br />" +
                                               " <span>Login to https://www.qa.vcqru.com/login.aspx#logsign </span><br />" +
                                               " Password - " + forgetpass + "</strong>  " +
                                               " <p>" +
                                               " <div class='w_detail'>" +
                                               " Assuring you  of  our best services always.<br />" +
                                               " Thank you,<br /><br />" +
                                               " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                                               "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                                               " </div>" +
                                               " </p>" +
                                               " </div>" +
                                               " </p>" +
                                               " </div> " +
                                               " </div> ";

                    DataSet dsMl = function9420.FetchMailDetail("support");
                    if (dsMl.Tables[0].Rows.Count > 0)
                    {
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
                            email, MailBody, "Forget Password");

                    }

                    ServiceLogic.SendSms("Your VCQRU_ID: " + MobileNo + " & PWD: " + forgetpass.ToString() + " Visit https://www.vcqru.com/login.aspx & complete your profile", "+" + MobileNo);
                    result = "Your password is send to registerd Email Id / Mobile Number!";

                }
                else
                {
                    ServiceLogic.SendSms("Your VCQRU_ID: " + MobileNo + " & PWD: " + dt.Rows[0]["Password"].ToString() + " Visit https://www.vcqru.com/login.aspx & complete your profile", "+" + MobileNo);
                    result = "Your password is send sms to Mobile No. xxxxxxx" + MobileNo.Substring(9, 3);
                }
            }
            else
            {
                result = "Your user id is invalid!";
            }
        }
        return result;
    }

    public static string GetYourFreePassNow(string Name, string Email, string Mobile, string Comp, string Visitor, string Exibitionname, string subject = null)
    {
        string result = "";
        Object9420 obj = new Object9420();
        obj.Name = Name.Trim().Replace("'", "''");
        obj.Email = Email.Trim().Replace("'", "''");
        obj.cmobile = Mobile.Trim().Replace("'", "''");
        obj.Comments = Visitor.Trim().Replace("'", "''");
        obj.Comp_Name = Comp.Trim().Replace("'", "''");
        string Exibitionnm = Exibitionname.ToUpper();
        if (subject == null)
        {
            subject = "Exhibition Passes Confirmation";
        }
        #region Mail Structure
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear  <em><strong>" + obj.Name + ",</strong></em></span><br />" +
        " <br />" +

        " Message :Thank you for expressing your interest in the IHFF Expo 2024 ! We appreciate your enthusiasm and are delighted to inform you that our representative will be in touch with you shortly to arrange the passes.<br/>" +
        " Our team is committed to ensuring that your experience at the exhibition is both enjoyable and informative. We believe you will find the event captivating and full of valuable insights.<br />" +
        " Once our representative reaches out to you, they will provide further details on the pass collection process and answer any questions you may have.<br />" +
        " We look forward to welcoming you to the exhibition and hope that it exceeds your expectations. If you require any further assistance or have additional inquiries, please feel free to reach out to us.<br />" +
        " <p>" +
        " <div class='w_detail'>" +
        " Thank you once again for your interest. We can't wait to share this exciting exhibition with you!<br /><br /><br />" +
        " Best regards,<br />" +
        " VCQRU Exhibition Team <br /> " +
        "  " + ProjectSession.sales_vcqrucom + "  <br /><br />" +
        " To know more about our services you may call our Business Development team on :<strong> +919355903102, +919355903103, +919355903104, +919355903105, +919355903107 <br/>" +
        " Follow Us On:<a href='https://www.youtube.com/channel/UCmQmBBnF3pHfM2czRYZhYAQ'>Youtube</a>  <a href='https://twitter.com/i/flow/login?redirect_after_login=%2FVcqru_Official'>Tweeter</a>  <a href='https://www.facebook.com/vcqru/'>Facebook</a>  <a href='https://www.linkedin.com/company/vcqru-wesecureyou'>Linkdin</a> <br/>" +
        " Team <em><strong><a href='https://www.vcqru.com/'>VCQRU.COM,</a></strong></em><br />" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";
        string MailBody1 = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong> Media,</strong></em></span><br />" +
        " <span><em><strong>Name : -</strong></em> " + obj.Name + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + obj.Email + "</span><br />" +

         " Mobile Number : <strong> " + obj.cmobile + " <br />" +
          " Company Name : <strong> " + obj.Comp_Name + " <br />" +
         " Message :Request for the Number of Passes <strong> " + obj.Comments + " <br />" +
         "for the Exibition of " + Exibitionnm + "" +
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
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Email, MailBody, subject);
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Media_accomplishtrades, MailBody1, subject);
        }
        result = "Success";

        // ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
        //"<script>alert('Record Added Successfully')</script>");

        return result;
    }


    public static string sendqueryService(string name, string cmobile, string pageName, string subject = null)
    {
        string result = "";
        Object9420 obj = new Object9420();
        obj.Name = name.Trim().Replace("'", "''");
        obj.cmobile = cmobile.Trim().Replace("'", "''");
        if (subject == null)
        {
            subject = "Contact Service";
            function9420.SaveLetUsTalk(obj);
        }
        string ServiceName = "";
        if (pageName == "bl")
        {
            subject = "User Query - Build Loyalty";
            ServiceName = "Build Loyalty";
        }
        else if (pageName == "ac")
        {
            subject = "User Query - Anticounterfit";
            ServiceName = "Anticounterfit";
        }
        #region Mail Structure
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + obj.Name + ",</strong></em></span><br />" +
        " <br />" +
        " Mobile Number : <strong> " + obj.cmobile + " <br />" +
          " <br />" +
           " Service Name : <strong> " + ServiceName + " <br />" +
        " We will contact you soon.   <br />" +
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
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong> Media,</strong></em></span><br />" +
               " <span><em><strong>Name : -</strong></em> " + obj.Name + "</span><br />" +
         " <span><em><strong>Mobile No : -</strong></em> " + obj.cmobile + "</span><br />" +
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
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Email, MailBody, subject);
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Media_accomplishtrades, MailBody1, subject);
        }
        result = "Query has been sent successfully.";

        // ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
        //"<script>alert('Record Added Successfully')</script>");

        return result;
    }

    public static string sendqueryMVCRPFAllPage(string name, string email, string comment, string companyName, string subject = null)
    {
        string result = "";
        Object9420 obj = new Object9420();
        obj.Name = name.Trim().Replace("'", "''");
        obj.Email = email.Trim().Replace("'", "''");
        obj.Comments = comment.Trim().Replace("'", "''");
        if (subject == null)
        {
            subject = "Request RFP - Contact us";
            //function9420.SaveLetUsTalk(obj);
        }
        #region Mail Structure
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + obj.Name + ",</strong></em></span><br />" +
        " <br />" +
        " Email Id :  <strong> " + obj.Email + " <br />" +
        " Company Name : <strong> " + companyName + " <br />" +
        " Message : <strong> " + obj.Comments + " <br />" +
        " We will contact you soon.   <br />" +
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
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong> Media,</strong></em></span><br />" +
        " <span><em><strong>Name : -</strong></em> " + obj.Name + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + obj.Email + "</span><br />" +
        " Company Name : <strong> " + companyName + " <br />" +
         " Message : <strong> " + obj.Comments + " <br />" +
        " <span><em><strong>Message : -</strong></em> " + obj.Comments + "</span><br /></div>" +
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
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Email, MailBody, subject);
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Media_accomplishtrades, MailBody1, subject);
        }
        result = "Query has been sent successfully.";

        // ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
        //"<script>alert('Record Added Successfully')</script>");

        return result;
    }
    // Added by Satvik//
    public static string sendqueryLandingPageContact(string name, string email, string cmobile, string companyName)
    {
        string result = "";
        Object9420 obj = new Object9420();
        obj.Name = name.Trim().Replace("'", "''");
        obj.Email = email.Trim().Replace("'", "''");
        obj.cmobile = cmobile.Trim().Replace("'", "''");

        string subject = "Request Landing Page - Contact us";
        //function9420.SaveLetUsTalk(obj);

        #region Mail Structure
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        //" <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>Madan Gopal Mishra,</strong></em></span><br />" +
        " <br />" +
        " You've just gained another lead – a promising opportunity awaits! <br />" +
         " <br />" +
        " Name :  <strong> " + obj.Name + " <br />" +
        " Email Id :  <strong> " + obj.Email + " <br />" +
        " Company Name : <strong> " + companyName + " <br />" +
        " Mobile Number : <strong> " + obj.cmobile + " <br />" +

        //" We will contact you soon.   <br />" +
        " <p>" +
        " <div class='w_detail'>" +
        " Don't be late connect with him/her soon and grab this deal.<br />" +
        //" Thank you,<br /><br />" +
        //" Team <em><strong>VCQRU.COM,</strong></em><br />" +
        //"  " + ProjectSession.sales_vcqrucom + "  <br />" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";
        string MailBody1 = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        //" <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        //" <span>Dear <em><strong> Media,</strong></em></span><br />" +
        " <span><em><strong>Name : -</strong></em> " + obj.Name + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + obj.Email + "</span><br />" +
        " Company Name : <strong> " + companyName + " <br />" +
         " Mobile Number : <strong> " + obj.cmobile + " <br />" +

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


        string MailBody3 = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        //" <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>Rajan Kumar,</strong></em></span><br />" +
        " <br />" +
        " You've just gained another lead – a promising opportunity awaits! <br />" +
         " <br />" +
        " Name :  <strong> " + obj.Name + " <br />" +
        " Email Id :  <strong> " + obj.Email + " <br />" +
        " Company Name : <strong> " + companyName + " <br />" +
        " Mobile Number : <strong> " + obj.cmobile + " <br />" +

        //" We will contact you soon.   <br />" +
        " <p>" +
        " <div class='w_detail'>" +
        " Don't be late connect with him/her soon and grab this deal.<br />" +
        //" Thank you,<br /><br />" +
        //" Team <em><strong>VCQRU.COM,</strong></em><br />" +
        //"  " + ProjectSession.sales_vcqrucom + "  <br />" +
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
            DataProvider.Utility.sendMailCC(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), "madan@vcqru.com", MailBody, subject);
            //  DataProvider.Utility.sendMailCC(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Media_accomplishtrades, MailBody1, subject,CC:"rajan@vcqru.com");
            DataProvider.Utility.sendMailCC(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), "rajan@vcqru.com", MailBody3, subject);
        }
        result = "Query has been sent successfully.";


        return result;
    }

    //added by satvik
    public static string sendqueryMVCRPF2(string name, string email, string comment, string companyName, string cmobile, string subject = null)
    {
        string result = "";
        Object9420 obj = new Object9420();
        obj.Name = name.Trim().Replace("'", "''");
        obj.Email = email.Trim().Replace("'", "''");
        obj.cmobile = cmobile.Trim().Replace("'", "''");
        obj.Comments = comment.Trim().Replace("'", "''");
        if (subject == null)
        {
            subject = "Visitor Request for NLGI EXPO";
            //function9420.SaveLetUsTalk(obj);
        }
        #region Mail Structure
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + obj.Name + ",</strong></em></span><br />" +
        " <br />" +
        " Email Id :  <strong> " + obj.Email + " <br />" +
        " Company Name : <strong> " + companyName + " <br />" +
        " Mobile Number : <strong> " + obj.cmobile + " <br />" +
        " Service Name : <strong> " + obj.Comments + " <br />" +
        " Thank you for submitting your details. Our team will get back to you soon.   <br />" +
        " <p>" +
        " <div class='w_detail'>" +
        //" Assuring you  of  our best services always.<br />" +
        //" Thank you,<br /><br />" +
        " Team <em><strong>VCQRU.COM,</strong></em><br />" +
        "  " + ProjectSession.sales_vcqrucom + "  <br />" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";
        string MailBody1 = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong> Team,</strong></em></span><br />" +
        " <span><em><strong>Name : -</strong></em> " + obj.Name + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + obj.Email + "</span><br />" +
        " Company Name : <strong> " + companyName + " <br />" +
         " Mobile Number : <strong> " + obj.cmobile + " <br />" +
        //" Service Name : <strong> " + obj.Comments + " <br />" +
        " <span><em><strong>Service Name : -</strong></em> " + obj.Comments + "</span><br /></div>" +
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
            //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Email, MailBody, subject);
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Media_accomplishtrades, MailBody1, subject);
        }
        result = "Query has been sent successfully.";

        // ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
        //"<script>alert('Record Added Successfully')</script>");

        return result;
    }

    //added by satvik
    public static string sendqueryMVCRPF(string name, string email, string comment, string companyName, string cmobile, string subject = null)
    {
        string result = "";
        Object9420 obj = new Object9420();
        obj.Name = name.Trim().Replace("'", "''");
        obj.Email = email.Trim().Replace("'", "''");
        obj.cmobile = cmobile.Trim().Replace("'", "''");
        obj.Comments = comment.Trim().Replace("'", "''");
        if (subject == null)
        {
            subject = "Request RFP - Contact us";
            //function9420.SaveLetUsTalk(obj);
        }
        #region Mail Structure
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + obj.Name + ",</strong></em></span><br />" +
        " <br />" +
        " Email Id :  <strong> " + obj.Email + " <br />" +
        " Company Name : <strong> " + companyName + " <br />" +
        " Mobile Number : <strong> " + obj.cmobile + " <br />" +
        " Message : <strong> " + obj.Comments + " <br />" +
        " We will contact you soon.   <br />" +
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
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong> Media,</strong></em></span><br />" +
        " <span><em><strong>Name : -</strong></em> " + obj.Name + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + obj.Email + "</span><br />" +
        " Company Name : <strong> " + companyName + " <br />" +
         " Mobile Number : <strong> " + obj.cmobile + " <br />" +
         " Message : <strong> " + obj.Comments + " <br />" +
        " <span><em><strong>Message : -</strong></em> " + obj.Comments + "</span><br /></div>" +
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
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Email, MailBody, subject);
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Media_accomplishtrades, MailBody1, subject);
        }
        result = "Query has been sent successfully.";

        // ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
        //"<script>alert('Record Added Successfully')</script>");

        return result;
    }


    public static string sendqueryMVCONT(string name, string email, string comment, string cmobile, string subject = null)
    {
        string result = "";
        Object9420 obj = new Object9420();
        obj.Name = name.Trim().Replace("'", "''");
        obj.Email = email.Trim().Replace("'", "''");
        obj.cmobile = cmobile.Trim().Replace("'", "''");
        obj.Comments = comment.Trim().Replace("'", "''");
        if (subject == null)
        {
            subject = "Request RFP - Contact us";
            //function9420.SaveLetUsTalk(obj);
        }
        #region Mail Structure
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + obj.Name + ",</strong></em></span><br />" +
        " <br />" +
        " Email Id :  <strong> " + obj.Email + " <br />" +

        " Mobile Number : <strong> " + obj.cmobile + " <br />" +
        " Message : <strong> " + obj.Comments + " <br />" +
        " We will contact you soon.   <br />" +
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
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong> Media,</strong></em></span><br />" +
        " <span><em><strong>Name : -</strong></em> " + obj.Name + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + obj.Email + "</span><br />" +

         " Mobile Number : <strong> " + obj.cmobile + " <br />" +
         " Message : <strong> " + obj.Comments + " <br />" +
        " <span><em><strong>Message : -</strong></em> " + obj.Comments + "</span><br /></div>" +
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
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Email, MailBody, subject);
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Media_accomplishtrades, MailBody1, subject);
        }
        result = "Query has been sent successfully.";

        // ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
        //"<script>alert('Record Added Successfully')</script>");

        return result;
    }




    public static string sendqueryMVCRQSemo(string name, string email, string comment, string companyName, string subject = null)
    {
        string result = "";
        //Object9420 obj = new Object9420();
        //obj.Name = name.Trim().Replace("'", "''");
        // obj.Email = email.Trim().Replace("'", "''");
        //obj.Comments = comment.Trim().Replace("'", "''");
        if (subject == null)
        {
            subject = "Request a demo - Contact us";
            //function9420.SaveLetUsTalk(obj);
        }
        #region Mail Structure
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + name + ",</strong></em></span><br />" +
        " <br />" +
        " Email Id :  <strong> " + email + " <br />" +
        " Company Name : <strong> " + companyName + " <br />" +
        " Message : <strong> " + comment + " <br />" +
        " We will contact you soon.   <br />" +
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
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong> Media,</strong></em></span><br />" +
        " <span><em><strong>Name : -</strong></em> " + name + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + email + "</span><br />" +
          " Company Name : <strong> " + companyName + " <br />" +
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
        result = "Query has been sent successfully.";

        // ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
        //"<script>alert('Record Added Successfully')</script>");

        return result;
    }

    public static string sendqueryMVCNews(string email, string name = null, string subject = null)
    {
        string result = "";

        if (subject == null)
        {
            subject = "Ask an expert - Contact us";

        }
        #region Mail Structure
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + name + ",</strong></em></span><br />" +
        " <br />" +

        " <strong> Welcome to the <a href='" + ProjectSession.absoluteSiteBrowseUrl + "' >VCQRU</a> inner circle of knowledge and excitement! Thank you for subscribing.<br /> Get ready for a journey of discovery and exclusive content delivered right to your inbox. <br />" +

        " <p>" +
        " <div class='w_detail'>" +
        " <div style='color:red;text-align: center;'><b>Defending Against Counterfeits, Securing Your Confidence.<b><br /></div>" +


         "  <div style='color:blue;'><strong>Explore Our Services:</strong><br /></div>" +




         "   <div style='text-align: center;'>" +

         "<table style='margin-left: 40px;'><tr>" +
         "<td><a href='" + ProjectSession.absoluteSiteBrowseUrl + "/anti-counterfeiting-solutions.aspx' ><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/NewContent/img-home/counterfeit-1.png' alt='Anti-Counterfeit' style='height:250px;width:250px;object-fit: contain;border: 1px solid #ddd; border-radius: 4px; padding: 5px;' /> <br><b>Anti-Counterfeit</b></a> </td>" +
         "<td  style='margin-left: 30px;'><a href='" + ProjectSession.absoluteSiteBrowseUrl + "/customer-loyalty-program.aspx'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/NewContent/img-home/build-loyalty-1.png' alt='Build-Loyalty' style='height:250px;width:250px;object-fit: contain;border: 1px solid #ddd; border-radius: 4px; padding: 5px;' /> <br><b>Build-Loyalty</b></a></td>" +
        "</tr>" +
         "<tr style='margin-top: 30px;'>" +
         "<td><a href='" + ProjectSession.absoluteSiteBrowseUrl + "/digital-e-warranty-management-solution.aspx'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/NewContent/img-home/e-warrenty-1.png' alt='E - Warrenty' style='height:250px;width:250px;object-fit: contain;border: 1px solid #ddd; border-radius: 4px; padding: 5px;' /><br><b>E- Warranty</td></a></b>" +
         "<td  style='margin-left: 30px;'><a href='" + ProjectSession.absoluteSiteBrowseUrl + "/website-design-and-development-company.aspx'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/NewContent/img-home/web-1.png' alt='Website Designing and Development' style='height:250px;width:250px;object-fit: contain;border: 1px solid #ddd; border-radius: 4px; padding: 5px;'/><br><b>Website Designing and Development</></a></td>" +
         "</tr>" +

         "</table>" +

              "<br><br><br></div>" +



        "  " + ProjectSession.sales_vcqrucom + "  <br />" +
        "  <strong>+91 124 5181074</strong><br />" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";
        string MailBody1 = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong> Media,</strong></em></span><br />" +
               " <span><em><strong>Name : -</strong></em> " + name + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + email + "</span><br />" +
        " <span><em><strong>Message : -</strong></em> Thanks for Connected with us</span><br /></div>" +
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
        result = "Query has been sent successfully.";

        // ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
        //"<script>alert('Record Added Successfully')</script>");

        return result;
    }
    public static string sendqueryMVC(string name, string email, string comment, string subject = null)
    {
        string result = "";

        if (subject == null)
        {
            subject = "Ask an expert - Contact us";

        }
        #region Mail Structure
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + name + ",</strong></em></span><br />" +
        " <br />" +
        " Email Id :  <strong> " + email + " <br />" +
        " Message : <strong> " + comment + " <br />" +
        " We will contact you soon.   <br />" +
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
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
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
        result = "Query has been sent successfully.";

        // ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
        //"<script>alert('Record Added Successfully')</script>");

        return result;
    }

    public static string sendqueryVendor(string name, string email, string comment, string cmobile, string pageName, string subject = null)
    {
        string result = "";
        Object9420 obj = new Object9420();
        obj.Name = name.Trim().Replace("'", "''");
        obj.Email = email.Trim().Replace("'", "''");
        obj.cmobile = cmobile.Trim().Replace("'", "''");
        obj.Comments = comment.Trim().Replace("'", "''");
        if (subject == null)
        {
            subject = "User Query";
            function9420.SaveLetUsTalk(obj);
        }
        var ServiceName = pageName;
        subject = "User Query - " + pageName;
        /*if (pageName == "bl")
        {
            subject = "User Query - Build Loyalty";
            ServiceName = "Build Loyalty";
        }
        else if (pageName == "ac")
        {
            subject = "User Query - Anticounterfit";
            ServiceName = "Anticounterfit";
        }*/

        #region Mail Structure
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + obj.Name + ",</strong></em></span><br />" +
        " <br />" +

        " Email Id :  <strong> " + obj.Email + " <br />" +
        " Mobile Number : <strong> " + obj.cmobile + " <br />" +
        " Company Name : <strong> " + obj.Comments + " <br />" +
        " Service Name : <strong> " + ServiceName + " <br />" +
         " Your Query has been received successfully.   <br />" +
        " We will contact you soon.   <br />" +
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
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong> Media,</strong></em></span><br />" +
        " <span><em><strong>Name : -</strong></em> " + obj.Name + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + obj.Email + "</span><br />" +
         " <span><em><strong>Mobile No : -</strong></em> " + obj.cmobile + "</span><br />" +
        " <span><em><strong>Company Name : -</strong></em> " + obj.Comments + "</span><br /></div>" +
         " <span><em><strong>Service Name : -</strong></em> " + ServiceName + "</span><br /></div>" +
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
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Email, MailBody, subject);
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Media_accomplishtrades, MailBody1, subject);
        }
        result = "Query has been sent successfully.";

        // ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
        //"<script>alert('Record Added Successfully')</script>");

        return result;
    }

    public static string setpassword(string password, string value)
    {
        string result = "";
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [User_ID] FROM [ResetPassword] where  [Encrypt_Value] = '" + value.Replace(" ", "+") + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Comp_Reg] SET [Password] = '" + (password.Replace("'", "''").ToString()) + "' WHERE [Comp_ID] = '" + ds.Tables[0].Rows[0]["User_ID"].ToString() + "'");
            result = "Password has been changed successfully.";
        }
        return result;
    }



    public static string sendqueryOpenings(string name, string email, string cmobile, string resumePath, string jobType, string subject = null)
    {
        string result = "";
        string resumeFileLink = "";
        Object9420 obj = new Object9420();
        string Name = name.Trim().Replace("'", "''");
        string Email = email.Trim().Replace("'", "''");
        string Mobile = cmobile.Trim().Replace("'", "''");

        if (subject == null)
        {
            subject = "Receipt Confirmation - Application Submission  - " + jobType;
            // function9420.SaveLetUsTalk(obj);
        }
        string subjectForUser = "Heartfelt Thanks for Your Application";
        if (resumePath != "")
        {
            string pathimh = ProjectSession.absoluteSiteBrowseUrl + resumePath;
            resumeFileLink = "Resume : <strong><a href='" + pathimh + "'>View Resume File</a><br />";
        }
        #region Mail Structure
        string MailBody = srt + /*"<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +*/
        //" <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        //" <hr style='border:1px solid #2587D5;'/>" +
        //" <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + Name + ",</strong></em></span><br />" +
        " <br />" +

        " I hope this email finds you well. We express our sincere gratitude to you for taking the time to apply for the " +
        "<span>" + jobType + "</span> role through our job portal. We truly appreciate your interest in joining our team.<br />" +
        " <p>" +
        " <div class='w_detail'>" +
        " Your qualifications and experiences are impressive, and we are excited about the possibility of you becoming a part of our organization." +
        "Your application will be carefully reviewed by our hiring team, and we will reach out to you if your qualifications align with the requirements of the position.<br />" +
        " Once again, thank you for considering a career with us. Should you have any questions or require further information, please don't hesitate to reach out.<br /><br />" +
        " <br />" +
        " Best Regards,<br /><br />" +
        " <br />" +
        "HR VCQRU <br />" +
        "9355903101 <br />" +
        "neha@vcqru.com <br />" +
        " <em><strong>https://www.vcqru.com/</strong></em><br />" +
          "<a href='https://www.facebook.com/vcqru/'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/facebook2.png' alt='Facebook' /></a>" +
        "<a href='https://www.linkedin.com/company/vcqru-wesecureyou/'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/linkedin2.png' alt='linkedin' /></a>" +
        "<a href='https://www.instagram.com/vcqru_wesecureyou/'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/instagram2.png' alt='instagram' /></a>" +
        "<a href='https://twitter.com/Vcqru_Official'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/twitter2.png' alt='twitter' /></a>" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";
        string MailBody1 = srt + /*"<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +*/
        //" <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        //" <hr style='border:1px solid #2587D5;'/>" +
        //" <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>  HR Team,</strong></em></span><br />" +
        " <br />" +
        " We have received an application from a candidate via our job portal for the <span>" + jobType + "</span> position Below are the details of the applicant:<br />" +
               " <span><em><strong>Name : -</strong></em> " + Name + "</span><br />" +
         //" <span><em><strong>Email ID : -</strong></em> " + Email + "</span><br />" +
         // " <span><em><strong>Mobile No : -</strong></em> " + cmobile + "</span><br />" +
         " <span><em><strong>Opening : -</strong></em> " + jobType + "</span><br />" +
         " <span><em><strong>Date : -</strong></em> " + DateTime.Now + "</span><br />" +
        " <p>" +
        " <div class='w_detail'>" +
        " We are proceeding to you for reviewing the application and assessing the candidate's qualifications against the requirements of the role." +
        " Once you have completed the initial review, share updates regarding the status of the application with the candidate.<br />" +
        " <br />" +
        " <span><em><strong>Attachment : -</strong></em> " + resumeFileLink + "</span><br /> " +
         " <br />" +
        " Best Regards,<br /><br />" +
         " <br />" +
         " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div><br />" +
        " <em><strong>https://www.vcqru.com/</strong></em><br />" +
         "<a href='https://www.facebook.com/vcqru/'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/facebook2.png' alt='Facebook' /></a>" +
        "<a href='https://www.linkedin.com/company/vcqru-wesecureyou/'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/linkedin2.png' alt='linkedin' /></a>" +
        "<a href='https://www.instagram.com/vcqru_wesecureyou/'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/instagram2.png' alt='instagram' /></a>" +
        "<a href='https://twitter.com/Vcqru_Official'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/twitter2.png' alt='twitter' /></a>" +
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
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Email, MailBody, subjectForUser);
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), "neha@vcqru.com", MailBody1, subject);
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Media_accomplishtrades, MailBody1, subject);


        }
        result = "Query has been sent successfully.";

        // ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
        //"<script>alert('Record Added Successfully')</script>");
        HttpContext.Current.Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "Thanks.aspx");
        return result;
    }



    public static string sendqueryMarketingCompaging(string name, string email, string comment, string cmobile, string pageName, string subject = null)
    {
        string result = "";
        Object9420 obj = new Object9420();
        obj.Name = name.Trim().Replace("'", "''");
        obj.Email = email.Trim().Replace("'", "''");
        obj.cmobile = cmobile.Trim().Replace("'", "''");
        obj.Comments = comment.Trim().Replace("'", "''");
        if (subject == null)
        {
            subject = "User Query - Marketing Campaign";
            //function9420.SaveLetUsTalk(obj);
        }
        var ServiceName = "";
        if (pageName == "MarketingCampaign")
        {
            subject = "User Query - Marketing Campaign";
            ServiceName = "Marketing Campaign";
        }
        #region Mail Structure
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + obj.Name + ",</strong></em></span><br />" +
        " <br />" +

        " Email Id :  <strong> " + obj.Email + " <br />" +
        " Mobile Number : <strong> " + obj.cmobile + " <br />" +
        " Service Name : <strong> " + ServiceName + " <br />" +
        " Message : <strong> " + obj.Comments + " <br />" +
         " Your Query has been received successfully.   <br />" +
        " We will contact you soon.   <br />" +
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
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong> Media,</strong></em></span><br />" +
        " <span><em><strong>Name : -</strong></em> " + obj.Name + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + obj.Email + "</span><br />" +
        " <span><em><strong>Mobile No : -</strong></em> " + obj.cmobile + "</span><br />" +
        " <span><em><strong>Service Name : -</strong></em> " + ServiceName + "</span><br /></div>" +
        " <span><em><strong>Message : -</strong></em> " + obj.Comments + "</span><br /></div>" +
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
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Email, MailBody, subject);
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Media_accomplishtrades, MailBody1, subject);
        }
        result = "Query has been sent successfully.";

        // ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
        //"<script>alert('Record Added Successfully')</script>");

        return result;
    }



    public static string sendquery(string name, string email, string comment, string cmobile, string subject = null)
    {
        string result = "";
        Object9420 obj = new Object9420();
        obj.Name = name.Trim().Replace("'", "''");
        obj.Email = email.Trim().Replace("'", "''");
        obj.cmobile = cmobile.Trim().Replace("'", "''");
        obj.Comments = comment.Trim().Replace("'", "''");
        if (subject == null)
        {
            subject = "User Query";
            function9420.SaveLetUsTalk(obj);
        }
        #region Mail Structure
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + obj.Name + ",</strong></em></span><br />" +
        " <br />" +

        " Your Query <strong> " + obj.Comments + "</strong>  has been received successfully.   <br />" +
        " We will contact you soon.   <br />" +
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
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong> Media,</strong></em></span><br />" +
               " <span><em><strong>Name : -</strong></em> " + obj.Name + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + obj.Email + "</span><br />" +
         " <span><em><strong>Mobile No : -</strong></em> " + obj.cmobile + "</span><br />" +
        " <span><em><strong>Message : -</strong></em> " + obj.Comments + "</span><br /></div>" +
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
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Email, MailBody, subject);
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Media_accomplishtrades, MailBody1, subject);
        }
        result = "Query has been sent successfully.";

        // ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
        //"<script>alert('Record Added Successfully')</script>");

        return result;
    }
    public static DataTable Filldtransaction(string size, int consumer_id)
    {

        string comp_idD = "";
        DataSet dcs = SQL_DB.ExecuteDataSet("SELECT Comp_id FROM [M_Consumer] where [M_Consumerid] = '" + consumer_id + "'");
        if (dcs.Tables[0].Rows.Count > 0)
        {
            comp_idD = dcs.Tables[0].Rows[0]["comp_id"].ToString();
        }
        if (comp_idD == "Comp-1400")
        {
            if (size == "Full")
            {

                DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("Gettransactionlist_VR", consumer_id);
                return dtTrans.Tables[0];
            }
            else
            {
                DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("Gettransactionlist10_VR", consumer_id);
                return dtTrans.Tables[0];
            }
        }
        else
        {

            if (size == "Full")
            {

                DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("Gettransactionlist", consumer_id);
                return dtTrans.Tables[0];
            }
            else
            {
                DataSet dtTrans = ExecuteNonQueryAndDatatable.FillTransactions("Gettransactionlist10", consumer_id);
                return dtTrans.Tables[0];
            }
        }





    }
    public static string appchkgenuenity(string code1, string code2, string mobile, string fields, string mode, string dealerid = "", string paintername = "", string dealermobile = "", string BookName = "", string BookShop = "", string CoachingCenter = "", string Email = "", string CompName = "", string Address = "", string SellerName = "")
    // public static string chkgenuenity(string code1, string code2, string mobile)
    {
        //return "testing <br/>  Congratulation's !!! <b>You</b> have won gift coupon of";
        string errMsg = "";
        string ReferralCodeFromUser = string.Empty;
        string result = "";
        string ConsumerId = "";
        string designation = string.Empty;
        message_status messageobject = new message_status();
        string MobileNo = mobile.Trim().Replace("'", "''");
        ServiceLogic.paytm_mobile = MobileNo;
        ServiceLogic.paytm_codes = code1 + code2;

        #region validation check
        //if (MobileNo == "")
        //{
        //    result = "Kindly Enter Your Mobile No.";
        //}
        #endregion
        #region Validate Mobile No (actual length entered by  user )
        //if (MobileNo.Length < 10)
        //{
        //    result = "Mobile No. must be 10 digits!";
        //}
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

        #endregion

        #region Checking for M_Consumer
        DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email] FROM [M_Consumer] where [MobileNo] = '" + MobileNo + "'");
        if (dcs.Tables[0].Rows.Count > 0)
        {
            // below line is commented by shweta
            //if (dcs.Tables[0].Rows[0]["Email"].ToString() != mobile.Trim().Replace("'", "''"))
            //{
            //    //if (mobile.Trim().Replace("'", "''") != "")
            //    //    SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [Email] = '" + mobile.Trim().Replace("'", "''") + "' WHERE [User_ID] = '" + dcs.Tables[0].Rows[0]["User_ID"].ToString() + "' ");
            //}
            //else
            ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
        }
        else
        {
            Random r = new Random();

            int psw = r.Next(1000, 9999);
            User_Details Log = new User_Details();
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));

            // Log.Email = "";
            // email.Trim().Replace("'", "''"); //this is comment is done by shweta

            Log.MobileNo = MobileNo;

            Log.PinCode = null;
            Log.Password = psw.ToString();
            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.ConsumerName = paintername;
            Log.Address = Address;
            Log.DML = "I";

            User_Details.InsertUpdateUserDetails(Log);
            string msgString = "Your VCQRU_ID: " + MobileNo + " & PWD: " + Log.Password + " Visit https://www.vcqru.com/login.aspx & complete your profile";
            if (paintername != "")
                msgString = "Your VCQRU_ID: " + MobileNo + " & PWD: " + Log.Password + " Visit https://www.vcqru.com/login.aspx & complete your profile";
            ServiceLogic.SendSms(msgString, MobileNo);


        }



        if (CompName == "SHRI BALAJI PUBLICATIONS")
        {
            if (BookName != null && BookShop != "")
            {
                Publisher_Details log1 = new Publisher_Details();
                log1.MobileNo = MobileNo;
                log1.bookShop = BookShop;
                log1.Bookname = BookName;
                log1.ccenter = CoachingCenter;
                log1.Code1 = code1;
                log1.Code2 = code2;
                User_Details.InsertUpdatePublisherDetails(log1);
            }
        }

        #endregion
        if (fields.Length > 0)
        {

            string msgReturn = string.Empty;

            string errDMsg = string.Empty;

            string employeeId = string.Empty;
            string distributorId = string.Empty;

            string[] FieldList = fields.Split(new string[] { FieldSeparator }, StringSplitOptions.None);
            string updatefields = string.Empty;
            for (int i = 0; i < FieldList.Length; i++)
            {
                string[] fieldname = FieldList[i].Split('=');
                if (fieldname[0] != "Painter OTP" || fieldname[0] != "Dealer Id")
                {
                    if (i < FieldList.Length - 1)
                        updatefields += SQL_DB.ExecuteScalar("select top 1 Field_value from App_fields where Field_name='" + fieldname[0] + "'") + "='" + fieldname[1] + "',";

                    else
                    {
                        if (fieldname[0] != "Select Role")
                        {
                            updatefields += SQL_DB.ExecuteScalar("select top 1 Field_value from App_fields where Field_name='" + fieldname[0] + "'") + "='" + fieldname[1] + "'";
                        }
                        else if (CompName == "OCI Wires and Cables" || CompName == "Inox Decor Pvt Ltd")
                        {

                        }

                        else
                            updatefields = updatefields.Remove(updatefields.LastIndexOf(","));
                    }
                }
            }

            string RoleType = "";

            foreach (string item in FieldList)
            {
                if (item.Contains("Technician / Techmaster / M-Star Id"))
                    employeeId = item.Split('=')[1];
                if (item.Contains("Dealer Code"))
                    distributorId = item.Split('=')[1];
                if (item.Contains("Select Role"))
                    RoleType = item.Split('=')[1];

                if (item.Contains("Designation"))
                {
                    designation = item.Split('=')[1];
                }

            }

            if (employeeId != "" && distributorId != "")
            {
                DataSet dsDistributor;
                DataSet dsEmployee;
                if (RoleType == "3")
                {
                    dsDistributor = CheckDistrbutorDetailsEmployee(employeeId, distributorId);
                    dsEmployee = CheckEmployeeDetailsEmployee(employeeId, distributorId);
                }
                else
                {

                    dsEmployee = CheckEmployeeDetails(employeeId, distributorId);
                    dsDistributor = CheckDistrbutorDetails(employeeId, distributorId);
                }

                if (dsEmployee.Tables[0].Rows.Count == 0)
                {
                    errMsg = "Please provide a valid Dealer Technician ID / Techmaster ID as given ID " + employeeId + " is wrong.";
                }

                if (dsDistributor.Tables[0].Rows.Count == 0)
                {
                    errDMsg = "Please provide a valid Dealer Code as given code " + distributorId + " is wrong.";
                }

                if (dsEmployee.Tables[0].Rows.Count == 0 && dsDistributor.Tables[0].Rows.Count == 0)
                {

                    messageobject.status = "Error";
                    messageobject.message = errMsg + Environment.NewLine + errDMsg;
                    messageobject.fields = "Technician ID,Dealer Code";
                    return JsonConvert.SerializeObject(messageobject, Formatting.Indented);


                }
                else
                {
                    SQL_DB.ExecuteNonQuery("update m_consumer set " + updatefields + " where [MobileNo] = '" + MobileNo + "'");
                }


            }
            else if (CompName == "A TO Z PHARMACEUTICALS")
            {
                SQL_DB.ExecuteNonQuery("update m_consumer set " + updatefields + " where [MobileNo] = '" + MobileNo + "'");
            }
        }


        Object9420 Reg = new Object9420();
        Reg.Received_Code1 = (code1.Trim().Replace("'", "''"));
        Reg.Received_Code2 = (code2.Trim().Replace("'", "''"));
        Reg.dealerid = dealerid;
        Reg.consumer_name = paintername;
        Reg.designation = designation;
        //if (HttpContext.Current.Session["mode"] != null)
        //{
        //    if (HttpContext.Current.Session["mode"].ToString() == "Barcode")
        //    {
        //        Reg.Dial_Mode = "QR code";
        //    }
        //    else
        //    {
        //        Reg.Dial_Mode = "WebSite";
        //    }
        //}
        //else
        //{
        Reg.Dial_Mode = mode;
        // }
        Reg.Mode_Detail = GetIP();

        Reg.Mobile_No = MobileNo;
        Reg.Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff"));
        Reg.callerdate = DateTime.Now;
        Reg.callertime = DateTime.Now.ToString("hh:mm:ss");
        //Location location = locationdetails();

        //Reg.callercircle = location.region_name;
        //Reg.City = location.city_name;
        Reg.dealer_mobile = dealermobile;
        ////Reg.Comp_ID = ProjectSession.strCompanyid.ToString();
        //if (cmpName == "MAHINDRA AND MAHINDRA LTD")
        //{
        //    Reg.TempleteHead = "SRV1005";
        //    Reg.SubHeadId = "cash";
        //}
        DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
        if (Business9420.function9420.FindCheckedStatus(Reg)) //it looks company status check i.e verify company by admin
        {
            Reg.Is_Success = 0;
            Business9420.function9420.InsertCodeChecked(Reg);
            // result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
            result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
            //send a mail to customer that it's company status is inactive(i.e 0) , so user cannot veryfy there product.
            //return result; // it should if not graranted shweta
            messageobject.status = "Invalid";
        }
        //   string DefaultComments = ""; string CompName = string.Empty;
        // DataSet ds = Business9420.function9420.FindCheckedCode(Reg);
        DataSet ds = ServiceLogic.FindCheckedCode_2(Reg);
        if (ds.Tables[0].Rows.Count == 0)
        {
            Reg.Is_Success = 0;
            Business9420.function9420.InsertCodeChecked(Reg);
            result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
            messageobject.status = "Inavlid";

            // result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
            // return result; // it should if not graranted shweta
        }
        else if (ds.Tables[0].Rows.Count > 0)
        {
            DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
            if (dsres.Tables.Count > 0)
            {
                if (dsres.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
                    {
                        result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, false, ReferralCodeFromUser, Reg.Dial_Mode);



                    }
                    else if (ds.Tables[0].Rows[0]["Use_Count"].ToString() != "0")
                    {
                        messageobject.status = "Unsuccess";
                        if (dsres.Tables[0].Rows[0]["Comp_Name"].ToString().ToUpper() == "ROYAL MANUFACTURER")
                        {
                            DataTable jpcdt1 = new DataTable();
                            jpcdt1 = SQL_DB.ExecuteDataTable("select count(1) TotalCount from Pro_Enq where Received_Code1='" + Reg.Received_Code1 + "' and Received_Code2='" + Reg.Received_Code2 + "'");

                            if (Convert.ToInt32(jpcdt1.Rows[0]["TotalCount"].ToString()) <= 2)
                            {
                                messageobject.status = "Success";
                            }
                        }
                        //DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
                        result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, true, ReferralCodeFromUser, Reg.Dial_Mode);
                        string resultapp = result.Replace("<br/><br/>", "");

                    }
                }
                else
                {
                    if (ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
                    {
                        Reg.Is_Success = 2;
                        messageobject.status = "Unsuccess";

                        DateTime Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff"));


                        if (HttpContext.Current.Session["lat"] != null && HttpContext.Current.Session["long"] != null)
                        {
                            location loc = new location();
                            loc.code1 = code1;
                            loc.code2 = code2;
                            loc.latitude = HttpContext.Current.Session["lat"].ToString();
                            loc.longitude = HttpContext.Current.Session["long"].ToString();
                            loc.EnqDate = Enq_Date;
                            Business9420.function9420.GetLocationFromLongLat(loc);
                        }

                        SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                            "[Is_Success],[callerdate],[callertime]) VALUES('" + Reg.Dial_Mode + "','" + Enq_Date + "'," +
                            "'" + MobileNo + "','" + code1 + "','" + code2 + "','" + Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "','" + Reg.callerdate.ToString("yyyy/MM/dd HH:mm:ss") + "','" + Reg.callertime + "')");
                        //DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
                        result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='Checked'");

                        //SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('result inner - " + result + "')");
                    }
                    else
                    {
                        DateTime Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff"));


                        if (HttpContext.Current.Session["lat"] != null && HttpContext.Current.Session["long"] != null)
                        {
                            location loc = new location();
                            loc.code1 = code1;
                            loc.code2 = code2;
                            loc.latitude = HttpContext.Current.Session["lat"].ToString();
                            loc.longitude = HttpContext.Current.Session["long"].ToString();
                            loc.EnqDate = Enq_Date;
                            Business9420.function9420.GetLocationFromLongLat(loc);
                        }

                        SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                        "[Is_Success],[callerdate],[callertime]) VALUES('" + Reg.Dial_Mode + "','" + Enq_Date + "'," +
                        "'" + MobileNo + "','" + code1 + "','" + code2 + "','" + Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "','" + Reg.callerdate.ToString("yyyy/MM/dd HH:mm:ss") + "','" + Reg.callertime + "')");

                        //result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, false, ReferralCodeFromUser, Reg.Dial_Mode);
                        result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode' and MsgType=2 ");
                        messageobject.status = "Invalid";

                    }

                    // result = result + "Invalid Code!";
                    //result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode' and MsgType=2");
                }

            }
            else
            {
                if (ds.Tables[0].Rows[0]["Use_Count"].ToString() != "0")
                {
                    Reg.Is_Success = 2;
                    messageobject.status = "Unsuccess";


                    DateTime Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff"));


                    if (HttpContext.Current.Session["lat"] != null && HttpContext.Current.Session["long"] != null)
                    {
                        location loc = new location();
                        loc.code1 = code1;
                        loc.code2 = code2;
                        loc.latitude = HttpContext.Current.Session["lat"].ToString();
                        loc.longitude = HttpContext.Current.Session["long"].ToString();
                        loc.EnqDate = Enq_Date;
                        Business9420.function9420.GetLocationFromLongLat(loc);
                    }

                    SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                        "[Is_Success],[callerdate],[callertime]) VALUES('" + Reg.Dial_Mode + "','" + Enq_Date + "'," +
                        "'" + MobileNo + "','" + code1 + "','" + code2 + "','" + Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "','" + Reg.callerdate.ToString("yyyy/MM/dd HH:mm:ss") + "','" + Reg.callertime + "')");
                    //DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
                    result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='Checked'");
                }
                else
                {
                    result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
                    messageobject.status = "Invalid";
                }
                // result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
            }
        }


        messageobject.message = result;
        if (result.Contains("Sorry"))
        {
            messageobject.status = "Invalid";
        }
        return JsonConvert.SerializeObject(messageobject, Formatting.Indented);
    }
    public static bool isDigits(string s)
    {
        if (s == null || s == "") return false;

        for (int i = 0; i < s.Length; i++)
            if ((s[i] ^ '0') > 9)
                return false;

        return true;
    }


    public static string chkgenuenity(string code1, string code2, string mobile, string email, string Role_ID, string State, string ReferralCodeFromUser, string city, string name, string dealerid = "", string designation = "", string dealermobile = "", string village = "", string district = "", string state = "", string compname = "", string country = "", string bookname = "", string bookShop = "", string ccenter = "", string Address = "", string SellerName = "", string CompID = "", string Other_Role = "", string PinCode = "", string BankName = "", string AccountNumber = "", string IfscCode = "", string AccountHolderName = "", string BranchName = "", string virtualPath = "", string TNC = "", string UPI = "", string Shopname = "", string Gender = "", string Age = "", string RefralCode = "", string pancard_number = "", string IsVerified = "", string Latitude = "", string Longitude = "", string aadhar_number = "", string teslapayoutmode = "")
    // public static string chkgenuenity(string code1, string code2, string mobile)
    {
        //return "testing <br/>  Congratulation's !!! <b>You</b> have won gift coupon of";
        string result = "";
        string ConsumerId = "";
        string consumer_name = "";
        string dvillage = "";
        string ddistrict = "";
        string dstate = "";
        string dbookname = "";
        string dbookShop = "";
        string dccenter = "";
        //string PinCode="";
        string MobileNo = mobile.Trim().Replace("'", "''");
        ServiceLogic.paytm_mobile = MobileNo;
        ServiceLogic.paytm_codes = code1 + code2;

        if (CompID != "Comp-1626")
        {
            #region validation check
            if (MobileNo == "")
            {
                result = "Kindly Enter Your Mobile No.";
            }
            #endregion
            #region Validate Mobile No (actual length entered by  user )

            if (!isDigits(MobileNo))
            {
                result = "Mobile No. must be numeric only!";
                return result;
            }
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

            #endregion
        }


        DataSet dscomp = ServiceLogic.GetServicesAssign_Product(code1, code2, CompID);
        string compnyid = "";
        string Pro_ID = "";
        if (dscomp.Tables.Count > 0)
        {
            if (dscomp.Tables[0].Rows.Count > 0)
            {
                compnyid = dscomp.Tables[0].Rows[0]["Comp_ID"].ToString();
                Pro_ID = dscomp.Tables[0].Rows[0]["Pro_ID"].ToString();
            }
        }

        //Hypersonic APP COde Restriction on Web
        if (Pro_ID == "AL69")
        {
            result = "Invalid Code.";
            return result;
        }


        //End Of HyperSonic
        //Milton App Added by Bipin
        if (compnyid == "Comp-1597")
        {
            result = "To Check Your Coupon Code, Please Download The App Milton ";
            return result;
        }
        //Milton App
        //Bsex App Added by Bipin
        if (compnyid == "Comp-1598")
        {
            result = "To Check Your Coupon Code, Please Download The App </br> <a href='https://play.google.com/store/apps/details?id=com.app.basex.basex'> Basex </a>";
            return result;
        }
        //Bsex App
        if (compnyid == "Comp-1727")
        { // suri 
            result = "To Check Your Coupon Code, Please Download The App </br> <a href='https://drive.google.com/drive/folders/1iyTlRSkg65YgJd-oMP7nJBZo92CVN387?usp=drive_link'>SURIE POLEX INDUSTRIES PRIVATE LIMITED </a>";
            return result;
        }
        //Sagar App
         if (compnyid == "Comp-1669")
        { // suri 
            result = "To Check Your Coupon Code, Please Download The App </br> <a href='https://play.google.com/store/apps/details?id=com.app.sagar_petroleum_app&pli=1'>Oil Doctor </a>";
            return result;
        }

        //Akemi App Added by Bipin
        if ((compnyid == "Comp-1567" || compnyid == "Comp-1650") && UPI != "KYC")
        {
            result = "To Check Your Coupon Code, Please Download The App </br> <a href='https://play.google.com/store/apps/details?id=com.app.akemi'>Akemi Rewards</a>";
            return result;
        }
        //Akemi App
        if (compname == "") // add by tej Hypersonic
        {
            DataTable companyname = SQL_DB.ExecuteDataTable("select Comp_Name from Comp_Reg where Comp_ID='" + compnyid + "'");
            if (companyname.Rows.Count > 0)
                compname = companyname.Rows[0][0].ToString();
        }

        //Hafila App Added by Bipin
        if (compnyid == "Comp-1615")
        {
            result = "To Check Your Coupon Code, Please Download The App </br> <a href='https://play.google.com/store/apps/details?id=com.app.megna'>Hafila.</a>";
            return result;
        }
        //Hafila App


        #region Checking for M_Consumer

        //Tej vr kable user code not check from web
        DataTable dcsVr;
        dcsVr = SQL_DB.ExecuteDataTable("select a.Pro_ID from M_Code as a , Pro_Reg as b where a.Code1='" + code1 + "' and a.Code2='" + code2 + "' and a.Pro_ID=b.Pro_ID and b.Comp_ID='Comp-1400'");
        if (dcsVr.Rows.Count > 0 && compnyid == "Comp-1400")
        {
            return result = "Unauthorised user! code check not allowed. Please download VR Sangh mobile application, register yourself to scan the code and get the rewards.";
        }

        //3 this changes for ram gopal
        DataSet dcs;
        string rgmobile;
        //** Trimurti Deep (Add [M_Consumerid]) **//
        if (MobileNo.StartsWith("91"))
        {
            rgmobile = MobileNo.Substring(MobileNo.Length - 10);
            dcs = SQL_DB.ExecuteDataSet("SELECT [M_Consumerid], [User_ID],[MobileNo],[Email],[ConsumerName],village,district,[state] FROM [M_Consumer] where right([MobileNo],10) = '" + rgmobile + "'");
        }
        else
        {
            rgmobile = MobileNo;
            dcs = SQL_DB.ExecuteDataSet("SELECT [M_Consumerid], [User_ID],[MobileNo],[Email],[ConsumerName],village,district,[state] FROM [M_Consumer] where [MobileNo] = '" + rgmobile + "'");
        }
        if (dcs.Tables[0].Rows.Count > 0)
        {
            // below line is commented by shweta
            //if (dcs.Tables[0].Rows[0]["Email"].ToString() != mobile.Trim().Replace("'", "''"))
            //{
            //    //if (mobile.Trim().Replace("'", "''") != "")
            //    //    SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [Email] = '" + mobile.Trim().Replace("'", "''") + "' WHERE [User_ID] = '" + dcs.Tables[0].Rows[0]["User_ID"].ToString() + "' ");
            //}
            //else
            ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
            //if(dcs.Tables[0].Rows[0]["ConsumerName"]!=null)
            //{
            //    consumer_name = dcs.Tables[0].Rows[0]["ConsumerName"].ToString();
            //}
            //if(dcs.Tables[0].Rows[0]["ConsumerName"]!=null)
            //{
            //    consumer_name = dcs.Tables[0].Rows[0]["ConsumerName"].ToString();
            //}
            //if(dcs.Tables[0].Rows[0]["village"]!=null)
            //{
            //    dvillage = dcs.Tables[0].Rows[0]["village"].ToString();
            //}
            //if(dcs.Tables[0].Rows[0]["district"]!=null)
            //{
            //    ddistrict = dcs.Tables[0].Rows[0]["district"].ToString();
            //}
            //if(dcs.Tables[0].Rows[0]["state"]!=null)
            //{
            //    dstate = dcs.Tables[0].Rows[0]["state"].ToString();
            //}
        }

        if (ConsumerId == "")
        {
            #region Registration
            Random rnd = new Random();
            User_Details Log = new User_Details();
            Log.Designation = designation;
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
            Log.ConsumerName = name;
            // Log.Email = "";
            // email.Trim().Replace("'", "''"); //this is comment is done by shweta
            Log.Email = email.Trim().Replace("'", "''");
            Log.MobileNo = MobileNo;
            Log.Role_ID = Role_ID;  //bipin added for inox reg
            Log.Other_Role = Other_Role;  //bipin added for inox reg
            Log.UPI = UPI;
            Log.PanNumber = pancard_number;
            Log.AadhaarNumber = aadhar_number; // vsc paint by tej
            Log.City = city;
            Log.PinCode = PinCode;
            Log.Password = rnd.Next(10000, 99999).ToString();
            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.code1 = code1.Trim().Replace("'", "''");
            Log.code2 = code2.Trim().Replace("'", "''");
            Log.village = village;
            Log.district = district;
            Log.state = state;
            if (state != "" && State == "") { State = state; }
            Log.state = State;
            Log.country = country;
            Log.DML = "I";
            Log.Comp_id = CompID;
            Log.Address = Address;
            Log.SellerName = SellerName;
            //Added by BIpin for Ramgopal 
            Log.gender = Gender;
            Log.Agegroup = Age;
            //Added by BIpin for Ramgopal 
            Log.teslapayoutmode = teslapayoutmode;
            User_Details.InsertUpdateUserDetails(Log);

            if (bookname != null && bookname != "")
            {
                Publisher_Details log1 = new Publisher_Details();
                log1.MobileNo = MobileNo;
                log1.bookShop = bookShop;
                log1.Bookname = bookname;
                log1.ccenter = ccenter;
                log1.Code1 = code1;
                log1.Code2 = code2;

                User_Details.InsertUpdatePublisherDetails(log1);
            }


            string strReferralCode = Convert.ToString(SQL_DB.ExecuteScalar("Select dbo.GetZeroConcactWithReferralCode(referralcode)  FROM [M_Consumer] where [MobileNo] = '" + MobileNo + "'"));
            string msgString = string.Empty;
            if (HttpContext.Current.Session["MMUser"] == null || HttpContext.Current.Session["MMUser"].ToString() == "")
            {
                if (HttpContext.Current.Session["service"] != null)
                {
                    if (HttpContext.Current.Session["service"].ToString() == "MS")
                        msgString = "You are registered with VCQRU.COM. Your USER ID is " + MobileNo + " and PASSWORD is " + Log.Password + " Visit www.vcqru.com for more info OR for any query contact customer care 9243029420. Thanks VCQRU";
                    else if (HttpContext.Current.Session["companyname"].ToString() == "JPH Publications Pvt. Ltd")
                        msgString = "You are registered with VCQRU.COM. Your USER ID is " + MobileNo + " and PASSWORD is " + Log.Password + " Visit www.vcqru.com for more info OR for any query contact customer care 9243029420. Thanks VCQRU";
                    else
                        msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ". Visit www.vcqru.com to complete the user and bank details  or call 9243029420 for customer support.";
                }

                else if (HttpContext.Current.Session["companyname"] != null)
                {
                    if (HttpContext.Current.Session["companyname"].ToString().ToUpper() == "MYSHA HEALTH WORLD")
                    {
                        msgString = "Thanks for purchasing from MYSHA Nutrition. You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ".";
                    }
                    else if (HttpContext.Current.Session["companyname"].ToString() == "Generic Pharma")
                    {
                        msgString = "You are registered with VCQRU.COM. Your USER ID is " + MobileNo + " and PASSWORD is " + Log.Password + " Visit www.vcqru.com for more info OR for any query contact customer care 9243029420. Thanks VCQRU";
                    }
                    else
                    {
                        msgString = "You are registered with VCQRU.COM. Your USER ID is " + MobileNo + " and PASSWORD is " + Log.Password + " Visit www.vcqru.com for more info OR for any query contact customer care 9243029420. Thanks VCQRU";
                    }

                }
                else
                {
                    msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ". Visit www.vcqru.com to complete the user and bank details  or call 9243029420 for customer support.";
                }
            }

            else
            {
                if (HttpContext.Current.Session["service"] != null)
                {
                    if (HttpContext.Current.Session["service"].ToString() == "MS")
                        msgString = "You are registered with VCQRU.COM. Your USER ID is " + MobileNo + " and PASSWORD is " + Log.Password + " Visit www.vcqru.com for more info OR for any query contact customer care 9243029420. Thanks VCQRU";
                    else if (HttpContext.Current.Session["companyname"].ToString() == "JPH Publications Pvt. Ltd")
                        msgString = "You are registered with VCQRU.COM. Your USER ID is " + MobileNo + " and PASSWORD is " + Log.Password + " Visit www.vcqru.com for more info OR for any query contact customer care 9243029420. Thanks VCQRU";
                    else
                        msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ". Visit www.vcqru.com to complete the user and bank details  or call 9243029420 for customer support.";
                }
                else
                {
                    msgString = "You are registered with VCQRU.COM. YOUR USER ID IS " + MobileNo + " AND PASSWORD IS " + Log.Password + ". Visit www.vcqru.com to complete the user and bank details  or call 9243029420 for customer support.";
                }
            }
            if (compname == "TESLA POWER INDIA PRIVATE LIMITED")
            {
                cls_teslaemailtemplate _mailtesla = new cls_teslaemailtemplate();
                _mailtesla.Registationemail(MobileNo, "s.trikha@teslapowerusa.com", "");
            }

            ServiceLogic.SendSms(msgString, MobileNo);
            //4 this changes for ram gopal
            DataTable dtnew;
            if (MobileNo.StartsWith("91"))
            {
                dtnew = SQL_DB.ExecuteDataTable("select * FROM [M_Consumer] where right([MobileNo],10) = '" + MobileNo.Substring(MobileNo.Length - 10) + "'");
            }
            else
            {
                dtnew = SQL_DB.ExecuteDataTable("select * FROM [M_Consumer] where [MobileNo] = '" + MobileNo + "'");
            }
            if (dtnew.Rows.Count > 0)
            {
                User_Details Lognew = new User_Details();
                if (dtnew.Rows[0]["ConsumerName"].ToString() == "")
                {
                    Lognew.ConsumerName = name;
                }

                if (dtnew.Rows[0]["Email"].ToString() == "")
                {
                    Lognew.Email = email;
                }
                if (dtnew.Rows[0]["City"].ToString() == "")
                {
                    Lognew.City = city;
                }
                if (dtnew.Rows[0]["PinCode"].ToString() == "")
                {
                    Lognew.PinCode = PinCode;
                }
                if (dtnew.Rows[0]["state"].ToString() == "")
                {
                    Lognew.state = state;
                }
                if (dtnew.Rows[0]["Address"].ToString() == "")
                {
                    Lognew.Address = Address;
                }
                if (dtnew.Rows[0]["SellerName"].ToString() == "")
                {
                    Lognew.SellerName = SellerName;
                }
                if (dtnew.Rows[0]["Vrkabel_User_Type"].ToString() == "")
                {
                    Lognew.Role_ID_VRK = Role_ID;
                }
                if ((compname == "PRINCIPLE ADHESIVES PRIVATE LIMITED" || compname == "CHERYL CHEMICAL AND POLYMERS" || compname == "DURGA COLOUR AND CHEM.P LTD." || compname == "OCI Wires and Cables" || compname == "SAMSOIL PETROLEUM INDIA LTD" || compname == "SRI ANANTHA PADMANABHA SWAMY ENTERPRISES") && (designation != "" || Role_ID != "" || UPI != "" || aadhar_number != "" || pancard_number != "" || PinCode != "" || city != "" || state != ""))
                {
                    SQL_DB.ExecuteNonQuery("UPDATE M_Consumer SET UPIId = '" + UPI.Trim().Replace("'", "''") + "' WHERE RIGHT(MobileNo, 10) = '" + MobileNo.Substring(MobileNo.Length - 10) + "'");
                    if (pancard_number != "")
                    {
                        dtnew = SQL_DB.ExecuteDataTable("UPDATE M_Consumer SET pancard_number = '" + pancard_number.Trim().Replace("'", "''") + "' WHERE RIGHT(MobileNo, 10) = '" + MobileNo.Substring(MobileNo.Length - 10) + "'");
                    }
                    if (aadhar_number != "")
                    {
                        dtnew = SQL_DB.ExecuteDataTable("UPDATE M_Consumer SET aadharNumber = '" + aadhar_number.Trim().Replace("'", "''") + "' WHERE RIGHT(MobileNo, 10) = '" + MobileNo.Substring(MobileNo.Length - 10) + "'");
                    }
                    if (PinCode != "")
                    {
                        SQL_DB.ExecuteNonQuery("UPDATE M_Consumer SET Pincode = '" + PinCode.Trim().Replace("'", "''") + "' WHERE RIGHT(MobileNo, 10) = '" + MobileNo.Substring(MobileNo.Length - 10) + "'");
                    }
                    if (city != "")
                    {
                        SQL_DB.ExecuteNonQuery("UPDATE M_Consumer SET city = '" + city.Trim().Replace("'", "''") + "' WHERE RIGHT(MobileNo, 10) = '" + MobileNo.Substring(MobileNo.Length - 10) + "'");
                    }
                    if (state != "")
                    {
                        SQL_DB.ExecuteNonQuery("UPDATE M_Consumer SET state = '" + state.Trim().Replace("'", "''") + "' WHERE RIGHT(MobileNo, 10) = '" + MobileNo.Substring(MobileNo.Length - 10) + "'");
                    }
                    if (Role_ID != "")
                    {
                        SQL_DB.ExecuteNonQuery("UPDATE M_Consumer SET Vrkabel_User_Type = '" + Role_ID + "' WHERE RIGHT(MobileNo, 10) = '" + MobileNo.Substring(MobileNo.Length - 10) + "'");
                    }
                    if (designation != "")
                    {
                        SQL_DB.ExecuteNonQuery("UPDATE M_Consumer SET designation = '" + designation + "' WHERE RIGHT(MobileNo, 10) = '" + MobileNo.Substring(MobileNo.Length - 10) + "'");
                    }



                }
            }


            //SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('IVR-caller_time-dddddddd')");
            #endregion
            ConsumerId = Log.User_ID;
            if (compname == "PRINCIPLE ADHESIVES PRIVATE LIMITED" || compname == "CHERYL CHEMICAL AND POLYMERS" || compname == "DURGA COLOUR AND CHEM.P LTD." || compname == "Shree Durga Traders" || compname == "NV INFOTECH DOMAIN PRIVATE LIMITED" || compname == "BLUEGEM PAINTS" || compname == "The Kolorado  Paints" || compname == "Oltimo Lubes" || compname == "HERBAL AYURVEDA AND RESEARCH CENTER" || compname == "SAMSOIL PETROLEUM INDIA LTD" || compname == "TESLA POWER INDIA PRIVATE LIMITED" && (AccountNumber != "" || IfscCode != "" || BankName != "" || BranchName != ""))
            {
                string M_Consumerid = SQL_DB.ExecuteScalar("select [M_Consumerid] FROM [M_Consumer] where right([MobileNo],10) = '" + MobileNo.Substring(MobileNo.Length - 10) + "'").ToString();
                Object9420 Log1 = new Object9420();
                Log1.Account_No = AccountNumber;
                Log1.IFSC_Code = IfscCode;
                if (compname == "Shree Durga Traders")
                    Log1.Account_HolderNm = name;
                else
                    Log1.Account_HolderNm = AccountHolderName;
                Log1.Bank_Name = BankName;
                Log1.Branch = BranchName;
                Log1.M_ConsumerID = Convert.ToInt32(M_Consumerid);
                Log1.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
                Log1.DML = "I";

                if (compname == "TESLA POWER INDIA PRIVATE LIMITED")
                {
                    DataTable dtchkbank = SQL_DB.ExecuteDataTable("select*from M_BankAccount where M_Consumerid='" + M_Consumerid + "'");
                    if (dtchkbank.Rows.Count == 0)
                    {
                        function9420.BankInfo(Log1);
                    }
                }
                else
                {
                    function9420.BankInfo(Log1);
                }

                if (compname == "HERBAL AYURVEDA AND RESEARCH CENTER")
                {
                    result = "Updated details have been processed, and the credited benefits will be seamlessly deposited into your account within the next 48 to 72 hours.";
                    return result;
                }
            }

        }
        else if (compname == "PRINCIPLE ADHESIVES PRIVATE LIMITED" || compname == "DURGA COLOUR AND CHEM.P LTD." || compname == "Shree Durga Traders" || compname == "NV INFOTECH DOMAIN PRIVATE LIMITED" || compname == "BLUEGEM PAINTS" || compname == "The Kolorado  Paints" || compname == "HERBAL AYURVEDA AND RESEARCH CENTER" || compname == "SAMSOIL PETROLEUM INDIA LTD" || compname == "TESLA POWER INDIA PRIVATE LIMITED" && (AccountNumber != "" || IfscCode != "" || BankName != "" || BranchName != ""))
        {
            string M_Consumerid = SQL_DB.ExecuteScalar("select [M_Consumerid] FROM [M_Consumer] where right([MobileNo],10) = '" + MobileNo.Substring(MobileNo.Length - 10) + "'").ToString();
            Object9420 Log = new Object9420();
            Log.Account_No = AccountNumber;
            Log.IFSC_Code = IfscCode;
            if (compname == "Shree Durga Traders")
                Log.Account_HolderNm = name;
            else
                Log.Account_HolderNm = AccountHolderName;
            Log.Bank_Name = BankName;
            Log.Branch = BranchName;
            Log.M_ConsumerID = Convert.ToInt32(M_Consumerid);
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
            DataTable dtaccount = SQL_DB.ExecuteDataTable("select * from [M_BankAccount] where M_Consumerid='" + Log.M_ConsumerID + "'");
            string BankAccount, ifscno;
            if (dtaccount.Rows.Count > 0)
            {
                BankAccount = dtaccount.Rows[0]["Account_No"].ToString();
                IfscCode = dtaccount.Rows[0]["IFSC_Code"].ToString();
            }
            else
            {
                BankAccount = string.Empty;
                ifscno = string.Empty;
            }
            if (BankAccount == "" && IfscCode == "")
            {
                SQL_DB.ExecuteNonQuery("UPDATE M_BankAccount SET " +
                      "[Account_No]='" + Log.Account_No + "', " +
                      "[IFSC_Code]='" + Log.IFSC_Code + "', " +
                      "[Bank_Name]='" + Log.Bank_Name + "', " +
                      "[Branch]='" + Log.Branch + "', " +
                      "[Account_HolderNm]='" + Log.Account_HolderNm + "', " +
                      "[Entry_Date]='" + Convert.ToDateTime(Log.Entry_Date).ToString("yyyy/MM/dd") + "' " +
                      "WHERE M_Consumerid='" + Log.M_ConsumerID + "'");

            }
            else
            {
                Log.DML = "U";
            }

            if (compname == "PRINCIPLE ADHESIVES PRIVATE LIMITED")
            {
                #region Registration
                if (ConsumerId != "")
                    SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [ConsumerName] = '" + name.Trim().Replace("'", "''") + "' WHERE [User_ID] = '" + ConsumerId + "' ");
                if (ConsumerId != "" && PinCode != "")
                    SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [PinCode] = '" + PinCode.Trim().Replace("'", "''") + "' WHERE [User_ID] = '" + ConsumerId + "' ");
                if (ConsumerId != "" && city != "")
                    SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [city] = '" + city.Trim().Replace("'", "''") + "' WHERE [User_ID] = '" + ConsumerId + "' ");
                if (ConsumerId != "" && email != "")
                    SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [Email] = '" + email.Trim().Replace("'", "''") + "' WHERE [User_ID] = '" + ConsumerId + "' ");
                if (ConsumerId != "" && state != "")
                    SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [state] = '" + state.Trim().Replace("'", "''") + "' WHERE [User_ID] = '" + ConsumerId + "' ");

                #endregion

            }

            function9420.BankInfo(Log);
            if (compname == "TESLA POWER INDIA PRIVATE LIMITED")
            {
                DataTable dtchkbank = SQL_DB.ExecuteDataTable("select*from M_BankAccount where M_Consumerid='" + M_Consumerid + "'");
                if (dtchkbank.Rows.Count == 0)
                {
                    function9420.BankInfo(Log);
                }
            }
            else
            {
                function9420.BankInfo(Log);
            }
            if (compname == "HERBAL AYURVEDA AND RESEARCH CENTER")
            {
                result = "Updated details have been processed, and the credited benefits will be seamlessly deposited into your account within the next 48 to 72 hours.";
                return result;
            }
        }
        else if (compname == "PRINCIPLE ADHESIVES PRIVATE LIMITED" || compname == "CHERYL CHEMICAL AND POLYMERS" || compname == "DURGA COLOUR AND CHEM.P LTD.")//this condition added for max paints to update existing consumer data
        {
            Random rnd = new Random();
            User_Details Log1 = new User_Details();
            Log1.Designation = designation;
            Log1.Other_Role = Other_Role;
            Log1.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
            Log1.ConsumerName = name;
            Log1.User_ID = ConsumerId;
            // Log.Email = "";
            // email.Trim().Replace("'", "''"); //this is comment is done by shweta
            Log1.Email = email.Trim().Replace("'", "''");
            Log1.MobileNo = MobileNo;
            Log1.City = city;
            Log1.Comp_id = CompID;
            Log1.PinCode = PinCode;
            // Log.Password = rnd.Next(10000, 99999).ToString();
            Log1.IsActive = 0;
            Log1.IsDelete = 0;
            Log1.code1 = code1.Trim().Replace("'", "''");
            Log1.code2 = code2.Trim().Replace("'", "''");

            Log1.state = state;


            Log1.DML = "U";

            User_Details.InsertUpdateUserDetails(Log1);
        }
        else if ((compname == "HANNOVER CHEMIKALIEN PRIVATE LIMITED") && UPI != "")
        {
            string User_ID = string.Empty;
            DataTable dtnew = SQL_DB.ExecuteDataTable("select * FROM [M_Consumer] where right([MobileNo],10) = '" + MobileNo.Substring(MobileNo.Length - 10) + "'");
            if (dtnew.Rows.Count > 0)
            {
                User_ID = dtnew.Rows[0]["User_ID"].ToString();
            }
            #region Registration
            Random rnd = new Random();
            User_Details Log = new User_Details();
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
            Log.ConsumerName = name;
            Log.User_ID = User_ID;
            Log.MobileNo = MobileNo;
            Log.City = city;
            Log.PinCode = PinCode;
            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.code1 = code1.Trim().Replace("'", "''");
            Log.code2 = code2.Trim().Replace("'", "''");
            Log.state = state;
            Log.DML = "U";

            User_Details.InsertUpdateUserDetails(Log);

            #endregion

        }
        else if ((compname == "SHERKOTTI INDUSTRIES PRIVATE LIMITED" || compname == "Oltimo Lubes" || compname == "SRI ANANTHA PADMANABHA SWAMY ENTERPRISES") && (UPI != "" || aadhar_number != "" || pancard_number != "" || PinCode != "" || city != "" || state != ""))
        {
            string User_ID = string.Empty;
            DataTable dtnew = SQL_DB.ExecuteDataTable("select * FROM [M_Consumer] where right([MobileNo],10) = '" + MobileNo.Substring(MobileNo.Length - 10) + "'");
            if (dtnew.Rows.Count > 0)
            {
                User_ID = dtnew.Rows[0]["User_ID"].ToString();
            }
            #region Registration
            Random rnd = new Random();
            User_Details Log = new User_Details();
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
            Log.ConsumerName = name;
            Log.User_ID = User_ID;
            Log.Email = email.Trim().Replace("'", "''");
            Log.MobileNo = MobileNo;
            Log.City = city;
            Log.PinCode = PinCode;
            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.code1 = code1.Trim().Replace("'", "''");
            Log.code2 = code2.Trim().Replace("'", "''");
            Log.PanNumber = pancard_number;
            Log.AadhaarNumber = aadhar_number; // vsc paint by tej
            Log.UPI = UPI;
            Log.state = state;
            Log.Address = Address;
            Log.SellerName = SellerName;
            Log.DML = "U";

            User_Details.InsertUpdateUserDetails(Log);

            #endregion


        }



        else if ((compname == "Oltimo Lubes" || compname == "HERBAL AYURVEDA AND RESEARCH CENTER") && UPI != "")
        {

            DataTable dtnew = SQL_DB.ExecuteDataTable("select * FROM [M_Consumer] where right([MobileNo],10) = '" + MobileNo.Substring(MobileNo.Length - 10) + "'");
            if (dtnew.Rows.Count > 0)
            {
                name = dtnew.Rows[0]["ConsumerName"].ToString();
                email = dtnew.Rows[0]["Email"].ToString();
                city = dtnew.Rows[0]["City"].ToString();
                PinCode = dtnew.Rows[0]["PinCode"].ToString();
                state = dtnew.Rows[0]["state"].ToString();
                Address = dtnew.Rows[0]["Address"].ToString();
                SellerName = dtnew.Rows[0]["SellerName"].ToString();
            }
            #region Registration
            Random rnd = new Random();
            User_Details Log = new User_Details();
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
            Log.ConsumerName = name;
            Log.User_ID = ConsumerId;
            // Log.Email = "";
            // email.Trim().Replace("'", "''"); //this is comment is done by shweta
            Log.Email = email.Trim().Replace("'", "''");
            Log.MobileNo = MobileNo;
            Log.City = city;
            //Log.PinCode = null;
            Log.PinCode = PinCode; // tej
                                   // Log.Password = rnd.Next(10000, 99999).ToString();
            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.code1 = code1.Trim().Replace("'", "''");
            Log.code2 = code2.Trim().Replace("'", "''");
            Log.UPI = UPI;
            Log.state = state;
            Log.Address = Address;
            Log.SellerName = SellerName;

            Log.DML = "U";

            User_Details.InsertUpdateUserDetails(Log);

            #endregion
            result = "Updated details have been processed, and the credited benefits will be seamlessly deposited into your account within the next 48 to 72 hours.";
            return result;

        }
        else if (compname == "YAMUNA INTERIORS PRIVATE LIMITED" || compname == "Yamuna Interiors Pvt Ltd G")
        {
            SQL_DB.ExecuteDataTable("exec UpdateConsumer_Yamuna '" + MobileNo + "','" + email + "','" + PinCode + "','" + city + "','" + state + "'");
        }
        else if (compname == "TESLA POWER INDIA PRIVATE LIMITED")
        {
            SQL_DB.ExecuteDataTable("exec UpdateConsumerAndBankAccount '" + MobileNo + "','" + name + "','" + PinCode + "','" + city + "','" + state + "','" + UPI + "','" + AccountHolderName + "','" + AccountNumber + "','" + IfscCode + "','" + teslapayoutmode + "','" + email + "'");
        }
        else if (compname == "Ambica Cable")
        {
            SQL_DB.ExecuteDataTable("exec UpdateConsumerAMBICA '" + MobileNo + "','" + name + "','" + PinCode + "','" + city + "','" + state + "','" + UPI + "','" + Address + "','" + Other_Role + "'");
        }

        //added ram gopal condition
        else if ((compname == "EVERCROP AGRO SCIENCE" || compname == "Ram Gopal and Sons") && (consumer_name == "" || dvillage == "" || ddistrict == "" || dstate == ""))
        {
            #region Registration
            Random rnd = new Random();
            User_Details Log = new User_Details();
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
            Log.ConsumerName = name;
            Log.User_ID = ConsumerId;
            // Log.Email = "";
            // email.Trim().Replace("'", "''"); //this is comment is done by shweta
            Log.Email = email.Trim().Replace("'", "''");
            Log.MobileNo = MobileNo;
            Log.City = city;
            Log.PinCode = null;
            // Log.Password = rnd.Next(10000, 99999).ToString();
            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.code1 = code1.Trim().Replace("'", "''");
            Log.code2 = code2.Trim().Replace("'", "''");
            Log.village = village;
            Log.district = district;
            Log.state = state;
            Log.country = country;
            Log.DML = "U";

            User_Details.InsertUpdateUserDetails(Log);
            #endregion

        }
        else if (compname == "SHRI BALAJI PUBLICATIONS" && (consumer_name == "" || bookname == "" || bookShop == "" || ccenter == ""))
        {
            #region Registration
            Random rnd = new Random();
            User_Details Log = new User_Details();
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
            Log.ConsumerName = name;
            Log.User_ID = ConsumerId;

            Log.Email = email.Trim().Replace("'", "''");
            Log.MobileNo = MobileNo;
            Log.City = city;
            Log.PinCode = null;

            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.code1 = code1.Trim().Replace("'", "''");
            Log.code2 = code2.Trim().Replace("'", "''");



            Log.DML = "U";

            User_Details.InsertUpdateUserDetails(Log);

            if (bookname != null && bookname != "")
            {
                Publisher_Details log1 = new Publisher_Details();
                log1.MobileNo = MobileNo;
                log1.bookShop = bookShop;
                log1.Bookname = bookname;
                log1.ccenter = ccenter;
                log1.Code1 = code1;
                log1.Code2 = code2;

                User_Details.InsertUpdatePublisherDetails(log1);
            }


            #endregion

        }

        else if (compname == "A TO Z PHARMACEUTICALS" || compname == "Ambica Cable" && (consumer_name == "" || Address == ""))
        {
            #region Registration
            Random rnd = new Random();
            User_Details Log = new User_Details();
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
            Log.ConsumerName = name;
            Log.User_ID = ConsumerId;
            // Log.Email = "";
            // email.Trim().Replace("'", "''"); //this is comment is done by shweta
            Log.Email = email.Trim().Replace("'", "''");
            Log.MobileNo = MobileNo;
            Log.City = city;
            Log.PinCode = null;
            // Log.Password = rnd.Next(10000, 99999).ToString();
            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.code1 = code1.Trim().Replace("'", "''");
            Log.code2 = code2.Trim().Replace("'", "''");
            Log.referalcode = RefralCode;
            Log.state = state;
            Log.Address = Address;

            Log.DML = "U";

            User_Details.InsertUpdateUserDetails(Log);
            #endregion

        }

        else if ((compname == "Oltimo Lubes" || compname == "FITSIQUE" || compname == "TRUE NUTRITION PERFORMANCE PRIVATE LIMITED" || compname == "Girish Chemical Industries" || compname == "BSC Paints Pvt Ltd" || compname == "Wudchem Industries Private Limited" || compname == "Ambica Cable" || compname == "Veena Polymer" || compname == "PARAG MILK FOODS" || compname == "Ankerite Health Care Pvt. Ltd" || compname == "Chase2Fit") && (consumer_name == "" || Address == "" || compname == "FOREVER NUTRITION" || compname == "RSR Resource"))
        {
            #region Registration
            Random rnd = new Random();
            User_Details Log = new User_Details();
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
            Log.ConsumerName = name;
            Log.User_ID = ConsumerId;
            // Log.Email = "";
            // email.Trim().Replace("'", "''"); //this is comment is done by shweta
            Log.Email = email.Trim().Replace("'", "''");
            Log.MobileNo = MobileNo;
            Log.City = city;
            Log.PinCode = null;
            // Log.Password = rnd.Next(10000, 99999).ToString();
            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.code1 = code1.Trim().Replace("'", "''");
            Log.code2 = code2.Trim().Replace("'", "''");
            Log.Other_Role = Other_Role;  //bipin added for inox reg

            Log.UPI = UPI;
            Log.PinCode = PinCode;

            Log.state = state;
            Log.Address = Address;
            Log.SellerName = SellerName;

            Log.DML = "U";

            User_Details.InsertUpdateUserDetails(Log);
            #endregion

        }


        else if ((compname == "R.S Industries" || compname == "Jupiter Aqua Lines Ltd") && (consumer_name == "" || Address == ""))
        {
            #region Registration
            Random rnd = new Random();
            User_Details Log = new User_Details();
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
            Log.ConsumerName = name;
            Log.User_ID = ConsumerId;
            // Log.Email = "";
            // email.Trim().Replace("'", "''"); //this is comment is done by shweta
            Log.Email = email.Trim().Replace("'", "''");
            Log.MobileNo = MobileNo;
            Log.City = city;
            Log.PinCode = null;
            // Log.Password = rnd.Next(10000, 99999).ToString();
            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.code1 = code1.Trim().Replace("'", "''");
            Log.code2 = code2.Trim().Replace("'", "''");

            Log.state = state;
            Log.Address = Address;


            Log.DML = "U";

            User_Details.InsertUpdateUserDetails(Log);
            #endregion

        }


        else if (compname == "GRIH PRAWESH MARKETING COMPANY" && (consumer_name == "" || dstate == ""))
        {
            #region Registration
            Random rnd = new Random();
            User_Details Log = new User_Details();
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
            Log.ConsumerName = name;
            Log.User_ID = ConsumerId;
            // Log.Email = "";
            // email.Trim().Replace("'", "''"); //this is comment is done by shweta
            Log.Email = email.Trim().Replace("'", "''");
            Log.MobileNo = MobileNo;
            Log.City = city;
            Log.PinCode = null;
            // Log.Password = rnd.Next(10000, 99999).ToString();
            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.code1 = code1.Trim().Replace("'", "''");
            Log.code2 = code2.Trim().Replace("'", "''");

            Log.state = state;

            Log.DML = "U";

            User_Details.InsertUpdateUserDetails(Log);
            #endregion

        }




        else if (compname == "ALSTONE INDUSTRIES PVT. Ltd REYNOBOND" && (consumer_name == "" || city == ""))
        {
            #region Registration
            Random rnd = new Random();
            User_Details Log = new User_Details();
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
            Log.ConsumerName = name;
            Log.User_ID = ConsumerId;
            // Log.Email = "";
            // email.Trim().Replace("'", "''"); //this is comment is done by shweta
            Log.Email = email.Trim().Replace("'", "''");
            Log.MobileNo = MobileNo;
            Log.City = city;
            Log.Comp_id = CompID;
            Log.PinCode = null;
            // Log.Password = rnd.Next(10000, 99999).ToString();
            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.code1 = code1.Trim().Replace("'", "''");
            Log.code2 = code2.Trim().Replace("'", "''");

            Log.state = state;


            Log.DML = "U";

            User_Details.InsertUpdateUserDetails(Log);
            #endregion

        }
        else if (compname == "RELX INDIA PRIVATE LIMITED" && (consumer_name == "" || email == "" || PinCode == "" || SellerName == "" || Other_Role == ""))
        { // Tej
            #region Registration
            if (ConsumerId != "")
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [Email] = '" + email.Trim().Replace("'", "''") + "',[PinCode] = '" + PinCode.Trim().Replace("'", "''") + "',[ConsumerName] = '" + name.Trim().Replace("'", "''") + "',[SellerName]='" + SellerName.Trim().Replace("'", "''") + "',[Other_Role]='" + Other_Role.Trim() + "' WHERE [User_ID] = '" + ConsumerId + "' ");

            #endregion

        }
        else if (compname == "PRINCIPLE ADHESIVES PRIVATE LIMITED" || compname == "CHERYL CHEMICAL AND POLYMERS" || compname == "OCI Wires and Cables" || compname == "TRUE NUTRITION PERFORMANCE PRIVATE LIMITED" || compname == "FITSIQUE" || compname == "TECHNICAL MINDS PRIVATE LIMITED" || compname == "ORBIT ELECTRODOMESTICS INDIA")
        {
            #region Registration
            if (ConsumerId != "")
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [ConsumerName] = '" + name.Trim().Replace("'", "''") + "' WHERE [User_ID] = '" + ConsumerId + "' ");
            if (ConsumerId != "" && PinCode != "")
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [PinCode] = '" + PinCode.Trim().Replace("'", "''") + "' WHERE [User_ID] = '" + ConsumerId + "' ");
            if (ConsumerId != "" && city != "")
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [city] = '" + city.Trim().Replace("'", "''") + "' WHERE [User_ID] = '" + ConsumerId + "' ");
            if (ConsumerId != "" && email != "")
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [Email] = '" + email.Trim().Replace("'", "''") + "' WHERE [User_ID] = '" + ConsumerId + "' ");
            if (ConsumerId != "" && state != "")
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [state] = '" + state.Trim().Replace("'", "''") + "' WHERE [User_ID] = '" + ConsumerId + "' ");

            #endregion

        }
        else if (compname == "DURGA COLOUR AND CHEM.P LTD." || compname == "OCI Wires and Cables" && Role_ID != "")
        {
            #region Registration
            if (ConsumerId != "" && consumer_name != "")
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [Vrkabel_User_Type] = '" + Role_ID + "' WHERE [User_ID] = '" + ConsumerId + "' ");
            if (ConsumerId != "" && designation != "")
                SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [designation] = '" + designation + "' WHERE [User_ID] = '" + ConsumerId + "' ");

            #endregion

        }



        ////SendSms("Congs! Gained Referral code-" + strReferralCode + "", ProjectSession.strMobileNo);
        #endregion
        if (!string.IsNullOrEmpty(ReferralCodeFromUser))
        {
            if (!string.IsNullOrEmpty(ConsumerId))
            {
                ExecuteNonQueryAndDatatable.InsertUser_ReferredUser(ReferralCodeFromUser, MobileNo);
            }
        }

        Object9420 Reg = new Object9420();
        Reg.Refral = RefralCode;
        Reg.Received_Code1 = (code1.Trim().Replace("'", "''"));
        Reg.Received_Code2 = (code2.Trim().Replace("'", "''"));
        Reg.designation = designation;
        Reg.consumer_name = name;
        #region Invailid code report
        Reg.Comp_ID = compnyid;
        #endregion
        //Reg.City = city;       //added by bipin jal
        Reg.State = state;      //added by bipin jal
        Reg.Email = email;
        Reg.IsVerified = IsVerified; // New Added
        Reg.Latitude = Latitude;// New Added
        Reg.Longitude = Longitude;// New Added
        Reg.Image = virtualPath;
        Reg.Others = Other_Role;     // Added by BIpin for tesla

        if (compname == "PATANJALI  FOODS  LIMITED" || compname == "PROQUEST NUTRITION PRIVATE LIMITED" || compname == "Girish Chemical Industries" || compname == "RELX INDIA PRIVATE LIMITED" || compname == "BLUEGEM PAINTS" || compname == "RAUNAQ PAINT INDUSTRY" || compname == "PARAG MILK FOODS" || compname == "SPORTECH SOLUTIONS" || compname == "MUSCLE PUNCH SUPPLEMENTS PRIVATE LIMITED" || compname == "The Kolorado  Paints" || compname == "Oltimo Lubes" || compname == "FOREVER NUTRITION" || compname == "RSR Resource" || compname == "YAMUNA INTERIORS PRIVATE LIMITED" || compname == "Yamuna Interiors Pvt Ltd G")
        {
            Reg.Retailer_Name = SellerName;
            Reg.Others = Other_Role;
            Reg.Image = virtualPath;
            Reg.Shop_Name = Shopname;
            Reg.IsVerified = IsVerified;
            Reg.PinCode = PinCode; //added by Deep Shukla
            Reg.City = city;       //added by Deep Shukla
            Reg.State = state;      //added by Deep Shukla

        }



        if (HttpContext.Current.Session["mode"] != null)
        {
            if (HttpContext.Current.Session["mode"].ToString() == "Barcode")
            {
                Reg.Dial_Mode = "QR code";
            }
            else
            {
                Reg.Dial_Mode = "WebSite";
            }
        }
        else
        {
            Reg.Dial_Mode = "WebSite";
        }
        Reg.Mode_Detail = GetIP();

        Reg.Mobile_No = MobileNo;
        Reg.Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff"));
        Reg.callerdate = DateTime.Now;
        Reg.callertime = DateTime.Now.ToString("hh:mm:ss");
        //Location location = locationdetails();

        //Reg.callercircle = location.region_name;
        //Reg.City = location.city_name;
        if (dealerid != "")
            Reg.dealerid = dealerid;
        if (dealermobile != "")
            Reg.dealer_mobile = "91" + dealermobile.Substring(dealermobile.Length - 10, 10);
        ////Reg.Comp_ID = ProjectSession.strCompanyid.ToString();
        //if (cmpName == "MAHINDRA AND MAHINDRA LTD")
        //{
        //    Reg.TempleteHead = "SRV1005";
        //    Reg.SubHeadId = "cash";
        //}
        DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
        if (Business9420.function9420.FindCheckedStatus(Reg)) //it looks company status check i.e verify company by admin
        {
            Reg.Is_Success = 0;
            Business9420.function9420.InsertCodeChecked(Reg);
            // result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
            result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
            //send a mail to customer that it's company status is inactive(i.e 0) , so user cannot veryfy there product.
            //return result; // it should if not graranted shweta
        }
        //   string DefaultComments = ""; string CompName = string.Empty;
        // DataSet ds = Business9420.function9420.FindCheckedCode(Reg);
        DataSet ds = ServiceLogic.FindCheckedCode_2(Reg);
        if (ds.Tables[0].Rows.Count == 0)
        {
            Reg.Is_Success = 0;
            Business9420.function9420.InsertCodeChecked(Reg);

            string client = null;
            if (HttpContext.Current.Session["client"] != null)
            {
                client = HttpContext.Current.Session["client"].ToString();
            }


            if (!string.IsNullOrEmpty(client))
            {
                result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode2'");

            }
            else if (compname == "PATANJALI  FOODS  LIMITED")
            {
                result = "The service of this coupon has been deactivated and cannot be verified, Please contact to support 7353000903.!";
            }
            else
            {
                result = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode2'");

                if (compname == "Paras cosmetics private limiteds" || compname == "Ram Gopal and Sons")
                {
                    result = "The code entered is invalid. Please try again";
                }
                else if (compname == "PATANJALI  FOODS  LIMITED")
                    result = "The service of this coupon has been deactivated and cannot be verified, Please contact to support 7353000903.!";
                else if (compname == "SAFFRO MELLOW COATINGS AND RESINS")
                    result = "The code entered is invalid. Please check and try again <br> To Check Another Code <a href='https://saffromellow.com/loyalty/'>Click Here</a>";

                else if (compname == "Muscle fighter Nutrition")
                    result = "The code is invalid.<br> To Check Another Code <a href='https://musclefighternutrition.com/authenticity'>Click Here</a>";
                else if (compname == "BENITTON BATHWARE")
                    result = "The code is invalid. Kindly visit  https://benittonbathware.com/ or call on 9079655396(Client support Number) for further assistance.";
                else if (compname == "HANNOVER CHEMIKALIEN PRIVATE LIMITED")
                    result = "The code is invalid. Kindly visit  https://hannoverchemikalien.com/ or call on <br> 91 7353000903 for further assistance.";
                else if (compname == "VCQRU")
                    result = "The code entered is invalid. Please check and try again.";
                else if (compname == "Oltimo Lubes")
                    result = "The code entered is invalid. Please check and try again.";
                else if (compname == "SHERKOTTI INDUSTRIES PRIVATE LIMITED")
                    result = "The code is invalid. Kindly visit  https://www.charminarbrush.com/ or call on 91 7353000903 for further assistance.";
                else if (compname == "TESLA POWER INDIA PRIVATE LIMITED")
                    result = "The coupon is invalid. Kindly contact our customer support department at +91 7353000903 for further assistance.</br> कूपन अमान्य है. कृपया अधिक सहायता के लिए हमारे ग्राहक सहायता विभाग से +91 7353000903 पर संपर्क करें।";
                else if (compname == "SRI ANANTHA PADMANABHA SWAMY ENTERPRISES")
                {
                    result = "The code entered is invalid. Please check and try again";
                }
                 else if (compname == "Fit Fleet") 
                    { 
                    result = "The code is invalid.Kindly contact our customer support department at +91 7353000903 for further assistance.";
                    }


            }
            // result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
            // return result; // it should if not graranted shweta
        }
        #region // On Wrong art image selection Patanjali
        else if (Reg.IsVerified == "False" && compname == "PATANJALI  FOODS  LIMITED")
        {



            DateTime Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff"));


            if (HttpContext.Current.Session["lat"] != null && HttpContext.Current.Session["long"] != null)
            {
                location loc = new location();
                loc.code1 = code1;
                loc.code2 = code2;
                loc.latitude = HttpContext.Current.Session["lat"].ToString();
                loc.longitude = HttpContext.Current.Session["long"].ToString();
                loc.EnqDate = Enq_Date;
                Business9420.function9420.GetLocationFromLongLat(loc);
            }

            SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Comp_ID],[Mode_Detail],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
            "[Is_Success],[callerdate],[callertime],Image,IsVerified) VALUES('" + Reg.Dial_Mode + "','" + compnyid + "','" + GetIP() + "',getdate()," +
            "'" + MobileNo + "','" + code1 + "','" + code2 + "','" + Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "',cast(getdate() as date),Convert(Time, GetDate()),'" + Reg.Image + "','" + Reg.IsVerified + "')");



            //result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, false, ReferralCodeFromUser, Reg.Dial_Mode);
            result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode' and MsgType=2 ");
            if (compnyid == "Comp-1693")
                result = "The authenticity of this product cannot be confirmed. Avoid purchasing it. If you have doubts about a newly purchased pack, please contact customer care or report it here.";

        }
        #endregion
        else if (ds.Tables[0].Rows.Count > 0)
        {
            DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/", Reg.Comp_ID);
            if (dsres.Tables.Count > 0)
            {
                if (dsres.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
                    {
                        result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, false, ReferralCodeFromUser, Reg.Dial_Mode, BankName, AccountNumber, IfscCode, AccountHolderName, BranchName, TNC);
                    }
                    else if (ds.Tables[0].Rows[0]["Use_Count"].ToString() != "0")
                    {
                        //DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
                        result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, true, ReferralCodeFromUser, Reg.Dial_Mode);
                    }
                }
                else
                {
                    if (ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
                    {
                        Reg.Is_Success = 2;

                        DateTime Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff"));


                        if (HttpContext.Current.Session["lat"] != null && HttpContext.Current.Session["long"] != null)
                        {
                            location loc = new location();
                            loc.code1 = code1;
                            loc.code2 = code2;
                            loc.latitude = HttpContext.Current.Session["lat"].ToString();
                            loc.longitude = HttpContext.Current.Session["long"].ToString();
                            loc.EnqDate = Enq_Date;
                            Business9420.function9420.GetLocationFromLongLat(loc);
                        }

                        SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                            "[Is_Success],[callerdate],[callertime]) VALUES('" + Reg.Dial_Mode + "','" + Enq_Date + "'," +
                            "'" + MobileNo + "','" + code1 + "','" + code2 + "','" + Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "','" + Reg.callerdate.ToString("yyyy/MM/dd HH:mm:ss") + "','" + Reg.callertime + "')");
                        //DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
                        result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='Checked'");
                        //SQL_DB.ExecuteNonQuery("INSERT INTO [Test]  ([Remak]) VALUES ('result inner - " + result + "')");

                    }
                    else
                    {

                        DateTime Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff"));


                        if (HttpContext.Current.Session["lat"] != null && HttpContext.Current.Session["long"] != null)
                        {
                            location loc = new location();
                            loc.code1 = code1;
                            loc.code2 = code2;
                            loc.latitude = HttpContext.Current.Session["lat"].ToString();
                            loc.longitude = HttpContext.Current.Session["long"].ToString();
                            loc.EnqDate = Enq_Date;
                            Business9420.function9420.GetLocationFromLongLat(loc);
                        }

                        SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                        "[Is_Success],[callerdate],[callertime]) VALUES('" + Reg.Dial_Mode + "','" + Enq_Date + "'," +
                        "'" + MobileNo + "','" + code1 + "','" + code2 + "','" + Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "','" + Reg.callerdate.ToString("yyyy/MM/dd HH:mm:ss") + "','" + Reg.callertime + "')");

                        //result = result + ServiceLogic.ServiceRequestCheck(dsres, Reg, MobileNo, false, ReferralCodeFromUser, Reg.Dial_Mode);
                        result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode' and MsgType=2 ");
                        if (compnyid == "Comp-1693")
                            result = "The service of this coupon has been deactivated and cannot be verified, Please contact to support 7353000903.!";
                    }

                    // result = result + "Invalid Code!";
                    //result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode' and MsgType=2");
                }

            }
            else
            {
                if (ds.Tables[0].Rows[0]["Use_Count"].ToString() != "0")
                {

                    DateTime Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff"));


                    if (HttpContext.Current.Session["lat"] != null && HttpContext.Current.Session["long"] != null)
                    {
                        location loc = new location();
                        loc.code1 = code1;
                        loc.code2 = code2;
                        loc.latitude = HttpContext.Current.Session["lat"].ToString();
                        loc.longitude = HttpContext.Current.Session["long"].ToString();
                        loc.EnqDate = Enq_Date;
                        Business9420.function9420.GetLocationFromLongLat(loc);
                    }

                    Reg.Is_Success = 2;
                    SQL_DB.ExecuteNonQuery("INSERT INTO [Pro_Enq] ([Dial_Mode],[Enq_Date],[MobileNo],[Received_Code1],[Received_Code2],[Circle],[Network]," +
                        "[Is_Success],[callerdate],[callertime]) VALUES('" + Reg.Dial_Mode + "','" + Enq_Date + "'," +
                        "'" + MobileNo + "','" + code1 + "','" + code2 + "','" + Reg.callercircle + "','" + Reg.network + "','" + Reg.Is_Success + "','" + Reg.callerdate.ToString("yyyy/MM/dd HH:mm:ss") + "','" + Reg.callertime + "')");
                    //DataSet dsres = ServiceLogic.GetProductDtsByCode1andcode2(Reg.Received_Code1, Reg.Received_Code2, ProjectSession.absoluteSiteBrowseUrl + "/Sound/");
                    result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='Checked'");
                }
                else
                {
                    result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");

                    if (compnyid == "Comp-1693")
                        result = "The service of this coupon has been deactivated and cannot be verified, Please contact to support 7353000903.!";
                }
                // result = result + ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, Reg.Received_Code1, Reg.Received_Code2, "Service_ID='InvalidCode'");
            }
        }
        return result;
    }

    public static string chkgenuenity_old(string code1, string code2, string mobile, string email)
    // public static string chkgenuenity(string code1, string code2, string mobile)
    {
        string result = "";
        string ConsumerId = "";

        string MobileNo = mobile.Trim().Replace("'", "''");
        #region validation check
        if (MobileNo == "")
        {
            result = "Kindly Enter Your Mobile No.";
        }
        #endregion
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
        #endregion

        #region Checking for M_Consumer

        DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email] FROM [M_Consumer] where [MobileNo] = '" + MobileNo + "'");
        if (dcs.Tables[0].Rows.Count > 0)
        {
            if (dcs.Tables[0].Rows[0]["Email"].ToString() != mobile.Trim().Replace("'", "''"))
            {
                if (mobile.Trim().Replace("'", "''") != "")
                    SQL_DB.ExecuteNonQuery("UPDATE [M_Consumer] SET [Email] = '" + mobile.Trim().Replace("'", "''") + "' WHERE [User_ID] = '" + dcs.Tables[0].Rows[0]["User_ID"].ToString() + "' ");
            }
            else
                ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
        }
        if (ConsumerId == "")
        {
            #region Registration
            Random rnd = new Random();
            User_Details Log = new User_Details();
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            Log.ConsumerName = null;
            // Log.Email = "";// email.Trim().Replace("'", "''"); // this is comment is done by shweta
            Log.Email = email.Trim().Replace("'", "''");
            Log.MobileNo = MobileNo;
            Log.City = null;
            Log.PinCode = null;
            Log.Password = rnd.Next(10000, 99999).ToString();
            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.DML = "I";
            User_Details.InsertUpdateUserDetails(Log);

            string smsMsg = "Your VCQRU_ID: " + MobileNo + " & PWD: " + Log.Password + " Visit https://www.vcqru.com/login.aspx & complete your profile";
            ServiceLogic.SendSms(smsMsg, MobileNo);
            #endregion
            ConsumerId = Log.User_ID;
        }
        #endregion

        Object9420 Reg = new Object9420();
        Reg.Received_Code1 = (code1.Trim().Replace("'", "''"));
        Reg.Received_Code2 = (code2.Trim().Replace("'", "''"));
        Reg.Dial_Mode = "WebSite";
        Reg.Mode_Detail = GetIP();
        Reg.Enq_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd HH:mm:ss"));
        if (Business9420.function9420.FindCheckedStatus(Reg))
        {
            Reg.Is_Success = 0;
            Business9420.function9420.InsertCodeChecked(Reg);
            result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";

        }
        DataSet ds = Business9420.function9420.FindCheckedCode(Reg);
        if (ds.Tables[0].Rows.Count == 0)
        {
            Reg.Is_Success = 0;
            Business9420.function9420.InsertCodeChecked(Reg);
            result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
        }
        else if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Use_Count"].ToString() == "0")
        {
            // Check for all servicesagainst the product
            //ServiceLogic.GetServicesAssign_Product(Reg.Pro_ID);
            //*************** Brand Loyalty Code start ******************//
            string LoyaltyMessage = "";
            LoyaltyMessage = GetMyMessage(MobileNo, Reg.Received_Code1, Reg.Received_Code2, Reg.Mode_Detail);
            //*************** Brand Loyalty Code end ******************//
            Reg.Is_Success = 1;
            DataSet dsres = SQL_DB.ExecuteDataSet("SELECT  Comp_Reg.Comp_Name,  m_code.Pro_ID+'-'+ " +
            " convert(varchar,(case when len(convert(nvarchar,M_Code.Series_Order)) = 1 " +
            " then '0'+ convert(nvarchar,M_Code.Series_Order) else " +
            " convert(nvarchar,M_Code.Series_Order) end))+'-'+" +
            " convert(varchar,(case when len(convert(varchar,M_Code.Series_Serial)) = 1 then '00' " +
            " +convert(varchar,M_Code.Series_Serial)  " +
            " when len(convert(varchar,M_Code.Series_Serial)) = 2 then '0' " +
            " +convert(varchar,M_Code.Series_Serial) " +
            " else convert(varchar,M_Code.Series_Serial) end )) as series, Pro_Reg.Pro_Name,isnull(Pro_Reg.Comments,'') as Comments,m_code.Pro_ID," +
            " T_Pro.MRP,convert(nvarchar,T_Pro.Mfd_Date,103) as Mfd_Date, convert(nvarchar,isnull(T_Pro.Exp_Date,''),103) as Exp_Date," +
            " T_Pro.Batch_No, M_Code.Code1,M_Code.Code2, " +
            //" '"+ ProjectSession.absoluteSiteBrowseUrl +"/Sound/' + substring(Pro_Reg.Comp_ID,6,4) + '/' + substring(Pro_Reg.Comp_ID,6,4) + '.wav' as Company_Sound_File," +
            //" '"+ ProjectSession.absoluteSiteBrowseUrl +"/Sound/'+ substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + T_Pro.Pro_ID + '.wav' as Product_Sound_File," +
            //" '"+ ProjectSession.absoluteSiteBrowseUrl +"/Sound/'+ substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + convert(nvarchar,T_Pro.Row_ID) + '/' + convert(nvarchar,T_Pro.Row_ID) + '_E.wav' as comment_english," +
            //" '"+ ProjectSession.absoluteSiteBrowseUrl +"/Sound/'+ substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + convert(nvarchar,T_Pro.Row_ID) + '/' + convert(nvarchar,T_Pro.Row_ID) + '_H.wav' as comment_hindi" +
            " '" + ProjectSession.absoluteSiteBrowseUrl + "/Sound/' + substring(Pro_Reg.Comp_ID,6,4) + '/' + substring(Pro_Reg.Comp_ID,6,4) + '.wav' as Company_Sound_File," +
            " '" + ProjectSession.absoluteSiteBrowseUrl + "/Sound/'+ substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + T_Pro.Pro_ID + '.wav' as Product_Sound_File," +
            " '" + ProjectSession.absoluteSiteBrowseUrl + "/Sound/'+ substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + convert(nvarchar,T_Pro.Row_ID) + '/' + convert(nvarchar,T_Pro.Row_ID) + '_E.wav' as comment_english," +
            " '" + ProjectSession.absoluteSiteBrowseUrl + "/Sound/'+ substring(Pro_Reg.Comp_ID,6,4) + '/' + T_Pro.Pro_ID + '/' + convert(nvarchar,T_Pro.Row_ID) + '/' + convert(nvarchar,T_Pro.Row_ID) + '_H.wav' as comment_hindi" +
            " FROM T_Pro INNER JOIN M_Code ON T_Pro.Row_ID = M_Code.Batch_No INNER JOIN" +
            " Pro_Reg ON T_Pro.Pro_ID = Pro_Reg.Pro_ID INNER JOIN Comp_Reg ON Pro_Reg.Comp_ID = Comp_Reg.Comp_ID" +
            " where  M_Code.Code1 = '" + Reg.Received_Code1 + "' and M_Code.Code2 = '" + Reg.Received_Code2 + "' and ISNULL(m_code.use_count,0) = 0");
            Business9420.function9420.InsertCodeChecked(Reg); // doing entry in Pro_Enq tabgle
            Business9420.function9420.UpdateUse_CountM_Code(Reg);// update [Use_Count] =0 in M_Code
            string DefaultComments = ""; if (Reg.Comp_type == "L")
            {
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
                result = "Code1-" + Reg.Received_Code1 + " & Code2-" + Reg.Received_Code2 + ", Prod-" + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", SN-" + dsres.Tables[0].Rows[0]["series"].ToString() + "" +
                                    ", MRP-" + dsres.Tables[0].Rows[0]["MRP"].ToString() + ", MFG" + dsres.Tables[0].Rows[0]["Mfd_Date"].ToString() + ", EXP, BtNo-" + dsres.Tables[0].Rows[0]["Batch_No"].ToString() + ", PROD IS GENUINE & mfd by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + " " + DefaultComments + " Tnx VCQRU.COM";
            }
            else
            {
                result = "Code1-" + Reg.Received_Code1 + " & Code2-" + Reg.Received_Code2 + ", Prod-" + dsres.Tables[0].Rows[0]["Pro_Name"].ToString() + ", SN-" + dsres.Tables[0].Rows[0]["series"].ToString() + "" +
                                        ", MRP-" + dsres.Tables[0].Rows[0]["MRP"].ToString() + ", MFG" + dsres.Tables[0].Rows[0]["Mfd_Date"].ToString() + ", EXP" + dsres.Tables[0].Rows[0]["Exp_Date"].ToString() + ", BtNo-" + dsres.Tables[0].Rows[0]["Batch_No"].ToString() + ", PROD IS GENUINE & mfd by " + dsres.Tables[0].Rows[0]["Comp_Name"].ToString() + " " + DefaultComments + " Tnx VCQRU.COM";
            }
        }
        else if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Use_Count"].ToString() != "0")
        {
            Reg.Is_Success = 0;
            Business9420.function9420.InsertCodeChecked(Reg);
            result = "THE AUTHENTICITY OF THE PRODUCT WITH CODE 1 " + Reg.Received_Code1 + " AND CODE2 " + Reg.Received_Code2 + " HAS ALREADY BEEN CHECKED BEFORE. IF YOU HAVE PURCHASED FRESH PRODUCT WITH UNSCRATCHED LABEL THEN ITS AUTHENTICITY CAN NOT BE GUARANTEED.";

        }
        // Gift Coupon logic

        return result;
    }
    #region Brand Loyalty Code


    private static void SendSms(string Message, string phone)
    {

        string str = "";
        try
        {
            //http://sms.bsmart.in:8080/smart/SMSmartSendSMS.jsp?http://sms.bsmart.in:8080/smart/SmartSendSMS.jsp
            //str = "http://sms.bsmart.in:8080/smart/SMSmartSendSMS.jsp?usr=LABEL9420&pass=LABEL890&sid=LBVRFY&GSM=" + phone + "&msg=" + Message + "&mt=0";
            //str = "http://193.105.74.58/api/v3/sendsms/plain?user=LABEL9420&password=Sid2014!&sender=labeld&SMSText=" + Message + "&GSM=" + phone;
            //str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A7285cc769f5ed203e7d8cee48444dbb8&sender=SIDEMO&to=" + phone + "&message=" + Message;

            //    str = "http://alerts.sinfini.com/api/web2sms.php?workingkey=A3f78a344d70a9e35c006e938f428f591&sender=LBVRFY&to=" + phone + "&message=" + Message;
            str = "http://etsrds.kapps.in/webapi/accomplish/api/accomplish_T897_sms.py?customer_number=" + phone + "&sms_text=" + Message;

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
        catch
        {
        }
    }

    private static void SendSmsWithAlfa(string msg, string phone)
    {
        string str = "";
        try
        {
            //string otpMsg = "Your Employee verification OTP is " + rdmNumber + " <a href='https://www.vcqru.com'>vcqru.com</a>";
            str = "http://sms.alfasms.in/sendSMS?username=alfasms&message=" + msg + "&sendername=Alfast&smstype=TRANS&numbers=" + phone + "&apikey=d13cfc39-dae1-4462-8b46-5a2ab78ca5c1";

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
        catch
        {
        }
    }

    //*************** Brand Loyalty Code start ******************//
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
                                ChkFlag = CheckCode1Code2(Code1, Code2);
                                if (ChkFlag)
                                {
                                    if (Frequency > 0)
                                    {
                                        Reg.Points = (((AcFrequency == 1) || (Frequency == GetFrequency)) ? Convert.ToDecimal(dst.Rows[0]["Points"]) : 0);
                                        if (Reg.Points == 0)
                                            Msg = "You win " + MyPointMsg.ToString() + " Points to " + ServiceLogic.GetNext(Frequency - GetFrequency) + " Next Purchage ";
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
    //private static string GetNext(Int32 i)
    //{
    //    string Msg = "";
    //    switch (i)
    //    {
    //        case 2:
    //            {
    //                Msg = i.ToString() + "nd";
    //                break;
    //            }
    //        case 3:
    //            {
    //                Msg = i.ToString() + "rd";
    //                break;
    //            }
    //        case 4:
    //        case 5:
    //        case 6:
    //        case 7:
    //        case 8:
    //        case 9:
    //        case 10:
    //            {
    //                Msg = i.ToString() + "th";
    //                break;
    //            }
    //        default:
    //            {
    //                Msg = "";
    //                break;
    //            }
    //    }
    //    return Msg;
    //}
    private static bool CheckCode1Code2(string Code1, string Code2)
    {
        DataTable dt = SQL_DB.ExecuteDataSet("select * from T_Points WHERE Code1= '" + Code1 + "' AND Code2 = '" + Code2 + "' ").Tables[0];
        if (dt.Rows.Count > 0)
            return false;
        else
            return true;
    }
    //*************** Brand Loyalty Code end ******************//

    #endregion
    public static string subscribenewsletter(string Email)
    {
        string result = "";
        DataSet ds = new DataSet();
        Object9420 Reg = new Object9420();
        Reg.Email = Email.Trim().Replace("'", "''");
        ds = function9420.GetNewsLettersEmail(Reg);
        if (ds.Tables[0].Rows.Count > 0)
        {
            if (Convert.ToInt32(ds.Tables[0].Rows[0]["Status"]) == 0)
            {
                Reg.Status = 1;
                Reg.DML = "U";
                result = "Your e-mail has been subscribe successfully.";
            }
            else
                result = "Your e-mail already subscribe.";
        }
        else
        {
            Reg.Status = 1;
            Reg.DML = "I";
            function9420.InsertNewsLetterSubscription(Reg);
            result = "Your e-mail has been subscribe successfully.";
        }
        return result;

    }
    public static string fillnews()
    {
        string sbnews = "";
        DataSet ds = Data_Access_Layer.NewssUpDate.FillGridData();
        if (sbnews == "")
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                if (i == 0)
                {
                    sbnews += "<div class='item active'><blockquote><div class='row'><div class='col-sm-12'>";
                }
                else
                {
                    sbnews += "<div class='item'><blockquote><div class='row'><div class='col-sm-12'>";
                }
                Regex regex = new Regex("<a(.*)target");
                var v = regex.Match(ds.Tables[0].Rows[i]["News"].ToString());
                string s = v.Groups[1].ToString();
                int ii = ds.Tables[0].Rows[i]["News_heading"].ToString().Length;
                sbnews += "<p>";
                if (ds.Tables[0].Rows[i]["News_heading"].ToString().Length > 150)
                    sbnews += "" + ds.Tables[0].Rows[i]["News_heading"].ToString().Substring(0, 150) + "....";
                else
                    sbnews += "" + ds.Tables[0].Rows[i]["News_heading"].ToString() + "...";

                sbnews += "</p>";
                sbnews += "<small><span class='ddmmyy'>" + Convert.ToDateTime(ds.Tables[0].Rows[i]["Updated_Date"]).ToString("dd MMM yyyy") + "</span><span><a style='padding:10px;' class='view_more' " + s.ToString() + " target='_blank' >View More...</a></span></small>";
                sbnews += "</div></div></blockquote></div>";
            }
        }
        return sbnews.ToString();
    }
    public static string CheckEmail(string Email)
    {
        string msg = "";
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Comp_Email] FROM [Comp_Reg] where [Comp_Email] = '" + Email.Trim().Replace("'", "''") + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            msg = "Email ID Already Registered!";
        }
        else
        {
            msg = "Email ID Not Registered!";
        }
        return msg;
    }
    public static string Encrypt(string TextToBeEncrypted)
    {
        RijndaelManaged RijndaelCipher = new RijndaelManaged();
        string Password = "CSC";
        byte[] PlainText = System.Text.Encoding.Unicode.GetBytes(TextToBeEncrypted);
        byte[] Salt = Encoding.ASCII.GetBytes(Password.Length.ToString());
        PasswordDeriveBytes SecretKey = new PasswordDeriveBytes(Password, Salt);
        ICryptoTransform Encryptor = RijndaelCipher.CreateEncryptor(SecretKey.GetBytes(32), SecretKey.GetBytes(16));
        MemoryStream memoryStream = new MemoryStream();
        CryptoStream cryptoStream = new CryptoStream(memoryStream, Encryptor, CryptoStreamMode.Write);
        cryptoStream.Write(PlainText, 0, PlainText.Length);
        cryptoStream.FlushFinalBlock();
        byte[] CipherBytes = memoryStream.ToArray();
        memoryStream.Close();
        cryptoStream.Close();
        string EncryptedData = Convert.ToBase64String(CipherBytes);
        return EncryptedData;
    }

    public static string Decrypt(string TextToBeDecrypted)
    {
        RijndaelManaged RijndaelCipher = new RijndaelManaged();
        string Password = "CSC";
        string DecryptedData;
        try
        {
            string dummyData = TextToBeDecrypted.Trim().Replace(" ", "+");
            if (dummyData.Length % 4 > 0)
                dummyData = dummyData.PadRight(dummyData.Length + 4 - dummyData.Length % 4, '=');
            byte[] EncryptedData = Convert.FromBase64String(dummyData);
            //byte[] EncryptedData = UTF8Encoding.UTF8.GetBytes(TextToBeDecrypted);
            byte[] Salt = Encoding.ASCII.GetBytes(Password.Length.ToString());
            PasswordDeriveBytes SecretKey = new PasswordDeriveBytes(Password, Salt);
            ICryptoTransform Decryptor = RijndaelCipher.CreateDecryptor(SecretKey.GetBytes(32), SecretKey.GetBytes(16));
            MemoryStream memoryStream = new MemoryStream(EncryptedData);
            CryptoStream cryptoStream = new CryptoStream(memoryStream, Decryptor, CryptoStreamMode.Read);
            byte[] PlainText = new byte[EncryptedData.Length];
            int DecryptedCount = cryptoStream.Read(PlainText, 0, PlainText.Length);
            memoryStream.Close();
            cryptoStream.Close();
            DecryptedData = Encoding.Unicode.GetString(PlainText, 0, DecryptedCount);
        }
        catch
        {
            DecryptedData = TextToBeDecrypted;
        }
        return DecryptedData;
    }





    [WebMethod]
    public static string register(string Companyname, string contactpersion, string email, string mobile)
    {
        Business9420.Object9420 obj = new Business9420.Object9420();
        obj.Comp_Name = Companyname.Trim().Replace("'", "''").ToString();
        obj.Comp_Email = email.Trim().Replace("'", "''").ToString();
        obj.Contact_Person = contactpersion.Trim().Replace("'", "''").ToString();
        obj.Mobile_No = mobile.Trim().Replace("'", "''").ToString();
        obj.Comp_type = "L";
        obj.Comp_ID = SQL_DB.ExecuteScalar("SELECT [PrPrefix]+ '-' + convert(nvarchar,[PrStart]) as compId FROM [Code_Gen] where [Prfor] = 'Company'").ToString();
        obj.Reg_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy hh:mm:ss tt");
        obj.Status = 0;
        obj.Email_Vari_Flag = 0;
        obj.Update_Flag = 0;
        //obj.Country_ID = 137;
        obj.DML = "I";
        DataSet ds12 = SQL_DB.ExecuteDataSet("SELECT [Comp_Email] FROM [Comp_Reg] where [Comp_Email] = '" + obj.Comp_Email + "' and [Delete_Flag] = 1 ");
        if (ds12.Tables[0].Rows.Count == 0)
        {
            Business9420.function9420.SaveCompanyReg(obj);
            SQL_DB.ExecuteNonQuery("UPDATE [Code_Gen] SET [PrStart] = PrStart + 1 WHERE [Prfor] = 'Company'");
            string EncData = string.Format("Comp_Id={0}", obj.Comp_ID);
            string link = ProjectSession.absoluteSiteBrowseUrl + "/default.aspx?key=" + Encrypt(obj.Comp_ID);
            #region Mial Body
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
            " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
            " <hr style='border:1px solid #2587D5;'/>" +
            " <div class='w_frame'>" +
            " <p>" +
            " <div class='w_detail'>" +
            " <span>Dear <em><strong>" + contactpersion + ",</strong></em></span><br />" +
            " <br />" +
            " <span>Thank you for choosing VCQRU.COM</span>" +
            " <br />you are just few seconds away to enjoy the services of VCQRU.COM <br />" +
            " Please visit the link below, to verify your email. <a href='" + link + "'><strong>Verify your Email now</strong></a>" +
            " <br />" +
            " <br />" +
            " <p>" +
            " <div class='w_detail'>" +
            " Assuring you  of  our best services always.<br />" +
            " Thank you,<br /><br />" +
            " Team <em><strong>VCQRU.COM,</strong></em><br />" +
            "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
            " </div>" +
            " </p>" +
            " </div>" +
            " </p>" +
            " </div> " +
            " </div> ";

            string MailBody1 = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
            " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
            " <hr style='border:1px solid #2587D5;'/>" +
            " <div class='w_frame'>" +
            " <p>" +
            " <div class='w_detail'>" +
            " <span>Dear <em><strong>, Sales person</strong></em></span><br />" +
            " <br />" +
            "<br/> <strong>" + obj.Comp_Name + "</strong> Company registered successfully. <br/> " +
            " Thank you,<br /><br />" +
            " Team <em><strong>VCQRU.COM,</strong></em><br />" +
            "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
            " </div>" +
            " </p>" +
            " </div>" +
            " </p>" +
            " </div> " +
            " </div> ";
            #endregion
            string msg = "";
            System.Data.DataSet dsMl = Business9420.function9420.FetchMailDetail("register");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Comp_Email, MailBody, "Company Registration");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Company Registration");
                msg = "<b>Dear " + contactpersion + "</b><br/> Thanks for registration with us. Please check your email to verify your account. <br/> <br/> <b> Thank you,</b> <br/> Team: VCQRU.COM <br/>  " + ProjectSession.sales_accomplishtrades + " ";
            }

            return msg;
        }
        else
        {
            string msg = "<b>This email id already registered in our system. Please enter different email id. </b>";
            return msg;
        }

    }


    [WebMethod]
    public static string demoreegister(string Companyname, string email, string contactpersion, string mobile)
    {
        string result = "";
        Object9420 obj = new Object9420();
        obj.Comp_Name = Companyname.Trim().Replace("'", "''").ToString();
        obj.Comp_Email = email.Trim().Replace("'", "''").ToString();
        obj.Contact_Person = contactpersion.Trim().Replace("'", "''").ToString();
        obj.Mobile_No = mobile.Trim().Replace("'", "''").ToString();
        obj.Comp_type = "D";
        obj.Comp_ID = SQL_DB.ExecuteScalar("SELECT [PrPrefix]+ '-' + convert(nvarchar,[PrStart]) as compId FROM [Code_Gen] where [Prfor] = 'Company'").ToString();
        obj.Reg_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy hh:mm:ss tt");
        obj.Status = 0;
        obj.Email_Vari_Flag = 1;
        obj.Update_Flag = 0;
        //obj.City_ID = 137;
        obj.DML = "I";
        Random rnd = new Random();
        obj.Password = rnd.Next().ToString().Substring(0, 5);

        function9420.SaveCompanyReg(obj);
        SQL_DB.ExecuteNonQuery("UPDATE [Allcation_Demo] SET [Entry_Flag] = 1 WHERE [Email_ID] = '" + obj.Comp_Email + "'");
        SQL_DB.ExecuteNonQuery("UPDATE [Code_Gen] SET [PrStart] = PrStart + 1 WHERE [Prfor] = 'Company'");
        string EncData = string.Format("Comp_Id={0}", obj.Comp_ID);
        //string link = ""+ ProjectSession.absoluteSiteBrowseUrl +"/default.aspx";
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + obj.Contact_Person + ",</strong></em></span><br />" +
        " <br />" +
        " <span> Your Company <strong>" + obj.Comp_Name + "</strong> Registered successflly as Demo </span>" +
        " <br />" +
        " <span>Your login credential is following</span>" +
        " <br />" +
        " <br />" +
        " <span><strong>Your User ID : - </strong>" + obj.Comp_Email + "</span>" +
        " <br />" +
        " <span><strong>Your Password : - </strong>" + obj.Password + "</span>" +
        " <br />you are just few seconds away to enjoy the services of VCQRU.COM <br />" +
        " <br />" +
        " <p>" +
        " <div class='w_detail'>" +
        " Assuring you  of  our best services always.<br />" +
        " Thank you,<br /><br />" +
        " Team <em><strong>VCQRU.COM,</strong></em><br />" +
        "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";
        DataSet dsMl = function9420.FetchMailDetail("register");
        if (dsMl.Tables[0].Rows.Count > 0)
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Comp_Email, MailBody, "Company Registration");
        result = "<b>Dear " + contactpersion + "</b><br/> Thanks for registration with us. Please check your email for your login details  <br/> <br/> <b> Thank you,</b> <br/> Team: VCQRU.COM <br/>  " + ProjectSession.sales_accomplishtrades + " ";
        return result;
    }

    public static string DemoPackeageCode(string PackeageCode)
    {
        string result = "";
        DataSet dsNewChk = SQL_DB.ExecuteDataSet("SELECT [Entry_Flag],[Email_ID] FROM [Allcation_Demo] where [Packet_Name] = '" + PackeageCode.Trim() + "'");
        if (dsNewChk.Tables[0].Rows.Count > 0 && dsNewChk.Tables[0].Rows[0]["Entry_Flag"].ToString() == "1")
        {
            result = "Packet secret code already registered !";
            return result;
        }
        else if (dsNewChk.Tables[0].Rows.Count > 0 && dsNewChk.Tables[0].Rows[0]["Entry_Flag"].ToString() == "0")
        {
            DataTable rdt = SQL_DB.ExecuteDataTable("SELECT IsRetailer FROM Comp_Reg WHERE Comp_Email= '" + dsNewChk.Tables[0].Rows[0]["Email_ID"].ToString() + "'");
            if (rdt.Rows.Count > 0)
            {
                if (Convert.ToInt32(rdt.Rows[0]["IsRetailer"]) == 1)
                {
                    result = "Packet secret code already registered !";
                    return result;
                }
            }
        }
        DataSet ds = Business9420.function9420.CheckDemoPackageCodes(PackeageCode.Trim());
        DataSet ds1 = Business9420.function9420.CheckDemoPackageCodesRows(PackeageCode.Trim());
        if (ds1.Tables[0].Rows.Count > 0)
        {
            DataSet dsAllot = SQL_DB.ExecuteDataSet("SELECT [Email_ID],[Comp_Name],[Contact_No],[Contact_Name],[Packet_Name] FROM [Allcation_Demo] where [Packet_Name] = '" + PackeageCode.Trim() + "'");
            if (dsAllot.Tables[0].Rows.Count > 0)
            {
                result = dsAllot.Tables[0].Rows[0]["Email_ID"].ToString() + '#' + dsAllot.Tables[0].Rows[0]["Comp_Name"].ToString() + '#' + dsAllot.Tables[0].Rows[0]["Contact_Name"].ToString() + '#' + dsAllot.Tables[0].Rows[0]["Contact_No"].ToString();
            }
            else
            {
                result = "Invalid packet secret code !";
                return result;
            }
            return result;
        }
        if (result == "")
        {
            result = "Invalid packet secret code !";
        }
        return result;
    }
    public static string loginEmp(string userid, string pass, int remember)
    {
        string result = "1";
        //Object9420 Log = new Business9420.Object9420();
        //if (userid.ToUpper() == "ADMIN")
        //{
        //    userid = "";
        //    pass = "";
        //    result = "1";
        //    return result;
        //}
        //else
        //{
        //Log.User_Type = "Employee";
        //  Log.User_ID = userid.Trim().Replace("'", "''");
        //  Log.Password = pass.Trim().Replace("'", "''");

        DataSet ds = SQL_DB.ExecuteDataSet("SELECT * FROM [Employee] where [email]='" + userid + "' AND [Pwd]='" + pass + "' AND [Active]=1 ");
        if (ds.Tables[0].Rows.Count > 0)
        {
            HttpContext.Current.Session["User_Type"] = "Employee";
            DataTable dt = ds.Tables[0];
            ProjectSession.strEmployeeName = dt.Rows[0]["name"].ToString();
            ProjectSession.strEmployeeEmail = dt.Rows[0]["email"].ToString();
            if (remember == 1)
            {
                HttpContext.Current.Response.Cookies["EquixUserNameEmp"].Value = dt.Rows[0]["email"].ToString();
                HttpContext.Current.Response.Cookies["EquixPasswordEmp"].Value = dt.Rows[0]["pwd"].ToString();
                HttpContext.Current.Response.Cookies["EquixUserNameEmp"].Expires = DateTime.Now.AddDays(15);
                HttpContext.Current.Response.Cookies["EquixPasswordEmp"].Expires = DateTime.Now.AddDays(15);
            }
            else if (remember == 2)
            {
                HttpContext.Current.Response.Cookies["EquixUserNameEmp"].Value = null;
                HttpContext.Current.Response.Cookies["EquixPasswordEmp"].Value = null;
            }


        }
        else
        {
            result = "3";
            return result;
        }
        return result;


    }
    public static string login(string userid, string pass, int remember)
    {
        string result = "";
        Object9420 Log = new Business9420.Object9420();
        if (userid.ToUpper() == "ADMIN")
        {
            userid = "";
            pass = "";
            result = "1";
            return result;
        }
        else
        {
            Log.User_Type = "Customer Care";
            Log.User_ID = userid.Trim().Replace("'", "''");
            Log.Password = pass.Trim().Replace("'", "''");
            if (Business9420.function9420.FetchDataForCustonerLogin(Log))
            {
                HttpContext.Current.Session["User_Type"] = "Customer Care";
                if (HttpContext.Current.Session["User_Type"] != null && HttpContext.Current.Request.QueryString["Page"] == null)
                {
                    SQL_DB.ExecuteNonQuery("INSERT INTO [Login_Summary](User_ID,Login_Date,User_Type) VALUES ('" + HttpContext.Current.Session["User_Type"].ToString() + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' ,1)");
                    HttpContext.Current.Response.Redirect("Dashboard.aspx");
                }
                else if (HttpContext.Current.Session["User_Type"] != null && HttpContext.Current.Request.QueryString["Page"] != null)
                {
                    SQL_DB.ExecuteNonQuery("INSERT INTO [Login_Summary](User_ID,Login_Date,User_Type) VALUES ('" + HttpContext.Current.Session["User_Type"].ToString() + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' ,1)");
                    HttpContext.Current.Response.Redirect(HttpContext.Current.Request.QueryString["Page"].ToString());
                }
            }

        }

        Log.Comp_Email = userid.Trim().Replace("'", "''");
        Log.Password = pass.Trim().Replace("'", "''");
        DataSet dsPass = SQL_DB.ExecuteDataSet("SELECT [IsRetailer],[Comp_ID],[Comp_Email],[Comp_Name],[Comp_type],[Status],[Delete_Flag],[ResiAddress],[DirectorName],[AadharNumber],[DirectorFatherName] FROM [Comp_Reg] where isnull(delete_flag,0) =1 " +
            " and [Comp_Email] = '" + Log.Comp_Email + "' and [Password] = '" + Log.Password + "' and [Email_Vari_Flag] = '1'  "); //and isnull(delete_flag,1) =1
        if (dsPass.Tables[0].Rows.Count > 0)
        {
            if (remember == 1)
            {
                HttpContext.Current.Response.Cookies["EquixUserName"].Value = Log.Comp_Email;
                HttpContext.Current.Response.Cookies["EquixPassword"].Value = pass.Trim();
                HttpContext.Current.Response.Cookies["EquixUserName"].Expires = DateTime.Now.AddDays(15);
                HttpContext.Current.Response.Cookies["EquixPassword"].Expires = DateTime.Now.AddDays(15);
            }
            else if (remember == 2)
            {
                HttpContext.Current.Response.Cookies["EquixUserName"].Value = null;
                HttpContext.Current.Response.Cookies["EquixPassword"].Value = null;
            }
            try
            {

                Log.Comp_ID = dsPass.Tables[0].Rows[0]["Comp_ID"].ToString();
                string path = HttpContext.Current.Server.MapPath("Data/Sound");
                path = path + "\\" + dsPass.Tables[0].Rows[0]["Comp_ID"].ToString().Substring(5, 4);
                DataProvider.Utility.CreateDirectory(path);
                path = path + "\\" + dsPass.Tables[0].Rows[0]["Comp_ID"].ToString().Substring(5, 4) + ".wav";
                int docflag = Convert.ToInt32(function9420.GetUploadDocStatus(Log));
                int Verdocflag = Convert.ToInt32(function9420.VerifyDocStatus(Log));
                int statusflag = Convert.ToInt32(dsPass.Tables[0].Rows[0]["Status"]);
                int delflag = Convert.ToInt32(dsPass.Tables[0].Rows[0]["Delete_Flag"]);
                Log.Dial_Mode = GetIP();


                SQL_DB.ExecuteNonQuery("INSERT INTO [Login_History](Dial_Mode,User_ID,Login_Date,User_Type) VALUES ('" + Log.Dial_Mode + "','" + dsPass.Tables[0].Rows[0]["Comp_ID"].ToString() + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' ,0)");
                if (delflag == 1)
                {
                    HttpContext.Current.Session["Status"] = Convert.ToString(dsPass.Tables[0].Rows[0]["Status"]);
                    HttpContext.Current.Session["User_Type"] = "Company"; //ViewState["User_Type"] = "Company";
                    HttpContext.Current.Session["Comp_type"] = dsPass.Tables[0].Rows[0]["Comp_type"].ToString();
                    HttpContext.Current.Session["CompanyId"] = dsPass.Tables[0].Rows[0]["Comp_ID"].ToString();
                    HttpContext.Current.Session["Comp_Name"] = dsPass.Tables[0].Rows[0]["Comp_Name"].ToString();
                    HttpContext.Current.Session["IsRetailer"] = dsPass.Tables[0].Rows[0]["IsRetailer"].ToString();
                    ProjectSession.strCompanyid = dsPass.Tables[0].Rows[0]["Comp_ID"].ToString();
                    ProjectSession.strCompanyName = dsPass.Tables[0].Rows[0]["Comp_Name"].ToString();
                    ProjectSession.strUserEmail = dsPass.Tables[0].Rows[0]["Comp_Email"].ToString();
                    //ProjectSession.strMobileNo = dsPass.Tables[0].Rows[0]["Mobile"].ToString();
                }

                #region //** Terms and Conditions
                if (dsPass.Tables[0].Rows[0]["ResiAddress"].ToString() == "" || dsPass.Tables[0].Rows[0]["DirectorName"].ToString() == "" || dsPass.Tables[0].Rows[0]["DirectorFatherName"].ToString() == "" || dsPass.Tables[0].Rows[0]["AadharNumber"].ToString() == "")
                {
                    HttpContext.Current.Session["MyNewMessageTC"] = null;
                    HttpContext.Current.Session["MyNewMessageTC"] = @"<div style='margin: 0 auto;width: 450px;border: 2px solid #dee2e6;padding: 1rem;border-radius: 8px;'>
        <div style='text-align: center;'>
            <img src='https://cdn-icons-png.flaticon.com/512/4539/4539472.png' alt='alert icon' style='height: 8rem;'>
        </div>
        <p style='line-height: 1.4;'>Your account has been temporarily deactivated due to the expiration of your KYC. To
            reactivate your account
            and resume services, kindly complete the re-KYC process by <a href='CompProfile.aspx'>updating your profile</a>, <a
                href='frmUploadDocuments.aspx'>uploading the required</a>
            documents, and accepting our terms of use.</p>
        <p style='line-height: 1.4;'>If you have already completed this process, please wait for activation from the
            ADMIN or contact your VCQRU
            account manager for further assistance.</p>
        <p style='line-height: 1.4;'>Thank you for your prompt attention to this matter.
        </p>
        <p style='line-height: 1.4;'>Best regards,<br><span style='color: #000;'>Team VCQRU</span></p>
    </div>";

                    result = "6";
                    return result;
                }
                #endregion

                if ((dsPass.Tables[0].Rows[0]["Comp_type"].ToString() == "L") && (delflag == 1))
                {
                    if (!File.Exists(path))
                    {
                        HttpContext.Current.Session["MyNewMessage"] = "Your account is in-active, please <a href='CompProfile.aspx' style='color:blue;'> update your profile </a> & <a href='frmUploadDocuments.aspx' style='color:blue;'> upload required documents</a>. If already done , please wait for activation from ADMIN.";
                        //HttpContext.Current.Response.Redirect("Manufacturer/CompProfile.aspx");
                        result = "4";
                    }
                    else if ((File.Exists(path)) && (docflag == 0))
                    {
                        if (!chkDoc(dsPass.Tables[0].Rows[0]["Comp_ID"].ToString()))
                        {
                            HttpContext.Current.Session["MyNewMessage"] = "Your account is in-active, please <a href='CompProfile.aspx' style='color:blue;'> update your profile </a> & <a href='frmUploadDocuments.aspx' style='color:blue;'> upload required documents</a>. If already done , please wait for activation from ADMIN.";
                            //HttpContext.Current.Response.Redirect("Manufacturer/frmUploadDocuments.aspx");
                            result = "5";
                        }
                        else
                        {
                            HttpContext.Current.Session["MyNewMessage"] = "Your account is in-active, please <a href='CompProfile.aspx' style='color:blue;'> update your profile </a> & <a href='frmUploadDocuments.aspx' style='color:blue;'> upload required documents</a>. If already done , please wait for activation from ADMIN.";
                            //HttpContext.Current.Response.Redirect("Manufacturer/Message.aspx");
                            result = "6";
                        }
                    }
                    else if ((File.Exists(path)) && (docflag == 1) && (Verdocflag != 7))
                    {
                        HttpContext.Current.Session["MyNewMessage"] = "Your account is in-active, please contact to admin.";
                        HttpContext.Current.Response.Redirect("Manufacturer/Message.aspx");
                    }
                    else if ((File.Exists(path)) && (docflag == 1) && (Verdocflag == 7) && (statusflag == 1))
                        HttpContext.Current.Response.Redirect("Manufacturer/Dashboard.aspx");
                    else if ((File.Exists(path)) && (docflag == 1) && (Verdocflag == 7) && (statusflag == 0))
                    {
                        HttpContext.Current.Session["MyNewMessage"] = "Your account is in-active, please contact to admin.";
                        HttpContext.Current.Response.Redirect("Manufacturer/Message.aspx");
                    }
                }
                else if ((dsPass.Tables[0].Rows[0]["Comp_type"].ToString() == "L") && (delflag == 0))
                {
                    result = "2";
                    return result;
                }
                else
                {
                    if (delflag == 1)
                    {
                        if (!File.Exists(path))
                        {
                            HttpContext.Current.Session["MyNewMessage"] = "Your account has been registered as demo user please <a href='UpDateCompanyProfileDemo.aspx' style='color=blue;'>update your profile</a>";
                            HttpContext.Current.Response.Redirect("Manufacturer/UpDateCompanyProfileDemo.aspx");
                        }
                        #region //** Terms and Conditions
                        if (dsPass.Tables[0].Rows[0]["ResiAddress"].ToString() == "" || dsPass.Tables[0].Rows[0]["DirectorName"].ToString() == "" || dsPass.Tables[0].Rows[0]["DirectorFatherName"].ToString() == "" || dsPass.Tables[0].Rows[0]["AadharNumber"].ToString() == "")
                        {
                            HttpContext.Current.Session["MyNewMessageTC"] = null;
                            HttpContext.Current.Session["MyNewMessageTC"] = @"<div style='margin: 0 auto;width: 450px;border: 2px solid #dee2e6;padding: 1rem;border-radius: 8px;'>
        <div style='text-align: center;'>
            <img src='https://cdn-icons-png.flaticon.com/512/4539/4539472.png' alt='alert icon' style='height: 8rem;'>
        </div>
        <p style='line-height: 1.4;'>Your account has been temporarily deactivated due to the expiration of your KYC. To
            reactivate your account
            and resume services, kindly complete the re-KYC process by <a href='CompProfile.aspx'>updating your profile</a>, <a
                href='frmUploadDocuments.aspx'>uploading the required</a>
            documents, and accepting our terms of use.</p>
        <p style='line-height: 1.4;'>If you have already completed this process, please wait for activation from the
            ADMIN or contact your VCQRU
            account manager for further assistance.</p>
        <p style='line-height: 1.4;'>Thank you for your prompt attention to this matter.
        </p>
        <p style='line-height: 1.4;'>Best regards,<br><span style='color: #000;'>Team VCQRU</span></p>
    </div>";

                            result = "6";
                            return result;
                        }
                        #endregion
                        else if ((File.Exists(path)) && (statusflag == 0))
                        {
                            HttpContext.Current.Session["MyNewMessage"] = "Your account is in-active, please wait for activation from ADMIN.";
                            HttpContext.Current.Response.Redirect("Manufacturer/Message.aspx");
                        }
                        else if ((File.Exists(path)) && (statusflag == 1))
                        {
                            HttpContext.Current.Session["MyNewMessage"] = "You are registered as demo user.";
                            HttpContext.Current.Response.Redirect("Manufacturer/Dashboard.aspx");
                        }
                    }
                    else
                    {
                        result = "2";
                        return result;
                    }
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        else
        {
            result = "3";
            return result;
        }
        return result;
    }

    private static bool chkDoc(string p)
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = p;
        DataSet ds = function9420.ChkUploadDocFlag(Reg);
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    private static string GetIP()
    {
        string Ipaddress;
        Ipaddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (Ipaddress == "" || Ipaddress == null)
        {
            Ipaddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }

        return Ipaddress;
    }


    public static string saveinterusted(string InterCompNm, string InterEmail, string InterUserNm, string InterMobileNo)
    {
        string result = "";
        Object9420 obj = new Object9420();
        obj.Comp_Name = InterCompNm.Trim().Replace("'", "''").ToString();
        obj.Comp_Email = InterEmail.Trim().Replace("'", "''").ToString();
        obj.Contact_Person = InterUserNm.Trim().Replace("'", "''").ToString();
        obj.Mobile_No = InterMobileNo.Trim().Replace("'", "''").ToString();
        obj.Status = 0;
        obj.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        function9420.InterestedAsDemo(obj);
        #region Mial Body
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>" + InterUserNm + ",</strong></em></span><br />" +
        " <br />" +
        "<br/> Your Interest for demo for VCQRU.COM Services has been received successfully. <br/> " +
        " Your details : -   <br />" +
        " <span><em><strong>Contact Person : -</strong></em> " + obj.Contact_Person + "</span><br />" +
        " <span><em><strong>Company Name : -</strong></em> " + obj.Comp_Name + "</span><br />" +
        " <span><em><strong>Mobile No : -</strong></em> " + obj.Mobile_No + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + obj.Comp_Email + "</span><br />" +
        " <span>Thank you for choosing VCQRU.COM</span><br/>" +
        " We will contact you soon.   <br />" +
        " <br />" +
        " <br />" +
        " <p>" +
        " <div class='w_detail'>" +
        " Assuring you  of  our best services always.<br />" +
        " Thank you,<br /><br />" +
        " Team <em><strong>VCQRU.COM,</strong></em><br />" +
        "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";

        string MailBody1 = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        " <hr style='border:1px solid #2587D5;'/>" +
        " <div class='w_frame'>" +
        " <p>" +
        " <div class='w_detail'>" +
        " <span>Dear <em><strong>, Sales person</strong></em></span><br />" +
        " <br />" +
        "<br/> <strong>" + obj.Comp_Name + "</strong> send Interested for demo request successfully. <br/> " +
        " Interested for Demo Manufacturer details : -   <br />" +
        " <span><em><strong>Contact Person : -</strong></em> " + obj.Contact_Person + "</span><br /></div>" +
        " <span><em><strong>Company Name : -</strong></em> " + obj.Comp_Name + "</span><br />" +
        " <span><em><strong>Mobile No : -</strong></em> " + obj.Mobile_No + "</span><br />" +
        " <span><em><strong>Email ID : -</strong></em> " + obj.Comp_Email + "</span><br />" +
        " Thank you,<br /><br />" +
        " Team <em><strong>VCQRU.COM,</strong></em><br />" +
        "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
        " </div>" +
        " </p>" +
        " </div>" +
        " </p>" +
        " </div> " +
        " </div> ";
        #endregion
        DataSet dsMl = function9420.FetchMailDetail("register");
        if (dsMl.Tables[0].Rows.Count > 0)
        {
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Comp_Email, MailBody, "Interested for Demo Registration");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.admin_accomplishtrades, MailBody1, "Interested for Demo Registration");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Marketing_accomplishtrades, MailBody1, "Interested for Demo Registration");
        }
        result = "<b>Dear " + InterUserNm + "</b><br/> Thanks for registration with us. Our team will contact you soon. <br/> <br/> <b> Thank you,</b> <br/> Team: VCQRU.COM <br/>  " + ProjectSession.sales_accomplishtrades + " ";
        return result;

    }


    public static int logout()
    {
        int result = 0;
        string IP = GetIP();
        if (HttpContext.Current.Session["User_Type"].ToString() == "Admin")
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Login_History] SET [Logout_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE CONVERT(VARCHAR,Login_Date,111)= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' AND User_ID = '" + HttpContext.Current.Session["User_Type"].ToString() + "'  AND user_Type = 1 AND (Dial_Mode = '" + IP + "')  AND Row_ID = (SELECT MAX(Row_ID) FROM  Login_History WHERE  User_ID = '" + HttpContext.Current.Session["User_Type"].ToString() + "'  AND (Dial_Mode = '" + IP + "') ) ");
            HttpContext.Current.Session.Abandon();
            //HttpContext.Current.Response.Redirect("Admin/Login.aspx");
            result = 1;
        }
        if (HttpContext.Current.Session["User_Type"].ToString() == "Consumer")
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Login_History] SET [Logout_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE CONVERT(VARCHAR,Login_Date,111)= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' AND User_ID = '" + HttpContext.Current.Session["User_Type"].ToString() + "'  AND user_Type = 1 AND (Dial_Mode = '" + IP + "')  AND Row_ID = (SELECT MAX(Row_ID) FROM  Login_History WHERE  User_ID = '" + HttpContext.Current.Session["USRID"].ToString() + "'  AND (Dial_Mode = '" + IP + "') ) ");
            HttpContext.Current.Session.Abandon();
            //HttpContext.Current.Response.Redirect("Index.aspx");
            result = 2;
        }
        else
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Login_History] SET [Logout_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE CONVERT(VARCHAR,Login_Date,111)= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' AND User_ID = '" + HttpContext.Current.Session["CompanyId"].ToString() + "'  AND user_Type = 0 AND (Dial_Mode = '" + IP + "')  AND Row_ID = (SELECT MAX(Row_ID) FROM  Login_History WHERE  User_ID = '" + HttpContext.Current.Session["CompanyId"].ToString() + "'  AND (Dial_Mode = '" + IP + "') ) ");
            HttpContext.Current.Session.Abandon();
            //HttpContext.Current.Response.Redirect("Index.aspx");
            result = 3;
        }
        return result;
    }
    public static string deleteaccount()
    {
        return "Your account has been deleted permanently, please contact to admin.";
    }
    public static string verifyresetpwd(string value)
    {
        string result = "";
        string mailstatsflag = value;
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Mail_Status] FROM [ResetPassword] where [Encrypt_Value] = '" + mailstatsflag.Replace(" ", "+") + "'");   //where User_ID = '" + ds1.Tables[0].Rows[0]["User_ID"].ToString() + "'
        if (ds.Tables[0].Rows.Count > 0)
        {
            if (ds.Tables[0].Rows[0]["Mail_Status"].ToString() == "1")
            {
                result = "Link expired, Please try again.";
            }
            else
            {
                SQL_DB.ExecuteNonQuery("update ResetPassword set Mail_Status = 1 where [Encrypt_Value] = '" + mailstatsflag.Replace(" ", "+") + "'");
                result = "yes";
            }
        }
        return result;
    }
    public static string DecryptCode(string name)
    {
        if (!string.IsNullOrEmpty(name))
        {
            return DataProvider.LogManager.Decrypt(name);
        }
        else
        {
            return "";
        }
    }
    public static string CheckReferral(string c1, string c2)
    {
        if (!string.IsNullOrEmpty(c1) && !string.IsNullOrEmpty(c2))
        {
            //return DataProvider.LogManager.Decrypt(name);
            //SQL_DB.ExecuteScalar("select row_id from ");
            //CheckReferral
            DataSet ds = ExecuteNonQueryAndDatatable.CheckReferral(c1, c2);
            if (ds.Tables.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    string strval = Convert.ToString(dt.Rows[0][0]);
                    if (!string.IsNullOrEmpty(strval))
                        return strval;
                    else
                    {
                        return "";
                    }
                }
                else
                {
                    return "";
                }
            }
        }
        return "";
    }

    public static string checkWarranty(string C1, string C2, string CompId = "")
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = CompId;
        Reg.Received_Code1 = (C1.Trim().Replace("'", "''"));
        Reg.Received_Code2 = (C2.Trim().Replace("'", "''"));

        DataSet ds = ServiceLogic.FindCheckedCode_2(Reg);
        DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
        if (ds.Tables[0].Rows.Count == 0)
        {
            #region// TemplateId for InvalidSMS
            string result = "The entered code is invalid. Please enter correct 13-digit code or call us on 7353000903. www.vcqru.com";
            ServiceLogic.SendSmsfromknowlarity(result, Reg.Mobile_No, "1007709448324581324");
            #endregion;  

            Reg.Is_Success = 0;
            //Business9420.function9420.InsertCodeChecked(Reg);
            return ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, C1, C1, "Service_ID='InvalidCode'");
            // result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
            // return result; // it should if not graranted shweta

        }
        else
        {
            if (!string.IsNullOrEmpty(C1) && !string.IsNullOrEmpty(C2))
            {
                ds = ExecuteNonQueryAndDatatable.CheckWarranty(C1, C2, CompId);
                if (ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        if (dt.Columns.Contains("PlanName"))
                        {
                            string strval = Convert.ToString(dt.Rows[0]["PlanName"]);
                            if (!string.IsNullOrEmpty(strval))
                                return strval;
                            else
                                return "";
                        }
                        else
                        {
                            //string strval = Convert.ToString(dt.Rows[0][1]);
                            string strval = Convert.ToString(dt.Rows[0][0]);
                            if (strval.Split('&').Length > 3)
                                HttpContext.Current.Session["service"] = strval.Split('&')[3];
                            if (!string.IsNullOrEmpty(strval))
                            {
                                if (strval.Split('&').Length > 0)
                                    HttpContext.Current.Session["companyname"] = strval.Split('&')[1];
                                return strval;
                            }
                            else
                                return "";
                        }
                    }
                    else
                    {
                        return "";
                    }
                }
            }
            return "";
        }
    }
    public static string appcheckWarranty(string C1, string C2, string MobileNo, string mode)
    {
        Object9420 Reg = new Object9420();
        app_details app = new app_details();
        Reg.Received_Code1 = (C1.Trim().Replace("'", "''"));
        Reg.Received_Code2 = (C2.Trim().Replace("'", "''"));
        string result = "";

        if (MobileNo == "")
        {
            result = "Kindly Enter Your Mobile No.";
        }

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
        Reg.Mobile_No = MobileNo;
        if (result != "")
        {
            app.message = result;
            // result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
            // return result; // it should if not graranted shweta
            app.status = "Error";
            return JsonConvert.SerializeObject(app, Formatting.Indented);
        }

        Reg.Dial_Mode = mode;
        string fields = string.Empty;
        string proIDD = ""; // added by tej
        DataSet ds = ServiceLogic.FindCheckedCode_2(Reg);
        DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
        string distributorid = SQL_DB.ExecuteScalar("select case when distributorID is null or distributorID='' then '0' else distributorid end distributorid from m_consumer where mobileno='" + MobileNo + "'").ToString();
        //string employeeid = SQL_DB.ExecuteScalar("select case when employeeid is null or employeeid='' then '0' else employeeid end employeeid from m_consumer where mobileno='" + MobileNo + "'").ToString();

        if (ds.Tables[0].Rows.Count > 0)
        {
            proIDD = ds.Tables[0].Rows[0]["Pro_ID"].ToString();  // added by tej

        }
        if (ds.Tables[0].Rows.Count == 0)
        {
            Reg.Is_Success = 0;
            Business9420.function9420.appInsertCodeChecked(Reg);
            app.message = ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, C1, C2, "Service_ID='InvalidCode'");
            // result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
            // return result; // it should if not graranted shweta
            app.status = "Invalid";
            return JsonConvert.SerializeObject(app, Formatting.Indented);

        }
        else
        {
            if (!string.IsNullOrEmpty(C1) && !string.IsNullOrEmpty(C2))
            {
                ds = ExecuteNonQueryAndDatatable.appCheckWarranty(C1, C2);
                if (ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        if (dt.Columns.Contains("PlanName"))
                        {
                            string strval = Convert.ToString(dt.Rows[0]["PlanName"]);
                            if (!string.IsNullOrEmpty(strval))
                                return strval;
                            else
                                return "";
                        }
                        else
                        {
                            //string strval = Convert.ToString(dt.Rows[0][1]);
                            //string strval = Convert.ToString(dt.Rows[0][0]);
                            //if(strval.Length>0)
                            //    HttpContext.Current.Session["service"] = strval.Split('&')[3];
                            //if (!string.IsNullOrEmpty(strval))
                            //    return strval;
                            //else
                            //    return "";
                            string VrUser_Type = "";
                            string CompanyName1 = ds.Tables[0].Rows[0][0].ToString().Split('&')[0];
                            if (CompanyName1 != "" && CompanyName1 == "VR KABLE INDIA PRIVATE LIMITED")
                            {
                                string KycCheck = SQL_DB.ExecuteScalar("select VRKbl_KYC_status from dbo.[m_consumer] where MobileNo='" + MobileNo + "'").ToString();
                                if (KycCheck == "1" || KycCheck == "0")
                                {
                                    DataTable dt1 = SQL_DB.ExecuteDataTable("select Vrkabel_User_Type from M_Consumer where MobileNo='" + MobileNo + "'");
                                    string VrUserRole = "";
                                    if (dt1.Rows.Count > 0)
                                    {
                                        VrUser_Type = dt1.Rows[0]["Vrkabel_User_Type"].ToString();
                                        if (VrUser_Type == "1")
                                        {
                                            VrUserRole = "Dealer";
                                        }
                                        else if (VrUser_Type == "2")
                                        {
                                            VrUserRole = "Retailer";
                                        }
                                        else if (VrUser_Type == "3")
                                        {
                                            VrUserRole = "Counter Boy";
                                        }
                                        else if (VrUser_Type == "4")
                                        {
                                            VrUserRole = "Electrician";
                                        }
                                    }
                                    if (VrUser_Type == "")
                                    {
                                        app.message = "Role is not activate!";
                                        app.status = "Invalid";
                                        return JsonConvert.SerializeObject(app, Formatting.Indented);
                                    }

                                    else if (VrUser_Type == "4" && proIDD == "AK01") // electrician use one time this profuct code diwali offer
                                    {
                                        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                                        con.Open();
                                        SqlCommand cmd = new SqlCommand("CheckCodeCountExibitionVRKable", con);
                                        cmd.CommandType = CommandType.StoredProcedure;
                                        cmd.Parameters.AddWithValue("@Compname", "VR KABLE INDIA PRIVATE LIMITED");
                                        cmd.Parameters.AddWithValue("@mobileno", MobileNo);
                                        cmd.Parameters.AddWithValue("@proid", proIDD);

                                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                                        DataTable countcd = new DataTable();
                                        da.Fill(countcd);
                                        con.Close();
                                        if (countcd.Rows.Count > 0)
                                        {
                                            app.message = "You have already verified the coupon of the Diwali scheme!";
                                            app.status = "Invalid";
                                            return JsonConvert.SerializeObject(app, Formatting.Indented);
                                        }
                                    }

                                    if (VrUser_Type == "2" && (proIDD == "AH91" || proIDD == "AH92" || proIDD == "AJ41" || proIDD == "AJ42" || proIDD == "AJ43" || proIDD == "AJ44")) // retailer
                                    {
                                    }
                                    else if (VrUser_Type == "3" && (proIDD == "AH94" || proIDD == "AH93" || proIDD == "AL91")) // counter boy
                                    {
                                    }
                                    else if (VrUser_Type == "4" && (proIDD == "AO29" || proIDD == "AM46" || proIDD == "AH86" || proIDD == "AH87" || proIDD == "AH88" || proIDD == "AH89" || proIDD == "AH90" || proIDD == "AI23" || proIDD == "AJ39" || proIDD == "AJ40" || proIDD == "AK01" || proIDD == "AL66" || proIDD == "AL67" || proIDD == "AL68" || proIDD == "AL93" || proIDD == "AL92")) // electrician
                                    {
                                    }
                                    else
                                    {
                                        app.message = "The code checked doesn't belong to " + VrUserRole + "(registered user)";
                                        app.status = "Invalid";
                                        return JsonConvert.SerializeObject(app, Formatting.Indented);
                                    }

                                }
                                else
                                {

                                    //app_details app = new app_details();
                                    result = "KYC is rejected by admin.";
                                    app.message = result;
                                    app.status = "Invalid";
                                    return JsonConvert.SerializeObject(app, Formatting.Indented);


                                }
                            }

                            // close for vr kabel ------
                            foreach (DataRow item in ds.Tables[1].Rows)
                            {
                                if ((distributorid != "0" && item["Field_name"].ToString() == "Dealer Id") || (distributorid != "0" && item["Field_name"].ToString() == "Dealer Name"))
                                { }
                                else
                                    fields += item["Field_name"].ToString() + FieldSeparator;
                            }
                            if (fields.Length > 0)
                                fields = fields.Remove(fields.LastIndexOf(FieldSeparator), FieldSeparator.Length);

                            app.code1 = C1;
                            app.code2 = C2;
                            if (ds.Tables[1].Rows.Count > 0)
                                app.ServiceId = ds.Tables[1].Rows[0]["Service_id"].ToString();
                            app.CompanyName = ds.Tables[0].Rows[0][0].ToString().Split('&')[0];
                            app.Logopath = ds.Tables[0].Rows[0][0].ToString().Split('&')[1];
                            app.fields = fields;
                            app.status = "Valid";
                            return JsonConvert.SerializeObject(app, Formatting.Indented);
                        }
                    }
                    else
                    {
                        return "";
                    }
                }
            }
            return "";
        }
    }
    public static string CheckReferralExists(string refcode, string Mno)
    {
        if (!string.IsNullOrEmpty(refcode))
        {
            Mno = ServiceLogic.GetMobileNo(Mno);
            //return DataProvider.LogManager.Decrypt(name);
            //SQL_DB.ExecuteScalar("select row_id from ");
            //CheckReferral
            DataSet ds = ExecuteNonQueryAndDatatable.CheckReferralExists(refcode, Mno);
            if (ds.Tables.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    string strval = Convert.ToString(dt.Rows[0][0]);
                    if (!string.IsNullOrEmpty(strval))
                        return strval;
                    else
                    {
                        return "";
                    }
                }
                else
                {
                    return "";
                }
            }
        }
        return "";
    }
    public static string CatchWebsiteHit()
    {
        string result = "";
        //string mailstatsflag = "";
        string strbrowser = string.Empty;
        //if (HttpContext.Current.Request.ServerVariables["HTTP_USER_AGENT"].Contains("MSIE"))
        //    strbrowser = "Internet Explorer";
        //else if (HttpContext.Current.Request.ServerVariables["HTTP_USER_AGENT"].Contains("Firefox"))
        //    strbrowser = "Mozilla";
        //else if (HttpContext.Current.Request.ServerVariables["HTTP_USER_AGENT"].Contains("Chrome"))
        //    strbrowser = "Mozilla";
        //else if (HttpContext.Current.Request.ServerVariables["HTTP_USER_AGENT"].Contains("Opera"))
        //    strbrowser = "Opera";
        //else 
        if (HttpContext.Current.Request.Browser.IsMobileDevice)
        {
            strbrowser = "Mobile";
            string[] mobiles =
        new[]
            {
                    "midp", "j2me", "avant", "docomo",
                    "novarra", "palmos", "palmsource",
                    "240x320", "opwv", "chtml",
                    "pda", "windows ce", "mmp/",
                    "blackberry", "mib/", "symbian",
                    "wireless", "nokia", "hand", "mobi",
                    "phone", "cdm", "up.b", "audio",
                    "SIE-", "SEC-", "samsung", "HTC",
                    "mot-", "mitsu", "sagem", "sony"
                    , "alcatel", "lg", "eric", "vx",
                    "NEC", "philips", "mmm", "xx",
                    "panasonic", "sharp", "wap", "sch",
                    "rover", "pocket", "benq", "java",
                    "pt", "pg", "vox", "amoi",
                    "bird", "compal", "kg", "voda",
                    "sany", "kdd", "dbt", "sendo",
                    "sgh", "gradi", "jb", "dddi",
                    "moto", "iphone"
            };

            //Loop through each item in the list created above 
            //and check if the header contains that text
            foreach (string s in mobiles)
            {
                if (HttpContext.Current.Request.ServerVariables["HTTP_USER_AGENT"].
                                                    ToLower().Contains(s.ToLower()))
                {
                    strbrowser = strbrowser + " - " + s.ToLower();
                }
            }
        }

        //  SQL_DB.ExecuteNonQuery("Insert into WebsiteHitHistory values ('" + GetIP() + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now) + "','" + strbrowser + "')");
        //if (ds.Tables[0].Rows.Count > 0)
        //{
        //    if (ds.Tables[0].Rows[0]["Mail_Status"].ToString() == "1")
        //    {
        //        result = "Link expired, Please try again.";
        //    }
        //    else
        //    {
        //        SQL_DB.ExecuteNonQuery("update ResetPassword set Mail_Status = 1 where [Encrypt_Value] = '" + mailstatsflag.Replace(" ", "+") + "'");
        //        result = "yes";
        //    }
        //}
        return result;
    }
    public static string verifyaccount(string value)
    {
        string result = "";
        string compid = Decrypt(value.Replace(" ", "+"));
        string key = "select Email_Vari_Flag,Comp_Email,Comp_Name,Contact_Person from Comp_Reg where Comp_ID = '" + compid + "'";
        DataSet ds = SQL_DB.ExecuteDataSet("select Email_Vari_Flag,Comp_Email,Comp_Name,Contact_Person from Comp_Reg where Comp_ID = '" + compid + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            string ps = "";
            if (ds.Tables[0].Rows[0]["Email_Vari_Flag"].ToString() == "0")
            {
                SQL_DB.ExecuteNonQuery("update Comp_Reg set Email_Vari_Flag = 1 where Comp_ID = '" + compid + "'");
                Random rnd = new Random();
                ps = rnd.Next().ToString().Substring(0, 5);
                SQL_DB.ExecuteNonQuery("UPDATE [Comp_Reg] SET [Password]='" + ps + "' WHERE [Comp_ID]='" + compid + "'");
                #region MailBody
                string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
                " <hr style='border:1px solid #2587D5;'/>" +
                " <div class='w_frame'>" +
                " <p>" +
                " <div class='w_detail'>" +
                " <span>Dear <em><strong>" + ds.Tables[0].Rows[0]["Contact_Person"].ToString() + ",</strong></em></span><br />" +
                " <br />" +
                " <span>Congratulations !!!</span>" +
                " <br />Your login details are as follows:- <br />" +
                " <table border='0' cellspacing='2'>" +
                " <tr>" +
                " <td width='70' align='left'><strong>Login ID :&nbsp; </strong></td>" +
                " <td width='282'><a href='#'>" + ds.Tables[0].Rows[0]["Comp_Email"].ToString() + "</a></td>" +
                " </tr>" +
                " <tr>" +
                " <td align='left' valign='top'><strong>Password :&nbsp;</strong></td>" +
                " <td>" + ps + "</td>" +
                " </tr>" +
                "<tr><td colspan='2'><a href='" + ProjectSession.absoluteSiteBrowseUrl + "/default.aspx#logsign'  target='_blank'><strong>CLICK HERE TO LOGIN</strong></a></td></tr>" +
                " </table>" +
                " <tr>" +
                " <td align='left' valign='top' colspan='2'><strong>Please login with above credentials and upload your company documents. Then please wait for our notification on your document verification and account activation <br> If you face any problem in login with above credentials, please feel free to email our support team</strong></td>" +
                " </tr>" +
                " </table>" +
                " <p>" +
                " <div class='w_detail'>" +
                " Assuring you  of  our best services always.<br />" +
                " Thank you,<br /><br />" +
                " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                " </div>" +
                " </p>" +
                " </div>" +
                " </p>" +
                " </div> " +
                " </div> ";

                string MailBody1 = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
               " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
               " <hr style='border:1px solid #2587D5;'/>" +
               " <div class='w_frame'>" +
               " <p>" +
               " <div class='w_detail'>" +
               " <span>Dear <em><strong>, Sales person</strong></em></span><br />" +
               " <br />" +
               "<br/> <strong>" + ds.Tables[0].Rows[0]["Comp_Name"].ToString() + "'s</strong> E-mail verification has been completed. <br/> " +
               " Thank you,<br /><br />" +
               " Team <em><strong>VCQRU.COM,</strong></em><br />" +
               "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
               " </div>" +
               " </p>" +
               " </div>" +
               " </p>" +
               " </div> " +
               " </div> ";

                #endregion
                DataSet dsMl = function9420.FetchMailDetail("admin");
                if (dsMl.Tables[0].Rows.Count > 0)
                {
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ds.Tables[0].Rows[0]["Comp_Email"].ToString(), MailBody, "User login credential");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Company E-mail verification");
                }
                result = "Your account has been verified successfully, Please check your registered mail for login credentials .";
            }
            else
            {
                result = "Your account is already verified.";
            }
        }
        return result;
    }
    public static string forgotpassword(string email)
    {
        string result = "";
        DataTable DtUserDetail = new DataTable();
        SQL_DB.GetDA("SELECT [Contact_Person] ,[Password],* FROM [Comp_Reg] where [Comp_Email] = '" + email.Trim() + "' and (  isnull(delete_flag,0) != 0)").Fill(DtUserDetail);
        if (DtUserDetail.Rows.Count > 0)
        {
            //DataSet dsMail = SQL_DB.ExecuteDataSet("SELECT [Comp_ID] FROM [Comp_Reg] where [Comp_Email] = '" + email.Trim() + "' ");
            // if (dsMail.Tables[0].Rows.Count > 0)
            {
                SQL_DB.ExecuteNonQuery("update ResetPassword set Mail_Status = 1 where User_ID = '" + DtUserDetail.Rows[0]["Comp_ID"].ToString() + "'");
                Random rnd = new Random();
                SQL_DB.ExecuteNonQuery("INSERT INTO [ResetPassword]" +
               " ([Entry_Date]" +
               " ,[User_ID]" +
               " ,[Encrypt_Value])" +
               " VALUES" +
               " ('" + Convert.ToDateTime(System.DateTime.Now).ToString("MM/dd/yyyy HH:mm:ss") + "'" +
               " ,'" + DtUserDetail.Rows[0]["Comp_ID"].ToString() + "'" +
               " ,'" + rnd.Next().ToString().Substring(0, 8) + "')");
            }
            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), email.Trim(), MailTemplate(DtUserDetail.Rows[0]["Contact_Person"].ToString(), (DtUserDetail.Rows[0]["Password"].ToString()), email), "Forgot Password");
            //result = "Please check your email to reset your password.";
            result = "Your password has been sent on your registered email address.";
        }
        else
        {
            result = "Your account is deleted.Please contact administrator!";
        }
        return result;
    }
    public static string forgotpasswordEmp(string email)
    {
        string result = "";
        //DataTable DtUserDetail = new DataTable();
        //SQL_DB.GetDA("SELECT [Name] ,[pwd] FROM [Employee] where [Email] = '" + email.Trim() + "' ").Fill(DtUserDetail);
        //if (DtUserDetail.Rows.Count > 0)
        //{
        //    DataSet dsMail = SQL_DB.ExecuteDataSet("SELECT [Name] ,[pwd] FROM [Employee] where [Email] = '" + email.Trim() + "' ");
        //    if (dsMail.Tables[0].Rows.Count > 0)
        //    {
        //        //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(),
        //        //    dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
        //        //    email.Trim(), MailTemplate(DtUserDetail.Rows[0]["Contact_Person"].ToString(),
        //        //    (DtUserDetail.Rows[0]["Password"].ToString()), email), "Forgot Password");
        //        // SQL_DB.ExecuteNonQuery("update ResetPassword set Mail_Status = 1 where User_ID = '" + dsMail.Tables[0].Rows[0]["Comp_ID"].ToString() + "'");
        //        // Random rnd = new Random();
        //        // SQL_DB.ExecuteNonQuery("INSERT INTO [ResetPassword]" +
        //        //" ([Entry_Date]" +
        //        //" ,[User_ID]" +
        //        //" ,[Encrypt_Value])" +
        //        //" VALUES" +
        //        //" ('" + Convert.ToDateTime(System.DateTime.Now).ToString("MM/dd/yyyy HH:mm:ss") + "'" +
        //        //" ,'" + dsMail.Tables[0].Rows[0]["Comp_ID"].ToString() + "'" +
        //        //" ,'" + rnd.Next().ToString().Substring(0, 8) + "')");
        //    }
        //    DataSet dsMl = function9420.FetchMailDetail("admin");
        //    if (dsMl.Tables[0].Rows.Count > 0)
        //        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), email.Trim(), MailTemplate(DtUserDetail.Rows[0]["Contact_Person"].ToString(), (DtUserDetail.Rows[0]["Password"].ToString()), email), "Forgot Password");
        //    result = "Please check your email to reset your password.";
        //}
        //else
        //{
        //    result = "Email ID does not exist...";
        //}
        return result;
    }

    private static string MailTemplate(string Name, string Password, string email)
    {
        string srt = "<style type='text/css'>" +
           " .latter" +
           " {" +
               " width:75%;" +
               " border:1px solid #2587D5;" +
               " display:inline-block;" +
               " -webkit-box-shadow: #D9E7FD 3px 3px 3px;" +
               " -moz-box-shadow: #D9E7FD 3px 3px 3px; " +
               " box-shadow: #D9E7FD 3px 3px 3px;" +
               " padding:5px;" +
               " margin-left:100px;" +
           " }" +
           " .latter div.w_logo" +
           " {" +
               " width:100%;" +
               " margin:0 auto;" +
               " background-position:center top;" +
               " height:70px;" +
               " margin-bottom:10px;" +
           " }" +
           " .latter div.w_logo span" +
           " {" +
               " font-size:18pt;" +
               " color:#222;" +
               " float:right;" +
               " font-weight:bold;" +
               " margin-right:45px;" +
               " margin-top:25px;" +
           " }" +
           " .latter div.w_logo img" +
           " {" +
               " height:29px;" +
               " width:300px;" +
           " }" +
           " .latter div.w_frame" +
           " {" +
               " width:98%;" +
               " margin:0 auto;" +
               " font-family:Arial, Helvetica, sans-serif;" +
               " font-size:9pt;" +
               " color:#333;" +
               " line-height:20px;" +
               " margin-bottom:10px;" +
           " }" +
           " .latter div.w_frame p" +
           " {" +
               " text-align:justify;" +
               " padding-bottom:5px;" +
           " }" +
           " .latter div.w_frame p span" +
           " {" +
               " padding-left:20px;" +
           " }" +
           " .w_detail" +
           " {" +
               " padding-left:20px;" +
               " text-align:justify;" +
           " }" +
           " .w_detail a" +
           " {" +
               " color:#095BB4;" +
               " text-decoration:none;" +
           " }" +
           " .w_detail a:hover" +
           " {" +
               " text-decoration:underline;" +
           " }" +
           " .w_foot" +
           " {" +
               " width:99%;" +
               " padding:5px;" +
               " color:#333;" +
               " font-size:8pt;" +
               " text-align:center;" +
               " line-height:13px;" +
               " margin:0 auto;" +
           " }" +
           " hr" +
           " {" +
           "  border:2px solid #2587D5" +
           " }" +
           " </style>";
        string link = "";
        DataSet dsMail = SQL_DB.ExecuteDataSet("SELECT ResetPassword.Encrypt_Value FROM [Comp_Reg] INNER JOIN ResetPassword ON [Comp_Reg].[Comp_ID] = ResetPassword.User_ID" +
        " where Comp_Reg.[Comp_Email]='" + email.Trim().Replace("'", "''").ToString() + "' and Comp_Reg.[Email_Vari_Flag]=1 and  ResetPassword.Mail_Status = 0");
        if (dsMail.Tables[0].Rows.Count > 0)
            // link = "http://54.201.1.244/index.aspx?key=" + dsMail.Tables[0].Rows[0]["Encrypt_Value"].ToString();
            link = "" + ProjectSession.absoluteSiteBrowseUrl + "/default.aspx?mlt=" + dsMail.Tables[0].Rows[0]["Encrypt_Value"].ToString();

        // string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        //       " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
        //       " <hr style='border:1px solid #2587D5;'/>" +
        //       " <div class='w_frame'>" +
        //       " <p>" +
        //       " <div class='w_detail'>" +
        //       " <span>Dear <em><strong>" + Name + ",</strong></em></span><br />" +
        //       " <br />" +
        //       " <span><em><strong>Please click the link below to reset your password :  <br/><br/>  <a href = '" + link + "' target = '_blank'> " + ProjectSession.absoluteSiteBrowseUrl + "/default.aspx?mlt=" + dsMail.Tables[0].Rows[0]["Encrypt_Value"].ToString() + " </a></strong></em></span><br/>" +
        //       " <p>" +
        //       " <div class='w_detail'>" +
        //      " Assuring you  of  our best services always.<br />" +
        //" Thank you,<br /><br />" +
        //" Team <em><strong>VCQRU.COM,</strong></em><br />" +
        //"  " + ProjectSession.sales_accomplishtrades + "  <br />" +
        //" </div>" +
        //" </p>" +
        //" </div>" +
        //" </p>" +
        //" </div> " +
        //" </div> ";

        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
         " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
         " <hr style='border:1px solid #2587D5;'/>" +
         " <div class='w_frame'>" +
         " <p>" +
         " <div class='w_detail'>" +
         " <span>Dear <em><strong>" + Name + ",</strong></em></span><br />" +
         " <br />" +
         " <span><em><strong>password : " + Password +
         " <p>" +
         " <div class='w_detail'>" +
        " Assuring you  of  our best services always.<br />" +
    " Thank you,<br /><br />" +
    " Team <em><strong>VCQRU.COM,</strong></em><br />" +
    "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
    " </div>" +
    " </p>" +
    " </div>" +
    " </p>" +
    " </div> " +
    " </div> ";
        return MailBody;
    }



    /// <summary>
    /// /Admin Login
    /// </summary>
    public string Adminlogin(string name, string password)
    {
        string result = "";
        Object9420 Log = new Business9420.Object9420();
        if (name.ToUpper() == "ADMIN")
        {
            Log.User_Type = name.Trim().Replace("'", "''");
            Log.User_ID = name.Trim().Replace("'", "''");
            Log.Password = password.Trim().Replace("'", "''");
            Log.Dial_Mode = GetIP();
            if (Business9420.function9420.FetchDataForAdminLogin(Log))
            {
                HttpContext.Current.Session["User_Type"] = "Admin";
                if (HttpContext.Current.Session["User_Type"] != null)
                {
                    SQL_DB.ExecuteNonQuery("INSERT INTO [Login_History](Dial_Mode,User_ID,Login_Date,User_Type) VALUES ('" + Log.Dial_Mode + "','" + HttpContext.Current.Session["User_Type"].ToString() + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' ,1)");
                    result = "1";
                }
            }
        }
        else
        {
            result = "2";
        }
        return result;
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    public DataRow GetProductName(string c)
    {
        DataRow rsProID = null;
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Pro_Name,PRO_ID FROM Pro_Reg WHERE PRO_ID IN (SELECT PRO_ID FROM M_Code Where CODE1='" + c.Split('-')[0] + "' and CODE2='" + c.Split('-')[1] + "')");
        if (ds.Tables[0].Rows.Count > 0)
            //rsProID = ds.Tables[0].Rows[0]["Pro_Name"].ToString();
            rsProID = ds.Tables[0].Rows[0];
        return rsProID;
    }

    public void SaveWarrentyDetails(string email, string billno, string purchasedate, string mobile, string filePath, string wCode, DateTime expDate, string period, string state, string city, string dealerName)
    {
        // DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
        DateTime purDate = Convert.ToDateTime(purchasedate);
        // DateTime expDate = purDate.AddYears(1);
        SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[WarrentyDetails] ([BillNo],[PurchaseDate],[Email],[Mobile],WarrantyPeriod,ExpirationDate,ImagePathBill,IsWarrantyClaimed, code, State, City, DealerName) values ('" + billno + "','" + purDate.ToString("MM/dd/yyyy") + "','" + email + "','" + mobile + "','" + period + "','" + expDate.ToString("MM/dd/yyyy") + "','" + filePath + "', 0, '" + wCode + "', '" + state + "', '" + city + "', '" + dealerName + "')");
    }
    public void SaveWarrentyDetailsforauto(string purchasedate, string mobile, string wCode, DateTime expDate, string period)
    {
        DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
        // DateTime expDate = purDate.AddYears(1);
        SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[WarrentyDetails] ([PurchaseDate],[Mobile],WarrantyPeriod,ExpirationDate,IsWarrantyClaimed, code) values ('" + purDate.ToString("MM/dd/yyyy") + "','" + mobile + "','" + period + "','" + expDate.ToString("MM/dd/yyyy") + "', 0, '" + wCode + "')");
    }
    public void SaveCompanyDetails(string cName, string pName, string purchasedate, string empId, string disId, string wCode, int otpCode, string mobileNumber)
    {
        DataSet dsOtpCheck = SQL_DB.ExecuteDataSet("Select * from [dbo].[CompanyProduct] Where mobileNumber='" + mobileNumber + "' and employeeID='" + empId + "' and distributorID='" + disId + "' and otp='" + otpCode + "' and [status]=1");
        if (dsOtpCheck.Tables[0].Rows.Count > 0)
        {
            DateTime expDate = System.DateTime.Now.AddYears(1); //purDate.AddYears(1);
            SQL_DB.ExecuteNonQuery("update [dbo].[CompanyProduct] set otp='" + otpCode + "', [status]=0 where mobileNumber='" + mobileNumber + "' and employeeID='" + empId + "' and distributorID='" + disId + "'");
        }
        else
        {
            DateTime expDate = System.DateTime.Now.AddYears(1); //purDate.AddYears(1);
            SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[CompanyProduct] ([companyName],[productName],[expiryDate],[employeeID],[distributorID], [code], [otp], [status],[mobileNumber]) values ('" + cName + "','" + pName + "','" + expDate.ToString("yyyy-MM-dd HH:mm:ss") + "','" + empId + "','" + disId + "','" + wCode + "', '" + otpCode + "', 0, '" + mobileNumber + "')");
        }
    }


    public void UpdateClaimWarrentyDetails(string comment, string filePath, string id)
    {
        SQL_DB.ExecuteNonQuery("update [dbo].[WarrentyDetails] set [IsWarrantyClaimed]=1,[Comment]='" + comment + "',VendorClaimStatus='Pending', ImagePath='" + filePath + "', claimdate='" + System.DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "' where id=" + id + "");
    }
    public void UpdateClaimWarrentyDetailsVendor(string comment, string approveStatus, string id)
    {
        //SQL_DB.ExecuteNonQuery("update [dbo].[WarrentyDetails] set VendorClaimStatus='" + approveStatus + "',[VendorComments]='" + comment + "' where id=" + id + "");
        if (HttpContext.Current.Session["CompanyId"].ToString() == "Comp-1629" || HttpContext.Current.Session["CompanyId"].ToString() == "Comp-1615")
        {
            SQL_DB.ExecuteNonQuery("update [dbo].[WarrentyDetails] set VendorClaimStatus='" + approveStatus + "',[VendorComments]='" + comment + "' where id=" + id + "");

            DataTable warrantdetaiHypersonicGetCode = SQL_DB.ExecuteDataTable("select Code,VendorClaimStatus from WarrentyDetails where id='" + id + "' order by id desc");
            DataTable warrantdetaiHypersonic = SQL_DB.ExecuteDataTable("select Code from WarrentyDetails where Code='" + warrantdetaiHypersonicGetCode.Rows[0]["Code"].ToString() + "' order by id desc");
            if (warrantdetaiHypersonic.Rows.Count < 11)
            {
                SQL_DB.ExecuteNonQuery("insert into [dbo].[WarrentyDetails](BillNo, PurchaseDate, Email,Mobile,WarrantyPeriod,ExpirationDate,IsWarrantyClaimed,ImagePathBill,Code,claimdate,State,City,DealerName,VendorClaimStatus) select BillNo, PurchaseDate, Email,Mobile,WarrantyPeriod,ExpirationDate,IsWarrantyClaimed=0,ImagePathBill,Code,claimdate,State,City,DealerName,'Pending' from [dbo].[WarrentyDetails] where id=" + id + "");
            }
            else if (warrantdetaiHypersonic.Rows.Count < 11 && warrantdetaiHypersonicGetCode.Rows[0]["VendorClaimStatus"].ToString() == "Reject")
            {
                SQL_DB.ExecuteNonQuery("insert into [dbo].[WarrentyDetails](BillNo, PurchaseDate, Email,Mobile,WarrantyPeriod,ExpirationDate,IsWarrantyClaimed,ImagePathBill,Code,claimdate,State,City,DealerName,VendorClaimStatus) select BillNo, PurchaseDate, Email,Mobile,WarrantyPeriod,ExpirationDate,IsWarrantyClaimed=0,ImagePathBill,Code,claimdate,State,City,DealerName,'Pending' from [dbo].[WarrentyDetails] where id=" + id + "");
            }
        }
        else
        {

            if (approveStatus == "Reject")
            {
                SQL_DB.ExecuteNonQuery("update [dbo].[WarrentyDetails] set [IsWarrantyClaimed]=0, VendorClaimStatus='" + approveStatus + "',[VendorComments]='" + comment + "' where id=" + id + "");
            }
            else
            {
                SQL_DB.ExecuteNonQuery("update [dbo].[WarrentyDetails] set [IsWarrantyClaimed]=1, VendorClaimStatus='" + approveStatus + "',[VendorComments]='" + comment + "' where id=" + id + "");
            }
        }
    }

    public void UpdateClaimDetailsVendor(string comment, string approveStatus, string id, string Comp_Id = "")
    {
        if (approveStatus == "2")
            SQL_DB.ExecuteNonQuery("update [dbo].[ClaimDetails] set Isapproved='" + approveStatus + "',[vendor_comment]='" + comment + "', action_date=getdate(), PaymentStatus='Rejected' where Row_id=" + id + "");
        else
            SQL_DB.ExecuteNonQuery("update [dbo].[ClaimDetails] set Isapproved='" + approveStatus + "',[vendor_comment]='" + comment + "', action_date=getdate(), PaymentStatus='Pending' where Row_id=" + id + "");
    }
    public void InsertFiles(string email, string fileName, string mobile, string filePath, string WarId)
    {
        SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[File] ([Email],[Mobile],FileName,FilePath,WarId) values ('" + email + "','" + mobile + "','" + fileName + "','" + filePath + "'," + WarId + ")");
    }

    public DataSet GetFiles(int id)
    {
        return SQL_DB.ExecuteDataSet("select filepath from file where WarId=" + id);
    }
    //** Added by BIpin for SBU Distributor
    public static DataSet CheckEmployeeDetailsSBU(string eID, string dID, string Mobileno)
    {
        DataSet dsEmployee = SQL_DB.ExecuteDataSet("SELECT * FROM M_DealerMaster WHERE replace(ltrim(replace(DealerTechnicianId,'0',' ')),' ','0')  like '%" + eID.TrimStart(new Char[] { '0' }) + "%' and replace(ltrim(replace(DealerCode,'0',' ')),' ','0') like '%" + dID.TrimStart(new Char[] { '0' }) + "%' and d_Status='Active' and Mobile_Num='" + Mobileno + "' ");
        return dsEmployee;
    }
    public static DataSet CheckDistrbutorDetailsSBU(string eID, string dID, string Mobileno)
    {
        DataSet dsDistrbutor = SQL_DB.ExecuteDataSet("SELECT * FROM M_DealerMaster WHERE replace(ltrim(replace(DealerTechnicianId,'0',' ')),' ','0') like '%" + eID.TrimStart(new Char[] { '0' }) + "%' and replace(ltrim(replace(DealerCode,'0',' ')),' ','0') like '%" + dID.TrimStart(new Char[] { '0' }) + "%' and d_Status='Active' and Mobile_Num='" + Mobileno + "' ");
        return dsDistrbutor;
    }
    //** End of SBU Distributor

    public static DataSet CheckEmployeeDetails(string eID, string dID)
    {
        DataSet dsEmployee = SQL_DB.ExecuteDataSet("SELECT * FROM M_DealerMaster WHERE replace(ltrim(replace(DealerTechnicianId,'0',' ')),' ','0')  = '" + eID.TrimStart(new Char[] { '0' }) + "' and replace(ltrim(replace(DealerCode,'0',' ')),' ','0') ='" + dID.TrimStart(new Char[] { '0' }) + "' and d_Status='Active' and Mobile_Num is null ");
        return dsEmployee;
    }

    public static DataSet CheckDistrbutorDetails(string eID, string dID)
    {
        DataSet dsDistrbutor = SQL_DB.ExecuteDataSet("SELECT * FROM M_DealerMaster WHERE replace(ltrim(replace(DealerTechnicianId,'0',' ')),' ','0') = '" + eID.TrimStart(new Char[] { '0' }) + "' and replace(ltrim(replace(DealerCode,'0',' ')),' ','0')='" + dID.TrimStart(new Char[] { '0' }) + "' and d_Status='Active' and Mobile_Num is null ");
        return dsDistrbutor;
    }

    public static DataSet CheckRetailerDealerCodeDetails(string M_Consumerid, string RetailerId, string DealerCode)
    {
        DataSet dsEmployee = SQL_DB.ExecuteDataSet("SELECT * FROM tblMMRetailerDetails WHERE DealerCode ='" + DealerCode + "' and Status='1' and M_Consumerid='" + M_Consumerid + "' ");
        return dsEmployee;
    }

    public static DataSet CheckRetailerDetails(string M_Consumerid, string RetailerId, string DealerCode)
    {
        DataSet dsEmployee = SQL_DB.ExecuteDataSet("SELECT * FROM tblMMRetailerDetails WHERE RetailerId  = '" + RetailerId + "' and Status='1' and M_Consumerid='" + M_Consumerid + "' ");
        return dsEmployee;
    }

    public static DataSet CheckEmployeeDetailsEmployee(string eID, string dID)
    {
        // string qr = "SELECT * FROM m_dealermaster_mahindra_emp WHERE replace(ltrim(replace(DealerTechnicianId,'0',' ')),' ','0')  = '" + eID.TrimStart(new Char[] { '0' }) + "' and replace(ltrim(replace(DealerCode,'0',' ')),' ','0') ='" + dID.TrimStart(new Char[] { '0' }) + "' and d_Status='Active'";
        DataSet dsEmployee = SQL_DB.ExecuteDataSet("SELECT * FROM m_dealermaster_mahindra_emp WHERE replace(ltrim(replace(DealerTechnicianId,'0',' ')),' ','0')  = '" + eID.TrimStart(new Char[] { '0' }) + "' and replace(ltrim(replace(DealerCode,'0',' ')),' ','0') ='" + dID.TrimStart(new Char[] { '0' }) + "' and d_Status='Active'  ");
        return dsEmployee;
    }

    public static DataSet CheckDistrbutorDetailsEmployee(string eID, string dID)
    {
        //string qry11 = "SELECT * FROM m_dealermaster_mahindra_emp WHERE replace(ltrim(replace(DealerTechnicianId,'0',' ')),' ','0') = '" + eID.TrimStart(new Char[] { '0' }) + "' and replace(ltrim(replace(DealerCode,'0',' ')),' ','0')='" + dID.TrimStart(new Char[] { '0' }) + "' and d_Status='Active' ";
        DataSet dsDistrbutor = SQL_DB.ExecuteDataSet("SELECT * FROM m_dealermaster_mahindra_emp WHERE replace(ltrim(replace(DealerTechnicianId,'0',' ')),' ','0') = '" + eID.TrimStart(new Char[] { '0' }) + "' and replace(ltrim(replace(DealerCode,'0',' ')),' ','0')='" + dID.TrimStart(new Char[] { '0' }) + "' and d_Status='Active'  ");
        return dsDistrbutor;
    }




    public DataSet ProductID(string c1, string c2)
    {
        return SQL_DB.ExecuteDataSet("SELECT mc.Pro_ID,pro_name FROM M_Code mc inner join Pro_Reg pr on pr.pro_id=mc.pro_id WHERE code1 = '" + c1 + "' and code2='" + c2 + "'");
    }

    public DataSet OTPVerify(string otpCode, string mobile, string eId, string dId)
    {
        SQL_DB.ExecuteNonQuery("Update COMPANYPRODUCT set status = 1 where otp = '" + otpCode + "' and MobileNumber='" + mobile + "'");
        return SQL_DB.ExecuteDataSet("SELECT * FROM COMPANYPRODUCT WHERE otp = '" + otpCode + "' and MobileNumber='" + mobile + "' and status=1 and employeeID='" + eId + "' and distributorID='" + dId + "'");
    }

    public DataSet app_OTPVerify(string otpCode, string mobile)
    {
        SQL_DB.ExecuteNonQuery("Update COMPANYPRODUCT set status = 1 where otp = '" + otpCode + "' and MobileNumber='" + mobile + "'");
        return SQL_DB.ExecuteDataSet("SELECT  top 1 otp FROM COMPANYPRODUCT WHERE MobileNumber='" + mobile + "' order by  [expiryDate] Desc, DateAdd(Second, -1, Cast([expiryDate] as time)) desc");

    }

    //exibition
    public DataSet OTPVerifyexibition(string otpCode, string mobile)
    {
        if (mobile.Length == 10)
        {
            mobile = "91" + mobile;
        }
        string lotp = "";
        string status = "";
        DataSet otpdataset = new DataSet();
        DataTable dtotp = SQL_DB.ExecuteDataTable("select top 1 otp,status from CompanyProduct where MobileNumber='" + mobile + "' order by CompanyID desc");
        if (dtotp.Rows.Count > 0)
        {
            lotp = dtotp.Rows[0]["otp"].ToString();
            status = dtotp.Rows[0]["status"].ToString();
            if ((lotp == otpCode) && (status == "False"))
            {
                SQL_DB.ExecuteNonQuery("Update COMPANYPRODUCT set status = 1 where otp = '" + otpCode + "' and MobileNumber='" + mobile + "'");
                otpdataset = SQL_DB.ExecuteDataSet("SELECT * FROM COMPANYPRODUCT WHERE otp = '" + otpCode + "' and MobileNumber='" + mobile + "' and status=1 ");
            }
            else
            {
                otpdataset = SQL_DB.ExecuteDataSet("SELECT * FROM COMPANYPRODUCT WHERE otp = '0000' and MobileNumber='" + mobile + "' and status=1 ");
            }
        }
        else
        {
            otpdataset = SQL_DB.ExecuteDataSet("SELECT * FROM COMPANYPRODUCT WHERE otp = '0000' and MobileNumber='" + mobile + "' and status=1 ");
        }
        return otpdataset;

    }
    //exibition



    public DataSet app_OTPVerifyVR(string otpCode, string mobile)
    {
        SQL_DB.ExecuteNonQuery("Update COMPANYPRODUCT set status = 1 where otp = '" + otpCode + "' and MobileNumber like '%" + mobile + "%'");
        return SQL_DB.ExecuteDataSet("SELECT  top 1 otp FROM COMPANYPRODUCT WHERE MobileNumber like '%" + mobile + "%' order by  [expiryDate] Desc, DateAdd(Second, -1, Cast([expiryDate] as time)) desc");

    }

    // Generate a random number between two numbers    
    public int RandomNumber(int min, int max)
    {
        Random random = new Random();
        return random.Next(min, max);
    }
    public static Location locationdetails()
    {
        string ipAddress = GetIP();
        //string APIKey = "8287343040a884bee543a519fe0bd28ad723a102550e6526ca9a2167c3c0f924";
        // string url = string.Format("http://api.ipinfodb.com/v3/ip-city/?key={0}&ip={1}&format=json", APIKey, ipAddress);
        //string url = "https://api.ip2location.com/v2/?ip=" + ipAddress + "&key=5QX2GKT5BA&package=WS9";
        //using (WebClient client = new WebClient())
        //{
        //    string json = client.DownloadString(url);
        //    Location location = new JavaScriptSerializer().Deserialize<Location>(json);
        //    List<Location> locations = new List<Location>();
        //    locations.Add(location);
        //    return location;
        //    //SQL_DB.ExecuteNonQuery("insert into userDetails values('" + Reg.Consumer_ID + "','" + location.CityName + "','" + location.RegionName + "','" + location.CountryName + "','" + location.CountryCode + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "','" + location.IPAddress + "','"+location.ZipCode+"','"+location.Latitude+"','"+location.Longitude+"')");

        //}

        string url = "https://api.ip2location.com/v2/?ip=" + ipAddress + "&key=5QX2GKT5BA&package=WS9";

        ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;

        HttpWebRequest http = (HttpWebRequest)HttpWebRequest.Create(url);


        HttpWebResponse response = (HttpWebResponse)http.GetResponse();
        using (StreamReader sr = new StreamReader(response.GetResponseStream()))
        {
            string json = sr.ReadToEnd();
            Location location = new JavaScriptSerializer().Deserialize<Location>(json);
            List<Location> locations = new List<Location>();
            locations.Add(location);
            return location;
            // SQL_DB.ExecuteNonQuery("insert into visitor values('" + location.city_name + "','" + location.region_name + "','" + location.country_name + "','" + location.country_code + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "','" + ipAddress + "','" + location.zip_code + "','" + location.latitude + "','" + location.longitude + "')");

        }





    }
    public string warranrty(string email, string mobile, string purchasedate, string code, string billno, string path)
    {
        string period = string.Empty;
        DateTime expDate = DateTime.Today;
        // foreach (HttpPostedFile file in context.Request.Files)

        string virtualPath = "~/WarrantyFile/" + path;

        DataRow product_details = GetProductName(code);
        string prdName = product_details["Pro_name"].ToString();
        DataSet dsServicesAssign = ServiceLogic.GetServicesAssign_Product(code);
        DataRow[] servicedetais = dsServicesAssign.Tables[0].Select("Service_id = 'SRV1023'");

        DateTime purDate = DateTime.ParseExact(purchasedate, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
        period = servicedetais[0]["WarrantyPeriod"].ToString();
        expDate = purDate.AddMonths(Convert.ToInt32(period));
        //DateTime expDate = purDate.AddYears(1);

        string strWar = "Warranty for the " + prdName +
              "has been registered successfully, Warranty validity till " + expDate + " To claim your warranty visit <a href='https://www.vcqru.com/'>https://www.vcqru.com/</a>";
        HttpContext.Current.Session["strWar"] = strWar;


        SaveWarrentyDetails(email, billno, purchasedate, mobile, virtualPath, code, expDate, period, null, null, null);
        /////////////////////////////////////////////

        if (mobile.Length == 10)
            mobile = "91" + mobile;

        DataSet dcs = SQL_DB.ExecuteDataSet("SELECT [User_ID],[MobileNo],[Email],Password FROM [M_Consumer] where [MobileNo] = '" + mobile + "'");
        if (dcs.Tables[0].Rows.Count > 0)
        {
            string ConsumerId = dcs.Tables[0].Rows[0]["User_ID"].ToString();
            string pass = dcs.Tables[0].Rows[0]["Password"].ToString();
            string MailBody = "";
            MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                                       " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
                                       " <hr style='border:1px solid #2587D5;'/>" +
                                       " <div class='w_frame'>" +
                                       " <p>" +
                                       " <div class='w_detail'>" +
                                       " <span>Dear <em><strong> Sir/Mam,</strong></em></span><br />" +
                                       " <br />" +
                                       " <span>Warranty registered successfully. Login to https://www.vcqru.com/login.aspx#logsign  Claim warranty </span><br />" +
                                       " Your Login Credentials  <br /> <strong> Mobile Number - " + mobile + "</strong><br /> <strong> Password - " + pass + "</strong>  " +
                                       "<br /><br /> We will contact you soon.   <br />" +
                                       " <p>" +
                                       " <div class='w_detail'>" +
                                       " Assuring you  of  our best services always.<br />" +
                                       " Thank you,<br /><br />" +
                                       " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                                       "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                                       " </div>" +
                                       " </p>" +
                                       " </div>" +
                                       " </p>" +
                                       " </div> " +
                                       " </div> ";

            DataSet dsMl = function9420.FetchMailDetail("support");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),
                    email, MailBody, "Warranty Registration");

            }
        }
        return strWar;
        ////////////////////////////////////////////////
        // ConsumerRegisterAndEma
    }
    public string getimagepaths(string id)
    {
        StringBuilder sr = new StringBuilder();
        DataTable dt = new DataTable();
        dt = SQL_DB.ExecuteDataTable("select filepath from [file] where Warid='" + id + "'");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (i == dt.Rows.Count - 1)
            {
                sr.Append(dt.Rows[i][0].ToString());
            }
            else
            {
                sr.Append(dt.Rows[i][0].ToString() + ",");
            }
        }
        return sr.ToString();

    }
    public void ProcessRequestevent(HttpContext context)
    {
        if (context.Request.HttpMethod == "POST")
        {
            string name = context.Request.Form["name"];
            string email = context.Request.Form["email"];
            string mobile = context.Request.Form["mobile"];
            string companyName = context.Request.Form["company_name"];
            string city = context.Request.Form["city"];
            string source = context.Request.Form["source"];
            string Designation = context.Request.Form["Designation"];

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(mobile) || string.IsNullOrEmpty(companyName) || string.IsNullOrEmpty(city) || string.IsNullOrEmpty(source))
            {
                context.Response.StatusCode = 400; // Bad Request
                context.Response.Write("All fields are required.");
                return;
            }

            SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[EventFormData] (Name,[Email],[Mobile],CompanyName,City,source,Designation) values ('" + name + "','" + email + "','" + mobile + "','" + companyName + "','" + city + "','" + source + "','" + Designation + "')");
            //string UserEmail = SQL_DB.ExecuteScalar("select Email from WarrentyDetails where id=" + id + "").ToString();
            // string passw = "87568";
            string msgString = "Thanks for visiting VCQRU at IHFF. Excited for Business collaboration! Connect on WhatsApp: https://wa.me/+919350726162";
            //ServiceLogic.SendSms(msgString, mobile);
            ServiceLogic.SendSMSFromAlfaCosmo(mobile, msgString, "OTP");


            // mail-------------
            string emailTemplate = @"
<table width=""100%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"">    
    <tbody>
        <tr>
            <td align=""center"">
                <table class=""col-600"" width=""600"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"">
                    <tbody>
                        <tr>
                            <td align=""center"" valign=""top"" background=""https://www.vcqru.com/NewContent/front-assets/img/IHFF_revised.jpg"" bgcolor=""#66809b"" style=""background-size:contain; background-repeat: no-repeat; background-position:top;height: 250px;"">
                                <table class=""col-600"" width=""600"" height=""200"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"">
                                    <tbody>
                                        <tr>
                                            <td height=""40""></td>
                                        </tr>    
                                        <tr>
                                            <td height=""50""></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td align=""center"">
                <table class=""col-600"" width=""600"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"" style=""margin-left:20px; margin-right:20px; border-left: 1px solid #dbd9d9; border-right: 1px solid #dbd9d9;"">
                    <tbody>
                        <tr>
                            <td height=""35""></td>
                        </tr>
                        <tr>
                            <td height=""10""></td>
                        </tr>
                        <tr>
                            <td style=""font-family: 'Times New Roman', Times, serif; font-size:18px; color:#000; line-height:24px; font-weight: 300; padding: 0 1rem;"">
                                Dear SirMam,
                            </td>
                        </tr>
                        <tr>
                            <td style=""font-family: 'Times New Roman', Times, serif; font-size:18px; color:#000; line-height:24px; font-weight: 300; padding: 0 1rem;"">
                                It was a pleasure meeting you at the International Health and Fitness Festival (IHFF) 2024! Thank you for taking the time to visit our booth and express interest in our products and services by filling out our form. <br> <br>
                            </td>
                        </tr>
                        <tr>
                            <td style=""font-family: 'Times New Roman', Times, serif; font-size:18px; color:#000; line-height:24px; font-weight: 300; padding: 0 1rem;"">
                                We are excited about the possibility of collaborating with you and helping you achieve your business goals. To provide you with the best possible experience, we would love to understand your specific needs and preferences better. Please expect a follow-up call from one of our representatives within the next few days. <br><br>
                                Once again, thank you for connecting with us at IHFF 2024. We look forward to building a strong and successful relationship with you. <br><br>
                                Best regards, <br><br>
                                Team VCQRU <br>
                                <a href=""tel:+91-124 5181074"">+91-124 5181074</a> <br>
                                <a href=""mailto:sales@vcqru.com"">sales@vcqru.com</a> <br>
                                <a href=""https://www.vcqru.com/"" target=""_blank""> https://www.vcqru.com/</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td align=""center"">
                <table class=""col-600"" width=""600"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"" style=""border-left: 1px solid #dbd9d9; border-right: 1px solid #dbd9d9;"">
                    <tbody>
                        <tr>
                            <td height=""10""></td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td align=""center"">
                <table class=""col-600"" width=""600"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"" style=""margin-left:20px; margin-right:20px;"">
                    <tbody>
                        <tr>
                            <td align=""center"">
                                <table class=""col-600"" width=""600"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"" style="" border-left: 1px solid #dbd9d9; border-right: 1px solid #dbd9d9;"">
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align=""center"">
                                <table align=""center"" width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"" style="" border-left: 1px solid #dbd9d9; border-right: 1px solid #dbd9d9;"">
                                    <tbody>
                                        <tr>
                                        </tr>
                                        <tr>
                                            <td align=""center"" bgcolor=""#34495e"" background=""https://designmodo.com/demo/emailtemplate/images/footer.jpg"" height=""185"">
                                                <table class=""col-600"" width=""600"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"">
                                                    <tbody>
                                                        <tr>
                                                            <td height=""25""></td>
                                                        </tr>
                                                        <tr>
                                                            <td align=""center"" style=""font-family: 'Raleway', sans-serif; font-size:22px; font-weight: 500; color:#f1c40f;"">Join our journey for exclusive content, updates, and more – follow us now!
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height=""25""></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table align=""center"" width=""35%"" border=""0"" cellspacing=""0"" cellpadding=""0"">
                                                    <tbody>
                                                        <tr>
                                                            <td align=""center"" width=""30%"" style=""vertical-align: top;"">
                                                                <a href=""https://www.facebook.com/vcqru/"" target=""_blank""> <img src=""https://designmodo.com/demo/emailtemplate/images/icon-fb.png""> </a>
                                                            </td>
                                                            <td align=""center"" class=""margin"" width=""30%"" style=""vertical-align: top;"">
                                                                <a href=""https://x.com/Vcqru_Official"" target=""_blank""> <img src=""https://designmodo.com/demo/emailtemplate/images/icon-twitter.png""> </a>
                                                            </td>
                                                            <td align=""center"" width=""30%"" style=""vertical-align: top;"">
                                                                <a href=""https://www.instagram.com/vcqru_wesecureyou/"" target=""_blank""> <img style=""height: 3rem;"" src=""https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/2048px-Instagram_logo_2016.svg.png""> </a>
                                                            </td>
                                                            <td align=""center"" width=""30%"" style=""vertical-align: top;"">
                                                                <a href=""https://in.linkedin.com/company/vcqru-wesecureyou"" target=""_blank""> <img style=""height: 3rem;"" src=""https://cdn1.iconfinder.com/data/icons/logotypes/32/circle-linkedin-512.png""> </a>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </tbody>
</table>";


            string subjec = "Thank You for Connecting with Us at IHFF 2024!";

            DataSet dsMl = function9420.FetchMailDetail("support");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), email, emailTemplate.Replace("SirMam", name), subjec);
            //DataProvider.Utility.sendMailAttachMultiRecipient(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), dsMld.Tables[0].Rows[0]["tomail"].ToString(), dsMld.Tables[0].Rows[0]["ccmail"].ToString(), body, subjec, file);
            //lblMsg1.Text = "Approveal mail sent seccessful...";

            context.Response.ContentType = "application/json";
            context.Response.Write("{\"message\": \"User created successfully\"}");
        }
        else
        {
            context.Response.StatusCode = 405; // Method Not Allowed
            context.Response.Write("Method not allowed");
        }
    }
}