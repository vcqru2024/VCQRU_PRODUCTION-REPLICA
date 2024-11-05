using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_KycPanDetails : System.Web.UI.Page
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
               
                string strr2 = "select a.M_Consumerid,a.MobileNo,pan_card_file,ConsumerName,pancardNumber,KycMode,pancard_number,PanName,InputPanName,PanRemarks as remark,case when IspanVerify='true' then 'Success' else 'Failure' end kycStatus,PanReqdate,created_at from M_Consumer a,tblKycPanDataDetails b  where a.M_Consumerid=b.M_Consumerid and b.M_Consumerid= '" + mid + "' order by b.Id desc  ";
                dt = SQL_DB.ExecuteDataTable(strr2);

                if (dt.Rows.Count > 0)
                {
                    txtName.Text = dt.Rows[0]["ConsumerName"].ToString();
                    PanHolderName.Text = dt.Rows[0]["PanName"].ToString();
                    panHolderNmFrm.Text = dt.Rows[0]["PanName"].ToString();
                    InputName.Text = dt.Rows[0]["InputPanName"].ToString();
                    txtMobile.Text = dt.Rows[0]["MobileNo"].ToString();
                    PanReqdate.Text = dt.Rows[0]["PanReqdate"].ToString();

                    HiddenM_ConID.Value = dt.Rows[0]["M_Consumerid"].ToString();
                    if (dt.Rows[0]["pancardNumber"].ToString()!="")
                    {
                        TextPanNo.Text = dt.Rows[0]["pancardNumber"].ToString();
                        PanNumberFrm.Text = dt.Rows[0]["pancardNumber"].ToString();
                    }
                    else
                    {
                        TextPanNo.Text = dt.Rows[0]["pancard_number"].ToString();
                        PanNumberFrm.Text = dt.Rows[0]["pancard_number"].ToString();
                    }
                    kycMode.Text = dt.Rows[0]["KycMode"].ToString();


                    TextRemark.Text = dt.Rows[0]["remark"].ToString();
                    TextRemarkText.Text = dt.Rows[0]["remark"].ToString();
                    // imgAadhar.Visible = true;
                    String kycSt = "";
                    string kycsstt = dt.Rows[0]["kycStatus"].ToString();
                  
                    if (kycsstt == "Failure") { kycSt = "0"; }
                    if (kycsstt == "Rejected") { kycSt = "2"; }
                    if (kycsstt == "Success") { kycSt = "1"; }
                    if (kycsstt == "Send request again") { kycSt = "3"; }
                    KycStatus.SelectedIndex = Convert.ToInt32(kycSt);
                    //Convert.ToInt32(KycStatus.SelectedValue); 
                    //KycStatus.Items.Insert(0, new ListItem(kycsstt.ToString(), kycSt.ToString()));
                    KycStatusText.Text = kycsstt;
                    if (!string.IsNullOrEmpty(dt.Rows[0]["pan_card_file"].ToString()))
                    {
                        imgPan.Visible = true;
                        imgPan.ImageUrl = "http://test.accomplishtrades.com/" + dt.Rows[0]["pan_card_file"].ToString();
                        HyperLinkPan.Visible = true;
                        HyperLinkPan.HRef = "http://test.accomplishtrades.com/" + dt.Rows[0]["pan_card_file"].ToString();
                    }
                    else
                    {
                        HyperLinkPan.HRef = string.Empty;
                        HyperLinkPan.Visible = false;
                        imgPan.Visible = false;
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

        Response.Redirect("kycPancardReport.aspx");
    }
    protected void ImgSearch_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();


        if (KycStatus.Text != "" && HiddenM_ConID.Value != "" && panHolderNmFrm.Text != "" && PanNumberFrm.Text != "")
        {

            string result = string.Empty;
            DataTable dt = new DataTable();
            //string qrystr = "select * from M_Consumer where MobileNo='" + HiddenM_ConID.Value + "'";

            dt = SQL_DB.ExecuteDataTable("select M_Consumerid from M_Consumer where M_Consumerid='" + HiddenM_ConID.Value + "'");
            if (dt.Rows.Count > 0)
            {
                SQL_DB.ExecuteNonQuery("update M_Consumer set pancard_number='" + PanNumberFrm.Text + "'  where M_Consumerid='" + HiddenM_ConID.Value + "'");

                SQL_DB.ExecuteNonQuery("update tblKycPanDataDetails set PanName='" + panHolderNmFrm.Text + "',pancardNumber='" + PanNumberFrm.Text + "', PanRemarks='" + TextRemark.Text + "', IspanVerify='" + KycStatus.Text + "'  where M_Consumerid='" + HiddenM_ConID.Value + "'");
                PanNumberFrm.Text = PanNumberFrm.Text;
                panHolderNmFrm.Text = panHolderNmFrm.Text;
                string stsKyc = "";
                if (KycStatus.Text == "1")
                {
                    stsKyc = "Success";
                    KycStatusText.Text = "Success";
                }
                else
                {
                    stsKyc = "Failure";
                    KycStatusText.Text = "Failure";
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