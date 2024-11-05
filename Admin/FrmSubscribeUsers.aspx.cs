using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Business9420;
using System.Web.Services;
using System.Web.Script.Services;
using System.IO;

public partial class FrmSubscribeUsers : System.Web.UI.Page
{
    public int str = 0, strr = 0,lflag =0; public int index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {        
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmSubscribeUsers.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {
            FillGrdLabel();
            newMsg.Visible = false;
            lblcount.Text = "0"; 
        }
        Label2.Text = "";
    }    
    private void FillGrdLabel()
    {        
        Object9420 Reg = new Object9420();
        Reg.Email = txtsearchlblname.Text.Trim().Replace("'","''");
        DataSet ds = function9420.GetNewsLettersEmailSearch(Reg);        
        GrdLabel.DataSource = ds.Tables[0];
        GrdLabel.DataBind();
        lblcount.Text = GrdLabel.Rows.Count.ToString();         
    }           
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        newMsg.Visible = false;
        FillGrdLabel();
    }
    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtsearchlblname.Text = string.Empty;        
        FillGrdLabel();
    }    
    protected void GrdLabel_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {       
        GrdLabel.PageIndex = e.NewPageIndex;
        FillGrdLabel();
    }    
}