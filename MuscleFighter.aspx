<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MuscleFighter.aspx.cs" Inherits="MuscleFighter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- Demo CSS -->
    <!-- Skin CSS -->
    <!--link rel="stylesheet" href="css/skins/skin-corporate-19.css"-->
    <link rel="stylesheet" href="css/skins/default.css" />
    <!-- Theme Custom CSS -->
    <link rel="stylesheet" href="css/custom.css" />
    <!-- Head Libs -->
    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="../Content/js/jquery-1.11.1.min.js"></script>
    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>
    <%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>--%>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/0.9.0/jquery.mask.min.js"></script>--%>
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

        #step1 {
            margin-bottom: -25px;
        }

        .massage_box strong {
            color: #12af84 !important
        }

        #wlink {
            text-align: center;
            color: #fff;
            padding-top: 10px;
        }

            #wlink a {
                text-decoration: none;
                color: #fff;
            }

        .mfn-product {
            width: 80%;
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
            background: url(./assets/images/MFN-img/MFN-bg.jpg);
            background-size: 100% 100%;
            position: relative;
            /* height: 100vh; */
            width: 100%;
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

        .mfn-btn {
            background-color: #000 !important;
            color: #fff !important;
            border: 0px !important;
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
            width: 300px;
            height: 100px;
            overflow: hidden;
            position: absolute;
            /*argin:0 auto*/
        }

            .logo-nutrition img {
                width: 100%;
                top: 0;
                left: 0;
                /* height: 100%; */
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

        /* .displayNone {
            display: none !important;
        }*/

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
            background: rgb(255 255 255 / 34%);
            border-radius: 3px;
            border: 6px solid #ffffff63;
            padding: 10px;
            max-width: 644px;
            margin: auto;
            margin-top: 8px;
            margin-top: 20%;
        }

            .formBox-input .form-control {
                background: white;
                border: 1px solid #ffffff;
                border-radius: 0;
                color: #000;
            }

            .formBox-input label {
                color: #FFF;
            }

            .formBox-input h2 {
                color: #fff;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-size: 24px;
                text-align: center;
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
            margin: 0 auto;
            padding-bottom: 60px;
            position: relative;
        }

        .absolute {
            position: relative !important
        }

        .icon-colauthentic h2, .icon-colauthentic h3, .icon-colauthentic p {
            color: #FFF;
            text-transform: uppercase;
            /* font-size: large; */
        }

        .icon-colauthentic p {
            margin-bottom: 0;
            margin-left: 15px;
            text-transform: uppercase;
            font-size: 14px;
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
                fill: #fff000;
            }

        .content-over .icon-colauthentic svg path {
            fill: #dc9c2e
        }

        .icon-colauthentic .rouded-effects {
            padding: 15px;
            border: 4px solid #ffffffa8;
            border-radius: 20px;
            background-image: linear-gradient(to right, #000000, #e43443);
            min-height: 134px;
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
        footer {
            width: 100%;
            background-color: #fff;
            padding: 10px;
            text-align: center;
            bottom: 0;
            position: fixed;
        }

        .footer-link {
            text-decoration: none;
            color: #000;
            width: 100%;
            /* position: absolute; */
            /* bottom: -45px; */
            text-align: center;
            font-weight: 600;
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

        @media (min-width:1000px) and (max-width: 1200px) {
            /* footer {
                position: absolute;
                bottom: 0;
            } */
            .bg-fixed {
                height: 100vh;
            }
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
            .icon-colauthentic h2, .icon-colauthentic p {
                color: #FFF;
                /* font-size: 12px; */
            }

            .icon-colauthentic h3 {
                color: #FFF;
                /* font-size: unset; */
            }

            .bg-fixed {
                background: url(./assets/images/MFN-img/MFN-bg.jpg) no-repeat 0 0;
                background-size: 100%;
                position: relative;
                height: 100%;
                min-height: 500px;
            }

            .mfn-product {
                width: 100%;
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
                width: 50%;
                height: 80px;
                overflow: hidden;
                position: relative;
                /* margin: 0 auto;
                float: right; */
            }

            .icon-colauthentic {
                padding-top: 0;
                position: relative
            }

                .icon-colauthentic .gap {
                    margin-top: 40;
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
                /* background: rgb(22 55 96); */
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


    <script type="text/javascript">
        // it is the variable initialized for the location purpose.
        var lat = "";
        var long = "";
        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }
        function Mobile_check() {

            var mobile_val = $('#mobile').val();
            var d = mobile_val.slice(0, 1);
            var c = parseInt(d);

            if ((mobile_val.length == '') || (mobile_val.length != 10)) {
                $('#mobilecheck').show();
                $('#mobilecheck').html("**Please Enter mobile number");
                $('#mobilecheck').css("color", "red");
                mobile_err = false;
                return false;
            }

            // if the mobile length value is correct and drop down list is not empty then through post api we can easily collect the data from the user
            if (mobile_val.length == 10) {
                debugger;
                $('#mobilecheck').hide();
                $.ajax({
                    type: "Post",
                    url: '../Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNo&MobileNo= ' + $("#mobile").val(),
                    success: function (data) {

                        if (c <= 5) {
                            $('#mobilecheck').text('Please Enter correct Mobile Number');
                            $('#mobile').val('');
                            return false;
                        }
                        else {

                            var Name = data.split('~')[0];
                            var pin = data.split('~')[6];
                            var Email = data.split('~')[7];
                            var city = data.split('~')[2];


                            if (Name != "") {
                                $("#name").val(Name);
                            }
                            else {

                                $('#Chkcode').hide();
                                $('#Chkfields').show();
                                $('#mobilefield').hide();
                                $('#Otherfield').show();
                            }

                            //if (Pin != "") {
                            //    $("#Pincode").val(Pin);
                            //}
                            //else {
                            //    $('#Chkcode').hide();
                            //    $('#mobilefield').hide();
                            //    $('#Chkfields').show();
                            //    $('#Otherfield').show();
                            //}

                            if (Email != "") {
                                $("#Mail").val(Email);

                            }
                            else {



                                $('#Chkcode').hide();
                                $('#Chkfields').show();
                                $('#mobilefield').hide();
                                $('#Otherfield').show();
                            }
                            if (city != "") {
                                $("#Location").val(city);

                            }
                            else {

                                $('#Chkcode').hide();
                                $('#Chkfields').show();
                                $('#mobilefield').hide();
                                $('#Otherfield').show();
                            }

                            if (name != "" && city != "") {
                                $('#Chkcode').hide();
                                $('#Chkfields').show();
                                $('#mobilefield').hide();
                                $('#Otherfield').hide();
                            }




                            //if (name == "" || city == "") {
                            //    $('#Chkcode').hide();
                            //    $('#Chkfields').show();
                            //    $('#mobilefield').hide();
                            //    $('#Otherfield').show();
                            //}



                        }
                    }
                });
            }
            else {
                $("#name").val('');


            }
        }

        $(document).ready(function () {

            debugger;
            $('#Chkcode').show();
            $('#Chkfields').hide();
            $('#mobilefield').hide();
            $('#Otherfield').hide();


            var id = $('#HdnID').val();
            if (id == "1") {

                $('#Chkcode').show();
                $('#Chkfields').hide();
                $('#mobilefield').hide();
                $('#Otherfield').hide();
            }

            else if (id == "musclefighter") {
                $('#Chkcode').hide();
                $('#Chkfields').show();
                $('#mobilefield').show();
                $('#Otherfield').hide();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $("#example13-digit-number").val(code);
            }


            var code_err = true;
            var mobile_err = true;
            var name_err = true;



            // check for the 13-digit number when the user is enter to check the code is correct or else 

            $("#example13-digit-number").mask("99999-99999999");

            $("#btnnxt").on('click', function (e) {
                e.preventDefault();
                /*debugger;*/

                var codeone = $('#example13-digit-number').val();

                if (codeone == "" || codeone == undefined) {
                    $('#nextcheck').html('Please Enter 13 Digit Code');
                    $('#nextcheck').css("color", "red");
                    return false;
                }
                else {
                    $('#nextcheck').text('');
                }

                if (codeone != undefined) {
                    if ($('#example13-digit-number').val().length < 14) {
                        $('#nextcheck').text('Please Enter 13 Digit Code');
                        $('#nextcheck').css("color", "red");
                        return false;
                    }
                    else {
                        $('#nextcheck').text('');
                        $('#nextcheck').hide();
                    }
                }

                var rquestpage_Dcrypt = $("#example13-digit-number").val();

                $('#btnnxt').hide();
                $('#btnloadnxt').show();

                $.ajax({
                    type: "POST",
                    url: '../Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                    success: function (data) {
                        $.ajax({
                            type: "POST",
                            url: '../Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1] + '&lat=' + lat + '&long=' + long,
                            success: function (data) {
                                $('#btnnxt').show();
                                $('#btnloadnxt').hide();
                                if (data.split('&')[0] === "1" && data.split('&')[1] === "Auto Max India") {



                                }
                                else {
                                    if (data.split('&')[1] == "Muscle fighter Nutrition" || data.split('&')[1] == "" || data.split('&')[1] == undefined) {
                                        $('#Chkcode').hide();
                                        $('#Chkfields').show();
                                        $('#Otherfield').hide();
                                        $('#mobilefield').show();
                                    }
                                    else {

                                        $('#Chkcode').show();
                                        $('#Chkfields').hide();
                                        $('#mobilefield').hide();
                                        $('#Otherfield').hide();
                                        return false;
                                    }
                                }
                            }
                        });
                    }
                });

            });

            // validation for the mobile function

            $("#mobile").mask("9999999999");

            $('#mobile').keyup(function () {
                Mobile_check();
            })



            // validation for the namecheck
            $('#name').keyup(function () {
                Name_check();
            });



            $('#Location').keyup(function () {
                locationCheck();
            });



            $("#Pincode").mask("999999");
            $('#Pincode').keyup(function () {
                Pin_check();

            });

            /*Pincode Api for the city and the state  */
            function Pin_check() {


                let pin = document.getElementById("Pincode").value;
                if (pin.length != 6) {
                    $('#pincheck').show();
                    $('#pincheck').html("**Please Enter the 6-digits pin code");
                    $('#pincheck').css("color", "red");
                    pin_err = false;
                    return false;
                }
                if (pin.length == 6) {
                    $.getJSON("https://api.postalpincode.in/pincode/" + pin, function (data) {

                        createHTML(data);
                    });
                    function createHTML(data) {

                        if (data[0].Status == "Success") {
                            var city = "";
                            var state = "";
                            var pin = "";
                            var city = data[0].PostOffice[0]['District'];
                            var state = data[0].PostOffice[0]['State'];
                            var Pin = data[0].PostOffice[0]['PinCode'];
                            $('#Pincode').text('');
                            $("#Location").val(city);
                            $('#pincheck').hide();
                            $('#locationCheck').hide();
                        }
                        else {
                            $('#pincheck').show();
                            $('#pincheck').html("**Please Enter Valid Pincode");
                            $('#pincheck').css("color", "red");
                            pin_err = false;
                            return false;
                        }
                    }
                }

                else {
                    if (pin != "") {
                        $("#city").val('');
                        /*  $("#state").val('');*/
                        $("#city").attr('readonly', false);
                        /*    $("#state").attr('readonly', false);*/
                        $('#pincheck').show();
                        $('#pincheck').html("**Please Enter the 6-digits pin code");
                        $('#pincheck').css("color", "red");
                        pin_err = false;
                        return false;
                    }
                    else {
                        $('#pincheck').html("");
                    }

                }

            }

            $('#name').keyup(function () {
                $('#namecheck').hide();
                $('#namecheck').html("");
                $('#namecheck').css("color", "black");

            });
            $('#Location').keyup(function () {
                $('#locationCheck').hide();
                $('#locationCheck').html("");
                $('#locationCheck').css("color", "black");

            });


            function Name_check() {
                var Name_val = $('#name').val();

                if ((Name_val.length == '')) {
                    $('#namecheck').show();
                    $('#namecheck').html("**Please Enter Name");
                    $('#namecheck').css("color", "Red");
                    name_err = false;
                    return false;
                }

                if ($('#name').val().match('^[a-z A-Z]{3,30}$')) {
                    $('#namecheck').hide();
                }
                else {
                    $('#namecheck').show();
                    $('#namecheck').html("**Please Enter valid name");
                    $('#namecheck').css("color", "Red");
                    name_err = false;
                    return false;
                }
            }



            function locationCheck() {
                var location_val = $('#Location').val();

                if ((location_val.length == '')) {
                    $('#locationCheck').show();
                    $('#locationCheck').html("**Please Enter Location");
                    $('#locationCheck').css("color", "red");
                    location_err = false;
                    return false;
                }

                if ($('#Location').val().match('^[a-z A-Z]{3,30}$')) {
                    $('#locationCheck').hide();
                }
                else {
                    $('#locationCheck').show();
                    $('#locationCheck').html("**Please Enter valid Location");
                    $('#locationCheck').css("color", "red");
                    location_err = false;
                    return false;
                }
            }

            $('#btnsubmit').on('click', function (e) {
                e.preventDefault();
                /* debugger;*/

                $('#Mail_Check').html('');

                var mobileone = $('#mobile').val();
                if (mobileone == "" || mobileone == undefined) {
                    $('#mobilecheck').html('Please Enter Mobile Number');
                    $('#mobilecheck').css("color", "red");
                    return false;
                }
                else {
                    $('#mobilecheck').text('');
                }

                var Name = $('#name').val();
                if (Name == "" || Name == undefined || Name.charAt(0) === ' ') {
                    $('#namecheck').html('Please Enter Name');
                    $('#namecheck').css("color", "red");
                    return false;
                }
                else {
                    $('#namecheck').text('');
                }
                var Email = document.getElementById('Mail').value;

                if (Email != "") {
                    var check = validateEmail(Email);

                    if (check != true) {
                        $('#Mail_Check').show();
                        $('#Mail_Check').html("**Please enter valid Email");
                        $('#Mail_Check').css("color", "red");
                        return false;
                    }
                    else if (check == true) {
                        $('#Mail_Check').html("");
                        $('#Mail_Check').hide();
                    }
                }

               

                var Location = $('#Location').val();
                if (Location == "" || Location == undefined ) {
                    $('#locationCheck').html('Please Enter Location');
                    $('#locationCheck').css("color", "red");
                    return false;
                }
                else {
                    $('#locationCheck').text('');
                }







                var code = $('#example13-digit-number').val();

                if (code != "") {

                    $('#btnsubmit').hide();
                    $('#btnloadsubmit').show();

                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: '../Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#example13-digit-number').val() + '&name=' + $('#name').val() + '&city=' + $('#Location').val() /*+ '&PinCode=' + $('#Pincode').val()*/ + '&EmailAddrs=' + $('#Mail').val() + '&comp=Muscle fighter Nutrition&Comp_ID=Comp-1640',
                        success: function (data) {




                            $('#btnsubmit').show();
                            $('#btnloadsubmit').hide();
                            if (data.split('~')[0] !== "failure") {
                                window.scrollTo(0, 0);
                                if (data.indexOf("not valid") !== -1) {
                                    data = data.split(".")[0];
                                }
                                /*$('#HEADING').hide();*/
                                $('#Chkfields').hide();
                                $('#mobilefield').hide();
                                $('#Otherfield').hide();
                                $('#Chkcode').hide();
                                $('#ShowMessage').show();
                                // $('#chkLine').hide();
                                $('#p3msg').html(data.split('~')[1]);
                                $('#p3msg:contains("not")').css('color', 'white');
                            }
                            else {
                                $('#msgcoats').hide();
                                toastr.error('Sonething went wrong');
                                $('#btnskyVerify1').attr('disabled', false);
                            }
                        }
                    });
                }

                else {

                    $('#btnsubmit').attr('disabled', false);
                }



            });

            $('#btnNext').click(function () {
                window.location.href = 'https://musclefighternutrition.com/';
            });

        });
        function validateEmail(email) {
            var re = /\S+@\S+\.\S+/;
            return re.test(email);
        }

        function MailCheck() {
            debugger;

            //var Email = $('#mail').val();
            var Email = document.getElementById('Mail').value;

            if (Email != "") {
                var check = validateEmail(Email);

                if (check != true) {
                    $('#Mail_Check').show();
                    $('#Mail_Check').html("**Please enter valid Email");
                    $('#Mail_Check').css("color", "red");
                    return false;
                }
                else if (check == true) {
                    $('#Mail_Check').html("");
                    $('#Mail_Check').hide();
                }
            }


            //var Mail_val = $('#mail').val();
            //var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            //if (Mail_val=="") {
            //    $('#Mail_Check').show();
            //    $('#Mail_Check').html("**Please enter Email");
            //    $('#Mail_Check').css("color", "white");
            //  //  Mail_err = false;
            //    return false;
            //}


            //else if (!regex.test(Mail_val)) {
            //    $('#Mail_Check').show();
            //    $('#Mail_Check').html("**Please enter valid Email");
            //    $('#Mail_Check').css("color", "white");
            //  //  Mail_err = false;
            //    return false;
            //}

            //else {
            //    $('#mailcheck').hide();
            //}
        }

        /*
        function MailCheck() {
            debugger;
            
            var email = $('#mail').val();
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (emailRegex.test(email)) {
                $('#Mail_Check').html("");
            } else {
                $('#Mail_Check').html("Please enter a valid email address.");
                $('#Mail_Check').css("color", "white");
                return false;
            }
        }
        */

    </script>

</head>
<body>


    <form name="form1" method="post" runat="server" action="./codeverify.aspx?ID=5" id="form1">
        <div>
            <input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKMTg0OTQ1MjgyNWRksJsH6oszOY6aBQb8ZYXqeZMoulsk8vinBkoOFmG/5+0=" />
        </div>

        <div>

            <input type="hidden" name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="1C52CC2C" />
            <input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION" value="/wEdAAd6JZhTpi8GFWyIsYyG2DIQTHJap1XPAwS4DQSuvGS50UWwP5KwieItj32l9mnkzqloDPdc3hZCgD7GXGAULra3/e/TMgqN0FcyW0KuwQmpO/68Exa89vh/IRkoWN0RiIwY7K8ZMmE2lBY9fYpYdQz1P9IDSJSefdmxvBXJdr6y/iaq/z6L9cln71gR+ZJ5CX0=" />
        </div>

        <asp:HiddenField ID="hdnmob" runat="server" />
        <asp:HiddenField ID="HdnID" runat="server" />
        <asp:HiddenField ID="HdnCode1" runat="server" />
        <asp:HiddenField ID="HdnCode2" runat="server" />
        <asp:HiddenField ID="CompName" runat="server" />
        <asp:HiddenField ID="long" runat="server" />
        <asp:HiddenField ID="lat" runat="server" />



        <!---=====start-of-FB Winow============-->
        <div class="bg-fixed">
            <div class=" container">
                <div class="row">
                    <div class="col-md-12 pt-4">
                        <div class="logo-nutrition">
                            <a href="https://musclefighternutrition.com/" target="_blank">
                                <img src="./assets/images/MFN-img/MFN-Grey-logo.png" class="img-fluid" /></a>
                        </div>
                    </div>
                </div>

                <div class="row align-items-center justify-content-center">

                    <div class="col-lg-5 mt-3">
                        <div class="formBox-input" style="padding: 2%;">
                            <div id="container2">
                                <h2>To Check Authenticity of Product</h2>

                                <div id="Chkcode">
                                    <div class="form-group">
                                        <input type="text" maxlength="13" class="form-control" id="example13-digit-number" placeholder="Enter 13 Digit Code*" />
                                        <h6 class="invalid-feedback d-block" id="nextcheck"></h6>
                                        <button type="button" id="btnnxt" data-toggle="modal" class="form-control mfn-btn">Next</button>
                                        <button type="button" id="btnloadnxt" style="display: none" data-toggle="modal" class="form-control mfn-btn"><i class="fa fa-spinner fa-spin"></i>Loading..</button>
                                      <%--  <h6 id="nextcheck"></h6>--%>
                                    </div>
                                </div>

                                <div id="Chkfields">

                                    <div class="mobilefield" id="mobilefield">
                                        <div class="form-group">
                                            <input type="text" class="form-control" id="mobile" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="Mobile No*" />
                                            <h6 class="invalid-feedback d-block" id="mobilecheck"></h6>
                                        </div>
                                    </div>
                                    <div class="Otherfield" id="Otherfield" style="display: none">
                                        <div class="form-group">
                                            <input type="text" maxlength="50" data-msg-required="Please Enter Your Name" class="form-control" id="name" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || (event.charCode == 32)" placeholder="Name*" />
                                            <h6 class="invalid-feedback d-block" id="namecheck"></h6>
                                        </div>

                                        <div class="form-group">
                                            <input type="text" maxlength="50" data-msg-required="Please Enter Your Email" onkeypress="MailCheck()" class="form-control" id="Mail" placeholder="Mail Address" />
                                            <%-- <input type="text" maxlength="50" data-msg-required="Please Enter Your Mail Address" class="form-control" id="Mail" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode === 64 || event.charCode === 46 || event.charCode === 45 || (event.charCode > 47 && event.charCode < 58)" placeholder="Mail Address" />--%>
                                            <h6 class="invalid-feedback d-block" id="Mail_Check"></h6>
                                        </div>

                                        <%-- <div class="form-group">

                                            <input type="text" maxlength="6" data-msg-required="Please Enter Your Pincode" class="form-control" id="Pincode" onkeypress="return (event.charCode >= 48 && event.charCode <= 57)" placeholder="Pincode*" />

                                            <h6 id="Pin_check"></h6>
                                        </div>--%>

                                        <div class="form-group">
                                            <input type="text" maxlength="50" data-msg-required="Please Enter Your Location" class="form-control" id="Location" onkeypress="return (event.charCode > 47 && event.charCode < 58) || (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode == 32)" placeholder="Location*" />
                                            <h6 class="invalid-feedback d-block" id="locationCheck"></h6>
                                        </div>
                                    </div>
                                    <button type="button" id="btnsubmit" data-toggle="modal" class="form-control mfn-btn">SUBMIT</button>
                                    <button type="button" id="btnloadsubmit" style="display: none" data-toggle="modal" class="form-control mfn-btn"><i class="fa fa-spinner fa-spin"></i>Loading..</button>

                                </div>

                                <div style="display: none; border: solid;color:black" id="ShowMessage">

                                    <div class="form-box">
                                        <p id="p3msg" style="overflow: hidden; color: white !important; font-size: 15px !important; font-weight: 500; margin: 7px; margin-right: 7px;" class="displayNone text-center">
                                        </p>
                                        <center><a href="javascript:void(0)" style="color:black;font-size:medium" class=" " id="btnNext">Close</a></center>
                                    </div>

                                </div>

                                <div class="row" id="p1msgmodal" style="display: none;">
                                    <div class="col-md-12 hintline mb-0">
                                        <div class="code-message mb-0">
                                            <p style="color: white !important;" id="p1msg"></p>
                                        </div>
                                    </div>
                                </div>
                                <p id="data"></p>
                                <p id="wlink" class="blink_me animate__animated animate__flash">
                                    QR/Code Related Support Available on
                                    <br />
                                    <i class="fa fa-phone" aria-hidden="true"></i><a href="tel:7353000903">7353000903 /
                                    </a>
                                    <i class="fa fa-whatsapp" aria-hidden="true"></i>
                                    <a href="https://api.whatsapp.com/send?phone=+919355903119&amp;text&amp;type=phone_number&amp;app_absent=1" target="blank">9355903119 </a>
                                </p>

                            </div>
                        </div>



                    </div>
                    <div class="col-lg-7 mt-3">
                        <div class="text-center">
                            <img src="assets/images/MFN-img/MFN-product.png" class="img-fluid mfn-product" />
                        </div>
                    </div>


                </div>


                <div class="container">
                    <div class="icon-colauthentic">
                        <div class="row align-content-center justify-content-center">
                            <div class="col-xxl-3 col-xl-3 col-lg-6 col-md-6 text-center">
                                <div class="gap">
                                    <h3>Products<br />
                                        Authentication Tips</h3>

                                </div>
                            </div>
                            <div class="col-xxl-3 col-xl-3 col-lg-6 col-md-6 mt-3 text-center">
                                <div class="rouded-effects">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="52.325" height="52.086" viewBox="0 0 52.325 52.086">
                                        <path id="prefix__Shape_3" fill="#dc3545" d="M351.885 1263.9a.823.823 0 0 1 .823-.819 8.785 8.785 0 0 0 3.538-.983.766.766 0 0 1 1.069.246.905.905 0 0 1-.329 1.147 9.921 9.921 0 0 1-4.279 1.229.883.883 0 0 1-.822-.82zm-7.322.819a.819.819 0 1 1 0-1.638h4.113a.819.819 0 1 1 0 1.638zm-8.145-.082h-17.77a9.178 9.178 0 0 1-9.213-9.173v-33.658a9.178 9.178 0 0 1 9.213-9.173h33.894a9.178 9.178 0 0 1 9.214 9.173v17.771c0 .082 0 .164-.082.082a.3.3 0 0 1 .082.246v4.1a.823.823 0 0 1-1.645 0v-2.539L338.476 1263h2.056a.819.819 0 1 1 0 1.638zm-25.338-42.831v33.74a7.411 7.411 0 0 0 7.568 7.453h17.03v-15.151a9.178 9.178 0 0 1 9.213-9.173h15.139v-16.87a7.532 7.532 0 0 0-7.569-7.535h-33.812a7.531 7.531 0 0 0-7.568 7.537zm26.243 26.124v14l21.637-21.53h-14.068a7.532 7.532 0 0 0-7.568 7.531zm21.8 12.857a.8.8 0 0 1-.165-1.147 7.444 7.444 0 0 0 1.152-3.44.893.893 0 0 1 .9-.737.647.647 0 0 1 .576.9 8.434 8.434 0 0 1-1.4 4.177.838.838 0 0 1-.658.41 1.4 1.4 0 0 1-.404-.162zm1.805-7.7a.82.82 0 0 1-.82-.82v-4.09a.819.819 0 0 1 .82-.82h.01a.82.82 0 0 1 .821.82v4.09a.82.82 0 0 1-.821.82z" data-name="Shape 3" transform="translate(-309.435 -1212.634)" />
                                    </svg>
                                    <p>Only accept products with an authentication sticker</p>
                                </div>
                            </div>
                            <div class="col-xxl-3 col-xl-3 col-lg-6 col-md-6 mt-3 text-center">
                                <div class="rouded-effects">

                                    <svg xmlns="http://www.w3.org/2000/svg" width="53.45" height="53.207" viewBox="0 0 53.45 53.207">
                                        <path id="prefix__Shape_4" fill="#dc3545" d="M635.111 1261.1l3.791-3.47a21.959 21.959 0 0 0 33.44-18.6 21.658 21.658 0 0 0-2.357-9.842l3.512-3.213a26.386 26.386 0 0 1 3.561 13.263 26.745 26.745 0 0 1-41.947 21.862zm-9.894-1.762l13.019-11.91v-12.386a7.3 7.3 0 0 1 4.64-6.8.544.544 0 0 0 .345-.5v-.764a.828.828 0 0 1-.767-.8v-1.719a1.193 1.193 0 0 1 1.189-1.184h13.342a1.192 1.192 0 0 1 1.188 1.184v1.719a.827.827 0 0 1-.767.8v.764a.527.527 0 0 0 .346.5 7.456 7.456 0 0 1 .959.455l14.054-12.857 3.434 3.72-14.219 13.007a7.533 7.533 0 0 1 .448 2.474v13.791a4.141 4.141 0 0 1-4.141 4.126h-15.909a4.119 4.119 0 0 1-2.078-.558l-11.649 10.656zm17.16-7.142h15.873a3.447 3.447 0 0 0 3.336-2.751h-18.053l-2.635 2.41a3.361 3.361 0 0 0 1.48.339zm19.247-3.591V1235a6.661 6.661 0 0 0-.268-1.864l-6.761 6.185a6.369 6.369 0 0 1 .7 2.25.927.927 0 0 1 .115 1.069 1.1 1.1 0 0 1-.843.611 6.6 6.6 0 0 1-3.949 1.375 5.445 5.445 0 0 1-1.577-.228l-4.593 4.2zM639 1235.041v11.684l6.506-5.951a.665.665 0 0 1-.486 0 .37.37 0 0 1-.038-.535 2.512 2.512 0 0 1 1.878-.955 2.072 2.072 0 0 1 .246.029l1.7-1.557a1.2 1.2 0 0 1-.261-.076c-.115-.038-.269-.077-.383-.114a1.231 1.231 0 0 1-.844-.458 1.107 1.107 0 0 1 .154-1.261v-.076a1.242 1.242 0 0 1 .383-.879c.115-.076.192-.191.307-.267a1.66 1.66 0 0 1 1.61-.305 6.209 6.209 0 0 1 1.693 1.005l3.479-3.182h-15.25a6.235 6.235 0 0 0-.694 2.898zm11.578 8.825a6.045 6.045 0 0 0 3.566-1.261.7.7 0 0 1 .268-.077.344.344 0 0 0 .307-.192c.076-.152.076-.229 0-.267a.469.469 0 0 1-.153-.305 5.493 5.493 0 0 0-.539-1.926l-4.329 3.96a5.328 5.328 0 0 0 .884.069zm-4.945-3.209l.453-.414a3.154 3.154 0 0 0-.449.414zm3.067-5.5c-.076.077-.192.152-.268.23a.432.432 0 0 0-.115.305.862.862 0 0 1-.268.65.8.8 0 0 0 0 .305 1.155 1.155 0 0 0 .383.153 2.139 2.139 0 0 1 .46.153.947.947 0 0 0 .805-.115.764.764 0 0 1 .375-.24l.871-.8a4.625 4.625 0 0 0-1.4-.834.946.946 0 0 0-.26-.036.819.819 0 0 0-.583.228zm-4.716-7.411a1.329 1.329 0 0 1-.843 1.223 6.358 6.358 0 0 0-3.029 2.444h15.628l2.362-2.161a6.337 6.337 0 0 0-.622-.284 1.33 1.33 0 0 1-.843-1.223v-.764h-12.649zm-.767-3.324h.039v1.72a.037.037 0 0 0 .038.038h14.072a.037.037 0 0 0 .038-.038v-1.72a.425.425 0 0 0-.421-.42h-13.34a.425.425 0 0 0-.422.419zm-19.613 14.816a26.747 26.747 0 0 1 42.565-21.425l-3.442 3.151a21.959 21.959 0 0 0-34.268 18.067 21.643 21.643 0 0 0 2.821 10.708l-3.73 3.414a26.393 26.393 0 0 1-3.942-13.916z" data-name="Shape 4" transform="translate(-623.608 -1212.633)" />
                                    </svg>
                                    <p>Don’t accept products with stickers that have been scratched off</p>
                                </div>
                            </div>
                            <div class="col-xxl-3 col-xl-3 col-lg-6 col-md-6 mt-3 text-center">
                                <div class="rouded-effects">
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


        </div>
        <!---=====end-of-FB Winow============-->



    </form>

    <footer>
        <a href="https://musclefighternutrition.com/" target="_blank" class="footer-link">www.musclefighternutrition.com</a>
    </footer>
</body>
</html>
