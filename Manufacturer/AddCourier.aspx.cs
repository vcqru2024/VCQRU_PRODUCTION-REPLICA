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
using Data9420;
using System.Configuration;
using DataProvider;
using Business_Logic_Layer;

public partial class Manufacturer_AddCourier : System.Web.UI.Page
{
    public int Flag = 0, index = 0;

    private string _Cid_Prop;
    public string Cid_Prop
    {
        get { return (string)ViewState["_Cid_Prop"]; }
        set { ViewState["_Cid_Prop"] = value; }
    }

   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../default.aspx?Page=AddCourier.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            if (Request.QueryString["id"] != null)
            {
                Cid_Prop = Convert.ToString(Request.QueryString["id"]);
                EditMode();
            }
            hdncmphdn.Value = ProjectSession.strCompanyid;// Session["CompanyId"].ToString();
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            //newMsg.Visible = false;DivNewMsg.Visible = false;
            //lblmsgHeader.Text = "";
            //newMsg.Visible = false;
            //lblcount.Text = "0";
        }
        //Label2.Text = "";
        
    }

    public void EditMode()
    {
        Object9420 Reg = new Object9420();
        lblBankId.Text = Cid_Prop;
        Reg.CourierPkid = Convert.ToInt32(Cid_Prop);
        //newMsg.Visible = false;
        function9420.GetCourierInfo(Reg);
        txtCourierName.Text = Reg.Courier_Name;
        txtCourierEmail.Text = Reg.Courier_Email;
        txtContactNo.Text = Reg.Courier_Mobile;
        txtAddress.Text = Reg.Courier_Address;
        //lblAddCourierHeader.Text = "Courier update Details";
        btnCourierSubmit.Text = "Update";
    }


    [WebMethod]
    [ScriptMethod]
    public static bool checkNewLabel(string res)
    {
        string[] Arr = res.ToString().Split('*');
        if (Arr.Length > 1)
        {
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Courier_Name] FROM [Courier_Master] WHERE  [Courier_Name]  = '" + Arr[0].ToString() + "' AND [User_ID] = '" + Arr[1].ToString() + "' ");
            if (ds.Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }
        else
            return false;
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        //Clear();
        //newMsg.Visible = false; DivNewMsg.Visible = false;
        //ModalPopupExtenderNewDesign.Show();
    }

    private void Clear()
    {
        txtAddress.Text = "";
        txtContactNo.Text = "";
        txtCourierEmail.Text = "";
        txtCourierName.Text = "";
       // lblAddCourierHeader.Text = "Add New Courier";
        btnCourierSubmit.Text = "Save";
    }

    protected void BtnSearchCourier_Click(object sender, ImageClickEventArgs e)
    {
        FillGrid();
       // newMsg.Visible = false;
    }

    protected void BtnSearchCourierRefesh_Click(object sender, ImageClickEventArgs e)
    {
        //txtSearchName.Text = "";
        //FillGrid();
        //newMsg.Visible = false;
    }

    private void FillGrid()
    {
        //DataSet DsGrd = new DataSet();

        //DsGrd = Business9420.function9420.FillCourierDataGrid(txtSearchName.Text.Trim(), ProjectSession.strCompanyid);
        //if (DsGrd.Tables.Count > 0)
        //{
        //    GrdCourier.DataSource = DsGrd.Tables[0];
        //    GrdCourier.DataBind();
        //    lblcount.Text = DsGrd.Tables[0].Rows.Count.ToString();
        //}
        //else
        //    lblcount.Text = "0";
    }
    protected void GrdCourier_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
       // GrdCourier.PageIndex = e.NewPageIndex;
       // FillGrid();
    }
    protected void GrdCourier_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //Object9420 Reg = new Object9420();
        //lblBankId.Text = e.CommandArgument.ToString();
        //Reg.CourierPkid = Convert.ToInt32(lblBankId.Text); newMsg.Visible = false;
        //function9420.GetCourierInfo(Reg);
        //if (e.CommandName.ToString() == "CourierEdit")
        //{
        //    //txtCourierName.Text = Reg.Courier_Name;
        //    //txtCourierEmail.Text = Reg.Courier_Email;
        //    //txtContactNo.Text = Reg.Courier_Mobile;
        //    //txtAddress.Text = Reg.Courier_Address;
        //    //lblAddCourierHeader.Text = "Courier update Details";
        //    //btnCourierSubmit.Text = "Update";            
        //    //ModalPopupExtenderNewDesign.Show();
        //}
        //else if (e.CommandName.ToString() == "CourierDelete")
        //{
        //    LabelAlertheader.Text = "Alert";
        //    LabelAlertText.Text = "Are you sure to dalete  <span style='color:blue;' >" + Reg.Courier_Name + "</span>  Courier Company permanently?";
        //    ModalPopupExtenderAlert.Show();
        //}
    }
    protected void btnNoActivation_Click(object sender, EventArgs e)
    {

    }
    protected void btnYesActivation_Click(object sender, EventArgs e)
    {
        //Object9420 Reg = new Object9420();
        //Reg.CourierPkid = Convert.ToInt32(lblBankId.Text);
        ////   function9420.GetCourierInfo(Reg);
        //function9420.DeleteCourierDetail(Reg);
        //newMsg.Visible = true;
        //newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        //lblmsgHeader.Text = "Courier <span style='color:blue;' >" + Reg.Courier_Name + "</span> has benn deleted  successfully.";
        //FillGrid();
        //string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }
    protected void btnCourierSubmit_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.Courier_Name = txtCourierName.Text.Trim().Replace("'", "''");
        Reg.Courier_Email = txtCourierEmail.Text.Trim().Replace("'", "''");
        Reg.Courier_Address = txtAddress.Text.Trim().Replace("'", "''");
        Reg.Courier_Mobile = txtContactNo.Text.Trim().Replace("'", "''");
        Reg.User_ID = Session["CompanyId"].ToString();
        if (btnCourierSubmit.Text == "Save")
        {
            Reg.DML = "I";
            function9420.SaveCourierMasterDetail(Reg);
            //DivNewMsg.Visible = true;
            //DivNewMsg.Attributes.Add("class", "alert_boxes_green");
            //lblpopmsg.Text = "Courier <span style='color:blue;' >" + Reg.Courier_Name + "</span> has been registered successfully.";
            // ModalPopupExtenderNewDesign.Show();
            //string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
            // Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
            Response.Redirect("FrmAwardsCourierMaster.aspx");
        }
        else
        {
            Reg.CourierPkid = Convert.ToInt32(lblBankId.Text);
            Reg.DML = "U";
            function9420.SaveCourierMasterDetail(Reg);
            Response.Redirect("FrmAwardsCourierMaster.aspx?edit=s");
         //   newMsg.Visible = true;
         //   newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
         //   lblmsgHeader.Text = "Courier <span style='color:blue;' >" + Reg.Courier_Name + "</span> has beeb updated successfully.";
         //   string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
         //   Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        }
       // Clear();
       // FillGrid();
    }
    protected void btnCourierReset_Click(object sender, EventArgs e)
    {
        //Clear(); newMsg.Visible = false; DivNewMsg.Visible = false;
        //ModalPopupExtenderNewDesign.Show();
        Response.Redirect("FrmAwardsCourierMaster.aspx");
    }
}