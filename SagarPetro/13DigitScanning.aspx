<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="13DigitScanning.aspx.cs" Inherits="Patanjali_13DigitScanning" %>

<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>consumer report</title>
    <!-- Bootstrap css -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" />
    <!-- css -->
    <link rel="stylesheet" href="../SagarPetro/css/css.css" />
    <link rel="stylesheet" href="../SagarPetro/css/reponsive.css" />
    <!-- font family -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
        rel="stylesheet" />
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet' />
    <!-- font-awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- DataTables Buttons CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.9/css/buttons.bootstrap5.min.css" />
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="sidebar" id="sidebar">
        <div class="menu-bar">
            <div class="menu">
                <li class="search-box">
                    <i class='bx bx-search icon'></i>
                    <input type="text" placeholder="Search..." />
                </li>
                <ul class="menu-links">
                    <li class="nav-link">
                        <a href="#">
                            <i class='bx bx-home-alt icon'></i>
                            <span class="text nav-text">Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-link">
                        <a href="#">
                            <i class='bx bx-bar-chart-alt-2 icon'></i>
                            <span class="text nav-text">Revenue</span>
                        </a>
                    </li>
                    <li class="nav-link">
                        <a href="#">
                            <i class='bx bx-bell icon'></i>
                            <span class="text nav-text">Notifications</span>
                        </a>
                    </li>
                    <li class="nav-link">
                        <a href="#">
                            <i class='bx bx-pie-chart-alt icon'></i>
                            <span class="text nav-text">Analytics</span>
                        </a>
                    </li>
                    <li class="nav-link">
                        <a href="#">
                            <i class='bx bx-heart icon'></i>
                            <span class="text nav-text">Likes</span>
                        </a>
                    </li>
                    <li class="nav-link">
                        <a href="#">
                            <i class='bx bx-wallet icon'></i>
                            <span class="text nav-text">Wallets</span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="bottom-content">
                <li class="nav-link">
                    <a href="#">
                        <i class='bx bx-log-out icon'></i>
                        <span class="text nav-text">Logout</span>
                    </a>
                </li>
            </div>
        </div>
    </div>
    <!-- Nav-topbar -->
    <div class="app-top-bar">
        <div class="container-fluid">
            <nav class="navbar navbar-expand-lg">
                <div class="container-fluid">
                    <div class="logo-part">
                        <div class="patanjaliayurved">
                            <img src="img/logo.svg" alt="logo" class="patanjali-logo">
                        </div>
                        <button class="toggle btn btn-primary" id="toggle" type="button">
                            <i class='bx bx-menu'></i>
                        </button>
                    </div>
                    <div class="dropdown">
                        <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            <img src="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=1780&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                                alt="User">
                            <div>
                                <h6>Dropdown button</h6>
                                <p>user profile</p>
                            </div>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">Action</a></li>
                            <li><a class="dropdown-item" href="#">Another action</a></li>
                            <li><a class="dropdown-item" href="#">Something else here</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- end-topbar -->
    <div class="page-wrapper">
        <div class="home-section">
            <div class="app-breadcrumb">
                <div class="row">
                    <div class="col">
                        <h5>13 Digit Mobile No Wise Scanning</h5>
                    </div>
                    <div class="col">
                        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#">home-section</a></li>
                                <li class="breadcrumb-item active" aria-current="page">13 Digit Mobile No Wise Scanning</li>
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
                            <div class="col col-md-4 mb-3">
                                <div class="global-search">
                                    <div class="form-group ">
                                        <input type="search" class="form-control" placeholder="Search" />
                                        <span><i class="fa fa-search"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="col mb-3">
                                <ul class="action-button-global">
                                    <li>
                                        <button class="btn btn-sm btn-light" type="button">
                                            <i
                                                class="bx bxs-download"></i>
                                            Export</button>
                                    </li>
                                    <li>
                                        <button class="btn btn-sm btn-light" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                                            <i
                                                class='bx bxs-filter-alt'></i>filter</button>
                                    </li>
                                    <li>
                                        <a href="#" class="btn btn-sm btn-primary"><i class='bx bx-plus'></i>add</a>
                                    </li>
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
                                    Response.Write("<thead><tr><th>Complete_Code</th><th>Mobile Number</th><th>Reverified Count</th><th>LastCheckTimeStamp</th></tr></thead>");
                                    Response.Write("<tbody>");
                                    foreach (DataRow row in dt.Rows)
                                    {
                                        Response.Write("<tr>");
                                        // Convert EnquiryDate to "dd-mm-yyyy" format
                                        //string formattedDate = ((DateTime)row["Entry_Date"]).ToString("yyyy-MM-dd");
                                        //Response.Write("<td data-order='" + ((DateTime)row["Entry_Date"]).ToString("yyyy-MM-dd") + "'>" + formattedDate + "</td>");
                                        Response.Write("<td>" + row["Complete_Code"] + "</td>");
                                        Response.Write("<td>" + row["Mobile Number"] + "</td>");
                                        Response.Write("<td>" + row["Reverified Count"] + "</td>");
                                        Response.Write("<td>" + row["LastCheckTimeStamp"] + "</td>");
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
            <!-- footer -->
            <footer class="footer inside-footer">
                <div class="container-fluid">
                    <p class="text-end">© 2024 Patanjali Ayurved Limited All Rights Reserved.</p>
                </div>
            </footer>
            <!-- footer-end -->
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
                            <label for="exampleInputPassword1" class="form-label">Complete_Code</label>
                            <input type="text" id="Complete_Code" class="form-control" />
                        </div>
                        <div class="mb-3">
                            <label for="exampleInputPassword1" class="form-label">Mobile Number</label>
                            <input type="text" id="Mobile Number" class="form-control" />
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
                dom: 'Blfrtip', // Added 'l' for length menu
                buttons: [
                    'copy', 'csv', 'excel', 'pdf', 'print'
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
                var Complete_Code = $('#Complete_Code').val();
                var Mobile Number = $('#Mobile Number').val();

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
                    .column(1) // Mobile column
                    .search(mobileno).column(0).search(Complete_Code)
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

