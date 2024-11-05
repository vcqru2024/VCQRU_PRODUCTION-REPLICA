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

public partial class admin_ResetForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Id"] == null)
            Response.Redirect("~/Member/logout.aspx");
        if (!IsPostBack)
        {
            ImageButton1.Visible = false;
            imgbtnlogin.Visible = true;
            chk.Visible = false;
            lblresetmsg.Text = "";
            txt.Visible = true;
        }
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {

        string str = "";        

        if (chkMaster.Checked == true)
        {
            str = ";truncate table F_Request" +
                    ";truncate table F_Transa_Tab " +
                    ";truncate table joining_Request" +
                    ";delete  from Registration where id>1;truncate table Money_Transfer;truncate table M_Bid_Purchase;truncate table Coin_Wallet_Detail;truncate table Recharge_Detail";
        }
        else if (chkCalc.Checked == true)
        {
            str = ";truncate table F_Request" +
                    ";truncate table F_Transa_Tab " +
                    ";truncate table joining_Request" +
                    ";delete  from Registration where id>1;truncate table Money_Transfer;truncate table M_Bid_Purchase;truncate table Coin_Wallet_Detail;truncate table Recharge_Detail";
            //str = "delete from Cal_Payment_Tab where tbl_id>1 " +
            //    ";truncate table Reward_Trans" +
            //";delete from F_Transa_Tab where Tra_Name='Fund Transfer' or Tra_Name='Growth' or Tra_Name='Leg Growth'" +
            //";Update Registration set IsPayReferal=0,IsFirst=0" +
            //";Update Registration Set Tot_Pair=0" +
            //";truncate table T_Primium" +
            //    ";truncate table T_ZoneForProgram" +
            //";truncate table T_Salary" +  
            //";truncate table Rec_Trans_Tab ";          
                    
        }
        else if (chkMem.Checked == true)
        {
            str = ";truncate table F_Request" +
                    ";truncate table F_Transa_Tab " +
                    ";truncate table joining_Request" +
                    ";delete  from Registration where id>1;truncate table Money_Transfer;truncate table M_Bid_Purchase;truncate table Coin_Wallet_Detail;truncate table Recharge_Detail";
            //str = "delete from Cal_Payment_Tab where tbl_id>1 " +
            //    ";Update Registration set IsPayReferal=0" +
            //      ";delete  from Registration where id>1" +
            //      ";truncate table F_AddFundReq" +
            //      ";truncate table F_Request" +
            //      ";truncate table F_Transa_Tab" +
            //      ";truncate table F_Transfer_UToU" +
            //      ";truncate table Pin" +
            //      ";truncate table Reward_Trans" +
            //     ";truncate table Pin_Request" +
            //      ";truncate table TDS_Trans " +
            //      ";truncate table MsgTransaction " +
            //      ";truncate table Msg_Main " +
            //      ";truncate table Rch_Trans " +
            //      ";truncate table Admin_Trans " +
            //      ";update code_gen Set startwith=101 where Key_Col='reg1' " +
            //      ";update code_gen Set startwith=1 where Key_Col<>'reg1'" +
            //      ";Update Registration Set Tot_Pair=0,IsFirst=0" +
            //";truncate table Rec_Trans_Tab " +
            //";delete from Recog_Pins ";
        }
        else if (chkAll.Checked == true)
        {
            str = ";truncate table F_Request" +
          ";truncate table F_Transa_Tab " +
            ";truncate table joining_Request" +
            ";delete  from Registration where id>1;truncate table Money_Transfer;truncate table M_Bid_Purchase;truncate table Coin_Wallet_Detail;truncate table Recharge_Detail";
            //str = "delete from Cal_Payment_Tab where tbl_id>1 " +
            //        ";delete  from Registration where id>1" +
            //        ";truncate table F_AddFundReq" +
            //         ";truncate table joining_Request" +
            //        ";truncate table F_Request" +
            //        ";truncate table F_Transa_Tab" +
            //        ";truncate table F_Transfer_UToU" +
            //        ";truncate table Pin" +                   
            //        ";truncate table Reward_Trans" +                   
            //        ";truncate table TDS_Trans " +
            //        ";truncate table MsgTransaction " +
            //        ";truncate table Msg_Main " +
            //        ";truncate table Rch_Trans " +                   
            //        ";truncate table Admin_Trans " +
            //        ";truncate table Product_master" +
            //        ";update code_gen Set startwith=101 where Key_Col='reg1' " +
            //        ";update code_gen Set startwith=1 where Key_Col<>'reg1'" +
            //        ";truncate table Release_Growth" +
            //        ";truncate table Bonanza_Master" +
            //        ";truncate table M_SmsTemplate " +
            //        ";truncate table rewards_tab" +
            //          ";truncate table Pin_Request" +
            //        ";truncate table Pair_income " +
            //        ";truncate table T_Primium" +                                                      
            //            ";truncate table T_ZoneForProgram" +
            //        ";delete from  Recog_Pins" +
            //        ";Update Registration set IsPayReferal=0" +
            //          ";truncate table Product_master" +
            //           ";truncate table T_Salary" +
            //        ";Update Registration Set Tot_Pair=0"; 
        }
        if (str != "")
        {
            SQL_DB.ExecuteNonQuery(str);
            lblcaldate.Text = "All Data Deleted Successfully ";
        }
        else
            lblcaldate.Text = "Select Option First ";

        ImageButton1.Visible = false;
        imgbtnlogin.Visible = true;
        chk.Visible = false;
        lblresetmsg.Text = "";
        txt.Visible = true;
    }
    protected void imgbtnlogin_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToString(SQL_DB.ExecuteScalar("select Cal_pass from Admin_login where User_Id='" + Convert.ToString(Session["User_Id"]) + "'")) == txtPass.Text)
        {
            chk.Visible = true;
            imgbtnlogin.Visible = false;
            ImageButton1.Visible = true;
            lblresetmsg.Text = "";
            txt.Visible = false;
        }
        else
        {
            lblresetmsg.Text = "Invalid Password";
            return;
        }
    }
}
