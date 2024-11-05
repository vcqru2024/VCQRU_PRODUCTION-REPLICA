<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PackPlus.aspx.cs" Inherits="PackPlus" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pack Plus</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script type="text/javascript" src="http://cdn.jsdelivr.net/jquery.slick/1.3.15/slick.min.js"></script>


    <script src="../Content/js/jquery-1.11.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>






</head>
<body>

    <style type="text/css">
        .clbl {
            color: #ff0101;
            /* background-color: red; */
            text-align: center;
            font-size: 14px;
            font-weight: bold;
        }


             .carousel .carousel-item {
                transition-duration: 0.1s;
            }

       #radioDiv {
            display: flex;
        }

        .vip2 {
            padding: 5px;
            color:white;
        }

        .vip {
            width: 20%;
            height: calc(1.5em + 0.75rem + 2px);
            font-size: 1rem;
            font-weight: 400;
            line-height: 1;
            color: #495057;
        }

        .banner-cosmetic {
            position: relative;
            background-size: 100% 100%;
            background-repeat: no-repeat;
            width: 100%;
            display: table;
            height: 100vh;
            background-image: url(../assets/images/Packplus/Pack_plus_bg.png);
        }



        .carousel-item a {
            text-decoration: none;
        }

        .logo img {
            width: 30%;
            max-width: 100%;
        }

        .heading-maine {
            font-size: 65px;
            color: #00285a !important;
            font-weight: bolder;
        }

        .social-icone img {
            width: 30px;
        }

        form {
            background-color: #00285a;
            /* padding: 20px 20px; */
            padding: 10px;
            width: 75%;
            float: right;
        }


        .heading-pack-plus {
            font-size: 30px;
        }

        .common {
            border-radius: 20px;
            padding-left: 50px;
            padding: 20px 50px;
        }

        .common-icone {
            position: relative;
        }



            .common-icone img {
                position: absolute;
                width: 8%;
                top: 4px;
                left: 11px;
            }

        .btn {
            background-color: #18beb7;
            width: 100%;
            border-radius: 20px;
            outline: none;
            border-none
        }





        .qr-heading {
            font-size: 16px;
            text-align: center;
        }

        footer {
            padding: 10px;
            background: #00285a;
            position: absolute;
            bottom: 0;
            width: 100%;
        }

        .number-style a {
            color: #fff;
        }

        .social-icone a {
            padding-right: 10px;
        }



        /*88888888888888888888888888888*/


        .card-body {
            background: #00285a;
            width: 100%;
            border-radius: 14px;
            margin: 23px auto;
        }

        @media (max-width: 767px) {

            form {
                width: 90%;
                float: none;
                margin: auto;
            }

            .card-body {
                width: 90%;
                margin: auto;
            }

            .heading-maine {
                font-size: 33px;
            }

            .mobile {
                text-align: center;
            }

            .banner-cosmetic {
                padding-bottom: 120px;
            }
            /*.banner-cosmetic {
                padding-bottom: 120px;*/
            /*  background-image: url(./img/mobile.png);*/
            /*display:none;
            }*/

            .social-icone a {
                padding-right: 3px;
            }

            .website {
                text-align: center;
            }
        }

        @media (width: 360px) {
            .heading-maine {
                font-size: 31px;
            }
        }


        @media (max-width: 767px) {
            .carousel-inner .carousel-item > div {
                display: none;
            }

            .mobie {
            }


            .maine-img img {
                display: none;
            }




            .social-icone {
                text-align: center;
            }

            .carousel-inner .carousel-item > div:first-child {
                display: block;
            }

            .carousel-control-next {
                right: -5px !important;
            }

            .carousel-control-prev {
                left: -5px !important;
            }

            .common-icone img {
                width: 34px;
                left: 5px;
                top: 4px;
            }
        }

        .carousel-inner .carousel-item.active,
        .carousel-inner .carousel-item-next,
        .carousel-inner .carousel-item-prev {
            display: flex;
        }

        /* display 3 */
        @media (min-width: 768px) {

            .carousel-inner .carousel-item-right.active,
            .carousel-inner .carousel-item-next {
                transform: translateX(16.666667%);
            }

            .common-icone img {
                position: absolute;
                width: 34px;
                top: 4px;
                left: 6px;
            }

            .banner-cosmetic {
                padding-bottom: 112px;
            }


            .carousel-inner .carousel-item-left.active,
            .carousel-inner .carousel-item-prev {
                transform: translateX(-16.666667%);
            }

            form {
                float: initial;
                margin: auto;
            }
        }

        .carousel-inner .carousel-item-right,
        .carousel-inner .carousel-item-left {
            transform: translateX(0);
        }

        .carousel-item.active .col-md-4:nth-child(2) {
            transform: scale(1.2);
        }

        .carousel-control-next {
            right: -29px;
        }

        .carousel-control-prev {
            left: -29px;
        }

        @media (width: 1024px) {
            .card-body {
                display: table;
                padding: 5px;
            }

                .card-body img {
                    padding: 12px;
                }

                .card-body h6 {
                    font-size: 12px;
                }

            .heading-maine {
                font-size: 56px;
            }
        }

        @media (min-width: 768px) and (max-width: 920px) {

            .img-maine {
                display: none;
            }
        }

        @media (width: 280px) {
            .common-icone img {
                width: 34px;
            }

            .banner-cosmetic {
                padding-bottom: 149px;
            }

            .social-icone img {
                width: 25px;
            }

            ::placeholder {
                font-size: 10px;
            }
        }

        @media (width: 540px) {
            .common-icone img {
                width: 34px;
            }

            .heading-maine {
                font-size: 47px;
            }
        }
    </style>


    <%--<script>
        $(document).ready(function () {
            //Cookies
            function setCookie(cname, cvalue, exdays) {
                debugger;
                const d = new Date();
                d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
                let expires = "expires=" + d.toUTCString();
                document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
            }

            function getCookie(cname) {
                debugger;
                let name = cname + "=";
                let decodedCookie = decodeURIComponent(document.cookie);
                let ca = decodedCookie.split(';');
                for (let i = 0; i < ca.length; i++) {
                    let c = ca[i];
                    while (c.charAt(0) == ' ') {
                        c = c.substring(1);
                    }
                    if (c.indexOf(name) == 0) {
                        return c.substring(name.length, c.length);
                    }
                }
                return "";
            }

            function checkCookie() {
                let user = getCookie("codeone");
                if (user != "") {
                    alert("Welcome again " + user);
                } else {
                    user = prompt("Please enter your name:", "");
                    if (user != "" && user != null) {
                        setCookie("username", user, 30);
                    }
                }
            }

        //Cookies

        });
    </script>--%>


    <script>
        $("#codeone").mask("99999-99999999");
        $("#mobile").mask("9999999999");




        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }



        //function Getdata() {
        //    debugger;
        //    var mobileno = $('#mobile').val();
        //    var d = mobileno.slice(0, 1);
        //    var c = parseInt(d);



        //    if ($('#mobile').val() == "") {
        //        $('#lbl').text('Please Enter Mobile Number!');
        //        $('#dealer').focus();
        //        return false;
        //    }
        //    else {
        //        $('#lbl').text('');
        //    }
        //    if (mobileno.length < 10) {
        //        $('#lbl').text('Please Enter 10 Digit Mobile Number!');
        //        return false;
        //    }
        //    else {
        //        $('#lbl').text('');
        //    }
        //    if (mobileno.match(/[^$,.\d]/)) {
        //        $('#lbl').text('Mobile Number Shoud Not be Alphabet!');
        //        $('#mobile').val('');
        //        return false;
        //    }
        //    else {
        //        $('#lbl').text('');
        //    }
        //    if (mobileno.length == 10) {
        //        document.cookie = "=Mobile:" + mobileno + ";" +"expires=Thu, 04 Jan 2924 00:00:00 UTC;"
                
        //        $.ajax({
        //            type: "Post",
        //            url: '../Info/MasterHandler.ashx?method=GetCodeCountbyMobile&MobileNo= ' + $("#mobile").val() + "&CompName=Pack Plus",
        //            success: function (data) {

        //                if (data.split('~')[0] === "failure") {
        //                    //alert(data.split('~')[1]);
        //                    $('#HEADING').hide();
        //                    $('#ChkCode').hide();
        //                    $('#Chkfields').hide();
        //                    $('#otpfield').hide();
        //                    $('#ShowMessage').show();
        //                    $('#p3msg').html(data.split('~')[1]);
        //                    $('#p3msg:contains("not")').css('color', 'white');
        //                }
        //                else {
        //                    $.ajax({
        //                        type: "POST",
        //                        contentType: false,
        //                        processData: false,

        //                        url: '../Info/MasterHandler.ashx?method=sendotpexibition&mobile=' + $('#mobile').val(),
        //                        success: function (data) {
        //                            if (data == "OTP send successfully") {
        //                                $('#HEADING').hide();
        //                                $('#ChkCode').hide();
        //                                $('#Chkfields').hide();
        //                                $('#otpfield').show();
        //                            }
        //                        }

        //                    });
        //                    $('#HEADING').hide();
        //                    $('#ChkCode').hide();
        //                    $('#mobilefield').hide();
        //                    $('#Chkfields').hide();
        //                    $('#otherfield').hide();
        //                    $('#otpfield').show();
        //                    $('#ShowMessage').hide();
        //                    $('#p3msg').html(data.split('~')[1]);
        //                    $('#p3msg:contains("not")').css('color', 'white');
        //                }


        //            }
        //        });
        //    }
        //    else {
        //        $('#lbl').text('Invalid Mobile Number');
        //    }
        //}

        //function createHTML(data) {
        //    debugger;
        //    alert(data.otp);
        //    alert(data.success);
        //    alert(data[0].success);
        //    alert(data[0].success);
        //    alert(data[0].otp);
        //    if (data.success == 1) {
        //        alert('ok');
        //    }
        //    else {
        //        alert('Invalid Request');
        //    }
        //}


        function Dopostback() {
            $('#btnsubmit').show();
            $('#imgloaddersubmit').hide();
            $('#btnsubmit').attr('disabled', false);
            //checkInternetConnection();
        }


        function checkInternetConnection() {
            var status = navigator.onLine;
            alert(status);
            if (status) {
                $('#ethernetloader').hide();
            } else {
                $('#ethernetloader').show();
            }
            setTimeout(function () {
                checkInternetConnection();
            }, 1000);
        }


       


        //calling above function
        


        $(document).ready(function () {

            //checkInternetConnection();

            debugger;
            $('#ChkCode').show();
            $('#Chkfields').hide();
            $('#mobilefield').hide();
            $('#otpfield').hide();
            var id = $('#HdnID').val();
            if (id == "1") {

                $('#ChkCode').show();
                $('#Chkfields').hide();
                $('#mobilefield').hide();
                $('#otpfield').hide();
            }

            else if (id == "Cosmo") {
                $('#ChkCode').hide();
                $('#otherfield').hide();
                $('#mobilefield').show();
                $('#Chkfields').hide();
                $('#otpfield').hide();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $("#codeone").val(code);
            }




            $("#codeone").mask("99999-99999999");
            $("#btnnxt").on('click', function () {
                debugger;
                //$("#btnnxt").hide();
                //$('#imgloadder').show();


                var codeone = $('#codeone').val();
                if (codeone != undefined) {
                    if ($('#codeone').val().length < 14) {
                        $('#lblmob').text('Please Enter 13 Digit Code*');
                        $('#codeone').focus();
                        return false;
                    }
                    else {
                        $('#lblmob').text('');
                    }
                    if ($('#codeone').val().length > 14) {
                        $('#lblmob').text('Please Enter 13 Digit Code*');
                        $('#codeone').focus();
                        return false;
                    }

                    else {
                        //document.cookie = "=Code:" + codeone + ";" + "expires=Thu, 04 Jan 2924 00:00:00 UTC;"

                       /* $('#imgloadder').hide();*/
                        $('#lblmob').text('');
                        $('#ChkCode').hide();
                        $('#Chkfields').hide();
                        $('#otherfield').hide();
                        $('#mobilefield').show();
                        $('#otpfield').hide();
                    }
                }
                else {
                    $('#lblmob').text('Please Enter 13 Digit Code*');
                    $('#codeone').focus();
                    return false;
                }
            });


            $("#btnsendotp").on('click', function () {
               // checkInternetConnection();
                debugger;
                var mobileno = $('#mobile').val();
                var d = mobileno.slice(0, 1);
                var c = parseInt(d);



                if ($('#mobile').val() == "") {
                    $('#lblgetotp').text('Please Enter Mobile Number!');
                    $('#mobile').focus();
                    return false;
                }
                else {
                    $('#lblgetotp').text('');
                }

                if (c <= 5) {
                    $('#lblgetotp').text('Please enter a valid number*');
                    $('#mobile').focus();
                    $('#mobile').val('');
                    return false;
                }
                else {
                    $('#lblgetotp').text('');
                }

                if (mobileno.length < 10) {
                    $('#lblgetotp').text('Please Enter 10 Digit Mobile Number!');
                    return false;
                }
                else {
                    $('#lblgetotp').text('');
                }
                if (mobileno.match(/[^$,.\d]/)) {
                    $('#lblgetotp').text('Mobile Number Shoud Not be Alphabet!');
                    $('#mobile').val('');
                    return false;
                }
                else {
                    $('#lblgetotp').text('');
                }
                if (mobileno.length == 10) {
                    $("#btnsendotp").hide();
                    $('#imgloaddersendotp').show();
                    //document.cookie = "=Mobile:" + mobileno + ";" + "expires=Thu, 04 Jan 2924 00:00:00 UTC;"

                    $.ajax({
                        type: "Post",
                        url: '../Info/MasterHandler.ashx?method=GetCodeCountbyMobile&MobileNo= ' + $("#mobile").val() + "&CompName=Cosmo Tech Expo",
                        success: function (data) {
                            
                            if (data.split('~')[0] === "failure") {
                                //alert(data.split('~')[1]);
                                $('#imgloaddersendotp').hide();
                                $('#HEADING').hide();
                                $('#ChkCode').hide();
                                $('#Chkfields').hide();
                                $('#mobilefield').hide();
                                $('#otpfield').hide();
                                $('#ShowMessage').show();
                                $('#p3msg').html(data.split('~')[1]);
                                $('#p3msg:contains("not")').css('color', 'white');
                            }
                            else {
                                $.ajax({
                                    type: "POST",
                                    contentType: false,
                                    processData: false,

                                    url: '../Info/MasterHandler.ashx?method=sendotpexibition&mobile=' + $('#mobile').val(),
                                    success: function (data) {
                                        $('#imgloaddersendotp').hide();
                                        if (data == "OTP send successfully") {
                                            $('#HEADING').hide();
                                            $('#ChkCode').hide();
                                            $('#Chkfields').hide();
                                            $('#otpfield').show();
                                        }
                                    }

                                });
                                $('#HEADING').hide();
                                $('#ChkCode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').hide();
                                $('#otherfield').hide();
                                $('#otpfield').show();
                                $('#ShowMessage').hide();
                                $('#p3msg').html(data.split('~')[1]);
                                $('#p3msg:contains("not")').css('color', 'white');
                            }


                        }
                    });
                }
                else {
                    $('#lblgetotp').text('Invalid Mobile Number');
                }
            });




            $('#btnsubmitotp').on('click', function () {
               // checkInternetConnection();
                debugger;
                $('#btnsubmitotp').attr('disabled', true);
                $('#btnsubmitotp').hide();
                $('#imgloaddersubmitotp').show();
                $.ajax({
                    type: "POST",
                    contentType: false,
                    processData: false,

                   

                    url: '../Info/MasterHandler.ashx?method=Validateotp&verifycode=' + $('#otp').val() + '&mobile=' + $('#mobile').val(),
                    success: function (data) {
                        $('#imgloaddersubmitotp').hide();
                        //alert(data);
                        if (data == "Success") {
                            $('#HEADING').hide();
                            $('#ChkCode').hide();
                            $('#Chkfields').show();
                            $('#otherfield').show();
                            $('#otpfield').hide();
                            $('#ShowMessage').hide();
                        }
                        else {
                            $('#lblvalidateotp').text('Invalid Otp');
                            $('#btnsubmitotp').show();
                            $('#imgloaddersubmitotp').hide();
                            $('#btnsubmitotp').attr('disabled', false);
                        }
                    }

                });

               
            });



            $('#btnsubmit').on('click', function () {
                debugger;
                
              //  checkInternetConnection();
                //document.cookie = "=Name:" + $('#Name').val() + ";" + "expires=Thu, 04 Jan 2924 00:00:00 UTC;"
                
                //document.cookie = "=Email:" + $('#Email').val() + ";" + "expires=Thu, 04 Jan 2924 00:00:00 UTC;"
                
                //document.cookie = "=Companyname:" + $('#Companyname').val() + ";" + "expires=Thu, 04 Jan 2924 00:00:00 UTC;"
               
                //document.cookie = "=Designation:" + $('#Designation').val() + ";" + "expires=Thu, 04 Jan 2924 00:00:00 UTC;"
               
                //document.cookie = "=Intrest:" + $("#radioDiv input[type='radio']:checked").val() + ";" + "expires=Thu, 04 Jan 2924 00:00:00 UTC;"
                //var cookiesdata = document.cookie;
                //alert(cookiesdata.split('=')[1]);
                //alert(cookiesdata.split('=')[2]);
                //alert(cookiesdata.split('=')[3]);
                //alert(cookiesdata.split('=')[4]);
                //alert(cookiesdata.split('=')[5]);
                //alert(cookiesdata.split('=')[6]);
                //alert(cookiesdata.split('=')[7]);
                $('#btnsubmit').hide();
                $('#imgloaddersubmit').show();


                $.ajax({
                    type: "POST",
                    contentType: false,
                    processData: false,

                    url: '../Info/MasterHandler.ashx?method=InsertUpdateExibition&Mobile_no=' + $('#mobile').val() + '&Name=' + $('#Name').val() + '&Email=' + $('#Email').val() + '&CompName=' + $('#Companyname').val() + '&Designation=' + $('#Designation').val() + '&Intrest=' + $("#radioDiv input[type='radio']:checked").val(),
                    success: function (data) {


                        $('#imgloaddersubmit').hide();
                        $('#btnsubmit').show();
                    }
                });
                

                var code = $('#codeone').val();
                var mobileno = $('#mobile').val();



                if ($('#mobile').val() == "") {
                    $('#lbl').text('Please Enter Mobile Number!');
                    $('#mobile').focus();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#lbl').text('');
                }

                if (mobileno.length < 10) {
                    $('#lbl').text('Please Enter 10 Digit Mobile Number!');
                    $('#mobile').focus();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#lbl').text('');
                }

                if ($('#Name').val().replace(/\s+/g, '').length == 0) {
                    $('#lbl').text('Please Enter Your Name*');
                    $('#Name').focus();
                    $('#Name').val('');
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#lbl').text('');
                }

                if ($('#Name').val() == "") {
                    $('#lbl').text('Please Enter Your Name!');
                    $('#Name').focus();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#lbl').text('');
                }

                var matches = $('#Name').val().match(/\d+/g);
                if (matches != null) {
                    $('#lbl').text('Name should be lphabet only!');
                    $('#Name').focus();
                    $('#btnsubmit').attr('disabled', false);
                    $('#Name').val('');
                    return false;
                }
                else {
                    $('#lbl').text('');
                }
                var matches1 = $('#Name').val().match(/[^a-zA-Z0-9 ]/);
                if (matches1 != null) {
                    $('#lbl').text('Name Should Not Contain any Special Character!');
                    $('#Name').focus();
                    $('#btnsubmit').attr('disabled', false);
                    $('#Name').val('');
                    return false;
                }
                else {
                    $('#lbl').text('');
                }







                if ($('#Email').val().replace(/\s+/g, '').length == 0) {
                    $('#lbl').text('Please Enter Your Email ID!');
                    $('#Email').focus();
                    $('#Email').val('');
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#lbl').text('');
                }


                var inputvalues = $('#Email').val();
                var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                if (!regex.test(inputvalues)) {
                    $('#lbl').text("Invalid email id");
                    $('#Email').focus();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#lbl').text('');
                }


                if ($('#Companyname').val().replace(/\s+/g, '').length == 0) {
                    $('#lbl').text('Please Enter Your Comapy Name!');
                    $('#Companyname').focus();
                    $('#Companyname').val('');
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#lbl').text('');
                }

                if ($('#Designation').val().replace(/\s+/g, '').length == 0) {
                    $('#lbl').text('Please Enter Your Designation!');
                    $('#Designation').focus();
                    $('#Designation').val('');
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#lbl').text('');
                }

                var matches1d = $('#Designation').val().match(/\d+/g);
                if (matches1d != null) {
                    $('#lbl').text('Designation should be lphabet only!');
                    $('#Designation').focus();
                    $('#btnsubmit').attr('disabled', false);
                    $('#Designation').val('');
                    return false;
                }
                else {
                    $('#lbl').text('');
                }

                var matchesd = $('#Designation').val().match(/[^a-zA-Z0-9 ]/);
                if (matchesd != null) {
                    $('#lbl').text('Designation Should Not Contain any Special Character!');
                    $('#Designation').focus();
                    $('#btnsubmit').attr('disabled', false);
                    $('#Designation').val('');
                    return false;
                }
                else {
                    $('#lbl').text('');
                }


                var selectedVal = "";
                var selected = $("#radioDiv input[type='radio']:checked");
                if (selected.length > 0) {
                    selectedVal = selected.val();
                    // alert(selectedVal);
                }
                else {
                    $('#lbl').text('Please Select One');
                    return false;
                }

                $('#btnsubmit').attr('disabled', false);
                $('#p3msg').html('');
                if (code != "") {

                    $('#btnsubmit').attr('disabled', true);
                    $('#btnsubmit').hide();
                    $('#imgloaddersubmit').show();
                    

                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: '../Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#codeone').val() + '&name=' + $('#Name').val() + '&EmailAddrs=' + $('#Email').val() + '&Comp_ID=' + $('#Companyname').val() + '&Other_Role=' + $('#Designation').val() + '&SellerName=' + $("#radioDiv input[type='radio']:checked").val() + '&comp=Cosmo Tech Expo',
                        success: function (data) {

                            
                            $('#imgloaddersubmit').hide();

                            if (data.split('~')[0] !== "failure") {
                                window.scrollTo(0, 0);
                                if (data.indexOf("not valid") !== -1) {
                                    data = data.split(".")[0];
                                }
                                $('#HEADING').hide();
                                $('#ChkCode').hide();
                                $('#Chkfields').hide();
                                $('#otpfield').hide();
                                $('#ShowMessage').show();
                                /*$('#congrats').show();*/
                                $('#p3msg').html(data.split('~')[1]);
                                $('#p3msg:contains("not")').css('color', 'white');
                            }
                            else {
                                $('#lblvalidateotp').text('Invalid Otp');
                                $('#btnsubmit').show();
                                $('#btnsubmit').attr('disabled', false);
                            }
                        }
                    });
                }
                else {
                    $('#btnsubmit').attr('disabled', false);
                }

            });
            $('#btnNext').click(function () {
                window.location.href = 'https://www.vcqru.com/';
            });
        });
    </script>

    <section class="banner-cosmetic mobile">
        <div class="container">
            <div class="row pt-4">
                <div class="col-lg-5 col-sm-12">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="logo">
                                <img src="../assets/images/Packplus/logo.png" />
                            </div>
                        </div>
                        <div class="col-sm-12">
                             <div id="carouselExampleSlidesOnly" class="carousel slide" data-ride="carousel">
                              <div class="carousel-inner">
                                <div class="carousel-item active">
                                 <p><h1 class="heading-maine text-white  py-4">Powering the Future of <span style="color: #18beb7;">E-Warranty</span></h1></p>
                                </div>
                                <div class="carousel-item">
                                <p> <h1 class="heading-maine text-white  py-4">Powering the Future of <span style="color: #18beb7;">Cash Transfer</span></h1></p>
                                </div>
                                <div class="carousel-item">
                                <p> <h1 class="heading-maine text-white  py-4">Powering the Future of <span style="color: #18beb7;">Build Loyalty</span></h1></p>
                                </div>

                                   <div class="carousel-item">
                                    <p> <h1 class="heading-maine text-white  py-4">Powering the Future of <span style="color: #18beb7;">Digital Marketing</span></h1></p>
                                </div>

                                   <div class="carousel-item">
                                <p> <h1 class="heading-maine text-white  py-4">Powering the Future of <span style="color: #18beb7;">Referral Services</span></h1></p>
                                </div>

                                   <div class="carousel-item">
                                 <p><h1 class="heading-maine text-white  py-4">Powering the Future of <span style="color: #18beb7;">Track & Trace</span></h1></p>
                                </div>


                                  <div class="carousel-item">
                                 <p><h1 class="heading-maine text-white  py-4">Powering the Future of <span style="color: #18beb7;">Gift Coupon</span></h1></p>
                                </div>


                                  <div class="carousel-item">
                                 <p><h1 class="heading-maine text-white  py-4">Powering the Future of <span style="color: #18beb7;">Smart Packaging</span></h1></p>
                                </div>
                              </div>
                            </div>
                        </div>

                       

                        <div class="col-lg-12">
                            <div class="maine-img">
                                <img class="img-fluid" src="../assets/images/Packplus/round-design.png" />

                            </div>
                        </div>


                    </div>

                </div>

                <div class="col-lg-7 col-sm-12">
                    <form runat="server">
                        <asp:HiddenField ID="hdnmob" runat="server" />
                        <asp:HiddenField ID="HdnID" runat="server" />
                        <asp:HiddenField ID="HdnCode1" runat="server" />
                        <asp:HiddenField ID="HdnCode2" runat="server" />
                        <asp:HiddenField ID="CompName" runat="server" />
                        <asp:HiddenField ID="long" runat="server" />
                        <asp:HiddenField ID="lat" runat="server" />

                        <div class="rows">
                            <div class="HEADING">
                                <h1 class="heading-pack-plus text-white text-center py-4">Explore Our Services And Win More
                                </h1>
                            </div>
                        </div>
                        <div id="ChkCode">
                            <div class="mb-3 common-icone">
                                <img src="../assets/images/Packplus/code.png" />
                                <input type="text" class="form-control common" id="codeone" maxlength="13" minlength="13" placeholder="Enter 13 Digit Code*" name="text" />
                            </div>
                            <div>
                                <center>
                                    <button type="button" id="btnnxt" class="btn btn-primary">Next</button>
                                    <img id="imgloadder" style="display:none;width: 66px;" src="assets/images/Packplus/YouTube_loading_symbol_3_(transparent).gif" />
                                </center>
                            </div>
                            <label id="lblmob" class="clbl"></label>
                        </div>
                         <div id="mobilefield" style="display: none">
                                <div class="mb-3 common-icone">
                                    <img src="../assets/images/Packplus/number.png" />
                                    <input type="text" class="form-control common" id="mobile" maxlength="10" placeholder="Enter Mobile Number*" name="phone" />
                                </div>
                             <label id="lblgetotp" class="clbl"></label>
                                <div>
                                <center >
                                    <button type="button" id="btnsendotp" class="btn btn-primary">Send Otp</button>
                                    <img id="imgloaddersendotp" style="display:none;width: 66px;" src="assets/images/Packplus/YouTube_loading_symbol_3_(transparent).gif" />
                                </center>
                            </div>
                            </div>

                        <div id="Chkfields">
                           
                            <div id="otherfield">
                                <div class="mb-3 common-icone">
                                    <img src="../assets/images/Packplus/name.png" />
                                    <input type="text" class="form-control common" id="Name" maxlength="50" onkeyup="Dopostback()" placeholder="Enter Your Name *" name="name" />
                                </div>

                                <div class="mb-3 common-icone">
                                    <img src="../assets/images/Packplus/envelope.png" />
                                    <input type="email" class="form-control common" id="Email" onkeyup="Dopostback()" maxlength="50" placeholder="Enter Your Email ID*" name="mail" />
                                </div>

                                <div class="mb-3 common-icone">
                                    <img src="../assets/images/Packplus/company-name.png" />
                                    <input type="text" class="form-control common" id="Companyname" onkeydown="Dopostback()" maxlength="150" placeholder="Enter Company Name*" name="company" />
                                </div>
                                <div class="mb-3 common-icone">
                                    <img src="../assets/images/Packplus/Designationiconblue.png" />
                                    <input type="text" class="form-control common" onkeyup="Dopostback()" maxlength="50" id="Designation" placeholder="Enter Your Designation*" name="Designation" />
                                </div>

                                <h6 class="text-white pt-2 qr-heading">Are you interested to book a demo of our services?</h6>
                                <div id="radioDiv">
                                    <div class="col-md-4 d-flex">
                                        <input type="radio" onclick="Dopostback()" class="vip" id="Yes" name="contact" value="Yes" />
                                        <label class="vip2" for="Yes">Yes</label>
                                    </div>

                                    <div class="col-md-4 d-flex">
                                        <input type="radio" onclick="Dopostback()" class="vip" id="No" name="contact" value="No" />
                                        <label class="vip2" for="No">No</label>
                                    </div>

                                    <div class="col-md-4 d-flex">
                                        <input type="radio" class="vip" onclick="Dopostback()" id="Maybe" name="contact" value="Maybe" />
                                        <label class="vip2" for="Maybe">Maybe</label>
                                    </div>
                                </div>

                            </div>
                            <label class="clbl" id="lbl"></label>
                            <button type="button" id="btnsubmit" class="btn btn-primary mt-3">SUBMIT</button>
                            <img id="imgloaddersubmit" style="display:none;width: 66px;" src="assets/images/Packplus/YouTube_loading_symbol_3_(transparent).gif" />
                        </div>

                        <div id="otpfield">
                            <div class="mb-3 common-icone">
                                <img src="../assets/images/Cosmo/code.png" />
                                <input type="text" class="form-control common" id="otp" maxlength="4" minlength="4" placeholder="OTP*" name="text" />
                            </div>
                            <label id="lblvalidateotp" class="clbl"></label>
                            <div>
                                <center>
                                    <button type="button" id="btnsubmitotp" class="btn btn-primary">SUBMIT</button>
                                    <img id="imgloaddersubmitotp" style="display:none;width: 66px;" src="assets/images/Packplus/YouTube_loading_symbol_3_(transparent).gif" />
                                </center>
                            </div>
                            <label id="lblotp" class="clbl"></label>
                        </div>

                        <div style="display: none;" id="ShowMessage">
                            <%--<img id="congrats" style="display:none" src="assets/images/Packplus/congrats-9-unscreen.gif" />--%>
                            <div class="form-box">
                                <p id="p3msg" style="overflow: hidden; color: white; font-size: 13px !important; font-weight: 500;" class="displayNone massage_box text-center"></p>
                                <br />
                                <center><a href="javascript:void(0)" class="btn btn-primary" id="btnNext">Close</a></center>
                            </div>
                        </div>
                        <h4 class="text-white pt-2 qr-heading">To know more about our services you may call our Business Development team on</h4>
                        <p class="text-white text-center number-style">

                            <a href="tel:+919355903102">+919355903102</a> ,<a href="tel:+919355903103">+919355903103</a> ,<a href="tel:+919355903104">+919355903104</a> ,<a href="tel:+919355903105">+919355903105</a> ,<a href="tel:+919355903107">+919355903107</a>

                            <%-- <img src="../assets/images/Packplus/telephone.png" style="width: 20px;" />
                            <a href="tel:8047278314">08047278314</a> /
                            <img src="../assets/images/Packplus/whatsapp.png" style="width: 20px;" />
                            <a href="https://api.whatsapp.com/send?phone=+919355903119&amp;text&amp;type=phone_number&amp;app_absent=1" target="blank">9355903119</a>--%>
                        </p>
                    </form>
                    <%--<img src="assets/images/Packplus/Internet-loader-unscreen.gif" id="ethernetloader" style="display:none" />--%>
                </div>

            </div>

             <div class="col-sm-12">

                            <div class="container text-center my-3">
                                <div class="row mx-auto my-auto">
                                    <div id="recipeCarousel" class="carousel slide w-100" data-ride="carousel">
                                        <div class="carousel-inner w-100" role="listbox">
                                            <div class="carousel-item active">
                                                <div class="col-md-2">
                                                    <a href="https://www.vcqru.com/packaging.aspx">
                                                        <div class="card-body">
                                                            <img class="img-fluid" src="../assets/images/Packplus/box.png" />
                                                            <h6 class="text-white mt-3">Smart<br />
                                                                Packaging
                                                            </h6>
                                                        </div>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="carousel-item">
                                                <div class="col-md-2">
                                                    <a href="https://www.vcqru.com/anti-counterfeit.aspx">
                                                        <div class="card-body">
                                                            <img class="img-fluid" src="../assets/images/Packplus/shield.png" />
                                                            <h6 class="text-white mt-3">Anti-<br />
                                                                Counterfiet
                                                            </h6>
                                                        </div>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="carousel-item">
                                                <div class="col-md-2">
                                                    <a href="https://www.vcqru.com/e-warranty.aspx">
                                                        <div class="card-body">
                                                            <img class="img-fluid" src="../assets/images/Packplus/warranty.png" />
                                                            <h6 class="text-white mt-3">E-<br />
                                                                Warranty
                                                            </h6>
                                                        </div>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="carousel-item">
                                                <div class="col-md-2">
                                                    <a href="https://www.vcqru.com/cash-transfer.aspx">
                                                        <div class="card-body">
                                                            <img class="img-fluid" src="../assets/images/Packplus/cash.png" />
                                                            <h6 class="text-white mt-3">Cash<br />

                                                                Transfer
                                                            </h6>
                                                        </div>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="carousel-item">
                                                <div class="col-md-2">
                                                    <a href="https://www.vcqru.com/build-loyalty.aspx">
                                                        <div class="card-body">
                                                            <img class="img-fluid" src="../assets/images/Packplus/loyalti.png" />
                                                            <h6 class="text-white mt-3">Build<br />

                                                                Loyalty
                                                            </h6>
                                                        </div>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="carousel-item">
                                                <div class="col-md-2">
                                                    <a href="https://www.vcqru.com/digital-marketing.aspx">
                                                        <div class="card-body">
                                                            <img class="img-fluid" src="../assets/images/Packplus/digital.png" />
                                                            <h6 class="text-white mt-3">Digital<br />


                                                                Marketing
                                                            </h6>
                                                        </div>
                                                    </a>
                                                </div>
                                            </div>

                                            <div class="carousel-item">
                                                <div class="col-md-2">
                                                    <a href="https://www.vcqru.com/referral-services.aspx">
                                                        <div class="card-body">
                                                            <img class="img-fluid" src="../assets/images/Packplus/referl.png" />
                                                            <h6 class="text-white mt-3">Referral<br />

                                                                Services

                                                            </h6>
                                                        </div>
                                                    </a>
                                                </div>
                                            </div>

                                            <div class="carousel-item">
                                                <div class="col-md-2">
                                                    <a href="https://www.vcqru.com/track-trace.aspx">
                                                        <div class="card-body">
                                                            <img class="img-fluid" src="../assets/images/Packplus/tracking.png" />
                                                            <h6 class="text-white mt-3">Track &<br />
                                                                Trace


                                                            </h6>
                                                        </div>
                                                    </a>
                                                </div>
                                            </div>

                                            <div class="carousel-item">
                                                <div class="col-md-2">
                                                    <a href="https://www.vcqru.com/gift-coupon.aspx">
                                                        <div class="card-body">
                                                            <img class="img-fluid" src="../assets/images/Packplus/gift.png" />
                                                            <h6 class="text-white mt-3">Gift<br />

                                                                Coupon

                                                            </h6>
                                                        </div>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <a class="carousel-control-prev w-auto" href="#recipeCarousel" role="button" data-slide="prev">
                                            <i class="fa fa-arrow-circle-left" style="font-size: 24px; color: #18beb7;"></i>
                                            <span class="sr-only">Previous</span>
                                        </a>
                                        <a class="carousel-control-next w-auto" href="#recipeCarousel" role="button" data-slide="next">
                                            <i class="fa fa-arrow-circle-right" style="font-size: 24px; color: #18beb7;"></i>
                                            <span class="sr-only">Next</span>
                                        </a>
                                    </div>
                                </div>
                            </div>


                        </div>

        </div>





        <footer class="mobile-space">

            <div class="container" />

            <div class="row">

                <div class="col-sm-9 col-12">
                    <div class="social-icone">
                        <label class="text-white">Follow us on :</label>
                        <a href="https://www.instagram.com/vcqru_wesecureyou/?hl=en" target="_blank">
                            <img class="" src="../assets/images/Packplus/instagram.png" /></a>
                        <a href="https://www.facebook.com/vcqru/" target="_blank">
                            <img class="" src="../assets/images/Packplus/facebook.png" /></a>
                        <a href="https://www.linkedin.com/company/vcqru-wesecureyou" target="_blank">
                            <img class="" src="../assets/images/Packplus/linkedin.png" /></a>
                        <a href="https://www.youtube.com/channel/UCmQmBBnF3pHfM2czRYZhYAQ" target="_blank">
                            <img class="" src="../assets/images/Packplus/youtube.png" /></a>

                    </div>

                </div>

                <div class="col-sm-3 col-12 mobile">
                    <a href="https://www.vcqru.com/" class="text-white mobie">www.vcqru.com</a>
                </div>



            </div>


        </footer>
    </section>


   

  

     <script type="text/javascript">

         //$('#recipeCarousel').carousel({
         //    interval: 10000
         //});

         $('.carousel .carousel-item').each(function () {
             var minPerSlide = 6;
             var next = $(this).next();
             if (!next.length) {
                 next = $(this).siblings(':first');
             }
             next.children(':first-child').clone().appendTo($(this));

             for (var i = 0; i < minPerSlide; i++) {
                 next = next.next();
                 if (!next.length) {
                     next = $(this).siblings(':first');
                 }

                 next.children(':first-child').clone().appendTo($(this));
             }
         });

     </script>

</body>
</html>
