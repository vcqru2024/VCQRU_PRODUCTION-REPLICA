<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true"
    CodeFile="Enquiry_Details_Report.aspx.cs" Inherits="Patanjali_Enquiry_Details_Report" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- end-topbar -->

    <div class="home-section">
        <div class="app-breadcrumb">
            <div class="row">
                <div class="col">
                    <h5>Enquiry Details Report</h5>
                </div>
                <div class="col">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">Enquiry Details Report
                            </li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
        <!-- table view -->
        <div class="user-role-card">
            <div class="card">
                <div class="card-body">
                    <div class="row align-items-end g-3">
                        <div class="col-lg-4">
                            <div class="global-search">
                                <div class="form-group">
                                    <input type="search" id="searchInput"
                                        onkeyup="performSearch(this.value)" class="form-control"
                                        placeholder="Search">
                                    <span><i class="fa fa-search"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">From Date</label>
                            <div class="input-group date" data-provide="datepicker">
                                <asp:TextBox ID="txtfromdate" AutoComplete="off" runat="server"
                                    CssClass="form-control" MaxLength="10" placeholder="MM/DD/YYYY">
                                </asp:TextBox>
                                <cc1:CalendarExtender runat="server" ID="txtfromdate_ce"
                                    Format="dd-MMM-yyyy" PopupButtonID="txtfromdate"
                                    TargetControlID="txtfromdate">
                                </cc1:CalendarExtender>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">To Date</label>
                            <div class="input-group date" data-provide="datepicker">
                                <asp:TextBox ID="txttodate" AutoComplete="off" runat="server"
                                    CssClass="form-control" MaxLength="10" placeholder="MM/DD/YYYY">
                                </asp:TextBox>
                                <cc1:CalendarExtender runat="server" ID="txttodate_ce" Format="dd-MMM-yyyy"
                                    Animated="False" PopupButtonID="txttodate" TargetControlID="txttodate">
                                </cc1:CalendarExtender>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <asp:Button ID="btnsearch" runat="server" Text="Search"
                                OnClick="btnsearch_Click" CssClass="btn btn-primary" />
                            <button runat="server" onclick="downloadGridData('Transactiondetails')"
                                class="btn btn-primary">
                                <i class="fas fa-file-csv"></i>
                            </button>
                        </div>
                        <!-- <div class="row mt-3">
                                        <div class="col-lg-4">
                                            <div class="global-search">
                                                <div class="form-group">
                                                    <input type="search" id="searchInput"
                                                        onkeyup="performSearch(this.value)" class="form-control"
                                                        placeholder="Search">
                                                    <span><i class="fa fa-search"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div> -->

                    </div>
                    <div class="app-table mt-3">
                        <table id='dataTable' class='table table-hover table-bordered'>
                            <thead>
                                <tr>
                                    <th>Sr No</th>
                                    <th>Scanned Date</th>
                                    <th>Product Name</th>
                                    <th>Scanned Mode</th>
                                    <th>Mobile No</th>
                                    <th>Complete Code</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater runat="server" ID="rptData">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <%#Container.ItemIndex+1 %>
                                            </td>
                                            <td>
                                                <%# Eval("Enquiry Date") %>
                                            </td>
                                            <td>
                                                <%# Eval("Product Name") %>
                                            </td>
                                            <td>
                                                <%# Eval("Enquiry Mode") %>
                                            </td>
                                            <td>
                                                <%# Eval("Enquiry Details") %>
                                            </td>
                                            <td>
                                                <%# Eval("Code1").ToString() + Eval("Code2").ToString() %>
                                            </td>
                                            <td>
                                                <%# Eval("Status") %>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>


    </div>


    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight"
        aria-labelledby="offcanvasRightLabel">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title" id="offcanvasRightLabel">Offcanvas right</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">

            <div class="row">
                <div class="col">
                    <div class="mb-3">
                        <label for="exampleInputPassword1" class="form-label">Enquiry Details</label>
                        <input type="text" id="Enquiry_Details" class="form-control" />
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputPassword1" class="form-label">Code1</label>
                        <input type="text" id="Code1" class="form-control" />
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputPassword1" class="form-label">Code2</label>
                        <input type="text" id="Code2" class="form-control" />
                    </div>
                    <button type="button" id="applyFilters" class="btn btn-primary">Submit</button>
                    <button type="reset" class="btn btn-primary">reset</button>
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
                    ['10  ', '25  ', '50  ', 'Show all']
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
                var Enquiry_Details = $('#Enquiry_Details').val();
                var Code1 = $('#Code1').val();
                var Code2 = $('#Code2').val();

                // Convert fromDate and toDate to match the table format
                var formattedFromDate = convertDateFormat(fromDate);
                var formattedToDate = convertDateFormat(toDate);

                // Remove previous search functions
                $.fn.dataTable.ext.search = [];

                // Add custom search function
                $.fn.dataTable.ext.search.push(
                    function (settings, data, dataIndex) {
                        var consumerNameMatch = true;
                        var dateMatch = true;

                        // Check productName
                        if (consumerName !== '') {
                            consumerNameMatch = data[1].toLowerCase().includes(consumerName.toLowerCase());
                        }

                        // Check date range
                        var currentDate = new Date(data[0]); // Assuming EnquiryDate is in the first column
                        var minDate = new Date(formattedFromDate);
                        var maxDate = new Date(formattedToDate);

                        if (!isNaN(minDate) && currentDate < minDate) {
                            dateMatch = false;
                        }
                        if (!isNaN(maxDate) && currentDate > maxDate) {
                            dateMatch = false;
                        }

                        return consumerNameMatch && dateMatch;
                    }
                );

                // Apply mobile search
                dataTable
                    .column(3) // Mobile column
                    .search(Enquiry_Details).column(4).search(Code1).column(5).search(Code2)
                    .draw();

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
