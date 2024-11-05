<%@ Page Language="C#" AutoEventWireup="true" CodeFile="swaraj.aspx.cs" Inherits="swaraj" %>

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


    <title>swaraj</title>
    <style>
        * {
            margin: 0px;
            padding: 0px;
            font-family: 'Poppins', sans-serif;
        }

        .marmo-solution {
            background-image: url(../assets/images/swaraj/swaraj-bg.png);
            background-repeat: no-repeat;
            background-position: top;
            background-size: cover;
            width: 100%;
            position: relative;
            display: table;
            height: 100vh;
            /* padding-bottom: 10px;*/
        }

            .marmo-solution .marmo-logo {
                width: 17%;
                padding: 10px 0px;
            }

        .form-box {
            background-color: #e4e7ec8a;
            display: table;
            margin: auto;
            border-radius: 25px;
            border: 5px solid #fff;
            padding-bottom: 30px;
            margin-bottom: 7%;
            position: relative;
            z-index: 1;
        }
        .slide-right {
  animation: 2s slide-right;
}

@keyframes slide-right {
   from {
    margin-left: 100%;
  }
  to {
    margin-left: 0%;
  }
}

            /* .black-box {
            display: flex;
            flex-direction: row-reverse;
        }*/

            .form-box h5 {
                text-align: center;
                width: 99.5%;
                color: #006d29;
                padding: 20px 0px 10px 0px;
                border-bottom-right-radius: 70%;
                border-bottom-left-radius: 70%;
                margin: auto;
                border-top-left-radius: 23px;
                border-top-right-radius: 23px;
                line-height: 29px;
                font-size: 18px;
                font-weight: 600;
            }

        .marmo-solution .form-box button {
            background-color: #006d29;
            color: #fff;
            margin-top: 5%;
            padding: 5px 32px;
        }

        .width-box {
            width: 90%;
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
        /*.producimg .tractor-img{
                    width: 45%;
                position: absolute;
                z-index: -0;
                animation-delay: 0.1s;
                bottom: 0px;
        }*/
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

        .producimg .tractor-img
        .icon-box .box img {
            width: 30%;
            padding: 10px 20px;
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

        .producimg .tractor-img {
            margin-top: 16%;
            animation-delay: .5s;
            animation-duration: 2s;
        }

        .footer {
            background-color: #2a934d;
            padding: 16px 0px 7px 0px;
            position: absolute;
            width: 100%;
            bottom: 0;
        }

            .footer a {
                text-decoration: none;
                color: #fff;
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

            .product_img img {
                width: 100% !important;
            }

            .select_opt {
                text-align: center;
            }

            .producimg img {
                width: 100% !important;
            }

            /* .tractor-img {
                display: none;
            }*/
            .producimg .tractor-img {
                margin-top: -17% !important;
                margin-bottom: 55px;
            }
        }


        @media screen and (width:768px) {
            .marmo-solution .product-box {
                margin: 57% 0 0 auto !important;
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

            .product_img img {
                margin-left: 5%;
            }

            .producimg .tractor-img {
                position: absolute;
                width: 55%;
                bottom: 15%;
            }

            .swaraj-product {
                margin-top: 60%;
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

            .product_img img {
                width: 100% !important;
                margin-top: 30% !important;
            }

            .select_opt {
                text-align: center;
            }

            .producimg .tractor-img {
                position: absolute;
                width: 55%;
                bottom: 15%;
            }

            .swaraj-product {
                margin-top: 60%;
            }
        }

        @media screen and (width:912px) {
            .position-box {
                bottom: 100%;
                width: 90%;
                top: 65%;
            }

            .swaraj-product {
                margin-top: 100%;
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
                margin: 8% auto;
            }

            .position-box {
                bottom: -39px;
                width: 100%;
                left: 0%;
            }

            .producimg .tractor-img {
                bottom: 100px;
                position: absolute;
                width: 48%;
            }

            .swaraj-product {
                padding-bottom: 15px;
            }
        }

        @media screen and (width:1280px) {
            .position-box {
                bottom: 28px;
            }
        }

        @media screen and (min-width:1281px) {
            .position-box {
                bottom: -37px;
                width: 90%;
                left: 6%;
            }

            .marmo-solution .product-box {
                margin: 0%;
            }

            .icon-box .box {
                padding: 29px 31px 27px 20px;
            }
        }
    </style>

    <script>

        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }

        <%--function GetProduct() {
            debugger;
            var codes = document.querySelector("#codeone").value;

            if (codes.length == 14) {
                $.ajax({
                    type: "Post",
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=Productnme&Codes= ' + $("#codeone").val(),
                    //url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=autobrowsesave&code= ' + $("#codeone").val(),

                        success: function (data) {

                            debugger;

                            var Product = data.split('~')[4];
                            // if (Product != "")
                            $("#Product").val(data);
                        }
                    });
            }
        }--%>


      


        $(document).ready(function () {




            firstfunction();


            var id = $('#HdnID').val();


            if (id == "1") {

                $('#ChkCode').show();
                $('#Chkfields').hide();
            }

            else if (id == "SWARAJ") {
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

                   
                   

                    if (validate) {
                        $('#p3msg').html('');


                        if (code != "") {
                            $.ajax({
                                type: "POST",
                                contentType: false,
                                processData: false,

                                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&comp=' + $('#CompName').val() + '&Comp_ID=Comp-1386',
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
                                       $('#p3msg').html(data.split('~')[1] + "<br/><br/>");

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
                    window.location.href = 'https://www.swarajtractors.com/';
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
            <div class="container">
                <img src="assets/images/swaraj/swaraj-logo.svg" alt="swaraj-tractors-logo" class="marmo-logo" />

            </div>
        </header>
        <section>
            <div class="container">
                <div class="row black-box">


                    <div class="col-md-5">
                        <div class="form-box mt-5 animate__animated animate__fadeInLeft">
                            <form id="form1" runat="server">

                                <asp:HiddenField ID="hdnmob" runat="server" />
                                <asp:HiddenField ID="HdnID" runat="server" />
                                <asp:HiddenField ID="HdnCode1" runat="server" />
                                <asp:HiddenField ID="HdnCode2" runat="server" />
                                <asp:HiddenField ID="CompName" runat="server" />
                                <asp:HiddenField ID="long" runat="server" />
                                <asp:HiddenField ID="lat" runat="server" />
                                <asp:HiddenField ID="codeonee" runat="server" />

                                <div class="row">
                                    <div id="fields">
                                        <div class="col-12">
                                            <h5 class="text-uppercase">to check authenticity And Avail Benefits</h5>
                                        </div>

                                        <div class="width-box">
                                            <div id="ChkCode">
                                                <div class="col-sm-12">
                                                    <input type="text" maxlength="13" id="codeone"  class="form-control input1" placeholder="Enter Unique 13 Digit Code*" />
                                                </div>
                                            </div>
                                            <div id="Chkfields">
                                            
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <input type="text" maxlength="10" id="mobilenumber" data-msg-required="Please Enter Your Moblie Number" class="form-control" placeholder="Enter Mobile Number*" />
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
                                                <div class="form-group" style="margin-left: 7%;">
                                                    <p id="p3msg" style="overflow: hidden; font-size: 14px !important;" class="displayNone massage_box"></p>
                                                </div>
                                                <a href="javascript:void(0)" class="next_btn btn btn-lg btn-primary" font-size="14px" id="btnNext">Close</a>
                                            </div>
                                        </center>

                                    </div>

                                </div>
                            </form>
                        </div>
                        <div class="col-12">
                            <img src="assets/images/swaraj/bg-1-product.png" alt="marmo-logo" class="swaraj-product animate__animated animate__fadeInLeft animate__delay-1s img-fluid" />
                        </div>

                    </div>

                    <div class="col-md-7">
                        <div class="producimg">

                            <img src="assets/images/swaraj/1img.png" alt="tractor-images" class="tractor-img slide-right tractor-img img-fluid" />

                        </div>
                    </div>



                </div>

            </div>

          


        </section>
        <footer class="footer">

            <div class="col-12">
                <div class="container">
                    <a class="" href="https://www.swarajtractors.com/">
                        <h5 class="weblink">www.swaraj.in</h5>
                    </a>
                </div>

            </div>
        </footer>

    </div>





</body>
</html>
