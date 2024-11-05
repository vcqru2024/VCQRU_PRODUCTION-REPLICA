<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Canadaherbals.aspx.cs" Inherits="Canadaherbals" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <%--<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

    <!--   link are added here for the jquery and the mask jquery cdn is also added
    -->
    <%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/0.9.0/jquery.mask.min.js"></script>--%>


    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="Content/js/jquery-1.11.1.min.js"></script>
    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>

    <title>Canada Herbals</title>
    <style>
        .CanadaHerbals {
            position: relative;
            /* background-size: cover;
            background-repeat: no-repeat;
            background-position:100%; */
            width: 100%;
            display: table;
            height: 100vh;
            /* background-image: url(./images/desktop-bg.jpg); */
            background-color: #cc2138;
            padding-bottom: 2%;
        }

            .CanadaHerbals .canada_logo {
                padding: 50px 0px;
                max-width: 35%;
            }

        .form-box {
            /* max-width: 80%; */
            margin: auto;
        }

            .form-box form {
                background-color: #fff;
                box-shadow: 0px 0px 16px 0px #000;
                margin-top: 12%;
                display: table;
            }

        .CanadaHerbals .form-title {
            background-color: #cc2138;
            color: #fff;
            border-bottom-left-radius: 100%;
            border-bottom-right-radius: 100%;
            padding: 16px 33px 34px;
            text-align: center;
            font-size: 22px;
        }

        .form-field input {
            border-radius: 0px;
            background-color: #dce0ec;
            margin-bottom: 22px;
            padding: 10px;
            margin-top: 20px;
        }

            .form-field input::placeholder {
                color: #333;
            }

        .canada_btn {
            color: #fff;
            background-color: #cc2138;
            border-radius: 100px;
            padding: 16px 10px;
            /*margin-top: 45px;*/
            font-size: 18px;
            font-weight: 600;
        }

        .btnclass {
            text-align: right;
        }

        #wlink {
            color: #000;
            text-align: center;
            margin-top: 25px;
        }

            #wlink a {
                color: #000;
                text-decoration: none;
            }

        .CanadaHerbals .canada_product {
            max-width: 50%;
            position: absolute;
            right: 0;
            /* top: 0; */
            bottom: 0px;
        }

        .CanadaHerbals .bg1 {
            position: absolute;
            top: 0;
            right: 0;
            max-width: 9%;
        }

        .CanadaHerbals .bg2 {
            position: absolute;
            bottom: 0;
            left: 0;
            max-width: 7%;
        }

        .upiBank li img {
            height: 2rem;
        }

        .upiBank {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: space-around;
        }

            .upiBank li .canada_btn {
                padding: 6px 16px !important;
                border: none;
            }

        .form-field {
            padding: 10px 30px 30px;
        }
        /* #form_1st{
            display: none;
        }
        #form_2nd{
            display: none;
        } */
        @media screen and (max-width:767px) {
            .CanadaHerbals .canada_product {
                max-width: 100%;
                position: initial;
            }

            .CanadaHerbals .bg2 {
                max-width: 30%;
            }

            .CanadaHerbals .bg1 {
                max-width: 18%;
            }

            .CanadaHerbals .canada_logo {
                padding: 30px 0px;
                max-width: 64%;
            }

            .form-box form {
                margin-top: 4%;
            }
        }

        @media screen and (min-width:768px) and (max-width:920px) {
            .form-box {
                max-width: 50%;
                position: absolute;
            }

            .CanadaHerbals .canada_product {
                max-width: 54%;
                top: initial;
            }

            .CanadaHerbals .bg1 {
                max-width: 100%;
            }

            .CanadaHerbals .bg2 {
                max-width: 100%;
            }

            .CanadaHerbals .canada_logo {
                padding: 50px 0px 0px;
                max-width: 50%;
            }
        }

        @media screen and (width:1024px) {
            .CanadaHerbals .canada_product {
                max-width: 80%;
                position: absolute;
                right: 0;
                top: 18%;
                bottom: 0px;
            }

            .form-box form {
                margin-top: 1%;
                margin-bottom: 26px;
            }

            .CanadaHerbals .bg1 {
                max-width: 18%;
            }
        }

        @media screen and (width:1280px) {
            .CanadaHerbals .canada_product {
                top: initial;
            }

            .form-box form {
                margin-top: 1%;
                margin-bottom: 26px;
            }
        }

        @media screen and (width:915px) {
            .form-box {
                max-width: 100% !important;
                position: inherit !important;
            }
        }
    </style>

    <script type="text/javascript">


        var lat = "";
        var long = "";
        var code1 = "";
        var code2 = "";
        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }



        function Mobile_check() {
            debugger;
            var mobile_val = $('#mobile').val();
            var d = mobile_val.slice(0, 1);
            var c = parseInt(d);

            if ((mobile_val.length == '') || (mobile_val.length != 10)) {
                $('#mobilecheck').show();
                $('#mobilecheck').html("**Please Enter Correct mobile number");
                $('#mobilecheck').css("color", "red");
                mobile_err = false;
                return false;
            }


            if (mobile_val.length == 10) {


                $('#mobilecheck').hide();
                $.ajax({
                    type: "Post",
                    url: '../Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNoandcomp&MobileNo= ' + $("#mobile").val() + '&compid=Comp-1593',
                    success: function (data) {
                        //alert(data);
                        if (c <= 5) {
                            $('#mobilecheck').text('Please Enter Correct Mobile Number');
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
                            var BankName = data.split('~')[7];
                            var AccountNumber = data.split('~')[8];
                            var IfscCode = data.split('~')[9];
                            var AccountHolderName = data.split('~')[12];
                            var UpiId = data.split('~')[10];

                            $("#AccountNumber").val(AccountNumber);
                            $("#ConfirmAccountNumber").val(AccountNumber);
                            $("#IfscCode").val(IfscCode);
                            $("#AccountHolderName").val(AccountHolderName);

                            $("#upi").val(UpiId);


                            if ($("#AccountHolderName").val() != "" && $("#IfscCode").val() != "" && $("#AccountHolderName").val() != "") {
                                $("#AccountNumber").attr('readonly', true);
                                $("#ConfirmAccountNumber").attr('readonly', true);
                                $("#IfscCode").attr('readonly', true);
                                $("#AccountHolderName").attr('readonly', true);
                            }
                            if ($("#upi").val() != "") {
                                $("#upi").attr('readonly', true);
                            }


                            if (Name != "") {
                                $("#name").val(Name);


                            }
                            else {

                                $('#Chkcode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();

                            }


                            if (city != "") {
                                $("#city").val(city);
                            }
                            else {
                                $('#Chkcode').hide();
                                $('#mobilefield').hide();
                                $('#Chkfields').show();
                                $('#Otherfield').show();
                            }

                            //if (UpiId != "") {




                            //    $('#payment').hide();
                            //    $('#divupi').hide();
                            //    $('#divbank').hide();
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
                $("#city").val('');


            }
        }


        function ValidateAccount() {
            var AccountNumber = $('#AccountNumber').val();
            if (AccountNumber != undefined) {

                if ($('#AccountNumber').val().length < 1) {
                    $('#lblaccount').text('Please Enter valid account number');
                    return false;
                }

            }

            var ConfirmAccountNumber = $('#ConfirmAccountNumber').val();
            if (ConfirmAccountNumber != undefined) {

                if ($('#ConfirmAccountNumber').val().length < 1) {
                    $('#lblaccount').text('Please Enter valid confirm account number');
                    return false;
                }

            }
        }

        function ACNamevalid() {
            var name = $('#AccountHolderName').val();
            if (name != undefined) {

                if ($('#AccountHolderName').val().length < 1) {
                    $('#lblaccount').text('Please Enter valid account holder name');
                    return false;
                }
                var matches = $('#AccountHolderName').val().match(/\d+/g);
                if (matches != null) {
                    $('#lblaccount').text('account holder name should be alphabet only!');
                    return false;
                }
                var matches1 = $('#AccountHolderName').val().match(/[^a-zA-Z0-9 ]/);
                if (matches1 != null) {
                    $('#lblaccount').text('account holder name should Not Contain any special sharacter!');
                    return false;
                }
            }
        }


        $(document).ready(function () {
            debugger;


            $('#Chkcode').show();
            $('#Chkfields').hide();
            $('#mobilefield').hide();
            $('#Otherfield').hide();
            $('#form_2nd').hide();

            var id = $('#HdnID').val();

            if (id == "1") {

                $('#Chkcode').show();
                $('#Chkfields').hide();
                $('#mobilefield').hide();
                $('#Otherfield').hide();
            }
            //else if (id == "form_2nd") {
            //    $('#form_1st').hide();
            //    $('#form_2nd').show();
            //}

            else if (id == "Canada_Herbels") {
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

            var city_err = true;
            Upi_err = true;
            bank_err = true;
            account_err = true;
            ifsc_err = true;


            $("#example13-digit-number").mask("99999-99999999");
            $("#btnnxt").on('click', function (e) {
                e.preventDefault();


                var codeone = $('#example13-digit-number').val();
                code1 = codeone.split('-')[0];
                code2 = codeone.split('-')[1];

                if (codeone == "" || codeone == undefined) {
                    $('#Code1check').html('**Please Enter 13 Digit-Code');
                    $('#Code1check').css("color", "red");
                    return false;
                }
                else {
                    $('#nextcheck').text('');
                }

                if (codeone != undefined) {
                    if ($('#example13-digit-number').val().length < 14) {
                        $('#Code1check').text('**Please Enter 13 Digit Code');
                        $('#Code1check').css("color", "red");
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

                                    if (data.split('&')[1] == "HERBAL AYURVEDA AND RESEARCH CENTER" || data.split('&')[1] == "" || data.split('&')[1] == undefined) {
                                        $('#Chkcode').hide();
                                        $('#Chkfields').show();
                                        $('#Otherfield').hide();
                                        $('#mobilefield').show();

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
            });



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



            var selectedVal = "";
            var selected = $("#divradio input[type='radio']:checked");
            if (selected.length > 0) {
                selectedVal = selected.val();

            }


            $("#divradio input[type='radio']").change(function () {
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


                // alert(this.value);
                if (this.value == 'UPI') {
                    $('#payment').show();
                    $('#divupi').show();
                    $('#divbank').hide();
                    $('#otherfieldall').hide();

                }
                else if (this.value == 'account') {
                    $('#payment').show();
                    $('#divupi').hide();
                    $('#divbank').show();
                    $('#otherfieldall').hide();
                }
            });


            $('#IfscCode').keyup(function () {
                debugger;
                ValidateIfccode(this.value);

            });







            $('#upi').keyup(function () {
                Upi_check();

            });

            function Upi_check() {

                var city_val = $('#upi').val();
                if ($('#upi').val().match('^[0-9A-Za-z.-]{2,256}@[A-Za-z]{2,64}$')) {
                    $('#upicheck').hide();
                }

                else {
                    $('#upicheck').show();
                    $('#upicheck').html("**Please enter valid UPI ID");
                    $('#upicheck').css("color", "red");
                    Upi_err = false;
                    return false;
                }
            }


            $('#btnsubmit').on('click', function (e) {
                e.preventDefault();

                debugger;


                var mobileone = $('#mobile').val();
                if ((mobileone == "") || (mobileone == undefined)) {


                    $('#mobilecheck').html('**Please Enter Mobile Number');
                    $('#mobilecheck').css("color", "red");
                    return false;
                }

                if (mobileone.length != 10) {
                    $('#mobilecheck').html('**Please Enter 10-Digits Mobile Number');
                    $('#mobilecheck').css("color", "red");
                    return false;
                }


                name_err = true;
                city_err = true;


                Name_check();
                city_check();

                if ((name_err != true) || (city_err != true)) {
                    return false;
                }






                $('#btnsubmit').hide();
                $('#btnloadsubmit').show();


                debugger;

                var code = $('#example13-digit-number').val();

                if (code != "") {

                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: '../Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#example13-digit-number').val() + '&name=' + $('#name').val() + '&city=' + $('#city').val() + '&comp=HERBAL AYURVEDA AND RESEARCH CENTER&Comp_ID=Comp-1593',
                        //url: '../Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#example13-digit-number').val() + '&name=' + $('#name').val() + '&city=' + $('#city').val() + '&UPI=' + $("#upi").val() + '&comp=Canada Herbels&Comp_ID=Comp-1318',
                        success: function (data) {





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
                                $('#wlink').html(data.split('~')[1]);
                                $('#wlink:contains("not")').css('color', 'black');

                                if ($('#wlink').html().includes('invalid') || $('#wlink').html().includes('already')) {
                                    //  alert('1');
                                    $('#payment').hide();
                                    $('#divupi').hide();
                                    $('#divselectpay').hide();
                                }

                                else {
                                    // alert('2');
                                    if ($("#upi").val() == "" && $("#AccountNumber").val() == "") {
                                        // $('#payment').show();
                                        // $('#divupi').show();
                                        $('#divselectpay').show();
                                    }
                                }





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


            $('#btnbank').on('click', function (e) {
                e.preventDefault();
                $('#payment').show();
                $('#divupi').hide();
                $('#divbank').show()
            });

            $('#btnupi').on('click', function (e) {
                e.preventDefault();
                $('#payment').show();
                $('#divupi').show();
                $('#divbank').hide()
            });






            $('#btnsubmit2').on('click', function (e) {
                e.preventDefault();

                debugger;


                if ($('#upi').val() == "" && $('#AccountHolderName').val() == "") {
                    $('#upicheck').html('Please Enter Your UPI Id');
                    $('#lblaccount').text('Please Enter valid account number');
                    return false;
                }
                else {
                    $('#upicheck').html('');
                    $('#lblaccount').text('');
                }
                if ($('#upi').val() != "" && $('#AccountHolderName').val() == "") {
                    Upi_check();
                }
                if ($('#upi').val() == "" && $('#AccountHolderName').val() != "") {
                     ValidateAccount();
                    ACNamevalid();

                    if ($('#AccountHolderName').val() == "") {
                        ACNamevalid();
                        // $('#btnsubmit').attr('disabled', false);
                        return false;
                    }

                    if ($('#AccountNumber').val() == "") {

                        $('#lblaccount').text('Please Enter valid account number');
                        return false;
                    }

                    if ($('#ConfirmAccountNumber').val() == "") {

                        $('#lblaccount').text('Confirm account number should be same as per account number');
                        return false;
                    }

                    var x = $('#AccountNumber').val();
                    var y = $('#ConfirmAccountNumber').val();
                    if (x == y) {

                    }
                    else {
                        $('#lblaccount').text("Confirm account number should be same as per account number");;

                        // $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    if ($('#AccountNumber').val().length < 9) {
                        $('#lblaccount').text('Please Enter valid account number');
                        return false;
                    }

                    if ($('#ConfirmAccountNumber').val().length < 9) {
                        $('#lblaccount').text('Please Enter valid confirm account number');
                        return false;
                    }


                    //alert('ok');



                    var IfscCode = $('#IfscCode').val();
                    if (IfscCode.length != 11) {
                        $('#lblaccount').text("Please enter 11 digit of Ifsc code .");
                        // $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    // alert('ok1');
                    if (IfscCode.length == 11) {
                        $.ajax({
                            type: "Post",
                            url: '../Info/MasterHandler.ashx?method=CheckIfcCode&IfcCode=' + IfscCode,
                            success: function (data) {
                               //  alert(data);
                                if (data == "0") {
                                    // alert("Invalid ifc code");
                                    $('#lblaccount').text("Invalid IFSC Code!");
                                  //  alert('1');
                                    return false;
                                   
                                } else {
                                    $('#lblaccount').text("");
                                    return true;
                                  //  alert('2');
                                }
                            }
                        });

                    }
                }


                if ($('#upi').val() == "" && $('#AccountHolderName').val() != "") {
                    var IfscCode = $('#IfscCode').val();
                    if (IfscCode.length != 11) {
                        $('#lblaccount').text("Please enter 11 digit of Ifsc code .");
                        // $('#btnsubmit').attr('disabled', false);
                        return false;
                    }
                    // alert('ok1');
                    if (IfscCode.length == 11) {
                        $.ajax({
                            type: "Post",
                            url: '../Info/MasterHandler.ashx?method=CheckIfcCode&IfcCode=' + IfscCode,
                            success: function (data) {
                               // alert(data);
                                if (data == "0") {
                                    // alert("Invalid ifc code");
                                    $('#lblaccount').text("Invalid IFSC Code!");
                                  //  alert('1');
                                    return false;

                                } else {
                                    $('#lblaccount').text("");
                                    return true;
                                     //      alert('2');
                                }
                            }
                        });

                    }
                }



                $('#btnsubmit2').hide();
                $('#btnloadsubmit2').show();


                debugger;

                var code = $('#example13-digit-number').val();

                if (code != "") {

                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        //url: '../Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#example13-digit-number').val() + '&name=' + $('#name').val() + '&city=' + $('#city').val() + '&comp=Canada Herbels&Comp_ID=Comp-1318',
                        url: '../Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#example13-digit-number').val() + '&name=' + $('#name').val() + '&city=' + $('#city').val() + '&UPI=' + $("#upi").val() + '&AccountNumber=' + $('#AccountNumber').val() + '&IfscCode=' + $('#IfscCode').val() + '&AccountHolderName=' + $('#AccountHolderName').val() + '&comp=HERBAL AYURVEDA AND RESEARCH CENTER&Comp_ID=Comp-1593',
                        success: function (data) {
                           // alert(data);




                            $('#btnsubmit2').show();
                            $('#btnloadsubmit2').hide();
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
                                $('#payment').hide();
                                $('#divupi').hide();
                                $('#divbank').hide()

                                $('#wlink').html(data.split('~')[1]);

                                $('#wlink:contains("not")').css('color', 'black');
                                $('#divselectpay').hide();



                            }

                            else if (data.split('~')[0] === "Failure") {
                               /* $('#msgcoats').hide();*/
                                $('#upicheck').show();
                                $('#upicheck').html(data.split('~')[1]);
                                $('#btnskyVerify1').attr('disabled', false);
                            }
                            else {
                               /* $('#msgcoats').hide();*/
                                $('#upicheck').show();
                                toastr.error(data.split('~')[1]);
                               // alert(data);
                                $('#btnskyVerify1').attr('disabled', false);
                            }
                        }
                    });
                }



                else {

                    $('#btnsubmit2').attr('disabled', false);
                }



            });




            $('#btnNext').click(function () {
                window.location.href = 'https://www.vcqru.com/Canadaherbals.aspx';
            });

            $('#btnlogin').click(function () {
                window.location.href = 'https://www.vcqru.com/login.aspx';
            });

        });

        function ValidateIfccode(ifscCode) {
            debugger;
            //alert(ifscCode);
            $('#btnsubmit2').attr('disabled', true);
            var ann = '../Info/MasterHandler.ashx?method=CheckIfcCode&IfcCode=' + ifscCode;
           
            $.ajax({
                type: "Post",
                url: '../Info/MasterHandler.ashx?method=CheckIfcCode&IfcCode=' + ifscCode,
                success: function (data) {
                   // alert(data);
                    if (data == "0") {
                        // alert("Invalid ifc code");
                        $('#lblaccount').text("Invalid IFSC Code!");
                        return false
                    } else {
                        $('#lblaccount').text("");
                        $('#btnsubmit2').attr('disabled', false);
                        return true;

                    }
                }
            });
        }


    </script>

</head>
<body>
    <section class="CanadaHerbals">
        <img src="../assets/images/Canada-img/bg1.png" alt="bg-img" class="bg1" />
        <img src="../assets/images/Canada-img/bg2.png" alt="bg-img" class="bg2" />
        <header class="Canada-header">
            <div class="container">
                <img src="../assets/images/Canada-img/canada_logo.png" alt="canada_logo-img" class="canada_logo" />
            </div>
        </header>
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <div class="form-box">
                        <form runat="server" id="frm">
                            <asp:HiddenField ID="hdnmob" runat="server" />
                            <asp:HiddenField ID="HdnID" runat="server" />
                            <asp:HiddenField ID="HdnCode1" runat="server" />
                            <asp:HiddenField ID="HdnCode2" runat="server" />
                            <asp:HiddenField ID="CompName" runat="server" />
                            <asp:HiddenField ID="long" runat="server" />
                            <asp:HiddenField ID="lat" runat="server" />
                            <h4 class="form-title">TO CHECK AUTHENTICITY AND AVAIL BENEFITS</h4>
                            <div class="form-field">
                                <div id="form_1st">
                                    <!-- this div is for code-generation 13 digit number -->
                                    <div id="Chkcode">
                                        <div class="col-12">
                                            <input type="text" maxlength="13" id="example13-digit-number" placeholder="Enter 13 Digit Code*" class="form-control" />
                                            <h6 id="Code1check"></h6>

                                        </div>
                                        <h6 id="codecheck"></h6>
                                        <button type="submit" id="btnnxt" class="form-control canada_btn">Next</button>
                                        <button type="submit" style="display: none" id="btnloadnxt" class="form-control canada_btn"><i class="fa fa-spinner fa-spin"></i>Loading..</button>
                                        <h6 id="nextcheck"></h6>
                                    </div>
                                    <div id="Chkfields">
                                        <div id="mobilefield">
                                            <div class="col-12">
                                                <input type="text" maxlength="10" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" id="mobile" placeholder="Mobile Number*" class="form-control" />
                                                <h6 id="mobilecheck"></h6>
                                            </div>
                                        </div>

                                        <div id="Otherfield">
                                            <div id="otherfieldall">
                                                <div class="col-12">
                                                    <input type="text"  maxlength="30" id="name"  placeholder="Name" class="form-control" />
                                                    <h6 id="namecheck"></h6>
                                                </div>

                                                <div class="col-12">
                                                    <input type="text" maxlength="30" id="city"  placeholder="City" class="form-control" />
                                                    <h6 id="citycheck"></h6>
                                                </div>

                                            </div>

                                        </div>


                                        <div class="col-12 mt-3">
                                            <button class="form-control canada_btn" id="btnsubmit">SUBMIT</button>
                                            <button type="submit" style="display: none" id="btnloadsubmit" class="form-control canada_btn"><i class="fa fa-spinner fa-spin"></i>Loading..</button>

                                        </div>
                                    </div>


                                </div>
                                <div style="display: none;" id="ShowMessage" class="row no-gutters pl-4 pr-4 textmessage">
                                    <center>
                                        <div class="col-md-12">
                                            <br />
                                            <div class="form-group">
                                                <p id="wlink" style="overflow: hidden; font-size: 14px !important;" class="displayNone massage_box">
                                                    <a href="javascript:void(0)" class="next_btn" id="btnlogin"><b>Login Here</b></a>
                                                   
                                                </p>
                                                
                                            </div>
                                          
                                            <div class="col-lg-12" id="divselectpay" style="margin-top:31px;">
                                                <ul class="upiBank my-3">
                                                    <li id="btnupi">
                                                        <button class="canada_btn">
                                                            <img src="https://cdn-icons-png.flaticon.com/512/4108/4108042.png" />
                                                            UPI
                                                        </button>
                                                    </li>
                                                    <li id="btnbank">
                                                        <button class="canada_btn">
                                                            <img src="https://cdn-icons-png.flaticon.com/512/2830/2830284.png" />
                                                            Bank
                                                        </button>
                                                    </li>
                                                </ul>
                                            </div>
                                            <a href="javascript:void(0)" class="next_btn" id="btnNext">Close</a>

                                        </div>
                                    </center>

                                </div>
                                <div style="display: none" id="payment">

                                    <%--  <span id="lblradio" style="color: red"></span>
                                                <div class="text-center" id="divradio">
                                                    <input type="radio" id="rblupi" name="payment" value="UPI">
                                                    <label for="rblupi">UPI ID</label>
                                                    <input type="radio" id="rblbank" name="payment" value="account">
                                                    <label for="rblbank">Bank Details</label>
                                                </div>--%>

                                    <%-- this is for UPI--%>
                                    <div id="divupi" style="display: none">
                                        <div class="col-12">
                                            <input type="text" id="upi" placeholder="Enter UPI ID*" maxlength="50" class="form-control" />
                                            <%-- <span id="btnbank" class="btnclass" style="text-align: center; display: block"><a href="#">OR Bank Account</a> </span>--%>
                                            <h6 id="upicheck" style="color: red"></h6>



                                        </div>
                                    </div>
                                    <div id="divbank" style="display: none">

                                        <div class="col-12">
                                            <input type="text" class="form-control" id="AccountHolderName" placeholder="Bank Account Holder Name *" maxlength="30" autocomplete="off" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode==32">
                                            <%--<input type="text" maxlength="30" autocomplete="off" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode==32" id="AccountHolderName" placeholder="Account holder name" class="form-control" />--%>
                                            <%--<h6 id="accountcheck"></h6>--%>
                                        </div>
                                        <div class="col-12">
                                            <input type="text" placeholder="Bank Account Number*" id="AccountNumber" minlength="9" maxlength="18" data-msg-required="Please Enter Bank Account Number*" class="form-control" pattern="[0-9]+" title="only numbers" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
                                            <%-- <input type="text" maxlength="18" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" id="AccountNumber" placeholder="Enter Bank account number*" class="form-control" />--%>
                                            <%--<h6 id="bankcheck"></h6>--%>
                                        </div>
                                        <div class="col-12">

                                            <input type="text" placeholder="Confirm Bank Account Number*" minlength="9" maxlength="18" class="form-control" id="ConfirmAccountNumber" pattern="[0-9]+" title="only numbers" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                                        </div>

                                        <%-- <div class="col-12">
                                                        <input type="text" placeholder="IFSC Code*" onkeypress="return ValidateAlphaNumeric1(event);" id="IfscCode" maxlength="11" data-msg-required="Please Enter Your IFSC Code*." class="form-control" style="text-transform: uppercase" pattern="[A-Za-z0-9]+" title="letters or numbers only" autocomplete="off" />
                                                        <span id="btnupi" class="btnclass" style="text-align:center;display:block"><a href="#"> Back To UPI</a></span>
                                                    </div>
                                                    <span id="lblaccount" style="color: red"></span>--%>

                                        <div class="col-12 mb-3">
                                            <input type="text" placeholder="IFSC Code*" onkeypress="return ValidateAlphaNumeric1(event);" id="IfscCode" maxlength="11" data-msg-required="Please Enter Your IFSC Code*." class="form-control mb-1" style="text-transform: uppercase" pattern="[A-Za-z0-9]+" title="letters or numbers only" autocomplete="off">
                                            <span id="lblaccount" style="color: red" class="mb-1 d-block"></span><%--<span id="btnupi" class="btnclass" style="text-align: center; display: block"><a href="#">Back To UPI</a></span>--%>
                                        </div>



                                    </div>

                                    <button class="form-control canada_btn" id="btnsubmit2">SUBMIT</button>
                                    <button type="submit" style="display: none" id="btnloadsubmit2" class="form-control canada_btn"><i class="fa fa-spinner fa-spin"></i>Loading..</button>

                                </div>



                                <%-- <div id="form_2nd">
                                    <div class="col-12">
                                        <input type="text" id="upi" placeholder="Enter UPI ID*" class="form-control" />
                                        <h6 id="upicheck"></h6>
                                    </div>
                                    <div class="text-center">
                                        <p><b>OR</b></p>
                                    </div>
                                    <div class="col-12">
                                        <input type="text" placeholder="Enter Bank account number*" class="form-control" />
                                    </div>
                                    <div class="col-12">
                                        <input type="text" placeholder="Account holder name" class="form-control" />
                                    </div>
                                    <div class="col-12">
                                        <input type="text" placeholder="IFSC Code*" class="form-control" />
                                    </div>
                                    <div class="col-12 mt-3">
                                        <button class="form-control canada_btn" id="btnsubmit2">SUBMIT</button>
                                        <button type="submit" style="display: none" id="btnloadsubmit2" class="form-control canada_btn"><i class="fa fa-spinner fa-spin"></i>Loading..</button>
                                    </div>
                                </div>--%>

                                <%-- <div style="display: none;" id="ShowMessage">
                                     <p id="wlink" style="font-size:14px!important" class="blink_me animate__animated animate__flash">
                                   
                                </div>--%>



                                <div>
                                    <div class="col-12 mt-2 text-center">
                                        <p id="wlink1" class="blink_me animate__animated animate__flash">
                                            QR/Code  Related Support Available on
                                                <br>
                                            <i class="fa fa-phone" style="color: #0d6efd;" aria-hidden="true"></i><a href="tel:8047278314">8047278314</a> /
                                                <i class="fa fa-whatsapp" style="color: #13fb06;" aria-hidden="true"></i>
                                            <a href="https://api.whatsapp.com/send?phone=+917669017712&amp;text&amp;type=phone_number&amp;app_absent=1" target="blank">7669017721</a>
                                        </p>

                                    </div>
                                </div>
                            </div>

                        </form>
                        <%-- <div class="text-center">
                            <div class="mt-2">
                                <input type="radio" name="form1" class="form-btn1" />
                                <input type="radio" name="form1" class="form-btn2" />
                            </div>
                        </div>--%>
                    </div>
                </div>
                <div class="col-sm-8">
                    <img src="../assets/images/Canada-img/canada_product.png" alt="canada_product-img" class="canada_product" />
                </div>
            </div>
        </div>

    </section>





    <!--<script>
      $(document).ready(function(){
            $("#form_2nd").hide();
            $("#form_1st").show();
        $(".form-btn1").click(function(){
            $("#form_2nd").hide();
            $("#form_1st").show();
        });
        $(".form-btn2").click(function(){
            $("#form_1st").hide();
            $("#form_2nd").show();
        });
});

  </script>-->





    <!-- <script>

function myFunction() {
          var x = document.getElementById("form_1st");
        //   if (x.style.display === "none") {
            x.style.display = "block";
        //   } else {
        //     x.style.display = "none";
        //   }
        }


        function myFunction() {
          var x = document.getElementById("form_2nd");
        //   if (x.style.display === "none") {
            {
                x.style.display = "block";
            }
           
        //   } else {
        //     x.style.display = "none";
        //   }
        }







        
    </script> -->



</body>

</html>
