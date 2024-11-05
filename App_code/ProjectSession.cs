using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;


/// <summary>
/// Summary description for ProjectSession
/// </summary>
public class ProjectSession
{
    public ProjectSession()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static int intM_ConsumeriD
    {
        get
        {
            if (HttpContext.Current.Session["M_ConsumeriD"] == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(HttpContext.Current.Session["M_ConsumeriD"]);
            }
        }
        set
        {
            HttpContext.Current.Session["M_ConsumeriD"] = value;
        }
    }
    public static int Empid
    {
        get
        {
            if (HttpContext.Current.Session["_Empid"] == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(HttpContext.Current.Session["_Empid"]);
            }
        }
        set
        {
            HttpContext.Current.Session["_Empid"] = value;
        }
    }
    public static string strConsumerUserID
    {
        get
        {
            if (HttpContext.Current.Session["USRID"] == null)
            {
                return "";
            }
            else
            {
                return HttpContext.Current.Session["USRID"].ToString().Trim();
            }
        }
        set
        {
            HttpContext.Current.Session["USRID"] = value.Trim();
        }
    }
    public static string strDealerUserID
    {
        get
        {
            if (HttpContext.Current.Session["DealerUSRID"] == null)
            {
                return "";
            }
            else
            {
                return HttpContext.Current.Session["DealerUSRID"].ToString().Trim();
            }
        }
        set
        {
            HttpContext.Current.Session["DealerUSRID"] = value.Trim();
        }
    }
    public static string strServiceID
    {
        get
        {
            if (HttpContext.Current.Session["strServiceID"] == null)
            {
                return "";
            }
            else
            {
                return HttpContext.Current.Session["strServiceID"].ToString().Trim();
            }
        }
        set
        {
            HttpContext.Current.Session["strServiceID"] = value.Trim();
        }
    }
    public static string strUser_Type
    {
        get
        {
            if (HttpContext.Current.Session["User_Type"] == null)
            {
                return "";
            }
            else
            {
                return HttpContext.Current.Session["User_Type"].ToString().Trim();
            }
        }
        set
        {
            HttpContext.Current.Session["User_Type"] = value.Trim();
        }
    }
    //public static int intUserID
    //{
    //    get
    //    {
    //        if (HttpContext.Current.Session["UserID"] == null)
    //        {
    //            return 0;
    //        }
    //        else
    //        {
    //            return Convert.ToInt32(HttpContext.Current.Session["UserID"]);
    //        }
    //    }
    //    set
    //    {
    //        HttpContext.Current.Session["UserID"] = value;
    //    }
    //}
    /// <summary>
    /// Get or Sets intUserCompanyID value
    /// </summary>
    public static int intUserCompanyID
    {
        get
        {
            if (HttpContext.Current.Session["userCompanyID"] == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(HttpContext.Current.Session["userCompanyID"]);
            }
        }
        set
        {
            HttpContext.Current.Session["userCompanyID"] = value;
        }
    }
    /// <summary>
    /// Get or Sets strCompanyName value
    /// </summary>
    public static string strCompanyName
    {
        get
        {
            if (HttpContext.Current.Session["strCompanyName"] == null)
            {
                return "";
            }
            else
            {
                return HttpContext.Current.Session["strCompanyName"].ToString();
            }
        }
        set
        {
            HttpContext.Current.Session["strCompanyName"] = value;
        }
    }
    public static string strConsumerName
    {
        get
        {
            if (HttpContext.Current.Session["strConsumerName"] == null)
            {
                return "";
            }
            else
            {
                return HttpContext.Current.Session["strConsumerName"].ToString();
            }
        }
        set
        {
            HttpContext.Current.Session["strConsumerName"] = value;
        }
    }
    public static string strDealerName
    {
        get
        {
            if (HttpContext.Current.Session["strDealerName"] == null)
            {
                return "";
            }
            else
            {
                return HttpContext.Current.Session["strDealerName"].ToString();
            }
        }
        set
        {
            HttpContext.Current.Session["strDealerName"] = value;
        }
    }
    public static string strEmployeeName
    {
        get
        {
            if (HttpContext.Current.Session["strEmployeeName"] == null)
            {
                return "";
            }
            else
            {
                return HttpContext.Current.Session["strEmployeeName"].ToString();
            }
        }
        set
        {
            HttpContext.Current.Session["strEmployeeName"] = value;
        }
    }
    public static string strEmployeeEmail
    {
        get
        {
            if (HttpContext.Current.Session["strEmployeeEmail"] == null)
            {
                return "";
            }
            else
            {
                return HttpContext.Current.Session["strEmployeeEmail"].ToString();
            }
        }
        set
        {
            HttpContext.Current.Session["strEmployeeEmail"] = value;
        }
    }
    /// <summary>
    /// Get or Sets strUserName value
    /// </summary>
    public static string strUserName
    {
        get
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "";
            }
            else
            {
                return HttpContext.Current.Session["UserName"].ToString().Trim();
            }
        }
        set
        {
            HttpContext.Current.Session["UserName"] = value.Trim();
        }
    }
    /// <summary>
    /// Get or Sets intUserType value
    /// </summary>
    public static int intUserType
    {
        get
        {
            if (HttpContext.Current.Session["intUserType"] == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(HttpContext.Current.Session["intUserType"]);
            }
        }
        set
        {
            HttpContext.Current.Session["intUserType"] = value;
        }
    }
    /// <summary>
    /// Get or Sets strCompanyCode value
    /// </summary>
    public static string strCompanyid
    {
        get
        {
            if (HttpContext.Current.Session["strCompanyCode"] == null)
            {
                return "";
            }
            else
            {
                return HttpContext.Current.Session["strCompanyCode"].ToString();
            }
        }
        set
        {
            HttpContext.Current.Session["strCompanyCode"] = value;
        }
    }

    public static string strMobileNo
    {
        get
        {
            if (HttpContext.Current.Session["strMobileNo"] == null)
            {
                return "";
            }
            else
            {
                return HttpContext.Current.Session["strMobileNo"].ToString();
            }
        }
        set
        {
            HttpContext.Current.Session["strMobileNo"] = value;
        }
    }
    public static long intM_Consumer_MCOde
    {
        get
        {
            if (HttpContext.Current.Session["intM_Consumer_MCOde"] == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(HttpContext.Current.Session["intM_Consumer_MCOde"]);
            }
        }
        set
        {
            HttpContext.Current.Session["intM_Consumer_MCOde"] = value;
        }
    }
    /// <summary>
    /// Get or Sets strURLCompanyCode value
    /// </summary>
    public static string strURLCompanyCode
    {
        get
        {
            if (HttpContext.Current.Session["strURLCompanyCode"] == null)
            {
                return "";
            }
            else
            {
                return HttpContext.Current.Session["strURLCompanyCode"].ToString();
            }
        }
        set
        {
            HttpContext.Current.Session["strURLCompanyCode"] = value;
        }
    }
    /// <summary>
    /// Get or Sets strUserEmail value
    /// </summary>
    public static string strUserEmail
    {
        get
        {
            if (HttpContext.Current.Session["Email"] == null)
            {
                return null;
            }
            else
            {
                return HttpContext.Current.Session["Email"].ToString();
            }
        }
        set
        {
            HttpContext.Current.Session["Email"] = value;
        }
    }
    
    /// Get or Sets strCompanyName value
    /// </summary>
    public static string filebrowserBrowseUrl
    {
        get
        {
            string _strSiteURL = String.Concat(HttpContext.Current.Request.Url.Scheme + "://", HttpContext.Current.Request.Url.Authority, HttpContext.Current.Request.ApplicationPath);
            if (!_strSiteURL.EndsWith("/")) _strSiteURL = String.Concat(_strSiteURL, "/");
            return String.Concat(_strSiteURL + "filemanager").Trim();
        }

    }

    public static string SiteURLApplicationPath
    {
        get
        {
            return HttpContext.Current.Request.ApplicationPath.Replace("/", "");
            
        }

    }

    public static string absoluteSiteBrowseUrl
    {
        get { return String.Concat(HttpContext.Current.Request.Url.Scheme + "://", HttpContext.Current.Request.Url.Authority, HttpContext.Current.Request.ApplicationPath).Trim(); }

    }
    public static string absoluteSiteBrowseUrl_Content
    {
        get { return String.Concat(HttpContext.Current.Request.Url.Scheme + "://", HttpContext.Current.Request.Url.Authority, HttpContext.Current.Request.ApplicationPath, "/content/").Trim(); }

    }
    public static string absoluteSiteBrowseUrl_CSS
    {
        get { return String.Concat(HttpContext.Current.Request.Url.Scheme + "://", HttpContext.Current.Request.Url.Authority, HttpContext.Current.Request.ApplicationPath, "/css/").Trim(); }

    }
    /// <summary>
    /// It is arish@vcqru.com changed, in place of sales@accomplishtrades.com
    /// </summary>
    public static string sales_accomplishtrades
    {
        get { return "sales@accomplishtrades.com"; }
       // get { return "arish@vcqru.com"; }

    }
    public static string sales_vcqrucom
    {
        get { return "sales@vcqru.com"; }

    }
    public static string Finance_accomplishtrades
    {
        get { return "sales@vcqru.com"; }

    }
    public static string admin_accomplishtrades
    {
        get { return "sales@vcqru.com"; }

    }

 public static string print_accomplishtrades
    {
        get { return "sales@accomplishtrades.com"; }

    }
    public static string it_accomplishtrades
    {
        get { return "sales@vcqru.com"; }

    }
    public static string Legal_accomplishtrades
    {
        get { return "sales@vcqru.com"; }

    }
    public static string Marketing_accomplishtrades
    {
        get { return "sales@vcqru.com"; }

    }
    public static string Media_accomplishtrades
    {
        get { return "sales@vcqru.com"; }

    }
    public static string channelpartners
    {
        get { return "sales@accomplishtrades.com"; }

    }
    public static string Company_AccTraPvtLtd
    {
        get { return "ACCOMPLISH TRADES PRIVATE LIMITED"; }

    }
    public static string GetWebsiteName
    {
        get { return ConfigurationManager.AppSettings["vcqru_dotcom"].ToString(); }

    }
    public static string GetVCQRU
    {
        get { return ConfigurationManager.AppSettings["vcqru"].ToString(); }

    }
}