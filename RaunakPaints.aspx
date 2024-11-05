<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaunakPaints.aspx.cs" Inherits="RaunakPaints" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />

    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="Content/js/jquery-1.11.1.min.js"></script>
    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>
    <title>Raunaq Paints</title>
    <style>
        * {
            margin: 0px;
            padding: 0px;
            font-family: 'Poppins', sans-serif;
        }

        .marmo-solution {
            background-image: url(./assets/images/Raunak/bg-img.jpg);
            background-repeat: no-repeat;
            background-position: top;
            background-size: 100% 100%;
            width: 100%;
            position: relative;
            display: table;
            height: 100vh;
            padding-bottom: 10px;
        }

        .product-img {
            margin-top: 6%;
            width: 124%;
        }

        .marmo-solution .marmo-logo {
            width: 17%;
            padding: 10px 0px;
        }

        .first-heading {
            display: none;
        }



        .form-box {
            background-color: #e4e7ec8a;
            display: table;
            margin: auto;
            margin: auto;
            border-radius: 25px;
            border: 5px solid #f38321;
            padding-bottom: 30px;
            margin-bottom: 7%;
        }

            .form-box h5 {
                text-align: center;
                width: 100%;
                color: #fff;
                background-color: #f38321;
                padding: 30px 15px;
                border-bottom-right-radius: 70%;
                border-bottom-left-radius: 70%;
                margin: auto;
                border-top-left-radius: 23px;
                border-top-right-radius: 23px;
                margin-bottom: 35px;
                line-height: 29px;
                font-size: 18px;
            }

        .marmo-solution .form-box button {
            background-color: #f38321;
            color: #fff;
            margin-top: 5%;
            padding: 5px 32px;
        }

        .width-box {
            width: 75%;
            margin: auto;
        }

            .width-box input {
                border-radius: 50px;
                border: 3px solid #f38321;
                background-color: #e4e7ec;
                margin-bottom: 7px;
                font-size: 13px;
                padding: 8px 6px;
                transition-duration: 0.5s;
            }

                .width-box input:focus {
                    color: #212529;
                    background-color: #e4e7ec;
                    outline: 0;
                    box-shadow: 0px 0px 0px;
                    font-size: 13px;
                    border: 3px solid #00265a;
                }

        .icon1 {
            width: 18%;
        }

        .product-box-1 h1 {
            padding-top: 150px;
            display: table;
            font-size: 60px;
            font-weight: 700;
            display: inherit;
        }

        span {
            color: red;
            color: red;
        }

        .marmo-solution .marmo-product {
            width: 90%;
        }

        .footer-brand {
            text-decoration: none;
            display: flex;
            justify-content: center;
        }

        .icon-box .box {
            display: flex;
            background-color: #fff;
            width: 100%;
            padding: 10px 35px;
            box-sizing: border-box;
            border-radius: 50px;
            box-shadow: 0px 2px 8px #545151;
            align-items: center;
        }

            .icon-box .box img {
                width: 30%;
                padding: 10px 20px;
            }

        .position-box {
            position: absolute;
            bottom: -35px;
            width: 90%;
            margin: auto;
            left: 6%;
        }

        .box p {
            text-align: center;
        }

        .footer-brand h5 {
            position: absolute;
            bottom: 0;
        }


        @media screen and (width:280px) {
            .icon-box .box img {
                width: 45%;
            }

            .icon-box .box {
                padding: 9px 25px 0px 0px;
            }

            .position-box {
                margin-top: -65px !important;
            }
        }

        @media screen and (max-width:767px) {
            .marmo-solution .marmo-logo {
                width: 45%;
            }

            .position-box {
                position: initial;
                width: 100%;
                margin-top: -75px;
                left: 0%;
            }

            .icon-box .box {
                margin-bottom: 10px;
            }

            .marmo-solution .product-box {
                margin: initial !important;
            }

            .product-box-1 h1 {
                padding-top: 14px;
                display: table;
                font-size: 43px;
                font-weight: 700;
                display: inherit;
                text-align: center;
            }

            .product-img {
                margin-top: 6%;
                width: 100%;
                text-align: center;
            }

            .icon1 {
                width: 26%;
            }

            .form-box {
                margin-top: 4% !important;
            }

            .first-heading {
                display: block;
                margin-top: 7%;
            }

            .pro-2 {
                display: none;
            }
        }


        @media screen and (width:768px) {
            .marmo-solution .product-box {
                margin: 57% 0 0 auto !important;
            }

            .position-box .col-md-4 {
                width: 90%;
                margin: auto;
            }

            .icon-box .box img {
                width: 24%;
            }

            .icon-box .box {
                margin-bottom: 15px;
            }

            .product-box-1 h1 {
                padding-top: 145px;
                display: table;
                font-size: 47px;
                font-weight: 700;
                display: inherit;
            }

            .icon1 {
                width: 30%;
            }
        }

        @media screen and (min-width:820px)and (max-width:912px) {
            .marmo-solution .product-box {
                margin: 100% 0 0 auto;
                padding: 45px 47px;
                bottom: -30px;
                width: 100%;
                left: 0;
                display: flex;
                flex-direction: column;
            }

            .marmo-solution .marmo-product {
                width: 100%;
            }

            .position-box .col-md-4 {
                width: 90%;
                margin: auto;
            }

            .icon-box .box {
                margin-bottom: 15px;
            }

                .icon-box .box img {
                    width: 17%;
                }

            .marmo-solution .marmo-logo {
                width: 35%;
            }

            .product-box-1 h1 {
                padding-top: 145px;
                display: table;
                font-size: 47px;
                font-weight: 700;
                display: inherit;
            }

            .icon1 {
                width: 32%;
            }
        }

        @media screen and (width:912px) {
            .position-box {
                bottom: 100%;
                width: 90%;
                top: 65%;
            }
        }

        @media screen and (min-width:1024px) {
            .icon-box .box img {
                width: 18%;
                padding: initial;
            }

            .icon-box .box {
                padding: 10px 23px 10px 15px;
            }

            .marmo-solution .product-box {
                margin: 8% auto;
            }

            .position-box {
                bottom: -39px;
                width: 100%;
                left: 0%;
            }
        }

        @media screen and (width:1280px) {
            .position-box {
                bottom: 28px;
            }
        }

        @media screen and (min-width:1281px) {
            .position-box {
                bottom: -37px;
                width: 90%;
                left: 6%;
            }

            .marmo-solution .product-box {
                margin: 0%;
            }

            .icon-box .box {
                padding: 29px 31px 27px 20px;
            }
        }
    </style>

    <script>

        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }
        $('#otherfield').hide();
        //$("#btnnxt2").on('click', function () {
        function Getdata() {
            debugger;
            var mobileno = document.querySelector("#mobilenumber").value;
            var d = mobileno.slice(0, 1);
            var c = parseInt(d);

            if ($('#mobilenumber').val() == "") {
                toastr.error("Please enter mobile number");
                $('#btnsubmit').attr('disabled', false);
                return false;
            }

            if ($('#shopname').val() == "") {
                toastr.error("Please enter shop name");
                $('#btnsubmit').attr('disabled', false);
                return false;
            }
           


            if (mobileno.match(/[^$,.\d]/)) {
                toastr.error("Please enter numeric value for mobile No.");
                $('#mobilenumber').val() == "";
                $('#btnsubmit').attr('disabled', false);
                return false;
            }

            else {
                if (mobileno.length == 10) {


                    var codeone = getUrlVars()["codeone"];
                    var codetwo = getUrlVars()["codetwo"];

                    if (codeone == undefined && codetwo == undefined) {
                        var completeCode = $("#codeone").val();
                        var arr = completeCode.split('-');
                        codeone = arr[0];
                        codetwo = arr[1];
                    }

                    $.ajax({
                        type: "Post",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=AUCConsumerDetailsByMobileNo&MobileNo=' + $("#mobilenumber").val()+ '&codeone=' + codeone + '&codetwo=' + codetwo,
                        success: function (data) {

                            debugger;
                            if (c <= 5) {
                                toastr.error('Please Enter Valid Mobile No');
                                $('#mobilenumber').val('');
                                return false;
                            }
                            else {

                                var count = data.split('~');
                                var Name = data.split('~')[0];
                                var pin = data.split('~')[6];
                                var city = data.split('~')[2];
                                var shopname = data.split('~')[4];
                                if (Name != "") {
                                    $("#Name").val(Name);
                                    $("#Name").readOnly = true;
                                    document.getElementById('Name').readOnly = true;
                                    $('#DivBankDetails').hide();
                                }

                                if (pin != "") {
                                    $("#pin").val(pin);
                                    $("#pin").readOnly = true;
                                    document.getElementById('pin').readOnly = true;
                                    $('#DivBankDetails').hide();
                                }


                                if (city != "") {
                                    $("#city").val(city);
                                    $("#city").readOnly = true;
                                    document.getElementById('city').readOnly = true;
                                    $('#DivBankDetails').hide();
                                }
                                $('#ChkCode').hide();
                                $('#otherfield').show();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();

                                if (count.length > 7) {
                                    var BankName = data.split('~')[7];
                                    if (BankName == "") {
                                        $('#otherfield').show();
                                        $('#mobilefield').hide();
                                        $('#Chkfields').show();
                                        $('#DivBankDetails').show();
                                    }
                                    else
                                        $('#DivBankDetails').hide();
                                }
                                else
                                {
                                    $('#DivBankDetails').hide();
                                }

                            }
                        }
                    });
                }
            }


        }
        // });
        /* Auto Cash Transfer Start*/

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

        function GetIfscDetails() {
            debugger;
            var IfscCode = $('#IfscCode').val();


            if (!IfscCode.match(/[a-zA-Z0-9]*$/)) {
                toastr.error("Please enter alphanumeric value for Ifsc code.");
                $('#IfscCode').val() == "";
                $('#btnsubmit').attr('disabled', false);
                return false;
            }

            else {

                if (IfscCode.length == 11) {



                    $.ajax({
                        type: "Post",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=IFSC&ifsccode=' + $("#IfscCode").val(),
                        success: function (data) {

                            debugger;
                            if (data == '[]') {
                                toastr.error('Please Enter Valid IFSC code');

                                return false;
                            }


                        }
                    });
                }
            }


        }
        function ValidateAccount() {
            var AccountNumber = $('#AccountNumber').val();
            if (AccountNumber != undefined) {

                if ($('#AccountNumber').val().length < 1) {
                    toastr.error('Please Enter valid account number');
                    validate = false;
                }

            }

            var ConfirmAccountNumber = $('#ConfirmAccountNumber').val();
            if (ConfirmAccountNumber != undefined) {

                if ($('#ConfirmAccountNumber').val().length < 1) {
                    toastr.error('Please Enter valid confirm account number');
                    validate = false;
                }

            }
        }

        function ACNamevalid() {
            var name = $('#AccountHolderName').val();
            if (name != undefined) {

                if ($('#AccountHolderName').val().length < 1) {
                    toastr.error('Please Enter valid account holder name');
                    validate = false;
                }
                var matches = $('#AccountHolderName').val().match(/\d+/g);
                if (matches != null) {
                    toastr.error('account holder name should be alphabet only!');
                    validate = false;
                }
                var matches1 = $('#AccountHolderName').val().match(/[^a-zA-Z0-9 ]/);
                if (matches1 != null) {
                    toastr.error('account holder name should Not Contain any special sharacter!');
                    validate = false;
                }
            }
        }

        /* Auto Cash Transfer End*/


        function ValidateAlpha(evt) {
            var keyCode = (evt.which) ? evt.which : evt.keyCode
            if ((keyCode < 65 || keyCode > 90) && (keyCode < 97 || keyCode > 123) && keyCode != 32)

                return false;
            return true;
        }
        function onlyNumberKey(evt) {

            // Only ASCII character in that range allowed
            var ASCIICode = (evt.which) ? evt.which : evt.keyCode
            if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
                return false;
            return true;
        }
        function getaddress() {
            debugger;
            let pin = document.getElementById("pin").value;
            if (pin.length == 6) {
                $.getJSON("https://api.postalpincode.in/pincode/" + pin, function (data) {
                    createHTML(data);
                })
                function createHTML(data) {
                    if (data[0].Status == "Success") {
                        var city = "";
                        var state = "";
                        var pin = "";
                        debugger;

                        var city = data[0].PostOffice[0]['District'];
                        var state = data[0].PostOffice[0]['State'];
                        var Pin = data[0].PostOffice[0]['PinCode'];
                        $("#city").val(city);
                        if (pin == "") {
                            $("#pin").val();
                        }
                        else {
                            $("#pin").val(Pin);
                        }
                        $('#btnsubmit').attr('disabled', false);
                    }
                    else {
                        toastr.error("Please enter valid pin.");
                        $('#btnsubmit').attr('disabled', true);
                        return false;
                    }
                }
            }
        }
        function pinval() {
            debugger;
            var pin = $('#pin').val();
            if (pin != undefined) {

                if ($('#pin').val().length < 6) {
                    toastr.error('Please Enter valid Pin Code');
                    validate = false;
                }
                if (pin.match(/[^$,.\d]/)) {
                    toastr.error("Please enter numeric value for Pin Code.");
                    validate = false;
                }

                var matches1 = $('#pin').val().match(/[^a-zA-Z0-9 ]/);
                if (matches1 != null) {
                    toastr.error('Pin Code Should Not Contain any Special Character!');
                    validate = false;
                }
            }
        }

        function namevalid() {
            var name = $('#Name').val();
            if (name != undefined) {

                if ($('#Name').val().length < 1) {
                    toastr.error('Please Enter valid Name');
                    validate = false;
                    return false;
                }
                var matches = $('#Name').val().match(/\d+/g);
                if (matches != null) {
                    toastr.error('Name Should be alphabet only!');
                    //validate = false;
                    return false;
                }
                var matches1 = $('#Name').val().match(/[^a-zA-Z0-9 ]/);
                if (matches1 != null) {
                    toastr.error('Name Should Not Contain any Special Character!');
                    validate = false;
                    return false;
                }
            }
        }

        function cityvalid() {
            var city = $('#city').val();
            if (city != undefined) {

                if ($('#city').val().length < 1) {
                    toastr.error('Please Enter valid City');
                    validate = false;
                }
                var matches = $('#city').val().match(/\d+/g);
                if (matches != null) {
                    toastr.error('City Name Should be alphabet only!');
                    validate = false;
                }
                var matches1 = $('#city').val().match(/[^a-zA-Z0-9 ]/);
                if (matches1 != null) {
                    toastr.error('City Name Should Not Contain any Special Character!');
                    validate = false;
                }
            }
        }

        function valmobile() {
            var phoneNumber = $('#mobilenumber').val();

            if (phoneNumber != undefined) {
                if (phoneNumber.length < 10) {
                    toastr.error('Please Enter Valid Mobile Number');
                    return false;
                }
                if (phoneNumber.match(/[^$,.\d]/)) {
                    toastr.error("Please enter numeric value for mobile No.");
                    validate = false;
                    return false;
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
                    return false;
                }
            }
        }


        $(document).ready(function () {
            debugger;
            $('#ChkCode').show();
            $('#Chkfields').hide();
            $('#mobilefield').hide();
            firstfunction();
            var id = $('#HdnID').val();
            if (id == "1") {

                $('#ChkCode').show();
                $('#Chkfields').hide();
                $('#mobilefield').hide();
            }

            else if (id == "Raunak") {
                $('#ChkCode').hide();
                $('#otherfield').hide();
                $('#mobilefield').show();
                $('#Chkfields').hide();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $("#codeone").val(code);
            }
            $("#codeone").mask("99999-99999999");

            $("#btnnxt").on('click', function () {
                debugger;
                var codeone = $('#codeone').val();
                if (codeone != undefined) {

                    if ($('#codeone').val().length < 14) {
                        toastr.error('Please Enter valid Code');
                        validate = false;
                        return false;
                    }
                }
                $('#ChkCode').hide();
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
                                    $('#Chkfields').hide();
                                    $('#otherfield').hide();
                                    $('#mobilefield').show();
                                }
                            }
                        });
                    }
                });
                //}
            });

            $('#btnsubmit').on('click', function () {
                debugger;
                $('#btnsubmit').attr('disabled', true);
                var mobilenumber = $('#mobilenumber').val()
                var pincode = $('#pin').val()
                var d = mobilenumber.slice(0, 1);
                var c = parseInt(d);
                if (mobilenumber.match(/[^$,.\d]/)) {
                    toastr.error("Please enter numeric value for mobile No.");
                    $('#mobilenumber').val('');
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if (mobilenumber.length == 10 && c <= 5) {
                    // toastr.error("Please enter valid mobile No.");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if (mobilenumber.length != 10) {
                    toastr.error("Please enter 10 digit of mobile No.");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    var matches = $('#Name').val().match(/\d+/g);
                    if (matches != null) {
                        toastr.error('Name Should be alphabet only!');
                        $('#btnsubmit').attr('disabled', false);
                        $('#Name').val('');
                        return false;
                    }

                    if ($('#Name').val() == "") {
                        namevalid();
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    if (pincode.length != 6) {
                        pinval();
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    if ($('#pin').val() == "") {
                        pinval();
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    if ($('#city').val() == "") {
                        cityvalid();
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }

                    if ($('#shopname').val() == "") {
                        toastr.error("Please Enter Shop Name.");
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                }

                var dim = $('#DivBankDetails').is(":visible");
                if (dim == true) {

                    var AcHLength = $('#AccountHolderName').val();
                    if (!AcHLength.replace(/\s/g, '').length) {
                        toastr.error("Please enter valid account holder name .");
                        $("#btnsubmit").removeAttr("disabled");
                        return false;
                    }


                    if ($('#AccountHolderName').val() == "") {
                        ACNamevalid();

                        $("#btnsubmit").removeAttr("disabled");
                        return false;
                    }

                    if ($('#AccountNumber').val() == "") {

                        ValidateAccount();
                        $("#btnsubmit").removeAttr("disabled");
                        return false;
                    }

                    if ($('#ConfirmAccountNumber').val() == "") {

                        ValidateAccount();
                        $("#btnsubmit").removeAttr("disabled");
                        return false;
                    }


                    var x = $('#AccountNumber').val();
                    if (x.length < 9 || x.length > 18) {
                        toastr.error("Please enter valid account number .");
                        $("#btnsubmit").removeAttr("disabled");
                        return false;
                    }
                    var y = $('#ConfirmAccountNumber').val();
                    if (y.length < 9 || y.length > 18) {
                        toastr.error("Please enter valid confirm account number .");
                        $("#btnsubmit").removeAttr("disabled");
                        return false;
                    }

                    if (x == y) {

                    }
                    else {
                        toastr.error("Entered account number should be same in confirm account number field.");
                        $("#btnsubmit").removeAttr("disabled");
                        return false;
                    }

                    var IfscCode = $('#IfscCode').val();

                    if (IfscCode.length != 11) {
                        toastr.error("Please enter 11 digit of Ifsc code .");
                        $("#btnsubmit").removeAttr("disabled");
                        return false;
                    }
                    else {

                        if (!IfscCode.match(/[a-zA-Z0-9]*$/)) {
                            toastr.error("Please enter alphanumeric value for Ifsc code.");
                            $('#IfscCode').val() == "";
                            $('#btnsubmit').attr('disabled', false);
                            return false;
                        }



                    }
                    var chkboxValue = false;
                    if (!$('#chkbox').prop('checked')) {
                        toastr.error("Please accept temrs and condition to move ahead .");

                        $("#btnsubmit").removeAttr("disabled");
                        return false;
                    }
                    else
                        chkboxValue = true;


                }

                $('#p3msg').html('');
                if (code != "") {
                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&name=' + $('#Name').val() + '&city=' + $('#city').val() + '&PinCode=' + $('#pin').val() + '&SellerName=' + $('#shopname').val() + '&comp=' + $('#CompName').val() + '&Comp_ID=Comp-1496&AccountNumber=' + $('#AccountNumber').val() + '&IfscCode=' + $('#IfscCode').val() + '&AccountHolderName=' + $('#AccountHolderName').val() + '&TNC=' + chkboxValue,
                        success: function (data) {
                            debugger;
                            if (data == "Kindly enter valid IFSC code !.") {
                                toastr.error(data);
                                $("#btnsubmit").removeAttr("disabled");
                                return false;
                            }

                            else if (data.split('~')[0] !== "failure") {
                                window.scrollTo(0, 0);
                                if (data.indexOf("not valid") !== -1) {
                                    data = data.split(".")[0];
                                }
                                $('#head').hide();
                                $('#Chkfields').hide();
                                $('#CodeHeading').hide();
                                $('#fields').hide();
                                $('#ShowMessage').show();
                                $('#chkLine').hide();
                                $('#p3msg').html(data.split('~')[1]);
                                $('#p3msg:contains("not")').css('color', 'black');
                            }
                            else  if (data.split('~')[0] == "failure")
                            {
                                toastr.error(data.split('~')[1]);
                                $("#btnsubmit").removeAttr("disabled");
                                return false;
                            }
                            else {

                                $('#msgcoats').hide();
                                toastr.error('Something went wrong !.');
                                $('#btnskyVerify1').attr('disabled', false);

                            }
                        }
                    });
                }
                // }
                else {

                    $('#btnsubmit').attr('disabled', false);
                }
            });
            $('#btnNext').click(function () {
                window.location.href = 'http://www.raunaqenterprises.in/';
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
</head>
<body>
    <div class="marmo-solution">
        <header>
            <div class="container">
                <a href="http://www.raunaqenterprises.in/">
                    <img src="assets/images/Raunak/croma-logo.png" alt="marmo-logo" class="marmo-logo" /></a>
            </div>
        </header>
        <section>
            <div class="container">
                <div class="row">
                    <div class="product-box-1 first-heading animate__animated animate__backInDown">
                        <h1 style="font-size: 27px; margin-top: -7%;">Welcome To The<br />
                            <span>Raunaq Paint Industry</span> </h1>
                    </div>
                    <div class="col-md-4">
                        <div class="form-box mt-5 animate__animated animate__fadeInLeft">
                            <form runat="server">
                                <asp:HiddenField ID="hdnmob" runat="server" />
                                <asp:HiddenField ID="HdnID" runat="server" />
                                <asp:HiddenField ID="HdnCode1" runat="server" />
                                <asp:HiddenField ID="HdnCode2" runat="server" />
                                <asp:HiddenField ID="CompName" runat="server" />
                                <asp:HiddenField ID="long" runat="server" />
                                <asp:HiddenField ID="lat" runat="server" />
                                <div id="fields">
                                    <div class="row">
                                        <div class="col-12">
                                            <h5 class="text-uppercase">to check authenticity And Avail Benefits</h5>
                                        </div>
                                    </div>
                                    <div class="width-box">
                                        <div id="ChkCode">
                                            <div class="col-sm-12">
                                                <input type="text" maxlength="13" minlength="13" id="codeone" required class="form-control"  placeholder="Enter 13 Digit Code (13 अंकों का कोड दर्ज करे)  " style="font-size: 11px;" />
                                            </div>
                                            <div>
                                                <center>
                                                    <button type="button" data-toggle="modal" id="btnnxt" class="btn text-uppercase">Next</button>
                                                </center>
                                            </div>
                                        </div>
                                        <div id="mobilefield">
                                            <div class="col-12">
                                                <input type="text" maxlength="10" id="mobilenumber" minlength="10" required data-msg-required="Please Enter Your Moblie Number" class="form-control" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="Enter Mobile Number(मोबाइल नंबर दर्ज करें)" style="font-size: 11px;">
                                            </div>
                                            <div class="col-12">
                                                <input type="text" id="shopname" class="form-control" required placeholder="रिटेलर दुकान का नाम दर्ज करें " style="font-size: 11px;">
                                            </div>
                                            <div>
                                                <center>
                                                    <button type="button" data-toggle="modal" id="btnnxt2" onclick="Getdata()" class="btn text-uppercase">Next</button>
                                                </center>
                                            </div>
                                        </div>
                                        <div id="Chkfields">
                                            <div id="otherfield" style="display: none">
                                                <div class="col-12">
                                                    <input type="text" id="Name" class="form-control" required onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123)" style="font-size: 11px;" placeholder="Enter Name(नाम दर्ज करें )" style="font-size: 11px;">
                                                </div>
                                                <div class="col-12">
                                                    <input type="text" id="pin" class="form-control" onkeyup="getaddress()" required placeholder="Enter Pin Code(पिन कोड दर्ज करें )" style="font-size: 11px;">
                                                </div>
                                                <div class="col-12">
                                                    <input type="text" id="city" class="form-control" required placeholder="Enter City(शहर दर्ज करें )" style="font-size: 11px;">
                                                </div>

                                                 <%--Auto Cash Transfer Start--%>
                                                <div id="DivBankDetails" runat="server">
                                                <div class="col-12">
                                                    <!-- <label>NAME<sup>*</sup></label> -->
                                                    <input type="text" class="form-control" id="AccountHolderName" onkeypress="return ValidateAlpha(event);" placeholder="Bank Account Holder Name *" maxlength="30"/>
                                                </div>
                                                <div class="col-12">
                                                    <!-- <label>Your City<sup>*</sup></label> -->
                                                    <input type="password" placeholder="Bank Account Number*" id="AccountNumber" maxlength="18" data-msg-required="Please Enter Bank Account Number*" class="form-control" onkeypress="return onlyNumberKey(event);"/>
                                                </div>
                        
                                                <div class="col-sm-12">
                                                    <!-- <label> Dealer / Retailer<sup>*</sup></label> -->
                                                    <input type="text" placeholder="Confirm bank Account number*" maxlength="18" class="form-control" id="ConfirmAccountNumber" onkeypress="return onlyNumberKey(event)">
                                                </div>
                                                <div class="col-12">
                                                    <!-- <label>Your State<sup>*</sup></label> -->
                                                    <input type="text" placeholder="IFSC Code*" style="text-transform:uppercase;" onkeypress="return ValidateAlphaNumeric(event);" id="IfscCode" maxlength="11" onkeyup="GetIfscDetails()" data-msg-required="Please Enter Your IFSC Code*." class="form-control"/>
                                                </div>
                                                 <div class="col-12">
                                                    <!-- <label>Your State<sup>*</sup></label> -->
                                                    <input type="checkbox" id="chkbox" data-msg-required="Please select checkbox*" /><span style="color:#000000;"> Please Accept <a style="color:#000000; text-decoration:none;" href="TermsNCondtions.aspx" ><b>Terms and Conditions</b></a></span>
                                                </div>
                                                    </div>

                                                 <%--Auto Cash Transfer End--%>

                                            </div>
                                            <div class="col-12 text-center">
                                                <button type="Submit" id="btnsubmit" data-toggle="modal" class="btn text-uppercase">SUBMIT</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div style="display: none;" id="ShowMessage" class="row no-gutters pl-4 pr-4 textmessage">
                                    <center>
                                        <div class="col-md-12">
                                            <br />
                                            <div class="form-group" style="padding: 20px;">
                                                <p id="p3msg" style="overflow: hidden; color: black; font-size: 14px !important;" class="displayNone massage_box"></p>
                                            </div>
                                            <a href="javascript:void(0)" class="next_btn" id="btnNext"><b>Close</b></a>

                                        </div>
                                    </center>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-md-7">
                        <div class="product-box-1 animate__animated animate__backInDown">
                            <div class="pro-2">
                                <h1>Welcome To The<br />
                                    <span>Raunaq Paint Industry</span> </h1>
                            </div>
                            <div class="product-img">
                                <img src="assets/images/Raunak/1-product.png" alt="sticker" class="icon1" />
                                <img src="assets/images/Raunak/2-product.png" alt="sticker" class="icon1" />
                                <img src="assets/images/Raunak/3-product.png" alt="sticker" class="icon1" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 mt-5">
                <a class="footer-brand" href="http://www.raunaqenterprises.in/" target="_blank">
                    <h5 class="weblink" style="color: #212529; text-align: center; padding-bottom: 5px;">www.raunaqenterprises.in</h5>
                </a>
            </div>
        </section>
    </div>
</body>
</html>
