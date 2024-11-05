using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text.RegularExpressions;
using Business_Logic_Layer;


public partial class SagarPetro_registeruser : System.Web.UI.Page
{
    int UserRoleID = 0;
    int User_Type = 0;
    string User_Typename = string.Empty;
    cls_patanjali db = new cls_patanjali();
    cls_message msg = new cls_message();
    cls_SagarPetro sagar = new cls_SagarPetro();

   

    protected void Page_Load(object sender, EventArgs e)
    {
        

        if (Session["Comp_ID"] == null)
            Response.Redirect("../SagarPetro/Loginpfl.aspx?from =registeruser");
        if (!IsPostBack)
        {
            DateTime currentDate = DateTime.Now;
            hm_dob.Text = currentDate.ToString("yyyy-MM-dd");

            if (!String.IsNullOrEmpty(Request.QueryString["id"]))
            {
                UserRoleID = Convert.ToInt32(Request.QueryString["id"]);
               
                DataTable dt = db.GetRegisteredUserData("USP_SagarGETUserROLEData", UserRoleID);
                if (dt.Rows.Count > 0)
                {
                   
                    User_Type = Convert.ToInt32(dt.Rows[0]["User_Type"]);
                    if (User_Type == 3)
                        User_Typename = "Backend Admin";
                    else if (User_Type == 4)
                        User_Typename = "Manager";
                    else if (User_Type == 5)
                        User_Typename = "Sales Executive";
                    else if (User_Type == 6)
                        User_Typename = "Head mechanics";
                    else if (User_Type == 7)
                        User_Typename = "Assistant mechanics";
                    #region Viewstate
                    ViewState["UserRoleID"] = UserRoleID;
                    ViewState["User_Type"] = User_Type;
                    ViewState["User_Typename"] = User_Typename;
                    #endregion

                    bindform(User_Typename, dt);
                    username.Text = dt.Rows[0]["UserName"].ToString();
                    username.ReadOnly = true;
                    userEmail.Text = dt.Rows[0]["UserEmail"].ToString();
                    userEmail.ReadOnly = true;
                    userMobile.Text = dt.Rows[0]["Mobile_Number"].ToString();
                    userMobile.ReadOnly = true;
                    BindReport(UserRoleID);
                    btnSubmit.Text = "Update";
                    ViewState["UserRoleID"] = UserRoleID;
                }
            }
            else
            {
                btnSubmit.Enabled = false;
               
                hm_ddldistrict.Enabled = false;
                hm_ddldistrict.Items.Insert(0, new ListItem("Select District", "0"));
                ddlcity.Enabled = false;
                ddlcity.Items.Insert(0, new ListItem("Select City", "0"));
                am_ddlcity.Enabled = false;
                am_ddlcity.Items.Insert(0, new ListItem("Select City", "0"));
                am_ddldistrict.Enabled = false;
                am_ddldistrict.Items.Insert(0, new ListItem("Select District", "0"));
                am_headmachanicname.Enabled = false;
                am_headmachanicname.Items.Insert(0, new ListItem("Select Head Mechanic Name", "0"));
                bindroletype();
                bindmachictype();
                bindassistantmachictype();
                BindAllMenus();
                bindstate();
            }
        }
    }



    public void BindReport(int roleId)
    {
        BindMenuItems(roleId, "1", Chkdashboard);
        BindMenuItems(roleId, "2", ChkUsers);
        BindMenuItems(roleId, "3", ChkReport);
       // BindMenuItems(roleId, "4", ChkCompprofile);
        BindMenuItems(roleId, "14", ChkProduct);
        BindMenuItems(roleId, "17", ChkService);
        BindMenuItems(roleId, "23", ChKLabel);
        BindMenuItems(roleId, "20", ChkScrap);
    }
    private void BindMenuItems(int roleId, string refMenuId, CheckBoxList checkBoxList)
    {
        DataTable dt = GetMenuItems(roleId, refMenuId);
        if (dt.Rows.Count > 0)
        {
            BindCheckBoxList(dt, checkBoxList);
        }
        else
        {
            DataTable defaultMenuItems = GetDefaultMenuItems(refMenuId);
            BindCheckBoxList(defaultMenuItems, checkBoxList);
        }
    }
    private DataTable GetMenuItems(int roleId, string refMenuId)
    {
        return bindOther1(roleId, refMenuId);
    }
    protected DataTable bindOther1(int roleId, string refMenuId)
    {
        try
        {
            DataTable dt = SQL_DB.ExecuteDataTable("exec USP_SagarGetAllMenuItems '" + roleId + "','" + refMenuId + "'");
            if (dt.Rows.Count > 0)
            {
                return dt;
            }
            else
            {
                return null;
            }
        }
        catch (Exception)
        {
            return null;
        }
    }
    private DataTable GetDefaultMenuItems(string refMenuId)
    {
        return SQL_DB.ExecuteDataTable("select MenuItemID, MenuItemName from MenuItem_Sagar_petro where RefMenu='" + refMenuId + "'");
    }
    private void BindCheckBoxList(DataTable dt, CheckBoxList checkBoxList)
    {
        try
        {
            if (dt != null)
            {
                checkBoxList.DataValueField = "MenuItemID";
                checkBoxList.DataTextField = "MenuItemName";
                checkBoxList.DataSource = dt;
                checkBoxList.DataBind();
                SelectCheckBoxes(dt, checkBoxList);
            }
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    private void SelectCheckBoxes(DataTable dt, CheckBoxList checkBoxList)
    {
        try
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var statusValue = dt.Rows[i]["Status"];

                bool status = false;
                if (statusValue is bool)
                {
                    status = (bool)statusValue;
                }
                else if (statusValue is int)
                {
                    status = (int)statusValue != 0;
                }
                else if (statusValue is string)
                {
                    bool.TryParse((string)statusValue, out status);
                }
                checkBoxList.Items[i].Selected = status;
            }
        }
        catch (Exception ex)
        {
            throw;
        }
    }


   
    public void bindmachictype()
    {
        DataTable dt = SQL_DB.ExecuteDataTable("select id,Mechanic_Type from tbl_sp_machanictype where IsActive=1 and Isdelete=0");
        if (dt.Rows.Count > 0)
        {
            hm_ddlmachnictype.DataSource = dt;
            hm_ddlmachnictype.DataTextField = "Mechanic_Type";
            hm_ddlmachnictype.DataValueField = "Id";
            hm_ddlmachnictype.DataBind();
            hm_ddlmachnictype.Items.Insert(0, new ListItem("--Select Role--", "0"));
            hm_ddlmachnictype.SelectedIndex = 0;
            hm_ddlmachnictype.Items[0].Attributes["disabled"] = "disabled";
            am_machinctype.DataSource = dt;
            am_machinctype.DataTextField = "Mechanic_Type";
            am_machinctype.DataValueField = "Id";
            am_machinctype.DataBind();
            am_machinctype.Items.Insert(0, new ListItem("--Select Role--", "0"));
            am_machinctype.SelectedIndex = 0;
            am_machinctype.Items[0].Attributes["disabled"] = "disabled";
        }
    }
    public void bindassistantmachictype()
    {
        DataTable dt = SQL_DB.ExecuteDataTable("select id,Mechanic_Type from tbl_sp_machanictype where IsActive=1 and Isdelete=0");
        if (dt.Rows.Count > 0)
        {
            am_machinctype.DataSource = dt;
            am_machinctype.DataTextField = "Mechanic_Type";
            am_machinctype.DataValueField = "Id";
            am_machinctype.DataBind();
            am_machinctype.Items.Insert(0, new ListItem("--Select Role--", "0"));
            am_machinctype.SelectedIndex = 0;
            am_machinctype.Items[0].Attributes["disabled"] = "disabled";
        }
    }
    public void bindroletype()
    {
        DataTable dt = SQL_DB.ExecuteDataTable("select id,RoleType from tbl_pflUserRole where IsActive=1 and Isdelete=0");
        if (dt.Rows.Count > 0)
        {
            ddlroletype.DataSource = dt;
            ddlroletype.DataTextField = "RoleType";
            ddlroletype.DataValueField = "Id";
            ddlroletype.DataBind();
            ddlroletype.Items.Insert(0, new ListItem("--Select Role--", "0"));
            ddlroletype.SelectedIndex = 0;
            ddlroletype.Items[0].Attributes["disabled"] = "disabled";
        }
    }
    public void bindheadmachanic(int DistrictId)
    {

       // DataTable dt = sagar.Getheadmachinicname("GetUserByHeadMechanicName", 6, am_ddldistrict.SelectedItem.Value, Session["CompanyId"].ToString());
        DataTable dt = SQL_DB.ExecuteDataTable("GetUserByHeadMechanicName '"+6+"','"+ DistrictId + "','"+ Session["CompanyId"].ToString() + "'");
        {
            am_headmachanicname.DataSource = dt;
            am_headmachanicname.DataTextField = "UserName";
            am_headmachanicname.DataValueField = "ID";
            am_headmachanicname.DataBind();
            am_headmachanicname.Items.Insert(0, new ListItem("--Select Head Machanic--", "0"));
            am_headmachanicname.SelectedIndex = 0;
            am_headmachanicname.Items[0].Attributes["disabled"] = "disabled";
            am_headmachanicname.Enabled = true;
        }

    }

    protected void ddlroletype_SelectedIndexChanged(object sender, EventArgs e)
    {
        ClearFields();
        string SelectedRoleid = ddlroletype.SelectedItem.Text;
        //bindform(SelectedRoleid);
        #region User Selection

        if (SelectedRoleid == "--Select Role--")
        {
            msg.ShowErrorMessage(this, "Please Select User Role");
            managerregform.Visible = false;
            assistantmachanic.Visible = false;
            headmachanicform.Visible = false;
            btnSubmit.Enabled = false;
            return;
        }
        if (SelectedRoleid.Contains("Backend Admin"))
        {
            ddldistrict.SelectionMode = ListSelectionMode.Single;
            headtext.Visible = true;
            dovmenuselection.Visible = true;
            backendadminregistration.Visible = true;
            managerregform.Visible = false;
            assistantmachanic.Visible = false;
            headmachanicform.Visible = false;
            btnSubmit.Enabled = true;
        }
        if (SelectedRoleid.Contains("Manager") || SelectedRoleid.Contains("Sales Executive"))
        {
            ddldistrict.SelectionMode = ListSelectionMode.Multiple;
            headtext.Visible = false;
            dovmenuselection.Visible = false;
            backendadminregistration.Visible = false;
            managerregform.Visible = true;
            assistantmachanic.Visible = false;
            headmachanicform.Visible = false;
            btnSubmit.Enabled = true;
           
            m_txtdesignation.Text = ddlroletype.SelectedItem.Text;
        }
        else if (SelectedRoleid.Contains("Head mechanics"))
        {
            headtext.Visible = false;
            dovmenuselection.Visible = false;
            backendadminregistration.Visible = false;
            managerregform.Visible = false;
            assistantmachanic.Visible = false;
            headmachanicform.Visible = true;
            btnSubmit.Enabled = true;
        }
        else if (SelectedRoleid.Contains("Assistant mechanics"))
        {
            headtext.Visible = false;
            dovmenuselection.Visible = false;
            backendadminregistration.Visible = false;
            managerregform.Visible = false;
            assistantmachanic.Visible = true;
            headmachanicform.Visible = false;
            btnSubmit.Enabled = true;
        }

        #endregion
    }
    public void bindform(string Selectedrole, DataTable dt)
    {
        string SelectedRoleid = Selectedrole;
        ddlroletype.Visible = false;
        if (SelectedRoleid == "--Select Role--")
        {
            msg.ShowErrorMessage(this, "Please Select User Role");
            managerregform.Visible = false;
            assistantmachanic.Visible = false;
            headmachanicform.Visible = false;
            btnSubmit.Enabled = false;
            return;
        }
        else if (SelectedRoleid.Contains("Backend Admin"))
        {
            ddldistrict.SelectionMode = ListSelectionMode.Single;
            headtext.Visible = true;
            dovmenuselection.Visible = true;
            backendadminregistration.Visible = true;
            managerregform.Visible = false;
            assistantmachanic.Visible = false;
            headmachanicform.Visible = false;
            btnSubmit.Enabled = true;
            txtbaname.Text = dt.Rows[0]["UserName"].ToString();
            txtbaname.ReadOnly = true;
            txtbaemail.Text = dt.Rows[0]["UserEmail"].ToString();
            txtbaemail.ReadOnly = true;
            txtbamobile.Text = dt.Rows[0]["Mobile_Number"].ToString();
            txtbaemail.ReadOnly = true;
        }
        else if (SelectedRoleid.Contains("Manager") || SelectedRoleid.Contains("Sales Executive"))
        {
            ddldistrict.SelectionMode = ListSelectionMode.Multiple;
            headtext.Visible = true;
            dovmenuselection.Visible = false;
            backendadminregistration.Visible = false;
            managerregform.Visible = true;
            assistantmachanic.Visible = false;
            headmachanicform.Visible = false;
            btnSubmit.Enabled = true;
            username.Text = dt.Rows[0]["UserName"].ToString();
            username.ReadOnly = true;
            userEmail.Text = dt.Rows[0]["UserEmail"].ToString();
            userEmail.ReadOnly = true;
            userMobile.Text = dt.Rows[0]["Mobile_Number"].ToString();
            userMobile.ReadOnly = true;
            bindstate();
            string selectedStateName = dt.Rows[0]["State_Name"].ToString();
            ListItem selectedItem = m_ddlstate.Items.FindByText(selectedStateName);
            if (selectedItem != null)
            {
                m_ddlstate.SelectedValue = selectedItem.Value;
            }
            m_ddlstate.Enabled = false;
            binddistrict(Convert.ToInt32( dt.Rows[0]["StateName"]));
            ddldistrict.SelectionMode = ListSelectionMode.Multiple;
            ddldistrict.ClearSelection();
            string districts = dt.Rows[0]["DistrictNames"].ToString();
            string[] districtArray = districts.Split(',');

            foreach (string district in districtArray)
            {
                ListItem item = ddldistrict.Items.FindByText(district.Trim());
                if (item != null)
                {
                    item.Selected = true;
                }
            }
            m_txtdesignation.Text = dt.Rows[0]["Designation"].ToString();
            m_txtdesignation.Enabled = false;
        }
        else if (SelectedRoleid.Contains("Head mechanics"))
        {
            headtext.Visible = false;
            dovmenuselection.Visible = false;
            backendadminregistration.Visible = false;
            managerregform.Visible = false;
            assistantmachanic.Visible = false;
            headmachanicform.Visible = true;
            btnSubmit.Enabled = true;
            hm_txtname.Text = dt.Rows[0]["UserName"].ToString();
            hm_txtname.ReadOnly = true;
            hm_mobileno.Text = dt.Rows[0]["Mobile_Number"].ToString();
            hm_mobileno.ReadOnly = true;
            hm_address.Text = dt.Rows[0]["Complete_Address"].ToString();
            hm_address.ReadOnly = true;
            bindstate();
            string selectedStateName = dt.Rows[0]["State_Name"].ToString();
            ListItem selectedItem = hm_ddlstate.Items.FindByText(selectedStateName);
            if (selectedItem != null)
            {
                hm_ddlstate.SelectedValue = selectedItem.Value;
            }
            hm_ddlstate.Enabled = false;
            binddistrict(Convert.ToInt32(dt.Rows[0]["StateName"]));
            string selecteddistrictName = dt.Rows[0]["DistrictNames"].ToString();
            ListItem selecteddistrictItem = hm_ddldistrict.Items.FindByText(selecteddistrictName);
            if (selecteddistrictItem != null)
            {
                hm_ddldistrict.SelectedValue = selecteddistrictItem.Value;
            }
            hm_ddldistrict.Enabled = false;
            bindcity(Convert.ToInt32( hm_ddldistrict.SelectedItem.Value));
            string Selectedcity = dt.Rows[0]["City_name"].ToString();
            ListItem selectedcityItem = ddlcity.Items.FindByText(Selectedcity);
            if (selectedcityItem != null)
            {
                ddlcity.SelectedValue = selectedcityItem.Value;
            }
            ddlcity.Enabled = false;
            hm_pincode.Text = dt.Rows[0]["Pincode"].ToString();
            hm_pincode.ReadOnly = true;

            bindmachictype();
            string selectedmechanictypeName = dt.Rows[0]["Mechanictype"].ToString();
            ListItem selectedMechanic_TypeItem = hm_ddlmachnictype.Items.FindByText(selectedmechanictypeName);
            if (selectedMechanic_TypeItem != null)
            {
                hm_ddlmachnictype.SelectedValue = selectedMechanic_TypeItem.Value;
            }
            hm_ddlmachnictype.Enabled = false;

            
            hm_dob.Text = dt.Rows[0]["User_DOB"].ToString().Substring(0,10);
            switch (dt.Rows[0]["Gender"].ToString())
            {
                case "Male":
                    genderMale.Checked = true;
                    break;
                case "Female":
                    genderFemale.Checked = true;
                    break;
                case "Other":
                    genderOther.Checked = true;
                    break;
                default:
                    genderMale.Checked = false;
                    genderFemale.Checked = false;
                    genderOther.Checked = false;
                    break;
            }
            switch (dt.Rows[0]["Marital_Status"].ToString())
            {
                case "Married":
                    rblmarried.Checked = true;
                    rblunmarried.Checked = false;
                    break;
                case "Unmarried":
                    rblmarried.Checked = false;
                    rblunmarried.Checked = true;
                    break;
                case "Single":
                    rblmarried.Checked = false;
                    rblunmarried.Checked = true;
                    break;
                default:
                    rblmarried.Checked = false;
                    rblunmarried.Checked = false;
                    break;
            }
            btnSubmit.Enabled = false;
        }
        else if (SelectedRoleid.Contains("Assistant mechanics"))
        {
            headtext.Visible = false;
            dovmenuselection.Visible = false;
            backendadminregistration.Visible = false;
            managerregform.Visible = false;
            assistantmachanic.Visible = true;
            headmachanicform.Visible = false;
            btnSubmit.Enabled = true;
            // Setting textboxes to read-only
            am_name.Text = dt.Rows[0]["UserName"].ToString();
            am_name.ReadOnly = true;

            am_mobileno.Text = dt.Rows[0]["Mobile_Number"].ToString();
            am_mobileno.ReadOnly = true;

            am_address.Text = dt.Rows[0]["Complete_Address"].ToString();
            am_address.ReadOnly = true;

            am_pincode.Text = dt.Rows[0]["Pincode"].ToString();
            am_pincode.ReadOnly = true;

            txtDate.Text = dt.Rows[0]["User_DOB"].ToString().Substring(0,10);
            txtDate.ReadOnly = true;


            bindstate();
            string selectedStateName = dt.Rows[0]["State_Name"].ToString();
            ListItem selectedItem = am_ddlstate.Items.FindByText(selectedStateName);
            if (selectedItem != null)
            {
                am_ddlstate.SelectedValue = selectedItem.Value;
            }
            am_ddlstate.Enabled = false;
            binddistrict(Convert.ToInt32(dt.Rows[0]["StateName"]));
            string selecteddistrictName = dt.Rows[0]["DistrictNames"].ToString();
            ListItem selecteddistrictItem = am_ddldistrict.Items.FindByText(selecteddistrictName);
            if (selecteddistrictItem != null)
            {
                am_ddldistrict.SelectedValue = selecteddistrictItem.Value;
            }
            am_ddldistrict.Enabled = false;
            bindcity(Convert.ToInt32(am_ddldistrict.SelectedItem.Value));
            string selectedcityName = dt.Rows[0]["City_name"].ToString();
            ListItem selectedcityItem = am_ddlcity.Items.FindByText(selectedcityName);
            if (selectedcityItem != null)
            {
                am_ddlcity.SelectedValue = selectedcityItem.Value;
            }
            am_ddlcity.Enabled = false;
            bindheadmachanic(Convert.ToInt32(am_ddldistrict.SelectedItem.Value));
            string selectedheadmechanicName = dt.Rows[0]["Headmechanicname"].ToString();
            ListItem selectedheadmechanicItem = am_headmachanicname.Items.FindByText(selectedheadmechanicName);
            if (selectedheadmechanicItem != null)
            {
                am_headmachanicname.SelectedValue = selectedheadmechanicItem.Value;
            }
            am_headmachanicname.Enabled = false;
            bindmachictype();
            string selectedmechanictypeName = dt.Rows[0]["Mechanictype"].ToString();
            ListItem selectedMechanic_TypeItem = am_machinctype.Items.FindByText(selectedmechanictypeName);
            if (selectedMechanic_TypeItem != null)
            {
                am_machinctype.SelectedValue = selectedMechanic_TypeItem.Value;
            }
            am_machinctype.Enabled = false;


            // Handling gender radio buttons
            switch (dt.Rows[0]["Gender"].ToString())
            {
                case "Male":
                    rbl_amgendormale.Checked = true;
                    break;
                case "Female":
                    rbl_amgendorfemale.Checked = true;
                    break;
                case "Other":
                    rbl_amgendorother.Checked = true;
                    break;
                default:
                    rbl_amgendormale.Checked = false;
                    rbl_amgendorfemale.Checked = false;
                    rbl_amgendorother.Checked = false;
                    break;
            }

            // Handling marital status radio buttons
            switch (dt.Rows[0]["Marital_Status"].ToString())
            {
                case "Married":
                    am_rblmarried.Checked = true;
                    
                    break;
                case "Unmaaried":
                case "Single":
                    am_rblmarried.Checked = true;
                  
                    break;
                default:
                    am_rblmarried.Checked = false;
                    am_rblunmarried.Checked = false;
                    break;
            }
            btnSubmit.Enabled = false;
        }
    }
    public  DataTable GetDataTable(string id,string name)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add(id);
        dt.Columns.Add(name);
        return dt;
    }
    public void BindDropDownList(DropDownList ddl, DataTable dt, string textField, string valueField, string selectedValue)
    {
        ddl.DataSource = dt;
        ddl.DataTextField = textField;
        ddl.DataValueField = valueField;
        ddl.DataBind();

        //SetDropDownListSelectedValue(ddl, selectedValue);
    }

    public void SetDropDownListSelectedValue(DropDownList ddl, string value)
    {
        ListItem item = ddl.Items.FindByValue(value);
        if (item != null)
        {
            ddl.SelectedValue = value;
            ddl.Enabled = false;
        }
        else
        {
            ddl.SelectedIndex = -1;
        }
    }
    public void McRegistration(string UserMobile)
    {
        if (UserMobile.Length == 10)
            UserMobile = "91" + UserMobile;
        User_Details Log = new User_Details();
        Random rnd = new Random();
        Log.Comp_id = Session["CompanyId"].ToString();
        Log.UPI = "";
        Log.designation = "";
        Log.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss.fff"));
        Log.ConsumerName = "";
        Log.Email = "";
        Log.MobileNo = UserMobile;
        Log.Role_ID = "";
        Log.Other_Role = "";
        Log.state = "";
        Log.City = "";
        Log.PinCode = "";
        Log.Password = "12345";
        Log.IsActive = 0;
        Log.IsDelete = 0;
        Log.code1 = null;
        Log.code2 = null;
        Log.village = "";
        Log.district = "";
        Log.state = "";
        Log.PanNumber = "";
        Log.country = "";
        Log.DML = "I";
        Log.Address = "";
        Log.SellerName = "";
        Log.gender = "";
        Log.Agegroup = "";
        User_Details.InsertUpdateUserDetails(Log);
    }

    private void UpdateMenuPermissionsupdate(CheckBoxList chkList, int userRoleId)
    {
        foreach (ListItem item in chkList.Items)
        {
            int menuId = Convert.ToInt32(item.Value);
            int status = item.Selected ? 1 : 0;
            DataTable dtmenuchk = SQL_DB.ExecuteDataTable("select*from tbl_SagarPetro_Usercontrol where MenuId='"+ menuId + "' and UserRole_Id='"+ userRoleId + "'");
            if (dtmenuchk.Rows.Count > 0)
            {
                SQL_DB.ExecuteNonQuery("UPDATE tbl_SagarPetro_Usercontrol SET Status ='" + status + "' WHERE MenuId = '" + menuId + "' AND UserRole_Id = '" + userRoleId + "'");
            }
            else
            {
                SQL_DB.ExecuteNonQuery("insert into tbl_SagarPetro_Usercontrol(MenuId,Status,UserRole_Id)values('" + menuId + "','" + status + "','" + userRoleId + "')");
            }
        }
    }

    #region Registration Method
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (btnSubmit.Text == "Update")
        {
            if (ViewState["UserRoleID"] != null)
            {
                #region Viewstate consume
                User_Typename = ViewState["User_Typename"].ToString();
                UserRoleID =Convert.ToInt32( ViewState["UserRoleID"]);
                User_Type =Convert.ToInt32 (ViewState["User_Type"]);
                #endregion
            }
            RegistrationMailsagar mail = new RegistrationMailsagar();
            string SelectedRoletext = User_Typename;
            if (SelectedRoletext == "--Select Role--")
            {
                msg.ShowErrorMessage(this, "Invalid Request");
                return;
            }
            if(User_Type == 6 || User_Type == 7){
                msg.ShowErrorMessage(this, "Can't Update");
                return;
            }
            DataTable dtget = SQL_DB.ExecuteDataTable("Select MenuId,Status from tbl_SagarPetro_Usercontrol where UserRole_Id = '" + UserRoleID + "'");
            if (dtget.Rows.Count > 0 )
            {
                UpdateMenuPermissionsupdate(Chkdashboard, UserRoleID);
               // UpdateMenuPermissionsupdate(ChkCompprofile, UserRoleID);
                UpdateMenuPermissionsupdate(ChkReport, UserRoleID);
                UpdateMenuPermissionsupdate(ChkUsers, UserRoleID);
                UpdateMenuPermissionsupdate(ChkProduct, UserRoleID);
                UpdateMenuPermissionsupdate(ChkService, UserRoleID);
                UpdateMenuPermissionsupdate(ChKLabel, UserRoleID);
                UpdateMenuPermissionsupdate(ChkScrap, UserRoleID);
                if(User_Type==4 || User_Type == 5)
                {
                    string UserDistrict = string.Empty;
                    foreach (int item in ddldistrict.GetSelectedIndices())
                    {
                        UserDistrict = UserDistrict + "" + ddldistrict.Items[item].Value + ",";
                    }
                    if (UserDistrict.Length > 0 && !UserDistrict.Contains("--Select District--"))
                    {
                        UserDistrict = UserDistrict.Remove(UserDistrict.Length - 1, 1);
                    }
                    else
                    {
                        UserDistrict = "";
                    }
                    SQL_DB.ExecuteNonQuery("update tbl_users_SP set District='"+ UserDistrict + "' where ID='" + UserRoleID + "' and User_Type='"+ User_Type + "' and IsActive=1 and IsDelete=0");
                }
            }
            else
            {
                UpdateMenuPermissions(Chkdashboard, UserRoleID);
               // UpdateMenuPermissions(ChkCompprofile, UserRoleID);
                UpdateMenuPermissions(ChkReport, UserRoleID);
                UpdateMenuPermissions(ChkUsers, UserRoleID);
                UpdateMenuPermissions(ChkProduct, UserRoleID);
                UpdateMenuPermissions(ChkService, UserRoleID);
                UpdateMenuPermissions(ChKLabel, UserRoleID);
                UpdateMenuPermissions(ChkScrap, UserRoleID);
            }
            msg.ShowSuccessMessage(this, "Updated Successfully!");
            return;
        }
        else
        {
            RegistrationMailsagar mail = new RegistrationMailsagar();
            string SelectedRoletext = ddlroletype.SelectedItem.Text;
            string SelectedRoleid = ddlroletype.SelectedItem.Value;
            if (SelectedRoletext == "--Select Role--")
            {
                msg.ShowErrorMessage(this, "Please Select User Role");
                return;
            }

            #region Backed admin
            if (SelectedRoletext.Contains("Backend Admin"))
            {
                string UserName = txtbaname.Text.Trim();
                string UserEmail = txtbaemail.Text.Trim();
                string UserMobile = txtbamobile.Text.Trim();
                if (!IsValidUserName(UserName))
                {
                    msg.ShowErrorMessage(this, "Please Enter Valid User Name");
                    return;
                }
                if (string.IsNullOrEmpty(UserEmail))
                {
                    msg.ShowErrorMessage(this, "Please Enter Email Id");
                    return;
                }
                if (!IsEmailValid(UserEmail))
                {
                    msg.ShowErrorMessage(this, "Please Enter Valid Email Id");
                    return;
                }
                if (!IsMobileNumberValid(UserMobile))
                {
                    msg.ShowErrorMessage(this, "Please Enter Valid Mobile Number");
                    return;
                }
                if (!sagar.Validatemobilenumber(UserMobile))
                {
                    msg.ShowErrorMessage(this, "Entered Mobile Number Already Used");
                    return;
                }



                DataTable dt = sagar.RegisterUser("USP_RegisterUser_SP", UserMobile, UserEmail, UserName, "", "", "", SelectedRoleid, Session["CompanyId"].ToString());
                string registrationMessage = dt.Rows[0][0].ToString();
                if (registrationMessage == "Entered Mobile Number Already Used" || registrationMessage == "Entered Email Id Already Used" || registrationMessage == "Entered email is deleted kindy connect to Administrator")
                {
                    msg.ShowErrorMessage(this, registrationMessage);
                    return;
                }
                DataTable dtconsumer = SQL_DB.ExecuteDataTable("select*from M_Consumer where MobileNo='" + UserMobile + "' and IsDelete=0");
                if (dtconsumer.Rows.Count == 0)
                {
                    McRegistration(UserMobile);
                }

                int userRoleId = GetUserRoleId(UserEmail, UserMobile);
                if (userRoleId == 0)
                    return;
                string userPassword = GetUserPassword(UserEmail, UserMobile);
                mail.Name = UserName;
                mail.Email = UserEmail;
                mail.Mobile = UserMobile;
                mail.Subject = "New Registration";
                mail.LoginID = UserEmail;
                mail.Password = userPassword;
               // string mailresponse = db.PostCall(mail.GetJson(), "api/sendmailregistration", "https://vrkableuat.vcqru.com/");


                UpdateMenuPermissions(Chkdashboard, userRoleId);
               // UpdateMenuPermissions(ChkCompprofile, userRoleId);
                UpdateMenuPermissions(ChkReport, userRoleId);
                UpdateMenuPermissions(ChkUsers, userRoleId);
                UpdateMenuPermissions(ChkProduct, userRoleId);
                UpdateMenuPermissions(ChkService, userRoleId);
                UpdateMenuPermissions(ChKLabel, userRoleId);
                UpdateMenuPermissions(ChkScrap, userRoleId);
                ClearFields();
                msg.ShowSuccessMessagewithredirect(this, "Registered Successfully", "../SagarPetro/newuser.aspx");

            }
            #endregion
            #region Manager and Sales Executive Registration Process
            if (SelectedRoletext.Contains("Manager") || SelectedRoletext.Contains("Sales Executive"))
            {
                string UserName = username.Text.Trim();
                string UserEmail = userEmail.Text.Trim();
                string UserMobile = userMobile.Text.Trim();

                string UserState = string.Empty;
                if (m_ddlstate.SelectedItem != null && m_ddlstate.SelectedItem.Value != "0")
                {
                    UserState = m_ddlstate.SelectedItem.Value;
                }
                string UserDistrict = string.Empty;
                //if (ddldistrict.SelectedItem != null && ddldistrict.SelectedItem.Value != "0")
                //{
                //    UserDistrict = ddldistrict.SelectedItem.Value;
                //}

                foreach (int item in ddldistrict.GetSelectedIndices())
                {
                    UserDistrict = UserDistrict + "" + ddldistrict.Items[item].Value + ",";

                }
                if (UserDistrict.Length > 0 && !UserDistrict.Contains("--Select District--"))
                {
                    UserDistrict = UserDistrict.Remove(UserDistrict.Length - 1, 1);
                }
                else
                {
                    UserDistrict = "";
                }


                string UserDesignation = m_txtdesignation.Text.Trim();

                if (!IsValidUserName(UserName))
                {
                    msg.ShowErrorMessage(this, "Please Enter Valid User Name");
                    return;
                }
                if (string.IsNullOrEmpty(UserEmail))
                {
                    msg.ShowErrorMessage(this, "Please Enter Email Id");
                    return;
                }
                if (!IsMobileNumberValid(UserMobile))
                {
                    msg.ShowErrorMessage(this, "Please Enter Valid Mobile no");
                    return;
                }
                if (!sagar.Validatemobilenumber(UserMobile))
                {
                    msg.ShowErrorMessage(this, "Entered Mobile Number Already Used");
                    return;
                }
                if (string.IsNullOrEmpty(UserState) ||UserState == "0")
                {
                    msg.ShowErrorMessage(this, "Please Select State");
                    return;
                }
                if (string.IsNullOrEmpty(UserDistrict) || UserDistrict == "0")
                {
                    msg.ShowErrorMessage(this, "Please Select District");
                    return;
                }
                if (string.IsNullOrEmpty(UserDesignation))
                {
                    msg.ShowErrorMessage(this, "Please Enter Designation");
                    return;
                }

                DataTable dt = sagar.RegisterUser("USP_RegisterUser_SP", UserMobile, UserEmail, UserName, UserDistrict, UserState, UserDesignation, SelectedRoleid, Session["CompanyId"].ToString());
                string registrationMessage = dt.Rows[0][0].ToString();
                if (registrationMessage == "Entered Mobile Number Already Used" || registrationMessage == "Entered Email Id Already Used" || registrationMessage == "Entered email is deleted kindy connect to Administrator")
                {
                    msg.ShowErrorMessage(this, registrationMessage);
                    return;
                }
                DataTable dtconsumer = SQL_DB.ExecuteDataTable("select*from M_Consumer where MobileNo='" + UserMobile + "' and IsDelete=0");
                if (dtconsumer.Rows.Count == 0)
                {
                    McRegistration(UserMobile);
                }

                int userRoleId = GetUserRoleId(UserEmail, UserMobile);
                if (userRoleId == 0)
                    return;
                string userPassword = GetUserPassword(UserEmail, UserMobile);
                mail.Name = UserName;
                mail.Email = UserEmail;
                mail.Mobile = UserMobile;
                mail.Subject = "New Registration";
                mail.LoginID = UserEmail;
                mail.Password = userPassword;
               // string mailresponse = db.PostCall(mail.GetJson(), "api/sendmailregistration", "https://vrkableuat.vcqru.com/");


                UpdateMenuPermissions(Chkdashboard, userRoleId);
               // UpdateMenuPermissions(ChkCompprofile, userRoleId);
                UpdateMenuPermissions(ChkReport, userRoleId);
                UpdateMenuPermissions(ChkUsers, userRoleId);
                UpdateMenuPermissions(ChkProduct, userRoleId);
                UpdateMenuPermissions(ChkService, userRoleId);
                UpdateMenuPermissions(ChKLabel, userRoleId);
                UpdateMenuPermissions(ChkScrap, userRoleId);
                ClearFields();
                msg.ShowSuccessMessagewithredirect(this, "Registered Successfully", "../SagarPetro/newuser.aspx");

            }
            #endregion
            #region Head mechanics Registration Process
            else if (SelectedRoletext.Contains("Head mechanics"))
            {

                string validationMessage;
                string UserName = hm_txtname.Text.Trim();
                string UserEmail = "";
                string UserMobile = hm_mobileno.Text.Trim();
                string UserAddress = hm_address.Text.Trim();
                string UserDistrict = hm_ddldistrict.SelectedItem.Value;
                string UserState = hm_ddlstate.SelectedItem.Value;
                string UserCity = ddlcity.SelectedItem.Value;
                string UserPin = hm_pincode.Text.Trim();
                int Machanictype = Convert.ToInt32(hm_ddlmachnictype.SelectedItem.Value);
                string UserDOB = Request.Form["ctl00$ContentPlaceHolder1$hm_dob"];
                
               
                
                

                if (!IsValidUserName(UserName))
                {
                    msg.ShowErrorMessage(this, "Please Enter Valid User Name");
                    return;
                }
                if (!IsMobileNumberValid(UserMobile))
                {
                    msg.ShowErrorMessage(this, "Please Enter Valid Mobile Number");
                    return;
                }
                if (!sagar.Validatemobilenumber(UserMobile))
                {
                    msg.ShowErrorMessage(this, "Entered Mobile Number Already Used");
                    return;
                }
                if (string.IsNullOrEmpty(UserAddress))
                {
                    msg.ShowErrorMessage(this, "Please Enter Address");
                    return;
                }
                if (string.IsNullOrEmpty(UserState) || UserState == "0")
                {
                    msg.ShowErrorMessage(this, "Please Select State");
                    return;
                }
                if (string.IsNullOrEmpty(UserDistrict) || UserDistrict == "0")
                {
                    msg.ShowErrorMessage(this, "Please Select District");
                    return;
                }
                if (string.IsNullOrEmpty(UserCity) || UserCity == "0")
                {
                    msg.ShowErrorMessage(this, "Please Select City");
                    return;
                }
                if (string.IsNullOrEmpty(UserPin))
                {
                    msg.ShowErrorMessage(this, "Please Enter Pin Code");
                    return;
                }
                if (Machanictype == 0)
                {
                    msg.ShowErrorMessage(this, "Please Select Mechanic Type");
                    return;
                }
                if (!IsValidAge(UserDOB, 18, out validationMessage))
                {
                    msg.ShowErrorMessage(this, validationMessage);
                    return;
                }
                string selectedGender = string.Empty;
                if (genderMale.Checked)
                {
                    selectedGender = genderMale.Text;
                }
                else if (genderFemale.Checked)
                {
                    selectedGender = genderFemale.Text;
                }
                else if (genderOther.Checked)
                {
                    selectedGender = genderOther.Text;
                }
                else
                {
                    msg.ShowErrorMessage(this, "Please Select Gender");
                    return;
                }
                string selectedMarritalStatus = string.Empty;
                if (rblmarried.Checked)
                {
                    selectedMarritalStatus = rblmarried.Text;
                }
                else if (rblunmarried.Checked)
                {
                    selectedMarritalStatus = rblunmarried.Text;
                }
                else
                {
                    msg.ShowErrorMessage(this, "Please Select Marital Status");
                    return;
                }

                DataTable dt = sagar.Headmachanicreg("USP_RegisterUser_SP", UserName, UserMobile, UserDistrict, UserState, null, UserAddress, UserCity, UserPin, Machanictype, UserDOB, selectedGender, selectedMarritalStatus, SelectedRoleid, null, UserEmail, Session["CompanyId"].ToString());
                string registrationMessage = dt.Rows[0][0].ToString();
                if (registrationMessage == "Entered Mobile Number Already Used" || registrationMessage == "Entered Email Id Already Used" || registrationMessage == "Entered email is deleted kindy connect to Administrator")
                {
                    msg.ShowErrorMessage(this, registrationMessage);
                    return;
                }
                DataTable dtconsumer = SQL_DB.ExecuteDataTable("select*from M_Consumer where MobileNo='" + UserMobile + "' and IsDelete=0");
                if (dtconsumer.Rows.Count == 0)
                {
                    McRegistration(UserMobile);
                }
                int userRoleId = GetUserRoleId(UserEmail, UserMobile);
                if (userRoleId == 0)
                    return;
                string userPassword = GetUserPassword(UserEmail, UserMobile);
                mail.Name = UserName;
                mail.Email = UserEmail;
                mail.Mobile = UserMobile;
                mail.Subject = "New Registration";
                mail.LoginID = UserEmail;
                mail.Password = userPassword;
                //string mailresponse = db.PostCall(mail.GetJson(), "api/sendmailregistration", "https://vrkableuat.vcqru.com/");

                #region Uncomment if need menu assign to head mechanic
                //UpdateMenuPermissions(Chkcodecheck, userRoleId);
                //UpdateMenuPermissions(Chkdashboard, userRoleId);
                //UpdateMenuPermissions(ChkReport, userRoleId);
                //UpdateMenuPermissions(ChkUsers, userRoleId);
                //UpdateMenuPermissions(ChkProduct, userRoleId);
                //UpdateMenuPermissions(ChkService, userRoleId);
                //UpdateMenuPermissions(ChKLabel, userRoleId);
                //UpdateMenuPermissions(ChkScrap, userRoleId);
                #endregion
                ClearFields();
                msg.ShowSuccessMessagewithredirect(this, "Registered Successfully", "../SagarPetro/newuser.aspx");
            }
            #endregion
            #region Assistant mechanics Registration Process
            else if (SelectedRoletext.Contains("Assistant mechanics"))
            {
                string validationMessage;
                string UserName = am_name.Text.Trim();
                string UserEmail = "";
                string UserMobile = am_mobileno.Text.Trim();
                if (string.IsNullOrEmpty(UserName))
                {
                    msg.ShowErrorMessage(this, "Please Enter Name");
                    return;
                }
                if (!IsMobileNumberValid(UserMobile))
                {
                    msg.ShowErrorMessage(this, "Please Enter Valid Mobile Number");
                    return;
                }
                if (!sagar.Validatemobilenumber(UserMobile))
                {
                    msg.ShowErrorMessage(this, "Entered Mobile Number Already Used");
                    return;
                }
                string UserAddress = am_address.Text.Trim();
                if (string.IsNullOrEmpty(UserAddress))
                {
                    msg.ShowErrorMessage(this, "Entered Enter Address");
                    return;
                }
                string UserDistrict = string.Empty;
                string UserState = am_ddlstate.SelectedItem.Value;
                if (string.IsNullOrEmpty(am_ddlstate.SelectedItem.Value))
                {
                    msg.ShowErrorMessage(this, "Please Select State");
                    return;
                }
                else
                {
                    UserState = am_ddlstate.SelectedItem.Value;
                }
                if (UserState == "0")
                {
                    msg.ShowErrorMessage(this, "Please Select State");
                    return;
                }
                if (string.IsNullOrEmpty(am_ddldistrict.SelectedItem.Value))
                {
                    msg.ShowErrorMessage(this, "Please Select District");
                    return;
                }
                else
                {
                     UserDistrict = am_ddldistrict.SelectedItem.Value;
                }
                if (UserDistrict == "0")
                {
                    msg.ShowErrorMessage(this, "Please Select District");
                    return;
                }

                string UserCity = am_ddlcity.SelectedItem.Value;
                if (string.IsNullOrEmpty(am_ddlcity.SelectedItem.Value))
                {
                    msg.ShowErrorMessage(this, "Please Select City");
                    return;
                }
                else
                {
                    UserCity = am_ddlcity.SelectedItem.Value;
                }
                if (UserCity == "0")
                {
                    msg.ShowErrorMessage(this, "Please Select City");
                    return;
                }

                string UserPin = am_pincode.Text.Trim();
                if (string.IsNullOrEmpty(UserPin))
                {
                    msg.ShowErrorMessage(this, "Please Enter Pin Code");
                    return;
                }
                int Machanictype = Convert.ToInt32(am_machinctype.SelectedItem.Value);
                if (Machanictype == 0)
                {
                    msg.ShowErrorMessage(this, "Please Select Mechanic Type");
                    return;
                }
                string UserDOB = Request.Form["ctl00$ContentPlaceHolder1$txtDate"];
                if (!IsValidAge(UserDOB, 18, out validationMessage))
                {
                    msg.ShowErrorMessage(this, validationMessage);
                    return;
                }
                string selectedGender = string.Empty;
                if (rbl_amgendormale.Checked)
                {
                    selectedGender = rbl_amgendormale.Text;
                }
                else if (rbl_amgendorfemale.Checked)
                {
                    selectedGender = rbl_amgendorfemale.Text;
                }
                else if (rbl_amgendorother.Checked)
                {
                    selectedGender = rbl_amgendorother.Text;
                }
                else
                {
                    msg.ShowErrorMessage(this, "Please Select Gender");
                    return;
                }
                string selectedMarritalStatus = string.Empty;
                if (am_rblmarried.Checked)
                {
                    selectedMarritalStatus = am_rblmarried.Text;
                }
                else if (am_rblunmarried.Checked)
                {
                    selectedMarritalStatus = am_rblunmarried.Text;
                }
                else
                {
                    msg.ShowErrorMessage(this, "Please Select Marital Status");
                    return;
                }
                string HeadMachanicName = am_headmachanicname.SelectedItem.Value;
                if (HeadMachanicName == "0")
                {
                    msg.ShowErrorMessage(this, "Please Select Head Machanic");
                    return;
                }

                
                DataTable dt = sagar.Assismachanicreg("USP_RegisterUser_SP", UserName, UserMobile, UserDistrict, UserState, null, UserAddress, UserCity, UserPin, Machanictype, UserDOB, selectedGender, selectedMarritalStatus, SelectedRoleid, HeadMachanicName, UserEmail, Session["CompanyId"].ToString());

                string registrationMessage = dt.Rows[0][0].ToString();
                if (registrationMessage == "Entered Mobile Number Already Used" || registrationMessage == "Entered Email Id Already Used" || registrationMessage == "Entered email is deleted kindy connect to Administrator")
                {
                    msg.ShowErrorMessage(this, registrationMessage);
                    return;
                }
                DataTable dtconsumer = SQL_DB.ExecuteDataTable("select*from M_Consumer where MobileNo='" + UserMobile + "' and IsDelete=0");
                if (dtconsumer.Rows.Count == 0)
                {
                    McRegistration(UserMobile);
                }
                int userRoleId = GetUserRoleId(UserEmail, UserMobile);
                if (userRoleId == 0)
                    return;
                string userPassword = GetUserPassword(UserEmail, UserMobile);
                mail.Name = UserName;
                mail.Email = UserEmail;
                mail.Mobile = UserMobile;
                mail.Subject = "New Registration";
                mail.LoginID = UserEmail;
                mail.Password = userPassword;
               // string mailresponse = db.PostCall(mail.GetJson(), "api/sendmailregistration", "https://vrkableuat.vcqru.com/");

                #region Uncomment if Need menu Assign to Assitant Mechanic
                //UpdateMenuPermissions(Chkcodecheck, userRoleId);
                //UpdateMenuPermissions(Chkdashboard, userRoleId);
                //UpdateMenuPermissions(ChkReport, userRoleId);
                //UpdateMenuPermissions(ChkUsers, userRoleId);
                //UpdateMenuPermissions(ChkProduct, userRoleId);
                //UpdateMenuPermissions(ChkService, userRoleId);
                //UpdateMenuPermissions(ChKLabel, userRoleId);
                //UpdateMenuPermissions(ChkScrap, userRoleId);
                #endregion
                ClearFields();
                msg.ShowSuccessMessagewithredirect(this, "Registered Successfully", "../SagarPetro/newuser.aspx");

            }
            #endregion
        }


    }
    #endregion

    private bool IsValidAge(string dobString, int requiredAge, out string validationMessage)
    {
        DateTime dob;
        if (DateTime.TryParse(dobString, out dob))
        {

            DateTime today = DateTime.Today;
            int age = today.Year - dob.Year;
            if (dob > today.AddYears(-age)) age--;
            if (age >= requiredAge)
            {
                validationMessage = "Valid age.";
                return true;
            }
            else
            {
                validationMessage = "You must be at least 18 years old.";
                return false;
            }
        }
        else
        {
            validationMessage = "Invalid date format. Please enter a valid date of birth.";
            return false;
        }
    }


    private void UpdateMenuPermissions(CheckBoxList chkList, int userRoleId)
    {
        foreach (ListItem item in chkList.Items)
        {
            int menuId = Convert.ToInt32(item.Value);
            int status = item.Selected ? 1 : 0;
            SQL_DB.ExecuteNonQuery("insert into tbl_SagarPetro_Usercontrol(MenuId,Status,UserRole_Id)values('" + menuId + "','" + status + "','" + userRoleId + "')");
        }
    }
    public string GetUserPassword(string email, string mobile)
    {
        DataTable dtUser = SQL_DB.ExecuteDataTable("SELECT ID,UserPassword FROM tbl_users_sp WHERE UserEmail = '" + email + "' AND Mobile_Number = '" + mobile + "' AND IsActive = 1");
        if (dtUser.Rows.Count > 0)
        {
            return dtUser.Rows[0]["UserPassword"].ToString();
        }
        return "0";
    }
    public int GetUserRoleId(string email, string mobile)
    {
        DataTable dtUser = SQL_DB.ExecuteDataTable("SELECT ID,UserPassword FROM tbl_users_sp WHERE  Mobile_Number = '" + mobile + "' AND IsActive = 1");
        if (dtUser.Rows.Count > 0)
        {
            return Convert.ToInt32(dtUser.Rows[0]["ID"]);
        }
        return 0;
    }

    protected void am_caldob_SelectionChanged(object sender, EventArgs e)
    {

    }

    protected void am_imgcalendar_Click(object sender, ImageClickEventArgs e)
    {

    }
    public void BindAllMenus()
    {
        BindMenu(Chkdashboard, 1);
        BindMenu(ChkReport, 3);
       // BindMenu(ChkCompprofile, 31);
        BindMenu(ChkScrap, 20);
        BindMenu(ChKLabel, 23);
        BindMenu(ChkProduct, 14);
        BindMenu(ChkUsers, 2);
        BindMenu(ChkService, 17);
    }
    public void BindMenu(Control checkboxControl, int refMenuId)
    {
        DataTable dt = SQL_DB.ExecuteDataTable("SELECT MenuItemID, MenuItemName FROM MenuItem_Sagar_petro WHERE RefMenu = '" + refMenuId + "'");
        CheckBoxList chkList = (CheckBoxList)checkboxControl;
        chkList.DataValueField = "MenuItemID";
        chkList.DataTextField = "MenuItemName";
        chkList.DataSource = dt;
        chkList.DataBind();
    }
    public static bool IsMobileNumberValid(string mobileNumber)
    {
        string pattern = @"^[5-9][0-9]{9}$";
        Regex regex = new Regex(pattern);
        Match match = regex.Match(mobileNumber);
        return match.Success;
    }
    public static bool IsEmailValid(string emailAddress)
    {
        string pattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
        Regex regex = new Regex(pattern);
        Match match = regex.Match(emailAddress);
        return match.Success;
    }
    public static bool IsValidUserName(string username)
    {
        string pattern = "^[A-Za-z\\s]+$";
        return Regex.IsMatch(username, pattern);
    }
    private bool IsValidInput(string name, string email, string mobile, string District, string State)
    {
        if (!IsValidUserName(name))
        {
            msg.ShowErrorMessage(this, "Please Enter Valid User Name");
            return false;
        }

        if (!IsEmailValid(email))
        {
            msg.ShowErrorMessage(this, "Please Enter Valid Email Id");
            return false;
        }

        if (!IsMobileNumberValid(mobile))
        {
            msg.ShowErrorMessage(this, "Please Enter Valid Mobile Number");
            return false;
        }

        if (string.IsNullOrEmpty(District))
        {
            msg.ShowErrorMessage(this, "Please Enter Valid District Name");
            return false;
        }
        if (string.IsNullOrEmpty(State))
        {
            msg.ShowErrorMessage(this, "Please Enter Valid State Name");
            return false;
        }


        return true;
    }

    #region Clear All field after registration
    public void ClearFields()
    {
        username.Text = "";
        userEmail.Text = "";
        userMobile.Text = "";
        ddldistrict.ClearSelection();
        m_ddlstate.ClearSelection();

        // Clear checkbox lists
        Chkdashboard.ClearSelection();
        ChkReport.ClearSelection();
        ChkUsers.ClearSelection();
        ChkProduct.ClearSelection();
        ChkService.ClearSelection();
        ChKLabel.ClearSelection();
        ChkScrap.ClearSelection();

        am_name.Text = "";
        am_email.Text = "";
        am_mobileno.Text = "";
        am_address.Text = "";
        am_ddldistrict.ClearSelection();
        am_ddlstate.ClearSelection();
        am_ddlcity.ClearSelection();
        am_pincode.Text = "";
        am_machinctype.SelectedIndex = -1;
        txtDate.Text = "";
        rbl_amgendormale.Checked = false;
        rbl_amgendorfemale.Checked = false;
        rbl_amgendorother.Checked = false;
        am_rblmarried.Checked = false;
        am_rblunmarried.Checked = false;
        am_headmachanicname.SelectedIndex = -1;


        hm_address.Text = "";
        ddlcity.ClearSelection();
        hm_ddlmachnictype.ClearSelection();
        hm_ddldistrict.ClearSelection();
        hm_dob.Text = "";
        hm_Emailid.Text = "";
        hm_mobileno.Text = "";
        hm_pincode.Text = "";
        hm_ddlstate.ClearSelection();
        hm_txtname.Text = "";
        genderMale.Checked = false;
        genderFemale.Checked = false;
        genderOther.Checked = false;
        rblmarried.Checked = false;
        rblunmarried.Checked = false;


    }
    #endregion

   


    #region Old Code
   
    public void bindstate()
    {
        DataTable dtstate = SQL_DB.ExecuteDataTable("select StateID,State_Name from StateMaster_SP where Isdelete=0");
        if (dtstate.Rows.Count > 0)
        {
            am_ddlstate.DataSource = dtstate;
            am_ddlstate.DataTextField = "State_Name";
            am_ddlstate.DataValueField = "StateID";
            am_ddlstate.DataBind();
            am_ddlstate.Items.Insert(0, new ListItem("--Select State--", "0"));
            am_ddlstate.SelectedIndex = 0;
            am_ddlstate.Items[0].Attributes["disabled"] = "disabled";
            hm_ddlstate.DataSource = dtstate;
            hm_ddlstate.DataTextField = "State_Name";
            hm_ddlstate.DataValueField = "StateID";
            hm_ddlstate.DataBind();
            hm_ddlstate.Items.Insert(0, new ListItem("--Select State--", "0"));
            hm_ddlstate.SelectedIndex = 0;
            hm_ddlstate.Items[0].Attributes["disabled"] = "disabled";
            m_ddlstate.DataSource = dtstate;
            m_ddlstate.DataTextField = "State_Name";
            m_ddlstate.DataValueField = "StateID";
            m_ddlstate.DataBind();
            m_ddlstate.Items.Insert(0, new ListItem("--Select State--", "0"));
            m_ddlstate.SelectedIndex = 0;
            m_ddlstate.Items[0].Attributes["disabled"] = "disabled";
            am_ddlstate.Enabled = true;


        }
    }
    public void binddistrict(int Stateid)
    {
        DataTable dtdistrict = SQL_DB.ExecuteDataTable("select DistrictID,DistrictName from DistrictMaster_SP where stateid='" + Stateid + "' and  IsDelete=0");
        ddldistrict.DataSource = dtdistrict;
        ddldistrict.DataTextField = "DistrictName";
        ddldistrict.DataValueField = "DistrictID";
        ddldistrict.DataBind();
        ddldistrict.Items.Insert(0, new ListItem("--Select District--", "0"));
        ddldistrict.SelectedIndex = 0;
        ddldistrict.Items[0].Attributes["disabled"] = "disabled";

        hm_ddldistrict.DataSource = dtdistrict;
        hm_ddldistrict.DataTextField = "DistrictName";
        hm_ddldistrict.DataValueField = "DistrictID";
        hm_ddldistrict.DataBind();
        hm_ddldistrict.Items.Insert(0, new ListItem("--Select District--", "0"));
        hm_ddldistrict.SelectedIndex = 0;
        hm_ddldistrict.Items[0].Attributes["disabled"] = "disabled";

        am_ddldistrict.DataSource = dtdistrict;
        am_ddldistrict.DataTextField = "DistrictName";
        am_ddldistrict.DataValueField = "DistrictID";
        am_ddldistrict.DataBind();
        am_ddldistrict.Items.Insert(0, new ListItem("--Select District--", "0"));
        am_ddldistrict.SelectedIndex = 0;
        am_ddldistrict.Items[0].Attributes["disabled"] = "disabled";
    }
    public void bindcity(int DistrictId)
    {
        DataTable dtcity = SQL_DB.ExecuteDataTable("select City_ID,City_Name from CityMaster_SP where DistrictID='" + DistrictId + "' and IsDelete=0");
        if (dtcity.Rows.Count > 0)
        {
            ddlcity.DataSource = dtcity;
            ddlcity.DataTextField = "City_Name";
            ddlcity.DataValueField = "City_ID";
            ddlcity.DataBind();
            ddlcity.Items.Insert(0, new ListItem("--Select City--", "0"));
            ddlcity.SelectedIndex = 0;
            ddlcity.Items[0].Attributes["disabled"] = "disabled";

            am_ddlcity.DataSource = dtcity;
            am_ddlcity.DataTextField = "City_Name";
            am_ddlcity.DataValueField = "City_ID";
            am_ddlcity.DataBind();
            am_ddlcity.Items.Insert(0, new ListItem("--Select City--", "0"));
            am_ddlcity.SelectedIndex = 0;
            am_ddlcity.Items[0].Attributes["disabled"] = "disabled";

        }
    }
    

    protected void am_ddlstate_SelectedIndexChanged(object sender, EventArgs e)
    {
        am_ddldistrict.Enabled = false;
        am_ddldistrict.Items.Clear();
        am_ddldistrict.Items.Insert(0, new ListItem("Select District", "0"));
        int stateId = int.Parse(am_ddlstate.SelectedItem.Value);
        if (stateId > 0)
        {
            binddistrict(stateId);
            // bindcityforassistant(stateId);
            am_ddldistrict.Enabled = true;
        }
        am_ddlcity.Enabled = false;
        am_ddlcity.Items.Insert(0, new ListItem("Select City", "0"));
    }
    protected void am_ddldistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        am_ddlcity.Enabled = false;
        am_ddlcity.Items.Clear();
        am_ddlcity.Items.Insert(0, new ListItem("Select City", "0"));
        int Districtid = int.Parse(am_ddldistrict.SelectedItem.Value);
        if (Districtid > 0)
        {
            bindcity(Districtid);
            am_ddlcity.Enabled = true;
            bindheadmachanic(Districtid);
        }
    }



    protected void m_ddlstate_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddldistrict.Enabled = false;
        ddldistrict.Items.Clear();
        ddldistrict.Items.Insert(0, new ListItem("Select district", "0"));
        int stateId = int.Parse(m_ddlstate.SelectedItem.Value);
        if (stateId > 0)
        {
            binddistrict(stateId);
           // bindcity(stateId);
            ddldistrict.Enabled = true;
        }
       
    }
    protected void hm_ddlstate_SelectedIndexChanged(object sender, EventArgs e)
    {
        hm_ddldistrict.Enabled = false;
        hm_ddldistrict.Items.Clear();
        hm_ddldistrict.Items.Insert(0, new ListItem("Select City", "0"));
        int stateId = int.Parse(hm_ddlstate.SelectedItem.Value);
        //int stateId = int.Parse(hm_ddlstate.SelectedItem.Value);
        if (stateId > 0)
        {
            binddistrict(stateId);
            hm_ddldistrict.Enabled = true;
        }
        ddlcity.Enabled = false;
        ddlcity.Items.Insert(0, new ListItem("Select City", "0"));
    }

    protected void hm_ddldistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlcity.Enabled = false;
        ddlcity.Items.Clear();
        ddlcity.Items.Insert(0, new ListItem("Select City", "0"));
        int Districtid = int.Parse(hm_ddldistrict.SelectedItem.Value);
        //int stateId = int.Parse(hm_ddlstate.SelectedItem.Value);
        if (Districtid > 0)
        {
            bindcity(Districtid);
            ddlcity.Enabled = true;
        }
    }
  
    #endregion


}