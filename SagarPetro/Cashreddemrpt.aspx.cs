using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class SagarPetro_Cashreddemrpt : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        bindclaim();
    }
    public void bindclaim()
    {
        DataTable dtclaim = SQL_DB.ExecuteDataTable("select pdate,mobileno,Amount,pstatus,orderid,Comment,AccountNo,AccountHolderName,IFSCCode from paytmtransaction where compId='"+ Session["CompanyId"].ToString() + "' and pstatus='Pending'");
        if (dtclaim.Rows.Count > 0)
        {
            gvNewUser.DataSource = dtclaim;
            gvNewUser.DataBind();
        }
    }
}