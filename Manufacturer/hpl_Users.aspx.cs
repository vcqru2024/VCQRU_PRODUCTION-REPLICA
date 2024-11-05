using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using ClosedXML.Excel;

public partial class Manufacturer_hpl_Users : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            UpdateStatus(1, true);
            UpdateStatus(2, false);

            BindGridView();
        }
    }

    private void BindGridView()
    {
        DataTable dt = SQL_DB.ExecuteDataTable("SELECT UserEmail, MobileNo, Location, CreatedDate, IsActive as Status FROM tbl_Hpl_Users WHERE   Isdelete = 0");
        if (dt.Rows.Count > 0)
        {
            grd1.DataSource = dt;
            grd1.DataBind();



        }
        else
        {
            grd1.DataSource = null;
            grd1.DataBind();
            grd1.EmptyDataText = "No records found.";
        }
    }

    protected void chkStatus_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkStatus = (CheckBox)sender;
        GridViewRow row = (GridViewRow)chkStatus.NamingContainer;
        int rowIndex = row.RowIndex;
        string userEmail = row.Cells[0].Text;
        int userID = GetUserIDByEmail(userEmail);
        bool newStatus = chkStatus.Checked;
        UpdateStatus(userID, newStatus);
    }


    private int GetUserIDByEmail(string email)
    {
        int UserRole = Convert.ToInt32(SQL_DB.ExecuteScalar("select Userrole_id from tbl_Hpl_Users where UserEmail='" + email + "'").ToString());
        return UserRole;
    }

    private void UpdateStatus(int userID, bool newStatus)
    {
        if (newStatus == false)
        {
            string Qry1 = "update tbl_Hpl_Users set IsActive='0' where Userrole_id='" + userID + "'";
            SQL_DB.ExecuteNonQuery1(Qry1);
        }

        else if (newStatus == true)
        {
            string QRY2 = "update tbl_Hpl_Users set IsActive='1' where Userrole_id='" + userID + "'";
            SQL_DB.ExecuteNonQuery1(QRY2);
        }
    }

    protected void grd1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridViewRow row = grd1.Rows[e.NewEditIndex];
        // int UserId = Convert.ToInt32(grd1.DataKeys[e.NewEditIndex].Value);
        // int UserId = Convert.ToInt32(grd1.DataKeys[e.NewEditIndex].Values[userIdIndex]);
        string emailId = row.Cells[0].Text;
        int userID = GetUserIDByEmail(emailId);
        Response.Redirect("hpl_userregistration.aspx?UserId=" + emailId + "");
    }

    protected void grd1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridViewRow row = grd1.Rows[e.RowIndex];
        string userEmail = row.Cells[0].Text;
        int userID = GetUserIDByEmail(userEmail);
        DeleteUser(userID);
        BindGridView();
    }


    private void DeleteUser(int userID)
    {
        SQL_DB.ExecuteNonQuery("update tbl_Hpl_Users set Isdelete=1 where Userrole_id='" + userID + "'");
    }

    protected void grd1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow row = grd1.Rows[e.RowIndex];
        string userEmail = row.Cells[0].Text;
        string mobileNo = row.Cells[1].Text;
        string location = row.Cells[2].Text;
        string createdDate = row.Cells[3].Text;
        string userID = row.Cells[4].Text;
        UpdateUser(Convert.ToInt32(userID), userEmail, mobileNo, location, createdDate);
        grd1.EditIndex = -1;
        BindGridView();
    }

    private void UpdateUser(int userID, string userEmail, string mobileNo, string location, string createdDate)
    {
        // Implement logic to update user in the database
    }

    protected void grd1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        grd1.EditIndex = -1;
        BindGridView();
    }

    protected void btn_download_Click(object sender, EventArgs e)
    {
        using (var workbook = new XLWorkbook())
        {
            var worksheet = workbook.Worksheets.Add("Sheet1");
            for (int i = 0; i < grd1.Columns.Count; i++)
            {
                worksheet.Cell(1, i + 1).Value = grd1.Columns[i].HeaderText;
            }
            for (int i = 0; i < grd1.Rows.Count; i++)
            {
                for (int j = 0; j < grd1.Columns.Count; j++)
                {
                    worksheet.Cell(i + 2, j + 1).Value = grd1.Rows[i].Cells[j].Text;
                }
            }
            Response.Clear();
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment;filename=Users.xlsx");
            using (MemoryStream memoryStream = new MemoryStream())
            {
                workbook.SaveAs(memoryStream);
                memoryStream.WriteTo(Response.OutputStream);
                memoryStream.Close();
            }
            Response.End();
        }
    }
}