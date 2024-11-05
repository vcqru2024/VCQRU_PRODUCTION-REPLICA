using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Business9420;
using System.Data;


public partial class Manufacturer_AddBigDataAnalysis : System.Web.UI.Page
{
    private string _strcompidName;
    public string strcompidName
    {
        get { return (string)ViewState["_strcompidName"]; }
        set { ViewState["_strcompidName"] = value; }
    }
    private string _strcompid1;
    public string strcompid1
    {
        get { return (string)ViewState["_strcompid1"]; }
        set { ViewState["_strcompid1"] = value; }
    }
    private long _BigDataId;
    public long BigDataId
    {
        //get { return _prop_Referralid; }
        //set { _prop_Referralid = value; }
        get
        {
            if (ViewState["_BigDataId"] == null)
            {
                return 0;
            }
            else
            {
                return (long)ViewState["_BigDataId"];
            }

        }
        set { ViewState["_BigDataId"] = value; }
    }

    private string _strComp_idVS;
    public DataTable strComp_idVS
    {
        //get { return _prop_Referralid; }
        //set { _prop_Referralid = value; }
        get
        {
            if (ViewState["_strComp_idVS"] == null)
            {
                DataTable dt = null;
                return dt;
            }
            else
            {
                return (DataTable)ViewState["_strComp_idVS"];
            }

        }
        set { ViewState["_strComp_idVS"] = value; }
    }

    private string _Did_Prop;
    public string Did_Prop
    {
        get { return (string)ViewState["_Did_Prop"]; }
        set { ViewState["_Did_Prop"] = value; }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../default.aspx?Page=AddDealer.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            FillDDL();
            FillData();
            if (Request.QueryString["id"] != null)
            {
                Did_Prop = Convert.ToString(Request.QueryString["id"]);
                EditMode();
            }
         
            if (ProjectSession.strCompanyid == "")
            {
                //imgNew.Visible = false;
            }
        }
        //Label2.Text = "";
        
    }

    public void EditMode()
    {
        #region
       
        string[] strD = Did_Prop.Split('*');
        lblid.Text = strD[0];
        //string compidv = strD[1];
        strcompid1 = strD[1];
        strcompidName = strD[2];
        chkSendMail.Text = "Send Mail To (" + strcompidName + ")";
        if (!string.IsNullOrEmpty(lblid.Text))
            BigDataId = Convert.ToInt64(lblid.Text);
        //  Object9420 Reg = new Object9420();
        //  Reg.Testimonial_ID = e.CommandArgument.ToString();
        DataSet ds = ExecuteNonQueryAndDatatable.BigdataAnalysisSelect(BigDataId, strcompid1);


        if (ProjectSession.strCompanyid == "")
        {
            strComp_idVS = ds.Tables[1];
          //  trexcel.Visible = true;
        }
        ddlQty.SelectedValue = ds.Tables[0].Rows[0]["BigDataAnalysisDataid"].ToString();
        txtPrice.Text = ds.Tables[0].Rows[0]["Price"].ToString();

        //Doc1.Visible = true;
        //Doc2.Visible = true;
        //Doc1.HRef = ds.Tables[0].Rows[0]["f1"].ToString();
        //Doc2.HRef = ds.Tables[0].Rows[0]["f2"].ToString();
        //lblheading.Text = "Update Request for data (consumer data)";
        //RequiredFieldValidator1.ValidationGroup = "F1";
        //RequiredFieldValidator2.ValidationGroup = "F1";
        btnsave.Text = "Update";
       // ModalPopupTestimonial.Show();
        #endregion
    }


    public void FillDDL()
    {
        //ExecuteNonQueryAndDatatable.FillCompany(ddlCompany);
        //if (ProjectSession.strCompanyid != "")
        //{
        //    ddlCompany.SelectedValue = ProjectSession.strCompanyid;
        //    ddlCompany.Enabled = false;
        //}
        DataSet dsddl = ExecuteNonQueryAndDatatable.GetBigDataAnalysisSelectALL();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexIntValbyShweta(dsddl, "BigDataAnalysisDataid", "DataQty", ddlQty, "--Select--");
        ddlQty.SelectedIndex = 0;
        DataProvider.MyUtilities.FillDDLInsertZeroIndexIntValbyShweta(dsddl, "BigDataAnalysisDataid", "Price", ddlPrice, "--Select--");
        ddlPrice.SelectedIndex = 0;
    }
    public int index = 0, sno = 0, Flag = 0;
    private void FillData()
    {


        //DateTime? dttxtDateFrom = null;
        //if (!string.IsNullOrEmpty(txtDateFrom.Text))
        //{
        //    dttxtDateFrom = DateTime.Parse(txtDateFrom.Text);
        //}
        //DateTime? dttxtDateTo = null;
        //if (!string.IsNullOrEmpty(txtDateTo.Text))
        //{
        //    dttxtDateFrom = DateTime.Parse(txtDateTo.Text);
        //}
        //DataSet ds = ExecuteNonQueryAndDatatable.GetBigdataAnalysis(ddlCompany.SelectedValue, dttxtDateFrom, dttxtDateTo);
        //DataTable dt = FillDataaTable();
        //if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 999)
        //    GrdVwTestimonial.PageSize = dt.Rows.Count;
        //else
        //    GrdVwTestimonial.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        //GrdVwTestimonial.DataSource = dt;
        //GrdVwTestimonial.DataBind();
        //lblcount.Text = dt.Rows.Count.ToString();
        //if (GrdVwTestimonial.Rows.Count > 0)
        //    GrdVwTestimonial.HeaderRow.TableSection = TableRowSection.TableHeader;

    }
   // public DataTable FillDataaTable()
   // {
        //DateTime? dttxtDateFrom = null;
        //if (!string.IsNullOrEmpty(txtDateFrom.Text))
        //{
        //    dttxtDateFrom = DateTime.Parse(txtDateFrom.Text);
        //}
        //DateTime? dttxtDateTo = null;
        //if (!string.IsNullOrEmpty(txtDateTo.Text))
        //{
        //    dttxtDateTo = DateTime.Parse(txtDateTo.Text);
        //}
        //DataSet ds = ExecuteNonQueryAndDatatable.GetBigdataAnalysis(ddlCompany.SelectedValue, dttxtDateFrom, dttxtDateTo);
        //DataTable dt = ds.Tables[0];
        //return dt;
   // }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        //NewMsgpop.Visible = false;
        //txtDateFrom.Text = ""; txtDateTo.Text = ""; //ddlQty.SelectedValue="0";
        //ddlCompany.SelectedIndex = 0;
        //FillData();
    }

    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        //NewMsgpop.Visible = false;
        FillData();
    }

    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
       // NewMsgpop.Visible = false;
        FillData();
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        //BigDataId = 0;
        //strcompid1 = "";
        //strcompidName = "";
        //strComp_idVS = null;
        //ddlQty.SelectedIndex = 0;
        //ddlPrice.SelectedIndex = 0;
        //txtPrice.Text = "";
        //Doc1.Visible = false;
        //Doc2.Visible = false;
        //lblheading.Text = "Request for data (consumer data)";
        //btnsave.Text = "Save";
        ////RequiredFieldValidator1.ValidationGroup = "FTset";
        ////RequiredFieldValidator2.ValidationGroup = "FTset";
        //ModalPopupTestimonial.Show();
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        Int16 dataStatus = 0;
        if (ProjectSession.strCompanyid == "")
        {
            dataStatus = 1; // which is only entered by admin
        }

        DataSet ds = ExecuteNonQueryAndDatatable.InsertUpdateBigDataAnalysis(BigDataId, "", ProjectSession.strCompanyid == "" ? strcompid1 : ProjectSession.strCompanyid, dataStatus, Convert.ToInt32(ddlQty.SelectedValue), 0, ProjectSession.strCompanyid, "",
            ProjectSession.strUser_Type.ToLower(), DateTime.Now);
        int Requestd_DataCountLacking = 0;
        string sendTo = string.Empty;
        DataTable dt = ds.Tables[0];

        if (ProjectSession.strCompanyid == "")
        {
            if (dt.Rows.Count > 0)
            {
                Requestd_DataCountLacking = Convert.ToInt32(dt.Rows[0]["LackingDataCount"].ToString());
                sendTo = dt.Rows[0]["CompanyEmail"].ToString();
            }
            if (Requestd_DataCountLacking >= 0)
            {
                DivMshLac.Visible = true;
                DivMshLac.Attributes.Add("class", "alert_boxes_green big_msg");
                lblMshLac.Text = " Updated successfully...!";
                string script = @"setTimeout(function(){document.getElementById('" + DivMshLac.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
              //  ModalPopupTestimonial.Show();

                //NewMsgpop.Visible = true;
                //NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
                //Label2.Text = " Updated successfully...!";
                //string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);

                //   ddlQty.SelectedIndex = 0;
                //   FillData();
            }
            else
            {
                DivMshLac.Visible = true;
                DivMshLac.Attributes.Add("class", "alert_boxes_pink big_msg");
                lblMshLac.Text = " Updated successfully...!";
                string script = @"setTimeout(function(){document.getElementById('" + DivMshLac.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                //ModalPopupTestimonial.Show();
                // ddlQty.SelectedIndex = 0;
                // FillData();
            }
        }
        else
        {
            DivMshLac.Visible = true;
            DivMshLac.Attributes.Add("class", "alert_boxes_pink big_msg");
            lblMshLac.Text = " Requested consumer data is not available.";
            string script = @"setTimeout(function(){document.getElementById('" + DivMshLac.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);

            //NewMsgpop.Visible = true;
            //NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");
            //Label2.Text = " Updated successfully...!";
            //string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);

          //  ddlQty.SelectedIndex = 0;
          //  FillData();
        }
        Response.Redirect("BigDataAnalysis.aspx");

        //string path = "", filename = "";
        //if (FileUpload1.HasFile)
        //{
        //    path = Server.MapPath("../Data/Sound") + "\\Testimonial\\" + Reg.Comp_ID.ToString().Substring(5, 4);
        //    DataProvider.Utility.CreateDirectory(path);
        //    filename = FileUpload1.FileName;
        //    int lindex = filename.LastIndexOf('.');
        //    string ext = filename.Substring(lindex, filename.Length - lindex);
        //    filename = "Img1_" + (Reg.Testimonial_ID).ToString() + ext;
        //    path = path + "\\" + filename;
        //    FileUpload1.SaveAs(path);
        //    Reg.Img1 = filename;
        //}
        //if (FileUpload2.HasFile)
        //{
        //    path = Server.MapPath("../Data/Sound") + "\\Testimonial\\" + Session["CompanyId"].ToString().Substring(5, 4);

        //    filename = FileUpload2.FileName;
        //    int lindex = filename.LastIndexOf('.');
        //    string ext = filename.Substring(lindex, filename.Length - lindex);
        //    filename = "Img2_" + (Reg.Testimonial_ID).ToString() + ext;
        //    path = path + "\\" + filename;
        //    FileUpload2.SaveAs(path);
        //    Reg.Img2 = filename;
        //}




    }
    //protected void btnreset_Click(object sender, EventArgs e)
    //{
        
    ////    txtPrice.Text = "";
    ////    ddlQty.SelectedIndex = 0;
    ////    ddlPrice.SelectedIndex = 0;
    ////    //txtTestimonial.Text = string.Empty;
    ////    // txtTestimonial.Text = string.Empty;
    ////    // Doc1.Visible = false;
    ////    //Doc2.Visible = false;
    ////    lblheading.Text = "Add New Request for data";
    ////    //RequiredFieldValidator1.ValidationGroup = "FTset";
    ////    //RequiredFieldValidator2.ValidationGroup = "FTset";
    ////    btnsave.Text = "Save";
    ////    ModalPopupTestimonial.Show();


    //}
    protected void GrdVwTestimonial_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
      //  GrdVwTestimonial.PageIndex = e.NewPageIndex;
        FillData();
    }
    //protected void GrdVwTestimonial_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    txtTestimonial.Text = string.Empty;
    //    NewMsgpop.Visible = false;
    //    lblid.Text = e.CommandArgument.ToString();
    //    if (!string.IsNullOrEmpty(lblid.Text))
    //        BigDataId = Convert.ToInt32(lblid.Text);
    //    Object9420 Reg = new Object9420();
    //    Reg.Testimonial_ID = e.CommandArgument.ToString();
    //    DataSet ds = function9420.FillTestimonial(Reg);
    //    if (e.CommandName == "EditRow")
    //    {
    //        txtTestimonial.Text = ds.Tables[0].Rows[0]["Testimonial"].ToString();
    //        Doc1.Visible = true;
    //        Doc2.Visible = true;
    //        Doc1.HRef = ds.Tables[0].Rows[0]["f1"].ToString();
    //        Doc2.HRef = ds.Tables[0].Rows[0]["f2"].ToString();
    //        lblheading.Text = "Update Testimonial";
    //        //RequiredFieldValidator1.ValidationGroup = "F1";
    //        //RequiredFieldValidator2.ValidationGroup = "F1";
    //        btnsave.Text = "Update";
    //        ModalPopupTestimonial.Show();
    //    }
    //    else if (e.CommandName == "Confirm")
    //    {
    //        Reg.chkstr = "Confirm";
    //        Reg.Flag = Convert.ToInt32(ds.Tables[0].Rows[0]["Con_Flg"].ToString());
    //        function9420.UpdateTestimonial(Reg);
    //    }
    //    else if (e.CommandName == "Reject")
    //    {
    //        Reg.chkstr = "Reject";
    //        Reg.Flag = Convert.ToInt32(ds.Tables[0].Rows[0]["Del_Flg"].ToString());
    //        function9420.UpdateTestimonial(Reg);
    //    }
    //    else if (e.CommandName == "ChangeStatus")
    //    {
    //        Reg.chkstr = "ChangeStatus";
    //        Reg.Flag = Convert.ToInt32(ds.Tables[0].Rows[0]["Act_Flg"].ToString());
    //        function9420.UpdateTestimonial(Reg);
    //    }
    //    FillData();
    //}

    protected void GrdVwTestimonial_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        ////ddlQty.SelectedIndex = 0;
        ////NewMsgpop.Visible = false;


        ////// DataSet ds = function9420.FillTestimonial(Reg);
        ////if (e.CommandName == "EditRow")
        ////{
        ////    #region
        ////    Response.Redirect("AddBigDataAnalysis.aspx?id=" + e.CommandArgument.ToString());
        ////    string[] strD = e.CommandArgument.ToString().Split('*');
        ////    lblid.Text = strD[0];
        ////    //string compidv = strD[1];
        ////    strcompid1 = strD[1];
        ////    strcompidName = strD[2];
        ////    chkSendMail.Text = "Send Mail To (" + strcompidName + ")";
        ////    if (!string.IsNullOrEmpty(lblid.Text))
        ////        BigDataId = Convert.ToInt64(lblid.Text);
        ////    //  Object9420 Reg = new Object9420();
        ////    //  Reg.Testimonial_ID = e.CommandArgument.ToString();
        ////    DataSet ds = ExecuteNonQueryAndDatatable.BigdataAnalysisSelect(BigDataId, strcompid1);


        ////    if (ProjectSession.strCompanyid == "")
        ////    {
        ////        strComp_idVS = ds.Tables[1];
        ////        trexcel.Visible = true;
        ////    }
        ////    ddlQty.SelectedValue = ds.Tables[0].Rows[0]["BigDataAnalysisDataid"].ToString();
        ////    txtPrice.Text = ds.Tables[0].Rows[0]["Price"].ToString();

        ////    //Doc1.Visible = true;
        ////    //Doc2.Visible = true;
        ////    //Doc1.HRef = ds.Tables[0].Rows[0]["f1"].ToString();
        ////    //Doc2.HRef = ds.Tables[0].Rows[0]["f2"].ToString();
        ////    lblheading.Text = "Update Request for data (consumer data)";
        ////    //RequiredFieldValidator1.ValidationGroup = "F1";
        ////    //RequiredFieldValidator2.ValidationGroup = "F1";
        ////    btnsave.Text = "Update";
        ////    ModalPopupTestimonial.Show();
        //    #endregion
        //}
        //else if (e.CommandName == "Reject")
        //{
        //    #region
        //    BigDataId = Convert.ToInt64(e.CommandArgument.ToString());
        //    ExecuteNonQueryAndDatatable.BigdataAnalysisDelete(BigDataId, ProjectSession.strCompanyid);
        //    //FillData();
        //    // Reg.chkstr = "Reject";
        //    // Reg.Flag = Convert.ToInt32(ds.Tables[0].Rows[0]["Del_Flg"].ToString());
        //    // function9420.UpdateTestimonial(Reg);
        //    FillData();
        //    #endregion
        //}
        //else if (e.CommandName == "DownloadConsumer")
        //{
        //    string[] strD = e.CommandArgument.ToString().Split('*');
        //    BigDataId = Convert.ToInt64(strD[0]);
        //    strcompid1 = strD[1];
        //    strcompidName = strD[2];
        //    // chkSendMail.Text = "Send Mail To (" + strcompidName + ")";

        //    DataSet ds = ExecuteNonQueryAndDatatable.BigdataAnalysisSelect(BigDataId);

        //    if (ds.Tables.Count > 0)
        //    {
        //        strComp_idVS = ds.Tables[0];
        //        downloadExcel();
        //    }
        //}

      
      
    }

    protected void ddlQty_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataSet dsddl = ExecuteNonQueryAndDatatable.GetTableData("BigDataAnalysisData", "BigDataAnalysisDataid", ddlQty.SelectedValue, "", 1);
        DataProvider.MyUtilities.FillDDLInsertZeroIndexIntValbyShweta(dsddl, "BigDataAnalysisDataid", "Price", ddlPrice, "--Select--");
        // ddlPrice.SelectedIndex = 0;
        if (dsddl.Tables[0].Rows.Count > 0)
        {
            txtPrice.Text = dsddl.Tables[0].Rows[0]["Price"].ToString();
            DataSet ds = ExecuteNonQueryAndDatatable.BigdataAnalysisSelectDDL(BigDataId, strcompid1, Convert.ToInt32(ddlQty.SelectedValue));

            // DataSet ds = function9420.FillTestimonial(Reg);

            if (ProjectSession.strCompanyid == "")
            {
                if (ds.Tables.Count > 1)
                {
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        strComp_idVS = ds.Tables[1];
                    }
                }

            }
        }
       // ModalPopupTestimonial.Show();
    }

    protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
    {

    }



    protected void btnExceldwn_Click1(object sender, ImageClickEventArgs e)
    {


        downloadExcel();


        //   ExecuteNonQueryAndDatatable.GetConsumerDataForCompany();
        //if (strComp_idVS != null)
        //{
        //    DataTable dt = strComp_idVS;
        //    DataView dv = new DataView(dt);
        //    DataTable dt2 = dv.ToTable("Selected", true, "CompanyName", "ConsumerName", "Email", "MobileNo", "Address", "City", "PinCode");
        //    //DataTable dt = SQL_DB.ExecuteDataSet(Qry).Tables[0];
        //    PDFCLass.downloadExcel(dt2, "Consumer_Data");

        //}
    }


    private void downloadExcel()
    {
        if (strComp_idVS != null)
        {
            DataTable dt = strComp_idVS;
            DataView dv = new DataView(dt);
            DataTable dt2 = dv.ToTable("Selected", true, "ConsumerName", "Email", "MobileNo", "Address", "City", "PinCode");
            //DataTable dt = SQL_DB.ExecuteDataSet(Qry).Tables[0];
            PDFCLass.downloadExcel(dt2, "Consumer_Data");

        }
        //  Response.Clear();
        //  Response.Charset = "";
        //  Response.AddHeader("content-disposition", "attachment;filename=" + FileName + ".xls");
        //  Response.ContentType = "application/vnd.ms-excel";

        //  StringWriter writer = new StringWriter();
        //  Html32TextWriter htmlwriter = new Html32TextWriter(writer);
        //  DataGrid grd = new DataGrid();
        //  grd.DataSource = dt;
        //  grd.DataBind();
        //  grd.RenderControl(htmlwriter);
        //  Response.Write(writer.ToString());
        //  //Response.BinaryWrite(WriteToStream(ReadDataTableToExcel(dt, sheetName, 1000)).GetBuffer());
        ////  Response.BinaryWrite();
        //  grd.AlternatingItemStyle.BackColor = System.Drawing.Color.LightSkyBlue;
        //  Response.End();
        //  htmlwriter.Close();
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        //DataSet ds = ExecuteNonQueryAndDatatable.BigdataAnalysisSelect(4);

        //if (ds.Tables.Count > 0)
        //{
        //    strComp_idVS = ds.Tables[0];
        //    downloadExcel();
        //}
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        Response.Redirect("BigDataAnalysis.aspx");
    }
}