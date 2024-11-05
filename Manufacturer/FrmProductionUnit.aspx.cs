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
using System.Xml;

public partial class FrmProductionUnit : System.Web.UI.Page
{
   
    private string _prop_Type;
    public string Prop_Type
    {
        get { return (string)ViewState["_prop_Type"]; }
        set { ViewState["_prop_Type"] = value; }
    }
    private int _prop_Referralid;
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
            newMsg.Visible = false;
            Label2.Text = "";
            if (Request.QueryString["tp"] != null)
            {
                Prop_Type = Request.QueryString["tp"].ToString();
            }
            if (Request.QueryString["edit"] != null)
            {
                //if( Request.QueryString["edit"].ToString() == "s")
                //{
                //    Label2.Text = "Saved Successfully";
                //    newMsg.Visible = true;
                //    newMsg.Attributes.Add("class", "alert_boxes_green");
                //    //ModalPopupCreateLabel.Show();
                //   string script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
                //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                //}
            }
            hdncmphdn.Value = ProjectSession.strCompanyid;// Session["CompanyId"].ToString();
            FillGrdVwDealerMaster(Prop_Type);
           
            lblcount.Text = "0"; 
        }
      
    }    
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {        
        newMsg.Visible = false;
        Cleartxt();
        newMsg.Visible = false;
        lblheading.Text = "Add New Dealer";
        //ModalPopupCreateLabel.Show();
    }
    private void FillGrdVwDealerMaster(string productionOrWarehouse)
    {
        string strVal = string.Empty;
        if (!string.IsNullOrEmpty(txtSearchName.Text))
        {
            strVal = "  and name like '%" + txtSearchName.Text + "%' ";
        }
        {
            DataTable dt = new DataTable();
           // if (productionOrWarehouse == "production")
                dt = SQL_DB.ExecuteDataTable("select * from productionunit where compid='" + ProjectSession.strCompanyid + "'" + strVal);
            //if (productionOrWarehouse == "channels")
            //    dt = SQL_DB.ExecuteDataTable("select * from channels where compid='" + ProjectSession.strCompanyid + "'");
            // if (dt.Rows.Count > 0)
            // {
            GrdCustomer.DataSource = dt;
            GrdCustomer.DataBind();
           
            lblcount.Text = GrdCustomer.Rows.Count.ToString();
            if (GrdCustomer.Rows.Count > 0)
                GrdCustomer.HeaderRow.TableSection = TableRowSection.TableHeader;
           // }
        }
        //Loyalty_Dealer Reg = new Loyalty_Dealer();
        //Reg.Row_ID = 0;
        //Reg.Dealer_Name = txtsearchlblname.Text.Trim().Replace("'", "''");
        //Reg.Comp_ID = hdncmphdn.Value;// Session["CompanyId"].ToString();
        //DataSet ds = Loyalty_Dealer.FillGridDealer(Reg);
       
    }           
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        //FillGrdVwDealerMaster();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
       // txtsearchlblname.Text = string.Empty;
        newMsg.Visible = false;
        //FillGrdVwDealerMaster();
    }
    protected void GrdCustomer_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdCustomer.PageIndex = e.NewPageIndex;
        //FillGrdVwDealerMaster();
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

        lbleditlabelid.Text = e.CommandArgument.ToString();
        newMsg.Visible = false; Div1.Visible = false;
        if (e.CommandName.ToString() == "EditCustomer")
        {
            Response.Redirect("AddPU.aspx?id=" + e.CommandArgument.ToString());
            // txtName.Text = Reg.GiftName;
            // lblAddCourierHeader.Text = "Gift update Details";
            //  btnSubmit.Text = "Update";
            //ModalPopupExtenderNewDesign.Show();
        }
        else if (e.CommandName.ToString() == "DeleteRow")
        {
            try
            {
                SQL_DB.ExecuteNonQuery("Delete from ProductionUnit where ProductionUnitID = " + lbleditlabelid.Text);
                FillGrdVwDealerMaster("production");
                Label2.Text = "Saved successfully !";
                newMsg.Visible = true;
                newMsg.Attributes.Add("class", "alert_boxes_green");
                //ModalPopupCreateLabel.Show();
                string script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            }
            catch (Exception)
            {

                
            }
            
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
        //FillGrdVwDealerMaster();  
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
      //  FillGrdVwDealerMaster();        
    }          
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Cleartxt();
        //ModalPopupCreateLabel.Show();
    }

    protected void imgNew_Click1(object sender, EventArgs e)
    {
         Response.Redirect("AddPU.aspx");
        //if (!string.IsNullOrEmpty(txtPU.Text))
        //{
        //    ProductionUnit_XMl("production");
        //}
        //FillGrdVwDealerMaster("production");

    }
    /// <summary>
    /// Here Type means - ProductionUnit or Warehoouse (in db warehouse is channels table)
    /// </summary>
    /// <param name="strType"></param>
    private void ProductionUnit_XMl(string strType)
    {
        XmlDocument xmldoc = new XmlDocument();
        XmlElement xmlrootelement = xmldoc.CreateElement("Tab");
        xmldoc.AppendChild(xmlrootelement);
        int i = 0;
       // for (int i = 0; i < lst.Items.Count; i++)
        {
            //   if (lstProfileItemId.Split(',')[i].Length > 0)
            {
                XmlElement child = xmldoc.CreateElement("id");
               // child.SetAttribute("name", txtPU.Text);
                //if (lst.Items[i].Value.All(char.IsDigit))
                //{
                //    child.SetAttribute("ProductionOrChannelsID", lst.Items[i].Value);
                //}
                //else
                //{
                child.SetAttribute("ProductionOrChannelsID", "0");
                //}

                child.SetAttribute("index", (i + 1).ToString());
                xmlrootelement.AppendChild(child);
            }

        }

        string xmlLibraryList = xmldoc.OuterXml;
        DateTime Createddate = Convert.ToDateTime(DataProvider.LocalDateTime.Now);//.ToString("yyyy/MM/dd hh:mm:ss tt");
        DataSet ds = ExecuteNonQueryAndDatatable.ProductioOrChannelsInsert(Createddate, ProjectSession.strCompanyid, xmlLibraryList, strType);
        //  if (lstProfileItemId.Split(',').Length >= 1)
        //   {
        //       objTabProfileItemBAL.Insert(xmlLibraryList);
        //    }
    }
    protected void btnSearch_Click(object sender, ImageClickEventArgs e)
    {
        FillGrdVwDealerMaster("production");
        newMsg.Visible = false;
    }

    protected void btnRefesh_Click(object sender, ImageClickEventArgs e)
    {
        txtSearchName.Text = "";
        FillGrdVwDealerMaster("production");
    }
}