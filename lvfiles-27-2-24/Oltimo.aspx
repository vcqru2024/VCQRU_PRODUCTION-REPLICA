<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Oltimo.aspx.cs" Inherits="Oltimo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Oltimolubes</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <%--  <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>--%>
    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="../Content/js/jquery-1.11.1.min.js"></script>
    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>

    <style type="text/css">

        .clbl {
            color: #ff0101;
            /* background-color: red; */
            text-align: center;
            font-size: 14px;
            font-weight: bold;
        }

        .background {
            position: relative;
            background-size: 100% 100%;
            background-repeat: no-repeat;
            width: 100%;
            display: table;
            height: 100vh;
            background-image: url('../assets/images/Oltimo/Bg.png');
        }

        .logo-img img {
            width: 18%;
        }

        form:before {
            height: 100%;
            content: "";
            background: black !important;
            position: absolute;
            width: 100% !important;
            z-index: -1;
            opacity: 0.9;
        }

        form {
            border-radius: 10px;
            box-shadow: 0px 0px 2px #2f2e2e;
        }

        .btn {
            width: 100%;
            background-color: #ffd800;
            outline: none;
            border: none;
            color: black;
        }

        .form-maine input::placeholder {
            color: #0a0a0a !important;
        }

        form input {
            background: #dce0ec !important;
            border-radius: 3px !important;
        }

        .HEADING {
            padding: 15px;
            text-align: center;
            color: #fff;
        }

            .HEADING h6 {
                color: #ffd800;
            }

        .form-select {
            background-color: #dce0ec;
        }


        .uploadFile {
            width: 100%;
            background-color: #dce0ec;
            border: 1px solid grey;
            color: black;
            font-size: 16px;
            line-height: 23px;
            overflow: hidden;
            padding: 10px 10px 4px 10px;
            position: relative;
            resize: none;
            [type="file"]

        {
            cursor: pointer !important;
            display: block;
            font-size: 999px;
            filter: alpha(opacity=0);
            min-height: 100%;
            min-width: 100%;
            opacity: 0;
            position: absolute;
            right: 0px;
            text-align: right;
            top: 0px;
            z-index: 1;
        }

        }


        footer {
            padding: 8px;
            background: #eb3438;
            position: absolute;
            width: 100%;
            bottom: 0px;
        }

        .number-style a {
            color: #fff;
            text-decoration: none;
        }

        .product-img img {
            /* top: 0%; */
            bottom: 9%;
            /* right: 7%; */
            padding: 0 5%;
        }

        .form-maine {
            padding: 0px 28px 5px;
            margin-bottom: 70px;
        }

        @media screen and (max-width: 767px) {

            .product-img img {
                position: unset;
                /* margin-top: 53px; */
                margin-bottom: 30px;
                width: 100%;
            }

            .background {
                position: relative;
                background-size: cover;
                background-repeat: no-repeat;
                width: 100%;
                display: table;
                height: 100vh;
               /* background-image: url(./img/Bg.png);*/
            }

            .product-img {
                margin-bottom: 30px;
            }

            .qr-heading {
                font-size: 16px;
            }

            .logo-img {
                text-align: center;
            }

                .logo-img img {
                    width: 64%;
                }
        }

        @media screen and (min-width: 768px) and (max-width: 1024px) {
            .product-img img {
                position: unset;
                /* top: 59%; */
                /* right: 2%; */
                padding: 0 5%;
            }

            .qr-heading {
                font-size: 17px;
                text-align: center;
            }

            .product-img {
                margin-bottom: 70px;
            }
        }

        @media screen and (min-width: 1025px) and (max-width: 1200px) {
            .product-img img {
                position: absolute;
                /* top: 0%; */
                bottom: 0%;
                /* right: 7%; */
                padding: 0 5%;
            }
        }

        @media screen and (width: 1024px) {
            .product-img img {
                position: absolute;
                width: 35%;
                /* top: 59%; */
                /* right: 2%; */
            }
        }

        @media screen and (width: 1000px) {
            .product-img img {
                position: absolute;
                width: 35%;
                /* top: 59%; */
                /* right: 2%; */
            }
        }
    </style>

    <script>
        $("#codeone").mask("99999-99999999");
        $("#mobile").mask("9999999999");
        $("#Pincode").mask("999999");
        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
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
                        var city = data[0].PostOffice[0]['District'];
                        var state = data[0].PostOffice[0]['State'];
                        var Pin = data[0].PostOffice[0]['PinCode'];
                        $("#city").val(city);
                        $("#state").val(state);
                        if (pin == "") {
                            $("#pin").val();
                        }
                        else {
                            $("#pin").val(Pin);
                        }
                        $('#btnsubmit').attr('disabled', false);
                    }
                    else {
                        $('#lblddl').text('Please enter valid pin*');
                        $('#lblddl').css("color", "red");
                        $('#pin').focus();
                        //$('#btnsubmit').attr('disabled', true);
                        return false;
                    }
                }
            }
            else {
                $("#city").val('');
                $("#state").val('');
                $('#lblddl').text('Please enter valid pin*');
            }
        }


        function ValidateAccount() {
            var AccountNumber = $('#AccountNumber').val();
            if (AccountNumber != undefined) {

                if ($('#AccountNumber').val().length < 1) {
                    $('#lbl').text('Please Enter valid account number');
                    return false;
                }

            }

            var ConfirmAccountNumber = $('#ConfirmAccountNumber').val();
            if (ConfirmAccountNumber != undefined) {

                if ($('#ConfirmAccountNumber').val().length < 1) {
                    $('#lbl').text('Please Enter valid confirm account number');
                    return false;
                }

            }
        }

        function ACNamevalid() {
            var name = $('#AccountHolderName').val();
            if (name != undefined) {

                if ($('#AccountHolderName').val().length < 1) {
                    $('#lbl').text('Please Enter valid account holder name');
                    return false;
                }
                var matches = $('#AccountHolderName').val().match(/\d+/g);
                if (matches != null) {
                    $('#lbl').text('account holder name should be alphabet only!');
                    return false;
                }
                var matches1 = $('#AccountHolderName').val().match(/^[a-zA-Z0-9!@#\$%\^\&*\)\(+=._-]+$/g);
                if (matches1 != null) {
                    $('#lbl').text('account holder name should Not Contain any special sharacter!');
                    return false;
                }
            }
        }
       
      

        function Getdata() {
            debugger;
            var mobileno = $('#mobile').val();
            var d = mobileno.slice(0, 1);
            var c = parseInt(d);

            $("#Name").val('');
            $("#pin").val('');
            $("#city").val('');
            $("#state").val('');
            $('#AccountNumber').val('');
            $('#IfscCode').val('');
            $('#AccountHolderName').val('');
            $('#ConfirmAccountNumber').val('');
            $("#Name").text('');
            $("#pin").text('');
            $("#city").text('');
            $("#state").text('');
            $('#AccountNumber').text('');
            $('#ConfirmAccountNumber').text('');
            $('#IfscCode').text('');
            $('#AccountHolderName').text('');


            if ($('#dealer').val() == "") {
                $('#lbl').text('Please Enter Dealer Name!');
                return false;
            }
            else {
                $('#lbl').text('');
            }

            if ($('#dealer').val().replace(/\s+/g, '').length == 0) {
                $('#lbl').text('Please Enter Dealer Name!');
                $('#dealer').focus();
                $('#dealer').attr('disabled', false);
                return false;
            }

            var matches11 = $('#dealer').val().match(/\d+/g);
            if (matches11 != null) {
                $('#lbl').text('Dealer name should be lphabet only!');
                $('#dealer').focus();
                $('#btnsubmit').attr('disabled', false);
                $('#dealer').val('');
                return false;
            }
            else {
                $('#lbl').text('');
            }
            var matches2 = $('#dealer').val();
            if (matches2.includes('~') || matches2.includes('!') || matches2.includes('@') || matches2.includes('#') || matches2.includes(')') || matches2.includes('_') || matches2.includes('-') || matches2.includes('>') || matches2.includes(',') || matches2.includes('?')
                || matches2.includes('$') || matches2.includes('%') || matches2.includes('^') || matches2.includes('&') || matches2.includes('*') || matches2.includes('(') || matches2.includes('+') || matches2.includes('<') || matches2.includes('.')
                || matches2.includes('=') || matches2.includes('{') || matches2.includes('}') || matches2.includes('[') || matches2.includes(']') || matches2.includes(':') || matches2.includes(';') || matches2.includes('"') || matches2.includes('/')
            ) {
                $('#lbl').text('Special Character Not Allow*');
                $('#dealer').focus();
                $('#dealer').val('');
                $('#btnsubmit').attr('disabled', false);
                $('#dealer').val('');
                return false;
            }
            else {
                $('#lbl').text('');
            }

            var fd = new FormData();
            var files = $('#file')[0].files[0];

            if (files == undefined || files == "undefined") {
                $('#lbl').text('Please Select Selfie With Product');
                $('#file').focus();
                $('#btnsubmit').attr('disabled', false);
                return false;
            }
            else {
                $('#lbl').text('');
            }
            fd.append('file', files);


            if ($('#mobile').val() == "") {
                $('#lbl').text('Please Enter Mobile Number!');
                $('#mobile').focus();
                return false;
            }
            else {
                $('#lbl').text('');
            }
            if (mobileno.length < 10) {
                $('#lbl').text('Please Enter 10 Digit Mobile Number!');
                $("#Name").val('');
                $("#pin").val('');
                $("#city").val('');
                $("#state").val('');
                $('#AccountNumber').val('');
                $('#IfscCode').val('');
                $('#AccountHolderName').val('');
                $('#ConfirmAccountNumber').val('');
                $("#Name").text('');
                $("#pin").text('');
                $("#city").text('');
                $("#state").text('');
                $('#AccountNumber').text('');
                $('#ConfirmAccountNumber').text('');
                $('#IfscCode').text('');
                $('#AccountHolderName').text('');
                return false;
            }
            else {
                $('#lbl').text('');
            }
            if (mobileno.match(/[^$,.\d]/)) {
                $('#lbl').text('Mobile Number Shoud Not be Alphabet!');
                $('#mobile').val('');
                return false;
            }
            else {
                $('#lbl').text('');
            }
            if (mobileno.length == 10) {
                var codes = $('#codeone').val();
                var code1 = codes.split('-')[0];
                var code2 = codes.split('-')[1];
                $.ajax({
                    type: "Post",
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNo2&MobileNo= ' + $("#mobile").val() + '&codeone= ' + code1 + '&codetwo= ' + code2,
                        success: function (data) {
                        if (c <= 5) {
                            $('#lbl').text('Please Enter Valid Mobile Number!');
                            $('#mobile').val('');
                            $('#mobile').focus();
                            return false;
                        }
                        else {
                            var Name = data.split('~')[0];
                            var pin = data.split('~')[6];
                            var city = data.split('~')[2];
                            var state = data.split('~')[3];
                            var shopname = data.split('~')[4];
                            var BankName = data.split('~')[7];
                            var AccountNumber = data.split('~')[8];
                            var IfscCode = data.split('~')[9];
                            var AccountHolderName = data.split('~')[10];
                            var BranchName = data.split('~')[11];




                            
                            if (Name != "") {
                                $("#Name").val(Name);
                                //document.getElementById("Name").readOnly = true;
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
                                //document.getElementById("pin").readOnly = true;
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
                                //document.getElementById("city").readOnly = true;
                            }
                            else {
                                $('#ChkCode').hide();
                                $('#otherfield').show();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#DivBankDetails').hide();
                            }
                            if (state != "") {
                                $("#state").val(state);
                                //document.getElementById("state").readOnly = true;
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

                        }
                    }
                });
            }
            else {
                $('#lbl').text('Invalid Mobile Number');
                $("#Name").val('');
                $("#pin").val('');
                $("#city").val('');
                $("#state").val('');
                $('#AccountNumber').val('');
                $('#IfscCode').val('');
                $('#AccountHolderName').val('');
                $('#ConfirmAccountNumber').val('');
                $("#Name").text('');
                $("#pin").text('');
                $("#city").text('');
                $("#state").text('');
                $('#AccountNumber').text('');
                $('#ConfirmAccountNumber').text('');
                $('#IfscCode').text('');
                $('#AccountHolderName').text('');
            }
        }


        function fileValidation() {
            var fileInput =
                document.getElementById('file');

            var filePath = fileInput.value;

            // Allowing file type
            var allowedExtensions =
                /(\.jpg|\.png|\.jpeg)$/i;

            if (!allowedExtensions.exec(filePath)) {
                alert('Invalid file type');
                fileInput.value = '';
                return false;

            }
        }


        $(document).ready(function () {
            debugger;
            $('#ChkCode').show();
            $('#Chkfields').hide();
            $('#mobilefield').hide();
            $('#DivBankDetails').hide();
            
            var id = $('#HdnID').val();
            if (id == "1") {

                $('#ChkCode').show();
                $('#Chkfields').hide();
                $('#mobilefield').hide();
            }

            else if (id == "Oltimo") {
                $('#ChkCode').hide();
                $('#otherfield').hide();
                $('#mobilefield').show();
                $('#Chkfields').show();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $("#codeone").val(code);
            }




            $("#codeone").mask("99999-99999999");

            //$("#btnnxt").on('click', function () {
            //    debugger;
            //    var codeone = $('#codeone').val();
            //    if (codeone != undefined) {
            //        if ($('#codeone').val().length < 14) {
            //            $('#lblcode').text('Please Enter 13 Digit Code*');
            //            $('#codeone').focus();
            //            return false;
            //        }
            //        else {
            //            $('#lblcode').text('');
            //        }
            //        if ($('#codeone').val().length > 14) {
            //            $('#lblcode').text('Please Enter 13 Digit Code*');
            //            $('#codeone').focus();
            //            return false;
            //        }

            //        else {
            //            $('#lblcode').text('');
            //            $('#ChkCode').hide();
            //            $('#Chkfields').show();
            //            $('#otherfield').hide();
            //            $('#mobilefield').show();
            //        }
            //    }
            //    else {
            //        $('#lblcode').text('Please Enter 13 Digit Code*');
            //        $('#codeone').focus();
            //        return false;
            //    }
            //});

            $("#btnnxt").on('click', function (e) {
                e.preventDefault();
                var codeone = $('#codeone').val();
                if (codeone != undefined) {

                    if ($('#codeone').val().length < 14) {
                        $('#lblcode').text('Please enter 13-digit code*');
                        $('#codeone').focus();
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
                                      if ($('#CompName').val() == "Oltimo Lubes" || $('#CompName').val() == "" || $('#CompName').val() == undefined) {
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
                                          $('#lblcode').text('Invalid Code');
                                          return false;
                                      }

                                  }
                              }
                          });
                      }
                  });
             });

            $('#btnsubmit').on('click', function (e) {
                e.preventDefault();
                debugger;
               // $('#btnsubmit').attr('disabled', true);
                var pincode = $('#pin').val();
                var code = $('#codeone').val();

              
                if ($('#dealer').val().replace(/\s+/g, '').length == 0) {
                    $('#lbl').text('Please Enter Dealer Name!');
                    $('#dealer').focus();
                    $('#dealer').attr('disabled', false);
                    return false;
                }

                var matches11 = $('#dealer').val().match(/\d+/g);
                if (matches11 != null) {
                    $('#lbl').text('Dealer name should be lphabet only!');
                    $('#dealer').focus();
                    $('#btnsubmit').attr('disabled', false);
                    $('#dealer').val('');
                    return false;
                }
                else {
                    $('#lbl').text('');
                }
                var matches2 = $('#dealer').val();
                if (matches2.includes('~') || matches2.includes('!') || matches2.includes('@') || matches2.includes('#') || matches2.includes(')') || matches2.includes('_') || matches2.includes('-') || matches2.includes('>') || matches2.includes(',') || matches2.includes('?')
                    || matches2.includes('$') || matches2.includes('%') || matches2.includes('^') || matches2.includes('&') || matches2.includes('*') || matches2.includes('(') || matches2.includes('+') || matches2.includes('<') || matches2.includes('.')
                    || matches2.includes('=') || matches2.includes('{') || matches2.includes('}') || matches2.includes('[') || matches2.includes(']') || matches2.includes(':') || matches2.includes(';') || matches2.includes('"') || matches2.includes('/')
                ) {
                    $('#lbl').text('Special Character Not Allow*');
                    $('#dealer').focus();
                    $('#dealer').val('');
                    $('#btnsubmit').attr('disabled', false);
                    $('#dealer').val('');
                    return false;
                }
                else {
                    $('#lbl').text('');
                }


               

                var fd = new FormData();
                var files = $('#file')[0].files[0];

                if (files == undefined || files == "undefined") {
                    $('#lbl').text('Please Select Selfie With Product');
                    $('#file').focus();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    
                    $('#lbl').text('');
                }
                fd.append('file', files);


                if ($('#mobile').val() == "") {
                    $('#lbl').text('Please Enter Mobile Number!');
                    $('#mobile').focus();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#lbl').text('');
                }


               
                if ($('#Name').val().replace(/\s+/g, '').length == 0) {
                    $('#lbl').text('Please Enter Your Name!');
                    $('#Name').focus();
                    $('#Name').attr('disabled', false);
                    return false;
                }

                var matches = $('#Name').val().match(/\d+/g);
                if (matches != null) {
                    $('#lbl').text('Name should be lphabet only!');
                    $('#Name').focus();
                    $('#btnsubmit').attr('disabled', false);
                    $('#Name').val('');
                    return false;
                }
                else {
                    $('#lbl').text('');
                }

                var matchesname = $('#Name').val();
                if (matchesname.includes('~') || matchesname.includes('!') || matchesname.includes('@') || matchesname.includes('#') || matchesname.includes(')') || matchesname.includes('_') || matchesname.includes('-') || matchesname.includes('>') || matchesname.includes(',') || matchesname.includes('?')
                    || matchesname.includes('$') || matchesname.includes('%') || matchesname.includes('^') || matchesname.includes('&') || matchesname.includes('*') || matchesname.includes('(') || matchesname.includes('+') || matchesname.includes('<') || matchesname.includes('.')
                    || matchesname.includes('=') || matchesname.includes('{') || matchesname.includes('}') || matchesname.includes('[') || matchesname.includes(']') || matchesname.includes(':') || matchesname.includes(';') || matchesname.includes('"') || matchesname.includes('/')
                ) {
                    $('#lbl').text('Special Character Not Allow*');
                    $('#Name').focus();
                    $('#Name').val('');
                    $('#btnsubmit').attr('disabled', false);
                    $('#Name').val('');
                    return false;
                }
                else {
                    $('#lbl').text('');
                }



                if ($('#pin').val() == "") {
                    $('#lbl').text('Please Enter Pin Code!');
                    $('#pin').focus();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#lbl').text('');
                }

                if (pincode.length != 6) {
                    $('#lbl').text('Please Enter 6 Digit Pin Code!');
                    $('#pin').focus();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#lbl').text('');
                }

               
                if ($('#city').val().replace(/\s+/g, '').length == 0) {
                    $('#lbl').text('Please Enter City Name!');
                    $('#city').focus();
                    $('#city').attr('disabled', false);
                    return false;
                }

                var matches2 = $('#city').val().match(/\d+/g);
                if (matches2 != null) {
                    $('#lbl').text('City name should be lphabet only!');
                    $('#city').focus();
                    $('#btnsubmit').attr('disabled', false);
                    $('#city').val('');
                    return false;
                }
                else {
                    $('#lbl').text('');
                }
                var matchescity = $('#city').val();
                if (matchescity.includes('~') || matchescity.includes('!') || matchescity.includes('@') || matchescity.includes('#') || matchescity.includes(')') || matchescity.includes('_') || matchescity.includes('-') || matchescity.includes('>') || matchescity.includes(',') || matchescity.includes('?')
                    || matchescity.includes('$') || matchescity.includes('%') || matchescity.includes('^') || matchescity.includes('&') || matchescity.includes('*') || matchescity.includes('(') || matchescity.includes('+') || matchescity.includes('<') || matchescity.includes('.')
                    || matchescity.includes('=') || matchescity.includes('{') || matchescity.includes('}') || matchescity.includes('[') || matchescity.includes(']') || matchescity.includes(':') || matchescity.includes(';') || matchescity.includes('"') || matchescity.includes('/')
                ) {
                    $('#lbl').text('Special Character Not Allow*');
                    $('#city').focus();
                    $('#city').val('');
                    $('#btnsubmit').attr('disabled', false);
                    $('#city').val('');
                    return false;
                }
                else {
                    $('#lbl').text('');
                }


               
                if ($('#state').val().replace(/\s+/g, '').length == 0) {
                    $('#lbl').text('Please Enter State Name!');
                    $('#state').focus();
                    $('#state').attr('disabled', false);
                    return false;
                }

                var matches2 = $('#state').val().match(/\d+/g);
                if (matches2 != null) {
                    $('#lbl').text('State name should be lphabet only!');
                    $('#state').focus();
                    $('#btnsubmit').attr('disabled', false);
                    $('#state').val('');
                    return false;
                }
                else {
                    $('#lbl').text('');
                }
                var matchesstate = $('#state').val();
                if (matchesstate.includes('~') || matchesstate.includes('!') || matchesstate.includes('@') || matchesstate.includes('#') || matchesstate.includes(')') || matchesstate.includes('_') || matchesstate.includes('-') || matchesstate.includes('>') || matchesstate.includes(',') || matchesstate.includes('?')
                    || matchesstate.includes('$') || matchesstate.includes('%') || matchesstate.includes('^') || matchesstate.includes('&') || matchesstate.includes('*') || matchesstate.includes('(') || matchesstate.includes('+') || matchesstate.includes('<') || matchesstate.includes('.')
                    || matchesstate.includes('=') || matchesstate.includes('{') || matchesstate.includes('}') || matchesstate.includes('[') || matchesstate.includes(']') || matchesstate.includes(':') || matchesstate.includes(';') || matchesstate.includes('"') || matchesstate.includes('/')
                ) {
                    $('#lbl').text('Special Character Not Allow*');
                    $('#state').focus();
                    $('#state').val('');
                    $('#btnsubmit').attr('disabled', false);
                    $('#state').val('');
                    return false;
                }
                else {
                    $('#lbl').text('');
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
                    $('#lbl').text("Entered account number should be same in confirm account number field.");;

                    // $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if ($('#AccountNumber').val().length < 9) {
                    $('#lbl').text('Please Enter valid account number');
                    return false;
                }

                if ($('#ConfirmAccountNumber').val().length < 9) {
                    $('#lbl').text('Please Enter valid confirm account number');
                    return false;
                }

                var IfscCode = $('#IfscCode').val();

                if (IfscCode.length != 11) {
                    $('#lbl').text("Please enter 11 digit of Ifsc code .");
                    // $('#btnsubmit').attr('disabled', false);
                    return false;
                }

                if (IfscCode.length == 11) {

                    var reg = /[A-Z|a-z]{4}[0][0-9|A-Z|a-z]{6}$/;
                    if (!IfscCode.match(reg)) {

                        $('#lbl').text("Please enter valid IFSC code(First 4 alphabet then zero then other ).");
                        return false;
                    }
                    else {
                        ValidateIfccode(IfscCode);
                    }

                }







                //alert('dd33d');
                $('#p3msg').html('');
                if (code != "") {
                    
                   

                   
                    var path = '../Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#codeone').val() + '&name=' + $('#Name').val() + '&city=' + $('#city').val() + '&state=' + $('#state').val() + '&SellerName=' + $('#dealer').val() + '&PinCode=' + $('#pin').val() + '&AccountNumber=' + $('#AccountNumber').val() + '&IfscCode=' + $('#IfscCode').val() + '&AccountHolderName=' + $('#AccountHolderName').val() + '&comp=' + $('#CompName').val() + '&Comp_ID=Comp-1538';
                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,
                        data: fd,
                        
                        url: path,
                        success: function (data1) {
                            //alert(data1);
                            if (data1.split('~')[0] !== "failure") {
                                window.scrollTo(0, 0);
                                if (data1.indexOf("not valid") !== -1) {
                                    data1 = data1.split(".")[0];
                                }
                                $('#HEADING').hide();
                                $('#ChkCode').hide();
                                $('#Chkfields').hide();
                                $('#ShowMessage').show();
                                $('#p3msg').html(data1.split('~')[1]);
                                $('#p3msg:contains("not")').css('color', 'white');
                            }
                            else if (data1.split('~')[0] == "failure") {
                                alert(data1.split('~')[1]);
                            }

                            else {
                                alert('Invalid Request!');
                            }
                        }
                    });
                }
                else {
                    $('#btnsubmit').attr('disabled', false);
                }

            });
            $('#btnNext').click(function () {
                window.location.href = 'https://oltimo.co.in/';
            });
        });


        function ValidateIfccode(ifscCode) {
            //alert(ifscCode);
            var ann = '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=CheckIfcCode&IfcCode=' + ifscCode;
            //alert(ann);
            $.ajax({
                type: "Post",
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=CheckIfcCode&IfcCode=' + ifscCode,
                success: function (data) {
                    // alert(data);
                    if (data == "0") {
                        // alert("Invalid ifc code");
                        $('#lbl').text("Invalid IFSC Code!");
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

    <section class="background">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="logo-img mt-3">
                        <img src="../assets/images/Oltimo/logo.png" class="animate__backInDown animate__animated img-fluid">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-4">
                    <div id="fields">
                        <form class="animate__backInLeft animate__animated mt-4 " runat="server">
                            <asp:HiddenField ID="hdnmob" runat="server" />
                        <asp:HiddenField ID="HdnID" runat="server" />
                        <asp:HiddenField ID="HdnCode1" runat="server" />
                        <asp:HiddenField ID="HdnCode2" runat="server" />
                        <asp:HiddenField ID="CompName" runat="server" />
                        <asp:HiddenField ID="long" runat="server" />
                        <asp:HiddenField ID="lat" runat="server" />


                            <div class="row">
                                <div class="HEADING">
                                    <h6><b>TO CHECK AUTHENTICITY AND<br> AVAIL BENEFITS</b></h6>
                                </div>
                            </div>
                            <div class="form-maine">
                                <div id="ChkCode">
                                    <div class="mb-3">
                                        <input type="text" class="form-control" id="codeone" maxlength="13" minlength="13" placeholder="Enter 13 Digit Code/कोड दर्ज करें*" aria-describedby="13-digit-number">
                                    </div>
                                    <label class="clbl" id="lblcode"></label>
                                    <div>
                                        <center>
                                            <button type="button" id="btnnxt" class="btn btn-primary">Next/अगला</button>
                                        </center>
                                    </div>
                                </div>
                                <div id="Chkfields">
                                    <div id="mobilefield" style="display: none">
                                        <div class="mb-3">
                                            <input type="text" class="form-control" id="dealer" placeholder="Dealer Name/डीलर का नाम*">
                                        </div>
                                        <div class="mb-3">
                                            <label class="uploadFile">
                                                <i class="fa fa-camera" style="font-size:24px; float: right;"></i>
                                                <span class="filename">Upload Selfie/सेल्फी अपलोड करें*</span>
                                                <input type="file" id="file" onchange="return fileValidation()" class="inputfile form-control" name="file">
                                            </label>

                                        </div>
                                        <div class="mb-3">
                                            <input type="text" class="form-control" id="mobile" onkeyup="Getdata()" maxlength="10" placeholder="Mobile Number/मोबाइल नंबर*">
                                        </div>
                                    </div>
                                    <div id="otherfield">
                                        <div class="mb-3">
                                            <input type="text" class="form-control" id="Name" placeholder="Name /नाम*">
                                        </div>

                                        <div class="mb-3">
                                            <input type="text" class="form-control" onkeyup="getaddress()" id="pin" placeholder="Pincode/पिन कोड*">
                                        </div>
                                        <div class="mb-3">
                                            <input type="text" class="form-control" id="city" placeholder="Location/जगह*">
                                        </div>

                                        <div class="mb-3">
                                            <input type="text" class="form-control" id="state" placeholder="Address/पता*">
                                        </div>
                                    </div>

                                     <div id="DivBankDetails" runat="server">
                                        <div class="mb-3">

                                            <input type="text" class="form-control" id="AccountHolderName" placeholder="Bank Account Holder Name *" maxlength="30" autocomplete="off" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode==32">
                                        </div>
                                        <div class="mb-3">

                                            <input type="text" placeholder="Bank Account Number*" id="AccountNumber" minlength="9" maxlength="18" data-msg-required="Please Enter Bank Account Number*" class="form-control" pattern="[0-9]+" title="only numbers" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
                                        </div>

                                        <div class="mb-3">

                                            <input type="text" placeholder="Confirm Bank Account Number*" minlength="9" maxlength="18" class="form-control" id="ConfirmAccountNumber" pattern="[0-9]+" title="only numbers" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                                        </div>
                                        <div class="mb-3">

                                            <input type="text" placeholder="IFSC Code*" onkeypress="return ValidateAlphaNumeric1(event);" id="IfscCode" maxlength="11" data-msg-required="Please Enter Your IFSC Code*." class="form-control" style="text-transform:uppercase" pattern="[A-Za-z0-9]+" title="letters or numbers only" autocomplete="off" />
                                        </div>
                                        <!--<div class="col-12">

                                            <input type="checkbox" id="chkbox" data-msg-required="Please select checkbox*" /><span style="color:#fff;"> Please Accept <a style="color:#fff; text-decoration:none;" href="TermsNCondtions.aspx"><b>Terms and Conditions</b></a></span>
                                        </div>-->
                                    </div>

                                    <label class="clbl" id="lbl"></label>
                                    <button type="submit" id="btnsubmit" class="btn btn-primary">Submit/जमा करें</button>
                                </div>
                                <div style="display: none;" id="ShowMessage">
                                    <div class="form-box">
                                        <p id="p3msg" style="overflow: hidden; color:white; font-size: 13px !important; font-weight: 500;" class="displayNone massage_box"></p>
                                        <br /><center><a href="javascript:void(0)" class="btn btn-primary" id="btnNext">Close</a></center>
                                    </div>
                                </div>
                                <h6 class="text-centre text-white pt-2 qr-heading" style="font-size: 14px;">QR/Code Related Support Available On</h6>
                                <p class="text-white text-center number-style">
                                    <img src="../assets/images/Oltimo/telephone.png" style="width: 20px;">  <a href="tel:7353000903">7353000903</a> /
                                    <img src="../assets/images/Oltimo/whatsapp.png" style="width: 20px;">  <a href="https://api.whatsapp.com/send?phone=+919355903119&amp;text&amp;type=phone_number&amp;app_absent=1" target="blank">9355903119</a>
                                </p>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="col-lg-8">
                    <div class="product-img ">

                        <img src="..\assets\images\Oltimo\Product2.png" class="img-fluid animate__fadeInDown animate__animated ">
                    </div>
                </div>


            </div>

        </div>

        <footer>
            <h6 class="text-center text-white"><a href="https://oltimo.co.in/" class="text-white" style="text-decoration: none;">www.Oltimolubes.com</a></h6>
        </footer>
    </section>
    <script type="text/javascript">
        $("input[type=file]").change(function (e) {
            $(this).parents(".uploadFile").find(".filename").text(e.target.files[0].name);
        });
    </script>
</body>
</html>
