<%@ Page Language="C#" AutoEventWireup="true" CodeFile="codeverify.aspx.cs" Inherits="codeverify" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
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


        .align-set {
            margin-top: -115px;
            margin-left: 104px;
            width: 100%;
            margin-bottom: 38px;
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

        body {
            background: #000;
        }

        .bg-fixed {
            background: url(../assets/images/nitro-banner-website-2.jpg);
            background-size: 100% 100%;
            position: relative;
            height: 100%;
        }

            .bg-fixed::before {
                position: absolute;
                left: 0;
                top: 0;
                height: 100%;
                width: 100%;
                content: '';
                background: rgb(56,70,131);
                background: linear-gradient(180deg, rgba(56,70,131,1) 0%, rgba(0, 0, 0, 0.55) 100%, rgba(14, 44, 48, 0.39) 100%);
                opacity: 0.3;
            }

        .max-box {
            width: 100%;
            display: block;
            margin-top: 0;
        }

            .max-box h1 {
                color: #dc3545;
                font-size: 6em;
                font-weight: bold;
                text-transform: uppercase;
                letter-spacing: 0.8px;
                text-align: center;
            }

                .max-box h1 span {
                    display: block;
                    color: #FFF;
                    font-size: 1em;
                    letter-spacing: 13px;
                }

        .royal-box {
            width: 100%;
            display: block;
            margin-bottom: 20em
        }

        .royalproduct {
            max-width: 613px;
            margin: 0 auto;
        }

        .royal-box h1 {
            color: #dc3545;
            font-size: 6em;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            text-align: center;
        }

            .royal-box h1 span {
                display: block;
                color: #2c98ea;
                font-size: 1em;
                letter-spacing: 13px;
            }

        .custom_col-container {
            width: 100%;
            max-width: 1600px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }

            .custom_col-container.content-over {
                /*position:absolute;
            top:50%;
            transform:translateY(-50%);*/
                position: relative;
                min-height: 100vh;
                width: 90%;
                box-sizing: border-box;
                max-width: 100%;
                margin: 0 auto;
            }

        .logo-nutrition {
            width: 100px;
            height: 100px;
            overflow: hidden;
            position: absolute;
            /*argin:0 auto*/
        }

            .logo-nutrition img {
                width: 100%;
                top: 0;
                left: 0;
                height: 100%;
                position: absolute;
                object-fit: contain;
            }

        .logo-ankriti img {
            width: 25%;
        }

        html .btn-primary {
            background: rgb(56,70,131);
            background: linear-gradient(90deg, rgba(56,70,131,1) 0%, rgba(235,49,54,1) 100%, rgba(255,234,196,1) 100%);
            color: #ffffff !important;
            border: none;
            border-radius: 0px;
            padding: 1em 4em;
            font-weight: 600;
            text-transform: uppercase;
        }

            html .btn-primary:active, html .btn-primary.active {
                background-color: #ed3439 !important;
                background-image: none !important;
                border-color: #ed3439 #ed3439 #ed3439 !important;
            }

        .popup {
            display: none;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            z-index: 900
        }

        .show {
            display: block
        }

        .popup-bg {
            position: fixed;
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
            background-color: rgba(0,0,0,.5);
            z-index: 900;
        }

        .displayNone {
            display: none !important;
        }

        .popup-close {
            position: absolute;
            right: -8px;
            top: -8px;
            width: 16px;
            height: 16px;
            font-size: 0;
            text-indent: -9999px;
            background-color: #cc0000;
            z-index: 999;
        }

        .popup-content {
            position: fixed;
            left: 50%;
            top: 50%;
            transform: translate(-50%,-50%);
            margin: auto;
            width: 200px;
            height: 200px;
            background-color: #fff;
            z-index: 999;
        }

        .formBox-input {
            background: rgba(0,0,0,0.1);
            border-radius: 3px;
            /* border: 1px solid #0a2c49;*/
            padding: 0px;
            max-width: 644px;
            margin: auto;
            margin-top: 8px;
        }

            .formBox-input .form-control {
                background: transparent;
                border: 1px solid #ffffff;
                border-radius: 0;
                color: #FFF;
            }

            .formBox-input label {
                color: #FFF;
            }

            .formBox-input h2 {
                color: #55abdd;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-size: 24px;
            }

        .content-over .formBox-input {
            /*position: absolute;*/
            top: -48px;
        }

            .content-over .formBox-input h2 {
                color: #FFF;
                font-size: 20px;
            }


        #ddlpurchasefrm {
            color: gray;
        }

        .bg-fixed-1 {
            background: url(../assets/images/Royal-nutrabale.jpg);
            background-size: 100%;
            background-repeat: no-repeat;
            position: relative;
            min-height: 100vh;
        }

            .bg-fixed-1::before {
                height: 100%;
                width: 100%;
                top: 0;
                left: 0;
                background: rgb(0,0,41);
                background: linear-gradient(90deg, rgba(0,0,41,1) 14%, rgba(2,13,55,0) 77%);
                opacity: 0;
                content: '';
                position: absolute;
            }

        .formBox-input.bg_blue {
            background: rgb(23 21 69);
        }

        .icon-colauthentic {
            /*position: absolute;
            */
            margin: 0 auto;
            padding-bottom: 15px;
            position: relative;
            bottom: 0px;
        }

        .absolute {
            position: relative !important
        }

        .icon-colauthentic h2, .icon-colauthentic h3, .icon-colauthentic p {
            color: #FFF;
        }

        .icon-colauthentic p {
            margin-bottom: 0;
            margin-left: 15px;
        }

        .icon-colauthentic .gap {
            margin-top: 40px;
        }

        .icon-colauthentic h2 {
            font-size: 40px;
        }

        .icon-colauthentic svg {
            width: 80px !important;
            height: 50px;
        }

            .icon-colauthentic svg path {
                fill: #FFF
            }

        .content-over .icon-colauthentic svg path {
            fill: #dc9c2e
        }

        .icon-colauthentic .rouded-effects {
            padding: 15px;
            border: 6px solid #5c4273;
            border-radius: 20px;
            background-image: linear-gradient(to right, #384683, #72418e, #aa3083, #d51c64, #eb3136);
            min-height: 116px;
            display: flex;
            align-items: center;
            text-align: left;
            justify-content: start;
            position: relative;
        }

        .icon-colauthentic .rouded-effects-1 {
            padding: 15px;
            border: 6px solid #1d1d1d;
            border-radius: 20px;
            background-image: linear-gradient(to right, #1f1f1f, #212227, #22252f, #202937, #1a2d3f);
            min-height: 116px;
            display: flex;
            align-items: center;
            text-align: left;
            justify-content: start;
            position: relative;
        }



        /*====Gurukripa start code===========*/
        .w2rapper {
            width: 100%;
            height: 100%;
            display: block;
            position: relative;
            overflow-x: hidden;
        }

        .w2rapper1 {
            width: 100%;
            height: 100%;
            display: block;
            position: relative;
            overflow-x: hidden;
        }

        .gurukripa-bg {
            background: url(../assets/images/gurukripa/gurukripa-bg.jpg);
            background-size: 100% 100%;
            position: relative;
            height: 100vh;
            background-repeat: no-repeat;
        }

        #step4 {
            position: relative;
            padding: 0px 7px 0px 4px;
        }


        #container3 {
            position: relative;
        }

        .muscletech-bg {
            background: url(../assets/images/nitro-banner-website-2.jpg);
            background-color: #ffeded4d;
            background-size: cover;
            position: relative;
            height: 100vh;
            background-repeat: no-repeat;
            height: 100vh;
            display: table;
            width: 100%;
        }


        .gurukripa-bg .topZig {
            position: absolute;
            right: -2px;
            top: 5px;
        }

        .gurukripa-bg .botZig {
            position: absolute;
            left: -2px;
            bottom: 5px;
            transform: scale(-1, -1);
        }


        /*   .muscletech-bg .topZig {
            position: absolute;
            right: -2px;
            top: 5px;
        }

        .muscletech-bg .botZig {
            position: absolute;
            left: -2px;
            bottom: 5px;
            transform: scale(-1, -1);
        }*/

        .formax-box {
            width: 100%;
            display: block;
            margin: 0 auto;
            max-width: 660px;
        }

            .formax-box h1 {
                color: #FFF;
                font-size: 5em;
                font-weight: bold;
                text-transform: uppercase;
                letter-spacing: 5px;
                text-align: left;
            }

                .formax-box h1 span {
                    display: block;
                    color: #fe5a3a;
                    font-size: 2em;
                    letter-spacing: 80px;
                }


        .custom_col-container-1 {
            width: 100%;
            max-width: 1600px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }

            .custom_col-container-1.content-over-1 {
                /*position:absolute;
            top:50%;
            transform:translateY(-50%);*/
                position: relative;
                min-height: 100vh;
                width: 90%;
                box-sizing: border-box;
                max-width: 100%;
                margin: 0 auto;
            }

        .logo-pronutrition {
            width: 170px;
            height: 120px;
            overflow: hidden;
            position: relative;
            /*argin:0 auto*/
        }

            .logo-pronutrition img {
                width: 85%;
                top: 0;
                left: 0;
                height: 100%;
                position: absolute;
                object-fit: contain;
            }

        .form-checkcode {
            /* background: rgba(0,0,0,0.1); */
            border-radius: 3px;
            background: #073757;
            border-radius: 10px;
            /* border: 1px solid #0a2c49; */
            padding: 0px;
            max-width: 644px;
            padding: 28px;
            margin: auto;
            margin-bottom: 70px;
            color: #fff;
        }

            .form-checkcode .form-control {
                background: #fff;
                border: 1px solid #ffffff;
                border-radius: 0;
            }


        input::placeholder {
            color: #004167 !important;
        }

        .form-checkcode label {
            color: #FFF;
            text-transform: uppercase;
            font-weight: 600;
            font-size: 14px;
        }

        .form-checkcode h2 {
            color: #ffffff;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 18px;
            font-weight: 700;
            text-align: center;
        }

        .content-over-1 .form-checkcode {
            /*position: absolute;*/
            top: -48px;
        }

            .content-over-1 .form-checkcode h2 {
                color: #FFF;
                font-size: 20px;
            }

        .form-checkcode.bg_blue {
            background: rgb(23 21 69);
        }

        .icon_pauthentic {
            /*position: absolute;
            */
            margin: 0 auto;
            padding-bottom: 15px;
            position: relative;
            bottom: 0px;
        }

            .icon_pauthentic h2, .icon_pauthentic h3, .icon_pauthentic p {
                color: #FFF;
            }

            .icon_pauthentic p {
                margin-bottom: 0;
                margin-left: 15px;
                font-weight: 500;
            }

            .icon_pauthentic .gap {
                margin-top: 40px;
            }

            .icon_pauthentic h2 {
                font-size: 40px;
            }

            .icon_pauthentic svg {
                width: 80px !important;
                height: 50px;
            }

                .icon_pauthentic svg path {
                    fill: #FFF
                }

            .icon_pauthentic .radius-effect {
                padding: 15px;
                border: 6px solid #0b2a4c;
                border-radius: 20px;
                background: rgb(216,50,18);
                background: linear-gradient(90deg, rgba(216,50,18,1) 14%, rgba(208,148,51,1) 77%);
                min-height: 116px;
                display: flex;
                align-items: center;
                text-align: left;
                justify-content: start;
                position: relative;
            }

            .icon_pauthentic .radius-effect-1 {
                padding: 15px;
                border: 6px solid #1d1d1d;
                border-radius: 20px;
                background-image: linear-gradient(to right, #1f1f1f, #212227, #22252f, #202937, #1a2d3f);
                min-height: 116px;
                display: flex;
                align-items: center;
                text-align: left;
                justify-content: start;
                position: relative;
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
        /* .footer-bot {
            position: relative;
            
            align-items: center;
            margin-top: 25px;
            justify-content: space-between;
        }*/


        .footer-bot {
            position: absolute;
            align-items: center;
            margin-top: 25px;
            justify-content: space-between;
            background: #fe5a3a;
            padding: 10px;
            text-align: center;
            bottom: 0;
            width: 100%;
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

        @media (min-width: 1200px) {
            .formBox-input, .form-checkcode {
                display: block;
            }

            .royal-box {
                width: 100%;
                display: block;
                margin-bottom: 10em;
            }

            .gurukripa-bg .topZig, .gurukripa-bg .botZig {
                max-width: 450px;
            }
        }

        @media (max-width: 1024px) {

            .gurukripa-bg .topZig, .gurukripa-bg .botZig {
                max-width: 450px;
            }

            .align-set {
                margin-left: 0px;
            }
        }

        @media(max-width: 1450px) {
            /*.icon-colauthentic {
                position: relative;
            }*/
        }

        @media (max-width: 1200px) {
        }

        @media(max-width: 1366px) {
            .royal-box {
                margin-top: 0;
                margin-bottom: 10em;
            }

                .max-box h1, .royal-box h1 {
                    font-size: 4.5em;
                }

                    .max-box h1 span, .royal-box h1 span {
                        letter-spacing: normal
                    }

            .gurukripa-bg {
                height: 100%;
            }

            .muscletech-bg {
                height: 100vh;
                display: table;
                width: 100%;
            }

            .formax-box h1, .royal-box h1 {
                font-size: 4.5em;
                margin-top: 40px;
            }

                .formax-box h1 span, .royal-box h1 span {
                    letter-spacing: normal
                }

                .formax-box h1 span, .royal-box .avattar h1 span {
                    letter-spacing: normal;
                    font-size: 100%;
                }
        }

        @media(max-width: 920px) {


            /* .form-checkcode {
                margin-top: 20% !important;
            }*/
            .form-checkcode .form-control {
                background: #ffdfdf;
                border: 1px solid #ffffff;
                border-radius: 0;
                margin-bottom: 10px;
                color: #212227;
                border-radius: 30px;
            }
        }

        @media(max-width: 768px) {

            .bg-fixed {
                background: url(../assets/images/nitro-banner-website-2.jpg) no-repeat 0 0;
                background-size: 100%;
                position: relative;
                height: 100%;
                min-height: 500px;
            }

            .align-set {
                margin-top: 0px;
                margin-left: 0px;
            }

            /*  .form-checkcode {
                margin-top: 20% !important;
            }*/

            .logo-pronutrition1 img {
                max-width: 159px;
            }

            .bg-fixed-1 {
                background: url(../assets/images/Royal-nutrabale.jpg);
                background-size: 100%;
                background-repeat: no-repeat;
                position: relative;
                height: 100%;
                min-height: 500px;
            }

            .custom_col-container.content-over {
                position: relative;
                top: 0;
                transform: none;
                width: 100%;
                box-sizing: border-box;
                max-width: 100%;
            }

            .absolute {
                position: relative !important
            }

            .logo-nutrition {
                width: 80px;
                height: 80px;
                overflow: hidden;
                position: relative;
                margin: 0 auto;
                float: right;
            }

            .icon-colauthentic {
                padding-top: 0;
                position: relative
            }

                .icon-colauthentic .gap {
                    margin-top: 0;
                }

            .gurukripa-bg {
                background-size: 100%;
                position: relative;
                height: 100%;
                min-height: 500px;
                padding-bottom: 5em;
            }

            .muscletech-bg {
                /* background-size: 100%; /
    position: relative;
    / height: 100vh; */
                min-height: 500px;
                display: table;
                padding-bottom: 5em;
                width: 100%;
            }

            .gurukripa-bg .topZig, .gurukripa-bg .botZig {
                max-width: 250px;
            }

            .form-checkcode .form-control {
                background: #ffdfdf;
                border: 1px solid #ffffff;
                border-radius: 0;
                margin-bottom: 10px;
                color: #212227;
                border-radius: 30px;
            }

            .custom_col-container-1.content-over-1 {
                position: relative;
                top: 0;
                transform: none;
                width: 100%;
                box-sizing: border-box;
                max-width: 100%;
            }

            .form-checkcode {
                background: #18212a;
                border-radius: 20px;
                border: 1px solid #0a2c49;
                padding: 15px;
                max-width: 644px;
                margin: auto;
                margin-bottom: 20px;
                color: #1f1f1f;
            }


            .logo-pronutrition {
                width: 145px;
                height: 114px;
                overflow: hidden;
                position: relative;
            }

            .icon_pauthentic {
                padding-top: 0;
                position: relative
            }

                .icon_pauthentic .gap {
                    margin-top: 0;
                }

            .formax-box h1 {
                font-size: 2em;
                text-align: center;
            }

            .royal-box {
                margin-bottom: 0;
            }

            .formBox-input {
                margin-top: 1em;
            }

            .formBox-input {
                background: rgb(22 55 96);
                /*border: 4px solid #122644;*/
                border-radius: 15px;
            }

            .content-over .formBox-input {
                position: relative;
                top: 0;
                margin-top: 180px;
            }

            .max-box h1, .royal-box h1 {
                font-size: 3em;
            }

            .footer-bot a {
                text-align: center
            }

            .footer-bot .socialicon ul {
                display: block;
                list-style-type: none;
                /*text-align:center*/
            }

            .avattar {
                margin-top: 55px;
            }
        }

        @media(max-width: 640px) {
            .max-box h1, .royal-box h1 {
                font-size: 3em;
            }

            .formBox-input h2 {
                font-size: 18px;
            }

            .formax-box h1 {
                font-size: 2em;
            }

            .form-checkcode h2 {
                font-size: 18px;
            }

            .productImg {
                max-width: 317px;
                margin: 0 auto;
            }

            .footer-bot {
                position: absolute;
                display: block;
                align-items: center;
                margin-top: 25px;
                justify-content: space-between;
                text-align: center;
            }

                .footer-bot .socialicon ul {
                    display: block;
                    list-style-type: none;
                    text-align: center;
                    margin-top: 15px;
                    padding: 0;
                }

            .icon-colauthentic svg {
                width: 53px !important;
                height: 50px;
            }
        }

        @media(max-width: 480px) {
            .max-box {
                margin-top: 50px;
            }

            .royal-box {
                margin-top: 120px;
            }
        }

        @media only screen and (max-width: 320px) {
            .input1 {
                height: 60px;
            }

            .formax-box {
                margin-top: 0;
            }
        }

        /*---------Chase2fit start code*/

        .chase2fit-bg {
            background: url(../assets/images/nitro-banner-website-2.jpg);
            background-size: 100% 100%;
            position: relative;
            background-repeat: no-repeat;
        }

            .chase2fit-bg .topZig {
                position: absolute;
                right: -2px;
                top: 5px;
            }



        /*--------- End Chase2fit Code ------------------*/
    </style>


    <script>


        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }

   $(function () {
            $("#ddlpurchasefrm").change(function () {
                if ($(this).val() == "Others") {
                    $("#dvother").show();
                } else {
                    $("#dvother").hide();
                    $("#txtotherrole").value() == "";
                }
            });
        });


function getaddress() {
            let pin = document.getElementById("pin").value;
            if (pin.length == 6) {
                $.getJSON("https://api.postalpincode.in/pincode/" + pin, function (data) {
                    createHTML(data);
                })
                function createHTML(data) {
                    if (data[0].Status == "Success") {
                        var city = "";
                        var state = "";
                        var pin = "";
                        var city = data[0].PostOffice[0]['District'];
                        var state = data[0].PostOffice[0]['State'];
                        var Pin = data[0].PostOffice[0]['PinCode'];
                        $("#city").val(city);
                        $("#state").val(state);
                         if (pin == "") {
                            $("#pin").val();
                        }
                        else {
                            $("#pin").val(Pin);
                        }
                        $('#btnsubmit').attr('disabled', false);
                    }
                    else {
                        toastr.error("Please enter valid pin.");
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                }
            }
        }


        $(function () {
            $("#btnsubmit").click(function () {
                var role_id = $("#ddlpurchasefrm");
                if (role_id.val() == "") {
                    alert("Please select Purchase From!");
                    return false;
                }
                return true;
            });
        });





        $(function () {

            //var queryString = location.search.substring(1);
            //if (navigator.geolocation) {
            //    navigator.geolocation.getCurrentPosition(showPosition);

            //} else {
            //    // x.innerHTML = "Geolocation is not supported by this browser.";
            //}

            var id = $('#HdnID').val();

            firstfunction();

            if (id == "1") {
                $('.bg-fixed').show();
                $('.bg-fixed-1').hide();
                $('.w2rapper').hide();
                $('.w2rapper1').hide();

                $('#step1').show();
                $('#step2').hide();
            }


            else if (id == "FBNutrition") {
                $('.bg-fixed').show();
                $('.bg-fixed-1').hide();
                $('.w2rapper').hide();
                $('.w2rapper1').hide();
                $('#step1').hide();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $(".codeone").val(code);
            }

            else if (id == "2") {
                $('.bg-fixed').hide();
                $('.w2rapper1').hide();
                $('.w2rapper').hide();
                $('.bg-fixed-1').show();
                $('#RoyalAK').hide();
                $('#Royal').addClass('formBox-input');


                $('#container2').contents().appendTo('#Royal');

                $('#step1').show();
                $('#step2').hide();
            }

            else if (id == "ROYALMANUFACTURER") {
                $('.bg-fixed').hide();
                $('.w2rapper').hide();
                $('.w2rapper1').hide();
                $('.bg-fixed-1').show();
                $('#RoyalAK').hide();
                $('#Royal').addClass('formBox-input');
                $('#container2').contents().appendTo('#Royal');
                $('#step1').hide();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $(".codeone").val(code);
            }


            else if (id == "3") {
                $('.bg-fixed').hide();
                $('.w2rapper').show();
                $('.w2rapper1').hide();
                $('.bg-fixed-1').hide();


                $('#container2').contents().appendTo('#GuruKripa');

                $('#step1').show();
                $('#step2').hide();
            }




            else if (id == "GuruKripaEnterprises") {
                $('.bg-fixed').hide();
                $('.w2rapper').show();
                $('.w2rapper1').hide();
                $('.bg-fixed-1').hide();

                $('#container2').contents().appendTo('#GuruKripa');
                $('#step1').hide();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $(".codeone").val(code);
            }


            else if (id == "4") {
                $('.bg-fixed').hide();
                $('.bg-fixed-1').hide();
                $('.w2rapper').hide();

                $('.w2rapper1').show();

                $('#forfocus').focus();

                //$('#container2').contents().appendTo('#muscletech');

                $('#step3').show();
                $('#step4').hide();
            }

            else if (id == "PARAG") {
                $('.bg-fixed').hide();
                $('.bg-fixed-1').hide();
                $('.w2rapper').hide();




                $('.w2rapper1').show();

                //$('#container2').contents().appendTo('#GuruKripa');
                $('#step3').hide();
                $('#step4').show();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $(".codeone1").val(code);
            }


            else if (id == "5") {
                $('.bg-fixed').hide();
                $('.bg-fixed-1').hide();
                $('.w2rapper').hide();

                $('.w2rapper1').hide();
                $('#RoyalAK').show();
                $('#forfocus').focus();

                //$('#container2').contents().appendTo('#muscletech');

                $('#step5').show();
                $('#step6').hide();
            }

            else if (id == "AnkeriteHealth") {
                $('.bg-fixed').hide();
                $('.bg-fixed-1').hide();
                $('.w2rapper').hide();

                $('.w2rapper1').hide();
                $('#RoyalAK').show();

                //$('#container2').contents().appendTo('#GuruKripa');
                $('#step5').hide();
                $('#step6').show();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $(".codeone2").val(code);
            }


            else if (id == "6") {
                $('.bg-fixed').hide();
                $('.bg-fixed-1').hide();
                $('.w2rapper').hide();

                $('.w2rapper1').hide();
                $('#RoyalAK').hide();
                $('#chase2fit').show();
                $('#forfocus').focus();

                //$('#container2').contents().appendTo('#muscletech');

                $('#step7').show();
                $('#step8').hide();
            }

            else if (id == "Chase2") {
                $('.bg-fixed').hide();
                $('.bg-fixed-1').hide();
                $('.w2rapper').hide();

                $('.w2rapper1').hide();
                $('#RoyalAK').hide();
                $('#chase2fit').show();

                //$('#container2').contents().appendTo('#GuruKripa');
                $('#step7').hide();
                $('#step8').show();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $(".codeone3").val(code);
            }



            $(".codeone").mask("99999-99999999");
            $(".codeone1").mask("99999-99999999");
            $(".codeone2").mask("99999-99999999");
            $(".codeone3").mask("99999-99999999");

            $(".input1").keyup(function () {

                if (this.value.length == this.maxLength) {
                    $('#step1').hide();
                    $('#step3').hide();
                    $('#step5').hide();
                    $('#step7').hide();
                    /*$('#step2').show();*/

                    $('#checkcode').removeClass('checkcode5');
                    $('#checkcode').addClass('checkcode');
                    $('#checkcodein').removeClass('col-md-5');
                    $('#checkcodein').addClass('col-md-12');

                    $('#checkcode1').removeClass('checkcode5');
                    $('#checkcode1').addClass('checkcode');
                    $('#checkcode1in').removeClass('col-md-5');
                    $('#checkcode1in').addClass('col-md-12');

                    $('#srcc').hide();
                    var rquestpage_Dcrypt = "";
                    if ($(".codeone").val() != undefined && $(".codeone").val() != "") {
                        rquestpage_Dcrypt = $(".codeone").val();
                    }
                    if ($(".codeone1").val() != undefined && $(".codeone1").val() != "") {
                        rquestpage_Dcrypt = $(".codeone1").val();
                    }
                    if ($(".codeone2").val() != undefined && $(".codeone2").val() != "") {
                        rquestpage_Dcrypt = $(".codeone2").val();
                    }
                    if ($(".codeone3").val() != undefined && $(".codeone3").val() != "") {
                        rquestpage_Dcrypt = $(".codeone3").val();
                    }


                    $.ajax({
                        type: "POST",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                        success: function (data) {

                            $.ajax({
                                type: "POST",
                                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                                success: function (data) {
                                    debugger;

                                    if (data.split('&')[0] === "1" && data.split('&')[1] === "Auto Max India") {

                                    }



                                    else {


                                        $('#step2').show();
                                        $('#step4').show();
                                        $('#step6').show();
                                        $('#step8').show();

                                    }
                                }
                            });
                        }
                    });
                }
            });

            var flag = false;
            $(".mobile_num").keyup(function () {

                var phoneNumber = $('.mobile_num').val();
                var validate = false;
                var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;

                if (filter.test(phoneNumber)) {
                    if (phoneNumber.length == 10) {
                        var c = phoneNumber.slice(0, 1);
                        if (c <= 5) {
                            $('#p3msg').html('Not a valid mobile number');
                            validate = false;
                            $('.mobile_num').val('');
                        }
                        else
                            validate = true;
                    } else {
                        if (phoneNumber.length > 10) {
                            $('#p3msg').html('Please put 10  digit mobile number');
                            //$('#p3msg').removeClass('displayNone');
                            validate = false;
                        }
                        else
                            validate = false;
                    }
                }
                else {

                    if (phoneNumber.length == 9) {
                        $('#p3msg').html('Not a valid mobile number');
                        $('.mobile_num').val('');
                        validate = false;
                    }
                    else
                        validate = false;
                }

                if (validate) {

                    $('#p3msg').addClass('displayNone');
                    if (this.value.length == this.maxLength) {
                        $('#step2').hide();
                        $('#checkcode2').show();
                        if (!flag) {
                            toastr.clear();

                            if ($('.codeone').val() == '') {
                                toastr.error("Please enter Code1"); msg = "no";
                                return false;
                            }

                            var array = $('.codeone').val().split("-");
                            var code1 = array[0];
                            var code2 = array[1]

                            if ($('#mobile').val() == '') {
                                toastr.error("Please enter your mobile No."); msg = "no";
                                return false;
                            }
                            if ($('#mobile').val() != '') {
                                var reg = new RegExp('[0-9]$');
                                if (!reg.test($('#mobile').val())) {
                                    toastr.error("Please enter numeric value for mobile No."); msg = "no";
                                    return false;
                                }
                            }
                            if ($('#mobile').val().length != 10) {
                                toastr.error("Please enter correct mobile No."); msg = "no";
                                return false;
                            }
                            //  else {
                            if ($('#mobile').val() == '') {
                                toastr.error("Please enter your mobile No."); msg = "no";
                                return false;
                            }
                            else {
                                var v = $('#mobile').val().length;
                                if (v != 10) {
                                    toastr.error("Please enter correct Mobile Number."); msg = "no"; return false;
                                }
                                else {
                                    $('#hdnmob').val('' + $('#mobile').val());

                                    var long = $('#long').val();

                                    flag = true;
                                    $.ajax({
                                        type: "POST",
                                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + code1 + '&codetwo=' + code2 + '&mobile=' + $('#mobile').val() + '&RefCd=' + $('#RefCd').val() + '&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                                        success: function (data) {

                                            $('#progress').hide();


                                            $('#mobile').val('');
                                            $('#RefCd').val('');

                                            $('#p1msgmodal').show();
                                            $('#p1msg').html(data);
                                            $('#p1msg:contains("can not be guaranteed")').css('color', 'red');
                                            $('#checkcode1').show();
                                            $('#checkcode').hide();
                                            $('#checkcode2').hide();
                                            flag = false;
                                        },
                                    });

                                }
                            }
                        }
                    }
                }
                else
                    $('#p3msg').removeClass('displayNone');
            });

            $('#btnsubmit').on('click', function () {
                debugger;
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
                                $('#p4msg').html('Not a valid mobile number');
                                validate = false;
                                $('#mobilenumber').val('');
                                $('#btnsubmit').attr('disabled', false);
                                return false;
                            }
                            else
                                validate = true;
                        } else {
                            if (phoneNumber.length > 10) {
                                $('#p4msg').html('Please put 10  digit mobile number');
                                $('#btnsubmit').attr('disabled', false);
                                validate = false;
                                return false;
                            }
                            else {
                                validate = false;
                                $('#btnsubmit').attr('disabled', false);
                            }
                        }
                    }



                    else {

                        if (phoneNumber.length == 9) {
                            $('#p4msg').html('Please Enter Valid mobile number');
                            $('#mobilenumber').val('');
                            validate = false;
                            $('#btnsubmit').attr('disabled', false);
                            return false;
                        }
                        else
                            validate = false;
                    }


                    if (phoneNumber.match(/[^$,.\d]/)) {
                        toastr.error("Please enter numeric value for mobile No.");
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }

                }


                var pin = $('#pin').val();

                if (pin != undefined) {
                    if (pin.length < 6) {
                        toastr.error('Please Enter Valid Pin Number');
                        $('#btnsubmit').attr('disabled', false);
                    }
                    var validate = false;
                    var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;
                    if (filter.test(pin)) {
                        if (pin.length > 6) {
                            $('#p4msg').html('Please put 6  digit pin number');
                            validate = false;
                            return false;
                        }
                        else {
                            validate = false;
                            $('#btnsubmit').attr('disabled', false);
                        }
                    }
                    if (pin.match(/[^$,.\d]/)) {
                        toastr.error("Please enter numeric value for pin No.");
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                }


                var fname = $('#First_Name').val();
                if (fname != undefined) {


                    if ($('#First_Name').val().length < 1) {
                        toastr.error('Please Enter First Name');
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    var matches = $('#First_Name').val().match(/\d+/g);
                    if (matches != null) {
                        toastr.error('First Name Should be alphabet only!');
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    var matches1 = $('#First_Name').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        toastr.error('First Name Should Not Contain any Special Character!');
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                }

                var lname = $('#Last_Name').val();
                if (lname != undefined) {


                    if ($('#Last_Name').val().length < 1) {
                        toastr.error('Please Enter Last Name');
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    var matches = $('#Last_Name').val().match(/\d+/g);
                    if (matches != null) {
                        toastr.error('Last Name Should be alphabet only!');
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    var matches1 = $('#Last_Name').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        toastr.error('Last Name Should Not Contain any Special Character!');
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                }


                var city = $('#city').val();
                if (city != undefined) {
                    if ($('#city').val().length < 1) {
                        toastr.error('Please Enter City');
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                }

                var state = $('#state').val();
                if (state != undefined) {
                    if ($('#state').val().length < 1) {
                        toastr.error('Please Enter State');
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                }

                var Email = $('#EmailAddrs').val();
                if (Email != undefined) {
                    var check = validateEmail(Email);
                    if (check != true) {
                        toastr.error('Please Enter valid Email Address!');
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                }


                var e = document.getElementById("ddlpurchasefrm");
                var optionSelIndex = e.options[e.selectedIndex].value;
                var optionSelectedText = e.options[e.selectedIndex].text;
                if (optionSelIndex == 0) {
                    toastr.error('Please Select Purchase from1');
                    validate = false;
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }

                if (optionSelIndex == 5) {
                    if ($('#txtotherrole').val().length<1) {
                        toastr.error('Please Select Purchase from');
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                   
                }

                if (optionSelectedText == "0") {
                    toastr.error('Please Select Purchase from');
                    validate = false;
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }

                if (optionSelectedText == "Others") {
                    if ($('#txtotherrole').val().length < 1) {
                        toastr.error('Please Enter Purchase from');
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }

var matches = $('#txtotherrole').val().match(/\d+/g);
                    if (matches != null) {
                        toastr.error('Purchase from alphabet only!');
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    var matches1 = $('#txtotherrole').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        toastr.error('Purchase from Should Not Contain any Special Character!');
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    
                }

                //if ($('#ddlpurchasefrm').val().length < 1) {
                //    toastr.error('Please Select Purchase from');
                //    validate = false;
                //}

               

                // if (validate) {
                $('#p4msg').html('');

                var purchasefromm = $('#ddlpurchasefrm').val();
                if (code != "") {
                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,
                       
                       
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('.codeone1').val() + '&City=' + $('#city').val() + '&state=' + $('#state').val() + '&SellerName=' + $('#ddlpurchasefrm').val() + '&PinCode=' + $('#pin').val() + '&name=' + $('#First_Name').val() + ' ' + $('#Last_Name').val() + '&EmailAddrs=' + $('#EmailAddrs').val() + '&Other_Role=' + $("#txtotherrole").val()+ '&comp=PARAG MILK FOODS',

                            success: function (data) {
                                debugger;
                                if (data.split('~')[0] !== "failure") {
                                    window.scrollTo(0, 0);
                                    $('#container3').hide();
                                    $('#Chkfields').hide();
                                    $('.form-checkcode').hide();

                                    //var input = document.getElementById("ShowMessage").focus();
                                    //var input1 = document.getElementById("p4msg").focus();
                                    $('#ShowMessage').show();

                                    $('#p4msg').focus();

                                    if (data.indexOf("not valid") !== -1) {
                                        data = data.split(".")[0];
                                    }

                                    $('#chkLine').hide();
                                    $('#p4msg').html(data.split('~')[1]);







                                }
                                else {

                                    $('#msgcoats').hide();
                                    toastr.error('OTP is not valid. Please provide the valid OTP');
                                    $('#btnskyVerify1').attr('disabled', false);

                                }
                            }
                        });
                }


                // }
                //else {

                //    $('#btnsubmit').attr('disabled', false);

                //}

            });


            $('#btnsubmit1').on('click', function () {
                $('#btnsubmit1').attr('disabled', true);

                var phoneNumber = $('#mobilenumber1').val();

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
                                $('#p4msg1').html('Not a valid mobile number');
                                validate = false;
                                $('#mobilenumber1').val('');
                            }
                            else
                                validate = true;
                        } else {
                            if (phoneNumber.length > 10) {
                                $('#p4msg1').html('Please put 10  digit mobile number');

                                validate = false;
                            }
                            else {
                                validate = false;
                                $('#btnsubmit1').attr('disabled', false);
                            }
                        }
                    }



                    else {

                        if (phoneNumber.length == 9) {
                            $('#p4msg1').html('Please Enter Valid mobile number');
                            $('#mobilenumber1').val('');
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
                var name = $('#Name1').val();
                if (name != undefined) {


                    if ($('#Name1').val().length < 1) {
                        toastr.error('Please Enter valid Name');
                        validate = false;
                    }
                    var matches = $('#Name1').val().match(/\d+/g);
                    if (matches != null) {
                        toastr.error('Name Should be alphabet only!');
                        validate = false;
                    }
                    var matches1 = $('#Name1').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        toastr.error('Name Should Not Contain any Special Character!');
                        validate = false;
                    }
                }


                var Address = $('#Address1').val();
                if (Address != undefined) {


                    if ($('#Address1').val().length < 1) {
                        toastr.error('Please Enter City');
                        validate = false;
                    }
                }




                if (validate) {
                    $('#p4msg1').html('');


                    if (code != "") {
                        $.ajax({
                            type: "POST",
                            contentType: false,
                            processData: false,

                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber1').val() + "&vCode=" + $('.codeone2').val() + '&Address=' + $('#Address1').val() + '&name=' + $('#Name1').val() + '&comp=Ankerite Health Care Pvt. Ltd',

                            success: function (data) {
                                debugger;
                                if (data.split('~')[0] !== "failure") {
                                    window.scrollTo(0, 0);
                                    $('#container4').hide();
                                    $('#Chkfields').hide();


                                    //var input = document.getElementById("ShowMessage").focus();
                                    //var input1 = document.getElementById("p4msg").focus();
                                    $('#ShowMessage1').show();

                                    $('#p4msg1').focus();

                                    if (data.indexOf("not valid") !== -1) {
                                        data = data.split(".")[0];
                                    }

                                    $('#chkLine').hide();
                                    $('#p4msg1').html(data.split('~')[1]);

                                    $('#p4msg1:contains("not")').css('color', 'white');





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

                    $('#btnsubmit1').attr('disabled', false);

                }

            });


            $('#btnsubmit2').on('click', function () {
                $('#btnsubmit2').attr('disabled', true);

                var phoneNumber = $('#mobilenumber2').val();

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
                                $('#p4msg2').html('Not a valid mobile number');
                                validate = false;
                                $('#mobilenumber2').val('');
                            }
                            else
                                validate = true;
                        } else {
                            if (phoneNumber.length > 10) {
                                $('#p4msg2').html('Please put 10  digit mobile number');

                                validate = false;
                            }
                            else {
                                validate = false;
                                $('#btnsubmit2').attr('disabled', false);
                            }
                        }
                    }



                    else {

                        if (phoneNumber.length == 9) {
                            $('#p4msg2').html('Please Enter Valid mobile number');
                            $('#mobilenumber2').val('');
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
                var name = $('#Name2').val();
                if (name != undefined) {


                    if ($('#Name2').val().length < 1) {
                        toastr.error('Please Enter valid Name');
                        validate = false;
                    }
                    var matches = $('#Name2').val().match(/\d+/g);
                    if (matches != null) {
                        toastr.error('Name Should be alphabet only!');
                        validate = false;
                    }
                    var matches1 = $('#Name2').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        toastr.error('Name Should Not Contain any Special Character!');
                        validate = false;
                    }
                }


                var Address = $('#Address2').val();
                if (Address != undefined) {


                    if ($('#Address2').val().length < 1) {
                        toastr.error('Please Enter City');
                        validate = false;
                    }
                }




                if (validate) {
                    $('#p4msg2').html('');


                    if (code != "") {
                        $.ajax({
                            type: "POST",
                            contentType: false,
                            processData: false,

                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber2').val() + "&vCode=" + $('.codeone3').val() + '&Address=' + $('#Address2').val() + '&name=' + $('#Name2').val() + '&comp=Chase2Fit',

                            success: function (data) {
                                debugger;
                                if (data.split('~')[0] !== "failure") {
                                    window.scrollTo(0, 0);
                                    $('#container5').hide();
                                    $('#Chkfields').hide();


                                    //var input = document.getElementById("ShowMessage").focus();
                                    //var input1 = document.getElementById("p4msg").focus();
                                    $('#ShowMessage2').show();

                                    $('#p4msg2').focus();

                                    if (data.indexOf("not valid") !== -1) {
                                        data = data.split(".")[0];
                                    }

                                    $('#chkLine').hide();
                                    $('#p4msg2').html(data.split('~')[1]);

                                    $('#p4msg2:contains("not")').css('color', 'white');





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

                    $('#btnsubmit2').attr('disabled', false);

                }

            });

            $('#btnNext').click(function () {
                window.location.href = '<%=ProjectSession.absoluteSiteBrowseUrl%>';
            });


        });

        function validateEmail(email) {
            var re = /\S+@\S+\.\S+/;
            return re.test(email);
        }


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

            //if ($('#' + cntrl_id).val().length == 0) {

            //    if (parseInt(evt.key) >= 6)
            //        return true;

            //}
            //else if (charCode >= 48 && charCode <= 57)
            //    return true;
            //if ($('#' + cntrl_id).val().length > 10) {

            //   return false;

            //}
            //if (charCode >= 96 && charCode <= 105) {
            //    return true;
            //}

            //if (charCode == 8)
            //    return true;
            //if (charCode == 46)
            //    return false;

            //return false;

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
</head>
<body>


    <form id="form1" runat="server">

        <asp:HiddenField ID="hdnmob" runat="server" />
        <asp:HiddenField ID="HdnID" runat="server" />
        <asp:HiddenField ID="HdnCode1" runat="server" />
        <asp:HiddenField ID="HdnCode2" runat="server" />
        <asp:HiddenField ID="long" runat="server" />
        <asp:HiddenField ID="lat" runat="server" />

        <!---=====start-of-FB Winow============-->
        <div class="bg-fixed">
            <div class="custom_col-container container-fluid">
                <div class="row">
                    <div class="col-md-12 pt-4">
                        <div class="logo-nutrition">
                            <img src="../assets/images/logo-fb-nuitrition.png" class="img-fluid" />
                        </div>
                    </div>
                </div>

                <div class="row align-items-center justify-content-center">
                    <div class="col-lg-6 mt-3">
                        <div>
                            <img src="assets/images/body-builder.png" class="img-fluid" />
                        </div>
                    </div>
                    <div class="col-lg-6 mt-3">

                        <div class="max-box mb-3">
                            <h1>Be Strong to<span> Stay Long</span></h1>
                        </div>
                        <div class="formBox-input" style="padding: 2%;">
                            <div id="container2">
                                <h2>To Check Authenticity of Product</h2>

                                <div id="step1">
                                    <div class="form-group">
                                        <input type="text" class="input1 step1 form-control codeone" required="" value="" data-msg-required="Please enter Code." maxlength="13" autofocus="autofocus" data-inputmask="'mask': '99999 9999 9999'" />
                                        <span class="highlight"></span>
                                        <span class="bar"></span>
                                        <label>Enter the Code/कोड भरें</label>
                                    </div>
                                </div>

                                <div id="step2">
                                    <p id="p3msg" class="displayNone" style="margin-top: 5px; color: red;"></p>
                                    <br />
                                    <div class="form-group" style="margin-top: -3%;">
                                        <label>Enter mobile number</label>
                                        <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control mobile_num step2" name="number" id="mobile" onkeypress="return isNumber(event,'mobile')" onkeydown="return isNumber(event,'mobile')" required />
                                    </div>
                                </div>
                                <%--<div class="">
                                    <input type="button" value="Submit" class="btn btn-primary" name="" />

                                </div>


                                <div class="row" id="p1msgmodal" style="display: none;">
                                    <div class="col-md-12 hintline mb-0">
                                        <div class="code-message mb-0">
                                            <p style="color: white !important;" id="p1msg"></p>
                                        </div>
                                    </div>
                                </div>

                                <%--<div class="checkcode" id="checkcode2" style="display: none">
                                    <div class="row">
                                        <div class="col-md-12 hintline" style="text-align: center;">
                                            <img src="../images/loading.gif" alt="loader" style="max-width: 100%;">
                                        </div>
                                    </div>
                                </div>--%>


                                <div class="row" id="p1msgmodal" style="display: none;">
                                    <div class="col-md-12 hintline mb-0">
                                        <div class="code-message mb-0">
                                            <p style="color: white !important;" id="p1msg"></p>
                                        </div>
                                    </div>
                                </div>



                            </div>
                        </div>


                        <div class="text-center mt-3 productImg">
                            <img src="assets/images/fb-products.png" class="img-fluid" />
                        </div>
                    </div>



                </div>

            </div>


            <div class="icon-colauthentic">
                <div class="row align-content-center justify-content-center">
                    <div class="col-md-3 mb-2 text-center">
                        <div class="gap">
                            <h3>Products<br />
                                Authentication Tips</h3>

                        </div>
                    </div>
                    <div class="col-md-3 mt-3 text-center">
                        <div class="rouded-effects">
                            <svg xmlns="http://www.w3.org/2000/svg" width="52.325" height="52.086" viewBox="0 0 52.325 52.086">
                                <path id="prefix__Shape_3" fill="#dc3545" d="M351.885 1263.9a.823.823 0 0 1 .823-.819 8.785 8.785 0 0 0 3.538-.983.766.766 0 0 1 1.069.246.905.905 0 0 1-.329 1.147 9.921 9.921 0 0 1-4.279 1.229.883.883 0 0 1-.822-.82zm-7.322.819a.819.819 0 1 1 0-1.638h4.113a.819.819 0 1 1 0 1.638zm-8.145-.082h-17.77a9.178 9.178 0 0 1-9.213-9.173v-33.658a9.178 9.178 0 0 1 9.213-9.173h33.894a9.178 9.178 0 0 1 9.214 9.173v17.771c0 .082 0 .164-.082.082a.3.3 0 0 1 .082.246v4.1a.823.823 0 0 1-1.645 0v-2.539L338.476 1263h2.056a.819.819 0 1 1 0 1.638zm-25.338-42.831v33.74a7.411 7.411 0 0 0 7.568 7.453h17.03v-15.151a9.178 9.178 0 0 1 9.213-9.173h15.139v-16.87a7.532 7.532 0 0 0-7.569-7.535h-33.812a7.531 7.531 0 0 0-7.568 7.537zm26.243 26.124v14l21.637-21.53h-14.068a7.532 7.532 0 0 0-7.568 7.531zm21.8 12.857a.8.8 0 0 1-.165-1.147 7.444 7.444 0 0 0 1.152-3.44.893.893 0 0 1 .9-.737.647.647 0 0 1 .576.9 8.434 8.434 0 0 1-1.4 4.177.838.838 0 0 1-.658.41 1.4 1.4 0 0 1-.404-.162zm1.805-7.7a.82.82 0 0 1-.82-.82v-4.09a.819.819 0 0 1 .82-.82h.01a.82.82 0 0 1 .821.82v4.09a.82.82 0 0 1-.821.82z" data-name="Shape 3" transform="translate(-309.435 -1212.634)" />
                            </svg>
                            <p>Only accept products with an authentication sticker</p>
                        </div>
                    </div>
                    <div class="col-md-3 mt-3 text-center">
                        <div class="rouded-effects">

                            <svg xmlns="http://www.w3.org/2000/svg" width="53.45" height="53.207" viewBox="0 0 53.45 53.207">
                                <path id="prefix__Shape_4" fill="#dc3545" d="M635.111 1261.1l3.791-3.47a21.959 21.959 0 0 0 33.44-18.6 21.658 21.658 0 0 0-2.357-9.842l3.512-3.213a26.386 26.386 0 0 1 3.561 13.263 26.745 26.745 0 0 1-41.947 21.862zm-9.894-1.762l13.019-11.91v-12.386a7.3 7.3 0 0 1 4.64-6.8.544.544 0 0 0 .345-.5v-.764a.828.828 0 0 1-.767-.8v-1.719a1.193 1.193 0 0 1 1.189-1.184h13.342a1.192 1.192 0 0 1 1.188 1.184v1.719a.827.827 0 0 1-.767.8v.764a.527.527 0 0 0 .346.5 7.456 7.456 0 0 1 .959.455l14.054-12.857 3.434 3.72-14.219 13.007a7.533 7.533 0 0 1 .448 2.474v13.791a4.141 4.141 0 0 1-4.141 4.126h-15.909a4.119 4.119 0 0 1-2.078-.558l-11.649 10.656zm17.16-7.142h15.873a3.447 3.447 0 0 0 3.336-2.751h-18.053l-2.635 2.41a3.361 3.361 0 0 0 1.48.339zm19.247-3.591V1235a6.661 6.661 0 0 0-.268-1.864l-6.761 6.185a6.369 6.369 0 0 1 .7 2.25.927.927 0 0 1 .115 1.069 1.1 1.1 0 0 1-.843.611 6.6 6.6 0 0 1-3.949 1.375 5.445 5.445 0 0 1-1.577-.228l-4.593 4.2zM639 1235.041v11.684l6.506-5.951a.665.665 0 0 1-.486 0 .37.37 0 0 1-.038-.535 2.512 2.512 0 0 1 1.878-.955 2.072 2.072 0 0 1 .246.029l1.7-1.557a1.2 1.2 0 0 1-.261-.076c-.115-.038-.269-.077-.383-.114a1.231 1.231 0 0 1-.844-.458 1.107 1.107 0 0 1 .154-1.261v-.076a1.242 1.242 0 0 1 .383-.879c.115-.076.192-.191.307-.267a1.66 1.66 0 0 1 1.61-.305 6.209 6.209 0 0 1 1.693 1.005l3.479-3.182h-15.25a6.235 6.235 0 0 0-.694 2.898zm11.578 8.825a6.045 6.045 0 0 0 3.566-1.261.7.7 0 0 1 .268-.077.344.344 0 0 0 .307-.192c.076-.152.076-.229 0-.267a.469.469 0 0 1-.153-.305 5.493 5.493 0 0 0-.539-1.926l-4.329 3.96a5.328 5.328 0 0 0 .884.069zm-4.945-3.209l.453-.414a3.154 3.154 0 0 0-.449.414zm3.067-5.5c-.076.077-.192.152-.268.23a.432.432 0 0 0-.115.305.862.862 0 0 1-.268.65.8.8 0 0 0 0 .305 1.155 1.155 0 0 0 .383.153 2.139 2.139 0 0 1 .46.153.947.947 0 0 0 .805-.115.764.764 0 0 1 .375-.24l.871-.8a4.625 4.625 0 0 0-1.4-.834.946.946 0 0 0-.26-.036.819.819 0 0 0-.583.228zm-4.716-7.411a1.329 1.329 0 0 1-.843 1.223 6.358 6.358 0 0 0-3.029 2.444h15.628l2.362-2.161a6.337 6.337 0 0 0-.622-.284 1.33 1.33 0 0 1-.843-1.223v-.764h-12.649zm-.767-3.324h.039v1.72a.037.037 0 0 0 .038.038h14.072a.037.037 0 0 0 .038-.038v-1.72a.425.425 0 0 0-.421-.42h-13.34a.425.425 0 0 0-.422.419zm-19.613 14.816a26.747 26.747 0 0 1 42.565-21.425l-3.442 3.151a21.959 21.959 0 0 0-34.268 18.067 21.643 21.643 0 0 0 2.821 10.708l-3.73 3.414a26.393 26.393 0 0 1-3.942-13.916z" data-name="Shape 4" transform="translate(-623.608 -1212.633)" />
                            </svg>
                            <p>Don’t accept products with stickers that have been scratched off</p>
                        </div>
                    </div>
                    <div class="col-md-3 mt-3 text-center">
                        <div class="rouded-effects">
                            <svg xmlns="http://www.w3.org/2000/svg" width="54.01" height="53.768" viewBox="0 0 54.01 53.768">
                                <path id="prefix__Shape_6" fill="#dc3545" d="M929.623 1265.841a2.26 2.26 0 0 1-1.728-.8 2.206 2.206 0 0 1-.495-1.8l3.282-17.932v-29.692a3.573 3.573 0 0 1 3.593-3.546h40.354a3.574 3.574 0 0 1 3.593 3.546v29.695l3.128 17.938a2.214 2.214 0 0 1-.5 1.8 2.265 2.265 0 0 1-1.723.79zm-.895-2.366a.853.853 0 0 0 .2.7.912.912 0 0 0 .7.32h49.5a.913.913 0 0 0 .695-.318.859.859 0 0 0 .2-.706l-.44-2.524h-50.392zm42.649-3.869h7.967l-.63-3.613h-7.667zm-10.319 0h8.964l-.33-3.613h-8.8zm-11.639 0h10.288l-.165-3.613h-9.958zm-10.315 0h8.964l.165-3.613h-8.8zm-9.668 0h8.312l.33-3.613H930.1zm41.488-4.957h7.556l-.63-3.612h-7.256zm-10.094 0h8.738l-.329-3.612h-8.573zm-11.186 0h9.835l-.165-3.612h-9.5zm-10.088 0h8.737l.166-3.612h-8.572zm-9.213 0h7.857l.33-3.612h-7.527zm40.128-4.956h7.143l-.636-3.648h-6.84zm-9.867 0h8.511l-.333-3.648h-8.345zm-10.733 0h9.383l-.167-3.648h-9.049zm-9.862 0h8.511l.167-3.648h-8.345zm-8.758 0h7.4l.333-3.648h-7.068zm.779-4.992h44.841v-26.726h-44.84zm0-29.081v1.01h44.841v-1.01a2.226 2.226 0 0 0-2.243-2.2h-40.353a2.226 2.226 0 0 0-2.244 2.199zm25.831 23.791a2.723 2.723 0 1 1 2.723 2.714 2.721 2.721 0 0 1-2.722-2.715zm1.349 0a1.374 1.374 0 1 0 1.374-1.368 1.373 1.373 0 0 0-1.373 1.367zm-10.624 0a2.723 2.723 0 1 1 2.723 2.714 2.721 2.721 0 0 1-2.722-2.715zm1.349 0a1.374 1.374 0 1 0 1.374-1.368 1.373 1.373 0 0 0-1.373 1.367zm-2.714-3.948a.675.675 0 0 1-.671-.59l-1.6-12.976h-1.483a.672.672 0 1 1 0-1.345h2.08a.674.674 0 0 1 .67.59l.261 2.126h18.795a.673.673 0 0 1 .672.732l-.978 10.851a.674.674 0 0 1-.672.612zm.6-1.344h15.863l.857-9.508h-17.894z" data-name="Shape 6" transform="translate(-927.368 -1212.073)" />
                            </svg>
                            <p>Only buy from authorized retailers</p>
                        </div>
                    </div>
                </div>
                <div class="footer-bot">


                    <%--<div><a href="https://fbnutrition.com/" target="_blank">fbnutrition.com</a></div>--%>
                    <div class="socialicon">
                        <ul>
                            <li>
                                <a href="https://www.facebook.com/FitnessBuzzNutrition/" target="_blank" class="facebook icon-bg icon-bg-sm">
                                    <i class="mdi mdi-facebook"></i>
                                </a>
                            </li>

                            <li>
                                <a href="https://www.instagram.com/fitnessbuzznutrition/" target="_blank" class="instagram icon-bg icon-bg-sm">
                                    <i class="mdi mdi-instagram"></i>
                                </a>
                            </li>

                            <li>
                                <a href="https://www.youtube.com/channel/UCx8GqC0b5KXBdQgipjvz2_w/featured" target="_blank" class="ytube icon-bg icon-bg-sm">
                                    <i class="mdi mdi-youtube"></i>
                                </a>
                            </li>
                        </ul>

                    </div>
                    <div class="row">

                        <div class="col-12">

                            <a href="https://fbnutrition.com/" target="_blank">fbnutrition.com</a>
                        </div>
                    </div>




                </div>
            </div>



        </div>
        <!---=====end-of-FB Winow============-->

        <!---=====start-of-Royal Winow============-->
        <div class="bg-fixed-1">
            <div class="custom_col-container container-fluid content-over">

                <div class="row align-items-center justify-content-start">

                    <div class="col-md-4 mt-3">
                        <div class="formBox-input">

                            <div id="Royal" style="padding: 3%; margin-top: 5rem !important;">
                            </div>

                        </div>
                    </div>

                    <div class="col-lg-6 mt-3 offset-md-2">
                        <div class="royal-box">
                            <h1>Be Strong to<span> Stay Long</span></h1>
                        </div>


                        <div class="royalproduct">
                            <img src="assets/images/royal-products.png" class="img-fluid" />
                        </div>
                    </div>

                </div>
                <!--end-of-first-row-->
                <div class="icon-colauthentic absolute">
                    <div class="row align-content-center justify-content-center">
                        <div class="col-md-3 mb-2 text-center">
                            <div class="gap">
                                <h3>Products<br />
                                    Authentication Tips</h3>

                            </div>
                        </div>
                        <div class="col-md-3 mt-3 text-center">
                            <div class="rouded-effects-1">
                                <svg xmlns="http://www.w3.org/2000/svg" width="52.325" height="52.086" viewBox="0 0 52.325 52.086">
                                    <path id="prefix__Shape_3" fill="#dc3545" d="M351.885 1263.9a.823.823 0 0 1 .823-.819 8.785 8.785 0 0 0 3.538-.983.766.766 0 0 1 1.069.246.905.905 0 0 1-.329 1.147 9.921 9.921 0 0 1-4.279 1.229.883.883 0 0 1-.822-.82zm-7.322.819a.819.819 0 1 1 0-1.638h4.113a.819.819 0 1 1 0 1.638zm-8.145-.082h-17.77a9.178 9.178 0 0 1-9.213-9.173v-33.658a9.178 9.178 0 0 1 9.213-9.173h33.894a9.178 9.178 0 0 1 9.214 9.173v17.771c0 .082 0 .164-.082.082a.3.3 0 0 1 .082.246v4.1a.823.823 0 0 1-1.645 0v-2.539L338.476 1263h2.056a.819.819 0 1 1 0 1.638zm-25.338-42.831v33.74a7.411 7.411 0 0 0 7.568 7.453h17.03v-15.151a9.178 9.178 0 0 1 9.213-9.173h15.139v-16.87a7.532 7.532 0 0 0-7.569-7.535h-33.812a7.531 7.531 0 0 0-7.568 7.537zm26.243 26.124v14l21.637-21.53h-14.068a7.532 7.532 0 0 0-7.568 7.531zm21.8 12.857a.8.8 0 0 1-.165-1.147 7.444 7.444 0 0 0 1.152-3.44.893.893 0 0 1 .9-.737.647.647 0 0 1 .576.9 8.434 8.434 0 0 1-1.4 4.177.838.838 0 0 1-.658.41 1.4 1.4 0 0 1-.404-.162zm1.805-7.7a.82.82 0 0 1-.82-.82v-4.09a.819.819 0 0 1 .82-.82h.01a.82.82 0 0 1 .821.82v4.09a.82.82 0 0 1-.821.82z" data-name="Shape 3" transform="translate(-309.435 -1212.634)" />
                                </svg>
                                <p>Only accept products with an authentication sticker</p>
                            </div>
                        </div>
                        <div class="col-md-3 mt-3 text-center">
                            <div class="rouded-effects-1">

                                <svg xmlns="http://www.w3.org/2000/svg" width="53.45" height="53.207" viewBox="0 0 53.45 53.207">
                                    <path id="prefix__Shape_4" fill="#dc3545" d="M635.111 1261.1l3.791-3.47a21.959 21.959 0 0 0 33.44-18.6 21.658 21.658 0 0 0-2.357-9.842l3.512-3.213a26.386 26.386 0 0 1 3.561 13.263 26.745 26.745 0 0 1-41.947 21.862zm-9.894-1.762l13.019-11.91v-12.386a7.3 7.3 0 0 1 4.64-6.8.544.544 0 0 0 .345-.5v-.764a.828.828 0 0 1-.767-.8v-1.719a1.193 1.193 0 0 1 1.189-1.184h13.342a1.192 1.192 0 0 1 1.188 1.184v1.719a.827.827 0 0 1-.767.8v.764a.527.527 0 0 0 .346.5 7.456 7.456 0 0 1 .959.455l14.054-12.857 3.434 3.72-14.219 13.007a7.533 7.533 0 0 1 .448 2.474v13.791a4.141 4.141 0 0 1-4.141 4.126h-15.909a4.119 4.119 0 0 1-2.078-.558l-11.649 10.656zm17.16-7.142h15.873a3.447 3.447 0 0 0 3.336-2.751h-18.053l-2.635 2.41a3.361 3.361 0 0 0 1.48.339zm19.247-3.591V1235a6.661 6.661 0 0 0-.268-1.864l-6.761 6.185a6.369 6.369 0 0 1 .7 2.25.927.927 0 0 1 .115 1.069 1.1 1.1 0 0 1-.843.611 6.6 6.6 0 0 1-3.949 1.375 5.445 5.445 0 0 1-1.577-.228l-4.593 4.2zM639 1235.041v11.684l6.506-5.951a.665.665 0 0 1-.486 0 .37.37 0 0 1-.038-.535 2.512 2.512 0 0 1 1.878-.955 2.072 2.072 0 0 1 .246.029l1.7-1.557a1.2 1.2 0 0 1-.261-.076c-.115-.038-.269-.077-.383-.114a1.231 1.231 0 0 1-.844-.458 1.107 1.107 0 0 1 .154-1.261v-.076a1.242 1.242 0 0 1 .383-.879c.115-.076.192-.191.307-.267a1.66 1.66 0 0 1 1.61-.305 6.209 6.209 0 0 1 1.693 1.005l3.479-3.182h-15.25a6.235 6.235 0 0 0-.694 2.898zm11.578 8.825a6.045 6.045 0 0 0 3.566-1.261.7.7 0 0 1 .268-.077.344.344 0 0 0 .307-.192c.076-.152.076-.229 0-.267a.469.469 0 0 1-.153-.305 5.493 5.493 0 0 0-.539-1.926l-4.329 3.96a5.328 5.328 0 0 0 .884.069zm-4.945-3.209l.453-.414a3.154 3.154 0 0 0-.449.414zm3.067-5.5c-.076.077-.192.152-.268.23a.432.432 0 0 0-.115.305.862.862 0 0 1-.268.65.8.8 0 0 0 0 .305 1.155 1.155 0 0 0 .383.153 2.139 2.139 0 0 1 .46.153.947.947 0 0 0 .805-.115.764.764 0 0 1 .375-.24l.871-.8a4.625 4.625 0 0 0-1.4-.834.946.946 0 0 0-.26-.036.819.819 0 0 0-.583.228zm-4.716-7.411a1.329 1.329 0 0 1-.843 1.223 6.358 6.358 0 0 0-3.029 2.444h15.628l2.362-2.161a6.337 6.337 0 0 0-.622-.284 1.33 1.33 0 0 1-.843-1.223v-.764h-12.649zm-.767-3.324h.039v1.72a.037.037 0 0 0 .038.038h14.072a.037.037 0 0 0 .038-.038v-1.72a.425.425 0 0 0-.421-.42h-13.34a.425.425 0 0 0-.422.419zm-19.613 14.816a26.747 26.747 0 0 1 42.565-21.425l-3.442 3.151a21.959 21.959 0 0 0-34.268 18.067 21.643 21.643 0 0 0 2.821 10.708l-3.73 3.414a26.393 26.393 0 0 1-3.942-13.916z" data-name="Shape 4" transform="translate(-623.608 -1212.633)" />
                                </svg>
                                <p>Don’t accept products with stickers that have been scratched off</p>
                            </div>
                        </div>
                        <div class="col-md-3 mt-3 text-center">
                            <div class="rouded-effects-1">
                                <svg xmlns="http://www.w3.org/2000/svg" width="54.01" height="53.768" viewBox="0 0 54.01 53.768">
                                    <path id="prefix__Shape_6" fill="#dc3545" d="M929.623 1265.841a2.26 2.26 0 0 1-1.728-.8 2.206 2.206 0 0 1-.495-1.8l3.282-17.932v-29.692a3.573 3.573 0 0 1 3.593-3.546h40.354a3.574 3.574 0 0 1 3.593 3.546v29.695l3.128 17.938a2.214 2.214 0 0 1-.5 1.8 2.265 2.265 0 0 1-1.723.79zm-.895-2.366a.853.853 0 0 0 .2.7.912.912 0 0 0 .7.32h49.5a.913.913 0 0 0 .695-.318.859.859 0 0 0 .2-.706l-.44-2.524h-50.392zm42.649-3.869h7.967l-.63-3.613h-7.667zm-10.319 0h8.964l-.33-3.613h-8.8zm-11.639 0h10.288l-.165-3.613h-9.958zm-10.315 0h8.964l.165-3.613h-8.8zm-9.668 0h8.312l.33-3.613H930.1zm41.488-4.957h7.556l-.63-3.612h-7.256zm-10.094 0h8.738l-.329-3.612h-8.573zm-11.186 0h9.835l-.165-3.612h-9.5zm-10.088 0h8.737l.166-3.612h-8.572zm-9.213 0h7.857l.33-3.612h-7.527zm40.128-4.956h7.143l-.636-3.648h-6.84zm-9.867 0h8.511l-.333-3.648h-8.345zm-10.733 0h9.383l-.167-3.648h-9.049zm-9.862 0h8.511l.167-3.648h-8.345zm-8.758 0h7.4l.333-3.648h-7.068zm.779-4.992h44.841v-26.726h-44.84zm0-29.081v1.01h44.841v-1.01a2.226 2.226 0 0 0-2.243-2.2h-40.353a2.226 2.226 0 0 0-2.244 2.199zm25.831 23.791a2.723 2.723 0 1 1 2.723 2.714 2.721 2.721 0 0 1-2.722-2.715zm1.349 0a1.374 1.374 0 1 0 1.374-1.368 1.373 1.373 0 0 0-1.373 1.367zm-10.624 0a2.723 2.723 0 1 1 2.723 2.714 2.721 2.721 0 0 1-2.722-2.715zm1.349 0a1.374 1.374 0 1 0 1.374-1.368 1.373 1.373 0 0 0-1.373 1.367zm-2.714-3.948a.675.675 0 0 1-.671-.59l-1.6-12.976h-1.483a.672.672 0 1 1 0-1.345h2.08a.674.674 0 0 1 .67.59l.261 2.126h18.795a.673.673 0 0 1 .672.732l-.978 10.851a.674.674 0 0 1-.672.612zm.6-1.344h15.863l.857-9.508h-17.894z" data-name="Shape 6" transform="translate(-927.368 -1212.073)" />
                                </svg>
                                <p>Only buy from authorized retailers</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!---=====end-of-Royal Winow============-->

        <!--========start-pronutrition-window============--->
        <div class="w2rapper">
            <div class="gurukripa-bg">
                <div class="custom_col-container-1 container-fluid">
                    <div class="row">
                        <div class="col-md-12 pt-4 animated fadeInDown">
                            <div class="logo-pronutrition">
                                <img src="../assets/images/gurukripa/logo-pronutrition.png" class="img-fluid" />
                            </div>
                        </div>
                    </div>

                    <div class="row align-items-center justify-content-center">
                        <div class="col-lg-6">
                            <div class="animated fadeInLeft">
                                <img src="assets/images/gurukripa/body-push-up.png" class="img-fluid" />
                            </div>
                        </div>
                        <div class="col-lg-6 animated bounceIn">

                            <div class="formax-box mb-3">
                                <h1><span>Pro</span> Nutrition</h1>
                                <div class="form-checkcode">

                                    <div id="GuruKripa">
                                    </div>
                                </div>

                            </div>



                            <!--<div class="text-center mt-3 productImg">
                            <img src="assets/images/fb-products.png" class="img-fluid">
                        </div>-->


                        </div>

                    </div>


                    <div class="icon_pauthentic">
                        <div class="row align-content-center justify-content-center">
                            <div class="col-md-3 text-center">
                                <div class="gap">
                                    <h3>Products<br>
                                        Authentication Tips</h3>

                                </div>
                            </div>
                            <div class="col-md-3 mt-3 text-center animated fadeInDown">
                                <div class="radius-effect">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="52.325" height="52.086" viewBox="0 0 52.325 52.086">
                                        <path id="prefix__Shape_3" fill="#dc3545" d="M351.885 1263.9a.823.823 0 0 1 .823-.819 8.785 8.785 0 0 0 3.538-.983.766.766 0 0 1 1.069.246.905.905 0 0 1-.329 1.147 9.921 9.921 0 0 1-4.279 1.229.883.883 0 0 1-.822-.82zm-7.322.819a.819.819 0 1 1 0-1.638h4.113a.819.819 0 1 1 0 1.638zm-8.145-.082h-17.77a9.178 9.178 0 0 1-9.213-9.173v-33.658a9.178 9.178 0 0 1 9.213-9.173h33.894a9.178 9.178 0 0 1 9.214 9.173v17.771c0 .082 0 .164-.082.082a.3.3 0 0 1 .082.246v4.1a.823.823 0 0 1-1.645 0v-2.539L338.476 1263h2.056a.819.819 0 1 1 0 1.638zm-25.338-42.831v33.74a7.411 7.411 0 0 0 7.568 7.453h17.03v-15.151a9.178 9.178 0 0 1 9.213-9.173h15.139v-16.87a7.532 7.532 0 0 0-7.569-7.535h-33.812a7.531 7.531 0 0 0-7.568 7.537zm26.243 26.124v14l21.637-21.53h-14.068a7.532 7.532 0 0 0-7.568 7.531zm21.8 12.857a.8.8 0 0 1-.165-1.147 7.444 7.444 0 0 0 1.152-3.44.893.893 0 0 1 .9-.737.647.647 0 0 1 .576.9 8.434 8.434 0 0 1-1.4 4.177.838.838 0 0 1-.658.41 1.4 1.4 0 0 1-.404-.162zm1.805-7.7a.82.82 0 0 1-.82-.82v-4.09a.819.819 0 0 1 .82-.82h.01a.82.82 0 0 1 .821.82v4.09a.82.82 0 0 1-.821.82z" data-name="Shape 3" transform="translate(-309.435 -1212.634)"></path>
                                    </svg>
                                    <p>Only accept products with an authentication sticker</p>
                                </div>
                            </div>
                            <div class="col-md-3 mt-3 text-center animated fadeInUp">
                                <div class="radius-effect">

                                    <svg xmlns="http://www.w3.org/2000/svg" width="53.45" height="53.207" viewBox="0 0 53.45 53.207">
                                        <path id="prefix__Shape_4" fill="#dc3545" d="M635.111 1261.1l3.791-3.47a21.959 21.959 0 0 0 33.44-18.6 21.658 21.658 0 0 0-2.357-9.842l3.512-3.213a26.386 26.386 0 0 1 3.561 13.263 26.745 26.745 0 0 1-41.947 21.862zm-9.894-1.762l13.019-11.91v-12.386a7.3 7.3 0 0 1 4.64-6.8.544.544 0 0 0 .345-.5v-.764a.828.828 0 0 1-.767-.8v-1.719a1.193 1.193 0 0 1 1.189-1.184h13.342a1.192 1.192 0 0 1 1.188 1.184v1.719a.827.827 0 0 1-.767.8v.764a.527.527 0 0 0 .346.5 7.456 7.456 0 0 1 .959.455l14.054-12.857 3.434 3.72-14.219 13.007a7.533 7.533 0 0 1 .448 2.474v13.791a4.141 4.141 0 0 1-4.141 4.126h-15.909a4.119 4.119 0 0 1-2.078-.558l-11.649 10.656zm17.16-7.142h15.873a3.447 3.447 0 0 0 3.336-2.751h-18.053l-2.635 2.41a3.361 3.361 0 0 0 1.48.339zm19.247-3.591V1235a6.661 6.661 0 0 0-.268-1.864l-6.761 6.185a6.369 6.369 0 0 1 .7 2.25.927.927 0 0 1 .115 1.069 1.1 1.1 0 0 1-.843.611 6.6 6.6 0 0 1-3.949 1.375 5.445 5.445 0 0 1-1.577-.228l-4.593 4.2zM639 1235.041v11.684l6.506-5.951a.665.665 0 0 1-.486 0 .37.37 0 0 1-.038-.535 2.512 2.512 0 0 1 1.878-.955 2.072 2.072 0 0 1 .246.029l1.7-1.557a1.2 1.2 0 0 1-.261-.076c-.115-.038-.269-.077-.383-.114a1.231 1.231 0 0 1-.844-.458 1.107 1.107 0 0 1 .154-1.261v-.076a1.242 1.242 0 0 1 .383-.879c.115-.076.192-.191.307-.267a1.66 1.66 0 0 1 1.61-.305 6.209 6.209 0 0 1 1.693 1.005l3.479-3.182h-15.25a6.235 6.235 0 0 0-.694 2.898zm11.578 8.825a6.045 6.045 0 0 0 3.566-1.261.7.7 0 0 1 .268-.077.344.344 0 0 0 .307-.192c.076-.152.076-.229 0-.267a.469.469 0 0 1-.153-.305 5.493 5.493 0 0 0-.539-1.926l-4.329 3.96a5.328 5.328 0 0 0 .884.069zm-4.945-3.209l.453-.414a3.154 3.154 0 0 0-.449.414zm3.067-5.5c-.076.077-.192.152-.268.23a.432.432 0 0 0-.115.305.862.862 0 0 1-.268.65.8.8 0 0 0 0 .305 1.155 1.155 0 0 0 .383.153 2.139 2.139 0 0 1 .46.153.947.947 0 0 0 .805-.115.764.764 0 0 1 .375-.24l.871-.8a4.625 4.625 0 0 0-1.4-.834.946.946 0 0 0-.26-.036.819.819 0 0 0-.583.228zm-4.716-7.411a1.329 1.329 0 0 1-.843 1.223 6.358 6.358 0 0 0-3.029 2.444h15.628l2.362-2.161a6.337 6.337 0 0 0-.622-.284 1.33 1.33 0 0 1-.843-1.223v-.764h-12.649zm-.767-3.324h.039v1.72a.037.037 0 0 0 .038.038h14.072a.037.037 0 0 0 .038-.038v-1.72a.425.425 0 0 0-.421-.42h-13.34a.425.425 0 0 0-.422.419zm-19.613 14.816a26.747 26.747 0 0 1 42.565-21.425l-3.442 3.151a21.959 21.959 0 0 0-34.268 18.067 21.643 21.643 0 0 0 2.821 10.708l-3.73 3.414a26.393 26.393 0 0 1-3.942-13.916z" data-name="Shape 4" transform="translate(-623.608 -1212.633)"></path>
                                    </svg>
                                    <p>Don’t accept products with stickers that have been scratched off</p>
                                </div>
                            </div>
                            <div class="col-md-3 mt-3 text-center animated fadeInDown">
                                <div class="radius-effect">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="54.01" height="53.768" viewBox="0 0 54.01 53.768">
                                        <path id="prefix__Shape_6" fill="#dc3545" d="M929.623 1265.841a2.26 2.26 0 0 1-1.728-.8 2.206 2.206 0 0 1-.495-1.8l3.282-17.932v-29.692a3.573 3.573 0 0 1 3.593-3.546h40.354a3.574 3.574 0 0 1 3.593 3.546v29.695l3.128 17.938a2.214 2.214 0 0 1-.5 1.8 2.265 2.265 0 0 1-1.723.79zm-.895-2.366a.853.853 0 0 0 .2.7.912.912 0 0 0 .7.32h49.5a.913.913 0 0 0 .695-.318.859.859 0 0 0 .2-.706l-.44-2.524h-50.392zm42.649-3.869h7.967l-.63-3.613h-7.667zm-10.319 0h8.964l-.33-3.613h-8.8zm-11.639 0h10.288l-.165-3.613h-9.958zm-10.315 0h8.964l.165-3.613h-8.8zm-9.668 0h8.312l.33-3.613H930.1zm41.488-4.957h7.556l-.63-3.612h-7.256zm-10.094 0h8.738l-.329-3.612h-8.573zm-11.186 0h9.835l-.165-3.612h-9.5zm-10.088 0h8.737l.166-3.612h-8.572zm-9.213 0h7.857l.33-3.612h-7.527zm40.128-4.956h7.143l-.636-3.648h-6.84zm-9.867 0h8.511l-.333-3.648h-8.345zm-10.733 0h9.383l-.167-3.648h-9.049zm-9.862 0h8.511l.167-3.648h-8.345zm-8.758 0h7.4l.333-3.648h-7.068zm.779-4.992h44.841v-26.726h-44.84zm0-29.081v1.01h44.841v-1.01a2.226 2.226 0 0 0-2.243-2.2h-40.353a2.226 2.226 0 0 0-2.244 2.199zm25.831 23.791a2.723 2.723 0 1 1 2.723 2.714 2.721 2.721 0 0 1-2.722-2.715zm1.349 0a1.374 1.374 0 1 0 1.374-1.368 1.373 1.373 0 0 0-1.373 1.367zm-10.624 0a2.723 2.723 0 1 1 2.723 2.714 2.721 2.721 0 0 1-2.722-2.715zm1.349 0a1.374 1.374 0 1 0 1.374-1.368 1.373 1.373 0 0 0-1.373 1.367zm-2.714-3.948a.675.675 0 0 1-.671-.59l-1.6-12.976h-1.483a.672.672 0 1 1 0-1.345h2.08a.674.674 0 0 1 .67.59l.261 2.126h18.795a.673.673 0 0 1 .672.732l-.978 10.851a.674.674 0 0 1-.672.612zm.6-1.344h15.863l.857-9.508h-17.894z" data-name="Shape 6" transform="translate(-927.368 -1212.073)"></path>
                                    </svg>
                                    <p>Only buy from authorized retailers</p>
                                </div>
                            </div>
                        </div>

                    </div>



                </div>

                <div class="topZig">
                    <img src="assets/images/gurukripa/zig-zag.png" class="img-fluid animated fadeInRight" alt="zig-zag" />
                </div>
                <div class="botZig">
                    <img src="assets/images/gurukripa/zig-zag.png" class="img-fluid  animated fadeInRight" alt="zig-zag" />
                </div>
            </div>
            <!--end-of-gurukripa-->
        </div>
        <!--========start-pronutrition-window end============--->


        <!--========start-MuscleTech-window============--->
        <div class="w2rapper1">
            <div class="muscletech-bg">
                <div class="custom_col-container-1 container-fluid">
                    <div class="row">
                        <div class="col-md-12 pt-4 animated fadeInDown">
                            <div class="logo-pronutrition">
                                <img src="../assets/images/Avataar/imgpsh_fullsize_anim.png" class="img-fluid" />
                            </div>
                        </div>
                    </div>

                    <div class="row align-items-center justify-content-center align-set">
                        <%-- <div class="col-lg-6">
                            <div class="animated fadeInLeft">
                                <img src="assets/images/Avataar/body-builder.png" class="img-fluid" />
                            </div>
                        </div>--%>

                        <div class="col-lg-4 animated bounceIn">

                            <div class="formax-box mb-3">
                                <h1 class="avattar" style="color: white !important; font-size: 2em!important; letter-spacing: 0px;">RECONSTRUCTING<span style="letter-spacing: 0px !important; font-size: 150%;"> NEVER STOPS</span></h1>
                                <div class="form-checkcode" style="margin-bottom: 0px !important;">

                                    <div id="container3">
                                        <h2 class="mt-md-3">To Check Authenticity of Product</h2>


                                        <div id="step3">
                                            <div class="form-group">
                                                <input type="text" class="input1 step1 form-control codeone1" required="" value="" data-msg-required="Please enter Code." maxlength="13" id="forfocus" data-inputmask="'mask': '99999 9999 9999'" />
                                                <span class="highlight"></span>
                                                <span class="bar"></span>
                                                <label>Enter the Code/कोड भरें</label>
                                            </div>
                                        </div>

                                        <div id="step4">

                                            <br />
                                            <div class="form-group" style="margin-top: -3%;">
                                                <input type="text" id="First_Name" placeholder="First Name" data-msg-required="Please Enter Your First Name" maxlength="50" class="form-control" required="" />
                                            </div>

                                            <div class="form-group" style="margin-top: -3%;">
                                                <input type="text" id="Last_Name" placeholder="Last Name" data-msg-required="Please Enter Your Last Name" maxlength="50" class="form-control" required="" />
                                            </div>

                                            <div class="form-group" style="margin-top: -3%;">
                                                <input type="text" id="mobilenumber" maxlength="10" placeholder="Mobile Number" data-msg-required="Please Enter Your Moblie Number" class="form-control" required="" />
                                            </div>

                                            <div class="form-group" style="margin-top: -3%;">
                                                <input type="email" id="EmailAddrs" placeholder="Email Address" data-msg-required="Please enter your Email Address" class="form-control" required="" />
                                            </div>

                                            <div class="form-group" style="margin-top: -3%;">
                                                <input type="text" id="pin" placeholder="Pin" maxlength="6" minlength="6" onkeyup="getaddress()" data-msg-required="Please Enter Your Pin." class="form-control" required="" />
                                            </div>

                                            <div class="form-group" style="margin-top: -3%;">
                                                <input type="text" id="city" placeholder="City" data-msg-required="Please Enter Your City." class="form-control" required="" />
                                            </div>

                                            <div class="form-group" style="margin-top: -3%;">
                                                <input type="text" id="state" placeholder="State"  data-msg-required="Please Enter Your State." class="form-control" required="" />
                                            </div>

                                            <div class="form-group" style="margin-top: -3%;">
                                                <%-- <label for="cars">Purchased From:</label>--%>

                                                <select name="cars" id="ddlpurchasefrm" class="form-control" required="" data-msg-required="Please Select Purchase From" style="color: #014369;">
                                                    <option value="0" selected="selected" disabled="disabled">Purchased From</option>
                                                    <option value="ONLINE – Official Website">ONLINE – Official Website</option>
                                                    <option value="ONLINE – Amazon Marketplace">ONLINE – Amazon Marketplace</option>
                                                    <option value="ONLINE – Flipkart Marketplace">ONLINE – Flipkart Marketplace</option>
                                                    <option value="OFFLINE – Authorised Retail Stores">OFFLINE – Authorised Retail Stores</option>
                                                    <option value="Others">Others</option>
                                                </select>
                                            </div>
                                            <div id="dvother" class="form-group" style="display: none">
                                                <input type="text" class="form-control"  placeholder="Enter Purchase from*" id="txtotherrole" />
                                            </div>
                                            <center>
                                                <button type="button" id="btnsubmit" data-toggle="modal" class="btn toast-success" style="background-color: #fe5a3a !important; font-size: 100%; width: 100%; color: white;">Submit</button>
                                            </center>
                                        </div>

                                    </div>

                                </div>

                                <div style="display: none; padding: 0px !important" id="ShowMessage" class="row no-gutters pl-4 pr-4 textmessage">

                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <p id="p4msg" style="color: white !important; overflow: hidden; font-size: 14px !important;" class="massage_box"></p>
                                        </div>
                                        <%-- <a href="javascript:void(0)" class="next_btn" id="btnNext">Close</a>--%>
                                    </div>


                                </div>

                            </div>

                        </div>


                        <div class="text-center mt-3 productImg">
                            <%-- <img src="assets/images/Avataar/product.png" class="img-fluid" />--%>
                            <img src="assets/images/Avataar/avatar copy.png" class="img-fluid" />
                        </div>
                    </div>

                </div>




                <div class="footer-bot">
                    <div class="socialicon">
                    </div>
                    <div class="row">

                        <div class="col-12">

                            <a href="https://www.avvatarindia.com/" target="_blank">avvatarindia.com</a>
                        </div>
                    </div>

                </div>


            </div>


        </div>
       
        <!--========start-MuscleTech-window end============--->

        <!---=====start-of-Ankerite Window============-->
        <div class="bg-fixed-1" id="RoyalAK" style="display: none;">
            <div class="custom_col-container container-fluid content-over">

                <div class="row">
                    <div class="col-md-12 pt-4">
                        <div class="logo-ankriti">
                            <img src="../assets/images/ankerite/ankerite.png" class="img-fluid" />

                        </div>
                    </div>
                </div>


                <div class="row align-items-center justify-content-start">

                    <div class="col-md-4 mt-3">
                        <div class="formBox-input">

                            <div style="padding: 3%; margin-top: 5rem !important;">
                                <div id="container4">
                                    <h2>To Check Authenticity of Product</h2>

                                    <div id="step5">
                                        <div class="form-group">
                                            <input type="text" class="input1 step1 form-control codeone2" required="" placeholder="Enter 13 Digit Code" value="" data-msg-required="Please enter Code." maxlength="13" id="forfocus" data-inputmask="'mask': '99999 9999 9999'" />

                                        </div>
                                    </div>

                                    <div id="step6">
                                        <br />
                                        <div class="form-group" style="margin-top: -5%;">

                                            <input type="text" id="Name1" placeholder="Name" data-msg-required="Please Enter Your Full Name" maxlength="50" class="form-control" required="" />
                                        </div>



                                        <div class="form-group" style="margin-top: -3%;">

                                            <input type="text" id="mobilenumber1" maxlength="10" placeholder="Mobile Number" data-msg-required="Please Enter Your Moblie Number" class="form-control" required="" />
                                        </div>


                                        <div class="form-group" style="margin-top: -3%;">

                                            <input type="text" id="Address1" placeholder="City" data-msg-required="Please Enter Your City." class="form-control" required="" />
                                        </div>
                                        <button type="button" id="btnsubmit1" data-toggle="modal" class="btn toast-success" style="background-color: #fe5a3a !important; font-size: 100%; color: white;">Submit</button>
                                    </div>
                                </div>

                                <div style="display: none; padding: 0px !important" id="ShowMessage1" class="row no-gutters pl-4 pr-4 textmessage">

                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <p id="p4msg1" style="color: white !important; overflow: hidden; font-size: 14px !important;"></p>
                                        </div>
                                        <%-- <a href="javascript:void(0)" class="next_btn" id="btnNext">Close</a>--%>
                                    </div>


                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 mt-3 offset-md-2">
                        <div class="royalproduct" style="margin-top: 38%;">
                            <img src="assets/images/ankerite/new product.png" class="img-fluid" />
                        </div>
                    </div>

                </div>
                <!--end-of-first-row-->
                <div class="icon-colauthentic absolute">
                    <div class="row align-content-center justify-content-center">
                        <div class="col-md-3 mb-2 text-center">
                            <div class="gap">
                                <h3>Products<br />
                                    Authentication Tips</h3>

                            </div>
                        </div>
                        <div class="col-md-3 mt-3 text-center">
                            <div class="rouded-effects-1">
                                <svg xmlns="http://www.w3.org/2000/svg" width="52.325" height="52.086" viewBox="0 0 52.325 52.086">
                                    <path id="prefix__Shape_3" fill="#dc3545" d="M351.885 1263.9a.823.823 0 0 1 .823-.819 8.785 8.785 0 0 0 3.538-.983.766.766 0 0 1 1.069.246.905.905 0 0 1-.329 1.147 9.921 9.921 0 0 1-4.279 1.229.883.883 0 0 1-.822-.82zm-7.322.819a.819.819 0 1 1 0-1.638h4.113a.819.819 0 1 1 0 1.638zm-8.145-.082h-17.77a9.178 9.178 0 0 1-9.213-9.173v-33.658a9.178 9.178 0 0 1 9.213-9.173h33.894a9.178 9.178 0 0 1 9.214 9.173v17.771c0 .082 0 .164-.082.082a.3.3 0 0 1 .082.246v4.1a.823.823 0 0 1-1.645 0v-2.539L338.476 1263h2.056a.819.819 0 1 1 0 1.638zm-25.338-42.831v33.74a7.411 7.411 0 0 0 7.568 7.453h17.03v-15.151a9.178 9.178 0 0 1 9.213-9.173h15.139v-16.87a7.532 7.532 0 0 0-7.569-7.535h-33.812a7.531 7.531 0 0 0-7.568 7.537zm26.243 26.124v14l21.637-21.53h-14.068a7.532 7.532 0 0 0-7.568 7.531zm21.8 12.857a.8.8 0 0 1-.165-1.147 7.444 7.444 0 0 0 1.152-3.44.893.893 0 0 1 .9-.737.647.647 0 0 1 .576.9 8.434 8.434 0 0 1-1.4 4.177.838.838 0 0 1-.658.41 1.4 1.4 0 0 1-.404-.162zm1.805-7.7a.82.82 0 0 1-.82-.82v-4.09a.819.819 0 0 1 .82-.82h.01a.82.82 0 0 1 .821.82v4.09a.82.82 0 0 1-.821.82z" data-name="Shape 3" transform="translate(-309.435 -1212.634)" />
                                </svg>
                                <p>Only accept products with an authentication sticker</p>
                            </div>
                        </div>
                        <div class="col-md-3 mt-3 text-center">
                            <div class="rouded-effects-1">

                                <svg xmlns="http://www.w3.org/2000/svg" width="53.45" height="53.207" viewBox="0 0 53.45 53.207">
                                    <path id="prefix__Shape_4" fill="#dc3545" d="M635.111 1261.1l3.791-3.47a21.959 21.959 0 0 0 33.44-18.6 21.658 21.658 0 0 0-2.357-9.842l3.512-3.213a26.386 26.386 0 0 1 3.561 13.263 26.745 26.745 0 0 1-41.947 21.862zm-9.894-1.762l13.019-11.91v-12.386a7.3 7.3 0 0 1 4.64-6.8.544.544 0 0 0 .345-.5v-.764a.828.828 0 0 1-.767-.8v-1.719a1.193 1.193 0 0 1 1.189-1.184h13.342a1.192 1.192 0 0 1 1.188 1.184v1.719a.827.827 0 0 1-.767.8v.764a.527.527 0 0 0 .346.5 7.456 7.456 0 0 1 .959.455l14.054-12.857 3.434 3.72-14.219 13.007a7.533 7.533 0 0 1 .448 2.474v13.791a4.141 4.141 0 0 1-4.141 4.126h-15.909a4.119 4.119 0 0 1-2.078-.558l-11.649 10.656zm17.16-7.142h15.873a3.447 3.447 0 0 0 3.336-2.751h-18.053l-2.635 2.41a3.361 3.361 0 0 0 1.48.339zm19.247-3.591V1235a6.661 6.661 0 0 0-.268-1.864l-6.761 6.185a6.369 6.369 0 0 1 .7 2.25.927.927 0 0 1 .115 1.069 1.1 1.1 0 0 1-.843.611 6.6 6.6 0 0 1-3.949 1.375 5.445 5.445 0 0 1-1.577-.228l-4.593 4.2zM639 1235.041v11.684l6.506-5.951a.665.665 0 0 1-.486 0 .37.37 0 0 1-.038-.535 2.512 2.512 0 0 1 1.878-.955 2.072 2.072 0 0 1 .246.029l1.7-1.557a1.2 1.2 0 0 1-.261-.076c-.115-.038-.269-.077-.383-.114a1.231 1.231 0 0 1-.844-.458 1.107 1.107 0 0 1 .154-1.261v-.076a1.242 1.242 0 0 1 .383-.879c.115-.076.192-.191.307-.267a1.66 1.66 0 0 1 1.61-.305 6.209 6.209 0 0 1 1.693 1.005l3.479-3.182h-15.25a6.235 6.235 0 0 0-.694 2.898zm11.578 8.825a6.045 6.045 0 0 0 3.566-1.261.7.7 0 0 1 .268-.077.344.344 0 0 0 .307-.192c.076-.152.076-.229 0-.267a.469.469 0 0 1-.153-.305 5.493 5.493 0 0 0-.539-1.926l-4.329 3.96a5.328 5.328 0 0 0 .884.069zm-4.945-3.209l.453-.414a3.154 3.154 0 0 0-.449.414zm3.067-5.5c-.076.077-.192.152-.268.23a.432.432 0 0 0-.115.305.862.862 0 0 1-.268.65.8.8 0 0 0 0 .305 1.155 1.155 0 0 0 .383.153 2.139 2.139 0 0 1 .46.153.947.947 0 0 0 .805-.115.764.764 0 0 1 .375-.24l.871-.8a4.625 4.625 0 0 0-1.4-.834.946.946 0 0 0-.26-.036.819.819 0 0 0-.583.228zm-4.716-7.411a1.329 1.329 0 0 1-.843 1.223 6.358 6.358 0 0 0-3.029 2.444h15.628l2.362-2.161a6.337 6.337 0 0 0-.622-.284 1.33 1.33 0 0 1-.843-1.223v-.764h-12.649zm-.767-3.324h.039v1.72a.037.037 0 0 0 .038.038h14.072a.037.037 0 0 0 .038-.038v-1.72a.425.425 0 0 0-.421-.42h-13.34a.425.425 0 0 0-.422.419zm-19.613 14.816a26.747 26.747 0 0 1 42.565-21.425l-3.442 3.151a21.959 21.959 0 0 0-34.268 18.067 21.643 21.643 0 0 0 2.821 10.708l-3.73 3.414a26.393 26.393 0 0 1-3.942-13.916z" data-name="Shape 4" transform="translate(-623.608 -1212.633)" />
                                </svg>
                                <p>Don’t accept products with stickers that have been scratched off</p>
                            </div>
                        </div>
                        <div class="col-md-3 mt-3 text-center">
                            <div class="rouded-effects-1">
                                <svg xmlns="http://www.w3.org/2000/svg" width="54.01" height="53.768" viewBox="0 0 54.01 53.768">
                                    <path id="prefix__Shape_6" fill="#dc3545" d="M929.623 1265.841a2.26 2.26 0 0 1-1.728-.8 2.206 2.206 0 0 1-.495-1.8l3.282-17.932v-29.692a3.573 3.573 0 0 1 3.593-3.546h40.354a3.574 3.574 0 0 1 3.593 3.546v29.695l3.128 17.938a2.214 2.214 0 0 1-.5 1.8 2.265 2.265 0 0 1-1.723.79zm-.895-2.366a.853.853 0 0 0 .2.7.912.912 0 0 0 .7.32h49.5a.913.913 0 0 0 .695-.318.859.859 0 0 0 .2-.706l-.44-2.524h-50.392zm42.649-3.869h7.967l-.63-3.613h-7.667zm-10.319 0h8.964l-.33-3.613h-8.8zm-11.639 0h10.288l-.165-3.613h-9.958zm-10.315 0h8.964l.165-3.613h-8.8zm-9.668 0h8.312l.33-3.613H930.1zm41.488-4.957h7.556l-.63-3.612h-7.256zm-10.094 0h8.738l-.329-3.612h-8.573zm-11.186 0h9.835l-.165-3.612h-9.5zm-10.088 0h8.737l.166-3.612h-8.572zm-9.213 0h7.857l.33-3.612h-7.527zm40.128-4.956h7.143l-.636-3.648h-6.84zm-9.867 0h8.511l-.333-3.648h-8.345zm-10.733 0h9.383l-.167-3.648h-9.049zm-9.862 0h8.511l.167-3.648h-8.345zm-8.758 0h7.4l.333-3.648h-7.068zm.779-4.992h44.841v-26.726h-44.84zm0-29.081v1.01h44.841v-1.01a2.226 2.226 0 0 0-2.243-2.2h-40.353a2.226 2.226 0 0 0-2.244 2.199zm25.831 23.791a2.723 2.723 0 1 1 2.723 2.714 2.721 2.721 0 0 1-2.722-2.715zm1.349 0a1.374 1.374 0 1 0 1.374-1.368 1.373 1.373 0 0 0-1.373 1.367zm-10.624 0a2.723 2.723 0 1 1 2.723 2.714 2.721 2.721 0 0 1-2.722-2.715zm1.349 0a1.374 1.374 0 1 0 1.374-1.368 1.373 1.373 0 0 0-1.373 1.367zm-2.714-3.948a.675.675 0 0 1-.671-.59l-1.6-12.976h-1.483a.672.672 0 1 1 0-1.345h2.08a.674.674 0 0 1 .67.59l.261 2.126h18.795a.673.673 0 0 1 .672.732l-.978 10.851a.674.674 0 0 1-.672.612zm.6-1.344h15.863l.857-9.508h-17.894z" data-name="Shape 6" transform="translate(-927.368 -1212.073)" />
                                </svg>
                                <p>Only buy from authorized retailers</p>
                            </div>
                        </div>
                    </div>


                    <div class="footer-bot">



                        <div class="socialicon">
                            <ul>
                                <li>
                                    <a href="https://www.facebook.com/AnkeriteNutritionIndia/" target="_blank" class="facebook icon-bg icon-bg-sm">
                                        <i class="mdi mdi-facebook"></i>
                                    </a>
                                </li>

                                <li>
                                    <a href="https://instagram.com/ankeritenutritionindia?igshid=YmMyMTA2M2Y=" target="_blank" class="instagram icon-bg icon-bg-sm">
                                        <i class="mdi mdi-instagram"></i>
                                    </a>
                                </li>

                                <li>
                                    <a href="https://youtube.com/channel/UC5UemWB7N3vdBPrah0j0Fzg" target="_blank" class="ytube icon-bg icon-bg-sm">
                                        <i class="mdi mdi-youtube"></i>
                                    </a>
                                </li>
                            </ul>

                        </div>
                        <div class="row">

                            <div class="col-12">

                                <a href="https://ankeritenutrition.com/" target="_blank">ankeritenutrition.com</a>
                            </div>
                        </div>




                    </div>

                </div>
            </div>
        </div>
        <!---=====end-of-Ankerite Winow============-->

        <!--========start-Chase2fit-window============--->
        <div class="w2rapper" id="chase2fit" style="display: none;">
            <div class="chase2fit-bg">
                <div class="custom_col-container-1 container-fluid">
                    <div class="row">
                        <div class="col-md-12 pt-4 animated fadeInDown">
                            <div class="logo-pronutrition1" style="width: 16%">
                                <img src="../assets/images/chase/chase1.png" class="img-fluid" />
                            </div>
                        </div>
                    </div>

                    <div class="row align-items-center justify-content-center" style="margin-top: -10%;">
                        <div class="col-lg-6 animated bounceIn Form-class">

                            <div class="formax-box mb-3">

                                <div class="form-checkcode" style="background-color: #0a1727; padding: 20px;">
                                    <div id="container5">
                                        <h2>To Check Authenticity of Product</h2>

                                        <div id="step7">
                                            <div class="form-group">

                                                <input type="text" class="input1 step1 form-control codeone3" required="" placeholder="Enter 13 Digit Code" value="" data-msg-required="Please enter Code." maxlength="13" id="forfocus" data-inputmask="'mask': '99999 9999 9999'" />
                                            </div>
                                        </div>

                                        <div id="step8">
                                            <br />
                                            <div class="form-group" style="margin-top: -5%;">

                                                <input type="text" id="Name2" placeholder="Name" data-msg-required="Please Enter Your Full Name" maxlength="50" class="form-control" required="" />
                                            </div>



                                            <div class="form-group" style="margin-top: -3%;">

                                                <input type="text" id="mobilenumber2" maxlength="10" placeholder="Mobile Number" data-msg-required="Please Enter Your Moblie Number" class="form-control" required="" />
                                            </div>


                                            <div class="form-group" style="margin-top: -3%;">

                                                <input type="text" id="Address2" placeholder="City" data-msg-required="Please Enter Your City." class="form-control" required="" />
                                            </div>

                                            <button type="button" id="btnsubmit2" style="background: #ea5e20;" class="btn btn-warning">SUBMIT</button>
                                        </div>


                                    </div>



                                    <div style="display: none; padding: 0px !important" id="ShowMessage2" class="row no-gutters pl-4 pr-4 textmessage">

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <p id="p4msg2" style="color: white !important; overflow: hidden; font-size: 14px !important;"></p>
                                            </div>
                                            <%-- <a href="javascript:void(0)" class="next_btn" id="btnNext">Close</a>--%>
                                        </div>


                                    </div>

                                </div>
                            </div>
                        </div>



                        <%--                        <div class="text-center mt-3 productImg">
                            <img src="assets/images/chase/Product.png" class="img-fluid">
                        </div>--%>

                        <div class="col-lg-6">
                            <div class="animated fadeInLeft">
                                <img src="assets/images/chase/CHASE2.png" class="img-fluid" />
                                <img src="assets/images/chase/product1.png" class="img-fluid" style="margin-top: -25%; width: 90%; margin-left: 5%;">
                            </div>
                        </div>
                    </div>






                </div>


                <div class="icon_pauthentic" style="margin-top: -3%; padding: 2%;">
                    <div class="row align-content-center justify-content-center">
                        <div class="col-md-3 text-center">
                            <div class="gap">
                                <h3>Products<br>
                                    Authentication Tips</h3>

                            </div>
                        </div>
                        <div class="col-md-3 mt-3 text-center animated fadeInDown">
                            <div class="radius-effect">
                                <svg xmlns="http://www.w3.org/2000/svg" width="52.325" height="52.086" viewBox="0 0 52.325 52.086">
                                    <path id="prefix__Shape_3" fill="#dc3545" d="M351.885 1263.9a.823.823 0 0 1 .823-.819 8.785 8.785 0 0 0 3.538-.983.766.766 0 0 1 1.069.246.905.905 0 0 1-.329 1.147 9.921 9.921 0 0 1-4.279 1.229.883.883 0 0 1-.822-.82zm-7.322.819a.819.819 0 1 1 0-1.638h4.113a.819.819 0 1 1 0 1.638zm-8.145-.082h-17.77a9.178 9.178 0 0 1-9.213-9.173v-33.658a9.178 9.178 0 0 1 9.213-9.173h33.894a9.178 9.178 0 0 1 9.214 9.173v17.771c0 .082 0 .164-.082.082a.3.3 0 0 1 .082.246v4.1a.823.823 0 0 1-1.645 0v-2.539L338.476 1263h2.056a.819.819 0 1 1 0 1.638zm-25.338-42.831v33.74a7.411 7.411 0 0 0 7.568 7.453h17.03v-15.151a9.178 9.178 0 0 1 9.213-9.173h15.139v-16.87a7.532 7.532 0 0 0-7.569-7.535h-33.812a7.531 7.531 0 0 0-7.568 7.537zm26.243 26.124v14l21.637-21.53h-14.068a7.532 7.532 0 0 0-7.568 7.531zm21.8 12.857a.8.8 0 0 1-.165-1.147 7.444 7.444 0 0 0 1.152-3.44.893.893 0 0 1 .9-.737.647.647 0 0 1 .576.9 8.434 8.434 0 0 1-1.4 4.177.838.838 0 0 1-.658.41 1.4 1.4 0 0 1-.404-.162zm1.805-7.7a.82.82 0 0 1-.82-.82v-4.09a.819.819 0 0 1 .82-.82h.01a.82.82 0 0 1 .821.82v4.09a.82.82 0 0 1-.821.82z" data-name="Shape 3" transform="translate(-309.435 -1212.634)"></path>
                                </svg>
                                <p>Only accept products with an authentication sticker</p>
                            </div>
                        </div>
                        <div class="col-md-3 mt-3 text-center animated fadeInUp">
                            <div class="radius-effect">

                                <svg xmlns="http://www.w3.org/2000/svg" width="53.45" height="53.207" viewBox="0 0 53.45 53.207">
                                    <path id="prefix__Shape_4" fill="#dc3545" d="M635.111 1261.1l3.791-3.47a21.959 21.959 0 0 0 33.44-18.6 21.658 21.658 0 0 0-2.357-9.842l3.512-3.213a26.386 26.386 0 0 1 3.561 13.263 26.745 26.745 0 0 1-41.947 21.862zm-9.894-1.762l13.019-11.91v-12.386a7.3 7.3 0 0 1 4.64-6.8.544.544 0 0 0 .345-.5v-.764a.828.828 0 0 1-.767-.8v-1.719a1.193 1.193 0 0 1 1.189-1.184h13.342a1.192 1.192 0 0 1 1.188 1.184v1.719a.827.827 0 0 1-.767.8v.764a.527.527 0 0 0 .346.5 7.456 7.456 0 0 1 .959.455l14.054-12.857 3.434 3.72-14.219 13.007a7.533 7.533 0 0 1 .448 2.474v13.791a4.141 4.141 0 0 1-4.141 4.126h-15.909a4.119 4.119 0 0 1-2.078-.558l-11.649 10.656zm17.16-7.142h15.873a3.447 3.447 0 0 0 3.336-2.751h-18.053l-2.635 2.41a3.361 3.361 0 0 0 1.48.339zm19.247-3.591V1235a6.661 6.661 0 0 0-.268-1.864l-6.761 6.185a6.369 6.369 0 0 1 .7 2.25.927.927 0 0 1 .115 1.069 1.1 1.1 0 0 1-.843.611 6.6 6.6 0 0 1-3.949 1.375 5.445 5.445 0 0 1-1.577-.228l-4.593 4.2zM639 1235.041v11.684l6.506-5.951a.665.665 0 0 1-.486 0 .37.37 0 0 1-.038-.535 2.512 2.512 0 0 1 1.878-.955 2.072 2.072 0 0 1 .246.029l1.7-1.557a1.2 1.2 0 0 1-.261-.076c-.115-.038-.269-.077-.383-.114a1.231 1.231 0 0 1-.844-.458 1.107 1.107 0 0 1 .154-1.261v-.076a1.242 1.242 0 0 1 .383-.879c.115-.076.192-.191.307-.267a1.66 1.66 0 0 1 1.61-.305 6.209 6.209 0 0 1 1.693 1.005l3.479-3.182h-15.25a6.235 6.235 0 0 0-.694 2.898zm11.578 8.825a6.045 6.045 0 0 0 3.566-1.261.7.7 0 0 1 .268-.077.344.344 0 0 0 .307-.192c.076-.152.076-.229 0-.267a.469.469 0 0 1-.153-.305 5.493 5.493 0 0 0-.539-1.926l-4.329 3.96a5.328 5.328 0 0 0 .884.069zm-4.945-3.209l.453-.414a3.154 3.154 0 0 0-.449.414zm3.067-5.5c-.076.077-.192.152-.268.23a.432.432 0 0 0-.115.305.862.862 0 0 1-.268.65.8.8 0 0 0 0 .305 1.155 1.155 0 0 0 .383.153 2.139 2.139 0 0 1 .46.153.947.947 0 0 0 .805-.115.764.764 0 0 1 .375-.24l.871-.8a4.625 4.625 0 0 0-1.4-.834.946.946 0 0 0-.26-.036.819.819 0 0 0-.583.228zm-4.716-7.411a1.329 1.329 0 0 1-.843 1.223 6.358 6.358 0 0 0-3.029 2.444h15.628l2.362-2.161a6.337 6.337 0 0 0-.622-.284 1.33 1.33 0 0 1-.843-1.223v-.764h-12.649zm-.767-3.324h.039v1.72a.037.037 0 0 0 .038.038h14.072a.037.037 0 0 0 .038-.038v-1.72a.425.425 0 0 0-.421-.42h-13.34a.425.425 0 0 0-.422.419zm-19.613 14.816a26.747 26.747 0 0 1 42.565-21.425l-3.442 3.151a21.959 21.959 0 0 0-34.268 18.067 21.643 21.643 0 0 0 2.821 10.708l-3.73 3.414a26.393 26.393 0 0 1-3.942-13.916z" data-name="Shape 4" transform="translate(-623.608 -1212.633)"></path>
                                </svg>
                                <p>Don’t accept products with stickers that have been scratched off</p>
                            </div>
                        </div>
                        <div class="col-md-3 mt-3 text-center animated fadeInDown">
                            <div class="radius-effect">
                                <svg xmlns="http://www.w3.org/2000/svg" width="54.01" height="53.768" viewBox="0 0 54.01 53.768">
                                    <path id="prefix__Shape_6" fill="#dc3545" d="M929.623 1265.841a2.26 2.26 0 0 1-1.728-.8 2.206 2.206 0 0 1-.495-1.8l3.282-17.932v-29.692a3.573 3.573 0 0 1 3.593-3.546h40.354a3.574 3.574 0 0 1 3.593 3.546v29.695l3.128 17.938a2.214 2.214 0 0 1-.5 1.8 2.265 2.265 0 0 1-1.723.79zm-.895-2.366a.853.853 0 0 0 .2.7.912.912 0 0 0 .7.32h49.5a.913.913 0 0 0 .695-.318.859.859 0 0 0 .2-.706l-.44-2.524h-50.392zm42.649-3.869h7.967l-.63-3.613h-7.667zm-10.319 0h8.964l-.33-3.613h-8.8zm-11.639 0h10.288l-.165-3.613h-9.958zm-10.315 0h8.964l.165-3.613h-8.8zm-9.668 0h8.312l.33-3.613H930.1zm41.488-4.957h7.556l-.63-3.612h-7.256zm-10.094 0h8.738l-.329-3.612h-8.573zm-11.186 0h9.835l-.165-3.612h-9.5zm-10.088 0h8.737l.166-3.612h-8.572zm-9.213 0h7.857l.33-3.612h-7.527zm40.128-4.956h7.143l-.636-3.648h-6.84zm-9.867 0h8.511l-.333-3.648h-8.345zm-10.733 0h9.383l-.167-3.648h-9.049zm-9.862 0h8.511l.167-3.648h-8.345zm-8.758 0h7.4l.333-3.648h-7.068zm.779-4.992h44.841v-26.726h-44.84zm0-29.081v1.01h44.841v-1.01a2.226 2.226 0 0 0-2.243-2.2h-40.353a2.226 2.226 0 0 0-2.244 2.199zm25.831 23.791a2.723 2.723 0 1 1 2.723 2.714 2.721 2.721 0 0 1-2.722-2.715zm1.349 0a1.374 1.374 0 1 0 1.374-1.368 1.373 1.373 0 0 0-1.373 1.367zm-10.624 0a2.723 2.723 0 1 1 2.723 2.714 2.721 2.721 0 0 1-2.722-2.715zm1.349 0a1.374 1.374 0 1 0 1.374-1.368 1.373 1.373 0 0 0-1.373 1.367zm-2.714-3.948a.675.675 0 0 1-.671-.59l-1.6-12.976h-1.483a.672.672 0 1 1 0-1.345h2.08a.674.674 0 0 1 .67.59l.261 2.126h18.795a.673.673 0 0 1 .672.732l-.978 10.851a.674.674 0 0 1-.672.612zm.6-1.344h15.863l.857-9.508h-17.894z" data-name="Shape 6" transform="translate(-927.368 -1212.073)"></path>
                                </svg>
                                <p>Only buy from authorized retailers</p>
                            </div>
                        </div>
                    </div>


                    <div class="footer-bot">



                        <div class="socialicon" style="margin-left: 2%;">
                            <ul>
                                <li>
                                    <a href="https://www.facebook.com/Chase2Fit-113672613802772/" target="_blank" class="facebook icon-bg icon-bg-sm">
                                        <i class="mdi mdi-facebook"></i>
                                    </a>
                                </li>

                                <li>
                                    <a href="https://instagram.com/chase2fit?igshid=YmMyMTA2M2Y=" target="_blank" class="instagram icon-bg icon-bg-sm">
                                        <i class="mdi mdi-instagram"></i>
                                    </a>
                                </li>

                                <%-- <li>
                                    <a href="https://youtube.com/channel/UC5UemWB7N3vdBPrah0j0Fzg" target="_blank" class="ytube icon-bg icon-bg-sm">
                                        <i class="mdi mdi-youtube"></i>
                                    </a>
                                </li>--%>
                            </ul>

                        </div>
                        <div class="row" style="margin-right: 2%;">

                            <div class="col-12">

                                <a href="http://www.chase2fit.com/" target="_blank">www.chase2fit.com</a>
                            </div>
                        </div>




                    </div>

                </div>


            </div>
        </div>

        <!--========start-Chase2fit-window end============--->

    </form>
</body>
</html>
