using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_ViewDetailsVrkable : System.Web.UI.Page
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
                /* string strr1 = "select M_Consumerid,ConsumerName,Email,MobileNo,City,cin_number, case  when Vrkabel_User_Type='1' then 'Dealer' when Vrkabel_User_Type='2' then 'Retailer' when Vrkabel_User_Type='3' then 'Counter Boy' when Vrkabel_User_Type='4' then 'Electrician'  end Vrkabel_User_Type, " +
                      "case  when VRKbl_KYC_status='1' then 'Approved' when VRKbl_KYC_status='2' then 'Rejected' when VRKbl_KYC_status='3' then 'Send Request again' else 'Pending' end VRKbl_KYC_status,dob,aadharNumber,pancard_number,gst_number,gender,aadharFile,aadharback,pan_card_file,shop_file,remark" +
                      " from M_Consumer where M_Consumerid='" + mid + "'";
                  */
                //string strr2 = "select a.M_Consumerid,ConsumerName,Email,MobileNo,a.City,cin_number," +
                //             "case  when Vrkabel_User_Type = '1' then 'Dealer' when Vrkabel_User_Type = '2' then 'Retailer' when Vrkabel_User_Type = '3' then 'Counter Boy' when Vrkabel_User_Type = '4' then 'Electrician'  end Vrkabel_User_Type, " +
                //             "case  when VRKbl_KYC_status = '1' then 'Approved' when VRKbl_KYC_status = '2' then 'Rejected' when VRKbl_KYC_status = '3' then 'Send Request again' else 'Pending' end VRKbl_KYC_status, " +
                //             "dob, aadharNumber, pancard_number, gst_number, gender, aadharFile, aadharback, pan_card_file, shop_file, remark, " +
                //             "b.[Bank_Name] as bankName,Account_HolderNm ,Account_No,Branch,IFSC_Code,passbook_source as passBook " +
                //      " from M_Consumer as a  left join  M_BankAccount as b  on b.M_Consumerid=a.M_Consumerid  " +
                //      "where a.M_Consumerid = '" + mid + "'";
                  string strr2 = "select top 1 a.M_Consumerid,ConsumerName,Email,MobileNo,a.City,cin_number,ref_cin_number,shop_name, " +
                             "case  when Vrkabel_User_Type = '1' then 'Dealer' when Vrkabel_User_Type = '2' then 'Retailer' when Vrkabel_User_Type = '3' then 'Counter Boy' when Vrkabel_User_Type = '4' then 'Electrician'  end Vrkabel_User_Type, " +
                             "case  when VRKbl_KYC_status = '1' then 'Approved' when VRKbl_KYC_status = '2' then 'Rejected' when VRKbl_KYC_status = '3' then 'Send Request again' else 'Pending' end VRKbl_KYC_status, " +
                             "dob, aadharNumber, pancard_number, gst_number, gender, aadharFile, aadharback, pan_card_file, shop_file, remark, " +
                             "b.[Bank_Name] as bankName,Account_HolderNm ,Account_No,Branch,IFSC_Code,passbook_source as passBook " +
                      " from M_Consumer as a  left join  M_BankAccount as b  on b.M_Consumerid=a.M_Consumerid  " +
                      "where a.M_Consumerid = '" + mid + "' order by b.Entry_Date desc";


                dt = SQL_DB.ExecuteDataTable(strr2);

                if (dt.Rows.Count > 0)
                {
                    txtName.Text = dt.Rows[0]["ConsumerName"].ToString();
                    txtEmail.Text = dt.Rows[0]["Email"].ToString();
                    txtMobile.Text = dt.Rows[0]["MobileNo"].ToString();
                    txtCity.Text = dt.Rows[0]["City"].ToString();
		    TextshopName.Text = dt.Rows[0]["shop_name"].ToString();
                    txtCIN.Text = dt.Rows[0]["cin_number"].ToString();
                    txtRefCIN.Text = dt.Rows[0]["ref_cin_number"].ToString();
                    txtUserRole.Text = dt.Rows[0]["Vrkabel_User_Type"].ToString();
                    txtKYC.Text = dt.Rows[0]["VRKbl_KYC_status"].ToString();
                    HiddenM_ConID.Value = dt.Rows[0]["M_Consumerid"].ToString();

                    txtDOB.Text = dt.Rows[0]["dob"].ToString();
                    TextAadharNo.Text = dt.Rows[0]["aadharNumber"].ToString();
                    TextPanNo.Text = dt.Rows[0]["pancard_number"].ToString();
                    TextGST.Text = dt.Rows[0]["gst_number"].ToString();
                    TextGender.Text = dt.Rows[0]["gender"].ToString();
                    TextRemark.Text = dt.Rows[0]["remark"].ToString();

                    TextBankName.Text = dt.Rows[0]["bankName"].ToString();
                    TextBranch.Text = dt.Rows[0]["Branch"].ToString();
                    TextAccountHolder.Text = dt.Rows[0]["Account_HolderNm"].ToString();
                    TextAccountNo.Text = dt.Rows[0]["Account_No"].ToString();
                    TextIFSC.Text = dt.Rows[0]["IFSC_Code"].ToString();
    

                    

                    // imgAadhar.Visible = true;
                    string kycsstt = dt.Rows[0]["VRKbl_KYC_status"].ToString();
                    String kycSt = "";
                    if (kycsstt == "Pending") { kycSt = "0"; }
                    if (kycsstt == "Rejected") { kycSt = "2"; }
                    if (kycsstt == "Approved") { kycSt = "1"; }
                    if (kycsstt == "Send request again") { kycSt = "3"; }
                    KycStatus.SelectedIndex = Convert.ToInt32(kycSt);
                    //Convert.ToInt32(KycStatus.SelectedValue); 
                    //KycStatus.Items.Insert(0, new ListItem(kycsstt.ToString(), kycSt.ToString()));
                    if (!string.IsNullOrEmpty(dt.Rows[0]["aadharFile"].ToString()))
                    {
                        imgAadharFront.Visible = false;
                        imgAadharFront.ImageUrl = "http://vrkable.vcqru.com/" + dt.Rows[0]["aadharFile"].ToString();
                        HyperLinkAadharFront.Visible = true;
                        HyperLinkAadharFront.HRef = "http://vrkable.vcqru.com/" + dt.Rows[0]["aadharFile"].ToString();
                    }
                    else
                    {
                        HyperLinkAadharFront.HRef = string.Empty;
                        HyperLinkAadharFront.Visible = false;
                        imgAadharFront.Visible = false;
                    }
                    if (!string.IsNullOrEmpty(dt.Rows[0]["aadharback"].ToString()))
                    {
                        imgAadharBack.Visible = false;
                        imgAadharBack.ImageUrl = "http://vrkable.vcqru.com/" + dt.Rows[0]["aadharback"].ToString();
                        HyperLinkAadharBack.Visible = true;
                        HyperLinkAadharBack.HRef = "http://vrkable.vcqru.com/" + dt.Rows[0]["aadharback"].ToString();
                    }
                    else
                    {
                        HyperLinkAadharBack.HRef = string.Empty;
                        HyperLinkAadharBack.Visible = false;
                        imgAadharBack.Visible = false;
                    }
                    if (!string.IsNullOrEmpty(dt.Rows[0]["pan_card_file"].ToString()))
                    {
                        imgPan.Visible = false;
                        imgPan.ImageUrl = "http://vrkable.vcqru.com/" + dt.Rows[0]["pan_card_file"].ToString();
                        HyperLinkPan.Visible = true;
                        HyperLinkPan.HRef = "http://vrkable.vcqru.com/" + dt.Rows[0]["pan_card_file"].ToString();
                    }
                    else
                    {
                        HyperLinkPan.HRef = string.Empty;
                        HyperLinkPan.Visible = false;
                        imgPan.Visible = false;
                    }
                    if (!string.IsNullOrEmpty(dt.Rows[0]["shop_file"].ToString()))
                    {
                        imgShop.Visible = false;
                        imgShop.ImageUrl = "http://vrkable.vcqru.com/" + dt.Rows[0]["shop_file"].ToString();
                        HyperLinkShop.Visible = true;
                        HyperLinkShop.HRef = "http://vrkable.vcqru.com/" + dt.Rows[0]["shop_file"].ToString();
                    }
                    else
                    {
                        HyperLinkShop.HRef = string.Empty;
                        HyperLinkShop.Visible = false;
                        imgShop.Visible = false;
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
        
        Response.Redirect("frm_Consumervr_dtls.aspx");
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
                SQL_DB.ExecuteNonQuery("update m_consumer set remark='"+ TextRemark.Text + "', VRKbl_KYC_status='" + KycStatus.Text + "'  where M_Consumerid='" + HiddenM_ConID.Value + "'");
                string stsKyc = "";
                if (KycStatus.Text == "1")
                {
                    stsKyc = "Approved";
                    txtKYC.Text = "Approved";
                }
                else
                {
                    stsKyc = "Rejected";
                    txtKYC.Text = "Rejected";
                }

                if (KycStatus.Text == "1")
                {
                    KycStatus.Text = "Approved";
                }
                else
                {
                    KycStatus.Text = "Rejected";
                }

                // lblmsgHeader.Text = "KYC updated Successfully";
                //string slbl = FindLabelCode();
                //string script = "";
                // NewMsgpop.Visible = true;
                // lblmsgHeader.Text = "KYC updated Successfully.";

                NewMsgpop.Visible = true;
                LblMsgUpdate.Text = "KYC " + stsKyc + " Successfully!";





                //ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
                //   "<script>alert('KYC updated Successfully')</script>");
                // HttpContext.Current.Response.Redirect("?mid=11493");

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