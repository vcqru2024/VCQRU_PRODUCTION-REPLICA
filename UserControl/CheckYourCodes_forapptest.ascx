<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CheckYourCodes.ascx.cs" Inherits="UserControl_CheckYourCodes" %>
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,900&display=swap" rel="stylesheet">

<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/3/jquery.inputmask.bundle.js"></script>
<%--<script src="../js/calendar/jquery-3.3.1.min.js"></script>--%>
<script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
<link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />

<style>
    @media(max-width:420px) {
        .checkcode {
            padding: 35px 35px !important;
        }
    }


    .checkcode5 {
        padding: 40px 30px;
        /* max-width: 500px; */
        width: 100%;
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

    body {
        background: url(https://newmibridges.michigan.gov/resource/1557577540000/ISD_Icons/landing-page/group-3.svg);
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
        padding: 30px;
        background: transparent;
        border-radius: 10px;
        margin-top: 6em;
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
            width: 260%;
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
        margin-top: -74px;
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
        display: none;
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

    @media (max-width: 1400px) {
        .outer_div {
            height: auto;
        }

        .section_type {
            width: 100%;
            padding-top: 0 !important;
            margin-top: 0em;
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
</style>
<div class="container">
    <p id="msg" style="display:none"></p>
    <div id="dvouter" class="outer_div">
        <div id="clogo" class="brand displayNone">
            <img src="../images/Flora/flora-logo.jpg" alt="flora-logo">
        </div>

        <div class="row">
            <div class="col-md-5 mb-4 mcenter-box">
                <div class="checkcode" id="checkcode0">
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

        <div class="row">
            <div id="checkcode" class="checkcode5" style="display: none;">
                <div class="row">
                    <div id="checkcodein" class="col-md-5" style="margin: 0 auto;">
                         <div class="col-md-12">
                            <div id="warratyHeading" style="display: block;">
                                <div style="text-align: center; margin-bottom: 10px; margin-top: 60px;">
                                    <img src="#" id="imgWarrantyLogo" alt="" style="width: 250px;" />
                                </div>
                                <div id="warrantyMsg" style="font-size: 18px; font-weight: bold; margin-bottom: 10px; text-align: center;">Welcome </div>
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
                                        <div style="float: right; margin-bottom: 25px; margin-top: -24px;"><a href="javascript:void(0)" id="btnResendOtp">Resend OTP</a></div>
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
                                            <label>Enter Bill Number</label>
                                        </div>

                                        <div class="group">
                                            <input type="text" value="" data-msg-required="Please enter the purchase date." placeholder="Enter Purchase Date" class="form-control form-control-modal" name="date" id="purchasedate" disabled required />
                                            <%--<br /><input type="text" class="datepicker">--%>
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                        </div>

                                        <div class="group">
                                            <input type="file" class="form-control form-control-modal" name="imgbill" id="img_bill" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                        </div>

                                        <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnWarranty" />
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


        <div class="row">
            
            <div id="checkcode1" class="checkcode5" style="display: none;">

                <div class="row">

                    <div id="checkcode1in" class="col-md-5" style="margin: 0 auto;">

                        <div class="mb-4 mcenter-box">
                            <div class="filter" id="dvcode1filt">
                                <span class="step1 active">1</span>
                                <span class="step2 active">2</span>
                                <span class="step3 active">3</span>
                            </div>

                            <div class="form-row">
                                <div class="row mb-4" style="display: none">
                                    <div class="col-md-12">
                                        <input type="submit" value="Submit" onclick="return chkgenuenity();" class="btn btn-primary btn-modern" data-loading-text="Loading..." />
                                        <input type="text" value="" placeholder="Referral Code" disabled="disabled" maxlength="12" class="form-slider" id="RefCd" style="display: none;" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 hintline">
                                    <p id="p1msg"></p>
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

                    <div id="divdem" class="col-md-7 displayNone">

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
<script>
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
</script>
<script type="text/javascript">
    var compInformation = "";
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
                    debugger
                    $.ajax({
                        type: "POST",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                        success: function (data) {
                            debugger;
                         
                            if (data.split('&')[0] === "1" && data.split('&')[1] === "Auto Max India" ) {
                                $('#chkGun').hide();
                                $('#warrentyauto').show();
                                $('#warratyHeading').show();
                                $('#checkcode').show(); 
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#jphcounter').hide();
                                $('#msg').html(data.split('&')[3].toString());
                           
                                $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }
                          else  if (data.split('&')[0] === "0" && data.split('&')[1] === "JPH Publications Pvt. Ltd") {
                                $('#chkGun').hide();
                                $('#jphcounter').show();
                                $('#warratyHeading').show();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();

                                //$('#msg').html(data.split('&')[3].toString());

                                $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
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
                            
                        else if (data.split('&')[0] === "2" && data.split('&')[1] === "Auto Max India" ) {
                        $('#chkGun').hide();
                         $('#warrentyauto').show();
                        $('#warratyHeading').show();
                        $('#checkcode').show();
                        $('#checkcode2').hide();
                        $('#divCompany').hide();
                                $('#jphcounter').hide();
                        $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                        $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                    }
                            else if (data.split('&')[0] === "2") {
                                $('#chkGun').hide();
                                $('#warrenty').show();
                                $('#warratyHeading').show();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#jphcounter').hide();
                                $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
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
                                $('#chkGun').hide();
                                $('#warrenty').hide();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').show();
                                $('#jphcounter').hide();
                                $('#checkcode1').removeClass('checkcode5');
                                $('#checkcode1').addClass('checkcode');
                                $('#checkcode1in').removeClass('col-md-5');
                                $('#checkcode1in').addClass('col-md-12');

                                $('#warratyHeading div').css('margin-top', "0px")
                                compInformation = data.split('&')[1];
                                $('#warratyHeading').show();
                                $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }
                            else if (data.split('&')[1] === "Competent Electricals India") {
                                $('#warrenty').hide();
                                $('#warratyHeading').hide();
                                $('#clogo').removeClass('displayNone');
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


                            }
                            else {
                                $('#warrenty').hide();
                                $('#warratyHeading').hide();
                                $('#chkGun').show();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#jphcounter').hide();

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
