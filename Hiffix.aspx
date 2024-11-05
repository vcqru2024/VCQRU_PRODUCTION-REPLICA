<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Hiffix.aspx.cs" Inherits="Hiffix" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hiifix</title>
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
                background: url('assets/images/Hiffix/background.png');
                background-repeat: no-repeat;
                background-size: cover;
                /* min-height: 100vh; */
                background-position: center;
                /* position: relative; */
            }

            input::placeholder {
                color: white !important;
            }

            ul {
                list-style-type: none;
            }

            .footer {
                /* height: 2rem; */
                width: 100%;
                padding: 0.25rem 0;
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


            .formplace h5 {
                color: #fff;
                text-align: center;
            }






            /* .formplace .card .card-body{
                    padding: 2rem;
                    font-weight: bold;
                    font-size: 12px;
                    color: black;
                } */
            .formplace .card .card-body button {
                background-color: #ffffff;
                color: rgb(0, 0, 0);
                width: 100%;
                border-radius: 4px;
                padding: .7rem 2rem;
                font-weight: 400;
                font-size: larger;
            }

            .formplace .card .card-body {
                padding: 2rem 1rem !important;
            }

            .formplace .formplace .card .card-body h4 {
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
                background-color: #ffffff45;
                border-radius: 4px;
                color: #ffffff;
                font-weight: 500;
                border: 2px solid rgb(255 255 255 / 97%);
                padding: .7rem 2rem;
            }


            .formplace .card {
                border-radius: 0px;
                box-shadow: 4px 4px 8px rgba(0, 0, 0, 0.217);
                background-color: #ffffff4f;
            }

            .product-img {
                margin-top: 28px;
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

            .formplace {
                margin-bottom: 50px;
                margin-top: 30px;
            }

            .product-heading2 {
                display: none;
            }

            .product-heading {
                display: block;
            }
            @media screen and (max-width: 780px) {
                .foot-links{
                    text-align: center!important;
                }
                .foot-text{
                    text-align: center!important;
                }
            }

            @media screen and (max-width: 999px) {
                .formplace .card {
                    margin: 0;
                }

                /* .formplace {
            margin-top: 0;
        } */

                .product-img {
                    margin-top: 0;
                    margin-bottom: 40px;
                }

                .product-heading2 {
                    display: block;
                }

                .product-heading {
                    display: none;
                }
                .logo-thing{
                    text-align: center!important;

                }
                .link-thing{
                    justify-content: center!important;

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


            function Mobile_check() {
                debugger;
                var mobile_val = $('#mobile').val();
                var d = mobile_val.slice(0, 1);
                var c = parseInt(d);

                if ((mobile_val.length == '') || (mobile_val.length != 10)) {
                    $('#mobilecheck').show();
                    $('#mobilecheck').html("**Please Enter 10 digit mobile number");
                    $('#mobilecheck').css("color", "red");
                    mobile_err = false;
                    return false;
                }


                if (mobile_val.length == 10) {
                    $('#mobilecheck').hide();

                    $.ajax({
                        type: "Post",
                        url: baseurl + 'Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNo&MobileNo=' + $("#mobile").val() + '&compid=Comp-1723',
                        success: function (data) {
                             //alert(data);
                            debugger;
                            if (c <= 5) {
                                $('#mobilecheck').text('Please Enter Correct Mobile Number');
                                $('#mobile').val('');
                                return false;
                            }

                            else {
                                debugger;

                                var Name = data.split('~')[0];
                                var city = data.split('~')[2];
                                var state = data.split('~')[3];
                                var pin = data.split('~')[6];
                                var AccountNumber = data.split('~')[9];
                                var IfscCode = data.split('~')[10];


                                $("#AccountNumber").val(AccountNumber);
                                $("#ConfirmAccountNumber").val(AccountNumber);
                                $("#IfscCode").val(IfscCode);
                                //$("#AccountHolderName").val(AccountHolderName);

                                /*$("#upi").val(UpiId);*/


                                if (/*$("#AccountHolderName").val() != "" && */$("#IfscCode").val() != "" && $("#AccountHolderName").val() != "") {
                                    $("#AccountNumber").attr('readonly', true);
                                    $("#ConfirmAccountNumber").attr('readonly', true);
                                    $("#IfscCode").attr('readonly', true);
                                    /*$("#AccountHolderName").attr('readonly', true);*/
                                }

                                debugger;

                                if (Name != "") {
                                    $("#name").val(Name);
                                    $("#name").attr('readonly', true);
                                    $('#Otherfield').hide();
                                    $('#divbank').show();
                                    //alert('1');
                                }

                                else if (Name == "" && AccountNumber != "" && IfscCode != "") {
                                    $('#ChkCode').hide();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#divbank').show();
                                    //alert('2');
                                }
                                else {
                                    $('#ChkCode').hide();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#divbank').show();
                                    //alert('3');
                                }
                                if (pin != "") {
                                    $("#Pincode").val(pin);
                                    $("#Pincode").attr('readonly', true);
                                    $('#Otherfield').hide();
                                    $('#divbank').show();
                                    //alert('4');
                                }
                                else if (pin == "" && AccountNumber != "" && IfscCode != "") {
                                    $('#ChkCode').hide();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#divbank').hide();
                                    //alert('5');
                                }
                                else {
                                    $('#ChkCode').hide();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#divbank').show();
                                    //alert('6');
                                }

                                if (city != "") {
                                    $("#city").val(city);
                                    $('#Otherfield').hide();
                                    $('#divbank').show();
                                    //alert('7');
                                }
                                else if (city == "" && AccountNumber != "" && IfscCode != "") {
                                    $('#ChkCode').hide();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#divbank').hide();
                                    //alert('8');
                                }
                                else {
                                    $('#ChkCode').hide();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#divbank').show();
                                    //alert('9');
                                }

                                if (state != "") {
                                    $("#State").val(state);
                                    $('#Otherfield').hide();
                                    $('#divbank').show();
                                    //alert('10');
                                }
                                else if (state == "" && AccountNumber != "" && IfscCode != "") {
                                    $('#ChkCode').hide();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#divbank').hide();
                                    //alert('11');
                                }
                                else {
                                    $('#ChkCode').hide();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#divbank').show();
                                    //alert('12');
                                }
                                if (AccountNumber != "" && IfscCode != "" && (Name == "" || pin == "" || city == "" || state == "")) {
                                    $('#ChkCode').hide();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#divbank').hide();
                                    //alert('16');
                                }

                                if (Name != "" && pin != "" && city != "" && state != "") {

                                    if (AccountNumber != "" && IfscCode != "") {
                                        $("#AccountNumber").val(AccountNumber);
                                        $("#ConfirmAccountNumber").val(AccountNumber);
                                        $("#IfscCode").val(IfscCode);
                                        $('#Chkfields').show();
                                        $('#mobilefield').show();
                                        $('#Otherfield').hide();
                                        $('#divbank').hide();
                                        //alert('17');
                                    }
                                    else {
                                        $('#ChkCode').hide();
                                        $('#mobilefield').hide();
                                        $('#Chkfields').show();
                                        $('#Otherfield').hide();
                                        $('#divbank').show();
                                        //alert('18');
                                    }

                                }
                            }
                        }
                    });
                }
                else {
                    $("#name").val('');
                    $("#Pincode").val('');
                    $("#city").val('');
                    $("#State").val('');
                }
            }

            //function onlyNumberKey(evt) {

            //    // Only ASCII character in that range allowed
            //    var ASCIICode = (evt.which) ? evt.which : evt.keyCode
            //    if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
            //        return false;
            //    return true;
            //}

            function onlyNumberKey(evt) {
                var ASCIICode = (evt.which) ? evt.which : evt.keyCode;
                if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57)) {
                    evt.preventDefault();  // Prevent the default action if not a number
                    return false;
                }
                return true;
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
                debugger;
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
                    $('#divbank').hide();
                }

                else if (id == "CHERYL CHEMICAL AND POLYMERS") {
                    $('#Chkcode').hide();
                    $('#Chkfields').show();
                    $('#mobilefield').show();
                    $('#divbank').hide();
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
                                    //  alert(data);
                                    $('#btnnxt').show();
                                    $('#btnloadnxt').hide();

                                    if (data.split('&')[1] == "CHERYL CHEMICAL AND POLYMERS" || data.split('&')[1] == "" || data.split('&')[1] == undefined) {
                                        $('#Chkcode').hide();
                                        $('#Chkfields').show();
                                        $('#mobilefield').show();
                                        $('#divbank').hide();
                                    }
                                    else {
                                        // alert('Invalid Code');
                                        $('#Chkcode').show();
                                        $('#Chkfields').hide();
                                        $('#mobilefield').hide();
                                        $('#divbank').hide();
                                        return false;
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
                    debugger;
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

                $('#Pincode').keyup(function () {
                    $('#pincheck').hide();
                    $('#pincheck').html("");
                    $('#pincheck').css("color", "purple");

                });
                $("#mobile").on('input', function () {
                    $("#mobilecheck").text("");
                });
                $("#AccountNumber").on('input', function () {
                    $("#AccountNumbercheck").text("");
                });
                $("#ConfirmAccountNumber").on('input', function () {
                    $("#ConfirmAccountNumbercheck").text("");
                });
                $('#btnsubmit').on('click', function (e) {
                    e.preventDefault();
                    debugger;

                    $('#mobilecheck').text('');
                    debugger;
                    var Mobile = $('#mobile').val()
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
                        $('#namecheck').css("color", "red");
                        $('#name').focus();
                        $('#name').val('');
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }

                    var name = $('#name').val();
                    if (name != undefined) {

                        if ($('#name').val().length < 1) {
                            $('#namecheck').text('Please Enter Valid Name');
                            $('#namecheck').css("color", "red");
                            return false;
                        }
                        var matches = $('#name').val().match(/\d+/g);
                        if (matches != null) {
                            $('#namecheck').text('Name should be alphabet only!');
                            $('#namecheck').css("color", "red");
                            return false;
                        }
                        var matches1 = $('#name').val();
                        if (matches1.includes('~') || matches1.includes('!') || matches1.includes('@') || matches1.includes('#') || matches1.includes(')') || matches1.includes('_') || matches1.includes('-') || matches1.includes('>') || matches1.includes(',') || matches1.includes('?')
                            || matches1.includes('$') || matches1.includes('%') || matches1.includes('^') || matches1.includes('&') || matches1.includes('*') || matches1.includes('(') || matches1.includes('+') || matches1.includes('<') || matches1.includes('.')
                            || matches1.includes('=') || matches1.includes('{') || matches1.includes('}') || matches1.includes('[') || matches1.includes(']') || matches1.includes(':') || matches1.includes(';') || matches1.includes('"') || matches1.includes('/')
                        ) {
                            $('#namecheck').text('Special characters are not allowed.*');
                            $('#namecheck').css("color", "red");
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
                            $('#pincheck').css("color", "red");
                            return false;
                        }
                        if (pin.match(/[^$,.\d]/)) {
                            $('#pincheck').text("Please Enter Numeric Value For Pin Code.");
                            $('#pincheck').css("color", "red");
                            return false;
                        }

                        var matches1 = $('#Pincode').val().match(/[^a-zA-Z0-9 ]/);
                        if (matches1 != null) {
                            $('#pincheck').text('Pin Code Should Not Contain Any Special Character!');
                            $('#pincheck').css("color", "red");
                            return false;
                        }
                    }

                    if ($('#city').val().trim().length == 0) {
                        $('#citycheck').text('Please Enter City Name!');
                        $('#city').focus();
                        return false;
                    } else {
                        $('#citycheck').text(''); // Clear the error message if input is valid
                    }

                    var city = $('#city').val();
                    if (city != undefined) {

                        if ($('#city').val().length < 1) {
                            $('#citycheck').text('Please Enter valid City');
                            $('#citycheck').css("color", "red");
                            return false;
                        }
                        var matches = $('#city').val().match(/\d+/g);
                        if (matches != null) {
                            $('#citycheck').text('City Name Should be alphabet only!');
                            $('#citycheck').css("color", "red");
                            return false;
                        }
                        var matchescity = $('#city').val();
                        if (matchescity.includes('~') || matchescity.includes('!') || matchescity.includes('@') || matchescity.includes('#') || matchescity.includes(')') || matchescity.includes('_') || matchescity.includes('-') || matchescity.includes('>') || matchescity.includes(',') || matchescity.includes('?')
                            || matchescity.includes('$') || matchescity.includes('%') || matchescity.includes('^') || matchescity.includes('*') || matchescity.includes('(') || matchescity.includes('+') || matchescity.includes('<') || matchescity.includes('.')
                            || matchescity.includes('=') || matchescity.includes('{') || matchescity.includes('}') || matchescity.includes('[') || matchescity.includes(']') || matchescity.includes(':') || matchescity.includes(';') || matchescity.includes('"') || matchescity.includes('/')
                        ) {
                            $('#citycheck').text('Special characters are not allowed.*');
                            $('#citycheck').css("color", "red");
                            $('#city').focus();
                            $('#btnsubmit').attr('disabled', false);
                            $('#city').val('');
                            return false;
                        }
                    }


                    if ($('#State').val().trim().length == 0) {
                        $('#statecheck').text('Please Enter Your State Name!');
                        $('#statecheck').css("color", "red");
                        $('#State').focus();
                        $('#btnsubmit').attr('disabled', true); // Disable the submit button
                        return false;
                    } else {
                        $('#statecheck').text(''); // Clear the error message if input is valid
                        $('#btnsubmit').attr('disabled', false); // Enable the submit button if needed
                    }

                    var State = $('#State').val();
                    if (State != undefined) {

                        if ($('#State').val().length < 1) {
                            $('#statecheck').text('Please Enter Valid State Name');
                            $('#statecheck').css("color", "red");
                            return false;
                        }
                        var matches = $('#State').val().match(/\d+/g);
                        if (matches != null) {
                            $('#statecheck').text('State Name Should be alphabet only!');
                            $('#statecheck').css("color", "red");
                            return false;
                        }
                        var matchesstate = $('#State').val();
                        if (matchesstate.includes('~') || matchesstate.includes('!') || matchesstate.includes('@') || matchesstate.includes('#') || matchesstate.includes(')') || matchesstate.includes('_') || matchesstate.includes('-') || matchesstate.includes('>') || matchesstate.includes(',') || matchesstate.includes('?')
                            || matchesstate.includes('$') || matchesstate.includes('%') || matchesstate.includes('^') || matchesstate.includes('*') || matchesstate.includes('(') || matchesstate.includes('+') || matchesstate.includes('<') || matchesstate.includes('.')
                            || matchesstate.includes('=') || matchesstate.includes('{') || matchesstate.includes('}') || matchesstate.includes('[') || matchesstate.includes(']') || matchesstate.includes(':') || matchesstate.includes(';') || matchesstate.includes('"') || matchesstate.includes('/')
                        ) {
                            $('#statecheck').text('Special characters are not allowed.*');
                            $('#statecheck').css("color", "red");
                            $('#State').focus();
                            $('#btnsubmit').attr('disabled', false);
                            $('#State').val('');
                            return false;
                        }
                    }

                    if ($('#AccountNumber').val() == "") {
                        $('#AccountNumbercheck').text('Please Enter valid account number');
                        $('#AccountNumbercheck').css("color", "red");
                        return false;
                    }

                    if ($('#ConfirmAccountNumber').val() == "") {
                        $('#ConfirmAccountNumbercheck').text('Confirm account number should be same as per account number');
                        $('#AccountNumbercheck').css("color", "red");
                        return false;
                    }

                    var x = $('#AccountNumber').val();
                    var y = $('#ConfirmAccountNumber').val();
                    if (x != y) {
                        $('#ConfirmAccountNumbercheck').text("Confirm account number should be same as per account number");
                        $('#AccountNumbercheck').css("color", "red");
                        return false;
                    }

                    if ($('#AccountNumber').val().length < 9) {
                        $('#AccountNumbercheck').text('Please Enter valid account number');
                        $('#AccountNumbercheck').css("color", "red");
                        return false;
                    }

                    if ($('#ConfirmAccountNumber').val().length < 9) {
                        $('#ConfirmAccountNumbercheck').text('Please Enter valid confirm account number');
                        $('#ConfirmAccountNumbercheck').css("color", "red");
                        return false;
                    }

                    var IfscCode = $('#IfscCode').val();
                    if (IfscCode.length != 11) {
                        $('#IfscCodecheck').text("Please enter 11 digit of Ifsc code.");
                        $('#IfscCodecheck').css("color", "red");
                        return false;
                    }

                    $.ajax({
                        type: "Post",
                        url: '../Info/MasterHandler.ashx?method=CheckIfcCode&IfcCode=' + IfscCode,
                        success: function (data) {
                            debugger;
                            if (data == "0") {
                                $('#IfscCodecheck').text("Invalid IFSC Code!");
                                $('#IfscCodecheck').css("color", "red");
                                return false;
                            } else {
                                $('#IfscCodecheck').text('');

                                // Proceed with form submission
                                $('#btnsubmit').hide();
                                $('#btnloadsubmit').show();

                                var code = $('#example13-digit-number').val();
                                if (code != "") {
                                    $.ajax({
                                        type: "POST",
                                        contentType: false,
                                        processData: false,
                                        url: baseurl + 'Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#example13-digit-number').val() + '&name=' + $('#name').val() + '&designation=' + $('#designation').val() + '&city=' + $('#city').val() + '&state=' + $('#State').val() + '&PinCode=' + $('#Pincode').val() + '&AccountNumber=' + $('#AccountNumber').val() + '&IfscCode=' + $('#IfscCode').val() + '&comp=CHERYL CHEMICAL AND POLYMERS&Comp_ID=Comp-1723' + "&Other_Role=" + $('#txtorganization').val(),
                                        success: function (data) {
                                           // alert(data);
                                            debugger;
                                            $('#btnsubmit').show();
                                            $('#btnloadsubmit').hide();
                                            if (data.split('~')[0] !== "failure") {
                                                window.scrollTo(0, 0);
                                                if (data.includes("invalid")) {
                                                    data = "0~The code is invalid <br> कोड अमान्य है";

                                                }
                                                if (data.indexOf("invalid") !== -1) {
                                                    data = data.split(".")[0];
                                                }

                                                $('#Chkfields').hide();
                                                $('#mobilefield').hide();
                                                $('#Otherfield').hide();
                                                $('#Chkcode').hide();
                                                $('#ShowMessage').show();
                                                $('#p3msg').html(data.split('~')[1]);
                                                $('#p3msg:contains("not")').css('color', 'black');
                                            } else if (data.split('~')[0] === "failure") {
                                                alert(data.split('~')[1]);
                                            } else {
                                                toastr.error('OTP is not valid. Please provide the valid OTP');
                                                $('#btnskyVerify1').attr('disabled', false);
                                            }
                                        }
                                    });
                                } else {
                                    $('#btnsubmit').attr('disabled', false);
                                }
                            }
                        }
                    });
                });



                $('#btnNext').click(function () {
                    window.location.href = 'https://www.hiifix.com/';
                });

            });

        </script>
    </head>

    <body>
        <div class="top-bar bg-white py-3">
            <div class="container">
                <div class="row align-items-center g-3">
                    <div class="col-xl-4 col-lg-4 col-md-12 logo-thing">
                        <a href="#">
                            <img style="height: 2.50rem;" src="assets/images/Hiffix/logo.png" alt="Logo" />
                        </a>
                    </div>
                    <div class="col-xl-8 col-lg-8 col-md-12">
                        <ul class="d-flex mb-0 gap-3 justify-content-end link-thing">
                            <li><a href="tel:7353000903" class="btn btn-sm btn-light"><i class="fa-solid fa-phone"></i> Call
                                    us</a></li>
                            <li><a href="mailto:cherly5600@gmail.com" class="btn"><i class="fa-solid fa-envelope"></i> Mail us</a></li>
                            <li><a href="assets/images/Hiffix/catalog.pdf" class="btn btn-primary" download>Brochure</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
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
                <img src="assets/images/Hiffix/banner.png" class="img-fluid banner" alt="">

                <div class="container">
                    <div class="row g-4">
                        <div class="col-12">
                        </div>
                        <div class="col-xxl-5 col-xl-5 col-lg-5 col-md-12">

                            <div class="product-heading2 text-end">
                                <!-- First Column -->

                                <h1 style="color: white;">Welcome to the world of
                                    Hiifix Adhesives</h1>

                            </div>
                            <div class="formplace">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="">Avail The Benifits</h5>
                                        <h5 class="">लाभ उठाने के लिए</h5>
                                        <hr>
                                        <div>
                                            <div class="mb-3">
                                                <div id="Chkcode">

                                                    <input type="text" id="example13-digit-number" class="form-control"
                                                        placeholder="Enter 13 digit code/13 अंकीय कोड दर्ज करें*" />
                                                    <h6 id="codecheck" class="invalid-feedback d-block"></h6>
                                                    <button type="button" id="btnnxt" data-toggle="modal"
                                                        class="form-buttom btn">
                                                        Next/अगला</button>
                                                    <button type="button" id="btnloadnxt" style="display: none"
                                                        data-toggle="modal" class="form-control login-btn">
                                                        <i class="fa fa-spinner fa-spin"></i>Loading..</button>
                                                    <h6 id="nextcheck"></h6>
                                                </div>
                                            </div>
                                            <div id="Chkfields">
                                                <div id="mobilefield">
                                                    <div class="mb-3">

                                                        <span class="">
                                                            <input type="text" maxlength="10" id="mobile"
                                                                onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
                                                                class="form-control"
                                                                placeholder="Mobile No/मोबाइल नंबर*" />
                                                        </span>
                                                        <h6 id="mobilecheck" class="invalid-feedback d-block"></h6>
                                                    </div>
                                                </div>
                                                <div id="Otherfield">


                                                    <div class="mb-3">
                                                        <input type="text" maxlength="40" id="name"
                                                            onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || (event.charCode == 32)"
                                                            class="form-control" placeholder="Name/नाम*" />
                                                        <h6 id="namecheck" class="invalid-feedback d-block"></h6>
                                                    </div>


                                                    <div class="mb-3">
                                                        <input type="text" minlegth="6" maxlength="6" id="Pincode"
                                                            placeholder="Pin code/पिन कोड*" onkeyup="getaddress()"
                                                            class="form-control" />
                                                        <h6 id="pincheck" class="invalid-feedback d-block"></h6>
                                                    </div>
                                                    <div class="mb-3">
                                                        <%-- <label for="city" class="form-label">City/शहर*</label>--%>
                                                            <input type="text" maxlength="40" id="city"
                                                                placeholder="City/शहर*" class="form-control" />
                                                            <h6 id="citycheck" class="invalid-feedback d-block"></h6>
                                                    </div>
                                                    <div class="mb-3">
                                                        <%--<label for="exampleInputtext6"
                                                            class="form-label">State/राज्य*</label>--%>
                                                            <input type="text" maxlength="40" id="State"
                                                                placeholder="State/राज्य*" class="form-control" />
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
                                                <div id="divbank">
                                                    <div class="mb-3">

                                                        <input type="text" minlength="9" maxlength="18"
                                                            id="AccountNumber"
                                                            placeholder="Account Details /खाता विवरण*"
                                                            onkeypress="return onlyNumberKey(event);"
                                                            class="form-control"  pattern="[0-9]+" title="only numbers" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
                                                        <h6 id="AccountNumbercheck" class="invalid-feedback d-block">
                                                        </h6>
                                                    </div>

                                                    <div class="mb-3">
                                                        <input type="text" minlength="9" maxlength="18"
                                                            id="ConfirmAccountNumber"
                                                            placeholder="Confirm account details /खाता विवरण की पुष्टि करें*"
                                                            onkeypress="return onlyNumberKey(event);"
                                                            class="form-control" pattern="[0-9]+" title="only numbers" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  />
                                                        <h6 id="ConfirmAccountNumbercheck"
                                                            class="invalid-feedback d-block"></h6>
                                                    </div>

                                                    <div class="mb-3">
                                                        <input type="text" maxlength="11" id="IfscCode"
                                                            placeholder="Ifsc Code /आईएफएससी कोड*"
                                                            onkeyup="getaddress()" class="form-control" />
                                                        <h6 id="IfscCodecheck" class="invalid-feedback d-block"></h6>
                                                    </div>
                                                </div>

                                                <div class="col-lg-12 p-1">
                                                    <button type="button" id="btnsubmit"
                                                        class="form-buttom btn">Next/अगला</button>
                                                    <button type="button" id="btnloadsubmit" style="display: none"
                                                        data-toggle="modal" class="form-control login-btn">
                                                        <i class="fa fa-spinner fa-spin"></i>Loading..</button>
                                                </div>
                                            </div>
                                            <div style="display: none;" id="ShowMessage">

                                                <div class="">
                                                    <p id="p3msg"
                                                        style="overflow: hidden; font-size: 15px !important; font-weight: 500; margin: 7px; margin-right: 7px;"
                                                        class="displayNone text-center">
                                                    </p>
                                                    <center>
                                                        <a href="javascript:void(0)"
                                                            style="color: black; font-size: medium" class=" "
                                                            id="btnNext">Close/बंद</a>
                                                    </center>
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
                            <div class="product-heading text-end">
                                <!-- First Column -->

                                <h1 style="color: white;">Welcome to the world of
                                    Hiifix Adhesives</h1>

                            </div>
                            <div class="product-img text-emd">
                                <!-- First Column -->

                                <img src="assets/images/Hiffix/product.png" class="img-fluid custom-img" alt="Image 6">
                            </div>



                        </div>

                    </div>
                </div>

            </div>
        </form>
        <div class="footer">
            <div class="container">
                <div class="row align-items-center">

                    <div class="col-md-6 foot-text ">
                        <p class="mb-0"><i class="fa-solid fa-globe"></i> Copyright © 2024 Hifix. All Rights
                            Reserved.</p>
                    </div>
                    <div class="col-md-6 text-end foot-links">
                        <a href="https://www.facebook.com/Hiifix/?ref=page_internal&mt_nav=0&_rdr" target="_blank"><i
                                class="fa-brands fa-facebook"></i></a>
                        <a href="https://youtube.com/@hiifix?si=YFRdz_W04AdIh3Gf" target="_blank"><i
                                class="fa-brands fa-youtube"></i></a>
                    </div>
                </div>
            </div>
        </div>


        <!-- bootstrap js -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>

    </html>