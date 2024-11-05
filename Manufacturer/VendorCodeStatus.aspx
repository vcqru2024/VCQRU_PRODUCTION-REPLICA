<%--<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="VendorCodeStatus.aspx.cs" Inherits="Manufacturer_VendorCodeStatus" %>--%>

<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    CodeFile="VendorCodeStatus.aspx.cs" Inherits="Manufacturer_VendorCodeStatus" Title="Enquiry Details" %>


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
    </script>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Code Status</h4>
                        </header>

                        <div class="card-body card-body-nopadding">
                            <div class="row">
                                <div class="col-lg-4">
                                    <asp:Label ID="LblMsg" Style="display: none;" CssClass="small_font" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-2">
                                    <asp:TextBox class="form-control form-control-sm" runat="server" placeholder="Code1" required="" value="" data-msg-required="Please enter Code 1" MaxLength="5" ID="textcodeone" />
                                </div>
                                <div class="col-lg-2">
                                    <asp:TextBox class="form-control form-control-sm" runat="server" placeholder="Code2" required="" value="" data-msg-required="Please enter Code 2" MaxLength="8" ID="textcodeTwo" />
                                </div>
                                <div class="col-lg-2">
                                    <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ToolTip="Search" OnClick="ImgSearch_Click" />
                                    <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" ToolTip="Reset" OnClick="ImgRefresh_Click" />
                                </div>

                            </div>
                            <div class="row" style="margin-top: 2%;">
                                <div class="col-lg-12">
                                    <div class="table-responsive table_large">
                                        <asp:GridView ID="GrdCodeEnquiry" runat="server" AutoGenerateColumns="False" CssClass="table table-striped tblSorting table-bordered"
                                            EmptyDataText="Record Not Found" BorderColor="transparent">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Enquiry Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="EnqDate" runat="server" Text='<%# Eval("EnqDate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Company Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Comp_Name" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Mobile No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="MobileNo" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Product Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Pro_Name" runat="server" Text='<%# Eval("Pro_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Enq. Mode">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Dial_Mode" runat="server" Text='<%# Bind("Dial_Mode") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Code 1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Received_Code1" runat="server" Text='<%# Eval("Received_Code1") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Code 2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Received_Code2" runat="server" Text='<%# Bind("Received_Code2") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Is_Success" runat="server" Text='<%# Bind("Is_Success") %>'></asp:Label>
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



