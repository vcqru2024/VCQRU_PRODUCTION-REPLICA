<%@ Page Title="" Language="C#" MasterPageFile="~/ZYDEX/zydexmaster.master" AutoEventWireup="true" CodeFile="Dealerregistration.aspx.cs" Inherits="ZYDEX_Dealerregistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="page-content-wrapper">
        <div class="container">
            <div class="app-breadcrumb">
                <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="../ZYDEX/dashboardzydex.aspx"><i class='bx bxs-home'></i> Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Dealer Registration</li>
  </ol>
</nav>
            </div>
            <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">Dealer Registration</h4>
                        </div>
                        <div class="card-body">
                            <div id="regdiv">
                                 <div class="row row-cols-xxl-4 row-cols-xl-4 row-cols-lg-3 row-cols-md-2 row-cols-1 g-3">
                                <div class="col">
                                    <asp:TextBox class="form-control" onkeyup="toUppercase(this)" MaxLength="15" runat="server" placeholder="SAP Dealer code" value="" ID="txtgst" />
                                </div>
                                <div class="col">
                                    <asp:TextBox class="form-control" onkeyup="toUppercase(this)" runat="server" placeholder="Dealer Name" value="" ID="txtDealer" />
                                </div>
                                <div class="col">
                                    <asp:TextBox class="form-control" runat="server" MaxLength="10" placeholder="Mobile No" value="" ID="txtMobile" />
                                </div>
                                <div class="col">
                                    <button onclick="downloadGridDatadealer('Dealer Details')" class="btn btn-light border border-2 w-100">
                                      <i class='bx bxs-download'></i> Export
                                    </button>
                                </div>
                                     <div class="col">
                                    <asp:TextBox ID="txtcluster" placeholder="Cluster" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="col">
                                    <asp:DropDownList ID="ddlstate" AutoPostBack="true" OnSelectedIndexChanged="ddlstate_SelectedIndexChanged" runat="server" CssClass="form-select"></asp:DropDownList>
                                </div>
                            <%--    <div class="col">
                                    <asp:DropDownList ID="ddlcity" runat="server" CssClass="form-select"></asp:DropDownList>
                                </div>--%>
                                     <div class="col">
                                         <asp:TextBox ID="txtcity" runat="server" CssClass="form-control" placeholder="Enter City"></asp:TextBox>
                                     </div>
                                <div class="col">
                                    <asp:Button ID="btnsave" OnClick="btnsave_Click" OnClientClick="$('#myspindiv').show(); $('#regdiv').hide();"  class="btn btn-primary w-100" runat="server" Text="Register" />
                                </div>
                            </div>
                           
                            </div>
                           
                             <div id="myspindiv" class="text-center" style="display: none">
                                <h5>Loading please wait</h5>
                               <%-- <img src="../SagarPetro/assets/img/wait2.gif" height="50" />--%>
                                 <img src="https://www.vcqru.com/zydex/assets/img/wait2.gif" height="50" />
                            </div>

                            <div class="global-search w-25 my-3">
                                                <input type="search" id="searchInput" onkeyup="performSearch(this.value)" class="form-control" placeholder="Search" />
                                                <span><i class="fa fa-search"></i></span>
                                            </div>
                                        <div class="app-table">
                                            <div class="table-responsive">
                                                <table id='dataTable' class='table table-hover table-striped table-bordered'>
                                                <thead>
                                                    <tr>
                                                        <th>Sr No</th>
                                                        <th>Dealer Code</th>
                                                        <th>Dealer Name</th>
                                                        <th>MOBILENO</th>
                                                        <th>Cluster</th>
                                                        <th>State</th>
                                                        <th>City</th>
                                                        <th>Date</th>
                                                        <th>Status</th>
                                                        <th>Activate/Deactivate</th>
                                                        <th>Delete</th>

                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:Repeater runat="server" OnItemDataBound="gvNewUser_ItemDataBound" ID="rptData">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td><%#Container.ItemIndex+1 %></td>
                                                                <td><%# Eval("Dealer Code") %></td>
                                                                <td><%# Eval("Dealer Name") %></td>
                                                                <td><%# Eval("MOBILENO") %></td>
                                                                <td><%# Eval("Location") %></td>
                                                                <td><%# Eval("State") %></td>
                                                                <td><%# Eval("City") %></td>
                                                                <td><%# Eval("Created_Date") %></td>
                                                                <td>
                                                                    <%# Convert.ToBoolean(Eval("Isactive")) ? "Active" : "Inactive" %>
                                                                </td>

                                                                <td>
                                                                    <asp:Literal ID="ltToggleAction" runat="server"></asp:Literal>
                                                                </td>
                                                                <td>
                                                                    <button type="button" class="btn btn-outline-danger d-flex btn-sm align-items-center" onclick="deleteUser('<%# Eval("ID") %>')">
                                                                       <i class='bx bxs-trash-alt' ></i></i>Delete
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

    <script>
        function UpdateUserstatus(userId) {
            $('txtgst').val('Invalid');
            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                url: '../Info/ZyexHandler.ashx?method=ActiveInactiveUser&UserRoleId=' + userId + '&CompID=<%=Session["CompanyId"].ToString()%>',
                success: function (data) {
                    if (data == "User Activated Successfully" || data == "User De-Activated Successfully") {
                        
                        Swal.fire('Success', data, 'success').then(() => {
                            window.location.href = "Dealerregistration.aspx";
                        });
                    }
                    else {
                        showAlert('Error', data, 'error');
                    }
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
            location.reload();
        }

        function onError(error) {
            alert(error.get_message());
        }
        function Deletenow(userId) {

            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                url: '../Info/ZyexHandler.ashx?method=DeleteUser&UserRoleId=' + userId + '&CompId=<%=Session["CompanyId"].ToString()%>',
                success: function (data) {
                    if (data == "Deleted") {
                        Swal.fire('Success', data, 'success').then(() => {
                            window.location.href = "Dealerregistration.aspx";
                        });
                    }
                    else {
                        showAlert('Error', data, 'error');
                    }
                }
            });
        }
    </script>

    <script>
        function downloadGridDatadealer(ReportName) {
            let table = document.getElementById('dataTable');
            let rows = table.rows;
            let csvContent = '';

            // Get the total number of columns
            let totalColumns = rows[0].cells.length;

            // Define columns to exclude (last two columns)
            let columnsToExclude = [totalColumns - 2, totalColumns - 1];

            // Convert columnsToExclude to a Set for efficient lookups
            let excludeSet = new Set(columnsToExclude);

            for (let i = 0; i < rows.length; i++) {
                let row = rows[i];
                let cols = row.cells;
                let rowData = [];

                for (let j = 0; j < cols.length; j++) {
                    if (!excludeSet.has(j)) { // Check if the column index should be excluded
                        rowData.push(cols[j].innerText);
                    }
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

