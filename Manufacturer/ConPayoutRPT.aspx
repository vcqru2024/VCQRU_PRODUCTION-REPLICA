<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="ConPayoutRPT.aspx.cs" Inherits="Manufacturer_ConPayoutRPT" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/2.1.5/css/dataTables.dataTables.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/3.1.2/css/buttons.dataTables.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Consumer Balance Report</h4>
                        </header>
                        <div class="card-body card-body-nopadding">
                            <div class="form-row">
                                <div class="col-lg-12">
                                    <asp:Label ID="lblMsg1" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="form-wizard medias">
                                <div class="col-lg-6">
                                </div>
                                <div class="col-lg-4">
                                    <asp:Label ID="LblMsg" CssClass="small_font" runat="server"></asp:Label>
                                </div>
                             <%--   <div class="form-row">
                                    <div class="mb-3">
                                        <label class="form-label">Mobile No.</label>
                                        <input type="date" id="txtfromdate" runat="server" class="form-control" required />
                                    </div>
                                    <div class="form-group col-lg-3 text-center">
                                        <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="servss"
                                            ToolTip="Search" OnClick="ImgSearch_Click" />
                                    </div>
                                </div>--%>
                                <hr />
                                <div class="table-responsive table_large">
                                    <table id='dataTable' class='table table-hover'>
                                        <thead>
                                            <tr>
                                                <th>Mobile No</th>
                                                <th>Consumer Name</th>
                                                <th>Account No</th>
                                                <th>Ifsc Code</th>
                                                <th>Total Earned</th>
                                                <th>Paid Balance</th>
                                                <th>Due Payment</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                // Assuming you have a method in your code-behind to fetch data from the database
                                                DataTable dt = GetDataFromDatabase(); // You need to implement this method in your code-behind

                                                if (dt != null && dt.Rows.Count > 0)
                                                {
                                                    foreach (DataRow row in dt.Rows)
                                                    {
                                                        Response.Write("<tr>");
                                                        Response.Write("<td>" + row["MobileNo"] + "</td>");
                                                        Response.Write("<td>" + row["ConsumerName"] + "</td>");
                                                        Response.Write("<td>" + row["Account_No"] + "</td>");
                                                        Response.Write("<td>" + row["IFSC_Code"] + "</td>");
                                                        Response.Write("<td>" + row["Cashearned"] + "</td>");
                                                        Response.Write("<td>" + row["PaidAmount"] + "</td>");
                                                        Response.Write("<td>" + row["DueAmount"] + "</td>");
                                                        Response.Write("</tr>");
                                                    }
                                                }
                                                else
                                                {
                                                    Response.Write("<p>No data available</p>");
                                                }
                                            %>
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/2.1.5/js/dataTables.js"></script>
    
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/3.1.2/js/dataTables.buttons.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/3.1.2/js/buttons.dataTables.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/3.1.2/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/3.1.2/js/buttons.print.min.js"></script>

    <script>
        new DataTable('#dataTable', {
            layout: {
                topStart: {
                    buttons: ['excel']
                }
            }
        });
       
    </script>
</asp:Content>

