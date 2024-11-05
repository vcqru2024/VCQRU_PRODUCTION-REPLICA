using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using DataProvider;
using Data_Access_Layer;
using Business9420;

namespace Business_Logic_Layer
{
    #region Admin_Login
    public class Admin_Login
    {
        #region Admin_Login Property
        private string _user_id;

        public string User_id
        {
            get { return _user_id; }
            set { _user_id = value; }
        }
        private string _pwd;

        public string Pwd
        {
            get { return _pwd; }
            set { _pwd = value; }
        }
        private Int32 _status;

        public Int32 Status
        {
            get { return _status; }
            set { _status = value; }
        }
        private string _typ;

        public string Typ
        {
            get { return _typ; }
            set { _typ = value; }
        }
        private string _cal_Pass;

        public string Cal_Pass
        {
            get { return _cal_Pass; }
            set { _cal_Pass = value; }
        }
        #endregion

        #region  Admin_Login Methods

        public static DataSet Admin_LoginFunction(Admin_Login Adm)
        {
            return Data_Access_Layer.Admin_Login.Admin_LoginFunction(Adm);
        }
        public static DataSet FillUserDDL()
        {
            return Data_Access_Layer.Admin_Login.FillUserDDL();
        }
        #endregion
    }
    #endregion

    #region Registration
    public class Registration
    {
        #region Registration Property
        private string _Remarks;

        public string Remarks
        {
            get { return _Remarks; }
            set { _Remarks = value; }
        }

        private string _check_No;

        public string Check_No
        {
            get { return _check_No; }
            set { _check_No = value; }
        }
        private string _dd_No;

        public string Dd_No
        {
            get { return _dd_No; }
            set { _dd_No = value; }
        }
        private string _tra_Id;

        public string Tra_Id
        {
            get { return _tra_Id; }
            set { _tra_Id = value; }
        }
        private double _req_Amt;

        public double Req_Amt
        {
            get { return _req_Amt; }
            set { _req_Amt = value; }
        }
        private string _appFormNo;

        public string AppFormNo
        {
            get { return _appFormNo; }
            set { _appFormNo = value; }
        }
        private string _dd_PinCode;

        public string Dd_PinCode
        {
            get { return _dd_PinCode; }
            set { _dd_PinCode = value; }
        }
        private string _dd_BankName;

        public string Dd_BankName
        {
            get { return _dd_BankName; }
            set { _dd_BankName = value; }
        }
        private string _ifc;

        public string Ifc
        {
            get { return _ifc; }
            set { _ifc = value; }
        }
        private string _common;

        public string Common
        {
            get { return _common; }
            set { _common = value; }
        }
        private string _user_id;

        public string User_id
        {
            get { return _user_id; }
            set { _user_id = value; }
        }
        private string _pwd;

        public string Pwd
        {
            get { return _pwd; }
            set { _pwd = value; }
        }
        private string _acc_Pass;

        public string Acc_Pass
        {
            get { return _acc_Pass; }
            set { _acc_Pass = value; }
        }
        private string _name;

        public string Name
        {
            get { return _name; }
            set { _name = value; }
        }
        private string _father;

        public string Father
        {
            get { return _father; }
            set { _father = value; }
        }
        private string _mother;

        public string Mother
        {
            get { return _mother; }
            set { _mother = value; }
        }
        private string _address;

        public string Address
        {
            get { return _address; }
            set { _address = value; }
        }
        private string _pincode;

        public string Pincode
        {
            get { return _pincode; }
            set { _pincode = value; }
        }
        private string _city;

        public string City
        {
            get { return _city; }
            set { _city = value; }
        }
        private string _state;

        public string State
        {
            get { return _state; }
            set { _state = value; }
        }
        private string _country;

        public string Country
        {
            get { return _country; }
            set { _country = value; }
        }
        private string _mobile;

        public string Mobile
        {
            get { return _mobile; }
            set { _mobile = value; }
        }
        private DateTime _d_o_b;

        public DateTime D_o_b
        {
            get { return _d_o_b; }
            set { _d_o_b = value; }
        }
        private string _pan_no;

        public string Pan_no
        {
            get { return _pan_no; }
            set { _pan_no = value; }
        }
        private string _e_mail;

        public string E_mail
        {
            get { return _e_mail; }
            set { _e_mail = value; }
        }
        private string _bank_Name;

        public string Bank_Name
        {
            get { return _bank_Name; }
            set { _bank_Name = value; }
        }
        private string _account_No;

        public string Account_No
        {
            get { return _account_No; }
            set { _account_No = value; }
        }
        private string _product_Code;

        public string Product_Code
        {
            get { return _product_Code; }
            set { _product_Code = value; }
        }
        private string _nominee_Name;

        public string Nominee_Name
        {
            get { return _nominee_Name; }
            set { _nominee_Name = value; }
        }
        private string _nominee_Relation;

        public string Nominee_Relation
        {
            get { return _nominee_Relation; }
            set { _nominee_Relation = value; }
        }
        private string _nominee_Dob;

        public string Nominee_Dob
        {
            get { return _nominee_Dob; }
            set { _nominee_Dob = value; }
        }
        private string _nominee_Address;

        public string Nominee_Address
        {
            get { return _nominee_Address; }
            set { _nominee_Address = value; }
        }
        private string _payment_Mode;

        public string Payment_Mode
        {
            get { return _payment_Mode; }
            set { _payment_Mode = value; }
        }
        private double _dd_Amount;

        public double Dd_Amount
        {
            get { return _dd_Amount; }
            set { _dd_Amount = value; }
        }
        private string _dd_Details;

        public string Dd_Details
        {
            get { return _dd_Details; }
            set { _dd_Details = value; }
        }
        private string _relation;

        public string Relation
        {
            get { return _relation; }
            set { _relation = value; }
        }
        private Int32 _act_Reg;

        public Int32 Act_Reg
        {
            get { return _act_Reg; }
            set { _act_Reg = value; }
        }
        private string _bank;

        public string Bank
        {
            get { return _bank; }
            set { _bank = value; }
        }
        private string _sponsor_Id;

        public string Sponsor_Id
        {
            get { return _sponsor_Id; }
            set { _sponsor_Id = value; }
        }
        private string _sponsor_Name;

        public string Sponsor_Name
        {
            get { return _sponsor_Name; }
            set { _sponsor_Name = value; }
        }
        private string _status;

        public string Status
        {
            get { return _status; }
            set { _status = value; }
        }
        private DateTime _reg_Date;

        public DateTime Reg_Date
        {
            get { return _reg_Date; }
            set { _reg_Date = value; }
        }
        private DateTime _act_Date;

        public DateTime Act_Date
        {
            get { return _act_Date; }
            set { _act_Date = value; }
        }
        private Int32 _level;

        public Int32 Level
        {
            get { return _level; }
            set { _level = value; }
        }
        private string _parent_Id;

        public string Parent_Id
        {
            get { return _parent_Id; }
            set { _parent_Id = value; }
        }
        private string _category;

        public string Category
        {
            get { return _category; }
            set { _category = value; }
        }
        private string _dd_Date;

        public string Dd_Date
        {
            get { return _dd_Date; }
            set { _dd_Date = value; }
        }
        private string _branch_Name;

        public string Branch_Name
        {
            get { return _branch_Name; }
            set { _branch_Name = value; }
        }
        private string _policy_Holder;

        public string Policy_Holder
        {
            get { return _policy_Holder; }
            set { _policy_Holder = value; }
        }
        private Int32 _slab;

        public Int32 Slab
        {
            get { return _slab; }
            set { _slab = value; }
        }
        private string _pairs;

        public string Pairs
        {
            get { return _pairs; }
            set { _pairs = value; }
        }
        #endregion




        #region Registration Methods
        public static void MyRegistration_Insert(Business_Logic_Layer.Registration Reg)
        {
            Data_Access_Layer.Registration.Registration_Insert(Reg);
        }
        public static void MyRegistration_Update(Business_Logic_Layer.Registration Reg)
        {
            Data_Access_Layer.Registration.Registration_Update(Reg);
        }
        public static string MyRegistrationExccel(Business_Logic_Layer.Registration Reg)
        {
            return Data_Access_Layer.Registration.MyRegistrationExccel(Reg);
        }
        public static bool CheckValidDOB(DateTime dob)
        {
            dob = Convert.ToDateTime(dob);
            TimeSpan t = DataProvider.LocalDateTime.Now.Subtract(dob);
            if (t.Days < 4380)
                return false;
            else
                return true;
        }
        public static void Fillddlpairsrch(DropDownList ddlpairsrch)
        {
            MyUtilities.FillDDLInsertZeroIndexString(Data_Access_Layer.Registration.Fillddlpairsrch(), "Pair", "Medal", ddlpairsrch, "Select Recognition");
        }
        public static void fillDDlrela(DropDownList ddlrelation)
        {
            MyUtilities.FillDDLInsertZeroIndexString(Data_Access_Layer.Registration.fillDDlrela(), "id", "relationship", ddlrelation, "Select Relation");
        }
        public static void fillDDlstate(DropDownList ddlstate)
        {
            MyUtilities.FillDropDownList(Data_Access_Layer.Registration.fillDDlstate(), "STATE_ID", "stateName", ddlstate);
        }
        public static void fillDDlcity(DropDownList ddlcity, Business_Logic_Layer.Registration RegCity)
        {
            MyUtilities.FillDropDownList(Data_Access_Layer.Registration.fillDDlcity(RegCity), "CITY_ID", "CityName", ddlcity);
        }
        public static void fillDDlcitySearch(DropDownList ddlcitysrch)
        {
            MyUtilities.FillDropDownList(Data_Access_Layer.Registration.fillDDlcitySearch(), "CityName", "CityName", ddlcitysrch);
        }
        public static void fillDDlPro(DropDownList ddlprodu)
        {
            MyUtilities.FillDropDownList(Data_Access_Layer.Registration.fillDDlPro(), "Product_code", "Product_Name", ddlprodu, "Upg=0");
        }
        public static void fillDDlProsrch(DropDownList ddlprodu)
        {
            MyUtilities.FillDropDownList(Data_Access_Layer.Registration.fillDDlPro(), "Product_code", "Product_Name", ddlprodu);
        }
        public static void fillDDlProducpay(DropDownList ddlprodu)
        {
            MyUtilities.FillDropDownList(Data_Access_Layer.Registration.fillDDlPro(), "Product_code", "Product_Name", ddlprodu, "Upg=1");
        }

        public static DataSet FillUpDateData(Registration Reg_Updt)
        {
            return Data_Access_Layer.Registration.FillUpDateData(Reg_Updt);
        }

        public static DataSet FillUpDDDateData(Registration Reg_Updt)
        {
            return Data_Access_Layer.Registration.FillUpDDDateData(Reg_Updt);
        }
        public static int FinSlab(Registration FindS)
        {
            return Data_Access_Layer.Registration.FinSlab(FindS);
        }
        #endregion

        public static string GetName(Registration FindS)
        {
            return Data_Access_Layer.Registration.GetName(FindS);
        }

        public static int AllCountRows(Registration FindS)
        {
            return Data_Access_Layer.Registration.AllCountRows(FindS);
        }
        public static void Joining_Request(Registration Join)
        {
            Data_Access_Layer.Registration.Joining_Request(Join);
        }
        //Deepak
        public static DataSet FetchUserLoginDetail(Business_Logic_Layer.Registration RegObj)
        {
            return Data_Access_Layer.Registration.FetchUserLoginDetail(RegObj);
        }
        public static DataSet FetchRetailerLoginDetail(Business_Logic_Layer.Registration RegObj)
        {
            return Data_Access_Layer.Registration.FetchRetailerLoginDetail(RegObj);
        }
        public static DataSet FillUserSlab(Business_Logic_Layer.Registration RegObj)
        {
            return Data_Access_Layer.Registration.FillUserSlab(RegObj);
        }
        //End
    }
    #endregion

    #region NewUpDate
    public class NewUpDate
    {
        #region NewUpDate Property
        private int _tbl_Id;

        public int Tbl_Id
        {
            get { return _tbl_Id; }
            set { _tbl_Id = value; }
        }
        private string _news;

        public string News
        {
            get { return _news; }
            set { _news = value; }
        }
        private DateTime _entry_Date;

        public DateTime Entry_Date
        {
            get { return _entry_Date; }
            set { _entry_Date = value; }
        }
        private DateTime Updated_Date;

        public DateTime Updated_Date1
        {
            get { return Updated_Date; }
            set { Updated_Date = value; }
        }
        private int _act_Flag;

        public int Act_Flag
        {
            get { return _act_Flag; }
            set { _act_Flag = value; }
        }
        private string _new_Heading;

        public string New_Heading
        {
            get { return _new_Heading; }
            set { _new_Heading = value; }
        }
        #endregion

        #region NewUpDate Methods

        public static void NewsEntry(NewUpDate mnews)
        {
            Data_Access_Layer.NewssUpDate.NewsEntry(mnews);
        }
        public static void NewsEntryUpdate(NewUpDate mnews)
        {
            Data_Access_Layer.NewssUpDate.NewsEntryUpdate(mnews);
        }
        public static void FillGrid(GridView MyGridView)
        {
            DataSet ds = new DataSet();
            MyGridView.DataSource = Data_Access_Layer.NewssUpDate.FillGridData();
            MyGridView.DataBind();
        }
        public static DataSet FillDataUpDate(NewUpDate NewUpdt)
        {
            return Data_Access_Layer.NewssUpDate.FillDataUpDate(NewUpdt);
        }

        public static void DeleteNews(NewUpDate Del)
        {
            Data_Access_Layer.NewssUpDate.DeleteNews(Del);
        }

        public static void NewsEntryUpdateFlag(NewUpDate UFlag)
        {
            Data_Access_Layer.NewssUpDate.NewsEntryUpdateFlag(UFlag);
        }
        #endregion
    }
    #endregion

    #region MyScheme
    public class MyScheme
    {
        #region Property
        private int _tbl_Id;

        public int Tbl_Id
        {
            get { return _tbl_Id; }
            set { _tbl_Id = value; }
        }
        private string _scheme;

        public string Scheme
        {
            get { return _scheme; }
            set { _scheme = value; }
        }
        private Int32 _months;

        public Int32 Months
        {
            get { return _months; }
            set { _months = value; }
        }
        private Int32 _deposit;

        public Int32 Deposit
        {
            get { return _deposit; }
            set { _deposit = value; }
        }
        private Int32 _offers;

        public Int32 Offers
        {
            get { return _offers; }
            set { _offers = value; }
        }
        private string _offer_Paid;

        public string Offer_Paid
        {
            get { return _offer_Paid; }
            set { _offer_Paid = value; }
        }
        #endregion

        #region Methods
        public static void SchemeInsert(Business_Logic_Layer.MyScheme Ins)
        {
            Data_Access_Layer.MyScheme.SchemeInsert(Ins);
        }
        #endregion

        public static void ScemeUpDate(MyScheme Insert)
        {
            Data_Access_Layer.MyScheme.SchemeUpDate(Insert);
        }

        public static DataSet FillSpeGrid()
        {
            return Data_Access_Layer.MyScheme.FillSpeGrid();
        }
    }
    #endregion

    #region Commission
    public class Commission
    {
        #region Property
        private Int32 _tbl_Id;

        public Int32 Tbl_Id
        {
            get { return _tbl_Id; }
            set { _tbl_Id = value; }
        }
        private Int32 _level;

        public Int32 Level
        {
            get { return _level; }
            set { _level = value; }
        }
        private Double _recharge_First;

        public Double Recharge_First
        {
            get { return _recharge_First; }
            set { _recharge_First = value; }
        }
        private Double _recharge_Always;

        public Double Recharge_Always
        {
            get { return _recharge_Always; }
            set { _recharge_Always = value; }
        }
        private Double _selling_First;

        public Double Selling_First
        {
            get { return _selling_First; }
            set { _selling_First = value; }
        }
        private Double _selling_Always;

        public Double Selling_Always
        {
            get { return _selling_Always; }
            set { _selling_Always = value; }
        }
        private Double _booking_First;

        public Double Booking_First
        {
            get { return _booking_First; }
            set { _booking_First = value; }
        }
        private Double _booking_Always;

        public Double Booking_Always
        {
            get { return _booking_Always; }
            set { _booking_Always = value; }
        }
        #endregion
        #region Methods
        public static DataSet FillCommissionGrid()
        {
            return Data_Access_Layer.Commission.FillCommissionGrid();
        }
        #endregion

        public static void Insert(Commission Ins)
        {
            Data_Access_Layer.Commission.Insert(Ins);
        }
        public static void UpDate(Commission Ins)
        {
            Data_Access_Layer.Commission.UpDate(Ins);
        }

        public static DataSet FillUpDateData(Commission Filldb)
        {
            return Data_Access_Layer.Commission.FillUpDateData(Filldb);
        }
    }
    #endregion

    #region Recognisation
    public class Recognisation
    {
        #region Property
        private int _tbl_Id;

        public int Tbl_Id
        {
            get { return _tbl_Id; }
            set { _tbl_Id = value; }
        }
        private double _amount;

        public double Amount
        {
            get { return _amount; }
            set { _amount = value; }
        }
        private string _medel;

        public string Medel
        {
            get { return _medel; }
            set { _medel = value; }
        }
        private string _offers_Name;

        public string Offers_Name
        {
            get { return _offers_Name; }
            set { _offers_Name = value; }
        }
        #endregion

        #region Methods
        public static void InsertRecognisation(Recognisation Reg)
        {
            Data_Access_Layer.Recognisation.InsertRecognisation(Reg);
        }
        public static void UpDateRecognisation(Recognisation Reg)
        {
            Data_Access_Layer.Recognisation.UpDateRecognisation(Reg);
        }
        public static DataSet FillUpDateData(Recognisation Reg)
        {
            return Data_Access_Layer.Recognisation.FillUpDateData(Reg);
        }
        public static void FillGrid(GridView grdrecog)
        {
            MyUtilities.FillGrid(Data_Access_Layer.Recognisation.FillGrid(), grdrecog);
        }
        public static void SendRequestAmount(Business_Logic_Layer.Registration Reg)
        {
            Data_Access_Layer.Registration.SendRequestAmount(Reg);
        }
        #endregion

    }
    #endregion

    #region Joining Reqeust
    public class ManRequest
    {
        #region Property
        private int _id;

        public int Id
        {
            get { return _id; }
            set { _id = value; }
        }
        private string _name;

        public string Name
        {
            get { return _name; }
            set { _name = value; }
        }
        private Int32 _mobile;

        public Int32 Mobile
        {
            get { return _mobile; }
            set { _mobile = value; }
        }
        private Int32 _e_Mail;

        public Int32 E_Mail
        {
            get { return _e_Mail; }
            set { _e_Mail = value; }
        }
        private Int32 _address;

        public Int32 Address
        {
            get { return _address; }
            set { _address = value; }
        }
        private string _state_Id;

        public string State_Id
        {
            get { return _state_Id; }
            set { _state_Id = value; }
        }
        private string _city_Id;

        public string City_Id
        {
            get { return _city_Id; }
            set { _city_Id = value; }
        }
        private DateTime _entry_Date;

        public DateTime Entry_Date
        {
            get { return _entry_Date; }
            set { _entry_Date = value; }
        }
        private int _commit1;

        public int Commit1
        {
            get { return _commit1; }
            set { _commit1 = value; }
        }
        private string _remarks;

        public string Remarks
        {
            get { return _remarks; }
            set { _remarks = value; }
        }
        private DateTime _date_From;

        public DateTime Date_From
        {
            get { return _date_From; }
            set { _date_From = value; }
        }
        private DateTime _Date_To;

        public DateTime Date_To
        {
            get { return _Date_To; }
            set { _Date_To = value; }
        }
        #endregion

        #region Methods
        public static DataSet FillManRequest(Business_Logic_Layer.ManRequest Reg)
        {
            return Data_Access_Layer.ManRequest.FillManRequest(Reg);
        }
        #endregion
    }
    #endregion

    #region Loyalty Programm

    public enum ServiceTypes
    {
        Instant,
        DueDate
    }
    public enum ServiceRules_ForInstantOrRandom
    {
        FirstnParticipants,
        EverynthParticipants,
        RandomParticipants,
        AllParticipants
    }
    public enum ServiceRules
    {
        FirstNCustomer,//FirstnParticipants
        RandomNCustomernth,//EverynthParticipants
        RandomNCustomer, //RandomParticipants
        AllCustomer,//AllParticipants
        FirstNCustomertoNCustomer,
        AllCusomertoRandomNCustomer,
        AllCusomertoRandomNWinners,
        AllCustomertoAllCustomer
    }
    public enum RwdDistrubutionRules
    {
        Random,
        Sequence
    }

    #region Add Loyalty Programm
    public class Referral
    {
        public string GiftReferral { get; set; }
        public string GiftUsers { get; set; }
        public string Typeofgift { get; set; }
        public Int64 Trans_Id { get; set; }
        public Int64 SST_Id { get; set; }
        public Int64 PointsReferral { get; set; }
        public Int64 PointsUsers { get; set; }
        public Int64 IsCashReferral { get; set; }
        public Int64 IsCashUsers { get; set; }
        public Int32 IsCashConvert { get; set; }
        public Int32 Frequency { get; set; }
        public string DML { get; set; }
    }
    public class Loyalty_Programm
    {
        #region Loyalty Programm Property
        public Referral Referrals { get; set; }
        public string ServiceType { get; set; }
        public string Rules { get; set; }
        public string RewardsDistribution { get; set; }
        public string PrizeTrans_Id { get; set; }
        public Int64 TotalNoOfCodes { get; set; }
        public List<Gifts> GiftList { get; set; }
        public Int64 MasterCodes { get; set; }
        public Int64 WinningCodes { get; set; }
        public Int64 WinCodes { get; set; }
        public Int32 IsCash { get; set; }
        public Int32 WarrantyPeriod { get; set; }
        public Int32 IsReferral { get; set; }
        private string _Subscribe_Id;
        public DateTime? dttxtDueDate { get; set; }
        public string code_range { get; set; }
        public string AmtType { get; set; }
        public Int32 Minval { get; set; }
        public Int32 Maxval { get; set; }
        public Int64 totalloyalty { get; set; }
        public Int64 totalcode { get; set; }
        public Int32 multiple { get; set; }
        public string Subscribe_Id
        {
            get { return _Subscribe_Id; }
            set { _Subscribe_Id = value; }
        }
        private string _Service_ID;

        public string Service_ID
        {
            get { return _Service_ID; }
            set { _Service_ID = value; }
        }
        private Int64 _ServiceTransId;

        public Int64 ServiceTransId
        {
            get { return _ServiceTransId; }
            set { _ServiceTransId = value; }
        }
        private Int64 _Trans_ID;

        public Int64 Trans_ID
        {
            get { return _Trans_ID; }
            set { _Trans_ID = value; }
        }
        private Int32 _ReferralLimit;

        public Int32 ReferralLimit
        {
            get { return _ReferralLimit; }
            set { _ReferralLimit = value; }
        }
        private Int64 _RowId;

        public Int64 RowId
        {
            get { return _RowId; }
            set { _RowId = value; }
        }
        private string _Pro_Name;

        public string Pro_Name
        {
            get { return _Pro_Name; }
            set { _Pro_Name = value; }
        }
        private string _Comp_ID;

        public string Comp_ID
        {
            get { return _Comp_ID; }
            set { _Comp_ID = value; }
        }
        public string Qry { get; set; }
        private string _Pro_ID;

        public string Pro_ID
        {
            get { return _Pro_ID; }
            set { _Pro_ID = value; }
        }
        private decimal _Points;

        public decimal Points
        {
            get { return _Points; }
            set { _Points = value; }
        }
        private Int32 _IsCashConvert;

        public Int32 IsCashConvert
        {
            get { return _IsCashConvert; }
            set { _IsCashConvert = value; }
        }
        private string _DateFrom;

        public string DateFrom
        {
            get { return _DateFrom; }
            set { _DateFrom = value; }
        }
        private string _DateTo;

        public string DateTo
        {
            get { return _DateTo; }
            set { _DateTo = value; }
        }
        private Int32 _IsActive;

        public Int32 IsActive
        {
            get { return _IsActive; }
            set { _IsActive = value; }
        }
        private Int32 _IsDelete;

        public Int32 IsDelete
        {
            get { return _IsDelete; }
            set { _IsDelete = value; }
        }

        private Int32 _AdditionalGift;

        public Int32 AdditionalGift
        {
            get { return _AdditionalGift; }
            set { _AdditionalGift = value; }
        }
        private Int32 _MessageTemplete;

        public Int32 MessageTemplete
        {
            get { return _MessageTemplete; }
            set { _MessageTemplete = value; }
        }
        private string _DMLs;

        public string DMLs
        {
            get { return _DMLs; }
            set { _DMLs = value; }
        }
        private string _DML;

        public string DML
        {
            get { return _DML; }
            set { _DML = value; }
        }
        private Int32 _Frequency;

        public Int32 Frequency
        {
            get { return _Frequency; }
            set { _Frequency = value; }
        }
        private Int32 _nth;

        public Int32 Nth
        {
            get { return _nth; }
            set { _nth = value; }
        }
        private string _Comments;

        public string Comments
        {
            get { return _Comments; }
            set { _Comments = value; }
        }
        private string _msg;

        public string Msg
        {
            get { return _msg; }
            set { _msg = value; }
        }
        private DateTime _Entry_Date;

        public DateTime Entry_Date
        {
            get { return _Entry_Date; }
            set { _Entry_Date = value; }
        }
        #endregion

        #region  Loyalty Programm Methods
        public static void InsUpdSrvForProduct(Loyalty_Programm Obj)
        {
            Data_Access_Layer.Loyalty_Function.InsUpdSrvForProduct(Obj);
        }
        public static void InsertUpdateLoyalty(Loyalty_Programm Obj)
        {
            Data_Access_Layer.Loyalty_Function.InsertUpdateLoyalty(Obj);
        }
        public static DataSet FillLoyaltyGrid()
        {
            return Data_Access_Layer.Loyalty_Function.FillLoyaltyGrid();
        }
        public static DataSet FetchSearchData(Loyalty_Programm obj)
        {
            return Data_Access_Layer.Loyalty_Function.FetchSearchData(obj);
        }
        public static DataSet FillServiceSubscription(Loyalty_Programm obj)
        {
            return Data_Access_Layer.Loyalty_Function.FillServiceSubscription(obj);
        }
        public static DataSet FillGrVwDraw(Loyalty_Programm obj)
        {
            return Data_Access_Layer.Loyalty_Function.FillGrVwDraw(obj);
        }
        public static DataSet FillGrVwCashTransfer(Loyalty_Programm obj)
        {
            return Data_Access_Layer.Loyalty_Function.FillGrVwCashTransfer(obj);
        }
        public static DataSet FillGrvWData(Loyalty_Programm obj)
        {
            return Data_Access_Layer.Loyalty_Function.FillGrvWData(obj);
        }
        public static DataSet FillGrvWDataAdmin(Loyalty_Programm obj)
        {
            return Data_Access_Layer.Loyalty_Function.FillGrvWDataAdmin(obj);
        }
        #endregion

        public static void UpdateFiles(Loyalty_Programm obj)
        {
            Data_Access_Layer.Loyalty_Function.UpdateFiles(obj);
        }
        public static void UpdateSoundFile(Loyalty_Programm obj)
        {
            Data_Access_Layer.Loyalty_Function.UpdateSoundFile(obj);
        }
        public static void IsActiveDelete(Loyalty_Programm obj)
        {
            Data_Access_Layer.Loyalty_Function.IsActiveDelete(obj);
        }
        public static void SSTIsActiveDelete(Loyalty_Programm obj)
        {
            Data_Access_Layer.Loyalty_Function.SSTIsActiveDelete(obj);
        }
    }
    #endregion

    #region Master Loyalty Settings
    public class Loyalty_Settings
    {
        #region Loyalty Programm Property
        private Int64 _RowId;

        public Int64 RowId
        {
            get { return _RowId; }
            set { _RowId = value; }
        }

        private string _Referral;
        public string Referral
        {
            get { return _Referral; }
            set { _Referral = value; }
        }
        private int _ReferralID;
        public int ReferralID
        {
            get { return _ReferralID; }
            set { _ReferralID = value; }
        }
        private string _ReferralLimit;
        public string ReferralLimit
        {
            get { return _ReferralLimit; }
            set { _ReferralLimit = value; }
        }
        private string _Comp_ID;
        public string Comp_ID
        {
            get { return _Comp_ID; }
            set { _Comp_ID = value; }
        }
        private decimal _Min_Bank_Transfer;

        public decimal Min_Bank_Transfer
        {
            get { return _Min_Bank_Transfer; }
            set { _Min_Bank_Transfer = value; }
        }
        private decimal _Points;

        public decimal Points
        {
            get { return _Points; }
            set { _Points = value; }
        }
        private Int32 _IsActive;

        public Int32 IsActive
        {
            get { return _IsActive; }
            set { _IsActive = value; }
        }
        private Int32 _IsDelete;

        public Int32 IsDelete
        {
            get { return _IsDelete; }
            set { _IsDelete = value; }
        }
        private string _DML;

        public string DML
        {
            get { return _DML; }
            set { _DML = value; }
        }
        private string _msg;

        public string Msg
        {
            get { return _msg; }
            set { _msg = value; }
        }
        private DateTime _Entry_Date;

        public DateTime Entry_Date
        {
            get { return _Entry_Date; }
            set { _Entry_Date = value; }
        }
        private Int32 _Courier;

        public Int32 Courier
        {
            get { return _Courier; }
            set { _Courier = value; }
        }
        private Int32 _Dealer;

        public Int32 Dealer
        {
            get { return _Dealer; }
            set { _Dealer = value; }
        }

        #endregion

        #region  Loyalty Programm Methods

        public static void InsertUpdateLoyalty(Loyalty_Settings Obj)
        {
            Data_Access_Layer.Loyalty_Function.InsertUpdateLoyaltySeetings(Obj);
        }
        public static void InsertUpdateReferralLimit(Loyalty_Settings Obj)
        {
            Data_Access_Layer.Loyalty_Function.InsertUpdateReferralLimit(Obj);
        }
        public static DataSet FillLoyaltySettingsGrid(Loyalty_Settings Obj)
        {
            return Data_Access_Layer.Loyalty_Function.FillLoyaltySettingsGrid(Obj);
        }
        #endregion
    }
    #endregion

    #region Master Loyalty Settings
    public class Loyalty_Awards
    {
        #region Loyalty Programm Property
        private Int64 _RewardKey;

        public Int64 RewardKey
        {
            get { return _RewardKey; }
            set { _RewardKey = value; }
        }
        private Int64 _RowId;

        public Int64 RowId
        {
            get { return _RowId; }
            set { _RowId = value; }
        }
        private string _User_ID;

        public string User_ID
        {
            get { return _User_ID; }
            set { _User_ID = value; }
        }
        private string _Comp_ID;

        public string Comp_ID
        {
            get { return _Comp_ID; }
            set { _Comp_ID = value; }
        }
        private string _CompName;

        public string CompName
        {
            get { return _CompName; }
            set { _CompName = value; }
        }
        private decimal _Points;

        public decimal Points
        {
            get { return _Points; }
            set { _Points = value; }
        }

        private int _DataQty;

        public int DataQty
        {
            get { return _DataQty; }
            set { _DataQty = value; }
        }

        private decimal _DataPrice;

        public decimal DataPrice
        {
            get { return _DataPrice; }
            set { _DataPrice = value; }
        }

        private decimal _EarnPoints;

        public decimal EarnPoints
        {
            get { return _EarnPoints; }
            set { _EarnPoints = value; }
        }
        private decimal _RedeemPoints;

        public decimal RedeemPoints
        {
            get { return _RedeemPoints; }
            set { _RedeemPoints = value; }
        }
        private decimal _BalancePoints;

        public decimal BalancePoints
        {
            get { return _BalancePoints; }
            set { _BalancePoints = value; }
        }
        private string _AwardName;

        public string AwardName
        {
            get { return _AwardName; }
            set { _AwardName = value; }
        }
        private Int32 _IsActive;

        public Int32 IsActive
        {
            get { return _IsActive; }
            set { _IsActive = value; }
        }
        private Int32 _IsDelete;

        public Int32 IsDelete
        {
            get { return _IsDelete; }
            set { _IsDelete = value; }
        }
        private string _DML;

        public string DML
        {
            get { return _DML; }
            set { _DML = value; }
        }
        private string _msg;

        public string Msg
        {
            get { return _msg; }
            set { _msg = value; }
        }
        private DateTime _Entry_Date;

        public DateTime Entry_Date
        {
            get { return _Entry_Date; }
            set { _Entry_Date = value; }
        }
        #endregion

        #region  Loyalty Programm Methods

        public static void InsertUpdateLoyaltyAward(Loyalty_Awards Obj)
        {
            Data_Access_Layer.Loyalty_Function.InsertUpdateLoyaltyAwards(Obj);
        }
        public static DataSet FillLoyaltyAwardsGrid(Loyalty_Awards Obj)
        {
            return Data_Access_Layer.Loyalty_Function.FillLoyaltyAwardsGrid(Obj);
        }
        #endregion

        public static void FillLoyaltyAwardsGridObject(Loyalty_Awards Reg)
        {
            Data_Access_Layer.Loyalty_Function.FillLoyaltyAwardsGridObject(Reg);
        }

        public static void IsActiveIsDeleteLoyaltyAwards(Loyalty_Awards Reg)
        {
            Data_Access_Layer.Loyalty_Function.IsActiveIsDeleteLoyaltyAwards(Reg);
        }
        public static void IsActiveIsDeleteBigDtataAlnalysisDATA(Loyalty_Awards Reg)
        {
            Data_Access_Layer.Loyalty_Function.IsActiveIsDeleteBigDtataAlnalysisDATA(Reg);
        }
        public static DataSet FillGrdLoyaltyAwards(Loyalty_Awards Reg)
        {
            return Data_Access_Layer.Loyalty_Function.FillGrdLoyaltyAwards(Reg);
        }
        public static DataSet FillMyAwards(Loyalty_Dispatch obj)
        {
            return Data_Access_Layer.Loyalty_Function.FillMyAwards(obj);
        }
        public static DataSet FillMyAwards(Loyalty_Awards obj)
        {
            return Data_Access_Layer.Loyalty_Function.FillMyAwards(obj);
        }
        public static DataSet FillGrdMainDispatchData(Loyalty_Awards obj)
        {
            return Data_Access_Layer.Loyalty_Function.FillGrdMainDispatchData(obj);
        }
        public static DataSet FillGrdWinAwards(Loyalty_Awards obj)
        {
            return Data_Access_Layer.Loyalty_Function.FillGrdWinAwards(obj);
        }
        public static DataSet FillMyWinAwards(Loyalty_Awards obj)
        {
            return Data_Access_Layer.Loyalty_Function.FillMyWinAwards(obj);
        }
        public static DataSet FillManufRedeemAwards(Loyalty_Awards obj)
        {
            return Data_Access_Layer.Loyalty_Function.FillManufRedeemAwards(obj);
        }
        public static DataSet FillMyCashWallet(Loyalty_Awards Reg)
        {
            return Data_Access_Layer.Loyalty_Function.FillMyCashWallet(Reg);
        }

        public static DataSet FillGrdMainDealerDispatch(Loyalty_Awards Reg)
        {
            return Data_Access_Layer.Loyalty_Function.FillGrdMainDealerDispatch(Reg);
        }
    }
    #endregion

    #region Master Points Details
    public class Loyalty_Points
    {
        #region Loyalty Programm Property
        private string _Mode;

        public string Mode
        {
            get { return _Mode; }
            set { _Mode = value; }
        }
        private string _MobileNo;

        public string MobileNo
        {
            get { return _MobileNo; }
            set { _MobileNo = value; }
        }
        private Int32 _IsUse;

        public Int32 IsUse
        {
            get { return _IsUse; }
            set { _IsUse = value; }
        }
        private Int32 _IsCashConvert;

        public Int32 IsCashConvert
        {
            get { return _IsCashConvert; }
            set { _IsCashConvert = value; }
        }
        private Int64 _Code1;

        public Int64 Code1
        {
            get { return _Code1; }
            set { _Code1 = value; }
        }
        private Int64 _Code2;

        public Int64 Code2
        {
            get { return _Code2; }
            set { _Code2 = value; }
        }
        private string _Pro_ID;

        public string Pro_ID
        {
            get { return _Pro_ID; }
            set { _Pro_ID = value; }
        }
        private string _User_ID;

        public string User_ID
        {
            get { return _User_ID; }
            set { _User_ID = value; }
        }
        private string _EarnType;

        public string EarnType
        {
            get { return _EarnType; }
            set { _EarnType = value; }
        }
        private Int32 _M_Consumerid;

        public Int32 M_Consumerid
        {
            get { return _M_Consumerid; }
            set { _M_Consumerid = value; }
        }

        private Int64 _RowId;

        public Int64 RowId
        {
            get { return _RowId; }
            set { _RowId = value; }
        }
        private string _Comp_ID;

        public string Comp_ID
        {
            get { return _Comp_ID; }
            set { _Comp_ID = value; }
        }
        public Int32 IsReferral { get; set; }
        public Int32 IsConvertCash { get; set; }
        private decimal _Points;

        public decimal Points
        {
            get { return _Points; }
            set { _Points = value; }
        }
        private string _AwardName;

        public string AwardName
        {
            get { return _AwardName; }
            set { _AwardName = value; }
        }
        private Int32 _IsActive;

        public Int32 IsActive
        {
            get { return _IsActive; }
            set { _IsActive = value; }
        }
        private Int32 _IsDelete;

        public Int32 IsDelete
        {
            get { return _IsDelete; }
            set { _IsDelete = value; }
        }
        private string _DML;

        public string DML
        {
            get { return _DML; }
            set { _DML = value; }
        }
        private string _msg;

        public string Msg
        {
            get { return _msg; }
            set { _msg = value; }
        }
        private DateTime _Entry_Date;

        public DateTime Entry_Date
        {
            get { return _Entry_Date; }
            set { _Entry_Date = value; }
        }
        #endregion

        #region  Loyalty Programm Methods

        public static void InsertUpdatePoints(Loyalty_Points Obj)
        {
            Data_Access_Layer.Loyalty_Function.InsertUpdatePoints(Obj);
        }
        public static DataSet FillLoyaltyAwardsGrid(Loyalty_Awards Obj)
        {
            return Data_Access_Layer.Loyalty_Function.FillLoyaltyAwardsGrid(Obj);
        }
        #endregion

        public static void FillLoyaltyAwardsGridObject(Loyalty_Awards Reg)
        {
            Data_Access_Layer.Loyalty_Function.FillLoyaltyAwardsGridObject(Reg);
        }

        public static void IsActiveIsDeleteLoyaltyAwards(Loyalty_Awards Reg)
        {
            Data_Access_Layer.Loyalty_Function.IsActiveIsDeleteLoyaltyAwards(Reg);
        }

        public static DataSet FillGrdpointsDetails(Loyalty_Points Reg)
        {
            return Data_Access_Layer.Loyalty_Function.FillGrdpointsDetails(Reg);
        }
        public static DataSet FillGrdForPoints(Loyalty_Points Reg)
        {
            return Data_Access_Layer.Loyalty_Function.FillGrdForPoints(Reg);
        }
        public static DataSet FillCompDropdownList(Loyalty_Points Reg)
        {
            return Data_Access_Layer.Loyalty_Function.FillCompDropdownList(Reg);
        }
        public static DataSet FillProductDropdownList(Loyalty_Points Reg)
        {
            return Data_Access_Layer.Loyalty_Function.FillProductDropdownList(Reg);
        }
        public static DataSet Proc_GetUseProductByConsumer(Loyalty_Points Reg)
        {
            return Data_Access_Layer.Loyalty_Function.Proc_GetUseProductByConsumer(Reg);
        }
        public static void InsertCashWallet(Award_Transactions op)
        {
            Data_Access_Layer.Loyalty_Function.InsertCashWallet(op);
        }
    }
    #endregion

    #region User Details

    public class Publisher_Details
    {
        private string _MobileNo;

        public string MobileNo
        {
            get { return _MobileNo; }
            set { _MobileNo = value; }
        }

        public string Bookname { get; set; }
        public string bookShop { get; set; }
        public string ccenter { get; set; }
        public string Code1 { get; set; }
        public string Code2 { get; set; }

    }

//packplus
    public class Exibition_details
    {
        private string _MobileNo;
        public string MobileNo
        {
            get { return _MobileNo; }
            set { _MobileNo = value; }
        }
        private string _Name;
        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }
        private string _Email;
        public string Email
        {
            get { return _Email; }
            set { _Email = value; }
        }
        private string _CompNAme;
        public string CompNAme
        {
            get { return _CompNAme; }
            set { _CompNAme = value; }
        }
        private string _Designation;
        public string Designation
        {
            get { return _Designation; }
            set { _Designation = value; }
        }
        private string _Intrest;
        public string Intrest
        {
            get { return _Intrest; }
            set { _Intrest = value; }
        }
        private string _DML;
        public string DML
        {
            get { return _DML; }
            set { _DML = value; }
        }
        private string _Exibitionname;
        public string Exibitionname
        {
            get { return _Exibitionname; }
            set { _Exibitionname = value; }
        }

        public static void InsertUpdateExibitiondtls(Exibition_details Obj)
        {
            Data_Access_Layer.Loyalty_Function.InsertUpdateExibitiondtls(Obj);
        }
    }
    //packplus

   public class User_Details
    {
        //User_ID, Email, MobileNo, City, PinCode, Password, Entry_Date
        #region User Details Property
        private string _aadharback;
        public string aadharback
        {
            get { return _aadharback; }
            set { _aadharback = value; }
        }
        private string _aadharNumber;
        public string aadharNumber
        {
            get { return _aadharNumber; }
            set { _aadharNumber = value; }
        }
        private string _distributorID;
        public string distributorID
        {
            get { return _distributorID; }
            set { _distributorID = value; }
        }

private string _Role_Id;       //Created by bipin for Inox 
        public string Role_ID
        {
            get { return _Role_Id; }
            set { _Role_Id = value; }
        }

 private string _Other_Role;       //Created by bipin for Inox 
        public string Other_Role
        {
            get { return _Other_Role; }
            set { _Other_Role = value; }
        }

        private string _PanNumber;       //Created by Deep Shukla For Hannover
        public string PanNumber
        {
            get { return _PanNumber; }
            set { _PanNumber = value; }
        }

        private string _UPI;       //Created by bipin for Inox 
        public string UPI
        {
            get { return _UPI; }
            set { _UPI = value; }
        }




        private string _code1;
        public string code1
        {
            get { return _code1; }
            set { _code1 = value; }
        }
        private string _code2;
        public string code2
        {
            get { return _code2; }
            set { _code2 = value; }
        }
        private string _Address;
        public string Address
        {
            get { return _Address; }
            set { _Address = value; }
        }

        private string _SellerName;
        public string SellerName
        {
            get { return _SellerName; }
            set { _SellerName = value; }
        }

        private string _referalcode;  // by Bipin for Ambica referal code
        public string referalcode
        {
            get { return _referalcode; }
            set { _referalcode = value; }
        }



        private string _PermanentAddress;

        public string PermanentAddress

        {

            get { return _PermanentAddress; }

            set { _PermanentAddress = value; }

        }

        private string _ConsumerName;

        public string ConsumerName
        {
            get { return _ConsumerName; }
            set { _ConsumerName = value; }
        }
        private string _User_Type;

        public string User_Type
        {
            get { return _User_Type; }
            set { _User_Type = value; }
        }


        private string _Comp_id;
        public string Comp_id
        {
            get { return _Comp_id; }
            set { _Comp_id = value; }
        }

        private string _User_ID;

        public string User_ID
        {
            get { return _User_ID; }
            set { _User_ID = value; }
        }
        private string _Consumer_ID;
        public string Consumer_ID
        {
            get { return _Consumer_ID; }
            set { _Consumer_ID = value; }
        }
        public string M_Consumerid
        {
            get { return _Consumer_ID; }
            set { _Consumer_ID = value; }
        }
        private string _Email;

        public string Email
        {
            get { return _Email; }
            set { _Email = value; }
        }
        private string _MobileNo;

        public string MobileNo
        {
            get { return _MobileNo; }
            set { _MobileNo = value; }
        }
        private string _profile_image;
        public string Profile_image
        {
            get { return _profile_image; }
            set { _profile_image = value; }
        }
        private string _City;

        public string City
        {
            get { return _City; }
            set { _City = value; }
        }
        private string _PinCode;

        public string PinCode
        {
            get { return _PinCode; }
            set { _PinCode = value; }
        }
        private string _Password;

        public string Password
        {
            get { return _Password; }
            set { _Password = value; }
        }
        private string _oldPassword;

        public string OldPassword
        {
            get { return _oldPassword; }
            set { _oldPassword = value; }
        }
        private Int32 _IsActive;
        public string strEntry_Date { get; set; }
        public Int32 IsActive
        {
            get { return _IsActive; }
            set { _IsActive = value; }
        }
        private Int32 _IsDelete;

        public Int32 IsDelete
        {
            get { return _IsDelete; }
            set { _IsDelete = value; }
        }
        private string _DML;

        public string DML
        {
            get { return _DML; }
            set { _DML = value; }
        }
        private DateTime _Entry_Date;

        public DateTime Entry_Date
        {
            get { return _Entry_Date; }
            set { _Entry_Date = value; }
        }

        private Int16 _EmployeeType;

        public Int16 EmployeeType
        {
            get { return _EmployeeType; }
            set { _EmployeeType = value; }
        }
        private string _EmployeeID;

        public string EmployeeID
        {
            get { return _EmployeeID; }
            set { _EmployeeID = value; }
        }
        private string _employeeID;

        public string employeeID
        {
            get { return _employeeID; }
            set { _employeeID = value; }
        }
        private int _createdby;

        public int CreatedBy
        {
            get { return _createdby; }
            set { _createdby = value; }
        }
//Created by Tej for VR  ------- start for VR Kabel
        private string _Role_Id_VRK;
        public string Role_ID_VRK
        {
            get { return _Role_Id_VRK; }
            set { _Role_Id_VRK = value; }
        }

        private string _cin_number;
        public string cin_number
        {
            get { return _cin_number; }
            set { _cin_number = value; }
        }

        private string _ref_cin_number;
        public string ref_cin_number
        {
            get { return _ref_cin_number; }
            set { _ref_cin_number = value; }
        }

        private string _designation;
        public string designation
        {
            get { return _designation; }
            set { _designation = value; }
        }

        private string _dob;
        public string dob
        {
            get { return _dob; }
            set { _dob = value; }
        }

        //Added by Bipin for Ramgoapl
        private string _Agegroup;
        public string Agegroup
        {
            get { return _Agegroup; }
            set { _Agegroup = value; }
        }
        //Added by Bipin for Ramgoapl

        private string _teslapayoutmode;       //Created by bipin for tesla 
        public string teslapayoutmode
        {
            get { return _teslapayoutmode; }
            set { _teslapayoutmode = value; }
        }

        private string _gender;
        public string gender
        {
            get { return _gender; }
            set { _gender = value; }
        }
        private string _sur_name;
        public string sur_name
        {
            get { return _sur_name; }
            set { _sur_name = value; }
        }
		 private string _communication_status;
        public string communication_status
        {
            get { return _communication_status; }
            set { _communication_status = value; }
        }

        private string _business_status;
        public string business_status
        {
            get { return _business_status; }
            set { _business_status = value; }
        }
		 private string _house_number;
        public string house_number
        {
            get { return _house_number; }
            set { _house_number = value; }
        }

        private string _land_mark;
        public string land_mark
        {
            get { return _land_mark; }
            set { _land_mark = value; }
        }


        //---------- close for VR Kabel

        public string village { get; set; }
        public string country { get; set; }
        public string district { get; set; }
        public string state { get; set; }
        public string MMEmployeID { get; set; }
        public string MMDistributorID { get; set; }
        public string AadhaarNumber { get; set; }
        public string AadhaarFile { get; set; }
        public string aadharFile { get; set; }
        public string Aadhaarback { get; set; }
        public string BankFile { get; set; }
        public string MMUser { get; set; }
        public string Designation { get; set; }
        #endregion

        #region  Loyalty Programm Methods

        public static void InsertUpdateUserDetails(User_Details Obj)
        {
            Data_Access_Layer.Loyalty_Function.InsertUpdateUserDetails(Obj);
        }

        public static void InsertUpdatePublisherDetails(Publisher_Details Obj)
        {
            Data_Access_Layer.Loyalty_Function.InsertUpdatePublisherDetails(Obj);
        }

        public static string appInsertUpdateUserDetails(User_Details Obj)
        {
            return Data_Access_Layer.Loyalty_Function.appInsertUpdateUserDetails(Obj);
        }
        public static DataTable GetUserLoginDetails(User_Details Log)
        {
            return Data_Access_Layer.Loyalty_Function.GetUserLoginDetails(Log);
        }
        public static DataTable app_GetUserLoginDetails(User_Details Log)
        {
            return Data_Access_Layer.Loyalty_Function.app_GetUserLoginDetails(Log);
        }
        //Added by Bipin for Ambika Reffral
        public static string web_LoginAbbikauser(string MobileNo, string password)
        {
            return Data_Access_Layer.Loyalty_Function.web_LoginAbbikauser(MobileNo, password);
        }

        public static string web_LoginregAbbikauser(string MobileNo)
        {
            return Data_Access_Layer.Loyalty_Function.web_LoginregAbbikauser(MobileNo);
        }
        //End of  Ambika Reffral
        public static void FillUpDateProfile(User_Details Reg)
        {
            Data_Access_Layer.Loyalty_Function.FillUpDateProfile(Reg);
        }
        public static void FillUpTransaction(User_Details Reg)
        {
            Data_Access_Layer.Loyalty_Function.FillUpDateProfile(Reg);
        }
        #endregion

        public static bool CheckOldPassConsumer(User_Details Reg)
        {
            return Data_Access_Layer.Loyalty_Function.CheckOldPassConsumer(Reg);
        }

        public static void ChangePassConsumer(User_Details Reg)
        {
            Data_Access_Layer.Loyalty_Function.ChangePassConsumer(Reg);
        }
    }

    public class Claim
    {
        public string Userid { get; set; }
        public int ProductId { get; set; }
        public int Productvalue { get; set; }
        public string claimdate { get; set; }
        public string Comp_id { get; set; }
    }

    public class tbl_Gift_Dispatch
    {
        public string Gift_Name { get; set; }
        public int M_consumerID { get; set; }
        public DateTime DispatchDate { get; set; }
        public string Mobile_No { get; set; }
        public string Comp_ID { get; set; }
        public string Courier_Name { get; set; }
        public string Tracking_No { get; set; }
        public string Dispatch_location { get; set; }
        public string Comments { get; set; }
    }

    #endregion
    public class message_status
    {
        public string status { get; set; }
        public string message { get; set; }
        public string fields { get; set; }
    }
    public class app_details
    {
        public string status { get; set; }
        public string message { get; set; }
        public string Logopath { get; set; }
        public string CompanyName { get; set; }
        public string ServiceId { get; set; }
        public string longitude { get; set; }
        public string latitude { get; set; }
        public string mobile { get; set; }
        public string code1 { get; set; }
        public string code2 { get; set; }
        public string fields { get; set; }
    }

    #region User Award Transactions
    public class Award_Transactions
    {
        #region User Details Property
        private Int64 _RowId;

        public Int64 RowId
        {
            get { return _RowId; }
            set { _RowId = value; }
        }
        private string _AwardName;

        public string AwardName
        {
            get { return _AwardName; }
            set { _AwardName = value; }
        }
        private string _Award_Key;

        public string Award_Key
        {
            get { return _Award_Key; }
            set { _Award_Key = value; }
        }
        private string _Particulers;

        public string Particulers
        {
            get { return _Particulers; }
            set { _Particulers = value; }
        }
        private Int64 _Credit;

        public Int64 Credit
        {
            get { return _Credit; }
            set { _Credit = value; }
        }
        private Int64 _Debit;

        public Int64 Debit
        {
            get { return _Debit; }
            set { _Debit = value; }
        }
        private decimal _Points;

        public decimal Points
        {
            get { return _Points; }
            set { _Points = value; }
        }
        private string _User_ID;

        public string User_ID
        {
            get { return _User_ID; }
            set { _User_ID = value; }
        }
        private string _Comp_ID;

        public string Comp_ID
        {
            get { return _Comp_ID; }
            set { _Comp_ID = value; }
        }
        private string _Dealer_ID;

        public string Dealer_ID
        {
            get { return _Dealer_ID; }
            set { _Dealer_ID = value; }
        }
        private string _TransactionNo;

        public string TransactionNo
        {
            get { return _TransactionNo; }
            set { _TransactionNo = value; }
        }
        private string _Delivery_Type;

        public string Delivery_Type
        {
            get { return _Delivery_Type; }
            set { _Delivery_Type = value; }
        }

        private string _Remarks;

        public string Remarks
        {
            get { return _Remarks; }
            set { _Remarks = value; }
        }

        private Int64 _Cash_Amount;

        public Int64 Cash_Amount
        {
            get { return _Cash_Amount; }
            set { _Cash_Amount = value; }
        }
        private Int32 _IsDelivered;

        public Int32 IsDelivered
        {
            get { return _IsDelivered; }
            set { _IsDelivered = value; }
        }
        private Int32 _IsActive;

        public Int32 IsActive
        {
            get { return _IsActive; }
            set { _IsActive = value; }
        }
        private Int32 _IsDelete;

        public Int32 IsDelete
        {
            get { return _IsDelete; }
            set { _IsDelete = value; }
        }
        private string _DML;

        public string DML
        {
            get { return _DML; }
            set { _DML = value; }
        }
        private DateTime _Entry_Date;

        public DateTime Entry_Date
        {
            get { return _Entry_Date; }
            set { _Entry_Date = value; }
        }
        #endregion

        #region  Loyalty Programm Methods

        #endregion

        public static DataTable FillLoyaltyAwardsGridObject(Award_Transactions Reg)
        {
            return Data_Access_Layer.Loyalty_Function.FillLoyaltyAwardsGridObject(Reg);
        }

        public static void InsertDistributedAwards(Award_Transactions Reg)
        {
            Data_Access_Layer.Loyalty_Function.InsertDistributedAwards(Reg);
        }
    }
    #endregion

    #region Courier Dispach Awards
    public class Loyalty_Dispatch
    {
        #region Courier Dispatch
        public Int64 RefRowId { get; set; }
        public Int64 RowId { get; set; }
        public string Courier_ID { get; set; }
        public string Courier_Name { get; set; }
        public string Courier_Email { get; set; }
        public string Courier_Mobile { get; set; }
        public string Courier_Address { get; set; }
        public string Courier_Disp_ID { get; set; }
        public string Tracking_No { get; set; }
        public DateTime Dispatch_Date { get; set; }
        public DateTime Expected_Date { get; set; }
        public string Dispatch_Pin { get; set; }
        public Int64 BatchSize { get; set; }
        public string Dispatch_Location { get; set; }
        public string chkstr { get; set; }
        public int Courier_Status { get; set; }
        public string Series_From { get; set; }
        public string Series_DFrom { get; set; }
        public string Series_To { get; set; }
        public DateTime Entry_Date { get; set; }
        public string Comp_ID { get; set; }
        public string DML { get; set; }
        public Int32 Received_Flag { get; set; }
        public string Admin_Reason { get; set; }
        public string Consumer_Reason { get; set; }
        #endregion

        public static void InsertUpdateDispatchDetails(Loyalty_Dispatch Reg)
        {
            Data_Access_Layer.Loyalty_Function.InsertUpdateDispatchDetails(Reg);
        }
    }

    #endregion

    #region Dealer Master
    public class Loyalty_Dealer
    {
        #region Dealer Master Property
        public Int64 Row_ID { get; set; }
        public string Comp_ID { get; set; }
        public string Dealer_ID { get; set; }
        public string Dealer_Name { get; set; }
        public string Contact_Person { get; set; }
        public string Email { get; set; }
        public string Address { get; set; }
        public string Mobile_No { get; set; }
        public string Password { get; set; }
        public DateTime Entry_Date { get; set; }
        public int IsActive { get; set; }
        public string DML { get; set; }
        public string City { get; set; }
        #endregion

        #region Dealer Master Function
        public static DataSet FillGridDealer(Loyalty_Dealer Reg)
        {
            return Data_Access_Layer.Loyalty_Function.FillGridDealer(Reg);
        }
        public static void SaveDealer(Loyalty_Dealer Reg)
        {
            Data_Access_Layer.Loyalty_Function.SaveDealer(Reg);
        }
        public static void ActiveDeActiveDealer(Loyalty_Dealer Reg)
        {
            Data_Access_Layer.Loyalty_Function.ActiveDeActiveDealer(Reg);
        }
        #endregion


    }
    #endregion

    #endregion

    #region Service Programm

    #region Master Service
    public partial class ObjService
    {
        #region Service Programm Property
        public string Subscribe_Id { get; set; }
        public Int64 PlanMasterPeriod { get; set; }
        public Int64 PlanSalePeriod { get; set; }
        public Int64 PlanMasterPrice { get; set; }
        public Int64 PlanSalePrice { get; set; }
        public int IsAdminVerify { get; set; }

        public string Plan_ID { get; set; }
        public string Pro_ID { get; set; }
        public string Comp_ID { get; set; }
        public string Service_ID { get; set; }
        public string EditServiceID { get; set; }
        public string ServiceName { get; set; }
        public Nullable<int> IsShowPrice { get; set; }
        public DateTime EntryDate { get; set; }
        public string Image { get; set; }
        public int IsActive { get; set; }
        public int IsDelete { get; set; }
        public string DML { get; set; }
        public string Act { get; set; }

        public Int64 ServiceFeaure_ID { get; set; }

        public Int64 Trans_ID { get; set; }
        public Int64 ReturnTransID { get; set; }

        public DateTime DateFrom { get; set; }
        public DateTime DateTo { get; set; }

        public double PlanPrice { get; set; }
        public string PlanName { get; set; }
        public Int64 PlanPeriod { get; set; }
        public double Service_Year { get; set; }
        public double Service_Months { get; set; }
        public string Msg { get; set; }

        public Int64 Row_ID { get; set; }
        public int IsPoints { get; set; }
        public int IsDateRange { get; set; }
        public int IsSound { get; set; }
        public int IsFrequency { get; set; }
        public int IsAdditionalGift { get; set; }
        public int IsMessageTemplete { get; set; }
        public int IsNotify { get; set; }
        public int IsNoMessage { get; set; }
        public int IsCoupons { get; set; }
        public int IsCash { get; set; }
        public int IsReferral { get; set; }

        public string AboutService { get; set; }
        public string Terms_Conditions { get; set; }
        public string Advantage { get; set; }


        #endregion

        #region Service Programm Function
        public static DataSet FillGridService(ObjService Reg)
        {
            return MasterService.FillGridService(Reg);
        }
        public static void IUpdService(ObjService Reg)
        {
            MasterService.IUpdService(Reg);
        }
        public static void FillServiceInfo(ObjService Reg)
        {
            MasterService.FillServiceInfo(Reg);
        }
        #endregion

        #region Service Programm For Price Function
        public static DataSet FillServicePriceDetails(ObjService Reg)
        {
            return MasterService.FillServicePriceDetails(Reg);
        }
        public static void IUpdServicePrice(ObjService Reg)
        {
            MasterService.IUpdServicePrice(Reg);
        }
        public static void FillServicePriceInfo(ObjService Reg)
        {
            MasterService.FillServicePriceInfo(Reg);
        }
        public static DataSet FillServicePriceTransDetGrd(ObjService Reg)
        {
            return MasterService.FillServicePriceTransDetGrd(Reg);
        }
        public static DataSet FillServiceddl()
        {
            return MasterService.FillServiceddl();
        }
        public static DataSet FillServiceddl(ObjService Reg)
        {
            return MasterService.FillServiceddl(Reg);
        }
        #endregion

        #region Service Feature Function
        public static DataSet FillGridServiceFeature(ObjService Reg)
        {
            return MasterService.FillGridServiceFeature(Reg);
        }
        public static void IUpdServiceFeature(ObjService Reg)
        {
            MasterService.IUpdServiceFeature(Reg);
        }
        public static void FillServiceFeatureInfo(ObjService Reg)
        {
            MasterService.FillServiceFeatureInfo(Reg);
        }
        #endregion
        #region About Service, Advantage &  Terms & Conditions
        public static void NewsEntry(ObjService Reg)
        {
            MasterService.NewsEntry(Reg);
        }
        public static void FillGrid(GridView MyGridView)
        {
            DataSet ds = new DataSet();
            MyGridView.DataSource = MasterService.FillGridData();
            MyGridView.DataBind();
        }
        public static DataSet FillDataUpDate(ObjService NewUpdt)
        {
            DataSet ds = new DataSet();
            return MasterService.FillDataUpDate(NewUpdt);
        }
        public static void DeleteRecords(ObjService NewUpdt)
        {
            MasterService.DeleteRecords(NewUpdt);
        }
        #endregion







        public static void InsertUpdateServieSubscription(ObjService Reg)
        {
            MasterService.InsertUpdateServieSubscription(Reg);
        }

        public static void VerifyServiceRequest(ObjService Reg)
        {
            MasterService.VerifyServiceRequest(Reg);
        }
    }
    #endregion
    #region Service Programm Function

    #endregion
    #endregion

    #region MyWarranty
    public partial class Warranty
    {
        public static DataSet CashWalletReport(string strCompanyId)
        {
            return Data_Access_Layer.Loyalty_Function.CashWalletReport(strCompanyId);
        }
        public static DataSet GetClaimDetailVendorMidas(string strCompanyId)
        {
            return Data_Access_Layer.Loyalty_Function.GetClaimDetailVendorMidas(strCompanyId);
        }
        public static DataSet GetClaimDetailVendor_downloadMidas(string strCompanyId)
        {
            return Data_Access_Layer.Loyalty_Function.GetClaimDetailVendor_downloadMidas(strCompanyId);
        }
        public static DataSet GetClaimDetailVendorWallet_downloadMidas(string strCompanyId)
        {
            return Data_Access_Layer.Loyalty_Function.GetClaimDetailVendorWallet_downloadMidas(strCompanyId);
        }

        public static DataSet GetWarrantyDetail(string email)
        {
            return Data_Access_Layer.Warranty.GetWarrantyDetail(email);
        }

        public static DataSet GetClaimDetailVendor(string strCompanyId)
        {
            return Data_Access_Layer.Loyalty_Function.GetClaimDetailVendor(strCompanyId);
        }
        public static DataSet GetClaimDetailVendor_download(string strCompanyId)
        {
            return Data_Access_Layer.Loyalty_Function.GetClaimDetailVendor_download(strCompanyId);
        }

        public static DataSet GetWarrantyDetailVendor(string strCompanyId)
        {
            return Data_Access_Layer.Warranty.GetWarrantyDetailVendor(strCompanyId);
        }
        public static DataSet GetWarrantyDetailVendor_download(string strCompanyId)
        {
            return Data_Access_Layer.Warranty.GetWarrantyDetailVendor_download(strCompanyId);
        }

        public static DataSet GetImages(int id)
        {
            return Data_Access_Layer.Warranty.GetImages(id);
        }
    }
    #endregion

// --------------- Start VR Kable -------------------
   public class message_AddVrReg
    {
        public string status { get; set; }
        public string result { get; set; }
        public string user_id { get; set; }
        public string user_idnew { get; set; }
        public string m_consumerid { get; set; }
        public string id { get; set; }
        public string name { get; set; }
        public string user_type { get; set; }
        public string communication_status { get; set; }
        public string business_status { get; set; }
        public string cin_number { get; set; }
        public string userTypeName { get; set; }
        public string mobile_number { get; set; }
        public string profile_status { get; set; }
        public string kycStatus { get; set; }
        public string entryDate { get; set; }


    }

    public class message_Vrkabel
    {
        public string status { get; set; }
        public string result { get; set; }
        public string message { get; set; }
        public string cinNumber { get; set; }

    }
    public class msg_Vrkabel
    {
        public string status { get; set; }
        public string result { get; set; }
        public string message { get; set; }
    }

public class Profile_DetailsVrKabel 
    {
        public string owner_number { get; set; }
        public string shop_name { get; set; }
        public string aadhar_number { get; set; }
        public string pan_card_file { get; set; }
        public string aadhar_file_front { get; set; }
        public string aadhar_file_back { get; set; }
        public string user_type { get; set; }
        public string name { get; set; }
        public string userTypeName { get; set; }
        public string mobile_number { get; set; }
        public string cin_number { get; set; }
        public string status { get; set;  }

        public string sur_name { get; set; }
        public string gender { get; set; }
        public string dob { get; set; }
        public string email_id { get; set; }
        public string house_number { get; set; }
        public string land_mark { get; set; }
        public string city { get; set; }
        public string district { get; set; }
        public string state { get; set; }
        public string pin_code { get; set; }
        public string pancard_number { get; set; }
        public string gst_number { get; set; }
        public string designation { get; set; }
        public string shop_file { get; set; }
        public string ref_cin_number { get; set; }
        public string user_id { get; set; }
        public string communication_status { get; set; }
        public string business_status { get; set; }
        public string message { get; set; }
 	public string M_Consumerid { get; set; }

    }
    // --------------- Close VR Kable -------------------

}