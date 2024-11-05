using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.IO;
using Business9420;
using DataProvider;

/// <summary>
/// Summary description for GenerateInvoice
/// </summary>
namespace GenerateCrystalInvoice
{
    public class Invoice
    {
        //public static void showReport(string Row_ID, string invn, string Trans_Type, Object9420 Reg)
        //{
        //    ReportDocument myreportdocumen = new ReportDocument();
        //    CrystalReportViewer CrystalReportViewer1 = new CrystalReportViewer();
        //    CrystalReportViewer1.DisplayGroupTree = false;
        //    CrystalReportViewer1.DisplayGroupTree = false;
        //    myreportdocumen.Load(Reg.Path, CrystalDecisions.Shared.OpenReportMethod.OpenReportByDefault);
        //    myreportdocumen.DataDefinition.FormulaFields["Invoice_No"].Text = "'" + invn + "'";
        //    myreportdocumen.DataDefinition.FormulaFields["Invoice_Date"].Text = "'" + DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy") + "'";
        //    myreportdocumen.DataDefinition.FormulaFields["Row_ID"].Text = "'" + Row_ID + "'";
        //    myreportdocumen.DataDefinition.FormulaFields["Trans_Type"].Text = "'" + Trans_Type + " '";
        //    //myreportdocumen.SetDatabaseLogon("vcqru", "admin@1234", "SERVER22", "tauseefbeta_L9420");
        //    myreportdocumen.SetDatabaseLogon("vcqru", "admin@1234");
        //    //myreportdocumen.SetDatabaseLogon("sa", "label#1234");
        //    CrystalReportViewer1.ReportSource = myreportdocumen;
        //    CrystalReportViewer1.DataBind();
        //    CrystalReportViewer1.Visible = false;
        //    ExportOptions CrExportOptions1;
        //    DiskFileDestinationOptions CrDiskFileDestinationOptions1 = new DiskFileDestinationOptions();
        //    PdfRtfWordFormatOptions CrFormatTypeOptions1 = new PdfRtfWordFormatOptions();
        //    string pt = Reg.FolderPath + "\\Invoice\\" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("dd-MM-yyyy");
        //    if (!Directory.Exists(pt))
        //        Directory.CreateDirectory(pt);
        //    CrDiskFileDestinationOptions1.DiskFileName = pt + "\\" + invn.ToString() + ".pdf";
        //    CrExportOptions1 = myreportdocumen.ExportOptions;
        //    {
        //        CrExportOptions1.ExportDestinationType = ExportDestinationType.DiskFile;
        //        CrExportOptions1.ExportFormatType = ExportFormatType.PortableDocFormat;
        //        CrExportOptions1.DestinationOptions = CrDiskFileDestinationOptions1;
        //        CrExportOptions1.FormatOptions = CrFormatTypeOptions1; LogManager.WriteExe("If Condition Check in showReport() First");
        //    }
        //    //myreportdocumen.Export(); arb: temporarily commented
        //}
        
    }
    public class Receipt
    {
        public static void showReport(Object9420 Reg)
        {
            //ReportDocument myreportdocumen = new ReportDocument();
            //CrystalReportViewer CrystalReportViewer1 = new CrystalReportViewer();
            //CrystalReportViewer1.DisplayGroupTree = false;
            //CrystalReportViewer1.DisplayGroupTree = false;
            //myreportdocumen.Load(Reg.Path, CrystalDecisions.Shared.OpenReportMethod.OpenReportByDefault);
            //myreportdocumen.DataDefinition.FormulaFields["Receipt_No"].Text = "'" + Reg.Request_No + "'";
            //myreportdocumen.DataDefinition.FormulaFields["Receipt_Date"].Text = "'" + DataProvider.LocalDateTime.Now.ToString("dd/MM/yyyy") + "'";
            //myreportdocumen.SetDatabaseLogon("sa", "label#1234");
            //CrystalReportViewer1.ReportSource = myreportdocumen;
            //CrystalReportViewer1.DataBind();
            //CrystalReportViewer1.Visible = false;
            //ExportOptions CrExportOptions1;
            //DiskFileDestinationOptions CrDiskFileDestinationOptions1 = new DiskFileDestinationOptions();
            //PdfRtfWordFormatOptions CrFormatTypeOptions1 = new PdfRtfWordFormatOptions();
            //string pt = Reg.FolderPath + "\\Receipt\\" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("dd-MM-yyyy");
            //if (!Directory.Exists(pt))
            //    Directory.CreateDirectory(pt);
            //CrDiskFileDestinationOptions1.DiskFileName = pt + "\\" + Reg.Request_No.ToString() + ".pdf";
            //CrExportOptions1 = myreportdocumen.ExportOptions;
            //{
            //    CrExportOptions1.ExportDestinationType = ExportDestinationType.DiskFile;
            //    CrExportOptions1.ExportFormatType = ExportFormatType.PortableDocFormat;
            //    CrExportOptions1.DestinationOptions = CrDiskFileDestinationOptions1;
            //    CrExportOptions1.FormatOptions = CrFormatTypeOptions1; LogManager.WriteExe("If Condition Check in showReport() Second");
            //}
            //myreportdocumen.Export();
        }
    }
}