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
using System.IO;
using DataProvider;
using System.Web.Services;

public partial class FrmCourierDispatch : System.Web.UI.Page
{
    public string _Prop_PrintRecp { get; set; }
    //public string Prop_PrintRecp
    //{
    //    get { return (string)ViewState["Prop_PrintRecp1"]; }
    //    set { ViewState["Prop_PrintRecp1"] = value; }
    //}
    public string Prop_PrintRecp
    {
        get { return (string)ViewState["_Prop_PrintRecp"]; }
        set { ViewState["_Prop_PrintRecp"] = value; }
    }

    // public string server = Convert.ToString(ConfigurationManager.ConnectionStrings["ServerName"].ConnectionString), userID = Convert.ToString(ConfigurationManager.ConnectionStrings["UserNameDspth"].ConnectionString), password = Convert.ToString(ConfigurationManager.ConnectionStrings["Password"].ConnectionString);
    public string srt = DataProvider.Utility.FindMailBody();
    public static string ExcelQry = "", VarLabelRequestID = "";
    public int index = 0, VarL = 0;

    DataTable LabelDataTableInfo = new DataTable();
    DataTable LabelDataTableInfoEdit = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        // Prop_PrintRecp = ProjectSession.absoluteSiteBrowseUrl + "/Admin/Bill/Invoice/25-06-2017/INVL17-1315.pdf";
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmCourierDispatch.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {
            ExcelQry = "";
            FillCompany();
            FillCourierCompany();
            FillGrdMain();
            LabelDataTableInfoEdit = CreateFileDataTable();
            LabelDataTableInfo = CreateFileDataTable();
            Session["LBLInfo"] = LabelDataTableInfo;
            LogManager.WriteCourierDispatch("Session Created");
            Session["LBLInfoEdit"] = LabelDataTableInfoEdit;
            Session["ProID"] = "";
        }
    }

    private DataTable CreateFileDataTable()
    {
        DataTable myDataTable = new DataTable();
        DataColumn myDataColumn;
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Courier_Disp_ID";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Pro_ID";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Pro_Name";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Label_Code";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Label_Name";
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
    private void AddPrintLabelInfo(string Courier_Disp_ID, string Pro_ID, string Pro_Name, string Label_Code, string Label_Name, string Series_From, string Series_To, string Qty, DataTable myTable)
    {
        DataRow row;
        row = myTable.NewRow();
        row["Courier_Disp_ID"] = Courier_Disp_ID;
        row["Pro_ID"] = Pro_ID;
        row["Pro_Name"] = Pro_Name;
        row["Label_Code"] = Label_Code;
        row["Label_Name"] = Label_Name;
        row["Series_From"] = Series_From;
        row["Series_To"] = Series_To;
        row["Qty"] = Qty;
        myTable.Rows.Add(row);
        if (myTable.Rows.Count == 1)
            Session["ProID"] = Pro_ID;

        LogManager.WriteCourierDispatch("Add rows to session (DataTable myTable)");
        LogManager.WriteCourierDispatch("myTable valuse - " + myTable.Rows.Count.ToString());
        LogManager.WriteCourierDispatch("------------------------------");
    }
    private void TxtClear()
    {
        txtDispatchDate.Text = string.Empty;
        txtDispLocation.Text = string.Empty;
        txtExpectedDate.Text = string.Empty;
        txtSearchName.Text = string.Empty;
        //txtTrackingNo.Text = string.Empty;
        string TrackingNo = function9420.GetTrackingId("Tracking No");
        txtTrackingNo.Text = TrackingNo;
        lblAddCourierHeader.Text = "Add New Courior Dispatch Details";
        btnCourierSubmit.Text = "Save";
        clearinfo();
        FillCompany();
        FillCourierCompany();
        lblUpFlTblId.Text = string.Empty;
        Session["ProID"] = "";
        txtDispLocation.Text = string.Empty;
    }
    private void FillCompany()
    {
        DataSet ds = function9420.FillActiveComp();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", DDLCompany, "--Select--");
        DDLCompany.SelectedIndex = 0;
        ddlProduct.Items.Clear();
        ddlProduct.Items.Insert(0, "--Select--");
        ddlProduct.SelectedIndex = 0;
    }
    private void FillCourierCompany()
    {
        DataSet ds = function9420.FillCorierCompany();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Courier_ID", "Courier_Name", DDLCourierCompany, "--Select--");
        DDLCourierCompany.SelectedIndex = 0;
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        ((DataTable)Session["LBLInfo"]).Rows.Clear();
        LogManager.WriteCourierDispatch("Session cleared at Add (+) click");
        FillGrdLabelInfo();
        //fillProduct("I");
        TxtClear();
        DivNewMsg.Visible = false;
        newMsg.Visible = false;
        ModalPopupExtenderNewDesign.Show();
    }
    private bool ChkSeries()
    {
        int cc = 0; int kcount = 0;
        DataTable dt = (DataTable)Session["LBLInfo"];
        LogManager.WriteCourierDispatch("Session cast to datatable in ChkSeries()");
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
                    string SeriesI1 = dt.Rows[l]["Series_From"].ToString().Substring(0, 9);
                    int SerialFrom1 = Convert.ToInt32(dt.Rows[l]["Series_From"].ToString().Substring(10, 4));
                    int SerialTo1 = Convert.ToInt32(dt.Rows[l]["Series_To"].ToString().Substring(10, 4));
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
                    string SeriesI1 = dt.Rows[l]["Series_From"].ToString().Substring(0, 9);
                    int SerialFrom1 = Convert.ToInt32(dt.Rows[l]["Series_From"].ToString().Substring(10, 4));
                    int SerialTo1 = Convert.ToInt32(dt.Rows[l]["Series_To"].ToString().Substring(10, 4));
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
                string[] Serialcode = txtSeries_Initial.Text.Split('-');
                string pro = Serialcode[0];
                Int32 Series_Order = Convert.ToInt32(Serialcode[1]);
                Int32 Series_Serial = Convert.ToInt32(txtSeriesFrom.Text);
                Int32 Series_Serial1 = Convert.ToInt32(txtSeriesTo.Text);
                if (Convert.ToInt32(Series_Serial1) >= Convert.ToInt32(Series_Serial))
                {
                    lblProDetailsMsg.Text = "";
                    str = " AND Series_Order=" + Series_Order + " AND Series_Serial >= " + Series_Serial;
                    str += " AND Series_Serial<=" + Series_Serial1 + " AND LabelRequestId IN (SELECT Tracking_No FROM M_Label_Request WHERE Pro_ID = '" + Reg.Pro_ID + "' AND Label_Code = '" + ddlLabel.SelectedValue.ToString() + "' ) ";
                    if (Convert.ToInt32(Series_Serial) == 0)
                        pcount = Convert.ToInt32(Series_Serial1) + 1;
                    else
                        pcount = Convert.ToInt32(Series_Serial1) - Convert.ToInt32(Series_Serial) + 1;
                    if (kcount == 0)
                    {
                        if (function9420.ChkSeries(Reg, str, pcount))
                            return true;
                        else
                            return false;
                    }
                    else
                    {
                        if (function9420.ChkSeries(Reg, str, pcount, kcount))
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

private void UpdateDispatchFlagSeries_CompId(string s)
    {
        Object9420 Reg = new Object9420();
        Reg.Courier_Disp_ID = lblCourierId.Text;
        DataSet ds = function9420.GetCourierDispLabelInfoID(Reg); // fetch record from Courier_Disp_ID
        if (ds.Tables[0].Rows.Count > 0)
        { // shweta code-----------------------------------
            ExecuteNonQueryAndDatatable.UpdateM_Code_DispatchFlagCompId(Reg.Courier_Disp_ID);

            if (s == "U")
                function9420.DeleteCourierProDispInfo(Reg);
        }
    }

    private void UpdateDispatchFlagSeries_New(string s)
    {
        Object9420 Reg = new Object9420();
        Reg.Courier_Disp_ID = lblCourierId.Text;
        DataSet ds = function9420.GetCourierDispLabelInfoID(Reg); // fetch record from Courier_Disp_ID
        if (ds.Tables[0].Rows.Count > 0)
        { // shweta code-----------------------------------
            ExecuteNonQueryAndDatatable.UpdateM_Code_DispatchFlag(Reg.Courier_Disp_ID);
            // for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            //{
            //G:
            //    Reg.Pro_ID = ds.Tables[0].Rows[i]["Pro_ID"].ToString();
            //    string str = ""; int pcount = 0;
            //    string[] Serialcode = ds.Tables[0].Rows[i]["Series_From"].ToString().Split('-');
            //    string pro = Serialcode[0];
            //    Int32 Series_Order = Convert.ToInt32(Serialcode[1]);
            //    Int32 Series_Serial = Convert.ToInt32(Serialcode[2]);
            //    string[] Serialcode1 = ds.Tables[0].Rows[i]["Series_To"].ToString().Split('-');
            //    string pro1 = Serialcode1[0];
            //    Int32 Series_Order1 = Convert.ToInt32(Serialcode1[1]);
            //    Int32 Series_Serial1 = Convert.ToInt32(Serialcode1[2]);
            //    if (Series_Order == Series_Order1 && pro == pro1) //&& pro == ddlProduct.SelectedValue.ToString() && pro == ddlProduct.SelectedValue.ToString()
            //    {
            //        lblProDetailsMsg.Text = "";
            //        str = " AND Series_Order=" + Series_Order + " AND Series_Serial >= " + Series_Serial;
            //        str += " AND Series_Serial<=" + Series_Serial1;
            //        if (Convert.ToInt32(Series_Serial1) >= Convert.ToInt32(Series_Serial))
            //        {
            //            if (Convert.ToInt32(Series_Serial) == 0)
            //                pcount = Convert.ToInt32(Series_Serial1) + 1;
            //            else
            //                pcount = Convert.ToInt32(Series_Serial1) - Convert.ToInt32(Series_Serial) + 1;
            //        }
            //        DataSet dsUpd = new DataSet();
            //        if (s == "I")
            //            dsUpd = function9420.ChkSeriesForupdate(Reg, str, pcount);
            //        else if (s == "U")
            //            dsUpd = function9420.ChkSeriesForupdateM_Code(Reg, str, pcount);
            //        if (dsUpd.Tables[0].Rows.Count > 0)
            //        {
            //            #region Looks code is not in use
            //            StringBuilder sb = new StringBuilder();
            //            StringBuilder sb1 = new StringBuilder();

            //            DataTable dtMyTable = new DataTable();
            //            //DataColumn myDataColumn ;
            //            DataColumn myDataColumn = new DataColumn();
            //            myDataColumn.DataType = Type.GetType("System.String");
            //            myDataColumn.ColumnName = "Code1";
            //            dtMyTable.Columns.Add(myDataColumn);

            //            DataColumn myDataColumn1 = new DataColumn();
            //            myDataColumn1.DataType = Type.GetType("System.String");
            //            myDataColumn1.ColumnName = "Code2";
            //            dtMyTable.Columns.Add(myDataColumn1);

            //            //sb.Append("UPDATE [M_Code] SET  [DispatchFlag] = nsal.DispatchFlag,[ReceiveFlag]= nsal.ReceiveFlag  FROM [M_Code] INNER JOIN (  ");
            //            //sb1.Append("UPDATE a SET  a.[DispatchFlag] = nsal.DispatchFlag  FROM [M_Code] a INNER JOIN (  ");
            //            for (int p = Series_Serial, k = 0; p <= Series_Serial1; p++, k++)
            //            {
            //                if (s == "U")
            //                {
            //                    //sb.Append("select null as DispatchFlag,null as ReceiveFlag,'" + dsUpd.Tables[0].Rows[k]["Code1"].ToString() + "' as Code1,'" + dsUpd.Tables[0].Rows[k]["Code2"].ToString() + "' as Code2 union ");
            //                    sb.Append("UPDATE [M_Code] SET  [DispatchFlag] = null , [ReceiveFlag] = null WHERE [Code1] = '" + dsUpd.Tables[0].Rows[k]["Code1"].ToString() + "' AND [Code2] = '" + dsUpd.Tables[0].Rows[k]["Code2"].ToString() + "' ;"); // AND [Use_Type] = 'L'  AND [Pro_ID] = '" + pro + "' AND [Print_Status] = 1 AND [Print_Date] <> null AND [Batch_No] <> null  AND [Series_Order] = " + Series_Order + " AND [Series_Serial] = " + p +"  AND [ScrapeFlag] = 0 
            //                }
            //                else if (s == "I")
            //                {
            //                    DataRow row;
            //                    row = dtMyTable.NewRow();
            //                    row["Code1"] = dsUpd.Tables[0].Rows[k]["Code1"].ToString();
            //                    row["Code2"] = dsUpd.Tables[0].Rows[k]["Code2"].ToString();
            //                    dtMyTable.Rows.Add(row);


            //                    // sb1.Append("select 1 ,'" + dsUpd.Tables[0].Rows[k]["Code1"].ToString() + "' , '" + dsUpd.Tables[0].Rows[k]["Code2"].ToString() + "'  union ");
            //                    //if (sb1.ToString().Contains("as Code1"))
            //                    //    sb1.Append("select 1 ,'" + dsUpd.Tables[0].Rows[k]["Code1"].ToString() + "' , '" + dsUpd.Tables[0].Rows[k]["Code2"].ToString() + "'  union ");
            //                    //else 
            //                    // sb1.Append("select 1 as DispatchFlag,'" + dsUpd.Tables[0].Rows[k]["Code1"].ToString() + "' as Code1, '" + dsUpd.Tables[0].Rows[k]["Code2"].ToString() + "' as Code2 union ");
            //                    sb.Append("Insert into Temp_Dispatch values('" + dsUpd.Tables[0].Rows[k]["Code1"].ToString() + "','" + dsUpd.Tables[0].Rows[k]["Code2"].ToString() + "');");
            //                    //sb.Append("UPDATE [M_Code] SET  [DispatchFlag] = 1 WHERE [Code1] = '" + dsUpd.Tables[0].Rows[k]["Code1"].ToString() + "' AND [Code2] = '" + dsUpd.Tables[0].Rows[k]["Code2"].ToString() + "' ;");
            //                }
            //            }
            //            // string newSb = sb.ToString().Substring(0, sb.ToString().Length - 6);
            //            // string newSb1 = sb1.ToString().Substring(0, sb1.ToString().Length - 6);
            //            //newSb = newSb + " ) nsal on ([M_Code].Code1 = nsal.Code1 and [M_Code].Code2 = nsal.Code2  )";
            //            //  newSb1 = newSb1 + " ) nsal on (a.Code1 = nsal.Code1 and a.Code2 = nsal.Code2  ) ";
            //            //if (s == "U")
            //            //{
            //            //    if (!function9420.UpdateM_Code(sb.ToString()))
            //            //        goto G;
            //            //}
            //            //else if (s == "I")
            //            //{
            //            //    if (!function9420.UpdateM_Code(newSb1.ToString()))
            //            //        goto G;
            //            //}


            //            //if (!function9420.UpdateM_Code(newSb.ToString()))
            //            //    goto G;

            //            //sb.Append(") nsal on [M_Code].where = nsal.where ");
            //            Session["DemoDispatchTable"] = dtMyTable;
            //            SaveTempDispatch(dtMyTable);



            //            //if (!function9420.UpdateM_Code(sb.ToString()))
            //            //    goto G;
            //            #endregion
            //        }
            //    }
            //}
            if (s == "U")
                function9420.DeleteCourierProDispInfo(Reg);
        }
    }

    private void UpdateDispatchFlagSeries(string s)
    {
        Object9420 Reg = new Object9420();
        Reg.Courier_Disp_ID = lblCourierId.Text;
        DataSet ds = function9420.GetCourierDispLabelInfoID(Reg); // fetch record from Courier_Disp_ID
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
            G:
                Reg.Pro_ID = ds.Tables[0].Rows[i]["Pro_ID"].ToString();
                string str = ""; int pcount = 0;
                string[] Serialcode = ds.Tables[0].Rows[i]["Series_From"].ToString().Split('-');
                string pro = Serialcode[0];
                Int32 Series_Order = Convert.ToInt32(Serialcode[1]);
                Int32 Series_Serial = Convert.ToInt32(Serialcode[2]);
                string[] Serialcode1 = ds.Tables[0].Rows[i]["Series_To"].ToString().Split('-');
                string pro1 = Serialcode1[0];
                Int32 Series_Order1 = Convert.ToInt32(Serialcode1[1]);
                Int32 Series_Serial1 = Convert.ToInt32(Serialcode1[2]);
                if (Series_Order == Series_Order1 && pro == pro1) //&& pro == ddlProduct.SelectedValue.ToString() && pro == ddlProduct.SelectedValue.ToString()
                {
                    lblProDetailsMsg.Text = "";
                    str = " AND Series_Order=" + Series_Order + " AND Series_Serial >= " + Series_Serial;
                    str += " AND Series_Serial<=" + Series_Serial1;
                    if (Convert.ToInt32(Series_Serial1) >= Convert.ToInt32(Series_Serial))
                    {
                        if (Convert.ToInt32(Series_Serial) == 0)
                            pcount = Convert.ToInt32(Series_Serial1) + 1;
                        else
                            pcount = Convert.ToInt32(Series_Serial1) - Convert.ToInt32(Series_Serial) + 1;
                    }
                    DataSet dsUpd = new DataSet();
                    if (s == "I")
                        dsUpd = function9420.ChkSeriesForupdate(Reg, str, pcount);
                    else if (s == "U")
                        dsUpd = function9420.ChkSeriesForupdateM_Code(Reg, str, pcount);
                    if (dsUpd.Tables[0].Rows.Count > 0)
                    {
                        #region Looks code is not in use
                        StringBuilder sb = new StringBuilder();
                        StringBuilder sb1 = new StringBuilder();

                        DataTable dtMyTable = new DataTable();
                        //DataColumn myDataColumn ;
                        DataColumn myDataColumn = new DataColumn();
                        myDataColumn.DataType = Type.GetType("System.String");
                        myDataColumn.ColumnName = "Code1";
                        dtMyTable.Columns.Add(myDataColumn);

                        DataColumn myDataColumn1 = new DataColumn();
                        myDataColumn1.DataType = Type.GetType("System.String");
                        myDataColumn1.ColumnName = "Code2";
                        dtMyTable.Columns.Add(myDataColumn1);

                        //sb.Append("UPDATE [M_Code] SET  [DispatchFlag] = nsal.DispatchFlag,[ReceiveFlag]= nsal.ReceiveFlag  FROM [M_Code] INNER JOIN (  ");
                        //sb1.Append("UPDATE a SET  a.[DispatchFlag] = nsal.DispatchFlag  FROM [M_Code] a INNER JOIN (  ");
                        for (int p = Series_Serial, k = 0; p <= Series_Serial1; p++, k++)
                        {
                            if (s == "U")
                            {
                                //sb.Append("select null as DispatchFlag,null as ReceiveFlag,'" + dsUpd.Tables[0].Rows[k]["Code1"].ToString() + "' as Code1,'" + dsUpd.Tables[0].Rows[k]["Code2"].ToString() + "' as Code2 union ");
                                sb.Append("UPDATE [M_Code] SET  [DispatchFlag] = null , [ReceiveFlag] = null WHERE [Code1] = '" + dsUpd.Tables[0].Rows[k]["Code1"].ToString() + "' AND [Code2] = '" + dsUpd.Tables[0].Rows[k]["Code2"].ToString() + "' ;"); // AND [Use_Type] = 'L'  AND [Pro_ID] = '" + pro + "' AND [Print_Status] = 1 AND [Print_Date] <> null AND [Batch_No] <> null  AND [Series_Order] = " + Series_Order + " AND [Series_Serial] = " + p +"  AND [ScrapeFlag] = 0 
                            }
                            else if (s == "I")
                            {
                                DataRow row;
                                row = dtMyTable.NewRow();
                                row["Code1"] = dsUpd.Tables[0].Rows[k]["Code1"].ToString();
                                row["Code2"] = dsUpd.Tables[0].Rows[k]["Code2"].ToString();
                                dtMyTable.Rows.Add(row);


                                // sb1.Append("select 1 ,'" + dsUpd.Tables[0].Rows[k]["Code1"].ToString() + "' , '" + dsUpd.Tables[0].Rows[k]["Code2"].ToString() + "'  union ");
                                //if (sb1.ToString().Contains("as Code1"))
                                //    sb1.Append("select 1 ,'" + dsUpd.Tables[0].Rows[k]["Code1"].ToString() + "' , '" + dsUpd.Tables[0].Rows[k]["Code2"].ToString() + "'  union ");
                                //else 
                                // sb1.Append("select 1 as DispatchFlag,'" + dsUpd.Tables[0].Rows[k]["Code1"].ToString() + "' as Code1, '" + dsUpd.Tables[0].Rows[k]["Code2"].ToString() + "' as Code2 union ");
                                sb.Append("Insert into Temp_Dispatch values('" + dsUpd.Tables[0].Rows[k]["Code1"].ToString() + "','" + dsUpd.Tables[0].Rows[k]["Code2"].ToString() + "');");
                                //sb.Append("UPDATE [M_Code] SET  [DispatchFlag] = 1 WHERE [Code1] = '" + dsUpd.Tables[0].Rows[k]["Code1"].ToString() + "' AND [Code2] = '" + dsUpd.Tables[0].Rows[k]["Code2"].ToString() + "' ;");
                            }
                        }
                        // string newSb = sb.ToString().Substring(0, sb.ToString().Length - 6);
                        // string newSb1 = sb1.ToString().Substring(0, sb1.ToString().Length - 6);
                        //newSb = newSb + " ) nsal on ([M_Code].Code1 = nsal.Code1 and [M_Code].Code2 = nsal.Code2  )";
                        //  newSb1 = newSb1 + " ) nsal on (a.Code1 = nsal.Code1 and a.Code2 = nsal.Code2  ) ";
                        //if (s == "U")
                        //{
                        //    if (!function9420.UpdateM_Code(sb.ToString()))
                        //        goto G;
                        //}
                        //else if (s == "I")
                        //{
                        //    if (!function9420.UpdateM_Code(newSb1.ToString()))
                        //        goto G;
                        //}


                        //if (!function9420.UpdateM_Code(newSb.ToString()))
                        //    goto G;

                        //sb.Append(") nsal on [M_Code].where = nsal.where ");
                        Session["DemoDispatchTable"] = dtMyTable;
                        SaveTempDispatch(dtMyTable);



                        //if (!function9420.UpdateM_Code(sb.ToString()))
                        //    goto G;
                        #endregion
                    }
                }
            }
            if (s == "U")
                function9420.DeleteCourierProDispInfo(Reg);
        }
    }

    private void SaveTempDispatch(DataTable dt)
    {
        SQL_DB.ExecuteNonQuery("TRUNCATE TABLE Temp_Dispatch");
        SqlConnection conn = dtcon.CreateConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.Open();
        if (((DataTable)Session["DemoDispatchTable"]).Rows.Count > 0)
        {
            using (SqlBulkCopy bulkCopy = new SqlBulkCopy(conn))
            {
                bulkCopy.DestinationTableName = "Temp_Dispatch";

                try
                {
                    // Write from the source to the destination.
                    bulkCopy.BulkCopyTimeout = 0;
                    bulkCopy.WriteToServer(dt);
                    Session["DemoDispatchTable"] = null;
                    //creating blank dt for dispatch 
                    //CodeTableInfo = CreateBlankDispatchDataTable();
                    //Session["DemoDispatchTable"] = CodeTableInfo;
                }
                catch (Exception ex)
                {
                    LogManager.WriteExe("Dispatch(SaveTempDispatch)  : Error " + ex.Message.ToString());
                }
            }
        }
        string str = "Insert Complete";
        try
        {
            //Business9420.function9420.PrintCodes();
            //SqlTransaction tr1 ;
            //tr1.Connection.BeginTransaction();
            SQL_DB.ExecuteNonQuery("update mc set mc.DispatchFlag = 1 from Temp_Dispatch td inner join M_code mc on td.code1 = mc.code1 and td.code2 = mc.code2");

            //if (conn.State == ConnectionState.Open)
            //    conn.Close();
            //conn.Open();
        }
        catch (Exception ex)
        {
            LogManager.WriteExe("Dispatch(SaveTempDispatch)  : Error " + ex.Message.ToString());
            //Response.Write(ex.Message.ToString());
        }
    }


    protected void btnAddPro_Click(object sender, ImageClickEventArgs e)
    {
        DivNewMsg.Visible = false;
        DivNewMsg.Attributes.Add("class", "");
        lblpopmsg.Text = string.Empty;
        string str = txtSeries_Initial.Text.ToString().Substring(0, 4).ToString();
        if (ddlProduct.SelectedValue.ToString() != str)
        {
            lblProDetailsMsg.Text = "Please select Valid Series!";
            lblProDetailsMsg.ForeColor = System.Drawing.Color.Red;
            ModalPopupExtenderNewDesign.Show();
            return;
        }
        if (ddlProduct.SelectedIndex == 0)
        {
            lblProDetailsMsg.Text = "Please select Product!";
            lblProDetailsMsg.ForeColor = System.Drawing.Color.Red;
            ModalPopupExtenderNewDesign.Show();
            return;
        }
        if (ddlLabel.SelectedIndex == 0)
        {
            lblProDetailsMsg.Text = "Please select Label Type!";
            lblProDetailsMsg.ForeColor = System.Drawing.Color.Red;
            ModalPopupExtenderNewDesign.Show();
            return;
        }
        if (Convert.ToInt32(txtSeriesTo.Text) >= Convert.ToInt32(txtSeriesFrom.Text))
        {
            if (btnAddPro.ImageUrl == "~/Content/images/add_new.png")
            {
                if (ChkSeries())
                {
                    DataTable myTable = (DataTable)Session["LBLInfo"];
                    LogManager.WriteCourierDispatch("Session cast to dt at btnAddPro_Click ");
                    if (myTable.Rows.Count > 0)
                    {
                        for (int k = 0; k < myTable.Rows.Count; k++)
                        {
                            string[] Arr = txtSeries_Initial.Text.Trim().Replace("'", "''").ToString().Split('-');
                            if (Arr[1] != "")
                            {
                                AddPrintLabelInfo("", ddlProduct.SelectedValue.ToString(), ddlProduct.SelectedItem.Text.ToString(), ddlLabel.SelectedValue.ToString(), ddlLabel.SelectedItem.Text.ToString(), txtSeries_Initial.Text.Trim().Replace("'", "''") + "-" + txtSeriesFrom.Text.Trim().Replace("'", "''").ToString(),
                                    txtSeries_Initial.Text.Trim().Replace("'", "''") + "-" + txtSeriesTo.Text.Trim().Replace("'", "''").ToString(), LblCountQty.Text.ToString(), (DataTable)Session["LBLInfo"]);
                                LogManager.WriteCourierDispatch("Add rows to session (DataTable myTable)");
                                LogManager.WriteCourierDispatch("(DataTable)Session[LBLInfo] valuse - " + ((DataTable)Session["LBLInfo"]).Rows.Count.ToString());
                                LogManager.WriteCourierDispatch("------------------------------");
                                Session["ProID"] = ddlProduct.SelectedValue.ToString();
                                clearinfo();
                                FillGrdLabelInfo();
                                #region Comments
                                //if (myTable.Rows[k]["Pro_ID"].ToString() == ddlProduct.SelectedValue.ToString())
                                //{
                                //    lblProDetailsMsg.Text = "Product Details Already Exist!";
                                //    lblProDetailsMsg.ForeColor = System.Drawing.Color.Red;
                                //}
                                //else
                                //{
                                //    AddPrintLabelInfo("", ddlProduct.SelectedValue.ToString(), ddlProduct.SelectedItem.Text.ToString(), ddlLabel.SelectedValue.ToString(), ddlLabel.SelectedItem.Text.ToString(), txtSeriesFrom.Text.Trim().ToString(), txtSeriesTo.Text.Trim().ToString(), (DataTable)Session["LBLInfo"]);
                                //    clearinfo();
                                //    FillGrdLabelInfo();
                                //}
                                #endregion
                            }
                            else
                                break;
                        }
                    }
                    else
                    {
                        string[] Arr = txtSeries_Initial.Text.Trim().Replace("'", "''").ToString().Split('-');
                        if (Arr[1] != "")
                        {
                            AddPrintLabelInfo("", ddlProduct.SelectedValue.ToString(), ddlProduct.SelectedItem.Text.ToString(), ddlLabel.SelectedValue.ToString(), ddlLabel.SelectedItem.Text.ToString(), txtSeries_Initial.Text.Trim().Replace("'", "''") + "-" + txtSeriesFrom.Text.Trim().Replace("'", "''").ToString(), txtSeries_Initial.Text.Trim().Replace("'", "''") + "-" + txtSeriesTo.Text.Trim().Replace("'", "''").ToString(), LblCountQty.Text.ToString(), (DataTable)Session["LBLInfo"]);
                            LogManager.WriteCourierDispatch("Add rows to session (DataTable myTable)");
                            LogManager.WriteCourierDispatch("(DataTable)Session[LBLInfo] valuse - " + ((DataTable)Session["LBLInfo"]).Rows.Count.ToString());
                            LogManager.WriteCourierDispatch("------------------------------");
                            Session["ProID"] = ddlProduct.SelectedValue.ToString();
                            clearinfo();
                            FillGrdLabelInfo();
                        }
                    }
                }
                else
                {
                    lblProDetailsMsg.Text = "Please select valid series or valid product!";
                    lblProDetailsMsg.ForeColor = System.Drawing.Color.Red;
                    ModalPopupExtenderNewDesign.Show();
                    return;
                }
            }
            else if (btnAddPro.ImageUrl == "~/Content/images/add_Update.png")
            {
                hdnFieldUpdate.Value = "Update";
                if (ChkSeries())
                {
                    int index = Convert.ToInt32(lblUpFlTblId.Text);
                    ((DataTable)Session["LBLInfo"]).Rows[index]["Pro_ID"] = ddlProduct.SelectedValue.ToString();
                    ((DataTable)Session["LBLInfo"]).Rows[index]["Pro_Name"] = ddlProduct.SelectedItem.Text;
                    ((DataTable)Session["LBLInfo"]).Rows[index]["Label_Code"] = ddlLabel.SelectedValue.ToString();
                    ((DataTable)Session["LBLInfo"]).Rows[index]["Label_Name"] = ddlLabel.SelectedItem.Text;
                    ((DataTable)Session["LBLInfo"]).Rows[index]["Series_From"] = txtSeries_Initial.Text + "-" + txtSeriesFrom.Text;
                    ((DataTable)Session["LBLInfo"]).Rows[index]["Series_To"] = txtSeries_Initial.Text + "-" + txtSeriesTo.Text;
                    ((DataTable)Session["LBLInfo"]).Rows[index]["Qty"] = LblCountQty.Text;
                    btnAddPro.ImageUrl = "~/Content/images/add_new.png";
                    clearinfo();
                    FillGrdLabelInfo();
                }
                else
                {
                    lblProDetailsMsg.Text = "Please select valid series or valid product!";
                    lblProDetailsMsg.ForeColor = System.Drawing.Color.Red;
                    ModalPopupExtenderNewDesign.Show();
                    return;
                }
            }
        }
        else
        {
            lblProDetailsMsg.Text = "Please select valid series or valid product!";
            lblProDetailsMsg.ForeColor = System.Drawing.Color.Red;
            ModalPopupExtenderNewDesign.Show();
            return;
        }
        ModalPopupExtenderNewDesign.Show();
    }
    protected void btnResetPro_Click(object sender, ImageClickEventArgs e)
    {
        clearinfo();
        ModalPopupExtenderNewDesign.Show(); ;
    }
    protected void BtnSearch_Click(object sender, ImageClickEventArgs e)
    {
        FillGrdMain();
    }
    protected void BtnRefesh_Click(object sender, ImageClickEventArgs e)
    {
        txtSearchName.Text = string.Empty;
        FillGrdMain();
    }
    private void FillGrdLabelInfo()
    {
        DataTable dt = (DataTable)Session["LBLInfo"];
        LogManager.WriteCourierDispatch("FillGrdLabelInfo()");
        LogManager.WriteCourierDispatch("(DataTable)Session[LBLInfo] valuse - " + ((DataTable)Session["LBLInfo"]).Rows.Count.ToString());
        LogManager.WriteCourierDispatch("------------------------------");
        GrdProductPrintLablelDet.DataSource = dt;
        GrdProductPrintLablelDet.DataBind();
    }
    private void clearinfo()
    {
        //ddlProduct.SelectedIndex = 0;
        //ddlLabel.SelectedIndex = 0;
        txtSeriesFrom.Text = string.Empty;
        txtSeriesTo.Text = string.Empty;
        lblProDetailsMsg.Text = string.Empty;
        if (txtSeries_Initial.Text != "")
        {
            string[] Arr = txtSeries_Initial.Text.ToString().Split('-');
            txtSeries_Initial.Text = Arr[0].ToString() + "-";
        }
        else
            txtSeries_Initial.Text = string.Empty;
        lblUpFlTblId.Text = string.Empty;
        LblCountQty.Text = string.Empty;
    }
    private DataTable SaveLabelInfo(DataTable dt)
    {
        LogManager.WriteExe("SaveLabelIngo Start");
        SqlConnection conn = dtcon.CreateConnection();
        LogManager.WriteCourierDispatch("SaveLabelInfo()");
        LogManager.WriteCourierDispatch("(DataTable)Session[LBLInfo] valuse - " + ((DataTable)Session["LBLInfo"]).Rows.Count.ToString());
        LogManager.WriteCourierDispatch("(DataTable)Session[LBLInfo] valuse - " + dt.Rows.Count.ToString());
        LogManager.WriteCourierDispatch("------------------------------");
        if (dt.Rows.Count > 0)
        {
            LogManager.WriteExe("SaveLabelIngo Start 1");
            string sr1 = "SELECT Courier_Disp_ID, Pro_ID,Label_Code, Label_Name, Series_From, Series_To,Qty FROM Courier_Disp_ProInfo with (nolock)";
            LogManager.WriteExe("SaveLabelIngo Start 2");
            SqlCommand cmd = new SqlCommand(sr1, conn);
            LogManager.WriteExe("SaveLabelIngo Start 3");
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            LogManager.WriteExe("SaveLabelIngo Start 4");
            SqlCommandBuilder cb = new SqlCommandBuilder(ad);
            LogManager.WriteExe("SaveLabelIngo Start 5");
            ad.Update(((DataTable)Session["LBLInfo"]));
            LogManager.WriteExe("SaveLabelIngo Start 6");
            dt.AcceptChanges();
            LogManager.WriteExe("SaveLabelIngo Start 7");
        }
        //if (((DataTable)Session["LBLInfo"]).Rows.Count > 0)
        //{
        //    LogManager.WriteExe("SaveLabelIngo Start 1");
        //    string sr1 = "SELECT Courier_Disp_ID, Pro_ID,Label_Code, Label_Name, Series_From, Series_To,Qty FROM Courier_Disp_ProInfo with (nolock)";
        //    LogManager.WriteExe("SaveLabelIngo Start 2");
        //    SqlCommand cmd = new SqlCommand(sr1, conn);
        //    LogManager.WriteExe("SaveLabelIngo Start 3");
        //    SqlDataAdapter ad = new SqlDataAdapter(cmd);
        //    LogManager.WriteExe("SaveLabelIngo Start 4");
        //    SqlCommandBuilder cb = new SqlCommandBuilder(ad);
        //    LogManager.WriteExe("SaveLabelIngo Start 5");
        //    ad.Update(((DataTable)Session["LBLInfo"]));
        //    LogManager.WriteExe("SaveLabelIngo Start 6");
        //    ((DataTable)Session["LBLInfo"]).AcceptChanges();
        //    LogManager.WriteExe("SaveLabelIngo Start 7");
        //}
        LogManager.WriteExe("SaveLabelIngo END");
        return dt;
    }
    protected void chkchange_CheckedChanged(object sender, EventArgs e)
    {
        if (!chkchange.Checked)
        {
            string TrackingNo = function9420.GetTrackingId("Tracking No");
            txtTrackingNo.Text = TrackingNo;
        }
        else
            txtTrackingNo.Text = string.Empty;
        ModalPopupExtenderNewDesign.Show();
    }
    protected void btnCourierSubmit_Click(object sender, EventArgs e)
    {

        LogManager.WriteCourierDispatch("arb - btnCourierSubmi " + Convert.ToString(((DataTable)Session["LBLInfo"]).Rows.Count));
        LogManager.WriteCourierDispatch("arb - btnCourierSubmi - LBLInfo2 " + Convert.ToString(((DataTable)Session["LBLInfo2"]).Rows.Count));
        if (Session["LBLInfo2"] != null)
            Session["LBLInfo"] = (DataTable)Session["LBLInfo2"];
        // LogManager.WriteExe("dispatch  start");
        string script = "";
        if ((LblCountQty.Text != "") || (txtSeriesFrom.Text != "") || (txtSeriesTo.Text != ""))
        {
            //   LogManager.WriteExe("validation failed");
            DivNewMsg.Visible = true;
            DivNewMsg.Attributes.Add("class", "alert_boxes_pink");
            lblpopmsg.Text = "Please add Product information in Courier !  <span style='color:green;'>Click For add Details : </span><img style='position: fixed;' alt='' src='~/Content/images/add_new.png' />";
            ModalPopupExtenderNewDesign.Show();
            script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            return;
        }
        else
        {
            lblpopmsg.Text = string.Empty;
        }
        //LogManager.WriteExe("validation done");
        Object9420 Reg = new Object9420();
        Reg.Courier_Disp_ID = function9420.GetCourierDispatchID();
        Reg.Comp_ID = DDLCompany.SelectedValue.ToString();
        // shweta
        Reg.Pro_ID = ddlProduct.SelectedValue.ToString();
        // end
        Reg.Courier_ID = DDLCourierCompany.SelectedValue.ToString();
        Reg.Courier_Name = DDLCourierCompany.SelectedItem.Text;
        Reg.Tracking_No = txtTrackingNo.Text.Trim().Replace("'", "''");
        Reg.Dispatch_Date = Convert.ToDateTime(Convert.ToDateTime(txtDispatchDate.Text).ToString("yyyy/MM/dd hh:mm:ss tt"));
        Reg.Expected_Date = Convert.ToDateTime(Convert.ToDateTime(txtExpectedDate.Text).ToString("yyyy/MM/dd hh:mm:ss tt"));
        //Reg.Dispatch_Pin = txtDispPin.Text.Trim().Replace("'", "''");
        Reg.Dispatch_Location = txtDispLocation.Text.Trim().Replace("'", "''");
        Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        if (btnCourierSubmit.Text == "Save")
        {
            LogManager.WriteExe("save started");
            Reg.DML = "I";
            DataTable dt = (DataTable)Session["LBLInfo"];
            for (int p = 0; p < dt.Rows.Count; p++)
            {
                dt.Rows[p]["Courier_Disp_ID"] = Reg.Courier_Disp_ID;
            }
            DataTable dt4 = SaveLabelInfo(dt);
            Session["LBLInfo"] = dt4;
            LogManager.WriteCourierDispatch("arb " + Convert.ToString(((DataTable)Session["LBLInfo"]).Rows.Count));
            LogManager.WriteExe("arb " + Convert.ToString(((DataTable)Session["LBLInfo"]).Rows.Count));
            //     lblTestSession.Text = "Session value 1- " + Convert.ToString(((DataTable)Session["LBLInfo"]).Rows.Count);
            if (((DataTable)Session["LBLInfo"]).Rows.Count > 0)
            {
                // LogManager.WriteExe("after labelInfo");

                Reg.Pro_ID = Session["ProID"].ToString();
                function9420.CourierDispatchMaster(Reg);
                lblCourierId.Text = Reg.Courier_Disp_ID;
                //  LogManager.WriteExe("I started");
                // belwo "UpdateDispatchFlagSeries("I")" is replaced by new function UpdateDispatchFlagSeries_New  - by shweta
                //UpdateDispatchFlagSeries("I"); // in m_code table

	if (Reg.Comp_ID == "Comp-1693")
                    UpdateDispatchFlagSeries_CompId("I"); // in m_code_CFL table
                else
                UpdateDispatchFlagSeries_New("I"); // in m_code table
                LogManager.WriteExe("I update ended");
                //invoice section start 
                try
                {
                    LogManager.WriteExe("invoice section started");
                    //  Reg.Path = Server.MapPath("../Reports") + "\\InvoiceReports.rpt";
                    //  Reg.FolderPath = Server.MapPath("../Data/Bill");

                    //PDFCLass.GeneratePDF(Reg);
                    LogManager.WriteExe("invoice section passed");
                }
                catch (Exception ex)
                {
                    LogManager.WriteExe("Error in Invoice while dispatch, Details: " + ex.Message.ToString());
                    //Response.Write("Error in Invoice while dispatch, Details: "+ ex.Message.ToString());
                }

                //invoice end

            
                LogManager.WriteExe("invoice section passed 11");
                function9420.CreateLabelInvoice(Reg);
                PDFCLass.GeneratePDF(Reg);
                Prop_PrintRecp = ProjectSession.absoluteSiteBrowseUrl + "/Admin/Bill/Invoice/" + Reg.Invoice_Date.ToString("dd-MM-yyyy") + "/" + Reg.Invoice_ID + ".pdf";
                //HtmlAnchor MyLnk = (HtmlAnchor)this.Master.FindControl("ctl00_ContentPlaceHolder1_btnYesActivation1");
                //MyLnk.HRef = ProjectSession.absoluteSiteBrowseUrl + "/Admin/Bill/Invoice/" + Reg.Invoice_Date.ToString("dd-MM-yyyy") + "/" + Reg.Invoice_ID + ".pdf";
                LogManager.WriteExe("invoice section passed11 end");
            }
            else
            {
                lblTestSession.Text = lblTestSession.Text + " And Session value 2 - " + Convert.ToString(((DataTable)Session["LBLInfo"]).Rows.Count);
                LogManager.WriteExe("invoice section passed else part");
                DivNewMsg.Visible = true;
                DivNewMsg.Attributes.Add("class", "alert_boxes_pink");
                lblpopmsg.Text = "Please add Product information in Courier <span style='color:blue;' >" + Reg.Courier_Name + "</span> !";
                ModalPopupExtenderNewDesign.Show();
                script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
            lblCourierId.Text = string.Empty;
            LogManager.WriteCourierDispatch("Save click");
            LogManager.WriteCourierDispatch("((DataTable)Session[LBLInfo]  value - " + Convert.ToString(((DataTable)Session["LBLInfo"]).Rows.Count));
            LogManager.WriteCourierDispatch("-----------------------------");
            ((DataTable)Session["LBLInfo"]).Rows.Clear();
            //  PDFCLass.GeneratePDF(Reg);
            FillGrdLabelInfo();
            //========================Manufacture mail ==================================

            try
            {
                LogManager.WriteExe("mail section started");
                DataSet dsMan = SQL_DB.ExecuteDataSet("SELECT Contact_Person, [Comp_Name],[Comp_Email] FROM [Comp_Reg] where [Comp_ID] = '" + Reg.Comp_ID + "'");
                if (dsMan.Tables[0].Rows.Count > 0)
                {

                    DataSet dsdet = function9420.GetCourierDispLabelInfoID(Reg);

                    #region MailBody
                    string InvoiceLink = "";
                    InvoiceLink = ProjectSession.absoluteSiteBrowseUrl + "/Admin/Bill/Invoice/" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("dd-MM-yyyy") + "/" + Reg.Invoice_ID + ".pdf";
                    string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                       " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/content/images/logo.png'' alt='logo' /></div>" +
                       " <hr style='border:1px solid #2587D5;'/>" +
                       " <div class='w_frame'>" +
                       " <p>" +
                       " <div class='w_detail'>" +
                       " <span>Dear <em><strong>" + dsMan.Tables[0].Rows[0]["Contact_Person"].ToString() + ",</strong></em></span><br />" +
                       " <br />" +
                       " <span>Your order has been dispatched successfully, on " + Convert.ToDateTime(Reg.Dispatch_Date).ToString("MMM dd,yyyy") + "</span>" +
                       " <br />Details are as follows:- <br />" +
                       " <table border='0' cellspacing='2'>";
                    if (ExcelQry == "")
                    {
                        MailBody += " <tr>" +
                        " <td width='90' align='right'><strong>Courier Name :&nbsp; </strong></td>" +
                        " <td width='282'><a href='#'>" + Reg.Courier_Name + "</a></td>" +
                        " </tr>";
                    }
                    MailBody += "<tr><td align='right' valign='top'><strong>Courier Tracking No. :&nbsp;</strong></td>" +
                       " <td>" + Reg.Tracking_No + "</td>" +
                       " </tr>" +
                       " <tr><td colspan='2' >";

                    if (dsdet.Tables[0].Rows.Count > 0)
                    {
                        MailBody += "<table border='0' cellspacing='2'>" +
                            "<tr style='background-color:Blue; color:White;'>" +
                            " <td align='right' valign='top'><strong>Product Name&nbsp;</strong></td> " +
                            " <td align='right' valign='top'><strong>Label Type(Size)&nbsp;</strong></td> " +
                            " <td align='right' valign='top'><strong>Series From&nbsp;</strong></td> " +
                            " <td align='right' valign='top'><strong>Series TO &nbsp;</strong></td> " +
                            " <td align='right' valign='top'><strong>Quantity &nbsp;</strong></td> " +
                        "</tr>";
                        for (int t = 0; t < dsdet.Tables[0].Rows.Count; t++)
                        {
                            MailBody += " <tr>" +
                                 " <td>" + dsdet.Tables[0].Rows[t]["Pro_Name"].ToString() + "</td>" +
                                 " <td>" + dsdet.Tables[0].Rows[t]["Label_Name"].ToString() + "</td>" +
                                 " <td>" + dsdet.Tables[0].Rows[t]["Series_From"].ToString() + "</td>" +
                                 " <td>" + dsdet.Tables[0].Rows[t]["Series_To"].ToString() + "</td>" +
                                 " <td align='center'>" + dsdet.Tables[0].Rows[t]["Qty"].ToString() + "</td>" +
                                 " </tr>";

                        }

                        MailBody += "</table>";
                    }
                    MailBody += "</td> </tr>" +
                      "<tr>" +
                    " <td align='right' valign='top'><strong>Expected delivery date :&nbsp;</strong></td>" +
                    " <td>" + Convert.ToDateTime(Reg.Expected_Date).ToString("MMM dd, yyyy") + "</td>" +
                    " </tr>" +
                   " <tr><td align='right' valign='top'><strong>Download Invoice &nbsp;</strong></td>" +
                   " <td><a href='" + InvoiceLink + "' target='_blank' >Invoice</a></td>" +
                   " </tr>" +
                    " </table>" +
                    " <p>" +
                    " <div class='w_detail'>" +
                    " Assuring you  of  our best services always.<br />" +
                    " Thank you,<br /><br />" +
                    " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                    "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                    " <strong>Toll Free: 1800 183 9420</strong>" +
                    " </div>" +
                    " </p>" +
                    " </div>" +
                    " </p>" +
                    " </div> " +
                    " </div> ";
                    #endregion

                    LogManager.WriteExe("mail template created");
                    DataSet dsMl = function9420.FetchMailDetail("dispatch");
                    LogManager.WriteExe("mail detailed fetched");
                    if (dsMl.Tables[0].Rows.Count > 0)
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(),
                            dsMl.Tables[0].Rows[0]["MPassword"].ToString(), dsMan.Tables[0].Rows[0]["Comp_Email"].ToString(), MailBody, "Order Dispatch");
                    LogManager.WriteExe("mail sent");

                }
            }
            catch (Exception ex)
            {
                Response.Write("Error in mail sending  while dispatch, Details: " + ex.Message.ToString());
            }
            //===========================================================================
            LabelAlertheader.Text = "Alert";
            LabelAlertText.Text = "Order has been sent <span style='color:blue;' >" + Reg.Courier_Name + "</span> courier company successfully.";
            btnYesActivation.Text = "Print Receipt";
            btnYesActivation.Visible = false;
            btnNoActivation.Visible = true;
            //DivNewMsg.Visible = true;
            //DivNewMsg.Attributes.Add("class", "alert_boxes_green");
            //lblpopmsg.Text = "Order has been sent ''" + Reg.Courier_Name + "'' courier company successfully.";

            // mail code is not hear(*) mailbody not confirm

            ModalPopupExtenderNewDesign.Show();
            ModalPopupExtenderAlert.Show();


            //   HtmlAnchor MyLnk = (HtmlAnchor)this.Master.FindControl("ctl00_ContentPlaceHolder1_btnYesActivation1");
            //   MyLnk.HRef = ProjectSession.absoluteSiteBrowseUrl + "/Admin/Bill/Invoice/" + Reg.Invoice_Date.ToString("dd-MM-yyyy") + "/" + Reg.Invoice_ID + ".pdf";
            //script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        else
        {
            Reg.Courier_Disp_ID = lblCourierId.Text;
            UpdateDispatchFlagSeries("U");
            function9420.DeleteCourierProDispInfo(Reg);
            Reg.DML = "U";
            if (((DataTable)Session["LBLInfo"]).Rows.Count > 0)
            {
                DataTable dt = (DataTable)Session["LBLInfo"];
                for (int p = 0; p < dt.Rows.Count; p++)
                {
                    dt.Rows[p]["Courier_Disp_ID"] = Reg.Courier_Disp_ID;
                }
                SaveLabelInfo(dt);
                function9420.CourierDispatchMaster(Reg);
                UpdateDispatchFlagSeries("I");
            }
            else
            {
                DivNewMsg.Visible = true;
                DivNewMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                lblmsgHeader.Text = "Please add Product information in Courier <span style='color:blue;' >" + Reg.Courier_Name + "</span> !";
                script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
            ((DataTable)Session["LBLInfo"]).Rows.Clear();
            ((DataTable)Session["LBLInfoEdit"]).Rows.Clear();
            FillGrdLabelInfo();
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
            lblmsgHeader.Text = "Courier <span style='color:blue;' >" + Reg.Courier_Name + "</span> has beeb updated successfully.";
            script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        if (ExcelQry != "")
            download(ExcelQry, ddlProduct.SelectedValue, Reg.Comp_ID, Reg.Courier_Disp_ID);//"VIR"+VarLabelRequestID
        TxtClear();
        FillGrdMain();
    }
    protected void ddlRows_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillGrdMain();
    }
    private void download(string qry, string Pro_ID, string Comp_ID, string LBLREQID)
    {
        Object9420 RegExccel = new Object9420();
        RegExccel.Pro_ID = Pro_ID;
        RegExccel.Comp_ID = Comp_ID;
        RegExccel.LabelRequestID = LBLREQID;
        string path = Server.MapPath("../Data");
        path = path + "\\" + "Excel";
        DataProvider.Utility.CreateDirectory(path);
        string DirectoryName = path + "\\" + DataProvider.LocalDateTime.Now.ToString("dd-MM-yyyy");
        DataProvider.Utility.CreateDirectory(DirectoryName);
        string DirectoryNameN = DirectoryName + "\\" + "Licence";
        DataProvider.Utility.CreateDirectory(DirectoryNameN);
        DataProvider.Utility.DeleteFiles(DirectoryNameN + "\\" + RegExccel.Comp_ID.Substring(5, 4) + "_" + RegExccel.Pro_ID + ".xls");
        DataSet ds_rpt = new DataSet(); DataSet ds = new DataSet(); DataTable dt = new DataTable();
        SQL_DB.GetDA(qry).Fill(ds, "1");
        Int32 countrows = ds.Tables[0].Rows.Count;
        int cntloop = 0;
        int rem = 0;
        if (countrows > 50000)
        {
            cntloop = countrows / 50000;
            rem = countrows - (cntloop * 50000);
        }
        else
        {
            rem = countrows;
        }
        int i = 0, j = 0, k = 0, l = 0;
        if (cntloop > 0)
        {
            for (i = 0; i < cntloop; i++)
            {
                dt = DataProvider.Utility.CreateDataTableExcel();
                for (l = 0, j = k; l < 50000; l++, j++)
                {
                    dt = DataProvider.Utility.AddNewRowsExcel(dt, Convert.ToInt32(ds.Tables[0].Rows[j]["Code1"]), Convert.ToInt32(ds.Tables[0].Rows[j]["Code2"]), Convert.ToInt32(ds.Tables[0].Rows[j]["SNO"]), ds.Tables[0].Rows[j]["Searies_Name"].ToString());
                }
                k = j;
                DataProvider.Utility.CreateExcel(dt, DirectoryNameN, RegExccel.Comp_ID, RegExccel.Pro_ID, i, RegExccel.LabelRequestID);
            }
        }
        if (rem > 0)
        {
            dt = DataProvider.Utility.CreateDataTableExcel();
            for (l = 0, j = k; l < rem; j++, l++)
            {
                dt = DataProvider.Utility.AddNewRowsExcel(dt, Convert.ToInt32(ds.Tables[0].Rows[j]["Code1"]), Convert.ToInt32(ds.Tables[0].Rows[j]["Code2"]), Convert.ToInt32(ds.Tables[0].Rows[j]["SNO"]), ds.Tables[0].Rows[j]["Searies_Name"].ToString());
            }
            DataProvider.Utility.CreateExcel(dt, DirectoryNameN, RegExccel.Comp_ID, RegExccel.Pro_ID, i, RegExccel.LabelRequestID);
        }

    }
    private void FillGrdMain()
    {
        Object9420 Reg = new Object9420();
        Reg.Courier_Disp_ID = "";
        Reg.Comp_Name = txtSerCompName.Text.Trim().Replace("'", "''");
        Reg.Courier_Name = txtSearchName.Text.Trim().Replace("'", "''");
        DataSet ds = function9420.FillGrdMainDispatchData(Reg);
        if (Convert.ToInt32(ddlRows.SelectedValue) > 1000)
        {
            if (ds.Tables[0].Rows.Count > 0)
                GrdCourierDispatch.PageSize = ds.Tables[0].Rows.Count;
        }
        else
            GrdCourierDispatch.PageSize = Convert.ToInt32(ddlRows.SelectedValue.Trim());
        lblcount.Text = ds.Tables[0].Rows.Count.ToString();
        if (ds.Tables[0].Rows.Count > 0)
            GrdCourierDispatch.DataSource = ds.Tables[0];
        GrdCourierDispatch.DataBind();
        lblcount.Text = ds.Tables[0].Rows.Count.ToString();
        FillProductDetails();
    }
    private void BtnDownloadLicence(string DispId)
    {
        string b = "";
        DataTable dt = SQL_DB.ExecuteDataTable("SELECT Pro_ID,Courier_Disp_ID,Comp_ID,Entry_Date FROM Courier_Dispatch_Master WHERE Courier_Disp_ID='" + DispId + "'");
        if (dt.Rows.Count > 0)
        {
            b = dt.Rows[0]["Pro_ID"].ToString() + "*" + Convert.ToDateTime(dt.Rows[0]["Entry_Date"]).ToString("dd-MM-yyyy") + "*" + dt.Rows[0]["Courier_Disp_ID"].ToString();
        }

        //ZipCompressor.CreateFolderToZipDownloadLic(Server.MapPath("Excel"), b); // this code for is Microsoft lib
        //Compressor.CreateFolderToZipDownloadNewlic(Server.MapPath("Excel"), b); // this code self is Microsoft lib
        //*************** Comments ddl not support ***************//
        string Paths = Server.MapPath("../Data");
        Paths = Paths + "\\Excel";
        ZipCreate.MyZipClass.ZipLicCreate(Paths, b);   // this code self is Ionic.dll lib

        string path = ""; string FileName = "";
        string[] Check12 = b.ToString().Split(',');
        if (Check12.Length > 1)
            FileName = "ExcelSheets.zip";
        else
        {
            string[] b12 = Check12[0].Split('*');
            FileName = b12[0].ToString() + "-" + b12[2].ToString() + ".zip";
        }
        path = Paths + "\\" + FileName;

        FileInfo myfile = new FileInfo(path);

        if (myfile.Exists)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ClearContent();
            Response.Clear();
            Response.ContentType = "application/zip";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + FileName);// + filename);
            Response.TransmitFile(myfile.FullName);
            Response.End();

        }

        //BigpopMsg.Visible = true;
        //BigpopMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        lblmsg.Text = "File downloaded successfully !";

        //newMsg.Visible = true;
        //LabelAlertheader.Text = "Alert";
        //LabelAlertText.Text = "Are you sure to dalete  <span style='color:blue;' >" + Reg.Courier_Name + "</span>  Courier Dispatch Order ?";
        //btnYesActivation.Text = "Yes";
        //btnYesActivation.Visible = true;
        //btnNoActivation.Visible = true;
        //ModalPopupExtenderAlert.Show();
        //string script1 = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script1, true);
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
    protected void btnCourierReset_Click(object sender, EventArgs e)
    {
        TxtClear(); DivNewMsg.Visible = false;
        newMsg.Visible = false; ModalPopupExtenderNewDesign.Show();
    }
    protected void GrdCourierDispatch_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdCourierDispatch.PageIndex = e.NewPageIndex;
        FillGrdMain();
    }
    protected void GrdProductPrintLablelDet_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        DataTable dt = (DataTable)Session["LBLInfo"];
        LogManager.WriteCourierDispatch("GrdProductPrintLablelDet_RowCommand");
        LogManager.WriteCourierDispatch("((DataTable)Session[LBLInfo]  value - " + Convert.ToString(((DataTable)Session["LBLInfo"]).Rows.Count));
        LogManager.WriteCourierDispatch("-----------------------------");
        int index = Convert.ToInt32(e.CommandArgument.ToString());
        lblUpFlTblId.Text = index.ToString();
        if (e.CommandName.ToString() == "DeleteProDetails")
        {
            ((DataTable)Session["LBLInfo"]).Rows[index].Delete();
            clearinfo();
            FillGrdLabelInfo();
            btnAddPro.ImageUrl = "~/Content/images/add_new.png";
        }
        else if (e.CommandName.ToString() == "EditProDetails")
        {
            fillProduct("E");
            if (((DataTable)Session["LBLInfo"]).Rows.Count > 0)
            {
                ddlProduct.SelectedValue = ((DataTable)Session["LBLInfo"]).Rows[index]["Pro_ID"].ToString();
                DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT Label_Code, Label_Name + '( ' +Label_Size+ ') ' as Label_Name FROM  M_Label WHERE Label_Code IN (SELECT [Label_Code]  FROM Pro_Reg where [Comp_ID] = '" + DDLCompany.SelectedValue.ToString() + "') order by [Label_Code]");
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    ddlLabel.DataSource = ds1.Tables[0];
                    ddlLabel.DataTextField = "Label_Name";
                    ddlLabel.DataValueField = "Label_Code";
                    ddlLabel.DataBind();
                    ddlLabel.Items.Insert(0, "--Select--");
                    ddlLabel.SelectedIndex = 0;
                }
                else
                {
                    ddlLabel.Items.Clear();
                    ddlLabel.Items.Insert(0, "--Select--");
                    ddlLabel.SelectedIndex = 0;
                }
                string[] Arr = ((DataTable)Session["LBLInfo"]).Rows[index]["Series_From"].ToString().Split('-');
                string[] ArrNew = ((DataTable)Session["LBLInfo"]).Rows[index]["Series_To"].ToString().Split('-');
                ddlLabel.SelectedValue = ((DataTable)Session["LBLInfo"]).Rows[index]["Label_Code"].ToString();
                txtSeries_Initial.Text = Arr[0] + "-" + Arr[1];//((DataTable)Session["LBLInfo"]).Rows[index]["Series_From"].ToString().Substring(0, 7);
                txtSeriesFrom.Text = Arr[2];//((DataTable)Session["LBLInfo"]).Rows[index]["Series_From"].ToString().Substring(8, 3);
                txtSeriesTo.Text = ArrNew[2];//((DataTable)Session["LBLInfo"]).Rows[index]["Series_To"].ToString().Substring(8, 3);
                LblCountQty.Text = ((DataTable)Session["LBLInfo"]).Rows[index]["Qty"].ToString();
                btnAddPro.ImageUrl = "~/Content/images/add_Update.png";
            }
            FillGrdLabelInfo();
        }
        ModalPopupExtenderNewDesign.Show();
    }
    protected void GrdCourierDispatch_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Object9420 Reg = new Object9420(); newMsg.Visible = false; DivNewMsg.Visible = false;
        lblCourierId.Text = e.CommandArgument.ToString();
        Reg.Courier_Disp_ID = lblCourierId.Text;
        Reg.Courier_Name = "";
        Reg.Comp_Name = "";
        function9420.GetCourierDispInfo(Reg);
        if (e.CommandName == "CourierEdit")
        {
            LogManager.WriteCourierDispatch("GrdCourierDispatch_RowCommand >> e.CommandName == CourierEdit");
            LogManager.WriteCourierDispatch("((DataTable)Session[LBLInfo]  value - " + Convert.ToString(((DataTable)Session["LBLInfo"]).Rows.Count));
            LogManager.WriteCourierDispatch("-----------------------------");
            ((DataTable)Session["LBLInfo"]).Rows.Clear();
            FillCompany();
            FillCourierCompany();
            DDLCompany.SelectedValue = Reg.Comp_ID;
            DDLCourierCompany.SelectedValue = Reg.Courier_ID;
            txtTrackingNo.Text = Reg.Tracking_No;
            txtDispatchDate.Text = Convert.ToDateTime(Reg.Dispatch_Date).ToString("dd/MM/yyyy");
            txtExpectedDate.Text = Convert.ToDateTime(Reg.Expected_Date).ToString("dd/MM/yyyy");
            txtDispLocation.Text = Reg.Dispatch_Location;
            //Session["LBLInfoEdit"] = createdata
            FillUpdateProDispInfo(Reg);
            FillGrdLabelInfo();
            fillProduct("E");
            btnCourierSubmit.Text = "Update";
            ModalPopupExtenderNewDesign.Show();
        }
        else if (e.CommandName == "CourierDelete")
        {
            newMsg.Visible = true;
            LabelAlertheader.Text = "Alert";
            LabelAlertText.Text = "Are you sure to dalete  <span style='color:blue;' >" + Reg.Courier_Name + "</span>  Courier Dispatch Order ?";
            btnYesActivation.Text = "Yes";
            btnYesActivation.Visible = true;
            btnNoActivation.Visible = true;
            ModalPopupExtenderAlert.Show();
            //string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        else if (e.CommandName == "DownloadExcel")
        {
            BtnDownloadLicence(lblCourierId.Text);
        }
    }
    private void FillUpdateProDispInfo(Object9420 Reg)
    {
        DataSet ds = function9420.GetCourierProDispInfo(Reg);
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            AddPrintLabelInfo("", ds.Tables[0].Rows[i]["Pro_ID"].ToString(), ds.Tables[0].Rows[i]["Pro_Name"].ToString(), ds.Tables[0].Rows[i]["Label_Code"].ToString(), ds.Tables[0].Rows[i]["Label_Name"].ToString(), ds.Tables[0].Rows[i]["Series_From"].ToString(), ds.Tables[0].Rows[i]["Series_To"].ToString(), ds.Tables[0].Rows[i]["Qty"].ToString(), (DataTable)Session["LBLInfo"]);
            AddPrintLabelInfo("", ds.Tables[0].Rows[i]["Pro_ID"].ToString(), ds.Tables[0].Rows[i]["Pro_Name"].ToString(), ds.Tables[0].Rows[i]["Label_Code"].ToString(), ds.Tables[0].Rows[i]["Label_Name"].ToString(), ds.Tables[0].Rows[i]["Series_From"].ToString(), ds.Tables[0].Rows[i]["Series_To"].ToString(), ds.Tables[0].Rows[i]["Qty"].ToString(), (DataTable)Session["LBLInfoEdit"]);
        }
        LogManager.WriteCourierDispatch("FillUpdateProDispInfo");
        LogManager.WriteCourierDispatch("((DataTable)Session[LBLInfo]  value - " + Convert.ToString(((DataTable)Session["LBLInfo"]).Rows.Count));
        LogManager.WriteCourierDispatch("-----------------------------");
    }
    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        LogManager.WriteCourierDispatch("ddlProduct_SelectedIndexChanged - start");
        LogManager.WriteCourierDispatch("((DataTable)Session[LBLInfo]  value - " + Convert.ToString(((DataTable)Session["LBLInfo"]).Rows.Count));
        LogManager.WriteCourierDispatch("-----------------------------");
        if (ddlProduct.SelectedIndex > 0)
        {
            DataTable dt = (DataTable)Session["LBLInfo"];
            if (dt.Rows.Count > 0)
            {
                if (ddlProduct.SelectedValue.ToString() != Session["ProID"].ToString())
                {
                    ddlProduct.SelectedValue = Session["ProID"].ToString();
                    LabelAlertheader.Text = "Alert";
                    LabelAlertText.Text = "Order dispatch Single product only one time.";
                    LabelAlertText.ForeColor = System.Drawing.Color.Red;
                    btnYesActivation.Visible = false;
                    btnNoActivation.Visible = false;
                    ModalPopupExtenderNewDesign.Show();
                    ModalPopupExtenderAlert.Show();
                }
            }
            //DataSet dds = SQL_DB.ExecuteDataSet("SELECT * FROM (SELECT (SELECT Label_Code FROM M_Label_Request WHERE Tracking_No = M_Code.LabelRequestId) AS Label_Code ,(SELECT   Label_Name + ' ( '+ Label_Size +' ) ' as Label_Name FROM M_Label WHERE Label_Code = (SELECT Label_Code FROM M_Label_Request WHERE Tracking_No = M_Code.LabelRequestId)) as Label_Name FROM M_Code WHERE Pro_ID = '" + ddlProduct.SelectedValue.ToString() + "' AND DispatchFlag IS NULL AND (ScrapeFlag IS NULL OR ScrapeFlag = 0)  GROUP BY LabelRequestId,Pro_ID ) Reg GROUP BY Label_Name,Label_Code");
            DataSet dds = ExecuteNonQueryAndDatatable.getM_Label_Request(ddlProduct.SelectedValue.Trim());
            if (dds.Tables[0].Rows.Count == 1)
            {
                ddlLabel.Enabled = false;
                DataProvider.MyUtilities.FillDDLInsertZeroIndexString(dds, "Label_Code", "Label_Name", ddlLabel, "--Select--");
                ddlLabel.SelectedIndex = 0;
                ddlLabel.SelectedValue = dds.Tables[0].Rows[1]["Label_Code"].ToString();
                txtSeries_Initial.Text = ddlProduct.SelectedValue.Trim() + "-"; txtSeriesFrom.Text = string.Empty; txtSeriesTo.Text = string.Empty; LblCountQty.Text = string.Empty;
                if (dds.Tables[0].Rows[1]["Label_Code"].ToString() == "LBL_1000")
                {
                    #region Auto Fill Data
                    LabelDataTableInfo = CreateFileDataTable();
                    Session["LBLInfo"] = LabelDataTableInfo;
                    string AddQry = " WHERE Pro_ID='" + ddlProduct.SelectedValue + "' AND ISNULL(Print_Date,'')  <> '' AND ISNULL(DispatchFlag,'') = 0";
                    //DataTable Mdt = SQL_DB.ExecuteDataTable("SELECT LabelRequestId from m_code " + AddQry + " GROUP BY  LabelRequestId");

                    //-----------------shweta code
                    //  DataTable Mdt = dds.Tables[1];                  
                    DataView dview1 = new DataView();
                    dview1.Table = dds.Tables[1];
                    DataTable Mdt = dview1.ToTable(true, "LabelRequestId");//SQL_DB.ExecuteDataTable("SELECT LabelRequestId from m_code " + AddQry + " GROUP BY  LabelRequestId");   

                    DataView dview2;
                    //-----------------end

                    if (Mdt.Rows.Count > 0)
                    {
                        ExcelQry = ""; VarLabelRequestID = "";
                        #region
                        for (int p = 0; p < Mdt.Rows.Count; p++)
                        {
                            AddQry = " WHERE Pro_ID='" + ddlProduct.SelectedValue + "' AND ISNULL(Print_Date,'')  <> '' AND ISNULL(DispatchFlag,'') = 0";
                            if (VarLabelRequestID != "")
                                VarLabelRequestID += "-" + Mdt.Rows[p]["LabelRequestId"].ToString().Substring(9, 3);
                            else
                                VarLabelRequestID = Mdt.Rows[p]["LabelRequestId"].ToString();
                            // -----------------THese below lines commentd by shweta. It is not using ... ----------------------------------------------------------------
                            //if (ExcelQry != "")
                            //    ExcelQry += " UNION ALL " + Convert.ToString(Business9420.function9420.MyVirtualExccel(ddlProduct.SelectedValue, Mdt.Rows[p]["LabelRequestId"].ToString()));
                            //else
                            //    ExcelQry = Convert.ToString(Business9420.function9420.MyVirtualExccel(ddlProduct.SelectedValue, Mdt.Rows[p]["LabelRequestId"].ToString()));
                            //---------------------------------XXX------------------------------------------
                            AddQry += " AND LabelRequestId = '" + Mdt.Rows[p]["LabelRequestId"].ToString() + "'";
                            //DataTable Modt = SQL_DB.ExecuteDataTable("SELECT DISTINCT Series_Order FROM M_Code " + AddQry);

                            //-----------------------Shweta
                            dview2 = new DataView();
                            dview2.Table = dds.Tables[1];
                            dview2.RowFilter = " LabelRequestId = '" + Mdt.Rows[p]["LabelRequestId"].ToString() + "'";
                            DataTable Modt = dview1.ToTable();//  DataTable Modt = SQL_DB.ExecuteDataTable("SELECT DISTINCT Series_Order FROM M_Code " + AddQry);

                            //--------------------------End
                            if (Modt.Rows.Count > 0)
                            {
                                #region
                                for (int q = 0; q < Modt.Rows.Count; q++)
                                {
                                    AddQry += "  AND Series_Order = '" + Modt.Rows[q]["Series_Order"].ToString() + "' ";
                                    string seriesFrom = "", seriesTo = ""; Int64 LabelQty = 0, SFrom = 0, STo = 0;
                                    txtSeries_Initial.Text = ddlProduct.SelectedValue + "-" + Modt.Rows[q]["Series_Order"].ToString();
                                    //DataTable Mindt = SQL_DB.ExecuteDataTable("SELECT MIN(Series_Serial) as Series_SerialFrom FROM M_Code " + AddQry);
                                    //if (Mindt.Rows.Count > 0)
                                    //{
                                    //    seriesFrom = ddlProduct.SelectedValue + "-" + string.Format("{0:0000}", Convert.ToInt64(Modt.Rows[q]["Series_Order"])) + "-" + string.Format("{0:0000}", Convert.ToInt64(Mindt.Rows[0]["Series_SerialFrom"]));
                                    //    SFrom = Convert.ToInt64(Mindt.Rows[0]["Series_SerialFrom"]);
                                    //}
                                    //DataTable Maxdt = SQL_DB.ExecuteDataTable("SELECT MAX(Series_Serial) as Series_SerialTo FROM M_Code " + AddQry);
                                    //if (Mindt.Rows.Count > 0)
                                    //{
                                    //    seriesTo = ddlProduct.SelectedValue + "-" + string.Format("{0:0000}", Convert.ToInt64(Modt.Rows[q]["Series_Order"])) + "-" + string.Format("{0:0000}", Convert.ToInt64(Maxdt.Rows[0]["Series_SerialTo"]));
                                    //    STo = Convert.ToInt64(Maxdt.Rows[0]["Series_SerialTo"]);
                                    //}

                                    //----------------shweta

                                    seriesFrom = ddlProduct.SelectedValue + "-" + string.Format("{0:0000}", Convert.ToInt64(Modt.Rows[q]["Series_Order"])) + "-" + string.Format("{0:0000}", Convert.ToInt64(Modt.Rows[q]["Series_SerialFrom"]));
                                    SFrom = Convert.ToInt64(Modt.Rows[q]["Series_SerialFrom"]);

                                    seriesTo = ddlProduct.SelectedValue + "-" + string.Format("{0:0000}", Convert.ToInt64(Modt.Rows[q]["Series_Order"])) + "-" + string.Format("{0:0000}", Convert.ToInt64(Modt.Rows[q]["Series_SerialTo"]));
                                    STo = Convert.ToInt64(Modt.Rows[q]["Series_SerialTo"]);
                                    //-------------------------------------end

                                    if (SFrom == 0)
                                        LabelQty = ++STo;
                                    else
                                        LabelQty = STo - SFrom + 1;
                                    #region
                                    DataTable myTable = (DataTable)Session["LBLInfo"];
                                    if (myTable.Rows.Count > 0)
                                    {
                                        for (int k = 0; k < myTable.Rows.Count; k++)
                                        {
                                            string[] Arr = txtSeries_Initial.Text.Trim().Replace("'", "''").ToString().Split('-');
                                            if (Arr[1] != "")
                                            {
                                                AddPrintLabelInfo("", ddlProduct.SelectedValue.ToString(), ddlProduct.SelectedItem.Text.ToString(), ddlLabel.SelectedValue.ToString(), ddlLabel.SelectedItem.Text.ToString(), seriesFrom, seriesTo, LabelQty.ToString(), (DataTable)Session["LBLInfo"]);
                                                Session["ProID"] = ddlProduct.SelectedValue.ToString();
                                                clearinfo();
                                                FillGrdLabelInfo();
                                            }
                                            else
                                                break;
                                        }
                                    }
                                    else
                                    {
                                        string[] Arr = txtSeries_Initial.Text.Trim().Replace("'", "''").ToString().Split('-');
                                        if (Arr[1] != "")
                                        {
                                            AddPrintLabelInfo("", ddlProduct.SelectedValue.ToString(), ddlProduct.SelectedItem.Text.ToString(), ddlLabel.SelectedValue.ToString(), ddlLabel.SelectedItem.Text.ToString(), seriesFrom, seriesTo, LabelQty.ToString(), (DataTable)Session["LBLInfo"]);
                                            Session["ProID"] = ddlProduct.SelectedValue.ToString();
                                            clearinfo();
                                            FillGrdLabelInfo();
                                        }
                                    }
                                    AddQry = " WHERE Pro_ID='" + ddlProduct.SelectedValue + "' AND ISNULL(Print_Date,'')  <> '' AND ISNULL(DispatchFlag,'') = 0 AND LabelRequestId = '" + Mdt.Rows[p]["LabelRequestId"].ToString() + "'";
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
                    LabelDataTableInfo = CreateFileDataTable();
                    Session["LBLInfo"] = LabelDataTableInfo;
                    clearinfo();
                    FillGrdLabelInfo();
                    #endregion
                }
            }
            else
            {
                ddlLabel.Enabled = true;
                DataProvider.MyUtilities.FillDDLInsertZeroIndexString(dds, "Label_Code", "Label_Name", ddlLabel, "--Select--");
                ddlLabel.SelectedIndex = 0;
                txtSeriesFrom.Text = string.Empty; txtSeriesTo.Text = string.Empty; LblCountQty.Text = string.Empty;
            }
            txtDispLocation.Text = SQL_DB.ExecuteScalar("SELECT Dispatch_Location  FROM Pro_Reg where [Pro_ID] = '" + ddlProduct.SelectedValue.ToString() + "'  ").ToString();
        }
        else
        {
            ddlLabel.Items.Clear();
            ddlLabel.Items.Insert(0, "--Select--");
            ddlLabel.SelectedIndex = 0;
        }
        LogManager.WriteCourierDispatch("ddlProduct_SelectedIndexChanged - End");
        LogManager.WriteCourierDispatch("((DataTable)Session[LBLInfo]  value - " + Convert.ToString(((DataTable)Session["LBLInfo"]).Rows.Count));
        LogManager.WriteCourierDispatch("-----------------------------");
        Session["LBLInfo2"] = (DataTable)Session["LBLInfo"];
        LogManager.WriteCourierDispatch("((DataTable)Session[LBLInfo2]  value - " + Convert.ToString(((DataTable)Session["LBLInfo2"]).Rows.Count));
        ModalPopupExtenderNewDesign.Show();
    }
    protected void ddlLabel_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlLabel.SelectedIndex > 0)
        {
            //ddlLabel.SelectedValue = Convert.ToString(SQL_DB.ExecuteScalar("SELECT Label_Code, Label_Name + '( ' +Label_Size+ ') ' as Label_Name FROM  M_Label WHERE Label_Code IN (SELECT [Label_Code]  FROM Pro_Reg where [Pro_ID] = '" + ddlProduct.SelectedValue.ToString() + "') "));
            txtSeries_Initial.Text = ddlProduct.SelectedValue.Trim() + "-"; txtSeriesFrom.Text = string.Empty; txtSeriesTo.Text = string.Empty; LblCountQty.Text = string.Empty;
        }
        ModalPopupExtenderNewDesign.Show();
    }
    protected void DDLCompany_SelectedIndexChanged(object sender, EventArgs e)
    {
        fillProduct("I");
        clearinfo();
        ((DataTable)Session["LBLInfo"]).Rows.Clear();
        LogManager.WriteCourierDispatch("DDLCompany_SelectedIndexChanged - start");
        LogManager.WriteCourierDispatch("((DataTable)Session[LBLInfo]  value - " + Convert.ToString(((DataTable)Session["LBLInfo"]).Rows.Count));
        LogManager.WriteCourierDispatch("-----------------------------");
        FillGrdLabelInfo();
        ModalPopupExtenderNewDesign.Show();
    }
    private void fillProduct(string str)
    {
        ddlProduct.Items.Clear(); ddlLabel.Items.Clear();
        Object9420 obj = new Object9420();
        obj.Comp_ID = DDLCompany.SelectedValue.ToString();
        obj.DML = str;
        //DataSet ds = Business9420.function9420.SelectProductDetailsNoofCodes(obj);
        //Commented for related //
        DataSet ds = Business9420.function9420.SelectProductDetailsLabelInfo(obj);
        //// Direct for product //
        //DataSet ds = SQL_DB.ExecuteDataSet("SELECT * FROM Pro_Reg WHERE Comp_ID = '" + obj.Comp_ID + "'");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProduct, "--Select--");
        ddlProduct.SelectedIndex = 0;
        //DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT Label_Code, Label_Name + '( ' +Label_Size+ ') ' as Label_Name FROM  M_Label WHERE Label_Code IN (SELECT [Label_Code]  FROM Pro_Reg where [Comp_ID] = '" + DDLCompany.SelectedValue.ToString() + "') order by [Label_Code]");
        //if (ds1.Tables[0].Rows.Count > 0)
        //{
        //    ddlLabel.DataSource = ds1.Tables[0];
        //    ddlLabel.DataTextField = "Label_Name";
        //    ddlLabel.DataValueField = "Label_Code";
        //    ddlLabel.DataBind();
        //    ddlLabel.Items.Insert(0, "--Select--");
        //    ddlLabel.SelectedIndex = 0;
        //}
        //else
        //{
        ddlLabel.Items.Clear();
        ddlLabel.Items.Insert(0, "--Select--");
        ddlLabel.SelectedIndex = 0;
        //}
    }

    protected void btnNoActivation_Click(object sender, EventArgs e)
    {
        if (btnYesActivation.Text == "Print Receipt")
            ModalPopupExtenderNewDesign.Show();
    }
    protected void btnYesActivation_Click(object sender, EventArgs e)
    {
        if (btnYesActivation.Text == "Yes")
        {
            Object9420 Reg = new Object9420();
            Reg.Courier_Disp_ID = lblCourierId.Text;
            UpdateDispatchFlagSeries("U");
            function9420.DeleteCourierProDispInfo(Reg);
            function9420.GetCourierDispInfo(Reg);
            function9420.DeleteCourierDispInfo(Reg);
            ((DataTable)Session["LBLInfo"]).Rows.Clear();

            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
            lblmsgHeader.Text = "Courier <span style='color:blue;' >" + Reg.Courier_Name + "</span> Dispatch order has been deleted successfull.";
            FillGrdMain();
            string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
        else
        {
            // Coding for print receipt
            ModalPopupExtenderNewDesign.Show();
            btnYesActivation.Text = "Yes";
        }

        //ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( 'your_page.aspx', null, 'height=700,width=760,status=yes,toolbar=no,scrollbars=yes,menubar=no,location=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
    }

    protected void btnYesActivation1_Click(object sender, EventArgs e)
    {
        // btnYesActivation1.PostBackUrl = ProjectSession.absoluteSiteBrowseUrl + "/Admin/Bill/Invoice/pp.pdf";
        // btnYesActivation1.Style.Add("target", "_blank");
        ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW",
            "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( '" + Prop_PrintRecp + "', '_blank');", true);
    }


}
