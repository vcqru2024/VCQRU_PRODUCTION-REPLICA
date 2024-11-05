using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.IO;
using System.Drawing;
using System.Text;
using DataProvider;


public partial class FrmGallary : System.Web.UI.Page
{
    public int sr = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmGallary.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!IsPostBack)
        {
            FillGrid();
            imgBtnSubmit.Text = "Save";//.ImageUrl = "../images/Button/save.png";
            fillDataImage();
        }
    }

    private void fillDataImage()
    {
        DataSet ds = new DataSet();
        SQL_DB.GetDA("SELECT [Album_Id],[Album_Name] FROM [M_Album] where Album_Id='ALB101'").Fill(ds, "1");
        if (ds.Tables["1"].Rows.Count > 0)
        {

            imgBtnSubmit.Text = "Save";//.ImageUrl = "../images/Button/save.png";
            txtprdname.Text = ds.Tables["1"].Rows[0]["Album_Name"].ToString();
            RequiredFieldValidator3.ValidationGroup = "xyz";
            ds.Clear();
            SQL_DB.GetDA("SELECT [Album_Id],[Image_Name] FROM [T_Album_Image] where Album_Id='ALB101'").Fill(ds, "1");
            List<UploadeFile> FDetail = new List<UploadeFile>();
            Session["UploadeFileList"] = FDetail;
            UploadeFile f;
            StringBuilder str = new StringBuilder();
            for (int i = 0; i < ds.Tables["1"].Rows.Count; i++)
            {
                try
                {
                    f = new UploadeFile();
                    f.FileName = ds.Tables["1"].Rows[i]["Image_Name"].ToString();
                    f.FileUrl = f.FileName;
                    f.Status = 0;
                    byte[] buffer = File.ReadAllBytes(Path.Combine(Server.MapPath("Gallary"), f.FileName));
                    f.FileSize = buffer.Length;
                    MemoryStream ms = new MemoryStream(buffer);
                    f.File = ms;
                    FDetail.Add(f);
                    str.Append("<div>");
                    str.Append("<div  onclick=\"DeleteFile(this,\'" + f.FileName + "')\">");
                    str.Append("</div>");
                    str.Append(" <img alt=\"\"   src=\"Gallary/" + f.FileName + "\" class=\"thumb\" /> ");
                    str.Append("</div>");
                }
                catch { }
            }
            list.InnerHtml = str.ToString();
        }


        //no_image512.jpg

    }



    #region Web Method for file uploader
    [WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static string GetWebProgress11()
    {
        return "sdsadasd";
    }
    [WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static object GetWebProgress()
    {

        if (HttpContext.Current.Session["UploadeFileSession"] == null)
            return "";
        UploadeFile FileDetail = (UploadeFile)HttpContext.Current.Session["UploadeFileSession"];
        return new
        {
            Message = FileDetail.UploadedLength.ToString(),
            FileSize = FileDetail.FileSize,
            UploadedLength = FileDetail.UploadedLength,

            FileUrl = Path.Combine(FileDetail.UploadFolder, FileDetail.FileName),
            Status = FileDetail.Status,
            FileName = FileDetail.FileName
        };

    }
    [WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static void DeleteWebFile(string name)
    {

        List<UploadeFile> FileDetailList = (List<UploadeFile>)HttpContext.Current.Session["UploadeFileList"];
        UploadeFile FileDetail = FileDetailList.Find(P => P.FileName == name);
        FileDetailList.Remove(FileDetail);
        HttpContext.Current.Session["UploadeFileList"] = FileDetailList;
        string path = HttpContext.Current.Server.MapPath("img");
        string FilePath = Path.Combine(path, name);
        if (File.Exists(FilePath))
            File.Delete(FilePath);
        path = Path.Combine(HttpContext.Current.Server.MapPath("img"), "Thmb");
        FilePath = Path.Combine(path, name);
        if (File.Exists(FilePath))
            File.Delete(FilePath);

    }
    #endregion
    protected void imgBtnSubmit_Click(object sender, EventArgs e)
    {
        string path = ""; string Album_Name = txtprdname.Text.Trim().Replace("'", "''"); LblmsgHead.Text = "";
        SQL_DB.ExecuteNonQuery("UPDATE [M_Album] SET [Album_Name] = 'aa' WHERE Album_Id='ALB101'");
        if (Request.Files.Count > 0)
        {
            DeleteFiles("ALB101");
            SaveFile("ALB101");
        }
        divmsg.Visible = true;
        divmsg.Attributes.Add("class", "alert_boxes_green big_msg");
        lblmsg.Text = "Record Saved Successfully...";
        string script = @"setTimeout(function(){document.getElementById('" + divmsg.ClientID + "').style.display='none';},5000);";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        fillDataImage();
    }
    private void SaveFile(string Id)
    {
        string Qry = "";
        string path = Server.MapPath("Gallary");
        PostedFiles();
        if (Session["UploadeFileList"] == null)
            return;
        List<UploadeFile> FileDetail = (List<UploadeFile>)Session["UploadeFileList"];
        string strr = Uttils.Create_Directory(Server.MapPath("Gallary\\" + Id.ToString()));
        for (int i = 0; i < FileDetail.Count; i++)
        {
            try
            {
                string imgName = strr + "//" + Id + "_" + i.ToString() + ".jpg";
                string temp = imgName;
                Stream m = FileDetail[i].File;
                System.Drawing.Image img = System.Drawing.Image.FromStream(m);

                Bitmap newThumbnail = new Bitmap(img, 305, 320);
                imgName = path + "//" + Id + "_" + i.ToString() + ".jpg";
                newThumbnail.Save(imgName);

                Qry = Qry + " INSERT INTO [T_Album_Image] " +
                "([Album_Id]" +
                ",[Image_Name])" +
                " VALUES " +
                " ('" + Id +
                " ','" + Id + "_" + i.ToString() + ".jpg')";
            }
            catch { }

        }
        if (Qry != "")
            SQL_DB.ExecuteNonQuery(Qry);
        Session["UploadeFileList"] = null;
        list.InnerHtml = "";
    }
    private void PostedFiles()
    {
        HttpFileCollection uploads = HttpContext.Current.Request.Files;
        List<UploadeFile> FileDetailList = new List<UploadeFile>();
        if (Session["UploadeFileList"] != null)
            FileDetailList = (List<UploadeFile>)Session["UploadeFileList"];
        UploadeFile FileD;
        for (int i = 0; i < uploads.Count; i++)
        {
            HttpPostedFile upload = uploads[i];
            if (upload.ContentLength == 0)
                continue;
            string d = upload.ContentType;
            if (d.IndexOf("image") < 0)
                continue;
            FileD = new UploadeFile();
            FileD.File = upload.InputStream;
            FileD.FileName = upload.FileName;
            FileD.Status = 1;
            FileDetailList.Add(FileD);
        }
        if (FileDetailList.Count > 0)
            Session["UploadeFileList"] = FileDetailList;
    }
    private void DeleteFiles(string Id)
    {
        DataSet ds = new DataSet();
        SQL_DB.GetDA("SELECT [Album_Id],[Image_Name] FROM [T_Album_Image] where Album_Id='" + Id + "'").Fill(ds, "1");
        string path = Server.MapPath("Gallary");
        for (int i = 0; i < ds.Tables["1"].Rows.Count; i++)
        {
            string s = path + "//" + ds.Tables["1"].Rows[i]["Image_Name"].ToString();
            DataProvider.Utility.DeleteFiles(s);
            //if (File.Exists(path + "//" + ds.Tables["1"].Rows[i]["Image_Name"].ToString()))
            //    File.Delete(path + "//" + ds.Tables["1"].Rows[i]["Image_Name"].ToString());
        }
        SQL_DB.ExecuteNonQuery("delete from [T_Album_Image] where [Album_Id]='" + Id + "'");
    }
    protected void imgBtnReset_Click(object sender, EventArgs e)
    {
        Clear();
    }



    private void Clear()
    {
        LblmsgHead.Text = string.Empty;
        txtprdname.Text = "";
        imgBtnSubmit.Text = "Save";//.ImageUrl = "../images/Button/save.png";
        list.InnerHtml = "";
        Session["UploadeFileList"] = null;
    }

    private void FillGrid()
    {

    }

}