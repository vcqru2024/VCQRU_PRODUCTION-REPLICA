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
using System.Text;
using DataProvider;
public partial class Patanjali_AddProductDetails : System.Web.UI.Page
{
    public Int64 _Proid_Prop;
    public Int64 Proid_Prop
    {
        get
        {

            if (ViewState["_Proid_Prop"] == null)
            { return 0; }
            else
            {
                return (Int64)ViewState["_Proid_Prop"];
            }

        }
        set { ViewState["_Proid_Prop"] = value; }
    }

    cls_patanjali db = new cls_patanjali();
    DataTable PrintLabelInfo = new DataTable();
    DataTable PrintLabelInfoEdit = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../Info/Login.aspx?Page=ProductDetails.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        //Clear();
        if (!Page.IsPostBack)
        {
            #region User Log 
            if (Session["UserName"] != null)
            {
                db.ExceptionLogs("Visited on AssignLable To Product", Session["UserName"].ToString(), "R");
            }
            else
            {
                db.ExceptionLogs("Visited on AssignLable To Product", Session["Comp_Name"].ToString(), "R");
            }
            #endregion
            //  Clear();
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            //if (Session["Comp_type"].ToString() == "D")
            //    imgNew.Visible = false;
            //else
            //    imgNew.Visible = true;

            if (Request.QueryString["id"] != null)
            {
                Proid_Prop = Convert.ToInt64(Request.QueryString["id"]);
            }
            if (Proid_Prop > 0)
            { filldata(); }
            else
            {
                fillddlPro_Id();
            }


            // BigpopMsg.Visible = false;
            PrintLabelInfoEdit = CreateFileDataTable();
            PrintLabelInfo = CreateFileDataTable();
            Session["PrintLabel"] = PrintLabelInfo;
            Session["LBLInfoEdit"] = PrintLabelInfoEdit;
            Session["ProID"] = "";
        }
    }

    public void FillPage()
    {
        Fieldset1.Visible = true;
        lblbatchsize.Text = string.Empty;
        ((DataTable)Session["PrintLabel"]).Rows.Clear();
        FillGrdLabelInfo();
        chkHindi.Enabled = false;
        chkEnglish.Enabled = false;
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Row_ID FROM Pro_Reg where Comp_ID = '" + Session["CompanyId"].ToString() + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            Object9420 obj = new Object9420();
            obj.Comp_ID = Session["CompanyId"].ToString();
            //DataSet ds = function9420.FetchProduct_Id(obj);

            DataSet ds1 = ExecuteNonQueryAndDatatable.GetProductDetailsNoofCodes(obj.Comp_ID);
            //DataSet ds1 = Business9420.function9420.SelectProductDetailsNoofCodes(obj);
            //DataSet ds2 = Business9420.function9420.SelectProductDetailsNoofCodesChk(obj);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                if (ChkDispatchLabels(ds1.Tables[0], ds1.Tables[1]))
                {
                    Clear();
                    // BigpopMsg.Visible = false;
                    ChangeValidationGroup(true);
                    fillddlPro_Id(ds1);
                    //  ProductDetailsPopUp.Show();
                }
                else
                {
                    // btnYesActivation.Text = "OK";
                    //  btnNoActivation.Text = "Close";
                    //  btnNoActivation.Visible = false;
                    //  lblPassPnlHead.Text = "Alert";
                    lblCompPassText.Text = "Please receive courier, First !";
                    //  ModalPopupExtenderAlert.Show();
                }
               
            }
            else
            {
                //DataSet ds3 = Business9420.function9420.SelectProductDetailsNoofCodesPrint(obj);
                // note: - ds1.Table[2] is  DataSet ds3
                //if (ds3.Tables[0].Rows.Count == 0)
                if (ds1.Tables[2].Rows.Count == 0)
                {
                    if (ds1.Tables[1].Rows.Count == 0)
                    {
                        btnYesActivation.Text = " OK ";
                        lblCompPassText.Text = "Your requested print labels are not dispatch.";
                        lblCompPassText.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        btnYesActivation.Text = "OK";
                        lblCompPassText.Text = "Please receive courier, First !";
                    }
                    //if (ds2.Tables[0].Rows.Count == 0)
                    //{
                    //    btnYesActivation.Text = " OK ";
                    //    lblCompPassText.Text = "Your requested print labels are not dispatch.";
                    //    lblCompPassText.ForeColor = System.Drawing.Color.Red;
                    //}
                    //else
                    //{
                    //    btnYesActivation.Text = "OK";
                    //    lblCompPassText.Text = "Please receive courier, First !";
                    //}
                }
                else
                {
                    btnYesActivation.Text = "OK";
                    lblCompPassText.Text = "Please receive courier, First !";
                }
                btnNoActivation.Text = "Close";
                btnNoActivation.Visible = false;
                lblPassPnlHead.Text = "Alert";
                // ModalPopupExtenderAlert.Show();
            }
        }
        else
        {
            btnYesActivation.Text = "Ok";
            btnNoActivation.Text = "Close";
            btnNoActivation.Visible = false;
            lblPassPnlHead.Text = "Alert";
            lblCompPassText.Text = "Please registered product, First ?";
            // ModalPopupExtenderAlert.Show();
        }
    }

    protected void btnNoActivation_Click(object sender, EventArgs e)
    {

    }
    private void fillddlPro_IdEdit()
    {
        Object9420 obj = new Object9420();
        obj.Comp_ID = Session["CompanyId"].ToString();
        DataSet ds = Business9420.function9420.SelectProductDetailsNoofCodesEdit(obj);
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProduct, "--Select--");
        ddlProduct.SelectedIndex = 0;
        //lblcount.Text = GrdProductMaster.Rows.Count.ToString();
    }

    private void fillddlPro_Id()
    {


        Object9420 obj = new Object9420();
        obj.Comp_ID = Session["CompanyId"].ToString();
        //  DataSet ds = Business9420.function9420.SelectProductDetailsNoofCodes(obj);
        // [PROC_SelectProductDetailsNoofCodes_ddl]
        DataSet ds = ExecuteNonQueryAndDatatable.GetProductDetailsNoofCodes_ddl(obj.Comp_ID);
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProduct, "--Select--");
        ddlProduct.SelectedIndex = 0;
        //if (ds.Tables[0].Rows.Count > 0)
        //    lblcount.Text = GrdProductMaster.Rows.Count.ToString();
        //else
        //    lblcount.Text = "0";
    }
    private void fillddlPro_Id(DataSet ds)
    {
        Object9420 obj = new Object9420();
        obj.Comp_ID = Session["CompanyId"].ToString();
        // DataSet ds = Business9420.function9420.SelectProductDetailsNoofCodes(obj);
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProduct, "--Select--");
        ddlProduct.SelectedIndex = 0;
        //if (ds.Tables[0].Rows.Count > 0)
        //    lblcount.Text = GrdProductMaster.Rows.Count.ToString();
        //else
        //    lblcount.Text = "0";
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
    [WebMethod]
    [ScriptMethod]
    public static string WriteProIDHelloCheck(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Pro_Reg.Comp_ID, Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, (SELECT COUNT(Pro_ID) AS Expr1 FROM M_Code WHERE  isnull(M_Code.ScrapeFlag,0)= 0 AND      (Pro_ID = Pro_Reg.Pro_ID) AND (Print_Status = 1) AND (M_Code.Batch_No IS NULL) AND (M_Code.DispatchFlag = 1) AND (M_Code.ReceiveFlag = 1) ) AS PrintCodes FROM  Comp_Reg INNER JOIN Pro_Reg ON Comp_Reg.Comp_ID = Pro_Reg.Comp_ID LEFT OUTER JOIN M_Code AS M_Code_1 ON Pro_Reg.Pro_ID = M_Code_1.Pro_ID WHERE     (Pro_Reg.Comp_ID = '" + HttpContext.Current.Session["CompanyId"] + "') AND Pro_Reg.Pro_ID= '" + res + "' GROUP BY Pro_Reg.Comp_ID, Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, Comp_Reg.Comp_Name");
        if (ds.Tables[0].Rows.Count > 0)
        {
            string pro = Convert.ToString(SQL_DB.ExecuteScalar("SELECT BatchSize FROM Pro_Reg  WHERE Pro_ID = '" + ds.Tables[0].Rows[0]["Pro_ID"].ToString() + "' "));
            return ds.Tables[0].Rows[0]["PrintCodes"].ToString() + "-" + res + "-" + pro;
        }
        else
            return "0-" + res + "-0";
    }

    [WebMethod]
    [ScriptMethod]
    public static bool checkNewProduct(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + HttpContext.Current.Session["CompanyId"] + "' and [Pro_Name] = '" + res + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkCodesForAvilable(string res)
    {
        DataSet ds = new DataSet();
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = HttpContext.Current.Session["CompanyId"].ToString();
        Business9420.function9420.FindAvilableCodesNew(Reg);
        //LblAvlCodes.Text = ; Reg.Password = "";
        if (res.ToString() != "" || res.ToString() != null)
        {
            if (Convert.ToInt32(res) > Convert.ToInt32(Reg.Password))
                return true;
            else
                return false;
        }
        else
            return true;
    }
    [WebMethod]
    [ScriptMethod]
    public static bool CheckBatch_No(string res)
    {
        string[] Arr = res.ToString().Split('-');
        if (Arr.Length != 1)
        {
            string Batch_No = Arr[0]; string Pro_Id = Arr[1];
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT Batch_No FROM T_Pro WHERE Pro_ID='" + Pro_Id + "' AND Batch_No='" + Batch_No + "'");
            if (ds.Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }
        else
            return true;
    }
    private void filldata()
    {
        Fieldset1.Visible = false;
        Clear();
        fillddlPro_IdEdit();
        Object9420 obj = new Object9420();
        obj.Row_ID = Proid_Prop.ToString(); hdneditrowid.Value = Proid_Prop.ToString();
        Business9420.function9420.FetchDataUpdateBatchProductDetails(obj);
        Business9420.function9420.FindOldNoofCodes(obj);
        lblproid.Text = obj.Row_ID;
        lblnoofcodes.Text = obj.NoofCodes.ToString();
        txtBatchNo.Text = obj.Batch_No;
        if (Convert.ToDateTime(obj.Mfd_Date).ToString("dd/MM/yyyy") != "01/01/1900")
            txtMfd_Date.Text = obj.Mfd_Date.ToString();
        else
            txtMfd_Date.Text = "";
        //txtMfd_Date.Text = obj.Mfd_Date.ToString();
        if (obj.Exp_Date.ToString() != "")
        {
            txtExp_Date.Text = obj.Exp_Date.ToString();
            if (Convert.ToDateTime(obj.Exp_Date).ToString("dd/MM/yyyy") != "01/01/1900")
                txtExp_Date.Text = obj.Exp_Date.ToString();
            else
                txtExp_Date.Text = "";
        }
        else
            txtExp_Date.Text = "";
        txtMRP.Text = obj.MRP.ToString();
        txtComment.Text = obj.Comments;
        txtNoOfCodes.Text = lblnoofcodes.Text;
        txtWarr.Text = obj.Warranty.ToString();
        //if (Session["Comp_type"].ToString() == "D")
        txtNoOfCodes.Enabled = false;
        //else
        //    txtNoOfCodes.Enabled = true;
        SFileE.HRef = obj.EnglishFle;
        SFileH.HRef = obj.HindiFile;
        ddlProduct.SelectedValue = obj.Pro_ID.ToString();
        HDF.Value = ddlProduct.SelectedValue;
        obj.Comp_ID = Session["CompanyId"].ToString();
        Business9420.function9420.FindAvilableCodes(obj);
        LblAvlCodes.Text = (Convert.ToInt32(lblnoofcodes.Text) + Convert.ToInt32(obj.Password)).ToString(); obj.Password = "";
        //string MySeriesDet = obj.statusstr.ToString().Replace("From  ", "").Replace("   To  ", ",").Trim();
        //string[] Arr = MySeriesDet.ToString().Split(',');
        //string[] Arr1 = Arr[0].ToString().Split('-');
        //string[] Arr2 = Arr[1].ToString().Split('-');
        //txtSeries_Initial1.Text = Arr1[0].ToString();
        //txtSeries_Initial.Text = string.Format("{0:00}", Convert.ToInt32(Arr1[1].ToString()));
        //txtSeriesFrom.Text = string.Format("{0:000}", Convert.ToInt32(Arr1[2].ToString()));
        //txtSeriesTo.Text = string.Format("{0:000}", Convert.ToInt32(Arr2[2].ToString()));
        //hdnSerialOrder.Value = Arr1[1].ToString();
        //hdnSeriesFrom.Value = Arr1[2].ToString();
        //hdnSeriesTo.Value = Arr2[2].ToString(); 
        lblbatchsize.Text = obj.BatchSize.ToString();

        #region change validation group for brand loyalty
        string ValGroup = "PRO"; bool Visible = false;
        DataTable dst = SQL_DB.ExecuteDataSet("SELECT Comments,Points FROM M_Loyalty WHERE IsActive = 0 AND IsDelete = 0 AND Pro_ID='" + ddlProduct.SelectedValue.ToString() + "'").Tables[0];
        if (dst.Rows.Count > 0)
        {
            ValGroup = "NA";
            Visible = false;
        }
        else
        {
            ValGroup = "PRO";
            Visible = true;
        }
        RequiredFieldValidator3.ValidationGroup = ValGroup;
        RequiredFieldValidator4.ValidationGroup = ValGroup;
        RequiredFieldValidator1.ValidationGroup = ValGroup;
        //btn.Visible = Visible;
        //  mrp.Visible = Visible;
        mfd.Visible = Visible;
        #endregion

        btnSave.Text = "Update";
        lblheading.Text = "Update Product Details";
        ChangeValidationGroup(false);
        // ProductDetailsPopUp.Show();
        //  ProductDetailsPopUp.Show();


        //DataSet ds = new DataSet();
        //Object9420 Reg = new Object9420();
        //Reg.Comp_ID = Session["CompanyId"].ToString();
        //Reg.Pro_Name = txtProductName.Text.Trim().Replace("'", "''");
        //if (txtDateFrom.Text != "")
        //    Reg.datefromstr = Convert.ToString(Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd"));
        //else
        //    Reg.datefromstr = "1900/01/01";
        //if (txtDateTo.Text != "")
        //    Reg.datetostr = Convert.ToString(Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd"));
        //else
        //    Reg.datetostr = DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd");
        //if (txtDateFrom.Text == "" && txtDateTo.Text == "")
        //    Reg.chkstr = "";
        //else if (txtDateFrom.Text != "" && txtDateTo.Text == "")
        //    Reg.chkstr = " and Convert(varchar,T_Pro.Mfd_Date,111) >= '" + Reg.datefromstr + "' ";
        //else if (txtDateFrom.Text == "" && txtDateTo.Text != "")
        //    Reg.chkstr = " and Convert(varchar,T_Pro.Mfd_Date,111) <= '" + Reg.datetostr + "' ";
        //else if (txtDateFrom.Text != "" && txtDateTo.Text != "")
        //    Reg.chkstr = " and Convert(varchar,T_Pro.Mfd_Date,111) >= '" + Reg.datefromstr + "'and Convert(varchar,T_Pro.Mfd_Date,111) <= '" + Reg.datetostr + "' ";
        //ds = function9420.FillGridDetails(Reg);
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
    private bool ChkDispatchLabels(DataSet ds, DataSet ds1)
    {
        Object9420 obj = new Object9420();
        obj.Comp_ID = Session["CompanyId"].ToString();
        //DataSet ds = Business9420.function9420.SelectProductDetailsNoofCodes(obj);
        //DataSet ds1 = Business9420.function9420.SelectProductDetailsNoofCodesChk(obj);
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
        {
            if (ds1.Tables[0].Rows.Count > 0)
                return false;
            else
                return true;
        }
    }
    private bool ChkDispatchLabels(DataTable ds, DataTable ds1)
    {
        Object9420 obj = new Object9420();
        obj.Comp_ID = Session["CompanyId"].ToString();
        //DataSet ds = Business9420.function9420.SelectProductDetailsNoofCodes(obj);
        //DataSet ds1 = Business9420.function9420.SelectProductDetailsNoofCodesChk(obj);
        if (ds.Rows.Count > 0)
            return true;
        else
        {
            if (ds1.Rows.Count > 0)
                return false;
            else
                return true;
        }
    }
    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {

        string res = "";
        if (ddlProduct.SelectedIndex > 0)
        {
            res = ddlProduct.SelectedValue.ToString();
            DataSet ds = ExecuteNonQueryAndDatatable.GetDetailsbyPro_id(HttpContext.Current.Session["CompanyId"].ToString(), res);
            // DataSet ds = SQL_DB.ExecuteDataSet("SELECT Pro_Reg.Comp_ID, Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, (SELECT COUNT(Pro_ID) AS Expr1 FROM M_Code WHERE  isnull(M_Code.ScrapeFlag,0)= 0 AND      (Pro_ID = Pro_Reg.Pro_ID) AND (Print_Status = 1) AND (M_Code.Batch_No IS NULL) AND (M_Code.DispatchFlag = 1) AND (M_Code.ReceiveFlag = 1) ) AS PrintCodes FROM  Comp_Reg INNER JOIN Pro_Reg ON Comp_Reg.Comp_ID = Pro_Reg.Comp_ID LEFT OUTER JOIN M_Code AS M_Code_1 ON Pro_Reg.Pro_ID = M_Code_1.Pro_ID WHERE     (Pro_Reg.Comp_ID = '" + HttpContext.Current.Session["CompanyId"] + "') AND Pro_Reg.Pro_ID= '" + res + "' GROUP BY Pro_Reg.Comp_ID, Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, Comp_Reg.Comp_Name");
            if (ds.Tables[0].Rows.Count > 0)
            {
                // string pro = Convert.ToString(SQL_DB.ExecuteScalar("SELECT BatchSize FROM Pro_Reg  WHERE Pro_ID = '" + ds.Tables[0].Rows[0]["Pro_ID"].ToString() + "' "));
                string pro = string.Empty;
                if (ds.Tables[1].Rows.Count > 0)
                {
                    pro = Convert.ToString(ds.Tables[1].Rows[0][0]);
                }

                LblAvlCodes.Text = ds.Tables[0].Rows[0]["PrintCodes"].ToString();
                HdnAvlCodes.Value = ds.Tables[0].Rows[0]["PrintCodes"].ToString();
                txtSeries_Initial1.Text = res;
                HdnSeriesIni.Value = res;
                lblbatchsize.Text = pro;
                HdnBatchSize.Value = pro;
                #region Fill Auto Label details for Virtual labels
                //DataTable dds = SQL_DB.ExecuteDataTable("SELECT TOP (1) Label_Code FROM M_Label_Request WHERE (Pro_ID = '" + ds.Tables[0].Rows[0]["Pro_ID"].ToString() + "') AND (Flag = 1) ORDER BY Row_ID DESC");
                DataTable dds = ds.Tables[2];
                if (dds.Rows[0]["Label_Code"].ToString() == "LBL_1000")
                {

                    #region Auto Fill Data
                    PrintLabelInfo = CreateFileDataTable();
                    Session["PrintLabel"] = PrintLabelInfo;
                    string AddQry = " WHERE Pro_ID='" + ddlProduct.SelectedValue + "' AND ISNULL(Batch_No,'')  = '' AND ISNULL(Print_Date,'')  <> '' AND ISNULL(DispatchFlag,'') = 1  AND ISNULL(ReceiveFlag,'') = 1 ";
                    //    DataTable Mdt = SQL_DB.ExecuteDataTable("SELECT LabelRequestId from m_code " + AddQry + " GROUP BY  LabelRequestId");
                    //-----------------shweta code
                    //  DataTable Mdt = dds.Tables[1];                  
                    DataView dview1 = new DataView();
                    DataSet dataset1 = ExecuteNonQueryAndDatatable.GetM_Label_RequestbyPro_id(ddlProduct.SelectedValue.Trim());
                    dview1.Table = dataset1.Tables[0];
                    DataTable Mdt = dview1.ToTable(true, "LabelRequestId");//SQL_DB.ExecuteDataTable("SELECT LabelRequestId from m_code " + AddQry + " GROUP BY  LabelRequestId");   

                    DataView dview2;
                    //-----------------end
                    if (Mdt.Rows.Count > 0)
                    {
                        #region
                        for (int p = 0; p < Mdt.Rows.Count; p++)
                        {
                            //-----------------------Shweta
                            dview2 = new DataView();
                            dview2.Table = dataset1.Tables[0];
                            dview2.RowFilter = " LabelRequestId = '" + Mdt.Rows[p]["LabelRequestId"].ToString() + "'";
                            DataTable Modt = dview2.ToTable();//  DataTable Modt = SQL_DB.ExecuteDataTable("SELECT DISTINCT Series_Order FROM M_Code " + AddQry);

                            //--------------------------End

                            //AddQry = " WHERE Pro_ID='" + ddlProduct.SelectedValue + "' AND ISNULL(Batch_No,'') = '' AND ISNULL(Print_Date,'')  <> '' AND ISNULL(DispatchFlag,'') = 1  AND ISNULL(ReceiveFlag,'') = 1 ";
                            //AddQry += " AND LabelRequestId = '" + Mdt.Rows[p]["LabelRequestId"].ToString() + "'";
                            //DataTable Modt = SQL_DB.ExecuteDataTable("SELECT DISTINCT Series_Order FROM M_Code " + AddQry);

                            if (Modt.Rows.Count > 0)
                            {
                                #region
                                for (int q = 0; q < Modt.Rows.Count; q++)
                                {
                                    AddQry += "  AND Series_Order = '" + Modt.Rows[q]["Series_Order"].ToString() + "' ";
                                    string seriesFrom = "", seriesTo = ""; Int64 LabelQty = 0, SFrom = 0, STo = 0;
                                    txtSeries_Initial.Text = string.Format("{0:0000}", Convert.ToInt64(Modt.Rows[q]["Series_Order"]));

                                    //DataTable Mindt = SQL_DB.ExecuteDataTable("SELECT MIN(Series_Serial) as Series_SerialFrom FROM M_Code " + AddQry);
                                    //if (Mindt.Rows.Count > 0)
                                    //{
                                    //    seriesFrom = string.Format("{0:0000}", Convert.ToInt64(Mindt.Rows[0]["Series_SerialFrom"]));
                                    //    SFrom = Convert.ToInt64(Mindt.Rows[0]["Series_SerialFrom"]);
                                    //}
                                    //DataTable Maxdt = SQL_DB.ExecuteDataTable("SELECT MAX(Series_Serial) as Series_SerialTo FROM M_Code " + AddQry);
                                    //if (Mindt.Rows.Count > 0)
                                    //{
                                    //    seriesTo = string.Format("{0:0000}", Convert.ToInt64(Maxdt.Rows[0]["Series_SerialTo"]));
                                    //    STo = Convert.ToInt64(Maxdt.Rows[0]["Series_SerialTo"]);
                                    //}

                                    //----------------shweta

                                    seriesFrom = string.Format("{0:0000}", Convert.ToInt64(Modt.Rows[q]["Series_SerialFrom"]));
                                    SFrom = Convert.ToInt64(Modt.Rows[q]["Series_SerialFrom"]);

                                    seriesTo = string.Format("{0:0000}", Convert.ToInt64(Modt.Rows[q]["Series_SerialTo"]));
                                    STo = Convert.ToInt64(Modt.Rows[q]["Series_SerialTo"]);
                                    //-------------------------------------end

                                    if (SFrom == 0)
                                        LabelQty = ++STo;
                                    else
                                        LabelQty = STo - SFrom + 1;
                                    #region
                                    DataTable myTable = (DataTable)Session["PrintLabel"];
                                    AddPrintLabelInfo("", ddlProduct.SelectedValue.ToString(), txtSeries_Initial.Text.Trim().Replace("'", "''"), seriesFrom, seriesTo, LabelQty.ToString(), (DataTable)Session["PrintLabel"]);
                                    clearinfo();
                                    FillGrdLabelInfo();
                                    AddQry = " WHERE Pro_ID='" + ddlProduct.SelectedValue + "' AND ISNULL(Batch_No,'') = '' AND ISNULL(Print_Date,'')  <> '' AND ISNULL(DispatchFlag,'') = 1  AND ISNULL(ReceiveFlag,'') = 1 ";
                                    #endregion
                                }
                                #endregion
                            }
                        }
                        #endregion
                    }
                    #endregion
                }
                else
                {
                    #region Clear Auto fill or mannual fill data
                    PrintLabelInfo = CreateFileDataTable();
                    Session["PrintLabel"] = PrintLabelInfo;
                    clearinfo();
                    FillGrdLabelInfo();
                    #endregion
                }
                #endregion
            }
            else
            {
                //return "0-" + res + "-0";
                LblAvlCodes.Text = "0";
                HdnAvlCodes.Value = "0";
                txtSeries_Initial1.Text = res;
                HdnSeriesIni.Value = res;
                lblbatchsize.Text = "0";
                HdnBatchSize.Value = "0";
            }

            string ValGroup = "PRO"; bool Visible = false;
            // Check for Counter Fitting Service is Exist then Mandaory fields
            DataTable dst = SQL_DB.ExecuteDataSet("SELECT Subscribe_Id FROM M_ServiceSubscription WHERE (Service_ID = 'SRV1018') AND (Pro_ID = '" + ddlProduct.SelectedValue.ToString() + "') AND (GETDATE() BETWEEN DateFrom AND DateTo) ").Tables[0];//AND (IsActive = 1) AND (IsDelete = 0) AND (IsAdminVerify = 1)
            //DataTable dst = SQL_DB.ExecuteDataSet("SELECT Comments,Points FROM M_Loyalty WHERE IsActive = 0 AND IsDelete = 0 AND Pro_ID='" + ddlProduct.SelectedValue.ToString() + "'").Tables[0];
            if (dst.Rows.Count == 0)
            {
                ValGroup = "NA";
                Visible = false;
            }
            else
            {
                ValGroup = "PRO";
                Visible = true;
            }
            RequiredFieldValidator3.ValidationGroup = ValGroup;
            RequiredFieldValidator4.ValidationGroup = ValGroup;
            RequiredFieldValidator1.ValidationGroup = ValGroup;
            //   btn.Visible = Visible;
            //   mrp.Visible = Visible;
            mfd.Visible = Visible;
        }
        else
        {
            //return "0-" + res + "-0";
            LblAvlCodes.Text = "";
            HdnAvlCodes.Value = "0";
            txtSeries_Initial1.Text = "";
            HdnSeriesIni.Value = "";
            lblbatchsize.Text = "";
            HdnBatchSize.Value = "0";
        }
        // ProductDetailsPopUp.Show();
    }

    protected void ddlProduct_SelectedIndexChanged_old(object sender, EventArgs e)
    {

        string res = "";
        if (ddlProduct.SelectedIndex > 0)
        {
            res = ddlProduct.SelectedValue.ToString();
            //   DataSet ds = ExecuteNonQueryAndDatatable.GetDetailsbyPro_id(HttpContext.Current.Session["CompanyId"].ToString(), res);
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT Pro_Reg.Comp_ID, Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, (SELECT COUNT(Pro_ID) AS Expr1 FROM M_Code WHERE  isnull(M_Code.ScrapeFlag,0)= 0 AND      (Pro_ID = Pro_Reg.Pro_ID) AND (Print_Status = 1) AND (M_Code.Batch_No IS NULL) AND (M_Code.DispatchFlag = 1) AND (M_Code.ReceiveFlag = 1) ) AS PrintCodes FROM  Comp_Reg INNER JOIN Pro_Reg ON Comp_Reg.Comp_ID = Pro_Reg.Comp_ID LEFT OUTER JOIN M_Code AS M_Code_1 ON Pro_Reg.Pro_ID = M_Code_1.Pro_ID WHERE     (Pro_Reg.Comp_ID = '" + HttpContext.Current.Session["CompanyId"] + "') AND Pro_Reg.Pro_ID= '" + res + "' GROUP BY Pro_Reg.Comp_ID, Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, Comp_Reg.Comp_Name");
            if (ds.Tables[0].Rows.Count > 0)
            {
                string pro = Convert.ToString(SQL_DB.ExecuteScalar("SELECT BatchSize FROM Pro_Reg  WHERE Pro_ID = '" + ds.Tables[0].Rows[0]["Pro_ID"].ToString() + "' "));
                //string pro = string.Empty;
                //if (ds.Tables[1].Rows.Count > 0)
                //{
                //    pro = Convert.ToString(ds.Tables[1].Rows[0][0]);
                //}

                LblAvlCodes.Text = ds.Tables[0].Rows[0]["PrintCodes"].ToString();
                HdnAvlCodes.Value = ds.Tables[0].Rows[0]["PrintCodes"].ToString();
                txtSeries_Initial1.Text = res;
                HdnSeriesIni.Value = res;
                lblbatchsize.Text = pro;
                HdnBatchSize.Value = pro;
                #region Fill Auto Label details for Virtual labels
                DataTable dds = SQL_DB.ExecuteDataTable("SELECT TOP (1) Label_Code FROM M_Label_Request WHERE (Pro_ID = '" + ds.Tables[0].Rows[0]["Pro_ID"].ToString() + "') AND (Flag = 1) ORDER BY Row_ID DESC");
                //DataTable dds = ds.Tables[2];
                if (dds.Rows[0]["Label_Code"].ToString() == "LBL_1000")
                {

                    #region Auto Fill Data
                    PrintLabelInfo = CreateFileDataTable();
                    Session["PrintLabel"] = PrintLabelInfo;
                    string AddQry = " WHERE Pro_ID='" + ddlProduct.SelectedValue + "' AND ISNULL(Batch_No,'')  = '' AND ISNULL(Print_Date,'')  <> '' AND ISNULL(DispatchFlag,'') = 1  AND ISNULL(ReceiveFlag,'') = 1 ";
                    DataTable Mdt = SQL_DB.ExecuteDataTable("SELECT LabelRequestId from m_code " + AddQry + " GROUP BY  LabelRequestId");
                    //-----------------shweta code
                    ////  DataTable Mdt = dds.Tables[1];                  
                    //DataView dview1 = new DataView();
                    //DataSet dataset1 = ExecuteNonQueryAndDatatable.GetM_Label_RequestbyPro_id(ddlProduct.SelectedValue.Trim());
                    //dview1.Table = dataset1.Tables[0];
                    //DataTable Mdt = dview1.ToTable(true, "LabelRequestId");//SQL_DB.ExecuteDataTable("SELECT LabelRequestId from m_code " + AddQry + " GROUP BY  LabelRequestId");   

                    //DataView dview2;
                    ////-----------------end
                    if (Mdt.Rows.Count > 0)
                    {
                        #region
                        for (int p = 0; p < Mdt.Rows.Count; p++)
                        {
                            ////-----------------------Shweta
                            //dview2 = new DataView();
                            //dview2.Table = dataset1.Tables[0];
                            //dview2.RowFilter = " LabelRequestId = '" + Mdt.Rows[p]["LabelRequestId"].ToString() + "'";
                            //DataTable Modt = dview1.ToTable();//  DataTable Modt = SQL_DB.ExecuteDataTable("SELECT DISTINCT Series_Order FROM M_Code " + AddQry);

                            ////--------------------------End

                            AddQry = " WHERE Pro_ID='" + ddlProduct.SelectedValue + "' AND ISNULL(Batch_No,'') = '' AND ISNULL(Print_Date,'')  <> '' AND ISNULL(DispatchFlag,'') = 1  AND ISNULL(ReceiveFlag,'') = 1 ";
                            AddQry += " AND LabelRequestId = '" + Mdt.Rows[p]["LabelRequestId"].ToString() + "'";
                            DataTable Modt = SQL_DB.ExecuteDataTable("SELECT DISTINCT Series_Order FROM M_Code " + AddQry);

                            if (Modt.Rows.Count > 0)
                            {
                                #region
                                for (int q = 0; q < Modt.Rows.Count; q++)
                                {
                                    AddQry += "  AND Series_Order = '" + Modt.Rows[q]["Series_Order"].ToString() + "' ";
                                    string seriesFrom = "", seriesTo = ""; Int64 LabelQty = 0, SFrom = 0, STo = 0;
                                    txtSeries_Initial.Text = string.Format("{0:0000}", Convert.ToInt64(Modt.Rows[q]["Series_Order"]));

                                    DataTable Mindt = SQL_DB.ExecuteDataTable("SELECT MIN(Series_Serial) as Series_SerialFrom FROM M_Code " + AddQry);
                                    if (Mindt.Rows.Count > 0)
                                    {
                                        seriesFrom = string.Format("{0:0000}", Convert.ToInt64(Mindt.Rows[0]["Series_SerialFrom"]));
                                        SFrom = Convert.ToInt64(Mindt.Rows[0]["Series_SerialFrom"]);
                                    }
                                    DataTable Maxdt = SQL_DB.ExecuteDataTable("SELECT MAX(Series_Serial) as Series_SerialTo FROM M_Code " + AddQry);
                                    if (Mindt.Rows.Count > 0)
                                    {
                                        seriesTo = string.Format("{0:0000}", Convert.ToInt64(Maxdt.Rows[0]["Series_SerialTo"]));
                                        STo = Convert.ToInt64(Maxdt.Rows[0]["Series_SerialTo"]);
                                    }

                                    ////----------------shweta

                                    //seriesFrom = string.Format("{0:0000}", Convert.ToInt64(Modt.Rows[q]["Series_SerialFrom"]));
                                    //SFrom = Convert.ToInt64(Modt.Rows[q]["Series_SerialFrom"]);

                                    //seriesTo = string.Format("{0:0000}", Convert.ToInt64(Modt.Rows[q]["Series_SerialTo"]));
                                    //STo = Convert.ToInt64(Modt.Rows[q]["Series_SerialTo"]);
                                    ////-------------------------------------end

                                    if (SFrom == 0)
                                        LabelQty = ++STo;
                                    else
                                        LabelQty = STo - SFrom + 1;
                                    #region
                                    DataTable myTable = (DataTable)Session["PrintLabel"];
                                    AddPrintLabelInfo("", ddlProduct.SelectedValue.ToString(), txtSeries_Initial.Text.Trim().Replace("'", "''"), seriesFrom, seriesTo, LabelQty.ToString(), (DataTable)Session["PrintLabel"]);
                                    clearinfo();
                                    FillGrdLabelInfo();
                                    AddQry = " WHERE Pro_ID='" + ddlProduct.SelectedValue + "' AND ISNULL(Batch_No,'') = '' AND ISNULL(Print_Date,'')  <> '' AND ISNULL(DispatchFlag,'') = 1  AND ISNULL(ReceiveFlag,'') = 1 ";
                                    #endregion
                                }
                                #endregion
                            }
                        }
                        #endregion
                    }
                    #endregion
                }
                else
                {
                    #region Clear Auto fill or mannual fill data
                    PrintLabelInfo = CreateFileDataTable();
                    Session["PrintLabel"] = PrintLabelInfo;
                    clearinfo();
                    FillGrdLabelInfo();
                    #endregion
                }
                #endregion
            }
            else
            {
                //return "0-" + res + "-0";
                LblAvlCodes.Text = "0";
                HdnAvlCodes.Value = "0";
                txtSeries_Initial1.Text = res;
                HdnSeriesIni.Value = res;
                lblbatchsize.Text = "0";
                HdnBatchSize.Value = "0";
            }

            string ValGroup = "PRO"; bool Visible = false;
            // Check for Counter Fitting Service is Exist then Mandaory fields
            DataTable dst = SQL_DB.ExecuteDataSet("SELECT Subscribe_Id FROM M_ServiceSubscription WHERE (Service_ID = 'SRV1018') AND (Pro_ID = '" + ddlProduct.SelectedValue.ToString() + "') AND (GETDATE() BETWEEN DateFrom AND DateTo) ").Tables[0];//AND (IsActive = 1) AND (IsDelete = 0) AND (IsAdminVerify = 1)
            //DataTable dst = SQL_DB.ExecuteDataSet("SELECT Comments,Points FROM M_Loyalty WHERE IsActive = 0 AND IsDelete = 0 AND Pro_ID='" + ddlProduct.SelectedValue.ToString() + "'").Tables[0];
            if (dst.Rows.Count == 0)
            {
                ValGroup = "NA";
                Visible = false;
            }
            else
            {
                ValGroup = "PRO";
                Visible = true;
            }
            RequiredFieldValidator3.ValidationGroup = ValGroup;
            RequiredFieldValidator4.ValidationGroup = ValGroup;
            RequiredFieldValidator1.ValidationGroup = ValGroup;
            // btn.Visible = Visible;
            //   mrp.Visible = Visible;
            mfd.Visible = Visible;
        }
        else
        {
            //return "0-" + res + "-0";
            LblAvlCodes.Text = "";
            HdnAvlCodes.Value = "0";
            txtSeries_Initial1.Text = "";
            HdnSeriesIni.Value = "";
            lblbatchsize.Text = "";
            HdnBatchSize.Value = "0";
        }
        //  ProductDetailsPopUp.Show();
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        Fieldset1.Visible = true;
        lblbatchsize.Text = string.Empty;
        ((DataTable)Session["PrintLabel"]).Rows.Clear();
        FillGrdLabelInfo();
        chkHindi.Enabled = false;
        chkEnglish.Enabled = false;
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Row_ID FROM Pro_Reg where Comp_ID = '" + Session["CompanyId"].ToString() + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            Object9420 obj = new Object9420();
            obj.Comp_ID = Session["CompanyId"].ToString();
            //DataSet ds = function9420.FetchProduct_Id(obj);

            DataSet ds1 = ExecuteNonQueryAndDatatable.GetProductDetailsNoofCodes(obj.Comp_ID);
            //DataSet ds1 = Business9420.function9420.SelectProductDetailsNoofCodes(obj);
            //DataSet ds2 = Business9420.function9420.SelectProductDetailsNoofCodesChk(obj);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                if (ChkDispatchLabels(ds1.Tables[0], ds1.Tables[1]))
                {
                    Clear();
                    //   BigpopMsg.Visible = false;
                    ChangeValidationGroup(true);
                    fillddlPro_Id(ds1);
                    //   ProductDetailsPopUp.Show();
                }
                else
                {
                    btnYesActivation.Text = "OK";
                    btnNoActivation.Text = "Close";
                    btnNoActivation.Visible = false;
                    lblPassPnlHead.Text = "Alert";
                    lblCompPassText.Text = "Please receive courier, First !";
                    //    ModalPopupExtenderAlert.Show();
                }
                //if (ChkDispatchLabels(ds1,ds2))
                //{
                //    Clear();
                //    BigpopMsg.Visible = false;
                //    ChangeValidationGroup(true);
                //    fillddlPro_Id();
                //    ProductDetailsPopUp.Show();
                //}
                //else
                //{
                //    btnYesActivation.Text = "OK";
                //    btnNoActivation.Text = "Close";
                //    btnNoActivation.Visible = false;
                //    lblPassPnlHead.Text = "Alert";
                //    lblCompPassText.Text = "Please receive courier, First !";
                //    ModalPopupExtenderAlert.Show();
                //}
            }
            else
            {
                //DataSet ds3 = Business9420.function9420.SelectProductDetailsNoofCodesPrint(obj);
                // note: - ds1.Table[2] is  DataSet ds3
                //if (ds3.Tables[0].Rows.Count == 0)
                if (ds1.Tables[2].Rows.Count == 0)
                {
                    if (ds1.Tables[1].Rows.Count == 0)
                    {
                        btnYesActivation.Text = " OK ";
                        lblCompPassText.Text = "Your requested print labels are not dispatch.";
                        lblCompPassText.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        btnYesActivation.Text = "OK";
                        lblCompPassText.Text = "Please receive courier, First !";
                    }
                    //if (ds2.Tables[0].Rows.Count == 0)
                    //{
                    //    btnYesActivation.Text = " OK ";
                    //    lblCompPassText.Text = "Your requested print labels are not dispatch.";
                    //    lblCompPassText.ForeColor = System.Drawing.Color.Red;
                    //}
                    //else
                    //{
                    //    btnYesActivation.Text = "OK";
                    //    lblCompPassText.Text = "Please receive courier, First !";
                    //}
                }
                else
                {
                    btnYesActivation.Text = "OK";
                    lblCompPassText.Text = "Please receive courier, First !";
                }
                btnNoActivation.Text = "Close";
                btnNoActivation.Visible = false;
                lblPassPnlHead.Text = "Alert";
                // ModalPopupExtenderAlert.Show();
            }
        }
        else
        {
            btnYesActivation.Text = "Ok";
            btnNoActivation.Text = "Close";
            btnNoActivation.Visible = false;
            lblPassPnlHead.Text = "Alert";
            lblCompPassText.Text = "Please registered product, First ?";
            //  ModalPopupExtenderAlert.Show();
        }
    }
    private void ChangeValidationGroup(bool str)
    {
        if (str == true)
        {
            //RequiredFieldValidator522.ValidationGroup = "PRO";
            //RequiredFieldValidator6English.ValidationGroup = "PRO";
            SFileE.Visible = false;
            SFileH.Visible = false;
            ddlProduct.Enabled = true;
            L1.Text = "*"; L2.Text = "*";
        }
        else
        {
            //RequiredFieldValidator522.ValidationGroup = "NO";
            //RequiredFieldValidator6English.ValidationGroup = "NO";
            ddlProduct.Enabled = false;
            SFileE.Visible = true;
            SFileH.Visible = true;
            L1.Text = ""; L2.Text = "";
        }
    }
    #region Multi Select Print Codes
    private DataTable CreateFileDataTable()
    {
        DataTable myDataTable = new DataTable();
        DataColumn myDataColumn;
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "RowId";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Pro_ID";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Series_Initial";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Series_From";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Series_To";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Qty";
        myDataTable.Columns.Add(myDataColumn);
        return myDataTable;
    }
    protected void GrdProductPrintLablelDet_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = Convert.ToInt32(e.CommandArgument.ToString());
        lblUpFlTblId.Text = index.ToString();
        if (e.CommandName.ToString() == "DeleteProDetails")
        {
            ((DataTable)Session["PrintLabel"]).Rows[index].Delete();
            clearinfo();
            FillGrdLabelInfo();
            btnAddPro.ImageUrl = "~/Content/images/add_new.png";
        }
        else if (e.CommandName.ToString() == "EditProDetails")
        {
            //fillProduct("E");
            if (((DataTable)Session["PrintLabel"]).Rows.Count > 0)
            {
                txtSeries_Initial.Text = ((DataTable)Session["PrintLabel"]).Rows[index]["Series_Initial"].ToString();
                txtSeriesFrom.Text = ((DataTable)Session["PrintLabel"]).Rows[index]["Series_From"].ToString();
                txtSeriesTo.Text = ((DataTable)Session["PrintLabel"]).Rows[index]["Series_To"].ToString();
                LblCountQty.Text = ((DataTable)Session["PrintLabel"]).Rows[index]["Qty"].ToString();
                btnAddPro.ImageUrl = "~/images/add_Update.png";
            }
            FillGrdLabelInfo();
        }
        //   ProductDetailsPopUp.Show();
    }
    private bool ChkSeries()
    {
        int cc = 0; int kcount = 0;
        DataTable dt = (DataTable)Session["PrintLabel"];
        if (dt.Rows.Count > 0)
        {
            string SeriesI = txtSeries_Initial.Text;
            int SerialFrom = Convert.ToInt32(txtSeriesFrom.Text);
            int SerialTo = Convert.ToInt32(txtSeriesTo.Text);
            int k1 = 0;
            if (SerialFrom == 0)
                k1 = SerialTo + 1;
            else
                k1 = SerialTo - SerialFrom + 1;
            for (int l = 0; l < dt.Rows.Count; l++)
            {
                if (l.ToString() != lblUpFlTblId.Text)
                {
                    string SeriesI1 = dt.Rows[l]["Series_Initial"].ToString();
                    int SerialFrom1 = Convert.ToInt32(dt.Rows[l]["Series_From"].ToString());
                    int SerialTo1 = Convert.ToInt32(dt.Rows[l]["Series_To"].ToString());
                    if (SeriesI == SeriesI1)
                    {
                        int k = 0;
                        if (SerialFrom1 == 0)
                            k = SerialTo1 + 1;
                        else
                            k = SerialTo1 - SerialFrom1 + 1;
                        for (int t = 0; t < k1; t++)
                        {
                            for (int p = 0; p < k; p++)
                            {
                                if (SerialFrom1 + p == SerialFrom + t)
                                {
                                    cc = 5;
                                    break;
                                }
                            }
                            if (cc == 5)
                                break;
                        }
                        if (cc == 5)
                            break;

                    }
                }
                else
                {
                    string SeriesI1 = dt.Rows[l]["Series_Initial"].ToString();
                    int SerialFrom1 = Convert.ToInt32(dt.Rows[l]["Series_From"].ToString());
                    int SerialTo1 = Convert.ToInt32(dt.Rows[l]["Series_To"].ToString());
                    if (SeriesI == SeriesI1)
                    {
                        if (SerialFrom1 == 0)
                            kcount = SerialTo1 + 1;
                        else
                            kcount = SerialTo1 - SerialFrom1 + 1;
                        if (SerialFrom < SerialTo1)
                        {
                            if (SerialFrom > SerialFrom1)
                                kcount -= SerialFrom - SerialFrom1;
                            if (SerialTo < SerialTo1)
                                kcount = k1;
                        }
                        else
                            kcount = 0;
                    }
                }
                if (cc == 5)
                    break;
            }//
        }
        if (cc == 5)
            return false;
        if (hdnFieldUpdate.Value != "Update")
        {
            Object9420 Reg = new Object9420();
            Reg.Pro_ID = ddlProduct.SelectedValue.ToString();
            string str = ""; int pcount = 0;
            if (txtSeriesFrom.Text != "" && txtSeriesTo.Text != "" && txtSeries_Initial.Text != "")
            {
                //string[] Serialcode = txtSeries_Initial.Text.Split('-');
                string pro = txtSeries_Initial1.Text;
                Int32 Series_Order = Convert.ToInt32(txtSeries_Initial.Text);
                Int32 Series_Serial = Convert.ToInt32(txtSeriesFrom.Text);
                Int32 Series_Serial1 = Convert.ToInt32(txtSeriesTo.Text);
                if (Convert.ToInt32(Series_Serial1) >= Convert.ToInt32(Series_Serial))
                {
                    lblProDetailsMsg.Text = "";
                    str = " AND Series_Order=" + Series_Order + " AND Series_Serial >= " + Series_Serial;
                    str += " AND Series_Serial<=" + Series_Serial1 + " ";
                    if (Convert.ToInt32(Series_Serial) == 0)
                        pcount = Convert.ToInt32(Series_Serial1) + 1;
                    else
                        pcount = Convert.ToInt32(Series_Serial1) - Convert.ToInt32(Series_Serial) + 1;
                    if (kcount == 0)
                    {
                        if (function9420.PrintChkSeries(Reg, str, pcount))
                            return true;
                        else
                            return false;
                    }
                    else
                    {
                        if (function9420.PrintChkSeries(Reg, str, pcount, kcount))
                            return true;
                        else
                            return false;
                    }
                }
                else
                    return false;
            }
            else
                return false;
        }
        else
            return true;
    }
    private void FillGrdLabelInfo()
    {
        DataTable dt = (DataTable)Session["PrintLabel"];
        GrdProductPrintLablelDet.DataSource = dt;
        GrdProductPrintLablelDet.DataBind();
        if (GrdProductPrintLablelDet.Rows.Count > 0)
            GrdProductPrintLablelDet.HeaderRow.TableSection = TableRowSection.TableHeader;
    }
    private void AddPrintLabelInfo(string RowId, string Pro_ID, string Series_Initial, string Series_From, string Series_To, string Qty, DataTable myTable)
    {
        DataRow row;
        row = myTable.NewRow();
        row["RowId"] = RowId;
        row["Pro_ID"] = Pro_ID;
        row["Series_Initial"] = Series_Initial;
        row["Series_From"] = Series_From;
        row["Series_To"] = Series_To;
        row["Qty"] = Qty;
        myTable.Rows.Add(row);
    }
    protected void btnAddPro_Click(object sender, ImageClickEventArgs e)
    {
        // DivNewMsg.Visible = false;
        // DivNewMsg.Attributes.Add("class", "");
        lblpopmsg.Text = string.Empty;
        if (Convert.ToInt32(txtSeriesTo.Text) >= Convert.ToInt32(txtSeriesFrom.Text))
        {
            if (btnAddPro.ImageUrl == "~/Content/images/add_new.png")
            {
                if (ChkSeries())
                {
                    AddPrintLabelInfo("", ddlProduct.SelectedValue.ToString(), txtSeries_Initial.Text.Trim().Replace("'", "''"), txtSeriesFrom.Text.Trim().Replace("'", "''").ToString(), txtSeriesTo.Text.Trim().Replace("'", "''").ToString(), LblCountQty.Text.ToString(), (DataTable)Session["PrintLabel"]);
                    clearinfo();
                    FillGrdLabelInfo();
                }
                else
                {
                    lblProDetailsMsg.Text = "Please select valid series or valid product!";
                    lblProDetailsMsg.ForeColor = System.Drawing.Color.Red;
                    // ProductDetailsPopUp.Show();
                    return;
                }
            }
            else if (btnAddPro.ImageUrl == "~/Content/images/add_Update.png")
            {
                hdnFieldUpdate.Value = "Update";
                if (ChkSeries())
                {
                    int index = Convert.ToInt32(lblUpFlTblId.Text);
                    ((DataTable)Session["PrintLabel"]).Rows[index]["Series_Initial"] = txtSeries_Initial.Text;
                    ((DataTable)Session["PrintLabel"]).Rows[index]["Series_From"] = txtSeriesFrom.Text;
                    ((DataTable)Session["PrintLabel"]).Rows[index]["Series_To"] = txtSeriesTo.Text;
                    ((DataTable)Session["PrintLabel"]).Rows[index]["Qty"] = LblCountQty.Text;
                    btnAddPro.ImageUrl = "~/Content/images/add_new.png";
                    clearinfo();
                    FillGrdLabelInfo();
                }
                else
                {
                    lblProDetailsMsg.Text = "Please select valid series or valid product!";
                    lblProDetailsMsg.ForeColor = System.Drawing.Color.Red;
                    //  ProductDetailsPopUp.Show();
                    return;
                }
            }
        }
        else
        {
            lblProDetailsMsg.Text = "Please select valid series or valid product!";
            lblProDetailsMsg.ForeColor = System.Drawing.Color.Red;
            //  ProductDetailsPopUp.Show();
            return;
        }
        //  ProductDetailsPopUp.Show();
    }
    protected void btnResetPro_Click(object sender, ImageClickEventArgs e)
    {
        clearinfo();
        //ProductDetailsPopUp.Show(); ;
    }
    private void clearinfo()
    {
        //ddlProduct.SelectedIndex = 0;
        //ddlLabel.SelectedIndex = 0;
        txtSeriesFrom.Text = string.Empty;
        txtSeriesTo.Text = string.Empty;
        lblProDetailsMsg.Text = string.Empty;
        txtSeries_Initial.Text = string.Empty;
        lblUpFlTblId.Text = string.Empty;
        LblCountQty.Text = string.Empty;
    }
    #endregion
    protected void btnSave_Click(object sender, EventArgs e)
    {

        LogManager.WriteExe("Enter Save button!");
        if (btnSave.Text == "Save")
        {
            #region Save Code
            LogManager.WriteExe("Enter Save functionality!");
            DataTable dt = (DataTable)Session["PrintLabel"];
            for (int p = 0; p < dt.Rows.Count; p++)
            {
                dt.Rows[p]["RowId"] = ++p;
            }
            LogManager.WriteExe("Update Rows in datatable for session!");
            string script = "";
            if ((LblCountQty.Text != "") || (txtSeriesFrom.Text != "") || (txtSeriesTo.Text != "") || (dt.Rows.Count == 0))
            {
                LogManager.WriteExe("Error which is fill data is available!");
                //  DivNewMsg.Visible = true;
                //  DivNewMsg.Attributes.Add("class", "alert_boxes_pink");
                LblMsg.Text = "Please add Pasted Label information !  <span style='color:green;'>Click For add Details : </span><img style='position: fixed;' alt='' src='../Content/images/add_new.png' />";
                // ProductDetailsPopUp.Show();
                //script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
            LogManager.WriteExe("Condition is right!");
            if (LblAvlCodes.Text == "")
                LblAvlCodes.Text = HdnAvlCodes.Value;
            if (txtSeries_Initial1.Text == "")
                txtSeries_Initial1.Text = HdnSeriesIni.Value;
            if (lblbatchsize.Text == "")
                lblbatchsize.Text = HdnBatchSize.Value;

            #region Logic Hare

            LogManager.WriteExe("Logic Heare enter!");
            //     DivNewMsg.Visible = false;
            string path_H = ""; string path_E = "";
            Object9420 obj = new Object9420();
            obj.Pro_ID = ddlProduct.SelectedValue;
            obj.Comp_ID = Session["CompanyId"].ToString();
            obj.Batch_No = txtBatchNo.Text.Trim().Replace("'", "''");
            if (txtMRP.Text.Trim() != "")
                obj.MRP = Convert.ToDouble(txtMRP.Text.Trim());
            if (txtMfd_Date.Text != "")
                obj.DemoMfd_Date = txtMfd_Date.Text;
            else
                obj.DemoMfd_Date = null;
            //obj.DemoMfd_Date = txtMfd_Date.Text;
            obj.Comments = txtComment.Text.Trim().Replace("'", "''");

            if (!string.IsNullOrEmpty(txtWarr.Text))
            {
                obj.Warranty = Convert.ToInt32(txtWarr.Text);
            }
            else
            {
                obj.Warranty = 0;
            }

            if (txtExp_Date.Text != "")
                obj.Exp_Date = txtExp_Date.Text;
            else
                obj.Exp_Date = null;
            obj.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            obj.Update_Flag = 0;
            LogManager.WriteExe("Before enter the condions!");
            //obj.NoofCodes = Convert.ToInt32(txtNoOfCodes.Text.Trim());


            /*
            #region Track and Trace added by Bipin for master code Implementation
            string Assignservice = "";
            DataTable Getservice = SQL_DB.ExecuteDataTable("select Service_ID from M_ServiceSubscription where IsActive=1 and Pro_ID='" + obj.Pro_ID + "'");
            DataTable getcode = SQL_DB.ExecuteDataTable("select Row_ID from [M_Code] WHERE [Pro_ID] = '" + obj.Pro_ID + "' ");
            if (Getservice.Rows.Count > 0)
            {
                Assignservice = Getservice.Rows[0][0].ToString();
                if (Assignservice == "SRV1021")
                {
                    int M_codeid;
                    foreach (DataRow row in getcode.Rows)
                    {
                        M_codeid = Convert.ToInt32(row["Row_ID"]);
                        SQL_DB.ExecuteNonQuery("Insert into MasterCode (M_CodeID,Type) values('" + M_codeid + "','I')");
                    }
                }
            }
            #endregion

            */




            if (Business9420.function9420.GetRowForPrintCodes(obj) > 0)
            {
                Int64 intRow_Id = Convert.ToInt64(ExecuteNonQueryAndDatatable.SaveBatchProductDetails_new(obj).Tables[0].Rows[0][0]);

                #region
                LogManager.WriteExe("After enter the condions!");
                //function9420.SaveBatchProductDetails(obj);
                LogManager.WriteExe("After save batch data!");
                // obj.Row_ID = Business9420.function9420.GetRow_ID();
                // obj.Batch_No = Business9420.function9420.GetRow_ID();
                //*************** Commented by Avadhesh 27/07/2014***************// Delhi

                ///function9420.UpDateBatchProductDetailsInM_Code(obj);

                //
                StringBuilder strb = new StringBuilder();
                //int serial_order = Convert.ToInt32(txtSeries_Initial.Text);
                //int serial_series = Convert.ToInt32(txtSeriesFrom.Text);

                //obj.Series_Order = serial_order;
                //obj.Series_Serial = serial_series;
                //obj.NoofCodes = counter;
                LogManager.WriteExe("Before Check Condition for session rows count!");
                if (dt.Rows.Count > 0)
                {
                    LogManager.WriteExe("After Check Condition for session rows count!");
                    // shweta code
                    StringBuilder sbSeriesConcat = new StringBuilder();

                    if(Session["CompanyId"].ToString()== "Comp-1311")
                    sbSeriesConcat.Append(" UPDATE [M_Code_PFL] SET [Batch_No] = " + intRow_Id + " WHERE [Pro_ID] = '" + obj.Pro_ID + "' AND (");
                    else
                    sbSeriesConcat.Append(" UPDATE [M_Code] SET [Batch_No] = " + intRow_Id + " WHERE [Pro_ID] = '" + obj.Pro_ID + "' AND (");


                    for (int w = 0; w < dt.Rows.Count; w++)
                    {
                        LogManager.WriteExe("Enter in For loop " + w.ToString());
                        try
                        {
                            // SQL_DB.ExecuteNonQuery("UPDATE [M_Code] SET [Batch_No] = " + obj.Batch_No + " WHERE [Pro_ID] = '" + obj.Pro_ID + "' AND [Series_Order] = " + Convert.ToInt32(dt.Rows[w]["Series_Initial"]) + "  AND [Series_Serial] >= " + Convert.ToInt32(dt.Rows[w]["Series_From"]) + " AND [Series_Serial] <= " + Convert.ToInt32(dt.Rows[w]["Series_To"]) + "");
                            // shweta code
                            if (w > 0 && w < dt.Rows.Count)
                                sbSeriesConcat.Append("or");
                            sbSeriesConcat.Append("(");
                            sbSeriesConcat.Append(" [Series_Order] = " + Convert.ToInt32(dt.Rows[w]["Series_Initial"]) + "  AND [Series_Serial] >= " + Convert.ToInt32(dt.Rows[w]["Series_From"]) + " AND [Series_Serial] <= " + Convert.ToInt32(dt.Rows[w]["Series_To"]));
                            sbSeriesConcat.Append(")");


                            // note  : below line is commented and above string builder created to fullfill the task of below update 
                            // SQL_DB.ExecuteNonQuery("UPDATE [M_Code] SET [Batch_No] = " + intRow_Id + " WHERE [Pro_ID] = '" + obj.Pro_ID + "' AND [Series_Order] = " + Convert.ToInt32(dt.Rows[w]["Series_Initial"]) + "  AND [Series_Serial] >= " + Convert.ToInt32(dt.Rows[w]["Series_From"]) + " AND [Series_Serial] <= " + Convert.ToInt32(dt.Rows[w]["Series_To"]) + "");
                        }
                        catch (Exception ex)
                        {
                            LogManager.WriteExe("Error in Execute None Query Error is  " + ex.Message.ToString());
                        }

                        ////============new code 8/2/13===========
                        //string strser = SQL_DB.ExecuteScalar("select (SELECT top 1 'From  ' + pro_id +'-'+ (case when len(convert(nvarchar,[Series_Order])) = 1 then '0'+convert(nvarchar,[Series_Order]) else convert(nvarchar,[Series_Order]) end)+'-'+ case when len(convert(nvarchar,[Series_Serial])) = 1 then '000'+convert(nvarchar,[Series_Serial]) when len(convert(nvarchar,[Series_Serial])) = 2 then '00'+convert(nvarchar,[Series_Serial]) when len(convert(nvarchar,[Series_Serial])) = 3 then '0'+convert(nvarchar,[Series_Serial]) else convert(nvarchar,[Series_Serial]) end " +
                        //" FROM [M_Code] where print_status = 1 and pro_id = '" + obj.Pro_ID + "' and Batch_no is not null and batch_no = '" + obj.Row_ID + "'" +
                        //" order by [Series_Order],[Series_Serial]) +'   '+" +
                        //" (SELECT top 1 'To  ' + pro_id +'-'+ (case when len(convert(nvarchar,[Series_Order])) = 1 then '0'+convert(nvarchar,[Series_Order]) else convert(nvarchar,[Series_Order]) end)+'-'+ case when len(convert(nvarchar,[Series_Serial])) = 1 then '000'+convert(nvarchar,[Series_Serial]) when len(convert(nvarchar,[Series_Serial])) = 2 then '00'+convert(nvarchar,[Series_Serial]) when len(convert(nvarchar,[Series_Serial])) = 3 then '0'+convert(nvarchar,[Series_Serial]) else convert(nvarchar,[Series_Serial]) end " +
                        //" FROM [M_Code] where print_status = 1 and pro_id = '" + obj.Pro_ID + "' and Batch_no is not null and batch_no = '" + obj.Row_ID + "'" +
                        //" order by [Series_Order],[Series_Serial] desc) as serOrder").ToString();
                        //SQL_DB.ExecuteNonQuery("UPDATE [T_Pro]" +
                        //" SET [Series_Limit] = '" + strser + "'" +
                        //" WHERE Row_ID = " + obj.Row_ID + " ");
                        ////======================================
                    }
                    // shweta code
                    sbSeriesConcat.Append(")");
                    string strQuery = sbSeriesConcat.ToString();
                    SQL_DB.ExecuteNonQuery(strQuery);

                    LogManager.WriteExe("After For loop is final!");
                }
                // Here below T_Pro is updating in funtion UpdateM_codeByBatch_No(intRow_Id, obj.Pro_ID)
                ExecuteNonQueryAndDatatable.UpdateM_codeByBatch_No(intRow_Id, obj.Pro_ID);
                #endregion
            }
            else
            {
                //    DivNewMsg.Visible = true;
                //   DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                LblMsg.Text = "Print code not avialable for this products !";
                //   ProductDetailsPopUp.Show();
                return;
            }

            #region Save Sound File
            if (chkHindi.Checked != true && chkEnglish.Checked != true)
            {
                string path = Server.MapPath("../Data/Sound");
                path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID + "\\" + obj.Row_ID;
                DataProvider.Utility.CreateDirectory(path);
                path_H = path + "\\" + obj.Row_ID + "_H.wav";
                flSound.SaveAs(path_H);
                path_E = path + "\\" + obj.Row_ID + "_E.wav";
                flSoundE.SaveAs(path_E);
            }
            else if (chkHindi.Checked == true && chkEnglish.Checked != true)
            {
                string path = Server.MapPath("../Data/Sound");
                path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID + "\\" + obj.Row_ID;
                DataProvider.Utility.CreateDirectory(path);
                path_H = path + "\\" + obj.Row_ID + "_H.wav";
                string patho = Server.MapPath("../Data/Sound");
                patho = patho + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID + "\\" + lblSame.Text.Trim();
                DataProvider.Utility.CreateDirectory(patho);
                string path_Ho = patho + "\\" + lblSame.Text.Trim() + "_H.wav";
                File.Copy(path_Ho, path_H);
                path_E = path + "\\" + obj.Row_ID + "_E.wav";
                flSoundE.SaveAs(path_E);
            }
            else if (chkHindi.Checked != true && chkEnglish.Checked == true)
            {
                string path = Server.MapPath("../Data/Sound");
                path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID + "\\" + obj.Row_ID;
                DataProvider.Utility.CreateDirectory(path);
                path_H = path + "\\" + obj.Row_ID + "_H.wav";
                flSound.SaveAs(path_H);
                path_E = path + "\\" + obj.Row_ID + "_E.wav";
                string path1 = Server.MapPath("../Data/Sound");
                path1 = path1 + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID + "\\" + lblSame.Text.Trim();
                DataProvider.Utility.CreateDirectory(path1);
                string path_Eo = path1 + "\\" + lblSame.Text.Trim() + "_E.wav";
                File.Copy(path_Eo, path_E);
            }
            else if (chkHindi.Checked == true && chkEnglish.Checked == true)
            {
                string path = Server.MapPath("../Data/Sound");
                path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID + "\\" + obj.Row_ID;
                DataProvider.Utility.CreateDirectory(path);
                path_H = path + "\\" + obj.Row_ID + "_H.wav";
                path_E = path + "\\" + obj.Row_ID + "_E.wav";
                string patho = Server.MapPath("../Data/Sound");
                patho = patho + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID + "\\" + lblSame.Text.Trim();
                DataProvider.Utility.CreateDirectory(patho);
                string path_Ho = patho + "\\" + lblSame.Text.Trim() + "_H.wav";
                File.Copy(path_Ho, path_H);
                string path1 = Server.MapPath("../Data/Sound");
                path1 = path1 + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID + "\\" + lblSame.Text.Trim();
                DataProvider.Utility.CreateDirectory(path1);
                string path_Eo = path1 + "\\" + lblSame.Text.Trim() + "_E.wav";
                File.Copy(path_Eo, path_E);
            }
            #endregion

            //************* Conirmation Message ******************//

            //for product information
            DataSet ds1 = function9420.UpdateData(obj);
            if (ds1.Tables[0].Rows.Count > 0)
                obj.Pro_Name = ds1.Tables[0].Rows[0]["Pro_Name"].ToString();
            else
                obj.Pro_Name = "------ ";
            btnYesActivation.Text = "Add Product Details";
            btnNoActivation.Text = "Close";
            btnNoActivation.Visible = false;
            lblCompPassText.ForeColor = System.Drawing.Color.Black;
            lblPassPnlHead.Text = "Alert";
            lblCompPassText.Text = "<span style='color:blue;' >" + txtNoOfCodes.Text.ToString() + "</span> Label , Batch No. <span style='color:blue;' >" + txtBatchNo.Text.Trim().Replace("'", "''") + "</span> Product  <span style='color:blue;' >" + obj.Pro_Name + "</span> uploaded successfully. These Labels can be pasted on products."; // Go to  <a class='myanc' href='frmPrintLabelPasting.aspx?Pro_ID=" + obj.Pro_ID + "&Batch=" + obj.Row_ID + "'  > Link </a> tab for viewing printed Labels.";

            //************* Conirmation Message ******************//
            dt.Rows.Clear();
            Session["PrintLabel"] = dt;
            FillGrdLabelInfo();
            //Clear();
            //filldata();
            //fillddlPro_Id();
            Response.Redirect("ProductDetails.aspx");


            //DivNewMsg.Visible = true;
            //DivNewMsg.Attributes.Add("class", "alert_boxes_green big_msg");   
            //LblMsg.Text = "Product successfully saved !";
            //     ProductDetailsPopUp.Show();
            //      ModalPopupExtenderAlert.Show();
            #endregion
            // arb, disable double click 
            //  btnSave.Enabled = false;

            #endregion




        }
        else if (btnSave.Text == "Update")
        {
            Object9420 obj = new Object9420();
            obj.Row_ID = hdneditrowid.Value;
            obj.Pro_ID = ddlProduct.SelectedValue;
            obj.Comp_ID = Session["CompanyId"].ToString();
            obj.Batch_No = txtBatchNo.Text.Trim().Replace("'", "''");
            if (txtMRP.Text.Trim() != "")
                obj.MRP = Convert.ToDouble(txtMRP.Text.Trim());
            if (txtMfd_Date.Text != "")
                obj.DemoMfd_Date = txtMfd_Date.Text;
            else
                obj.DemoMfd_Date = null;
            //obj.DemoMfd_Date = txtMfd_Date.Text;
            obj.Comments = txtComment.Text.Trim().Replace("'", "''");
            if (!string.IsNullOrEmpty(txtWarr.Text))
            {
                obj.Warranty = Convert.ToInt32(txtWarr.Text);
            }
            else
            {
                obj.Warranty = 0;
            }
            if (txtExp_Date.Text != "")
                obj.Exp_Date = txtExp_Date.Text;
            else
                obj.Exp_Date = null;
            obj.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            obj.Update_Flag = 0;
            try
            {
                //SQL_DB.ExecuteNonQuery("UPDATE [T_Pro] SET [MRP] = '" + obj.MRP + "', [Mfd_Date] = '" + (obj.DemoMfd_Date == null ? null : Convert.ToDateTime(obj.DemoMfd_Date).ToString("yyyy/MM/dd hh:mm:ss tt")) + "' " +
                //" ,[Exp_Date] =  '" + (obj.Exp_Date == null ? null : Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt")) + "' ,[Batch_No] =  '" + obj.Batch_No + "' " +
                //" ,[Entry_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "'  WHERE [Pro_ID] = '" + obj.Pro_ID + "' AND [Row_ID] = " + Convert.ToInt64(obj.Row_ID) + " ");
                function9420.UpdBatchProductDetails(obj);
                //BigpopMsg.Visible = true;
                //BigpopMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                //Label2.Text = "Product details successfully updated !";
            }
            catch (Exception ex)
            {
                throw ex;
            }
            filldata();
            Response.Redirect("ProductDetails.aspx");
            #region Commented code
            /*
            #region Check Label Valid Series
            int counter = 0, serial_series = 0, serial_order = 0, serialSeriesFrom=0;            
            int od = Convert.ToInt32(hdnSerialOrder.Value); int seriesfr = Convert.ToInt32(hdnSeriesFrom.Value); int seriesto = Convert.ToInt32(hdnSeriesTo.Value);
            int odn = Convert.ToInt32(txtSeries_Initial.Text); int seriesfrn = Convert.ToInt32(txtSeriesFrom.Text); int serieston = Convert.ToInt32(txtSeriesTo.Text);
            if (odn == od)
            {
                counter = Convert.ToInt32(txtSeriesTo.Text) - Convert.ToInt32(txtSeriesFrom.Text);
                if (counter == 0)
                    counter = 1;
                else
                    counter += 1;
                txtNoOfCodes.Text = counter.ToString();
                int cnt = 0;
                serial_order = odn;
                int chkseries = 0;
                if (((seriesfrn < seriesfr) && (serieston < seriesfr)) || (seriesfrn > seriesto))//New Code Checking
                {
                    #region First
                    serial_series = Convert.ToInt32(txtSeriesFrom.Text); serialSeriesFrom = Convert.ToInt32(txtSeriesFrom.Text);
                    DataSet ds = new DataSet();
                    SQL_DB.GetDA("SELECT  Pro_ID, Series_Order, Series_Serial FROM  dbo.M_Code where Pro_ID = '" + ddlProduct.SelectedValue + "' and (ScrapeFlag is null or ScrapeFlag = 0) AND ReceiveFlag = 1 AND Batch_No IS NULL ").Fill(ds, "1");
                    counter = Convert.ToInt32(txtSeriesTo.Text) - Convert.ToInt32(txtSeriesFrom.Text);
                    if (counter == 0)
                        counter = 1;
                    else
                        counter += 1;
                    for (int i = 0; i < counter; i++)
                    {
                        if (i != 0)
                            serial_series++;
                        DataSet dsn = new DataSet();
                        SQL_DB.GetDA("SELECT  Pro_ID, Series_Order, Series_Serial FROM  dbo.M_Code where Pro_ID = '" + ddlProduct.SelectedValue + "' and (ScrapeFlag is null or ScrapeFlag = 0) AND ReceiveFlag = 1 and Series_Order = " + serial_order + " and Series_Serial= " + serial_series + " AND Batch_No IS NULL ").Fill(dsn, "2");
                        if (dsn.Tables["2"].Rows.Count == 0)
                            cnt++;
                    }
                    if (cnt > 0)
                    {
                        DivNewMsg.Visible = true;
                        DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                        LblMsg.Text = "Please enter valid Series Details !";
                        ProductDetailsPopUp.Show();
                        return;
                    }
                    #endregion
                }
                else if ((seriesfrn < seriesfr) && (serieston > seriesfr) && (serieston > seriesfr))//SeriesForm is less and To is Greater
                {
                    chkseries = seriesfr - seriesfrn;
                    #region Second Condion
                    serial_series = Convert.ToInt32(txtSeriesFrom.Text);
                    serialSeriesFrom = Convert.ToInt32(txtSeriesFrom.Text);
                    DataSet ds = new DataSet();
                    SQL_DB.GetDA("SELECT  Pro_ID, Series_Order, Series_Serial FROM  dbo.M_Code where Pro_ID = '" + ddlProduct.SelectedValue + "' and (ScrapeFlag is null or ScrapeFlag = 0) AND ReceiveFlag = 1 AND Batch_No IS NULL ").Fill(ds, "1");
                    counter = chkseries;
                    if (counter < ds.Tables["1"].Rows.Count)
                    {
                        for (int i = 0; i < counter; i++)
                        {
                            if (i != 0)
                                serial_series++;
                            DataSet dsn = new DataSet();
                            SQL_DB.GetDA("SELECT  Pro_ID, Series_Order, Series_Serial FROM  dbo.M_Code where Pro_ID = '" + ddlProduct.SelectedValue + "' and (ScrapeFlag is null or ScrapeFlag = 0) AND ReceiveFlag = 1 and Series_Order = " + serial_order + " and Series_Serial= " + serial_series + " AND Batch_No IS NULL ").Fill(dsn, "2");
                            if (dsn.Tables["2"].Rows.Count == 0)
                                cnt++;
                        }
                        if (cnt > 0)
                        {
                            DivNewMsg.Visible = true;
                            DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                            LblMsg.Text = "Please enter valid Series Details !";
                            ProductDetailsPopUp.Show();
                            return;
                        }
                    }
                    else
                    {
                        DivNewMsg.Visible = true;
                        DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                        LblMsg.Text = "Please enter valid Series Details !";
                        ProductDetailsPopUp.Show();
                        return;
                    }
                    #endregion
                }
                else if ((seriesfrn < seriesfr) && (serieston == seriesfr) && (serieston == seriesfr))
                {
                    chkseries = seriesfr - seriesfrn - 1;
                    serialSeriesFrom = Convert.ToInt32(chkseries);
                    #region Third Condion
                    serial_series = Convert.ToInt32(txtSeriesFrom.Text);
                    DataSet ds = new DataSet();
                    SQL_DB.GetDA("SELECT  Pro_ID, Series_Order, Series_Serial FROM  dbo.M_Code where Pro_ID = '" + ddlProduct.SelectedValue + "' and (ScrapeFlag is null or ScrapeFlag = 0) AND ReceiveFlag = 1 AND Batch_No IS NULL ").Fill(ds, "1");
                    counter = chkseries;
                    if (counter < ds.Tables["1"].Rows.Count)
                    {
                        for (int i = 0; i < counter; i++)
                        {
                            if (i != 0)
                                serial_series++;
                            DataSet dsn = new DataSet();
                            SQL_DB.GetDA("SELECT  Pro_ID, Series_Order, Series_Serial FROM  dbo.M_Code where Pro_ID = '" + ddlProduct.SelectedValue + "' and (ScrapeFlag is null or ScrapeFlag = 0) AND ReceiveFlag = 1 and Series_Order = " + serial_order + " and Series_Serial= " + serial_series + " AND Batch_No IS NULL ").Fill(dsn, "2");
                            if (dsn.Tables["2"].Rows.Count == 0)
                                cnt++;
                        }
                        if (cnt > 0)
                        {
                            DivNewMsg.Visible = true;
                            DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                            LblMsg.Text = "Please enter valid Series Details !";
                            ProductDetailsPopUp.Show();
                            return;
                        }
                    }
                    else
                    {
                        DivNewMsg.Visible = true;
                        DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                        LblMsg.Text = "Please enter valid Series Details !";
                        ProductDetailsPopUp.Show();
                        return;
                    }
                    #endregion
                }
                else if ((seriesfrn < seriesfr) && (serieston > seriesfr) && (serieston == seriesfr))
                {
                    chkseries = seriesfr - seriesfrn - 1;
                    serialSeriesFrom = Convert.ToInt32(chkseries);
                    #region Third Condion
                    serial_series = Convert.ToInt32(txtSeriesFrom.Text);
                    DataSet ds = new DataSet();
                    SQL_DB.GetDA("SELECT  Pro_ID, Series_Order, Series_Serial FROM  dbo.M_Code where Pro_ID = '" + ddlProduct.SelectedValue + "' and (ScrapeFlag is null or ScrapeFlag = 0) AND ReceiveFlag = 1 AND Batch_No IS NULL ").Fill(ds, "1");
                    counter = chkseries;
                    if (counter > ds.Tables["1"].Rows.Count)
                    {
                        for (int i = 0; i < counter; i++)
                        {
                            if (i != 0)
                                serial_series++;
                            DataSet dsn = new DataSet();
                            SQL_DB.GetDA("SELECT  Pro_ID, Series_Order, Series_Serial FROM  dbo.M_Code where Pro_ID = '" + ddlProduct.SelectedValue + "' and (ScrapeFlag is null or ScrapeFlag = 0) AND ReceiveFlag = 1 and Series_Order = " + serial_order + " and Series_Serial= " + serial_series + " AND Batch_No IS NULL ").Fill(dsn, "2");
                            if (dsn.Tables["2"].Rows.Count == 0)
                                cnt++;
                        }
                        if (cnt > 0)
                        {
                            DivNewMsg.Visible = true;
                            DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                            LblMsg.Text = "Please enter valid Series Details !";
                            ProductDetailsPopUp.Show();
                            return;
                        }
                    }
                    else
                    {
                        DivNewMsg.Visible = true;
                        DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                        LblMsg.Text = "Please enter valid Series Details !";
                        ProductDetailsPopUp.Show();
                        return;
                    }
                    #endregion
                }
                else if ((seriesfrn > seriesfr) && (seriesfrn < seriesto) && (serieston > seriesto))
                {
                    chkseries = serieston - seriesto;
                    #region Fourth Condion
                    serial_series = Convert.ToInt32(seriesto) + 1;
                    serialSeriesFrom = Convert.ToInt32(serial_series);
                    DataSet ds = new DataSet();
                    SQL_DB.GetDA("SELECT  Pro_ID, Series_Order, Series_Serial FROM  dbo.M_Code where Pro_ID = '" + ddlProduct.SelectedValue + "' and (ScrapeFlag is null or ScrapeFlag = 0) AND ReceiveFlag = 1 AND Batch_No IS NULL ").Fill(ds, "1");
                    counter = chkseries;
                    if (counter > ds.Tables["1"].Rows.Count)
                    {
                        for (int i = 0; i < counter; i++)
                        {
                            if (i != 0)
                                serial_series++;
                            DataSet dsn = new DataSet();
                            SQL_DB.GetDA("SELECT  Pro_ID, Series_Order, Series_Serial FROM  dbo.M_Code where Pro_ID = '" + ddlProduct.SelectedValue + "' and (ScrapeFlag is null or ScrapeFlag = 0) AND ReceiveFlag = 1 and Series_Order = " + serial_order + " and Series_Serial= " + serial_series + " AND Batch_No IS NULL ").Fill(dsn, "2");
                            if (dsn.Tables["2"].Rows.Count == 0)
                                cnt++;
                        }
                        if (cnt > 0)
                        {
                            DivNewMsg.Visible = true;
                            DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                            LblMsg.Text = "Please enter valid Series Details !";
                            ProductDetailsPopUp.Show();
                            return;
                        }
                    }
                    else
                    {
                        DivNewMsg.Visible = true;
                        DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                        LblMsg.Text = "Please enter valid Series Details !";
                        ProductDetailsPopUp.Show();
                        return;
                    }
                    #endregion
                }
                else if ((seriesfrn == seriesfr) && (serieston > seriesto))
                {                    
                    chkseries = serieston - seriesto;
                    #region Fifth Condion
                    serial_series = Convert.ToInt32(seriesto) + 1;
                    serialSeriesFrom = Convert.ToInt32(serial_series);
                    DataSet ds = new DataSet();
                    SQL_DB.GetDA("SELECT  Pro_ID, Series_Order, Series_Serial FROM  dbo.M_Code where Pro_ID = '" + ddlProduct.SelectedValue + "' and (ScrapeFlag is null or ScrapeFlag = 0) AND ReceiveFlag = 1 AND Batch_No IS NULL ").Fill(ds, "1");
                    counter = chkseries;
                    if (counter <= ds.Tables["1"].Rows.Count)
                    {
                        for (int i = 0; i < counter; i++)
                        {
                            if (i != 0)
                                serial_series++;
                            DataSet dsn = new DataSet();
                            SQL_DB.GetDA("SELECT  Pro_ID, Series_Order, Series_Serial FROM  dbo.M_Code where Pro_ID = '" + ddlProduct.SelectedValue + "' and (ScrapeFlag is null or ScrapeFlag = 0) AND ReceiveFlag = 1 and Series_Order = " + serial_order + " and Series_Serial= " + serial_series + " AND Batch_No IS NULL ").Fill(dsn, "2");
                            if (dsn.Tables["2"].Rows.Count == 0)
                                cnt++;
                        }
                        if (cnt > 0)
                        {
                            DivNewMsg.Visible = true;
                            DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                            LblMsg.Text = "Please enter valid Series Details !";
                            ProductDetailsPopUp.Show();
                            return;
                        }
                    }
                    else
                    {
                        DivNewMsg.Visible = true;
                        DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                        LblMsg.Text = "Please enter valid Series Details !";
                        ProductDetailsPopUp.Show();
                        return;
                    }
                    #endregion
                }
                else
                {
                    counter = Convert.ToInt32(txtSeriesTo.Text) - Convert.ToInt32(txtSeriesFrom.Text);
                    if(counter == 0)
                        counter = 1;
                    else
                        counter += 1;
                    chkseries = counter;
                    serialSeriesFrom = Convert.ToInt32(txtSeriesFrom.Text);
                }
            }
            else
            {
                #region Fresh Code
                DataSet ds = new DataSet();
                SQL_DB.GetDA("SELECT  Pro_ID, Series_Order, Series_Serial FROM  dbo.M_Code where Pro_ID = '" + ddlProduct.SelectedValue + "' and (ScrapeFlag is null or ScrapeFlag = 0) AND ReceiveFlag = 1 AND Batch_No IS NULL ").Fill(ds, "1");
                counter = Convert.ToInt32(txtSeriesTo.Text) - Convert.ToInt32(txtSeriesFrom.Text);
                if (counter == 0)
                    counter = 1;
                else
                    counter += 1;
                txtNoOfCodes.Text = counter.ToString();
                if ((counter == 0) || (counter > ds.Tables["1"].Rows.Count))
                {
                    DivNewMsg.Visible = true;
                    DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                    LblMsg.Text = "Please enter valid Series Details !";
                    ProductDetailsPopUp.Show();
                    return;
                }
                if (ds.Tables["1"].Rows.Count > 0)
                {
                    int cnt = 0;
                    serial_order = Convert.ToInt32(txtSeries_Initial.Text);
                    serial_series = Convert.ToInt32(txtSeriesFrom.Text);
                    for (int i = 0; i < counter; i++)
                    {
                        if (i != 0)
                            serial_series++;
                        DataSet dsn = new DataSet();
                        SQL_DB.GetDA("SELECT  Pro_ID, Series_Order, Series_Serial FROM  dbo.M_Code where Pro_ID = '" + ddlProduct.SelectedValue + "' and (ScrapeFlag is null or ScrapeFlag = 0) AND ReceiveFlag = 1 and Series_Order = " + serial_order + " and Series_Serial= " + serial_series + " AND Batch_No IS NULL ").Fill(dsn, "2");
                        if (dsn.Tables["2"].Rows.Count == 0)
                            cnt++;
                    }
                    if (cnt > 0)
                    {
                        DivNewMsg.Visible = true;
                        DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                        LblMsg.Text = "Please enter valid Series Details !";
                        ProductDetailsPopUp.Show();
                        return;
                    }
                }
                else
                {
                    DivNewMsg.Visible = true;
                    DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                    LblMsg.Text = "Please enter valid Series Details !";
                    ProductDetailsPopUp.Show();
                    return;
                }
                #endregion
            }
            #endregion
            #region Update Logic
            if (Convert.ToInt32(txtNoOfCodes.Text) == 0)
            {
                DivNewMsg.Visible = true;
                DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                LblMsg.Text = "Please enter valid value !";
                ProductDetailsPopUp.Show();
                return;
            }

            if (Convert.ToInt32(txtNoOfCodes.Text) > Convert.ToInt32(LblAvlCodes.Text))
            {
                DivNewMsg.Visible = true;
                DivNewMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                LblMsg.Text = "No. of codes must not exceed the available codes !";
                ProductDetailsPopUp.Show();
                return;
            }
            DivNewMsg.Visible = false;




            string path_H = ""; string path_E = "";
            Object9420 obj = new Object9420();
            obj.Pro_ID = ddlProduct.SelectedValue;
            obj.Comp_ID = Session["CompanyId"].ToString();
            obj.MRP = Convert.ToDouble(txtMRP.Text.Trim());
            obj.Mfd_Date = Convert.ToDateTime(txtMfd_Date.Text);
            obj.Comments = txtComment.Text.Trim().Replace("'", "''");
            if (txtExp_Date.Text != "")
                obj.Exp_Date = txtExp_Date.Text;
            else
                obj.Exp_Date = null;
            obj.Row_ID = lblproid.Text;
            obj.NoofCodes = Convert.ToInt32(lblnoofcodes.Text);
            obj.Batch_No = null;
            function9420.UpDateBatchProductDetailsInM_CodeNew(obj);
            obj.Batch_No = txtBatchNo.Text.Trim().Replace("'", "''");
            function9420.UpdateBatchProductDetails(obj);
            obj.Batch_No = lblproid.Text.ToString();
            obj.NoofCodes = Convert.ToInt32(txtNoOfCodes.Text.Trim());

            //function9420.UpDateBatchProductDetailsInM_Code(obj);

            StringBuilder strb = new StringBuilder();
            //serial_order = Convert.ToInt32(txtSeries_Initial.Text);
            //serial_series = Convert.ToInt32(txtSeriesFrom.Text);

            serial_series = serialSeriesFrom;

            for (int i = 0; i < counter; i++)
            {
                if (i != 0)
                    serial_series++;//WHERE [Pro_ID] = @Pro_ID AND [Print_Status] = 1 AND ([Batch_No] IS NULL) AND (ISNULL(ScrapeFlag,0)=0) AND (DispatchFlag = 1) AND (ReceiveFlag = 1)
                strb.Append("UPDATE [M_Code] SET  [Batch_No] = '" + obj.Batch_No + "' where Pro_ID = '" + obj.Pro_ID + "' AND Series_Order = " + serial_order + " and Series_Serial= " + serial_series + " AND ([Batch_No] IS NULL) AND (ISNULL(ScrapeFlag,0)=0) ;");
            }
            if (strb.Length > 0)
                SQL_DB.ExecuteNonQuery(strb.ToString());


            //============new code 8/2/13===========
            string strser = SQL_DB.ExecuteScalar("select (SELECT top 1 'From  ' + pro_id +'-'+ (case when len(convert(nvarchar,[Series_Order])) = 1 then '0'+convert(nvarchar,[Series_Order]) else convert(nvarchar,[Series_Order]) end)+'-'+ convert(nvarchar,[Series_Serial])" +
            " FROM [M_Code] where print_status = 1 and pro_id = '" + obj.Pro_ID + "' and Batch_no is not null and batch_no = '" + obj.Row_ID + "'" +
            " order by [Series_Order],[Series_Serial]) +'   '+" +
            " (SELECT top 1 'To  ' + pro_id +'-'+ (case when len(convert(nvarchar,[Series_Order])) = 1 then '0'+convert(nvarchar,[Series_Order]) else convert(nvarchar,[Series_Order]) end)+'-'+ convert(nvarchar,[Series_Serial])" +
            " FROM [M_Code] where print_status = 1 and pro_id = '" + obj.Pro_ID + "' and Batch_no is not null and batch_no = '" + obj.Row_ID + "'" +
            " order by [Series_Order],[Series_Serial] desc) as serOrder").ToString();
            SQL_DB.ExecuteNonQuery("UPDATE [T_Pro]" +
            " SET [Series_Limit] = '" + strser + "'" +
            " WHERE Row_ID = " + obj.Row_ID + " ");
            //======================================

            if (flSound.FileName != "" || flSoundE.FileName != "")
            {
                string path = Server.MapPath("../Data/Sound");
                path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID + "\\" + obj.Row_ID;
                DataProvider.Utility.CreateDirectory(path);
                path_H = path + "\\" + obj.Row_ID + "_H.wav";
                if (flSound.FileName != "")
                {
                    flSound.SaveAs(path_H);
                    Business9420.function9420.UpdateFileFlagProDetH(obj);
                }
                path_E = path + "\\" + obj.Row_ID + "_E.wav";
                if (flSoundE.FileName != "")
                {
                    flSoundE.SaveAs(path_E);
                    Business9420.function9420.UpdateFileFlagProDetE(obj);
                }
            }
            Clear();
            filldata();
            ChangeValidationGroup(true);
            BigpopMsg.Visible = true;
            BigpopMsg.Attributes.Add("class", "alert_boxes_green big_msg");
            Label2.Text = "Product successfully updated !";
            #endregion
             */
            #endregion
        }
    }



    private string UpdateProID(string prefix)
    {
        SQL_DB.ExecuteNonQuery("UPDATE [Code_Gen] SET [PrFlag] = '0' WHERE [Prfor] = 'Product'");
        SQL_DB.ExecuteNonQuery("INSERT INTO [Code_Gen] ([Prfor],[PrPrefix] ,[PrStart],[PrFlag]) VALUES ('Product' ,'" + prefix + "' ,100 ,'1')");
        return SQL_DB.ExecuteScalar("SELECT [PrPrefix] + substring(convert(nvarchar,[PrStart]),2,2) as Product_Id FROM [Code_Gen] where [Prfor] = 'Product' and [PrFlag] = 1").ToString();
    }


    private string GenerateProductID()
    {
        string a1 = "";
        string prefix = "";
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [PrPrefix] + substring(convert(nvarchar,[PrStart]),2,2) as Product_Id,[PrStart]" +
        " FROM [Code_Gen] where [Prfor] = 'Product' and [PrFlag] = 1");
        int char1 = (int)Convert.ToChar(ds.Tables[0].Rows[0]["Product_Id"].ToString().Substring(0, 1));
        int char2 = (int)Convert.ToChar(ds.Tables[0].Rows[0]["Product_Id"].ToString().Substring(1, 1));
        if (ds.Tables[0].Rows[0]["PrStart"].ToString() == "200" && char2 == 90 && char1 == 90)
        {
            return a1;
        }
        if (ds.Tables[0].Rows[0]["PrStart"].ToString() == "200" && char2 != 90)
        {
            char2 = char2 + 1;
            prefix = Char.ConvertFromUtf32(char1) + Char.ConvertFromUtf32(char2);
            return UpdateProID(prefix);
        }
        if (ds.Tables[0].Rows[0]["PrStart"].ToString() == "200" && char2 == 90)
        {
            char1 = char1 + 1;
            char2 = 65;
            prefix = Char.ConvertFromUtf32(char1) + Char.ConvertFromUtf32(char2);
            return UpdateProID(prefix);
        }
        return ds.Tables[0].Rows[0]["Product_Id"].ToString();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        if (Session["Comp_type"].ToString() == "L")
            Clear();
        fillddlPro_Id();
        //   ProductDetailsPopUp.Show();
        Response.Redirect("ProductDetails.aspx");
    }
    private void Clear()
    {
        lblheading.Text = "Add Product Details";
        btnSave.Text = "Save";
        if (ddlProduct.Items.Count == 0)
            ddlProduct.Items.Insert(0, "--Select--");
        else
            ddlProduct.SelectedIndex = 0;
        txtBatchNo.Text = "";
        txtMRP.Text = "";
        txtMfd_Date.Text = "";
        txtExp_Date.Text = "";

        txtNoOfCodes.Text = "";
        chkComments.Checked = false;
        LblAvlCodes.Text = "";
        HdnAvlCodes.Value = string.Empty;
        HdnSeriesIni.Value = string.Empty;
        HdnBatchSize.Value = string.Empty;
        txtComment.Text = "";
        txtWarr.Text = "";
        chkHindi.Enabled = false;
        chkEnglish.Enabled = false;
        ChangeValidationGroup(true);
        LblMsg.Text = ""; //Label2.Text = "";// Label3.Text = "";
        chkHindi.Checked = false; chkEnglish.Checked = false;
        //  DivNewMsg.Visible = false;
        txtSeries_Initial1.Text = string.Empty;
        txtSeries_Initial.Text = string.Empty;
        txtSeriesFrom.Text = string.Empty;
        txtSeriesTo.Text = string.Empty;
    }


    protected void GrdProductMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        // BigpopMsg.Visible = false;
        if (e.CommandName == "ChangeBatchInfo")
        {
            Fieldset1.Visible = false;
            Clear();
            fillddlPro_IdEdit();
            Object9420 obj = new Object9420();
            obj.Row_ID = e.CommandArgument.ToString(); hdneditrowid.Value = e.CommandArgument.ToString();
            Business9420.function9420.FetchDataUpdateBatchProductDetails(obj);
            Business9420.function9420.FindOldNoofCodes(obj);
            lblproid.Text = e.CommandArgument.ToString();
            lblnoofcodes.Text = obj.NoofCodes.ToString();
            txtBatchNo.Text = obj.Batch_No;
            if (Convert.ToDateTime(obj.Mfd_Date).ToString("dd/MM/yyyy") != "01/01/1900")
                txtMfd_Date.Text = obj.Mfd_Date.ToString();
            else
                txtMfd_Date.Text = "";
            //txtMfd_Date.Text = obj.Mfd_Date.ToString();
            if (obj.Exp_Date.ToString() != "")
            {
                txtExp_Date.Text = obj.Exp_Date.ToString();
                if (Convert.ToDateTime(obj.Exp_Date).ToString("dd/MM/yyyy") != "01/01/1900")
                    txtExp_Date.Text = obj.Exp_Date.ToString();
                else
                    txtExp_Date.Text = "";
            }
            else
                txtExp_Date.Text = "";
            txtMRP.Text = obj.MRP.ToString();
            txtComment.Text = obj.Comments;
            txtWarr.Text = obj.Warranty.ToString();
            txtNoOfCodes.Text = lblnoofcodes.Text;
            //if (Session["Comp_type"].ToString() == "D")
            txtNoOfCodes.Enabled = false;
            //else
            //    txtNoOfCodes.Enabled = true;
            SFileE.HRef = obj.EnglishFle;
            SFileH.HRef = obj.HindiFile;
            ddlProduct.SelectedValue = obj.Pro_ID.ToString();
            HDF.Value = ddlProduct.SelectedValue;
            obj.Comp_ID = Session["CompanyId"].ToString();
            Business9420.function9420.FindAvilableCodes(obj);
            LblAvlCodes.Text = (Convert.ToInt32(lblnoofcodes.Text) + Convert.ToInt32(obj.Password)).ToString(); obj.Password = "";
            //string MySeriesDet = obj.statusstr.ToString().Replace("From  ", "").Replace("   To  ", ",").Trim();
            //string[] Arr = MySeriesDet.ToString().Split(',');
            //string[] Arr1 = Arr[0].ToString().Split('-');
            //string[] Arr2 = Arr[1].ToString().Split('-');
            //txtSeries_Initial1.Text = Arr1[0].ToString();
            //txtSeries_Initial.Text = string.Format("{0:00}", Convert.ToInt32(Arr1[1].ToString()));
            //txtSeriesFrom.Text = string.Format("{0:000}", Convert.ToInt32(Arr1[2].ToString()));
            //txtSeriesTo.Text = string.Format("{0:000}", Convert.ToInt32(Arr2[2].ToString()));
            //hdnSerialOrder.Value = Arr1[1].ToString();
            //hdnSeriesFrom.Value = Arr1[2].ToString();
            //hdnSeriesTo.Value = Arr2[2].ToString(); 
            lblbatchsize.Text = obj.BatchSize.ToString();

            #region change validation group for brand loyalty
            string ValGroup = "PRO"; bool Visible = false;
            DataTable dst = SQL_DB.ExecuteDataSet("SELECT Comments,Points FROM M_Loyalty WHERE IsActive = 0 AND IsDelete = 0 AND Pro_ID='" + ddlProduct.SelectedValue.ToString() + "'").Tables[0];
            if (dst.Rows.Count > 0)
            {
                ValGroup = "NA";
                Visible = false;
            }
            else
            {
                ValGroup = "PRO";
                Visible = true;
            }
            RequiredFieldValidator3.ValidationGroup = ValGroup;
            RequiredFieldValidator4.ValidationGroup = ValGroup;
            RequiredFieldValidator1.ValidationGroup = ValGroup;
            //     btn.Visible = Visible;
            //     mrp.Visible = Visible;
            mfd.Visible = Visible;
            #endregion

            btnSave.Text = "Update";
            lblheading.Text = "Update Product Details";
            ChangeValidationGroup(false);
            //  ProductDetailsPopUp.Show();
        }
        if (e.CommandName == "EditRow")
        {
            Clear();
            fillddlPro_IdEdit();
            Object9420 obj = new Object9420();
            obj.Row_ID = e.CommandArgument.ToString();
            Business9420.function9420.FetchDataUpdateBatchProductDetails(obj);
            Business9420.function9420.FindOldNoofCodes(obj);
            lblproid.Text = e.CommandArgument.ToString();
            lblnoofcodes.Text = obj.NoofCodes.ToString();
            txtBatchNo.Text = obj.Batch_No;
            txtMfd_Date.Text = obj.Mfd_Date.ToString();
            if (obj.Exp_Date.ToString() != "")
                txtExp_Date.Text = obj.Exp_Date.ToString();
            else
                txtExp_Date.Text = "";
            txtMRP.Text = obj.MRP.ToString();
            txtComment.Text = obj.Comments;
            txtWarr.Text = obj.Warranty.ToString();
            txtNoOfCodes.Text = lblnoofcodes.Text;
            if (Session["Comp_type"].ToString() == "D")
                txtNoOfCodes.Enabled = false;
            else
                txtNoOfCodes.Enabled = true;
            SFileE.HRef = obj.EnglishFle;
            SFileH.HRef = obj.HindiFile;
            ddlProduct.SelectedValue = obj.Pro_ID.ToString();
            HDF.Value = ddlProduct.SelectedValue;
            obj.Comp_ID = Session["CompanyId"].ToString();
            Business9420.function9420.FindAvilableCodes(obj);
            LblAvlCodes.Text = (Convert.ToInt32(lblnoofcodes.Text) + Convert.ToInt32(obj.Password)).ToString(); obj.Password = "";
            string MySeriesDet = obj.statusstr.ToString().Replace("From  ", "").Replace("   To  ", ",").Trim();
            string[] Arr = MySeriesDet.ToString().Split(',');
            string[] Arr1 = Arr[0].ToString().Split('-');
            string[] Arr2 = Arr[1].ToString().Split('-');
            txtSeries_Initial1.Text = Arr1[0].ToString();
            txtSeries_Initial.Text = string.Format("{0:00}", Convert.ToInt32(Arr1[1].ToString()));
            txtSeriesFrom.Text = string.Format("{0:000}", Convert.ToInt32(Arr1[2].ToString()));
            txtSeriesTo.Text = string.Format("{0:000}", Convert.ToInt32(Arr2[2].ToString()));
            hdnSerialOrder.Value = Arr1[1].ToString();
            hdnSeriesFrom.Value = Arr1[2].ToString();
            hdnSeriesTo.Value = Arr2[2].ToString();
            btnSave.Text = "Update";
            lblheading.Text = "Update Product Details";
            ChangeValidationGroup(false);
            //  ProductDetailsPopUp.Show();
        }
        else if (e.CommandName == "DownLodExcel")
        {
            Object9420 obj = new Object9420();
            obj.Row_ID = e.CommandArgument.ToString();
            DataSet ds = new DataSet();
            ds = SQL_DB.ExecuteDataSet("select Row_ID,Pro_ID,(SELECT Pro_Name FROM Pro_Reg  WHERE Pro_ID = T_Pro.Pro_ID) as Pro_Name,Mfd_Date,Exp_Date,Batch_No,Entry_Date,Series_Limit from T_Pro  WHERE Row_ID = '" + obj.Row_ID + "' ");
            obj.statusstr = ds.Tables[0].Rows[0]["Series_Limit"].ToString();
            string MySeriesDet = obj.statusstr.ToString().Replace("From  ", "").Replace("   To  ", ",").Trim();
            string[] Arr = MySeriesDet.ToString().Split(',');
            string[] Arr1 = Arr[0].ToString().Split('-');
            string[] Arr2 = Arr[1].ToString().Split('-');
            string Pro_ID = Arr1[0].ToString();
            int series_order = Convert.ToInt32(Arr1[1].ToString());
            int series_From = Convert.ToInt32(Arr1[2].ToString());
            int series_To = Convert.ToInt32(Arr2[2].ToString());
            string FileName = ds.Tables[0].Rows[0]["Batch_No"].ToString() + "_" + Convert.ToDateTime(ds.Tables[0].Rows[0]["Entry_Date"]).ToString("dd-MM-yyy hh:mm:ss tt");
          
            
            string Qry = "SELECT row_number() OVER (ORDER BY Excel.Series_Name) AS SNO,* from (SELECT Pro_ID +'-'+ (case when len(convert(nvarchar,Series_Order)) = 1 then '0'+convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end)+'-'+  " +
            "(case when len(convert(nvarchar,Series_Serial)) = 1 then '000'+convert(nvarchar,Series_Serial) when len(convert(nvarchar,Series_Serial)) = 2 then '00'+convert(nvarchar,Series_Serial) when len(convert(nvarchar,Series_Serial)) = 3 then '0'+convert(nvarchar,Series_Serial) else convert(nvarchar,Series_Serial) end) AS Series_Name ,Code1,' ' as Mark_Scrap FROM  M_Code " +
            "WHERE Pro_ID='" + Pro_ID + "' and print_status = 1 AND (Series_Order = " + series_order + ") AND (Series_Serial >= " + series_From + ") AND (Series_Serial <= " + series_To + ") ) as Excel";
            download(Qry, FileName, Session["Comp_Name"].ToString(), ds.Tables[0].Rows[0]["Pro_Name"].ToString(), ds.Tables[0].Rows[0]["Batch_No"].ToString(), Convert.ToDateTime(ds.Tables[0].Rows[0]["Entry_Date"].ToString()).ToString("dd/MM/yyyy"));
        }
        if (e.CommandName == "DeleteRow")
        {
            Object9420 obj = new Object9420();
            obj.Row_ID = e.CommandArgument.ToString();
            Business9420.function9420.FetchDataUpdateBatchProductDetails(obj);
            Business9420.function9420.FindOldNoofCodes(obj);
            lblproid.Text = e.CommandArgument.ToString();
            lblnoofcodes.Text = obj.NoofCodes.ToString();
            obj.NoofCodes = Convert.ToInt32(lblnoofcodes.Text);
            obj.Batch_No = null;
            function9420.UpDateBatchProductDetailsInM_CodeNew(obj);
            obj.Row_ID = e.CommandArgument.ToString();
            Business9420.function9420.DeleteBatchProductDetailsCodes(obj);
            string path = Server.MapPath("../Data/Sound");
            path = path + "\\" + Session["CompanyId"].ToString().Substring(5, 4) + "\\" + obj.Pro_ID + "\\" + obj.Row_ID;
            DataProvider.Utility.DeleteDirectory(path);
            Clear();
            filldata();
            //   BigpopMsg.Visible = true;
            //   BigpopMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            //   Label2.Text = "Product successfully deleted !";
        }

    }
    private void download(string Qry, string FileName, string Comp_Name, string Pro_Name, string Batch_No, string Pasted_Date)
    {

        string Str = "";
        DataSet ds_rpt = new DataSet();
        SQL_DB.GetDA(Qry).Fill(ds_rpt);
        Response.Clear();
        Response.Charset = "";
        Response.AddHeader("content-disposition", "attachment;filename=" + FileName + ".xls");
        Response.ContentType = "application/vnd.ms-excel";

        StringWriter writer = new StringWriter();
        Html32TextWriter htmlwriter = new Html32TextWriter(writer);

        TableCell tc = null;
        // DataGridItem
        DataGridItem di = new DataGridItem(0, 0, ListItemType.Item);

        tc = new TableCell();
        tc.Controls.Add(new LiteralControl("Label Pasting Report"));
        tc.BackColor = System.Drawing.ColorTranslator.FromHtml("#E6E6E6");
        tc.Font.Size = 20;
        tc.ForeColor = System.Drawing.Color.Red;
        tc.Font.Bold = true;
        tc.HorizontalAlign = HorizontalAlign.Center;
        tc.ColumnSpan = 4;

        // Add Rows
        di.Controls.AddAt(0, tc);

        // DataGridItem
        DataGridItem di1 = new DataGridItem(0, 0, ListItemType.Item);

        tc = new TableCell();
        tc.Controls.Add(new LiteralControl("Company Name :"));
        tc.Font.Size = 14;
        tc.Font.Bold = true;
        tc.HorizontalAlign = HorizontalAlign.Right;

        di1.Controls.AddAt(0, tc);

        tc = new TableCell();
        tc.Controls.Add(new LiteralControl(Comp_Name));
        tc.Font.Size = 12;
        tc.Font.Bold = true;
        tc.HorizontalAlign = HorizontalAlign.Left;

        di1.Controls.AddAt(1, tc);

        tc = new TableCell();
        tc.Controls.Add(new LiteralControl("Product Name :"));
        tc.Font.Size = 14;
        tc.Font.Bold = true;
        tc.HorizontalAlign = HorizontalAlign.Left;

        di1.Controls.AddAt(2, tc);

        tc = new TableCell();
        tc.Controls.Add(new LiteralControl(Pro_Name));
        tc.Font.Size = 12;
        tc.Font.Bold = true;
        tc.HorizontalAlign = HorizontalAlign.Left;

        di1.Controls.AddAt(3, tc);

        // DataGridItem
        DataGridItem di2 = new DataGridItem(0, 0, ListItemType.Item);

        tc = new TableCell();
        tc.Controls.Add(new LiteralControl("Batch No:"));
        tc.Font.Size = 14;
        tc.Font.Bold = true;
        tc.HorizontalAlign = HorizontalAlign.Right;

        di2.Controls.AddAt(0, tc);

        tc = new TableCell();
        tc.Controls.Add(new LiteralControl(Batch_No));
        tc.Font.Size = 12;
        tc.Font.Bold = true;
        tc.HorizontalAlign = HorizontalAlign.Left;

        di2.Controls.AddAt(1, tc);

        tc = new TableCell();
        tc.Controls.Add(new LiteralControl("Pasted Date :"));
        tc.Font.Size = 14;
        tc.Font.Bold = true;
        tc.HorizontalAlign = HorizontalAlign.Left;

        di2.Controls.AddAt(2, tc);

        tc = new TableCell();
        tc.Controls.Add(new LiteralControl(Pasted_Date));
        tc.Font.Size = 12;
        tc.Font.Bold = true;
        tc.HorizontalAlign = HorizontalAlign.Left;

        di2.Controls.AddAt(3, tc);



        // DataGridItem
        DataGridItem di3 = new DataGridItem(0, 0, ListItemType.Item);

        tc = new TableCell();
        tc.Controls.Add(new LiteralControl("Name Of Incharge"));
        tc.Font.Size = 13;
        tc.Font.Bold = true;
        tc.HorizontalAlign = HorizontalAlign.Center;
        tc.VerticalAlign = VerticalAlign.Top;
        tc.ColumnSpan = 2;

        // Add Rows
        di3.Controls.AddAt(0, tc);

        tc = new TableCell();
        tc.Controls.Add(new LiteralControl("Signature"));
        tc.Font.Size = 13;
        tc.Font.Bold = true;
        tc.HorizontalAlign = HorizontalAlign.Center;
        tc.ColumnSpan = 2;
        tc.Height = 80;
        tc.VerticalAlign = VerticalAlign.Top;

        // Add Rows
        di3.Controls.AddAt(1, tc);




        DataGrid grd = new DataGrid();
        grd.DataSource = ds_rpt.Tables[0];
        grd.DataBind();


        Table childTable = (Table)grd.Controls[0];
        childTable.Rows.AddAt(0, di);
        childTable.Rows.AddAt(1, di1);
        childTable.Rows.AddAt(2, di2);
        childTable.Rows.Add(di3);

        grd.AlternatingItemStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#E6E6E6");
        //grd.Caption = "Label Psting Report";
        //grd.Enabled = false;
        //grd.ShowFooter = true;
        ////grd.Columns.IsReadOnly;



        grd.RenderControl(htmlwriter);
        Response.Write(writer.ToString());
        Response.End();
        htmlwriter.Close();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        // txtDateFrom.Text = ""; txtDateTo.Text = ""; txtProductName.Text = ""; filldata();
        // BigpopMsg.Visible = false;
    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        //  BigpopMsg.Visible = false;
        //  filldata();
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        // BigpopMsg.Visible = false;
        filldata();
    }

    protected void GrdProductMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        // BigpopMsg.Visible = false;
        // GrdProductMaster.PageIndex = e.NewPageIndex;
        filldata();
    }
    protected void chkComments_CheckedChanged(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        SQL_DB.GetDA("SELECT Comments FROM T_Pro WHERE Pro_ID IN (SELECT Pro_ID FROM Pro_Reg WHERE (Comp_ID = '" + Session["CompanyId"].ToString() + "')) ORDER BY Row_ID DESC").Fill(ds, "1");
        if (ds.Tables["1"].Rows.Count > 0)
        {
            if (chkComments.Checked == true)
                txtComment.Text = ds.Tables["1"].Rows[0]["Comments"].ToString();
            else
                txtComment.Text = string.Empty;
        }
        else
            txtComment.Text = string.Empty;
        // ProductDetailsPopUp.Show();
    }
    protected void chkHindi_CheckedChanged(object sender, EventArgs e)
    {
        if (chkHindi.Checked == true && chkEnglish.Checked == true)
        {
            //RequiredFieldValidator522.ValidationGroup = "NN";
            //RequiredFieldValidator6English.ValidationGroup = "NN";
            L2.Text = ""; L1.Text = "";
            //   ProductDetailsPopUp.Show();
        }
        else if (chkHindi.Checked == true && chkEnglish.Checked != true)
        {
            //RequiredFieldValidator522.ValidationGroup = "NN";
            //RequiredFieldValidator6English.ValidationGroup = "PRO";
            L2.Text = ""; L1.Text = "*";
            //  ProductDetailsPopUp.Show();
        }
        else if (chkHindi.Checked != true && chkEnglish.Checked == true)
        {
            //RequiredFieldValidator6English.ValidationGroup = "NN";
            //RequiredFieldValidator522.ValidationGroup = "PRO";
            L2.Text = "*"; L1.Text = "";
            // ProductDetailsPopUp.Show();
        }
        else if (chkHindi.Checked != true && chkEnglish.Checked != true)
        {
            //RequiredFieldValidator522.ValidationGroup = "PRO";
            //RequiredFieldValidator6English.ValidationGroup = "PRO";
            L2.Text = "*"; L1.Text = "*";
            //  ProductDetailsPopUp.Show();
        }

    }
    protected void btnYesActivation_Click(object sender, EventArgs e)
    {
        if (btnYesActivation.Text == "Ok")
            Response.Redirect("RegisteredProduct.aspx");
        else if (btnYesActivation.Text == "OK")
            Response.Redirect("FrmLabelDispatch.aspx");
    }

    protected void imgNew_Click1(object sender, EventArgs e)
    {
        Response.Redirect("AddProductDetails.aspx");
    }
}