<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CheckYourCodes.ascx.cs" Inherits="UserControl_CheckYourCodes" %>
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,900&display=swap" rel="stylesheet">

<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/3/jquery.inputmask.bundle.js"></script>
<%--<script src="../js/calendar/jquery-3.3.1.min.js"></script>--%>
<script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
<link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />



<%--<style type="text/css">
 
.context {
    width: 100%;
    position: absolute;
    
    z-index: 100;
    
}

.context h1{
    text-align: center;
    color: #fff;
    font-size: 50px;

}

.input-group>.form-control:focus, .input-group>.form-floating:focus-within, .input-group>.form-select:focus {
    z-index: 0;
}

.code{
    z-index: 100;
}

.verfiy-form
{
    position: relative;
    place-items: center;
}

form{
    width: 80%;
    margin: auto;
}


.input-group-append
{
    position: absolute;
    right: 0;
    margin-right: 10px;
    
}

.input-verify
{
    border-radius: 29px;
}

input#txtemail {
    border-radius: 29px;
}

.theme-btn-black {
    border: none;
    background: #0194EF;
    padding: 9px;
    border-radius: 24px;
    color: #fff;
}

.area{
    background: #d1ecff;  
    background: -webkit-linear-gradient(to left, #8f94fb, #4e54c8);  
    width: 100%;
    height:100vh;
    z-index: 1000;
    display: table;
   
}

.code-verify {
    text-align: center;
    z-index: 100;
    padding-top: 200px;
    /* padding-bottom: 200px; */
}

.row.col-lg-6.text-center {
    margin: auto;
}

.col-lg-12.code {
    z-index: 1000;
}

.input-group-append {
    margin-left:-1px;
}



.circles{
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
}

.circles li {
    position: absolute;
    display: block;
    list-style: none;
    width: 20px;
    height: 20px;
    background: #fff;
    /* background: rgba(255, 255, 255, 0.2); */
    animation: animate 7s linear infinite;
    bottom: -150px;
}

.circles li:nth-child(1) {
    left: 25%;
    width: 80px;
    height: 80px;
    border-radius: 50px;
    animation-delay: 0s;
}


.circles li:nth-child(2){
    left: 10%;
    width: 20px;
    height: 20px;
    animation-delay: 2s;
    animation-duration: 12s;
       
}

.circles li:nth-child(3){
    left: 70%;
    width: 20px;
    height: 20px;
    animation-delay: 4s;
        color: #DAEDFA;
}

.circles li:nth-child(4){
    left: 40%;
    width: 60px;
    height: 60px;
    animation-delay: 0s;
    animation-duration: 18s;
           
}

.circles li:nth-child(5){
    left: 65%;
    width: 20px;
    height: 20px;
    animation-delay: 0s;
        color: #DAEDFA;
}

.circles li:nth-child(6){
    left: 75%;
    width: 110px;
    height: 110px;
    animation-delay: 3s;
        color: #DAEDFA;
}

.circles li:nth-child(7){
    left: 35%;
        color: #DAEDFA;
    width: 150px;
    height: 150px;
    animation-delay: 7s;
}

.circles li:nth-child(8){
    left: 50%;
                background: #d0dbe3;
    width: 25px;
    height: 25px;
    animation-delay: 15s;
    animation-duration: 45s;
}

.circles li:nth-child(9){
    left: 20%;
    width: 15px;
               
    height: 15px;
    animation-delay: 2s;
    animation-duration: 35s;
}

.circles li:nth-child(10){
    left: 85%;
    width: 150px;
    height: 150px;
            
    animation-delay: 0s;
    animation-duration: 11s;
}



@keyframes animate {

    0%{
        transform: translate(0) rotate(360deg);
        opacity: 1;
        border-radius: 0;
    }

    100%{
        transform: translateY(-1000px) rotate(360deg);
        opacity: 0;
        border-radius: 50%;
    }

}



</style>--%>



<style>
    #frmmm {
        width: 100%;
    }

    .form-check-input[type=radio] {
        border-radius: 50%;
        margin-top: 4px;
    }

    #frmmm input.form-control {
        border-radius: 0px;
        border: 0px solid black !important;
        font-size: 14px !important;
        color: black !important;
        box-shadow: none;
        height: 44px !important;
        font-family: 'Lato', sans-serif;
        border: 1px solid #d6cfcf !important;
        background-color: transparent !important;
        border-radius: 3px;
        padding: 12px 20px;
        box-shadow: none !important;
        font-weight: bold;
    }

    .context {
        width: 100%;
        position: absolute;
        z-index: 100;
    }

        .context h1 {
            text-align: center;
            color: #fff;
            font-size: 50px;
        }

    input {
        padding: 13px;
    }

        input#code-number {
            border-radius: 29px;
            padding-left: 25px;
        }

    .input-group > .form-control:focus, .input-group > .form-floating:focus-within, .input-group > .form-select:focus {
        z-index: 0;
    }

    .code {
        z-index: 100;
    }

    .verfiy-form {
        position: relative;
        place-items: center;
    }

    form {
        width: 80%;
        margin: auto;
    }


    .input-group-append {
        position: absolute;
        right: 0;
        margin-right: 10px;
    }

    input#code-number {
        padding: 13px !important;
        border-radius: 50px;
    }

    .input-verify {
        border-radius: 29px;
        padding: 13px !important;
        border-radius: 50px !important;
    }

    input#txtemail {
        border-radius: 29px;
    }

    .theme-btn-black {
        border: none;
        background: #0194EF;
        padding: 9px;
        border-radius: 24px;
        color: #fff;
    }

    .area {
        background: #d1ecff;
        background: -webkit-linear-gradient(to left, #8f94fb, #4e54c8);
        width: 100%;
        height: 100vh;
        z-index: 1000;
        display: table;
    }

    .code-verify {
        text-align: center;
        z-index: 100;
        padding-top: 200px;
        /* padding-bottom: 200px; */
    }

    .row.col-lg-6.text-center {
        margin: auto;
    }

    .col-lg-12.code {
        z-index: 1000;
    }

    .input-group-append {
        margin-left: -1px;
    }



    .circles {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    }

        .circles li {
            position: absolute;
            display: block;
            list-style: none;
            width: 20px;
            height: 20px;
            background: #fff;
            /* background: rgba(255, 255, 255, 0.2); */
            animation: animate 7s linear infinite;
            bottom: -150px;
        }

            .circles li:nth-child(1) {
                left: 25%;
                width: 80px;
                height: 80px;
                border-radius: 50px;
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
                color: #DAEDFA;
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
                color: #DAEDFA;
            }

            .circles li:nth-child(6) {
                left: 75%;
                width: 110px;
                height: 110px;
                animation-delay: 3s;
                color: #DAEDFA;
            }

            .circles li:nth-child(7) {
                left: 35%;
                color: #DAEDFA;
                width: 150px;
                height: 150px;
                animation-delay: 7s;
            }

            .circles li:nth-child(8) {
                left: 50%;
                background: #d0dbe3;
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
            transform: translate(0) rotate(360deg);
            opacity: 1;
            border-radius: 0;
        }

        100% {
            transform: translateY(-1000px) rotate(360deg);
            opacity: 0;
            border-radius: 50%;
        }
    }


    @media only screen and (max-width:767px) {
        .code-verify {
            padding-top: 20px;
        }

        form {
            width: 100% !important;
        }
    }

    #lblpopupm {
        right: 0;
        text-align: right;
    }

    #MM_role {
        font-size: 14px !important;
    }

    #ddlNationality {
        height: 44px;
    }

    .modal-dialog {
        z-index: 9999 !important;
    }

    #div_modal .two-column__form {
        width: 80%;
        margin: auto;
        z-index: 99999;
    }

        #div_modal .two-column__form input {
            border: 1px solid #ccc !important;
            border-radius: 10px;
        }

    #btnmmp_submit {
        padding: 10px 30px;
    }

    @media(max-width:420px) {
        .checkcode {
            padding: 14px 12px !important;
        }
    }

    html .btn-primary {
        background: -webkit-linear-gradient(180deg, rgba(73 141 247) 0%, rgb(30 165 254) 100%);
        background: linear-gradient(180deg, rgb(78 141 183) 0%, rgb(30 165 254) 100%);
        color: #ffffff !important;
        border: none;
        font-weight: bold;
        padding-top: 0.7em;
        padding-bottom: 0.7em;
    }

        html .btn-primary:hover, html .btn-primary.hover {
            color: #ffffff;
            box-shadow: 0px 4px 10px rgb(151 207 244);
            transform: translateY(-2px);
        }

    .checkcode5 {
        padding: 40px 30px;
        width: 100%;
        margin: 0px auto;
        display: block;
        background-image: linear-gradient(to right, #ffffff, #ffffff, #cfe9f4, #c3eac3, #f8ba8e);
        top: 50%;
        left: 50%;
        border-radius: 20px;
        box-shadow: 0px 15px 30px rgb(0 0 0 / 10%);
        overflow: hidden;
    }

        .checkcode5 #evercrop h3 {
            color: #fb7d34;
        }

        .checkcode5 #nutravel h3 {
            color: #fb7d34;
        }

        .checkcode5 .web_links {
            padding-left: 5em;
            position: relative;
            min-height: 62px;
            text-align: left;
            border: none;
            border-radius: 4px;
            margin-bottom: 8px;
            padding-right: 10px;
            transition: 0.5s ease;
            padding-bottom: 0px;
            display: flex;
            align-items: center;
            justify-content: start;
        }

            .checkcode5 .web_links.facebook {
                background: #4790ef;
            }

            .checkcode5 .web_links.whats-app {
                background: #5cb35c;
            }

            .checkcode5 .web_links.website {
                background: #498ecc;
            }

            .checkcode5 .web_links a {
                /*color: #FFF;
        top: 0;
        font-weight: 500;
        font-size: 16px;*/
                color: #FFF;
                top: 0;
                font-weight: 500;
                font-size: 16px;
                text-overflow: ellipsis;
                white-space: nowrap;
                overflow: hidden;
            }

        .checkcode5 .group label {
            left: auto;
            top: 20px;
        }

        .checkcode5 .group input:focus ~ label, .checkcode5 .group input:valid ~ label {
            top: 0px;
        }

        .checkcode5 .group input.form-control {
            border-radius: 0px;
            border: 0px solid black !important;
            font-size: 18px !important;
            color: black !important;
            box-shadow: none;
            height: 45px !important;
            font-family: 'Lato', sans-serif;
            border-bottom: 1px solid #989898 !important;
            background-color: transparent !important;
            padding: 6px 0px;
            box-shadow: none !important;
            padding-top: 27px;
        }

        .checkcode5 .web_links span {
            position: absolute;
            top: 5px;
            left: 9px;
            width: 50px;
            height: 50px;
            border-radius: 0;
            overflow: hidden;
        }

    body {
        font-family: 'Lato', sans-serif;
    }

    .red {
        color: red !important;
    }

    .check-code-text-headding {
        font-weight: 500;
        font-size: 15px;
        color: #5f5c5c;
        margin-bottom: 0px;
        line-height: 21px !important;
        text-align: left !important;
        padding-left: 15px;
        position: relative;
        display: inline-block;
    }

        /*.check-code-text-headding {
        font-size: 15px;
        color: #343535;
        margin-bottom: 0px;
        line-height: 28px !important;
        text-align: left !important;
        padding-left: 15px;
        position: relative;
        display: inline-block;
        font-weight: bold;
        margin-top: 0;
    }*/

        .check-code-text-headding:after {
            content: '';
            border-left: 4px solid #6b9ac1;
            position: absolute;
            left: 0px;
            top: 0px;
            height: 100%;
        }

    .checkcode {
        padding: 40px 30px;
        /* max-width: 500px; */
        margin: 0px auto;
        display: block;
        background: #ffffff;
        /* position: absolute; */
        /* transform: translate(-50%, -50%); */
        top: 50%;
        left: 50%;
        /* width: 90%; */
        border-radius: 4px;
        border-top: 3px solid #50a3e8;
        box-shadow: 0px -2px 60px rgba(0, 0, 0, 0.2);
        overflow: hidden;
    }

        .checkcode input[type="button"] {
            background: #2f90e5;
            color: #FFF;
            padding: .650rem .895rem;
            border-radius: 3px;
        }

            .checkcode input[type="button"]:hover, .checkcode input[type="button"]:focus, .checkcode input[type="button"]:active {
                box-shadow: 0px 6px 10px rgba(47, 144, 229, 0.5);
            }

    .box-coats, .box-skydecore {
        padding: 40px 30px;
        /* max-width: 500px; */
        margin: 0px auto;
        display: block;
        background: #ffffff url(../assets/images/background/coats-bg.jpg) !important;
        /* position: absolute; */
        /* transform: translate(-50%, -50%); */
        /* top: 50%; */
        /* left: 50%; */
        /* width: 90%; */
        border-radius: 4px;
        border-top: none;
        box-shadow: 0px -2px 60px rgb(0 0 0 / 20%);
        overflow: hidden;
        background-position: center center;
        background-size: contain !important;
        background-repeat: no-repeat !important;
        width: 100%;
    }

    .box-skydecore {
        padding: 40px 30px;
        /* max-width: 500px; */
        margin: 0px auto;
        display: block;
        background: #ffffff url(./assets/images/skydecore-bg.jpg) !important;
        /* position: absolute; */
        /* transform: translate(-50%, -50%); */
        /* top: 50%; */
        /* left: 50%; */
        /* width: 90%; */
        border-radius: 4px;
        border-top: none;
        box-shadow: 0px -2px 60px rgb(0 0 0 / 20%);
        overflow: hidden;
        background-position: center center;
        background-size: cover !important;
        background-repeat: no-repeat !important;
        width: 100%;
    }

        .box-coats input.form-control, .box-skydecore input.form-control {
            border-radius: 0px;
            border: 1px solid #2f90e5 !important;
            font-size: 14px !important;
            color: black !important;
            box-shadow: none;
            height: 44px !important;
            font-family: 'Lato', sans-serif;
            /* border-bottom: 1px solid #ffffff !important; */
            background-color: #ffffffa3 !important;
            padding: 6px 10px;
            box-shadow: none !important;
            border: 1px solid #000;
            margin-top: 10px;
            border-radius: 3px;
        }

        .box-coats input:focus ~ label, .box-coats input:valid ~ label, .box-skydecore input:focus ~ label, .box-skydecore input:valid ~ label {
            top: -12px;
            font-size: 11px;
            color: #50a3e8;
            background: #FFF;
            padding: 0 9px;
            border-radius: 10px;
            /* border: 1px solid #2f90e5;*/
        }

        .box-coats .curve::after, .box-skydecore .curve::after {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            background: rgb(255 255 255 / 74%);
            height: 100%;
            content: '';
            content: '';
            z-index: -1;
        }

        .box-coats .curve, .box-skydecore .curve {
            position: relative;
            z-index: 2;
        }

            .checkcode .curve svg, .box-skydecore .curve svg {
                position: absolute;
                bottom: 0;
                width: 100%;
                left: 0;
                transform: rotate(-180deg);
            }

                .checkcode .curve svg path {
                    fill: #d9261c;
                }

                .box-skydecore .curve svg path {
                    fill: #4da0e9;
                }

        .box-coats fieldset span, .box-skydecore fieldset span {
            margin-right: 18px;
            margin-left: 10px;
            color: #335979;
            font-weight: 600;
        }

    .checkcode .curve h4 {
        color: #2b5a84
    }

    .checkcode .curve #warrantyMsg {
        color: #2076b9;
    }

    input.form-control {
        border-radius: 0px;
        border: 0px solid black !important;
        font-size: 14px !important;
        color: black !important;
        box-shadow: none;
        height: 44px !important;
        font-family: 'Lato', sans-serif;
        border-bottom: 1px solid #989898 !important;
        background-color: transparent !important;
        padding: 6px 0px;
        box-shadow: none !important;
    }

    .message-box {
        /*background: #3aa0e8; 
        padding: 15px;
        margin-bottom: 20px; 
        border-radius: 4px; 
        color: #FFF;*/
    }

    .message-box1 {
        background: #3aa0e8;
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 4px;
        color: #FFF;
    }

    .code-message {
        /* background: #17a0d6;
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 4px;
        color: #FFF;*/
    }

        .code-message p {
            /* margin:0 auto !important;*/
            /*     color:#FFF !important; */
        }

    .web_links {
        padding-left: 5em;
        position: relative;
        min-height: 62px;
        text-align: left;
        border: 1px solid #d1d8e1;
        border-radius: 4px;
        margin-bottom: 8px;
        padding-right: 10px;
        transition: 0.5s ease;
        padding-bottom: 8px;
    }

        .web_links span {
            position: absolute;
            top: 5px;
            left: 9px;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            overflow: hidden;
        }

        .web_links a {
            position: relative;
            top: 17px
        }

        .web_links:hover {
            box-shadow: 0px 2px 20px rgba(0, 0, 0, 0.2);
            transition: 0.5s ease;
        }

    /*body {*/
    /* background: url(https://newmibridges.michigan.gov/resource/1557577540000/ISD_Icons/landing-page/group-3.svg);*/
    /*background: #f7f7f7 url(assets/images/codecheck-bg.svg);
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
        background-attachment: fixed;
        margin: 4em auto;
        height: 75vh;
    }*/

    ::placeholder { /* Chrome, Firefox, Opera, Safari 10.1+ */
        color: #3c3838 !important;
        opacity: 1; /* Firefox */
    }

    :-ms-input-placeholder { /* Internet Explorer 10-11 */
        color: #3c3838 !important;
    }

    .mb-15 {
        margin-bottom: 20px;
    }

    ::-ms-input-placeholder { /* Microsoft Edge */
        color: #3c3838 !important;
    }

    .hintline p {
        color: #292828;
        margin-bottom: 0px;
        line-height: 26px;
        font-size: 16px;
        font-weight: 400;
        text-align: left;
        margin: 25px auto;
    }

    .next_btn {
        background: #2d85cf;
        padding: 5px 30px;
        color: white !important;
        text-transform: uppercase;
        font-size: 14px;
        border: 1px solid gray;
        margin-top: 20px;
        margin: 20px auto 0px;
        text-align: center;
        box-shadow: 0px 0px 8px rgb(45, 133, 207,0.3);
        float: right;
        border-radius: 3px;
        text-align: center;
        display: table;
        float: none !important;
        margin: 0 auto;
    }

    .pline {
        color: black;
        font-size: 16px;
        margin: 15px auto 30px auto;
        font-weight: 400;
    }

    .hintline {
        margin-bottom: 15px;
    }

    .group {
        position: relative;
        margin-bottom: 0px;
        /*margin-top: 35px;*/
        margin-top: 0px;
    }

    input {
        font-size: 18px;
        padding: 18px 10px 10px 5px;
        display: block;
        width: 100%;
        border: none;
        border-bottom: 1px solid #0a0a0a;
        background: transparent;
    }

    fieldset input[type=radio] {
        box-sizing: border-box;
        padding: 0;
        width: 12px;
        margin: 0;
        padding: 0 !important;
        position: relative;
        top: 4px;
    }

    fieldset span {
        margin-right: 18px;
        margin-left: 10px;
    }

    input:focus {
        outline: none;
        border-color: #4da0e9
    }

    /* LABEL ======================================= */
    .group label {
        color: #a09d9d;
        font-size: 14px;
        font-weight: normal;
        position: absolute;
        pointer-events: none;
        left: 5px;
        top: 10px;
        transition: 0.2s ease all;
        -moz-transition: 0.2s ease all;
        -webkit-transition: 0.2s ease all;
        font-weight: 600;
    }

    /* active state */
    input:focus ~ label, input:valid ~ label {
        top: -5px;
        font-size: 12px;
        color: #50a3e8;
    }

    /* BOTTOM BARS ================================= */
    .bar {
        position: relative;
        display: block;
        width: 100%;
    }

        .bar:before, .bar:after {
            content: '';
            height: 1px;
            width: 0;
            bottom: 0px;
            position: absolute;
            background: #5264AE;
            transition: 0.2s ease all;
            -moz-transition: 0.2s ease all;
            -webkit-transition: 0.2s ease all;
        }

        .bar:before {
            left: 50%;
        }

        .bar:after {
            right: 50%;
        }

    /* active state */
    input:focus ~ .bar:before, input:focus ~ .bar:after {
        width: 50%;
    }

    /* HIGHLIGHTER ================================== */
    .highlight {
        position: absolute;
        height: 60%;
        width: 100px;
        top: 25%;
        left: 0;
        pointer-events: none;
        opacity: 0.5;
    }

    /* active state */
    input:focus ~ .highlight {
        -webkit-animation: inputHighlighter 0.3s ease;
        -moz-animation: inputHighlighter 0.3s ease;
        animation: inputHighlighter 0.3s ease;
    }

    /* ANIMATIONS ================ */
    @-webkit-keyframes inputHighlighter {
        from {
            background: #5264AE;
        }

        to {
            width: 0;
            background: transparent;
        }
    }

    @-moz-keyframes inputHighlighter {
        from {
            background: #5264AE;
        }

        to {
            width: 0;
            background: transparent;
        }
    }

    @keyframes inputHighlighter {
        from {
            background: #5264AE;
        }

        to {
            width: 0;
            background: transparent;
        }
    }

    .outer_div {
        display: inline-block;
        width: 100%;
        height: 100%;
        /* padding: 30px; */
        background: transparent;
        border-radius: 10px;
        /* margin-top: 6em; */
        position: relative;
    }

    .fill_div {
        display: inline-block;
        width: 100%;
        height: 100%;
        padding: 30px;
        background: rgb(255 255 255) !important;
        border-radius: 10px;
        border: 1px solid rgba(255, 255, 255, 0.2);
        margin-top: 6em;
        position: relative;
        box-shadow: 0px 2px 20px rgba(0, 0, 0, 0.2);
    }

    .filter {
        width: 100%;
        display: inline-block;
        text-align: center;
    }

    input[type=number]::-webkit-inner-spin-button,
    input[type=number]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        margin: 0;
    }

    .filter span {
        width: 40px;
        height: 40px;
        background: #b3d6f3;
        display: inline-block;
        color: white;
        padding: 7px 8px;
        text-align: center;
        border-radius: 50%;
        font-weight: 300;
        margin: 0px 90px 20px 0px;
        position: relative;
        transition: all 0.5s;
        cursor: pointer;
    }

        .filter span:last-child {
            margin-right: 0px
        }

        .filter span.active {
            background: #2d85cf;
        }

        .filter span:hover {
            background: #8bbce4;
        }

            .filter span:hover:before {
                border-top: 10px solid #8bbce4;
            }

        .filter span:after {
            content: "";
            border-bottom: 2px solid #2d85cf;
            width: 237%;
            position: absolute;
            top: 20px;
            left: 40px;
            cursor: pointer;
            transition: all 0.5s;
        }

        .filter span::before {
            content: "";
            border-top: 10px solid transparent;
            border-right: 10px solid transparent;
            border-left: 10px solid transparent;
            position: absolute;
            top: 100%;
            left: 10px;
            margin-top: -4px;
            cursor: pointer;
            transition: all 0.5s;
        }

        .filter span.active::before {
            content: "";
            border-top: 10px solid #2d85cf;
            border-right: 10px solid transparent;
            border-left: 10px solid transparent;
            position: absolute;
            top: 100%;
            left: 10px;
            margin-top: -4px;
            cursor: pointer;
        }

        .filter span.active {
            background: #2d85cf;
        }

        .filter span.step3:after {
            content: "";
            border-bottom: 0px solid #2d85cf;
            width: 110%;
            position: absolute;
            top: 20px;
            left: 40px;
            z-index: -1;
        }


    @media(max-width:560px) {
        .web_links a {
            position: relative;
            top: 5px;
        }

        .filter span {
            width: 40px;
            height: 40px;
            display: inline-block;
            color: white;
            padding: 7px 8px;
            text-align: center;
            border-radius: 50%;
            font-weight: 300;
            margin: 0px 40px 20px 0px;
            position: relative;
            transition: all 0.5s;
            cursor: pointer;
        }

            .filter span.step3:after {
                border: 0px !important;
            }

            .filter span:after {
                width: 160%;
            }
    }

    @media only screen and (max-width: 320px) {
        .input1 {
            height: 60px;
        }
    }

    /*========Rizwan from VCQRU=============*/
    .outer_div .brand {
        width: 120px;
        height: 120px;
        margin: 0 auto;
        background: #fff;
        position: relative;
        z-index: 2;
        margin-top: -44px;
        border-radius: 50%;
        box-shadow: 0px 2px 20px rgba(0, 0, 0, 0.2);
        border: 8px solid #f3f3f3;
        overflow: hidden;
    }

        .outer_div .brand img {
            max-height: 300px;
            display: block;
            width: 100%;
        }

    .section_type {
        width: auto;
        padding: 0 !important;
    }

        .section_type .column_cols {
            position: relative;
            overflow: hidden;
        }

            .section_type .column_cols h3 {
                font-weight: 700;
                font-size: 16px;
                text-transform: uppercase;
                letter-spacing: 0.1px;
                margin-bottom: 10px;
                padding-bottom: 10px;
                border-bottom: 1px solid #f3f1f1;
            }

            .section_type .column_cols .yout_tube {
                width: 60px;
                height: 60px;
                margin: 0 auto;
            }

                .section_type .column_cols .yout_tube img {
                    width: 100%;
                    max-height: 60px;
                }

            .section_type .column_cols .brand {
                width: 150px;
                height: 150px;
                margin: 0 auto;
                margin-top: -130px;
                ;
                background: #fff;
                z-index: 1;
                border-radius: 50%;
                box-shadow: 0px 2px 20px rgba(0, 0, 0, 0.2);
                border: 8px solid #f3f3f3;
                overflow: hidden;
            }

                .section_type .column_cols .brand img {
                    max-height: 300px;
                    display: block;
                    width: 100%;
                }

            .section_type .column_cols .box_vertical {
                background: #f9f9f9;
                border-radius: 4px;
                overflow: hidden;
                box-shadow: 0px -2px 60px rgba(0, 0, 0, 0.2);
            }

                .section_type .column_cols .box_vertical img {
                    width: 100%;
                    max-height: 500px;
                    display: block;
                }

    .box_info {
        padding: 15px;
        background: #FFF;
        box-shadow: 0px 4px 30px rgba(0, 0, 0, 0.1);
        border-radius: 4px;
    }

    .ie-shape-wave-1 {
        overflow: hidden;
        vertical-align: middle;
        position: fixed;
        bottom: 0;
        left: 0;
        z-index: -1;
        fill: #596bea;
    }

    .section_type .column_cols label {
        position: relative;
        top: 0;
        left: 0;
        font-weight: 600;
    }

    .displayNone {
        display: none !important;
    }

    .mcenter-box {
        margin: 0 auto;
    }

    .btn_pomprimary {
        border-radius: 30px;
        background-color: #4da0e9;
        border-color: #4da0e9;
        color: #FFF !important;
        margin: 0;
        margin-top: 0 !important;
    }

        .btn_pomprimary:hover, .btn_pomprimary:focus {
            background-color: #0c70bd;
            border-color: #0c70bd;
        }

    .responsive-box {
        transition: 0.5s ease-in-out;
    }

        .responsive-box img {
            width: 100%;
            max-height: 400px;
        }

        .responsive-box:hover {
            transform: translateY(-2px);
            box-shadow: 0px 2px 30px #0000003b;
        }

    .owl-carousel {
        margin-bottom: 0;
    }

        .owl-carousel .owl-nav button[class*="owl-"] {
            background-color: #4da0e9;
            border-color: #4da0e9;
            color: #ffffff;
            border-radius: 50%;
        }

    .owl-nav span {
        color: #fffdfd;
        line-height: 25px;
        margin: 0 0 20px;
        font-size: 14px;
        display: none;
    }

    .owl-carousel .owl-item img {
        -webkit-transform-style: unset;
        transform-style: unset;
        border-radius: 4px;
        width: 100%;
        /*max-height: 320px;*/
        max-height: 140px;
        border: 1px solid #eaeaea;
        transition: all 0.5s ease;
    }

        .owl-carousel .owl-item img:hover {
            transform: scale(1.1);
            z-index: 2;
        }

    .owl-theme .owl-dots {
        display: none;
    }

    .owl-carousel .owl-nav {
        display: none;
    }

    .owl-carousel:hover .owl-nav {
        display: block;
    }

    @media (max-width: 768px) {
        .text-xcenter {
            text-align: center;
        }
    }

    @media (max-width: 640px) {
        .owl-carousel .owl-item img {
            height: 100%;
            max-height: 100%;
        }
    }

    @media (min-width: 1200px) {
        .checkcode {
            max-width: 550px;
            margin: 0px auto;
            display: block;
            background: #ffffff;
            position: relative;
            top: 0;
            left: 0;
            /*top: 50%;
        transform: translateY(-50%);*/
        }
    }

    @media (max-width: 1400px) {
        .outer_div {
            height: auto;
        }

        .section_type {
            width: 100%;
            padding-top: 0 !important;
            margin-top: 0em;
        }

        .box-coats, .box-skydecore {
            padding: 40px 30px;
            /* max-width: 500px; */
            margin: 0px auto;
            display: block;
        }

        .checkcode {
            max-width: 550px;
            margin: 0px auto;
            display: block;
            background: #ffffff;
            position: relative;
            transform: none;
            top: 0;
            left: 0;
        }
    }



    #waves {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        top: 0;
        pointer-events: none;
    }

        #waves > svg {
            position: absolute;
            bottom: 0;
            opacity: 0.5;
        }

            #waves > svg:nth-child(1) {
                animation: expand 12s infinite ease-in-out;
            }

            #waves > svg:nth-child(2) {
                animation: expand 16s infinite ease-in;
            }

            #waves > svg:nth-child(3) {
                animation: expand 19s infinite ease-out;
            }

    #sign {
        color: white;
        position: relative;
        z-index: 99;
        transform: translateY(-50px);
    }

    #epingle {
        --epingle-color: #0099ff;
        --epingle-height: 20px;
        position: absolute;
        transform: translateX(-40px) translateY(-40px) rotate(-20deg) scale(0.6);
    }

        #epingle > .circle {
            width: var(--epingle-height);
            height: var(--epingle-height);
            border: 1px solid var(--epingle-color);
            border-radius: 50%;
        }

        #epingle > .cylindre {
            width: calc(var(--epingle-height) * 3);
            height: var(--epingle-height);
            border: 1px solid var(--epingle-color);
            border-radius: 10px;
            position: absolute;
            top: 0;
        }

        #epingle > .circle2 {
            width: var(--epingle-height);
            height: var(--epingle-height);
            border: 1px solid var(--epingle-color);
            background-color: var(--epingle-color);
            border-radius: 50%;
            position: absolute;
            top: 0;
            left: calc(var(--epingle-height) * 2);
        }

    ol {
        padding: 0px;
    }

        ol > li {
            list-style-type: none;
        }

            ol > li::before {
                content: "";
                margin-right: 15px;
            }

            .goutte,
            ol > li::before {
                --goutte-size: 10px;
                display: inline-block;
                width: var(--goutte-size);
                height: var(--goutte-size);
                border-radius: 0 50% 50% 50%;
                border: 1px solid #0099ff;
                transform: rotate(45deg);
            }

    #pluie {
        position: absolute;
        top: -20px;
        right: 0;
        bottom: 0;
        left: 50%;
        z-index: 9999;
        pointer-events: none;
    }

        #pluie > .goutte:nth-child(1) {
            animation: fall 3s infinite ease-out;
        }

        #pluie > .goutte:nth-child(2) {
            animation: fall 3s 0.5s infinite ease-out;
        }

        #pluie > .goutte:nth-child(3) {
            animation: fall 3s 1.5s infinite ease-out;
        }

    @keyframes expand {
        0% {
            transform: scaleX(1);
        }

        50% {
            transform: scaleX(3);
        }

        100% {
            transform: scaleX(1);
        }
    }

    @keyframes fall {
        0% {
            transform: translateY(-30px) rotate(45deg);
        }

        100% {
            transform: translateY(100vh) rotate(45deg);
        }
    }
</style>


<%--Mahindra RID--%>
<script>
    function showModal() {
        $('#Mahindra_Modelpopup').modal('show');
    }


    function getaddress() {
        let pin = document.getElementById("txtmmp_pin").value;
        if (pin.length == 6) {
            $.getJSON("https://api.postalpincode.in/pincode/" + pin, function (data) {
                createHTML(data);
            })
            function createHTML(data) {
                debugger;
                if (data[0].Status == "Success") {
                    var city = "";
                    var state = "";
                    var pin = "";
                    var city = data[0].PostOffice[0]['District'];
                    var state = data[0].PostOffice[0]['State'];
                    var Pin = data[0].PostOffice[0]['PinCode'];
                    $("#txtmmp_city").val(city);
                    if ($("#txtmmp_city").val() != "") {
                        $("#txtmmp_city").prop("readonly", true);
                    }
                    else {
                        $("#txtmmp_city").prop("readonly", false);
                    }
                    $('#hdnstate').val(state);
                    $("#txtmmp_state").val(state);
                    if ($("#txtmmp_state").val() != "") {
                        $("#txtmmp_state").prop("readonly", true);

                        $.ajax({
                            type: "POST",
                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=Binddealer&State=' + $('#txtmmp_state').val() + "&City=" + $('#txtmmp_city').val(),
                            success: function (Data) {

                                $.each(JSON.parse("[" + Data + "]"), function (index, record) {
                                    // start a loop on the current record in the iteration
                                    $.each(record, function (index2, sub_record) {
                                        $('#ddlNationality').append('<option value="' + sub_record.DealerCode + '">' + sub_record.DealerName + '</option>');
                                    });
                                });
                            }
                        });
                    }
                    else {
                        $("#txtmmp_state").prop("readonly", false);
                    }
                }
                else {
                    $('#lbltxtmm').text('Please Enter Valid Pin Code*');
                    $('#lbltxtmm').css("color", "red");
                    $('#txtmmp_pin').focus();
                    return false;
                }
            }
        }
    }


    $(document).ready(function () {
        $("#ddlNationality").change(function () {
            debugger;
            if ($('#ddlNationality').val() != "" || $('#ddlNationality').val() != undefined) {
                var ddl = $("#ddlNationality option:selected").val();
                $('#txtmmp_dealercode').val(ddl);
                $("#txtmmp_dealercode").prop("readonly", true);
            }
        });
    });

    function validategst() {
        if ((!($('#inlineRadio1').prop('checked'))) && (!($('#inlineRadio2').prop('checked')))) {

            $('#lbltxtmm').text("Please Select Document Type");
            $('#lbltxtmm').css('color', 'red');
            return false;
        }
        else {
            $('#lbltxtmm').text('');
        }
        if ((($('#inlineRadio1').prop('checked'))) && (!($('#inlineRadio2').prop('checked')))) {
            $('#txtmmp_gst').prop('maxlength', '15')
            var gst = $('#txtmmp_gst').val();
            var gstinformat = new RegExp('^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');
            if ($('#txtmmp_gst').val() == '') {
                $('#lbltxtmm').text('Please Enter GST Number');
                $('#lbltxtmm').css('color', 'red');
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            if (!gstinformat.test(gst) && gst != '') {
                $('#lbltxtmm').text('Invalid GST Number');
                $('#lbltxtmm').css('color', 'red');
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
        }


        if ((!($('#inlineRadio1').prop('checked'))) && (($('#inlineRadio2').prop('checked')))) {
            $('#txtmmp_gst').prop('maxlength', '12')
            var regex = /^([0-9]{4}[0-9]{4}[0-9]{4}$)|([0-9]{4}\s[0-9]{4}\s[0-9]{4}$)|([0-9]{4}-[0-9]{4}-[0-9]{4}$)/;
            if (!regex.test($("#txtmmp_gst").val())) {
                $('#lbltxtmm').text('Invalid Adhar Number');
                $('#lbltxtmm').css('color', 'red');
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
        }
    }


    $(document).ready(function () {
        $('#btnmmp_submit').click(function (e) {
            e.preventDefault();
            var name = $('#txtmmp_name').val();
            var mobile = $('#txtmmp_mobile').val();
            var gst_or_adhar = $('#txtmmp_gst').val();
            var shopname = $('#txtmmp_shop').val();
            var pin = $('#txtmmp_pin').val();
            var city = $('#txtmmp_city').val();
            var state = $('#txtmmp_state').val();
            //var dealername = $('#txtmmp_dealername').val();
            var dealercode = $('#txtmmp_dealercode').val();
            var lable = $('#lblmmp').val();
            //Validation For Name
            if (name == "") {
                $('#lbltxtmm').text('Please Enter Your Full Name*');
                $('#lbltxtmm').css('color', 'red');
                $('#txtmmp_name').focus();
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            var matches = $('#txtmmp_name').val().match(/\d+/g);
            if (matches != null) {
                $('#lbltxtmm').text('Name Should be alphabet only*');
                $('#lbltxtmm').css('color', 'red');
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            var matches1 = $('#txtmmp_name').val().match(/[^a-zA-Z0-9 ]/);
            if (matches1 != null) {
                $('#lbltxtmm').text('Name Should Not Contain Any Special Character*');
                $('#lbltxtmm').css('color', 'red');
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            //End Of Name Validation

            //Validation for Mobile no
            if (mobile == "") {
                $('#lbltxtmm').text('Please Enter Mobile Number*');
                $('#lbltxtmm').css('color', 'red');
                $('#txtmmp_mobile').focus();
                return false;
            }
            if (mobile.length > 10) {
                $('#lbltxtmm').text('Please Enter 10 Digit Mobile Number*');
                $('#lbltxtmm').css('color', 'red');
                $('#txtmmp_mobile').focus();
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            if (mobile != undefined) {
                if (mobile.length < 10) {
                    $('#lbltxtmm').text('Please Enter 10 Digit Mobile Number*');
                    $('#lbltxtmm').css('color', 'red');
                    $('#txtmmp_mobile').focus();
                    return false;
                }
                else {
                    $('#lbltxtmm').text('');
                }
                if (mobile.match(/[^$,.\d]/)) {
                    $('#lbltxtmm').text('Please Enter Numeric Value for Mobile No*');
                    $('#lbltxtmm').css('color', 'red');
                    $('#txtmmp_mobile').focus();
                    return false;
                }
                else {
                    $('#lbltxtmm').text('');
                }
                var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;
                if (filter.test(mobile)) {
                    if (mobile.length == 10) {
                        var c = mobile.slice(0, 1);
                        if (c <= 5) {
                            $('#lbltxtmm').text('Please Enter Valid Mobile No*');
                            $('#lbltxtmm').css('color', 'red');
                            $('#txtmmp_mobile').focus();
                            return false;
                        }
                        else {
                            $('#lbltxtmm').text('');
                        }
                    }
                }

                if (mobile.match(/[^$,.\d]/)) {
                    $('#lbltxtmm').text('Name Should be alphabet only*');
                    $('#lbltxtmm').css('color', 'red');
                    $('#txtmmp_mobile').focus();
                    return false;
                }
                else {
                    $('#lbltxtmm').text('');
                }
            }
            //End Of Mobile no Validation

            if ((!($('#inlineRadio1').prop('checked'))) && (!($('#inlineRadio2').prop('checked')))) {
                $('#lbltxtmm').css('color', 'red');
                $('#lbltxtmm').text("Please Select Document Type");
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            if ((($('#inlineRadio1').prop('checked'))) && (!($('#inlineRadio2').prop('checked')))) {
                $('#txtmmp_gst').prop('maxlength', '15')
                var gst = $('#txtmmp_gst').val();
                var reggst = /^([0-9]){2}([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}([0-9]){1}([a-zA-Z]){1}([0-9]){1}?$/;
                if ($('#txtmmp_gst').val() == '') {
                    $('#lbltxtmm').text('Please Enter GST Number');
                    $('#lbltxtmm').css('color', 'red');
                    return false;
                }
                else {
                    $('#lbltxtmm').text('');
                }
                if (!reggst.test(gst) && gst != '') {
                    $('#lbltxtmm').text('Invalid GST Number');
                    $('#lbltxtmm').css('color', 'red');
                    return false;
                }
                else {
                    $('#lbltxtmm').text('');
                }
            }


            if ((!($('#inlineRadio1').prop('checked'))) && (($('#inlineRadio2').prop('checked')))) {
                $('#txtmmp_gst').prop('maxlength', '12')
                var regex = /^([0-9]{4}[0-9]{4}[0-9]{4}$)|([0-9]{4}\s[0-9]{4}\s[0-9]{4}$)|([0-9]{4}-[0-9]{4}-[0-9]{4}$)/;
                if (!regex.test($("#txtmmp_gst").val())) {
                    $('#lbltxtmm').text('Invalid Adhar Number');
                    $('#lbltxtmm').css('color', 'red');
                    return false;
                }
                else {
                    $('#lbltxtmm').text('');
                }
            }




            //Validation for Retailer Adhar/GST
            if (gst_or_adhar == "") {
                $('#lbltxtmm').text('Please Enter Adhar/Gst Number*');
                $('#lbltxtmm').css('color', 'red');
                $('#txtmmp_gst').focus();
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }

            //End Of Retailer Adhar/GST Validation

            //Validation for shopname name
            if (shopname == "") {
                $('#lbltxtmm').text('Please Enter Shop Name*');
                $('#lbltxtmm').css('color', 'red');
                $('#txtmmp_shop').focus();
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }

            var matches1 = $('#txtmmp_shop').val().match(/[^a-zA-Z0-9 ]/);
            if (matches1 != null) {
                $('#lbltxtmm').text('Shop Name Should Not Contain Any Special Character*');
                $('#lbltxtmm').css('color', 'red');
                $('#txtmmp_shop').focus();
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            //End Of shopname name Validation

            //Validation for Pin no
            if (pin == "") {
                $('#lbltxtmm').text('Please Enter Area Pin Code*');
                $('#lbltxtmm').css('color', 'red');
                $('#txtmmp_pin').focus();
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            if (pin.length < 6) {
                $('#lbltxtmm').text('Please Enter 6 Digit Pin Code*');
                $('#lbltxtmm').css('color', 'red');
                $('#txtmmp_pin').focus();
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            if (pin.match(/[^$,.\d]/)) {
                $('#lbltxtmm').text('Please Enter Numeric Value for Pin Code*');
                $('#lbltxtmm').css('color', 'red');
                $('#txtmmp_pin').focus();
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            //End Of Pin  Validation

            //Validation for City 
            if (city == "") {
                $('#lbltxtmm').text('Please Enter City Name*');
                $('#lbltxtmm').css('color', 'red');
                $('#txtmmp_city').focus();
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            var matches = $('#txtmmp_city').val().match(/\d+/g);
            if (matches != null) {
                $('#lbltxtmm').text('City Name Should be alphabet only*');
                $('#lbltxtmm').css('color', 'red');
                $('#txtmmp_city').focus();
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            var matches1 = $('#txtmmp_city').val().match(/[^a-zA-Z0-9 ]/);
            if (matches1 != null) {
                $('#lbltxtmm').text('City Name Should Not Contain Any Special Character*');
                $('#lbltxtmm').css('color', 'red');
                $('#txtmmp_city').focus();
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            //End Of City Validation

            //Validation for State Name
            if (state == "") {
                $('#lbltxtmm').text('Please Enter State Name*');
                $('#lbltxtmm').css('color', 'red');
                $('#txtmmp_state').focus();
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            var matches = $('#txtmmp_state').val().match(/\d+/g);
            if (matches != null) {
                $('#lbltxtmm').text('State Name Should be alphabet only*');
                $('#lbltxtmm').css('color', 'red');
                $('#txtmmp_state').focus();
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            var matches1 = $('#txtmmp_state').val().match(/[^a-zA-Z0-9 ]/);
            if (matches1 != null) {
                $('#lbltxtmm').text('State Name Should Not Contain Any Special Character*');
                $('#lbltxtmm').css('color', 'red');
                $('#txtmmp_state').focus();
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            //End Of State Validation

            //Validation for Dealer Name 
            var dealername = $('#ddlNationality');


            if (dealername.val() == "") {
                $('#lbltxtmm').text('Please Select Dealer Name*');
                $('#lbltxtmm').css('color', 'red');
                $('#ddlNationality').focus();
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }

            //End Of Dealer Name Validation

            //Validation for Dealer Code
            if (dealercode == "") {
                $('#lbltxtmm').text('Please Enter Dealer Code*');
                $('#lbltxtmm').css('color', 'red');
                $('#txtmmp_dealercode').focus();
                return false;
            }
            else {
                $('#lbltxtmm').text('');
            }
            //End Of Dealer Code Validation


            if (dealername.val() != "" && dealercode != "" && shopname != "" && name != "" && mobile != "") {
                $.ajax({
                    type: "POST",
                    contentType: false,
                    processData: false,

                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=SaveRetailerId&name=' + $('#txtmmp_name').val() + "&mobile=" + $('#txtmmp_mobile').val() + '&gst_or_adhar=' + $('#txtmmp_gst').val() + '&shopname=' + $('#txtmmp_shop').val() + '&pin=' + $('#txtmmp_pin').val() + '&city=' + $('#txtmmp_city').val() + '&state=' + $('#txtmmp_state').val() + '&dealercode=' + $('#txtmmp_dealercode').val() + '&dealername=' + $("#ddlNationality option:selected ").text(),
                    success: function (data) {
                        //alert(data);
                        if (data.split('~')[0] == "Success") {
                            alert("Please Note RID & Dealer Code for Future Reference  RID " + data.split('~')[1] + " Dealer Code " + data.split('~')[2]);
                            $('#empID').val(data.split('~')[1]);
                            $('#distributorID').val(data.split('~')[2]);
                            $('#Mahindra_Modelpopup').modal('hide');
                        }
                        else if (data.split('~')[0] == "Already registered !.") {
                            alert("Already Registered!");
                            //$('#empID').val(data.split('~')[1]);
                            //$('#distributorID').val(data.split('~')[2]);
                            $('#Mahindra_Modelpopup').modal('hide');
                        }
                        else {
                            alert("You are Not Valid ");
                            $('#Mahindra_Modelpopup').modal('hide');
                        }
                    }
                });
            }
        });
    });
</script>
<%--Mahindra RID--%>



<%--<div style="display:none">
    <div id="pluie">
        <div class="goutte"></div>
        <div class="goutte"></div>
        <div class="goutte"></div>
    </div>
    <div id="sign">
        <div id="epingle">
            <div class="circle"></div>
            <div class="cylindre"></div>
            <div class="circle2"></div>
        </div>

    </div>
    <div id="waves">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
            <path fill="#0099ff" fill-opacity="1" d="M0,96L34.3,101.3C68.6,107,137,117,206,138.7C274.3,160,343,192,411,170.7C480,149,549,75,617,69.3C685.7,64,754,128,823,181.3C891.4,235,960,277,1029,266.7C1097.1,256,1166,192,1234,144C1302.9,96,1371,64,1406,48L1440,32L1440,320L1405.7,320C1371.4,320,1303,320,1234,320C1165.7,320,1097,320,1029,320C960,320,891,320,823,320C754.3,320,686,320,617,320C548.6,320,480,320,411,320C342.9,320,274,320,206,320C137.1,320,69,320,34,320L0,320Z"></path>
        </svg>
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
            <path fill="#0099ff" fill-opacity="1" d="M0,32L30,42.7C60,53,120,75,180,90.7C240,107,300,117,360,106.7C420,96,480,64,540,48C600,32,660,32,720,53.3C780,75,840,117,900,144C960,171,1020,181,1080,176C1140,171,1200,149,1260,128C1320,107,1380,85,1410,74.7L1440,64L1440,320L1410,320C1380,320,1320,320,1260,320C1200,320,1140,320,1080,320C1020,320,960,320,900,320C840,320,780,320,720,320C660,320,600,320,540,320C480,320,420,320,360,320C300,320,240,320,180,320C120,320,60,320,30,320L0,320Z"></path>
        </svg>
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
            <path fill="#0099ff" fill-opacity="1" d="M0,256L40,234.7C80,213,160,171,240,149.3C320,128,400,128,480,144C560,160,640,192,720,202.7C800,213,880,203,960,202.7C1040,203,1120,213,1200,218.7C1280,224,1360,224,1400,224L1440,224L1440,320L1400,320C1360,320,1280,320,1200,320C1120,320,1040,320,960,320C880,320,800,320,720,320C640,320,560,320,480,320C400,320,320,320,240,320C160,320,80,320,40,320L0,320Z"></path>
        </svg>
    </div>
</div>--%>
<div class="context">
</div>

<div class="area">
    <ul class="circles ">
        <li class="rounded-circle"></li>
        <li class="rounded-circle"></li>
        <li class="rounded-circle"></li>
        <li class="rounded-circle"></li>
        <li class="rounded-circle"></li>
        <li class="rounded-circle"></li>
        <li class="rounded-circle"></li>
        <li class="rounded-circle"></li>
        <li class="rounded-circle"></li>
        <li class="rounded-circle"></li>


    </ul>

    <div class="container mt-5">
        <p id="msg" style="display: none"></p>
        <div id="dvouter" class="outer_div">
            <div id="clogo" class="brand displayNone">
                <img src="../images/Flora/flora-logo.jpg" alt="flora-logo">
            </div>

            <div id="maincode" class="row">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-7 mb-4 mcenter-box">
                            <div class="checkcode fadeInDown animated" id="checkcode0">
                                <div class="row">
                                    <div id="code" class="col-md-12 hintline">
                                        <div class="filter">
                                            <span class="step1 active">1</span>
                                            <span class="step2">2</span>
                                            <span class="step3">3</span>
                                        </div>
                                        <span class="check-code-text-headding">Scratch to reveal the code and enter the 13 digits code</span>
                                        <br />
                                        <strong style="font-size: 14px; color: #669be9;">13 अंको के कोड को जानने के लिए पैकेट पर चिपके कूपन को  खरोंचे। </strong>
                                        <div class="group">
                                            <input type="text" class="input1 step1" required="" value="" data-msg-required="Please enter Code." maxlength="13" name="codeone" id="codeone" autofocus required="required" data-inputmask="'mask': '99999 9999 9999'" />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Enter the Code/कोड भरें</label>
                                        </div>
                                    </div>

                                </div>

                            </div>

                            <div class="checkcode" id="checkcode2" style="display: none">
                                <div class="row">
                                    <div class="col-md-12 hintline" style="text-align: center;">
                                        <img src="../images/loading.gif" alt="loader" style="max-width: 100%;">
                                    </div>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12" style="margin: 0 auto;">
                    <div id="checkcode" class="checkcode5 p-0 bounceIn animated" animation-duration="0.5s" style="display: none;">
                        <!--box-coats-->
                        <div class="curve pl-4 pr-4 pt-4 pb-4">

                            <div class="row">
                                <div id="checkcodein" class="col-md-5" style="margin: 0 auto;">

                                    <div>
                                        <div id="warratyHeading" style="display: block;">
                                            <div style="text-align: center; display: block; width: 100%;" class="mb-4 fadeinDown animated">
                                                <img src="#" id="imgWarrantyLogo" alt="" style="width: 250px; padding: 10px; border-radius: 10px; background: #ffffff; box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.2);" />

                                            </div>
                                            <div id="warrantyMsg" class="fadeinDown animated" style="font-size: 18px; font-weight: bold; margin-bottom: 24px; text-align: center;">Welcome to</div>
                                        </div>

                                        <div class="filter" id="dvfiltermob">
                                            <span class="step1 active">1</span>
                                            <span class="step2 active">2</span>
                                            <span class="step3">3</span>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-12">
                                                <p id="p3msg" class="displayNone" style="margin-top: 5px; color: red;"></p>
                                                <br />
                                                <div class="group" id="chkGun" style="display: none;">
                                                    <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control mobile_num form-control-modal step2" name="number" id="mobile" onkeypress="return isNumber(event,'mobile')" onkeydown="return isNumber(event,'mobile')" required />
                                                    <span class="highlight"></span>
                                                    <span class="bar"></span>
                                                    <label>Enter Mobile Number</label>
                                                </div>


                                                <section id="dvyout" class="section_type displayNone">
                                                    <div class="column_cols">
                                                        <div class="row">

                                                            <div class="col-md-3 text-xcenter">
                                                                <hr />
                                                                <div class="yout_tube">
                                                                    <img src="../images/Flora/youtube.svg">
                                                                </div>
                                                            </div>
                                                            <div class="col-md-9 text-xcenter">
                                                                <!--offset-md-4-->
                                                                <div class="padding-left">
                                                                    <label>How To Claim Points</label>
                                                                    <br>
                                                                    <a href="https://youtu.be/RQPIG62WwuE" target="_blank">https://youtu.be/RQPIG62WwuE</a>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </section>


                                                <div id="divCompany" style="display: none;">
                                                    <div class="group" style="margin-top: 4px;">
                                                        <select data-msg-required="Please select the role." class="form-control form-control-modal" name="role" id="MM_role" required>
                                                            <option value="-1" disable="disable">Select Role</option>
                                                            <option value="3">M-Star Id</option>
                                                            
                                                            <option value="5">SBU Distributor Id</option>
                                                            <option value="1">Technician Id/Techmaster Id</option>
                                                        </select>
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                    </div>

                                                    <div class="group">
                                                        <input type="text" value="" placeholder="Enter Mobile Number" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control mobile_num form-control-modal" name="number" id="MM_mobile" onkeypress="return isNumber(event,'MM_mobile')" onkeydown="return isNumber(event,'MM_mobile')" required />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                        <%--  <label>Enter Mobile Number</label>--%>
                                                    </div>

                                                    <div class="group" style="margin-top: 4px;">
                                                        <input type="text" class="input1" onmousedown="CHKSBUDATA()" required="" style="text-transform: uppercase" value="" placeholder="Enter Technician/Techmaster/M-Star Id/SBU Id" data-msg-required="Please enter Dealer Technician/Techmaster ID." maxlength="15" name="empID" id="empID" autofocus required="required" />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                        <%--<label>Enter Technician/Techmaster/M-Star Id/SBU Id</label>--%>
                                                    </div>
                                                    <div class="group" style="margin-top: 4px; margin-bottom: 3px;">
                                                        <input type="text" class="input1" required="" style="text-transform: uppercase" placeholder="Enter Dealer Code" value="" data-msg-required="Please enter dealer Code." maxlength="13" name="distributorID" id="distributorID" autofocus required="required" />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                        <%--  <label>Enter Dealer Code</label>--%>
                                                    </div>
                                                   
                                                    <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnCompany" />
                                                </div>

                                                <div id="divOtpVerified" style="display: none">
                                                    <span class="check-code-text-headding" id="otpMsg"></span>
                                                    <div class="group">
                                                        <input type="text" value="" data-msg-required="Please enter the otp number." maxlength="4" class="form-control form-control-modal" name="number" id="mmOTP" onkeypress="return isNumber(event)" required />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                        <label>Enter OTP</label>
                                                    </div>
                                                    <div style="float: right;"><a href="javascript:void(0)" id="btnResendOtp">Resend OTP</a></div>
                                                    <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnVerify" />
                                                </div>

                                                <div id="warrenty" style="display: none;">
                                                    <h4>Enter Details to register warranty</h4>
                                                    <div class="group">
                                                        <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control mobile_num form-control-modal" name="number" id="warr_mobile" onkeypress="return isNumber(event,'warr_mobile')" onkeydown="return isNumber(event,'warr_mobile')" required />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                        <label>Enter Mobile Number</label>
                                                    </div>

                                                    <div class="group">
                                                        <input type="email" value="" data-msg-required="Please enter the e-mail address." class="form-control form-control-modal" name="email" id="emailAddress" required />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                        <label>Enter Email Address</label>
                                                    </div>

                                                    <div class="group">
                                                        <input type="text" value="" data-msg-required="Please enter the bill number." class="form-control form-control-modal" name="bill" id="billNumber" required />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                        <label>Enter Bill Number/13 Digit Warranty Number - (under scratch layer)</label>
                                                    </div>

                                                    <div class="group">
                                                        <input type="text" value="" data-msg-required="Please enter the purchase date." placeholder="Enter Purchase Date" class="form-control form-control-modal" name="date" id="purchasedate" required />
                                                        <%--<br /><input type="text" class="datepicker">--%>
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                    </div>

                                                    <div class="group">
                                                        <input type="file" class="form-control form-control-modal" accept="image/*,application/pdf" name="imgbill" id="img_bill" required />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                    </div>

                                                    <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnWarranty" />
                                                </div>
                                                <%--<div id="Coatsbathfitting" style="display: none;">
                                        <h4>Enter Details</h4>
                                             <div class="group">
                                                 <fieldset id="checkArray" class="mb-3" style="display: flex;">
                                            <input type="radio" value="Plumber" name="checkdesignation" checked="checked"><span>Plumber</span>
                                                  <input type="radio" value="Consumer" name="checkdesignation"  /><span>Consumer</span>
                                                  <input type="radio" value="Other" name="checkdesignation"  /><span>Other</span>
                                                     </fieldset>
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                           
                                        </div> 
                                        <div class="group">
                                            <input type="text" value="" data-msg-required="Please enter the Name" class="form-control form-control-modal" name="coats_name" id="coats_name" onkeydown="return /[a-z]/i.test(event.key)" onkeypress="return /[a-z]/i.test(event.key)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Enter Name</label>
                                        </div>
                                        <div class="group">
                                            <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control form-control-modal" name="number" id="coats_mobile" onkeypress="return isNumber(event,'coats_mobile')" onkeydown="return isNumber(event,'coats_mobile')" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Enter Mobile Number</label>
                                        </div>
                                        <div class="mt-3">
                                        <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btncoats" />
                                        </div>
                                    </div>  --%>
                                                <%--<div id="dv_dkymessage" class="message-box rubberBand animated"  data-animation="animated rubberBand">--%>
                                                <p id="sky_message" class="message-box1 rubberBand animated" data-animation="animated rubberBand" style="display: none"></p>
                                                <a href="javascript:void(0)" class="next_btn" id="btnNext2" style="display: none">Close</a>

                                                <%--</div>--%>
                                                <div id="skydecore" style="display: none;">

                                                    <h4>Enter Details</h4>

                                                    <div class="group">
                                                        <input type="text" value="" data-msg-required="Please enter the Name" class="form-control form-control-modal" name="sky_name" id="sky_name" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                        <label>Enter Name</label>
                                                    </div>
                                                    <div class="group pb-2">
                                                        <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control form-control-modal" name="number" id="sky_mobile" onkeypress="return isNumber(event,'coats_mobile')" onkeydown="return isNumber(event,'coats_mobile')" required />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                        <label>Enter Mobile Number</label>
                                                    </div>

                                                    <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnsky" />
                                                </div>
                                                <div id="jpc" style="display: none;">
                                                    <h4>Enter Details</h4>
                                                    <div class="group">
                                                        <input type="text" value="" data-msg-required="Please enter the Dealer mobile number." minlength="10" maxlength="10" class="form-control form-control-modal" name="number" id="jpcdealer_mobile" onkeypress="return isNumber(event,'jpcdealer_mobile')" onkeydown="return isNumber(event,'jpcdealer_mobile')" required />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                        <label>Enter Dealer Mobile Number</label>
                                                    </div>
                                                    <div class="group">
                                                        <input type="text" value="" data-msg-required="Please enter DealerID" class="form-control form-control-modal" name="jpc_dealerid" id="jpc_dealerid" required />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                        <label>Enter Dealer ID</label>
                                                    </div>


                                                    <div class="group">
                                                        <input type="text" value="" data-msg-required="Please enter Dealer Name" class="form-control form-control-modal" name="jpcpainter_name" id="jpcpainter_name" onkeypress="return /[a-z]/i.test(event.key)" onkeydown="return /[a-z]/i.test(event.key)" required />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                        <label>Enter Dealer Name</label>
                                                    </div>
                                                    <div class="group" style="display: none">
                                                        <input type="text" value="6666666666" data-msg-required="Please enter the Painter mobile number." minlength="10" maxlength="10" class="form-control form-control-modal" name="jpcpainter_mobile" id="jpcpainter_mobile" onkeypress="return isNumber(event,'jpcpainter_mobile')" onkeydown="return isNumber(event,'jpcpainter_mobile')" required />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                        <label>Enter Painter Mobile Number</label>
                                                    </div>

                                                    <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnjpc" />
                                                </div>
                                                <div id="divOtpVerified1" style="display: none">
                                                    <span class="check-code-text-headding" id="otpMsg1"></span>
                                                    <div class="group">
                                                        <input type="text" value="" data-msg-required="Please enter the otp number." maxlength="4" class="form-control form-control-modal" name="number" id="nonmmOTP" onkeypress="return isNumber(event)" required />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                        <label>Enter OTP</label>
                                                    </div>
                                                    <div style="float: right;"><a href="javascript:void(0)" id="btnResendOtp1">Resend OTP</a></div>
                                                    <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnskyVerify" />
                                                </div>
                                                <div id="warrentyauto" style="display: none;">
                                                    <h4>Enter Details to register warranty</h4>
                                                    <div class="group">
                                                        <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control mobile_num form-control-modal" name="number" id="autowarr_mobile" onkeypress="return isNumber(event,'autowarr_mobile')" onkeydown="return isNumber(event,'autowarr_mobile')" required />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                        <label>Enter Mobile Number</label>
                                                    </div>


                                                    <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnautoWarranty" />
                                                </div>




                                                <div id="jphcounter" style="display: none;">
                                                    <%--<h4>Enter Details to register warranty</h4>--%>
                                                    <div class="group">
                                                        <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control mobile_num form-control-modal" name="number" id="jph_mobile" onkeypress="return isNumber(event,'jph_mobile')" onkeydown="return isNumber(event,'jph_mobile')" required />
                                                        <span class="highlight"></span>
                                                        <span class="bar"></span>
                                                        <label>Enter Mobile Number</label>
                                                    </div>
                                                    <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnjph" />
                                                </div>

                                            </div>
                                        </div>

                                        <div class="row mb-4" style="display: none">
                                            <div class="col-md-12">
                                                <input type="submit" value="Submit" onclick="return chkgenuenity();" class="btn btn-primary btn-modern" data-loading-text="Loading..." />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 custom-padding-modal-stape" style="display: none">
                                        <div class="row modal-border-right-style">
                                            <div class="col-md-12">
                                            </div>
                                            <div class="col-md-12 text-center">
                                                <img src="./image/logo-1.png" class="" style="width: 70%; height: auto;" />
                                            </div>
                                            <div class="col-md-12">
                                                <p class="check-code-text-right-side">Step 1: Scratch to reveal the code</p>
                                                <p class="check-code-text-right-side">Step 2 Input the code & mobile no. and click the “Verify” button</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>




                                <div id="divdem1" class="col-md-7 displayNone">

                                    <div class="mt-4">
                                        <div class="demos">
                                            <div class="columns box_info">
                                                <div class="owl-carousel owl-theme">
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../images/Flora/user-login.jpg" alt="screen-shots1">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../images/Flora/check-code.jpeg" alt="screen-shots2">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../images/Flora/transaction.jpeg" alt="screen-shots1">
                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-2">
                                        <div class="demos">
                                            <div class="columns box_info">
                                                <div class="owl-carousel owl-theme">
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../images/Flora/wire-cables.jpg" alt="wire-cables">
                                                        <div class="text-center mt-2">
                                                            <h5>Wires and Cables</h5>
                                                        </div>
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../images/Flora/mcb-switch.jpg" alt="mcb-switch">
                                                        <div class="text-center mt-2">
                                                            <h5>MCB</h5>
                                                        </div>
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../images/Flora/main-switch.jpg" alt="main-switch">
                                                        <div class="text-center mt-2">
                                                            <h5>Main Switch</h5>
                                                        </div>
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../images/Flora/capacitors.jpg" alt="capacitors">
                                                        <div class="text-center mt-2">
                                                            <h5>Capacitors</h5>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="text-center"><a href="http://www.competentelectricals.com/" class="btn btn_pomprimary btn-sm">View More</a></div>
                                            </div>
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <!---start products of coats-->
            <div class="row" id="coats" style="display: none">
                <div id="c_logo" class="brand shake animated" style="border-radius: 4px; height: auto; width: 150px">
                    <img src="#" alt="coats-logo" id="coats_logo" style="border-radius: 4px; width: 100%;">
                </div>
                <div class="col-md-12 mt-4" style="margin: 0 auto;">
                    <div id="check_code" class="checkcode5 p-0 fadeInUp animated">
                        <!--box-coats-->
                        <div class="curve pl-4 pr-4 pt-4 pb-4n pb-3">
                            <div class="row">
                                <div id="checkcode_in" class="col-md-5" style="margin: 0 auto;">
                                    <div class="row">
                                        <div class="col-md-12 hintline" id="msgcoats" style="display: none">
                                            <p id="p1msg2"></p>
                                            <a href="javascript:void(0)" class="next_btn" id="btnNext1">Close</a>
                                        </div>
                                    </div>
                                    <div id="Coatsbathfitting">
                                        <h3 id="coatsheading" style="display: none">Welcome to the world of COATS</h3>
                                        <h3 id="skyheading" style="display: none; text-align: center">Welcome to the world of SKYDECOR</h3>
                                        <h4>Enter Details</h4>
                                        <div class="group">
                                            <fieldset id="check_Array" class="mb-3" style="display: flex;">
                                                <input type="radio" value="Plumber" name="checkdesignation" checked="checked"><span>Plumber</span>
                                                <input type="radio" value="Consumer" name="checkdesignation" /><span>Consumer</span>
                                                <!--<input type="radio" value="Other" name="checkdesignation"  /><span>Other</span>-->
                                            </fieldset>
                                            <span class="highlight"></span>
                                            <span class="bar"></span>

                                        </div>
                                        <div class="group">
                                            <input type="text" value="" data-msg-required="Please enter the Name" class="form-control form-control-modal" name="coats_name" id="coats_name" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Enter Name</label>
                                        </div>
                                        <div class="group">
                                            <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control form-control-modal" name="number" id="coats_mobile" onkeypress="return isNumber(event,'coats_mobile')" onkeydown="return isNumber(event,'coats_mobile')" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Enter Mobile Number</label>
                                        </div>
                                        <div class="mt-3">
                                            <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btncoats" />
                                        </div>
                                    </div>
                                    <!--Ever crop  window start -->
                                    <%--<div id="evercrop">
                                         <h3>एवरक्रॉप</h3>
                                        <h4>विवरण दर्ज करें।</h4>
                                        <div class="row">   
                                        <div class="group col-md-12">
                                            <input type="text" value="" data-msg-required="Please enter the Name" class="form-control form-control-modal" name="ever_name" id="ever_name" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>नाम*</label>
                                        </div>
                                        <div class="group col-md-6">
                                            <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control form-control-modal" name="number" id="ever_mobile" onkeypress="return isNumber(event,'ever_mobile')" onkeydown="return isNumber(event,'ever_mobile')" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>मोबाइल नंबर*</label>
                                        </div>
                                        <div class="group col-md-6">
                                            <input type="text" value="" data-msg-required="Please enter village."  class="form-control form-control-modal" name="village" id="ever_village" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>गाँव*</label>
                                        </div>
                                        <!--<div class="group col-md-6">
                                            <input type="text" value="" data-msg-required="Please enter the Panchayat."  class="form-control form-control-modal" name="panchayat" id="panchayat" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>पंचायत</label>
                                        </div>-->
                                        <div class="group col-md-12">
                                            <input type="text" value="" data-msg-required="Please enter district."  class="form-control form-control-modal" name="district" id="ever_district" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>जिला*</label>
                                        </div>
                                         <div class="group col-md-12">
                                            <input type="text" value="" data-msg-required="Please enter the state."  class="form-control form-control-modal" name="state" id="ever_state" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>राज्य*</label>
                                        </div>
                                        <div class="group col-md-12">
                                            <input type="text" value="" data-msg-required="Please enter the state."  class="form-control form-control-modal" name="Country" id="ever_country" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>देश*</label>
                                        </div>
                                        
                                        <div class="mt-4 mb-2 col-md-6">
                                        <input type="button" value="जमा करे।" class="btn btn-primary btn-modern" id="btnever" />
                                        </div>
                                            </div>
                                    </div>--%>
                                    <div id="evercrop">
                                        <h3>एवरक्रॉप</h3>
                                        <h4>विवरण दर्ज करें।</h4>
                                        <div class="row">
                                            <div class="group col-md-12">
                                                <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control form-control-modal" name="ever_mobile" id="ever_mobile" onkeypress="return isNumber(event,'ever_mobile')" onkeydown="return isNumber(event,'ever_mobile')" required />
                                                <span class="highlight"></span>
                                                <span class="bar"></span>
                                                <label>मोबाइल नंबर*</label>
                                            </div>
                                            <div class="group col-md-12" style="display: none" id="ever13">
                                                <input type="text" value="" data-msg-required="Please enter the 13 digit code." maxlength="13" class="form-control form-control-modal" name="ever_code" id="ever_code" onkeypress="return isNumber(event)" required />
                                                <span class="highlight"></span>
                                                <span class="bar"></span>
                                                <label>13 अंकों का कोड*</label>
                                            </div>
                                            <div class="group col-md-6">
                                                <input type="text" value="" data-msg-required="Please enter the Name" class="form-control form-control-modal" name="ever_name" id="ever_name" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                                <span class="highlight"></span>
                                                <span class="bar"></span>
                                                <label>नाम*</label>
                                            </div>

                                            <div class="group col-md-6">
                                                <input type="text" value="" data-msg-required="Please enter village." class="form-control form-control-modal" name="village" id="ever_village" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                                <span class="highlight"></span>
                                                <span class="bar"></span>
                                                <label>गाँव*</label>
                                            </div>
                                            <!--<div class="group col-md-6">
                                            <input type="text" value="" data-msg-required="Please enter the Panchayat."  class="form-control form-control-modal" name="panchayat" id="panchayat" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>पंचायत</label>
                                        </div>-->
                                            <div class="group col-md-12">
                                                <input type="text" value="" data-msg-required="Please enter district." class="form-control form-control-modal" name="district" id="ever_district" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                                <span class="highlight"></span>
                                                <span class="bar"></span>
                                                <label>जिला*</label>
                                            </div>
                                            <div class="group col-md-12">
                                                <input type="text" value="" data-msg-required="Please enter the state." class="form-control form-control-modal" name="state" id="ever_state" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                                <span class="highlight"></span>
                                                <span class="bar"></span>
                                                <label>राज्य*</label>
                                            </div>
                                            <div class="group col-md-12">
                                                <input type="text" value="" data-msg-required="Please enter the state." class="form-control form-control-modal" name="Country" id="ever_country" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                                <span class="highlight"></span>
                                                <span class="bar"></span>
                                                <label>देश</label>
                                            </div>

                                            <div class="mt-4 mb-2 col-md-6">
                                                <input type="button" value="जमा करे।" class="btn btn-primary btn-modern" id="btnever" />
                                            </div>
                                        </div>
                                    </div>
                                    <!--ever crop window end-->
                                    <!--Nutravel -->
                                    <div id="nutravel">
                                        <h3 id="nutraheading">Welcome to </h3>
                                        <h4>Enter Details</h4>

                                        <div class="group">
                                            <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control form-control-modal" name="number" id="nutra_mobile" onkeypress="return isNumber(event,'nutra_mobile')" onkeydown="return isNumber(event,'nutra_mobile')" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Enter Mobile Number</label>
                                        </div>
                                        <div class="mt-3 mb-4">
                                            <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnnutra" />
                                        </div>
                                    </div>
                                    <!--Nutravel end -->
                                    <div id="patanjali" style="display: none">
                                        <h3 id="patanjaliheading">welcome to the world of patanjali</h3>

                                        <h4>enter details</h4>

                                        <div class="group">
                                            <input type="text" value="" data-msg-required="please enter the mobile number." maxlength="10" class="form-control form-control-modal" name="number" id="patanjali_mobile" onkeypress="return isnumber(event,'patanjali_mobile')" onkeydown="return isnumber(event,'patanjali_mobile')" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>enter mobile number</label>
                                        </div>
                                        <div class="group">
                                            <%--<textarea value=""  data-msg-required="please enter the comment" class="form-control form-control-modal" name="coats_name" id="patanjali_comment" onkeydown="return /^[a-za-z ]*$/i.test(event.key)" onkeypress="return /^[a-za-z ]*$/i.test(event.key)" required ></textarea>--%>
                                            <textarea placeholder="please enter the comment" class="form-control form-control-modal" name="coats_name" id="patanjali_comment" onkeydown="return /^[a-za-z ]*$/i.test(event.key)" onkeypress="return /^[a-za-z ]*$/i.test(event.key)" required> </textarea>
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <%--<label>enter comment</label>--%>
                                        </div>
                                        <div class="mt-3">
                                            <input type="button" value="submit" class="btn btn-primary btn-modern" id="btnpatanjali" />
                                        </div>
                                    </div>
                                    <!-- Supriya Start-->
                                    <%-- <div id="supriya" style="display:none">
                                         <h3>Welcome to the World of Supriya</h3>
                                        <h4>Enter Details</h4>
                                        <div class="row">   
                                        <div class="group col-md-12">
                                            <input type="text" value="" data-msg-required="Please enter the Name" class="form-control form-control-modal" name="ever_name" id="ever_name" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Name/नाम</label>
                                        </div>
                                        <div class="group col-md-6">
                                            <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control form-control-modal" name="number" id="ever_mobile" onkeypress="return isNumber(event,'ever_mobile')" onkeydown="return isNumber(event,'ever_mobile')" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Mobile No/मोबाइल नंबर</label>
                                        </div>
                                    
                                       
                                         <div class="group col-md-12">
                                            <input type="text" value="" data-msg-required="Please enter the state."  class="form-control form-control-modal" name="state" id="ever_state" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>State/राज्य</label>
                                        </div>
                                       
                                        
                                        <div class="mt-4 mb-2 col-md-6">
                                        <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnsupriya" />
                                        </div>
                                            </div>
                                    </div>--%>
                                    <!--Supriya End-->
                                    <div id="divOtpVerified2" style="display: none">
                                        <span class="check-code-text-headding" id="otpMsg2"></span>
                                        <div class="group">
                                            <input type="text" value="" data-msg-required="Please enter the otp number." maxlength="4" class="form-control form-control-modal" name="number" id="nonmmOTP1" onkeypress="return isNumber(event)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Enter OTP</label>
                                        </div>
                                        <div style="float: right;"><a href="javascript:void(0)" id="btnResendOtp2">Resend OTP</a></div>
                                        <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnskyVerify1" />
                                    </div>
                                    <div id="divOtpVerified3" style="display: none">
                                        <span class="check-code-text-headding" id="otpMsg3"></span>
                                        <div class="group">
                                            <input type="text" value="" data-msg-required="Please enter the otp number." maxlength="4" class="form-control form-control-modal" name="number" id="nonmmOTP3" onkeypress="return isNumber(event)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Enter OTP</label>
                                        </div>
                                        <div style="float: right;"><a href="javascript:void(0)" id="btnResendOtp3">Resend OTP</a></div>
                                        <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnskyVerify3" />
                                    </div>

                                </div>




                                <div id="divdemo" class="col-md-7">


                                    <div class="mb-2">
                                        <div class="demos">
                                            <div class="columns box_info">
                                                <div class="owl-carousel owl-theme" id="sky_images">
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../images/sky/Img1.jpg" alt="screen-shots1">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../images/sky/Img2.jpg" alt="screen-shots2">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../images/sky/Img3.jpg" alt="screen-shots1">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../images/sky/Img4.jpg" alt="screen-shots1">
                                                    </div>

                                                </div>
                                                <div class="owl-carousel owl-theme" id="coats_images">
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/coats/product-coats1.jpg" alt="wire-cables">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/coats/product-coats2.jpg" alt="mcb-switch">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/coats/product-coats3.jpg" alt="main-switch">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/coats/product-coats4.jpg" alt="capacitors">
                                                    </div>

                                                </div>
                                                <div class="owl-carousel owl-theme" id="patanjali_images" style="display: none">
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/patanjali/1.jpg" alt="wire-cables">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/patanjali/2.jpg" alt="mcb-switch">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/patanjali/3.jpg" alt="main-switch">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/patanjali/4.jpg" alt="capacitors">
                                                    </div>

                                                </div>

                                            </div>
                                        </div>
                                        <div class="row">


                                            <div class="col-md-12 text-xcenter">
                                                <!--offset-md-4-->
                                                <div class="pt-4 pb-2">
                                                    <div class="web_links" id="youtube" style="display: none">
                                                        <span>
                                                            <img style="width: 100%; height: 50px;" src="../assets/images/youtube.svg"></span>
                                                        <a href="https://www.youtube.com/watch?v=fxmUWArnOic" target="_blank">https://www.youtube.com/watch?v=fxmUWArnOic</a>
                                                    </div>
                                                    <div class="web_links" id="coatslink">
                                                        <span>
                                                            <img style="width: 100%; height: 50px;" src="../assets/images/sky-decoreweb.svg"></span>
                                                        <a href="https://www.coatsbath.co.in/" target="_blank">https://www.coatsbath.co.in/</a>
                                                    </div>
                                                    <div class="web_links" id="skylink">
                                                        <span>
                                                            <img style="width: 100%; height: 50px;" src="../assets/images/sky-decoreweb.svg"></span>
                                                        <a href="http://www.skydecor.in" target="_blank">http://www.skydecor.in</a>
                                                    </div>
                                                    <div class="web_links" id="patanjalilink" style="display: none">
                                                        <span>
                                                            <img style="width: 100%; height: 50px;" src="../assets/images/sky-decoreweb.svg"></span>
                                                        <a href="https://www.patanjaliayurved.net/" target="_blank">https://www.patanjaliayurved.net/</a>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <!--ever crop start-->
                                <div id="everproducts" class="col-md-7 displaynone">


                                    <div class="mb-2">
                                        <div class="demos">
                                            <div class="columns box_info">
                                                <div class="owl-carousel owl-theme">
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/ever/10.jpeg" alt="capacitors">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/ever/11.jpeg" alt="capacitors">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/ever/12.jpeg" alt="capacitors">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/ever/13.jpeg" alt="capacitors">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/ever/14.jpeg" alt="capacitors">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/ever/15.jpeg" alt="capacitors">
                                                    </div>


                                                </div>

                                            </div>
                                        </div>
                                        <div class="row">


                                            <div class="col-md-12 text-xcenter">
                                                <!--offset-md-4-->
                                                <div class="pt-4 pb-2 d">

                                                    <div class="web_links facebook">
                                                        <span>
                                                            <img style="width: 100%; height: 50px; padding: 3px" src="../assets/images/facebook.svg"></span>
                                                        <a href="https://www.facebook.com/evercrop.agro/" target="_blank">https://www.facebook.com/evercrop.agro/</a>
                                                    </div>
                                                    <div class="web_links whats-app">
                                                        <span>
                                                            <img style="width: 100%; height: 50px; padding: 3px" src="../assets/images/whats-app.svg"></span>
                                                        <a href="https://wa.me/c/917428919991" target="_blank">https://wa.me/c/917428919991</a>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <!--ever crop end-->

                                <!--nutravel start-->
                                <div id="nutravelproduct" class="col-md-7 displaynone">


                                    <div class="mb-2">
                                        <div class="demos">
                                            <div class="columns box_info">
                                                <div class="owl-carousel owl-theme">
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/nutra/1.jpg" alt="wire-cables">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/nutra/2.jpg" alt="mcb-switch">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/nutra/3.jpg" alt="main-switch">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/nutra/4.jpg" alt="capacitors">
                                                    </div>

                                                </div>

                                            </div>
                                        </div>
                                        <div class="row">


                                            <div class="col-md-12 text-xcenter">
                                                <!--offset-md-4-->
                                                <div class="pt-4 pb-2">

                                                    <div class="web_links website">
                                                        <span>
                                                            <img style="width: 100%; height: 50px;" src="../assets/images/sky-decoreweb.svg"></span>
                                                        <a href="https://nutravelhealthcare.com" target="_blank">https://nutravelhealthcare.com</a>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <!--nutravel end-->
                                <!--amulya start-->
                                <div id="amulyaproduct" class="col-md-7 displaynone">


                                    <div class="mb-2">
                                        <div class="demos">
                                            <div class="columns box_info">
                                                <div class="owl-carousel owl-theme">
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/amulya/1.png" alt="wire-cables">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/amulya/2.png" alt="mcb-switch">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/amulya/3.png" alt="main-switch">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/amulya/4.png" alt="capacitors">
                                                    </div>

                                                </div>

                                            </div>
                                        </div>
                                        <div class="row">


                                            <div class="col-md-12 text-xcenter">
                                                <!--offset-md-4-->
                                                <div class="pt-4 pb-2">

                                                    <div class="web_links website">
                                                        <span>
                                                            <img style="width: 100%; height: 50px;" src="../assets/images/sky-decoreweb.svg"></span>
                                                        <a href="https://amulyaayurveda.com/" target="_blank">https://amulyaayurveda.com/</a>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <!--amulya end-->
                                <!--black mango start-->
                                <div id="balckmangoproduct" class="col-md-7 displaynone">


                                    <div class="mb-2">
                                        <div class="demos">
                                            <div class="columns box_info">
                                                <div class="owl-carousel owl-theme">
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/blackmango/1.png" alt="wire-cables">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/blackmango/2.png" alt="mcb-switch">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/blackmango/3.png" alt="main-switch">
                                                    </div>
                                                    <div class="item">
                                                        <img class="img-fluid mx-auto d-block" src="../assets/images/blackmango/4.png" alt="capacitors">
                                                    </div>

                                                </div>

                                            </div>
                                        </div>

                                        <div class="row">


                                            <div class="col-md-12 text-xcenter">
                                                <!--offset-md-4-->
                                                <div class="pt-4 pb-2">

                                                    <div class="web_links website">
                                                        <span>
                                                            <img style="width: 100%; height: 50px;" src="../assets/images/sky-decoreweb.svg"></span>
                                                        <a href="http://blackmangoherbs.com/" target="_blank">http://blackmangoherbs.com/</a>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <!--black mango end-->
                            </div>
                            <div class="row" id="supriya" style="display: none">
                                <div class="col-md-5">
                                    <div id="supriyaform">
                                        <h3>Welcome to GRIH PRAWESH MARKETING COMPANY</h3>
                                        <h4>Enter Details/विवरण दर्ज करें।</h4>
                                        <div class="row">
                                            <div class="group col-md-12">
                                                <input type="text" value="" data-msg-required="Please enter the Name" class="form-control form-control-modal" name="ever_name" id="supriya_name" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                                <span class="highlight"></span>
                                                <span class="bar"></span>
                                                <label>Name/नाम</label>
                                            </div>
                                            <div class="group col-md-12">
                                                <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control form-control-modal" name="number" id="supriya_mobile" onkeypress="return isNumber(event,'ever_mobile')" onkeydown="return isNumber(event,'ever_mobile')" required />
                                                <span class="highlight"></span>
                                                <span class="bar"></span>
                                                <label>Mobile No/मोबाइल नंबर</label>
                                            </div>


                                            <div class="group col-md-12">
                                                <input type="text" value="" data-msg-required="Please enter the state." class="form-control form-control-modal" name="state" id="supriya_state" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                                <span class="highlight"></span>
                                                <span class="bar"></span>
                                                <label>State/राज्य</label>
                                            </div>


                                            <div class="mt-4 mb-2 col-md-3 text-center">
                                                <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnsupriya" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12 hintline" id="msgsupriya" style="display: none">
                                        <p id="supriyap1msg2"></p>
                                        <a href="javascript:void(0)" class="next_btn" id="supriyabtnNext1">Close</a>
                                    </div>
                                    <div>
                                        <img src="../assets/images/supriya-product.png" class="img-fluid" />
                                    </div>

                                    <%--</div>--%>
                                    <!--Supriya id End-->

                                </div>
                                <div class="col-md-7">
                                    <h1 style="font-size: 3em; color: #2f90e5">Supriya</h1>
                                    <h4 style="color: #438f81; text-transform: uppercase; letter-spacing: 0.2px;">AN ISO 9001 AND 14001 Certified Company</h4>
                                    <h1 style="font-size: 2em; color: #ef5b2e; line-height: 34px">सुन्दर घर का सपना !<br />
                                        सुप्रिया से घर बनाए अपना !!</h1>
                                    <div class="products_sup">
                                        <img src="../assets/images/supriya.png" class="img-fluid" />
                                    </div>

                                </div>
                                <div class="col-md-12">

                                    <!-- <div class="demos">
                                <div class="columns box_info" >
                                    <div class="owl-supriya owl-carousel owl-theme">
                                        <div class="item">
                                            <img class="img-fluid mx-auto d-block" style="max-height:100%; height:400px;" src="../images/Flora/wire-cables.jpg" alt="wire-cables">
                                            <div class="text-center mt-2">
                                                <h5>Wires and Cables</h5>
                                            </div>
                                        </div>
                                        <div class="item">
                                            <img class="img-fluid mx-auto d-block" style="max-height:100%; height:400px;" src="../images/Flora/mcb-switch.jpg" alt="mcb-switch">
                                            <div class="text-center mt-2">
                                                <h5>MCB</h5>
                                            </div>
                                        </div>
                                        <div class="item">
                                            <img class="img-fluid mx-auto d-block" style="max-height:100%; height:400px;" src="../images/Flora/main-switch.jpg" alt="main-switch">
                                            <div class="text-center mt-2">
                                                <h5>Main Switch</h5>
                                            </div>
                                        </div>
                                        <div class="item">
                                            <img class="img-fluid mx-auto d-block" style="max-height:100%; height:400px;" src="../images/Flora/capacitors.jpg" alt="capacitors">
                                            <div class="text-center mt-2">
                                                <h5>Capacitors</h5>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="text-center"><a href="http://www.competentelectricals.com/" class="btn btn_pomprimary btn-sm">View More</a></div>
                                </div>
                            </div>-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <!---end products of coats-->

            <div class="row">
                <div class="col-md-12" style="margin: 0 auto;">
                    <div id="checkcode1" class="checkcode5 fadeInDown animated" style="display: none;">

                        <div class="row">

                            <div id="checkcode1in" class="col-md-5" style="margin: 0 auto;">
                                <div class="mb-4 mcenter-box">
                                    <!--<div class="filter" id="dvcode1filt">
                                <span class="step1 active">1</span>
                                <span class="step2 active">2</span>
                                <span class="step3 active">3</span>
                            </div>-->

                                    <div class="form-row">
                                        <div class="row mb-4" style="display: none">
                                            <div class="col-md-12">
                                                <input type="submit" value="Submit" onclick="return chkgenuenity();" class="btn btn-primary btn-modern" data-loading-text="Loading..." />
                                                <input type="text" value="" placeholder="Referral Code" disabled="disabled" maxlength="12" class="form-slider" id="RefCd" style="display: none;" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12 hintline mb-0">
                                            <div class="code-message mb-0">
                                                <p id="p1msg"></p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 custom-padding-modal-stape" style="display: none">
                                        <div class="row modal-border-right-style">
                                            <div class="col-md-12 text-center">
                                                <img src="./image/logo-1.png" class="" style="width: 70%; height: auto;" />
                                            </div>
                                            <div class="col-md-12">
                                                <p class="check-code-text-right-side">Step 1: Scratch to reveal the code</p>
                                                <p class="check-code-text-right-side">Step 2 Input the code & mobile no. and click the “Verify” button</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div id="scrc" class="col-md-12 hintline displayNone">
                                        <span class="check-code-text-headding">Scratch the label & enter 13digit code to earn loyalty points</span>
                                        <div class="group">
                                            <input type="text" class="input2 step1" required="" value="" data-msg-required="Please enter code." maxlength="13" name="codeone" id="codeone3" autofocus required="required" data-inputmask="'mask': '99999 9999 9999'" />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Enter the Code</label>
                                        </div>
                                        <div class="mt-4">
                                            <button class="btn btn_pomprimary mt-4 btn-block" id="btnsubcode">Submit</button>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12 hintline">
                                            <p id="p2msg"></p>
                                            <a href="javascript:void(0)" class="next_btn" id="btnNext">Close</a>
                                        </div>
                                    </div>

                                    <section id="dvyout1" class="section_type displayNone">
                                        <div class="column_cols">
                                            <div class="row">

                                                <div class="col-md-3 text-xcenter">
                                                    <hr />
                                                    <div class="yout_tube">
                                                        <img src="../images/Flora/youtube.svg">
                                                    </div>
                                                </div>
                                                <div class="col-md-9 text-xcenter">
                                                    <!--offset-md-4-->
                                                    <div class="padding-left">
                                                        <label>How To Claim Points</label>
                                                        <br>
                                                        <a href="https://youtu.be/RQPIG62WwuE" target="_blank">https://youtu.be/RQPIG62WwuE</a>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </section>

                                </div>
                            </div>

                            <div id="divdemo" class="col-md-7 displayNone">

                                <div class="mt-4">
                                    <div class="demos">
                                        <div class="columns box_info">
                                            <div class="owl-carousel owl-theme">
                                                <div class="item">
                                                    <img class="img-fluid mx-auto d-block" src="../images/Flora/user-login.jpg" alt="screen-shots1">
                                                </div>
                                                <div class="item">
                                                    <img class="img-fluid mx-auto d-block" src="../images/Flora/check-code.jpeg" alt="screen-shots2">
                                                </div>
                                                <div class="item">
                                                    <img class="img-fluid mx-auto d-block" src="../images/Flora/transaction.jpeg" alt="screen-shots1">
                                                </div>


                                            </div>


                                        </div>
                                    </div>
                                </div>
                                <div class="mb-2">
                                    <div class="demos">
                                        <div class="columns box_info">
                                            <div class="owl-carousel owl-theme">
                                                <div class="item">
                                                    <img class="img-fluid mx-auto d-block" src="../images/Flora/wire-cables.jpg" alt="wire-cables">
                                                    <div class="text-center mt-2">
                                                        <h5>Wires and Cables</h5>
                                                    </div>
                                                </div>
                                                <div class="item">
                                                    <img class="img-fluid mx-auto d-block" src="../images/Flora/mcb-switch.jpg" alt="mcb-switch">
                                                    <div class="text-center mt-2">
                                                        <h5>MCB</h5>
                                                    </div>
                                                </div>
                                                <div class="item">
                                                    <img class="img-fluid mx-auto d-block" src="../images/Flora/main-switch.jpg" alt="main-switch">
                                                    <div class="text-center mt-2">
                                                        <h5>Main Switch</h5>
                                                    </div>
                                                </div>
                                                <div class="item">
                                                    <img class="img-fluid mx-auto d-block" src="../images/Flora/capacitors.jpg" alt="capacitors">
                                                    <div class="text-center mt-2">
                                                        <h5>Capacitors</h5>
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="text-center"><a href="http://www.competentelectricals.com/" class="btn btn_pomprimary btn-sm">View More</a></div>
                                        </div>
                                    </div>

                                </div>

                            </div>

                        </div>
                    </div>
                </div>

            </div>
            <%--<div class="row">
            <div  class="col-md-12">

                      
                        <div class="mb-2 mt-4">
                            <div class="demos" id="pro_info" style="display:none">
                               
                                <div class="columns box_info">
                                     <h4>View Products</h4> 
                                    <div class="owl-carousel owl-theme coats-carousel">
                                        <div class="item">
                                            <img class="img-fluid mx-auto d-block" src="../assets/images/coats/product-coats1.jpg" alt="product-coats1">
                                            <!--<div class="text-center mt-2">
                                                <h5>Wires and Cables</h5>
                                            </div>-->
                                        </div>
                                        <div class="item">
                                            <img class="img-fluid mx-auto d-block" src="../assets/images/coats/product-coats2.jpg" alt="mcb-switch">
                                            
                                        </div>
                                        <div class="item">
                                            <img class="img-fluid mx-auto d-block" src="../assets/images/coats/product-coats3.jpg" alt="main-switch">
                                           
                                        </div>
                                        <div class="item">
                                            <img class="img-fluid mx-auto d-block" src="../assets/images/coats/product-coats4.jpg" alt="capacitors">
                                            
                                        </div>

                                    </div>

                                    <%--<div class="text-center mt-4"><a href="#" class="btn btn_pomprimary btn-sm">View More</a></div>
                                </div>
                            </div>

                        </div>
                        
                    </div>

        </div>--%>
        </div>

    </div>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    <%-- Modelpopup For Mahindra--%>
    <div class="modal fade" id="Mahindra_Modelpopup">
        <div class="modal-dialog modal-lg">
            <div class="modal-content ">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title title-pading">Register For Retailer ID (RID)</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <!-- Modal body -->
                <div class="modal-body model-pading">
                    <form id="frmmm">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Full Name*</label>
                                    <input type="text" class="form-control" id="txtmmp_name" minlength="3" maxlength="30" aria-describedby="text" required>
                                </div>
                            </div>


                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Mobile No*</label>
                                    <input type="text" class="form-control" minlength="10" maxlength="10" id="txtmmp_mobile" required>
                                </div>

                            </div>



                            <div class="col-lg-6">
                                <div class="mb-3 form-label">
                                    <div class="form-check form-check-inline mb-2">
                                        <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1">
                                        <label class="form-check-label" for="inlineRadio1">Retailer GST</label>
                                    </div>
                                    <div class="form-check form-check-inline mb-2">
                                        <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
                                        <label class="form-check-label" for="inlineRadio2">Aadhar No*</label>
                                    </div>
                                    <input type="text" class="form-control" onkeyup="validategst()" id="txtmmp_gst" required>
                                </div>

                            </div>

                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Shop Name*</label>
                                    <input type="text" class="form-control" id="txtmmp_shop" minlength="3" maxlength="30" required>
                                </div>

                            </div>


                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Pin Code*</label>
                                    <input type="text" class="form-control" id="txtmmp_pin" minlength="6" maxlength="6" onkeyup="getaddress()" required>
                                </div>

                            </div>

                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">City*</label>
                                    <input type="text" class="form-control" id="txtmmp_city" minlength="3" maxlength="100" required>
                                </div>

                            </div>

                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">State*</label>
                                    <input type="text" class="form-control" id="txtmmp_state" minlength="3" maxlength="100" required>
                                </div>

                            </div>

                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Select Dealer*</label>
                                    <select class="form-control" id="ddlNationality" aria-label="Default select example">
                                        <option value="">--Select Dealer--</option>
                                    </select>
                                </div>

                            </div>

                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Dealer Code*</label>
                                    <input type="text" class="form-control" readonly="readonly" id="txtmmp_dealercode" minlength="3" maxlength="30" required>
                                </div>

                            </div>
                            <label id="lbltxtmm"></label>
                            <div class="col-lg-12">
                                <div class="mb-3 text-center">
                                    <button type="submit" id="btnmmp_submit" class="btn btn-primary poppup-button">Submit</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>



            </div>
        </div>
    </div>

    <%--End Of Modelpopup For Mahindra--%>


    <%--<div class="modal fade" id="Check-Codes" tabindex="-1" role="dialog" aria-labelledby="defaultModalLabel" aria-hidden="true">
	<div class="modal-dialog checkcodes">
                   
		<div  class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="defaultModalLabel">Check Your Codes</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-6 col-sm-12 mb-3">
						<div class="input1_wrapper">
							<input type="text" placeholder="Code 1" maxlength="5" class="form-slider" id="codeone" onkeypress="return isNumberKey(this, event);" 
                                onblur="return isNumberKeyAndReferral(this, event);" />
						</div>
					</div>
					<div class="col-md-6 col-sm-12 mb-3">
						<div class="input1_wrapper">
							<input type="text" placeholder="Code 2"  maxlength="8" class="form-slider"  id="codetwo"  onkeypress="return isNumberKey(this, event);"  
                                onblur="return isNumberKeyAndReferral(this, event);" />
						</div>
					</div>
					<div class="col-md-6 col-sm-12 mb-3">
						<div class="input1_wrapper">
							<input type="text" value=""  placeholder="Mobile No."   maxlength="10" class="form-slider" id="mobile" 
                                onkeypress="return isNumberKey(this, event);"    onchange="return mobileAutoFill();" />
						</div>
					</div>
					<div class="col-md-6 col-sm-12 mb-3">
						<div class="input1_wrapper">
										
						</div>
					</div>
					<div class="col-md-12 col-sm-12 mt-2 text-center">
						<button type="submit" onclick="return chkgenuenity();" class="btn btn-outline btn-custom-modal slider-btn-style btn-lg">Go</button>
					</div>
				</div>
			</div>
						
		</div>
	</div>
</div>
    --%>
</div>
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.2/js/bootstrap.min.js'></script>
<script>
    $(document).ready(function () {
        $('.coats-carousel').owlCarousel({
            loop: true,
            margin: 10,
            padding: 10,
            items: 3,
            responsiveClass: true,
            nav: true,
            responsive: {
                0: {
                    items: 1
                },
                600: {
                    items: 3
                },
                960: {
                    items: 4
                },
                1200: {
                    items: 5
                }
            }
        })
        debugger;
        var id = GetParameterValues('id');
        if (id == 'ever') {
            $('#pro_info').show();
            $('#ever13').show();
            $('#chkGun').hide();
            $('#Coatsbathfitting').hide();
            $('#nutravel').hide();
            $('#evercrop').show();
            $('#maincode').hide();
            //compInformation = data.split('&')[1];
            $('#checkcode').addClass('box-coats');
            $('#skydecore').hide();
            $('#warrentyauto').hide();
            //$('#warratyHeading').show();
            //$('#checkcode').show();
            $('#warratyHeading').hide();
            $('#checkcode').hide();
            $('#coats').show();
            $('#divdemo').hide();
            $('#everproducts').show();
            $('#nutravelproduct').hide();
            $('#amulyaproduct').hide();
            $('#balckmangoproduct').hide();
            $('#checkcode2').hide();
            $('#divCompany').hide();
            $('#jpc').hide();
            $('#jphcounter').hide();
            $('#warrantyMsg').text("Welcome to the world of EverCrop");
            $("#coats_logo").attr("src", '/Info/img/logos/1312/EVERCROP LOGO-1312.png');
        }
    })
    function GetParameterValues(param) {
        var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
        for (var i = 0; i < url.length; i++) {
            var urlparam = url[i].split('=');
            if (urlparam[0] == param) {
                return urlparam[1];
            }
        }
    }
</script>
<%--<script>
    $(document).ready(function () {
        $('.owl-carousel').owlCarousel({
            loop: true,
            margin: 10,
            padding: 10,
            items: 3,
            responsiveClass: true,
            nav: true,
            responsive: {
                0: {
                    items: 1
                },
                600: {
                    items: 3
                },
                960: {
                    items: 3
                },
                1200: {
                    items: 3
                }
            }
        })
   
    })
</script>--%>
<script type="text/javascript">
    var compInformation = "";

    $('#jpcdealer_mobile').keyup(function () {

        if (this.value.length == 10) {

            $.ajax({

                type: "POST",

                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=dealerid&mobile=' + this.value,

                success: function (data) {



                    if (data != "0" && data != "0,0") {


                        $('#jpc_dealerid').val(data.split(",")[0]);
                        $('#jpcpainter_name').val(data.split(",")[1]);



                        $('#jpc_dealerid').attr('data - msg - required', '');

                        $('#jpc_dealerid').attr('disabled', 'disabled');
                        $('#jpcpainter_name').attr('data - msg - required', '');

                        $('#jpcpainter_name').attr('disabled', 'disabled');

                    }

                }

            });

        }

    });
    $("#ever_code").keyup(function () {
        debugger;
        if (this.value.length == this.maxLength && $("#ever_mobile").val().length == 10) {

            var rquestpage_Dcrypt = $("#ever_code").val();

            $.ajax({
                type: "POST",
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=userdetails&codeone=' + rquestpage_Dcrypt + '&mobile=' + $('#ever_mobile').val(),
                success: function (data) {
                    if (data.split('~')[0] == 'Failure') {
                        $('#p1msg2').html(data.split('~')[1]);

                        $('#p1msg2:contains("not")').css('color', 'red');
                        $('#checkcode').hide();
                        $('#msgcoats').show();
                        $('#evercrop').hide();
                        // $('#checkcode1').show();
                        $('#' + divname).hide();
                    }
                    else if (data.split('~')[0] == 'Details') {

                    }
                    else {
                        alert(data.split('~')[1]);
                    }

                }
            });
        }
    });

     <%-- SBU  --%>
    function CHKSBUDATA() {
        debugger;
        if ($('#MM_mobile').val().length == 10 && $('#MM_role :selected').val() == "5") {
            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=CHKSBUDATA&mobile=' + $('#MM_mobile').val(),
                success: function (data) {
                    if (data.split('~')[0] == "Success") {
                        $('#empID').val(data.split('~')[1]).prop('readonly', true);
                        $('#distributorID').val(data.split('~')[2]).prop('readonly', true);
                    }
                }
            });
        }
        else {
            $('#empID').val('').prop('readonly', false);
            $('#distributorID').val('').prop('readonly', false);
        }
    }
    var dropdown = document.getElementById("MM_role");
    dropdown.addEventListener("change", function () {
        $('#empID').val('').prop('readonly', false);
        $('#distributorID').val('').prop('readonly', false);
    });
  <%-- SBU --%>

    $(".input1").keyup(function () {

        if (this.value.length == this.maxLength) {
            $('#checkcode0').hide();
            $('#checkcode2').show();

            $('#checkcode').removeClass('checkcode5');
            $('#checkcode').addClass('checkcode');
            $('#checkcodein').removeClass('col-md-5');
            $('#checkcodein').addClass('col-md-12');

            $('#checkcode1').removeClass('checkcode5');
            $('#checkcode1').addClass('checkcode');
            $('#checkcode1in').removeClass('col-md-5');
            $('#checkcode1in').addClass('col-md-12');

            $('#srcc').hide();
            var rquestpage_Dcrypt = $("#codeone").val();

            $.ajax({
                type: "POST",
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                success: function (data) {


<%--                    $.ajax({
                        type: "POST",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=SaveLocation&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1] + '&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                        success: function (data) {--%>

                    $.ajax({
                        type: "POST",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1] + '&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                        success: function (data) {
                            debugger;

                            if (data.split('&')[0] === "1" && data.split('&')[1] === "Auto Max India") {
                                $('#Patanjali').hide();
                                $('#chkGun').hide();
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
                            else if (data.split('&')[0] === "0" && data.split('&')[1] === "JPH Publications Pvt. Ltd") {
                                $('#Patanjali').hide();
                                $('#nutravel').hide();
                                $('#evercrop').hide();
                                $('#supriya').hide();
                                $('#everproducts').hide();
                                $('#nutravelproduct').hide();
                                $('#amulyaproduct').hide();
                                $('#balckmangoproduct').hide()
                                $('#chkGun').hide();
                                $('#Coatsbathfitting').hide();
                                $('#skydecore').hide();
                                $('#jphcounter').show();
                                $('#warratyHeading').show();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#jph').hide();
                                //$('#msg').html(data.split('&')[3].toString());

                                $('#warrantyMsg').text("welcome to " + data.split('&')[1]);
                                $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }
                            else if (data.split('&')[0] === "0" && data.split('&')[1] === "OSR IMPEX") {
                                $('#Patanjali').hide();
                                $('#nutravel').hide();
                                $('#evercrop').hide();
                                $('#supriya').hide();
                                $('#everproducts').hide();
                                $('#nutravelproduct').hide();
                                $('#amulyaproduct').hide();
                                $('#balckmangoproduct').hide()
                                $('#chkGun').hide();
                                $('#Coatsbathfitting').hide();
                                $('#skydecore').hide();
                                $('#jphcounter').show();
                                $('#warratyHeading').show();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#jph').hide();
                                //$('#msg').html(data.split('&')[3].toString());

                                $('#warrantyMsg').text("welcome to " + data.split('&')[1]);
                                $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }
                            else if (data.split('&')[0] === "0" && data.split('&')[1] === "JOHNSON PAINTS CO.") {
                                $('#Patanjali').hide();
                                $('#nutravel').hide();
                                $('#evercrop').hide();
                                $('#supriya').hide();
                                $('#everproducts').hide();
                                $('#nutravelproduct').hide();
                                $('#amulyaproduct').hide();
                                $('#balckmangoproduct').hide()
                                $('#chkGun').hide();
                                $('#Coatsbathfitting').hide();
                                $('#skydecore').hide();
                                $('#jphcounter').hide();
                                $('#jpc').show();
                                $('#warratyHeading').show();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                compInformation = data.split('&')[1];
                                //$('#msg').html(data.split('&')[3].toString());

                                $('#warrantyMsg').text("welcome to " + data.split('&')[1]);
                                $("#imgWarrantyLogo").attr("src", data.split('&')[2].replace('~', ''));
                            }

                            //else if (data.split('&')[0] === "1") {

                            //    $('#chkGun').hide();
                            //    $('#warrenty').show();
                            //    $('#warratyHeading').show();
                            //    $('#checkcode').show();
                            //    $('#checkcode2').hide();
                            //    $('#divCompany').hide();
                            //    $('#jphcounter').hide();
                            //    $('#msg').html(data.split('&')[3].toString());

                            //    $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                            //    $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            //    //$('#p1msg').html(data.split('&')[3]);
                            //    //$('#p1msg:contains("not")').css('color', 'red');
                            //    //$('#checkcode1').show();
                            //    //$('#checkcode2').hide();
                            //    //$('#warrenty').show();
                            //    //$('#warratyHeading').show();
                            //    //$('#divCompany').hide();
                            //    //$('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                            //    //$("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            //}

                            else if (data.split('&')[0] === "2" && data.split('&')[1] === "Auto Max India") {
                                $('#Patanjali').hide();
                                $('#chkGun').hide();
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
                                $('#jpc').hide();
                                $('#warrantyMsg').text("welcome to " + data.split('&')[1]);
                                $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }
                            else if (data.split('&')[1] === "SKYDECOR LAMINATES PRIVATE LIMITED") {
                                //$('#chkGun').hide();
                                //$('#Coatsbathfitting').hide();
                                //compInformation = data.split('&')[1];
                                //$('#checkcode').addClass('box-skydecore');
                                //$('#skydecore').show();
                                //$('#warrentyauto').hide();
                                //$('#warratyHeading').show();
                                //$('#jpc').hide();
                                //$('#checkcode').show();
                                //$('#checkcode2').hide();
                                //$('#divCompany').hide();
                                //$('#jphcounter').hide();
                                //$('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                //$("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                                $('#Patanjali').hide();
                                $('#nutravel').hide();
                                $('#evercrop').hide();
                                $('#supriya').hide();
                                $('#everproducts').hide();
                                $('#nutravelproduct').hide();
                                $('#amulyaproduct').hide();
                                $('#balckmangoproduct').hide()
                                $('#sky_images').show();
                                $('#coats_images').hide();
                                $('#pro_info').show();
                                $('#youtube').hide();
                                $('#skylink').show();
                                $('#coatslink').hide();
                                $('#chkGun').hide();
                                $('#coatsheading').hide();
                                $('#skyheading').show();
                                $('#Coatsbathfitting').show();
                                compInformation = data.split('&')[1];
                                $('#checkcode').addClass('box-coats');
                                $('#skydecore').hide();
                                $('#warrentyauto').hide();
                                $('#check_Array').hide();
                                //$('#warratyHeading').show();
                                //$('#checkcode').show();
                                $('#warratyHeading').hide();
                                $('#checkcode').hide();
                                $('#coats').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#jpc').hide();
                                $('#jphcounter').hide();
                                $('#warrantyMsg').text("Welcome to " + data.split('&')[1]);
                                $("#coats_logo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }
                            else if (data.split('&')[1] === "COATS BATH FITTINGS") {
                                debugger;
                                $('#Patanjali').hide();
                                $('#nutravel').hide();
                                $('#evercrop').hide();
                                $('#supriya').hide();
                                $('#everproducts').hide();
                                $('#nutravelproduct').hide();
                                $('#amulyaproduct').hide();
                                $('#balckmangoproduct').hide()
                                $('#pro_info').show();
                                $('#youtube').show();
                                $('#skylink').hide();
                                $('#coatslink').show();
                                $('#coatsheading').show();
                                $('#skyheading').hide();
                                $('#chkGun').hide();
                                $('#sky_images').hide();
                                $('#coats_images').show();
                                $('#Coatsbathfitting').show();
                                $('#check_Array').show();
                                compInformation = data.split('&')[1];
                                $('#checkcode').addClass('box-coats');
                                $('#skydecore').hide();
                                $('#warrentyauto').hide();
                                //$('#warratyHeading').show();
                                //$('#checkcode').show();
                                $('#warratyHeading').hide();
                                $('#checkcode').hide();
                                $('#coats').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#jpc').hide();
                                $('#jphcounter').hide();
                                $('#warrantyMsg').text("Welcome to " + data.split('&')[1]);
                                $("#coats_logo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }
                            ////// patanjali/////////////////////
                            else if (data.split('&')[1] === "PATANJALI") {
                                $('#nutravel').hide();
                                $('#evercrop').hide();
                                $('#supriya').hide();
                                $('#everproducts').hide();
                                $('#nutravelproduct').hide();
                                $('#amulyaproduct').hide();
                                $('#balckmangoproduct').hide()
                                $('#pro_info').show();
                                $('#youtube').hide();
                                $('#coatslink').hide();
                                $('#skylink').hide();
                                $('#patanjalilink').show();
                                $('#patanjaliheading').show();
                                $('#skyheading').hide();
                                $('#chkGun').hide();
                                $('#sky_images').hide();
                                $('#patanjali_images').show();
                                $('#coats_images').hide();
                                $('#Coatsbathfitting').hide();
                                $('#Patanjali').show();

                                $('#check_Array').show();
                                compInformation = data.split('&')[1];
                                $('#checkcode').addClass('box-coats');
                                $('#skydecore').hide();
                                $('#warrentyauto').hide();
                                //$('#warratyHeading').show();
                                //$('#checkcode').show();
                                $('#warratyHeading').hide();
                                $('#checkcode').hide();
                                $('#coats').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#jpc').hide();
                                $('#jphcounter').hide();
                                $('#warrantyMsg').text("Welcome to " + data.split('&')[1]);
                                $("#coats_logo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }

                            else if (data.split('&')[1] === "EVERCROP AGRO SCIENCE") {

                                $('#pro_info').show();
                                $('#chkGun').hide();
                                $('#Coatsbathfitting').hide();
                                $('#nutravel').hide();
                                $('#evercrop').show();
                                $('#supriya').hide();
                                compInformation = data.split('&')[1];
                                $('#checkcode').addClass('box-coats');
                                $('#skydecore').hide();
                                $('#warrentyauto').hide();
                                //$('#warratyHeading').show();
                                //$('#checkcode').show();
                                $('#warratyHeading').hide();
                                $('#checkcode').hide();
                                $('#coats').show();
                                $('#divdemo').hide();
                                $('#everproducts').show();
                                $('#nutravelproduct').hide();
                                $('#amulyaproduct').hide();
                                $('#balckmangoproduct').hide();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#jpc').hide();
                                $('#jphcounter').hide();
                                $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                $("#coats_logo").attr("src", data.split('&')[2].toString().replace('~', ''));


                            }

                            else if (data.split('&')[1] === "GRIH PRAWESH MARKETING COMPANY") {

                                $('#pro_info').hide();
                                $('#chkGun').hide();
                                $('#Coatsbathfitting').hide();
                                $('#nutravel').hide();
                                $('#evercrop').hide();
                                $('#supriya').show();
                                compInformation = data.split('&')[1];
                                $('#checkcode').addClass('box-coats');
                                $('#skydecore').hide();
                                $('#warrentyauto').hide();
                                //$('#warratyHeading').show();
                                //$('#checkcode').show();
                                $('#warratyHeading').hide();
                                $('#checkcode').hide();
                                $('#coats').show();
                                $('#divdemo').hide();
                                $('#everproducts').hide();
                                $('#nutravelproduct').hide();
                                $('#amulyaproduct').hide();
                                $('#balckmangoproduct').hide();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#jpc').hide();
                                $('#jphcounter').hide();
                                $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                $("#coats_logo").attr("src", data.split('&')[2].toString().replace('~', ''));


                            }


                            else if (data.split('&')[1] === "Nutravel Health Care") {

                                $('#pro_info').show();
                                $('#chkGun').hide();
                                $('#Coatsbathfitting').hide();
                                $('#nutravel').show();
                                $('#evercrop').hide();
                                $('#supriya').hide();
                                compInformation = data.split('&')[1];
                                $('#checkcode').addClass('box-coats');
                                $('#skydecore').hide();
                                $('#warrentyauto').hide();
                                //$('#warratyHeading').show();
                                //$('#checkcode').show();
                                $('#warratyHeading').hide();
                                $('#checkcode').hide();
                                $('#coats').show();
                                $('#divdemo').hide();
                                $('#everproducts').hide();
                                $('#nutravelproduct').show();
                                $('#amulyaproduct').hide();
                                $('#balckmangoproduct').hide();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#jpc').hide();
                                $('#jphcounter').hide();
                                $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                $('#nutraheading').text($('#nutraheading').text() + compInformation);
                                $("#coats_logo").attr("src", data.split('&')[2].toString().replace('~', ''));


                            }
                            else if (data.split('&')[1] === "AMULYA AYURVEDA") {

                                $('#pro_info').show();
                                $('#chkGun').hide();
                                $('#Coatsbathfitting').hide();
                                $('#nutravel').show();
                                $('#evercrop').hide();
                                $('#supriya').hide();
                                compInformation = data.split('&')[1];
                                $('#checkcode').addClass('box-coats');
                                $('#skydecore').hide();
                                $('#warrentyauto').hide();
                                //$('#warratyHeading').show();
                                //$('#checkcode').show();
                                $('#warratyHeading').hide();
                                $('#checkcode').hide();
                                $('#coats').show();
                                $('#divdemo').hide();
                                $('#everproducts').hide();
                                $('#nutravelproduct').hide();
                                $('#amulyaproduct').show();
                                $('#balckmangoproduct').hide();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#jpc').hide();
                                $('#jphcounter').hide();
                                $('#nutraheading').text($('#nutraheading').text() + compInformation);
                                $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                $("#coats_logo").attr("src", data.split('&')[2].toString().replace('~', ''));


                            }
                            else if (data.split('&')[1] === "Black Mango Herbs") {

                                $('#pro_info').show();
                                $('#chkGun').hide();
                                $('#Coatsbathfitting').hide();
                                $('#nutravel').show();
                                $('#evercrop').hide();
                                compInformation = data.split('&')[1];
                                $('#checkcode').addClass('box-coats');
                                $('#skydecore').hide();
                                $('#warrentyauto').hide();
                                //$('#warratyHeading').show();
                                //$('#checkcode').show();
                                $('#warratyHeading').hide();
                                $('#checkcode').hide();
                                $('#coats').show();
                                $('#divdemo').hide();
                                $('#everproducts').hide();
                                $('#nutravelproduct').hide();
                                $('#amulyaproduct').hide();
                                $('#balckmangoproduct').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#jpc').hide();
                                $('#jphcounter').hide();
                                $('#nutraheading').text($('#nutraheading').text() + compInformation);
                                $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                $("#coats_logo").attr("src", data.split('&')[2].toString().replace('~', ''));


                            }

                            else if (data.split('&')[0] === "2" && data.split('&')[1] === "ORBIT ELECTRODOMESTICS INDIA") {
                                window.location.href = "https://www.indiaorbit.in/e-warranty?ID=Orbitindia&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[0] === "2" && data.split('&')[1] === "TECHNICAL MINDS PRIVATE LIMITED") {
                                window.location.href = "https://hypersonic.club/e-warranty?ID=Hypersonic&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];

                            }

                            else if (data.split('&')[0] === "2") {
                                $('#Patanjali').hide();
                                $('#chkGun').hide();
                                $('#Coatsbathfitting').hide();
                                $('#nutravel').hide();
                                $('#evercrop').hide();
                                $('#everproducts').hide();
                                $('#nutravelproduct').hide();
                                $('#amulyaproduct').hide();
                                $('#balckmangoproduct').hide()
                                $('#skydecore').hide();
                                $('#warrenty').show();
                                $('#warratyHeading').show();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#jpc').hide();
                                $('#divCompany').hide();
                                $('#jphcounter').hide();
                                $('#warrantyMsg').text("Welcome to " + data.split('&')[1]);
                                $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }

                            else if (data.split('&')[3] === "MM") {
                                $('#MM_mobile').val($('#mobilenumber').val());
                                $('#mobile').show();
                                $('#mobile1').hide();
                                $('#chkGun').hide();
                                $('#warrenty').hide();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').show();
                                $('#MM_mobile').val($('#mobilenumber').val());
                                $('#warratyHeading div').css('margin-top', "0px")
                                compInformation = data.split('&')[1];
                                $('#warratyHeading').show();
                                //$('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }

                            //else if (data.split('&')[1] === "MAHINDRA AND MAHINDRA LTD") {
                            else if (data.split('&')[3] === "MS" && data.split('&')[1] === "MAHINDRA AND MAHINDRA LTD") {
                                $('#Patanjali').hide();
                                $('#chkGun').hide();
                                $('#warrenty').hide();
                                $('#Coatsbathfitting').hide();
                                $('#nutravel').hide();
                                $('#evercrop').hide();
                                $('#everproducts').hide();
                                $('#nutravelproduct').hide();
                                $('#amulyaproduct').hide();
                                $('#balckmangoproduct').hide()
                                $('#skydecore').hide();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#jpc').hide();
                                $('#divCompany').show();
                                $('#jphcounter').hide();
                                $('#checkcode1').removeClass('checkcode5');
                                $('#checkcode1').addClass('checkcode');
                                $('#checkcode1in').removeClass('col-md-5');
                                $('#checkcode1in').addClass('col-md-12');

                                $('#warratyHeading div').css('margin-top', "0px")
                                compInformation = data.split('&')[1];
                                $('#warratyHeading').show();
                                $('#warrantyMsg').text("Welcome to " + data.split('&')[1]);
                                $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }
                            else if (data.split('&')[1] === "Competent Electricals India") {
                                $('#Patanjali').hide();
                                $('#warrenty').hide();
                                $('#warratyHeading').hide();
                                $('#nutravel').hide();
                                $('#evercrop').hide();
                                $('#everproducts').hide();
                                $('#nutravelproduct').hide();
                                $('#amulyaproduct').hide();
                                $('#balckmangoproduct').hide()
                                $('#clogo').removeClass('displayNone');
                                $('#jpc').hide();
                                $('#dvyout').removeClass('displayNone');
                                $('#dvyout1').removeClass('displayNone');
                                $('#divdem').removeClass('displayNone');
                                $('#divdem1').removeClass('displayNone');
                                $('#scrc').removeClass('displayNone');
                                $('#jphcounter').hide();
                                $('#checkcode').removeClass('checkcode');
                                $('#checkcode').addClass('checkcode5');
                                $('#checkcodein').removeClass('col-md-12');
                                $('#checkcodein').addClass('col-md-5');

                                $('#checkcode1').removeClass('checkcode');
                                $('#checkcode1').addClass('checkcode5');
                                $('#checkcode1in').removeClass('col-md-12');
                                $('#checkcode1in').addClass('col-md-5');

                                $('#dvfiltermob').hide();
                                $('#dvcode1filt').hide();

                                $('#clogo').show();
                                $('#dvyout').show();
                                $('#dvyout1').show();
                                $('#scrc').show();
                                $('#divdem').show();
                                $('#divdem1').show();
                                $('#chkGun').show();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#Coatsbathfitting').hide();
                                $('#skydecore').hide();

                            }

                            else if (data.split('&')[0] === "0" && data.split('&')[1] === "FB Nutrition") {


                                window.location.href = "codeverify.aspx?ID=FBNutrition&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1];
                            }
                            else if (data.split('&')[0] === "0" && data.split('&')[1] === "ROYAL MANUFACTURER") {


                                window.location.href = "codeverify.aspx?ID=ROYALMANUFACTURER&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1];
                            }


                            else if (data.split('&')[0] === "0" && data.split('&')[1] === "SHRI BALAJI PUBLICATIONS") {



                                window.location.href = "balaji.aspx?Pub_Code=shribalaji&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1];

                            }
                            else if (data.split('&')[1] === "A TO Z PHARMACEUTICALS") {


                                window.location.href = "fharmaceticals.aspx?ID=fharmaceticals&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];

                            }
                            else if (data.split('&')[1] === "MARMO SOLUTIONS PRIVATE LIMITED") {
                                window.location.href = "Marmo.aspx?ID=Marmo&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }

                            else if (data.split('&')[1] === "BSC Paints Pvt Ltd") {
                                window.location.href = "BscPaint.aspx?ID=BSC&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }


                            else if (data.split('&')[1] === "RAUNAQ PAINT INDUSTRY") {
                                window.location.href = "raunaq.aspx?ID=Raunak&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }

                            else if (data.split('&')[1] === "SPORTECH SOLUTIONS") {
                                window.location.href = "https://thevitamin.co/pages/authenticate?ID=Vitamin&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "RELX INDIA PRIVATE LIMITED") {
                                window.location.href = "https://www.lexisnexis.in/authenticity?ID=RELX&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }

                            else if (data.split('&')[1] === "Yava Paints Pvt. Ltd.") {
                                window.location.href = "http://yavapaints.com/yuva-paints.html?ID=YAVA&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }

                            else if (data.split('&')[1] === "ORBIT ELECTRODOMESTICS INDIA") {
                                window.location.href = "https://www.indiaorbit.in/e-warranty?ID=Orbitindia&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "TECHNICAL MINDS PRIVATE LIMITED") {
                                window.location.href = "https://hypersonic.club/e-warranty?ID=Hypersonic&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];

                            }
                            else if (data.split('&')[1] === "SHERKOTTI INDUSTRIES PRIVATE LIMITED") {
                                window.location.href = "sherkotti.aspx?ID=SHERKOTTI INDUSTRIES PRIVATE LIMITED&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }                          


                            else if (data.split('&')[1] === "Veena Polymers") {
                                window.location.href = "veena-polymers.aspx?ID=Veena&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            /*
                            else if (data.split('&')[1] === "FOREVER NUTRITION") {
                                window.location.href = "Trueforma.html?ID=Truefarma&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }*/
                            else if (data.split('&')[1] === "FOREVER NUTRITION") {
                                window.location.href = "https://trueforma.in/authenticate?ID=Truefarma&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }

                            /*else if (data.split('&')[1] === "RSR Resource") {
                                window.location.href = "MuscleMountain.html?ID=MuscleMountain&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            } */
                            else if (data.split('&')[1] === "RSR Resource") {
                                window.location.href = "https://musclemountain.com/pages/authenticity?ID=MuscleMountain&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "Muscle Fighter Nutrition") {
                                window.location.href = "https://musclefighternutrition.com/authenticity?ID=musclefighter&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "MITHILA PAINTS PRIVATE LIMITED") {
                                window.location.href = "https://mithilapaints.com/loyality?ID=musclefighter&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "Color Valley Coatings") {


                                window.location.href = "colorvalley.aspx?ID=Color&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];

                            }
                            else if (data.split('&')[1] === "The Kolorado  Paints") {
                                window.location.href = "Kolorado.aspx?ID=Kolorado&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }

                            else if (data.split('&')[1] === "Gupta edutech Delhi") {
                                window.location.href = "https://verify.qmaths.in/?ID=Blackbook&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }

                            else if (data.split('&')[1] === "SWARAJ") {
                                window.location.href = "Swaraj.aspx?ID=SWARAJ&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "TESLA POWER INDIA PRIVATE LIMITED") {
                                window.location.href = "https://autoz365.com/scheme/tesla1.html?ID=Tesla&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "PRINCIPLE ADHESIVES PRIVATE LIMITED") {
                                window.location.href = "https://princecol.com/loyaltyprinciple.php?ID=PRINCIPLE ADHESIVES PRIVATE LIMITED&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "YAMUNA INTERIORS PRIVATE LIMITED") {
                                window.location.href = "blackcobraretail.aspx?ID=blackcobraretail&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "Yamuna Interiors Pvt Ltd G") {
                                window.location.href = "blackcobragov.aspx?ID=blackcobragov&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "SAFFRO MELLOW COATINGS AND RESINS") {
                                window.location.href = "https://saffromellow.com/loyalty/?ID=saffro mellow&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }

                            else if (data.split('&')[1] === "SAMSOIL PETROLEUM INDIA LTD") {
                                window.location.href = "Samsoils.aspx?ID=Samsoil&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "Shree Durga Traders") {
                                window.location.href = "durga.aspx?ID=Durga&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }                            
                            else if (data.split('&')[1] === "Girish Chemical Industries") {
                                window.location.href = "https://www.gcipaints.com/loyalty?ID=GCI Paint&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "HERBAL AYURVEDA AND RESEARCH CENTER") {
                                window.location.href = "herbal.aspx?ID=Canada_Herbels&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "Wellversed Health Pvt Ltd") {
                                window.location.href = "https://wellversed.in/pages/authenticator?ID=Wellverse&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }

                            else if (data.split('&')[1] === "Gupta edutech Delhi") {
                                window.location.href = "blackbook.html?ID=Blackbook&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "MIDAS TOUCH METALLOYS PRIVATE LIMITED") {
                                window.location.href = "scotts.html?ID=MIDAS TOUCH&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }

                            else if (data.split('&')[1] === "Indian Plywood Company") {
                                window.location.href = "https://www.indianplywoodcompany.com/authenticate.html?ID=Indianplywood&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "Helix") {
                                window.location.href = "Helix.aspx?ID=Helix&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "PROQUEST NUTRITION PRIVATE LIMITED") {
                                window.location.href = "https://www.proquest.fit/check-authenticity?ID=ProquestNutritionPvtLtd&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "CHERYL CHEMICAL AND POLYMERS") {
                                window.location.href = "hiffix.aspx?ID=CHERYL CHEMICAL AND POLYMERS&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "Muscle Garage") {
                                window.location.href = "musclegarage.aspx?ID=musclegarage&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "DURGA COLOUR AND CHEM.P LTD.") {
                                window.location.href = "MaxPaints.html?ID=MaxPaint&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "OCI Wires and Cables") {
                                window.location.href = "Oci.html?ID=OCI Wires and Cables&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            
                            else if (data.split('&')[1] === "Lubigen Pvt Ltd") {
                                window.location.href = "Lubigen.aspx?ID=Lubi&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "TRUE NUTRITION PERFORMANCE PRIVATE LIMITED") {
                                window.location.href = "TrueNutrition.aspx?ID=TRUE NUTRITION PERFORMANCE PRIVATE LIMITED&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "FITSIQUE") {
                                window.location.href = "https://fitsique.in/authenticate?ID=FITSIQUE&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "1 STOP NUTRITION") {
                                window.location.href = "1stop.aspx?ID=1Stop&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }

                            else if (data.split('&')[1] === "MANGAL DASS TRADING CO") {
                                window.location.href = "https://nikoltnutrition.com/authenticate?ID=Nikolt&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "Oltimo Lubes") {
                                window.location.href = "Oltimo.aspx?ID=Oltimo&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[0] === "0" && data.split('&')[1] === "VCQRU") {
                                window.location.href = "UPI-cashback.aspx?ID=VCQRU&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "BAGHLA SANITARYWARE") {
                                window.location.href = "Baghla.aspx?ID=Bhagla&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }

                            else if (data.split('&')[1] === "BLUEGEM PAINTS") {
                                window.location.href = "https://bluegem.in/authenticate?ID=Bluegem&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[1] === "Cosmo Tech Expo") {
                                window.location.href = "PackPlus.aspx?ID=Cosmo&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                                //window.location.href = "ihff-event.aspx?ID=Cosmo&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                                  // window.location.href = "ihff-event.aspx?ID=Cosmo&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];

		           }
                            else if (data.split('&')[1] === "Pack Plus") {
                                window.location.href = "event/code-check.html?ID=expo&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1];

                               // window.location.href = "PackPlus.aspx?ID=PackPlus&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            } else if (data.split('&')[1] === "Ram Gopal and Sons") {
                                window.location.href = "ramgopal.html?ID=ramgopal&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];

                            }
                            //else if (data.split('&')[1] === "Ram Gopal and Sons") {
                            //    window.location.href = "https://www.eagleshenna.com/authenticate?ID=Ramgopal&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            //}


                            else if (data.split('&')[1] === "R.S Industries") {
                                window.location.href = "polytuf_new.aspx?ID=polytuf&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];

                            }
                            else if (data.split('&')[1] === "Jupiter Aqua Lines Ltd") {


                                window.location.href = "JALBATH.aspx?ID=JALBATH&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];

                            }


                            else if (data.split('&')[0] === "0" && data.split('&')[1] === "Guru Kripa Enterprises") {



                                window.location.href = "codeverify.aspx?ID=GuruKripaEnterprises&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1];
                            }

                            else if (data.split('&')[0] === "0" && data.split('&')[1] === "PARAG MILK FOODS") {



                                window.location.href = "codeverify.aspx?ID=PARAG&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1];
                            }

                            else if (data.split('&')[0] === "0" && data.split('&')[1] === "Ankerite Health Care Pvt. Ltd") {



                                window.location.href = "codeverify.aspx?ID=AnkeriteHealth&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1];
                            }

                            else if (data.split('&')[0] === "0" && data.split('&')[1] === "Chase2Fit") {



                                window.location.href = "codeverify.aspx?ID=Chase2&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1];
                            }
                            else if (data.split('&')[0] === "0" && data.split('&')[1] === "Paras cosmetics private limited") {
                                window.location.href = "aromacare.aspx?ID=Paras&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1];
                            }
				else if (data.split('&')[1] === "Big Daddy Overseas") {
                                    window.location.href = "bigdaddy.html?ID=BigDaddy&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                                }
                            else if (data.split('&')[0] === "0" && data.split('&')[1] === "HANNOVER CHEMIKALIEN PRIVATE LIMITED") {
                                window.location.href = "hannover.aspx?ID=hanover&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[0] === "0" && data.split('&')[1] === "SRI ANANTHA PADMANABHA SWAMY ENTERPRISES") {
                                window.location.href = "vscpaint.html?ID=VSCPaint&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[0] === "0" && data.split('&')[1] === "BENITTON BATHWARE") {
                                window.location.href = "https://benittonbathware.com/loyalty/?ID=benittion&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
							 else if (data.split('&')[0] === "0" && data.split('&')[1] === "RANDHAWA SWEETS") {
                                window.location.href = "https://www.randhawasweets.com/authenticity/?ID=Randhawasweets&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }
                            else if (data.split('&')[0] === "0" && data.split('&')[1] === "Fit Fleet") {
                                window.location.href = "fit-fleet.aspx?ID=FitFleet&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];
                            }


                            else {
                                $('#warrenty').hide();
                                $('#Patanjali').hide();
                                $('#nutravel').hide();
                                $('#evercrop').hide();
                                $('#everproducts').hide();
                                $('#nutravelproduct').hide();
                                $('#amulyaproduct').hide();
                                $('#balckmangoproduct').hide()
                                $('#warratyHeading').hide();
                                $('#chkGun').show();
                                $('#checkcode').show();
                                $('#jpc').hide();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#jphcounter').hide();
                                $('#Coatsbathfitting').hide();
                                $('#skydecore').hide();

                            }
                        }
                    });

                    //    }
                    //});
                }
            });
        }
    });


    $('.next_btn').click(function () {
        $('#checkcode0').hide();
        $('#checkcode').hide();

    });

    $('#btnNext').click(function () {
        window.location.href = '<%=ProjectSession.absoluteSiteBrowseUrl%>';
    });
    $('#btnNext1').click(function () {
        window.location.href = '<%=ProjectSession.absoluteSiteBrowseUrl%>';
    });
    $('#btnNext2').click(function () {
        window.location.href = '<%=ProjectSession.absoluteSiteBrowseUrl%>';
    });
    $('#supriyabtnNext1').click(function () {
        window.location.href = '<%=ProjectSession.absoluteSiteBrowseUrl%>';
    });
    function isNumber(evt) {
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        return true;
    }

    function isNumber(evt, cntrl_id) {
        debugger;
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
