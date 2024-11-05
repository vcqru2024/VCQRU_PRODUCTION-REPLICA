
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Manufacturer_ViewKycDetails : System.Web.UI.Page
{
    string baseurl = "https://www.vcqru.com/";
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["CompanyId"].ToString()== "Comp-1567" || Session["CompanyId"].ToString() == "Comp-1598" || Session["CompanyId"].ToString() == "Comp-1615" || Session["CompanyId"].ToString() == "Comp-1650")
        {
            DivPassbook.Visible = true;
            if (Session["CompanyId"].ToString() == "Comp-1650" || Session["CompanyId"].ToString() == "Comp-1567")
            {
                workplacestate.Visible = true;
                divcompany.Visible = true;
                divbtncomp.Visible = true;
            }
        }
        if (Session["CompanyId"].ToString() == "Comp-1684")
        {
            DivAddressProof.Visible = true;
        }
        if (Session["CompanyId"].ToString() == "Comp-1727")
        {
            TextBankNameDiv.Visible = false;
            TextBranchDiv.Visible = false;
            TextAccountHolderDiv.Visible = false;
            TextAccountNoDiv.Visible = false;
            TextIFSCDiv.Visible = false;
        }


        if (Session["CompanyId"] == null)
            Response.Redirect("../Info/Login.aspx?Page=frm_ViewKycDetails.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }


        if (!Page.IsPostBack)
        {

            if (Session["CompanyId"].ToString() == "Comp-1650" || Session["CompanyId"].ToString() == "Comp-1567")
            {
                binddropdown();
                ddlstate.Items.Insert(0, new ListItem("--Select State--", "--Select State--"));
                ddlstate.Enabled = true;
            }

            NewMsgpop.Visible = false;
            if (Request.QueryString["mid"] != null)
            {
                string mid = Convert.ToString(Request.QueryString["mid"]);
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("Proc_getkycuserdata", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MID", mid);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    bindcomp(mid);
                    txtName.Text = dt.Rows[0]["ConsumerName"].ToString();
                    txtEmail.Text = dt.Rows[0]["Email"].ToString();
                    txtMobile.Text = dt.Rows[0]["MobileNo"].ToString();
                    txtCity.Text = dt.Rows[0]["City"].ToString();
                    txtCIN.Text = dt.Rows[0]["cin_number"].ToString();
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
                    txtRefCIN.Text = dt.Rows[0]["ref_cin_number"].ToString();
                    //ddlstate.SelectedItem.Text = dt.Rows[0]["Workplacestate"].ToString();
                    TextUPIId.Text = dt.Rows[0]["UPIId"].ToString(); // oci tej
                    if (dt.Columns.Contains("Workplacestate"))
                    {
                        string workplaceState = dt.Rows[0]["Workplacestate"].ToString();
                        if (!string.IsNullOrEmpty(workplaceState))
                        {
                            ddlstate.SelectedItem.Text = workplaceState;
                        }
                        if (!string.IsNullOrEmpty(workplaceState) || workplaceState == "0")
                        {
                            workplacestate.Visible = true;
                            btnupdateworkplace.Visible = true;
                        }
                        else
                        {
                            ddlstate.Enabled = false;
                        }
                    }
                    

                    string kycsstt = dt.Rows[0]["VRKbl_KYC_status"].ToString();
                    String kycSt = "";
                    if (kycsstt == "Pending") { kycSt = "0"; }
                    if (kycsstt == "Rejected") { kycSt = "2"; }
                    if (kycsstt == "Approved") { kycSt = "1"; }
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
                    if (!string.IsNullOrEmpty(dt.Rows[0]["AddressProof"].ToString()))
                    {
                        imgAddressProof.Visible = true;
                        imgAddressProofdiv.InnerText = "";
                        imgAddressProof.Attributes.Add("src", baseurl + dt.Rows[0]["AddressProof"].ToString());
                        HyperLinkAddressProof.Visible = true;
                        HyperLinkAddressProof.HRef = baseurl + dt.Rows[0]["AddressProof"].ToString();
                    }
                    else
                    {
                        HyperLinkAddressProof.HRef = string.Empty;
                        imgAddressProof.Visible = false;
                        imgAddressProofdiv.Visible = false;
                        imgAddressProofdiv.InnerText = "NA";
                    }
                    if (!string.IsNullOrEmpty(dt.Rows[0]["UpiidImage"].ToString())) // oci
                    {
                        DivUPIID.Visible = true;
                        imgUPIID.Visible = true;
                        imgUPIIDdiv.InnerText = "";
                        imgUPIID.Attributes.Add("src", baseurl + dt.Rows[0]["UpiidImage"].ToString());
                        HyperLinkUPIID.Visible = true;
                        HyperLinkUPIID.HRef = baseurl + dt.Rows[0]["UpiidImage"].ToString();
                    }
                    else
                    {
                        HyperLinkUPIID.HRef = string.Empty;
                        HyperLinkUPIID.Visible = false;
                        imgUPIID.Visible = false;
                        imgUPIIDdiv.InnerText = "NA";
                    }
                    if (!string.IsNullOrEmpty(dt.Rows[0]["Selfie_image"].ToString())) // oci
                    {
                        Divselfie.Visible = true;
                        imgselfie.Visible = true;
                        imgselfiediv.InnerText = "";
                        imgselfie.Attributes.Add("src", baseurl + dt.Rows[0]["Selfie_image"].ToString());
                        HyperLinkselfie.Visible = true;
                        HyperLinkselfie.HRef = baseurl + dt.Rows[0]["Selfie_image"].ToString();
                    }
                    else
                    {
                        HyperLinkselfie.HRef = string.Empty;
                        HyperLinkselfie.Visible = false;
                        imgselfie.Visible = false;
                        imgselfiediv.InnerText = "NA";
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

                    if (!string.IsNullOrEmpty(dt.Rows[0]["shop_file"].ToString()))
                    {
                        imgShop.Visible = true;
                        imgShopDiv.InnerText = "";
                        imgShop.Attributes.Add("src", baseurl + dt.Rows[0]["shop_file"].ToString());
                        HyperLinkShop.Visible = true;
                        HyperLinkShop.HRef = baseurl + dt.Rows[0]["shop_file"].ToString();
                    }
                    else
                    {
                        HyperLinkShop.HRef = string.Empty;
                        HyperLinkShop.Visible = false;
                        imgShop.Visible = false;
                        imgShopDiv.Visible = false;
                        imgShopDiv.InnerText = "NA";
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
        Response.Redirect("frm_KYC.aspx");
    }
    protected void ImgSearch_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        if (KycStatus.Text != "" && HiddenM_ConID.Value != "")
        {
            string result = string.Empty;
            DataTable dt = new DataTable();
            dt = SQL_DB.ExecuteDataTable("select M_Consumerid from M_Consumer where M_Consumerid='" + HiddenM_ConID.Value + "'");
            if (dt.Rows.Count > 0)
            {
                //SQL_DB.ExecuteNonQuery("update m_consumer set remark='" + TextRemark.Text + "', VRKbl_KYC_status='" + KycStatus.Text + "'  where M_Consumerid='" + HiddenM_ConID.Value + "'");
                if (Session["CompanyId"].ToString() == "Comp-1650" || Session["CompanyId"].ToString() == "Comp-1567")
                {
                    SQL_DB.ExecuteNonQuery("update m_consumer set remark='" + TextRemark.Text + "', VRKbl_KYC_status='" + KycStatus.Text + "'  where M_Consumerid='" + HiddenM_ConID.Value + "'");
                }
                else
                {
                    SQL_DB.ExecuteNonQuery("update m_consumer set remark='" + TextRemark.Text + "', VRKbl_KYC_status='" + KycStatus.Text + "'  where M_Consumerid='" + HiddenM_ConID.Value + "'");
                }
                string stsKyc = "";
                if (KycStatus.Text == "1")
                {
                    stsKyc = "Approved";
                    txtKYC.Text = "Approved";
                    string code1 = "";
                    string code2 = "";
                    string mob = txtMobile.Text;
                    DataTable dtcode = new DataTable();
                    string pro_id = "";
                    if (Session["CompanyId"].ToString() == "Comp-1567")
                    {
                        pro_id = "AJ87";
                        dtcode = SQL_DB.ExecuteDataTable("select top 1 Code1,Code2 from M_code where Pro_ID='AJ87' and Use_Count is null");
                    }
                    else if (Session["CompanyId"].ToString() == "Comp-1650")
                    {
                        pro_id = "AL90";
                        dtcode = SQL_DB.ExecuteDataTable("select top 1 Code1,Code2 from M_code where Pro_ID='AL90' and Use_Count is null");
                    }
                    
                    if (dtcode.Rows.Count > 0)
                    {
                        code1 = dtcode.Rows[0]["Code1"].ToString();
                        code2 = dtcode.Rows[0]["Code2"].ToString();
                    }
                    

                    SqlCommand cmd = new SqlCommand("CheckCodeCountkyc", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@mobileno", mob);
                    cmd.Parameters.AddWithValue("@pro_id", pro_id);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable countcd = new DataTable();
                    da.Fill(countcd);

                    if (countcd.Rows.Count > 0)
                    {

                    }
                    else
                    {
                        if (Session["CompanyId"].ToString() == "Comp-1567" || Session["CompanyId"].ToString() == "Comp-1650")
                        {
                            getpdtlsAsync(code1, code2, mob);
                        }
                          
                    }
                }
                else
                {
                    stsKyc = "Rejected";
                    txtKYC.Text = "Rejected";
                    NewMsgpop.Attributes.Add("style", "background-color:Red");
                }

                if (KycStatus.Text == "1")
                {
                    KycStatus.Text = "Approved";
                }
                else
                {
                    KycStatus.Text = "Rejected";

                    NewMsgpop.Attributes.Add("style", "background-color:Red");
                }

                NewMsgpop.Visible = true;
                LblMsgUpdate.Text = "KYC " + stsKyc + " Successfully!";
            }
        }
        else
        {
            NewMsgpop.Visible = true;
            LblMsgUpdate.Text = "Please select KYC Status!";
            LblMsgUpdate.ForeColor = System.Drawing.Color.Red;
        }

    }

    //public async Task getpdtlsAsync(string code1, string code2, string mobileno)
    //{
    //    var options = new RestClientOptions("http://localhost:58566")
    //    {
    //        MaxTimeout = -1,
    //    };
    //    var client = new RestClient(options);
    //    var request = new RestRequest("/Info/MasterHandler.ashx?method=verifyotp&mobile=" + mobileno + "&vCode=" + code1 + "-" + code2 + "&UPI=KYC", Method.Get);
    //    request.AddHeader("Cookie", "ASP.NET_SessionId=ulpq2lkvmazbtfnpidrybuve");
    //    RestResponse response = await client.ExecuteAsync(request);
    //    Console.WriteLine(response.Content);
    //}

    public async Task getkycpointAsync(string code1, string code2, string mobileno)
    {
       


        string URL = String.Format("https://www.vcqru.com/Info/MasterHandler.ashx?method=verifyotp&mobile=" + mobileno + "&vCode=" + code1 + "-" + code2 + "&UPI=KYC"); ////////Running API//////////
                                                                                                                                                                                                                                      // string URL = String.Format("http://sms.alfasms.in/sendSMS?username=vcqru1&message=" + sMessage + "&sendername=wecqru&smstype=TRANS&numbers=" + sPhoneNo + "&apikey=3625aac6-eed4-4606-9e1e-65dbb39311fc"); ///////////testing APi/////////
        HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(URL);
        myReq.Method = "GET";
        HttpWebResponse Webresponse = (HttpWebResponse)myReq.GetResponse();
        Stream rstream = Webresponse.GetResponseStream();
        StreamReader reader = new StreamReader(rstream, Encoding.UTF8);
       string sResponse = reader.ReadToEnd();
        reader.Close();


    }

    public async Task getpdtlsAsync(string code1, string code2, string mobileno)
    {
      
        string URL = String.Format("https://www.vcqru.com/Info/MasterHandler.ashx?method=verifyotp&mobile=" + mobileno + "&vCode=" + code1 + "-" + code2 + "&UPI=KYC"); ////////Running API//////////
                                                                                                                                                                                  // string URL = String.Format("http://sms.alfasms.in/sendSMS?username=vcqru1&message=" + sMessage + "&sendername=wecqru&smstype=TRANS&numbers=" + sPhoneNo + "&apikey=3625aac6-eed4-4606-9e1e-65dbb39311fc"); ///////////testing APi/////////
        HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(URL);
        myReq.Method = "GET";
        HttpWebResponse Webresponse = (HttpWebResponse)myReq.GetResponse();
        Stream rstream = Webresponse.GetResponseStream();
        StreamReader reader = new StreamReader(rstream, Encoding.UTF8);
        string sResponse = reader.ReadToEnd();
        reader.Close();

    }

    protected void btnupdatewstate_Click(object sender, EventArgs e)
    {
        if (ddlstate.SelectedItem.Text != "--Select State--")
        {
            string selectedValue = ddlstate.SelectedItem.Value;
            if (!string.IsNullOrEmpty(selectedValue))
            {
                SQL_DB.ExecuteNonQuery("Update M_consumer set Shop_address='" + selectedValue + "' where M_Consumerid='" + HiddenM_ConID.Value + "'");
                NewMsgpop.Visible = true;
                LblMsgUpdate.Text = "WorkPlace State Updated Successfully!";
            }
            else
            {
                LblMsgUpdate.Text = "Please select a value from the dropdown.";
            }
        }
        else
        {
            LblMsgUpdate.Text = "Please select a value from the dropdown.";
        }
    }
    public void binddropdown()
    {
        DataTable dtstate = SQL_DB.ExecuteDataTable("select State_Id,StateName from StateMaster");
        ddlstate.DataSource = dtstate;
        ddlstate.DataTextField = "StateName";
        ddlstate.DataValueField = "StateName";
        ddlstate.DataBind();
    }
    public void bindcomp(string MId)
    {
        // DataTable dtcompany = SQL_DB.ExecuteDataTable("Select comp_id from M_Consumer where M_Consumerid='"+ MId + "'");
        DataTable dtcompany = SQL_DB.ExecuteDataTable("SELECT comp_id,CASE WHEN comp_id = 'Comp-1567' THEN 'Silicone Concepts' WHEN comp_id = 'Comp-1650' THEN 'Akemi Technology' ELSE 'Unknown'END AS Comp_Name FROM M_Consumer WHERE M_Consumerid = '" + MId + "'");
        if (dtcompany.Rows.Count > 0)
        {
            ddlcompany.DataSource = dtcompany;
            ddlcompany.DataTextField = "Comp_Name";
            ddlcompany.DataValueField = "Comp_ID";
            ddlcompany.DataBind();
            ddlcompany.Enabled = false;
        }
    }
    public void bindallcomp()
    {
        DataTable dtcompany = SQL_DB.ExecuteDataTable("SELECT Comp_Name,Comp_ID FROM Comp_Reg WHERE Comp_ID IN ('Comp-1567', 'Comp-1650')");
        if (dtcompany.Rows.Count > 0)
        {
            ddlcompany.DataSource = dtcompany;
            ddlcompany.DataTextField = "Comp_Name";
            ddlcompany.DataValueField = "Comp_ID";
            ddlcompany.DataBind();
        }

        btnComp.Text = "Update";
    }



    protected void btnComp_Click(object sender, EventArgs e)
    {
        if (btnComp.Text == "Update")
        {
            string Selectedcompid = ddlcompany.SelectedValue;
            if (Selectedcompid == "Comp-1567" || Selectedcompid == "Comp-1650")
            {
                SQL_DB.ExecuteNonQuery("Update M_consumer set comp_id='" + Selectedcompid + "' where M_Consumerid='" + HiddenM_ConID.Value + "' ");
            }
        }
        else
        {
            bindallcomp();
            ddlcompany.Enabled = true;
        }

    }
}