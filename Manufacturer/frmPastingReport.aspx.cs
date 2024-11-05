using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business9420;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Services;
using System.IO;


//using CrystalDecisions.CrystalReports.Engine;
//using CrystalDecisions.Shared;
//using System.Data.SqlClient;

public partial class frmPastingReport : System.Web.UI.Page
{
    public bool Flag = false; public int i = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Session["User_Type"] == null)
            Response.Redirect("../Index.aspx?Page=frmPastingReport.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }  
        if (!Page.IsPostBack)
        {
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            fillProduct(ddlProduct);
            if (Request.QueryString["Pro_ID"] != null)
            {
                ddlProduct.SelectedValue = Request.QueryString["Pro_ID"].ToString();
                fillBatch(ddlBatch,ddlProduct);
            }
            fillBatch(ddlBatch,ddlProduct);
            fillData();
            Flag = false;
        }
    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkFile(string ult)
    {
        int lindex = ult.LastIndexOf('.');
        string ext = ult.Substring(lindex, ult.Length - lindex);
        if (ext.ToUpper() == ".PDF")
            return false;
        else
            return true;
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        fillProduct(ddlProduct1);        
        fillBatch(ddlBatch1,ddlProduct1);
        newMsg.Visible = false; 
        lblheading.Text = "Upload Label Pasting Report";
        ModalPopupCreateLabel.Show();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();        
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        if (btnSave.Text == "Upload")
        {
            Reg.LabelUploadRptID = function9420.GetLabelCode("UploadReport");
            Reg.Comp_ID = Session["CompanyId"].ToString();
            Reg.Pro_ID = ddlProduct1.SelectedValue.ToString();
            Reg.Batch_No = ddlBatch1.SelectedValue.ToString();
            string path = Server.MapPath("Excel");
            path = path + "\\UploadLabelPastingReport";
            DataProvider.Utility.CreateDirectory(path);
            string ext = Path.GetExtension(LabelFileupload.FileName);
            path = path + "\\" + Reg.LabelUploadRptID + ext;
            LabelFileupload.SaveAs(path);
            Reg.Label_Image = Reg.LabelUploadRptID + ext;
            Reg.Flag = 1;
            //function9420.SaveLabel(Reg);
            function9420.SaveUploadLabelPastingReport(Reg);
            ProductsLabelPrices.Text = "Label Pasting Report <span style='color:blue;' >" + ddlProduct1.SelectedItem.Text + "</span> ( " + ddlBatch1.SelectedItem.Text.Trim() + " ) has been Uploaded successfully !";
            function9420.UpdateLabelCode("UploadReport");
            Div1.Visible = true;
            Div1.Attributes.Add("class", "alert_boxes_green");
            ModalPopupCreateLabel.Show();
            string script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            ddlBatch1.SelectedIndex = 0;
            ddlProduct1.SelectedIndex = 0;
        }
        fillData();
        ModalPopupCreateLabel.Show();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        ddlProduct1.SelectedIndex = 0;
        ddlBatch1.SelectedIndex = 0;
        ModalPopupCreateLabel.Show();
    }
    #region ReportingCoding 
    protected void CrystalReportViewer1_Init1(object sender, EventArgs e)
    {
        fillData();
        if(GrdPrintLabel.Rows.Count > 0)
            fillrpt();
    }
    //protected void CrystalReportViewer1_Navigate(object source, CrystalDecisions.Web.NavigateEventArgs e)
    //{
    //    fillrpt();
    //}
    protected void CrystalReportViewer1_Load(object sender, EventArgs e)
    {
        fillrpt();
    }
    protected void ImgRpt_Click(object sender, ImageClickEventArgs e)
    {
        Flag = true;
        fillData();
        fillrpt();
    }    
    private void fillrpt()
    {
        //if (Flag == false)
        //    return;
        //string MyChar = null; string path = ""; string filename = "";
        //ReportDocument myreportdocumen = new ReportDocument();
        //CrystalReportViewer1.DisplayGroupTree = false;


        //myreportdocumen.Load(Server.MapPath("Reports\\RptPrintLabelsPasting.rpt"), CrystalDecisions.Shared.OpenReportMethod.OpenReportByDefault);

        //#region RecordSectionFormula
        ////string ReFomL = ""; string Qry = "";
        ////ReFomL = " Date({VW_RegisterConsigned.DateOfConsignmentOnRecordRoom})>= #" + Convert.ToDateTime(DateFrom).ToString("yyyy/MM/dd") + "# And Date({VW_RegisterConsigned.DateOfConsignmentOnRecordRoom})<= #" + Convert.ToDateTime(DateTo).ToString("yyyy/MM/dd") + "# AND {VW_RegisterConsigned.MyAppYear} IN [" + inYear + "] ";
        ////Qry = "SELECT  * FROM   VW_RegisterConsigned  where CONVERT(VARCHAR,DateOfConsignmentOnRecordRoom,111) >= '" + Convert.ToDateTime(DateFrom).ToString("yyyy/MM/dd") + "' and CONVERT(VARCHAR,DateOfConsignmentOnRecordRoom,111) <= '" + Convert.ToDateTime(DateTo).ToString("yyyy/MM/dd") + "' AND MyAppYear  in (" + sYear + ") ";
        ////#endregion
        ////DataSet ds = new DataSet();
        ////if (ddlRptType.SelectedValue != "ALL")
        ////    Qry += "  AND ClaimNo not in (SELECT distinct ClaimNo FROM WRInstitutionRegister_Decision union SELECT distinct WritNo as ClaimNo FROM CODisposalRegister) ";
        ////SQL_DB.GetDA(Qry).Fill(ds, "1");
        ////lbld.Text = ds.Tables["1"].Rows.Count.ToString();
        ////if (ds.Tables["1"].Rows.Count > 0)
        ////    myreportdocumen.SetDataSource(ds.Tables["1"]);
        //filename = "\\Print_Sheet_For_Pasting.pdf";
        //#endregion

        //#region Only Report as PopUp
        //DataSet Ds = new DataSet();
        ////if(MyChar != "D")
        ////    SQL_DB.GetDA("SELECT   count(WritNo) FROM   VW_Hearing_Summary where convert(varchar,VW_Hearing_Summary.NextHearingDate,103)>='" + Convert.ToDateTime(txtFromDate.Text).ToString("dd/MM/yyyy") + "' and convert(varchar,NextHearingDate,103) <= '" + Convert.ToDateTime(txtToDate.Text).ToString("dd/MM/yyyy") + "' and AppYear = " + Convert.ToInt32(Session["Year"]) + " AND (User_Id = 'Reporting' OR Cause_flag = 'S' OR Cause_gen_flag=0 AND ConFlg <> 'C') ").Fill(Ds, "1");
        ////else if(MyChar == null)
        ////    SQL_DB.GetDA("SELECT   count(WritNo) FROM   VW_Hearing_Summary where convert(varchar,VW_Hearing_Summary.NextHearingDate,103)>='" + Convert.ToDateTime(txtFromDate.Text).ToString("dd/MM/yyyy") + "' and convert(varchar,NextHearingDate,103) <= '" + Convert.ToDateTime(txtToDate.Text).ToString("dd/MM/yyyy") + "' and AppYear = " + Convert.ToInt32(Session["Year"]) + " AND ConFlg <> 'C'").Fill(Ds, "1");
        ////else
        ////    SQL_DB.GetDA("SELECT   count(WritNo) FROM   VW_Hearing_Summary where convert(varchar,VW_Hearing_Summary.NextHearingDate,103)>='" + Convert.ToDateTime(txtFromDate.Text).ToString("dd/MM/yyyy") + "' and convert(varchar,NextHearingDate,103) <= '" + Convert.ToDateTime(txtToDate.Text).ToString("dd/MM/yyyy") + "' and AppYear = " + Convert.ToInt32(Session["Year"]) + " AND User_Id <> 'Reporting' OR Cause_flag = 'D' AND ConFlg <> 'C'").Fill(Ds, "1");
        ////myreportdocumen.SetDataSource(Ds.Tables["1"]);

        ////Ds.Tables[0].Rows.Clear();
        //Object9420 Reg = new Object9420();
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //string spr = "";
        //if (ddlProduct.SelectedIndex > 0)
        //    spr = "  AND (vw_pastinglabel.Pro_ID = '" + ddlProduct.SelectedValue.ToString() + "')";
        //else
        //    spr = "  AND (vw_pastinglabel.Pro_ID = vw_pastinglabel.Pro_ID)";
        //if (ddlBatch.SelectedIndex > 0)
        //    spr += "  AND  (vw_pastinglabel.Row_ID = " + ddlBatch.SelectedValue.ToString() + " )";
        //else
        //    spr += "  AND  (vw_pastinglabel.Row_ID = vw_pastinglabel.Row_ID)";
        //Reg.Condition = spr;
        //Ds = function9420.FillLabelPastingSheet(Reg);
        //if (Ds.Tables[0].Rows.Count > 0)
        //    myreportdocumen.SetDataSource(Ds.Tables[0]);
        //myreportdocumen.SetDatabaseLogon("sa", "infra");
        //CrystalReportViewer1.ReportSource = myreportdocumen;

        //path = Server.MapPath("Excel") + "//PdfFile" + filename;
        ////DataProvider.Utility.CreateDirectory(path);
        //if (System.IO.File.Exists(path))
        //    System.IO.File.Delete(path);
        //ExportOptions CrExportOptions1;
        //DiskFileDestinationOptions CrDiskFileDestinationOptions1 = new DiskFileDestinationOptions();
        //PdfRtfWordFormatOptions CrFormatTypeOptions1 = new PdfRtfWordFormatOptions();
        //CrDiskFileDestinationOptions1.DiskFileName = path;
        //CrExportOptions1 = myreportdocumen.ExportOptions;
        //{
        //    CrExportOptions1.ExportDestinationType = ExportDestinationType.DiskFile;
        //    CrExportOptions1.ExportFormatType = ExportFormatType.PortableDocFormat;
        //    CrExportOptions1.DestinationOptions = CrDiskFileDestinationOptions1;
        //    CrExportOptions1.FormatOptions = CrFormatTypeOptions1;
        //}
        //myreportdocumen.Export();

        ////WebClient client = new WebClient();
        ////Byte[] buffer = client.DownloadData(path);

        ////if (buffer != null)
        ////{
        ////    Response.ContentType = "application/pdf";
        ////    Response.AddHeader("content-length", buffer.Length.ToString());
        ////    Response.BinaryWrite(buffer);            
        ////}
        ////open a pop up window at the center of the page.
        //ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( 'http://localhost:1528/DwnLabel9420/Excel/PdfFile/" + filename + "', null, 'height=700,width=760,status=yes,toolbar=no,scrollbars=yes,menubar=no,location=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
        ////CrystalReportViewer1.DataBind();
        //CrystalReportViewer1.Visible = false;
        //#endregion

        
    }
    #endregion    


    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlProduct.SelectedIndex > 0)
            fillBatch(ddlBatch,ddlProduct);
        else
        {
            ddlBatch.Items.Clear();
            ddlBatch.Items.Insert(0, "--Select Product--");
        }
    }
    protected void ddlProduct1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlProduct1.SelectedIndex > 0)
            fillBatch(ddlBatch1,ddlProduct1);
        else
        {
            ddlBatch1.Items.Clear();
            ddlBatch1.Items.Insert(0, "--Select Product--");
        }
        ModalPopupCreateLabel.Show();
    }
    private void fillBatch(DropDownList DDlList,DropDownList DDLMList)
    {
        if (DDLMList.SelectedIndex > 0)
        {
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT distinct T_Pro.Row_ID, T_Pro.Batch_No" +
            " FROM M_Code INNER JOIN T_Pro ON M_Code.Pro_ID = T_Pro.Pro_ID AND M_Code.Batch_No = T_Pro.Row_ID INNER JOIN" +
            " Pro_Reg ON T_Pro.Pro_ID = Pro_Reg.Pro_ID" +
            " WHERE (M_Code.Print_Status = 1) AND (M_Code.Batch_No IS NOT NULL) AND (Pro_Reg.Comp_ID = '" + Session["CompanyId"].ToString() + "') and T_Pro.Pro_ID ='" + DDLMList.SelectedValue.ToString() + "'");
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataProvider.MyUtilities.FillDDLInsertZeroIndexIntVal(ds, "Row_ID", "Batch_No", DDlList, "--Select Batch--");
                DDlList.SelectedIndex = 0;
            }
            else
            {
                DDlList.Items.Clear();
                DDlList.Items.Insert(0, "--Select Batch--");
            }
        }
        else
        {
            DDlList.Items.Clear();
            DDlList.Items.Insert(0, "--Select Batch--");
        }
        DDlList.SelectedIndex = 0;
        
    }
    
    private void fillProduct(DropDownList DDLList)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT distinct M_Code.Pro_ID, Pro_Reg.Pro_Name FROM M_Code INNER JOIN T_Pro ON M_Code.Pro_ID = T_Pro.Pro_ID AND M_Code.Batch_No = T_Pro.Row_ID INNER JOIN" +
        " Pro_Reg ON T_Pro.Pro_ID = Pro_Reg.Pro_ID WHERE (M_Code.Print_Status = 1) " +
        " AND (M_Code.Batch_No IS NOT NULL) AND (Pro_Reg.Comp_ID = '" + Session["CompanyId"].ToString() + "')");
        if (ds.Tables[0].Rows.Count > 0)
        {
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", DDLList, "--Select Product--");
            DDLList.SelectedIndex = 0;
        }
        else
        {
            DDLList.Items.Clear();
            DDLList.Items.Insert(0, "--Select Product--");
        }
        
    }
    
    private void fillData()
    {
        string spr = ""; string str ="";
        if (ddlProduct.SelectedIndex > 0)
            spr = "'" + ddlProduct.SelectedValue.ToString() + "'";
        else
            spr = "t.Pro_ID";

        string sbt = "";
        if (ddlBatch.SelectedIndex > 0)
            sbt = "'"+ddlBatch.SelectedValue.ToString()+ "'";
        else
            sbt = "t.Batch_No";
        if ((txtDateFrom.Text != "") && (txtDateTo.Text != ""))
            str = " AND (CONVERT,VARCHAR,Entry_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text.Trim()).ToString("yyyy/MM/dd") + "') AND (CONVERT,VARCHAR,Entry_Date,111) >= '" + Convert.ToDateTime(txtDateTo.Text.Trim()).ToString("yyyy/MM/dd") + "')";
        if ((txtDateFrom.Text != "") && (txtDateTo.Text == ""))
            str = " AND (CONVERT,VARCHAR,Entry_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text.Trim()).ToString("yyyy/MM/dd") + "') ";
        if ((txtDateFrom.Text == "") && (txtDateTo.Text != ""))
            str = " (CONVERT,VARCHAR,Entry_Date,111) >= '" + Convert.ToDateTime(txtDateTo.Text.Trim()).ToString("yyyy/MM/dd") + "')";
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT     t.Row_ID, t.File_ID, t.Comp_ID, t.Pro_ID,(SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = t.Pro_ID) as Pro_Name, t.Batch_No,(SELECT Batch_No FROM T_Pro WHERE Row_ID = t.Batch_No) as Batch_Name, t.FilePath,'Excel\\UploadLabelPastingReport\\'+t.FilePath as DocPath, t.Entry_Date, t.Flag FROM T_UploadPastingRpt as t WHERE t.Comp_ID = '" + Session["CompanyId"].ToString() + "' " +
         " and t.Pro_ID = " + spr + " and t.Batch_No = " + sbt + str + " ORDER BY t.Entry_Date DESC");
         //Session["MyData"] =(DataTable)ds.Tables[0];
         //SaveLabelPastingInfo();
         //((DataTable)Session["MyData"]).Rows.Clear();         
         if (ds.Tables[0].Rows.Count > 0)
             GrdPrintLabel.DataSource = ds.Tables[0];
         GrdPrintLabel.DataBind();
         lblcount.Text = ds.Tables[0].Rows.Count.ToString();
        if (GrdPrintLabel.Rows.Count > 0)
            GrdPrintLabel.HeaderRow.TableSection = TableRowSection.TableHeader;
    }

    private void SaveLabelPastingInfo()
    {
        SqlConnection conn = dtcon.CreateConnection();
        if (((DataTable)Session["MyData"]).Rows.Count > 0)
        {
            string sr1 = "SELECT [SeriesName] ,[Code1],[Batch_No],[Comp_ID],[PrintDate],[SerialCode] FROM [Rpt_Pasing]";
            SqlCommand cmd = new SqlCommand(sr1, conn);
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            SqlCommandBuilder cb = new SqlCommandBuilder(ad);
            ad.Update(((DataTable)Session["MyData"]));
            ((DataTable)Session["MyData"]).AcceptChanges();
        }
    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        fillData();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        fillProduct(ddlProduct);
        ddlBatch.Items.Clear();
        ddlBatch.Items.Insert(0, "--Select Batch--");
        fillData();
    }

    protected void GrdPrintLabel_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdPrintLabel.PageIndex = e.NewPageIndex;
        fillData();
    }


    protected void imgNew_Click1(object sender, EventArgs e)
    {
        Response.Redirect("AddLabelPasting.aspx");
    }
}