<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BscPaint.aspx.cs" Inherits="BscPaint" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <script src="https://use.fontawesome.com/53f5a10329.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="Content/js/jquery-1.11.1.min.js"></script>
    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>
    <title>BSC Paints</title>

   <style>
        * {
            margin: 0px;
            padding: 0px;
        }

        .bsc-paints {
            background-image: url(assets/images/bsc-paint-img/bg1.png);
            background-repeat: no-repeat;
            background-position: top;
            background-size: cover;
            width: 100%;
            position: relative;
            display: table;
            height: 100vh;
            /*padding: 10px 0px;*/
        }

            .bsc-paints .bsc-paints-logo {
                width: 31%;
                padding: 18px;
            }

        .CV-title {
            color: #fff;
            font-size: 42px;
            font-weight: 800;
            text-align: left !important;
            margin-top: 50px !important;
        }

            .CV-title span {
                color: #ffcc29;
            }

        .bsc-paint-product {
            width: 90%;
        }
        .custom_code{
            padding-bottom:6%;
        }
            .custom_code p {
                color: #fff;
                font-weight: 500;
                background-color: #3e4095b8;
                padding: 10px 15px;
                border-radius: 10px;
                margin-top: 3%;
               
                text-align: center;
            }

            #wlink{
                 width:75%;
            }

            .custom_code p a{
                color: #fff;
                text-decoration:none;
            }

       /* .blink_me {
            animation: blinker 1s linear infinite;
        }

        @keyframes blinker {
            50% {
                opacity: 0;
            }
        }*/

        .form-box {
            background-color: #3e4095b8;
            display: table;
            width: 75%;
            border-radius: 25px;
            border: 5px solid #fff;
            padding-bottom: 15px;
            margin-bottom: 7%;
        }

            .form-box h5 {
                text-align: center;
                width: 100%;
                color: #3e4095;
                background-color: #ffffff;
                padding: 16px 14px 35px 14px;
                border-bottom-right-radius: 70%;
                border-bottom-left-radius: 70%;
                margin: -1px auto;
                border-top-left-radius: 23px;
                border-top-right-radius: 23px;
                margin-bottom: 33px;
                line-height: 22px;
                font-size: 100%;
                font-weight: 700;
            }

        .bsc-paints .form-box button {
            background: rgb(253,194,216);
            background: linear-gradient(90deg, rgba(253,194,216,1) 0%, rgba(252,166,94,1) 35%, rgba(255,121,131,1) 58%, rgba(4,18,130,1) 100%);
            color: #fff;
            margin-top: 5%;
            padding: 5px 32px;
            border-radius: 13px;
            font-weight: 600;
            box-shadow: 0px 0px 7px #ffffff8a;
            border:1px solid #fff;
        }

            .bsc-paints .form-box button:hover {
                background: rgb(253,194,216);
                background: linear-gradient(245deg, rgba(253,194,216,1) 0%, rgba(252,166,94,1) 35%, rgba(255,121,131,1) 58%, rgba(4,18,130,1) 100%);
            }

        .width-box {
            width: 94%;
            margin: auto;
        }

            .width-box input {
                border-radius: 5px;
                background-color: #ffffff;
                margin-bottom: 7px;
                font-size: 13px;
                padding: 8px 10px;
                transition-duration: 0.5s;
            }

             .width-box input a{
                 text-decoration:none;
             }
             .width-box input a:hover{
                 color:#fb0202;
             }

            .width-box label {
                font-size: 12px;
                color: #fff;
            }

            .width-box input:focus {
                color: #212529;
                background-color: #e4e7ec;
                outline: 0;
                box-shadow: 0px 0px 0px;
                font-size: 13px;
                border: 2px solid #ffcc29;
            }
        .footer {
            text-align: center;
            padding: 10px 0px;
            position: absolute;
            bottom: 3px;
            margin: auto;
            left: 50%;
            transform: translate(-50%);
            color: #fff;
        }
        .footer span a {
            color: #fff !important;
            text-decoration: none !important;
        }
         .footer span {
            color: #fff !important;
            
        }

        .icons {
            font-size: 24px;
        }

        .icons a{
            color:#fff;
        }





        @media screen and (max-width:767px) {
            /*.custom_code {
                flex-direction: column-reverse;
                margin-top: 22px;
            }*/
            .bsc-paints .bsc-paints-logo {
                width: 100%;
                padding: 18px;
            }
            .color-valley-product {
                width: 100%;
            }

            .form-box {
                width: 100%;
            }
            .bsc-paint-product {
                width: 100%;
            }
            .footer {
                position: initial;
                transform: initial;
            }
            #wlink {
                width: 100%;
            }
            
        }

        @media screen and (min-width:768px) and (max-width:920px) {
            .bsc-paint-product {
                width: 60%;
                position: absolute;
                right: 0px;
                bottom: 75px;
            }
            
        }
        /* @media screen and (width:820px){
            .color-valley-product {
                width: 63%!important;

            }
        }*/
        @media screen and (width: 540px) 
       {
        .form-box {
            width: 80%;
            margin: auto;
        }
        }
        @media screen and (min-width:768px) and (max-width:1280px) {
            /*.footer a {
             
                position: absolute;
                bottom: 16px;
                
            }*/
            .form-box {
                margin-top: 15%;
                width: 100%;
            }
            #wlink{
                 width:100%;
            }

        }
        @media screen and (width: 1024px) {
            .bsc-paint-product {
                width: 100%;
                margin-top: 12%;
            }
            .form-box {
                margin-top: 10%;
            }
        }
        @media screen and (width: 1280px) {
            .bsc-paint-product {
                width: 100%;
                margin-top: 6%;
            }

            .form-box {
                margin-top: 10%;
            }
        }

        @media screen and (min-width:1300px) and (max-width:1700px) {
            .bsc-paint-product {
                width:90%;
                margin-top: -10%;
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

        function Getdata() {
            debugger;
            var mobileno = document.querySelector("#mobilenumber").value;
            var d = mobileno.slice(0, 1);
            var c = parseInt(d);

            if (mobileno.match(/[^$,.\d]/)) {
                toastr.error("Please enter numeric value for mobile No.");
                $('#mobilenumber').val() == "";
                $('#btnsubmit').attr('disabled', false);
                return false;
            }

            else {

                if (mobileno.length == 10)
                {
                    var codeone = getUrlVars()["codeone"];
                    var codetwo = getUrlVars()["codetwo"];

                    if (codeone == undefined && codetwo == undefined)
                    {
                        var completeCode = $("#codeone").val();
                        var arr = completeCode.split('-');
                        codeone = arr[0];
                        codetwo = arr[1];
                    }
                        

                    $.ajax({
                        type: "Post",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=AUCConsumerDetailsByMobileNo&MobileNo= ' + $("#mobilenumber").val() + '&codeone= ' + codeone + '&codetwo= ' + codetwo,
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
                                if (Name != "") {
                                    $("#Name").val(Name);
                                }
                                 /*Auto Cash Transfer Start */
                                if (Name == "") {
                                    $('#otherfield').show();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#DivBankDetails').hide();
                                }
                                if (pin != "") {
                                    $("#pin").val(pin);
                                }
                                if (pin == "") {
                                    $('#otherfield').show();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#DivBankDetails').hide();
                                }
                               

                                if (city != "")
                                {
                                    $("#city").val(city);
                                }
                                if (city == "") {
                                    $('#otherfield').show();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                    $('#DivBankDetails').hide();
                                }
                              
                                if (count.length > 7) {
                                    var BankName = data.split('~')[7];
                                    if (BankName == "") {
                                        $('#otherfield').show();
                                        $('#mobilefield').hide();
                                        $('#Chkfields').show();
                                        $('#DivBankDetails').show();
                                    }
                                }
                                else

                                {
                                    $('#DivBankDetails').hide();
                                }

                                /*Auto Cash Transfer End*/
                            }
                        }
                    });
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
            else {
                $('#city').val(''); 
            }





        }
        function pinval() {
            var pin = $('#pin').val();
            if (pin != undefined) {

                if ($('#pin').val().length < 1) {
                    toastr.error('Please Enter valid Pin Code');
                    $('#city').val() = '';
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


        function validation() {
            if ($('#pin').val() == '') {
                toastr.error('Please enter pin frist.');
                return false;
                $('#btnsubmit').attr('disabled', false);
            }
        }

        function namevalid() {
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
        }

        /* Auto Cash Transfer Start*/

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
        }





        $(document).ready(function () {


            $('#ChkCode').show();
            $('#Chkfields').hide();

            firstfunction();


            var id = $('#HdnID').val();


            if (id == "1") {

                $('#ChkCode').show();
                $('#Chkfields').hide();
            }

            else if (id == "BSC") {
                $('#ChkCode').hide();
                $('#otherfield').hide();
                $('#mobilefield').show();
                $('#Chkfields').show();
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
                    //if (codeone.match(/[^$,.\d]/)) {
                    //    toastr.error("Please enter numeric value for Code.");
                    //    validate = false;
                    //    return false;
                    //}

                    //var matches1 = $('#codeone').val().match(/[^a-zA-Z0-9 ]/);
                    //if (matches1 != null) {
                    //    toastr.error('Code Should Not Contain any Special Character!');
                    //    validate = false;
                    //    return false;
                    //}
                }



                /*if (this.value.length == this.maxLength) {*/
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
                                        $('#Chkfields').show();
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
                var mobilenumber = $('#mobilenumber').val();
                var pincode = $('#pin').val();
                var d = mobilenumber.slice(0, 1);
                var c = parseInt(d);

                if ($('#mobilenumber').val() == "") {
                    toastr.error("Please Enter Mobile No.");
                    $('#btnsubmit').attr('disabled', false);
                    return false;

                }


                //if (mobilenumber.match(/[^$,.\d]/)) {
                //    toastr.error("Please enter numeric value for mobile No.");
                //   $('#mobilenumber').val() == "";
                //    $('#btnsubmit').attr('disabled', false);
                //    validate = false;
                //}


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

                   
                    if ($('#pin').val() == "") {
                        pinval();
                        $('#city').val() == "";
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    if (pincode.length != 6) {
                        toastr.error("Please enter 6 digit of Pin No .");
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    if ($('#city').val() == "") {
                        cityvalid();
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                }


                var dim = $('#DivBankDetails').is(":visible");
                if (dim == true)

                {

                    var AcHLength = $('#AccountHolderName').val();
                    if (!AcHLength.replace(/\s/g, '').length)
                    {
                        toastr.error("Please enter valid account holder name .");
                        $("#btnsubmit").removeAttr("disabled");
                        return false;
                    }
                    if ($('#AccountHolderName').val() == "" || AcHLength.length == 1) {
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
                    if (x.length < 9 || x.length >18) {
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
                    else
                    {
                       
                        if (!IfscCode.match(/[a-zA-Z0-9]*$/))
                        {
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
                



                //return false;
                //$('#btnsubmit').attr('disabled', false);

                //else {
                //    othervalid();
                //    $('#btnsubmit').attr('disabled', false);
                //    return false;
                //}
                // $('#btnsubmit').attr('disabled', false);
                //$('#otherfield').show();
                //$('#mobilefield').hide();
                // $('#Chkfields').show();



                // validate = false;

                // if (validate) {
                $('#p3msg').html('');


                if (code != "") {
                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&name=' + $('#Name').val() + '&city=' + $('#city').val() + '&PinCode=' + $('#pin').val() + '&comp=' + $('#CompName').val() + '&Comp_ID=Comp-1275&AccountNumber=' + $('#AccountNumber').val() + '&IfscCode=' + $('#IfscCode').val() + '&AccountHolderName=' + $('#AccountHolderName').val() + '&TNC=' + chkboxValue,
                            success: function (data) {
                                debugger;
                                if (data == "Kindly enter valid IFSC code !.")
                                {
                                    toastr.error(data);
                                    $("#btnsubmit").removeAttr("disabled");
                                    return false;
                                }
                                else if (data.split('~')[0] !== "failure")
                                {
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
                                else if (data.split('~')[0] == "failure")
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
                window.location.href = 'https://www.bscpaints.com/';
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
        function allowOnlyLetters(e, t) {
            if (window.event) {
                var charCode = window.event.keyCode;
            }
            else if (e) {
                var charCode = e.which;
            }
            else { return true; }
            if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123))
                return true;
            else {
                alert("Please enter only alphabets");
                return false;
            }
        }

        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }

        function isNumber(evt, cntrl_id) {
            debugger;
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;


            if ($('#' + cntrl_id).val().length == 0) {

                if (parseInt(evt.key) > 6)
                    return true;

            }
            if ($('#' + cntrl_id).val().length > 10) {

                return false;

            }
            if (charCode >= 96 && charCode <= 105) {
                return true;
            }
            if (charCode >= 48 && charCode <= 57)
                return true;
            if (charCode == 8)
                return true;
            if (charCode == 46)
                return false;

            return false;
        }

    </script>

</head>

<body>
    <section class="bsc-paints">
        <header>
            <div class="container">
                <a href="https://www.bscpaints.com/" target="_blank">
                    <img src="assets/images/bsc-paint-img/bsc-paints-logo.png" alt="bsc-paint-logo" class="img-fluid bsc-paints-logo animate__animated animate__pulse" /></a>
            </div>
        </header>
        <section class="container">

            <div class="row custom_code">

                <div class="col-sm-5">
                    <form class="bsc-paints-form">
                        <div class="form-box  animate__animated animate__backInLeft">
                            <form class="form1" runat="server">
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
                                            <h5 class="text-uppercase">to check authenticity And
                                                <br />
                                                Avail Benefits</h5>
                                        </div>
                                    </div>
                                    <div class="width-box">
                                        <div id="ChkCode">
                                            <div class="col-sm-12">
                                                <input type="text" maxlength="13" minlength="13" id="codeone" class="form-control" onkeypress="return onlyNumberKey(event)" placeholder="Enter 13-Digit Code *" />
                                            </div>
                                            <div>
                                                <center>
                                                    <button type="button" data-toggle="modal" id="btnnxt" class="btn text-uppercase">Next</button>
                                                </center>
                                            </div>
                                        </div>
                                        <div id="Chkfields">
                                            <div id="mobilefield">
                                                <div class="col-12">
                                                    <input type="text" maxlength="10" id="mobilenumber" minlength="10" data-msg-required="Please Enter Your Moblie Number" onkeyup="Getdata()" class="form-control" onkeypress="return onlyNumberKey(event)" placeholder="Enter Mobile Number *" />
                                                </div>
                                            </div>
                                            <div id="otherfield" style="display: none">
                                                <div class="col-12">
                                                    <input type="text" class="form-control" onkeypress="return ValidateAlpha(event);" id="Name" placeholder="Enter Name*" />
                                                </div>
                                                <div class="col-12">
                                                    <input type="text" maxlength="6" minlength="6" class="form-control" id="pin" onkeypress="return onlyNumberKey(event)" onkeyup="getaddress()" placeholder="Pin Code *" />
                                                </div>
                                                <div class="col-12">
                                                    <input type="text" class="form-control" onkeypress="return ValidateAlpha(event);" id="city" placeholder="Enter City*" />
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
                                                    <input type="checkbox" id="chkbox" data-msg-required="Please select checkbox*" /><span style="color:#fff;"> Please Accept <a style="color:#fff; text-decoration:none;" href="TermsNCondtions.aspx" ><b>Terms and Conditions</b></a></span>
                                                </div>
                                                    </div>

                                                 <%--Auto Cash Transfer End--%>

                                            </div>
                                            <div class="col-12 text-center">
                                                <button type="button" id="btnsubmit" data-bs-toggle="modal" data-bs-target="#exampleModal" class="btn text-uppercase">SUBMIT</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div style="display: none;" id="ShowMessage" class="row no-gutters pl-4 pr-4 textmessage">
                                    <center>
                                        <div class="col-md-12">
                                            <br />
                                            <div class="form-group" style="padding: 20px;">
                                                <p id="p3msg" style="overflow: hidden; color: white; font-size: 14px !important;" class="displayNone massage_box"></p>
                                            </div>
                                            <a href="javascript:void(0)" class="next_btn" id="btnNext"><b>Close</b></a>

                                        </div>
                                    </center>
                                </div>
                            </form>
                        </div>
                    </form>
                    <p id="wlink" class="blink_me">QR/Code  Related Support Available on <br /><a href="tel:8047278314">8047278314</a> / <i class="fa fa-whatsapp" aria-hidden="true"></i> <a href="https://api.whatsapp.com/send?phone=+917669017712&text&type=phone_number&app_absent=1" target="blank">7669017721</a> </p>
                </div>
                <div class="col-sm-7 text-center">

                    <img src="assets/images/bsc-paint-img/product.png" alt="bsc-paints-product-img" class="img-fluid bsc-paint-product animate__animated animate__fadeInLeft" />
                </div>
            </div>

            <!-- Popup start -->

                        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                              <div class="modal-content">
                                <div class="modal-header">
                                  
                                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="container text-center p-4">
                                        <h1 class="pb-4">Congratulations!</h1>
                                        <p>
                                            Your coupon redemption was successful. The amount will be transferred to your bank account within 2 
                                            working hours from Monday to Friday during banking operational time. If the coupon was checked after banking 
                                            operational time, the transfer will occur on the next working day.
                                        </p>
                                        <p class="text-bold">
                                            Thank you for choosing our services. If you have any questions, please contact our customer support team.
                                        </p>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                  
                                </div>
                              </div>
                            </div>
                          </div> 



            <!-- Popup end -->

        </section>
        <footer class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="icons">

                            <a target="_blank" href="https://www.instagram.com/bscpaints.in/?igshid=OTJlNzQ0NWM%3D"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                            <a target="_blank" href="https://www.facebook.com/bscpaints?mibextid=ZbWKwL"><i class="fa fa-facebook-square" aria-hidden="true"></i></a>
                            <a target="_blank" href="https://twitter.com/bscpaints"><i class="fa fa-twitter-square" aria-hidden="true"></i></a>

                        </div>
                        <a href="mailto:info@bscpaints.com" target="_blank" class="footer-link">info@bscpaints.com</a> |
                        <a href="tel:1800 11 4663" target="_blank" class="footer-link">1800 11 4663</a> |
                        <a href="https://www.bscpaints.com/" target="_blank" class="footer-link">www.bscpaints.com</a>
                    </div>
                </div>
            </div>
        </footer>
    </section>


</body>
</html>
