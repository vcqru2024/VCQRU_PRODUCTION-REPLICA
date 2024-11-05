using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Net;
using System.Data.SqlClient;

public partial class Manufacturer_VendorMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] != null)
        {
            Auth.Oncheck();
            if (Session["User_Type"].ToString() == "Admin")
                lblloginName.Text = "Admin";

            else
            {
                if (Session["User_Type"].ToString() != "Customer Care")
                    lblloginName.Text = SQL_DB.ExecuteScalar("SELECT [Comp_Name] FROM [Comp_Reg] where [Comp_ID] = '" + Session["CompanyId"].ToString() + "'").ToString();
                else
                    lblloginName.Text = Session["User_Type"].ToString();
            }

            if (Session["CompanyId"] == null)
                Response.Redirect("~/login.aspx");

            if (Session["CompanyId"] != null)
            {
                DataTable dtcomplogo = SQL_DB.ExecuteDataTable("exec USP_GetCompLogoPath '" + Session["CompanyId"].ToString() + "'");
                if (dtcomplogo.Rows.Count > 0)
                {
                    string baseUrl = "https://www.vcqru.com/";
                    string imagePath = dtcomplogo.Rows[0][0].ToString();
                    Uri baseUrlUri = new Uri(baseUrl);
                    Uri imagePathUri = new Uri(baseUrlUri, imagePath);
                    string absoluteUrl = imagePathUri.AbsoluteUri;
                    string cleanedUrl = absoluteUrl.Replace("~/", "");
                    headlogo.Src = cleanedUrl;
                }
            }


            if (Session["CompanyId"].ToString() == "Comp-1722")  //Tesla
            {
                Session["BackgroundColor"] = "linear-gradient(180deg, rgb(241 35 28) 0%, rgb(0 0 0) 100%)";
                Session["card-header"] = "card-headerhpl";
                Session["btn-primary"] = "btn-primaryhpl";
                Session["hplindia"] = "hplindia";
                Session["hplindia"] = "hplindia";
                teslakyc.Visible = true;
                consumerwallet.Visible = true;
                consumerneft.Visible = true;
                ScanDetails.Visible = true;
                warrantydetails.Visible = false;
                lablebill.Visible = false;
                luckywinner.Visible = false;
                runsurveydetails.Visible = false;
                pointadjust.Visible = false;
                transfercash.Visible = false;
                cashdetails.Visible = false;
                awarddetails.Visible = false;
                codeanalytical.Visible = false;
                tdsuser.Visible = false;
                PointTransactionReport.Visible = false;
                BankTransferrpt.Visible = false;
                PointsDetails.Visible = false;
                cashdetailsrpt.Visible = false;
                UserDataReport.Visible = false;
                RefferalRPT.Visible = false;
                TransactionReport.Visible = false;
                liAuto.Visible = false;
                BannerVcqru.Visible = false;
                lihafila.Visible = false;
                CodeWisePayoutReport.Visible = false;
                Li2.Visible = false;
                Li3.Visible = false;
                frmusernotification.Visible = false;
                litransactionsetting.Visible = false;
                WarrantyReportVendor.Visible = false;
                loyaltyclmreport.Visible = false;
                frmgiftDispatch.Visible = false;
            }
            if (Session["CompanyId"].ToString() == "Comp-1727")
            {
                pointChartReport.Visible = true;
                BrocherRep.Visible = true;
                sendnotificationtousers.Visible = true;
                BusinessEnquiry.Visible = true;
                financialYearReport.Visible = true;
            }
            if (Session["CompanyId"].ToString() == "Comp-1466")
            { //financial year report

                financialYearReport.Visible = true;
            }


            if (Session["CompanyId"].ToString() == "Comp-1713" || Session["CompanyId"].ToString() == "Comp-1718" || Session["CompanyId"].ToString() == "Comp-1717" || Session["CompanyId"].ToString() == "Comp-1626" || Session["CompanyId"].ToString() == "Comp-1336" || Session["CompanyId"].ToString() == "Comp-1337" || Session["CompanyId"].ToString() == "Comp-1366" || Session["CompanyId"].ToString() == "Comp-1383" || Session["CompanyId"].ToString() == "Comp-1388" || Session["CompanyId"].ToString() == "Comp-1312" || Session["CompanyId"].ToString() == "Comp-1439" || Session["CompanyId"].ToString() == "Comp-1451" || Session["CompanyId"].ToString() == "Comp-1466" || Session["CompanyId"].ToString() == "Comp-1483" || Session["CompanyId"].ToString() == "Comp-1499" || Session["CompanyId"].ToString() == "Comp-1496" || Session["CompanyId"].ToString() == "Comp-1714" || Session["CompanyId"].ToString() == "Comp-1728" || Session["CompanyId"].ToString() == "Comp-1722" || Session["CompanyId"].ToString() == "Comp-1599" || Session["CompanyId"].ToString() == "Comp-1733")
            {
                divNot.Visible = true;
                totalnot.Text = SQL_DB.ExecuteScalar("exec Pro_notification '" + Session["CompanyId"].ToString() + "'").ToString();
            }

            #region // Gupta edutech Delhi
            if (Session["CompanyId"].ToString() == "Comp-1594")
            {
                blackbookuser.Visible = true;
            }
            #endregion

            #region // BASEX ADHESIVE INDIA PVT LTD
            if (Session["CompanyId"].ToString() == "Comp-1598")
            {
                Licatalog.Visible = true;
            }
            #endregion
            #region // Vr Kable notification menu
            if (Session["CompanyId"].ToString() == "Comp-1400")
            {
                frmusernotification.Visible = true;
            }
            #endregion

            #region //** Lubigen loyalti report
            if (Session["CompanyId"].ToString() == "Comp-1709")
            {

                loyaltyclmpaymentreport.Visible = false;
                WarrantyReportVendor.Visible = false;
            }
            #endregion

            #region //Yamuna
            if (Session["CompanyId"].ToString() == "Comp-1714" || Session["CompanyId"].ToString() == "Comp-1728")
            {
                trackingrptyamuna.Visible = true;
            }
            #endregion

            #region //Shree Durga Traders
            if (Session["CompanyId"].ToString() == "Comp-1609")
            {
                lidurga.Visible = true;
            }
            #endregion

            if (Session["CompanyId"].ToString() == "Comp-1629")
            {
                limappingdevice.Visible = true;
            }
            if (Session["CompanyId"].ToString() == "Comp-1707")
            {
                manualPayout_cashTransfer.Visible = true;
            }
            if (Session["CompanyId"].ToString() == "Comp-1690")
            {
                CashWalletReport.Visible = true;
                CashTransferReport.Visible = true;
            }

            if (Session["CompanyId"].ToString() == "Comp-1595")
            {
                UserDataReport.Visible = false;
                userdata.Visible = false;
                TransactionReport.Visible = false;
                GraphicalReport.Visible = false;
                liAuto.Visible = false;
                lihafila.Visible = false;
                BannerVcqru.Visible = false;
                vrkbl.Visible = false;

                PointTransactionReport.Visible = false;
                PointsDetails.Visible = false;
            }


            if (Session["CompanyId"].ToString() == "Comp-1438")
            {
                blackbookuser.Visible = true;
            }
            if (Session["CompanyId"].ToString() == "Comp-1548" || Session["CompanyId"].ToString() == "Comp-1702" || Session["CompanyId"].ToString() == "Comp-1709")
            {
                UPIPaymentDetails.Visible = true;
            }

            if (Session["CompanyId"].ToString() == "Comp-1386")
            {
                userdata.Visible = false;
            }

            if (Session["CompanyId"].ToString() == "Comp-1541")
            {
                //feedback.Visible = true;
                //packplususer.Visible = true;
                IHFFContactEnquiry.Visible = true;
            }

            if (Session["CompanyId"].ToString() == "Comp-1046")
            {

                kycAadharReport.Visible = true;
                kycPancardReport.Visible = true;
                kycBankVeryfyReport.Visible = true;
                completekycVeryfyReport.Visible = true;
            }

            if (Session["CompanyId"].ToString() == "Comp-1599")
            {

                lirporteddatawellverse.Visible = true;
            }

            if (Session["CompanyId"].ToString() == "Comp-1248")
            {

                lireports.Visible = false;
                limanageprofile.Visible = false;
                liproductparticular.Visible = false;
                liourservice.Visible = false;
                litransactionsetting.Visible = false;
                lilablesection.Visible = false;
                liscrapparticuler.Visible = false;
                liclaimreport.Visible = false;
                liemployeemaster.Visible = false;

            }
            else
            {
                #region
                //** For paytm payment process for RUHE **//
                if (Session["CompanyId"].ToString() == "Comp-1321")
                {

                    liRuhe.Visible = true;

                }
                #endregion
                // For Auto Cash transfer
                if (Session["CompanyId"].ToString() == "Comp-1499" || Session["CompanyId"].ToString() == "Comp-1496")
                {

                    liAuto.Visible = true;

                }
                // For Auto Cash transfer

                if (Session["CompanyId"].ToString() == "Comp-1466")
                {
                    pointdtl.Visible = true;
                }
                if (Session["CompanyId"].ToString() == "Comp-1738")
                {
                    consumerpayoutreport.Visible = true;
                }
                if (Session["CompanyId"].ToString() == "Comp-1538")
                {
                    frmoltimo.Visible = true;
                }

                if (Session["CompanyId"].ToString() == "Comp-1152")
                {
                    retailrmm.Visible = true;


                }



                if (Session["CompanyId"].ToString() == "Comp-1274")
                {

                    liJohn.Visible = true;
                    FYReport.Visible = true;

                }

                #region //** Akemi Technologies loyalti report
                if (Session["CompanyId"].ToString() == "Comp-1567" || Session["CompanyId"].ToString() == "Comp-1650")
                {

                    nonkycuser.Visible = true;
                    loyaltyclmreport.Visible = false;
                    PointTransactionReport.Visible = false;
                    loyaltyclmBankpaymentreport.Visible = true;

                }
                #endregion
                if (Session["CompanyId"].ToString() == "Comp-1659" || Session["CompanyId"].ToString() == "Comp-1674")
                {
                    loyaltyclmreport.Visible = false;
                    loyaltyclmBankpaymentreport.Visible = true;
                }

                if (Session["CompanyId"].ToString() == "Comp-1400")
                {
                    vrkbl.Visible = true;
                    vrUserWiseCodeCheck.Visible = true;
                    vrProductWiseCodeCheck.Visible = true;
                    vrUserRegistration.Visible = true;
                    vrkblGifts.Visible = true;
                    copperLi.Visible = true;
                    notific.Visible = true;
                    UpdateRole.Visible = true;
                }


                if (Session["CompanyId"].ToString() == "Comp-1727" || Session["CompanyId"].ToString() == "Comp-1726" || Session["CompanyId"].ToString() == "Comp-1218" || Session["CompanyId"].ToString() == "Comp-1538" || Session["CompanyId"].ToString() == "Comp-1548" || Session["CompanyId"].ToString() == "Comp-1709" || Session["CompanyId"].ToString() == "Comp-1702" || Session["CompanyId"].ToString() == "Comp-1673" || Session["CompanyId"].ToString() == "Comp-1567" || Session["CompanyId"].ToString() == "Comp-1650" || Session["CompanyId"].ToString() == "Comp-1388" || Session["CompanyId"].ToString() == "Comp-1312" || Session["CompanyId"].ToString() == "Comp-1439" || Session["CompanyId"].ToString() == "Comp-1321" || Session["CompanyId"].ToString() == "Comp-1451" || Session["CompanyId"].ToString() == "Comp-1466" || Session["CompanyId"].ToString() == "Comp-1483" || Session["CompanyId"].ToString() == "Comp-1499" || Session["CompanyId"].ToString() == "Comp-1722")
                { //suri-1727,shercotti,oci
                    showbalance.Visible = true;
                    BalanceAmount.Text = GETvendoWalletbalance("UPS_GetVendorWalletbalance");
                    // BalanceAmount.Text = SQL_DB.ExecuteScalar("select Sum(Paytm_balance.Amount)-sum(cc.Amount) as Balance  from Paytm_balance  inner join(select sum(Amount) As Amount, compId from paytmtransaction where compId = '" + Session["CompanyId"].ToString() + "' and pstatus = 'SUCCESS' group by compId) cc on cc.compId = Paytm_balance.Comp_ID").ToString();
                }
                if (Session["CompanyId"].ToString() == "Comp-1738")
                {
                    showbalance.Visible = true;

                    // Secure query using parameters to prevent SQL injection
                    string companyId = Session["CompanyId"].ToString();
                    string query = @"
   SELECT 
    SUM(Paytm_balance.Amount) - COALESCE(SUM(cc.Amount), 0) AS Balance  
FROM 
    Paytm_balance  
LEFT JOIN 
    (SELECT SUM(Amount) AS Amount, 'Comp-' + CompId AS CompId 
     FROM transactions 
     WHERE CompId = '" + companyId.Substring(5) + @"' 
     GROUP BY CompId) cc 
ON 
    cc.CompId = Paytm_balance.Comp_ID
WHERE 
    Paytm_balance.Comp_ID = '" + companyId + @"'
GROUP BY 
    Paytm_balance.Comp_ID;";



                    object result = SQL_DB.ExecuteScalar(query);
                    BalanceAmount.Text = result != null ? result.ToString() : "0";
                }

            }
        }
    }

    public string GETvendoWalletbalance(string Procedure)
    {
        string Result = string.Empty;
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand(Procedure, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@companyid", Session["CompanyId"].ToString());
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
        if (dt.Rows.Count > 0)
        {
            Result = dt.Rows[0][0].ToString();
        }
        else
        {
            Result = "0";
        }
        return Result;
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

    protected void imglogout_Click1(object sender, EventArgs e)
    {
        string IP = ServiceLogic.GetIP();
        if (Session["User_Type"].ToString() == "Admin")
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Login_History] SET [Logout_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE CONVERT(VARCHAR,Login_Date,111)= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' AND User_ID = '" + Session["User_Type"].ToString() + "'  AND user_Type = 1 AND (Dial_Mode = '" + IP + "')  AND Row_ID = (SELECT MAX(Row_ID) FROM  Login_History WHERE  User_ID = '" + Session["User_Type"].ToString() + "'  AND (Dial_Mode = '" + IP + "') ) ");
            Session.Abandon();
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/Admin/Login.aspx");
        }
        else if (Session["CompanyId"].ToString() == "Comp-1722")
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Login_History] SET [Logout_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE CONVERT(VARCHAR,Login_Date,111)= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' AND User_ID = '" + Session["CompanyId"].ToString() + "'  AND user_Type = 0 AND (Dial_Mode = '" + IP + "')  AND Row_ID = (SELECT MAX(Row_ID) FROM  Login_History WHERE  User_ID = '" + Session["CompanyId"].ToString() + "'  AND (Dial_Mode = '" + IP + "') ) ");
            Session.Abandon();
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "teslalogin.aspx");
        }
        else
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Login_History] SET [Logout_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE CONVERT(VARCHAR,Login_Date,111)= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' AND User_ID = '" + Session["CompanyId"].ToString() + "'  AND user_Type = 0 AND (Dial_Mode = '" + IP + "')  AND Row_ID = (SELECT MAX(Row_ID) FROM  Login_History WHERE  User_ID = '" + Session["CompanyId"].ToString() + "'  AND (Dial_Mode = '" + IP + "') ) ");
            Session.Abandon();
            //  Response.Redirect("~/Default.aspx");
            // Response.Redirect("../info/login.aspx");
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "login.aspx");

        }
    }
}
