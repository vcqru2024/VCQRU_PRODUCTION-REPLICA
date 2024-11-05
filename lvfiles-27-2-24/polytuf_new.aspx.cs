using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class polytuf_new : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["ID"] == "1")
        {
            HdnID.Value = Request.QueryString["ID"];
        }


        else if (Request.QueryString["ID"] == "polytuf")
        {
            HdnID.Value = Request.QueryString["ID"];
            HdnCode1.Value = Request.QueryString["codeone"];
            HdnCode2.Value = Request.QueryString["codetwo"];
            CompName.Value = Request.QueryString["Comp"];

        }


        DataTable table = SQL_DB.ExecuteDataTable("select top 1 max(bl.M_Consumerid),sum(Points) Points,M_Consumer.ConsumerName from BLoyaltyPointsEarned bl inner join BuiltLoyaltyMCodeCheck blm on blm.Pkid = bl.BuildLoyaltyOrReferralMCodeCheckid inner join M_Consumer_M_Code mc on mc.M_Consumer_MCodeid = blm.M_Consumer_MCOdeid inner join M_Consumer on M_Consumer.M_Consumerid = bl.M_Consumerid where mc.Compid = 'Comp-1285' group by bl.M_Consumerid, M_Consumer.ConsumerName order by sum(Points) desc ");
        if (table.Rows.Count > 0)
        {
            txtmar.InnerText = "ख़रीदते रहो !! " + table.Rows[0]["ConsumerName"].ToString() + " ने हाल ही में एक स्मार्ट फोन जीता है !! आप अगले विजेता हो सकते हैं";
        }


    }
}