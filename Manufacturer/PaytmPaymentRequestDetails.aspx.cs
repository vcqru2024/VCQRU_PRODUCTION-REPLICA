using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_PaytmPaymentRequestDetails : System.Web.UI.Page
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
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!Page.IsPostBack)
        {
        }
    }

    protected void btnSearchmobile_Click(object sender, ImageClickEventArgs e)
    {
        Binddata();

    }

    private void Binddata()
    {

        

        DataSet dtTrans = new DataSet();

        if (txtmobile.Text != "")
        {
           
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("GetPaytmpaymentRequestDetails", "@MobileNo", txtmobile.Text.Trim());
        }
        else if (ViewState["mobile"] != null && ViewState["mobile"].ToString() != "0"  && ViewState["mobile"].ToString() != "")
        {
            string mobile1 = ViewState["mobile"].ToString();
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("GetPaytmpaymentRequestDetails", "@M_Consumerid", mobile1);
            // DataTable dtcondition = SQL_DB.ExecuteDataTable("select c.M_Consumerid,c.MobileNo,c.ConsumerName,b.TotalPoints,b.ReqDate from M_Consumer c inner join tblWalletBalance b on b.M_Consumerid=c.M_Consumerid where c.M_Consumerid='" + ViewState["mobile"].ToString() + "'");

            ViewState["mobile"] = "";
        }

        else 
        { 
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("GetPaytmpaymentRequestDetails", "@WalletBalance", txtbalance.Text.Trim());
        }
        //  DataSet dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("GetPaytmpaymentRequestDetails", "@WalletBalance", txtbalance.Text.Trim());

        GridView1.DataSource = "";
        if (dtTrans.Tables[0].Rows.Count > 0)
        {
            GridView1.Visible = true;
            GridView1.DataSource = dtTrans.Tables[0];
            GridView1.DataBind();
        }
        else
        {

            GridView1.DataSource = "";
            GridView1.Visible = false;
        }
    }
    protected void btnSearch_Click(object sender, ImageClickEventArgs e)
    {
        Binddata();
    }

    protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox ChkBoxHeader = (CheckBox)GridView1.HeaderRow.FindControl("chkSelectAll");
        foreach (GridViewRow row in GridView1.Rows)
        {
            CheckBox ChkBoxRows = (CheckBox)row.FindControl("chkselected");
            if (ChkBoxHeader.Checked == true)
            {
                ChkBoxRows.Checked = true;
                TextBox txttp = (TextBox)row.FindControl("txttp");
            }
                
            
            else
                ChkBoxRows.Checked = false;
        }
    }

    private void Makepayment(string M_Consumerid, string Mobile,string Cash)
    {
        string CompId = "Comp-1321";
        string CompName = "RUHE";
        string OrderId  = SQL_DB.ExecuteScalar("select (ISNULL(max(orderid),1000))+1 as orderid from [dbo].[paytmtransaction]").ToString();
        string Response = ServiceLogic.Paytm_Cash(Mobile, Cash, OrderId, null, CompName);
        if (Response.Contains("ACCEPTED"))
        {

            SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + CompId + "','" + Mobile + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + M_Consumerid + "'," + Cash + ",'Accepted','" + OrderId + "')");
            SQL_DB.ExecuteNonQuery("insert into BPointsTransaction([Transsctionid],[TotalPoints],[RedeemPoints],[Redeemdate],[RedeemBy],Incash,bpstatus) values(1," + Cash + "," + Cash + ",'" + System.DateTime.Now.ToString("yyyy-MM-dd") + "','" + M_Consumerid + "'," + Cash + ",'Accepted')");
            try
            {
                string Resp = ExecuteNonQueryAndDatatable.checkscalarvalues("Sp_InsupdWalletbalance", Convert.ToInt32(M_Consumerid));
            }
            catch
            {

            }
            string msg = "Successfull .";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Success", "alert('Notification : " + msg + "');window.location='PaytmPaymentRequestDetails.aspx';", true);
        }
        else
        {
            SQL_DB.ExecuteNonQuery("insert into paytmtransaction([compid],mobileno,[pdate],[M_consumerid],Amount,pstatus,orderid) values('" + CompId + "','" + Mobile + "','" + System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "','" + M_Consumerid + "'," + Cash + ",'FAILURE','" + OrderId + "')");

        }
    }
    protected void btnpayall_Click(object sender, EventArgs e)
    {

        string confirmValue = Request.Form["confirm_value"];
        if (confirmValue == "No")
        {
            return;
        }



            CheckBox ChkBoxHeader = (CheckBox)GridView1.HeaderRow.FindControl("chkSelectAll");
        Button btnpayall = (Button)GridView1.HeaderRow.FindControl("btnpayall");
        btnpayall.Visible = false;
        int tp = 0;
       

      

        foreach (GridViewRow row in GridView1.Rows)
        {
            // Only look in data rows, ignore header and footer rows
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox ChkBoxRows = (CheckBox)row.FindControl("chkselected");

                if (ChkBoxHeader.Checked == true)
                {
                   
                    if(ChkBoxRows.Checked)
                    {
                        HiddenField hfM_Consumerid = (HiddenField)row.FindControl("hfM_Consumerid");
                        Label lblMobileNo = (Label)row.FindControl("lblMobileNo");
                        Label lblTotalPoints = (Label)row.FindControl("lblTotalPoints");


                        tp = int.Parse(lblTotalPoints.Text);

                        if (tp >= 200)
                        {
                            
                            Makepayment(hfM_Consumerid.Value, lblMobileNo.Text, lblTotalPoints.Text);
                          
                        }

                        else
                        {
                            //string msg = "Points not avalibale for claim .";
                          //  ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Success", "alert('Notification : " + msg + "');window.location='PaytmPaymentRequestDetails.aspx';", true);

                          
                        }


                      
                    }
                    

                  
                }

            }
        }

        Binddata();
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
     
            string confirmValue = Request.Form["confirm_value"];
        if (confirmValue == "No")
        {
            return;
        }

        if (e.CommandName == "Edit")
        {
            string a = e.CommandArgument.ToString();
            ViewState["mobile"] = a;
        }


            //string message = "";
           else if (e.CommandName == "PayIndivisual")
        {
            int tp = 0;
        
            int rowIndex = Convert.ToInt32(e.CommandArgument);

         
            GridViewRow row = GridView1.Rows[rowIndex];

            HiddenField hfM_Consumerid = (HiddenField)row.FindControl("hfM_Consumerid");
            HiddenField hftotalpoint = (HiddenField)row.FindControl("hftotalpoint");
            Label lblMobileNo = (Label)row.FindControl("lblMobileNo");
            TextBox txtTotalPoints = (TextBox)row.FindControl("txtTotalPoints");
       
            tp = Convert.ToInt32(txtTotalPoints.Text);

           

            string confirmValue2 = Request.Form["confirm_value"];
            if (confirmValue2 == "No")
            {
                return;
            }
            int Actualpoint = Convert.ToInt32(hftotalpoint.Value);

                if (Actualpoint > 0)
            {
                if (Actualpoint >= tp)
                {
                    Button btnpay = (Button)row.FindControl("btnpay");
                    btnpay.Visible = false;
                    Makepayment(hfM_Consumerid.Value, lblMobileNo.Text, txtTotalPoints.Text);
                    Binddata();
                }
                else
                {
                    string msg = "Sufficient point is not available for claim.";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Success", "alert('Notification : " + msg + "');window.location='PaytmPaymentRequestDetails.aspx';", true);
                }
            }
            else
            {
                string msg = "Sufficient point is not available for claim.";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Success", "alert('Notification : " + msg + "');window.location='PaytmPaymentRequestDetails.aspx';", true);
            }


            




        }
      
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        Binddata();
    }

    protected void btn_download_Click(object sender, EventArgs e)
    {
       
        if (Page.IsValid)
        {
            try
            {
                DataSet dtTrans = new DataSet();
                
                if(txtmobile.Text !="")
                    dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("GetPaytmpaymentRequestDetails", "@MobileNo", txtmobile.Text.Trim());
                else
                    dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("GetPaytmpaymentRequestDetails", "@WalletBalance", txtbalance.Text.Trim());

                GridView1.DataSource = "";
                if (dtTrans.Tables[0].Rows.Count > 0)
                {
                    if (dtTrans.Tables[0].Columns.Contains("M_Consumerid"))
                        dtTrans.Tables[0].Columns.Remove("M_Consumerid");

                    XLWorkbook wb = new XLWorkbook();
                    wb.Worksheets.Add(dtTrans.Tables[0], "User_details");
                    MemoryStream stream = new MemoryStream();
                    wb.SaveAs(stream);
                    Response.Clear();
                    Response.ContentType = "application/force-download";
                    Response.AddHeader("content-disposition", "attachment;    filename=Paytmpaymentrequest.xlsx");
                    Response.BinaryWrite(stream.ToArray());
                    Response.End();

                    
                }
                



                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //Label lblMobileNo = (Label) FindControl("lblMobileNo");
        
        GridView1.EditIndex = e.NewEditIndex;
        GridView1.DataBind();
         GridView1.Visible = true;
        Binddata();

    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        
        GridView1.EditIndex = -1;
        GridView1.DataBind();
        GridView1.Visible = true;
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
        if (e.Row.RowIndex == GridView1.EditIndex)
        {
            Label lblTotalPoints = e.Row.FindControl("lblTotalPoints") as Label;
            
            TextBox txtTotalPoints = e.Row.FindControl("txtTotalPoints") as TextBox;
            Label mob= e.Row.FindControl("lblMobileNo") as Label;

            if (lblTotalPoints != null)
            {
                
                
                txtTotalPoints.Text = lblTotalPoints.Text;
            }
            

        }
    }

    public void bindgd()
    {

    }
}