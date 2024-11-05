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
public partial class Employee_UpdateProfile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Session["USRID"] == null)
        //    Response.Redirect("../Home/Index.aspx?Page=UpdateProfile.aspx");
        //else
        //{
        //    if (Session["User_Type"].ToString() == "Admin")
        //        Response.Redirect("../Login.aspx");
        //}
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
        Reg.Email = ProjectSession.strEmployeeEmail;
        // User_Details.FillUpDateProfile(Reg);
        DataTable dt = SQL_DB.ExecuteDataSet("SELECT * FROM Employee WHERE Email = '" + Reg.Email + "'").Tables[0];
        Reg.EmployeeID = Convert.ToInt32(dt.Rows[0]["EmployeeID"].ToString());
        ProjectSession.Empid = Reg.EmployeeID;
        ddlEmployee.SelectedValue = Convert.ToString(dt.Rows[0]["Emp_type"].ToString());
        txtPersonName.Text  = Convert.ToString(dt.Rows[0]["name"].ToString());
        txtAddress.Text = Convert.ToString(dt.Rows[0]["address"].ToString());
        txtEmail.Text = Convert.ToString(dt.Rows[0]["email"].ToString());
        txtEmail.Enabled = false;
        txtMob.Text =  Convert.ToString(dt.Rows[0]["mobileno"].ToString());
       ddlCity.Text = Convert.ToString(dt.Rows[0]["city"].ToString());
        txtpincode.Text = Convert.ToString(dt.Rows[0]["pincode"].ToString());

        // txtEmail.Text = Reg.Email; txtEmail.Enabled = false;
        //txtPersonName.Text = Reg.ConsumerName; txtAddress.Text = Reg.Address;
        //txtMob.Text = Reg.MobileNo; ddlCity.Text = Reg.City; txtpincode.Text = Reg.PinCode;
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
        ddlEmployee.Enabled = false;
        txtEmail.Enabled = false;
        txtAddress.Enabled = false;
        ddlCity.Enabled = false;
        txtPersonName.Enabled = false;
        txtMob.Enabled = false;
        txtpincode.Enabled = false;
        ddlCity.Enabled = false;
    }
    private void EdittxtGrayToEdit()
    {
        txtEmail.Enabled = false; 
        ddlCity.Enabled = true; ddlCity.Enabled = true;
        txtPersonName.Enabled = true; txtAddress.Enabled = true;
        txtMob.Enabled = true; txtpincode.Enabled = true;

    }
    protected void btnUpDate_Click(object sender, EventArgs e)
    {
        if (btnUpDate.Text == "Update")
        {
            if (txtEmail.Text != "")
            {
                DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [Employee] where [Email] = '" + txtEmail.Text.Trim().Replace("'", "''") +
                    "' AND EmployeeID <> '" + Session["empid"] + "' ");
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
            Log.EmployeeType = Convert.ToInt16(ddlEmployee.SelectedItem.Value);
            Log.EmployeeID = Convert.ToInt32(Session["empid"].ToString());
            Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            Log.ConsumerName = txtPersonName.Text.Trim().Replace("'", "''");
            Log.Email = txtEmail.Text.Trim().Replace("'", "''");
            Log.MobileNo = txtMob.Text.Trim().Replace("'", "''");
            Log.City = ddlCity.Text.Trim().Replace("'", "''");
            Log.PinCode = txtpincode.Text.Trim().Replace("'", "''");
            //Log.Password = txtpincode.Text.Trim().Replace("'", "''");
            Log.IsActive = 1;
            Log.IsDelete = 0;
            Log.Address = txtAddress.Text.Trim().Replace("'", "''");
            Log.DML = "U";
            Log.CreatedBy = Log.EmployeeID;
            // User_Details.InsertUpdateUserDetails(Log);
            ExecuteNonQueryAndDatatable.InsertEmployeeDetails(Log);
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
        txtpincode.Text = "";
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