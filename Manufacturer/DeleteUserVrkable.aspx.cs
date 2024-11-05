using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using ClosedXML.Excel;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
public partial class Manufacturer_DeleteUserVrkable : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           

            SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
            con.Open();
             string qrystr = "select ConsumerName AS name,REPLACE(REPLACE(MobileNo,'VR',''),'K','') AS MobileNo,Email,REPLACE(REPLACE(MobileNo,'VR',''),'K','') AS mobile_number,remark AS Mode, case  when Vrkabel_User_Type='1' then 'Dealer' when Vrkabel_User_Type='2' then 'Retailer' when Vrkabel_User_Type='3' then 'Counter Boy' when Vrkabel_User_Type='4' then 'Electrician'  end 'Usertype',cin_number from M_Consumer where [IsDelete]=1 and Comp_id='Comp-1400' order by M_Consumerid desc";

           

            SqlCommand cmd = new SqlCommand(qrystr, con);
            System.Data.DataSet ds = new System.Data.DataSet();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(ds);
            grd1.DataSource = ds;
            grd1.DataBind();
            con.Close();


        }
    }


  

}