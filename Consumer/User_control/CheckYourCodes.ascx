<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CheckYourCodes.ascx.cs" Inherits="UserControl_CheckYourCodes" %>
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,900&display=swap" rel="stylesheet">

<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/3/jquery.inputmask.bundle.js"></script>
<%--<script src="../js/calendar/jquery-3.3.1.min.js"></script>--%>
<script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
<%--<link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />--%>
<meta name="apple-mobile-web-app-capable" content="yes">


<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
	  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/webrtc-adapter/5.0.4/adapter.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.1.10/vue.min.js"></script>
    <%--<script type="text/javascript" src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>--%>
	<script type="text/javascript" src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
	<!-- Global site tag (gtag.js) - Google Analytics -->

	
<style>
    @media(max-width:420px) {
        .checkcode {
            padding: 35px 35px !important;
        }
    }
    .red{
       color:red !important;

    }
    .hide{
        display:none;
    }

    /*body {
        font-family: 'Lato', sans-serif;
    }*/

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

        .check-code-text-headding:after {
            content: '';
            border-left: 4px solid #6b9ac1;
            position: absolute;
            left: 0px;
            top: 0px;
            height: 100%;
        }
        .warrentyheading{
            font-size:18px !important;
            font-weight:600;
        }
    .checkcode {
 max-width: 420px;
    margin: 0px auto;
    display: block;
    padding: 50px;
    background: #ffffff;
    left: 50%;
    width: 90%;
    border-radius: 15px;
        border: 1px solid #ddd;
    box-shadow: 2px 2px 2px rgba(225,225,225,0.9);
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

    /*body {
        background: url(https://newmibridges.michigan.gov/resource/1557577540000/ISD_Icons/landing-page/group-3.svg);
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
        margin-top: 35px;
    }

    input {
        font-size: 18px;
        padding: 10px 10px 10px 5px;
        display: block;
        width: 100%;
        border: none;
        border-bottom: 1px solid #0a0a0a;
        background: transparent;
    }

        input:focus {
            outline: none;
        }

    /* LABEL ======================================= */
    label {
        color: #525252;
        font-size: 16px;
        font-weight: normal;
        position: absolute;
        pointer-events: none;
        left: 5px;
        top: 10px;
        transition: 0.2s ease all;
        -moz-transition: 0.2s ease all;
        -webkit-transition: 0.2s ease all;
        font-weight: 300;
    }

    /* active state */
    input:focus ~ label, input:valid ~ label {
        top: -20px;
        font-size: 14px;
        color: #5264AE;
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
         display: flex;
    width: 100%;
    height: auto;
    margin: 10em auto;
    /* background: #ccc9c9; */
    position: relative;
    justify-content: center;
    align-items: center;
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

        .filter span:after {
            content: "";
            border-bottom: 2px solid #2d85cf;
            width: 260%;
            position: absolute;
            top: 20px;
            left: 40px;
            z-index: -1;
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
            background: #6bb0e8;
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

        @media only screen and (max-width: 600px) {
            .warrentyheading {
                font-size: 15px !important;
                font-weight: 600;
            }
        }
    }
</style>


<div class="outer_div">
     <p id="msg" style="display:none"></p>
    <div class="checkcode" id="checkcode0">
        <div class="row">
            <div class="col-md-12 hintline">
                
                <span class="check-code-text-headding">Scratch to reveal the code and enter the 13 digits code</span>
                <div class="group">
                  
                    <input type="text" class="input1 step1" required="" value="" data-msg-required="Please enter code." maxlength="13" name="codeone" id="codeone" autofocus required="required" data-inputmask="'mask': '99999 9999 9999'" />
                    <span class="highlight"></span>
                    <span class="bar"></span>
                    <label>Enter the Code</label>
                </div>
            </div>

        </div>
       


    </div>

    <div class="checkcode" id="checkcode" style="display: none;">
        <div class="row">
            <div class="col-md-12">
                <div id="warratyHeading" style="display: block;">
                    <div style="text-align: center; margin-bottom: 10px; margin-top: 60px;">
                        <img src="#" id="imgWarrantyLogo" alt="" style="width: 250px;" />
                    </div>
                    <%--<div id="warrantyMsg" style="font-size: 18px; font-weight: bold; margin-bottom: 10px; text-align: center;">Welcome </div>--%>
                </div>

               
                <div class="form-row">
                    <div class="form-group col-md-12">
                        <div class="group" id="chkGun" style="display: none;">
                            <input type="text" value="" data-msg-required="Please enter the mobile number." maxlength="10" class="form-control mobile_num form-control-modal step2" name="number" id="mobile" onkeypress="return isNumber(event,'mobile')" required />
                            <span class="highlight"></span>
                            <span class="bar"></span>
                            <label>Enter Mobile Number</label>
                        </div>
                        <div class="group" id="chkGun1" style="display: none;">
                            <input type="text" value="" data-msg-required="Please enter the mobile number." maxlength="10" class="form-control mobile_number form-control-modal step2" name="number" id="mobile1" onkeypress="return isNumber(event,'mobile1')" required />
                            <span class="highlight"></span>
                            <span class="bar"></span>
                            <label>Enter Mobile Number</label>
                        </div>
                        <div id="divCompany" style="display: none;">
                            <div class="group">
                                <input type="text" value="" data-msg-required="Please enter the mobile number." maxlength="10" class="form-control form-control-modal" name="number" id="MM_mobile" onkeypress="return isNumber(event,'MM_mobile')" required />
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label>Enter Mobile Number</label>
                            </div>
                            <div class="group">
                                <input type="text" class="input1" required="" value="" data-msg-required="Please enter Dealer Technician/Techmaster ID." maxlength="13" name="empID" id="empID" autofocus required="required" />
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label>Enter Technician/Techmaster ID</label>
                            </div>
                            <div class="group">
                                <input type="text" class="input1" required="" value="" data-msg-required="Please enter dealer Code." maxlength="13" name="distributorID" id="distributorID" autofocus required="required" />
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label>Enter Dealer Code</label>
                            </div>

                            <input type="button" value="Submit" class="btn btn-primary btn-modern" style="margin-top: 20px" id="btnCompany" />
                        </div>

                        <div id="divOtpVerified" style="display: none">
                            <span class="check-code-text-headding" id="otpMsg"></span>
                            <div class="group">
                                <input type="text" value="" data-msg-required="Please enter the otp number." maxlength="4" class="form-control form-control-modal" name="number" id="mmOTP" onkeypress="return isNumber(event)" required />
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label>Enter OTP</label>
                            </div>
                            <div style="float: right; margin-bottom: 25px; margin-top: -35px;"><a href="javascript:void(0)" id="btnResendOtp">Resend OTP</a></div>
                            <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnVerify" />
                        </div>

                        <div id="warrenty" style="display: none; text-align: center;">
                            <span class="warrentyheading">Enter Details to register warranty</span>
                            <div class="group">
                                <input type="text" value="" data-msg-required="Please enter the mobile number." maxlength="10" class="form-control form-control-modal" name="number" id="warr_mobile" onkeypress="return isNumber(event)" disabled required />
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <%--<label>Enter Mobile Number</label>--%>
                            </div>

                            <div class="group">
                                <input type="text" value="" data-msg-required="Please enter the e-mail address." class="form-control form-control-modal" name="email" id="emailAddress" required />
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label id="emaillabelwarr">Enter Email Address</label>
                            </div>

                            <div class="group">
                                <input type="text" value="" data-msg-required="Please enter the bill number." maxlength="16" class="form-control form-control-modal" name="bill" id="billNumber" required />
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label id="bill_label">Enter Bill Number</label>
                            </div>

                            <div class="group">
                                <input type="text" value="" data-msg-required="Please enter Purchase Date."   class="form-control form-control-modal" name="date" id="purchasedate" required />
                                <%--<br /><input type="text" class="datepicker">--%>
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                 <label id="purhase_label">Enter Purchase Date</label>
                            </div>

                            <div class="group">
                                <input type="file" class="form-control form-control-modal" accept="image/*" name="imgbill" id="img_bill" required />
                                <span class="highlight"></span>
                                <span class="bar"></span>
                            </div>

                            <input type="button" value="Submit" style="margin-top: 20px;" class="btn btn-primary btn-modern" id="btnWarranty" />
                        </div>
                        <div id="warrentyauto" style="display: none; text-align: center;">
                                        <h4>Enter Details to register warranty</h4>
                                        <div class="group">
                                            <input type="number" value="" data-msg-required="Please enter the mobile number." minlength="10" maxlength="10" class="form-control form-control-modal" name="number" id="autowarr_mobile" onkeypress="return isNumber(event)" required />
                                            <span class="highlight"></span>
                                            <span class="bar"></span>
                                            <label>Enter Mobile Number</label>
                                        </div>


                                        <input type="button" value="Submit" class="btn btn-primary btn-modern" id="btnautoWarranty" />
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
                        <img src="../image/logo-1.png" class="" style="width: 70%; height: auto;" />
                    </div>
                    <div class="col-md-12">
                        <p class="check-code-text-right-side">Step 1: Scratch to reveal the code</p>
                        <p class="check-code-text-right-side">Step 2 Input the code & mobile no. and click the “Verify” button</p>
                    </div>
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

    <div class="checkcode" id="checkcode1" style="display: none">
        <div class="row">
            <div class="col-md-12">
                

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
                        <a href="CodeCheck.aspx" class="next_btn" id="btnNext">Check More Codes</a>
                    </div>
                </div>
                <div class="col-md-6 custom-padding-modal-stape" style="display: none">
                    <div class="row modal-border-right-style">
                        <div class="col-md-12 text-center">
                            <img src="../image/logo-1.png" class="" style="width: 70%; height: auto;" />
                        </div>
                        <div class="col-md-12">
                            <p class="check-code-text-right-side">Step 1: Scratch to reveal the code</p>
                            <p class="check-code-text-right-side">Step 2 Input the code & mobile no. and click the “Verify” button</p>
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

<script type="text/javascript">
    $('#billNumber').on('keypress', function (event) {
        var regex = new RegExp("^[a-zA-Z0-9]+$");
        var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
        if (!regex.test(key)) {
            event.preventDefault();
            return false;
        }
    });
    var compInformation = "";
    $(".input1").keyup(function () {
        if (this.value.length == this.maxLength) {
            $('#checkcode0').hide();
            $('#checkcode2').show();
            var rquestpage_Dcrypt = $("#codeone").val();
            debugger
           <%-- $.ajax({
                type: "POST",
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                success: function (data) {--%>
                    debugger
                    $.ajax({
                        type: "POST",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                        success: function (data) {
                            debugger;
                        if(data.split('&')[0] === "1" && data.split('&')[1] === "Auto Max India") {
                $('#chkGun').hide();
                $('#warrentyauto').show();
                $('#warratyHeading').show();
                $('#checkcode').show();
                $('#checkcode2').hide();
                $('#divCompany').hide();
                            $('#msg').html(data.split('&')[3].toString());
                $('#autowarr_mobile').val($('#mobilenumber').val());
                $('#warrantyMsg').text("Welcome " + data.split('&')[1]);

                //$("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                $('#autowarr_mobile').focus();
            }
                          else if (data.split('&')[0] === "1") {

                                $('#p1msg').html(data.split('&')[3]);
                                $('#p1msg:contains("not")').css('color', 'red');
                                msg = data.split('&')[2].toString().replace('~', '');
                                $('#mobile').hide();
                               
                               
                                
                                $('#warrenty').hide();
                                $('#warratyHeading').hide();
                                $('#chkGun1').show();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#mobile1').val($('#mobilenumber').val());
                                $('#mobile1').focus();
                                $('#mobile1').show();

                            //    $('#p1msg').html(data.split('&')[3]);
                            //    $('#p1msg:contains("not")').css('color', 'red');
                            //    $('#checkcode1').show();
                            //    $('#warrenty').hide();
                            //    $('#warratyHeading').show();
                            //    $('#divCompany').hide();
                            //    $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                            //    $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }
                            else if (data.split('&')[0] === "2" && data.split('&')[1] === "Auto Max India") {
                                $('#chkGun').hide();
                                $('#warrentyauto').show();
                                $('#warratyHeading').show();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();

                                $('#autowarr_mobile').val($('#mobilenumber').val());
                                $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                              
                                //$("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                                $('#autowarr_mobile').focus();
                            }
                            else if (data.split('&')[3] === "MS") {
                                $('#warrenty').hide();
                                $('#warratyHeading').hide();
                                $('#chkGun').show();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                                $('#mobile').val($('#mobilenumber').val());
                                $('#mobile').focus();
                            }
                           else if (data.split('&')[0] === "2") {
                                $('#mobile').show();
                                $('#mobile1').hide();
                                $('#chkGun').hide();
                                $('#warrenty').show();
                                $('#warratyHeading').show();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                 $('#divCompany').hide();
                              
                                 $('#warr_mobile').val($('#mobilenumber').val());
                                //$('#warrantyMsg').text("Welcome " + data.split('&')[1]);
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
                            else if (data.split('&')[1] === "MAHINDRA AND MAHINDRA LTD") {
                                $('#mobile').show();
                                $('#mobile1').hide();
                                 $('#MM_mobile').val($('#mobilenumber').val());
                                $('#chkGun').hide();
                                $('#warrenty').hide();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').show();
                                
                                $('#warratyHeading div').css('margin-top', "0px")
                                compInformation = data.split('&')[1];
                                $('#warratyHeading').show();
                                //$('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }
                            else {
                                $('#mobile').show();
                                $('#mobile1').hide();
                                $('#warrenty').hide();
                                 $('#warratyHeading').hide();
                            
                                $('#chkGun').show();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                 $('#divCompany').hide();

                                 $('#mobile').val($('#mobilenumber').val());
                                 $('#mobile').focus();

                           
                            }
                        }
                    });
            //    }
            //});
        }
    });

    //$('.next_btn').click(function () {
    //    $('#checkcode0').hide();
    //    $('#checkcode').show();
    //});

    $('#btnNext').click(function () {
        window.location.href = '<%=ProjectSession.absoluteSiteBrowseUrl%>';
    });
    function isNumber(evt) {
        debugger;
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

        if ($('#' + cntrl_id).val().length == 0) {

            if (parseInt(evt.key) < 6)
                return false;

        }
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        return true;
    }
</script>
