using Business_Logic_Layer;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_frmgiftDispatch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
        {
            Response.Redirect("/Login.aspx");
            //Response.Redirect("default.aspx?Page=frmManfEnquiry.aspx");
        }
        else
        {
            string comp_ID = Convert.ToString(Session["CompanyId"]);
            GetDispatchCourier(comp_ID);


        }
        tick.Visible = false;
        lblsuccess.Visible = false;
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        //Allows for printing
    }

    private void GetDispatchCourier(string comp_ID)
    {
        try
        {

            DataSet ds = SQL_DB.ExecuteDataSet("select Mobile_No,Gift_Name,convert(date,DispatchDate) DispatchDate,Dispatch_location,Courier_Name,Tracking_No,Comments from tbl_Gift_Dispatch where Comp_ID = '" + comp_ID + "'");
            if (ds.Tables[0].Rows.Count > 0)
            {
                //LblMsg.Visible = true;
                //LblMsg.Text = "Updated successfully";
                //LblMsg.ForeColor = System.Drawing.Color.Green;
                GridView1.DataSource = ds.Tables[0];
                GridView1.DataBind();
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;

            }
            else
            {
                GridView1.DataSource = "";
                GridView1.DataBind();

            }

        }
        catch (Exception ex)
        {

            throw;
        }
    }

    protected void ShowPopup(object sender, EventArgs e)
    {
        string comp_ID = Convert.ToString(Session["CompanyId"]);
        FillMobile(comp_ID);
        FillGift(comp_ID);
        ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup();", true);
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Session["registration"] = "false";
    }


    protected void btnsavecourier_Click(object sender, EventArgs e)
    {
        Page.Validate("PR1");
        bool vldt = Page.IsValid;


        if (vldt)
        {
            registeruser();
            string comp_ID = Convert.ToString(Session["CompanyId"]);
            GetDispatchCourier(comp_ID);
            Session["registration"] = "True";

        }

        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showAgainModal();", true);
    }

    private void registeruser()
    {

        tbl_Gift_Dispatch Log = new tbl_Gift_Dispatch();

        string qSQL1 = "select 'x' from tbl_Gift_Dispatch where tracking_no='" + txtTrackingNo.Text + "'";

        DataTable ddt1 = SQL_DB.ExecuteDataSet(qSQL1).Tables[0];
        if (ddt1.Rows.Count == 0)
        {


            Log.Comp_ID = Session["CompanyId"].ToString();
            Log.Mobile_No = ddlMobileNo.SelectedItem.Text;
            Log.M_consumerID = Convert.ToInt32(ddlMobileNo.SelectedItem.Value);
            Log.Gift_Name = ddlGiftName.SelectedItem.Text;
            Log.DispatchDate = Convert.ToDateTime(txtDispatchDate.Text);
            Log.Tracking_No = txtTrackingNo.Text;
            Log.Comments = txtComments.Text;
            Log.Courier_Name = txtCourierCom.Text;
            Log.Dispatch_location = txtlocation.Text;



            SQL_DB.ExecuteNonQuery("insert into tbl_Gift_Dispatch(M_consumerID,Mobile_No,Gift_Name,DispatchDate, Dispatch_location, Courier_Name, Tracking_No, Comments, Comp_ID, CreatedDate) values(" + Log.M_consumerID + ", '" + Log.Mobile_No + "', '" + Log.Gift_Name + "', '" + Log.DispatchDate.ToString("yyyy-MM-dd hh:mm:ss.fff") + "', '" + Log.Dispatch_location + "', '" + Log.Courier_Name + "', '" + Log.Tracking_No + "', '" + Log.Comments + "', '" + Log.Comp_ID + "', '" + System.DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss.fff") + "') ");

            SQL_DB.ExecuteNonQuery("update ClaimDetails set issent=1 where Mobileno= '91" + Log.Mobile_No + "' and Isapproved=1 and issent=0");

            ddlMobileNo.SelectedItem.Selected = false;
            ddlGiftName.SelectedItem.Selected = false;
            txtDispatchDate.Text = "";
            txtTrackingNo.Text = "";
            txtCourierCom.Text = "";
            txtlocation.Text = "";
            txtComments.Text = "";

            tick.Visible = true;
            lblsuccess.Visible = true;
        }
        else
        {
            tick.Visible = false;
            RequiredFieldValidator4.IsValid = false;
            RequiredFieldValidator4.ErrorMessage = "Tracking No Already Exists";
            // RegExpValMobNo.Display=

            lblsuccess.Visible = false;

        }


    }


    protected void button_export(object sender, EventArgs e)
    {
        ExportGridToExcel();
    }
    private void ExportGridToExcel()
    {
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = "Gift_Dispatched_Report" + DateTime.Now + ".xls";
        StringWriter strwritter = new StringWriter();
        HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
        GridView1.GridLines = GridLines.Both;
        GridView1.HeaderStyle.Font.Bold = true;
        GridView1.RenderControl(htmltextwrtter);
        Response.Write(strwritter.ToString());
        Response.End();

    }




    private void FillMobile(string Comp_ID)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("select  mc.M_Consumerid , right(cd.Mobileno,10)Mobileno from ClaimDetails cd  left join M_Consumer mc on right(mc.MobileNo, 10) = right(cd.Mobileno, 10) where cd.Comp_id = '" + Comp_ID + "' and Isapproved = 1 and issent=0");
        if (ds.Tables[0].Rows.Count > 0)
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString1(ds, "M_Consumerid", "Mobileno", ddlMobileNo, "--Select--");
        ddlMobileNo.SelectedIndex = 0;
    }
    private void FillGift(string Comp_ID)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("select gift_id,Gift_desc from Claim_gift where CompID='" + Comp_ID + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString1(ds, "gift_id", "Gift_desc", ddlGiftName, "--Select--");
            ddlGiftName.SelectedIndex = 0;
        }
        else
        {
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString1(ds, "gift_id", "Gift_desc", ddlGiftName, "--Select--");
        }

    }

}