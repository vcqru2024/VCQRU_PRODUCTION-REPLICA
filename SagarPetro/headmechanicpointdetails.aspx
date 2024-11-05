<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="headmechanicpointdetails.aspx.cs" Inherits="SagarPetro_headmechanicpointdetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid home-section">
        <div class="app-breadcrumb">
            <div class="row">
                <div class="col">
                    <h5>User Score Details</h5>
                </div>
                <div class="col">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Head Mechanic Point Details</li>
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
                        <div class="col-md-2">
                            <strong>Select User Type</strong>
                            <asp:DropDownList ID="ddlusertype" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Select User Type" Value="" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Head Mechanic" Value="6"></asp:ListItem>
                                <asp:ListItem Text="Assistant Mechanic" Value="7"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2">
                            <strong>From Date</strong>
                            <div class="input-group date" data-provide="datepicker">
                                <asp:TextBox ID="txtfromdate" AutoComplete="off" runat="server" CssClass="form-control" MaxLength="10" placeholder="MM/DD/YYYY"></asp:TextBox>
                                <cc1:CalendarExtender runat="server" ID="txtfromdate_ce" Format="dd-MMM-yyyy" PopupButtonID="txtfromdate"
                                    TargetControlID="txtfromdate">
                                </cc1:CalendarExtender>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <strong>To Date</strong>
                            <div class="input-group date" data-provide="datepicker">
                                <asp:TextBox ID="txttodate" AutoComplete="off" runat="server" CssClass="form-control" MaxLength="10" placeholder="MM/DD/YYYY"></asp:TextBox>
                                <cc1:CalendarExtender runat="server" ID="txttodate_ce" Format="dd-MMM-yyyy" Animated="False"
                                    PopupButtonID="txttodate" TargetControlID="txttodate">
                                </cc1:CalendarExtender>
                            </div>
                        </div>
                        <div class="col-md-2" style="margin-top: 1.5rem !important;">
                            <asp:Button ID="btnsearch" runat="server" Text="Search" OnClick="btnsearch_Click" CssClass="btn btn-primary" />
                        </div>
                    </div>

                </div>
            </div>
            <div class="card">
                <div class="card-body">
                    <div class="app-table table-responsive">
                        <% 
                            DataTable dt = GetDataFromDatabase(ddlusertype.SelectedItem.Value,txtfromdate.Text,txttodate.Text);
                            StringBuilder tableHtml = new StringBuilder();
                            tableHtml.Append("<table id='dataTable' class='table table-hover table-striped table-bordered'>");
                            tableHtml.Append("<thead>" +
                                "<tr>" +
                                "<th>#</th>" +
                                "<th>Mobile Number</th>" +
                                "<th>Consumer Name</th>" +
                                "<th>KYC Status</th>" +
                                "<th>Points</th>" +
                                "<th>Available Amount</th>" +
                                "</tr>" +
                                "</thead>");
                            tableHtml.Append("<tbody>");

                            if (dt != null && dt.Rows.Count > 0)
                            {
                                int rowIndex = 1;
                                foreach (DataRow row in dt.Rows)
                                {
                                    tableHtml.Append("<tr>");
                                    tableHtml.AppendFormat("<td>{0}</td>", rowIndex);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["Mobile Number"]);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["Consumer Name"]);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["KYC"]);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["Points"]);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["Available Amount"]);
                                    tableHtml.Append("</tr>");
                                    rowIndex++;
                                }
                            }
                            else
                            {
                                tableHtml.Append("<tr><td colspan='11'>No data available</td></tr>");
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

