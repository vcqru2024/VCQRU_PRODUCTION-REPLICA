<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fharmaceticals.aspx.cs" Inherits="fharmaceticals" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/fonts/materialdesign-web/css/materialdesignicons.min.css" />
    <link rel="stylesheet" href="vendor/fontawesome-free/css/all.min.css" />
    <link rel="stylesheet" href="vendor/animate/animate.min.css" />
    <link rel="stylesheet" href="vendor/simple-line-icons/css/simple-line-icons.min.css" />
    <link rel="stylesheet" href="vendor/owl.carousel/assets/owl.carousel.min.css" />

    <link rel="stylesheet" href="vendor/magnific-popup/magnific-popup.min.css" />
    <!-- Theme CSS -->
    <!--<link rel="stylesheet" href="css/theme.css" />
    <link rel="stylesheet" href="css/theme-elements.css" />
    <link rel="stylesheet" href="css/theme-blog.css" />
    <link rel="stylesheet" href="css/theme-shop.css" />-->
    <!-- Current Page CSS -->

    <!-- Demo CSS -->
    <!-- Skin CSS -->


    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="Content/js/jquery-1.11.1.min.js"></script>
    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>

    <style>
        body {
            background: #FFF;
            font-family: 'Poppins', sans-serif;
        }

        @import url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,200;1,300;1,400;1,500;1,600&display=swap');

        .h3, h3 {
            font-size: 1.1rem;
        }

        .wrapper-box {
            position: relative;
            overflow: hidden;
            height: 100%;
            width: 100%;
        }

        .wrapper-bg {
            background: url(../assets/images/fharmaceuticals/pharma_bg.png)
        }

        .common-section {
            width: 100%;
            height: 100%;
            position: relative;
            padding: 3em 0;
            min-height: 100vh;
        }

            .common-section .shapes {
                position: absolute;
                left: -4.061%;
                top: -31.611%;
                background: #1b876a;
                width: 538px;
                height: 538px;
                border-radius: 30px;
                transition: all 0.5s ease;
                opacity: 0.5;
                -ms-transform: rotate(45deg) !important;
                -o-transform: rotate(45deg) !important;
                -moz-transform: rotate(45deg) !important;
                -webkit-transform: rotate(45deg) !important;
                transform: rotate(45deg) !important;
            }

                .common-section .shapes::after {
                    position: absolute;
                    left: 91.939%;
                    top: 15%;
                    background: #1f705a;
                    width: 300px;
                    height: 300px;
                    content: '';
                    border-radius: 30px;
                    z-index: 999;
                    opacity: 0.6;
                }

        .max-container {
            max-width: 1200px;
        }

        .position_index {
            position: relative;
            z-index: 2;
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

        .common-section .curvebg {
            position: absolute;
            top: 0;
            width: 100%;
            height: 100%;
            min-height: 600px;
            z-index: -1;
        }

            .common-section .curvebg svg {
                height: 100%;
                width: 100%;
            }

                .common-section .curvebg svg path {
                    fill: #0c9e76;
                }

        .header-topstrip {
            /*border-bottom:1px solid #eaeaea;
           background:#FFF;*/
            padding: 15px 0;
            z-index: 2;
            position: relative;
            background: #FFF;
        }

        #dynamic {
            margin: 0px auto;
        }

        .newClass {
            border: none;
            background-color: orange;
        }

        .header-topstrip .balaji-brand {
            max-width: 250px;
        }

        .header-topstrip .fharma-brand-text h1 {
            color: #f36828;
            font-weight: 700;
            line-height: 1.1;
        }

            .header-topstrip .fharma-brand-text h1 span {
                color: #4f9d9b;
            }

        .header-topstrip .balaji-brand img {
            max-width: 100%;
            display: block;
        }

        .common-section .hedding h3, .common-section .hedding h1, .common-section .hedding h2, .common-section .hedding p {
            color: #FFF;
        }

        .common-section .hedding h1 {
            margin-bottom: 1rem;
            font-size: 2.2rem;
            text-transform: uppercase;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .common-section .hedding h3 {
            font-size: 0.9em;
            letter-spacing: 0.6px;
            color: #0c9d76;
            font-weight: 600;
            padding: 0.3rem 0.5rem;
            border-radius: 20px;
            border: 1px dashed #0c9e76;
        }

        .common-section .code-cforma {
            background: transparent;
        }

            .common-section .code-cforma h4 {
                font-size: 0.9rem;
                color: #f36828;
                margin-bottom: 1rem;
                letter-spacing: 0.5px;
            }

            .common-section .code-cforma .img_tophed {
                background: #FFF;
                overflow: hidden;
                border-radius: 10px;
                position: relative;
                padding-bottom: 20px;
                box-shadow: 0px 15px 20px rgba(0, 0, 0, 0.2);
            }

            .common-section .code-cforma::before {
                width: 100px;
                height: 100px;
                background: #c19484;
                content: '';
                position: absolute;
                border-radius: 50%;
                top: -21px;
                right: -36px;
                z-index: -1;
            }

            .common-section .code-cforma::after {
                width: 90px;
                height: 90px;
                background: #51c7a6;
                opacity: 0.6;
                content: '';
                position: absolute;
                border-radius: 50%;
                top: 100%;
                left: -36px;
                z-index: -1;
                margin-top: -50px;
            }

            /*.common-section .code-cforma .form-group{
            padding-left:0.5em;
            padding-right:0.5em;
       }*/
            .common-section .code-cforma .form-group label {
                color: #1c1c1c;
                font-weight: 500;
                margin-bottom: 0;
                font-size: 14px;
            }

            .common-section .code-cforma .form-group .form-control {
                border-radius: 30px;
                height: 35px;
                border: 1px solid #e1e1e1;
            }

                .common-section .code-cforma .form-group .form-control:focus {
                    color: #495057;
                    background-color: #fff;
                    border-color: #a0d5c6;
                    outline: 0;
                    box-shadow: 0 0 0 0.2rem rgb(12, 158, 118, 0.2);
                }

            .common-section .code-cforma .form-group textarea {
                height: auto !important;
                border-radius: 10px !important;
            }

            .common-section .code-cforma .submit-btn {
                background: rgb(243,101,36);
                background: linear-gradient(90deg, rgba(243,101,36,1) 14%, rgba(245,144,109,1) 77%);
                color: #FFF;
                border: none;
                border-radius: 30px;
                padding: 0.5em 3em;
                text-transform: uppercase;
                font-weight: 500;
                letter-spacing: 0.5px;
            }

        .common-section .footer-srtip {
            width: 100%;
            display: block;
            border-radius: 3px;
            position: relative;
            border: 2px solid #f36625;
            /*overflow:hidden;*/
            margin-top: 5em;
            background: #FFF;
            box-shadow: 0px 3px 10px rgba(0,0,0,0.3);
        }

            .common-section .footer-srtip::after {
                position: absolute;
                top: 0;
                right: 70px;
                height: 100px;
                width: 100px;
                border-radius: 20px;
                content: '';
                background: #c5eae0;
                z-index: -1;
                opacity: 0.5;
                -ms-transform: rotate(45deg);
                -o-transform: rotate(45deg);
                -moz-transform: rotate(45deg);
                -webkit-transform: rotate(45deg);
                transform: rotate(45deg);
            }

            .common-section .footer-srtip::before {
                position: absolute;
                bottom: 0;
                right: -56px;
                height: 200px;
                width: 200px;
                border-radius: 20px;
                content: '';
                background: #51c7a6;
                opacity: 0.6;
                z-index: -1;
                -ms-transform: rotate(45deg);
                -o-transform: rotate(45deg);
                -moz-transform: rotate(45deg);
                -webkit-transform: rotate(45deg);
                transform: rotate(45deg);
            }

            .common-section .footer-srtip .social-call {
                position: relative;
                padding: 0.7em 1em;
                display: flex;
                /*align-items: center;
            justify-content: center;*/
            }

                .common-section .footer-srtip .social-call .social-icon {
                    display: flex;
                    width: 100%;
                    align-items: center
                }

                    .common-section .footer-srtip .social-call .social-icon span {
                        font-weight: 600;
                    }

                    .common-section .footer-srtip .social-call .social-icon ul {
                        list-style-type: none;
                        margin-bottom: 0;
                        padding-left: 10px;
                    }

                        .common-section .footer-srtip .social-call .social-icon ul li {
                            display: inline-block;
                        }

                            .common-section .footer-srtip .social-call .social-icon ul li a {
                                display: inline-block;
                                width: 33px;
                                height: 33px;
                                background: #000;
                                font-size: 22px;
                                text-align: center;
                                border-radius: 50%;
                                line-height: 33px;
                            }

                                .common-section .footer-srtip .social-call .social-icon ul li a.facebook-icon {
                                    background: #218ae4;
                                    color: #FFF;
                                }

                                .common-section .footer-srtip .social-call .social-icon ul li a.twitter-icon {
                                    background: #54a9b1;
                                    color: #FFF;
                                }

                                .common-section .footer-srtip .social-call .social-icon ul li a.linkedin-icon {
                                    background: #54a9b1;
                                    color: #FFF;
                                }

                                .common-section .footer-srtip .social-call .social-icon ul li a.whatsapp-icon {
                                    background: green;
                                    color: #FFF;
                                }

                .common-section .footer-srtip .social-call .weblinks {
                    position: relative;
                    display: flex;
                    border: 2px solid #FFF;
                    padding: 0;
                    border-radius: 3px;
                    align-items: center;
                    min-height: 45px;
                    -ms-transition: all 0.5s ease-in;
                    -moz-transition: all 0.5s ease-in;
                    -webkit-transition: all 0.5s ease-in;
                    -o-transition: all 0.5s ease-in;
                    transition: all 0.5s ease-in;
                }

                    .common-section .footer-srtip .social-call .weblinks i {
                        font-size: 26px;
                        color: #f36828
                    }

                    .common-section .footer-srtip .social-call .weblinks a {
                        position: relative;
                        padding-left: 0.2em;
                        display: block;
                        font-size: 14px;
                        font-weight: 600;
                        color: #0c9e76;
                        line-height: 35px;
                        line-height: 1.1;
                    }

                        .common-section .footer-srtip .social-call .weblinks a i {
                            position: absolute;
                            left: 0;
                            top: 0px;
                            font-size: 26px;
                            font-weight: normal;
                        }

                        .common-section .footer-srtip .social-call .weblinks a:hover {
                            color: rgb(243,101,36);
                        }

        .common-section .product-sec {
            margin-top: 2.5em;
        }

        .common-section .owel-fharma {
            position: relative;
        }

            .common-section .owel-fharma .fharma-boxb {
                background: #FFF;
                border-radius: 5px;
                height: 100%;
                width: 100%;
                padding: 6px;
                margin-bottom: 15px;
                box-shadow: 0px 2px 6px rgba(0,0,0,0.2);
            }

            .common-section .owel-fharma .balaji-boxs {
                background: #b39d9d;
                overflow: hidden;
                border-radius: 6px;
                display: block;
            }

                .common-section .owel-fharma .balaji-boxs img {
                    display: block;
                    max-width: 100%;
                    border-radius: 6px;
                    height: 138px;
                    width: 100%;
                }

        .owl-carousel .owl-dots.disabled, .owl-carousel .owl-nav.disabled {
            display: block;
        }

        .owl-carousel .owl-nav {
            text-align: center
        }

            .owl-carousel .owl-nav button.owl-next, .owl-carousel .owl-nav button.owl-prev {
                background: #FFF;
                font-size: 30px;
                box-shadow: 0px 2px 6px rgba(0,0,0,0.2);
                border-radius: 4px;
                position: relative;
                width: 50px;
                background: #FFF;
                height: 43px;
                font-size: 30px;
                outline: none;
                text-align: center;
                transition: all 0.5s ease;
            }

            .owl-carousel .owl-nav button.owl-next {
                margin-left: 10px
            }

                .owl-carousel .owl-nav button.owl-next:hover, .owl-carousel .owl-nav button.owl-prev:hover {
                    background: rgb(243,101,36);
                    background: linear-gradient(90deg, rgba(243,101,36,1) 14%, rgba(245,144,109,1) 77%);
                    transition: all 0.5s ease;
                    color: #FFF;
                }

        .prduct-title {
            width: 100%;
        }

            .prduct-title h4 {
                font-weight: 500;
                color: #FFF;
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
        /*.footer-bot{
            position:absolute;
            bottom: 0;
            height: 50px;
             width: 100%;
            left: 0;
        }*/
        .footer-bot {
            position: relative;
            display: flex;
            align-items: center;
            margin-top: 25px;
            justify-content: space-between;
        }

            .footer-bot a {
                color: #d4eeff;
            }

            .footer-bot .socialicon ul {
                display: block;
                list-style-type: none;
                text-align: right;
                margin: 0;
                padding: 0;
            }

                .footer-bot .socialicon ul li {
                    display: inline-block
                }

                    .footer-bot .socialicon ul li a {
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

                        .footer-bot .socialicon ul li a.facebook {
                            background: #0f6ed5;
                            color: #FFF;
                        }

                        .footer-bot .socialicon ul li a.instagram {
                            background: rgb(68,56,131);
                            background: linear-gradient(180deg, rgba(68,56,131,1) 0%, rgba(235,49,54,1) 100%, rgba(255,234,196,1) 100%);
                        }

                        .footer-bot .socialicon ul li a.ytube {
                            background: #ed3439;
                            color: #FFF;
                        }

                        .footer-bot .socialicon ul li a:hover.facebook {
                            background: #FFF;
                            color: #0088cc;
                        }

                        .footer-bot .socialicon ul li a:hover.instagram {
                            background: #FFF;
                            color: #e25b5b
                        }

                        .footer-bot .socialicon ul li a:hover.ytube {
                            background: #FFF;
                            color: rgba(235,49,54,1);
                        }

        @media(max-width: 767px) {

            .common-section .product-sec {
                margin-top: 0
            }

            .common-section .hedding h3 {
                font-size: 1.8em;
                text-align: center
            }
        }

        @media(max-width: 768px) {
            .common-section {
                overflow: hidden
            }

            .header-topstrip {
                padding: 5px 0;
                z-index: 2;
                position: relative;
                background: #FFF;
                border-bottom: 1px solid #dfdfdf;
            }

            .common-section .code-cforma {
                margin-top: 0;
            }

            .prduct-title {
                background: #f36524;
                padding: 5px 10px;
                border-radius: 30px;
                margin-bottom: 15px;
            }

                .prduct-title h4 {
                    margin-bottom: 0;
                    font-size: 1.2rem;
                }

                .prduct-title h2 {
                    margin-bottom: 0;
                }

            .common-section .owel-fharma .balaji-boxs img {
                height: 250px;
                width: 100%;
            }

            .common-section .curvebg {
                position: fixed;
                top: 0;
                width: 250%;
                height: 100%;
            }

            .common-section .footer-srtip {
                margin-top: 15px;
            }

                .common-section .footer-srtip .social-call {
                    display: grid !important;
                    padding: 1em;
                }

            .common-section .hedding h1 {
                margin-bottom: 1rem;
                font-size: 1.1rem;
                text-transform: uppercase;
                font-weight: 700;
                letter-spacing: 1px;
                text-align: center;
            }

                .common-section .hedding h1 span {
                    display: block;
                    font-size: 1.5rem;
                }
        }

        @media(max-width: 640px) {
            .common-section .hedding h3 {
                font-size: 1em;
                text-align: center;
            }
        }

        @media(max-width: 480px) {
            .header-topstrip .fharma-brand-text h1 {
                line-height: 1.1;
                font-size: 25px;
                margin-bottom: 0;
            }

            .common-section {
                padding: 2em 0;
            }

                .common-section .owel-fharma .fharma-boxb {
                    padding: 4px;
                }


                .common-section .product-sec {
                    margin-top: 0;
                }

                .common-section .hedding h1 {
                    margin-bottom: 1rem;
                    font-size: 11px;
                    text-align: center;
                }

                    .common-section .hedding h1 span {
                        display: block;
                        font-size: 21px;
                        letter-spacing: 5px;
                    }

                .common-section .hedding h3 {
                    font-size: 0.7em;
                    letter-spacing: normal;
                    font-weight: 600;
                    border-radius: 20px;
                    border: 1px dashed #0c9e76;
                }

            .prduct-title h2 {
                text-transform: uppercase;
                font-weight: 600;
                color: #FFF;
                margin: 0;
                font-size: 22px;
            }
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

        <!---=====start-of-wrapper-box============-->
        <div class="wrapper-box wrapper-bg">
            <div class="header-topstrip" id="dynamic">
                <div class="container max-container">
                    <div class="row align-items-center justify-content-center">
                        <!--<div class="col-md-3">
                        <div class="balaji-brand"><img src="assets/images/balaji/logo-balaji.jpg" alt="logo-balaji" /></div>
                    </div>-->
                        <div class="col-md-12 text-center">
                            <div class="fharma-brand-text animated pulse">
                                <h1>PHARMACEUTICALS <span>& LABORATORY</span></h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--end-of-head-top-->
            <section class="position-relative common-section">
                <div class="container position_index max-container">
                    <div class="row align-items-center justify-content-center hedding">
                        <div class="col-md-12">
                            <h1 class="animated animated fadeInUp d-lg-none d-sm-block"><span>Welcome to</span>
                                A TO Z PHARMACEUTICALS &amp; LABORATORIES</h1>
                        </div>
                        <div class="col-md-4 order-sm-2 order-lg-2 animated fadeInUp mb-4">

                            <div class="code-cforma">

                                <div class="img_tophed">
                                    <img src="assets/images/fharmaceuticals/fharma-graphics.jpg" class="img-fluid" />

                                    <div class="row no-gutters pl-4 pr-4 pt-3">
                                        <div class="col-md-12">
                                            <h3>A to Z Pharmaceuticals & Laboratories</h3>
                                            <h4 id="chkLine">To check the authenticity of the product you have purchased - Fill in the below details:</h4>
                                        </div>

                                        <div class="col-md-12" id="ChkCode">
                                            <div class="form-group">
                                                <label>Enter 13 Digit Code<em>*</em></label>
                                                <input type="text" id="codeone" data-msg-required="Please enter your name." maxlength="50" class="form-control input1" />
                                            </div>
                                        </div>
                                        <div class="col-md-12" style="display: none;" id="Chkfields">
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label>Name<em>*</em></label>
                                                    <input type="text" id="Name" placeholder="Name" data-msg-required="Please Enter Your Name." maxlength="50" class="form-control" required="" />
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label>Mobile number<em>*</em></label>
                                                    <input type="text" id="mobilenumber" maxlength="10" placeholder="Mobile Number" data-msg-required="Please Enter Your Moblie Number" class="form-control" required="" />
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label>Address<em>*</em></label>
                                                    <input type="text" id="Address" placeholder="Address" data-msg-required="Please Enter Your Address." class="form-control" required="" />
                                                </div>
                                            </div>

                                            <div class="col-md-12 text-right">
                                                <div class="form-group">
                                                    <input class="btn btn-danger submit-btn" value="Submit" type="button" id="btnsubmit" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>



                                    <div style="display: none;" id="ShowMessage" class="row no-gutters pl-4 pr-4 textmessage">

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <p id="p3msg" style="color: black !important; overflow: hidden; font-size: 14px !important;" class="displayNone"></p>
                                            </div>
                                            <a href="javascript:void(0)" class="next_btn" id="btnNext">Close</a>
                                        </div>


                                    </div>
                                </div>

                            </div>


                        </div>
                        <div class="col-md-8 order-sm-1 order-lg-1">
                            <h1 class="animated animated fadeInUp d-none d-lg-block d-sm-none">Welcome to
                                A TO Z PHARMACEUTICALS & LABORATORIES</h1>

                            <div class="product-sec animated fadeInUp">
                                <div class="prduct-title">
                                    <h4>Our Products</h4>
                                </div>
                                <div class="owel-fharma owl-carousel">
                                    <div class="item">
                                        <div class="fharma-boxb">
                                            <div class="balaji-boxs">
                                                <img class="img-fluid mx-auto d-block" src="assets/images/fharmaceuticals/product1.jpg" alt="product1.jpg" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="fharma-boxb">
                                            <div class="balaji-boxs">
                                                <img class="img-fluid mx-auto d-block" src="assets/images/fharmaceuticals/product2.jpg" alt="product2" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="fharma-boxb">
                                            <div class="balaji-boxs">
                                                <img class="img-fluid mx-auto d-block" src="assets/images/fharmaceuticals/product3.jpg" alt="product3" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="fharma-boxb">
                                            <div class="balaji-boxs">
                                                <img class="img-fluid mx-auto d-block" src="assets/images/fharmaceuticals/product4.jpg" alt="product4" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="fharma-boxb">
                                            <div class="balaji-boxs">
                                                <img class="img-fluid mx-auto d-block" src="assets/images/fharmaceuticals/product5.jpg" alt="product5" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="fharma-boxb">
                                            <div class="balaji-boxs">
                                                <img class="img-fluid mx-auto d-block" src="assets/images/fharmaceuticals/product6.jpg" alt="product6" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="fharma-boxb">
                                            <div class="balaji-boxs">
                                                <img class="img-fluid mx-auto d-block" src="assets/images/fharmaceuticals/product7.jpg" alt="product7" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>
                    <!--end-of-row-->


                    <div class="row">

                        <div class="col-md-12">
                            <div class="footer-srtip">
                                <div class="social-call">
                                    <!--<div class="social-icon">
                                    <span>Follow Us at:</span>
                                    <ul>
                                        <li><a href="https://www.facebook.com/shribalajibooks/" class="facebook-icon" target="_blank"><i class="mdi mdi-facebook"></i></a></li>
                                        <li><a href="javascript:void(0)" class="twitter-icon" target="_blank"> <i class="mdi mdi-twitter"></i></a></li>
                                        <li><a href="https://api.whatsapp.com/send/?phone=917302224004&text&app_absent=0" class="whatsapp-icon" target="_blank"><i class="mdi mdi-whatsapp"></i></a></li>
                                    </ul>
                                 </div>-->
                                    <div class="weblinks">
                                        <i class="mdi mdi-earth"></i><a href="https://www.indiamart.com/a-to-z-pharmaceutical-company-laboratory/profile.html" target="_blank">https://www.indiamart.com/a-to-z-pharmaceutical-company-laboratory/profile.html</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <!--end-of-row-->

                </div>
                <div class="curvebg">

                    <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                        width="100%" height="100%" preserveAspectRatio="none" viewBox="0 0 1880 965" enable-background="new 0 0 1880 965" xml:space="preserve">
                        <path fill="#069E76" d="M0,0h1880v89.973c0,0-143.697,548.594-552.925,446.123c-117.567-27.027-292.075-33.664-432.934,93.151
	c0,0-191.811,157.751-437.022,139.337C285,758,99.215,768.001,0,965V0z" />
                        <image display="none" overflow="visible" width="1903" height="1085" xlink:href="7444ED99.jpg" transform="matrix(0.9999 0 0 0.9999 0 0)">
                        </image>
                    </svg>
                </div>
                <div class="shapes fadeInUp"></div>
            </section>
        </div>
        <!---=====end-of-wrapper-box============-->


    </form>
    <script src="../vendor/jquery.appear/jquery.appear.min.js"></script>
    <script src="../vendor/jquery.easing/jquery.easing.min.js"></script>
    <script src="../vendor/jquery-cookie/jquery-cookie.min.js"></script>
    <script src="../vendor/popper/umd/popper.min.js"></script>
    <script src="../vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="../vendor/common/common.min.js"></script>

    <script src="../vendor/owl.carousel/owl.carousel.min.js"></script>
    <script src="../vendor/magnific-popup/jquery.magnific-popup.min.js"></script>
    <script src="../vendor/vide/vide.min.js"></script>
    <script>

        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }

        $(document).ready(function () {
            $('.owel-fharma').owlCarousel({
                loop: true,
                margin: 8,
                items: 2,
                responsiveClass: true,
                nav: true,
                paginationNumbers: true,
                slideSpeed: true,
                navigation: true,
                autoplay: true,
                responsive: {
                    0: {
                        items: 2
                    },
                    600: {
                        items: 2
                    },
                    960: {
                        items: 4
                    },
                    1200: {
                        items: 6
                    }
                }
            });


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

            else if (id == "fharmaceticals") {
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
                                        $('#Patanjali').hide();
                                        /*$('#chkGun').hide();*/
                                        $('#step2').hide();
                                        $('#Coatsbathfitting').hide();
                                        $('#nutravel').hide();
                                        $('#evercrop').hide();
                                        $('#supriya').hide();
                                        $('#everproducts').hide();
                                        $('#nutravelproduct').hide();
                                        $('#amulyaproduct').hide();
                                        $('#balckmangoproduct').hide()
                                        $('#skydecore').hide();
                                        $('#warrentyauto').show();
                                        $('#warratyHeading').show();
                                        $('#checkcode').show();
                                        $('#checkcode2').hide();
                                        $('#divCompany').hide();
                                        $('#jphcounter').hide();
                                        $('#jphcounter').hide();
                                        $('#jphcounter').hide();
                                        $('#jph').hide();
                                        $('#msg').html(data.split('&')[3].toString());

                                        $('#warrantyMsg').text("welcome to " + data.split('&')[1]);
                                        $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
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






                if (validate) {
                    $('#p3msg').html('');


                    if (code != "") {
                        $.ajax({
                            type: "POST",
                            contentType: false,
                            processData: false,

                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&Address=' + $('#Address').val() + '&name=' + $('#Name').val() + '&comp=' + $('#CompName').val(),
                            success: function (data) {
                                debugger;
                                if (data.split('~')[0] !== "failure") {
                                    window.scrollTo(0, 0);
                                    $('#head').hide();
                                    $('#Chkfields').hide();
                                    $('#ShowMessage').show();
                                    $('#chkLine').hide();
                                    $('#p3msg').html(data.split('~')[1]);

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

