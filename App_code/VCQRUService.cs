using Business9420;
using DataProvider;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Xml;

///// <summary>
///// Summary description for VCQRUService
///// </summary>
//[WebService(Namespace = "http://tempuri.org/")]
//[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
//// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
//// [System.Web.Script.Services.ScriptService]
/// <summary>
/// Summary description for adminhandeler
/// </summary>
[WebService(Namespace = "http://www.vcqru.com/")]
//[WebService(Namespace = ProjectSession.absoluteSiteBrowseUrl.ToString())]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class VCQRUService : System.Web.Services.WebService
{

    public VCQRUService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string PrintCode(string Pro_ID)
    {
        DataTable dt1 = SQL_DB.ExecuteDataTable("select * from M_Label_Request where  Pro_ID = '" + Pro_ID + "' order by Entry_Date asc");
        Int64 Qty = Convert.ToInt64(dt1.Rows[0]["Qty"].ToString());
        string trackingcode = dt1.Rows[0]["Tracking_No"].ToString();
        DataTable dt = SQL_DB.ExecuteDataTable("SELECT COUNT(Row_ID) as Cnt FROM M_Code with (nolock) WHERE ISNULL(Print_Status,'') <> '' AND" +
            "ISNULL(Print_Date,'') <> '' AND LabelRequestId ='" + trackingcode + "'");
        Int64 PrintCount = Convert.ToInt64(dt.Rows[0]["Cnt"]);
        if (Qty > PrintCount)
        {
          //  AllocateAndPrint("1", Pro_ID, Comp_ID,);
        }
        // AllocateAndPrint("1", Pro_ID,Comp_ID,);
        return "Hello World";
    }
    public DataTable CodeTableInfo;
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
    //private string AllocateAndPrint(string NoofCodes, string Pro_ID, string Comp_ID, string trackid, string PrintLabelOrQrcode)
    //{
    //    CodeTableInfo = CreateFileDataTable();
    //    Session["DemoTable1"] = CodeTableInfo;
    //    string result = "";
    //    LogManager.WriteExe("New Print Labels Request Codes" + NoofCodes);
    //    //************************* Code Allocation Start **************************//

    //    //************************* Print Labels Start **************************//
    //    DataSet ds = new DataSet();
    //    Object9420 Reg = new Object9420();
    //    Reg.Pro_ID = Pro_ID;
    //    Reg.LabelRequestID = trackid;
    //    string s1 = ""; string o1 = ""; string s2 = ""; string o2 = "";
    //    ds.Reset();
    //    //ds = SQL_DB.ExecuteDataSet("SELECT top " + Convert.ToInt32(NoofCodes) + " [Code1],[Code2] FROM [M_Code] where [Pro_ID] is null and [Use_Type] is null AND [Allot_Date] IS NULL ");//[Pro_ID] = '" + Pro_ID + "' and [Print_Status] = 0
    //    t:
    //    try
    //    {
    //        ds = SQL_DB.ExecuteDataSet("SELECT * FROM [dbo].[GetAvailableCode] (" + Convert.ToInt64(NoofCodes) + ")");
    //    }
    //    catch (Exception ex)
    //    {
    //       // LogManager.WriteExe("Error find count Avail Code in M_code " + ex.Message.ToString());
    //        goto t;
    //    }
    //    if (ds.Tables[0].Rows.Count == 0)
    //    {
    //        return "NoCodeAvailable";
    //    }
    //    else if (ds.Tables[0].Rows.Count < Convert.ToInt64(NoofCodes))
    //    {
    //        return "NoCodeAvailable";
    //    }
    //    else if (ds.Tables[0].Rows.Count > 0)
    //    {
    //        StringBuilder sb = new StringBuilder();
    //        DataSet dseries = SQL_DB.ExecuteDataSet("select isnull( max([Series_Order]),0) as Series_order," +
    //        " isnull(max(Series_Serial),0) as Series_Serial FROM [M_Code] with (nolock) where [Pro_ID] = '" + Pro_ID + "'" +
    //        " and Print_Status = 1 and [Series_Order] = (select max([Series_Order]) as Series_order " +
    //        " FROM [M_Code] with (nolock) where [Pro_ID] = '" + Pro_ID + "' " +
    //        " and Print_Status = 1)");
    //        int orderId = Convert.ToInt32(dseries.Tables[0].Rows[0]["Series_order"]);
    //        int serialId = Convert.ToInt32(dseries.Tables[0].Rows[0]["Series_Serial"]);
    //        int i = 0;
    //        DataTable M_Code = new DataTable();
    //        M_Code = CreateDataTable();
    //        int counter = 0;
    //        if (orderId == 0 && serialId == 0)
    //        {
    //            Reg.Series_Order = 0;
    //            Reg.Series_Serial = 0;
    //            Reg.Use_Type = "L";
    //            Reg.Code1 = Convert.ToInt64(ds.Tables[0].Rows[0]["Code1"].ToString());
    //            Reg.Code2 = Convert.ToInt64(ds.Tables[0].Rows[0]["Code2"].ToString());
    //            Business9420.function9420.UpdateFunction(Reg);
    //            i = 1;
    //            counter++;
    //            s1 = Reg.Series_Serial.ToString();
    //            o1 = Reg.Series_Order.ToString();
    //        }
    //        bool CFlag = false; int currentindex = 0;
    //        string Series_OrderChk = ""; string Series_SerialChkFrom = ""; string Series_SerialChkTo = "";
    //        //k:
    //        for (; i < ds.Tables[0].Rows.Count; i++)
    //        //for (int i=0; i < ds.Tables[0].Rows.Count; i++)
    //        {
    //            //p:
    //            if (!CFlag)
    //            {
    //                string NewNumber = NextNumber(orderId, serialId);
    //                string[] b = NewNumber.Split('-');
    //                Reg.Series_Order = Convert.ToInt32(b[0]);
    //                Reg.Series_Serial = Convert.ToInt32(b[1]);
    //            }
    //            if (sb.Length == 0)
    //            {
    //                currentindex = i;
    //                Series_OrderChk = Reg.Series_Order.ToString(); Series_SerialChkFrom = Reg.Series_Serial.ToString();
    //            }
    //            #region Only Mail Data
    //            if (i == 0)
    //            {
    //                s1 = Reg.Series_Serial.ToString();
    //                o1 = Reg.Series_Order.ToString();
    //            }
    //            if (i == ds.Tables[0].Rows.Count - 1)
    //            {
    //                s2 = Reg.Series_Serial.ToString();
    //                o2 = Reg.Series_Order.ToString();
    //            }
    //            #endregion
    //            Reg.Use_Type = "L";
    //            Reg.Code1 = Convert.ToInt64(ds.Tables[0].Rows[i]["Code1"].ToString());
    //            Reg.Code2 = Convert.ToInt64(ds.Tables[0].Rows[i]["Code2"].ToString());
    //            //--------------New Code 22_3_13---------------------                

    //            //M_Code = AddNewRows(M_Code, Convert.ToInt32(Reg.Code1), Convert.ToInt32(Reg.Code2), Reg.Use_Type, Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd")), Pro_ID, 1, Convert.ToDateTime(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd")), Reg.Series_Order, Reg.Series_Serial);
    //            //string Pro_ID, string Use_Type,string Series_Order, string Series_Serial ,string LabelRequestId, string Code1, string Code2, DataTable myTable
    //            AddCodelInfo(Pro_ID, Reg.Use_Type, Reg.Series_Order.ToString(), Reg.Series_Serial.ToString(), trackid, Reg.Code1.ToString(),
    //                Reg.Code2.ToString(), (DataTable)Session["DemoTable1"]);

    //            /********************* Commented Code Logic With Vartual Table PrintLabels *****************/

    //            orderId = Convert.ToInt32(Reg.Series_Order);
    //            serialId = Convert.ToInt32(Reg.Series_Serial);

    //        }

    //        SaveLabelInfo1((DataTable)Session["DemoTable1"], ds.Tables[0].Rows.Count);
    //        // SaveLabelInfo((DataTable)Session["DemoTable"]);
    //        int noofrecordds = ds.Tables[0].Rows.Count;
    //        int Sessiondatatable = ((DataTable)Session["DemoTable1"]).Rows.Count;

    //        Object9420 NewReg = new Object9420();
    //        NewReg.Comp_ID = Comp_ID;
    //        Business9420.function9420.FillUpDateProfile(NewReg);
    //    }
    //}
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
}
