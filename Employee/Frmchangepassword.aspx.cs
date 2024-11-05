using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business9420;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using Business_Logic_Layer;

public partial class Employee_Frmchangepassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
        if (Session["User_Type"] == null)
            Response.Redirect("../default.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("../default.aspx");
        }        
        if (!Page.IsPostBack)
            newMsg.Visible = false;
    }    
  
    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        if (txtnewpass.Text == txtreenterpass.Text)
        {
            User_Details Reg = new User_Details();
            Reg.OldPassword = txtoldpass.Text;
            Reg.Password = txtnewpass.Text;
            Reg.User_Type = "Employee";
            Reg.EmployeeID = ProjectSession.Empid;
            Reg.DML = "emp";
            Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(System.DateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
            DataTable dt= SQL_DB.ExecuteDataTable("SELECT * FROM Employee WHERE  EmployeeID = " + Reg.EmployeeID  + " AND pwd = '" + Reg.OldPassword + "'");
            if (dt.Rows.Count > 0)
            {
                // User_Details.ChangePassConsumer(Reg);
                SQL_DB.ExecuteNonQuery("UPDATE [EMPLOYEE] SET [PWD] = '" + Reg.Password + "',[modifieddate] = '" + Reg.Entry_Date.ToString("MM/dd/yyyy") + "'  WHERE [Employeeid] = " + Reg.EmployeeID);
                newMsg.Visible = true;
                newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
                Label2.Text = "Password changed successfully !";
                //LblMsg.Text = "";
            }
            else
            {
                newMsg.Visible = true;
                newMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
                Label2.Text = "Incorrect old password";
            }

        }
        else
        {
            //newMsg.Visible = false;
            //LblMsg.Text = "Password not matched";
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            Label2.Text = "Password not matched";
        }
        Clear();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Clear();
        //  LblMsg.Text = "";
        Label2.Text = "";
        newMsg.Visible = false;
    }
    private void Clear()
    {
        txtnewpass.Text = ""; txtoldpass.Text = ""; txtreenterpass.Text = "";
        // LblMsg.Text = "";
    }
}