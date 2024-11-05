<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CheckYourCodes.ascx.cs" Inherits="UserControl_CheckYourCodes" %>
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,900&display=swap" rel="stylesheet">

<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/3/jquery.inputmask.bundle.js"></script>
<%--<script src="../js/calendar/jquery-3.3.1.min.js"></script>--%>
<script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
<link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
 
<style>
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
    .checkcode5 #evercrop h3{
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
    .checkcode5 .web_links.facebook{
        background: #4790ef;
    }
    .checkcode5 .web_links.whats-app{
        background: #5cb35c;
    }
    .checkcode5 .web_links a{
        color: #FFF;
        top: 0;
        font-weight: 500;
        font-size: 16px;
    }
    .checkcode5 .group label{
        left:auto;
        top:20px;
    }
    .checkcode5 .group input:focus ~ label, .checkcode5 .group input:valid ~ label{
        top:0px;
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
    .checkcode5 .web_links span{
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
    .checkcode input[type="button"]{
        background:#2f90e5;
        color:#FFF;
        padding:.650rem .895rem;
        border-radius:3px;
    }
    .checkcode input[type="button"]:hover,.checkcode input[type="button"]:focus,.checkcode input[type="button"]:active{
        box-shadow: 0px 6px 10px rgba(47, 144, 229, 0.5);
    }
    .box-coats,.box-skydecore {
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

    .box-coats input.form-control,.box-skydecore input.form-control {
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
    .box-coats input:focus ~ label, .box-coats input:valid ~ label,.box-skydecore input:focus ~ label, .box-skydecore input:valid ~ label {
    top: -12px;
    font-size: 11px;
    color: #50a3e8;
    background: #FFF;
    padding: 0 9px;
    border-radius: 10px;
    /* border: 1px solid #2f90e5;*/
}
    .box-coats .curve::after,.box-skydecore .curve::after{
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
    .box-coats .curve,.box-skydecore .curve{
        position:relative;
        z-index:2;
    }
    .checkcode .curve svg,.box-skydecore .curve svg{
    position: absolute;
    bottom: 0;
    width: 100%;
    left: 0;
    transform: rotate(-180deg);
    }

    .checkcode .curve svg path{
        fill: #d9261c;
    }
    .box-skydecore .curve svg path{
        fill: #4da0e9;
    }

    .box-coats fieldset span,.box-skydecore fieldset span {
    margin-right: 18px;
    margin-left: 10px;
    color: #335979;
    font-weight: 600;
}
    .checkcode .curve h4{
        color:#2b5a84
    }
    .checkcode .curve #warrantyMsg{
        color:#2076b9;
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
    .message-box{
        /*background: #3aa0e8; 
        padding: 15px;
        margin-bottom: 20px; 
        border-radius: 4px; 
        color: #FFF;*/
       
    }
    .message-box1{
        background: #3aa0e8; 
        padding: 15px;
        margin-bottom: 20px; 
        border-radius: 4px; 
        color: #FFF;
       
    }
    .code-message{
       /* background: #17a0d6;
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 4px;
        color: #FFF;*/
    }
    .code-message p{
       /* margin:0 auto !important;*/
   /*     color:#FFF !important; */
    }
    .web_links{
        padding-left: 5em; position: relative;min-height: 62px; text-align: left;border: 1px solid #d1d8e1; border-radius: 4px;
        margin-bottom:8px;
        padding-right: 10px;
        transition: 0.5s ease;
        padding-bottom: 8px;
    }
    .web_links span{
        position: absolute; top: 5px; left: 9px; width: 50px; height: 50px; border-radius: 50%; overflow: hidden;
    }
    .web_links a{
        position:relative; top:17px
    }
   .web_links:hover{
        box-shadow: 0px 2px 20px rgba(0, 0, 0, 0.2);
         transition: 0.5s ease;
    }
    body {
       /* background: url(https://newmibridges.michigan.gov/resource/1557577540000/ISD_Icons/landing-page/group-3.svg);*/
       
       background: #f7f7f7 url(assets/images/codecheck-bg.svg);
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
        background-attachment: fixed;
        margin: 4em auto;
        height: 75vh;
    }

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
    fieldset span{
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
        .web_links a{
            position:relative;
            top:5px; 
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
        max-height: 320px;
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
    @media (min-width: 1200px) {
        .checkcode {
        max-width: 550px;
        margin: 0px auto;
        display: block;
        background: #ffffff;
        position: relative;
        top: 50%;
        left: 0;
        transform: translateY(-50%);
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
        .box-coats,.box-skydecore {
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
            /*top: 0;*/
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


<div>
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
	</div>



<div class="container">
    <p id="msg" style="display:none"></p>
    <div id="dvouter" class="outer_div">
        <div id="clogo" class="brand displayNone">
            <img src="../images/Flora/flora-logo.jpg" alt="flora-logo">
        </div>

        <div id="maincode" class="row">
            <div class="col-md-12">
                <div class="row">
             <div class="col-md-5 mb-4 mcenter-box">
                <div class="checkcode fadeInDown animated" id="checkcode0">
                    <div class="row">
                        <div id="code" class="col-md-12 hintline">
                            <div class="filter">
                    <span class="step1 active">1</span>
                    <span class="step2">2</span>
                    <span class="step3">3</span>
                </div>
                            <span class="check-code-text-headding">Scratch to reveal the code and enter the 13 digits code</span>
                            <div class="group">
                                <input type="text" class="input1 step1" required="" value="" data-msg-required="Please enter Code." maxlength="13" name="codeone" id="codeone" autofocus required="required" data-inputmask="'mask': '99999 9999 9999'" />
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label>Enter the Code</label>
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
            <div class="col-md-12"  style="margin: 0 auto;">
            <div id="checkcode" class="checkcode5 p-0 bounceIn animated" animation-duration="0.5s"   style="display: none;">  <!--box-coats-->
                <div class="curve pl-4 pr-4 pt-4 pb-4">
   
                <div class="row">
                    <div id="checkcodein" class="col-md-5" style="margin: 0 auto;">
                        
                         <div>
                            <div id="warratyHeading" style="display: block;">
                                <div style="text-align: center;  display:block; width:100%;" class="mb-4 fadeinDown animated">
                                   <img src="#" id="imgWarrantyLogo" alt="" style="width: 250px;padding: 10px;border-radius: 10px;background: #ffffff;box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.2);" />
                                    
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
                                    <p id="p3msg" class="displayNone" style="margin-top:5px;color:red;"></p><br />
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
                                        <div class="group">
                                            <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control mobile_num form-control-modal" name="number" id="MM_mobile" onkeypress="return isNumber(event,'MM_mobile')" onkeydown="return isNumber(event,'MM_mobile')" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Enter Mobile Number</label>
                                        </div>
                                        <div class="group" style="margin-top:4px;">
                                            <input type="text" class="input1" required="" value="" data-msg-required="Please enter Dealer Technician/Techmaster ID." maxlength="13" name="empID" id="empID" autofocus required="required" />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Enter Technician/Techmaster ID</label>
                                        </div>
                                        <div class="group" style="margin-top:4px;margin-bottom:3px;">
                                            <input type="text" class="input1" required="" value="" data-msg-required="Please enter dealer Code." maxlength="13" name="distributorID" id="distributorID" autofocus required="required" />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Enter Dealer Code</label>
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
                                        <div style="float: right; "><a href="javascript:void(0)" id="btnResendOtp">Resend OTP</a></div>
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
                                            <input type="text" value="" data-msg-required="Please enter the purchase date." placeholder="Enter Purchase Date" class="form-control form-control-modal" name="date" id="purchasedate"  required />
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
                                         <p id="sky_message" class="message-box1 rubberBand animated" data-animation="animated rubberBand" style="display:none"></p>
                                     <a href="javascript:void(0)" class="next_btn" id="btnNext2" style="display:none">Close</a>

                                     <%--</div>--%>
                                    <div id="skydecore"  style="display: none;"> 
                                       
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
                                        <div class="group" style="display:none">
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
                                        <div style="float: right; "><a href="javascript:void(0)" id="btnResendOtp1">Resend OTP</a></div>
                                        <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnskyVerify" />
                                    </div>
                                    <div id="warrentyauto" style="display: none;">
                                        <h4>Enter Details to register warranty</h4>
                                        <div class="group">
                                            <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10"  maxlength="10" class="form-control mobile_num form-control-modal" name="number" id="autowarr_mobile" onkeypress="return isNumber(event,'autowarr_mobile')" onkeydown="return isNumber(event,'autowarr_mobile')" required />
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
        <div class="row" id="coats" style="display:none">
            <div id="c_logo" class="brand shake animated" style= "border-radius:4px; height:auto; width:150px">
             <img src="#" alt="coats-logo" id="coats_logo" style="border-radius:4px; width:100%;">
             </div>
            <div class="col-md-12 mt-4"  style="margin: 0 auto;">  
            <div id="check_code" class="checkcode5 p-0 fadeInUp animated">  <!--box-coats-->
                <div class="curve pl-4 pr-4 pt-4 pb-4n pb-3"> 
                   <div class="row"> 
                    <div id="checkcode_in" class="col-md-5" style="margin: 0 auto;">
                         <div class="row">
                                <div class="col-md-12 hintline" id="msgcoats" style="display:none">
                                    <p id="p1msg2"></p>
                                     <a href="javascript:void(0)" class="next_btn" id="btnNext1">Close</a>
                                </div>
                            </div>
                        <div id="Coatsbathfitting">
                            <h3 id="coatsheading" style="display:none">Welcome to the world of COATS</h3>
                            <h3 id="skyheading" style="display:none; text-align:center">Welcome to the world of SKYDECOR</h3>
                                        <h4>Enter Details</h4>
                                             <div class="group">
                                                 <fieldset id="check_Array" class="mb-3" style="display: flex;">
                                            <input type="radio" value="Plumber" name="checkdesignation" checked="checked"><span>Plumber</span>
                                                  <input type="radio" value="Consumer" name="checkdesignation"  /><span>Consumer</span>
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
                                    <div id="evercrop">
                                         <h3>एवर क्रॉप</h3>
                                        <h4>Enter Details</h4>
                                        <div class="row">   
                                        <div class="group col-md-12">
                                            <input type="text" value="" data-msg-required="Please enter the Name" class="form-control form-control-modal" name="ever_name" id="ever_name" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>नाम</label>
                                        </div>
                                        <div class="group col-md-6">
                                            <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control form-control-modal" name="number" id="ever_mobile" onkeypress="return isNumber(event,'ever_mobile')" onkeydown="return isNumber(event,'ever_mobile')" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>मोबाइल नंबर</label>
                                        </div>
                                        <div class="group col-md-6">
                                            <input type="text" value="" data-msg-required="Please enter village."  class="form-control form-control-modal" name="village" id="ever_village" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>गाँव</label>
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
                                            <label>जिला</label>
                                        </div>
                                         <div class="group col-md-12">
                                            <input type="text" value="" data-msg-required="Please enter the state."  class="form-control form-control-modal" name="state" id="ever_state" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>राज्य</label>
                                        </div>
                                       
                                        
                                        <div class="mt-4 col-md-6">
                                        <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnever" />
                                        </div>
                                            </div>
                                    </div>
                        <!--ever crop window end-->
                        <!--Nutravel -->
                        <div id="nutravel">
                            <h3 id="nutraheading">Welcome to the world of </h3>
                                        <h4>Enter Details</h4>
                                         
                                         <div class="group">
                                            <input type="text" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control form-control-modal" name="number" id="nutra_mobile" onkeypress="return isNumber(event,'nutra_mobile')" onkeydown="return isNumber(event,'nutra_mobile')" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Enter Mobile Number</label>
                                        </div>
                                        <div class="mt-3">
                                        <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnnutra" />
                                        </div>
                                    </div>
                        <!--Nutravel end -->
                        <div id="patanjali" style="display:none">
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

                         <div id="divOtpVerified2" style="display: none">
                                        <span class="check-code-text-headding" id="otpMsg2"></span>
                                        <div class="group">
                                            <input type="text" value="" data-msg-required="Please enter the otp number." maxlength="4" class="form-control form-control-modal" name="number" id="nonmmOTP1" onkeypress="return isNumber(event)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Enter OTP</label>
                                        </div>
                                        <div style="float: right; "><a href="javascript:void(0)" id="btnResendOtp2">Resend OTP</a></div>
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
                                        <div style="float: right; "><a href="javascript:void(0)" id="btnResendOtp3">Resend OTP</a></div>
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
                                    <div class="owl-carousel owl-theme" id="patanjali_images" style="display:none">
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
                                                       <div class="web_links" id="youtube" style="display:none">
                                                        <span><img style="width:100%; height:50px;" src="../assets/images/youtube.svg"></span>
                                                        <a href="https://www.youtube.com/watch?v=fxmUWArnOic" target="_blank">https://www.youtube.com/watch?v=fxmUWArnOic</a>
                                                       </div>
                                                       <div class="web_links" id="coatslink">
                                                        <span><img style="width:100%; height:50px;" src="../assets/images/sky-decoreweb.svg"></span>
                                                          <a href="https://www.coatsbath.co.in/" target="_blank">https://www.coatsbath.co.in/</a>
                                                       </div>
                                                        <div class="web_links" id="skylink">
                                                        <span><img style="width:100%; height:50px;" src="../assets/images/sky-decoreweb.svg"></span>
                                                         <a href="http://www.skydecor.in" target="_blank">http://www.skydecor.in</a>
                                                       </div>
                                                         <div class="web_links" id="patanjalilink" style="display:none">
                                                        <span><img style="width:100%; height:50px;" src="../assets/images/sky-decoreweb.svg"></span>
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
                                            <img class="img-fluid mx-auto d-block" src="../assets/images/ever/product-coats1.jpg" alt="wire-cables">
                                           
                                        </div>
                                        <div class="item">
                                            <img class="img-fluid mx-auto d-block" src="../assets/images/ever/product-coats2.jpg" alt="mcb-switch">
                                            
                                        </div>
                                        <div class="item">
                                            <img class="img-fluid mx-auto d-block" src="../assets/images/ever/product-coats3.jpg" alt="main-switch">
                                           
                                        </div>
                                        <div class="item">
                                            <img class="img-fluid mx-auto d-block" src="../assets/images/ever/product-coats4.jpg" alt="capacitors">
                                            
                                        </div>

                                    </div>

                                </div>
                            </div> 
                             <div class="row">
                                                
                                               
                                                <div class="col-md-12 text-xcenter">
                                                    <!--offset-md-4-->
                                                    <div class="pt-4 pb-2 d">
                                                 
                                                       <div class="web_links facebook">
                                                        <span><img style="width:100%; height:50px; padding:3px" src="../assets/images/facebook.svg"></span>
                                                          <a href="https://www.facebook.com/evercrop.agro/" target="_blank">https://www.facebook.com/evercrop.agro/</a>
                                                       </div>
                                                        <div class="web_links whats-app">
                                                        <span><img style="width:100%; height:50px; padding:3px" src="../assets/images/whats-app.svg"></span>
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
                                                  
                                                       <div class="web_links">
                                                        <span><img style="width:100%; height:50px;" src="../assets/images/sky-decoreweb.svg"></span>
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
                                                    
                                                       <div class="web_links">
                                                        <span><img style="width:100%; height:50px;" src="../assets/images/sky-decoreweb.svg"></span>
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
                                                    
                                                       <div class="web_links">
                                                        <span><img style="width:100%; height:50px;" src="../assets/images/sky-decoreweb.svg"></span>
                                                          <a href="http://blackmangoherbs.com/" target="_blank">http://blackmangoherbs.com/</a>
                                                       </div>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                        </div>
                        
                    </div>
                       <!--black mango end-->
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
                                <div class="columns box_info" >
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



                    if (data != "0") {

                        $('#jpc_dealerid').val(data);



                        $('#jpc_dealerid').attr('data - msg - required', '');

                        $('#jpc_dealerid').attr('disabled', 'disabled');

                    }

                }

            });

        }

    });
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
                 
                    $.ajax({
                        type: "POST",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                        success: function (data) {
                            debugger;
                           
                            if (data.split('&')[0] === "1" && data.split('&')[1] === "Auto Max India") {
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
                            else if (data.split('&')[1] === "Nutravel Health Care") {

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
                            //else if (data.split('&')[3] === "MM") {
                            //    $('#chkGun').hide();
                            //    $('#warrenty').hide();
                            //    $('#checkcode0').show();
                            //    $('#checkcode').hide();
                            //    $('#checkcode2').hide();
                            //    $('#divCompany').show();

                            //    $('#warratyHeading div').css('margin-top', "0px")
                            //    compInformation = data.split('&')[1];
                            //    $('#warratyHeading').show();
                            //    $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                            //    $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            //}
                            //else if (data.split('&')[1] === "MAHINDRA AND MAHINDRA LTD") {
                            else if (data.split('&')[3] === "MM" && data.split('&')[1] === "MAHINDRA AND MAHINDRA LTD") {
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
