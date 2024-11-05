using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Auth
/// </summary>
public class Auth
{
    public Auth()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static void Oncheck()
    {
        if (HttpContext.Current.Session["User_Type"] != null)
        {
            if (HttpContext.Current.Session["User_Type"].ToString().ToLower() == "admin" && HttpContext.Current.Request.Url.AbsoluteUri.ToLower().Contains("admin") ||
                HttpContext.Current.Session["User_Type"].ToString().ToLower() == "company" && (HttpContext.Current.Request.Url.AbsoluteUri.ToLower().Contains("manufacturer") || HttpContext.Current.Request.Url.AbsoluteUri.ToLower().Contains("info")))
            {
                
            }
            else
            {
                if (HttpContext.Current.Session["User_Type"].ToString().ToLower() == "admin")
                {
                    HttpContext.Current.Session.Abandon();
                    HttpContext.Current.Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/admin/login.aspx");
                }
                else if (HttpContext.Current.Session["User_Type"].ToString().ToLower() == "company")
                {
                    HttpContext.Current.Session.Abandon();
                    HttpContext.Current.Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/info/login.aspx");
                }
            }
        }


        //if (HttpContext.Current.Session["User_Type"].ToString().ToLower() == "company" && HttpContext.Current.Request.Url.AbsoluteUri.ToLower().Contains("Manufacturer"))
        //{

        //}
        //else
        //{
        //    HttpContext.Current.Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "info/login.aspx");
        //}



        //if ((ProjectSession.intUserID == 0 || ProjectSession.strURLCompanyCode == "") &&
        //    (filterContext.ActionDescriptor).ActionName != "LoginSubmit" && (filterContext.ActionDescriptor).ActionName != "ForgotPassword"
        //    && (filterContext.ActionDescriptor).ActionName != "AdminCompany")
        //{
        //    if (ProjectSession.intUserID == 0 && ProjectSession.strURLCompanyCode != "" &&
        //       ((System.Web.Mvc.ControllerContext)(filterContext)).RouteData.Values["Controller"].ToString() == "DisplayCase")
        //    {
        //    }
        //    else if (ProjectSession.intUserID == 0 && ProjectSession.strURLCompanyCode != "" &&
        //       ((filterContext.ActionDescriptor).ActionName == "ShowAssignedImage") &&
        //        ((System.Web.Mvc.ControllerContext)(filterContext)).RouteData.Values["Controller"].ToString() == "CaseWriter")
        //    {
        //    }
        //    else
        //    {
        //        HandleUnauthorizedRequest(filterContext);
        //    }
        //    //send them off to the login page
        //    //RedirectUserToLoginPage(filterContext);
        //}
        ////first check Admin Area and writer Access
        //else if ((ProjectSession.intUserType == 3 || ProjectSession.intUserType == 4 || ProjectSession.intUserType == 5 || ProjectSession.intUserType == 6) && ((System.Web.Mvc.ControllerContext)(filterContext)).Controller.ToString().Contains("CBPS.Areas.Admin"))
        //{

        //    //in Admin Area writer can access registration -> My Profile action.
        //    if (((System.Web.Mvc.ControllerContext)(filterContext)).RouteData.Values["Controller"].ToString().Equals("Registration") &&
        //        ((System.Web.Mvc.ControllerContext)(filterContext)).RouteData.Values["Action"].ToString().Equals("MyProfile")
        //        )
        //    {

        //    }
        //    else
        //    {
        //        //send them off to the login page
        //        RedirectUserToLoginPage(filterContext);

        //    }
        //}
        //else if (ProjectSession.intUserType > 2 && (filterContext.ActionDescriptor).ActionName == "List" && ((filterContext.ActionDescriptor).ControllerDescriptor.ControllerName == "ImageLibrary"))
        //{
        //    RedirectUserToLoginPage(filterContext);
        //}
        //else if (ProjectSession.intUserType > 1 && ((filterContext.ActionDescriptor).ControllerDescriptor.ControllerName == "Company"))
        //{
        //    RedirectUserToLoginPage(filterContext);
        //}

        // }

        //#endregion

        ///   #region Protected Methods
        // <summary>
        /// Processes HTTP requests that fail authorization.
        /// </summary>
        /// <param name="filterContext">Encapsulates the information for using <see cref="T:System.Web.Mvc.AuthorizeAttribute"/>. The <paramref name="filterContext"/> object contains the controller, HTTP context, request context, action result, and route data.</param>

        //protected void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        //{
        //    if (filterContext.ActionDescriptor.ControllerDescriptor.ControllerName.ToLower() == "login" && filterContext.ActionDescriptor.ActionName.ToLower() == "demo"
        //        ||
        //        (filterContext.ActionDescriptor.ControllerDescriptor.ControllerName.ToLower() == "casewriter" &&
        //       (
        //       (filterContext.ActionDescriptor).ActionName == "getInstructionHTML" || (filterContext.ActionDescriptor).ActionName == "ShowAssignedImage"
        //       )
        //       ))

        //    {
        //        //HttpSessionStateBase session = filterContext.HttpContext.Session;
        //        //var url = new UrlHelper(filterContext.RequestContext);
        //        //var loginUrl = ProjectSession.absoluteSiteBrowseUrl;//
        //    }
        //    else
        //    {
        //        if (filterContext.HttpContext.Request.IsAjaxRequest())
        //        {
        //            var filepath = HttpContext.Current.Request.FilePath;
        //            filterContext.HttpContext.Response.StatusCode = 401;
        //            filterContext.HttpContext.Response.End();
        //            base.HandleUnauthorizedRequest(filterContext);
        //        }
        //        else
        //        {

        //            if (((((System.Web.Mvc.ControllerContext)(filterContext)).HttpContext).Request).Path.Contains("/sa/Admin"))
        //            {
        //                RedirectUserToLoginPage(filterContext, true);
        //            }
        //            else
        //                RedirectUserToLoginPage(filterContext);
        //        }
        //    }
        //}

        //private void RedirectUserToLoginPage(AuthorizationContext filterContext, bool isSuperAdmin = false)
        //{
        //    HttpSessionStateBase session = filterContext.HttpContext.Session;
        //    var url = new UrlHelper(filterContext.RequestContext);
        //    var loginUrl = ProjectSession.absoluteSiteBrowseUrl;//ConfigurationManager.AppSettings["SiteUrl"].ToString(); //url.Content("~/Account/LogOff");
        //    if (isSuperAdmin)
        //        loginUrl += "sa";

        //    session.RemoveAll();
        //    session.Clear();
        //    session.Abandon();
        //    // Will not be called                
        //    //filterContext.HttpContext.Response.Redirect(loginUrl, true);
        //    filterContext.Result = new RedirectResult(loginUrl, true);
        //}

        // #endregion
    }
}
