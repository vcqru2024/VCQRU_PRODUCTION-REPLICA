<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="ViewConnectedpeople.aspx.cs" Inherits="SagarPetro_ViewConnectedpeople" %>

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
                        <%--    <ul class="action-button-global">
                                <li>
                                    <a href="../SagarPetro/registeruser.aspx" class="btn btn-sm btn-primary"><i class='bx bx-plus'></i>add User</a>
                                </li>
                            </ul>--%>
                            <button runat="server" onclick="downloaduserData('UserData')"
                                class="btn btn-primary">
                                <i class="fas fa-file-csv"></i>
                            </button>
                        </div>
                        <div class="col mv-3">
                            <asp:Button ID="btnback" CssClass="btn btn-primary" Text="Back" OnClick="btnback_Click" runat="server" />
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
                                       
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="gvNewUser" runat="server">
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">
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
    </script>

</asp:Content>

