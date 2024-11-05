using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_CodeLabelPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void BtnDownloadLicence_Click(object sender, ImageClickEventArgs e)
    {
        if (Request.Form["chkselect"] == null)
        {
            //BigpopMsg.Visible = true;
            //BigpopMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            //lblmsg.Text = "Please select checkbox for download !";
            return;
        }
        //CreateFolderToZipDownload();
        string[] Check1 = Request.Form["chkselect"].ToString().Split(',');
        string b = "";
        for (int i = 0; i < Check1.Count(); i++)
        {
            b += Check1[i].ToString() + ",";
        }
        if (b != "")
            b = b.ToString().Substring(0, b.Length - 1);

        //ZipCompressor.CreateFolderToZipDownloadLic(Server.MapPath("Excel"), b); // this code for is Microsoft lib
        //Compressor.CreateFolderToZipDownloadNewlic(Server.MapPath("Excel"), b); // this code self is Microsoft lib
        //*************** Comments ddl not support ***************//
        string Paths = Server.MapPath("../Data");
        Paths = Paths + "\\Excel";
        ZipCreate.MyZipClass.ZipLicCreate(Paths, b);   // this code self is Ionic.dll lib

        string path = ""; string FileName = "";
        string[] Check12 = b.ToString().Split(',');
        if (Check12.Length > 1)
            FileName = "ExcelSheets.zip";
        else
        {
            string[] b12 = Check12[0].Split('*');
            FileName = b12[0].ToString() + "-" + b12[2].ToString() + ".zip";
        }
        path = Paths + "\\" + FileName;

        FileInfo myfile = new FileInfo(path);

        if (myfile.Exists)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ClearContent();
            Response.Clear();
            Response.ContentType = "application/zip";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + FileName);// + filename);
            Response.TransmitFile(myfile.FullName);
            Response.End();

        }

        //BigpopMsg.Visible = true;
        //BigpopMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        //lblmsg.Text = "File downloaded successfully !";
    }
}