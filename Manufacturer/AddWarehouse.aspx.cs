using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business9420;
using System.IO;
using System.Web.Services;
using System.Web.Script.Services;
using Data9420;
using System.Configuration;
using DataProvider;
using Business_Logic_Layer;
using System.Xml;

public partial class Manufacturer_AddWarehouse : System.Web.UI.Page
{
    public int Flag = 0, index = 0, sno = 1;

    private string _Giftid_Prop;
    public string Giftid_Prop
    {
        get { return (string)ViewState["_Giftid_Prop"]; }
        set { ViewState["_Giftid_Prop"] = value; }
    }

   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/Default.aspx?Page=FrmDealerMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            if (Request.QueryString["id"] != null)
            {
                Giftid_Prop = Convert.ToString(Request.QueryString["id"]);
                EditMode();
            }

            hdnCompID.Value = Session["CompanyId"].ToString();
            // hdncmphdn.Value = ProjectSession.strCompanyid;// Session["CompanyId"].ToString();
            //  lblmsgHeader.Text = "";
            //newMsg.Visible = false;
            //lblcount.Text = "0";
        }
        //Label2.Text = "";
        
    }

    public void EditMode()
    {
        //CouponProver Reg = new CouponProver();
        //lblBankId.Text = Giftid_Prop;
        //Reg.Gift_ID = lblBankId.Text;
        ////newMsg.Visible = false;
        //Reg.DML = "S";
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //CouponProver.GiftFillDataGrid(Reg);

        DataTable dt = SQL_DB.ExecuteDataTable("Select * from Channels where Channelsid =" + Giftid_Prop);
        if (dt.Rows.Count > 0)
        {

            txtName.Text = dt.Rows[0]["name"].ToString();
            //  lblAddCourierHeader.Text = "Gift update Details";
        }
        btnSubmit.Text = "Update";
    }


    [WebMethod]
    [ScriptMethod]
    public static bool checkNewLabel(string res)
    {
        string[] Arr = res.ToString().Split('*');
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [GiftName] FROM [M_Gift] WHERE  [GiftName]  = '" + Arr[0].ToString() + "' AND Comp_ID = '" + Arr[1].ToString() + "' AND IsDelete = 0 ");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
      //  Clear();
       // newMsg.Visible = false; DivNewMsg.Visible = false;
       // ModalPopupExtenderNewDesign.Show();
    }
    private void Clear()
    {

      //  dhnactiontype.Value = string.Empty;
        txtName.Text = "";
      //  lblAddCourierHeader.Text = "Add New Gift";
        btnSubmit.Text = "Save";
    }
    protected void btnSearch_Click(object sender, ImageClickEventArgs e)
    {
      //  FillGrid();
       // newMsg.Visible = false;
    }
    protected void btnRefesh_Click(object sender, ImageClickEventArgs e)
    {
        //txtSearchName.Text = "";
       // FillGrid();
       // newMsg.Visible = false;
    }
    private void FillGrid()
    {
        //CouponProver Reg = new CouponProver();
        //Reg.DML = "F";
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //Reg.GiftName = txtSearchName.Text.Trim().Replace("'", "''");
        //DataTable DsGrd = new DataTable();
        //DsGrd = Business9420.CouponProver.GiftFillDataGrid(Reg);
        ////if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        ////{
        ////    if (DsGrd.Rows.Count > 0)
        ////        GrdVw.PageSize = DsGrd.Rows.Count;
        ////}
        ////else
        ////    GrdVw.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        //if (DsGrd.Rows.Count > 0)
        //    GrdVw.DataSource = DsGrd;
        //GrdVw.DataBind();
        //lblcount.Text = DsGrd.Rows.Count.ToString();
        //if (GrdVw.Rows.Count > 0)
        //    GrdVw.HeaderRow.TableSection = TableRowSection.TableHeader;

    }
   
    protected void GrdVw_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //CouponProver Reg = new CouponProver();
        //lblBankId.Text = e.CommandArgument.ToString();
        //Reg.Gift_ID = lblBankId.Text; newMsg.Visible = false;
        //Reg.DML = "S";
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //CouponProver.GiftFillDataGrid(Reg);
        //if (e.CommandName.ToString() == "EditRow")
        //{
        //    txtName.Text = Reg.GiftName;
        //    lblAddCourierHeader.Text = "Gift update Details";
        //    btnSubmit.Text = "Update";
        //    //ModalPopupExtenderNewDesign.Show();
        //}
        //else if (e.CommandName.ToString() == "DeleteRow")
        //{
        //    dhnactiontype.Value = "D";
        //    LabelAlertheader.Text = "Alert";
        //    LabelAlertText.Text = "Are you sure to dalete  <span style='color:blue;' >" + Reg.GiftName + "</span>  Gift permanently?";
        //    ModalPopupExtenderAlert.Show();
        //}
        //else if (e.CommandName.ToString() == "ActivateRow")
        //{
        //    dhnactiontype.Value = "A";
        //    LabelAlertheader.Text = "Alert";
        //    LabelAlertText.Text = "Are you sure to <span style='color:blue;' > " + FindStatus(Reg.IsActive) + " </span> <span style='color:blue;' >" + Reg.GiftName + "</span>  Gift permanently?";
        //    ModalPopupExtenderAlert.Show();
        //}
    }
    private string FindStatus(int p)
    {
        if (p == 0)
            return "De-Activate";
        else
            return "Activate";
    }
    private string FindStatusNew(int p)
    {
        if (p == 0)
            return "Activated";
        else
            return "De-Activated";
    }
    protected void btnNo_Click(object sender, EventArgs e)
    {

    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        //CouponProver Reg = new CouponProver();
        //Reg.Gift_ID = lblBankId.Text;
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //Reg.DML = "S";
        //CouponProver.GiftFillDataGrid(Reg);
        //if (dhnactiontype.Value == "A")
        //{
        //    Reg.DML = "A";
        //    if (Reg.IsActive == 0)
        //    {
        //        Reg.IsActive = 1;
        //        lblmsgHeader.Text = "Gift <span style='color:blue;' >" + Reg.GiftName + "</span> has benn <span style='color:blue;' > " + FindStatusNew(Reg.IsActive) + " </span>  successfully.";
        //    }
        //    else
        //    {
        //        Reg.IsActive = 0;
        //        lblmsgHeader.Text = "Gift <span style='color:blue;' >" + Reg.GiftName + "</span> has benn <span style='color:blue;' > " + FindStatusNew(Reg.IsActive) + " </span>  successfully.";
        //    }
        //}
        //else if (dhnactiontype.Value == "D")
        //{
        //    Reg.DML = "D";
        //    if (Reg.IsDelete == 0)
        //        Reg.IsDelete = 1;
        //    else
        //        Reg.IsDelete = 0;
        //    lblmsgHeader.Text = "Gift <span style='color:blue;' >" + Reg.GiftName + "</span> has benn deleted  successfully.";
        //}
        //CouponProver.GiftActivateDelete(Reg);
        //newMsg.Visible = true;
        //newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        //FillGrid();
        //string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //CouponProver Reg = new CouponProver();
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //Reg.EntryDate = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        //Reg.GiftName = txtName.Text.Trim().Replace("'", "''");

        //if (btnSubmit.Text == "Save")
        //{
        //    Reg.DML = "I";
        //    CouponProver.GiftInsertUpdate(Reg);          
        //    Response.Redirect("FrmGiftMaster.aspx");
        //}
        //else
        //{
        //    Reg.Gift_ID = lblBankId.Text;
        //    Reg.DML = "U";
        //    CouponProver.GiftInsertUpdate(Reg);
        //    Response.Redirect("FrmGiftMaster.aspx?edit=s");
        //}
        Channels_XMl("Channels");
        Response.Redirect("FrmWarehouse.aspx?edit=s");
    }
    private void Channels_XMl(string strType)
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
                child.SetAttribute("name", txtName.Text);
                //if (lst.Items[i].Value.All(char.IsDigit))
                if (!string.IsNullOrEmpty(Giftid_Prop))
                {
                    child.SetAttribute("ProductionOrChannelsID", Giftid_Prop);
                }
                else
                {
                    child.SetAttribute("ProductionOrChannelsID", "0");
                }

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
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Response.Redirect("FrmWarehouse.aspx");
      //  Clear(); newMsg.Visible = false; DivNewMsg.Visible = false;
      //  ModalPopupExtenderNewDesign.Show();
    }
}