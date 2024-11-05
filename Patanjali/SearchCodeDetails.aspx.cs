using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Business9420;
using System.Globalization;

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


            fillProduct_From(); 

            //if (Request.QueryString["P"] != null)
            //{
            //    txtcode.Text = Request.QueryString["P"].ToString();
            //    txtscrapfrom.Text = Request.QueryString["S1"].ToString();
            //    txtscrapto.Text = Request.QueryString["S2"].ToString();
            //}

        }
    }

   

    


    private void ScrapEntry(string Pro_Id,string BatchNo,string InputBatchNumber, string manufactureddate, string expirydate)
    {
        try
        {
            string manufactureDateFormatted = string.Empty;
            string expiryDateFormatted = string.Empty;
            manufactureddate = manufactureddate.Replace("/", "-");
            expirydate = expirydate.Replace("/", "-");
            string[] formats = { "MM-dd-yyyy", "dd-MM-yyyy", "yyyy-MM-dd", "dd/MM/yyyy" };
            DateTime manufactureDate;
            DateTime expiryDate;
            if (DateTime.TryParseExact(manufactureddate, formats, CultureInfo.InvariantCulture, DateTimeStyles.None, out manufactureDate))
            {
                manufactureDateFormatted = manufactureDate.ToString("yyyy-MM-dd");
            }
            else
            {
                Console.WriteLine("Invalid manufacture date format.");
            }
            if (DateTime.TryParseExact(expirydate, formats, CultureInfo.InvariantCulture, DateTimeStyles.None, out expiryDate))
            {
                expiryDateFormatted = expiryDate.ToString("yyyy-MM-dd");
            }
            else
            {
                Console.WriteLine("Invalid expiry date format.");
            }

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
                    "inner join M_ServiceSubscriptionTrans st on st.Subscribe_Id = s.Subscribe_Id  and (st.IsActive=1 or st.IsActive=0) " +
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
                        "inner join M_ServiceSubscriptionTrans st on st.Subscribe_Id = s.Subscribe_Id  and (st.IsActive=1 or st.IsActive=0) " +
                        "where m.Batch_No is not null and p.Comp_ID = '"+ Comp_ID + "' AND m.Series_Order ="+ Oldseries_order + " AND m.Series_Serial = "+ Oldseries_serial + " AND m.Pro_ID='"+ Oldpro + "'";
                    SQL_DB.GetDA(SelQury).Fill(Codedt);
                    if (Codedt.Rows.Count > 0)
                    {

                        string Old_Pro_ID = Codedt.Rows[0]["Pro_ID"].ToString();
                        string M_CodeId = Codedt.Rows[0]["Row_ID"].ToString();
                        string Old_SerialCode = Codedt.Rows[0]["SerialCode"].ToString();
                        string Old_Batch_No = Codedt.Rows[0]["Batch_No"].ToString();

                        string InsQury = "insert into tblNewBatchAssingedDetails" +
                       "(M_CodeId,Old_Pro_ID,Old_SerialCode,Old_Batch_No,New_Pro_ID,New_SerialCode,New_Batch_No,Manufactured_date,Expiry_date)" +
                       "values('" + M_CodeId + "','" + Old_Pro_ID + "','" + Old_SerialCode + "','" + Old_Batch_No + "','" + Newpro + "','" + NewSerialCode + "','" + BatchNo + "','" + manufactureDateFormatted + "','" + expiryDateFormatted + "')";

                        int Count = SQL_DB.ExecuteNonQuery1(InsQury);

                        if (Count > 0)
                        {
                            string grpupdateqry = "UPDATE [M_Code_PFL] SET Pro_ID='" + Newpro + "',Batch_No='" + BatchNo + "',[Series_Order]=" + Newseries_order + ", [Series_Serial]=" + Newseries_serial + " WHERE  Row_ID='" + M_CodeId + "' ";
                            SQL_DB.ExecuteNonQuery(grpupdateqry);


                            string qry = "select Batch_No,Row_ID,Series_Limit from T_Pro where Pro_ID='" + ddlProduct.SelectedItem.Value + "' and Batch_No='"+ InputBatchNumber + "'";
                            SQL_DB.GetDA(qry).Fill(ds);

                            DataTable batchdt = new DataTable();
                            if (ds.Tables[0].Rows.Count == 0)
                            {
                              
                                string InitialSerieseDetails = "From  " + ddlProduct.SelectedItem.Value + "-00-0000   To  " + ddlProduct.SelectedItem.Value + "-00-0000";
                                string newbatchinser = "insert into T_Pro(Pro_ID,MRP,Mfd_Date,Exp_Date,Batch_No,Entry_Date,Series_Limit)values('" + ddlProduct.SelectedItem.Value + "','0','" + System.DateTime.Now.ToString("yyyy-MM-dd") + "','" + System.DateTime.Now.AddMonths(60).ToString("yyyy-MM-dd") + "','" + InputBatchNumber + "',GETDATE(),'" + InitialSerieseDetails + "')";
                              int RowId= Convert.ToInt32(SQL_DB.ExecuteScalar(newbatchinser));

                                grpupdateqry = "UPDATE [M_Code_PFL] SET Pro_ID='" + Newpro + "',Batch_No='" + RowId + "',[Series_Order]=" + Newseries_order + ", [Series_Serial]=" + Newseries_serial + " WHERE  Row_ID='" + M_CodeId + "' ";
                                SQL_DB.ExecuteNonQuery(grpupdateqry);
                            }
                            else
                            {
                                string Series_Limit = "From  " + SelectedBatch[1] + "   To  " + NewSerialCode;
                                string Tproupdateqry = "UPDATE [T_Pro] SET Series_Limit='" + Series_Limit + "',Batch_No='" + InputBatchNumber + "',Entry_Date=GETDATE() WHERE  Row_ID='" + BatchNo + "' ";
                                SQL_DB.ExecuteNonQuery(Tproupdateqry);
                            }

                                


                        }

                    }


                    LblMsg.Text = Convert.ToString(Arr.Length) + " Rows Updated";
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "Updated", "showAlert('Success', '"+ LblMsg.Text + " Successfully', 'success');", true);
            }
            else
               // LblMsg.Text = "no row selected"; 
            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'no row selected', 'error');", true);

            txtcode.Text = "";
            txtbatchsize.Text = "";
            txtscrapfrom.Text = "";
            ddlproductFrom.SelectedIndex = 0;
            lblcount.Text = "";
            DataTable dt = new DataTable();
            Grdscrap.DataSource = dt;
            Grdscrap.DataBind();
        }
        catch
        {

            txtcode.Text = "";
            txtbatchsize.Text = "";
            txtscrapfrom.Text = "";
            ddlproductFrom.SelectedIndex = 0;
            lblcount.Text = "";
            DataTable dt = new DataTable();
            Grdscrap.DataSource = dt;
            Grdscrap.DataBind();
            LblMsg.Text = "Request aborted , Please try again later !";
            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', '"+ LblMsg.Text + "', 'error');", true);
        }

    }

    protected void btnYesScrap_Click(object sender, EventArgs e)
    {
        if (hidden1.Value != null)
        {

            if (txtbatchnumber.Text.Trim() == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please enter a batch number !', 'error');", true);
                return;
            }

            if (ddlproductFrom.SelectedItem.Value==ddlProduct.SelectedItem.Value)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please select another product to assign,both products are same !', 'error');", true);
                return;
            }
            if (string.IsNullOrEmpty(txtDateFrom.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please enter manufacturing date', 'error');", true);
                return;
            }
            if (string.IsNullOrEmpty(txtDateTo.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please enter expiry date', 'error');", true);
                return;
            }
            string Pro_Id = ddlProduct.SelectedItem.Value;
             string BachNo = hdnbatchnumber.Value;
            string NewBachNo = txtbatchnumber.Text;
            string Manfacturingdate = txtDateFrom.Text;
            string expirydate = txtDateTo.Text;
            ScrapEntry(Pro_Id, BachNo, NewBachNo, Manfacturingdate, expirydate);

            txtcode.Text = "";
            txtbatchnumber.Text = "";
            ddlproductFrom.SelectedIndex = 0;
            txtscrapfrom.Text = ""; txtscrapto.Text = "";
            txtbatchsize.Text = "";
            txtscrapfrom.Text = "";
            LblMsg.Text = "";
            txtDateFrom.Text = "";
            txtDateTo.Text = "";
        }
           
        else
        {
            LblMsg.Text = "No row selected";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            LblMsg.Font.Bold = true;
            hidden1.Value = string.Empty;
        }
        txtbatchsize.Text = "";
    }
    protected void btnNoScrap_Click(object sender, EventArgs e)
    {

    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {

    }

    private void fillProduct_From()
    {
        DataSet ds = new DataSet();
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.Status = 1;

        string qry = "select * from Pro_Reg where Comp_ID='"+ Reg.Comp_ID + "' order by Pro_Name asc";

        SQL_DB.GetDA(qry).Fill(ds);
        
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlproductFrom, "--Select--");
      //  ddlproductFrom.SelectedIndex = 0;
 ddlproductFrom.SelectedValue= "AM29";
    }
    private void fillProduct()
    {
        DataSet ds = new DataSet();
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Reg.Status = 1;
        string qry = "select * from Pro_Reg where Comp_ID='" + Reg.Comp_ID + "' order by Pro_Name asc";

        SQL_DB.GetDA(qry).Fill(ds);
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlProduct, "--Select--");
        ddlProduct.SelectedIndex = 0;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (ddlproductFrom.SelectedItem.Text == "--Select--")
        {
            LblMsg.Text = "";
            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please select a product to move ahead !', 'error');", true);
            return;
        }
        if (string.IsNullOrEmpty(txtscrapfrom.Text.Trim()))
        {
            LblMsg.Text = "";
            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please enter serial code !', 'error');", true);
            return;
        }
        if (string.IsNullOrEmpty(txtbatchsize.Text.Trim()))
        {
            LblMsg.Text = "";
            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please enter batch size !', 'error');", true);
            return;
        }
        if (string.IsNullOrEmpty(txtbatchnumber.Text.Trim()))
        {
            LblMsg.Text = "";
            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please enter batch no !', 'error');", true);
            return;
        }
        if (string.IsNullOrEmpty(txtDateFrom.Text.Trim()) && string.IsNullOrEmpty(txtDateTo.Text.Trim()))
        {
            LblMsg.Text = "";
            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please Select date range !', 'error');", true);
            return;
        }

        if (Request.Form["chkselect"] != null)
        {
            hidden1.Value = Convert.ToString(Request.Form["chkselect"]);

            fillProduct();
            LabelAlertNewHeader.Text = "Assign to an other batch";
            ModalPopupExtenderScrap.Show();
        }
        else if (Session["Seriesdata"] != null)
        {
            hidden1.Value = Session["Seriesdata"].ToString();
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
        lblseriesdetails.Text = "";
    }

    private void fillgrid()
    {
        lblseriesdetails.Text="";
        #region Query
        string s = null;
        string Comp_ID = Session["CompanyId"].ToString();
        //if (ddlProduct.SelectedIndex == 0)
        //    s = null;
        //else s = ddlProduct.SelectedValue.ToString();

        DataSet ds = new DataSet(); //TOP (" + RowsCount + ")
        string qry = "select TOP (" + txtbatchsize.Text.Trim() + ") p.Pro_Name,cast(m.Code1 as varchar(5)) + cast(m.Code2 as varchar(8)) Completedcode," +
            "m.Pro_ID +'-'+convert(varchar,(case when len(convert(nvarchar,m.Series_Order)) = 1 then '0'+ convert(nvarchar,m.Series_Order) else convert(nvarchar,m.Series_Order) end))  +'-'+ convert(varchar,(case when len(convert(nvarchar,m.Series_Serial)) = 1 then '000'+ convert(nvarchar,m.Series_Serial) when len(convert(nvarchar,m.Series_Serial)) = 2 then '00'+ convert(nvarchar,m.Series_Serial) when len(convert(nvarchar,m.Series_Serial)) = 3 then '0'+ convert(nvarchar,m.Series_Serial) else convert(nvarchar,m.Series_Serial) end)) as SerialCode," +
            "(select Batch_No from  T_Pro where Row_Id=m.Batch_No)Batch_No,s.DateFrom,s.DateTo," +
            "case when st.isactive = 0 then 'Deactived' when st.isactive = -1 then 'Expired' else 'Active' end Status " +
            "from M_Code_PFL m inner join Pro_Reg p on p.Pro_ID = m.Pro_ID inner join M_ServiceSubscription s on s.Comp_ID = p.Comp_ID " +
            "and s.Pro_ID = m.Pro_ID and s.IsDelete=0 inner join tbl_Pfl_importedCodeDetails pfl on pfl.Code1=m.Code1 and pfl.Code2=m.Code2" +
            " inner join M_ServiceSubscriptionTrans st on st.Subscribe_Id = s.Subscribe_Id  and (st.IsActive=1 or st.IsActive=0) " +
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
        else if (ddlproductFrom.SelectedItem.Text == "--Select--")
        {
            LblMsg.Text = "";
            str += "";
            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please select a product to move ahead !', 'error');", true);
            return;
        }
        else if (txtscrapfrom.Text == "")
        {
            LblMsg.Text = "";
            str += "";
            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please enter valid serial code!', 'error');", true);
            return;
        }
        else if (txtscrapfrom.Text.Length > 18 || txtscrapfrom.Text.All(char.IsLetterOrDigit))
        {
            txtscrapfrom.Text = "";
            LblMsg.Text = "";
            str += "";

            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please enter valid serial code! (Like : XXXX-XXXX-XXXX)', 'error');", true);

            return;
        }
        else if (txtbatchsize.Text == "")
        {
            LblMsg.Text = "";
            str += "";
            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please provides number of codes, how much you want to move !', 'error');", true);
            return;
        }

        else if (ddlproductFrom.SelectedItem.Text != "--Select--" && txtbatchsize.Text != "" && txtscrapfrom.Text != "")
        {
            string[] Serialcode = txtscrapfrom.Text.Split('-');
            string pro = ddlproductFrom.SelectedItem.Value;

            str += " AND m.Pro_ID='" + pro + "' and Use_Count is null ";

            string Ser_ProId = Serialcode[0].ToString().Trim();
              Int32 Series_Order = Convert.ToInt32(Serialcode[1]);
             Int32 Series_Serial = Convert.ToInt32(Serialcode[2]);
string EnteredSearies_Name = pro + "-00" + Serialcode[1].ToString() + "-" + Serialcode[2].ToString();

            if(pro != Ser_ProId)
            {
                txtscrapfrom.Text = "";
                LblMsg.Text = "";
                str += "";
                ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Please enter valid serial code! (Like : " + pro + "-XXXX-XXXX)', 'error');", true);
                return;
            }
            //str += " AND m.Series_Order =" + Series_Order + " AND m.Series_Serial >= " + Series_Serial + "order by pfl.SNO asc";
            str += " and pfl.SNO >= (Select SNO from tbl_Pfl_importedCodeDetails where Searies_Name='"+ txtscrapfrom.Text.Trim() + "') order by pfl.SNO asc";
   
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

        if (ds.Tables["1"].Rows.Count > 0)
        {
            DataTable dt = new DataTable();

            dt = ds.Tables["1"].AsEnumerable().Take(Convert.ToInt32(txtbatchsize.Text)).CopyToDataTable();

            Session["GrdData"] = (DataTable)dt;

            if (ds.Tables["1"].Rows.Count < Convert.ToInt32(txtbatchsize.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Number of availble codes for selected productes are " + ds.Tables["1"].Rows.Count + " !', 'error');", true);
                return;
            }
            if (Convert.ToInt32(txtbatchsize.Text) > 100)
            {
                string firstSerialCode = dt.Rows[0]["SerialCode"].ToString();
                string lastSerialCode = dt.Rows[dt.Rows.Count - 1]["SerialCode"].ToString();
                string totalCodes = dt.Rows.Count.ToString();

                List<string> serialCodes = new List<string>();
                foreach (DataRow dr in dt.Rows)
                {
                    serialCodes.Add(dr["SerialCode"].ToString());
                }
                string formattedSerialCodes = string.Join(",", serialCodes);
                Session["Seriesdata"] = formattedSerialCodes;

                DataTable dtserialcode = new DataTable();
                dtserialcode.Columns.Add("Series Start From");
                dtserialcode.Columns.Add("Series End To");
                dtserialcode.Columns.Add("No Of Codes");

                DataRow row = dtserialcode.NewRow();
                row["Series Start From"] = firstSerialCode;
                row["Series End To"] = lastSerialCode;
                row["No Of Codes"] = totalCodes;
                dtserialcode.Rows.Add(row);

                newgrd.DataSource = dtserialcode;
                newgrd.DataBind();
                newgrd.Visible = true;
                Grdscrap.Visible = false;


                lblcount.Text = ds.Tables["1"].Rows.Count.ToString();
                lblC.Text = txtbatchsize.Text;
            }
            else
            {
                Grdscrap.DataSource = dt;
                Grdscrap.DataBind();
                Grdscrap.Visible = true;
                newgrd.Visible = false;
                lblcount.Text = ds.Tables["1"].Rows.Count.ToString();
                lblC.Text = Grdscrap.Rows.Count.ToString();
            }
        }
        else
        {
            Grdscrap.Visible = false;
            lblcount.Text = "0";
            ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'No records found !', 'error');", true);
            return;
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
        ddlproductFrom.SelectedIndex = 0;
        txtscrapfrom.Text = ""; txtscrapto.Text = "";
        txtbatchsize.Text = "";
        txtscrapfrom.Text = "";
        LblMsg.Text = "";
        lblcount.Text = "";
        DataTable dt = new DataTable();
        Grdscrap.DataSource = dt;
        Grdscrap.DataBind();


        //fillgrid();
    }

    protected void ddlProduct_SelectedIndexChanged1(object sender, EventArgs e)
    {
        lblseriesdetails.Text = "";
	hdnbatchnumber.Value = "";


        #region Check batch number is exist ?
        DataSet Exds = new DataSet();
        string Exqry = "select pr.Pro_ID,p.Pro_Name from T_Pro pr inner join Pro_Reg p on p.Pro_ID=pr.Pro_ID where pr.Batch_No='" + txtbatchnumber.Text.Trim() + "' and p.Comp_ID='" + Session["CompanyId"].ToString() + "'";
        SQL_DB.GetDA(Exqry).Fill(Exds);
        if (Exds.Tables[0].Rows.Count > 0 )
        {
            if((Exds.Tables[0].Rows[0]["Pro_ID"].ToString()).Trim() != ddlProduct.SelectedItem.Value.Trim())
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "showAlert('Error', 'Entered batch number already exist with product : " + Exds.Tables[0].Rows[0]["Pro_Name"] + " !', 'error');", true);
                return;
            }
           
        }
        #endregion

        DataSet ds = new DataSet();
            Object9420 Reg = new Object9420();
            Reg.Comp_ID = Session["CompanyId"].ToString();
            Reg.Status = 1;

        string qry = "select Batch_No,Row_ID,Series_Limit from T_Pro where Pro_ID='" + ddlProduct.SelectedItem.Value+ "' order by Entry_Date desc";
        SQL_DB.GetDA(qry).Fill(ds);

        DataTable dt = new DataTable();
        if(ds.Tables[0].Rows.Count==0)
        {

            //var lowerBound = 1;
            //var upperBound = 9999999;
            //Random rnd = new Random();
            //var Imagename = rnd.Next(lowerBound, upperBound);
            //string BatchNo = Imagename.ToString();


            string BatchNo = txtbatchnumber.Text.Trim();
            string InitialSerieseDetails = "From  " + ddlProduct.SelectedItem.Value + "-00-0000   To  " + ddlProduct.SelectedItem.Value + "-00-0000";
                string grpupdateqry = "insert into T_Pro(Pro_ID,MRP,Mfd_Date,Exp_Date,Batch_No,Entry_Date,Series_Limit)values('"+ ddlProduct.SelectedItem.Value + "','0','"+System.DateTime.Now.ToString("yyyy-MM-dd")+ "','" + System.DateTime.Now.AddMonths(60).ToString("yyyy-MM-dd") + "','"+ BatchNo + "',GETDATE(),'" + InitialSerieseDetails + "')";
            SQL_DB.ExecuteNonQuery(grpupdateqry);

            #region Recheck for existance
            SQL_DB.GetDA(qry).Fill(ds);

            dt = ds.Tables[0];
            #endregion

        }

        if (ds.Tables[0].Rows.Count > 0)
        {
            dt = ds.Tables[0];
            hdnbatchnumber.Value= dt.Rows[0]["Row_ID"].ToString();
            lblseriesdetails.Text = dt.Rows[0]["Series_Limit"].ToString();
            DataRow[] filteredRows = dt.Select("Batch_No like '%" + txtbatchnumber.Text.Trim() + "%'", "Row_ID desc");

            if (filteredRows.Length==0)
            {
                string InitialSerieseDetails = lblseriesdetails.Text;
                string grpupdateqry = "insert into T_Pro(Pro_ID,MRP,Mfd_Date,Exp_Date,Batch_No,Entry_Date,Series_Limit)values('" + ddlProduct.SelectedItem.Value + "','0','" + System.DateTime.Now.ToString("yyyy-MM-dd") + "','" + System.DateTime.Now.AddMonths(60).ToString("yyyy-MM-dd") + "','" + txtbatchnumber.Text.Trim() + "',GETDATE(),'" + InitialSerieseDetails + "')";
              SQL_DB.ExecuteNonQuery(grpupdateqry);


                DataSet newds = new DataSet();
                SQL_DB.GetDA(qry).Fill(newds);
                DataTable newdt = new DataTable();
                
                newdt = newds.Tables[0];
                hdnbatchnumber.Value = newdt.Rows[0]["Row_ID"].ToString();
            }
            else
            {
                hdnbatchnumber.Value = filteredRows[0][1].ToString();
                //lblseriesdetails.Text = filteredRows[2].ToString();
            }
        }
        else
            lblseriesdetails.Text = "";



        //ModalPopupExtenderScrap.Show();
        //ddlbachno.DataSource = dt;
        //ddlbachno.DataValueField = "Row_ID";
        //ddlbachno.DataTextField = "Batch_No";
        //ddlbachno.DataBind();
        //ddlbachno.Items.Insert(0, new ListItem("--Select--", "--Select--"));

        //ddlbachno.SelectedIndex = 0;
        //lblseriesdetails.Text = "";
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

    protected void txtbatchsize_TextChanged(object sender, EventArgs e)
    {

    }
}