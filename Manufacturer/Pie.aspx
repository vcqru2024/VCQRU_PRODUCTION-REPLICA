<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="Pie.aspx.cs" Inherits="Manufacturer_Pie" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
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
        .divtgcc {
            background-color: royalblue !important;
            color: white;
            font-weight: bold;
            font-size: 20px;
            margin-left: 5px;
            margin-right: 5px;
            margin-top: 5px;
        }

        .lbltotalcodec {
            font-size: 38px;
        }

        .rowbackgroundcolor {
            background-color: white;
        }
        /* .heading{
            color:#0a0a0a;
            text-align:center;
            margin-top:25px;
        }*/


        .heading {
            color: #0a0a0a;
            text-align: center;
            margin-top: 25px;
            position: absolute;
             width: 80%;
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



    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                       

                         <div class="row rowbackgroundcolor">
        <div class="col-lg-3 col-md-6">
            <div class="card bg-info divtgcc" id="divtgc" style="height: 114px; background-color:#00bcfe !important;">
                <div class="card-body text-center">
                    <asp:Label runat="server">Generated Codes</asp:Label><br />
                    <br />
                    <asp:Label ID="lbltotalcode" CssClass="lbltotalcodec" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="card bg-info divtgcc" id="divtuc" style="height: 114px; background-color:#5e5ece !important;">
                <div class="card-body text-center">
                    <asp:Label runat="server">Checked Code</asp:Label><br />
                    <br />
                    <asp:Label ID="lblttlusedcode" CssClass="lbltotalcodec" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="card bg-info divtgcc" id="divtusr" style="height: 114px; background-color:#e2201d !important;">
                <div class="card-body text-center">
                    <asp:Label runat="server">Registered User</asp:Label><br />
                    <br />
                    <asp:Label ID="lblttluser" CssClass="lbltotalcodec" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="card bg-info divtgcc" id="divtpro" style="height: 114px; background-color:#ff9b05 !important;">
                <div class="card-body text-center">
                    <asp:Label runat="server">Registered Product</asp:Label><br />
                    <br />
                    <asp:Label ID="lblttlproduct" CssClass="lbltotalcodec" runat="server"></asp:Label>
                </div>
            </div>
        </div>
    </div>


    <div class="row rowbackgroundcolor">
        <div class="col-lg-6 col-md-12">
            <h4 class="heading">Checked Code v/s Unchecked Code</h4>
            <asp:Chart ID="Chart1" runat="server" CssClass="piewieth"
                BorderlineWidth="0" Height="475px" Palette="None" PaletteCustomColors=""
                Width="539px" BorderlineColor="64, 0, 64">
                <Titles>
                    <asp:Title Alignment="BottomCenter"  Font="bold" Name="Items" />
                </Titles>
                <Legends>
                    <asp:Legend Alignment="Center" Docking="Right" IsTextAutoFit="False" Name="Default"
                        LegendStyle="Table" />
                </Legends>
                <Series>
                    <asp:Series Name="Default" />
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1" BorderWidth="0" />
                </ChartAreas>
            </asp:Chart>
        </div>
        <div class="col-lg-6 col-md-12">
            <h4 class="heading">State Wise Code Check</h4>
            <asp:Chart ID="Chart2" runat="server" CssClass="piewieth"
                BorderlineWidth="0" Height="475px" Palette="None" PaletteCustomColors=""
                Width="539px" BorderlineColor="64, 0, 64">
                <Titles>
                    <asp:Title ShadowOffset="10" Name="Items" />
                </Titles>
                <Legends>
                    <asp:Legend Alignment="Center" Docking="Right" IsTextAutoFit="False" Name="Default"
                        LegendStyle="Table" />
                </Legends>
                <Series>
                    <asp:Series Name="Default" />
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1" BorderWidth="0" />
                </ChartAreas>
            </asp:Chart>
        </div>
    </div>
    <div class="row rowbackgroundcolor">
        <div class="col-lg-6 col-md-12">
            <h4 class="heading">State Wise User</h4>
            <asp:Chart ID="Chart3" runat="server" CssClass="piewieth"
                BorderlineWidth="0" Height="475px" Palette="None" PaletteCustomColors=""
                Width="539px" BorderlineColor="64, 0, 64">
                <Titles>
                    <asp:Title ShadowOffset="0" Font="bold" TextStyle="Embed" Name="Items" />
                </Titles>
                <Legends>
                    <asp:Legend Alignment="Center" Docking="Right" IsTextAutoFit="False" Name="Default"
                        LegendStyle="Table" />
                </Legends>
                <Series>
                    <asp:Series Name="Default" />
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1" BorderWidth="0" />
                </ChartAreas>
            </asp:Chart>
        </div>
        <div class="col-lg-6 col-md-12">
            <h4 class="heading">Product Wise Checked Code</h4>
            <asp:Chart ID="Chart4" runat="server" CssClass="piewieth" BorderlineColor="64, 0, 64"
                Height="475px" Palette="None" PaletteCustomColors=""
                Width="539px">
                <Series>
                    <asp:Series Name="Series1">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1">
                    </asp:ChartArea>
                </ChartAreas>
            </asp:Chart>
        </div>
    </div>



                    </div>
                </div>
            </div>
        </div>
    </div>


   
</asp:Content>

