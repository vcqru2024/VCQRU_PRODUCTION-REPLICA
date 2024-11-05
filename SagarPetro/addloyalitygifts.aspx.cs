using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class SagarPetro_addloyalitygifts : System.Web.UI.Page
{
    cls_message db = new cls_message();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Comp_ID"] == null)
            Response.Redirect("../SagarPetro/Loginpfl.aspx?from=addloyalitygifts");
        if (!IsPostBack)
        {
            bindgrid();
        }
    }

    public void bindgrid()
    {
        DataTable dt = SQL_DB.ExecuteDataTable("select gift_id,Gift_name,Gift_value,Gift_desc,Gift_image,status from Claim_gift where CompID='" + Session["CompanyId"].ToString() + "' and Isdelete=0");
        grd1.DataSource = dt.Rows.Count > 0 ? dt : null;
        grd1.DataBind();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string giftName = txtgiftname.Text.Trim();
        string giftValue = txtgiftvalue.Text.Trim();
        string giftDescription = txtgiftdesc.Text.Trim();
        string giftid = hdngiftid.Value.Trim();
        if (btnSubmit.Text== "Update")
        {
            if (string.IsNullOrEmpty(giftName) || string.IsNullOrEmpty(giftValue) || string.IsNullOrEmpty(giftDescription))
            {
                db.ShowErrorMessage(this, "Please Fill The Details");
                return;
            }
            SQL_DB.ExecuteNonQuery("update claim_gift set Gift_name='"+ giftName + "' ,Gift_value='"+ giftValue + "',Gift_desc='"+ giftDescription + "' where gift_id='"+ giftid + "'");
            db.ShowSuccessMessagewithredirect(this, "Gift Updated Successfully", "../SagarPetro/addloyalitygifts.aspx");
        }
        else
        {
            if (Page.IsValid)
            {
                

                if (string.IsNullOrEmpty(giftName) || string.IsNullOrEmpty(giftValue) || string.IsNullOrEmpty(giftDescription))
                {
                    db.ShowErrorMessage(this, "Please Fill The Details");
                    return;
                }

                if (FileUpload1.HasFile)
                {
                    string fileExtension = Path.GetExtension(FileUpload1.FileName).ToLower();
                    string[] allowedExtensions = { ".jpg", ".jpeg", ".png" };
                    if (Array.Exists(allowedExtensions, element => element == fileExtension))
                    {
                        try
                        {
                            string sanitizedGiftName = Regex.Replace(giftName, @"[^a-zA-Z0-9_]+", "_");

                            // Generate a unique filename
                            string uniqueFileName = GenerateUniqueFileName(sanitizedGiftName, fileExtension);

                            string relativePath = "images/Gift/" + uniqueFileName;
                            string filePath = Server.MapPath("~/images/Gift/") + uniqueFileName;

                            // Save file
                            FileUpload1.SaveAs(filePath);

                            // Insert into database
                            SQL_DB.ExecuteNonQuery("INSERT INTO Claim_gift (Gift_name, Gift_value, Gift_desc, Gift_image, status, CompID) VALUES ('" + giftName + "', '" + giftValue + "', '" + giftDescription + "', '" + relativePath + "', '0', '" + Session["Comp_id"].ToString() + "')");
                            db.ShowSuccessMessagewithredirect(this, "Gift Added Successfully", "../SagarPetro/addloyalitygifts.aspx");
                            // Bind grid
                           // bindgrid();

                            // Clear textboxes
                            txtgiftname.Text = "";
                            txtgiftvalue.Text = "";
                            txtgiftdesc.Text = "";
                        }
                        catch (Exception ex)
                        {
                            // Handle the error
                            db.ShowErrorMessage(this, "An error occurred while uploading the file: " + ex.Message);
                        }
                    }
                    else
                    {
                        db.ShowErrorMessage(this, "Only .jpg, .jpeg, and .png files are allowed.");
                    }
                }
                else
                {
                    db.ShowErrorMessage(this, "Please upload an image file.");
                }
                System.Threading.Thread.Sleep(3000); // Consider removing this delay
            }
        }
        
    }

    private string GenerateUniqueFileName(string sanitizedGiftName, string fileExtension)
    {
        string fileName = sanitizedGiftName + fileExtension;
        string uniqueFileName = fileName;
        int count = 1;

        // Check if the file already exists, generate a new name if it does
        while (File.Exists(Server.MapPath("~/images/Gift/") + uniqueFileName))
        {
            uniqueFileName = string.Format("{0}_{1}{2}", sanitizedGiftName, count, fileExtension);
            count++;
        }

        return uniqueFileName;
    }
    protected void grd1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "UpdateStatus")
        {
            string gift_id = e.CommandArgument.ToString();
            // Implement your logic to update the status of the gift
            SQL_DB.ExecuteNonQuery("UPDATE Claim_gift SET status = CASE WHEN status = '0' THEN '1' ELSE '0' END WHERE gift_id = '" + gift_id + "' AND CompID = '" + Session["CompanyId"].ToString() + "'");
            bindgrid();
        }
        else if (e.CommandName == "DeleteGift")
        {
            string gift_id = e.CommandArgument.ToString();
            // Implement your logic to delete the gift
            SQL_DB.ExecuteNonQuery("update claim_gift set Isdelete=1 where CompID='"+ Session["CompanyId"].ToString() + "' and gift_id='"+ gift_id + "'");
            bindgrid();
        }
        else if (e.CommandName == "editgift")
        {

            string gift_id = e.CommandArgument.ToString();
            hdngiftid.Value = gift_id;
            // Implement your logic to delete the gift
            DataTable dtgift = SQL_DB.ExecuteDataTable("Select * from claim_gift where gift_id='"+ gift_id + "'");
            if (dtgift.Rows.Count > 0)
            {
                txtgiftname.Text = dtgift.Rows[0]["Gift_name"].ToString();
                txtgiftvalue.Text = dtgift.Rows[0]["Gift_value"].ToString();
                txtgiftdesc.Text = dtgift.Rows[0]["Gift_desc"].ToString();
                imgdiv.Visible = false;
                btncancel.Text = "Clear";
                btnSubmit.Text = "Update";
            }
            bindgrid();
        }
    }

    protected void grd1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            var isActive = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "status"));
            var userId = DataBinder.Eval(e.Row.DataItem, "gift_id").ToString();
            var ltToggleAction = e.Row.FindControl("ltToggleAction") as Literal;

            if (ltToggleAction != null)
            {
                var color = isActive ? "green" : "red";
                ltToggleAction.Text = string.Format("<a type='button' class='dropdown-item' href='javascript:void(0);' onclick='Activeinactive(\"{0}\", {1})' style='color: {4};'>" +
                                                    "<i class='fas {2}'></i> {3}</a>",
                                                    userId,
                                                    isActive.ToString().ToLower(),
                                                    isActive ? "fa-toggle-on" : "fa-toggle-off",
                                                    isActive ? "Deactivate" : "Activate",
                                                    color);
            }
        }
    }

    protected void btncancel_Click(object sender, EventArgs e)
    {
        txtgiftname.Text = "";
        txtgiftdesc.Text = "";
        txtgiftvalue.Text = "";
        FileUpload1.Attributes.Clear();
    }
}