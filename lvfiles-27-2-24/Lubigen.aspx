<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Lubigen.aspx.cs" Inherits="lubeign" %>

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


    <title>Lubigen</title>
    <style>
        * {
            margin: 0px;
            padding: 0px;
            font-family: 'Poppins', sans-serif;
        }

        .marmo-solution {
            background-image: url(./assets/images/lubigen/bg-img.jpg);
            background-repeat: no-repeat;
            background-position: top;
            background-size: cover;
            width: 100%;
            position: relative;
            display: table;
            height: 100vh;
        }

            .marmo-solution .marmo-logo {
                width: 35%;
                padding: 5px 5px;
            }

        .form-box {
            background-color: #e4e7ec8a;
            display: table;
            /*margin: auto;*/
            border-radius: 25px;
            border: 5px solid #fff;
            padding-bottom: 30px;
            margin-bottom: 7%;
            width: 70%;
        }

            .form-box h5 {
                text-align: center;
                width: 99.5%;
                color: #fff;
                background-color: #2c4769;
                padding: 30px 0px;
                border-bottom-right-radius: 70%;
                border-bottom-left-radius: 70%;
                margin: auto;
                border-top-left-radius: 23px;
                border-top-right-radius: 23px;
                margin-bottom: 10px;
                line-height: 29px;
                font-size: 18px;
            }

        .marmo-solution .form-box button {
            background-color: #00265a;
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
                border: 3px solid #fff;
                background-color: #e4e7ec;
                margin-bottom: 7px;
                font-size: 13px;
                padding: 11px 20px;
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

        .marmo-solution .product-box {
            background-color: #fff;
            border-radius: 100%;
            padding: 45px 30px;
            display: table;
            margin: auto;
            text-align: center;
            box-shadow: 2px 1px 17px #807f7f;
        }

        .marmo-solution .marmo-product {
            width: 90%;
            margin-top: 45%;
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
            width: 90%;
            margin: auto;
            margin-top: -95px;
        }

        .box p {
            text-align: center;
        }

        .weblink a:hover {
            color: #00265a;
        }

        .slide-right {
            animation: 2s slide-right;
        }
        /* #ShowMessage{
            width:80%;
            margin:auto;
        }*/

        @keyframes slide-right {
            from {
                margin-left: 100%;
            }

            to {
                margin-left: 0%;
            }
        }


        @media screen and (width:280px) {
            .icon-box .box img {
                width: 45%;
            }

            .icon-box .box {
                padding: 9px 25px 0px 0px;
            }

            .position-box {
                width: 100%;
                margin-top: -60px;
            }

            .slide-right {
                margin-top: -35px;
            }
        }

        @media screen and (max-width:767px) {
            .marmo-solution .marmo-logo {
                width: 100%;
            }
            /*.position-box {
                position: initial;
                width: 100%;
                margin-top: -75px;
                left: 0%;
            }*/
            .icon-box .box {
                margin-bottom: 10px;
            }

            .marmo-solution .product-box {
                margin: initial !important;
            }
            /*.weblink {
                color: #2c4769 !important;
                width: 100%;
                text-align: center;
            }*/
            .marmo-solution .marmo-product {
                width: 100%;
                margin: -11% 0 0 auto;
            }
            /*.weblink{
                text-align:center;
            }*/
            .weblink a {
                color: #fff;
                position: absolute;
                bottom: 5px;
            }

            .marmo-solution {
                padding-bottom: 45px;
            }

            .form-box {
                margin-top: 0px !important;
                margin: auto;
                margin-bottom: 40px;
                width: 100%;
            }

            .icon-box .box img {
                width: 30%;
                padding: 10px 7px;
            }

            .form-box h5 {
                padding: 30px 11px;
            }
        }


        @media screen and (width:768px) {
            .marmo-solution .product-box {
                margin: 57% 0 0 auto !important;
            }

            .marmo-solution {
                height: 100vh;
            }

            .icon-box .box img {
                width: 24%;
            }

            .icon-box .box {
                margin-bottom: 15px;
            }

            .position-box {
                position: absolute;
                bottom: 0px;
            }

            .slide-right {
                width: 55%;
                position: absolute;
                bottom: 9%;
            }

            .icon-box .box img {
                width: 42%;
            }

            .icon-box .box {
                padding: 10px 15px;
            }

            .marmo-solution .marmo-product {
                width: 90%;
                margin-top: -5%;
            }
        }

        @media screen and (min-width:820px)and (max-width:912px) {
            /*.marmo-solution .product-box {
                margin: 100% 0 0 auto;
                padding: 45px 47px;
                bottom: -30px;
                width: 100%;
                left: 0;
                display: flex;
                flex-direction: column;
            }*/
            .marmo-solution {
                height: 100vh;
            }

            .position-box {
                position: absolute;
                bottom: 0px;
            }

            .marmo-solution .marmo-product {
                width: 95%;
            }

            /* .position-box .col-md-4 {
                width: 90%;
                margin: auto;
            }*/

            .icon-box .box {
                margin-bottom: 15px;
            }

                .icon-box .box img {
                    width: 42%;
                }

            .marmo-solution .marmo-logo {
                width: 35%;
            }

            .slide-right {
                width: 80%;
                position: absolute;
                bottom: 0%;
            }

            .icon-box .box {
                padding: 10px 15px;
            }
        }

        @media screen and (width:912px) {
            .position-box {
                width: 80%;
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

            .marmo-solution .marmo-product {
                width: 100%;
                margin-top: 28%;
            }

            .position-box {
                width: 100%;
                margin-top: -64px;
            }
        }

        @media screen and (width:1024px) {
            .marmo-solution .marmo-product {
                margin-top: 80%;
            }
        }

        @media screen and (width:1280px) {
            .marmo-solution .marmo-product {
                margin-top: 80%;
            }
        }

        @media screen and (min-width:1281px) {
            /*.position-box {
                bottom: -37px;
                width: 90%;
                left: 6%;
            }*/
            /*.marmo-solution .product-box {
                margin: 0%;
            }*/
            .icon-box .box {
                padding: 29px 31px 27px 20px;
            }
        }

        .lubeign-rev {
            display: flex;
            flex-direction: row-reverse;
        }
    </style>

    <script>

        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }
        $('#otherfield').hide();
        function Getdata() {
            debugger;
            var mobileno = document.querySelector("#mobilenumber").value;

            if (mobileno.length == 10) {
                $.ajax({
                    type: "Post",
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNo&MobileNo= ' + $("#mobilenumber").val(),
                    success: function (data) {

                        debugger;

                        var Name = data.split('~')[0];
                        var pin = data.split('~')[6];
                        var city = data.split('~')[2];
                        if (Name != "") {
                            $("#Name").val(Name);
                        }
                        if (Name == "") {
                            $('#otherfield').show();
                            $('#mobilefield').hide();
                            $('#Chkfields').show();
                        }
                        if (pin != "") {
                            $("#pin").val(pin);
                        }
                        if (pin == "") {
                            $('#otherfield').show();
                            $('#mobilefield').hide();
                            $('#Chkfields').show();
                        }

                        if (city != "") {
                            $("#city").val(city);
                        }
                        if (city == "") {
                            $('#otherfield').show();
                            $('#mobilefield').hide();
                            $('#Chkfields').show();
                        }
                    }
                });
            }
        }

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
            $.getJSON("https://api.postalpincode.in/pincode/" + pin, function (data) {
                createHTML(data);
            })
            function createHTML(data) {

                var city = "";
                var state = "";
                var pin = "";
                debugger;

                var city = data[0].PostOffice[0]['District'];
                var state = data[0].PostOffice[0]['State'];
                var Pin = data[0].PostOffice[0]['PinCode'];

                $("#city").val(city);
            }
        }
        function pinval() {
            var pin = $('#pin').val();
            if (pin != undefined) {

                if ($('#pin').val().length < 1) {
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

            else if (id == "Lubi") {
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
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1] + '&Client=Lubigen Automotive and Industrial Lubicants',
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
                var mobilenumber = $('#mobilenumber').val()
                if ($('#mobilenumber').val() == "") {
                    valmobile();
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                   // validate = false;
                }
                if (mobilenumber.length != 10) {
                    toastr.error("Please enter 10 digit of mobile No.");
                    $('#btnsubmit').attr('disabled', false);
                    return false;

                }
               else {
                    if ($('#Name').val() == "") {
                        namevalid();
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

                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&name=' + $('#Name').val() + '&city=' + $('#city').val() + '&PinCode=' + $('#pin').val() + '&comp=' + $('#CompName').val() + '&Comp_ID=Comp-1272',
                            success: function (data) {
                                debugger;
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
                                    $('#p3msg').html(data.split('~')[1] );

                                    $('#p3msg:contains("not")').css('color', 'black');
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
                window.location.href = 'https://lubigen.com/';
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
    <div class="marmo-solution">
        <header>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-8">
                        <a class="" href="https://lubigen.com/">
                            <img src="assets/images/lubigen/lubign-logo.png" alt="marmo-logo" class="marmo-logo" />
                        </a>
                    </div>
                    <div class="col-md-4 weblink">
                        <a class="" href="https://lubigen.com/">
                            <h5 class="weblink" style="float: right; color: #fff; padding: 5px 5px;">www.lubigen.com</h5>
                        </a>
                    </div>

                </div>
            </div>
        </header>
        <section>
            <div class="container">
                <div class="row lubeign-rev">

                    <div class="col-md-8">
                        <div class="form-box mt-5 animate__animated animate__fadeInLeft">
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
                                            <h5 class="text-uppercase">to check authenticity And Avail Benefits</h5>
                                        </div>
                                    </div>
                                    <div class="width-box">
                                        <div id="ChkCode">
                                            <div class="col-sm-12">
                                                <input type="text" maxlength="13" minlength="13" id="codeone" class="form-control" placeholder="Enter Unique 13 Digit Code*" />
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
                                                    <input type="text" maxlength="10" onkeyup="Getdata()" onkeypress="return onlyNumberKey(event)"  id="mobilenumber" minlength="10" data-msg-required="Please Enter Your Moblie Number" class="form-control" placeholder="Enter Mobile Number*" />
                                                </div>
                                                <%--  <div>
                                              <center>
                                              <button type="button" data-toggle="modal" id="btnnxt1" class="btn text-uppercase">Next</button>
                                                  </center>
                                                  </div>--%>
                                            </div>
                                            <div id="otherfield" style="display: none">
                                                <div class="col-12">
                                                    <input type="text" class="form-control" onKeyPress="return ValidateAlpha(event);" id="Name" placeholder="Enter Name*" />
                                                </div>
                                                <div class="col-12">
                                                    <input type="text" class="form-control" id="pin" maxlength="6" minlength="6" onkeypress="return onlyNumberKey(event)" onkeyup="getaddress()" placeholder="Enter Pin*" />
                                                </div>
                                                <div class="col-12">
                                                    <input type="text" class="form-control" onKeyPress="return ValidateAlpha(event);" id="city" placeholder="Enter City*" />
                                                </div>
                                            </div>


                                            <div class="col-12 text-center">
                                                <button type="button" data-toggle="modal" id="btnsubmit" class="btn text-uppercase">SUBMIT</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div style="display: none;" id="ShowMessage" class="row no-gutters pl-4 pr-4 textmessage">
                                    <center>
                                        <div class="col-md-12">
                                            <br />
                                            <div class="form-group" style="padding: 20px;">
                                                <p id="p3msg" style="overflow: hidden; font-size: 14px !important;" class="displayNone massage_box"></p>
                                            </div>
                                            <a href="javascript:void(0)" class="next_btn" id="btnNext"><b>Close</b></a>

                                        </div>
                                    </center>
                                </div>

                            </form>
                        </div>
                    </div>

                    <div class="col-md-4 mt-5 ">
                        <div class=" slide-right">
                            <img src="assets/images/lubigen/product_1.png" alt="lubeign-product" class="marmo-product" />
                        </div>
                    </div>





                </div>

            </div>

            <%-- <div  class="container">
                        <div class="row box1 pb-3 position-box animate__animated animate__bounce">
                            
                            <div class="col-md-4">
                                <div class="icon-box">
                                    <div class="box">
                                        <img src="assets/images/lubeign/icon-1.jpg" alt="sticker" class="icon1" />
                                        <p>Only accept products with authentication sticker</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="icon-box animate__animated animate__bounce">
                                    <div class="box">
                                        <img src="assets/images/lubeign/icon-2.jpg" alt="sticker" class="icon1" />
                                        <p style="font-size: 13px; font-weight: 500;">Dont accept products with stickers that have been scratched Off</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="icon-box animate__animated animate__bounce">
                                    <div class="box">
                                        <img src="assets/images/lubeign/icon-3.jpg" alt="sticker" class="icon1" />
                                        <p>Only buy from authorized retailers</p>
                                    </div>
                                </div>
                            </div>
                        
                        </div>
                    </div>--%>
        </section>

    </div>





</body>
</html>
