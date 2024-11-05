using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
/// <summary>
/// Summary description for UploadeFile
/// </summary>
public class UploadeFile
{
    public UploadeFile()
    {
        //
        // TODO: Add constructor logic here
        //     
        UploadFolder = "Upload";
    }
    public string FileName { get; set; }
    public Int32 FileSize { get; set; }
    public Int32 UploadedLength { get; set; }
    public string UploadFolder { get; set; }
    public string FileUrl { get; set; }
    public Stream File { get; set; }
    // 0 for progress 1 for complete -1 for error
    public int Status { get; set; }

    public void SaveAs(string path)
    {
        if (File == null)
            return;
        byte[] buffer = new byte[File.Length];
        FileStream fs = new FileStream(path, FileMode.Create);
        fs.Write(buffer, 0, buffer.Length);
        fs.Close();
    }
    public void DeleteFile(string FileName)
    {     
       string path = Path.Combine(HttpContext.Current.Request.PhysicalApplicationPath, UploadFolder);
       if (System.IO.File.Exists(Path.Combine(path, FileName)))
           System.IO.File.Delete(Path.Combine(path, FileName)); 

    }

    
}