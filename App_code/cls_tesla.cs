using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;


public class cls_tesla
{
    public int calculatepoint(string M_cnsumerid, string compid, string Userid)
    {
        int totalpoint = 0;
        int tp = 0;
        DataTable dtcp = SQL_DB.ExecuteDataTable("select mss.Comp_ID,isnull(sum(bl.points), 0) point,isnull(cl.p_cash ,0) p_cash from dbo.[BLoyaltyPointsEarned] bl left join[dbo].[M_ServiceSubscriptionTrans] ms on bl.sst_id = ms.sst_id left join[dbo].M_ServiceSubscription mss on mss.Subscribe_Id = ms.Subscribe_Id left join dbo.claimredeem cl on cl.compid=mss.Comp_ID where  bl.M_consumerid = (select M_consumerid from dbo.m_consumer where user_id = '" + Userid + "') and Comp_ID='" + compid + "' group by mss.Comp_ID,cl.p_cash");
        if (dtcp.Rows.Count > 0)
        {
            totalpoint = (Convert.ToInt32(dtcp.Rows[0]["point"].ToString()));
            int redeempoint = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(bl.[RedeemPoints]) is null then 0 else Sum(isnull(bl.[RedeemPoints],0)) end FROM [BPointsTransaction] bl inner join [M_consumer] mc on mc.[M_Consumerid]=bl.[RedeemBy] where mc.[User_ID]='" + Userid + "' and (bl.bpstatus is null or bl.bpstatus<>'FAILURE')"));
            int claimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [ClaimDetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.[User_ID]='" + Userid + "' and (cl.Isapproved=1 ) and cl.Comp_id='"+ compid + "'"));
            #region UPI Claim process
            int Upiclaimapply = 0;
            if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1722")
            {
                Upiclaimapply = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT case when Sum(cl.Amount) is null then 0 else Sum(isnull(cl.Amount,0)) end FROM [tblupitransactiondetails] cl inner join [M_consumer] mc on mc.MobileNo=cl.Mobileno where mc.[User_ID]='" + Userid + "' and (cl.status='Success') and cl.Code1 <> '' and cl.Code2 <>''"));
            }
            #region Cash reedemtion 
            int Cashredeem = 0;
            DataTable dtconsumer = SQL_DB.ExecuteDataTable("select top 1 *from M_Consumer where User_ID='" + Userid + "' and IsDelete=0");
            if (dtconsumer.Rows.Count > 0)
            {
               string consumerMobileno = dtconsumer.Rows[0]["mobileno"].ToString();
                if (dtcp.Rows[0]["Comp_ID"].ToString() == "Comp-1722")
                {
                    Cashredeem = Convert.ToInt32(SQL_DB.ExecuteScalar("select isnull(sum(Amount),0) from paytmtransaction where pstatus='Success' and Rec_code1 is not null  and Rec_code2 is not null  and compId='" + dtcp.Rows[0]["Comp_ID"].ToString() + "'and mobileno='" + consumerMobileno + "'"));
                }
            }
            #endregion
            claimapply = claimapply + Upiclaimapply+ Cashredeem;
            #endregion
            DataTable dtcondition = SQL_DB.ExecuteDataTable("select top 1 codition_point,condition_match from point_redeem_condition where comp_id='" + dtcp.Rows[0]["Comp_ID"].ToString() + "' and isactive=1 and selection_id=case when (select count(*) from paytmtransaction where m_consumerid='" + M_cnsumerid + "' and comp_id='Comp-1214')>0 then 2 else 1 end ");
            if (dtcondition.Rows.Count > 0)
            {
                tp = totalpoint - redeempoint - claimapply;
            }
        }
        return tp;
    }

    public string SubmitClaim(string mobileNo, int ptforrd, string M_Consumer, string Comp_id)
    {
        string msg = string.Empty;
        try
        {
            string upiId = SQL_DB.ExecuteScalar("SELECT UPIId FROM m_consumer WHERE MobileNo='" + mobileNo + "'").ToString();
            DataTable dt = SQL_DB.ExecuteDataTable("SELECT TOP 1 * FROM m_consumer WHERE M_Consumerid=" + M_Consumer);
            #region Multivendor Condition
            DataTable dtchkmultivendor = SQL_DB.ExecuteDataTable("exec USP_Companywisepoints '"+ dt.Rows[0]["user_id"].ToString() + "'");
            if (dtchkmultivendor.Rows.Count > 1)
            {
                msg = "Multivendor";
                return msg;
            }
            #endregion
            int availablePoints = calculatepoint(dt.Rows[0]["M_Consumerid"].ToString(), Comp_id, dt.Rows[0]["User_ID"].ToString());
            if (availablePoints < ptforrd)
            {
                msg = "Point not avlaibe";
                return msg;
            }
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12; // Use TLS 1.2
            string str = "https://api2.vcqru.com/api/ApiSubmitClaim";
            WebRequest request = WebRequest.Create(str);
            request.Method = "POST";
            string postData = "{\"Mobile\":\"" + dt.Rows[0]["MobileNo"].ToString() + "\",\"ProductId\":\"284\",\"Productvalue\":\"250\",\"ServiceId\":\"SRV1029\",\"Amount\":\"" + ptforrd + "\",\"UPIID\":\"" + upiId + "\",\"Comp_id\":\"" + Comp_id.ToString() + "\"}";
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            request.ContentType = "application/json";
            using (Stream dataStream = request.GetRequestStream())
            {
                dataStream.Write(byteArray, 0, byteArray.Length);
            }
            using (WebResponse response = request.GetResponse())
            {
                Console.WriteLine(((HttpWebResponse)response).StatusDescription);
                using (StreamReader reader = new StreamReader(response.GetResponseStream()))
                {
                    string responseFromServer = reader.ReadToEnd();
                    JObject jObjects = JObject.Parse(responseFromServer);
                     msg = jObjects["Message"].ToString();
                    return msg;
                }
            }
        }
        catch (Exception ex)
        {
            throw;
        }
    }
}




