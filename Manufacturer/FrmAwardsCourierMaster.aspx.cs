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
using System.Web.Services;
using System.Web.Script.Services;

public partial class FrmAwardsCourierMaster : System.Web.UI.Page
{
    public int Flag=0,index=0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("../Info/Login.aspx?Page=FrmAwardsCourierMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }  
        if (!Page.IsPostBack)
        {
            hdncmphdn.Value = ProjectSession.strCompanyid;// Session["CompanyId"].ToString();
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));                       
            //newMsg.Visible = false;DivNewMsg.Visible = false;
            lblmsgHeader.Text = "";           
            FillGrid();
        }
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
        Clear();
        newMsg.Visible = false; DivNewMsg.Visible = false;
        ModalPopupExtenderNewDesign.Show();
    }

    private void Clear()
    {
        //txtAddress.Text = "";
        //txtContactNo.Text = "";
        //txtCourierEmail.Text = "";
        //txtCourierName.Text = "";
        //lblAddCourierHeader.Text = "Add New Courier";
        //btnCourierSubmit.Text = "Save";        
    }

    protected void BtnSearchCourier_Click(object sender, ImageClickEventArgs e)
    {
        FillGrid();
        newMsg.Visible = false;
    }

    protected void BtnSearchCourierRefesh_Click(object sender, ImageClickEventArgs e)
    {
        txtSearchName.Text = "";
        FillGrid();
        newMsg.Visible = false;
    }

    private void FillGrid()
    {
        DataSet DsGrd = new DataSet();

        DsGrd = Business9420.function9420.FillCourierDataGrid(txtSearchName.Text.Trim(), ProjectSession.strCompanyid);
        if (DsGrd.Tables.Count > 0)
        {
            GrdCourier.DataSource = DsGrd.Tables[0];
            GrdCourier.DataBind();
            lblcount.Text = DsGrd.Tables[0].Rows.Count.ToString();
            if (GrdCourier.Rows.Count > 0)
                GrdCourier.HeaderRow.TableSection = TableRowSection.TableHeader;

        }
        else
            lblcount.Text = "0";
    }
    protected void GrdCourier_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdCourier.PageIndex = e.NewPageIndex;
        FillGrid();
    }
    protected void GrdCourier_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Object9420 Reg = new Object9420();
        lblBankId.Text = e.CommandArgument.ToString();
        Reg.CourierPkid =Convert.ToInt32(lblBankId.Text); newMsg.Visible = false;
        function9420.GetCourierInfo(Reg);
        if (e.CommandName.ToString() == "CourierEdit")
        {
            Response.Redirect("AddCourier.aspx?id=" + e.CommandArgument.ToString());
            //txtCourierName.Text = Reg.Courier_Name;
            //txtCourierEmail.Text = Reg.Courier_Email;
            //txtContactNo.Text = Reg.Courier_Mobile;
            //txtAddress.Text = Reg.Courier_Address;
            //lblAddCourierHeader.Text = "Courier update Details";
            //btnCourierSubmit.Text = "Update";            
            //ModalPopupExtenderNewDesign.Show();
        }
        else if (e.CommandName.ToString() == "CourierDelete")
        {                    
            //LabelAlertheader.Text = "Alert";
            //LabelAlertText.Text = "Are you sure to dalete  <span style='color:blue;' >" + Reg.Courier_Name + "</span>  Courier Company permanently?";        
           // ModalPopupExtenderAlert.Show();
           // function9420.DeleteCourierDetail(Reg);
           // FillGrid();
        }
    }
    protected void btnNoActivation_Click(object sender, EventArgs e)
    {

    }
    protected void btnYesActivation_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        Reg.CourierPkid = Convert.ToInt32(lblBankId.Text);
     //   function9420.GetCourierInfo(Reg);
        function9420.DeleteCourierDetail(Reg);
        newMsg.Visible = true;
        newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        lblmsgHeader.Text = "Courier <span style='color:blue;' >" + Reg.Courier_Name + "</span> has benn deleted  successfully.";
        FillGrid();
        string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
    }
    protected void btnCourierSubmit_Click(object sender, EventArgs e)
    {
        //Object9420 Reg = new Object9420();
        //Reg.Courier_Name = txtCourierName.Text.Trim().Replace("'", "''");
        //Reg.Courier_Email = txtCourierEmail.Text.Trim().Replace("'", "''");
        //Reg.Courier_Address = txtAddress.Text.Trim().Replace("'", "''");
        //Reg.Courier_Mobile = txtContactNo.Text.Trim().Replace("'", "''");
        //Reg.User_ID = Session["CompanyId"].ToString();
        //if (btnCourierSubmit.Text == "Save")
        //{
        //    Reg.DML = "I";
        //    function9420.SaveCourierMasterDetail(Reg);
        //    DivNewMsg.Visible = true;
        //    DivNewMsg.Attributes.Add("class", "alert_boxes_green");
        //    lblpopmsg.Text = "Courier <span style='color:blue;' >" + Reg.Courier_Name + "</span> has been registered successfully.";            
        //    ModalPopupExtenderNewDesign.Show();
        //    string script = @"setTimeout(function(){document.getElementById('" + DivNewMsg.ClientID + "').style.display='none';},5000);";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //}
        //else
        //{
        //    Reg.CourierPkid = Convert.ToInt32(lblBankId.Text);
        //    Reg.DML = "U";
        //    function9420.SaveCourierMasterDetail(Reg);
        //    newMsg.Visible = true;
        //    newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        //    lblmsgHeader.Text = "Courier <span style='color:blue;' >" + Reg.Courier_Name + "</span> has beeb updated successfully.";            
        //    string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //}
        //Clear();
        //FillGrid();
    }
    protected void btnCourierReset_Click(object sender, EventArgs e)
    {
        Clear(); newMsg.Visible = false; DivNewMsg.Visible = false;
        ModalPopupExtenderNewDesign.Show();
    }

    protected void imgNew_Click1(object sender, EventArgs e)
    {
        Response.Redirect("AddCourier.aspx");
    }
}
