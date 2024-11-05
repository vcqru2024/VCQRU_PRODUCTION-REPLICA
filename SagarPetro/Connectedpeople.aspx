<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="Connectedpeople.aspx.cs" Inherits="SagarPetro_Connectedpeople" %>

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
                        <div class="col col-md-4 mb-3 ">
                            <asp:DropDownList ID="ddlusertype" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlusertype_SelectedIndexChanged" runat="server">
                                <asp:ListItem Text="Manager" Value="4"></asp:ListItem>
                                <asp:ListItem Text="Sales Executive" Value="5"></asp:ListItem>
                                <asp:ListItem Text="Head Mechanic" Value="6"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col col-md-4 mb-3 ">
                            <div class="global-search">
                                <div class="form-group">
                                    <input type="search" runat="server" id="searchInput" onkeyup="performSearch(this.value)" class="form-control" placeholder="Search">
                                    <span><i class="fa fa-search"></i></span>
                                </div>
                            </div>

                        </div>
                        <div class="col mb-3">
                            <%-- <ul class="action-button-global">
                                <li>
                                    <a href="../SagarPetro/registeruser.aspx" class="btn btn-sm btn-primary"><i class='bx bx-plus'></i>add User</a>
                                </li>
                            </ul>--%>
                            <button runat="server" onclick="downloaduserData('UserData')"
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
                                        <th scope="col">Count Of Assistant</th>
                                        <th scope="col">Count Of Head</th>


                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="gvNewUser" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Container.ItemIndex + 1 %></td>
                                                <td><%# Eval("UserName") %></td>
                                                <td>
                                                    <%# Eval("CountOfAssistant") %>
                                                    <button type="button" class="btn-icon btn-success" onclick="handleClick('<%# Eval("id") %>', '7')">
                                                        <i class="fa-solid fa-eye"></i>
                                                    </button>
                                                </td>
                                                <td>
                                                    <%# Eval("CountOfHead") %>
                                                    <button type="button" class="btn-icon btn-success" onclick="handleClick('<%# Eval("id") %>', '6')">
                                                        <i class="fa-solid fa-eye"></i>
                                                    </button>
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



    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">
        function handleClick(id, type) {
            var url = '../SagarPetro/ViewConnectedpeople.aspx?id=' + id + '&type=' + type;
            window.location.href = url;
        }
        function downloaduserData(ReportName) {
            let table = document.getElementById('dataTable');
            let rows = table.rows;
            let csvContent = '';
            for (let i = 0; i < rows.length; i++) {
                let row = rows[i];
                let cols = row.cells;
                let rowData = [];
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

