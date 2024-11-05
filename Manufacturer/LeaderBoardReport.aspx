<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="LeaderBoardReport.aspx.cs" Inherits="Manufacturer_LeaderBoardReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

    <%@ Register
        Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
        Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
        <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
   
            <!-- <link rel="stylesheet"
            href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
                crossorigin="anonymous"></script>
                <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
                <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
                <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
                
            
                



                <script>
                    // function openDate(){
                    //     var inputElement = document.getElementById('Test_DatetimeLocal');
                    //     if (inputElement.style.display === 'none' || inputElement.style.display === '') {
                    //         inputElement.style.display = 'block';
                    //     } else {
                    //         inputElement.style.display = 'none';
                    //     }
                    // }
                    // document.getElementById('toggleLink').addEventListener('click', function(event) {
                    //     event.preventDefault();
                        
                    // });
                </script>
                <script>
                 document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('.form-select').addEventListener('change', function() {
        var selectedOption = this.options[this.selectedIndex];
        var inputElements = document.querySelectorAll('.Test_DatetimeLocal');

        if (selectedOption.id === 'toggleLink') {
            inputElements.forEach(function(inputElement) {
                if (inputElement.style.display === 'none' || inputElement.style.display === '') {
                    inputElement.style.display = 'block';
                } else {
                    inputElement.style.display = 'none';
                }
            });
        } else {
            inputElements.forEach(function(inputElement) {
                inputElement.style.display = 'none';
            });
        }
    });
});

                </script>

            
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
                .Test_DatetimeLocal{
                    display: none;
                }
                   #Test_DatetimeLocal {
            display: none;
        }
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
                    font-weight: 600;
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


                body{
                    background-color: #F5F6FA !;
                    
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

                .foot-box span,
                .foot-box strong {
                    font-size: 14px !important;
                }

                .foot-box strong {
                    font-weight: 600 !important;
                }
            </style>
            <style>
                .page-wrapper {
                    height: 100%;
                    margin-top: 80px;
                    margin-left: 250px;
                    transition: margin 0.3s ease-in-out;
                }

                .dashboard-header {
                    background: url('../assets/img/dashboard-icon/header-bg.svg');
                    padding: 1.5rem 1.5rem 4rem 1.5rem;
                    background-position: center;
                    background-repeat: no-repeat;
                    background-size: cover;
                    color: var(--bs-white);
                }

                .dashboard-header h4 {
                    margin-bottom: 0.50rem;
                    color: white;

                }

                .dashboard-header h1 {
                    margin-bottom: 0.50rem;
                    font-weight: 700;

                }

                .dashboard-header p {
                    margin-bottom: 0;
                    color: white;
                }

                /* .graph-sec {
            margin: 1rem 0;
        } */

                .graph-sec .card {
                    width: 100%;

                    /* font-family: 'Times New Roman', Times, serif; */
                }

                .page-content-wrapper .dashboard-header h4 {
                    margin-bottom: 0.50rem;
                }

                .page-content-wrapper .dashboard-header h1 {
                    margin-bottom: 0.50rem;
                    font-weight: 700;
                    color: #fff;
                }

                .page-content-wrapper .dashboard-header p {
                    margin-bottom: 0;
                }

                /* header-top-card */
                .page-content-wrapper .dashboard-top-cards .card .card-body ul {
                    list-style: none;
                    padding: 0;
                    margin: 0;
                    display: flex;
                    justify-content: space-between;
                }


                .page-content-wrapper .dashboard-top-cards .card .card-body ul li img {
                    height: 3rem;
                    border-radius: 8px;

                }

                .page-content-wrapper .dashboard-top-cards .card .card-body ul li .card-title {
                    margin-bottom: 0.25rem;
                    font-weight: 500;
                }

                .page-content-wrapper .dashboard-top-cards .card .card-body ul li h2 {
                    font-weight: 700;
                    margin-bottom: 0.25rem;
                }

                .page-content-wrapper .dashboard-top-cards .card .card-body ul li .card-text {
                    color: var(--bs-secondary);
                }

                .page-content-wrapper .dashboard-top-cards {
                    margin-top: -50px;

                }

                .page-content-wrapper .dashboard-top-cards .card {
                    border: 0;
                }

                .page-content-wrapper .home-section {
                    padding: 1rem;
                }
                h6{
                    font-size: larger;
                    font-weight: 600;
                }
              .LeaderBoardReport-table.table tbody th,
              .LeaderBoardReport-table.table tbody td{
                vertical-align: middle;
    border-bottom: 1px solid #dee2e6;
    color: #565656;
    white-space: nowrap;
    /* font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif; */
              }

            </style>
<%--            <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.4/Chart.min.js"></script>--%>

        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
            <div id="page-content-wrapper" class="page-content-wrapper">

                <div class="dashboard-header">
                    <h4>
                        <asp:Label ID="lblGreeting" runat="server">shweta</asp:Label>,  <asp:Label ID="lblloginName" runat="server">shweta</asp:Label>
                    </h4>
                   <%-- <h1>
                       
                    </h1>--%>
                <%--    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Unde voluptatum soluta laboriosam
                        temporibus ullam, repellat.</p>--%>
                </div>
                <div class="home-section">

                    <div class="dashboard-top-cards">
                        <div class="row g-3">
                            <div class="col-xxl-4 col-xl-4 col-lg-4 col-md-6 mb-3">
                                
                                        <ul>
                                            <li>
                                                <h6 class="card-title text-black  ">Total Cash Paid</h6>
                                                <h2 class="text-success">
                                                    <asp:Label ID="lblTotalcashPaid" CssClass="lbltotalcodec"
                                                        runat="server"></asp:Label>
                                                </h2>

                                            </li>
                                            <li>
                                                <img src="../assets/img/dashboard-icon/1.svg"
                                                    alt="Generated Codes">
                                            </li>
                                        </ul>
                                    </div>
                                
                            
                            <div class="col-xxl-4 col-xl-4 col-lg-4 col-md-6 mb-3">
                                
                                        <ul>
                                            <li>
                                                <h6 class="card-title text-black">Claim Received</h6>
                                                <h2 class="text-danger">
                                                    <asp:Label ID="lblClaimReceived" class="lbltotalcodec"  CssClass="" runat="server">
                                                    </asp:Label>
                                                </h2>

                                            </li>
                                            <li>
                                                <img src="../assets/img/dashboard-icon/2.svg"
                                                    alt="Checked Code">
                                            </li>
                                        </ul>
                                    </div>
                                
                            
                            <div class="col-xxl-4 col-xl-4 col-lg-4 col-md-6 mb-3">
                                
                                        <ul>
                                            <li>
                                                <h6 class="card-title text-black">Claim Approved </h6>
                                                <h2 class="text-primary">
                                                    <asp:Label ID="lblClaimApproved" CssClass="lbltotalcodec"
                                                        runat="server"></asp:Label>
                                                </h2>

                                            </li>
                                            <li>
                                                <img src="../assets/img/dashboard-icon/3.svg"
                                                    alt="Registered User">
                                            </li>
                                        </ul>
                                    </div>
                                
                            
                            <div class="col-xxl-4 col-xl-4 col-lg-4 col-md-6 mb-3">
                                
                                        <ul>
                                            <li>
                                                <h6 class="card-title text-black">User Received Benefits</h6>
                                                <h2 class="text-warning">
                                                    <asp:Label ID="lblUserReceivedBenefits" CssClass="lbltotalcodec"
                                                        runat="server"></asp:Label>
                                                </h2>

                                            </li>
                                            <li>
                                                <img src="../assets/img/dashboard-icon/4.svg"
                                                    alt="Registered Product">
                                            </li>
                                        </ul>
                                    </div>
                                
                            
                            <div class="col-xxl-4 col-xl-4 col-lg-4 col-md-6 mb-3">
                                
                                        <ul>
                                            <li>
                                                <h6 class="card-title text-black">Rejected Claim</h6>
                                                <h2 class="text-primary">
                                                    <asp:Label ID="lblRejectedclaims" CssClass="lbltotalcodec"
                                                        runat="server"></asp:Label>
                                                </h2>

                                            </li>
                                            <li>
                                                <img src="../assets/img/dashboard-icon/5.svg"
                                                    alt="Registered User">
                                            </li>
                                        </ul>
                                    </div>
                                
                            
                            <div class="col-xxl-4 col-xl-4 col-lg-4 col-md-6 mb-3">
                                
                                        <ul>
                                            <li>
                                                <h6 class="card-title text-black">Pending Claim</h6>
                                                <h2 class="text-warning">
                                                    <asp:Label ID="lblPendingclaims" CssClass="lbltotalcodec" runat="server"></asp:Label>
                                                </h2>

                                            </li>
                                            <li>
                                                <img src="../assets/img/dashboard-icon/6.svg"
                                                    alt="Registered Product">
                                            </li>
                                        </ul>
                                    </div>
                                
                            
                        </div>
                    </div>

                    <div class="graph-sec">
                        <div class="row g-3">
                            
                            
                            <div class="col-xxl-12 col-xxl-12 col-lg-12 d-flex mb-3">
                                <div class="card ">
                                    <div class="card-body">
                                        <div class="filters">
                                            <div class="row">
                                            <div class="col-xxl-2 col-xxl-2 col-lg-2">
                                            <h5>Leader Board</h5>
                                            </div>
                                            <div class="col-xxl-2 col-xxl-2 col-lg-2 ">
                                            <div class="Test_DatetimeLocal">
                                            <div class="d-flex align-items-center justify-content">
                                            <h6>From: </h6>
                                            <asp:TextBox ID="txtDateFrom" Visible="true" runat="server" CssClass="form-control form-control-sm" Text="From Date"></asp:TextBox>
                                            <cc1:CalendarExtender runat="server" ID="txtfromdate_ce" Format="yyyy-MM-dd" PopupButtonID="txtDateFrom"
                                            TargetControlID="txtDateFrom" >
                                            </cc1:CalendarExtender>
                                            </div>
                                            </div>
                                            </div>
                                            <div class="col-xxl-2 col-xxl-2 col-lg-2 ">
                                            <div class="Test_DatetimeLocal">
                                            <div class="d-flex align-items-center justify-content">
                                            <h6>To:</h6>
                                            <asp:TextBox ID="txtDateto" Visible="true" runat="server" CssClass="form-control form-control-sm" Text="To Date"></asp:TextBox>
                                            <cc1:CalendarExtender runat="server" ID="txttodate_ce" Format="yyyy-MM-dd" Animated="False"
                                            PopupButtonID="txtDateto" TargetControlID="txtDateto">
                                            </cc1:CalendarExtender>

                                            </div>
                                            </div>
                                            </div>
                                                
                                            <div class="col-xxl-2 col-xxl-2 col-lg-2">
                                            <asp:DropDownList ID="ddlst" runat="server" CssClass="form-select form-control">
                                            <asp:ListItem Text="" Selected="True">Select One</asp:ListItem>
                                            <asp:ListItem Text="Today"></asp:ListItem>
                                            <asp:ListItem Text="Yesterday"></asp:ListItem>
                                            <asp:ListItem Text="Weekly"></asp:ListItem>
                                            <asp:ListItem Text="Monthly"></asp:ListItem>
                                            <asp:ListItem Text="Yearly"></asp:ListItem>
                                            <asp:ListItem Text="Custom" id="toggleLink"></asp:ListItem>
                                            </asp:DropDownList>

    
    
                                            </div>
                                            <div class="col-xxl-2 col-xxl-2 col-lg-2" >
                                            <asp:DropDownList ID="DropDownList1" runat="server" 
                                            CssClass="form-control form-control-sm">
                                            </asp:DropDownList>
                                            </div>
                                            <div class="col-xxl-2 col-xxl-2 col-lg-2" >
                                            <asp:ImageButton ID="ImgSearch"  Visible="true" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="servss"
                                            ToolTip="Search" OnClick="ImgSearch_Click1" />
                                            <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" ToolTip="Reset"
                                            OnClick="ImgRefresh_Click" />
                                            </div>
                                                
                                            </div>
                                        </div>
                                        <br>
                                        <div class="table-responsive table_large">
                                        <asp:GridView ID="grd1" runat="server" CssClass="table tblSorting LeaderBoardReport-table" EmptyDataText="Record Not Found" BorderColor="transparent">
                                       
                                        </asp:GridView>
                                            </div>
                                    </div>
                                </div>
                            </div>
                        
                            <%--<div class="col-xxl-8 col-xxl-8 col-lg-8 d-flex mb-3">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Product Wise Checked Code</h5>
                                        <hr>
                                        <asp:Chart ID="Chart4" runat="server" CssClass="piewieth"
                                            BorderlineColor="64, 0, 64" Height="475px" Palette="None"
                                            PaletteCustomColors="" Width="539px">
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
                            </div>--%>
                            </div>
                    </div>
                </div>

      </div>
        </asp:Content>
