<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UPI-cashback.aspx.cs" Inherits="UPI_cashback" %>

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UPI cashback</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href=" https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/0.9.0/jquery.mask.min.js"></script>
    <!-- fav-icon -->
    <link rel="icon" type="image/x-icon" href="https://www.vcqru.com/NewContent/front-assets/img/fav-icon.svg" />
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <!-- font-family -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
        rel="stylesheet">

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap');

        body {
            font-family: "Poppins", sans-serif;
        }

        .landing-ui .container-fluid {
            padding: 0;
        }

        .landing-ui .card-left,
        .landing-ui .card-right {
            min-height: 100vh;
            width: 100%;
        }

        .landing-ui .card-left {
            padding: 3rem 10rem;
        }

            .landing-ui .card-left .logo {
                margin-bottom: 1.50rem;
            }

                .landing-ui .card-left .logo img {
                    height: 3rem;
                }

            .landing-ui .card-left .web-heading {
                margin-bottom: 1rem;
            }

                .landing-ui .card-left .web-heading .card-title {
                    margin-bottom: 0.75rem;
                    font-weight: 600;
                }

                .landing-ui .card-left .web-heading .card-text {
                    margin-bottom: 0;
                    color: #4B5563;
                    font-size: 14px;
                }

            .landing-ui .card-left .form-group .form-control {
                border-radius: 2px;
                background-color: #F3F4F6;
                font-weight: 600;
                padding: 0.75rem;
            }

                .landing-ui .card-left .form-group .form-control::placeholder {
                    color: #ADAAAF;
                }

            .landing-ui .card-left .form-group .form-label {
                font-size: 16px;
                font-weight: 600;
                color: #5F5E62;
                text-transform: capitalize;
            }

            .landing-ui .card-left .form-group .btn {
                width: 100%;
                border-radius: 2px;
                font-weight: 600;
                text-transform: uppercase;
                padding: 0.75rem;
            }

            .landing-ui .card-left .form-label span {
                color: var(--bs-danger);
            }

        .landing-ui .card-right {
            background: linear-gradient(300deg, rgb(13 110 253) 0%, rgb(86 154 255) 100%);
            position: relative;
            padding: 3rem 6rem;
        }

            .landing-ui .card-right::before {
                content: '';
                background-image: url('https://qa.vcqru.com/assets/images/patanjali/img/bg-right-card.svg');
                width: 100%;
                height: 100%;
                position: absolute;
                bottom: 0;
                left: 0;
                background-size: cover;
            }

            .landing-ui .card-right .card-title {
                margin-bottom: 1.5rem;
                font-weight: 700;
            }

            .landing-ui .card-right ul {
                list-style: none;
                padding: 0;
                margin-bottom: 0;
                display: flex;
                flex-direction: column;
                gap: 1.50rem;
            }

                .landing-ui .card-right ul li {
                    display: flex;
                    align-items: start;
                    gap: 1rem;
                }

                    .landing-ui .card-right ul li i {
                        font-size: 20px;
                        color: #fff;
                        background-color: rgba(255, 255, 255, 0.5);
                        border-radius: var(--bs-border-radius-pill);
                        height: 1.5rem;
                        min-width: 1.5rem;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

            .landing-ui .card-right .card-right-content {
                position: relative;
                z-index: 1000;
                color: var(--bs-white);
            }

            .landing-ui .card-right ul li h5 {
                margin-bottom: 0.25rem;
            }

            .landing-ui .card-right ul li p {
                margin-bottom: 0;
                font-size: 14px;
            }

        .landing-ui .card-left .success-msg {
            padding: 2rem;
            background-color: rgba(52, 199, 89, 16%);
            border-radius: var(--bs-border-radius-lg);
            border: 1px solid #34C759;
            text-align: center;
            margin-top: 1.50rem;
        }

        @media screen and (max-width:768px) {
            .landing-ui .card-right,
            .landing-ui .card-left {
                padding: 2rem;
                min-height: auto;
            }
        }
    </style>
    <script type="text/javascript">
        // it is the variable initialized for the location purpose.


        var Codeone = "";
        var Codetwo = "";
        var comp = "";
        var Id = "";
        var baseurl = "https://www.vcqru.com/";
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

            var mobileno = document.querySelector("#mobile").value;
            var d = mobileno.slice(0, 1);
            var c = parseInt(d);

            if (mobileno.match(/[^$,.\d]/)) {
                toastr.error("Please enter numeric value for mobile No.");
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
                             //alert(data);

                            if (c <= 5) {
                                toastr.error('Please Enter Valid Mobile No');
                                $('#mobile').val('');
                                return false;
                            }
                            else {

                                var count = data.split('~');
                                var Name = data.split('~')[0];
                                var pin = data.split('~')[6];
                                var city = data.split('~')[2];
                                var state = data.split('~')[3];
                                var UPI = data.split('~')[11];
                                var pancard_number = data.split('~')[16];

                                if (Name != "") {
                                    $("#name").val(Name);
                                    $("#name").attr("readonly", true);
                                }
                                /*Auto Cash Transfer Start */
                                else {
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#mobilefield').hide();
                                    $("#name").attr("readonly", false);


                                }
                                
                                if (UPI != "") {
                                    $("#UPI").val(UPI);
                                    $("#UPI").attr("readonly", true);
                                }
                                else {
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#mobilefield').hide();
                                    $("#UPI").attr("readonly", false);
                                }


                                if (UPI != "" && UPI != "") {
                                    $('#Otherfield').hide();
                                }


                            }
                        }
                    });
                }
            }


        }

        function getaddress() {

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
        function valUpiID() {
            var UpiID = $('#UPI').val();
            if (UpiID.charAt(0) === ' ') {
                $('#upicheck').html("Please Enter Valid UPI ID");
                $('#upicheck').css("color", "red");
                return false;
            }
            if (UpiID == "") {
                $('#upicheck').html("Please Enter Valid UPI ID");
                $('#upicheck').css("color", "red");
                return false;
            }
            var filter = /^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$/;
            if (!filter.test(UpiID)) {
                $('#upicheck').html("Please Enter Valid UPI ID");
                $('#upicheck').css("color", "red");
                return false;
            }
            else {
                $('#upicheck').hide();
                $('#upicheck').html("");
                $('#upicheck').css("color", "purple");
            }
        }

        function valPancard() {
            var Pan = $('#pancard_number').val();
            if (Pan.charAt(0) === ' ') {
                $('#pancheck').html("*Please Enter Valid Pan ID");
                $('#pancheck').css("color", "red");
                return false;
            }
            if (Pan == "") {
                $('#pancheck').html("*Please Enter Valid Pan ID");
                $('#pancheck').css("color", "red");
                return false;
            }
            var filter = /^[A-Z]{5}[0-9]{4}[A-Z]$/;
            if (!filter.test(Pan)) {
                $('#pancheck').html("*Please Enter Valid Pan ID");
                $('#pancheck').css("color", "red");
                return false;
            }
            else {
                $('#pancheck').hide();
                $('#pancheck').html("");
                $('#pancheck').css("color", "purple");
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

            else if (id == "VCQRU") {
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
            debugger;
            $("#btnnxt").on('click', function (e) {
                e.preventDefault();


                var codeone = $('#example13-digit-number').val();

                if (codeone == "" || codeone == undefined) {
                    $('#codecheck').html('Please Enter 13 Digit Code');
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
                                if (data.split('&')[1] == "VCQRU" || data.split('&')[1] == "" || data.split('&')[1] == undefined) {
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
            $('#UPI').keyup(function () {
                $('#upicheck').hide();
                $('#upicheck').html("");
                $('#upicheck').css("color", "white");

            });
            $('#pancard_number').keyup(function () {
                $('#pancheck').hide();
                $('#pancheck').html("");
                $('#pancheck').css("color", "white");

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
                        $('#pincheck').html("Please Enter  Pincode");
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
                /**/
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
                /**/
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
            //$('#UPI').keyup(function () {
            //    Upi_check();

            //});

            // validation for the upi
            $('#UPI').keyup(function () {
                valUpiID();

            });

            //function Upi_check() {

            //    var upi = $('#UPI').val();
            //    if ($('#UPI').val().match('^[0-9A-Za-z.-]{2,256}@[A-Za-z]{2,64}$')) {
            //        $('#upicheck').hide();
            //    }

            //    else {
            //        $('#upicheck').show();
            //        $('#upicheck').html("**Please enter valid UPI ID");
            //        $('#upicheck').css("color", "red");
            //        Upi_err = false;
            //        return false;
            //    }
            //}

            // validation for the pancard
            $('#pancard_number').keyup(function () {
                validatePan();

            });

            function validatePan(pan) {
                // Regular expression for PAN validation
                //var pattern = /^[A-Z]{5}[0-9]{4}[A-Z]$/;
                var pattern = /^[A-Z]{5}[0-9]{4}[A-Z]$/;
                return pattern.test(pan);
            }

            // Example usage:
            var panNumber = "ABCDE1234F";
            var isValidPan = validatePan(panNumber);

            if (isValidPan) {
                console.log("PAN is valid.");
            } else {
                console.log("Invalid PAN.");
            }

            $('#btnsubmit').on('click', function (e) {
                e.preventDefault();

                var mobileone = $('#mobile').val();

                if (mobileone == "" || mobileone == undefined) {

                    $('#mobilecheck').html('Please Enter Mobile Number');
                    $('#mobilecheck').css("color", "red");
                    return false;
                }
                if (mobileone.length != 10) {
                    $('#mobilecheck').html('Please Enter Mobile Number');
                    $('#mobilecheck').css("color", "red");
                    return false;
                }
                else {
                    $('#mobilecheck').text('');
                }

                var Name = $('#name').val();
                if (Name == "" || Name == undefined || Name.charAt(0) === ' ') {
                    $('#namecheck').html('Please Enter Name');
                    $('#namecheck').css("color", "red");
                    return false;
                }
                else {
                    $('#namecheck').text('');

                }
                //var pincode = $('#Pincode').val();
                //if ($('#Pincode').val() == "" || pincode == undefined) {
                //    $('#pincheck').html('Please Enter pincode');
                //    $('#pincheck').css("color", "red");
                //    pinval();
                //    $('#city').val() == "";
                //    $('#State').val() == "";
                //    $('#btnsubmit').attr('disabled', false);
                //    return false;
                //}
                //else {
                //    $('#pincheck').text('');

                //}

                //var City = $('#city').val();
                //if (City == "" || City == undefined || City.charAt(0) === ' ') {
                //    $('#citycheck').html('Please Enter City');
                //    $('#citycheck').css("color", "red");
                //    $('#btnsubmit').attr('disabled', false);
                //    return false;
                //}
                //else {
                //    $('#citycheck').text('');
                //}
                //var State = $('#State').val();
                //if (State == "" || State == undefined || State.charAt(0) === ' ') {
                //    $('#statecheck').html('Please Enter State');
                //    $('#statecheck').css("color", "red");
                //    $('#btnsubmit').attr('disabled', false);
                //    return false;
                //}
                //else {
                //    $('#statecheck').text('');
                //}
                //var pancard_number = document.getElementById('pancard_number').value;
                ////if ($('#pancard_number').val() == "") {
                ////    valPancard();
                ////    $('#btnsubmit').attr('disabled', false);
                ////    return false;



                ////}
                //alert(UPI);
                //if (pancard_number != "") {
                //    var check = validatePancard(pancard_number);

                //    if (check != true) {
                //        $('#pancheck').html("**Please Enter Valid Pan ID");
                //        $('#pancheck').css("color", "red");
                //        $('#btnsubmit').attr('disabled', false);
                //        return false;
                //    }
                //    else {
                //        $('#pancheck').text('');
                //    }
                //}
                //var Pancard = $('#Pancard').val();
                //if (Pancard == "" || Pancard == undefined || Pancard.charAt(0) === ' ') {
                //    $('#pancheck').html('Please Enter Valid Pancard NO');
                //    $('#pancheck').css("color", "red");
                //    $('#btnsubmit').attr('disabled', false);
                //    return false;
                //}
                //else {
                //    $('#pancheck').text('');
                //}

                var UPI = document.getElementById('UPI').value;
                if ($('#UPI').val() == "") {
                    valUpiID();
                    $('#btnsubmit').attr('disabled', false);
                    return false;



                }
                //alert(UPI);
                if (UPI != "") {
                    var check = validateUPI(UPI);

                    if (check != true) {
                        $('#upicheck').html("Please Enter Valid UPI ID");
                        $('#upicheck').css("color", "red");
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    else {
                        $('#upicheck').text('');
                    }
                }

                $('#btnsubmit').hide();
                $('#btnloadsubmit').show();

                var code = $('#example13-digit-number').val();
                //alert(code);
                if (code != "") {
                    // alert("dfef");


                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: baseurl + 'Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#example13-digit-number').val() + '&name=' + $('#name').val() + '&city=' + $('#city').val() + '&state=' + $('#State').val() + '&PinCode=' + $('#Pincode').val() + '&UPI=' + $('#UPI').val() + '&pancard_number=' + $('#pancard_number').val() + '&comp=VCQRU&Comp_ID=Comp-1218',
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
                                $('#p3msg:contains("not")');
                            }
                            else if (data.split('~')[0] === "failure") {
                                //  alert(data.split('~')[1])
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
                window.location.href = ' https://www.vcqru.com/';
            });

        });
        function validateUPI(UPI) {
            var re = /^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}\d{0,50}$/;
            return re.test(UPI);
        }

        function UPICheck() {
            // 

            //var Email = $('#mail').val();
            var UPI = document.getElementById('UPI').value;

            if (UPI != "") {
                var check = validateUPI(UPI);

                if (check != true) {
                    /* toastr.error('Please Enter a Valid UPI ID');*/
                    $('#upicheck').html("Please Enter Valid UPI ID");
                    $('#upicheck').css("color", "red");
                    return false;
                }
                else if (check == true) {
                    $('#UPI').html("");
                    $('#UPI').hide();
                }
            }


        }
        function validatePancard(pancard_number) {
            var re = /^[A-Z]{5}[0-9]{4}[A-Z]$/;
            return re.test(pancard_number);
        }

        function PancardCheck() {
            // 

            //var Email = $('#mail').val();
            var pancard_number = document.getElementById('pancard_number').value;

            if (pancard_number != "") {
                var check = validatePancard(pancard_number);

                if (check != true) {
                    /* toastr.error('Please Enter a Valid UPI ID');*/
                    $('#pancheck').html("**Please Enter Valid Pan ID");
                    $('#pancheck').css("color", "red");
                    return false;
                }
                else if (check == true) {
                    $('#pancard_number').html("");
                    $('#pancard_number').hide();
                }
            }


        }

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
        <asp:HiddenField ID="hdnmob" runat="server" />
        <asp:HiddenField ID="HdnID" runat="server" />
        <asp:HiddenField ID="HdnCode1" runat="server" />
        <asp:HiddenField ID="HdnCode2" runat="server" />
        <asp:HiddenField ID="CompName" runat="server" />
        <asp:HiddenField ID="long" runat="server" />
        <asp:HiddenField ID="lat" runat="server" />
        <section class="landing-ui">
            <div class="container-fluid">
                <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 row-cols-1 g-0">
                    <div class="col d-flex order-lg-1 order-2">
                        <div class="card-left">
                            <div class="logo">
                                <a href="https://www.vcqru.com/">
                                    <img src="https://www.vcqru.com/newContent/front-assets/img/vcqru-logo.png"
                                        alt="logo">
                                </a>
                            </div>
                            <div class="row row-cols-1 g-3">
                                <div class="col">
                                    <div class="web-heading">
                                        <h5 class="card-title">To Avail Benifits/लाभ उठाने के लिए</h5>
                                        <p class="card-text">
                                            Welcome to the Official VCQRU Loyalty Cashback Page
                                        </p>
                                    </div>
                                </div>
                                <div class="col" id="Chkcode">
                                    <div class="row row-cols-1 g-3">
                                        <div class="col">
                                            <div class="form-group">
                                                <label for="codeNumber" class="form-label">
                                                    13 Digit Code /13 अंकीय कोड
                                                        <span>*</span></label>
                                                <input type="text" placeholder="52258-87896578"
                                                    id="example13-digit-number" class="form-control" />
                                                <div id="codecheck" class="invalid-feedback d-block"></div>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-group">
                                                <button type="button" id="btnnxt"
                                                    class="btn btn-primary">
                                                    Next</button>
                                                <button type="button" id="btnloadnxt" style="display: none"
                                                    class="btn btn-primary">
                                                    <i
                                                        class="fa fa-spinner fa-spin"></i>Loading..</button>
                                            </div>
                                        </div>
                                        <div class="col m-0">
                                            <div class="form-group">
                                                <div id="nextcheck"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col" id="Chkfields">
                                    <div class="row row-cols-1 g-3">
                                        <div class="col" id="mobilefield">
                                            <div class="form-group">
                                                <label for="mobile" class="form-label">
                                                    Mobile No
                                                        <span>*</span></label>
                                                <input type="text" placeholder="Enter your mobile number"
                                                    maxlength="10" id="mobile" onkeyup="Getdata()"
                                                    onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
                                                    class="form-control" />
                                                <div id="mobilecheck" class="invalid-feedback d-block"></div>
                                            </div>
                                        </div>
                                        <div class="col" id="Otherfield">
                                            <div class="row row-cols-1 g-3">
                                                <div class="col">
                                                    <div class="form-group">
                                                        <label for="name" class="form-label">
                                                            Name
                                                                <span>*</span></label>
                                                        <input type="text" placeholder="Enter your name"
                                                            maxlength="40" id="name"
                                                            onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || (event.charCode == 32)"
                                                            class="form-control" />
                                                        <div id="namecheck" class="invalid-feedback d-block"></div>
                                                    </div>
                                                </div>
                                                
                                                <div class="col">
                                                    <div class="form-group">
                                                        <label for="UPI" class="form-label">
                                                            UPI
                                                                <span>*</span></label>
                                                        <input type="text" maxlength="30" class="form-control"
                                                            id="UPI" placeholder="Enter your UPI ID" required>
                                                        <div id="upicheck" class="invalid-feedback d-block"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-group">
                                                <button type="button" id="btnsubmit"
                                                    class="btn btn-primary">
                                                    submit</button>
                                                <button type="button" id="btnloadsubmit" style="display: none"
                                                    class="btn btn-primary">
                                                    <i
                                                        class="fa fa-spinner fa-spin"></i>Loading..</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col" id="ShowMessage" style="display: none;">
                                    <div class="success-msg">
                                        <p id="p3msg"></p>
                                        <a href="javascript:void(0)" id="btnNext">Close</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col d-flex order-lg-2 order-1">
                        <div class="card-right">
                            <div class="card-right-content">
                                <h4 class="card-title">Get Instant Loyalty Cashback, Follow These Simple Steps:</h4>
                                <ul>
                                    <li>
                                        <i class="bx bx-check"></i>
                                        <div>
                                            <h5> Scan QR Code</h5>
                                            <p>
                                                Use your mobile device to scan the provided QR code.
                                            </p>
                                        </div>
                                    </li>
                                    <li>
                                        <i class="bx bx-check"></i>
                                        <div>
                                            <h5>Enter the mobile number</h5>
                                            <p>
                                                Input your mobile number in the designated field.
                                            </p>
                                        </div>
                                    </li>
                                     <li>
                                        <i class="bx bx-check"></i>
                                        <div>
                                            <h5>Enter UPI ID and Account Holder Name</h5>
                                            <p>
                                               Provide your UPI ID and  the account holder's name as required.
                                            </p>
                                        </div>
                                    </li>
                                       <li>
                                        <i class="bx bx-check"></i>
                                        <div>
                                            <h5>Submit</h5>
                                            <p>
                                             Click the submit button.
                                             Your cashback will be credited to your bank account instantly.
                                            </p>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </section>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    </form>
</body>

</html>
