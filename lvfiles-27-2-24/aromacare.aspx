<%@ Page Language="C#" AutoEventWireup="true" CodeFile="aromacare.aspx.cs" Inherits="aromacare" %>

<!DOCTYPE html>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Aroma Care</title>
    <style>
        .aroma_care-section {
            background-image: url(../assets/images/aromaCare-img/aroma-bg.jpg);
            background-repeat: no-repeat;
            background-position: bottom;
            background-size: cover;
            width: 100%;
            position: relative;
            display: table;
            height: 100vh;
            padding-bottom: 10px;
        }

            .aroma_care-section img.aroma-logo {
                width: 24%;
            }

            .aroma_care-section header {
                padding: 5px 0;
            }

            /*It is updated  by the rama Sir*/
            .aroma_care-section .aroma-form {
                background-color: #31728ab8;
                border-radius: 4px;
                border: 2px solid #31728a73;
                margin-top:16% !important;
				
                 margin: auto;
                display: table;
               
            }

                .aroma_care-section .aroma-form .aroma-form-box {
                    display: flex;
                    flex-direction: column;
                    gap: 5px;
                    padding: 20px 32px;
                }

                .aroma_care-section .aroma-form h4 {
                    color: #fff;
                    text-align: center;
                }

                .aroma_care-section .aroma-form input::placeholder {
                    font-size: 12px;
                }

                .aroma_care-section .aroma-form button {
                    color: #fff;
                    background-color: #000;
                    width: 50%;
                    display: flex;
                    justify-content: center;
                    margin: 16px auto;
                    border: 0;
                    padding: 8px;
                    font-size: 16px;
                }

        .aroma-form-box input {
            margin-bottom: 5px;
        }

        .aroma_care-section .aroma-product {
            width: 80%;
        }


        .aroma_care-section .footer-section {
            background-color: #000;
            text-align: center;
            padding: 12px;
            position: fixed;
            width: 100%;
            bottom: 0;
        }

            .aroma_care-section .footer-section a {
                color: #fff;
                text-align: center;
                text-decoration: none;
            }

                .aroma_care-section .footer-section a:hover {
                    color: #2c6d81;
                }

        #wlink  {
            text-align: center;
            font-size: 16px;
            font-weight: 600;
            color:#fff
        }
        #support {
            text-align: center;
            font-size: 16px;
            font-weight: 600;
            color:#000;
        }

            #wlink a,#support a {
                text-decoration: none;
                color: #000;
            }


        @media screen and (max-width:767px) {
            .aroma_care-section .aroma-product {
                width: 100%;
                padding: 10% 0;
            }

            .aroma_care-section img.aroma-logo {
                width: 38%;
            }
             .aroma_care-section .aroma-form {
                margin-top: 6% !important;
            }
        }

        @media screen and (min-width:768px) and (max-width:1280px) {
            .aroma_care-section .aroma-product {
                width: 100%;
                padding: 10% 0;
            }
        }

        /* @media screen and (width: 1024px){
            .aroma_care-section .aroma-product {
                width: 145%;
                padding: 10%;
                position: absolute;
                right: 0px;
                bottom: -150%;
            }
        } */
    </style>

    <!--   link are added here for the jquery and the mask jquery cdn is also added
-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/0.9.0/jquery.mask.min.js"></script>

    <script type="text/javascript">
        // it is the variable initialized for the location purpose.
        var lat = "";
        var long = "";
        var baseurl = "https://www.vcqru.com/";
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
                    url: baseurl + 'Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNo&MobileNo= ' + $("#mobile").val(),
                    success: function (data) {

                        if (c <= 5) {
                            $('#mobilecheck').text('Please Enter correct Mobile Number');
                            $('#mobile').val('');
                            return false;
                        }
                        else {
                           // alert(data);
                            var Name = data.split('~')[0];
                            var pin = data.split('~')[6];
                            var city = data.split('~')[2];
                            var state = data.split('~')[3];
                            var shopname = data.split('~')[4];
                            var Address = data.split('~')[9];
                            var ddlconsumertype = data.split('~')[5];
                            var UpiId = data.split('~')[10];

                            if(Name != "") {
                                $("#name").val(Name);
                               // alert(Name);

                            }
                            else{
                                $("#name").val(Name);
                                $('#Chkcode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();

                            }
                            if(pin != "") {
                                $("#Pincode").val(pin);
                               // document.getElementById('Pin').readOnly = true;

                            }
                            else {
                                $("#Pincode").val(pin);
                                $('#Chkcode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();

                            }

                            if(city != "") {
                                $("#city").val(city);
                            } else {
                                $("#city").val(city);
                                $('#Chkcode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();
                            }

                            if(state != "") {
                                $("#state").val(state);
                            }
                            else {
                                $("#state").val(state);
                                $('#Chkcode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();
                            }
                            

                            if(Name != "" && pin != "" && city != "" && state != ""){
                                $('#Chkcode').hide();
                                $('#mobilefield').show();
                                $('#Chkfields').show();
                                $('#Otherfield').hide();
                            }



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
            /*debugger;*/

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
                        $("#city").attr('readonly', true);
                        $("#state").val(state);
                        $("#state").attr('readonly', true);
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
                        $("#city").attr('readonly', false);
                        $("#state").attr('readonly', false);
                        pin_err = false;
                        return false;
                    }
                }
            }

            else {
                $("#city").val('');
                $("#state").val('');
                $("#city").attr('readonly', false);
                $("#state").attr('readonly', false);
                $('#pincheck').show();
                $('#pincheck').html("**Please Enter the 6-digits pin code");
                $('#pincheck').css("color", "red");
                pin_err = false;
                return false;
            }

        }

        $(document).ready(function () {

            debugger;

            /* debugger;*/
            $('#Chkcode').show();
            $('#Chkfields').hide();
            $('#mobilefield').hide();
            $('#Otherfield').hide();
    

            var id = $('#HdnID').val();


            if (id == "1") {

                $('#ChkCode').show();
                $('#Chkfields').hide();
            }

            else if (id == "Paras") {
                $('#Chkcode').hide();
                $('#otherfield').hide();
                $('#mobilefield').show();
                $('#Chkfields').show();
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
                /* debugger;*/

                var codeone = $('#example13-digit-number').val();

                if (codeone == "" || codeone == undefined) {
                    $('#nextcheck').html('**Please Enter 13 Digit Code');
                    $('#nextcheck').css("color", "red");
                    return false;
                }
                else {
                    $('#nextcheck').text('');
                }

                if (codeone != undefined) {
                    if ($('#example13-digit-number').val().length < 14) {
                        $('#nextcheck').text('**Please Enter 13 Digit Code');
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

                $.ajax({
                    type: "POST",
                    url: baseurl + 'Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                    success: function (data) {
                        $.ajax({
                            type: "POST",
                            url: baseurl + 'Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1] + '&lat=' + lat + '&long=' + long,
                            success: function (data) {
                                $('#btnnxt').show();
                                $('#btnloadnxt').hide();
                               // alert(data.split('&')[1]);
                                if (data.split('&')[0] === "1" && data.split('&')[1] === "Paras cosmetics private limited") {

                            

                                }
                                else {
                                    // this is used to know from api  which company name
                                    //alert(data.split('&')[1])
                                  
                                    if (data.split('&')[1] == "Paras cosmetics private limited" || data.split('&')[1] == "" || data.split('&')[1] == undefined) {
                                        $('#Chkcode').hide();
                                        $('#Chkfields').show();
                                        $('#Otherfield').hide();
                                        $('#mobilefield').show();
                                       
                                    }
                                    else {
                                       
                                        $('#nextcheck').text('**Invalid Code');
                                        $('#nextcheck').css("color", "red");
                                        $('#nextcheck').show();
                                        // alert('Invalid Code');
                                       // $('#Chkcode').show();
                                       // $('#Chkfields').hide();
                                        //$('#mobilefield').hide();
                                        //$('#Otherfield').hide();
                                        return false;
                                    }
                                }
                            }
                        });
                    }
                });

            });

            // end of the code check process 
            // validation for the mobile function

            $("#mobile").mask("9999999999");

            $('#mobile').keyup(function () {
                Mobile_check();
            });

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
                /* debugger;*/
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


                if (mobileone.length < 10 || mobileone == undefined) {
                    // this line work for the submitting button 
                    // $('#btnsubmit').prop('disabled', true);
                    $('#mobilecheck').html('**Please Enter 10-digit Mobile Number');
                    $('#mobilecheck').css("color", "red");
                    return false;
                }
                else {
                    $('#mobilecheck').text('');
                    // $('#btnsubmit').prop('disabled', false);
                }

                name_err = true;
                pin_err = true;
                city_err = true;
                state_err = true;


                Name_check();
                Pin_check();
                city_check();

                State_check();

                if ((name_err != true) || (pin_err != true) || (city_err != true) || (state_err != true)) {
                    return false;
                }




                $('#btnsubmit').hide();
                $('#btnloadsubmit').show();


                var code = $('#example13-digit-number').val();
                //alert(code);
                if (code != "") {
                    //alert("dfef");
                    /* debugger;*/

                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: baseurl + 'Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#example13-digit-number').val() + '&name=' + $('#name').val() + '&city=' + $('#city').val() + '&state=' + $('#state').val() + '&PinCode=' + $('#Pincode').val() + '&comp=Paras cosmetics private limited&Comp_ID=Comp-1632',
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
                                $('#auth').hide();

                                $('#ShowMessage').show();
                                $('#wlink').show();
                                // $('#chkLine').hide();
                                if ((data.split('~')[1]).includes("Congratulations")) {
                                    var successMasg = data.split('~')[1] + "<br> To Check Another Code <a href='https://vcqru.com/aromacare.aspx' style='color:blue;'>Click Here</a>";
                                    $('#wlink').html(successMasg);
                                } else {
                                    $('#wlink').html(data.split('~')[1]);
                                }

                                $('#wlink:contains("not")').css('color', 'white');
                            }
                            else {
                                $('#wlink').hide();
                                $('#auth').hide();

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
                window.location.href = 'https://www.aromacares.com/';
            });

        });

    </script>
</head>
<body>
    <section class="aroma_care-section">
        <div class="container">
            <header>
                <a href="https://www.aromacares.com/" target="_blank">
                    <img src="assets/images/aromaCare-img/aroma_logo.png" alt="aroma-logo" class="aroma-logo" /></a>
            </header>
            <div class="aroma-body">
                <div class="row">
                    <div class="col-lg-5">
                        <div class="aroma-form">
                            <form class="aroma-form-box" runat="server">
                                <asp:HiddenField ID="HdnID" runat="server" />
                                <asp:HiddenField ID="hdnmob" runat="server" />
                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                <asp:HiddenField ID="HdnCode1" runat="server" />
                                <asp:HiddenField ID="HdnCode2" runat="server" />
                                <asp:HiddenField ID="CompName" runat="server" />
                                <asp:HiddenField ID="long" runat="server" />
                                <asp:HiddenField ID="lat" runat="server" />
                                <h4 id="auth">TO CHECK AUTHENTICITY</h4>
                                <div id="Chkcode">
                                    <%-- 13 digit code--%>
                                    <div class="row">
                                        <div class="col-12">
                                            <input type="text" maxlength="13" id="example13-digit-number" placeholder="13 Digit Number*" class="form-control" />
                                            <h6 id="codecheck"></h6>
                                              <h6 id="nextcheck"></h6>
                                            <button type="submit" id="btnnxt" class="form-control">Next</button>
                                            <button type="submit" style="display: none" id="btnloadnxt" class="form-control"><i class="fa fa-spinner fa-spin"></i>Loading..</button>
                                          
                                        </div>

                                    </div>
                                </div>
                                <div id="Chkfields">
                                    <div class="mobilefield" id="mobilefield">
                                        <div class="row">
                                            <%--   mobile field--%>

                                            <div class="col-12">
                                                <input type="text" id="mobile" placeholder="Mobile No.*" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false" class="form-control" />
                                                <h6 id="mobilecheck"></h6>
                                            </div>

                                        </div>

                                    </div>

                                    <!-- this div is used in the else condition when the cidw is not successed -->
                                    <div class="Otherfield" id="Otherfield" style="display: none">
                                        <div class="row">

                                            <div class="col-12">
                                                <input type="text" placeholder="Name*" id="name" class="form-control" />
                                                <h6 id="namecheck"></h6>
                                            </div>

                                        </div>
                                        <%-- <br />--%>
                                        <div class="row">
                                            <div class="col-12">
                                                <input type="text" id="Pincode" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="Pincode*" class="form-control" />
                                                <h6 id="pincheck"></h6>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-12">
                                                <input type="text" id="city" maxlength="50" placeholder="City*" class="form-control" />
                                                <h6 id="citycheck"></h6>
                                            </div>

                                        </div>

                                        <div class="row">
                                            <div class="col-12">
                                                <input type="text" id="state" maxlength="50" placeholder="State*" class="form-control" />
                                                <h6 id="statecheck"></h6>
                                            </div>

                                        </div>


                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <button type="submit" id="btnsubmit" class="btn btn-primary">Submit</button>
                                            <button type="submit" style="display: none" id="btnloadsubmit" class="btn btn-primary"><i class="fa fa-spinner fa-spin"></i>Loading..</button>
                                        </div>
                                    </div>
                                </div>
                                <%--end of the other field--%>
                                <%--<div class="row">
                                    <div class="col-12">
                                        <button class="form-control">Submit</button>
                                    </div>
                                </div>--%>
                                <div id="ShowMessage">
                                    <div class="row">
                                        <div class="col-12">
                                            <p id="wlink" class="blink_me animate__animated animate__flash">
                                                
                                            <%--<br>
                                                <i class="fa fa-phone" aria-hidden="true"></i><a href="tel:7353000903">7353000903 </a>/ 
                                            <i class="fa fa-whatsapp" aria-hidden="true"></i>
                                                <a href="https://api.whatsapp.com/send?phone=+919355903119&amp;text&amp;type=phone_number&amp;app_absent=1" target="blank">9355903119 </a>
                                            </p>--%>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                       <div class="row">
                                        <div class="col-12">
                                            <p id="support" class="blink_me animate__animated animate__flash">
                                                QR/Code  Related Support Available on
                                            <br>
                                                <i class="fa fa-phone" aria-hidden="true"></i><a href="tel:7353000903">7353000903 </a>/ 
                                            <i class="fa fa-whatsapp" aria-hidden="true"></i>
                                                <a href="https://api.whatsapp.com/send?phone=+919355903119&amp;text&amp;type=phone_number&amp;app_absent=1" target="blank">9355903119 </a>
                                            </p>
                                        </div>
                                    </div>
                            </div>
                    <div class="col-lg-7 text-center">
                        <img src="assets/images/aromaCare-img/aroma-product.png" alt="aroma-product" class="aroma-product " />
                    </div>
                </div>
            </div>
        </div>
        <footer class="footer-section">
            <a href="https://www.aromacares.com/" class="text-center" target="_blank">www.aromacares.com</a>
        </footer>
    </section>

</body>
</html>
