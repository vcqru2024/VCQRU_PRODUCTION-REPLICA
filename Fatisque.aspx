<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Fatisque.aspx.cs" Inherits="Fatisque_" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fatisque</title>
    <!-- Bootstrap css -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <!-- css -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
        rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/0.9.0/jquery.mask.min.js"></script>
    <!-- Boxicons CSS -->

    <!-- font-awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body {
            background: url('assets/images/Fatisque/background.png');
            background-repeat: no-repeat;
            background-size: cover;
            min-height: 100vh;
            background-position: center;
            position: relative;
        }

        .footer {
            height: 2rem;
            width: 100%;
            background-color: #000000;
            color: white;
            position: fixed;
            bottom: 0;
        }

            .footer a {
                color: white;
                font-weight: 500;
                text-decoration: none;
            }

        .banner {
            width: 100%;
        }


       /* .formplace h5 {
            color: #fff;
        }*/

        .formplace h5 {
            color: #fff;
            text-align-last: center;
        }






        /* .formplace .card .card-body{
                    padding: 2rem;
                    font-weight: bold;
                    font-size: 12px;
                    color: black;
                } */
        .formplace .card .card-body button {
            background-color: #00E784;
            color: white;
            width: 100%;
            border-radius: 0px;
        }

        .formplace .card .card-body {
            padding: 2rem 1rem !important;
        }

        .formplace

        .formplace .card .card-body h4 {
            color: #000000;
            font-weight: bold;
            font-size: 1.7rem;
        }

        .formplace .card .card-body .form-label {
            font-size: 14px;
            font-weight: 500;
            color: white;
            border: 1px;
        }

        .formplace .card .card-body .form-control {
            border: 0;
            background-color: #EDF5F4;
            border-radius: 0px;
            color: #000;
            font-weight: 500;
            border: 1px solid rgba(0, 0, 0, 0.578);
        }

        .formplace .card {
            border-radius: 0px;
            box-shadow: 4px 4px 8px rgba(0, 0, 0, 0.8);
            background-color: #000000c5;
        }



        /* .landing {
                padding-top: 2rem;
            } */

        .product-img .card {
            background-color: rgba(255, 255, 255, 0.226);
            border-radius: 0px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.526);
        }


        @media screen and (max-width: 999px) {
            .formplace .card {
                margin: 0;
            }

            /* .formplace {
            margin-top: 0;
        } */


            .product img {
                height: 4rem;
                margin: 2rem 0;
            }
        }

        hr {
            border: none;
            height: 1px;
            /* Set the hr color */
            color: #ffffff;
            /* old IE */
            background-color: #ffffff;
            /* Modern Browsers */
        }

        .product-img img {
            margin-top: 70px !important;
        }

        .product img {
            margin-bottom: 2rem;
        }
    </style>
    <script type="text/javascript">
        // it is the variable initialized for the location purpose.

        var baseurl = "../";
        var Codeone = "";
        var Codetwo = "";
        var comp = "";
        var Id = "";

        var lat = "";
        var long = "";
        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }
        $('#otherfield').hide();


        // Read a page's GET URL variables and return them as an associative array.
        function getUrlVars() {
            var vars = [], hash;

            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        }

        // form this function we may easily collect the data to the our database by using the post api


        function Getdata() {
            debugger;
            var mobileno = document.querySelector("#mobile").value;
            var d = mobileno.slice(0, 1);
            var c = parseInt(d);

            if (mobileno.match(/[^$,.\d]/)) {
                $('#mobilecheck').html('Please enter numeric value for mobile No.');
                $('#mobile').val() == "";
                $('#btnsubmit').attr('disabled', false);
                return false;
            }

            else {

                if (mobileno.length == 10) {
                    var codeone = getUrlVars()["codeone"];
                    var codetwo = getUrlVars()["codetwo"];

                    if (codeone == undefined && codetwo == undefined) {
                        var completeCode = $("#example13-digit-number").val();
                        var arr = completeCode.split('-');
                        codeone = arr[0];
                        codetwo = arr[1];
                    }


                    $.ajax({
                        type: "Post",
                        url: baseurl + 'Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNo&MobileNo=' + $("#mobile").val(),
                        success: function (data) {
                            // alert(data);
                            debugger;
                            if (c <= 5) {
                                $('#mobilecheck').html('Please Enter Valid Mobile No');
                                $('#mobile').val('');
                                return false;
                            }
                            else {

                                var count = data.split('~');
                                var Name = data.split('~')[0];
                                var pin = data.split('~')[6];
                                var city = data.split('~')[2];
                                var state = data.split('~')[3];
                                var email = data.split('~')[7];
                                var UPI = data.split('~')[10];
                                var pancard_number = data.split('~')[16];

                                if (Name != "") {
                                    $("#name").val(Name);
                                }
                                /*Auto Cash Transfer Start */
                                else {
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#mobilefield').hide();


                                }
                                if (pin != "") {
                                    $("#Pincode").val(pin);
                                    $("#Pincode").attr("readonly", true);
                                }
                                else {
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#mobilefield').hide();
                                    $("#Pincode").attr("readonly", false);
                                    $("#city").attr('readonly', false);
                                    $("#State").attr('readonly', false);

                                }


                                if (city != "") {
                                    $("#city").val(city);
                                    $("#city").attr("readonly", true);
                                }
                                else {
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#mobilefield').hide();
                                    $("#city").attr("readonly", false);


                                }
                                if (state != "") {
                                    $("#State").val(state);
                                    $("#State").attr("readonly", true);
                                }
                                else {
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#mobilefield').hide();
                                    $("#State").attr("readonly", false);


                                }
                                if (email != "") {
                                    $("#email").val(email);
                                    $("#email").attr("readonly", true);
                                }
                                else {
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#mobilefield').hide();
                                    $("#email").attr("readonly", false);


                                }
                            }
                        }
                    });
                }
            }


        }

        function getaddress() {
            debugger;
            let pin = document.getElementById("Pincode").value;
            if (pin.length == 6) {
                $.getJSON("https://api.postalpincode.in/pincode/" + pin, function (data) {
                    createHTML(data);
                })
                function createHTML(data) {
                    if (data[0].Status == "Success") {
                        var city = "";
                        var State = "";
                        var pin = "";
                        debugger;

                        var city = data[0].PostOffice[0]['District'];
                        var State = data[0].PostOffice[0]['State'];
                        var Pin = data[0].PostOffice[0]['PinCode'];
                        $("#city").val(city);
                        $("#city").attr("readonly", true);
                        $("#State").val(State);
                        $("#State").attr("readonly", true);

                        if (pin == "") {
                            $("#Pincode").val();
                            $('#pincheck').html("");

                        }
                        else {
                            $("#Pincode").val(Pin);

                        }
                        $('#btnsubmit').attr('disabled', false);
                    }

                }
            }
            else {
                $('#city').val('');
                $("#State").val('');
            }

        }
        // for the 13 digit code check
        $(document).ready(function () {

            $('#Chkcode').show();
            $('#Chkfields').hide();
            $('#mobilefield').hide();
            $('#Otherfield').hide();


            var code_err = true;
            var mobile_err = true;
            var name_err = true;
            var pin_err = true;
            var city_err = true;
            var village_err = true;



            function getUrlVars() {
                debugger;
                var vars = [], hash;
                var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                for (var i = 0; i < hashes.length; i++) {
                    hash = hashes[i].split('=');
                    vars.push(hash[0]);
                    vars[hash[0]] = hash[1];
                }
                return vars;
            };
            Codeone = getUrlVars()["codeone"];
            Codetwo = getUrlVars()["codetwo"];
            comp = getUrlVars()["Comp"];
            Id = getUrlVars()["ID"];

            if (comp === undefined || comp === "undefined") {
                comp = comp;
            }
            else {
                comp = comp.replace("%20", " ");
                comp = comp.replace("%20", " ");
                comp = comp.replace("%20", " ");
                comp = comp.replace("%20", " ");
            }
            if (Codeone === undefined || Codeone === undefined) {
                Codeone = Codeone;
            }
            else {
                var HdnCode1 = Codeone;
                var HdnCode2 = Codetwo;
                // $("#codeone").val(code);
            }

            var id = comp;

            if (id == "1") {

                $('#ChkCode').show();
                $('#Chkfields').hide();
                $('#mobilefield').hide();
                $('#Otherfield').hide();
            }

            else if (id == "FITSIQUE") {
                $('#Chkcode').hide();
                $('#Chkfields').show();
                $('#mobilefield').show();
                $('#Otherfield').hide();
                var code = Codeone + '-' + Codetwo
                // var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $("#example13-digit-number").val(code);
            }





            // check for the 13-digit number when the user is enter to check the code is correct or else

            $('#example13-digit-number').mask("99999-99999999");

            $("#btnnxt").on('click', function (e) {
                e.preventDefault();
                debugger;

                var codeone = $('#example13-digit-number').val();

                if (codeone == "" || codeone == undefined) {
                    $('#codecheck').html('**Please Enter 13- Digit-Code');
                    $('#codecheck').css("color", "red");
                    return false;
                }
                else {
                    $('#nextcheck').text('');
                }

                if (codeone != undefined) {
                    if ($('#example13-digit-number').val().length < 14) {
                        $('#codecheck').text('**Please Enter 13-Digit-Code');
                        $('#codecheck').css("color", "red");
                        return false;
                    }
                    else {
                        $('#codecheck').text('');
                        $('#codecheck').hide();
                    }
                }

                var rquestpage_Dcrypt = $("#example13-digit-number").val();

                $('#btnnxt').hide();
                $('#btnloadnxt').show();
                debugger;
                $.ajax({
                    type: "POST",
                    url: baseurl + 'Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                    success: function (data) {

                        $.ajax({
                            type: "POST",
                            url: baseurl + 'Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1] + '&lat=' + lat + '&long=' + long,
                            success: function (data) {

                                $('#btnnxt').show();
                                $('#btnloadnxt').hide();
                                if (data.split('&')[0] === "1" && data.split('&')[1] === "fatisque") {



                                }
                                else {
                                    // this is used to know from api  which company name


                                    if (data.split('&')[1] == "FITSIQUE" || data.split('&')[1] == "" || data.split('&')[1] == undefined) {
                                        $('#Chkcode').hide();
                                        $('#Chkfields').show();
                                        $('#mobilefield').show();
                                        $('#Otherfield').hide();


                                    }
                                    else {
                                        // alert('Invalid Code');
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

            $("#mobile").mask("9999999999");

            $('#mobile').keyup(function () {
                Mobile_check();
            })

            // Validation for the pincode
            $("#Pincode").mask("999999");
            $('#Pincode').keyup(function () {
                pinval();

            });

            // validation for the namecheck
            $('#name').keyup(function () {
                Name_check();

            });



            $('#example13-digit-number').keyup(function () {
                $('#codecheck').hide();
                $('#codecheck').html("");
                $('#codecheck').css("color", "white");

            });
            $('#name').keyup(function () {
                $('#namecheck').hide();
                $('#namecheck').html("");
                $('#namecheck').css("color", "white");

            });
            $('#Pincode').keyup(function () {
                $('#pincheck').hide();
                $('#pincheck').html("");
                $('#pincheck').css("color", "white");

            });
            $('#city').keyup(function () {
                $('#citycheck').hide();
                $('#citycheck').html("");
                $('#citycheck').css("color", "white");

            });
            $('#State').keyup(function () {
                $('#statecheck').hide();
                $('#statecheck').html("");
                $('#statecheck').css("color", "white");

            });


            function Name_check() {
                var Name_val = $('#name').val();

                if (Name_val.charAt(0) === ' ') {
                    $('#namecheck').html("**Please Enter Valid Name");
                    $('#namecheck').css("color", "red");
                    /* toastr.error('Please Enter a Valid UPI ID');*/
                    return false;
                }
                if ((Name_val.length == '')) {
                    $('#namecheck').show();
                    $('#namecheck').html("**Please Enter Name");
                    $('#namecheck').css("color", "red");
                    name_err = false;
                    return false;
                }

                if ($('#name').val().match('^[a-z A-Z]{3,40}$')) {
                    $('#namecheck').hide();
                }
                else {
                    $('#namecheck').show();
                    $('#namecheck').html("**Please Enter valid name");
                    $('#namecheck').css("color", "red");
                    name_err = false;
                    return false;
                }

            }
            function pinval() {
                var pin = $('#Pincode').val();
                if (pin != undefined) {

                    if ($('#Pincode').val().length < 1) {
                        $('#pincheck').html("**Please Enter  Pincode");
                        $('#pincheck').css("color", "red");
                        $('#city').val() = '';
                        $('#State').val() = '';
                        validate = false;
                    }
                    if (pin.match(/[^$,.\d]/)) {
                        $('#pincheck').html("**Please Enter Valid Pincode");
                        $('#pincheck').css("color", "red");
                        validate = false;
                    }

                    var matches1 = $('#pin').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        $('#pincheck').html("**Please Enter Valid Pincode");
                        $('#pincheck').css("color", "red");
                        validate = false;
                    }
                }
            }
            // validation for the city
            $('#city').keyup(function () {
                city_check();

            });

            function city_check() {

                var city_val = $('#city').val();
                /*debugger;*/
                if (city_val.charAt(0) === ' ') {
                    $('#citycheck').html("**Please Enter  City");
                    $('#citycheck').css("color", "red");
                    /* toastr.error('Please Enter a Valid UPI ID');*/
                    return false;
                }
                if ($('#city').val().match('^[a-z A-Z]{3,40}$')) {
                    $('#citycheck').hide();
                }
                else if ($('#city').val() == '') {
                    $('#citycheck').hide();

                }
                else {
                    $('#citycheck').show();
                    $('#citycheck').html("**Please enter valid city name");
                    $('#citycheck').css("color", "red");
                    city_err = false;
                    return false;
                }
            }


            // validation for states
            $('#State').keyup(function () {
                State_check();

            });

            function State_check() {
                /*debugger;*/
                var State_val = $('#State').val();
                if (State_val.charAt(0) === ' ') {
                    $('#statecheck').html("**Please Enter  State");
                    $('#statecheck').css("color", "red");
                    /* toastr.error('Please Enter a Valid UPI ID');*/
                    return false;
                }
                if ($('#State').val().match('^[a-z A-Z]{3,40}$')) {
                    $('#statecheck').hide();
                }
                else if ($('#State').val() == '') {
                    $('#statecheck').hide();

                }
                else {

                    $('#statecheck').show();
                    $('#statecheck').html("**Please Enter State name");
                    $('#statecheck').css("color", "red");
                    Vill_err = false;
                    return false;
                }
            }
            $('#email').keyup(function () {
                Mail_check();
            });

            /* Validation for the Mail */
            function Mail_check() {
                debugger;
                var Mail_val = $('#email').val();
                var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;

                if (Mail_val.length == 0) { // Check for empty email field
                    $('#emailcheck').show();
                    $('#emailcheck').html("**Please enter Email");
                    $('#emailcheck').css("color", "red");
                    Mail_err = false;
                    return false;
                } else if (!regex.test(Mail_val)) { // Check for invalid email format
                    $('#emailcheck').show();
                    $('#emailcheck').html("**Please enter valid Email");
                    $('#emailcheck').css("color", "red");
                    Mail_err = false;
                    return false;
                } else { // Email is valid
                    $('#emailcheck').html("");
                    Mail_err = true;
                }
            }
            $('#Pincode').keyup(function () {
                $('#pincheck').hide();
                $('#pincheck').html("");
                $('#pincheck').css("color", "purple");

            });

            $('#btnsubmit').on('click', function (e) {
                e.preventDefault();
                $('#mobilecheck').text('');
                debugger;
                var Mobile = $('#mobile').val()
                var pincode = $('#pincode').val()
                var d = Mobile.slice(0, 1);
                var c = parseInt(d);
                if (Mobile.match(/[^$,.\d]/)) {
                    $('#mobilecheck').text(" Mobile number should not contain any special characters.");
                    $('#mobile').val('');
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if (Mobile.length == 10 && c <= 5) {
                    $('#mobilecheck').text("Please enter a valid mobile number.");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if (Mobile.length != 10) {
                    $('#mobilecheck').text("Please enter 10 digit mobile number.");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if ($('#name').val().replace(/\s+/g, '').length == 0) {
                    $('#namecheck').text('Please Enter Your Name!');
                    $('#name').focus();
                    $('#name').val('');
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }

                var name = $('#name').val();
                if (name != undefined) {

                    if ($('#name').val().length < 1) {
                        $('#namecheck').text('Please Enter Valid Name');
                        return false;
                    }
                    var matches = $('#name').val().match(/\d+/g);
                    if (matches != null) {
                        $('#namecheck').text('Name should be alphabet only!');
                        return false;
                    }
                    var matches1 = $('#name').val();
                    if (matches1.includes('~') || matches1.includes('!') || matches1.includes('@') || matches1.includes('#') || matches1.includes(')') || matches1.includes('_') || matches1.includes('-') || matches1.includes('>') || matches1.includes(',') || matches1.includes('?')
                        || matches1.includes('$') || matches1.includes('%') || matches1.includes('^') || matches1.includes('&') || matches1.includes('*') || matches1.includes('(') || matches1.includes('+') || matches1.includes('<') || matches1.includes('.')
                        || matches1.includes('=') || matches1.includes('{') || matches1.includes('}') || matches1.includes('[') || matches1.includes(']') || matches1.includes(':') || matches1.includes(';') || matches1.includes('"') || matches1.includes('/')
                    ) {
                        $('#namecheck').text('Special characters are not allowed.*');
                        $('#name').focus();
                        $('#btnsubmit').attr('disabled', false);
                        $('#name').val('');
                        return false;
                    }
                }



                var pin = $('#Pincode').val();
                if (pin != undefined) {

                    if ($('#Pincode').val().length < 6) {
                        $('#pincheck').text('Please Enter Valid Pin Code');
                        return false;
                    }
                    if (pin.match(/[^$,.\d]/)) {
                        $('#pincheck').text("Please Enter Numeric Value For Pin Code.");
                        return false;
                    }

                    var matches1 = $('#Pincode').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        $('#pincheck').text('Pin Code Should Not Contain Any Special Character!');
                        return false;
                    }
                }

                if ($('#city').val().replace(/\s+/g, '').length == 0) {
                    $('#citycheck').text('Please Enter Your City Name!');
                    $('#city').focus();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }

                var city = $('#city').val();
                if (city != undefined) {

                    if ($('#city').val().length < 1) {
                        $('#citycheck').text('Please Enter valid City');
                        return false;
                    }
                    var matches = $('#city').val().match(/\d+/g);
                    if (matches != null) {
                        $('#citycheck').text('City Name Should be alphabet only!');
                        return false;
                    }
                    var matchescity = $('#city').val();
                    if (matchescity.includes('~') || matchescity.includes('!') || matchescity.includes('@') || matchescity.includes('#') || matchescity.includes(')') || matchescity.includes('_') || matchescity.includes('-') || matchescity.includes('>') || matchescity.includes(',') || matchescity.includes('?')
                        || matchescity.includes('$') || matchescity.includes('%') || matchescity.includes('^') || matchescity.includes('&') || matchescity.includes('*') || matchescity.includes('(') || matchescity.includes('+') || matchescity.includes('<') || matchescity.includes('.')
                        || matchescity.includes('=') || matchescity.includes('{') || matchescity.includes('}') || matchescity.includes('[') || matchescity.includes(']') || matchescity.includes(':') || matchescity.includes(';') || matchescity.includes('"') || matchescity.includes('/')
                    ) {
                        $('#citycheck').text('Special characters are not allowed.*');
                        $('#city').focus();
                        $('#btnsubmit').attr('disabled', false);
                        $('#city').val('');
                        return false;
                    }
                }


                if ($('#State').val().replace(/\s+/g, '').length == 0) {
                    $('#statecheck').text('Please Enter Your State Name!');
                    $('#State').focus();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }

                var State = $('#State').val();
                if (State != undefined) {

                    if ($('#State').val().length < 1) {
                        $('#statecheck').text('Please Enter Valid State Name');
                        return false;
                    }
                    var matches = $('#State').val().match(/\d+/g);
                    if (matches != null) {
                        $('#statecheck').text('State Name Should be alphabet only!');
                        return false;
                    }
                    var matchesstate = $('#State').val();
                    if (matchesstate.includes('~') || matchesstate.includes('!') || matchesstate.includes('@') || matchesstate.includes('#') || matchesstate.includes(')') || matchesstate.includes('_') || matchesstate.includes('-') || matchesstate.includes('>') || matchesstate.includes(',') || matchesstate.includes('?')
                        || matchesstate.includes('$') || matchesstate.includes('%') || matchesstate.includes('^') || matchesstate.includes('*') || matchesstate.includes('(') || matchesstate.includes('+') || matchesstate.includes('<') || matchesstate.includes('.')
                        || matchesstate.includes('=') || matchesstate.includes('{') || matchesstate.includes('}') || matchesstate.includes('[') || matchesstate.includes(']') || matchesstate.includes(':') || matchesstate.includes(';') || matchesstate.includes('"') || matchesstate.includes('/')
                    ) {
                        $('#statecheck').text('Special characters are not allowed.*');
                        $('#State').focus();
                        $('#btnsubmit').attr('disabled', false);
                        $('#State').val('');
                        return false;
                    }
                }
                // Email validation
                var email = $('#email').val();
                if (email.replace(/\s+/g, '').length == 0) {
                    $('#emailcheck').text('Please Enter Your Email!');
                    $('#email').focus();
                    return false;
                }
                var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
                if (!emailPattern.test(email)) {
                    $('#emailcheck').text('Please Enter a Valid Email Address!');
                    $('#email').focus();
                    return false;
                }

                $('#btnsubmit').hide();
                $('#btnloadsubmit').show();


                var code = $('#example13-digit-number').val();
                // alert(code);
                if (code != "") {
                    // alert("dfef");
                    debugger;

                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: baseurl + 'Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#example13-digit-number').val() + '&name=' + $('#name').val() + '&city=' + $('#city').val() + '&state=' + $('#State').val() + '&PinCode=' + $('#Pincode').val() + '&EmailAddrs=' + $('#email').val() + '&comp=FITSIQUE&Comp_ID=Comp-1720',
                        success: function (data) {
                            // to know about outcome
                            // alert(data);
                            // alert(data.split('~')[1]);
                            $('#btnsubmit').show();
                            $('#btnloadsubmit').hide();
                            if (data.split('~')[0] !== "failure") {
                                window.scrollTo(0, 0);
                                const card = document.getElementById('card');
                                if (data.includes("invalid")) {
                                    data = "0~The code entered is invalid";
                                    card.style.backgroundColor = '#dc3545'; // Bootstrap danger color
                                } else if (data.includes("Congratulations!!")) {
                                    data = "0~Congratulations!! You have purchased an Authentic product from Fitsique, to check another code <a href='../Fatisque.aspx' class='text-white'>Click Here</a>.";
                                    card.style.backgroundColor = '#28a745'; // Bootstrap success color
                                } else if (data.includes("already")) {
                                    data = "0~The Code is already verified, to check another code <br><a href='../Fatisque.aspx' class='text-white'>Click Here</a>.";
                                    card.style.backgroundColor = '#dc3545'; // Bootstrap warning color
                                } else {
                                    // Handle any other conditions if necessary
                                    card.style.backgroundColor = '#6c757d'; // Bootstrap secondary color
                                }
                                if (data.indexOf("invalid") !== -1) {
                                    data = data.split(".")[0];
                                }

                                $('#Chkfields').hide();
                                $('#mobilefield').hide();
                                $('#Otherfield').hide();
                                $('#Chkcode').hide();
                                $('#ShowMessage').show();
                                // $('#chkLine').hide();
                                //if ((data) === "success~The code is invalid. Kindly call on 7353000903 for further assistance. </br>कोड अमान्य है. कृपया अधिक सहायता के लिए 7353000903 पर कॉल करें।")
                                //{

                                //    $('#p3msg').html('The code entered is invalid. Please check and try again');
                                //}

                                $('#p3msg').html(data.split('~')[1]);
                                $('#p3msg:contains("not")').css('color', 'white');
                            }
                            else if (data.split('~')[0] === "failure") {
                                alert(data.split('~')[1]);
                            }
                            else {
                                /*$('#msgcoats').hide();*/
                                toastr.error('OTP is not valid. Please provide the valid OTP');
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
                window.location.href = 'https://fitsique.in/';
            });

        });

    </script>
</head>

<body>
    <form method="post" runat="server" action="./codeverify.aspx?ID=5" id="form1">
        <div>
            <input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE"
                value="/wEPDwUKMTg0OTQ1MjgyNWRksJsH6oszOY6aBQb8ZYXqeZMoulsk8vinBkoOFmG/5+0=" />
        </div>
        <div>
            <input type="hidden" name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="1C52CC2C" />
            <input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION"
                value="/wEdAAd6JZhTpi8GFWyIsYyG2DIQTHJap1XPAwS4DQSuvGS50UWwP5KwieItj32l9mnkzqloDPdc3hZCgD7GXGAULra3/e/TMgqN0FcyW0KuwQmpO/68Exa89vh/IRkoWN0RiIwY7K8ZMmE2lBY9fYpYdQz1P9IDSJSefdmxvBXJdr6y/iaq/z6L9cln71gR+ZJ5CX0=" />
        </div>
        <!-- <asp:HiddenField ID="hdnmob" runat="server" />
        <asp:HiddenField ID="HdnID" runat="server" />
        <asp:HiddenField ID="HdnCode1" runat="server" />
        <asp:HiddenField ID="HdnCode2" runat="server" />
        <asp:HiddenField ID="CompName" runat="server" />
        <asp:HiddenField ID="long" runat="server" />
        <asp:HiddenField ID="lat" runat="server" /> -->
        <input type="hidden" id="hdnmob" name="hdnmob" />
        <input type="hidden" id="HdnID" name="HdnID" />
        <input type="hidden" id="HdnCode1" name="HdnCode1" />
        <input type="hidden" id="HdnCode2" name="HdnCode2" />
        <input type="hidden" id="CompName" name="CompName" />
        <input type="hidden" id="long" name="long" />
        <input type="hidden" id="lat" name="lat" />
        <div class="landing">
            <img src="assets/images/Fatisque/banner.png" class="img-fluid banner" alt="">

            <div class="container">
                <div class="row g-4">
                    <div class="col-12">
                    </div>
                    <div class="col-xxl-5 col-xl-5 col-lg-5 col-md-12">

                        <div class="product">
                            <img src="assets/images/Fatisque/logo.png" alt="">
                        </div>
                        <div class="formplace">
                            <div class="card" id="card">
                                <div class="card-body">
                                    <h5 class="">Autheticate your Product</h5>
                                    <hr>
                                    <div>
                                        <div class="mb-3">
                                            <div id="Chkcode">
                                                <label for="example13-digit-numbe" class="form-label">Enter 13 Digit Code*</label>
                                                <input type="text" id="example13-digit-number" class="form-control" />
                                                <h6 id="codecheck" class="invalid-feedback d-block"></h6>
                                                <button type="button" id="btnnxt" data-toggle="modal"
                                                    class="form-buttom btn">
                                                    Next</button>
                                                <button type="button" id="btnloadnxt" style="display: none"
                                                    data-toggle="modal" class="form-control login-btn">
                                                    <i
                                                        class="fa fa-spinner fa-spin"></i>Loading..</button>
                                                <h6 id="nextcheck"></h6>
                                            </div>
                                        </div>
                                        <div id="Chkfields">
                                            <div id="mobilefield">
                                                <div class="mb-3">
                                                    <label for="mobile" class="form-label">Mobile No*</label>

                                                    <span class="">
                                                        <input type="text" maxlength="10"
                                                            id="mobile" onkeyup="Getdata()"
                                                            onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
                                                            class="form-control" />
                                                    </span>
                                                    <h6 id="mobilecheck" class="invalid-feedback d-block"></h6>
                                                </div>
                                            </div>
                                            <div id="Otherfield">


                                                <div class="mb-3">
                                                    <label for="name" class="form-label">Name*</label>
                                                    <input type="text" maxlength="40" id="name"
                                                        onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || (event.charCode == 32)"
                                                        class="form-control" />
                                                    <h6 id="namecheck" class="invalid-feedback d-block"></h6>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="name" class="form-label">Email*</label>
                                                    <input type="text" maxlength="40" id="email"
                                                        <%--onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || (event.charCode == 32)"--%>
                                                        class="form-control" />
                                                    <h6 id="emailcheck" class="invalid-feedback d-block"></h6>
                                                </div>


                                                <div class="mb-3">
                                                    <label for="exampleInputtext4" class="form-label">Pin Code*</label>
                                                    <input type="text" minlegth="6" maxlength="6" id="Pincode"
                                                        onkeyup="getaddress()" class="form-control" />
                                                    <h6 id="pincheck" class="invalid-feedback d-block"></h6>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="city" class="form-label">City*</label>
                                                    <input type="text" maxlength="40" id="city" class="form-control" />
                                                    <h6 id="citycheck" class="invalid-feedback d-block"></h6>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="city" class="form-label">State*</label>
                                                    <input type="text" maxlength="40" id="State" class="form-control" />
                                                    <h6 id="statecheck" class="invalid-feedback d-block"></h6>
                                                </div>





                                                <!-- <div class="mb-3">
                                                <label for="exampleInputtext2" class="form-label">UPI Id/यूपीआई आईडी*</label>
                                                <input type="text" maxlength="30" class="form-control" id="UPI"
                                                    required>
                                                <h6 id="upicheck" class="invalid-feedback d-block"></h6>

                                            </div>

                                            <div class="mb-3">
                                                <label for="exampleInputtext2" class="form-label">PAN Card/पैन कार्ड*</label>
                                                <input type="text" class="form-control" maxlength="10"
                                                    id="pancard_number" 
                                                    required>
                                                <h6 id="pancheck" class="invalid-feedback d-block"></h6>
                                            </div>
                                            -->
                                            </div>

                                            <div class="col-lg-12 p-1">
                                                <button type="button" id="btnsubmit" class="form-buttom btn">Next</button>
                                                <button type="button" id="btnloadsubmit" style="display: none"
                                                    data-toggle="modal" class="form-control login-btn">
                                                    <i
                                                        class="fa fa-spinner fa-spin"></i>Loading..</button>
                                            </div>
                                        </div>
                                        <div style="display: none;" id="ShowMessage">

                                            <div class="">
                                                <p id="p3msg"
                                                    style="overflow: hidden; font-size: 15px !important; font-weight: 500; margin: 7px; margin-right: 7px;"
                                                    class="displayNone text-center text-white">
                                                </p>
                                                <center>
                                                    <a href="javascript:void(0)"
                                                        style="color: white; font-size: medium" class=" "
                                                        id="btnNext">Close</a></center>
                                            </div>

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                    <div class="col-xxl-7 col-xl-7 col-lg-7 col-md-12 ">

                        <!-- <div class="product-img text-center">
                        <img class="img-fluid" src="" alt="">
                    </div> -->
                        <div class="product-img text-end ">
                            <!-- First Column -->

                            <img src="assets/images/Fatisque/product.png" class="img-fluid custom-img" alt="Image 6">
                        </div>



                    </div>
                    <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12 ">

                        <!-- <div class="product-img text-center">
                        <img class="img-fluid" src="" alt="">
                    </div> -->
                        <div class="footer-img text-center mb-5">
                            <!-- First Column -->

                            <img src="assets/images/Fatisque/footer.png" class="img-fluid custom-img" alt="Image 6">
                        </div>



                    </div>

                </div>
            </div>
            <div class="footer">
                <div class="container">
                    <div class="row">

                        <div class="col text-center">
                            <a href="https://fitsique.in/" target="_blank"><i class="fa-solid fa-globe"></i>https://fitsique.in/</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>



    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>
