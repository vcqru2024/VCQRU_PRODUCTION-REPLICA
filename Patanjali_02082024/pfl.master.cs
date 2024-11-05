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


        DataTable dt = new DataTable();
        if (Session["UserRole_id"] != null)
        {
            dt = SQL_DB.ExecuteDataTable("SELECT * FROM MenuItem_PfL m INNER JOIN tbl_pflUsercontrol ma ON m.MenuItemID= ma.MenuId WHERE UserRole_Id='" + Session["UserRole_id"].ToString() + "' and RefMenu<>0 order by MenuId asc");
        }
        else
        {
            dt = SQL_DB.ExecuteDataTable("SELECT * FROM MenuItem_PfL m INNER JOIN tblMenuAuthendication ma ON m.MenuItemID= ma.MenuId WHERE Comp_Id='" + Session["Comp_id"] + "' and RefMenu<>0 order by MenuId asc");
        }



        // Special user check
        if (Session["Comp_Email"].ToString() == "uatpatnjali@gmail.com")
        {
            lblcompname.InnerHtml = Session["Comp_name"].ToString();
            divprofile.Visible = true;
            DivUser.Visible = false;
            SetAllElementsVisible(true);
        }
        else
        {
            DataTable dtUser = db.GetRegisteredUserData("USP_PFLGETUserROLEData", Convert.ToInt32(Session["UserRole_id"]));
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
                    #region To Improve 
                    /*
                    switch (columnName)
                    {
                        case "Dashboard":
                            DashboardDiv.Visible = isVisible;
                            break;
                        case "Users":
                            divUsers.Visible = isVisible;
                            break;
                        case "Consumer Report":
                            lireports.Visible = isVisible;
                            break;
                        case "Code Duplicity Report":
                            rptConsumer.Visible = isVisible;
                            break;
                        case "State Wise Status":
                            codescanning.Visible = isVisible;
                            break;
                        case "Product Wise Status":
                            statestatus.Visible = isVisible;
                            break;
                        case "Mobile Number Wise Status":
                            productstatus.Visible = isVisible;
                            break;
                        case "Code Wise Status Count":
                            MobileStatus.Visible = isVisible;
                            break;
                        case "Mothly code usage and user analysis":
                            Companystatus.Visible = isVisible;
                            break;
                        case "Consumer Product History":
                            usercode.Visible = isVisible;
                            break;
                        case "Code Status":
                            producthistory.Visible = isVisible;
                            break;
                        case "Enquiry Details":
                            codestatus.Visible = isVisible;
                            break;
                        case "Product Registration":
                            enqreport.Visible = isVisible;
                            break;
                        case "Assign Labels to Product":
                            codeverification.Visible = isVisible;
                            break;
                        case "Service Subscription":
                            ClickedReport.Visible = isVisible;
                            break;
                        case "Service Setting":
                            liproductparticular.Visible = isVisible;
                            break;
                        case "Scrap Summary Report":
                            liproductregistration.Visible = isVisible;
                            break;
                        case "Scrap Label Entry":
                            liassignlabel.Visible = isVisible;
                            break;
                        case "Request For Print Labels":
                            liOurservice.Visible = isVisible;
                            break;
                        case "Label Receive":
                            liservicesubscription.Visible = isVisible;
                            break;
                        case "Add Label Request":
                            liserviceSetting.Visible = isVisible;
                            break;
                        case "Code Verification":
                            liScrapParticulars.Visible = isVisible;
                            break;
                        case "Product Click tracking Report":
                            liscrapsummary.Visible = isVisible;
                            break;
                        case "Invalid Code Details":
                            liscraplabelentry.Visible = isVisible;
                            break;
                        case "Assign New Batch No":
                            liLabelSection.Visible = isVisible;
                            break;
                        case "Company Profile":
                            Companyprofilesec.Visible = isVisible;
                            break;
                        default:
                            break;
                    }
                    */
                    #endregion
                    switch (columnName)
                    {
                        case "Dashboard":
                            DashboardDiv.Visible = isVisible;
                            break;
                        case "Users":
                            divUsers.Visible = isVisible;
                            break;
                        case "Consumer Report":
                            rptConsumer.Visible = isVisible;
                            break;
                        case "Code Duplicity Report":
                            codescanning.Visible = isVisible;
                            break;
                        case "State Wise Status":
                            statestatus.Visible = isVisible;
                            break;
                        case "Product Wise Status":
                            productstatus.Visible = isVisible;
                            break;
                        case "Mobile Number Wise Status":
                            MobileStatus.Visible = isVisible;
                            break;
                        case "Code Wise Status Count":
                            Companystatus.Visible = isVisible;
                            break;
                        case "Mothly code usage and user analysis":
                            usercode.Visible = isVisible;
                            break;
                        case "Consumer Product History":
                            producthistory.Visible = isVisible;
                            break;
                        case "Code Status":
                            codestatus.Visible = isVisible;
                            break;
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
                        //case "Add Label Request":
                        //    liserviceSetting.Visible = isVisible;
                        //    break;
                        case "Code Verification":
                            codeverification.Visible = isVisible;
                            break;
                        case "Product Click tracking Report":
                            ClickedReport.Visible = isVisible;
                            break;
                        case "Invalid Code Details":
                            InvalidCodeReport.Visible = isVisible;
                            break;
                        case "Assign New Batch No":
                            SearchCodeDetails.Visible = isVisible;
                            break;
                        case "Company Profile":
                            Companyprofilesec.Visible = isVisible;
                            break;
                        case "User Enquiry Report":
                            divuserenqrpt.Visible = isVisible;
                            break;
                        default:
                            break;
                    }
                }
            }


if (codeverification.Visible == false && enqreport.Visible == false && InvalidCodeReport.Visible == false && rptConsumer.Visible == false && codescanning.Visible == false && statestatus.Visible == false && productstatus.Visible == false && MobileStatus.Visible == false && Companystatus.Visible == false && usercode.Visible == false && producthistory.Visible == false && codestatus.Visible == false && ClickedReport.Visible == false && divuserenqrpt.Visible == false)
                lireports.Visible = false;
             if (liproductregistration.Visible == false && liassignlabel.Visible == false && SearchCodeDetails.Visible == false)
                liproductparticular.Visible = false;
             if (liservicesubscription.Visible == false && liserviceSetting.Visible == false)
                liOurservice.Visible = false;
             if (liRequestForPrintLabels.Visible == false && liLabelReceive.Visible == false)
                liLabelSection.Visible = false;
             if (liscrapsummary.Visible == false && liscraplabelentry.Visible == false)
                liScrapParticulars.Visible = false;
        }

    }

    public void SetAllElementsVisible(bool isVisible)
    {
        DashboardDiv.Visible = divUsers.Visible = lireports.Visible = rptConsumer.Visible = codescanning.Visible =
            statestatus.Visible = productstatus.Visible = MobileStatus.Visible = Companystatus.Visible = usercode.Visible =
            producthistory.Visible = codestatus.Visible = enqreport.Visible = codeverification.Visible = ClickedReport.Visible =
            liproductparticular.Visible = liproductregistration.Visible = liassignlabel.Visible = liOurservice.Visible =
            liservicesubscription.Visible = liserviceSetting.Visible = liScrapParticulars.Visible = liscrapsummary.Visible =
            liscraplabelentry.Visible = liLabelSection.Visible = liRequestForPrintLabels.Visible = liLabelReceive.Visible =
           /* liAddLabelRequest.Visible =*/ isVisible;
    }

    protected void btnlogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("../Patanjali/loginpfl.aspx");
    }
}
