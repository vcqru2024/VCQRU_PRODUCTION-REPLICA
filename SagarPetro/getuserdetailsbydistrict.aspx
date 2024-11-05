<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true"
    CodeFile="getuserdetailsbydistrict.aspx.cs" Inherits="SagarPetro_getuserdetailsbydistrict" %>

    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
        <%@ Import Namespace="System.Data" %>
            <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
                <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
            </asp:Content>
            <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
                <div class="home-section">
                    <div class="app-breadcrumb">
                        <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1 g-3">
                            <div class="col">
                                <h5>User Wise Score Details</h5>
                            </div>
                            <div class="col">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a>
                                        </li>
                                        <li class="breadcrumb-item active" aria-current="page">User Wise Score Details
                                        </li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                    <!-- table view -->
                    <div class="user-role-card">
                        <div class="card">
                            <div class="card-body">
                                <div class="row row-cols-xxl-6 row-cols-xl-6 row-cols-lg-4 row-cols-md-3 row-cols-1 g-3">
                                    <div class="col">
                                        <label class="form-label">Select User Type</label>
                                        <asp:DropDownList ID="ddlusertype" runat="server" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlusertype_SelectedIndexChanged"
                                            CssClass="form-select">
                                            <asp:ListItem Text="Select User Type" Value="" Selected="True">
                                            </asp:ListItem>
                                            <asp:ListItem Text="Head Mechanic" Value="6"></asp:ListItem>
                                            <asp:ListItem Text="Assistant Mechanic" Value="7"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col">
                                        <label class="form-label">Select State</label>
                                        <asp:DropDownList ID="ddlstate" runat="server" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlstate_SelectedIndexChanged"
                                            CssClass="form-select">
                                            <asp:ListItem Text="Select State" Value="" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Andhra Pradesh" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Telangana" Value="2"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col">
                                        <label class="form-label">Select District</label>
                                        <asp:DropDownList ID="ddlcity" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlcity_SelectedIndexChanged" runat="server"
                                            CssClass="form-select">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col">
                                        <label class="form-label">From Date</label>
                                        <div class="input-group date" data-provide="datepicker">
                                            <asp:TextBox ID="txtfromdate" AutoComplete="off" runat="server"
                                                CssClass="form-control" MaxLength="10" placeholder="MM/DD/YYYY">
                                            </asp:TextBox>
                                            <cc1:CalendarExtender runat="server" ID="txtfromdate_ce"
                                                Format="dd-MMM-yyyy" PopupButtonID="txtfromdate"
                                                TargetControlID="txtfromdate">
                                            </cc1:CalendarExtender>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label class="form-label">To Date</label>
                                        <div class="input-group date" data-provide="datepicker">
                                            <asp:TextBox ID="txttodate" AutoComplete="off" runat="server"
                                                CssClass="form-control" MaxLength="10" placeholder="MM/DD/YYYY">
                                            </asp:TextBox>
                                            <cc1:CalendarExtender runat="server" ID="txttodate_ce" Format="dd-MMM-yyyy"
                                                Animated="False" PopupButtonID="txttodate" TargetControlID="txttodate">
                                            </cc1:CalendarExtender>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label class="form-label text-white">.</label><br>
                                        <asp:Button ID="btnsearch" runat="server" Text="Search"
                                            OnClick="btnsearch_Click" CssClass="btn btn-primary px-5" />
                                    </div>
                                </div>
                                     <div class="row">
                        <div class="col col-md-1 mb-2 mt-2">
                            <button runat="server" onclick="downloadGridData('Productwisepointearnreport')"
                                class="btn btn-primary">
                                <i class="fas fa-file-csv"></i>
                            </button>
                        </div>
                        <div class="col col-md-4 mb-3 mt-2">
                            <div class="global-search">
                                <div class="form-group">
                                    <input type="search" runat="server" id="searchInput" onkeyup="performSearch(this.value)" class="form-control" placeholder="Search">
                                    <span><i class="fa fa-search"></i></span>
                                </div>
                            </div>

                        </div>
                    </div>
                                <div class="app-table mt-3">
                                    <div class="table-responsive">
                                        <table id='dataTable' class='table table-hover table-bordered mb-0'>
                                            <thead>
                                                <tr>
                                                    <th>Sr No</th>
                                                    <th>User Name</th>
                                                    <th>Mobile Number</th>
                                                    <th>KYC Status</th>
                                                    <th>State</th>
                                                    <th>District</th>
                                                    <th>City</th>
                                                    <th>Pin Code</th>
                                                    <th>Mechanic Type</th>
                                                    <th>Date of Birth</th>
                                                    <th>Gender</th>
                                                    <th>Marital Status</th>
                                                    <th>Total Amount</th>
                                                    <th>Redeem Amount</th>
                                                    <th>Available Amount</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater runat="server" ID="rptData">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <%#Container.ItemIndex+1 %>
                                                            </td>
                                                            <td>
                                                                <%# Eval("UserName") %>
                                                            </td>
                                                            <td>
                                                                <%# Eval("Mobile_Number") %>
                                                            </td>
                                                            <td>
                                                                <%# Eval("KYC") %>
                                                            </td>
                                                            <td>
                                                                <%# Eval("State") %>
                                                            </td>
                                                            <td>
                                                                <%# Eval("District") %>
                                                            </td>
                                                            <td>
                                                                <%# Eval("City") %>
                                                            </td>
                                                            <td>
                                                                <%# Eval("Pin Code") %>
                                                            </td>
                                                            <td>
                                                                <%# Eval("Mechanic Type") %>
                                                            </td>
                                                            <td>
                                                                <%# Eval("Date of Birth") %>
                                                            </td>
                                                            <td>
                                                                <%# Eval("Gender") %>
                                                            </td>
                                                            <td>
                                                                <%# Eval("Marital_Status") %>
                                                            </td>
                                                              <td>
                                                                <%# Eval("Total Amount") %>
                                                            </td>
                                                              <td>
                                                                <%# Eval("Redeem Amount") %>
                                                            </td>
                                                            <td>
                                                                <%# Eval("Available Amount") %>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>
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