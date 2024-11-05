<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="hpl_Users.aspx.cs" Inherits="Manufacturer_hpl_Users" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $(".accordion2 p").eq(28).addClass("active");
            $(".accordion2 div.open").eq(26).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
                    .siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });

    </script>
    <style>
        .active {
    color: green; /* Example style */
                }

.inactive {
    color: red; /* Example style */
          }
        .roundedcorners {
            -webkit - border - radius: 30px;
            -khtml - border - radius: 30px;
            -moz - border - radius: 30px;
            border - radius: 30px;
        }

        .aadhar {
            align-content: center;
            margin-top: 10px;
        }

        .verifyimghide {
            width: 20px;
            height: 20px;
            display: none
        }

        .verifyimgshow {
            width: 20px !important;
            height: 20px !important;
            display: block;
            position: absolute;
            right: 15px;
        }

        .box-data {
            padding: 10px;
            border: 1px solid #ececec;
            border-radius: 10px;
            background: #f5f5f5;
            position: relative;
        }

            .box-data img {
                height: 322px;
                width: 100%;
                border-width: 0px;
                border-radius: 10px;
            }

        .foot-box {
            padding-left: 66px;
            position: relative;
            margin-top: 15px;
        }

            .foot-box .roundedcorners {
                position: absolute;
                left: 0;
            }

            .foot-box span, .foot-box strong {
                font-size: 14px !important;
            }

            .foot-box strong {
                font-weight: 600 !important;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function performSearch(searchText) {
            $('#ctl00_ContentPlaceHolder1_grd1 tbody tr').each(function () {
                var row = $(this);
                var found = false;
                row.find('td').each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.includes(searchText.toLowerCase())) {
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
        }
    </script>
    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <%--<header class="card-header">--%>
                        <header class="<%= Session["card-header"] %>">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>OEM Data</h4>
                        </header>
                        <div class="card-body card-body-nopadding">
                            <div class="form-row">
                                <div class="col-lg-12">
                                    <asp:Label ID="lblMsg1" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="form-wizard medias">
                                <div class="form-row">
                                    <div class="col-md-4">
                                        <asp:Button ID="btn_download" runat="server" Text="Download" OnClick="btn_download_Click" CssClass="btn btn-primary" />
                                    </div>
                                </div>
                                <div class="form-row mt-1">
                                    <div>
                                        <h4 class="mt-2">Search :</h4>
                                    </div>
                                    <div class="col-md-4">
                                        <input type="search" id="searchInput" onkeyup="performSearch(this.value)" class="form-control" placeholder="Search" />
                                    </div>
                                </div>
                                <br />
                                <br />
                                <div class="table-responsive table_large">
                                    <asp:GridView ID="grd1" runat="server" CssClass="table table-striped tblSorting table-bordered" EmptyDataText="No records found" BorderColor="transparent" AutoGenerateColumns="False" OnRowEditing="grd1_RowEditing" OnRowDeleting="grd1_RowDeleting">
                                        <Columns>
                                            <asp:BoundField DataField="UserEmail" HeaderText="User Email" />
                                            <asp:BoundField DataField="MobileNo" HeaderText="Mobile No" />
                                            <asp:BoundField DataField="Location" HeaderText="Location" />
                                            <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" />
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkStatus" runat="server" Checked='<%# Convert.ToBoolean(Eval("Status")) %>' AutoPostBack="true" OnCheckedChanged="chkStatus_CheckedChanged" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="UserStatus">
                                                <ItemTemplate>
                                                    <label class='<%# Convert.ToBoolean(Eval("Status")) ? "active" : "inactive" %>'>
                                                        <%# Convert.ToBoolean(Eval("Status")) ? "Active" : "Inactive" %>
                                                    </label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" CssClass="btn btn-primary"><i class="fas fa-edit"></i> Edit</asp:LinkButton>
                                                    <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandName="Delete" CssClass="btn btn-danger"><i class="fas fa-trash"></i> Delete</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle BackColor="DarkBlue" ForeColor="White" Font-Bold="True" />
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
