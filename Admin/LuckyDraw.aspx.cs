using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Business9420;
using System.IO;
using ComponentAce.Compression.ZipForge;
using ComponentAce.Compression.Archiver;
using System.Net;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Configuration;
using Business_Logic_Layer;
using CustomeDraw;

public partial class LuckyDraw : System.Web.UI.Page
{
    public int c = 0, index = 0, vl = 0, IsActive = 0, IsDraw = 0, dts = 0;
    public string srt = DataProvider.Utility.FindMailBody();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=LuckyDraw.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!Page.IsPostBack)
        {
            allClear();
            fillGrid();
        }
    }
    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        fillGrid();
    }
    private void fillGrid()
    {
        Loyalty_Programm obj = new Loyalty_Programm();
        if (ddlComp_Id.SelectedIndex > 0)
            obj.Comp_ID = ddlComp_Id.SelectedValue;
        else
            obj.Comp_ID = "";
        if (ddlPro_ID.SelectedIndex > 0)
            obj.Pro_ID = " AND REG.Pro_ID = '" + ddlPro_ID.SelectedValue + "' ";
        DataSet ds = Loyalty_Programm.FillGrVwDraw(obj);
        if (Convert.ToInt32(ddlRowsShow.SelectedValue) > 1000)
        {
            if (ds.Tables[0].Rows.Count > 0)
                GrdVw.PageSize = ds.Tables[0].Rows.Count;
        }
        else
            GrdVw.PageSize = Convert.ToInt32(ddlRowsShow.SelectedValue);
        if (ds.Tables[0].Rows.Count > 0)
            GrdVw.DataSource = ds.Tables[0];
        GrdVw.DataBind();
        lblcount.Text = GrdVw.Rows.Count.ToString();
    }
    private void allClear()
    {
        fillCompany();
        lblmsg.Text = "";
        lblcount.Text = "0";
    }
    private void fillCompany()
    {
        DataSet ds = function9420.FillActiveComp();
        ds = Business9420.function9420.FillActiveComp();
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", ddlComp_Id, "--Select--");
        ddlComp_Id.SelectedIndex = 0;
    }
    private void fillProductSearch()
    {
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = ddlComp_Id.SelectedValue.Trim().ToString();
        DataSet ds = function9420.FillddlProForPrint(Reg);
        if (ds.Tables[0].Rows.Count > 0)
        {
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlPro_ID, "--Product--");
            ddlPro_ID.SelectedIndex = 0;
        }
        else
        {
            ddlPro_ID.Items.Clear();
            ddlPro_ID.Items.Insert(0, "--Product--");
        }
    }
    private void fillddl()
    {
        fillCompany();
    }
    protected void GrdVw_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DrawRewards")
        {
            try
            {
                string str = RewardsDraw.Draw(Convert.ToInt64(e.CommandArgument.ToString()));
                string[] Arr = str.ToString().Split('*');
                if (Arr.Length > 1)
                {
                    if (Arr[0].ToString().Trim() == "false")
                    {
                        lblmsg.Text = "Catch Excepion " + Arr[1].ToString();
                    }
                    else
                    {
                        lblmsg.Text = "Excepion " + Arr[1].ToString();
                    }
                    BigpopMsg.Visible = true;
                    BigpopMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                    string script = @"setTimeout(function(){document.getElementById('" + BigpopMsg.ClientID + "').style.display='none';},5000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
                }
            }
            catch (Exception ex)
            {
                lblmsg.Text = "Catch Excepion " + ex.Message.ToString();
                BigpopMsg.Visible = true;
                BigpopMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                string script = @"setTimeout(function(){document.getElementById('" + BigpopMsg.ClientID + "').style.display='none';},5000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            }

        }
    }
    protected void GrdVw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdVw.PageIndex = e.NewPageIndex;
        fillGrid();
    }

    protected void ddlComp_Id_SelectedIndexChanged(object sender, EventArgs e)
    {
        BigpopMsg.Visible = false;
        fillProductSearch();
        fillGrid();
    }
    protected void ddlPro_ID_SelectedIndexChanged(object sender, EventArgs e)
    {
        fillGrid();
    }
    protected void BtnSearch_Click(object sender, ImageClickEventArgs e)
    {
        lblmsg.Text = "";
        BigpopMsg.Visible = false;
        fillGrid();
    }
    protected void BtnRefesh_Click(object sender, ImageClickEventArgs e)
    {
        lblmsg.Text = "";
        BigpopMsg.Visible = false;
        fillCompany(); ddlPro_ID.Items.Clear(); ddlPro_ID.Items.Insert(0, "--Product--"); ddlPro_ID.SelectedIndex = 0;
        fillGrid();
    }
}