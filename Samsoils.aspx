<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Samsoils.aspx.cs" Inherits="Samsoils" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/0.9.0/jquery.mask.min.js"></script>
    <title>SAMSOIL</title>
    <style>
        .SAMSOIL {
            background-image: url(Samsoil/bg.jpg);
            background-repeat: no-repeat;
            background-position: top;
            width: 100%;
            height: 100vh;
            background-size: cover;
            position: relative;
            display: table;
        }
        header{
            position:relative;
            z-index:100;
        }
        .samsoil-logo {
            width: 17%;
            padding: 16px 16px 36px 16px;
        }

        .samsoil-product {
            z-index: 1;
            width: 100%;
        }

        .form-box .btn-1, .btn-2 {
            margin-bottom: 6px;
        }

        .form-box input {
            background-color: #dee0e1;
        }

        /* .form-box{
            position: absolute;
            width: 27%;
            top: 20%;
        } */
        .form-box .card {
            z-index: 1;
            /* background-color: #a51380db; */
            padding-bottom: 0px !important;
            border: 4px solid #ef3138;
                margin-bottom: 3rem;
        }

            .form-box .card h4 {
                font-size: 1.2rem;
                color: #000000;
                font-weight: 700;
            }

            .form-box .card input::placeholder {
                font-size: 0.8rem;
            }

        .form-box #wlink {
            text-align: center;
            color: #000000;
            font-weight: 700;
        }

            .form-box #wlink a {
                //text-decoration: none;
                color: #0d6efd;
            }

        .login-btn {
            background-color: #53b25a;
            border: 1px solid #fff;
            color: #fff;
            padding: 10px 0px;
            margin-top: 5px;
        }

        .SAMSOIL h2 {
            font-size: 3.5rem;
            font-weight: 700;
            text-transform: uppercase;
        }

        .text-color-red {
            color: #ef3138;
        }

        .footer-bg-box {
            background-color: #ef3138;
            padding: 22px;
            width: 100%;
            position: absolute;
            bottom: 0;
            z-index:100;
        }

        @media screen and (max-width:767px) {
            .samsoil-logo {
                width: 38%;
                padding: 6px;
            }

            .SAMSOIL h2 {
                font-size: 1.5rem;
            }
        }


        @media screen and (min-width:768px) and (max-width:1200px) {
            .SAMSOIL h2 {
                font-size: 2.5rem;
            }

            /*.samsoil-product {
                position: absolute;
                width: 60%;
                left: 5%;
                bottom: 10%;
            }*/
        }
    </style>

    <script type="text/javascript">
        var baseURL = "https://www.vcqru.com/";
        var lat = "";
        var long = "";
        var code1 = "";
        var code2 = "";
        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }
        function Mobile_check() {
            debugger;
            var mobile_val = $('#mobile').val();
            var d = mobile_val.slice(0, 1);
            var c = parseInt(d);

            if ((mobile_val.length == '') || (mobile_val.length != 10)) {
                $('#mobilecheck').show();
                $('#mobilecheck').html("**Please Enter Correct mobile number");
                $('#mobilecheck').css("color", "red");
                mobile_err = false;
                return false;
            }
            if (mobile_val.length == 10) {
                $('#mobilecheck').html('');
                $('#mobilecheck').hide();
                $.ajax({
                    type: "Post",
                    url: baseURL+'Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNoandcomp&MobileNo= ' + $("#mobile").val() + '&compid=Comp-1649',
                    success: function (data) {
                       
                        if (c <= 5) {
                            $('#mobilecheck').text('Please Enter Correct Mobile Number');
                            $('#mobile').val('');
                            return false;
                        }
                        else {
                            var Name = data.split('~')[0];
                            var pin = data.split('~')[6];
                            var city = data.split('~')[2];
                            var state = data.split('~')[3];
                            var AccountHolderName = data.split('~')[12];
                            var AccountNumber = data.split('~')[8];
                            var IfscCode = data.split('~')[9];

                            $("#AccountNumber").val(AccountNumber);
                            $("#ConfirmAccountNumber").val(AccountNumber);
                            $("#IfscCode").val(IfscCode);
                            $("#AccountHolderName").val(AccountHolderName);
                            //if ($("#AccountHolderName").val() != "" && $("#IfscCode").val() != "" && $("#AccountHolderName").val() != "") {
                            //    $("#AccountNumber").attr('readonly', true);
                            //    $("#ConfirmAccountNumber").attr('readonly', true);
                            //    $("#IfscCode").attr('readonly', true);
                            //    $("#AccountHolderName").attr('readonly', true);
                            //}
                           

                            if (Name != "" || Name!=null) {
                                $("#name").val(Name);
                            }
                            else {
                                $('#Chkcode').hide();
                                $('#Chkfields').show();
                                $('#mobilefield').hide();
                                $('#Otherfield').show();
                                $('#divbank').hide();
                            }
                            if (pin != "" || pin!=null) {
                                $("#Pincode").val(pin);
                            }
                            else {
                                $('#Chkcode').hide();
                                $('#Chkfields').show();
                                $('#mobilefield').hide();
                                $('#Otherfield').show();
                                $('#divbank').hide();
                            }
                            if (city != "" || city !=null) {
                                $("#city").val(city);
                            }
                            else {
                                $('#Chkcode').hide();
                                $('#Chkfields').show();
                                $('#mobilefield').hide();
                                $('#Otherfield').show();
                                $('#divbank').hide();
                            }
                            if (state != "" || state!=null) {
                                $("#State").val(state);
                            }
                            else {
                                $('#Chkcode').hide();
                                $('#Chkfields').show();
                                $('#mobilefield').hide();
                                $('#Otherfield').show();
                                $('#divbank').hide();
                            }

                           
                            if (AccountNumber == "" || AccountNumber==null) {
                                $('#Chkcode').hide();
                                $('#Chkfields').show();
                                $('#mobilefield').hide();
                                $('#Otherfield').hide();
                                $('#divbank').show();
                            }
                            else {
                                $('#AccountNumber').val(AccountNumber);
                                $('#ConfirmAccountNumber').val(AccountNumber);
                                document.getElementById("AccountNumber").readOnly = true;
                            }
                            if (IfscCode == "" || IfscCode==null) {
                                $('#Chkcode').hide();
                                $('#Chkfields').show();
                                $('#mobilefield').hide();
                                $('#Otherfield').hide();
                                $('#divbank').show();
                            }
                            else {
                                $('#IfscCode').val(IfscCode);
                                document.getElementById("IfscCode").readOnly = true;
                            }
                            if (AccountHolderName == "" || AccountHolderName == null) {
                                $('#Chkcode').hide();
                                $('#Chkfields').show();
                                $('#mobilefield').hide();
                                $('#Otherfield').hide();
                                $('#divbank').show();
                            }
                            else {
                                $('#AccountHolderName').val(AccountHolderName);
                                document.getElementById("AccountHolderName").readOnly = true;
                            }

                            if (Name == "" && pin == "" && city == "" && state == "" && AccountHolderName == "" && AccountNumber == "" && IfscCode == "") {
                                $('#Chkcode').hide();
                                $('#Chkfields').show();
                                $('#mobilefield').hide();
                                $('#Otherfield').show();
                                $('#divbank').show();

                            }
                            else if (Name != "" && pin == "" && city != "" && state != "" && AccountHolderName == "" && AccountNumber == "" && IfscCode == "") {
                                $('#Chkcode').hide();
                                $('#Chkfields').show();
                                $('#mobilefield').hide();
                                $('#Otherfield').show();
                                $('#divbank').show();
                            }
                            else if (Name != "" && pin != "" && city != "" && state != "" && AccountHolderName == "" && AccountNumber == "" && IfscCode == "") {
                                $('#Chkcode').hide();
                                $('#Chkfields').show();
                                $('#mobilefield').hide();
                                $('#Otherfield').hide();
                                $('#divbank').show();
                            } else if (Name == "" && pin == "" && city == "" && state == "" && AccountHolderName != "" && AccountNumber != "" && IfscCode != "") {
                                $('#Chkcode').hide();
                                $('#Chkfields').show();
                                $('#mobilefield').hide();
                                $('#Otherfield').show();
                                $('#divbank').hide();
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
        function ValidateAccount() {
            var AccountNumber = $('#AccountNumber').val();
            if (AccountNumber != undefined) {

                if ($('#AccountNumber').val().length < 1) {
                    $('#lblaccount').text('Please Enter valid account number');
                    return false;
                }
            }

            var ConfirmAccountNumber = $('#ConfirmAccountNumber').val();
            if (ConfirmAccountNumber != undefined) {

                if ($('#ConfirmAccountNumber').val().length < 1) {
                    $('#lblaccount').text('Please Enter valid confirm account number');
                    return false;
                }

            }
        }
        function ValidateAlpha(evt) {
            var keyCode = (evt.which) ? evt.which : evt.keyCode
            if ((keyCode < 65 || keyCode > 90) && (keyCode < 97 || keyCode > 123) && keyCode != 32)
                return false;
            return true;
        }
        function ValidateAlphaNumeric(evt) {
            var keyCode = (evt.which) ? evt.which : evt.keyCode
            if ((keyCode < 65 || keyCode > 90) && (keyCode < 97 || keyCode > 123) && (ASCIICode < 48 || ASCIICode > 57) && keyCode == 32)

                return false;
            return true;
        }
        function onlyNumberKey(evt) {
            var ASCIICode = (evt.which) ? evt.which : evt.keyCode
            if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
                return false;
            return true;
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
                        debugger;
                        var city = data[0].PostOffice[0]['District'];
                        var State = data[0].PostOffice[0]['State'];
                        var Pin = data[0].PostOffice[0]['PinCode'];
                        $("#city").val(city);
                        $("#State").val(State);
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
                        url: baseURL+'Info/MasterHandler.ashx?method=IFSC&ifsccode=' + $("#IfscCode").val(),
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

        function ACNamevalid() {
            var name = $('#AccountHolderName').val();
            if (name != undefined) {

                if ($('#AccountHolderName').val().length < 1) {
                    $('#AccountHolderNamecheck').html("**Please Enter Valid AccountHolderName");
                    $('#AccountHolderNamecheck').css("color", "red");
                    validate = false;
                    return false;
                }
                var matches = $('#AccountHolderName').val().match(/\d+/g);
                if (matches != null) {
                    $('#AccountHolderNamecheck').html("**Please Enter Valid AccountHolderName");
                    $('#AccountHolderNamecheck').css("color", "red");
                    validate = false;
                    return false;
                }
                var matches1 = $('#AccountHolderName').val().match(/[^a-zA-Z0-9 ]/);
                if (matches1 != null) {
                    $('#AccountHolderNamecheck').html("**Please Enter Valid AccountHolderName");
                    $('#AccountHolderNamecheck').css("color", "red");
                    validate = false;
                    return false;
                }
            }
        }
        function ValidateIfccode(ifscCode) {
            $('#btnsubmit2').attr('disabled', true);
            var ann = '../Info/MasterHandler.ashx?method=CheckIfcCode&IfcCode=' + ifscCode;
            $.ajax({
                type: "Post",
                url: '../Info/MasterHandler.ashx?method=CheckIfcCode&IfcCode=' + ifscCode,
                success: function (data) {
                    if (data == "0") {
                        $('#lblaccount').text("Invalid IFSC Code!");
                        return false
                    } else {
                        $('#lblaccount').text("");
                        $('#btnsubmit2').attr('disabled', false);
                        return true;
                    }
                }
            });
        }
        $(document).ready(function () {
            debugger;


            $('#Chkcode').show();
            $('#Chkfields').hide();
            $('#mobilefield').hide();
            $('#Otherfield').hide();
            $('#divbank').hide();
            var id = $('#HdnID').val();
            if (id == "1") {

                $('#Chkcode').show();
                $('#Chkfields').hide();
                $('#mobilefield').hide();
                $('#Otherfield').hide();
                $('#divbank').hide();
            }


            else if (id == "Samsoil") {
                $('#Chkcode').hide();
                $('#mobilefield').show();
                $('#Chkfields').show();
                $('#Otherfield').hide();
                $('#divbank').hide();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $("#example13-digit-number").val(code);
            }


            var code_err = true;
            var mobile_err = true;
            var name_err = true;

            var city_err = true;
            /* Upi_err = true;*/
            bank_err = true;
            account_err = true;
            ifsc_err = true;


            $("#example13-digit-number").mask("99999-99999999");
            $("#btnnxt").on('click', function (e) {
                e.preventDefault();


                var codeone = $('#example13-digit-number').val();
                code1 = codeone.split('-')[0];
                code2 = codeone.split('-')[1];

                if (codeone == "" || codeone == undefined) {
                    $('#codecheck').html('**Please Enter 13 Digit-Code');
                    $('#codecheck').css("color", "red");
                    return false;
                }
                else {
                    $('#nextcheck').text('');
                }

                if (codeone != undefined) {
                    if ($('#example13-digit-number').val().length < 14) {
                        $('#codecheck').text('**Please Enter 13 Digit Code');
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
                    url: baseURL+'Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                    success: function (data) {
                        $.ajax({
                            type: "POST",
                            url: baseURL+'Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1] + '&lat=' + lat + '&long=' + long,
                            success: function (data) {
                                $('#btnnxt').show();
                                $('#btnloadnxt').hide();
                                if (data.split('&')[0] === "1" && data.split('&')[1] === "Auto Max India") {
                                }
                                else {

                                    if (data.split('&')[1] == "SAMSOIL PETROLEUM INDIA LTD" || data.split('&')[1] == "" || data.split('&')[1] == undefined) {
                                        $('#Chkcode').hide();
                                        $('#Chkfields').show();
                                        $('#Otherfield').hide();
                                        $('#mobilefield').show();
                                        $('#divbank').hide();

                                    }
                                    else {
                                        $('#Chkcode').show();
                                        $('#Chkfields').hide();
                                        $('#mobilefield').hide();
                                        $('#Otherfield').hide();
                                        $('#divbank').hide();
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
            });
            $("#Pincode").mask("999999");
            $('#Pincode').keyup(function () {
                pinval();

            });
            $('#name').keyup(function () {
                Name_check();

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
                    return false;
                }
                if ((Name_val.length == '')) {
                    $('#namecheck').show();
                    $('#namecheck').html("**Please Enter Name");
                    $('#namecheck').css("color", "red");
                    name_err = false;
                    return false;
                }

                if ($('#name').val().match('^[a-z A-Z]{3,30}$')) {
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
                        $('#city').val() == '';
                        $('#State').val() == '';
                        validate = false;
                    }
                    if (pin.match(/[^$,.\d]/)) {
                        $('#pincheck').html("**Please Enter Valid Pincode");
                        $('#pincheck').css("color", "red");
                        validate = false;
                    }

                    var matches1 = $('#Pincode').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        $('#pincheck').html("**Please Enter Valid Pincode");
                        $('#pincheck').css("color", "red");
                        validate = false;
                    }
                }
            }
            $('#city').keyup(function () {
                city_check();

            });
            function city_check() {
                var city_val = $('#city').val();
                if (city_val.charAt(0) === ' ') {
                    $('#citycheck').html("**Please Enter  City");
                    $('#citycheck').css("color", "red");
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
            $('#State').keyup(function () {
                State_check();

            });
            function State_check() {
                var State_val = $('#State').val();
                if (State_val.charAt(0) === ' ') {
                    $('#statecheck').html("**Please Enter  State");
                    $('#statecheck').css("color", "red");
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
            $('#IfscCode').keyup(function () {
                debugger;
                ValidateIfccode(this.value);
            });

            $('#btnsubmit').on('click', function (e) {
                e.preventDefault();

                debugger;


                var mobileone = $('#mobile').val();
                if ((mobileone == "") || (mobileone == undefined)) {


                    $('#mobilecheck').html('**Please Enter Mobile Number');
                    $('#mobilecheck').css("color", "red");
                    return false;
                }

                if (mobileone.length != 10) {
                    $('#mobilecheck').html('**Please Enter 10-Digits Mobile Number');
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
                var pincode = $('#Pincode').val();

                if ($('#Pincode').val() == "" || pincode == undefined) {
                    $('#pincheck').html('Please Enter pincode');
                    $('#pincheck').css("color", "red");
                    pinval();
                    $('#city').val() == "";
                    $('#State').val() == "";
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#pincheck').text('');

                }
                
                var City = $('#city').val();
                if (City == "" || City == undefined || City.charAt(0) === ' ') {
                    $('#citycheck').html('Please Enter City');
                    $('#citycheck').css("color", "red");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#citycheck').text('');
                }
                var State = $('#State').val();
                if (State == "" || State == undefined || State.charAt(0) === ' ') {
                    $('#statecheck').html('Please Enter State');
                    $('#statecheck').css("color", "red");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#statecheck').text('');
                }


                if ($('#AccountHolderName').val() == "") {

                    $('#AccountHolderNamecheck').html("**Please Enter  AccountHolderName");
                    $('#AccountHolderNamecheck').css("color", "red");
                    validate = false;
                    return false;
                }
                else {
                    $('#AccountHolderNamecheck').html("");
                }
                if ($('#AccountHolderName').val() != "") {
                    ValidateAccount();
                    ACNamevalid();
                    var AcHLength = $('#AccountHolderName').val();
                    if (!AcHLength.replace(/\s/g, '').length) {
                        $('#AccountHolderNamecheck').html("**Please Enter  AccountHolderName");
                        $('#AccountHolderNamecheck').css("color", "red");
                        $("#btnsubmit2").removeAttr("disabled");
                        return false;
                    }
                    else {
                        $('#AccountHolderNamecheck').html("");
                    }
                    if ($('#AccountHolderName').val() == "" || AcHLength.length == 1) {
                        ACNamevalid();
                        $("#btnsubmit2").removeAttr("disabled");
                        return false;
                    }

                    if ($('#AccountNumber').val() == "") {
                        $('#lblaccount').text('Please Enter valid account number');
                        return false;
                    }

                    if ($('#ConfirmAccountNumber').val() == "") {
                        $('#lblaccount').text('Confirm account number should be same as per account number');
                        return false;
                    }

                    var x = $('#AccountNumber').val();
                    var y = $('#ConfirmAccountNumber').val();
                    if (x == y) {

                    }
                    else {
                        $('#lblaccount').text("Confirm account number should be same as per account number");;
                        return false;
                    }
                    if ($('#AccountNumber').val().length < 9) {
                        $('#lblaccount').text('Please Enter valid account number');
                        return false;
                    }

                    if ($('#ConfirmAccountNumber').val().length < 9) {
                        $('#lblaccount').text('Please Enter valid confirm account number');
                        return false;
                    }
                    var IfscCode = $('#IfscCode').val();
                    if (IfscCode.length != 11) {
                        $('#lblaccount').text("Please enter 11 digit of Ifsc code .");
                        return false;
                    }
                    if (IfscCode.length == 11) {
                        $.ajax({
                            type: "Post",
                            url: baseURL+'Info/MasterHandler.ashx?method=CheckIfcCode&IfcCode=' + IfscCode,
                            success: function (data) {
                                if (data == "0") {
                                    $('#lblaccount').text("Invalid IFSC Code!");
                                    return false;
                                } else {
                                    $('#lblaccount').text("");
                                    return true;
                                }
                            }
                        });
                    }
                }

                $('#btnsubmit').hide();
                $('#btnloadsubmit').show();
                var code = $('#example13-digit-number').val();
                var rquestpage_Dcrypt = code;
                if (code != "") {
                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,
                        url: baseURL+'Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#example13-digit-number').val() + '&name=' + $('#name').val() + '&city=' + $('#city').val() + '&state=' + $('#State').val() + '&PinCode=' + $('#Pincode').val() /*+ '&UPI=' + $("#upi").val()*/ + '&AccountNumber=' + $('#AccountNumber').val() + '&IfscCode=' + $('#IfscCode').val() + '&AccountHolderName=' + $('#AccountHolderName').val() + '&comp=SAMSOIL PETROLEUM INDIA LTD&Comp_ID=Comp-1649',
                        success: function (data) {
                           
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
                                $('#divbank').hide();
                                if (data.toUpperCase().includes("INVALID")) {
                                    $('#wlink').html("The code is invalid.");
                                }
                                else {
                                    $('#wlink').html(data.split('~')[1]);
                                }
                                
                            }
                            else {
                                $('#Chkfields').hide();
                                $('#mobilefield').hide();
                                $('#Otherfield').hide();
                                $('#Chkcode').hide();
                                $('#ShowMessage').show();
                                $('#divbank').hide();
                                $('#wlink').html(data.split('~')[1]);
                            }
                        }
                    });
                }
            });

            $('#btnNext').click(function () {
                window.location.href = 'https://www.vcqru.com/SamSoil.aspx';
            });
            $('#btnlogin').click(function () {
                window.location.href = 'https://www.vcqru.com/login.aspx';
            });
        });
    </script>
</head>
<body>
    <form name="form1" method="post" runat="server" action="./codeverify.aspx?ID=5" id="form1">
        <div>
            <input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKMTg0OTQ1MjgyNWRksJsH6oszOY6aBQb8ZYXqeZMoulsk8vinBkoOFmG/5+0=" />
        </div>
        <div>
            <input type="hidden" name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="1C52CC2C" />
            <input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION" value="/wEdAAd6JZhTpi8GFWyIsYyG2DIQTHJap1XPAwS4DQSuvGS50UWwP5KwieItj32l9mnkzqloDPdc3hZCgD7GXGAULra3/e/TMgqN0FcyW0KuwQmpO/68Exa89vh/IRkoWN0RiIwY7K8ZMmE2lBY9fYpYdQz1P9IDSJSefdmxvBXJdr6y/iaq/z6L9cln71gR+ZJ5CX0=" />
        </div>
        <asp:HiddenField ID="hdnmob" runat="server" />
        <asp:HiddenField ID="HdnID" runat="server" />
        <asp:HiddenField ID="HdnCode1" runat="server" />
        <asp:HiddenField ID="HdnCode2" runat="server" />
        <asp:HiddenField ID="CompName" runat="server" />
        <asp:HiddenField ID="long" runat="server" />
        <asp:HiddenField ID="lat" runat="server" />
        <section class="SAMSOIL">
            <div class="container">
                <header>
                    <img src="Samsoil/logo.png" alt="samsoil-logo" class="samsoil-logo" />
                </header>
                <div class="row pb-2">
                    <div class="col-lg-8 text-center order-lg-1 order-2">
                        <h2>Welcome to the
                            <br />
                            world of <span class="text-color-red">SAMSOIL </span></h2>
                        <img src="Samsoil/product.png" alt="samsoil-product" class="samsoil-product mb-lg-0 mb-5" />
                    </div>
                    <div class="col-lg-4 order-lg-2 order-1">

                        <div class="m-auto form-box">
                            <div class=" card p-3 z-2">
                                <h4 class="text-center">To avail benefits/लाभ उठाने के लिए
                                </h4>
                                <div id="Chkcode">
                                    <div class="col-lg-12 p-1">
                                        <input type="text" maxlength="13" id="example13-digit-number" placeholder="13 अंकीय कोड दर्ज करें/Enter 13 digit code*" class="form-control" />
                                        <h6 id="codecheck" class="invalid-feedback d-block"></h6>
                                        <button type="button" id="btnnxt" data-toggle="modal" class="form-control login-btn">Next/अगला</button>
                                        <button type="button" id="btnloadnxt" style="display: none" data-toggle="modal" class="form-control login-btn"><i class="fa fa-spinner fa-spin"></i>Loading..</button>
                                        <h6 id="nextcheck"></h6>
                                    </div>
                                </div>
                                <div id="Chkfields">
                                    <div id="mobilefield">
                                        <div class="col-lg-12 p-1">
                                            <input type="text" maxlength="10" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" id="mobile" placeholder="मोबाइल नंबर/Mobile No*" class="form-control" />
                                            <h6 id="mobilecheck" class="invalid-feedback d-block"></h6>
                                        </div>
                                    </div>
                                    <div id="Otherfield">
                                        <div class="col-lg-12 p-1">
                                            <input type="text" maxlength="30" id="name" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || (event.charCode == 32)" placeholder="Name/नाम*" class="form-control" />
                                            <h6 id="namecheck" class="invalid-feedback d-block"></h6>
                                        </div>
                                        <div class="col-lg-12 p-1">
                                            <input type="text" minlegth="6" maxlength="6" id="Pincode" onkeyup="getaddress()" placeholder="Pin Code/पिन कोड*" class="form-control" />
                                            <h6 id="pincheck" class="invalid-feedback d-block"></h6>
                                        </div>
                                        <div class="col-lg-12 p-1">
                                            <input type="text" maxlength="30" id="city" placeholder="City/शहर*" class="form-control" />
                                            <h6 id="citycheck" class="invalid-feedback d-block"></h6>
                                        </div>
                                        <div class="col-lg-12 p-1">
                                            <input type="text" maxlength="40" id="State" placeholder="State/राज्य*" class="form-control" />
                                            <h6 id="statecheck" class="invalid-feedback d-block"></h6>
                                        </div>
                                    </div>
                                    <div id="divbank">
                                        <div class="col-12">
                                            <input type="text" class="form-control" id="AccountHolderName" placeholder="Bank Account Holder Name/खाता धारक का नाम *" maxlength="30" autocomplete="off" onkeypress="return ValidateAlpha(event);" />
                                            <h6 id="AccountHolderNamecheck" style="color: red"></h6>
                                        </div>
                                        <div class="col-12">
                                            <input type="text" placeholder="Bank Account Number/खाता संख्या*" id="AccountNumber" minlength="9" maxlength="18" data-msg-required="Please Enter Bank Account Number*" class="form-control" pattern="[0-9]+" title="only numbers" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
                                            <h6 id="AccountNumbercheck" style="color: red"></h6>
                                        </div>
                                        <div class="col-12">
                                            <input type="text" placeholder="Confirm Bank Account Number/खाता संख्या की पुष्टि करें*" minlength="9" maxlength="18" class="form-control" id="ConfirmAccountNumber" pattern="[0-9]+" title="only numbers" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
                                            <h6 id="ConfirmAccountNumbercheck" style="color: red"></h6>
                                        </div>
                                        <div class="col-12 mb-3">
                                            <input type="text" placeholder="IFSC Code/आईएफएससी कोड*" onkeypress="return ValidateAlphaNumeric(event);" id="IfscCode" maxlength="11" onkeyup="GetIfscDetails()" data-msg-required="Please Enter Your IFSC Code*." class="form-control mb-1" />
                                            <h6 id="IfscCodecheck" style="color: red"></h6>
                                            <span id="lblaccount" style="color: red" class="mb-1 d-block"></span>
                                        </div>
                                    </div>

                                    <div class="col-lg-12 p-1">
                                        <button type="button" id="btnsubmit" class="form-control login-btn">LOG IN/लॉग इन</button>
                                        <button type="button" id="btnloadsubmit" style="display: none" data-toggle="modal" class="form-control login-btn"><i class="fa fa-spinner fa-spin"></i>Loading..</button>
                                    </div>
                                </div>

                                <div style="display: none;" id="ShowMessage" class="row no-gutters pl-4 pr-4 textmessage">
                                    <center>
                                        <div class="col-md-12">
                                            <br />
                                            <div class="form-group">
                                                <p id="wlink" style="overflow: hidden; font-size: 14px !important;" class="displayNone massage_box">
                                                    <a style="text-decoration: underline" href="javascript:void(0)" class="next_btn" id="btnlogin"><b>Login Here</b></a>
                                                </p>
                                            </div>
                                            <a href="javascript:void(0)" class="next_btn" id="btnNext">Close</a>
                                        </div>
                                    </center>
                                </div>
                                <div class="col-lg-12 p-2 text-center">
                                    <p id="wlink1" class="blink_me animate__animated animate__flash">
                                        QR/Code Related Support Available on
                                    <br />
                                        <i class="fa fa-phone" aria-hidden="true"></i><a href="tel:7353000903">7353000903
                                        </a>
                                        <i class="fa fa-whatsapp" aria-hidden="true"></i>
                                        <a href="https://api.whatsapp.com/send?phone=+919355903119&amp;text&amp;type=phone_number&amp;app_absent=1" target="blank">9355903119 </a>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <footer class="footer-bg-box"></footer>
        </section>
    </form>
</body>
</html>
