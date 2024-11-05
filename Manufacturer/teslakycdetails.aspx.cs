using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_teslakycdetails : System.Web.UI.Page
{
    cls_message db = new cls_message();
    cls_teslaemailtemplate _mail = new cls_teslaemailtemplate();
    cls_tesla claim = new cls_tesla();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../Login.aspx?Page=frm_ViewKycDetails.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["mid"] != null)
            {
                string mid = Convert.ToString(Request.QueryString["mid"]);
                DataTable dt = SQL_DB.ExecuteDataTable("exec Proc_getkycuserdata '" + mid + "'");
                if (dt.Rows.Count > 0)
                {
                    txtName.Text = dt.Rows[0]["ConsumerName"].ToString();
                    txtMobile.Text = dt.Rows[0]["MobileNo"].ToString();
                    txtCity.Text = dt.Rows[0]["City"].ToString();
                   // txtKYC.Text = dt.Rows[0]["VRKbl_KYC_status"].ToString();
                    txtKYC.Text = dt.Rows[0]["UPIKYCSTATUS"].ToString();
                    if (dt.Rows[0]["UPIKYCSTATUS"].ToString() == "1")
                    {
                        txtKYC.Text = "Approved";
                        TextUPIId.ReadOnly = true;
                    }
                    else if (dt.Rows[0]["UPIKYCSTATUS"].ToString() == "2")
                    {
                        txtKYC.Text = "Rejected";
                    }
                    else if (dt.Rows[0]["UPIKYCSTATUS"].ToString() == "3")
                    {
                        txtKYC.Text = "Send request again";
                    }
                    else
                    {
                        txtKYC.Text = "Pending";
                    }
                    HiddenM_ConID.Value = dt.Rows[0]["M_Consumerid"].ToString();
                    hdnemail.Value = dt.Rows[0]["Email"].ToString();
                    TextRemark.Text = dt.Rows[0]["remark"].ToString();
                    TextBankName.Text = dt.Rows[0]["bankName"].ToString();
                    TextBranch.Text = dt.Rows[0]["Branch"].ToString();
                    TextAccountHolder.Text = dt.Rows[0]["Account_HolderNm"].ToString();
                    TextAccountNo.Text = dt.Rows[0]["Account_No"].ToString();
                    TextIFSC.Text = dt.Rows[0]["IFSC_Code"].ToString();
                    TextUPIId.Text = dt.Rows[0]["UPIId"].ToString();
                    string UPIKYCSTATUS = dt.Rows[0]["UPIKYCSTATUS"].ToString();
                    string kycsstt = dt.Rows[0]["VRKbl_KYC_status"].ToString();
                    string teslapaymentselection = dt.Rows[0]["teslapayoutmode"].ToString();
                    String kycSt = "";
                    if (kycsstt == "Pending") { kycSt = "0"; }
                    if (kycsstt == "Rejected") { kycSt = "2"; }
                    if (kycsstt == "Approved") { kycSt = "1"; }
                    if (kycsstt == "Send request again") { kycSt = "3"; }
                    KycStatus.SelectedIndex = Convert.ToInt32(kycSt);
                    if (string.IsNullOrEmpty(UPIKYCSTATUS))
                        UPIKYCSTATUS = "0";
                    ddlupikycstatus.SelectedValue = UPIKYCSTATUS;
                   DataTable dtcon = SQL_DB.ExecuteDataTable("select top 1 * from M_Consumer where M_Consumerid='" + HiddenM_ConID.Value + "'");
                  
                    int point = claim.calculatepoint(mid, Session["CompanyId"].ToString(), dtcon.Rows[0]["User_ID"].ToString());
                    lblpoint.Text = point.ToString();
                    divUPIKYC.Visible = true;
                    bankkyc.Visible = true;
                    bankkycupdate.Visible = true;
                }
                else
                {
                }
            }
            else
            {
                Response.Redirect("teslakyc.aspx");
            }
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        Response.Redirect("teslakyc.aspx");
    }
    protected void ImgSearch_Click(object sender, EventArgs e)
    {
        
        if (KycStatus.Text != "" && HiddenM_ConID.Value != "")
        {
            // int pforredem = Convert.ToInt32(lblpoint.Text);
            int pforredem = string.IsNullOrWhiteSpace(lblpoint.Text) ? 0 : Convert.ToInt32(lblpoint.Text);
            DataTable dt = new DataTable();
            dt = SQL_DB.ExecuteDataTable("select * from M_Consumer where M_Consumerid='" + HiddenM_ConID.Value + "'");
            if (dt.Rows.Count > 0)
            {
                if (string.IsNullOrEmpty(dt.Rows[0]["UPIId"].ToString()))
                {
                    DataTable dtchkupi = SQL_DB.ExecuteDataTable("select [mobileno] FROM [M_Consumer] where MobileNo <> '" + dt.Rows[0]["MobileNo"].ToString() + "' AND UPIId ='" + TextUPIId.Text.Trim() + "'");
                    if (string.IsNullOrEmpty(TextUPIId.Text.Trim()))
                    {
                        db.ShowErrorMessage(this, "Please enter upi id");
                        return;
                    }
                    if (dtchkupi.Rows.Count > 0)
                    {
                        db.ShowErrorMessage(this,"Upi id already used with another user");
                        return;
                    }
                    if (!TextUPIId.Text.Trim().Contains("@"))
                    {
                        db.ShowErrorMessage(this, "Please enter valid upi id");
                        return;
                    }

                    SQL_DB.ExecuteNonQuery("update M_consumer set UPIId='" + TextUPIId.Text.Trim() + "' where M_consumerid='" + HiddenM_ConID.Value + "'");
                }

                //SQL_DB.ExecuteNonQuery("update m_consumer set remark='" + TextRemark.Text + "', VRKbl_KYC_status='" + KycStatus.Text + "'  where M_Consumerid='" + HiddenM_ConID.Value + "'");
                SQL_DB.ExecuteNonQuery("update M_consumer set remark='" + TextRemark.Text + "', UPIKYCSTATUS=" + KycStatus.Text + " where M_consumerid='" + HiddenM_ConID.Value + "'");
                string stsKyc = "";
                if (KycStatus.Text == "1")
                {
                    stsKyc = "Approved";
                    if (pforredem > 0)
                    {
                        claim.SubmitClaim(dt.Rows[0]["mobileno"].ToString(), pforredem, dt.Rows[0]["M_consumerid"].ToString(), Session["CompanyId"].ToString());
                    }

                    _mail.ApprovedKYC(txtName.Text, hdnemail.Value, "s.trikha@teslapowerusa.com");
                }
                else
                {
                    stsKyc = "Reject";
                    _mail.RejectedKYC(txtName.Text, hdnemail.Value, "s.trikha@teslapowerusa.com");
                }
                db.ShowSuccessMessagewithredirect(this, "KYC " + stsKyc + " Successfully", "../Manufacturer/teslakyc.aspx");
            }
        }
        else
        {
            db.ShowErrorMessage(this, "Please select KYC Status!");
        }
    }

    protected void btnverifyupi_Click(object sender, EventArgs e)
    {
        int pforredem = Convert.ToInt32(lblpoint.Text);
        string UPIId = TextUPIId.Text;
        string UPIKYCSelection = ddlupikycstatus.SelectedItem.Value;
        string Consumerid = HiddenM_ConID.Value;

        DataTable dt = new DataTable();
        dt = SQL_DB.ExecuteDataTable("select * from M_Consumer where M_Consumerid='" + HiddenM_ConID.Value + "'");

        if (string.IsNullOrEmpty(UPIId))
        {
            db.ShowErrorMessage(this, "UPI Id should not be null or blank!");
            return;
        }
        else if (string.IsNullOrEmpty(Consumerid))
        {
            db.ShowErrorMessage(this, "Something went wrong please try after sometime!");
            return;
        }
        else if (UPIKYCSelection == "-1")
        {
            db.ShowErrorMessage(this, "Please Select UPI KYC Status!");
            return;
        }
        else
        {
            if (UPIKYCSelection == "1")
            {
                if (pforredem > 0)
                {
                    claim.SubmitClaim(dt.Rows[0]["mobileno"].ToString(), pforredem, dt.Rows[0]["M_consumerid"].ToString(), Session["CompanyId"].ToString());
                }
                _mail.ApprovedKYC(txtName.Text, hdnemail.Value,"s.trikha@teslapowerusa.com");
            }
            else if (UPIKYCSelection == "2")
            {
                _mail.RejectedKYC(txtName.Text, hdnemail.Value, "s.trikha@teslapowerusa.com");
            }
            SQL_DB.ExecuteNonQuery("update M_consumer set UPIKYCSTATUS=" + UPIKYCSelection + " where M_consumerid='" + Consumerid + "'");
            db.ShowSuccessMessage(this, "UPI KYC Updated Successfully!");
        }
    }
}