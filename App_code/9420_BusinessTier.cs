using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Data9420;
using System.Diagnostics;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Net;
/// <summary>
/// Summary description for _9420_BusinessTier
/// </summary>
/// 

namespace Business9420
{
    public class Object9420
    {
        public string Refral { get; set; }
        #region dealer_fields
        public string dealerid { get; set; }
        public string dealer_mobile { get; set; }
        #endregion
        #region Company_Document
        public string Comp_Info { get; set; }
        public string PAN_TAN { get; set; }
        public string VAT { get; set; }
        public string Comp_Addressproof { get; set; }
        public string Owner_proof { get; set; }
        public string Signature { get; set; }
        public string Doc_Id { get; set; }
        public int DocFlag { get; set; }
        #endregion

        #region CompanyRegion
        public string PartmerID { get; set; }
        public string Name { get; set; }
        public string cmobile { get; set; }
        public string Email { get; set; }
        public string PANNo { get; set; }
        public string PANNoProof { get; set; }
        public string IDProof { get; set; }
        public string Addproof { get; set; }
        public string Photo { get; set; }
        public string BankAccNo { get; set; }
        #endregion

        #region CompanyRegion
        public static string DownloadZipFIle { get; set; }
        public string HindiFile { get; set; }
        public string EnglishFle { get; set; }
        public string Row_ID { get; set; }
        public Int64 M_code_Row_ID { get; set; }
        public string OldRow_ID { get; set; }
        public Int32 NoofCodes { get; set; }

        public string ProductionUnit { get; set; }
        public string Channels { get; set; }
        public Int32 ExcNoofCodes { get; set; }
        public Int32 ActNoofCodes { get; set; }
        public string Comp_ID { get; set; }
        public string Comp_Name { get; set; }
        public Int32 Comp_Cat_Id { get; set; }
        public string Comp_Email { get; set; }
        public string PacketCode { get; set; }
        public string WebSite { get; set; }
        public string Address { get; set; }

        public string ResiAddress { get; set; }
        public string DirectorName { get; set; }
        public string DirectorFatherName { get; set; }

        public string AadharNumber { get; set; }
public bool IsAadharVerified { get; set; }
        public Int32 City_ID { get; set; }
        public Int32 M_ConsumerID { get; set; }
        public Int64 intM_Consumer_MCOde { get; set; }
        public string Contact_Person { get; set; }
        public string Mobile_No { get; set; }
        public string Phone_No { get; set; }
        public string Fax { get; set; }
        public string Reg_Date { get; set; }
        public DateTime Req_Date { get; set; }
        public DateTime Rec_Date { get; set; }
        public string Password { get; set; }
        public string oldPassword { get; set; }
        public Int32 IsRetailer { get; set; }
        public Int32 Status { get; set; }
        public Int32 Email_Vari_Flag { get; set; }
        public Int32 Update_Flag { get; set; }
        public string TypeOfCompany { get; set; }
        public string Comp_type { get; set; }
        public string Condition { get; set; }
        public DateTime AmcDateFrom { get; set; }
        public DateTime AmcDateTo { get; set; }
        public DateTime DateFrom { get; set; }
        public DateTime DateTo { get; set; }
        public DateTime DateFromChk { get; set; }
        public DateTime DateToChk { get; set; }
        public DateTime PromoDateFrom { get; set; }
        public DateTime PromoDateTo { get; set; }
        public string logo_path { get; set; }
        #endregion

        #region CodeMaster
        public string Gen_Date { get; set; }
        public string Gen_By { get; set; }
        public Int64 Code1 { get; set; }
        public Int64 Code2 { get; set; }
        public string Use_Type { get; set; }
        public DateTime Allot_Date { get; set; }
        public Int32 Print_Status { get; set; }
        public DateTime Print_Date { get; set; }
        public Int32 Use_Count { get; set; }
        public Int32 ScrapeFlag { get; set; }
        public Int32 Series_Order { get; set; }
        public Int32 Series_Serial { get; set; }
        public Int32 Series_SerialTo { get; set; }

        public Int64 l1 { get; set; }
        public Int64 u1 { get; set; }
        public Int64 l2 { get; set; }
        public Int64 u2 { get; set; }

        public Int64 Norec { get; set; }
        public Int64 intFlag { get; set; }




        #endregion

        #region ProductEnquiry
        public string Dial_Mode { get; set; }
        public DateTime Enq_Date { get; set; }
public string Image { get; set; }//added by bipin for Oltimo
        public string Mode_Detail { get; set; }
//public string city { get; set; }//added by bipin 190922
        public string State { get; set; }//added by bipin 220922
public string Retailer_Name { get; set; }//added by bipin for raunaq
public string Others { get; set; }//added by bipin for Avtaar
public string Shop_Name { get; set; }//lexis nexsis tej

public string PinCode { get; set; }//Patanjali Deep Shukla
public string IsVerified { get; set; }//Patanjali Deep Shukla
        public string Latitude { get; set; }//Patanjali Deep Shukla
        public string Longitude { get; set; }//Patanjali Deep Shukla


        public string callercircle { get; set; }

        public string network { get; set; }

        public DateTime callerdate { get; set; }
        public string callertime { get; set; }
        public string Received_Code1 { get; set; }
        public string Received_Code2 { get; set; }
        public Int32 Is_Success { get; set; }
        public string M_Code { get; set; }
        public string TempleteHead { get; set; }
        public string SubHeadId { get; set; }
        public string consumer_name { get; set; }

        public string designation { get; set; }
        #endregion

        #region ProductMaster
        public string Subscribe_Id { get; set; }
        public string Pro_ID { get; set; }
        public string Service_ID { get; set; }
        public string Pro_Entry_Date { get; set; }
        public string Pro_Name { get; set; }
        public string Pro_Descri { get; set; }
        public string DML { get; set; }
        public string datefromstr { get; set; }
        public string datetostr { get; set; }
        public string modestr { get; set; }
        public string statusstr { get; set; }
        public string Path { get; set; }
        #endregion

        #region ProductDetail
        public double MRP { get; set; }
        public int Warranty { get; set; }
        public DateTime Mfd_Date { get; set; }

        public string DemoMfd_Date { get; set; }

        public string Exp_Date { get; set; }
        public string Batch_No { get; set; }
        public DateTime Entry_Date { get; set; }
        public string Comments { get; set; }
        public string NewsLetterID { get; set; }
        public string NewsSubject { get; set; }
        public string NewsContent { get; set; }
        #endregion

        #region MessageLog
        public string Send_To { get; set; }
        public string Send_CC { get; set; }
        public string Send_BCC { get; set; }
        public string Send_Subject { get; set; }
        public string Send_Message { get; set; }
        public string Send_AttachFile { get; set; }
        #endregion

        #region Demo Allocation
        public string Packet_Name { get; set; }
        #endregion

        #region Generate_Bill
        public string FolderPath { get; set; }
        public string ImgFolderPath { get; set; }
        public int Act_Flag { get; set; }
        public int Con_Flag { get; set; }
        public int Del_Flag { get; set; }
        public string Img1 { get; set; }
        public string Img2 { get; set; }
        public string Testimonial_ID { get; set; }
        public string Testimonial_Text { get; set; }
        public string Invoice_No { get; set; }
        public DateTime Invoice_Date { get; set; }
        public string Invoice_ID { get; set; }
        public string Head_ID { get; set; }
        public string Head_Name { get; set; }
        public string Cancelled_By { get; set; }
        public string Last_Payment_Receipt { get; set; }
        public double Last_Paid_Amount { get; set; }
        public DateTime Last_Paid_Date { get; set; }
        public string Net_Balance { get; set; }
        public double Net_Pay { get; set; }
        public string Request_No { get; set; }
        public string Remarks { get; set; }
        public string Location { get; set; }
        public string AmcOfferRemarks { get; set; }
        public string Message { get; set; }
        public string Comment_Txt { get; set; }
        public string Admin_Remarks { get; set; }
        public double Qty { get; set; }
        public double Rate { get; set; }
        public double Rec_Payment { get; set; }
        public double ManuReq_Payment { get; set; }
        public double Debit_Payment { get; set; }
        public double Credit_Payment { get; set; }
        public double AdminReq_Payment { get; set; }
        public double Req_Payment { get; set; }
        public double TotalReq_Payment { get; set; }
        public string TransRow_ID { get; set; }
        public double TRec_Payment { get; set; }
        public double TReq_Payment { get; set; }
        public string Refund_From { get; set; }
        public double MG_Amount { get; set; }
        public double G_Amount { get; set; }
        public double Tax { get; set; }
        public double Service_Tax { get; set; }
        public double Vat_Tax { get; set; }
        public double Service_Tax_Value { get; set; }
        public double Vat_Tax_Value { get; set; }
        public double MService_Tax_Value { get; set; }
        public double MVat_Tax_Value { get; set; }
        public string TaxSet_ID { get; set; }
        public double Label_ServiceTax { get; set; }
        public double Label_Vat { get; set; }
        public double AMC_ServiceTax { get; set; }
        public double AMC_Vat { get; set; }
        public double Offer_ServiceTax { get; set; }
        public double Offer_Vat { get; set; }
        public double N_Amount { get; set; }
        public string Upgrade_From { get; set; }
        public double Upgrade_Amount { get; set; }
        public double OldUpgrade_Amount { get; set; }
        public double MN_Amount { get; set; }
        public double Pre_Bal { get; set; }
        public string PayMode { get; set; }
        public string ModeofPayment { get; set; }
        public string Details { get; set; }
        public string FileType { get; set; }
        public string Amt_Type { get; set; }
        public int Pay_Type { get; set; }
        public double PayAmt { get; set; }
        public double OldPayAmt { get; set; }
        public double OldReqAmt { get; set; }
        public double Discount { get; set; }
        public double CDiscount { get; set; }
        public double MDiscount { get; set; }

        #endregion

        #region Admin_Login
        public string User_ID { get; set; }
        public string User_Type { get; set; }
        #endregion

        #region Category and Customer
        public string Category_ID { get; set; }
        public string Category_Name { get; set; }

        public string Customer_ID { get; set; }
        public string Customer_Name { get; set; }
        #endregion

        #region Create Label
        public string LabelUploadRptID { get; set; }
        public string Label_Code { get; set; }
        public string LabelRequestID { get; set; }
        public string Label_Name { get; set; }
        public string Label_Size { get; set; }
        public double Label_Prise { get; set; }
        public string Label_Width { get; set; }
        public string Label_Height { get; set; }
        public string Label_Image { get; set; }
        public string Msg { get; set; }
        public int Flag { get; set; }
        public int Disp { get; set; }
        public string Label_Msg { get; set; }
        public string Pro_Doc { get; set; }
        public int Doc_Flag { get; set; }
        public string Plan_ID { get; set; }
        public string OldPlan_ID { get; set; }
        public Int32 Plan_Time { get; set; }
        public Int32 Plan_year { get; set; }
        public Int32 Plan_months { get; set; }
        public Int32 Plan_days { get; set; }
        public string Plan_Name { get; set; }
        public string Plan_Type { get; set; }
        public double PlanAmount { get; set; }
        public double Plan_Amount { get; set; }
        public double Plan_AmountA { get; set; }
        public double Plan_Discount { get; set; }
        public double Plan_DiscountC { get; set; }
        public double Admin_Balance { get; set; }
        public double Manu_Balance { get; set; }
        public double Balance { get; set; }
        public double Availabl_Balance { get; set; }
        public double Pay_Balance { get; set; }
        public int Amc_Offer_ID { get; set; }
        public double AmcPlan_Amount { get; set; }
        public string Amt_Remark { get; set; }
        public string Admin_Remark { get; set; }
        public string Manu_Remark { get; set; }
        public string Trans_Type { get; set; }
        public string TransType { get; set; }
        public string Manage_By { get; set; }
        public string UniqueID { get; set; }
        public string Promo_Id { get; set; }
        public string OldPromo_Id { get; set; }
        public string Promo_Name { get; set; }
        public double Promo_Amount { get; set; }
        public double Promo_AmountA { get; set; }
        public int Time_Days { get; set; }
        public int TotalTime { get; set; }
        #endregion

        #region Bank Account
        public string Bank_ID { get; set; }
        public string Bank_Name { get; set; }
        public string Account_HolderNm { get; set; }
        public string Account_No { get; set; }
        public string Branch { get; set; }
        public string IFSC_Code { get; set; }
        public string City { get; set; }
        public string RTGS_Code { get; set; }
        public string Account_Type { get; set; }
        public string chkpassbook { get; set; }
        #endregion

        #region Courier
        public int CourierPkid { get; set; }
        public string Courier_ID { get; set; }
        public string Courier_Name { get; set; }
        public string Courier_Email { get; set; }
        public string Courier_Mobile { get; set; }
        public string Courier_Address { get; set; }
        #endregion

        #region Courier Dispatch
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
        #endregion
    }
    public class location
    {
        public string code1 { get; set; }
        public string code2 { get; set; }
        public string mobileno { get; set; }
        public string latitude { get; set; }
        public string longitude { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public string country { get; set; }
        public string address { get; set; }
        public DateTime EnqDate { get; set; }
        public string PostalCode { get; set; }
    }

    //added by Bipin fro Wellverse

    public class insertfakedata
    {
        public string Mobileno { get; set; }
        public string Imgpath { get; set; }
        public string Purchsedfrom { get; set; }
        public string Lat { get; set; }
        public string Long { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Country { get; set; }
        public string Comp_id { get; set; }
        public string Remark { get; set; }
        public string DML { get; set; }

    }

    //End of Wellverse
    public class function9420
    {
        public static void SaveProductMaster(Object9420 obj)
        {
            Data_9420.SaveProductMaster(obj);
        }
        public static void ProductMaster(Object9420 obj)
        {
            Data_9420.ProductMaster(obj);
        }
        public static DataSet FetchData(Object9420 obj)
        {
            return Data_9420.FetchData(obj);
        }

        public static DataSet UpdateData(Object9420 obj)
        {
            return Data_9420.UpdateData(obj);
        }

        public static void UpdateProductMaster(Object9420 obj)
        {
            Data_9420.UpdateProductMaster(obj);
        }

        public static void DeleteProductMaster(Object9420 obj)
        {
            Data_9420.DeleteProductMaster(obj);
        }

        public static DataSet fetchCategory()
        {
            return Data_9420.fetchCategory();
        }

        public static bool CheckeReadyCodes(Object9420 Reg)
        {
            return Data_9420.CheckeReadyCodes(Reg);
        }

        public static DataSet FindCheckCodes(Object9420 Reg)
        {
            return Data_9420.FindCheckCodes(Reg);
        }


        public static DataSet FindCodesUsesDataSearch(Object9420 Reg)
        {
            return Data_9420.FindCodesUsesDataSearch(Reg);
        }
        public static DataSet FindCheckedCode(Object9420 Reg)
        {
            return Data_9420.FindCheckedCode(Reg);
        }
        public static DataSet FindCheckeCodes(Object9420 Reg)
        {
            return Data_9420.FindCheckeCodes(Reg);
        }






        public static DataSet fetchCountry()
        {
            return Data_9420.fetchCountry();
        }
        public static DataSet fetchState()
        {
            return Data_9420.fetchState();
        }

        public static void SavePartnerReg(Object9420 obj)
        {
            Data_9420.SavePartnerReg(obj);
        }

        public static void SaveCompanyReg(Object9420 obj)
        {
            Data_9420.SaveCompanyReg(obj);
        }

        public static void MasterCodeGeneration(Object9420 obj)
        {
            Data_9420.MasterCodeGeneration(obj);
        }

        public static DataSet fetchProductCodeDT(Object9420 obj)
        {
            return Data_9420.fetchProductCodeDT(obj);
        }

        #region Avadhesh

        public static DataSet FetchProductDetailsData(Object9420 obj)
        {
            return Data_9420.FetchProductDetailsData(obj);
        }
        public static DataSet FetchProduct_Id(Object9420 obj)
        {
            return Data_9420.FetchProduct_Id(obj);
        }
        public static DataSet FetchComanyProfileData()
        {
            return Data_9420.FetchComanyProfileData();
        }
        public static DataSet FindData(Object9420 Reg)
        {
            return Data_9420.FindData(Reg);
        }

        public static void CheckPaymentRec(Object9420 Reg)
        {
            Data_9420.CheckPaymentRec(Reg);
        }

        public static void CompanyAutherntication(Object9420 Reg)
        {
            Data_9420.CompanyAutherntication(Reg);
        }
        public static void CompanyAuthernticationEmailVeriFy(Object9420 Reg)
        {
            Data_9420.CompanyAuthernticationEmailVeriFy(Reg);
        }
        public static void CompanyAuthernticationNew(Object9420 Reg)
        {
            Data_9420.CompanyAuthernticationNew(Reg);
        }
        public static void CompanyAuthernticationBlock(Object9420 Reg)
        {
            Data_9420.CompanyAuthernticationBlock(Reg);
        }
        public static void RegDeleteData(Object9420 Reg)
        {
            Data_9420.RegDeleteData(Reg);
        }
        public static DataSet FillddlCat()
        {
            return Data_9420.FillddlCat();
        }
        public static DataSet FindDataOther(Object9420 Reg)
        {
            return Data_9420.FindDataOther(Reg);
        }
        public static DataSet FetchSearchData(Object9420 obj)
        {
            return Data_9420.FetchSearchData(obj);
        }
        public static DataSet CheckStatusForMan(Object9420 obj)
        {
            return Data_9420.CheckStatusForMan(obj);
        }

        public static DataSet FetchDataForManDashBoard(Object9420 obj)
        {
            return Data_9420.FetchDataForManDashBoard(obj);
        }

        public static DataSet FetchRequestLabel(Object9420 obj)
        {
            return Data_9420.FetchRequestLabel(obj);
        }
        public static DataSet FetchRequestProductList(Object9420 obj)
        {
            return Data_9420.FetchRequestProductList(obj);
        }
        public static DataSet FetchRequestPro(Object9420 obj)
        {
            return Data_9420.FetchRequestPro(obj);
        }





        #endregion


        #region NewCode


        public static void FillUpDateProfile(Object9420 Reg)
        {
            Data_9420.FillUpDateProfile(Reg);
        }
        public static void FindAvilableCodes(Object9420 Reg)
        {
            Data_9420.FindAvilableCodes(Reg);
        }
        public static DataSet BatchProductDetails(Object9420 obj)
        {
            return Data_9420.BatchProductDetails(obj);
        }
        public static void SaveBatchProductDetails(Object9420 obj)
        {
            Data_9420.SaveBatchProductDetails(obj);
        }
        public static void UpDateBatchProductDetailsInM_Code(Object9420 obj)
        {
            Data_9420.UpDateBatchProductDetailsInM_Code(obj);
        }
        public static void UpDateBatchProductDetailsInM_CodeDemo(Object9420 obj)
        {
            Data_9420.UpDateBatchProductDetailsInM_CodeDemo(obj);
        }
        public static void UpDateBatchProductDetailsInM_CodeNew(Object9420 obj)
        {
            Data_9420.UpDateBatchProductDetailsInM_CodeNew(obj);
        }
        public static string GetRow_ID()
        {
            return Data_9420.GetRow_ID();
        }
        public static void FetchDataUpdateBatchProductDetails(Object9420 obj)
        {
            Data_9420.FetchDataUpdateBatchProductDetails(obj);
        }

        public static void FindOldNoofCodes(Object9420 obj)
        {
            Data_9420.FindOldNoofCodes(obj);
        }
        public static void UpdateBatchProductDetails(Object9420 obj)
        {
            Data_9420.UpdateBatchProductDetails(obj);
        }
        public static void DeleteBatchProductDetailsCodes(Object9420 obj)
        {
            Data_9420.DeleteBatchProductDetailsCodes(obj);
        }
        public static int GetRowForPrintCodes(Object9420 obj)
        {
            return Data_9420.GetRowForPrintCodes(obj);
        }
        public static DataSet SelectProductDetailsNoofCodes(Object9420 obj)
        {
            return Data_9420.SelectProductDetailsNoofCodes(obj);
        }
        public static DataSet SelectProductDetailsNoofCodesChk(Object9420 obj)
        {
            return Data_9420.SelectProductDetailsNoofCodesChk(obj);
        }
        public static DataSet SelectProductDetailsNoofCodesPrint(Object9420 obj)
        {
            return Data_9420.SelectProductDetailsNoofCodesPrint(obj);
        }
        public static DataSet SelectProductDetailsLabelInfo(Object9420 obj)
        {
            return Data_9420.SelectProductDetailsLabelInfo(obj);
        }
        public static DataSet SelectProductDetailsNoofCodesEdit(Object9420 obj)
        {
            return Data_9420.SelectProductDetailsNoofCodesEdit(obj);
        }
        public static DataSet SearchBatchProductDetails(Object9420 obj)
        {
            return Data_9420.SearchBatchProductDetails(obj);
        }
        public static void FindAvilableCodesNew(Object9420 Reg)
        {
            Data_9420.FindAvilableCodesNew(Reg);
        }
        public static bool FetchDataForLogin(Object9420 Reg)
        {
            return Data_9420.FetchDataForLogin(Reg);
        }
        public static string FetchDataForLoginFirst(Object9420 Reg)
        {
            return Data_9420.FetchDataForLoginFirst(Reg);
        }
         public static string FilCodelInfo(string Compid)
        {
            return Data_9420.FilCodelInfo(Compid);
        }
        public static string FilCodelInfoDemo(string Compid)
        {
            return Data_9420.FilCodelInfoDemo(Compid);
        }
         public static string FilCodelInfoUsed(string Compid)
        {
            return Data_9420.FilCodelInfoUsed(Compid);
        }
        public static void DeAllocateBatchProductDetailsInM_Code(Object9420 obj)
        {
            Data_9420.DeAllocateBatchProductDetailsInM_Code(obj);
        }
        public static void InsertDeAllocatedCodes(Object9420 obj)
        {
            Data_9420.InsertDeAllocatedCodes(obj);
        }
        public static void FindSomeInfo(Object9420 obj)
        {
            Data_9420.FindSomeInfo(obj);
        }
        #endregion

        public static string FindAvlDemoCode()
        {
            return Data_9420.FindAvlDemoCode();
        }

        public static void PrintsInM_CodeUpdate(Object9420 Reg)
        {
            Data_9420.PrintsInM_CodeUpdate(Reg);
        }

        public static DataSet FindRowCountPrintDemoCodes(Object9420 Reg)
        {
            return Data_9420.FindRowCountPrintDemoCodes(Reg);
        }

        public static bool CheckPacketNo(Object9420 Reg)
        {
            return Data_9420.CheckPacketNo(Reg);
        }

        public static DataSet FindPrintDemoCodesNoUnique()
        {
            return Data_9420.FindPrintDemoCodesNoUnique();
        }

        public static void InsertMessageLog(Object9420 Reg)
        {
            Data_9420.InsertMessageLog(Reg);
        }

        public static void FindInfo(Object9420 Reg)
        {
            Data_9420.FindInfo(Reg);
        }

        public static void UpdateFileFlag(Object9420 obj)
        {
            Data_9420.UpdateFileFlag(obj);
        }

        public static void UpdateFileFlagProduct(Object9420 obj)
        {
            Data_9420.UpdateFileFlagProduct(obj);
        }

        public static void UpdateFileFlagProDetE(Object9420 obj)
        {
            Data_9420.UpdateFileFlagProDetE(obj);
        }

        public static void UpdateFileFlagProDetH(Object9420 obj)
        {
            Data_9420.UpdateFileFlagProDetH(obj);
        }

        public static void UpdateFunction(Object9420 Reg)
        {
            Data_9420.updatefuunction(Reg);
        }

        public static object MyRegistrationExccel(Object9420 RegExccel)
        {
            return Data_9420.MyRegistrationExccel(RegExccel);
        }

 public static object MyRegistrationExccel_ImageFile(Object9420 RegExccel)
        {
            return Data_9420.MyRegistrationExccel_ImageFile(RegExccel);
        }

        public static object MyVirtualExccel(string ProId, string LabelRequestId)
        {
            return Data_9420.MyVirtualExccel(ProId, LabelRequestId);
        }

        public static string MyRegistrationExccelDemo(Object9420 Reg)
        {
            return Data_9420.MyRegistrationExccelDemo(Reg);
        }

        public static void FindLicenceData(Object9420 Reg)
        {
            Data_9420.FindLicenceData(Reg);
        }
        #region Code For Customization
        public static DataSet CheckDemoPackageCodes(string PackageName)
        {
            return Data_9420.CheckDemoPackageCodes(PackageName);
        }
        public static DataSet CheckDemoPackageCodesRows(string PackageName)
        {
            return Data_9420.CheckDemoPackageCodesRows(PackageName);
        }
        #endregion



        public static DataSet FillddlDemoAll()
        {
            return Data_9420.FillddlDemoAll();
        }

        public static string FindPack(Object9420 Reg)
        {
            return Data_9420.FindPack(Reg);
        }

        public static void InsertAllocatedCodesForDemo(Object9420 Reg)
        {
            Data_9420.InsertAllocatedCodesForDemo(Reg);
        }
        public static DataSet FetchMailDetail(string Qry)
        {
            return Data_9420.FetchMailDetail(Qry);
        }
        public static DataSet FetchMailingDetail(string Qry, string mtype)
        {
            return Data_9420.FetchMailingDetail(Qry, mtype);
        }

        public static DataSet FillDataDemoGrid(string Qry)
        {
            return Data_9420.FillDataDemoGrid(Qry);
        }

        public static DataSet FillDataDemoGridNew(string strAll, string CodePacket)
        {
            return Data_9420.FillDataDemoGridNew(strAll, CodePacket);
        }

        public static string FindQry()
        {
            return Data_9420.FindQry();
        }

        public static bool UpdateEmailFlag(Object9420 Reg)
        {
            return Data_9420.UpdateEmailFlag(Reg);
        }

        public static DataSet FindFillGridDataReports()
        {
            return Data_9420.FindFillGridDataReports();
        }

        public static DataSet FindFillGridDataSearch(string StrAll)
        {
            return Data_9420.FindFillGridDataSearch(StrAll);
        }

        public static int InsertCodeChecked(Object9420 Reg)
        {
            Reg.Enq_Date = Convert.ToDateTime((Reg.Enq_Date).ToString("yyyy/MM/dd HH:mm:ss.fff"));

            if (HttpContext.Current.Session["lat"] != null && HttpContext.Current.Session["long"] != null)
            {
                location loc = new location();
                loc.code1 = Reg.Received_Code1;
                loc.code2 = Reg.Received_Code2;
                loc.latitude = HttpContext.Current.Session["lat"].ToString();
                loc.longitude = HttpContext.Current.Session["long"].ToString();
                loc.EnqDate = Reg.Enq_Date;
                Business9420.function9420.GetLocationFromLongLat(loc);
            }





            StackTrace stackTrace = new StackTrace();
            //DataProvider.LogManager.ErrorExceptionLog(stackTrace.GetFrame(1).GetFileName());
            //DataProvider.LogManager.ErrorExceptionLog(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy-MM-dd hh:mm:ss.fff tt") + "Dial_Mode:" + Reg.Dial_Mode + " Enq_Date:" + Convert.ToDateTime(Reg.Enq_Date).ToString("yyyy/MM/dd HH:mm:ss") +
            //     " Mode_Detail:" + Reg.Mode_Detail + " MobileNo:" + Reg.Mobile_No + " Received_Code1:" + Reg.Received_Code1 + " Received_Code2:" + Reg.Received_Code2 + " Is_Success: " +
            //     Reg.Is_Success + " IsDraw:0 SST_ID:0 City:" + Reg.City + "callercircle: " + Reg.callercircle + "network: " + Reg.network + "callerdate:" + Reg.callerdate + " callertime:" + Reg.callertime + " M_Codeid:" + Reg.M_ConsumerID +
            //     " Proid:" + Reg.Pro_ID + " Compid:" + Reg.Comp_ID+" method: "+ stackTrace.GetFrame(1).GetMethod().Name);
            return Data_9420.InsertCodeChecked(Reg);
        }

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

        public class address_component
        {
            public string long_name { get; set; }
            public string short_name { get; set; }
            public string[] types { get; set; }
        }
        //Added by Bipin fro Wellverse

        public static String GetLocationFromLongLatreturnaddress(location loc)
        {
            try
            {

                string result = "";

                if (loc.latitude != null && loc.latitude != "undefined" && loc.longitude != null && loc.longitude != "undefined")
                {
                    var json = new WebClient().DownloadString("https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=" + loc.latitude + "&longitude=" + loc.longitude + "&localityLanguage=en"); //concatenate URL with the input lat/lng and downloads the requested resource
                    JObject dd = JObject.Parse(json);
                    loc.country = dd["countryName"].ToString();
                    loc.country = loc.country.Replace("\"", string.Empty).Trim();
                    loc.state = dd["principalSubdivision"].ToString();
                    loc.state = loc.state.Replace("\"", string.Empty).Trim();
                    loc.city = dd["city"].ToString();
                    loc.city = loc.city.Replace("\"", string.Empty).Trim();
                    loc.address = dd["locality"].ToString();
                    loc.address = loc.address.Replace("\"", string.Empty).Trim();
                    //ExecuteNonQueryAndDatatable.location_update1(loc);
                    result = loc.country + "~" + loc.state + "~" + loc.city + "~" + loc.address;
                }

                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        //End of Wellverse

        public static String GetLocationFromLongLat(location loc)
        {
            try
            {

                string result = "";

                if (loc.latitude != null && loc.latitude != "undefined" && loc.longitude != null && loc.longitude != "undefined")
                {
                    var json = new WebClient().DownloadString("https://maps.googleapis.com/maps/api/geocode/json?latlng=" + loc.latitude + "," + loc.longitude + "&sensor=false&key=AIzaSyDvCCR3oMI2OtpMVoBAWJ6y8-EhLa7Lu-Y"); //concatenate URL with the input lat/lng and downloads the requested resource
                    GoogleGeoCodeResponse jsonResult = JsonConvert.DeserializeObject<GoogleGeoCodeResponse>(json); //deserializing the result to GoogleGeoCodeResponse

                    string status = jsonResult.status; // get status

                    string geoLocation = String.Empty;

                    if (status == "OK") //check if status is OK
                    {
                        for (int i = 1; i < jsonResult.results[0].address_components.Length; i++) //loop throught the result for addresses
                        {
                            if (jsonResult.results[0].address_components[i].types[0] == "country")
                            {
                                loc.country = jsonResult.results[0].address_components[i].long_name;
                            }
                            else if (jsonResult.results[0].address_components[i].types[0] == "postal_code")
                            {
                                loc.PostalCode = jsonResult.results[0].address_components[i].long_name;
                            }
                            else if (jsonResult.results[0].address_components[i].types[0] == "administrative_area_level_1")
                            {
                                loc.state = jsonResult.results[0].address_components[i].long_name;
                            }
                            else if (jsonResult.results[0].address_components[i].types[0] == "locality")
                            {
                                loc.city = jsonResult.results[0].address_components[i].long_name;
                            }
                        }

                        loc.address = jsonResult.results[0].formatted_address;
                        ExecuteNonQueryAndDatatable.location_update1(loc);
                        result = "Success";
                    }
                    else
                    {
                        result = "Failed";
                    }
                }

                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        public static int appInsertCodeChecked(Object9420 Reg)
        {
            return Data_9420.appInsertCodeChecked(Reg);
        }
        public static void UpdateUse_CountM_Code(Object9420 Reg)
        {
            Data_9420.UpdateUse_CountM_Code(Reg);
        }

        public static DataSet FetchEnquiryData()
        {
            return Data_9420.FetchEnquiryData();
        }

        public static DataSet FindBill()
        {
            return Data_9420.FindBill();
        }
        public static DataSet FindBillParam(String Comp_Ids)
        {
            return Data_9420.FindBillParam(Comp_Ids);
        }
        public static DataSet FindBillNew(Object9420 Reg, string Qry)
        {
            return Data_9420.FindBillNew(Reg, Qry);
        }

        public static void FindGenerateData(Object9420 Reg)
        {
            Data_9420.FindGenerateData(Reg);
        }

        public static void InsertGenerateBills(Object9420 Reg)
        {
            Data_9420.InsertGenerateBills(Reg);
        }

        public static string GetInvoice_No()
        {
            return Data_9420.GetInvoice_No();
        }

        public static void SetInvoice_No()
        {
            Data_9420.SetInvoice_No();
        }

        public static void FindBillData(Object9420 Reg, double Pre_Val)
        {
            Data_9420.FindBillData(Reg, Pre_Val);
        }
        public static void FindBillDataNew(Object9420 Reg, double Pre_Val)
        {
            Data_9420.FindBillDataNew(Reg, Pre_Val);
        }

        public static DataSet FillDataGridPayment(string str)
        {
            return Data_9420.FillDataGridPayment(str);
        }
        public static DataSet FillDataGridPaymentAmc(string str)
        {
            return Data_9420.FillDataGridPaymentAmc(str);
        }
        public static DataSet FillDataGridPaymentRequest(string str, string Comp_ID)
        {
            return Data_9420.FillDataGridPaymentRequest(str, Comp_ID);
        }
        public static void FillDetailsPaymentRequest(Object9420 Reg)
        {
            Data_9420.FillDetailsPaymentRequest(Reg);
        }
        public static string FindAvaAmount(string str, string Pro_ID)
        {
            return Data_9420.FindAvaAmount(str, Pro_ID);
        }
        public static string FindAvaAmount(string str)
        {
            return Data_9420.FindAvaAmount(str);
        }
        public static void InsertReceivedPayment(Object9420 Reg)
        {
            Data_9420.InsertReceivedPayment(Reg);
        }
        public static bool ChangePass(Object9420 Reg)
        {
            return Data_9420.ChangePass(Reg);
        }

        public static void ChangePasswordCompID(Object9420 Reg)
        {
            Data_9420.ChangePasswordCompID(Reg);
        }

        public static bool ChangePassAdmin(Object9420 Reg)
        {
            return Data_9420.ChangePassAdmin(Reg);
        }

        public static void ChangePasswordAdmin(Object9420 Reg)
        {
            Data_9420.ChangePasswordAdmin(Reg);
        }
        public static bool FetchDataForCustonerLogin(Object9420 Log)
        {
            return Data_9420.FetchDataForCustonerLogin(Log);
        }
        public static bool FetchDataForAdminLogin(Object9420 Log)
        {
            return Data_9420.FetchDataForAdminLogin(Log);
        }
        public static string GetTrans_No()
        {
            return Data_9420.GetTrans_No();
        }
        public static void SetTrans_No()
        {
            Data_9420.SetTrans_No();
        }
        public static string GetRequest_No()
        {
            return Data_9420.GetRequest_No();
        }
        public static void SetRequest_No()
        {
            Data_9420.SetRequest_No();
        }
        public static DataSet FillGidProductsPricesList(Object9420 Reg)
        {
            return Data_9420.FillGidProductsPricesList(Reg);
        }

        public static void UpdateProductsPrices(Object9420 Reg)
        {
            Data_9420.UpdateProductsPrices(Reg);
        }

        public static bool FindPro_IDInPriceMaster(Object9420 Reg)
        {
            return Data_9420.FindPro_IDInPriceMaster(Reg);
        }

        public static void InsertProductsPrices(Object9420 Reg)
        {
            Data_9420.InsertProductsPrices(Reg);
        }

        public static bool CheckedPreiceMaster(string p)
        {
            return Data_9420.CheckedPreiceMaster(p);
        }

        public static void InsertCategoryMaster(string p)
        {
            Data_9420.InsertCategoryMaster(p);
        }

        public static Int32 FindMaxCategoryMaster()
        {
            return Data_9420.FindMaxCategoryMaster();
        }

        public static DataSet FindAllocationDataGrid(string p)
        {
            return Data_9420.FindAllocationDataGrid(p);
        }

        public static DataSet FindAllocationDataGridNew(string p)
        {
            return Data_9420.FindAllocationDataGridNew(p);
        }

        public static DataSet FillDataDemoGridDemo(string S)
        {
            return Data_9420.FillDataDemoGridDemo(S);
        }
        public static DataSet FillDataRetailerGrid(string S)
        {
            return Data_9420.FillDataRetailerGrid(S);
        }

        public static object ReturnQuery()
        {
            return Data_9420.ReturnQuery();
        }

        public static DataSet fetchProductCodeDailyCodesUses(Object9420 obj, string Qry)
        {
            return Data_9420.fetchProductCodeDailyCodesUses(obj, Qry);
        }

        public static DataSet FindFillGridGeneratedBills(string StrAll)
        {
            return Data_9420.FindFillGridGeneratedBills(StrAll);
        }

        public static DataSet FetchInvoiceNoWiseDetails(Object9420 obj)
        {
            return Data_9420.FetchInvoiceNoWiseDetails(obj);
        }
        public static DataSet FetchInvoiceNoWiseAmcOfferDetails(Object9420 obj)
        {
            return Data_9420.FetchInvoiceNoWiseAmcOfferDetails(obj);
        }
        public static DataTable FindProducts(Object9420 Reg)
        {
            return Data_9420.FindProducts(Reg);
        }
        public static DataSet FillGidProductsWiseDetails(Object9420 Reg, bool y)
        {
            return Data_9420.FillGidProductsWiseDetails(Reg, y);
        }


        public static void ResetDataAll(int keyval)
        {
            Data_9420.ResetDataAll(keyval);
        }

        public static void ResetCodeBank(Object9420 Reg)
        {
            Data_9420.ResetCodeBank(Reg);
        }
        public static void ResetPrintAll(Object9420 Reg)
        {
            Data_9420.ResetPrintAll(Reg);
        }
        public static void ResetAllInvoice(Object9420 Reg)
        {
            Data_9420.ResetAllInvoice(Reg);
        }
        public static void RemoveCompany(Object9420 Reg)
        {
            Data_9420.RemoveCompany(Reg);
        }

        public static void ResetProducts(Object9420 Reg)
        {
            Data_9420.ResetProducts(Reg);
        }
        public static void ProductReset(Object9420 Reg)
        {
            Data_9420.ProductReset(Reg);
        }
        public static void UploadDocuments(Object9420 Log)
        {
            Data_9420.UploadDocuments(Log);
        }
        /// <summary>
        /// Created By shweta : Combining the 2 seperate qry into single qry
        /// </summary>
        /// <param name="Reg"></param>
        /// <returns></returns>
        public static DataSet FindCompanyDocuments(Object9420 Reg)
        {
            return Data_9420.FindCompanyDocuments(Reg);
        }
        public static DataSet FindDataForDocuments(Object9420 Reg)
        {
            return Data_9420.FindDataForDocuments(Reg);
        }

        public static DataSet FindVerifyData(Object9420 Reg)
        {
            return Data_9420.FindVerifyData(Reg);
        }

        public static void VerifyAll(Object9420 Reg)
        {
            Data_9420.VerifyAll(Reg);
        }

        public static bool CheckedVerifyFlag(Object9420 Reg)
        {
            return Data_9420.CheckedVerifyFlag(Reg);
        }

        public static void UpdateDocFlag(Object9420 Reg)
        {
            Data_9420.UpdateDocFlag(Reg);
        }
        public static void UpdateDocFlagInActive(Object9420 Reg)
        {
            Data_9420.UpdateDocFlagInActive(Reg);
        }
        #region Create Label Function
        public static DataSet FillGridLabel(Object9420 Reg)
        {
            return Data_9420.FillGridLabel(Reg);
        }
        public static DataSet FillGridPlan(Object9420 Reg)
        {
            return Data_9420.FillGridPlan(Reg);
        }
        public static DataSet FillGridPlan(int i)
        {
            return Data_9420.FillGridPlan(i);
        }
        public static string GetCategoryCode(string p)
        {
            return Data_9420.GetCategoryCode(p);
        }
        public static string GetLabelCode(string p)
        {
            return Data_9420.GetLabelCode(p);
        }
        public static void UpdateLabelCode(string p)
        {
            Data_9420.UpdateLabelCode(p);
        }
        #endregion

        #region Category  and Customer Function
        public static DataSet FillGridCategory(Object9420 Reg)
        {
            return Data_9420.FillGridCategory(Reg);
        }
        public static void SaveCategory(Object9420 Reg)
        {
            Data_9420.SaveCategory(Reg);
        }
        public static void UpdateCategoryFlag(Object9420 Reg)
        {
            Data_9420.UpdateCategoryFlag(Reg);
        }

        public static DataSet FillGridCustomer(Object9420 Reg)
        {
            return Data_9420.FillGridCustomer(Reg);
        }
        public static void SaveCustomer(Object9420 Reg)
        {
            Data_9420.SaveCustomer(Reg);
        }
        public static void UpdateCustomerFlag(Object9420 Reg)
        {
            Data_9420.UpdateCustomerFlag(Reg);
        }
        #endregion
        #region Create Label Function
        public static DataSet FillGridAMC(Object9420 Reg)
        {
            return Data_9420.FillGridAMC(Reg);
        }
        public static DataSet FillGridVwDiscount(Object9420 Reg)
        {
            return Data_9420.FillGridVwDiscount(Reg);
        }
        public static DataSet FillGridVwOffer(Object9420 Reg)
        {
            return Data_9420.FillGridVwOffer(Reg);
        }
        #endregion
        public static void SaveOfferPlan(Object9420 Reg)
        {
            Data_9420.SaveOfferPlan(Reg);
        }
        public static void SaveDiscountPlanMaster(Object9420 Reg)
        {
            Data_9420.SaveDiscountPlanMaster(Reg);
        }
        public static void SaveAmcPlan(Object9420 Reg)
        {
            Data_9420.SaveAmcPlan(Reg);
        }
        public static void SaveLabel(Object9420 Reg)
        {
            Data_9420.SaveLabel(Reg);
        }
        public static void SaveUploadLabelPastingReport(Object9420 Reg)
        {
            Data_9420.SaveUploadLabelPastingReport(Reg);
        }
        public static void UpdateLabel(Object9420 Reg)
        {
            Data_9420.UpdateLabel(Reg);
        }
        public static DataSet FillPlanLog(Object9420 Reg)
        {
            return Data_9420.FillPlanLog(Reg);
        }
        public static void FillofferPlanInfo(Object9420 Reg)
        {
            Data_9420.FillofferPlanInfo(Reg);
        }
        public static void FillPlanInfo(Object9420 Reg)
        {
            Data_9420.FillPlanInfo(Reg);
        }
        public static void FillLabelInfo(Object9420 Reg)
        {
            Data_9420.FillLabelInfo(Reg);
        }
        public static DataSet FillLabelInfo(string lblid)
        {
            DataSet ds = Data_9420.FillLabelInfo(lblid);
            return ds;
        }
        public static DataSet FillLabelPriseInfo(Object9420 Reg)
        {
            return Data_9420.FillLabelPriseInfo(Reg);
        }

        public static void UpdateLabelFlag(Object9420 Reg)
        {
            Data_9420.UpdateLabelFlag(Reg);
        }
        public static void UpdateDiscountFlag(Object9420 Reg)
        {
            Data_9420.UpdateDiscountFlag(Reg);
        }
        public static void UpdatePlanFlag(Object9420 Reg)
        {
            Data_9420.UpdatePlanFlag(Reg);
        }
        public static void UpdateOfferPlanFlag(Object9420 Reg)
        {
            Data_9420.UpdateOfferPlanFlag(Reg);
        }

        public static DataSet FillDataGridAccount(string StrAll)
        {
            return Data_9420.FillDataGridAccount(StrAll);
        }

        public static bool ChkDocFlag(Object9420 Reg)
        {
            return Data_9420.ChkDocFlag(Reg);
        }

        public static string GetBankID()
        {
            return Data_9420.GetBankID();
        }

        public static void SetBankID()
        {
            Data_9420.SetBankID();
        }

        public static void BankInfo(Object9420 Reg)
        {
            Data_9420.BankInfo(Reg);
        }
        public static string appBankInfo(Object9420 Reg)
        {
            return Data_9420.appBankInfo(Reg);
        }
        public static void bankfileupload(string bankid, int consumerid, string dml, string chkbook)
        {
            Data_9420.bankfileupload(bankid, consumerid, dml, chkbook);
        }
        public static void GetBankInfo(Object9420 Reg)
        {
            Data_9420.GetBankInfo(Reg);
        }
        public static void GetappBankInfo(bank_responses Reg)
        {
            Data_9420.GetappBankInfo(Reg);
        }
        public static string UpdateActivationFlag(Object9420 Reg)
        {
            return Data_9420.UpdateActivationFlag(Reg);
        }
        public static void SaveCourierMasterDetail(Object9420 Obj)
        {
            Data_9420.SaveCourierMasterDetail(Obj);
        }
        public static string GetCourierID()
        {
            return Data_9420.GetCourierID();
        }
        public static string GetCourierDispatchID()
        {
            return Data_9420.GetCourierDispatchID();
        }
        public static void SetCourierDispatchID()
        {
            Data_9420.SetCourierDispatchID();
        }
        public static void SetCourierID()
        {
            Data_9420.SetCourierID();
        }
        public static string GetTrackingId(string Profx)
        {
            return Data_9420.GetTrackingId(Profx);
        }

        public static string GetTrackingId_New(string Profx)
        {
            return Data_9420.GetTrackingId_New(Profx);
        }

        public static void SetTrackingId(string Profx)
        {
            Data_9420.SetTrackingId(Profx);
        }
        public static void GetCourierInfo(Object9420 Reg)
        {
            Data_9420.GetCourierInfo(Reg);
        }
        public static DataSet FillCourierDataGrid(string Search, string User_ID)
        {
            return Data_9420.FillCourierDataGrid(Search, User_ID);
        }
        public static void DeleteCourierDetail(Object9420 Reg)
        {
            Data_9420.DeleteCourierDetail(Reg);
        }

        public static DataSet FillCompany()
        {
            return Data_9420.FillCompany();
        }
        public static DataSet FillCorierCompany()
        {
            return Data_9420.FillCorierCompany();
        }
        public static DataSet FillCorierCompanyM(string User_ID)
        {
            return Data_9420.FillCorierCompanyM(User_ID);
        }

        public static void CourierDispatchMaster(Object9420 Reg)
        {
            Data_9420.CourierDispatchMaster(Reg);
        }

        public static DataSet FillGrdMainDispatchData(Object9420 Reg)
        {
            return Data_9420.FillGrdMainDispatchData(Reg);
        }
        public static DataSet FillGrdMainLabelDispatchData(Object9420 Reg)
        {
            return Data_9420.FillGrdMainLabelDispatchData(Reg);
        }
        public static DataSet FillGrdMainLabelDispatchDataDashBoard(Object9420 Reg)
        {
            return Data_9420.FillGrdMainLabelDispatchDataDashBoard(Reg);
        }
        public static DataSet FillGrdMainLabelDispatchDataPending(Object9420 Reg)
        {
            return Data_9420.FillGrdMainLabelDispatchDataPending(Reg);
        }
        public static DataSet FillGrdVwPartner(Object9420 Reg)
        {
            return Data_9420.FillGrdVwPartner(Reg);
        }

        public static void GetCourierDispInfo(Object9420 Reg)
        {
            Data_9420.GetCourierDispInfo(Reg);
        }
        public static DataSet GetCourierProDispInfo(Object9420 Reg)
        {
            return Data_9420.GetCourierProDispInfo(Reg);
        }

        public static void DeleteCourierProDispInfo(Object9420 Reg)
        {
            Data_9420.DeleteCourierProDispInfo(Reg);
        }

        public static void DeleteCourierDispInfo(Object9420 Reg)
        {
            Data_9420.DeleteCourierDispInfo(Reg);
        }

        public static bool ChkSeries(Object9420 Reg, string str, int pcount)
        {
            return Data_9420.ChkSeries(Reg, str, pcount);
        }
        public static bool ChkSeries(Object9420 Reg, string str, int pcount, int kcout)
        {
            return Data_9420.ChkSeries(Reg, str, pcount, kcout);
        }
        public static bool PrintChkSeries(Object9420 Reg, string str, int pcount)
        {
            return Data_9420.PrintChkSeries(Reg, str, pcount);
        }
        public static bool PrintChkSeries(Object9420 Reg, string str, int pcount, int kcout)
        {
            return Data_9420.PrintChkSeries(Reg, str, pcount, kcout);
        }
        public static void UpdateDispFlag(Object9420 Reg, string str, int pcount)
        {
            Data_9420.UpdateDispFlag(Reg, str, pcount);
        }

        public static DataSet GetCourierDispLabelInfoID(Object9420 Reg)
        {
            return Data_9420.GetCourierDispLabelInfoID(Reg);
        }

        public static DataSet ChkSeriesForupdate(Object9420 Reg, string str, int pcount)
        {
            return Data_9420.ChkSeriesForupdate(Reg, str, pcount);
        }
        public static DataSet ChkSeriesForupdateM_Code(Object9420 Reg, string str, int pcount)
        {
            return Data_9420.ChkSeriesForupdateM_Code(Reg, str, pcount);
        }
        public static bool UpdateM_Code(string p)
        {
            return Data_9420.UpdateM_Code(p);
        }

        public static void GetLabelInfo(Object9420 Reg)
        {
            Data_9420.GetLabelInfo(Reg);
        }

        public static void LabelReceipt(Object9420 Reg)
        {
            Data_9420.LabelReceipt(Reg);
        }
        public static bool LabelReceiptCheckedFlag(Object9420 Reg)
        {
            return Data_9420.LabelReceiptCheckedFlag(Reg);
        }

        public static DataSet GetReason(object p)
        {
            return Data_9420.GetReason(p);
        }

        public static void UpdateMCodeScrapAdmin(string p)
        {
            Data_9420.UpdateMCodeScrapAdmin(p);
        }

        public static bool ChkSeriesScrap(Object9420 Reg, string str, int pcount)
        {
            return Data_9420.ChkSeriesScrap(Reg, str, pcount);
        }
        public static bool ChkSeriesScrapM(Object9420 Reg, string str, int pcount)
        {
            return Data_9420.ChkSeriesScrapM(Reg, str, pcount);
        }

        public static DataSet FillScrapGrd(Object9420 Reg)
        {
            return Data_9420.FillScrapGrd(Reg);
        }
        public static DataSet FillScrapGrd1(Object9420 Reg)
        {
            return Data_9420.FillScrapGrd1(Reg);
        }

        public static DataSet FillLabel()
        {
            return Data_9420.FillLabel();
        }

        public static void InsertPrintRequestLabels(Object9420 Reg)
        {
            Data_9420.InsertPrintRequestLabels(Reg);
        }

        public static void UpdateLabelCode(Object9420 Reg)
        {
            Data_9420.UpdateLabelCode(Reg);
        }

        public static void GetCompanyForProID(Object9420 Reg)
        {
            Data_9420.GetCompanyForProID(Reg);
        }

        public static DataSet FillGrdLabelsRequested(Object9420 Reg)
        {
            return Data_9420.FillGrdLabelsRequested(Reg);
        }

        public static void CancelLabelsRequest(Object9420 Reg)
        {
            Data_9420.CancelLabelsRequest(Reg);
        }

        public static DataSet FillLabelPastingSheet(Object9420 Reg)
        {
            return Data_9420.FillLabelPastingSheet(Reg);
        }

        public static DataSet FillLoginSummary(Object9420 obj)
        {
            return Data_9420.FillLoginSummary(obj);
        }

        public static void InsertAmcOfferPlan(Object9420 obj)
        {
            Data_9420.InsertAmcOfferPlan(obj);
        }

        public static DataSet FillGrdProDoc(Object9420 Reg)
        {
            return Data_9420.FillGrdProDoc(Reg);
        }
        public static DataSet FillGrdProDocMan(Object9420 Reg)
        {
            return Data_9420.FillGrdProDocMan(Reg);
        }
        public static bool chkVerifyDoc(Object9420 Reg)
        {
            return Data_9420.chkVerifyDoc(Reg);
        }

        public static void FillDetailForReqPay(Object9420 Reg)
        {
            throw new NotImplementedException();
        }

        public static bool GetAmcPlan(Object9420 obj)
        {
            return Data_9420.GetAmcPlan(obj);
        }
        public static bool chkSendRequest(Object9420 obj)
        {
            return Data_9420.chkSendRequest(obj);
        }

        public static bool chkPrintCode(Object9420 obj)
        {
            return Data_9420.chkPrintCode(obj);
        }

        public static bool chkDetails(Object9420 obj)
        {
            return Data_9420.chkDetails(obj);
        }

        public static void FillSecreteCode(Object9420 Reg)
        {
            Data_9420.FillSecreteCode(Reg);
        }

        public static void FillProductDetailDemo(Object9420 Reg)
        {
            Data_9420.FillProductDetailDemo(Reg);
        }

        public static DataSet ChkUploadDocFlag(Object9420 Reg)
        {
            return Data_9420.ChkUploadDocFlag(Reg);
        }

        public static void FindFile(Object9420 Log)
        {
            Data_9420.FindFile(Log);
        }

        public static bool FindVerifyFile(Object9420 Log)
        {
            return Data_9420.FindVerifyFile(Log);
        }
        public static void UpdateSoundFlagProduct(Object9420 obj)
        {
            Data_9420.UpdateSoundFlagProduct(obj);
        }

public static void UpdateDocFlagProduct_Pfl(Object9420 obj)
        {
            Data_9420.UpdateDocFlagProduct_Pfl(obj);
        }

        public static void UpdateDocFlagProduct(Object9420 obj)
        {
            Data_9420.UpdateDocFlagProduct(obj);
        }
        public static DataSet FillActiveCompForTax()
        {
            return Data_9420.FillActiveCompForTax();
        }
        public static DataSet FillActiveComp()
        {
            return Data_9420.FillActiveComp();
        }
        public static DataSet FillAllComp()
        {
            return Data_9420.FillAllComp();
        }

        public static string GetRequestLabelCode(string p)
        {
            return Data_9420.GetRequestLabelCode(p);
        }

        public static DataSet FillScrapEntryCourier(Object9420 obj)
        {
            return Data_9420.FillScrapEntryCourier(obj);
        }

        public static void FindAMCInfo(Object9420 OAMC)
        {
            Data_9420.FindAMCInfo(OAMC);
        }

        //public static double FindAmcAmount(string p)
        //{
        //    return Data_9420.FindAmcAmount(p);
        //}
        public static DataSet FilldllProAmcOffer(Object9420 Reg)
        {
            return Data_9420.FilldllProAmcOffer(Reg);
        }
        public static DataSet FillProductAmcOffer(Object9420 Reg)
        {
            return Data_9420.FillProductAmcOffer(Reg);
        }
        public static DataSet FillProductAmcAmount(Object9420 Reg)
        {
            return Data_9420.FillProductAmcAmount(Reg);
        }
        public static void SaveRequestTransaction(Object9420 Reg)
        {
            Data_9420.SaveRequestTransaction(Reg);
        }
        public static void SaveTransaction(Object9420 Reg)
        {
            Data_9420.SaveTransaction(Reg);
        }
        public static void VerifyRequestTransaction(Object9420 Reg)
        {
            Data_9420.VerifyRequestTransaction(Reg);
        }

        public static void FillData(Object9420 Amc)
        {
            Data_9420.FillData(Amc);
        }

        public static DataSet FillTransDetailsData(Object9420 obj)
        {
            return Data_9420.FillTransDetailsData(obj);
        }

        public static void ReceivedPaymentRequest(Object9420 Reg)
        {
            Data_9420.ReceivedPaymentRequest(Reg);
        }

        public static void UpgradeAcc(Object9420 Reg)
        {
            Data_9420.UpgradeAcc(Reg);
        }

        public static DataSet FindStateID(Object9420 Reg)
        {
            return Data_9420.FindStateID(Reg);
        }

        public static int GetUploadDocStatus(Object9420 Log)
        {
            return Data_9420.GetUploadDocStatus(Log);
        }
        public static int VerifyDocStatus(Object9420 Log)
        {
            return Data_9420.VerifyDocStatus(Log);
        }
        public static void UpdateDocForVerification(Object9420 Log)
        {
            Data_9420.UpdateDocForVerification(Log);
        }

        public static string FindUpdateCode(Object9420 Reg)
        {
            return "UPDATE [M_Code] SET [Allot_Date] = '" + Reg.Entry_Date.ToString("yyyy/MM/dd hh:mm:ss tt") + "',[Pro_ID] = '" + Reg.Pro_ID + "',[Print_Status] = 0  WHERE [Code1] = " + Reg.Code1 + " and [Code2] = " + Reg.Code2 + ";";
        }
        public static DataSet FillProddlSearch(Object9420 Reg)
        {
            return Data_9420.FillProddlSearch(Reg);
        }
        public static DataSet FillProddlDetails(Object9420 Reg)
        {
            return Data_9420.FillProddlDetails(Reg);
        }
        public static DataSet FillBatchddlDetails(Object9420 Reg)
        {
            return Data_9420.FillBatchddlDetails(Reg);
        }
        public static DataSet FillSeriesDetails(Object9420 Reg)
        {
            return Data_9420.FillSeriesDetails(Reg);
        }
        public static DataSet GrdVwEnquiryDetails(Object9420 Reg)
        {
            return Data_9420.GrdVwEnquiryDetails(Reg);
        }
        public static DataSet FillFridForEnqDetails(Object9420 Reg)
        {
            return Data_9420.FillFridForEnqDetails(Reg);
        }
        public static DataSet FillFridForEnqDetails_Warranty(Object9420 Reg)
        {
            return Data_9420.FillFridForEnqDetails_Warranty(Reg);
        }
        public static DataSet FillFridForEnqDetails_Warranty_download(Object9420 Reg)
        {
            return Data_9420.FillFridForEnqDetails_Warranty_download(Reg);
        }

        public static DataSet FillGridForPrintedLabels(Object9420 Reg)
        {
            return Data_9420.FillGridForPrintedLabels(Reg);
        }


	public static DataSet FillGridDetails_PFL(Object9420 Reg)
        {
            return Data_9420.FillGridDetails_PFL(Reg);
        }
        public static DataSet FillGridDetails(Object9420 Reg)
        {
            return Data_9420.FillGridDetails(Reg);
        }

        public static DataSet FillddlProForPrint(Object9420 Reg)
        {
            return Data_9420.FillddlProForPrint(Reg);
        }

        public static DataSet FillFridForAmcBills(Object9420 Reg)
        {
            return Data_9420.FillFridForAmcBills(Reg);
        }

        public static DataSet FillPromotional(int i)
        {
            return Data_9420.FillPromotional(i);
        }

        public static void FindPromoInfo(Object9420 Promoobj)
        {
            Data_9420.FindPromoInfo(Promoobj);
        }
        public static void Generate_Invoice(Object9420 Reg)
        {
            Data_9420.Generate_Invoice(Reg);
        }
        public static void Generate_InvoiceAmcOffer(Object9420 Reg)
        {
            Data_9420.Generate_InvoiceAmcOffer(Reg);
        }
        public static void Generate_InvoiceLabel(Object9420 Reg)
        {
            Data_9420.Generate_InvoiceLabel(Reg);
        }
        public static void InsertTransaction(Object9420 Reg)
        {
            Data_9420.InsertTransaction(Reg);
        }

        public static DataSet FindDetailsForRequestPayment(Object9420 Reg)
        {
            return Data_9420.FindDetailsForRequestPayment(Reg);
        }

        public static DataSet FillAmcOfferDetails(Object9420 Reg)
        {
            return Data_9420.FillAmcOfferDetails(Reg);
        }
        public static DataSet FillPaymentsDetails(Object9420 Reg)
        {
            return Data_9420.FillPaymentsDetails(Reg);
        }

        public static void UpdateAmcOfferPayment(Object9420 Reg)
        {
            Data_9420.UpdateAmcOfferPayment(Reg);
        }

        public static void UpdateReceivedPayment(Object9420 Reg)
        {
            Data_9420.UpdateReceivedPayment(Reg);
        }

        public static void CanceledRequest(Object9420 Reg)
        {
            Data_9420.CanceledRequest(Reg);
        }
        public static void CanceledPaymentRequest(Object9420 Reg)
        {
            Data_9420.CanceledPaymentRequest(Reg);
        }

        public static DataSet FillGenBillData(Object9420 Reg)
        {
            return Data_9420.FillGenBillData(Reg);
        }

        public static DataSet Fill_Payment_Status(Object9420 obj)
        {
            return Data_9420.Fill_Payment_Status(obj);
        }

        public static string FindRowID()
        {
            return Data_9420.FindRowID();
        }

        public static DataSet FillLabelPaymentDetails(Object9420 Reg)
        {
            return Data_9420.FillLabelPaymentDetails(Reg);
        }

        public static bool CheckOffer(Object9420 Reg)
        {
            return Data_9420.CheckOffer(Reg);
        }
        public static bool CheckDateFromDiscount(Object9420 Amc)
        {
            return Data_9420.CheckDateFromDiscount(Amc);
        }
        public static bool CheckDateToDiscount(Object9420 Amc)
        {
            return Data_9420.CheckDateToDiscount(Amc);
        }
        public static bool CheckDateFrom(Object9420 Amc)
        {
            return Data_9420.CheckDateFrom(Amc);
        }
        public static bool CheckDateTo(Object9420 Amc)
        {
            return Data_9420.CheckDateTo(Amc);
        }

        public static void UpdateProductComments(Object9420 Amc)
        {
            Data_9420.UpdateProductComments(Amc);
        }
        public static void UpdateProductCommentsH(Object9420 Amc)
        {
            Data_9420.UpdateProductCommentsH(Amc);
        }
        public static void UpdateProductCommentsE(Object9420 Amc)
        {
            Data_9420.UpdateProductCommentsE(Amc);
        }

        public static void SetPrefixAndStart()
        {
            Data_9420.SetPrefixAndStart();
        }

        public static DataSet FillofferInfo(Object9420 Reg)
        {
            return Data_9420.FillofferInfo(Reg);
        }

        public static DataSet FillPlan(Object9420 Reg)
        {
            return Data_9420.FillPlan(Reg);
        }

        public static void FillDiscountInfo(Object9420 Reg)
        {
            Data_9420.FillDiscountInfo(Reg);
        }

        public static string GetPartnerId(string p)
        {
            return Data_9420.GetPartnerId(p);
        }
        public static void setPartnerId(string p)
        {
            Data_9420.SetPartnerId(p);
        }

        public static void InsertSendQuery(Object9420 obj)
        {
            Data_9420.InsertSendQuery(obj);
        }

        public static void SaveLetUsTalk(Object9420 obj)
        {
            Data_9420.SaveLetUsTalk(obj);
        }
        public static DataSet GetNewsLettersEmailSearch(Object9420 Reg)
        {
            return Data_9420.GetNewsLettersEmailSearch(Reg);
        }
        public static DataSet GetLetsTalkSearch(Object9420 Reg)
        {
            return Data_9420.GetLetsTalkSearch(Reg);
        }
        public static DataSet GetNewsLettersEmail(Object9420 Reg)
        {
            return Data_9420.GetNewsLettersEmail(Reg);
        }
        public static DataSet GetNewsLettersEmails(Object9420 Reg)
        {
            return Data_9420.GetNewsLettersEmails(Reg);
        }

        public static void InsertNewsLetterSubscription(Object9420 Reg)
        {
            Data_9420.InsertNewsLetterSubscription(Reg);
        }

        public static DataSet GetNewsLetters(Object9420 Reg)
        {
            return Data_9420.GetNewsLetters(Reg);
        }

        public static void SaveNewsLetters(Object9420 Reg)
        {
            Data_9420.SaveNewsLetters(Reg);
        }

        public static DataSet FillGrdVwNewsLetterDet(Object9420 Reg, string StrAll)
        {
            return Data_9420.FillGrdVwNewsLetterDet(Reg, StrAll);
        }

        public static bool FindCheckedStatus(Object9420 Reg)
        {
            return Data_9420.FindCheckedStatus(Reg);
        }


        public static void FindAmcOfferId(Object9420 obj)
        {
            Data_9420.FindAmcOfferId(obj);
        }

        public static DataSet FillAmcOfferInvoiceDetails(String Reg)
        {
            return Data_9420.FillAmcOfferInvoiceDetails(Reg);
        }

        public static void MasterPasteLabels(Object9420 obj)
        {
            Data_9420.MasterPasteLabels(obj);
        }

        public static void TaxMasterSetting(Object9420 Reg)
        {
            Data_9420.TaxMasterSetting(Reg);
        }

        public static DataSet FillGridVwTaxMaster(Object9420 Reg)
        {
            return Data_9420.FillGridVwTaxMaster(Reg);
        }

        public static void FillScrapInfo(Object9420 Reg)
        {
            Data_9420.FillScrapInfo(Reg);
        }

        public static bool CheckForGenerateInvoice(string p)
        {
            return Data_9420.CheckForGenerateInvoice(p);
        }
        public static void CreateInvoices(Object9420 Inv)
        {
            Data_9420.CreateInvoices(Inv);
        }
        public static void CreateInvoice(Object9420 Inv)
        {
            Data_9420.CreateInvoice(Inv);
        }
        public static void CreateRefundInvoice(Object9420 Inv)
        {
            Data_9420.CreateRefundInvoice(Inv);
        }
        public static DataSet FindAmcOfferInfo(Object9420 Reg)
        {
            return Data_9420.FindAmcOfferInfo(Reg);
        }


        public static DataSet FindFillGrdVwInvoicess(string StrAll)
        {
            return Data_9420.FindFillGrdVwInvoicess(StrAll);
        }

        public static void CreateLabelInvoice(Object9420 Reg)
        {
            Data_9420.CreateLabelInvoice(Reg);
        }


        public static DataSet GetCurrentLabelInfo(Object9420 Reg)
        {
            return Data_9420.GetCurrentLabelInfo(Reg);
        }

        public static string GetPlanTime(Object9420 Amc)
        {
            return Data_9420.GetPlanTime(Amc);
        }

        public static DataTable GetBeyondOffer(Object9420 Amc)
        {
            return Data_9420.GetBeyondOffer(Amc);
        }

        public static void CancelledAmcOfferPlan(Object9420 Reg)
        {
            Data_9420.CancelledAmcOfferPlan(Reg);
        }

        public static void InsertTestimonialData(Object9420 Reg)
        {
            Data_9420.InsertTestimonialData(Reg);
        }
        //added by Bipin for Wellverse

        public static void Insertfakedata(insertfakedata Reg)
        {
            Data_9420.Insertfakedata(Reg);
        }

        //End of Wellverse

        public static DataSet FillTestimonial(Object9420 Reg)
        {
            return Data_9420.FillTestimonial(Reg);
        }

        public static void UpdateTestimonial(Object9420 Reg)
        {
            Data_9420.UpdateTestimonial(Reg);
        }

        public static void InterestedAsDemo(Object9420 obj)
        {
            Data_9420.InterestedAsDemo(obj);
        }

        public static DataSet FillPrintLbl(Object9420 obj)
        {
            return Data_9420.FillPrintLbl(obj);
        }

        public static DataSet DispatchLabelsStatus(Object9420 obj)
        {
            return Data_9420.DispatchLabelsStatus(obj);
        }
        public static DataSet FetchProduct(Object9420 Reg)
        {
            return Data_9420.FetchProduct(Reg);
        }

        public static DataSet FillInterestedForDemo(Object9420 Reg)
        {
            return Data_9420.FillInterestedForDemo(Reg);
        }

        public static void UpdBatchProductDetails(Object9420 obj)
        {
            Data_9420.UpdBatchProductDetails(obj);
        }
        public static DataSet FindServiceInfo(Object9420 Inv)
        {
            return Data_9420.FindServiceInfo(Inv);
        }

        public static Int32 GetNoOfCodes(string p)
        {
            return Data_9420.GetNoOfCodes(p);
        }

        public static DataTable GetMessageTemplete(Object9420 Reg)
        {
            return Data_9420.GetMessageTemplete(Reg);
        }
        public static DataTable GetAllServices(Object9420 Reg)
        {
            return Data_9420.GetAllServices(Reg);
        }

        public static void GetCompanyInfo(Object9420 Reg)
        {
            Data_9420.GetCompanyInfo(Reg);
        }

        public static void PrintCodes()
        {
            Data_9420.PrintCodes();
        }
    }
    public class AllotedCoupons
    {
        public Int64 CouponTrans_ID { get; set; }
    }
    public class Gifts
    {
        public Int64 CouponRequest_ID { get; set; }
        public Int64 AdditionalGift_ID { get; set; }
        public string Gift_ID { get; set; }
        public string GiftName { get; set; }
        public Int64 GiftCount { get; set; }
        public Int64 DistributeGiftCount { get; set; }
        public string SpendTotalCount { get; set; }
        public string IsCoupon { get; set; }
    }
    public class SMSGifts
    {
        public Int64 Trans_Id { get; set; }
        public string MobileNo { get; set; }
        public string GiftName { get; set; }
    }
    public class CouponProver
    {
        public Int64 CouponProvider_Id { get; set; }
        public string CouponProviderName { get; set; }
        public string CouponProviderEmail { get; set; }
        public string CouponProviderContactPerson { get; set; }
        public string CouponProviderContactNo { get; set; }
        public int IsActive { get; set; }
        public int IsDelete { get; set; }
        public int IsAdminVerify { get; set; }
        public DateTime EntryDate { get; set; }
        public string DML { get; set; }
        public string Coupon_ID { get; set; }
        public string CouponName { get; set; }
        public string Gift_ID { get; set; }
        public string Question_Id { get; set; }
        public string GiftName { get; set; }

        public string QuestionName { get; set; }
        public string Comp_ID { get; set; }
        public string CouponRequest_ID { get; set; }
        public string DateFrom { get; set; }
        public string DateTo { get; set; }
        public Int64 CouponCount { get; set; }

        #region Coupon Provider Master

        #region Coupon Provider Master
        public static DataTable CPMFillDataGrid(CouponProver Reg)
        {
            return CouponProverObj.CPMFillDataGrid(Reg);
        }
        public static void CPMInsertUpdate(CouponProver Reg)
        {
            CouponProverObj.CPMInsertUpdate(Reg);
        }
        public static void CPMActivateDelete(CouponProver Reg)
        {
            CouponProverObj.CPMActivateDelete(Reg);
        }
        #endregion

        #region Coupon Master
        public static DataTable CMFillDataGrid(CouponProver Reg)
        {
            return CouponProverObj.CMFillDataGrid(Reg);
        }
        public static void CMInsertUpdate(CouponProver Reg)
        {
            CouponProverObj.CMInsertUpdate(Reg);
        }
        public static void CMActivateDelete(CouponProver Reg)
        {
            CouponProverObj.CMActivateDelete(Reg);
        }
        #endregion

        #region Gift Master
        public static DataTable GiftFillDataGrid(CouponProver Reg)
        {
            return CouponProverObj.GiftFillDataGrid(Reg);
        }
        public static void GiftInsertUpdate(CouponProver Reg)
        {
            CouponProverObj.GiftInsertUpdate(Reg);
        }
        public static void GiftActivateDelete(CouponProver Reg)
        {
            CouponProverObj.GiftActivateDelete(Reg);
        }

        public static DataTable QuestionFillDataGrid(CouponProver Reg)
        {
            return CouponProverObj.QuestionFillDataGrid(Reg);
        }
        public static void QuestionInsertUpdate(CouponProver Reg)
        {
            CouponProverObj.QuestionInsertUpdate(Reg);
        }
        public static void QuestionActivateDelete(CouponProver Reg)
        {
            CouponProverObj.QuestionActivateDelete(Reg);
        }
        #endregion

        #region Coupon Request Master
        public static DataTable CRFillDataGrid(CouponProver Reg)
        {
            return CouponProverObj.CRFillDataGrid(Reg);
        }
        public static void CRInsertUpdate(CouponProver Reg)
        {
            CouponProverObj.CRInsertUpdate(Reg);
        }
        public static void CRActivateDelete(CouponProver Reg)
        {
            CouponProverObj.CRActivateDelete(Reg);
        }
        #endregion

        #endregion
    }
}