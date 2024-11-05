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
using System.Web.Services;
using System.Web.Script.Services;
using System.IO;
using Business_Logic_Layer;

public partial class Dealer_MyProfile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/default.aspx#logsign");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/default.aspx#logsign");
        }
        if (!IsPostBack)
        {
            btnUpDate.Text = "Edit";
            btnUpDate.ValidationGroup = "chk941";
            EdittxtGray();
            FillUpDateProfile();
            NewMsgpop.Visible = false;
        }
    }
    private void ChkOpen()
    {
        Object9420 obj = new Object9420();
        obj.Comp_ID = Session["CompanyId"].ToString();
        DataSet ds = function9420.CheckStatusForMan(obj);
        if (ds.Tables[0].Rows.Count > 0)
        {
            if (ds.Tables[0].Rows[0]["Comp_Type"] == "D")
                Response.Redirect("Message.aspx");
        }
    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewProduct(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [M_Consumer] FROM [Email] where [Comp_Email] = '" + res + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    private void FillUpDateProfile()
    {
        allClear();
        User_Details Reg = new User_Details();
        Reg.User_ID = ProjectSession.strDealerUserID; //Session["DealerUSRID"].ToString();
        //User_Details.FillUpDateProfile(Reg);
        DataTable ddt = SQL_DB.ExecuteDataSet("SELECT * FROM Dealer WHERE Dealerid = '" + Reg.User_ID + "' and isnull(active,0) = 1 and isnull([delete],0) = 0 ").Tables[0];
        if (ddt.Rows.Count > 0)
        {
            try
            {
                Reg.User_ID = ddt.Rows[0]["DealerID"].ToString();
                Reg.ConsumerName = ddt.Rows[0]["name"].ToString();
                Reg.Email = ddt.Rows[0]["Email"].ToString();
                Reg.MobileNo = ddt.Rows[0]["MobileNo"].ToString();
                Reg.City = ddt.Rows[0]["Location"].ToString(); ;
                Reg.PinCode = ddt.Rows[0]["PinCode"].ToString();
                Reg.Address = ddt.Rows[0]["Address"].ToString();
                Reg.Password = ddt.Rows[0]["pwd"].ToString();
                Reg.User_Type = ddt.Rows[0]["Type"].ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        txtEmail.Text = Reg.Email; txtEmail.Enabled = false;
        txtPersonName.Text = Reg.ConsumerName; txtAddress.Text = Reg.Address;
        txtMob.Text = Reg.MobileNo; ddlCity.Text = Reg.City; txtpincode.Text = Reg.PinCode;
    }
    private bool ChkVerDoc(Object9420 Reg)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("select * from Comp_Doc_Flag WHERE Comp_ID = '" + Reg.Comp_ID + "' AND Flag = 1");
        if (ds.Tables[0].Rows.Count > 0)
        {
            if (ds.Tables[0].Rows.Count == 6)
                return true;
            else
                return false;
        }
        else
            return false;
    }
    private void EdittxtGray()
    {
        txtEmail.Enabled = false; txtEmail.Enabled = false; txtAddress.Enabled = false;
        ddlCity.Enabled = false;
        txtPersonName.Enabled = false;
        txtMob.Enabled = false;
        txtpincode.Enabled = false; ddlCity.Enabled = false;
    }
    private void EdittxtGrayToEdit()
    {
        txtEmail.Enabled = true; txtEmail.Enabled = true;
        ddlCity.Enabled = true; ddlCity.Enabled = true;
        txtPersonName.Enabled = true; txtAddress.Enabled = true;
        txtMob.Enabled = false; txtpincode.Enabled = true;

    }
    protected void btnUpDate_Click(object sender, EventArgs e)
    {
        if (btnUpDate.Text == "Update")
        {
            if (txtEmail.Text != "")
            {
                DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [Dealer] where [Email] = '" + txtEmail.Text.Trim().Replace("'", "''") + "' AND Dealerid <> '" + ProjectSession.strDealerUserID + "' ");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    NewMsgpop.Visible = true;
                    NewMsgpop.Attributes.Add("class", "alert_boxes_pink");
                    LblMsgUpdate.Text = "Email ID Already exist!";
                    string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                    return;
                }
            }
            //DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT [MobileNo] FROM [M_Consumer] where [MobileNo] = '" + txtMob.Text.Trim().Replace("'", "''") + "'  AND User_ID <> '" + Session["USRID"] + "' ");
            //if (ds1.Tables[0].Rows.Count > 0)
            //{
            //    NewMsgpop.Visible = true;
            //    LblMsgUpdate.Text = "Mobile No. Already exist!";
            //    return;
            //}
            User_Details Log = new User_Details();
            Log.User_ID = Session["USRID"].ToString();
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            Log.ConsumerName = txtPersonName.Text.Trim().Replace("'", "''");
            Log.Email = txtEmail.Text.Trim().Replace("'", "''");
            Log.MobileNo = txtMob.Text.Trim().Replace("'", "''");
            Log.City = ddlCity.Text.Trim().Replace("'", "''");
            Log.PinCode = txtpincode.Text.Trim().Replace("'", "''");
            //Log.Password = txtpincode.Text.Trim().Replace("'", "''");
            Log.IsActive = 0;
            Log.IsDelete = 0;
            Log.Address = txtAddress.Text.Trim().Replace("'", "''");
            Log.DML = "U";
            //ExecuteNonQueryAndDatatable.InsertDealerDetails(Log); // incomplete update and insert
            allClear();
            FillUpDateProfile();
            NewMsgpop.Visible = true;
            LblMsgUpdate.Text = "Profile updated successfully.";
            btnUpDate.Text = "Edit";
            EdittxtGray();
        }
        else
        {
            NewMsgpop.Visible = false;
            EdittxtGrayToEdit();
            btnUpDate.ValidationGroup = "chk94";
            btnUpDate.Text = "Update";
            btnNextDoc.Visible = false;
        }
    }
    private void SoundFileVerification(Object9420 Log, string path)
    {
        if (!File.Exists(path))
        {
            Log.DML = "I";
            Log.Doc_Id = Log.Comp_ID.ToString().Substring(5, 4) + "_Sound";
            Log.DocFlag = 0;
            function9420.UpdateDocForVerification(Log);
        }
    }
    private void allClear()
    {
        txtEmail.Text = string.Empty;
        ddlCity.Text = string.Empty;
        txtPersonName.Text = string.Empty;
        txtMob.Text = string.Empty;
        txtAddress.Text = string.Empty;
    }
    protected void btnNextDoc_Click(object sender, EventArgs e)
    {
        if (btnUpDate.Text == "Edit")
            Response.Redirect("frmUploadDocuments.aspx");
    }
}