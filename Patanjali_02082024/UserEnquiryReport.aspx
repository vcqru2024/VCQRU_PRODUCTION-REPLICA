<%@ Page Title="" Language="C#" MasterPageFile="~/Patanjali/pfl.master" AutoEventWireup="true" CodeFile="UserEnquiryReport.aspx.cs" Inherits="Patanjali_UserEnquiryReport" %>

<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="home-section">
        <div class="app-breadcrumb">
            <div class="row">
                <div class="col">
                    <h5>User Enquiry Report</h5>
                </div>
                <div class="col">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="#">Reports</a></li>
                            <li class="breadcrumb-item active" aria-current="page">User Enquiry Report</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
        <!-- table view -->
        <div class="user-role-card">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                       
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
                        <table id='dataTable' class='table table-hover'>
                            <thead>
                                <tr>
                                    <th>Enquiry Date</th>
                                    <th>Name</th>
                                    <th>Mobile_Number</th>
                                    <th>City</th>
                                    <th>Email ID</th>                                   
                                    <th>Enquiry</th>  
                                    <th>Image</th>

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
                                            //Convert EnquiryDate to "dd-mm-yyyy" format
                                            string formattedDate = ((DateTime)row["Created_Date"]).ToString("yyyy-MM-dd");
                                            Response.Write("<td data-order='" + ((DateTime)row["Created_Date"]).ToString("yyyy-MM-dd") + "'>" + formattedDate + "</td>");
                                            Response.Write("<td>" + row["Name"] + "</td>");
                                            Response.Write("<td>" + row["Mobile_Number"] + "</td>");
                                            Response.Write("<td>" + row["City"] + "</td>");
                                            Response.Write("<td>" + row["Email_ID"] + "</td>");
                                            Response.Write("<td>" + row["Enquiry"] + "</td>");
                                            Response.Write("<td><img src='" + ResolveUrl(row["Image_Url"].ToString()) + "' alt='Image' Height='100' Width='100'></td>");

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
    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title" id="offcanvasRightLabel">Filters</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">

            <div class="row">
                <div class="col">
                    <form>
                        <div class="mb-3">
                            <label for="exampleInputEmail1" class="form-label">From Date</label>
                            <input type="date" id="fromDate" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="exampleInputEmail1" class="form-label">From Date</label>
                            <input type="date" id="toDate" class="form-control" aria-describedby="emailHelp">
                        </div>
                        <div class="mb-3">
                            <label for="exampleInputPassword1" class="form-label">Name</label>
                            <input type="text" id="Name" class="form-control" />
                        </div>
                        <div class="mb-3">
                            <label for="exampleInputPassword1" class="form-label">City</label>
                            <input type="text" id="City" class="form-control" />
                        </div>
                        <div class="mb-3">
                            <label for="exampleInputPassword1" class="form-label">Email</label>
                            <input type="text" id="Email" class="form-control" />
                        </div>
                        <div class="mb-3">
                            <label for="exampleInputPassword1" class="form-label">Mobile</label>
                            <input type="text" id="Mobile" class="form-control" />
                        </div>
                        <button type="button" id="applyFilters" class="btn btn-primary">Submit</button>
                        <button type="reset" class="btn btn-primary">reset</button>
                    </form>
                </div>

            </div>

        </div>
    </div>

    <script>
        $(document).ready(function () {
            var dataTable = $('#dataTable').DataTable({
                dom: 'Blfrtip',
                buttons: [
                    //{
                    //    extend: 'copy',
                    //    text: '<i class="fa fa-copy"></i> Copy',
                    //    className: 'btn-copy',
                    //    exportOptions: {
                    //        columns: ':visible'
                    //    }
                    //},
                    //{
                    //    extend: 'csv',
                    //    text: '<i class="fa fa-file-csv"></i> CSV',
                    //    className: 'btn-csv',
                    //    exportOptions: {
                    //        columns: ':visible'
                    //    }
                    //},
                    {
                        extend: 'excel',
                        text: '<i class="fa fa-file-excel"></i> Excel',
                        className: 'btn-excel',
                        exportOptions: {
                            columns: ':visible'
                        }
                    }
                    //{
                    //    extend: 'pdf',
                    //    text: '<i class="fa fa-file-pdf"></i> PDF',
                    //    className: 'btn-pdf',
                    //    exportOptions: {
                    //        columns: ':visible'
                    //    }
                    //},
                    //{
                    //    extend: 'print',
                    //    text: '<i class="fa fa-print"></i> Print',
                    //    className: 'btn-print',
                    //    exportOptions: {
                    //        columns: ':visible'
                    //    }
                    //}
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
                var Name = $('#Name').val();
                var City = $('#City').val();
                var Email = $('#Email').val();
                var Mobile = $('#Mobile').val();

                // Convert fromDate and toDate to match the table format
                var formattedFromDate = convertDateFormat(fromDate);
                var formattedToDate = convertDateFormat(toDate);

                // Remove previous search functions
                $.fn.dataTable.ext.search = [];

                // Add custom search function
                $.fn.dataTable.ext.search.push(
                    function (settings, data, dataIndex) {
                        var nameMatch = true;
                        var cityMatch = true;
                        var emailMatch = true;
                        var mobileMatch = true;
                        var dateMatch = true;

                        // Check Name
                        if (Name !== '') {
                            nameMatch = data[1].toLowerCase().includes(Name.toLowerCase());
                        }

                        // Check City
                        if (City !== '') {
                            cityMatch = data[3].toLowerCase().includes(City.toLowerCase());
                        }

                        // Check Email
                        if (Email !== '') {
                            emailMatch = data[4].toLowerCase().includes(Email.toLowerCase());
                        }

                        // Check Mobile
                        if (Mobile !== '') {
                            mobileMatch = data[2].toLowerCase().includes(Mobile.toLowerCase());
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

                        return nameMatch && cityMatch && emailMatch && mobileMatch && dateMatch;
                    }
                );

                // Redraw the DataTable
                dataTable.draw();

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
    <script>
        // Example starter JavaScript for disabling form submissions if there are invalid fields
        (() => {
            'use strict'

            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            const forms = document.querySelectorAll('.needs-validation')

            // Loop over them and prevent submission
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }

                    form.classList.add('was-validated')
                }, false)
            })
        })()
    </script>
</asp:Content>

