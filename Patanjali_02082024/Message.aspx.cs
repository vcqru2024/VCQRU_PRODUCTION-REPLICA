using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Business9420;
using System.IO;

public partial class Messageshow : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] != null)
        {
            if (!IsPostBack)
                CheckUserDetail();
        }
        else
            Response.Redirect("Index.aspx");
    }

    private void CheckUserDetail()
    {
        Object9420 Log = new Business9420.Object9420();
        Log.Comp_Email = Session["CompanyId"].ToString();
        DataSet dsPass = SQL_DB.ExecuteDataSet("SELECT [Comp_ID],[Comp_Email],[Comp_Name],[Comp_type],[Status],[Delete_Flag] FROM [Comp_Reg] where [Comp_ID] = '" + Log.Comp_Email + "' and [Email_Vari_Flag] = '1'");
        if (dsPass.Tables[0].Rows.Count > 0)        {
            
            string path = Server.MapPath("../Data/Sound");
            path = path + "\\" + dsPass.Tables[0].Rows[0]["Comp_ID"].ToString().Substring(5, 4);
            DataProvider.Utility.CreateDirectory(path);
            path = path + "\\" + dsPass.Tables[0].Rows[0]["Comp_ID"].ToString().Substring(5, 4) + ".wav";
            int docflag = Convert.ToInt32(function9420.GetUploadDocStatus(Log));
            int Verdocflag = Convert.ToInt32(function9420.VerifyDocStatus(Log));
            int statusflag = Convert.ToInt32(dsPass.Tables[0].Rows[0]["Status"]);
            int delflag = Convert.ToInt32(dsPass.Tables[0].Rows[0]["Delete_Flag"]);
            if ((dsPass.Tables[0].Rows[0]["Comp_type"].ToString() == "L") && (delflag == 1))
            {
                if (!File.Exists(path))
                    //Session["MyNewMessage"] = "Your account is in-active, please <a href='CompProfile.aspx' style='color:blue;'> update your profile </a> & <a href='CompDocument.aspx' style='color:blue;'> upload required documents</a>. If already done , please wait for activation from ADMIN.";
                    Session["MyNewMessage"] = "Your account is in-active, please <a href='CompProfile.aspx' style='color:blue;'> update your profile </a> & <a href='frmUploadDocuments.aspx' style='color:blue;'> upload required documents</a>. If already done , please wait for activation from ADMIN.";
                else if ((File.Exists(path)) && (docflag == 0))
                {
                    if (!chkDoc(Session["CompanyId"].ToString()))
                        //Session["MyNewMessage"] = "Your account is in-active, please <a href='CompProfile.aspx' style='color:blue;'> update your profile </a> & <a href='CompDocument.aspx' style='color:blue;'> upload required documents</a>. If already done , please wait for activation from ADMIN.";
                        Session["MyNewMessage"] = "Your account is in-active, please <a href='CompProfile.aspx' style='color:blue;'> update your profile </a> & <a href='frmUploadDocuments.aspx' style='color:blue;'> upload required documents</a>. If already done , please wait for activation from ADMIN.";
                    else
                        //Session["MyNewMessage"] = "Your account is in-active, please <a href='CompProfile.aspx' style='color:blue;'> update your profile </a> & <a href='CompDocument.aspx' style='color:blue;'> upload required documents</a>. If already done , please wait for activation from ADMIN.";
                        Session["MyNewMessage"] = "Your account is in-active, please <a href='CompProfile.aspx' style='color:blue;'> update your profile </a> & <a href='frmUploadDocuments.aspx' style='color:blue;'> upload required documents</a>. If already done , please wait for activation from ADMIN.";
                }
                else if ((File.Exists(path)) && (docflag == 1) && (Verdocflag != 7))
                    Session["MyNewMessage"] = "Your account is in-active, please contact to admin.";
                else if ((File.Exists(path)) && (docflag == 1) && (Verdocflag == 7) && (statusflag == 0))
                    Session["MyNewMessage"] = "Your account is in-active, please contact to admin.";
            }
            else if ((dsPass.Tables[0].Rows[0]["Comp_type"].ToString() == "L") && (delflag == 0))
            {
                Response.Redirect("../Index.aspx?Del=Del");
                return;
            }
            else
            {
                if (delflag == 1)
                {
                    if (!File.Exists(path))
                        Session["MyNewMessage"] = "Your account has been registered as demo user please <a href='UpDateCompanyProfileDemo.aspx' style='color=blue;'>update your profile</a>";
                    else if ((File.Exists(path)) && (statusflag == 0))
                        Session["MyNewMessage"] = "Your account is in-active, please contact to admin.";
                    else
                        Session["MyNewMessage"] = "You are registered as demo user.";
                }
                else
                {
                    Response.Redirect("../Index.aspx?Del=Del");
                    return;
                }
            }
        }
        
    }   
    private bool chkDoc(string p)
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = p;
        DataSet ds = function9420.ChkUploadDocFlag(Reg);
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
}
