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

public partial class FrmLabelDispatch : System.Web.UI.Page
{
    public string srt = DataProvider.Utility.FindMailBody();
    DataTable LabelDataTableInfo = new DataTable(); public int Flag = 0,index =0; 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("../Info/Login.aspx?Page=FrmLabelDispatch.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }  
        if (!IsPostBack)
        {
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
    protected void BtnSearch_Click(object sender, ImageClickEventArgs e)
    {
        FillGrdMain();
    }
    protected void BtnRefesh_Click(object sender, ImageClickEventArgs e)
    {
        txtProName.Text = string.Empty;
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
        ExecuteNonQueryAndDatatable.UpdateM_code_ReceiveFlag(Reg.Courier_Disp_ID);

        // below lines are commneted by shweta. Below lines are of no use.

        //DataSet ds = function9420.GetCourierDispLabelInfoID(Reg);


        // if (ds.Tables[0].Rows.Count > 0)
        //{
        //    #region
        //    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        //    {
        //    G:
        //        Reg.Pro_ID = ds.Tables[0].Rows[i]["Pro_ID"].ToString();
        //        string str = ""; int pcount = 0;
        //        string[] Serialcode = ds.Tables[0].Rows[i]["Series_From"].ToString().Split('-');
        //        string pro = Serialcode[0];
        //        Int32 Series_Order = Convert.ToInt32(Serialcode[1]);
        //        Int32 Series_Serial = Convert.ToInt32(Serialcode[2]);
        //        string[] Serialcode1 = ds.Tables[0].Rows[i]["Series_To"].ToString().Split('-');
        //        string pro1 = Serialcode1[0];
        //        Int32 Series_Order1 = Convert.ToInt32(Serialcode1[1]);
        //        Int32 Series_Serial1 = Convert.ToInt32(Serialcode1[2]);
        //        if (Series_Order == Series_Order1 && pro == pro1) //&& pro == ddlProduct.SelectedValue.ToString() && pro == ddlProduct.SelectedValue.ToString()
        //        {
        //            str = " AND Series_Order=" + Series_Order + " AND Series_Serial >= " + Series_Serial;
        //            str += " AND Series_Serial<=" + Series_Serial1;
        //            if (Convert.ToInt32(Series_Serial1) >= Convert.ToInt32(Series_Serial))
        //            {
        //                if (Convert.ToInt32(Series_Serial) == 0)
        //                    pcount = Convert.ToInt32(Series_Serial1) + 1;
        //                else
        //                    pcount = Convert.ToInt32(Series_Serial1) - Convert.ToInt32(Series_Serial) + 1;
        //            }
        //            // shweta code-----------------------------------


        //            // below lines are commneted by shweta. Below lines are of no use.

        //            //DataSet dsUpd = new DataSet();
        //            //dsUpd = function9420.ChkSeriesForupdateM_Code(Reg, str, pcount);

        //            //if (dsUpd.Tables[0].Rows.Count > 0)
        //            //{
        //            //    StringBuilder sb = new StringBuilder();

        //            //    DataTable dtMyTable = new DataTable();
        //            //    //DataColumn myDataColumn ;
        //            //    DataColumn myDataColumn = new DataColumn();
        //            //    myDataColumn.DataType = Type.GetType("System.String");
        //            //    myDataColumn.ColumnName = "Code1";
        //            //    dtMyTable.Columns.Add(myDataColumn);

        //            //    DataColumn myDataColumn1 = new DataColumn();
        //            //    myDataColumn1.DataType = Type.GetType("System.String");
        //            //    myDataColumn1.ColumnName = "Code2";
        //            //    dtMyTable.Columns.Add(myDataColumn1);


        //            //    for (int p = Series_Serial, k = 0; p <= Series_Serial1; p++, k++)
        //            //    {
        //            //        //sb.Append("UPDATE [M_Code] SET  [ReceiveFlag] = 1 WHERE [Code1] = '" + dsUpd.Tables[0].Rows[k]["Code1"].ToString() + "' AND [Code2] = '" + dsUpd.Tables[0].Rows[k]["Code2"].ToString() + "' ;");
        //            //        DataRow row;
        //            //        row = dtMyTable.NewRow();
        //            //        row["Code1"] = dsUpd.Tables[0].Rows[k]["Code1"].ToString();
        //            //        row["Code2"] = dsUpd.Tables[0].Rows[k]["Code2"].ToString();
        //            //        dtMyTable.Rows.Add(row);
        //            //        sb.Append("Insert into Temp_Receive values('" + dsUpd.Tables[0].Rows[k]["Code1"].ToString() + "','" + dsUpd.Tables[0].Rows[k]["Code2"].ToString() + "');");
        //            //    }

        //            //    Session["DemoReceiveTable"] = dtMyTable;
        //            //    SaveTempDispatch(dtMyTable);

        //            //if (!function9420.UpdateM_Code(sb.ToString()))
        //            //    goto G;
        //        //}
        //    }
        //    }
        //    #endregion
        //}
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
            //Business9420.function9420.PrintCodes();
            //SqlTransaction tr1 ;
            //tr1.Connection.BeginTransaction();
            SQL_DB.ExecuteNonQuery("update mc set mc.ReceiveFlag = 1 from Temp_Receive tr inner join M_code mc on tr.code1 = mc.code1 and tr.code2 = mc.code2");

            //if (conn.State == ConnectionState.Open)
            //    conn.Close();
            //conn.Open();
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
        //LabelAlertheader.Text = "Alert";
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
                Response.Redirect("FrmScrapEntry.aspx?P="+ Reg.Pro_ID +"&S1=" + Reg.Series_From + "&S2=" + Reg.Series_To);
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
        //Object9420 Reg = new Object9420();
        //Reg.Courier_Disp_ID = lblCourierId.Text;
        //Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        //Reg.Flag = -1;
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //Reg.Manu_Remark = LabelReasonText.Text.Trim().Replace("'", "''");
        //function9420.LabelReceipt(Reg);        
        //Business9420.function9420.FillUpDateProfile(Reg);
        //newMsg.Visible = true;
        //newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        //lblmsgHeader.Text = "Courier <span style='color:blue;' >" + hdCompanyNm.Value + "</span> Dispatch order has been rejected successfully.";
        //FillGrdMain();

        //DataSet ds = SQL_DB.ExecuteDataSet("SELECT     cdpi.Courier_Disp_ID, cdpi.Pro_ID, cdpi.Label_Name, sum(cdpi.Qty) Qty, cm.Courier_Name, cdm.Tracking_No, cdm.Entry_Date,  " +
        //              " p.Pro_Name FROM Courier_Disp_ProInfo AS cdpi INNER JOIN Courier_Dispatch_Master AS cdm ON cdpi.Courier_Disp_ID = cdm.Courier_Disp_ID INNER JOIN " +
        //              " Courier_Master AS cm ON cdm.Courier_ID = cm.Courier_ID INNER JOIN Pro_Reg AS p ON cdpi.Pro_ID = p.Pro_ID WHERE     (cdpi.Courier_Disp_ID = '"+ Reg.Courier_Disp_ID +"') group by cdpi.Courier_Disp_ID, cdpi.Pro_ID, cdpi.Label_Name, cm.Courier_Name, cdm.Tracking_No, cdm.Entry_Date, " +
        //              " p.Pro_Name");
        //#region MailBody
        //#region MailBody
        //string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
        //   " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
        //   " <hr style='border:1px solid #2587D5;'/>" +
        //   " <div class='w_frame'>" +
        //   " <p>" +
        //   " <div class='w_detail'>" +
        //   " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
        //   " <br />" +
        //   " <span>Your order has been rejected by  " + hdCompanyNm.Value + "</span>" +
        //   " <br />Details are as follows:- <br />" +
        //   " <table border='0' cellspacing='2'>" +
        //   " <tr>" +
        //   " <td width='90' align='right'><strong>Product Name :&nbsp; </strong></td>" +
        //   " <td width='282'><a href='#'>" + ds.Tables[0].Rows[0]["Pro_Name"].ToString() + "</a></td>" +
        //   " </tr>" +
        //   " <tr>" +
        //   " <td width='90' align='right'><strong>Courier Name :&nbsp; </strong></td>" +
        //   " <td width='282'><a href='#'>" + ds.Tables[0].Rows[0]["Courier_Name"].ToString() + "</a></td>" +
        //   " </tr>" +
        //   " <tr>" +
        //   " <td align='right' valign='top'><strong>Courier Tracking No. :&nbsp;</strong></td>" +
        //   " <td>" + ds.Tables[0].Rows[0]["Tracking_No"].ToString() + "</td>" +
        //   " </tr>" +
        //   " <tr>" +
        //   " <td align='right' valign='top'><strong>No. of Labels :&nbsp;</strong></td>" +
        //   " <td>" + ds.Tables[0].Rows[0]["Qty"].ToString() + "</td>" +
        //   " </tr>" +
        //   " <tr>" +
        //   " <td align='right' valign='top'><strong>Courier Date :&nbsp;</strong></td>" +
        //   " <td>" + ds.Tables[0].Rows[0]["Entry_Date"].ToString() + "</td>" +
        //   " </tr>" +
        //   " <tr>" +
        //   " <tr>" +
        //   " <td align='right' valign='top'><strong>Reason :&nbsp;</strong></td>" +
        //   " <td>" + LabelReasonText.Text.Trim() + "</td>" +
        //   " </tr>" +
        //   " <tr>" +
        //   " <td width='100%' align='left' colspan='2'></td>" +
        //   " </tr>" +
        //   " </table>" +
        //   " <p>" +
        //   " <div class='w_detail'>" +
        //   " Assuring you  of  our best services always.<br />" +
        //   " Thank you,<br /><br />" +
        //   " Team <em><strong>VCQRU.COM,</strong></em><br />" +
        //   "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
        //   " <strong>Toll Free: 1800 183 9420</strong>" +
        //   " </div>" +
        //   " </p>" +
        //   " </div>" +
        //   " </p>" +
        //   " </div> " +
        //   " </div> ";
        //#endregion
        //string MBofy = " <br />" +
        //   " <span>Label Dispatch order has been rejected by  " + hdCompanyNm.Value + "</span>" +
        //   " <br />Details are as follows:- <br />" +           
        //   " <p>" +
        //  " <table border='0' cellspacing='2'>" +
        //  " <tr>" +
        //   " <td width='90' align='right'><strong>Product Name :&nbsp; </strong></td>" +
        //   " <td width='282'><a href='#'>" + ds.Tables[0].Rows[0]["Pro_Name"].ToString() + "</a></td>" +
        //   " </tr>" +
        //   " <tr>" +
        //   " <td width='90' align='right'><strong>Courier Name :&nbsp; </strong></td>" +
        //   " <td width='282'><a href='#'>" + ds.Tables[0].Rows[0]["Courier_Name"].ToString() + "</a></td>" +
        //   " </tr>" +
        //   " <tr>" +
        //   " <td align='right' valign='top'><strong>Courier Tracking No. :&nbsp;</strong></td>" +
        //   " <td>" + ds.Tables[0].Rows[0]["Tracking_No"].ToString() + "</td>" +
        //   " </tr>" +
        //   " <tr>" +
        //   " <td align='right' valign='top'><strong>No. of Labels :&nbsp;</strong></td>" +
        //   " <td>" + ds.Tables[0].Rows[0]["Qty"].ToString() + "</td>" +
        //   " </tr>" +
        //   " <tr>" +
        //   " <td align='right' valign='top'><strong>Courier Date :&nbsp;</strong></td>" +
        //   " <td>" + ds.Tables[0].Rows[0]["Entry_Date"].ToString() + "</td>" +
        //   " </tr>" +
        //   " <tr>" +
        //   " <tr>" +
        //   " <td align='right' valign='top'><strong>Reason :&nbsp;</strong></td>" +
        //   " <td>" + LabelReasonText.Text.Trim() + "</td>" +
        //   " </tr>" +
        //   " <tr>" +
        //   " <td width='100%' align='left' colspan='2'></td>" +
        //   " </tr>" +
        //   " </table>";
        //string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Sales department", "Label Dispatch Order rejection by " + hdCompanyNm.Value + "." + MBofy);
        //string MailBody2 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Print department", "Label Dispatch Order rejection by " + hdCompanyNm.Value + "." + MBofy);
        //string MailBody3 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Account department", "Label Dispatch Order rejection by " + hdCompanyNm.Value + "." + MBofy);
        //string MailBody4 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "IT department", "Label Dispatch Order rejection by " + hdCompanyNm.Value + "." + MBofy);
        //#endregion
        //DataSet dsMl = function9420.FetchMailDetail("admin");
        //if (dsMl.Tables[0].Rows.Count > 0)
        //{
        //    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Label Dispatch Order rejection");
        //    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Label Dispatch Order rejection");
        //    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(),ProjectSession.print_accomplishtrades, MailBody2, "Label Dispatch Order rejection");
        //    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Label Dispatch Order rejection");
        //    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Label Dispatch Order rejection");
        //}
        //string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //hdCompanyNm.Value = string.Empty;
    }
}
