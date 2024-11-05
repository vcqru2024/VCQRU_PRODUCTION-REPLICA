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
using System.Data.SqlClient;
using System.Text;
using Business_Logic_Layer;
using System.Web.Services;
using System.Web.Script.Services;

public partial class GiftDispatchBy : System.Web.UI.Page
{
    public int index = 0, index1 = 0;  public static int sno = 0, isdis = 0, isdel = 0; public static string dis = "", awname = ""; public static int str = 0, IDisp = 0, IDel = 0; public static int Rcnt = 0, roid = 0;
    // public string server = Convert.ToString(ConfigurationManager.ConnectionStrings["ServerName"].ConnectionString), userID = Convert.ToString(ConfigurationManager.ConnectionStrings["UserNameDspth"].ConnectionString), password = Convert.ToString(ConfigurationManager.ConnectionStrings["Password"].ConnectionString);
    public string srt = DataProvider.Utility.FindMailBody();

  
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["User_Type"] == null)
            Response.Redirect("../Info/Login.aspx?Page=FrmAwardCourierDispatch.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {

            newMsg.Visible = false;
            Fillddl();
           // FillGrdMain();
           
            
        }
    }
    public void UpdateByCourierOrDealer(string strType)
    {

        //string[] listGift_Pkid = Gift_Pkid;
        //string[] listConsumer_Pkid = Consumer_Pkid;
        //string[] listCodeConsumer_Pkid = CodeConsumer_Pkid;
        // string str = "";
        string strGift_Pkid = string.Empty;
        string strConsumer_Pkid = string.Empty;
        string strCodeConsumer_Pkid = string.Empty;
       string sst_id = string.Empty;
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            GridViewRow gvr = GridView1.Rows[i];
            if (((CheckBox)gvr.FindControl("childchk2")).Checked == true)
            {
                strCodeConsumer_Pkid = strCodeConsumer_Pkid + "," + ((Label)gvr.FindControl("M_Consumer_MCodeid")).Text;
                strConsumer_Pkid = strConsumer_Pkid + "," + ((Label)gvr.FindControl("M_Consumerid")).Text;
                strGift_Pkid = strGift_Pkid + "," + ((Label)gvr.FindControl("Gift_Pkid")).Text;
                sst_id = sst_id + "," + ((Label)gvr.FindControl("sst_id")).Text;
            }
        }
       
        strGift_Pkid = strGift_Pkid.TrimStart(',').TrimEnd(',');
        strConsumer_Pkid = strConsumer_Pkid.TrimStart(',').TrimEnd(',');
        strCodeConsumer_Pkid = strCodeConsumer_Pkid.TrimStart(',').TrimEnd(',');
        sst_id = sst_id.TrimStart(',').TrimEnd(',');

        if (strCodeConsumer_Pkid.Length > 0)
        {
            if (strType == "dealer")
            {
                ExecuteNonQueryAndDatatable.Proc_InsUpdtGiftDispatch(strGift_Pkid, strConsumer_Pkid, strType, Convert.ToInt32(ddlDealer.SelectedValue), null, null,
                    ProjectSession.strCompanyid, strCodeConsumer_Pkid, sst_id, ddlService.SelectedValue);
            }
            else if (strType == "courier")
            {
                ExecuteNonQueryAndDatatable.Proc_InsUpdtGiftDispatch(strGift_Pkid, strConsumer_Pkid, strType, Convert.ToInt32(ddlCourierCompany.SelectedValue), Convert.ToDateTime(txtDispatchDate.Text)
                    , Convert.ToDateTime(txtExpectedDate.Text), ProjectSession.strCompanyid, strCodeConsumer_Pkid, sst_id, ddlService.SelectedValue);
            }
        }
        else
        {
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            lblmsgHeader.Text = "None of the item(consumer) is selected to dispatch gift.";
            string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }

    }
    protected void Button10_Click(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            UpdateByCourierOrDealer("courier");
            Response.Redirect("FrmAwardCourierDispatch.aspx");
        }
        else
        {

            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            lblmsgHeader.Text = "Please select any service and do search to fill consumer details in below for dispatching gift.";
            string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
    }
     
    protected void Button11_Click(object sender, EventArgs e)
    {
       
        if (GridView1.Rows.Count > 0)
        {
            UpdateByCourierOrDealer("dealer");
            Response.Redirect("FrmAwardCourierDispatch.aspx");
        }
        else
        {
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            lblmsgHeader.Text = "Please select service and search to fill gift to dispatch.";
            string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
    }



    protected void Button2_Click1(object sender, EventArgs e)
    {
        Response.Redirect("~/Manufacturer/FrmAwardCourierDispatch.aspx");
    }
    private void FillGrdMain()
    {
       
        string strQry = string.Empty;

        //DateTime? dtfrom = null;
        //if (!string.IsNullOrEmpty(txtDateFrom.Text))
        //{
        //    dtfrom = DateTime.Parse(txtDateFrom.Text);
        //}
        //DateTime? dtTo = null;
        //if (!string.IsNullOrEmpty(txtDateto.Text))
        //{
        //    dtTo = DateTime.Parse(txtDateto.Text);
        //}
        //if (ddlService.SelectedValue == "SRV1001")
        //{
        //    GridView1.DataSource = null;
        //    GridView1.DataBind();          
        //}
        //else
        {
            DataSet dsset = ExecuteNonQueryAndDatatable.GetAwardListByReffleBuildReferral(ddlproname.SelectedValue, Convert.ToInt32(ddlAward.SelectedValue), txtMobile.Text, ProjectSession.strCompanyid, null, "", ddlService.SelectedValue);
            GridView1.DataSource = dsset.Tables[0];
            GridView1.DataBind();
        }
        lblcount.Text = GridView1.Rows.Count.ToString();
        if (GridView1.Rows.Count > 0)
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
        //        DataSet dsamc = function9420.FillGridPlan(Amc);
        //DataSet ds = function9420.FillGridPlan(i);
        // DataView dv = dsamc.Tables[0].DefaultView;
        // dv.RowFilter = "Flag = 1";
        // DataTable dt = dv.ToTable();
        //DataTable dt = dsset.Tables[0];
    }
    private void Fillddl()
    {
        
        ExecuteNonQueryAndDatatable.FillProduct(ProjectSession.strCompanyid,ddlproname, "'SRV1001','SRV1006','SRV1020'");
        DataSet ds = ExecuteNonQueryAndDatatable.GetGiftByCompany(ProjectSession.strCompanyid);
        if (ds.Tables.Count > 2)
        {
            DataTable dtGidt = ds.Tables[0];
            DataProvider.MyUtilities.FillDDLInsertBlankIndexWithZero(dtGidt, "Gift_Pkid", "GiftName", ddlAward, "--Select--");
            DataTable dtDealer = ds.Tables[1];
            DataProvider.MyUtilities.FillDDLInsertZeroIndexIntValBy(dtDealer, "Row_Id", "Dealer_Name", ddlDealer, "--Select--");
            DataTable dtCourier = ds.Tables[2];
            DataProvider.MyUtilities.FillDDLInsertZeroIndexIntValBy(dtCourier, "CourierPkid", "Courier_Name", ddlCourierCompany, "--Select--");

        }
        
     //   DataSet ds = function9420.FillCorierCompanyM(Session["CompanyId"].ToString());
      //  DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Courier_ID", "Courier_Name", DDLCourierCompany, "--Select--");
      //  DDLCourierCompany.SelectedIndex = 0;
       // Loyalty_Awards obj = new Loyalty_Awards();
      //  obj.Comp_ID = Session["CompanyId"].ToString();
      //  DataSet dt = Loyalty_Awards.FillMyAwards(obj);
      //  DataProvider.MyUtilities.FillDDLInsertZeroIndexIntVal(dt, "RowId", "AwardName", ddlAwards, "--Select--");
      //  ddlAwards.SelectedIndex = 0;
      //  if (dt.Tables[0].Rows.Count > 0)
      //      Rcnt = Convert.ToInt32(dt.Tables[0].Rows.Count);
    }
    //private void FillAwards(Loyalty_Dispatch obj)
    //{
    //    obj.Comp_ID = Session["CompanyId"].ToString();
    //    DataSet dt = Loyalty_Awards.FillMyAwards(obj);
    //    if (dt.Tables[0].Rows.Count > 0)
    //    {
    //        awname = dt.Tables[0].Rows[0]["AwardName"].ToString();
    //        roid = Convert.ToInt32(dt.Tables[0].Rows[0]["RowId"]);
    //    }
    //}
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        // Response.Redirect("~/Manufacturer/GiftDispatch.aspx");
        //TxtClear();
        //DivNewMsg.Visible = false;
        //newMsg.Visible = false;
        //ModalPopupExtenderNewDesign.Show();
    }
    protected void BtnSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdMain();
    }
    protected void BtnRefesh_Click(object sender, ImageClickEventArgs e)
    {
        ddlService.SelectedIndex = 0;
        ddlproname.SelectedIndex = 0;
        ddlAward.SelectedIndex = 0;
        txtMobile.Text = "";
        
        //FillGrdMain();
    }
    protected void btnCourierSubmit_Click(object sender, EventArgs e)
    {
        //string script = "";
        //if (txtTrackingNo.Text == "")
        //{
        //    DivNewMsg.Visible = true;
        //    DivNewMsg.Attributes.Add("class", "alert_boxes_pink");
        //    lblpopmsg.Text = "Please add Product information in Courier !  <span style='color:green;'>Click For add Details : </span><img style='position: fixed;' alt='' src='images/add_new.png' />";
        //    ModalPopupExtenderNewDesign.Show();
        //    script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //    return;
        //}
        //Loyalty_Dispatch Reg = new Loyalty_Dispatch();
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //Reg.Courier_ID = DDLCourierCompany.SelectedValue.ToString();
        //Reg.Courier_Name = DDLCourierCompany.SelectedItem.Text;
        //Reg.Tracking_No = txtTrackingNo.Text.Trim().Replace("'", "''");
        //Reg.Dispatch_Date = Convert.ToDateTime(Convert.ToDateTime(txtDispatchDate.Text).ToString("yyyy/MM/dd hh:mm:ss tt"));
        //Reg.Expected_Date = Convert.ToDateTime(Convert.ToDateTime(txtExpectedDate.Text).ToString("yyyy/MM/dd hh:mm:ss tt"));
        //Reg.Dispatch_Location = txtDispLocation.Text.Trim().Replace("'", "''");
        //Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        //Reg.Courier_Status = 0;
        //Reg.Received_Flag = 0;
        //Reg.Admin_Reason = "";
        //Reg.Consumer_Reason = "";
        //Reg.RefRowId = Convert.ToInt64(ddlAwards.SelectedValue);
        //if (btnCourierSubmit.Text == "Save")
        //{
        //    Reg.RowId = 0;
        //    Reg.DML = "I";
        //    DivNewMsg.Visible = true;
        //    DivNewMsg.Attributes.Add("class", "alert_boxes_green");
        //    lblpopmsg.Text = "This awards dispatch successfully!";
        //    ModalPopupExtenderNewDesign.Show();
        //    script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //}
        //else
        //{
        //    Reg.RowId = Convert.ToInt64(lblCourierId.Text);
        //    Reg.DML = "U";
        //    newMsg.Visible = true;
        //    newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        //    lblmsgHeader.Text = "This awards dispatch updated successfully!";
        //    script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //}
        //Loyalty_Dispatch.InsertUpdateDispatchDetails(Reg);
        //TxtClear();
        //FillGrdMain();
    }
    [WebMethod]
    [ScriptMethod]
    public static bool MethodChkTrackingNo(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT  TransactionNo FROM T_DistributedAwardDetails WHERE TransactionNo = '" + res.Trim().Replace("'","''") + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
  
    protected void ddlDeliveryBy_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (ddlDeliveryBy.SelectedValue == "Dealer")
        //{
        //    GrdVwDealer.Visible = true;
        //    GrdCourierDispatch.Visible = false;
        //}
        //else
        //{
        //    GrdCourierDispatch.Visible = true;
        //    GrdVwDealer.Visible = false;
        //}
        //FillGrdMain();
    }
    private void FillProductDetails()
    {
        //DataSet ds = new DataSet();
        //if (GrdCourierDispatch.Rows.Count > 0)
        //{
        //    for (int i = 0; i < GrdCourierDispatch.Rows.Count; i++)
        //    {
        //        Label CourierDispID = (Label)GrdCourierDispatch.Rows[i].FindControl("lblCDispID");
        //        Object9420 obj = new Object9420();
        //        obj.Courier_Disp_ID = CourierDispID.Text;
        //        ds = SQL_DB.ExecuteDataSet("SELECT m.Dispatch_Location FROM  Awards_Dispatch_Master AS m WHERE m.RowId = " + Convert.ToInt64(obj.Courier_Disp_ID) + " ");
        //        GridView Grd = (GridView)GrdCourierDispatch.Rows[i].FindControl("GrdLablelDet");
        //        Grd.DataSource = ds.Tables[0];
        //        Grd.DataBind();
        //    }
        //}
    }
    protected void btnCourierReset_Click(object sender, EventArgs e)
    {
        //TxtClear(); DivNewMsg.Visible = false;
        //newMsg.Visible = false; ModalPopupExtenderNewDesign.Show();
    }
    protected void GrdCourierDispatch_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //newMsg.Visible = false;
        //GrdCourierDispatch.PageIndex = e.NewPageIndex;
        //FillGrdMain();
    }
    protected void GrdCourierDispatch_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //Loyalty_Dispatch Reg = new Loyalty_Dispatch(); newMsg.Visible = false; DivNewMsg.Visible = false;
        //lblCourierId.Text = e.CommandArgument.ToString();
        //Reg.RowId = Convert.ToInt64(lblCourierId.Text);
        //Reg.Courier_Name = "";
        //DataSet ds = SQL_DB.ExecuteDataSet("SELECT m.* FROM  Awards_Dispatch_Master AS m WHERE m.RowId = " + Convert.ToInt64(Reg.RowId) + " ");
        //if (e.CommandName == "CourierEdit")
        //{
        //    ddlAwards.Enabled = false;
        //    Reg.Tracking_No = ds.Tables[0].Rows[0]["Tracking_No"].ToString();
        //    FillCourierCompany();
        //    FillAwards(Reg);
        //    //ddlAwards.Items.Insert(Rcnt, awname);           
        //    ddlAwards.Items.Add(new ListItem { Text = awname, Value = roid.ToString() });
        //    ddlAwards.SelectedValue = roid.ToString();
        //    DDLCourierCompany.SelectedValue = ds.Tables[0].Rows[0]["Courier_ID"].ToString();
        //    txtTrackingNo.Text = ds.Tables[0].Rows[0]["Tracking_No"].ToString();
        //    txtDispatchDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["Dispatch_Date"].ToString()).ToString("dd/MM/yyyy");
        //    txtExpectedDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["Expected_Date"].ToString()).ToString("dd/MM/yyyy");
        //    txtDispLocation.Text = ds.Tables[0].Rows[0]["Dispatch_Location"].ToString();
        //    btnCourierSubmit.Text = "Update";
        //    ModalPopupExtenderNewDesign.Show();
        //}
        //else if (e.CommandName == "CourierDelete")
        //{
        //    newMsg.Visible = true;
        //    LabelAlertheader.Text = "Alert";
        //    LabelAlertText.Text = "Are you sure to dalete  <span style='color:blue;' >" + Reg.Courier_Name + "</span>  Courier Dispatch Order ?";
        //    btnYesActivation.Text = "Yes";
        //    btnYesActivation.Visible = true;
        //    btnNoActivation.Visible = true;
        //    ModalPopupExtenderAlert.Show();
        //    string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //}
        //else if (e.CommandName == "ReceiveCourier")
        //{
        //    newMsg.Visible = false;
        //    LabelAlertheader.Text = "Alert";
        //    LabelAlertText.Text = "Are you sure to receive  <span style='color:blue;' >" + Reg.Courier_Name + "</span>  Courier Dispatch Order ?";
        //    btnYesActivation.Text = "Yes";
        //    ReceiveModalPopup.Show();
        //    //string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        //    //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //}
    }
    protected void ddlAwards_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (ddlAwards.SelectedIndex > 0)
        //{
        //    Div1.Visible = false;
        //    DataTable dt = SQL_DB.ExecuteDataSet("SELECT RowId, User_ID,Comp_ID, Dealer_ID, TransactionNo, Delivery_Type, IsDelivered, Remarks, Cash_Amount, Entry_Date, Award_Key FROM T_DistributedAwardDetails WHERE RowId = " + Convert.ToInt64(ddlAwards.SelectedValue) + " ").Tables[0];
        //    if (dt.Rows.Count > 0)
        //    {
        //        string Address = "";
        //        DataTable dst = SQL_DB.ExecuteDataSet("SELECT User_ID, ConsumerName, Email, MobileNo, City, PinCode, Password, Entry_Date, IsActive, IsDelete, Address FROM M_Consumer WHERE User_ID = '" + dt.Rows[0]["User_ID"].ToString() + "'").Tables[0];
        //        if (dst.Rows.Count > 0)
        //        {
        //            Address = dst.Rows[0]["ConsumerName"].ToString();
        //            Address += dst.Rows[0]["Address"].ToString();
        //            Address += "  City :" + dst.Rows[0]["City"].ToString();
        //            Address += "  Pin Code :" + dst.Rows[0]["PinCode"].ToString();
        //            Address += "  Contact No :" + dst.Rows[0]["MobileNo"].ToString();
        //        }
        //        txtDispLocation.Text = Address;
        //    }
        //}
        //else
        //{
        //    txtDispLocation.Text = string.Empty;
        //    Div1.Visible = true;
        //    Div1.Attributes.Add("class", "alert_boxes_green big_msg");
        //    Label1.Text = "Please select awards name.";
        //    FillGrdMain();
        //    string script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //}
        //ModalPopupExtenderNewDesign.Show();
    }
    protected void GrdVwDealer_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //newMsg.Visible = false;
        //GrdVwDealer.PageIndex = e.NewPageIndex;
        //FillGrdMain();
    }
    protected void GrdVwDealer_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //Loyalty_Dispatch Reg = new Loyalty_Dispatch(); newMsg.Visible = false; DivNewMsg.Visible = false;
        //lblCourierId.Text = e.CommandArgument.ToString();
        //Reg.RowId = Convert.ToInt64(lblCourierId.Text);
        //Reg.Courier_Name = "";
        //DataSet ds = ds = SQL_DB.ExecuteDataSet("SELECT m.* FROM  Awards_Dispatch_Master AS m WHERE m.RowId = " + Convert.ToInt64(Reg.RowId) + " ");
        //if (e.CommandName == "ReceiveDealer")
        //{
        //    newMsg.Visible = false;
        //    LabelAlertheader.Text = "Alert";
        //    LabelAlertText.Text = "Are you sure to received  <span style='color:blue;' >" + Reg.Courier_Name + "</span>  by dealer ?";
        //    btnYesActivation.Text = "Yes";
        //    ReceiveModalPopup.Show();
        //    //string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        //    //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //}
    }
    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (ddlProduct.SelectedIndex > 0)
        //{
        //    DataTable dt = (DataTable)Session["LBLInfo"];
        //    if (dt.Rows.Count > 0)
        //    {
        //        if (ddlProduct.SelectedValue.ToString() != Session["ProID"].ToString())
        //        {
        //            ddlProduct.SelectedValue = Session["ProID"].ToString();
        //            LabelAlertheader.Text = "Alert";
        //            LabelAlertText.Text = "Order dispatch Single product only one time.";
        //            LabelAlertText.ForeColor = System.Drawing.Color.Red;
        //            btnYesActivation.Visible = false;
        //            btnNoActivation.Visible = false;
        //            ModalPopupExtenderNewDesign.Show();
        //            ModalPopupExtenderAlert.Show();
        //        }
        //    }
        //    DataSet dds = SQL_DB.ExecuteDataSet("SELECT * FROM (SELECT (SELECT Label_Code FROM M_Label_Request WHERE Tracking_No = M_Code.LabelRequestId) AS Label_Code ,(SELECT   Label_Name + ' ( '+ Label_Size +' ) ' as Label_Name FROM M_Label WHERE Label_Code = (SELECT Label_Code FROM M_Label_Request WHERE Tracking_No = M_Code.LabelRequestId)) as Label_Name FROM M_Code WHERE Pro_ID = '" + ddlProduct.SelectedValue.ToString() + "' AND DispatchFlag IS NULL AND (ScrapeFlag IS NULL OR ScrapeFlag = 0)  GROUP BY LabelRequestId,Pro_ID ) Reg GROUP BY Label_Name,Label_Code");
        //    if (dds.Tables[0].Rows.Count == 1)
        //    {

        //    }
        //    else
        //    {

        //    }
        //    txtDispLocation.Text = SQL_DB.ExecuteScalar("SELECT Dispatch_Location  FROM Pro_Reg where [Pro_ID] = '" + ddlProduct.SelectedValue.ToString() + "'  ").ToString();
        //}
        //else
        //{

        //}
        //ModalPopupExtenderNewDesign.Show();
    }
    protected void ddlLabel_SelectedIndexChanged(object sender, EventArgs e)
    {
      //  ModalPopupExtenderNewDesign.Show();
    }
    protected void DDLCompany_SelectedIndexChanged(object sender, EventArgs e)
    {
        //fillProduct("I");
        //((DataTable)Session["LBLInfo"]).Rows.Clear();
        //ModalPopupExtenderNewDesign.Show();
    }
   

    protected void ddlproname_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillGrdMain();
    }



    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GridView1.PageIndex = e.NewPageIndex;
        FillGrdMain();
    }

    protected void ddlService_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataSet ds = ExecuteNonQueryAndDatatable.GetGiftByCompany(ProjectSession.strCompanyid);
        if (ddlService.SelectedValue == "SRV1001")
        {
         
            if (ds.Tables.Count > 3)
            {
                DataTable dtGidt = ds.Tables[3];
                DataProvider.MyUtilities.FillDDLInsertBlankIndexWithZero(dtGidt, "RowId", "AwardName", ddlAward, "--Select--");
                //DataTable dtDealer = ds.Tables[1];
                //DataProvider.MyUtilities.FillDDLInsertZeroIndexIntValBy(dtDealer, "Row_Id", "Dealer_Name", ddlDealer, "--Select--");
                //DataTable dtCourier = ds.Tables[2];
                //DataProvider.MyUtilities.FillDDLInsertZeroIndexIntValBy(dtCourier, "CourierPkid", "Courier_Name", ddlCourierCompany, "--Select--");

            }
        }
        else
        {
            if (ds.Tables.Count > 3)
            {
                DataTable dtGidt = ds.Tables[0];
                DataProvider.MyUtilities.FillDDLInsertBlankIndexWithZero(dtGidt, "Gift_Pkid", "GiftName", ddlAward, "--Select--");
            }
        }
    }
}
