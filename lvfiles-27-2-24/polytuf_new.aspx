<%@ Page Language="C#" AutoEventWireup="true" CodeFile="polytuf_new.aspx.cs" Inherits="polytuf_new" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.0/animate.min.css" />

    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>



    <script>


        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }



        $(document).ready(function () {
            $('.customer-logos').slick({
                slidesToShow: 6,
                slidesToScroll: 1,
                autoplay: true,
                autoplaySpeed: 1500,
                arrows: false,
                dots: false,
                pauseOnHover: false,
                responsive: [{
                    breakpoint: 768,
                    settings: {
                        slidesToShow: 4
                    }
                }, {
                    breakpoint: 520,
                    settings: {
                        slidesToShow: 3
                    }
                }]
            });

            firstfunction();

            var id = $('#HdnID').val();


            if (id == "1") {

                $('#div1').show();
                $('#div2').hide();
                $('#div3').hide();
            }

            else if (id == "polytuf") {
                $('#div1').hide();
                $('#div2').show();
                $('#div3').show();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $("#codeone").val(code);


            }



            $("#codeone").mask("99999-99999999");

            $(".input1").keyup(function () {

                if (this.value.length == this.maxLength) {
                    $('#div1').hide();

                    var rquestpage_Dcrypt = $("#codeone").val();

                    $.ajax({
                        type: "POST",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                        success: function (data) {


                            $.ajax({
                                type: "POST",
                                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1] + '&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                                success: function (data) {
                                    debugger;

                                    if (data.split('&')[0] === "1" && data.split('&')[1] === "Auto Max India") {

                                    }

                                    else {

                                        $('#CompName').val(data.split('&')[1]);
                                        $('#div2').show();
                                        $('#div3').show();

                                    }
                                }
                            });

                            //    }
                            //});
                        }
                    });
                }
            });

            $('#btnsubmit').on('click', function () {
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
                                $('#btnsubmit').attr('disabled', false);
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
                    var matches1 = $('#Name').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        toastr.error('Name Should Not Contain any Special Character!');
                        validate = false;
                    }
                }


                var Address = $('#Address').val();
                if (Address != undefined) {


                    if ($('#Address').val().length < 1) {
                        toastr.error('Please Enter Address');
                        validate = false;
                    }
                }



                if (validate) {
                    $('#p3msg').html('');


                    if (code != "") {
                        $.ajax({
                            type: "POST",
                            async: true,
                            contentType: false,
                            processData: false,

                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&Address=' + $('#Address').val() + '&name=' + $('#Name').val() + '&comp=' + $('#CompName').val(),
                            success: function (data) {
                                debugger;
                                if (data.split('~')[0] !== "failure") {
                                    window.scrollTo(0, 0);
                                    $('#head').hide();
                                    $('#div2').hide();
                                    $('#div3').hide();
                                    $('#mainform').hide();
                                    $('#ShowMessage').show();
                                    $('#chkLine').hide();
                                    $('#p3msg').html(data.split('~')[1]);
                                    $('.product_img').attr("style", "margin-top : 0px !important");

                                    var input = document.getElementById("ShowMessage").focus();

                                    //$('#p3msg:contains("not")').css('color', 'white');





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

                    $('#btnsubmit').attr('disabled', false);

                }

            });


            $('#btnNext').click(function () {
                window.location.href = 'https://www.polytuf.in/';
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

    </script>




    <script>

        var alertRedInput = "#8C1010";
        var defaultInput = "rgba(10, 180, 180, 1)";

        function userNameValidation(usernameInput) {
            var username = document.getElementById("username");
            var issueArr = [];
            if (/[-!@#$%^&*()_+|~=`{}\[\]:";'<>?,.\/]/.test(usernameInput)) {
                issueArr.push("No special characters!");
            }
            if (issueArr.length > 0) {
                username.setCustomValidity(issueArr);
                username.style.borderColor = alertRedInput;
            } else {
                username.setCustomValidity("");
                username.style.borderColor = defaultInput;
            }
        }

        function passwordValidation(passwordInput) {
            var password = document.getElementById("password");
            var issueArr = [];
            if (!/^.{7,15}$/.test(passwordInput)) {
                issueArr.push("Password must be between 7-15 characters.");
            }
            if (!/\d/.test(passwordInput)) {
                issueArr.push("Must contain at least one number.");
            }
            if (!/[a-z]/.test(passwordInput)) {
                issueArr.push("Must contain a lowercase letter.");
            }
            if (!/[A-Z]/.test(passwordInput)) {
                issueArr.push("Must contain an uppercase letter.");
            }
            if (issueArr.length > 0) {
                password.setCustomValidity(issueArr.join("\n"));
                password.style.borderColor = alertRedInput;
            } else {
                password.setCustomValidity("");
                password.style.borderColor = defaultInput;
            }
        }




    </script>





    <style>
        * {
            margin: 0px;
            padding: 0px;
        }

        body {
            font-family: "Open Sans", sans-serif;
            color: #444444;
            overflow: auto !important;
        }

        a {
            color: #bd953f;
            text-decoration: none;
        }

            a:hover {
                color: #dfb458;
                text-decoration: none;
            }

        h1, h2, h3, h4, h5, h6 {
            font-family: "Raleway", sans-serif;
        }



        @import url(https://fonts.googleapis.com/css?family=Open+Sans:400,700,300);
        @import url(https://fonts.googleapis.com/css?family=Raleway:400,900,800,700,600,500,200,300);

        html, body {
            height: 100%;
            font-family: 'Lato', sans-serif;
            overflow: hidden;
        }

        .nav {
            display: none;
            height: 30px;
            width: 100%;
            background-color: #34495e;
            position: relative;
            z-index: 3;
            -webkit-transition: all 0.5s ease;
            -moz-transition: all 0.5s ease;
            -o-transition: all 0.5s ease;
            -ms-transition: all 0.5s ease;
            transition: all 0.5s ease;
        }

        h1 {
            font-family: 'Raleway', sans-serif;
            font-size: 15vmin;
            line-height: 15vmin;
            font-weight: 300;
            text-align: center;
            color: #2c3e50;
            margin: 0 auto;
            width: 100%;
        }

            h1 b {
                font-weight: 700;
            }

        .main {
            padding: 10px;
            width: 100%;
            height: 100%;
            background-color: #ddd;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 0;
            box-sizing: border-box;
        }

        .top, .bottom {
            z-index: 1;
            width: 100%;
            height: 50%;
            -webkit-transition: all 0.5s ease;
            -moz-transition: all 0.5s ease;
            -o-transition: all 0.5s ease;
            -ms-transition: all 0.5s ease;
            transition: all 0.5s ease;
        }

        .top {
            background-color: #34495e;
            position: absolute;
            top: 0;
        }

        .bottom {
            background-color: #bdc3c7;
            position: absolute;
            bottom: 0;
        }

        .top h1 {
            position: absolute;
            bottom: 40%;
            color: #bdc3c7;
        }

        .bottom h1 {
            position: absolute;
            top: 40%;
            color: #34495e;
        }

        .lock {
            z-index: 2;
            width: 0;
            height: 0;
            border: 50px solid transparent;
            border-bottom-color: #2c3e50;
            position: absolute;
            margin: auto;
            position: absolute;
            top: -100px;
            left: 0;
            bottom: 0;
            right: 0;
            cursor: pointer;
        }

            .lock:after {
                content: '';
                position: absolute;
                left: -50px;
                top: 50px;
                width: 0;
                height: 0;
                border: 50px solid transparent;
                border-top-color: #2c3e50;
            }

        .lockBack {
            z-index: 2;
            width: 0;
            height: 0;
            border: 60px solid transparent;
            border-bottom-color: #2c3e50;
            opacity: 0.4;
            position: absolute;
            margin: auto;
            position: absolute;
            top: -120px;
            left: 0;
            bottom: 0;
            right: 0;
        }

            .lockBack:after {
                content: '';
                position: absolute;
                left: -60px;
                top: 60px;
                width: 0;
                height: 0;
                border: 60px solid transparent;
                border-top-color: #2c3e50;
            }

        .front {
            /* height:10px; */
        }

        #header {
            background-image: url("/assets/images/polytuf/1.jpg");
            width: 100%;
            background-size: cover;
            background-repeat: no-repeat;
            /*background-color: #17a2b8;*/
            height: 110vh;
        }



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


        #nav-bar IMG {
            margin-top: 5%;
        }


        /*contact form*/

        @import 'https://fonts.googleapis.com/css?family=Open+Sans|Quicksand:400,700';

        /*--------------------
General Style
---------------------*/
        *,
        *::before,
        *::after {
            box-sizing: border-box;
        }

        body,
        html {
            height: 100%;
            font-family: 'Quicksand', sans-serif;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        body {
            background: rgba(30,29,31,1);
            background: -moz-linear-gradient(-45deg, rgba(30,29,31,1) 0%, rgba(223,64,90,1) 100%);
            background: -webkit-gradient(left top, right bottom, color-stop(0%, rgba(30,29,31,1)), color-stop(100%, rgba(223,64,90,1)));
            background: -webkit-linear-gradient(-45deg, rgba(30,29,31,1) 0%, rgba(223,64,90,1) 100%);
            background: -o-linear-gradient(-45deg, rgba(30,29,31,1) 0%, rgba(223,64,90,1) 100%);
            background: -ms-linear-gradient(-45deg, rgba(30,29,31,1) 0%, rgba(223,64,90,1) 100%);
            background: linear-gradient(135deg, rgba(30,29,31,1) 0%, rgba(223,64,90,1) 100%);
            filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#1e1d1f', endColorstr='#df405a', GradientType=1 );
        }

        /*--------------------
Text
---------------------*/

        h2, h3 {
            font-size: 16px;
            letter-spacing: -1px;
            line-height: 20px;
        }

        h2 {
            color: #747474;
            text-align: center;
        }

        h3 {
            color: #032942;
            text-align: right;
        }

        /*--------------------
Icons
---------------------*/

        .box {
            width: 330px;
            position: absolute;
            top: 50%;
            left: 50%;
            margin-top: -3%;
            -webkit-transform: translate(-50%, -50%);
            transform: translate(-50%, -50%);
        }

        .product_img img {
            text-align: center;
        }

        .box-form {
            width: 320px;
            position: relative;
            z-index: 1;
        }

        .box-login-tab {
            width: 50%;
            height: 40px;
            background: #fdfdfd;
            position: relative;
            float: left;
            z-index: 1;
            -webkit-border-radius: 6px 6px 0 0;
            -moz-border-radius: 6px 6px 0 0;
            border-radius: 6px 6px 0 0;
            -webkit-transform: perspective(5px) rotateX(0.93deg) translateZ(-1px);
            transform: perspective(5px) rotateX(0.93deg) translateZ(-1px);
            -webkit-transform-origin: 0 0;
            transform-origin: 0 0;
            -webkit-backface-visibility: hidden;
            backface-visibility: hidden;
            -webkit-box-shadow: 15px -15px 30px rgba(0,0,0,0.32);
            -moz-box-shadow: 15px -15px 30px rgba(0,0,0,0.32);
            box-shadow: 15px -15px 30px rgba(0,0,0,0.32);
        }

        .box-login-title {
            width: 35%;
            height: 40px;
            position: absolute;
            float: left;
            z-index: 2;
        }

        .box-login {
            position: relative;
            top: -4px;
            width: 320px;
            background: #fdfdfd;
            text-align: center;
            overflow: hidden;
            z-index: 2;
            -webkit-border-top-right-radius: 6px;
            -webkit-border-bottom-left-radius: 6px;
            -webkit-border-bottom-right-radius: 6px;
            -moz-border-radius-topright: 6px;
            -moz-border-radius-bottomleft: 6px;
            -moz-border-radius-bottomright: 6px;
            border-top-right-radius: 6px;
            border-bottom-left-radius: 6px;
            border-bottom-right-radius: 6px;
            -webkit-box-shadow: 15px 30px 30px rgba(0,0,0,0.32);
            -moz-box-shadow: 15px 30px 30px rgba(0,0,0,0.32);
            box-shadow: 15px 30px 30px rgba(0,0,0,0.32);
        }

        .box-info {
            width: 260px;
            top: 60px;
            position: absolute;
            right: -5px;
            padding: 15px 15px 15px 30px;
            background-color: rgba(255,255,255,0.6);
            border: 1px solid rgba(255,255,255,0.2);
            z-index: 0;
            -webkit-border-radius: 6px;
            -moz-border-radius: 6px;
            border-radius: 6px;
            -webkit-box-shadow: 15px 30px 30px rgba(0,0,0,0.32);
            -moz-box-shadow: 15px 30px 30px rgba(0,0,0,0.32);
            box-shadow: 15px 30px 30px rgba(0,0,0,0.32);
        }

        .line-wh {
            width: 100%;
            height: 1px;
            top: 0px;
            margin: 12px auto;
            position: relative;
            border-top: 1px solid rgba(255,255,255,0.3);
        }




        /*--------------------
Form
---------------------*/

        a {
            text-decoration: none;
        }

        button:focus {
            outline: 0;
        }

        .b {
            height: 24px;
            line-height: 24px;
            background-color: transparent;
            border: none;
            cursor: pointer;
        }

        .b-form {
            opacity: 0.5;
            margin: 10px 20px;
            float: right;
        }

        .b-info {
            opacity: 0.5;
            float: left;
        }

            .b-form:hover,
            .b-info:hover {
                opacity: 1;
            }

        .b-support, .b-cta {
            width: 100%;
            padding: 0px 15px;
            font-family: 'Quicksand', sans-serif;
            font-weight: 700;
            letter-spacing: -1px;
            font-size: 16px;
            line-height: 32px;
            cursor: pointer;
            -webkit-border-radius: 16px;
            -moz-border-radius: 16px;
            border-radius: 16px;
        }

        .b-support {
            border: #87314e 1px solid;
            background-color: transparent;
            color: #87314e;
            margin: 6px 0;
        }

        .b-cta {
            border: #df405a 1px solid;
            background-color: #df405a;
            color: #fff;
        }

            .b-support:hover, .b-cta:hover {
                color: #fff;
                background-color: #87314e;
                border: #87314e 1px solid;
            }

        .fieldset-body {
            display: table;
        }


        .next_btn {
            background: coral;
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


        .fieldset-body img {
            margin-right: 20px;
            padding-top: 13px;
            float: right;
        }


        .fieldset-body p {
            width: 100%;
            display: inline-table;
            padding: 5px 20px;
            margin-bottom: 2px;
        }

        label {
            float: left;
            width: 100%;
            top: 0px;
            color: #032942;
            font-size: 13px;
            font-weight: 700;
            text-align: left;
            line-height: 1.5;
        }

            label.checkbox {
                float: left;
                padding: 5px 20px;
                line-height: 1.7;
            }

        input[type=text],
        input[type=password] {
            width: 100%;
            height: 32px;
            padding: 0px 10px;
            background-color: rgba(0,0,0,0.03);
            border: none;
            display: inline;
            color: #303030;
            font-size: 16px;
            font-weight: 400;
            float: left;
            -webkit-box-shadow: inset 1px 1px 0px rgba(0,0,0,0.05), 1px 1px 0px rgba(255,255,255,1);
            -moz-box-shadow: inset 1px 1px 0px rgba(0,0,0,0.05), 1px 1px 0px rgba(255,255,255,1);
            box-shadow: inset 1px 1px 0px rgba(0,0,0,0.05), 1px 1px 0px rgba(255,255,255,1);
        }

            input[type=text]:focus,
            input[type=password]:focus {
                background-color: #dfdef7;
                outline: none;
            }

        input[type=submit] {
            width: 100%;
            height: 48px;
            margin-top: 24px;
            padding: 0px 20px;
            font-family: 'Quicksand', sans-serif;
            font-weight: 700;
            font-size: 18px;
            color: #fff;
            line-height: 40px;
            text-align: center;
            background-color: #87314e;
            border: 1px #87314e solid;
            opacity: 1;
            cursor: pointer;
        }

            input[type=submit]:hover {
                background-color: #df405a;
                border: 1px #df405a solid;
            }

            input[type=submit]:focus {
                outline: none;
            }

        p.field span.i {
            width: 24px;
            height: 24px;
            float: right;
            position: relative;
            margin-top: -26px;
            right: 2px;
            z-index: 2;
            display: none;
            -webkit-animation: bounceIn 0.6s linear;
            -moz-animation: bounceIn 0.6s linear;
            -o-animation: bounceIn 0.6s linear;
            animation: bounceIn 0.6s linear;
        }

        /*--------------------
Transitions
---------------------*/

        .box-form, .box-info, .b, .b-support, .b-cta,
        input[type=submit], p.field span.i {
            -webkit-transition: all 0.3s;
            -moz-transition: all 0.3s;
            -ms-transition: all 0.3s;
            -o-transition: all 0.3s;
            transition: all 0.3s;
        }

        /*--------------------
Credits
---------------------*/

        .icon-credits {
            width: 100%;
            position: absolute;
            bottom: 4px;
            font-family: 'Open Sans', 'Helvetica Neue', Helvetica, sans-serif;
            font-size: 12px;
            color: rgba(255,255,255,0.1);
            text-align: center;
            z-index: -1;
        }

            .icon-credits a {
                text-decoration: none;
                color: rgba(255,255,255,0.2);
            }


        /* End contact form*/


        .weblink {
            color: white;
            cursor: pointer;
        }

        /*product slider*/
        /*End product slider*/
        #body-section img {
            margin-top: 3%;
        }

        /*--------------------
media
---------------------*/


        @media only screen and (max-width: 760px) {
            .box {
                top: 230px !important;
            }

            .index_page {
                z-index: 333;
            }

            .product_img {
                margin-top: 480px;
                text-align: center;
            }

            marquee {
                color: #fff;
                padding-top: 25px;
                padding-bottom: 40px;

            }

             marquee img {
                
                 width:20% !important;
            }
            

            #header {
                height: auto;
            }
        }

        @media only screen and (min-device-width: 769px) and (max-device-width: 1326px) {
            /*.box {
                top: 300px;
            }*/

            /*.product_img {
                margin-top: 70px;
            }*/
        }

        @media only screen and (max-width: 667px) {
            .box {
                top: 230px !important;
            }

            .product_img {
                margin-top: 480px;
                text-align: center;
            }

            

            marquee h6 {
                color: #000;
                padding-top: 25px;
                padding-bottom: 40px;
            }

            #header {
                height: auto;
            }

            .footer h5 {
                text-align: center;
                margin-right: 20%;
                color: #fff;
            }
        }

        .footer {
            float: right;
            padding-top: 5%;
        }
    </style>

</head>

<body>
    <form id="form1" runat="server">


        <asp:HiddenField ID="hdnmob" runat="server" />
        <asp:HiddenField ID="HdnID" runat="server" />
        <asp:HiddenField ID="HdnCode1" runat="server" />
        <asp:HiddenField ID="HdnCode2" runat="server" />
        <asp:HiddenField ID="CompName" runat="server" />
        <asp:HiddenField ID="long" runat="server" />
        <asp:HiddenField ID="lat" runat="server" />

        <section id="header">


            <section id="nav-bar">

                <nav class="navbar navbar-expand-lg navbar-dark">
                    <a class="navbar-brand" href="#">
                        <img src="/assets/images/polytuf/Polytuf final logo (3) (1).png" style="width: 15%;" class="embed-responsive" /></a>

                </nav>
            </section>

            <marquee style="margin-top:-3%;">
                        <span runat="server" style="color:red; font-size:160%;" id="txtmar"></span> <img src="/assets/images/polytuf/scroll.png" id="scollimg" style="width:10%"alt="product_img" class="img-fluid"/></marquee>



            <section id="body-section">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 index_page">


                            <div class='box' id="mainform">
                                <div class='box-form'>
                                    <div class='box-login-tab'></div>

                                    <div class='box-login'>
                                        <div class='fieldset-body' id='login_form'>
                                            <img src="/assets/images/polytuf/5.png" style="width: 10%;" class="embed-responsive" />

                                            <div id="div1" style="display: none;">
                                                <p class='field'>
                                                    <label for='user'>ENTER 13 DIGIT CODE</label>
                                                    <input style="margin-bottom: 5%;" type="text" id="codeone" data-msg-required="ENTER 13 DIGIT CODE" maxlength="13" class="form-control input1" />

                                                </p>
                                            </div>
                                            <div id="div2">
                                                <p class='field'>
                                                    <div class="form-check form-check-inline">
                                                        <input class="form-check-input" type="radio" checked name="inlineRadioOptions" id="inlineRadio1" value="option1" />
                                                        <label class="form-check-label" for="inlineRadio1">Plumber</label>
                                                    </div>
                                                    <div class="form-check form-check-inline">
                                                        <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2" />
                                                        <label class="form-check-label" for="inlineRadio2">Consumer</label>
                                                    </div>

                                                </p>

                                                <p class='field'>
                                                    <label for='pass'>NAME</label>
                                                    <input type="text" id="Name" placeholder="Name" data-msg-required="Please Enter Your Full Name" maxlength="50" class="input-line full-width" />

                                                </p>

                                                <p class='field'>
                                                    <label for='pass'>NUMBER</label>
                                                    <input type="text" id="mobilenumber" maxlength="10" placeholder="Mobile Number" data-msg-required="Please Enter Your Moblie Number" class="input-line full-width" />
                                                </p>


                                                <p class='field'>
                                                    <label for='pass'>ADDRESS</label>
                                                    <input type="text" id="Address" placeholder="Address" data-msg-required="Please Enter Your Address." class="input-line full-width" />
                                                </p>





                                                <%--<input type='submit' id='do_login' data-toggle="modal" data-target="#exampleModalCenter" value='Submit' title='Get Started' />--%>
                                                <button type="button" id="btnsubmit" data-toggle="modal" class="btn toast-success" style="background-color: orange !important; color: white;">Submit</button>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div style="display: none; padding: 0px !important; margin-top: 15%;" id="ShowMessage" class="row no-gutters pl-4 pr-4 textmessage">

                                <div class="col-md-12">
                                    <div class="form-group">
                                        <p id="p3msg" style="color: green !important; overflow: hidden; font-size: 14px !important;" class="displayNone massage_box"></p>
                                    </div>
                                    <a href="javascript:void(0)" class="next_btn" id="btnNext">Close</a>
                                </div>


                            </div>

                        </div>
                        <div class="col-sm-6">

                            <div class="product_img">
                                <img src="/assets/images/polytuf/product_img.png" alt="product_img" class="img-fluid" />
                            </div>

                        </div>





                    </div>

                </div>
            </section>


        </section>
        <div class="row">
            <div class="col-12" style="text-align: right;">
                <a class="navbar-brand" href="https://www.polytuf.in/">
                    <h5 class="weblink">www.polytuf.in</h5>
                </a>
            </div>
        </div>
    </form>






    </div>

    <%--<div class="container-fluid">
        <div class="row">
            <div class="col-md-6"></div>
            <div class="col-md-6">
                <div class="footer">
                </div>
            </div>
        </div>
    </div>--%>
</body>
</html>
