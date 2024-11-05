<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="ShowNotifications.aspx.cs" Inherits="Manufacturer_ShowNotifications" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function () {

            $(".accordion2 p").eq(36).addClass("active");
            $(".accordion2 div.open").eq(30).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
                    .siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });


        function GetSelectedRow(UserLink) {
            var row = UserLink.parentNode.parentNode;
            var rowIndex = row.rowIndex - 1;
            var Code = row.cells[0].innerText;

            window.location.href = "../Manufacturer/ShowNotifications?Code=" + Code;

        }


    </script>

    <style>
        .Blue {
            color: blue;
        }

        .Black {
            color: black;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Notifications</h4>
                        </header>

                        <div class="card-body card-body-nopadding">
                            <div class="row">
                                <div class="col-lg-4">
                                    <asp:Label ID="LblMsg" Style="display: none;" CssClass="small_font" runat="server"></asp:Label>
                                </div>
                            </div>

                            <div class="row" style="margin-top: 2%;">
                                <div class="col-lg-3">
                                    <div class="table-responsive table_large">
                                        <asp:GridView ID="GrdNotifications" runat="server" AutoGenerateColumns="False" CssClass="table table-striped tblSorting table-bordered"
                                            EmptyDataText="Record Not Found" BorderColor="transparent" OnRowCommand="GrdNotifications_RowCommand">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Code">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="Code" CommandName="select" CommandArgument='<%# Eval("Code") %>' class='<%# Eval("Class") %>' runat="server" Text='<%# Eval("Code") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>


                                                <asp:TemplateField HeaderText="Total">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Total" runat="server" Text='<%# Bind("Total") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>



                                            </Columns>

                                        </asp:GridView>
                                    </div>
                                </div>

                                <div class="col-lg-9">
                                    <div class="table-responsive table_large">
                                        <asp:GridView ID="GridShowAllNot" runat="server" AutoGenerateColumns="False" CssClass="table table-striped tblSorting table-bordered"
                                            EmptyDataText="Record Not Found" BorderColor="transparent">
                                            <Columns>

                                                <asp:TemplateField HeaderText="Mobile No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="MobileNo" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Code">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Code" runat="server" Text='<%# Bind("Code") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Enq_Date" runat="server" Text='<%# Bind("Enq_Date") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Status" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>


                                            </Columns>

                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

</asp:Content>



