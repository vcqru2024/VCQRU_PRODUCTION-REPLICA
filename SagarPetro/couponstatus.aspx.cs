using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SagarPetro_couponstatus : System.Web.UI.Page
{
    cls_message msg = new cls_message();
    private static DbCommand dbCommand;
    private static Database database = DatabaseFactory.CreateDatabase();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../SagarPetro/Loginpfl.aspx");
    }

    
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        string Code1 = textcodeone.Text.Trim();
        string Code2 = textcodeTwo.Text.Trim();
        string Series = txtseries.Text.Trim();

        if (!string.IsNullOrEmpty(Code1) && !string.IsNullOrEmpty(Code2))
        {
            if (Code1.Length != 5)
            {
                msg.ShowErrorMessage(this, "Please enter valid code");
                return;
            }
            if (Code2.Length != 8)
            {
                msg.ShowErrorMessage(this, "Please enter valid code");
                return;
            }
            DataSet dtdealer = Codestatusbycode(Code1, Code2, Session["CompanyId"].ToString());
            if (dtdealer.Tables[0].Rows.Count >0)
            {
                psnproductname.InnerText = dtdealer.Tables[0].Rows[0]["Pro_Name"].ToString();
                spnpoint.InnerText = dtdealer.Tables[0].Rows[0]["Point"].ToString();
                spncash.InnerText = dtdealer.Tables[0].Rows[1]["Cash"].ToString();
                spnstatus.InnerText = dtdealer.Tables[0].Rows[0]["CodeStatus"].ToString();
                GrdCodeEnquiry.DataSource = dtdealer.Tables[1];
                GrdCodeEnquiry.DataBind();
            }
            else
            {
                msg.ShowErrorMessage(this, "Invalid Code");
                textcodeone.Text = "";
                 textcodeTwo.Text= "";
                return;
            }
            if (GrdCodeEnquiry.Rows.Count > 0)
                GrdCodeEnquiry.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
        else if (string.IsNullOrEmpty(Code1) && string.IsNullOrEmpty(Code2) && !string.IsNullOrEmpty(Series))
        {
            if (Series.Length != 14)
            {
                msg.ShowErrorMessage(this, "Please enter valid series no");
                return;
            }
            string Proid = Series.Substring(0, 4).ToString();
            string Series_Order = Series.Substring(5, 4).ToString();
            string Series_Serial = Series.Substring(10, 4).ToString();
            DataSet dtdealer = Codestatusbyserial(Proid, Series_Order, Series_Serial, Session["CompanyId"].ToString());
           
            if (dtdealer.Tables[0].Rows.Count >0)
            {
                psnproductname.InnerText = dtdealer.Tables[0].Rows[0]["Pro_Name"].ToString();
                spnpoint.InnerText = dtdealer.Tables[0].Rows[0]["Point"].ToString();
                spncash.InnerText = dtdealer.Tables[0].Rows[1]["Cash"].ToString();
                spnstatus.InnerText = dtdealer.Tables[0].Rows[0]["CodeStatus"].ToString();
                GrdCodeEnquiry.DataSource = dtdealer.Tables[1];
                GrdCodeEnquiry.DataBind();
            }
            else
            {
                msg.ShowErrorMessage(this, "Invalid series no");
                return;
            }
            if (GrdCodeEnquiry.Rows.Count > 0)
                GrdCodeEnquiry.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
        else
        {
            msg.ShowErrorMessage(this,"Please Enter code or Series");
            GrdCodeEnquiry.DataSource = "";
            GrdCodeEnquiry.DataBind();
        }
    }

    public static DataSet Codestatusbycode(string Code1, string Code2,string CompId)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("USP_Codestatus_sp");
            database.AddInParameter(dbCommand, "@Code1", DbType.String, Code1);
            database.AddInParameter(dbCommand, "@Code2", DbType.String, Code2);
            database.AddInParameter(dbCommand, "@compId", DbType.String, CompId);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public static DataSet Codestatusbyserial(string Proid, string seriesorder, string seriessireal,string compId)
    {
        try
        {
            dbCommand = database.GetStoredProcCommand("USP_Codestatusbyserial_sp");
            database.AddInParameter(dbCommand, "@Pro_ID", DbType.String, Proid);
            database.AddInParameter(dbCommand, "@Series_Order", DbType.String, seriesorder);
            database.AddInParameter(dbCommand, "@Series_Serial", DbType.String, seriessireal);
            database.AddInParameter(dbCommand, "@compId", DbType.String, compId);
            return database.ExecuteDataSet(dbCommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        textcodeone.Text = "";
        textcodeTwo.Text = "";
        txtseries.Text = "";
        GrdCodeEnquiry.DataSource = "";
        GrdCodeEnquiry.DataBind();
    }
}