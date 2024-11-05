using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using System.Data;
using Business9420;
using System.Text.RegularExpressions;
using System.Configuration;
using Business_Logic_Layer;
using System.Net;
using System.Web.SessionState;
using System.Net.Mail;
using DataProvider;

/// <summary>
/// Summary description for EnumClass
/// </summary>
public class EnumClass
{
    public EnumClass()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public enum TrackTraceChannel
    {
        ProductionUnit = -1, Warehouse=-2   
    }
    public enum ServiceName
    {
        SRV1001=1,SRV1002 = 2, SRV1003 = 3, SRV1004 = 4, SRV1005 = 5, SRV1006 = 6, SRV1011 = 7, SRV1012 = 8, SRV1017 = 9, SRV1018 = 10, SRV1020 = 11
    }
    //    public enum ServiceName
    //    {

    // BuildLoyalty
    // Run Surveys
    // Gift Coupons
    // Big Data Analysis
    // Cash Transfers
    // Raffle Scheme
    //SRV1011 Customer Engagement
    //SRV1012 Customised Solution
    //SRV1017 sdfsdf sfd
    //SRV1018 COUNTERFIETING
    //SRV1020 Referral
    //    }
}