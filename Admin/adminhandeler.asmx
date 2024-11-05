 <%@ WebService Language="C#" Class="adminhandeler" %>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data;
using System.Web.Script.Serialization;
using System.Security.Cryptography;
using Business9420;
using System.Data.SqlClient;
using DataProvider;
using System.Text;
using System.IO;
using System.Web.UI;
using ComponentArt.Web.UI;
using System.Xml;
using System.Drawing;
using ZXing.Common;
using ZXing;
using ZXing.QrCode;


/// <summary>
/// Summary description for adminhandeler
/// </summary>
[WebService(Namespace = "http://localhost:6331/")]
//[WebService(Namespace = ProjectSession.absoluteSiteBrowseUrl.ToString())]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]

public class adminhandeler : System.Web.Services.WebService
{
    QrCodeEncodingOptions options = new QrCodeEncodingOptions();
    public DataTable CodeTableInfo;
    // System.Timers.Timer testTimer = new System.Timers.Timer();
    public adminhandeler()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String bindpayment()
    {
        String daresult = null;
        DataTable dt = new DataTable();
        string StrAll = "Flag=0"; string Comp_ID = "";
        if (Session["User_Type"] != null)
        {
            if (Session["User_Type"].ToString() == "Admin")
                Comp_ID = "";
            else
                Comp_ID = HttpContext.Current.Session["CompanyId"].ToString();
            DataSet ds = Business9420.function9420.FillDataGridPaymentRequest(StrAll, Comp_ID);
            daresult = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        }
        return daresult;
    }
    [WebMethod(EnableSession = true)]
    public String bindintrusted()
    {
        String daresult = null;
        DataSet ds = new DataSet();
        string Qty = "SELECT Row_ID as id, Comp_Name as cname, Comp_Email as cemail, Contact_Person as cpersob, Mobile_No as cmobile, Reg_Date as cdate , case when Status = 0 then 'Not View & Contact'  when Status = 1 then 'Already View & Contact' else 'Cancelled' end ReqStFlag, Status, Contact_Flag FROM Interested_Demo WHERE Status = 0 ";
        SQL_DB.GetDA(Qty).Fill(ds, "1");
        daresult = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return daresult;
    }

    [WebMethod(EnableSession = true)]
    public string actionintrusted(string id, string action)
    {
        string result = "";
        if (action == "IntReqAccept")
        {
            SQL_DB.ExecuteNonQuery("UPDATE  Interested_Demo SET Status = 1 WHERE Row_ID = '" + id + "'  ");
            result = "IntReqAccept";
        }
        else if (action == "IntReqCancel")
        {
            SQL_DB.ExecuteNonQuery("UPDATE  Interested_Demo SET Status = -1 WHERE Row_ID = '" + id + "'  ");
            result = "IntReqCancel";
        }
        return result;
    }
    public string DataTableToJSONWithJavaScriptSerializer(DataTable table)
    {
        JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
        List<Dictionary<string, object>> parentRow = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRow;
        foreach (DataRow row in table.Rows)
        {
            childRow = new Dictionary<string, object>();
            foreach (DataColumn col in table.Columns)
            {

                childRow.Add(col.ColumnName, row[col]);
            }
            parentRow.Add(childRow);
        }
        return jsSerializer.Serialize(parentRow);
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string logout()
    {
        string result = "0";
        string IP = GetIP();
        if (Session["User_Type"].ToString() == "Admin")
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Login_History] SET [Logout_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE CONVERT(VARCHAR,Login_Date,111)= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' AND User_ID = '" + Session["User_Type"].ToString() + "'  AND user_Type = 1 AND (Dial_Mode = '" + IP + "')  AND Row_ID = (SELECT MAX(Row_ID) FROM  Login_History WHERE  User_ID = '" + Session["User_Type"].ToString() + "'  AND (Dial_Mode = '" + IP + "') ) ");
            Session.Abandon();
            result = "1";
            //HttpContext.Current.Response.Redirect("Login.aspx");
        }
        else
        {
            SQL_DB.ExecuteNonQuery("UPDATE [Login_History] SET [Logout_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE CONVERT(VARCHAR,Login_Date,111)= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "' AND User_ID = '" + Session["CompanyId"].ToString() + "'  AND user_Type = 0 AND (Dial_Mode = '" + IP + "')  AND Row_ID = (SELECT MAX(Row_ID) FROM  Login_History WHERE  User_ID = '" + Session["CompanyId"].ToString() + "'  AND (Dial_Mode = '" + IP + "') ) ");
            Session.Abandon();
            result = "2";
            //HttpContext.Current.Response.Redirect("Index.aspx");
        }
        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String Productmaster()
    {
        String daresult = null;
        DataSet ds = new DataSet();
        string Qty = "SELECT * from ( SELECT Comp_ID as Comp_ID, Comp_Name as Comp_Name, (SELECT Cat_Name FROM M_Category WHERE Cat_Id=Comp_Reg.Comp_Cat_Id ) as Comp_Type, Comp_Email as Comp_Email, WebSite as WebSite, Address as Address, (SELECT Country_Name FROM M_Country WHERE Country_ID=Comp_Reg.City_ID) AS Country_Name, Contact_Person as Contact_Person, Mobile_No as Mobile_No, Phone_No as Phone_No, Fax as Fax, Reg_Date as Reg_Date, Password as Password, Status as Status, " +
            " case when Comp_Type = 'L' then (case when isnull((select Row_ID from Comp_Document where  Comp_ID = Comp_Reg.Comp_ID),0)  = 0 then 'No' else  convert(varchar, (case when isnull((select count(*) from Comp_Doc_Flag where Comp_ID = Comp_Reg.Comp_ID and Flag = 1),0) = 0 then (case when Status = 0 then 'No' else 'ENo' end) else (case when Status = 0 then 'No' else 'EYes' end) end) )end) else (case when Status = 0 then 'No' else 'ENo' end) end as Doo, " +
            " (case when isnull((select Row_ID from Comp_Document where  Comp_ID = Comp_Reg.Comp_ID),0)  = 0 then 'No' else  convert(varchar, (case when isnull((select count(*) from Comp_Doc_Flag where Comp_ID = Comp_Reg.Comp_ID),0) < 7  then 'No' when isnull((select count(*) from Comp_Doc_Flag where Comp_ID = Comp_Reg.Comp_ID),0) = 7  then 'ENo' else 'EYes' end) ) end )as D, " +
            " (case when isnull((select Row_ID from Comp_Document where  Comp_ID = Comp_Reg.Comp_ID),0)  = 0 then 'No' else  convert(varchar, (case when isnull((select count(*) from Comp_Doc_Flag where Comp_ID = Comp_Reg.Comp_ID and Flag = 1),0) = 0 then 'No' else 'Yes' end) )end)as Cnt, " +
        " Email_Vari_Flag as Email_Vari_Flag, Update_Flag as Update_Flag,(case when Comp_Type = 'D' then 1 else isnull((SELECT top(1) Flag FROM Comp_Doc_Flag WHERE (Comp_ID = Comp_Reg.Comp_ID) GROUP BY Comp_ID, Flag ORDER BY Flag),0)end) as Doc_Flag,'Sound/' + SUBSTRING(Comp_ID, 6, 4) + '/' + SUBSTRING(Comp_ID, 6, 4) + '.mp3' AS SoundPath,Comp_Type as TypeCmp " +
        " FROM Comp_Reg ) Reg where Reg.Doo = 'No' ORDER BY Reg_Date DESC --AND Reg.TypeCmp = 'L' ";
        SQL_DB.GetDA(Qty).Fill(ds, "1");
        daresult = DataTableToJSONWithJavaProductmaster(ds.Tables[0]);
        return daresult;

    }

    public string DataTableToJSONWithJavaProductmaster(DataTable table)
    {
        JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
        List<Dictionary<string, object>> parentRow = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRow;
        string FPath = Server.MapPath("../Data/Data/");
        foreach (DataRow row in table.Rows)
        {
            childRow = new Dictionary<string, object>();
            foreach (DataColumn col in table.Columns)
            {
                if (col.ColumnName == "SoundPath")
                {
                    if (System.IO.File.Exists(FPath + row[col].ToString().Replace("/", "\\")))
                    {
                        //childRow.Add(col.ColumnName, (FPath + row[col].ToString().Replace("/", "\\")));
                        childRow.Add(col.ColumnName, (row[col].ToString().Replace("/", "\\")));
                    }
                    else
                    {
                        childRow.Add(col.ColumnName, "0");
                    }
                }
                else
                {
                    childRow.Add(col.ColumnName, row[col]);
                }

            }
            parentRow.Add(childRow);
        }
        return jsSerializer.Serialize(parentRow);
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String RequestCancel2(string id, string proid, string noofcode, string request_Amout, string compID, string action, string proname, string compname, string labeltype, string Request_No, string contactPerson)
    {
        Object9420 Reg = new Object9420();
        Reg.Row_ID = id;
        Reg.Comp_ID = compID;
        DataSet dsl1 = function9420.GetCurrentLabelInfo(Reg);
        string HiddenTrackingNoValue = dsl1.Tables[0].Rows[0]["Tracking_No"].ToString();
        string Pro_name = dsl1.Tables[0].Rows[0]["Pro_Name"].ToString();
        string qty = noofcode;// dsl1.Tables[0].Rows[0]["qty"].ToString();
        string Label_Name = dsl1.Tables[0].Rows[0]["Label_Name"].ToString();
        Reg.Comp_Email = dsl1.Tables[0].Rows[0]["Comp_Email"].ToString();
        SQL_DB.ExecuteNonQuery("UPDATE [M_Label_Request] SET [Flag] = -1 WHERE Row_ID = " + Reg.Row_ID);
        #region MailBody
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
           " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
           " <hr style='border:1px solid #2587D5;'/>" +
           " <div class='w_frame'>" +
           " <p>" +
           " <div class='w_detail'>" +
           " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
           " <br />" +
           " <span>Your label print request is rejected. Please Contact Admin. </span>" +
           " following details below: -" +
           " <p>" +
           " <table border='0' cellspacing='2'>" +
           " <tr>" +
           " <td width='50%' align='left' ><strong>Product Name : </strong></td>" +
           " <td width='50%' align='left' ><strong>" + Pro_name + "</strong></td>" +
           " </tr>" +
           " <tr>" +
           " <td width='50%' align='left' ><strong>No of labels : </strong></td>" +
           " <td width='50%' align='left' ><strong>" + qty + "</strong></td>" +
           " </tr>" +
           " <tr>" +
           " <td width='50%' align='left' ><strong>Labels request ID : </strong></td>" +
           " <td width='50%' align='left' ><strong>" + HiddenTrackingNoValue + "</strong></td>" +
           " </tr>" +
           //" <tr>" +
           //" <td width='50%' align='left' ><strong>Reason : </strong></td>" +
           //" <td width='50%' align='left' ><strong>" + HiddenTrackingNo.Value + "</strong></td>" +
           //" </tr>" +
           " </table>" +
           " <div class='w_detail'>" +
           " Assuring you  of  our best services always.<br />" +
           " Thank you,<br /><br />" +
           " Team <em><strong>VCQRU.COM,</strong></em><br />" +
           "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
           " </div>" +
           " </p>" +
           " </div>" +
           " </p>" +
           " </div> " +
           " </div> ";
        string MBofy = " <br/> following details below: -" +
           " <p>" +
           " <table border='0' cellspacing='2'>" +
           " <tr>" +
           " <td width='50%' align='left' ><strong>Product Name : </strong></td>" +
           " <td width='50%' align='left' ><strong>" + Pro_name + "</strong></td>" +
           " </tr>" +
           " <tr>" +
           " <td width='50%' align='left' ><strong>No of labels : </strong></td>" +
           " <td width='50%' align='left' ><strong>" + qty + "</strong></td>" +
           " </tr>" +
           " <tr>" +
           " <td width='50%' align='left' ><strong>Labels request ID : </strong></td>" +
           " <td width='50%' align='left' ><strong>" + HiddenTrackingNoValue + "</strong></td>" +
           " </tr>" +
           " </table>";
        string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Sales department", "Product requested labels has been print successfully." + MBofy);
        string MailBody2 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Print department", "Product requested labels has been print successfully." + MBofy);
        string MailBody3 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Account department", "Product requested labels has been print successfully." + MBofy);
        string MailBody4 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "IT department", "Product requested labels has been print successfully." + MBofy);
        #endregion
        DataSet dsMl = function9420.FetchMailDetail("admin");
        if (dsMl.Tables[0].Rows.Count > 0)
        {
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Label request print");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Print Labels");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.print_accomplishtrades, MailBody2, "Print Labels");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Print Labels");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Print Labels");
        }
        return qty + " labels canceled successfully <span style='color:blue;' > " + compID + "  </span>  >> " + Pro_name + " >> " + Label_Name;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String working()
    {
        String daresult = null;
        DataSet ds = new DataSet();
        string Qty = "SELECT * FROM (SELECT  Status as Status , Comp_ID as Comp_ID, Comp_Name as Comp_Name,Contact_Person as Contact_Person, Reg_Date as Reg_Date, Comp_Email as Comp_Email, Mobile_No as Mobile_No,Comp_Type as Comp_Type ,(SELECT     ISNULL(COUNT(Pro_ID), 0) FROM  Pro_Reg WHERE (Comp_ID = Comp_Reg.Comp_ID)) as P,  " +
            " Isnull((SELECT top(1) Doc_Flag FROM  Pro_Reg WHERE (Comp_ID = Comp_Reg.Comp_ID) ORDER BY (CASE  WHEN ((Sound_Flag = 1) AND (Doc_Flag = 1)) THEN 10 WHEN ((Sound_Flag = 1) AND (Doc_Flag = 0)) THEN 9 WHEN ((Sound_Flag = 1) AND (Doc_Flag = -1)) THEN 7 WHEN ((Sound_Flag = 0) AND (Doc_Flag = 1)) THEN 8 WHEN ((Sound_Flag = -1) AND (Doc_Flag = 1)) THEN 5 WHEN ((Sound_Flag = -1) AND (Doc_Flag = -1)) THEN 4 WHEN ((Sound_Flag = -1) AND (Doc_Flag = 0)) THEN 3 WHEN ((Sound_Flag = 0) AND (Doc_Flag = -1)) THEN 6 ELSE  2  END) DESC  ),0) as Doc_Flag , " +
            " Isnull((SELECT top(1) Sound_Flag FROM  Pro_Reg WHERE (Comp_ID = Comp_Reg.Comp_ID) ORDER BY (CASE  WHEN ((Sound_Flag = 1) AND (Doc_Flag = 1)) THEN 10 WHEN ((Sound_Flag = 1) AND (Doc_Flag = 0)) THEN 9 WHEN ((Sound_Flag = 1) AND (Doc_Flag = -1)) THEN 7 WHEN ((Sound_Flag = 0) AND (Doc_Flag = 1)) THEN 8 WHEN ((Sound_Flag = -1) AND (Doc_Flag = 1)) THEN 5 WHEN ((Sound_Flag = -1) AND (Doc_Flag = -1)) THEN 4 WHEN ((Sound_Flag = -1) AND (Doc_Flag = 0)) THEN 3 WHEN ((Sound_Flag = 0) AND (Doc_Flag = -1)) THEN 6 ELSE  2  END) DESC  ),0) as Sound_Flag  " +
            " ,ISNULL((SELECT  TOP(1) (CASE WHEN Flag = 1 THEN 1  WHEN Flag = 0 THEN 2 WHEN Flag = -1 THEN 3 ELSE 4 END) AS Cnt FROM  M_Label_Request WHERE Pro_ID IN (SELECT Pro_ID FROM Pro_Reg where Comp_ID = Comp_Reg.Comp_ID)  ORDER BY Flag DESC),4) as R " +
            " FROM  Comp_Reg WHERE Status = 1) Reg  WHERE R <> 1 ORDER BY  Reg_Date DESC";
        SQL_DB.GetDA(Qty).Fill(ds, "1");
        daresult = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return daresult;

    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String uploadimg()
    {
        string result = "";

        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String legaldocument()
    {
        Object9420 Reg = new Object9420();
        String daresult = null;
        if (Session["User_Type"].ToString() == "Admin")
            Reg.Comp_ID = "";
        else
            Reg.Comp_ID = Session["CompanyId"].ToString();
        DataSet ds = function9420.FillGrdProDoc(Reg);
        daresult = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return daresult;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string savetaxsetting(string proid, string productname, string compid, string compname, string ltax, string lvat, string stax, string svat)
    {
        string result = "";
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = compid;
        Reg.Pro_ID = proid;
        Reg.DateFrom = Convert.ToDateTime(Convert.ToDateTime("01/04/" + DataProvider.LocalDateTime.Now.Year).ToString("yyyy/MM/dd"));
        Reg.DateTo = Reg.DateFrom.AddYears(1);
        Reg.DateTo = Reg.DateTo.AddDays(-1);
        Reg.Entry_Date = Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt"));
        Reg.AMC_ServiceTax = Convert.ToDouble(stax);
        Reg.AMC_Vat = Convert.ToDouble(svat);
        Reg.Label_ServiceTax = Convert.ToDouble(ltax);
        Reg.Label_Vat = Convert.ToDouble(lvat);
        Reg.Offer_ServiceTax = Convert.ToDouble(0);
        Reg.Offer_Vat = Convert.ToDouble(0);
        Reg.Row_ID = "";
        Reg.TaxSet_ID = "";// Business9420.function9420.GetLabelCode("TaxSetting"); changed by shweta
        Reg.DML = "I";
        Business9420.function9420.TaxMasterSetting(Reg);
        //  Business9420.function9420.UpdateLabelCode("TaxSetting");
        return result = "Tax Setting <span style='color:blue;'>" + compname + "</span> >> <span style='color:blue;'>" + productname + "</span>  has been saved.";
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String taxdata(string id, string compid)
    {
        String daresult = null;
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT Comp_Reg.Comp_ID, Comp_Reg.Comp_Name, Category_Master.Category_Name, Pro_Reg.Dispatch_Location " +
           " FROM         Comp_Reg INNER JOIN Category_Master ON Comp_Reg.Comp_Cat_Id = Category_Master.Category_ID INNER JOIN Pro_Reg ON Comp_Reg.Comp_ID = Pro_Reg.Comp_ID  WHERE Comp_Reg.Comp_ID = '" + compid + "' AND Pro_Reg.Pro_ID = '" + id + "'  ");
        daresult = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return daresult;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String RequestedLabels()
    {
        String daresult = null;
        DataSet ds = new DataSet();
        Object9420 obj = new Object9420();
        if (Session["User_Type"].ToString() == "Admin")
        {
            obj.Comp_ID = "";
            obj.Status = 0;
        }
        else
        {
            obj.Comp_ID = Session["CompanyId"].ToString();
            obj.Status = 1;
        }
        ds = function9420.FillGrdLabelsRequested(obj);
        daresult = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return daresult;
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String LabelsRecord()
    {
        String daresult = null;
        Object9420 Reg = new Object9420();
        if (Session["User_Type"].ToString() == "Admin")
            Reg.Comp_ID = "";
        else
            Reg.Comp_ID = Session["CompanyId"].ToString();
        DateTime D1 = Convert.ToDateTime(DataProvider.LocalDateTime.Now);
        D1 = D1.AddDays(-10);
        Reg.Msg = " AND (CONVERT(VARCHAR,Entry_Date,111) <= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "') AND (CONVERT(VARCHAR,Entry_Date,111) >= '" + Convert.ToDateTime(D1).ToString("yyyy/MM/dd") + "')";
        DataSet ds = function9420.FillGrdMainLabelDispatchDataDashBoard(Reg);
        daresult = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return daresult;
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public String dispachLabelsRecord()
    {
        String daresult = null;
        Object9420 Reg = new Object9420();
        if (Session["User_Type"].ToString() == "Admin")
            Reg.Comp_ID = "";
        else
            Reg.Comp_ID = Session["CompanyId"].ToString();
        DateTime D1 = Convert.ToDateTime(DataProvider.LocalDateTime.Now);
        D1 = D1.AddDays(-10);
        Reg.Msg = " AND (CONVERT(VARCHAR,Entry_Date,111) <= '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "') AND (CONVERT(VARCHAR,Entry_Date,111) >= '" + Convert.ToDateTime(D1).ToString("yyyy/MM/dd") + "')";
        DataSet ds = function9420.FillGrdMainLabelDispatchDataDashBoard(Reg);
        daresult = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return daresult;
    }
    private string GetIP()
    {
        string Ipaddress;
        Ipaddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (Ipaddress == "" || Ipaddress == null)
        {
            Ipaddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }
        return Ipaddress;
    }
    #region Create Virtual table
    private DataTable CreateFileDataTable()
    {
        DataTable myDataTable = new DataTable();
        DataColumn myDataColumn;
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Print_Date";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Allot_Date";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Pro_ID";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Use_Type";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Print_Status";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Series_Order";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Series_Serial";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "LabelRequestId";
        myDataTable.Columns.Add(myDataColumn); ;
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Code1";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.Int64");
        myDataColumn.ColumnName = "Code2";
        myDataTable.Columns.Add(myDataColumn);


        return myDataTable;
    }
    private void AddCodelInfo(string Pro_ID, string Use_Type, string Series_Order, string Series_Serial, string LabelRequestId, string Code1, string Code2, DataTable myTable)
    {
        try
        {
            string Print_Status = "1";
            string dt = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt");
            string Print_Date = dt; string Allot_Date = dt;
            DataRow row;
            row = myTable.NewRow();
            row["Print_Date"] = Print_Date;
            row["Allot_Date"] = Allot_Date;
            row["Pro_ID"] = Pro_ID;
            row["Use_Type"] = Use_Type;
            row["Print_Status"] = Print_Status;
            row["Series_Order"] = Series_Order;
            row["Series_Serial"] = Series_Serial;
            row["LabelRequestId"] = LabelRequestId;
            row["Code1"] = Code1;
            row["Code2"] = Code2;

            myTable.Rows.Add(row);

            Session["DemoTable"] = myTable;
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    private void SaveLabelInfo1(DataTable dt, int noofrows)
    {
        XmlDocument xmldoc = new XmlDocument();
        XmlElement xmlrootelement = xmldoc.CreateElement("Tab");
        xmldoc.AppendChild(xmlrootelement);

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            //   if (lstProfileItemId.Split(',')[i].Length > 0)
            {
                XmlElement child = xmldoc.CreateElement("id");
                child.SetAttribute("Series_Order", dt.Rows[i]["Series_Order"].ToString());
                child.SetAttribute("Series_Serial", dt.Rows[i]["Series_Serial"].ToString());
                child.SetAttribute("Code1", dt.Rows[i]["Code1"].ToString());
                child.SetAttribute("Code2", dt.Rows[i]["Code2"].ToString());
                child.SetAttribute("index", (i + 1).ToString());
                xmlrootelement.AppendChild(child);
            }

        }

        string xmlLibraryList = xmldoc.OuterXml;
        DateTime print_date = Convert.ToDateTime(DataProvider.LocalDateTime.Now);//.ToString("yyyy/MM/dd hh:mm:ss tt");
        DataSet ds = ExecuteNonQueryAndDatatable.InsertPrintLabels(noofrows, dt.Rows[0]["Pro_ID"].ToString(), print_date, dt.Rows[0]["Use_Type"].ToString(),
              dt.Rows[0]["LabelRequestId"].ToString(), xmlLibraryList);
        //  if (lstProfileItemId.Split(',').Length >= 1)
        //   {
        //       objTabProfileItemBAL.Insert(xmlLibraryList);
        //    }
    }
    private void SaveLabelInfo(DataTable dt)
    {
        SQL_DB.ExecuteNonQuery("TRUNCATE TABLE Temp_PrintLabels");
        SqlConnection conn = dtcon.CreateConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.Open();
        if (((DataTable)Session["DemoTable"]).Rows.Count > 0)
        {
            using (SqlBulkCopy bulkCopy = new SqlBulkCopy(conn))
            {
                bulkCopy.DestinationTableName = "Temp_PrintLabels";

                try
                {
                    // Write from the source to the destination.
                    bulkCopy.BulkCopyTimeout = 0;
                    bulkCopy.WriteToServer(dt);
                    Session["DemoTable"] = null;
                    CodeTableInfo = CreateFileDataTable();
                    Session["DemoTable"] = CodeTableInfo;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
        string str = "Insert Complete";
        try
        {
            //Business9420.function9420.PrintCodes();
            SQL_DB.ExecuteNonQuery("UPDATE MC  " +
            " SET MC.Print_Date=TPL.Print_Date,  " +
             " MC.Allot_Date=TPL.Allot_Date,  " +
             " MC.Pro_ID=TPL.Pro_ID,  " +
             " MC.Use_Type=TPL.Use_Type,  " +
             " MC.Print_Status=TPL.Print_Status,  " +
             " MC.Series_Order=TPL.Series_Order,  " +
             " MC.Series_Serial=TPL.Series_Serial,  " +
             " MC.LabelRequestId =TPL.LabelRequestId  " +
            " FROM M_Code MC   " +
            " INNER JOIN Temp_PrintLabels TPL  " +
              " ON MC.Code1=TPL.CODE1 AND mc.Code2=TPL.code2");
        }
        catch (Exception ex)
        {
            LogManager.WriteExe("Code not mapped between temp and M_Code : Error " + ex.Message.ToString());
        }
    }
    #endregion

    public string srt = DataProvider.Utility.FindMailBody();

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string Upgradeaccount()
    {
        string result = "";
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        Business9420.function9420.FillUpDateProfile(Reg);
        string path = "";
        path = Server.MapPath("../Data/Sound");
        path = path + "\\" + Reg.Comp_ID.ToString().Substring(5, 4);
        DataProvider.Utility.DeleteDirectoryDemo(path);
        Business9420.function9420.UpgradeAcc(Reg);
        #region MailBody
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
           //   " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
           " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
           " <hr style='border:1px solid #2587D5;'/>" +
           " <div class='w_frame'>" +
           " <p>" +
           " <div class='w_detail'>" +
           " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
           " <br />" +
           " <span>Your company upgradation demo to Licence has been upgrade successfully. </span><br/><br/><br/>" +
           " <span>Kindly sign in with existing user name and password. </span><br/><br/><br/>" +
           " <span>After conversion to licence version, The Demo Print Labels given to you earlier are no longer valid. Please do not paste them now on products.  </span><br/><br/><br/>" +
           " <div class='w_detail'>" +
           " Assuring you  of  our best services always.<br />" +
           " Thank you,<br /><br />" +
           " Team <em><strong>VCQRU.COM,</strong></em><br />" +
           "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
           " </div>" +
           " </p>" +
           " </div>" +
           " </p>" +
           " </div> " +
           " </div> ";
        string MBofy = " <p>" +
           " <table border='0' cellspacing='2'>" +
           " <tr ><td colspan='2' ><strong>Comapny Details : - </strong></td> </tr>" +
           " <tr>" +
           " <td width='50%' align='left' ><strong>Company Name : </strong></td>" +
           " <td width='50%' align='left' >" + Reg.Comp_Name + "</td>" +
           " </tr>" +
           " <tr>" +
           " <td width='50%' align='left' ><strong>Contact Person : </strong></td>" +
           " <td width='50%' align='left' >" + Reg.Contact_Person + "</td>" +
           " </tr>" +
            " <tr>" +
           " <td width='50%' align='left' ><strong>Mobile No : </strong></td>" +
           " <td width='50%' align='left' >" + Reg.Mobile_No + "</td>" +
           " </tr>" +
            " <tr>" +
           " <td width='50%' align='left' ><strong>Email ID : -</strong></td>" +
           " <td width='50%' align='left' >" + Reg.Comp_Email + "</td>" +
           " </tr>" +
            " <tr>" +
           " <td width='50%' align='left' ><strong>Address : </strong></td>" +
           " <td width='50%' align='left' >" + Reg.Address + "</td>" +
           " </tr>" +
           " </table>";
        string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Admin department", "Company upgradation demo to Licence has been upgrade successfully.<br/>" + MBofy);
        #endregion
        DataSet dsMl1 = function9420.FetchMailDetail("register");
        if (dsMl1.Tables[0].Rows.Count > 0)
            DataProvider.Utility.sendMail(dsMl1.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl1.Tables[0].Rows[0]["User_Id"].ToString(), dsMl1.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.admin_accomplishtrades, MailBody1, "Company upgradation");
        DataSet dsMl = function9420.FetchMailDetail("admin");
        if (dsMl.Tables[0].Rows.Count > 0)
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Company upgrade Confirmation");
        Session.Abandon();
        result = "yes";
        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string paymentverify(string id, string compid, string payprice, string requiredpayment)
    {
        string result = "";
        Object9420 Reg = new Object9420();
        Reg.User_Type = Session["User_Type"].ToString();
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt"));
        Reg.Comp_ID = compid; // Comp_ID from Payment Received
        Reg.Row_ID = id; // Row_Id from Payment Received
        Reg.Flag = 0;
        function9420.FindDetailsForRequestPayment(Reg);

        #region Code For Account
        double payAmt = 0.0;
        Reg.ManuReq_Payment = Convert.ToDouble(requiredpayment);
        Reg.Admin_Remark = null;// ddlpay.SelectedValue.ToString();// txtAmtremarks.Text;
        if (Reg.Admin_Remark == "Block")
            Reg.Status = 0;
        else if (Reg.Admin_Remark == "Continue")
            Reg.Status = 1;
        if (payprice != "")
            Reg.TRec_Payment = Convert.ToDouble(payprice);
        else
            Reg.TRec_Payment = 0.00;
        payAmt += Convert.ToDouble(Reg.TRec_Payment);
        //}
        if (payAmt > 0.00)
        {
            Reg.Row_ID = id; // Row_Id from Payment Received where action applied
            Reg.Rec_Payment = payAmt;
            Reg.Flag = 1;
            if (payAmt == Convert.ToDouble(requiredpayment))
                Reg.Admin_Remark = "Verified all requested amount";
            else
                Reg.Admin_Remark = "Verified Less amount in requested amount";
            function9420.UpdateReceivedPayment(Reg);  // Update Payment_Received Table Data 
                                                      //************ Receipt Report Code Start ***************//
            Reg.FolderPath = Server.MapPath("../Data/Bill");
            Reg.Path = Server.MapPath("../Reports") + "\\PaymentReceipt.rpt";
            //GenerateCrystalInvoice.Receipt.showReport(Reg);
            //************ Receipt Report Code End ***************//
        }
        #endregion
        //function9420.Generate_InvoiceAmcOffer(Reg);
        function9420.FillUpDateProfile(Reg);
        result = "Verified all requested amount";
        return result;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string rejectpayment(string id, string compid, string remark)
    {
        string result = "";
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = compid; // Comp_ID from Payment Received
        Reg.Row_ID = id; // Row_Id from Payment Received
        Reg.TransRow_ID = id;
        Reg.User_Type = Session["User_Type"].ToString();
        Reg.Admin_Remarks = remark.Trim().Replace("'", "''");
        Reg.Flag = 0;
        function9420.FindDetailsForRequestPayment(Reg);
        if (Session["User_Type"].ToString() == "Admin")
            Reg.Flag = -1;
        else
            Reg.Flag = 2;
        //function9420.CanceledRequest(Reg); // Old Function for checking
        function9420.CanceledPaymentRequest(Reg);
        function9420.FillUpDateProfile(Reg);
        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string actionmethod(string id, string proid, string noofcode, string request_Amout, string compID, string action, string proname, string compname,
        string labeltype, string Request_No, string contactPerson, string PrintLabelOrQrcode)
    {


        string result = "<span style='color:blue'>Not </span> " + action + " !";
        // return result;
        //   MyClassPrintLabels.PrintLabels();
        string trackingcode = "";
        //   LogManager.WriteExe("Enter Yes Button Click");// for tem commented
        Object9420 Reg = new Object9420();
        if (id != "no")
        {
            Reg.Row_ID = id;
        }
        Reg.Pro_ID = proid;
        if (Request_No != "no")
        {
            Reg.Request_No = Request_No;
        }
        if (request_Amout != "no")
        {
            Reg.ManuReq_Payment = Convert.ToDouble(request_Amout);
        }
        if (noofcode != "no")
            Reg.Qty = Convert.ToInt32(noofcode);
        else
            Reg.Qty = 0;
        if (request_Amout != "no")
            Reg.Label_Prise = Convert.ToDouble(request_Amout);
        else
            Reg.Label_Prise = 0.00;
        Reg.Comp_ID = compID;
        if (action == "PrintLabels")
        {
            if (ExecuteNonQueryAndDatatable.Is_DispatchPending(proid))
            {
                result = "<span style='color:red'>Please dispatch the labels first. After dispatching labels you can print more labels.</span>. Go to the <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Admin/FrmCourierDispatch.aspx'><u><b>Courier Dispatch</b></u></a>.";
                return result;
            }
            //LogManager.WriteExe("Enter Yes Button Click for PrintLabels functionality!");
            DataSet dsl = function9420.GetCurrentLabelInfo(Reg);
            trackingcode = dsl.Tables[0].Rows[0]["Tracking_No"].ToString(); //SQL_DB.ExecuteScalar("SELECT Tracking_No FROM  M_Label_Request where  Row_ID='" + Reg.Row_ID + "'").ToString();
            Reg.Trans_Type = "Label";
            try
            {
                string strIsCodeAvailable = string.Empty;
                Int64 PrintCount = 0;
                DataTable dt = SQL_DB.ExecuteDataTable("SELECT COUNT(Row_ID) as Cnt FROM M_Code with (nolock) WHERE ISNULL(Print_Status,'') <> '' AND ISNULL(Print_Date,'') <> '' AND LabelRequestId ='" + trackingcode + "'");
                if (Reg.Comp_ID == "Comp-1693")
                    dt = SQL_DB.ExecuteDataTable("SELECT COUNT(Row_ID) as Cnt FROM M_Code_PFL with (nolock) WHERE ISNULL(Print_Status,'') <> '' AND ISNULL(Print_Date,'') <> '' AND LabelRequestId ='" + trackingcode + "'");
                if (dt.Rows.Count > 0) //7600
                {

                    PrintCount = Convert.ToInt64(dt.Rows[0]["Cnt"]);
                    if (PrintCount == 0)
                    {
                        strIsCodeAvailable = AllocateAndPrint(noofcode, proid, compID, trackingcode, PrintLabelOrQrcode);
                    }
                    else
                    {
                        Int64 PendingLaels = Convert.ToInt64(noofcode) - Convert.ToInt64(PrintCount);
                        strIsCodeAvailable = AllocateAndPrint(PendingLaels.ToString(), proid, compID, trackingcode, PrintLabelOrQrcode);//hdNoofCodes.Value
                    }
                }
                if (strIsCodeAvailable == "NoCodeAvailable")
                {
                    result = "<span style='color:red'>Not sufficient code to print LABELS</span>. Kindly first generate the CODES <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Admin/CodeGeneration.aspx'><u><b>Generate Code</b></u></a> and then proceed further to print labels.";
                    return result;
                }
            }
            catch (Exception ex)
            {
                LogManager.WriteExe("Error Find in Code Label Print functionality! Error is " + ex.Message.ToString());
            }

            //  LogManager.WriteExe("Before updte M_Label_Request!");
            double CurrLabelPrice = Convert.ToDouble(dsl.Tables[0].Rows[0]["Price"]);
            SQL_DB.ExecuteNonQuery("UPDATE [M_Label_Request] SET [Flag] = 1,[Price] = '" + CurrLabelPrice + "' WHERE Row_ID = " + Reg.Row_ID);
            //    LogManager.WriteExe("After updte M_Label_Request!");
            function9420.Generate_Invoice(Reg);
            // function9420.Invoice(Reg);

            //Generate Invoice PDF by shweta
            //  PDFCLass.GeneratePDF(Reg);

            Business9420.function9420.FillUpDateProfile(Reg);
            #region MailBody
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
             //  " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
             " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
               " <hr style='border:1px solid #2587D5;'/>" +
               " <div class='w_frame'>" +
               " <p>" +
               " <div class='w_detail'>" +
               " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
               " <br />" +
               " <span>Your label print request accepted and labels printed successfully. </span>" +
               " following details below: -" +
               " <p>" +
               " <table border='0' cellspacing='2'>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>Product Name : </strong></td>" +
               " <td width='50%' align='left' ><strong>" + proname + "</strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>No of labels : </strong></td>" +
               " <td width='50%' align='left' ><strong>" + noofcode + "</strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>Labels request ID : </strong></td>" +
               " <td width='50%' align='left' ><strong>" + trackingcode + "</strong></td>" +
               " </tr>" +
               " </table>" +
               " <div class='w_detail'>" +
               " Assuring you  of  our best services always.<br />" +
               " Thank you,<br /><br />" +
               " Team <em><strong>VCQRU.COM,</strong></em><br />" +
               "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
               " </div>" +
               " </p>" +
               " </div>" +
               " </p>" +
               " </div> " +
               " </div> ";
            string MBofy = " <br/> following details below: -" +
               " <p>" +
               " <table border='0' cellspacing='2'>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>Product</strong></td>" +
               " <td width='50%' align='left' ><strong>" + proname + "</strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>No of labels</strong></td>" +
               " <td width='50%' align='left' ><strong>" + noofcode + "</strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='50%' align='left' ><strong>Labels request ID : </strong></td>" +
               " <td width='50%' align='left' ><strong>" + trackingcode + "</strong></td>" +
               " </tr>" +
               " </table>";
            string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, ProjectSession.sales_accomplishtrades, "Product requested labels has been print successfully." + MBofy);
            string MailBody2 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, ProjectSession.print_accomplishtrades, "Product requested labels has been print successfully." + MBofy);
            string MailBody3 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, ProjectSession.Finance_accomplishtrades, "Product requested labels has been print successfully." + MBofy);
            string MailBody4 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, ProjectSession.it_accomplishtrades, "Product requested labels has been print successfully." + MBofy);
            #endregion
            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Label request print");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Print Labels");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.print_accomplishtrades, MailBody2, "Print Labels");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Print Labels");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Print Labels");
            }
            result = noofcode + " labels printed successfully <span style='color:blue;' > " + compname + "  </span>  >> " + proname + " >> " + labeltype + ".\n Go to the <a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Admin/FrmCourierDispatch.aspx'><u><b>Courier Dispatch</b></u></a>";

        }
        else if (action == "RequestCancel")
        {
            DataSet dsl1 = function9420.GetCurrentLabelInfo(Reg);
            trackingcode = dsl1.Tables[0].Rows[0]["Tracking_No"].ToString();
            #region Label Request Cancel
            Int64 PrintCount = 0;
            DataTable dt = SQL_DB.ExecuteDataTable("SELECT COUNT(Row_ID) as Cnt FROM M_Code WHERE ISNULL(Print_Status,'') <> '' AND ISNULL(Print_Date,'') <> '' AND LabelRequestId ='" + trackingcode + "'");
            if (dt.Rows.Count > 0)
            {
                PrintCount = Convert.ToInt64(dt.Rows[0]["Cnt"]);
                if (PrintCount == 0)
                {
                    SQL_DB.ExecuteNonQuery("UPDATE [M_Label_Request] SET [Flag] = -1 WHERE Row_ID = " + Reg.Row_ID);
                    #region MailBody
                    string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                     //  " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
                     " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
                       " <hr style='border:1px solid #2587D5;'/>" +
                       " <div class='w_frame'>" +
                       " <p>" +
                       " <div class='w_detail'>" +
                       " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
                       " <br />" +
                       " <span>Your label print request is rejected. Please Contact Admin. </span>" +
                       " following details below: -" +
                       " <p>" +
                       " <table border='0' cellspacing='2'>" +
                       " <tr>" +
                       " <td width='50%' align='left' ><strong>Product Name : </strong></td>" +
                       " <td width='50%' align='left' ><strong>" + proname + "</strong></td>" +
                       " </tr>" +
                       " <tr>" +
                       " <td width='50%' align='left' ><strong>No of labels : </strong></td>" +
                       " <td width='50%' align='left' ><strong>" + noofcode + "</strong></td>" +
                       " </tr>" +
                       " <tr>" +
                       " <td width='50%' align='left' ><strong>Labels request ID : </strong></td>" +
                       " <td width='50%' align='left' ><strong>" + trackingcode + "</strong></td>" +
                       " </tr>" +
                       //" <tr>" +
                       //" <td width='50%' align='left' ><strong>Reason : </strong></td>" +
                       //" <td width='50%' align='left' ><strong>" + HiddenTrackingNo.Value + "</strong></td>" +
                       //" </tr>" +
                       " </table>" +
                       " <div class='w_detail'>" +
                       " Assuring you  of  our best services always.<br />" +
                       " Thank you,<br /><br />" +
                       " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                       "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                       " </div>" +
                       " </p>" +
                       " </div>" +
                       " </p>" +
                       " </div> " +
                       " </div> ";
                    string MBofy = " <br/> following details below: -" +
                       " <p>" +
                       " <table border='0' cellspacing='2'>" +
                       " <tr>" +
                       " <td width='50%' align='left' ><strong>Product Name : </strong></td>" +
                       " <td width='50%' align='left' ><strong>" + proname + "</strong></td>" +
                       " </tr>" +
                       " <tr>" +
                       " <td width='50%' align='left' ><strong>No of labels : </strong></td>" +
                       " <td width='50%' align='left' ><strong>" + noofcode + "</strong></td>" +
                       " </tr>" +
                       " <tr>" +
                       " <td width='50%' align='left' ><strong>Labels request ID : </strong></td>" +
                       " <td width='50%' align='left' ><strong>" + trackingcode + "</strong></td>" +
                       " </tr>" +
                       " </table>";
                    string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, ProjectSession.sales_accomplishtrades, "Product requested labels has been print successfully." + MBofy);
                    string MailBody2 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, ProjectSession.print_accomplishtrades, "Product requested labels has been print successfully." + MBofy);
                    string MailBody3 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, ProjectSession.Finance_accomplishtrades, "Product requested labels has been print successfully." + MBofy);
                    string MailBody4 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, ProjectSession.it_accomplishtrades, "Product requested labels has been print successfully." + MBofy);
                    #endregion
                    DataSet dsMl = function9420.FetchMailDetail("admin");
                    if (dsMl.Tables[0].Rows.Count > 0)
                    {
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Label request print");
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Print Labels");
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.print_accomplishtrades, MailBody2, "Print Labels");
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Print Labels");
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Print Labels");
                    }
                    result = noofcode + " labels canceled successfully <span style='color:blue;' > " + compname + "  </span>  >> " + proname + " >> " + labeltype;

                }
                else
                {
                    Int64 PendingLaels = Convert.ToInt64(noofcode) - Convert.ToInt64(PrintCount);
                    DataSet dsl = function9420.GetCurrentLabelInfo(Reg);
                    trackingcode = dsl.Tables[0].Rows[0]["Tracking_No"].ToString(); //SQL_DB.ExecuteScalar("SELECT Tracking_No FROM  M_Label_Request where  Row_ID='" + Reg.Row_ID + "'").ToString();
                    Reg.Trans_Type = "Label";
                    try
                    {
                        AllocateAndPrint(PendingLaels.ToString(), proid, compID, trackingcode, PrintLabelOrQrcode);//hdNoofCodes.Value
                    }
                    catch (Exception ex)
                    {
                        LogManager.WriteExe("Error Find in Code Label Print functionality! Error is " + ex.Message.ToString());
                    }
                    LogManager.WriteExe("Before updte M_Label_Request!");
                    double CurrLabelPrice = Convert.ToDouble(dsl.Tables[0].Rows[0]["Price"]);
                    SQL_DB.ExecuteNonQuery("UPDATE [M_Label_Request] SET [Flag] = 1,[Price] = '" + CurrLabelPrice + "' WHERE Row_ID = " + Reg.Row_ID);
                    LogManager.WriteExe("After updte M_Label_Request!");
                    function9420.Generate_Invoice(Reg);
                    //function9420.Invoice(Reg);
                    Business9420.function9420.FillUpDateProfile(Reg);
                    #region MailBody
                    string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                      // " <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
                      " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
                       " <hr style='border:1px solid #2587D5;'/>" +
                       " <div class='w_frame'>" +
                       " <p>" +
                       " <div class='w_detail'>" +
                       " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
                       " <br />" +
                       " <span>Your label print request accepted and labels printed successfully. </span>" +
                       " following details below: -" +
                       " <p>" +
                       " <table border='0' cellspacing='2'>" +
                       " <tr>" +
                       " <td width='50%' align='left' ><strong>Product Name : </strong></td>" +
                       " <td width='50%' align='left' ><strong>" + proname + "</strong></td>" +
                       " </tr>" +
                       " <tr>" +
                       " <td width='50%' align='left' ><strong>No of labels : </strong></td>" +
                       " <td width='50%' align='left' ><strong>" + noofcode + "</strong></td>" +
                       " </tr>" +
                       " <tr>" +
                       " <td width='50%' align='left' ><strong>Labels request ID : </strong></td>" +
                       " <td width='50%' align='left' ><strong>" + trackingcode + "</strong></td>" +
                       " </tr>" +
                       " </table>" +
                       " <div class='w_detail'>" +
                       " Assuring you  of  our best services always.<br />" +
                       " Thank you,<br /><br />" +
                       " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                       "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                       " </div>" +
                       " </p>" +
                       " </div>" +
                       " </p>" +
                       " </div> " +
                       " </div> ";
                    string MBofy = " <br/> following details below: -" +
                       " <p>" +
                       " <table border='0' cellspacing='2'>" +
                       " <tr>" +
                       " <td width='50%' align='left' ><strong>Product</strong></td>" +
                       " <td width='50%' align='left' ><strong>" + proname + "</strong></td>" +
                       " </tr>" +
                       " <tr>" +
                       " <td width='50%' align='left' ><strong>No of labels</strong></td>" +
                       " <td width='50%' align='left' ><strong>" + noofcode + "</strong></td>" +
                       " </tr>" +
                       " <tr>" +
                       " <td width='50%' align='left' ><strong>Labels request ID : </strong></td>" +
                       " <td width='50%' align='left' ><strong>" + trackingcode + "</strong></td>" +
                       " </tr>" +
                       " </table>";
                    string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Sales department", "Product requested labels has been print successfully." + MBofy);
                    string MailBody2 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Print department", "Product requested labels has been print successfully." + MBofy);
                    string MailBody3 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Account department", "Product requested labels has been print successfully." + MBofy);
                    string MailBody4 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "IT department", "Product requested labels has been print successfully." + MBofy);
                    #endregion
                    DataSet dsMl = function9420.FetchMailDetail("admin");
                    if (dsMl.Tables[0].Rows.Count > 0)
                    {
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Label request print");
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Print Labels");
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.print_accomplishtrades, MailBody2, "Print Labels");
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Print Labels");
                        DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Print Labels");
                    }
                    result = noofcode + " labels printed successfully <span style='color:blue;' > " + compname + "  </span>  >> " + proname + " >> " + labeltype;

                }
            }
            #endregion
        }
        else if (action == "VerifyReqPay")
        {
            Reg.Comp_ID = compID; // Comp_ID from Payment Received
            Reg.Row_ID = id; // Row_Id from Payment Received
            Reg.Flag = 0;
            function9420.FindDetailsForRequestPayment(Reg);
        }
        else if (action == "VerifySound")
        {
            string Info = "";
            SQL_DB.ExecuteNonQuery("UPDATE Pro_Reg SET Sound_Flag = 1  WHERE  (Pro_ID = '" + proid + "')");//(isnull(Sound_Flag,0) = 0) AND             
                                                                                                           //************************* Code start For Generate Invoice ******************//
            if (function9420.CheckForGenerateInvoice(proid))
            {
                Info = "<br /> Please subscribe the service for this product for further action.<br />";
                Object9420 Inv = new Object9420();
                Inv.Comp_ID = compID;
                Inv.Pro_ID = proid;
                Inv.Plan_ID = "";
                Inv.FolderPath = Server.MapPath("../Data/Bill");
                Inv.Path = Server.MapPath("../Reports") + "\\InvoiceReport.rpt";
                function9420.CreateInvoice(Inv);

            }
            //************************* Code start For Generate Invoice ******************//

            result = "<span style='color:blue'>" + compname + "</span> >> <span style='color:blue'>" + proname + "</span> sound file has been verified successfully !";
            Reg.Pro_ID = "";
            Reg.FileType = "Sound";
            Reg.Comp_Name = compname;
            #region MailBody
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
               //" <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
               " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
               " <hr style='border:1px solid #2587D5;'/>" +
               " <div class='w_frame'>" +
               " <p>" +
               " <div class='w_detail'>" +
               " <span>Dear <em><strong>" + contactPerson + ",</strong></em></span><br />" +
               " <br />" +
               " <span>Product <b>" + proname + "'s</b> Sound file  has been verified successfully. </span><br />" + Info.ToString() +
               " <p>" +
               " <div class='w_detail'>" +
               " Assuring you  of  our best services always.<br />" +
               " Thank you,<br /><br />" +
               " Team <em><strong>VCQRU.COM,</strong></em><br />" +
               "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
               " </div>" +
               " </p>" +
               " </div>" +
               " </p>" +
               " </div> " +
               " </div> ";
            string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Sales department", "Product <b>" + proname + "'s</b> sound file has been verified successfully.");
            string MailBody2 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Lagal department", "Product <b>" + proname + "'s</b> sound file has been verified successfully.");
            string MailBody3 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Account department", "Product <b>" + proname + "'s</b> sound file has been verified successfully.");
            string MailBody4 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "IT department", "Product <b>" + proname + "'s</b> sound file has been verified successfully.");
            #endregion
            string SubjectStr = proname + "'s " + Reg.FileType + " file verified";
            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), proid, MailBody, SubjectStr);
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Company's product sound file activation");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Legal_accomplishtrades, MailBody2, "Company's product sound file activation");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Company's product sound file activation");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Company's product sound file activation");
            }

        }
        else if (action == "VerifyDocuments")
        {
            SQL_DB.ExecuteNonQuery("UPDATE Pro_Reg SET Doc_Flag = 1  WHERE (Pro_ID = '" + proid + "')");//(isnull(Doc_Flag,0) = 0) AND 
            string Info1 = "";
            //************************* Code start For Generate Invoice ******************//
            if (function9420.CheckForGenerateInvoice(proname))
            {
                Info1 = "<br /> Please subscribe the service for this product for further action.<br />";
                Object9420 Inv = new Object9420();
                Inv.Comp_ID = compID;
                Inv.Pro_ID = proid;
                Inv.Plan_ID = "";
                Inv.FolderPath = Server.MapPath("../Data/Bill");
                Inv.Path = Server.MapPath("../Reports") + "\\InvoiceReport.rpt";
                function9420.CreateInvoice(Inv);
            }
            //************************* Code start For Generate Invoice ******************//

            result = "<span style='color:blue'>" + compname + "</span> >> <span style='color:blue'>" + proname + "</span> document file has been verified successfully !";
            Reg.Pro_ID = "";
            Reg.FileType = "Document";
            Reg.Comp_Name = compname;
            #region MailBody
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
               //" <div class='w_logo'><img src='http://vcqru.com/images/logo.png' alt='logo' /></div>" +
               " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
               " <hr style='border:1px solid #2587D5;'/>" +
               " <div class='w_frame'>" +
               " <p>" +
               " <div class='w_detail'>" +
               " <span>Dear <em><strong>" + contactPerson + ",</strong></em></span><br />" +
               " <br />" +
               " <span>Product <b>" + proname + "'s</b> documents has been verified successfully. </span><br />" + Info1.ToString() +
               " <p>" +
               " <div class='w_detail'>" +
               " Assuring you  of  our best services always.<br />" +
               " Thank you,<br /><br />" +
               " Team <em><strong>VCQRU.COM,</strong></em><br />" +
               "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
               " </div>" +
               " </p>" +
               " </div>" +
               " </p>" +
               " </div> " +
               " </div> ";
            string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Sales department", "Product <b>" + proname + "'s</b> document file has been verified successfully.");
            string MailBody2 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Lagal department", "Product <b>" + proname + "'s</b> document file has been verified successfully.");
            string MailBody3 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Account department", "Product <b>" + proname + "'s</b> document file has been verified successfully.");
            string MailBody4 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "IT department", "Product <b>" + proname + "'s</b> document file has been verified successfully.");
            #endregion
            string SubjectStr = proname + "'s " + Reg.FileType + " file verified";
            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), proid, MailBody, SubjectStr);
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Company's product document file activation");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Legal_accomplishtrades, MailBody2, "Company's product document file activation");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Company's product document file activation");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Company's product document file activation");
            }

        }
        else if (action == "VerifySoundreject")
        {


        }
        else if (action == "VerifyDocumentsreject")
        {

        }
        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string actionmethodApproveReject(string id, string proid, string noofcode, string request_Amout, string compID, string action, string proname, string compname, string labeltype, string Request_No,
        string contactPerson, string txtComments)
    {
        string result = "<span style='color:blue'>Not </span> " + action + " !";
        //   MyClassPrintLabels.PrintLabels();
        //   string trackingcode = "";
        //   LogManager.WriteExe("Enter Yes Button Click");// for tem commented
        Object9420 Reg = new Object9420();
        if (id != "no")
        {
            Reg.Row_ID = id;
        }
        Reg.Pro_ID = proid;
        if (Request_No != "no")
        {
            Reg.Request_No = Request_No;
        }
        if (request_Amout != "no")
        {
            Reg.ManuReq_Payment = Convert.ToDouble(request_Amout);
        }
        if (noofcode != "no")
            Reg.Qty = Convert.ToInt32(noofcode);
        else
            Reg.Qty = 0;
        if (request_Amout != "no")
            Reg.Label_Prise = Convert.ToDouble(request_Amout);
        else
            Reg.Label_Prise = 0.00;
        Reg.Comp_ID = compID;
        DataSet dsComp = function9420.FindData(Reg);
        Reg.Comp_Email = dsComp.Tables[0].Rows[0]["Comp_Email"].ToString();
        if (action == "VerifySound" || action == "VerifySoundreject")
        {
            string Info = "";
            if (action == "VerifySound")
            {
                SQL_DB.ExecuteNonQuery("UPDATE Pro_Reg SET Sound_Flag = 1 ,Sound_Remark = '" + txtComments + "' WHERE  (Pro_ID = '" + proid + "')");//(isnull(Sound_Flag,0) = 0) AND       
                result = "<span style='color:blue'>" + compname + "</span> >> <span style='color:blue'>" + proname + "</span> sound file has been verified successfully !";
            }
            else if (action == "VerifySoundreject")
            {
                SQL_DB.ExecuteNonQuery("UPDATE Pro_Reg SET Sound_Flag = -1 ,Sound_Remark = '" + txtComments + "' WHERE  (Pro_ID = '" + proid + "')");//(isnull(Sound_Flag,0) = 0) AND  
                result = "<span style='color:blue'>" + compname + "</span> >> <span style='color:blue'>" + proname + "</span> sound file has been rejected successfully!";
            }

            //************************* Code start For Generate Invoice ******************//
            if (function9420.CheckForGenerateInvoice(proid))
            {
                Info = "<br /> Please subscribe the service for this product for further action.<br />";
                Object9420 Inv = new Object9420();
                Inv.Comp_ID = compID;
                Inv.Pro_ID = proid;
                Inv.Plan_ID = "";
                Inv.FolderPath = Server.MapPath("../Data/Bill");
                Inv.Path = Server.MapPath("../Reports") + "\\InvoiceReport.rpt";
                function9420.CreateInvoice(Inv);

            }
            //************************* Code start For Generate Invoice ******************//


            string SubjectStr = "";

            Reg.Pro_ID = "";
            Reg.FileType = "Sound";
            Reg.Comp_Name = compname;
            #region MailBody
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
               //" <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
               " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
               " <hr style='border:1px solid #2587D5;'/>" +
               " <div class='w_frame'>" +
               " <p>" +
               " <div class='w_detail'>" +
               " <span>Dear <em><strong>" + contactPerson + ",</strong></em></span><br />" +
               " <br />";// +
            string strSSS = "";
            if (action == "VerifySound")
            {
                strSSS = " verified successfully";
                SubjectStr = proname + "'s " + Reg.FileType + " file verified";
                //MailBody = MailBody + " <span>Product <b>" + proname + "'s</b> documents has been. </span><br />" + Info1.ToString();
            }
            else if (action == "VerifySoundreject")
            {
                strSSS = " Rejected by Admin";
                SubjectStr = proname + "'s " + Reg.FileType + " file rejected";
            }
            MailBody = MailBody + " <span>Product <b>" + proname + "'s</b> Sound file  has been " + strSSS + ". </span><br />" + Info.ToString();
            MailBody = MailBody + " </br>" + txtComments + "</br> <p>" +
           " <div class='w_detail'>" +
           " Assuring you  of  our best services always.<br />" +
           " Thank you,<br /><br />" +
           " Team <em><strong>VCQRU.COM,</strong></em><br />" +
           "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
           " </div>" +
           " </p>" +
           " </div>" +
           " </p>" +
           " </div> " +
           " </div> ";
            string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Sales department", "Product <b>" + proname + "'s</b> sound file has been verified successfully.");
            string MailBody2 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Lagal department", "Product <b>" + proname + "'s</b> sound file has been verified successfully.");
            string MailBody3 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Account department", "Product <b>" + proname + "'s</b> sound file has been verified successfully.");
            string MailBody4 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "IT department", "Product <b>" + proname + "'s</b> sound file has been verified successfully.");
            #endregion
            // string SubjectStr = proname + "'s " + Reg.FileType + " file verified";
            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, SubjectStr);
                // DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Label request print");
                if (action == "VerifySound")
                {
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Company's product sound file activation");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Legal_accomplishtrades, MailBody2, "Company's product sound file activation");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Company's product sound file activation");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Company's product sound file activation");
                }
            }

        }
        else if (action == "VerifyDocuments" || action == "VerifyDocumentsreject")
        {
            string Info1 = "";
            if (action == "VerifyDocuments")
            {
                SQL_DB.ExecuteNonQuery("UPDATE Pro_Reg SET Doc_Flag = 1,Doc_Remark = '" + txtComments + "'  WHERE (Pro_ID = '" + proid + "')");//(isnull(Doc_Flag,0) = 0) AND 

                result = "<span style='color:blue'>" + compname + "</span> >> <span style='color:blue'>" + proname + "</span> document file has been verified successfully !";
                //************************* Code start For Generate Invoice ******************//
                if (function9420.CheckForGenerateInvoice(proname))
                {
                    Info1 = "<br /> Please subscribe the service for this product for further action.<br />";
                    Object9420 Inv = new Object9420();
                    Inv.Comp_ID = compID;
                    Inv.Pro_ID = proid;
                    Inv.Plan_ID = "";
                    Inv.FolderPath = Server.MapPath("../Data/Bill");
                    Inv.Path = Server.MapPath("../Reports") + "\\InvoiceReport.rpt";
                    function9420.CreateInvoice(Inv);
                }
                //************************* Code start For Generate Invoice ******************//
            }
            else if (action == "VerifyDocumentsreject")
            {
                SQL_DB.ExecuteNonQuery("UPDATE Pro_Reg SET Doc_Flag = -1,Doc_Remark = '" + txtComments + "'  WHERE (Pro_ID = '" + proid + "')");//(isnull(Doc_Flag,0) = 0) AND 
                result = "<span style='color:blue'>" + compname + "</span> >> <span style='color:blue'>" + proname + "</span> document file has been rejected successfully !";
            }
            string SubjectStr = "";

            Reg.Pro_ID = "";
            Reg.FileType = "Document";
            Reg.Comp_Name = compname;
            #region MailBody
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +

               " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
               " <hr style='border:1px solid #2587D5;'/>" +
               " <div class='w_frame'>" +
               " <p>" +
               " <div class='w_detail'>" +
               " <span>Dear <em><strong>" + contactPerson + ",</strong></em></span><br />" +
               " <br />";
            string strSSS = "";
            if (action == "VerifyDocuments")
            {
                strSSS = " verified successfully";
                SubjectStr = proname + "'s " + Reg.FileType + " file verified";
                //MailBody = MailBody + " <span>Product <b>" + proname + "'s</b> documents has been. </span><br />" + Info1.ToString();
            }
            else if (action == "VerifyDocumentsreject")
            {
                strSSS = " Rejected by Admin";
                SubjectStr = proname + "'s " + Reg.FileType + " file rejected";
            }
            MailBody = MailBody + " <span>Product <b>" + proname + "'s</b> documents has been " + strSSS + ". </span><br />" + txtComments + "</br>" + Info1.ToString();
            MailBody = MailBody + " <p>" +
             " <div class='w_detail'>" +
             " Assuring you  of  our best services always.<br />" +
             " Thank you,<br /><br />" +
             " Team <em><strong>VCQRU.COM,</strong></em><br />" +
             "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
             " </div>" +
             " </p>" +
             " </div>" +
             " </p>" +
             " </div> " +
             " </div> ";
            string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Sales department", "Product <b>" + proname + "'s</b> document file has been verified successfully.");
            string MailBody2 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Lagal department", "Product <b>" + proname + "'s</b> document file has been verified successfully.");
            string MailBody3 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Account department", "Product <b>" + proname + "'s</b> document file has been verified successfully.");
            string MailBody4 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "IT department", "Product <b>" + proname + "'s</b> document file has been verified successfully.");
            #endregion
            // string SubjectStr = proname + "'s " + Reg.FileType + " file verified";
            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, SubjectStr);
                if (action == "VerifyDocuments")
                {
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Company's product document file activation");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Legal_accomplishtrades, MailBody2, "Company's product document file activation");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Company's product document file activation");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Company's product document file activation");
                }
            }

        }
        else if (action == "VerifySoundreject")
        {

        }
        else if (action == "VerifyDocumentsreject")
        {

        }
        return result;
    }

    private string AllocateAndPrint(string NoofCodes, string Pro_ID, string Comp_ID, string trackid, string PrintLabelOrQrcode)
    {
        CodeTableInfo = CreateFileDataTable();
        Session["DemoTable"] = CodeTableInfo;
        string result = "";
        LogManager.WriteExe("New Print Labels Request Codes" + NoofCodes);
        //************************* Code Allocation Start **************************//

        //************************* Print Labels Start **************************//
        DataSet ds = new DataSet();
        Object9420 Reg = new Object9420();
        Reg.Pro_ID = Pro_ID;
        Reg.Comp_ID = Comp_ID;//Add this companyId
        Reg.LabelRequestID = trackid;
        string s1 = ""; string o1 = ""; string s2 = ""; string o2 = "";
        ds.Reset();
    //ds = SQL_DB.ExecuteDataSet("SELECT top " + Convert.ToInt32(NoofCodes) + " [Code1],[Code2] FROM [M_Code] where [Pro_ID] is null and [Use_Type] is null AND [Allot_Date] IS NULL ");//[Pro_ID] = '" + Pro_ID + "' and [Print_Status] = 0
    t:
        try
        {
            if (Reg.Comp_ID == "Comp-1693")
                ds = SQL_DB.ExecuteDataSet("SELECT * FROM [dbo].[GetAvailableCode_PFL] (" + Convert.ToInt64(NoofCodes) + ")");
            else
                ds = SQL_DB.ExecuteDataSet("SELECT * FROM [dbo].[GetAvailableCode] (" + Convert.ToInt64(NoofCodes) + ")");
        }
        catch (Exception ex)
        {
            LogManager.WriteExe("Error find count Avail Code in M_code " + ex.Message.ToString());
            goto t;
        }
        if (ds.Tables[0].Rows.Count == 0)
        {
            return "NoCodeAvailable";
        }
        else if (ds.Tables[0].Rows.Count < Convert.ToInt64(NoofCodes))
        {
            return "NoCodeAvailable";
        }
        else if (ds.Tables[0].Rows.Count > 0)
        {
            StringBuilder sb = new StringBuilder();
            DataSet dseries = SQL_DB.ExecuteDataSet("select isnull( max([Series_Order]),0) as Series_order," +
            " isnull(max(Series_Serial),0) as Series_Serial FROM [M_Code] with (nolock) where [Pro_ID] = '" + Pro_ID + "'" +
            " and Print_Status = 1 and [Series_Order] = (select max([Series_Order]) as Series_order " +
            " FROM [M_Code] with (nolock) where [Pro_ID] = '" + Pro_ID + "' " +
            " and Print_Status = 1)");

            if (Comp_ID == "Comp-1693")
                dseries = SQL_DB.ExecuteDataSet("select isnull( max([Series_Order]),0) as Series_order," +
        " isnull(max(Series_Serial),0) as Series_Serial FROM [M_Code_PFL] with (nolock) where [Pro_ID] = '" + Pro_ID + "'" +
        " and Print_Status = 1 and [Series_Order] = (select max([Series_Order]) as Series_order " +
        " FROM [M_Code_PFL] with (nolock) where [Pro_ID] = '" + Pro_ID + "' " +
        " and Print_Status = 1)");

            int orderId = Convert.ToInt32(dseries.Tables[0].Rows[0]["Series_order"]);
            int serialId = Convert.ToInt32(dseries.Tables[0].Rows[0]["Series_Serial"]);
            int i = 0;
            DataTable M_Code = new DataTable();
            M_Code = CreateDataTable();
            int counter = 0;
            if (orderId == 0 && serialId == 0)
            {
                Reg.Series_Order = 0;
                Reg.Series_Serial = 0;
                Reg.Use_Type = "L";
                Reg.Code1 = Convert.ToInt64(ds.Tables[0].Rows[0]["Code1"].ToString());
                Reg.Code2 = Convert.ToInt64(ds.Tables[0].Rows[0]["Code2"].ToString());
                Business9420.function9420.UpdateFunction(Reg);
                i = 1;
                counter++;
                s1 = Reg.Series_Serial.ToString();
                o1 = Reg.Series_Order.ToString();
            }
            bool CFlag = false; int currentindex = 0;
            string Series_OrderChk = ""; string Series_SerialChkFrom = ""; string Series_SerialChkTo = "";
            //k:
            for (; i < ds.Tables[0].Rows.Count; i++)
            //for (int i=0; i < ds.Tables[0].Rows.Count; i++)
            {
                //p:
                if (!CFlag)
                {
                    string NewNumber = NextNumber(orderId, serialId);
                    string[] b = NewNumber.Split('-');
                    Reg.Series_Order = Convert.ToInt32(b[0]);
                    Reg.Series_Serial = Convert.ToInt32(b[1]);
                }
                if (sb.Length == 0)
                {
                    currentindex = i;
                    Series_OrderChk = Reg.Series_Order.ToString(); Series_SerialChkFrom = Reg.Series_Serial.ToString();
                }
                #region Only Mail Data
                if (i == 0)
                {
                    s1 = Reg.Series_Serial.ToString();
                    o1 = Reg.Series_Order.ToString();
                }
                if (i == ds.Tables[0].Rows.Count - 1)
                {
                    s2 = Reg.Series_Serial.ToString();
                    o2 = Reg.Series_Order.ToString();
                }
                #endregion
                Reg.Use_Type = "L";
                Reg.Code1 = Convert.ToInt64(ds.Tables[0].Rows[i]["Code1"].ToString());
                Reg.Code2 = Convert.ToInt64(ds.Tables[0].Rows[i]["Code2"].ToString());
                //--------------New Code 22_3_13---------------------                

                //M_Code = AddNewRows(M_Code, Convert.ToInt32(Reg.Code1), Convert.ToInt32(Reg.Code2), Reg.Use_Type, Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd")), Pro_ID, 1, Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd")), Reg.Series_Order, Reg.Series_Serial);
                //string Pro_ID, string Use_Type,string Series_Order, string Series_Serial ,string LabelRequestId, string Code1, string Code2, DataTable myTable
                AddCodelInfo(Pro_ID, Reg.Use_Type, Reg.Series_Order.ToString(), Reg.Series_Serial.ToString(), trackid, Reg.Code1.ToString(),
                    Reg.Code2.ToString(), (DataTable)Session["DemoTable"]);

                /********************* Commented Code Logic With Vartual Table PrintLabels *****************/

                orderId = Convert.ToInt32(Reg.Series_Order);
                serialId = Convert.ToInt32(Reg.Series_Serial);

            }

            SaveLabelInfo1((DataTable)Session["DemoTable"], ds.Tables[0].Rows.Count);
            // SaveLabelInfo((DataTable)Session["DemoTable"]);
            int noofrecordds = ds.Tables[0].Rows.Count;
            int Sessiondatatable = ((DataTable)Session["DemoTable"]).Rows.Count;
        }

        //************** Download Excel File And Save *****************
        Object9420 RegExccel = new Object9420();
        RegExccel.Pro_ID = Pro_ID;
             RegExccel.Comp_ID = Comp_ID;
        RegExccel.LabelRequestID = trackid;

        string Qry = "";
        if (Reg.Comp_ID == "Comp-1693")
        {
            Qry = "SELECT row_number() OVER (ORDER BY Excel.Series_Order,Excel.Searies_Name) AS SNO,Excel.Searies_Name, Excel.Row_ID, Excel.Code1, Excel.Code2 ,Excel.Series_Order , c.QRCode from (SELECT Row_ID,Pro_ID +'-'+ (case when len(convert(nvarchar,Series_Order)) = 1 then '000'+convert(nvarchar,Series_Order) when len(convert(nvarchar,Series_Order)) = 2 then '00'+convert(nvarchar,Series_Order) when len(convert(nvarchar,Series_Order)) = 3 then '0'+convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end)+'-'+ " +
                  " (case when len(convert(nvarchar,Series_Serial)) = 1 then '000'+convert(nvarchar,Series_Serial) when len(convert(nvarchar,Series_Serial)) = 2 then '00'+convert(nvarchar,Series_Serial) when len(convert(nvarchar,Series_Serial)) = 3 then '0'+convert(nvarchar,Series_Serial) else convert(nvarchar,Series_Serial) end) AS Searies_Name ,Code1, Code2 ,Series_Order FROM  M_Code_PFL " +
                  " WHERE CONVERT(VARCHAR,Print_Date,111)='" + DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd") + "' AND Pro_ID='" + RegExccel.Pro_ID + "' and print_status = 1 AND (LabelRequestId = '" + RegExccel.LabelRequestID + "' ) " +
                  " ) as Excel  inner join M_Code_C_PFL C on Excel.Row_ID = C.id ";
        }
        else
        {
            Qry = "SELECT row_number() OVER (ORDER BY Excel.Series_Order,Excel.Searies_Name) AS SNO,Excel.Searies_Name, Excel.Row_ID, Excel.Code1, Excel.Code2 ,Excel.Series_Order , c.QRCode from (SELECT Row_ID,Pro_ID +'-'+ (case when len(convert(nvarchar,Series_Order)) = 1 then '000'+convert(nvarchar,Series_Order) when len(convert(nvarchar,Series_Order)) = 2 then '00'+convert(nvarchar,Series_Order) when len(convert(nvarchar,Series_Order)) = 3 then '0'+convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end)+'-'+ " +
          " (case when len(convert(nvarchar,Series_Serial)) = 1 then '000'+convert(nvarchar,Series_Serial) when len(convert(nvarchar,Series_Serial)) = 2 then '00'+convert(nvarchar,Series_Serial) when len(convert(nvarchar,Series_Serial)) = 3 then '0'+convert(nvarchar,Series_Serial) else convert(nvarchar,Series_Serial) end) AS Searies_Name ,Code1, Code2 ,Series_Order FROM  M_Code " +
          " WHERE CONVERT(VARCHAR,Print_Date,111)='" + DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd") + "' AND Pro_ID='" + RegExccel.Pro_ID + "' and print_status = 1 AND (LabelRequestId = '" + RegExccel.LabelRequestID + "' ) " +
          " ) as Excel  inner join M_Code_C C on Excel.Row_ID = C.id ";
        }

         if (PrintLabelOrQrcode == "4" || PrintLabelOrQrcode == "5")
        {
            Qry = "SELECT row_number() OVER (ORDER BY Excel.Series_Order,Excel.Searies_Name) AS SNO,Excel.Searies_Name, Excel.Row_ID, Excel.Code1, Excel.Code2 ,Excel.Series_Order , c.QRCode,Excel.Encrypt_13DigitCode  from (SELECT Row_ID,Pro_ID +'-'+ (case when len(convert(nvarchar,Series_Order)) = 1 then '000'+convert(nvarchar,Series_Order) when len(convert(nvarchar,Series_Order)) = 2 then '00'+convert(nvarchar,Series_Order) when len(convert(nvarchar,Series_Order)) = 3 then '0'+convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end)+'-'+ " +
          " (case when len(convert(nvarchar,Series_Serial)) = 1 then '000'+convert(nvarchar,Series_Serial) when len(convert(nvarchar,Series_Serial)) = 2 then '00'+convert(nvarchar,Series_Serial) when len(convert(nvarchar,Series_Serial)) = 3 then '0'+convert(nvarchar,Series_Serial) else convert(nvarchar,Series_Serial) end) AS Searies_Name ,Code1, Code2 ,Series_Order, CONCAT(Code1, Code2) AS Encrypt_13DigitCode FROM  M_Code_PFL " +
          " WHERE CONVERT(VARCHAR,Print_Date,111)='" + DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd") + "' AND Pro_ID='" + RegExccel.Pro_ID + "' and print_status = 1 AND (LabelRequestId = '" + RegExccel.LabelRequestID + "' ) " +
          " ) as Excel  inner join M_Code_C_PFL C on Excel.Row_ID = C.id ";
        }
        if (PrintLabelOrQrcode == "1")
        {
            download(Convert.ToString(Business9420.function9420.MyRegistrationExccel(RegExccel)), Pro_ID, Comp_ID, RegExccel.LabelRequestID);
        }
         else if (PrintLabelOrQrcode == "5")
        {
            downloadImageFile(Convert.ToString(Business9420.function9420.MyRegistrationExccel_ImageFile(RegExccel)), Pro_ID, Comp_ID, RegExccel.LabelRequestID);
        }
        else
        {
            download_PrintLabels(Convert.ToString(Qry), Pro_ID, Comp_ID, RegExccel.LabelRequestID, PrintLabelOrQrcode);
        }
        //************** Download Excel File And End Save *****************
        LogManager.WriteExe("After Generate Invoice");
        // for company information
        Object9420 NewReg = new Object9420();
        NewReg.Comp_ID = Comp_ID;
        Business9420.function9420.FillUpDateProfile(NewReg);

        //for product information
        DataSet ds1 = function9420.UpdateData(RegExccel);
        if (ds1.Tables[0].Rows.Count > 0)
            RegExccel.Pro_Name = ds1.Tables[0].Rows[0]["Pro_Name"].ToString();
        else
            RegExccel.Pro_Name = "-- -- -- ";

        // for Label Information
        function9420.GetLabelInfo(RegExccel);

        //LabelConfrimHeader.Text = "Alert";
        result = NoofCodes + " Labels of Type '" + RegExccel.Label_Name + "'  for  '" + NewReg.Comp_Name + "'  company  printed.";

        #region MailBody
        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
           //" <div class='w_logo'><img src='"+ ProjectSession.absoluteSiteBrowseUrl +"/images/logo.png' alt='logo' /></div>" +
           " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
           " <hr style='border:1px solid #2587D5;'/>" +
           " <div class='w_frame'>" +
           " <p>" +
           " <div class='w_detail'>" +
           " <span>Dear <em><strong>" + NewReg.Contact_Person + ",</strong></em></span><br />" +
           " <br />" +
           " <span>Your print labels request has been done</span>" +
           //" <br /> Your account has been activated successfully. <br />" +
           " <br />printed labels details are as follows:- <br />" +
           " <table border='0' cellspacing='2'>" +
           " <tr>" +
           " <td width='90' align='right'><strong>Company Name :&nbsp; </strong></td>" +
           " <td width='282'><a href='#'>" + NewReg.Comp_Name + "</a></td>" +
           " </tr>" +
           " <tr>" +
           " <td align='right' valign='top'><strong>Address :&nbsp;</strong></td>" +
           " <td>" + NewReg.Address + "</td>" +
           " </tr>" +

           " <tr>" +
           " <td align='right' valign='top'><strong>Mobile No. :&nbsp;</strong></td>" +
           " <td>" + NewReg.Mobile_No + "</td>" +
           " </tr>" +

           " <tr>" +
           " <td align='right' valign='top'><strong>Fax No. :&nbsp;</strong></td>" +
           " <td>" + NewReg.Fax + "</td>" +
           " </tr>" +

           " <tr>" +
           " <td align='right' valign='top'><strong>Email :&nbsp;</strong></td>" +
           " <td>" + NewReg.Comp_Email + "</td>" +
           " </tr>" +

           " <tr>" +
           " <td align='right' valign='top'><strong>Product Name :&nbsp;</strong></td>" +
           " <td>" + RegExccel.Pro_Name + "</td>" +
           " </tr>" +

           " <tr>" +
           " <td align='right' valign='top'><strong>Label Type :&nbsp;</strong></td>" +
           " <td>" + RegExccel.Label_Name + " ( " + RegExccel.Label_Size + " ) </td>" +
           " </tr>" +

           " <tr>" +
           " <td align='right' valign='top'><strong>Number of Labels :&nbsp;</strong></td>" +
           " <td>" + NoofCodes + "</td>" +
           " </tr>" +

           " <tr>" +
           " <td width='100%' align='left' colspan='2'><strong>Label Series From " + RegExccel.Pro_ID + "-" + string.Format("{0:00}", o1) + "-" + string.Format("{0:000}", s1) + " </strong></td>" +
           " </tr>" +
           " <tr>" +


            " <tr>" +
           " <td width='100%' align='left' colspan='2'><strong>Series Up To " + RegExccel.Pro_ID + "-" + string.Format("{0:00}", o2) + "-" + string.Format("{0:000}", s2) + " </strong></td> " +
           " </tr>" +
           " <tr>" +

           " <tr>" +
           " <td align='right' valign='top'><strong>Label Cost :&nbsp;</strong></td>" +
           " <td>" + RegExccel.Label_Prise.ToString() + "</td>" +
           " </tr>" +

            " <tr>" +
           " <td width='100%' align='left' colspan='2'><strong>Each full series contains 10000 Labels starting from 0000 To 9999.</strong></td>" +
           " </tr>" +

           //" <tr>" +
           //" <td width='100%' align='left' colspan='2'><strong><u>Invoice Copy</u></strong></td>" +
           //" </tr>" +
           " </table>" +
           " <p>" +
           " <div class='w_detail'>" +
           " Assuring you  of  our best services always.<br />" +
           " Thank you,<br /><br />" +
           " Team <em><strong>VCQRU.COM,</strong></em><br />" +
           "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
           " <strong>Toll Free: 1800 183 9420</strong>" +
           " </div>" +
           " </p>" +
           " </div>" +
           " </p>" +
           " </div> " +
           " </div> ";
        #endregion
        DataSet dsMl = function9420.FetchMailDetail("print");
        if (dsMl.Tables[0].Rows.Count > 0)
        {
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), NewReg.Comp_Email, MailBody, "Printed Labels");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.admin_accomplishtrades, MailBody, "Printed Labels");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.print_accomplishtrades, MailBody, "Printed Labels");
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody, "Printed Labels");
        }

        //lblRequestLabelID.Text = string.Empty; // Reset Print Codes Row_ID



        //************************* Print Labels End **************************//

        //ModalPopupExtenderAlert.Show();
        return result;
    }


    private string NextNumber(int orderid, int serialid)
    {
        int NewOrderID;
        int NewSerialID;
        if (serialid == 9999)
            NewOrderID = orderid + 1;
        else
            NewOrderID = orderid;

        if (serialid == 9999)
            NewSerialID = 0;
        else
            NewSerialID = serialid + 1;

        string NewOrderSerial = Convert.ToString(NewOrderID) + "-" + Convert.ToString(NewSerialID);
        return NewOrderSerial;
    }


    private DataTable CreateDataTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Code1", typeof(Int32));
        dt.Columns.Add("Code2", typeof(Int32));
        dt.Columns.Add("Use_Type", typeof(string));
        dt.Columns.Add("Allot_Date", typeof(DateTime));
        dt.Columns.Add("Pro_ID", typeof(string));
        dt.Columns.Add("Print_Status", typeof(Int32));
        dt.Columns.Add("Print_Date", typeof(DateTime));
        dt.Columns.Add("Series_Order", typeof(Int32));
        dt.Columns.Add("Series_Serial", typeof(Int32));
        return dt;
    }
    private DataTable AddNewRows(DataTable dt, Int32 Code1, Int32 Code2, string Use_Type, DateTime Allot_Date, string Pro_ID, Int32 Print_Status, DateTime Print_Date, Int32 Series_Order, Int32 Series_Serial)
    {
        DataRow dr = dt.NewRow();
        dr["Code1"] = Code1;
        dr["Code2"] = Code2;
        dr["Use_Type"] = Use_Type;
        dr["Allot_Date"] = Allot_Date;
        dr["Pro_ID"] = Pro_ID;
        dr["Print_Status"] = Print_Status;
        dr["Print_Date"] = Print_Date;
        dr["Series_Order"] = Series_Order;
        dr["Series_Serial"] = Series_Serial;
        dt.Rows.Add(dr);
        return dt;
    }
    private void download_PrintLabels(string qry, string Pro_ID, string Comp_ID, string LBLREQID, string PrintLabelOrQrcode)
    {
        Object9420 RegExccel = new Object9420();
        RegExccel.Pro_ID = Pro_ID;
        RegExccel.Comp_ID = Comp_ID;
        RegExccel.LabelRequestID = LBLREQID;
        string path = Server.MapPath("../Data");
        path = path + "\\" + "Excel";
        DataProvider.Utility.CreateDirectory(path);
        string DirectoryName = path + "\\" + DataProvider.LocalDateTime.Now.ToString("dd-MM-yyyy");
        DataProvider.Utility.CreateDirectory(DirectoryName);
        string DirectoryNameN = DirectoryName + "\\" + "Licence";
        DataProvider.Utility.CreateDirectory(DirectoryNameN);
        DataProvider.Utility.DeleteFiles(DirectoryNameN + "\\" + RegExccel.Comp_ID.Substring(5, 4) + "_" + RegExccel.Pro_ID + ".xls");

        DataProvider.Utility.DeleteFiles(DirectoryNameN + "\\" + RegExccel.Comp_ID.Substring(5, 4) + "_" + RegExccel.Pro_ID + ".pdf");
        DataSet ds_rpt = new DataSet(); DataSet ds = new DataSet(); DataTable dt = new DataTable();
        try
        {
            ds = ExecuteNonQueryAndDatatable.GetPrintLabels(qry);
            //SQL_DB.GetDA(qry).Fill(ds, "1");
        }
        catch (Exception ex)
        {

            throw ex;
        }

        Int32 countrows = ds.Tables[0].Rows.Count;
        int cntloop = 0;
        int rem = 0;
        //if (countrows > 50000)
        if (countrows > 30000)
        {
            //cntloop = countrows / 50000;
            //rem = countrows - (cntloop * 50000);
            cntloop = countrows / 30000;
            rem = countrows - (cntloop * 30000);
        }
        else
        {
            rem = countrows;
        }
        int i = 0, j = 0, k = 0, l = 0;
        if (cntloop > 0)
        {
            for (i = 0; i < cntloop; i++)
            {
                dt = DataProvider.Utility.CreateDataTableExcel_PrintLabels();
                //for (l = 0, j = k; l < 50000; l++, j++)
                for (l = 0, j = k; l < 30000; l++, j++)
                {
                    dt = DataProvider.Utility.AddNewRowsExcel_PrintLabels(dt, Convert.ToInt32(ds.Tables[0].Rows[j]["Code1"]), Convert.ToInt32(ds.Tables[0].Rows[j]["Code2"]), Convert.ToInt32(ds.Tables[0].Rows[j]["SNO"]), ds.Tables[0].Rows[j]["Searies_Name"].ToString(), (byte[])ds.Tables[0].Rows[j]["QRCode"]);
                }
                k = j;
                DataProvider.Utility.CreateExcel_PrintLabels(dt, DirectoryNameN, RegExccel.Comp_ID, RegExccel.Pro_ID, i, RegExccel.LabelRequestID, PrintLabelOrQrcode);
            }
        }
        if (rem > 0)
        {
            dt = DataProvider.Utility.CreateDataTableExcel_PrintLabels();
            for (l = 0, j = k; l < rem; j++, l++)
            {
                dt = DataProvider.Utility.AddNewRowsExcel_PrintLabels(dt, Convert.ToInt32(ds.Tables[0].Rows[j]["Code1"]), Convert.ToInt32(ds.Tables[0].Rows[j]["Code2"]), Convert.ToInt32(ds.Tables[0].Rows[j]["SNO"]), ds.Tables[0].Rows[j]["Searies_Name"].ToString(), (byte[])ds.Tables[0].Rows[j]["QRCode"]);
            }
            DataProvider.Utility.CreateExcel_PrintLabels(dt, DirectoryNameN, RegExccel.Comp_ID, RegExccel.Pro_ID, i, RegExccel.LabelRequestID, PrintLabelOrQrcode);
        }

    }

        private void SaveAssingedImageInfo(DataTable dt)
    {
        SqlConnection conn = dtcon.CreateConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.Open();
        if (((DataTable)Session["ImageInfo"]).Rows.Count > 0)
        {
            using (SqlBulkCopy bulkCopy = new SqlBulkCopy(conn))
            {

                bulkCopy.DestinationTableName = "tblAssignedArtImages";

                try
                {

                    // Note QrCodeStatus is true . It is set as default binding in sql server
                    // Write from the source to the destination.
                    bulkCopy.BulkCopyTimeout = 0;
                    bulkCopy.WriteToServer(dt);
                    Session["ImageInfo"] = null;
                    CodeTableInfo =DataProvider.Utility.CreateAssingedImageDataTable();
                    Session["ImageInfo"] = CodeTableInfo;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }


        }
    }

      public string RandomImage(string CodeDetails, int FileName, DataTable myTable)
    {
       string OldFileName = "111.png";

        var lowerBound = 1;
        int upperBound = 147;
        int Rem = FileName % upperBound;
        if (Rem > 0)
            OldFileName = Rem.ToString() + ".png";
        else
                OldFileName ="147.png";
          //OldFileName = DataProvider.Utility.GetNewImageFile();



        string[] Codes = CodeDetails.Split('-');
        //#region Commented due to missing codes
        //SQL_DB.ExecuteNonQuery("insert into tblAssignedArtImages(Code1,Code2,ImagePath)values('" + Codes[0].ToString() + "','" + Codes[1].ToString() + "','/Art_Image/" + OldFileName + "')");


        //#endregion

        DataRow row;
        row = myTable.NewRow();

        row["ImagePath"] = "/Art_Image/" + OldFileName;
        row["Code1"] = Codes[0].ToString();
        row["Code2"] = Codes[1].ToString();
        myTable.Rows.Add(row);
        Session["ImageInfo"] = myTable;
             
        return "https://www.vcqru.com/Art_Image/"+OldFileName;
    }
    private void downloadImageFile(string qry, string Pro_ID, string Comp_ID, string LBLREQID)
    {
        Object9420 RegExccel = new Object9420();
        RegExccel.Pro_ID = Pro_ID;
        RegExccel.Comp_ID = Comp_ID;
        RegExccel.LabelRequestID = LBLREQID;
        string path = Server.MapPath("../Data");
        path = path + "\\" + "Excel";
        DataProvider.Utility.CreateDirectory(path);
        string DirectoryName = path + "\\" + DataProvider.LocalDateTime.Now.ToString("dd-MM-yyyy");
        DataProvider.Utility.CreateDirectory(DirectoryName);
        string DirectoryNameN = DirectoryName + "\\" + "Licence";
        DataProvider.Utility.CreateDirectory(DirectoryNameN);
        DataProvider.Utility.DeleteFiles(DirectoryNameN + "\\" + RegExccel.Comp_ID.Substring(5, 4) + "_" + RegExccel.Pro_ID + ".xls");

        string MediaFileName = path + "\\ MediaFile" + DataProvider.LocalDateTime.Now.ToString("dd-MM-yyyy");
        DataProvider.Utility.CreateDirectory(MediaFileName);
        string MediaFileNameN = DirectoryName + "\\" + "MediaFile";
        DataProvider.Utility.CreateDirectory(MediaFileNameN);
        //  DataProvider.Utility.DeleteFiles(MediaFileNameN + "\\" + RegExccel.Comp_ID.Substring(5, 4) + "_" + RegExccel.Pro_ID + ".xls");
        DataSet ds_rpt = new DataSet(); DataSet ds = new DataSet(); DataTable dt = new DataTable();
        SQL_DB.GetDA(qry).Fill(ds, "1");
        Int32 countrows = ds.Tables[0].Rows.Count;
        int cntloop = 0;
        int rem = 0;
        if (countrows > 50000)
        {
            cntloop = countrows / 50000;
            rem = countrows - (cntloop * 50000);
        }
        else
        {
            rem = countrows;
        }
        int i = 0, j = 0, k = 0, l = 0;
        if (cntloop > 0)
        {
            for (i = 0; i <= cntloop; i++)
            {
                    Session["ImageInfo"] = null;
                CodeTableInfo = DataProvider.Utility.CreateAssingedImageDataTable();
                Session["ImageInfo"] = CodeTableInfo;
                dt = DataProvider.Utility.CreateDataTableExcelImageFile();
                for (l = 0, j = k; l < 50000; l++, j++)
                {
                    dt = DataProvider.Utility.AddNewRowsExcel_ImageFile_PrintLabels(dt, Convert.ToInt32(ds.Tables[0].Rows[j]["Code1"]), Convert.ToInt32(ds.Tables[0].Rows[j]["Code2"]), Convert.ToInt32(ds.Tables[0].Rows[j]["SNO"]), ds.Tables[0].Rows[j]["Searies_Name"].ToString(), RandomImage(ds.Tables[0].Rows[j]["ImageFile"].ToString(),(l+1), (DataTable)Session["ImageInfo"]));
                }
                k = j;

                    SaveAssingedImageInfo((DataTable)Session["ImageInfo"]);

                DataProvider.Utility.CreateExcel(dt, DirectoryNameN, RegExccel.Comp_ID, RegExccel.Pro_ID, i, RegExccel.LabelRequestID);
            }
        }
        if (rem > 0)
        {
                Session["ImageInfo"] = null;
                CodeTableInfo = DataProvider.Utility.CreateAssingedImageDataTable();
                Session["ImageInfo"] = CodeTableInfo;
            dt = DataProvider.Utility.CreateDataTableExcelImageFile();
            for (l = 0, j = k; l < rem; j++, l++)
            {
                dt = DataProvider.Utility.AddNewRowsExcel_ImageFile_PrintLabels(dt, Convert.ToInt32(ds.Tables[0].Rows[j]["Code1"]), Convert.ToInt32(ds.Tables[0].Rows[j]["Code2"]), Convert.ToInt32(ds.Tables[0].Rows[j]["SNO"]), ds.Tables[0].Rows[j]["Searies_Name"].ToString(), RandomImage(ds.Tables[0].Rows[j]["ImageFile"].ToString(),(l+1), (DataTable)Session["ImageInfo"]));
            }
            SaveAssingedImageInfo((DataTable)Session["ImageInfo"]);

            DataProvider.Utility.CreateExcel(dt, DirectoryNameN, RegExccel.Comp_ID, RegExccel.Pro_ID, i, RegExccel.LabelRequestID);
        }

    }


    private void download(string qry, string Pro_ID, string Comp_ID, string LBLREQID)
    {
        Object9420 RegExccel = new Object9420();
        RegExccel.Pro_ID = Pro_ID;
        RegExccel.Comp_ID = Comp_ID;
        RegExccel.LabelRequestID = LBLREQID;
        string path = Server.MapPath("../Data");
        path = path + "\\" + "Excel";
        DataProvider.Utility.CreateDirectory(path);
        string DirectoryName = path + "\\" + DataProvider.LocalDateTime.Now.ToString("dd-MM-yyyy");
        DataProvider.Utility.CreateDirectory(DirectoryName);
        string DirectoryNameN = DirectoryName + "\\" + "Licence";
        DataProvider.Utility.CreateDirectory(DirectoryNameN);
        DataProvider.Utility.DeleteFiles(DirectoryNameN + "\\" + RegExccel.Comp_ID.Substring(5, 4) + "_" + RegExccel.Pro_ID + ".xls");
        DataSet ds_rpt = new DataSet(); DataSet ds = new DataSet(); DataTable dt = new DataTable();
        SQL_DB.GetDA(qry).Fill(ds, "1");
        Int32 countrows = ds.Tables[0].Rows.Count;
        int cntloop = 0;
        int rem = 0;
        if (countrows > 50000)
        {
            cntloop = countrows / 50000;
            rem = countrows - (cntloop * 50000);
        }
        else
        {
            rem = countrows;
        }
        int i = 0, j = 0, k = 0, l = 0;
        if (cntloop > 0)
        {
            for (i = 0; i < cntloop; i++)
            {
                dt = DataProvider.Utility.CreateDataTableExcel();
                for (l = 0, j = k; l < 50000; l++, j++)
                {
                    dt = DataProvider.Utility.AddNewRowsExcel(dt, Convert.ToInt32(ds.Tables[0].Rows[j]["Code1"]), Convert.ToInt32(ds.Tables[0].Rows[j]["Code2"]), Convert.ToInt32(ds.Tables[0].Rows[j]["SNO"]), ds.Tables[0].Rows[j]["Searies_Name"].ToString());
                }
                k = j;
                DataProvider.Utility.CreateExcel(dt, DirectoryNameN, RegExccel.Comp_ID, RegExccel.Pro_ID, i, RegExccel.LabelRequestID);
            }
        }
        if (rem > 0)
        {
            dt = DataProvider.Utility.CreateDataTableExcel();
            for (l = 0, j = k; l < rem; j++, l++)
            {
                dt = DataProvider.Utility.AddNewRowsExcel(dt, Convert.ToInt32(ds.Tables[0].Rows[j]["Code1"]), Convert.ToInt32(ds.Tables[0].Rows[j]["Code2"]), Convert.ToInt32(ds.Tables[0].Rows[j]["SNO"]), ds.Tables[0].Rows[j]["Searies_Name"].ToString());
            }
            DataProvider.Utility.CreateExcel(dt, DirectoryNameN, RegExccel.Comp_ID, RegExccel.Pro_ID, i, RegExccel.LabelRequestID);
        }

    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string bindcodeData(string Comp_ID=null)
    {
            string Compid = string.Empty;
        if (Comp_ID != "null")
            Compid = Comp_ID;

        Session["LBLInfo"] = null;
        CodeTableInfo = CreatecodeFileDataTable();
        Session["LBLInfo"] = CodeTableInfo;
        string result = "";
        string result1 = Business9420.function9420.FilCodelInfoUsed(Compid);
        string result2 = Business9420.function9420.FilCodelInfo(Compid);
        string result3 = Business9420.function9420.FilCodelInfoDemo(Compid);

        string result4 = (Convert.ToInt32(result1) - (Convert.ToInt32(result2) + Convert.ToInt32(result3))).ToString();
        return result = result1 + "$" + result2 + "$" + result3 + "$" + result4 + "$";
    }


    #region Code Generation
    private DataTable CreatecodeFileDataTable()
    {
        DataTable myDataTable = new DataTable();
        DataColumn myDataColumn;
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.Int64");
        myDataColumn.ColumnName = "Row_ID";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Gen_Date";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Gen_By";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.String");
        myDataColumn.ColumnName = "Code1";
        myDataTable.Columns.Add(myDataColumn);
        myDataColumn = new DataColumn();
        myDataColumn.DataType = Type.GetType("System.Int64");
        myDataColumn.ColumnName = "Code2";
        myDataTable.Columns.Add(myDataColumn);
        //myDataColumn = new DataColumn();
        //myDataColumn.DataType = Type.GetType("System.Boolean");
        //myDataColumn.ColumnName = "QRCodeStatus";
        //  myDataTable.Columns.Add(myDataColumn);
        return myDataTable;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    private void GenerateCode(Int64 TOTALQ, string Suffix,string CompID)
    {
        //Response.Write("<br/> Start Time " + System.DateTime.Now);
        //if (((DataTable)Session["LBLInfo"]).Rows.Count > 0)
        //{
        //    ((DataTable)Session["LBLInfo"]).Rows.Clear();
        //    Session["LBLInfo"] = null;
        //}
        DateTime now1 = new DateTime();
        now1 = DateTime.Now;
        Random rand = new Random(now1.Millisecond);
        int cnt = 0;
        Dictionary<Int64, string> rHash = new Dictionary<Int64, string>();
        while (true)
        {
            string number = "";
            number = number + rand.Next(1, 9).ToString();
            number = number + rand.Next(0, 9).ToString();
            number = number + rand.Next(0, 9).ToString();
            number = number + rand.Next(0, 9).ToString();
            number = number + rand.Next(0, 9).ToString();
            number = number + rand.Next(0, 9).ToString();
            number = number + rand.Next(0, 9).ToString();
            number = number + rand.Next(0, 9).ToString();
            number = number + rand.Next(1, 9).ToString();
            number = number + rand.Next(0, 9).ToString();
            number = number + rand.Next(0, 9).ToString();
            number = number + rand.Next(0, 9).ToString();
            number = number + rand.Next(0, 9).ToString();
            string Code2 = number.ToString().Substring(0, 8);
            string Code1 = number.ToString().Substring(8, 5);

            number = Code1 + Code2;

            Int64 tempKey = Convert.ToInt64(number);

            if (!rHash.ContainsKey(tempKey))
            {
                rHash.Add(tempKey, number);

                AddCodelInfo(0, "", "Admin", Code1, Code2, (DataTable)Session["LBLInfo"]);
            }

            if (rHash.Count == TOTALQ) break;


        }
        rHash = new Dictionary<Int64, string>();
        CheckDuplicate_GenerateCode((DataTable)Session["LBLInfo"],CompID);
        // SavenewLabelInfo((DataTable)Session["LBLInfo"]);
        //bool chkCodeDuplicate = CheckDuplicate_GenerateCode((DataTable)Session["LBLInfo"]);
        //if (chkCodeDuplicate)
        //{
        //    rHash = new Dictionary<Int64, string>();
        //    SavenewLabelInfo((DataTable)Session["LBLInfo"]);
        //}
        //else
        //{
        //    CheckDuplicate_GenerateCode((DataTable)Session["LBLInfo"]);
        //}
    }
    private void CheckDuplicate_GenerateCode(DataTable dt,string CompID)
    {
        XmlDocument xmldoc = new XmlDocument();
        XmlElement xmlrootelement = xmldoc.CreateElement("Tab");
        xmldoc.AppendChild(xmlrootelement);

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            //   if (lstProfileItemId.Split(',')[i].Length > 0)
            {
                XmlElement child = xmldoc.CreateElement("id");
                //   child.SetAttribute("Series_Order", dt.Rows[i]["Series_Order"].ToString());
                //    child.SetAttribute("Series_Serial", dt.Rows[i]["Series_Serial"].ToString());
                child.SetAttribute("Code1", dt.Rows[i]["Code1"].ToString());
                child.SetAttribute("Code2", dt.Rows[i]["Code2"].ToString());
                child.SetAttribute("index", (i + 1).ToString());
                xmlrootelement.AppendChild(child);
            }

        }
        if (dt.Rows.Count > 0)
        {
            string xmlLibraryList = xmldoc.OuterXml;
            //  DateTime print_date = Convert.ToDateTime(DataProvider.LocalDateTime.Now);//.ToString("yyyy/MM/dd hh:mm:ss tt");
            DataTable ddt1 = ExecuteNonQueryAndDatatable.CheckDuplicate_GenerateCode(xmlLibraryList).Tables[0];
            if (ddt1.Rows.Count == 0)
            {

                SavenewLabelInfo((DataTable)Session["LBLInfo"],CompID);
            }
            else
            {
                DataTable dtAllRecords = (DataTable)Session["LBLInfo"];
                for (int i = 0; i < ddt1.Rows.Count; i++)
                {
                    DataRow[] dr = dtAllRecords.Select("code1=" + ddt1.Rows[i]["code1"] + " and code2=" + ddt1.Rows[i]["code2"]);
                    DataRow dr1 = dr[0];
                    dr1.Delete();

                }
                int y = dtAllRecords.Rows.Count;
                SavenewLabelInfo(dtAllRecords,CompID);
                GenerateCode(ddt1.Rows.Count, "",CompID);

            }
        }

    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    private void AddCodelInfo(Int64 Row_ID, string Gen_Date, string Gen_By, string Code1, string Code2, DataTable myTable)
    {
        DataRow row;
        row = myTable.NewRow();
        row["Row_ID"] = Row_ID;
        row["Gen_Date"] = Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt");
        row["Gen_By"] = Gen_By;
        row["Code1"] = Code1;
        row["Code2"] = Code2;
        // Note QrCodeStatus is true . It is set as default binding in sql server
        // row["QRCodeStatus"] = true;
        myTable.Rows.Add(row);
        Session["LBLInfo"] = myTable;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    private void SavenewLabelInfo(DataTable dt,string CompID)
    {
        SqlConnection conn = dtcon.CreateConnection();
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.Open();
        if (((DataTable)Session["LBLInfo"]).Rows.Count > 0)
        {
            using (SqlBulkCopy bulkCopy = new SqlBulkCopy(conn))
            {
                    if(CompID !="")
                    bulkCopy.DestinationTableName = "M_Code_PFL";
                else
                bulkCopy.DestinationTableName = "M_Code";

                try
                {

                    // Note QrCodeStatus is true . It is set as default binding in sql server
                    // Write from the source to the destination.
                    bulkCopy.BulkCopyTimeout = 0;
                    bulkCopy.WriteToServer(dt);
                    Session["LBLInfo"] = null;
                    CodeTableInfo = CreatecodeFileDataTable();
                    Session["LBLInfo"] = CodeTableInfo;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }

            DataTable dtM_Code = new DataTable();
            if(CompID !="")
                 dtM_Code = SQL_DB.ExecuteDataTable("Select Row_id,code1,code2 from M_Code_PFL where isnull(QRCodeStatus,0) =1; Update M_Code_PFL set QRCodeStatus=0 where isnull(QRCodeStatus,0) =1");
            else
            dtM_Code = SQL_DB.ExecuteDataTable("Select Row_id,code1,code2 from m_code where isnull(QRCodeStatus,0) =1; Update M_code set QRCodeStatus=0 where isnull(QRCodeStatus,0) =1");
            if (dtM_Code.Rows.Count > 0)
            {
                dtM_Code.Columns.Add("QRCodeStatus", typeof(Byte[]));

                string strEncrypt = string.Empty;
                for (int i = 0; i < dtM_Code.Rows.Count; i++)
                {
                    strEncrypt = DataProvider.LogManager.Encrypt("codeone=" + dtM_Code.Rows[i]["code1"].ToString() + "&codetwo=" + dtM_Code.Rows[i]["code2"].ToString());
                    var qr = new ZXing.BarcodeWriter();
                    qr.Options = options;
                    qr.Format = ZXing.BarcodeFormat.QR_CODE;
                    Bitmap result = new Bitmap(qr.Write(ProjectSession.absoluteSiteBrowseUrl + "/Default.aspx?id=" + strEncrypt));
                    MemoryStream ms = new MemoryStream();
                    result.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    byte[] byteImage = ms.ToArray();

                    dtM_Code.Rows[i]["QRCodeStatus"] = byteImage;
                }
                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(conn))
                {
                         if(CompID !="")
                    bulkCopy.DestinationTableName = "M_Code_C_PFL";
                else
                    bulkCopy.DestinationTableName = "M_Code_C";

                    try
                    {


                        // Write from the source to the destination.
                        bulkCopy.BulkCopyTimeout = 0;
                        bulkCopy.WriteToServer(dtM_Code);
                        // Session["LBLInfo"] = null;
                        // CodeTableInfo = CreatecodeFileDataTable();
                        //Session["LBLInfo"] = CodeTableInfo;
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }
            }

        }
    }
    #endregion

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string generatecode(string code,string Comp_ID=null)
    {
        string result = "";

            

        string CompID = string.Empty;
        if (Comp_ID != "null")
            CompID = Comp_ID;

        if (Convert.ToInt64(code) > 2500000)
        {

            result = "PLEASE ENTER CODES 2500000 OR LESS THAN 2500000";
        }
        else
        {
            try
            {
                GenerateCode(Convert.ToInt64(code), "0",CompID);

                result = code.ToString() + " codes generated successfully !";
                //DataTable kdt = SQL_DB.ExecuteDataTable("SELECT TOP(1) * FROM [M_CodeKey] WHERE [IsUsed]= 0 ORDER BY NEWID()");
                //if (kdt.Rows.Count > 0)
                //{
                //    SQL_DB.ExecuteNonQuery("UPDATE [M_CodeKey] SET [IsUsed] = 1 WHERE [Row_ID]= " + kdt.Rows[0]["Row_ID"] + "");
                //    GenerateCode(Convert.ToInt64(code), kdt.Rows[0]["Sufix"].ToString());

                //    result = code.ToString() + " codes generated successfully !";
                //}
                //else
                //{
                //    result = "You don't have sufix !";
                //}

            }
            catch (Exception ex)
            {
                result = ex.Message.ToString();//"Some Exception in codes generation !";
            }
        }
        return result;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getcompany()
    {
        String daresult = null;
        DataSet ds = function9420.FillActiveComp();
        daresult = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return daresult;

    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getcompanyproducts(string compid)
    {
        String daresult = null;
        Object9420 Reg = new Object9420();
        Reg.Comp_ID = compid;
        // DataSet ds = function9420.FillddlProForPrint(Reg);
        // this change is done by shweta because in above "function9420.FillddlProForPrint(Reg);"  - m_code table is used and taking too much time for fectching data.
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT  distinct   Pro_Reg.Pro_ID, Pro_Reg.Pro_Name FROM Pro_Reg WHERE (Pro_Reg.Comp_ID = '" + Reg.Comp_ID + "')  ORDER BY Pro_Reg.Pro_Name");
        daresult = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return daresult;
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string AddFunds(string compid, decimal Amount)
    {
        String daresult = null;
        Object9420 Reg = new Object9420();


        decimal Old_Amount;
        decimal New_Amount;
        DataTable dt = SQL_DB.ExecuteDataTable("select  Amount from Paytm_balance where Comp_ID='" + compid + "'");

        try
        {

            if (dt.Rows.Count >= 1)
            {
                Old_Amount = Convert.ToDecimal(dt.Rows[0]["Amount"].ToString());
                New_Amount = Old_Amount + Amount;


                SQL_DB.ExecuteNonQuery("UPDATE [Paytm_balance]  SET  Amount = '" + New_Amount + "' WHERE Comp_ID='" + compid + "'");
            }
            else
            {
                New_Amount = Amount;
                SQL_DB.ExecuteNonQuery("Insert into Paytm_balance(Comp_ID,Amount,Updated_date)values('" + compid + "'," + New_Amount + ",GETDATE())");

            }


            if (SendMailClass.SendMailToCompany(compid, "Paytm Balance Updated", "Today we have Added " + Amount + " Rupees in Your Paytm Wallet.", null))
            {
                daresult = "Success";
            }
            else
            {
                // Email not sending from here 
                daresult = "Success";
            }


            return daresult;
        }

        catch (Exception ex)
        {
            daresult = "Failed";

        }
        return daresult;

    }



    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getfilterdata(string compid, string proid, string fromdate, string todate)
    {
        String daresult = null;
        string strAll = "";
        //if (fromdate != "")
        //{
        //    strAll = "      AND Print_Date >='" + Convert.ToDateTime(fromdate).ToString("yyyy/MM/dd HH:mm:ss") + "' ";//AND Print_Date <='" + Convert.ToDateTime(todate).AddDays(1).ToString("yyyy/MM/dd HH:mm:ss") + "'";
        //}
        //if (fromdate == todate)
        //{
        //    strAll = "      AND Print_Date >='" + Convert.ToDateTime(fromdate).ToString("yyyy/MM/dd HH:mm:ss") + "'";
        //}
        //else
        //{
        if (fromdate != "" && todate != "")
            strAll = "      AND Print_Date >='" + Convert.ToDateTime(fromdate).ToString("yyyy/MM/dd HH:mm:ss") + "' AND Print_Date <='" + Convert.ToDateTime(todate).AddDays(1).ToString("yyyy/MM/dd HH:mm:ss") + "'";
        else if (fromdate != "" && todate == "")
            strAll = "    AND Print_Date >='" + Convert.ToDateTime(fromdate).ToString("yyyy/MM/dd  HH:mm:ss") + "' ";//AND Print_Date <='" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd HH:mm:ss") + "'";
        else if (fromdate == "" && todate != "")
            strAll = "     AND Print_Date <='" + Convert.ToDateTime(todate).AddDays(1).ToString("yyyy/MM/dd HH:mm:ss") + "'";
        //strAll = "    AND Print_Date >='" + Convert.ToDateTime("1900/01/01").ToString("yyyy/MM/dd  HH:mm:ss") + "' AND Print_Date <='" + Convert.ToDateTime(todate).ToString("yyyy/MM/dd HH:mm:ss") + "'";
        // }
        if (proid != "0")
            strAll += " AND (''='" + proid + "' OR Pro_ID='" + proid + "')";

        string Qry = "";
        if (compid != "0")
        {
            if (compid == "Comp-1693")
            {

                strAll += " AND (''='" + compid + "' OR (SELECT  Comp_ID FROM Pro_Reg WHERE Pro_Reg.Pro_ID=MC.Pro_ID)='" + compid + "')";

                Qry = "SELECT ROW_NUMBER() OVER(ORDER BY print_date ASC) ID, SerFr,SerTo,SUM(Codes) Codes, pro_id,DownFl, Comp_Name,Pro_Name,Cast(print_date AS DATE) print_date FROM (SELECT CONVERT(NVARCHAR,MC.Pro_ID)+'-'+(CASE WHEN LEN(CONVERT(NUMERIC,max(Series_Order))) = 1 THEN  '0' + CONVERT(NVARCHAR,max(Series_Order)) ELSE CONVERT(NVARCHAR,max(Series_Order)) END) + '-' + (CASE WHEN LEN(CONVERT(NUMERIC,min(Series_Serial))) = 1 THEN  '000' + CONVERT(NVARCHAR,min(Series_Serial)) WHEN LEN(CONVERT(NUMERIC,min(Series_Serial))) = 2 THEN  '00' + CONVERT(NVARCHAR,min(Series_Serial)) WHEN LEN(CONVERT(NUMERIC,min(Series_Serial))) = 3 THEN  '0' + CONVERT(NVARCHAR,min(Series_Serial)) ELSE CONVERT(NVARCHAR,min(Series_Serial)) END) AS SerFr," +
                   " CONVERT(NVARCHAR,MC.Pro_ID)+'-'+(CASE WHEN LEN(CONVERT(NUMERIC,max(Series_Order))) = 1 THEN  '0' + CONVERT(NVARCHAR,max(Series_Order)) ELSE CONVERT(NVARCHAR,max(Series_Order)) END) + '-' + (CASE WHEN LEN(CONVERT(NUMERIC,max(Series_Serial))) = 1 THEN  '000' + CONVERT(NVARCHAR,max(Series_Serial)) WHEN LEN(CONVERT(NUMERIC,max(Series_Serial))) = 2 THEN  '00' + CONVERT(NVARCHAR,max(Series_Serial)) WHEN LEN(CONVERT(NUMERIC,max(Series_Serial))) = 3 THEN  '0' + CONVERT(NVARCHAR,max(Series_Serial)) ELSE CONVERT(NVARCHAR,max(Series_Serial)) END) AS SerTo, " +
               " COUNT(MC.Row_ID) AS Codes,isnull(B.Display_Series,MC.Pro_ID) Pro_ID,MC.Pro_ID+'*'+ convert(nvarchar,CAST(Print_Date AS DATE),105)+'*'+LabelRequestId as DownFl,(SELECT  Comp_Name FROM Comp_Reg WHERE Comp_ID=(SELECT  Comp_ID FROM Pro_Reg WHERE Pro_ID=MC.Pro_ID)) AS Comp_Name ,(Select isnull(Display_Product,Pro_Name) Pro_Name from Pro_Reg where Pro_ID = MC.Pro_ID) as Pro_Name,CAST(Print_Date AS DATE) Print_Date FROM M_Code_PFL MC left join Pro_Reg B on MC.Pro_ID = B.Pro_ID WHERE [Use_Type]='L' " + strAll + " GROUP BY MC.Pro_ID,B.Display_Series  ,CAST(Print_Date AS DATE),LabelRequestId) A GROUP BY SerFr,SerTo, A.pro_id,DownFl, Comp_Name,Pro_Name, Cast(print_date AS DATE)  ORDER BY ID DESC";

            }
            else
            {

                strAll += " AND (''='" + compid + "' OR (SELECT  Comp_ID FROM Pro_Reg WHERE Pro_Reg.Pro_ID=MC.Pro_ID)='" + compid + "')";
                Qry = "SELECT ROW_NUMBER() OVER(ORDER BY print_date ASC) ID, SerFr,SerTo,SUM(Codes) Codes, pro_id,DownFl, Comp_Name,Pro_Name,Cast(print_date AS DATE) print_date FROM (SELECT CONVERT(NVARCHAR,MC.Pro_ID)+'-'+(CASE WHEN LEN(CONVERT(NUMERIC,max(Series_Order))) = 1 THEN  '0' + CONVERT(NVARCHAR,max(Series_Order)) ELSE CONVERT(NVARCHAR,max(Series_Order)) END) + '-' + (CASE WHEN LEN(CONVERT(NUMERIC,min(Series_Serial))) = 1 THEN  '000' + CONVERT(NVARCHAR,min(Series_Serial)) WHEN LEN(CONVERT(NUMERIC,min(Series_Serial))) = 2 THEN  '00' + CONVERT(NVARCHAR,min(Series_Serial)) WHEN LEN(CONVERT(NUMERIC,min(Series_Serial))) = 3 THEN  '0' + CONVERT(NVARCHAR,min(Series_Serial)) ELSE CONVERT(NVARCHAR,min(Series_Serial)) END) AS SerFr," +
                   " CONVERT(NVARCHAR,MC.Pro_ID)+'-'+(CASE WHEN LEN(CONVERT(NUMERIC,max(Series_Order))) = 1 THEN  '0' + CONVERT(NVARCHAR,max(Series_Order)) ELSE CONVERT(NVARCHAR,max(Series_Order)) END) + '-' + (CASE WHEN LEN(CONVERT(NUMERIC,max(Series_Serial))) = 1 THEN  '000' + CONVERT(NVARCHAR,max(Series_Serial)) WHEN LEN(CONVERT(NUMERIC,max(Series_Serial))) = 2 THEN  '00' + CONVERT(NVARCHAR,max(Series_Serial)) WHEN LEN(CONVERT(NUMERIC,max(Series_Serial))) = 3 THEN  '0' + CONVERT(NVARCHAR,max(Series_Serial)) ELSE CONVERT(NVARCHAR,max(Series_Serial)) END) AS SerTo, " +
               " COUNT(MC.Row_ID) AS Codes,isnull(B.Display_Series,MC.Pro_ID) Pro_ID,MC.Pro_ID+'*'+ convert(nvarchar,CAST(Print_Date AS DATE),105)+'*'+LabelRequestId as DownFl,(SELECT  Comp_Name FROM Comp_Reg WHERE Comp_ID=(SELECT  Comp_ID FROM Pro_Reg WHERE Pro_ID=MC.Pro_ID)) AS Comp_Name ,(Select Pro_Name from Pro_Reg where Pro_ID = MC.Pro_ID) as Pro_Name,CAST(Print_Date AS DATE) Print_Date FROM M_Code MC left join Pro_Reg B on MC.Pro_ID = B.Pro_ID WHERE [Use_Type]='L' " + strAll + " GROUP BY MC.Pro_ID,B.Display_Series  ,CAST(Print_Date AS DATE),LabelRequestId) A GROUP BY SerFr,SerTo, A.pro_id,DownFl, Comp_Name,Pro_Name, Cast(print_date AS DATE)  ORDER BY ID DESC";
            }
        }
        DataSet ds = new DataSet();
        try
        {

            //ds = SQL_DB.ExecuteDataSet(Qry);
            ds = ExecuteNonQueryAndDatatable.getfilterdata(Qry);
        }
        catch (Exception)
        {


        }

        daresult = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return daresult;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string compname()
    {
        string result = "";
        result = SQL_DB.ExecuteScalar("SELECT [Comp_Name] FROM [Comp_Reg] where [Comp_ID] = '" + Session["CompanyId"].ToString() + "'").ToString();
        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string downloadcodelabelprint(string chkselect)
    {
        string result = "";
        //title="Select"
        if (chkselect == null || chkselect == "undefined")
        {
            result = "Please select checkbox for download !";
        }
        else
        {
            //CreateFolderToZipDownload();
            string[] Check1 = chkselect.Split(',');
            string b = "";
            for (int i = 0; i < Check1.Count(); i++)
            {
                b += Check1[i].ToString() + ",";
            }
            if (b != "")
                b = b.ToString().Substring(0, b.Length - 1);

            //ZipCompressor.CreateFolderToZipDownloadLic(Server.MapPath("Excel"), b); // this code for is Microsoft lib
            //Compressor.CreateFolderToZipDownloadNewlic(Server.MapPath("Excel"), b); // this code self is Microsoft lib
            //*************** Comments ddl not support ***************//
            string Paths = Server.MapPath("../Data");
            Paths = Paths + "\\Excel";
            ZipCreate.MyZipClass.ZipLicCreate(Paths, b);   // this code self is Ionic.dll lib

            string path = ""; string FileName = "";
            string[] Check12 = b.ToString().Split(',');
            if (Check12.Length > 1)
                FileName = "ExcelSheets.zip";
            else
            {
                string[] b12 = Check12[0].Split('*');
                FileName = b12[0].ToString() + "-" + b12[2].ToString() + ".zip";
            }
            path = Paths + "\\" + FileName;

            FileInfo myfile = new FileInfo(path);

            if (myfile.Exists)
            {
                HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                HttpContext.Current.Response.ClearContent();
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ContentType = "application/zip";
                HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment; filename=" + FileName);// + filename);
                HttpContext.Current.Response.TransmitFile(myfile.FullName);
                HttpContext.Current.Response.End();

            }

            result = "File downloaded successfully !";
        }
        return result;
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getddlNoofCodes()
    {
        string daresult = "";
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT PrintBunchofCode,CONVERT(VARCHAR,PrintBunchofCode) as PP FROM (SELECT distinct COUNT(m.Row_ID) AS PrintBunchofCode FROM dbo.M_Code m  WHERE m.[Use_Type] != 'L' GROUP BY m.Use_Type,m.Print_Date,m.[Pro_ID]  )  R ORDER BY R.PrintBunchofCode");
        daresult = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return daresult;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getdemoprintlabel(string status, string noofcode, string fromdate, string todate, string code)
    {
        string daresult = "";
        string CodePacket = "";
        if (noofcode == "0")
            CodePacket = "";
        else
            CodePacket = "having COUNT(m.Row_ID) = " + noofcode;

        string strAll = " and m.Use_Type like '%" + code.Trim() + "%'"; string stat = "";

        if (status == "--Status--")
            stat = null;
        else
            stat = status;
        if (fromdate != "" && todate != "")
            strAll += "   AND Print_Date >='" + Convert.ToDateTime(fromdate).ToString("yyyy/MM/dd") + "' AND Print_Date <='" + Convert.ToDateTime(todate).ToString("yyyy/MM/dd") + "'";

        else if (fromdate != "" && todate == "")
            strAll += "    AND Print_Date >='" + Convert.ToDateTime(fromdate).ToString("yyyy/MM/dd") + "' AND Print_Date <='" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "'";
        else if (fromdate == "" && todate != "")
            strAll += "    AND Print_Date >='" + Convert.ToDateTime("1900/01/01").ToString("yyyy/MM/dd") + "' AND Print_Date <='" + Convert.ToDateTime(todate).ToString("yyyy/MM/dd") + "'";
        if (strAll == "")
            strAll += "  AND  ('' ='" + stat + "' OR " + Business9420.function9420.FindQry() + "='" + stat + "')";
        else
        {
            if (stat != "")
                strAll += " AND ('' ='" + stat + "' OR " + Business9420.function9420.FindQry() + "='" + stat + "')";
        }
        DataSet ds = Business9420.function9420.FillDataDemoGridNew(strAll, CodePacket);
        daresult = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return daresult;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getavilablecodes()
    {
        string result = "";
        result = Business9420.function9420.FindAvlDemoCode();
        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string addlabelpacket(string numcode, string numpackage)
    {
        string result = "";
        Business9420.Object9420 Reg = new Object9420();
        Reg.NoofCodes = Convert.ToInt32(numcode.Trim());
        HttpContext.Current.Session["CNT"] = Reg.NoofCodes;
        Reg.Print_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now);
        DataSet ds1 = new DataSet();
        for (int i = 0; i < Convert.ToInt32(numpackage); i++)
        {
            string PacketNo = "";
        CHK:
            {
                Random rnd = new Random();
                PacketNo = Convert.ToString(rnd.Next(1000000, 9999999));
                Reg.Use_Type = PacketNo;
                if (Business9420.function9420.CheckPacketNo(Reg))
                    goto CHK;
            }
            Business9420.function9420.PrintsInM_CodeUpdate(Reg);
            //************** Download Excel File And Save *****************
            downloadDemo(Convert.ToString(Business9420.function9420.MyRegistrationExccelDemo(Reg)), Reg.Use_Type);
            //************** Download Excel File And End Save *****************
        }
        result = "Code printed successfully !";
        return result;
    }
    public void downloadDemo(string qry, string Package)
    {
        Object9420 RegExccel = new Object9420();
        RegExccel.Use_Type = Package.ToString();
        string path = HttpContext.Current.Server.MapPath("");
        path = path + "\\" + "Excel";
        DataProvider.Utility.CreateDirectory(path);
        string DirectoryName = path + "\\" + DataProvider.LocalDateTime.Now.ToString("dd-MM-yyyy");
        DataProvider.Utility.CreateDirectory(DirectoryName);
        string DirectoryNameN = DirectoryName + "\\Demo";
        DataProvider.Utility.CreateDirectory(DirectoryNameN);
        DataProvider.Utility.DeleteFiles(DirectoryNameN + "\\" + RegExccel.Use_Type + ".xls");
        DataSet ds_rpt = new DataSet();
        SQL_DB.GetDA(qry).Fill(ds_rpt, "1");
        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter hw = new HtmlTextWriter(sw))
            {
                StreamWriter writer = File.AppendText(DirectoryNameN + "\\" + RegExccel.Use_Type.ToString() + ".xls");
                FileInfo fileInfo = new FileInfo(DirectoryNameN + "\\" + RegExccel.Use_Type.ToString() + ".xls");
                fileInfo.IsReadOnly = true;
                DataGrid gvDetails = new DataGrid();
                gvDetails.DataSource = ds_rpt.Tables["1"];
                gvDetails.DataBind();
                gvDetails.RenderControl(hw);
                writer.WriteLine(sw.ToString());
                writer.Close();
            }
        }
    }



    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string filldemoalocation(string Company, string fromdate, string todate, string Persion)
    {
        string result = "";
        string StrAll = "";
        if (fromdate != "" && todate != "")
            StrAll = "   WHERE Comp_Name LIKE '%" + Company.Trim().Replace("'", "''") + "%' AND Contact_Name LIKE '%" + Persion.Trim().Replace("'", "''") + "%' AND   CONVERT(nvarchar, Entry_Date, 111) >= '" + Convert.ToDateTime(fromdate).ToString("yyyy/MM/dd") + "' AND CONVERT(nvarchar, Entry_Date, 111) <= '" + Convert.ToDateTime(todate).ToString("yyyy/MM/dd") + "'";
        else if (fromdate == "" && todate != "")
            StrAll = "   WHERE Comp_Name LIKE '%" + Company.Trim().Replace("'", "''") + "%'  AND Contact_Name LIKE '%" + Persion.Trim().Replace("'", "''") + "%' AND   CONVERT(nvarchar,Entry_Date, 111) <= '" + Convert.ToDateTime(todate).ToString("yyyy/MM/dd") + "'";
        else if (fromdate != "" && todate == "")
            StrAll = "   WHERE  Comp_Name LIKE '%" + Company.Trim().Replace("'", "''") + "%'  AND Contact_Name LIKE '%" + Persion.Trim().Replace("'", "''") + "%' AND  CONVERT(nvarchar, Entry_Date, 111) >= '" + Convert.ToDateTime(fromdate).ToString("yyyy/MM/dd") + "'";
        else
            StrAll = "   WHERE  Comp_Name LIKE '%" + Company.Trim().Replace("'", "''") + "%'  AND Contact_Name LIKE '%" + Persion.Trim().Replace("'", "''") + "%'";
        DataSet ds = Business9420.function9420.FillDataDemoGridDemo(StrAll);
        result = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string chkemail(string email)
    {
        string result = "";
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Comp_Email] FROM [Comp_Reg] where [Comp_Email] = '" + email + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            result = "Email alredy registered !";
        }
        else
        {

        }
        return result;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getpackagetype()
    {
        string result = "";
        DataSet ds = new DataSet();
        ds = SQL_DB.ExecuteDataSet("select convert(nvarchar,bunchCode) as bunchCode, convert(nvarchar,row_number() over(order by bunchCode))+'-'+ convert(nvarchar, count(bunchCode)) as totalCount from vw_bunch_code group by bunchCode"); //Business9420.function9420.FillddlDemoAll();        
        result = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return result;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getpacketbytypeid(string bunchCode)
    {
        string result = "";
        DataSet ds = new DataSet();
        ds = SQL_DB.ExecuteDataSet("select bunchCode,Use_Type as Packet_Name from vw_bunch_code WHERE bunchCode = '" + bunchCode + "'");
        result = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return result;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string submitalocation(string email, string comp, string person, string mbile, string pkgtype, string packet)
    {
        string result = "";
        Object9420 Reg = new Object9420();
        Reg.Comp_Email = email.Trim().Replace("'", "''");
        Reg.Comp_Name = comp.Trim().Replace("'", "''");
        Reg.Contact_Person = person.Trim().Replace("'", "''");
        Reg.Mobile_No = mbile.Trim().Replace("'", "''");
        Reg.NoofCodes = Convert.ToInt32(pkgtype.ToString());
        Reg.Use_Type = packet.Trim(); //Business9420.function9420.FindPack(Reg);
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now);
        Business9420.function9420.InsertAllocatedCodesForDemo(Reg);


        string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                 //  " <div class='w_logo'><img src='http://vcqru.com/images/logo.png' alt='logo' /></div>" +
                 " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
                   " <hr style='border:1px solid #2587D5;'/>" +
                   " <div class='w_frame'>" +
                   " <p>" +
                   " <div class='w_detail'>" +
                   " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
                   " <br /> Thank you for choosing VCQRU.COM Your details are as follows:-<br />" +
                   " <table border='0' cellspacing='2'>" +
                   " <tr>" +
                   " <td width='150' align='right'><strong>account Type :&nbsp; </strong></td>" +
                   " <td width='282'>Demo</td>" +
                   " </tr>" +
                   " <tr>" +
                   " <td align='right' valign='top'><strong>Packet secret Code :&nbsp;</strong></td>" +
                   " <td>" + Reg.Use_Type + "</td>" +
                   " </tr>" +
                   " <tr>" +
                   " <td align='right' valign='top'><strong>Codes in packet :&nbsp;</strong></td>" +
                   " <td>" + Reg.NoofCodes + "</td>" +
                   " </tr>" +
                   " </table>" +
                   " <p>" +
                   " <div class='w_detail'>" +
                   " Assuring you  of  our best services always.<br />" +
                   " Thank you,<br /><br />" +
                   " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                   "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                   " </div>" +
                   " </p>" +
                   " </div>" +
                   " </p>" +
                   " </div> " +
                   " </div> ";

        DataSet dsMl = function9420.FetchMailDetail("admin");
        if (dsMl.Tables[0].Rows.Count > 0)
            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Company Demo Registration");

        return result = "Packet secret code send successfully !";

    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getdailyallocation(string comp, string from, string to)
    {
        string result = "";
        string NewQry = "";
        string DateFrom = "1900/01/01"; string DateTo = DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd");
        string StrAll = " WHERE  Comp_Name  LIKE '%" + comp.Trim().Replace("'", "''") + "%'";
        if (from != "" && to == "")
        {
            DateFrom = Convert.ToDateTime(from).ToString();
            StrAll += " AND CONVERT(VARCHAR,Allot_Date,111) >=" + Convert.ToDateTime(DateFrom).ToString("yyyy/MM/dd");
            //NewQry = " AND CONVERT(VARCHAR,M_Code_1.Allot_Date,111) >=" + Convert.ToDateTime(DateFrom).ToString("yyyy/MM/dd");
        }
        else if (from == "" && to != "")
        {
            DateFrom = Convert.ToDateTime(from).ToString();
            DateTo = Convert.ToDateTime(to).ToString();
            StrAll += "  AND CONVERT(VARCHAR,Allot_Date,111) >='" + Convert.ToDateTime(DateFrom).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,Allot_Date,111) <='" + Convert.ToDateTime(DateTo).ToString("yyyy/MM/dd") + "'";
            //NewQry = "  AND CONVERT(VARCHAR,M_Code_1.Allot_Date,111) >='" + Convert.ToDateTime(DateFrom).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,M_Code_1.Allot_Date,111) <='" + Convert.ToDateTime(DateTo).ToString("yyyy/MM/dd") + "'";
        }
        else if (from != "" && to != "")
        {
            DateFrom = Convert.ToDateTime(from).ToString();
            DateTo = Convert.ToDateTime(to).ToString();
            StrAll += "  AND CONVERT(VARCHAR,Allot_Date,111) >='" + Convert.ToDateTime(DateFrom).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,Allot_Date,111) <='" + Convert.ToDateTime(DateTo).ToString("yyyy/MM/dd") + "'";
            //NewQry = "  AND CONVERT(VARCHAR,M_Code_1.Allot_Date,111) >='" + Convert.ToDateTime(DateFrom).ToString("yyyy/MM/dd") + "' AND CONVERT(VARCHAR,M_Code_1.Allot_Date,111) <='" + Convert.ToDateTime(DateTo).ToString("yyyy/MM/dd") + "'";
        }
        DataSet ds = Business9420.function9420.FindFillGridDataSearch(StrAll);
        result = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return result;
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getproductwisedetails(string comp, string date)
    {
        string result = "";
        string NewQry = "";
        Object9420 obj = new Object9420();
        obj.Comp_ID = comp;
        obj.Contact_Person = date;
        NewQry = " AND CONVERT(VARCHAR,M_Code_1.Allot_Date,111) = '" + Convert.ToDateTime(obj.Contact_Person).ToString("yyyy/MM/dd") + "'";
        DataSet dsProd = function9420.fetchProductCodeDailyCodesUses(obj, NewQry);
        result = DataTableToJSONWithJavaScriptSerializer(dsProd.Tables[0]);
        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getcodeusedofcompany(string company, string comptype)
    {
        string result = "";
        Object9420 Reg = new Object9420();
        Reg.Comp_Name = company.Trim().Replace("'", "''");
        Reg.Comp_type = comptype;
        DataSet ds = Business9420.function9420.FindCodesUsesDataSearch(Reg);
        result = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return result;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getcodeuseddetails(string comp)
    {
        string result = "";
        Object9420 obj = new Object9420();
        obj.Comp_ID = comp;
        DataSet dsProd = function9420.fetchProductCodeDT(obj);
        result = DataTableToJSONWithJavaScriptSerializer(dsProd.Tables[0]);
        return result;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getlabeldatarecord(string lblid)
    {
        string result = "";
        Object9420 Reg = new Object9420();
        Reg.Courier_Disp_ID = lblid;
        DataSet dsn12 = Business9420.function9420.FillScrapEntryCourier(Reg);
        result = DataTableToJSONWithJavaScriptSerializer(dsn12.Tables[0]);
        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getlabels(string label)
    {
        string result = "";
        Object9420 Reg = new Object9420();
        Reg.Label_Name = label.Trim().Replace("'", "''");
        DataSet ds = function9420.FillGridLabel(Reg);
        result = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string checkNewLabel(string res)
    {
        string result = "";
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Label_Name] FROM [M_Label] where [Label_Name] = '" + res + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            result = "Label Name Aleredy Exist";
        }
        else
        {
        }
        return result;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string editlabel(string lblid)
    {
        string result = "";
        Object9420 Reg = new Object9420();
        Reg.Label_Code = lblid;
        DataSet ds = function9420.FillLabelInfo(lblid);
        result = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string actionlabel(string lblid)
    {
        string result = "";
        Object9420 Reg = new Object9420();
        Reg.Label_Code = lblid;
        function9420.UpdateLabelFlag(Reg);
        result = "update";
        return result;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string labelpricedetails(string lblid)
    {
        string result = "";
        Object9420 Reg = new Object9420();
        Reg.Label_Code = lblid;
        DataSet ds = function9420.FillLabelPriseInfo(Reg);
        result = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return result;
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string Updatelabelprice(string lblid, string price)
    {
        string result = "Updated";
        Object9420 Reg = new Object9420();
        Reg.Label_Prise = Convert.ToDouble(price);
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        Reg.Label_Code = lblid;
        function9420.UpdateLabel(Reg);
        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string savelabel(string price, string name, string width, string height, string img)
    {
        string result = "";
        Object9420 Reg = new Object9420();
        Reg.Label_Prise = Convert.ToDouble(price);
        Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        Reg.Label_Code = function9420.GetLabelCode("Label");
        string[] ext = img.Split('.');
        Reg.Label_Image = Reg.Label_Code + "." + ext[1];
        Reg.Label_Name = name.Trim().Replace("'", "''");
        Reg.Label_Size = width.Trim().Replace("'", "''") + " X " + height.Trim().Replace("'", "''");
        Reg.Flag = 1;
        function9420.SaveLabel(Reg);
        result = Reg.Label_Code;
        return result;
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string FillGridstatusProducts(string comp, string comppro, string status)
    {
        string result = "";
        Business9420.Object9420 Reg = new Business9420.Object9420();
        bool flag = true;
        string strcomp = ""; string strproid = ""; string chk = null;
        if (comp == null)//== "--Select Company--")
            strcomp = null;
        else
            strcomp = comp;

        if (Convert.ToInt32(status) == 0) //.SelectedValue == "--All--")
            chk = " AND ISNULL(Use_Count,0) = ISNULL(Use_Count,0)";
        else if (Convert.ToInt32(status) == 1)
            chk = " AND ISNULL(Use_Count,0) != 0";
        else if (Convert.ToInt32(status) == 2)
            chk = " AND ISNULL(Use_Count,0) = 0";
        if (comppro == null) //"--Select Product--")
        {
            flag = false;
            strproid = null;
        }
        else
        {
            strproid = comppro;
            flag = true;
        }
        Reg.Password = chk;
        Reg.Comp_ID = strcomp;
        Reg.Pro_ID = strproid;
        DataSet ds = Business9420.function9420.FillGidProductsWiseDetails(Reg, flag);
        result = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return result;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getcategory()
    {
        string result = "";
        DataSet ds = new DataSet();
        ds = function9420.FillddlCat();
        result = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return result;
    }


    #region Company Registration

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getregisteredcompany(string company, string category, string status, string comptype, string from, string to, string all, string active, string Dactive, string delete)
    {
        if (comptype == "null")
        {
            comptype = "0";
        }
        string result = "";
        DataSet ds = new DataSet();
        string Cat_Id = ""; string SStatus = ""; string Qty = ""; string typecmp = "", IsRetailer = "";
        if (category != "--Select Category --" && category != "null")
            Cat_Id = category;
        else
            Cat_Id = "0";
        if (status != "--Status--")
            SStatus = status;
        else
            SStatus = "Status";
        if (comptype == "0")
            typecmp = "Comp_Type";
        else
        {
            if (comptype == "R")
            {
                IsRetailer = " AND IsRetailer = 1";
                typecmp = "'D'";
            }
            else
            {
                IsRetailer = " AND IsRetailer = 0";
                typecmp = "'" + comptype + "'";
            }
        }
        string strfrom = ""; string strto = "";
        if (from != "")
            strfrom = Convert.ToString(Convert.ToDateTime(from).ToString("yyyy/MM/dd"));
        else
            strfrom = "1900/01/01";
        if (to != "")
            strto = Convert.ToString(Convert.ToDateTime(to).ToString("yyyy/MM/dd"));
        else
            strto = DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd");
        Qty = "SELECT IsRetailer,Comp_ID, Comp_Name, (SELECT Cat_Name FROM M_Category WHERE Cat_Id=Comp_Reg.Comp_Cat_Id ) as Comp_Type, Comp_Email, " +
                "WebSite, Address, (SELECT Country_Name FROM M_Country WHERE Country_ID = (SELECT [COUNTRY_ID] FROM [StateMaster] WHERE [STATE_ID] = " +
                " (SELECT [State_id] FROM [CityMaster] WHERE [CITY_ID] = Comp_Reg.City_ID))) AS Country_Name, Contact_Person, Mobile_No, Phone_No, Fax, Reg_Date, " +
                " Password, Status, " +
        " Email_Vari_Flag, Update_Flag, " +
        "(case when Comp_Type = 'D' then 8 else isnull((SELECT Count(Flag) Flag FROM Comp_Doc_Flag WHERE (Comp_ID = Comp_Reg.Comp_ID) AND Flag = 1),0)end) as Doc_Flag, " +
        "ISNULL((SELECT Count([Row_ID]) FROM [Comp_Document] WHERE [Comp_ID]=Comp_Reg.Comp_ID),0) as Doc_Flag1, " +
        " '../Data/Sound/' + SUBSTRING(Comp_ID, 6, 4) + '/' + SUBSTRING(Comp_ID, 6, 4) + '.mp3' AS SoundPath,Password,Comp_Type as TypeCmp,Password " +
        " FROM Comp_Reg WHERE  (''=" + Cat_Id + " or Comp_Cat_Id=" + Cat_Id + ") and Status=" + SStatus + " and Comp_Type = " + typecmp + "" + IsRetailer +
        " and ('' like '%" + company.Trim().Replace("'", "''") + "%' or Comp_Name like '%" + company.Trim().Replace("'", "''") + "%') ";
        if (from == "" && to == "")
            Qty += "";
        else if (from != "" && to == "")
            Qty += " and Convert(varchar,Comp_Reg.Reg_Date,111) >= '" + strfrom + "' ";
        else if (from == "" && to != "")
            Qty += " and Convert(varchar,Comp_Reg.Reg_Date,111) <= '" + strto + "' ";
        else if (from != "" && to != "")
            Qty += " and Convert(varchar,Comp_Reg.Reg_Date,111) >= '" + strfrom + "'and Convert(varchar,Comp_Reg.Reg_Date,111) <= '" + strto + "' ";
        if (all == "1")
            Qty += "";
        else if (delete == "1")
            Qty += " AND Delete_Flag = 0 ";
        else if (active == "1")
            Qty += " AND Delete_Flag = 1 AND Status = 1 ";
        else if (Dactive == "1")
            Qty += " AND Delete_Flag = 1 AND Status = 0 ";
        Qty += " order by Comp_Reg.Reg_Date desc ";
        SQL_DB.GetDA(Qty).Fill(ds, "1");
        result = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getcomppro(string compid, string strType)
    {
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        Object9420 obj = new Object9420();
        obj.Comp_ID = compid;
        string result = "";
        if (strType == "product")
        {
            obj.Pro_Name = "";
            ds = function9420.FetchSearchData(obj);
            result = DataTableToJSONWithJavaScriptSerializer(ds.Tables[0]);
        }
        else if (strType == "doc")
        {

            dt = ExecuteNonQueryAndDatatable.FillDocumentData(obj);
            result = DataTableToJSONWithJavaScriptSerializer(dt);
        }
        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public DataRow getproductamc(string proid)
    //{
    //    string result = "";
    //    string result1 = "";
    //    string result2 = "";
    //    string compid = Convert.ToString(SQL_DB.ExecuteScalar("SELECT Comp_ID FROM Pro_Reg WHERE  Pro_ID='" + proid + "'"));
    //    Object9420 Amc = new Object9420();
    //    Amc.Pro_ID = proid;
    //    Amc.Comp_ID = compid;
    //    Amc.Amt_Type = "AMC";
    //    DataSet dsset = SQL_DB.ExecuteDataSet("SELECT Amc_Offer_ID,Plan_ID,Plan_Amount,Plan_Discount,Date_From,Date_To,isnull(Status,0) as Status FROM M_Amc_Offer WHERE Amc_Offer_ID = (SELECT Max(Amc_Offer_ID) FROM M_Amc_Offer WHERE Pro_Id = '" + Amc.Pro_ID + "' AND Trans_Type = '" + Amc.Amt_Type + "' )");
    //    DataSet dsamc = function9420.FillGridPlan(Amc);
    //    //DataSet ds = function9420.FillGridPlan(i);
    //    DataView dv = dsamc.Tables[0].DefaultView;
    //    dv.RowFilter = "Flag = 1";
    //    DataTable dt = dv.ToTable();
    //    DataRow DR = new DataRow();
    //    //DR=dsset.Tables[0];
    //}
    public string getproductamc(string proid)
    {
        string result = "";
        string result1 = "";
        string result2 = "";
        string compid = Convert.ToString(SQL_DB.ExecuteScalar("SELECT Comp_ID FROM Pro_Reg WHERE  Pro_ID='" + proid + "'"));
        Object9420 Amc = new Object9420();
        Amc.Pro_ID = proid;
        Amc.Comp_ID = compid;
        Amc.Amt_Type = "AMC";
        DataSet dsset = SQL_DB.ExecuteDataSet("SELECT Amc_Offer_ID,Plan_ID,Plan_Amount,Plan_Discount,Date_From,Date_To,isnull(Status,0) as Status FROM M_Amc_Offer WHERE Amc_Offer_ID = (SELECT Max(Amc_Offer_ID) FROM M_Amc_Offer WHERE Pro_Id = '" + Amc.Pro_ID + "' AND Trans_Type = '" + Amc.Amt_Type + "' )");
        DataSet dsamc = function9420.FillGridPlan(Amc);
        //DataSet ds = function9420.FillGridPlan(i);
        DataView dv = dsamc.Tables[0].DefaultView;
        dv.RowFilter = "Flag = 1";
        DataTable dt = dv.ToTable();
        if (dsset.Tables[0].Rows.Count > 0)
        {
            result1 = DataTableToJSONWithJavaScriptSerializer(dsset.Tables[0]);
        }
        result2 = DataTableToJSONWithJavaScriptSerializer(dt);
        result = result2 + '#' + result1;
        return result;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void getCompDocVerify(string[] list, string[] listName, string[] listComments, string compid, string strtype)//,string  compid,string strtype
    {
        string[] mylist = list;
        string str = "";
        string docFlagid = string.Empty;
        //bool blnflag = false;
        string strFlag = "0";
        if (strtype == "Verify")
        {
            //blnflag = true;
            strFlag = "1";
        }
        else if (strtype == "Reject")
        {
            strFlag = "-1";
        }
        if (mylist.Length > 0)
        {
            for (int i = 0; i < mylist.Length; i++)
            {
                // if (list[i].Length > 0)
                // {
                docFlagid = mylist[i];
                string docremarks = listComments[i];
                SQL_DB.ExecuteNonQuery("UPDATE [Comp_Doc_Flag]  SET  remarks = '" + docremarks + "' ,flag= '" + strFlag + "' WHERE Row_ID  = " + docFlagid + "  ");
                str = str + "," + mylist[i];
                // }
            }
        }
        str = str.TrimStart(',').TrimEnd(',');
        DataSet ds = ExecuteNonQueryAndDatatable.Proc_VerifyDoc(compid, str);
        DataTable dt = ds.Tables[0];
        DataTable dtComp_Reg = ds.Tables[1];
        string strComments = string.Empty;
        // DataTable dtComp_DocFlagVerify = ds.Tables[2];
        //  DataTable dtComp_DocFlagReject = ds.Tables[3];
        if (dt.Rows.Count > 0)
        {
            //if (Convert.ToInt16(dt.Rows[0][0].ToString()) < 7) // check all doc is verified or not
            {
                DataSet dsMl = function9420.FetchMailDetail("admin");
                if (dsMl.Tables[0].Rows.Count > 0)
                {
                    if (dtComp_Reg.Rows.Count > 0)
                    {

                        string strcomp_Name = dtComp_Reg.Rows[0]["Comp_Name"].ToString();
                        string strcomp_Email = dtComp_Reg.Rows[0]["Comp_Email"].ToString();

                        string MailBody = DataProvider.Utility.FindMailBody() + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                          " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/content/images/logo.png' alt='logo' /></div>" +
                          " <hr style='border:1px solid #2587D5;'/>" +
                          " <div class='w_frame'>" +
                          " <p>" +
                          " <div class='w_detail'>" +
                          " <span>Dear <em><strong>" + dtComp_Reg.Rows[0]["Contact_Person"].ToString() + ",</strong></em></span><br />" +
                          " <br />";
                        //  " <br /> Your documents <b>" +dt.Rows[0][0].ToString() + "</b> are rejected by the admin. <br />" +
                        //  " <br /> Reason of <b>" + txtCancelRemarks.Text.Trim().Replace("'", "''") + " </b>" +
                        if (strtype == "Verify")
                        {

                            MailBody = MailBody + " <br /> Your documents are verified by the admin. Please wait untill your company account gets activated. <br />" +
                                     "  Your account will be activated shortly . please wait . ";
                            MailBody = MailBody + " <br /> <br /> Following documents are verified  <br /><br />";
                            for (int i = 0; i < listName.Length; i++)
                            {
                                strComments = listComments[i];// " (" + listComments[i] + ")
                                if (!string.IsNullOrEmpty(strComments))
                                {
                                    strComments = " (" + listComments[i] + ")";
                                }
                                MailBody = MailBody + listName[i] + strComments + "<br/> ";
                            }
                        }
                        else if (strtype == "Reject")
                        {

                            MailBody = MailBody + " <br /> Your documents are Rejected by the admin. <br />" +
                              " <br /> Please fill complete details in <b> 'Company Profile' and 'Manage Company Document to verify documents. </b> ";
                            MailBody = MailBody + " <br />  <br />Following documents are rejected <br /> <br />";
                            for (int i = 0; i < listName.Length; i++)
                            {
                                strComments = listComments[i];// " (" + listComments[i] + ")
                                if (!string.IsNullOrEmpty(strComments))
                                {
                                    strComments = " (" + listComments[i] + ")";
                                }
                                MailBody = MailBody + listName[i] + strComments + "<br/> ";
                            }
                            //MailBody = MailBody + "Following Documents Rejected <br/> ";
                        }

                        MailBody = MailBody + " <p>" +
                        " <div class='w_detail'>" +
                        // " <span style='color:blue;' >Please upload correct documents again.</span><br />" +
                        " Assuring you  of  our best services always.<br />" +
                        " Thank you,<br /><br />" +
                        " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                        "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                        " </div>" +
                        " </p>" +
                        " </div>" +
                        " </p>" +
                        " </div> " +
                        " </div> ";

                        if (strtype == "Verify")
                        {

                            string MailBody1 = DataProvider.Utility.FindMailBody(strcomp_Name, "Sales department", "documents has been verified successfully.");
                            string MailBody2 = DataProvider.Utility.FindMailBody(strcomp_Name, "Lagal department", "documents has been verified successfully.");
                            if (dsMl.Tables[0].Rows.Count > 0)
                            {
                                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), strcomp_Email, MailBody, "Document verified");
                                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Document verified");
                                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Legal_accomplishtrades, MailBody1, "Document verified");
                            }

                        }
                        else if (strtype == "Reject")
                        {

                            string MailBody1 = DataProvider.Utility.FindMailBody(strcomp_Name, "Sales department", "documents has been rejected successfully.");
                            string MailBody2 = DataProvider.Utility.FindMailBody(strcomp_Name, "Lagal department", "documents has been rejected successfully.");

                            if (dsMl.Tables[0].Rows.Count > 0)
                            {
                                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), strcomp_Email, MailBody, "Document rejected");
                                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Document rejected");
                                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Legal_accomplishtrades, MailBody1, "Document rejected");
                            }
                        }



                        //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), strcomp_Email, MailBody, "Document rejected");
                        //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Document rejected");
                        //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Legal_accomplishtrades, MailBody1, "Document rejected");
                        //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), "shwetasingh227@gmail.com", MailBody1, "Document rejected");
                        // DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), strcomp_Email, MailBody, "Email Verified");
                        //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), dtComp_Reg.Rows[0]["Comp_Email"].ToString(), MailBody, "Email Verified");
                        //result = "Incomplete documents !not verified.";
                    }
                }
            }

        }
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string CompanyUploadFilr()
    {
        try
        {


            var httpPostedFile = HttpContext.Current.Request.Files["UploadedFile"];
            string strNewFilename = string.Empty; string path = string.Empty;
            HttpPostedFile file = httpPostedFile;
            string compid = Context.Request.Form["comp_id"];
            //string strtxtcc = Context.Request.Form["strtxtcc"];
            //string strtxtbcc = Context.Request.Form["strtxtbcc"];
            string strtxtsubject = Context.Request.Form["strtxtsubject"];
            string strtxtbody = Context.Request.Form["strtxtbody"];
            string result = string.Empty;

            if (SendMailClass.SendMailToCompany(compid, strtxtsubject, strtxtbody, file))
            {
                result = "Mail sent successfully";
            }
            else
            {
                result = "Failed in sending mail";
            }
            return result;
            //if (httpPostedFile != null)
            //{
            //    //if (httpPostedFile != null)
            //    //{
            //    //    string directory = HttpContext.Current.Server.MapPath("~/Data/Sound");
            //    //    directory = directory + "\\" + strComp_id.Substring(5, 4) + "\\Files";
            //    //    // directory = directory + "\\" + "1" + "\\Files";
            //    //    if (!System.IO.Directory.Exists(directory))
            //    //    {
            //    //        System.IO.Directory.CreateDirectory(directory);
            //    //    }

            //    //    strNewFilename = System.IO.Path.GetFileNameWithoutExtension(file.FileName) + DateTime.Now.ToString("MMddyyyyhhmmss");
            //    //    string strGetExtension = System.IO.Path.GetExtension(file.FileName);
            //    //    strNewFilename = strNewFilename.Replace(" ", "") + strGetExtension;
            //    //    path = System.IO.Path.Combine(directory, strNewFilename);
            //    //    file.SaveAs(path);
            //    //}
            //}
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string CompanySendMail(string compid, string strtxtcc, string strtxtbcc, string strtxtsubject, string strtxtbody)
    //  public string CompanySendMail()
    {


        //string result = "Successfully Updated";
        HttpPostedFile file = null;

        if (Context.Request.Files.Count > 0)
        {
            HttpFileCollection files = Context.Request.Files;
            file = files[0];
        }
        //   var httpPostedFile = HttpContext.Current.Request.Files["UploadedFile"];
        string strNewFilename = string.Empty; string path = string.Empty;
        //  HttpPostedFile file = httpPostedFile;
        //string compid = Context.Request.Form["comp_id"];
        ////string strtxtcc = Context.Request.Form["strtxtcc"];
        ////string strtxtbcc = Context.Request.Form["strtxtbcc"];
        //string strtxtsubject = Context.Request.Form["strtxtsubject"];
        //string strtxtbody = Context.Request.Form["strtxtbody"];
        string result = string.Empty;

        if (SendMailClass.SendMailToCompany(compid, strtxtsubject, strtxtbody, file))
        {
            result = "Mail sent successfully";
        }
        else
        {
            result = "Failed in sending mail";
        }
        return result;



    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getGiftByCompany(string strType)
    {
        string result1 = "";
        string strQry = "";
        if (strType == "gift")
        {
            strQry = "SELECT * from [M_Gift] where  isnull(IsActive,1) = 0 and  isnull(Isdelete,1)=0 and comp_id = '" + ProjectSession.strCompanyid + "' ";
        }
        else if (strType == "dealer")
        {
            strQry = "SELECT * from [M_Dealer] where  isnull(IsActive,1) = 0 and comp_id = '" + ProjectSession.strCompanyid + "' ";
        }
        else if (strType == "couriercompany")
        {
            strQry = "SELECT * from [Courier_Master] where  isnull(flag,0) = 1 and User_ID = '" + ProjectSession.strCompanyid + "' ";
        }
        DataSet dsset = SQL_DB.ExecuteDataSet(strQry);
        //        DataSet dsamc = function9420.FillGridPlan(Amc);
        //DataSet ds = function9420.FillGridPlan(i);
        // DataView dv = dsamc.Tables[0].DefaultView;
        // dv.RowFilter = "Flag = 1";
        // DataTable dt = dv.ToTable();
        DataTable dt = dsset.Tables[0];
        if (dsset.Tables[0].Rows.Count > 0)
        {

            result1 = DataTableToJSONWithJavaScriptSerializer(dsset.Tables[0]);
        }
        // result2 = DataTableToJSONWithJavaScriptSerializer(dt);
        // result = result2 + '#' + result1;
        return result1;
    }

    //[WebMethod(EnableSession = true)]
    //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public string DispatchGift(string txtMobile,string ddlstatus,string ddlService)
    //{
    //    string result1 = "";
    //    string strQry = string.Empty;
    //    //        if (Convert.ToInt32(ddlstatus) > 0)
    //    //        {
    //    //            strQry = " and g.Gift_Pkid = " + ddlstatus;
    //    //        }
    //    //        else if (!string.IsNullOrEmpty(txtMobile))
    //    //        {
    //    //            strQry = strQry + " and M.Mobileno = '" + txtMobile + "'";
    //    //        }
    //    //        strQry = strQry + " and MC.M_Consumer_MCodeid not in (select M_Consumer_MCodeid from M_GiftDisptachDealerCourier)";
    //    //        string strtest = "select M.*,G.*,MC.M_Consumer_MCodeid from M_Consumer M inner join M_Consumer_M_Code MC on M.M_Consumerid = MC.M_Consumerid " +
    //    //"inner join M_CodeCouponAssign CA on Mc.M_Codeid = CA.M_CodeID " +
    //    //"inner join M_Gift g on ca.CouponTransID = g.Gift_Pkid where CA.M_CodeID in  (select Row_ID from M_Code where Pro_ID in (select pro_id from Pro_Reg where Comp_ID ='" + ProjectSession.strCompanyid + "'))" + strQry;
    //    // DataSet dsset = SQL_DB.ExecuteDataSet(strtest);
    //    DataSet dsset = ExecuteNonQueryAndDatatable.GetAwardListByCompany(txtMobile, ddlstatus, ProjectSession.strCompanyid, null, "", ddlService);

    //    //        DataSet dsamc = function9420.FillGridPlan(Amc);
    //    //DataSet ds = function9420.FillGridPlan(i);
    //    // DataView dv = dsamc.Tables[0].DefaultView;
    //    // dv.RowFilter = "Flag = 1";
    //    // DataTable dt = dv.ToTable();
    //    DataTable dt = dsset.Tables[0];
    //    if (dsset.Tables[0].Rows.Count > 0)
    //    {

    //        result1 = DataTableToJSONWithJavaScriptSerializer(dsset.Tables[0]);
    //    }
    //    // result2 = DataTableToJSONWithJavaScriptSerializer(dt);
    //    // result = result2 + '#' + result1;
    //    return result1;
    //}

    //[WebMethod(EnableSession = true)]
    //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public string UpdateDispatchGift(string[] Gift_Pkid,string[] Consumer_Pkid,string dealid, string courid, string dispdate, string expdate,string strType,string[] CodeConsumer_Pkid )
    //{
    //    string result1 = "success";

    //    try
    //    {


    //        string[] listGift_Pkid = Gift_Pkid;
    //        string[] listConsumer_Pkid = Consumer_Pkid;
    //        string[] listCodeConsumer_Pkid = CodeConsumer_Pkid;
    //        // string str = "";
    //        string strGift_Pkid = string.Empty;
    //        string strConsumer_Pkid = string.Empty;
    //        string strCodeConsumer_Pkid = string.Empty;
    //        //bool blnflag = false;
    //        //string strFlag = "0";
    //        //if (strtype == "Verify")
    //        //{
    //        //    //blnflag = true;
    //        //    strFlag = "1";
    //        //}
    //        //else if (strtype == "Reject")
    //        //{
    //        //    strFlag = "-1";
    //        //}
    //        if (listGift_Pkid.Length > 0)
    //        {
    //            for (int i = 0; i < listGift_Pkid.Length; i++)
    //            {
    //                // if (list[i].Length > 0)
    //                // {
    //                //strGift_Pkid = listGift_Pkid[i];
    //                strGift_Pkid = strGift_Pkid + "," + listGift_Pkid[i];
    //                strConsumer_Pkid = strConsumer_Pkid + "," + listConsumer_Pkid[i];
    //                strCodeConsumer_Pkid = strCodeConsumer_Pkid + "," + listCodeConsumer_Pkid[i];
    //                //SQL_DB.ExecuteNonQuery("UPDATE [Comp_Doc_Flag]  SET  remarks = '" + docremarks + "' ,flag= '"+strFlag+"' WHERE Row_ID  = " + docFlagid + "  ");

    //                // }
    //            }
    //        }
    //        strGift_Pkid = strGift_Pkid.TrimStart(',').TrimEnd(',');
    //        strConsumer_Pkid = strConsumer_Pkid.TrimStart(',').TrimEnd(',');
    //        strCodeConsumer_Pkid = strCodeConsumer_Pkid.TrimStart(',').TrimEnd(',');
    //        if (strType == "dealer")
    //        {
    //            ExecuteNonQueryAndDatatable.Proc_InsUpdtGiftDispatch(strGift_Pkid,strConsumer_Pkid,strType,Convert.ToInt32(dealid),null,null,ProjectSession.strCompanyid,strCodeConsumer_Pkid);
    //        }
    //        else if (strType == "courier")
    //        {
    //            ExecuteNonQueryAndDatatable.Proc_InsUpdtGiftDispatch(strGift_Pkid, strConsumer_Pkid, strType,Convert.ToInt32(courid), Convert.ToDateTime(dispdate), Convert.ToDateTime(expdate),ProjectSession.strCompanyid,strCodeConsumer_Pkid);
    //        }
    //        //   DataSet dsset = SQL_DB.ExecuteDataSet("SELECT * from where  isnull(IsActive,1) = 0 and  isnull(Isdelete,1)=0 and comp_id = '" +  ProjectSession.strCompanyid + "' ");
    //        //        DataSet dsamc = function9420.FillGridPlan(Amc);
    //        //DataSet ds = function9420.FillGridPlan(i);
    //        // DataView dv = dsamc.Tables[0].DefaultView;
    //        // dv.RowFilter = "Flag = 1";
    //        // DataTable dt = dv.ToTable();
    //        //DataTable dt = dsset.Tables[0];
    //        //if (dsset.Tables[0].Rows.Count > 0)
    //        //{

    //        //    result1 = DataTableToJSONWithJavaScriptSerializer(dsset.Tables[0]);
    //        //}
    //        // result2 = DataTableToJSONWithJavaScriptSerializer(dt);
    //        // result = result2 + '#' + result1;
    //        return result1;
    //    }
    //    catch (Exception)
    //    {

    //        return "error";
    //    }
    //}
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string CompanyAccActivate(string compid, int intStatus, string strType)
    {
        Object9420 Reg = new Object9420();
        DataSet dsComp = new DataSet();
        Reg.Comp_ID = compid;
        //  hdncmpidfordel.Value = Reg.Comp_ID;
        dsComp = function9420.FindData(Reg);
        Reg.Comp_Email = dsComp.Tables[0].Rows[0]["Comp_Email"].ToString();
        string result = "Successfully Updated";

        //  int i = Convert.ToInt32(SQL_DB.ExecuteScalar("SELECT STATUS FROM Comp_Reg  WHERE Comp_Id='" + compid + "'"));
        //  if (intStatus == 0)
        //   {
        if (strType == "logincredential")
        {
            string str1 = " <div class='w_detail'>" +
                          " User Id : " + dsComp.Tables[0].Rows[0]["Comp_Email"].ToString() + "<br />" +
                          " Password : " + dsComp.Tables[0].Rows[0]["Password"].ToString() + "<br />" +
                          " </div>";
            result = str1;
        }
        else if (strType == "DeleteRow")
        {

            //  string cstatus = "";
            if (dsComp.Tables[0].Rows[0]["Delete_Flag"].ToString() == "1")
                Reg.Del_Flag = 0;
            else
                Reg.Del_Flag = 1;
            function9420.RegDeleteData(Reg);
        }
        else if (strType == "AccountActiveOrDeActive")
        {
            SQL_DB.ExecuteNonQuery("UPDATE  Comp_Reg SET Status = " + intStatus + " WHERE Comp_Id='" + compid + "'");
            Reg.Contact_Person = dsComp.Tables[0].Rows[0]["Contact_Person"].ToString();
            if (intStatus == 1)
            {
                #region Mail Structure
                string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
               " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
               //  " <div class='w_logo'><img src='ttp://216.104.37.202/uat/images/logo.png' alt='logo' /></div>" +
               " <hr style='border:1px solid #2587D5;'/>" +
               " <div class='w_frame'>" +
               " <p>" +
               " <div class='w_detail'>" +
               " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
               " <br />" +
               " <span>Congratulations !!!</span>" +
               " <br /> Your account has been activated successfully. <br />" +
               " <table border='0' cellspacing='2'>" +
               " <tr>" +
               " <td width='100%' align='left' colspan='2'><strong>(i)&nbsp; Please save the User Id and Password. </strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='100%' align='left' colspan='2'><strong>(ii)&nbsp; You can modify the password in your account after login. </strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='100%' align='left' colspan='2'><strong>(iii)&nbsp; Please register your product particulars after login. </strong></td>" +
               " </tr>" +
               " <tr>" +
               " <td width='100%' align='left' colspan='2'><strong>(iv)&nbsp; During the product registration, you are required to upload your legal document to support your ownership for the product. </strong></td>" +
               " </tr>" +
               " </table>" +
               " <p>" +
               " <div class='w_detail'>" +
               " Assuring you  of  our best services always.<br />" +
               " Thank you,<br /><br />" +
               " Team <em><strong>VCQRU.COM,</strong></em><br />" +
               "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
               " </div>" +
               " </p>" +
               " </div>" +
               " </p>" +
               " </div> " +
               " </div> ";
                #endregion
                string MailBody1 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Sales department", "account has been activated successfully.");
                string MailBody2 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Lagal department", "account has been activated successfully.");
                string MailBody3 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "Account department", "account has been activated successfully.");
                string MailBody4 = DataProvider.Utility.FindMailBody(Reg.Comp_Name, "IT department", "account has been activated successfully.");
                DataSet dsMl = function9420.FetchMailDetail("register");
                if (dsMl.Tables[0].Rows.Count > 0)
                {
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Company Registration Activated");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Company Registration Activated");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Legal_accomplishtrades, MailBody2, "Company Registration Activated");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Finance_accomplishtrades, MailBody3, "Company Registration Activated");
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.it_accomplishtrades, MailBody4, "Company Registration Activated");
                }
            }
            else
            {

                string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
               " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/images/logo.png' alt='logo' /></div>" +
               " <hr style='border:1px solid #2587D5;'/>" +
               " <div class='w_frame'>" +
               " <p>" +
               " <div class='w_detail'>" +
               " <span>Dear <em><strong>" + Reg.Contact_Person + ",</strong></em></span><br />" +
               " <br />Your account has been blocked.<br />" +
               " <br />Please Contact to admin <br />" +
               " <p>" +
               " <div class='w_detail'>" +
               " Assuring you  of  our best services always.<br />" +
               " Thank you,<br /><br />" +
               " Team <em><strong>VCQRU.COM,</strong></em><br />" +
               "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
               //" <strong>Toll Free: 1800 183 9420</strong>" +
               " </div>" +
               " </p>" +
               " </div>" +
               " </p>" +
               " </div> " +
               " </div> ";
                DataSet dsMl = function9420.FetchMailDetail("register");
                if (dsMl.Tables[0].Rows.Count > 0)
                    DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), Reg.Comp_Email, MailBody, "Company Registration De-Activated");
            }
        }
        else if (strType == "VerifyMail")
        {
            DataSet ds = SQL_DB.ExecuteDataSet("select Email_Vari_Flag,Comp_Email,Comp_Name,Contact_Person from Comp_Reg where Comp_ID = '" + compid + "'");
            string ps = "";
            SQL_DB.ExecuteNonQuery("UPDATE [Comp_Reg]  SET  [Email_Vari_Flag] = 1  WHERE [Comp_ID] = '" + compid + "'");
            Random rnd = new Random();
            ps = rnd.Next().ToString().Substring(0, 5);
            SQL_DB.ExecuteNonQuery("UPDATE [Comp_Reg] SET [Password]='" + ps + "' WHERE [Comp_ID]='" + compid + "'");
            #region MailBody
            string MailBody = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
            " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
            " <hr style='border:1px solid #2587D5;'/>" +
            " <div class='w_frame'>" +
            " <p>" +
            " <div class='w_detail'>" +
            " <span>Dear <em><strong>" + ds.Tables[0].Rows[0]["Contact_Person"].ToString() + ",</strong></em></span><br />" +
            " <br />" +
            " <span>Congratulations !!!</span>" +
            " <br />Your login details are as follows:- <br />" +
            " <table border='0' cellspacing='2'>" +
            " <tr>" +
            " <td width='70' align='left'><strong>Login ID :&nbsp; </strong></td>" +
            " <td width='282'><a href='#'>" + ds.Tables[0].Rows[0]["Comp_Email"].ToString() + "</a></td>" +
            " </tr>" +
            " <tr>" +
            " <td align='left' valign='top'><strong>Password :&nbsp;</strong></td>" +
            " <td>" + ps + "</td>" +
            " </tr>" +
            "<tr><td colspan='2'><a href='" + ProjectSession.absoluteSiteBrowseUrl + "/Info/Login.aspx#login' target = '_blank'><strong>CLICK HERE TO LOGIN</strong></a></td></tr>" +
            " </table>" +
            " <tr>" +
            " <td align='left' valign='top' colspan='2'><strong>Please login with above credentials and upload your company documents. Then please wait for our notification on your document verification and account activation <br> If you face any problem in login with above credentials, please feel free to email our support team</strong></td>" +
            " </tr>" +
            " </table>" +
            " <p>" +
            " <div class='w_detail'>" +
            " Assuring you  of  our best services always.<br />" +
            " Thank you,<br /><br />" +
            " Team <em><strong>VCQRU.COM,</strong></em><br />" +
            "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
            " </div>" +
            " </p>" +
            " </div>" +
            " </p>" +
            " </div> " +
            " </div> ";

            string MailBody1 = srt + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
           " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/Content/images/logo.png' alt='logo' /></div>" +
           " <hr style='border:1px solid #2587D5;'/>" +
           " <div class='w_frame'>" +
           " <p>" +
           " <div class='w_detail'>" +
           " <span>Dear <em><strong>, Sales person</strong></em></span><br />" +
           " <br />" +
           "<br/> <strong>" + ds.Tables[0].Rows[0]["Comp_Name"].ToString() + "'s</strong> E-mail verification has been completed. <br/> " +
           " Thank you,<br /><br />" +
           " Team <em><strong>VCQRU.COM,</strong></em><br />" +
           "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
           " </div>" +
           " </p>" +
           " </div>" +
           " </p>" +
           " </div> " +
           " </div> ";

            #endregion
            DataSet dsMl = function9420.FetchMailDetail("admin");
            if (dsMl.Tables[0].Rows.Count > 0)
            {
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ds.Tables[0].Rows[0]["Comp_Email"].ToString(), MailBody, "User login credential");
                DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Company E-mail verification");
            }
        }
        else if (strType == "VerifyDoc")
        {
            DataSet ds = ExecuteNonQueryAndDatatable.Proc_VerifyDoc(compid, "0");
            DataTable dt = ds.Tables[0];
            DataTable dtComp_Reg = ds.Tables[1];

            if (dt.Rows.Count > 0)
            {
                if (Convert.ToInt16(dt.Rows[0][0].ToString()) < 7) // check all doc is verified or not
                {
                    DataSet dsMl = function9420.FetchMailDetail("admin");
                    if (dsMl.Tables[0].Rows.Count > 0)
                    {
                        if (dtComp_Reg.Rows.Count > 0)
                        {

                            string strcomp_Name = dtComp_Reg.Rows[0]["Comp_Name"].ToString();
                            string strcomp_Email = dtComp_Reg.Rows[0]["Comp_Email"].ToString();

                            string MailBody = DataProvider.Utility.FindMailBody() + "<div class='latter' style='border:1px solid #2587D5;padding:5px;'>" +
                              " <div class='w_logo'><img src='" + ProjectSession.absoluteSiteBrowseUrl + "/content/images/logo.png' alt='logo' /></div>" +
                              " <hr style='border:1px solid #2587D5;'/>" +
                              " <div class='w_frame'>" +
                              " <p>" +
                              " <div class='w_detail'>" +
                              " <span>Dear <em><strong>" + dtComp_Reg.Rows[0]["Contact_Person"].ToString() + ",</strong></em></span><br />" +
                              " <br />" +
                             //  " <br /> Your documents <b>" +dt.Rows[0][0].ToString() + "</b> are rejected by the admin. <br />" +
                             //  " <br /> Reason of <b>" + txtCancelRemarks.Text.Trim().Replace("'", "''") + " </b>" +
                             " <br /> Your documents are not verified by the admin. <br />" +
                              " <br /> Please fill complete details in <b> 'Company Profile' and 'Manage Company Document to verify documents. </b> " +
                              " <p>" +
                              " <div class='w_detail'>" +
                              " <span style='color:blue;' >Please upload correct documents again.</span><br />" +
                              " Assuring you  of  our best services always.<br />" +
                              " Thank you,<br /><br />" +
                              " Team <em><strong>VCQRU.COM,</strong></em><br />" +
                              "  " + ProjectSession.sales_accomplishtrades + "  <br />" +
                              " </div>" +
                              " </p>" +
                              " </div>" +
                              " </p>" +
                              " </div> " +
                              " </div> ";

                            string MailBody1 = DataProvider.Utility.FindMailBody(strcomp_Name, "Sales department", "documents has been rejected successfully.");
                            string MailBody2 = DataProvider.Utility.FindMailBody(strcomp_Name, "Lagal department", "documents has been rejected successfully.");


                            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), strcomp_Email, MailBody, "Document rejected");
                            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.sales_accomplishtrades, MailBody1, "Document rejected");
                            DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), ProjectSession.Legal_accomplishtrades, MailBody1, "Document rejected");
                            //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), "shwetasingh227@gmail.com", MailBody1, "Document rejected");
                            // DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), strcomp_Email, MailBody, "Email Verified");
                            //DataProvider.Utility.sendMail(dsMl.Tables[0].Rows[0]["Mail_SMTP"].ToString(), dsMl.Tables[0].Rows[0]["User_Id"].ToString(), dsMl.Tables[0].Rows[0]["MPassword"].ToString(), dtComp_Reg.Rows[0]["Comp_Email"].ToString(), MailBody, "Email Verified");
                            result = "Incomplete documents !not verified.";
                        }
                    }
                }
                //else if (dt.Rows[0][0].ToString() == "7")
                //{
                //    // result = "Documents are verified. Account is activated.";
                //}

            }


        }
        return result;
        //result = "Update Status Are you sure to Activate  <span style='color:blue;' >" + compid + "</span>   Account ?";
        //   }
        //   else if (intStatus == 1)
        //   {
        //    SQL_DB.ExecuteNonQuery("UPDATE  Comp_Reg SET Status = 0 WHERE Comp_Id='" + compid + "'");
        //  result = "Update Status Are you sure to de-Activate  <span style='color:blue;' >" + compid + "</span>  Account ?"; ;
        //  }


        // string compid = Convert.ToString(SQL_DB.ExecuteScalar("SELECT Comp_ID FROM Pro_Reg WHERE  Pro_ID='" + proid + "'"));
        //  Object9420 Amc = new Object9420();
        //  Amc.Pro_ID = proid;
        //  Amc.Comp_ID = compid;
        //  Amc.Amt_Type = "AMC";
        //  DataSet dsset = SQL_DB.ExecuteDataSet("SELECT Amc_Offer_ID,Plan_ID,Plan_Amount,Plan_Discount,Date_From,Date_To,isnull(Status,0) as Status FROM M_Amc_Offer WHERE Amc_Offer_ID = (SELECT Max(Amc_Offer_ID) FROM M_Amc_Offer WHERE Pro_Id = '" + Amc.Pro_ID + "' AND Trans_Type = '" + Amc.Amt_Type + "' )");
        //   DataSet dsamc = function9420.FillGridPlan(Amc);
        //DataSet ds = function9420.FillGridPlan(i);
        //    DataView dv = dsamc.Tables[0].DefaultView;
        //    dv.RowFilter = "Flag = 1";
        //    DataTable dt = dv.ToTable();
        //if (dsset.Tables[0].Rows.Count > 0)
        //{
        //    result1 = DataTableToJSONWithJavaScriptSerializer(dsset.Tables[0]);
        //}
        // result2 = DataTableToJSONWithJavaScriptSerializer(dt);
        //// result = result2 + '#' + result1;
        // return result;
        //result =DataTableToJSONWithJavaScriptSerializer(dt)
        //= "Tax Setting <span style='color:blue;'>" + compname + "</span> >> <span style='color:blue;'>" + productname + "</span>  has been saved.";
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string InsertGetRunSurveyQuestion(string[] radioRate1TO5, string[] QsPkid, long M_Consumer_MCodeid)
    {
        string result1 = "success";

        try
        {


            string[] listGift_Pkid = radioRate1TO5;
            string[] listConsumer_Pkid = QsPkid;
            //string[] listCodeConsumer_Pkid = CodeConsumer_Pkid;
            // string str = "";
            string strGift_Pkid = string.Empty;
            string strConsumer_Pkid = string.Empty;
            // string strCodeConsumer_Pkid = string.Empty;
            //bool blnflag = false;
            //string strFlag = "0";
            //if (strtype == "Verify")
            //{
            //    //blnflag = true;
            //    strFlag = "1";
            //}
            //else if (strtype == "Reject")
            //{
            //    strFlag = "-1";
            //}
            if (listGift_Pkid.Length > 0)
            {
                for (int i = 0; i < listGift_Pkid.Length; i++)
                {
                    // if (list[i].Length > 0)
                    // {
                    //strGift_Pkid = listGift_Pkid[i];
                    strGift_Pkid = strGift_Pkid + "," + listGift_Pkid[i];
                    strConsumer_Pkid = strConsumer_Pkid + "," + listConsumer_Pkid[i];
                    //  strCodeConsumer_Pkid = strCodeConsumer_Pkid + "," + listCodeConsumer_Pkid[i];
                    //SQL_DB.ExecuteNonQuery("UPDATE [Comp_Doc_Flag]  SET  remarks = '" + docremarks + "' ,flag= '"+strFlag+"' WHERE Row_ID  = " + docFlagid + "  ");

                    // }
                }
            }
            strGift_Pkid = strGift_Pkid.TrimStart(',').TrimEnd(',');
            strConsumer_Pkid = strConsumer_Pkid.TrimStart(',').TrimEnd(',');
            // strCodeConsumer_Pkid = strCodeConsumer_Pkid.TrimStart(',').TrimEnd(',');
            //   if (strType == "dealer")
            //   {
            ExecuteNonQueryAndDatatable.InsertGetRunSurveyQuestion(strGift_Pkid, strConsumer_Pkid, ProjectSession.strMobileNo, M_Consumer_MCodeid);
            //   }
            //    else if (strType == "courier")
            //    {
            //   ExecuteNonQueryAndDatatable.Proc_InsUpdtGiftDispatch(strGift_Pkid, strConsumer_Pkid, strType, Convert.ToInt32(courid), Convert.ToDateTime(dispdate), Convert.ToDateTime(expdate), ProjectSession.strCompanyid, strCodeConsumer_Pkid);
            //   }
            //   DataSet dsset = SQL_DB.ExecuteDataSet("SELECT * from where  isnull(IsActive,1) = 0 and  isnull(Isdelete,1)=0 and comp_id = '" +  ProjectSession.strCompanyid + "' ");
            //        DataSet dsamc = function9420.FillGridPlan(Amc);
            //DataSet ds = function9420.FillGridPlan(i);
            // DataView dv = dsamc.Tables[0].DefaultView;
            // dv.RowFilter = "Flag = 1";
            // DataTable dt = dv.ToTable();
            //DataTable dt = dsset.Tables[0];
            //if (dsset.Tables[0].Rows.Count > 0)
            //{

            //    result1 = DataTableToJSONWithJavaScriptSerializer(dsset.Tables[0]);
            //}
            // result2 = DataTableToJSONWithJavaScriptSerializer(dt);
            // result = result2 + '#' + result1;
            return result1;
        }
        catch (Exception)
        {

            return "error";
        }
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetRunSurveyQuestion(string txtMobile)
    {
        string result1 = "No Question for Survey!";
        string strQry = string.Empty;
        //if (Convert.ToInt32(ddlstatus) > 0)
        //{
        //    strQry = " and g.Gift_Pkid = " + ddlstatus;
        //}
        //else if (!string.IsNullOrEmpty(txtMobile))
        //{
        //    strQry = strQry + " and M.Mobileno = '" + txtMobile + "'";
        //}
        DataTable dt = ExecuteNonQueryAndDatatable.GetRunSurveyQuestion(ProjectSession.strCompanyid, txtMobile).Tables[0];
        //        strQry = strQry + " and MC.M_Consumer_MCodeid not in (select M_Consumer_MCodeid from M_GiftDisptachDealerCourier)";
        //        string strtest = "select M.*,G.*,MC.M_Consumer_MCodeid from M_Consumer M inner join M_Consumer_M_Code MC on M.M_Consumerid = MC.M_Consumerid " +
        //"inner join M_CodeCouponAssign CA on Mc.M_Codeid = CA.M_CodeID " +
        //"inner join M_Gift g on ca.CouponTransID = g.Gift_Pkid where CA.M_CodeID in  (select Row_ID from M_Code where Pro_ID in (select pro_id from Pro_Reg where Comp_ID ='" + ProjectSession.strCompanyid + "'))" + strQry;
        //        DataSet dsset = SQL_DB.ExecuteDataSet(strtest);
        //        DataSet dsamc = function9420.FillGridPlan(Amc);
        //DataSet ds = function9420.FillGridPlan(i);
        // DataView dv = dsamc.Tables[0].DefaultView;
        // dv.RowFilter = "Flag = 1";
        // DataTable dt = dv.ToTable();
        // DataTable dt = dsset.Tables[0];
        // if (dt.Rows.Count > 0)
        // {

        result1 = DataTableToJSONWithJavaScriptSerializer(dt);
        // }

        // result2 = DataTableToJSONWithJavaScriptSerializer(dt);
        // result = result2 + '#' + result1;
        return result1;
    }

    #endregion Company Registration
}


