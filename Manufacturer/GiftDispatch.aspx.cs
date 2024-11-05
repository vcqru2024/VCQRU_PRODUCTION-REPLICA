using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business9420;
using System.Web.Services;

public partial class Manufacturer_GiftDispatch : System.Web.UI.Page
{
    public string strTrackingNo { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("../Info/Login.aspx?Page=FrmAwardCourierDispatch.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
           // strTrackingNo = 
            //FillCourierCompany();
            //FillGrdMain();
            //Session["LBLInfo"] = LabelDataTableInfo;
            //Session["LBLInfoEdit"] = LabelDataTableInfoEdit;
            //Session["ProID"] = "";
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Manufacturer/FrmAwardCourierDispatch.aspx");

    }

    [WebMethod]
    public static string MethodChkTrackingNo()
    {

        string result = function9420.GetTrackingId_New("Tracking No");
        return result;
    }
}