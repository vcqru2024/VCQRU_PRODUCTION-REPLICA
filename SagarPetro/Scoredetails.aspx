<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="Scoredetails.aspx.cs" Inherits="SagarPetro_Scoredetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="home-section">
        <div class="app-breadcrumb">
            <div class="row">
                <div class="col">
                    <h5>User Score Details</h5>
                </div>
                <div class="col">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">User Score Details</li>
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
                            <label class="form-label">Select User Type</label>
                            <asp:DropDownList ID="ddlusertype" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Select User Type" Value="" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Head Mechanic" Value="6"></asp:ListItem>
                                <asp:ListItem Text="Assistant Mechanic" Value="7"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col">
                            <label class="form-label">From Date</label>
                            <div class="input-group date" data-provide="datepicker">
                                <asp:TextBox ID="txtfromdate" AutoComplete="off" runat="server" CssClass="form-control" MaxLength="10" placeholder="MM/DD/YYYY"></asp:TextBox>
                                <cc1:CalendarExtender runat="server" ID="txtfromdate_ce" Format="dd-MMM-yyyy" PopupButtonID="txtfromdate"
                                    TargetControlID="txtfromdate">
                                </cc1:CalendarExtender>
                            </div>
                        </div>
                        <div class="col">
                            <label class="form-label">To Date</label>
                            <div class="input-group date" data-provide="datepicker">
                                <asp:TextBox ID="txttodate" AutoComplete="off" runat="server" CssClass="form-control" MaxLength="10" placeholder="MM/DD/YYYY"></asp:TextBox>
                                <cc1:CalendarExtender runat="server" ID="txttodate_ce" Format="dd-MMM-yyyy" Animated="False"
                                    PopupButtonID="txttodate" TargetControlID="txttodate">
                                </cc1:CalendarExtender>
                            </div>
                        </div>
                        <div class="col">
                            <label class="form-label text-white">.</label><br>
                            <asp:Button ID="btnsearch" runat="server" Text="Search" OnClick="btnsearch_Click" CssClass="btn btn-primary" />
                               <button runat="server" onclick="downloadGridData('Score Details')"
                                        class="btn btn-primary">
                                        <i class="fas fa-file-csv"></i>
                                    </button>
                        </div>
                         <div class="row mt-3">
                                <div class="col-lg-4">
                                    <div class="global-search">
                                        <div class="form-group">
                                            <input type="search" id="searchInput" onkeyup="performSearch(this.value)"
                                                class="form-control" placeholder="Search">
                                            <span><i class="fa fa-search"></i></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <div class="app-table mt-3">
                        <div class="table-responsive">
                            <% 
                            DataTable dt = GetDataFromDatabase(ddlusertype.SelectedItem.Value, txtfromdate.Text, txttodate.Text);
                            StringBuilder tableHtml = new StringBuilder();
                            tableHtml.Append("<table id='dataTable' class='table table-hover table-bordered mb-0'>");
                            tableHtml.Append("<thead>" +
                                "<tr>" +
                                "<th>User Name</th>" +
                                "<th>Mobile Number</th>" +
                                "<th>KYC Status</th>" +
                                "<th>District</th>" +
                                "<th>City</th>" +
                                "<th>Pin Code</th>" +
                                "<th>Mechanic Type</th>" +
                                "<th>Date of Birth</th>" +
                                "<th>Gender</th>" +
                                "<th>Marital Status</th>" +
                                "<th>Available Amount</th>" +
                                "</tr>" +
                                "</thead>");
                            tableHtml.Append("<tbody>");

                            if (dt != null && dt.Rows.Count > 0)
                            {
                                foreach (DataRow row in dt.Rows)
                                {
                                    tableHtml.Append("<tr>");
                                    tableHtml.AppendFormat("<td>{0}</td>", row["UserName"]);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["Mobile_Number"]);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["KYC"]);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["District"]);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["City"]);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["Pin Code"]);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["Mechanic Type"]);
                                    tableHtml.AppendFormat("<td>{0:yyyy-MM-dd}</td>", row["Date of Birth"]);

                                    tableHtml.AppendFormat("<td>{0}</td>", row["Gender"]);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["Marital_Status"]);
                                    tableHtml.AppendFormat("<td>{0}</td>", row["Available Amount"]);
                                    tableHtml.Append("</tr>");
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
