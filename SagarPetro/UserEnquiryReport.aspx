<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="UserEnquiryReport.aspx.cs" Inherits="Patanjali_UserEnquiryReport" %>

<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!--sweet alert-->
    <!-- Add this to the head section of your HTML file -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="home-section">
        <div class="app-breadcrumb">
            <div class="row row-cols-md-2 row-cols-1 g-3">
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
                    <div class="enquiry-report-cards">
                    <div class="row row-cols-xxl-4 row-cols-xl-4 row-cols-lg-2 row-cols-md-2 row-cols-1 g-3">
                        <div class="col d-flex">
                            <ul>
                                <li>
                                    <p>
                                        Generated Enquiries
                                    </p>
                                    <h5 class="text-success" id="lblgenenq" runat="server">
                                        14392
                                    </h5>
                                </li>
                                <li>
                                    <img src="assets/img/Generated-Codes.svg" alt="Generated Codes">
                                </li>
                            </ul>
                        </div>
                        <div class="col d-flex">
                            <ul>
                                <li>
                                    <p>
                                        New Enquiries
                                    </p>
                                    <h5 class="text-success" id="lblnewenq" runat="server">
                                        14392
                                    </h5>
                                </li>
                                <li>
                                    <img src="assets/img/Generated-Codes.svg" alt="Generated Codes">
                                </li>
                            </ul>
                        </div>
                        <div class="col d-flex">
                            <ul>
                                <li>
                                    <p>
                                        Open Enquiriew
                                    </p>
                                    <h5 class="text-success" id="lblopnenq" runat="server">
                                        14392
                                    </h5>
                                </li>
                                <li>
                                    <img src="assets/img/Generated-Codes.svg" alt="Generated Codes">
                                </li>
                            </ul>
                        </div>
                        <div class="col d-flex">
                            <ul>
                                <li>
                                    <p>
                                        Closed Enquiries
                                    </p>
                                    <h5 id="lblclsenq" runat="server" class="text-success">
                                        14392
                                    </h5>
                                </li>
                                <li>
                                    <img src="assets/img/Generated-Codes.svg" alt="Generated Codes">
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <ul class="action-button-global float-end">
                    <li>
                        <button class="btn btn-sm btn-light" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                            <i
                                class='bx bxs-filter-alt'></i>filter</button>
                    </li>
                </ul>
                    <div class="app-table">
                        <!--On Edit Click modal popup will open-->
                        <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="editModalLabel">Edit Details</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form id="editForm">
                                            <div class="form-group">
                                                <asp:HiddenField ID="editRow_ID" runat="server" />
                                            </div>
                                            <div class="form-group">
                                                <label for="editEnquiryDate">Enquiry Date:</label>
                                                <input type="text" class="form-control" id="editEnquiryDate" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="editName">Name:</label>
                                                <input type="text" class="form-control" id="editName" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="editMobileNumber">Mobile Number:</label>
                                                <input type="text" class="form-control" id="editMobileNumber" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="editCity">City:</label>
                                                <input type="text" class="form-control" id="editCity" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="editEmail">Email:</label>
                                                <input type="email" class="form-control" id="editEmail" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="editEnquiry">Enquiry:</label>
                                                <input type="text" class="form-control" id="editEnquiry" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="editImage">Image:</label>
                                                <img src="" alt="Image" id="editImage" class="img-fluid" style="max-width: 100%;">
                                            </div>
                                            <div class="form-group">
                                                <label for="editStatus" name="editStatus">Status:</label>
                                                <asp:DropDownList ID="editStatus" CssClass="form-control" runat="server">
                                                    <asp:ListItem Value="0">New</asp:ListItem>
                                                    <asp:ListItem Value="1">Open</asp:ListItem>
                                                    <asp:ListItem Value="2">Close</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="form-group">
                                                <label for="editStatus">Calling Status:</label>
                                                <asp:DropDownList ID="editCallingStatus" CssClass="form-control" runat="server" ClientIDMode="Static">
                                                    <asp:ListItem Value="0">Not Connected</asp:ListItem>
                                                    <asp:ListItem Value="1">Connected</asp:ListItem>
                                                    <asp:ListItem Value="2">Unreachable</asp:ListItem>
                                                    <asp:ListItem Value="3">Call Later</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="form-group">
                                                <label for="editRemarks" name="editRemarks">Remarks:</label>
                                                <asp:TextBox ID="editRemarks" CssClass="form-control" runat="server"></asp:TextBox>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <asp:Button ID="EnquiryUpdate" CssClass="btn btn-primary" runat="server" OnClick="EnquiryUpdate_Click" Text="Button" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <script>
                            if (window.history.replaceState) {
                                window.history.replaceState(null, null, window.location.href);
                            }
                        </script>
                        <script>
                            function showAlert(title, text, icon) {
                                Swal.fire({
                                    title: title,
                                    text: text,
                                    icon: icon,
                                    confirmButtonText: 'OK'
                                });
                            }
                            var editRowID = '<%= editRow_ID.ClientID %>'
                            var editStatus = '<%= editStatus.ClientID %>'
                            var editRemarks = '<%= editRemarks.ClientID %>'
                            var editCallingStatus = '<%= editCallingStatus.ClientID %>'
                            function editDetails(Row_ID, enquiryDate, name, mobileNumber, city, email, enquiry, imageUrl, status, callingStatus, remarks) {
                                // Populating modal fields and showing the modal
                                $('#' + editRowID).val(Row_ID);
                                $('#editEnquiryDate').val(enquiryDate);
                                $('#editName').val(name);
                                $('#editMobileNumber').val(mobileNumber);
                                $('#editCity').val(city);
                                $('#editEmail').val(email);
                                $('#editEnquiry').val(enquiry);
                                $('#editImage').attr('src', imageUrl);
                                // Set the selected text for the status dropdown
                                $('#' + editStatus).find('option').filter(function () {
                                    return $(this).text() === status;
                                }).prop('selected', true);
                                $('#' + editRemarks).val(remarks);
                                // Set the selected text for the calling status dropdown
                                $('#' + editCallingStatus).find('option').filter(function () {
                                    return $(this).text() === callingStatus;
                                }).prop('selected', true);

                                $('#editModal').modal('show');
                                // Preventing default behavior of the event
                                event.preventDefault();
                            }
                        </script>
                        <!--Edit modal region ends here-->
                        <table id='dataTable' class='table table-hover'>
                            <thead>
                                <tr>
                                    <th>Row_ID</th>
                                    <th>Enquiry Date</th>
                                    <th>Name</th>
                                    <th>Mobile_Number</th>
                                    <th>City</th>
                                    <th>Email ID</th>
                                    <th>Enquiry</th>
                                    <th>Image</th>
                                    <th>Status</th>
                                    <th>Calling Status</th>
                                    <th>Remarks</th>
                                    <th>Action</th>
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
                                            Response.Write("<td>" + row["Row_ID"] + "</td>");
                                            string formattedDate = ((DateTime)row["Created_Date"]).ToString("yyyy-MM-dd");
                                            Response.Write("<td data-order='" + ((DateTime)row["Created_Date"]).ToString("yyyy-MM-dd") + "'>" + formattedDate + "</td>");
                                            Response.Write("<td>" + row["Name"] + "</td>");
                                            Response.Write("<td>" + row["Mobile_Number"] + "</td>");
                                            Response.Write("<td>" + row["City"] + "</td>");
                                            Response.Write("<td>" + row["Email_ID"] + "</td>");
                                            Response.Write("<td>" + row["Enquiry"] + "</td>");
                                            Response.Write("<td><img src='" + ResolveUrl(row["Image_Url"].ToString()) + "' alt='Image' Height='100' Width='100'></td>");
                                            Response.Write("<td>" + row["Status_Text"] + "</td>");
                                            Response.Write("<td>" + row["Calling_Status_Text"] + "</td>");
                                            Response.Write("<td>" + row["Remarks"] + "</td>");
                                            Response.Write("<td>");
                                            Response.Write("<button class='btn btn-primary' onclick='editDetails(\"" + row["Row_ID"] + "\",\"" + row["Created_Date"] + "\",\"" + row["Name"] + "\", \"" + row["Mobile_Number"] + "\", \"" + row["City"] + "\", \"" + row["Email_ID"] + "\",\"" + row["Enquiry"] + "\",\"" + ResolveUrl(row["Image_Url"].ToString()) + "\",\"" + row["Status_Text"] + "\",\"" + row["Calling_Status_Text"] + "\",\"" + row["Remarks"] + "\")'>Edit</button>");
                                            Response.Write("</td>");
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

            
                    <form class="row row-cols-xxl-1 row-cols-xl-1 row-cols-lg-1 row-cols-md-1 row-cols-1 g-3">
                        <div class="col">
                            <label for="exampleInputEmail1" class="form-label">From Date</label>
                            <input type="date" id="fromDate" class="form-control">
                        </div>
                        <div class="col">
                            <label for="exampleInputEmail1" class="form-label">From Date</label>
                            <input type="date" id="toDate" class="form-control" aria-describedby="emailHelp">
                        </div>
                        <div class="col">
                            <label for="exampleInputPassword1" class="form-label">Name</label>
                            <input type="text" id="Name" class="form-control" />
                        </div>
                        <div class="col">
                            <label for="exampleInputPassword1" class="form-label">City</label>
                            <input type="text" id="City" class="form-control" />
                        </div>
                        <div class="col">
                            <label for="exampleInputPassword1" class="form-label">Email</label>
                            <input type="text" id="Email" class="form-control" />
                        </div>
                        <div class="col">
                            <label for="exampleInputPassword1" class="form-label">Mobile</label>
                            <input type="text" id="Mobile" class="form-control" />
                        </div>
                       <div class="col">
                        <button type="button" id="applyFilters" class="btn btn-primary">Submit</button>
                        <button type="reset" class="btn btn-primary">reset</button>
                       </div>
                    </form>
            
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
                pageLength: 25,
                scrollY: 400, // Set the height for vertical scrolling (adjust as needed)
                scrollX: true, // Enable horizontal scrolling
                scrollCollapse: true, // Enable collapsing of the table when scrolling
                scroller: true // Enable the Scroller extension
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

