using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;
using Business9420;
using System.Data;
using System.Web.UI;
/// <summary>
/// Summary description for PDFCLass
/// </summary>
public class PDFCLass
{
    public PDFCLass()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static void GeneratePdfPrintLabel()
    {

    }
    public  static void GeneratePDF(Object9420 Reg)
    {
        //HttpContext.Current.Response.Redirect("Default.aspx");
        string strInvoiceNo = Reg.Invoice_ID; // DateTime.Now.ToString("yyyyMMddTHHmmss");
      //  Reg.Comp_ID = "Comp-1066";
      //  Reg.Pro_ID = "AB32";
      //  Reg.Invoice_Date = Reg.Invoice_Date;
        DataSet ds = ExecuteNonQueryAndDatatable.Proc_GetInvoiceData(Reg.Comp_ID, Reg.Pro_ID, Reg.Invoice_ID);

        Document doc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
        //  Document doc = new Document();
        //Create PDF Table
        string strAdminPath = "~/Admin/Bill/Invoice/";
       

        string subPath = HttpContext.Current.Server.MapPath(strAdminPath + Reg.Invoice_Date.ToString("dd-MM-yyyy")); // your code goes here
        string subPathWithFilename = HttpContext.Current.Server.MapPath(strAdminPath + Reg.Invoice_Date.ToString("dd-MM-yyyy") + "/" + strInvoiceNo + ".pdf");// DateTime.Now.ToString("yyyyMMddTHHmmss") + ".pdf"); // your code goes here

        bool exists = System.IO.Directory.Exists(subPath);

        if (!exists)
            System.IO.Directory.CreateDirectory(subPath);

       
        if (ds.Tables.Count > 0)
        {
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                //Create a PDF file in specific path
                PdfWriter.GetInstance(doc, new FileStream(subPathWithFilename, FileMode.Create));

                //Open the PDF document
                doc.Open();

                //iTextSharp.text.Image image = iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath("~/Content/images/logo.png"));
                //image.ScalePercent(24f);
                //image.ScaleToFit(500f, 30f);
                //image.GetLeft(10f);
                //doc.Add(image);
                //Add Content to PDF
                PdfPTable tableLayout1 = new PdfPTable(2);
                doc.Add(Add_Content_To_PDF1(tableLayout1, dt, Reg));

                PdfPTable tableLayout2 = new PdfPTable(4);
                doc.Add(Add_Content_To_PDF2(tableLayout2, dt, Reg));

                PdfPTable tableLayout3 = new PdfPTable(7);
                doc.Add(Add_Content_To_PDF3(tableLayout3, dt, Reg));


                // Closing the document
                doc.Close();
            }
        }



       
    }

    public static void AddTable(Document doc, string txt, Font header2)
    {
        PdfPTable table2 = new PdfPTable(2);
        PdfPCell cell3 = new PdfPCell(new Phrase(txt, new Font(header2)));
        //cell3.Colspan = 2;
        cell3.HorizontalAlignment = 0; //0=Left, 1=Centre, 2=Right
        cell3.VerticalAlignment = 1;
        cell3.Border = 0;
        table2.AddCell(cell3);
        doc.Add(table2);
    }
    private static PdfPTable Add_Content_To_PDF(PdfPTable table2)
    {
        //PdfPTable table = new PdfPTable(2);
       // table.AddCell(new PdfPCell(new Phrase( ProjectSession.GetWebsiteName, new Font(Font.BOLD, 12, 1, iTextSharp.text.Color())) { HorizontalAlignment = Element.ALIGN_CENTER, Padding = 5, BackgroundColor = new iTextSharp.text.Color(0, 51, 102) });
       // PdfPCell cell = new PdfPCell(new Phrase("Row 1 , Col 1, Col 2 "));
       //// cell.Colspan = 3;
       // cell.HorizontalAlignment = Element.ALIGN_CENTER;
       // table.AddCell(cell);

        Font header = new Font(Font.FontFamily.TIMES_ROMAN, 15f, Font.BOLD | Font.UNDERLINE, BaseColor.BLACK);

       // PdfPCell cell2 = new PdfPCell(new Phrase( ProjectSession.GetWebsiteName,new Font(Font.BOLD.ToString(),12,1,BaseColor.BLUE)));
       // cell2.UseVariableBorders = true;
       // cell2.BorderColorLeft = BaseColor.BLUE;
       // cell2.BorderColorRight = BaseColor.ORANGE;
        
       // table.AddCell(cell2);



        //PdfPCell cell;
       
        PdfPTable table = new PdfPTable(1);

        PdfPCell cell = new PdfPCell(new Phrase( ProjectSession.GetWebsiteName, new Font(header)));
        cell.Colspan = 4;
        cell.HorizontalAlignment = 0; //0=Left, 1=Centre, 2=Right
        cell.VerticalAlignment = 1;
        cell.Border = 0;
        table.AddCell(cell);


        PdfPTable table3 = new PdfPTable(2);

        PdfPCell cell2 = new PdfPCell(new Phrase("To", new Font(header)));
        cell2.Colspan = 2;
        cell2.HorizontalAlignment = 0; //0=Left, 1=Centre, 2=Right
        cell2.VerticalAlignment = 1;
        cell2.Border= 0;
        table3.AddCell(cell2);

        PdfPCell cell3 = new PdfPCell(new Phrase(ProjectSession.GetWebsiteName +"<br/><br/>B1/503 , MILAN VIHAR, 72 I.P. EXTENSION ,PATPARGANJ DELHI - 110092", new Font(header)));
        cell3.Colspan = 2;
        cell3.HorizontalAlignment = 0; //0=Left, 1=Centre, 2=Right
        cell3.VerticalAlignment = 1;
        cell3.Border = 1;

        table3.AddCell(cell3);


        return table;
    }
    private static PdfPTable Add_Content_To_PDF1(PdfPTable tableLayout, DataTable dt, Object9420 Reg)
    {
        string strPATNo = dt.Rows[0]["PAN_TAN"].ToString();
        string strVATNo = dt.Rows[0]["VAT"].ToString();
        string strRegNo = dt.Rows[0]["Comp_ID"].ToString();
        string dtInvoiceDate = Convert.ToDateTime(dt.Rows[0]["Invoice_Date"].ToString()).ToString("dd -MM-yyyy");
        string InvoiceNo = dt.Rows[0]["Invoice_ID"].ToString();
        float[] headers = { 50,50 };  //Header Widths
        tableLayout.SetWidths(headers);        //Set the pdf headers
        tableLayout.WidthPercentage = 80;       //Set the PDF File witdh percentage
        tableLayout.SpacingAfter = 20f;

        //Add Title to the PDF file at the top


        iTextSharp.text.Image image = iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath("~/Content/images/logo.png"));
        image.ScalePercent(24f);
        image.ScaleToFit(500f, 30f);
        image.GetLeft(10f);
        //doc.Add(image);
        

       // iTextSharp.text.Image jpg = iTextSharp.text.Image.GetInstance(imagepath + "/logo.jpg");
        PdfPCell imageCell = new PdfPCell(image);
        imageCell.Colspan = 2; // either 1 if you need to insert one cell
        imageCell.Border = 0;
        imageCell.HorizontalAlignment = Element.ALIGN_LEFT;
        // add a image
        tableLayout.AddCell(imageCell);

        
        var FontColour = new BaseColor(0, 128, 128);
        Font header = new Font(Font.FontFamily.TIMES_ROMAN, 15f, Font.BOLD | Font.UNDERLINE, BaseColor.BLACK);
        tableLayout.AddCell(new PdfPCell(new Phrase("VCQRU.com",
            new Font(Font.FontFamily.HELVETICA, 15f, Font.BOLD, BaseColor.BLACK)))
        { Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_LEFT });
        tableLayout.AddCell(new PdfPCell(new Phrase("TAX INVOICE",
            new Font(Font.FontFamily.HELVETICA, 18f, Font.BOLD, FontColour)))
        {  Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_RIGHT });



        
        tableLayout.AddCell(new PdfPCell(new Phrase("To \n\n"+ dt.Rows[0]["Comp_Name"].ToString() +" \n\n"+ dt.Rows[0]["Address"].ToString() + "\n\n\n PAN No : " + strPATNo + "\n\n GSTIN No : " + strVATNo + "\n\n RegNo : " + strRegNo + " ",
            new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        { BorderWidthTop = .5f, BorderWidthBottom = .5f, BorderWidthLeft = .5f, BorderWidthRight = 0, PaddingBottom = 10, HorizontalAlignment = Element.ALIGN_LEFT, BorderWidth = .5f });
        tableLayout.AddCell(new PdfPCell(new Phrase("From \n\nVCQRU.com \n\n\n PAN No: AAQCA3749P\n\n GSTIN No: 07AAQCA3749P1ZV\n\n CONTACT: 9711809420 \n\n EMAIL: " + ProjectSession.sales_vcqrucom + " " ,
          new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        { BorderWidthTop = .5f, BorderWidthBottom = .5f, BorderWidthLeft = .5f, BorderWidthRight = .5f, PaddingBottom = 10, HorizontalAlignment = Element.ALIGN_LEFT,BorderWidth=.5f});
        tableLayout.AddCell(new PdfPCell(new Phrase("InvoiceDate : " + dtInvoiceDate,
           new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        { BorderWidthTop = 0, BorderWidthBottom = .5f, BorderWidthLeft = .5f, BorderWidthRight = 0, PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_LEFT, BorderWidth = .5f });
        tableLayout.AddCell(new PdfPCell(new Phrase("Invoice No : " + InvoiceNo,
          new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        { BorderWidthTop = 0, BorderWidthBottom = .5f, BorderWidthLeft = .5f, BorderWidthRight = .5f, PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_LEFT, BorderWidth = .5f });


        //PdfPTable innerTable = new PdfPTable(2);

        //tableLayout.AddCell(new PdfPCell(innerTable){ Colspan = 2, Border = 0, });
        //Add_Content_To_PDF_Inner(tableLayout);


        //tableLayout.AddCell(new PdfPCell(new Phrase("To Label 9420 B1/503,", new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.NORMAL, BaseColor.BLACK)))
        //{ Colspan = 4, Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_LEFT });
        //tableLayout.AddCell(new PdfPCell(new Phrase("MILAN VIHAR, 72 I.P. EXTENSION,", new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.NORMAL, BaseColor.BLACK)))
        //{ Colspan = 4, Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_LEFT });
        //tableLayout.AddCell(new PdfPCell(new Phrase("PATPARGANJ DELHI-110092", new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.NORMAL, BaseColor.BLACK)))
        //{ Colspan = 4, Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_LEFT });
        //tableLayout.AddCell(new PdfPCell(new Phrase("To Label 9420 B1/503 , MILAN VIHAR, 72 I.P. EXTENSION , PATPARGANJ DELHI-110092", new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.NORMAL, BaseColor.BLACK)))
        //{ Colspan = 4, Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_LEFT });



        return tableLayout;
    }

    private static PdfPTable Add_Content_To_PDF2(PdfPTable tableLayout,DataTable dt,Object9420 Reg)
    {
        float[] headers = { 25,25,25,25 };  //Header Widths
        tableLayout.SetWidths(headers);        //Set the pdf headers
        tableLayout.WidthPercentage = 80;       //Set the PDF File witdh percentage
        tableLayout.SpacingAfter = 20f;
       



        tableLayout.AddCell(new PdfPCell(new Phrase("Last Pament Receipt ",
           new Font(Font.FontFamily.HELVETICA, 9f, Font.BOLD, BaseColor.BLACK)))
        { BorderWidthTop = .5f, BorderWidthBottom = .5f, BorderWidthLeft = .5f, BorderWidthRight = 0, PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f ,BackgroundColor=BaseColor.LIGHT_GRAY});
        tableLayout.AddCell(new PdfPCell(new Phrase("Balance",
          new Font(Font.FontFamily.HELVETICA, 9f, Font.BOLD, BaseColor.BLACK)))
        { BorderWidthTop = .5f, BorderWidthBottom = .5f, BorderWidthLeft = .5f, BorderWidthRight = 0, PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f, BackgroundColor = BaseColor.LIGHT_GRAY });
        tableLayout.AddCell(new PdfPCell(new Phrase("Current Charge",
           new Font(Font.FontFamily.HELVETICA, 9f, Font.BOLD, BaseColor.BLACK)))
        { BorderWidthTop = .5f, BorderWidthBottom = .5f, BorderWidthLeft = .5f, BorderWidthRight = 0, PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f, BackgroundColor = BaseColor.LIGHT_GRAY });
        tableLayout.AddCell(new PdfPCell(new Phrase("Net Pay",
          new Font(Font.FontFamily.HELVETICA, 9f, Font.BOLD, BaseColor.BLACK)))
        { BorderWidthTop = .5f, BorderWidthBottom = .5f, BorderWidthLeft = .5f, BorderWidthRight = .5f, PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f, BackgroundColor = BaseColor.LIGHT_GRAY });


        tableLayout.AddCell(new PdfPCell(new Phrase(dt.Rows[0]["LstReceiptNo"].ToString(),
          new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        { BorderWidthTop = .5f, BorderWidthBottom = .5f, BorderWidthLeft = .5f, BorderWidthRight = 0, PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f});
        tableLayout.AddCell(new PdfPCell(new Phrase(dt.Rows[0]["Last_Paid_Amount"].ToString(),
          new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        { BorderWidthTop = .5f, BorderWidthBottom = .5f, BorderWidthLeft = .5f, BorderWidthRight = 0, PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f});
        tableLayout.AddCell(new PdfPCell(new Phrase("Rs." + dt.Rows[0]["N_Amount_Invoice"].ToString(),
           new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        { BorderWidthTop = .5f, BorderWidthBottom = .5f, BorderWidthLeft = .5f, BorderWidthRight = 0, PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
        tableLayout.AddCell(new PdfPCell(new Phrase("Rs." + dt.Rows[0]["N_Amount_Invoice"].ToString(),
          new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        { BorderWidthTop = .5f, BorderWidthBottom = .5f, BorderWidthLeft = .5f, BorderWidthRight = .5f, PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f});


        return tableLayout;
    }
    public static void Add_Content_To_PDF_Inner(PdfPTable tableLayout)
    {
        PdfPTable innerTable = new PdfPTable(2);
        float[] headers = { 20, 20 };  //Header Widths
        innerTable.SetWidths(headers);        //Set the pdf headers
        innerTable.WidthPercentage = 20;
        innerTable.DefaultCell.Border = 1;
        innerTable.DefaultCell.BorderWidth= 1;
        innerTable.DefaultCell.BorderColor = BaseColor.BLACK;
       // innerTable.TotalWidth = 50f;
        //fix the absolute width of the table
      //  innerTable.LockedWidth = true;
        innerTable.DefaultCell.BorderWidthBottom = 1;
        innerTable.DefaultCell.BorderWidthLeft = 1;
        innerTable.DefaultCell.BorderWidthRight = 1;

        innerTable.AddCell(new PdfPCell(new Phrase("To", new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.NORMAL, BaseColor.BLACK)))
        { PaddingBottom = 10, Border = 0,HorizontalAlignment = Element.ALIGN_LEFT });
        innerTable.AddCell(new PdfPCell(new Phrase("  ", new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.NORMAL, BaseColor.BLACK)))
        { PaddingBottom = 10, Border = 0, HorizontalAlignment = Element.ALIGN_LEFT });

        innerTable.AddCell(new PdfPCell(new Phrase("Company Name", new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.NORMAL, BaseColor.BLACK)))
        {  PaddingBottom = 10, Border = 0,HorizontalAlignment = Element.ALIGN_LEFT });
        innerTable.AddCell(new PdfPCell(new Phrase(" ", new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.NORMAL, BaseColor.BLACK)))
        { PaddingBottom = 10, Border = 0, HorizontalAlignment = Element.ALIGN_LEFT });

        innerTable.AddCell(new PdfPCell(new Phrase("B1/503,MILAN VIHAR, 72 I.P. EXTENSION,", new Font(Font.FontFamily.TIMES_ROMAN, 8f, Font.NORMAL, BaseColor.BLACK)))
        {  Border = 0,  HorizontalAlignment = Element.ALIGN_LEFT });
        innerTable.AddCell(new PdfPCell(new Phrase(" ", new Font(Font.FontFamily.TIMES_ROMAN, 8f, Font.NORMAL, BaseColor.BLACK)))
        {  Border = 0, HorizontalAlignment = Element.ALIGN_LEFT });

        innerTable.AddCell(new PdfPCell(new Phrase("PATPARGANJ DELHI-110092", new Font(Font.FontFamily.TIMES_ROMAN, 8f, Font.NORMAL, BaseColor.BLACK)))
        {  Border = 0,  HorizontalAlignment = Element.ALIGN_LEFT });
        innerTable.AddCell(new PdfPCell(new Phrase(" ", new Font(Font.FontFamily.TIMES_ROMAN, 8f, Font.NORMAL, BaseColor.BLACK)))
        { Border = 0, HorizontalAlignment = Element.ALIGN_LEFT });


        //   tableLayout.AddCell(new PdfPCell(innerTable) { Colspan = 2, Border = 1, });

        tableLayout.AddCell(new PdfPCell(innerTable) { Colspan = 2, BorderWidthBottom= 1,BorderWidthLeft= 1, BorderWidthRight= 1});



     
    }

    private static PdfPTable Add_Content_To_PDF3(PdfPTable tableLayout,DataTable dt, Object9420 Reg)
    {
        //float[] headers = { 5,20,10,10,15,15,10,15 };  //Header Widths
        float[] headers = { 5, 20, 15, 15, 15, 15, 15 };  //Header Widths
        tableLayout.SetWidths(headers);        //Set the pdf headers
        tableLayout.WidthPercentage = 80;       //Set the PDF File witdh percentage
        tableLayout.SpacingAfter = 40f;

        //  Add header
        tableLayout.AddCell(new PdfPCell(new Phrase("SNo.",
            new Font(Font.FontFamily.HELVETICA, 9f, Font.BOLD, BaseColor.BLACK)))
        {  PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
        tableLayout.AddCell(new PdfPCell(new Phrase("Particulars",
          new Font(Font.FontFamily.HELVETICA, 9f, Font.BOLD, BaseColor.BLACK)))
        {  PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f});
        tableLayout.AddCell(new PdfPCell(new Phrase("Qty",
        new Font(Font.FontFamily.HELVETICA, 9f, Font.BOLD, BaseColor.BLACK)))
        { PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
        tableLayout.AddCell(new PdfPCell(new Phrase("Rate",
           new Font(Font.FontFamily.HELVETICA, 9f, Font.BOLD, BaseColor.BLACK)))
        {  PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f});
        tableLayout.AddCell(new PdfPCell(new Phrase("Amount",
          new Font(Font.FontFamily.HELVETICA, 9f, Font.BOLD, BaseColor.BLACK)))
        { PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f});
        tableLayout.AddCell(new PdfPCell(new Phrase("GST",
          new Font(Font.FontFamily.HELVETICA, 9f, Font.BOLD, BaseColor.BLACK)))
        { PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
        //tableLayout.AddCell(new PdfPCell(new Phrase("Vat",
        //  new Font(Font.FontFamily.HELVETICA, 9f, Font.BOLD, BaseColor.BLACK)))
        //{ PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
        tableLayout.AddCell(new PdfPCell(new Phrase("Net Amount",
          new Font(Font.FontFamily.HELVETICA, 9f, Font.BOLD, BaseColor.BLACK)))
        { PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });



        //Add body


        for (int i = 0; i < dt.Rows.Count; i++)
        {
            int j = i + 1;
            tableLayout.AddCell(new PdfPCell(new Phrase(j.ToString(),
                new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
            { PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
            tableLayout.AddCell(new PdfPCell(new Phrase(dt.Rows[i]["Pro_Name"].ToString() + "\n(" + dt.Rows[0]["Label_Name"].ToString() + ")",
              new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
            { PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
            tableLayout.AddCell(new PdfPCell(new Phrase(dt.Rows[i]["Qty"].ToString(),
              new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
            { PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
            tableLayout.AddCell(new PdfPCell(new Phrase(dt.Rows[i]["Price"].ToString(),
               new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
            { PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
            tableLayout.AddCell(new PdfPCell(new Phrase(dt.Rows[i]["G_Amount"].ToString(),
              new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
            { PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });

            tableLayout.AddCell(new PdfPCell(new Phrase(dt.Rows[i]["Service_Tax"].ToString(),
            new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
            { PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
            //tableLayout.AddCell(new PdfPCell(new Phrase(dt.Rows[i]["Vat_LIF"].ToString(),
            //new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
            //{ PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
            tableLayout.AddCell(new PdfPCell(new Phrase(dt.Rows[i]["N_Amount"].ToString(),
            new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
            { PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
        }

        //tableLayout.AddCell(new PdfPCell(new Phrase(i.ToString(),
        //               new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        //{ PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
        //tableLayout.AddCell(new PdfPCell(new Phrase("Total",
        //  new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        //{ PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
        //tableLayout.AddCell(new PdfPCell(new Phrase(dt.Rows[i]["Qty"].ToString(),
        //  new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        //{ PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
        tableLayout.AddCell(new PdfPCell(new Phrase("Total",
           new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        { Colspan=4,PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_RIGHT, BorderWidth = .5f });
        tableLayout.AddCell(new PdfPCell(new Phrase(dt.Rows[0]["G_Amount_Invoice"].ToString(),
          new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        { PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });

        tableLayout.AddCell(new PdfPCell(new Phrase(dt.Rows[0]["Service_Tax_Invoice"].ToString(),
        new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        { PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
        //tableLayout.AddCell(new PdfPCell(new Phrase(dt.Rows[0]["Vat_invoice"].ToString(),
        //new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        //{ PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
        tableLayout.AddCell(new PdfPCell(new Phrase(dt.Rows[0]["N_Amount_Invoice"].ToString(),
        new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        { PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });


        // AddCellToBody(tableLayout, " ", " "," ", "Amount", dt.Rows[0]["G_Amount"].ToString());
        AddCellToBody(tableLayout, " ", " ", " ", "Discount", string.Format("{0:#.00}", dt.Rows[0]["Discount_Invioce"].ToString()));
        //  AddCellToBody(tableLayout, " ", " ", " ", "Service Tax", dt.Rows[0]["Service_Tax"].ToString());
        //  AddCellToBody(tableLayout, " ", " ", " ", "VAT", dt.Rows[0]["VAT"].ToString());
        decimal dec1 = Convert.ToDecimal(dt.Rows[0]["N_Amount_Invoice"].ToString()) - Convert.ToDecimal(dt.Rows[0]["Discount_Invioce"].ToString());
        string str = string.Format("{0:0.00}", dec1);
        AddCellToBody(tableLayout, " ", " ", " ", "Total Due", string.Format("{0:#.00}", dec1));


        tableLayout.AddCell(new PdfPCell(new Phrase("\n\nPLEASE MAKE PAYMENT ONLINE OR BY DD/CHQ/CASH IN FAVOUR OF “" + ProjectSession.Company_AccTraPvtLtd + "” \n\nSIGNATURE\n\n\n\nFOR VCQRU.com",
       new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD, BaseColor.BLACK)))
        {Colspan=7, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_LEFT, Border=0 });

        return tableLayout;
    }
    private static PdfPTable Add_Content_To_PDF33(PdfPTable tableLayout)
    {
        float[] headers = { 25, 25, 25, 25 };  //Header Widths
        tableLayout.SetWidths(headers);        //Set the pdf headers
        tableLayout.WidthPercentage = 80;       //Set the PDF File witdh percentage

        //Add Title to the PDF file at the top
        Font header = new Font(Font.FontFamily.TIMES_ROMAN, 15f, Font.BOLD | Font.UNDERLINE, BaseColor.BLACK);
        tableLayout.AddCell(new PdfPCell(new Phrase( ProjectSession.GetWebsiteName, 
            new Font(Font.FontFamily.TIMES_ROMAN, 15f, Font.BOLD, BaseColor.BLACK))) { Colspan = 4, Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_LEFT });
       

        //PdfPTable innerTable = new PdfPTable(2);

        //tableLayout.AddCell(new PdfPCell(innerTable){ Colspan = 2, Border = 0, });
        Add_Content_To_PDF_Inner(tableLayout);


        tableLayout.AddCell(new PdfPCell(new Phrase("To " + ProjectSession.GetWebsiteName + " B1/503,", new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.NORMAL, BaseColor.BLACK)))
        { Colspan = 4, Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_LEFT });
        tableLayout.AddCell(new PdfPCell(new Phrase("MILAN VIHAR, 72 I.P. EXTENSION,", new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.NORMAL, BaseColor.BLACK)))
        { Colspan = 4, Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_LEFT });
        tableLayout.AddCell(new PdfPCell(new Phrase("PATPARGANJ DELHI-110092", new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.NORMAL, BaseColor.BLACK)))
        { Colspan = 4, Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_LEFT });
        tableLayout.AddCell(new PdfPCell(new Phrase("To " + ProjectSession.GetWebsiteName  + " B1/503 , MILAN VIHAR, 72 I.P. EXTENSION , PATPARGANJ DELHI-110092", new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.NORMAL, BaseColor.BLACK)))
        { Colspan = 4, Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_LEFT });

      //  Add header
        AddCellToHeader(tableLayout, "To");
        AddCellToHeader(tableLayout,  ProjectSession.GetWebsiteName); // comes company name
        AddCellToHeader(tableLayout, "B1/503 , MILAN VIHAR, 72 I.P. EXTENSION ,");
        AddCellToHeader(tableLayout, "PATPARGANJ DELHI-110092");

        //Add body
        //AddCellToBody(tableLayout, "Sachin Tendulkar");
        //AddCellToBody(tableLayout, "1.65 m");
        //AddCellToBody(tableLayout, "April 24, 1973");
        //AddCellToBody(tableLayout, "Ramesh Tendulkar, Rajni Tendulkar");

        //AddCellToBody(tableLayout, "Mahendra Singh Dhoni");
        //AddCellToBody(tableLayout, "1.75 m");
        //AddCellToBody(tableLayout, "July 7, 1981");
        //AddCellToBody(tableLayout, "Devki Devi, Pan Singh");

        //AddCellToBody(tableLayout, "Virender Sehwag");
        //AddCellToBody(tableLayout, "1.70 m");
        //AddCellToBody(tableLayout, "October 20, 1978");
        //AddCellToBody(tableLayout, "Aryavir Sehwag, Vedant Sehwag");

        //AddCellToBody(tableLayout, "Virat Kohli");
        //AddCellToBody(tableLayout, "1.75 m");
        //AddCellToBody(tableLayout, "November 5, 1988");
        //AddCellToBody(tableLayout, "Saroj Kohli, Prem Kohli");

        return tableLayout;
    }

    // Method to add single cell to the header
    private static void AddCellToHeader(PdfPTable tableLayout, string cellText)
    {
        Font header = new Font(Font.FontFamily.TIMES_ROMAN, 15f, Font.BOLD | Font.UNDERLINE, BaseColor.BLACK);
        //tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(Font.BOLD, 8, 1))) { HorizontalAlignment = Element.ALIGN_CENTER, Padding = 5, BackgroundColor = new  iTextSharp.text.Color(0, 51, 102) });
      //  tableLayout.AddCell(new PdfPCell(new Phrase("To Label 9420 B1/503 , MILAN VIHAR, 72 I.P. EXTENSION , PATPARGANJ DELHI-110092", new Font(Font.FontFamily.TIMES_ROMAN, 15f, Font.BOLD | Font.UNDERLINE, BaseColor.BLACK)))
      //  { Colspan = 4, Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_LEFT });
       tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(Font.FontFamily.TIMES_ROMAN, 11f, Font.NORMAL | Font.NORMAL, BaseColor.BLACK))) { HorizontalAlignment = Element.ALIGN_LEFT, Padding = 5});
    }

    // Method to add single cell to the body
    private static void AddCellToBody(PdfPTable tableLayout, string cellText1, string cellText2, string cellText3, string cellText4, string cellText5)
    {
        //tableLayout.AddCell(new PdfPCell(new Phrase(cellText1,
        //    new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        //{  PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
        //tableLayout.AddCell(new PdfPCell(new Phrase(cellText2,
        //  new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        //{  PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });

        tableLayout.AddCell(new PdfPCell(new Phrase(cellText3,
          new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        { Colspan = 5, PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });

        tableLayout.AddCell(new PdfPCell(new Phrase(cellText4,
           new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        { PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });
        tableLayout.AddCell(new PdfPCell(new Phrase("Rs."+cellText5,
          new Font(Font.FontFamily.HELVETICA, 9f, Font.NORMAL, BaseColor.BLACK)))
        {  PaddingBottom = 10, PaddingTop = 10, HorizontalAlignment = Element.ALIGN_CENTER, BorderWidth = .5f });




    }

    public static void downloadExcel(DataTable dt, string FileName)
    {
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.Charset = "";
        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + FileName + ".xls");
        HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";

        StringWriter writer = new StringWriter();
        Html32TextWriter htmlwriter = new Html32TextWriter(writer);
        DataGrid grd = new DataGrid();
        grd.DataSource = dt;
        grd.DataBind();
        grd.RenderControl(htmlwriter);
        HttpContext.Current.Response.Write(writer.ToString());
        grd.AlternatingItemStyle.BackColor = System.Drawing.Color.LightSkyBlue;
        HttpContext.Current.Response.End();
        htmlwriter.Close();
    }


  
}
public class MyClassPrintLabels
{
    
}