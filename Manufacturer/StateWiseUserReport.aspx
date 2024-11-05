<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="StateWiseUserReport.aspx.cs" Inherits="Manufacturer_StateWiseUserReport" %>

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

    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <%--<header class="card-header">--%>
                         <header class="<%= Session["card-header"] %>">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>State Wise User Report</h4>
                        </header>
                        <div class="card-body card-body-nopadding">
                            <div class="form-row">
                                <div class="col-lg-12">
                                    <asp:Label ID="lblMsg1" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="form-wizard medias">
                                <div class="col-lg-6">
                                </div>
                                <div class="col-lg-4">
                                    <asp:Label ID="LblMsg" CssClass="small_font" ForeColor="Red" runat="server"></asp:Label>
                                </div>
                                <div class="form-row">
                                     <div class="form-group col-lg-3">
                                        <asp:TextBox ID="txtDateFrom" Visible="true" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                         <cc1:CalendarExtender runat="server" ID="txtfromdate_ce" Format="yyyy-MM-dd" PopupButtonID="txtDateFrom"
                                        TargetControlID="txtDateFrom" >
                                    </cc1:CalendarExtender>
                                       <%-- <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateFrom" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                                            ErrorMessage="Please enter valid date." ValidationGroup="servss" />--%>
                                    </div>
                                    <div class="form-group col-lg-3">
                                        <asp:TextBox ID="txtDateto" Visible="true" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                        <cc1:CalendarExtender runat="server" ID="txttodate_ce" Format="yyyy-MM-dd" Animated="False"
                                        PopupButtonID="txtDateto" TargetControlID="txtDateto">
                                    </cc1:CalendarExtender>
                                       <%-- <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateto" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                                            ErrorMessage="Please enter valid date." ValidationGroup="servss" />--%>
                                    </div>
                                    <div class="form-group col-lg-3">
                                    <asp:ImageButton ID="ImgSearch"  Visible="true" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="servss"
                                        ToolTip="Search" OnClick="ImgSearch_Click" />
                                    <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" ToolTip="Reset"
                                        OnClick="ImgRefresh_Click" />
                                    
                                </div>
                                    <div class="form-group col-lg-3">
                                        <asp:Button ID="btn_download" runat="server" Text="Download" OnClick="btn_download_Click" CssClass="btn btn-primary" />
                                    </div>
                                    
                                </div>
                                    
                               
                                <br />
                                <br />
                                <div class="table-responsive table_large">
                                    <asp:GridView ID="grd1" runat="server" CssClass="table table-striped tblSorting table-bordered" EmptyDataText="Record Not Found" BorderColor="transparent">
                                        <AlternatingRowStyle BackColor="#CCCCCC" />
                                        <FooterStyle BackColor="#CCCCCC" />
                                        <HeaderStyle BackColor="blue" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                        <SortedAscendingHeaderStyle BackColor="#808080" />
                                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                        <SortedDescendingHeaderStyle BackColor="#383838" />
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


