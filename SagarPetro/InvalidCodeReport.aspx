<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="InvalidCodeReport.aspx.cs" Inherits="Patanjali_InvalidCodeReport" %>

<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="home-section">
        <div class="app-breadcrumb">
            <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1 g-3">
                <div class="col">
                    <h5>Users Records</h5>
                </div>
                <div class="col">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                           <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Users Records</li>
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
                        <div class="col">
                            <ul class="action-button-global">
                                <li>
                                    <button class="btn btn-sm btn-light" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                                        <i class="bx bxs-filter-alt"></i>filter</button>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="app-table">
                        <div class='table-responsive'>
                            <table id='dataTable' class='table table-hover table-bordered mb-0'>
                                <thead>
                                    <tr>
                                        <th>Enquiry Date</th>
                                        <th>Complete Code</th>
                                        <th>Mobile No</th>
                                        <th>Consumer Name</th>
                                        <th>Village</th>
                                        <th>District</th>
                                        <th>City</th>
                                        <th>Pin Code</th>
                                        <th>State</th>
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
                                                // Convert EnquiryDate to "dd-mm-yyyy" format
                                                string formattedDate = ((DateTime)row["Enquiry Date"]).ToString("yyyy-MM-dd");
                                                Response.Write("<td data-order='" + ((DateTime)row["Enquiry Date"]).ToString("yyyy-MM-dd") + "'>" + formattedDate + "</td>");
                                                Response.Write("<td>" + row["Complete_Code"] + "</td>");
                                                Response.Write("<td>" + row["MobileNo"] + "</td>");
                                                Response.Write("<td>" + row["Consumer Name"] + "</td>");
                                                Response.Write("<td>" + row["Village"] + "</td>");
                                                Response.Write("<td>" + row["District"] + "</td>");
                                                Response.Write("<td>" + row["City"] + "</td>");
                                                Response.Write("<td>" + row["PinCode"] + "</td>");
                                                Response.Write("<td>" + row["State"] + "</td>");

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
            <div class="row row-cols-xxl-1 row-cols-xl-1 row-cols-lg-1 row-cols-md-1 row-cols-1 g-3">
                <div class="col">
                    <label class="form-label">form date</label>
                    <input type="date" id="txtfromdate" runat="server" class="form-control" />
                    <div class="invalid-feedback">here</div>
                </div>
                <div class="col">
                    <label class="form-label">To date</label>
                    <input type="date" id="txtTodate" runat="server" class="form-control" />
                    <div class="invalid-feedback">here</div>
                </div>
                <div class="col">
                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="Search" OnClick="Button1_Click" />
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
                var state = $('#state').val();

                //// Convert fromDate and toDate to match the table format
                //var formattedFromDate = convertDateFormat(fromDate);
                //var formattedToDate = convertDateFormat(toDate);

                // Remove previous search functions
                $.fn.dataTable.ext.search = [];

                // Add custom search function
                //$.fn.dataTable.ext.search.push(
                //    function (settings, data, dataIndex) {
                //        var consumerNameMatch = true;
                //        var dateMatch = true;

                //        // Check productName
                //        if (consumerName !== '') {
                //            consumerNameMatch = data[1].toLowerCase().includes(consumerName.toLowerCase());
                //        }

                //        // Check date range
                //        var currentDate = new Date(data[0]); // Assuming EnquiryDate is in the first column
                //        var minDate = new Date(formattedFromDate);
                //        var maxDate = new Date(formattedToDate);

                //        if (!isNaN(minDate) && currentDate < minDate) {
                //            dateMatch = false;
                //        }
                //        if (!isNaN(maxDate) && currentDate > maxDate) {
                //            dateMatch = false;
                //        }

                //        return consumerNameMatch && dateMatch;
                //    }
                //);

                // Apply mobile search
                dataTable
                    .column(0) // Mobile column
                    .search(state)
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

