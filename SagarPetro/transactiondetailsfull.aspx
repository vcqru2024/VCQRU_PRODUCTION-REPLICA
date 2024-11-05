<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true"
    CodeFile="transactiondetailsfull.aspx.cs" Inherits="SagarPetro_transactiondetailsfull" %>

    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
        <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
            <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
            <div class="container-fluid home-section">
                <div class="app-breadcrumb">
                    <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1 g-3">
                        <div class="col">
                            <h5>Transaction Details</h5>
                        </div>
                        <div class="col">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Transaction Details Report
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
                            <div class="row row-cols-xxl-5 row-cols-xxl-5 row-cols-lg-5 row-cols-md-3 row-cols-1 g-3">
                                <div class="col">
                                    <label class="form-label">Select State</label>
                                    <asp:DropDownList ID="ddlstate" runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlstate_SelectedIndexChanged" CssClass="form-select">
                                        <asp:ListItem Text="Select State" Value="" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Andhra Pradesh" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Telangana" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col">
                                    <label class="form-label">Select District</label>
                                    <asp:DropDownList ID="ddldistrict" AutoPostBack="true" runat="server"
                                        CssClass="form-select">
                                    </asp:DropDownList>
                                </div>
                                <div class="col">
                                    <label class="form-label">From Date</label>
                                    <div class="input-group date" data-provide="datepicker">
                                        <asp:TextBox ID="txtfromdate" AutoComplete="off" runat="server"
                                            CssClass="form-control" MaxLength="10" placeholder="MM/DD/YYYY">
                                        </asp:TextBox>
                                        <cc1:CalendarExtender runat="server" ID="txtfromdate_ce" Format="dd-MMM-yyyy"
                                            PopupButtonID="txtfromdate" TargetControlID="txtfromdate">
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
                                    <asp:Button ID="btnsearch" runat="server" Text="Search" OnClick="btnsearch_Click"
                                        CssClass="btn btn-primary" />
                                    <button runat="server" onclick="downloadGridData('Transactiondetails')"
                                        class="btn btn-primary">
                                        <i class="fas fa-file-csv"></i>
                                    </button>
                                </div>
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
                            <div class="app-table mt-3">
                                <div class="table-responsive">
                                    <table id='dataTable' class='table table-hover table-bordered mb-0'>
                                        <thead>
                                            <tr>
                                                <th>Sr No</th>
                                                <th>Mobile Number</th>
                                                <th>User Name</th>
                                               <%-- <th>User Email</th>
                                                <th>Designation</th>--%>
                                                <th>City Name</th>
                                                <th>State Name</th>
                                                <th>Role Type</th>
                                                <th>Transaction Date</th>
                                                <th>Amount</th>
                                                <th>Reference ID</th>
                                                <th>Code1</th>
                                                <th>Code2</th>
                                                <th>Status</th>
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
                                                            <%# Eval("Mobile_Number") %>
                                                        </td>
                                                        <td>
                                                            <%# Eval("UserName") %>
                                                        </td>
                                                        <%--<td>
                                                            <%# Eval("UserEmail") %>
                                                        </td>
                                                        <td>
                                                            <%# Eval("Designation") %>
                                                        </td>--%>
                                                        <td>
                                                            <%# Eval("City_Name") %>
                                                        </td>
                                                        <td>
                                                            <%# Eval("State_Name") %>
                                                        </td>
                                                        <td>
                                                            <%# Eval("RoleType") %>
                                                        </td>
                                                        <td>
                                                            <%# Eval("Transaction Date") %>
                                                        </td>
                                                        <td>
                                                            <%# Eval("Amount") %>
                                                        </td>
                                                        <td>
                                                            <%# Eval("Reference ID") %>
                                                        </td>
                                                        <td>
                                                            <%# Eval("Code1") %>
                                                        </td>
                                                        <td>
                                                            <%# Eval("Code2") %>
                                                        </td>
                                                          <td>
                                                            <%# Eval("Status") %>
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
        </asp:Content>