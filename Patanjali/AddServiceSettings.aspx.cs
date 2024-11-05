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
using Business_Logic_Layer;
using Business9420;
using System.Web.Services;
using System.Web.Script.Services;
using System.Text;
using System.Collections.Generic;
using CustomeDraw;
using System.Xml;
using DataProvider;
using System.Data.SqlClient;


public partial class Partner_AddServiceSettings : System.Web.UI.Page
{
    public Int64 _SSTID;
    public Int64 SStid_Prop
    {
        get
        {

            if (ViewState["_SSTID"] == null)
            { return 0; }
            else
            {
                return (Int64)ViewState["_SSTID"];
            }

        }
        set { ViewState["_SSTID"] = value; }
    }


    public static List<Gifts> Obj = new List<Gifts>();
    public StringBuilder srv = new StringBuilder(); public int vl = 0; public static int sno = 0, srno = 0;
    public int c = 0, str = 0, upplanindex = 0, upamcindex = 0, upofindex = 0, index = 0, pindex = 0, planindex = 0, Disp = 0, promoDisp = 0, dispindex = 0, promoind = 0; public string TransType = "", Comptype = "", LCode = "", PlanID = "", PromoID = ""; public bool LabelFlag = false;
    public int CntDays = 0, IsActive = 0;
    public string srt = DataProvider.Utility.FindMailBody();
    public string strCouponRequest_ID { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        #region Creae Conrol Panel For Services

        if (Session["CompanyId"] == null)
            Response.Redirect("../patanjali/loginpfl.aspx?Page=AddServiceSettings.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("../patanjali/loginpfl.aspx");
        }

        if (!Page.IsPostBack)
        {

           
            Session["Gift"] = "";
            Session["Plan_ID"] = "";
            
           
          
            hhdnCompID.Value = Session["CompanyId"].ToString().Substring(5, 4);
            Session["Path"] = Server.MapPath("../Data/Sound");

           
            
            if (Request.QueryString["id"] != null)
            {
                SStid_Prop = Convert.ToInt64(Request.QueryString["id"]);
            }
            if (SStid_Prop > 0)
            {
                filldata();
               
            }


        }
    }
    public void CheckGiftCouponServiceStarted(Int32 sst_id, string service_id)
    {
        if (service_id == EnumClass.ServiceName.SRV1003.ToString() || service_id == EnumClass.ServiceName.SRV1006.ToString())
        {
            DataTable dt = ExecuteNonQueryAndDatatable.CheckGiftCouponServiceStarted(sst_id, service_id).Tables[0];
            if (dt.Rows.Count > 0)
            {
                LblMsgBody.Text = "This service already started, you cannot update details. You can de-Activate it, in case if you want to stop/discontinue  the service .";
                DivMsg.Visible = true;
                DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
                btnSave.Enabled = false;
            }
            else
            {
                LblMsgBody.Text = "";
                btnSave.Enabled = true;
            }
        }

    }
   
   
    public void BindUT(string strUT, DropDownList ddlM, string ddlvalue)
    {
        DataTable dt = SQL_DB.ExecuteDataTable("Select * from Dealer  where  compid='" + ProjectSession.strCompanyid + "' and  [type] in (Select  TTUserTypeid from [UserType_TrackTrace] where type = '" + strUT + "')");
        if (dt.Rows.Count > 0)
        {

            ddlM.DataSource = dt;
            ddlM.DataTextField = "name";
            ddlM.DataValueField = "DealerID";
            ddlM.DataBind();
            ddlM.Items.Insert(0, new ListItem("Select", "0"));
            //chkTT.Items.Insert(1, new ListItem("Warehouse", "00"));

        }
        else
        {
            ddlM.Items.Insert(0, new ListItem("Select", "0"));
        }
        if (!string.IsNullOrEmpty(ddlvalue))
        {
            ddlM.SelectedValue = ddlvalue;
        }
    }
   
  

    [WebMethod]
    [ScriptMethod]
    public static bool checkFile(string ult)
    {
        int lindex = ult.LastIndexOf('.');
        string ext = ult.Substring(lindex, ult.Length - lindex);
        if (ext.ToUpper() == ".WAV")
            return false;
        else
            return true;
    }

    private void ClearText()
    {
       
        hdnisaddi.Value = string.Empty; hdnsstid.Value = string.Empty; hdnprizetransid.Value = string.Empty;
        DivMsg.Visible = false;
       
        hdnpointsval.Value = string.Empty;
       
        txtloyaltydtfrom.Text = string.Empty;
        txtloyaltydtto.Text = string.Empty;
       
        ddlProduct.SelectedIndex = 0;
       
        hdneditval.Value = string.Empty;
       
        filldata();
    }

   
   

   
    private void CheckValidation(string ServiceId)
    {
        DataTable dt = SQL_DB.ExecuteDataSet("SELECT ServiceFeaure_ID, Service_ID,(SELECT ServiceName FROM M_Service WHERE Service_ID = M_ServiceFeature.Service_ID) ServiceName, IsPoints,IsCash, IsDateRange, IsSound, IsFrequency, IsAdditionalGift, IsMessageTemplete,IsReferral, EntryDate, IsDelete,IsRandom FROM M_ServiceFeature WHERE IsDelete = 0 AND Service_ID = '" + ServiceId + "' ").Tables[0];
        if (dt.Rows.Count > 0)
        {
            //txtReferralLimit.Text = (select[Limit] from[ReferralLimit] where [M_SST_id] = ),
            //  Lblloyaltyhead.Text = "Add " + dt.Rows[0]["ServiceName"].ToString();
            int IsPoints = 0, IsCash = 0, IsDateRange = 0, IsSound = 0, IsFrequency = 0, IsAdditionalGift = 0, IsMessageTemplete = 0, IsReferral = 0, Israndom = 0;
            IsPoints = Convert.ToInt32(dt.Rows[0]["IsPoints"].ToString());
            IsCash = Convert.ToInt32(dt.Rows[0]["IsCash"].ToString());
            IsDateRange = Convert.ToInt32(dt.Rows[0]["IsDateRange"].ToString());
            IsSound = Convert.ToInt32(dt.Rows[0]["IsSound"].ToString());
            IsFrequency = Convert.ToInt32(dt.Rows[0]["IsFrequency"].ToString());
            IsAdditionalGift = Convert.ToInt32(dt.Rows[0]["IsAdditionalGift"].ToString());
            IsMessageTemplete = Convert.ToInt32(dt.Rows[0]["IsMessageTemplete"].ToString());
            IsReferral = Convert.ToInt32(dt.Rows[0]["IsReferral"].ToString());
            Israndom = Convert.ToInt32(dt.Rows[0]["IsRandom"].ToString());
            if (IsDateRange == 0)
            {
                RFVIsDateFrom.ValidationGroup = "SRVS";
            }
            else
            {
                RFVIsDateFrom.ValidationGroup = "NN";
            }
            //if (IsPoints == 0)
            //{
            //    divispoints.Visible = true;
            //    RFVIsPoints.ValidationGroup = "SRVS";
            //}
            //else
            //{
           
            //}
            if (IsAdditionalGift == 0)
            {
                hdnisaddi.Value = IsAdditionalGift.ToString();
               
            }
            else
            {
                hdnisaddi.Value = string.Empty;
               
            }
            if (IsSound == 0)
            {
               
            }
            else
            {
               
            }
           
        }
    }
   
  
    [WebMethod]
    [ScriptMethod]
    public static string WritePlanAmtDis(string res)
    {
        string[] Arr = res.ToString().Split('*');
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Plan_ID, Service_ID, PlanName, PlanPeriod, PlanPrice, EntryDate, IsActive, IsDelete FROM M_ServicePlan WHERE PlanPeriod = '" + Convert.ToInt32(Arr[0]) + "' AND IsActive = 0  AND Service_ID = '" + Arr[1] + "' ");
        if (ds.Tables[0].Rows.Count > 0)
            return ds.Tables[0].Rows[0]["PlanPrice"].ToString() + "*0";
        else
            return "0*0";
    }
    [WebMethod]
    [ScriptMethod]
    public static string checkGetDateIsExist(string res)
    {
        string[] Arr = res.ToString().Split('*');
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Subscribe_Id, Service_ID, Comp_ID, Pro_ID, Plan_ID, PlanName, PlanMasterPeriod, PlanSalePeriod, PlanMasterPrice, PlanSalePrice, DateFrom, DateTo, EntryDate, IsActive, IsDelete, IsAdminVerify FROM M_ServiceSubscription  WHERE Service_ID = '" + Arr[1] + "' AND Pro_ID = '" + Arr[0] + "' AND IsDelete = 0 ");
        if (ds.Tables[0].Rows.Count > 0)
        {
            DateTime DE = Convert.ToDateTime(Arr[2]);
            if ((DE >= Convert.ToDateTime(ds.Tables[0].Rows[0]["DateFrom"])) && (DE <= Convert.ToDateTime(ds.Tables[0].Rows[0]["DateTo"])))
                return "false*";
            else
                return "true*Date Between Period From : " + Convert.ToDateTime(ds.Tables[0].Rows[0]["DateFrom"]).ToString("dd/MM/yyyy") + " To : " + Convert.ToDateTime(ds.Tables[0].Rows[0]["DateTo"]).ToString("dd/MM/yyyy"); ;
        }
        else
            return "true*Service is not subscribe please subscribe service first.";
    }
    [WebMethod]
    [ScriptMethod]
    public static string checkGetDateIsExistNew(string res)
    {
        string[] Arr = res.ToString().Split('*');
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Subscribe_Id, Service_ID, Comp_ID, Pro_ID, Plan_ID, PlanName, PlanMasterPeriod, PlanSalePeriod, PlanMasterPrice, PlanSalePrice, DateFrom, DateTo, EntryDate, IsActive, IsDelete, IsAdminVerify FROM M_ServiceSubscription  WHERE Service_ID = '" + Arr[1] + "' AND Pro_ID = '" + Arr[0] + "' AND IsDelete = 0 ");
        if (ds.Tables[0].Rows.Count > 0)
        {
            DateTime DE = Convert.ToDateTime(Arr[2]);
            if ((DE > Convert.ToDateTime(ds.Tables[0].Rows[0]["DateFrom"])) && (DE <= Convert.ToDateTime(ds.Tables[0].Rows[0]["DateTo"])))
                return "false*";
            else
                return "true*Date Between Period From : " + Convert.ToDateTime(ds.Tables[0].Rows[0]["DateFrom"]).ToString("dd/MM/yyyy") + " To : " + Convert.ToDateTime(ds.Tables[0].Rows[0]["DateTo"]).ToString("dd/MM/yyyy"); ;
        }
        else
            return "true*Service is not subscribe please subscribe service first.";
    }
    [WebMethod]
    [ScriptMethod]
    public static string checkGetSubscription(string res)
    {
        string[] Arr = res.ToString().Split('*');
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Subscribe_Id, Service_ID, Comp_ID, Pro_ID, Plan_ID, PlanName, PlanMasterPeriod, PlanSalePeriod, PlanMasterPrice, PlanSalePrice, DateFrom, DateTo, EntryDate, IsActive, IsDelete, IsAdminVerify FROM M_ServiceSubscription  WHERE Service_ID = '" + Arr[1] + "' AND Pro_ID = '" + Arr[0] + "' AND IsDelete = 0 and [start_order]=" + Arr[2].Split(',')[0].Split('-')[0] + " and [start_series]=" + Arr[2].Split(',')[0].Split('-')[1] + "and [end_order]=" + Arr[2].Split(',')[1].Split('-')[0] + "and [end_series]=" + Arr[2].Split(',')[1].Split('-')[1] + "");
        if (ds.Tables[0].Rows.Count > 0)
            return "true*Period From : " + Convert.ToDateTime(ds.Tables[0].Rows[0]["DateFrom"]).ToString("dd/MM/yyyy") + " To : " + Convert.ToDateTime(ds.Tables[0].Rows[0]["DateTo"]).ToString("dd/MM/yyyy") + "*" + ds.Tables[0].Rows[0]["Subscribe_Id"].ToString();
        else
            return "false*Service is not subscribe please subscribe service first.*";
    }

    private string GetMyGiftID(string p)
    {
        string str = "";
        if (Session["Gift"] != null)
        {
            DataTable dt = (DataTable)Session["Gift"];
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string[] Arr;
                    //string[] Arr = dt.Rows[i]["Gift_ID"].ToString().Split('*');
                    string strGftid = dt.Rows[i]["Gift_ID"].ToString();
                    if (strGftid.Contains('&'))
                        Arr = dt.Rows[i]["Gift_ID"].ToString().Split('&');
                    else
                    {
                        Arr = dt.Rows[i]["Gift_ID"].ToString().Split('*');
                    }
                    if (Arr.Length > 0)
                    {
                        if (p.Contains('&'))
                        {
                            p = p.Split('&')[0];
                        }
                        if (Arr[0].ToString() == p)
                        {
                            str = dt.Rows[i]["Gift_ID"].ToString();
                            break;
                        }
                    }
                }
                return str;
            }
        }
        else
            return "";
    }
    protected void Submit_Click(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        //  ClearText();
        //  ModalPopupExtenderServices.Show();

    }
    private int FindOccurence(string substr)
    {
        string reqstr = Request.Form.ToString();
        return ((reqstr.Length - reqstr.Replace(substr, "").Length) / substr.Length);
    }
    private void RecreateControls(string ctrlPrefix, string ctrlType)
    {
        string[] ctrls = Request.Form.ToString().Split('&');
        int cnt = FindOccurence(ctrlPrefix);
        if (cnt > 0)
        {
            Literal lt;
            for (int k = 1; k <= cnt; k++)
            {
                for (int i = 0; i < ctrls.Length; i++)
                {
                    if (ctrls[i].Contains(ctrlPrefix + "-" + k.ToString()))
                    {
                        string ctrlName = ctrls[i].Split('=')[0];
                        string ctrlValue = ctrls[i].Split('=')[1];

                        //Decode the Value
                        ctrlValue = Server.UrlDecode(ctrlValue);

                        if (ctrlType == "TextBox")
                        {
                            TextBox txt = new TextBox();
                            txt.ID = ctrlName;
                            txt.Text = ctrlValue;
                            //    pnlTextBox.Controls.Add(txt);
                            lt = new Literal();
                            lt.Text = "<br />";
                            //    pnlTextBox.Controls.Add(lt);
                        }

                        if (ctrlType == "DropDownList")
                        {
                            DropDownList ddl = new DropDownList();
                            ddl.ID = ctrlName;

                            //Rebind Data
                            ddl.Items.Add(new ListItem("One", "1"));
                            ddl.Items.Add(new ListItem("Two", "2"));
                            ddl.Items.Add(new ListItem("Three", "3"));

                            //Select the Preselected Item
                            ddl.Items.FindByValue(ctrlValue).Selected = true;
                            //    pnlDropDownList.Controls.Add(ddl);
                            lt = new Literal();
                            lt.Text = "<br />";
                            //    pnlDropDownList.Controls.Add(lt);
                        }
                        break;
                    }
                }
            }
        }
    }
    private void fillProductLoyalty(bool Flag, DropDownList ddlPro)
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        string Qry = "";
        if (hdneditval.Value != "Edit")
            Qry = " AND Subscribe_Id not in (Select Subscribe_Id From M_ServiceSubscriptionTrans where CONVERT(VARCHAR,DateTo,111) >= CONVERT(VARCHAR,GETDATE(),111)  AND IsDelete = 0 and Subscribe_Id in (Select Subscribe_Id From M_ServiceSubscription Where (Comp_ID = '" + Reg.Comp_ID + "') AND IsDelete = 0 AND Service_ID = '" + ddlService.SelectedValue + "' ))";
        //Qry = " AND Subscribe_Id IN (SELECT Subscribe_Id FROM M_ServiceSubscriptionTrans  WHERE CONVERT(VARCHAR,DateTo,111) < CONVERT(VARCHAR,GETDATE(),111))";
        if (Flag)
            Qry = "SELECT Pro_ID, Pro_Name FROM Pro_Reg WHERE (Comp_ID = '" + Reg.Comp_ID + "') AND (Doc_Flag = 1) AND (Sound_Flag = 1) AND (Pro_ID IN (SELECT Pro_ID FROM M_ServiceSubscription WHERE (Comp_ID = Pro_Reg.Comp_ID) AND IsDelete = 0 AND Service_ID = '" + ddlService.SelectedValue + "' " + Qry + ")) ORDER BY Pro_Name";
        else
            Qry = "SELECT Pro_ID, Pro_Name FROM Pro_Reg WHERE (Comp_ID = '" + Reg.Comp_ID + "') AND (Doc_Flag = 1) AND (Sound_Flag = 1) AND (Pro_ID IN (SELECT Pro_ID FROM M_ServiceSubscription WHERE   (Comp_ID = Pro_Reg.Comp_ID)  AND IsDelete = 0 AND Service_ID = '" + ddlService.SelectedValue + "' " + Qry + ")) ORDER BY Pro_Name";
        
        DataTable ds = SQL_DB.ExecuteDataSet(Qry).Tables[0];
        if (ds.Rows.Count > 0)
        {
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlPro, "--Select--");
            ddlPro.SelectedIndex = 0;
        }
        else
        {
            ddlPro.Items.Clear();
            ddlPro.Items.Insert(0, "--Select--");
        }
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        // NewMsgpop.Visible = false;
        // txtDateFrom.Text = ""; txtDateTo.Text = ""; txtProductName.Text = ""; filldata();
    }

    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        NewMsgpop.Visible = false;
        filldata();
    }
    private void filldata()
    {
        string SST_Id1 = string.Empty;
        hdnisaddi.Value = string.Empty; hdnsstid.Value = string.Empty; hdnprizetransid.Value = string.Empty;
        #region IsActive
        hdneditval.Value = "Edit";
        lblproiddel.Text = SStid_Prop.ToString();// e.CommandArgument.ToString(); 
        hdnsstid.Value = lblproiddel.Text;
        lblproidamc.Value = lblproiddel.Text;
        DataTable ddt = SQL_DB.ExecuteDataSet("SELECT * ,WarrantyPeriod,REG.IsSound AS Sound,CASE WHEN REG.IsSound = 0 THEN '../Data/Sound/' + SUBSTRING(REG.Comp_ID, 6, 4) + '/' + REG.Pro_ID + '/Loyalty/'+ CONVERT(VARCHAR,REG.SST_Id) +'/' + CONVERT(VARCHAR,REG.SST_Id) + '_H.wav' ELSE '' END AS SoundPath,CASE WHEN REG.IsSound = 0 THEN '../Data/Sound/' + SUBSTRING(REG.Comp_ID, 6, 4) + '/' + REG.Pro_ID + '/Loyalty/'+ CONVERT(VARCHAR,REG.SST_Id) +'/' + CONVERT(VARCHAR,REG.SST_Id) + '_E.wav' ELSE '' END AS SoundPath1 FROM (SELECT    sst.WarrantyPeriod, sst.SST_Id, sst.Subscribe_Id, sst.IsCash, sst.Points, sst.Frequency, sst.IsReferral, sst.IsCashConvert, sst.DateFrom, sst.DateTo, sst.Entry_Date, sst.Update_Flag_H, sst.Update_Flag_E, sst.Comments, sst.IsActive, sst.IsDelete, ms.ServiceName, p.Pro_Name, M_ServiceFeature.IsSound,ss.Comp_ID,ss.Pro_ID,ms.Service_ID,ss.start_order,ss.end_order,start_series,end_series,isnull(Amttype,'Fixed') amttype,isnull(Minval,0) minval,isnull(Maxval,0) maxval,isnull(totalamont,0) totalamount FROM  M_ServiceFeature INNER JOIN M_Service AS ms ON M_ServiceFeature.Service_ID = ms.Service_ID INNER JOIN M_ServiceSubscription AS ss ON ms.Service_ID = ss.Service_ID INNER JOIN M_ServiceSubscriptionTrans AS sst ON ss.Subscribe_Id = sst.Subscribe_Id INNER JOIN Pro_Reg AS p ON ss.Pro_ID = p.Pro_ID) REG WHERE REG.SST_Id = '" + SStid_Prop.ToString() + "' ").Tables[0];
        if (ddt.Rows.Count > 0)
        {
            // fill limit
            try
            {
                
            }
            catch (Exception)
            {

                // throw ex;
            }
           
            SST_Id1 = ddt.Rows[0]["SST_Id"].ToString();
            selsrvid.Value = ddt.Rows[0]["Service_ID"].ToString();
            ddlService.SelectedValue = ddt.Rows[0]["Service_ID"].ToString();
           
            fillProductLoyalty(true, ddlProduct);
            CheckValidation(ddt.Rows[0]["Service_ID"].ToString());
            #region Service Logic Check
            if (hdnisaddi.Value == "0")
            {
                #region
                DataTable rulesdt = SQL_DB.ExecuteDataSet("SELECT Trans_Id, SST_Id, ServiceType, Rules, DistributionType, PrizeTrans_Id, MasterCodes, WinningCodes, WinCodes, Frequency,DueDate FROM M_ServiceRules WHERE SST_Id = '" + ddt.Rows[0]["SST_Id"].ToString() + "' ").Tables[0];
                if (rulesdt.Rows.Count > 0)
                {
                    hdnprizetransid.Value = rulesdt.Rows[0]["PrizeTrans_Id"].ToString();
                    #region
                    if (rulesdt.Rows[0]["ServiceType"].ToString() == ServiceTypes.Instant.ToString())
                    {
                       
                    }
                    else
                    {
                       
                    }
                 
                    #endregion
                }
                #endregion

               
            }
            #endregion
            #region
           
            bool check = GetUpdate(ddt.Rows[0]["Pro_ID"].ToString(), Convert.ToDateTime(ddt.Rows[0]["Entry_Date"]));
            currindex.Value = ddt.Rows[0]["SST_Id"].ToString();
            ddlProduct.SelectedValue = ddt.Rows[0]["Pro_ID"].ToString();
           
            hdnloyalty.Value = ddt.Rows[0]["Pro_ID"].ToString();
           
            txtloyaltydtfrom.Text = ddt.Rows[0]["DateFrom"].ToString();
            txtloyaltydtto.Text = ddt.Rows[0]["DateTo"].ToString();
           
           
           
           
            btnSave.Text = "Update";
            // Lblloyaltyhead.Text = "Update Loyalty";
            #endregion
        }
        else
        {
           
            btnSave.Text = "Save";
            //   Lblloyaltyhead.Text = "Add Loyalty";
        }
        CheckGiftCouponServiceStarted(Convert.ToInt32(SST_Id1), selsrvid.Value);
       

    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        NewMsgpop.Visible = false;
        filldata();
    }
    private string FindStatus(int i)
    {
        if (i == 0)
            return "Activated";
        else
            return "De-Activated";
    }
    protected void GrdProductMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            currindex.Value = string.Empty;
            NewMsgpop.Visible = false;
            lblproiddel.Text = e.CommandArgument.ToString();
            lblproidamc.Value = lblproiddel.Text;


            if (e.CommandName == "IsActive")
            {
                #region IsActive
                ActionText.Value = "IsActive";
                Loyalty_Programm Reg = new Loyalty_Programm();
                Reg.Pro_ID = " AND REG.SST_Id = '" + lblproiddel.Text + "'";
                Reg.Comp_ID = Session["CompanyId"].ToString();
                DataSet ds = Loyalty_Programm.FillGrvWData(Reg);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    IsAct.Value = ds.Tables[0].Rows[0]["IsActive"].ToString();
                    currindex.Value = ds.Tables[0].Rows[0]["SST_Id"].ToString();
                    
                    Reg.RowId = Convert.ToInt64(currindex.Value);
                    //if (ActionText.Value == "IsActive")
                    //{
                    if (Convert.ToInt32(IsAct.Value) == 0)
                        Reg.IsActive = 1;
                    else
                        Reg.IsActive = 0;
                    Reg.DMLs = "IsActive";
                    Loyalty_Programm.SSTIsActiveDelete(Reg);
                    Label2.Text = "Product " + ds.Tables[0].Rows[0]["Pro_Name"].ToString() + "[" + ds.Tables[0].Rows[0]["ServiceName"].ToString() + " Services has been <span style='color:blue;'>" + FindStatus(Convert.ToInt32(IsAct.Value)) + "</span> successfully !";
                    //}                    
                    filldata();
                    NewMsgpop.Visible = true;
                    NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
                    string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                    return;
                }
                #endregion
            }
            if (e.CommandName == "DeleteRow")
            {
                #region IsActive
                ActionText.Value = "IsDelete";
                Loyalty_Programm Reg = new Loyalty_Programm();
                Reg.Pro_ID = " AND REG.SST_Id = '" + lblproiddel.Text + "'";
                Reg.Comp_ID = Session["CompanyId"].ToString();
                DataSet ds = Loyalty_Programm.FillGrvWData(Reg);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    //btnNoAlert.Visible = false;
                    //LabelAlertHead.Text = "Alert";
                    //lblalert.Text = " Are you sure to delete the Brand Loyalty Settings of <span style='color:blue;'>" + ds.Tables[0].Rows[0]["Pro_Name"].ToString() + "</span> product ?";
                    //ModalPopupExtenderAlert.Show();

                    IsAct.Value = ds.Tables[0].Rows[0]["IsActive"].ToString();
                    currindex.Value = ds.Tables[0].Rows[0]["SST_Id"].ToString();
                    Reg.RowId = Convert.ToInt64(currindex.Value);
                    //else if (ActionText.Value == "IsDelete")
                    //{
                    Reg.IsDelete = 1;
                    Reg.DMLs = "IsDelete";
                    Loyalty_Programm.SSTIsActiveDelete(Reg);
                    Label2.Text = "Product " + ds.Tables[0].Rows[0]["Pro_Name"].ToString() + "[" + ds.Tables[0].Rows[0]["ServiceName"].ToString() + " has been deleted successfully !";
                    //}
                    filldata();
                    NewMsgpop.Visible = true;
                    NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
                    string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                }
                #endregion
            }
            else if (e.CommandName == "AudioPlay")
            {
                #region IsActive
                System.Media.SoundPlayer player = new System.Media.SoundPlayer(Server.MapPath(e.CommandArgument.ToString()));
                player.Play();
                #endregion
            }
            else if (e.CommandName == "EditRows")
            {
                string SST_Id1 = string.Empty;
                hdnisaddi.Value = string.Empty; hdnsstid.Value = string.Empty; hdnprizetransid.Value = string.Empty;
                #region IsActive
                hdneditval.Value = "Edit";
                lblproiddel.Text = e.CommandArgument.ToString(); hdnsstid.Value = lblproiddel.Text;
                lblproidamc.Value = lblproiddel.Text;
                DataTable ddt = SQL_DB.ExecuteDataSet("SELECT * ,REG.IsSound AS Sound,CASE WHEN REG.IsSound = 0 THEN '../Data/Sound/' + SUBSTRING(REG.Comp_ID, 6, 4) + '/' + REG.Pro_ID + '/Loyalty/'+ CONVERT(VARCHAR,REG.SST_Id) +'/' + CONVERT(VARCHAR,REG.SST_Id) + '_H.wav' ELSE '' END AS SoundPath,CASE WHEN REG.IsSound = 0 THEN '../Data/Sound/' + SUBSTRING(REG.Comp_ID, 6, 4) + '/' + REG.Pro_ID + '/Loyalty/'+ CONVERT(VARCHAR,REG.SST_Id) +'/' + CONVERT(VARCHAR,REG.SST_Id) + '_E.wav' ELSE '' END AS SoundPath1 FROM (SELECT     sst.SST_Id, sst.Subscribe_Id, sst.IsCash, sst.Points, sst.Frequency, sst.IsReferral, sst.IsCashConvert, sst.DateFrom, sst.DateTo, sst.Entry_Date, sst.Update_Flag_H, sst.Update_Flag_E, sst.Comments, sst.IsActive, sst.IsDelete, ms.ServiceName, p.Pro_Name, M_ServiceFeature.IsSound,ss.Comp_ID,ss.Pro_ID,ms.Service_ID FROM  M_ServiceFeature INNER JOIN M_Service AS ms ON M_ServiceFeature.Service_ID = ms.Service_ID INNER JOIN M_ServiceSubscription AS ss ON ms.Service_ID = ss.Service_ID INNER JOIN M_ServiceSubscriptionTrans AS sst ON ss.Subscribe_Id = sst.Subscribe_Id INNER JOIN Pro_Reg AS p ON ss.Pro_ID = p.Pro_ID) REG WHERE REG.SST_Id = '" + e.CommandArgument.ToString() + "' ").Tables[0];
                if (ddt.Rows.Count > 0)
                {
                    // fill limit
                    try
                    {
                      
                    }
                    catch (Exception)
                    {

                        // throw ex;
                    }

                    SST_Id1 = ddt.Rows[0]["SST_Id"].ToString();
                    selsrvid.Value = ddt.Rows[0]["Service_ID"].ToString();
                    ddlService.SelectedValue = ddt.Rows[0]["Service_ID"].ToString();
                    fillProductLoyalty(false, ddlProduct);
                    CheckValidation(ddt.Rows[0]["Service_ID"].ToString());
                    #region Service Logic Check
                    if (hdnisaddi.Value == "0")
                    {
                        #region
                        DataTable rulesdt = SQL_DB.ExecuteDataSet("SELECT Trans_Id, SST_Id, ServiceType, Rules, DistributionType, PrizeTrans_Id, MasterCodes, WinningCodes, WinCodes, Frequency,DueDate FROM M_ServiceRules WHERE SST_Id = '" + ddt.Rows[0]["SST_Id"].ToString() + "' ").Tables[0];
                        if (rulesdt.Rows.Count > 0)
                        {
                            hdnprizetransid.Value = rulesdt.Rows[0]["PrizeTrans_Id"].ToString();
                           
                        }
                        #endregion

                       
                    }
                    #endregion
                    #region
                   
                    bool check = GetUpdate(ddt.Rows[0]["Pro_ID"].ToString(), Convert.ToDateTime(ddt.Rows[0]["Entry_Date"]));
                    currindex.Value = ddt.Rows[0]["SST_Id"].ToString();
                    ddlProduct.SelectedValue = ddt.Rows[0]["Pro_ID"].ToString();
                   
                    hdnloyalty.Value = ddt.Rows[0]["Pro_ID"].ToString();
                    
                    txtloyaltydtfrom.Text = ddt.Rows[0]["DateFrom"].ToString();
                    txtloyaltydtto.Text = ddt.Rows[0]["DateTo"].ToString();
                   
                  
                  
                    btnSave.Text = "Update";
                    // Lblloyaltyhead.Text = "Update Loyalty";
                    #endregion
                }
                else
                {
                   
                    btnSave.Text = "Save";
                    //   Lblloyaltyhead.Text = "Add Loyalty";
                }
                CheckGiftCouponServiceStarted(Convert.ToInt32(SST_Id1), ddlService.SelectedValue);
                //  ModalPopupLoyalty.Show();

                #endregion
            }
        }
        catch (Exception ex)
        {
        }
    }

    private bool IsSubscribed(string Pro_ID)
    {
        string Comp_ID = Session["CompanyId"].ToString();

        DataTable dt = SQL_DB.ExecuteDataSet("select s.Pro_ID from M_ServiceSubscription s inner join M_ServiceSubscriptionTrans st on st.Subscribe_Id=s.Subscribe_Id where s.Pro_ID='"+ Pro_ID + "' and s.Comp_ID='"+ Comp_ID + "' and st.IsDelete=0").Tables[0];
        if (dt.Rows.Count > 0)
            return true;
        else
            return false;
    }
    private bool GetUpdate(string Pro_ID, DateTime DateTime)
    {
        DataTable dt = SQL_DB.ExecuteDataSet("SELECT  RowId, Comp_ID, Pro_ID, User_ID, Code1, Code2, Points, Type, Entry_Date, Mode, IsCashConvert, IsUse FROM  T_Points WHERE Pro_ID='" + Pro_ID + "' AND CONVERT(VARCHAR,Entry_Date,111) >= '" + Convert.ToDateTime(DateTime).ToString("yyyy/MM/dd") + "' ").Tables[0];
        if (dt.Rows.Count > 0)
            return false;
        else
            return true;
    }
   
    protected void GrdProductMaster_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        NewMsgpop.Visible = false;
        //  GrdProductMaster.PageIndex = e.NewPageIndex;
        filldata();
    }

   

    
  
    private readonly Random _random = new Random();

    // Generates a random number within a range.      
    public int RandomNumber(int min, int max)
    {
        return _random.Next(min, max);
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        LblMsgBody.Text = "";

        if (ddlService.SelectedIndex == 0)
        {
            //LblMsgBody.Text = "Please select the service.";
            DivMsg.Visible = true;
            DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);

            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please select the service.', 'error');", true);
            //ModalPopupLoyalty.Show();
            return;
        }
        if (ddlProduct.SelectedIndex == 0)
        {
           // LblMsgBody.Text = "Please select the product.";
            DivMsg.Visible = true;
            DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);

            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please select the product.', 'error');", true);
            //ModalPopupLoyalty.Show();
            return;
        }


        if (txtloyaltydtfrom.Text == "")
        {
          //  LblMsgBody.Text = "Please enter date from.";
            DivMsg.Visible = true;
            DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);

            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please enter date from.', 'error');", true);
            //ModalPopupLoyalty.Show();
            return;
        }
        if (txtloyaltydtto.Text == "")
        {
           // LblMsgBody.Text = "Please enter date to.";
            DivMsg.Visible = true;
            DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);

            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please enter date to.', 'error');", true);
            return;
        }
        #endregion
        string Productid = ddlProduct.SelectedValue.ToString();
        bool IsSubcribed = IsSubscribed(Productid);
        if(IsSubcribed)
        {
            
            DivMsg.Visible = true;
            DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);

            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Already subscribed !', 'The "+ddlService.SelectedItem.Text+" service is already subscribed for the "+ddlProduct.SelectedItem.Text+" product .', 'error');", true);
            
            return;

        }
        //bool CheckRwdQty = true; 
        Int64 TrwdQty = 0;
        if (Obj.Count > 0)
            TrwdQty = Obj.Sum(x => x.GiftCount);
        //bool Chk = false;

        Loyalty_Programm Reg = new Loyalty_Programm();

        Referral Ref = new Referral();


        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.Pro_ID = ddlProduct.SelectedValue.ToString();
        Reg.Service_ID = ddlService.SelectedValue;
        Reg.Subscribe_Id = selsrvplanid.Value;
        object subscribe_id = null;
        if (Reg.Subscribe_Id == null || Reg.Subscribe_Id == "")
        {
            
            
            if (subscribe_id != null)
                Reg.Subscribe_Id = subscribe_id.ToString();
            else
            {
                DataTable dtseubscription = SQL_DB.ExecuteDataTable("select * from m_servicesubscription where pro_id='" + Reg.Pro_ID + "' and comp_id='" + Reg.Comp_ID + "' and service_id='" + Reg.Service_ID + "'");
                Reg.Subscribe_Id = Utility.GetMyGenID("Subscription");
                DataRow dr = dtseubscription.Rows[0];
                dr["subscribe_id"] = Reg.Subscribe_Id;
                
                dr["entrydate"] = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff");
                DataTable dtsb = dtseubscription.Clone();
                dtsb.ImportRow(dr);
                ConnectionStringSettings settings =
      ConfigurationManager.ConnectionStrings["defaultConnectionbeta"];
                SqlConnection connection = new SqlConnection(settings.ConnectionString);
                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(connection))
                {
                    connection.Open();
                    bulkCopy.DestinationTableName = "[m_servicesubscription]";

                    bulkCopy.WriteToServer(dtsb);


                }
                Utility.SetMyGenID("Subscription");

            }
        }
        int IsSound = 0, IsAdditionalGift = 0;
        string str4 = ddlService.SelectedValue;

        switch (str4)
        {
            case "SRV1018":
                {

                    break;
                }
           
            default:
                break;
        }
        #region Logic For Check Feature

        DataTable dt = SQL_DB.ExecuteDataSet("SELECT ServiceFeaure_ID, Service_ID,(SELECT ServiceName FROM M_Service WHERE Service_ID = M_ServiceFeature.Service_ID) ServiceName, IsPoints, IsDateRange, IsSound, IsFrequency, IsAdditionalGift, IsMessageTemplete, EntryDate, IsDelete FROM M_ServiceFeature WHERE IsDelete = 0 AND Service_ID = '" + Reg.Service_ID + "' ").Tables[0];
        if (dt.Rows.Count > 0)
        {
            IsSound = Convert.ToInt32(dt.Rows[0]["IsSound"].ToString());
            IsAdditionalGift = Convert.ToInt32(dt.Rows[0]["IsAdditionalGift"].ToString());
        }
        if (IsAdditionalGift == 0)
        {
            if (TrwdQty == 0)
            {
                LblMsgBody.Text = "Please add gifts List with quantity.";
                DivMsg.Visible = true;
                DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
                //     ModalPopupLoyalty.Show();
                return;
            }
        }
        #endregion
        #region taking value from textbox
       
        if (txtloyaltydtfrom.Text != "")
            Reg.DateFrom = Convert.ToDateTime(txtloyaltydtfrom.Text).ToString("yyyy/MM/dd hh:mm:ss tt");
        else
            Reg.DateFrom = null;
        if (txtloyaltydtto.Text != "")
            Reg.DateTo = Convert.ToDateTime(txtloyaltydtto.Text).ToString("yyyy/MM/dd hh:mm:ss tt");
        else
            Reg.DateTo = null;
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        
            Reg.IsCashConvert = 1;
        
            Reg.Frequency = 1;
        
            Reg.Points = 0;

        
            Reg.AmtType = "Fixed";
            Reg.Minval = 0;
            Reg.Maxval = 0;

       

       
            Reg.IsCash = 0;
        
        //Reg.TotalNoOfCodes = Convert.ToInt64(txttcodes.Text);
        #endregion
        if (Obj.Count > 0)
            Reg.GiftList = Obj;
        if (btnSave.Text == "Save")
        {
            Reg.RowId = 0;
            Reg.DML = "I";
            Label2.Text = "Loyalty Programm saved successfully fot this Product!";
            selsrvid.Value = string.Empty;
        }
        else
        {
            Reg.RowId = Convert.ToInt32(lblproiddel.Text);
            Reg.DML = "U";
            Reg.RowId = Convert.ToInt32(currindex.Value);
            Label2.Text = "Loyalty Programm saved successfully fot this Product!";
            selsrvid.Value = string.Empty;
        }

       
            Reg.IsReferral = 0;
            Ref = new Referral();
        
        Reg.Referrals = Ref;
        #endregion
        DateTime? dttxtDueDate = null;
        


        Loyalty_Programm.InsUpdSrvForProduct(Reg); //[M_ServiceSubscriptionTrans] having inset/update

       
        #region Save for Sound File
        if (IsSound == 0)
        {
            string path = Server.MapPath("../Data/Sound"); string path1 = Server.MapPath("../Data/Sound");
           
           
                if (Convert.ToInt32(currindex.Value) > 0)
                {
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + Reg.RowId;
                    DataProvider.Utility.CreateDirectory(path);
                    path = path + "\\" + Reg.RowId + "_H.wav";
                    path1 = Server.MapPath("../Data/Sound");
                    path1 = path1 + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + currindex.Value;
                    path1 = path1 + "\\" + currindex.Value + "_H.wav";
                    System.IO.File.Copy(path1, path, true);
                }
            
            
            if (Convert.ToInt32(currindex.Value) > 0)
                {
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + Reg.RowId;
                    DataProvider.Utility.CreateDirectory(path);
                    path = path + "\\" + Reg.RowId + "_E.wav";
                    path1 = Server.MapPath("../Data/Sound");
                    path1 = path1 + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + currindex.Value;
                    path1 = path1 + "\\" + currindex.Value + "_E.wav";
                    System.IO.File.Copy(path1, path, true);
                }
            
        }
        #endregion


      

        //ClearText();
        NewMsgpop.Visible = true;
        NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
        string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        Response.Redirect("ServiceSettings.aspx");
    end:;
        // arb, handle double click 
        //  btnSave.Enabled = false;
    }
    /// <summary>
    /// Track And Trace service settings
    /// </summary>
    /// <param name="M_ServiceSubscriptionId"></param>
   

    protected void ddlService_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlService.SelectedValue != "0")
        {
           
            //  selsrvid.Value = ((ImageButton)sender).AlternateText;
            hdnisaddi.Value = string.Empty; hdnsstid.Value = string.Empty; hdnprizetransid.Value = string.Empty;
            //Label2.Text = string.Empty; NewMsgpop.Visible = false;
            //  txtdtfromamc1.Text = Convert.ToDateTime(System.DateTime.Now.AddDays(1)).ToString("dd/MM/yyyy");

           
            fillProductLoyalty(true, ddlProduct);
            string ServiceId = ddlService.SelectedValue;
            #region Logic For Additional
            DataTable dt = SQL_DB.ExecuteDataSet("SELECT ServiceFeaure_ID, Service_ID,(SELECT ServiceName FROM M_Service WHERE Service_ID = M_ServiceFeature.Service_ID) ServiceName, IsPoints, IsDateRange, IsSound, IsFrequency, IsAdditionalGift, IsMessageTemplete,IsCoupons, EntryDate, IsDelete,IsRandom FROM M_ServiceFeature WHERE IsDelete = 0 AND Service_ID = '" + ServiceId + "' ").Tables[0];
            if (dt.Rows.Count > 0)
            {
               

            }
            #endregion
            CheckValidation(ServiceId);
          
            Obj = new List<Gifts>();
          
            btnSave.Text = "Save";
           
        }
        // ModalPopupLoyalty.Show();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("ServiceSettings.aspx");
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {

    }

  
   

    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        string Pro_Id = ddlProduct.SelectedItem.Value;
        string Comp_Id = Session["CompanyId"].ToString();
        DataTable dt = new DataTable();
        dt = SQL_DB.ExecuteDataTable("select top 1 DateFrom,DateTo,Subscribe_Id from M_ServiceSubscription where Comp_ID='" + Comp_Id + "' and Pro_ID='"+ Pro_Id + "' order by EntryDate desc");
       if(dt.Rows.Count >0)
        {
            txtloyaltydtfrom.Text = dt.Rows[0]["DateFrom"].ToString();
            txtloyaltydtto.Text = dt.Rows[0]["DateTo"].ToString();
           // selsrvplanid.Value = dt.Rows[0]["Subscribe_Id"].ToString();
        }
    }


}