<%@ Page Language="C#" AutoEventWireup="true" CodeFile="veena-polymers.aspx.cs" Inherits="veena_polymers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Veena Polymers</title>
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/fonts/materialdesign-web/css/materialdesignicons.min.css" />
    <link rel="stylesheet" href="vendor/fontawesome-free/css/all.min.css" />
    <link rel="stylesheet" href="vendor/animate/animate.min.css" />
    <link rel="stylesheet" href="vendor/simple-line-icons/css/simple-line-icons.min.css" />
    <link rel="stylesheet" href="vendor/owl.carousel/assets/owl.carousel.min.css" />
    <link rel="stylesheet" href="vendor/owl.carousel/assets/owl.theme.default.min.css" />
    <link rel="stylesheet" href="vendor/magnific-popup/magnific-popup.min.css" />

    <!-- Theme CSS -->
    <link rel="stylesheet" href="css/theme.css" />
    <link rel="stylesheet" href="css/theme-elements.css" />
    <link rel="stylesheet" href="css/theme-blog.css" />
    <link rel="stylesheet" href="css/theme-shop.css" />

    <!-- Current Page CSS -->
    <link rel="stylesheet" href="vendor/rs-plugin/css/settings.css" />
    <link rel="stylesheet" href="vendor/rs-plugin/css/layers.css" />
    <link rel="stylesheet" href="vendor/rs-plugin/css/navigation.css" />
    <link rel="stylesheet" href="vendor/circle-flip-slideshow/css/component.css" />
    <!-- Demo CSS -->

    <!-- Skin CSS -->
    <!--link rel="stylesheet" href="css/skins/skin-corporate-19.css"-->
    <link rel="stylesheet" href="css/skins/default.css" />
    <!-- Theme Custom CSS -->
    <link rel="stylesheet" href="css/custom.css" />
    <!-- Head Libs -->
    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="Content/js/jquery-1.11.1.min.js"></script>
    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Ubuntu:ital,wght@0,300;0,400;0,500;0,700;1,300&display=swap');

        body {
            background: #FFF;
            font-family: 'Ubuntu', sans-serif !important;
        }

        ::-webkit-input-placeholder {
            color: #FFF;
        }

        ::-moz-placeholder {
            color: #FFF;
        }

        :-ms-input-placeholder {
            color: #FFF;
        }

        :-moz-placeholder {
            color: #FFF;
        }

        input:-internal-autofill-selected {
            appearance: menulist-button;
            background-image: none !important;
            background-color: -internal-light-dark(rgb(0, 0, 0, 0), rgba(0, 0, 0, 0)) !important;
            color: -internal-light-dark(black, white) !important;
        }

        .w3rapper {
            width: 100%;
            height: 100%;
            display: block;
            position: relative;
            overflow-x: hidden;
        }

        .bg-grya-light {
            background: #d3e0f4;
        }

        .bg-dark-blue {
            background: #072043 url(../assets/images/veena-polimers/veena-bg.png);
            background-blend-mode: overlay;
        }

        .custom_main-container {
            width: 100%;
            max-width: 1600px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }



        .massage_box {
            color: #12af84 !important;
            overflow: hidden;
            font-size: 13px !important;
            max-width: 100%;
            border: 2px dashed #f47932;
            padding: 1em;
            border-radius: 4px;
        }

            .massage_box strong {
                color: #12af84 !important
            }

            .massage_box a {
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
                display: block;
                color: #fb6405;
                text-decoration: none;
                font-weight: 600;
                margin-top: 10px;
            }


        .main-section {
            position: relative;
            min-height: 100vh;
            height: 100%;
        }

            .main-section .angle-curve {
                position: absolute;
                top: 0;
                bottom: 0;
                width: auto;
                height: 100%;
                left: 0
            }

                .main-section .angle-curve svg {
                    opacity: 0.5;
                }

            .main-section .logo-veena {
                width: 140px;
                overflow: hidden;
                position: absolute;
            }

                .main-section .logo-veena img {
                    width: 100%;
                    display: block
                }

            .main-section .image-sec {
                position: relative;
                margin-left: 50px;
                max-width: 500px;
                min-height: 657px;
            }

                .main-section .image-sec .large-circle {
                    max-width: 500px;
                    border-radius: 100%;
                    border: 10px solid #d3e0f4;
                    overflow: hidden
                }

                .main-section .image-sec .product-veena {
                    max-width: 500px;
                    display: block;
                    position: absolute;
                    bottom: 0;
                    margin-left: -8em;
                }

                    .main-section .image-sec .product-veena img {
                        display: block;
                        width: 100%;
                    }

                .main-section .image-sec .large-circle img {
                    max-width: 100%;
                }

            .main-section .form-section {
                width: calc(100% - 50px);
                position: relative;
                display: block;
                margin-left: 50px;
            }

                .main-section .form-section h1 {
                    font-size: 11em;
                    color: #e6464d;
                    font-weight: 700;
                    letter-spacing: 10px;
                    margin: 0;
                }

                .main-section .form-section h2 {
                    font-size: 5em;
                    letter-spacing: 15px;
                    font-weight: 700;
                    color: #FFF;
                }

                .main-section .form-section h3 {
                    color: #FFF;
                }

                .main-section .form-section h1, .main-section .form-section h2, .main-section .form-section h3, .main-section .form-section strong {
                    text-transform: uppercase
                }

                .main-section .form-section strong {
                    font-size: 1em;
                    font-weight: 700 !important;
                    color: #5b9ed7
                }

                .main-section .form-section label {
                    text-transform: uppercase;
                    color: #FFF;
                    font-size: 0.9em;
                    letter-spacing: 0.5px;
                    font-weight: 500;
                }

                .main-section .form-section .form-control {
                    display: block;
                    width: 100%;
                    height: calc(2.55rem + 2px);
                    padding: 0.575rem 0.75rem;
                    font-size: 1rem;
                    line-height: 1.5;
                    color: #FFF;
                    background-color: #fff0;
                    background-clip: padding-box;
                    border: 1px solid #e2eaf1;
                    border-radius: 0;
                    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
                }

                    .main-section .form-section .form-control:focus {
                        border: 1px solid #2d7bfa;
                    }

                .main-section .form-section .btn-veena {
                    background: rgba(243,101,36);
                    background: linear-gradient(90deg, rgba(228,71,79,1) 14%, rgba(45,123,250,1) 77%);
                    color: #FFF;
                    border: none;
                    border-radius: 2px;
                    padding: 1em 4em;
                    text-transform: uppercase;
                    font-weight: 500;
                    letter-spacing: 0.5px;
                    box-shadow: 0 0 0 0.2rem #dc354580;
                }

            .main-section .sociaLinks ul {
                display: block;
                list-style-type: none;
                margin: 0;
                padding: 0;
            }

                .main-section .sociaLinks ul li {
                    display: inline-block;
                }

                    .main-section .sociaLinks ul li a {
                        color: #FFF;
                        display: flex;
                        align-items: center;
                        justify-content: center
                    }

                        .main-section .sociaLinks ul li a span {
                            display: inline-block;
                            color: #d4eeff;
                            font-size: 21px;
                            text-align: center;
                            width: 28px;
                            height: 28px;
                            line-height: 28px;
                            border-radius: 40px;
                            transition: all 0.5s ease;
                        }

                        .main-section .sociaLinks ul li a strong {
                            font-size: 14px;
                            margin-left: 10px;
                            font-weight: 400 !important;
                        }

                        .main-section .sociaLinks ul li a span.facebook {
                            background: #0f6ed5;
                            color: #FFF;
                        }

                        .main-section .sociaLinks ul li a span.ytube {
                            background: #ed3439;
                            color: #FFF;
                        }

                        .main-section .sociaLinks ul li a span.instagram {
                            background: rgb(68,56,131);
                            background: linear-gradient(180deg, rgba(68,56,131,1) 0%, rgba(235,49,54,1) 100%, rgba(255,234,196,1) 100%);
                        }

            .main-section .web {
                font-weight: 400 !important;
                color: #FFF;
                font-size: 14px;
            }

                .main-section .web:hover {
                    color: #0099e6
                }

        @media(min-width:1024px) {
            .main-section .form-section h1 {
                font-size: 6em;
            }

            .main-section .form-section h2 {
                font-size: 3em;
            }
        }

        @media(max-width:1366px) {
            .main-section .logo-veena {
                width: 110px;
                overflow: hidden;
                z-index: 3;
            }
        }

        @media(max-width:991px) {
            .main-section .image-sec {
                min-height: 462px;
            }

                .main-section .image-sec .product-veena {
                    margin-left: -3em;
                }

            .main-section .form-section {
                width: 100%;
                margin-left: 0;
            }

                .main-section .form-section h1 {
                    font-size: 6em;
                }

                .main-section .form-section h2 {
                    font-size: 3em;
                }
        }

        @media(max-width:768px) {
            .main-section {
                height: 100%;
            }

                .main-section .image-sec .large-circle {
                    border: none;
                }

                .main-section .angle-curve svg polygon {
                    fill: #102b50;
                }

                .main-section .logo-veena {
                    width: 140px;
                    overflow: hidden;
                    position: relative;
                }

                .main-section .form-section {
                    width: 100%;
                    position: relative;
                    margin-left: 0;
                }

                .main-section .image-sec {
                    min-height: 100%;
                    margin-bottom: 40px;
                }

                    .main-section .image-sec .product-veena {
                        margin-left: -50px;
                        bottom: -62px;
                    }
        }

        @media(max-width:480px) {
            .main-section .sociaLinks ul li a strong {
                font-size: 10px;
                margin-left: 10px;
                line-height: 1.1;
            }

            .main-section .logo-veena {
                width: 76px;
                overflow: hidden;
                position: relative;
            }

            .main-section .image-sec .product-veena {
                margin-left: -52px;
                bottom: -40px;
            }

            .main-section .form-section h1 {
                font-size: 5em;
                font-weight: 700;
                letter-spacing: 5px;
                margin: 0;
            }

            .main-section .form-section h2 {
                font-size: 3em;
                letter-spacing: 6px;
            }

            .main-section .form-section h3 {
                font-size: 100%;
            }
        }


        .next_btn {
            background: #ffffff;
            padding: 5px 30px;
            color: #073136 !important;
            text-transform: uppercase;
            font-size: 14px;
            border: 1px solid white;
            margin-top: 20px;
            margin: 20px auto 0px;
            text-align: center;
            float: right;
            border-radius: 3px;
            text-align: center;
            display: table;
            float: none !important;
            margin: 0 auto;
            font-weight: 600;
            text-decoration: none !important;
            outline: none;
            transition: all 0.5s ease;
        }

            .next_btn:hover {
                background: #f36828;
                color: #FFF !important;
                border-color: #f36828;
                box-shadow: 0px 0px 8px rgba(0,0,0,0.2);
            }
    </style>
</head>

<body>
    <form id="form1" runat="server">


        <asp:HiddenField ID="hdnmob" runat="server" />
        <asp:HiddenField ID="HdnID" runat="server" />
        <asp:HiddenField ID="HdnCode1" runat="server" />
        <asp:HiddenField ID="HdnCode2" runat="server" />
        <asp:HiddenField ID="CompName" runat="server" />
        <asp:HiddenField ID="long" runat="server" />
        <asp:HiddenField ID="lat" runat="server" />

        <div class="w3rapper bg_body">
            <section class="bg-dark-blue main-section bg_body">
                <div class="">
                    <div class="angle-curve animated fadeInDown">

                        <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" preserveAspectRatio="none" x="0px" y="0px" width="100%" height="100%" viewBox="0 0 977 812" enable-background="new 0 0 977 812" xml:space="preserve">
                            <polygon fill="#D3E0F2" points="0,812 977,0 0,0"></polygon>
                        </svg>
                    </div>
                    <div class="custom_main-container container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="logo-veena animated fadeInDown">
                                    <img src="assets/images/veena-polimers/veena-brand.png" alt="veena-brand" />
                                </div>
                            </div>
                        </div>
                        <div class="row align-items-center justify-content-lg-center">
                            <div class="col-lg-6 col-md-6 offset-lg-1">
                                <div class="image-sec">
                                    <div class="large-circle animated fadeInRight">
                                        <img src="assets/images/veena-polimers/veena_bg.jpg" alt="veena_bg" />
                                    </div>
                                    <div class="product-veena animated fadeInUp">
                                        <img src="assets/images/veena-polimers/veena-products.png" class="img-fluid" alt="veena-products" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-6 col-lg-5">
                                <div class="form-section">
                                    <div>
                                        <h1 class="animated fadeInDown">Veena</h1>
                                        <h2 class="animated fadeInRight">Polymers</h2>
                                        <div class="row" id="ChkCode">
                                            <div class="col-md-12 animated fadeInDown">
                                                <div class="form-group">
                                                    <label>Enter 13 Digit Code<em>*</em></label>
                                                    <input type="text" id="codeone" data-msg-required="Please enter your name." maxlength="50" class="form-control input1" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row" style="display: none;" id="Chkfields">
                                            <div class="col-md-12 animated fadeInDown">
                                                <h3>TO CHECK AUTHENTICITY / Avail Benefits</h3>
                                                <strong>Fill in the Below details</strong>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="form-group animated fadeInDown">
                                                    <label>Name/नाम</label>
                                                    <input type="text" id="Name" placeholder="Name" data-msg-required="Please Enter Your Full Name" maxlength="50" class="form-control" required="" />
                                                </div>
                                                <div class="form-group animated fadeInDown">
                                                    <label>Mobile Number/मोबाइल नंबर</label>
                                                    <input type="text" id="mobilenumber" maxlength="10" placeholder="Mobile Number" data-msg-required="Please Enter Your Moblie Number" class="form-control" required="" />
                                                </div>

                                                <div class="form-group animated fadeInDown">
                                                    <label>Address/पता</label>
                                                    <input type="text" id="Address" placeholder="Address" data-msg-required="Please Enter Your Address." class="form-control" required="" />
                                                </div>

                                                <div class="form-group animated fadeInDown">
                                                    <label>Seller Name/विक्रेता का नाम (optional)</label>
                                                    <input type="text" id="SellerName" placeholder="Seller Name" class="form-control" />
                                                </div>

                                                <div class="text-right mt-3 animated fadeInDown">
                                                    <input class="btn btn-danger btn-veena" value="Submit" type="button" id="btnsubmit" />
                                                </div>
                                            </div>
                                        </div>

                                        <div style="display: none; padding: 0px !important" id="ShowMessage" class="row no-gutters pl-4 pr-4 textmessage">

                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <p id="p3msg" style="color: white !important; overflow: hidden; font-size: 14px !important;" class="displayNone massage_box"></p>
                                                </div>
                                                <a href="javascript:void(0)" class="next_btn" id="btnNext">Close</a>
                                            </div>


                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row align-items-center justify-content-center mt-4">
                            <div class="col-md-6 col-7">
                                <div class="sociaLinks animated fadeInUp">
                                    <ul>
                                        <li>
                                            <a href="https://youtu.be/6WTajUuX1r0" target="_blank" class="facebook icon-bg icon-bg-sm">
                                                <span class="ytube">
                                                    <i class="mdi mdi-youtube"></i>
                                                </span>
                                                <strong>Watch Videos On YouTube</strong>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-6 col-5">
                                <div>
                                    <a class="float-right web" href="https://www.richies.in" target="_blank">www.richies.in</a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </section>
        </div>

    </form>

    <script>

        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }

        $(document).ready(function () {
            //$('.owel-fharma').owlCarousel({
            //    loop: true,
            //    margin: 8,
            //    items: 2,
            //    responsiveClass: true,
            //    nav: true,
            //    paginationNumbers: true,
            //    slideSpeed: true,
            //    navigation: true,
            //    autoplay: true,
            //    responsive: {
            //        0: {
            //            items: 2
            //        },
            //        600: {
            //            items: 2
            //        },
            //        960: {
            //            items: 4
            //        },
            //        1200: {
            //            items: 6
            //        }
            //    }
            //});


            firstfunction();

            //var queryString = location.search.substring(1);
            //if (navigator.geolocation) {
            //    navigator.geolocation.getCurrentPosition(showPosition);

            //} else {
            //    // x.innerHTML = "Geolocation is not supported by this browser.";
            //}

            var id = $('#HdnID').val();


            if (id == "1") {

                $('#ChkCode').show();
                $('#Chkfields').hide();
            }

            else if (id == "Veena") {
                $('#ChkCode').hide();
                $('#Chkfields').show();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $("#codeone").val(code);


            }


            $("#codeone").mask("99999-99999999");

            $(".input1").keyup(function () {

                if (this.value.length == this.maxLength) {
                    $('#ChkCode').hide();

                    var rquestpage_Dcrypt = $("#codeone").val();

                    $.ajax({
                        type: "POST",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                        success: function (data) {

<%--                            $.ajax({
                                type: "POST",
                                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=SaveLocation&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1] + '&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                                success: function (data1) {--%>

                            $.ajax({
                                type: "POST",
                                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1] + '&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                                success: function (data) {
                                    debugger;

                                    if (data.split('&')[0] === "1" && data.split('&')[1] === "Auto Max India") {

                                    }

                                    else {

                                        $('#CompName').val(data.split('&')[1]);
                                        $('#Chkfields').show();

                                    }
                                }
                            });

                            //    }
                            //});
                        }
                    });
                }
            });

            $('#btnsubmit').on('click', function () {
                $('#btnsubmit').attr('disabled', true);

                var phoneNumber = $('#mobilenumber').val();

                if (phoneNumber != undefined) {
                    if (phoneNumber.length < 10) {
                        toastr.error('Please Enter Valid Mobile Number');
                    }



                    var validate = false;
                    var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;

                    if (filter.test(phoneNumber)) {
                        if (phoneNumber.length == 10) {
                            var c = phoneNumber.slice(0, 1);
                            if (c <= 5) {
                                $('#p3msg').html('Not a valid mobile number');
                                validate = false;
                                $('#mobilenumber').val('');
                            }
                            else
                                validate = true;
                        } else {
                            if (phoneNumber.length > 10) {
                                $('#p3msg').html('Please put 10  digit mobile number');

                                validate = false;
                            }
                            else {
                                validate = false;
                                $('#btnsubmit').attr('disabled', false);
                            }
                        }
                    }



                    else {

                        if (phoneNumber.length == 9) {
                            $('#p3msg').html('Please Enter Valid mobile number');
                            $('#mobilenumber').val('');
                            validate = false;
                        }
                        else
                            validate = false;
                    }


                    if (phoneNumber.match(/[^$,.\d]/)) {
                        toastr.error("Please enter numeric value for mobile No.");
                        validate = false;
                    }

                }
                var name = $('#Name').val();
                if (name != undefined) {


                    if ($('#Name').val().length < 1) {
                        toastr.error('Please Enter valid Name');
                        validate = false;
                    }
                    var matches = $('#Name').val().match(/\d+/g);
                    if (matches != null) {
                        toastr.error('Name Should be alphabet only!');
                        validate = false;
                    }
                    var matches1 = $('#Name').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        toastr.error('Name Should Not Contain any Special Character!');
                        validate = false;
                    }
                }


                var Address = $('#Address').val();
                if (Address != undefined) {


                    if ($('#Address').val().length < 1) {
                        toastr.error('Please Enter Address');
                        validate = false;
                    }
                }


                var SellerName = $('#SellerName').val();
                if (SellerName != undefined) {


                    var matches = $('#SellerName').val().match(/\d+/g);
                    if (matches != null) {
                        toastr.error('Seller Name Should be alphabet only!');
                        validate = false;
                    }
                    var matches1 = $('#SellerName').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        toastr.error('Seller Name Should Not Contain any Special Character!');
                        validate = false;
                    }
                }




                if (validate) {
                    $('#p3msg').html('');


                    if (code != "") {
                        $.ajax({
                            type: "POST",
                            contentType: false,
                            processData: false,

                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&Address=' + $('#Address').val() + '&name=' + $('#Name').val() + '&comp=' + $('#CompName').val() + '&SellerName=' + $('#SellerName').val(),
                            success: function (data) {
                                debugger;
                                if (data.split('~')[0] !== "failure") {
                                    window.scrollTo(0, 0);
                                    $('#head').hide();
                                    $('#Chkfields').hide();
                                    $('#ShowMessage').show();
                                    $('#chkLine').hide();
                                    $('#p3msg').html(data.split('~')[1] + '<br/>To claim or checkpoints - Visit : <a href=https://www.vcqru.com/login.aspx style=margin-top:-1% !important;color:blue;>https://www.vcqru.com/login.aspx</a>');

                                    $('#p3msg:contains("not")').css('color', 'white');





                                }
                                else {

                                    $('#msgcoats').hide();
                                    toastr.error('OTP is not valid. Please provide the valid OTP');
                                    $('#btnskyVerify1').attr('disabled', false);

                                }
                            }
                        });
                    }


                }
                else {

                    $('#btnsubmit').attr('disabled', false);

                }

            });


            $('#btnNext').click(function () {
                window.location.href = '<%=ProjectSession.absoluteSiteBrowseUrl%>';
            });


        });


        //function showPosition(position) {
        //    $('#lat').val(position.coords.latitude);
        //    $('#long').val(position.coords.longitude);
        //    //alert("long: " + $('#lat').val() + "lat: " + $('#long').val());
        //}

        async function firstfunction() {
            debugger;
            if (navigator.geolocation) {
                await getPosition()
                    .then((position) => {
                        $('#lat').val(position.coords.latitude);
                        $('#long').val(position.coords.longitude);
                    })
                    .catch((err) => {
                        console.error(err.message);
                    });
            } else {
                // x.innerHTML = "Geolocation is not supported by this browser.";
            }

            var lat = $('#lat').val();
            var long = $('#long').val();

            $.ajax({
                type: "POST",
                async: true,
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=chklocation&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                success: function (data) {

                    debugger;

                }
            });
        }

    </script>

</body>
</html>
