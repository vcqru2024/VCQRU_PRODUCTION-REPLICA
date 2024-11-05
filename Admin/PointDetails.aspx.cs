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
using System.IO;
using System.Web.Services;
using System.Web.Script.Services;
using Business_Logic_Layer;

public partial class Consumer_PointDetails : System.Web.UI.Page
{
    public int str = 0, strr = 0, lflag = 0; public int index = 0, IsCash = 0; public string Earn = "", Redeem = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=PointDetails.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {
            FillDateFromTo();
            fillCompany();
            FillGrdPointsDetails();
            newMsg.Visible = false;
            //lblcount.Text = "0";
        } 


        //if (Session["User_Type"] == null)
        //    Response.Redirect("../Home/Index.aspx?Page=AwardList.aspx");
        //else
        //{
        //    if (Session["User_Type"].ToString() == "Company")
        //        Response.Redirect("../Index.aspx");
        //}
        //if (!IsPostBack)
        //{
        //    FillDateFromTo();
        //    fillCompany();
        //    FillGrdPointsDetails();
        //    newMsg.Visible = false;
        //    lblcount.Text = "0";
        //}
        //Label2.Text = "";
    }
    private void FillDateFromTo()
    {
        DataTable dt = SQL_DB.ExecuteDataSet("SELECT MIN(Entry_Date) as DT FROM [T_Points] ").Tables[0];//where User_ID ='"+ Session["USRID"].ToString() +"'
        if(dt.Rows.Count > 0)
            txtDateFrom.Text = Convert.ToDateTime(dt.Rows[0]["DT"]).ToString("dd/MM/yyyy");
        else
            txtDateFrom.Text = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("dd/MM/yyyy");
        txtDateto.Text = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("dd/MM/yyyy");
    }
    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillGrdPointsDetails();
    }
    protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCompany.SelectedIndex > 0)
            fillProduct();
        else
        {
            ddlProduct.Items.Clear();
            ddlProduct.Items.Insert(0, "--Product Name--");
            ddlProduct.SelectedIndex = 0;
        }
        FillGrdPointsDetails();
    }
    private void fillCompany()
    {
        Loyalty_Points Reg = new Loyalty_Points();
        Reg.User_ID = "";//Session["USRID"].ToString();
        DataSet ds = Loyalty_Points.FillCompDropdownList(Reg); //function9420.FillActiveComp();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", ddlCompany, "--Company Name--");
        ddlCompany.SelectedIndex = 0;
        ddlProduct.Items.Clear();
        ddlProduct.Items.Insert(0, "--Product Name--");
        ddlProduct.SelectedIndex = 0;
    }
    private void fillProduct()
    {
        Loyalty_Points Reg = new Loyalty_Points();
        Reg.User_ID = ""; // Session["USRID"].ToString();
        Reg.Comp_ID = ddlCompany.SelectedValue.ToString();
        DataSet ds = Loyalty_Points.FillProductDropdownList(Reg);
        //DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_ID],[Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + ddlCompany.SelectedValue.ToString() + "' order by [Pro_Name]");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProduct, "--Product Name--");
        ddlProduct.SelectedIndex = 0;
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        Cleartxt();
        newMsg.Visible = false;
        lblheading.Text = "Check New Product";
        ModalPopupCreateLabel.Show();
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        newMsg.Visible = false;
        FillGrdPointsDetails();
    }
    private void FillGrdPointsDetails()
    {
        Loyalty_Points Reg = new Loyalty_Points(); string Qry = "";
        //Reg.Msg = " AND [Points] > 0 ";
        if (ddlCompany.SelectedIndex > 0)
        {
            Reg.Comp_ID = ddlCompany.SelectedValue.ToString();
            Reg.Msg = " AND Comp_ID = '" + Reg.Comp_ID + "'"; Qry = " AND Comp_ID = '" + Reg.Comp_ID + "'";
        }
        if (ddlProduct.SelectedIndex > 0)
        {
            Reg.Pro_ID = ddlProduct.SelectedValue.ToString();
            Reg.Msg += " AND Pro_ID = '" + Reg.Pro_ID + "'"; //Qry += " AND Pro_ID = '" + Reg.Pro_ID + "'";
        }
        Reg.User_ID = "";// Session["USRID"].ToString();
        if (ddlEarntype.SelectedIndex > 0)
        {
            Reg.EarnType = ddlEarntype.SelectedValue.ToString();
            Reg.Msg += " AND [Type] = '" + Reg.EarnType + "'";
        }
        if (txtcode1search.Text.Trim().Length == 5)
        {
            Reg.Msg += " AND [Code1] = '" + txtcode1search.Text.Trim() + "'";
        }
        if (txtcode2search.Text.Trim().Length == 8)
        {
            Reg.Msg += " AND [Code2] = '" + txtcode2search.Text.Trim() + "'";
        }
        Reg.Msg += " AND CONVERT(VARCHAR,Entry_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text.Trim()).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,Entry_Date,111) <= '" + Convert.ToDateTime(txtDateto.Text.Trim()).ToString("yyyy/MM/dd") + "' ";
        if (Reg.Msg == null)
            Reg.Msg = "";
        DataSet ds = Loyalty_Points.FillGrdpointsDetails(Reg);
        //GrdLabel.DataSource = ds.Tables[0];        
        if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 1000)
        {
            if (ds.Tables[0].Rows.Count > 0)
                GrdLabel.PageSize = ds.Tables[0].Rows.Count;
        }
        else
            GrdLabel.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        if (ds.Tables[0].Rows.Count > 0)
            GrdLabel.DataSource = ds.Tables[0];
        GrdLabel.DataBind();
        lblcount.Text = ds.Tables[0].Rows.Count.ToString();
        if (GrdLabel.Rows.Count > 0)
        {
            Int64 REarnPoints = 0;
            DataTable eds = SQL_DB.ExecuteDataSet("SELECT ISNULL(SUM(Cash_Amount),0) AS RPoints FROM T_DistributedAwardDetails WHERE Delivery_Type = 'Cash' AND CONVERT(VARCHAR,Entry_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text.Trim()).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,Entry_Date,111) <= '" + Convert.ToDateTime(txtDateto.Text.Trim()).ToString("yyyy/MM/dd") + "' AND ('' = '" + Reg.User_ID + "' OR [User_ID] = '" + Reg.User_ID + "') " + Qry).Tables[0];
            if (eds.Rows.Count > 0)
                REarnPoints = Convert.ToInt64(eds.Rows[0]["RPoints"]);
            else
                REarnPoints = 0;
            lblToatalPoints.Visible = true; object tpc = ds.Tables[0].Compute("Sum(Points)", "Type='Earn' AND IsCashConvert=0");
            object tp = ds.Tables[0].Compute("Sum(Points)", "Type='Earn'"); object tp1 = ds.Tables[0].Compute("Sum(Points)", "Type='Refund'"); object tp2 = ds.Tables[0].Compute("Sum(Points)", "Type='Redeem'");
            Int64 TPoints = Convert.ToInt64((tp is DBNull ? 0 : tp)) + Convert.ToInt64((tp1 is DBNull ? 0 : tp1)) - Convert.ToInt64((tp2 is DBNull ? 0 : tp2));
            lblToatalPoints.Text = "<span style='color:green;'>Balance Points</span> <span style='color:blue;'><b>[" + TPoints.ToString() + "]</b></span>";
            Int64 TEarnPoints = Convert.ToInt64((tp is DBNull ? 0 : tp)) + Convert.ToInt64((tp1 is DBNull ? 0 : tp1));
            Int64 CEarnPoints = Convert.ToInt64((tpc is DBNull ? 0 : tpc));
            Int64 CTPoints = ((TEarnPoints >= CEarnPoints) ? CEarnPoints : 0) - REarnPoints;
            lblToatalCashPoints.Text = "<span style='color:green;'>Cash Convertable Balance Points</span> <span style='color:blue;'><b>[" + (CTPoints > TPoints ? TPoints.ToString() : CTPoints.ToString()) + "]</b></span>";
        }
        else
            lblToatalPoints.Visible = false;
    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdPointsDetails();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        FillDateFromTo();
        newMsg.Visible = false;
        FillGrdPointsDetails();
    }
    protected void GrdLabel_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdLabel.PageIndex = e.NewPageIndex;
        if (GrdLabel.PageIndex == 0)
            str = 0;        
        else
            str = (16 * GrdLabel.PageIndex) - GrdLabel.PageIndex;
        FillGrdPointsDetails();
    }
    private void Cleartxt()
    {
        lbleditlabelid.Text = "";
        //txtMobileNo.Text = string.Empty;
        //txtCode1.Text = string.Empty; 
        txtCode2.Text = string.Empty;
        btnSave.Text = "Save";
        lblheading.Text = "Check New Product";
    }
    private void EditLabel(Object9420 Reg)
    {
        //txtlabelprise.Enabled = true;
        btnSave.Text = "Update";
    }
    protected void GrdLabel_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Object9420 Reg = new Object9420();
        lbleditlabelid.Text = e.CommandArgument.ToString();
        Reg.Label_Code = lbleditlabelid.Text;
        function9420.FillLabelInfo(Reg);
        newMsg.Visible = false; Div1.Visible = false;
        if (e.CommandName == "EditLabel")
        {
            EditLabel(Reg);
            lblheading.Text = "Update Label";
            ModalPopupCreateLabel.Show();
        }
        else if (e.CommandName == "ShowHideLabel")
        {

            lblPassPnlHead.Text = "Alert";
            lblPopMsgText.Text = "Are you sure to " + FindStatus(Reg.Flag) + " <span style='color:blue;' >" + Reg.Label_Name + "</span>  ( " + Reg.Label_Size + " )  Label ?";
            ModalPopupExtender3.Show();
        }
        else if (e.CommandName == "ViewLabelDetails")
        {
            FillLabelDetGrd(Reg);
            ModalPopupLabelPriseDetails.Show();
        }
    }
    private string FindStatus(int Status)
    {
        if (Status == 1)
            return "De-Activate";
        else
            return "Activate";
    }
    private string FindStatus1(int Status)
    {
        if (Status == 0)
            return "De-Activated";
        else
            return "Activated";
    }
    protected void btnYesActivation_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Label_Code = lbleditlabelid.Text;
        function9420.UpdateLabelFlag(Reg);
        function9420.FillLabelInfo(Reg);
        newMsg.Visible = true;
        newMsg.Attributes.Add("class", "alert_boxes_green");
        Label2.Text = "Status of <span style='color:blue;' >" + Reg.Label_Name + "</span>  ( " + Reg.Label_Size + " ) is <span style='color:blue;' >" + Reg.Label_Msg + "</span> ! ";
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        FillGrdPointsDetails();
    }
    protected void btnNoActivation_Click(object sender, EventArgs e)
    {

    }
    private void FillLabelDetGrd(Object9420 Reg)
    {
        DataSet ds = function9420.FillLabelPriseInfo(Reg);
        Label1.Text = " Price Details";
        Label4.Text = ds.Tables[0].Rows[0]["Label_Name"].ToString() + "  ( " + ds.Tables[0].Rows[0]["Label_Size"].ToString() + " )";
        GrdViewLabelDetails.DataSource = ds.Tables[0];
        GrdViewLabelDetails.DataBind();
    }
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewLabel(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Label_Name] FROM [M_Label] where [Label_Name] = '" + res + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string MobileNo = txtMobileNo.Text.Trim().Replace("'", "''");
        #region Find Actual Mobile No
        if (MobileNo.Length < 10)
        {
            btnSave.Enabled = false;
            btnSave.Attributes.Add("class", "save_btn_Sec f_left");
            ProductsLabelPrices.Text = "Mobile No. must be 10 digits!";
            Div1.Visible = true;
            Div1.Attributes.Add("class", "alert_boxes_pink");
            string script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            return;
        }
        if (MobileNo.Length == 11)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = "91" + MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                btnSave.Enabled = false;
                btnSave.Attributes.Add("class", "save_btn_Sec f_left");
                ProductsLabelPrices.Text = "Mobile No. Wrong!";
                Div1.Visible = true;
                Div1.Attributes.Add("class", "alert_boxes_pink");
                string script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
        }
        if (MobileNo.Length == 13)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 1));
            if (initial == 0)
                MobileNo = MobileNo.Substring(1, MobileNo.Length - 1);
            else
            {
                btnSave.Enabled = false;
                btnSave.Attributes.Add("class", "save_btn_Sec f_left");
                ProductsLabelPrices.Text = "Mobile No. Wrong!";
                Div1.Visible = true;
                Div1.Attributes.Add("class", "alert_boxes_pink");
                string script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
        }
        if (MobileNo.Length == 12)
        {
            int initial = Convert.ToInt32(MobileNo.Substring(0, 2));
            if (initial == 91)
                MobileNo = MobileNo.Substring(2, MobileNo.Length - 2);
            else
            {
                btnSave.Enabled = false;
                btnSave.Attributes.Add("class", "save_btn_Sec f_left");
                ProductsLabelPrices.Text = "Mobile No. Wrong!";
                Div1.Visible = true;
                Div1.Attributes.Add("class", "alert_boxes_pink");
                string script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                return;
            }
        }
        if (MobileNo.Length == 10)
            MobileNo = "91" + MobileNo;
        #endregion
        Loyalty_Points Reg = new Loyalty_Points();
        Reg.User_ID = Session["USRID"].ToString();
        Reg.MobileNo = MobileNo;
        Reg.Code1 = Convert.ToInt64(txtCode1.Text.Trim().Replace("'", "''"));
        Reg.Code2 = Convert.ToInt64(txtCode2.Text.Trim().Replace("'", "''"));
        Reg.Mode = Reg.MobileNo;
        DataTable dt = SQL_DB.ExecuteDataSet("Select Pro_ID,(SELECT Comp_ID FROM Pro_Reg WHERE Pro_ID = [M_Code].Pro_ID) AS Comp_ID,Use_Count FROM M_Code WHERE Code1 = " + Reg.Code1 + " AND Code2 = " + Reg.Code2 + " ").Tables[0];
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        if (dt.Rows.Count > 0)
        {
            Reg.Comp_ID = dt.Rows[0]["Comp_ID"].ToString(); Reg.Pro_ID = dt.Rows[0]["Pro_ID"].ToString();
            if (Convert.ToInt32(dt.Rows[0]["Use_Count"]) == 0)
            {
                if (btnSave.Text == "Save")
                {
                    DataTable ddt = SQL_DB.ExecuteDataSet("SELECT [RowId],[Comp_ID],[Pro_ID],[Points],[IsCashConvert],[DateFrom],[DateTo],[IsActive],[IsDelete],[Entry_Date] FROM [tauseef_L9420].[dbo].[M_Loyalty] WHERE [Pro_ID] = '" + dt.Rows[0]["Pro_ID"].ToString() + "' AND [IsActive] = 0 AND [IsDelete] = 0 ").Tables[0];
                    if (ddt.Rows.Count > 0)
                    {
                        bool ChkFlag = false;
                        string Dt1 = ddt.Rows[0]["DateFrom"].ToString(); string Dt2 = ddt.Rows[0]["DateTo"].ToString();
                        if ((Dt1 != "") && (Dt2 != ""))
                        {
                            if ((Convert.ToDateTime(ddt.Rows[0]["DateFrom"]) <= Convert.ToDateTime(Reg.Entry_Date)) && (Convert.ToDateTime(ddt.Rows[0]["DateTo"]) >= Convert.ToDateTime(Reg.Entry_Date)))
                                ChkFlag = true;
                            else
                            {
                                ProductsLabelPrices.Text = "This Product is <span style='color:blue;' > not valid for loyalty programm  </span> !";
                                Div1.Visible = true;
                                Div1.Attributes.Add("class", "alert_boxes_pink");
                                ChkFlag = false;
                            }
                        }
                        else if ((Dt1 != "") && (Dt2 == ""))
                            ChkFlag = true;
                        else if ((Dt1 == "") && (Dt2 == ""))
                            ChkFlag = true;
                        if (ChkFlag)
                        {
                            Reg.Points = Convert.ToDecimal(ddt.Rows[0]["Points"]);
                            Reg.EarnType = "Earn";
                            Reg.DML = "I";
                            Loyalty_Points.InsertUpdatePoints(Reg);
                            ProductsLabelPrices.Text = "This Product is <span style='color:blue;' > Genuine </span> !";
                            Div1.Visible = true;
                            Div1.Attributes.Add("class", "alert_boxes_green");
                        }
                    }
                    else
                    {
                        ProductsLabelPrices.Text = "This Product is <span style='color:blue;' > valid for loyalty programm  </span> !";
                        Div1.Visible = true;
                        Div1.Attributes.Add("class", "alert_boxes_pink");
                    }
                    ModalPopupCreateLabel.Show();
                    string script = @"setTimeout(function(){document.getElementById('" + Div1.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                }
            }
            else
            {
                ProductsLabelPrices.Text = "This Product is <span style='color:blue;' > Already checked  </span> !";
                Div1.Visible = true;
                Div1.Attributes.Add("class", "alert_boxes_pink");
                ModalPopupCreateLabel.Show();
            }
            Cleartxt();
            FillGrdPointsDetails();
        }
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Cleartxt();
        ModalPopupCreateLabel.Show();
    }
}
