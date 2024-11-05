<%@ Page Title="" Language="C#" MasterPageFile="~/Patanjali/pfl.master" AutoEventWireup="true" CodeFile="pfl13digitmobilenoscaning.aspx.cs" Inherits="Patanjali_pfl13digitmobilenoscaning" %>

<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="home-section">
        <div class="app-breadcrumb">
            <div class="row">
                <div class="col">
                    <h5>13 Digit Mobile No Wise Scanning</h5>
                </div>
                <div class="col">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="../Patanjali/dashboard.aspx">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Code Duplicity</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
        <!-- table view -->
        <div class="user-role-card">
            <div class="card">
                <div class="card-body">
                   
                    <div class="app-table">
                        <table id='dataTable' class='table table-hover'>
                            <thead>
                                <tr>
                                    <th>Complete_Code</th>
                                    <th>Mobile Number</th>
                                    <th>Reverified Count</th>
                                    <th>LastCheckTimeStamp</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    DataTable dt = GetDataFromDatabase(); // You need to implement this method in your code-behind

                                    if (dt != null && dt.Rows.Count > 0)
                                    {
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
                            </tbody>
                        </table>
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
                    ['10 ', '25 ', '50 ', 'Show all']
                ],
                pageLength: 25
            });

          

            
            $('#applyFilters').on('click', function () {
            

              
                var state = $('#state').val();

               
                $.fn.dataTable.ext.search = [];

               
                dataTable
                    .column(0) 
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

