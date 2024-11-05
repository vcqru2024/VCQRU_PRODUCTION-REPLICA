<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="pflconsumerdetails.aspx.cs" Inherits="Patanjali_pflconsumerdetails" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="home-section"> 
        <div class="app-breadcrumb">
            <div class="row">
                <div class="col">
                    <h5>consumer details</h5>
                </div>
                <div class="col">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                           <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">consumer details</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
        <div class="user-role-card">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                       <%-- <div class="col col-md-4 mb-3">
                            <div class="global-search">
                                <div class="form-group ">
                                    <input type="search" id="searchInput" class="form-control" placeholder="Search">
                                    <span><i class="fa fa-search"></i></span>
                                </div>
                            </div>
                        </div>--%>
                        <div class="col mb-3">
                            <ul class="action-button-global">
                                
                                <li>
                                    <button class="btn btn-sm btn-light" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                                        <i
                                            class='bx bxs-filter-alt'></i>filter</button>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="app-table">
                       <div class="table-responsive">
                        <table id='dataTable' class='table table-hover table-bordered mb-0'>
                            <thead><tr><th>Entry_Date</th><th>ConsumerName</th><th>MobileNo</th><th>PinCode</th><th>City</th><th>Address</th><th>state</th></tr></thead>
                            <tbody>
                        <%

                            // Assuming you have a method in your code-behind to fetch data from the database
                            DataTable dt = GetDataFromDatabase(); // You need to implement this method in your code-behind

                            if (dt != null && dt.Rows.Count > 0)
                            {
                              
                                foreach (DataRow row in dt.Rows)
                                {
                                    Response.Write("<tr>");
                                    // Convert EnquiryDate to "dd-mm-yyyy" format
                                    string formattedDate = ((DateTime)row["Entry_Date"]).ToString("yyyy-MM-dd");
                                    Response.Write("<td data-order='" + ((DateTime)row["Entry_Date"]).ToString("yyyy-MM-dd") + "'>" + formattedDate + "</td>");
                                    Response.Write("<td>" + row["ConsumerName"] + "</td>");
                                    Response.Write("<td>" + row["MobileNo"] + "</td>");
                                    Response.Write("<td>" + row["PinCode"] + "</td>");
                                    Response.Write("<td>" + row["City"] + "</td>");
                                    Response.Write("<td>" + row["Address"] + "</td>");
                                    Response.Write("<td>" + row["state"] + "</td>");
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

     <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title" id="offcanvasRightLabel">Offcanvas right</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">

            <div class="row">
                <div class="col">
                    
                        <div class="mb-3">
                            <label for="exampleInputEmail1" class="form-label">From Date</label>
                            <input type="date" id="fromDate" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="exampleInputEmail1" class="form-label">From Date</label>
                            <input type="date" id="toDate" class="form-control" aria-describedby="emailHelp">
                        </div>
                        <div class="mb-3">
                            <label for="exampleInputPassword1" class="form-label">Consumer Name</label>
                            <input type="text" id="consumerName" class="form-control" />
                        </div>
                        <div class="mb-3">
                            <label for="exampleInputPassword1" class="form-label">Mobile NO</label>
                            <input type="text" id="mobileno" class="form-control" />
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
                var fromDate = $('#fromDate').val();
                var toDate = $('#toDate').val();
                var consumerName = $('#consumerName').val();
                var mobileno = $('#mobileno').val();

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
                    .column(2) // Mobile column
                    .search(mobileno)
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

