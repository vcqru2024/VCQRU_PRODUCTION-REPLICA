<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fit-fleet.aspx.cs" Inherits="fit_fleet" %>

    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Fit Fleet</title>
        <!-- css -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
        <!-- icon -->
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet' />
        <!-- font-family -->
        <!-- font family -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/0.9.0/jquery.mask.min.js"></script>
    </head>
    <style>
        body {
            font-family: 'Jost' !important;
        }

        .landing-ui .card-left {
            padding: 3rem 10rem;
            width: 100%;
        }

        .landing-ui .card-left .logo {
            text-align: center;
            margin-bottom: 1rem;
        }

        .landing-ui .card-left .logo img {
            height: 5rem;
        }

        .landing-ui .card-left .card-title {
            margin-bottom: 0.25rem;
        }

        .landing-ui .card-left .card-text {
            color: #4B5563;
        }

        .landing-ui .card-left .form-label {
            font-size: 16px;
            font-weight: 600;
            color: #5F5E62;
            text-transform: capitalize;
        }

        .landing-ui .card-left .form-label span {
            color: var(--bs-danger);
        }

        .landing-ui .card-left .form-control {
            border-radius: 2px;
            background-color: #F3F4F6;
            font-weight: 600;
            padding: 0.75rem;
        }

        .landing-ui .card-left .form-control::placeholder {
            color: #ADAAAF;
        }

        .landing-ui .card-left .btn {
            width: 100%;
            border-radius: 2px;
            background-color: #FB0102;
            color: var(--bs-white);
            font-weight: 600;
            text-transform: uppercase;
            padding: 0.75rem;
            border-color: #FB0102;
        }

        .footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            background-color: #FB0102;
            padding: 0.25rem 0;
            z-index: 1000;
        }

        .footer p {
            margin-bottom: 0;
            font-size: 14px;
            color: var(--bs-white);
        }

        .footer a {
            color: var(--bs-white);
        }

        /* Chrome, Safari, Edge, Opera */
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        /* Firefox */
        input[type=number] {
            -moz-appearance: textfield;
        }

        /* card-right */
        .landing-ui .card-right {
            width: 100%;
            position: relative;
            overflow: hidden;
            min-height: 100vh;
        }

        .landing-ui .card-right video {
            width: 100%;
            height: 100%;
            object-fit: cover;
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
        }

        .landing-ui .card-right::before {
            content: '';
            position: absolute;
            top: 0;
            background: linear-gradient(0deg, rgba(0, 0, 0, 1) 0%, rgba(0, 0, 0, 0) 100%);
            height: 100%;
            width: 100%;
            z-index: 1000;
        }

        .landing-ui .container-fluid {
            padding: 0;
        }

        .landing-ui .product-img {
            position: absolute;
            z-index: 1000;
            width: 100%;
            text-align: center;
            bottom: 0;
            margin-bottom: 2rem;
        }

        /* reponsive-css */
        @media screen and (max-width:1024px) {
            .landing-ui .card-left {
                padding: 3rem;
            }
        }

        @media screen and (max-width:768px) {
            .landing-ui .card-right video {
                position: unset;
            }

            .landing-ui .product-img {
                margin-bottom: 3rem;
            }
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
            /* debugger */
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
                            /* debugger */
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
                            }
                        }
                    });
                }
            }


        }

        function getaddress() {
            /* debugger */
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
                        /* debugger */

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
                /* debugger */
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

            else if (id == "Fit Fleet") {
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
                               // alert(data);
                                $('#btnnxt').show();
                                $('#btnloadnxt').hide();
                                if (data.split('&')[0] === "1" && data.split('&')[0] === "Fit Fleet") {



                                }
                                else {
                                    // this is used to know from api  which company name


                                    if (data.split('&')[1] == "Fit Fleet" || data.split('&')[1] == "" || data.split('&')[1] == undefined) {
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
                Pin_check();

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
                debugger;
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
                debugger;
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

            $('#Pincode').keyup(function () {
                $('#pincheck').hide();
                $('#pincheck').html("");
                $('#pincheck').css("color", "purple");

            });

            $('#btnsubmit').on('click', function (e) {
                e.preventDefault();
                $('#mobilecheck').text('');
                /* debugger */
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
                    $('#mobilecheck').text("Please enter your mobile number.");
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

                $('#btnsubmit').hide();
                $('#btnloadsubmit').show();


                var code = $('#example13-digit-number').val();
                // alert(code);
                if (code != "") {
                    // alert("dfef");
                    /* debugger */

                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: baseurl + 'Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#example13-digit-number').val() + '&name=' + $('#name').val() + '&city=' + $('#city').val() + '&state=' + $('#State').val() + '&PinCode=' + $('#Pincode').val() + '&comp=Fit Fleet&Comp_ID=Comp-1733',
                        success: function (data) {
                            // to know about outcome
                            // alert(data);
                            // alert(data.split('~')[1]);
                            $('#btnsubmit').show();
                            $('#btnloadsubmit').hide();
                            if (data.split('~')[0] !== "failure") {
                                window.scrollTo(0, 0);
                                if (data.indexOf("not valid") !== -1) {
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
                                $('#p3msg:contains("not")').css('color', 'black');
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
                window.location.href = 'https://vcqru.com/fit-fleet.aspx';
            });

        });

    </script>

    <body>
        <!-- section -->
        <section class="landing-ui">
            <div class="container-fluid">
                <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 row-cols-1 g-0">
                    <div class="col d-flex">
                      <div class="card">
                            <div class="card-left">
                            <div class="logo">
                                <img src="assets/images/fitfleet/logo.svg" alt="Logo">
                            </div>
                            <form method="post" runat="server" action="./codeverify.aspx?ID=5" id="form1">
                                <div>
                                    <input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE"
                                        value="/wEPDwUKMTg0OTQ1MjgyNWRksJsH6oszOY6aBQb8ZYXqeZMoulsk8vinBkoOFmG/5+0=" />
                                </div>
                                <div>
                                    <input type="hidden" name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR"
                                        value="1C52CC2C" />
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
                                <div class="mb-3">
                                    <h5 class="card-title">Check Authenticity</h5>
                                    <p class="card-text">Welcome to the official page of the Fit Fleet authenticity
                                        check portal.</p>
                                </div>
                                <div id="Chkcode">
                                    <div class="row row-cols-1 g-3">
                                        <div class="col">
                                            <div class="form-group">
                                                <label for="example13-digit-numbe" class="form-label">Enter 13 digit
                                                    code<span>*</span></label>

                                                <input type="text" id="example13-digit-number" class="form-control" />
                                                <div id="codecheck" class="invalid-feedback d-block"></div>
                                                <div id="nextcheck"></div>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <button type="button" id="btnnxt" class="btn btn-danger">Next</button>
                                            <button type="button" id="btnloadnxt" style="display: none"
                                                data-toggle="modal" class="btn btn-danger"><i
                                                    class="fa fa-spinner fa-spin"></i>Loading..</button>
                                        </div>
                                    </div>
                                </div>
                                <div id="Chkfields">
                                    <div class="row row-cols-1 g-3">
                                        <div id="mobilefield" class="col">
                                            <div class="form-group">
                                                <label for="mobile" class="form-label">Mobile No*</label>
                                                <input type="text" maxlength="10" id="mobile" onkeyup="Getdata()"
                                                    onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
                                                    class="form-control" />
                                                <div id="mobilecheck" class="invalid-feedback d-block"></div>
                                            </div>
                                        </div>
                                        <div id="Otherfield" class="col">
                                            <div class="form-group">
                                                <label for="name" class="form-label">Name*</label>
                                                <input type="text" maxlength="40" id="name"
                                                    onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || (event.charCode == 32)"
                                                    class="form-control" />
                                                <div id="namecheck" class="invalid-feedback d-block"></div>
                                            </div>
                                        
                                        <div class="col">
                                            <div class="form-group mb-3">
                                                <label for="exampleInputtext4" class="form-label">Pin Code*</label>
                                                <input type="text" minlegth="6" maxlength="6" id="Pincode"
                                                    onkeyup="getaddress()" class="form-control" />
                                                <div id="pincheck" class="invalid-feedback d-block"></div>
                                            </div>
                                            <div class="form-group mb-3">
                                                <label for="city" class="form-label">City*</label>
                                                <input type="text" maxlength="40" id="city" class="form-control" />
                                                <h6 id="citycheck" class="invalid-feedback d-block"></h6>
                                            </div>
                                            <div class="form-group mb-3">
                                                <label for="exampleInputtext6" class="form-label">State*</label>
                                                <input type="text" maxlength="40" id="State" class="form-control" />
                                                <h6 id="statecheck" class="invalid-feedback d-block"></h6>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        <button type="button" id="btnsubmit" class="form-buttom btn">Submit</button>
                                        <button type="button" id="btnloadsubmit" style="display: none"
                                            class="form-control login-btn"><i
                                                class="fa fa-spinner fa-spin"></i>Loading..</button>
                                    </div>
                                </div>
                                </div>
                                <div class="card" style="display: none;" id="ShowMessage">
    <div class="card-body">
        <p id="p3msg" class="card-text text-center"></p>
        <div class="text-center">
            <a href="javascript:void(0)" id="btnNext" class="btn btn-primary">Close</a>
        </div>
    </div>
</div>
                            </form>
                        </div>

                      </div>
                    </div>
                    <div class="col d-flex">
                        <div class="card-right">
                            <video playsinline="true" autoplay="true" loop="true" controlslist="nodownload"
                                msallowfullscreen="true" muted="true">
                                <source src="assets/images/fitfleet/right-card-video.mp4" type="video/mp4" />
                            </video>
                            <div class="product-img">
                                <img src="assets/images/fitfleet/product-img.svg" alt="product-img" class="img-fluid" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- footer -->
        <footer class="footer">
            <div class="container">
                <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1">
                    <div class="col">
                        <p class="text-md-start text-center">© 2024 Fit Fleet All rights reserved.</p>
                    </div>
                </div>
            </div>
        </footer>
        <!-- footer-end -->
        <!-- bootstrap js -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>