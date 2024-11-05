<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="userroletype.aspx.cs" Inherits="SagarPetro_userroletype" %>

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
                            <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">User Role Type</li>
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
                                <li>
                                    <%--<a href="../SagarPetro/adduser.aspx" class="btn btn-sm btn-primary"><i class='bx bx-plus'></i>New Role Type</a>--%>
                                    <a href="#" class="btn btn-sm btn-primary" id="openModal"><i class='bx bx-plus'></i>New Role Type</a>
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
                                        <th scope="col">Date</th>
                                        <th scope="col">User Type</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">edit</th>
                                        <th scope="col">Activate</th>
                                        <th scope="col">Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="gvNewUser" runat="server">
                                        <itemtemplate>
                                            <tr>
                                                <td><%# Container.ItemIndex + 1 %></td>
                                                <td><%# Eval("Createddate") %></td>
                                                <td><%# Eval("RoleType") %></td>
                                                <td>
                                                    <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Deactive" %>
                                                </td>

                                                <td>
                                                    <a type="button" class="dropdown-item"
                                                        href='../SagarPetro/adduser.aspx?id=<%# Eval("Id") %>'>
                                                        <i class="bx bxs-message-square-edit"></i>
                                                        edit</a>
                                                </td>
                                                <td>

                                                    <a type="button" class="dropdown-item" href="javascript:void(0);" onclick="Activeinactive('<%# Eval("Id") %>')">
                                                        <i class="fas fa-toggle-on"></i>Activate
                                                    </a>
                                                </td>
                                                <td>
                                                    <a type="button" class="dropdown-item" href="javascript:void(0);" onclick="deleteUser('<%# Eval("Id") %>')">
                                                        <i class="fas fa-trash-alt"></i>Delete
                                                    </a>
                                                </td>
                                            </tr>
                                        </itemtemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
               <asp:TextBox ID="txtrolename" CssClass="form-control" runat="server" placeholder="Enter Role Name*" required></asp:TextBox>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary close" data-dismiss="modal">Close</button>
                <%--<button type="button" class="btn btn-primary">Save changes</button>--%>
                <asp:Button ID="btnsavechnages" OnClick="btnsavechnages_Click" runat="server" Text="Save changes" CssClass="btn btn-primary" />
            </div>
        </div>
    </div>
</div>

    <script>
        document.getElementById("openModal").addEventListener("click", function () {
            $('#myModal').modal('show');
        });
        document.querySelectorAll('.close').forEach(function (btn) {
            btn.addEventListener('click', function () {
                $('#myModal').modal('hide');
            });
        });
    </script>

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
                url: '../Info/PatanjaliHandler.ashx?method=DeleteRole&UserRoleId=' + userId,
                success: function (data) {
                    if (data == "User Deleted Successfully") {
                        showAlert('Success', data, 'success');
                        window.location.reload(true);
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
                url: '../Info/PatanjaliHandler.ashx?method=ActiveInactiveRole&UserRoleId=' + userId,
                success: function (data) {
                    if (data == "User Activated Successfully" || data == "User De-Activated Successfully") {
                        showAlert('Success', data, 'success');
                        window.location.reload(true);
                    }
                    else {
                        showAlert('Error', data, 'error');
                    }
                }
            });
        }
    </script>
</asp:Content>

