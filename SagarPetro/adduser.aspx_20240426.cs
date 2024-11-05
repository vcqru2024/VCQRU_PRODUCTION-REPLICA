using RestSharp;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Http;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patanjali_adduser : System.Web.UI.Page
{
    int UserRoleID = 0;
    cls_patanjali db = new cls_patanjali();
    string Comp_id = "";
    SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);
    SqlCommand cmd;
    string query;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Session["Comp_ID"] == null)
            Response.Redirect("../Patanjali/Loginpfl.aspx?From=adduser");
        if (!IsPostBack)
        {
            if (!String.IsNullOrEmpty(Request.QueryString["id"]))
            {
                UserRoleID = Convert.ToInt32(Request.QueryString["id"]);
                DataTable dt = db.GetRegisteredUserData("USP_PFLGETUserROLEData", UserRoleID);
                if (dt.Rows.Count > 0)
                {
                    username.Text = dt.Rows[0]["UserName"].ToString();
                    username.ReadOnly = true;
                    userEmail.Text = dt.Rows[0]["UserEmail"].ToString();
                    userEmail.ReadOnly = true;
                    userMobile.Text = dt.Rows[0]["UserMobile"].ToString();
                    userMobile.ReadOnly = true;
                    bindreport(UserRoleID);
                    btnSubmit.Text = "Update";
                    ViewState["UserRoleID"] = UserRoleID;
                }
            }
            else
            {
                bindmenuall();
            }
        }
        else
        {
            if (!String.IsNullOrEmpty(Request.QueryString["id"]))
            {
                UserRoleID = Convert.ToInt32(Request.QueryString["id"]);
            }
        }

    }

    public void bindreport(int RoleId)
    {
        
        DataTable dt = bindOther1(RoleId, "1");
        if (dt.Rows.Count > 0)
        {
            bindchk(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (Convert.ToBoolean(dt.Rows[i]["Status"]) == true)
                {
                    Chkdashboard.Items[i].Selected = true;
                }
                else
                {
                    Chkdashboard.Items[i].Selected = false;
                }
            }
        }
        else
        {
            dt = SQL_DB.ExecuteDataTable("select MenuItemID,MenuItemName from MenuItem_PfL where RefMenu=1");
            Chkdashboard.DataValueField = "MenuItemID";
            Chkdashboard.DataTextField = "MenuItemName";
            Chkdashboard.DataSource = dt;
            Chkdashboard.DataBind();
        }
        dt = dt = bindOther1(RoleId, "3");
        if (dt.Rows.Count > 0)
        {
            bindchkReport(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["Status"].ToString() == "1")
                {
                    ChkReport.Items[i].Selected = true;
                }
                else
                {
                    ChkReport.Items[i].Selected = false;
                }
            }
        }
        else
        {
            dt = SQL_DB.ExecuteDataTable("select MenuItemID,MenuItemName from MenuItem_PfL where RefMenu=3");
            ChkReport.DataValueField = "MenuItemID";
            ChkReport.DataTextField = "MenuItemName";
            ChkReport.DataSource = dt;
            ChkReport.DataBind();
        }
        dt = dt = bindOther1(RoleId, "2");
        if (dt.Rows.Count > 0)
        {
            bindchkUsers(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["Status"].ToString() == "1")
                {
                    ChkUsers.Items[i].Selected = true;
                }
                else
                {
                    ChkUsers.Items[i].Selected = false;
                }
            }
        }
        else
        {
            dt = SQL_DB.ExecuteDataTable("select MenuItemID,MenuItemName from MenuItem_PfL where RefMenu=2");
            ChkUsers.DataValueField = "MenuItemID";
            ChkUsers.DataTextField = "MenuItemName";
            ChkUsers.DataSource = dt;
            ChkUsers.DataBind();
        }
        dt = dt = bindOther1(RoleId, "14");
        if (dt.Rows.Count > 0)
        {
            bindchkProductParticulars(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["Status"].ToString() == "1")
                {
                    ChkProduct.Items[i].Selected = true;
                }
                else
                {
                    ChkProduct.Items[i].Selected = false;
                }
            }
        }
        else
        {
            dt = SQL_DB.ExecuteDataTable("select MenuItemID,MenuItemName from MenuItem_PfL Where RefMenu=14");
            ChkProduct.DataValueField = "MenuItemID";
            ChkProduct.DataTextField = "MenuItemName";
            ChkProduct.DataSource = dt;
            ChkProduct.DataBind();
        }
        dt = dt = bindOther1(RoleId, "17");
        if (dt.Rows.Count > 0)
        {
            bindchkOurService(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["Status"].ToString() == "1")
                {
                    ChkService.Items[i].Selected = true;
                }
                else
                {
                    ChkService.Items[i].Selected = false;
                }
            }
        }
        else
        {
            dt = SQL_DB.ExecuteDataTable("select MenuItemID,MenuItemName from MenuItem_PfL where RefMenu=17");
            ChkService.DataValueField = "MenuItemID";
            ChkService.DataTextField = "MenuItemName";
            ChkService.DataSource = dt;
            ChkService.DataBind();
        }
        dt = dt = bindOther1(RoleId, "22");
        //if (dt.Rows.Count > 0)
        //{
        //    bindchkTransactionSetting(dt);
        //    for (int i = 0; i < dt.Rows.Count; i++)
        //    {
        //        if (dt.Rows[i]["Status"].ToString() == "1")
        //        {
        //            ChkTransaction.Items[i].Selected = true;
        //        }
        //        else
        //        {
        //            ChkTransaction.Items[i].Selected = false;
        //        }
        //    }
        //}
        //else
        //{
        //    dt = SQL_DB.ExecuteDataTable("select MenuItemID,MenuItemName from MenuItem_PfL where RefMenu=22");
        //    ChkTransaction.DataValueField = "MenuItemID";
        //    ChkTransaction.DataTextField = "MenuItemName";
        //    ChkTransaction.DataSource = dt;
        //    ChkTransaction.DataBind();
        //}
        dt = dt = bindOther1(RoleId, "23");
        if (dt.Rows.Count > 0)
        {
            bindchkLabelSection(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["Status"].ToString() == "1")
                {
                    ChKLabel.Items[i].Selected = true;
                }
                else
                {
                    ChKLabel.Items[i].Selected = false;
                }
            }
        }
        else
        {
            dt = SQL_DB.ExecuteDataTable("select MenuItemID,MenuItemName from MenuItem_PfL where RefMenu=23");
            ChKLabel.DataValueField = "MenuItemID";
            ChKLabel.DataTextField = "MenuItemName";
            ChKLabel.DataSource = dt;
            ChKLabel.DataBind();
        }
      
        dt = dt = bindOther1(RoleId, "20");
        if (dt.Rows.Count > 0)
        {
            bindchkScrapParticulars(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["Status"].ToString() == "1")
                {
                    ChkScrap.Items[i].Selected = true;
                }
                else
                {
                    ChkScrap.Items[i].Selected = false;
                }
            }
        }
        else
        {
            dt = SQL_DB.ExecuteDataTable("select MenuItemID,MenuItemName from MenuItem_PfL where RefMenu=20");
            ChkScrap.DataValueField = "MenuItemID";
            ChkScrap.DataTextField = "MenuItemName";
            ChkScrap.DataSource = dt;
            ChkScrap.DataBind();
        }
    }

   
    protected void bindchk(DataTable dt)
    {
        try
        {
            // DataTable dt = bindOther1(Comp_id, "1");
            if (dt != null)
            {
              
                Chkdashboard.DataValueField = "MenuItemID";
                Chkdashboard.DataTextField = "MenuItemName";
                Chkdashboard.DataSource = dt;
                Chkdashboard.DataBind();
            }
            dt = null;
        }
        catch (Exception ex)
        {
            // Handle the exception here
        }
    }
    protected void bindchkReport(DataTable dt)
    {
        try
        {
            //DataTable dt = bindOther1(Comp_id, "2");
            if (dt != null)
            {
                ChkReport.DataValueField = "MenuItemID";
                ChkReport.DataTextField = "MenuItemName";
                ChkReport.DataSource = dt;
                ChkReport.DataBind();
            }
            dt = null;
        }
        catch (Exception ex)
        {
            // Handle the exception here
        }
    }

    protected void bindchkUsers(DataTable dt)
    {
        try
        {
            //DataTable dt = bindOther1(Comp_id, "10");
            if (dt != null)
            {
                ChkUsers.DataValueField = "MenuItemID";
                ChkUsers.DataTextField = "MenuItemName";
                ChkUsers.DataSource = dt;
                ChkUsers.DataBind();
            }
            dt = null;
        }
        catch (Exception ex)
        {
            // Handle the exception here
        }
    }
    protected void bindchkProductParticulars(DataTable dt)
    {
        try
        {
            //DataTable dt = bindOther1(Comp_id, "14");
            if (dt != null)
            {
                ChkProduct.DataValueField = "MenuItemID";
                ChkProduct.DataTextField = "MenuItemName";
                ChkProduct.DataSource = dt;
                ChkProduct.DataBind();
            }
            dt = null;
        }
        catch (Exception ex)
        {
            // Handle the exception here
        }
    }
    protected void bindchkOurService(DataTable dt)
    {
        try
        {
            //DataTable dt = bindOther1(Comp_id, "18");
            if (dt != null)
            {
                ChkService.DataValueField = "MenuItemID";
                ChkService.DataTextField = "MenuItemName";
                ChkService.DataSource = dt;
                ChkService.DataBind();
            }
            dt = null;
        }
        catch (Exception ex)
        {
            // Handle the exception here
        }
    }
    //protected void bindchkTransactionSetting(DataTable dt)
    //{
    //    try
    //    {
    //        //DataTable dt = bindOther1(Comp_id, "22");
    //        if (dt != null)
    //        {
    //            ChkTransaction.DataValueField = "MenuItemID";
    //            ChkTransaction.DataTextField = "MenuItemName";
    //            ChkTransaction.DataSource = dt;
    //            ChkTransaction.DataBind();
    //        }
    //        dt = null;
    //    }
    //    catch (Exception ex)
    //    {
    //        // Handle the exception here
    //    }
    //}
    protected void bindchkLabelSection(DataTable dt)
    {
        try
        {
            //DataTable dt = bindOther1(Comp_id, "33");
            if (dt != null)
            {
                ChKLabel.DataValueField = "MenuItemID";
                ChKLabel.DataTextField = "MenuItemName";
                ChKLabel.DataSource = dt;
                ChKLabel.DataBind();
            }
            dt = null;
        }
        catch (Exception ex)
        {
            // Handle the exception here
        }
    }
   
    protected void bindchkScrapParticulars(DataTable dt)
    {
        try
        {
            //DataTable dt = bindOther1(Comp_id, "39");
            if (dt != null)
            {
                ChkScrap.DataValueField = "MenuItemID";
                ChkScrap.DataTextField = "MenuItemName";
                ChkScrap.DataSource = dt;
                ChkScrap.DataBind();
            }
            dt = null;
        }
        catch (Exception ex)
        {
            // Handle the exception here
        }
    }
   
  

    protected DataTable bindOther1(int RoleId, string RefMenuId)
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("USP_PFLGetAllMenuItems", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@RoleID", RoleId);
        cmd.Parameters.AddWithValue("@RefMenuId", RefMenuId);
        DataTable dt = new DataTable();
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        adp.Fill(dt);
        con.Close();
        return dt;
    }


    //public string getPatanjaliDemonew(string name, string email, string cmobile)
    //{
    //    var client = new HttpClient();
    //    var request = new HttpRequestMessage(HttpMethod.Get, "https://qa.vcqru.com/Info/MasterHandler.ashx?method=PatanjaliRegistrationDeno&name=" + name + "&email=" + email + "&cmobile=" + cmobile + "");
    //    request.Headers.Add("Cookie", "ASP.NET_SessionId=mjkjnv0e0sfaiqjdd5l4c3k5");

    //    var response = client.SendAsync(request).Result; // Blocking call to get the response synchronously
    //    response.EnsureSuccessStatusCode();

    //    return response.Content.ReadAsStringAsync().Result; // Blocking call to read the response content synchronously
    //}

    public string getPatanjaliDemonew(string name, string email, string cmobile)
    {
        var options = "https://qa.vcqru.com/";
        var client = new RestClient(options);
        var request = new RestRequest("../Info/MasterHandler.ashx?method=PatanjaliRegistrationDeno&name=" + name + "&email=" + email + "&cmobile=" + cmobile, Method.Get);
        request.AddHeader("Cookie", "ASP.NET_SessionId=gfyn4xtzlrnl55rpfbxp1o3d");
        RestResponse response = client.Execute(request);
        return response.Content;
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if(btnSubmit.Text== "Update")
        {
            if (UserRoleID==0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Something Went Wrong Please try After', 'error');", true);
                return;
            }
           
                
           
            DataTable dtget = SQL_DB.ExecuteDataTable("Select MenuId,Status from tbl_pflUsercontrol where UserRole_Id = '" + UserRoleID + "'");

            if (dtget.Rows.Count > 0)
            {
                #region Update Report for Dashboard
                for (int i = 0; i < Chkdashboard.Items.Count; i++)
                {
                    if (Chkdashboard.Items[i].Selected)
                    {
                        int chked = Convert.ToInt32(Chkdashboard.Items[i].Value);
                        SQL_DB.ExecuteNonQuery("update tbl_pflUsercontrol set Status=1 where MenuId='" + chked + "' and UserRole_Id='" + UserRoleID + "'");
                    }
                    else
                    {
                        int chked = Convert.ToInt32(Chkdashboard.Items[i].Value);

                        SQL_DB.ExecuteNonQuery("update tbl_pflUsercontrol set Status=0 where MenuId='" + chked + "' and UserRole_Id='" + UserRoleID + "'");
                    }
                }
                #endregion
                #region Update Report for Report
                for (int i = 0; i < ChkReport.Items.Count; i++)
                {
                    if (ChkReport.Items[i].Selected)
                    {
                        int chked = Convert.ToInt32(ChkReport.Items[i].Value);
                        SQL_DB.ExecuteNonQuery("update tbl_pflUsercontrol set Status=1 where MenuId='" + chked + "' and UserRole_Id='" + UserRoleID + "'");
                    }
                    else
                    {
                        int chked = Convert.ToInt32(ChkReport.Items[i].Value);

                        SQL_DB.ExecuteNonQuery("update tbl_pflUsercontrol set Status=0 where MenuId='" + chked + "' and UserRole_Id='" + UserRoleID + "'");
                    }
                }
                #endregion
                #region Update Report for Profile
                for (int i = 0; i < ChkUsers.Items.Count; i++)
                {
                    if (ChkUsers.Items[i].Selected)
                    {
                        int chked = Convert.ToInt32(ChkUsers.Items[i].Value);
                        SQL_DB.ExecuteNonQuery("update tbl_pflUsercontrol set Status=1 where MenuId='" + chked + "' and UserRole_Id='" + UserRoleID + "'");
                    }
                    else
                    {
                        int chked = Convert.ToInt32(ChkUsers.Items[i].Value);

                        SQL_DB.ExecuteNonQuery("update tbl_pflUsercontrol set Status=0 where MenuId='" + chked + "' and UserRole_Id='" + UserRoleID + "'");
                    }
                }
                #endregion
                #region Update Report for Product
                for (int i = 0; i < ChkProduct.Items.Count; i++)
                {
                    if (ChkProduct.Items[i].Selected)
                    {
                        int chked = Convert.ToInt32(ChkProduct.Items[i].Value);
                        SQL_DB.ExecuteNonQuery("update tbl_pflUsercontrol set Status=1 where MenuId='" + chked + "' and UserRole_Id='" + UserRoleID + "'");
                    }
                    else
                    {
                        int chked = Convert.ToInt32(ChkProduct.Items[i].Value);

                        SQL_DB.ExecuteNonQuery("update tbl_pflUsercontrol set Status=0 where MenuId='" + chked + "' and UserRole_Id='" + UserRoleID + "'");
                    }
                }
                #endregion
                #region Update Report for Dashboard
                for (int i = 0; i < ChkService.Items.Count; i++)
                {
                    if (ChkService.Items[i].Selected)
                    {
                        int chked = Convert.ToInt32(ChkService.Items[i].Value);
                        SQL_DB.ExecuteNonQuery("update tbl_pflUsercontrol set Status=1 where MenuId='" + chked + "' and UserRole_Id='" + UserRoleID + "'");
                    }
                    else
                    {
                        int chked = Convert.ToInt32(ChkService.Items[i].Value);

                        SQL_DB.ExecuteNonQuery("update tbl_pflUsercontrol set Status=0 where MenuId='" + chked + "' and UserRole_Id='" + UserRoleID + "'");
                    }
                }
                #endregion
                //#region Update Report for Transaction
                //for (int i = 0; i < ChkTransaction.Items.Count; i++)
                //{
                //    if (ChkTransaction.Items[i].Selected)
                //    {
                //        int chked = Convert.ToInt32(ChkTransaction.Items[i].Value);
                //        SQL_DB.ExecuteNonQuery("update tbl_pflUsercontrol set Status=1 where MenuId='" + chked + "' and UserRole_Id='" + UserRoleID + "'");
                //    }
                //    else
                //    {
                //        int chked = Convert.ToInt32(ChkTransaction.Items[i].Value);
                //        SQL_DB.ExecuteNonQuery("update tbl_pflUsercontrol set Status=0 where MenuId='" + chked + "' and UserRole_Id='" + UserRoleID + "'");
                //    }
                //}
                //#endregion
                #region Update Report for Lable
                for (int i = 0; i < ChKLabel.Items.Count; i++)
                {
                    if (ChKLabel.Items[i].Selected)
                    {
                        int chked = Convert.ToInt32(ChKLabel.Items[i].Value);
                        SQL_DB.ExecuteNonQuery("update tbl_pflUsercontrol set Status=1 where MenuId='" + chked + "' and UserRole_Id='" + UserRoleID + "'");
                    }
                    else
                    {
                        int chked = Convert.ToInt32(ChKLabel.Items[i].Value);
                        SQL_DB.ExecuteNonQuery("update tbl_pflUsercontrol set Status=0 where MenuId='" + chked + "' and UserRole_Id='" + UserRoleID + "'");
                    }
                }
                #endregion
                #region Update Report for Scrap
                for (int i = 0; i < ChkScrap.Items.Count; i++)
                {
                    if (ChkScrap.Items[i].Selected)
                    {
                        int chked = Convert.ToInt32(ChkScrap.Items[i].Value);
                        SQL_DB.ExecuteNonQuery("update tbl_pflUsercontrol set Status=1 where MenuId='" + chked + "' and UserRole_Id='" + UserRoleID + "'");
                    }
                    else
                    {
                        int chked = Convert.ToInt32(ChkScrap.Items[i].Value);

                        SQL_DB.ExecuteNonQuery("update tbl_pflUsercontrol set Status=0 where MenuId='" + chked + "' and UserRole_Id='" + UserRoleID + "'");
                    }
                }
                #endregion

                ScriptManager.RegisterStartupScript(this, GetType(), "Updated", "showAlert('Success', 'Updated Successfully!', 'success');", true);
                return;
            }
        }
        #region Registration Process Patanjali Users
        else
        {
            string Name = username.Text;
            string Email = userEmail.Text;
            string Mobile = userMobile.Text;
            bool isValid = IsMobileNumberValid(Mobile);
            bool isValidEmail = IsEmailValid(Email);
            if (!isValid)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please Enter Valid Mobie Number', 'error');", true);
                return;
            }
            if (!isValidEmail)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please Enter Valid Email Id', 'error');", true);
                return;
            }
            if (!string.IsNullOrEmpty(Name) && !string.IsNullOrEmpty(Email) && !string.IsNullOrEmpty(Mobile))
            {
                DataTable dt = db.RegisterUser("Insert_pflUser  ", Mobile, Email, Name, "Comp-1311");
                if (dt.Rows[0][0].ToString()!= "Entered Mobile Number Already Used" || dt.Rows[0][0].ToString() != "Entered Email Id Already Used")
                {
                    userMobile.Text = "";
                    userEmail.Text = "";
                    username.Text = "";
                    DataTable dtUser = SQL_DB.ExecuteDataTable("select Userrole_id from tbl_pflUsers where UserEmail='" + Email + "' and UserMobile='" + Mobile + "' and IsActive=1 ");
                    if (dtUser.Rows.Count > 0)
                    {
                        string UserRoleId = dtUser.Rows[0][0].ToString();
                        #region Loop for Insert Dashboard Menu Selection 
                        for (int i = 0; i < Chkdashboard.Items.Count; i++)
                        {
                            if (Chkdashboard.Items[i].Selected)
                            {
                                int chked = Convert.ToInt32(Chkdashboard.Items[i].Value);
                                SQL_DB.ExecuteNonQuery("insert into tbl_pflUsercontrol (MenuId,Status,UserRole_Id) values('" + chked + "',1,'" + UserRoleId + "')");
                            }
                            else
                            {
                                int chked = Convert.ToInt32(Chkdashboard.Items[i].Value);
                                SQL_DB.ExecuteNonQuery("insert into tbl_pflUsercontrol (MenuId,Status,UserRole_Id) values('" + chked + "',0,'" + UserRoleId + "')");
                            }
                        }
                        #endregion
                        #region  Loop for Insert Report Menu Selection 
                        for (int i = 0; i < ChkReport.Items.Count; i++)
                        {
                            if (ChkReport.Items[i].Selected)
                            {
                                int chked = Convert.ToInt32(ChkReport.Items[i].Value);
                                SQL_DB.ExecuteNonQuery("insert into tbl_pflUsercontrol (MenuId,Status,UserRole_Id) values('" + chked + "',1,'" + UserRoleId + "')");
                            }
                            else
                            {
                                int chked = Convert.ToInt32(ChkReport.Items[i].Value);
                                SQL_DB.ExecuteNonQuery("insert into tbl_pflUsercontrol (MenuId,Status,UserRole_Id) values('" + chked + "',0,'" + UserRoleId + "')");
                            }
                        }
                        #endregion
                        #region  Loop for Insert Users Menu Selection 
                        for (int i = 0; i < ChkUsers.Items.Count; i++)
                        {
                            if (ChkUsers.Items[i].Selected)
                            {
                                int chked = Convert.ToInt32(ChkUsers.Items[i].Value);
                                SQL_DB.ExecuteNonQuery("insert into tbl_pflUsercontrol (MenuId,Status,UserRole_Id) values('" + chked + "',1,'" + UserRoleId + "')");
                            }
                            else
                            {
                                int chked = Convert.ToInt32(ChkUsers.Items[i].Value);
                                SQL_DB.ExecuteNonQuery("insert into tbl_pflUsercontrol (MenuId,Status,UserRole_Id) values('" + chked + "',0,'" + UserRoleId + "')");
                            }
                        }
                        #endregion
                        #region  Loop for Insert Product Menu Selection 
                        for (int i = 0; i < ChkProduct.Items.Count; i++)
                        {
                            if (ChkProduct.Items[i].Selected)
                            {
                                int chked = Convert.ToInt32(ChkProduct.Items[i].Value);
                                SQL_DB.ExecuteNonQuery("insert into tbl_pflUsercontrol (MenuId,Status,UserRole_Id) values('" + chked + "',1,'" + UserRoleId + "')");
                            }
                            else
                            {
                                int chked = Convert.ToInt32(ChkProduct.Items[i].Value);
                                SQL_DB.ExecuteNonQuery("insert into tbl_pflUsercontrol (MenuId,Status,UserRole_Id) values('" + chked + "',0,'" + UserRoleId + "')");
                            }
                        }
                        #endregion
                        #region  Loop for Insert Service Menu Selection 
                        for (int i = 0; i < ChkService.Items.Count; i++)
                        {
                            if (ChkService.Items[i].Selected)
                            {
                                int chked = Convert.ToInt32(ChkService.Items[i].Value);
                                SQL_DB.ExecuteNonQuery("insert into tbl_pflUsercontrol (MenuId,Status,UserRole_Id) values('" + chked + "',1,'" + UserRoleId + "')");
                            }
                            else
                            {
                                int chked = Convert.ToInt32(ChkService.Items[i].Value);
                                SQL_DB.ExecuteNonQuery("insert into tbl_pflUsercontrol (MenuId,Status,UserRole_Id) values('" + chked + "',0,'" + UserRoleId + "')");
                            }
                        }
                        #endregion
                        //#region  Loop for Insert Transaction Menu Selection 
                        //for (int i = 0; i < ChkTransaction.Items.Count; i++)
                        //{
                        //    if (ChkTransaction.Items[i].Selected)
                        //    {
                        //        int chked = Convert.ToInt32(ChkTransaction.Items[i].Value);
                        //        SQL_DB.ExecuteNonQuery("insert into tbl_pflUsercontrol (MenuId,Status,UserRole_Id) values('" + chked + "',1,'" + UserRoleId + "')");
                        //    }
                        //    else
                        //    {
                        //        int chked = Convert.ToInt32(ChkTransaction.Items[i].Value);
                        //        SQL_DB.ExecuteNonQuery("insert into tbl_pflUsercontrol (MenuId,Status,UserRole_Id) values('" + chked + "',0,'" + UserRoleId + "')");
                        //    }
                        //}
                        //#endregion
                        #region  Loop for Insert Lable Menu Selection 
                        for (int i = 0; i < ChKLabel.Items.Count; i++)
                        {
                            if (ChKLabel.Items[i].Selected)
                            {
                                int chked = Convert.ToInt32(ChKLabel.Items[i].Value);
                                SQL_DB.ExecuteNonQuery("insert into tbl_pflUsercontrol (MenuId,Status,UserRole_Id) values('" + chked + "',1,'" + UserRoleId + "')");
                            }
                            else
                            {
                                int chked = Convert.ToInt32(ChKLabel.Items[i].Value);
                                SQL_DB.ExecuteNonQuery("insert into tbl_pflUsercontrol (MenuId,Status,UserRole_Id) values('" + chked + "',0,'" + UserRoleId + "')");
                            }
                        }
                        #endregion
                        #region  Loop for Insert Scrap  Menu Selection 
                        for (int i = 0; i < ChkScrap.Items.Count; i++)
                        {
                            if (ChkScrap.Items[i].Selected)
                            {
                                int chked = Convert.ToInt32(ChkScrap.Items[i].Value);
                                SQL_DB.ExecuteNonQuery("insert into tbl_pflUsercontrol (MenuId,Status,UserRole_Id) values('" + chked + "',1,'" + UserRoleId + "')");
                            }
                            else
                            {
                                int chked = Convert.ToInt32(ChkScrap.Items[i].Value);
                                SQL_DB.ExecuteNonQuery("insert into tbl_pflUsercontrol (MenuId,Status,UserRole_Id) values('" + chked + "',0,'" + UserRoleId + "')");
                            }
                        }
                        #endregion
                       // getPatanjaliDemoAsync(Name, Email, Mobile);
                      string Resp=  getPatanjaliDemonew(Name, Email, Mobile);
                        if(Resp== "Query has been sent successfully.")
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "loginSuccess", "showAlert('Success', 'Login successful!', 'success');", true);
                            Response.Redirect("../Patanjali/newuser.aspx");
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "Registration Faild", "showAlert('Error', 'Login successful!', 'success');", true);
                        }
                        
                        return;
                    }
                }
                else
                {
                   ScriptManager.RegisterStartupScript(this, GetType(), "Registration Faild", "showAlert('Error', '"+ dt.Rows[0][0].ToString() + "', 'error');", true);
                    return;
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Invalid Details", "showAlert('Error', 'Please Enter Valid Details', 'error');", true);
                return;
            }
        }
        #endregion
    }




    public static bool IsMobileNumberValid(string mobileNumber)
    {
        string pattern = @"^[0-9]{10}$";
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

    public void bindmenuall()
    {
       DataTable dt = SQL_DB.ExecuteDataTable("select MenuItemID,MenuItemName from MenuItem_PfL where RefMenu =1");
        Chkdashboard.DataValueField = "MenuItemID";
        Chkdashboard.DataTextField = "MenuItemName";
        Chkdashboard.DataSource = dt;
        Chkdashboard.DataBind();

        dt = SQL_DB.ExecuteDataTable("select MenuItemID,MenuItemName from MenuItem_PfL where RefMenu=3");
        ChkReport.DataValueField = "MenuItemID";
        ChkReport.DataTextField = "MenuItemName";
        ChkReport.DataSource = dt;
        ChkReport.DataBind();
        dt = SQL_DB.ExecuteDataTable("select MenuItemID,MenuItemName from MenuItem_PfL where RefMenu=20");
        ChkScrap.DataValueField = "MenuItemID";
        ChkScrap.DataTextField = "MenuItemName";
        ChkScrap.DataSource = dt;
        ChkScrap.DataBind();
        dt = SQL_DB.ExecuteDataTable("select MenuItemID,MenuItemName from MenuItem_PfL where RefMenu=23");
        ChKLabel.DataValueField = "MenuItemID";
        ChKLabel.DataTextField = "MenuItemName";
        ChKLabel.DataSource = dt;
        ChKLabel.DataBind();
        //dt = SQL_DB.ExecuteDataTable("select MenuItemID,MenuItemName from MenuItem_PfL where RefMenu=14");
        //ChkTransaction.DataValueField = "MenuItemID";
        //ChkTransaction.DataTextField = "MenuItemName";
        //ChkTransaction.DataSource = dt;
        //ChkTransaction.DataBind();
        dt = SQL_DB.ExecuteDataTable("select MenuItemID,MenuItemName from MenuItem_PfL Where RefMenu=14");
        ChkProduct.DataValueField = "MenuItemID";
        ChkProduct.DataTextField = "MenuItemName";
        ChkProduct.DataSource = dt;
        ChkProduct.DataBind();
        dt = SQL_DB.ExecuteDataTable("select MenuItemID,MenuItemName from MenuItem_PfL where RefMenu=2");
        ChkUsers.DataValueField = "MenuItemID";
        ChkUsers.DataTextField = "MenuItemName";
        ChkUsers.DataSource = dt;
        ChkUsers.DataBind();
        dt = SQL_DB.ExecuteDataTable("select MenuItemID,MenuItemName from MenuItem_PfL where RefMenu=17");
        ChkService.DataValueField = "MenuItemID";
        ChkService.DataTextField = "MenuItemName";
        ChkService.DataSource = dt;
        ChkService.DataBind();
    }
}