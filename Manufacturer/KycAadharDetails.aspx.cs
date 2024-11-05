using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_KycAadharDetails : System.Web.UI.Page
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
               
   
               string strr2 = "select top 1 a.M_Consumerid,a.aadharFile,a.aadharback,a.MobileNo,ConsumerName,AadharNo,aadharNumber,AadharName,case when IsaadharVerify='true' then 'Success' else 'Failure' end kycStatus,AadharReqdate,AadharRemarks as remark,KycMode,created_at,kycMode from M_Consumer a,tblKycAadharDataDetails b  where a.M_Consumerid=b.M_Consumerid and b.M_Consumerid = '" + mid + "' order by b.Id desc  ";
                dt = SQL_DB.ExecuteDataTable(strr2);
                if (dt.Rows.Count > 0)
                {
                    txtName.Text = dt.Rows[0]["ConsumerName"].ToString();
                    txtMobile.Text = dt.Rows[0]["MobileNo"].ToString();
                    txtKYC.Text = dt.Rows[0]["kycStatus"].ToString();
                    HiddenM_ConID.Value = dt.Rows[0]["M_Consumerid"].ToString();
                    aadharHolderNmFrm.Text = dt.Rows[0]["AadharName"].ToString();
                    AadharHolderName.Text = dt.Rows[0]["AadharName"].ToString();
                    TextRemark.Text = dt.Rows[0]["remark"].ToString();
                    TextRemarkText.Text = dt.Rows[0]["remark"].ToString();
                    TextRemarkText.Text = dt.Rows[0]["remark"].ToString();
                    AadharReqdate.Text = dt.Rows[0]["AadharReqdate"].ToString();
                    kycMode.Text = dt.Rows[0]["KycMode"].ToString();                                      

                    if (dt.Rows[0]["AadharNo"].ToString() != "")
                    {
                        TextAadharNo.Text = dt.Rows[0]["AadharNo"].ToString();
                        aadhharNumberFrm.Text = dt.Rows[0]["AadharNo"].ToString();                        
                    }
                    else
                    {
                        TextAadharNo.Text = dt.Rows[0]["aadharNumber"].ToString();
                        aadhharNumberFrm.Text = dt.Rows[0]["aadharNumber"].ToString();
                    }             

                    // imgAadhar.Visible = true;
                    string kycsstt = dt.Rows[0]["kycStatus"].ToString();
                    String kycSt = "";
                    if (kycsstt == "Failure") { kycSt = "0"; }
                    if (kycsstt == "Success") { kycSt = "1"; }
                    if (kycsstt == "Rejected") { kycSt = "2"; }
                  
                    if (kycsstt == "Send request again") { kycSt = "3"; }
                    KycStatus.SelectedIndex = Convert.ToInt32(kycSt);
                    //Convert.ToInt32(KycStatus.SelectedValue); 
                    //KycStatus.Items.Insert(0, new ListItem(kycsstt.ToString(), kycSt.ToString()));
                    if (!string.IsNullOrEmpty(dt.Rows[0]["aadharFile"].ToString()))
                    {
                        imgAadharFront.Visible = true;
                        imgAadharFront.ImageUrl = "http://test.accomplishtrades.com/" + dt.Rows[0]["aadharFile"].ToString();
                        HyperLinkAadharFront.Visible = true;
                        HyperLinkAadharFront.HRef = "http://test.accomplishtrades.com/" + dt.Rows[0]["aadharFile"].ToString();
                    }
                    else
                    {
                        HyperLinkAadharFront.HRef = string.Empty;
                        HyperLinkAadharFront.Visible = false;
                        imgAadharFront.Visible = false;
                    }
                    if (!string.IsNullOrEmpty(dt.Rows[0]["aadharback"].ToString()))
                    {
                        imgAadharBack.Visible = true;
                        imgAadharBack.ImageUrl = "http://test.accomplishtrades.com/" + dt.Rows[0]["aadharback"].ToString();
                        HyperLinkAadharBack.Visible = true;
                        HyperLinkAadharBack.HRef = "http://test.accomplishtrades.com/" + dt.Rows[0]["aadharback"].ToString();
                    }
                    else
                    {
                        HyperLinkAadharBack.HRef = string.Empty;
                        HyperLinkAadharBack.Visible = false;
                        imgAadharBack.Visible = false;
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

        Response.Redirect("KycAadharReport.aspx");
    }
    protected void ImgSearch_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();


        if (KycStatus.Text != "" && HiddenM_ConID.Value != "")
        {

            string result = string.Empty;
            DataTable dt = new DataTable();
            //string qrystr = "select * from M_Consumer where MobileNo='" + HiddenM_ConID.Value + "'";

            dt = SQL_DB.ExecuteDataTable("select M_Consumerid from M_Consumer where M_Consumerid='" + HiddenM_ConID.Value + "'");
            if (dt.Rows.Count > 0)
            {
                SQL_DB.ExecuteNonQuery("update m_consumer set aadharNumber='" + aadhharNumberFrm.Text + "'  where M_Consumerid='" + HiddenM_ConID.Value + "'");
                SQL_DB.ExecuteNonQuery("update tblKycAadharDataDetails set AadharName='" + aadharHolderNmFrm.Text + "',AadharNo='" + aadhharNumberFrm.Text + "', AadharRemarks='" + TextRemark.Text + "', IsaadharVerify='" + KycStatus.Text + "'  where M_Consumerid='" + HiddenM_ConID.Value + "'");
                aadhharNumberFrm.Text = aadhharNumberFrm.Text;
                aadharHolderNmFrm.Text = aadharHolderNmFrm.Text;
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