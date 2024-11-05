using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Business9420;
using System.Data;

public partial class ClientTestimonialMaster : System.Web.UI.Page
{
    public int index = 0,sno=0,Flag=0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=ClientTestimonialMaster.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!Page.IsPostBack)
        {            
            txtTestimonial.Text = string.Empty;
            FillData();
        }
    }
    private void FillData()
    {
        DataSet ds = new DataSet();
        Object9420 Reg = new Object9420();
        if ((txtDateFrom.Text != "") && (txtDateFrom.Text != ""))
            Reg.statusstr = " AND CONVERT(VARCHAR,Entry_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,Entry_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        else if ((txtDateFrom.Text != "") && (txtDateFrom.Text == ""))
            Reg.statusstr = " AND CONVERT(VARCHAR,Entry_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "' ";
        else if ((txtDateFrom.Text == "") && (txtDateFrom.Text != ""))
            Reg.statusstr = " AND CONVERT(VARCHAR,Entry_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "' ";
        if (Session["User_Type"] != null)
        {
            if (Session["User_Type"].ToString() != "Admin")
                Reg.Comp_ID = Session["CompanyId"].ToString();
            else
                Reg.Comp_ID = "";
        }
        ds = function9420.FillTestimonial(Reg);
        if (Convert.ToInt32(ddlRowProductCnt.SelectedValue) > 999)
            GrdVwTestimonial.PageSize = ds.Tables[0].Rows.Count;
        else
            GrdVwTestimonial.PageSize = Convert.ToInt32(ddlRowProductCnt.SelectedValue);
        GrdVwTestimonial.DataSource = ds.Tables[0];
        GrdVwTestimonial.DataBind();
        lblcount.Text = ds.Tables[0].Rows.Count.ToString();        
    }    
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        NewMsgpop.Visible = false;
        txtDateFrom.Text = ""; txtDateTo.Text = ""; txtTestimonial.Text = ""; FillData();
    }

    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        NewMsgpop.Visible = false;
        FillData();
    }

    protected void ddlRowsShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        NewMsgpop.Visible = false;
        FillData();
    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        txtTestimonial.Text = string.Empty;
        Doc1.Visible = false;
        Doc2.Visible = false;
        lblheading.Text = "Add New Testimonial";
        btnsave.Text = "Save";
        ModalPopupTestimonial.Show();
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {        
        Object9420 Reg = new Object9420();
        Reg.Testimonial_ID = function9420.GetLabelCode("User-Testimonial");
        Reg.Testimonial_Text = txtTestimonial.Text.Trim().Replace("'","''");
        Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.Act_Flag = 0;
        Reg.Con_Flag = 0;
        Reg.Del_Flag = 0;
        Reg.Comp_ID = Session["CompanyId"].ToString();
        if (btnsave.Text == "Save")
            Reg.DML = "I";
        else
            Reg.DML = "U";        
        #region Save Files
        string path = "", filename = "";
        if (FileUpload1.HasFile)
        {
            path = Server.MapPath("../Data/Sound") + "\\Testimonial\\" + Reg.Comp_ID.ToString().Substring(5, 4);
            DataProvider.Utility.CreateDirectory(path);
            filename = FileUpload1.FileName;
            int lindex = filename.LastIndexOf('.');
            string ext = filename.Substring(lindex, filename.Length - lindex);
            filename = "Img1_" + (Reg.Testimonial_ID).ToString() + ext;
            path = path + "\\" + filename;
            FileUpload1.SaveAs(path);
            Reg.Img1 = filename;
        }
        if (FileUpload2.HasFile)
        {
            path = Server.MapPath("../Data/Sound") + "\\Testimonial\\" + Session["CompanyId"].ToString().Substring(5, 4);

            filename = FileUpload2.FileName;
            int lindex = filename.LastIndexOf('.');
            string ext = filename.Substring(lindex, filename.Length - lindex);
            filename = "Img2_" + (Reg.Testimonial_ID).ToString() + ext;
            path = path + "\\" + filename;
            FileUpload2.SaveAs(path);
            Reg.Img2 = filename;
        }
        function9420.InsertTestimonialData(Reg);
        #endregion
        function9420.UpdateLabelCode("User-Testimonial");
        //NewMsgpop.Visible = true;
        //NewMsgpop.Attributes.Add("class", "alert_boxes_green big_msg");  
        //Label2.Text = "Your request has been submited successfully...!";
        //string script = @"setTimeout(function(){document.getElementById('" + NewMsgpop.ClientID + "').style.display='none';},5000);";
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        lblloginName.Text = SQL_DB.ExecuteScalar("SELECT [Comp_Name] FROM [Comp_Reg] where [Comp_ID] = '" + Session["CompanyId"].ToString() + "'").ToString();
        lblloginName.Text = "Your request has been submited successfully."; // <span style='color:blue;'>" + lblloginName.Text + "</span> 
        ModalPopupMessage.Show();
        txtTestimonial.Text = string.Empty;
        FillData();
    }
    protected void btnreset_Click(object sender, EventArgs e)
    {
        txtTestimonial.Text = string.Empty;
        txtTestimonial.Text = string.Empty;
        Doc1.Visible = false;
        Doc2.Visible = false;
        lblheading.Text = "Add New Testimonial";
        btnsave.Text = "Save";
        ModalPopupTestimonial.Show();
    }
    protected void GrdVwTestimonial_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdVwTestimonial.PageIndex = e.NewPageIndex;
        FillData();
    }
    protected void GrdVwTestimonial_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        txtTestimonial.Text = string.Empty;
        NewMsgpop.Visible = false;
        lblid.Text = e.CommandArgument.ToString();
        Object9420 Reg = new Object9420();
        Reg.Testimonial_ID = e.CommandArgument.ToString();
        DataSet ds = function9420.FillTestimonial(Reg);
        if (e.CommandName == "EditRow")
        {            
            txtTestimonial.Text = ds.Tables[0].Rows[0]["Testimonial"].ToString();
            Doc1.Visible = true;
            Doc2.Visible = true;
            Doc1.HRef = ds.Tables[0].Rows[0]["f1"].ToString();
            Doc2.HRef = ds.Tables[0].Rows[0]["f2"].ToString();
            lblheading.Text = "Update Testimonial";
            btnsave.Text = "Update";
            ModalPopupTestimonial.Show();            
        }
        else if (e.CommandName == "Confirm")
        {
            Reg.chkstr = "Confirm";
            Reg.Flag = Convert.ToInt32(ds.Tables[0].Rows[0]["Con_Flg"].ToString());
            function9420.UpdateTestimonial(Reg);
        }
        else if (e.CommandName == "Reject")
        {
            Reg.chkstr = "Reject";
            Reg.Flag = Convert.ToInt32(ds.Tables[0].Rows[0]["Del_Flg"].ToString());
            function9420.UpdateTestimonial(Reg);
        }
        else if (e.CommandName == "ChangeStatus")
        {
            Reg.chkstr = "ChangeStatus";
            Reg.Flag = Convert.ToInt32(ds.Tables[0].Rows[0]["Act_Flg"].ToString());
            function9420.UpdateTestimonial(Reg);
        }
        FillData();
    }
}