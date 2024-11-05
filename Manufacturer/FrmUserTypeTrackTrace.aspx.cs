using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Business9420;
using System.Web.Services;
using System.Web.Script.Services;
using System.IO;
using Business_Logic_Layer;

public partial class FrmUserTypeTrackTrace : System.Web.UI.Page
{
    public int str = 0, strr = 0,lflag =0; public int index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
       // string strPwd = System.Web.Security.Membership.GeneratePassword(10, 2);
        
        
        //if (Session["CompanyId"] == null)
        if (ProjectSession.strCompanyid == null || ProjectSession.strCompanyid == "")
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/Default.aspx?Page=FrmDealerMaster.aspx");
        else
        {
            if (ProjectSession.strUser_Type == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            hdncmphdn.Value = ProjectSession.strCompanyid;// Session["CompanyId"].ToString();
            lblcount.Text = "0";
            BindList();
            FillGrdVwDealerMaster();
            newMsg.Visible = false;
           
        }
        Label2.Text = "";
    }
    public void BindList()
    {
        DataTable dt = SQL_DB.ExecuteDataTable("select * from UserType_TrackTrace");
        if (dt.Rows.Count > 0)
        {
            ddlUT.DataSource = dt;
            ddlUT.DataTextField = "type";
            ddlUT.DataValueField = "TTUserTypeid";
            ddlUT.DataBind();
            ddlUT.Items.Insert(0, new ListItem("Select", "0"));
        }
        else
        {
            ddlUT.Items.Insert(0, new ListItem("Select", "0"));
        }
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {        
        newMsg.Visible = false;
        Cleartxt();
        newMsg.Visible = false;
        lblheading.Text = "Add New UserType";
        //ModalPopupCreateLabel.Show();
    }
    private void FillGrdVwDealerMaster()
    {        
       // if (Request.QueryString["utype"] != null)
        {
            //string struType = Request.QueryString["utype"].ToString();
            string strval = ddlUT.SelectedItem.Value;
            if (strval != "0")
            {
                strval = " where Type = " + ddlUT.SelectedItem.Value;
            }
            else
            {
                strval = "";
            }
            DataTable dt = SQL_DB.ExecuteDataTable("Select (select [type] from UserType_TrackTrace where  TTUserTypeid = Dealer.[Type]) as ut,* from Dealer " + strval);
            //if (dt.Rows.Count > 0)
            {
                GrdCustomer.DataSource = dt;
                GrdCustomer.DataBind();
                //if (struType == "2")
                //{
                //    lblcount.Text = GrdCustomer.Rows.Count.ToString() + " <b>Distributors</b> ";
                //}
                //else if (struType == "3")
                //{
                //    lblcount.Text = GrdCustomer.Rows.Count.ToString() + " <b>Retailers</b> ";
                //}
                if (GrdCustomer.Rows.Count > 0)
                    GrdCustomer.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }
        //Loyalty_Dealer Reg = new Loyalty_Dealer();
        //Reg.Row_ID = 0;
        //Reg.Dealer_Name = txtsearchlblname.Text.Trim().Replace("'", "''");
        //Reg.Comp_ID = hdncmphdn.Value;// Session["CompanyId"].ToString();
        //DataSet ds = Loyalty_Dealer.FillGridDealer(Reg);
        //GrdCustomer.DataSource = ds.Tables[0];
        //GrdCustomer.DataBind();
        //lblcount.Text = GrdCustomer.Rows.Count.ToString();
        //if (GrdCustomer.Rows.Count > 0)
        //    GrdCustomer.HeaderRow.TableSection = TableRowSection.TableHeader;
    }           
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdVwDealerMaster();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        ddlUT.SelectedIndex = 0;
        newMsg.Visible = false;
        FillGrdVwDealerMaster();
    }
    protected void GrdCustomer_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdCustomer.PageIndex = e.NewPageIndex;
        FillGrdVwDealerMaster();
    }
    private void Cleartxt()
    {
        ddlUserType.Text = string.Empty;
        txtcontactprson.Text = string.Empty;
        txtaddress.Text = string.Empty;
        txtEmail.Text = string.Empty;
        txtMobileNo.Text = string.Empty;
        lbleditlabelid.Text = "";        
        txtplanname.Text = string.Empty;
        txtplanname.Enabled = true;                
        btnSave.Text = "Save";
    }
    protected void GrdCustomer_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //Cleartxt();
        Loyalty_Dealer Reg = new Loyalty_Dealer();
        lbleditlabelid.Text = e.CommandArgument.ToString();
      //  newMsg.Visible = false; Div1.Visible = false;
        if (e.CommandName == "EditCustomer")
        {
            Response.Redirect("MyProfile.aspx?id=" + e.CommandArgument.ToString());
        }
        else if (e.CommandName == "DeleteRow")
        {
            SQL_DB.ExecuteNonQuery("Delete from Dealer where DealerID = " + lbleditlabelid.Text);
            FillGrdVwDealerMaster();
            Label2.Text = "Saved successfully !";
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green");
            //ModalPopupCreateLabel.Show();
            string script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }        
    }
    private string FindStatus(int Status)
    {
        if (Status == 1)
            return "De-Activate";
        else
            return "Activate";
    }
    private string FindStatus1(int Status)
    {
        if (Status == 1)
            return "De-Activated";
        else
            return "Activated";
    }
    protected void btnYesActivation_Click(object sender, EventArgs e)
    {        
        Loyalty_Dealer Reg = new Loyalty_Dealer();
        Reg.Row_ID = Convert.ToInt64(lbleditlabelid.Text);
        //Reg.Dealer_Name = txtsearchlblname.Text.Trim().Replace("'", "''");
        Reg.Comp_ID = ProjectSession.strCompanyid;// Session["CompanyId"].ToString();
        Loyalty_Dealer.ActiveDeActiveDealer(Reg);
        DataSet ds = Loyalty_Dealer.FillGridDealer(Reg);
        Reg.Contact_Person = ds.Tables[0].Rows[0]["Dealer_Name"].ToString();
        Reg.IsActive = Convert.ToInt32(ds.Tables[0].Rows[0]["Status"]);
        newMsg.Visible = true;               
        newMsg.Attributes.Add("class", "alert_boxes_green");
        Label2.Text = "Dealer <span style='color:blue;' >" + Reg.Contact_Person + " </span> (<span style='color:green;' >" + ds.Tables[0].Rows[0]["Contact_Person"].ToString() + "</span>) is <span style='color:blue;' >" + FindStatus1(Reg.IsActive) + "</span> successfully! ";
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        FillGrdVwDealerMaster();  
    }    
    protected void btnNoActivation_Click(object sender, EventArgs e)
    {
        
    } 
    [WebMethod]
    [ScriptMethod]
    public static bool checkMobileNo(string res)
    {        
        string[] Arr = res.ToString().Split('*');
        if (Arr.Length > 1)
        {
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Mobile_No] FROM [M_Dealer] where [Mobile_No] = '" + Arr[0].ToString() + "' AND [Comp_ID] = '" + Arr[1].ToString() + "' ");
            if (ds.Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }
        else
            return false;
    }    
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewPlan(string res)
    {
        string[] Arr = res.ToString().Split('*');
        if (Arr.Length > 1)
        {
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Email] FROM [M_Dealer] where [Email] = '" + Arr[0].ToString() + "' AND [Comp_ID] = '" + Arr[1].ToString() + "' ");
            if (ds.Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }
        else
            return false;
    }    
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Loyalty_Dealer Reg = new Loyalty_Dealer();
        string script = "";
        Reg.Contact_Person = txtcontactprson.Text.Trim().Replace("'","''");
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));             
        Reg.Dealer_Name = txtplanname.Text.Trim().Replace("'", "''");
        Reg.Email = txtEmail.Text.Trim().Replace("'", "''");
        Reg.Address = txtaddress.Text.Trim().Replace("'", "''");
        Reg.Mobile_No = txtMobileNo.Text.Trim().Replace("'", "''");
        Reg.IsActive = 0;
        Reg.City = ddlUserType.Text;
        Reg.Comp_ID = ProjectSession.strCompanyid;// Session["CompanyId"].ToString();
        Random r = new Random();
        Reg.Password = r.Next().ToString().Substring(0, 5);
       // Reg.Password = DataProvider.Utility.GeneratePassword();
        if (btnSave.Text == "Save")
        {
           // Reg.Dealer_ID = function9420.GetLabelCode("Dealer").Replace("_", "");
            Reg.DML = "I";
            Loyalty_Dealer.SaveDealer(Reg);
            ProductsLabelPrices.Text = "Dealer <span style='color:blue;'>" + Reg.Dealer_Name + "</span> has been saved successfully !";
            function9420.UpdateLabelCode("Dealer");
            Div1.Visible = true;
            Div1.Attributes.Add("class", "alert_boxes_green");
            //ModalPopupCreateLabel.Show();
            script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        else
        {
            Reg.Row_ID = Convert.ToInt64(lbleditlabelid.Text);
            Reg.DML = "U";
            Loyalty_Dealer.SaveDealer(Reg);            
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green");
            Label2.Text = "Dealer <span style='color:blue;'>" + Reg.Dealer_Name + "</span>  has been Updated successfully !";
            script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        Cleartxt();
        FillGrdVwDealerMaster();        
    }          
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Cleartxt();
        //ModalPopupCreateLabel.Show();
    }

    protected void imgNew_Click1(object sender, EventArgs e)
    {
        Response.Redirect("TrackTraceUserType.aspx");
    }
}