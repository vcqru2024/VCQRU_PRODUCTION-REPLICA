using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_Coppervrkable : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            NewMsgpop.Visible = false;


                //string mid = Convert.ToString(Request.QueryString["mid"]);
                DataTable dt = new DataTable();
                string ss = "select title,price,CONCAT(sortDesc,validTillDate) as sortDesc, detail,imagePath,created_at,status from vr_copper_detail";
                
                dt = SQL_DB.ExecuteDataTable("select title,price,CONCAT(sortDesc,validTillDate) as sortDesc, detail,imagePath,created_at,status from vr_copper_detail");

                if (dt.Rows.Count > 0)
                {
                txtNpriceame.Text = dt.Rows[0]["price"].ToString();
              //  sortDesc.Text = dt.Rows[0]["sortDesc"].ToString();
               // validTillDate.Text = dt.Rows[0]["validTillDate"].ToString();

                // imgAadhar.Visible = true;
                string kycsstt = dt.Rows[0]["status"].ToString();
                 
                }
                else
                {

                }
            

        }


    }
  
    protected void ImgSearch_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
        con.Open();


        if (txtNpriceame.Text != "" )
        {

            string result = string.Empty;
            DataTable dt = new DataTable();
            string qrystr = "select title,price,CONCAT(sortDesc,updated_at) as sortDesc, detail,imagePath,created_at,status from vr_copper_detail";

            dt = SQL_DB.ExecuteDataTable("select title,price,CONCAT(sortDesc,updated_at) as sortDesc, detail,imagePath,created_at,status from vr_copper_detail");
            if (dt.Rows.Count > 0)
            {
                SQL_DB.ExecuteNonQuery("update vr_copper_detail set  price='" + txtNpriceame.Text + "', updated_at='"+ System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "' ");
               


                NewMsgpop.Visible = true;
                LblMsgUpdate.Text = "updated Successfully!";


            }
        }
        else
        {
            NewMsgpop.Visible = true;
            LblMsgUpdate.Text = "Please select enter fields!";
            //ClientScript.RegisterClientScriptBlock(GetType(), "Javascript",
            //      "<script>alert('Please select KYC Status!')</script>");
        }

    }
}