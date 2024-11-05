<%@ Page Language="C#" AutoEventWireup="true" CodeFile="1stop.aspx.cs" Inherits="_1stopnutrition" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>One Stop Nutrition</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <%--<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>--%>

    <script src="../Content/js/jquery-1.11.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>


    <style type="text/css">
        #wlink a {
            color: #fff;
            text-decoration: none;
        }

        #wlink {
            color: #fff;
            margin: 15px 0px;
        }

        .background-desk {
            position: relative;
            background-size: cover;
            background-repeat: no-repeat;
            background-position: 100%;
            width: 100%;
            display: table;
            height: 100vh;
            background-image: url(./assets/images/onestop/desktop-bg.jpg);
        }

        .OSN-form {
            padding-top: 10px;
        }

        .logo-img img {
            width: 18%;
            padding: 18px 0px;
        }

        .OSN-form .form-box {
            background-color: #353742;
            display: table;
            margin: auto;
            padding-bottom: 15px;
            margin-bottom: 64px;
            .OSN-product bottom: 0px;
            top: 0%;
        }

        .form-box h5 {
            text-align: center;
            width: 100%;
            color: #000;
            background-color: #ffff00;
            padding: 16px 32px 43px 32px;
            margin: -1px auto;
            border-bottom-left-radius: 100%;
            border-bottom-right-radius: 100%;
            margin-bottom: 33px;
            line-height: 22px;
            font-size: 84%;
            font-weight: 700;
        }

        .OSN-form .width-box input::placeholder {
            font-size: 12px;
        }

        .OSN-form .width-box {
            padding: 0px 20px;
        }

            .OSN-form .width-box input {
                border-radius: 0px;
                margin-bottom: 7px;
            }

        .form-box .OSN-button {
            background-color: #ffff00;
            color: #000;
            margin-top: 5%;
            padding: 5px 32px;
            border-radius: 0px;
            font-weight: 600;
        }

            .form-box .OSN-button:hover {
                background-color: #3e4095;
                color: #fff;
            }


        footer {
            position: absolute;
            bottom: 0px;
            background-color: #ffff00;
            width: 100%;
            text-align: center;
            padding: 8px;
        }

            footer a {
                color: #000;
            }

        .number-style a {
            color: #fff;
            text-decoration: none;
        }

        .OSN-product {
            position: absolute;
            width: 48%;
            right: 10%;
            bottom: 32px;
            left: 50%;
        }

        .form-maine {
            padding: 0px 28px 5px;
            margin-bottom: 70px;
        }

        @media screen and (max-width:767px) {
            .logo-img img {
                width: 45%;
            }

            .OSN-form .form-box {
                position: initial !important;
            }

            .OSN-product {
                position: initial;
                width: 100%;
            }

            .background-desk {
                background-image: url(./assets/images/onestop/mobile-bg.jpg) !important;
                position: relative;
                background-size: cover;
                background-repeat: no-repeat;
                background-position: 100%;
                width: 100%;
                display: table;
                height: 100vh;
            }
        }


        @media screen and (min-width:768px) and (max-width:920px) {
            .OSN-form .form-box {
                position: initial !important;
                margin-top: 25%;
            }

            .OSN-product {
                max-width: 75%;
                /*left: 19%;
                right:20%;*/
            }
        }

        @media screen and (min-width:280px)and (max-width:540px) {
            .OSN-product {
                padding: 0px 0px 40px 0px;
            }

            .OSN-form {
                padding-top: 45px;
            }
        }

        @media screen and (width:1024px) {
            .OSN-form .form-box {
                /*  margin-bottom: 42px;*/
            }
        }

        @media screen and (width:1280px) {
            .OSN-form .form-box {
                margin-bottom: 13%;
            }
        }
    </style>

    <!--   link are added here for the jquery and the mask jquery cdn is also added
    -->
    <%--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/0.9.0/jquery.mask.min.js"></script>--%>

    <script type="text/javascript">
        // it is the variable initialized for the location purpose.
        var lat = "";
        var long = "";
        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }

        // form this function we may easily collect the data to the our database by using the post api

        function Mobile_check() {

            var mobile_val = $('#mobile').val();
            var d = mobile_val.slice(0, 1);
            var c = parseInt(d);

            if ((mobile_val.length == '') || (mobile_val.length != 10)) {
                $('#mobilecheck').show();
                $('#mobilecheck').html("**Please Enter mobile number");
                $('#mobilecheck').css("color", "red");
                mobile_err = false;
                return false;
            }

            // if the mobile length value is correct and drop down list is not empty then through post api we can easily collect the data from the user
            if (mobile_val.length == 10) {
                debugger;
                $('#mobilecheck').hide();
                $.ajax({
                    type: "Post",
                    url: './Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNo&MobileNo= ' + $("#mobile").val(),
                    success: function (data) {

                        if (c <= 5) {
                            $('#mobilecheck').text('Please Enter correct Mobile Number');
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
                            var UpiId = data.split('~')[10];

                            if (Name != "") {
                                $("#name").val(Name);
                                $("#name").attr("readonly", true);

                            }
                            else {

                                $('#Chkcode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();
                                $("#name").attr("readonly", false);

                            }
                            if (pin != "") {
                                $("#Pincode").val(pin);
                                $("#Pincode").attr("readonly", true);

                            }
                            else {
                                $('#Chkcode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();
                                $("#Pincode").attr("readonly", false);

                            }

                            if (city != "") {
                                $("#city").val(city);
                                $("#city").attr("readonly", true);
                              
                            }
                            else {
                                $('#Chkcode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();
                                $("#city").attr("readonly", false);
                               
                            }

                            if (state != "") {
                                $("#state").val(state);
                               
                                $("#state").attr("readonly", true);
                            }
                            else {
                                $('#Chkcode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();
                               
                                $("#state").attr("readonly", false);
                            }
                            //if (Address != "") {
                            //    $("#Address").val(Address);
                            //}
                            //else {
                            //    $('#Chkcode').hide();
                            //    $('#mobilefield').hide();
                            //    $('#Chkfields').show();
                            //    $('#Otherfield').show();
                            //}



                        }
                    }
                });
            }
            else {
                $("#name").val('');
                $("#Pincode").val('');
                $("#city").val('');
                $("#state").val('');
                $("#Address").val('');

            }
        }




        /*Pincode Api for the city and the state  */
        function Pin_check() {
            debugger;

            let pin = document.getElementById("Pincode").value;
            if (pin.length == 6) {
                $.getJSON("https://api.postalpincode.in/pincode/" + pin, function (data) {

                    createHTML(data);
                });
                function createHTML(data) {

                    if (data[0].Status == "Success") {
                        var city = "";
                        var state = "";
                        var pin = "";
                        var city = data[0].PostOffice[0]['District'];
                        var state = data[0].PostOffice[0]['State'];
                        var Pin = data[0].PostOffice[0]['PinCode'];
                        $('#Pincode').text('');
                        $("#city").val(city);
                        $("#city").attr("readonly", true);
                        $("#state").val(state);
                        $("#state").attr("readonly", true);
                        $('#pincheck').hide();
                        $('#citycheck').hide();
                        $('#statecheck').hide();

                        if ($("#city").val() != "") {

                        }
                        if ($("#state").val() != "") {

                        }
                    }
                    else {
                        $('#pincheck').show();
                        $('#pincheck').html("**Please Enter Valid Pincode");
                        $('#pincheck').css("color", "red");
                        pin_err = false;
                        $("#city").attr("readonly", false);
                        $("#state").attr("readonly", false);
                        return false;
                    }
                   // $("#city").attr("readonly", false);
                   // $("#state").attr("readonly", false);
                }
                
            }

            else {
                $("#city").val('');
                $("#state").val('');
                $('#pincheck').show();
                $('#pincheck').html("**Please Enter the 6-digits pin code");
                $('#pincheck').css("color", "red");
                $("#city").attr("readonly", false);
                $("#state").attr("readonly", false);
                pin_err = false;
                return false;
            }

        }

        $(document).ready(function () {

            debugger;
            $('#Chkcode').show();
            $('#Chkfields').hide();
            $('#mobilefield').hide();
            $('#Otherfield').hide();


            var id = $('#HdnID').val();

            if (id == "1") {

                $('#Chkcode').show();
                $('#Chkfields').hide();
                $('#mobilefield').hide();
                $('#Otherfield').hide();
            }

            else if (id == "1Stop") {
                $('#Chkcode').hide();
                $('#mobilefield').show();
                $('#Chkfields').show();
                $('#Otherfield').hide();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $("#example13-digit-number").val(code);
            }


            var code_err = true;
            var mobile_err = true;
            var name_err = true;
            var pin_err = true;
            var city_err = true;
            var state_err = true;


            // check for the 13-digit number when the user is enter to check the code is correct or else 

            $("#example13-digit-number").mask("99999-99999999");

            $("#btnnxt").on('click', function (e) {
                e.preventDefault();
                debugger;

                var codeone = $('#example13-digit-number').val();

                if (codeone == "" || codeone == undefined) {
                    $('#nextcheck').html('Please Enter 13 Digit Code');
                    $('#nextcheck').css("color", "red");
                    return false;
                }
                else {
                    $('#nextcheck').text('');
                }

                if (codeone != undefined) {
                    if ($('#example13-digit-number').val().length < 14) {
                        $('#nextcheck').text('Please Enter 13 Digit Code');
                        $('#nextcheck').css("color", "red");
                        return false;
                    }
                    else {
                        $('#nextcheck').text('');
                        $('#nextcheck').hide();
                    }
                }

                var rquestpage_Dcrypt = $("#example13-digit-number").val();

                $('#btnnxt').hide();
                $('#btnloadnxt').show();
                $('#btnloadnxt').attr('disabled', true);

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
                                    // this is used to know from api  which company name
                                    //alert(data.split('&')[1])

                                    if (data.split('&')[1] == "1 STOP NUTRITION" || data.split('&')[1] == "" || data.split('&')[1] == undefined) {
                                        $('#Chkcode').hide();
                                        $('#Chkfields').show();
                                        $('#Otherfield').hide();
                                        $('#mobilefield').show();

                                    }
                                    else {
                                         alert('Invalid Code');
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



            $("#mobile").mask("9999999999");

            $('#mobile').keyup(function () {
                Mobile_check();
            })

            // Validation for the pincode 
            $("#Pincode").mask("999999");
            $('#Pincode').keyup(function () {
                Pin_check();

            });

            // validation for the namecheck
            $('#name').keyup(function () {
                Name_check();

            });

            function Name_check() {
                var Name_val = $('#name').val();

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



            // validation for the city 
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
                    $('#citycheck').html("**Please enter valid city name");
                    $('#citycheck').css("color", "red");
                    city_err = false;
                    return false;
                }
            }

            // validation for states
            $('#state').keyup(function () {
                State_check();

            });

            function State_check() {
                debugger;
                var state_val = $('#state').val();
                if ((state_val.length == '') || (state_val.length < 2) || (state_val.length > 30)) {
                    $('#statecheck').show();
                    $('#statecheck').html("**Please Enter the state name");
                    $('#statecheck').css("color", "red");
                    state_err = false;
                    return false;
                }
                if ($('#state').val().match('^[a-z A-Z]{3,30}$')) {
                    $('#statecheck').hide();
                }
                else {
                    //$('#statecheck').hide();
                    $('#statecheck').show();
                    $('#statecheck').html("**Please Enter valid State name");
                    $('#statecheck').css("color", "red");
                    state_err = false;
                    return false;
                }
            }

            $('#btnsubmit').on('click', function (e) {
                e.preventDefault();
                debugger;



                var mobileone = $('#mobile').val();

                if (mobileone == "" || mobileone == undefined) {
                    $('#mobilecheck').html('Please Enter Mobile Number');
                    $('#mobilecheck').css("color", "red");
                    return false;
                }
                else {
                    $('#mobilecheck').text('');
                }

                name_err = true;
                pin_err = true;
                city_err = true;
                state_err = true;


                Name_check();
                city_check();
                Pin_check();
                State_check();

                if ((name_err != true) || (pin_err != true) || (city_err != true) || (state_err != true)) {
                    return false;
                }




                $('#btnsubmit').hide();
                $('#btnloadsubmit').show();
                $('#btnloadsubmit').attr('disabled', true);

                var code = $('#example13-digit-number').val();
                //alert(code);
                if (code != "") {
                    //alert("dfef");
                    debugger;

                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: '../Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#example13-digit-number').val() + '&name=' + $('#name').val() + '&city=' + $('#city').val() + '&state=' + $('#state').val() + '&PinCode=' + $('#Pincode').val() + '&comp=1 STOP NUTRITION&Comp_ID=Comp-1155',
                        success: function (data) {
                            // to know about outcome

                            // alert(data.split('&')[1])
                            $('#btnsubmit').show();
                            $('#btnloadsubmit').hide();
                            if (data.split('~')[0] !== "failure") {
                                window.scrollTo(0, 0);
                                if (data.indexOf("not valid") !== -1) {
                                    data = data.split(".")[0];
                                }
                                /*$('#HEADING').hide();*/
                                $('#Chkfields').hide();
                                $('#mobilefield').hide();
                                $('#Otherfield').hide();
                                $('#Chkcode').hide();
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

                else {

                    $('#btnsubmit').attr('disabled', false);
                }



            });

            $('#btnNext').click(function () {
                window.location.href = 'https://www.1stopnutrition.in/';
            });

        });




    </script>

</head>
<body>

    <section class="background-desk">

        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="logo-img mt-3">
                        <a href="https://www.1stopnutrition.in/">
                            <img src="./assets/images/onestop/OSN-logo.png" class="animate__backInDown animate__animated img-fluid">
                        </a>
                    </div>
                </div>
            </div>

            <div class="row">

                <div class="col-sm-5">
                    <form class="OSN-form" runat="server">
                        <asp:HiddenField ID="hdnmob" runat="server" />
                        <asp:HiddenField ID="HdnID" runat="server" />
                        <asp:HiddenField ID="HdnCode1" runat="server" />
                        <asp:HiddenField ID="HdnCode2" runat="server" />
                        <asp:HiddenField ID="CompName" runat="server" />
                        <asp:HiddenField ID="long" runat="server" />
                        <asp:HiddenField ID="lat" runat="server" />


                        <div class="form-box  animate__animated animate__backInUp">

                            <div class="row">
                                <div class="col-12">
                                    <h5 class="text-uppercase">to check authenticity And Avail Benefits</h5>
                                </div>
                            </div>
                            <div class="width-box">
                                <!-- this is added for the 13-digit code  -->
                                <div id="Chkcode">
                                    <div class="col-sm-12">

                                        <input type="text" maxlength="13" class="form-control" id="example13-digit-number" placeholder="Enter 13 Digit Code*" />
                                        <h6 id="codecheck"></h6>
                                        <button type="submit" id="btnnxt" class="btn text-uppercase form-control OSN-button">Next</button>
                                        <button type="submit" style="display: none" id="btnloadnxt" class="btn text-uppercase form-control OSN-button"><i class="fa fa-spinner fa-spin"></i>Loading..</button>
                                        <h6 id="nextcheck"></h6>

                                    </div>
                                </div>
                                <!-- this div is done for the the showing mobile field and its side by side view -->
                                <div id="Chkfields">
                                    <div class="mobilefield" id="mobilefield">
                                        <div class="col-12">

                                            <!-- added for the label output -->
                                            <div class="col-12">

                                                <input type="text" class="form-control" id="mobile" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="Mobile No*" />
                                                <h6 id="mobilecheck"></h6>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- this div is used in the else condition when the cidw is not successed -->
                                    <div class="Otherfield" id="Otherfield" style="display: none">


                                        <div class="col-12">

                                            <input type="text" maxlength="50" data-msg-required="Please Enter Your Name" class="form-control" id="name"  placeholder="Name*" />
                                            <h6 id="namecheck"></h6>
                                        </div>


                                        <div class="col-12">

                                            <input type="text" class="form-control" id="Pincode" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder=" Pincode*" />
                                            <h6 id="pincheck"></h6>
                                        </div>
                                        <div class="col-12">

                                            <input type="text" class="form-control" id="city" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123)" maxlength="50" placeholder="City*" />
                                            <h6 id="citycheck"></h6>
                                        </div>
                                        <div class="col-12">

                                            <input type="text" class="form-control" id="state" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123)" maxlength="50" placeholder="State*" />
                                            <h6 id="statecheck"></h6>
                                        </div>
                                    </div>

                                    <button type="submit" id="btnsubmit" class="btn text-uppercase form-control OSN-button">Submit</button>
                                    <button type="submit" style="display: none" id="btnloadsubmit" class="btn text-uppercase form-control OSN-button"><i class="fa fa-spinner fa-spin"></i>Loading..</button>

                                </div>

                            </div>

                            <div style="display: none;" id="ShowMessage">

                                <div class="form-box">
                                    <p id="p3msg" style="overflow: hidden; color: white; font-size: 15px !important; font-weight: 500; margin-left: 7px; margin-right: 7px;" class="displayNone massage_box text-center"></p>
                                    <br />
                                    <center><a href="javascript:void(0)" class=" " id="btnNext">Close</a></center>
                                </div>

                            </div>

                            <div class="col-12 text-center">
                                <p id="wlink" class="blink_me animate__animated animate__flash">
                                    QR/Code  Related Support Available on
                                                <br>
                                    <i class="fa fa-phone" style="color: #0d6efd;" aria-hidden="true"></i><a href="tel:8047278314">8047278314</a> /
                                                <i class="fa fa-whatsapp" style="color: #13fb06;" aria-hidden="true"></i>
                                    <a href="https://api.whatsapp.com/send?phone=+917669017712&amp;text&amp;type=phone_number&amp;app_absent=1" target="blank">7669017721</a>
                                </p>
                            </div>

                        </div>
                    </form>
                </div>

                <div class="col-sm-7 text-center">
                    <img src="./assets/images/onestop/product.png" alt="OSN-product-img" class="img-fluid mt-5 OSN-product animate__animated animate__backInUp" />
                </div>
            </div>

        </div>

        <footer>
            <a href="https://www.1stopnutrition.in/" style="text-decoration: none;">www.1stopnutrition.in</a>
        </footer>

    </section>
</body>
</html>
