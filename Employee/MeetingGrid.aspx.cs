using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Business9420;
using System.Web.Services;
using System.Web.Script.Services;
using System.IO;
using Business_Logic_Layer;
using EmpMeetingBAL;
public partial class Employee_MeetingGrid : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/default.aspx#trylogin");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect(ProjectSession.absoluteSiteBrowseUrl + "/default.aspx");
        }
        if (!IsPostBack)
        {
            FillDDL();
            FillGrid();

        }
    }
    public void FillDDL()
    {
        DataTable dt = SQL_DB.ExecuteDataSet("Select * from Employee where isnull(active,1) = 1 and isnull(dalete,1)=0 ").Tables[0];
        if (dt.Rows.Count > 0)
        {
            ddlEmployeeName.DataSource = dt;          
            ddlEmployeeName.DataTextField = "name";
            ddlEmployeeName.DataValueField = "Employeeid";
            ddlEmployeeName.DataBind();
            ddlEmployeeName.Items.Insert(0, new ListItem("Select","0"));

             DataTable dt2 =  SQL_DB.ExecuteDataSet("Select Emp_Type from Employee where Employeeid= " + ProjectSession.Empid).Tables[0];
            if (dt2.Rows.Count>0)
            {
                if (dt2.Rows[0]["Emp_Type"].ToString() == "1")
                {
                    ddlEmployeeName.SelectedValue = ProjectSession.Empid.ToString();
                    ddlEmployeeName.Enabled = false;
                }
                else if (dt2.Rows[0]["Emp_Type"].ToString() == "2")
                {
                    DataTable dt3 =  SQL_DB.ExecuteDataSet("select distinct employeeid,(select name from employee where employee.employeeid =Employee_Meeting.employeeid) as name from Employee_Meeting where EmployeeSupervisor = " + ProjectSession.Empid).Tables[0];
                    ddlEmployeeName.DataSource = dt3;
                    ddlEmployeeName.DataTextField = "name";
                    ddlEmployeeName.DataValueField = "Employeeid";
                    ddlEmployeeName.DataBind();
                    ddlEmployeeName.Items.Insert(0, new ListItem("Select", "0"));
                }
                //else
                //{
                //    ddlEmployeeName.DataSource = dt3;
                //    ddlEmployeeName.DataTextField = "name";
                //    ddlEmployeeName.DataValueField = "Employeeid";
                //    ddlEmployeeName.DataBind();
                //    ddlEmployeeName.Items.Insert(0, new ListItem("Select", "0"));
                //}
            }
            
        }
    }
    public  void FillGrid()
    {
        DateTime? dtfrom = null;
        if (!string.IsNullOrEmpty(txtDateFrom.Text))
        {
            dtfrom = DateTime.Parse(txtDateFrom.Text);
        }
        DateTime? dtTo = null;
        if (!string.IsNullOrEmpty(txtDateto.Text))
        {
            dtTo = DateTime.Parse(txtDateto.Text);
        }


        
        DataSet ds1 = Employee_MeetingBAL.SelectAll(Convert.ToInt32(ddlEmployeeName.SelectedValue),
            txtCompClientName.Text,txtMobileNo.Text,dtfrom,dtTo,ProjectSession.Empid);
        DataTable dt2 = ds1.Tables[0];
        if (dt2.Rows.Count > 0)
        {
            //if (dt2.Rows[0]["Emp_Type"].ToString() == "2")
            //{
                
            //    ddlEmployeeName.Enabled = true;
            //}
            //else
            //{
            //    ddlEmployeeName.SelectedValue = dt2.Rows[0]["Employeeid"].ToString();
            //    ddlEmployeeName.Enabled = false;
            //}
            
        }
        DataTable dt = ds1.Tables[1];
       // if (dt.Rows.Count > 0)
        {
            GrdLabel.DataSource = dt;
            GrdLabel.DataBind();
            if (GrdLabel.Rows.Count > 0)
            {
                GrdLabel.HeaderRow.TableSection = TableRowSection.TableHeader;
                lblcount.Text = GrdLabel.Rows.Count.ToString();
            }
        }

    }
    protected void GrdLabel_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        // string MeetingID = e.CommandArgument.ToString();
        if (e.CommandName == "EditRows")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GrdLabel.Rows[index];
            string meetid = ((Label)row.FindControl("MeetingID")).Text;
            Response.Redirect("Metting.aspx?Mtid=" + meetid);
        }
        else if (e.CommandName == "De-Activated")
        {

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GrdLabel.Rows[index];
            ((ImageButton)row.FindControl("ImgDeActivated")).Visible = true;
            ((ImageButton)row.FindControl("ImgImgIsActive")).Visible = false;
            string meetid = ((Label)row.FindControl("MeetingID")).Text;
            SQL_DB.ExecuteNonQuery("Update Employee_Meeting set IsActive = 0 where MeetingID= " + meetid);
            FillGrid();
        }
        else if (e.CommandName == "IsActive")
        {

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GrdLabel.Rows[index];
            ((ImageButton)row.FindControl("ImgDeActivated")).Visible = false;
            ((ImageButton)row.FindControl("ImgImgIsActive")).Visible = true;
            string meetid = ((Label)row.FindControl("MeetingID")).Text;
            SQL_DB.ExecuteNonQuery("Update Employee_Meeting set IsActive = 1 where MeetingID= " + meetid);
            FillGrid();
        }
        else if (e.CommandName == "DeleteRow")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GrdLabel.Rows[index];
            string meetid = ((Label)row.FindControl("MeetingID")).Text;
            SQL_DB.ExecuteNonQuery("Update Employee_Meeting set IsDelete = 1 where MeetingID= " + meetid);
            FillGrid();
        }
    }

    protected void GrdLabel_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }

    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        FillGrid();
    }

    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        // Server.Transfer();
        txtCompClientName.Text = "";
        txtMobileNo.Text = "";
        txtMeetingTime.Text = "";
        txtDateFrom.Text = "";
        txtDateto.Text = "";


    }

    protected void btnAddEmp_Click(object sender, EventArgs e)
    {
        Response.Redirect("Metting.aspx");
    }

    protected void GrdLabel_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //int index = e.Row.RowIndex;
            //GridViewRow gvr = GrdLabel.Rows[index];
            //GrdLabel.Rows[index].FindControl("ImgDeActivated")
        }
    }
}