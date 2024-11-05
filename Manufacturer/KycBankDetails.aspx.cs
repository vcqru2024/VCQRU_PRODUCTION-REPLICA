using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_KycBankDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            NewMsgpop.Visible = false;

            if (Request.QueryString["mid"] != null)
            {
                string mid = Convert.ToString(Request.QueryString["mid"]);
                DataTable dt = new DataTable();
               // string strr2 = "select a.M_Consumerid,a.MobileNo,ConsumerName,b.AccountNo,b.AccountHolderName,KycMode,case when IsBankAccountVerify='true' then 'Success' else 'Failure' end kycStatus,b.IFSC_Code,b.BankReqdate,b.BankRemarks as remark,created_at, Bank_Name,Account_HolderNm,Branch,Account_No,c.IFSC_Code as IfcCodee,Account_Type from M_Consumer a,tblKycBankDataDetails b, M_BankAccount c where a.M_Consumerid=b.M_Consumerid and b.M_Consumerid =  c.M_Consumerid and b.M_Consumerid= '" + mid + "' order by b.Id desc  ";
                string strr2 = "select a.M_Consumerid,a.MobileNo,ConsumerName,AccountNo,AccountHolderName,KycMode,case when IsBankAccountVerify='true' then 'Success' else 'Failure' end kycStatus,b.IFSC_Code,BankReqdate,BankRemarks as remark,created_at, Bank_Name,Account_HolderNm,Branch,Account_No,c.IFSC_Code as IfcCodee,Account_Type,passbook_source " +
                   " from M_Consumer a " +
                   " left join  tblKycBankDataDetails b on a.M_Consumerid=b.M_Consumerid " +
                   " left join M_BankAccount c  on b.M_Consumerid =  c.M_Consumerid " +
                   " where  b.M_Consumerid='" + mid + "' ";

                dt = SQL_DB.ExecuteDataTable(strr2);
                if (dt.Rows.Count > 0)
                {
                    txtName.Text = dt.Rows[0]["ConsumerName"].ToString();
                    txtMobile.Text = dt.Rows[0]["MobileNo"].ToString();
                    txtKYC.Text = dt.Rows[0]["kycStatus"].ToString();
                    HiddenM_ConID.Value = dt.Rows[0]["M_Consumerid"].ToString();
                    TextRemark.Text = dt.Rows[0]["remark"].ToString();
                    TextBankName.Text = dt.Rows[0]["Bank_Name"].ToString();
                    TextBranch.Text = dt.Rows[0]["Branch"].ToString();
                    TextAccountHolder.Text = dt.Rows[0]["AccountHolderName"].ToString();
                    TextAccountNo.Text = dt.Rows[0]["AccountNo"].ToString();
                    TextIFSC.Text = dt.Rows[0]["IFSC_Code"].ToString();

                    kycMode.Text = dt.Rows[0]["KycMode"].ToString();
                    BankReqdate.Text = dt.Rows[0]["BankReqdate"].ToString();

                    // imgAadhar.Visible = true;
                    string kycsstt = dt.Rows[0]["kycStatus"].ToString();
                    String kycSt = "";
                    if (kycsstt == "Failure") { kycSt = "0"; }
                    if (kycsstt == "Rejected") { kycSt = "2"; }
                    if (kycsstt == "Success") { kycSt = "1"; }
                    if (kycsstt == "Send request again") { kycSt = "3"; }
                    KycStatus.SelectedIndex = Convert.ToInt32(kycSt);
                   
                    if (!string.IsNullOrEmpty(dt.Rows[0]["passbook_source"].ToString()))
                    {
                        imgPan.Visible = true;
                        imgPassbook.Visible = true;
                        imgPan.ImageUrl = "http://test.accomplishtrades.com/" + dt.Rows[0]["passbook_source"].ToString();
                        HyperLinkPan.Visible = true;
                        HyperLinkPan.HRef = "http://test.accomplishtrades.com/" + dt.Rows[0]["passbook_source"].ToString();
                    }
                    else
                    {
                        HyperLinkPan.HRef = string.Empty;
                        HyperLinkPan.Visible = false;
                        imgPan.Visible = false;
                        imgPassbook.Visible = false;
                    }
                   


                }
                else
                {

                }
            }

        }


    }
    protected void btnReset_Click(object sender, EventArgs e)
    {

        Response.Redirect("kycBankVeryfyReport.aspx");
    }
    protected void ImgSearch_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();


        if (KycStatus.Text != "" && HiddenM_ConID.Value != "")
        {

            string result = string.Empty;
            DataTable dt = new DataTable();
            DataTable dt2 = new DataTable();
            //string qrystr = "select * from M_Consumer where MobileNo='" + HiddenM_ConID.Value + "'";

            dt = SQL_DB.ExecuteDataTable("select M_Consumerid from M_Consumer where M_Consumerid='" + HiddenM_ConID.Value + "'");
            if (dt.Rows.Count > 0)
            {
                // SQL_DB.ExecuteNonQuery("update m_consumer set remark='" + TextRemark.Text + "', VRKbl_KYC_status='" + KycStatus.Text + "'  where M_Consumerid='" + HiddenM_ConID.Value + "'");
                dt2 = SQL_DB.ExecuteDataTable("select M_Consumerid from M_BankAccount where M_Consumerid='" + HiddenM_ConID.Value + "'");
                if (dt2.Rows.Count > 0)
                {

                    SQL_DB.ExecuteNonQuery("update M_BankAccount set Bank_Name='" + TextBankName.Text + "',Account_HolderNm='" + TextAccountHolder.Text + "', Account_No='" + TextAccountNo.Text + "', Branch='" + TextBranch.Text + "',IFSC_Code='" + TextIFSC + "'  where M_Consumerid='" + HiddenM_ConID.Value + "'");
                    SQL_DB.ExecuteNonQuery("update tblKycBankDataDetails set AccountHolderName='" + TextAccountHolder.Text + "', IsBankAccountVerify='" + KycStatus.Text + "',Status='" + KycStatus.Text + "',IFSC_Code='" + TextIFSC.Text + "',AccountNo='" + TextAccountNo.Text + "',BankRemarks='" + TextRemark.Text + "'  where M_Consumerid='" + HiddenM_ConID.Value + "'");
                    string stsKyc = "";
                    if (KycStatus.Text == "1")
                    {
                        stsKyc = "Success";
                        txtKYC.Text = "Success";
                    }
                    else
                    {
                        stsKyc = "Failure";
                        txtKYC.Text = "Failure";
                    }

                    if (KycStatus.Text == "1")
                    {
                        KycStatus.Text = "Success";
                    }
                    else
                    {
                        KycStatus.Text = "Failure";
                    }


                    NewMsgpop.Visible = true;
                    LblMsgUpdate.Text = "KYC " + stsKyc + " Successfully!";

                }

                else
                {
                    NewMsgpop.Visible = true;
                    LblMsgUpdate.Text = "Please upload document first using app!";
                }
            }
            else
            {
                NewMsgpop.Visible = true;
                LblMsgUpdate.Text = "User not registered Or Login!";
            }
        }
        else
        {
            NewMsgpop.Visible = true;
            LblMsgUpdate.Text = "Please select KYC Status!";
            //ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
            //      "<script>alert('Please select KYC Status!')</script>");
        }

    }

}