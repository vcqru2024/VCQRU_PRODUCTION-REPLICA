<%@ Page Title="" Language="C#" MasterPageFile="~/ZYDEX/zydexmaster.master" AutoEventWireup="true" CodeFile="dashboardzydex.aspx.cs" Inherits="ZYDEX_dashboardzydex" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        body {
            background-color: var(--bs-light)
        }
    </style>


    <div class="container">
        <div class="card">
            <div class="card-body">
                <div class="profile-details">
                    <h5>Hey, <%=Session["Comp_Name"].ToString() %>!</h5>
                    <%--<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>--%>
                </div>
                <div class="action-row">
                    <div class="row align-items-center">
                        <div class="col-xxl-4 col-xl-4 col-lg-4 col-md-6">
                            <div class="search-bar">
                                <input type="search" name="search" id="searchInput" onkeyup="performSearch(this.value)" class="form-control"
                                    placeholder="Search...">
                                <div class="position-absolute top-50 start-0 translate-middle-y ms-2">
                                    <i class='bx bx-search'></i>
                                </div>
                            </div>
                        </div>
                        <div class="col ms-auto">
                            <ul>
                                <li>
                                    <%--  <button type="button" class="btn btn-outline-secondary btn-sm">
                                            <i
                                                class='bx bxs-download'></i> export</button>--%>
                                    <button runat="server" onclick="downloadGridData('Details')"
                                        class="btn btn-light border-2 border btn-sm">
                                        <i
                                            class='bx bxs-download'></i>export
                                    </button>
                                </li>
                                <li>
                                    <a class="btn btn-outline-secondary btn-sm" href="Dealerregistration.aspx"><i
                                        class='bx bx-plus'></i>Register Dealer</a>
                                </li>
                                <li>
                                    <button type="button" class="btn btn-outline-secondary btn-sm"
                                        data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                        <i
                                            class='bx bx-plus'></i>add</button>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="row">
                    
                    <div class="col">
                        <label class="form-label">Dealer SAP Code</label>
                        <asp:DropDownList ID="ddldistributor" AutoPostBack="true" OnSelectedIndexChanged="ddldistributor_SelectedIndexChanged1" runat="server"  CssClass="form-select"></asp:DropDownList>
                    </div>
                    <div class="col">
                        <label class="form-label">Dealer Name</label>
                        <asp:TextBox ID="txtdealernm" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>

                    <%--<div class="col">
                        <label class="form-label">From Date</label>
                        <div class="input-group date" data-provide="datepicker">
                            <asp:TextBox ID="txtfromdate" AutoComplete="off" runat="server" CssClass="form-control" MaxLength="10" placeholder="MM/DD/YYYY"></asp:TextBox>
                            <cc1:CalendarExtender runat="server" ID="txtfromdate_ce" Format="dd-MMM-yyyy" PopupButtonID="txtfromdate"
                                TargetControlID="txtfromdate">
                            </cc1:CalendarExtender>
                        </div>
                    </div>--%>
                  <%--  <div class="col">
                        <label class="form-label">To Date</label>
                        <div class="input-group date" data-provide="datepicker">
                            <asp:TextBox ID="txttodate" AutoComplete="off" runat="server" CssClass="form-control" MaxLength="10" placeholder="MM/DD/YYYY"></asp:TextBox>
                            <cc1:CalendarExtender runat="server" ID="txttodate_ce" Format="dd-MMM-yyyy" Animated="False"
                                PopupButtonID="txttodate" TargetControlID="txttodate">
                            </cc1:CalendarExtender>
                        </div>
                    </div>--%>
                    <div class="col">
                        <label class="form-label text-white">*</label><br />
                        <asp:Button ID="btnsearch" runat="server" Text="Search" OnClick="btnsearch_Click" CssClass="btn btn-primary" />
                    </div>
                </div>
                <div class="app-table">
                    <div class="table-responsive">
                        <table id='dataTable' class='table table-hover table-striped table-bordered'>
                            <thead>
                                <tr>
                                    <th scope="col">Sr No</th>
                                    <th scope="col">Serial Number</th>
                                    <th scope="col">Dealer SAP</th>
                                    <th scope="col">Dealer Name</th>
                                    <th scope="col">Cluster</th>
                                    <th scope="col">City</th>
                                    <th scope="col">State</th>
                                    <th scope="col">Bill Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater runat="server" ID="rptData">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%#Container.ItemIndex+1 %></td>
                                            <td><%# Eval("Serial_Number") %></td>
                                            <td><%# Eval("Dealer Code") %></td>
                                            <td><%# Eval("Distributor Name") %></td>
                                            <td><%# Eval("Cluster") %></td>
                                            <td><%# Eval("City") %></td>
                                            <td><%# Eval("State") %></td>
                                            <td><%# Eval("Date") %></td>
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
    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
        aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-sm modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Assign To Dealer</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row row-cols-xxl-1 row-cols-xl-1 row-cols-lg-1 row-cols-md-1 row-cols-1 g-3">
                        <div class="col">
                            <label for="txtfromseries" class="form-label">From<span>*</span></label>
                            <asp:TextBox ID="txtfromseries" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col">
                            <label for="To" class="form-label">To<span>*</span></label>
                            <asp:TextBox ID="txttoseries" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col">
                            <label for="DealerName" class="form-label">Dealer SAP Code<span>*</span></label>
                            <asp:DropDownList ID="ddldealer" AutoPostBack="true" OnSelectedIndexChanged="ddldistributor_SelectedIndexChanged" runat="server" CssClass="form-select"></asp:DropDownList>

                        </div>
                        <div class="col">
                            <label for="txtdisname" class="form-label">Dealer Name</label>
                            <asp:TextBox ID="txtdisname" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                        <%-- <div class="col">
                                <label for="SAPDealercode" class="form-label">SAP Dealer code<span>*</span></label>
                                <input type="text" class="form-control" id="SAPDealercode" required>
                            </div>--%>
                        <%-- <div class="col">
                                <label for="City" class="form-label">City<span>*</span></label>
                                <input type="text" class="form-control" id="City" required>
                            </div>--%>
                        <%--   <div class="col">
                                <label for="Cluster" class="form-label">Cluster<span>*</span></label>
                                <input type="text" class="form-control" id="Cluster" required>
                            </div>--%>
                    </div>
                </div>
                <div class="modal-footer d-flex flex-nowrap">
                    <button type="button" class="btn btn-danger w-100" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnsubmit" runat="server" OnClick="btnsubmit_Click" CssClass="btn btn-primary w-100" Text="Submit" />
                </div>
            </div>
        </div>
    </div>
    <!-- js -->
    <script src="assets/js/index.js"></script>
    <script>
        // Example starter JavaScript for disabling form submissions if there are invalid fields
        (() => {
            'use strict'

            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            const forms = document.querySelectorAll('.needs-validation')

            // Loop over them and prevent submission
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }

                    form.classList.add('was-validated')
                }, false)
            })
        })()
    </script>
    <script>
        $(document).ready(function () {
            $('#dataTable').DataTable({
                "paging": true,
                "searching": false,
                "info": false,
                "responsive": true
            });

        });

        function showModal() {
            var myModal = new bootstrap.Modal(document.getElementById('staticBackdrop'), {
                keyboard: false
            });
            myModal.show();
        }

    </script>



</asp:Content>

