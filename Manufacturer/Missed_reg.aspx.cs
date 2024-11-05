using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;

public partial class Manufacturer_Missed_reg : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        edit();
    }

    public void edit()
    {
        if (Request.QueryString["idd"] != null && Request.QueryString["idd"] != "")
        {
            if (!IsPostBack)
            {

                try
                {
                    DataTable dta = new DataTable();
                    dta = SQL_DB.ExecuteDataTable("select * from tblParticipant  where  tblParticipant.Id='" + Request.QueryString["idd"] + "'");
                    txtPhoneNumber.Text = dta.Rows[0]["PhoneNumber"].ToString();
                    ddlproduct.SelectedValue = dta.Rows[0]["ProductId"].ToString();
                    txtParticipantName.Text = dta.Rows[0]["ParticipantName"].ToString();
                    ddlgender.SelectedValue = dta.Rows[0]["Gender"].ToString();
                    txtAge.Text = dta.Rows[0]["Age"].ToString();
                    pin.Value = dta.Rows[0]["Pin_code"].ToString();
                    txtAddress.Text = dta.Rows[0]["Address"].ToString();
                    txtCity.Text = dta.Rows[0]["City"].ToString();
                    txtState.Text = dta.Rows[0]["State"].ToString();
                    ViewState["img"]= dta.Rows[0]["ProofforPurchase"].ToString();
                    btnsave.Text = "Update";
                }
                catch(Exception ex)
                {

                }
               
            }
        }
    }
    private void Imageupload()
    {
        if (FileUpload1.HasFile)
        {
            string folderPath = Server.MapPath("~/Amrutanjan/Img");

            //Check whether Directory (Folder) exists.
            if (!Directory.Exists(folderPath))
            {
                //If Directory (Folder) does not exists Create it.
                Directory.CreateDirectory(folderPath);
            }

            //Save the File to the Directory (Folder).
            FileUpload1.SaveAs(folderPath + Path.GetFileName(FileUpload1.FileName));

          


            if (FileUpload1.HasFile)
            {
                string img = string.Empty;
                Bitmap bmpImg = null;
                try
                {
                    bmpImg = Resize_Image(FileUpload1.PostedFile.InputStream, 700, 500);
                    string FileName = Guid.NewGuid().ToString() + ".png";
                    img = Server.MapPath("~/Amrutanjan/Img") + FileName;
                    bmpImg.Save(img, ImageFormat.Jpeg);
                    hfuploadfile.Value = "/Amrutanjan/Img" + FileName;
                }
                catch (Exception ex)
                {
                    Response.Write("Error occured: " + ex.Message.ToString());
                }
                finally
                {
                    img = string.Empty;
                    bmpImg.Dispose();
                }
            }

        }
    }


    private Bitmap Resize_Image(Stream streamImage, int maxWidth, int maxHeight)
    {
        Bitmap originalImage = new Bitmap(streamImage);
        int newWidth = originalImage.Width;
        int newHeight = originalImage.Height;
        double aspectRatio = Convert.ToDouble(originalImage.Width) / Convert.ToDouble(originalImage.Height);

        if (aspectRatio <= 1 && originalImage.Width > maxWidth)
        {
            newWidth = maxWidth;
            newHeight = Convert.ToInt32(Math.Round(newWidth / aspectRatio));
        }
        else if (aspectRatio > 1 && originalImage.Height > maxHeight)
        {
            newHeight = maxHeight;
            newWidth = Convert.ToInt32(Math.Round(newHeight * aspectRatio));
        }
        return new Bitmap(originalImage, newWidth, newHeight);
    }

    protected void btnsave_Click(object sender, EventArgs e)
    {
        if (btnsave.Text == "Update")
        {
            try
            {
                Imageupload();
                //File.Delete(Server.MapPath("~/Amrutanjan/Img"+ ViewState["img"]));
                if (hfuploadfile.Value != "")
                {
                    Imageupload();
                    SQL_DB.ExecuteScalar("update tblParticipant set ParticipantName='" + txtParticipantName.Text + "',PhoneNumber='" + txtPhoneNumber.Text + "',Gender='" + ddlgender.SelectedValue + "',Age='" + txtAge.Text + "',Address='" + txtAddress.Text + "',City='" + txtCity.Text + "',State='" + txtState.Text + "',Pin_code='" + pin.Value + "',ProofforPurchase='" + hfuploadfile.Value + "',ProductId='" + ddlproduct.SelectedValue + "' where Id='" + Request.QueryString["idd"] + "' ");
                }
                else
                {
                    SQL_DB.ExecuteScalar("update tblParticipant set ParticipantName='" + txtParticipantName.Text + "',PhoneNumber='" + txtPhoneNumber.Text + "',Gender='" + ddlgender.SelectedValue + "',Age='" + txtAge.Text + "',Address='" + txtAddress.Text + "',City='" + txtCity.Text + "',State='" + txtState.Text + "',Pin_code='" + pin.Value + "',ProductId='" + ddlproduct.SelectedValue + "' where Id='" + Request.QueryString["idd"] + "' ");
                }
                clear();
                btnsave.Text = "Register";
                Response.Write("<script>alert('Update Successfully ! ')</script>");
                Response.Redirect("AmrutanjanParticipantDetails.aspx");
            } 
            catch(Exception ex)
            {

            }
            
           
        }
    }
    public void clear()
    {
        txtParticipantName.Text = "";
        txtPhoneNumber.Text = "";
        txtAddress.Text = "";
        txtCity.Text = "";
        pin.Value = "";
        txtState.Text = "";
        txtAge.Text = "";
        ddlgender.SelectedIndex = 0;
        ddlproduct.SelectedIndex = 0;
    }

    protected void BtnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("AmrutanjanParticipantDetails.aspx");
    }
}