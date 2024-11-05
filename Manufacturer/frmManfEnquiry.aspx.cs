using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business9420;
using System.Data;
using Data9420;
using System.Runtime.InteropServices;
using ClosedXML.Excel;
using System.IO;
using ZXing.OneD;

using TheArtOfDev.HtmlRenderer.PdfSharp;
using PdfSharp;
using System.Net;
using System.Text;

public partial class frmManfEnquiry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

        }
        if (Session["CompanyId"] == null)
        {
            Response.Redirect("/Login.aspx");
            //Response.Redirect("default.aspx?Page=frmManfEnquiry.aspx");
        }
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");

            if (Convert.ToString(Session["CompanyId"]) == "Comp-1248")
                Response.Redirect("AmrutanjanParticipantDetails.aspx");

            if (Convert.ToString(Session["CompanyId"]) == "Comp-1152")
            {
                GrdEnquiry.Columns[7].Visible = true;
                GrdEnquiry.Columns[8].Visible = true;
            }
            else
            {
                GrdEnquiry.Columns[7].Visible = false;
                GrdEnquiry.Columns[8].Visible = false;
            }
        }
        if (!Page.IsPostBack)
        {
            if (DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()) != "")
                Response.Redirect(DataProvider.User_Status.CheckUserStatus(Session["CompanyId"].ToString(), Session["User_Type"].ToString()));
            fillservice();
            allClear();
            fillMode();
            fillData();
        }
        if (Convert.ToString(Session["CompanyId"]) == "Comp-1326")
        {
            btnCodeStatus.Visible = false;
        }
    }
    private void fillservice()
    {
        DataSet ds = SQL_DB.ExecuteDataSet("select distinct sb.service_id,serv.servicename from M_ServiceSubscription sb left join m_service serv on sb.Service_ID=serv.Service_ID where sb.Comp_ID='" + Session["CompanyId"].ToString() + "'");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "service_id", "servicename", ddlservice, "--Service--");
        ddlservice.SelectedIndex = 0;
    }
    private void fillMode()
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT distinct [Dial_Mode] ,[Dial_Mode] as Dial_Mode1 FROM [Pro_Enq] order by [Dial_Mode]");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Dial_Mode", "Dial_Mode1", ddlMode, "--Select --");
        ddlMode.SelectedIndex = 0;
        FillProducts(Session["CompanyId"].ToString());
    }
    private void FillProducts(string CompID)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT DISTINCT Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, Pro_Reg.Comp_ID FROM M_Code FULL OUTER JOIN  Pro_Reg ON M_Code.Pro_ID = Pro_Reg.Pro_ID WHERE (M_Code.Print_Status = 1)  AND (Pro_Reg.Comp_ID = '" + CompID.ToString() + "')");
        DataProvider.MyUtilities.FillDDLInsertZeroIndexString(ds, "Pro_ID", "Pro_Name", ddlproname, "--Product--");
        ddlproname.SelectedIndex = 0;
    }



    private void allClear()
    {
        txtDateFrom.Text = "";
        txtDateTo.Text = "";
        ddlMode.SelectedIndex = 0;
        ddlStatus.SelectedIndex = 0;
    }
    private void fillData()
    {
        #region Query
        Object9420 Reg = new Object9420();
        if (ddlproname.SelectedIndex > 0)
        {
            Reg.Pro_ID = ddlproname.SelectedValue;
            Reg.Msg = "M_Code.Pro_ID = '" + Reg.Pro_ID + "'";
        }
        else
            Reg.Pro_ID = "";
        if (Reg.Msg != null)
        {
            if (Reg.Msg.Length > 1)
                Reg.Msg = " WHERE " + Reg.Msg;
        }
        Reg.Comp_ID = Session["CompanyId"].ToString();
        if (Reg.Msg != null)
        {
            if (Reg.Msg.Length > 1)
                Reg.Msg += " AND [m_code].Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
        }
        else
        {


            Reg.Msg += " WHERE [m_code].Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
        }
        #region Adding the date condition if Comp_ID is "Comp-1321"
        if (Reg.Comp_ID == "Comp-1595")
        {
            // Only show data from 18th September 2024 onwards
            Reg.Msg += " AND convert(nvarchar, [vw_pro_enq].Enq_Date, 111) >= '2024/09/18'";
        }

        #endregion

        if (txtDateFrom.Text == "")
            Reg.datefromstr = "convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111))";
        else
        {
            //Reg.datefromstr = "'" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
            //Reg.Msg += " AND convert(nvarchar,Pro_Enq.Enq_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
            Reg.Msg += " AND convert(nvarchar,[vw_pro_enq].Enq_Date,111) >= '" + Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy/MM/dd") + "'";
        }

        if (txtDateTo.Text == "")
            Reg.datetostr = "convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111))";
        else
        {
            //Reg.datetostr = "'" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
            Reg.Msg += " AND convert(nvarchar,[vw_pro_enq].Enq_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        }
        if (ddlMode.SelectedIndex == 0)
            Reg.modestr = "[vw_pro_enq].Dial_Mode";
        else
        {
            //Reg.modestr = "'" + ddlMode.SelectedValue.ToString() + "'";
            Reg.Msg += " AND [vw_pro_enq].[Dial_Mode] = '" + ddlMode.SelectedItem.Text.ToString() + "'";
        }
        if (ddlStatus.SelectedIndex == 0)
            Reg.statusstr = "(case when [vw_pro_enq].Is_Success = '1' then 'Success' else 'Unsuccess' end)";
        else
        {
            //Reg.statusstr = "'" + ddlStatus.SelectedItem.Text.ToString() + "'";
            Reg.Msg += "AND (case when [vw_pro_enq].Is_Success = '1' then 'Success' else 'Unsuccess' end) = '" + ddlStatus.SelectedItem.Text.ToString() + "'";
        }
        DataSet ds = function9420.FillFridForEnqDetails(Reg);
        #endregion

        if (ds.Tables[0].Rows.Count > 0)
        {
            //if (Convert.ToString(Session["CompanyId"]) == "Comp-1321")
            //{
            //    DataTable dt = new DataTable();
            //    dt = ds.Tables[0];
            //    dt.Columns.Remove("MobileNo");
            //    dt.Columns.Add("MobileNo", typeof(string));
            //    dt.AcceptChanges();

            //    string[] selectedColumns = new[] { "EnquiryDate", "Pro_Name", "ModeOfInquiry", "MobileNo", "Received_Code1", "Received_Code2", "Successstatus", "employeeid", "distributorid" };

            //    DataTable Selecteddt = new DataView(dt).ToTable(false, selectedColumns);

            //    GrdEnquiry.DataSource = Selecteddt;
            //}
            //else
                GrdEnquiry.DataSource = ds.Tables[0];
        }

        GrdEnquiry.DataBind();
        lblcount.Text = GrdEnquiry.Rows.Count.ToString();
        //if (GrdEnquiry.Rows.Count > 0)
        //    GrdEnquiry.HeaderRow.TableSection = TableRowSection.TableHeader;

    }

    protected void btnCodeStatus_Click(object sender, EventArgs e)
    {
        Response.Redirect("VendorCodeStatus.aspx");
    }
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {
        fillData();
    }

    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        allClear();
        fillData();
    }
    protected void GrdEnquiry_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdEnquiry.PageIndex = e.NewPageIndex;
        fillData();
    }

    protected void btnDownloadExcel_Click(object sender, EventArgs e)
    {
        Object9420 Reg = new Object9420();
        if (txtDateFrom.Text != "")
            Reg.datefromstr = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd");
        if (txtDateTo.Text != "")
            Reg.datetostr = Convert.ToDateTime(txtDateTo.Text).ToString("yyyy-MM-dd");
        if (ddlservice.SelectedIndex > 0)
        {
            Reg.Service_ID = ddlservice.SelectedValue;

        }
        else
        {
            Reg.Service_ID = "";
        }
        if (ddlproname.SelectedIndex > 0)
        {
            Reg.Pro_ID = ddlproname.SelectedValue;
            //Reg.Msg = "M_Code.Pro_ID = '" + Reg.Pro_ID + "'";
        }
        else
            Reg.Pro_ID = "";
        if (Reg.Msg != null)
        {
            if (Reg.Msg.Length > 1)
                Reg.Msg = " WHERE " + Reg.Msg;
        }
        Reg.Comp_ID = Session["CompanyId"].ToString();
        if (Reg.Msg != null)
        {
            if (Reg.Msg.Length > 1)
                Reg.Msg += " AND [m_code].Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
        }
        else
        {
            Reg.Msg += " WHERE [m_code].Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "'))";
        }
        #region Adding the date condition if Comp_ID is "Comp-1595"
        if (Reg.Comp_ID == "Comp-1595")
        {
            // Only show data from 18th September 2024 onwards
            Reg.Msg += " AND convert(nvarchar, [vw_pro_enq].Enq_Date, 111) >= '2024/09/18'";
        }

        #endregion
        if (txtDateFrom.Text == "")
        {
            Reg.datefromstr = "";

        }

        if (txtDateTo.Text == "")
        {
            Reg.datetostr = "";

        }

        if (txtDateTo.Text == "")
            Reg.datetostr = "Pro_Enq.Enq_Date,";
        else
        {
            //Reg.datetostr = "'" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy-MM-dd 00:00:00.000") + "'";
            Reg.Msg += " AND convert(nvarchar,Pro_Enq.Enq_Date,111) <= '" + Convert.ToDateTime(txtDateTo.Text).ToString("yyyy/MM/dd") + "'";
        }
        if (ddlMode.SelectedIndex > 0)
            //Reg.modestr = "Pro_Enq.Dial_Mode";
            Reg.modestr = ddlMode.Text;
        else
        {
            //Reg.modestr = "'" + ddlMode.SelectedValue.ToString() + "'";
            //Reg.Msg += " AND Pro_Enq.[Dial_Mode] = '" + Reg.modestr + "'";
            Reg.modestr = "";
        }
        if (ddlStatus.SelectedIndex > 0)
            // Reg.statusstr = "(case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end)";
            Reg.statusstr = ddlStatus.Text;
        else
        {
            Reg.statusstr = "";
            //Reg.statusstr = "'" + ddlStatus.SelectedItem.Text.ToString() + "'";
            //Reg.Msg += "AND (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) = '" + ddlStatus.SelectedItem.Text.ToString() + "'";
        }

        //string strMsg = "and T_Pro.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "')) ";
        //string sQury = "SELECT Pro_Enq.Enq_Date as EnquiryDate, (SELECT Pro_Name FROM Pro_Reg Where Pro_ID = M_Code.Pro_ID) as Pro_Name, Pro_Enq.Dial_Mode AS ModeOfInquiry," +//M_Code.Pro_ID,
        //    " ISNULL(Pro_Enq.MobileNo,'-- --') as MobileNo, Pro_Enq.Received_Code1 As Code1, " +
        //    //cast(convert(nvarchar,Pro_Enq.Enq_Date,109) as datetime) as EnquiryDate 
        //    " Pro_Enq.Received_Code2 As Code2, (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) as Successstatus";
        //if (Convert.ToString(Session["CompanyId"]) == "Comp-1152")
        //    sQury = sQury + " ,isnull(mc.employeeid,'-- --') as employeeid , isnull(mc.distributorid,'-- --') as distributorid";
        //sQury = sQury + " FROM  M_Code (nolock) INNER JOIN   Pro_Enq " +
        //    " ON cast(M_Code.Code1 as nvarchar) = Pro_Enq.Received_Code1 AND cast(M_Code.Code2 as nvarchar) = Pro_Enq.Received_Code2 " +
        //    " left join T_Pro on M_code.Batch_No = T_Pro.Row_ID" +
        //    " left join m_consumer mc on mc.mobileno = Pro_Enq.MobileNo" +
        //    " where ('' = '" + Reg.Pro_ID + "' OR M_Code.Pro_ID = '" + Reg.Pro_ID + "') " +
        //    " and Pro_Enq.Enq_Date>= '" + Reg.datefromstr + "'" +
        //    " and Pro_Enq.Enq_Date <= '" + Reg.datetostr + "' " +
        //    //"and Pro_Enq.[Dial_Mode] = " + Reg.modestr + " " +
        //    " and (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) = " + Reg.statusstr + "" +
        //    " AND M_Code.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "')) " +
        //    "  order by Pro_Enq.Enq_Date desc";
        // + Reg.Msg  +  strMsg + " order by Pro_Enq.Enq_Date desc");
        Page.Validate("servss");
        if (Page.IsValid)
        {
            try
            {


                DataSet ds = Data_9420.Enquirdetailsdownload(Reg.Pro_ID, Reg.modestr, Reg.statusstr, Convert.ToDateTime(Reg.datefromstr), Convert.ToDateTime(Reg.datetostr), Reg.Comp_ID, Reg.Service_ID);
                XLWorkbook wb = new XLWorkbook();

                #region //** For Lexis and Nexis
                if (Convert.ToString(Session["CompanyId"]) == "Comp-1321")
                {
                    DataTable dt = new DataTable();
                    dt = ds.Tables[0];
                    dt.Columns.Remove("MobileNo");
                    dt.Columns.Add("MobileNo", typeof(string));
                    dt.AcceptChanges();

                    wb.Worksheets.Add(dt, "Enquiry_details");
                }
                else

                    #endregion



                    wb.Worksheets.Add(ds.Tables[0], "Enquiry_details");
                MemoryStream stream = new MemoryStream();
                wb.SaveAs(stream);
                //Return xlsx Excel File  

                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment;    filename=enquiry_details.xlsx");
                Response.BinaryWrite(stream.ToArray());
                Response.End();
                // return  File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet","Enquiry Details");

                //DownlaodExcel(ds.Tables[0]);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

    //public void DownlaodExcel(DataTable dt)
    //{
    //   // DataTable dt = SQL_DB.ExecuteDataTable(sQry);

    //    //Build the CSV file data as a Comma separated string.
    //    string csv = string.Empty;

    //    foreach (DataColumn column in dt.Columns)
    //    {
    //        //Add the Header row for CSV file.
    //        csv += column.ColumnName + ',';
    //    }

    //    //Add new line.
    //    csv += "\r\n";

    //    foreach (DataRow row in dt.Rows)
    //    {
    //        foreach (DataColumn column in dt.Columns)
    //        {
    //            //Add the Data rows.

    //                csv +=row[column.ColumnName].ToString().Replace(",", ";") + ',';


    //        }

    //        //Add new line.
    //        csv += "\r\n";
    //    }

    //    //Download the CSV file.
    //    Response.Clear();
    //    Response.Buffer = true;
    //    Response.AddHeader("content-disposition", "attachment;filename=Vendor_EnquiryDetails.csv");
    //    Response.Charset = "";
    //    //Response.ContentType = "application/text";
    //    Response.ContentType = "text/csv";
    //    Response.Output.Write(csv);
    //    Response.Flush();
    //    Response.End();
    //}

    protected void btnAccepted_Click(object sender, EventArgs e)
    {

        try
        {



            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {

                    DataSet dsCompanydetails = SQL_DB.ExecuteDataSet("select c.Comp_ID,c.Comp_Name,c.Comp_Email,c.Address,c.Contact_Person,c.Mobile_No,cd.PAN_TAN,c.ResiAddress,c.DirectorName,c.DirectorFatherName,c.AadharNumber from Comp_Reg c inner join Comp_Document cd on c.Comp_ID=cd.Comp_ID where c.Comp_ID='" + Session["CompanyId"].ToString() + "'");
                    if (dsCompanydetails.Tables[0].Rows.Count > 0)
                    {
                        string Comp_ID = dsCompanydetails.Tables[0].Rows[0]["Comp_ID"].ToString();
                        string Comp_Name = dsCompanydetails.Tables[0].Rows[0]["Comp_Name"].ToString();
                        string Comp_Email = dsCompanydetails.Tables[0].Rows[0]["Comp_Email"].ToString();
                        string Address = dsCompanydetails.Tables[0].Rows[0]["Address"].ToString();
                        string Contact_Person = dsCompanydetails.Tables[0].Rows[0]["Contact_Person"].ToString();
                        string Mobile_No = dsCompanydetails.Tables[0].Rows[0]["Mobile_No"].ToString();
                        string PAN_TAN = dsCompanydetails.Tables[0].Rows[0]["PAN_TAN"].ToString();
                        string ResiAddress = dsCompanydetails.Tables[0].Rows[0]["ResiAddress"].ToString();
                        string DirectorName = dsCompanydetails.Tables[0].Rows[0]["DirectorName"].ToString();
                        string DirectorFatherName = dsCompanydetails.Tables[0].Rows[0]["DirectorFatherName"].ToString();
                        string AadharNumber = dsCompanydetails.Tables[0].Rows[0]["AadharNumber"].ToString();
                        DateTime date = System.DateTime.Now;

                        DateTime tdate = date.AddYears(1);
                        string Datefrom = date.ToString("dd/MM/yyyy");
                        string TillDate = tdate.ToString("dd/MM/yyyy");
                        string DateAndTime = date.ToString("dd/MM/yyyy HH:mm");

                        DivAgreement.RenderControl(hw);
                        StringReader sr = new StringReader(sw.ToString());

                        string backgroundImagePath = @"C:\inetpub\wwwroot\httpdocs\assets\VCQRU_LETTER-HEAD.png";
                        // Read the background image as a base64-encoded string
                        string backgroundImageBase64 = Convert.ToBase64String(File.ReadAllBytes(backgroundImagePath));

                        string logoImagePath = @"C:\inetpub\wwwroot\httpdocs\Content\images\logo.png";
                        // Read the background image as a base64-encoded string
                        string logoImageBase64 = Convert.ToBase64String(File.ReadAllBytes(logoImagePath));

                        // Add the background image to the HTML content
                        //  string htmlWithBackgroundImage = @"<html><head><style>body{{background-image:url('data:image/png;base64,{" + backgroundImageBase64 + "}');background-size: contain;}} .content-container {{padding: 20px;background-color: rgba(0, 0, 0, 0.5);}}</style></head><body>" + sw.ToString() + "</body></html>";

                        string htmlWithBackgroundImage = @"<html><head><style>body{{
                    font-family: Arial, sans-serif;
                    color: white;
                }}
                .background-container {{
                    background-image: url('data:image/png;base64,backgroundImageBase64');
                    background-size: cover;
                    width: 100%;
                    height: 100%;
                    position: absolute;
                    top: 0;
                    left: 0;
                    z-index: -1;
                }}
            .header-container {{
                    text-align: center;
                    margin-top: 10px;
                }}
                .logo {{
                    height: 50px !important; /* Adjust the max-height as needed */
                }}
                .content-container {{
                    padding: 20px;
                    background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent background for better readability */
                }}</style></head><body><div class='background-container'></div><div class='header-container'>
                <img class='logo' style='height:50px'; src='data:image/png;base64,logoImageBase64' alt='Logo'>
            </div><p style='text-align:center;font-size:24px;font-weight: 800; color: #000;' class='tandc'>Terms and Conditions</p> <div class='content-container'>" + sw.ToString() + "</div></body></html>";

                        // htmlWithBackgroundImage = htmlWithBackgroundImage.Replace("<Datefrom>", Datefrom).Replace("<Dateto>", TillDate).Replace("<Duration>", "one year .").Replace("<DateandTime>", DateAndTime).Replace("<VendorName>", Comp_Name).Replace("<DirectorPanNo>", PAN_TAN).Replace("<OfficeAddress>", Address).Replace("<ResidentialAddressofDirector>", ResiAddress).Replace("<DirectorName>", DirectorName).Replace("<DirectorFatherName>", DirectorFatherName).Replace("<DirectorAadharNo>", AadharNumber);



                        DataSet dsServicedetails = SQL_DB.ExecuteDataSet("select ServiceName from M_Service where Service_ID in (select distinct Service_ID from M_ServiceSubscription where Comp_ID='" + Session["CompanyId"].ToString() + "')");

                        string ServiceName = "";
                        if (dsServicedetails.Tables[0].Rows.Count > 0)
                        {
                            DataTable dt = new DataTable();
                            dt = dsServicedetails.Tables[0];

                            foreach (DataRow row in dt.Rows)
                            {
                                string name = row["ServiceName"].ToString();
                                ServiceName = name + " ,";
                            }

                            ServiceName = ServiceName.Remove(ServiceName.Length - 1);
                        }



                        htmlWithBackgroundImage = htmlWithBackgroundImage.Replace("Servicename", ServiceName).Replace("logoImageBase64", logoImageBase64).Replace("backgroundImageBase64", backgroundImageBase64).Replace("NameofCompany", Comp_Name).Replace("Datefrom", Datefrom).Replace("Dateto", TillDate).Replace("Duration", "one year .").Replace("DateandTime", DateAndTime).Replace("VendorName", Comp_Name).Replace("DirectorPanNo", PAN_TAN).Replace("OfficeAddress", Address).Replace("ResidentialAddressofDirector", ResiAddress).Replace("DirectorName", DirectorName).Replace("DirectorFatherName", DirectorFatherName).Replace("DirectorAadharNo", AadharNumber);

                        using (var pdfDocument = PdfGenerator.GeneratePdf(htmlWithBackgroundImage, PageSize.A4))
                        {

                            pdfDocument.Save(@"C:\inetpub\wwwroot\httpdocs\assets\VendorAgreementCopy\" + Session["CompanyId"].ToString() + ".pdf");
                        }

                        string IpAddress = hdfIpaddresss.Value;
                        string DeviceDetails = hdfDeviceDetails.Value;
                        string Browser = hdfBrowser.Value;
                        string str = String.Format("https://www.vcqru.com/Info/MasterHandler.ashx?method=InsertVendorTermsCondition&Comp_Id=" + Session["CompanyId"].ToString() + "&Content=This is demo request on qa.&IPAddress=" + IpAddress + "&Browser=" + Browser + "&DeviceDetails=" + DeviceDetails + "&MacID=NA");
                        WebRequest request = WebRequest.Create(str);

                        request.Method = "POST";
                        string postData = "";
                        byte[] byteArray = Encoding.UTF8.GetBytes(postData);

                        request.ContentType = "application/x-www-form-urlencoded";//application/     x-www-form-urlencoded
                        request.ContentLength = byteArray.Length;
                        request.UseDefaultCredentials = true;
                        request.PreAuthenticate = true;
                        request.Credentials = CredentialCache.DefaultCredentials;

                        Stream dataStream = request.GetRequestStream();
                        dataStream.Write(byteArray, 0, byteArray.Length);
                        dataStream.Close();
                        WebResponse response = request.GetResponse();
                        Console.WriteLine(((HttpWebResponse)response).StatusDescription);
                        dataStream = response.GetResponseStream();
                        StreamReader reader = new StreamReader(dataStream);
                        string responseFromServer = reader.ReadToEnd();
                        Console.WriteLine(responseFromServer);
                        reader.Close();
                        dataStream.Close();

                    }




                }
            }




        }
        catch (Exception ex)
        {

        }

    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }
}
