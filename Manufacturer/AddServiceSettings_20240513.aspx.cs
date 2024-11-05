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

public partial class Manufacturer_AddServiceSettings : System.Web.UI.Page
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
        //try
        //{
        //    //Get ContentPlaceHolder
        //    ContentPlaceHolder content = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");

        //   // Literal lt;
        //   // Label lb;
        //   // DataTable dt = SQL_DB.ExecuteDataSet("SELECT Service_ID, ServiceName, IsShowPrice, EntryDate, Image, IsActive, IsDelete FROM  M_Service WHERE IsActive = 0 AND IsDelete = 0  AND  Service_ID IN (SELECT  Service_ID FROM M_ServiceSubscription WHERE  Comp_ID='" + Session["CompanyId"].ToString() + "' AND IsDelete = 0) ").Tables[0];
        //    //if (dt.Rows.Count > 0)
        //    //{
        //    //    for (int i = 0; i < dt.Rows.Count; i++)
        //    //    {
        //    //        srv = new StringBuilder();
        //    //        srv.Append("<div class='col-md-3'>");
        //    //        srv.Append("<div class='restmenuwrap'>");
        //    //        srv.Append("<div class='restitem clearfix'>");
        //    //        lt = new Literal();
        //    //        lt.Text = srv.ToString();
        //    //        pnlTextBox.Controls.Add(lt);

        //    //        //Button To add TextBoxes
        //    //        ImageButton btnAddTxt = new ImageButton();
        //    //        btnAddTxt.ID = "BtnImgsrv" + i.ToString();
        //    //        btnAddTxt.AlternateText = dt.Rows[i]["Service_ID"].ToString();
        //    //        btnAddTxt.ToolTip = "Click Add For " + dt.Rows[i]["ServiceName"].ToString();
        //    //        btnAddTxt.Attributes.Add("class", "rm-thumb");
        //    //        btnAddTxt.OnClientClick = "javascript:GetService(this.alt)";
        //    //        btnAddTxt.ImageUrl = ProjectSession.absoluteSiteBrowseUrl + "/Data/Data/Service/" + dt.Rows[i]["Image"].ToString();
        //    //        btnAddTxt.Click += new ImageClickEventHandler(btnSelectService_Click);
        //    //        pnlTextBox.Controls.Add(btnAddTxt);
        //    //        srv = new StringBuilder();

        //    //        srv.Append("<h5 class='headname'>" + dt.Rows[i]["ServiceName"].ToString() + "</h5>");
        //    //        srv.Append("<div style='width:100%;padding-left:0px;padding-top:10px;'>");
        //    //        //srv.Append("<span style='width:49%; float:left; text-align:left;'><a href='#'>Know More...</a></span><span style='width:49%; float:right; padding: 1px !important;  text-align: center;'><p title= '" + dt.Rows[i]["Service_ID"].ToString() + "' onclick='javascript:GetService(this.title)' style='border:solid 1px #e6e6e6; background-color:#909090; color:#f0f0f0; cursor:pointer;'>Buy Now</p></span>");
        //    //        srv.Append("</div>");
        //    //        srv.Append("</div>");
        //    //        srv.Append("</div>");
        //    //        srv.Append("</div>");

        //    //        lt = new Literal();
        //    //        lt.Text = srv.ToString();
        //    //        pnlTextBox.Controls.Add(lt);

        //    //    }
        //    //}
        //}
        //catch (Exception ex)
        //{
        //    Response.Write(ex.Message.ToString());
        //}
        #endregion
        if (Session["CompanyId"] == null)
            Response.Redirect("../Info/Login.aspx?Page=ServiceSettings.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }

        //arb, prevent refresh 
        //ClearText();

        if (!Page.IsPostBack)
        {
           
            #region Referral Service : Load Settins
            rdIsRefCash.Checked = false; rdIsRefGift.Checked = false; rdIsRefPoints.Checked = true;
            lblrefHead.Text = "Points";
            divpoinscash.Visible = true;
            divrefGift.Visible = false;
            txtreffrom.Text = string.Empty;
            txtrefto.Text = string.Empty;
            divisreferral.Visible = true;
            chkRefIsCash.Checked = false;
            chkRefIsCash.Visible = true;
            #endregion
            Session["Gift"] = "";
            Session["Plan_ID"] = "";
            diviscash.Visible = false;
            divrange.Visible = false;
            divrange1.Visible = false;
            stepvalue.Visible = false;
            FillDropdown();
            FillAmtypeDropdown();
            hhdnCompID.Value = Session["CompanyId"].ToString().Substring(5, 4);
            Session["Path"] = Server.MapPath("../Data/Sound");
           
            ////******************* Open For Retailler Service *****************//
            ////Session["Comp_type"]
            //if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
            //    Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            //if (Session["Comp_type"].ToString() == "D")
            //    imgNew.Visible = false;
            //else
            //    imgNew.Visible = true;

            // Add Code for Retailer
            //if (Session["Comp_type"].ToString() == "D")
            //{
            //    if (Session["CompanyId"].ToString() == "0")
            //        imgNew.Visible = false;
            //    else
            //        imgNew.Visible = true;
            //}
            //else
            //    imgNew.Visible = true;
            ShowDiv(false);
            if (Request.QueryString["id"] != null)
            {
                SStid_Prop = Convert.ToInt64(Request.QueryString["id"]);
            }
            if (SStid_Prop > 0)
            {
                filldata();
                FillchkTT();
            }
            
          
            // NewMsgpop.Visible = false;

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
    private void FillchkTT()
    {
        if (ddlService.SelectedItem.Value == "SRV1021")
        {
            divPU.Visible = true;
            divPU2.Visible = false;
            divPU3.Visible = true;
            //BindUT("Manager", ddlM);
            //BindUT("Distributor", ddlDis);
            //BindUT("Sub-Distributor", ddlSDis);
            //BindUT("Retailer", ddlret);            
            //BindListboxproductionunit(ddlPUname); BindListboxchannels(ddlchnls);
            FillGrid_TT();
        }
        else
        {
            divPU.Visible = false;
            divPU2.Visible = false;
            divPU3.Visible = false;
        }
        if (ddlService.SelectedItem.Value == "SRV1023")
        {
            divWarranty.Visible = true;
        }
        else
        {
            divWarranty.Visible = false;
        }
    }
    public void FillGrid_TT()
    {
        DataTable dt2 = new DataTable();  
        if (SStid_Prop > 0)
        {
            // create procedure - create temp tables
            dt2 = ExecuteNonQueryAndDatatable.TrackTraceUpdate(SStid_Prop).Tables[0];

        }
        else
        {
            dt2 = SQL_DB.ExecuteDataTable("select 0 as Typevalue,*,cast(1 as bit) as ischecked from [UserType_TrackTrace] where compid='" + ProjectSession.strCompanyid + "'");
            DataRow dr = dt2.NewRow();
            dr["type"] = "Production Unit";
            dr["TTUserTypeid"] = (int)EnumClass.TrackTraceChannel.ProductionUnit;
            dr["ischecked"] = 1;
            dr["Typevalue"] = 0;
            dt2.Rows.InsertAt(dr, 0);
            DataRow dr2 = dt2.NewRow();
            dr2["type"] = "Warehouse";
            dr2["TTUserTypeid"] = (int)EnumClass.TrackTraceChannel.Warehouse;
            dr2["ischecked"] = 1;
            dr2["Typevalue"] = 0;
            dt2.Rows.InsertAt(dr2, 1);
        }
        

        // if (dt2.Rows.Count > 0)
        {
            GrdVw.DataSource = dt2;
            // ddlchnls.DataTextField = "name";
            // ddlchnls.DataValueField = "ChannelsID";
            GrdVw.DataBind();
           // lblcount.Text = dt2.Rows.Count.ToString();
            if (GrdVw.Rows.Count > 0)
                GrdVw.HeaderRow.TableSection = TableRowSection.TableHeader;

            if (SStid_Prop > 0)
            {

            }

                ((ImageButton)GrdVw.Rows[0].FindControl("imgbtnUp")).Visible = false;
            ((ImageButton)GrdVw.Rows[GrdVw.Rows.Count - 1].FindControl("imgbtnDown")).Visible = false;
        }
    }
    public void BindUT(string strUT,DropDownList ddlM, string ddlvalue)
    {
        DataTable dt = SQL_DB.ExecuteDataTable("Select * from Dealer  where [type] in (Select  TTUserTypeid from [UserType_TrackTrace] where type = '" + strUT + "')");
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
    public void BindListboxproductionunit(DropDownList ddl,string ddlvalue)
    {
        DataTable dt = SQL_DB.ExecuteDataTable("select * from productionunit where compid='" + ProjectSession.strCompanyid + "'");
        if (dt.Rows.Count > 0)
        {
            ddl.DataSource = dt;
            ddl.DataTextField = "name";
            ddl.DataValueField = "ProductionUnitID";
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("Select", "0"));
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
    public void BindListboxchannels(DropDownList ddl, string ddlvalue)
    {
        DataTable dt2 = SQL_DB.ExecuteDataTable("select * from channels where compid='" + ProjectSession.strCompanyid + "'");
        if (dt2.Rows.Count > 0)
        {
            ddl.DataSource = dt2;
            ddl.DataTextField = "name";
            ddl.DataValueField = "ChannelsID";
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("Select", "0"));
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
    private void FillAmtypeDropdown()
    {
        Object9420 obj = new Object9420();
        obj.Comp_ID = Session["CompanyId"].ToString();

        DataSet ds = SQL_DB.ExecuteDataSet("select * from Amount_type");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "amtype", "amtype", ddlamttype, "--Select--");
        ddlamttype.SelectedIndex = 0;
    }
    private void FillDropdown()
    {
        Object9420 obj = new Object9420();
        obj.Comp_ID = Session["CompanyId"].ToString();
        // DataSet ds = function9420.FetchRequestProductList(obj);
        // DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlsearchPro, "--Select--");
        // ddlsearchPro.SelectedIndex = 0;
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Service_ID, ServiceName, IsShowPrice, EntryDate, Image, IsActive, IsDelete FROM  M_Service WHERE IsActive = 0 AND IsDelete = 0  AND  Service_ID IN (SELECT  Service_ID FROM M_ServiceSubscription WHERE  Comp_ID='" + Session["CompanyId"].ToString() + "' AND IsDelete = 0)");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Service_ID", "ServiceName", ddlService, "--Select--");
        ddlService.SelectedIndex = 0;
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
        txtReferralLimit.Text = string.Empty;
        RFVIsPoints.ValidationGroup = "NN";
        RFVIsMessage.ValidationGroup = "NN";
        RFVIsSoundH.ValidationGroup = "NN";
        RFVIsSoundE.ValidationGroup = "NN";
        Reqreffrom.ValidationGroup = "NN";
        Reqrefto.ValidationGroup = "NN";
        RFVIsCash.ValidationGroup = "NN";
        lblRwdHeader.Text = string.Empty; lblRwdCounts.Text = string.Empty;
        hdnisaddi.Value = string.Empty; hdnsstid.Value = string.Empty; hdnprizetransid.Value = string.Empty;
        DivMsg.Visible = false;
        txtfrequency.Text = string.Empty;
        hdnpointsval.Value = string.Empty;
        ChangeUpdateFields(true);
        ChnageValidation(true);
        txtloyaltydtfrom.Text = string.Empty;
        txtloyaltydtto.Text = string.Empty;
        txtloyaltypoints.Text = string.Empty;
        //txtProductName.Text = string.Empty;
        ddlProduct.SelectedIndex = 0;
        txtCommentsTxt.Text = string.Empty;
        chkconvert.Checked = false;
       // txtDateFrom.Text = string.Empty;
       // txtDateTo.Text = string.Empty;
        hdneditval.Value = string.Empty;
        txtcashamt.Text = string.Empty;
        filldata();
    }
    
    public void Instant(bool bln)
    {
        divinstant.Visible = bln;
        divinstant2.Visible = bln;
        divinstant3.Visible = bln;
        divinstant4.Visible = bln;
      //  divisAdditionalGift_Grid.Visible = bln;
    }
    public void Duedate(bool bln)
    {
        divduedate.Visible = bln;
        divduedate2.Visible = bln;
        divduedate3.Visible = bln;
        divduedate4.Visible = bln;
       // divisAdditionalGift_Grid.Visible = bln;
    }

    public void ShowDiv(bool bln)
    {
        //divispoints.Visible = bln;
        divisreferral.Visible = bln;
        divpoinscash.Visible = bln;
        divtxtReferralLimit.Visible = bln;
        divisfrequency.Visible = bln;
        diviscash.Visible = bln;
        divisAdditionalGift.Visible = bln;
        divisAdditionalGift_Grid.Visible = bln;
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
            Israndom= Convert.ToInt32(dt.Rows[0]["IsRandom"].ToString());
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
               divispoints.Visible = false;
              RFVIsPoints.ValidationGroup = "NN";
            //}
            if (IsAdditionalGift == 0)
            {
                hdnisaddi.Value = IsAdditionalGift.ToString();
                divisAdditionalGift.Visible = true;
                divisAdditionalGift_Grid.Visible = true;
                Instant(true);
                Duedate(false);
                //divinstant.Visible = true;
                //divduedate.Visible = false;

                //ReqTotalNoOfCodes.ValidationGroup = "SRVS";
            }
            else
            {
                hdnisaddi.Value = string.Empty;
                divisAdditionalGift.Visible = false;
                divisAdditionalGift_Grid.Visible = false;
                //divinstant.Visible = false;
                //divduedate.Visible = false;
                Instant(false);
                Duedate(false);
                
                //ReqTotalNoOfCodes.ValidationGroup = "NN";
            }
            if (IsSound == 0)
            {
                divissoundComments.Visible = true;
                RFVIsMessage.ValidationGroup = "SRVS";
                RFVIsSoundH.ValidationGroup = "SRVS";
                RFVIsSoundE.ValidationGroup = "SRVS";
            }
            else
            {
                divissoundComments.Visible = false;
                RFVIsMessage.ValidationGroup = "NN";
                RFVIsSoundH.ValidationGroup = "NN";
                RFVIsSoundE.ValidationGroup = "NN";
            }
            if (IsFrequency == 0)
                divisfrequency.Visible = true;
            else
                divisfrequency.Visible = false;
            divtxtReferralLimit.Visible = false;
            if (IsReferral == 0)
            {
                Reqreffrom.ValidationGroup = "SRVS";
                Reqrefto.ValidationGroup = "SRVS";
                rdIsRefCash.Checked = false; rdIsRefPoints.Checked = true; rdIsRefGift.Checked = false;
                // lblrefHead.Text = "Cash";
                lblrefHead.Text = "Points";
                divpoinscash.Visible = true;
                divrefGift.Visible = false;
                txtreffrom.Text = string.Empty;
                txtrefto.Text = string.Empty;
                divisreferral.Visible = true;
                divtxtReferralLimit.Visible = true;
            }
            else
            {
                Reqreffrom.ValidationGroup = "NN";
                Reqrefto.ValidationGroup = "NN";
                rdIsRefCash.Checked = false; rdIsRefPoints.Checked = false; rdIsRefGift.Checked = false;
                divpoinscash.Visible = false;
                divrefGift.Visible = false;
                txtreffrom.Text = string.Empty;
                txtrefto.Text = string.Empty;
                divisreferral.Visible = false;
            }
            if (IsCash == 0)
            {
                diviscash.Visible = true;
                RFVIsCash.ValidationGroup = "SRVS";
            }
            else
            {
                diviscash.Visible = false;
                RFVIsCash.ValidationGroup = "NN";
            }
            if (Israndom == 0)
            {
                amounttype.Visible = false;
                reqamount.ValidationGroup = "SRVS";
            }
            else
            {
                amounttype.Visible = true;
                reqamount.ValidationGroup = "NN";
            }
        }
    }
    protected void rdReferral_CheckedChanged(object sender, EventArgs e)
    {
        if (rdIsRefPoints.Checked)
        {
            rdIsRefCash.Checked = false; rdIsRefGift.Checked = false; rdIsRefPoints.Checked = true;
            lblrefHead.Text = "Points";
            divpoinscash.Visible = true;
            divrefGift.Visible = false;
            txtreffrom.Text = string.Empty;
            txtrefto.Text = string.Empty;
            divisreferral.Visible = true;
            chkRefIsCash.Checked = false;
            chkRefIsCash.Visible = true;
        }
        else if (rdIsRefCash.Checked)
        {
            rdIsRefPoints.Checked = false; rdIsRefGift.Checked = false; rdIsRefCash.Checked = true;
            lblrefHead.Text = "Cash";
            divpoinscash.Visible = true;
            divrefGift.Visible = false;
            txtreffrom.Text = string.Empty;
            txtrefto.Text = string.Empty;
            divisreferral.Visible = true;
            chkRefIsCash.Checked = false;
            chkRefIsCash.Visible = false;
        }
        else if (rdIsRefGift.Checked)
        {
            rdIsRefCash.Checked = false; rdIsRefPoints.Checked = false; rdIsRefGift.Checked = true;
            //lblrefHead.Text = "Cash";
            divpoinscash.Visible = false;
            divrefGift.Visible = true;
            txtreffrom.Text = string.Empty;
            txtrefto.Text = string.Empty;
            FillGiftddl(ddlrefGiftFrom, ddlService.SelectedValue);
            FillGiftddl(ddlrefGiftTo, ddlService.SelectedValue);
            divisreferral.Visible = true;
            chkRefIsCash.Checked = false;
            chkRefIsCash.Visible = false;
        }
        else
        {
            rdIsRefCash.Checked = false; rdIsRefPoints.Checked = false; rdIsRefGift.Checked = false;
            //lblrefHead.Text = "Cash";
            divpoinscash.Visible = true;
            divrefGift.Visible = false;
            txtreffrom.Text = string.Empty;
            txtrefto.Text = string.Empty;
            divisreferral.Visible = false;
            chkRefIsCash.Checked = false;
            chkRefIsCash.Visible = false;
        }
      //  ModalPopupLoyalty.Show();
    }
    protected void btnSelectService_Click(object sender, ImageClickEventArgs e)
    {
        //selsrvid.Value = ((ImageButton)sender).AlternateText;
        //hdnisaddi.Value = string.Empty; hdnsstid.Value = string.Empty; hdnprizetransid.Value = string.Empty; Label2.Text = string.Empty; NewMsgpop.Visible = false;
        //txtdtfromamc1.Text = Convert.ToDateTime(System.DateTime.Now.AddDays(1)).ToString("dd/MM/yyyy");
        //fillProductLoyalty(true, ddlProduct);
        //string ServiceId = selsrvid.Value;
        //#region Logic For Additional
        //DataTable dt = SQL_DB.ExecuteDataSet("SELECT ServiceFeaure_ID, Service_ID,(SELECT ServiceName FROM M_Service WHERE Service_ID = M_ServiceFeature.Service_ID) ServiceName, IsPoints, IsDateRange, IsSound, IsFrequency, IsAdditionalGift, IsMessageTemplete,IsCoupons, EntryDate, IsDelete FROM M_ServiceFeature WHERE IsDelete = 0 AND Service_ID = '" + ServiceId + "' ").Tables[0];
        //if (dt.Rows.Count > 0)
        //{
        //    //int IsAdditionalGift = 0;
        //    //IsAdditionalGift = Convert.ToInt32(dt.Rows[0]["IsAdditionalGift"].ToString());
        //    int IsAdditionalGift = 1, IsCoupons = 1;
        //    IsAdditionalGift = Convert.ToInt32(dt.Rows[0]["IsAdditionalGift"].ToString());
        //    IsCoupons = Convert.ToInt32(dt.Rows[0]["IsCoupons"].ToString());
        //    if (IsAdditionalGift == 0)
        //    {
        //        txttcodesrand.Enabled = false; txtrand.Enabled = false;
        //        rdAtDueDate.Checked = false; rdInstant.Checked = true;
        //        rdRandom.Checked = false; rdAllParticipant.Checked = false; rdFirstRandomnth.Checked = false; rdFirstnth.Checked = true;
        //        rdAllton.Checked = false; rdAlltoAll.Checked = false; rdFirstnton.Checked = false; rdAlltonthrand.Checked = true;
        //        rdSequenceDistri.Checked = false; rdRandomDistri.Checked = true;
        //        txttcodes.Text = string.Empty; txtnth.Text = string.Empty;
        //        txttcodes.Enabled = true; txtnth.Enabled = true;
        //        txttcodesrand.Text = string.Empty; txtrand.Text = string.Empty;
        //        txteverynth.Text = string.Empty; txteverywin.Text = string.Empty;
        //        txteverynth.Enabled = false; txteverywin.Enabled = false;
        //        btnGSave.Text = "Save";
        //        divinstant.Visible = true; divduedate.Visible = false;

        //        reqnth.ValidationGroup = "SRVS"; txttcodes.ValidationGroup = "SRVS";
        //        reqtcodesrand.ValidationGroup = "NN"; reqrand.ValidationGroup = "NN";
        //        txteverynth.ValidationGroup = "NN"; txteverywin.ValidationGroup = "NN";
        //        reqallpFirstn.ValidationGroup = "NN"; reqallpFirstnton.ValidationGroup = "NN";
        //        reqalltonth.ValidationGroup = "NN"; reqrandfreq.ValidationGroup = "NN";
        //        reqalltonCustomer.ValidationGroup = "NN";
        //        ChkInfinite.Enabled = false;
        //        txtGiftQty.Text = string.Empty;
        //        if (IsCoupons == 0)
        //        {
        //            #region Check Coupon
        //            string ChkQry = "SELECT * FROM (SELECT SUM(m.CouponCount) TotalCount,(SELECT COUNT(Coupon_ID) FROM M_CouponCodes WHERE Comp_ID = '" + Session["CompanyId"].ToString() + "' AND isnull(SST_ID,'') = '' GROUP BY Comp_ID) as UseCount FROM M_CouponRequest AS m WHERE m.Comp_ID = '" + Session["CompanyId"].ToString() + "' AND m.IsAdminVerify = 1 AND IsDelete = 0) REG WHERE REG.UseCount > 0";
        //            DataTable td = SQL_DB.ExecuteDataTable(ChkQry);// ("SELECT * FROM M_CouponRequest WHERE Comp_ID = '" + Session["CompanyId"].ToString() + "' AND IsAdminVerify = 1 AND IsDelete = 0").Tables[0];
        //            if (td.Rows.Count == 0)
        //            {
        //                Label2.Text = "Please request for coupon first <a href='FrmCouponRequest.aspx?Open=OP' target='_blank'>Click for Coupon Request</>.";
        //                NewMsgpop.Visible = true;
        //                NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
        //                string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //                return;
        //            }
        //            #endregion
        //            rdAllParticipant.Enabled = false;
        //            rdAlltoAll.Enabled = false;
        //        }
        //        else
        //        {
        //            rdAllParticipant.Enabled = true;
        //            rdAlltoAll.Enabled = true;
        //        }
        //    }
        //    else
        //    {
        //        rdInstant.Checked = false; rdAtDueDate.Checked = false;
        //        rdRandomDistri.Checked = false; rdSequenceDistri.Checked = false;
        //        rdFirstnth.Checked = false; rdRandom.Checked = false; rdAllParticipant.Checked = false; rdFirstRandomnth.Checked = false;
        //        rdFirstnton.Checked = false; rdAlltonthrand.Checked = false; rdAllton.Checked = false; rdAlltoAll.Checked = false;
        //        reqnth.ValidationGroup = "NN"; txttcodes.ValidationGroup = "NN";
        //        reqtcodesrand.ValidationGroup = "NN"; reqrand.ValidationGroup = "NN";
        //        txteverynth.ValidationGroup = "NN"; txteverywin.ValidationGroup = "NN";
        //        reqallpFirstn.ValidationGroup = "NN"; reqallpFirstnton.ValidationGroup = "NN";
        //        reqalltonth.ValidationGroup = "NN"; reqrandfreq.ValidationGroup = "NN";
        //        reqalltonCustomer.ValidationGroup = "NN";
        //    }
        //}
        //#endregion
        //CheckValidation(ServiceId);
        //FillPlanMasterGrid(ServiceId, 0);
        //FillGiftddl(ddlAddGift, ServiceId);
        //Obj = new List<Gifts>();
        //FillGiftDetails(GrdVwGift, 1);
        //btnSave.Text = "Save";
        //ModalPopupLoyalty.Show();
    }

    private void FillGiftddl(DropDownList ddlAddGift, string ServiceId)
    {
        DataSet ds = ExecuteNonQueryAndDatatable.Proc_GetGiftList(ProjectSession.strCompanyid, ServiceId);
        DataTable dt = ds.Tables[0];
        //   string Qry = "", Qry1 = "";
        //Qry = "SELECT  Gift_ID + '*' + CONVERT(VARCHAR,0) + '*' + CONVERT(VARCHAR,1) AS Gift_ID, GiftName,0 as CouponCount,1 AS Coupon FROM M_Gift  " +
        //    " WHERE Comp_ID = '" + Session["CompanyId"].ToString() + "' AND isnull(IsDelete,0) = 0 and isnull(IsActive,0) =0";
        //int IsCoupons = 1;
        //IsCoupons = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT IsCoupons FROM M_ServiceFeature WHERE IsDelete = 0 AND Service_ID ='" + ServiceId + "'"));
        //if (IsCoupons == 0)
        //{
        //    DataTable td = SQL_DB.ExecuteDataSet("SELECT * FROM M_CouponRequest WHERE Comp_ID = '" + Session["CompanyId"].ToString() + "' AND IsAdminVerify = 1 AND IsDelete = 0").Tables[0];
        //    if (td.Rows.Count > 0)
        //    {
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0][0].ToString() != "-1")
            {
                if (txtloyaltydtfrom.Text == "")
                {
                    if (dt.Rows[0]["DateFrom"].ToString() != "")
                        txtloyaltydtfrom.Text = Convert.ToDateTime(dt.Rows[0]["DateFrom"].ToString()).ToString("dd/MM/yyyy"); //Convert.ToDateTime(System.DateTime.Now).ToString("dd/MM/yyyy");
                    if (dt.Rows[0]["DateTo"].ToString() != "")
                        txtloyaltydtto.Text = Convert.ToDateTime(dt.Rows[0]["DateTo"].ToString()).ToString("dd/MM/yyyy"); //Convert.ToDateTime(System.DateTime.Now).AddDays(15).ToString("dd/MM/yyyy");
                }


                string GiftID = "";
                if (Obj.Count > 0)
                {
                    foreach (var item in Obj)
                    {
                        GiftID += "'" + item.Gift_ID + "',";
                    }
                    if (GiftID.Length > 1)
                        GiftID = GiftID.ToString().Substring(0, GiftID.Length - 1);
                }
                else
                    GiftID = "";


                Session["Gift"] = dt;
                DataProvider.MyUtilities.FillDDLInsertZeroIndexString(dt, "Gift_ID", "GiftName", ddlAddGift, "--Select--");
                ddlAddGift.SelectedIndex = 0;

            }
        }
        //        //  Qry1 = " SELECT CouponRequest_ID,Coupon_ID + '*' + CONVERT(VARCHAR,CouponCount-ISNULL(UseCount,0)) + '*' + CONVERT(VARCHAR,0) AS Gift_ID , * FROM (SELECT (SELECT CouponName FROM M_Coupon WHERE Coupon_ID=M_CouponRequest.Coupon_ID) AS GiftName,CouponRequest_ID,ISNULL((SELECT COUNT(Coupon_ID) FROM M_CouponCodes WHERE Comp_ID = '" + Session["CompanyId"].ToString() + "' AND Coupon_ID =M_CouponRequest.Coupon_ID  AND isnull(SST_ID,'') <> '' GROUP BY Comp_ID),0) as UseCount, " +
        //        Qry1 = " SELECT CouponRequest_ID,Coupon_ID + '*' + CONVERT(VARCHAR,CouponCount-ISNULL(UseCount,0)) + '*' + CONVERT(VARCHAR,0) + '*' + CouponRequest_ID AS Gift_ID , * FROM (SELECT (SELECT CouponName FROM M_Coupon WHERE Coupon_ID=M_CouponRequest.Coupon_ID) AS GiftName,CouponRequest_ID,ISNULL((SELECT COUNT(Coupon_ID) FROM M_CouponCodes WHERE Comp_ID = '" + Session["CompanyId"].ToString() + "' AND Coupon_ID =M_CouponRequest.Coupon_ID  AND isnull(SST_ID,'') <> '' GROUP BY Comp_ID),0) as UseCount, " +
        //            //" Coupon_ID + '*' + CONVERT(VARCHAR,CouponCount-ISNULL(AllotedCount,0)) + '*' + CONVERT(VARCHAR,0) AS Gift_ID
        //        " Coupon_ID, CouponCount-ISNULL(AllotedCount,0) AS CouponCount,0 AS Coupon " +
        //        " FROM M_CouponRequest " +
        //        " WHERE Comp_ID = '" + Session["CompanyId"].ToString() + "' AND IsAdminVerify = 1 AND IsDelete = 0  " +
        //        " AND '" + Convert.ToDateTime(txtloyaltydtfrom.Text).ToString("yyyy/MM/dd") + "' BETWEEN DateFrom AND DateTo AND '" + Convert.ToDateTime(txtloyaltydtto.Text).ToString("yyyy/MM/dd") + "' BETWEEN DateFrom AND DateTo ) REG WHERE REG.CouponCount > 0";
        //        txtloyaltydtfrom.Text = string.Empty;
        //        txtloyaltydtto.Text = string.Empty;
        //    }
        //}
        //string GiftID = "";
        //if (Obj.Count > 0)
        //{
        //    foreach (var item in Obj)
        //    {
        //        GiftID += "'" + item.Gift_ID + "',";
        //    }
        //    if (GiftID.Length > 1)
        //        GiftID = GiftID.ToString().Substring(0, GiftID.Length - 1);
        //}
        //else
        //    GiftID = "";
        //if (IsCoupons == 0)
        //{
        //    if (Qry1 != "")
        //        Qry = Qry1;
        //    // Both data Gift And Coupons *//
        //    //if (Qry1 != "")
        //    //    Qry = "SELECT* FROM ( " + Qry + " UNION ALL " + Qry1 + " ) Reg ORDER BY Reg.Gift_ID,Reg.GiftName";
        //}
        //  DataTable dt = SQL_DB.ExecuteDataSet(Qry).Tables[0]; Session["Gift"] = dt;

        //Session["Gift"] = dt;
        //DataProvider.MyUtilities.FillDDLInsertZeroIndexString(dt, "Gift_ID", "GiftName", ddlAddGift, "--Select--");
        //ddlAddGift.SelectedIndex = 0;
    }
    private void FillGiftddl_old(DropDownList ddlAddGift, string ServiceId)
    {
        string Qry = "", Qry1 = "";
        Qry = "SELECT  Gift_ID + '*' + CONVERT(VARCHAR,0) + '*' + CONVERT(VARCHAR,1) AS Gift_ID, GiftName,0 as CouponCount,1 AS Coupon FROM M_Gift  " +
            " WHERE Comp_ID = '" + Session["CompanyId"].ToString() + "' AND isnull(IsDelete,0) = 0 ";
        int IsCoupons = 1;
        IsCoupons = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT IsCoupons FROM M_ServiceFeature WHERE IsDelete = 0 AND Service_ID ='" + ServiceId + "'"));
        if (IsCoupons == 0)
        {
            DataTable td = SQL_DB.ExecuteDataSet("SELECT * FROM M_CouponRequest WHERE Comp_ID = '" + Session["CompanyId"].ToString() + "' AND IsAdminVerify = 1 AND IsDelete = 0").Tables[0];
            if (td.Rows.Count > 0)
            {
                if (txtloyaltydtfrom.Text == "")
                {
                    txtloyaltydtfrom.Text = Convert.ToDateTime(td.Rows[0]["DateFrom"].ToString()).ToString("dd/MM/yyyy"); //Convert.ToDateTime(System.DateTime.Now).ToString("dd/MM/yyyy");
                    txtloyaltydtto.Text = Convert.ToDateTime(td.Rows[0]["DateTo"].ToString()).ToString("dd/MM/yyyy"); //Convert.ToDateTime(System.DateTime.Now).AddDays(15).ToString("dd/MM/yyyy");
                }
                //  Qry1 = " SELECT CouponRequest_ID,Coupon_ID + '*' + CONVERT(VARCHAR,CouponCount-ISNULL(UseCount,0)) + '*' + CONVERT(VARCHAR,0) AS Gift_ID , * FROM (SELECT (SELECT CouponName FROM M_Coupon WHERE Coupon_ID=M_CouponRequest.Coupon_ID) AS GiftName,CouponRequest_ID,ISNULL((SELECT COUNT(Coupon_ID) FROM M_CouponCodes WHERE Comp_ID = '" + Session["CompanyId"].ToString() + "' AND Coupon_ID =M_CouponRequest.Coupon_ID  AND isnull(SST_ID,'') <> '' GROUP BY Comp_ID),0) as UseCount, " +
                Qry1 = " SELECT CouponRequest_ID,Coupon_ID + '*' + CONVERT(VARCHAR,CouponCount-ISNULL(UseCount,0)) + '*' + CONVERT(VARCHAR,0) + '*' + CouponRequest_ID AS Gift_ID , " +
                    "* FROM (SELECT (SELECT CouponName FROM M_Coupon WHERE Coupon_ID=M_CouponRequest.Coupon_ID) AS GiftName,CouponRequest_ID,ISNULL((SELECT COUNT(Coupon_ID) " +
                    "FROM M_CouponCodes WHERE Comp_ID = '" + Session["CompanyId"].ToString() + "' AND Coupon_ID =M_CouponRequest.Coupon_ID  AND isnull(SST_ID,'') <> '' GROUP BY Comp_ID),0) as UseCount, " +
                //" Coupon_ID + '*' + CONVERT(VARCHAR,CouponCount-ISNULL(AllotedCount,0)) + '*' + CONVERT(VARCHAR,0) AS Gift_ID
                " Coupon_ID, CouponCount-ISNULL(AllotedCount,0) AS CouponCount,0 AS Coupon " +
                " FROM M_CouponRequest " +
                " WHERE Comp_ID = '" + Session["CompanyId"].ToString() + "' AND IsAdminVerify = 1 AND IsDelete = 0  " +
                " AND '" + Convert.ToDateTime(txtloyaltydtfrom.Text).ToString("yyyy/MM/dd") + "' BETWEEN DateFrom AND DateTo AND '" + Convert.ToDateTime(txtloyaltydtto.Text).ToString("yyyy/MM/dd") + "' BETWEEN DateFrom AND DateTo ) REG WHERE REG.CouponCount > 0";
                txtloyaltydtfrom.Text = string.Empty;
                txtloyaltydtto.Text = string.Empty;
            }
        }
        string GiftID = "";
        if (Obj.Count > 0)
        {
            foreach (var item in Obj)
            {
                GiftID += "'" + item.Gift_ID + "',";
            }
            if (GiftID.Length > 1)
                GiftID = GiftID.ToString().Substring(0, GiftID.Length - 1);
        }
        else
            GiftID = "";
        if (IsCoupons == 0)
        {
            if (Qry1 != "")
                Qry = Qry1;
            // Both data Gift And Coupons *//
            //if (Qry1 != "")
            //    Qry = "SELECT* FROM ( " + Qry + " UNION ALL " + Qry1 + " ) Reg ORDER BY Reg.Gift_ID,Reg.GiftName";
        }
        DataTable dt = SQL_DB.ExecuteDataSet(Qry).Tables[0]; Session["Gift"] = dt;
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(dt, "Gift_ID", "GiftName", ddlAddGift, "--Select--");
        ddlAddGift.SelectedIndex = 0;
    }
    private void FillGiftDetails(GridView GrdVw, int p)
    {
        if (p == 0)
        {
            Obj = new List<Gifts>();
            DataTable giftdt = SQL_DB.ExecuteDataSet("SELECT  Trans_Id, SST_Id, PrizeTrans_Id, Gift_Id, GiftName, GiftCount, DistributeCount FROM M_ServicePrize WHERE SST_Id = '" + hdnsstid.Value + "'").Tables[0];
            if (giftdt.Rows.Count > 0)
            {
                int counter = 1;
                for (int t = 0; t < giftdt.Rows.Count; t++)
                {
                    Obj.Add(new Gifts { AdditionalGift_ID = counter, Gift_ID = giftdt.Rows[t]["Gift_Id"].ToString(), GiftName = giftdt.Rows[t]["GiftName"].ToString(), GiftCount = Convert.ToInt64(giftdt.Rows[t]["GiftCount"]), DistributeGiftCount = Convert.ToInt64(giftdt.Rows[t]["DistributeCount"]), IsCoupon = "0", SpendTotalCount = "0" });
                    counter++;
                }
            }
        }
        if (Obj.Count > 0)
        {
            int counter = 1;
            foreach (var item in Obj)
            {
                item.AdditionalGift_ID = counter;
                counter++;
            }
        }
        GrdVw.DataSource = Obj;
        GrdVw.DataBind();
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
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Subscribe_Id, Service_ID, Comp_ID, Pro_ID, Plan_ID, PlanName, PlanMasterPeriod, PlanSalePeriod, PlanMasterPrice, PlanSalePrice, DateFrom, DateTo, EntryDate, IsActive, IsDelete, IsAdminVerify FROM M_ServiceSubscription  WHERE Service_ID = '" + Arr[1] + "' AND Pro_ID = '" + Arr[0] + "' AND IsDelete = 0 and [start_order]="+ Arr[2].Split(',')[0].Split('-')[0] + " and [start_series]=" + Arr[2].Split(',')[0].Split('-')[1] + "and [end_order]=" + Arr[2].Split(',')[1].Split('-')[0] + "and [end_series]=" + Arr[2].Split(',')[1].Split('-')[1] + "");
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
        //Qry = "SELECT Pro_ID, Pro_Name FROM Pro_Reg WHERE (Comp_ID = '" + Reg.Comp_ID + "') AND (Doc_Flag = 1) AND (Sound_Flag = 1) AND (Pro_ID IN (SELECT Pro_ID FROM M_ServiceSubscription WHERE  Pro_ID <> '" + lblproiddel.Text + "' AND (Comp_ID = Pro_Reg.Comp_ID)  AND IsDelete = 0 AND Service_ID = '" + ddlService.SelectedValue + "' " + Qry + ")) ORDER BY Pro_Name";
        //if (Flag)
        //    Qry = "SELECT Pro_ID, Pro_Name FROM Pro_Reg WHERE (Comp_ID = '" + Reg.Comp_ID + "') AND (Doc_Flag = 1) AND (Sound_Flag = 1) AND (Pro_ID NOT IN (SELECT Pro_ID FROM M_Loyalty WHERE (Comp_ID = Pro_Reg.Comp_ID) AND IsDelete = 0)) ORDER BY Pro_Name";
        //else
        //    Qry = "SELECT Pro_ID, Pro_Name FROM Pro_Reg WHERE (Comp_ID = '" + Reg.Comp_ID + "') AND (Doc_Flag = 1) AND (Sound_Flag = 1) AND (Pro_ID NOT IN (SELECT Pro_ID FROM M_Loyalty WHERE  Pro_ID <> '" + lblproiddel.Text + "' AND (Comp_ID = Pro_Reg.Comp_ID)  AND IsDelete = 0)) ORDER BY Pro_Name";
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
                txtReferralLimit.Text = Convert.ToString(SQL_DB.ExecuteScalar("SELECT [Limit] from [ReferralLimit] where [M_SST_id] = " + ddt.Rows[0]["SST_Id"].ToString()));
            }
            catch (Exception)
            {

                // throw ex;
            }
            if (ddt.Rows[0]["Service_ID"].ToString() == "SRV1001" || ddt.Rows[0]["Service_ID"].ToString() == "SRV1024" || ddt.Rows[0]["Service_ID"].ToString() == "SRV1005")
            {
                seriestart.Visible = true;
                seriesend.Visible = true;
                serieslabel.Visible = true;
            }
            else
            {
                seriestart.Visible = false;
                seriesend.Visible = false;
                serieslabel.Visible = false;
            }
            SST_Id1 = ddt.Rows[0]["SST_Id"].ToString();
            selsrvid.Value = ddt.Rows[0]["Service_ID"].ToString();
            ddlService.SelectedValue = ddt.Rows[0]["Service_ID"].ToString();
            txtWarranty.Text = ddt.Rows[0]["WarrantyPeriod"].ToString();
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
                        rdAtDueDate.Checked = false;
                        rdInstant.Checked = true;
                        divinstant.Visible = true;
                        divduedate.Visible = false;
                        txttcodes.Text = string.Empty;
                        txteverynth.Text = string.Empty;
                        txteverywin.Text = string.Empty;
                        txttcodesrand.Text = string.Empty;

                        //txtalltonth.Text = string.Empty;
                        //txtrandfreq.Text = string.Empty;
                        //txtalltonCustomer.Text = string.Empty;
                        //txtallpFirstn.Text = string.Empty;
                        //txtallpFirstnton.Text = string.Empty;
                        #region Instant Logic
                        if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.FirstNCustomer.ToString())
                        {
                            rdFirstRandomnth.Checked = false; rdRandom.Checked = false; rdAllParticipant.Checked = false; rdFirstnth.Checked = true;
                            txttcodes.Text = rulesdt.Rows[0]["MasterCodes"].ToString();
                            txtnth.Text = rulesdt.Rows[0]["WinningCodes"].ToString();
                            lblRwdHeader.Text = "Gift count is equal to ";
                            lblRwdCounts.Text = txtnth.Text;
                            txttcodes.Enabled = true;
                            txtnth.Enabled = true;
                            txteverynth.Enabled = false;
                            txteverywin.Enabled = false;
                            txttcodesrand.Enabled = false;
                            txtrand.Enabled = false;
                        }
                        else if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.RandomNCustomernth.ToString())
                        {
                            rdFirstnth.Checked = false; rdRandom.Checked = false; rdAllParticipant.Checked = false; rdFirstRandomnth.Checked = true;
                            txteverynth.Text = rulesdt.Rows[0]["Frequency"].ToString();
                            txteverywin.Text = rulesdt.Rows[0]["WinningCodes"].ToString();
                            //txteverywin.Text = (Convert.ToInt64(txteverywin.Text) * Convert.ToInt64(txteverynth.Text)).ToString();
                            lblRwdHeader.Text = "Gift count is equal to ";
                            lblRwdCounts.Text = txteverywin.Text;//(Convert.ToInt64(txteverywin.Text) / Convert.ToInt64(txteverynth.Text)).ToString();
                            txttcodes.Enabled = false;
                            txtnth.Enabled = false;
                            txteverynth.Enabled = true;
                            txteverywin.Enabled = true;
                            txttcodesrand.Enabled = false;
                            txtrand.Enabled = false;
                        }
                        else if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.RandomNCustomer.ToString())
                        {
                            txteverynth.Text = string.Empty; txteverywin.Text = string.Empty;
                            rdFirstnth.Checked = false; rdFirstRandomnth.Checked = false; rdAllParticipant.Checked = false; rdRandom.Checked = true;
                            txttcodesrand.Text = rulesdt.Rows[0]["MasterCodes"].ToString();
                            txtrand.Text = rulesdt.Rows[0]["WinningCodes"].ToString();
                            lblRwdHeader.Text = "Gift count is equal to ";
                            lblRwdCounts.Text = txtrand.Text;
                            txttcodes.Enabled = false;
                            txtnth.Enabled = false;
                            txteverynth.Enabled = false;
                            txteverywin.Enabled = false;
                            txttcodesrand.Enabled = true;
                            txtrand.Enabled = true;
                        }
                        else if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.AllCustomer.ToString())
                        {
                            rdFirstnth.Checked = false; rdFirstRandomnth.Checked = false; rdRandom.Checked = false; rdAllParticipant.Checked = true;
                            txttcodes.Text = string.Empty;
                            txtnth.Text = string.Empty;
                            txteverynth.Text = string.Empty;
                            txteverywin.Text = string.Empty;
                            txttcodes.Text = string.Empty;
                            txttcodesrand.Text = string.Empty;
                            txtrand.Text = string.Empty;
                            lblRwdHeader.Text = string.Empty;
                            lblRwdCounts.Text = string.Empty;
                            txttcodes.Enabled = false;
                            txtnth.Enabled = false;
                            txteverynth.Enabled = false;
                            txteverywin.Enabled = false;
                            txttcodesrand.Enabled = false;
                            txtrand.Enabled = false;
                        }
                        #endregion
                    }
                    else
                    {
                        if (!string.IsNullOrEmpty(rulesdt.Rows[0]["duedate"].ToString()))
                            txtDueDate.Text = rulesdt.Rows[0]["duedate"].ToString();
                        rdInstant.Checked = false;
                        rdAtDueDate.Checked = true;
                        divinstant.Visible = false;
                        divduedate.Visible = true;
                        //rdAlltonthrand
                        txtalltonth.Text = string.Empty;
                        txtrandfreq.Text = string.Empty;
                        //rdAllton
                        txtalltonCustomer.Text = string.Empty;
                        //rdFirstnton
                        txtallpFirstn.Text = string.Empty;
                        txtallpFirstnton.Text = string.Empty;
                        //rdAlltoAll
                        #region Instant Logic  //rdFirstnton rdAlltonthrand rdAllton rdAlltoAll
                        if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.FirstNCustomertoNCustomer.ToString())
                        {
                            rdAllton.Checked = false; rdAlltoAll.Checked = false; rdAlltonthrand.Checked = false; rdFirstnton.Checked = true;
                            txtallpFirstn.Text = rulesdt.Rows[0]["MasterCodes"].ToString();
                            txtallpFirstnton.Text = rulesdt.Rows[0]["WinningCodes"].ToString();
                            lblRwdHeader.Text = "Gift count is equal to ";
                            lblRwdCounts.Text = txtnth.Text;
                            txtallpFirstn.Enabled = true;
                            txtallpFirstnton.Enabled = true;
                            txtalltonth.Enabled = false;
                            txtrandfreq.Enabled = false;
                            txtalltonCustomer.Enabled = false;
                        }
                        else if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.AllCusomertoRandomNCustomer.ToString())
                        {
                            rdAllton.Checked = false; rdAlltoAll.Checked = false; rdFirstnton.Checked = false; rdAlltonthrand.Checked = true;
                            txtrandfreq.Text = rulesdt.Rows[0]["Frequency"].ToString();
                            txtalltonth.Text = rulesdt.Rows[0]["WinningCodes"].ToString();
                            lblRwdHeader.Text = "Gift count is equal to ";
                            lblRwdCounts.Text = txtalltonth.Text;
                            txtallpFirstn.Enabled = false;
                            txtallpFirstnton.Enabled = false;
                            txtalltonth.Enabled = true;
                            txtrandfreq.Enabled = true;
                            txtalltonCustomer.Enabled = false;
                        }
                        else if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.AllCusomertoRandomNWinners.ToString())
                        {
                            rdAlltoAll.Checked = false; rdFirstnton.Checked = false; rdAlltonthrand.Checked = false; rdAllton.Checked = true;
                            txtalltonCustomer.Text = rulesdt.Rows[0]["MasterCodes"].ToString();
                            txtalltonCustomer.Text = rulesdt.Rows[0]["WinningCodes"].ToString();
                            lblRwdHeader.Text = "Gift count is equal to ";
                            lblRwdCounts.Text = txtalltonCustomer.Text;
                            txtallpFirstn.Enabled = false;
                            txtallpFirstnton.Enabled = false;
                            txtalltonth.Enabled = false;
                            txtrandfreq.Enabled = false;
                            txtalltonCustomer.Enabled = true;
                        }
                        else if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.AllCustomertoAllCustomer.ToString())
                        {
                            rdFirstnton.Checked = false; rdAlltonthrand.Checked = false; rdAllton.Checked = false; rdAlltoAll.Checked = true;
                            txtallpFirstn.Text = string.Empty;
                            txtallpFirstnton.Text = string.Empty;
                            txtalltonth.Text = string.Empty;
                            txtrandfreq.Text = string.Empty;
                            txtalltonCustomer.Text = string.Empty;
                            txtalltonCustomer.Text = string.Empty;
                            lblRwdHeader.Text = string.Empty;
                            lblRwdCounts.Text = string.Empty;
                            txtallpFirstn.Enabled = false;
                            txtallpFirstnton.Enabled = false;
                            txtalltonth.Enabled = false;
                            txtrandfreq.Enabled = false;
                            txtalltonCustomer.Enabled = false;
                        }
                        #endregion
                    }
                    if (rulesdt.Rows[0]["DistributionType"].ToString() == RwdDistrubutionRules.Random.ToString())
                    {
                        rdSequenceDistri.Checked = false;
                        rdRandomDistri.Checked = true;
                    }
                    else
                    {
                        rdRandomDistri.Checked = false;
                        rdSequenceDistri.Checked = true;
                    }
                    #endregion
                }
                #endregion

                #region Fill GridView & Dropdown
                FillGiftddl(ddlAddGift, selsrvid.Value);
                FillGiftDetails(GrdVwGift, 0);
                #endregion
            }
            #endregion
            #region
            RFVIsSoundH.ValidationGroup = "NN";
            RFVIsSoundE.ValidationGroup = "NN";
            bool check = GetUpdate(ddt.Rows[0]["Pro_ID"].ToString(), Convert.ToDateTime(ddt.Rows[0]["Entry_Date"]));
            currindex.Value = ddt.Rows[0]["SST_Id"].ToString();
            ddlProduct.SelectedValue = ddt.Rows[0]["Pro_ID"].ToString();
            if (Convert.ToInt32(ddt.Rows[0]["IsCashConvert"]) == 0)
                chkconvert.Checked = true;
            else
                chkconvert.Checked = false;
            hdnloyalty.Value = ddt.Rows[0]["Pro_ID"].ToString();
            txtloyaltypoints.Text = ddt.Rows[0]["Points"].ToString();
            txtcashamt.Text = ddt.Rows[0]["IsCash"].ToString();
            txtloyaltydtfrom.Text = ddt.Rows[0]["DateFrom"].ToString();
            txtloyaltydtto.Text = ddt.Rows[0]["DateTo"].ToString();
            txtCommentsTxt.Text = ddt.Rows[0]["Comments"].ToString();
            FileDownHindi.HRef = ddt.Rows[0]["SoundPath"].ToString();
            FileDownEnglish.HRef = ddt.Rows[0]["SoundPath1"].ToString();
            txtfrequency.Text = ddt.Rows[0]["Frequency"].ToString();
            if (ddt.Rows[0]["start_order"].ToString() != "")
            { 
                ddlseriesstart.Text = ddt.Rows[0]["start_order"].ToString() + "-" + ddt.Rows[0]["start_series"].ToString();
            ddlseriesend.Text = ddt.Rows[0]["end_order"].ToString() + "-" + ddt.Rows[0]["end_series"].ToString();
              
                    ddlamttype.Text = ddt.Rows[0]["amttype"].ToString();
                if (ddlamttype.Text.ToUpper() == "RANDOM")
                {
                    divshow();
                    txtrangeval.Text = ddt.Rows[0]["minval"].ToString() + "-" + ddt.Rows[0]["maxval"].ToString();
                    txttotalamount.Text = ddt.Rows[0]["totalamount"].ToString();
                }
                //  loya.Text = ddt.Rows[0]["AmtType"].ToString();

            }
            hdnpointsval.Value = txtloyaltypoints.Text;
            ChangeUpdateFields(check);
            ChnageValidation(false);
            #region code for referral
            Int32 IsReferral = Convert.ToInt32(ddt.Rows[0]["IsReferral"]);
            if (IsReferral > 0)
            {
                DataTable Refdt = SQL_DB.ExecuteDataTable("select PointsReferral, PointsUsers, IsCashReferral, IsCashUsers, IsCashConvert, GiftReferral, GiftUsers, Frequency from T_CouponsTrans WHERE SST_Id = " + Convert.ToInt64(ddt.Rows[0]["SST_Id"]) + " ");
                if (Refdt.Rows.Count > 0)
                {
                    rdInstant.Checked = false;
                    rdAtDueDate.Checked = false;
                    if (IsReferral == 1)
                    {
                        divpoinscash.Visible = true;
                        divrefGift.Visible = false;
                        rdIsRefPoints.Checked = false;
                        rdIsRefGift.Checked = false;
                        rdIsRefCash.Checked = true;
                        txtreffrom.Text = Refdt.Rows[0]["IsCashReferral"].ToString();
                        txtrefto.Text = Refdt.Rows[0]["IsCashUsers"].ToString();
                        chkRefIsCash.Visible = false;
                    }
                    else if (IsReferral == 2)
                    {
                        divpoinscash.Visible = true;
                        divrefGift.Visible = false;
                        chkRefIsCash.Visible = true;
                        rdIsRefGift.Checked = false;
                        rdIsRefCash.Checked = false;
                        rdIsRefPoints.Checked = true;
                        txtreffrom.Text = Refdt.Rows[0]["PointsReferral"].ToString();
                        txtrefto.Text = Refdt.Rows[0]["PointsUsers"].ToString();
                    }
                    else if (IsReferral == 3)
                    {
                        divpoinscash.Visible = false;
                        divrefGift.Visible = true;
                        rdIsRefPoints.Checked = false;
                        rdIsRefCash.Checked = false;
                        rdIsRefGift.Checked = true;
                        FillGiftddl(ddlrefGiftFrom, selsrvid.Value);
                        FillGiftddl(ddlrefGiftTo, selsrvid.Value);
                        ddlrefGiftFrom.SelectedValue = Refdt.Rows[0]["GiftReferral"].ToString();
                        ddlrefGiftTo.SelectedValue = Refdt.Rows[0]["GiftUsers"].ToString();
                        chkRefIsCash.Visible = false;
                    }
                    if (Convert.ToInt32(Refdt.Rows[0]["IsCashConvert"]) == 0)
                        chkRefIsCash.Checked = true;
                    else
                        chkRefIsCash.Checked = false;
                }
            }
            #endregion
            btnSave.Text = "Update";
            // Lblloyaltyhead.Text = "Update Loyalty";
            #endregion
        }
        else
        {
            ChnageValidation(true);
            btnSave.Text = "Save";
            //   Lblloyaltyhead.Text = "Add Loyalty";
        }
        CheckGiftCouponServiceStarted(Convert.ToInt32(SST_Id1), selsrvid.Value);
      //  ModalPopupLoyalty.Show();
        #endregion
        //Loyalty_Programm obj = new Loyalty_Programm();
        //obj.Comp_ID = Session["CompanyId"].ToString();
        //obj.Pro_Name = txtProductName.Text.Trim().Replace("'", "''");
        //if (ddlsearchSrervice.SelectedIndex > 0)
        //    obj.Service_ID = " AND REG.Service_ID = '" + ddlsearchSrervice.SelectedValue + "' ";
        //if (ddlsearchPro.SelectedIndex > 0)
        //    obj.Pro_ID = " AND REG.Pro_ID = '" + ddlsearchPro.SelectedValue + "' ";
        //DataSet ds = Loyalty_Programm.FillGrvWData(obj);
        //if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        //{
        //    if (ds.Tables[0].Rows.Count > 0)
        //        GrdProductMaster.PageSize = ds.Tables[0].Rows.Count;
        //}
        //else
        //    GrdProductMaster.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        //if (ds.Tables[0].Rows.Count > 0)
        //    GrdProductMaster.DataSource = ds.Tables[0];
        //GrdProductMaster.DataBind();
        //lblcount.Text = GrdProductMaster.Rows.Count.ToString();

        //if (GrdProductMaster.Rows.Count > 0)
        //    GrdProductMaster.HeaderRow.TableSection = TableRowSection.TableHeader;

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
                    //btnNoAlert.Visible = false;
                    //LabelAlertHead.Text = "Alert";
                    //lblalert.Text = " Are you sure to <span style='color:blue;'>" + FindStatus(Convert.ToInt32(ds.Tables[0].Rows[0]["IsActive"])) + "</span> the Brand Loyalty Settings of <span style='color:blue;'>" + ds.Tables[0].Rows[0]["Pro_Name"].ToString() + "</span> product ?";
                    //ModalPopupExtenderAlert.Show();


                    //Loyalty_Programm Reg = new Loyalty_Programm();
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
                        txtReferralLimit.Text = Convert.ToString(SQL_DB.ExecuteScalar("SELECT [Limit] from [ReferralLimit] where [M_SST_id] = " + ddt.Rows[0]["SST_Id"].ToString()));
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
                            #region
                            if (rulesdt.Rows[0]["ServiceType"].ToString() == ServiceTypes.Instant.ToString())
                            {
                                rdAtDueDate.Checked = false;
                                rdInstant.Checked = true;
                                //divinstant.Visible = true;
                                //divduedate.Visible = false;
                                Instant(true);
                                Duedate(false);
                                txttcodes.Text = string.Empty;
                                txteverynth.Text = string.Empty;
                                txteverywin.Text = string.Empty;
                                txttcodesrand.Text = string.Empty;

                                //txtalltonth.Text = string.Empty;
                                //txtrandfreq.Text = string.Empty;
                                //txtalltonCustomer.Text = string.Empty;
                                //txtallpFirstn.Text = string.Empty;
                                //txtallpFirstnton.Text = string.Empty;
                                #region Instant Logic
                                if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.FirstNCustomer.ToString())
                                {
                                    rdFirstRandomnth.Checked = false; rdRandom.Checked = false; rdAllParticipant.Checked = false; rdFirstnth.Checked = true;
                                    txttcodes.Text = rulesdt.Rows[0]["MasterCodes"].ToString();
                                    txtnth.Text = rulesdt.Rows[0]["WinningCodes"].ToString();
                                    lblRwdHeader.Text = "Gift count is equal to ";
                                    lblRwdCounts.Text = txtnth.Text;
                                    txttcodes.Enabled = true;
                                    txtnth.Enabled = true;
                                    txteverynth.Enabled = false;
                                    txteverywin.Enabled = false;
                                    txttcodesrand.Enabled = false;
                                    txtrand.Enabled = false;
                                }
                                else if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.RandomNCustomernth.ToString())
                                {
                                    rdFirstnth.Checked = false; rdRandom.Checked = false; rdAllParticipant.Checked = false; rdFirstRandomnth.Checked = true;
                                    txteverynth.Text = rulesdt.Rows[0]["Frequency"].ToString();
                                    txteverywin.Text = rulesdt.Rows[0]["WinningCodes"].ToString();
                                    //txteverywin.Text = (Convert.ToInt64(txteverywin.Text) * Convert.ToInt64(txteverynth.Text)).ToString();
                                    lblRwdHeader.Text = "Gift count is equal to ";
                                    lblRwdCounts.Text = txteverywin.Text;//(Convert.ToInt64(txteverywin.Text) / Convert.ToInt64(txteverynth.Text)).ToString();
                                    txttcodes.Enabled = false;
                                    txtnth.Enabled = false;
                                    txteverynth.Enabled = true;
                                    txteverywin.Enabled = true;
                                    txttcodesrand.Enabled = false;
                                    txtrand.Enabled = false;
                                }
                                else if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.RandomNCustomer.ToString())
                                {
                                    txteverynth.Text = string.Empty; txteverywin.Text = string.Empty;
                                    rdFirstnth.Checked = false; rdFirstRandomnth.Checked = false; rdAllParticipant.Checked = false; rdRandom.Checked = true;
                                    txttcodesrand.Text = rulesdt.Rows[0]["MasterCodes"].ToString();
                                    txtrand.Text = rulesdt.Rows[0]["WinningCodes"].ToString();
                                    lblRwdHeader.Text = "Gift count is equal to ";
                                    lblRwdCounts.Text = txtrand.Text;
                                    txttcodes.Enabled = false;
                                    txtnth.Enabled = false;
                                    txteverynth.Enabled = false;
                                    txteverywin.Enabled = false;
                                    txttcodesrand.Enabled = true;
                                    txtrand.Enabled = true;
                                }
                                else if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.AllCustomer.ToString())
                                {
                                    rdFirstnth.Checked = false; rdFirstRandomnth.Checked = false; rdRandom.Checked = false; rdAllParticipant.Checked = true;
                                    txttcodes.Text = string.Empty;
                                    txtnth.Text = string.Empty;
                                    txteverynth.Text = string.Empty;
                                    txteverywin.Text = string.Empty;
                                    txttcodes.Text = string.Empty;
                                    txttcodesrand.Text = string.Empty;
                                    txtrand.Text = string.Empty;
                                    lblRwdHeader.Text = string.Empty;
                                    lblRwdCounts.Text = string.Empty;
                                    txttcodes.Enabled = false;
                                    txtnth.Enabled = false;
                                    txteverynth.Enabled = false;
                                    txteverywin.Enabled = false;
                                    txttcodesrand.Enabled = false;
                                    txtrand.Enabled = false;
                                }
                                #endregion
                            }
                            else
                            {
                                if (!string.IsNullOrEmpty(rulesdt.Rows[0]["duedate"].ToString()))
                                    txtDueDate.Text = rulesdt.Rows[0]["duedate"].ToString();
                                rdInstant.Checked = false;
                                rdAtDueDate.Checked = true;
                               // divinstant.Visible = false;
                                //divduedate.Visible = true;
                                Instant(false);
                                Duedate(true);
                                //rdAlltonthrand
                                txtalltonth.Text = string.Empty;
                                txtrandfreq.Text = string.Empty;
                                //rdAllton
                                txtalltonCustomer.Text = string.Empty;
                                //rdFirstnton
                                txtallpFirstn.Text = string.Empty;
                                txtallpFirstnton.Text = string.Empty;
                                //rdAlltoAll
                                #region Instant Logic  //rdFirstnton rdAlltonthrand rdAllton rdAlltoAll
                                if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.FirstNCustomertoNCustomer.ToString())
                                {
                                    rdAllton.Checked = false; rdAlltoAll.Checked = false; rdAlltonthrand.Checked = false; rdFirstnton.Checked = true;
                                    txtallpFirstn.Text = rulesdt.Rows[0]["MasterCodes"].ToString();
                                    txtallpFirstnton.Text = rulesdt.Rows[0]["WinningCodes"].ToString();
                                    lblRwdHeader.Text = "Gift count is equal to ";
                                    lblRwdCounts.Text = txtnth.Text;
                                    txtallpFirstn.Enabled = true;
                                    txtallpFirstnton.Enabled = true;
                                    txtalltonth.Enabled = false;
                                    txtrandfreq.Enabled = false;
                                    txtalltonCustomer.Enabled = false;
                                }
                                else if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.AllCusomertoRandomNCustomer.ToString())
                                {
                                    rdAllton.Checked = false; rdAlltoAll.Checked = false; rdFirstnton.Checked = false; rdAlltonthrand.Checked = true;
                                    txtrandfreq.Text = rulesdt.Rows[0]["Frequency"].ToString();
                                    txtalltonth.Text = rulesdt.Rows[0]["WinningCodes"].ToString();
                                    lblRwdHeader.Text = "Gift count is equal to ";
                                    lblRwdCounts.Text = txtalltonth.Text;
                                    txtallpFirstn.Enabled = false;
                                    txtallpFirstnton.Enabled = false;
                                    txtalltonth.Enabled = true;
                                    txtrandfreq.Enabled = true;
                                    txtalltonCustomer.Enabled = false;
                                }
                                else if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.AllCusomertoRandomNWinners.ToString())
                                {
                                    rdAlltoAll.Checked = false; rdFirstnton.Checked = false; rdAlltonthrand.Checked = false; rdAllton.Checked = true;
                                    txtalltonCustomer.Text = rulesdt.Rows[0]["MasterCodes"].ToString();
                                    txtalltonCustomer.Text = rulesdt.Rows[0]["WinningCodes"].ToString();
                                    lblRwdHeader.Text = "Gift count is equal to ";
                                    lblRwdCounts.Text = txtalltonCustomer.Text;
                                    txtallpFirstn.Enabled = false;
                                    txtallpFirstnton.Enabled = false;
                                    txtalltonth.Enabled = false;
                                    txtrandfreq.Enabled = false;
                                    txtalltonCustomer.Enabled = true;
                                }
                                else if (rulesdt.Rows[0]["Rules"].ToString() == ServiceRules.AllCustomertoAllCustomer.ToString())
                                {
                                    rdFirstnton.Checked = false; rdAlltonthrand.Checked = false; rdAllton.Checked = false; rdAlltoAll.Checked = true;
                                    txtallpFirstn.Text = string.Empty;
                                    txtallpFirstnton.Text = string.Empty;
                                    txtalltonth.Text = string.Empty;
                                    txtrandfreq.Text = string.Empty;
                                    txtalltonCustomer.Text = string.Empty;
                                    txtalltonCustomer.Text = string.Empty;
                                    lblRwdHeader.Text = string.Empty;
                                    lblRwdCounts.Text = string.Empty;
                                    txtallpFirstn.Enabled = false;
                                    txtallpFirstnton.Enabled = false;
                                    txtalltonth.Enabled = false;
                                    txtrandfreq.Enabled = false;
                                    txtalltonCustomer.Enabled = false;
                                }
                                #endregion
                            }
                            if (rulesdt.Rows[0]["DistributionType"].ToString() == RwdDistrubutionRules.Random.ToString())
                            {
                                rdSequenceDistri.Checked = false;
                                rdRandomDistri.Checked = true;
                            }
                            else
                            {
                                rdRandomDistri.Checked = false;
                                rdSequenceDistri.Checked = true;
                            }
                            #endregion
                        }
                        #endregion

                        #region Fill GridView & Dropdown
                        FillGiftddl(ddlAddGift, ddlService.SelectedValue);
                        FillGiftDetails(GrdVwGift, 0);
                        #endregion
                    }
                    #endregion
                    #region
                    RFVIsSoundH.ValidationGroup = "NN";
                    RFVIsSoundE.ValidationGroup = "NN";
                    bool check = GetUpdate(ddt.Rows[0]["Pro_ID"].ToString(), Convert.ToDateTime(ddt.Rows[0]["Entry_Date"]));
                    currindex.Value = ddt.Rows[0]["SST_Id"].ToString();
                    ddlProduct.SelectedValue = ddt.Rows[0]["Pro_ID"].ToString();
                    if (Convert.ToInt32(ddt.Rows[0]["IsCashConvert"]) == 0)
                        chkconvert.Checked = true;
                    else
                        chkconvert.Checked = false;
                    hdnloyalty.Value = ddt.Rows[0]["Pro_ID"].ToString();
                    txtloyaltypoints.Text = ddt.Rows[0]["Points"].ToString();
                    txtcashamt.Text = ddt.Rows[0]["IsCash"].ToString();
                    txtloyaltydtfrom.Text = ddt.Rows[0]["DateFrom"].ToString();
                    txtloyaltydtto.Text = ddt.Rows[0]["DateTo"].ToString();
                    txtCommentsTxt.Text = ddt.Rows[0]["Comments"].ToString();
                    FileDownHindi.HRef = ddt.Rows[0]["SoundPath"].ToString();
                    FileDownEnglish.HRef = ddt.Rows[0]["SoundPath1"].ToString();
                    txtfrequency.Text = ddt.Rows[0]["Frequency"].ToString();
                    hdnpointsval.Value = txtloyaltypoints.Text;
                    ChangeUpdateFields(check);
                    ChnageValidation(false);
                    #region code for referral
                    Int32 IsReferral = Convert.ToInt32(ddt.Rows[0]["IsReferral"]);
                    if (IsReferral > 0)
                    {
                        DataTable Refdt = SQL_DB.ExecuteDataTable("select PointsReferral, PointsUsers, IsCashReferral, IsCashUsers, IsCashConvert, GiftReferral, GiftUsers, Frequency from T_CouponsTrans WHERE SST_Id = " + Convert.ToInt64(ddt.Rows[0]["SST_Id"]) + " ");
                        if (Refdt.Rows.Count > 0)
                        {
                            rdInstant.Checked = false;
                            rdAtDueDate.Checked = false;
                            if (IsReferral == 1)
                            {
                                divpoinscash.Visible = true;
                                divrefGift.Visible = false;
                                rdIsRefPoints.Checked = false;
                                rdIsRefGift.Checked = false;
                                rdIsRefCash.Checked = true;
                                txtreffrom.Text = Refdt.Rows[0]["IsCashReferral"].ToString();
                                txtrefto.Text = Refdt.Rows[0]["IsCashUsers"].ToString();
                                chkRefIsCash.Visible = false;
                            }
                            else if (IsReferral == 2)
                            {
                                divpoinscash.Visible = true;
                                divrefGift.Visible = false;
                                chkRefIsCash.Visible = true;
                                rdIsRefGift.Checked = false;
                                rdIsRefCash.Checked = false;
                                rdIsRefPoints.Checked = true;
                                txtreffrom.Text = Refdt.Rows[0]["PointsReferral"].ToString();
                                txtrefto.Text = Refdt.Rows[0]["PointsUsers"].ToString();
                            }
                            else if (IsReferral == 3)
                            {
                                divpoinscash.Visible = false;
                                divrefGift.Visible = true;
                                rdIsRefPoints.Checked = false;
                                rdIsRefCash.Checked = false;
                                rdIsRefGift.Checked = true;
                                FillGiftddl(ddlrefGiftFrom, ddlService.SelectedValue);
                                FillGiftddl(ddlrefGiftTo, ddlService.SelectedValue);
                                ddlrefGiftFrom.SelectedValue = Refdt.Rows[0]["GiftReferral"].ToString();
                                ddlrefGiftTo.SelectedValue = Refdt.Rows[0]["GiftUsers"].ToString();
                                chkRefIsCash.Visible = false;
                            }
                            if (Convert.ToInt32(Refdt.Rows[0]["IsCashConvert"]) == 0)
                                chkRefIsCash.Checked = true;
                            else
                                chkRefIsCash.Checked = false;
                        }
                    }
                    #endregion
                    btnSave.Text = "Update";
                    // Lblloyaltyhead.Text = "Update Loyalty";
                    #endregion
                }
                else
                {
                    ChnageValidation(true);
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
    protected void CheckforUpdate(object sender, EventArgs e)
    {
        Int64 OldPoints = Convert.ToInt64(hdnpointsval.Value);
        Int64 NewPoints = Convert.ToInt64(txtloyaltypoints.Text);
        if (OldPoints <= NewPoints)
        {
            txtloyaltypoints.Text = NewPoints.ToString();
            DivMsg.Visible = false;
        }
        else
        {
            LblMsgBody.Text = "Points not update is less than old points " + OldPoints;
            DivMsg.Visible = true;
            DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
            string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            txtloyaltypoints.Text = OldPoints.ToString();
        }
       // ModalPopupLoyalty.Show();
    }
    private void ChangeUpdateFields(bool check)
    {

    }
    private bool GetUpdate(string Pro_ID, DateTime DateTime)
    {
        DataTable dt = SQL_DB.ExecuteDataSet("SELECT  RowId, Comp_ID, Pro_ID, User_ID, Code1, Code2, Points, Type, Entry_Date, Mode, IsCashConvert, IsUse FROM  T_Points WHERE Pro_ID='" + Pro_ID + "' AND CONVERT(VARCHAR,Entry_Date,111) >= '" + Convert.ToDateTime(DateTime).ToString("yyyy/MM/dd") + "' ").Tables[0];
        if (dt.Rows.Count > 0)
            return false;
        else
            return true;
    }
    private void ChnageValidation(bool Flag)
    {
        if (Flag)
        {
            FileDownHindi.Visible = false; FileDownEnglish.Visible = false;
            RFVIsSoundH.ValidationGroup = "LOY";
            RFVIsSoundE.ValidationGroup = "LOY";
        }
        else
        {
            FileDownHindi.Visible = true; FileDownEnglish.Visible = true;
            RFVIsSoundH.ValidationGroup = "NA";
            RFVIsSoundE.ValidationGroup = "NA";
        }
    }
    protected void GrdProductMaster_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        NewMsgpop.Visible = false;
      //  GrdProductMaster.PageIndex = e.NewPageIndex;
        filldata();
    }

    #region For Instant
    protected void GetWinners_TextChanged(object sender, EventArgs e)
    {
        lblRwdHeader.Text = "Gift Count is equal to ";
        txtnth.Text = txttcodes.Text;
        lblRwdCounts.Text = txtnth.Text;
      //  ModalPopupLoyalty.Show();
    }
    protected void GetWinners1_TextChanged(object sender, EventArgs e)
    {
        if ((txteverywin.Text != "") && (txteverynth.Text != ""))
        {
            lblRwdHeader.Text = "Gift Count is equal to ";
            lblRwdCounts.Text = txteverywin.Text;//Convert.ToInt32(Convert.ToInt64(txteverywin.Text) / Convert.ToInt64(txteverynth.Text)).ToString();
        }
        else
        {
            lblRwdHeader.Text = string.Empty; lblRwdCounts.Text = string.Empty;
        }
       // ModalPopupLoyalty.Show();
    }
    protected void GetWinners2_TextChanged(object sender, EventArgs e)
    {
        #region Logic For Product Details
        string str = GetProductDetils();
        string[] Arr = str.ToString().Split('*');
        if (Arr.Length > 1)
        {
            if (Arr[0].ToString().Trim() == "false")
            {
                txtrand.Text = string.Empty;
                LblMsgBody.Text = Arr[1].ToString();
                DivMsg.Visible = true;
                DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
           //     ModalPopupLoyalty.Show();
                return;
            }
            else
            {
                lblRwdHeader.Text = "Gift Count is equal to ";
                txtrand.Text = txttcodesrand.Text;
                lblRwdCounts.Text = txtrand.Text;
                if (Convert.ToInt64(lblProDetCount.Text) > 0)
                {
                    if (Convert.ToInt64(lblProDetCount.Text) < Convert.ToInt64(txtrand.Text))
                    {

                        txtrand.Text = string.Empty;
                        LblMsgBody.Text = "Total Random Participants is less or equal to " + lblProDetCount.Text;
                        DivMsg.Visible = true;
                        DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                        string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
                    }
                }
                else
                    DivMsg.Visible = false;
            //    ModalPopupLoyalty.Show();
                return;
            }
        }
        #endregion
    }
    #endregion

    #region For At Due Date
    protected void GetWinner_TextChanged(object sender, EventArgs e)
    {
        lblRwdHeader.Text = "Gift Count is equal to ";
        lblRwdCounts.Text = txtalltonth.Text;
       // ModalPopupLoyalty.Show();
    }
    protected void GetWinner1_TextChanged(object sender, EventArgs e)
    {
        lblRwdHeader.Text = "Gift Count is equal to ";
        lblRwdCounts.Text = txtalltonCustomer.Text;
      ///  ModalPopupLoyalty.Show();
    }
    protected void GetWinner2_TextChanged(object sender, EventArgs e)
    {
        lblRwdHeader.Text = "Gift Count is equal to ";
        lblRwdCounts.Text = txtallpFirstnton.Text;
      //  ModalPopupLoyalty.Show();
    }
    #endregion

    #region Get Total Filled Product Details
    private string GetProductDetils()
    {
        if (ddlProduct.SelectedIndex > 0)
        {
            Object9420 Reg = new Object9420();
            Reg.Pro_ID = ddlProduct.SelectedValue.Trim();
            if (lblProDetCount.Text.Trim() == "")
            {
                Int64 DetailsCount = 0;
                LBL:
                try
                {
                    DetailsCount = Convert.ToInt64(Rewards_DataTire.GetFilledDetailsCount(Reg));
                }
                catch (Exception Ex)
                {
                    goto LBL;
                }
                lblProDetCount.Text = DetailsCount.ToString();
            }
            return "true*" + lblProDetCount.Text;
        }
        else
        {
            txttcodesrand.Text = string.Empty; txtrand.Text = string.Empty;
            return "false*Please select Product.";
        }

    }
    #endregion
    protected void ChkInfinite_CheckedChanged(object sender, EventArgs e)
    {
        if (ChkInfinite.Checked)
        {
            txtGiftQty.Enabled = false;
            txtGiftQty.Text = "0";
        }
        else
        {
            txtGiftQty.Enabled = true;
            txtGiftQty.Text = string.Empty;
        }
      //  ModalPopupLoyalty.Show();
    }
    protected void rdAllParticipant_CheckedChanged(object sender, EventArgs e)
    {
        txtnth.Text = string.Empty; txttcodes.Text = string.Empty; txttcodesrand.Text = string.Empty; txtrand.Text = string.Empty; txteverynth.Text = string.Empty; txteverywin.Text = string.Empty;
        if (rdFirstnth.Checked)
        {
            reqnth.ValidationGroup = "SRVS"; reqtcodes.ValidationGroup = "SRVS"; reqtcodesrand.ValidationGroup = "NN"; reqrand.ValidationGroup = "NN"; txteverynth.ValidationGroup = "NN"; txteverywin.ValidationGroup = "NN";
            txtnth.Enabled = true; txttcodes.Enabled = true; txttcodesrand.Enabled = false; txtrand.Enabled = false; txteverynth.Enabled = false; txteverywin.Enabled = false;
            ChkInfinite.Enabled = false;
        }
        if (rdRandom.Checked)
        {//reqrand.ValidationGroup = "SRVS";
            reqnth.ValidationGroup = "NN"; txttcodes.ValidationGroup = "NN"; reqtcodesrand.ValidationGroup = "SRVS"; txteverynth.ValidationGroup = "NN"; txteverywin.ValidationGroup = "NN";
            txtnth.Enabled = false; txttcodes.Enabled = false; txttcodesrand.Enabled = true; txtrand.Enabled = true; txteverynth.Enabled = false; txteverywin.Enabled = false;
            ChkInfinite.Enabled = false;
        }
        else if (rdAllParticipant.Checked)
        {
            lblRwdHeader.Text = string.Empty; lblRwdCounts.Text = string.Empty;
            reqnth.ValidationGroup = "NN"; txttcodes.ValidationGroup = "NN"; reqtcodesrand.ValidationGroup = "NN"; reqrand.ValidationGroup = "NN"; txteverynth.ValidationGroup = "NN"; txteverywin.ValidationGroup = "NN";
            txtnth.Enabled = false; txttcodes.Enabled = false; txttcodesrand.Enabled = false; txtrand.Enabled = false; txteverynth.Enabled = false; txteverywin.Enabled = false;
            ChkInfinite.Enabled = true;
        }
        else if (rdFirstRandomnth.Checked)
        {
            reqnth.ValidationGroup = "NN"; txttcodes.ValidationGroup = "NN"; reqtcodesrand.ValidationGroup = "NN"; reqrand.ValidationGroup = "NN"; txteverynth.ValidationGroup = "SRVS"; txteverywin.ValidationGroup = "SRVS";
            txtnth.Enabled = false; txttcodes.Enabled = false; txttcodesrand.Enabled = false; txtrand.Enabled = false; txteverynth.Enabled = true; txteverywin.Enabled = true;
            ChkInfinite.Enabled = false;
        }
        DivMsg.Visible = false;
        Obj = new List<Gifts>();
        FillGiftDetails(GrdVwGift, 1);
      //  ModalPopupLoyalty.Show();
    }
    protected void rdAlltoAll_CheckedChanged(object sender, EventArgs e)
    {
        txtallpFirstn.Text = string.Empty; txtallpFirstnton.Text = string.Empty; txtalltonth.Text = string.Empty; txtrandfreq.Text = string.Empty; txtalltonCustomer.Text = string.Empty;
        if (rdFirstnton.Checked)
        {
            reqallpFirstn.ValidationGroup = "SRVS"; reqallpFirstnton.ValidationGroup = "SRVS"; reqalltonth.ValidationGroup = "NN"; reqrandfreq.ValidationGroup = "NN"; reqalltonCustomer.ValidationGroup = "NN";
            txtallpFirstn.Enabled = true; txtallpFirstnton.Enabled = true; txtalltonth.Enabled = false; txtrandfreq.Enabled = false; txtalltonCustomer.Enabled = false;
            ChkInfinite.Enabled = false;
        }
        else if (rdAlltonthrand.Checked)
        {
            reqallpFirstn.ValidationGroup = "NN"; reqallpFirstnton.ValidationGroup = "NN"; reqalltonth.ValidationGroup = "SRVS"; reqrandfreq.ValidationGroup = "SRVS"; reqalltonCustomer.ValidationGroup = "NN";
            txtallpFirstn.Enabled = false; txtallpFirstnton.Enabled = false; txtalltonth.Enabled = true; txtrandfreq.Enabled = true; txtalltonCustomer.Enabled = false;
            ChkInfinite.Enabled = false;
        }
        else if (rdAllton.Checked)
        {
            reqallpFirstn.ValidationGroup = "NN"; reqallpFirstnton.ValidationGroup = "NN"; reqalltonth.ValidationGroup = "NN"; reqrandfreq.ValidationGroup = "NN"; reqalltonCustomer.ValidationGroup = "SRVS";
            txtallpFirstn.Enabled = false; txtallpFirstnton.Enabled = false; txtalltonth.Enabled = false; txtrandfreq.Enabled = false; txtalltonCustomer.Enabled = true;
            ChkInfinite.Enabled = false;
        }
        else if (rdAlltoAll.Checked)
        {
            reqallpFirstn.ValidationGroup = "NN"; reqallpFirstnton.ValidationGroup = "NN"; reqalltonth.ValidationGroup = "NN"; reqrandfreq.ValidationGroup = "NN"; reqalltonCustomer.ValidationGroup = "NN";
            txtallpFirstn.Enabled = false; txtallpFirstnton.Enabled = false; txtalltonth.Enabled = false; txtrandfreq.Enabled = false; txtalltonCustomer.Enabled = false;
            ChkInfinite.Enabled = true;
        }
        DivMsg.Visible = false;
        Obj = new List<Gifts>();
        FillGiftDetails(GrdVwGift, 1);
      //  ModalPopupLoyalty.Show();
    }
    protected void rdRandomDistri_CheckedChanged(object sender, EventArgs e)
    {
        List<Gifts> nList = new List<Gifts>();
        int Counter = 0;//indexes = -1;
        if (Obj.Count > 1)
        {
            if (rdSequenceDistri.Checked)
            {
                foreach (var item in Obj)
                {
                    if (item.GiftCount != 0)
                        nList.Add(new Gifts { Gift_ID = item.Gift_ID, GiftCount = item.GiftCount, AdditionalGift_ID = item.AdditionalGift_ID, DistributeGiftCount = item.DistributeGiftCount, GiftName = item.GiftName, IsCoupon = item.IsCoupon, SpendTotalCount = item.SpendTotalCount });
                    if (item.GiftCount == 0)
                    {
                        if (Counter == 0)
                            nList.Add(new Gifts { Gift_ID = item.Gift_ID, GiftCount = item.GiftCount, AdditionalGift_ID = item.AdditionalGift_ID, DistributeGiftCount = item.DistributeGiftCount, GiftName = item.GiftName, IsCoupon = item.IsCoupon, SpendTotalCount = item.SpendTotalCount });
                        Counter++;
                    }
                }
                if (nList.Count > 0)
                {
                    Obj = nList;
                    FillGiftDetails(GrdVwGift, 1);
                }
            }
        }
       // ModalPopupLoyalty.Show();
    }
    protected void rdInstant_CheckedChanged(object sender, EventArgs e)
    {
        if (rdInstant.Checked)
        {
            txtnth.Text = string.Empty; txttcodes.Text = string.Empty; txttcodesrand.Text = string.Empty; txtrand.Text = string.Empty; txteverynth.Text = string.Empty; txteverywin.Text = string.Empty;
            txtnth.Enabled = true; txttcodes.Enabled = true; txttcodesrand.Enabled = false; txtrand.Enabled = false; txteverynth.Enabled = false; txteverywin.Enabled = false;
            rdRandom.Checked = false;
            rdAllParticipant.Checked = false;
            rdFirstRandomnth.Checked = false;
            rdFirstnth.Checked = true;
           // divinstant.Visible = true;
           // divduedate.Visible = false;
            Instant(true);
            Duedate(false);
        }
        else
        {
            txtallpFirstn.Text = string.Empty; txtallpFirstnton.Text = string.Empty; txtalltonth.Text = string.Empty; txtrandfreq.Text = string.Empty; txtalltonCustomer.Text = string.Empty;
            txtallpFirstn.Enabled = false; txtallpFirstnton.Enabled = false; txtalltonth.Enabled = true; txtrandfreq.Enabled = true; txtalltonCustomer.Enabled = false;
            rdAllton.Checked = false;
            rdAlltoAll.Checked = false;
            rdFirstnton.Checked = false;
            rdAlltonthrand.Checked = true;
           // divinstant.Visible = false;
           // divduedate.Visible = true;
            Instant(false);
            Duedate(true);
        }
       // ModalPopupLoyalty.Show();
    }

    protected void btnGSave_Click(object sender, EventArgs e)
    {
        try
        {


            #region Check For Gift Coupons
            string[] ArrNew = ddlAddGift.SelectedValue.Trim().ToString().Split('*');
            if (ArrNew.Length > 1)
            {
                if (Convert.ToInt32(ArrNew[2]) == 0)
                {
                    if (Convert.ToInt32(ArrNew[1]) < Convert.ToInt32(txtGiftQty.Text))
                    {
                        //LblMsgBody.Text = "Please enter No. of prize quantity is less than Total Quantity.";
                        LblMsgBody.Text = "Total quantity cannot be more than Available quantity of gift.";
                        DivMsg.Visible = true;
                        DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                        string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                //        ModalPopupLoyalty.Show();
                        return;
                    }
                }
            }

            #endregion
            Int64 p = 0; Int64 MQty = 0, TQty = 0, Frequency = 1; bool Chk = false; string Msg = "";
            if (rdInstant.Checked)
            {
                #region Instant Logic
                if (!rdAllParticipant.Checked)
                {
                    if (rdFirstnth.Checked)
                    {
                        if (txttcodes.Text == "")
                        {
                            LblMsgBody.Text = "Please enter No. of First 'n' Participants.";
                            DivMsg.Visible = true;
                            DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                            string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                    //        ModalPopupLoyalty.Show();
                            return;
                        }
                        else if (txtnth.Text == "")
                        {
                            LblMsgBody.Text = "Please enter No. of Random Winners.";
                            DivMsg.Visible = true;
                            DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                            string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                    //        ModalPopupLoyalty.Show();
                            return;
                        }
                        MQty = Convert.ToInt64(txttcodes.Text);
                        TQty = Convert.ToInt64(txtnth.Text);
                        Chk = true;
                    }
                    else if (rdFirstRandomnth.Checked)
                    {
                        #region Logic for check
                        if (txteverynth.Text == "")
                        {
                            LblMsgBody.Text = "Please enter Every n<sup>th</sup> participants.";
                            DivMsg.Visible = true;
                            DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                            string script2 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script2, true);
                    //        ModalPopupLoyalty.Show();
                            return;
                        }
                        if (txteverywin.Text == "")
                        {
                            LblMsgBody.Text = "Please enter No. of winners.";
                            DivMsg.Visible = true;
                            DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                            string script2 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script2, true);
                      //      ModalPopupLoyalty.Show();
                            return;
                        }
                        MQty = Convert.ToInt64(txteverywin.Text);//Convert.ToInt64(txteverywin.Text) / Convert.ToInt64(txteverynth.Text);
                        TQty = Convert.ToInt64(MQty);
                        #endregion
                        Chk = true;
                    }
                    else if (rdRandom.Checked)
                    {
                        if (txttcodesrand.Text == "")
                        {
                            LblMsgBody.Text = "Please enter No. of Random Participants.";
                            DivMsg.Visible = true;
                            DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                            string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                      //      ModalPopupLoyalty.Show();
                            return;
                        }
                        // this "else if " section is commented by shweta
                        //else if (txtrand.Text == "")
                        //{
                        //    LblMsgBody.Text = "Please enter No. of Random Winners.";
                        //    DivMsg.Visible = true;
                        //    DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                        //    string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                        //    ModalPopupLoyalty.Show();
                        //    return;
                        //}
                        MQty = Convert.ToInt64(txttcodesrand.Text);
                        TQty = MQty;// Convert.ToInt64(txtrand.Text);
                        Chk = true;
                    }
                }
                else
                {
                    TQty = 0;
                    Chk = false;
                }
                #endregion
            }
            if (rdAtDueDate.Checked)
            {
                #region At Due Date Logic
                if (rdFirstnton.Checked)
                {
                    #region Logic Check
                    if (txtallpFirstn.Text == "")
                    {
                        LblMsgBody.Text = "Please enter First 'n' participants.";
                        DivMsg.Visible = true;
                        DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                        string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                       // ModalPopupLoyalty.Show();
                        return;
                    }
                    if (txtallpFirstnton.Text == "")
                    {
                        LblMsgBody.Text = "Please enter No. of customer for random winning.";
                        DivMsg.Visible = true;
                        DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                        string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                      //  ModalPopupLoyalty.Show();
                        return;
                    }
                    MQty = Convert.ToInt64(txtallpFirstn.Text);
                    TQty = Convert.ToInt64(txtallpFirstnton.Text);
                    #endregion
                    Chk = true;
                }
                else if (rdAllton.Checked)
                {
                    #region Logic Check
                    if (txtalltonCustomer.Text == "")
                    {
                        LblMsgBody.Text = "Please enter random winners.";
                        DivMsg.Visible = true;
                        DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                        string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                       // ModalPopupLoyalty.Show();
                        return;
                    }
                    MQty = Convert.ToInt64(txtalltonCustomer.Text);
                    TQty = Convert.ToInt64(txtalltonCustomer.Text);
                    Frequency = 1;
                    #endregion
                    Chk = true;
                }
                else if (rdAlltonthrand.Checked)
                {
                    #region Logic Check
                    if (txtalltonth.Text == "")
                    {
                        LblMsgBody.Text = "Please enter random 'n' participants.";
                        DivMsg.Visible = true;
                        DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                        string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                      //  ModalPopupLoyalty.Show();
                        return;
                    }
                    if (txtrandfreq.Text == "")
                    {
                        LblMsgBody.Text = "Please enter frequency for random 'n' winners.";
                        DivMsg.Visible = true;
                        DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                        string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                      //  ModalPopupLoyalty.Show();
                        return;
                    }
                    MQty = Convert.ToInt64(txtalltonth.Text);
                    TQty = Convert.ToInt64(txtalltonth.Text);
                    #endregion
                    Chk = true;
                }
                else if (rdAlltoAll.Checked)
                {
                    #region Logic Check
                    MQty = 0;
                    TQty = 0;
                    #endregion
                    Chk = false;
                }
                #endregion
            }
            if (txtGiftQty.Text == "")
                txtGiftQty.Text = "0";
            if (TQty > 0)
            {
                if (txtGiftQty.Text == "0")
                {
                    if (!rdAllParticipant.Checked)
                    {
                        LblMsgBody.Text = "Please enter No. of prize quantity.";
                        DivMsg.Visible = true;
                        DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                        string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                      //  ModalPopupLoyalty.Show();
                        return;
                    }
                }
            }
            if (Chk)
            {
                if (MQty < TQty)
                {
                    LblMsgBody.Text = "No. of paricipants is always greater or equal to <span style='color:blue;'>" + Msg + "</span> winners.";
                    DivMsg.Visible = true;
                    DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                    string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                   // ModalPopupLoyalty.Show();
                    return;
                }
                if (Obj.Count > 0)
                {
                    Int64 Remain = 0;
                    p = Obj.Sum(x => x.GiftCount);
                    if (btnGSave.Text != "Save")
                        p = p - Convert.ToInt64(hdneditvalue.Value);
                    Remain = TQty - p;
                    p += Convert.ToInt64(txtGiftQty.Text);
                    if (p > TQty)
                    {
                        string str = "";
                        if (Remain > 0)
                            str = "Remainig Gift Quantity : " + Remain;
                        else
                            str = "No Remaining Gift is set.";
                        LblMsgBody.Text = "No. of Gift is greaer than distributed customer." + str;
                        DivMsg.Visible = true;
                        DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                        string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                   //     ModalPopupLoyalty.Show();
                        return;
                    }
                }
            }
            string[] Arr = ddlAddGift.SelectedValue.ToString().Split('*');
            bool Flag = true; bool SeqFlag = false;
            if (btnGSave.Text == "Save")
            {
                if (Obj.Count > 0)
                {
                    foreach (var item in Obj)
                    {
                        if (item.Gift_ID == Arr[0].ToString())
                            Flag = false;
                        if (rdSequenceDistri.Checked)
                        {
                            if (item.GiftCount == 0)
                            {
                                if (item.GiftCount == Convert.ToInt64(txtGiftQty.Text))
                                    SeqFlag = true;
                            }
                        }
                    }
                }
            }
            else
            {
                int lindex = Convert.ToInt32(hdngiftrowid.Value) - 1;
                var rand = Obj[lindex];
                Obj.Remove(rand);
                Flag = true;
            }
            if (SeqFlag)
            {
                LblMsgBody.Text = "Only One Gift with infinite quantity.";
                DivMsg.Visible = true;
                DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                //ModalPopupLoyalty.Show();
                return;
            }
            if (Flag)
            {
                Obj.Add(new Gifts { AdditionalGift_ID = 0, Gift_ID = Arr[0], GiftName = ddlAddGift.SelectedItem.Text.Trim(), GiftCount = Convert.ToInt64(txtGiftQty.Text), SpendTotalCount = txttcodes.Text.Trim(), IsCoupon = Arr[2].ToString() });
                FillGiftDetails(GrdVwGift, 1);
                ddlAddGift.SelectedIndex = 0;
                txtGiftQty.Text = string.Empty;
                hdngiftrowid.Value = string.Empty;
                hdneditvalue.Value = string.Empty;
                ChkInfinite.Checked = false;
                txtGiftQty.Enabled = true;
                btnGSave.Text = "Save";
                DivMsg.Visible = false;
            }
            else
            {
                LblMsgBody.Text = "This Gift is Already Exist";
                DivMsg.Visible = true;
                DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                string script = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            }
            //ModalPopupLoyalty.Show();
        }

        catch (Exception ex)
        {
            DataProvider.LogManager.WriteExe("Error In Saveing Gift coupon service " + ex.Message.ToString() + "------------" + ex.ToString());
        }
    }
    protected void btnGReset_Click(object sender, EventArgs e)
    {
        DivMsg.Visible = false;
        ddlAddGift.SelectedIndex = 0;
        txtGiftQty.Text = string.Empty;
        btnGSave.Text = "Save";
        hdngiftrowid.Value = string.Empty;
        hdneditvalue.Value = string.Empty;
       // ModalPopupLoyalty.Show();
    }
    protected void GrdVwGift_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            DivMsg.Visible = false;
            int lindex = Convert.ToInt32(e.CommandArgument.ToString()) - 1;
            var rand = Obj[lindex];
            if (e.CommandName == "DeleteGiftRow")
            {
                Obj.Remove(rand);
                FillGiftDetails(GrdVwGift, 1);
            }
            else if (e.CommandName == "EditGiftRow")
            {
                string GID = GetMyGiftID(rand.Gift_ID);
                hdngiftrowid.Value = e.CommandArgument.ToString();
                ddlAddGift.SelectedValue = GID; hdneditvalue.Value = rand.GiftCount.ToString();
                txtGiftQty.Text = (rand.GiftCount > 0 ? rand.GiftCount.ToString() : "");
                btnGSave.Text = "Update";
            }
         //   ModalPopupLoyalty.Show();
        }
        catch (Exception ex)
        {
          //  ModalPopupLoyalty.Show();
        }
    }



    protected void btnYesAlert_Click(object sender, EventArgs e)
    {
        Loyalty_Programm Reg = new Loyalty_Programm();
        Reg.RowId = Convert.ToInt64(currindex.Value);
        if (ActionText.Value == "IsActive")
        {
            if (Convert.ToInt32(IsAct.Value) == 0)
                Reg.IsActive = 1;
            else
                Reg.IsActive = 0;
            Reg.DMLs = "IsActive";
            Loyalty_Programm.IsActiveDelete(Reg);
            Label2.Text = "Product " + Reg.Pro_Name + " has been <span style='color:blue;'>" + FindStatus(Reg.IsActive) + "</span> successfully !";
        }
        else if (ActionText.Value == "IsDelete")
        {
            Reg.IsDelete = 1;
            Reg.DMLs = "IsDelete";
            Loyalty_Programm.IsActiveDelete(Reg);
            Label2.Text = "Product " + Reg.Pro_Name + " has been deleted successfully !";
        }
        filldata();
        NewMsgpop.Visible = true;
        NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
        string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }
    protected void btnNoAlert_Click(object sender, EventArgs e)
    {

    }
    protected void PlanGridViewDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        selsrvplanid.Value = e.CommandArgument.ToString();
        if (e.CommandName.ToString() == "BuyService")
        {
            string ServiceId = ddlService.SelectedValue;
            CheckValidation(ServiceId);

            ClearText(); NewMsgpop.Visible = false;
            fillProductLoyalty(true, ddlProduct);
            if (ddlProduct.SelectedIndex > 0)
            {
                DataTable ddt = SQL_DB.ExecuteDataSet("SELECT RowId, Comp_ID, Pro_ID, Points,IsCashConvert, DateFrom, DateTo, IsActive, IsDelete FROM M_Loyalty WHERE Pro_ID = '" + ddlProduct.SelectedValue.ToString() + "' ").Tables[0];
                if (ddt.Rows.Count > 0)
                {
                    if (Convert.ToInt32(ddt.Rows[0]["IsCashConvert"]) == 0)
                        chkconvert.Checked = true;
                    else
                        chkconvert.Checked = false;
                    hdnloyalty.Value = ddt.Rows[0]["Pro_ID"].ToString();
                    txtloyaltypoints.Text = ddt.Rows[0]["Points"].ToString();
                    txtloyaltydtfrom.Text = ddt.Rows[0]["DateFrom"].ToString();
                    txtloyaltydtto.Text = ddt.Rows[0]["DateTo"].ToString();
                    btnSave.Text = "Update";
                    //Lblloyaltyhead.Text = "Update Loyalty";
                }
                else
                {
                    btnSave.Text = "Save";
                    //Lblloyaltyhead.Text = "Add Loyalty";
                }
            }
            else
            {
                btnSave.Text = "Save";
                //Lblloyaltyhead.Text = "Add Loyalty";
            }
         //   ModalPopupLoyalty.Show();
        }
    }
    private void FillPlanMasterGrid(string ServiceId, int disp)
    {

        DataTable dt = SQL_DB.ExecuteDataSet("SELECT " + disp + " AS Disp, Plan_ID, Service_ID,(SELECT ServiceName FROM M_Service WHERE Service_ID = M_ServicePlan.Service_ID) ServiceName, PlanName, PlanPeriod, PlanPrice, EntryDate, IsActive, IsDelete FROM M_ServicePlan WHERE Service_ID = '" + ServiceId + "' AND IsActive = 0 AND IsDelete = 0 ").Tables[0];
        if (dt.Rows.Count > 0)
        {
          //  lblplgrw.Text = dt.Rows[0]["ServiceName"].ToString();
            // Lblloyaltyhead.Text = dt.Rows[0]["ServiceName"].ToString();  commneted by shweta - 11MAy2018
        }
       // PlanGridViewDetails.DataSource = dt;
       // PlanGridView.DataBind();
    }

    //protected void btnSave_Click(object sender, EventArgs e)
    //{

    //    #region validation check for date , if not chech then return
    //    if (rdAtDueDate.Checked)
    //    {
    //        if (string.IsNullOrEmpty(txtDueDate.Text))
    //        {
    //            LblMsgBody.Text = "Please select due date ";
    //            DivMsg.Visible = true;
    //            DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //            string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //            ModalPopupLoyalty.Show();
    //            return;
    //        }
    //    }

    //    if (txtloyaltydtfrom.Text == "")
    //    {
    //        LblMsgBody.Text = "Please enter date from.";
    //        DivMsg.Visible = true;
    //        DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //        string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //        ModalPopupLoyalty.Show();
    //        return;
    //    }
    //    if (txtloyaltydtto.Text == "")
    //    {
    //        LblMsgBody.Text = "Please enter date to.";
    //        DivMsg.Visible = true;
    //        DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //        string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //        ModalPopupLoyalty.Show();
    //        return;
    //    }
    //    #endregion
    //    bool CheckRwdQty = true; Int64 TrwdQty = 0;
    //    if (Obj.Count > 0)
    //        TrwdQty = Obj.Sum(x => x.GiftCount);
    //    bool Chk = false;

    //    Loyalty_Programm Reg = new Loyalty_Programm();

    //    Referral Ref = new Referral();

    //    #region Logic For Additional Gift
    //    if (rdInstant.Checked)
    //    {
    //        Reg.ServiceType = ServiceTypes.Instant.ToString();
    //        #region Logic for Instant Rules
    //        if (rdFirstnth.Checked)
    //        {
    //            Reg.Rules = ServiceRules.FirstNCustomer.ToString();
    //            #region First radio btn checked


    //            #region validation check
    //            if (txtnth.Text == "")
    //            {
    //                CheckRwdQty = false;
    //                LblMsgBody.Text = "Please enter distributed first'n' no. of customers";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            #endregion
    //            Reg.MasterCodes = Convert.ToInt64(txttcodes.Text);
    //            Reg.WinningCodes = Convert.ToInt64(txtnth.Text);
    //            Reg.WinCodes = 0;
    //            Reg.Nth = 1;

    //            Chk = true;
    //            #endregion
    //        }
    //        else if (rdFirstRandomnth.Checked)
    //        {
    //            Reg.Rules = ServiceRules.RandomNCustomernth.ToString();
    //            #region Second radio btn checked


    //            #region validation check
    //            if (txteverynth.Text == "")
    //            {
    //                LblMsgBody.Text = "Please enter Every n<sup>th</sup> participants.";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //                string script2 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script2, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            if (txteverywin.Text == "")
    //            {
    //                LblMsgBody.Text = "Please enter No. of winners.";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //                string script2 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script2, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            #endregion
    //            Reg.MasterCodes = Convert.ToInt64(txteverywin.Text);//Convert.ToInt64(txteverywin.Text) / Convert.ToInt64(txteverynth.Text);
    //            Reg.WinningCodes = Reg.MasterCodes;
    //            Reg.WinCodes = 0;
    //            Reg.Nth = Convert.ToInt32(txteverynth.Text);

    //            Chk = true;
    //            #endregion
    //        }
    //        else if (rdRandom.Checked)
    //        {
    //            Reg.Rules = ServiceRules.RandomNCustomer.ToString();
    //            #region third radio btn checked


    //            #region validation check
    //            // if (txtrand.Text == "")
    //            if (txttcodesrand.Text == "")
    //            {
    //                LblMsgBody.Text = "Please enter distributed no. of customers";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //                string script2 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script2, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            #endregion
    //            Reg.MasterCodes = Convert.ToInt32(txttcodesrand.Text);
    //            Reg.WinningCodes = Convert.ToInt32(txttcodesrand.Text);
    //            Reg.WinCodes = 0;
    //            Reg.Nth = 1;

    //            Chk = true;
    //            #endregion
    //        }
    //        else if (rdAllParticipant.Checked)
    //        {
    //            Reg.Rules = ServiceRules.AllCustomer.ToString();
    //            #region 4th radion btn
    //            Reg.MasterCodes = 0;
    //            Reg.WinningCodes = Convert.ToInt64(TrwdQty);
    //            Reg.WinCodes = 0;
    //            Reg.Nth = 1;
    //            #endregion
    //            Chk = false;
    //        }
    //        #endregion
    //        Reg.PrizeTrans_Id = hdnprizetransid.Value;
    //    }
    //    if (rdAtDueDate.Checked)
    //    {
    //        Reg.ServiceType = ServiceTypes.DueDate.ToString();
    //        #region Logic for At Due Date Rules
    //        if (rdFirstnton.Checked)
    //        {
    //            Reg.Rules = ServiceRules.FirstNCustomertoNCustomer.ToString();
    //            #region Logic for check
    //            if (txtallpFirstn.Text == "")
    //            {
    //                CheckRwdQty = false;
    //                LblMsgBody.Text = "Please enter distributed first 'n' no. of customers";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            else if (txtallpFirstnton.Text == "")
    //            {
    //                CheckRwdQty = false;
    //                LblMsgBody.Text = "Please enter distributed Random 'n' no. of customers.";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            else if (Convert.ToInt64(txtallpFirstnton.Text) > Convert.ToInt64(txtallpFirstn.Text))
    //            {
    //                CheckRwdQty = false;
    //                LblMsgBody.Text = "Please enter distributed Random 'n' no. of customers is less than first 'n' customers.";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            Reg.MasterCodes = Convert.ToInt64(txtallpFirstn.Text);
    //            Reg.WinningCodes = Convert.ToInt64(txtallpFirstnton.Text);
    //            Reg.WinCodes = 0;
    //            Reg.Nth = 1;
    //            #endregion
    //            Chk = true;
    //        }
    //        else if (rdAlltonthrand.Checked)
    //        {
    //            Reg.Rules = ServiceRules.AllCusomertoRandomNCustomer.ToString();
    //            #region Logic for check
    //            if (txtalltonth.Text == "")
    //            {
    //                CheckRwdQty = false;
    //                LblMsgBody.Text = "Please enter random first 'n' participants.";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            else if (txtrandfreq.Text == "")
    //            {
    //                CheckRwdQty = false;
    //                LblMsgBody.Text = "Please enter frequency for Random 'n' participants.";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            Reg.MasterCodes = Convert.ToInt64(txtalltonth.Text);
    //            Reg.WinningCodes = Convert.ToInt64(txtalltonth.Text);
    //            Reg.WinCodes = 0;
    //            Reg.Nth = Convert.ToInt32(txtrandfreq.Text);
    //            #endregion
    //            Chk = true;
    //        }
    //        else if (rdAllton.Checked)
    //        {
    //            Reg.Rules = ServiceRules.AllCusomertoRandomNWinners.ToString();
    //            #region Logic for check
    //            if (txtalltonCustomer.Text == "")
    //            {
    //                CheckRwdQty = false;
    //                LblMsgBody.Text = "Please enter random 'n' participants winners.";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            Reg.MasterCodes = Convert.ToInt64(txtalltonCustomer.Text);
    //            Reg.WinningCodes = Convert.ToInt64(txtalltonCustomer.Text);
    //            Reg.WinCodes = 0;
    //            Reg.Nth = 1;
    //            #endregion
    //            Chk = true;
    //        }
    //        else if (rdAlltoAll.Checked)
    //        {
    //            Reg.Rules = ServiceRules.AllCustomertoAllCustomer.ToString();
    //            #region Logic for check
    //            Reg.MasterCodes = 0;
    //            Reg.WinningCodes = Convert.ToInt64(TrwdQty);
    //            Reg.WinCodes = 0;
    //            Reg.Nth = 1;
    //            #endregion
    //            Chk = true;
    //        }
    //        #endregion
    //        Reg.PrizeTrans_Id = hdnprizetransid.Value;
    //    }
    //    if (Chk)
    //    {
    //        #region 
    //        string Txt = "";
    //        if (TrwdQty > Reg.WinningCodes)
    //            Txt = "greater";
    //        else if (TrwdQty < Reg.WinningCodes)
    //            Txt = "less";
    //        else
    //        {
    //            Txt = "";
    //        }
    //        if (Txt != "")
    //        {
    //            CheckRwdQty = false;
    //            LblMsgBody.Text = "No. of rewards is " + Txt + " than Distrubuted customer.";
    //            DivMsg.Visible = true;
    //            DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //            string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //            ModalPopupLoyalty.Show();
    //            return;
    //        }
    //        #endregion
    //    }
    //    else
    //    {
    //        if ((rdInstant.Checked) || (rdAtDueDate.Checked))
    //        {
    //            //var lst = Obj.Where(x => x.GiftCount == 0).SingleOrDefault();
    //            // if (lst == null)
    //            if (Obj.Count == 0)
    //            {
    //                LblMsgBody.Text = "Minimum one <span style='color:blue;'>Gift</span> is added Quantity <span style='color:blue;'>Gift</span> in your gift List.";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //        }
    //    }
    //    if (rdRandomDistri.Checked)
    //        Reg.RewardsDistribution = RwdDistrubutionRules.Random.ToString();
    //    else
    //    {
    //        if (rdSequenceDistri.Checked)
    //            Reg.RewardsDistribution = RwdDistrubutionRules.Sequence.ToString();
    //        else
    //            Reg.RewardsDistribution = RwdDistrubutionRules.Random.ToString();
    //    }
    //    if (!CheckRwdQty)
    //    {
    //        LblMsgBody.Text = "No. of rewards is greater or less than Distrubuted customer.";
    //        DivMsg.Visible = true;
    //        DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //        string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //        ModalPopupLoyalty.Show();
    //        return;
    //    }
    //    #endregion
    //    Reg.Comp_ID = Session["CompanyId"].ToString();
    //    Reg.Pro_ID = ddlProduct.SelectedValue.ToString();
    //    Reg.Service_ID = selsrvid.Value;
    //    Reg.Subscribe_Id = selsrvplanid.Value;
    //    #region Logic For Check Feature
    //    int IsSound = 0, IsAdditionalGift = 0;
    //    DataTable dt = SQL_DB.ExecuteDataSet("SELECT ServiceFeaure_ID, Service_ID,(SELECT ServiceName FROM M_Service WHERE Service_ID = M_ServiceFeature.Service_ID) ServiceName, IsPoints, IsDateRange, IsSound, IsFrequency, IsAdditionalGift, IsMessageTemplete, EntryDate, IsDelete FROM M_ServiceFeature WHERE IsDelete = 0 AND Service_ID = '" + Reg.Service_ID + "' ").Tables[0];
    //    if (dt.Rows.Count > 0)
    //    {
    //        IsSound = Convert.ToInt32(dt.Rows[0]["IsSound"].ToString());
    //        IsAdditionalGift = Convert.ToInt32(dt.Rows[0]["IsAdditionalGift"].ToString());
    //    }
    //    if (IsAdditionalGift == 0)
    //    {
    //        if (TrwdQty == 0)
    //        {
    //            LblMsgBody.Text = "Please add gifts List with quantity.";
    //            DivMsg.Visible = true;
    //            DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //            string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //            ModalPopupLoyalty.Show();
    //            return;
    //        }
    //    }
    //    #endregion

    //    #region taking value from textbox
    //    if (txtloyaltydtfrom.Text != "")
    //        Reg.DateFrom = Convert.ToDateTime(txtloyaltydtfrom.Text).ToString("yyyy/MM/dd hh:mm:ss tt");
    //    else
    //        Reg.DateFrom = null;
    //    if (txtloyaltydtto.Text != "")
    //        Reg.DateTo = Convert.ToDateTime(txtloyaltydtto.Text).ToString("yyyy/MM/dd hh:mm:ss tt");
    //    else
    //        Reg.DateTo = null;
    //    Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
    //    if (chkconvert.Checked)
    //        Reg.IsCashConvert = 0;
    //    else
    //        Reg.IsCashConvert = 1;
    //    if (txtfrequency.Text.Trim().Replace("'", "''") != "")
    //        Reg.Frequency = Convert.ToInt32(txtfrequency.Text.Trim().Replace("'", "''"));
    //    else
    //        Reg.Frequency = 1;
    //    if (txtloyaltypoints.Text != "")
    //        Reg.Points = Convert.ToDecimal(txtloyaltypoints.Text);
    //    else
    //        Reg.Points = 0;
    //    if (txtcashamt.Text != "")
    //        Reg.IsCash = Convert.ToInt32(txtcashamt.Text);
    //    else
    //        Reg.IsCash = 0;
    //    Reg.Comments = txtCommentsTxt.Text.Trim().Replace("'", "''");
    //    //Reg.TotalNoOfCodes = Convert.ToInt64(txttcodes.Text);
    //    #endregion
    //    if (Obj.Count > 0)
    //        Reg.GiftList = Obj;
    //    if (btnSave.Text == "Save")
    //    {
    //        Reg.RowId = 0;
    //        Reg.DML = "I";
    //        Label2.Text = "Loyalty Programm saved successfully fot this Product!";
    //        selsrvid.Value = string.Empty;
    //    }
    //    else
    //    {
    //        Reg.RowId = Convert.ToInt32(lblproiddel.Text);
    //        Reg.DML = "U";
    //        Reg.RowId = Convert.ToInt32(currindex.Value);
    //        Label2.Text = "Loyalty Programm saved successfully fot this Product!";
    //        selsrvid.Value = string.Empty;
    //    }

    //    #region Code For Referral
    //    if ((rdIsRefCash.Checked) || (rdIsRefPoints.Checked) || (rdIsRefGift.Checked))
    //    {
    //        Ref.Trans_Id = Reg.Trans_ID;
    //        Ref.SST_Id = Reg.RowId;
    //        Ref.DML = Reg.DML;
    //        if (rdIsRefGift.Checked)
    //        {
    //            Reg.IsReferral = 3;
    //            Ref.GiftReferral = ddlrefGiftFrom.SelectedValue.Trim();
    //            Ref.GiftUsers = ddlrefGiftTo.SelectedValue.Trim();
    //        }
    //        else if (rdIsRefPoints.Checked)
    //        {
    //            Reg.IsReferral = 2;
    //            Ref.PointsReferral = Convert.ToInt64(txtreffrom.Text.Trim());
    //            Ref.PointsUsers = Convert.ToInt64(txtrefto.Text.Trim());
    //            if (chkRefIsCash.Checked)
    //                Ref.IsCashConvert = 0;
    //            else
    //                Ref.IsCashConvert = 1;
    //        }
    //        else if (rdIsRefCash.Checked)
    //        {
    //            Reg.IsReferral = 1;
    //            Ref.IsCashReferral = Convert.ToInt64(txtreffrom.Text.Trim());
    //            Ref.IsCashUsers = Convert.ToInt64(txtrefto.Text.Trim());
    //        }
    //    }
    //    else
    //    {
    //        Reg.IsReferral = 0;
    //        Ref = new Referral();
    //    }
    //    Reg.Referrals = Ref;
    //    #endregion
    //    DateTime? dttxtDueDate = null;
    //    if (!string.IsNullOrEmpty(txtDueDate.Text))
    //    {
    //        dttxtDueDate = DateTime.Parse(txtDueDate.Text);
    //        Reg.dttxtDueDate = dttxtDueDate;
    //    }

    //    Loyalty_Programm.InsUpdSrvForProduct(Reg); //[M_ServiceSubscriptionTrans] having inset/update
    //    #region Save for Sound File
    //    if (IsSound == 0)
    //    {
    //        string path = Server.MapPath("../Data/Sound"); string path1 = Server.MapPath("../Data/Sound");
    //        if (flSoundH.FileName != "")
    //        {
    //            path = Server.MapPath("../Data/Sound");
    //            path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + Reg.RowId;
    //            DataProvider.Utility.CreateDirectory(path);
    //            path = path + "\\" + Reg.RowId + "_H.wav";
    //            flSoundH.SaveAs(path);
    //            Reg.DMLs = "H";
    //            Loyalty_Programm.UpdateFiles(Reg);
    //        }
    //        else
    //        {
    //            if (Convert.ToInt32(currindex.Value) > 0)
    //            {
    //                path = Server.MapPath("../Data/Sound");
    //                path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + Reg.RowId;
    //                DataProvider.Utility.CreateDirectory(path);
    //                path = path + "\\" + Reg.RowId + "_H.wav";
    //                path1 = Server.MapPath("../Data/Sound");
    //                path1 = path1 + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + currindex.Value;
    //                path1 = path1 + "\\" + currindex.Value + "_H.wav";
    //                System.IO.File.Copy(path1, path, true);
    //            }
    //        }
    //        if (flSoundE.FileName != "")
    //        {
    //            path = Server.MapPath("../Data/Sound");
    //            path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + Reg.RowId;
    //            DataProvider.Utility.CreateDirectory(path);
    //            path = path + "\\" + Reg.RowId + "_E.wav";
    //            flSoundE.SaveAs(path);
    //            Reg.DMLs = "E";
    //            Loyalty_Programm.UpdateFiles(Reg);
    //        }
    //        else
    //        {
    //            if (Convert.ToInt32(currindex.Value) > 0)
    //            {
    //                path = Server.MapPath("../Data/Sound");
    //                path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + Reg.RowId;
    //                DataProvider.Utility.CreateDirectory(path);
    //                path = path + "\\" + Reg.RowId + "_E.wav";
    //                path1 = Server.MapPath("../Data/Sound");
    //                path1 = path1 + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + currindex.Value;
    //                path1 = path1 + "\\" + currindex.Value + "_E.wav";
    //                System.IO.File.Copy(path1, path, true);
    //            }
    //        }
    //    }
    //    #endregion

    //    ClearText();
    //    NewMsgpop.Visible = true;
    //    NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
    //    string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
    //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    //    // arb, handle double click 
    //    btnSave.Enabled = false;
    //}
    public string LogicForAdditonalGift(Loyalty_Programm Reg, Int64 TrwdQty)
    {
        string strErrorMsg = "error";
        bool CheckRwdQty = true; //int TrwdQty = 0;
        bool Chk = false;
        #region Logic For Additional Gift
        if (rdInstant.Checked)
        {
            Reg.ServiceType = ServiceTypes.Instant.ToString();
            #region Logic for Instant Rules
            if (rdFirstnth.Checked)
            {
                Reg.Rules = ServiceRules.FirstNCustomer.ToString();
                #region First radio btn checked


                #region validation check
                if (txtnth.Text == "")
                {
                    CheckRwdQty = false;
                    LblMsgBody.Text = "Please enter distributed first'n' no. of customers";
                    DivMsg.Visible = true;
                    DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                    string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
                  //  ModalPopupLoyalty.Show();
                    return strErrorMsg;
                }
                #endregion
                Reg.MasterCodes = Convert.ToInt64(txttcodes.Text);
                Reg.WinningCodes = Convert.ToInt64(txtnth.Text);
                Reg.WinCodes = 0;
                Reg.Nth = 1;

                Chk = true;
                #endregion
            }
            else if (rdFirstRandomnth.Checked)
            {
                Reg.Rules = ServiceRules.RandomNCustomernth.ToString();
                #region Second radio btn checked


                #region validation check
                if (txteverynth.Text == "")
                {
                    LblMsgBody.Text = "Please enter Every n<sup>th</sup> participants.";
                    DivMsg.Visible = true;
                    DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                    string script2 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script2, true);
               //     ModalPopupLoyalty.Show();
                    return strErrorMsg;
                }
                if (txteverywin.Text == "")
                {
                    LblMsgBody.Text = "Please enter No. of winners.";
                    DivMsg.Visible = true;
                    DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                    string script2 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script2, true);
               //     ModalPopupLoyalty.Show();
                    return strErrorMsg;
                }
                #endregion
                Reg.MasterCodes = Convert.ToInt64(txteverywin.Text);//Convert.ToInt64(txteverywin.Text) / Convert.ToInt64(txteverynth.Text);
                Reg.WinningCodes = Reg.MasterCodes;
                Reg.WinCodes = 0;
                Reg.Nth = Convert.ToInt32(txteverynth.Text);

                Chk = true;
                #endregion
            }
            else if (rdRandom.Checked)
            {
                Reg.Rules = ServiceRules.RandomNCustomer.ToString();
                #region third radio btn checked


                #region validation check
                // if (txtrand.Text == "")
                if (txttcodesrand.Text == "")
                {
                    LblMsgBody.Text = "Please enter distributed no. of customers";
                    DivMsg.Visible = true;
                    DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                    string script2 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script2, true);
                  //  ModalPopupLoyalty.Show();
                    return strErrorMsg;
                }
                #endregion
                Reg.MasterCodes = Convert.ToInt32(txttcodesrand.Text);
                Reg.WinningCodes = Convert.ToInt32(txttcodesrand.Text);
                Reg.WinCodes = 0;
                Reg.Nth = 1;

                Chk = true;
                #endregion
            }
            else if (rdAllParticipant.Checked)
            {
                Reg.Rules = ServiceRules.AllCustomer.ToString();
                #region 4th radion btn
                Reg.MasterCodes = 0;
                Reg.WinningCodes = Convert.ToInt64(TrwdQty);
                Reg.WinCodes = 0;
                Reg.Nth = 1;
                #endregion
                Chk = false;
            }
            #endregion
            Reg.PrizeTrans_Id = hdnprizetransid.Value;
        }
        if (rdAtDueDate.Checked)
        {
            Reg.ServiceType = ServiceTypes.DueDate.ToString();
            #region Logic for At Due Date Rules
            if (rdFirstnton.Checked)
            {
                Reg.Rules = ServiceRules.FirstNCustomertoNCustomer.ToString();
                #region Logic for check
                if (txtallpFirstn.Text == "")
                {
                    CheckRwdQty = false;
                    LblMsgBody.Text = "Please enter distributed first 'n' no. of customers";
                    DivMsg.Visible = true;
                    DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                    string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
               //     ModalPopupLoyalty.Show();
                    return strErrorMsg;
                }
                else if (txtallpFirstnton.Text == "")
                {
                    CheckRwdQty = false;
                    LblMsgBody.Text = "Please enter distributed Random 'n' no. of customers.";
                    DivMsg.Visible = true;
                    DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                    string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
                  //  ModalPopupLoyalty.Show();
                    return strErrorMsg;
                }
                else if (Convert.ToInt64(txtallpFirstnton.Text) > Convert.ToInt64(txtallpFirstn.Text))
                {
                    CheckRwdQty = false;
                    LblMsgBody.Text = "Please enter distributed Random 'n' no. of customers is less than first 'n' customers.";
                    DivMsg.Visible = true;
                    DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                    string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
                  //  ModalPopupLoyalty.Show();
                    return strErrorMsg;
                }
                Reg.MasterCodes = Convert.ToInt64(txtallpFirstn.Text);
                Reg.WinningCodes = Convert.ToInt64(txtallpFirstnton.Text);
                Reg.WinCodes = 0;
                Reg.Nth = 1;
                #endregion
                Chk = true;
            }
            else if (rdAlltonthrand.Checked)
            {
                Reg.Rules = ServiceRules.AllCusomertoRandomNCustomer.ToString();
                #region Logic for check
                if (txtalltonth.Text == "")
                {
                    CheckRwdQty = false;
                    LblMsgBody.Text = "Please enter random first 'n' participants.";
                    DivMsg.Visible = true;
                    DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                    string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
                  //  ModalPopupLoyalty.Show();
                    return strErrorMsg;
                }
                else if (txtrandfreq.Text == "")
                {
                    CheckRwdQty = false;
                    LblMsgBody.Text = "Please enter frequency for Random 'n' participants.";
                    DivMsg.Visible = true;
                    DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                    string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
                 //   ModalPopupLoyalty.Show();
                    return strErrorMsg;
                }
                Reg.MasterCodes = Convert.ToInt64(txtalltonth.Text);
                Reg.WinningCodes = Convert.ToInt64(txtalltonth.Text);
                Reg.WinCodes = 0;
                Reg.Nth = Convert.ToInt32(txtrandfreq.Text);
                #endregion
                Chk = true;
            }
            else if (rdAllton.Checked)
            {
                Reg.Rules = ServiceRules.AllCusomertoRandomNWinners.ToString();
                #region Logic for check
                if (txtalltonCustomer.Text == "")
                {
                    CheckRwdQty = false;
                    LblMsgBody.Text = "Please enter random 'n' participants winners.";
                    DivMsg.Visible = true;
                    DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                    string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
                 //   ModalPopupLoyalty.Show();
                    return strErrorMsg;
                }
                Reg.MasterCodes = Convert.ToInt64(txtalltonCustomer.Text);
                Reg.WinningCodes = Convert.ToInt64(txtalltonCustomer.Text);
                Reg.WinCodes = 0;
                Reg.Nth = 1;
                #endregion
                Chk = true;
            }
            else if (rdAlltoAll.Checked)
            {
                Reg.Rules = ServiceRules.AllCustomertoAllCustomer.ToString();
                #region Logic for check
                Reg.MasterCodes = 0;
                Reg.WinningCodes = Convert.ToInt64(TrwdQty);
                Reg.WinCodes = 0;
                Reg.Nth = 1;
                #endregion
                Chk = true;
            }
            #endregion
            Reg.PrizeTrans_Id = hdnprizetransid.Value;
        }
        if (Chk)
        {
            #region 
            string Txt = "";
            if (TrwdQty > Reg.WinningCodes)
                Txt = "greater";
            else if (TrwdQty < Reg.WinningCodes)
                Txt = "less";
            else
            {
                Txt = "";
            }
            if (Txt != "")
            {
                CheckRwdQty = false;
                LblMsgBody.Text = "No. of rewards is " + Txt + " than Distrubuted customer.";
                DivMsg.Visible = true;
                DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
              //  ModalPopupLoyalty.Show();
                return strErrorMsg;
            }
            #endregion
        }
        else
        {
            if ((rdInstant.Checked) || (rdAtDueDate.Checked))
            {
                //var lst = Obj.Where(x => x.GiftCount == 0).SingleOrDefault();
                // if (lst == null)
                if (Obj.Count == 0)
                {
                    LblMsgBody.Text = "Minimum one <span style='color:blue;'>Gift</span> is added Quantity <span style='color:blue;'>Gift</span> in your gift List.";
                    DivMsg.Visible = true;
                    DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                    string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
               //     ModalPopupLoyalty.Show();
                    return strErrorMsg;
                }
            }
        }
        if (rdRandomDistri.Checked)
            Reg.RewardsDistribution = RwdDistrubutionRules.Random.ToString();
        else
        {
            if (rdSequenceDistri.Checked)
                Reg.RewardsDistribution = RwdDistrubutionRules.Sequence.ToString();
            else
                Reg.RewardsDistribution = RwdDistrubutionRules.Random.ToString();
        }
        if (!CheckRwdQty)
        {
            LblMsgBody.Text = "No. of rewards is greater or less than Distrubuted customer.";
            DivMsg.Visible = true;
            DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
            string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
          //  ModalPopupLoyalty.Show();
            return strErrorMsg;
        }
        return "";
        #endregion
    }

    //protected void btnAddServices_Click(object sender, EventArgs e)
    //{
    //    #region
    //    if (txtloyaltydtfrom.Text == "")
    //    {
    //        LblMsgBody.Text = "Please enter date from.";
    //        DivMsg.Visible = true;
    //        DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //        string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //        ModalPopupLoyalty.Show();
    //        return;
    //    }
    //    if (txtloyaltydtto.Text == "")
    //    {
    //        LblMsgBody.Text = "Please enter date to.";
    //        DivMsg.Visible = true;
    //        DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //        string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //        ModalPopupLoyalty.Show();
    //        return;
    //    }
    //    bool CheckRwdQty = true; Int64 TrwdQty = 0;
    //    if (Obj.Count > 0)
    //        TrwdQty = Obj.Sum(x => x.GiftCount);
    //    bool Chk = false;
    //    #endregion
    //    Loyalty_Programm Reg = new Loyalty_Programm();
    //    Referral Ref = new Referral();
    //    #region Logic For Additional Gift
    //    if (rdInstant.Checked)
    //    {
    //        Reg.ServiceType = ServiceTypes.Instant.ToString();
    //        #region Logic for Instant Rules
    //        if (rdFirstnth.Checked)
    //        {
    //            Reg.Rules = ServiceRules.FirstNCustomer.ToString();
    //            #region Logic for check
    //            if (txtnth.Text == "")
    //            {
    //                CheckRwdQty = false;
    //                LblMsgBody.Text = "Please enter distributed first'n' no. of customers";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            Reg.MasterCodes = Convert.ToInt64(txttcodes.Text);
    //            Reg.WinningCodes = Convert.ToInt64(txtnth.Text);
    //            Reg.WinCodes = 0;
    //            Reg.Nth = 1;
    //            #endregion
    //            Chk = true;
    //        }
    //        else if (rdFirstRandomnth.Checked)
    //        {
    //            Reg.Rules = ServiceRules.RandomNCustomernth.ToString();
    //            #region Logic for check
    //            if (txteverynth.Text == "")
    //            {
    //                LblMsgBody.Text = "Please enter Every n<sup>th</sup> participants.";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //                string script2 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script2, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            if (txteverywin.Text == "")
    //            {
    //                LblMsgBody.Text = "Please enter No. of winners.";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //                string script2 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script2, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            Reg.MasterCodes = Convert.ToInt64(txteverywin.Text);//Convert.ToInt64(txteverywin.Text) / Convert.ToInt64(txteverynth.Text);
    //            Reg.WinningCodes = Reg.MasterCodes;
    //            Reg.WinCodes = 0;
    //            Reg.Nth = Convert.ToInt32(txteverynth.Text);
    //            #endregion
    //            Chk = true;
    //        }
    //        else if (rdRandom.Checked)
    //        {
    //            Reg.Rules = ServiceRules.RandomNCustomer.ToString();
    //            #region Logic for check
    //            if (txtrand.Text == "")
    //            {
    //                LblMsgBody.Text = "Please enter distributed no. of customers";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //                string script2 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script2, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            Reg.MasterCodes = Convert.ToInt64(txttcodesrand.Text);
    //            Reg.WinningCodes = Convert.ToInt64(txtrand.Text);
    //            Reg.WinCodes = 0;
    //            Reg.Nth = 1;
    //            #endregion
    //            Chk = true;
    //        }
    //        else if (rdAllParticipant.Checked)
    //        {
    //            Reg.Rules = ServiceRules.AllCustomer.ToString();
    //            #region
    //            Reg.MasterCodes = 0;
    //            Reg.WinningCodes = Convert.ToInt64(TrwdQty);
    //            Reg.WinCodes = 0;
    //            Reg.Nth = 1;
    //            #endregion
    //            Chk = false;
    //        }
    //        #endregion
    //        Reg.PrizeTrans_Id = hdnprizetransid.Value;
    //    }
    //    if (rdAtDueDate.Checked)
    //    {
    //        Reg.ServiceType = ServiceTypes.DueDate.ToString();
    //        #region Logic for At Due Date Rules
    //        if (rdFirstnton.Checked)
    //        {
    //            Reg.Rules = ServiceRules.FirstNCustomertoNCustomer.ToString();
    //            #region Logic for check
    //            if (txtallpFirstn.Text == "")
    //            {
    //                CheckRwdQty = false;
    //                LblMsgBody.Text = "Please enter distributed first 'n' no. of customers";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            else if (txtallpFirstnton.Text == "")
    //            {
    //                CheckRwdQty = false;
    //                LblMsgBody.Text = "Please enter distributed Random 'n' no. of customers.";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            else if (Convert.ToInt64(txtallpFirstnton.Text) > Convert.ToInt64(txtallpFirstn.Text))
    //            {
    //                CheckRwdQty = false;
    //                LblMsgBody.Text = "Please enter distributed Random 'n' no. of customers is less than first 'n' customers.";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            Reg.MasterCodes = Convert.ToInt64(txtallpFirstn.Text);
    //            Reg.WinningCodes = Convert.ToInt64(txtallpFirstnton.Text);
    //            Reg.WinCodes = 0;
    //            Reg.Nth = 1;
    //            #endregion
    //            Chk = true;
    //        }
    //        else if (rdAlltonthrand.Checked)
    //        {
    //            Reg.Rules = ServiceRules.AllCusomertoRandomNCustomer.ToString();
    //            #region Logic for check
    //            if (txtalltonth.Text == "")
    //            {
    //                CheckRwdQty = false;
    //                LblMsgBody.Text = "Please enter random first 'n' participants.";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            else if (txtrandfreq.Text == "")
    //            {
    //                CheckRwdQty = false;
    //                LblMsgBody.Text = "Please enter frequency for Random 'n' participants.";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            Reg.MasterCodes = Convert.ToInt64(txtalltonth.Text);
    //            Reg.WinningCodes = Convert.ToInt64(txtalltonth.Text);
    //            Reg.WinCodes = 0;
    //            Reg.Nth = Convert.ToInt32(txtrandfreq.Text);
    //            #endregion
    //            Chk = true;
    //        }
    //        else if (rdAllton.Checked)
    //        {
    //            Reg.Rules = ServiceRules.AllCusomertoRandomNWinners.ToString();
    //            #region Logic for check
    //            if (txtalltonCustomer.Text == "")
    //            {
    //                CheckRwdQty = false;
    //                LblMsgBody.Text = "Please enter random 'n' participants winners.";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
    //                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //            Reg.MasterCodes = Convert.ToInt64(txtalltonCustomer.Text);
    //            Reg.WinningCodes = Convert.ToInt64(txtalltonCustomer.Text);
    //            Reg.WinCodes = 0;
    //            Reg.Nth = 1;
    //            #endregion
    //            Chk = true;
    //        }
    //        else if (rdAlltoAll.Checked)
    //        {
    //            Reg.Rules = ServiceRules.AllCustomertoAllCustomer.ToString();
    //            #region Logic for check
    //            Reg.MasterCodes = 0;
    //            Reg.WinningCodes = Convert.ToInt64(TrwdQty);
    //            Reg.WinCodes = 0;
    //            Reg.Nth = 1;
    //            #endregion
    //            Chk = true;
    //        }
    //        #endregion
    //        Reg.PrizeTrans_Id = hdnprizetransid.Value;
    //    }
    //    if (Chk)
    //    {
    //        string Txt = "";
    //        if (TrwdQty > Reg.WinningCodes)
    //            Txt = "greater";
    //        else if (TrwdQty < Reg.WinningCodes)
    //            Txt = "less";
    //        else
    //        {
    //            Txt = "";
    //        }
    //        if (Txt != "")
    //        {
    //            CheckRwdQty = false;
    //            LblMsgBody.Text = "No. of rewards is " + Txt + " than Distrubuted customer.";
    //            DivMsg.Visible = true;
    //            DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //            string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //            ModalPopupLoyalty.Show();
    //            return;
    //        }
    //    }
    //    else
    //    {
    //        if ((rdInstant.Checked) || (rdAtDueDate.Checked))
    //        {
    //            var lst = Obj.Where(x => x.GiftCount == 0).SingleOrDefault();
    //            if (lst == null)
    //            {
    //                LblMsgBody.Text = "Minimum one <span style='color:blue;'>Gift</span> is added Quantity <span style='color:blue;'>Gift</span> in your gift List.";
    //                DivMsg.Visible = true;
    //                DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //                ModalPopupLoyalty.Show();
    //                return;
    //            }
    //        }
    //    }
    //    if (rdRandomDistri.Checked)
    //        Reg.RewardsDistribution = RwdDistrubutionRules.Random.ToString();
    //    else
    //    {
    //        if (rdSequenceDistri.Checked)
    //            Reg.RewardsDistribution = RwdDistrubutionRules.Sequence.ToString();
    //        else
    //            Reg.RewardsDistribution = RwdDistrubutionRules.Random.ToString();
    //    }
    //    if (!CheckRwdQty)
    //    {
    //        LblMsgBody.Text = "No. of rewards is greater or less than Distrubuted customer.";
    //        DivMsg.Visible = true;
    //        DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //        string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //        ModalPopupLoyalty.Show();
    //        return;
    //    }
    //    #endregion
    //    Reg.Comp_ID = Session["CompanyId"].ToString();
    //    Reg.Pro_ID = ddlProduct.SelectedValue.ToString();
    //    Reg.Service_ID = selsrvid.Value;
    //    Reg.Subscribe_Id = selsrvplanid.Value;
    //    #region Logic For Check Feature
    //    int IsSound = 0, IsAdditionalGift = 0;
    //    DataTable dt = SQL_DB.ExecuteDataSet("SELECT ServiceFeaure_ID, Service_ID,(SELECT ServiceName FROM M_Service WHERE Service_ID = M_ServiceFeature.Service_ID) ServiceName, IsPoints, IsDateRange, IsSound, IsFrequency, IsAdditionalGift, IsMessageTemplete, EntryDate, IsDelete FROM M_ServiceFeature WHERE IsDelete = 0 AND Service_ID = '" + Reg.Service_ID + "' ").Tables[0];
    //    if (dt.Rows.Count > 0)
    //    {
    //        IsSound = Convert.ToInt32(dt.Rows[0]["IsSound"].ToString());
    //        IsAdditionalGift = Convert.ToInt32(dt.Rows[0]["IsAdditionalGift"].ToString());
    //    }
    //    if (IsAdditionalGift == 0)
    //    {
    //        if (TrwdQty == 0)
    //        {
    //            LblMsgBody.Text = "Please add gifts List with quantity.";
    //            DivMsg.Visible = true;
    //            DivMsg.Attributes.Add("class", "alert_boxes_green big_msg");
    //            string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
    //            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
    //            ModalPopupLoyalty.Show();
    //            return;
    //        }
    //    }
    //    #endregion
    //    if (txtloyaltydtfrom.Text != "")
    //        Reg.DateFrom = Convert.ToDateTime(txtloyaltydtfrom.Text).ToString("yyyy/MM/dd hh:mm:ss tt");
    //    else
    //        Reg.DateFrom = null;
    //    if (txtloyaltydtto.Text != "")
    //        Reg.DateTo = Convert.ToDateTime(txtloyaltydtto.Text).ToString("yyyy/MM/dd hh:mm:ss tt");
    //    else
    //        Reg.DateTo = null;
    //    Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
    //    if (chkconvert.Checked)
    //        Reg.IsCashConvert = 0;
    //    else
    //        Reg.IsCashConvert = 1;
    //    if (txtfrequency.Text.Trim().Replace("'", "''") != "")
    //        Reg.Frequency = Convert.ToInt32(txtfrequency.Text.Trim().Replace("'", "''"));
    //    else
    //        Reg.Frequency = 1;
    //    if (txtloyaltypoints.Text != "")
    //        Reg.Points = Convert.ToDecimal(txtloyaltypoints.Text);
    //    else
    //        Reg.Points = 0;
    //    if (txtcashamt.Text != "")
    //        Reg.IsCash = Convert.ToInt32(txtcashamt.Text);
    //    else
    //        Reg.IsCash = 0;
    //    Reg.Comments = txtCommentsTxt.Text.Trim().Replace("'", "''");
    //    //Reg.TotalNoOfCodes = Convert.ToInt64(txttcodes.Text);
    //    if (Obj.Count > 0)
    //        Reg.GiftList = Obj;
    //    if (btnSave.Text == "Save")
    //    {
    //        Reg.RowId = 0;
    //        Reg.DML = "I";
    //        Label2.Text = "Loyalty Programm saved successfully fot this Product!";
    //        selsrvid.Value = string.Empty;
    //    }
    //    else
    //    {
    //        Reg.RowId = Convert.ToInt32(lblproiddel.Text);
    //        Reg.DML = "U";
    //        Reg.RowId = Convert.ToInt32(currindex.Value);
    //        Label2.Text = "Loyalty Programm saved successfully fot this Product!";
    //        selsrvid.Value = string.Empty;
    //    }
    //    #region Code For Referral
    //    if ((rdIsRefCash.Checked) || (rdIsRefPoints.Checked) || (rdIsRefGift.Checked))
    //    {
    //        Ref.Trans_Id = Reg.Trans_ID;
    //        Ref.SST_Id = Reg.RowId;
    //        Ref.DML = Reg.DML;
    //        if (rdIsRefGift.Checked)
    //        {
    //            Reg.IsReferral = 3;
    //            Ref.GiftReferral = ddlrefGiftFrom.SelectedValue.Trim();
    //            Ref.GiftUsers = ddlrefGiftTo.SelectedValue.Trim();
    //        }
    //        else if (rdIsRefPoints.Checked)
    //        {
    //            Reg.IsReferral = 2;
    //            Ref.PointsReferral = Convert.ToInt64(txtreffrom.Text.Trim());
    //            Ref.PointsUsers = Convert.ToInt64(txtrefto.Text.Trim());
    //            if (chkRefIsCash.Checked)
    //                Ref.IsCashConvert = 0;
    //            else
    //                Ref.IsCashConvert = 1;
    //        }
    //        else if (rdIsRefCash.Checked)
    //        {
    //            Reg.IsReferral = 1;
    //            Ref.IsCashReferral = Convert.ToInt64(txtreffrom.Text.Trim());
    //            Ref.IsCashUsers = Convert.ToInt64(txtrefto.Text.Trim());
    //        }
    //    }
    //    else
    //    {
    //        Reg.IsReferral = 0;
    //        Ref = new Referral();
    //    }
    //    Reg.Referrals = Ref;
    //    #endregion
    //    Loyalty_Programm.InsUpdSrvForProduct(Reg);
    //    #region Save for Sound File
    //    if (IsSound == 0)
    //    {
    //        string path = Server.MapPath("../Data/Sound"); string path1 = Server.MapPath("../Data/Sound");
    //        if (flSoundH.FileName != "")
    //        {
    //            path = Server.MapPath("../Data/Sound");
    //            path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + Reg.RowId;
    //            DataProvider.Utility.CreateDirectory(path);
    //            path = path + "\\" + Reg.RowId + "_H.wav";
    //            flSoundH.SaveAs(path);
    //            Reg.DMLs = "H";
    //            Loyalty_Programm.UpdateFiles(Reg);
    //        }
    //        else
    //        {
    //            if (Convert.ToInt32(currindex.Value) > 0)
    //            {
    //                path = Server.MapPath("../Data/Sound");
    //                path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + Reg.RowId;
    //                DataProvider.Utility.CreateDirectory(path);
    //                path = path + "\\" + Reg.RowId + "_H.wav";
    //                path1 = Server.MapPath("../Data/Sound");
    //                path1 = path1 + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + currindex.Value;
    //                path1 = path1 + "\\" + currindex.Value + "_H.wav";
    //                System.IO.File.Copy(path1, path, true);
    //            }
    //        }
    //        if (flSoundE.FileName != "")
    //        {
    //            path = Server.MapPath("../Data/Sound");
    //            path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + Reg.RowId;
    //            DataProvider.Utility.CreateDirectory(path);
    //            path = path + "\\" + Reg.RowId + "_E.wav";
    //            flSoundE.SaveAs(path);
    //            Reg.DMLs = "E";
    //            Loyalty_Programm.UpdateFiles(Reg);
    //        }
    //        else
    //        {
    //            if (Convert.ToInt32(currindex.Value) > 0)
    //            {
    //                path = Server.MapPath("../Data/Sound");
    //                path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + Reg.RowId;
    //                DataProvider.Utility.CreateDirectory(path);
    //                path = path + "\\" + Reg.RowId + "_E.wav";
    //                path1 = Server.MapPath("../Data/Sound");
    //                path1 = path1 + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + currindex.Value;
    //                path1 = path1 + "\\" + currindex.Value + "_E.wav";
    //                System.IO.File.Copy(path1, path, true);
    //            }
    //        }
    //    }
    //    #endregion

    //    ClearText();
    //    NewMsgpop.Visible = true;
    //    NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
    //    string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
    //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    //    // arb, handle double click 
    //    btnSave.Enabled = false;
    //}

    // Generates a random number within a range.      


    private readonly Random _random = new Random();

    // Generates a random number within a range.      
    public int RandomNumber(int min, int max)
    {
        return _random.Next(min, max);
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        #region validation check for date , if not chech then return
        if (rdAtDueDate.Checked)
        {
            if (string.IsNullOrEmpty(txtDueDate.Text))
            {
                LblMsgBody.Text = "Please select due date ";
                DivMsg.Visible = true;
                DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
                //   ModalPopupLoyalty.Show();
                return;
            }
        }

        if (txtloyaltydtfrom.Text == "")
        {
            LblMsgBody.Text = "Please enter date from.";
            DivMsg.Visible = true;
            DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
            //ModalPopupLoyalty.Show();
            return;
        }
        if (txtloyaltydtto.Text == "")
        {
            LblMsgBody.Text = "Please enter date to.";
            DivMsg.Visible = true;
            DivMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            string script1 = @"setTimeout(function(){document.getElementById('" + DivMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
            // ModalPopupLoyalty.Show();
            return;
        }
        #endregion

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
            #region //** Add Auto cash transfer service id here
            if (Reg.Service_ID != "SRV1005" && Reg.Service_ID != "SRV1001" && Reg.Service_ID != "SRV1024" && Reg.Service_ID != "SRV1027")
            {

                subscribe_id = SQL_DB.ExecuteScalar("select top 1 subscribe_id from m_servicesubscription where pro_id='" + Reg.Pro_ID + "' and comp_id='" + Reg.Comp_ID + "' and service_id='" + Reg.Service_ID + "'");
            }
            #endregion
            else
            {
                subscribe_id = SQL_DB.ExecuteScalar("select top 1 subscribe_id from m_servicesubscription where pro_id='" + Reg.Pro_ID + "' and comp_id='" + Reg.Comp_ID + "' and service_id='" + Reg.Service_ID + "' and(start_order =" + ddlseriesstart.Text.Split('-')[0] + " and start_series =" + ddlseriesstart.Text.Split('-')[1] + ") and (end_order <=" + ddlseriesend.Text.Split('-')[0] + " and end_series <=" + ddlseriesend.Text.Split('-')[1] + ")");
            }
                if (subscribe_id != null)
                Reg.Subscribe_Id = subscribe_id.ToString();
            else
            {
             DataTable dtseubscription=SQL_DB.ExecuteDataTable("select * from m_servicesubscription where pro_id='" + Reg.Pro_ID + "' and comp_id='" + Reg.Comp_ID + "' and service_id='" + Reg.Service_ID + "'");
                Reg.Subscribe_Id = Utility.GetMyGenID("Subscription");
                DataRow dr = dtseubscription.Rows[0];
                dr["subscribe_id"] = Reg.Subscribe_Id;
                dr["start_order"] = ddlseriesstart.Text.Split('-')[0];
                dr["end_order"] = ddlseriesend.Text.Split('-')[0];
                dr["start_series"] = ddlseriesstart.Text.Split('-')[1];
                dr["end_series"] = ddlseriesend.Text.Split('-')[1];
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
            case "SRV1003":
                {
                    if (LogicForAdditonalGift(Reg, TrwdQty) == "error")
                        return;

                    break;
                }
            case "SRV1006":
                {

                    if (LogicForAdditonalGift(Reg, TrwdQty) == "error")
                        return;
                    break;
                }
            case "SRV1021":
                {
                    break;
                }
            case "SRV1023":
                {
                    if (!string.IsNullOrEmpty(txtWarranty.Text))
                    {
                        Reg.WarrantyPeriod = Convert.ToInt32(txtWarranty.Text);
                    }
                    else
                    {
                        Reg.WarrantyPeriod = 0;
                    }
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
        if (!string.IsNullOrEmpty(txtReferralLimit.Text))
        {
            Reg.ReferralLimit = Convert.ToInt32(txtReferralLimit.Text);
        }
        if (txtloyaltydtfrom.Text != "")
            Reg.DateFrom = Convert.ToDateTime(txtloyaltydtfrom.Text).ToString("yyyy/MM/dd hh:mm:ss tt");
        else
            Reg.DateFrom = null;
        if (txtloyaltydtto.Text != "")
            Reg.DateTo = Convert.ToDateTime(txtloyaltydtto.Text).ToString("yyyy/MM/dd hh:mm:ss tt");
        else
            Reg.DateTo = null;
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        if (chkconvert.Checked)
            Reg.IsCashConvert = 0;
        else
            Reg.IsCashConvert = 1;
        if (txtfrequency.Text.Trim().Replace("'", "''") != "")
            Reg.Frequency = Convert.ToInt32(txtfrequency.Text.Trim().Replace("'", "''"));
        else
            Reg.Frequency = 1;
        if (txtloyaltypoints.Text != "")
            Reg.Points = Convert.ToDecimal(txtloyaltypoints.Text);
        else
            Reg.Points = 0;

        if (ddlamttype.Text == "Random")
        {
            Reg.AmtType = "Random";
            Reg.totalloyalty = Convert.ToInt64(txttotalamount.Text);

            if (ddlseriesstart.Text == "" || (!ddlseriesstart.Text.Contains("-")))
            {
                Response.Write("<script langauge=\"javascript\">alert('Please Enter a valid start Series value.');</script>");
                goto end;
            }
            if (ddlseriesend.Text == "" || (!ddlseriesend.Text.Contains("-")))
            {
                Response.Write("<script langauge=\"javascript\">alert('Please Enter a valid end Series value.');</script>");
                goto end;
            }
            //txtcashamt.Text = RandomNumber(Convert.ToInt32(txtminval.Text), Convert.ToInt32(txtmaxval.Text)).ToString();
            if (!txtrangeval.Text.Contains("-"))
                Response.Write("<script langauge=\"javascript\">alert('Please Enter a valid Range value.');</script>");
            else
            {
                Reg.multiple = Convert.ToInt32(txtmultiple.Text);
                Reg.Minval = Convert.ToInt32(txtrangeval.Text.Split('-')[0]);
                Reg.Maxval = Convert.ToInt32(txtrangeval.Text.Split('-')[1]);
                if(Reg.multiple==0)
                {
                    Response.Write("<script langauge=\"javascript\">alert('Step Value van not be Zero.');</script>");
                    goto end;
                }
                if (Reg.multiple < Reg.Maxval)
                {
                    Reg.totalcode = Convert.ToInt64(SQL_DB.ExecuteScalar("select count(code1) from m_code (nolock) where [ScrapeFlag] is null and pro_id='" + ddlProduct.SelectedValue + "' and  concat(format(Series_Order,'000#'),format(Series_Serial,'000#'))>=" + ddlseriesstart.Text.Split('-')[0].PadLeft(4, '0') + ddlseriesstart.Text.Split('-')[1].PadLeft(4, '0') + " and concat(format(Series_Order,'000#'),format(Series_Serial,'000#'))<=" + ddlseriesend.Text.Split('-')[0].PadLeft(4, '0') + ddlseriesend.Text.Split('-')[1].PadLeft(4, '0') + "").ToString());
                    if (Reg.totalcode > 0)
                    {
                        if (((Reg.totalloyalty / Reg.totalcode) >= Reg.Minval) && ((Reg.totalloyalty / Reg.totalcode) <= Reg.Maxval))
                        {
                            Dictionary<int, int> codedistribute = ServiceLogic.loyaltydistribution(Reg);
                            foreach (KeyValuePair<int, int> item in codedistribute)
                            {
                                if (item.Key > 0)
                                {
                                    //SQL_DB.ExecuteNonQuery("insert into m_code_loyalty(code1,code2,loyalty,subscribe_id,service_id,pro_id,entry_date) select top " + item.Value + " code1,code2," + item.Key + ",'" + Reg.Subscribe_Id + "','" + ddlService.SelectedValue + "',pro_id,GETDATE() from M_Code(nolock) where pro_id='" + ddlProduct.SelectedValue + "' and  concat(format(Series_Order,'000#'),format(Series_Serial,'000#'))>=" + ddlseriesstart.Text.Split('-')[0].PadLeft(4, '0') + ddlseriesstart.Text.Split('-')[1].PadLeft(4, '0') + " and concat(format(Series_Order,'000#'),format(Series_Serial,'000#'))<=" + ddlseriesend.Text.Split('-')[0].PadLeft(4, '0') + ddlseriesend.Text.Split('-')[1].PadLeft(4, '0') + " ORDER BY Rand()");
                                    //Int64 val = Convert.ToInt64(SQL_DB.ExecuteScalar("select count(code1) from m_code_loyalty where pro_id='" + ddlProduct.SelectedValue + "'").ToString());

                                    //if (val > 0)
                                    ServiceLogic.insertcodeforloyalty(ddlProduct.SelectedValue, ddlseriesstart.Text.Split('-')[0].PadLeft(4, '0') + ddlseriesstart.Text.Split('-')[1].PadLeft(4, '0'), ddlseriesend.Text.Split('-')[0].PadLeft(4, '0') + ddlseriesend.Text.Split('-')[1].PadLeft(4, '0'), Reg.Subscribe_Id, ddlService.SelectedValue, item.Value, item.Key);
                                    //else
                                    //    SQL_DB.ExecuteNonQuery("insert into m_code_loyalty(code1,code2,loyalty,subscribe_id,service_id,pro_id,entry_date) select top " + item.Value + " code1,code2," + item.Key + ",'" + Reg.Subscribe_Id + "','" + ddlService.SelectedValue + "',pro_id,GETDATE() from M_Code(nolock) where pro_id='" + ddlProduct.SelectedValue + "' and  concat(format(Series_Order,'000#'),format(Series_Serial,'000#'))>=" + ddlseriesstart.Text.Split('-')[0].PadLeft(4, '0') + ddlseriesstart.Text.Split('-')[1].PadLeft(4, '0') + " and concat(format(Series_Order,'000#'),format(Series_Serial,'000#'))<=" + ddlseriesend.Text.Split('-')[0].PadLeft(4, '0') + ddlseriesend.Text.Split('-')[1].PadLeft(4, '0') + " ORDER BY Rand()");
                                    ////SQL_DB.ExecuteNonQuery("insert into m_code_loyalty(code1,code2,loyalty,subscribe_id,service_id,pro_id,entry_date) select top " + item.Value + " code1,code2," + item.Key + ",'" + Reg.Subscribe_Id + "','" + ddlService.SelectedValue + "',pro_id,GETDATE() from M_Code(nolock) where concat(code1,code2) not in (select concat(code1,code2) from m_code_loyalty(nolock)  where subscribe_id='" + Reg.Subscribe_Id + "' and service_id='" + ddlService.SelectedValue + "' and pro_id='" + ddlProduct.SelectedValue + "' ) and pro_id='" + ddlProduct.SelectedValue + "'  ORDER BY Rand()");
                                }
                            }
                        }
                        else
                        {
                            Response.Write("<script langauge=\"javascript\">alert('Amount can not be distribute as per range');</script>");
                            goto end;
                        }
                        //"select top 8300  mc.code1,mc.code2,5,'SSI1489','SRV1001',mc.pro_id,GETDATE() from M_Code(nolock) mc inner join m_code_loyalty ml on mc.code1<>ml.code1 and mc.code2<>ml.code2 where mc.pro_id='AD55' and subscribe_id=" + Reg.Subscribe_Id + "'' and service_id='SRV1001' ORDER BY RAND() "
                    }
                    else
                    {
                        Response.Write("<script langauge=\"javascript\">alert('Please Enter a valid Range value. Total Record can not be zero.');</script>");
                        goto end;
                    }
                }
                else
                {
                    Response.Write("<script langauge=\"javascript\">alert('step value can not be more than max value.');</script>");
                    goto end;
                }
            }
            }
        else
        {
            Reg.AmtType = "Fixed";
            Reg.Minval = 0;
            Reg.Maxval = 0;
            
        }

        if (txtcashamt.Text != "")
            Reg.IsCash = Convert.ToInt32(txtcashamt.Text);
        else
            Reg.IsCash = 0;
        Reg.Comments = txtCommentsTxt.Text.Trim().Replace("'", "''");
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

        #region Code For Referral
        if ((rdIsRefCash.Checked) || (rdIsRefPoints.Checked) || (rdIsRefGift.Checked))
        {

            Ref.Trans_Id = Reg.Trans_ID;
            Ref.SST_Id = Reg.RowId;
            Ref.DML = Reg.DML;
            if (rdIsRefGift.Checked)
            {
                Reg.IsReferral = 3;
                Ref.GiftReferral = ddlrefGiftFrom.SelectedValue.Trim().Split('*')[0];
                Ref.GiftUsers = ddlrefGiftTo.SelectedValue.Trim().Trim().Split('*')[0];
            }
            else if (rdIsRefPoints.Checked)
            {
                Reg.IsReferral = 2;
                Ref.PointsReferral = Convert.ToInt64(txtreffrom.Text.Trim());
                Ref.PointsUsers = Convert.ToInt64(txtrefto.Text.Trim());
                if (chkRefIsCash.Checked)
                    Ref.IsCashConvert = 0;
                else
                    Ref.IsCashConvert = 1;
            }
            else if (rdIsRefCash.Checked)
            {
                Reg.IsReferral = 1;
                Ref.IsCashReferral = Convert.ToInt64(txtreffrom.Text.Trim());
                Ref.IsCashUsers = Convert.ToInt64(txtrefto.Text.Trim());
            }
        }
        else
        {
            Reg.IsReferral = 0;
            Ref = new Referral();
        }
        Reg.Referrals = Ref;
        #endregion
        DateTime? dttxtDueDate = null;
        if (!string.IsNullOrEmpty(txtDueDate.Text))
        {
            dttxtDueDate = DateTime.Parse(txtDueDate.Text);
            Reg.dttxtDueDate = dttxtDueDate;
        }


        Loyalty_Programm.InsUpdSrvForProduct(Reg); //[M_ServiceSubscriptionTrans] having inset/update

        AddSetting(Reg.RowId);
        #region Save for Sound File
        if (IsSound == 0)
        {
            string path = Server.MapPath("../Data/Sound"); string path1 = Server.MapPath("../Data/Sound");
            if (flSoundH.FileName != "")
            {
                path = Server.MapPath("../Data/Sound");
                path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + Reg.RowId;
                DataProvider.Utility.CreateDirectory(path);
                path = path + "\\" + Reg.RowId + "_H.wav";
                flSoundH.SaveAs(path);
                Reg.DMLs = "H";
                Loyalty_Programm.UpdateFiles(Reg);
            }
            else
            {
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
            }
            if (flSoundE.FileName != "")
            {
                path = Server.MapPath("../Data/Sound");
                path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + Reg.Pro_ID + "\\Service\\" + Reg.RowId;
                DataProvider.Utility.CreateDirectory(path);
                path = path + "\\" + Reg.RowId + "_E.wav";
                flSoundE.SaveAs(path);
                Reg.DMLs = "E";
                Loyalty_Programm.UpdateFiles(Reg);
            }
            else
            {
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
    private void AddSetting(Int64 M_ServiceSubscriptionId)
    {
        XmlDocument xmldoc = new XmlDocument();
        XmlElement xmlrootelement = xmldoc.CreateElement("Tab");
        xmldoc.AppendChild(xmlrootelement);
       // int i = 0;
         for (int i = 0; i < GrdVw.Rows.Count; i++)
        {
            //   if (lstProfileItemId.Split(',')[i].Length > 0)
            {
                //string chk1 = ((CheckBox)GrdVw.Rows[indx - 1].FindControl("lblTypeName")).Text;
                //string chk2 = ((CheckBox)GrdVw.Rows[indx].FindControl("lblTypeName")).Text;
                //string lblTTUserTypeid1 = ((Label)GrdVw.Rows[indx - 1].FindControl("lblTTUserTypeid")).Text;
                //string lblTTUserTypeid2 = ((Label)GrdVw.Rows[indx].FindControl("lblTTUserTypeid")).Text;
                //DropDownList ddl1 = (DropDownList)GrdVw.Rows[indx - 1].FindControl("ddl1");
                //DropDownList ddl2 = (DropDownList)GrdVw.Rows[indx].FindControl("ddl1");
                int k = 1;
                bool blnChannelName = ((CheckBox)GrdVw.Rows[i].FindControl("lblTypeName")).Checked;
                if (blnChannelName)
                {
                    XmlElement child = xmldoc.CreateElement("id");
                    // note : lblTTUserTypeid is coming from 3 tables "ProductionUnit", "Channels","UserType_TrackTrace"
                    child.SetAttribute("Typeid", ((Label)GrdVw.Rows[i].FindControl("lblTTUserTypeid")).Text); 

                    child.SetAttribute("TypeName", ((CheckBox)GrdVw.Rows[i].FindControl("lblTypeName")).Text);
                    // note : data is coming from Dealer table, productionunit, channels (for warehouse)
                    child.SetAttribute("Typevalue", ((DropDownList)GrdVw.Rows[i].FindControl("ddl1")).SelectedItem.Value);
                    child.SetAttribute("orderno", (k).ToString());

                    child.SetAttribute("index", (i + 1).ToString());
                    xmlrootelement.AppendChild(child);
                    k++;
                }
               
            }

        }

        string xmlLibraryList = xmldoc.OuterXml;
        DateTime Createddate = Convert.ToDateTime(DataProvider.LocalDateTime.Now);//.ToString("yyyy/MM/dd hh:mm:ss tt");
        DataSet ds = ExecuteNonQueryAndDatatable.TrackTraceInsert(Createddate, ProjectSession.strCompanyid, xmlLibraryList, M_ServiceSubscriptionId);
        //  if (lstProfileItemId.Split(',').Length >= 1)
        //   {
        //       objTabProfileItemBAL.Insert(xmlLibraryList);
        //    }
    }
    protected void imgNew_Click1(object sender, EventArgs e)
    {
        Response.Redirect("AddServiceSettings.aspx");
    }


    protected void ddlService_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlService.SelectedValue != "0")
        {
            ShowDiv(true);
            //  selsrvid.Value = ((ImageButton)sender).AlternateText;
            hdnisaddi.Value = string.Empty; hdnsstid.Value = string.Empty; hdnprizetransid.Value = string.Empty;
            //Label2.Text = string.Empty; NewMsgpop.Visible = false;
            //  txtdtfromamc1.Text = Convert.ToDateTime(System.DateTime.Now.AddDays(1)).ToString("dd/MM/yyyy");

            #region //** Add service id for "Auto Cash Transfer" as 'SRV1027'
            if (ddlService.SelectedValue=="SRV1001"|| ddlService.SelectedValue == "SRV1024"|| ddlService.SelectedValue == "SRV1005" || ddlService.SelectedValue == "SRV1027")
            {
                seriestart.Visible = true;
                seriesend.Visible = true;
                serieslabel.Visible = true;
            }
            #endregion
            else
            {
                seriestart.Visible = false;
                seriesend.Visible = false;
                serieslabel.Visible = false;
            }
            fillProductLoyalty(true, ddlProduct);
            string ServiceId = ddlService.SelectedValue;
            #region Logic For Additional
            DataTable dt = SQL_DB.ExecuteDataSet("SELECT ServiceFeaure_ID, Service_ID,(SELECT ServiceName FROM M_Service WHERE Service_ID = M_ServiceFeature.Service_ID) ServiceName, IsPoints, IsDateRange, IsSound, IsFrequency, IsAdditionalGift, IsMessageTemplete,IsCoupons, EntryDate, IsDelete,IsRandom FROM M_ServiceFeature WHERE IsDelete = 0 AND Service_ID = '" + ServiceId + "' ").Tables[0];
            if (dt.Rows.Count > 0)
            {
                //int IsAdditionalGift = 0;
                //IsAdditionalGift = Convert.ToInt32(dt.Rows[0]["IsAdditionalGift"].ToString());
                int IsAdditionalGift = 1, IsCoupons = 1;
                IsAdditionalGift = Convert.ToInt32(dt.Rows[0]["IsAdditionalGift"].ToString());
                IsCoupons = Convert.ToInt32(dt.Rows[0]["IsCoupons"].ToString());
                if (IsAdditionalGift == 0)
                {
                    txttcodesrand.Enabled = false; txtrand.Enabled = false;
                    rdAtDueDate.Checked = false; rdInstant.Checked = true;
                    rdRandom.Checked = false; rdAllParticipant.Checked = false; rdFirstRandomnth.Checked = false; rdFirstnth.Checked = true;
                    rdAllton.Checked = false; rdAlltoAll.Checked = false; rdFirstnton.Checked = false; rdAlltonthrand.Checked = true;
                    rdSequenceDistri.Checked = false; rdRandomDistri.Checked = true;
                    txttcodes.Text = string.Empty; txtnth.Text = string.Empty;
                    txttcodes.Enabled = true; txtnth.Enabled = true;
                    txttcodesrand.Text = string.Empty; txtrand.Text = string.Empty;
                    txteverynth.Text = string.Empty; txteverywin.Text = string.Empty;
                    txteverynth.Enabled = false; txteverywin.Enabled = false;
                    btnGSave.Text = "Save";
                   // divinstant.Visible = true; divduedate.Visible = false;
                    Instant(true);
                    Duedate(false);

                    reqnth.ValidationGroup = "SRVS"; txttcodes.ValidationGroup = "SRVS";
                    reqtcodesrand.ValidationGroup = "NN"; reqrand.ValidationGroup = "NN";
                    txteverynth.ValidationGroup = "NN"; txteverywin.ValidationGroup = "NN";
                    reqallpFirstn.ValidationGroup = "NN"; reqallpFirstnton.ValidationGroup = "NN";
                    reqalltonth.ValidationGroup = "NN"; reqrandfreq.ValidationGroup = "NN";
                    reqalltonCustomer.ValidationGroup = "NN";
                    ChkInfinite.Enabled = false;
                    txtGiftQty.Text = string.Empty;
                    if (IsCoupons == 0)
                    {
                        #region Check Coupon
                        string ChkQry = "SELECT * FROM (SELECT SUM(m.CouponCount) TotalCount,(SELECT COUNT(Coupon_ID) FROM M_CouponCodes WHERE Comp_ID = '" + Session["CompanyId"].ToString() + "' AND isnull(SST_ID,'') = '' GROUP BY Comp_ID) as UseCount FROM M_CouponRequest AS m WHERE m.Comp_ID = '" + Session["CompanyId"].ToString() + "' AND m.IsAdminVerify = 1 AND IsDelete = 0) REG WHERE REG.UseCount > 0";
                        DataTable td = SQL_DB.ExecuteDataTable(ChkQry);// ("SELECT * FROM M_CouponRequest WHERE Comp_ID = '" + Session["CompanyId"].ToString() + "' AND IsAdminVerify = 1 AND IsDelete = 0").Tables[0];
                        if (td.Rows.Count == 0)
                        {
                            Label2.Text = "Please request for coupon first (In Left Menu -> Transaction Setting -> Coupon Request Master)";
                            NewMsgpop.Visible = true;
                            NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
                            string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},20000);";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                            return;
                        }
                        #endregion
                    //    rdAllParticipant.Enabled = true;
                    //    rdAlltoAll.Enabled = true;
                    }
                    else
                    {
                     //   rdAllParticipant.Enabled = false;
                     //   rdAlltoAll.Enabled = false;
                    }
                }
                else
                {
                    rdInstant.Checked = false; rdAtDueDate.Checked = false;
                    rdRandomDistri.Checked = false; rdSequenceDistri.Checked = false;
                    rdFirstnth.Checked = false; rdRandom.Checked = false; rdAllParticipant.Checked = false; rdFirstRandomnth.Checked = false;
                    rdFirstnton.Checked = false; rdAlltonthrand.Checked = false; rdAllton.Checked = false; rdAlltoAll.Checked = false;
                    reqnth.ValidationGroup = "NN"; txttcodes.ValidationGroup = "NN";
                    reqtcodesrand.ValidationGroup = "NN"; reqrand.ValidationGroup = "NN";
                    txteverynth.ValidationGroup = "NN"; txteverywin.ValidationGroup = "NN";
                    reqallpFirstn.ValidationGroup = "NN"; reqallpFirstnton.ValidationGroup = "NN";
                    reqalltonth.ValidationGroup = "NN"; reqrandfreq.ValidationGroup = "NN";
                    reqalltonCustomer.ValidationGroup = "NN";

                }
                // code for Track and trace
                //if (dt.Rows[0]["Service_ID"].ToString() == "SRV1021")
                //{
                //    divTNT1.Visible = true;
                //}
                    
            }
            #endregion
            CheckValidation(ServiceId);
            FillPlanMasterGrid(ServiceId, 0);
            FillGiftddl(ddlAddGift, ServiceId);
            Obj = new List<Gifts>();
            FillGiftDetails(GrdVwGift, 1);
            btnSave.Text = "Save";
            FillchkTT();
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

    protected void GrdVw_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int indx = Convert.ToInt32(e.CommandArgument.ToString());
        if (e.CommandName == "up")
        {
            string chk1 = ((CheckBox)GrdVw.Rows[indx - 1].FindControl("lblTypeName")).Text;
            string chk2 = ((CheckBox)GrdVw.Rows[indx].FindControl("lblTypeName")).Text;
            string lblTTUserTypeid1 = ((Label)GrdVw.Rows[indx - 1].FindControl("lblTTUserTypeid")).Text;
            string lblTTUserTypeid2 = ((Label)GrdVw.Rows[indx].FindControl("lblTTUserTypeid")).Text;
            DropDownList ddl1 = (DropDownList)GrdVw.Rows[indx - 1].FindControl("ddl1");
            DropDownList ddl2 = (DropDownList)GrdVw.Rows[indx].FindControl("ddl1");

            ((CheckBox)GrdVw.Rows[indx - 1].FindControl("lblTypeName")).Text = chk2;
            ((CheckBox)GrdVw.Rows[indx].FindControl("lblTypeName")).Text = chk1;

            ((Label)GrdVw.Rows[indx - 1].FindControl("lblTTUserTypeid")).Text = lblTTUserTypeid2;
            ((Label)GrdVw.Rows[indx].FindControl("lblTTUserTypeid")).Text = lblTTUserTypeid1;

            BindGridDropDown(chk2, ddl1, "");
            BindGridDropDown(chk1, ddl2, "");

        }
        if (e.CommandName == "down")
        {
            string chk1 = ((CheckBox)GrdVw.Rows[indx].FindControl("lblTypeName")).Text;
            string chk2 = ((CheckBox)GrdVw.Rows[indx + 1].FindControl("lblTypeName")).Text;
            DropDownList ddl1 = (DropDownList)GrdVw.Rows[indx].FindControl("ddl1");
            DropDownList ddl2 = (DropDownList)GrdVw.Rows[indx + 1].FindControl("ddl1");

            string lblTTUserTypeid1 = ((Label)GrdVw.Rows[indx].FindControl("lblTTUserTypeid")).Text;
            string lblTTUserTypeid2 = ((Label)GrdVw.Rows[indx + 1].FindControl("lblTTUserTypeid")).Text;

            ((CheckBox)GrdVw.Rows[indx].FindControl("lblTypeName")).Text = chk2;
            ((CheckBox)GrdVw.Rows[indx + 1].FindControl("lblTypeName")).Text = chk1;

            ((Label)GrdVw.Rows[indx].FindControl("lblTTUserTypeid")).Text = lblTTUserTypeid2;
            ((Label)GrdVw.Rows[indx + 1].FindControl("lblTTUserTypeid")).Text = lblTTUserTypeid1;

            BindGridDropDown(chk2, ddl1, "");
            BindGridDropDown(chk1, ddl2, "");

        }
    }

    protected void GrdVw_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // Find the drop-down (say in 3rd column)

            //BindUT("Distributor", ddlDis);
            //BindUT("Sub-Distributor", ddlSDis);
            //BindUT("Retailer", ddlret);
            //BindListboxproductionunit(); BindListboxchannels();

            string lbl1 = ((CheckBox)e.Row.FindControl("lblTypeName")).Text;
            string lblTypevalue = ((Label)e.Row.FindControl("lblTypevalue")).Text;
            DropDownList ddl = (DropDownList)e.Row.FindControl("ddl1");
            BindGridDropDown(lbl1, ddl,lblTypevalue);

        }
    }
    public void BindGridDropDown(string lbl1, DropDownList ddl,string ddlvalue)
    {
        if (lbl1 == "Production Unit")
        {
            BindListboxproductionunit(ddl, ddlvalue);
        }
        else if (lbl1 == "Warehouse")
        {
            BindListboxchannels(ddl, ddlvalue);
        }
        else
        {
            BindUT(lbl1, ddl, ddlvalue);
        }
    }

    protected void ddlamttype_SelectedIndexChanged(object sender, EventArgs e)
    {
        divshow();
    }

    public void divshow()
    {
        if (ddlamttype.Text == "Fixed")
        {
            diviscash.Visible = true;
            divrange.Visible = false;
            divrange1.Visible = false;
            stepvalue.Visible = false;
            if (ddlService.SelectedValue == "SRV1001")
            {
                divispoints.Visible = true;
                RFVIsPoints.ValidationGroup = "SRVS";
                diviscash.Visible = false;
                RFVIsCash.ValidationGroup = "NN";
            }
            else
            {
                divispoints.Visible = false;
                RFVIsPoints.ValidationGroup = "NN";
                diviscash.Visible = true;
                RFVIsCash.ValidationGroup = "SRVS";
            }
        }
        else if (ddlamttype.Text == "Random")
        {
            diviscash.Visible = false;
            divrange.Visible = true;
            divispoints.Visible = false;
            stepvalue.Visible = true;
            divrange1.Visible = true;
        }
        else
        {
            diviscash.Visible = false;
            divrange.Visible = false;
            stepvalue.Visible = false;
            divrange1.Visible = false;

        }
    }

    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
    //    DataTable dt = new DataTable();
    //    dt = SQL_DB.ExecuteDataTable("select  concat(series_order,'-',series_Serial) series from m_code where pro_id='" + ddlProduct.SelectedValue + "' order by series_order,series_Serial");
    //    DataProvider.MyUtilities.FillsingleDDLInsertZeroIndexString(dt, "series", "series", ddlseriesstart, "--Select start series--");
    //    DataProvider.MyUtilities.FillsingleDDLInsertZeroIndexString(dt, "series", "series", ddlseriesend, "--Select end series--");
    }
   

    
}