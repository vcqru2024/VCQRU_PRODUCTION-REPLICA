<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="teslakyc.aspx.cs" Inherits="Manufacturer_teslakyc" %>

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>KYC User Data</h4>
                        </header>
                        <div class="card-body card-body-nopadding">
                            <div class="form-wizard medias">
                                <div class="row">
                                    <div class="form-group col-lg-3">
                                        <asp:TextBox ID="txtDateFrom" Visible="true" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateFrom" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$" ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                                    </div>
                                    <div class="form-group col-lg-3">
                                        <asp:TextBox ID="txtDateto" Visible="true" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateto" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$" ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                                    </div>
                                    <div class="form-group col-lg-3">
                                        <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="servss" ToolTip="Search" OnClick="ImgSearch_Click" />
                                        <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" ToolTip="Reset" OnClick="ImgRefresh_Click" />
                                        <asp:Button ID="btn_download" runat="server" Text="Download" OnClick="btn_download_Click" CssClass="btn btn-primary" />
                                    </div>
                                    <div class="col-lg-4">
                                        <label class="form-label">Search:</label>
                                        <input type="search" id="searchInput" onkeyup="performSearch(this.value)"
                                            class="form-control" placeholder="Search" />
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="table-responsive">
                                        <div class="table-responsive">
                                            <table id='dataTable' class='table table-hover table-striped table-bordered Frm_Scrap'>
                                                <thead>
                                                    <tr>
                                                        <th>Sr No</th>
                                                        <th>Name</th>
                                                        <th>Mobile Number</th>
                                                        <th>KYC Status</th>
                                                      <%--  <th>Bank KYC Status</th>--%>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:Repeater runat="server" ID="grd1">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td>
                                                                    <%#Container.ItemIndex+1 %>
                                                                </td>
                                                                <td>
                                                                    <%# Eval("ConsumerName") %>
                                                                </td>
                                                                <td>
                                                                    <%# Eval("MobileNumber") %>
                                                                </td>
                                                                <td>
                                                                    <%# Eval("UPIKYCSTATUS") %>
                                                                </td>
                                                            <%--    <td>
                                                                    <%# Eval("BankKYCSTATUS") %>
                                                                </td>--%>
                                                                <td>
                                                                    <a href='teslakycdetails.aspx?mid=<%# Eval("M_Consumerid") %>'>
                                                                        <img src="../Content/images/edit.png"></a>
                                                                </td>

                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>




                                <div class="form-group col-lg-6">
                                    <cc1:CalendarExtender ID="CalendarExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtenderdatefrom" runat="server"
                                        TargetControlID="txtDateFrom" WatermarkText="Date From....">
                                    </cc1:TextBoxWatermarkExtender>
                                    <cc1:CalendarExtender ID="CalendarExtender1to" runat="server" TargetControlID="txtDateto"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1to" runat="server" TargetControlID="txtDateto"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1to" runat="server" TargetControlID="txtDateto"
                                        WatermarkText="Date To....">
                                    </cc1:TextBoxWatermarkExtender>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

