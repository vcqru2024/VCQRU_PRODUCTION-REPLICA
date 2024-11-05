using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
using AjaxControlToolkit;
using System.Collections.Specialized;
using System.Configuration;
using Business9420;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Web.Script.Services;
//using System.Runtime.Serialization.Json;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{
    public string server = Convert.ToString(ConfigurationManager.ConnectionStrings["ServerName"].ConnectionString), userID = Convert.ToString(ConfigurationManager.ConnectionStrings["UserName"].ConnectionString), password = Convert.ToString(ConfigurationManager.ConnectionStrings["Password"].ConnectionString);
    public string srt = DataProvider.Utility.FindMailBody();
    [WebMethod(EnableSession = true)]
    public string Login(string UserID,string Password)
    {
        if (UserID.Trim().Replace("'", "''") != null && Password.Trim().Replace("'", "''") != "")
        {
            if (UserID.Trim().Replace("'", "''").ToUpper() == "ADMIN")
                return "2-false";
            Object9420 Log = new Business9420.Object9420();
            Log.Comp_Email = UserID.Trim().Replace("'", "''");
            Log.Password = Password.Trim().Replace("'", "''");
            DataSet dsPass = SQL_DB.ExecuteDataSet("SELECT [Comp_ID],[Comp_Email],[Doc_Flag],Comp_type FROM [Comp_Reg] where [Comp_Email] = '" + Log.Comp_Email + "' and [Password] = '" + Log.Password + "' and [Email_Vari_Flag] = '1'");
            if (dsPass.Tables[0].Rows.Count > 0)
            {
                if (dsPass.Tables[0].Rows[0]["Doc_Flag"].ToString() == "0")
                {
                    Session["User_Type"] = "Company";
                    Session["Comp_type"] = dsPass.Tables[0].Rows[0]["Comp_type"].ToString();
                    Session["CompanyId"] = dsPass.Tables[0].Rows[0]["Comp_ID"].ToString();
                    Session["Comp_Name"] = dsPass.Tables[0].Rows[0]["Comp_ID"].ToString();
                    return "0-true";
                }
                else
                {
                    Session["User_Type"] = "Company";
                    Session["Comp_type"] = dsPass.Tables[0].Rows[0]["Comp_type"].ToString();
                    Session["CompanyId"] = dsPass.Tables[0].Rows[0]["Comp_ID"].ToString();
                    Session["Comp_Name"] = dsPass.Tables[0].Rows[0]["Comp_ID"].ToString();
                    return "1-true";
                }
            }
            else
            {
                return "2-false";
            }
        }
        else
            return "2-false";
    }
    [WebMethod(EnableSession = true)]
    public string Register(string CompanyNm, string ContactP, string Email, string Mobile, string CompType)
    {
        if (CompanyNm != null && ContactP != "" && Email != null && Mobile != "" && CompType != "")
        {
            Object9420 obj = new Object9420();
            obj.Comp_Name = CompanyNm.Trim().Replace("'", "''");
            obj.Contact_Person = ContactP.Trim().Replace("'", "''");
            obj.Comp_Email = Email.Trim().Replace("'", "''");
            obj.Contact_Person = Mobile.Trim().Replace("'", "''");
            obj.Comp_type = CompType;
            obj.Comp_ID = SQL_DB.ExecuteScalar("SELECT [PrPrefix]+ '-' + convert(nvarchar,[PrStart]) as compId FROM [Code_Gen] where [Prfor] = 'Company'").ToString();
            obj.Reg_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy hh:mm:ss");
            obj.Status = 0;
            obj.Email_Vari_Flag = 0;
            obj.Update_Flag = 0;
            obj.TypeOfCompany = "L";
            function9420.SaveCompanyReg(obj);

            SQL_DB.ExecuteNonQuery("UPDATE [Code_Gen] SET [PrStart] = PrStart + 1 WHERE [Prfor] = 'Company'");
            string EncData = string.Format("Comp_Id={0}", obj.Comp_ID);
            string link = string.Format(""+ ProjectSession.absoluteSiteBrowseUrl +"/EmailVerification.aspx?{0}", Encrypt(EncData));


            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
            " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
            " <hr style='border:1px solid #2587D5;'/>" +
            " <div class='w_frame'>" +
            " <p>" +
            " <div class='w_detail'>" +
            " <span>Dear <em><strong>" + obj.Contact_Person + ",</strong></em></span><br />" +
            " <br />" +
            " <span>Thank you for choosing VCQRU.com</span>" +
            " <br />you are just few seconds away to enjoy the services of VCQRU.com <br />" +
            " Please visit the link below, to verify your email. <a href='" + link + "'><strong>Verify your Email now</strong></a>" +
            " <br />" +
            " <br />" +
            " <p>" +
            " <div class='w_detail'>" +
            " Assuring you  of  our best services always.<br />" +
            " Thank you,<br /><br />" +
            " Team <em><strong>VCQRU.COM,</strong></em><br />" +
            "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                //" <strong>Toll Free: 1800 183 9420</strong>" +
            " </div>" +
            " </p>" +
            " </div>" +
            " </p>" +
            " </div> " +
            " </div> ";
            DataSet dsMl = function9420.FetchMailDetail("register");
            if (dsMl.Tables[0].Rows.Count > 0)
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), obj.Comp_Email, MailBody, "Company Registration");
            string ss = "<b>Dear " + obj.Contact_Person + "</b><br/> Thanks for registration with us. Please check your email for <br/> further process. <br/> <br/> <b> Thank you,</b> <br/> Team: VCQRU.COM <br/>  " + ProjectSession.sales_accomplishtrades + " ";
            return "true - " + ss;
        }
        else
            return "true";
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

    DataSet ds = new DataSet();
    [WebMethod]
    public CascadingDropDownNameValue[] BindPacketDetails(string knownCategoryValues, string category)
    {
        SQL_DB.GetDA("select bunchCode, count(bunchCode) as totalCount from vw_bunch_code group by bunchCode").Fill(ds); //Business9420.function9420.FillddlDemoAll();

        //SQL_DB.GetDA("SELECT [Count_Id] ,[Count_Name] FROM [Country_Master]").Fill(ds);
        List<CascadingDropDownNameValue> Packetdetails = new List<CascadingDropDownNameValue>();
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            string PacketId = dr["totalCount"].ToString();
            string PacketName = dr["bunchCode"].ToString();
            Packetdetails.Add(new CascadingDropDownNameValue(PacketName, PacketId));
        }
        return Packetdetails.ToArray();
    }
        
    [WebMethod]
    public CascadingDropDownNameValue[] BindStateDetails(string knownCategoryValues, string category)
    {
        string CountryID;
        StringDictionary CountryDetails = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
        CountryID = Convert.ToString(CountryDetails["Country_Master"]);
        SQL_DB.GetDA("SELECT [STATE_ID], [stateName] FROM [StateMaster] where [COUNTRY_ID]=" + CountryID + "").Fill(ds);

        List<CascadingDropDownNameValue> StateDetails = new List<CascadingDropDownNameValue>();
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            string STATE_ID = dr["STATE_ID"].ToString();
            string StateName = dr["stateName"].ToString();
            StateDetails.Add(new CascadingDropDownNameValue(StateName, STATE_ID));
        }
        return StateDetails.ToArray();
    }

    [WebMethod]
    public CascadingDropDownNameValue[] BindCityDetails(string knownCategoryValues, string category)
    {
        string StateId;
        StringDictionary StateDetails = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
        StateId = Convert.ToString(StateDetails["StateMaster"]);
        SQL_DB.GetDA("SELECT [CITY_ID] ,[CityName]  FROM [CityMaster] where [State_id] =" + StateId + "").Fill(ds);

        List<CascadingDropDownNameValue> CityDetails = new List<CascadingDropDownNameValue>();
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            string CityId = dr["CITY_ID"].ToString();
            string CityName = dr["CityName"].ToString();
            CityDetails.Add(new CascadingDropDownNameValue(CityName, CityId));
        }
        return CityDetails.ToArray();
    }

    [WebMethod]
    public CascadingDropDownNameValue[] BindCompany(string knownCategoryValues, string category)
    {
        DataSet ds = function9420.FillCompany();
        List<CascadingDropDownNameValue> Countrydetails = new List<CascadingDropDownNameValue>();
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            string CompID = dr["Comp_ID"].ToString();
            string CompName = dr["Comp_Name"].ToString();
            Countrydetails.Add(new CascadingDropDownNameValue(CompName, CompID));
        }
        return Countrydetails.ToArray();
    }
    [WebMethod]
    public CascadingDropDownNameValue[] BindProduct(string knownCategoryValues, string category)
    {
        string Comp_ID;
        StringDictionary CountryDetails = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
        Comp_ID = Convert.ToString(CountryDetails["Comp_Reg"]);
        List<CascadingDropDownNameValue> StateDetails = new List<CascadingDropDownNameValue>();
        if (Comp_ID != null)
        {
            SQL_DB.GetDA("SELECT [Pro_ID], [Pro_Name] FROM [Pro_Reg] where [Comp_ID]='" + Comp_ID + "' order by Pro_Name").Fill(ds);


            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                string ProID = dr["Pro_ID"].ToString();
                string ProName = dr["Pro_Name"].ToString();
                StateDetails.Add(new CascadingDropDownNameValue(ProName, ProID));
            }
        }
        return StateDetails.ToArray();
    }

}
