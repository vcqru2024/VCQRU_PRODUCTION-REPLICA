<%@ Page Language="C#" AutoEventWireup="true" CodeFile="balaji.aspx.cs" Inherits="balaji" %>

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


    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="Content/js/jquery-1.11.1.min.js"></script>
    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>

    <style>
        body {
            background: #FFF url(../assets/images/balaji/bg-material.png);
            font-family: 'Poppins', sans-serif;
        }

        @import url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,200;1,300;1,400;1,500;1,600&display=swap');

        .h3, h3 {
            font-size: 1.0rem;
        }

        .mainsection {
            width: 100%;
            height: 100%;
            position: relative;
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

        .max-container {
            max-width: 1200px;
        }

        .position_index {
            position: relative;
            z-index: 2;
        }

        .mainsection .curvebg {
            position: absolute;
            top: 0;
            width: 100%;
            height: 100%;
        }

            .mainsection .curvebg svg {
                height: 100%;
                width: 100%;
            }

                .mainsection .curvebg svg path {
                    fill: #FFF;
                }

        .mainsection .head-top {
            /*border-bottom:1px solid #eaeaea;
           background:#FFF;*/
            padding: 5px 0;
            z-index: 2;
            position: relative;
        }

        #dynamic {
            margin: 0px auto;
        }

        .newClass {
            border: none;
            background-color: orange;
        }

        .mainsection .head-top .balaji-brand {
            max-width: 250px;
        }

        .mainsection .head-top .balaji-brand-text h1 {
            color: #f36828;
            font-weight: 700;
        }

            .mainsection .head-top .balaji-brand-text h1 span {
                color: #4f9d9b;
            }

        .mainsection .head-top .balaji-brand img {
            max-width: 100%;
            display: block;
        }

        .mainsection .hedding h3 {
            font-size: 1rem !important;
        }

        .mainsection .textblow, .mainsection .textmessage {
            width: 100%;
        }

        .mainsection .textmessage {
            background: #72cf97;
            border-radius: 10px;
            padding: 10px 15px;
            margin-bottom: 15px;
            border: 1px dashed #fff;
        }

            .mainsection .textmessage p {
                margin-bottom: 15px !important;
                color: #072c2e;
                overflow: hidden;
                margin-bottom: 0;
                text-align: center;
                font-size: 13px;
                font-weight: 600;
            }

        .mainsection .codecheck-form {
            background: rgb(80,158,155);
            background: linear-gradient(90deg, rgba(80,158,155,1) 14%, rgba(40,134,146,1) 77%);
            padding: 1.5em 1.5em;
            border-radius: 10px;
            position: relative;
        }

            .mainsection .codecheck-form::after {
                width: 100px;
                height: 100px;
                background: #f1d7cd;
                content: '';
                position: absolute;
                border-radius: 50%;
                top: 15px;
                left: -50px;
                z-index: -1;
            }

            .mainsection .codecheck-form::before {
                position: absolute;
                left: -176px;
                top: 107px;
                width: 290px;
                display: block;
                height: 100%;
                content: '';
                background: url(../assets/images/balaji/addvertisement.png);
                background-repeat: no-repeat;
                background-size: contain;
            }

            .mainsection .codecheck-form .form-group {
                padding-left: 0.5em;
                padding-right: 0.5em;
            }

                .mainsection .codecheck-form .form-group label {
                    color: #FFF;
                    font-weight: 400;
                    margin-bottom: 0;
                    font-size: 16px;
                }

                .mainsection .codecheck-form .form-group .form-control {
                    border-radius: 30px;
                    height: 35px;
                    border: none;
                }

                .mainsection .codecheck-form .form-group textarea {
                    height: auto !important;
                    border-radius: 10px !important;
                }

            .mainsection .codecheck-form .submit-btn {
                background: rgb(243,101,36);
                background: linear-gradient(90deg, rgba(243,101,36,1) 14%, rgba(245,144,109,1) 77%);
                color: #FFF;
                border: none;
                border-radius: 30px;
                padding: 0.5em 3em;
                text-transform: uppercase;
                font-weight: 500;
                letter-spacing: 0.5px;
                box-shadow: 0 0 0 0.2rem #dc354580;
            }

        .mainsection .col-bleder {
            width: 100%;
            display: block;
            border-radius: 10px;
            position: relative;
            /*overflow:hidden;*/
            margin-top: 50px;
            background: rgb(243,101,36);
            background: linear-gradient(90deg, rgba(243,101,36,1) 14%, rgba(245,144,109,1) 77%);
        }

            .mainsection .col-bleder::before {
                width: 100px;
                height: 100px;
                background: #d9eeef;
                content: '';
                position: absolute;
                border-radius: 50%;
                top: -52px;
                left: 28px;
                z-index: -1;
            }

            .mainsection .col-bleder::after {
                position: absolute;
                bottom: 0;
                left: 0;
                height: 50%;
                width: 100%;
                border-bottom-left-radius: 10px;
                border-bottom-right-radius: 10px;
                content: '';
                background: rgb(54,142,149);
                background: linear-gradient(0deg, rgba(54,142,149,1) 14%, rgba(12,80,80,1) 77%);
            }

            .mainsection .col-bleder .collage-boy {
                max-width: 282px;
                margin: 0 auto;
                position: relative;
                z-index: 1;
            }

                .mainsection .col-bleder .collage-boy:before {
                    position: absolute;
                    top: 0;
                    left: 0;
                    height: 180px;
                    width: 180px;
                    border-radius: 50%;
                    z-index: -1;
                    content: '';
                    background: #ceebfb;
                    margin-top: -10px;
                    left: 50%;
                    transform: translateX(-50%);
                }

                .mainsection .col-bleder .collage-boy img {
                    max-width: 100%;
                    display: block;
                }

            .mainsection .col-bleder .social-call {
                position: relative;
                padding: 1.5em 1em;
            }

                .mainsection .col-bleder .social-call .social-icon {
                    display: flex;
                    width: 100%;
                    border: 2px solid #00b1b1;
                    background: #FFF;
                    padding: 5px 10px;
                    border-radius: 3px;
                    align-items: center
                }

                    .mainsection .col-bleder .social-call .social-icon span {
                        font-weight: 600;
                    }

                    .mainsection .col-bleder .social-call .social-icon ul {
                        list-style-type: none;
                        margin-bottom: 0;
                        padding-left: 10px;
                    }

                        .mainsection .col-bleder .social-call .social-icon ul li {
                            display: inline-block;
                        }

                            .mainsection .col-bleder .social-call .social-icon ul li a {
                                display: inline-block;
                                width: 33px;
                                height: 33px;
                                background: #000;
                                font-size: 22px;
                                text-align: center;
                                border-radius: 50%;
                                line-height: 33px;
                            }

                                .mainsection .col-bleder .social-call .social-icon ul li a.facebook-icon {
                                    background: #218ae4;
                                    color: #FFF;
                                }

                                .mainsection .col-bleder .social-call .social-icon ul li a.twitter-icon {
                                    background: #54a9b1;
                                    color: #FFF;
                                }

                                .mainsection .col-bleder .social-call .social-icon ul li a.linkedin-icon {
                                    background: #54a9b1;
                                    color: #FFF;
                                }

                                .mainsection .col-bleder .social-call .social-icon ul li a.whatsapp-icon {
                                    background: green;
                                    color: #FFF;
                                }

                .mainsection .col-bleder .social-call .weblinks {
                    position: relative;
                    display: flex;
                    width: 100%;
                    border: 2px solid #FFF;
                    padding: 5px 10px;
                    border-radius: 3px;
                    align-items: center;
                    min-height: 45px;
                    margin-top: 10px;
                    -ms-transition: all 0.5s ease-in;
                    moz-transition: all 0.5s ease-in;
                    -webkit-transition: all 0.5s ease-in;
                    -o-transition: all 0.5s ease-in;
                    transition: all 0.5s ease-in;
                }

                    .mainsection .col-bleder .social-call .weblinks a {
                        position: relative;
                        padding-left: 2em;
                        display: block;
                        font-size: 14px;
                        color: #FFF;
                        line-height: 35px;
                    }

                        .mainsection .col-bleder .social-call .weblinks a i {
                            position: absolute;
                            left: 0;
                            top: 0px;
                            font-size: 26px;
                            font-weight: normal;
                        }

                    .mainsection .col-bleder .social-call .weblinks:hover {
                        background: rgb(80,158,155);
                        background: linear-gradient(90deg, rgba(80,158,155,1) 14%, rgba(40,134,146,1) 77%);
                        -ms-transition: all 0.5s ease-in;
                        moz-transition: all 0.5s ease-in;
                        -webkit-transition: all 0.5s ease-in;
                        -o-transition: all 0.5s ease-in;
                        transition: all 0.5s ease-in;
                    }

        .mainsection .owl-balaji {
            position: relative;
        }

            .mainsection .owl-balaji .balaji-boxb {
                background: #FFF;
                border-radius: 10px;
                height: 100%;
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                box-shadow: 0px 2px 6px rgba(0,0,0,0.2);
            }

            .mainsection .owl-balaji .balaji-boxs {
                background: #b39d9d;
                overflow: hidden;
                border-radius: 6px;
                display: block;
            }

                .mainsection .owl-balaji .balaji-boxs img {
                    display: block;
                    max-width: 100%;
                    border-radius: 6px;
                    height: 280px;
                    width: 100%;
                }

        .owl-carousel .owl-dots.disabled, .owl-carousel .owl-nav.disabled {
            display: block;
        }

        .owl-carousel .owl-prev {
            left: 2px;
        }

        .owl-carousel .owl-next {
            right: 2px;
        }

        .owl-carousel .owl-nav button.owl-next, .owl-carousel .owl-nav button.owl-prev {
            background: #FFF;
            font-size: 30px;
            box-shadow: 0px 2px 6px rgba(0,0,0,0.2);
            border-radius: 4px;
            transform: translateY(-50%);
            top: 50%;
            position: absolute;
            width: 50px;
            background: #FFF;
            height: 43px;
            font-size: 30px;
            line-height: 40px;
            outline: none;
            transition: all 0.5s ease;
        }

            .owl-carousel:hover .owl-nav button.owl-next:hover, .owl-carousel .owl-nav button.owl-prev:hover {
                background: rgb(80,158,155);
                background: linear-gradient(90deg, rgba(80,158,155,1) 14%, rgba(40,134,146,1) 77%);
                transition: all 0.5s ease;
                color: #FFF;
            }

        .owl-carousel .owl-nav {
            opacity: 0;
            visibility: hidden;
        }

        .owl-carousel:hover .owl-nav {
            opacity: 1;
            visibility: visible;
        }

        .prduct-title {
            width: 100%;
        }

            .prduct-title h2 {
                text-transform: uppercase;
                font-weight: 600;
                color: #FFF;
            }

        ::-webkit-input-placeholder {
            color: #FFF;
            font-size: 14px;
            font-weight: 500;
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


        @media(max-width: 1366px) {
            .mainsection .codecheck-form, .mainsection .textblow, .mainsection .textmessage {
                width: calc(100% - 136px);
                margin-left: 136px;
            }

                .mainsection .codecheck-form::before {
                    left: -172px;
                }
        }

        @media(max-width: 768px) {
            .mainsection {
                overflow: hidden
            }

                .mainsection .head-top {
                    padding: 5px 0;
                    z-index: 2;
                    position: relative;
                    background: #FFF;
                    border-bottom: 1px solid #dfdfdf;
                }

                .mainsection .codecheck-form, .mainsection .textblow, .mainsection .textmessage {
                    width: 100%;
                    margin-left: 0;
                }

                    .mainsection .textblow p, .mainsection .textmessage p {
                        font-weight: 600;
                    }

                .mainsection .codecheck-form {
                    margin-top: 10px;
                }

                    .mainsection .codecheck-form::before {
                        position: absolute;
                        left: -24px;
                        top: -4px;
                        bottom: 100%;
                        width: 372px;
                        display: block;
                        height: 209px;
                        content: '';
                        background: url(../assets/images/balaji/addvertisement.png);
                        background-repeat: no-repeat;
                        background-size: contain;
                        transform: rotate(90deg);
                        display: none;
                    }

                .mainsection .curvebg {
                    position: absolute;
                    top: 0;
                    width: 200%;
                    height: auto;
                }

                .mainsection .col-bleder {
                    background: rgb(249 168 131);
                    background: linear-gradient(90deg, rgb(76 155 154) 14%, rgb(249 168 131) 77%);
                }

                .mainsection .codecheck-form {
                    width: 100%;
                    margin-left: 0;
                }

                .mainsection .head-top .balaji-brand-text h1 {
                    color: #f36828;
                    font-weight: 700;
                    line-height: 1.1;
                    margin-top: 10px;
                }
        }

        @media(max-width: 480px) {
            .mainsection .owl-balaji .balaji-boxb {
                padding: 4px;
            }

            .mainsection .owl-balaji .balaji-boxs img {
                height: 185px;
            }

            .prduct-title h2 {
                text-transform: uppercase;
                font-weight: 600;
                color: #FFF;
                margin: 0;
                font-size: 22px;
            }

            .mainsection .codecheck-form {
                padding: 1.5em 0.5em;
            }

            .mainsection .col-bleder::before {
                background: rgba(228, 254, 255, 0.2);
            }
        }
    </style>

</head>
<body>


    <form id="form1" runat="server">

        <asp:HiddenField ID="hdnmob" runat="server" />
        <asp:HiddenField ID="HdnID" runat="server" />
        <asp:HiddenField ID="codeone" runat="server" />
        <asp:HiddenField ID="HdnCode1" runat="server" />
        <asp:HiddenField ID="HdnCode2" runat="server" />
        <asp:HiddenField ID="long" runat="server" />
        <asp:HiddenField ID="lat" runat="server" />

        <!---=====start-of-balaji Winow============-->
        <section class="position-relative mainsection hedding">
            <div class="head-top" id="dynamic">
                <div class="container max-container">
                    <div class="row align-items-center justify-content-center">
                        <div class="col-md-3">
                            <div class="balaji-brand">
                                <img src="assets/images/balaji/logo-balaji.jpg" alt="logo-balaji" />
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div class="balaji-brand-text">
                                <h1>SHRI BALAJI <span>PUBLICATIONS</span></h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--end-of-head-top-->

            <div class="container position_index max-container">
                <div class="row  pt-3 pb-3">
                    <div class="col-md-8">
                        <div id="head" class="textblow">
                            <p style="font-size: 16px; margin-bottom: 1% !important;">To check the Authenticity of the product you have purchased. Fill the below details (All fields are mandatory)</p>
                        </div>
                        <div style="display: none;" id="ShowMessage" class="textmessage">
                            <p id="p3msg" class="displayNone"></p>

                            <a href="javascript:void(0)" class="next_btn" id="btnNext">Close</a>
                        </div>
                        <div class="codecheck-form" id="BalajiFields">

                            <div class="row no-gutters">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Name<em>*</em></label>

                                        <input type="text" id="Name" placeholder="Name" data-msg-required="Please enter your name." maxlength="50" class="form-control" required="" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Mobile number<em>*</em></label>
                                        <input type="text" id="mobilenumber" maxlength="10" placeholder="Mobile Number" data-msg-required="Please enter your Moblie Number" class="form-control" required="" />
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Email Address<em>*</em></label>
                                        <input type="email" id="EmailAddrs" placeholder="Email Address" data-msg-required="Please enter your Email Address" class="form-control" required="" />
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Book name you have purchased<em>*</em></label>
                                        <input type="text" id="bookname" placeholder="Book name you have purchased" data-msg-required="Please enter Book name you have purchased" class="form-control" required="" />
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Book shop/center where you purchased<em>*</em></label>
                                        <input type="text" id="bookShop" placeholder="Book shop/center where you purchased" data-msg-required="Please enter Book shop/center where you purchased" class="form-control" required="" />
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Coaching center, you’re studying in<em>*</em></label>
                                        <input type="text" id="ccenter" placeholder="Coaching center, you’re studying in" data-msg-required="Coaching center, you’re studying in" class="form-control" required="" />
                                    </div>
                                </div>

                                <%--<div class="col-md-12">
                                    <div class="form-group">
                                        <label>Your Message<em>*</em></label>
                                        <textarea type="text" id="message" onkeyup="alphanumeric(this);" rows="5" cols="6" class="form-control"></textarea>
                                    </div>
                                </div>--%>
                                <div class="col-md-12 text-right">
                                    <div class="form-group">
                                        <input class="btn btn-danger submit-btn" id="btnbalaji" value="Submit" type="button" />
                                    </div>
                                </div>
                            </div>




                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="col-bleder">
                            <div class="social-call">
                                <div class="social-icon">
                                    <span>Follow Us at:</span>
                                    <ul>
                                        <li><a href="https://www.facebook.com/shribalajibooks/" class="facebook-icon" target="_blank"><i class="mdi mdi-facebook"></i></a></li>
                                        <%--<li><a href="" class="twitter-icon" target="_blank"><i class="mdi mdi-twitter"></i></a></li>--%>
                                        <li><a href="https://api.whatsapp.com/send/?phone=917302224004&text&app_absent=0" class="whatsapp-icon" target="_blank"><i class="mdi mdi-whatsapp"></i></a></li>
                                    </ul>
                                </div>
                                <div class="weblinks">
                                    <a href="https://shribalajibooks.com" target="_blank"><i class="mdi mdi-earth"></i>https://shribalajibooks.com</a>
                                </div>
                            </div>
                            <div class="collage-boy">
                                <img src="assets/images/balaji/collage-boy.png" alt="collage-boy" />
                            </div>
                        </div>
                    </div>
                </div>
                <!--end-of-row-->


                <div class="row">
                    <div class="col-lg-12">
                        <div class="text-center prduct-title">
                            <h2>Our Products</h2>
                        </div>
                        <div class="owl-balaji owl-carousel">
                            <div class="item">
                                <div class="balaji-boxb">
                                    <div class="balaji-boxs">
                                        <img class="img-fluid mx-auto d-block" src="assets/images/balaji/chemistry.jpg" alt="wire-cables" />
                                    </div>
                                </div>
                            </div>
                            <div class="item">
                                <div class="balaji-boxb">
                                    <div class="balaji-boxs">
                                        <img class="img-fluid mx-auto d-block" src="assets/images/balaji/inorgainic-chemistry.jpg" alt="inorgainic-chemistry" />
                                    </div>
                                </div>
                            </div>
                            <div class="item">
                                <div class="balaji-boxb">
                                    <div class="balaji-boxs">
                                        <img class="img-fluid mx-auto d-block" src="assets/images/balaji/organic-chemistry.jpg" alt="organic-chemistry" />
                                    </div>
                                </div>
                            </div>
                            <div class="item">
                                <div class="balaji-boxb">
                                    <div class="balaji-boxs">
                                        <img class="img-fluid mx-auto d-block" src="assets/images/balaji/organic-chemistry1.jpg" alt="organic-chemistry1" />
                                    </div>
                                </div>
                            </div>
                            <div class="item">
                                <div class="balaji-boxb">
                                    <div class="balaji-boxs">
                                        <img class="img-fluid mx-auto d-block" src="assets/images/balaji/physical-chemistry.jpg" alt="physical-chemistry" />
                                    </div>
                                </div>
                            </div>
                            <div class="item">
                                <div class="balaji-boxb">
                                    <div class="balaji-boxs">
                                        <img class="img-fluid mx-auto d-block" src="assets/images/balaji/physical-chemistry1.jpg" alt="physical-chemistry1" />
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>

                </div>
                <!--end-of-row-->

            </div>
            <div class="curvebg">
                <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                    width="100%" height="100%" preserveAspectRatio="none" viewBox="0 0 1880 1200" enable-background="new 0 0 1880 1200" xml:space="preserve">
                    <path fill="#F26928" d="M0,1200c0,0,126.737-491.809,1011.826-600c657.066-63.187,788.254-437.742,868.175-600H0V1200z" />
                </svg>
                <!--<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                width="100%" height="100%" viewBox="0 0 1880 1200"  preserveAspectRatio="none" enable-background="new 0 0 1880 1200" xml:space="preserve">
                <path fill="#F26928" d="M0,1200c0,0,126.737-491.809,1011.826-600c657.066-63.187,788.254-437.742,868.175-600v1200H0z"/>-->
                </svg>
            </div>
        </section>
        <!---=====end-of-FB Winow============-->

        <!---=====start-of-Royal Winow============-->

        <!---=====end-of-Royal Winow============-->
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

            $('.owl-balaji').owlCarousel({
                responsiveClass: true,
                nav: true,
                loop: true,
                margin: 10,
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
                        items: 5
                    }
                }
            });

            firstfunction();

            var compInformation = $('#HdnID').val();
            if (compInformation == "shribalaji") {

                compInformation = "SHRI BALAJI PUBLICATIONS";
            }

            $('#btnbalaji').on('click', function () {
                $('#btnbalaji').attr('disabled', true);

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
                                $('#btnbalaji').attr('disabled', false);
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
                }

                var bookname = $('#bookname').val();
                if (bookname != undefined) {


                    if ($('#bookname').val().length < 1) {
                        toastr.error('Please Enter Book Name');
                        validate = false;
                    }
                    var matches = $('#bookname').val().match(/\d+/g);
                    if (matches != null) {
                        toastr.error('Book Name Should be alphabet only!');
                        validate = false;
                    }
                }

                var bookShop = $('#bookShop').val();
                if (bookShop != undefined) {


                    if ($('#bookShop').val().length < 1) {
                        toastr.error('Please Enter Book Shop');
                        validate = false;
                    }
                    //var matches = $('#bookShop').val().match(/\d+/g);
                    //if (matches != null) {
                    //    toastr.error('Book Shop Should be alphabet only!');
                    //    validate = false;
                    //}
                }

                var ccenter = $('#ccenter').val();
                if (ccenter != undefined) {


                    if ($('#ccenter').val().length < 1) {
                        toastr.error('Please Enter Coaching Center Name');
                        validate = false;
                    }
                    //var matches = $('#bookShop').val().match(/\d+/g);
                    //if (matches != null) {
                    //    toastr.error('Book Shop Should be alphabet only!');
                    //    validate = false;
                    //}
                }


                var Email = $('#EmailAddrs').val();
                if (Email != undefined) {
                    var check = validateEmail(Email);

                    if (check != true) {
                        toastr.error('Please Enter valid Email Address!');
                        validate = false;
                    }
                }





                if (validate) {
                    $('#p3msg').html('');

                    var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                    $("#codeone").val(code);

                    if (code != "") {
                        $.ajax({
                            type: "POST",
                            contentType: false,
                            processData: false,

                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&bookname=' + $('#bookname').val() + '&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&bookShop=' + $('#bookShop').val() + '&ccenter=' + $('#ccenter').val() + '&name=' + $('#Name').val() + '&EmailAddrs=' + $('#EmailAddrs').val() + '&comp=' + compInformation,
                            success: function (data) {
                                debugger;
                                if (data.split('~')[0] !== "failure") {
                                    window.scrollTo(0, 0);
                                    $('#head').hide();
                                    $('#BalajiFields').hide();
                                    $('#ShowMessage').show();
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

                    $('#btnbalaji').attr('disabled', false);

                }

            });


            $('#btnNext').click(function () {
                window.location.href = '<%=ProjectSession.absoluteSiteBrowseUrl%>';
            });



        });


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


        function validateEmail(email) {
            var re = /\S+@\S+\.\S+/;
            return re.test(email);
        }

        function showPosition(position) {
            $('#lat').val(position.coords.latitude);
            $('#long').val(position.coords.longitude);
            //alert("long: " + $('#lat').val() + "lat: " + $('#long').val());
        }

        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }

        function isNumber(evt, cntrl_id) {
            /*debugger;*/
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if ($('#' + cntrl_id).val().length == 0) {

                if (parseInt(evt.key) > 6)
                    return true;

            }
            if ($('#' + cntrl_id).val().length > 10) {

                return false;

            }
            if (charCode >= 96 && charCode <= 105) {
                return true;
            }
            if (charCode >= 48 && charCode <= 57)
                return true;
            if (charCode == 8)
                return true;
            if (charCode == 46)
                return false;

            return false;
        }


    </script>

</body>
</html>
