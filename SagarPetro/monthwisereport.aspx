<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="monthwisereport.aspx.cs" Inherits="SagarPetro_monthwisereport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
    .gridview {
        width: 100%;
        border-collapse: collapse;
        font-family: Arial, sans-serif;
    }
    .gridview th {
        background-color: #4CAF50; /* Header background color */
        color: white; /* Header text color */
        text-align: center;
        padding: 10px;
    }
     .gridview tr th {
            color: white;
    font-weight: bold;
    }
    .gridview td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }
    .gridview tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .gridview tr:hover {
        background-color: #ddd;
    }
    .gridview th.sort-header {
        cursor: pointer;
    }
    .gridview th, .gridview td {
        white-space: nowrap;
    }
</style>

    <div class="home-section">
        <div class="app-breadcrumb">
            <div class="row">
                <div class="col">
                    <h5>Month Wise Data</h5>
                </div>
                <div class="col">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Month Wise Data</li>
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
                            <asp:DropDownList ID="ddlusertype" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Select User Type" Value="" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Head Mechanic" Value="6"></asp:ListItem>
                                <asp:ListItem Text="Assistant Mechanic" Value="7"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col">
                            <label class="form-label">Select State</label>
                            <asp:DropDownList ID="ddlstate" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlstate_SelectedIndexChanged" CssClass="form-select">
                                <asp:ListItem Text="Select State" Value="-1" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Andhra Pradesh" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Telangana" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col">
                            <label class="form-label">Select District</label>
                            <asp:DropDownList ID="ddlcity" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                      
                        <div class="col">
                            <label class="form-label text-white">.</label><br>
                            <asp:Button ID="btnsearch" runat="server" Text="Search" OnClick="btnsearch_Click" CssClass="btn btn-primary px-5" />
                        </div>
                         <div class="col">
                            <label class="form-label text-white">.</label><br>
                            <asp:Button ID="btndownload" runat="server" Text="Download" OnClick="btndownload_Click" CssClass="btn btn-primary px-5" />
                        </div>
                     
                    </div>
                      
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                    <div class="app-table">
                        <table id='dataTable' class='table table-hover table-striped'>
                            <asp:GridView ID="grdmonthwisereport" runat="server" CssClass="gridview" AutoGenerateColumns="True" GridLines="None" CellPadding="8" AllowSorting="False" AllowPaging="True" PageSize="10" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true"></asp:GridView>

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
