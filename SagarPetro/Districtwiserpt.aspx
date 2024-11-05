<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="Districtwiserpt.aspx.cs" Inherits="SagarPetro_Districtwiserpt" %>

<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="home-section">
        <div class="app-breadcrumb">
            <div class="row">
                <div class="col">
                    <h5>Points earned against product</h5>
                </div>
                <div class="col">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Points earned against product</li>
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
                        <% 
                            DataTable dt = GetDataFromDatabase();
                            StringBuilder tableHtml = new StringBuilder();
                            tableHtml.Append("<table id='dataTable' class='table table-hover'>");
                            tableHtml.Append("<thead><tr><th>Pro Name No</th><th>Total Code Generated</th><th>Success Codes</th><th>Earned Amount</th><th>Pending Codes</th></tr></thead>");
                            tableHtml.Append("<tbody>");

                            if (dt != null && dt.Rows.Count > 0)
                            {
                                foreach (DataRow row in dt.Rows)
                                {
                                    tableHtml.Append("<tr>");
                                    tableHtml.AppendFormat("<td>{0}</td>", row["Pro_Name"]);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["Total Code Generated"]);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["Success Codes"]);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["Earned Amount"]);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["Pending Codes"]);
                                    tableHtml.Append("</tr>");
                                }
                            }
                            else
                            {
                                tableHtml.Append("<tr><td colspan='4'>No data available</td></tr>");
                            }

                            tableHtml.Append("</tbody>");
                            tableHtml.Append("</table>");
                            Response.Write(tableHtml.ToString());
                        %>
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

            var offcanvasElement = document.getElementById('offcanvasRight');
            var offcanvas = new bootstrap.Offcanvas(offcanvasElement);
            $('#applyFilters').on('click', function () {
                debugger;
                $.fn.dataTable.ext.search = [];

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
</asp:Content>


