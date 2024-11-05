<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="Cashreddemrpt.aspx.cs" Inherits="SagarPetro_Cashreddemrpt" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="home-section">
        <div class="app-breadcrumb">
            <div class="row">
                <div class="col">
                    <h5>Claim Details</h5>
                </div>
                <div class="col">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Claim Details</li>
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
                        <div class="col">
                          
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
                                        <th scope="col">Date</th>
                                        <th scope="col">Mobile No</th>
                                        <th scope="col">Amount</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">Order ID</th>
                                        <th scope="col">Remark Date</th>
                                        <th scope="col">Account No</th>
                                        <th scope="col">Account Holder Name</th>
                                        <th scope="col">IFSC CODE</th>
                                      
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="gvNewUser" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Container.ItemIndex + 1 %></td>
                                                <td><%# Eval("pdate") %></td>
                                                <td><%# Eval("mobileno") %></td>
                                                <td><%# Eval("Amount") %></td>
                                                <td><%# Eval("pstatus") %></td>
                                                <td><%# Eval("orderid") %></td>
                                                <td><%# Eval("Comment") %></td>
                                                <td><%# Eval("AccountNo") %></td>
                                              
                                                <td><%# Eval("AccountHolderName") %></td>
                                                <td><%# Eval("IFSCCode") %></td>
                                               
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



       

      


    </script>
</asp:Content>


