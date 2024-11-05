<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="RefferalRPT.aspx.cs" Inherits="Manufacturer_RefferalRPT" %>

<%@ Import Namespace="System.Data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
    <style>
        .form-row {
            display: flex;
            align-items: end;
        }

        label {
            font-weight: 400;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Refferral Report</h4>
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
                                <div class="form-row">
                                    <div class="mb-3">
                                        <label class="form-label">from date</label>
                                        <input type="date" id="txtfromdate" runat="server" class="form-control" required />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label ml-2">To date</label>
                                        <input type="date" id="txtTodate" runat="server" class="form-control ml-2" required />
                                    </div>
                                    <div class="form-group col-lg-3 text-center">
                                        <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="servss"
                                            ToolTip="Search" OnClick="ImgSearch_Click" />
                                    </div>
                                </div>
                                <hr />
                                <div class="table-responsive table_large">
                                    <table id='dataTable' class='table table-hover'>
                                        <thead>
                                            <tr>
                                                <th>Referral Mobile No</th>
                                                <th>Referral Code</th>
                                                <th>Date</th>
                                                <th>Consumer Mobile No</th>
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
                                                        Response.Write("<td>" + row["Referral Mobile No"] + "</td>");
                                                        Response.Write("<td>" + row["Referral Code"] + "</td>");
                                                        if (row["Date"] != DBNull.Value)
                                                        {
                                                            DateTime date;
                                                            bool isDateValid = DateTime.TryParse(row["Date"].ToString(), out date);
                                                            if (isDateValid)
                                                            {
                                                                string formattedDate = date.ToString("yyyy-MM-dd HH:mm:ss");
                                                                Response.Write("<td data-order='" + formattedDate + "'>" + formattedDate + "</td>");
                                                            }
                                                            else
                                                            {
                                                                Response.Write("<td data-order=''>" + "Invalid Date" + "</td>");
                                                            }
                                                        }
                                                        else
                                                        {
                                                            Response.Write("<td data-order=''>" + "No Date" + "</td>");
                                                        }
                                                        Response.Write("<td>" + row["Consumer Mobile No"] + "</td>");
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
    <script>
        $(document).ready(function () {
            var dataTable = $('#dataTable').DataTable({
                dom: 'Blfrtip',
                buttons: [
                    {
                        extend: 'excel',
                        text: '<i class="fa fa-file-excel"></i> Excel',
                        className: 'btn-excel',
                        exportOptions: {
                            columns: ':visible'
                        }
                    }
                ],
                lengthMenu: [
                    [10, 25, 50, -1],
                    ['10 ', '25 ', '50 ', 'Show all']
                ],
                pageLength: 25
            });

            // Initialize offcanvas
            var offcanvasElement = document.getElementById('offcanvasRight');
            var offcanvas = new bootstrap.Offcanvas(offcanvasElement);

            // Apply filters based on user input
            $('#applyFilters').on('click', function () {
                debugger;

                // Retrieve input values
                //var fromDate = $('#fromDate').val();
                //var toDate = $('#toDate').val();
                //var consumerName = $('#consumerName').val();
                //var mobileno = $('#mobileno').val();

                // Convert fromDate and toDate to match the table format
                //var formattedFromDate = convertDateFormat(fromDate);
                //var formattedToDate = convertDateFormat(toDate);

                // Remove previous search functions
                $.fn.dataTable.ext.search = [];



                // Apply mobile search
                //dataTable
                //  .column(0) // Mobile column
                //.search(mobileno)
                //.draw();

                // Hide offcanvas after applying filters
                offcanvas.hide();
            });

            // Function to convert date format from DD/MM/YYYY to YYYY-MM-DD
            function convertDateFormat(dateString) {
                var parts = dateString.split('/');
                if (parts.length === 3) {
                    return parts[2] + '-' + parts[1] + '-' + parts[0]; // Convert to YYYY-MM-DD format
                }
                return dateString; // Return as is if not in expected format
            }
        });
    </script>
</asp:Content>

