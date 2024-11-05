using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Class1Test
/// </summary>
public class Class1Test
{
    public Class1Test()
    {
        //
        // TODO: Add constructor logic here
        //
    }
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
}