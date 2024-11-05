<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="compcodewisereport.aspx.cs" Inherits="Patanjali_compcodewisereport" %>

<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="home-section">
        <div class="app-breadcrumb">
            <div class="row">
                <div class="col">
                    <h5>Complete Code Wise Status Count Report</h5>
                </div>
                <div class="col">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Complete Code Wise Status Count</li>
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
                                <%-- <li>
                                    <button class="btn btn-sm btn-light" type="button">
                                        <i
                                            class="bx bxs-download"></i>
                                        Export</button>
                                </li>--%>
                                <li>
                                    <button class="btn btn-sm btn-light" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                                        <i
                                            class='bx bxs-filter-alt'></i>filter</button>
                                </li>
                                <%-- <li>
                                    <a href="#" class="btn btn-sm btn-primary"><i class='bx bx-plus'></i>add</a>
                                </li>--%>
                            </ul>
                        </div>
                    </div>
                    <div class="app-table">
                        <%

                            // Assuming you have a method in your code-behind to fetch data from the database
                            DataTable dt = GetDataFromDatabase(); // You need to implement this method in your code-behind

                            if (dt != null && dt.Rows.Count > 0)
                            {
                                Response.Write("<table id='dataTable' class='table table-hover'>");
                                Response.Write("<thead><tr><th>Complete Code</th><th>Success</th><th>Unsuccess</th><th>Grand Total</th></tr></thead>");
                                Response.Write("<tbody>");
                                foreach (DataRow row in dt.Rows)
                                {
                                    Response.Write("<tr>");
                                    // Convert EnquiryDate to "dd-mm-yyyy" format
                                    //string formattedDate = ((DateTime)row["Entry_Date"]).ToString("yyyy-MM-dd");
                                    //Response.Write("<td data-order='" + ((DateTime)row["Entry_Date"]).ToString("yyyy-MM-dd") + "'>" + formattedDate + "</td>");
                                    Response.Write("<td>" + row["Complete_Code"] + "</td>");
                                    Response.Write("<td>" + row["Success"] + "</td>");
                                    Response.Write("<td>" + row["Unsuccess"] + "</td>");
                                    Response.Write("<td>" + row["Grand Total"] + "</td>");
                                    //Response.Write("<td>" + row["Address"] + "</td>");
                                    //Response.Write("<td>" + row["state"] + "</td>");
                                    Response.Write("</tr>");
                                }

                                Response.Write("</tbody>");
                                Response.Write("</table>");
                            }
                            else
                            {
                                Response.Write("<p>No data available</p>");
                            }
                        %>
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
                        <%--<div class="mb-3">
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
                        </div>--%>
                        <div class="mb-3">
                            <label class="form-label">form date</label>
                            <input type="date" id="txtfromdate" runat="server" class="form-control" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">To date</label>
                            <input type="date" id="txtTodate" runat="server" class="form-control" />
                        </div>
                        <div class="mb-3">
                            <button type="submit" id="applyFilters" class="btn btn-primary">Submit</button>
                            <button type="reset" class="btn btn-primary">reset</button>
                        </div>
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
                    ['10 entries', '25 entries', '50 entries', 'Show all']
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
                //var completecode = $('#completecode').val();

                // Convert fromDate and toDate to match the table format
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
               // dataTable
                //    .column(0) // Mobile column
                 //   .search(completecode)
                   // .draw();

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

