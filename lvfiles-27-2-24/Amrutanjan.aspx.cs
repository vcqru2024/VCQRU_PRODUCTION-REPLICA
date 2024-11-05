using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.Web.UI.WebControls;

public partial class Amrutanjan : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

         if (!string.IsNullOrWhiteSpace(Request.QueryString["customer_number"]))
        {

            //  ServiceLogic.MissedcallLogs(customer_number, data);


            string customer_number = Request.QueryString["customer_number"].ToString();
            string call_date = Request.QueryString["call_date"].ToString();
            string call_time = Request.QueryString["call_time"].ToString();
            string call_uuid = Request.QueryString["call_uuid"].ToString();
            string call_status = Request.QueryString["call_status"].ToString();

            string Resdata = SaveMissedcallData(call_date, call_time, customer_number, call_uuid, call_status);

            return;
        }
        else
        {

        }

        hfproductId.Value = Request.QueryString["Id"];

    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        lblmessage.Text = "";
       
        if (txtParticipantName.Text == "")
        {
            lblmessage.Text = "Please enter participant name";
            lblmessage.ForeColor = System.Drawing.Color.Red;
            myModal.Visible = true;
            myModal.Attributes.Add("class", "modal show");
            return;
        }
        if (txtPhoneNumber.Text == "")
        {
            lblmessage.Text = "Please enter your phone";
            lblmessage.ForeColor = System.Drawing.Color.Red;
            myModal.Visible = true;
            myModal.Attributes.Add("class", "modal show");
            return;
        }
 else
        {
            DataSet dtTrans = new DataSet();
            dtTrans = ExecuteNonQueryAndDatatable.GetStoreProcedure("GetAmrutanjanMobileNovalidate", "@PhoneNumber", txtPhoneNumber.Text.Trim(), "@ProductId", hfproductId.Value.Trim());
            if(dtTrans.Tables[0].Rows.Count>0)
            {
                string ProductName = dtTrans.Tables[0].Rows[0]["ProductName"].ToString();


                lblmessage.Text = "You are already registered for the contest of "+ ProductName + "";
                lblmessage.ForeColor = System.Drawing.Color.Red;
                myModal.Visible = true;
                myModal.Attributes.Add("class", "modal show");
                return;
            }
        }

        if (txtAddress.Text == "")
        {
            lblmessage.Text = "Please enter your address";
            lblmessage.ForeColor = System.Drawing.Color.Red;
            myModal.Visible = true;
            myModal.Attributes.Add("class", "modal show");
            return;
        }
        if (txtCity.Text == "")
        {
            lblmessage.Text = "Please enter your city";
            lblmessage.ForeColor = System.Drawing.Color.Red;
            myModal.Visible = true;
            myModal.Attributes.Add("class", "modal show");
            return;
        }
        if (txtState.Text == "")
        {
            lblmessage.Text = "Please enter your state";
            lblmessage.ForeColor = System.Drawing.Color.Red;
            myModal.Visible = true;
            myModal.Attributes.Add("class", "modal show");
            return;
        }
        if (ddlgender.SelectedItem.Text == "--Select Gender--")
        {
            lblmessage.Text = "Please select your gender";
            lblmessage.ForeColor = System.Drawing.Color.Red;
            myModal.Visible = true;
            myModal.Attributes.Add("class", "modal show");
            return;
        }
        if (txtAge.Text == "")
        {
            lblmessage.Text = "Please enter your age";
            lblmessage.ForeColor = System.Drawing.Color.Red;
            myModal.Visible = true;
            myModal.Attributes.Add("class", "modal show");
            return;
        }
        if (txtAge.Text.Length >= 3)
        {
            lblmessage.Text = "Please enter valid age";
            lblmessage.ForeColor = System.Drawing.Color.Red;
            myModal.Visible = true;
            myModal.Attributes.Add("class", "modal show");
            return;
        }
        if (txtPhoneNumber.Text.Length <10)
        {
            lblmessage.Text = "Please enter valid phone number";
            lblmessage.ForeColor = System.Drawing.Color.Red;
            myModal.Visible = true;
            myModal.Attributes.Add("class", "modal show");
            return;
        }

        Imageupload();
        if (hfuploadfile.Value == "")
        {
            lblmessage.Text = "Please upload proof of purchase";
            myModal.Attributes.Add("class", "modal show");
            return;
        }
        else
        {
           

            int Icount = ExecuteNonQueryAndDatatable.InsUpdStoreProcedure("Sp_InsUdpParticipantDetails", "@ParticipantName", txtParticipantName.Text.Trim(), "@PhoneNumber", txtPhoneNumber.Text.Trim(), "@Gender", ddlgender.Text.Trim(), "@Age", txtAge.Text.Trim(), "@Address", txtAddress.Text.Trim(), "@City", txtCity.Text.Trim(), "@State", txtState.Text.Trim(), "@ProofofPurchase", hfuploadfile.Value.Trim(), "@Mode", "QR Code", "@ActType", "I", "@ProductId", hfproductId.Value.Trim());
            if (Icount != 0)
            {
                txtParticipantName.Text = "";
                txtPhoneNumber.Text = "";
                txtAddress.Text = "";
                txtCity.Text = "";
                txtState.Text = "";
                txtAge.Text = "";
                Response.Redirect("AmrutanjanSuccess.aspx");
                //Redirect To Success page
                lblmessage.Text = "Request accepted successfull.";

            }
            else
                lblmessage.Text = "Request accepted successfull.";
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
          //  FileUpload1.SaveAs(folderPath + Path.GetFileName(FileUpload1.FileName));

            //Display the Picture in Image control.
            

            if (FileUpload1.HasFile)
            {
                string img = string.Empty;
                Bitmap bmpImg = null;
                try
                {
                    bmpImg = Resize_Image(FileUpload1.PostedFile.InputStream, 700, 500);
                    string FileName= Guid.NewGuid().ToString() + ".png";
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

public string SaveMissedcallData(string call_date, string call_time, string customer_number, string call_uuid, string call_status)
    {
        string data = "customer_number : " + customer_number + " | call_status : " + call_status + " | call_uuid : " + call_uuid + " | call_date : " + call_date + " | call_time : " + call_time;
        ServiceLogic.MissedcallLogs(customer_number, data);
        string mob = customer_number.Substring(3, 10);
        string Status = "Failure";
        if (call_status == "success")
        {
            DataSet dtTrans = new DataSet();
            //SQL_DB.ExecuteNonQuery1("INSERT INTO [dbo].[tblMissedCallData] (customer_number, call_uuid, call_date,call_time,call_status) values ('" + customer_number + "','" + call_uuid + "','" + call_date + "','" + call_time + "','" + call_status + "')").ToString();
            SQL_DB.ExecuteNonQuery1("INSERT INTO [dbo].[tblParticipant] (PhoneNumber, Mode) values ('" + mob + "','Missed Call')").ToString();
            Status = "Success";
        }
        return Status;
    }
}