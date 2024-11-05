<%@ Page Title="" Language="C#" MasterPageFile="~/Patanjali/pfl.master" AutoEventWireup="true" CodeFile="newuser.aspx.cs" Inherits="Patanjali_newuser" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="home-section">
        <div class="app-breadcrumb">
            <div class="row">
                <div class="col">
                    <h5>User Control</h5>
                </div>
                <div class="col">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="../Patanjali/dashboard.aspx">Dashboard</a></li>
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
                                    <input type="search" id="searchInput" onkeyup="performSearch(this.value)" class="form-control" placeholder="Search">
                                    <span><i class="fa fa-search"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="col mb-3">
                            <ul class="action-button-global">
                               <%-- <li>
                                    <button class="btn btn-sm btn-light" id="exportButton" type="button" runat="server">
                                        <i
                                            class="bx bxs-download"></i>
                                        Export</button>
                                </li>--%>
                               <%-- <li>
                                    <button class="btn btn-sm btn-light" type="button">
                                        <i
                                            class='bx bxs-filter-alt'></i>filter</button>
                                </li>--%>
                                <li>
                                    <a href="../Patanjali/adduser.aspx" class="btn btn-sm btn-primary"><i class='bx bx-plus'></i>add User</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="app-table">
                        <div class="table-responsive">
                            <table class="table table-hover table-striped" id="dataTable">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">User Name</th>
                                        <th scope="col">User Email</th>
                                        <th scope="col">User Mobile</th>
                                        <th scope="col">Created Date</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">edit</th>
                                        <th scope="col">Action</th>
                                        <th scope="col">Delete</th>
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
                                                    <a type="button" class="dropdown-item"
                                                        href='../Patanjali/adduser.aspx?id=<%# Eval("UserRole_id") %>'>
                                                        <i class="bx bxs-message-square-edit"></i>
                                                        edit</a>
                                                </td>
                                                <td>
    <button type="button" class='<%# Eval("Status").ToString().Equals("active", StringComparison.OrdinalIgnoreCase) ? "btn btn-danger btn-sm w-100 py-0" : "btn btn-success btn-sm w-100 py-0" %>'
            onclick="Activeinactive('<%# Eval("UserRole_id") %>')">
        <span><%# Eval("Status").ToString().Equals("active", StringComparison.OrdinalIgnoreCase) ? "Deactivate" : "Activate" %></span>
    </button>
</td>

                                                <td>
                                                    <a type="button" class="dropdown-item" href="javascript:void(0);" onclick="deleteUser('<%# Eval("UserRole_id") %>')">
                                                        <i class="fas fa-trash-alt"></i> Delete
                                                    </a>
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

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">

        function performSearch(searchText) {
            $('#dataTable tbody tr').each(function () {
                var row = $(this);
                var found = false;

                row.find('td').each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.includes(searchText.toLowerCase())) {
                        found = true;
                        return false; // Exit the loop if found
                    }
                });

                if (found) {
                    row.show();
                } else {
                    row.hide();
                }
            });
        }

        $(document).ready(function () {
            
            //$('#searchInput').on('keyup', function () {
            //    var searchText = $(this).val().toLowerCase();
            //    alert(searchText);
            //    $('#dataTable tbody tr').each(function () {
            //        var row = $(this);
            //        var found = false;
                    
            //        row.find('td').each(function () {
            //            var cellText = $(this).text().toLowerCase();
            //            if (cellText.includes(searchText)) {
            //                found = true;
            //                return false;
            //            }
            //        });
            //        if (found) {
            //            row.show();
            //        } else {
            //            row.hide();
            //        }
            //    });
            //});

        });


        function deleteUser(userId) {
            if (confirm('Are you sure you want to delete this user?')) {
                Deletenow(userId, onSuccess, onError);
            }
        }

        function onSuccess(result) {
            alert(result);
            window.location.reload();
        }

        function onError(error) {
            alert(error.get_message());
        }

        function Deletenow(userId) {
            
            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                url: '../Info/PatanjaliHandler.ashx?method=DeleteUser&UserRoleId=' + userId,
                success: function (data) {
                    if (data == "User Deleted Successfully") {
                        showAlert('Success', data, 'success');
                        location.reload();
                    }
                    else {
                        showAlert('Error', data, 'error');
                    }
                }
            });
        }

        function Activeinactive(userId) {
            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                url: '../Info/PatanjaliHandler.ashx?method=ActiveInactiveUser&UserRoleId=' + userId,
                success: function (data) {
                    if (data == "User Activated Successfully" || data == "User De-Activated Successfully") {
                        showAlert('Success', data, 'success');
                        setTimeout(function () {
                            location.reload();
                        }, 700); // Reload after 3 seconds (3000 milliseconds)
                    }
                    else {
                        showAlert('Error', data, 'error');
                    }
                }

            });
          
        }

    </script>
</asp:Content>

