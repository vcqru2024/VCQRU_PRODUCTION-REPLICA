﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPageNew : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {Page.Header.DataBind();
        ManageSessions();
    }
    public void ManageSessions()
    {
    }
}
