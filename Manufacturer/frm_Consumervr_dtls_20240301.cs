using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using ClosedXML.Excel;

public partial class Manufacturer_frm_Consumervr_dtls : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindState();
            // bindrole();
            bindrole2();
            userType.Items.Insert(0, new ListItem("Select user type", "0"));
            userType.Enabled = true;


            ddlvrrole.Items.Insert(0, new ListItem("Select user type", "0"));
            ddlvrrole.Enabled = false;
            ddlsubrole.Items.Insert(0, new ListItem("Select user", "0"));
            ddlsubrole.Enabled = false;
            ddlallreg.Items.Insert(0, new ListItem("--Select--", "0"));
            ddlallreg.Enabled = false;
        }
    }
    
    protected void btn_download_Click_drpdown(object sender, EventArgs e)
    {

        if (Page.IsValid)
        {
            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();

                string qrystr = "select distinct User_Type ,ConsumerName as ConsumerName,cin_number as CINNumber, MobileNo as MobileNumber,gender as Gender,Email as Emailid,mc.Entry_Date as EntryDate,mc.ref_cin_number as RefCinNumber,bnk.Account_No as AccountNumber,bnk.IFSC_Code as IfscCode, bnk.bank_name,bnk.branch,bnk.city, mc.aadharNumber as AaddharNumber, mc.pancard_number as PanCardNumber,shop_name, case when mc.VRKbl_KYC_status='1' then 'Approved' when mc.VRKbl_KYC_status='2' then 'Rejected' when mc.VRKbl_KYC_status='3' then 'Send Request again' else 'Pending' end  KYCStatus ,mc.remark from vr_user vu inner join M_Consumer mc on vu.id=mc.Vrkabel_User_Type left join M_BankAccount bnk on bnk.M_Consumerid=mc.M_Consumerid where state='" + ddlstate.SelectedItem + "'";
                if (ddlvrrole.SelectedValue != "0")
                {
                    qrystr += " AND  Vrkabel_User_Type = '" + ddlvrrole.SelectedValue + "'";
                }

                if (ddlsubrole.SelectedValue != "0")
                {
                    qrystr = "select distinct User_Type ,ConsumerName as ConsumerName,cin_number as CINNumber, MobileNo as MobileNumber,gender as Gender,Email as Emailid,mc.Entry_Date as EntryDate,mc.ref_cin_number as RefCinNumber,bnk.Account_No as AccountNumber,bnk.IFSC_Code as IfscCode, bnk.bank_name,bnk.branch,bnk.city,  mc.aadharNumber as AaddharNumber, mc.pancard_number as PanCardNumber,shop_name, case when mc.VRKbl_KYC_status='1' then 'Approved' when mc.VRKbl_KYC_status='2' then 'Rejected' when mc.VRKbl_KYC_status='3' then 'Send Request again' else 'Pending' end  KYCStatus ,mc.remark from vr_user vu inner join M_Consumer mc on vu.id=mc.Vrkabel_User_Type left join M_BankAccount bnk on bnk.M_Consumerid=mc.M_Consumerid where ref_cin_number='" + ddlsubrole.SelectedValue + "'";

                    //qrystr += " AND ref_cin_number = '" + ddlsubrole.SelectedValue + "'";
                }
                SqlCommand cmd = new SqlCommand(qrystr, con);

                 SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();

                 XLWorkbook wb = new XLWorkbook();
                 wb.Worksheets.Add(dt, "User_details");
                 MemoryStream stream = new MemoryStream();
                 wb.SaveAs(stream);
                 Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=User_details.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

    
   
    protected void ViewReport(object sender, EventArgs e)
    {

    }
    protected void btn_download_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {     
        
            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();

                string datefromstr = string.Empty;
                string datetostr = string.Empty;
                string userType1 = "1";
                string qrystr = "";

                if (txtDateFrom.Text == "" && txtDateto.Text == "" && userType.SelectedValue == "0")
                {
                   
                    qrystr = "select vr.User_Type as UserType, mc.ConsumerName,mc.sur_name as SurName,mc.gender as Gender, mc.Email as Emailid,mc.MobileNo,mc.City,mc.district as District, mc.state as State,mc.PinCode, mc.cin_number as CinNumbr,Entry_Date as EntryDate, case when mc.VRKbl_KYC_status='1' then 'Approved' when mc.VRKbl_KYC_status='2' then 'Rejected' when mc.VRKbl_KYC_status='3' then 'Send Request again' else 'Pending' end  KYCStatus,shop_name from M_Consumer mc inner join vr_user vr on vr.id=mc.Vrkabel_User_Type where  mc.Vrkabel_User_Type = '9' ";
                }

                if (txtDateFrom.Text != "")
                {
                    datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
                }
                if (txtDateto.Text != "")
                {
                    datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
                }
                if (userType.SelectedValue != "0")
                {
                    userType1 = userType.SelectedValue;
                }

                if (userType.SelectedValue != "0" && (txtDateFrom.Text == "" && txtDateto.Text == ""))
                {
                   // qrystr = "select vr.User_Type as UserType, mc.ConsumerName,mc.sur_name as SurName,mc.gender as Gender, mc.Email as Emailid,mc.MobileNo,mc.City,mc.district as District, mc.state as State,mc.PinCode, mc.cin_number as CinNumbr,Entry_Date as EntryDate, case when mc.VRKbl_KYC_status='1' then 'Approved' when mc.VRKbl_KYC_status='2' then 'Rejected' when mc.VRKbl_KYC_status='3' then 'Send Request again' else 'Pending' end  KYCStatus from M_Consumer mc inner join vr_user vr on vr.id=mc.Vrkabel_User_Type where  mc.Vrkabel_User_Type = '" + userType1 + "' ";
                    qrystr = "select vr.User_Type as UserType, mc.ConsumerName,mc.sur_name as SurName,mc.gender as Gender, mc.Email as Emailid,mc.MobileNo,mc.City,mc.district as District, mc.state as State,mc.PinCode, mc.cin_number as CinNumbr,mc.Entry_Date as EntryDate,mc.ref_cin_number as RefCinNumber,bnk.Account_No as AccountNumber,bnk.IFSC_Code as IfscCode, bnk.bank_name,bnk.branch,bnk.city, mc.aadharNumber as AaddharNumber, mc.pancard_number as PanCardNumber, case when mc.VRKbl_KYC_status='1' then 'Approved' when mc.VRKbl_KYC_status='2' then 'Rejected' when mc.VRKbl_KYC_status='3' then 'Send Request again' else 'Pending' end  KYCStatus,shop_name ,mc.remark from M_Consumer mc inner join vr_user vr on vr.id=mc.Vrkabel_User_Type left join M_BankAccount bnk on bnk.M_Consumerid=mc.M_Consumerid where  mc.Vrkabel_User_Type = '" + userType1 + "' ";
                }

                if (userType.SelectedValue == "0" && (txtDateFrom.Text != "" && txtDateto.Text != ""))
                {
                   // qrystr = " select vr.User_Type as UserType,mc.ConsumerName,mc.sur_name as SurName,mc.gender as Gender, mc.Email as Emailid,mc.MobileNo,mc.City,mc.district as District, mc.state as State,mc.PinCode, mc.cin_number as CinNumbr,Entry_Date as EntryDate, case when mc.VRKbl_KYC_status='1' then 'Approved' when mc.VRKbl_KYC_status='2' then 'Rejected' when mc.VRKbl_KYC_status='3' then 'Send Request again' else 'Pending' end  KYCStatus from M_Consumer mc inner join vr_user vr on vr.id=mc.Vrkabel_User_Type where mc.Entry_Date >= '" + datefromstr + "' and mc.Entry_Date <= '" + datetostr + "'  ";
                    qrystr = "select vr.User_Type as UserType,mc.ConsumerName,mc.sur_name as SurName,mc.gender as Gender, mc.Email as Emailid,mc.MobileNo,mc.City,mc.district as District, mc.state as State,mc.PinCode, mc.cin_number as CinNumbr,mc.Entry_Date as EntryDate,mc.ref_cin_number as RefCinNumber,bnk.Account_No as AccountNumber,bnk.IFSC_Code as IfscCode, bnk.bank_name,bnk.branch,bnk.city, mc.aadharNumber as AaddharNumber, mc.pancard_number as PanCardNumber, case when mc.VRKbl_KYC_status='1' then 'Approved' when mc.VRKbl_KYC_status='2' then 'Rejected' when mc.VRKbl_KYC_status='3' then 'Send Request again' else 'Pending' end  KYCStatus,shop_name ,mc.remark from M_Consumer mc inner join vr_user vr on vr.id=mc.Vrkabel_User_Type left join M_BankAccount bnk on bnk.M_Consumerid=mc.M_Consumerid where mc.Entry_Date >= '" + datefromstr + "' and mc.Entry_Date <= '" + datetostr + "'  ";
                }
                if (userType.SelectedValue != "0" && txtDateFrom.Text != "" && txtDateto.Text != "")
                {
                   // qrystr = "select vr.User_Type as UserType, mc.ConsumerName,mc.sur_name as SurName,mc.gender as Gender, mc.Email as Emailid,mc.MobileNo,mc.City,mc.district as District, mc.state as State,mc.PinCode, mc.cin_number as CinNumbr,Entry_Date as EntryDate, case when mc.VRKbl_KYC_status='1' then 'Approved' when mc.VRKbl_KYC_status='2' then 'Rejected' when mc.VRKbl_KYC_status='3' then 'Send Request again' else 'Pending' end  KYCStatus from M_Consumer mc inner join vr_user vr on vr.id=mc.Vrkabel_User_Type where mc.Entry_Date >= '" + datefromstr + "' and mc.Entry_Date <= '" + datetostr + "' and mc.Vrkabel_User_Type = '" + userType1 + "' ";
                    qrystr = "select vr.User_Type as UserType, mc.ConsumerName,mc.sur_name as SurName,mc.gender as Gender, mc.Email as Emailid,mc.MobileNo,mc.City,mc.district as District, mc.state as State,mc.PinCode, mc.cin_number as CinNumbr,mc.Entry_Date as EntryDate,mc.ref_cin_number as RefCinNumber,bnk.Account_No as AccountNumber,bnk.IFSC_Code as IfscCode, bnk.bank_name,bnk.branch,bnk.city, mc.aadharNumber as AaddharNumber, mc.pancard_number as PanCardNumber, case when mc.VRKbl_KYC_status='1' then 'Approved' when mc.VRKbl_KYC_status='2' then 'Rejected' when mc.VRKbl_KYC_status='3' then 'Send Request again' else 'Pending' end  KYCStatus,shop_name ,mc.remark from M_Consumer mc inner join vr_user vr on vr.id=mc.Vrkabel_User_Type left join M_BankAccount bnk on bnk.M_Consumerid=mc.M_Consumerid where mc.Entry_Date >= '" + datefromstr + "' and mc.Entry_Date <= '" + datetostr + "' and mc.Vrkabel_User_Type = '" + userType1 + "' ";
                }

                //SqlCommand cmd = new SqlCommand("select  mc.ConsumerName,mc.sur_name as SurName,mc.gender as Gendr, mc.Email as Emailid,mc.MobileNo,mc.City,mc.district as District, mc.state as State,mc.PinCode, mc.cin_number as CinNumbr,Entry_Date as EntryDate from M_Consumer mc inner join vr_user vr on vr.id=mc.Vrkabel_User_Type where mc.Entry_Date >= '" + datefromstr + "' and mc.Entry_Date <= '" + datetostr + "' ", con);
                SqlCommand cmd = new SqlCommand(qrystr, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();

                 XLWorkbook wb = new XLWorkbook();
                 wb.Worksheets.Add(dt, "User_details");
                 MemoryStream stream = new MemoryStream();
                 wb.SaveAs(stream);
                 Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment; filename=User_details.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

    protected void ImgSearch_Click(object sender, EventArgs e)
    {
        string datefromstr = string.Empty;
        string datetostr = string.Empty;
        string userType1 = "1";
        string qrystr = "";
        if (txtDateFrom.Text != "") { 
        datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
            }
        if (txtDateto.Text != "")
        {
            datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
        }
        if (userType.SelectedValue != "0")
        {
            userType1 = userType.SelectedValue;
        }

        if (userType.SelectedValue == "0" && txtDateFrom.Text == "" && txtDateto.Text == "")
        {
            Response.Redirect("frm_Consumervr_dtls.aspx");
        }


        if (userType.SelectedValue != "0" && (txtDateFrom.Text == "" && txtDateto.Text == ""))
        {
             qrystr = "select vr.User_Type as UserType, mc.M_Consumerid, mc.ConsumerName,mc.sur_name as SurName,mc.gender as Gender, mc.Email as Emailid,mc.MobileNo as MobileNumber,mc.City,mc.district as District, mc.state as State,mc.PinCode, mc.cin_number as CinNumbr,Entry_Date as EntryDate, case when mc.VRKbl_KYC_status='1' then 'Approved' when mc.VRKbl_KYC_status='2' then 'Rejected' when mc.VRKbl_KYC_status='3' then 'Send Request again' else 'Pending' end  KYCStatus from M_Consumer mc inner join vr_user vr on vr.id=mc.Vrkabel_User_Type where  mc.Vrkabel_User_Type = '" + userType1 + "' ";

        }

        if (userType.SelectedValue == "0" && (txtDateFrom.Text != "" && txtDateto.Text != ""))
        {
            qrystr = "select vr.User_Type as UserType, mc.M_Consumerid,mc.ConsumerName,mc.sur_name as SurName,mc.gender as Gender, mc.Email as Emailid,mc.MobileNo as MobileNumber,mc.City,mc.district as District, mc.state as State,mc.PinCode, mc.cin_number as CinNumbr,Entry_Date as EntryDate, case when mc.VRKbl_KYC_status='1' then 'Approved' when mc.VRKbl_KYC_status='2' then 'Rejected' when mc.VRKbl_KYC_status='3' then 'Send Request again' else 'Pending' end  KYCStatus from M_Consumer mc inner join vr_user vr on vr.id=mc.Vrkabel_User_Type where mc.Entry_Date >= '" + datefromstr + "' and mc.Entry_Date <= '" + datetostr + "'  ";
 
        }
        if (userType.SelectedValue != "0" && txtDateFrom.Text != "" && txtDateto.Text != "")
        {
            qrystr = "select vr.User_Type as UserType, mc.M_Consumerid,mc.ConsumerName,mc.sur_name as SurName,mc.gender as Gender, mc.Email as Emailid,mc.MobileNo as MobileNumber,mc.City,mc.district as District, mc.state as State,mc.PinCode, mc.cin_number as CinNumbr,Entry_Date as EntryDate, case when mc.VRKbl_KYC_status='1' then 'Approved' when mc.VRKbl_KYC_status='2' then 'Rejected' when mc.VRKbl_KYC_status='3' then 'Send Request again' else 'Pending' end  KYCStatus from M_Consumer mc inner join vr_user vr on vr.id=mc.Vrkabel_User_Type where mc.Entry_Date >= '" + datefromstr + "' and mc.Entry_Date <= '" + datetostr + "' and mc.Vrkabel_User_Type = '" + userType1 + "' ";
  
        }
      

        if (Page.IsValid)
        {
            try
            {
                SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
                con.Open();
                //DataTable newdt = SQL_DB.ExecuteDataTable("select ref_cin_number from M_Consumer where M_Consumerid='10745'");
                ///string ssss = qrystr
                SqlCommand cmd = new SqlCommand(qrystr, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                grd1.DataSource = dt;
                grd1.DataBind();
                countRows.InnerText = "Total user : " + dt.Rows.Count.ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
    }

    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("frm_Consumervr_dtls.aspx");
    }
    public void bindrole2()
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("select*from vr_user", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
        userType.DataValueField = "id";
        userType.DataTextField = "User_Type";
        userType.DataSource = dt;
        userType.DataBind();
        //userType.Items.Insert(0, new ListItem("--Select--", "0"));

    }
    public void BindState()
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        //DataTable newdt = SQL_DB.ExecuteDataTable("select cin_number from M_Consumer where M_Consumerid='10745'");
        SqlCommand cmd = new SqlCommand("select*from tbl_jal_statelist ", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();

       // ddlstate.Enabled = true;
        ddlstate.DataValueField = "id";
        ddlstate.DataTextField = "State_name";
        ddlstate.DataSource = dt;
        ddlstate.DataBind();
        ddlstate.Items.Insert(0, new ListItem("Select State", "0"));


    }

    public void bindrole()
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("select * from vr_user ", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
        ddlvrrole.DataValueField = "id";
        ddlvrrole.DataTextField = "User_Type";
        ddlvrrole.DataSource = dt;
        ddlvrrole.DataBind();
        ddlvrrole.Items.Insert(0, new ListItem("--Select user type--", "0"));

    }

    protected void ddlvrrole_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlvrrole.SelectedValue == "0" )
        {
            ddlsubrole.Enabled = false;
            ddlsubrole.SelectedValue = "0";
        }
        else
        {
            SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
            con.Open();
            //DataTable newdt = SQL_DB.ExecuteDataTable("select cin_number from M_Consumer where M_Consumerid='10745'");
            SqlCommand cmd = new SqlCommand("select vu.User_Type as UserType,ConsumerName as ConsumerName,M_Consumerid,cin_number as CINNumber, MobileNo as MobileNumber,gender as Gender,Email as Emailid, Entry_Date as EntryDate,case when mc.VRKbl_KYC_status='1' then 'Approved' when mc.VRKbl_KYC_status='2' then 'Rejected' when mc.VRKbl_KYC_status='3' then 'Send Request again' else 'Pending' end  KYCStatus  from vr_user vu inner join M_Consumer mc on vu.id=mc.Vrkabel_User_Type where Vrkabel_User_Type ='" + ddlvrrole.SelectedValue+"' and state='"+ddlstate.SelectedItem+"'", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            if (ddlvrrole.SelectedValue == "1" || ddlvrrole.SelectedValue == "2")
            {
                ddlsubrole.Enabled = true;
                ddlsubrole.DataValueField = "CINNumber";
                ddlsubrole.DataTextField = "ConsumerName";
                ddlsubrole.DataSource = dt;
                ddlsubrole.DataBind();
                ddlsubrole.Items.Insert(0, new ListItem("Select user", "0"));
                grd1.DataSource = dt;
                grd1.DataBind();
                countRows.InnerText = "Total user : " + dt.Rows.Count.ToString();
            }
            else if(ddlvrrole.SelectedValue == "3" || ddlvrrole.SelectedValue == "4")
            {
                grd1.DataSource = dt;
                grd1.DataBind();
                countRows.InnerText = "Total user : " + dt.Rows.Count.ToString();
            }
        }
    }

    protected void ddlsubrole_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        //DataTable newdt = SQL_DB.ExecuteDataTable("select ref_cin_number from M_Consumer where M_Consumerid='10745'");
        SqlCommand cmd = new SqlCommand("select vr.User_Type as UserType,mc.ConsumerName,M_Consumerid,mc.sur_name as SurName,mc.gender as Gender, mc.Email as Emailid, MobileNo as MobileNumber,mc.City,mc.district as District, mc.state as State,mc.PinCode, mc.cin_number as CinNumbr,Entry_Date as EntryDate,case when mc.VRKbl_KYC_status='1' then 'Approved' when mc.VRKbl_KYC_status='2' then 'Rejected' when mc.VRKbl_KYC_status='3' then 'Send Request again' else 'Pending' end  KYCStatus from M_Consumer mc inner join vr_user vr on vr.id=mc.Vrkabel_User_Type where  ref_cin_number='" + ddlsubrole.SelectedValue + "'", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
        grd1.DataSource = dt;
        grd1.DataBind();
        countRows.InnerText = "Total user : " + dt.Rows.Count.ToString();
    }
    /*
    public void Filter()
    {
        if (ddlsubrole.SelectedValue == "0")
        {
            ddlallreg.Enabled = false;
            ddlallreg.SelectedValue = "0";
        }
        else
        {
            SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
            con.Open();
            DataTable newdt = SQL_DB.ExecuteDataTable("select ref_cin_number from M_Consumer where M_Consumerid='10745'");
            SqlCommand cmd = new SqlCommand("select distinct vr.User_Type from M_Consumer mc inner join vr_user vr on vr.id = mc.Vrkabel_User_Type where ref_cin_number ='" + newdt.Rows[0][0].ToString() + "'", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            ddlallreg.Enabled = true;
            ddlallreg.DataValueField = "";
            ddlallreg.DataTextField = "User_Type";
            ddlallreg.DataSource = dt;
            ddlallreg.DataBind();
            ddlallreg.Items.Insert(0, new ListItem("--Select--", "0"));
        }
    }
    */



    protected void ddlstate_SelectedIndexChanged(object sender, EventArgs e)
    
    {
        if (ddlstate.SelectedValue == "0")
        {
            ddlvrrole.Enabled = false;
            ddlvrrole.SelectedValue = "0";
        }
        else
        {
            ddlvrrole.Enabled = true;
            bindrole();
            state_grid();
        }
    }

    public void state_grid()
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();
        //DataTable newdt = SQL_DB.ExecuteDataTable("select*from tbl_jal_statelist",con);
        // SqlCommand cmd = new SqlCommand("select case when cast( Vrkabel_User_Type as varchar(2)) = '1' then 'Dealer' when cast(Vrkabel_User_Type as varchar(2)) = '2' then 'Retailer' when cast(Vrkabel_User_Type as varchar(2)) = '3' then 'Electrician' when cast(Vrkabel_User_Type as varchar(2)) = '4' then 'Counter Boy' else cast(Vrkabel_User_Type as varchar(2)) end as UserType,ConsumerName as ConsumerName,cin_number as CINNumber, MobileNo as MobileNumber,gender as Gender,Email as Emailid, Entry_Date as EntryDate from vw_stateVR where State_Name= '" + ddlstate.SelectedValue + "'", con);
        SqlCommand cmd = new SqlCommand("select DISTINCT(mc.MobileNo) as MobileNumber, mc.M_Consumerid, case when mc.Vrkabel_User_Type = '1' then 'Dealer' when mc.Vrkabel_User_Type = '2' then 'Retailer' when mc.Vrkabel_User_Type = '3' then 'Electrician' else 'Counter Boy'  end as UserType, mc.ConsumerName as ConsumerName,mc.cin_number as CINNumber, mc.MobileNo as MobileNumber,mc.gender as Gender,mc.Email as Emailid, mc.Entry_Date as EntryDate,case when mc.VRKbl_KYC_status='1' then 'Approved' when mc.VRKbl_KYC_status='2' then 'Rejected' when mc.VRKbl_KYC_status='3' then 'Send Request again' else 'Pending' end  KYCStatus from M_Consumer mc, vw_stateVR vc where vc.state = mc.state and vc.State_Name= '" + ddlstate.SelectedValue + "'", con);

       
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        DataTable dta = new DataTable();
        da.Fill(dt);
        con.Close();
        grd1.DataSource = dt;
        grd1.DataBind();
        countRows.InnerText = "Total user : " + dt.Rows.Count.ToString();
    }

    protected void grd1_PageIndexChanged(object sender, EventArgs e)
    {
        //grd1.PageIndex = e.NewPageIndex;
        //Bindgrid();
    }
}