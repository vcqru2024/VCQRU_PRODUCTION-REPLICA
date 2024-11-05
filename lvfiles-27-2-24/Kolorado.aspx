<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Kolorado.aspx.cs" Inherits="Karlodo" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <title>Vcqru</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/ulg/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />

    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="Content/js/jquery-1.11.1.min.js"></script>
    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>


    <style type="text/css">
        .bg h2 {
            padding: 18px 0 0 0;
            /*text-align: center;*/
        }

        #wlink {
            font-weight: 700;
            padding: 10px 0;
            text-align: center;
        }

            #wlink a {
                color: #fff;
            }

        form {
            background: #FF5722;
            border-radius: 16px;
            padding: 27px 23px;
            margin-bottom: 15px;
            margin-top: 30px;
            box-shadow: 0px 0px 13px #eaa27b;
        }


        h2.heading {
            padding: 0px 0px 15px 0px;
            text-align: center;
            font-size: 24px;
        }

        .form-control::placeholder {
            font-size: 12px;
            font-weight: 600;
        }

        .form-control {
            transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
        }

        button.btn.btn-primary {
            background: #5e2606;
            border: navajowhite;
            outline: none;
        }

        .btn-primary {
            height: calc(2.45em + 0.75rem + 2px);
            width: 100%;
        }

        .heading {
            color: #fff;
        }

        .bg {
            position: relative;
            background-position: top;
            height: 100vh;
            background-size: 100% 100%;
            background-repeat: no-repeat;
            width: 100%;
            display: table;
            background-image: url(../assets/images/karlodo/background.png);
            /*margin: 0px 0px -17% 0px;*/
        }

        .img-right {
            max-width: 89%;
            padding: 10px;
        }

        .body-bakground img {
            position: absolute;
            right: 0;
            width: 86%;
            bottom: 0;
            top: 0px;
            height: 100vh;
        }


        form h2 {
            font-size: 64px;
        }

        #welcome {
            margin-left: 106px;
        }

        footer {
            background: #ff5722;
            position: absolute;
            bottom: -40px;
            color: #fff;
            text-align: center;
            width: 100%;
            height: 40px;
        }

        .tex {
            padding-top: 36px;
        }

        footer p {
            margin-bottom: 0px;
        }

        header {
            padding: 0px 0px 20px 0px;
        }


        @media screen and (max-width: 767px) {


            .body-bakground img {
                height: 100%;
                width: initial;
                z-index: -1 !important;
            }

            form {
                border: 3px solid #fff;
            }

            .img-right {
                margin-top: 26%;
            }
        }

        @media only screen and (min-width: 768px) and (max-width: 1004px) {

            .body-bakground img {
                height: initial;
                width: initial;
            }

            form {
                border: 3px solid #fff;
            }
        }

        @media only screen and (width: 280px) {
            .img-right {
                margin-top: 55%;
            }
        }

        @media only screen and (min-width: 768px) {
            .body-bakground img {
                width: initial;
                z-index: -1;
            }
        }

        @media only screen and (width: 1280px) {
            .img-right {
                max-width: 96%;
                padding: 10px;
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

            if ($('#shopname').val() == "") {
                toastr.error("Please Enter Shop Name.");
                $('#btnsubmit').attr('disabled', false);
                return false;
            }

            if ($('#shopname').val().replace(/\s+/g, '').length == 0) {
                toastr.error("Please Enter Shop Name.");
                $('#shopname').focus();
                $('#shopname').val('');
                $('#btnsubmit').attr('disabled', false);
                return false;
            }

            if ($('#mobilenumber').val() == "") {
                toastr.error("Please enter mobile number");
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

                    var codes = $('#codeone').val();
                    var code1 = codes.split('-')[0];
                    var code2 = codes.split('-')[1];
                    $.ajax({
                        type: "Post",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNo2&MobileNo= ' + $("#mobilenumber").val() + '&codeone= ' + code1 + '&codetwo= ' + code2,
                        success: function (data) {


                            if (c <= 5) {
                                toastr.error('Please Enter Valid Mobile No');
                                $('#mobilenumber').val('');
                                return false;
                            }
                            else {


                                var Name = data.split('~')[0];
                                var pin = data.split('~')[6];
                                var city = data.split('~')[2];
                                var shopname = data.split('~')[4];
                                var BankName = data.split('~')[7];
                                var AccountNumber = data.split('~')[8];
                                var IfscCode = data.split('~')[9];
                                var AccountHolderName = data.split('~')[10];
                                var BranchName = data.split('~')[11];

                                if (Name != "") {
                                    $("#Name").val(Name);
                                    $("#Name").readOnly = true;
                                    document.getElementById('Name').readOnly = true;
                                }
                                else {
                                    $('#ChkCode').hide();
                                    $('#otherfield').show();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#DivBankDetails').hide();
                                }

                                if (pin != "") {
                                    $("#pin").val(pin);
                                    $("#pin").readOnly = true;
                                    document.getElementById('pin').readOnly = true;
                                }
                                else {
                                    $('#ChkCode').hide();
                                    $('#otherfield').show();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#DivBankDetails').hide();
                                }


                                if (city != "") {
                                    $("#city").val(city);
                                    $("#city").readOnly = true;
                                    document.getElementById('city').readOnly = true;
                                }
                                else {
                                    $('#ChkCode').hide();
                                    $('#otherfield').show();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#DivBankDetails').hide();
                                }



                                if (AccountNumber == "") {
                                    $('#otherfield').show();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#DivBankDetails').show();
                                }
                                else {
                                    $('#AccountNumber').val(AccountNumber);
                                    $('#ConfirmAccountNumber').val(AccountNumber);
                                    document.getElementById("AccountNumber").readOnly = true;
                                }
                                if (IfscCode == "") {
                                    $('#otherfield').show();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#DivBankDetails').show();
                                }
                                else {
                                    $('#IfscCode').val(IfscCode);
                                    document.getElementById("IfscCode").readOnly = true;
                                }
                                if (AccountHolderName == "") {
                                    $('#otherfield').show();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#DivBankDetails').show();
                                }
                                else {
                                    $('#AccountHolderName').val(AccountHolderName);
                                    document.getElementById("AccountHolderName").readOnly = true;
                                }

                                //if (Name != "" && pin != "" && city != "") {
                                //    $('#otherfield').hide();
                                //    $('#mobilefield').hide();
                                //    $('#Chkfields').show();
                                //    $('#DivBankDetails').show();
                                //}
                                // if (AccountNumber != "" && IfscCode != "" && AccountHolderName!="") {
                                //    $('#otherfield').show();
                                //    $('#mobilefield').hide();
                                //    $('#Chkfields').show();
                                //    $('#DivBankDetails').show();
                                //}
                                //if (AccountNumber != "" && IfscCode != "" && AccountHolderName != "" && Name != "" && pin != "" && city != "") {
                                //    $('#otherfield').show();
                                //    $('#mobilefield').hide();
                                //    $('#Chkfields').show();
                                //    $('#DivBankDetails').hide();
                                //}

                            }
                        }
                    });
                }
            }


        }
        // });

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
                        //$('#btnsubmit').attr('disabled', true);
                        return false;
                    }
                }
            }
        }


        function ValidateAccount() {
            var AccountNumber = $('#AccountNumber').val();
            if (AccountNumber != undefined) {

                if ($('#AccountNumber').val().length < 1) {
                    toastr.error('Please Enter valid account number');
                    return false;
                }

            }

            var ConfirmAccountNumber = $('#ConfirmAccountNumber').val();
            if (ConfirmAccountNumber != undefined) {

                if ($('#ConfirmAccountNumber').val().length < 1) {
                    toastr.error('Please Enter valid confirm account number');
                    return false;
                }

            }
        }

        function ACNamevalid() {
            var name = $('#AccountHolderName').val();
            if (name != undefined) {

                if ($('#AccountHolderName').val().length < 1) {
                    toastr.error('Please Enter valid account holder name');
                    return false;
                }
                var matches = $('#AccountHolderName').val().match(/\d+/g);
                if (matches != null) {
                    toastr.error('account holder name should be alphabet only!');
                    return false;
                }
                var matches1 = $('#AccountHolderName').val().match(/[^a-zA-Z0-9 ]/);
                if (matches1 != null) {
                    toastr.error('account holder name should Not Contain any special sharacter!');
                    return false;
                }
            }
        }




        function pinval() {

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

            $('#ChkCode').show();
            $('#Chkfields').hide();
            $('#mobilefield').hide();
            $('#DivBankDetails').hide();
            firstfunction();
            var id = $('#HdnID').val();
            if (id == "1") {

                $('#ChkCode').show();
                $('#Chkfields').hide();
                $('#mobilefield').hide();
            }

            else if (id == "Kolorado") {
                $('#ChkCode').hide();
                $('#otherfield').hide();
                $('#mobilefield').show();
                $('#Chkfields').show();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $("#codeone").val(code);
            }
            $("#codeone").mask("99999-99999999");

            $("#btnnxt").on('click', function () {

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

                                if (data.split('&')[0] === "1" && data.split('&')[1] === "Auto Max India") {
                                }
                                else {
                                    $('#CompName').val(data.split('&')[1]);
                                    if ($('#CompName').val() == "The Kolorado  Paints" || $('#CompName').val() == "" || $('#CompName').val() == undefined) {
                                        $('#ChkCode').hide();
                                        $('#Chkfields').show();
                                        $('#otherfield').hide();
                                        $('#mobilefield').show();
                                    }
                                    else {
                                        $('#ChkCode').show();
                                        $('#Chkfields').hide();
                                        $('#otherfield').hide();
                                        $('#mobilefield').hide();
                                        toastr.info('Invalid Code');
                                        return false;
                                    }

                                }
                            }
                        });
                    }
                });
                //}
            });

            $('#btnsubmit').on('click', function (e) {
                e.preventDefault();

                //$('#btnsubmit').attr('disabled', true);
                var mobilenumber = $('#mobilenumber').val()
                var pincode = $('#pin').val()
                var d = mobilenumber.slice(0, 1);
                var c = parseInt(d);

                if ($('#shopname').val() == "") {
                    toastr.error("Please Enter Shop Name.");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if ($('#shopname').val().replace(/\s+/g, '').length == 0) {
                    toastr.error("Please Enter Shop Name.");
                    $('#shopname').focus();
                    $('#shopname').val('');
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }

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

                    if ($('#Name').val().replace(/\s+/g, '').length == 0) {
                        toastr.error("Please Enter Your Name.");
                        $('#Name').focus();
                        $('#Name').val('');
                        $('#btnsubmit').attr('disabled', false);
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

                    if ($('#AccountHolderName').val().replace(/\s+/g, '').length == 0) {
                        toastr.error("Please Enter Account Holder Name.");
                        $('#AccountHolderName').focus();
                        $('#AccountHolderName').val('');
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }

                    if ($('#AccountHolderName').val() == "") {
                        ACNamevalid();
                        // $('#btnsubmit').attr('disabled', false);
                        return false;
                    }

                    if ($('#AccountNumber').val() == "") {

                        ValidateAccount();
                        // $('#btnsubmit').attr('disabled', false);
                        return false;
                    }

                    if ($('#ConfirmAccountNumber').val() == "") {

                        ValidateAccount();
                        // $('#btnsubmit').attr('disabled', false);
                        return false;
                    }

                    var x = $('#AccountNumber').val();
                    var y = $('#ConfirmAccountNumber').val();
                    if (x == y) {

                    }
                    else {
                        toastr.error("Entered account number should be same in confirm account number field.");;

                        // $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    if ($('#AccountNumber').val().length < 9) {
                        toastr.error('Please Enter valid account number');
                        return false;
                    }

                    if ($('#ConfirmAccountNumber').val().length < 9) {
                        toastr.error('Please Enter valid confirm account number');
                        return false;
                    }

                    var IfscCode = $('#IfscCode').val();

                    if (IfscCode.length != 11) {
                        toastr.error("Please enter 11 digit of Ifsc code .");
                        // $('#btnsubmit').attr('disabled', false);
                        return false;
                    }

                    if (IfscCode.length == 11) {

                        var reg = /[A-Z|a-z]{4}[0][0-9|A-Z|a-z]{6}$/;
                        if (!IfscCode.match(reg)) {

                            toastr.error("Please enter valid IFSC code(First 4 alphabet then zero then other ).");
                            return false;
                        }
                        else {
                            //ValidateIfccode(IfscCode);
                        }

                    }



                }
                $('#p3msg').html('');
                if (code != "") {
                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&name=' + $('#Name').val() + '&city=' + $('#city').val() + '&PinCode=' + $('#pin').val() + '&SellerName=' + $('#shopname').val() + '&AccountNumber=' + $('#AccountNumber').val() + '&IfscCode=' + $('#IfscCode').val() + '&AccountHolderName=' + $('#AccountHolderName').val() + '&comp=' + $('#CompName').val(),
                        success: function (data) {
                           // alert();

                            if (data == "Kindly enter valid IFSC code !.") {
                                toastr.error(data);
                            }
                            else {
                                if (data.split('~')[0] !== "failure") {
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
                                    $('#p3msg:contains("not")').css('color', 'white');
                                }

                                else if (data.split('~')[0] == "failure") {
                                    toastr.info(data.split('~')[1]);
                                }

                                else {

                                    $('#msgcoats').hide();
                                    toastr.error('OTP is not valid. Please provide the valid OTP');
                                    $('#btnskyVerify1').attr('disabled', false);
                                }
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
                window.location.href = 'https://www.vcqru.com/Kolorado.aspx';
            });
        });
        async function firstfunction() {

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
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chklocation&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                success: function (data) {


                }
            });
        }

        function ValidateIfccode(ifscCode) {
            //alert(ifscCode);
            var ann = 'http://qa.accomplishtrades.com/Info/MasterHandler.ashx?method=CheckIfcCode&IfcCode=' + ifscCode;
            //alert(ann);
            $.ajax({
                type: "Post",
                url: 'http://qa.accomplishtrades.com/Info/MasterHandler.ashx?method=CheckIfcCode&IfcCode=' + ifscCode,
                success: function (data) {
                    // alert(data);
                    if (data == "0") {
                        // alert("Invalid ifc code");
                        toastr.error("Invalid IFSC Code!");
                        return false
                    } else {
                        return true
                    }
                }
            });
        }

    </script>

</head>
<body>



    <div class="bg">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <h2>Welcome to the Kolorado Paints</h2>
                </div>
            </div>
        </div>
        <div class="body-bakground">
            <img src="../assets/images/karlodo/orange-background-1.png" class="animate__animated animate__fadeInDownBig">
        </div>

        <div class="container">
            <div class="row text">
                <div class="col-lg-5">



                    <form class=" animate__animated animate__backInLeft" runat="server">

                        <asp:HiddenField ID="hdnmob" runat="server" />
                        <asp:HiddenField ID="HdnID" runat="server" />
                        <asp:HiddenField ID="HdnCode1" runat="server" />
                        <asp:HiddenField ID="HdnCode2" runat="server" />
                        <asp:HiddenField ID="CompName" runat="server" />
                        <asp:HiddenField ID="long" runat="server" />
                        <asp:HiddenField ID="lat" runat="server" />


                        <div id="fields">
                            <div class="row">
                                <div>
                                    <h2 class="heading">TO CHECK AUTHENTICITY AND AVAIL BENEFITS</h2>
                                </div>
                            </div>
                            <div class="width-box">
                                <div id="ChkCode">
                                    <div class="form-group">
                                        <input type="text" class="form-control" maxlength="13" minlength="13" placeholder="Enter 13 Digit Code/13 अंको का कोड दर्ज करें*" id="codeone" <%--oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"--%> required>
                                    </div>
                                    <div>
                                        <center>
                                            <button type="button" id="btnnxt" class="btn btn-primary">Next</button>
                                            <%--<button type="button" data-toggle="modal" id="btnnxt" class="btn text-uppercase">Next</button>--%>
                                        </center>
                                    </div>
                                </div>
                                <div id="mobilefield" style="display: none">

                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="Retailer Shop name/विक्रेता दुकान का नाम *" id="shopname" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode==32" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" onkeyup="Getdata()" maxlength="10" minlength="10" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="Mobile Number/मोबाइल नंबर*" id="mobilenumber" required>
                                    </div>
                                    <%--<div>
                                        <center>
                                            <button type="button" data-toggle="modal" id="btnnxt" onclick="Getdata()" class="btn text-uppercase">Next</button>
                                         <button type="button" id="btnsubmit1" class="btn btn-primary">Submit</button>
                                        </center>
                                    </div>--%>
                                </div>
                                <div id="Chkfields">
                                    <div id="otherfield">
                                        <div class="form-group">
                                            <input type="text" class="form-control" placeholder="Name/नाम *" id="Name" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode==32"  required>
                                        </div>

                                        <div class="form-group">
                                            <input type="text" class="form-control" onkeyup="getaddress()" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="6" minlength="6" placeholder="Pincode/पिनकोड*" id="pin" required>
                                        </div>

                                        <div class="form-group">
                                            <input type="text" class="form-control" placeholder="City/शहर*" readonly="readonly" id="city" required >
                                        </div>


                                    </div>

                                    <div id="DivBankDetails" runat="server">
                                        <div class="mb-3">

                                            <input type="text" class="form-control" id="AccountHolderName" placeholder="Bank Account Holder Name /खाता धारक का नाम*" maxlength="30" autocomplete="off" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode==32">
                                        </div>
                                        <div class="mb-3">

                                            <input type="text" placeholder="Bank Account Number/खाता संख्या*" id="AccountNumber" minlength="9" maxlength="18" data-msg-required="Please Enter Bank Account Number*" class="form-control" pattern="[0-9]+" title="only numbers" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
                                        </div>

                                        <div class="mb-3">

                                            <input type="text" placeholder="Confirm bank Account number/खाता संख्या की पुष्टि करें*" minlength="9" maxlength="18" class="form-control" id="ConfirmAccountNumber" pattern="[0-9]+" title="only numbers" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                                        </div>
                                        <div class="mb-3">

                                            <input type="text" placeholder="IFSC Code/आईएफएससी कोड*" onkeypress="return ValidateAlphaNumeric1(event);" id="IfscCode" maxlength="11" data-msg-required="Please Enter Your IFSC Code*." class="form-control" style="text-transform: uppercase" pattern="[A-Za-z0-9]+"  title="letters or numbers only" autocomplete="off" />
                                        </div>
                                        <!--<div class="col-12">

                                            <input type="checkbox" id="chkbox" data-msg-required="Please select checkbox*" /><span style="color:#fff;"> Please Accept <a style="color:#fff; text-decoration:none;" href="TermsNCondtions.aspx"><b>Terms and Conditions</b></a></span>
                                        </div>-->
                                    </div>

                                    <div>
                                        <button type="button" id="btnsubmit" class="btn btn-primary">Submit</button>
                                    </div>

                                </div>
                                <p id="wlink" class="blink_me">
                                    QR/Code  Related Support Available on
                                    <br>
                                    <i class="fa fa-phone" aria-hidden="true"></i>
                                    <a href="tel:7353000903">7353000903</a> / 
                           
                                    <i class="fa fa-whatsapp" aria-hidden="true"></i>
                                    <a href="https://api.whatsapp.com/send?phone=+919355903119&amp;text&amp;type=phone_number&amp;app_absent=1" target="blank">9355903119</a>
                                </p>
                            </div>
                        </div>
                        <div style="display: none;" id="ShowMessage" class="row no-gutters textmessage">
                            <center>
                                <div class="col-md-12">
                                    <br />
                                    <div class="form-group">
                                        <p id="p3msg" style="overflow: hidden; color: white; font-size: 21px !important;" class="displayNone massage_box"></p>
                                    </div>
                                    <a href="javascript:void(0)" class="next_btn" id="btnNext"><b>Close</b></a>

                                </div>
                            </center>
                        </div>
                    </form>
                </div>
                <div class="col-lg-7 text-center">

                    <div class="img-right">
                        <img src="assets/images/karlodo/Layer10.png" class="img-fluid animate__animated animate__zoomIn ">
                    </div>
                </div>
            </div>
        </div>
        <footer>
            <%-- <p class="py-2">www.vcqru.com</p>--%>
        </footer>
    </div>
</body>
</html>
