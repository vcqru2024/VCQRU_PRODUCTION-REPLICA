﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Patanjali.aspx.cs" Inherits="Patanjali" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Patanjali</title>
        <!-- Bootstrap css -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <!-- css -->
        <link rel="stylesheet" href="../assets/images/patanjali/css/css.css">
        <link rel="stylesheet" href="../assets/images/patanjali/css/reponsive.css">
        <!--sweet alert-->
        <!-- Add this to the head section of your HTML file -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- font family -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet">
        <!-- Boxicons CSS -->
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <!-- font-awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
            integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />


        <script src="vendor/modernizr/modernizr.min.js"></script>
        <script src="Content/js/jquery-1.11.1.min.js"></script>
        <script src="../Content/js/toastr.min.js"></script>
        <link href="../Content/css/toastr.min.css" rel="stylesheet" />

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
            integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA=" crossorigin="anonymous"></script>

        <style>
            .landing-ui .card-left .invalid-feedback {
                display: block;
            }

            #overlay {
                position: fixed;
                top: 0;
                z-index: 10000;
                width: 100%;
                height: 100%;
                display: none;
                background: rgba(0, 0, 0, 0.6);
            }

            .cv-spinner {
                height: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .spinner {
                width: 40px;
                height: 40px;
                border: 4px #ddd solid;
                border-top: 4px #2e93e6 solid;
                border-radius: 50%;
                animation: sp-anime 0.8s infinite linear;
            }

            @keyframes sp-anime {
                100% {
                    transform: rotate(360deg);
                }
            }

            .is-hide {
                display: none;
            }
        </style>

        <script type="text/javascript" language="javascript">

            function DisableBackButton() {
                window.history.forward()
            }
            DisableBackButton();
            window.onload = DisableBackButton;
            window.onpageshow = function (evt) { if (evt.persisted) DisableBackButton() }
            window.onunload = function () { void (0) }
        </script>


        <script type="text/javascript">
            //const { Session } = require("inspector");

            var BaseURL = "../";
            var lat = "";
            var long = "";
            var imgval1 = "";
            var imgval2 = "";
            var imgval3 = "";
            var getPosition = function (options) {
                return new Promise(function (resolve, reject) {
                    navigator.geolocation.getCurrentPosition(resolve, reject, options);
                });
            }

            function ShowProgress() {
                $("#overlay").fadeIn(300);

            };

            function HideProgress() {
                $("#overlay").fadeIn(0);
                $("#overlay").hide();

            };
            function getproductimg() {
                debugger;


                var Mobile = $('#Mobile').val();
                var d = Mobile.slice(0, 1);
                var c = parseInt(d);
                if (Mobile.match(/[^$,.\d]/)) {
                    $('#lblMobile').text(" Mobile number should not contain any special characters.");
                    $('#Mobile').val('');
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if (Mobile.length == 10 && c <= 5) {
                    $('#lblMobile').text("Please enter a valid mobile number.");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if (Mobile.length != 10) {
                    $('#lblMobile').text("Please enter your mobile number.");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }

                if (Mobile.length == 10) {


                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: BaseURL + 'Info/MasterHandler.ashx?method=Getproductimgurl&mobile=' + $('#Mobile').val() + "&vCode=" + $('#codeone').val() + '&comp=PATANJALI  FOODS  LIMITED&Comp_ID=Comp-1693',
                        success: function (data) {
                            HideProgress();
                            debugger;
                            var upperviewm = data.split('~')[0];
                            var lowerviewm = data.split('~')[1];
                            var fullviewm = data.split('~')[2];
                            if (upperviewm.includes('C:\inetpub\wwwroot\qa.vcqru.com')) {
                                upperviewm = upperviewm.replace("C:\inetpub\wwwroot\qa.vcqru.com", "..");
                                upperviewm = 'https://qa.vcqru.com' + upperviewm;
                            }
                            if (lowerviewm.includes('C:\inetpub\wwwroot\qa.vcqru.com')) {
                                lowerviewm = lowerviewm.replace("C:\inetpub\wwwroot\qa.vcqru.com", "..");
                                lowerviewm = 'https://qa.vcqru.com' + lowerviewm;
                            }
                            if (fullviewm.includes('C:\inetpub\wwwroot\qa.vcqru.com')) {
                                fullviewm = fullviewm.replace("C:\inetpub\wwwroot\qa.vcqru.com", "..");
                                fullviewm = 'https://qa.vcqru.com' + fullviewm;

                            }
                            document.getElementById('UpperViewimg').src = upperviewm;
                            document.getElementById('LowerViewimg').src = lowerviewm;
                            document.getElementById('FullViewimg').src = fullviewm;
                            //alert(upperviewm);
                            $('#verifypro').show();
                        }
                    });
                }

            }

            function GetArtimages() {

                debugger;

                var Mobile = $('#Mobile').val();

                if ($('#Mobile').val().replace(/\s+/g, '').length == 0) {
                    $('#lbl').text('Please Enter Your Mobile Number');
                    $('#Mobile').focus();
                    return false;
                }
                else {
                    $('#lbl').text('');
                }

                if ($('#divpincode').is(':visible')) {

                    Pincode = $("#Pin").val();
                    if (Pincode == "" || Pincode == undefined) {
                        $('#lblpincode').html('Please enter your pincode code');
                        return false;
                    }
                    else if (Pincode.length == 6 && Pincode.match(/^\d+$/)) {
                        Pin_check();
                        $('#lblpincode').html('');
                    }

                    else {
                        $('#lblpincode').html('**Please Enter the 6-digits pin code');
                        return false;
                    }

                }



                var d = Mobile.slice(0, 1);
                var c = parseInt(d);
                if (Mobile.match(/[^$,.\d]/)) {
                    $('#lbl').text(" Mobile number should not contain any special characters.");
                    $('#Mobile').val('');
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if (Mobile.length == 10 && c <= 5) {
                    $('#lbl').text("Please enter a valid mobile number.");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if (Mobile.length != 10) {
                    $('#lbl').text("Please enter your mobile number.");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }

                if (Mobile != undefined) {
                    if ($('#Mobile').val().length != 10) {
                        $('#lbl').text('Please Enter 10 Digit Mobile Number');
                        return false;
                    }
                    else {
                        $('#lbl').text('');
                    }
                }
                if (Mobile.length == 10) {
                    var rquestpage_Dcrypt1 = $("#codeone").val();
                    $('#loadermob').show();

                    $.ajax({
                        type: "POST",
                        url: BaseURL + 'Info/MasterHandler.ashx?method=chkwarrantypatanjali&codeone=' + rquestpage_Dcrypt1.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt1.split('-')[1] + '&mobile=' + $('#Mobile').val() + '&Comp_ID=Comp-1693',
                        success: function (data) {
                            $('#loadermob').hide();
                            HideProgress();
                            debugger;
                            if (data.split('&')[0] === "1" && data.split('&')[1] === "Auto Max India") {

                            }
                            else {
                                $('#CompName').val(data.split('&')[1]);



                                if (data.split('&')[3] === "True") {
                                    /* alert(data.split('&')[3]);*/
                                    $('#ChkCode').hide();
                                    //ChkCode.style.display = 'none';
                                    $('#Chkfields').show();
                                    $('#mobilefield').hide();
                                    $('#Otherfield').show();
                                    $('#divbutton').hide();
                                    $('#lbl').text('');
                                    /*// ArtImages */
                                    var ResCount = data.split('&')
                                    if (ResCount.length > 3) {
                                        var First = data.split('&')[4]
                                        var Second = data.split('&')[5]
                                        var Third = data.split('&')[6]
                                        var Four = data.split('&')[7]
                                        var Five = data.split('&')[8]
                                        var Six = data.split('&')[9]

                                        $("#FirstImage").attr("src", First.split('-')[0]);
                                        $("#hfFirst").val(First.split('-')[1]);

                                        $("#SecondImage").attr("src", Second.split('-')[0]);
                                        $("#hfSecond").val(Second.split('-')[1]);

                                        $("#ThirdImage").attr("src", Third.split('-')[0]);
                                        $("#hfThird").val(Third.split('-')[1]);

                                        $("#FourthImage").attr("src", Four.split('-')[0]);
                                        $("#hfFour").val(Four.split('-')[1]);

                                        $("#FifthImage").attr("src", Five.split('-')[0]);
                                        $("#hfFive").val(Five.split('-')[1]);

                                        $("#SixthImage").attr("src", Six.split('-')[0]);
                                        $("#hfSix").val(Six.split('-')[1]);
                                    }

                                    /*// ArtImages */


                                }
                                else if (data.split('&')[3] == "False") {
                                    $('#ChkCode').hide();
                                    //ChkCode.style.display = 'none';
                                    $('#Chkfields').show();
                                    $('#mobilefield').hide();
                                    $('#Otherfield').show();

                                    var ResData = 'The authenticity of this product is already verifed..';
                                    window.location.href = 'Patanjali_Success.aspx?id=' + ResData;


                                }
                                else {
                                    $('#ChkCode').show();
                                    //ChkCode.style.display = 'none';
                                    $('#Chkfields').hide();
                                    $('#mobilefield').hide();
                                    $('#Otherfield').hide();

                                    var ResData = 'The authenticity of this product cannot be confirmed. Avoid purchasing it. If you have doubts about a newly purchased pack, please contact customer care or report it here.';
                                    window.location.href = 'Patanjali_Success.aspx?id=' + ResData;

                                }

                            }
                            //getproductimg();
                        }
                    });
                }

            };

            function DataSubmit() {
                var Mobile = $('#Mobile').val();

                if ($("#codeone").val().length > 10) {

                }
                else {
                    var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                    $("#codeone").val(code);
                }

                var d = Mobile.slice(0, 1);
                var c = parseInt(d);
                if (Mobile.match(/[^$,.\d]/)) {
                    $('#lblMobile').text(" Mobile number should not contain any special characters.");
                    $('#Mobile').val('');
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if (Mobile.length == 10 && c <= 5) {
                    $('#lblMobile').text("Please enter a valid mobile number.");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if (Mobile.length != 10) {
                    $('#lblMobile').text("Please enter your mobile number.");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }




                $('#btnsubmit').hide();
                $('#btnloadsubmit').show();

                var IsFirst = $('#hfFirst').val();
                var IsSecond = $('#hfSecond').val();
                var IsThird = $('#hfThird').val();
                var IsFour = $('#hfFour').val();
                var IsFive = $('#hfFive').val();
                var IsSix = $('#hfSix').val();
                var IsVerified = $("#hfIsVerified").val();
                var Image = $('#hfImage').val();

                debugger;
                imgval1 = "No";
                imgval2 = "No";
                imgval3 = "No";
                imgval4 = "No";
                imgval5 = "No";
                imgval6 = "No";
                if (IsFirst == "True")
                    imgval1 = "Yes";
                if (IsSecond == "True")
                    imgval2 = "Yes";
                if (IsThird == "True")
                    imgval3 = "Yes";
                if (IsFour == "True")
                    imgval4 = "Yes";
                if (IsFive == "True")
                    imgval5 = "Yes";
                if (IsSix == "True")
                    imgval6 = "Yes";
                /* alert(code);*/
                if (code != "") {

                    ShowProgress();
                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: BaseURL + 'Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#Mobile').val() + "&vCode=" + $('#codeone').val() /*+ "&state=" + $('#State').val()*/ + '&SellerName=' + imgval1 + '&Other_Role=' + imgval2 + '&virtualPath1=' + Image + '&Shopname=' + $('#Shopname').val() + '&IsVerified=' + IsVerified + '&comp=PATANJALI  FOODS  LIMITED&Comp_ID=Comp-1693&Latitude=' + lat + '&Longitude=' + long + '&city=' + $('#City').val() + '&state=' + $('#State').val() + '&PinCode=' + $('#Pin').val(),
                        success: function (data) {
                            HideProgress();
                            $('#btnsubmit').show();
                            $('#btnloadsubmit').hide();
                            if (data.split('~')[0] !== "Failure") {
                                window.scrollTo(0, 0);
                                if (data.indexOf("not valid") !== -1) {
                                    data = data.split(".")[0];
                                }
                                var response = data.split('~')[1];
                                $('#pmsg').html(response);
                                sessionStorage.setItem('ResponseContent', '"+ response + "');
                                window.location.href = 'Patanjali_Success.aspx?id=' + response;
                            }
                            else {
                                $('#msgcoats').hide();

                                $('#btnsubmit').attr('disabled', false);

                                var response = data.split('~')[1];
                                sessionStorage.setItem('ResponseContent', response);
                                window.location.href = 'Patanjali_Success.aspx?id=' + data;
                            }
                        }
                    });
                }
                else {

                    $('#btnsubmit').attr('disabled', false);
                }
            }

            /*Pincode Api for the city and the state  */
            function Pin_check() {
                /*debugger;*/

                let pin = document.getElementById("Pin").value;
                if (pin.length == 6 && pin.match(/^\d+$/)) {
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

                            $("#City").val(city);
                            $("#City").attr('readonly', true);
                            $("#State").val(state);
                            $("#State").attr('readonly', true);

                            if ($("#city").val() != "") {

                            }
                            if ($("#state").val() != "") {

                            }
                        }
                        else {
                            $('#pincheck').show();
                            $('#pincheck').html("**Please Enter Valid Pincode");
                            $('#pincheck').css("color", "red");
                            $("#city").attr('readonly', false);
                            $("#state").attr('readonly', false);
                            pin_err = false;
                            return false;
                        }
                    }
                }

                else {
                    $("#city").val('');
                    $("#state").val('');
                    $("#city").attr('readonly', false);
                    $("#state").attr('readonly', false);

                    $('#lblcode').html("**Please Enter the 6-digits pin code");

                    return false;

                    pin_err = false;
                    return false;
                }

            }




            $(document).ready(function () {

                debugger;

                firstfunction();
                $('#ChkCode').show();
                $('#Chkfields').hide();
                $('#verifypro').hide();

                var id = $('#HdnID').val();

                if (id == "1") {

                    $('#ChkCode').show();
                    $('#mobilefield').hide();
                }

                else if (id == "Patanjli") {
                    $('#ChkCode').hide();
                    $('#Chkfields').show();
                    $('#mobilefield').show();
                    $('#Otherfield').hide();
                    var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                    $("#codeone").val(code);
                }
                $("#codeone").mask("99999-99999999");

                $("#BTNNXT").on('click', function (e) {
                    e.preventDefault();
                    debugger;

                    var codeone = $('#codeone').val();

                    if (codeone == "" || codeone == undefined) {
                        $('#lblcode').html('Please enter 13 digit code');
                        return false;
                    }
                    else {
                        $('#lblcode').text('');
                    }

                    if (codeone != undefined) {
                        if ($('#codeone').val().length < 14) {
                            $('#lblcode').html('Please enter 13 digit code');
                            return false;
                        }
                        else {
                            $('#lblcode').text('');
                        }
                    }

                    var rquestpage_Dcrypt = $("#codeone").val();



                    $("#HdnCode1").val(rquestpage_Dcrypt.split('-')[0]);
                    $("#HdnCode2").val(rquestpage_Dcrypt.split('-')[1]);

                    $('#btnnxt').hide();
                    $('#btnloadnxt').show();
                    $('#ChkCode').hide();

                    $.ajax({
                        type: "POST",
                        url: BaseURL + 'Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                        success: function (data) {
                            $.ajax({
                                type: "POST",
                                url: BaseURL + 'Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1] + '&lat=' + lat + '&long=' + long,
                                success: function (data) {

                                    HideProgress();
                                    $('#btnnxt').show();
                                    $('#btnloadnxt').hide();
                                    if (data.split('&')[0] === "1" && data.split('&')[1] === "Auto Max India") {
                                    }
                                    else {
                                        $('#CompName').val(data.split('&')[1]);

                                        if ($('#CompName').val() == "PATANJALI  FOODS  LIMITED" || $('#CompName').val() == "" || $('#CompName').val() == undefined) {
                                            $('#ChkCode').hide();
                                            //ChkCode.style.display = 'none';
                                            $('#Chkfields').show();
                                            $('#mobilefield').show();
                                            $('#Otherfield').hide();
                                        }
                                        else {
                                            $('#ChkCode').show();
                                            $('#Chkfields').hide();
                                            /* alert('Invalid Code');*/
                                        }
                                    }
                                }
                            });
                        }
                    });
                });


                $('#FirstImage').on({
                    'click': function () {
                        debugger;

                        var src = $('#FirstImage').attr('src')
                        $("#hfImage").val(src);
                        $("#hfIsVerified").val("False");
                        var Iscorrect = $('#hfFirst').val();
                        if (Iscorrect == "True") {
                            $("#hfIsVerified").val("True");
                            // $('#pmsg').html('The product you have purchased is an authentic product of Patanjali.');
                            $('#divupper').hide();
                            $('#divlower').hide();
                            $('#divfull').hide();
                            DataSubmit();

                        }

                        else {
                            //  $('#pmsg').html('Product authentication failed, Please contact customer support on +91-9999999999.');
                            $('#divupper').hide();
                            $('#divlower').hide();
                            $('#divfull').hide();
                            DataSubmit();
                        }



                    }
                });

                $('#SecondImage').on({
                    'click': function () {
                        debugger;
                        var src = $('#SecondImage').attr('src')
                        $("#hfImage").val(src);
                        $("#hfIsVerified").val("False");
                        var Iscorrect = $('#hfSecond').val();

                        if (Iscorrect == "True") {
                            $("#hfIsVerified").val("True");
                            //  $('#pmsg').html('The product you have purchased is an authentic product of Patanjali.');
                            $('#divupper').hide();
                            $('#divlower').hide();
                            $('#divfull').hide();
                            DataSubmit();
                        }
                        else {
                            //  $('#pmsg').html('Product authentication failed, Please contact customer support on +91-9999999999.');
                            $('#divupper').hide();
                            $('#divlower').hide();
                            $('#divfull').hide();
                            DataSubmit();
                        }
                    }
                });

                $('#ThirdImage').on({
                    'click': function () {

                        debugger;
                        var src = $('#ThirdImage').attr('src')
                        $("#hfImage").val(src);
                        $("#hfIsVerified").val("False");
                        var Iscorrect = $('#hfThird').val();

                        if (Iscorrect == "True") {
                            //  $('#pmsg').html('The product you have purchased is an authentic product of Patanjali.');
                            $("#hfIsVerified").val("True");
                            $('#divupper').hide();
                            $('#divlower').hide();
                            $('#divfull').hide();
                            DataSubmit();
                        }
                        else {
                            //  $('#pmsg').html('Product authentication failed, Please contact customer support on +91-9999999999.');
                            $('#divupper').hide();
                            $('#divlower').hide();
                            $('#divfull').hide();
                            DataSubmit();
                        }
                    }
                });

                $('#FourthImage').on({
                    'click': function () {

                        debugger;
                        var src = $('#FourthImage').attr('src')
                        $("#hfImage").val(src);
                        $("#hfIsVerified").val("False");
                        var Iscorrect = $('#hfFour').val();

                        if (Iscorrect == "True") {
                            //  $('#pmsg').html('The product you have purchased is an authentic product of Patanjali.');
                            $("#hfIsVerified").val("True");
                            $('#divupper').hide();
                            $('#divlower').hide();
                            $('#divfull').hide();
                            DataSubmit();
                        }
                        else {
                            //  $('#pmsg').html('Product authentication failed, Please contact customer support on +91-9999999999.');
                            $('#divupper').hide();
                            $('#divlower').hide();
                            $('#divfull').hide();
                            DataSubmit();
                        }
                    }
                });
                $('#FifthImage').on({
                    'click': function () {

                        debugger;
                        var src = $('#FifthImage').attr('src')
                        $("#hfImage").val(src);
                        $("#hfIsVerified").val("False");
                        var Iscorrect = $('#hfFive').val();

                        if (Iscorrect == "True") {
                            //  $('#pmsg').html('The product you have purchased is an authentic product of Patanjali.');
                            $("#hfIsVerified").val("True");
                            $('#divupper').hide();
                            $('#divlower').hide();
                            $('#divfull').hide();
                            DataSubmit();
                        }
                        else {
                            //  $('#pmsg').html('Product authentication failed, Please contact customer support on +91-9999999999.');
                            $('#divupper').hide();
                            $('#divlower').hide();
                            $('#divfull').hide();
                            DataSubmit();
                        }
                    }
                });
                $('#SixthImage').on({
                    'click': function () {

                        debugger;
                        var src = $('#SixthImage').attr('src')
                        $("#hfImage").val(src);
                        $("#hfIsVerified").val("False");
                        var Iscorrect = $('#hfSix').val();

                        if (Iscorrect == "True") {
                            //  $('#pmsg').html('The product you have purchased is an authentic product of Patanjali.');
                            $("#hfIsVerified").val("True");
                            $('#divupper').hide();
                            $('#divlower').hide();
                            $('#divfull').hide();
                            DataSubmit();
                        }
                        else {
                            //  $('#pmsg').html('Product authentication failed, Please contact customer support on +91-9999999999.');
                            $('#divupper').hide();
                            $('#divlower').hide();
                            $('#divfull').hide();
                            DataSubmit();
                        }
                    }
                });


                $("#Mobile").on('keyup', function (e) {
                    e.preventDefault();
                    GetArtimages();


                });



                $('#divrbl1 button').on('click', function (e) {
                    e.preventDefault();
                    $('#lbl').text('');
                    imgval1 = $(this).val();
                    //alert(imgval1);
                    if (imgval1 == "Yes" || imgval1 == "No") {
                        $('#divupper').hide();
                        $('#divlower').show();
                        $('#additionnalinfo').hide();
                    }

                });

                $('#divrbl2 button').on('click', function (e) {
                    e.preventDefault();
                    $('#lbl').text('');
                    imgval2 = $(this).val();
                    var rquestpage_Dcrypt1 = $("#codeone").val();
                    // alert(rquestpage_Dcrypt1);

                    $.ajax({
                        type: "POST",
                        url: BaseURL + 'Info/MasterHandler.ashx?method=Getproductdetailsbycode&Code1=' + rquestpage_Dcrypt1.split('-')[0] + '&Code2=' + rquestpage_Dcrypt1.split('-')[1],
                        success: function (data) {
                            $('#spnpname').html(data.split('~')[0]);
                            $('#spnbno').html(data.split('~')[1]);
                            $('#spnmdate').html(data.split('~')[2]);
                            $('#spnedate').html(data.split('~')[3]);
                            $('#spnmrp').html(data.split('~')[4]);
                        }
                    });

                    $('#divupper').hide();
                    $('#divlower').hide();
                    $('#divfull').show();
                    $('#additionnalinfo').hide();
                });


                $('#divrbl3 button').on('click', function (e) {
                    e.preventDefault();
                    $('#lbl').text('');
                    imgval3 = $(this).val();
                    // alert(imgval3);
                    if (imgval3 == "Yes" || imgval3 == "No") {
                        $('#divupper').hide();
                        $('#divlower').hide();
                        $('#divfull').hide();
                        $('#pmsg').hide();
                        $('#divshopfield').show();
                        $('#divbtnsubmit').show();
                    }

                });


                $('#btnsubmit').on('click', function (e) {
                    e.preventDefault();
                    debugger;
                    GetArtimages()
                });



                $('#btnNext').click(function () {
                    window.location.href = 'https://www.patanjaliayurved.net/';
                });


            });






            async function firstfunction() {

                if (navigator.geolocation) {
                    await getPosition()
                        .then((position) => {

                            $('#divpincode').hide();
                            $('#lat').val(position.coords.latitude);
                            $('#long').val(position.coords.longitude);
                            var latitude = position.coords.latitude;
                            var longitude = position.coords.longitude;
                            lat = latitude;
                            long = longitude;

                            $.ajax({
                                type: "POST",
                                async: true,
                                url: BaseURL + 'Info/MasterHandler.ashx?method=chklocation&lat=' + latitude + '&long=' + longitude,
                                success: function (data) {
                                    lat = latitude;
                                    long = longitude;

                                }
                            });
                        })
                        .catch((err) => {

                            $('#divpincode').show();
                            console.error(err.message);
                        });
                } else {

                    // x.innerHTML = "Geolocation is not supported by this browser.";
                }
            }
        </script>

    </head>

    <body>
        <div id="overlay">
            <div class="cv-spinner">
                <span class="spinner"></span>
            </div>
        </div>
        <!-- top-bar -->
        <div class="update-msg">
            <div class="container">
                <marquee behavior="" direction="" onmouseover="this.stop();" onmouseout="this.start();">
                    The authenticity of the products can only be checked through patanjali domain <a
                        href="https://www.patanjaliayurved.net/" target="_blank">patanjaliayurved.net</a></marquee>
            </div>
        </div>
        <!-- section -->
        <section class="landing-ui">
            <form runat="server" class="needs-validation" novalidate>
                <asp:HiddenField ID="hdnmob" runat="server" />
                <asp:HiddenField ID="HdnID" runat="server" />
                <asp:HiddenField ID="HdnCode1" runat="server" />
                <asp:HiddenField ID="HdnCode2" runat="server" />
                <asp:HiddenField ID="CompName" runat="server" />
                <asp:HiddenField ID="long" runat="server" />
                <asp:HiddenField ID="lat" runat="server" />
                <input type="hidden" name="hfFirst" id="hfFirst" />
                <input type="hidden" name="hfSecond" id="hfSecond" />
                <input type="hidden" name="hfIsVerified" id="hfIsVerified" />
                <input type="hidden" name="hfImage" id="hfImage" />
                <input type="hidden" name="hfThird" id="hfThird" />
                <input type="hidden" name="hfThird" id="hfFour" />
                <input type="hidden" name="hfThird" id="hfFive" />
                <input type="hidden" name="hfThird" id="hfSix" />

                <div class="container-fluid">
                    <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 row-cols-1 g-0">
                        <div class="col d-flex order-lg-1 order-2">
                            <div class="card-left">
                                <div class="logo">
                                    <img src="../assets/images/patanjali/img/logo.svg" alt="Logo">
                                </div>
                                <!--0 One "tab" for each step in the form: -->
                                <div id="ChkCode" class="my-4">
                                    <div class="tab">
                                        <h5 class="card-title">Check Authenticity</h5>
                                        <p class="card-text">
                                            Welcome to the official page of Patanjali product authenticity
                                            check portal
                                        </p>
                                        <div class="form-group">
                                            <label for="codeNumber" class="form-label">
                                                13 Digit Code
                                                <span>*</span></label>
                                            <input type="text" id="codeone" maxlength="13" placeholder="52258-87896578"
                                                class="form-control" name="codeNumber" required>
                                            <div id="lblcode" class="invalid-feedback"></div>
                                        </div>



                                        <div class="form-btns">
                                            <button type="button" id="BTNNXT" <%--onclick="nextPrev(1)" --%>
                                                class="btn">
                                                Next</button>
                                        </div>
                                    </div>
                                </div>

                                <div id="Chkfields">
                                    <div class="tab" id="mobilefield">
                                        <h5 class="card-title">Check Authenticity</h5>
                                        <p class="card-text">
                                            Welcome to the official page of Patanjali product authenticity
                                            check portal
                                        </p>
                                        <div class="form-group">
                                            <label for="Mobile" class="form-label">Mobile Number <span>*</span></label>
                                            <input type="text" maxlength="10" id="Mobile" placeholder="+91 9111111111"
                                                class="form-control" name="Mobile">
                                            <div id="lbl" class="invalid-feedback"></div>
                                        </div>


                                        <div id="divpincode">
                                            <div class="form-group">
                                                <label for="codeNumber" class="form-label">
                                                    Pin Code
                                                    <span>*</span></label>
                                                <input type="text" id="Pin" maxlength="6" placeholder="110041"
                                                    class="form-control" name="codeNumber" required>
                                                <div id="lblpincode" class="invalid-feedback"></div>
                                            </div>
                                            <div class="form-group" style="display:none;">
                                                <label for="codeNumber" class="form-label">
                                                    City
                                                    <span>*</span></label>
                                                <input type="text" class="form-control" maxlength="100" id="City"
                                                    placeholder="City*" required />


                                            </div>
                                            <div class="form-group" style="display:none;">
                                                <label for="codeNumber" class="form-label">
                                                    State
                                                    <span>*</span></label>
                                                <input type="text" maxlength="100" id="State" placeholder="State*"
                                                    class="form-control" required>

                                            </div>

                                        </div>

                                    </div>



                                    <div class="tab" id="Otherfield">
                                        <p id="pmsg"
                                            style="overflow: hidden; color: white; font-size: 16px !important; font-weight: bold; margin-left: 7px; margin-right: 7px; margin-top: 0%"
                                            class="massage_box text-center">
                                        </p>
                                        <h5 class="card-title">Check Authenticity</h5>
                                        <p class="card-text mb-2">
                                            Please verify the image printed on the label along with QR
                                            code.
                                        </p>
                                        <p class="card-text">
                                            Please click on the same image which is printed on label.
                                        </p>
                                        <div class="form-group">
                                            <div class="art-design">
                                                <div class="art-gif">
                                                    <img src="../assets/images/patanjali/img/Animation - 1713362634296.gif"
                                                        alt="gif" class="art-gif-img">
                                                </div>
                                                <img src="../assets/images/patanjali/img/art-design.png"
                                                    alt="art-design">
                                            </div>
                                            <div
                                                class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-3 row-cols-3 g-2">
                                                <div class="col text-center">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio"
                                                            name="flexRadioDefault" id="oneImg">
                                                        <label class="form-check-label" for="oneImg">
                                                            <img src="../assets/images/patanjali/img/logo.svg" alt=""
                                                                id="FirstImage">
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col text-center">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio"
                                                            name="flexRadioDefault" id="twoImg">
                                                        <label class="form-check-label" for="twoImg">
                                                            <img src="../assets/images/patanjali/img/logo.svg" alt=""
                                                                id="SecondImage">
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col text-center">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio"
                                                            name="flexRadioDefault" id="threeImg">
                                                        <label class="form-check-label" for="threeImg">
                                                            <img src="../assets/images/patanjali/img/logo.svg" alt=""
                                                                id="ThirdImage">
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col text-center">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio"
                                                            name="flexRadioDefault" id="fourImg">
                                                        <label class="form-check-label" for="fourImg">
                                                            <img src="../assets/images/patanjali/img/logo.svg" alt=""
                                                                id="FourthImage">
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col text-center">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio"
                                                            name="flexRadioDefault" id="fifthImg">
                                                        <label class="form-check-label" for="fifthImg">
                                                            <img src="../assets/images/patanjali/img/logo.svg" alt=""
                                                                id="FifthImage">
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col text-center">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio"
                                                            name="flexRadioDefault" id="sixthImg">
                                                        <label class="form-check-label" for="sixthImg">
                                                            <img src="../assets/images/patanjali/img/logo.svg" alt=""
                                                                id="SixthImage">
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- <div id="lbl" class="invalid-feedback"></div> -->
                                    <div class="form-btns" id="divbutton">
                                        <button type="button" id="prevBtn" onclick="nextPrev(-1)" class="d-none">
                                            Previous</button>
                                        <button type="button" id="btnsubmit" <%--onclick="nextPrev(1)" --%>
                                            class="btn">
                                            Next</button>
                                    </div>
                                </div>
                                <!-- for support -->
                                <div class="for-support">
                                    <hr>
                                    <span>For support</span>
                                    <ul>
                                        <li>
                                            <i class='bx bxs-phone-call'></i>
                                            <a href="tel:8047278314">+91-8047278314</a>

                                        </li>
                                        <li>
                                            <i class='bx bxs-envelope'></i>
                                            <a href="mailto:support@vcqru.com">support@vcqru.com</a>
                                        </li>
                                    </ul>
                                </div>
                                <!-- fou support-end -->
                                <div class="youtube-video d-lg-none d-block mt-3">
                                    <iframe width="100%"
                                        src="https://www.youtube.com/embed/PATK_BsHVZg?si=OrC-tnDEdjbCaTvw"
                                        title="YouTube video player" frameborder="0"
                                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                                        referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                                </div>
                            </div>
                        </div>
                        <div class="col d-flex order-lg-2 order-1">
                            <div class="card-right">
                                <div class="position-relative">
                                    <h4 class="card-title">Check product authenticity in 3 easy steps</h4>
                                    <ul>
                                        <li>
                                            <i class='bx bx-check'></i>
                                            <div>
                                                <h5>Scan the QR code</h5>
                                                <p>
                                                    Scan the QR code placed on the security label of the product
                                                    packaging.
                                                </p>
                                            </div>
                                        </li>
                                        <li>
                                            <i class='bx bx-check'></i>
                                            <div>
                                                <h5>Enter the mobile number</h5>
                                                <p>
                                                    Please kindly provide your valid mobile number for us to assist you
                                                    effectively.
                                                </p>
                                            </div>
                                        </li>
                                        <li>
                                            <i class='bx bx-check'></i>
                                            <div>
                                                <h5>Visual pattern identification</h5>
                                                <p>
                                                    Match the image from the webpage with the image available on the
                                                    product
                                                    packaging's security label.
                                                </p>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="youtube-video d-lg-block d-none">
                                    <iframe width="100%"
                                        src="https://www.youtube.com/embed/PATK_BsHVZg?si=OrC-tnDEdjbCaTvw"
                                        title="YouTube video player" frameborder="0"
                                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                                        referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </form>
        </section>
        <!-- footer -->
        <footer class="footer">
            <div class="container">
                <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1">
                    <div class="col">
                        <p>© 2024 Patanjali Ayurved Limited All Rights Reserved.</p>
                    </div>
                    <div class="col">
                        <p class="text-md-end text-center">
                            Design and development by <a href="https://www.vcqru.com/" target="_blank">VCQRU
                                Private Limited.</a>
                        </p>
                    </div>
                </div>
            </div>
        </footer>
        <!-- chat box -->
        <div class="main-chat-box" title="User Enquiry Form">
            <button class="open-chat-button btn btn-light" type="button" data-bs-toggle="modal"
                data-bs-target="#exampleModal" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Tooltip on top">
                <img src="../assets/images/patanjali/img/chat-icon.svg" id="chat-icon">
            </button>
            <div class="modal fade" id="exampleModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
                aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-sm modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header py-2">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Send us a Message</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form id="exampleModalform" class="needs-validation" enctype="multipart/form-data" novalidate>
                            <div class="modal-body">
                                <div
                                    class="row row-cols-xxl-1 row-cols-xl-1 row-cols-lg-1 row-cols-md-1 row-cols-1 g-1">
                                    <div class="col">
                                        <label for="name" class="form-label">Name<span>*</span></label>
                                        <input type="text" id="name" class="form-control"
                                            pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" placeholder="Enter Name" required>
                                        <div class="invalid-feedback">
                                            Enter valid name
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label for="mob" class="form-label">Mobile No<span>*</span></label>
                                        <input type="number" class="form-control" maxlength="10" id="mob"
                                            placeholder="920XX77XX6"
                                            oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value.length !== 10) this.setCustomValidity('Phone number must be exactly 10 digits.'); else this.setCustomValidity('');"
                                            required>
                                        <div class="invalid-feedback">
                                            Enter valid mobile number
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label for="email" class="form-label">Email Address<span>*</span></label>
                                        <input type="email" class="form-control" id="email"
                                            placeholder="example@xyz.com" required>
                                        <div class="invalid-feedback">
                                            Enter a valid email address.
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label for="city" class="form-label">City<span>*</span></label>
                                        <input type="text" class="form-control" id="city"
                                            pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" placeholder="Gurugram" required>
                                        <div class="invalid-feedback">
                                            Enter valid city
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label for="uploadCoupon" class="form-label">Upload coupon</label>
                                        <input type="file" name="image" class="form-control" id="uploadCoupon"
                                            accept=".jpg, .jpeg, .png, .pdf" placeholder=""
                                            style="background-image: none;">
                                        <div class="invalid-feedback">
                                            Please Upload coupon
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label for="enquiry" class="form-label">Enquiry<span>*</span></label>
                                        <textarea class="form-control" id="enquiry" rows="1" required></textarea>
                                        <div class="invalid-feedback">
                                            Enter valid message
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer pt-0 border-0">
                                <button type="submit" class="btn btn-primary w-100">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function showAlert(title, text, icon) {
                Swal.fire({
                    title: title,
                    text: text,
                    icon: icon,
                    confirmButtonText: 'OK'
                });
            }

            $(document).ready(function () {
                // Attach a submit event listener to the form
                $('#exampleModalform').submit(function (e) {
                    e.preventDefault(); // Prevent the default form submission behavior

                    // Show the loader overlay
                    $('#overlay').show();

                    // Validate the form
                    if (!this.checkValidity()) {
                        // If the form is invalid, hide the loader and show the validation feedback
                        $('#overlay').hide();
                        $(this).addClass('was-validated');
                        return;
                    }

                    // Prepare form data using FormData object to handle file upload
                    var formData = new FormData();
                    formData.append('Name', $('#name').val());
                    formData.append('city', $('#city').val());
                    formData.append('mobile', $('#mob').val());
                    formData.append('useremail', $('#email').val());
                    formData.append('image', $('#uploadCoupon')[0].files[0]); // Use files array to get the selected file
                    formData.append('enquiry', $('#enquiry').val());
                    formData.append('userid', 'Dipak Tiwari');
                    formData.append('email', 'dipak.tiwari@vcqru.com'); // You can set a default email here or get it from another source

                    // Make a POST request using AJAX
                    $.ajax({
                        type: 'POST',
                        url: 'Info/PatanjaliHandler.ashx?method=PatanjaliContactus',
                        data: formData,
                        contentType: false, // Set to false when sending FormData object
                        processData: false, // Set to false when sending FormData object
                        success: function (data) {
                            // Handle success response
                            console.log('Inquiry submitted successfully');
                            // Close the modal form
                            $('#exampleModal').modal('hide');
                            // Clear all input fields
                            $('#exampleModalform')[0].reset();
                            // Show a success message using SweetAlert
                            showAlert('Success!', 'Your Enquiry has been submitted successfully.', 'success');
                        },
                        error: function (xhr, status, error) {
                            // Handle error
                            console.error('Failed to submit inquiry:', error);
                            // Show an error message using SweetAlert
                            showAlert('Error!', 'Failed to submit your inquiry. Please try again later.', 'error')
                        },
                        complete: function () {
                            // Hide the loader overlay when the AJAX request is complete
                            $('#overlay').hide();
                        }
                    });
                });
            });
        </script>
        <!-- chat box end -->
        <!-- bootstrap js -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- form with next and prev-->
        <script>
            var currentTab = 0; // Current tab is set to be the first tab (0)
            showTab(currentTab); // Display the current tab

            function showTab(n) {
                // This function will display the specified tab of the form...
                var x = document.getElementsByClassName("tab");
                x[n].style.display = "block";
                //... and fix the Previous/Next buttons:
                if (n == 0) {
                    document.getElementById("prevBtn").style.display = "none";
                } else {
                    document.getElementById("prevBtn").style.display = "inline";
                }
                //if (n == (x.length - 1)) {
                //    document.getElementById("nextBtn").innerHTML = "Submit";
                //} else {
                //    document.getElementById("nextBtn").innerHTML = "Next";
                //}
                //... and run a function that will display the correct step indicator:
                fixStepIndicator(n)
            }

            function nextPrev(n) {
                // This function will figure out which tab to display
                var x = document.getElementsByClassName("tab");
                // Hide the current tab:
                x[currentTab].style.display = "none";
                // Increase or decrease the current tab by 1:
                currentTab = currentTab + n;
                // if you have reached the end of the form...
                if (currentTab >= x.length) {
                    // ... the form gets submitted:
                    //document.getElementById("regForm").submit();
                    return false;
                }
                // Otherwise, display the correct tab:
                showTab(currentTab);
            }

            function fixStepIndicator(n) {
                // This function removes the "active" class of all steps...
                var i, x = document.getElementsByClassName("step");
                for (i = 0; i < x.length; i++) {
                    x[i].className = x[i].className.replace(" active", "");
                }
                //... and adds the "active" class on the current step:
                x[n].className += " active";
            }
        </script>
        <!-- validation -->
        <script>
            // Example starter JavaScript for disabling form submissions if there are invalid fields
            (() => {
                'use strict'

                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                const forms = document.querySelectorAll('.needs-validation')

                // Loop over them and prevent submission
                Array.from(forms).forEach(form => {
                    form.addEventListener('submit', event => {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }

                        form.classList.add('was-validated')
                    }, false)
                })
            })()
        </script>


        <%-- <script>
            $('#recipeCarousel').carousel({
            interval: 5000
            })

            $('.carousel .carousel-item').each(function () {
            var minPerSlide = 1;
            var next = $(this).next();
            if (!next.length) {
            next = $(this).siblings(':first');
            }
            next.children(':first-child').clone().appendTo($(this));

            for (var i = 0; i < minPerSlide; i++) { next=next.next(); if (!next.length) {
                next=$(this).siblings(':first'); } next.children(':first-child').clone().appendTo($(this)); } });
                </script>--%>

                <script>
                    function maskNumber(input) {
                        // Get the input value
                        let number = input.value;

                        // Check if input is empty or less than 5 characters
                        if (!number || number.length < 5) {
                            return;
                        }

                        // Check if a hyphen already exists after the fifth character
                        if (number.charAt(5) === '-') {
                            return;
                        }

                        // Add hyphen after the fifth character
                        let maskedNumber = number.substring(0, 5) + '-' + number.substring(5);

                        // Update the input value with masked number
                        input.value = maskedNumber;
                    }

                    // Get the input element
                    const inputElement = document.getElementById('codeone');

                    // Add event listener to input element
                    inputElement.addEventListener('input', function () {
                        // Call the maskNumber function when input changes
                        maskNumber(this);
                    });
                </script>
    </body>

    </html>