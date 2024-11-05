<%@ WebHandler Language="C#" Class="Upload" Debug="true" %>

using System;
using System.Web;
using System.IO;

public class Upload : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.Expires = -1;        
        try
        {
            string newfilename = Business9420.function9420.GetLabelCode("Label");
            string savepath = "";
            string tempPath = "~/Data/Sound/Label";
            savepath = context.Server.MapPath(tempPath);
            HttpPostedFile postedFile = context.Request.Files["Filedata"];
            string ext = postedFile.FileName;            
            newfilename = newfilename.Replace(" ", "-");
            postedFile.SaveAs(savepath + "\\" + postedFile.FileName.Replace(postedFile.FileName,newfilename+ Path.GetExtension(postedFile.FileName)));
            context.Response.Write(newfilename + Path.GetExtension(postedFile.FileName));
            context.Response.StatusCode = 200;
        }
        catch (Exception ex)
        {
            context.Response.Write("Error: " + ex.Message);
        }
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}