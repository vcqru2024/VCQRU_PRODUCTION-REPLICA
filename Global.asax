
<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
		 RegisterRoutes(RouteTable.Routes);


    }
	
	static void RegisterRoutes(RouteCollection routes)
    {
        routes.MapPageRoute("DisplayBlog", "blog/{Slugs}.aspx", "~/blog/brand-loyalty.aspx");
    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown


    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs
        try
        {

            // Code that runs when an unhandled error occurs
            //Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "default.aspx");
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "index.html");
            //Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/login.aspx");//arb for session out error
            string ErrorPagePath = Context.Request.Url.ToString();
            Exception ErrorInfo = Server.GetLastError().GetBaseException();
            DataProvider.LogManager.ErrorExceptionLog(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            DataProvider.LogManager.ErrorExceptionLog(ErrorPagePath);
            DataProvider.LogManager.ErrorExceptionLog(ErrorInfo.Message);
            DataProvider.LogManager.ErrorExceptionLog("\n" + ErrorInfo.StackTrace + "\n");
            DataProvider.LogManager.ErrorExceptionLog("\n UserHostAddress: " + Convert.ToString(Request.UserHostAddress) + ",REMOTE_ADDR: " + Request.ServerVariables["REMOTE_ADDR"] + ", HTTP_X_FORWARDED_FOR: " + Convert.ToString(Request.ServerVariables["HTTP_X_FORWARDED_FOR"]));
            // Code that runs when an unhandled error occurs
            // write all errors to ApplicationError.XML file located at root.
            //    System.Xml. xmlDoc = new  System.Xml.XmlDocument();
            //    xmlDoc.Load(App_Code.Common.ErrorFilePath());//ConfigurationManager.AppSettings["SiteUrl"].ToString()

            //    XmlNodeList xmNodeLst = xmlDoc.GetElementsByTagName("ErrorList");

            //    #region Remove above 50  nodes from ApplicationError.xml
            //    XmlNodeList xdocError = xmlDoc.GetElementsByTagName("Error");
            //    int intCount = xdocError.Count - 50;
            //    if (xdocError.Count > 50)
            //    {
            //        for (int j = 0; j < intCount; j++)
            //        {
            //            xmNodeLst[0].RemoveChild(xdocError[0]);
            //        }
            //    }
            //    #endregion



            //    if ((xmNodeLst.Count > 0))
            //    {

            //        XmlNode parentNode = xmNodeLst[0];
            //        XmlNode errorNode = xmlDoc.CreateElement("Error");
            //        XmlNode dateTimeNode = xmlDoc.CreateElement("DateTime");
            //        XmlNode pathNode = xmlDoc.CreateElement("Path");
            //        XmlNode messageNode = xmlDoc.CreateElement("Message");
            //        XmlNode StackTraceNode = xmlDoc.CreateElement("StackTrace");
            //        XmlNode FromNode = xmlDoc.CreateElement("FromIP");

            //        parentNode.AppendChild(errorNode);
            //        errorNode.AppendChild(dateTimeNode);
            //        errorNode.AppendChild(pathNode);
            //        errorNode.AppendChild(messageNode);
            //        errorNode.AppendChild(StackTraceNode);
            //        errorNode.AppendChild(FromNode);

            //        dateTimeNode.AppendChild(xmlDoc.CreateTextNode(DateTime.Now.ToString()));
            //        pathNode.AppendChild(xmlDoc.CreateTextNode(ErrorPagePath));
            //        messageNode.AppendChild(xmlDoc.CreateTextNode(ErrorInfo.Message));
            //        StackTraceNode.AppendChild(xmlDoc.CreateTextNode("\n" + ErrorInfo.StackTrace + "\n"));
            //        FromNode.AppendChild(xmlDoc.CreateTextNode("\n UserHostAddress: " + Convert.ToString(Request.UserHostAddress) + ",REMOTE_ADDR: " + Request.ServerVariables["REMOTE_ADDR"] + ", HTTP_X_FORWARDED_FOR: " + Convert.ToString(Request.ServerVariables["HTTP_X_FORWARDED_FOR"])));

            //        xmlDoc.Save(App_Code.Common.ErrorFilePath());
            //    }
            //    App_Code.ErrorConsole.SendErrorEmail(ErrorInfo);
            //}
            //catch (Exception)
            //{
            //    throw;
            //}
            //try
            //{
            //    if (HttpContext.Current != null && HttpContext.Current.Session != null)
            //    {
            //        Exception exception = Server.GetLastError();
            //        Server.ClearError();
            //        RouteData routeData = new RouteData();
            //        routeData.Values["controller"] = "Error";
            //        routeData.Values["action"] = "Index";
            //        IController controller = new Controllers.ErrorController();
            //        RequestContext rc = new RequestContext(new HttpContextWrapper(Context), routeData);
            //        controller.Execute(rc);
            //    }
            // Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/login.aspx");
        }
        catch(Exception)
        {
        }

    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e)
    {
        Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "index.html");
        //Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/login.aspx");
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.


    }
    protected void Application_BeginRequest(Object sender, EventArgs e)
    {

        //// note - in local it will not enter in if loop, but on live application it is working fine.
        if (HttpContext.Current.Request.IsSecureConnection.Equals(false) && HttpContext.Current.Request.IsLocal.Equals(false))
        {
            Response.Redirect("https://" + Request.ServerVariables["HTTP_HOST"]
           + HttpContext.Current.Request.RawUrl);
        }
     
        //HttpApplication app = (HttpApplication)sender;

        //if(!app.Current.Request.IsSecureConnection)
        //{
        //    app.Current.Redirect(Request.RawUrl.Replace("http://","https://"), true);
        //    return;
        //}
    }
</script>
