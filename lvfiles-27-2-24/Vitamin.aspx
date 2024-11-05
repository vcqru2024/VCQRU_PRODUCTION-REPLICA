<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Vitamin.aspx.cs" Inherits="Thevitaminco" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Thevitamin.co</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>



    <style type="text/css">
        .background {
            position: relative;
            background-size: 100% 100%;
            background-repeat: no-repeat;
            width: 100%;
            display: table;
            height: 100vh;
            background-image: url(../assets/images/thevitamin/color-background.png);
        }

        .top-img {
            position: absolute;
            background-size: 100% 100%;
            background-repeat: no-repeat;
            width: 9%;
            display: table;
            height: 21vh;
            background-image: url(../assets/images/thevitamin/VITAMIN-SHAPE-1.png);
        }


        .bottom-img {
            position: absolute;
            background-size: cover;
            background-repeat: no-repeat;
            width: 100%;
            display: table;
            height: 21vh;
            bottom: 0;
            background-image: url(../assets/images/thevitamin/VITAMIN-SHAPE-2.png);
        }

        footer a {
            color: black;
            text-decoration: none;
        }

        .logo-img {
            text-align: center;
            margin: 20px;
        }

        form {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 2px #2f2e2e;
            margin-bottom: 30px;
        }


        .btn {
            width: 100%;
            background-color: #fd8802;
            outline: none;
            border: none;
        }

        .logo-img img {
            width: 11%;
        }

        .form-maine input::placeholder {
            color: #0a0a0a !important;
        }

        form input {
            background: #dce0ec !important;
            border-radius: 3px !important;
        }



        .HEADING {
            border-radius: 0px 0px 100px 100px;
            background: #fd8802;
            padding: 10px;
            text-align: center;
            color: #fff;
        }

        .form-select {
            background-color: #dce0ec;
        }

        select {
            border: none;
            background: transparent;
            /*background-color: blue;*/
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            width: 180px;
            padding-top: 0px;
            background-size: 20px;
            color: #ffffff;
            font-size: 30px;
        }

            select option {
                color: #424146;
                background: #ffffff;
            }

        .form-maine {
            padding: 25px;
        }

        footer {
            text-align: center;
            font-weight: 600;
            position: absolute;
            bottom: 0px;
            width: 100%;
        }


        .footer-linke a {
            color: #fff;
        }

        .blink_me {
            /*position: absolute;*/
            bottom: 51px;
            font-weight: 600;
            margin-top: 30px;
            color: #fff;
            text-align: center;
            left: 11%;
        }

        .product-img img {
            position: absolute;
            width: 46%;
            bottom: 0;
            right: 197px;
        }

        @media screen and (max-width: 767px) {
            .logo-img img {
                width: 34%;
            }

            .product-img img {
                position: unset;
                width: 98%;
                bottom: 0;
                right: 197px;
            }

            .product-img {
                padding: 0px 0px 82px;
            }

            .blink_me {
                bottom: 0;
                color: black;
                margin-bottom: 30px;
            }

            .footer-linke a {
                color: #040404;
            }
        }

        @media screen and (min-width: 768px) and (max-width: 1024px) {
            .product-img {
                padding: 0px 0px 69px;
                text-align: center;
            }

            .blink_me {
                bottom: 0;
                left: 34%;
                margin-bottom: 34px;
                color: black;
            }

            .product-img img {
                position: unset;
                width: 100%;
                bottom: 0;
                /* right: 197px; */
            }

            .footer-linke a {
                color: #000;
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
            
            var mobileno = document.querySelector("#mobilenumber").value;
            var d = mobileno.slice(0, 1);
            var c = parseInt(d);

            if ($('#mobilenumber').val() == "") {
               
                $('#lblmobile').text('Please enter mobile number*');
                $('#lblmobile').css("color", "red");
                $('#mobilenumber').focus();
                $('#btnsubmit').attr('disabled', false);
                return false;
            }





            if (mobileno.match(/[^$,.\d]/)) {
                
                $('#lblmobile').text('Please enter numeric value for mobile No*');
                $('#lblmobile').css("color", "red");
                $('#mobilenumber').val() == "";
                $('#mobilenumber').focus();
                $('#btnsubmit').attr('disabled', false);
                return false;
            }

            else {
                if (mobileno.length == 10) {
                    $.ajax({
                        type: "Post",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNo&MobileNo= ' + $("#mobilenumber").val(),
                        success: function (data) {


                            if (c <= 5) {
                                $('#lblmobile').text('Please enter valid number*');
                                $('#lblmobile').css("color", "red");
                                $('#mobilenumber').focus();
                                $('#mobilenumber').val('');
                                return false;
                            }
                            else {


                                var Name = data.split('~')[0];
                                var pin = data.split('~')[6];
                                var city = data.split('~')[2];
                                var ddlshopfrom = data.split('~')[4];
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
                                }
                                if (ddlshopfrom != "") {
                                    $("#ddlpurchasefrm").val(ddlshopfrom);
                                    $("#ddlpurchasefrm").readOnly = true;
                                    document.getElementById('ddlpurchasefrm').readOnly = true;
                                }
                                else {
                                    $('#ChkCode').hide();
                                    $('#otherfield').show();
                                    $('#mobilefield').hide();
                                    $('#Chkfields').show();
                                }


                                //$('#ChkCode').hide();
                                //$('#otherfield').show();
                                //$('#mobilefield').hide();
                                //$('#Chkfields').show();

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
                        $('#lblddl').text('Please enter valid pin*');
                        $('#lblddl').css("color", "red");
                        $('#pin').focus();
                        $('#btnsubmit').attr('disabled', true);
                        return false;
                    }
                }
            }
        }




        function pinval() {

            var pin = $('#pin').val();
            if (pin != undefined) {

                if ($('#pin').val().length < 6) {
                    
                    $('#lblddl').text('Please Enter valid Pin Code*');
                    $('#lblddl').css("color", "red");
                    $('#pin').focus();
                    validate = false;
                }
                if (pin.match(/[^$,.\d]/)) {
                    
                    $('#lblddl').text('Please enter numeric value for Pin Code*');
                    $('#lblddl').css("color", "red");
                    $('#pin').focus();
                    validate = false;
                }

                var matches1 = $('#pin').val().match(/[^a-zA-Z0-9 ]/);
                if (matches1 != null) {
                   
                    $('#lblddl').text('Pin Code Should Not Contain any Special Character*');
                    $('#lblddl').css("color", "red");
                    $('#pin').focus();
                    validate = false;
                }
            }
        }


        function namevalid() {
            var name = $('#Name').val();
            if (name != undefined) {

                if ($('#Name').val().length < 1) {
                    
                    $('#lblddl').text('Please Enter valid Name*');
                    $('#lblddl').css("color", "red");
                    validate = false;
                    return false;
                }
                var matches = $('#Name').val().match(/\d+/g);
                if (matches != null) {
                    $('#lblddl').text('Name Should be alphabet only*');
                    $('#lblddl').css("color", "red");
                    //validate = false;
                    return false;
                }
                var matches1 = $('#Name').val().match(/[^a-zA-Z0-9 ]/);
                if (matches1 != null) {
                    $('#lblddl').text('Name Should Not Contain any Special Character*');
                    $('#lblddl').css("color", "red");
                    validate = false;
                    return false;
                }
            }
        }

        function cityvalid() {
            var city = $('#city').val();
            if (city != undefined) {

                if ($('#city').val().length < 1) {
                  
                    $('#lblddl').text('Please Enter City Name*');
                    $('#lblddl').css("color", "red");
                    validate = false;
                }
                var matches = $('#city').val().match(/\d+/g);
                if (matches != null) {
                    $('#lblddl').text('City Name Should be alphabet only*');
                    $('#lblddl').css("color", "red");
                    validate = false;
                }
                var matches1 = $('#city').val().match(/[^a-zA-Z0-9 ]/);
                if (matches1 != null) {
                    $('#lblddl').text('City Name Should Not Contain any Special Character*');
                    $('#lblddl').css("color", "red");
                    validate = false;
                }
            }
        }

        function valmobile() {
            var phoneNumber = $('#mobilenumber').val();

            if (phoneNumber != undefined) {
                if (phoneNumber.length < 10) {
                   
                    $('#lblmobile').text('Please Enter Valid Mobile Number*');
                    $('#lblmobile').css("color", "red");
                    return false;
                }
                if (phoneNumber.match(/[^$,.\d]/)) {
                  
                    $('#lblmobile').text('Please enter numeric value for mobile No*');
                    $('#lblmobile').css("color", "red");
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
                    $('#lblmobile').text('Please enter numeric value for mobile No*');
                    $('#lblmobile').css("color", "red");
                    validate = false;
                    return false;
                }
            }
        }
        $(document).ready(function () {

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

            else if (id == "Vitamin") {
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
                        $('#lblcode').text('Please Enter 13 Digit Code*');
                        $('#lblcode').css("color", "red");
                        $('#codeone').focus();
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
                $('#btnsubmit').attr('disabled', true);
                var mobilenumber = $('#mobilenumber').val()
                var pincode = $('#pin').val()
                var d = mobilenumber.slice(0, 1);
                var c = parseInt(d);
                if (mobilenumber.match(/[^$,.\d]/)) {
                    $('#lblmobile').text("Please enter numeric value for mobile No*");
                    $('#lblmobile').css("color", "red");
                    $('#mobilenumber').focus();
                    $('#mobilenumber').val('');
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if (mobilenumber.length == 10 && c <= 5) {
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                if (mobilenumber.length != 10) {
                    $('#lblmobile').text("Please enter 10 digit of mobile No*");
                    $('#lblmobile').css("color", "red");
                    $('#mobilenumber') .focus();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    var matches = $('#Name').val().match(/\d+/g);
                    if (matches != null) {
                        $('#lblddl').text('Name Should be alphabet only*');
                        $('#lblddl').css("color", "red");
                        $('#Name').focus();
                        $('#btnsubmit').attr('disabled', false);
                        $('#Name').val('');
                        return false;
                    }
                    var matches1 = $('#Name').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        $('#lblddl').text('Name Should Not Contain any Special Character*');
                        $('#lblddl').css("color", "red");
                        $('#Name').focus();
                        $('#btnsubmit').attr('disabled', false);
                        $('#Name').val('');
                        return false;
                    }

                    if ($('#Name').val() == "") {
                        namevalid();
                        $('#Name').focus();
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    if (pincode.length != 6) {
                        pinval();
                        $('#pin').focus();
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    if ($('#pin').val() == "") {
                        pinval();
                        $('#pin').focus();
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    if ($('#city').val() == "") {
                        cityvalid();
                        $('#city').focus();
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    var e = document.getElementById("ddlpurchasefrm");
                    var optionSelIndex = e.options[e.selectedIndex].value;
                    var optionSelectedText = e.options[e.selectedIndex].text;
                    if (optionSelIndex == 0) {
                        $('#lblddl').text("Please Select Source Of Purchaese*");
                        $('#lblddl').css("color", "red");
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                        
                    }
                    if (optionSelectedText == "0") {
                        $('#lblddl').text("Please Select Source Of Purchaese*");
                        $('#lblddl').css("color", "red");
                        validate = false;
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }

                }
                $('#p3msg').html('');
                if (code != "") {
                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&name=' + $('#Name').val() + '&city=' + $('#city').val() + '&SellerName=' + $('#ddlpurchasefrm').val()  + '&PinCode=' + $('#pin').val() + '&comp=' + $('#CompName').val() + '&Comp_ID=Comp-1281',
                         success: function (data) {

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
                                 $('#p3msg:contains("not")').css('color', 'Black');
                             }
                             else {

                                 $('#msgcoats').hide();
                                 alert('OTP is not valid. Please provide the valid OTP');
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
                window.location.href = 'https://thevitamin.co/';
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
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=chklocation&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                success: function (data) {


                }
            });
        }
    </script>

</head>


<body>
    <section class="background">
        <div class="top-img">
        </div>
        <div class="bottom-img">
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="logo-img">
                        <img src="../assets/images/thevitamin/VITAMIN.png" class="animate__backInDown animate__animated">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <form class="animate__backInLeft animate__animated" runat="server">
                        <asp:HiddenField ID="hdnmob" runat="server" />
                        <asp:HiddenField ID="HdnID" runat="server" />
                        <asp:HiddenField ID="HdnCode1" runat="server" />
                        <asp:HiddenField ID="HdnCode2" runat="server" />
                        <asp:HiddenField ID="CompName" runat="server" />
                        <asp:HiddenField ID="long" runat="server" />
                        <asp:HiddenField ID="lat" runat="server" />

                        <div class="row">
                            <div id="fields">
                                <div class="HEADING">
                                    <h6>TO CHECK AUTHENTICITY AND AVAIL BENEFITS</h6>
                                </div>
                                <div class="width-box">
                                    <div class="form-maine">
                                        <div id="ChkCode">
                                            <div class="mb-3">
                                                <input type="text" class="form-control" onkeyup="validateForm()" id="codeone" maxlength="13" minlength="13" placeholder="Enter 13 Digit Code*" required aria-describedby="13-digit-number">
                                                <label id="lblcode"></label>
                                            </div>
                                            <div class="mb-3">
                                                <button type="submit" id="btnnxt" class="btn btn-primary">Next</button>
                                            </div>
                                        </div>
                                        <div id="mobilefield" style="display: none">
                                            <div class="mb-3">
                                                <input type="text" class="form-control" onkeyup="Getdata()" id="mobilenumber" maxlength="10" minlength="10" required placeholder="Mobile Number*">
                                                <label id="lblmobile"></label>
                                            </div>
                                        </div>
                                        <div id="Chkfields">
                                            <div id="otherfield">
                                                <div class="mb-3">
                                                    <input type="text" class="form-control" id="Name" required placeholder="Name*">
                                                    <%--<label id="lblname"></label>--%>
                                                </div>
                                                <div class="mb-3">
                                                    <input type="text" class="form-control" onkeyup="getaddress()" maxlength="6" minlength="6" required id="pin" placeholder="Pincode*">
                                                   <%-- <label id="lblpin"></label>--%>
                                                </div>
                                                <div class="mb-3">
                                                    <input type="text" class="form-control" id="city" required placeholder="City*">
                                                    <%--<label id="lblcity"></label>--%>
                                                </div>
                                                <div class="mb-3">
                                                    <select id="ddlpurchasefrm" class="form-select form-control">
                                                        <option value="0" selected="selected" disabled="disabled">Source of Purchase</option>
                                                        <option value="Amazon">Amazon</option>
                                                        <option value="Flipkart">Flipkart</option>
                                                        <option value="Others">Others</option>
                                                    </select>
                                                </div>
                                                <label id="lblddl"></label>
                                            </div>
                                            <button type="submit" id="btnsubmit" class="btn btn-primary">Submit</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div style="display: none;" id="ShowMessage" class="row no-gutters pl-4 pr-4 textmessage">
                                <center>
                                    <div class="col-md-12">
                                        <br />
                                        <div class="form-group" style="margin-left: 7%;">
                                            <p id="p3msg" style="overflow: hidden; font-size: 14px !important;" class="displayNone massage_box"></p>
                                        </div>
                                       
                                        <a href="javascript:void(0)" class="next_btn" id="btnNext"><b>Close</b></a>
                                         <br />
                                        <br />
                                    </div>
                                </center>
                            </div>
                        </div>
                    </form>
                    <div class="footer-linke">
                        <p id="wlink" class="blink_me animate__bounceIn">
                            QR/Code  Related Support Available on
                            <br>
                            <img src="../assets/images/thevitamin/call.png" style="width: 20px;">
                            <a href="tel:7353000903">7353000903</a> / 
                        <img src="../assets/images/thevitamin/whatsapp.png" style="width: 20px;">
                            <a href="https://api.whatsapp.com/send?phone=+919355903119&amp;text&amp;type=phone_number&amp;app_absent=1" target="blank">9355903119</a>
                        </p>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="product-img ">
                        <img src="../assets/images/thevitamin/PRODUCT-1.png" class="img-fluid animate__zoomInRight animate__animated">
                    </div>
                </div>
            </div>
        </div>
        <footer><a href="https://thevitamin.co/">www.thevitamin.co</a></footer>
    </section>
</body>
</html>
