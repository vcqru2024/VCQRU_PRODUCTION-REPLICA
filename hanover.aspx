<%@ Page Language="C#" AutoEventWireup="true" CodeFile="hanover.aspx.cs" Inherits="hanover" %>

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hannover</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href=" https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/0.9.0/jquery.mask.min.js"></script>

    <style>

        body {
            background: url(./assets/images/hanover/Layer1.png);
            background-size: cover;
            background-color: #fff;
            background-repeat: no-repeat;
            min-height: 100vh;
            background-position:center;
        }



        .logo img {
            width: 10rem;
            margin-top: 1rem;
        }

        .formplace .card {
            background-color: #545454;
            color: white;
            margin-bottom: 4rem;
            margin-top: 3rem;
            text-align:center;
        }

            .formplace .card h4 {
                margin-left: 1rem;
                margin-bottom: 1.5rem;
            }

            .formplace .card button {
                border: 2px solid white;
                font-weight: bold;
            }

            .formplace .card input {
                border: 2px solid rgb(70, 167, 199);
            }
             .product-img{
                    position:absolute;
                    bottom:0;
                    margin-bottom:2rem;
                }
                .product-img img{
                    height:20rem;
                }
        .product-img img {
            width: 100%;
            filter: drop-shadow(0px 5px 19px rgba(0, 0, 2, 7.9));
        }

        .landing .row {
            align-items: end;
        }
        .form-buttom {
    background-color: #ED1B24;
    border: 0px solid #fff;
    padding: 9px 60px;
    color: #fff;
}

        @media screen and (max-width: 768px) {
           
            .formplace .card {
                margin-bottom: 1rem;
            }
            .product-img{
                position:relative;
            }
            .product-img img{
                height:auto;
            }
        }

        @media screen and (min-width: 2560px) {
            .footer {
                background-color: black;
                /* display: flex;
                align-items: center;
                justify-content: center; */
                position: fixed;
                width: 100%;
                bottom: 0;
            }
        }

        .footer {
            background-color: black;
            position: fixed;
            width: 100%;
            bottom: 0;
        }

            .footer .links {
                display: flex;
                align-items: end;
                justify-content: center;
            }

                .footer .links a {
                    color: white;
                    text-decoration: none;
                }
               
    </style>
    <script type="text/javascript">
        // it is the variable initialized for the location purpose.


        var Codeone = "";
        var Codetwo = "";
        var comp = "";
        var Id = "";

        var lat = "";
        var long = "";
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

        // form this function we may easily collect the data to the our database by using the post api


        function Getdata() {
            debugger;
            var mobileno = document.querySelector("#mobile").value;
            var d = mobileno.slice(0, 1);
            var c = parseInt(d);

            if (mobileno.match(/[^$,.\d]/)) {
                toastr.error("Please enter numeric value for mobile No.");
                $('#mobile').val() == "";
                $('#btnsubmit').attr('disabled', false);
                return false;
            }

            else {

                if (mobileno.length == 10) {
                    var codeone = getUrlVars()["codeone"];
                    var codetwo = getUrlVars()["codetwo"];

                    if (codeone == undefined && codetwo == undefined) {
                        var completeCode = $("#example13-digit-number").val();
                        var arr = completeCode.split('-');
                        codeone = arr[0];
                        codetwo = arr[1];
                    }


                    $.ajax({
                        type: "Post",
                        url: '../Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNo&MobileNo=' + $("#mobile").val(),
                        success: function (data) {
                            // alert(data);
                            debugger;
                            if (c <= 5) {
                                toastr.error('Please Enter Valid Mobile No');
                                $('#mobile').val('');
                                return false;
                            }
                            else {

                                var count = data.split('~');
                                var Name = data.split('~')[0];
                                var pin = data.split('~')[6];
                                var city = data.split('~')[2];
                                var state = data.split('~')[3];
                                var UPI = data.split('~')[10];
                                var pancard_number = data.split('~')[16];

                                if (Name != "") {
                                    $("#name").val(Name);
                                    $("#name").attr("readonly", true);
                                }
                                /*Auto Cash Transfer Start */
                                else {
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#mobilefield').hide();
                                    $("#name").attr("readonly", false);


                                }
                                if (pin != "") {
                                    $("#Pincode").val(pin);
                                    $("#Pincode").attr("readonly", true);
                                }
                                else {
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#mobilefield').hide();
                                    $("#Pincode").attr("readonly", false);
                                    $("#city").attr('readonly', false);
                                    $("#State").attr('readonly', false);

                                }


                                if (city != "") {
                                    $("#city").val(city);
                                    $("#city").attr("readonly", true);
                                }
                                else {
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#mobilefield').hide();
                                    $("#city").attr("readonly", false);


                                }
                                if (state != "") {
                                    $("#State").val(state);
                                    $("#State").attr("readonly", true);
                                }
                                else {
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#mobilefield').hide();
                                    $("#State").attr("readonly", false);


                                }
                                if (UPI != "") {
                                    $("#UPI").val(UPI);
                                    $("#UPI").attr("readonly", true);
                                }
                                else {
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#mobilefield').hide();
                                    $("#UPI").attr("readonly", false);
                                }


                                if (pancard_number != "") {
                                    $("#pancard_number").val(pancard_number);
                                    $("#pancard_number").attr("readonly", true);
                                }
                                else {
                                    $('#Chkfields').show();
                                    $('#Otherfield').show();
                                    $('#mobilefield').hide();
                                    $("#pancard_number").attr("readonly", false);
                                }


                            }
                        }
                    });
                }
            }


        }

        function getaddress() {
            debugger;
            let pin = document.getElementById("Pincode").value;
            if (pin.length == 6) {
                $.getJSON("https://api.postalpincode.in/pincode/" + pin, function (data) {
                    createHTML(data);
                })
                function createHTML(data) {
                    if (data[0].Status == "Success") {
                        var city = "";
                        var State = "";
                        var pin = "";
                        debugger;

                        var city = data[0].PostOffice[0]['District'];
                        var State = data[0].PostOffice[0]['State'];
                        var Pin = data[0].PostOffice[0]['PinCode'];
                        $("#city").val(city);
                        $("#city").attr("readonly", true);
                        $("#State").val(State);
                        $("#State").attr("readonly", true);

                        if (pin == "") {
                            $("#Pincode").val();
                            $('#pincheck').html("");

                        }
                        else {
                            $("#Pincode").val(Pin);

                        }
                        $('#btnsubmit').attr('disabled', false);
                    }

                }
            }
            else {
                $('#city').val('');
                $("#State").val('');
            }

        }
        function valUpiID() {
            var UpiID = $('#UPI').val();
            if (UpiID.charAt(0) === ' ') {
                $('#upicheck').html("**Please Enter Valid UPI ID");
                $('#upicheck').css("color", "red");
                return false;
            }
            if (UpiID == "") {
                $('#upicheck').html("**Please Enter Valid UPI ID");
                $('#upicheck').css("color", "red");
                return false;
            }
            var filter = /^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$/;
            if (!filter.test(UpiID)) {
                $('#upicheck').html("**Please Enter Valid UPI ID");
                $('#upicheck').css("color", "red");
                return false;
            }
            else {
                $('#upicheck').hide();
                $('#upicheck').html("");
                $('#upicheck').css("color", "purple");
            }
        }

        function valPancard() {
            var Pan = $('#pancard_number').val();
            if (Pan.charAt(0) === ' ') {
                $('#pancheck').html("**Please Enter Valid Pan ID");
                $('#pancheck').css("color", "red");
                return false;
            }
            if (Pan == "") {
                $('#pancheck').html("**Please Enter Valid Pan ID");
                $('#pancheck').css("color", "red");
                return false;
            }
            var filter = /^[A-Z]{5}[0-9]{4}[A-Z]$/;
            if (!filter.test(Pan)) {
                $('#pancheck').html("**Please Enter Valid Pan ID");
                $('#pancheck').css("color", "red");
                return false;
            }
            else {
                $('#pancheck').hide();
                $('#pancheck').html("");
                $('#pancheck').css("color", "purple");
            }
        }

        // for the 13 digit code check
        $(document).ready(function () {

            $('#Chkcode').show();
            $('#Chkfields').hide();
            $('#mobilefield').hide();
            $('#Otherfield').hide();


            var code_err = true;
            var mobile_err = true;
            var name_err = true;
            var pin_err = true;
            var city_err = true;
            var village_err = true;



            function getUrlVars() {
                debugger;
                var vars = [], hash;
                var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                for (var i = 0; i < hashes.length; i++) {
                    hash = hashes[i].split('=');
                    vars.push(hash[0]);
                    vars[hash[0]] = hash[1];
                }
                return vars;
            };
            Codeone = getUrlVars()["codeone"];
            Codetwo = getUrlVars()["codetwo"];
            comp = getUrlVars()["Comp"];
            Id = getUrlVars()["ID"];

            if (comp === undefined || comp === "undefined") {
                comp = comp;
            }
            else {
                comp = comp.replace("%20", " ");
                comp = comp.replace("%20", " ");
                comp = comp.replace("%20", " ");
                comp = comp.replace("%20", " ");
            }
            if (Codeone === undefined || Codeone === undefined) {
                Codeone = Codeone;
            }
            else {
                var HdnCode1 = Codeone;
                var HdnCode2 = Codetwo;
                // $("#codeone").val(code);
            }

            var id = comp;

            if (id == "1") {

                $('#ChkCode').show();
                $('#Chkfields').hide();
                $('#mobilefield').hide();
                $('#Otherfield').hide();
            }

            else if (id == "HANNOVER CHEMIKALIEN PRIVATE LIMITED") {
                $('#Chkcode').hide();
                $('#Chkfields').show();
                $('#mobilefield').show();
                $('#Otherfield').hide();
                var code = Codeone + '-' + Codetwo
                // var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $("#example13-digit-number").val(code);
            }





            // check for the 13-digit number when the user is enter to check the code is correct or else

            $('#example13-digit-number').mask("99999-99999999");

            $("#btnnxt").on('click', function (e) {
                e.preventDefault();
                debugger;

                var codeone = $('#example13-digit-number').val();

                if (codeone == "" || codeone == undefined) {
                    $('#codecheck').html('**Please Enter 13- Digit-Code');
                    $('#codecheck').css("color", "red");
                    return false;
                }
                else {
                    $('#nextcheck').text('');
                }

                if (codeone != undefined) {
                    if ($('#example13-digit-number').val().length < 14) {
                        $('#codecheck').text('**Please Enter 13-Digit-Code');
                        $('#codecheck').css("color", "red");
                        return false;
                    }
                    else {
                        $('#codecheck').text('');
                        $('#codecheck').hide();
                    }
                }

                var rquestpage_Dcrypt = $("#example13-digit-number").val();

                $('#btnnxt').hide();
                $('#btnloadnxt').show();
                debugger;
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


                                    if (data.split('&')[1] == "HANNOVER CHEMIKALIEN PRIVATE LIMITED" || data.split('&')[1] == "" || data.split('&')[1] == undefined) {
                                        $('#Chkcode').hide();
                                        $('#Chkfields').show();
                                        $('#mobilefield').show();
                                        $('#Otherfield').hide();


                                    }
                                    else {
                                        // alert('Invalid Code');
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



            $('#example13-digit-number').keyup(function () {
                $('#codecheck').hide();
                $('#codecheck').html("");
                $('#codecheck').css("color", "white");

            });
            $('#name').keyup(function () {
                $('#namecheck').hide();
                $('#namecheck').html("");
                $('#namecheck').css("color", "white");

            });
            $('#Pincode').keyup(function () {
                $('#pincheck').hide();
                $('#pincheck').html("");
                $('#pincheck').css("color", "white");

            });
            $('#city').keyup(function () {
                $('#citycheck').hide();
                $('#citycheck').html("");
                $('#citycheck').css("color", "white");

            });
            $('#State').keyup(function () {
                $('#statecheck').hide();
                $('#statecheck').html("");
                $('#statecheck').css("color", "white");

            });
            $('#UPI').keyup(function () {
                $('#upicheck').hide();
                $('#upicheck').html("");
                $('#upicheck').css("color", "white");

            });
            $('#pancard_number').keyup(function () {
                $('#pancheck').hide();
                $('#pancheck').html("");
                $('#pancheck').css("color", "white");

            });

            function Name_check() {
                var Name_val = $('#name').val();

                if (Name_val.charAt(0) === ' ') {
                    $('#namecheck').html("**Please Enter Valid Name");
                    $('#namecheck').css("color", "red");
                    /* toastr.error('Please Enter a Valid UPI ID');*/
                    return false;
                }
                if ((Name_val.length == '')) {
                    $('#namecheck').show();
                    $('#namecheck').html("**Please Enter Name");
                    $('#namecheck').css("color", "red");
                    name_err = false;
                    return false;
                }

                if ($('#name').val().match('^[a-z A-Z]{3,40}$')) {
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
            function pinval() {
                var pin = $('#Pincode').val();
                if (pin != undefined) {

                    if ($('#Pincode').val().length < 1) {
                        $('#pincheck').html("**Please Enter  Pincode");
                        $('#pincheck').css("color", "red");
                        $('#city').val() = '';
                        $('#State').val() = '';
                        validate = false;
                    }
                    if (pin.match(/[^$,.\d]/)) {
                        $('#pincheck').html("**Please Enter Valid Pincode");
                        $('#pincheck').css("color", "red");
                        validate = false;
                    }

                    var matches1 = $('#pin').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        $('#pincheck').html("**Please Enter Valid Pincode");
                        $('#pincheck').css("color", "red");
                        validate = false;
                    }
                }
            }
            // validation for the city
            $('#city').keyup(function () {
                city_check();

            });

            function city_check() {

                var city_val = $('#city').val();
                /*debugger;*/
                if (city_val.charAt(0) === ' ') {
                    $('#citycheck').html("**Please Enter  City");
                    $('#citycheck').css("color", "red");
                    /* toastr.error('Please Enter a Valid UPI ID');*/
                    return false;
                }
                if ($('#city').val().match('^[a-z A-Z]{3,40}$')) {
                    $('#citycheck').hide();
                }
                else if ($('#city').val() == '') {
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
            $('#State').keyup(function () {
                State_check();

            });

            function State_check() {
                /*debugger;*/
                var State_val = $('#State').val();
                if (State_val.charAt(0) === ' ') {
                    $('#statecheck').html("**Please Enter  State");
                    $('#statecheck').css("color", "red");
                    /* toastr.error('Please Enter a Valid UPI ID');*/
                    return false;
                }
                if ($('#State').val().match('^[a-z A-Z]{3,40}$')) {
                    $('#statecheck').hide();
                }
                else if ($('#State').val() == '') {
                    $('#statecheck').hide();

                }
                else {

                    $('#statecheck').show();
                    $('#statecheck').html("**Please Enter State name");
                    $('#statecheck').css("color", "red");
                    Vill_err = false;
                    return false;
                }
            }

            $('#Pincode').keyup(function () {
                $('#pincheck').hide();
                $('#pincheck').html("");
                $('#pincheck').css("color", "purple");

            });
            //$('#UPI').keyup(function () {
            //    Upi_check();

            //});

            // validation for the upi
            $('#UPI').keyup(function () {
                valUpiID();

            });

            //function Upi_check() {

            //    var upi = $('#UPI').val();
            //    if ($('#UPI').val().match('^[0-9A-Za-z.-]{2,256}@[A-Za-z]{2,64}$')) {
            //        $('#upicheck').hide();
            //    }

            //    else {
            //        $('#upicheck').show();
            //        $('#upicheck').html("**Please enter valid UPI ID");
            //        $('#upicheck').css("color", "red");
            //        Upi_err = false;
            //        return false;
            //    }
            //}

            // validation for the pancard
            $('#pancard_number').keyup(function () {
                validatePan();

            });

            function validatePan(pan) {
                // Regular expression for PAN validation
                //var pattern = /^[A-Z]{5}[0-9]{4}[A-Z]$/;
                var pattern = /^[A-Z]{5}[0-9]{4}[A-Z]$/;
                return pattern.test(pan);
            }

            // Example usage:
            var panNumber = "ABCDE1234F";
            var isValidPan = validatePan(panNumber);

            if (isValidPan) {
                console.log("PAN is valid.");
            } else {
                console.log("Invalid PAN.");
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
                if (mobileone.length != 10) {
                    $('#mobilecheck').html('Please Enter Mobile Number');
                    $('#mobilecheck').css("color", "red");
                    return false;
                }
                else {
                    $('#mobilecheck').text('');
                }

                var Name = $('#name').val();
                if (Name == "" || Name == undefined || Name.charAt(0) === ' ') {
                    $('#namecheck').html('Please Enter Name');
                    $('#namecheck').css("color", "red");
                    return false;
                }
                else {
                    $('#namecheck').text('');

                }
                var pincode = $('#Pincode').val();
                if ($('#Pincode').val() == "" || pincode == undefined) {
                    $('#pincheck').html('Please Enter pincode');
                    $('#pincheck').css("color", "red");
                    pinval();
                    $('#city').val() == "";
                    $('#State').val() == "";
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#pincheck').text('');

                }

                var City = $('#city').val();
                if (City == "" || City == undefined || City.charAt(0) === ' ') {
                    $('#citycheck').html('Please Enter City');
                    $('#citycheck').css("color", "red");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#citycheck').text('');
                }
                var State = $('#State').val();
                if (State == "" || State == undefined || State.charAt(0) === ' ') {
                    $('#statecheck').html('Please Enter State');
                    $('#statecheck').css("color", "red");
                    $('#btnsubmit').attr('disabled', false);
                    return false;
                }
                else {
                    $('#statecheck').text('');
                }
                var pancard_number = document.getElementById('pancard_number').value;
                //if ($('#pancard_number').val() == "") {
                //    valPancard();
                //    $('#btnsubmit').attr('disabled', false);
                //    return false;



                //}
                // alert(UPI);
                if (pancard_number != "") {
                    var check = validatePancard(pancard_number);

                    if (check != true) {
                        $('#pancheck').html("**Please Enter Valid Pan ID");
                        $('#pancheck').css("color", "red");
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    else {
                        $('#pancheck').text('');
                    }
                }
                //var Pancard = $('#Pancard').val();
                //if (Pancard == "" || Pancard == undefined || Pancard.charAt(0) === ' ') {
                //    $('#pancheck').html('Please Enter Valid Pancard NO');
                //    $('#pancheck').css("color", "red");
                //    $('#btnsubmit').attr('disabled', false);
                //    return false;
                //}
                //else {
                //    $('#pancheck').text('');
                //}

                var UPI = document.getElementById('UPI').value;
                if ($('#UPI').val() == "") {
                    valUpiID();
                    $('#btnsubmit').attr('disabled', false);
                    return false;



                }
                // alert(UPI);
                if (UPI != "") {
                    var check = validateUPI(UPI);

                    if (check != true) {
                        $('#upicheck').html("**Please Enter Valid UPI ID");
                        $('#upicheck').css("color", "red");
                        $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    else {
                        $('#upicheck').text('');
                    }
                }




                $('#btnsubmit').hide();
                $('#btnloadsubmit').show();


                var code = $('#example13-digit-number').val();
                // alert(code);
                if (code != "") {
                    // alert("dfef");
                    debugger;

                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: '../Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#example13-digit-number').val() + '&name=' + $('#name').val() + '&city=' + $('#city').val() + '&state=' + $('#State').val() + '&PinCode=' + $('#Pincode').val() + '&UPI=' + $('#UPI').val() + '&pancard_number=' + $('#pancard_number').val() + '&comp=HANNOVER CHEMIKALIEN PRIVATE LIMITED&Comp_ID=Comp-1673',
                        success: function (data) {
                            // to know about outcome
                            // alert(data);
                            // alert(data.split('~')[1]);
                            $('#btnsubmit').show();
                            $('#btnloadsubmit').hide();
                            if (data.split('~')[0] !== "failure") {
                                window.scrollTo(0, 0);
                                if (data.indexOf("not valid") !== -1) {
                                    data = data.split(".")[0];
                                }

                                $('#Chkfields').hide();
                                $('#mobilefield').hide();
                                $('#Otherfield').hide();
                                $('#Chkcode').hide();
                                $('#ShowMessage').show();
                                // $('#chkLine').hide();
                                //if ((data) === "success~The code is invalid. Kindly call on 7353000903 for further assistance. </br>कोड अमान्य है. कृपया अधिक सहायता के लिए 7353000903 पर कॉल करें।")
                                //{

                                //    $('#p3msg').html('The code entered is invalid. Please check and try again');
                                //}

                                $('#p3msg').html(data.split('~')[1]);
                                $('#p3msg:contains("not")').css('color', 'white');
                            }
                            else if (data.split('~')[0] === "failure") {
                                alert(data.split('~')[1])
                            }
                            else {
                                /*$('#msgcoats').hide();*/
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
                window.location.href = ' http://www.hannoverchemikalien.com/';
            });

        });
        function validateUPI(UPI) {
            var re = /^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$/;
            return re.test(UPI);
        }

        function UPICheck() {
            // debugger;

            //var Email = $('#mail').val();
            var UPI = document.getElementById('UPI').value;

            if (UPI != "") {
                var check = validateUPI(UPI);

                if (check != true) {
                    /* toastr.error('Please Enter a Valid UPI ID');*/
                    $('#upicheck').html("**Please Enter Valid UPI ID");
                    $('#upicheck').css("color", "red");
                    return false;
                }
                else if (check == true) {
                    $('#UPI').html("");
                    $('#UPI').hide();
                }
            }


        }
        function validatePancard(pancard_number) {
            var re = /^[A-Z]{5}[0-9]{4}[A-Z]$/;
            return re.test(pancard_number);
        }

        function PancardCheck() {
            // debugger;

            //var Email = $('#mail').val();
            var pancard_number = document.getElementById('pancard_number').value;

            if (pancard_number != "") {
                var check = validatePancard(pancard_number);

                if (check != true) {
                    /* toastr.error('Please Enter a Valid UPI ID');*/
                    $('#pancheck').html("**Please Enter Valid Pan ID");
                    $('#pancheck').css("color", "red");
                    return false;
                }
                else if (check == true) {
                    $('#pancard_number').html("");
                    $('#pancard_number').hide();
                }
            }


        }

    </script>
</head>


<body>
    <form method="post" runat="server" action="./codeverify.aspx?ID=5" id="form1">
        <div>
            <input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKMTg0OTQ1MjgyNWRksJsH6oszOY6aBQb8ZYXqeZMoulsk8vinBkoOFmG/5+0=" />
        </div>
        <div>
            <input type="hidden" name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="1C52CC2C" />
            <input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION" value="/wEdAAd6JZhTpi8GFWyIsYyG2DIQTHJap1XPAwS4DQSuvGS50UWwP5KwieItj32l9mnkzqloDPdc3hZCgD7GXGAULra3/e/TMgqN0FcyW0KuwQmpO/68Exa89vh/IRkoWN0RiIwY7K8ZMmE2lBY9fYpYdQz1P9IDSJSefdmxvBXJdr6y/iaq/z6L9cln71gR+ZJ5CX0=" />
        </div>
        <asp:HiddenField ID="hdnmob" runat="server" />
        <asp:HiddenField ID="HdnID" runat="server" />
        <asp:HiddenField ID="HdnCode1" runat="server" />
        <asp:HiddenField ID="HdnCode2" runat="server" />
        <asp:HiddenField ID="CompName" runat="server" />
        <asp:HiddenField ID="long" runat="server" />
        <asp:HiddenField ID="lat" runat="server" />
    <div class="landing">
        <div class="container">
            <div class="row g-4 ">
                <div class="col-xxl-4 col-xl-4 col-lg-4 col-md-12">
                    <div class="logo">
                        <img src="assets/images/hanover/loho.png" alt="">
                    </div>
                    <div class="formplace">
                        <div class="card">
                            <div class="card-body">
                                <h4>To Avail Benifits/लाभ उठाने के लिए</h4>
                                <div>
                                    <div class="mb-3" >
                                        <div id="Chkcode">
                                            <input type="text" placeholder="13 अंकीय कोड दर्ज करें/Enter 13 digit code*" id="example13-digit-number" class="form-control" />
                                            <h6 id="codecheck" class="invalid-feedback d-block"></h6>
                                            <button type="button" id="btnnxt" data-toggle="modal" class="form-buttom">Next</button>
                                            <button type="button" id="btnloadnxt" style="display: none" data-toggle="modal" class="form-control login-btn"><i class="fa fa-spinner fa-spin"></i>Loading..</button>
                                            <h6 id="nextcheck"></h6>
                                        </div>
                                    </div>
                                    <div id="Chkfields">
                                        <div id="mobilefield">
                                            <div class="mb-3">
                                                
                                                 <input type="text" placeholder="मोबाइल नंबर/Mobile No*" maxlength="10" id="mobile" onkeyup="Getdata()" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" class="form-control" /> 
                                                <h6 id="mobilecheck" class="invalid-feedback d-block"></h6>
                                            </div>
                                        </div>
                                        <div id="Otherfield">
                                            <div class="mb-3">
                                                <input type="text" placeholder="नाम/Name*" maxlength="40" id="name" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || (event.charCode == 32)" class="form-control" />
                                                <h6 id="namecheck" class="invalid-feedback d-block"></h6>
                                            </div>

                                            <div class="mb-3">
                                                <input type="text" placeholder="पिन कोड/Pin Code*" minlegth="6" maxlength="6" id="Pincode" onkeyup="getaddress()" class="form-control" />
                                                <h6 id="pincheck" class="invalid-feedback d-block"></h6>
                                            </div>
                                            <div class="mb-3">
                                                <input type="text" placeholder="शहर/City*" maxlength="40" id="city" class="form-control" />
                                                <h6 id="citycheck" class="invalid-feedback d-block"></h6>
                                            </div>
                                            <div class="mb-3">
                                                <input type="text" placeholder="राज्य/State*" maxlength="40" id="State" class="form-control" />
                                                <h6 id="statecheck" class="invalid-feedback d-block"></h6>
                                            </div>

                                            <div class="mb-3">
                                                <input type="text" class="form-control" maxlength="10" id="pancard_number"
                                                    placeholder="PAN Card/पैन कार्ड*" required>
                                                <h6 id="pancheck" class="invalid-feedback d-block"></h6>
                                            </div>
                                            <div class="mb-3">
                                                <input type="text" maxlength="30" class="form-control" id="UPI"
                                                    placeholder="UPI ID/यूपीआई आईडी*" required>
                                                <h6 id="upicheck" class="invalid-feedback d-block"></h6>

                                            </div>
                                        </div>

                                        <div class="col-lg-12 p-1">
                                            <button type="button" id="btnsubmit" class="form-buttom btn">submit</button>
                                            <button type="button" id="btnloadsubmit" style="display: none" data-toggle="modal" class="form-control login-btn"><i class="fa fa-spinner fa-spin"></i>Loading..</button>
                                        </div>
                                        </div>
                                           <div style="display: none;" id="ShowMessage">

                                    <div class="">
                                        <p id="p3msg" style="overflow: hidden;  font-size: 15px !important; font-weight: 500; margin: 7px; margin-right: 7px;" class="displayNone text-center"></p>
                                        <center><a href="javascript:void(0)" style="color:black; font-size:medium" class=" " id="btnNext">Close</a></center>
                                    </div>

                                </div>
                                        
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xxl-8 col-xl-8 col-lg-8 col-md-12">
                    <div class="product-img">
                        <img src="assets/images/hanover/product.png" alt="">
                    </div>
                </div>

            </div>
        </div>
    </div>
    <div class="footer">
        <div class="row">
            <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12">
                <div class="links">
                    <a href="https://hannoverchemikalien.com/ " target="_blank"><span><i
                        class="fa-brands fa-internet-explorer"></i></span>www.hannoverchemikalien.com</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
        </form>
</body>

</html>
