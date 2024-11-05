using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SagarPetro_Redemption_rpt : System.Web.UI.Page
{
    cls_message db = new cls_message();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../SagarPetro/Loginpfl.aspx? page = redemtionrpt");

    }




    protected void btnsearch_Click(object sender, EventArgs e)
    {

        if (string.IsNullOrEmpty(txtmobile.Text.Trim()) || txtmobile.Text.Trim().Length != 10 || !txtmobile.Text.Trim().All(char.IsDigit))
        {
            db.ShowErrorMessage(this, "Please Enter a Valid 10-digit Mobile Number");
            return;
        }
        else
        {
            try
            {
                DataTable dtuser = SQL_DB.ExecuteDataTable("exec USP_Redeemtionrpt_SP '" + Session["CompanyId"].ToString() + "','" + txtmobile.Text.Trim() + "'");
                if (dtuser.Rows.Count > 0)
                {
                    rptData.DataSource = dtuser;
                    rptData.DataBind();
                }
                else
                {
                    rptData.DataSource = null;
                    rptData.DataBind();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}