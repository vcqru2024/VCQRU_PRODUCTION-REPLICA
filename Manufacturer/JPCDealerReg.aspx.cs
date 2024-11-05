using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_JPCDealerReg : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["defaultConnectionbeta"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["CompanyId"] = "Comp-1216";
        if (Session["CompanyId"] == null)
            Response.Redirect("../Info/Login.aspx?Page=ServiceSettings.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
    }

    protected void Button1_Click(object sender, System.EventArgs e)
    {



        string Pan = txtPan.Text.Trim();
        string Dealer = txtDealer.Text.Trim();
        string Mobile = txtMobile.Text.Trim();
        string Adhar = txtAdhar.Text.Trim();
        string address = txtaddress.Text.Trim();

        Boolean Req = false;

        if (Dealer == "")
        {
            LblMsg.Visible = true;
            LblMsg.Text = "Please Enter Dealer Name";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            Req = true;
            return;
        }
        else if (Mobile == "")
        {
            LblMsg.Visible = true;
            LblMsg.Text = "Please Enter Mobile No";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            Req = true;
            return;
        }

        else if (Pan == "" && Adhar == "")
        {
            LblMsg.Visible = true;
            LblMsg.Text = "Please Enter Valid Data";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            Req = true;
            return;
        }
        else if (address == "")
        {
            LblMsg.Visible = true;
            LblMsg.Text = "Please Enter City Name";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            Req = true;
            return;
        }
        else if (!Regex.IsMatch(address, @"^[A-Za-z\s]+$"))
        {
            LblMsg.Visible = true;
            LblMsg.Text = "Please Enter City Name";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            Req = true;
            return;
        }

        DataTable dtjpcdealer = SQL_DB.ExecuteDataTable("select [Dealer Code] from dealership_details where [Dealer Code]='" + Pan + "'");
        if (dtjpcdealer.Rows.Count > 0)
        {
            LblMsg.Visible = true;
            LblMsg.Text = "Dealer Id Already Exists";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            return;
        }

        DataTable dtMobile = SQL_DB.ExecuteDataTable("select MOBILENO from dealership_details where MOBILENO='" + Mobile + "'");
        if (dtMobile.Rows.Count > 0)
        {
            LblMsg.Visible = true;
            LblMsg.Text = "Mobile Number Already Exists";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            return;
        }




        if (Req == false)
        {

            try
            {
              //  SQL_DB.ExecuteNonQuery("delete from TBLJPCReg");


                if (Pan == "")
                {
                    SQL_DB.ExecuteNonQuery("insert into TBLJPCReg(PAN,DEALERSHIPNAME,MOBILENO,AdharNo,city)values(Null,'" + Dealer + "','" + Mobile + "','" + Adhar + "','" + address + "')");
                }

                else if (Adhar == "")
                {
                    SQL_DB.ExecuteNonQuery("insert into TBLJPCReg(PAN,DEALERSHIPNAME,MOBILENO,AdharNo,city)values('" + Pan + "','" + Dealer + "','" + Mobile + "',Null,'" + address + "')");
                }
                else
                {
                    SQL_DB.ExecuteNonQuery("insert into TBLJPCReg(PAN,DEALERSHIPNAME,MOBILENO,AdharNo,city)values('" + Pan + "','" + Dealer + "','" + Mobile + "','" + Adhar + "','" + address + "')");
                }



                DataSet ds = SQL_DB.ExecuteDataSet("exec Pro_JPCDealerReg");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    LblMsg.Visible = true;
                    LblMsg.Text = "Updated successfully";
                    LblMsg.ForeColor = System.Drawing.Color.Green;
                    GridView1.DataSource = ds.Tables[0];
                    GridView1.DataBind();
                    GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;

                }
                else
                {
                    GridView1.DataSource = "";
                    GridView1.DataBind();

                }


            }
            catch (Exception ex)
            {
                LblMsg.Visible = true;
                LblMsg.Text = ex.Message;
                LblMsg.ForeColor = System.Drawing.Color.Red;
            }

        }
        else
        {

            LblMsg.Text = "Please Fill Required Fields!";
            LblMsg.Visible = true;
            LblMsg.ForeColor = System.Drawing.Color.Red;
        }

    }
    protected void btneditdealer_Click(object sender, EventArgs e)
    {
        btnsection.Visible = false;
        filtersection.Visible = true;

        bindgried();
    }

    public void bindgried()
    {

        string qry = " select [Dealer Code] as dealercode ,[Dealer Name] as dealername,City as city ,MOBILENO as mobileno from dealership_details " +
       "where len([dealer code])>= 15 and[Dealer Code] not like '%active%' " +
       "and[Dealer Code] not like '%deacti%'" +
       "and[dealer name] not like '%test%'" +
        "and[mobileno] <>''" +
       "group by[Dealer Code],[Dealer Name], City, MOBILENO";

        divregistration.Visible = false;
        DataTable dt = SQL_DB.ExecuteDataTable(qry);
        //DataTable dt = SQL_DB.ExecuteDataTable("select*from fn_JPCDealderdetails()");
        GridView2.DataSource = dt;
        GridView2.DataBind();
    }


    protected void GridView2_RowEditing(object sender, GridViewEditEventArgs e)
    {

        GridView2.EditIndex = e.NewEditIndex;

        bindgried();
    }

    protected void GridView2_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView2.EditIndex = -1;
        bindgried();
    }

    protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        LblMsg.Text = "";
        Label dealerid = GridView2.Rows[e.RowIndex].FindControl("lbldealerid") as Label;
        Label dealercode = GridView2.Rows[e.RowIndex].FindControl("lbldealercode") as Label;
        Label dealermobile = GridView2.Rows[e.RowIndex].FindControl("lbldealermobile") as Label;
        Label dealername = GridView2.Rows[e.RowIndex].FindControl("txt_dealername") as Label;
        TextBox dealercity = GridView2.Rows[e.RowIndex].FindControl("txt_dealercity") as TextBox;


        //if (dealercity.Text=="")
        //{
        //    LblMsg.Visible = true;
        //    LblMsg.Text = "Please Enter Valid City";
        //    LblMsg.ForeColor = System.Drawing.Color.Red;
        //    return;
        //}
        if (!Regex.IsMatch(dealercity.Text.Trim(), @"^[A-Za-z\s]+$"))
        {
            LblMsg.Visible = true;
            LblMsg.Text = "Please Enter Valid City";
            LblMsg.ForeColor = System.Drawing.Color.Red;
            return;
        }


        SQL_DB.ExecuteNonQuery("update dealership_details set City='" + dealercity.Text.Trim() + "'  where [Dealer Code]='" + dealercode.Text + "'");

        // SQL_DB.ExecuteNonQuery("update m_dealermaster set City='" + dealercity.Text + "' where DealerCode='" + dealercode.Text + "'");
        GridView2.EditIndex = -1;
        bindgried();
    }

    public void Bindgrid()
    {

        string mob = txtmobileno.Text;



        LblMsg.Text = "";
        string datefromstr = string.Empty;
        string datetostr = string.Empty;
        if (txtDateFrom.Text != "")
            datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd" + " " + "00:00:01.999");
        if (txtDateto.Text != "")
            datetostr = Convert.ToDateTime(txtDateto.Text).ToString("yyyy-MM-dd" + " " + "23:59:59.999");
        try
        {
            SqlConnection con = new SqlConnection(SQL_DB.ConnectionString);
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter();
            if (mob != "" && datefromstr == "" && datetostr == "")
            {
                string qry = " select [Dealer Code] as dealercode ,[Dealer Name] as dealername,City,MOBILENO from dealership_details " +
       "where len([dealer code])>= 15 and[Dealer Code] not like '%active%' " +
       "and[Dealer Code] not like '%deacti%'" +
        "and[mobileno] <>''" +
       "and[dealer name] not like '%test%' and MOBILENO like'%" + mob + "%' " +
       "group by[Dealer Code],[Dealer Name], City, MOBILENO";

                SqlCommand cmd = new SqlCommand(qry, con);
                da = new SqlDataAdapter(cmd);
            }
            //else if (mob != "" && datefromstr != "" && datetostr != "")
            //{
            //    string qry = "select mc.ConsumerName, fr.Mobileno,Purchasedfrom,fr.Address,fr.City,fr.State,fr.Country,Dateofreport,Imgpath  from tbl_Wellverse_Fake_RPT fr inner join M_Consumer mc on mc.MobileNo=fr.Mobileno where fr.Comp_id='" + Session["CompanyId"].ToString() + "' and  fr.Dateofreport>='" + datefromstr + "'and fr.Dateofreport<='" + datetostr + "' and fr.Mobileno='" + mob + "'";
            //    // string qry = "select Mobile_no,User_Name,Email,PinCode,City,State,Retailer_name,case  when book_name= 'Book1' then 'Black book of English Vocabulary.'when book_name= 'Book2' then 'Black book of Samanya Jagrukta.'when book_name= 'Book3' then 'Black book of General Awareness.'end as Book_name,Rating,Feedback,Enq_date from tbl_blackbookuserdetails where  enq_date>='" + datefromstr + "'and enq_date<='" + datetostr + "' and Mobile_no='" + mob + "'";
            //    SqlCommand cmd = new SqlCommand(qry, con);
            //    da = new SqlDataAdapter(cmd);
            //}

            //else if (mob == "" && datefromstr != "" && datetostr != "")
            //{
            //    string qry = "select mc.ConsumerName, fr.Mobileno,Purchasedfrom,fr.Address,fr.City,fr.State,fr.Country,Dateofreport,Imgpath  from tbl_Wellverse_Fake_RPT fr inner join M_Consumer mc on mc.MobileNo=fr.Mobileno where fr.Comp_id='" + Session["CompanyId"].ToString() + "' and  fr.Dateofreport>='" + datefromstr + "'and fr.Dateofreport<='" + datetostr + "'";
            //    // string qry = "select Mobile_no,User_Name,Email,PinCode,City,State,Retailer_name,case  when book_name= 'Book1' then 'Black book of English Vocabulary.'when book_name= 'Book2' then 'Black book of Samanya Jagrukta.'when book_name= 'Book3' then 'Black book of General Awareness.'end as Book_name,Rating,Feedback,Enq_date from tbl_blackbookuserdetails where  enq_date>='" + datefromstr + "'and enq_date<='" + datetostr + "' and Mobile_no='" + mob + "'";
            //    SqlCommand cmd = new SqlCommand(qry, con);
            //    da = new SqlDataAdapter(cmd);
            //}

            else
            {
                string qry = " select [Dealer Code] as dealercode ,[Dealer Name] as dealername,City,MOBILENO from dealership_details " +
        "where len([dealer code])>= 15 and[Dealer Code] not like '%active%' " +
        "and[Dealer Code] not like '%deacti%'" +
        "and[dealer name] not like '%test%'" +
         "and[mobileno] <>''" +
        "group by[Dealer Code],[Dealer Name], City, MOBILENO";
                SqlCommand cmd = new SqlCommand(qry, con);
                da = new SqlDataAdapter(cmd);
            }


            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            GridView2.DataSource = dt;
            GridView2.DataBind();

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }



    protected void btn_download_Click(object sender, EventArgs e)
    {
        string qry = "";
        string mob = txtmobileno.Text;
        if (mob == "")
        {
            qry = " select [Dealer Code] as dealercode ,[Dealer Name] as dealername,City,MOBILENO from dealership_details " +
       "where len([dealer code])>= 15 and[Dealer Code] not like '%active%' " +
       "and[Dealer Code] not like '%deacti%'" +
       "and[dealer name] not like '%test%'" +
        "and[mobileno] <>''" +
       "group by[Dealer Code],[Dealer Name], City, MOBILENO";
        }
        else
        {
            qry = " select [Dealer Code] as dealercode ,[Dealer Name] as dealername,City,MOBILENO from dealership_details " +
     "where len([dealer code])>= 15 and[Dealer Code] not like '%active%' " +
     "and[Dealer Code] not like '%deacti%'" +
      "and[mobileno] <>''" +
     "and[dealer name] not like '%test%' and MOBILENO like'%" + mob + "%' " +
     "group by[Dealer Code],[Dealer Name], City, MOBILENO";
        }

        DataTable dt = SQL_DB.ExecuteDataTable(qry);
        if (dt.Rows.Count > 0)
        {
            GridView2.DataSource = dt;
            GridView2.DataBind();
            string date = Convert.ToString(DateTime.Now);
            XLWorkbook wb = new XLWorkbook();
            wb.Worksheets.Add(dt, "Reported Data");
            MemoryStream stream = new MemoryStream();
            wb.SaveAs(stream);
            Response.Clear();
            Response.ContentType = "application/force-download";
            Response.AddHeader("content-disposition", "attachment;    filename=Reported_Data" + date + ".xlsx");
            Response.BinaryWrite(stream.ToArray());
            Response.End();


        }

    }

    protected void imgsearch_Click(object sender, ImageClickEventArgs e)
    {
        Bindgrid();
    }

    protected void imgreset_Click(object sender, ImageClickEventArgs e)
    {
        txtDateFrom.Text = "";
        txtDateto.Text = "";
        txtmobileno.Text = "";
        Bindgrid();
    }
    protected void grd1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView2.PageIndex = e.NewPageIndex;
        Bindgrid();
    }



    protected void btnnewregistration_Click(object sender, EventArgs e)
    {
        btnsection.Visible = false;
        divregistration.Visible = true;
    }

    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //Get the value of column from the DataKeys using the RowIndex.
            //string getcity = e.Row.Cells[3].Text.Contains("").ToString();

            var row = (DataRowView)e.Row.DataItem;
            var ckcity = row.Row.ItemArray[2].ToString();
            //var id = (int)row["Label2"];


            if (ckcity == "")
            {
                e.Row.Enabled = true;//row is editable
            }
            else
            {
                LinkButton btnEdit = (LinkButton)e.Row.FindControl("LinkButton3");
                btnEdit.Visible = false;
                e.Row.Enabled = false;//row is not editable

            }
        }
        if (e.Row.RowType == DataControlRowType.DataRow && (e.Row.RowState & DataControlRowState.Edit) > 0)
        {
            // Register the startup script to set focus on the edit textbox
            ScriptManager.RegisterStartupScript(this, GetType(), "SetFocusScript", "SetFocusOnEditTextBox();", true);
        }




        // Bindgrid();
    }

    protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView2.PageIndex = e.NewPageIndex;
        bindgried();
    }
}
