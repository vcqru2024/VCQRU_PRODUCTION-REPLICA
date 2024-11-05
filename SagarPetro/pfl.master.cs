using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_pfl : System.Web.UI.MasterPage
{
    cls_patanjali db = new cls_patanjali();
    protected void Page_Load(object sender, EventArgs e)
    {
        // DataTable dtcomplogo = db.SelectCompLogo("USP_GetCompLogoPath", Session["Comp_id"].ToString());
        DataTable dtcomplogo = SQL_DB.ExecuteDataTable("exec USP_GetCompLogoPath '" + Session["Comp_id"].ToString() + "'");
        if (dtcomplogo.Rows.Count > 0)
        {
            string baseUrl = ProjectSession.absoluteSiteBrowseUrl;
            string imagePath = dtcomplogo.Rows[0][0].ToString();
            Uri baseUrlUri = new Uri(baseUrl);
            Uri imagePathUri = new Uri(baseUrlUri, imagePath);
            string absoluteUrl = imagePathUri.AbsoluteUri;
            string cleanedUrl = absoluteUrl.Replace("~/", "");
            imgLogo.ImageUrl = cleanedUrl;
        }

        DataTable dt = new DataTable();
        if (Session["UserRole_id"] != null)
        {
            Li1.Visible = false;
            dt = SQL_DB.ExecuteDataTable("SELECT * FROM MenuItem_Sagar_petro m INNER JOIN tbl_SagarPetro_Usercontrol ma ON m.MenuItemID= ma.MenuId WHERE UserRole_Id='" + Session["UserRole_id"].ToString() + "' and RefMenu<>0 order by MenuId asc");
        }
        else
        {
            dt = SQL_DB.ExecuteDataTable("SELECT * FROM MenuItem_PfL m INNER JOIN tblMenuAuthendication ma ON m.MenuItemID= ma.MenuId WHERE Comp_Id='" + Session["Comp_id"] + "' and RefMenu<>0 order by MenuId asc");
        }
        bindcash();



        // Special user check
        if (Session["UserRole_id"] == null)
        {
            lblcompname.InnerHtml = Session["Comp_name"].ToString();
            divprofile.Visible = true;
            DivUser.Visible = false;
            SetAllElementsVisible(true);
        }
        else
        {
            DataTable dtUser = db.GetRegisteredUserData("USP_SagarnewGETUserROLEData", Convert.ToInt32(Session["UserRole_id"]));
            if (dtUser.Rows.Count > 0)
            {
                lblUserName.InnerText = dtUser.Rows[0]["UserName"].ToString();
                lblUserName.Style["color"] = "green !important";
            }
            divprofile.Visible = false;
            DivUser.Visible = true;
            foreach (DataRow row in dt.Rows)
            {
                string columnName = row["MenuItemName"].ToString();
                if (Session[columnName] != null)
                {
                    bool isVisible = Convert.ToBoolean(Session[columnName].ToString());

                    switch (columnName)
                    {
                        case "Dashboard":
                            DashboardDiv.Visible = isVisible;
                            break;
                        case "Users Details":
                            divUsers.Visible = isVisible;
                            break;
                        case "Add Loyalty Gift":
                            divloyalitity.Visible = isVisible;
                            break;
                        case "Users KYC":
                            divuserkyc.Visible = isVisible;
                            break;
                        //case "Consumer Report":
                        //    rptConsumer.Visible = isVisible;
                        //    break;
                        //case "Code Duplicity Report":
                        //    codescanning.Visible = isVisible;
                        //    break;
                        //case "State Wise Status":
                        //    statestatus.Visible = isVisible;
                        //    break;
                        //case "Product Wise Status":
                        //    productstatus.Visible = isVisible;
                        //    break;
                        //case "Mobile Number Wise Status":
                        //    MobileStatus.Visible = isVisible;
                        //    break;
                        //case "Code Wise Status Count":
                        //    Companystatus.Visible = isVisible;
                        //    break;
                        //case "Mothly code usage and user analysis":
                        //    usercode.Visible = isVisible;
                        //    break;
                        //case "Consumer Product History":
                        //    producthistory.Visible = isVisible;
                        //    break;
                        //case "Code Status":
                        //    codestatus.Visible = isVisible;
                        //    break;
                        case "Enquiry Details":
                            enqreport.Visible = isVisible;
                            break;
                        case "Product Registration":
                            liproductregistration.Visible = isVisible;
                            break;
                        case "Assign Labels to Product":
                            liassignlabel.Visible = isVisible;
                            break;
                        case "Service Subscription":
                            liservicesubscription.Visible = isVisible;
                            break;
                        case "Service Setting":
                            liserviceSetting.Visible = isVisible;
                            break;
                        case "Scrap Summary Report":
                            liscrapsummary.Visible = isVisible;
                            break;
                        case "Scrap Label Entry":
                            liscraplabelentry.Visible = isVisible;
                            break;
                        case "Request For Print Labels":
                            liRequestForPrintLabels.Visible = isVisible;
                            break;
                        case "Label Receive":
                            liLabelReceive.Visible = isVisible;
                            break;

                        case "Code Verification":
                            codeverification.Visible = isVisible;
                            break;
                        //case "Product Click tracking Report":
                        //    ClickedReport.Visible = false;
                        //    break;
                        //case "Invalid Code Details":
                        //    InvalidCodeReport.Visible = isVisible;
                        //    break;
                        case "Assign New Batch No":
                            SearchCodeDetails.Visible = isVisible;
                            break;
                        case "Users Count":
                            usercounts.Visible = isVisible;
                            break;
                        case "Loyalty Claim":
                            loyalityclaim.Visible = isVisible;
                            break;
                        case "Points earned against product":
                            productwisepoint.Visible = isVisible;
                            break;
                        //case "User Score Details":
                        //    Scoredetails.Visible = isVisible;
                        //    break;
                        case "User Wise Score Details":
                            UserviewScoredetails.Visible = isVisible;
                            break;
                        case "Transaction Summery":
                            transactionsummery.Visible = isVisible;
                            break;
                        case "Transaction Details":
                            transactiondetails.Visible = isVisible;
                            break;
                        case "Instant Payout Details":
                            instantpayout.Visible = isVisible;
                            break;
                        case "Month Wise Data":
                            monthwisereport.Visible = isVisible;
                            break;
                        case "Connected People":
                            LiConnectedpeople.Visible = isVisible;
                            break;
                        case "Code Status":
                            codedetails.Visible = isVisible;
                            break;
                        case "Redeemtion":
                            redeemtionrpt.Visible = isVisible;
                            break;
                        case "Cash Claim Details":
                            liuserclaimcash.Visible = isVisible;
                            break;
                        //case "Company Profile":
                        //    Li1.Visible = isVisible;
                        //    break;
                        default:
                            break;
                    }
                }
            }
        }

    }

    public void bindcash()
    {
        CashBalanceAmount.Text = SQL_DB.ExecuteScalar("select Amount as Balance  from Paytm_balance where  Comp_ID = '" + Session["CompanyId"].ToString() + "'").ToString();
        Showcashbalance.Visible = true;
    }

    public void SetAllElementsVisible(bool isVisible)
    {
        DashboardDiv.Visible = divUsers.Visible = lireports.Visible
             = enqreport.Visible = codeverification.Visible =
            liproductparticular.Visible = liproductregistration.Visible = liassignlabel.Visible = 
            liservicesubscription.Visible = liserviceSetting.Visible = liScrapParticulars.Visible = liscrapsummary.Visible =
            liscraplabelentry.Visible = liLabelSection.Visible = liRequestForPrintLabels.Visible = liLabelReceive.Visible =
           /* liAddLabelRequest.Visible =*/ isVisible;
    }

    protected void btnlogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.RemoveAll();
        Session.Abandon();
        Response.Redirect("../SagarPetro/loginpfl.aspx");
    }
}
