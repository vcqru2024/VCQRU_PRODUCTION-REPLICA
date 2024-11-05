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

public partial class Admin_FrmRedeemHistory : System.Web.UI.Page
{
    public int str = 0, IDisp = 0, IDel = 0, index = 0; public string DeliveryType = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmRedeemHistory.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Comapny")
                Response.Redirect("Index.aspx");
        }
        if (!Page.IsPostBack)
        {
            //if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
            //    Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            //if (Session["Comp_type"].ToString() == "D")
            //    imgNew.Visible = false;
            //else
            //    imgNew.Visible = true;
            FillCompany();
            FillGrdAwards();
            newMsg.Visible = false;
        }        
    }
    protected void ddlComp_SelectedIndexChanged(object sender, EventArgs e)
    {
            FillGrdAwards();
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillGrdAwards();
    }
    private void FillCompany()
    {
        Loyalty_Points Reg = new Loyalty_Points();
        Reg.User_ID = "";
        DataSet ds = Loyalty_Points.FillCompDropdownList(Reg); //function9420.FillActiveComp();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", ddlComp, "--Company Name--");
        ddlComp.SelectedIndex = 0;
        //ddlProduct.Items.Clear();
        //ddlProduct.Items.Insert(0, "--Product Name--");
        //ddlProduct.SelectedIndex = 0;
        //DataSet ds = new DataSet();
        //ds = SQL_DB.ExecuteDataSet("SELECT Comp_ID,Comp_Name FROM Comp_Reg WHERE Comp_ID IN (SELECT Comp_ID FROM Pro_Reg  WHERE Pro_ID IN(SELECT Pro_ID FROM M_Loyalty))");
        //DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", ddlComp, "--Select Company--");
        //ddlComp.SelectedIndex = 0;
    }
    protected void GrdLabel_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        newMsg.Visible = false;
        GrdLabel.PageIndex = e.NewPageIndex;
        FillGrdAwards();
    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdAwards();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtSerCompName.Text = string.Empty; txtSearchName.Text = string.Empty;
        newMsg.Visible = false;
        FillGrdAwards();
    }    
    private void Cleartxt()
    {
        lbleditlabelid.Text = "";
    }
    private void FillGrdAwards()
    {
        Loyalty_Awards Reg = new Loyalty_Awards(); ;        
        Reg.AwardName = txtSearchName.Text.Trim().Replace("'", "''");
        if(txtrewardkey.Text.Trim().Length == 9)
            Reg.RewardKey = Convert.ToInt64(txtrewardkey.Text.Trim());
        Reg.DML = ddlstatus.SelectedValue.ToString();
        if (ddlComp.SelectedIndex > 0)
        {
            Reg.Comp_ID = ddlComp.SelectedValue.ToString();// Session["CompanyId"].ToString();
            Reg.CompName = ddlComp.SelectedItem.Text.Trim(); //txtSerCompName.Text.Trim().Replace("'", "''");
        }
        else
        {
            Reg.Comp_ID = "";
            Reg.CompName = "";
        }
        DataSet ds = Loyalty_Awards.FillManufRedeemAwards(Reg);
        if (Convert.ToInt32(ddlRowsShow.SelectedValue) > 1000)
        {
            if (ds.Tables[0].Rows.Count > 0)
                GrdLabel.PageSize = ds.Tables[0].Rows.Count;
        }
        else
            GrdLabel.PageSize = Convert.ToInt32(ddlRowsShow.SelectedValue.Trim());
        GrdLabel.DataSource = ds.Tables[0];
        GrdLabel.DataBind();
        lblcount.Text = ds.Tables[0].Rows.Count.ToString();
    }
    protected void GrdLabel_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //Object9420 Reg = new Object9420();
        //lbleditlabelid.Text = e.CommandArgument.ToString();
        //Reg.Label_Code = lbleditlabelid.Text;
        //function9420.FillLabelInfo(Reg);
        //newMsg.Visible = false; Div1.Visible = false;
        //if (e.CommandName == "EditLabel")
        //{
        //    EditLabel(Reg);
        //    lblheading.Text = "Update Label";
        //    ModalPopupCreateLabel.Show();
        //}
        //else if (e.CommandName == "ShowHideLabel")
        //{

        //    lblPassPnlHead.Text = "Alert";
        //    lblPopMsgText.Text = "Are you sure to " + FindStatus(Reg.Flag) + " <span style='color:blue;' >" + Reg.Label_Name + "</span>  ( " + Reg.Label_Size + " )  Label ?";
        //    ModalPopupExtender3.Show();
        //}
        //else if (e.CommandName == "ViewLabelDetails")
        //{
        //    FillLabelDetGrd(Reg);
        //    ModalPopupLabelPriseDetails.Show();
        //}
    }
}
