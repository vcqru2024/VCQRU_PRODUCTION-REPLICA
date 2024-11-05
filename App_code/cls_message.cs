using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

public class cls_message
{
    public void ShowErrorMessage(Page page, string message)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), "Invalid", "showAlert('Error', '" + message + "', 'error');", true);
    }

    public void ShowSuccessMessage(Page page, string message)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), "Success", "showAlert('Success', '" + message + "', 'success');", true);
    }
    public void ShowSuccessMessagewithredirect(Page page, string message, string URL)
    {
        string script = "showMessagewithredirect('Success', '" + message + "', 'success', '" + URL + "');";
        ScriptManager.RegisterStartupScript(page, page.GetType(), "Success", script, true);
    }
}