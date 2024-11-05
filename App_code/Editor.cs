using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using AjaxControlToolkit;
using AjaxControlToolkit.HTMLEditor;
/// <summary>
/// Summary description for Editor
/// </summary>
/// 
namespace CustomControl
{
    
    public class CustomEditor :Editor
    {
        public CustomEditor()
        {
            //
            // TODO: Add constructor logic here
            //
          
        }
        protected override void FillTopToolbar()
        {
            AjaxControlToolkit.HTMLEditor.ToolbarButton.Underline MyFontUnderline = new AjaxControlToolkit.HTMLEditor.ToolbarButton.Underline();
            AjaxControlToolkit.HTMLEditor.ToolbarButton.Bold MyFontbold = new AjaxControlToolkit.HTMLEditor.ToolbarButton.Bold();
            AjaxControlToolkit.HTMLEditor.ToolbarButton.Italic MyFontItalic = new AjaxControlToolkit.HTMLEditor.ToolbarButton.Italic();
            AjaxControlToolkit.HTMLEditor.ToolbarButton.ForeColor MyFontColor = new AjaxControlToolkit.HTMLEditor.ToolbarButton.ForeColor();
            AjaxControlToolkit.HTMLEditor.ToolbarButton.FontSize MyFontSize = new AjaxControlToolkit.HTMLEditor.ToolbarButton.FontSize();
            AjaxControlToolkit.HTMLEditor.ToolbarButton.SelectOption fontsizeOptions = new AjaxControlToolkit.HTMLEditor.ToolbarButton.SelectOption();
            MyFontSize.Attributes.Clear();
            fontsizeOptions.Value = "8pt";
            fontsizeOptions.Text = "1 (8 pt)";
            MyFontSize.Options.Add(fontsizeOptions);
            fontsizeOptions = new AjaxControlToolkit.HTMLEditor.ToolbarButton.SelectOption();
            fontsizeOptions.Value = "10pt";
            fontsizeOptions.Text = "2 (10 pt)";
            MyFontSize.Options.Add(fontsizeOptions);
            fontsizeOptions = new AjaxControlToolkit.HTMLEditor.ToolbarButton.SelectOption();           
            fontsizeOptions.Value = "12pt";
            fontsizeOptions.Text = "3 (12 pt)";
            MyFontSize.Options.Add(fontsizeOptions);
            fontsizeOptions = new AjaxControlToolkit.HTMLEditor.ToolbarButton.SelectOption();
            fontsizeOptions.Value = "14pt";
            fontsizeOptions.Text = "4 (14 pt)";
            MyFontSize.Options.Add(fontsizeOptions);
            fontsizeOptions = new AjaxControlToolkit.HTMLEditor.ToolbarButton.SelectOption();
            fontsizeOptions.Value = "18pt";
            fontsizeOptions.Text = "5 (18 pt)";
            MyFontSize.Options.Add(fontsizeOptions);
            fontsizeOptions = new AjaxControlToolkit.HTMLEditor.ToolbarButton.SelectOption();
            fontsizeOptions.Value = "24pt";
            fontsizeOptions.Text = "6 (24 pt)";
            MyFontSize.Options.Add(fontsizeOptions);
            TopToolbar.Buttons.Add(MyFontbold);
            TopToolbar.Buttons.Add(MyFontItalic);
            TopToolbar.Buttons.Add(MyFontUnderline);
            TopToolbar.Buttons.Add(MyFontColor);
            TopToolbar.Buttons.Add(MyFontSize);            
            
        }
        

    }
}