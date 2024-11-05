using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_FrmUserReport : System.Web.UI.Page
{

   public static bool flag = false;
    protected void Page_Load(object sender, EventArgs e)
    {
    
        
        if (Session["User_Type"] == null)
            Response.Redirect("~/Login.aspx?Page=FrmUploadDealerCode.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("~/adminLogin.aspx");
        }

        if(!IsPostBack)
        {

            DataTable dtservice = SQL_DB.ExecuteDataTable("select distinct ms.Service_ID,ms.ServiceName from M_ServiceSubscription subs inner join M_Service ms on ms.Service_ID=subs.Service_ID where Comp_ID='" + HttpContext.Current.Session["CompanyId"].ToString() + "' and subs.IsActive=1");
            ddlService.DataSource = dtservice;
            ddlService.DataValueField = "Service_ID";
            ddlService.DataTextField = "ServiceName";
            ddlService.DataBind();
            ddlService.SelectedIndex = 0;
            ddlDocuments.SelectedIndex = 0;
            //DataSet ds= LoadbindUsrRpt(1);

            //dtvurpt.DataSource = ds.Tables["1"];
            //dtvurpt.DataBind();

            //lblcount.Text = ds.Tables["1"].Rows.Count.ToString();
            DataSet dscnt = GetCustomerscount(ddlService.SelectedValue);
            txttlcnt.Text = dscnt.Tables[0].Rows.Count.ToString();
            txtdocumentcount.Text = dscnt.Tables[1].Rows.Count.ToString();
            DataSet ds = GetCustomersData(1, ddlService.SelectedValue,"",ddlDocuments.SelectedValue,"", DateTime.Today.ToString("yyyy-MM-dd") + " 23:59:59.999");

            rptCustomers.DataSource = ds;
            rptCustomers.DataBind();
        }
        if (IsPostBack)
        {
            flag = true;
            if (txtMobile.Text.Length > 0)
            {
                if (txtMobile.Text.All(char.IsDigit) && Convert.ToInt32(txtMobile.Text.Substring(0,1))>5)
                {
                    REFmoblie.IsValid = true;
                    DataSet dscnt = GetCustomerscount(ddlService.SelectedValue);
                    txttlcnt.Text = dscnt.Tables[0].Rows.Count.ToString();
                    txtdocumentcount.Text = dscnt.Tables[1].Rows.Count.ToString();
                    DataSet ds = GetCustomersData(1, ddlService.SelectedValue, txtMobile.Text,ddlDocuments.SelectedValue,"", DateTime.Today.ToString("yyyy-MM-dd") + " 23:59:59.999");

                    rptCustomers.DataSource = ds;
                    rptCustomers.DataBind();
                }
                else
                {
                    REFmoblie.IsValid = false;

                }
            }
            else
            {
                DataSet dscnt = GetCustomerscount(ddlService.SelectedValue);
                txttlcnt.Text = dscnt.Tables[0].Rows.Count.ToString();
                txtdocumentcount.Text = dscnt.Tables[1].Rows.Count.ToString();
                string datefrom = "";
                string dateto = "";
                if (txtDateFrom.Text != "")
                {
                     datefrom =Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd") + " 00:00:00.000";
                }
                if (txtDateto.Text != "")
                {
                     dateto = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd") + " 23:59:59.999";
                }
                else
                {
                    dateto = DateTime.Today.ToString("yyyy-MM-dd") + " 23:59:59.999";
                }
                DataSet ds = GetCustomersData(1, ddlService.SelectedValue,"",ddlDocuments.SelectedValue, datefrom, dateto);

                rptCustomers.DataSource = ds;
                rptCustomers.DataBind();
            }
        }
    }
protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        txtDateFrom.Text = "";
        txtDateto.Text = "";
  ddlService.SelectedIndex = 0;
            ddlDocuments.SelectedIndex = 0;
txtMobile.Text="";
       
    }
    [WebMethod]
    public static string GetCustomers(int pageIndex,string service,string document, string mobile,string datefrom,string dateto)
    {
        flag = false;
        if (datefrom != "")
        {
            datefrom = Convert.ToDateTime(datefrom).ToString("yyyy-MM-dd") + " 00:00:00.000";
        }
        if (dateto != "")
        {
            dateto = Convert.ToDateTime(dateto).ToString("yyyy-MM-dd") + " 23:59:59.999";
        }
        else
        {
            dateto = DateTime.Today.ToString("yyyy-MM-dd") + " 23:59:59.999";
        }
        return GetCustomersData(pageIndex,service,mobile,document,datefrom,dateto).GetXml();
    }
    public static DataSet GetCustomersData(int pageIndex,string service,string mobile,string document,string datefrom,string dateto)
    {
        SqlCommand cmd;
        if (mobile== "")
        {
            string query = "[usp_UserRpt]";
             cmd = new SqlCommand(query);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@PageNumber", pageIndex);
            cmd.Parameters.AddWithValue("@PageSize", 10);
            cmd.Parameters.AddWithValue("@service", service);
            cmd.Parameters.AddWithValue("@document", document);
            cmd.Parameters.AddWithValue("@datefrom", datefrom);
            cmd.Parameters.AddWithValue("@dateto", dateto);
            cmd.Parameters.AddWithValue("@comp_id", HttpContext.Current.Session["CompanyId"].ToString());

            cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
            return GetData(cmd,true);
        }
        else if(flag)
        {
            string query = "[usp_mobilesearch]";
             cmd = new SqlCommand(query);
            cmd.CommandType = CommandType.StoredProcedure;
           
            cmd.Parameters.AddWithValue("@service", service);

            cmd.Parameters.AddWithValue("@comp_id", HttpContext.Current.Session["CompanyId"].ToString());

            cmd.Parameters.Add("@mobile", mobile);
            return GetData(cmd,false);
        }
       else
        {
            DataSet ds = new DataSet();
            return ds;
        }

    }
    public static DataSet GetCustomerscount(string service)
    {
        
        string query = "[user_countrpt]";
        SqlCommand cmd = new SqlCommand(query);
        cmd.CommandType = CommandType.StoredProcedure;
  
        cmd.Parameters.AddWithValue("@service", service);

        cmd.Parameters.AddWithValue("@comp_id", HttpContext.Current.Session["CompanyId"].ToString());

    
        return GetcntData(cmd);

    }

    private static DataSet GetData(SqlCommand cmd,bool flag)
    {
        using (SqlConnection con = new SqlConnection(SQL_DB.ConnectionString))
        {
            using (SqlDataAdapter sda = new SqlDataAdapter())
            {
                cmd.Connection = con;
                sda.SelectCommand = cmd;
                using (DataSet ds = new DataSet())
                {
                    sda.Fill(ds, "Customers");
                    if (flag)
                    {
                        DataTable dt = new DataTable("PageCount");
                        dt.Columns.Add("PageCount");
                        dt.Rows.Add();
                        dt.Rows[0][0] = cmd.Parameters["@PageCount"].Value;
                        ds.Tables.Add(dt);
                    }
                    return ds;
                }
            }
        }
    }

    private static DataSet GetcntData(SqlCommand cmd)
    {
        using (SqlConnection con = new SqlConnection(SQL_DB.ConnectionString))
        {
            using (SqlDataAdapter sda = new SqlDataAdapter())
            {
                cmd.Connection = con;
                sda.SelectCommand = cmd;
                using (DataSet ds = new DataSet())
                {
                    sda.Fill(ds, "Customers");
                   
                  
                    return ds;
                }
            }
        }
    }


}