<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dashboard.aspx.cs" Inherits="Consumer_dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>VCQRU | We secure you</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="author" content="codedthemes" />
    <link rel="icon" href="../img-1/favicon.png" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800&display=swap" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/icon/icofont/css/icofont.css" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/css/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/icon/themify-icons/themify-icons.css" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/css/style.css" />
    <link href="../assets/css/font-awesome.min.css" rel="stylesheet" />
    <style>
        .hide_class {
            display: none;
        }
        #nvh{
                background-color: #5da8ff;
        }
         #nvh ul li a{
                color:#fff;
        }


        .companies {
            width: 100%;
            display: flex;
        }

        @media (max-width: 600px) {
            .companies {
                width: 100%;
                display: contents;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <!-- Pre-loader start -->
        <div class="theme-loader">
            <div class="loader-track">
                <div class="loader-bar"></div>
            </div>
        </div>
        <!-- Pre-loader end -->
        <div id="pcoded" class="pcoded">
            <div class="pcoded-overlay-box"></div>
            <div class="pcoded-container navbar-wrapper">

                <nav class="navbar header-navbar pcoded-header" id="nvh">
                    <div class="navbar-wrapper">
                        <div class="navbar-logo">

                            <div class="mobile-search">
                                <div class="header-search">
                                    <div class="main-search morphsearch-search">
                                        <div class="input-group">
                                            <span class="input-group-addon search-close"><i class="ti-close"></i></span>
                                            <input type="text" class="form-control" placeholder="Enter Keyword">
                                            <span class="input-group-addon search-btn"><i class="ti-search"></i></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="menu_toogle" style="display: none;">
                                <i class="ti-menu"></i>
                            </div>
                            <a href="Dashboard.aspx" runat="server" id="logo">
                                <img class="img-fluid logo_img" id="Complogo" runat="server" src="../assetsfrui/images/auth/logo.png" />
                            </a>
                            <a class="mobile-options">
                                <i class="ti-more"></i>
                            </a>
                        </div>

                        <div class="navbar-container container-fluid">
                            <ul class="nav-left">
                                <%-- <li>
								<a href="CodeCheck.aspx">Check Code</a>
                           </li>--%>
                                <li class="active">
                                    <a href="Dashboard.aspx"><i class="fa fa-tachometer" aria-hidden="true"></i> Dashboard</a>
                                </li>
                                <li>
                                    <a href="profile.aspx?hjhg8h"><i class="fa fa-users" aria-hidden="true"></i> Profile</a>
                                </li>
                                <li>
                                    <a href="transactions.aspx"><i class="fa fa-money" aria-hidden="true"></i> Transactions</a>
                                </li>

                            </ul>
                            <ul class="nav-right">


                                <li class="user-profile header-notification">
                                    <a href="#!">
                                        <asp:Image class="img-radius" alt="User-Profile-Image" ID="top_profile_img" runat="server" />
                                        <span>
                                            <asp:Label ID="lblUser_name" runat="server" /></span>
                                        <i class="ti-angle-down"></i>
                                    </a>
                                    <ul class="show-notification profile-notification">

                                        <li>
                                            <a href="changepassword.aspx">
                                                <i class="ti-user"></i>Change Password
                                            </a>
                                        </li>
                                        <li>
                                            <a href="auth-normal-sign-in.html">
                                                <i class="ti-layout-sidebar-left"></i>
                                                <asp:Button runat="server" BorderStyle="None" BackColor="Transparent" Text="Logout" OnClick="Logout" />
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <div class="pcoded-main-container">
                    <div class="pcoded-wrapper">

                        <div class="pcoded-content">
                            <div class="pcoded-inner-content">
                                <div class="main-body">
                                    <div class="page-wrapper">

                                        <div class="page-body">
                                            <div class="row">

                                                <!-- order-card start -->
                                                <div class="col-md-6 col-xl-3" style="cursor: pointer" onclick="callclick('codes')">
                                                    <div class="card bg-c-blue order-card">
                                                        <div class="card-block">
                                                            <h6 class="m-b-20">Total Codes Checked</h6>
                                                            <h2 class="text-right"><i class="fa fa-qrcode f-left"></i><span>
                                                                <asp:Label ID="lblttlcode" runat="server"></asp:Label></span></h2>
                                                            <p class="m-b-0">Success Codes<span class="f-right"><asp:Label ID="lblsuccesscode" runat="server"></asp:Label></span></p>
                                                            <p style="margin-top: 5px" class="m-b-0">Unsuccess Codes<span class="f-right"><asp:Label ID="lblunsuccess" runat="server"></asp:Label></span></p>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-6 col-xl-3" style="cursor: pointer" id="divcashback" onclick="callclick('cashback')">
                                                    <div class="card bg-c-green order-card">
                                                        <div class="card-block">
                                                            <h6 class="m-b-20">Total Amount Won</h6>
                                                            <h2 class="text-right"><i class="fa fa-money f-left"></i><span style="font-family: Consolas">₹
                                                                <asp:Label ID="lblcashback" runat="server" /></span></h2>
                                                            <p class="m-b-0">Amount Transferred <span class="f-right" style="font-family: Consolas">₹
                                                                <asp:Label ID="lblredeem" runat="server" /></span></p>
                                                            <p style="margin-top: 5px" class="m-b-0">Current Balance to Transfer<span class="f-right" style="font-family: Consolas">₹
                                                                <asp:Label ID="lblcashbalance" runat="server"></asp:Label></span></p>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-6 col-xl-3" style="cursor: pointer" onclick="callclick('points')" id="divpoint">
                                                    <div class="card bg-c-yellow order-card">
                                                        <div class="card-block">
                                                            <h6 class="m-b-20">Total Points Earned</h6>
                                                            <h2 class="text-right"><i class="fa fa-trophy f-left"></i><span>
                                                                <asp:Label ID="lblgift" runat="server" /></span></h2>
                                                            <p class="m-b-0">Points Redeemed<span class="f-right"><asp:Label ID="lblgiftrec" runat="server" /></span></p>
                                                            <p style="margin-top: 5px" class="m-b-0">Wallet Balance<span class="f-right"><asp:Label ID="lblpointbalance" runat="server"></asp:Label></span></p>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-6 col-xl-3" style="cursor: pointer" id="divwarranty" onclick="callclick('warranty')">
                                                    <div class="card bg-c-pink order-card">
                                                        <div class="card-block">
                                                            <h6 class="m-b-20">Total Warranty Registered</h6>
                                                            <h2 class="text-right"><i class="ti-medall-alt f-left"></i><span>
                                                                <asp:Label ID="lblwarranty" runat="server" /></span></h2>
                                                            <p class="m-b-0">Product under Warranty<span class="f-right"><asp:Label ID="lblvalid" runat="server" /></span></p>
                                                            <p style="margin-top: 5px" class="m-b-0">&nbsp;&nbsp<span class="f-right"><asp:Label ID="Label1" runat="server"></asp:Label></span></p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 col-xl-3" style="cursor: pointer" id="divwarranty2" onclick="callclick('warranty')">
                                                    <div class="card bg-c-pink order-card">
                                                        <div class="card-block">
                                                            <h6 class="m-b-20">Total Warranty Check</h6>
                                                            <h2 class="text-right"><i class="ti-medall-alt f-left"></i><span>
                                                                <asp:Label ID="lblwarranty2" runat="server" /></span></h2>
                                                            <p class="m-b-0">Valid Products<span class="f-right"><asp:Label ID="Label2" runat="server" /></span></p>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 col-xl-3" style="cursor: pointer" id="divwarranty3" onclick="callclick('warranty')">
                                                    <div class="card bg-c-pink order-card">
                                                        <div class="card-block">
                                                            <h6 class="m-b-20">Total Warranty Check</h6>
                                                            <h2 class="text-right"><i class="ti-medall-alt f-left"></i><span>
                                                                <asp:Label ID="lblwarranty3" runat="server" /></span></h2>
                                                            <p class="m-b-0">Valid Products<span class="f-right"><asp:Label ID="Label4" runat="server" /></span></p>

                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-6 col-xl-3" style="cursor: pointer" id="divwarranty4" onclick="callclick('warranty')">
                                                    <div class="card bg-c-pink order-card">
                                                        <div class="card-block">
                                                            <h6 class="m-b-20">Total Warranty Check</h6>
                                                            <h2 class="text-right"><i class="ti-medall-alt f-left"></i><span>
                                                                <asp:Label ID="lblwarranty4" runat="server" /></span></h2>
                                                            <p class="m-b-0">Valid Products<span class="f-right"><asp:Label ID="Label6" runat="server" /></span></p>

                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="companies" id="comapnies" runat="server">
                                                </div>

<div class="col-md-12 row col-xl-12" runat="server" visible="false" style="cursor: pointer" id="reward">
                                                   <img src="../assets/gift-point-img.jpg" id="imggift" class="img-thumbnail" alt="Cinque Terre" width="600" height="536" />
                                                </div>


                                                <!-- social statustic end -->
                                                <%--<asp:Button ID="gotosum" runat="server" OnClick="gotosum_Click" Style="display:none" />--%>
                                                <!-- users visite and profile start -->



                                            </div>
                                        </div>

                                        <div id="styleSelector">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </form>
    <script type="text/javascript" src="../assetsfrui/js/jquery.min.js"></script>

    <script type="text/javascript" src="../assetsfrui/js/bootstrap.min.js"></script>
    <!-- <script type="text/javascript" src="assets/js/jquery-slimscroll/jquery.slimscroll.js"></script> -->
    <script type="text/javascript" src="../assetsfrui/js/script.js"></script>
    <script src="../assetsfrui/js/pcoded.min.js"></script>
    <script src="../assetsfrui/js/vartical-demo.js"></script>
    <!-- <script src="assets/js/jquery.mCustomScrollbar.concat.min.js"></script> -->

</body>
<script>

    $('.menu_toogle').click(function () {
        $('.nav-left').toggleClass('slide_show');
    });
    debugger;
    function gotosummary(obj) {
        window.location.href = '../consumer/transactions.aspx?summary=' + obj.id
    }
    debugger;
    function callclick(obj) {
        window.location.href = '../consumer/transactions.aspx?filter=' + obj;
    }
    $(document).ready(function () {
        debugger;

        if ($('#lblwarranty').text() == '0' || $('#lblwarranty').text() == '') {
            $('#divwarranty').addClass('hide_class');
        }
        if ($('#lblgift').text() == '0' || $('#lblgift').text() == '') {
            $('#divpoint').addClass('hide_class');
        }
        if ($('#lblcashback').text() == '0' || $('#lblcashback').text() == '') {
            $('#divcashback').addClass('hide_class');
        }

        if ($('#lblwarranty2').text() == '0' || $('#lblwarranty2').text() == '') {
            $('#divwarranty2').addClass('hide_class');
        }
        if ($('#lblwarranty3').text() == '0' || $('#lblwarranty3').text() == '') {
            $('#divwarranty3').addClass('hide_class');
        }
        if ($('#lblwarranty4').text() == '0' || $('#lblwarranty4').text() == '') {
            $('#divwarranty4').addClass('hide_class');
        }
    });
</script>
</html>
