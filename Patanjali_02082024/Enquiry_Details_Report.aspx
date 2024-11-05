<%@ Page Title="" Language="C#" MasterPageFile="~/Patanjali/pfl.master" AutoEventWireup="true" CodeFile="Enquiry_Details_Report.aspx.cs" Inherits="Patanjali_Enquiry_Details_Report" %>

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
                            <li class="breadcrumb-item"><a href="../Patanjali/dashboard.aspx">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Enquiry Details Report</li>
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
                                        <i
                                            class='bx bxs-filter-alt'></i>filter</button>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="app-table">
                        <div class='table-responsive'>
                            <table id='dataTable' class='table table-hover'>
                                <thead>
                                    <tr>
                                       <th>Enquiry Date</th>
                                        <th>Product Name</th>
                                        <th>Enquiry Mode</th>
                                        <th>Enquiry Details</th>
                                        <th>Complete Code</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        DataTable dt = GetDataFromDatabase();

                                        if (dt != null && dt.Rows.Count > 0)
                                        {
                                            foreach (DataRow row in dt.Rows)
                                            {
                                                Response.Write("<tr>");
                                                string formattedDate = ((DateTime)row["Enquiry Date"]).ToString("yyyy-MM-dd HH:MM:ss");
                                                Response.Write("<td data-order='" + ((DateTime)row["Enquiry Date"]).ToString("yyyy-MM-dd HH:MM:ss") + "'>" + formattedDate + "</td>");
                                                Response.Write("<td>" + row["Product Name"] + "</td>");
                                                Response.Write("<td>" + row["Enquiry Mode"] + "</td>");
                                                Response.Write("<td>" + row["Enquiry Details"] + "</td>");
                                                Response.Write("<td>" + row["Code1"] + row["Code2"] + "</td>");
                                                Response.Write("<td>" + row["Status"] + "</td>");
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
            <h5 class="offcanvas-title" id="offcanvasRightLabel">Filter</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">
            <div class="row row-cols-xxl-1 row-cols-xl-1 row-cols-lg-1 row-cols-md-1 row-cols-1 g-3">
                <div class="col">
                    <label class="form-label">From date</label>
                    <input type="date" id="txtfromdate" runat="server" class="form-control" />
                    <div class="invalid-feedback">here</div>
                </div>
                <div class="col">
                    <label class="form-label">To date</label>
                    <input type="date" id="txtTodate" runat="server" class="form-control" />
                    <div class="invalid-feedback">here</div>
                </div>
                <div class="col">
                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="Search" />
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
             var offcanvasElement = document.getElementById('offcanvasRight');
             var offcanvas = new bootstrap.Offcanvas(offcanvasElement);
             $('#applyFilters').on('click', function () {
                 var state = $('#state').val();
                 $.fn.dataTable.ext.search = [];
                 dataTable
                     .column(0) // Mobile column
                     .search(state)
                     .draw();
                 offcanvas.hide();
             });

            
             function convertDateFormat(dateString) {
                 var parts = dateString.split('/');
                 if (parts.length === 3) {
                     return parts[2] + '-' + parts[1] + '-' + parts[0]; 
                 }
                 return dateString; 
             }
         });
     </script>
    <script>
      
        (() => {
            'use strict'
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

