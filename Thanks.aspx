<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Thanks.aspx.cs" Inherits="tahnks_you" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thank You</title>
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
        .wrapper-all {
            position: relative;
            display: block;
            height: 100%;
            width: 100%;
            overflow: hidden
        }

            .wrapper-all .main-bg {
                height: 100vh;
                width: 100%;
                position: relative;
                background: rgb(25,172,255);
                background: linear-gradient(45deg, rgba(25,172,255,1) 19%, rgba(2,91,167,1) 98%);
            }

                .wrapper-all .main-bg .reffect {
                    position: absolute;
                    position: absolute;
                    right: -100px;
                    top: -130px;
                    content: '';
                    width: 500px;
                    height: 500px;
                    background: #FFF;
                    border-radius: 50%;
                    opacity: 0.1;
                }

                .wrapper-all .main-bg::before {
                    position: absolute;
                    right: -126px;
                    top: -160px;
                    content: '';
                    width: 500px;
                    height: 500px;
                    background: #FFF;
                    border-radius: 50%;
                    opacity: 0.2;
                }

                .wrapper-all .main-bg::after {
                    position: absolute;
                    left: -126px;
                    bottom: -160px;
                    content: '';
                    width: 300px;
                    height: 300px;
                    background: #FFF;
                    border-radius: 50%;
                    opacity: 0.2;
                }

                .wrapper-all .main-bg .container-box {
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    transform: translate(-50%, -50%);
                    max-width: 900px;
                    z-index: 2;
                }

        .callback_btn {
            background: rgb(37 97 212);
            background: linear-gradient(90deg, rgb(17 23 30) 19%, rgb(5 5 53) 98%);
            border: none;
            padding: 0.8rem 2rem;
            font-weight: 600;
            color: rgb(255 255 255) !important;
            border-radius: 2px;
            font-size: 16px;
            transition: all 0.4s;
            -webkit-transition: all 0.4s;
        }

            .callback_btn:hover, .callback_btn:focus {
                background: rgb(229 166 114);
                background: linear-gradient(90deg, rgb(229 166 114) 19%, rgb(253 147 31) 98%);
                transform: translateY(-10px);
                transition: all 0.4s;
                -webkit-transition: all 0.4s;
                box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.2);
            }

        .container-box .imgCalled {
            max-width: 470px;
            margin: 0 auto;
        }

        .wrapper-all .main-bg .container-box h1, .wrapper-all .main-bg .container-box h4 {
            color: #FFF;
            text-align: center
        }

        .wrapper-all .main-bg .container-box h4 {
            font-size: 2rem;
            font-weight: 100;
            letter-spacing: 0.01rem;
        }

        .wrapper-all .main-bg .container-box h1 {
            font-size: 5rem;
            letter-spacing: 0.1rem;
        }

        .context {
            width: 100%;
            position: absolute;
            top: 50vh;
        }

            .context h1 {
                text-align: center;
                color: #fff;
                font-size: 50px;
            }


        .area {
            width: 100%;
            height: 100vh;
            position: absolute
        }

        .circles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            overflow: hidden;
            z-index: 1;
        }

            .circles li {
                position: absolute;
                display: block;
                list-style: none;
                width: 20px;
                height: 20px;
                background: rgba(255, 255, 255, 0.2);
                animation: animate 25s linear infinite;
                bottom: -150px;
            }

                .circles li:nth-child(1) {
                    left: 25%;
                    width: 80px;
                    height: 80px;
                    animation-delay: 0s;
                }


                .circles li:nth-child(2) {
                    left: 10%;
                    width: 20px;
                    height: 20px;
                    animation-delay: 2s;
                    animation-duration: 12s;
                }

                .circles li:nth-child(3) {
                    left: 70%;
                    width: 20px;
                    height: 20px;
                    animation-delay: 4s;
                }

                .circles li:nth-child(4) {
                    left: 40%;
                    width: 60px;
                    height: 60px;
                    animation-delay: 0s;
                    animation-duration: 18s;
                }

                .circles li:nth-child(5) {
                    left: 65%;
                    width: 20px;
                    height: 20px;
                    animation-delay: 0s;
                }

                .circles li:nth-child(6) {
                    left: 75%;
                    width: 110px;
                    height: 110px;
                    animation-delay: 3s;
                }

                .circles li:nth-child(7) {
                    left: 35%;
                    width: 150px;
                    height: 150px;
                    animation-delay: 7s;
                }

                .circles li:nth-child(8) {
                    left: 50%;
                    width: 25px;
                    height: 25px;
                    animation-delay: 15s;
                    animation-duration: 45s;
                }

                .circles li:nth-child(9) {
                    left: 20%;
                    width: 15px;
                    height: 15px;
                    animation-delay: 2s;
                    animation-duration: 35s;
                }

                .circles li:nth-child(10) {
                    left: 85%;
                    width: 150px;
                    height: 150px;
                    animation-delay: 0s;
                    animation-duration: 11s;
                }



        @keyframes animate {

            0% {
                transform: translateY(0) rotate(0deg);
                opacity: 1;
                border-radius: 0;
            }

            100% {
                transform: translateY(-1000px) rotate(720deg);
                opacity: 0;
                border-radius: 50%;
            }
        }


        @media(max-width:768px) {
            .wrapper-all {
                position: relative;
                display: block;
                height: 100%;
                width: 100%;
                overflow-x: hidden
            }

                .wrapper-all .main-bg {
                    background: rgba(142, 208, 255);
                    background: linear-gradient(150deg, #c3e4f7 20%, #3eafff 80%);
                    width: 100%;
                    padding: 2em 0;
                    overflow-x: hidden;
                }

                    .wrapper-all .main-bg .container-box {
                        position: relative;
                        top: 0;
                        left: 0;
                        transform: none;
                        max-width: 900px;
                        z-index: 2;
                    }

                        .wrapper-all .main-bg .container-box h1, .wrapper-all .main-bg .container-box h4 {
                            color: #060733;
                            text-align: center;
                        }

                        .wrapper-all .main-bg .container-box h1 {
                            font-size: 3rem;
                            letter-spacing: 0.1rem;
                        }

                    .wrapper-all .main-bg::after {
                        position: absolute;
                        left: -36px;
                        bottom: -25px;
                        content: '';
                        width: 100px;
                        height: 100px;
                        background: #FFF;
                        border-radius: 50%;
                        opacity: 0.2;
                    }

                    .wrapper-all .main-bg::before {
                        position: absolute;
                        right: -126px;
                        top: -160px;
                        content: '';
                        width: 300px;
                        height: 300px;
                        background: #0f6eb1;
                        border-radius: 50%;
                        opacity: 0.8;
                    }

                    .wrapper-all .main-bg .reffect {
                        position: absolute;
                        position: absolute;
                        right: -162px;
                        top: -130px;
                        content: '';
                        width: 300px;
                        height: 300px;
                        background: #ffffff;
                        border-radius: 50%;
                        opacity: 0.2;
                    }
        }
    </style>
    <script>
        function backpage() {
            window.location.href = '<%=ProjectSession.absoluteSiteBrowseUrl%>';
        }


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper-all">
            <div class="area">
                <ul class="circles">
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                </ul>
            </div>
            <div class="main-bg">
                <span class="reffect"></span>
                <div class="container-box container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="imgCalled animated fadeInDown">
                                <img src="assets/images/thanks.png" class="img-fluid" alt="thanks" />
                            </div>
                            <div class="mt-4 text-center">
                                <h1 class="animated fadeInDown">Thank You !</h1>
                                <h4 class="animated fadeInDown">We've received your request. our representative will get back to you with in next 24 Hours.</h4>
                                <div class="mt-5 animated fadeInUp"><a href="#" onclick="backpage();" class="btn callback_btn">Continue to Homepage</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
