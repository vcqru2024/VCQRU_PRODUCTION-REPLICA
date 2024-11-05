<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChemInd.aspx.cs" Inherits="ChemInd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;700;900&display=swap" rel="stylesheet" />


    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="Content/js/jquery-1.11.1.min.js"></script>
    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>


    <title>wudchem</title>
       <style>
        *{
            margin:0px;
            padding:0px;
            font-family: 'Poppins', sans-serif;
        }
        body{
            overflow:auto;
            height:100vh;
        }
        .wudchem{
            background-image:url(assets/images/wudchem/wudchembg-img.jpg);
            background-repeat:no-repeat;
            background-position:center;
            background-size:cover;
            width:100%;
            position:relative;
            height:700px;
        }
        .wudchem .wud-logo{
            width: 150px;
            padding: 10px 0px;
        }
        .wudchem-form{
            width: 408px;
            background-color: #2a120b;
            padding: 8px;
            color: #fff;
            margin-bottom: 60px !important;
            margin: auto;
        }
        .wudchem-form form{
            border:2px solid #fff;
            padding:10px;
        }
        .wudchem-form h6{
            color: #25bcbd;
            line-height: 24px;
            font-size: 14px;
            font-weight: 500;
        }
        .wudchem-form label{
            font-size: 12px;
        }
        .wudchem-form label sup{
            color:#ff0000;
            padding: 3px;
        }
        .wudchem-form form input{
            background-color:#fff0;
            border:1px solid #fff;
            margin-bottom: 12px;
            color:#fff;
        }
        .wudchem-form form input:focus{
            background-color:#fff0;
            box-shadow: 0px 0px 0px;
            border-color: #26bcbd;
            color:#fff;
        } 
        .wudchem-form button{
            background-color: #6ad1d2;
            color: #fff;
            border-radius: 0px;
            padding: 6px 46px;
            margin-top: 16px;
            margin-bottom: 10px;
        }
        .wudchem-form button:hover{
            color:#025a5a;
        }
        .wudchem .change-box{
            display: flex;
            flex-direction: row-reverse;
            /*margin-top: 13%;*/
        }
        .wudchem .product{
            position: absolute;
            bottom: -110px;
        }
        .bottom-box{
            background-image:url(assets/images/wudchem/bg-img.jpg);
            background-repeat:no-repeat;
            background-position:center;
            background-size:cover;
            width:100%;
            height:170px;
        }
        .wud-footer{
            background-color:#341713;
        }
        .wud-footer .footer-text{
            text-align: center;
            color: #c87f3d;
            margin-top: 27px;
            vertical-align: middle;
            margin-bottom: 10px;
        }
        .wud-footer .product{
            float: right;
            margin-top: -20px;
        }
        .footer-text a{
            text-decoration:none;
            color:#c87f3d;
            z-index: 999;
        }

        @media screen and (max-width: 700px) {
            .wudchem {
                padding-bottom: 110px;
            }
			.wudchem .wud-logo {
                width: 25%;
            }
            .wudchem-form {
                width: 100%;
            }
            .wudchem .product {
                bottom: -139px;
                width: 90%;
            }
            .bottom-box {
                height: 130px;
            }
            .footer-text lable {
                font-size: 14px;
            }
            .wud-footer .product {
                padding: 4px 0px;
                width: 15%;
            }
		}
         @media screen and (width: 768px){
            .wudchem .product {
                bottom: -139px;
                width: 53%;
            }
            .wudchem-form {
                width: 100%;
            }
            .wudchem {
                height: 778px;
            }
        }

        @media screen and (min-width: 769px) and (max-width: 1024px){
            .wudchem-form {
                width: 100%;
            }
            .wudchem .product {
                bottom: -165px;
                width: 50%;
            }
        }
        @media screen and (width: 540px) {
            .wud-footer .product {
                margin-top: -30px;
            }
            .bottom-box {
                height: 176px;
            }
            .wud-footer .footer-text {
                margin-top: 40px;
            }
            .wudchem .product {
                bottom: -170px;
            }
            .wudchem {
                height: 790px;
            }
        }
         @media screen and (width: 280px){
            .footer-text lable {
                font-size: 10px;
            }
            .wud-footer .product {
                float: initial;
                margin-top: 0;
            }
            .wudchem {
                padding-bottom: 36px;
                height: 650px;

            }
            .wud-footer .product {
                padding: 10px 0px;
                width: 13%;
                bottom: -128px;
            }
            .wudchem .product {
                bottom: -130px;
            }
        }
         @media screen and (width: 412px){
            .bottom-box {
                height: 186px;
            }
            .wudchem .product {
                bottom: -170px;
                width: 90%;
            }
            .wudchem {
                padding-bottom: 50px;
            }
        }
         @media screen and (width: 1024px){
            .wudchem .product {
                bottom: -110px;
            }
            .bottom-box {
                height: 165px;
            }
        }
          @media screen and (width: 1280px){
            .wudchem .product {
                bottom: -140px;
            }
        }
          @media screen and (width: 820px){
            .bottom-box {
                height: 200px;
            }
            .wudchem .change-box {
                margin-top: 29%;
            }
            .wudchem {
                height: 906px;
            }
        }
           @media screen and (width: 912px){
            .wudchem {
                height: 82vh;
            }
        }
        
    </style>

    <script>

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

            else if (id == "WUD") {
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
                    var matches1 = $('#Name').val().match(/[^a-zA-Z0-9 ]/);
                    if (matches1 != null) {
                        toastr.error('Name Should Not Contain any Special Character!');
                        validate = false;
                    }
                }


                var Address = $('#Address').val();
                if (Address != undefined) {


                    if ($('#Address').val().length < 1) {
                        toastr.error('Please Enter Address');
                        validate = false;
                    }
                }



                if (validate) {
                    $('#p3msg').html('');


                    if (code != "") {
                        $.ajax({
                            type: "POST",
                            contentType: false,
                            processData: false,

                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&Address=' + $('#Address').val() + '&name=' + $('#Name').val() + '&comp=' + $('#CompName').val(),
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
                                    $('#p3msg').html(data.split('~')[1] + "<br/><br/>Add <br/>5 points to get ₹12 <br/>10 points to get ₹30 <br/>20 points to get ₹65 <br/> 50 points to get ₹175 <br/>100 points to get ₹400");

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


                }
                else {

                    $('#btnsubmit').attr('disabled', false);

                }

            });



            $('#btnNext').click(function () {
                window.location.href = 'https://wudchemindustries.com/';
            });


        });


        //function showPosition(position) {
        //    $('#lat').val(position.coords.latitude);
        //    $('#long').val(position.coords.longitude);
        //    //alert("long: " + $('#lat').val() + "lat: " + $('#long').val());
        //}

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

            //if ($('#' + cntrl_id).val().length == 0) {

            //    if (parseInt(evt.key) >= 6)
            //        return true;

            //}
            //else if (charCode >= 48 && charCode <= 57)
            //    return true;
            //if ($('#' + cntrl_id).val().length > 10) {

            //   return false;

            //}
            //if (charCode >= 96 && charCode <= 105) {
            //    return true;
            //}

            //if (charCode == 8)
            //    return true;
            //if (charCode == 46)
            //    return false;

            //return false;

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
    <section class="wudchem">
        <div class="container">
            <header>
                <div class="row">
                    <div class="col-sm-12">
                        <img src="assets/images/wudchem/wudchem_logo.png" class="img-fluid wud-logo" alt="wudchem-logo" />
                    </div>
                </div>
            </header>
            <div class="row change-box">
                <div class="col-sm-5">
                    <div class="wudchem-form">
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
                                    <div class="col-sm-12" id="CodeHeading">
                                        <h6 class="text-uppercase">To check authenticity and avail benefits / प्रामाणिकता की जांच करने और लाभ प्राप्त करने के लिए |</h6>
                                    </div>
                                    <div id="ChkCode">
                                        <div class="col-sm-12">
                                            <label>ENTER 13 DIGIT CODE<sup>*</sup></label>
                                            <input type="text" id="codeone" data-msg-required="Please enter your name." maxlength="13" class="form-control input1 color" />
                                        </div>
                                    </div>
                                    <div id="Chkfields">
                                        <div class="col-12">
                                            <label>NAME<sup>*</sup></label>
                                            <input type="text" class="form-control color" id="Name" placeholder="Enter Your Name*" required="" />
                                        </div>
                                        <div class="col-12">
                                            <label>NUMBER<sup>*</sup></label>
                                            <input type="text" id="mobilenumber" maxlength="10" placeholder="Enter Your Mobile Number*" data-msg-required="Enter Your Moblie Number" class="form-control color mobile_num" onkeypress="return isNumber(event,'mobilenumber')" onkeydown="return isNumber(event,'mobilenumber')" required="" />
                                        </div>
                                        <div class="col-12">
                                            <label>City<sup>*</sup></label>
                                            <input type="text" class="form-control color" id="Address" placeholder="Enter Your City*" required="" />
                                        </div>
                                        <div class="col-12 text-center">

                                            <button value="Submit" type="button" id="btnsubmit" data-toggle="modal" class="btn">Submit</button>
                                        </div>
                                    </div>
                                </div>
                                <div style="display: none;" id="ShowMessage" class="row no-gutters pl-4 pr-4 textmessage">

                                    <div class="col-md-12">
                                        <div class="form-group" style="margin-left:7%;">
                                            <p id="p3msg" style="overflow: hidden; font-size: 14px !important;" class="displayNone massage_box"></p>
                                        </div>
                                        <a href="javascript:void(0)" class="next_btn" id="btnNext">Close</a>
                                    </div>


                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-sm-7">
                    <div class="product-img">
                        <img src="assets/images/wudchem/WudchemImage.png" class="img-fluid product" alt="product-img" />
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="bottom-box">
    </section>
       <footer class="wud-footer">
        <div class="container">
            <div class="row">
                <div class="col-sm-12 footer-text">
                    <a href="https://www.wudchemindustries.com/" target="_blank">www.wudchemindustries.com</a><a href="https://www.indiamart.com/" target="_blank"><img src="assets/images/wudchem/mart-logo.png"  class="img-fluid product" alt="product-img"/></a>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>
