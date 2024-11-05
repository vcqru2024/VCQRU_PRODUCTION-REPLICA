<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Marmo.aspx.cs" Inherits="Marmo" %>

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
    <script src="https://use.fontawesome.com/53f5a10329.js"></script>

    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="Content/js/jquery-1.11.1.min.js"></script>
    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>

    <title>Marmo Solution</title>
    <style>
        * {
            margin: 0px;
            padding: 0px;
            font-family: 'Poppins', sans-serif;
        }

        .marmo-solution {
            background-image: url(./assets/images/marmo/bg-img.jpg);
            background-repeat: no-repeat;
            background-position: top;
            background-size: cover;
            width: 100%;
            position: relative;
            display: table;
            height: 100vh;
            padding-bottom: 10px;
        }

            .marmo-solution .marmo-logo {
                width: 17%;
                padding: 10px 0px;
            }
        .form-box .width-box label{
            display: inline-block;
            font-size: 12px;
            color: #000;
            font-weight: 500;
        }
        .form-box {
            background-color: #e4e7ec8a;
            display: table;
            margin: auto;
            border-radius: 25px;
            border: 5px solid #fff;
            padding-bottom: 15px;
            margin-bottom: 7%;
            width:90%;
        }

            .form-box h5 {
                text-align: center;
                width: 99.5%;
                color: #fff;
                background-color: #2c4769;
                padding: 30px 10px;
                border-bottom-right-radius: 70%;
                border-bottom-left-radius: 70%;
                margin: auto;
                border-top-left-radius: 23px;
                border-top-right-radius: 23px;
                margin-bottom: 15px;
                line-height: 22px;
                font-size: 85%;
            }

        .marmo-solution .form-box button {
            background-color: #00265a;
            color: #fff;
            margin-top: 5%;
            padding: 5px 32px;
        }

        .width-box {
            width: 80%;
            margin: auto;
        }

            .width-box input {
                border-radius: 50px;
                border: 3px solid #fff;
                background-color: #e4e7ec;
                margin-bottom: 7px;
                font-size: 13px;
                padding: 8px 20px;
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
                margin-right: 5%;
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

        .marmo-solution h1 {
            font-weight: 600;
            color: #fff;
            text-shadow: 1px 2px 0px #0000009c;
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

            .footer-box {
                flex-direction: column;
                text-align: center;
            }
        }

        @media screen and (width:412px) {

            .footer-box {
                flex-direction: column;
                text-align: center;
            }
        }

        @media screen and (max-width:767px) {
            .marmo-solution .marmo-logo {
                width: 50%;
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

            footer {
                padding-top: 0% !important;
            }
        }


        @media screen and (width:768px) {
            .marmo-solution .product-box {
                margin: 80% 0 0 auto !important;
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

            .position-box {
                bottom: 12px;
            }

            footer {
                padding-top: 45% !important;
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

            .position-box {
                bottom: 20px;
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
        }

        footer {
            padding-top: 35%;
        }

            footer a {
                text-decoration: none;
                color: #00265a;
            }

                footer a:hover {
                    color: #da7c3d;
                }

                footer a i {
                    background-color: #00265a;
                    padding: 10px 10px;
                    border-radius: 100px;
                    color: #fff;
                }

                    footer a i:hover {
                        color: #da7c3d;
                    }

        @media screen and (width:912px) {
            .position-box {
                bottom: 100%;
                width: 90%;
                top: 65%;
            }

            footer {
                padding-top: 44% !important;
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
                margin-top: 40%;
            }

            .position-box {
                bottom: 36px;
                width: 100%;
                left: 0%;
            }

            footer {
                padding-top: 4%;
            }
        }

        @media screen and (width:1280px) {
            .position-box {
                bottom: 66px;
            }
        }

        @media screen and (min-width:1281px) {
            .position-box {
                bottom: 34px;
                width: 90%;
                left: 6%;
            }

            .marmo-solution .product-box {
                margin-top: 22%;
            }

            .icon-box .box {
                padding: 29px 31px 27px 20px;
            }
        }
    </style>


    <script>


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

                        var city = data.split('~')[2];
                        var Retailer = data.split('~')[4];
                        var UPI = data.split('~')[10];
                        if (Name != "")
                            $("#Name").val(Name);
                        if (city != "")
                            $("#city").val(city);
                        if (Retailer != "")
                            $("#retailername").val(Retailer);
                        if (UPI != "")
                            $("#UPI").val(UPI);

                    }
                });
            }
        }




        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }

        function valUpiID() {
            var UpiID = $('#UPI').val();
            if (UpiID.charAt(0) === ' ') {
                toastr.error('Please Enter a Valid UPI ID');
                return false;
            }
            if (UpiID == "") {
                toastr.error('Please Enter a Valid UPI ID');
                return false;
            }
            var filter = /^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$/;
            if (!filter.test(UpiID)) {
                toastr.error('Please Enter a Valid UPI ID');
                return false;
            }
        }

        $(document).ready(function () {


            firstfunction();


            var id = $('#HdnID').val();


            if (id == "1") {

                $('#ChkCode').show();
                $('#Chkfields').hide();
            }

            else if (id == "Marmo") {
                $('#ChkCode').hide();
                $('#Chkfields').show();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $("#codeone").val(code);


            }







            $("#codeone").mask("99999-99999999");

            $(".input1").keyup(function () {

                if (this.value.length == this.maxLength) {
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

                                    }
                                }
                            });

                        }
                    });
                }
            });












            $('#btnsubmit').on('click', function () {
                $('#btnsubmit').attr('disabled', true);

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
                    //var matches1 = $('#Name').val().match(/[^a-zA-Z0-9 ]/);
                    //if (matches1 != null) {
                    //    toastr.error('Name Should Not Contain any Special Character!');
                    //    validate = false;
                    //}
                }


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
                    //var matches1 = $('#city').val().match(/[^a-zA-Z0-9 ]/);
                    //if (matches1 != null) {
                    //    toastr.error('City Name Should Not Contain any Special Character!');
                    //    validate = false;
                    //}
                }

                var retailername = $('#retailername').val();
                if (retailername != undefined) {

                    if ($('#retailername').val().length < 1) {
                        toastr.error('Please Enter valid Retailer');
                        validate = false;
                    }
                    var matches = $('#retailername').val().match(/\d+/g);
                    if (matches != null) {
                        toastr.error('Retailer Name Should be alphabet only!');
                        validate = false;
                    }
                    //var matches1 = $('#retailername').val().match(/[^a-zA-Z0-9 ]/);
                    //if (matches1 != null) {
                    //    toastr.error('Retailer Name Should Not Contain any Special Character!');
                    //    validate = false;
                    //}
                }
                var UPI = document.getElementById('UPI').value;
                if ($('#UPI').val() == "") {
                    valUpiID();
                    $('#btnsubmit').attr('disabled', false);
                    return false;



                }
                if (UPI != "") {
                    var check = validateUPI(UPI);

                    if (check != true) {
                        toastr.error('Please Enter a Valid UPI ID');
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                }


                if (validate) {
                    $('#p3msg').html('');


                    if (code != "") {
                        $.ajax({
                            type: "POST",
                            contentType: false,
                            processData: false,

                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&SellerName=' + $('#retailername').val() + '&name=' + $('#Name').val() + '&city=' + $('#city').val() + '&UPI=' + UPI + '&Comp_ID=Comp-1266',
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
                                    $('#ShowMessage').show();
                                    $('#chkLine').hide();
                                    $('#p3msg').html(data.split('~')[1] + "<br/><br/>");

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


                }
                else {

                    $('#btnsubmit').attr('disabled', false);

                }

            });



            $('#btnNext').click(function () {
                window.location.href = 'http://www.marmosolutions.com/';
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
        function validateUPI(UPI) {
            var re = /^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$/;
            return re.test(UPI);
        }

        function UPICheck() {
            debugger;

            //var Email = $('#mail').val();
            var UPI = document.getElementById('UPI').value;

            if (UPI != "") {
                var check = validateUPI(UPI);

                if (check != true) {
                    toastr.error('Please Enter a Valid UPI ID');
                    return false;
                }
                else if (check == true) {
                    $('#UPI').html("");
                    $('#UPI').hide();
                }
            }


        }
    </script>


</head>
<body>
    <div class="marmo-solution">
        <header>
            <div class="container">
                <a href="http://www.marmosolutions.com/" target="_blank">
                    <img src="assets/images/marmo/marmo-logo.png" alt="marmo-logo" class="marmo-logo" /></a>
            </div>
        </header>
        <section>
            <div class="container">
                <div class="row">
                    <div class="col-sm-12 p-3">
                        <h1 class="text-center text-uppercase font-weight-bold">Welcome to the world of MARMO Solutions</h1>
                    </div>
                    <div class="col-md-5">
                        <div class="form-box mt-4 animate__animated animate__fadeInLeft">
                            <form id="form1" runat="server">

                                <asp:HiddenField ID="hdnmob" runat="server" />
                                <asp:HiddenField ID="HdnID" runat="server" />
                                <asp:HiddenField ID="HdnCode1" runat="server" />
                                <asp:HiddenField ID="HdnCode2" runat="server" />
                                <asp:HiddenField ID="CompName" runat="server" />
                                <asp:HiddenField ID="long" runat="server" />
                                <asp:HiddenField ID="lat" runat="server" />


                                <div class="row">
                                    <div id="fields">
                                        <div class="col-12" id="CodeHeading">
                                            <h5 class="text-uppercase">to check authenticity And Avail Benefits</h5>
                                        </div>

                                        <div class="width-box">
                                            <div id="ChkCode">
                                                <div class="col-sm-12">
                                                    <label>Enter 13 Digit Code/13 अंकों का कोड दर्ज करें*</label>
                                                    <input type="text" id="codeone" maxlength="13" class="form-control input1" placeholder="Enter 13 Digit Code*" />
                                                </div>
                                            </div>
                                            <div id="Chkfields">
                                                <div class="col-12">
                                                    <label>Enter Mobile Number/मोबाइल नंबर दर्ज करें*</label>
                                                    <input type="text" id="mobilenumber" onkeyup="Getdata()" maxlength="10" data-msg-required="Please Enter Your Moblie Number" class="form-control" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="Enter Mobile Number*" />
                                                </div>

                                                <div class="col-12">
                                                    <label>Enter Name/नाम दर्ज करें*</label>
                                                    <input type="text" id="Name" class="form-control"  placeholder="Enter Name*" />
                                                </div>
                                                <div class="col-12">
                                                    <label>Enter City/शहर दर्ज करें *</label>
                                                    <input type="text" id="city" class="form-control" placeholder="Enter City*" />
                                                </div>

                                                <div class="col-12">
                                                    <label>Enter Retailer/Shop Name / दुकान का नाम दर्ज करें*</label>
                                                    <input type="text" id="retailername" class="form-control" placeholder="Enter Retailer/Shop Name *" />
                                                </div>
                                                <div class="col-12">
                                                    <label>Enter UPI / UPI दर्ज करें*</label>
                                                    <input type="text" maxlength="40" minlength="6" id="UPI" class="form-control" placeholder="Enter UPI *" />
                                                </div>
                                               <%-- <div>
                                                    <center>
                                                    <h9 style="color:darkblack">(Shop name from where he has bought the product)</h9>
                                                    </center>
                                                </div>--%>


                                                <div class="col-12 text-center">
                                                    <button type="button" id="btnsubmit" data-toggle="modal" class="btn text-uppercase">SUBMIT</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div style="display: none;" id="ShowMessage" class="row no-gutters pl-4 pr-4 textmessage">
                                        <br />
                                         <center>
                                        <div class="col-md-12">
                                            <br />
                                          
                                            <div class="form-group" style="margin-left: 7%;">
                                                <p id="p3msg" style="overflow: hidden; font-size: 14px !important;" class="displayNone massage_box"></p>
                                            </div>
                                           
                                                <a href="javascript:void(0)" class="next_btn" id="btnNext">Close</a>
                                            
                                        </div>
                                        </center>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="col-md-7">
                        <div class="product-box animate__animated animate__backInRight">
                            <img src="assets/images/marmo/marmo-product-img.png" alt="marmo-product" class="marmo-product" />
                        </div>
                    </div>
                </div>

            </div>

            <div class="row mb-5 position-box animate__animated animate__bounce">
                <div class="col-md-4">
                    <div class="icon-box">
                        <div class="box">
                            <img src="assets/images/marmo/icon-1.png" alt="sticker" class="icon1" />
                            <p>Only accept products with authentication sticker</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="icon-box animate__animated animate__bounce">
                        <div class="box">
                            <img src="assets/images/marmo/icon-2.png" alt="sticker" class="icon1" />
                            <p>Dont accept products with stickers that have been scratched Off</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="icon-box animate__animated animate__bounce">
                        <div class="box">
                            <img src="assets/images/marmo/icon-3.png" alt="sticker" class="icon1" />
                            <p>Only buy from authorized retailers</p>
                        </div>
                    </div>
                </div>
            </div>


        </section>

        <footer>
            <div class="container">
                <div class="col-12 d-flex justify-content-between footer-box">
                    <a href="http://www.marmosolutions.com/" target="_blank">
                        <h6>www.marmosolutions.com</h6>
                    </a>
                    <a href="https://www.youtube.com/channel/UCZoPRg65NFH-4rxJ3pUsClA" target="_blank"><i class="fa fa-youtube-play" aria-hidden="true"></i></a>
                </div>
            </div>
        </footer>

    </div>





</body>
</html>
