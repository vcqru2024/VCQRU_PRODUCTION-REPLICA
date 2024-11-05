<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="codeverification.aspx.cs" Inherits="Patanjali_codeverification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="home-section">
        <div class="app-breadcrumb">
            <div class="row">
                <div class="col">
                    <h5>User Control</h5>
                </div>
                <div class="col">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="#">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Our User Role</li>
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
                        <div class="col col-md-4 mb-3">
                            <div class="global-search">
                                <div class="form-group ">
                                    <input type="search" id="searchInput" class="form-control" placeholder="Search">
                                    <span><i class="fa fa-search"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="col mb-3">
                            <ul class="action-button-global">
                                <li>
                                    <button class="btn btn-sm btn-light" id="exportButton" type="button" runat="server">
                                        <i
                                            class="bx bxs-download"></i>
                                        Export</button>
                                </li>
                                <li>
                                    <button class="btn btn-sm btn-light" type="button">
                                        <i
                                            class='bx bxs-filter-alt'></i>filter</button>
                                </li>
                               <%-- <li>
                                    <a href="../SagarPetro/adduser.aspx" class="btn btn-sm btn-primary"><i class='bx bx-plus'></i>add</a>
                                </li>--%>
                            </ul>
                        </div>
                    </div>
                    <div class="app-table">
                        <div class="table-responsive">
                            <table class="table table-hover" id="dataTable">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">User Name</th>
                                        <th scope="col">User Email</th>
                                        <th scope="col">User Mobile</th>
                                        <th scope="col">Created Date</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="gvNewUser" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Container.ItemIndex + 1 %></td>
                                                <td><%# Eval("UserName") %></td>
                                                <td><%# Eval("UserEmail") %></td>
                                                <td><%# Eval("UserMobile") %></td>
                                                <td><%# Eval("Created_Date") %></td>
                                                <td><%# Eval("Status") %></td>
                                                <td>
                                                    <div class="action-dropdown">
                                                        <div class="dropdown">
                                                            <button class="btn dropdown-toggle" type="button"
                                                                data-bs-toggle="dropdown" aria-expanded="false">
                                                                <i class="fa-solid fa-ellipsis"></i>
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                <li>
                                                                     <a type="button"  class="dropdown-item"
                                                                        href='../SagarPetro/adduser.aspx?id=<%# Eval("UserRole_id") %>'>
                                                                        <i class="bx bxs-message-square-edit"></i>
                                                                        edit</a>
                                                                    
                                                                </li>
                                                                <li>
                                                                    <%--<asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("RowID") %>' CssClass="dropdown-item text-danger"><i class="bx bxs-trash-alt"></i> Delete</asp:LinkButton>--%>
                                                                    <a class="dropdown-item text-danger" href="#"><i class="bx bxs-trash-alt"></i>delete</a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </td>
                                                <%-- <td class='<%# (Eval("status").ToString().ToUpper()=="SUCCESS"?"btn btn-success":"btn btn-danger") %>'>
                                                <%# Eval("Status") %>
                                            </td>
                                            <td><%# Eval("AddDate") %></td>
                                            <td><a href='AepsReceipt.aspx?ID=<%# Eval("referenceno") %>' style="color: black;" target="_blank">View Receipt</a></td>--%>
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

    <script type="text/javascript">
        $(document).ready(function () {
            $('#searchInput').on('input', function () {
                var searchText = $(this).val().toLowerCase();
                $('#dataTable tbody tr').each(function () {
                    var row = $(this);
                    var found = false;
                    row.find('td').each(function () {
                        var cellText = $(this).text().toLowerCase();
                        if (cellText.includes(searchText)) {
                            found = true;
                            return false;
                        }
                    });
                    if (found) {
                        row.show();
                    } else {
                        row.hide();
                    }
                });
            });
        });

    </script>
</asp:Content>

