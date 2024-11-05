using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace vcqruUtils
{
    public partial class frmSupport : Form
    {
        public frmSupport()
        {
            InitializeComponent();
        }
        SqlConnection con = new SqlConnection("Connect Timeout=500; pooling=true; Max Pool Size=200;Data Source=162.252.86.157;Initial Catalog=Vcqru;User ID=vcqru_label;Password=vcqruadmin@123");
        private void btnSearch_Click(object sender, EventArgs e)
        {
            

            //SqlConnection con = new SqlConnection("Connect Timeout=500; pooling=true; Max Pool Size=200;Data Source=162.252.86.157;Initial Catalog=Vcqru;User ID=vcqru_label;Password=vcqruadmin@123");
            SqlCommand cmd = new SqlCommand("USP_SUPPORT", con);
            cmd.Parameters.Add(new SqlParameter("@comp_id", "Comp-1152"));
            cmd.Parameters.Add(new SqlParameter("@pro_id", "AB94"));
            cmd.Parameters.Add(new SqlParameter("@enq_date", "2019-11-19 23:59:59.097"));
            cmd.Parameters.Add(new SqlParameter("@is_success", "All"));
            cmd.Parameters.Add(new SqlParameter("@mobileno", "All"));
                        cmd.CommandType = CommandType.StoredProcedure;

            DataTable dt = new DataTable();
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            
            adp.Fill(dt);

            gvDetails.DataSource = dt;
           // gvData.DataBind();
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
          //  adp.Update() 
            SqlCommand cmd = new SqlCommand("USP_SUPPORT_INSERT", con);
            cmd.Parameters.Add(new SqlParameter("@Enquiry_Date", txtEnquiryDate.Text.Trim() ));
            cmd.Parameters.Add(new SqlParameter("@Vendor", txtVendor.Text.Trim() ));
            cmd.Parameters.Add(new SqlParameter("@Product_Name", txtProductName.Text.Trim()));
            cmd.Parameters.Add(new SqlParameter("@Location", txtLocation.Text.Trim() ));
            cmd.Parameters.Add(new SqlParameter("@Code1",txtCode.Text.Trim()));

            cmd.Parameters.Add(new SqlParameter("@Code2", "All"));
            cmd.Parameters.Add(new SqlParameter("@Status", txtStatus.Text.Trim() ));
            cmd.Parameters.Add(new SqlParameter("@email", txtMail.Text.Trim()));
            cmd.Parameters.Add(new SqlParameter("@Mobile_Number", "All"));
            cmd.Parameters.Add(new SqlParameter("@Amount_Won", "All"));
            cmd.Parameters.Add(new SqlParameter("@Mode_of_Verification", "All"));
            cmd.Parameters.Add(new SqlParameter("@TechnicianID", "All"));
            cmd.Parameters.Add(new SqlParameter("@DealerCode", "All"));
            cmd.Parameters.Add(new SqlParameter("@consumername", "All"));
            cmd.Parameters.Add(new SqlParameter("@city", "All"));
            cmd.Parameters.Add(new SqlParameter("@address", "All"));
            cmd.Parameters.Add(new SqlParameter("@pincode", "All"));
            cmd.Parameters.Add(new SqlParameter("@aadharnumber", "All"));
            cmd.Parameters.Add(new SqlParameter("@Bank_Name", "All"));
            cmd.Parameters.Add(new SqlParameter("@Account_holder_Name", "All"));
            cmd.Parameters.Add(new SqlParameter("@Account_No", "All"));
            cmd.Parameters.Add(new SqlParameter("@Branch", "All"));

            cmd.Parameters.Add(new SqlParameter("@IFSC_Code", "All"));
            cmd.Parameters.Add(new SqlParameter("@City_of_Branch", "All"));
            cmd.Parameters.Add(new SqlParameter("@Branch_Address", "All"));
            cmd.Parameters.Add(new SqlParameter("@Account_type", "All"));
            cmd.Parameters.Add(new SqlParameter("@Notes", "All"));
            cmd.Parameters.Add(new SqlParameter("@UserId", "All"));
            
            
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            int n = cmd.ExecuteNonQuery();
            con.Close(); 
            if (n > 0)
                MessageBox.Show("Record updated");

           

        }

        private void frmSupport_Load(object sender, EventArgs e)
        {
            DataTable dtState = new DataTable();
            string strSql = "select 'ALL' comp_name,'All' comp_id union all select comp_name,comp_id from comp_reg ";
            SqlDataAdapter adpState = new SqlDataAdapter(strSql, con);
            adpState.Fill(dtState);
            cmbState.DisplayMember = "comp_name";
            cmbState.ValueMember = "comp_id";
            cmbState.DataSource = dtState;
            
        }

        private void label24_Click(object sender, EventArgs e)
        {

        }

        private void gvDetails_RowHeaderMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            int i = e.RowIndex;
            txtEnquiryDate.Text = gvDetails.Rows[e.RowIndex].Cells["Enquiry_Date"].Value.ToString();
            txtVendor.Text = gvDetails.Rows[e.RowIndex].Cells["Vendor"].Value.ToString();
            txtProductName.Text = gvDetails.Rows[e.RowIndex].Cells["Product_Name"].Value.ToString();
            txtLocation.Text = gvDetails.Rows[e.RowIndex].Cells["Location"].Value.ToString();
            txtCode.Text = gvDetails.Rows[e.RowIndex].Cells["Code1"].Value.ToString() + "-"+ gvDetails.Rows[e.RowIndex].Cells["Code2"].Value.ToString();
            txtStatus.Text = gvDetails.Rows[e.RowIndex].Cells["Status"].Value.ToString();
            txtAmountWon.Text = gvDetails.Rows[e.RowIndex].Cells["Amount_Won"].Value.ToString();
            txtModeOfVerification.Text = gvDetails.Rows[e.RowIndex].Cells["Mode_of_Verification"].Value.ToString();
            txtTechnicianId.Text = gvDetails.Rows[e.RowIndex].Cells["TechnicianID"].Value.ToString();
            txtDealerCode.Text = gvDetails.Rows[e.RowIndex].Cells["DealerCode"].Value.ToString();
            txtMobile.Text = gvDetails.Rows[e.RowIndex].Cells["Mobile_Number"].Value.ToString();
            txtAadhar.Text = gvDetails.Rows[e.RowIndex].Cells["aadharnumber"].Value.ToString();
            txtName.Text = gvDetails.Rows[e.RowIndex].Cells["consumername"].Value.ToString();
            txtAddress.Text = gvDetails.Rows[e.RowIndex].Cells["Address"].Value.ToString();
            txtCity.Text = gvDetails.Rows[e.RowIndex].Cells["city"].Value.ToString();
            txtPIN.Text = gvDetails.Rows[e.RowIndex].Cells["pincode"].Value.ToString();

            txtBankName.Text = gvDetails.Rows[e.RowIndex].Cells["Bank_Name"].Value.ToString();
            txtAccHolder.Text = gvDetails.Rows[e.RowIndex].Cells["Account_holder_Name"].Value.ToString();
            txtAccNumber.Text = gvDetails.Rows[e.RowIndex].Cells["Account_No"].Value.ToString();
            txtAccType.Text = gvDetails.Rows[e.RowIndex].Cells["Account_type"].Value.ToString();
            txtIFSC.Text = gvDetails.Rows[e.RowIndex].Cells["IFSC_Code"].Value.ToString();
            txtBranch.Text = gvDetails.Rows[e.RowIndex].Cells["Branch"].Value.ToString();
            txtBranchCity.Text = gvDetails.Rows[e.RowIndex].Cells["City_of_Branch"].Value.ToString();
            txtBranchAddress.Text = gvDetails.Rows[e.RowIndex].Cells["Address"].Value.ToString();






        }
    }
}
