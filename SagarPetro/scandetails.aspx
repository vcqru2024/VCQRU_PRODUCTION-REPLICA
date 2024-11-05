<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="scandetails.aspx.cs" Inherits="SagarPetro_scandetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid home-section">
        <div class="app-breadcrumb">
            <div class="row">
                <div class="col">
                    <h5>User Score Score Details</h5>
                </div>
                <div class="col">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">User Wise Score Details</li>
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
                            <strong>Select State</strong>
                            <asp:DropDownList ID="ddlstate" runat="server"  CssClass="form-control">
                                <asp:ListItem Text="Select State" Value="" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Andhra Pradesh" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Telangana" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2">
                            <strong>Select District</strong>
                            <asp:DropDownList ID="ddlcity" AutoPostBack="true" OnSelectedIndexChanged="ddlcity_SelectedIndexChanged" runat="server" CssClass="form-control">
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
                        <table id='dataTable' class='table table-hover table-striped table-bordered'>
                            <thead>
                                <tr>
                                    <th>#</th>
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
                                    <th>Available Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater runat="server" ID="rptData">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%#Container.ItemIndex+1 %></td>
                                            <td><%# Eval("Enquiry Date") %></td>
                                            <td><%# Eval("Success") %></td>
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

   
</asp:Content>

