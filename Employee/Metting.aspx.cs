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
using EmpMeetingBAL;

public partial class Employee_Metting : System.Web.UI.Page
{
    public int intMeetingVS { get { return Convert.ToInt32(ViewState["intMeetingVS"].ToString()); } set { ViewState["intMeetingVS"] = value; } }
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
            FillDropDown();
            EditMode();

        }
    }
    public void FillDropDown()
    {
        DataTable dt = SQL_DB.ExecuteDataSet("Select * from M_Service where isnull(isactive,1) = 0 and isnull(isdelete,1)=0").Tables[0];
        if (dt.Rows.Count > 0)
        {
            chkbxServices.DataSource = dt;
            chkbxServices.DataBind();
            
        }

        DataTable dt2 = SQL_DB.ExecuteDataSet("Select * from Employee where isnull(active,0) = 1 and isnull(dalete,0)=0 and  Emp_type  !=1  and employeeid not in ( " + ProjectSession.Empid  +")").Tables[0];
        if (dt.Rows.Count > 0)
        {
            ddlEmpSupervisor.DataSource = dt2;
           
            ddlEmpSupervisor.DataTextField = "name";
            ddlEmpSupervisor.DataValueField = "EmployeeID";
            ddlEmpSupervisor.DataBind();
            ddlEmpSupervisor.Items.Insert(0, new ListItem("Select", "0"));

        }

        txtMeetingDate.Text = DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy");
        txtMeetingTime.Text = DataProvider.LocalDateTime.Now.ToString("hh:mm");

    }
    public void EditMode()
    {

        txtFollowUpDate.Style.Add("display", "none");
        txtFollowUpTime.Style.Add("display", "none");
        lblfldt.Style.Add("display", "none");
        lblfltt.Style.Add("display", "none");

        if (Request.QueryString["Mtid"] != null)
        {
            int MeetingID1 = Convert.ToInt32(Request.QueryString["Mtid"].ToString());
            intMeetingVS = MeetingID1;
            lblMeetid.Text = MeetingID1.ToString();
            DataSet ds= Employee_MeetingBAL.Select(MeetingID1);
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                DataTable dtMMasterId = SQL_DB.ExecuteDataTable("Select * from EmployeeMeetingMaster where  Emp_MeetingMasterId = " + dt.Rows[0]["MeetingMasterID"].ToString() );
                if (dtMMasterId.Rows.Count > 0)
                {
                    txtMeetingTitle.Text = dtMMasterId.Rows[0]["Title"].ToString();
                    ddlEmpSupervisor.SelectedValue = dtMMasterId.Rows[0]["EmployeeSupervisor"].ToString();
                    lblMeetMasterid.Text = dt.Rows[0]["MeetingMasterID"].ToString();
                    txtMeetingTitle.Enabled = false;
                    ddlEmpSupervisor.Enabled = false;
                }


                txtVisitStatus.Text = dt.Rows[0]["VisitStatus"].ToString();
                txtCompanyName.Text = dt.Rows[0]["CompanyName"].ToString();
                txtPersonName.Text = dt.Rows[0]["PersonName"].ToString();
                txtEmail.Text = dt.Rows[0]["Email"].ToString();
                txtMobileNo.Text = dt.Rows[0]["MobileNo"].ToString();
                txtMeetingDate.Text = Convert.ToDateTime(dt.Rows[0]["MeetingDate"].ToString()).ToString("dd/MM/yyyy");
                txtMeetingTime.Text = dt.Rows[0]["MeetingTime"].ToString();
                ddlMeetingStatus.SelectedValue = dt.Rows[0]["MeetingStatus"].ToString();
                if (ddlMeetingStatus.SelectedValue == "1")
                {
                   txtFollowUpDate.Text = Convert.ToDateTime(dt.Rows[0]["FollowUpdate"].ToString()).ToString("dd/MM/yyyy");
                    txtFollowUpTime.Text = dt.Rows[0]["FollowupTime"].ToString();
                    txtFollowUpDate.Style.Add("display", "block");
                    txtFollowUpTime.Style.Add("display", "block");
                    lblfldt.Style.Add("display", "block");
                    lblfltt.Style.Add("display", "block");

                }
                else
                {
                    txtFollowUpDate.Style.Add("display", "none");
                    txtFollowUpTime.Style.Add("display", "none");
                    lblfldt.Style.Add("display", "none");
                    lblfltt.Style.Add("display", "none");
                }
                DataTable dtSer = EmpMeeting_ServicesFor.SelectByMeetingid(Convert.ToInt32(lblMeetMasterid.Text)).Tables[0];
                if (dtSer.Rows.Count > 0)
                {
                    for (int i = 0; i < chkbxServices.Items.Count; i++)
                    {
                        for (int k = 0; k < dtSer.Rows.Count; k++)
                        {
                            if (dtSer.Rows[k]["Services"].ToString() == chkbxServices.Items[i].Value)
                                chkbxServices.Items[i].Selected = true;
                        }
                        
                    }
                    //chkbxServices.DataSource = dtSer;
                    //chkbxServices.DataBind();

                }
                DataTable dtCardUplooad = EmpMeeting_CardUpload.SelectByMeetingid(Convert.ToInt32(lblMeetMasterid.Text)).Tables[0];
                if (dtCardUplooad.Rows.Count > 0)
                {
                    LinkButton1.InnerText = dtCardUplooad.Rows[0]["FileUploadOriginalName"].ToString();
                    LinkButton1.HRef = ProjectSession.absoluteSiteBrowseUrl + "EmployeeCardUpload/" + dtCardUplooad.Rows[0]["FileUploadName"].ToString();
                    
                }
                if (dtCardUplooad.Rows.Count > 1)
                {
                    LinkButton2.InnerText = dtCardUplooad.Rows[1]["FileUploadOriginalName"].ToString();
                    LinkButton2.HRef = ProjectSession.absoluteSiteBrowseUrl + "/EmployeeCardUpload/" + dtCardUplooad.Rows[1]["FileUploadName"].ToString();

                }
                if (dtCardUplooad.Rows.Count > 2)
                {
                    LinkButton3.InnerText = dtCardUplooad.Rows[2]["FileUploadOriginalName"].ToString();
                    LinkButton3.HRef = ProjectSession.absoluteSiteBrowseUrl + "/EmployeeCardUpload/" + dtCardUplooad.Rows[2]["FileUploadName"].ToString();

                }
                txtFlUpPersonName.Text = dt.Rows[0]["FollowUpPerson"].ToString();
                txtFlupPersonDesignation.Text = dt.Rows[0]["FollowUpDesignation"].ToString();
                txtFlupPersonEmail.Text = dt.Rows[0]["FollowUpEmail"].ToString();
                txtFlupPersonMobile.Text = dt.Rows[0]["FollowUpMobile"].ToString();
            }
        }
    }
    protected void btnUpDate_Click(object sender, EventArgs e)
    {


        //EmployeeMeetingMaster objEmployeeMeetingMaster = new EmployeeMeetingMaster();
        //if (Request.QueryString["Mtid"] != null)
        //{
        //    objEmployeeMeetingMaster.Emp_MeetingMasterId = Convert.ToInt32(Request.QueryString["Mtid"].ToString());
        //}
        //objEmployeeMeetingMaster.Title = txtMeetingTitle.Text.Replace("'", "''");
        //objEmployeeMeetingMaster.EmployeeSupervisor = Convert.ToInt32(ddlEmpSupervisor.SelectedItem.Value);
        //if (objEmployeeMeetingMaster.Emp_MeetingMasterId > 0)
        //{ objEmployeeMeetingMaster.Update(); }
        //else
        //{
        //    objEmployeeMeetingMaster.Createddate = Convert.ToDateTime(DataProvider.LocalDateTime.Now);
        //    objEmployeeMeetingMaster.Createdby = ProjectSession.Empid;
        //    objEmployeeMeetingMaster.Insert();
        //}

        EmployeeMeetingMaster objEmployeeMeetingMaster = new EmployeeMeetingMaster();

        objEmployeeMeetingMaster.Title = txtMeetingTitle.Text.Replace("'", "''");
        objEmployeeMeetingMaster.EmployeeSupervisor = Convert.ToInt32(ddlEmpSupervisor.SelectedItem.Value);

        Employee_MeetingBAL objEmployee_MeetingBAL = new Employee_MeetingBAL();
        if (Request.QueryString["Mtid"] != null)
        {
            objEmployee_MeetingBAL.MeetingID = Convert.ToInt32(Request.QueryString["Mtid"].ToString());
        }
        if (objEmployee_MeetingBAL.MeetingID == 0)
        {
            objEmployeeMeetingMaster.Createddate = Convert.ToDateTime(DataProvider.LocalDateTime.Now);
            objEmployeeMeetingMaster.Createdby = ProjectSession.Empid;
            objEmployeeMeetingMaster.Insert();
        }
        else
        {
            txtMeetingTitle.Enabled = false;
            objEmployeeMeetingMaster.Emp_MeetingMasterId = Convert.ToInt32(lblMeetMasterid.Text);
            //objEmployeeMeetingMaster.Update();
        }
        objEmployee_MeetingBAL.Employeeid = ProjectSession.Empid;
        objEmployee_MeetingBAL.EmployeeSupervisor = Convert.ToInt32(ddlEmpSupervisor.SelectedItem.Value);
        objEmployee_MeetingBAL.MeetingMasterID = objEmployeeMeetingMaster.Emp_MeetingMasterId;
        objEmployee_MeetingBAL.PersonName = txtPersonName.Text;
        objEmployee_MeetingBAL.CompanyName = txtCompanyName.Text;
        objEmployee_MeetingBAL.Email = txtEmail.Text;
        objEmployee_MeetingBAL.MobileNo = txtMobileNo.Text;
        objEmployee_MeetingBAL.MeetingDate = Convert.ToDateTime(txtMeetingDate.Text);
        objEmployee_MeetingBAL.MeetingTime = txtMeetingTime.Text;
        objEmployee_MeetingBAL.MeetingStatus = Convert.ToInt16(ddlMeetingStatus.SelectedItem.Value);
        if (objEmployee_MeetingBAL.MeetingStatus == 1)
        {
            objEmployee_MeetingBAL.FollowUpdate = Convert.ToDateTime(txtFollowUpDate.Text);
            objEmployee_MeetingBAL.FollowupTime = txtFollowUpTime.Text;
        }
        else
         {
            objEmployee_MeetingBAL.FollowUpdate = null;
        }
        objEmployee_MeetingBAL.VisitStatus = txtVisitStatus.Text;  
        objEmployee_MeetingBAL.FollowUpPerson = txtFlUpPersonName.Text;
        objEmployee_MeetingBAL.FollowUpDesignation = txtFlupPersonDesignation.Text;
        objEmployee_MeetingBAL.FollowUpEmail = txtFlupPersonEmail.Text;
        objEmployee_MeetingBAL.FollowUpMobile = txtFlupPersonMobile.Text;
        objEmployee_MeetingBAL.IsActive = true;
        objEmployee_MeetingBAL.IsDelete = false;
        // objEmployee_MeetingBAL.IsDelete = false;
        //if (objEmployee_MeetingBAL.MeetingID > 0)
        //{
        //    objEmployee_MeetingBAL.ModifiedDate = Convert.ToDateTime(DataProvider.LocalDateTime.Now);
        //    objEmployee_MeetingBAL.ModifiedBy = ProjectSession.Empid;
        //    objEmployee_MeetingBAL.Update();
        //}
        //else
        //{

        objEmployee_MeetingBAL.IsActive = true;
        objEmployee_MeetingBAL.CreatedDate = Convert.ToDateTime(DataProvider.LocalDateTime.Now);
        objEmployee_MeetingBAL.CreatedBy = ProjectSession.Empid;
        objEmployee_MeetingBAL.Insert();

      //  }

        if (objEmployee_MeetingBAL.MeetingID > 0)
        {


            //DataTable dtMMasterId = SQL_DB.ExecuteDataTable("Select * from EmployeeMeetingMaster where  Emp_MeetingMasterId = " + objEmployee_MeetingBAL.MeetingMasterID);
            //if (dtMMasterId.Rows.Count > 0)
            //{
            //    txtMeetingTitle.Text = dtMMasterId.Rows[0]["Title"].ToString();
            //    ddlEmpSupervisor.SelectedValue = dtMMasterId.Rows[0]["EmployeeSupervisor"].ToString();
            //}
            



            string ServiceString = string.Empty;
            EmpMeeting_ServicesFor objEmpMeeting_ServicesFor = new EmpMeeting_ServicesFor();
            for (int i = 0; i < chkbxServices.Items.Count; i++)
            {
                if (chkbxServices.Items[i].Selected == true)
                    ServiceString = ServiceString + "," + chkbxServices.Items[i].Value;
            }
            ServiceString = ServiceString.TrimStart(',').TrimEnd(',');
            objEmpMeeting_ServicesFor.Meetingid = objEmployeeMeetingMaster.Emp_MeetingMasterId;
            objEmpMeeting_ServicesFor.Services = "";
            objEmpMeeting_ServicesFor.Insert(ServiceString);

            EmpMeeting_CardUpload objEmpMeeting_CardUpload = new EmpMeeting_CardUpload();
            objEmpMeeting_CardUpload.Meetingid = objEmployeeMeetingMaster.Emp_MeetingMasterId;

            if (FileUpload1.PostedFile != null)
            {
                if (FileUpload1.PostedFile.FileName != "")
                {
                    string[] str1 = GetFileName(FileUpload1.PostedFile, objEmployeeMeetingMaster.Emp_MeetingMasterId);
                    objEmpMeeting_CardUpload.FileUploadOriginalName = str1[0];
                    objEmpMeeting_CardUpload.FileUploadName = str1[1];
                    objEmpMeeting_CardUpload.Insert();
                }
            }
            if (FileUpload2.PostedFile != null)
            {
                if (FileUpload2.PostedFile.FileName != "")
                {
                    string[] str2 = GetFileName(FileUpload2.PostedFile, objEmployeeMeetingMaster.Emp_MeetingMasterId);
                    objEmpMeeting_CardUpload.FileUploadOriginalName = str2[0];
                    objEmpMeeting_CardUpload.FileUploadName = str2[1];
                    objEmpMeeting_CardUpload.Insert();
                }
            }
            if (FileUpload3.PostedFile != null)
            {
                if (FileUpload3.PostedFile.FileName != "")
                {
                    string[] str3 = GetFileName(FileUpload3.PostedFile, objEmployeeMeetingMaster.Emp_MeetingMasterId);
                    objEmpMeeting_CardUpload.FileUploadOriginalName = str3[0];
                    objEmpMeeting_CardUpload.FileUploadName = str3[1];
                    objEmpMeeting_CardUpload.Insert();
                }
            }
            Response.Redirect("MeetingGrid.aspx");
            //string filename1 = FileUpload1.PostedFile.FileName;
            //string filename2 = FileUpload2.PostedFile.FileName;
            //string filename3 = FileUpload3.PostedFile.FileName;
            ////FileUpload3.PostedFile.SaveAs()

            //objEmpMeeting_CardUpload.FileUploadOriginalName = FileUpload1.PostedFile.FileName;
            //string strNewFilename = Path.GetFileNameWithoutExtension(filename1) + DateTime.Now.ToString("MMddyyyyhhmmss");
            //strNewFilename = strNewFilename.Replace(" ", "");
            //string strGetExtension = Path.GetExtension(filename1);
            ////file name shoud be unique
            //objEmpMeeting_CardUpload.FileUploadName = strNewFilename + "_" + objEmployee_MeetingBAL.MeetingID + strGetExtension;
            //FileUpload1.SaveAs(Server.MapPath("~/EmployeeCardUpload/" + objEmpMeeting_CardUpload.FileUploadName));
        }
    }
    public string[] GetFileName(HttpPostedFile file,int meetingid)
    {
        //string filename1 = FileUpload1.PostedFile.FileName;
        //string filename2 = FileUpload2.PostedFile.FileName;
        //string filename3 = FileUpload3.PostedFile.FileName;
        //FileUpload3.PostedFile.SaveAs()
        string[] strFLName = new string[2];
        // objEmpMeeting_CardUpload.FileUploadOriginalName = file.FileName;
        if (file.ContentLength > 0)
        {
            string strNewFilename = Path.GetFileNameWithoutExtension(file.FileName) + DateTime.Now.ToString("MMddyyyyhhmmss");
            strNewFilename = strNewFilename.Replace(" ", "");
            string strGetExtension = Path.GetExtension(file.FileName);
            //file name shoud be unique
            string strFinalFileName = strNewFilename + "_" + meetingid + strGetExtension;
            FileUpload1.SaveAs(Server.MapPath("~/EmployeeCardUpload/" + strFinalFileName));


            strFLName[0] = file.FileName;
            strFLName[1] = strFinalFileName;
            return strFLName;
        }
        return strFLName;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("MeetingGrid.aspx");
    }
}