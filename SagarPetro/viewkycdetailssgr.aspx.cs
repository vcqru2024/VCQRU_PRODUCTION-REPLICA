using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;


public partial class SagarPetro_viewkycdetailssgr : System.Web.UI.Page
{
    string baseurl = ProjectSession.absoluteSiteBrowseUrl;
    cls_message db = new cls_message();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["CompanyId"] == null)
            Response.Redirect("../Sagarpetro/Loginpfl.aspx?Page=frm_ViewKycDetails");
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
                DataTable dt = SQL_DB.ExecuteDataTable("exec Proc_getkycuserdata_sp '" + mid + "'");
                if (dt.Rows.Count > 0)
                {
                    txtName.Text = dt.Rows[0]["UserName"].ToString();
                    txtMobile.Text = dt.Rows[0]["MobileNo"].ToString();
                    txtCity.Text = dt.Rows[0]["City_Name"].ToString();
                    txtKYC.Text = dt.Rows[0]["VRKbl_KYC_status"].ToString();
                    HiddenM_ConID.Value = dt.Rows[0]["M_Consumerid"].ToString();
                    TextRemark.Text = dt.Rows[0]["remark"].ToString();
                    TextBankName.Text = dt.Rows[0]["bankName"].ToString();
                    TextBranch.Text = dt.Rows[0]["Branch"].ToString();
                    TextAccountHolder.Text = dt.Rows[0]["Account_HolderNm"].ToString();
                    TextAccountNo.Text = dt.Rows[0]["Account_No"].ToString();
                    TextIFSC.Text = dt.Rows[0]["IFSC_Code"].ToString();
                    string kycsstt = dt.Rows[0]["VRKbl_KYC_status"].ToString();
                    String kycSt = "";
                    if (kycsstt == "Pending") { kycSt = "0"; }
                    if (kycsstt == "Approved") { kycSt = "1"; }
                    if (kycsstt == "Rejected") { kycSt = "2"; }
                    if (kycsstt == "Send request again") { kycSt = "3"; }
                    KycStatus.SelectedIndex = Convert.ToInt32(kycSt);
                    if (!string.IsNullOrEmpty(dt.Rows[0]["aadharFile"].ToString()))
                    {
                        imgAadharFront.Visible = true;
                        imgAadharFrontDiv.InnerText = "";
                        imgAadharFront.Attributes.Add("src", baseurl + dt.Rows[0]["aadharFile"].ToString());
                        HyperLinkAadharFront.Visible = true;
                        HyperLinkAadharFront.HRef = baseurl + dt.Rows[0]["aadharFile"].ToString();
                    }
                    else
                    {
                        imgAadharFrontDiv.Visible = false;
                        HyperLinkAadharFront.HRef = string.Empty;
                        HyperLinkAadharFront.Visible = false;
                        imgAadharFront.Visible = false;
                        imgAadharFrontDiv.InnerText = "NA";
                    }
                    if (!string.IsNullOrEmpty(dt.Rows[0]["aadharback"].ToString()))
                    {
                        imgAadharBack.Visible = true;
                        imgAadharBackDiv.InnerText = "";
                        imgAadharBack.Attributes.Add("src", baseurl + dt.Rows[0]["aadharback"].ToString());
                        HyperLinkAadharBack.Visible = true;
                        HyperLinkAadharBack.HRef = baseurl + dt.Rows[0]["aadharback"].ToString();
                    }
                    else
                    {
                        HyperLinkAadharBack.HRef = string.Empty;
                        HyperLinkAadharBack.Visible = false;
                        imgAadharBack.Visible = false;
                        imgAadharBackDiv.InnerText = "NA";
                    }
                    if (!string.IsNullOrEmpty(dt.Rows[0]["pan_card_file"].ToString()))
                    {
                        imgPan.Visible = true;
                        imgPanDiv.InnerText = "";
                        imgPan.Attributes.Add("src", baseurl + dt.Rows[0]["pan_card_file"].ToString());
                        HyperLinkPan.Visible = true;
                        HyperLinkPan.HRef = baseurl + dt.Rows[0]["pan_card_file"].ToString();
                    }
                    else
                    {
                        HyperLinkPan.HRef = string.Empty;
                        HyperLinkPan.Visible = false;
                        imgPan.Visible = false;
                        imgPanDiv.InnerText = "NA";
                    }

                    if (!string.IsNullOrEmpty(dt.Rows[0]["chkPassbook"].ToString()))
                    {
                        imgpass.Visible = true;
                        imgpassdiv.InnerText = "";
                        imgpass.Attributes.Add("src", baseurl + dt.Rows[0]["chkPassbook"].ToString());
                        HyperLinkPass.Visible = true;
                        HyperLinkPass.HRef = baseurl + dt.Rows[0]["chkPassbook"].ToString();
                    }
                    else
                    {
                        HyperLinkPass.HRef = string.Empty;
                        HyperLinkPass.Visible = false;
                        imgpass.Visible = false;
                        imgpassdiv.InnerText = "NA";
                    }

                    if (!string.IsNullOrEmpty(dt.Rows[0]["Shopimg"].ToString()))
                    {
                        imgShop.Visible = true;
                        imgShopDiv.InnerText = "";
                        imgShop.Attributes.Add("src", baseurl + dt.Rows[0]["Shopimg"].ToString());
                        HyperLinkShop.Visible = true;
                        HyperLinkShop.HRef = baseurl + dt.Rows[0]["Shopimg"].ToString();
                    }
                    else
                    {
                        HyperLinkShop.HRef = string.Empty;
                        HyperLinkShop.Visible = false;
                        imgShop.Visible = false;
                        imgShopDiv.Visible = false;
                        imgShopDiv.InnerText = "NA";
                    }
                    if (!string.IsNullOrEmpty(dt.Rows[0]["Shopimg2"].ToString()))
                    {
                        imgShop1.Visible = true;
                        imgShopDiv1.InnerText = "";
                        imgShop1.Attributes.Add("src", baseurl + dt.Rows[0]["Shopimg2"].ToString());
                        HyperLinkShop1.Visible = true;
                        HyperLinkShop1.HRef = baseurl + dt.Rows[0]["Shopimg2"].ToString();
                    }
                    else
                    {
                        HyperLinkShop1.HRef = string.Empty;
                        HyperLinkShop1.Visible = false;
                        imgShop1.Visible = false;
                        imgShopDiv1.Visible = false;
                        imgShopDiv1.InnerText = "NA";
                    }
                    if (!string.IsNullOrEmpty(dt.Rows[0]["Shopimg3"].ToString()))
                    {
                        imgShop2.Visible = true;
                        imgShopDiv2.InnerText = "";
                        imgShop2.Attributes.Add("src", baseurl + dt.Rows[0]["Shopimg3"].ToString());
                        HyperLinkShop2.Visible = true;
                        HyperLinkShop2.HRef = baseurl + dt.Rows[0]["Shopimg3"].ToString();
                    }
                    else
                    {
                        HyperLinkShop2.HRef = string.Empty;
                        HyperLinkShop2.Visible = false;
                        imgShop2.Visible = false;
                        imgShopDiv2.Visible = false;
                        imgShopDiv2.InnerText = "NA";
                    }
                }

            }
        }
    }



    protected void btnReset_Click(object sender, EventArgs e)
    {
        Response.Redirect("frm_KYC.aspx");
    }
    protected void ImgSearch_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        if ( !string.IsNullOrEmpty(KycStatus.Text) &&  !string.IsNullOrEmpty(HiddenM_ConID.Value))
        {
            DataTable dt = SQL_DB.ExecuteDataTable("select M_Consumerid from M_Consumer where M_Consumerid='" + HiddenM_ConID.Value + "'");
            if (dt.Rows.Count > 0)
            {
                SQL_DB.ExecuteNonQuery("update m_consumer set remark='" + TextRemark.Text + "', VRKbl_KYC_status='" + KycStatus.Text + "'  where M_Consumerid='" + HiddenM_ConID.Value + "'");
                if (KycStatus.Text == "1")
                {
                    db.ShowSuccessMessage(this, "KYC Approved Successfully!");
                }
                else
                {
                    db.ShowSuccessMessage(this, "KYC Rejected Successfully!");
                }
            }
        }
        else
        {
            db.ShowErrorMessage(this, "Please Select Kyc Status");
        }
    }

    protected void btnback_Click(object sender, EventArgs e)
    {
        Response.Redirect("../SagarPetro/frmkycsgr.aspx");
    }
}