<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true"
    CodeFile="Userrptsgr.aspx.cs" Inherits="SagarPetro_Userrptsgr" %>
    <%@ Import Namespace="System.Data" %>
        <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

            <div class="home-section">
                <div class="app-breadcrumb">
                    <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1 g-3">
                        <div class="col">
                            <h5>Users Count</h5>
                        </div>
                        <div class="col">
                            <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Users Records</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <!-- table view -->
                <div class="user-role-card">
                    <div class="card">
                        <div class="card-header">
                              <div class="col col-md-3 mb-2">
                                  <button runat="server" onclick="downloadGridData('UserCount')"
                                class="btn btn-primary">
                                <i class="fas fa-file-csv"></i>
                            </button>
                            </div>
                        </div>
                       
                        <div class="card-body">

                            <div class="app-table">
                                <div class='table-responsive'>
                                    <table id='dataTable' class='table table-hover table-bordered mb-0'>
                                        <thead>
                                            <tr>
                                                <th>Registered Head Mechanic</th>
                                                <th>Active Head Mechanic</th>
                                                <th>Registered Assistant Mechanic</th>
                                                <th>Active Assistant Mechanic</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% DataTable dt=GetDataFromDatabase(); if (dt !=null && dt.Rows.Count> 0)
                                                {

                                                foreach (DataRow row in dt.Rows)
                                                {
                                                Response.Write("<tr>");

                                                    Response.Write("<td>" + row["TotalHeadMechanic"] + "</td>");
                                                    Response.Write("<td>" + row["ActiveHeadMechanic"] + "</td>");
                                                    Response.Write("<td>" + row["TotalAssistantMechanic"] + "</td>");
                                                    Response.Write("<td>" + row["ActiveAssistantMechanic"] + "</td>");
                                                    Response.Write("</tr>");
                                                }
                                                }
                                                else
                                                {
                                                Response.Write("<p>No data available</p>");
                                                }
                                                %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <script>
                $(document).ready(function () {
                    var dataTable = $('#dataTable').DataTable({
                        dom: 'Blfrtip',
                        buttons: [

                            {
                                extend: 'excel',
                                text: '<i class="fa fa-file-excel"></i> Excel',
                                className: 'btn-excel',
                                exportOptions: {
                                    columns: ':visible'
                                }
                            }
                        ],
                        lengthMenu: [
                            [10, 25, 50, -1],
                            ['10 ', '25 ', '50 ', 'Show all']
                        ],
                        pageLength: 25
                    });
                });
            </script>
            <script>
                (() => {
                    'use strict'
                    const forms = document.querySelectorAll('.needs-validation')
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

        </asp:Content>