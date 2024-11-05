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
using System.IO;

public partial class FrmResetData : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Type"] == null)
            Response.Redirect("Login.aspx?Page=FrmResetData.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Company")
                Response.Redirect("Index.aspx");
        }
        if (!Page.IsPostBack)
        {
            FillCompany();
            newMsg.Visible = false;
        }
    }

    private void FillCompany()
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Comp_ID],[Comp_Name] FROM [Comp_Reg] order by [Comp_Name]");
        if (ds.Tables[0].Rows.Count > 0)
        {
            DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Comp_ID", "Comp_Name", ddlComp_Id, "--Select--");
            ddlComp_Id.SelectedIndex = 0;
        }
        else
        {
            ddlComp_Id.Items.Clear();
            ddlComp_Id.Items.Insert(0, "--Select--");
        }
    }

    private void ChkCheckBoxAll()
    {
        if (chk1.Checked == true)
        {
            chk2.Checked = true; chk3.Checked = true; chk4.Checked = true; chk5.Checked = true; chk6.Checked = true; chk7.Checked = true; chk8.Checked = true; chk9.Checked = true;
            ddlComp_Id.SelectedIndex = 0;
            ddlComp_Id.Enabled = false;
            return;
        }
        else if (chk1.Checked == false)
        {
            chk2.Checked = false; chk3.Checked = false; chk4.Checked = false; chk5.Checked = false; chk6.Checked = false; chk7.Checked = false; chk8.Checked = false; chk9.Checked = false;
            ddlComp_Id.SelectedIndex = 0;
            ddlComp_Id.Enabled = true;
            return;
        }
    }
    private void ChkCheckBox()
    {
        if (chk2.Checked == true && chk3.Checked == true && chk4.Checked == true && chk5.Checked == true && chk6.Checked == true && chk7.Checked == true && chk8.Checked == true && chk9.Checked == true)
        {
            chk1.Checked = true; ddlComp_Id.Enabled = false;
            return;
        }
        else if (chk2.Checked == true || chk3.Checked == true || chk4.Checked == true || chk5.Checked == true || chk6.Checked == true || chk7.Checked == true || chk8.Checked == true || chk9.Checked == true)
        {
            chk1.Checked = false; ddlComp_Id.Enabled = true;
            return;
        }
    }
    private void DeleteDirectory(string path)
    {
        System.IO.DirectoryInfo dir = new System.IO.DirectoryInfo(path);
        if (dir.Exists)
            System.IO.Directory.Delete(path, true);

    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        int keyval = 0; 
        Object9420 Reg = new Object9420();
        DataSet dsS = new DataSet();
        DataSet dc = new DataSet();
        DataSet dsc = new DataSet();
        if (ddlComp_Id.SelectedValue.ToString() == "--Select--")
            Reg.Comp_ID = "''";
        else
            Reg.Comp_ID = "'" + ddlComp_Id.SelectedValue.ToString() + "'";
        string path = "";


        if (chk1.Checked == true) // All Reset
        {
            #region
            //===sound folder==================
            dc = SQL_DB.ExecuteDataSet("SELECT [Comp_ID] FROM [Comp_Reg]");
            for (int p = 0; p < dc.Tables[0].Rows.Count; p++)
            {
                Reg.Comp_ID = dc.Tables[0].Rows[p]["Comp_ID"].ToString();
                dsS = SQL_DB.ExecuteDataSet("SELECT [Row_ID],[Pro_ID] FROM  T_Pro WHERE  [Pro_ID] IN (SELECT [Pro_ID] FROM [Pro_Reg] where [Comp_ID] = '" + Reg.Comp_ID + "' ) ");
                for (int i = 0; i < dsS.Tables[0].Rows.Count; i++)
                {
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + dsS.Tables[0].Rows[i]["Pro_ID"].ToString() + "\\" + dsS.Tables[0].Rows[i]["Row_ID"].ToString();
                    DeleteDirectory(path);
                }
                for (int i = 0; i < dsS.Tables[0].Rows.Count; i++)
                {
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + dsS.Tables[0].Rows[i]["Pro_ID"].ToString();
                    DeleteDirectory(path);
                }
                path = Server.MapPath("../Data/Sound");
                path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4);
                DeleteDirectory(path);
                dsS.Reset();
            }
            //=================================================
            dc.Reset();
            keyval = 1;
            function9420.ResetDataAll(keyval);
            showmsg(1);
            return;
            #endregion
        }
        else if (chk2.Checked == true) // Reset News Details 
        {
            #region
            keyval = 2;
            function9420.ResetDataAll(keyval);
            showmsg(2);
            #endregion
        }
        else if (chk3.Checked == true)// Remove Products 
        {
            #region
            dc = SQL_DB.ExecuteDataSet("SELECT [Comp_ID] FROM [Comp_Reg] where ('' = " + Reg.Comp_ID + " or Comp_ID = " + Reg.Comp_ID + ") ");
            for (int p = 0; p < dc.Tables[0].Rows.Count; p++)
            {
                Reg.Comp_ID = dc.Tables[0].Rows[p]["Comp_ID"].ToString();
                dsS = SQL_DB.ExecuteDataSet("SELECT [Row_ID],[Pro_ID] FROM  T_Pro WHERE  [Pro_ID] IN (SELECT [Pro_ID] FROM [Pro_Reg] where [Comp_ID] = '" + Reg.Comp_ID + "' ) ");
                for (int i = 0; i < dsS.Tables[0].Rows.Count; i++)
                {
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + dsS.Tables[0].Rows[i]["Pro_ID"].ToString() + "\\" + dsS.Tables[0].Rows[i]["Row_ID"].ToString();
                    DeleteDirectory(path);
                }
                for (int i = 0; i < dsS.Tables[0].Rows.Count; i++)
                {
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + dsS.Tables[0].Rows[i]["Pro_ID"].ToString();
                    DeleteDirectory(path);
                }
                dsc = SQL_DB.ExecuteDataSet("SELECT [Pro_ID] FROM [Pro_Reg] where [Comp_ID] = '" + Reg.Comp_ID + "' AND [Pro_ID] NOT IN (SELECT [Pro_ID] FROM  T_Pro WHERE  [Pro_ID] IN (SELECT [Pro_ID] FROM [Pro_Reg] where [Comp_ID] = '" + Reg.Comp_ID + "' ) ) ");
                for (int i = 0; i < dsc.Tables[0].Rows.Count; i++)
                {
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + dsc.Tables[0].Rows[i]["Pro_ID"].ToString();
                    DeleteDirectory(path);
                }
                Business9420.function9420.ResetProducts(Reg);
                dsS.Reset(); dsc.Reset();
            }
            dc.Reset();
            showmsg(3);
            #endregion
        }
        else if (chk4.Checked == true) // Reset Print Code Details
        {
            #region
            dc = SQL_DB.ExecuteDataSet("SELECT [Comp_ID] FROM [Comp_Reg] where ('' = " + Reg.Comp_ID + " or Comp_ID = " + Reg.Comp_ID + ") ");
            for (int p = 0; p < dc.Tables[0].Rows.Count; p++)
            {
                Reg.Comp_ID = dc.Tables[0].Rows[p]["Comp_ID"].ToString();
                dsS = SQL_DB.ExecuteDataSet("SELECT [Row_ID],[Pro_ID] FROM  T_Pro WHERE  [Pro_ID] IN (SELECT [Pro_ID] FROM [Pro_Reg] where [Comp_ID] = '" + Reg.Comp_ID + "') ");
                for (int i = 0; i < dsS.Tables[0].Rows.Count; i++)
                {
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + dsS.Tables[0].Rows[i]["Pro_ID"].ToString() + "\\" + dsS.Tables[0].Rows[i]["Row_ID"].ToString();
                    DeleteDirectory(path);
                }
                dsS.Reset();
                function9420.ResetPrintAll(Reg);
            }
            dc.Reset();
            showmsg(4);
            #endregion
        }
        else if (chk5.Checked == true)  // Reset Code Allocatation
        {
            #region
            dc = SQL_DB.ExecuteDataSet("SELECT [Comp_ID] FROM [Comp_Reg] where ('' = " + Reg.Comp_ID + " or Comp_ID = " + Reg.Comp_ID + ") ");
            for (int p = 0; p < dc.Tables[0].Rows.Count; p++)
            {
                Reg.Comp_ID = dc.Tables[0].Rows[p]["Comp_ID"].ToString();
                dsS = SQL_DB.ExecuteDataSet("SELECT [Row_ID],[Pro_ID] FROM  T_Pro WHERE  [Pro_ID] IN (SELECT [Pro_ID] FROM [Pro_Reg] where [Comp_ID] = '" + Reg.Comp_ID + "' ) ");
                for (int i = 0; i < dsS.Tables[0].Rows.Count; i++)
                {
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + dsS.Tables[0].Rows[i]["Pro_ID"].ToString() + "\\" + dsS.Tables[0].Rows[i]["Row_ID"].ToString();
                    DeleteDirectory(path);
                }
                Business9420.function9420.ResetCodeBank(Reg);
                dsS.Reset();
            }
            dc.Reset();
            showmsg(5);
            #endregion
        }
        else if (chk6.Checked == true)  // Reset Remove Company 
        {
            #region
            dc = SQL_DB.ExecuteDataSet("SELECT [Comp_ID],[Comp_Email] FROM [Comp_Reg] where ('' = " + Reg.Comp_ID + " or Comp_ID = " + Reg.Comp_ID + ") ");
            for (int p = 0; p < dc.Tables[0].Rows.Count; p++)
            {
                Reg.Comp_ID = dc.Tables[0].Rows[p]["Comp_ID"].ToString();
                dsS = SQL_DB.ExecuteDataSet("SELECT [Row_ID],[Pro_ID] FROM  T_Pro WHERE  [Pro_ID] IN (SELECT [Pro_ID] FROM [Pro_Reg] where [Comp_ID] = '" + Reg.Comp_ID + "') ");

                for (int i = 0; i < dsS.Tables[0].Rows.Count; i++)
                {
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + dsS.Tables[0].Rows[i]["Pro_ID"].ToString() + "\\" + dsS.Tables[0].Rows[i]["Row_ID"].ToString();
                    DeleteDirectory(path);
                }
                for (int i = 0; i < dsS.Tables[0].Rows.Count; i++)
                {
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + dsS.Tables[0].Rows[i]["Pro_ID"].ToString();
                    DeleteDirectory(path);
                }
                dsc = SQL_DB.ExecuteDataSet("SELECT [Pro_ID] FROM [Pro_Reg] where [Comp_ID] = '" + Reg.Comp_ID + "' AND [Pro_ID] NOT IN (SELECT [Pro_ID] FROM  T_Pro WHERE  [Pro_ID] IN (SELECT [Pro_ID] FROM [Pro_Reg] where [Comp_ID] = '" + Reg.Comp_ID + "' ) ) ");
                for (int i = 0; i < dsc.Tables[0].Rows.Count; i++)
                {
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + dsc.Tables[0].Rows[i]["Pro_ID"].ToString();
                    DeleteDirectory(path);
                }
                // delete this company
                path = Server.MapPath("../Data/Sound");
                path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4);
                DeleteDirectory(path);
                SQL_DB.ExecuteNonQuery("DELETE FROM [Allcation_Demo] WHERE Email_ID = '" + dc.Tables[0].Rows[p]["Comp_Email"].ToString() + "'");
                function9420.SetPrefixAndStart();                
                Business9420.function9420.RemoveCompany(Reg);
                dsS.Reset(); dsc.Reset();
            }
            dc.Reset();
            showmsg(6);
            #endregion
        }
        else if (chk7.Checked == true) // Reset CodeBank 
        {
            #region
            dc = SQL_DB.ExecuteDataSet("SELECT [Comp_ID] FROM [Comp_Reg] where ('' = " + Reg.Comp_ID + " or Comp_ID = " + Reg.Comp_ID + ") ");
            for (int p = 0; p < dc.Tables[0].Rows.Count; p++)
            {
                Reg.Comp_ID = dc.Tables[0].Rows[p]["Comp_ID"].ToString();
                dsS = SQL_DB.ExecuteDataSet("SELECT [Row_ID],[Pro_ID] FROM  T_Pro WHERE  [Pro_ID] IN (SELECT [Pro_ID] FROM [Pro_Reg] where [Comp_ID] = '" + Reg.Comp_ID + "' ) ");
                for (int i = 0; i < dsS.Tables[0].Rows.Count; i++)
                {
                    path = Server.MapPath("../Data/Sound");
                    path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4) + "\\" + dsS.Tables[0].Rows[i]["Pro_ID"].ToString() + "\\" + dsS.Tables[0].Rows[i]["Row_ID"].ToString();
                    DeleteDirectory(path);
                }
                Business9420.function9420.ResetCodeBank(Reg);
                dsS.Reset();
            }
            DataSet dds = new DataSet();
            dds = SQL_DB.ExecuteDataSet("SELECT Comp_ID FROM Payment_Received");
            if (dds.Tables[0].Rows.Count == 0)
            {
                dds.Reset();
                dds = SQL_DB.ExecuteDataSet("SELECT Comp_ID FROM T_Generate_Bill WHERE [Invoice_No] in (SELECT Invoice_No FROM M_Generate_Bill WHERE  Trans_Type='Label')");
                if (dds.Tables[0].Rows.Count == 0)
                {
                    dds.Reset();
                    dds = SQL_DB.ExecuteDataSet("SELECT Comp_ID FROM M_Generate_Bill");
                    if (dds.Tables[0].Rows.Count == 0)
                        SQL_DB.ExecuteNonQuery("UPDATE [Code_Gen] SET [PrStart] = 1001 WHERE [Prfor]= 'Invoice' ;");              
                }
            }                        
            dc.Reset();
            showmsg(7);                                   
            #endregion
        }
        else if (chk8.Checked == true)  // Reset Enquiry
        {
            #region
            keyval = 8;
            function9420.ResetDataAll(keyval);
            dc = SQL_DB.ExecuteDataSet("SELECT [Comp_ID] FROM [Comp_Reg]  where ('' = " + Reg.Comp_ID + " or Comp_ID = " + Reg.Comp_ID + ") ");
            for (int p = 0; p < dc.Tables[0].Rows.Count; p++)
            {
                Reg.Comp_ID = dc.Tables[0].Rows[p]["Comp_ID"].ToString();
                SQL_DB.ExecuteNonQuery("UPDATE [M_Code] SET [Use_Count] = 0 WHERE [Pro_ID] in (SELECT  Pro_ID FROM Pro_Reg WHERE ('' = '" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))");
            }
            showmsg(8);
            #endregion
        }
        else if (chk9.Checked == true)  // Reset All Invoice
        {
            #region
            dc = SQL_DB.ExecuteDataSet("SELECT [Comp_ID] FROM [Comp_Reg] where ('' = " + Reg.Comp_ID + " or Comp_ID = " + Reg.Comp_ID + ") ");
            for (int p = 0; p < dc.Tables[0].Rows.Count; p++)
            {
                Reg.Comp_ID = dc.Tables[0].Rows[p]["Comp_ID"].ToString();
                DataSet dst = SQL_DB.ExecuteDataSet("SELECT [Request_No],[Rec_Amount],[Payment_By] FROM [Payment_Received] WHERE [Comp_ID] = '" + Reg.Comp_ID + "' AND [Flag] = 1 ");
                for (int l = 0; l < dst.Tables[0].Rows.Count; l++)
                {
                    Reg.Request_No = dst.Tables[0].Rows[l]["Request_No"].ToString();
                    DataSet dsrec = SQL_DB.ExecuteDataSet("SELECT  Req_Amount,Rec_Amount,Amc_Offer_ID FROM Payment_Trans WHERE [Request_No] = '" + Reg.Request_No + "'");
                    if (dsrec.Tables[0].Rows.Count > 0)
                    {
                        for (int t = 0; t < dsrec.Tables[0].Rows.Count; t++)
			            {
                            Reg.TRec_Payment = Convert.ToDouble(dsrec.Tables[0].Rows[t]["Rec_Amount"].ToString());
                            Reg.TReq_Payment = Convert.ToDouble(dsrec.Tables[0].Rows[t]["Req_Amount"].ToString());
                            Reg.Credit_Payment = Reg.TReq_Payment - Reg.TRec_Payment;
                            if (dst.Tables[0].Rows[l]["Payment_By"].ToString() == "Admin")
                                SQL_DB.ExecuteDataSet("UPDATE [M_Amc_Offer] SET [Admin_Balance] = [Admin_Balance] + " + Reg.TRec_Payment + "   ,[Manu_Balance] = [Manu_Balance] + " + Reg.TRec_Payment + "  WHERE  Row_ID = '" + dsrec.Tables[0].Rows[t]["Amc_Offer_ID"].ToString() + "' ");
                            else
                                SQL_DB.ExecuteDataSet("UPDATE [M_Amc_Offer] SET [Admin_Balance] = [Admin_Balance] + " + Reg.TRec_Payment + " ,[Manu_Balance] = [Manu_Balance] - " + Reg.Credit_Payment + "  WHERE  Row_ID = '" + dsrec.Tables[0].Rows[t]["Amc_Offer_ID"].ToString() + "' ");
                            SQL_DB.ExecuteDataSet("UPDATE [Payment_Trans] SET [Rec_Amount] = 0.00   ,[Admin_Remark] = null  WHERE  Amc_Offer_ID = '" + dsrec.Tables[0].Rows[t]["Amc_Offer_ID"].ToString() + "' AND [Request_No] = '" + Reg.Request_No + "' ");
			            }                        
                    }
                    SQL_DB.ExecuteDataSet("UPDATE [Payment_Received] SET [Rec_Date] = null ,[Rec_Amount] = null,[Admin_Remark] = null,[Flag] = 0 WHERE [Request_No] = '" + Reg.Request_No + "' AND [Flag] = 1 ");
                }
                function9420.ResetAllInvoice(Reg);
            }
            dc.Reset();
            showmsg(9);
            #endregion
        }
        else
        {
            newMsg.Visible = true;
            newMsg.Attributes.Add("class", "alert_boxes_pink big_msg");
            lblmsg.Text = "Please select atleast one checkbox !";
        }
        FillCompany();
    }
    private void showmsg(int i)
    {
        newMsg.Visible = true;
        newMsg.Attributes.Add("class", "alert_boxes_green big_msg");
        string Msgtype = ""; string Msghead = "Reset";
        if (i == 1)
            Msgtype = "Database";
        if (i == 2)
            Msgtype = "News";
        if (i == 3)
        {
            Msghead = "Remove";
            Msgtype = "Products";
        }
        if (i == 4)
            Msgtype = "Printed Code";
        if (i == 5)
            Msgtype = "Code Allocatation";
        if (i == 6)
        {
            Msghead = "Remove";
            Msgtype = "Company";
        }
        if (i == 7)
            Msgtype = "CodeBank";
        if (i == 8)
            Msgtype = "Enquiry";
        if (i == 9)
            Msgtype = "Invoice";
        
        if (ddlComp_Id.SelectedValue.ToString() == "--Select--")
            lblmsg.Text = Msghead+ " All " + Msgtype + " successfully !";
        else
            lblmsg.Text = Msghead+ "  " +Msgtype + " successfully for <span style='color:blue;' >" + ddlComp_Id.SelectedItem.Text.Trim() + "</span> Company!";        
    }
    protected void chkall_CheckedChanged(object sender, EventArgs e)
    {
        newMsg.Visible = false;
        ChkCheckBoxAll();
    }
    protected void chk1_CheckedChanged(object sender, EventArgs e)
    {
        newMsg.Visible = false;
        ChkCheckBox();
        if (chk2.Checked)
        {
            ddlComp_Id.SelectedIndex = 0;
            ddlComp_Id.Enabled = false;
        }
        else
        {
            ddlComp_Id.SelectedIndex = 0;
            ddlComp_Id.Enabled = true;
        }

    }
}
