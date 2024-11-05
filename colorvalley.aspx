<%@ Page Language="C#" AutoEventWireup="true" CodeFile="colorvalley.aspx.cs" Inherits="colorvalley" %>

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




    <title>Color Valley</title>

    <style>
        * {
            margin: 0px;
            padding: 0px;
        }

        .color-valley {
            background-image: url(assets/images/CollorValley-img/ColorValley-bg.jpg);
            background-repeat: no-repeat;
            background-position: top;
            background-size: cover;
            width: 100%;
            position: relative;
            display: table;
            height: 100vh;
            padding: 10px 0px;
        }

            .color-valley .color-valley-logo {
                width: 275px;
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

        .color-valley-product {
            width: 90%;
        }

        .form-box {
            background-color: #3e4095b8;
            display: table;
            margin: auto;
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
                font-size: 85%;
                font-weight: 700;
            }

        .color-valley .form-box button {
            background-color: #ffcc29;
            color: #3e4095;
            margin-top: 5%;
            padding: 5px 32px;
            border-radius: 13px;
            font-weight: 600;
            box-shadow: 0px 0px 7px #ffffff8a;
        }

            .color-valley .form-box button:hover {
                background-color: #3e4095;
                color: #fff;
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

        .cv-footer {
            background-color: #3e4095;
            padding: 10px 0px;
        }

            .cv-footer span {
                color: #db2c16;
                padding: 4px 8px;
                background-color: #ffff;
                border-radius: 50px;
                font-size: 24px;
                vertical-align: middle;
            }
            .cv-footer p{
                display: inline-block;
                color: #fff;
                float: right;
                padding: 10px 0px;
                margin-bottom: 0px;
            }
                .cv-footer p a {
                    text-decoration:none;
                    color:#ffcc29;
                    font-weight:800;
                    cursor:pointer;
                }
            
            .cv-footer img {
                width: 38px;
            }

            .cv-footer .footer-link {
                text-decoration: none;
                color: #fff;
                font-size: 18px;
                padding-left: 10px;
                cursor: pointer;
            }
            #p3msg{
                color:white;
            }

        @media screen and (max-width:767px) {
            .custom_code {
                flex-direction: column-reverse;
                margin-top: 22px;
            }

            .color-valley-product {
                width: 100%;
            }

            .CV-title {
                font-size: 27px;
            }
            .cv-footer p {
                text-align: center;
                display: block;
                float: initial;
            }
            .margin-icon{
                text-align:center;
            }
        }

        @media screen and (min-width:768px) and (max-width:920px) {
            .color-valley-product {
                width: 63% !important;
            }
        }
        /* @media screen and (width:820px){
            .color-valley-product {
                width: 63%!important;

            }
        }*/
        @media screen and (min-width:768px) and (max-width:1280px) {
            .color-valley-product {
                width: 50%;
                position: absolute;
                bottom: 0px;
                left: 0px;
            }

            .form-box {
                margin-top: 25%;
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

                        if (Name != "")
                            $("#Name").val(Name);
                        if (city != "")
                            $("#city").val(city);


                    }
                });
            }
        }





        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }



        $(document).ready(function () {


            firstfunction();


            var id = $('#HdnID').val();


            if (id == "1") {

                $('#ChkCode').show();
                $('#Chkfields').hide();
            }

            else if (id == "Color") {
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



                if (validate) {
                    $('#p3msg').html('');


                    if (code != "") {
                        $.ajax({
                            type: "POST",
                            contentType: false,
                            processData: false,

                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&name=' + $('#Name').val() + '&city=' + $('#city').val() + '&Comp_ID=Comp-1270',
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

                                    $('#p3msg:contains("not")').css('color', 'White');
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
                window.location.href = 'http://www.cvalley.in/';
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
    <section class="color-valley">
        <header>
            <div class="container">
                <a href="http://www.cvalley.in/" target="_blank">
                    <img src="assets/images/CollorValley-img/ColorValley-logo.png" alt="ColorValley-logo" class="img-fluid color-valley-logo animate__animated animate__pulse" /></a>
            </div>
        </header>
        <section class="container">
            <div class="row">
                <div class="col-sm-12">
                    <h2 class="text-center CV-title text-uppercase mt-3  animate__animated animate__backInDown">Welcome to the world
                        <br />
                        of <span>COLOR VALLEY</span> COATINGS</h2>
                </div>
            </div>
            <div class="row custom_code">
                <div class="col-sm-7 text-center">
                     
                
                    <img src="assets/images/CollorValley-img/ColorValley-product-img.png" alt="ColorValley-product-img" class="img-fluid mt-5 color-valley-product animate__animated animate__fadeInLeft" />
                </div>
                <div class="col-sm-5">
                    <form class="color-valley-form">
                        <div class="form-box  animate__animated animate__backInRight">
                            <form class="form-group" runat="server">


                                <asp:HiddenField ID="hdnmob" runat="server" />
                                <asp:HiddenField ID="HdnID" runat="server" />
                                <asp:HiddenField ID="HdnCode1" runat="server" />
                                <asp:HiddenField ID="HdnCode2" runat="server" />
                                <asp:HiddenField ID="CompName" runat="server" />
                                <asp:HiddenField ID="long" runat="server" />
                                <asp:HiddenField ID="lat" runat="server" />


                                <div class="row">
                                    <div id="fields">
                                        <div class="col-12">
                                            <h5 class="text-uppercase">to check authenticity And Avail Benefits</h5>
                                        </div>

                                        <div class="width-box">
                                            <div id="ChkCode">
                                                <div class="col-sm-12">
                                                    <label>Enter 13-Digit Code/13 अंकों का कोड दर्ज करें *</label>
                                                    <input type="text" id="codeone" maxlength="13" class="form-control input1" placeholder="Enter Unique 13 Digit Code*" required />
                                                </div>
                                            </div>
                                            <div id="Chkfields">
                                                <div class="col-12">
                                                    <label>Enter Mobile Number/मोबाइल नंबर दर्ज करें *</label>
                                                    <input type="text" id="mobilenumber" onkeyup="Getdata()" maxlength="10" data-msg-required="Please Enter Your Moblie Number" class="form-control" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="Enter Mobile Number*" required />
                                                </div>
                                                <div class="col-12">
                                                    <label>Enter Name/नाम दर्ज करें *</label>
                                                    <input type="text" id="Name" class="form-control"  placeholder="Enter Name*" required />
                                                </div>

                                                <div class="col-12">
                                                    <label>Enter City/शहर दर्ज करें *</label>
                                                    <input type="text" id="city" class="form-control"  placeholder="Enter City*" required />
                                                </div>

                                                <div class="col-12 text-center">
                                                    <button type="button" id="btnsubmit" data-toggle="modal" class="btn text-uppercase">SUBMIT</button>
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

                                            </div>
                                        </center>
                                    </div>


                                </div>
                            </form>
                        </div>
                    </form>
                </div>
            </div>
        </section>
    </section>
    <footer class="cv-footer">
        <div class="container">
            <div class="row">
                <div class="col-sm-12 margin-icon">
                    <a href="#"><span><i class="fa fa-youtube-play" aria-hidden="true"></i></span></a>
                    <img src="assets/images/CollorValley-img/web-icon.png" alt="web-icon" class="img-fluid" />
                    <a href="http://www.cvalley.in/" target="_blank" class="footer-link">www.cvalley.in</a>
                    <p id="wlink" class="blink_me">For QR or code related query, contact on <a href="tel:7353000903">7353000903</a></p>
                </div>
            </div>
        </div>
    </footer>

</body>
</html>
