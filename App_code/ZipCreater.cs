using System;
using System.IO;
using Ionic.Zip;


namespace ZipCreate
{
   public class MyZipClass
    {
        MyZipClass()
        {
        }
        public static void ZipDemoCreate(string serverpath, string Arr)
        {
            string[] Check1 = Arr.ToString().Split(',');
            //string[] filename = new string[Check1.Length];  
            try
            {
                string str = ""; string FileName = "";        
                for (int i = 0; i < Check1.Length; i++)
                {
                    string[] b = Check1[i].Split('*');
                    string path1 = serverpath;
                    FileName = b[0].ToString();
                    path1 = path1 + "\\" + b[1].ToString() + "\\Demo\\" + b[0].ToString() + ".xls";
                    //filename[i] = path1;
                    if (System.IO.File.Exists(path1))
                    {
                        //System.IO.File.Copy(path1, path2);
                        str += path1 + ",";
                    }   
                }
                if (str != "")
                {
                    str = str.ToString().Substring(0, str.Length - 1);
                    string[] filename = str.ToString().Split(',');
                    ZipFile zip = new ZipFile();
                    if (Check1.Length > 1)
                    {
                        zip.AddFiles(filename, "ExcelSheets");
                        zip.Save(serverpath + "\\ExcelSheets.zip");
                    }
                    else
                    {
                        zip.AddFiles(filename, FileName);
                        zip.Save(serverpath + "\\" + FileName + ".zip");
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static void ZipLicCreate(string serverpath, string Arr)
        {
            string[] Check1 = Arr.ToString().Split(',');
            //string[] filename = new string[Check1.Length];
            try
            {
                string str = ""; string FileName = "";
                for (int i = 0; i < Check1.Length; i++)
                {
                    string[] b = Check1[i].Split('*');
                    FileName = b[0].ToString() +"-"+ b[2].ToString();                    
                    string CPid = SQL_DB.ExecuteScalar("SELECT [Comp_ID] FROM [Pro_Reg] where [Pro_ID] = '" + b[0].ToString() + "'").ToString();
                    try
                    {
                        string ppath = serverpath + "\\" + b[1].ToString() + "\\Licence";
                        // Only get files that begin with the letter "c." 
                        string[] dirs = Directory.GetFiles(ppath, CPid.Substring(5, 4) + "_" + b[0].ToString()+"_"+b[2].ToString() + "*");
                        //Console.WriteLine("The number of files starting with c is {0}.", dirs.Length);
                        foreach (string dir in dirs)
                        {
                            //Console.WriteLine(dir);
                            string ss = dir;
                            string path1 = serverpath;
                            //path1 = path1 + "\\" + b[1].ToString() + "\\Licence\\" + CPid.Substring(5, 4) + "_" + b[0].ToString() + ".xls";
                            string path2 = serverpath;
                            //path2 = path2 + "\\" + b[1].ToString() + "\\Licence\\" + CPid.Substring(5, 4) + "_" + b[0].ToString() + "_0.xls"; // chamge dynamic file name
                            path1 = dir;
                            path2 = dir;
                            if (System.IO.File.Exists(path1))
                            {
                                //System.IO.File.Copy(path1, path2);
                                str += path2 + ",";
                            }   
                        }
                    }
                    catch (Exception)
                    {
                        //Console.WriteLine("The process failed: {0}", e.ToString());
                    }
                }
                if (str != "")
                {
                    str = str.ToString().Substring(0, str.Length - 1);
                    string[] filename = str.ToString().Split(',');
                    ZipFile zip = new ZipFile();
                    if (Check1.Length > 1)
                    {
                        zip.AddFiles(filename, "ExcelSheets");
                        zip.Save(serverpath + "\\ExcelSheets.zip");
                    }
                    else
                    {
                        zip.AddFiles(filename, FileName);
                        zip.Save(serverpath + "\\"+FileName+".zip");                        
                    }
                }
            }
            catch (Exception )
            {

            }
        }
        public static void ZipCreate(string serverpath, string Arr)
        {
            string[] Check1 = Arr.ToString().Split(',');              
            try
            {
                string str = "";
                for (int i = 0; i < Check1.Length; i++)
                {
                    string[] b = Check1[i].Split('*');
                    string path1 = serverpath;
                    path1 = path1 + "\\" + b[0].ToString() +"\\"+ b[1].ToString();                    
                    if (System.IO.File.Exists(path1))
                        str += path1 + ",";
                }
                if (str != "")
                {
                    str = str.ToString().Substring(0, str.Length - 1);
                    string[] filename = str.ToString().Split(',');
                    ZipFile zip = new ZipFile();
                    zip.AddFiles(filename, "Documents");
                    zip.Save(serverpath + "\\Documents.zip");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }        
    }
}
//using System.IO.Packaging;

//namespace ZipSample
//{
//    class Program
//    {
//        static void Main(string[] args)
//        {
//            AddFileToZip("Output.zip", @"C:\Windows\Notepad.exe");
//            AddFileToZip("Output.zip", @"C:\Windows\System32\Calc.exe");
//        }

//        private const long BUFFER_SIZE = 4096;

//        private static void AddFileToZip(string zipFilename, string fileToAdd)
//        {
//            using (Package zip = System.IO.Packaging.Package.Open(zipFilename, FileMode.OpenOrCreate))
//            {
//                string destFilename = ".\\" + Path.GetFileName(fileToAdd);
//                Uri uri = PackUriHelper.CreatePartUri(new Uri(destFilename, UriKind.Relative));
//                if (zip.PartExists(uri))
//                {
//                    zip.DeletePart(uri);
//                }
//                PackagePart part = zip.CreatePart(uri, "", CompressionOption.Normal);
//                using (FileStream fileStream = new FileStream(fileToAdd, FileMode.Open, FileAccess.Read))
//                {
//                    using (Stream dest = part.GetStream())
//                    {
//                        CopyStream(fileStream, dest);
//                    }
//                }
//            }
//        }

//        private static void CopyStream(System.IO.FileStream inputStream, System.IO.Stream outputStream)
//        {
//            long bufferSize = inputStream.Length < BUFFER_SIZE ? inputStream.Length : BUFFER_SIZE;
//            byte[] buffer = new byte[bufferSize];
//            int bytesRead = 0;
//            long bytesWritten = 0;
//            while ((bytesRead = inputStream.Read(buffer, 0, buffer.Length)) != 0)
//            {
//                outputStream.Write(buffer, 0, bytesRead);
//                bytesWritten += bufferSize;
//            }
//        }
//    }
//}
