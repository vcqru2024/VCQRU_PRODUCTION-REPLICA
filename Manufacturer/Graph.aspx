<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="Graph.aspx.cs" Inherits="Manufacturer_Graph" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script src="https://cdn.anychart.com/releases/v8/js/anychart-base.min.js"></script>

    <script src="https://cdn.anychart.com/releases/v8/js/anychart-ui.min.js"></script>

    <script src="https://cdn.anychart.com/releases/v8/js/anychart-exports.min.js"></script>

    <link href="https://cdn.anychart.com/releases/v8/css/anychart-ui.min.css" type="text/css" rel="stylesheet">

    <link href="https://cdn.anychart.com/releases/v8/fonts/css/anychart-font.min.css" type="text/css" rel="stylesheet">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>

    <link rel="stylesheet" type="text/css" href="~/iconnew/style.css" />

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <style>
        @import url(//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css);

        @import url(https://fonts.googleapis.com/css?family=Titillium+Web:300);

        .fa-2x {
            font-size: 2em;
        }

        /*.fa {
            position: relative;
            display: table-cell;
            width: 60px;
            height: 36px;
            text-align: center;
            vertical-align: middle;
            font-size: 20px;
        }*/


        #container {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
        }

        /*  #container svg{
                width:100%;
                height:100%;
            }*/

        #state_pie {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
        }

        .main-menu:hover, nav.main-menu.expanded {
            width: 250px;
            overflow: visible;
        }

        .main-menu {
            background: #0194ef;
            border-right: 1px solid #e5e5e5;
            position: absolute;
            top: 0;
            bottom: 0;
            height: 100%;
            left: 0;
            width: 60px;
            overflow: hidden;
            -webkit-transition: width .05s linear;
            transition: width .05s linear;
            -webkit-transform: translateZ(0) scale(1,1);
            z-index: 1000;
        }

            .main-menu > ul {
                margin: 7px 0;
            }

            .main-menu li {
                position: relative;
                display: block;
                width: 250px;
            }

                .main-menu li > a {
                    position: relative;
                    display: table;
                    border-collapse: collapse;
                    border-spacing: 0;
                    color: #fff;
                    font-family: arial;
                    font-size: 14px;
                    text-decoration: none;
                    -webkit-transform: translateZ(0) scale(1,1);
                    -webkit-transition: all .1s linear;
                    transition: all .1s linear;
                }

            .main-menu .nav-icon {
                position: relative;
                display: table-cell;
                width: 60px;
                height: 36px;
                text-align: center;
                vertical-align: middle;
                font-size: 18px;
            }

            .main-menu .nav-text {
                position: relative;
                display: table-cell;
                vertical-align: middle;
                width: 190px;
                font-family: 'Titillium Web', sans-serif;
            }

            .main-menu > ul.logout {
                position: absolute;
                left: 0;
                bottom: 0;
            }

        .no-touch .scrollable.hover {
            overflow-y: hidden;
        }

            .no-touch .scrollable.hover:hover {
                overflow-y: auto;
                overflow: visible;
            }

        a:hover, a:focus {
            text-decoration: none;
        }

        nav {
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            -o-user-select: none;
            user-select: none;
        }

            nav ul, nav li {
                outline: 0;
                margin: 0;
                padding: 0;
            }

        /*.main-menu li:hover > a, nav.main-menu li.active > a, .dropdown-menu > li > a:hover, .dropdown-menu > li > a:focus, .dropdown-menu > .active > a, .dropdown-menu > .active > a:hover, .dropdown-menu > .active > a:focus, .no-touch .dashboard-page nav.dashboard-menu ul li:hover a, .dashboard-page nav.dashboard-menu ul li.active a {
                color: #fff;
                background-color: #0676bc;
            }*/

        .area {
            float: left;
            background: #e2e2e2;
        }

        @font-face {
            font-family: 'Titillium Web';
            font-style: normal;
            font-weight: 300;
            src: local('Titillium WebLight'), local('TitilliumWeb-Light'), url(https://themes.googleusercontent.com/static/fonts/titilliumweb/v2/anMUvcNT0H1YN4FII8wpr24bNCNEoFTpS2BTjF6FB5E.woff) format('woff');
        }

        .row {
            --bs-gutter-x: 0rem;
        }

        .color-blue {
            background: rgb(23,169,220);
            background: linear-gradient(90deg, rgba(23,169,220,1) 0%, rgba(71,198,243,1) 100%);
        }

        .color-yellow {
            background: rgb(255,152,24);
            background: linear-gradient(90deg, rgba(255,152,24,1) 0%, rgba(255,199,91,1) 100%);
        }

        .color-darkBlue {
            background: rgb(99,111,185);
            background: linear-gradient(90deg, rgba(99,111,185,1) 0%, rgba(1,148,239,1) 100%);
        }

        .report-box {
            padding: 20px;
            margin: 20px;
            border-radius: 15px;
            color: #fff;
        }

            .report-box img {
                width: 28%;
                padding: 10px;
                display: inline-block;
                float: left;
            }

        .icon-title {
            padding: 10px;
        }

        .report-title {
            color: #ccc;
        }

        .container-box {
            background-color: #FDCC4C;
        }



        /*body {
            background-color: #1B1F2A;
            width: 100%;
            font-family: 'Roboto', sans-serif;
            height: 100%;
        }*/

        /*.widget {
            margin: 0 auto;
            width: 350px;
            margin-top: 50px;
            background-color: #222D3A;
            border-radius: 5px;
            box-shadow: 0px 0px 1px 0px #06060d;
        }*/




        .skills {
            text-align: right;
            color: white;
        }

        .Haryana {
            width: 10%;
            background-color: #5A75E0;
        }

        .Rajasthan {
            width: 20%;
            background-color: #5A75E0;
        }

        .Delhi {
            width: 40%;
            background-color: #5A75E0;
        }

        .Mumbai {
            width: 65%;
            background-color: #5A75E0;
        }

        .Goa {
            width: 70%;
            background-color: #5A75E0;
        }

        #StateChart {
            width: 730px !important;
            height: 730px !important;
            margin: auto;
        }

        .header {
            height: 40px;
            color: #06060d;
            text-align: center;
            line-height: 40px;
            border-top-left-radius: 7px;
            border-top-right-radius: 7px;
            font-weight: 400;
            font-size: 18px;
            text-shadow: 1px 1px #06060d;
        }
        /*#myChart{
            width:100%;
            height:100%;
            max-width:500px;
        }*/
        .chart-container {
            padding: 25px;
        }

        .shadow {
            -webkit-filter: drop-shadow( 0px 3px 3px rgba(0,0,0,.5) );
            filter: drop-shadow( 0px 3px 3px rgba(0,0,0,.5) );
        }

        #PieChart1 {
            height: 100%;
            width: 100%;
        }

        @media screen and (max-width:767px) {
            .report-box img {
                width: 36%;
            }

            .margin-leftSpace {
                margin-left: 10%;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">





    <div class="container">
        <div class="row pt-5">
            <div class="col-sm-6">
                <a href="#"></a>
            </div>
            <div class="col-sm-6">
                <%--<h6 class="text-end">VCQRU.COM</h6>--%>
            </div>
        </div>
        <%--<div class="row">
            <div class="col-sm-12 mt-4 mb-5">
                <h2 class="text-center report-title">BSC PAints</h2>
            </div>
        </div>--%>

        <div class="row margin-leftSpace">
            <div class="col-sm-4">
                <div class="report-box color-blue ">
                    <div class="row">
                        <div class="">
                            <img src="../iconnew/1-icon.png" alt="icon" />

                            <div class="icon-title">
                                <h6>Total generated Codes</h6>
                                <h2>
                                    <asp:Label ID="lblttlcode" runat="server"></asp:Label></h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="report-box color-yellow">
                    <div class="">

                        <img src="../iconnew/2-icon.png" alt="icon" />


                        <div class="icon-title">
                            <h6>Total Users</h6>
                            <h2>
                                <asp:Label ID="lbltotalusers" runat="server"></asp:Label></h2>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="report-box color-darkBlue">
                    <div class="">

                        <img src="../iconnew/3-icon.png" alt="icon" />

                        <div class="icon-title">
                            <h6>Products</h6>
                            <h2>
                                <asp:Label ID="lbltotalproduct" runat="server"></asp:Label></h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="container pb-5">

        <div class="row ">
            <div class="col-sm-6">
                <asp:Literal ID="ltScripts" runat="server"></asp:Literal>
                <div id="myChart" style="height: 600px; width: 600px"></div>
            </div>

            <div class="col-sm-6">
                <asp:Literal ID="ltScripts2" runat="server"></asp:Literal>
                <div id="container"></div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-5 mt-5">
            <h5 class="text-center">City Wise Code Check</h5>
            <asp:Literal ID="ltScripts3" runat="server"></asp:Literal>
            <%-- <canvas id="StateChart" style="width: 100%; max-width: 100%"></canvas>--%>
            <div id="StateChart" style="width: 900px; height: 500px;"></div>
        </div>
        <div class="col-sm-7 mt-5  m-auto">
            <h5>Total Generated codes Productwise VS
                    Used Codes Productwise
            </h5>
            <asp:Literal ID="ltScripts1" runat="server"></asp:Literal>
            <div id="piechart_3d" style="width: 100%; max-width: 600px; height: 730px;"></div>
            <canvas id="ProductwiseChart" style=" max-width: 600px"></canvas>
        </div>

    </div>



    <div class="row">

        <div class="col-sm-12">
            <div class="title text-center">
                <h3>Top Locations</h3>
                <span>of code checkers</span>
                <asp:Literal ID="Literal7" runat="server"></asp:Literal>
                <div id="bar" style="height: 900px; width: auto"></div>


                <%--  </div>
                <p>Haryana</p>
                <div class="container-box">
                    <div class="skills Haryana">10%</div>
                </div>

                <p>Rajasthan</p>
                <div class="container-box">
                    <div class="skills Rajasthan">20%</div>
                </div>

                <p>Delhi</p>
                <div class="container-box">
                    <div class="skills Delhi">40%</div>
                </div>

                <p>Mumbai</p>
                <div class="container-box">
                    <div class="skills Mumbai">65%</div>
                </div>

                <p>Goa</p>
                <div class="container-box">
                    <div class="skills Goa">70%</div>
                </div>
            </div>--%>
            </div>
        </div>
    </div>


    <script type="text/javascript">
        debugger;
        google.load("visualization", "1", { packages: ["corechart"] });
        google.setOnLoadCallback(drawChart);
        function drawChart() {
            var options = {
                title: '',





            };
            $.ajax({
                type: "POST",
                url: '../Graph.aspx/GetChartData4',
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var data = google.visualization.arrayToDataTable(r.d);
                    var chart = new google.visualization.ColumnChart($("#bar")[0]);
                    //var chart = new google.visualization.anychart.pie($("#container")[0]);
                    chart.draw(data, options);
                },
                failure: function (r) {
                    alert(r.d);
                },
                error: function (r) {
                    alert(r.d);
                }
            });
        }
    </script>





    <script type="text/javascript">
        debugger;
        google.load("visualization", "1", { packages: ["corechart"] });
        google.setOnLoadCallback(drawChart);
        function drawChart() {
            var options = {
                title: '',
                pieHole: 0.5
            };
            $.ajax({
                type: "POST",
                url: "../Graph.aspx/GetChartData4",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var data = google.visualization.arrayToDataTable(r.d);
                    var chart = new google.visualization.PieChart($("#StateChart")[0]);
                    chart.draw(data, options);
                },
                failure: function (r) {
                    alert(r.d);
                },
                error: function (r) {
                    alert(r.d);
                }
            });
        }
    </script>







    




    <script>

        debugger;
        google.load("visualization", "1", { packages: ["corechart"] });
        google.setOnLoadCallback(drawChart);
        function drawChart() {
            var options = {
                title: 'City Wise Code Check',
                is3D: true,
                isanychart: true



            };
            $.ajax({
                type: "POST",
                url: "../Graph.aspx/GetChartData5",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var data = google.visualization.arrayToDataTable(r.d);
                    var chart = new google.visualization.PieChart($("#container")[0]);
                    //var chart = new google.visualization.anychart.pie($("#container")[0]);
                    chart.draw(data, options);
                },
                failure: function (r) {
                    alert(r.d);
                },
                error: function (r) {
                    alert(r.d);
                }
            });
        }




    </script>
</asp:Content>

