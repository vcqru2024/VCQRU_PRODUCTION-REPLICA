<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="Consumer_Purchase_History_Report.aspx.cs" Inherits="Patanjali_Consumer_Purchase_History_Report" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
           <div class="home-section">
            <div class="app-breadcrumb">
                <div class="row">
                    <div class="col">
                        <h5>Consumer Purchase History Report</h5>
                    </div>
                    <div class="col">
                        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                              <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Consumer Purchase History</li>
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
                           <%-- <div class="col col-md-4 mb-3">
                                <div class="global-search">
                                    <div class="form-group ">
                                        <input type="search" class="form-control" placeholder="Search" />
                                        <span><i class="fa fa-search"></i></span>
                                    </div>
                                </div>
                            </div>--%>
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
                                    Response.Write("<thead><tr><th>MobileNo</th><th>ConsumerName</th><th>State</th><th>Verified Products</th><th>LastCodeCheckTimeStamp</th></tr></thead>");
                                    Response.Write("<tbody>");
                                    foreach (DataRow row in dt.Rows)
                                    {
                                        Response.Write("<tr>");
                                        //string formattedDate = ((DateTime)row["Enquiry Date"]).ToString("yyyy-MM-dd");
                                        //Response.Write("<td data-order='" + ((DateTime)row["Enquiry Date"]).ToString("yyyy-MM-dd") + "'>" + formattedDate + "</td>");
                                        Response.Write("<td>" + row["MobileNo"] + "</td>");
                                        Response.Write("<td>" + row["ConsumerName"] + "</td>");
                                        Response.Write("<td>" + row["State"] + "</td>");
                                        Response.Write("<td>" + row["Verified Products"] + "</td>");
                                        Response.Write("<td>" + row["LastCodeCheckTimeStamp"] + "</td>");
                                        //Response.Write("<td>" + row["Status"] + "</td>");
                                        Response.Write("</tr>");
                                    }

                                    Response.Write("</tbody>");
                                    Response.Write("</table>");
                                }
                                else
                                {
                                    Response.Write("<p class="mb-0">No data available</p>");
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
                      <%--  <div class="mb-3">
                            <label for="exampleInputEmail1" class="form-label">From Date</label>
                            <input type="date" id="fromDate" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="exampleInputEmail1" class="form-label">To Date</label>
                            <input type="date" id="toDate" class="form-control" aria-describedby="emailHelp">
                        </div>--%>
                        <div class="mb-3">
                            <label for="exampleInputPassword1" class="form-label">MobileNo</label>
                            <input type="text" id="MobileNo" class="form-control" />
                        </div>
                    <%--    <div class="mb-3">
                            <label for="exampleInputPassword1" class="form-label">Code1</label>
                            <input type="text" id="Code1" class="form-control" />
                        </div>
                         <div class="mb-3">
                            <label for="exampleInputPassword1" class="form-label">Code2</label>
                            <input type="text" id="Code2" class="form-control" />
                        </div>--%>
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
                dom: 'Blfrtip', // Added 'l' for length menu
                buttons: [
                     'excel'
                ],
                lengthMenu: [ // Define the options for the dropdown
                    [10, 25, 50, -1], // 10, 25, 50, and All
                    ['10 entries', '25 entries', '50 entries', 'Show all']
                ],
                pageLength: 25 // Initial page length
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
                var MobileNo = $('#MobileNo').val();
                //var Code1 = $('#Code1').val();
                //var Code2 = $('#Code2').val();

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
                    .column(0) // Mobile column
                    .search(MobileNo)
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

