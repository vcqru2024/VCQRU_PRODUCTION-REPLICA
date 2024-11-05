
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Uploadbill : System.Web.UI.Page
{
    public class Querystring
    {
        public string M_Consumerid { get; set; }
        public string MobileNo { get; set; }
        public string Code1 { get; set; }
        public string Code2 { get; set; }
        public string BillURL { get; set; }
    }
    Querystring Res = new Querystring();
    protected void Page_Load(object sender, EventArgs e)
    {
        btnUpload.Visible = true;
        Res.M_Consumerid = Request.QueryString["M_Consumerid"];
        Res.MobileNo = Request.QueryString["MobileNo"];
        Res.Code1 = Request.QueryString["Code1"];
        Res.Code2 = Request.QueryString["Code2"];
        if (!string.IsNullOrEmpty(Res.M_Consumerid) && !string.IsNullOrEmpty(Res.MobileNo) && !string.IsNullOrEmpty(Res.Code1))
        {
            SQL_DB.ExecuteNonQuery("Update tbl_HYPERSONIC_UploadBill set Isactive=0 , Isdelete=1 where  M_Consumerid='"+ Res.M_Consumerid + "' and MobileNo='"+ Res.MobileNo + "'");
        }
        else
        {
            lblMessage.Visible = true;
            lblMessage.Text = "You Can't Upload File!!!!";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            btnUpload.Visible = false;
        }
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        if (fileupload.HasFile)
        {
            try
            {
                lblMessage.Text = "";
                string path = string.Empty;
                string virtualPath = string.Empty;

                string ext = Path.GetExtension(fileupload.FileName);
                if(ext==".JPEG"|| ext == ".jpeg" || ext == ".JPG" || ext == ".jpg" || ext == ".PNG" || ext == ".png" || ext == ".PDF" || ext == ".pdf")
                {
                    var fileName = Path.GetFileNameWithoutExtension(fileupload.FileName) + "_" + Guid.NewGuid().ToString() + "." + Path.GetExtension(fileupload.FileName);

                    path = Path.Combine(Server.MapPath("~/WarrantyFile"), fileName);
                    virtualPath = Path.Combine("~/WarrantyFile", fileName);
                    fileupload.SaveAs(path);
                    string newPath = path.Replace(@"C:\inetpub\wwwroot\httpdocs\", "/");
                    SQL_DB.ExecuteNonQuery("insert into tbl_HYPERSONIC_UploadBill (M_Consumerid,MobileNo,Code1,Code2,BillPath) values('" + Res.M_Consumerid + "','" + Res.MobileNo + "','" + Res.Code1 + "','" + Res.Code2 + "','" + newPath + "')");
                    lblMessage.Visible = true;
                    lblMessage.ForeColor = System.Drawing.Color.Black;
                     lblMessage.Text = "Thank you for uploading file.";
                    btnUpload.Visible = false;
                    uploadfile.Visible = false;
                }
                else
                {
                    lblMessage.Visible = true;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Image should be in (.jpg, .png, & pdf ) format.";
                }
               
            }
            catch(Exception ex)
            {
                lblMessage.Visible = true;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error"+ ex.Message;
            }
        }
        else
        {
            lblMessage.Visible = true;
            lblMessage.ForeColor = System.Drawing.Color.Red;
            lblMessage.Text = "Plz upload the image!!!!";
        }
    }
}