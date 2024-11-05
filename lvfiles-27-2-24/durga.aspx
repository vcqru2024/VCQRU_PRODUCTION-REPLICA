<%@ Page Language="C#" AutoEventWireup="true" CodeFile="durga.aspx.cs" Inherits="shreedurga" %>

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shree Durga</title>
    <!-- css -->
    <link rel="stylesheet" href="../assets/images/Shree_Durga_Tradres/css/css.css">
    <link rel="stylesheet" href="../assets/images/Shree_Durga_Tradres/css/style.css">

    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="Content/js/jquery-1.11.1.min.js"></script>
    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>

    <style>
        #lbl {
            color: red;
        }

        #nextcheck {
            color: red;
        }
    </style>

</head>

<body>

    <script type="text/javascript">
        var lat = "";
        var long = "";
        var code1 = "";
        var code2 = "";
        var code = "";
        var filstate = "";
        var GlobalBaseURL = "https://qa.vcqru.com/"; //QA
       // var GlobalBaseURL = "https://uat.vcqru.com/"; //UAT
       // var GlobalBaseURL = "https://www.vcqru.com/"; //Live
        var GlobalCompID = "Comp-1609";  //Live
        var GlobalCompName = "Shree Durga Traders"; //UAT
        var RedirectURL = "https://qa.vcqru.com/shreedurga.aspx";
        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }


        function getaddress() {
           
            $("#Pin").mask("999999");
            let pin = document.getElementById("Pin").value;
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
                        filstate = state;
                        var Pin = data[0].PostOffice[0]['PinCode'];
                        $('#lbl').text('');
                        $("#city").val(city);
                        $("#hdnstate").val(state);

                        if ($("#city").val() != "") {
                            document.getElementById('city').readOnly = true;
                            $('#pincheck').html("");
                        }

                    }
                    else {
                        $('#pincheck').html("Please Enter Valid Pin Code.");
                        $('#pincheck').css("color", "red");
                        $("#Pin").val('');
                        return false;
                    }
                }
            }
            else {
                $("#city").val('');
                $('#pincheck').html("Please Enter Valid Pin Code.");
                $('#pincheck').css("color", "red");
                document.getElementById('city').readOnly = false;
                return false;
            }
        }


        function Mobile_check() {
           
            var mobile_val = $('#mobile').val();
            var d = mobile_val.slice(0, 1);
            var c = parseInt(d);
            if ((mobile_val.length == '') || (mobile_val.length != 10)) {
                $('#mobilecheck').show();
                $('#mobilecheck').html("Please Enter Correct mobile number");
                $('#mobilecheck').css("color", "red");
                mobile_err = false;
                return false;
            }


            if (mobile_val.length == 10) {


                $('#mobilecheck').hide();
                $.ajax({
                    type: "Post",
                    url: '../Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNoandcomp&MobileNo= ' + $("#mobile").val() + '&compid=' + GlobalCompID,
                    success: function (data) {
                        //alert(data);
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
                            var shopname = data.split('~')[4];
                            var Address = data.split('~')[9];
                            var ddlconsumertype = data.split('~')[5];
                            var BankName = data.split('~')[7];
                            var AccountNumber = data.split('~')[8];
                            var IfscCode = data.split('~')[9];
                            var AccountHolderName = data.split('~')[12];
                            var UpiId = data.split('~')[10];

                            $("#AccountNumber").val(AccountNumber);
                            $("#ConfirmAccountNumber").val(AccountNumber);
                            $("#IfscCode").val(IfscCode);
                            $("#AccountHolderName").val(AccountHolderName);




                            if ($("#AccountHolderName").val() != "" && $("#IfscCode").val() != "" && $("#AccountHolderName").val() != "") {
                                $("#AccountNumber").attr('readonly', true);
                                $("#ConfirmAccountNumber").attr('readonly', true);
                                $("#IfscCode").attr('readonly', true);
                                $("#AccountHolderName").attr('readonly', true);
                            }



                            if (Name != "") {
                                $("#name").val(Name);
                            }
                            else {

                                $('#Chkcode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();

                            }

                            if (pin != "") {
                                $("#Pin").val(pin);
                            }
                            else {

                                $('#Chkcode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();

                            }

                            if (city != "") {
                                $("#city").val(city);
                            }
                            else {
                                $('#Chkcode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();
                            }


                            if (Name != "" && Pin != "" && city != "") {

                                if (AccountNumber != "" && IfscCode != "") {
                                    $("#AccountNumber").val(AccountNumber);
                                    $("#ConfirmAccountNumber").val(AccountNumber);
                                    $("#IfscCode").val(IfscCode);
                                    $("#AccountHolderName").val(AccountHolderName);
                                    $('#Chkfields').show();
                                    $('#mobilefield').show();
                                    $('#Otherfield').hide();
                                }
                                else {
                                    $('#ChkCode').hide();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                }

                            }

                            


                        }

                    }
                });
            }
            else {
                $("#name").val('');
                $("#city").val('');


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








        $(document).ready(function () {
           


            $('#Chkcode').show();
            $('#Chkfields').hide();
            $('#mobilefield').hide();
            $('#Otherfield').hide();
            $('#form_2nd').hide();

            var id = $('#HdnID').val();

            if (id == "1") {

                $('#Chkcode').show();
                $('#Chkfields').hide();
                $('#mobilefield').hide();
                $('#Otherfield').hide();
            }


            else if (id == "Durga") {
                $('#Chkcode').hide();
                $('#mobilefield').show();
                $('#Chkfields').show();
                $('#Otherfield').hide();
                 code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $("#example13-digit-number").val(code);
            }


            var code_err = true;
            var mobile_err = true;
            var name_err = true;

            var city_err = true;
            bank_err = true;
            account_err = true;
            ifsc_err = true;

            $('#example13-digit-number').keyup(function () {
                // codeonecheck();
            });

            function codeonecheck() {
                var codeone = $('#example13-digit-number').val();
                if (codeone == "" || codeone == undefined) {
                    $('#Code1check').html('Please Enter 13 Digit-Code');
                    $('#Code1check').css("color", "red");
                    return false;
                }
                else {
                    $('#nextcheck').text('');
                }

                if (codeone != undefined) {
                    if ($('#example13-digit-number').val().length < 13) {
                        $('#Code1check').text('Please Enter 13 Digit Code');
                        $('#Code1check').css("color", "red");
                        return false;
                    }
                    else {
                        $('#nextcheck').text('');
                        $('#nextcheck').hide();
                    }

                }
            }


            $("#example13-digit-number").mask("99999-99999999");
            $("#btnnxt").on('click', function (e) {
                e.preventDefault();

                var codeone = $('#example13-digit-number').val();
                if (codeone == "" || codeone == undefined) {
                    $('#Code1check').html('Please Enter 13 Digit-Code');
                    $('#Code1check').css("color", "red");
                    return false;
                }
                else {
                    $('#nextcheck').text('');
                }

                if (codeone != undefined) {
                    if ($('#example13-digit-number').val().length < 14) {
                        $('#Code1check').text('Please Enter 13 Digit Code');
                        $('#Code1check').css("color", "red");
                        return false;
                    }
                    else {
                        $('#nextcheck').text('');
                        $('#nextcheck').hide();
                    }

                }

                var rquestpage_Dcrypt = $("#example13-digit-number").val();
                code = $("#example13-digit-number").val();
                $('#btnnxt').hide();
                $('#btnloadnxt').show();

                $.ajax({
                    type: "POST",
                    url: '../Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                    success: function (data) {
                        $.ajax({
                            type: "POST",
                            url: '../Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1] + '&lat=' + lat + '&long=' + long,
                            success: function (data) {
                                //alert(data);
                                $('#btnnxt').show();
                                $('#btnloadnxt').hide();
                                if (data.split('&')[0] === "1" && data.split('&')[1] === "Auto Max India") {
                                }
                                else {
                                    if (data.split('&')[1] == GlobalCompName || data.split('&')[1] == "" || data.split('&')[1] == undefined) {
                                        $('#Chkcode').hide();
                                        $('#Chkfields').show();
                                        $('#Otherfield').hide();
                                        $('#mobilefield').show();
                                    }
                                    else {
                                        toastr.info("You Can't Use This Coupon");
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



            function ACNamevalid() {
               
                var name = $('#AccountHolderName').val();
                if (name != undefined) {

                    if ($('#AccountHolderName').val().length < 1) {
                        $('#Accountholderchk').html('Please Enter valid account holder name');
                        $('#Accountholderchk').css("color", "red");
                        $('#AccountHolderName').focus();
                        return false;
                    }
                    else {
                        $('#Accountholderchk').html('');
                       
                    }
                    var matches = $('#AccountHolderName').val().match(/\d+/g);
                    if (matches != null) {
                        $('#Accountholderchk').html('account holder name should be alphabet only!');
                        $('#Accountholderchk').css("color", "red");
                        $('#AccountHolderName').focus();
                        return false;
                    }
                    else {
                        $('#Accountholderchk').html('');
                        
                    }
                    var matches1 = $('#AccountHolderName').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        $('#Accountholderchk').html('account holder name should Not Contain any special sharacter!');
                        $('#Accountholderchk').css("color", "red");
                        $('#AccountHolderName').focus();
                        return false;
                    }
                    else {
                        $('#Accountholderchk').html('');
                        return true;
                    }
                }
            }


            function AccountNumberchk() {
                var name = $('#AccountNumber').val();
                if (name != undefined) {

                    if ($('#AccountNumber').val().length < 9) {
                        $('#Accountchk').html('Please enter valid account number');
                        $('#Accountchk').css("color", "red");
                        $('#AccountNumber').focus();
                        return false;
                    }
                    else {
                        $('#Accountchk').html('');
                       
                    }

                    var matches1 = $('#AccountNumber').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        $('#Accountchk').html('account number should Not Contain any special sharacter!');
                        $('#Accountchk').css("color", "red");
                        $('#AccountNumber').focus();
                        return false;
                    }
                    else {
                        $('#Accountchk').html('');
                       
                    }
                }
            }


            function ReAccountNumberchk() {
               
                var name = $('#ConfirmAccountNumber').val();
                if (name != undefined) {

                    if ($('#ConfirmAccountNumber').val().length < 9) {
                        $('#ReAccountchk').html('Please enter valid confirm account number');
                        $('#ReAccountchk').css("color", "red");
                        $('#ConfirmAccountNumber').focus();
                        return false;
                    }
                    else {
                        $('#ReAccountchk').html('');
                       
                    }

                    var matches1 = $('#ConfirmAccountNumber').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        $('#ReAccountchk').html('Confirm account number should Not Contain any special sharacter!');
                        $('#ReAccountchk').css("color", "red");
                        $('#ConfirmAccountNumber').focus();
                        return false;
                    }
                    else {
                        $('#ReAccountchk').html('');
                       
                    }

                    //if ($('#AccountNumber').val() != $('#ConfirmAccountNumber').val) {
                    //    $('#ReAccountchk').html('Confirm Account Number should be as per Account Number');
                    //    $('#ReAccountchk').css("color", "red");
                    //    $('#ConfirmAccountNumber').focus();
                    //    return false;
                    //}
                    //else {
                    //    $('#ReAccountchk').html('');
                        
                    //}
                }
            }

            //$('#AccountHolderName').keyup(function () {
            //    ACNamevalid();
            //});
            $('#AccountNumber').keyup(function () {
                AccountNumberchk();
            });
            $('#ConfirmAccountNumber').keyup(function () {
                ReAccountNumberchk();
            });



            $("#mobile").mask("9999999999");

            $('#mobile').keyup(function () {
                Mobile_check();
            });



            $('#name').keyup(function () {
                Name_check();

            });

            function Name_check() {
                var Name_val = $('#name').val();

                if ((Name_val.length == '')) {
                    $('#namecheck').show();
                    $('#namecheck').html("Please Enter Name");
                    $('#namecheck').css("color", "red");
                    name_err = false;
                    return false;
                }

                if ($('#name').val().match('^[a-z A-Z]{3,30}$')) {
                    $('#namecheck').hide();
                }
                else {
                    $('#namecheck').show();
                    $('#namecheck').html("Please Enter valid name");
                    $('#namecheck').css("color", "red");
                    name_err = false;
                    return false;
                }
            }


            $('#city').keyup(function () {
                city_check();

            });

            function city_check() {

                var city_val = $('#city').val();
                if ($('#city').val().match('^[a-z A-Z]{3,40}$')) {
                    $('#citycheck').hide();
                }

                else {
                    $('#citycheck').show();
                    $('#citycheck').html("Please enter valid city name");
                    $('#citycheck').css("color", "red");
                    city_err = false;
                    return false;
                }
            }


            $('#IfscCode').keyup(function () {
               
                ValidateIfccode(this.value);

            });




            $('#btnsubmit').on('click', function (e) {
                e.preventDefault();
                // Getdata2();
                debugger;
                $('#lblmob').text('');
                var Mobile = $('#mobile').val()
                var pincode = $('#Pin').val()
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
                    $('#lbl').text('Please Enter Your Name!');
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



                var pin = $('#Pin').val();
                if (pin != undefined) {

                    if ($('#Pin').val().length < 6) {
                        $('#pincheck').text('Please Enter Valid Pin Code');
                        return false;
                    }
                    if (pin.match(/[^$,.\d]/)) {
                        $('#pincheck').text("Please Enter Numeric Value For Pin Code.");
                        return false;
                    }

                    var matches1 = $('#Pin').val().match(/[^a-zA-Z0-9 ]/);
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

                if ($('#AccountHolderName').val() == "") {
                    ACNamevalid();
                    return false;
                }

                if ($('#AccountNumber').val() == "") {

                    AccountNumberchk();
                    return false;
                }

                if ($('#ConfirmAccountNumber').val() == "") {

                    ReAccountNumberchk()
                    return false;
                }

                var x = $('#AccountNumber').val();
                var y = $('#ConfirmAccountNumber').val();
                if (x == y) {

                }
                else {
                    $('#ReAccountchk').text("Confirm account number should be same as per account number");;
                    return false;
                }
                if ($('#AccountNumber').val().length < 9) {
                    $('#Accountchk').text('Please Enter valid account number');
                    return false;
                }

                if ($('#ConfirmAccountNumber').val().length < 9) {
                    $('#ReAccountchk').text('Please Enter valid confirm account number');
                    return false;
                }




                var IfscCode = $('#IfscCode').val();
                if (IfscCode.length != 11) {
                    $('#Ifscchk').text("Please enter 11 digit of Ifsc code.");
                    return false;
                }


                if (IfscCode.length == 11) {
                    $.ajax({
                        type: "Post",
                        url: '../Info/MasterHandler.ashx?method=CheckIfcCode&IfcCode=' + IfscCode,
                        success: function (data) {
                           // alert(data);
                            if (data == "0") {
                                $('#Ifscchk').text("Invalid IFSC Code!");
                                return false
                            }
                            else {
                                $('#Ifscchk').text("");
                            }
                        }
                    });

                }


                if (code != "" && $('#AccountNumber').val() != "") {
                    $('#btnsubmit').hide();
                    $('#btnloadsubmit').show();

                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: '../Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#example13-digit-number').val() + '&name=' + $('#name').val() + '&city=' + $('#city').val() + '&state=' + $('#hdnstate').val() + '&PinCode=' + $('#Pin').val() + '&AccountNumber=' + $('#AccountNumber').val() + '&IfscCode=' + $('#IfscCode').val() /*+ '&AccountHolderName=' + $('#AccountHolderName').val()*/ + '&comp=' + GlobalCompName + '&Comp_ID=' + GlobalCompID,
                        success: function (data) {

                            debugger;
                            $('#btnsubmit').show();
                            $('#btnloadsubmit').hide();
                            if (data.split('~')[0] !== "failure") {
                                window.scrollTo(0, 0);
                                if (data.indexOf("not valid") !== -1) {
                                    data = data.split(".")[0];
                                }
                                $('#Heading').hide();
                                $('#Chkfields').hide();
                                $('#mobilefield').hide();
                                $('#Otherfield').hide();
                                $('#ChkCode').hide();
                                $('#ShowMessage').show();
                                if (data.split('~')[1].includes('invalid')) {
                                    $('#p3msg').html("నమోదు చేసిన కోడ్ చెల్లదు. దయచేసి తనిఖీ చేసి, మళ్లీ ప్రయత్నించండి <br> The code entered is invalid. Please check and try again");
                                }
                                else {
                                    $('#p3msg').html(data.split('~')[1]);
                                }
                                
                                $('#p3msg:contains("not")').css('color', 'black');
                            }
                            else if (data.split('~')[0] === "failure") {
                                toastr.info(data.split('~')[1]);
                            }
                            else {
                                $('#msgcoats').hide();
                                toastr.error('OTP is not valid. Please provide the valid OTP');
                                $('#btnskyVerify1').attr('disabled', false);
                            }
                        }
                    });
                }
            });
        });


        //$('#btnNext').click(function () {
        //    window.location.href = 'https://qa.vcqru.com/shreedurga.aspx';
        //});


        function ValidateIfccode(ifscCode) {
            $('#btnsubmit').attr('disabled', true);
            $.ajax({
                type: "Post",
                url: '../Info/MasterHandler.ashx?method=CheckIfcCode&IfcCode=' + ifscCode,
                success: function (data) {
                    //alert(data);
                    if (data == "0") {
                        $('#Ifscchk').text("Invalid IFSC Code!");
                        return false
                    } else {
                        
                        $('#btnsubmit').attr('disabled', false);
                        $('#Ifscchk').html("");
                        return true;
                    }
                }
            });
        }


    </script>

    <!-- header -->
    <div class="top-logo">
        <img src="../assets/images/Shree_Durga_Tradres/img/durga-Logo.png" alt="Logo">
    </div>
    <section class="header">
        <div class="container">
            <div class="row">
                <div class="col-xl-4 col-lg-5">
                    <div class="card">
                        <form id="frm" runat="server">
                            <asp:HiddenField ID="hdnmob" runat="server" />
                            <asp:HiddenField ID="HdnID" runat="server" />
                            <asp:HiddenField ID="HdnCode1" runat="server" />
                            <asp:HiddenField ID="HdnCode2" runat="server" />
                            <asp:HiddenField ID="CompName" runat="server" />
                            <asp:HiddenField ID="long" runat="server" />
                            <asp:HiddenField ID="lat" runat="server" />
                             <asp:HiddenField ID="hdnstate" runat="server" />
                            <div class="card-body bg-warning" id="Heading">
                                <p class="mb-0" style="    font-weight: 600;text-align: center;">
                                    లాభాలు పొందడానికి కింద తెెలెపిన వివరములను నమోదు చెయ్యాలి/<br>
                                    To avail benefits enter
                                below details
                                </p>
                            </div>
                            <div class="card-body">


                                <div class="row">
                                    <div id="Chkcode">
                                        <div class="col-lg-12 mb-3">
                                            <label for="Digit" class="form-label">
                                                13 అంకెల కోడ్ని నమోదు చేయండి/Enter 13
                                            Digit Code<span class="text-danger">*</span></label>
                                            <input type="text" class="form-control form-control-sm" id="example13-digit-number">
                                            <span id="Code1check" style="color:red;font-size: small;"></span>
                                        </div>
                                        <div class="col-lg-12 mb-3">
                                            <button type="submit" id="btnnxt" class="btn btn-warning w-100">తరువాత/Next</button>
                                            <button type="submit" style="display: none" id="btnloadnxt" class="btn btn-warning w-100"><i class="fa fa-spinner fa-spin"></i>Loading..</button>
                                            <span id="nextcheck" style="color:red;font-size: small;"></span>
                                        </div>
                                    </div>
                                    <div id="Chkfields">
                                        <div id="mobilefield">
                                            <div class="col-lg-12 mb-3">
                                                <label for="name" class="form-label">మొబైల్ నంబర్/Mobile Number<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control form-control-sm" id="mobile" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
                                                <span id="mobilecheck" style="color:red;font-size: small;"></span>
                                            </div>
                                        </div>
                                        <div id="Otherfield" style="display: none">
                                            <div class="col-lg-12 mb-3">
                                                <label for="name" class="form-label">పేరు/Name<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control form-control-sm" maxlength="50" id="name">
                                                <span id="namecheck" style="color:red;font-size: small;"></span>
                                            </div>
                                            <div class="col-lg-12 mb-3">
                                                <label for="pincode" class="form-label">పిన్ కోడ్/Pincode<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control form-control-sm" id="Pin" onkeyup="getaddress()" maxlength="6" minlength="6">
                                                <span id="pincheck" style="color:red;font-size: small;"></span>
                                            </div>
                                            <div class="col-lg-12 mb-3">
                                                <label for="city" class="form-label">నగరం/City<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control form-control-sm" maxlength="100" minlength="2" id="city">
                                                <span id="citycheck" style="color:red;font-size: small;"></span>
                                            </div>
                                           <%-- <div class="col-lg-12 mb-3">
                                                <label for="accountno" class="form-label">ఖాతాదారుని పేరు/Account Holder Name<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control form-control-sm" id="AccountHolderName" maxlength="30" autocomplete="off" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode==32">
                                                 <span id="Accountholderchk" style="color:red;font-size: small;"></span>
                                            </div>--%>
                                            <div class="col-lg-12 mb-3">
                                                <label for="accountno" class="form-label">ఖాతా సంఖ్య/Account Number<span class="text-danger">*</span></label>
                                                <input type="password" class="form-control form-control-sm" id="AccountNumber" minlength="9" maxlength="18" data-msg-required="Please Enter Bank Account Number*" pattern="[0-9]+" title="only numbers" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
                                                 <span id="Accountchk" style="color:red;font-size: small;"></span>
                                            </div>
                                            <div class="col-lg-12 mb-3">
                                                <label for="reaccount" class="form-label">
                                                    ఖాతా సంఖ్యను మళ్లీ నమోదు
                                            చేయండి:/Re-Enter Account Number<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control form-control-sm" id="ConfirmAccountNumber" minlength="9" maxlength="18" pattern="[0-9]+" title="only numbers" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
                                                 <span id="ReAccountchk" style="color:red;font-size: small;"></span>
                                            </div>
                                            <div class="col-lg-12 mb-3">
                                                <label for="ifsccode" class="form-label">IFSC కోడ్/IFSC Code<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control form-control-sm" onkeypress="return ValidateAlphaNumeric1(event);" id="IfscCode" maxlength="11" data-msg-required="Please Enter Your IFSC Code*." style="text-transform: uppercase" pattern="[A-Za-z0-9]+" title="letters or numbers only" autocomplete="off">
                                                 <span id="Ifscchk" style="color:red;font-size: small;"></span>
                                            </div>
                                        </div>
                                      <%--  <label id="lblaccount" style="color:red;"></label>
                                        <label id="lbl"></label>--%>
                                        <div class="col-lg-12 text-center">
                                            <button type="submit" id="btnsubmit" class="btn btn-warning w-100">సమర్పించండి/Submit</button>
                                            <button type="submit" style="display: none" id="btnloadsubmit" class="btn btn-warning w-100"><i class="fa fa-spinner fa-spin"></i>Loading..</button>
                                        </div>
                                    </div>
                                    
                                </div>

                            </div>
                            <div style="display: none;" id="ShowMessage">
                                <div class="form-box">
                                    <p id="p3msg" style="overflow: hidden; border:thick; color: black; font-size: 13px !important; font-weight: 500; margin-left: 7px; margin-right: 7px;" class="displayNone massage_box text-center"></p>
                                    <br />
                                    <center><a href="https://www.vcqru.com/durga.aspx" class="btn-2 mb-1" id="btnNext">Close</a></center>
                                </div>
                            </div>
                              <h6 class="text-centre text-black pt-2 qr-heading text-center" style="font-size: 14px;">QR/కోడ్ సంబంధిత మద్దతు అందుబాటులో ఉంది/QR/Code Related Support Available on</h6>
                                <p class="text-white text-center number-style">
                                    <img src="../assets/images/Oltimo/telephone.png" style="width: 20px;">  <a href="tel:07353000903">07353000903</a> 
                                    <%--<img src="../assets/images/Oltimo/whatsapp.png" style="width: 20px;">  <a href="https://api.whatsapp.com/send?phone=+919355903119&amp;text&amp;type=phone_number&amp;app_absent=1" target="blank">9355903119</a>--%>
                                </p>
                        </form>
                    </div>
                    <!-- slider -->
                    <div class="app-slider mt-3 mb-5">
                        <div id="carouselExampleInterval" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active" data-bs-interval="10000">
                                    <ul>
                                        <li>
                                            <img src="../assets/images/Shree_Durga_Tradres/img/Sceptre-img.jpeg" alt="Sceptre-img">
                                        </li>
                                        <li>
                                            <img src="../assets/images/Shree_Durga_Tradres/img/Million-img.jpeg" alt="Million-img">
                                        </li>
                                        <li>
                                            <img src="../assets/images/Shree_Durga_Tradres/img/Meta-sheet-img.jpeg" alt="Meta-sheet-img">
                                        </li>
                                    </ul>
                                </div>
                                <div class="carousel-item" data-bs-interval="10000">
                                    <ul>
                                        <li>
                                            <img src="../assets/images/Shree_Durga_Tradres/img/sceptre-gold-img.jpeg" alt="sceptre-gold-img">
                                        </li>
                                        <li>
                                            <img src="../assets/images/Shree_Durga_Tradres/img/Fire-img.jpeg" alt="Fire-img">
                                        </li>
                                        <li>
                                            <img src="../assets/images/Shree_Durga_Tradres/img/million-logo.jpeg" alt="million-logo">
                                        </li>
                                    </ul>
                                </div>
                                <div class="carousel-item" data-bs-interval="10000">
                                    <ul>
                                        <li>
                                            <img src="../assets/images/Shree_Durga_Tradres/img/Measuturing-tape-img.jpg" alt="Measuturing-tape-img">
                                        </li>
                                        <li>
                                            <img src="../assets/images/Shree_Durga_Tradres/img/Welding-holders-img.jpeg" alt="Welding-holders-img">
                                        </li>
                                        <li>
                                            <img src="../assets/images/Shree_Durga_Tradres/img/wedding-safety-img.jpg" alt="wedding-safety-img">
                                        </li>
                                    </ul>
                                </div>
                                <div class="carousel-item" data-bs-interval="10000">
                                    <ul>
                                        <li>
                                            <img src="../assets/images/Shree_Durga_Tradres/img/Shuttering-tape-img.jpg" alt="Shuttering-tape-img">
                                        </li>
                                        <li>
                                            <img src="../assets/images/Shree_Durga_Tradres/img/Sds-scew-img.jpg" alt="Sds-scew-img">
                                        </li>
                                        <li>
                                            <img src="../assets/images/Shree_Durga_Tradres/img/Johnson-img.jpg" alt="Johnson-img">
                                        </li>
                                    </ul>
                                </div>
                                <div class="carousel-item" data-bs-interval="10000">
                                    <ul>
                                        <li>
                                            <img src="../assets/images/Shree_Durga_Tradres/img/Chicken-mesh-img.jpg" alt="Chicken-mesh-img">
                                        </li>
                                        <li>
                                            <img src="../assets/images/Shree_Durga_Tradres/img/Safety-gloves-img.jpg" alt="Safety-gloves-img">
                                        </li>
                                        <li>
                                            <img src="../assets/images/Shree_Durga_Tradres/img/Sceptre-img.jpeg" alt="Sceptre-img">
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button"
                                data-bs-target="#carouselExampleInterval" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button"
                                data-bs-target="#carouselExampleInterval" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                        <p class="text-center mb-0 text-warning fw-bold">అగ్ని ఉంది మరియు అది ఆగదు </p>
                    </div>
                    <div class="col-lg-6">
                        <div class="hero-img d-lg-block d-none">
                            <img src="../assets/images/Shree_Durga_Tradres/img/large_img.png" alt="">
                        </div>
                    </div>
                    <div class="col-md-12 d-lg-none d-bock">
                      <img src="../assets/images/Shree_Durga_Tradres/img/large_img.png" class="img-fluid" alt="">
                    </div>
                </div>
            </div>
        </div>
        <div class="copyright">
            <div class="container">
                <p>కలిసి భారత్ ని చేద్దాం:Let's make bharath together</p>
            </div>
        </div>
    </section>
    <!-- js -->
    <script src="../assets/images/Shree_Durga_Tradres/js/js.js"></script>
</body>

</html>
