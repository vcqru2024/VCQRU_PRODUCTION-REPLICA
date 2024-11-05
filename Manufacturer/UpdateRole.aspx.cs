using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Drawing;

public partial class Manufacturer_UpdateRole : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {


        }
    }




    protected void ViewReport(object sender, EventArgs e)
    {

    }

    protected void ImgSearch_Click(object sender, EventArgs e)
    {
        lblMsg1.Text = "";
        Label2.Text = "";
        string UserMobileNo1 = string.Empty;
        string qrystr = "";
        if (UserMobileNo.Text != "")
        {
            UserMobileNo1 = UserMobileNo.Text;
        }


        if (UserMobileNo.Text == "")
        {
            Response.Redirect("UpdateRole.aspx");
        }




        if (UserMobileNo.Text != "")
        {
            qrystr = "select top 1 Entry_Date,ConsumerName,MobileNo,M_Consumerid,Vrkabel_User_Type,cin_number,ref_cin_number from M_Consumer where right(MobileNo,10)  = '" + UserMobileNo1.Substring(UserMobileNo1.Length - 10, 10).ToString() + "' and Comp_id='Comp-1400'  order by M_Consumerid desc  ";

            string kycsstt = "0";
            DataTable dt = new DataTable();
            dt = SQL_DB.ExecuteDataTable(qrystr);
            if (dt.Rows.Count > 0)
            {
                FormUpdate.Visible = true;
                CNBoyItem.Enabled = true;
                ElectrItem.Enabled = true;
                RetailerItem.Enabled = false;
                DealerItem.Enabled = false;
                lblMsg1.Text = "";
                // txtKYC.Text = dt.Rows[0]["Vrkabel_User_Type"].ToString();
                HiddenM_ConID.Value = dt.Rows[0]["M_Consumerid"].ToString();
               // cin_number.Text = dt.Rows[0]["cin_number"].ToString();
                RefCinNo.Text = dt.Rows[0]["ref_cin_number"].ToString();
                ConName.Text = dt.Rows[0]["ConsumerName"].ToString();
                HiddenRole.Value = dt.Rows[0]["Vrkabel_User_Type"].ToString();
                if (dt.Rows[0]["Vrkabel_User_Type"].ToString() != "")
                {
                    kycsstt = dt.Rows[0]["Vrkabel_User_Type"].ToString();
                }

               
             
                UserRole.SelectedIndex = Convert.ToInt32(kycsstt);
                if (kycsstt == "0")
                {
                   // cin_number.Visible = true;
                    RefCinNo.Visible = true;
                    Lblcin_Refnumber.Visible = true;
                   // Lblcin_number.Visible = true;
                }
                if (kycsstt == "1" || kycsstt == "2")
                {
                    
          
                    string qrystr2 = "select Received_Code1 from Pro_Enq where right(MobileNo,10)  = '" + UserMobileNo1.Substring(UserMobileNo1.Length - 10, 10).ToString() + "' and Is_success='1' ";
                    DataTable dt2ProEnq = new DataTable();
                    dt2ProEnq = SQL_DB.ExecuteDataTable(qrystr2);

                    string qrystr3 = "select ConsumerName from M_Consumer where ref_cin_number  = '" + dt.Rows[0]["cin_number"].ToString() + "' and Comp_id='Comp-1400'  order by M_Consumerid desc  ";
                    DataTable dtRefUser = new DataTable();
                    dtRefUser = SQL_DB.ExecuteDataTable(qrystr3);
                    
                    if (dt2ProEnq.Rows.Count >0 && dtRefUser.Rows.Count > 0)
                    {
                        
                        FormUpdate.Visible = false;
                        lblMsg1.ForeColor = Color.Red;
                        lblMsg1.Text = dt.Rows[0]["ConsumerName"].ToString() + " can't be change role because He have " + dtRefUser.Rows.Count + " reference user and  He have checked " + dt2ProEnq.Rows.Count + " success codes!"; 

                    }else if (dt2ProEnq.Rows.Count > 0 && dtRefUser.Rows.Count <= 0)
                    {

                        FormUpdate.Visible = false;
                        lblMsg1.ForeColor = Color.Red;
                        lblMsg1.Text = dt.Rows[0]["ConsumerName"].ToString() + " can't be change role because He have  checked " + dt2ProEnq.Rows.Count + " success codes!";

                    }
                    else if (dt2ProEnq.Rows.Count <= 0 && dtRefUser.Rows.Count > 0)
                    {

                        FormUpdate.Visible = false;
                        lblMsg1.ForeColor = Color.Red;
                        lblMsg1.Text = dt.Rows[0]["ConsumerName"].ToString() + " can't be change role because He have " + dtRefUser.Rows.Count + " reference user !";

                    }
                    else 
                    {
                        CNBoyItem.Enabled = true;
                        ElectrItem.Enabled = true;
                        RetailerItem.Enabled = true;
                        DealerItem.Enabled = true;
                        
                    }

                }
                
                if (kycsstt == "3" || kycsstt == "4")
                {
                    RefCinNo.Visible = true;
                    RetailerItem.Enabled = false;
                    DealerItem.Enabled = false;
                    // cin_number.Visible = false;
                    Lblcin_Refnumber.Visible = true;                    
                    // Lblcin_number.Visible = false;
                }

            }
            else
            {
                FormUpdate.Visible = false;
                lblMsg1.ForeColor = Color.Red;
                lblMsg1.Text = "invalid Mobile Number!";
            }

        }
    }
    protected void ImgRefresh_Click1(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        if (UserRole.Text != "" && HiddenM_ConID.Value != "")
        {

            if ( (UserRole.Text != "1" && RefCinNo.Text.Trim().Length > 3) || (UserRole.Text == "1" && RefCinNo.Text.Trim().Length < 1))
            {

            lblMsg1.Text = "";
            Label2.Text = "";
            string result = string.Empty;
            DataTable dt = new DataTable();

            dt = SQL_DB.ExecuteDataTable("select M_Consumerid from M_Consumer where M_Consumerid='" + HiddenM_ConID.Value + "' and Comp_id='Comp-1400'");

            if (dt.Rows.Count > 0)
            {

                string qrySerach = "select top 1 M_Consumerid from M_Consumer where ";
                    if (UserRole.Text == "1")
                    {
                        qrySerach += " M_Consumerid = '" + HiddenM_ConID.Value + "'";
                    }
                    if (UserRole.Text == "2")
                    {
                        qrySerach += "cin_number = '" + RefCinNo.Text.Trim() + "' and M_Consumerid != '" + HiddenM_ConID.Value + "' and Vrkabel_User_Type = '1' ";
                    }

                    if (UserRole.Text == "3" || UserRole.Text == "4")
                    {
                   // qrySerach += "cin_number = '" + RefCinNo.Text.Trim() + "' and M_Consumerid != '" + HiddenM_ConID.Value + "' and Vrkabel_User_Type = '2' ";
					 qrySerach += "cin_number = '" + RefCinNo.Text.Trim() + "' and M_Consumerid != '" + HiddenM_ConID.Value + "' ";
                    }


                dt = SQL_DB.ExecuteDataTable(qrySerach);

                if (dt.Rows.Count > 0)
                {

                    if (UserRole.Text == "1")
                    {
                        SQL_DB.ExecuteNonQuery("update m_consumer set Vrkabel_User_Type='" + UserRole.Text + "',ref_cin_number=''  where M_Consumerid='" + HiddenM_ConID.Value + "'");
                    }
                    if (UserRole.Text == "2")
                    {
                        SQL_DB.ExecuteNonQuery("update m_consumer set Vrkabel_User_Type='" + UserRole.Text + "',ref_cin_number='" + RefCinNo.Text.Trim() + "'  where M_Consumerid='" + HiddenM_ConID.Value + "'");
                    }
                    if (UserRole.Text == "3" || UserRole.Text == "4")
                    {
                        SQL_DB.ExecuteNonQuery("update m_consumer set cin_number='', ref_cin_number='" + RefCinNo.Text.Trim() + "', Vrkabel_User_Type='" + UserRole.Text.Trim() + "'  where M_Consumerid='" + HiddenM_ConID.Value + "'");
                    }

                    string qrystr1 = "select M_Consumerid,ConsumerName,cin_number,ref_cin_number,Vrkabel_User_Type from M_Consumer where M_Consumerid='" + HiddenM_ConID.Value + "'";
                    DataTable dt1 = new DataTable();
                    dt1 = SQL_DB.ExecuteDataTable(qrystr1);
                    if (dt1.Rows.Count > 0)
                    {
                        // txtKYC.Text = dt.Rows[0]["Vrkabel_User_Type"].ToString();
                        HiddenM_ConID.Value = dt1.Rows[0]["M_Consumerid"].ToString();
                        //cin_number.Text = dt1.Rows[0]["cin_number"].ToString();
                        ConName.Text = dt1.Rows[0]["ConsumerName"].ToString();
                        RefCinNo.Text = dt1.Rows[0]["ref_cin_number"].ToString();
                        UserRole.SelectedIndex = Convert.ToInt32(dt1.Rows[0]["Vrkabel_User_Type"]);
                    }
                        //NewMsgpop.Visible = true;
                        Label2.ForeColor = Color.Green;
                        Label2.Text = "Record updated Successfully!<br>";
                }
                else
                {
                        Label2.ForeColor = Color.Red;
                        Label2.Text = "Invalid Reference CIN number!<br>";
                }

            }
            else
            {
                    Label2.ForeColor = Color.Red;
                    Label2.Text = "Invalid Mobile Number!<br>";

            }
            }
            else
            {
                Label2.ForeColor = Color.Red;
                Label2.Text = "Please enter valid Reference CIN number!<br>";
            }
        }
        else
        {

            Label2.ForeColor = Color.Red;
            Label2.Text = "Please select User Role !<br>";

        }
    
}


    protected void ImgRefresh_Click2(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("UpdateRole.aspx");
    }

    protected void UserRole_SelectedIndexChanged(object sender, EventArgs e)
    {
      string RoleValue =  UserRole.SelectedValue;
        string HiddenRoleVal = HiddenRole.Value;
        Button1.Visible = true;
        if (HiddenRoleVal == RoleValue)
        {
            Button1.Visible = false;
            Label2.ForeColor = Color.Red;
            Label2.Text = "Please select other user!<br>";
        }

        if (RoleValue == "2")
        {
            Lblcin_Refnumber.Visible = true;
            RefCinNo.Visible = true;
            RefCinNo.Text = "";
            RefCinNo.ReadOnly = false;
          //  cin_number.Visible = false;

        }
        else if (RoleValue == "1")
        {
            Lblcin_Refnumber.Visible = false;
            RefCinNo.Visible = false;
            RefCinNo.Text = "";
            RefCinNo.ReadOnly = true;
        }
        else if (RoleValue == "3" || RoleValue == "4")
        {
            Lblcin_Refnumber.Visible = true;
            RefCinNo.Visible = true;
            RefCinNo.Text = "";
        }


    }
}