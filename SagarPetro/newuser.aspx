<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="newuser.aspx.cs" Inherits="Patanjali_newuser" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="home-section">
        <div class="app-breadcrumb">
            <div class="row">
                <div class="col">
                    <h5>User Details</h5>
                </div>
                <div class="col">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a></li>
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
                                <div class="form-group">
                                    <input type="search" runat="server" id="searchInput" onkeyup="performSearch(this.value)" class="form-control" placeholder="Search">
                                    <span><i class="fa fa-search"></i></span>
                                </div>
                            </div>
                             
                        </div>
                        <div class="col mb-3">
                            <ul class="action-button-global">
                                <li>
                                    <a href="../SagarPetro/registeruser.aspx" class="btn btn-sm btn-primary"><i class='bx bx-plus'></i>add User</a>
                                </li>
                            </ul>
                            <button runat="server" style="margin-top:-48px;" onclick="downloaduserData('UserData')"
                                class="btn btn-primary">
                                <i class="fas fa-file-csv"></i>
                            </button>
                        </div>
                    </div>
                    <div class="app-table">
                        <div class="table-responsive">
                            <table class="table table-hover table-striped" id="dataTable">
                                <thead>
                                    <tr>
                                        <th scope="col">Sr No</th>
                                        <th scope="col">User Name</th>
                                        <th scope="col">User Type</th>
                                        <th scope="col">User Email</th>
                                        <th scope="col">User Mobile</th>
                                        <th scope="col">State</th>
                                        <th scope="col">Created Date</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">edit</th>
                                        <th scope="col">Activate/Deactivate</th>
                                        <th scope="col">Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="gvNewUser" runat="server" OnItemDataBound="gvNewUser_ItemDataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Container.ItemIndex + 1 %></td>
                                                <td><%# Eval("UserName") %></td>
                                                <td><%# Eval("RoleType") %></td>
                                                <td><%# Eval("UserEmail") %></td>
                                                <td><%# Eval("Mobile_Number") %></td>
                                                <td><%# Eval("StateName") %></td>
                                                <td><%# Eval("Created_Date") %></td>
                                                <td><%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %></td>
                                                <td>
                                                    <a type="button" class="dropdown-item" href='../SagarPetro/registeruser.aspx?id=<%# Eval("ID") %>'>
                                                        <i class="bx bxs-message-square-edit"></i>edit
                                                    </a>
                                                </td>
                                                <td>
                                                    <asp:Literal ID="ltToggleAction" runat="server"></asp:Literal>
                                                </td>
                                                <td>
                                                    <a type="button" class="dropdown-item" href="javascript:void(0);" onclick="deleteUser('<%# Eval("ID") %>')">
                                                        <i class="fas fa-trash-alt"></i>Delete
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
    <asp:HiddenField ID="hdnid" runat="server" />
    <asp:HiddenField ID="hdnroletype" runat="server" />
    <asp:HiddenField ID="hdnnewuser" runat="server" />
    <asp:HiddenField ID="hdnremakrk" runat="server" />
    <!-- The Modal -->
    <div class="modal" id="myModal">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Transfer User</h4>
                    <button type="button" id="btncloseup" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <div class="row mt-2">
                        <label class="form-control mt-2">Transfer To</label>
                        <select class="form-select" id="ddluser" aria-label="Default select example">
                            <option value="">--Select--</option>
                        </select>
                    </div>
                    <div class="row mt-2">
                        <label class="form-control mt-2">Remark</label>
                        <input type="text" id="txtremark" class="form-control" aria-multiline="true" />
                    </div>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" id="btnsubmit" class="btn btn-primary" data-bs-dismiss="modal">Save</button>
                    <button type="button" id="btnclosedown" class="btn btn-danger" data-bs-dismiss="modal">Close</button>

                </div>

            </div>
        </div>
    </div>
    <!-- end Modal -->


    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

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

        function downloaduserData(ReportName) {
            let table = document.getElementById('dataTable');
            let rows = table.rows;
            let csvContent = '';

            for (let i = 0; i < rows.length; i++) {
                let row = rows[i];
                let cols = row.cells;
                let rowData = [];

                // Only iterate through columns excluding the last three
                for (let j = 0; j < cols.length - 3; j++) {
                    rowData.push(cols[j].innerText);
                }

                csvContent += rowData.join(',') + '\n';
            }

            let blob = new Blob([csvContent], { type: 'text/csv' });
            let link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = ReportName + '.csv';
            link.click();
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
                url: '../Info/SagarHandler.ashx?method=DeleteUser&UserRoleId=' + userId,
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
            hdnid = userId;
            $.ajax({
                type: "POST",
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/SagarHandler.ashx?method=GetUserType&userId=' + userId,
                success: function (Data) {
                    if (Data != "Invalid") {
                        let Usertype = Data.split('~')[0];
                        let Status = Data.split('~')[1];
                        let RegisteredAssitant = Data.split('~')[2];
                        hdnroletype = Usertype;
                        if (Usertype === "6" && Status === "1" && RegisteredAssitant !=="0") {
                            $.ajax({
                                type: "POST",
                                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/SagarHandler.ashx?method=Selectuser&userId=' + userId,
                                success: function (Data) {
                                    $('#ddluser').empty();
                                    if (Data != "False") {
                                        $.each(JSON.parse("[" + Data + "]"), function (index, record) {
                                            $.each(record, function (index2, sub_record) {
                                                $('#ddluser').append('<option value="' + sub_record.id + '">' + sub_record.UserName + '</option>');
                                            });
                                        });
                                    }
                                }
                            });
                            $('#myModal').show();

                        } else {
                            UpdateUserstatus(userId, Usertype);
                        }
                    }

                }
            });
        }

        $('#btncloseup').on('click', function () {
            $('#myModal').hide();
        });
        $('#btnclosedown').on('click', function () {
            $('#myModal').hide();
        });
        $('#btnsubmit').on('click', function () {
            hdnremakrk = $('#txtremark').val();
            //alert(hdnremakrk);
            if ($('#ddluser option:selected').val() == "" || $('#ddluser option:selected').val() == null) {
                showAlert('Error', 'Please Select User', 'error');
            }
            else {
                $.ajax({
                    type: "POST",
                    contentType: false,
                    processData: false,
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/SagarHandler.ashx?method=UpdateRole&UserRoleId=' + hdnid + '&User_Type=' + hdnroletype + '&NewRoleId=' + $('#ddluser option:selected').val() + '&Remark=' + $('#txtremark').val(),
                    success: function (data) {
                        if (data == "User Updated Successfully") {
                            Swal.fire('Success', data, 'success').then(() => {
                                location.reload();
                            });
                        }
                        else {
                            showAlert('Error', data, 'error');
                        }
                    }
                });
            }
        });


        function UpdateUserstatus(userId, Usertype) {
            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                url: '../Info/SagarHandler.ashx?method=ActiveInactiveUser&UserRoleId=' + userId + '&Usertype=' + Usertype,
                success: function (data) {
                    if (data == "User Activated Successfully" || data == "User De-Activated Successfully") {
                        //showAlert('Success', data, 'success');
                        //location.reload();
                        Swal.fire('Success', data, 'success').then(() => {
                            location.reload();
                        });
                    }
                    else {
                        showAlert('Error', data, 'error');
                    }
                }
            });
        }


    </script>
</asp:Content>

