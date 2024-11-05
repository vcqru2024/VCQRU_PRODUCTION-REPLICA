using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ZYDEX_dashboardzydex : System.Web.UI.Page
{
    cls_Zydex db = new cls_Zydex();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("~/ZYDEX/Login.aspx");
        if (!IsPostBack)
        {
            bindgrid();
            binddealer();
        }
    }

    public void bindgrid()
    {
        DataTable dt = SQL_DB.ExecuteDataTable("exec USP_GetCodeDistributorsDetails_Zydex");
        if (dt.Rows.Count == 0)
            dt = null;
        rptData.DataSource = dt;
        rptData.DataBind();

    }
    public void binddealer()
    {
        DataTable dtdealer = SQL_DB.ExecuteDataTable("select id,[Dealer Code],[Dealer Name] from Dealerdetailssagar where Isactive=1 and Isdelete=0 and Comp_ID='" + Session["CompanyId"].ToString() + "'");
        if (dtdealer.Rows.Count > 0)
        {
            ddldealer.DataSource = dtdealer;
            ddldealer.DataValueField = "Dealer Code";
            ddldealer.DataTextField = "Dealer Code";
            ddldealer.DataBind();
            ddldealer.Items.Insert(0, new ListItem("--Select Dealer SAP Code--", "0"));
            ddldealer.SelectedIndex = 0;
            ddldealer.Items[0].Attributes["disabled"] = "disabled";
            ddldealer.Enabled = true;
            ddldistributor.DataSource = dtdealer;
            ddldistributor.DataValueField = "Dealer Code";
            ddldistributor.DataTextField = "Dealer Code";
            ddldistributor.DataBind();
            ddldistributor.Items.Insert(0, new ListItem("--Select Dealer SAP Code--", "0"));
            ddldistributor.SelectedIndex = 0;
            ddldistributor.Items[0].Attributes["disabled"] = "disabled";
            ddldistributor.Enabled = true;
        }
    }


    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtfromseries.Text))
        {
            db.ShowErrorMessage(this, "Please Enter code Serial No");
            return;
        }
        else if (!txtfromseries.Text.All(char.IsDigit))
        {
            db.ShowErrorMessage(this, "Please enter only numeric characters");
            clear();
            return;
        }
        else if (string.IsNullOrEmpty(txttoseries.Text))
        {
            db.ShowErrorMessage(this, "Please Enter code Serial No");
            return;
        }
        else if (!txttoseries.Text.All(char.IsDigit))
        {
            db.ShowErrorMessage(this, "Please enter only numeric characters");
            clear();
            return;
        }
        else if (string.IsNullOrEmpty(ddldealer.SelectedItem.Value))
        {
            db.ShowErrorMessage(this, "Please Select Dealer");
            return;
        }
        else if (ddldealer.SelectedItem.Value == "0")
        {
            db.ShowErrorMessage(this, "Please Select Dealer");
            return;
        }
        else
        {
            #region Lable Assign to Distributor Logic
            if (Session["CompanyId"].ToString() == "Comp-1711")
            {
                string Seriesfrom = txtfromseries.Text;
                string Seriesto = txttoseries.Text;
                string DealerID = ddldealer.SelectedItem.Value;
                string DealerNAme = ddldealer.SelectedItem.Text;
                string CompanyId = Session["CompanyId"].ToString();
                DataSet dt1 = SQL_DB.ExecuteDataSet("exec USP_UpdateM_codeZYDEXusingserial 'AM82','" + CompanyId + "','" + ddldealer.SelectedItem.Value + "','" + Seriesfrom + "','" + Seriesto + "' ");
                if (dt1.Tables[0].Rows[0]["Result"].ToString() == "Success")
                {
                    db.ShowSuccessMessagewithredirect(this, " Codes Assign Successfully to " + ddldealer.SelectedItem.Text + " From Serial No " + Seriesfrom + " - " + Seriesto, "../ZYDEX/dashboardzydex.aspx");
                }
                else
                {
                    //DataTable dt = SQL_DB.ExecuteDataTable("exec USP_CHECKDEALDER '" + Seriesfrom + "','" + Seriesto + "'");
                    //if (dt.Rows.Count > 0)
                    //{
                    //    DealerNAme = dt.Rows[0][0].ToString();
                    //}
                   
                   // db.ShowErrorMessage(this, "This serial no " + Seriesfrom + "-" + Seriesto + " already Assign to " + DealerNAme);
                    db.ShowErrorMessage(this, dt1.Tables[0].Rows[0]["Result"].ToString());
                    clear();
                }
            }
            #endregion
        }
    }

    public void clear()
    {
        txtfromseries.Text = "";
        txttoseries.Text = "";
        ddldealer.ClearSelection();
    }
    protected void btnsearch_Click(object sender, EventArgs e)
    {
        if (ddldistributor.SelectedItem.Value == "0")
        {
            db.ShowErrorMessage(this, "Please Select Distributor");
        }
        //else if (string.IsNullOrEmpty(txtfromdate.Text) && string.IsNullOrEmpty(txttodate.Text))
        //{
        //    db.ShowErrorMessage(this, "Please Select Date Range");
        //}
        else
        {
           
         
            //DateTime parsedDatefrom = DateTime.ParseExact(txtfromdate.Text, "dd-MMM-yyyy", System.Globalization.CultureInfo.InvariantCulture);
            //string Datefrom = parsedDatefrom.ToString("yyyy-MM-dd 00:00:00.001");
            //DateTime parsedDate = DateTime.ParseExact(txttodate.Text, "dd-MMM-yyyy", System.Globalization.CultureInfo.InvariantCulture);
            //string DateTO = parsedDate.ToString("yyyy-MM-dd 23:59:59.999");
            string Distributorid = ddldistributor.SelectedItem.Value;
            DataTable dt = SQL_DB.ExecuteDataTable("exec USP_GetCodeDistributorsDetails_Zydex '','','" + Distributorid + "'");
            if (dt.Rows.Count == 0)
                dt = null;
            rptData.DataSource = dt;
            rptData.DataBind();
        }
    }

    protected void ddldistributor_SelectedIndexChanged(object sender, EventArgs e)
    {
       // staticBackdrop.Attributes.Add("Class", "show");
        string distid = ddldealer.SelectedItem.Value;
        if (distid != "0")
        {
            DataTable dtdist = SQL_DB.ExecuteDataTable("select [Dealer Name] from Dealerdetailssagar where [Dealer Code]='"+ distid + "' and Isactive=1 and Isdelete=0");
            if (dtdist.Rows.Count > 0)
            {
                txtdisname.Text = dtdist.Rows[0][0].ToString();
            }
            else
            {
                txtdisname.Text = "";
            }
        }
        else
        {
            txtdisname.Text = "";
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showModal();", true);
    }

    protected void ddldistributor_SelectedIndexChanged1(object sender, EventArgs e)
    {
        string distid = ddldistributor.SelectedItem.Value;
        if (distid != "0")
        {
            DataTable dtdist = SQL_DB.ExecuteDataTable("select [Dealer Name] from Dealerdetailssagar where [Dealer Code]='" + distid + "' and Isactive=1 and Isdelete=0");
            if (dtdist.Rows.Count > 0)
            {
                txtdealernm.Text = dtdist.Rows[0][0].ToString();
            }
            else
            {
                txtdealernm.Text = "";
            }
        }
        else
        {
            txtdealernm.Text = "";
        }
    }
}
