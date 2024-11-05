using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Business9420;

public partial class Patanjali_SearchCodeDetails : System.Web.UI.Page
{
    public int ScrapeFlag = 0;
    public int index = 0;
    public Int32 sr = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("../Patanjali/Loginpfl.aspx?Page=SearchCodeDetails.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            Clear();
            if (Request.QueryString["P"] != null)
            {
                txtcode.Text = Request.QueryString["P"].ToString();
                txtscrapfrom.Text = Request.QueryString["S1"].ToString();
                txtscrapto.Text = Request.QueryString["S2"].ToString();
            }

        }
    }

   

    


    private void ScrapEntry(string Pro_Id,string BatchNo)
    {
        try
        {

            string Comp_ID = Session["CompanyId"].ToString();

            if (txtcode.Text !="")
            {
                string NewSelectedBatch = lblseriesdetails.Text;
                NewSelectedBatch = NewSelectedBatch.Replace("From  ", "").Replace("   To  ", "|");

                string[] SelectedBatch = NewSelectedBatch.Split('|');
                string[] Cstr = SelectedBatch[1].Split('-');
                string pro = Cstr[0].ToString();
                Int32 series_order = Convert.ToInt32(Cstr[1]);
                Int32 series_serial = Convert.ToInt32(Cstr[2]);
                if (series_serial > 9999)
                {
                    series_order = series_order + 1;
                    series_serial = 0;
                }
                else
                {
                    series_serial = series_serial + 1;
                }

                string Biuldseries_order = series_order.ToString();
                if (Biuldseries_order.Length == 1)
                    Biuldseries_order = "0" + Biuldseries_order;
                string BuildNewseries_serial = series_serial.ToString();
                if (BuildNewseries_serial.Length == 1)
                    BuildNewseries_serial = "000" + BuildNewseries_serial;
                else if (BuildNewseries_serial.Length == 2)
                    BuildNewseries_serial = "00" + BuildNewseries_serial;
                else if (BuildNewseries_serial.Length == 3)
                    BuildNewseries_serial = "0" + BuildNewseries_serial;
                else
                    BuildNewseries_serial = BuildNewseries_serial;

                string NewSerialCode = pro + "-" + Biuldseries_order + "-" + BuildNewseries_serial;


                string CompleteCode = txtcode.Text.Trim();
                string Code1 = CompleteCode.Substring(0, 5);
                string Code2 = CompleteCode.Substring(5, 8);


                DataTable Codedt = new DataTable();
                string SelQury = "select p.Pro_ID,m.Row_ID,m.Pro_ID +'-'+convert(varchar,(case when len(convert(nvarchar,m.Series_Order)) = 1 then" +
                    " '0'+ convert(nvarchar,m.Series_Order) else convert(nvarchar,m.Series_Order) end)) +'-'+ convert(varchar,(case when len(convert(nvarchar,m.Series_Serial)) = 1 " +
                    "then '000'+ convert(nvarchar,m.Series_Serial) when len(convert(nvarchar,m.Series_Serial)) = 2 " +
                    "then '00'+ convert(nvarchar,m.Series_Serial) when len(convert(nvarchar,m.Series_Serial)) = 3 then '0'+ convert(nvarchar,m.Series_Serial) " +
                    "else convert(nvarchar,m.Series_Serial) end)) as SerialCode,m.Batch_No " +
                    "from M_Code_PFL m inner join Pro_Reg p on p.Pro_ID = m.Pro_ID " +
                    "inner join M_ServiceSubscription s on s.Comp_ID = p.Comp_ID and s.Pro_ID = m.Pro_ID " +
                    "inner join M_ServiceSubscriptionTrans st on st.Subscribe_Id = s.Subscribe_Id and st.IsActive=1 " +
                    "where m.Batch_No is not null and p.Comp_ID = '"+ Comp_ID + "' AND  m.Code1='" + Code1 + "' and m.Code2='" + Code2 + "'";
                SQL_DB.GetDA(SelQury).Fill(Codedt);
                if(Codedt.Rows.Count>0)
                {
                   
                    string Old_Pro_ID = Codedt.Rows[0]["Pro_ID"].ToString();
                    string M_CodeId = Codedt.Rows[0]["Row_ID"].ToString();
                    string Old_SerialCode = Codedt.Rows[0]["SerialCode"].ToString();
                    string Old_Batch_No = Codedt.Rows[0]["Batch_No"].ToString();

                    string InsQury = "insert into tblNewBatchAssingedDetails" +
                   "(M_CodeId,Old_Pro_ID,Old_SerialCode,Old_Batch_No,New_Pro_ID,New_SerialCode,New_Batch_No)" +
                   "values('" + M_CodeId + "','" + Old_Pro_ID + "','" + Old_SerialCode + "','" + Old_Batch_No + "','"+ Pro_Id + "','"+ NewSerialCode + "','"+ BatchNo + "')";

                    int Count = SQL_DB.ExecuteNonQuery1(InsQury);

                    if (Count > 0)
                    {
                        //string updateqry = "UPDATE [M_Code_PFL] SET Pro_ID='" + Pro_Id + "',Batch_No='" + BatchNo + "',[Series_Order]=" + series_order + ", [Series_Serial]=" + series_serial+ " WHERE  Row_ID='"+ M_CodeId + "' ";
                        //SQL_DB.ExecuteNonQuery(updateqry);
                    }

                    ScriptManager.RegisterStartupScript(this, GetType(), "Updated", "showAlert('Success', 'Updated Successfully!', 'success');", true);
                }
                else
                    ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Something Went Wrong Please try After', 'error');", true);







            }
            if (hidden1.Value != null)//(Request.Form["chkselect"] != null)
            {
                string NewSelectedBatch = lblseriesdetails.Text;
                NewSelectedBatch = NewSelectedBatch.Replace("From  ", "").Replace("   To  ", "|");

                string[] SelectedBatch = NewSelectedBatch.Split('|');
                string[] Newstr = SelectedBatch[1].Split('-');
                string Newpro = Newstr[0].ToString();
                Int32 Newseries_order = Convert.ToInt32(Newstr[1]);
                Int32 Newseries_serial = Convert.ToInt32(Newstr[2]);
                
                string[] Arr = hidden1.Value.ToString().Split(',');
                for (int i = 0; i < Arr.Length; i++)
                {
                    if (Newseries_serial > 9999)
                    {
                        Newseries_order = Newseries_order + 1;
                        Newseries_serial = 0;
                    }
                    else
                    {
                        Newseries_serial = Newseries_serial + 1;
                    }
                    string Biuldseries_order = Newseries_order.ToString();
                    if (Biuldseries_order.Length == 1)
                        Biuldseries_order = "0" + Biuldseries_order;
                    string BuildNewseries_serial = Newseries_serial.ToString();
                    if (BuildNewseries_serial.Length == 1)
                        BuildNewseries_serial = "000" + BuildNewseries_serial;
                    else if (BuildNewseries_serial.Length == 2)
                        BuildNewseries_serial = "00" + BuildNewseries_serial;
                    else if (BuildNewseries_serial.Length == 3)
                        BuildNewseries_serial = "0" + BuildNewseries_serial;
                    else
                        BuildNewseries_serial = BuildNewseries_serial;

                    string NewSerialCode= Newpro+"-"+ Biuldseries_order+"-"+BuildNewseries_serial;
                    DataSet ds = new DataSet();
                    string updateqry = null;
                    string[] Oldstr = Arr[i].Split('-');
                    string Oldpro = Oldstr[0].ToString();
                    Int32 Oldseries_order = Convert.ToInt32(Oldstr[1]);
                    Int32 Oldseries_serial = Convert.ToInt32(Oldstr[2]);

                    DataTable Codedt = new DataTable();
                    string SelQury = "select p.Pro_ID,m.Row_ID,m.Pro_ID +'-'+convert(varchar,(case when len(convert(nvarchar,m.Series_Order)) = 1 then" +
                        " '0'+ convert(nvarchar,m.Series_Order) else convert(nvarchar,m.Series_Order) end)) +'-'+ convert(varchar,(case when len(convert(nvarchar,m.Series_Serial)) = 1 " +
                        "then '000'+ convert(nvarchar,m.Series_Serial) when len(convert(nvarchar,m.Series_Serial)) = 2 " +
                        "then '00'+ convert(nvarchar,m.Series_Serial) when len(convert(nvarchar,m.Series_Serial)) = 3 then '0'+ convert(nvarchar,m.Series_Serial) " +
                        "else convert(nvarchar,m.Series_Serial) end)) as SerialCode,m.Batch_No " +
                        "from M_Code_PFL m inner join Pro_Reg p on p.Pro_ID = m.Pro_ID " +
                        "inner join M_ServiceSubscription s on s.Comp_ID = p.Comp_ID and s.Pro_ID = m.Pro_ID " +
                        "inner join M_ServiceSubscriptionTrans st on st.Subscribe_Id = s.Subscribe_Id and st.IsActive=1 " +
                        "where m.Batch_No is not null and p.Comp_ID = '"+ Comp_ID + "' AND m.Series_Order ="+ Oldseries_order + " AND m.Series_Serial = "+ Oldseries_serial + " AND m.Pro_ID='"+ Oldpro + "'";
                    SQL_DB.GetDA(SelQury).Fill(Codedt);
                    if (Codedt.Rows.Count > 0)
                    {

                        string Old_Pro_ID = Codedt.Rows[0]["Pro_ID"].ToString();
                        string M_CodeId = Codedt.Rows[0]["Row_ID"].ToString();
                        string Old_SerialCode = Codedt.Rows[0]["SerialCode"].ToString();
                        string Old_Batch_No = Codedt.Rows[0]["Batch_No"].ToString();

                        string InsQury = "insert into tblNewBatchAssingedDetails" +
                       "(M_CodeId,Old_Pro_ID,Old_SerialCode,Old_Batch_No,New_Pro_ID,New_SerialCode,New_Batch_No)" +
                       "values('" + M_CodeId + "','" + Old_Pro_ID + "','" + Old_SerialCode + "','" + Old_Batch_No + "','" + Newpro + "','" + NewSerialCode + "','" + BatchNo + "')";

                        int Count = SQL_DB.ExecuteNonQuery1(InsQury);

                        if (Count > 0)
                        {
                            string grpupdateqry = "UPDATE [M_Code_PFL] SET Pro_ID='" + Newpro + "',Batch_No='" + BatchNo + "',[Series_Order]=" + Newseries_order + ", [Series_Serial]=" + Newseries_serial + " WHERE  Row_ID='" + M_CodeId + "' ";
                            SQL_DB.ExecuteNonQuery(grpupdateqry);

                            string Series_Limit = "From  " + SelectedBatch[0] + "   To  " + NewSerialCode;
                            string Tproupdateqry = "UPDATE [T_Pro] SET Series_Limit='" + Series_Limit + "' WHERE  Row_ID='" + BatchNo + "' ";
                            SQL_DB.ExecuteNonQuery(Tproupdateqry);


                        }

                    }


                    LblMsg.Text = Convert.ToString(Arr.Length) + " Rows Updated";
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "Updated", "showAlert('Success', '"+ LblMsg.Text + " Successfully', 'success');", true);
            }
            else
               // LblMsg.Text = "no row selected"; 
            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'no row selected', 'error');", true);
            fillgrid();
        }
        catch
        {
            LblMsg.Text = "Request aborted , Please try again later !";
            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', '"+ LblMsg.Text + "', 'error');", true);
        }

    }

    protected void btnYesScrap_Click(object sender, EventArgs e)
    {
        if (hidden1.Value != null)
        {
            string Pro_Id = ddlProduct.SelectedItem.Value;
            string BachNo = ddlbachno.SelectedItem.Value;
            ScrapEntry(Pro_Id, BachNo);
        }
           
        else
        {
            LblMsg.Text = "No row selected";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            LblMsg.Font.Bold = true;
            hidden1.Value = string.Empty;
        }
    }
    protected void btnNoScrap_Click(object sender, EventArgs e)
    {

    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {

    }


    private void fillProduct()
    {
        DataSet ds = new DataSet();
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.Status = 1;
        ds = function9420.FillProddlSearch(Reg);
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProduct, "--Select--");
        ddlProduct.SelectedIndex = 0;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Request.Form["chkselect"] != null)
        {
            hidden1.Value = Convert.ToString(Request.Form["chkselect"]);
           
            fillProduct();
            LabelAlertNewHeader.Text = "Assign to an other batch";
            ModalPopupExtenderScrap.Show();
        }
        else
        {
            hidden1.Value = string.Empty;
            LblMsg.Text = "No row selected";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            LblMsg.Font.Bold = true;
        }

    }

    private void fillgrid()
    {
       ;
        #region Query
        string s = null;
        string Comp_ID = Session["CompanyId"].ToString();
        //if (ddlProduct.SelectedIndex == 0)
        //    s = null;
        //else s = ddlProduct.SelectedValue.ToString();

        DataSet ds = new DataSet(); //TOP (" + RowsCount + ")
        string qry = "select p.Pro_Name,cast(m.Code1 as varchar(5)) + cast(m.Code2 as varchar(8)) Completedcode," +
            "m.Pro_ID +'-'+convert(varchar,(case when len(convert(nvarchar,m.Series_Order)) = 1 then '0'+ convert(nvarchar,m.Series_Order) else convert(nvarchar,m.Series_Order) end))  +'-'+ convert(varchar,(case when len(convert(nvarchar,m.Series_Serial)) = 1 then '000'+ convert(nvarchar,m.Series_Serial) when len(convert(nvarchar,m.Series_Serial)) = 2 then '00'+ convert(nvarchar,m.Series_Serial) when len(convert(nvarchar,m.Series_Serial)) = 3 then '0'+ convert(nvarchar,m.Series_Serial) else convert(nvarchar,m.Series_Serial) end)) as SerialCode," +
            "(select Batch_No from  T_Pro where Row_Id=m.Batch_No)Batch_No,s.DateFrom,s.DateTo," +
            "case when st.isactive = 0 then 'Deactived' when st.isactive = -1 then 'Expired' else 'Active' end Status " +
            "from M_Code_PFL m inner join Pro_Reg p on p.Pro_ID = m.Pro_ID inner join M_ServiceSubscription s on s.Comp_ID = p.Comp_ID " +
            "and s.Pro_ID = m.Pro_ID inner join M_ServiceSubscriptionTrans st on st.Subscribe_Id = s.Subscribe_Id and st.IsActive=1" +
            " where m.Batch_No is not null and p.Comp_ID = '"+ Comp_ID + "'";
        
        string str = null;
        if (txtcode.Text != "")
        {
            string CompleteCode = txtcode.Text.Trim();
            string Code1 = CompleteCode.Substring(0, 5);
            string Code2 = CompleteCode.Substring(5, 8);


            LblMsg.Text = "";
            str = " and m.Code1='"+Code1+"' and m.Code2='"+Code2+"'";
           


        }

        if (txtscrapfrom.Text != "" && txtscrapto.Text != "")
        {
            string[] Serialcode = txtscrapfrom.Text.Split('-');
            string pro = Serialcode[0];
            Int32 Series_Order = Convert.ToInt32(Serialcode[1]);
            Int32 Series_Serial = Convert.ToInt32(Serialcode[2]);
            string[] Serialcode1 = txtscrapto.Text.Split('-');
            string pro1 = Serialcode1[0];
            Int32 Series_Order1 = Convert.ToInt32(Serialcode1[1]);
            Int32 Series_Serial1 = Convert.ToInt32(Serialcode1[2]);
            if (Series_Order == Series_Order1 && pro == pro1)
            {
                LblMsg.Text = "";
                str = " AND m.Series_Order =" + Series_Order + " AND m.Series_Serial between " + Series_Serial+" and "+ Series_Serial1;
                str += " AND m.Pro_ID='" + pro1 + "'";
            }
            else
            {
                LblMsg.Text = "Plz select right product... ";
            }
        }
        else if (txtscrapfrom.Text != "" && txtscrapto.Text == "")
        {

            string[] Serialcode = txtscrapfrom.Text.Split('-');
            string pro = Serialcode[0];
            Int32 Series_Order = Convert.ToInt32(Serialcode[1]);
            Int32 Series_Serial = Convert.ToInt32(Serialcode[2]);
            
                LblMsg.Text = "";
            str = " AND m.Series_Order=" + Series_Order + " AND m.Series_Serial = " + Series_Serial;
            str += " AND m.Pro_ID='" + pro + "'";

        }
        else if (txtscrapfrom.Text == "" && txtscrapto.Text != "")
        {
            string[] Serialcode1 = txtscrapto.Text.Split('-');
            string pro1 = Serialcode1[0];
            Int32 Series_Order1 = Convert.ToInt32(Serialcode1[1]);
            Int32 Series_Serial1 = Convert.ToInt32(Serialcode1[2]);
            
                LblMsg.Text = "";
            str = " AND m.Series_Order=" + Series_Order1 + " AND m.Series_Serial = " + Series_Serial1;
            str += " AND m.Pro_ID='" + pro1 + "'";

        }
        else
        {
            LblMsg.Text = "";
            str += "";

            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please provide some input to search !', 'error');", true);

            return;
        }
        #endregion
        string fqry = qry + str;
        SQL_DB.GetDA(fqry).Fill(ds, "1");
        Session["GrdData"] = (DataTable)ds.Tables["1"];
        
       

        if (ds.Tables["1"].Rows.Count > 0)
        {
            Grdscrap.DataSource = ds.Tables["1"];
            Grdscrap.DataBind();
            Grdscrap.Visible = true;
            lblcount.Text = ds.Tables["1"].Rows.Count.ToString();
            lblC.Text = Grdscrap.Rows.Count.ToString();
        }
        else
        {
            Grdscrap.Visible = false;
            lblcount.Text = "0";
        }

        if (Grdscrap.Rows.Count > 0)
            Grdscrap.HeaderRow.TableSection = TableRowSection.TableHeader;


        
    }
    protected void ddlbatchno_SelectedIndexChanged(object sender, EventArgs e)
    {
        fillgrid();
    }
    private void Clear()
    {
       
    }
    protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
    {

    }
    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        LblMsg.Text = "";
        txtscrapfrom.Text = "";
        txtscrapto.Text = "";
        fillgrid();
    }
  
    protected void Grdscrap_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Grdscrap.PageIndex = e.NewPageIndex;
        fillgrid();
    }
    protected void ddlRowProductCnt_SelectedIndexChanged(object sender, EventArgs e)
    {
        Grdscrap.SelectedIndex = 0;
        fillgrid();
    }



    #region Filter According To Status
    private void RowFilterGridData(string str)
    {
        LblMsg.Text = string.Empty;
        DataTable dt = (DataTable)Session["GrdData"];
        DataView dataview = dt.DefaultView;
        dataview.RowFilter = "FF = " + str;
        DataTable dt1 = dataview.ToTable();
       
        if (dt1.Rows.Count > 0)
        {
            lblcount.Text = dt1.Rows.Count.ToString();
            lblC.Text = Grdscrap.Rows.Count.ToString();
            Grdscrap.Visible = true;
            Grdscrap.DataSource = dt1;
            Grdscrap.DataBind();
        }
        else
        {
            Grdscrap.Visible = false;
            lblcount.Text = "0";
        }


       
    }
    protected void btnScrap_Click(object sender, EventArgs e)
    {
        LblMsg.Text = string.Empty;
        DataTable dt = (DataTable)Session["GrdData"];
        DataView dataview = dt.DefaultView;
        dataview.RowFilter = "FF = -1 OR FF = 5";
        DataTable dt1 = dataview.ToTable();
       

       
    }
    #endregion

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        fillgrid();
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        txtcode.Text = ""; 
        txtscrapfrom.Text = ""; txtscrapto.Text = ""; 
        LblMsg.Text = "";
        fillgrid();
    }

    protected void ddlProduct_SelectedIndexChanged1(object sender, EventArgs e)
    {
        
            DataSet ds = new DataSet();
            Object9420 Reg = new Object9420();
            Reg.Comp_ID = Session["CompanyId"].ToString();
            Reg.Status = 1;

        string qry = "select Batch_No,Row_ID from T_Pro where Pro_ID='"+ddlProduct.SelectedItem.Value+"'";
        SQL_DB.GetDA(qry).Fill(ds);

        DataTable dt = ds.Tables[0];
        ddlbachno.DataSource = dt;
        ddlbachno.DataValueField = "Row_ID";
        ddlbachno.DataTextField = "Batch_No";
        ddlbachno.DataBind();
        ddlbachno.Items.Insert(0, new ListItem("--Select--", "--Select--"));

        ddlbachno.SelectedIndex = 0;
        lblseriesdetails.Text = "";
        ModalPopupExtenderScrap.Show();

    }

    protected void ddlbachno_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        string qry = "select Batch_No,Row_ID,Series_Limit from T_Pro where Row_ID='" + ddlbachno.SelectedItem.Value + "'";
        SQL_DB.GetDA(qry).Fill(dt);

        if (dt.Rows.Count > 0)
        {
            lblseriesdetails.Text = dt.Rows[0]["Series_Limit"].ToString();
        }
        else
            lblseriesdetails.Text = "";

         ModalPopupExtenderScrap.Show();
    }

    protected void txtscrapfrom_TextChanged(object sender, EventArgs e)
    {
        txtcode.Text = "";
    }

    protected void txtscrapto_TextChanged(object sender, EventArgs e)
    {
        txtcode.Text = "";
    }

    protected void txtcode_TextChanged(object sender, EventArgs e)
    {
        txtscrapto.Text = "";
        txtscrapfrom.Text = "";
    }
}