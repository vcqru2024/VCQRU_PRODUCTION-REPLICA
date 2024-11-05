<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="Consumerwalletbalancetesla.aspx.cs" Inherits="Manufacturer_Consumerwalletbalancetesla" %>

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
            border-radius: 30px;
        }

        .aadhar {
            text-align: center;
            margin-top: 10px;
        }

        .verifyimghide {
            width: 20px;
            height: 20px;
            display: none;
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
            border: none;
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
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>User wise total amount earned</h4>
                        </header>
                        <div class="card-body card-body-nopadding">
                            <div class="row"></div>
                            <div class="form-wizard medias">
                                <div class="row">
                                    <div class="col-md-3">
                                        <asp:Button ID="btn_download" runat="server" Text="Download" OnClick="btn_download_Click" CssClass="btn btn-primary" />
                                    </div>
                                    <div class="col-md-12">
                                        <div class="global-search w-25 my-3">
                                            <input type="search" id="searchInput" onkeyup="performSearch(this.value)" class="form-control" placeholder="Search" />
                                            <span><i class="fa fa-search"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="app-table">
                                    <div class="table-responsive">
                                        <table id="dataTable" class="table table-hover table-striped table-bordered Frm_Scrap">
                                            <thead>
                                                <tr>
                                                    <th>Sr No</th>
                                                    <th>Mobile Number</th>
                                                    <th>Consumer Name</th>
                                                    <th>Amount Earned</th>
                                                    <th>Redeemed Amount</th>
                                                    <th>Available Balance</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater runat="server" ID="rptData">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td><%# Container.ItemIndex + 1 %></td>
                                                            <td><%# Eval("Mobile Number") %></td>
                                                            <td><%# Eval("Consumer Name") %></td>
                                                            <td><%# Eval("Amount Earned") %></td>
                                                            <td><%# Eval("Redeemed Amount") %></td>
                                                            <td><%# Eval("Available Balance") %></td>
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
            </div>
        </div>
    </div>
</asp:Content>
