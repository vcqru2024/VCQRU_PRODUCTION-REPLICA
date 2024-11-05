<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Bluegem.aspx.cs" Inherits="Bluegem" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <title>Bluegem</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <link rel="stylesheet" type="text/css" href="assets/css/style_blugem.css">

    <script src="../Content/js/jquery-1.11.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>
</head>
<body>

    <style type="text/css">
        .clbl {
            color: white;
        }

        .banner {
            background-size: cover;
            background-repeat: no-repeat;
            width: 100%;
            display: table;
            background-position-y: center;
            height: 100vh;
            background-image: url(assets/images/Bluegem/background.png);
        }
    </style>



    <script type="text/javascript">
        var lat = "";
        var long = "";
        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }

        function Getdata2() {
           



            var Retailer = $('#Retailer').val();

            if ($('#Retailer').val().replace(/\s+/g, '').length == 0) {
                $('#lblmob').text('Please Enter Retailer Name !');
                $('#Retailer').focus();
                $('#btnsubmit').attr('disabled', false);
                return false;
            }
            if (Retailer != undefined) {

                if ($('#Retailer').val().length < 1) {
                    $('#lblmob').text('Please Enter Valid Retailer Name');
                    return false;
                }
                var matches = $('#Retailer').val().match(/\d+/g);
                if (matches != null) {
                    $('#lblmob').text('Retailer Name Should be alphabet only!');
                    return false;
                }
                var matchesstate = $('#Retailer').val();
                if (matchesstate.includes('~') || matchesstate.includes('!') || matchesstate.includes('@') || matchesstate.includes('#') || matchesstate.includes(')') || matchesstate.includes('_') || matchesstate.includes('-') || matchesstate.includes('>') || matchesstate.includes(',') || matchesstate.includes('?')
                    || matchesstate.includes('$') || matchesstate.includes('%') || matchesstate.includes('^') || matchesstate.includes('&') || matchesstate.includes('*') || matchesstate.includes('(') || matchesstate.includes('+') || matchesstate.includes('<') || matchesstate.includes('.')
                    || matchesstate.includes('=') || matchesstate.includes('{') || matchesstate.includes('}') || matchesstate.includes('[') || matchesstate.includes(']') || matchesstate.includes(':') || matchesstate.includes(';') || matchesstate.includes('"') || matchesstate.includes('/')
                ) {
                    $('#lblmob').text('Special characters are not allowed.*');
                    $('#Retailer').focus();
                    $('#btnsubmit').attr('disabled', false);
                    $('#Retailer').val('');
                    return false;
                }
            }

            debugger;
            $("#Mobile").mask("9999999999");
            var mobileno = document.querySelector("#Mobile").value;
            var d = mobileno.slice(0, 1);
            var c = parseInt(d);
            if ($('#Mobile').val().replace(/\s+/g, '').length == 0) {
                $('#lblmob').text('Please Enter Mobile Number !');
                $('#Mobile').focus();
                $('#btnsubmit').attr('disabled', false);
                return false;
            }
            if (mobileno.match(/[^$,.\d]/)) {
                $('#lblmob').text("Mobile Number Shoud Not be Alphabet!");
                $('#Mobile').val('');
                return false;
            }

            if (mobileno.includes('$')) {
                $('#lblmob').text("Special characters are not allowed.*");
                $('#Mobile').val('');
                return false;
            }

            if (mobileno.length == 10 && Retailer != "") {
                $.ajax({
                    type: "Post",
                    url: '../Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNo&MobileNo= ' + $("#Mobile").val(),
                    success: function (data) {
                        if (c <= 5) {
                            $('#lblmob').text('Please Enter 10 Digit Mobile No');
                            $('#Mobile').val('');
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
                            var UpiId = data.split('~')[10];

                            if (Name != "") {
                                $("#Name").val(Name);
                                document.getElementById('Name').readOnly = true;

                            }
                            else {

                                $('#ChkCode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();

                            }
                            if (pin != "") {
                                $("#Pin").val(pin);
                                document.getElementById('Pin').readOnly = true;

                            }
                            else {
                                $('#ChkCode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();

                            }

                            if (city != "") {
                                $("#City").val(city);
                            }
                            else {
                                $('#ChkCode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();
                            }

                            if (state != "") {
                                $("#State").val(state);
                            }
                            else {
                                $('#ChkCode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();
                            }
                            if (Address != "") {
                                $("#Address").val(Address);
                            }
                            else {
                                $('#ChkCode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();
                            }

                            //if (ddlconsumertype != "") {
                            //    $("#Retailer").val(ddlconsumertype);
                            //}
                            //else {
                            //    $('#ChkCode').hide();
                            //    $('#mobilefield').hide();
                            //    $('#Chkfields').show();
                            //    $('#Otherfield').show();
                            //}

                        }
                    }
                });
            }
            else {
                $("#Name").val('');
                $("#Pin").val('');
                $("#City").val('');
                $("#State").val('');
                $("#Address").val('');

            }
        }


        function Getdata() {
            $('#lbl').text('');
            $("#Name").val('');
            $("#Pin").val('');
            $("#City").val('');
            $("#State").val('');
            $("#Address").val('');
            




            debugger;
            $("#Mobile").mask("9999999999");
            var mobileno = document.querySelector("#Mobile").value;
            var d = mobileno.slice(0, 1);
            var c = parseInt(d);
            if ($('#Mobile').val().replace(/\s+/g, '').length == 0) {
                $('#lblmob').text('Please Enter Mobile Number !');
                $('#Mobile').focus();
                $('#btnsubmit').attr('disabled', false);
                return false;
            }
            if (mobileno.match(/[^$,.\d]/)) {
                $('#lblmob').text("Mobile Number Shoud Not be Alphabet!");
                $('#Mobile').val('');
                return false;
            }

            if (mobileno.includes('$')) {
                $('#lblmob').text("Special characters are not allowed.*");
                $('#Mobile').val('');
                return false;
            }

            if (mobileno.length == 10) {

                var Retailer = $('#Retailer').val();

                if ($('#Retailer').val().replace(/\s+/g, '').length == 0) {
                    $('#lblmob').text('Please Enter Retailer Name !');
                    $('#Retailer').val('');
                    $('#Retailer').focus();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if (Retailer != undefined) {

                    if ($('#Retailer').val().length < 1) {
                        $('#lblmob').text('Please Enter Valid Retailer Name');
                        return false;
                    }
                    var matches = $('#Retailer').val().match(/\d+/g);
                    if (matches != null) {
                        $('#lblmob').text('Retailer Name Should be alphabet only!');
                        return false;
                    }
                    var matchesstate = $('#Retailer').val();
                    if (matchesstate.includes('~') || matchesstate.includes('!') || matchesstate.includes('@') || matchesstate.includes('#') || matchesstate.includes(')') || matchesstate.includes('_') || matchesstate.includes('-') || matchesstate.includes('>') || matchesstate.includes(',') || matchesstate.includes('?')
                        || matchesstate.includes('$') || matchesstate.includes('%') || matchesstate.includes('^') || matchesstate.includes('&') || matchesstate.includes('*') || matchesstate.includes('(') || matchesstate.includes('+') || matchesstate.includes('<') || matchesstate.includes('.')
                        || matchesstate.includes('=') || matchesstate.includes('{') || matchesstate.includes('}') || matchesstate.includes('[') || matchesstate.includes(']') || matchesstate.includes(':') || matchesstate.includes(';') || matchesstate.includes('"') || matchesstate.includes('/')
                    ) {
                        $('#lblmob').text('Special characters are not allowed.*');
                        $('#Retailer').focus();
                        $('#btnsubmit').attr('disabled', false);
                        $('#Retailer').val('');
                        return false;
                    }
                }



                $.ajax({
                    type: "Post",
                    url: '../Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNo&MobileNo= ' + $("#Mobile").val(),
                    success: function (data) {
                        if (c <= 5) {
                            $('#lblmob').text('Please Enter 10 Digit Mobile No');
                            $('#Mobile').val('');
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
                            var UpiId = data.split('~')[10];

                            if (Name != "") {
                                $("#Name").val(Name);
                                document.getElementById('Name').readOnly = true;

                            }
                            else {

                                $('#ChkCode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();

                            }
                            if (pin != "") {
                                $("#Pin").val(pin);
                                document.getElementById('Pin').readOnly = true;

                            }
                            else {
                                $('#ChkCode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();

                            }

                            if (city != "") {
                                $("#City").val(city);
                            }
                            else {
                                $('#ChkCode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();
                            }

                            if (state != "") {
                                $("#State").val(state);
                            }
                            else {
                                $('#ChkCode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();
                            }
                            if (Address != "") {
                                $("#Address").val(Address);
                            }
                            else {
                                $('#ChkCode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();
                            }

                            //if (ddlconsumertype != "") {
                            //    $("#Retailer").val(ddlconsumertype);
                            //}
                            //else {
                            //    $('#ChkCode').hide();
                            //    $('#mobilefield').hide();
                            //    $('#Chkfields').show();
                            //    $('#Otherfield').show();
                            //}

                        }
                    }
                });
            }
            else {
                $("#Name").val('');
                $("#Pin").val('');
                $("#City").val('');
                $("#State").val('');
                $("#Address").val('');
               
            }
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
                        var Pin = data[0].PostOffice[0]['PinCode'];
                        $('#lbl').text('');
                        $("#City").val(city);
                        $("#State").val(state);

                        if ($("#City").val() != "") {
                            document.getElementById('City').readOnly = true;
                        }
                        if ($("#State").val() != "") {
                            document.getElementById('State').readOnly = true;
                        }
                    }
                    else {
                        $('#lbl').text("Please Enter Valid Pin.");
                        $("#Pin").val('');
                        return false;
                    }
                }
            }
            else {
                $("#City").val('');
                $("#State").val('');
                $('#lbl').text("Please Enter Valid Pin Code.");

                return false;
            }
        }




        $(document).ready(function () {


            firstfunction();
            $('#ChkCode').show();
            $('#Chkfields').hide();
            $('#mobilefield').hide();
            $('#Otherfield').hide();

            var id = $('#HdnID').val();

            if (id == "1") {

                $('#ChkCode').show();
                $('#Chkfields').hide();
                $('#mobilefield').hide();
                $('#Otherfield').hide();
            }

            else if (id == "Bluegem") {
                $('#ChkCode').hide();
                $('#mobilefield').show();
                $('#Chkfields').show();
                $('#Otherfield').hide();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $("#codeone").val(code);
            }
            $("#codeone").mask("99999-99999999");

            $("#btnnxt").on('click', function () {
                debugger;

                var codeone = $('#codeone').val();

                if (codeone == "" || codeone == undefined) {
                    $('#lblcode').text('Please Enter 13 Digit Code');
                    return false;
                }
                else {
                    $('#lblcode').text('');
                }

                if (codeone != undefined) {
                    if ($('#codeone').val().length < 14) {
                        $('#lblcode').text('Please Enter 13 Digit Code');
                        return false;
                    }
                    else {
                        $('#lblcode').text('');
                    }
                }

                var rquestpage_Dcrypt = $("#codeone").val();
                $('#btnnxt').hide();
                $('#btnloadnxt').show();
                // $('#ChkCode').hide();
                $.ajax({
                    type: "POST",
                    url: '../Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                    success: function (data) {
                        $.ajax({
                            type: "POST",
                            url: '../Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1] + '&lat=' + lat + '&long=' + long,
                            success: function (data) {
                                $('#btnnxt').show();
                                $('#btnloadnxt').hide();
                                if (data.split('&')[0] === "1" && data.split('&')[1] === "Auto Max India") {
                                }
                                else {
                                    $('#CompName').val(data.split('&')[1]);
                                    if ($('#CompName').val() == "BLUEGEM PAINTS" || $('#CompName').val() == "" || $('#CompName').val() == undefined) {
                                        $('#ChkCode').hide();
                                        $('#Chkfields').show();
                                        $('#Otherfield').hide();
                                        $('#mobilefield').show();

                                    }
                                    else {
                                        alert('Invalid Code');
                                        $('#ChkCode').show();
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
                //}
            });




            $('#btnsubmit').on('click', function (e) {
                e.preventDefault();
                Getdata2();
                $('#lblmob').text('');

                if ($('#Retailer').val().replace(/\s+/g, '').length == 0) {
                    $('#lblmob').text('Please Enter Retailer Name !');
                    $('#Retailer').val('');
                    $('#Retailer').focus();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }

                if (Retailer != undefined) {

                    if ($('#Retailer').val().length < 1) {
                        $('#lbl').text('Please Enter Valid Retailer Name');
                        return false;
                    }
                    var matches = $('#Retailer').val().match(/\d+/g);
                    if (matches != null) {
                        $('#lbl').text('Retailer Name Should be alphabet only!');
                        return false;
                    }
                    var matchesstate = $('#Retailer').val();
                    if (matchesstate.includes('~') || matchesstate.includes('!') || matchesstate.includes('@') || matchesstate.includes('#') || matchesstate.includes(')') || matchesstate.includes('_') || matchesstate.includes('-') || matchesstate.includes('>') || matchesstate.includes(',') || matchesstate.includes('?')
                        || matchesstate.includes('$') || matchesstate.includes('%') || matchesstate.includes('^') || matchesstate.includes('&') || matchesstate.includes('*') || matchesstate.includes('(') || matchesstate.includes('+') || matchesstate.includes('<') || matchesstate.includes('.')
                        || matchesstate.includes('=') || matchesstate.includes('{') || matchesstate.includes('}') || matchesstate.includes('[') || matchesstate.includes(']') || matchesstate.includes(':') || matchesstate.includes(';') || matchesstate.includes('"') || matchesstate.includes('/')
                    ) {
                        $('#lbl').text('Special characters are not allowed.*');
                        $('#Retailer').focus();
                        $('#btnsubmit').attr('disabled', false);
                        $('#Retailer').val('');
                        return false;
                    }
                }
               
                var Mobile = $('#Mobile').val()
                var pincode = $('#Pin').val()
                var d = Mobile.slice(0, 1);
                var c = parseInt(d);
                if (Mobile.match(/[^$,.\d]/)) {
                    $('#lbl').text(" Mobile number should not contain any special characters.");
                    $('#Mobile').val('');
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if (Mobile.length == 10 && c <= 5) {
                    $('#lbl').text("Please enter a valid mobile number.");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if (Mobile.length != 10) {
                    $('#lbl').text("Please enter your mobile number.");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }

                if ($('#Name').val().replace(/\s+/g, '').length == 0) {
                    $('#lbl').text('Please Enter Your Name!');
                    $('#Name').focus();
                    $('#Name').val('');
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }

                var name = $('#Name').val();
                if (name != undefined) {

                    if ($('#Name').val().length < 1) {
                        $('#lbl').text('Please Enter Valid Name');
                        return false;
                    }
                    var matches = $('#Name').val().match(/\d+/g);
                    if (matches != null) {
                        $('#lbl').text('Name should be alphabet only!');
                        return false;
                    }
                    var matches1 = $('#Name').val();
                    if (matches1.includes('~') || matches1.includes('!') || matches1.includes('@') || matches1.includes('#') || matches1.includes(')') || matches1.includes('_') || matches1.includes('-') || matches1.includes('>') || matches1.includes(',') || matches1.includes('?')
                        || matches1.includes('$') || matches1.includes('%') || matches1.includes('^') || matches1.includes('&') || matches1.includes('*') || matches1.includes('(') || matches1.includes('+') || matches1.includes('<') || matches1.includes('.')
                        || matches1.includes('=') || matches1.includes('{') || matches1.includes('}') || matches1.includes('[') || matches1.includes(']') || matches1.includes(':') || matches1.includes(';') || matches1.includes('"') || matches1.includes('/')
                    ) {
                        $('#lbl').text('Special characters are not allowed.*');
                        $('#Name').focus();
                        $('#btnsubmit').attr('disabled', false);
                        $('#Name').val('');
                        return false;
                    }
                }



                var pin = $('#Pin').val();
                if (pin != undefined) {

                    if ($('#Pin').val().length < 6) {
                        $('#lbl').text('Please Enter Valid Pin Code');
                        return false;
                    }
                    if (pin.match(/[^$,.\d]/)) {
                        $('#lbl').text("Please Enter Numeric Value For Pin Code.");
                        return false;
                    }

                    var matches1 = $('#Pin').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        $('#lbl').text('Pin Code Should Not Contain Any Special Character!');
                        return false;
                    }
                }

                if ($('#City').val().replace(/\s+/g, '').length == 0) {
                    $('#lbl').text('Please Enter Your City Name!');
                    $('#City').focus();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }

                var city = $('#City').val();
                if (city != undefined) {

                    if ($('#City').val().length < 1) {
                        $('#lbl').text('Please Enter valid City');
                        return false;
                    }
                    var matches = $('#City').val().match(/\d+/g);
                    if (matches != null) {
                        $('#lbl').text('City Name Should be alphabet only!');
                        return false;
                    }
                    var matchescity = $('#City').val();
                    if (matchescity.includes('~') || matchescity.includes('!') || matchescity.includes('@') || matchescity.includes('#') || matchescity.includes(')') || matchescity.includes('_') || matchescity.includes('-') || matchescity.includes('>') || matchescity.includes(',') || matchescity.includes('?')
                        || matchescity.includes('$') || matchescity.includes('%') || matchescity.includes('^') || matchescity.includes('&') || matchescity.includes('*') || matchescity.includes('(') || matchescity.includes('+') || matchescity.includes('<') || matchescity.includes('.')
                        || matchescity.includes('=') || matchescity.includes('{') || matchescity.includes('}') || matchescity.includes('[') || matchescity.includes(']') || matchescity.includes(':') || matchescity.includes(';') || matchescity.includes('"') || matchescity.includes('/')
                    ) {
                        $('#lbl').text('Special characters are not allowed.*');
                        $('#City').focus();
                        $('#btnsubmit').attr('disabled', false);
                        $('#City').val('');
                        return false;
                    }
                }


                if ($('#State').val().replace(/\s+/g, '').length == 0) {
                    $('#lbl').text('Please Enter Your State Name!');
                    $('#State').focus();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }

                var State = $('#State').val();
                if (State != undefined) {

                    if ($('#State').val().length < 1) {
                        $('#lbl').text('Please Enter Valid State Name');
                        return false;
                    }
                    var matches = $('#State').val().match(/\d+/g);
                    if (matches != null) {
                        $('#lbl').text('State Name Should be alphabet only!');
                        return false;
                    }
                    var matchesstate = $('#City').val();
                    if (matchesstate.includes('~') || matchesstate.includes('!') || matchesstate.includes('@') || matchesstate.includes('#') || matchesstate.includes(')') || matchesstate.includes('_') || matchesstate.includes('-') || matchesstate.includes('>') || matchesstate.includes(',') || matchesstate.includes('?')
                        || matchesstate.includes('$') || matchesstate.includes('%') || matchesstate.includes('^') || matchesstate.includes('&') || matchesstate.includes('*') || matchesstate.includes('(') || matchesstate.includes('+') || matchesstate.includes('<') || matchesstate.includes('.')
                        || matchesstate.includes('=') || matchesstate.includes('{') || matchesstate.includes('}') || matchesstate.includes('[') || matchesstate.includes(']') || matchesstate.includes(':') || matchesstate.includes(';') || matchesstate.includes('"') || matchesstate.includes('/')
                    ) {
                        $('#lbl').text('Special characters are not allowed.*');
                        $('#City').focus();
                        $('#btnsubmit').attr('disabled', false);
                        $('#City').val('');
                        return false;
                    }
                }



                var Address = $('#Address').val();
                if (Address != undefined) {

                    if ($('#Address').val().length < 1) {
                        $('#lbl').text('Please Enter Valid Address');
                        return false;
                    }

                }
                if ($('#Address').val().replace(/\s+/g, '').length == 0) {
                    $('#lbl').text('Please Enter Your Address !');
                    $('#Address').focus();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }

                


                $('#btnsubmit').hide();
                $('#btnloadsubmit').show();

                if (code != "") {
                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: '../Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#Mobile').val() + "&vCode=" + $('#codeone').val() + '&name=' + $('#Name').val() + '&city=' + $('#City').val() + '&state=' + $('#State').val() + '&PinCode=' + $('#Pin').val() + '&SellerName=' + $("#Retailer").val() + '&Address=' + $("#Address").val() + '&comp=BLUEGEM PAINTS&Comp_ID=Comp-1559',
                        success: function (data) {
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
                                // $('#chkLine').hide();
                                $('#p3msg').html(data.split('~')[1]);
                                $('#p3msg:contains("not")').css('color', 'white');
                            }
                            else {
                                $('#msgcoats').hide();
                                toastr.error('OTP is not valid. Please provide the valid OTP');
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
                window.location.href = 'https://www.bluegem.in/';
            });
        });




        async function firstfunction() {

            if (navigator.geolocation) {
                await getPosition()
                    .then((position) => {
                        $('#lat').val(position.coords.latitude);
                        $('#long').val(position.coords.longitude);
                        var latitude = position.coords.latitude;
                        var longitude = position.coords.longitude;
                        lat = latitude;
                        long = longitude;

                        $.ajax({
                            type: "POST",
                            async: true,
                            url: '../Info/MasterHandler.ashx?method=chklocation&lat=' + latitude + '&long=' + longitude,
                            success: function (data) {
                                lat = latitude;
                                long = longitude;
                            }
                        });
                    })
                    .catch((err) => {
                        console.error(err.message);
                    });
            } else {
                // x.innerHTML = "Geolocation is not supported by this browser.";
            }
        }
    </script>

    <header>
        <section class="top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 offset-lg-8 view-social-tab">
                        <ul>
                            <li style="margin-right: 20px;">Follow us on</li>

                            <li><a href="https://www.facebook.com/BlueGemIndia?mibextid=ZbWKwL">
                                <img src="assets/images/Bluegem/facebook.png"></a></li>
                            <li><a href="https://instagram.com/bluegemindia?utm_source=qr&igshid=MzNlNGNkZWQ4Mg%3D%3D">
                                <img src="assets/images/Bluegem/instagram.png"></a></li>
                            <li><a href="https://www.linkedin.com/company/bluegem-constrowell-llp/">
                                <img src="assets/images/Bluegem/linkedin.png"></a></li>
                            <li><a href="https://youtube.com/@bluegemtiles9359">
                                <img src="assets/images/Bluegem/youtube.png"></a></li>
                        </ul>
                    </div>
                </div>

            </div>

        </section>
        <section class="bottom-heder">
            <div class="container">
                <div class="row">
                    <div class="logo">
                        <img src="assets/images/Bluegem/logo.png">
                    </div>
                </div>
            </div>


        </section>

    </header>

    <section class="banner">

        <div class="container">
            <div class="row view">
                <div class="col-lg-8 ">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="content mt-sm-5 animate__animated animate__zoomIn">
                                <h1 class="main-head">Bringing Colors to Life:</h1>
                                <h4 class="text-white pt-2 main-head-sub">Your Trusted Partner in Paint and Construction Chemical Solutions</h4>
                                <hr>
                                <p class="text-white pt-2">We BLUEGEM, we specialize in creating vibrant, durable, and environmentally-friendly paint solutions for all your needs. Whether you're a homeowner, contractor, or designer, we have the perfect palette of colors and finishes to bring your vision to life.</p>
                            </div>

                        </div>

                        <div class="col-lg-12">
                            <div class="product-img mt-sm-5 animate__animated animate__zoomInUp">
                                <img src="assets/images/Bluegem/product.png" class="img-fluid">
                            </div>

                        </div>

                    </div>

                </div>

                <div class="col-lg-4">
                    <form class="animate__backInLeft animate__animated mt-4" runat="server">
                        <asp:HiddenField ID="hdnmob" runat="server" />
                        <asp:HiddenField ID="HdnID" runat="server" />
                        <asp:HiddenField ID="HdnCode1" runat="server" />
                        <asp:HiddenField ID="HdnCode2" runat="server" />
                        <asp:HiddenField ID="CompName" runat="server" />
                        <asp:HiddenField ID="long" runat="server" />
                        <asp:HiddenField ID="lat" runat="server" />

                        <div id="Heading" class="HEADING text-white">
                            <h5><b>TO CHECK AUTHENTICITY AND<br>
                                AVAIL BENEFITS</b></h5>
                        </div>

                        <div class="form-maine">
                            <div id="ChkCode">
                                <div class="mb-3">
                                    <input type="text" class="form-control" id="codeone" onkeypress="return onlyNumberKey(event)" placeholder="Enter 13 Digit Code/13 अंको का कोड दर्ज करें*" aria-describedby="13-digit-number" required>
                                </div>
                                <div>
                                    <center>
                                        <button type="button" id="btnnxt" class="btn-2">Next/अगला</button>
                                        <button type="button" style="display: none" id="btnloadnxt" class="btn-2"><i class="fa fa-spinner fa-spin"></i> Loading..</button>
                                    </center>
                                </div>
                                <label id="lblcode" class="clbl"></label>
                            </div>
                            <div id="Chkfields">
                                <div id="mobilefield" style="display: none">

                                     <div class="mb-3">
                                        <input type="text" class="form-control" id="Retailer" placeholder="Retailer/Dealer name/विक्रेता का नाम *" required>
                                    </div>
                                    <div class="mb-3">
                                        <input type="text" class="form-control number" maxlength="10" onkeyup="Getdata()" id="Mobile" onkeypress="return onlyNumberKey(event)" placeholder="Mobile Number/मोबाइल नंबर*" required>
                                    </div>
                                    <label id="lblmob" class="clbl"></label>
                                </div>
                                <div id="Otherfield" style="display:none">

                                    <div class="mb-3">
                                        <input type="text" class="form-control" id="Name" placeholder="Name/नाम *" required>
                                    </div>

                                    <div class="mb-3">
                                        <input type="text" class="form-control" onkeyup="getaddress()" maxlength="6" onkeypress="return onlyNumberKey(event)" id="Pin" placeholder="Pincode/पिन कोड*" required>
                                    </div>

                                    <div class="mb-3">
                                        <input type="text" class="form-control" id="City" placeholder="City/शहर*" required>
                                    </div>

                                    <div class="mb-3">
                                        <input type="text" class="form-control" id="State" placeholder="State/राज्य*" required>
                                    </div>

                                    <div class="mb-3">
                                        <input type="text" class="form-control" id="Address" placeholder="Address/पता*" required>
                                    </div>

                                   
                                </div>

                                <button type="submit" id="btnsubmit" class="btn-2">Submit/जमा करे</button>
                                <button type="button" style="display: none" id="btnloadsubmit" class="btn-2"><i class="fa fa-spinner fa-spin"></i> Loading..</button>
                                <label id="lbl" class="clbl"></label>
                            </div>
                        </div>
                        <div style="display: none;" id="ShowMessage">

                            <div class="form-box">
                                <p id="p3msg" style="overflow: hidden; color: white; font-size: 13px !important; font-weight: 500; margin-left: 7px;margin-right: 7px;" class="displayNone massage_box text-center"></p>
                                <br />
                                <center><a href="javascript:void(0)" class="btn-2" id="btnNext">Close</a></center>
                            </div>
                        </div>
                    </form>
                    <div class="footer-linke">
                        <p id="wlink" class="blink_me animate__bounceIn">
                            QR/Code Related Support Available on
                            <br>
                            <img src="assets/images/Bluegem/call.png" style="width: 20px;">
                            <a href="tel:8047278314">8047278314</a> /
                            <img src="assets/images/Bluegem/whatsapp.png" style="width: 20px;">
                            <a href="https://api.whatsapp.com/send?phone=+919355903119&amp;text&amp;type=phone_number&amp;app_absent=1" target="blank">9355903119</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <footer>
        <a href="https://www.bluegem.in/">www.bluegem.in</a>
    </footer>

</body>
</html>
