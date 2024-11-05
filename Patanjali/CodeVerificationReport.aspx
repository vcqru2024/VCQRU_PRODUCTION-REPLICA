<%@ Page Title="" Language="C#" MasterPageFile="~/Patanjali/pfl.master" AutoEventWireup="true" CodeFile="CodeVerificationReport.aspx.cs" Inherits="Patanjali_CodeVerificationReport" %>

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
                            <li class="breadcrumb-item"><a href="../Patanjali/dashboard.aspx">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Code Verification</li>
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
                       <%-- <div class="col-12 col-md-4 mb-3">
                            <div class="global-search">
                                <div class="form-group ">
                                    <input type="search" class="form-control" placeholder="Search">
                                    <span><i class="fa fa-search"></i></span>
                                </div>
                            </div>
                        </div>--%>
                        <div class="col">
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
                                    <th>Product Name</th>
                                    <th>Complete Code</th>
                                    <th>Image Verification Status</th>
                                    <th>Status</th>
                                    <th>Final Status</th>
                                    <th>Mobile NO</th>
                                    <th>Mode Of Verification </th>
                                    <th>Remarks</th>
                                    <th>User location</th>
                                    <th>Lat</th>
                                    <th>Long</th>
                                    <th>Pincode</th>
                                    <th>District</th>
                                    <th>State</th>
                                    <th>Manufacturing Date</th>
                                    <th>Expiry Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%

                                    // Assuming you have a method in your code-behind to fetch data from the database
                                    DataSet ds = getdataset();
                                    DataTable dt = new DataTable();
                                    if (ds.Tables.Count > 0)
                                    {
                                        dt = ds.Tables[0]; // Access the first table in the DataSet
                                                           // Proceed with further operations on dt...
                                    }// You need to implement this method in your code-behind
                                    else
                                    {
                                        dt = null;
                                    }

                                    if (dt != null && dt.Rows.Count > 0)
                                    {
                                        foreach (DataRow row in dt.Rows)
                                        {
                                            Response.Write("<tr>");
                                            //Convert EnquiryDate to "dd-mm-yyyy" format
                                            string formattedDate = ((DateTime)row["enquiry_date"]).ToString("yyyy-MM-dd HH:MM:ss.fff");
                                             string formattedMan = row["Manufactured_date"] != DBNull.Value ? ((DateTime)row["Manufactured_date"]).ToString("yyyy-MM-dd") : string.Empty;
                                            string formattedExp = row["Expiry_date"] != DBNull.Value ? ((DateTime)row["Expiry_date"]).ToString("yyyy-MM-dd") : string.Empty;
                                            Response.Write("<td data-order='" + ((DateTime)row["enquiry_date"]).ToString("yyyy-MM-dd HH:MM:ss.fff") + "'>" + formattedDate + "</td>");
                                            Response.Write("<td>" + row["Product_name"] + "</td>");
                                            Response.Write("<td>" + row["completecode"] + "</td>");
                                            Response.Write("<td>" + row["Image Verification Status"] + "</td>");
                                            Response.Write("<td>" + row["status"] + "</td>");
                                            Response.Write("<td>" + row["Final Status"] + "</td>");
                                            Response.Write("<td>" + row["mobile_number"] + "</td>");
                                            Response.Write("<td>" + row["mode_of_verification"] + "</td>");
                                            Response.Write("<td>" + row["remarks"] + "</td>");
                                            Response.Write("<td>" + row["User Location"] + "</td>");
                                            Response.Write("<td>" + row["Latitude"] + "</td>");
                                            Response.Write("<td>" + row["Longitude"] + "</td>");
                                             Response.Write("<td>" + row["PinCode"] + "</td>");
                                             Response.Write("<td>" + row["district"] + "</td>");
                                            Response.Write("<td>" + row["State"] + "</td>");
                                            Response.Write("<td data-order='" + formattedMan + "'>" + formattedMan + "</td>");
                                            Response.Write("<td data-order='" + formattedExp + "'>" + formattedExp + "</td>");
                                           
                                            Response.Write("</tr>");
                                        }
                                    }
                                    else
                                    {
                                        Response.Write("");
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasRightLabel">Filter</h5>
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">
                <div class="row row-cols-xxl-1 row-cols-xl-1 row-cols-lg-1 row-cols-md-1 row-cols-1 g-3">
                    <div class="col">
                        <label class="form-label">Service</label>
                        <asp:DropDownList ID="ddlservice" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="ddlservice_SelectedIndexChanged" />
                        <asp:RequiredFieldValidator ID="rfvservice" CssClass="invalid-feedback" ControlToValidate="ddlservice" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col">
                        <label class="form-label">Product Name</label>
                        <asp:ListBox ID="liproname" runat="server" CssClass="form-control" SelectionMode="Multiple" />
                    </div>
                    <div class="col">
                        <label class="form-label">Location</label>
                        <asp:ListBox ID="listate" runat="server" CssClass="form-control" SelectionMode="Multiple" />
                    </div>
                    <div class="col">
                        <asp:DropDownList ID="ddlRemarks" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>
                    <div class="col">
                        <asp:TextBox ID="Mobile" runat="server" CssClass="form-control" placeholder="Mobile No." maxlength="10" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value.length !== 10) this.setCustomValidity('Phone number must be exactly 10 digits.'); else this.setCustomValidity('');" />
                    </div>
                    <div class="col">
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                            <asp:ListItem Text="--Select Status--"></asp:ListItem>
                            <asp:ListItem Text="Success"></asp:ListItem>
                            <asp:ListItem Text="Repeated"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col">
                        <label class="form-label">From date</label>
                        <input type="date" id="txtfromdate" runat="server" class="form-control" />
                    </div>
                    <div class="col">
                        <label class="form-label">To date</label>
                        <input type="date" id="txtTodate" runat="server" class="form-control" />
                    </div>
                    <div class="col sticky-bottom bg-white">
                        <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary px-3" Text="Search" OnClick="Button1_Click" />
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
                    ['10   ', '25   ', '50   ', 'Show all']
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
                var productname = $('#productname').val();
                var mobileno = $('#mobileno').val();
                var completecode = $('#completecode').val();

                // Convert fromDate and toDate to match the table format
                var formattedFromDate = convertDateFormat(fromDate);
                var formattedToDate = convertDateFormat(toDate);

                // Remove previous search functions
                $.fn.dataTable.ext.search = [];

                // Add custom search function
                $.fn.dataTable.ext.search.push(
                    function (settings, data, dataIndex) {
                        var productNameMatch = true;
                        var dateMatch = true;

                        // Check productName
                        if (productname !== '') {
                            productNameMatch = data[1].toLowerCase().includes(productname.toLowerCase());
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

                        return productNameMatch && dateMatch;
                    }
                );

                // Apply mobile search
                dataTable.column(6).search(mobileno);
                dataTable.column(4).search(completecode);
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

