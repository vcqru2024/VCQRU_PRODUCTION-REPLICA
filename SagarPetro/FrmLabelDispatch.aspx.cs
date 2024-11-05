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
using DataProvider;

public partial class Patanjali_FrmLabelDispatch : System.Web.UI.Page
{
    cls_patanjali db = new cls_patanjali();
    public string srt = DataProvider.Utility.FindMailBody();
    DataTable LabelDataTableInfo = new DataTable(); public int Flag = 0, index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../Info/Login.aspx?Page=FrmLabelDispatch.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            #region User Log 
            if (Session["UserName"] != null)
            {
                db.ExceptionLogs("Visited on LableDispatch", Session["UserName"].ToString(), "R");
            }
            else
            {
                db.ExceptionLogs("Visited on LableDispatch", Session["Comp_Name"].ToString(), "R");
            }
            #endregion
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            FillGrdMain();
        }
    }
    protected void ddlRows_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillGrdMain();
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        ((DataTable)Session["LBLInfo"]).Rows.Clear();
        newMsg.Visible = false;
    }
   
    protected void BtnRefesh_Click(object sender, ImageClickEventArgs e)
    {
      //  txtProName.Text = string.Empty;
        FillGrdMain();
    }
    private void FillGrdMain()
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.Courier_Name = txtProName.Text.Trim().Replace("'", "''");
        DataSet ds = function9420.FillGrdMainLabelDispatchData(Reg);
        //if (Convert.ToInt32(ddlRows.SelectedValue) > 1000)
        //{
        //    if (ds.Tables[0].Rows.Count > 0)
        //        GrdCourierDispatch.PageSize = ds.Tables[0].Rows.Count;
        //}
        //else
        //    GrdCourierDispatch.PageSize = Convert.ToInt32(ddlRows.SelectedValue.Trim());
        lblcount.Text = ds.Tables[0].Rows.Count.ToString();
        if (ds.Tables[0].Rows.Count > 0)
            GrdCourierDispatch.DataSource = ds.Tables[0];
        GrdCourierDispatch.DataBind();
        lblcount.Text = ds.Tables[0].Rows.Count.ToString();
        if (GrdCourierDispatch.Rows.Count > 0)
            GrdCourierDispatch.HeaderRow.TableSection = TableRowSection.TableHeader;


        FillProductDetails();
    }
    private void FillProductDetails()
    {
        DataSet ds = new DataSet();
        if (GrdCourierDispatch.Rows.Count > 0)
        {
            for (int i = 0; i < GrdCourierDispatch.Rows.Count; i++)
            {
                Label CourierDispID = (Label)GrdCourierDispatch.Rows[i].FindControl("lblCDispID");
                Object9420 obj = new Object9420();
                obj.Courier_Disp_ID = CourierDispID.Text;
                ds = function9420.GetCourierProDispInfo(obj);
                GridView Grd = (GridView)GrdCourierDispatch.Rows[i].FindControl("GrdLablelDet");
                Grd.DataSource = ds.Tables[0];
                Grd.DataBind();
            }
        }
    }
    protected void GrdCourierDispatch_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }
    private void UpdateDispatchFlagSeries()
    {
        Object9420 Reg = new Object9420();
        Reg.Courier_Disp_ID = lblCourierId.Value;

        // shweta code-----------------------------------

        if (Session["CompanyId"].ToString() == "Comp-1311")
            ExecuteNonQueryAndDatatable.UpdateM_code_ReceiveFlagCompId(Reg.Courier_Disp_ID);
        else
            ExecuteNonQueryAndDatatable.UpdateM_code_ReceiveFlag(Reg.Courier_Disp_ID);
        #region User Log 
        if (Session["UserName"] != null)
        {
            db.ExceptionLogs("Lable Dispached By", Session["UserName"].ToString(), "U");
        }
        else
        {
            db.ExceptionLogs("Lable Dispached By", Session["Comp_Name"].ToString(), "U");
        }
        #endregion

    }

    private void SaveTempDispatch(DataTable dt)
    {
        SQL_DB.ExecuteNonQuery("TRUNCATE TABLE Temp_Receive");
        SqlConnection conn = dtcon.CreateConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.Open();
        if (((DataTable)Session["DemoReceiveTable"]).Rows.Count > 0)
        {
            using (SqlBulkCopy bulkCopy = new SqlBulkCopy(conn))
            {
                bulkCopy.DestinationTableName = "Temp_Receive";

                try
                {
                    // Write from the source to the destination.
                    bulkCopy.BulkCopyTimeout = 0;
                    bulkCopy.WriteToServer(dt);
                    Session["DemoReceiveTable"] = null;
                    //creating blank dt for dispatch 
                    //CodeTableInfo = CreateBlankDispatchDataTable();
                    //Session["DemoDispatchTable"] = CodeTableInfo;
                }
                catch (Exception ex)
                {
                    LogManager.WriteExe("Receive(SaveTempDispatch)  : Error " + ex.Message.ToString());
                }
            }
        }
        string str = "Insert Complete";
        try
        {
            
            SQL_DB.ExecuteNonQuery("update mc set mc.ReceiveFlag = 1 from Temp_Receive tr inner join M_code mc on tr.code1 = mc.code1 and tr.code2 = mc.code2");
            #region User Log 
            if (Session["UserName"] != null)
            {
                db.ExceptionLogs("Lable Dispached By", Session["UserName"].ToString(), "U");
            }
            else
            {
                db.ExceptionLogs("Lable Dispached By", Session["Comp_Name"].ToString(), "U");
            }
            #endregion

        }
        catch (Exception ex)
        {
            LogManager.WriteExe("Receive(SaveTempDispatch)  : Error " + ex.Message.ToString());
            //Response.Write(ex.Message.ToString());
        }
    }

    protected void GrdCourierDispatch_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Object9420 Reg = new Object9420(); newMsg.Visible = false;
        lblCourierId.Value = e.CommandArgument.ToString();
        Reg.Courier_Disp_ID = lblCourierId.Value;
        function9420.GetCourierDispInfo(Reg); LabelCalText.Value = ""; hdCompanyNm.Value = Reg.Courier_Name;
        newMsg.Visible = true;
      
        if (e.CommandName == "LabelReceipt")
        {
            // MyRadio.Visible = false;
            LabelCalText.Value = "Cal No";
            LabelAlertText.Text = "Are you sure to receive <span style='color:blue;' >" + Reg.Courier_Name + "</span>  Courier Dispatch Order ?";
            ModalPopupExtenderAlert.Show();
        }
        else if (e.CommandName == "DenyLabels")
        {
            //  MyRadio.Visible = false;
            LabelCalText.Value = "Cal Deny";
            LabelAlertText.Text = "Are you sure to rejected <span style='color:blue;' >" + Reg.Courier_Name + "</span>  Courier Dispatch Order ?";
            //ModalPopupExtender1.Show();
            //ModalPopupExtenderAlert.Show();
            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "none", "<script>$('#EraseModal').modal('show');</ script > ", false);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", "<script >$('#EraseModal').modal('show');</ script > ", true);
            FillGrdMain();
        }
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {

    }
    protected void btnYesReceipt_Click(object sender, EventArgs e)
    {
        if (LabelCalText.Value == "Cal Yes")
        {
            Object9420 Reg = new Object9420();
            Reg.Courier_Disp_ID = lblCourierId.Value;
            Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            if (rdReceipt.Checked)
            {
                Reg.Flag = 1;
                lblmsgHeader.Text = "Courier <span style='color:blue;' >" + hdCompanyNm.Value + "</span> Dispatch order has been received successfully.";
            }
            else if (rdReceipts.Checked)
            {
                Reg.Flag = 2;
                UpdateDispatchFlagSeries();
                function9420.LabelReceipt(Reg);
                function9420.FillScrapInfo(Reg);
                Response.Redirect("FrmScrapEntry.aspx?P=" + Reg.Pro_ID + "&S1=" + Reg.Series_From + "&S2=" + Reg.Series_To);
            }
            else if (rdReceiptd.Checked)
            {
                Reg.Flag = -1;
                lblmsgHeader.Text = "Courier <span style='color:blue;' >" + hdCompanyNm.Value + "</span> Dispatch order has been rejected.";
            }
            try
            {
                UpdateDispatchFlagSeries();
                function9420.LabelReceipt(Reg);
            }
            catch (Exception)
            {
                DataTable cdt = SQL_DB.ExecuteDataSet("SELECT [Received_Flag] FROM [Courier_Dispatch_Master] WHERE [Courier_Disp_ID] = '" + Reg.Courier_Disp_ID + "'").Tables[0];
                if (cdt.Rows.Count > 0)
                {
                    if (Convert.ToInt32(cdt.Rows[0]["Received_Flag"]) == 1)
                        SQL_DB.ExecuteNonQuery("UPDATE [Courier_Dispatch_Master] SET [Received_Date] = null,[Received_Flag] = 0 ,[Man_Reason] = null WHERE [Courier_Disp_ID] = '" + Reg.Courier_Disp_ID + "'");
                }
                lblmsgHeader.Text = "Courier Dispatch order has been error occured redceived time.";
                newMsg.Visible = true;
                newMsg.Attributes.Add("class", "alert_boxes_pink big_msg");

                FillGrdMain();
                string script1 = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
                hdCompanyNm.Value = string.Empty;
                return;
            }
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green big_msg");

            //FillGrdMain();
            string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            hdCompanyNm.Value = string.Empty;
        }
        else if (LabelCalText.Value == "Cal Deny")
        {
            Object9420 Reg = new Object9420();
            Reg.Courier_Disp_ID = lblCourierId.Value;
            Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            Reg.Flag = 5;
            function9420.LabelReceipt(Reg);
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
            lblmsgHeader.Text = "Courier <span style='color:blue;' >" + hdCompanyNm.Value + "</span> Dispatch order has been rejected successfully.";
            FillGrdMain();
            string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            hdCompanyNm.Value = string.Empty;
        }
        else if (LabelCalText.Value == "Cal No")
        {
            MyRadio.Visible = true;
            LabelCalText.Value = "Cal Yes";
            LabelAlertText.Text = "";
            ModalPopupExtenderAlert.Show();
        }
        FillGrdMain();
    }
    protected void btnNoReceipt_Click(object sender, EventArgs e)
    {
        LabelCalText.Value = "";
    }



    protected void BtnCancelRemark1_Click(object sender, EventArgs e)
    {
        
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        FillGrdMain();
    }
}