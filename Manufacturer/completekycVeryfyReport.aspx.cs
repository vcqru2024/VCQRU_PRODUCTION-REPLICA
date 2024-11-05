using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using ClosedXML.Excel;
using System;


public partial class Manufacturer_completekycVeryfyReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {


        }
    }

    protected void btn_download_Click_drpdown(object sender, EventArgs e)
    {

        if (Page.IsValid)
        {
            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                string qrystr = "select  top 50 mc.MobileNo,mc.ConsumerName,mc.Entry_Date, bnk.AccountHolderName,case when bnk.IsBankAccountVerify='true' then 'Success' else 'Failure' end bankStatus,bnk.AccountNo as AccNo,bnk.IFSC_Code,bnk.BankReqdate,bnk.BankRemarks,pandt.PanName,pandt.InputPanName,pandt.pancardNumber,case when pandt.IspanVerify='true' then 'Success' else 'Failure' end panStatus,pandt.PanReqdate,pandt.PanRemarks,adhr.AadharName,adhr.AadharNo,case when adhr.IsaadharVerify='true' then 'Success' else 'Failure' end aadharStatus,adhr.AadharReqdate,adhr.AadharRemarks " +
                       "from M_Consumer mc right " +
                       "join tblKycBankDataDetails bnk on bnk.M_Consumerid = mc.M_Consumerid right join tblKycPanDataDetails pandt on pandt.M_Consumerid = mc.M_Consumerid right join tblKycAadharDataDetails adhr on adhr.M_Consumerid = mc.M_Consumerid " +
                       " order by pandt.PanReqdate desc ";
                SqlCommand cmd = new SqlCommand(qrystr, con);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();

                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "User_KycCompleteKycReport");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=User_CompleteKycdetails.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }



    protected void ViewReport(object sender, EventArgs e)
    {

    }
    protected void btn_download_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {

            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();

                string datefromstr = string.Empty;
                string datetostr = string.Empty;

                string qrystr = "";



                if (txtDateFrom.Text != "")
                {
                    datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
                }
                if (txtDateto.Text != "")
                {
                    datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
                }


                if (txtDateFrom.Text != "" && txtDateto.Text != "")
                {
                    qrystr = "select  top 50 mc.MobileNo,mc.ConsumerName,mc.Entry_Date, bnk.AccountHolderName,case when bnk.IsBankAccountVerify='true' then 'Success' else 'Failure' end bankStatus,bnk.AccountNo as AccNo,bnk.IFSC_Code,bnk.BankReqdate,bnk.BankRemarks,pandt.PanName,pandt.InputPanName,pandt.pancardNumber,case when pandt.IspanVerify='true' then 'Success' else 'Failure' end panStatus,pandt.PanReqdate,pandt.PanRemarks,adhr.AadharName,adhr.AadharNo,case when adhr.IsaadharVerify='true' then 'Success' else 'Failure' end aadharStatus,adhr.AadharReqdate,adhr.AadharRemarks " +
                        "from M_Consumer mc right " +
                        "join tblKycBankDataDetails bnk on bnk.M_Consumerid = mc.M_Consumerid right join tblKycPanDataDetails pandt on pandt.M_Consumerid = mc.M_Consumerid right join tblKycAadharDataDetails adhr on adhr.M_Consumerid = mc.M_Consumerid " +
                        "where pandt.PanReqdate >= '" + datefromstr + "' and pandt.PanReqdate <= '" + datetostr + "' order by pandt.PanReqdate desc ";
                }

                SqlCommand cmd = new SqlCommand(qrystr, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();

                XLWorkbook wb = new XLWorkbook();
                wb.Worksheets.Add(dt, "User_KycCompleteKycReport");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment; filename=User_CompleteKycdetails.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

    protected void ImgSearch_Click(object sender, EventArgs e)
    {
        string datefromstr = string.Empty;
        string datetostr = string.Empty;
        string qrystr = "";
        if (txtDateFrom.Text != "")
        {
            datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
        }
        if (txtDateto.Text != "")
        {
            datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
        }


        if (txtDateFrom.Text == "" && txtDateto.Text == "")
        {
            Response.Redirect("completekycVeryfyReport.aspx");
        }


        if (txtDateFrom.Text != "" && txtDateto.Text != "")
        {
            qrystr = "select  top 50 mc.MobileNo,mc.ConsumerName,mc.Entry_Date, bnk.AccountHolderName,case when bnk.IsBankAccountVerify='true' then 'Success' else 'Failure' end bankStatus,bnk.AccountNo as AccNo,bnk.IFSC_Code,bnk.BankReqdate,bnk.BankRemarks,pandt.PanName,pandt.InputPanName,pandt.pancardNumber,case when pandt.IspanVerify='true' then 'Success' else 'Failure' end panStatus,pandt.PanReqdate,pandt.PanRemarks,adhr.AadharName,adhr.AadharNo,case when adhr.IsaadharVerify='true' then 'Success' else 'Failure' end aadharStatus,adhr.AadharReqdate,adhr.AadharRemarks " +
                       "from M_Consumer mc right " +
                       "join tblKycBankDataDetails bnk on bnk.M_Consumerid = mc.M_Consumerid right join tblKycPanDataDetails pandt on pandt.M_Consumerid = mc.M_Consumerid right join tblKycAadharDataDetails adhr on adhr.M_Consumerid = mc.M_Consumerid " +
                       "where pandt.PanReqdate >= '" + datefromstr + "' and pandt.PanReqdate <= '" + datetostr + "' order by pandt.PanReqdate desc ";

        }


        if (Page.IsValid)
        {
            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                //DataTable newdt = SQL_DB.ExecuteDataTable("select ref_cin_number from M_Consumer where M_Consumerid='10745'");
                ///string ssss = qrystr
                SqlCommand cmd = new SqlCommand(qrystr, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                grd1.DataSource = dt;
                grd1.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
    }

    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("completekycVeryfyReport.aspx");
    }



    protected void grd1_PageIndexChanged(object sender, EventArgs e)
    {

    }
}